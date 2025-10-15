Return-Path: <linux-pci+bounces-38208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A47C6BDE704
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 14:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 872FF4E8906
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 12:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31041322DB7;
	Wed, 15 Oct 2025 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8lDNOc0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E5D23A99E;
	Wed, 15 Oct 2025 12:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760530661; cv=none; b=OGZLegPJQgv7ZlcObusMJgOKFm6cWG20UbvKjjVaMr4uT4ChsgfwnLHuv05/3t5GOCHqwQ5CvxBs1bSmVm8E2SXAaVLB2h7GbWvvuqIeuFYlTfYc98OqzG8G8Bfy8QguwxG6ZCrvGDlN+f7r+T6NKE7Alzf1OMvTOoa0gbtGaDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760530661; c=relaxed/simple;
	bh=4dj1pZ6/tkmCuLONgrISudEw+q6AJznQjWAEkKNElIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwOL4lCHrzysR2sLMCATXdzsaZzfF3BsAbRuW7k/paTNdjmop6u4bUUxb8FihxbPzNRs1wpgBjYo29EwwhPcg4R3sWSxv0UxkZftMVyk7NmhuDR3FJJV09WgOcZfOt6hsPW9QhWQ5eC9msQ/2LUlBa/B9Bw33gYHuIUCMfFTk9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8lDNOc0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902FFC4CEF8;
	Wed, 15 Oct 2025 12:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760530660;
	bh=4dj1pZ6/tkmCuLONgrISudEw+q6AJznQjWAEkKNElIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f8lDNOc0OeNbG8ocnB2PZFMo+hN3z3hiUHGZJeLH+9i5EhN4BjlN8aIGqIYngwYAK
	 on22xFQLC/JMXXiJLl/ZO4w9+oqmPCV7cNkNGsr9Pk6pG+xi89Dda/PlxPqK3G5MqJ
	 l4EEt13MCuosPRziMtwFQjNUPJUYbWKlkoUuFqMvLPXDw88epRZbAR+HmQfDtHBfR2
	 ThJFdtm5vXp7qB0GIiWHw9XqyVF+cqBLUeLLnz8neI7Pd/TX/kzSVaJKodYYC5sq1z
	 0UmDGPCqzXLw/vAVozyj2/W0dSDdcSas0OR1ppDnjimXzokF+WCMyiyz9arjYpHIVG
	 D5qcV+MxguYAg==
Date: Wed, 15 Oct 2025 14:17:33 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	manivannan.sadhasivam@oss.qualcomm.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	"David E. Box" <david.e.box@linux.intel.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Chia-Lin Kao <acelan.kao@canonical.com>,
	Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org, regressions@lists.linux.dev,
	FUKAUMI Naoki <naoki@radxa.com>
Subject: Re: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
Message-ID: <aO-Q3QsxPBXbFieG@ryzen>
References: <22594781424C5C98+22cb5d61-19b1-4353-9818-3bb2b311da0b@radxa.com>
 <20251014184905.GA896847@bhelgaas>
 <5ivvb3wctn65obgqvnajpxzifhndza65rsoiqgracfxl7iiimt@oym345d723o2>
 <823262AB21C8D981+8c1b9d50-5897-432b-972e-b7bb25746ba5@radxa.com>
 <7ugvxl3g5szxhc5ebxnlfllp46lhprjvcg5xp75mobsa44c6jv@h2j3dvm5a4lq>
 <a9ca7843-b780-45aa-9f62-3f443ae06eee@rock-chips.com>
 <aO9tWjgHnkATroNa@ryzen>
 <ud72uxkobylkwy5q5gtgoyzf24ewm7mveszfxr3o7tortwrvw5@kc3pfjr3dtaj>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ud72uxkobylkwy5q5gtgoyzf24ewm7mveszfxr3o7tortwrvw5@kc3pfjr3dtaj>

On Wed, Oct 15, 2025 at 04:03:53PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Oct 15, 2025 at 11:46:02AM +0200, Niklas Cassel wrote:
> > Hello Shawn,
> > 
> > On Wed, Oct 15, 2025 at 05:11:39PM +0800, Shawn Lin wrote:
> > > > 
> > > > Thanks! Could you please try the below diff with f3ac2ff14834 applied?
> > > > 
> > > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > > index 214ed060ca1b..0069d06c282d 100644
> > > > --- a/drivers/pci/quirks.c
> > > > +++ b/drivers/pci/quirks.c
> > > > @@ -2525,6 +2525,15 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
> > > >    */
> > > >   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
> > > > 
> > > > +
> > > > +static void quirk_disable_aspm_all(struct pci_dev *dev)
> > > > +{
> > > > +       pci_info(dev, "Disabling ASPM\n");
> > > > +       pci_disable_link_state(dev, PCIE_LINK_STATE_ALL);
> > > > +}
> > > > +
> > > > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ROCKCHIP, 0x3588, quirk_disable_aspm_all);
> > > 
> > > That's not true from my POV. Rockchip platform supports all ASPM policy
> > > after mass production verification. I also verified current upstream
> > > code this morning with RK3588-EVB and can check L0s/L1/L1ss work fine.
> > > 
> > > The log and lspci output could be found here:
> > > https://pastebin.com/qizeYED7
> > > 
> > > Moreover, I disscussed this issue with FUKAUMI today off-list and his
> > > board seems to work when only disable L1ss by patching:
> > > 
> > > --- a/drivers/pci/pcie/aspm.c
> > > +++ b/drivers/pci/pcie/aspm.c
> > > @@ -813,7 +813,7 @@ static void pcie_aspm_override_default_link_state(struct
> > > pcie_link_state *link)
> > > 
> > >         /* For devicetree platforms, enable all ASPM states by default */
> > >         if (of_have_populated_dt()) {
> > > -               link->aspm_default = PCIE_LINK_STATE_ASPM_ALL;
> > > +               link->aspm_default = PCIE_LINK_STATE_L0S |
> > > PCIE_LINK_STATE_L1;
> > >                 override = link->aspm_default & ~link->aspm_enabled;
> > >                 if (override)
> > >                         pci_info(pdev, "ASPM: DT platform,
> > > 
> > > 
> > > So, is there a proper way to just disable this feature for spec boards
> > > instead of this Soc?
> > 
> > This fix seems do the trick, without needing to patch common code (aspm.c):
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > index 3e2752c7dd09..f5e1aaa97719 100644
> > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > @@ -200,6 +200,19 @@ static bool rockchip_pcie_link_up(struct dw_pcie *pci)
> >  	return FIELD_GET(PCIE_LINKUP_MASK, val) == PCIE_LINKUP;
> >  }
> >  
> > +static void rockchip_pcie_disable_l1sub(struct dw_pcie *pci)
> > +{
> > +	u32 cap, l1subcap;
> > +
> > +	cap = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
> > +	if (cap) {
> > +		l1subcap = dw_pcie_readl_dbi(pci, cap + PCI_L1SS_CAP);
> > +		l1subcap &= ~(PCI_L1SS_CAP_ASPM_L1_1 | PCI_L1SS_CAP_ASPM_L1_2 | PCI_L1SS_CAP_L1_PM_SS);
> > +		dw_pcie_writel_dbi(pci, cap + PCI_L1SS_CAP, l1subcap);
> > +		l1subcap = dw_pcie_readl_dbi(pci, cap + PCI_L1SS_CAP);
> > +	}
> > +}
> > +
> >  static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
> >  {
> >  	u32 cap, lnkcap;
> > @@ -264,6 +277,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
> >  	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
> >  					rockchip);
> >  
> > +	rockchip_pcie_disable_l1sub(pci);
> >  	rockchip_pcie_enable_l0s(pci);
> >  
> >  	return 0;
> > @@ -301,6 +315,7 @@ static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
> >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >  	enum pci_barno bar;
> >  
> > +	rockchip_pcie_disable_l1sub(pci);
> >  	rockchip_pcie_enable_l0s(pci);
> >  	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
> > 
> 
> But this patch removes the L1SS CAP for all boards, isn't it?

Yes, all boards supported by pcie-dw-rockchip.c, which matches what their
downstream driver does.

(Their downstream driver disables L1 substates for all boards that have
not defined 'supports-clkreq', and a grep through their downstream tree,
for all their all their different branches, shows that not a since rockchip
DTS has this property specified.)

So, let me submit a real patch with the above.


Kind regards,
Niklas

