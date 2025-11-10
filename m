Return-Path: <linux-pci+bounces-40703-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55924C469F4
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 13:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA9C3AF1E4
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 12:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E399E305064;
	Mon, 10 Nov 2025 12:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5ECe5HE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90471C5D7D;
	Mon, 10 Nov 2025 12:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778091; cv=none; b=MjyULmHn2VzdfQS/0OEfuAGd67MPahPptuqR4O1mXdWFUPWnlsRkrXgTQflRJIfPWMaSh7wwgdEQFDCEhhQYNUYpZr3s8QafvgiVUU30pG+y8hUig5zcJmFp7x1Nju/X+e8JggvgWhYu6vS9WA8rQipP87BuMeShhdrjS/8sSOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778091; c=relaxed/simple;
	bh=PeHtSq2Ht5kZyHKHWShGAlbplKSNmgtXjdAXCDAwyzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJt1C+Rk16wiIU3vJbkfgRQWNMBDoIb/CNbXhlFVGP1OHtUTkcFpItUyUKyD0PwBOz7PulQnzd0JJsvx93+RC5N+xOu38Vr1bIS8wO3hL25kkufCzU6nF7MMxe93O2PiD/EWEEWI9PcBaUiKZ8rmkBIxWfH356zpvBMJCxtGL4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5ECe5HE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538F1C16AAE;
	Mon, 10 Nov 2025 12:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762778087;
	bh=PeHtSq2Ht5kZyHKHWShGAlbplKSNmgtXjdAXCDAwyzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L5ECe5HEMSeV1nupeXsDs/B9yrJfrmid6wcQIhTk7DYH83uQUKtD+WqGLNeRvCLms
	 9a3gwYGfZLrtkCIdOejEOU055pvulTkGooNnScP04Kv8ggJrXwiJufPfn1bS105eFQ
	 SkiolcTPwB9arfm0JL7jm3IZ13a3VjOReRtjh20mMdAS4BJUvvbyFJNCZEbL0xlBdR
	 kzaKeaibmThXZPZOZEWiwl1W1fRcR/qbtLZpA66leleQD3K+cFBiq0cFiRQs3a52oF
	 wy1Zl6Um9igCYzTqlbB3eE6IKIIk84CF4Qlu0W6LSnGSQqy4erAfRqjX4CCoU9I3PV
	 V2yB/HaPYqy/Q==
Date: Mon, 10 Nov 2025 13:34:41 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, Damien Le Moal <dlemoal@kernel.org>,
	Anand Moon <linux.amoon@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Dragan Simic <dsimic@manjaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, mani@kernel.org
Subject: Re: [RESEND] Re: [PATCH] PCI: dw-rockchip: Skip waiting for link up
Message-ID: <aRHb4S40a7ZUDop1@ryzen>
References: <aQ840q5BxNS1eIai@ryzen>
 <aQ9FWEuW47L8YOxC@ryzen>
 <55EB0E5F655F3AFC+136b89fd-98d4-42af-a99d-a0bb05cc93f3@radxa.com>
 <aRCI5kG16_1erMME@ryzen>
 <F8B2B6FA2884D69A+b7da13f2-0ffb-4308-b1ba-0549bc461be8@radxa.com>
 <780a4209-f89f-43a9-9364-331d3b77e61e@rock-chips.com>
 <4487DA40249CC821+19232169-a096-4737-bc6a-5cec9592d65f@radxa.com>
 <363d6b4d-c999-43d4-866e-880ef7d0dec3@rock-chips.com>
 <0C31787C387488ED+fd39bfe6-0844-4a87-bf48-675dd6d6a2df@radxa.com>
 <dc932773-af5b-4af7-a0d0-8cc72dfbd3c7@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc932773-af5b-4af7-a0d0-8cc72dfbd3c7@rock-chips.com>

On Mon, Nov 10, 2025 at 06:15:33PM +0800, Shawn Lin wrote:
> > 
> > Could you try PCIe 2.0 slot on your board?
> 
> I did, it doesn't work on PCIe 2.0 slot. From the PA, I could see
> the link is still in training during pci_host_probe() is called.
> Add some delay before pci_rescan_bus() in pcie-dw-rockchip doesn't
> help. But the below change should work as we delayed pci_host_probe().
> 
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -236,6 +236,8 @@ static int rockchip_pcie_start_link(struct dw_pcie *pci)
>         msleep(PCIE_T_PVPERL_MS);
>         gpiod_set_value_cansleep(rockchip->rst_gpio, 1);
> 
> +       msleep(50);
> +
>         return 0;
> 
> Otherwise we got:
> 
> [    0.841518] pci_bus 0003:33: busn_res: can not insert [bus 33-31] under
> [bus 32-31] (conflicts with (null) [bus 32-31])
> [    0.842596] pci_bus 0003:33: busn_res: [bus 33-31] end is updated to 33
> [    0.843184] pci_bus 0003:33: busn_res: can not insert [bus 33] under [bus
> 32-31] (conflicts with (null) [bus 32-31])
> [    0.844120] pci 0003:32:00.0: devices behind bridge are unusable because
> [bus 33] cannot be assigned for them
> [    0.845229] pci_bus 0003:34: busn_res: can not insert [bus 34-31] under
> [bus 32-31] (conflicts with (null) [bus 32-31])
> [    0.846309] pci_bus 0003:34: busn_res: [bus 34-31] end is updated to 34
> [    0.846898] pci_bus 0003:34: busn_res: can not insert [bus 34] under [bus
> 32-31] (conflicts with (null) [bus 32-31])
> [    0.847833] pci 0003:32:06.0: devices behind bridge are unusable because
> [bus 34] cannot be assigned for them
> [    0.848923] pci_bus 0003:35: busn_res: can not insert [bus 35-31] under
> [bus 32-31] (conflicts with (null) [bus 32-31])
> [    0.850014] pci_bus 0003:35: busn_res: [bus 35-31] end is updated to 35
> [    0.850605] pci_bus 0003:35: busn_res: can not insert [bus 35] under [bus
> 32-31] (conflicts with (null) [bus 32-31])
> [    0.851540] pci 0003:32:0e.0: devices behind bridge are unusable because
> [bus 35] cannot be assigned for them
> [    0.852424] pci_bus 0003:32: busn_res: [bus 32-31] end is updated to 35
> [    0.853028] pci_bus 0003:32: busn_res: can not insert [bus 32-35] under
> [bus 31] (conflicts with (null) [bus 31])
> [    0.853184] hub 3-0:1.0: USB hub found
> [    0.853931] pci 0003:31:00.0: devices behind bridge are unusable because
> [bus 32-35] cannot be assigned for them
> [    0.854262] hub 3-0:1.0: 1 port detected
> [    0.855144] pcieport 0003:30:00.0: bridge has subordinate 31 but max busn
> 35
> [    0.855722] hub 4-0:1.0: USB hub found
> [    0.856109] pci 0003:32:00.0: PCI bridge to [bus 33]
> [    0.856939] pci 0003:32:06.0: PCI bridge to [bus 34]
> [    0.857133] hub 4-0:1.0: 1 port detected
> [    0.857430] pci 0003:32:0e.0: PCI bridge to [bus 35]
> [    0.858236] pci 0003:31:00.0: PCI bridge to [bus 32-35]

Mani,

while I see the idea behind your suggested hack:
 
+       if (pdev->vendor == 0x1d87 && pdev->device == 0x3588) {
+               pdev->is_hotplug_bridge = pdev->is_pciehp = 1;
+               return;
+       }


Considering what Shawn says, that the switch gets enumerated properly
if we simply add a msleep() in ->start_link(), which will be called
by dw_pcie_host_init() before pci_host_probe() is called...

...we already have a delay in the link up IRQ handler, before calling
pci_rescan_bus().

So, I think that the problem is that we are unconditionally calling
pci_host_probe() in dw_pcie_host_init(), even for platforms that have
a link-up IRQ.


I think a better solution would be something like:

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index e92513c5bda5..42d987ddab7d 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -565,6 +565,39 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
 	return 0;
 }
 
+static int dw_pcie_host_initial_scan(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct pci_host_bridge *bridge = pp->bridge;
+	int ret;
+
+	ret = pci_host_probe(bridge);
+	if (ret)
+		return ret;
+
+	if (pp->ops->post_init)
+		pp->ops->post_init(pp);
+
+	dwc_pcie_debugfs_init(pci, DW_PCIE_RC_TYPE);
+
+	return 0;
+}
+
+void dw_pcie_handle_link_up_irq(struct dw_pcie_rp *pp)
+{
+	if (!pp->initial_linkup_irq_done) {
+		if (dw_pcie_host_initial_scan(pp)) {
+			//TODO: cleanup
+		}
+		pp->initial_linkup_irq_done = true;
+	} else {
+		/* Rescan the bus to enumerate endpoint devices */
+		pci_lock_rescan_remove();
+		pci_rescan_bus(pp->bridge->bus);
+		pci_unlock_rescan_remove();
+	}
+}
+
 int dw_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -672,15 +705,13 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (!pp->use_linkup_irq)
 		/* Ignore errors, the link may come up later */
 		dw_pcie_wait_for_link(pci);
-
-	ret = pci_host_probe(bridge);
-	if (ret)
-		goto err_stop_link;
-
-	if (pp->ops->post_init)
-		pp->ops->post_init(pp);
-
-	dwc_pcie_debugfs_init(pci, DW_PCIE_RC_TYPE);
+	else
+		/*
+		 * For platforms with Link Up IRQ, initial scan will be done
+		 * on first Link Up IRQ.
+		 */
+		if (dw_pcie_host_initial_scan(pp))
+			goto err_stop_link;
 
 	return 0;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index e995f692a1ec..a31bd93490dc 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -427,6 +427,7 @@ struct dw_pcie_rp {
 	int			msg_atu_index;
 	struct resource		*msg_res;
 	bool			use_linkup_irq;
+	bool			initial_linkup_irq_done;
 	struct pci_eq_presets	presets;
 	struct pci_config_window *cfg;
 	bool			ecam_enabled;
@@ -807,6 +808,7 @@ void dw_pcie_msi_init(struct dw_pcie_rp *pp);
 int dw_pcie_msi_host_init(struct dw_pcie_rp *pp);
 void dw_pcie_free_msi(struct dw_pcie_rp *pp);
 int dw_pcie_setup_rc(struct dw_pcie_rp *pp);
+void dw_pcie_handle_link_up_irq(struct dw_pcie_rp *pp);
 int dw_pcie_host_init(struct dw_pcie_rp *pp);
 void dw_pcie_host_deinit(struct dw_pcie_rp *pp);
 int dw_pcie_allocate_domains(struct dw_pcie_rp *pp);
@@ -844,6 +846,9 @@ static inline int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 	return 0;
 }
 
+static inline void dw_pcie_handle_link_up_irq(struct dw_pcie_rp *pp)
+{ }
+
 static inline int dw_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	return 0;
diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 8a882dcd1e4e..042e5845bdd6 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -468,10 +468,7 @@ static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
 		if (rockchip_pcie_link_up(pci)) {
 			msleep(PCIE_RESET_CONFIG_WAIT_MS);
 			dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
-			/* Rescan the bus to enumerate endpoint devices */
-			pci_lock_rescan_remove();
-			pci_rescan_bus(pp->bridge->bus);
-			pci_unlock_rescan_remove();
+			dw_pcie_handle_link_up_irq(pp);
 		}
 	}
 




What do you think?



Kind regards,
Niklas

