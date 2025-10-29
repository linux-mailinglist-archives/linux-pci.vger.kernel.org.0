Return-Path: <linux-pci+bounces-39669-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB7BC1C2FA
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02720585EF2
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 15:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A493347BD1;
	Wed, 29 Oct 2025 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goUpW2lp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AB2347BC0;
	Wed, 29 Oct 2025 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753556; cv=none; b=d7dKNIZDGQ8+JW0mFfG4OU229Vmill+4IRNGEzcl9rNnuULS8cWC7nYVvx4Ke+wk7rPb15BZDYwSWmFea/zl7yhgPjzkrS1D0ZBVyw7B+4mtps9+xpNL1IPxO9NjjMT3QVj6wr+pFgmEmSdls5bMKFZpvzSH4aCIgpAm/LRX4Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753556; c=relaxed/simple;
	bh=BgmmyeX0qvCVjapAnPnDG8LNCQFeWgDwHiQBafyqKGg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Xw9GxeSrKvdYDThW/OlGOWFNxA61tLvh1XHy4X53PLISI+QKJ2v0yf1ISU97mXlRwIYhgDT4SeciqG+d+Y2/JULmMjBF7oz8jWdwA0PrBon5f7eoBQM1ADOnZVoy7xZx4pxlUlogehUqKabKJypjedxBqBmKvJ3Uu6wEA7/Mtaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goUpW2lp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4DBC4CEF8;
	Wed, 29 Oct 2025 15:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761753555;
	bh=BgmmyeX0qvCVjapAnPnDG8LNCQFeWgDwHiQBafyqKGg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=goUpW2lplrswAiJGRTPiqFN91fyucf0gHLsVwamQ0ELnE4mqXBXzIlJgT29sWRzlq
	 efPIs8A8+Il3KnlWxUGe/vbTM0ftb1HLNXXXPKhqAethTLOVjsXcdSz7RfSDajG7Pg
	 rK9aBW9LY6DfI6ikoEZAcJL3vZjoB+tFfzX6rMAyc1v7MbsgHoQ6FyFujhfcL3mZ0q
	 upG+SaliKlySMKLjUsCIzlaJP5JtBSvXyzAp7WVUfI6a0Ubl+uOQE0itPBlbrOBsux
	 rfuIcHHpttl3oMcYKplNe9VLuY9ImAaS4V31kSwURTUYwPMqcjv8BOhvD5xjHbe6c1
	 Rrvya6CLl+uNg==
Date: Wed, 29 Oct 2025 10:59:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Johan Hovold <johan@kernel.org>, linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Naoki FUKAUMI <naoki@radxa.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Diederik de Haas <diederik@cknow-tech.com>,
	Dragan Simic <dsimic@manjaro.org>, linuxppc-dev@lists.ozlabs.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Lin <shawn.lin@rock-chips.com>, Frank Li <Frank.li@nxp.com>,
	"R.T.Dickinson" <rtd2@xtra.co.nz>,
	mad skateman <madskateman@gmail.com>, hypexed@yahoo.com.au,
	Christian Zigotzky <info@xenosoft.de>
Subject: Re: [PATCH] PCI/ASPM: Enable only L0s and L1 for devicetree platforms
Message-ID: <20251029155913.GA1563823@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D6280EFB-08D7-41EC-BAC6-FD7793A98A16@xenosoft.de>

On Wed, Oct 29, 2025 at 06:47:19AM +0100, Christian Zigotzky wrote:
> > On 29 October 2025 at 00:33 am, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > ﻿On Mon, Oct 27, 2025 at 06:12:24PM +0100, Christian Zigotzky wrote:
> >> Hi All,
> >> 
> >> I activated CONFIG_PCIEASPM and CONFIG_PCIEASPM_DEFAULT again for the RC3 of
> >> kernel 6.18. Unfortunately my AMD Radeon HD6870 doesn't work with the latest
> >> patches.
> >> 
> >> But that doesn't matter because we disable the above kernel options by
> >> default. We don't need power management for PCI Express because of boot
> >> issues and performance issues.
>  
> > If you have a chance, could you try the patch below on top of
> > v6.18-rc3 with CONFIG_PCIEASPM=y?
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 214ed060ca1b..2b6d4e0958aa 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
> >  * disable both L0s and L1 for now to be safe.
> >  */
> > DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, 0x0451, quirk_disable_aspm_l0s_l1);
> > 
> > /*
> >  * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
> 
> Thanks for the patch. 
> 
> I will test it on my FSL Cyrus+ board over the weekend.
> BTW, I also tested my PASemi Nemo board with the RC3 of kernel 6.18
> and with power management for PCI Express enabled. Unfortunately,
> the installed AMD Radeon HD5870 does not work with power management
> for PCI Express enabled either.

Can you share the output of "sudo lspci -vv" and the dmesg log for
this Nemo board that doesn't work with v6.18-rc3?  I would still guess
that Nemo root port has an issue rather than the HD5870.

Hypexed reported that "pasemi,nemo PA6T 0x900102 A-EON Amigaone X1000"
worked fine on 0739473694c4, which was just before v6.18-rc1.  That
system has:

  pci 0000:00:10.0: [1959:a002] type 01 class 0x060400 PCIe Root Port
  pci 0000:00:10.0: PCI bridge to [bus 01]
  pci 0000:01:00.0: [1002:6610] type 00 class 0x030000 PCIe Legacy Endpoint
  pci 0000:01:00.0: ASPM: DT platform, enabling L0s-up L0s-dw L1 ASPM-L1.1 ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2

which is a [1959:a002] PA Semi PWRficient PCI-Express Root Port
leading to [1002:6610] AMD Oland XT [Radeon HD 8670 / R5 340X OEM / R7
250/350/350X OEM], and we tried to enable all ASPM states.

Bjorn

