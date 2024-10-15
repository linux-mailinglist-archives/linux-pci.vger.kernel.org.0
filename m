Return-Path: <linux-pci+bounces-14515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D0699DEA9
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 08:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415081C20F35
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 06:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C1216C6B7;
	Tue, 15 Oct 2024 06:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaZyvqTn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9BA4D8DA
	for <linux-pci@vger.kernel.org>; Tue, 15 Oct 2024 06:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728974841; cv=none; b=WCVvnVUSWjskhW2Ffeth2uKGbqVMeEcHdLTOYD3DtEfNLp+upJXcTAAMuSr58+wGufyFtER80GE57OkYXbu/lkw/oa7uOKc1Rzaj6n/MpG8FmXyjW9zOPX/2Eu6bgRVRoq/su2PS/Kcxlnfmbf7gy4LFEX8unOewLhzzgJgKOpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728974841; c=relaxed/simple;
	bh=1y+clsIEVDpx4uritX9t9raGIuW+tu51iQs7hz6Dvf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eWh2B1xALrWBGjueoTUWdl25MGOr+4hCUEBm8hV7ZWwx3fTfLRv7exd5ngkHnuoiyiObKm0Tr0U0aqxnzusppfSaWiIREEIb+gwYSO2k0QrBk9Dya3dpslg97s4jIBteUbJN/JAlQOv0wgLea9tuwOmVaJQUCMiwYHsMfmumWl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XaZyvqTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF70C4CEC7;
	Tue, 15 Oct 2024 06:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728974841;
	bh=1y+clsIEVDpx4uritX9t9raGIuW+tu51iQs7hz6Dvf8=;
	h=From:To:Cc:Subject:Date:From;
	b=XaZyvqTn0224noLci9vWVT62TxcZitj0I6QyIc5mwcSzh58FbQiqEuCqueVU8knN4
	 IZyNOtR6fY9ZwMcZvGAuvXjhKbCCzdaS+hWR2Diw4FcIpzi3cNUPeyrI8qchXzcCYO
	 ggdpIsdZItM2V58+4GbjuonEhYoqvshZ1Mx8XANj1J/z3Oqam6ALoJ9foCtXMoHP9i
	 5hWcmS1ZYxCObdCO5FoD/HP7k6zeC3Fnn6fxp/WEGscJIvGI4Hu5JWURk9TDAFo8OC
	 OEGgmikNrYEzSqPIeIu0LSe3ymUzC/6/UApnebCr9KTkTNoWxjjuCxp3vtfLCLhGJ8
	 2lQHs70eBcrgw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>,
	linux-pci@vger.kernel.org
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] PCI: endpoint: Improve pci_epc_ops::align_addr() interface
Date: Tue, 15 Oct 2024 15:47:18 +0900
Message-ID: <20241015064718.111952-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCI endpoint controller operation interface for the align_addr()
operation uses the phys_addr_t type for the PCI address argument and
return a value using this type. This is not ideal as PCI addresses are
bus addresses, not memory physical addresses. Replace the use of
phys_addr_t for this operation with the generic u64 type. To be
consistent with this change the Designware driver implementation of this
operation (function dw_pcie_ep_align_addr()) is also changed.

Fixes: e98c99e2ccad ("PCI: endpoint: Introduce pci_epc_mem_map()/unmap()")
Fixes: cb6b7158fdf5 ("PCI: dwc: endpoint: Implement the pci_epc_ops::align_addr() operation")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 6 +++---
 include/linux/pci-epc.h                         | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 0ada60487c25..df1460ed63d9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -268,12 +268,12 @@ static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
 	return -EINVAL;
 }
 
-static phys_addr_t dw_pcie_ep_align_addr(struct pci_epc *epc,
-			phys_addr_t pci_addr, size_t *pci_size, size_t *offset)
+static u64 dw_pcie_ep_align_addr(struct pci_epc *epc, u64 pci_addr,
+				 size_t *pci_size, size_t *offset)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
-	phys_addr_t mask = pci->region_align - 1;
+	u64 mask = pci->region_align - 1;
 	size_t ofst = pci_addr & mask;
 
 	*pci_size = ALIGN(ofst + *pci_size, ep->page_size);
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index f4b8dc37e447..ff208fd4526b 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -93,8 +93,8 @@ struct pci_epc_ops {
 			   struct pci_epf_bar *epf_bar);
 	void	(*clear_bar)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			     struct pci_epf_bar *epf_bar);
-	phys_addr_t (*align_addr)(struct pci_epc *epc, phys_addr_t pci_addr,
-				  size_t *size, size_t *offset);
+	u64	(*align_addr)(struct pci_epc *epc, u64 pci_addr, size_t *size,
+			      size_t *offset);
 	int	(*map_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			    phys_addr_t addr, u64 pci_addr, size_t size);
 	void	(*unmap_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
-- 
2.47.0


