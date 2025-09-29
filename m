Return-Path: <linux-pci+bounces-37195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 869EDBA9114
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 13:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7C53C70A9
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 11:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FF93019DE;
	Mon, 29 Sep 2025 11:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDg4tRWN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6397301715
	for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 11:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145904; cv=none; b=XmQhJeRhGp4//JPaGSegg6ATQeXpM2WBClo4Apk3XkoqIjgveAqSTqZGmj19yveLgud/SD0/tg4RLE/sEjLrwp1qRQzWGlWE+Nu6t2y6Pz7HMYgryUxkgRKqspzDdrqcbTIDZuaF1aL7AuFlVAsylJu5EOaouhdiOpzlu8p/hAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145904; c=relaxed/simple;
	bh=OuzlMBf2DYxUrGozGqCnGqXutFM3aRqod7/0oO6AhUE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOuLVLM7KJNwXF35F5NlU9eulNKQ3IvO7J8sbR6X6prOXHGX8+kXAtQT4SnNLtVrl3WNwgOOZ/TTWn9mwVEgOsB1MtncFxrOD90TqI3sligG94654lJuZRyE/qiLANHlO2Sp3Thg0NQ3WV5LnXNk6v0aCsoJMpfW4JO/5EVt9HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDg4tRWN; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e2e6a708fso29234755e9.0
        for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 04:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759145901; x=1759750701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3LU04oH6Jeu7LPnO6lTLYJu+6qHSNvnAGZMQiBqSTLE=;
        b=cDg4tRWNlagFMKq37giuUe8paoEMsdJzfqj5yqjtUm+vHz1Oyr6GKuKSVYusQ1ldqF
         1fFTOG5vky8NLD6170RjsR2CG5P/5vV80nWCUoV4Xq4CXUsymPO/6ZzXSCAjxcOOFBHs
         z59DyiKFx0V3HlDd5Qpf09NcM0CE+v3YRzoU62VpaKtvD//L42HPF6xO+S3xhBswl6b2
         sRlUL5F86XW+j2LYcdyxQx09rxTQ66Gv574PT+uarL/o/0P0pkSU09goo8lgaOcp3f4y
         7HyWyg8TG2rLnzfvTYCfweg+jdd5TC0Hw9G84sRUswxo7JVg+wX0QhtF0Cq8RCkiQgvx
         d/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759145901; x=1759750701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LU04oH6Jeu7LPnO6lTLYJu+6qHSNvnAGZMQiBqSTLE=;
        b=w9mF7KGHmGRg+gK5cdk4zC+EyrsgQPKLgmzjBXBSsRgRTsRGRVwYONgcs8Jxokjr+k
         MPUgIHjDfznoHv7cpqsuFCk4pQnJ58zk9oeeRTl2NzC96272xo3N2CQFWwJ9nG0g04lP
         953Ds7CrNd9BwswPP3RS7hWsSytSNHdlJ2LeAn1qg8/U9Q4tQF0lbiX0QTYAzpoy3dYr
         uPUGjjvuuCaPY8wcQTBnF5qoUIqoeMTdSc15/ZO2+LPDZeyaZ1OhKqPhMgXpKWjv5J5A
         XY/h7NgAR6W+pP4JMOEvu6LD+VpcbCuDg1BuiorlDqfFW/eT69O+6V1qrC2wNCdbwQIK
         gieQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHV9lgvRKhQaGlGjfD9d3wKBWfEq8s3c3A90zE5AlVzhiCQCE+EyvtUvLqtMY5ILSApubHyOfxr5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQsGEnCr2y22KmzYhBBbir/y4wNaqMGbaJCj/3J4o7L04MBqA2
	LzAoa2c11l7WrpD7hBFwPQqiZqw9evFVoAC8dNII7JS54rAm/w9Y/VyQ
X-Gm-Gg: ASbGnctDLWLlEMn3m1jO0YiJj9uTLqWrhyQmZ+46VH4j+lTF8LXwdzWzveEjJ2FF+nK
	kr49A9OlTOl+rU3O7SapVuZX9nRZWjawXT3b5MHE2E9ZQTTmHhgqu6R69TfkUb9zyABZK2tAE8w
	W1p665yHTHKT9IfpdCQqD1afi6ixlQana5OT/7IOCT9DhfEP2c7qd1BhtuxF1y0Y0HaHCMdDBUv
	WOyc+42XAkkfcCECC9vKf5M16vtoye3mR7mzgkGFfLIi56dZPdrAVEqZZfV+2ARuYP+LHbUGqJX
	L/T+rtXSUZEbnEdc5pdxNvPsSL5MbS3k1uAB2KjBxPyIhV2zRzmqEi9Ljfl85smPOdpFq3svRWH
	R7oHvCALuZZST1/nmWyZZH7bHsVGoZoHIMJS+6cdJOsAgkVsmwnz4wVIOxYEEmRIlydqZBJk=
X-Google-Smtp-Source: AGHT+IGwis8GqJEF1Qzf9bSzV6u14blzsX+OeBzCW6GOkWLJgWkwGAve2YAB0K6RDda7Irm9+euaNA==
X-Received: by 2002:a05:600c:1e23:b0:46e:39e1:fc3c with SMTP id 5b1f17b1804b1-46e3a4e1b6amr123957035e9.5.1759145901122;
        Mon, 29 Sep 2025 04:38:21 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46e56f53596sm9502465e9.7.2025.09.29.04.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 04:38:20 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 4/5] PCI: mediatek: convert bool to single flags entry and bitmap
Date: Mon, 29 Sep 2025 13:38:03 +0200
Message-ID: <20250929113806.2484-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929113806.2484-1-ansuelsmth@gmail.com>
References: <20250929113806.2484-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To clean Mediatek SoC PCIe struct, convert all the bool to a bitmap and
use a single flags to reference all the values. This permits cleaner
addition of new flag without having to define a new bool in the struct.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/pci/controller/pcie-mediatek.c | 28 +++++++++++++++-----------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 24cc30a2ab6c..1678461e56d3 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -142,24 +142,29 @@
 
 struct mtk_pcie_port;
 
+enum mtk_pcie_flags {
+	NEED_FIX_CLASS_ID = BIT(0), /* host's class ID needed to be fixed */
+	NEED_FIX_DEVICE_ID = BIT(1), /* host's device ID needed to be fixed */
+	NO_MSI = BIT(2), /* Bridge has no MSI support, and relies on an
+			  * external block
+			  */
+};
+
 /**
  * struct mtk_pcie_soc - differentiate between host generations
- * @need_fix_class_id: whether this host's class ID needed to be fixed or not
- * @need_fix_device_id: whether this host's device ID needed to be fixed or not
  * @no_msi: Bridge has no MSI support, and relies on an external block
  * @device_id: device ID which this host need to be fixed
  * @ops: pointer to configuration access functions
  * @startup: pointer to controller setting functions
  * @setup_irq: pointer to initialize IRQ functions
+ * @flags: pcie device flags.
  */
 struct mtk_pcie_soc {
-	bool need_fix_class_id;
-	bool need_fix_device_id;
-	bool no_msi;
 	unsigned int device_id;
 	struct pci_ops *ops;
 	int (*startup)(struct mtk_pcie_port *port);
 	int (*setup_irq)(struct mtk_pcie_port *port, struct device_node *node);
+	u32 flags;
 };
 
 /**
@@ -703,7 +708,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 	writel(val, port->base + PCIE_RST_CTRL);
 
 	/* Set up vendor ID and class code */
-	if (soc->need_fix_class_id) {
+	if (soc->flags & NEED_FIX_CLASS_ID) {
 		val = PCI_VENDOR_ID_MEDIATEK;
 		writew(val, port->base + PCIE_CONF_VEND_ID);
 
@@ -711,7 +716,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 		writew(val, port->base + PCIE_CONF_CLASS_ID);
 	}
 
-	if (soc->need_fix_device_id)
+	if (soc->flags & NEED_FIX_DEVICE_ID)
 		writew(soc->device_id, port->base + PCIE_CONF_DEVICE_ID);
 
 	/* 100ms timeout value should be enough for Gen1/2 training */
@@ -1099,7 +1104,7 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 
 	host->ops = pcie->soc->ops;
 	host->sysdata = pcie;
-	host->msi_domain = pcie->soc->no_msi;
+	host->msi_domain = !!(pcie->soc->flags & NO_MSI);
 
 	err = pci_host_probe(host);
 	if (err)
@@ -1187,9 +1192,9 @@ static const struct dev_pm_ops mtk_pcie_pm_ops = {
 };
 
 static const struct mtk_pcie_soc mtk_pcie_soc_v1 = {
-	.no_msi = true,
 	.ops = &mtk_pcie_ops,
 	.startup = mtk_pcie_startup_port,
+	.flags = NO_MSI,
 };
 
 static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
@@ -1199,19 +1204,18 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
 };
 
 static const struct mtk_pcie_soc mtk_pcie_soc_mt7622 = {
-	.need_fix_class_id = true,
 	.ops = &mtk_pcie_ops_v2,
 	.startup = mtk_pcie_startup_port_v2,
 	.setup_irq = mtk_pcie_setup_irq,
+	.flags = NEED_FIX_CLASS_ID,
 };
 
 static const struct mtk_pcie_soc mtk_pcie_soc_mt7629 = {
-	.need_fix_class_id = true,
-	.need_fix_device_id = true,
 	.device_id = PCI_DEVICE_ID_MEDIATEK_7629,
 	.ops = &mtk_pcie_ops_v2,
 	.startup = mtk_pcie_startup_port_v2,
 	.setup_irq = mtk_pcie_setup_irq,
+	.flags = NEED_FIX_CLASS_ID | NEED_FIX_DEVICE_ID,
 };
 
 static const struct of_device_id mtk_pcie_ids[] = {
-- 
2.51.0


