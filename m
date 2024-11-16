Return-Path: <linux-pci+bounces-16951-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4A39CFC2D
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 02:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B231A1F24D99
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 01:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D8B1925A1;
	Sat, 16 Nov 2024 01:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kB6XNqMM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E52019066D;
	Sat, 16 Nov 2024 01:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731721087; cv=none; b=sh8R8HjmnHa9+79Agz2u7iyPDy+ZtXgeencN1vUj5XKT3s0bfwU+a3CpQZNGkO3zpVUUOlQMZZEHcJIxZiof9iLng5pGEL80UVyxoq6bUZUSbJTdiDmrZ8O4xRr79Lf7Y2/uDHLe1OS5YooVrr8tLi5GmsgV8w3YfFqci4mUKME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731721087; c=relaxed/simple;
	bh=We7+mnLDPHlJfTjNDEFiooxDEJCUNFlOZ8XnnWervXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=f7T8w9JWhuv3gsra/HvpnnlQkE7Yzzd0Tgyo4folfaOvKVikOjeR1ptaUAt3/ZHAnMBVy36TkJkvsf5y66Sfk4iil/I626qqsGM2NweHeGutRSSOSSGKiq7P069pu5BJ0IW2N0AoK1653xovomLGsAZlvxBcyQtxGKo1mFwGVb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kB6XNqMM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFI5SSV029678;
	Sat, 16 Nov 2024 01:37:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vuTudi5/3YYxGx4jpAauoXilRSBGft4yh6bEdurqNtI=; b=kB6XNqMMgUsNwkzl
	yaWn7xsYQ9m1mI0fuc4zYKhS9CGbAHWT0kSFewEJwjd+m12CSqJd5GoCTY5CRPoM
	bJcqXRFemnp+QMnYWVdLgAHEO2FoUwI7p2UU9PA/FgFf8E89Mm9cc4gI78a4RqJE
	pDRqa7aiTsvLNu12hMYYCZ0HTIqH/Vczl3QtfmWxDKG2uFszZ5oYtLCQIVliI4Th
	YFV3zmeENYMQF8LsZoFs1rLC5FVkvrrXAfn9HtVxvnx757GemWRqTs2Cbc3ZAORj
	e+2juygz9nX5F4VMG6lxJMaza8DbHzlErsopWKW6erEG56d6Dv8aWhgtwcQ99ZRj
	E3LvCA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42wjqan2y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 01:37:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AG1btlF010341
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 01:37:55 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 15 Nov 2024 17:37:48 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sat, 16 Nov 2024 07:07:31 +0530
Subject: [PATCH 2/4] PCI: of: Add API to retrieve equalization presets from
 device tree
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241116-presets-v1-2-878a837a4fee@quicinc.com>
References: <20241116-presets-v1-0-878a837a4fee@quicinc.com>
In-Reply-To: <20241116-presets-v1-0-878a837a4fee@quicinc.com>
To: <quic_mrana@quicinc.com>, <quic_vbadigan@quicinc.com>,
        <kernel@quicinc.com>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas
	<bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "Krishna
 chaitanya chundru" <quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731721058; l=4750;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=We7+mnLDPHlJfTjNDEFiooxDEJCUNFlOZ8XnnWervXg=;
 b=vwECHnCTXdvKttpyLRS3rsVUwRQDyhMaj96flJPS9ZHogUtD5GkGIEdKQc7XYuwMiCz4McIhs
 8u0Dt1QDeBPDS788kNjcS4Yo3AzjvO7gdPY9kIs36ZhfH6ydr1Xk2Om
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jWebHggDihbxmAY-0Efwn5gNMWI8AuW5
X-Proofpoint-ORIG-GUID: jWebHggDihbxmAY-0Efwn5gNMWI8AuW5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411160011

PCIe equalization presets are predefined settings used to optimize
signal integrity by compensating for signal loss and distortion in
high-speed data transmission.

As per PCIe spec 6.0.1 revision section 8.3.3.3 & 4.2.4 for data rates
of 8.0 GT/s, 16.0 GT/s, 32.0 GT/s, and 64.0 GT/s, there is a way to
configure lane equalization presets for each lane to enhance the PCIe
link reliability. Each preset value represents a different combination
of pre-shoot and de-emphasis values. For each data rate, different
registers are defined: for 8.0 GT/s, registers are defined in section
7.7.3.4; for 16.0 GT/s, in section 7.7.5.9, etc. The 8.0 GT/s rate has
an extra receiver preset hint, requiring 16 bits per lane, while the
remaining data rates use 8 bits per lane.

Based on the number of lanes and the supported data rate, this function
reads the device tree property and stores in the presets structure.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/of.c  | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h | 17 +++++++++++++--
 2 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index dacea3fc5128..0d37bc231956 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -826,3 +826,65 @@ u32 of_pci_get_slot_power_limit(struct device_node *node,
 	return slot_power_limit_mw;
 }
 EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
+
+int of_pci_get_equalization_presets(struct device *dev,
+				    struct pci_eq_presets *presets,
+				    int num_lanes)
+{
+	int ret;
+
+	if (of_property_present(dev->of_node, "eq-presets-8gts")) {
+		presets->eq_presets_8gts = devm_kzalloc(dev, sizeof(u16) * num_lanes, GFP_KERNEL);
+		if (!presets->eq_presets_8gts)
+			return -ENOMEM;
+
+		ret = of_property_read_u16_array(dev->of_node, "eq-presets-8gts",
+						 presets->eq_presets_8gts, num_lanes);
+		if (ret) {
+			dev_err(dev, "Error reading eq-presets-8gts %d\n", ret);
+			return ret;
+		}
+	}
+
+	if (of_property_present(dev->of_node, "eq-presets-16gts")) {
+		presets->eq_presets_16gts = devm_kzalloc(dev, sizeof(u8) * num_lanes, GFP_KERNEL);
+		if (!presets->eq_presets_16gts)
+			return -ENOMEM;
+
+		ret = of_property_read_u8_array(dev->of_node, "eq-presets-16gts",
+						presets->eq_presets_16gts, num_lanes);
+		if (ret) {
+			dev_err(dev, "Error reading eq-presets-16gts %d\n", ret);
+			return ret;
+		}
+	}
+
+	if (of_property_present(dev->of_node, "eq-presets-32gts")) {
+		presets->eq_presets_32gts = devm_kzalloc(dev, sizeof(u8) * num_lanes, GFP_KERNEL);
+		if (!presets->eq_presets_32gts)
+			return -ENOMEM;
+
+		ret = of_property_read_u8_array(dev->of_node, "eq-presets-32gts",
+						presets->eq_presets_32gts, num_lanes);
+		if (ret) {
+			dev_err(dev, "Error reading eq-presets-32gts %d\n", ret);
+			return ret;
+		}
+	}
+
+	if (of_property_present(dev->of_node, "eq-presets-64gts")) {
+		presets->eq_presets_64gts = devm_kzalloc(dev, sizeof(u8) * num_lanes, GFP_KERNEL);
+		if (!presets->eq_presets_64gts)
+			return -ENOMEM;
+
+		ret = of_property_read_u8_array(dev->of_node, "eq-presets-64gts",
+						presets->eq_presets_64gts, num_lanes);
+		if (ret) {
+			dev_err(dev, "Error reading eq-presets-64gts %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 14d00ce45bfa..757872f0cc35 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -731,7 +731,12 @@ static inline u64 pci_rebar_size_to_bytes(int size)
 }
 
 struct device_node;
-
+struct pci_eq_presets {
+	u16 *eq_presets_8gts;
+	u8 *eq_presets_16gts;
+	u8 *eq_presets_32gts;
+	u8 *eq_presets_64gts;
+};
 #ifdef CONFIG_OF
 int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
 int of_get_pci_domain_nr(struct device_node *node);
@@ -746,7 +751,9 @@ void pci_set_bus_of_node(struct pci_bus *bus);
 void pci_release_bus_of_node(struct pci_bus *bus);
 
 int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge);
-
+int of_pci_get_equalization_presets(struct device *dev,
+				    struct pci_eq_presets *presets,
+				    int num_lanes);
 #else
 static inline int
 of_pci_parse_bus_range(struct device_node *node, struct resource *res)
@@ -793,6 +800,12 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
 	return 0;
 }
 
+static int of_pci_get_equalization_presets(struct device *dev,
+					   struct pci_eq_presets *presets,
+					   int num_lanes)
+{
+	return 0;
+}
 #endif /* CONFIG_OF */
 
 struct of_changeset;

-- 
2.34.1


