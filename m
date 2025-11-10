Return-Path: <linux-pci+bounces-40717-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDE3C479A7
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 16:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFFFE188F3B4
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 15:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A117B26FA6C;
	Mon, 10 Nov 2025 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXVfW0hL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7954F1A5B92;
	Mon, 10 Nov 2025 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789093; cv=none; b=B7w+bzciB57YsJTiiBX8a2CUcS9KzIPo0MnHsUis3Pn5nDDl8+5I95mzTVMDGPTb8rEHWDq1wyBlVUHJ0hvlHAaUVK8+dhHBPIDFCezmT8m1mx7uaIdxFxIJpz7yNWYixUk7YqHCFvoDw+U/2ffuIC78jGlmqhi/5bS9qt3NYb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789093; c=relaxed/simple;
	bh=CpwSvvgbCGqW3S46CMlFEao+/kI0Gr5YmT9SXvKYbfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMBMwYb2HNJzM39BHHiX1/rNSTZlGyFnX0ChM1UgfIlO1HvpzwcQiQIzNIg2njLA/XjmCvycilemqKLGLfdGutUDLg7ZNKDMlyqCa+tHEuzIlWxIbrEBFAKXhtMHvgddqewTY6WZVpaV2MoD3kpti9JTrEv79hHLhj+Dfe4WiqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXVfW0hL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E688FC116B1;
	Mon, 10 Nov 2025 15:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762789093;
	bh=CpwSvvgbCGqW3S46CMlFEao+/kI0Gr5YmT9SXvKYbfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eXVfW0hLR++XliqC40OLy5LSAKANL6GcdwkMlevN/PfAubYGaXpeAZQj7OW0oWH8j
	 x3INcEpT+E1RnEkx0s/CY24H8pWlwSakqQE+tfTGpOWJwefnNTibW4ajfxyrpZTJ70
	 oYm0ZGdaYbCXXecWPSoF2Evt9AVzR2Dfyrv5/UG2SsOdHIwoFbZQvOuIcyjuJ5EreM
	 GrmXyHMTZbhWnIS/OwdoGm78P1lEYFvRzch9mYqOiqdNiGuMdfJYMmHvFftCxmLvQE
	 ZlzGPyHYWvYnvwrE1sGZ2qng2q3ALctfB7w9ZbLg86rmDlMyCKcLqsbECi8AE+kuw0
	 076scsYmZfBEw==
Date: Mon, 10 Nov 2025 21:07:58 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: Niklas Cassel <cassel@kernel.org>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Anand Moon <linux.amoon@gmail.com>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Dragan Simic <dsimic@manjaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>
Subject: Re: [RESEND] Re: [PATCH] PCI: dw-rockchip: Skip waiting for link up
Message-ID: <wnrtofgggs5d7y42ps4ujp3h54nuiszfkmoor6hdz2vlpbvkys@d4nre55j6nam>
References: <aRCI5kG16_1erMME@ryzen>
 <F8B2B6FA2884D69A+b7da13f2-0ffb-4308-b1ba-0549bc461be8@radxa.com>
 <780a4209-f89f-43a9-9364-331d3b77e61e@rock-chips.com>
 <4487DA40249CC821+19232169-a096-4737-bc6a-5cec9592d65f@radxa.com>
 <363d6b4d-c999-43d4-866e-880ef7d0dec3@rock-chips.com>
 <0C31787C387488ED+fd39bfe6-0844-4a87-bf48-675dd6d6a2df@radxa.com>
 <dc932773-af5b-4af7-a0d0-8cc72dfbd3c7@rock-chips.com>
 <aRHb4S40a7ZUDop1@ryzen>
 <aRHdeVCY3rRmxe80@ryzen>
 <7A613E8E5A3767C6+84d31db2-074e-49aa-8e82-bfb78632d2fa@radxa.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7A613E8E5A3767C6+84d31db2-074e-49aa-8e82-bfb78632d2fa@radxa.com>

On Tue, Nov 11, 2025 at 12:21:20AM +0900, FUKAUMI Naoki wrote:
> Hi Shawn, Mani, Niklas,
> 
> I'm testing your patches on ROCK 5A/5C, but the behavior is inconsistent.
> Sometimes it works, sometimes it doesn't, and sometimes I get an oops. I'm a
> bit confused, so I'll try again tomorrow.
> 
> BTW, do you have any idea about this oops?
> 

I don't know why this is happening, but looks like it is coming from
CONFIG_PCI_DYNAMIC_OF_NODES. You can unset it and give it a try.

- Mani

> [    1.680251] Unable to handle kernel NULL pointer dereference at virtual
> address 0000000000000080
> [    1.681039] Mem abort info:
> [    1.681294]   ESR = 0x0000000096000004
> [    1.681627]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    1.682101]   SET = 0, FnV = 0
> [    1.682382]   EA = 0, S1PTW = 0
> [    1.682662]   FSC = 0x04: level 0 translation fault
> [    1.683119] Data abort info:
> [    1.683381]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [    1.683869]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [    1.684324]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [    1.684798] user pgtable: 4k pages, 48-bit VAs, pgdp=000000005630d000
> [    1.685374] [0000000000000080] pgd=0000000000000000, p4d=0000000000000000
> [    1.685983] Internal error: Oops: 0000000096000004 [#1]  SMP
> [    1.686483] Modules linked in: phy_rockchip_usbdp typec
> phy_rockchip_naneng_combphy phy_rockchip_samsung_hdptx dwmac_rk
> stmmac_platform stmmac pcs_xpcs rockchipdrm dw_hdmi_qp analogix_dp dw_hdmi
> dw_mipi_dsi drm_dp_aux_bus drm_display_helper cec drm_client_lib
> drm_dma_helper drm_kms_helper drm backlight
> [    1.688881] CPU: 0 UID: 0 PID: 171 Comm: irq/87-pcie-sys Tainted: G
> W           6.18.0-rc5-dirty #2 PREEMPT
> [    1.689801] Tainted: [W]=WARN
> [    1.690066] Hardware name: radxa Radxa ROCK 5C/Radxa ROCK 5C, BIOS
> 2025.10-00012-g0c3aff620204-dirty 10/01/2025
> [    1.690952] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS
> BTYPE=--)
> [    1.691567] pc : of_pci_add_properties+0x284/0x4c4
> [    1.692000] lr : of_pci_add_properties+0x264/0x4c4
> [    1.692426] sp : ffff8000813fbbf0
> [    1.692722] x29: ffff8000813fbc40 x28: ffffcfffe906b3b8 x27:
> ffffcfffeb95b1d0
> [    1.693358] x26: ffff000001236980 x25: ffff00007452ceac x24:
> ffff000008844600
> [    1.693993] x23: ffff00007452ce00 x22: ffff0000073b3a00 x21:
> ffff00000045db10
> [    1.694628] x20: ffff00000057c000 x19: 0000000000000000 x18:
> 00000000ffffffff
> [    1.695264] x17: 0000000000000000 x16: 0000000000000000 x15:
> ffff8000813fba70
> [    1.695898] x14: ffff000000c355b8 x13: ffff000000c355b6 x12:
> 0000000000000000
> [    1.696533] x11: 00333634353d4d55 x10: 000000000000002c x9 :
> 0000000000000000
> [    1.697168] x8 : ffff00007479c800 x7 : 0000000000000000 x6 :
> 0000000000696370
> [    1.697803] x5 : 0000000000000000 x4 : 0000000000000002 x3 :
> ffff8000813fbc20
> [    1.698439] x2 : ffffcfffeabc6ef0 x1 : ffff0000073b3a00 x0 :
> 0000000000000000
> [    1.699074] Call trace:
> [    1.699293]  of_pci_add_properties+0x284/0x4c4 (P)
> [    1.699723]  of_pci_make_dev_node+0xd8/0x150
> [    1.700109]  pci_bus_add_device+0x138/0x168
> [    1.700485]  pci_bus_add_devices+0x3c/0x88
> [    1.700853]  pci_bus_add_devices+0x68/0x88
> [    1.701220]  pci_rescan_bus+0x30/0x44
> [    1.701551]  rockchip_pcie_rc_sys_irq_thread+0xb8/0xd0
> [    1.702010]  irq_thread_fn+0x2c/0xa8
> [    1.702333]  irq_thread+0x168/0x320
> [    1.702648]  kthread+0x12c/0x204
> [    1.702941]  ret_from_fork+0x10/0x20
> [    1.703267] Code: aa1603e1 f000abc2 d2800044 913bc042 (f94040a0)
> 
> Best regards,
> 
> --
> FUKAUMI Naoki
> Radxa Computer (Shenzhen) Co., Ltd.
> 
> On 11/10/25 21:41, Niklas Cassel wrote:
> > On Mon, Nov 10, 2025 at 01:34:41PM +0100, Niklas Cassel wrote:
> > > @@ -672,15 +705,13 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > >   	if (!pp->use_linkup_irq)
> > >   		/* Ignore errors, the link may come up later */
> > >   		dw_pcie_wait_for_link(pci);
> > > -
> > > -	ret = pci_host_probe(bridge);
> > > -	if (ret)
> > > -		goto err_stop_link;
> > > -
> > > -	if (pp->ops->post_init)
> > > -		pp->ops->post_init(pp);
> > > -
> > > -	dwc_pcie_debugfs_init(pci, DW_PCIE_RC_TYPE);
> > > +	else
> > > +		/*
> > > +		 * For platforms with Link Up IRQ, initial scan will be done
> > > +		 * on first Link Up IRQ.
> > > +		 */
> > > +		if (dw_pcie_host_initial_scan(pp))
> > > +			goto err_stop_link;
> > 
> > Oops.. this condition was inverted, what I meant was:
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index e92513c5bda5..0e04c1d6d260 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -565,6 +565,39 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
> >   	return 0;
> >   }
> > +static int dw_pcie_host_initial_scan(struct dw_pcie_rp *pp)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct pci_host_bridge *bridge = pp->bridge;
> > +	int ret;
> > +
> > +	ret = pci_host_probe(bridge);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (pp->ops->post_init)
> > +		pp->ops->post_init(pp);
> > +
> > +	dwc_pcie_debugfs_init(pci, DW_PCIE_RC_TYPE);
> > +
> > +	return 0;
> > +}
> > +
> > +void dw_pcie_handle_link_up_irq(struct dw_pcie_rp *pp)
> > +{
> > +	if (!pp->initial_linkup_irq_done) {
> > +		if (dw_pcie_host_initial_scan(pp)) {
> > +			//TODO: cleanup
> > +		}
> > +		pp->initial_linkup_irq_done = true;
> > +	} else {
> > +		/* Rescan the bus to enumerate endpoint devices */
> > +		pci_lock_rescan_remove();
> > +		pci_rescan_bus(pp->bridge->bus);
> > +		pci_unlock_rescan_remove();
> > +	}
> > +}
> > +
> >   int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >   {
> >   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > @@ -669,18 +702,17 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >   	 * If there is no Link Up IRQ, we should not bypass the delay
> >   	 * because that would require users to manually rescan for devices.
> >   	 */
> > -	if (!pp->use_linkup_irq)
> > +	if (!pp->use_linkup_irq) {
> >   		/* Ignore errors, the link may come up later */
> >   		dw_pcie_wait_for_link(pci);
> > -	ret = pci_host_probe(bridge);
> > -	if (ret)
> > -		goto err_stop_link;
> > -
> > -	if (pp->ops->post_init)
> > -		pp->ops->post_init(pp);
> > -
> > -	dwc_pcie_debugfs_init(pci, DW_PCIE_RC_TYPE);
> > +		/*
> > +		 * For platforms with Link Up IRQ, initial scan will be done
> > +		 * on first Link Up IRQ.
> > +		 */
> > +		if (dw_pcie_host_initial_scan(pp))
> > +			goto err_stop_link;
> > +	}
> >   	return 0;
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index e995f692a1ec..a31bd93490dc 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -427,6 +427,7 @@ struct dw_pcie_rp {
> >   	int			msg_atu_index;
> >   	struct resource		*msg_res;
> >   	bool			use_linkup_irq;
> > +	bool			initial_linkup_irq_done;
> >   	struct pci_eq_presets	presets;
> >   	struct pci_config_window *cfg;
> >   	bool			ecam_enabled;
> > @@ -807,6 +808,7 @@ void dw_pcie_msi_init(struct dw_pcie_rp *pp);
> >   int dw_pcie_msi_host_init(struct dw_pcie_rp *pp);
> >   void dw_pcie_free_msi(struct dw_pcie_rp *pp);
> >   int dw_pcie_setup_rc(struct dw_pcie_rp *pp);
> > +void dw_pcie_handle_link_up_irq(struct dw_pcie_rp *pp);
> >   int dw_pcie_host_init(struct dw_pcie_rp *pp);
> >   void dw_pcie_host_deinit(struct dw_pcie_rp *pp);
> >   int dw_pcie_allocate_domains(struct dw_pcie_rp *pp);
> > @@ -844,6 +846,9 @@ static inline int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
> >   	return 0;
> >   }
> > +static inline void dw_pcie_handle_link_up_irq(struct dw_pcie_rp *pp)
> > +{ }
> > +
> >   static inline int dw_pcie_host_init(struct dw_pcie_rp *pp)
> >   {
> >   	return 0;
> > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > index 8a882dcd1e4e..042e5845bdd6 100644
> > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > @@ -468,10 +468,7 @@ static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
> >   		if (rockchip_pcie_link_up(pci)) {
> >   			msleep(PCIE_RESET_CONFIG_WAIT_MS);
> >   			dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
> > -			/* Rescan the bus to enumerate endpoint devices */
> > -			pci_lock_rescan_remove();
> > -			pci_rescan_bus(pp->bridge->bus);
> > -			pci_unlock_rescan_remove();
> > +			dw_pcie_handle_link_up_irq(pp);
> >   		}
> >   	}
> > 
> 

-- 
மணிவண்ணன் சதாசிவம்

