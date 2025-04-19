Return-Path: <linux-pci+bounces-26269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B517A941D6
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 07:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4655F8E1BB4
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 05:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B98178CC8;
	Sat, 19 Apr 2025 05:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B3tfcXbF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB85B19066D
	for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 05:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745041417; cv=none; b=XJ+mNI3ZA4iCijrj9y7I/pg/t/eQ2mp387grAQfVqqbpMemK0Q3ty55AiRWQklEy/4Gegzi5WlS2bBtB4XIlmB09Msd3EFGGxrVMrYq792nzgGkT8sShKGVGRRMCxiOXqGm7bLhuQvgRtpsfzV9QmMiOU2CvmAbIHXjO2OvIzQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745041417; c=relaxed/simple;
	bh=l+iLQRs3Sd9q7CUv85IAG9PJ5au9ED/F26dF58ymUtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AZv7Ms9KhrSrgBPQ5NNG5ukT2DcT3zAhludpGvv7e2ZvfQkGQWf6TTLCJ96CSz0cLglRAiVBYTdH7XhOphLMrZv87whYbHLjuB0x+JOjsbXelberKufmXUJRM6XscMrn/9OLDDnmqqM+jtjwS9BeeSTEGeMU+YWqId777UTX9k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B3tfcXbF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53J4knec030962
	for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 05:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HBnyWza8rS1v7HrmjjSzQ1pFiEcjxC/rJnoS7wzUeqY=; b=B3tfcXbF88TMtoNU
	OyzIzxLDCHBGM/Kc9nQOwItkQ6M/XoT2DGsLx6TmsLZzevrG4LHEN7HDVJYiMi2+
	Ld0jCnpyf3yLbfGVrpavWUCVs0QVxvf6XTyumJXgJ/SvyBcMT7GluJa9llc7qSuY
	agvY65shLDtBkKM4s60FZg+NO1eQSqJLI1dcyv+NRNxZtjfeFVyRaH+WSljjH5Tq
	1jn4gvtQA3XuL42w3Nqyzw+hJXrL03N/wDGdS0I8CDe4UwaDaaBChX01DHgKkWTz
	fayzgJB6fsnkTfIBWhtFzLdH/2rgqImvwj4ASmP3ERi6rRhJwW2pwfTQl1YJMB1s
	sht2bQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4643e185cj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 05:43:33 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-224191d9228so31873585ad.3
        for <linux-pci@vger.kernel.org>; Fri, 18 Apr 2025 22:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745041412; x=1745646212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBnyWza8rS1v7HrmjjSzQ1pFiEcjxC/rJnoS7wzUeqY=;
        b=R5nZVkMrQxkay4Wy2I3ucrqQcHPzyqiNzltr0cgJmSSKdv64pkFqAR1+R4105xVZaJ
         GHZwoYRM09hneB8UOkUJoqNYKouYuLygcehOVCnQT4rYi9CTvcR6fkQ9aXxn/hT3Yyn9
         0LCwBGsJA4QEiDy4bYEXB+rWnRwB/CupJUY3YkbmPMkv8609tEzYuGUxjg07fidZ7tif
         7dCxH5ejzktF62yktwpxDp8yeHAw8EWfZ7i4Q8CFC7+P/EYvnCHhpObCRKI6tQSAeG1l
         RUByeqsdiEBLViND5GzRkkZjqEgodOj7lZzUhltSVyZsLszJ8ySSlXbQ7PAay4nr8Ajr
         FyHg==
X-Forwarded-Encrypted: i=1; AJvYcCVS+xABnw83Y6oFkjUkvdl6eDQJl/QMiiPNigb5lFOCWdcZNo9C3u9fv3wx8ansQ8B+xtoEa4oVego=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFyhtpMSOQ1NJwcMrw22PRitpx4j1CxKbNpCnE8EnwiXHe+cv4
	XtF3dDf7MAEa49NSO7lYCmFQYNWH+D6Q3+Ogqp9ID/WKtSMk5i69kGRaY2K/MaX2yVBE47hzkBI
	yANBTE4DyaBLnXtNi7fkx18+hxa68/0VAukojM3VKZAA502TU/njodIAAZ8Kb8XsqSk4=
X-Gm-Gg: ASbGncug2rvjJthecJGZODRwPP6/hYKt9ML2B0YOKCwRrv2TH8TyFSI/Yc2srFSeI6v
	shWXIa+zrBV8RMHlQuF4J9MeBUrJ/pwAA/YSQ81gDGEkrW2lYpXxSIslJco+XScyJr8UNLRWd4c
	kapomKR3dkiSXAYIRV92T7rrFmSzwqVjW+ochGppPbSd7Oxe5FTT0Op8hn+nPm/Rt9Ew+JSc9m9
	1+tgNwXgNWVRkxbWlnF3+YDAEPCPHDa+tJ6dzViFs+dKozV4vfMLXMQMPB0x0MmffYdQSwuJPNX
	aBudRqOFmwmet/Nd0pEsk4XPn1d98by4XNLK6m6deuArBmc=
X-Received: by 2002:a17:903:32d1:b0:224:fa0:36da with SMTP id d9443c01a7336-22c5358321dmr58141355ad.18.1745041411756;
        Fri, 18 Apr 2025 22:43:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzWEAMRvo6PUazfjfHTnWx8uUrubDqpzpgGItMl2BoJHPEaH7gA3csflj14Pu/DY/NJrWd/w==
X-Received: by 2002:a17:903:32d1:b0:224:fa0:36da with SMTP id d9443c01a7336-22c5358321dmr58141215ad.18.1745041411390;
        Fri, 18 Apr 2025 22:43:31 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eceb37sm26014945ad.179.2025.04.18.22.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 22:43:31 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 19 Apr 2025 11:13:04 +0530
Subject: [PATCH v2 2/2] PCI: Add support for PCIe wake interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250419-wake_irq_support-v2-2-06baed9a87a1@oss.qualcomm.com>
References: <20250419-wake_irq_support-v2-0-06baed9a87a1@oss.qualcomm.com>
In-Reply-To: <20250419-wake_irq_support-v2-0-06baed9a87a1@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745041398; l=5149;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=l+iLQRs3Sd9q7CUv85IAG9PJ5au9ED/F26dF58ymUtk=;
 b=Y3KF+GIIZYUGLI6u3qqIz8HUKIe4N/LUFLwc4f/nbvf/ewo8/wiGDrihcavfWs4SaYd9VSleO
 s+isiQTAOLfDcGjNQPpie72yhaQFIUqCPiiKgGS72yxjAIgT6hoHMeH
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=ZOrXmW7b c=1 sm=1 tr=0 ts=68033805 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=iljMX2kAvVRlE-iODa4A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: yjqVPhGL-Wxzg1C5s41HfEcdcTqmDpn0
X-Proofpoint-ORIG-GUID: yjqVPhGL-Wxzg1C5s41HfEcdcTqmDpn0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_02,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0 phishscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504190043

PCIe wake interrupt is needed for bringing back PCIe device state
from D3cold to D0.

Implement new functions, of_pci_setup_wake_irq() and
of_pci_teardown_wake_irq(), to manage wake interrupts for PCI devices
using the Device Tree.

From the port bus driver call these functions to enable wake support
for bridges.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/of.c           | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h          |  6 +++++
 drivers/pci/pcie/portdrv.c | 12 +++++++++-
 3 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index ab7a8252bf4137a17971c3eb8ab70ce78ca70969..13623797c88a03dfb9d9079518d87a5e1e68df38 100644
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
@@ -966,3 +968,61 @@ u32 of_pci_get_slot_power_limit(struct device_node *node,
 	return slot_power_limit_mw;
 }
 EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
+
+/**
+ * of_pci_setup_wake_irq - Set up wake interrupt for PCI device
+ * @pdev: The PCI device structure
+ *
+ * This function sets up the wake interrupt for a PCI device by getting the
+ * corresponding GPIO pin from the device tree, and configuring it as a
+ * dedicated wake interrupt.
+ *
+ * Return: 0 if the wake gpio is not available or successfully parsed else
+ * errno otherwise.
+ */
+int of_pci_setup_wake_irq(struct pci_dev *pdev)
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
+	if (IS_ERR(wake)) {
+		dev_warn(&pdev->dev, "Cannot get wake GPIO\n");
+		return 0;
+	}
+
+	wake_irq = gpiod_to_irq(wake);
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
+EXPORT_SYMBOL_GPL(of_pci_setup_wake_irq);
+
+/**
+ * of_pci_teardown_wake_irq - Teardown wake interrupt setup for PCI device
+ *
+ * @pdev: The PCI device structure
+ *
+ * This function tears down the wake interrupt setup for a PCI device,
+ * clearing the dedicated wake interrupt and disabling device wake-up.
+ */
+void of_pci_teardown_wake_irq(struct pci_dev *pdev)
+{
+	dev_pm_clear_wake_irq(&pdev->dev);
+	device_init_wakeup(&pdev->dev, false);
+}
+EXPORT_SYMBOL_GPL(of_pci_teardown_wake_irq);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b81e99cd4b62a3022c8b07a09f212f6888674487..b2f65289f4156fa1851c2d2f20c4ca948f36258f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -888,6 +888,9 @@ void pci_release_of_node(struct pci_dev *dev);
 void pci_set_bus_of_node(struct pci_bus *bus);
 void pci_release_bus_of_node(struct pci_bus *bus);
 
+int of_pci_setup_wake_irq(struct pci_dev *pdev);
+void of_pci_teardown_wake_irq(struct pci_dev *pdev);
+
 int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge);
 bool of_pci_supply_present(struct device_node *np);
 
@@ -931,6 +934,9 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
 	return 0;
 }
 
+static int of_pci_setup_wake_irq(struct pci_dev *pdev) { return 0; }
+static void of_pci_teardown_wake_irq(struct pci_dev *pdev) { }
+
 static inline bool of_pci_supply_present(struct device_node *np)
 {
 	return false;
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index e8318fd5f6ed537a1b236a3a0f054161d5710abd..33220ecf821c348d49782855eb5aa3f2fe5c335e 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -694,12 +694,18 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	     (type != PCI_EXP_TYPE_RC_EC)))
 		return -ENODEV;
 
+	status = of_pci_setup_wake_irq(dev);
+	if (status)
+		return status;
+
 	if (type == PCI_EXP_TYPE_RC_EC)
 		pcie_link_rcec(dev);
 
 	status = pcie_port_device_register(dev);
-	if (status)
+	if (status) {
+		of_pci_teardown_wake_irq(dev);
 		return status;
+	}
 
 	pci_save_state(dev);
 
@@ -732,6 +738,8 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
 
 	pcie_port_device_remove(dev);
 
+	of_pci_teardown_wake_irq(dev);
+
 	pci_disable_device(dev);
 }
 
@@ -744,6 +752,8 @@ static void pcie_portdrv_shutdown(struct pci_dev *dev)
 	}
 
 	pcie_port_device_remove(dev);
+
+	of_pci_teardown_wake_irq(dev);
 }
 
 static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,

-- 
2.34.1


