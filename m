Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265BF45A6A4
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 16:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237126AbhKWPl4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 10:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbhKWPl4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Nov 2021 10:41:56 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29D1C061574
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 07:38:47 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so2702172wme.0
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 07:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wmyhIsaxeXey3XXeHcb8bFkkqjF6JXdSe1AWLC1myzI=;
        b=cSinTVf42lYxBTZxzdNXAlRI4Nr34nwH6iIYns3LYMfKQg0SVmwcSmB0WHSKP/6aVe
         Fen/YzhcfwE/LCAxTBWllW6GgDxaEDzr7lRmfcQ5c9lp1qrjCAQFllLmBZ/i2HGnWeLi
         t0bx7gL40n1LFzr2lt5Qyb76oTCw1N60dqk6kYYjnzB1zzIKq6+NgytdGeF4HmPNMqV/
         5M1+YVACt0MbXaQ6bQjq0pNIWk3PuMjOW8YdKy7BQNePpgz342uUxyZGIqtDzHfv+bj8
         tMpJ6x1VeCTHz6Q7IXZ/b6BINAtWUGLDdo1vOvs4D22jNJyxNNyGMlpVXsc9ThdgfvSb
         5Jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wmyhIsaxeXey3XXeHcb8bFkkqjF6JXdSe1AWLC1myzI=;
        b=OdhO6YySl117mIY9ohWl3o0ydpPXvOwbr0KDs5ymyMi0aEMXqaG18O95N34UHZbC3/
         zMoyl3cXmg4ziIQazcKid8Kkn6OenqKYXr25refG8+RCH0C0lri8UIyQthL7x2YNhDCG
         lBakoY5suavdOh0E774hPjYQhZBKaTPFTClu7jSRPGdimyetPqBuEUH7O03+428H8W98
         ppk+rGLdkCRIZdbkG00X3jTfE7/dLLOL2UjzHLJ7LqhGbw9cHJRuOau+gJrsCT2ax+MR
         F9Ow3FQzMqvLyYcwxWC5atz4J7z3epnxO24kLcQ+XdtQCj8zPvHJ7HaGx5OcWDoTOwRA
         6neQ==
X-Gm-Message-State: AOAM5310m61UGl5UyFdGk0H+U4ZmAt8+RiUHD0KBl93gQEUXlNfXUDdq
        63MqXaxJd3V9ikXdzAEQpWo=
X-Google-Smtp-Source: ABdhPJzsF+ChfV62kiGspxAJ7WuruYwY19fhoml0RibIiqyT0eXTeMubJDViwq7igLo9eIe8wR5DmA==
X-Received: by 2002:a05:600c:4113:: with SMTP id j19mr4417656wmi.48.1637681926470;
        Tue, 23 Nov 2021 07:38:46 -0800 (PST)
Received: from claire-ThinkPad-T470.localdomain (dynamic-2a01-0c23-b916-4400-b786-57bd-b8fa-4b8b.c23.pool.telefonica.de. [2a01:c23:b916:4400:b786:57bd:b8fa:4b8b])
        by smtp.gmail.com with ESMTPSA id g5sm18281696wri.45.2021.11.23.07.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 07:38:46 -0800 (PST)
From:   Fan Fei <ffclaire1224@gmail.com>
To:     bjorn@helgaas.com
Cc:     Fan Fei <ffclaire1224@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 3/4] PCI: al: Remove device * in struct
Date:   Tue, 23 Nov 2021 16:38:37 +0100
Message-Id: <e1c097ef8ef4e42b2fd94a327ce5af2bc2bac991.1637533108.git.ffclaire1224@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1637533108.git.ffclaire1224@gmail.com>
References: <cover.1637533108.git.ffclaire1224@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove "device *dev" in struct al_pcie because it refers struct dw_pcie,
which contains a "device *dev" already.

Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
---
 drivers/pci/controller/dwc/pcie-al.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controller/dwc/pcie-al.c
index e8afa50129a8..f4b7bcda6b2d 100644
--- a/drivers/pci/controller/dwc/pcie-al.c
+++ b/drivers/pci/controller/dwc/pcie-al.c
@@ -130,7 +130,6 @@ struct al_pcie_target_bus_cfg {
 struct al_pcie {
 	struct dw_pcie *pci;
 	void __iomem *controller_base; /* base of PCIe unit (not DW core) */
-	struct device *dev;
 	resource_size_t ecam_size;
 	unsigned int controller_rev_id;
 	struct al_pcie_reg_offsets reg_offsets;
@@ -171,12 +170,12 @@ static int al_pcie_rev_id_get(struct al_pcie *pcie, unsigned int *rev_id)
 		*rev_id = AL_PCIE_REV_ID_4;
 		break;
 	default:
-		dev_err(pcie->dev, "Unsupported dev_id_val (0x%x)\n",
+		dev_err(pcie->pci->dev, "Unsupported dev_id_val (0x%x)\n",
 			dev_id_val);
 		return -EINVAL;
 	}
 
-	dev_dbg(pcie->dev, "dev_id_val: 0x%x\n", dev_id_val);
+	dev_dbg(pcie->pci->dev, "dev_id_val: 0x%x\n", dev_id_val);
 
 	return 0;
 }
@@ -192,7 +191,7 @@ static int al_pcie_reg_offsets_set(struct al_pcie *pcie)
 		pcie->reg_offsets.ob_ctrl = OB_CTRL_REV3_5_OFFSET;
 		break;
 	default:
-		dev_err(pcie->dev, "Unsupported controller rev_id: 0x%x\n",
+		dev_err(pcie->pci->dev, "Unsupported controller rev_id: 0x%x\n",
 			pcie->controller_rev_id);
 		return -EINVAL;
 	}
@@ -258,7 +257,7 @@ static void al_pcie_config_prepare(struct al_pcie *pcie)
 
 	ecam_bus_mask = (pcie->ecam_size >> PCIE_ECAM_BUS_SHIFT) - 1;
 	if (ecam_bus_mask > 255) {
-		dev_warn(pcie->dev, "ECAM window size is larger than 256MB. Cutting off at 256\n");
+		dev_warn(pcie->pci->dev, "ECAM window size is larger than 256MB. Cutting off at 256\n");
 		ecam_bus_mask = 255;
 	}
 
@@ -334,7 +333,6 @@ static int al_pcie_probe(struct platform_device *pdev)
 	pci->pp.ops = &al_pcie_host_ops;
 
 	al_pcie->pci = pci;
-	al_pcie->dev = dev;
 
 	ecam_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
 	if (!ecam_res) {
-- 
2.25.1

