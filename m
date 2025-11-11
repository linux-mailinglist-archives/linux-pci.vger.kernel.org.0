Return-Path: <linux-pci+bounces-40855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41086C4CB65
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 10:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47DD94EE330
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 09:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62354264627;
	Tue, 11 Nov 2025 09:33:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D62D272E56;
	Tue, 11 Nov 2025 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853629; cv=none; b=g1XhemQkSit3jb1kssLlc9MEfiZq31hlfUViyb1l/yRHEl4FY5sZTDABCjK+5Hry61IXoApKLjKVTcYkp2L0NXsgjy6GOtXxLtSbOaZaQXcuLtv0i++pZsc6OtNZqqiIvJ0S/za0HSYdw8AfudZJEY7EOs+ZJJbzn+CnCSGu7hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853629; c=relaxed/simple;
	bh=1vZEB9mLt1tvSK3kr7NMusiIvmJhsL4784GfMZVvzk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mO5H3BpXVDCczfRpda6f9exD4PtVgt9dv/rqIN2XKl/5yHUHFAxsC4eUnOFed1OGO39oiLVhIlGvUghFo0Qp1lzctrRBXefuJzpr5UTQsMThKZd+M2/SjZjURmfoAQKqdlFcaGDsCWccV/FPJCeE5SropZ02u5uDSyNr/Ak4k0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id F0F48200B1DF;
	Tue, 11 Nov 2025 10:33:43 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E0F1C23FB; Tue, 11 Nov 2025 10:33:43 +0100 (CET)
Date: Tue, 11 Nov 2025 10:33:43 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Christian Zigotzky <chzigotzky@xenosoft.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	mad skateman <madskateman@gmail.com>,
	"R . T . Dickinson" <rtd2@xtra.co.nz>,
	Darren Stevens <darren@stevens-zone.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	luigi burdo <intermediadc@hotmail.com>, Al <al@datazap.net>,
	Roland <rol7and@gmx.com>, Hongxing Zhu <hongxing.zhu@nxp.com>,
	hypexed@yahoo.com.au, linuxppc-dev@lists.ozlabs.org,
	debian-powerpc@lists.debian.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/4] PCI/ASPM: Allow quirks to avoid L0s and L1
Message-ID: <aRMC9z93mI5BKbW0@wunner.de>
References: <20251110222929.2140564-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110222929.2140564-1-helgaas@kernel.org>

On Mon, Nov 10, 2025 at 04:22:24PM -0600, Bjorn Helgaas wrote:
> We enabled ASPM too aggressively in v6.18-rc1.  f3ac2ff14834 ("PCI/ASPM:
> Enable all ClockPM and ASPM states for devicetree platforms") enabled ASPM
> L0s, L1, and (if advertised) L1 PM Substates.
> 
> df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms")
> (v6.18-rc3) backed off and omitted Clock PM and L1 Substates because we
> don't have good infrastructure to discover CLKREQ# support, and L1
> Substates may require device-specific configuration.
> 
> L0s and L1 are generically discoverable and should not require
> device-specific support, but some devices advertise them even though they
> don't work correctly.  This series is a way to add quirks avoid L0s and L1
> in this case.

Reviewed-by: Lukas Wunner <lukas@wunner.de>

I note that a number of drivers call pci_disable_link_state() or
pci_disable_link_state_locked() to disable ASPM on probe.
Can we convert (all of) these to quirks which use the new helper
introduced here?

I think that would be useful because it would disable ASPM even if
the driver isn't available and thus avoid e.g. AER messages caused
by ASPM issues.

pcie_aspm_init_link_state() also contains the following code comment:

	/*
	 * At this stage drivers haven't had an opportunity to change the
	 * link policy setting. Enabling ASPM on broken hardware can cripple
	 * it even before the driver has had a chance to disable ASPM, so
	 * default to a safe level right now. If we're enabling ASPM beyond
	 * the BIOS's expectation, we'll do so once pci_enable_device() is
	 * called.
	 */

If we'd mask out incorrect or non-working L0s/L1 capabilities for all
devices early during enumeration via quirks, we wouldn't have to go
through these contortions of setting up deeper ASPM states only at
device enable time.

Thanks,

Lukas

