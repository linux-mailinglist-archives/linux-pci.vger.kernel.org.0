Return-Path: <linux-pci+bounces-38243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A75BDFA28
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 18:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62FED18871F2
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 16:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4377D335BBE;
	Wed, 15 Oct 2025 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdzAG5u9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1E426B764
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 16:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760545421; cv=none; b=GyYkAiddRfxvbBuOC5YtIDjffqcEsRAImI5qhX18rMi39+QqSnIUWE2goF1QCoTruOLDHAvuSGuD30i8GzXg6bhX0MmT7cVF7AkvLEuRuJckQZyiIkJRAZO+rhUR3B96Dl1fn3pF+YDpufRpOp/nwZF5xAIDTZAIk5fn4m6r7H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760545421; c=relaxed/simple;
	bh=vu6ue76QD8o9WFynC7bUcUGayTYCLLK40E6CHK4jY2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SiqjJABTCBjcTdwibdH7Vhy5toAhmtdjysI3y4sBvYR3IP8MKeO90ErH4S0ZkBvthA4q5987OhNuLziukylhsFgkdYJu1sA+3p0nWsLPhP0PUzME/opq+Jgktog85YfddIWcN37JbuLJaIDZuzeRm27763Y2A3TjSqua7JPYxtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdzAG5u9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01675C4CEFB;
	Wed, 15 Oct 2025 16:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760545420;
	bh=vu6ue76QD8o9WFynC7bUcUGayTYCLLK40E6CHK4jY2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bdzAG5u9dO9QPkYgHiX7SK3N/AugvofjOAAidYDmd6E40Huua/4C37iiqmS9qv0wi
	 M+WzekZzM+RT11P3e1eYjolgcaxDCV4aZXNhlkB/bcvV+TP4ApHKVJEQK/HO0dPPpv
	 j0kA22ElaAFOG/BXPO6or9sHcXlHrYNjZyv+MuBYV3VDoADTSGLkYoKzoBrtpCVWud
	 GN5MSstr6e1fSzxwecWXiq9xGjwa248l+buDzj9rEv/N5XP3ceJsNWyMP7yOjdW1ss
	 j1wA2vL5iYmn8InvTiwVii4oar72ugqxrw7bkhyBxT1N6WsT9fvkf0UesrwyhpWyp4
	 fHqp2a5Hb06ow==
Date: Wed, 15 Oct 2025 21:53:26 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>, 
	Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, mad skateman <madskateman@gmail.com>, 
	"R.T.Dickinson" <rtd2@xtra.co.nz>, Christian Zigotzky <info@xenosoft.de>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au, Darren Stevens <darren@stevens-zone.net>, 
	debian-powerpc@lists.debian.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Message-ID: <jznknzm2ke7b7d7itdbv5nqianxl3n6p35dg45gpwm3e57ulxp@iy2juxdq5m4i>
References: <20251015135811.58b22331@bootlin.com>
 <EF4D5B4B-9A61-4CF8-A5CC-5F6A49E824C1@xenosoft.de>
 <20251015145901.3ca9d8a0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251015145901.3ca9d8a0@bootlin.com>

On Wed, Oct 15, 2025 at 02:59:01PM +0200, Herve Codina wrote:
> On Wed, 15 Oct 2025 14:27:00 +0200
> Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
> 
> > > On 15 October 2025 at 01:58 pm, Herve Codina <herve.codina@bootlin.com> wrote:
> > > 
> > > ﻿Hi Christian,
> > >   
> > >> On Wed, 15 Oct 2025 13:30:44 +0200
> > >> Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
> > >> 
> > >> Hello Herve,
> > >>   
> > >>>> On 15 October 2025 at 10:39 am, Herve Codina <herve.codina@bootlin.com> wrote:  
> > >>> 
> > >>> ﻿Hi All,
> > >>> 
> > >>> I also observed issues with the commit f3ac2ff14834 ("PCI/ASPM: Enable all
> > >>> ClockPM and ASPM states for devicetree platforms")    
> > >> 
> > >> Thanks for reporting.
> > >>   
> > >>> 
> > >>> Also tried the quirk proposed in this discussion (quirk_disable_aspm_all)
> > >>> an the quirk also fixes the timing issue.    
> > >> 
> > >> Where have you added quirk_disable_aspm_all?  
> > > 
> > > --- 8< ---
> > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > index 214ed060ca1b..a3808ab6e92e 100644
> > > --- a/drivers/pci/quirks.c
> > > +++ b/drivers/pci/quirks.c
> > > @@ -2525,6 +2525,17 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
> > >  */
> > > DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
> > > 
> > > +static void quirk_disable_aspm_all(struct pci_dev *dev)
> > > +{
> > > +       pci_info(dev, "Disabling ASPM\n");
> > > +       pci_disable_link_state(dev, PCIE_LINK_STATE_ALL);
> > > +}
> > > +
> > > +/* LAN966x PCI board */
> > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EFAR, 0x9660, quirk_disable_aspm_all);
> > > +
> > > /*
> > >  * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
> > >  * Link bit cleared after starting the link retrain process to allow this
> > > --- 8< ---
> > > 
> > > Best regards,
> > > Hervé  
> > 
> > It is the same patch, I use for my AMD Radeon cards.
> > 
> > In my point of view we have to add a lot of other devices.
> 
> Yes, probably!
> 
> > 
> > But if the computer does not boot, will the average user know that there is a problem with the power management and their graphics card?
> > I am unsure whether I can deliver the kernel to average users later on.
> 
> Also when it boots, it is not easy to know about the problem root cause.
> 
> In my case, it was not obvious to make the relationship on my side between
> my ping timings behavior and ASPM.
> 

Interesting. So in your case, the issue is that ASPM adds up latency of the
network card? If so, it is intended. The added latency should correspond to the
L0s/L1 exit latencies.

If you want performance, then you should select CONFIG_PCIEASPM_PERFORMANCE
using Kconfig or pass 'pcie_aspm=off' in cmdline or do,

'echo performance > /sys/module/pcie_aspm/parameters/policy'

By default, enabling ASPM saves power, but it comes with a cost of reducing
performance.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

