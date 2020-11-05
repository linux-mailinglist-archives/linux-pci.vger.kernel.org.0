Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABC92A88B5
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 22:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731954AbgKEVM1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 16:12:27 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40975 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732367AbgKEVM1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2020 16:12:27 -0500
Received: by mail-oi1-f194.google.com with SMTP id m13so3162684oih.8
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2020 13:12:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5hcZakSJUhRFvjna18Ua4O/OJhqtOUdxfTzHnucmOj8=;
        b=bl94ZV/5EqESlFFYlE4ZRUWBMYnwkSG7faHFQz7IefD4pvaSZunmReBdtZ7sseGjjZ
         Yo38+gXVfvBWSbreaYYlTEHBUQnb2zKMYkz53yqy288MKaY28wlHQ/4p4E0uyMJQ813Q
         W2JD9bt3VItRtHFcQUM46YqW/x4KFH+VlegKZ+y3CMXFAlHPV/RYYti5Ccj1+W7bi5fC
         8He9qT/hlATV2et5nFFO4i/F/RCcY02HD24IHHNctQpkPO63e9qi75FUtUIuhSoupUyJ
         rRIF9yxV1P+qtnoPOgq9Vzdf+4dF2QMSFUaYfjI7DO4RRdY1+t3W+YxEdhd+A96HpBJp
         wJzg==
X-Gm-Message-State: AOAM532hX6F45+d2Bwws3TYtzcJlu9jU7aQ26M4irR+4jTkmCqBdxRmJ
        0M3up9tbOwy6hiBgiljwqsWfSXzWwDwl
X-Google-Smtp-Source: ABdhPJxdDzfSB3qfZ3bJyaFVJMx+eCkG/JO3NAT2SigMzFeAAr+hJuX1TQG4CufqggpkGTSna2RuQQ==
X-Received: by 2002:aca:4257:: with SMTP id p84mr897507oia.176.1604610746448;
        Thu, 05 Nov 2020 13:12:26 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id z19sm622549ooi.32.2020.11.05.13.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 13:12:25 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 15/16] PCI: dwc: Move inbound and outbound windows to common struct
Date:   Thu,  5 Nov 2020 15:11:58 -0600
Message-Id: <20201105211159.1814485-16-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105211159.1814485-1-robh@kernel.org>
References: <20201105211159.1814485-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The number of inbound and outbound windows are defined by the h/w and
apply to both RC and EP modes, so move them to the appropriate struct.

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - new patch

 .../pci/controller/dwc/pcie-designware-ep.c   | 25 ++++++++++---------
 drivers/pci/controller/dwc/pcie-designware.h  |  4 +--
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 6fe176e1bdd2..79b998982e41 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -161,8 +161,8 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no,
 	u32 free_win;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);

-	free_win = find_first_zero_bit(ep->ib_window_map, ep->num_ib_windows);
-	if (free_win >= ep->num_ib_windows) {
+	free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
+	if (free_win >= pci->num_ib_windows) {
 		dev_err(pci->dev, "No free inbound window\n");
 		return -EINVAL;
 	}
@@ -187,8 +187,8 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
 	u32 free_win;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);

-	free_win = find_first_zero_bit(ep->ob_window_map, ep->num_ob_windows);
-	if (free_win >= ep->num_ob_windows) {
+	free_win = find_first_zero_bit(ep->ob_window_map, pci->num_ob_windows);
+	if (free_win >= pci->num_ob_windows) {
 		dev_err(pci->dev, "No free outbound window\n");
 		return -EINVAL;
 	}
@@ -264,8 +264,9 @@ static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
 			      u32 *atu_index)
 {
 	u32 index;
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);

-	for (index = 0; index < ep->num_ob_windows; index++) {
+	for (index = 0; index < pci->num_ob_windows; index++) {
 		if (ep->outbound_addr[index] != addr)
 			continue;
 		*atu_index = index;
@@ -713,41 +714,41 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	ep->phys_base = res->start;
 	ep->addr_size = resource_size(res);

-	ret = of_property_read_u32(np, "num-ib-windows", &ep->num_ib_windows);
+	ret = of_property_read_u32(np, "num-ib-windows", &pci->num_ib_windows);
 	if (ret < 0) {
 		dev_err(dev, "Unable to read *num-ib-windows* property\n");
 		return ret;
 	}
-	if (ep->num_ib_windows > MAX_IATU_IN) {
+	if (pci->num_ib_windows > MAX_IATU_IN) {
 		dev_err(dev, "Invalid *num-ib-windows*\n");
 		return -EINVAL;
 	}

-	ret = of_property_read_u32(np, "num-ob-windows", &ep->num_ob_windows);
+	ret = of_property_read_u32(np, "num-ob-windows", &pci->num_ob_windows);
 	if (ret < 0) {
 		dev_err(dev, "Unable to read *num-ob-windows* property\n");
 		return ret;
 	}
-	if (ep->num_ob_windows > MAX_IATU_OUT) {
+	if (pci->num_ob_windows > MAX_IATU_OUT) {
 		dev_err(dev, "Invalid *num-ob-windows*\n");
 		return -EINVAL;
 	}

 	ep->ib_window_map = devm_kcalloc(dev,
-					 BITS_TO_LONGS(ep->num_ib_windows),
+					 BITS_TO_LONGS(pci->num_ib_windows),
 					 sizeof(long),
 					 GFP_KERNEL);
 	if (!ep->ib_window_map)
 		return -ENOMEM;

 	ep->ob_window_map = devm_kcalloc(dev,
-					 BITS_TO_LONGS(ep->num_ob_windows),
+					 BITS_TO_LONGS(pci->num_ob_windows),
 					 sizeof(long),
 					 GFP_KERNEL);
 	if (!ep->ob_window_map)
 		return -ENOMEM;

-	addr = devm_kcalloc(dev, ep->num_ob_windows, sizeof(phys_addr_t),
+	addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
 			    GFP_KERNEL);
 	if (!addr)
 		return -ENOMEM;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 57326aebc6e1..e4f964e6cabe 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -236,8 +236,6 @@ struct dw_pcie_ep {
 	phys_addr_t		*outbound_addr;
 	unsigned long		*ib_window_map;
 	unsigned long		*ob_window_map;
-	u32			num_ib_windows;
-	u32			num_ob_windows;
 	void __iomem		*msi_mem;
 	phys_addr_t		msi_mem_phys;
 	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
@@ -263,6 +261,8 @@ struct dw_pcie {
 	/* Used when iatu_unroll_enabled is true */
 	void __iomem		*atu_base;
 	u32			num_viewport;
+	u32			num_ib_windows;
+	u32			num_ob_windows;
 	struct pcie_port	pp;
 	struct dw_pcie_ep	ep;
 	const struct dw_pcie_ops *ops;
--
2.25.1
