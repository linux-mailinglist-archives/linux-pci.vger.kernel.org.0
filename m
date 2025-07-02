Return-Path: <linux-pci+bounces-31245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E75EAF139E
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 13:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948CA177284
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 11:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911DF2676E2;
	Wed,  2 Jul 2025 11:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lW4FckJN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EC1265CD4
	for <linux-pci@vger.kernel.org>; Wed,  2 Jul 2025 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751455272; cv=none; b=YdTAr5PWiFT8gxnuvXYW4v1N+Vgkv+P1SKMcmNpAitl+aa+d60RucPKMKLwgTBZhicHhejns6/sB5CDYZZzsThDXCGbqwENfn3ERPMnEaATMvDpXZ6DTz9mEgxtTrBYlK+lCy2Xq9x3ffY1IsmMWwDkbELJS/1NseAK+vwK+Jsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751455272; c=relaxed/simple;
	bh=A38xSljKc5j/Hin6ltpfaZ+hAhX+pVLlWZ3StYFW/Os=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tobM3pwP13CR5fJh2IvzUGXZcesLlbRtmzN3k2G8OnGnRS/VRdHeZd5WM/fZDKPG8cEA7N4on1G2jI9mh0rlCB8yuM1UyX1SeKq5KKcG0A2a+iPrT3/bEr8minmJf8CjOKFq8ZHfL7dIQ2KMfXMX/bDLZVQqe/e3UwJW0OHZA5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lW4FckJN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5625cULB018568
	for <linux-pci@vger.kernel.org>; Wed, 2 Jul 2025 11:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5F+sTxGPeHZTq3lkD4jSiUbC1PD//qQ0WXLka1L493g=; b=lW4FckJN4KkT4VVY
	YXhKSvXJZk72xKdxAf6JrPEnJKL4TbgHXu3V62S9zW5XVJMAuWiNl5aE44Zkqxhn
	E412RAH5khvaxqVc3XXO8sU1CF+cqx3llMik7/Q9WEu3Y/KRnthvZGuMKSSkJRGo
	gyTTg39oct3thM9ls4NYyTnyKngbtiBzvX72WZazYBoeE+MJWOjqV8tCK8xYL/2Q
	urqE1BYMmMipqUTTU1JEiZIo8uUltgdAfwxEpl2eUKGu4sr2459BM+TOyqeo8Gey
	7x0JGjUjjNvbTiQgRYWRLbHKVJv86Y6o22ySkoJWkK9k5biWJIlYdERxLalKL1vj
	K90umA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j8fxmg70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 02 Jul 2025 11:21:09 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-235e7550f7bso61831355ad.3
        for <linux-pci@vger.kernel.org>; Wed, 02 Jul 2025 04:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751455268; x=1752060068;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5F+sTxGPeHZTq3lkD4jSiUbC1PD//qQ0WXLka1L493g=;
        b=qyzJZJ5rKKLYIb01SIVOWup0vUeBK/q06KcJRXpwmsg+xIG/DhmX4W1YNfl1yZM36K
         QHrTcQY12a5sHbsKfUZHkzMyj/2OIrgCuG0TzelGqvzB4Mlq5Iex/5jImoINv+kBb4aM
         UaCz8sfaqzrsDsgGJZQMSP59I+9ca+msVOpyl0gsBe7bw9fTBqSeSfTSNr+9/WONFqZp
         AvRXOYgVW1JYTJcK7L2pya74SeQhyGaIv9lbrtN8HZDnWzj6hfcNQWQnYOYseb7qM2Df
         YGHw2xhGzNAZhDPqxfaz90pz4ivFBi+vfwutnxcjYa00+glYE8o/2jaeQsC1pM7YOSyM
         jNIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9ZR2RdTVM1JbxDNrcvUrYbehdzoFxoCyxV0HKG02R5wqi6WE1t3v+NOO3+H7snrowGm1wMbpowzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt2fY7zCUH4sjpBro+gx69iyQgpFbLtCxczTEe0OPLxWQQOEes
	COqlOBgL2xuVN6nk2/8udVfHK+1Bgwaf3xc+unuBVCNmpRqJUXSO4vUl8+gEm9TXcdysBZawH4+
	grf4D76ifSshv/k9hb7l+A6IrUOsqXXLJvteJv22NT3cQbnqBhETq7v82l+E8tdA=
X-Gm-Gg: ASbGncs5K8YTbGZmiRrbqJ0daQIEQ8q1raUe1cN1XdhR6MstADBVYYAhe/icoUhIlp0
	Q8Z5IQ6wXmfLzg6R+JgXcKPk+Vqlrv7+tvHoiqCv3oH2L0H6r1Wnd+XtqAJGx6ciamPXtmeUVRG
	nCZxaoKH/ulCxbZjGFk0AAJxdzqv6GmsIHzFqfG3pZGY13FqekjXyD/k1u6SR8vfrIFJ/88jA0m
	IdDm1DGCX0ORvteo8sixrIcZX5PG9q2uh77CO2kEaoZuqQ7aKUZdcaXFcdyXSFAPG7w89LJCNH9
	hsgWWxa3OMgWgvvz+sTe5P0nQodLo4BZzYFJaTapMOv6rGZajlpaDB5KGg==
X-Received: by 2002:a17:903:2bcc:b0:234:9ffb:840a with SMTP id d9443c01a7336-23c6e633930mr27990795ad.50.1751455268116;
        Wed, 02 Jul 2025 04:21:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC99kPyn5iGagtvBR5otuGrTDjsarDmdzae+VuRgVq4uL7qGj5kRWq2CxJe9BG7h4QzmssDg==
X-Received: by 2002:a17:903:2bcc:b0:234:9ffb:840a with SMTP id d9443c01a7336-23c6e633930mr27990475ad.50.1751455267603;
        Wed, 02 Jul 2025 04:21:07 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23b0b3bc0f1sm83926955ad.171.2025.07.02.04.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 04:21:07 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 02 Jul 2025 16:50:42 +0530
Subject: [PATCH v5 2/2] PCI: qcom: Add support for multi-root port
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-perst-v5-2-920b3d1f6ee1@qti.qualcomm.com>
References: <20250702-perst-v5-0-920b3d1f6ee1@qti.qualcomm.com>
In-Reply-To: <20250702-perst-v5-0-920b3d1f6ee1@qti.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751455253; l=8478;
 i=krichai@qti.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=A38xSljKc5j/Hin6ltpfaZ+hAhX+pVLlWZ3StYFW/Os=;
 b=KEyzD4fITStC+0DI6bfdOsdIhKEtdcCoBIWQvDZNodbi8J90QIqtBSTwBGyi86z0THNFalP6b
 RnPm9uxD0dWDupBjoDLDzVKkA5PbvJZi52wpW9uFKJ7nJqzgwC/RLy5
X-Developer-Key: i=krichai@qti.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA5MiBTYWx0ZWRfX/xlhryC8KjD4
 j1R9PH6eGeqruMWkNifGo8wCS3PsYF1n8ET3d0tRe8Bd+k5RPD+PbzrWLss11rr6KF317BeSoHX
 MdOjyY1NdQQtUNh1umEuUaRPIyMoU/6uU1W0vJjvrGpVufmaVsriCvwKsKCDINhLpFkjhSHKqXG
 X4mQAfwoXg12YL2WA7msQeO3bJ3lWUdIQl5bDRAetWYjrQ9y6gbCqsaARwzwMpFnyaw6ZepNMA7
 5VSI+VIcvBI1gRe3SlJPVuB9wOoXfVTjdjIjw6xuYm1ac0qFeThdmbhfRLoNw+NoOxs0Q8L+OHi
 B4JGtYzJdvgNoErNgF0WGzLiJu5qfxiBUSStP1oJYu9ed7ji+xXK65SfcEz6mMYDwN382yyd2FM
 iGEVhY/OZwOccEOptuX58ZHnDAS+XAjU4IPHlnlnf3FyaFDjOySgH2ZocTLnNnODeMDg9eVN
X-Proofpoint-GUID: C7ZUCd1O6b6vCZaFPoNspoksaWQG5FCH
X-Proofpoint-ORIG-GUID: C7ZUCd1O6b6vCZaFPoNspoksaWQG5FCH
X-Authority-Analysis: v=2.4 cv=TqPmhCXh c=1 sm=1 tr=0 ts=68651625 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=kQczSkNYjdDqFxC5ROQA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 impostorscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507020092

Move phy, PERST# handling to root port and provide a way to have multi-port
logic.

Currently, QCOM controllers only support single port, and all properties
are present in the host bridge node itself. This is incorrect, as
properties like phys, perst-gpios, etc.. can vary per port and should be
present in the root port node.

To maintain DT backwards compatibility, fallback to the legacy method of
parsing the host bridge node if the port parsing fails.

pci-bus-common.yaml uses reset-gpios property for representing PERST#, use
same property instead of perst-gpios.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 178 ++++++++++++++++++++++++++++-----
 1 file changed, 151 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index f7ed1e010eb6607b2e98a42f0051c47e4de2af93..56d04a15edf8f99f6d3b9bfaa037ff922b521888 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -267,6 +267,12 @@ struct qcom_pcie_cfg {
 	bool no_l0s;
 };
 
+struct qcom_pcie_port {
+	struct list_head list;
+	struct gpio_desc *reset;
+	struct phy *phy;
+};
+
 struct qcom_pcie {
 	struct dw_pcie *pci;
 	void __iomem *parf;			/* DT parf */
@@ -279,24 +285,37 @@ struct qcom_pcie {
 	struct icc_path *icc_cpu;
 	const struct qcom_pcie_cfg *cfg;
 	struct dentry *debugfs;
+	struct list_head ports;
 	bool suspended;
 	bool use_pm_opp;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
 
-static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
+static void qcom_perst_assert(struct qcom_pcie *pcie, bool assert)
 {
-	gpiod_set_value_cansleep(pcie->reset, 1);
+	struct qcom_pcie_port *port;
+	int val = assert ? 1 : 0;
+
+	if (list_empty(&pcie->ports))
+		gpiod_set_value_cansleep(pcie->reset, val);
+	else
+		list_for_each_entry(port, &pcie->ports, list)
+			gpiod_set_value_cansleep(port->reset, val);
+
 	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
 }
 
+static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
+{
+	qcom_perst_assert(pcie, true);
+}
+
 static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
 {
 	/* Ensure that PERST has been asserted for at least 100 ms */
 	msleep(PCIE_T_PVPERL_MS);
-	gpiod_set_value_cansleep(pcie->reset, 0);
-	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
+	qcom_perst_assert(pcie, false);
 }
 
 static int qcom_pcie_start_link(struct dw_pcie *pci)
@@ -1234,6 +1253,59 @@ static bool qcom_pcie_link_up(struct dw_pcie *pci)
 	return val & PCI_EXP_LNKSTA_DLLLA;
 }
 
+static void qcom_pcie_phy_exit(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_port *port;
+
+	if (list_empty(&pcie->ports))
+		phy_exit(pcie->phy);
+	else
+		list_for_each_entry(port, &pcie->ports, list)
+			phy_exit(port->phy);
+}
+
+static void qcom_pcie_phy_power_off(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_port *port;
+
+	if (list_empty(&pcie->ports)) {
+		phy_power_off(pcie->phy);
+	} else {
+		list_for_each_entry(port, &pcie->ports, list)
+			phy_power_off(port->phy);
+	}
+}
+
+static int qcom_pcie_phy_power_on(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_port *port;
+	int ret = 0;
+
+	if (list_empty(&pcie->ports)) {
+		ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
+		if (ret)
+			return ret;
+
+		ret = phy_power_on(pcie->phy);
+		if (ret)
+			return ret;
+	} else {
+		list_for_each_entry(port, &pcie->ports, list) {
+			ret = phy_set_mode_ext(port->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
+			if (ret)
+				return ret;
+
+			ret = phy_power_on(port->phy);
+			if (ret) {
+				qcom_pcie_phy_power_off(pcie);
+				return ret;
+			}
+		}
+	}
+
+	return ret;
+}
+
 static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -1246,11 +1318,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		return ret;
 
-	ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
-	if (ret)
-		goto err_deinit;
-
-	ret = phy_power_on(pcie->phy);
+	ret = qcom_pcie_phy_power_on(pcie);
 	if (ret)
 		goto err_deinit;
 
@@ -1273,7 +1341,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 err_assert_reset:
 	qcom_ep_reset_assert(pcie);
 err_disable_phy:
-	phy_power_off(pcie->phy);
+	qcom_pcie_phy_power_off(pcie);
 err_deinit:
 	pcie->cfg->ops->deinit(pcie);
 
@@ -1286,7 +1354,7 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 
 	qcom_ep_reset_assert(pcie);
-	phy_power_off(pcie->phy);
+	qcom_pcie_phy_power_off(pcie);
 	pcie->cfg->ops->deinit(pcie);
 }
 
@@ -1631,11 +1699,41 @@ static const struct pci_ecam_ops pci_qcom_ecam_ops = {
 	}
 };
 
+static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node)
+{
+	struct device *dev = pcie->pci->dev;
+	struct qcom_pcie_port *port;
+	struct gpio_desc *reset;
+	struct phy *phy;
+
+	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
+				      "reset", GPIOD_OUT_HIGH, "PERST#");
+	if (IS_ERR(reset))
+		return PTR_ERR(reset);
+
+	phy = devm_of_phy_get(dev, node, NULL);
+	if (IS_ERR(phy))
+		return PTR_ERR(phy);
+
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	port->reset = reset;
+	port->phy = phy;
+	INIT_LIST_HEAD(&port->list);
+	list_add_tail(&port->list, &pcie->ports);
+
+	return 0;
+}
+
 static int qcom_pcie_probe(struct platform_device *pdev)
 {
 	const struct qcom_pcie_cfg *pcie_cfg;
 	unsigned long max_freq = ULONG_MAX;
+	struct qcom_pcie_port *port, *tmp;
 	struct device *dev = &pdev->dev;
+	struct device_node *of_port;
 	struct dev_pm_opp *opp;
 	struct qcom_pcie *pcie;
 	struct dw_pcie_rp *pp;
@@ -1701,6 +1799,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_pm_runtime_put;
 	}
 
+	INIT_LIST_HEAD(&pcie->ports);
+
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 	pp = &pci->pp;
@@ -1709,12 +1809,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	pcie->cfg = pcie_cfg;
 
-	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
-	if (IS_ERR(pcie->reset)) {
-		ret = PTR_ERR(pcie->reset);
-		goto err_pm_runtime_put;
-	}
-
 	pcie->parf = devm_platform_ioremap_resource_byname(pdev, "parf");
 	if (IS_ERR(pcie->parf)) {
 		ret = PTR_ERR(pcie->parf);
@@ -1737,12 +1831,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
-	pcie->phy = devm_phy_optional_get(dev, "pciephy");
-	if (IS_ERR(pcie->phy)) {
-		ret = PTR_ERR(pcie->phy);
-		goto err_pm_runtime_put;
-	}
-
 	/* OPP table is optional */
 	ret = devm_pm_opp_of_add_table(dev);
 	if (ret && ret != -ENODEV) {
@@ -1789,9 +1877,42 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	pp->ops = &qcom_pcie_dw_ops;
 
-	ret = phy_init(pcie->phy);
-	if (ret)
-		goto err_pm_runtime_put;
+	for_each_available_child_of_node(dev->of_node, of_port) {
+		ret = qcom_pcie_parse_port(pcie, of_port);
+		of_node_put(of_port);
+		if (ret) {
+			if (ret != -ENOENT) {
+				dev_err_probe(pci->dev, ret,
+					      "Failed to parse port nodes %d\n",
+					      ret);
+				goto err_port_del;
+			}
+			break;
+		}
+	}
+
+	/*
+	 * In the case of properties not populated in root port, fallback to the
+	 * legacy method of parsing the host bridge node. This is to maintain DT
+	 * backwards compatibility.
+	 */
+	if (ret) {
+		pcie->phy = devm_phy_optional_get(dev, "pciephy");
+		if (IS_ERR(pcie->phy)) {
+			ret = PTR_ERR(pcie->phy);
+			goto err_pm_runtime_put;
+		}
+
+		pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
+		if (IS_ERR(pcie->reset)) {
+			ret = PTR_ERR(pcie->reset);
+			goto err_pm_runtime_put;
+		}
+
+		ret = phy_init(pcie->phy);
+		if (ret)
+			goto err_pm_runtime_put;
+	}
 
 	platform_set_drvdata(pdev, pcie);
 
@@ -1836,7 +1957,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 err_host_deinit:
 	dw_pcie_host_deinit(pp);
 err_phy_exit:
-	phy_exit(pcie->phy);
+	qcom_pcie_phy_exit(pcie);
+err_port_del:
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+		list_del(&port->list);
 err_pm_runtime_put:
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);

-- 
2.34.1


