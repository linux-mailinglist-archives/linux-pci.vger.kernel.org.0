Return-Path: <linux-pci+bounces-41047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F1CC559CE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 05:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 574804E19EE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 04:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5532673BA;
	Thu, 13 Nov 2025 04:02:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B8E23BD02;
	Thu, 13 Nov 2025 04:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763006564; cv=none; b=aV13w7aUbYAuAv6y5/pJgQhDxYxKVDqsXfVtcN4f0kMsOHUWl9Q4zR1x5bkrigDfRZTwzpHXERz3eYpcAwVi6j4BKLrmEHM+z8qHufYwczvU+WFqgwYUOiYOygPV0p5t+r7VIa0+vNFGe6TGmmpCDTa3ucQmGxHMe5KM9M3k57I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763006564; c=relaxed/simple;
	bh=jiSh8g4p4ap2FOTDccw8d7f07J/r8WwSxRs64K5bYEA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=A/IEwVpUT6Lq4NDPTO6NwjkS3AYrH7AMlsD90+I2TplAe9lklADYSmxDAmHs9F4sa3CpKNJw591j/2GYvA7BjR2rOspnq2YYr/YamYze7slIvR9kxMmIzuX4B0Dh90LYL8jdR/t6ag4UF4dx03kWBWgXsO0Szypl1m3uxQoM4jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 8753292009C; Thu, 13 Nov 2025 05:02:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 8093392009B;
	Thu, 13 Nov 2025 04:02:39 +0000 (GMT)
Date: Thu, 13 Nov 2025 04:02:39 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org, 
    Christian Zigotzky <chzigotzky@xenosoft.de>, 
    mad skateman <madskateman@gmail.com>, "R. T. Dickinson" <rtd2@xtra.co.nz>, 
    Darren Stevens <darren@stevens-zone.net>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    Lukas Wunner <lukas@wunner.de>, luigi burdo <intermediadc@hotmail.com>, 
    Al <al@datazap.net>, Hongxing Zhu <hongxing.zhu@nxp.com>, 
    hypexed@yahoo.com.au, linuxppc-dev@lists.ozlabs.org, 
    debian-powerpc@lists.debian.org, linux-kernel@vger.kernel.org, 
    Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 2/4] PCI/ASPM: Add pcie_aspm_remove_cap() to override
 advertised link states
In-Reply-To: <20251112204658.GA2242023@bhelgaas>
Message-ID: <alpine.DEB.2.21.2511130354500.25436@angie.orcam.me.uk>
References: <20251112204658.GA2242023@bhelgaas>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 12 Nov 2025, Bjorn Helgaas wrote:

> > > +	pci_info(pdev, "ASPM:%s%s removed from Link Capabilities to avoid device defect\n",
> > > +		 lnkcap & PCI_EXP_LNKCAP_ASPM_L0S ? " L0s" : "",
> > > +		 lnkcap & PCI_EXP_LNKCAP_ASPM_L1 ? " L1" : "");
> > 
> > I think this gives a false impression that the ASPM CAPs are being
> > removed from the LnkCap register. This function is just removing it
> > from the internal cache and the LnkCap register is left unchanged.
> 
> Very true, this is confusing since we're not actually changing the
> LnkCap register, so lspci etc will still show these states as
> supported.  The quirk needs to work for arbitrary devices, and there's
> no generic way to change LnkCap, so the quirk can't do that.

 There's no way to poke at hw, but that is only relevant for x86 I believe 
and not the default access method for `lspci' anyway.  For sysfs we do it 
already for things such as fixing the device class; cf. `quirk_isa_bridge'
(arch/alpha/kernel/pci.c), so why is it a problem here?  Unless we want to 
keep it for `lspci' actually.

  Maciej

