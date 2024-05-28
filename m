Return-Path: <linux-pci+bounces-7894-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA528D1C0F
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 15:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EE0C287717
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 13:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398D913D61E;
	Tue, 28 May 2024 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvuTwEpP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E6216D9AC
	for <linux-pci@vger.kernel.org>; Tue, 28 May 2024 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716901253; cv=none; b=kN3YjBpaGAl2/eAx7A7doNBkPqG1xzcZ4sdePhZJiAdOgNgjwW9fToJuW8/4LUp6egcTkFBoVH7oxywaGSlfU4WzGPTxDr3xKjSNpGiYLN6quV9Dj1aBhYxwaRH1xwcmLRU3eDU3MMIL5CWIvbcQOMVDfufy7g2uVt7aRJzjAiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716901253; c=relaxed/simple;
	bh=rTKDOORCHsiuFawhjGRKxRI14XmNpYQLaB2TyDJOugg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqFylcdc2FU/keX0uAY2WA0cbc96QjpLZetPGrHjNR6+qCktaITMD1ejLJ1oepFKUnxmrOyuqBFIKPQTfMAT71bP2cAdcikpAqzoHz3F5SdEplLZo0YmVb9k1G7ClestR5jUtvq3hW5J/aAdisX2NrE3ovdHnfPQ/1RvaPqCaWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvuTwEpP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9939CC4AF12;
	Tue, 28 May 2024 13:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716901252;
	bh=rTKDOORCHsiuFawhjGRKxRI14XmNpYQLaB2TyDJOugg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DvuTwEpPNllONSJXNQGvh+VjoW2+QSDLbe01iEyKBmwK2yM9NPWYsF/aGW09tPJqY
	 zfYyd8Lt7w0fw6dTp6TNpOPTHGeYIB9McMtxw9CHpPznWRnImbUDLSSkrosueN0EQu
	 bbdaMi0Dhi430DiGuwMrL737XDaCx0ic0YJ4eFQIFs2tlLYMji5qcyoip0IqoT8Cj9
	 TPvNuu75uBsHAw9ju/9XTe9HwFNAb+aB6lB9etTwTQz1sr7P7zbmHy0wg48tpLAVl0
	 V2lFyo3sI8Jr4Dv4jfaiICvwoJfk9LZoMClFgJ2sVXKBGgo4kkZ1OhRdeh4tCWvNPB
	 DzCte/Wvx72oQ==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH 1/3] PCI: dwc: ep: Add dw_pcie_ep_deinit_notify()
Date: Tue, 28 May 2024 15:00:37 +0200
Message-ID: <20240528130035.1472871-6-cassel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528130035.1472871-5-cassel@kernel.org>
References: <20240528130035.1472871-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2320; i=cassel@kernel.org; h=from:subject; bh=rTKDOORCHsiuFawhjGRKxRI14XmNpYQLaB2TyDJOugg=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJCr5YcFtda8fo8z6Pjmxxeemaqxq7J9hP7OWfW9I7fb G+/Sqzz6ShlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBE0n8x/C+r2vkoQdgnbOW+ 8rjXDxUeRZ2TEnBLv39dT0Dl9V4OvlUM/2vbt82+z+65RystfmGM/mmbqMn8BU1/08WvPfy9SGu xAR8A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Add a DWC specific wrapper function (dw_pcie_ep_deinit_notify()) around
pci_epc_deinit_notify(), similar to how we have a wrapper function
(dw_pcie_ep_init_notify()) around pci_epc_init_notify().

This will allow the DWC glue drivers to use the same API layer for init
and deinit notification.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 13 +++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h    |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 2063cf2049e5..3c9079651dff 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -39,6 +39,19 @@ void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_init_notify);
 
+/**
+ * dw_pcie_ep_deinit_notify - Notify EPF drivers about EPC deinitialization
+ *			      complete
+ * @ep: DWC EP device
+ */
+void dw_pcie_ep_deinit_notify(struct dw_pcie_ep *ep)
+{
+	struct pci_epc *epc = ep->epc;
+
+	pci_epc_deinit_notify(epc);
+}
+EXPORT_SYMBOL_GPL(dw_pcie_ep_deinit_notify);
+
 /**
  * dw_pcie_ep_get_func_from_ep - Get the struct dw_pcie_ep_func corresponding to
  *				 the endpoint function
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f8e5431a207b..dc63f764b8ba 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -672,6 +672,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep);
 void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep);
 void dw_pcie_ep_deinit(struct dw_pcie_ep *ep);
+void dw_pcie_ep_deinit_notify(struct dw_pcie_ep *ep);
 void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep);
 int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no);
 int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
@@ -706,6 +707,10 @@ static inline void dw_pcie_ep_deinit(struct dw_pcie_ep *ep)
 {
 }
 
+static inline void dw_pcie_ep_deinit_notify(struct dw_pcie_ep *ep)
+{
+}
+
 static inline void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
 {
 }
-- 
2.45.1


