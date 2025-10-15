Return-Path: <linux-pci+bounces-38187-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD67BDDD7A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 11:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECFE04E9310
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 09:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825E531B113;
	Wed, 15 Oct 2025 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTl5jtli"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E95231A576;
	Wed, 15 Oct 2025 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521573; cv=none; b=GKqCcuhUSPyzbE057ytp8BpNres02X8XJL3qtNneOqhhcFVSgDKDSjijVTNByVnMjz32nKaJqO9Va2NKZNKSy89NGwo4SF5WVbXYXm0oKmI45GaLbAJn0P7eV/X0HYmHSfJkzdHKKMzZMU0LaFD/v4ZLqYNDjiHSej1eJKoncx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521573; c=relaxed/simple;
	bh=x1SIc1MqB3wV0gAWbE4/Pg73r1++IsnTATh7kIeSqtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oF3z4OHTKMuu7pLFlVGodphDXuHDP08yynKNwvzoiecSq5mpFbEg/XqI+5qpc5y++ohd7Y0rw26+mNQx6NJcV0zuDFdE8iQVuiRyisWVe5xrMaHuMN0MmJGbcM5LDXjaC4R2+dPYGIh6d82bhhg5Av8SUVPJpFzDGOrCy8bjL5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTl5jtli; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA61C4CEF8;
	Wed, 15 Oct 2025 09:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760521569;
	bh=x1SIc1MqB3wV0gAWbE4/Pg73r1++IsnTATh7kIeSqtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hTl5jtliWdw1y1hpAB/3jsQTzi2kE8SebNgnhuHTtCRoSQX7EZkhKkjxGZAP6OoAx
	 sBVqILL4zmpW3KTjU42dpbYuPUuiwJQagmaoV5HjbsZQJW+EbFR+UPafG/Ac2ydUwt
	 ijQSywEJVNkaLHpeIku2tsjp4wWbieGDXJm0xZ0oNebhHHku7fXkjlpOtjgcUP/q0u
	 rzVcTGu1v4qVW3jDLjOEadCK1yejYh5yJqU4s9rosaTXH9720unrRzXHrOYrZT/P9B
	 85CCrphXEdR+TR95Msy3NLd8t2vQzGRIvIcGatpeAmYD8tAnJHvzKXJutO7A0Sase/
	 0bJBVHzmHQ8EQ==
Date: Wed, 15 Oct 2025 11:46:02 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
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
Message-ID: <aO9tWjgHnkATroNa@ryzen>
References: <22594781424C5C98+22cb5d61-19b1-4353-9818-3bb2b311da0b@radxa.com>
 <20251014184905.GA896847@bhelgaas>
 <5ivvb3wctn65obgqvnajpxzifhndza65rsoiqgracfxl7iiimt@oym345d723o2>
 <823262AB21C8D981+8c1b9d50-5897-432b-972e-b7bb25746ba5@radxa.com>
 <7ugvxl3g5szxhc5ebxnlfllp46lhprjvcg5xp75mobsa44c6jv@h2j3dvm5a4lq>
 <a9ca7843-b780-45aa-9f62-3f443ae06eee@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9ca7843-b780-45aa-9f62-3f443ae06eee@rock-chips.com>

Hello Shawn,

On Wed, Oct 15, 2025 at 05:11:39PM +0800, Shawn Lin wrote:
> > 
> > Thanks! Could you please try the below diff with f3ac2ff14834 applied?
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 214ed060ca1b..0069d06c282d 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -2525,6 +2525,15 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
> >    */
> >   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
> > 
> > +
> > +static void quirk_disable_aspm_all(struct pci_dev *dev)
> > +{
> > +       pci_info(dev, "Disabling ASPM\n");
> > +       pci_disable_link_state(dev, PCIE_LINK_STATE_ALL);
> > +}
> > +
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ROCKCHIP, 0x3588, quirk_disable_aspm_all);
> 
> That's not true from my POV. Rockchip platform supports all ASPM policy
> after mass production verification. I also verified current upstream
> code this morning with RK3588-EVB and can check L0s/L1/L1ss work fine.
> 
> The log and lspci output could be found here:
> https://pastebin.com/qizeYED7
> 
> Moreover, I disscussed this issue with FUKAUMI today off-list and his
> board seems to work when only disable L1ss by patching:
> 
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -813,7 +813,7 @@ static void pcie_aspm_override_default_link_state(struct
> pcie_link_state *link)
> 
>         /* For devicetree platforms, enable all ASPM states by default */
>         if (of_have_populated_dt()) {
> -               link->aspm_default = PCIE_LINK_STATE_ASPM_ALL;
> +               link->aspm_default = PCIE_LINK_STATE_L0S |
> PCIE_LINK_STATE_L1;
>                 override = link->aspm_default & ~link->aspm_enabled;
>                 if (override)
>                         pci_info(pdev, "ASPM: DT platform,
> 
> 
> So, is there a proper way to just disable this feature for spec boards
> instead of this Soc?

This fix seems do the trick, without needing to patch common code (aspm.c):

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 3e2752c7dd09..f5e1aaa97719 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -200,6 +200,19 @@ static bool rockchip_pcie_link_up(struct dw_pcie *pci)
 	return FIELD_GET(PCIE_LINKUP_MASK, val) == PCIE_LINKUP;
 }
 
+static void rockchip_pcie_disable_l1sub(struct dw_pcie *pci)
+{
+	u32 cap, l1subcap;
+
+	cap = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
+	if (cap) {
+		l1subcap = dw_pcie_readl_dbi(pci, cap + PCI_L1SS_CAP);
+		l1subcap &= ~(PCI_L1SS_CAP_ASPM_L1_1 | PCI_L1SS_CAP_ASPM_L1_2 | PCI_L1SS_CAP_L1_PM_SS);
+		dw_pcie_writel_dbi(pci, cap + PCI_L1SS_CAP, l1subcap);
+		l1subcap = dw_pcie_readl_dbi(pci, cap + PCI_L1SS_CAP);
+	}
+}
+
 static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
 {
 	u32 cap, lnkcap;
@@ -264,6 +277,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
 	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
 					rockchip);
 
+	rockchip_pcie_disable_l1sub(pci);
 	rockchip_pcie_enable_l0s(pci);
 
 	return 0;
@@ -301,6 +315,7 @@ static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar;
 
+	rockchip_pcie_disable_l1sub(pci);
 	rockchip_pcie_enable_l0s(pci);
 	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);




In reality, I think that pcie-dw-rockchip.c should check 'supports-clkreq',
and only if it doesn't support clkreq, it should disable L1 substates, similar
to how the Tegra driver does things:
https://github.com/torvalds/linux/blob/v6.18-rc1/drivers/pci/controller/dwc/pcie-tegra194.c#L934-L938
https://github.com/torvalds/linux/blob/v6.18-rc1/drivers/pci/controller/dwc/pcie-tegra194.c#L1164-L1165

In fact, that is also how the downstream rockchip drives does things:
https://github.com/rockchip-linux/kernel/blob/develop-6.6/drivers/pci/controller/dwc/pcie-dw-rockchip.c#L200-L233
https://github.com/rockchip-linux/kernel/blob/develop-6.6/drivers/pci/controller/dwc/pcie-dw-rockchip.c#L725

So I guess we either:
1) Add code to pcie-dw-rockchip.c to unconditionally disable L1 substates, or
2) We add code to:
- If have 'supports-clkreq' property, set PCIE_CLIENT_POWER_CON.app_clk_req_n=1
- If don't have 'supports-clkreq' property, disable L1 substates.

I think we need to do either 1) or 2), because a user can build the kernel with
CONFIG_PCIEASPM_POWER_SUPERSAVE=y
and that would break things even on older kernels, that don't have Mani's recent
commit.



Mani, perhaps common code (aspm.c) should enable L1 substates only if
'supports-clkreq' DT property exists?



Kind regards,
Niklas

