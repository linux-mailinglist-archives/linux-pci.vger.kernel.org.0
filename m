Return-Path: <linux-pci+bounces-27427-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC980AAF463
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 09:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB8A1BA866F
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 07:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AAD21E0BD;
	Thu,  8 May 2025 07:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UCrmUAti"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F093221260
	for <linux-pci@vger.kernel.org>; Thu,  8 May 2025 07:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746688243; cv=none; b=UkWuXSl/BmMBIeV8Tr4rRlVLFgB0NFWWRHoHWTOjJNc3t2mV8t4uI3GdQJ/TthmXLhePmlKHtrQzN/fAQqZ+n5sRTp1ujUgDRklswxpptaXSWzYkBNQwdxJ460V7wj5TcRSqMB4DG4GyzuFQkzNHorQ4RRl7t1ZyW9ptmo1ZG0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746688243; c=relaxed/simple;
	bh=3LL1EMi315Z/B5zK3zsxrKW113WDL+SEaQ+1pl/P2Rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HPBKq95ttH+tPOwv6IHl2peHBCyPJlnY5D76KRP0gJjVWrMxlzo0gu+YmtfEHbTUtxL+dHz+vcVOeHIkFQgzpGvPVh+MqJuC4vBYEPx6V5TyZFksQ6IdWfeG48agnd1tQimgwek7T3j6Tq/Fm35CF5LynczNm2Uz0wUI/1B7tTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UCrmUAti; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so4052935e9.1
        for <linux-pci@vger.kernel.org>; Thu, 08 May 2025 00:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746688239; x=1747293039; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANtxwEr6laRS33/pxu2Fx1NdTAnqeBmRbC8AgVjEito=;
        b=UCrmUAtixkXXaw76iN8sdVbWo6BhPF4ZI+ECH3iwLPAKd+j0HCLEY31dZ45r9SSmJn
         f0ODObYQMui0a5kKomYAED1TxZ/Nz5lIKqRad3txGUgnXzgMjNtP+n/IIHDAG1eP9ezX
         x0q6xNft/dstcOdfU3E9HRs4xwp0fkRulHZ3PYh14TrJnP3ab3JUXoi3urV4h2IEEOuC
         AHN7+VrUICPR7y2b81W0MMabWN2gERJFQ5iZPZlc8yoo8aRFeMELyzKO1xd/Yk1e9bF4
         n41VCOc0XCTitsdpMmotDlqr2v6FYLLSFbZVvlaLNcqzXqDa5FtEq9Dm+1bsfPjL8hE1
         Bv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746688239; x=1747293039;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANtxwEr6laRS33/pxu2Fx1NdTAnqeBmRbC8AgVjEito=;
        b=MdfgdK08JExCEqOkdy1tfNdqoQdomGibbQ212Pqz7P/13s5ORbc6Fu8pNYU3UwWCFP
         BqLI2LoeowjJwLVVVUk0NCCBvVkPJTMtYGQdqlRm3ENbwjjlx+iao/CSmoY95y9w+Gb4
         UZpu/FSZOmDA7ZeWY1uK3Yv2oQkkDJXdUZpEIjk4EiU8jr1ZY3tMi54tt/ss/yQgJh3o
         gG6KlL0A2VyjvbudoTcJXBXdPaZMWWk/IqEaH8dzX8R5MXcwLRdVegPQNOz/fAENEUGs
         0dN4SCF6SuzRU6Ts4XRgyMZ2RaW8m+/8FBQ0fKvPeqxFAfTXjhasfJiPipmeNJ3Makj9
         BtUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlk7tGEhxFnbZHvgks0KZSSWyTxTEHT21CX488zIr4KuL8eIDYi0GL1fMsnZdY//lLcVTfBlMgKDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBA0tThl1jWuwpQ0jhIi5UIFOxCiI1euKqYgJg+0ZhVlPukC0b
	keDjPHWw3uUwDnFN5s0kaJK083YFYEsLDOUYmYhrI+D2YLjcwvuao7fP5dWmkg==
X-Gm-Gg: ASbGncuvvNQUOXZRcSlbiRjHioxX348l7v0IZoTbd5xit0xm14WxcrEiU+XfyVK20oP
	aqYOwYAR4IbNLwhAFp64LfyYbpy8Mi9UwftEIjfxwZ+ITKOg6lK9B0y+yX5CS2xfk1tEX8MPmlr
	pkvbm6+7uoVy3GbON8QcEMvXD1SJbJnyX8kyFuxIigveAhOpv4ZPCp0yoRmolTVlcO+xxoWUreY
	mcjsH9+6NJ7fekwVS23HOObOma4HNJF3hgYoDrWwAugQqSsdc6HHHSTWx7H9fg5+/BIrgdm0EjX
	gyztB+gdUXIWDfhdy99fmHX+Re0YrPxD0rG0mg1e0VOLl2+qybhvYlq8j7KWhs4wz9WVLMEPhL6
	qqflkz5oUM58FF2gKxf9BdQowj5M=
X-Google-Smtp-Source: AGHT+IEzLeXl64VuG3LDBY0EBEtsib+I2DE0INi6/ZnHENyuUXbkLuxvlx2tOJR3jgevvW/m5m9a1A==
X-Received: by 2002:a05:600c:5111:b0:440:68db:9fef with SMTP id 5b1f17b1804b1-442d034ad4fmr13925925e9.20.1746688239310;
        Thu, 08 May 2025 00:10:39 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-69-61.cust.wifirst.net. [46.193.69.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b178absm19500236f8f.97.2025.05.08.00.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 00:10:38 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 08 May 2025 12:40:33 +0530
Subject: [PATCH v4 4/5] PCI: host-common: Add link down handling for host
 bridges
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250508-pcie-reset-slot-v4-4-7050093e2b50@linaro.org>
References: <20250508-pcie-reset-slot-v4-0-7050093e2b50@linaro.org>
In-Reply-To: <20250508-pcie-reset-slot-v4-0-7050093e2b50@linaro.org>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>, 
 Will Deacon <will@kernel.org>, Robert Richter <rric@kernel.org>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Marc Zyngier <maz@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>
Cc: dingwei@marvell.com, cassel@kernel.org, Lukas Wunner <lukas@wunner.de>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5013;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=3LL1EMi315Z/B5zK3zsxrKW113WDL+SEaQ+1pl/P2Rg=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBoHFjpL07zvpNmz80RZq+CJ23rDNKQ4rbWHFYvk
 WEYaovGi+WJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaBxY6QAKCRBVnxHm/pHO
 9TldB/0enq4tJZ2uTvuG8JYQU+8hIIEyWbBv64ohIiJ9BqvlzzpZxAmt8uyb0qahy2kubec5Boj
 avyvEzax3nAwi5ldUbHq7FXTSTXx8LCRlABHPcw9wmG91cGx16OfkgnM3FUKgIfEO9YVsD65aVW
 hB3ecw9FGLzTLX/x2ywNimLi3H2pQK5LFPgsfYyWd54qJ+oWgFNzT/OXKVDjzrgDDKMskxj2P7p
 QJ7/UAOOlUhxcSmCfawGsRN43aCRDBvW4uO0c6YViOIz/cfYgfrAhcmXt/ge3QP0PbwEGZvqfe+
 bAfEPRFBQTvnwJgd3CK6yQ8dGSbCpx4cQgfIduSe8Ne8/aEQ
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

The PCI link, when down, needs to be recovered to bring it back. But that
cannot be done in a generic way as link recovery procedure is specific to
host bridges. So add a new API pci_host_handle_link_down() that could be
called by the host bridge drivers when the link goes down.

The API will iterate through all the slots and calls the pcie_do_recovery()
function with 'pci_channel_io_frozen' as the state. This will result in the
execution of the AER Fatal error handling code. Since the link down
recovery is pretty much the same as AER Fatal error handling,
pcie_do_recovery() helper is reused here. First the AER error_detected
callback will be triggered for the bridge and the downstream devices. Then,
pci_host_reset_slot() will be called for the slot, which will reset the
slot using 'reset_slot' callback to recover the link. Once that's done,
resume message will be broadcasted to the bridge and the downstream devices
indicating successful link recovery.

In case if the AER support is not enabled in the kernel, only
pci_bus_error_reset() will be called for each slots as there is no way we
could inform the drivers about link recovery.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/pci-host-common.c | 58 ++++++++++++++++++++++++++++++++
 drivers/pci/controller/pci-host-common.h |  1 +
 drivers/pci/pci.c                        |  1 +
 drivers/pci/pcie/err.c                   |  1 +
 4 files changed, 61 insertions(+)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index f93bc7034e697250711833a5151f7ef177cd62a0..f916f0a874a61ddfbfd99f96975c00fb66dd224c 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -12,9 +12,11 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
+#include <linux/pci.h>
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
 
+#include "../pci.h"
 #include "pci-host-common.h"
 
 static void gen_pci_unmap_cfg(void *ptr)
@@ -96,5 +98,61 @@ void pci_host_common_remove(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(pci_host_common_remove);
 
+#if IS_ENABLED(CONFIG_PCIEAER)
+static pci_ers_result_t pci_host_reset_slot(struct pci_dev *dev)
+{
+	int ret;
+
+	ret = pci_bus_error_reset(dev);
+	if (ret) {
+		pci_err(dev, "Failed to reset slot: %d\n", ret);
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	pci_info(dev, "Slot has been reset\n");
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+static void pci_host_recover_slots(struct pci_host_bridge *host)
+{
+	struct pci_bus *bus = host->bus;
+	struct pci_dev *dev;
+
+	for_each_pci_bridge(dev, bus) {
+		if (!pci_is_root_bus(bus))
+			continue;
+
+		pcie_do_recovery(dev, pci_channel_io_frozen,
+				 pci_host_reset_slot);
+	}
+}
+#else
+static void pci_host_recover_slots(struct pci_host_bridge *host)
+{
+	struct pci_bus *bus = host->bus;
+	struct pci_dev *dev;
+	int ret;
+
+	for_each_pci_bridge(dev, bus) {
+		if (!pci_is_root_bus(bus))
+			continue;
+
+		ret = pci_bus_error_reset(dev);
+		if (ret)
+			pci_err(dev, "Failed to reset slot: %d\n", ret);
+		else
+			pci_info(dev, "Slot has been reset\n");
+	}
+}
+#endif
+
+void pci_host_handle_link_down(struct pci_host_bridge *bridge)
+{
+	dev_info(&bridge->dev, "Recovering slots due to Link Down\n");
+	pci_host_recover_slots(bridge);
+}
+EXPORT_SYMBOL_GPL(pci_host_handle_link_down);
+
 MODULE_DESCRIPTION("Common library for PCI host controller drivers");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/controller/pci-host-common.h
index d8be024ca68d43afb147fd9104d632b907277144..904698c1a2695888a0fc9c2fac360e456116eb1d 100644
--- a/drivers/pci/controller/pci-host-common.h
+++ b/drivers/pci/controller/pci-host-common.h
@@ -12,5 +12,6 @@
 
 int pci_host_common_probe(struct platform_device *pdev);
 void pci_host_common_remove(struct platform_device *pdev);
+void pci_host_handle_link_down(struct pci_host_bridge *bridge);
 
 #endif
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13709bb898a967968540826a2b7ee8ade6b7e082..4d396bbab4a8f33cae0ffe8982da120a9f1d92c9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5781,6 +5781,7 @@ int pci_bus_error_reset(struct pci_dev *bridge)
 	mutex_unlock(&pci_slot_mutex);
 	return pci_bus_reset(bridge->subordinate, PCI_RESET_DO_RESET);
 }
+EXPORT_SYMBOL_GPL(pci_bus_error_reset);
 
 /**
  * pci_probe_reset_bus - probe whether a PCI bus can be reset
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index b834fc0d705938540d3d7d3d8739770c09fe7cf1..3e3084bb7cb7fa06b526e6fab60e77927aba0ad0 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -270,3 +270,4 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 
 	return status;
 }
+EXPORT_SYMBOL_GPL(pcie_do_recovery);

-- 
2.43.0


