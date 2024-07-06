Return-Path: <linux-pci+bounces-9877-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F07C929455
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 17:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79E65B214F7
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 15:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5532F13AD26;
	Sat,  6 Jul 2024 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScRftX0b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3CEA93D;
	Sat,  6 Jul 2024 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720278480; cv=none; b=pm54UDQK/YvQGmix1u1TYfTLELQ8FUzWQ4NXRHcvcjGxbC84TEkD5rQRJJWEf1c/diXW/mi+R5UcRwUizkOlBWM5yV5zmrM5eNEuDbGn1xFqxnOffMFqj/G2G3zeT+Dlm15o4W4IJA+gI12Zqt6JqgpDFLdnCN5rgRyH05QYrKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720278480; c=relaxed/simple;
	bh=GzegKvDmy28OsgYrvwumczSzNZ4lFHQDEzhh6CtatVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tPpyfZxjOEtz7nnkTYxFLsvFtUD1Z8ZtPTHkLidttBQAdn3c0Hq8UmwiQigAZZ0F547yWZAScRmORFEw73UByERJJ6JxOU0UBz1VcNVSG5Yed66p+5Ck+WuO7CfLOQn2xpZW+LNcajvE+4vNFX+Xkk12b1jKGfxoY6NF2C8MAJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScRftX0b; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-367940c57ddso1555912f8f.3;
        Sat, 06 Jul 2024 08:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720278477; x=1720883277; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UT9BnAFcxutpgK4IXGhba1ZOikJaXe7Gk3G+5TB5Xzw=;
        b=ScRftX0bwnCY2gqXDq+Fd4hiO5MtlBiDzsZGePWFDPiWBDuJkctu5tGdtiArUjtHWm
         NoolVhXGQ0Enf3RRlZBFUhfxvIDIZXm0+2poThy3IyZr3dJyzkZVAFMjLD8bEudOnAXV
         iW9xwZF/tSrCB/fuaZDUgk5DYVggwzwVl3/n9jXCT65iLp0X2tNeDqYzHtOEzB1otnCF
         LIWf9pQJPldljLsnkJtGtOMjjYOSpRPDIYyM+W8O+LbSSsfzJihRqen5GSpCb9Wu/FVu
         g1XnErPbsQi2tZW0MQh59+FKY66LRKbU3E4/R3II4llodwSCWPPGXceXf4uM0ht9OdlX
         9UPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720278477; x=1720883277;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UT9BnAFcxutpgK4IXGhba1ZOikJaXe7Gk3G+5TB5Xzw=;
        b=ImhN61trhpJhmS0vri8piKYvUh+fSZDv/OCzfkz+5SRJCnTIehGK4qKYX2iDI2GNTZ
         Ch7VaZpF8MLVvbZZ+bgp3VSjciUDeMJPlmYjFTEGY1lipLGkcK9yNAIfVdBCp3dQp3cU
         zrSatGvbT5m1Tfp6AVIiBIe7jEpSUIBdDRjtKMDbmZZrzdy51wfR2PABm9bbzADzNgF3
         57RPOKt0SMhIE8kY7kdeBQEQ+UEpNWIt+KuCnk3o0SeTC8FrtuVMOaL93Vj3oVuQdlHK
         tNOyR5m3MjqB4pjbMehyWpW6Na40APF5kiehi55bF1aw7WuuvFH0+LT15nQaz8Qnd4n3
         NbeA==
X-Forwarded-Encrypted: i=1; AJvYcCU6VxoT2kIjBp7yT0CPd2Sbjxe+YQ+KiLTx2yrFzYM4553vc8CKlz667TDNCzyge8HbsiJjaf2mP/8dBRfgsitz2AcGdhi7g8BvQC0x
X-Gm-Message-State: AOJu0YwNYBIrJm0sQ+NT//NWpW4yL6ckCL8GVITIzzJj3coZWi2CoOuf
	gPVIKwK8bFRZ8TgVtUDtqkdp9PQZAcxDhIb4zsk7vsC42Ef9eVui
X-Google-Smtp-Source: AGHT+IFNejYDpmn4Dgs5oaRMvslRRq6vk0geYOqWMt4BFT3Z/EABwywzWcNVunZ/kEoRlvkMRwFEwA==
X-Received: by 2002:a05:6000:1845:b0:366:eb47:41f9 with SMTP id ffacd0b85a97d-3679dd30decmr5737214f8f.29.1720278476618;
        Sat, 06 Jul 2024 08:07:56 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-d11b-8ec4-ea76-796c.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d11b:8ec4:ea76:796c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a1805e53sm5896437f8f.22.2024.07.06.08.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 08:07:56 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 06 Jul 2024 17:07:46 +0200
Subject: [PATCH 1/2] PCI: kirin: use dev_err_probe() in probe error paths
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240706-pcie-kirin-dev_err_probe-v1-1-56df797fb8ee@gmail.com>
References: <20240706-pcie-kirin-dev_err_probe-v1-0-56df797fb8ee@gmail.com>
In-Reply-To: <20240706-pcie-kirin-dev_err_probe-v1-0-56df797fb8ee@gmail.com>
To: Xiaowei Song <songxiaowei@hisilicon.com>, 
 Binghui Wang <wangbinghui@hisilicon.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, 
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720278473; l=2711;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=GzegKvDmy28OsgYrvwumczSzNZ4lFHQDEzhh6CtatVU=;
 b=rjiucIMo8sYfJzLoy6mNbZA0XUw5YdRZrLpXrBsKm9WzGdpNFR5qVHd0Hcr6X/ykUpqIHjvf/
 F6YLNN6T3VGDP6qgHKIUtx/MYSJWX21wNJvMv9mcMikDNhaWEkHnXTg
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

dev_err_probe() is used in some probe error paths, yet the
"dev_err() + return" pattern is used in some others.

Use dev_err_probe() in all error paths with that construction.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/pci/controller/dwc/pcie-kirin.c | 39 +++++++++++++--------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 0a29136491b8..da8091f6b22b 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -216,10 +216,8 @@ static int hi3660_pcie_phy_start(struct hi3660_pcie_phy *phy)
 
 	usleep_range(PIPE_CLK_WAIT_MIN, PIPE_CLK_WAIT_MAX);
 	reg_val = kirin_apb_phy_readl(phy, PCIE_APB_PHY_STATUS0);
-	if (reg_val & PIPE_CLK_STABLE) {
-		dev_err(dev, "PIPE clk is not stable\n");
-		return -EINVAL;
-	}
+	if (reg_val & PIPE_CLK_STABLE)
+		return dev_err_probe(dev, -EINVAL, "PIPE clk is not stable\n");
 
 	return 0;
 }
@@ -371,10 +369,9 @@ static int kirin_pcie_get_gpio_enable(struct kirin_pcie *pcie,
 	if (ret < 0)
 		return 0;
 
-	if (ret > MAX_PCI_SLOTS) {
-		dev_err(dev, "Too many GPIO clock requests!\n");
-		return -EINVAL;
-	}
+	if (ret > MAX_PCI_SLOTS)
+		return dev_err_probe(dev, -EINVAL,
+				     "Too many GPIO clock requests!\n");
 
 	pcie->n_gpio_clkreq = ret;
 
@@ -421,16 +418,14 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
 			}
 
 			pcie->num_slots++;
-			if (pcie->num_slots > MAX_PCI_SLOTS) {
-				dev_err(dev, "Too many PCI slots!\n");
-				return -EINVAL;
-			}
+			if (pcie->num_slots > MAX_PCI_SLOTS)
+				return dev_err_probe(dev, -EINVAL,
+						     "Too many PCI slots!\n");
 
 			ret = of_pci_get_devfn(child);
-			if (ret < 0) {
-				dev_err(dev, "failed to parse devfn: %d\n", ret);
-				return ret;
-			}
+			if (ret < 0)
+				return dev_err_probe(dev, ret,
+						     "failed to parse devfn: %d\n", ret);
 
 			slot = PCI_SLOT(ret);
 
@@ -729,16 +724,12 @@ static int kirin_pcie_probe(struct platform_device *pdev)
 	struct dw_pcie *pci;
 	int ret;
 
-	if (!dev->of_node) {
-		dev_err(dev, "NULL node\n");
-		return -EINVAL;
-	}
+	if (!dev->of_node)
+		return dev_err_probe(dev, -EINVAL, "NULL node\n");
 
 	data = of_device_get_match_data(dev);
-	if (!data) {
-		dev_err(dev, "OF data missing\n");
-		return -EINVAL;
-	}
+	if (!data)
+		return dev_err_probe(dev, -EINVAL, "OF data missing\n");
 
 	kirin_pcie = devm_kzalloc(dev, sizeof(struct kirin_pcie), GFP_KERNEL);
 	if (!kirin_pcie)

-- 
2.40.1


