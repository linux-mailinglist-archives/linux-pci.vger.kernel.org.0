Return-Path: <linux-pci+bounces-25033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0548A773A1
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 06:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0031885AC8
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 04:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D7A1DF739;
	Tue,  1 Apr 2025 04:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZyPtIp/Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620BB1DEFD2
	for <linux-pci@vger.kernel.org>; Tue,  1 Apr 2025 04:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743482599; cv=none; b=aNXJyTYIrcaqsfnpFTyu2crdFBROr1BUrX8TFGx/BOglV3tueFms9dvFV34UaYfaAqN/XM9SgzzR/qKfdAJ1AFilB02wU/QawZUueWmcqhkA6m+wCs9DI7iwTbmM7EA9RatHOjPq/J+R19xD2EQDxWtdxfo46ERg8JRgl4uBA7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743482599; c=relaxed/simple;
	bh=ux2W3fa5UF+jdQyyWQKpB6Q0rrH+j8lj+L+VJ6ZwaEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fe3SFhxR63KAHf7EAmksOo0RTEEwA+TDi6C+RvrkeWDrBsjT6/pa0D66PIpDGKBeFuG4O1fbzrzHHLaFfd1pRg8u/3h7BHML5zRzNV6cO2kjsySeROvrNbGQ/vHWF0kZKgXLdBT4FLvW7/ZIVVMYjuXg8OyqPDpk/ANjhu6VEOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZyPtIp/Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VFCrpC032704
	for <linux-pci@vger.kernel.org>; Tue, 1 Apr 2025 04:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bhbf80HBiZjeWneDSbVO1CX4rg1V65JnwlZBLRmEgRg=; b=ZyPtIp/ZGEaJeLgw
	k3v0qQyWNrseS532oecOPu7m+If9/Q/3UtsuAOBkaE5Jusp6fBPv6Ezqvrt1kG9B
	H1UZTF8IVzjSA8+YCw+oBKMZKS9cipbcit9UudQYI8Jg+xTpcwdBuz61DhIngEWL
	jir8MvW403vIKQOIwh0v99Sq4PWl+I16lVYq63+xIxLN+WulgY7b37m0/ycJeYI0
	JtoJEc1rTQ1MpUkGyyJeHKdDcHQ5rqsddzB3iw7txmoCW5h4KubuFnkkx0BYsm3w
	TOYt6MUEtUp3aKnKaTcZQbsILmghvCfQ45yaByRk6jCLvGF/aEuRijtv9vxh0Dar
	Gx4+3A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p67qerdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 01 Apr 2025 04:43:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-227a8cdd272so85670885ad.2
        for <linux-pci@vger.kernel.org>; Mon, 31 Mar 2025 21:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743482595; x=1744087395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bhbf80HBiZjeWneDSbVO1CX4rg1V65JnwlZBLRmEgRg=;
        b=ptFBNLalsJsaQgUSG8oMgUicstFyRSNSEL929pJVQcHsGeKugva3Ilu+BIc58S0x0l
         VxOZj9oUx/LkWXqeKn6vLqOVqkFJHPdlhMW7Cj83XklkfWGRgIZlw4EiH7WB5KI7FVqF
         m6FLVG4eYsFLY0fN7oVw7zzQ+znWVLwkS0AW2iHphxppnTG4ZzD2XzRjLWhnYZLDOMjT
         4m3KKYym5SQg2r5MvyMGPqD9H2+IuFs1vYzE+qKm0bTBf8le5+qRkE3c5NP/OEaEV5Xp
         3+mETal0l3CN6ZRfyYTfASFQiUhT8CVArbnw0p4zfmBw6wD+BjzT3Y7hXeeuBFcpmUIw
         wTXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFSuA24hgrraDL9eePbaUJiFKV3golbHcfEVFccfHNCA11+FnOX/ABAia4kZ5VU8b/SL9nRMZXpwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT8kRCE8GNQHi3kuBU0rmn+W+qmxvHhIAmfmKAsZEH1XyXpzQ0
	e0Oc8HoIB2YjaYb447jK8Um93I2+5hirWZko9XZWp1CVeffYlQ/IwK0KFYUPuDXwrUyh8K/1aUa
	r6NHNgUEViGCf4zGScplAImdZ7kGn3ZDPjzjYzVsRgw8xNGoM0gxsANYEV+DTLuOG9wI=
X-Gm-Gg: ASbGncu71pyUMwFKIN9hNSnmXsJfX35u3McPrTX62GataHP5KIFDWX2NpimVkNLScIN
	kZnUPZqFZ04Ug5jsDEKM+/ZqrQqJFoAq/5axWD0aUjoTirOAce94dONNyxG52DBrkuEF6Kj7GuS
	H+amsXkadzIXQmwz3JkWSUq75nhDA+VGD/cQVKTwMR66niS7Mrh3BSbfM1jCF4BnAT+E18PoVYd
	riXZ130D08F1VHvEnhw5fo0khbDqwZ+XahVfkcAFeDCEQiOmBWDVdOSYWeYF2wTbYpLqH4rbOHD
	CZoN4I16oncxvF16YA2adVSyIxVr7PkvMEu+8ACt5jkj5CgCmp4=
X-Received: by 2002:a05:6a00:1784:b0:736:8c0f:7758 with SMTP id d2e1a72fcca58-7398038028cmr16685912b3a.10.1743482594816;
        Mon, 31 Mar 2025 21:43:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz+MOxmKD2YZ5JuPKKSQQaWVdGpFuYmspO+ReGzpMU1Pa0EptpT2IjBujNxWCzYr7pQoED6A==
X-Received: by 2002:a05:6a00:1784:b0:736:8c0f:7758 with SMTP id d2e1a72fcca58-7398038028cmr16685882b3a.10.1743482594367;
        Mon, 31 Mar 2025 21:43:14 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970deec96sm7940294b3a.34.2025.03.31.21.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 21:43:14 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 01 Apr 2025 10:12:44 +0530
Subject: [PATCH 2/2] PCI: Add support for PCIe wake interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250401-wake_irq_support-v1-2-d2e22f4a0efd@oss.qualcomm.com>
References: <20250401-wake_irq_support-v1-0-d2e22f4a0efd@oss.qualcomm.com>
In-Reply-To: <20250401-wake_irq_support-v1-0-d2e22f4a0efd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743482582; l=4789;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=ux2W3fa5UF+jdQyyWQKpB6Q0rrH+j8lj+L+VJ6ZwaEc=;
 b=j77PZzhEvi2s1vAWkryDc1cbVK09KS8RrSQxK5DVlcoCLxjZGd2QdV+Zrd/IBPCbx75WNPsfh
 JmTXTmY9JXjDyN/iPT4ihlhT3Ud411gAn1DSnypn1fVq6gnvAXNHT/L
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=fMI53Yae c=1 sm=1 tr=0 ts=67eb6ee4 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=iljMX2kAvVRlE-iODa4A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: bwEtuipT0esxDEuqX2E9193Fd0oh_BX6
X-Proofpoint-GUID: bwEtuipT0esxDEuqX2E9193Fd0oh_BX6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_01,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504010030

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
 drivers/pci/pcie/portdrv.c |  6 +++++
 3 files changed, 72 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 7a806f5c0d201bc322d4a53d6ac47cab2cd28c55..abb0ba001edf604170aaa118f7fdc1a1709c171f 100644
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
@@ -851,3 +853,61 @@ u32 of_pci_get_slot_power_limit(struct device_node *node,
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
index 01e51db8d285af54673db3ea526ceda073c94ec9..6e3d90db4b2505dd3885b482d4c5eafa033714e7 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -820,6 +820,9 @@ void pci_release_of_node(struct pci_dev *dev);
 void pci_set_bus_of_node(struct pci_bus *bus);
 void pci_release_bus_of_node(struct pci_bus *bus);
 
+int of_pci_setup_wake_irq(struct pci_dev *pdev);
+void of_pci_teardown_wake_irq(struct pci_dev *pdev);
+
 int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge);
 bool of_pci_supply_present(struct device_node *np);
 
@@ -863,6 +866,9 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
 	return 0;
 }
 
+static int of_pci_setup_wake_irq(struct pci_dev *pdev) { return 0; }
+static void of_pci_teardown_wake_irq(struct pci_dev *pdev) { }
+
 static inline bool of_pci_supply_present(struct device_node *np)
 {
 	return false;
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 02e73099bad0532466fa10f549cc3c5013aa1bbb..fe1da757e9eca0f82ae0d8043c0e4547ac9c30b6 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -695,6 +695,10 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	if (type == PCI_EXP_TYPE_RC_EC)
 		pcie_link_rcec(dev);
 
+	status = of_pci_setup_wake_irq(dev);
+	if (status)
+		return status;
+
 	status = pcie_port_device_register(dev);
 	if (status)
 		return status;
@@ -728,6 +732,8 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
 		pm_runtime_dont_use_autosuspend(&dev->dev);
 	}
 
+	of_pci_teardown_wake_irq(dev);
+
 	pcie_port_device_remove(dev);
 
 	pci_disable_device(dev);

-- 
2.34.1


