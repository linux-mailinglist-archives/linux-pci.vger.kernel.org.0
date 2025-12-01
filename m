Return-Path: <linux-pci+bounces-42372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3F3C97DE4
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 15:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A3CD3A28B5
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 14:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061B631A568;
	Mon,  1 Dec 2025 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5BwSWHs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C499831A056;
	Mon,  1 Dec 2025 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764599905; cv=none; b=YeHuvp1ThsEiGk2G9RI5CDJwRni9w372MGXFm8zf4xjOwWu++xrS48SZRjhBicUrVDf6/b/lMobjGoQaLZAYfaNuVXZhNPQftmtj9CtyAP+OmW3bhWXnQmz2rxf7DhGILA3VQQhBLK2KqosdceW2o1UvSZ5ycmZyDg+d1vQ5dU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764599905; c=relaxed/simple;
	bh=EHvypyuHfYXIwS659rxHGpzozRLtcucDtPLHNKO3ggs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fL8kO9jGnKuanwR/P9Gf4ZYIxqLk9qUnPtDeOqL4xCZ255syPBbjyZQPEU/Woy17PXZsd89VA4lv28ac6FowwdzNO2lJ6WmUn511DTppBZBqZKhx2NHTUKxatcBXgENBIQ62jsx+SwlJ+FV0xK+vq7sOGE8WYlf1Q+RIqRIkum8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5BwSWHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23016C16AAE;
	Mon,  1 Dec 2025 14:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764599905;
	bh=EHvypyuHfYXIwS659rxHGpzozRLtcucDtPLHNKO3ggs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h5BwSWHsHAdsoiOK2nrzyMN9Cbi9OBkZVIuBUQm5Vwk7rVb0cz2+yWsLLQdV4gsW1
	 GQ+R71uPj37/xw0g8aUXRzwnD+DTZQVziPyuxJTz8udH3jZntzcQdFpYertYNqqzHy
	 8tksG5UxTwDp0ZfbzUGhTO91yXQJExglEDdcBO9h8y/G08L6kV4CtgdLPBLzY342vX
	 PcnUgWxuiftUAVzFHZTjl5WNh2dvGnIqcqFespyHHpdtKBVSKmwunMGzeP0/VBbpJs
	 eL35umdGxETT98TzCGgZRMU1dxqImvXLHYRpiPmj8d5o3tv7LdY7eg7+xPeTBiQwSm
	 SCwv8bCWWlGlw==
Date: Mon, 1 Dec 2025 20:08:12 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Jonathan Chocron <jonnyc@amazon.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v9 4/4] PCI: dwc: Support ECAM mechanism by enabling iATU
 'CFG Shift Feature'
Message-ID: <syg7vpbt3w53s24hgl7b6w64odmif5bq557lwlvzlbvgkukwcn@66jtzzc3vtiu>
References: <20250909-controller-dwc-ecam-v9-0-7d5b651840dd@kernel.org>
 <20250909-controller-dwc-ecam-v9-4-7d5b651840dd@kernel.org>
 <alpine.DEB.2.21.2511280256260.36486@angie.orcam.me.uk>
 <c7aea2b3-6984-40f5-8234-14d265dabefc@oss.qualcomm.com>
 <alpine.DEB.2.21.2511280755440.36486@angie.orcam.me.uk>
 <cabf4c20-095b-4579-adc1-146a566b19b9@oss.qualcomm.com>
 <alpine.DEB.2.21.2511281714030.36486@angie.orcam.me.uk>
 <a4c6d47f-28b5-40d3-bc82-10aeb14f8e78@oss.qualcomm.com>
 <alpine.DEB.2.21.2511290428340.36486@angie.orcam.me.uk>
 <h7pgm3lqolm53sb4wrcpcurk4ghz4tulqnr7vgd7rzxy4hscue@jcn5tepevlwl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4taha6h4y7ppae6c"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <h7pgm3lqolm53sb4wrcpcurk4ghz4tulqnr7vgd7rzxy4hscue@jcn5tepevlwl>


--4taha6h4y7ppae6c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Dec 01, 2025 at 05:21:50PM +0530, Manivannan Sadhasivam wrote:
> On Sat, Nov 29, 2025 at 06:04:24AM +0000, Maciej W. Rozycki wrote:
> > On Sat, 29 Nov 2025, Krishna Chaitanya Chundru wrote:
> > 
> > > > > Hi Maciej, Can you try attached patch and let me know if that is helping
> > > > > you
> > > > > or not. - Krishna Chaitanya.
> > > >   No change, it's still broken, sorry.
> > > HI Maciej,
> > > For the previous patch can you apply this diff and share me dmesg o/p
> > 
> >  Your patch came though garbled, likely due to:
> > 
> > Content-Type: text/plain; charset=UTF-8; format=flowed
> > 
> > Please refer Documentation/process/email-clients.rst and reconfigure your 
> > e-mail client if possible.
> > 
> >  Regardless, I've fixed it up by hand and the only difference in the log, 
> > except for usual noise which I removed, is this:
> > 
> > --- dmesg-bad.log	2025-11-28 03:47:29.582049781 +0100
> > +++ dmesg-debug.log	2025-11-29 05:41:23.384645926 +0100
> > @@ -164,6 +164,8 @@
> >  fu740-pcie e00000000.pcie: ECAM at [mem 0xdf0000000-0xdffffffff] for [bus 00-ff]
> >  fu740-pcie e00000000.pcie: Using 256 MSI vectors
> >  fu740-pcie e00000000.pcie: iATU: unroll T, 8 ob, 8 ib, align 4K, limit 4096G
> > +fu740-pcie e00000000.pcie: Current iATU OB index 2
> > +fu740-pcie e00000000.pcie: Current iATU OB index 4
> >  fu740-pcie e00000000.pcie: cap_exp at 70
> >  fu740-pcie e00000000.pcie: PCIe Gen.1 x8 link up
> >  fu740-pcie e00000000.pcie: changing speed back to original
> > 
> > I've attached a full copy of the debug log too.  I hope this helps you 
> > narrow the issue down or otherwise let me know what to try next.
> > 
> >  NB I note that code you've been poking at only refers resources of the 
> > IORESOURCE_MEM type.  What about IORESOURCE_IO, which seems more relevant 
> > here?
> > 
> >  Also as a quick check I've now reconfigured the defxx driver for PCI port 
> > I/O (which is a one-liner; the mapping used to be selectable by hand, but 
> > distributions got it wrong for systems w/o PCI port I/O, so I switched the 
> > driver to an automatic choice a few years ago, but the logic remains):
> > 
> > # cat /proc/ioports
> > 00000000-0000ffff : pcie@e00000000
> >   00001000-00002fff : PCI Bus 0000:01
> >     00001000-00002fff : PCI Bus 0000:02
> >       00001000-00002fff : PCI Bus 0000:05
> >         00001000-00002fff : PCI Bus 0000:06
> >           00001000-00001fff : PCI Bus 0000:07
> >           00001000-00001007 : 0000:07:00.0
> >           00001000-00001002 : parport0
> >           00001003-00001007 : parport0
> >           00001008-0000100b : 0000:07:00.0
> >           00001008-0000100a : parport0
> >           00002000-00002fff : PCI Bus 0000:08
> >           00002000-00002fff : PCI Bus 0000:09
> >           00002000-000020ff : 0000:09:01.0
> >           00002100-0000217f : 0000:09:02.0
> >           00002100-0000217f : defxx
> > # 
> > 
> > and:
> > 
> > defxx 0000:09:02.0: assign IRQ: got 40
> > defxx: v1.12 2021/03/10  Lawrence V. Stefani and others
> > defxx 0000:09:02.0: enabling device (0000 -> 0003)
> > defxx 0000:09:02.0: enabling bus mastering
> > 0000:09:02.0: DEFPA at I/O addr = 0x2100, IRQ = 40, Hardware addr = 00-60-6d-xx-xx-xx
> > 0000:09:02.0: registered as fddi0
> > 
> > (as at commit 4660e50cf818) and likewise it has stopped working here from 
> > commit 0da48c5b2fa7 onwards:
> > 
> > defxx 0000:09:02.0: assign IRQ: got 40
> > defxx: v1.12 2021/03/10  Lawrence V. Stefani and others
> > defxx 0000:09:02.0: enabling device (0000 -> 0003)
> > defxx 0000:09:02.0: enabling bus mastering
> > 0000:09:02.0: Could not read adapter factory MAC address!
> > 
> > So it's definitely nothing specific to the parport driver, but rather a 
> > general issue with PCI/e port I/O not working anymore.  I do hope these 
> > observations will let you address the issue now.  You might be able to 
> > reproduce it with hardware you have available even.
> > 
> 
> Yes, looks like the I/O port access is not working with the CFG Shift feature.
> The spec says that both I/O and MEM TLPs should be handled by this feature, so
> we are currently unsure why MEM works, but not I/O.
> 
> The issue you reported with parport_pc driver is that the driver gets probed,
> but it fails to detect the parallel ports on the device. More precisely, it
> fails due to the parport_SPP_supported() check in drivers/parport/parport_pc.c.
> This function performs some read/write checks to make sure that the port exists,
> but most likely the read value doesn't match the written one. And since there is
> no log printed in this function, it just failed silently.
> 
> We will check why I/O access fails with ECAM mode and revert back asap. Since
> the merge window is now open, it becomes difficult to revert the CFG shift
> feature cleanly. The timing of the report also made it difficult to fix the
> issue in v6.18. Hopefully, we can backport the fix once we identify the culprit.
> 

Can you try the attached patch? It is a reworked version of Krishna's patch. I
just moved things around to check potential override issue.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

--4taha6h4y7ppae6c
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-PCI-qcom-Enable-iATU-mapping-for-memory-IO-regions.patch"

From b35d92c71d40d3f6471900372f73e07079f8ee34 Mon Sep 17 00:00:00 2001
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 28 Nov 2025 16:44:17 +0530
Subject: [PATCH] PCI: qcom: Enable iATU mapping for memory & IO regions

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 37 +++++++++++--------
 drivers/pci/controller/dwc/pcie-designware.c  |  3 ++
 drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
 3 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index e92513c5bda5..cffd66d51d02 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -36,6 +36,7 @@ static struct pci_ops dw_child_pcie_ops;
 
 #define IS_256MB_ALIGNED(x) IS_ALIGNED(x, SZ_256M)
 
+static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp);
 static const struct msi_parent_ops dw_pcie_msi_parent_ops = {
 	.required_flags		= DW_PCIE_MSI_FLAGS_REQUIRED,
 	.supported_flags	= DW_PCIE_MSI_FLAGS_SUPPORTED,
@@ -433,7 +434,7 @@ static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
 	 * Immediate bus under Root Bus, needs type 0 iATU configuration and
 	 * remaining buses need type 1 iATU configuration.
 	 */
-	atu.index = 0;
+	atu.index = pp->ob_atu_index;
 	atu.type = PCIE_ATU_TYPE_CFG0;
 	atu.parent_bus_addr = pp->cfg0_base + SZ_1M;
 	/* 1MiB is to cover 1 (bus) * 32 (devices) * 8 (functions) */
@@ -448,14 +449,20 @@ static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
 	if (bus_range_max < 2)
 		return 0;
 
+	pp->ob_atu_index++;
+
 	/* Configure remaining buses in type 1 iATU configuration */
-	atu.index = 1;
+	atu.index = pp->ob_atu_index;
 	atu.type = PCIE_ATU_TYPE_CFG1;
 	atu.parent_bus_addr = pp->cfg0_base + SZ_2M;
 	atu.size = (SZ_1M * bus_range_max) - SZ_2M;
 	atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;
 
-	return dw_pcie_prog_outbound_atu(pci, &atu);
+	ret = dw_pcie_prog_outbound_atu(pci, &atu);
+	if (!ret)
+		pp->ob_atu_index++;
+
+	return ret;
 }
 
 static int dw_pcie_create_ecam_window(struct dw_pcie_rp *pp, struct resource *res)
@@ -630,14 +637,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		goto err_free_msi;
 
-	if (pp->ecam_enabled) {
-		ret = dw_pcie_config_ecam_iatu(pp);
-		if (ret) {
-			dev_err(dev, "Failed to configure iATU in ECAM mode\n");
-			goto err_free_msi;
-		}
-	}
-
 	/*
 	 * Allocate the resource for MSG TLP before programming the iATU
 	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
@@ -942,7 +941,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
 			 pci->num_ob_windows);
 
-	pp->msg_atu_index = i;
+	pp->ob_atu_index = i;
 
 	i = 0;
 	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
@@ -1086,12 +1085,20 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 	 * the platform uses its own address translation component rather than
 	 * ATU, so we should not program the ATU here.
 	 */
-	if (pp->bridge->child_ops == &dw_child_pcie_ops) {
+	if (pp->bridge->child_ops == &dw_child_pcie_ops || pp->ecam_enabled) {
 		ret = dw_pcie_iatu_setup(pp);
 		if (ret)
 			return ret;
 	}
 
+	if (pp->ecam_enabled) {
+		ret = dw_pcie_config_ecam_iatu(pp);
+		if (ret) {
+			dev_err(pci->dev, "Failed to configure iATU in ECAM mode\n");
+			return ret;
+		}
+	}
+
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
 
 	/* Program correct class for RC */
@@ -1113,7 +1120,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 	void __iomem *mem;
 	int ret;
 
-	if (pci->num_ob_windows <= pci->pp.msg_atu_index)
+	if (pci->num_ob_windows <= pci->pp.ob_atu_index)
 		return -ENOSPC;
 
 	if (!pci->pp.msg_res)
@@ -1123,7 +1130,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 	atu.routing = PCIE_MSG_TYPE_R_BC;
 	atu.type = PCIE_ATU_TYPE_MSG;
 	atu.size = resource_size(pci->pp.msg_res);
-	atu.index = pci->pp.msg_atu_index;
+	atu.index = pci->pp.ob_atu_index;
 
 	atu.parent_bus_addr = pci->pp.msg_res->start - pci->parent_bus_offset;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index c644216995f6..d27b469b417b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -478,6 +478,9 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 
 	limit_addr = parent_bus_addr + atu->size - 1;
 
+	if (atu->index > pci->num_ob_windows)
+		return -ENOSPC;
+
 	if ((limit_addr & ~pci->region_limit) != (parent_bus_addr & ~pci->region_limit) ||
 	    !IS_ALIGNED(parent_bus_addr, pci->region_align) ||
 	    !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->size) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index e995f692a1ec..69d0bd8b3c57 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -423,8 +423,8 @@ struct dw_pcie_rp {
 	struct pci_host_bridge  *bridge;
 	raw_spinlock_t		lock;
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
+	int			ob_atu_index;
 	bool			use_atu_msg;
-	int			msg_atu_index;
 	struct resource		*msg_res;
 	bool			use_linkup_irq;
 	struct pci_eq_presets	presets;
-- 
2.48.1


--4taha6h4y7ppae6c--

