Return-Path: <linux-pci+bounces-33285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A20B18091
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 13:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4337A845EE
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 11:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577C0246327;
	Fri,  1 Aug 2025 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K/ucVyCp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7870E23A995
	for <linux-pci@vger.kernel.org>; Fri,  1 Aug 2025 11:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754046013; cv=none; b=j1GqPyB3fSOQxZXDFKvHv/k4BjIUkowjEY4/0r6Ppy5ODd/bmSZbHSqWR/6+UqZixcVEte0hKX38Wot1ptn0WjldW5764yXD65tb8cvZmGB0TRkFJdNLupW0VA0mVzpMqYt9fftK2lYtWQiui+ocd+plivtsA+VFlEqG9roYvso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754046013; c=relaxed/simple;
	bh=Kp7aLz6ua2U/kn6vy6jAG2izbyo0Wnrw280JYTZZa0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hECN9r02FGmjv4jU6eNvLWBPTvRhJ1jCT+kuPV4nLCfU26KQKqJW1ccaszdGjEj6jiTxs3peq8HM8f0Yn0mKNj5ynSd7Xs53OyZdyNjG9qzZm2fe+SjiXlis/bN+C6gch59OmLqJtJ6OV3inRrgT9fEF/2aVC1qHhNaskG0Ed84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K/ucVyCp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5719g6FF006268
	for <linux-pci@vger.kernel.org>; Fri, 1 Aug 2025 11:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oEMFi3yFFkbpJ7pR+UhigZi4QAV8nxhHoe8LrmMYYTA=; b=K/ucVyCpYUpqLgBZ
	j9GS7cUVB/ZmfFQ7ErzZdU9dVKOI3j6dUUXM/6jUZKZg5QudjVAJk4D0t8WbfiZE
	jw6dcjvhPlt8R0UwVpkuhviGsQ3m+BB0KzhvSftt2khlHv7+vbOQt6IFYS4R4Ej5
	dxCTh6MPjGt/d8g0K1w2TKNRKeqA9GaoAyO1YtKn46dPw7Q+aF2Nz0voJo+PhATO
	joA5Y8m03fAM6bSh9jsYqvRjQwSnBmtC3pCQRpFcVvszoyCAm7q1L8tqpI+/oMzv
	7WAyRXOB2VBSI16rfzvM/gQyPWBONmil1xALZfTf6ODexU8FeQ1+iWHBfCjPx2p0
	7m+qJQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 488u6508sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 01 Aug 2025 11:00:10 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31f2a98d91eso2126902a91.3
        for <linux-pci@vger.kernel.org>; Fri, 01 Aug 2025 04:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754046009; x=1754650809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEMFi3yFFkbpJ7pR+UhigZi4QAV8nxhHoe8LrmMYYTA=;
        b=WG+vfxJthacfvuVvImdlUnh+F1GjLGFRoIPotcTwzt98f5T/+Dn7WzB8LKSyj75iQ7
         4XSQWX5V7F0CiNSBpm1g2M+Y86QGaWqplp8H9NdUDbTvTWm/IN10SYuK++XXwiKrrEyk
         jmzBBI65zl1GOPFSSpPT59qXzJUyFHpl318TyGKVeO3CEcaKrXvOW8nvfhuBo4ubasMD
         Te3qtKCBSluoVE259PR8BIfSgnODKYLzV+rsm4e7DvBtk0+CJxRD4UmSmJJAo45fj0Qg
         5ORBlcOeh3pWgA5lcqql17FzplNPNjmEvRLK7fOcPXF6wmoZX3fRvL6eKmoQI+WzKdMu
         MyjA==
X-Forwarded-Encrypted: i=1; AJvYcCVc6SAZmJ/Y5n6zaj2ptf9v69aUvEhFsGzza5e1HtWRaoav0NbiXWkfIhOFXeJLJjoG0B102xv3fOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzk+pNT+qoAHhDbOd3pxSzumYMT0DP+AuodGwPH5ndW5P3/I78
	TVVYzDUTZD2pWY+ABma8JlIduyIuA8WH7WHXT7w05+eE7Sllh5JWOsoa2cWyD4lZq/c3BsBXLpX
	4Wkt04BgZtOu6D/6THECkg5LGZaqVKFMLKkLXUiipzcq7Zv0aSWitAj+lAP0mgms=
X-Gm-Gg: ASbGncti3lV/LAFuIeleVjBEs4hvJbmpeGTV2fJNPTQoXoN+TKECCuh4Rjaiz4G0hbS
	LLl9t7H6lOb8juBnktSB8G4idL2N48QVGbmX9PoRpYC1/jeAPuQAaeR0HeaJ9Gg0u4LIkGXZrA9
	yR4WUmyXdnxFqEH52Q39ETJ6KDbVpoC/o2YPHW31XUK+pwtLTzsb2GPKihGOu+95W0XcG4AxMDc
	tt/3dx6WJYuFSHvui6kXlBFiDoxHXAs1533XICv+k0s7eOnUhGGLcrc3JtqIlVAM4hqIVo118l3
	h+eAh06Od9a1RxW5Eo5VrT4q3rhlHpUnvs6vLMggLXNzWLfQa3QcxtgQZgeBno8+FT2JyGhtX38
	=
X-Received: by 2002:a17:90b:2511:b0:31e:3bbc:e9e6 with SMTP id 98e67ed59e1d1-31f5de4b9demr10317708a91.19.1754046008559;
        Fri, 01 Aug 2025 04:00:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1a77JjJtoze4OxqCff+khRd9sEZFHd1GYlo3bjukpx9Fh2DsfOlLdvQnBiwD1wkCTknZygw==
X-Received: by 2002:a17:90b:2511:b0:31e:3bbc:e9e6 with SMTP id 98e67ed59e1d1-31f5de4b9demr10317670a91.19.1754046008033;
        Fri, 01 Aug 2025 04:00:08 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f0b4aesm7154395a91.26.2025.08.01.04.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 04:00:07 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 01 Aug 2025 16:29:44 +0530
Subject: [PATCH v4 3/3] PCI: Add support for PCIe WAKE# interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-wake_irq_support-v4-3-6b6639013a1a@oss.qualcomm.com>
References: <20250801-wake_irq_support-v4-0-6b6639013a1a@oss.qualcomm.com>
In-Reply-To: <20250801-wake_irq_support-v4-0-6b6639013a1a@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, sherry.sun@nxp.com,
        linux-pm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754045985; l=8173;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Kp7aLz6ua2U/kn6vy6jAG2izbyo0Wnrw280JYTZZa0o=;
 b=g5pBTW9TyAhCznAys9dfE3nfBdbVVklgPlSnpz/26ZyyOP0ZwZd9UFUCPgPPKpx0XXuyv6oCU
 xT7IcLaN/26Bq9HgztbUiMbg8NLAbcxlscON+J7HEGNAJGc9AN8aywm
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: AUOhJ4yjUun_DQ15_ha-c6YrcKFL8PuH
X-Proofpoint-GUID: AUOhJ4yjUun_DQ15_ha-c6YrcKFL8PuH
X-Authority-Analysis: v=2.4 cv=f+RIBPyM c=1 sm=1 tr=0 ts=688c9e3a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=pg203nmD_v0msc3Z_NIA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA4MSBTYWx0ZWRfXwLXr38pRdnms
 h2dw6zj5zD0pFx+tEMWG/wfeuX1kf9m5YlrDhg1PuwSf5LBXIqgxE+CrInZW4/hHAnCw0QLwVk8
 TW4J3Y6pgcYK4fiqlGWGN4OYNqVzoSCRrd7WamwUxLb9chDt72CSbX2Eq4g12lniFmQOLzSAkDi
 89bmPECDNEhewtbaB9pd5yhRjJa5ffapJND8xMUYCcToxstcmqjK6t9/S9mAy9EXSnPDrXLbLA/
 Slzw0arRJShwv/7gdEa/q6yTyi2oXmoqyhh8If5ux8c6vxnOmg/yzmLkWgjrabaPEusa9d8PqOM
 pynSSrFuJuftulElfeVCgIkdKnO6B+ofd4pbZOG/1azrz+NYanNn7AEZd0t5siq/hcz6F4/RHu0
 QaPXmbPxKY0L8IZuTIKptSwbFzwvtPar4G1JdP+hY4cD2vjfbFVhNwADyMyh3A8LXbU98/Y6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010081

According to the PCIe specification 6, sec 5.3.3.2, there are two defined
wakeup mechanisms: Beacon and WAKE# for the Link wakeup mechanisms to
provide a means of signaling the platform to re-establish power and
reference clocks to the components within its domain. Adding WAKE#
support in PCI framework.

According to the PCIe specification, multiple WAKE# signals can exist in a
system. In configurations involving a PCIe switch, each downstream port
(DSP) of the switch may be connected to a separate WAKE# line, allowing
each endpoint to signal WAKE# independently. To support this, the WAKE#
should be described in the device tree node of the upstream bridge to which
the endpoint is connected. For example, in a switch-based topology, the
WAKE# can be defined in the DSP of the switch. In a direct connection
scenario, the WAKE# can be defined in the root port. If all endpoints share
a single WAKE# line, the GPIO should be defined in the root port.

During endpoint probe, the driver searches for the WAKE# in its immediate
upstream bridge. If not found, it continues walking up the hierarchy until
it either finds a WAKE# or reaches the root port. Once found, the driver
registers the wake IRQ in shared mode, as the WAKE# may be shared among
multiple endpoints.

When the IRQ is asserted, the wake handler triggers a pm_runtime_resume().
The PM framework ensures that the parent device is resumed before the
child i.e controller driver which can bring back link to D0.

WAKE# is added in dts schema and merged based on this link.

Link: https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com/
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/of.c         | 66 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci-driver.c | 10 ++++++++
 drivers/pci/pci.h        | 10 ++++++++
 drivers/pci/probe.c      |  2 ++
 drivers/pci/remove.c     |  1 +
 include/linux/pci.h      |  2 ++
 6 files changed, 91 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 3579265f119845637e163d9051437c89662762f8..5a832bbf2dd5da728080f83220f47c3578cb6b5a 100644
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
@@ -586,6 +588,29 @@ int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
 	return irq_create_of_mapping(&oirq);
 }
 EXPORT_SYMBOL_GPL(of_irq_parse_and_map_pci);
+
+void pci_parse_of_wake_gpio(struct pci_dev *dev)
+{
+	struct device_node *dn __free(device_node) = pci_device_to_OF_node(dev);
+	struct gpio_desc *gpio;
+
+	if (!dn)
+		return;
+
+	gpio = fwnode_gpiod_get_index(of_fwnode_handle(no_free_ptr(dn)),
+				      "wake", 0, GPIOD_IN, NULL);
+	if (!IS_ERR(gpio))
+		dev->wake = gpio;
+}
+
+void pci_remove_of_wake_gpio(struct pci_dev *dev)
+{
+	if (!dev->wake)
+		return;
+
+	gpiod_put(dev->wake);
+	dev->wake = NULL;
+}
 #endif	/* CONFIG_OF_IRQ */
 
 static int pci_parse_request_of_pci_ranges(struct device *dev,
@@ -1010,3 +1035,44 @@ int of_pci_get_equalization_presets(struct device *dev,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
+
+int pci_configure_wake_irq(struct pci_dev *pdev)
+{
+	struct pci_dev *bridge = pdev;
+	struct gpio_desc *wake;
+	int ret, wake_irq;
+
+	while (bridge) {
+		wake = bridge->wake;
+		if (wake)
+			break;
+		bridge = pci_upstream_bridge(bridge);  // Move to upstream bridge
+	}
+
+	if (!wake)
+		return 0;
+
+	wake_irq = gpiod_to_irq(wake);
+	if (wake_irq < 0) {
+		dev_err(&pdev->dev, "Failed to get wake irq: %d\n", wake_irq);
+		return wake_irq;
+	}
+
+	device_init_wakeup(&pdev->dev, true);
+
+	ret = dev_pm_set_dedicated_wake_irq_flags(&pdev->dev, wake_irq,
+						  IRQF_SHARED | IRQ_TYPE_EDGE_FALLING);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to set wake IRQ: %d\n", ret);
+		device_init_wakeup(&pdev->dev, false);
+		return ret;
+	}
+
+	return 0;
+}
+
+void pci_remove_wake_irq(struct pci_dev *pdev)
+{
+	dev_pm_clear_wake_irq(&pdev->dev);
+	device_init_wakeup(&pdev->dev, false);
+}
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index b853585cb1f87216981bde2a7782b8ed9c337636..2a1dca1d19b914d21b300ea78be0e0dce418cc88 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -447,10 +447,19 @@ static int pci_device_probe(struct device *dev)
 	if (error < 0)
 		return error;
 
+	if (pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ENDPOINT) {
+		error =  pci_configure_wake_irq(pci_dev);
+		if (error) {
+			pcibios_free_irq(pci_dev);
+			return error;
+		}
+	}
+
 	pci_dev_get(pci_dev);
 	error = __pci_device_probe(drv, pci_dev);
 	if (error) {
 		pcibios_free_irq(pci_dev);
+		pci_remove_wake_irq(pci_dev);
 		pci_dev_put(pci_dev);
 	}
 
@@ -475,6 +484,7 @@ static void pci_device_remove(struct device *dev)
 		pm_runtime_put_noidle(dev);
 	}
 	pcibios_free_irq(pci_dev);
+	pci_remove_wake_irq(pci_dev);
 	pci_dev->driver = NULL;
 	pci_iov_remove(pci_dev);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 12215ee72afb682b669c0e3a582b5379828e70c4..c8cf0b404a4f31b271f187dddd75a007c7566982 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -920,6 +920,11 @@ void pci_release_of_node(struct pci_dev *dev);
 void pci_set_bus_of_node(struct pci_bus *bus);
 void pci_release_bus_of_node(struct pci_bus *bus);
 
+void pci_parse_of_wake_gpio(struct pci_dev *dev);
+void pci_remove_of_wake_gpio(struct pci_dev *dev);
+int pci_configure_wake_irq(struct pci_dev *pdev);
+void pci_remove_wake_irq(struct pci_dev *pdev);
+
 int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge);
 bool of_pci_supply_present(struct device_node *np);
 int of_pci_get_equalization_presets(struct device *dev,
@@ -965,6 +970,11 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
 	return 0;
 }
 
+static inline void pci_parse_of_wake_gpio(struct pci_dev *dev) { }
+static inline void pci_remove_of_wake_gpio(struct pci_dev *dev) { }
+static inline int pci_configure_wake_irq(struct pci_dev *pdev) { return 0; }
+static inline void pci_remove_wake_irq(struct pci_dev *pdev) { }
+
 static inline bool of_pci_supply_present(struct device_node *np)
 {
 	return false;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index e6a34db778266862564532becc2a30aec09bab22..4fb9d8df19bc41cb84dcd1886546076bcc867a43 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2717,6 +2717,8 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	/* Set up MSI IRQ domain */
 	pci_set_msi_domain(dev);
 
+	pci_parse_of_wake_gpio(dev);
+
 	/* Notifier could use PCI capabilities */
 	ret = device_add(&dev->dev);
 	WARN_ON(ret < 0);
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 445afdfa6498edc88f1ef89df279af1419025495..1910f7c18b8f9b11c8136fea970788aaf834c97f 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -52,6 +52,7 @@ static void pci_destroy_dev(struct pci_dev *dev)
 	if (pci_dev_test_and_set_removed(dev))
 		return;
 
+	pci_remove_of_wake_gpio(dev);
 	pci_doe_sysfs_teardown(dev);
 	pci_npem_remove(dev);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 05e68f35f39238f8b9ce08df97b384d1c1e89bbe..8f861298e41d2f0d2dd0fc3f5778fe0e77a93511 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -548,6 +548,8 @@ struct pci_dev {
 	/* These methods index pci_reset_fn_methods[] */
 	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
 
+	struct gpio_desc *wake; /* Holds WAKE# gpio */
+
 #ifdef CONFIG_PCIE_TPH
 	u16		tph_cap;	/* TPH capability offset */
 	u8		tph_mode;	/* TPH mode */

-- 
2.34.1


