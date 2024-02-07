Return-Path: <linux-pci+bounces-3218-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B5684D1DA
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 19:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50201C20D26
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 18:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C0884FAF;
	Wed,  7 Feb 2024 18:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwfZp65n"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2941E506
	for <linux-pci@vger.kernel.org>; Wed,  7 Feb 2024 18:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707332152; cv=none; b=VS90dwu9XQQ7MMoHTQNjg52teBKU8J+oMe0P2bj9SKLS9uLiy03aB3rnMYuQ7J57r85ofpihzQ2RFL2z7hQ95RdqZTzx70bTL1ZH6WyCQm2iql8UgfNSw4A1cdUddkPOVFK022RYGOPr9b4Ren++iX7qclr4ufMoOkhve2Vu4sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707332152; c=relaxed/simple;
	bh=+ny9U/MprK9HUht7EqD3pvuq0hpKdIilxYnokCDxKjc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VIesaxkul81Um+hGg2PGLGh7G02SlFoCwbphqpMWuuuprX5y2dPvZSbxhFcYJAqeP7jKqm62WQy3Ca9ZGnJNe9QLVkV0u4SPupAvQAzY2LPI+1B6Srw2W7hW91VTkBBjXsaoMjWStbcZ3vMRzGvTtnbJbJsQ6uohpSKUetIYv58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwfZp65n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C670C433F1;
	Wed,  7 Feb 2024 18:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707332151;
	bh=+ny9U/MprK9HUht7EqD3pvuq0hpKdIilxYnokCDxKjc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rwfZp65nUXTiISyDNuhpcr4/ELe5MwPy7m66vK2H57Z5LqWJci1nqsBR2Qu5lwDDg
	 M1CTvqXQGoRL6Yzq4xfSMf9ZXgC0x/0vGlI+TTrEReXnZQ1u4kYmJsClFEzdBkC5G5
	 chICkTnpU30MK3Ss591wiTXxhXiQ5ALROAKqXd9WGmin/PRrhWmb2DtuLGE9Wxi3d7
	 yV0Nzx5kc1y2vETjYZoEuKHJgURxGAFxjbVgGM7mmGQP2TwnMB9AygiSuBufQplS6/
	 nKGqit8J/qs/7eJxjXPoMjc+uvJ+HOlmfNMFXXabKNasjiL1Y7EFPpuzQdmQ5Q3VAm
	 1QeJJH7zEQArQ==
Date: Wed, 7 Feb 2024 12:55:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on VMD
 rootports
Message-ID: <20240207185549.GA910460@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a296e02527c6465edcb051d2393e2e6e612a1b0d.camel@linux.intel.com>

On Tue, Feb 06, 2024 at 05:27:29PM -0700, Nirmal Patel wrote:
> ...
> Did you have a chance to look at my response on January 16th to your
> questions? I tried to summarize all of the potential problems and
> issues with different fixes. Please let me know if it is easier if I
> resend the explanation. Thanks.

I did see your Jan 16 response, thanks.

I had more questions after reading it, but they're more about
understanding the topology seen by the host and the guest:
  Jan 16: https://lore.kernel.org/r/20240117004933.GA108810@bhelgaas
  Feb  1: https://lore.kernel.org/r/20240201211620.GA650432@bhelgaas

As I mentioned in my second Feb 1 response
(https://lore.kernel.org/r/20240201222245.GA650725@bhelgaas), the
usual plan envisioned by the PCI Firmware spec is that an OS can use a
PCIe feature if the platform has granted the OS ownership via _OSC and
a device advertises the feature via a Capability in config space.

My main concern with the v2 patch
(https://lore.kernel.org/r/20231127211729.42668-1-nirmal.patel@linux.intel.com)
is that it overrides _OSC for native_pcie_hotplug, but not for any of
the other features (AER, PME, LTR, DPC, etc.)

I think it's hard to read the specs and conclude that PCIe hotplug is
a special case, and I think we're likely to have similar issues with
other features in the future.

But if you think this is the best solution, I'm OK with merging it.

Bjorn

