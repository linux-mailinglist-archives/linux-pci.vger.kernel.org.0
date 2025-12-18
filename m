Return-Path: <linux-pci+bounces-43335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA1BCCD982
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 21:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 913E0309B34F
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 20:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A3134CFD6;
	Thu, 18 Dec 2025 20:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gk8MpisC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9644E34CFAB;
	Thu, 18 Dec 2025 20:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090616; cv=none; b=fTjDUqk2LbMgFggcn96OkJqtGCK+Coa/fXAm35/jIMwWqWO2udS+9NJdfhcMmY6Y/oIpEwbsc3fKxAdVP398IzvsZuMZEs+2OfOlwfx+AZ5jsEFMadFlQrsqeNNB0bEp+gmGUYMb/fOHxmhPCV/LdvW9PH/ndcHsv5Xp0M0uGDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090616; c=relaxed/simple;
	bh=fCy/Wex3WYIT9VqJQWpmMAZe/B9Xqn+9Ch8KYPH3iWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r25IlXno/UNsAJRVskrXL0xdwwl2Rc1ItMBD06s+lEWKy2DwsSMP6RWqv06rq2YCG4k0vDtD8Vkwbt/PuQQFjoVxd3zyMBxlJH0CI7SUuZrbxw+j0qij/Nudb74I2Qhbyx4L8esfaMjqtmyP4p5UgP7/83iv6StrG/inTqMUbDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gk8MpisC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E117C116D0;
	Thu, 18 Dec 2025 20:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766090615;
	bh=fCy/Wex3WYIT9VqJQWpmMAZe/B9Xqn+9Ch8KYPH3iWc=;
	h=From:To:Cc:Subject:Date:From;
	b=gk8MpisCrLbpa/Mn5S7d0uTTTxTLstfeeflYPUj3lYumtazib6okEgNq6niC0k/+8
	 rejTLi+Haqk52XbVZHpO+/XPgTIrMUywbLl25ZZM1//v9qwduPcPcTz5VlvNDyXYiL
	 2cTPD9L9RrzBKALOYbwIcGDRKk7E4SDU3YM5axk2c6f+Slc5iUjwpOO7jP0X07CiBM
	 568O71GdcDaNvvjY/5liZ51bMZNJn5yJDJ27DEerYI1cW0OFh4OPzZ4dpo5v1lYWza
	 OKoS0zp6l3bNt54LbyouLWC7drrvazR81F7t5I3UcbLFA8KVK2Ur2Aco9mQUpIVTva
	 1dgEJmJ9ba0iQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v1 0/8] ACPI: bus: Rework of the \_SB._OSC handling
Date: Thu, 18 Dec 2025 21:29:03 +0100
Message-ID: <5049211.GXAFRqVoOG@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

While this is a replacement for

https://lore.kernel.org/linux-acpi/12803663.O9o76ZdvQC@rafael.j.wysocki/

it goes much farther than the simple workaround, so I've decided to start
over version numbering from 1.

The motivation is (again) to make the _OSC evaluation more robust against
platform firmware deficiencies related to setting error bits in _OSC
return buffers by mistake (which apparently don't affect alternative OSes),
but the approach is more in-depth now.

The first 5 patches are preliminary.  The first one fixes the current
inconsistent handling of _OSC error bits.  The second one reworks the
printing of debug messages from acpi_run_osc() for clarity.  Patch
[3/8] splits the _OSC evaluation code out of acpi_run_osc() (so it
can be used in other functions), and patch [4/8] splits the handling
of _OSC error bits out of it (for the same purpose).  Patch [5/8] is
just a by-the-way simple cleanup.

Patch [6/8] introduces a new function for handling _OSC handshakes in
a way that should be less susceptible to failing in certain cases due
to platform firmware mistakes that should not be fatal and makes the
\_SB._OSC platform features handling code use it.

Patch [7/8] is a cleanup on top of the previous one, and patch [8/8]
updates the USB4 \_SB._OSC features handling to use the new function
introduced in patch [8/8].

Thanks!




