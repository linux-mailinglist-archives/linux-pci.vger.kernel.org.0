Return-Path: <linux-pci+bounces-21048-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0E8A2E567
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 08:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7891188A77B
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 07:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B441A7046;
	Mon, 10 Feb 2025 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PYGjOplb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F991BBBD7
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739172631; cv=none; b=p9o6UlGG2uXoBGH908vzfaFajm9jzO3G9lhzouOD9zc10uYtU9bppLFUMCpT4TmpizSLpAdP7pBKOEqQNDp4dxvKMCo5GDESR+GhidoWCGgUxnXCJxm1bgqt6dfsoPdBixSFpxf1xFeivIk0SilGhb0Fj9kHKuGYCB4xlA8Cyzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739172631; c=relaxed/simple;
	bh=Cl4JFaJxDzryIs/mN/kRhxhJFn3c+jBU5lxYfvGD3Bo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qRvRg0lFWmzs7D7jn8pBlntrHtEeQQSYp4wTxn0zQY4s8pc3DEPEMnxNvmCYQKuxb5oii5x5A7xuuYyx9Gmxc7k040LX3IQkTs2wyqNdamS4PJqSUbR9yqD5rpRnNGyfmoLVY2wY+itBZJTTDjIP6ieEcasxljcTmV29eWYLmKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PYGjOplb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 519KoJZ9018262
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 07:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iVMR37ilbhZdZuNg7cIw79Nb+gL8nScpY3WJEBixtSY=; b=PYGjOplbIa5psQWX
	eklcHhcoaaE0w3AavcD11n/kgYB81dOG/A04n6famm8st0EY319HV2FXh8I0iYgr
	xiWG9EfEA1SefObAHyiu+JabyyoJDvzgo4Av1As+lhyqTnfFQ4qdXtB0MprCuQWl
	UfFUlbBTJfzQb4kDUFLa1k0hLZemQ9KDDRDefrL4j1Ur+qdo21DZC3y3O+TQM0H5
	56eQMr9hUkodZVLb+2KlaUqCKotTbnIPBkp+SwMo4f5fkYGKwBRgnxGBXGKXh2+R
	8pE/OHAuaX983JRb0xvkspLHWW/qTBdEeEdANMALJnaF4kg24SvkZRURcbKWCDOH
	XbXZ+w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44p0kakdx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 07:30:28 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fa57c42965so2800804a91.1
        for <linux-pci@vger.kernel.org>; Sun, 09 Feb 2025 23:30:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739172628; x=1739777428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVMR37ilbhZdZuNg7cIw79Nb+gL8nScpY3WJEBixtSY=;
        b=j86Lsn5/ifDiix0+m6uGaUUTBkv/tMeMVJfuYvg4YFqtRyaEoM/eOPYKfsGMez8PRI
         JD1prGnHWTifE7J5mUQNGKNjpCqiwPALEAKaqmS22Ijzk7IbY9ZMiTLQHuR4hdVf62NY
         34BF2HnuddPNqSGfk/r/r0I6BRqyuU7BWkFgin27ZWZof4PkAoAK8zui8Zx3MZeDzlkw
         uYxHp4Ja+6JaqbqlKMcPavnvCpF41lhGigbd2Up3dsyZJMgVQ4k1HuV8y/GTITRhiDk7
         eR9TMTBMemfTkS5bp+zveLHFv0wRxtW6a8zzVXQRFigktPaGLJ2D+AsC+u1PB2Ycyhii
         U8Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXpbgltJdqKX1ssu+sPxXdBuNHtTKsercJHNfCNddy2QoW9surgxo0DbN1deI1HaYmrQQmj5th32LY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4MkzU0F7VkjB34Kxh0L1Xe7/HfSiMThBipzfioYWLGKqs5BVi
	hP+jQ13ug5bebIhGRMoox5XpAE9dkTZCEi5UVj1bMHZ4Fv3j1LgN0kSlGM7ltVoqd7qLBBFFct3
	xjODb8mP8mnTo6e6ma/eieAbcZ6+28cYJzLd7/FZFedosTEFBrOrltqWbess=
X-Gm-Gg: ASbGncuAx7zpHw0jnANwvQ23lpRkqLrPTgwtbLTa7bkDgTIW9zuOpGCIIFVFLLm1uCa
	oRKpf4Pgg8gRFjSvyIDkBK57FVYMBny0die4wv0mRZdbarHp6OkAUPQBNh334hol3UZ/5EtoY4M
	uc23w6emxe0Y1W7zcnfZxV+nxknGenZkaEfcO+HCQ6Mr4T0wkGoRNVek112zxGC8pA/WOOgSKTr
	8c9i6OF9NlVdoFKuybqYFps7oZbsGgnQPaep9jDt2TqVoAA4jeetKCI1bIWlq1KPFsZQ/dcp2Nd
	cV95kAt+arGLsLALd9rn7tCZEYPnzp4MrUyD5cPI
X-Received: by 2002:a17:90b:510e:b0:2ef:67c2:4030 with SMTP id 98e67ed59e1d1-2fa242e5c6amr17844365a91.27.1739172627566;
        Sun, 09 Feb 2025 23:30:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSOpMpC2e4JGafXI8GZYwAZg2RfKrZm6bHipHYV3z7/cDG/+8TkM7I1j7eP7ZF+MkJdktefQ==
X-Received: by 2002:a17:90b:510e:b0:2ef:67c2:4030 with SMTP id 98e67ed59e1d1-2fa242e5c6amr17844322a91.27.1739172627161;
        Sun, 09 Feb 2025 23:30:27 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a6fe28sm7918507a91.26.2025.02.09.23.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 23:30:26 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 10 Feb 2025 13:00:01 +0530
Subject: [PATCH v6 2/4] PCI: of: Add API to retrieve equalization presets
 from device tree
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-preset_v6-v6-2-cbd837d0028d@oss.qualcomm.com>
References: <20250210-preset_v6-v6-0-cbd837d0028d@oss.qualcomm.com>
In-Reply-To: <20250210-preset_v6-v6-0-cbd837d0028d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_mrana@quicinc.com, quic_vbadigan@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739172612; l=4565;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Cl4JFaJxDzryIs/mN/kRhxhJFn3c+jBU5lxYfvGD3Bo=;
 b=29acobT21vTWtDtjMxRnTSFmbSUHMbJZyioTJp4qz/b6uRVPm11tg9ouLcyZnkmet8EY4ZcTf
 2XtE1M/RIdsBeT/swGo4AFIdkaL81UHJdRL/eIV6dCSK0tofIkcln6R
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: 7V3Df94BFKWALAcJPEva8epztau2NuZk
X-Proofpoint-ORIG-GUID: 7V3Df94BFKWALAcJPEva8epztau2NuZk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_04,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 suspectscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502100062

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

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/of.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h | 27 ++++++++++++++++++++++++++-
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 7a806f5c0d20..705d5529fa95 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -851,3 +851,46 @@ u32 of_pci_get_slot_power_limit(struct device_node *node,
 	return slot_power_limit_mw;
 }
 EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
+
+/**
+ * of_pci_get_equalization_presets - Parses the "eq-presets-ngts" property.
+ *
+ * @dev: Device containing the properties.
+ * @presets: Pointer to store the parsed data.
+ * @num_lanes: Maximum number of lanes supported.
+ *
+ * If the property is present read and store the data in the preset structure
+ * assign default value 0xff to indicate property is not present.
+ *
+ * Return: 0 if the property is not available or successfully parsed; errno otherwise.
+ */
+int of_pci_get_equalization_presets(struct device *dev,
+				    struct pci_eq_presets *presets,
+				    int num_lanes)
+{
+	char name[20];
+	int ret;
+
+	presets->eq_presets_8gts[0] = PCI_EQ_RESV;
+	ret = of_property_read_u16_array(dev->of_node, "eq-presets-8gts",
+					 presets->eq_presets_8gts, num_lanes);
+	if (ret && ret != -EINVAL) {
+		dev_err(dev, "Error reading eq-presets-8gts %d\n", ret);
+		return ret;
+	}
+
+	for (int i = 0; i < EQ_PRESET_TYPE_MAX; i++) {
+		presets->eq_presets_Ngts[i][0] = PCI_EQ_RESV;
+		snprintf(name, sizeof(name), "eq-presets-%dgts", 8 << (i + 1));
+		ret = of_property_read_u8_array(dev->of_node, name,
+						presets->eq_presets_Ngts[i],
+						num_lanes);
+		if (ret && ret != -EINVAL) {
+			dev_err(dev, "Error reading %s %d\n", name, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 01e51db8d285..e87c2ffd1e85 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -9,6 +9,8 @@ struct pcie_tlp_log;
 /* Number of possible devfns: 0.0 to 1f.7 inclusive */
 #define MAX_NR_DEVFNS 256
 
+#define MAX_NR_LANES 16
+
 #define PCI_FIND_CAP_TTL	48
 
 #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
@@ -808,6 +810,20 @@ static inline u64 pci_rebar_size_to_bytes(int size)
 
 struct device_node;
 
+#define	PCI_EQ_RESV	0xff
+
+enum equalization_preset_type {
+	EQ_PRESET_TYPE_16GTS,
+	EQ_PRESET_TYPE_32GTS,
+	EQ_PRESET_TYPE_64GTS,
+	EQ_PRESET_TYPE_MAX
+};
+
+struct pci_eq_presets {
+	u16 eq_presets_8gts[MAX_NR_LANES];
+	u8 eq_presets_Ngts[EQ_PRESET_TYPE_MAX][MAX_NR_LANES];
+};
+
 #ifdef CONFIG_OF
 int of_get_pci_domain_nr(struct device_node *node);
 int of_pci_get_max_link_speed(struct device_node *node);
@@ -822,7 +838,9 @@ void pci_release_bus_of_node(struct pci_bus *bus);
 
 int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge);
 bool of_pci_supply_present(struct device_node *np);
-
+int of_pci_get_equalization_presets(struct device *dev,
+				    struct pci_eq_presets *presets,
+				    int num_lanes);
 #else
 static inline int
 of_get_pci_domain_nr(struct device_node *node)
@@ -867,6 +885,13 @@ static inline bool of_pci_supply_present(struct device_node *np)
 {
 	return false;
 }
+
+static inline int of_pci_get_equalization_presets(struct device *dev,
+						  struct pci_eq_presets *presets,
+						  int num_lanes)
+{
+	return 0;
+}
 #endif /* CONFIG_OF */
 
 struct of_changeset;

-- 
2.34.1


