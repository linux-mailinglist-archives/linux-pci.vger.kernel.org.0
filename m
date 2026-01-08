Return-Path: <linux-pci+bounces-44269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 75948D02A65
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 13:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CB2F3104028
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 12:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD1F3ECBFB;
	Thu,  8 Jan 2026 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvwyTXDG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A6B3C0092;
	Thu,  8 Jan 2026 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767865062; cv=none; b=rm3bOoz4Rp3q30ACRmIW+EmjCavW7WMVI0XPKDQdOa8ptjzgBwT3lOLmNnBqSn932hcUXTNfTFTQUdPw1Y9V4caVK+C3+n2VMjW/YMSscglQmUxQwq7/uM+rYo48WDwxE564eow+tHvmrBAnb/P4NoCLF6pvlEmry99xVdqxNLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767865062; c=relaxed/simple;
	bh=3BE7IiWT5ZKp/+ptUtREs0Q3bes4WcCBm+hrYp/Emdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blkEp6uPvJ4VRtdQ13Wt7n0tmhHSyIghPTFL3KftbAQGooAF1JUHRxzd8cn3zEbQKX7MJPn8lb6ROpFl99NhiXdkNAw1Syxej4qsmb+yZEPCEjyAPJuLxfnF98XSlPzvdIAOGw2P5eSOqtQbrFY0M72nZh7p7wFgDcyL4Q/kPPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvwyTXDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44164C116C6;
	Thu,  8 Jan 2026 09:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767865060;
	bh=3BE7IiWT5ZKp/+ptUtREs0Q3bes4WcCBm+hrYp/Emdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RvwyTXDGWFnXkkyP/wDY62Fk/TUFDrNXE9LksZzAw+SviW8UiLIyORo20rySKHHEc
	 2qLWN1S6f72EMYEj5xMfs/68cZv+jNDkh3VZZiPv+MHAKZ8kGmS1A0/507lpfq5NJw
	 7ZYRSUeX28cqt815DLLjSF+YZuzP4blS04rRl+Q52ryZbnkbPMISBF8DyT0hx/HS+1
	 9Xf3tDF5DJ+gB2L5uS9bMhBeXRLxLw6DY+0eqD1KOiiYWPSGQ2t5iNTIDFVlVRCE7m
	 2Z17alQvmQ7exkyogGQWiHLM9bwpt3pent+dAvpYpAEwNPaJDRC2p3bR2ZfA1SJBC4
	 RGdb6jPSLgRbQ==
Date: Thu, 8 Jan 2026 10:37:35 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	Frank.Li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] PCI: endpoint: Add BAR subrange mapping support
Message-ID: <aV9638ebwqc4bsbd@ryzen>
References: <20260108044148.2352800-1-den@valinux.co.jp>
 <20260108044148.2352800-2-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108044148.2352800-2-den@valinux.co.jp>

On Thu, Jan 08, 2026 at 01:41:47PM +0900, Koichiro Den wrote:
> Extend the PCI endpoint core to support mapping subranges within a BAR.
> Introduce a new 'submap' field and a 'use_submap' flag in struct
> pci_epf_bar so an endpoint function driver can request inbound mappings
> that fully cover the BAR.
> 
> The submap array describes the complete BAR layout (no overlaps and no
> gaps are allowed to avoid exposing untranslated address ranges). This
> provides the generic infrastructure needed to map multiple logical
> regions into a single BAR at different offsets, without assuming a
> controller-specific inbound address translation mechanism. Also, the
> array must be sorted in ascending order by offset.
> 
> No controller-specific implementation is added in this commit.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

What I don't really like is that you don't have any checks at all in:
pci_epc_set_bar() if the controller actually supports the submap feature.

AFAICT, for non-DWC drivers, e.g.:
drivers/pci/controller/cadence/pcie-cadence-ep.c
drivers/pci/controller/pcie-rcar-ep.c
drivers/pci/controller/pcie-rockchip-ep.c

They have no idea about submapping, so they will silently ignore
pci_epf_bar.use_submap.

I think that we should somehow expose that an EndPoint Controller(EPC)
supports the submap feature.

That way pci_epc_set_bar() can return an error for an EPC that does not
support it.

Perhaps something like:

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 1195d401df19..b8eb069f6d57 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -622,15 +622,26 @@ static int dw_pcie_ep_start(struct pci_epc *epc)
 	return dw_pcie_start_link(pci);
 }
 
+static struct pci_epc_features dw_pcie_ep_features;
+
 static const struct pci_epc_features*
 dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+	const struct pci_epc_features *glue_epc_features;
 
 	if (!ep->ops->get_features)
 		return NULL;
 
-	return ep->ops->get_features(ep);
+	glue_epc_features = ep->ops->get_features(ep);
+
+	memcpy(&dw_pcie_ep_features, glue_epc_features,
+	       sizeof(dw_pcie_ep_features));
+
+	/* All DWC based glue drivers support inbound subrange mapping */
+	dw_pcie_ep_features.subrange_mapping = true;
+
+	return &dw_pcie_ep_features;
 }
 
 static const struct pci_epc_ops epc_ops = {
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index ca7f19cc973a..8804daaf8376 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -596,6 +596,9 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	if (!epc_features)
 		return -EINVAL;
 
+	if (epf_bar->flags && !epc_features->subrange_mapping)
+		return -EINVAL;
+
 	if (epc_features->bar[bar].type == BAR_RESIZABLE &&
 	    (epf_bar->size < SZ_1M || (u64)epf_bar->size > (SZ_128G * 1024)))
 		return -EINVAL;
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 4286bfdbfdfa..898a29e7d6f7 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -223,6 +223,8 @@ struct pci_epc_bar_desc {
 /**
  * struct pci_epc_features - features supported by a EPC device per function
  * @linkup_notifier: indicate if the EPC device can notify EPF driver on link up
+ * @subrange_mapping: indicate if the EPC device can map inbound subranges for a
+ *                    BAR
  * @msi_capable: indicate if the endpoint function has MSI capability
  * @msix_capable: indicate if the endpoint function has MSI-X capability
  * @intx_capable: indicate if the endpoint can raise INTx interrupts
@@ -231,6 +233,7 @@ struct pci_epc_bar_desc {
  */
 struct pci_epc_features {
 	unsigned int	linkup_notifier : 1;
+	unsigned int	subrange_mapping : 1;
 	unsigned int	msi_capable : 1;
 	unsigned int	msix_capable : 1;
 	unsigned int	intx_capable : 1;



The memcpy in dw_pcie_ep_get_features() is a bit ugly.
I guess the alternative is to change all the DWC based glue drivers
to return a "struct pci_epc_features*" instead of a "const struct pci_epc_features*"
such that dw_pcie_ep_get_features() can simply set subrange_mapping = true in the
struct pci_epc_features returned by the glue driver.


Kind regards,
Niklas

