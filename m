Return-Path: <linux-pci+bounces-29013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DC8ACE94B
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 07:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7599174385
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 05:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0A61DDC04;
	Thu,  5 Jun 2025 05:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mEBsW1WD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC711DC98C
	for <linux-pci@vger.kernel.org>; Thu,  5 Jun 2025 05:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749101111; cv=none; b=DlZrPzj43b7NANqPBecPNqMtZtkOlSP5JYOpCvPsVXCJdywWWdDFnorPzdLn3ltZHYWLiIyEzAnvStjmCe2I8BANDr5CCppOTiperzAOwGn7+knluQxiuWDK3O+DZXnZBjc4Q97IYal/VcztfRaAF6YThTtWBevaXBnS424xSFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749101111; c=relaxed/simple;
	bh=vlJXvAa9X+ezoDZ5kkgtL0pzbm0tSOq3EooVS4mttsg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z0Wm5a5R6YgzOUk+6uWmzPLnHbKcpB5qpwAUpnLlY0/B9U/jzTrQ3fLDU3tSOf5ID7pDWN9El9UJKD5dkZinBfbDK41G8CQe/Gey5rXQ1FnIUnWA0OrIULwUepPOrXqzLMDTkhcqLZEBsTIgCOyyHLWG/NZaM2/b5Hqs4zLwAuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mEBsW1WD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554H4UDc007627
	for <linux-pci@vger.kernel.org>; Thu, 5 Jun 2025 05:25:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XOXtSog1QDveCNyYwT9jqHDvpBgbfVSj3rU4ri3NmDo=; b=mEBsW1WDRqFshoHA
	uTzUhVdfE64SiFtIzd6/gTGhfQWonSx9pDB5NasrBvxjTXTPaTZq8P6kV//UuVkT
	qVrRpNngnSTFHA1raEa6gkgiQV3XrkwvKUqTY3CjXDgQw3GdmZ1t3johfnSP/ZgX
	4a5c0lHCCQ5IBYMA0RQqlyGZ0sD+EsNzzKpnMiA9OM6w0+EH+l4MfT7xyY2pehdi
	ozOW1KSGK5TVKSsYqOcYdsux6UfOataj+UAbIFWTYsc77DSBkgpcdnDDhHQ/jfAl
	hYWLkdmnL6PjCUHYxKffyYpfWi2xSD6W1+4s9EGC3jKEW+yFKvJG3biv+SyajKh+
	5rcwSw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8t056x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Jun 2025 05:25:07 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3122368d82bso954231a91.0
        for <linux-pci@vger.kernel.org>; Wed, 04 Jun 2025 22:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749101107; x=1749705907;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOXtSog1QDveCNyYwT9jqHDvpBgbfVSj3rU4ri3NmDo=;
        b=ROC8+FyhXa42aPyVB7mweneFXEmdsixykz8Z/QM02NFsROcbYT+h971+/8KVtUp6uh
         w8GBayLtc5bOKFrOTBSYiOdg0rVtXOnn0FRRCjnzp3kKc6AS7rwvnXeK677M4BrNvNbT
         tdc/pHC0IgpcMQCzuzz2LQJQgiQKUGNR7bKqx/VnYe1JMnpPIQq8sCntwVTVM5+CSA0K
         tcHScMFO6e/RsvcisxMG3OUYGUCqoswpeJ5VpMmBGrp7uy2UF3scaiV813NGZPO6N+lE
         ZZv5BZEkl/5XY0GXkBOM/HSecm8cSGcSO2smdomI+16wTjjzHYhtk2tr+JjkUg/qWH8i
         oe5g==
X-Forwarded-Encrypted: i=1; AJvYcCVCVLhVWUmAg1XVwPkoGVUzfl01ARVccgR/ipkkQMfHWWLEpCsAABvw4vtO7KPm1FfLezUrFhgiMQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj6SBITxqLwUsawc5p3mc6Lp3FlTieR+jSMn9vlnOJL/tKsoN/
	wbjjjafAxfjbIih7FhCziSzsArhsgEB9vvW6iBSXCUob28pEhd7/1P97dtXE52+Pqp/YjviSSef
	pnF0Nu3itva/P0ZSrFwbk/yVHuUQjWMUOUBIc6eMavL8/TeUV991IdmJaL4KUwBw=
X-Gm-Gg: ASbGncuavXtv0bMuXtITXhKXQMoUQvujbPvIfq0slQeh9xH8qQZSmjTmB1P/xKX+vuS
	SEvF3n8cvzx5vYWViD+btWh/BCVTUy/ngvUG67Rmib44Lti+lDDIGhEg7rPlAIr8l7DtOHI3xi9
	vcycO3BxZgepn5A3drQDDd1UV/QtJuinuOnyxhmkpMROelmoaocID8kF0B52GP+4fSjDjmaojIV
	8JuqvUfr/APoTayRbA+oaNPemRDf7k8abGtrSBxSCmJZP6wdKyG9lkf8y5Jj2NyO57egcO71615
	TmULOXsH9DiFEMtadEZSXxoL0QfBpjqDCETorPw1Hr9Dduc=
X-Received: by 2002:a17:90b:52c6:b0:312:1d2d:18df with SMTP id 98e67ed59e1d1-3130cd67f87mr7348325a91.23.1749101106948;
        Wed, 04 Jun 2025 22:25:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGizPUuInvJsfPhGgAodQGX82jrYIhBDW3+fyLJE7myE9Z/9iGHSaKGIpVNnw9+dcwQ6gmrMw==
X-Received: by 2002:a17:90b:52c6:b0:312:1d2d:18df with SMTP id 98e67ed59e1d1-3130cd67f87mr7348282a91.23.1749101106412;
        Wed, 04 Jun 2025 22:25:06 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3132c0ad55csm621815a91.40.2025.06.04.22.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 22:25:06 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 05 Jun 2025 10:54:45 +0530
Subject: [PATCH v3 2/2] PCI/portdrv: Add support for PCIe wake interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-wake_irq_support-v3-2-7ba56dc909a5@oss.qualcomm.com>
References: <20250605-wake_irq_support-v3-0-7ba56dc909a5@oss.qualcomm.com>
In-Reply-To: <20250605-wake_irq_support-v3-0-7ba56dc909a5@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Sherry Sun <sherry.sun@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749101092; l=5481;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=vlJXvAa9X+ezoDZ5kkgtL0pzbm0tSOq3EooVS4mttsg=;
 b=+u3TTrTXFx8RDNANNurLLF+fnnpi0DJrWjY6QqkCiRbl4RP7ve/2ANlZxpia7e9xsxF4S9N7P
 ketU6RZ+8BoBbPrH5VNtMwAfMDhwgmizFzSGxHCPQe4R3h+LZ+A/cz9
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=RMizH5i+ c=1 sm=1 tr=0 ts=68412a33 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=8AirrxEcAAAA:8
 a=4qw4IQhyAdn_hH04eJkA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA0NSBTYWx0ZWRfX51dwpj4dHAS+
 zN7/UzhKoA789+4J3szT3tyS86ze/DfY8/R/G5slYKrysf89DmHxxFXFqU3/6lzTNcyrsVqrCK5
 tXfo2ZQpYxjAGNonmTsoJ046iZoAPbDlpvNRwGNID7hpYSUMA53zOwir7quhcQp3joVzBZASOmn
 XnJQJWDBJ1bi6VKgmQq5sNlsangmSCTB/uVCCTBxtFVZwSzo9gEpJXz8p1wgWKtUzBtGk2WhLQW
 83kKPdRjsbznLdS+037eTB73Ha0JcnWVsL7K7Bk3hvGVZn5iDzLfTNRsIWpm6NYzmSStcBs2KxH
 cklHvVXH9EXzLAaGlPBrftqDVz0wFxUOmqTch6P99/RFS2MrxVeoNuV1joRa5LLVgzcDVzu6HQR
 ijwwMe6hnvS5P739Z0xVzSAtf0i/rsElsJ4hsFC6CviuEuVcy97VDtvDQk/zhyIIsZJpsIEC
X-Proofpoint-GUID: 6Mi6zvp3OJm4TfgB3uCpTB4OBjF4DXVV
X-Proofpoint-ORIG-GUID: 6Mi6zvp3OJm4TfgB3uCpTB4OBjF4DXVV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_01,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506050045

PCIe wake interrupt is needed for bringing back PCIe device state
from D3cold to D0.

Implement new functions, of_pci_setup_wake_irq() and
of_pci_teardown_wake_irq(), to manage wake interrupts for PCI devices
using the Device Tree.

From the port bus driver call these functions to enable wake support
for bridges.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Tested-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/pci/of.c           | 67 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h          |  6 +++++
 drivers/pci/pcie/portdrv.c | 12 ++++++++-
 3 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index ab7a8252bf4137a17971c3eb8ab70ce78ca70969..3487cd62d81f0a66e7408e286475e8d91c2e410a 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -7,6 +7,7 @@
 #define pr_fmt(fmt)	"PCI: OF: " fmt
 
 #include <linux/cleanup.h>
+#include <linux/gpio/consumer.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
@@ -15,6 +16,7 @@
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
 #include "pci.h"
 
 #ifdef CONFIG_PCI
@@ -966,3 +968,68 @@ u32 of_pci_get_slot_power_limit(struct device_node *node,
 	return slot_power_limit_mw;
 }
 EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
+
+/**
+ * of_pci_slot_setup_wake_irq - Set up wake interrupt for PCI device
+ * @pdev: The PCI device structure
+ *
+ * This function sets up the wake interrupt for a PCI device by getting the
+ * corresponding WAKE# gpio from the device tree, and configuring it as a
+ * dedicated wake interrupt.
+ *
+ * Return: 0 if the WAKE# gpio is not available or successfully parsed else
+ * errno otherwise.
+ */
+int of_pci_slot_setup_wake_irq(struct pci_dev *pdev)
+{
+	struct gpio_desc *wake;
+	struct device_node *dn;
+	int ret, wake_irq;
+
+	dn = pci_device_to_OF_node(pdev);
+	if (!dn)
+		return 0;
+
+	wake = devm_fwnode_gpiod_get(&pdev->dev, of_fwnode_handle(dn),
+				     "wake", GPIOD_IN, NULL);
+	if (IS_ERR(wake) && PTR_ERR(wake) != -ENOENT) {
+		dev_err(&pdev->dev, "Failed to get wake GPIO: %ld\n", PTR_ERR(wake));
+		return PTR_ERR(wake);
+	}
+	if (IS_ERR(wake))
+		return 0;
+
+	wake_irq = gpiod_to_irq(wake);
+	if (wake_irq < 0) {
+		dev_err(&pdev->dev, "Dailed to get wake irq: %d\n", wake_irq);
+		return wake_irq;
+	}
+
+	device_init_wakeup(&pdev->dev, true);
+
+	ret = dev_pm_set_dedicated_wake_irq(&pdev->dev, wake_irq);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to set wake IRQ: %d\n", ret);
+		device_init_wakeup(&pdev->dev, false);
+		return ret;
+	}
+	irq_set_irq_type(wake_irq, IRQ_TYPE_EDGE_FALLING);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_pci_slot_setup_wake_irq);
+
+/**
+ * of_pci_slot_teardown_wake_irq - Teardown wake interrupt setup for PCI device
+ *
+ * @pdev: The PCI device structure
+ *
+ * This function tears down the wake interrupt setup for a PCI device,
+ * clearing the dedicated wake interrupt and disabling device wake-up.
+ */
+void of_pci_slot_teardown_wake_irq(struct pci_dev *pdev)
+{
+	dev_pm_clear_wake_irq(&pdev->dev);
+	device_init_wakeup(&pdev->dev, false);
+}
+EXPORT_SYMBOL_GPL(of_pci_slot_teardown_wake_irq);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 39f368d2f26de872f6484c6cb4e12752abfff7bc..dd7a4da1225bbdb1dff82707b580e7e0a95a5abf 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -888,6 +888,9 @@ void pci_release_of_node(struct pci_dev *dev);
 void pci_set_bus_of_node(struct pci_bus *bus);
 void pci_release_bus_of_node(struct pci_bus *bus);
 
+int of_pci_slot_setup_wake_irq(struct pci_dev *pdev);
+void of_pci_slot_teardown_wake_irq(struct pci_dev *pdev);
+
 int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge);
 bool of_pci_supply_present(struct device_node *np);
 
@@ -931,6 +934,9 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
 	return 0;
 }
 
+static int of_pci_slot_setup_wake_irq(struct pci_dev *pdev) { return 0; }
+static void of_pci_slot_teardown_wake_irq(struct pci_dev *pdev) { }
+
 static inline bool of_pci_supply_present(struct device_node *np)
 {
 	return false;
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index e8318fd5f6ed537a1b236a3a0f054161d5710abd..9a6beec87e4523a33ecace684109cd44e025c97b 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -694,12 +694,18 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	     (type != PCI_EXP_TYPE_RC_EC)))
 		return -ENODEV;
 
+	status = of_pci_slot_setup_wake_irq(dev);
+	if (status)
+		return status;
+
 	if (type == PCI_EXP_TYPE_RC_EC)
 		pcie_link_rcec(dev);
 
 	status = pcie_port_device_register(dev);
-	if (status)
+	if (status) {
+		of_pci_slot_teardown_wake_irq(dev);
 		return status;
+	}
 
 	pci_save_state(dev);
 
@@ -732,6 +738,8 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
 
 	pcie_port_device_remove(dev);
 
+	of_pci_slot_teardown_wake_irq(dev);
+
 	pci_disable_device(dev);
 }
 
@@ -744,6 +752,8 @@ static void pcie_portdrv_shutdown(struct pci_dev *dev)
 	}
 
 	pcie_port_device_remove(dev);
+
+	of_pci_slot_teardown_wake_irq(dev);
 }
 
 static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,

-- 
2.34.1


