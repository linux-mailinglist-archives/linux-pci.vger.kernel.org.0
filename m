Return-Path: <linux-pci+bounces-2530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD4C83B304
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 21:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB5BFB23C7B
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 20:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2954E132C30;
	Wed, 24 Jan 2024 20:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3iASBSG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064CE131E33
	for <linux-pci@vger.kernel.org>; Wed, 24 Jan 2024 20:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706128192; cv=none; b=QGceiuM+K49Gw3xda6nuhH+E2CgcII7siFfeviOPchfvXeV9Yff9ZFZ53SOguqjSiMd7PgcEWeVH9CXkXV4RMd7P7wtfsbTwuEPjFyca7F4yGwxEhfV0gKeadvmam5tt3PFCSE/O0D7Tv0AE2OgrWaJ+f0bbzuSt/nVoU7HjKaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706128192; c=relaxed/simple;
	bh=FXYRRSk0uLvnCZYQKMX91IVXbm6WYEd4jBMhgoffjck=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HtBViWbdwHnWa6cCUhC9bYFxA4HTVC7nYbEAP46Mqke5HyD9v/jwGURGIQG7R/kndCnuJzrazIb0bWWrZPmSJdC5NWMSAjZuhePYJ7YDndY28DgzFvBrwkwyrvT8BZHZLBwBBwMivGf/HpYwh9ZsDQXC4258ehkeJX/nWZL8QsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3iASBSG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A3DC433F1;
	Wed, 24 Jan 2024 20:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706128191;
	bh=FXYRRSk0uLvnCZYQKMX91IVXbm6WYEd4jBMhgoffjck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=c3iASBSGX6Aghzhxh8xYViHcxVVNFvMPDilZVjvuZ2oceBOTYjdHcuwmSTWOEzNUH
	 x24vtoUErnmBWZXXuajuzMrTvYRO1NCljqYOWpQw34wWzBh1l4jx6MZmqYgtkCCbND
	 DvBKSCa2OXIf5nIbiSXI+t7ydSO+sgHLCMYki+IuYP6MPGmxVTqPBcmI2+9G73rKTh
	 C5sSBpVDpQoKiVWrZSihaqBHmE3AhImiK3xz/8cuikDhnrFGqb4u1+9Q6+LY1P2001
	 xL0JtrP1441KLa3FB7pGZvqSCwqiO7EYWaOO+2QwgRUMYkDli6uV8qHvaUlVUOhzgz
	 9pKdKQdRda0tQ==
Date: Wed, 24 Jan 2024 14:29:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Matthew W Carlis <mattc@purestorage.com>
Cc: bhelgaas@google.com, kbusch@kernel.org, linux-pci@vger.kernel.org,
	lukas@wunner.de, mika.westerberg@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH 1/1] PCI/portdrv: Allow DPC if the OS controls AER
 natively.
Message-ID: <20240124202949.GA358535@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123231834.11340-1-mattc@purestorage.com>

On Tue, Jan 23, 2024 at 04:18:34PM -0700, Matthew W Carlis wrote:
> Hello again! I'm glad that I'm not the only person with a little
> confusion about the FW ECN regarding DPC/EDR. I would argue that DPC
> wasn't tied to EDR & shouldn't have been because DPC was added in
> PCI Base Spec Rev 3.1 in 2014, but there wasn't an EDR ECN till
> ~2020. Anyway, that's the way it goes..

It does involve several different specs (PCIe Base for the DPC
hardware feature, ACPI for the OS/firmware EDR interface, PCI Firmware
for the EDR support and DPC ownership negotiation), so maybe that
helps explain the muddle.

> I don't want to burden the kernel with making some impossible boot
> time decision here. Perhaps most of the machines in the world using
> DPC will soon use EDR/SFI etc. My use cases are a bit out of the
> ordinary & the ACPI specifications don't seem to have given us a
> mechanism for the kernel to conclude it can use DPC without EDR
> support...

I don't know anything about SFI and I don't see any required
connection between DPC/EDR/SFI in the PCI Firmware spec.

The PCI Firmware spec requires ACPI OSes to support EDR if they want
to use DPC.  But I don't know that the firmware is required to
actually implement the EDR functionality.

Non-ACPI OSes are presumed to own DPC and all other PCIe hardware
features, and I don't think EDR would be in the picture since it's an
ACPI thing.

> Shall I submit a patch removing CONFIG_PCIE_EDR? Perhaps the
> exercise would inform me about whether its code should be in
> CONFIG_PCIE_DPC or CONFIG_ACPI.

That would be great!  I would say CONFIG_PCIE_EDR should go away and
edr.c should only be compiled if CONFIG_PCIE_DPC=y and CONFIG_ACPI=y.

Bjorn

