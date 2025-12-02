Return-Path: <linux-pci+bounces-42475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BE4C9B584
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 12:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97B63A6174
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 11:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D30F31076B;
	Tue,  2 Dec 2025 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWPsL1ju"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082A2296BA5;
	Tue,  2 Dec 2025 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764675886; cv=none; b=ia26F42vqfSPv7VO5CF011+ORZNUAWYd79vv2guH33zBFhLC0ybD/CMOSz4r+KxCW+aiPGFFICIQ+T/KPhID9y7CH29vlfodX0YZBhsWiZ13MgRmcJM4/g0o7S2gHL5Rn151aNPDBjt/w6jHxAeUcngkYpo43Fho2LqSEFj6RPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764675886; c=relaxed/simple;
	bh=A2OtBjHKMPsv5ieu0X0QAARKlZkIcWNozF8zp2T2n7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQ0QxSkuzTe8JlZBZvDKBJwVllHLmrlB9MgY64k6jRfi1EY48VHKkeEF9ks8K54iKWykUfj2UnVm9ZpknkeZl3ZgW2GZNKP33VElCjIE71He6K0MxEddRAxxQJAvB/s+anR7qd1G+RyQaFGFyOJTu7H/s4myxLH3bQF3jcHsjME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWPsL1ju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E566C4CEF1;
	Tue,  2 Dec 2025 11:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764675885;
	bh=A2OtBjHKMPsv5ieu0X0QAARKlZkIcWNozF8zp2T2n7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XWPsL1juzkH3Cy///Ny5yKw9iel0mf0OoPe7j9SDtdwUYKGAqWZTLKIL+6DIganYy
	 rboC8MZXuN2GKqELrn9+ubeSNSZF+aXY7SUfNuPAf5CEwj3tkMAWQuRBTcRcKemsiN
	 hEhqNdJUuKmqq+gDN8y5XNBvvS24gCT8JszlIjNz6SW+y+KfaA9wjJMdMHg7Gbe4J4
	 MjNKDTsgoSV2ZMxRO3y06JdAi4gaM4+HxFKFIY2MuXHdThj5i0eG1jY7DvYmn4G7qG
	 WHN8Diy6D5uTFusOcg8mDMs7MQUnvqge8y3jk2zGUghVC5HWetCsknCUxEkG2ekQsg
	 ZWv9UFaYK5Dew==
Date: Tue, 2 Dec 2025 17:14:31 +0530
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
Message-ID: <ps5jjiqv5mw2g3exzvfcfsa4bcda7hois2h6riarwb2d2son4u@2onu4bibw2hb>
References: <alpine.DEB.2.21.2511280256260.36486@angie.orcam.me.uk>
 <c7aea2b3-6984-40f5-8234-14d265dabefc@oss.qualcomm.com>
 <alpine.DEB.2.21.2511280755440.36486@angie.orcam.me.uk>
 <cabf4c20-095b-4579-adc1-146a566b19b9@oss.qualcomm.com>
 <alpine.DEB.2.21.2511281714030.36486@angie.orcam.me.uk>
 <a4c6d47f-28b5-40d3-bc82-10aeb14f8e78@oss.qualcomm.com>
 <alpine.DEB.2.21.2511290428340.36486@angie.orcam.me.uk>
 <h7pgm3lqolm53sb4wrcpcurk4ghz4tulqnr7vgd7rzxy4hscue@jcn5tepevlwl>
 <syg7vpbt3w53s24hgl7b6w64odmif5bq557lwlvzlbvgkukwcn@66jtzzc3vtiu>
 <alpine.DEB.2.21.2512011617250.49654@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3my6bnxaowecwlhh"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.2512011617250.49654@angie.orcam.me.uk>


--3my6bnxaowecwlhh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Dec 01, 2025 at 04:42:42PM +0000, Maciej W. Rozycki wrote:
> On Mon, 1 Dec 2025, Manivannan Sadhasivam wrote:
> 
> > > > So it's definitely nothing specific to the parport driver, but rather a 
> > > > general issue with PCI/e port I/O not working anymore.  I do hope these 
> > > > observations will let you address the issue now.  You might be able to 
> > > > reproduce it with hardware you have available even.
> > > > 
> > > 
> > > Yes, looks like the I/O port access is not working with the CFG Shift feature.
> > > The spec says that both I/O and MEM TLPs should be handled by this feature, so
> > > we are currently unsure why MEM works, but not I/O.
> 
>  As I say, last time I checked (for another reason) documentation was not 
> available to the general public, so I can't help with that.
> 

Sure. I know that the DWC documentation is well secured behind firewalls. So not
asking for help here.

> > > The issue you reported with parport_pc driver is that the driver gets probed,
> > > but it fails to detect the parallel ports on the device. More precisely, it
> > > fails due to the parport_SPP_supported() check in drivers/parport/parport_pc.c.
> > > This function performs some read/write checks to make sure that the port exists,
> > > but most likely the read value doesn't match the written one. And since there is
> > > no log printed in this function, it just failed silently.
> 
>  Whatever the exact transaction conditions are port I/O TLPs seem not to 
> make it through to the requested target device anymore.
> 
>  FWIW the defxx driver issues a command to the device's command register 
> and wants to see a successful completion status in the status register 
> before retrieving the MAC address via the data register.  So it's not a 
> simple case of poking at a register and reading it back, but the end 
> result is the same: the device cannot be talked to.
> 
> > > We will check why I/O access fails with ECAM mode and revert back asap. Since
> > > the merge window is now open, it becomes difficult to revert the CFG shift
> > > feature cleanly. The timing of the report also made it difficult to fix the
> > > issue in v6.18. Hopefully, we can backport the fix once we identify the culprit.
> 
>  No worries, I've been around for long enough (short of 30 years) to know 
> the process.
> 
>  FWIW the original change would've best been reverted for 6.18 as a fatal 
> regression, however port I/O is uncommon enough nowadays we can defer any 
> final decision to 6.19 I suppose.  I'm glad I've tripped over this in the 
> first place as I'm not eager to upgrade all my lab devices all the time, 
> and it was owing to another issue only that I chose this moment to move 
> forward, not so long after the original commit.
> 
> > Can you try the attached patch? It is a reworked version of Krishna's patch. I
> > just moved things around to check potential override issue.
> 
>  No change in behaviour, sorry.  I suppose it's this range of host address 
> decoding:
> 
> fu740-pcie e00000000.pcie:       IO 0x0060080000..0x006008ffff -> 0x0060080000
> 
> aka:
> 
> pci_bus 0000:00: root bus resource [io  0x0000-0xffff] (bus address [0x60080000-0x6008ffff])
> 
> that you're after.  Are you sure your code discovers it correctly?  As I 
> say I can only see IORESOURCE_MEM references and no IORESOURCE_IO ones as 
> would be appropriate for the root bus resource quoted.
> 

The I/O resource is discovered by the driver correctly as seen from the logs:

pci_bus 0000:00: root bus resource [io  0x0000-0xffff] (bus address [0x60080000-0x6008ffff])
pci_bus 0000:00: root bus resource [mem 0x60090000-0x7fffffff]
pci_bus 0000:00: root bus resource [mem 0x2000000000-0x3fffffffff pref]

But we believe that the iATU is not programmed for the I/O port, resulting in
the I/O access not going out to the device.

Krishna found an issue in the previous patch that got shared. So I've attached a
new one. Could you please try and let us know? If it didn't help, please share
the dmesg log that will have some more info.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

--3my6bnxaowecwlhh
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-PCI-qcom-Enable-iATU-mapping-for-memory-IO-regions.patch"

From 5acab1289f8fd20ecead7c517e7e282584946ff0 Mon Sep 17 00:00:00 2001
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 28 Nov 2025 16:44:17 +0530
Subject: [PATCH] PCI: qcom: Enable iATU mapping for memory & IO regions

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 42 ++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.c  |  3 ++
 drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
 3 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index e92513c5bda5..d977bb92cf3b 100644
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
@@ -919,6 +918,8 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		}
 	}
 
+	dev_info(pci->dev, "%s: %d MEM index: %d", __func__, __LINE__, i);
+
 	if (pp->io_size) {
 		if (pci->num_ob_windows > ++i) {
 			atu.index = i;
@@ -936,13 +937,16 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		} else {
 			pp->cfg0_io_shared = true;
 		}
+
+		dev_info(pci->dev, "%s: %d I/O index: %d", __func__, __LINE__, i);
 	}
 
 	if (pci->num_ob_windows <= i)
 		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
 			 pci->num_ob_windows);
 
-	pp->msg_atu_index = i;
+	pp->ob_atu_index = ++i;
+	dev_info(pci->dev, "%s: %d Final index: %d", __func__, __LINE__, i);
 
 	i = 0;
 	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
@@ -1086,12 +1090,20 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
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
@@ -1113,7 +1125,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 	void __iomem *mem;
 	int ret;
 
-	if (pci->num_ob_windows <= pci->pp.msg_atu_index)
+	if (pci->num_ob_windows <= pci->pp.ob_atu_index)
 		return -ENOSPC;
 
 	if (!pci->pp.msg_res)
@@ -1123,7 +1135,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
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


--3my6bnxaowecwlhh--

