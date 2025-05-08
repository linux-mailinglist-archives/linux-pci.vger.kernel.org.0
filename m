Return-Path: <linux-pci+bounces-27426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E571BAAF45F
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 09:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0BE1BA86C1
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 07:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65114221F1C;
	Thu,  8 May 2025 07:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="loWh9646"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3D3220680
	for <linux-pci@vger.kernel.org>; Thu,  8 May 2025 07:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746688243; cv=none; b=XeH+fJ6xZli+L/LiJDQ537UAkOBR6kiQMXgUFZlCPol4SnJrctE4MoX4L5Igsg+PomWvl1v1kyo9igTrZIdhluLAuBxEPLN0wQG5D8Wy3iRQf3DGOd0LKVJ+PS7nRipYbo6ftrjp5H3906K2MHckfY7Ws22QIzlrFnDJ+6vv9EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746688243; c=relaxed/simple;
	bh=9YTGSyyEjJBWzKcv9X508Ju9+VcoznZB2wd8RCZhBIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=twN/VcPhAtN64UVfwDFP0sRVBNslvBoUO7KpKjiX8MQCDncqdpcuWf9ETLNNqqnAFchDuC46PE+rCwRWk4ZfW1AebQw6UBQ+9WnYH6IZ6b/82ykMHY7Ha+eWR2jTUPbtR63QVwKBCkexGq/WVSaRX4yd9U6JH4E3B9UcynQSRmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=loWh9646; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39ee682e0ddso507027f8f.1
        for <linux-pci@vger.kernel.org>; Thu, 08 May 2025 00:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746688238; x=1747293038; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZCXJnaWqE0fAgUs100fVOe2mb9c5kJtvlpY1ACqYb3k=;
        b=loWh96468eHxNKBzmrfmj9mMf1mOPCu1nwNjIKHIf9b4OILe0Zvi4iYbufsf6zk+Uw
         Z7a3/tb7d2Q2eMH0ldGGB7gheXLsiDueQTJSWqGa6SYPyDrK0GKPBO1H92SdrL8U66MN
         4jf15cMvh8QDizaK+pudiQ1tK2xRQv5n3317ggbX91QsF6x69J1bKGKyQD2BtVsrvrtC
         iB322fhr1dEmP2qjcgZ9dxyNkVYv+EjTqeETXADsqJZegCelj9Ai4BmqxLzuWgsa5Kxz
         4/ARYShPWHFhvPQzawoYBqk/NMYEUpb0hRvAMd4YryVDp3j142sCGlVvhVgSIIXy5rWI
         diqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746688238; x=1747293038;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZCXJnaWqE0fAgUs100fVOe2mb9c5kJtvlpY1ACqYb3k=;
        b=alWvMJ0v+B4uza5luDUwQ+3laFbB1eb18YESQ3T2bbFFCxkRC05b7eP/WXFRlgK4uW
         gyW48XzPOf28UdfJW5Y/fQrq3NpL4sFQ48EzW2ymMFFpE4l6qgzOC/48wSLMM+xNTZAQ
         GkQz50+h/bo+olrvlIwg0gGy0oOiowgdz2wk+w4wUXyT3En2svGhRTOyRo4dSozy5F4p
         AFfqG4ZHX0TTmGZEc3PdHzNCaFbs8X9gH28tgtntsBLXyqFv4yNJV7HmohNJ3oGEqj2e
         UWbd7WhGgEXca+zKwMtIgkKI+P607Rqky4TUcMM2gFw9bT4wYzlcxr+Uz3WdS0Pmhrj/
         jqfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmNJGYIMbw1GQRqf7z8hb/Rxm4Fm6Jujyprt4whhF/fCbH94jUE3YeEyQq16FAkf+6sO0GLcTBMnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSprtcCyWTvv2ja/CJz+sPkckGegp4/mf79xXyXHwNF0OSpS79
	WoMZeDNFimTvUa0+AGUv3NF5Un0Tgnd475OV0rlms2zjoS0NKz24nflLcO7ypYXunJMp+AkKBdw
	moQ==
X-Gm-Gg: ASbGnctpax5wsRD5QnOhAtxTtktc5Z29u7G+hXFKzfBiXde2H4VgDjX1+1TfvHih6EU
	7R7ffXnX+h15tb4Bu91xVqzJ3RFeELLshcrQgbJMu+c+MsY2Pbr7hKi1x5m6W5cc/0+jHcs2zvy
	HZ1rEPC8o5UVHFDV/e9DL9Izbu6Fmbrylvy4IixdT9TAbOt84d4CmrZ5tvF3D1ctYI+oyUzVd/2
	9f+YDHU+ytFOBiOx/9Eq2iKfD/k2JZbxYe2mOviKE9edQCjKvcnhNJd9qun7s2ofM+jS1ku4wcb
	RvNtX4NR+sId2+5KLivhoXvA/sZWkP2HEiizbs771PQHC4TNENYgTcAPaphfzpC7JeDFNOLia5a
	ugiKQaB/Gbct8ZcVPZS5fJZP7G1U=
X-Google-Smtp-Source: AGHT+IHV1JSfv4qBQwupY4Va2+Wb9i9D07szr7SibcAfJ9Za0IJyccsIDSZGMhPonRwpb8x04FLbNA==
X-Received: by 2002:a5d:5988:0:b0:39e:e557:7d9 with SMTP id ffacd0b85a97d-3a0b49e9fa9mr4148948f8f.5.1746688238305;
        Thu, 08 May 2025 00:10:38 -0700 (PDT)
Received: from [127.0.1.1] (cust-east-par-46-193-69-61.cust.wifirst.net. [46.193.69.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b178absm19500236f8f.97.2025.05.08.00.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 00:10:37 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 08 May 2025 12:40:32 +0530
Subject: [PATCH v4 3/5] PCI: host-common: Make the driver as a common
 library for host controller drivers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250508-pcie-reset-slot-v4-3-7050093e2b50@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7440;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=9YTGSyyEjJBWzKcv9X508Ju9+VcoznZB2wd8RCZhBIA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBoHFjp1kFqMhXSTF/eBh/n6fZtF2vM5B0B0c5Ul
 nv49HMJlUuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaBxY6QAKCRBVnxHm/pHO
 9du0B/sGQkAQ1jOTMZmz5FNWat7V9HdLSW4K3BY3FD4mEBtb8jIpZDNiJTYBb085icKcXYPQ31M
 FICFZzr47/EPEyJr5oHdHiHCT8+qdsDKMOpTy2RdIU+iNDY9GUhOtVFVMU28cHFcQsNAtOKy2kx
 6Qf1JpijCSxiu+KVABIWBz/rhP8pvPTX2kP+U22LEeMkDtoPjU0HsKK9f3VWPQbHlWZlbO8zQtn
 G889qzgpaWL0nyW20O6LrdnY/6FAo53jRjxSzQvt9/ufEIqUyTj51abVn0y2cNfYfLC+v1SLdW7
 HtCcl1pwMCMjjs3Q5IGertLvu1r/cz+TfDDhWWGVtWqkYZCl
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

This common library will be used as a placeholder for helper functions
shared by the host controller drivers. This avoids placing the host
controller drivers specific helpers in drivers/pci/*.c, to avoid enlarging
the kernel Image on platforms that do not use host controller drivers at
all (like x86/ACPI platforms).

Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/Kconfig                    |  8 ++++----
 drivers/pci/controller/dwc/pcie-hisi.c            |  1 +
 drivers/pci/controller/pci-host-common.c          |  6 ++++--
 drivers/pci/controller/pci-host-common.h          | 16 ++++++++++++++++
 drivers/pci/controller/pci-host-generic.c         |  2 ++
 drivers/pci/controller/pci-thunder-ecam.c         |  2 ++
 drivers/pci/controller/pci-thunder-pem.c          |  1 +
 drivers/pci/controller/pcie-apple.c               |  2 ++
 drivers/pci/controller/plda/pcie-microchip-host.c |  1 +
 include/linux/pci-ecam.h                          |  6 ------
 10 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 9800b768105402d6dd1ba4b134c2ec23da6e4201..9bb8bf669a807272777b6168d042f8fd7490aeec 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -3,6 +3,10 @@
 menu "PCI controller drivers"
 	depends on PCI
 
+config PCI_HOST_COMMON
+	tristate
+	select PCI_ECAM
+
 config PCI_AARDVARK
 	tristate "Aardvark PCIe controller"
 	depends on (ARCH_MVEBU && ARM64) || COMPILE_TEST
@@ -119,10 +123,6 @@ config PCI_FTPCI100
 	depends on OF
 	default ARCH_GEMINI
 
-config PCI_HOST_COMMON
-	tristate
-	select PCI_ECAM
-
 config PCI_HOST_GENERIC
 	tristate "Generic PCI host controller"
 	depends on OF
diff --git a/drivers/pci/controller/dwc/pcie-hisi.c b/drivers/pci/controller/dwc/pcie-hisi.c
index 8904b5b85ee589576afcb6c81bb4bd39ff960c15..3c17897e56fcb60ec08cf522ee1485f90a2f36a3 100644
--- a/drivers/pci/controller/dwc/pcie-hisi.c
+++ b/drivers/pci/controller/dwc/pcie-hisi.c
@@ -15,6 +15,7 @@
 #include <linux/pci-acpi.h>
 #include <linux/pci-ecam.h>
 #include "../../pci.h"
+#include "../pci-host-common.h"
 
 #if defined(CONFIG_PCI_HISI) || (defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS))
 
diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index f441bfd6f96a8bde1c07fcf97d43d0693c424a27..f93bc7034e697250711833a5151f7ef177cd62a0 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Generic PCI host driver common code
+ * Common library for PCI host controller drivers
  *
  * Copyright (C) 2014 ARM Limited
  *
@@ -15,6 +15,8 @@
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
 
+#include "pci-host-common.h"
+
 static void gen_pci_unmap_cfg(void *ptr)
 {
 	pci_ecam_free((struct pci_config_window *)ptr);
@@ -94,5 +96,5 @@ void pci_host_common_remove(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(pci_host_common_remove);
 
-MODULE_DESCRIPTION("Generic PCI host common driver");
+MODULE_DESCRIPTION("Common library for PCI host controller drivers");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/controller/pci-host-common.h
new file mode 100644
index 0000000000000000000000000000000000000000..d8be024ca68d43afb147fd9104d632b907277144
--- /dev/null
+++ b/drivers/pci/controller/pci-host-common.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Common library for PCI host controller drivers
+ *
+ * Copyright (C) 2014 ARM Limited
+ *
+ * Author: Will Deacon <will.deacon@arm.com>
+ */
+
+#ifndef _PCI_HOST_COMMON_H
+#define _PCI_HOST_COMMON_H
+
+int pci_host_common_probe(struct platform_device *pdev);
+void pci_host_common_remove(struct platform_device *pdev);
+
+#endif
diff --git a/drivers/pci/controller/pci-host-generic.c b/drivers/pci/controller/pci-host-generic.c
index 4051b9b61dace669422e5a6453cc9f58a081beb5..c1bc0d34348f44c9fdd549811f637fb50fe89c64 100644
--- a/drivers/pci/controller/pci-host-generic.c
+++ b/drivers/pci/controller/pci-host-generic.c
@@ -14,6 +14,8 @@
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
 
+#include "pci-host-common.h"
+
 static const struct pci_ecam_ops gen_pci_cfg_cam_bus_ops = {
 	.bus_shift	= 16,
 	.pci_ops	= {
diff --git a/drivers/pci/controller/pci-thunder-ecam.c b/drivers/pci/controller/pci-thunder-ecam.c
index 08161065a89c35a95714df935ef437dfc8845697..b5b4a958e6a22b21501cad45bb242a95a784efc1 100644
--- a/drivers/pci/controller/pci-thunder-ecam.c
+++ b/drivers/pci/controller/pci-thunder-ecam.c
@@ -11,6 +11,8 @@
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
 
+#include "pci-host-common.h"
+
 #if defined(CONFIG_PCI_HOST_THUNDER_ECAM) || (defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS))
 
 static void set_val(u32 v, int where, int size, u32 *val)
diff --git a/drivers/pci/controller/pci-thunder-pem.c b/drivers/pci/controller/pci-thunder-pem.c
index f1bd5de67997cddac173723bc7f4ec20aaf20064..5fa037fb61dc356f3029d1b5cae632ae1da5bb9b 100644
--- a/drivers/pci/controller/pci-thunder-pem.c
+++ b/drivers/pci/controller/pci-thunder-pem.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include "../pci.h"
+#include "pci-host-common.h"
 
 #if defined(CONFIG_PCI_HOST_THUNDER_PEM) || (defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS))
 
diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 18e11b9a7f46479348815c3f706319189e0a80b5..edd4c8c683c6a693401b47f5f056641c13ae89f8 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -29,6 +29,8 @@
 #include <linux/of_irq.h>
 #include <linux/pci-ecam.h>
 
+#include "pci-host-common.h"
+
 #define CORE_RC_PHYIF_CTL		0x00024
 #define   CORE_RC_PHYIF_CTL_RUN		BIT(0)
 #define CORE_RC_PHYIF_STAT		0x00028
diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index 3fdfffdf027001bf88df8e1c2538587298228220..24bbf93b8051fa0d9027ce6983eae34cad81065e 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -23,6 +23,7 @@
 #include <linux/wordpart.h>
 
 #include "../../pci.h"
+#include "../pci-host-common.h"
 #include "pcie-plda.h"
 
 #define MC_MAX_NUM_INBOUND_WINDOWS		8
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index 3a10f8cfc3ad5c90585a8fc971be714011ed18fe..d930651473b4d0b406e657a24ede87e09517d091 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -93,10 +93,4 @@ extern const struct pci_ecam_ops al_pcie_ops;	/* Amazon Annapurna Labs PCIe */
 extern const struct pci_ecam_ops tegra194_pcie_ops; /* Tegra194 PCIe */
 extern const struct pci_ecam_ops loongson_pci_ecam_ops; /* Loongson PCIe */
 #endif
-
-#if IS_ENABLED(CONFIG_PCI_HOST_COMMON)
-/* for DT-based PCI controllers that support ECAM */
-int pci_host_common_probe(struct platform_device *pdev);
-void pci_host_common_remove(struct platform_device *pdev);
-#endif
 #endif

-- 
2.43.0


