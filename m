Return-Path: <linux-pci+bounces-24430-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC7CA6C755
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 04:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12DDD46404A
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 03:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7881514F6;
	Sat, 22 Mar 2025 03:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LBPHggUd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EDF149DE8
	for <linux-pci@vger.kernel.org>; Sat, 22 Mar 2025 03:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742612473; cv=none; b=clnl38VW7dnhm+wlGVHWuhbO+s9VNajd3FdwTNqVNgnUV6vNAulmhkZjvef4JbzBFfnay6FLXtnoYK3IU9Wt3atpCmY5T7XdFnxdU+UyDH+leJl5MV4C1ljVnJq9STGTDWAVlJ5Y+ay4gMym9kgx6TFx9vQi18GZrRgzOQ9qAGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742612473; c=relaxed/simple;
	bh=OcsIuznLjZUAtjrb/hnQscAcM6N2IyI9O79LK0QxW3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N6/ux0JJWIz/wmkbYVj0dfwMYT9JseGpx/i1NKLYi0RDral1rYqbh5rJ6QKq5XVZzmffZhcEnsUNbwNHaZJEC6vWtVBtALuauiQtsQc8BuxJqfDdLAQpmHOUzWGD3PhO/nKx9Vd6L0TZk4FWp/E5ih5KUOCBT4XPbt84MzeGcog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LBPHggUd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52M0vtAY022106
	for <linux-pci@vger.kernel.org>; Sat, 22 Mar 2025 03:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5TuaKD5nu/QplYVB4AwEHfIcahKIDJ4Ugxxeg3cp2iQ=; b=LBPHggUd2DVv923a
	WbFGLv5IL9sspzXjpzvMZOMni5WM6HiRGXa8kadOxxAL2YR/Y3Slf1Ds8UvRP5mX
	/aJ1dsnep4cZvpPTofvzrRzEkCfagVz6qz80noNY9sDjchB7jDiDHW/C7j4F7b96
	VBPmdVCK0A92jkxgXgD/d8P3tJQ97BD0JmPuS3FX+eAtuVhIvpXjAqk8X0GlmKl3
	3eyn7pjaEFOER6BNz0kM++XFBAlrF4TrTRXZfCFbOK0tnpFO81/msvr8YABwCNAN
	3j7BouKWFOdNCLXmsMtNrcgzxvYohS5VtgDwm6NVtimUDhJQTHvcwqebqELQbKU7
	MXywIA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45h4wpjbb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 22 Mar 2025 03:01:10 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-225ab228a37so36914845ad.2
        for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 20:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742612469; x=1743217269;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TuaKD5nu/QplYVB4AwEHfIcahKIDJ4Ugxxeg3cp2iQ=;
        b=jfhhyS0Nf3nac+PaE9uDCQsBSfy11kgwZOGjnuQlKMWkLmIB0RylYXtVA0BarNOAol
         N7OtPUXfcBFHwjg52JpWDSQ5OPtTRez83jDC4sgRsy+Gda/+IOQLjqMH+JlhjFx63ulq
         f32sIwXd+4+EWFSRLZsjCAlFY9NhgmdWYRR7NwEyk//1TJGNstOYxTuBJCIXvoyqMGV0
         LJ3WIDGfmDS4Vf5jBTwKoUQZ3pHhBhowBFV5dO0FoK05cdlHL07u9sxNgasy5ZY+V10P
         6QkYRQOAuGKGRC0bGFYVA8rq0Eqx37H0r1OlOq7c0e1d2oRI7lg8rurZzzWvLX0uqRyu
         RcuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAS3yPyuZvGGxdG9mYHFbjEUB6oYOQ90X2omxGGu/+qAgdqO4hXWXuuFNh0uBltvGiJqv9xCk1MYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhLGkQhECOoBOkbDki7m3oPKorKdMtDVQvkWS3Pn2h5MkYnKij
	KPnoBcTFX/ZzJAomTU7CeEfq44dwyawoy7MSTKpWbAQoMG8BSR4rtJ5HHt/Rrhe+bwW5eeWRRue
	zTIS03dj3DsS73/OXK2iyAwKUdP1dPEz9HvsYxNDSZEWRZIb+C30Ab7iU7w0=
X-Gm-Gg: ASbGncu3hzxeWHB9YhMXOB65KIO1BmFafUA65zEDX3iWHG7FOJaAffpkSrkL1QWzvqn
	BVewRxD7RktLtPQg+Z9Px5FwKQRxbuMn4uBOmyMa2JXdMfDw2ASJyn5EYSn9Pud3lGsLdFDyphe
	m14vv7c1BKl3GEhRQ607BVyDI1Z8YBgAGF00S97PHg2n2QOdd4XCIF6QfCLHJ3maUwWtgJe3kAa
	0ZUjqw2++1WounBgv2Wu+QQ3Tu3pnDAGGfm5stkvmg5gBSCyjJ7tB2nS3SfadFh1AvhhuvRI8na
	0laoqLko5mwnenmmXVUGQFc99kPuTBDEuGZwOySYqsd0bz4wnu0=
X-Received: by 2002:a17:903:2286:b0:224:249f:9723 with SMTP id d9443c01a7336-22780e38317mr77072485ad.51.1742612468564;
        Fri, 21 Mar 2025 20:01:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX0JuJ42Nry6a84KPdNyBZiNsGh22KBCKMNjpKA+L5XS01gQs1OjBDyxnkz6m4y+Kr0dA+Iw==
X-Received: by 2002:a17:903:2286:b0:224:249f:9723 with SMTP id d9443c01a7336-22780e38317mr77072075ad.51.1742612468111;
        Fri, 21 Mar 2025 20:01:08 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811bdca7sm25859945ad.137.2025.03.21.20.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 20:01:07 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 22 Mar 2025 08:30:45 +0530
Subject: [PATCH 3/3] PCI: qcom: Add support for multi-root port
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-perst-v1-3-e5e4da74a204@oss.qualcomm.com>
References: <20250322-perst-v1-0-e5e4da74a204@oss.qualcomm.com>
In-Reply-To: <20250322-perst-v1-0-e5e4da74a204@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742612448; l=7891;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=OcsIuznLjZUAtjrb/hnQscAcM6N2IyI9O79LK0QxW3c=;
 b=RBHOJiWkUKfaiWLxbUruJ9FvxtO4bp2bHH/7LUto9+ZwmBoOiS83AiN/jDW0Dj8b56pjtz2Jd
 k6A1tL/zwuhDVwrpJ3FLJD8F0WZqXI99izQHe3DrizktGict+45wrpA
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: GKiktbbzHSySXw3dL867xqtNPc8xajKp
X-Proofpoint-GUID: GKiktbbzHSySXw3dL867xqtNPc8xajKp
X-Authority-Analysis: v=2.4 cv=ZN3XmW7b c=1 sm=1 tr=0 ts=67de27f6 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=KZ4ZsdeBRq2BojHjq4kA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-22_01,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503220019

Move phy, perst handling to root port and provide a way to have multi-port
logic.

Currently, qcom controllers only support single port, and all properties
are present in the controller node itself. This is incorrect, as
properties like phy, perst, wake, etc. can vary per port and should be
present in the root port node.

pci-bus-common.yaml uses reset-gpios property for representing PERST, use
same property instead of perst-gpios.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 149 +++++++++++++++++++++++++++------
 1 file changed, 123 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index e4d3366ead1f..6424dcfd3e1b 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -262,6 +262,11 @@ struct qcom_pcie_cfg {
 	bool no_l0s;
 };
 
+struct qcom_pcie_port {
+	struct list_head list;
+	struct gpio_desc *reset;
+	struct phy *phy;
+};
 struct qcom_pcie {
 	struct dw_pcie *pci;
 	void __iomem *parf;			/* DT parf */
@@ -276,21 +281,36 @@ struct qcom_pcie {
 	struct dentry *debugfs;
 	bool suspended;
 	bool use_pm_opp;
+	struct list_head ports;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
 
 static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
 {
-	gpiod_set_value_cansleep(pcie->reset, 1);
+	struct qcom_pcie_port *port, *tmp;
+
+	if (list_empty(&pcie->ports))
+		gpiod_set_value_cansleep(pcie->reset, 1);
+	else
+		list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+			gpiod_set_value_cansleep(port->reset, 1);
+
 	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
 }
 
 static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
 {
+	struct qcom_pcie_port *port, *tmp;
+
 	/* Ensure that PERST has been asserted for at least 100 ms */
 	msleep(100);
-	gpiod_set_value_cansleep(pcie->reset, 0);
+	if (list_empty(&pcie->ports))
+		gpiod_set_value_cansleep(pcie->reset, 0);
+	else
+		list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+			gpiod_set_value_cansleep(port->reset, 0);
+
 	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
 }
 
@@ -1229,10 +1249,19 @@ static int qcom_pcie_link_up(struct dw_pcie *pci)
 	return !!(val & PCI_EXP_LNKSTA_DLLLA);
 }
 
+static void qcom_pcie_port_phy_off(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_port *port, *tmp;
+
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+		phy_power_off(port->phy);
+}
+
 static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	struct qcom_pcie_port *port, *tmp;
 	int ret;
 
 	qcom_ep_reset_assert(pcie);
@@ -1241,13 +1270,27 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		return ret;
 
-	ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
-	if (ret)
-		goto err_deinit;
+	if (list_empty(&pcie->ports)) {
+		ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
+		if (ret)
+			goto err_deinit;
 
-	ret = phy_power_on(pcie->phy);
-	if (ret)
-		goto err_deinit;
+		ret = phy_power_on(pcie->phy);
+		if (ret)
+			goto err_deinit;
+	} else {
+		list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
+			ret = phy_set_mode_ext(port->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
+			if (ret)
+				goto err_deinit;
+
+			ret = phy_power_on(port->phy);
+			if (ret) {
+				qcom_pcie_port_phy_off(pcie);
+				goto err_deinit;
+			}
+		}
+	}
 
 	if (pcie->cfg->ops->post_init) {
 		ret = pcie->cfg->ops->post_init(pcie);
@@ -1268,7 +1311,10 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 err_assert_reset:
 	qcom_ep_reset_assert(pcie);
 err_disable_phy:
-	phy_power_off(pcie->phy);
+	if (list_empty(&pcie->ports))
+		phy_power_off(pcie->phy);
+	else
+		qcom_pcie_port_phy_off(pcie);
 err_deinit:
 	pcie->cfg->ops->deinit(pcie);
 
@@ -1281,7 +1327,10 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 
 	qcom_ep_reset_assert(pcie);
-	phy_power_off(pcie->phy);
+	if (list_empty(&pcie->ports))
+		phy_power_off(pcie->phy);
+	else
+		qcom_pcie_port_phy_off(pcie);
 	pcie->cfg->ops->deinit(pcie);
 }
 
@@ -1579,11 +1628,41 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
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
+	phy = devm_of_phy_get(dev, node, "pciephy");
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
@@ -1611,6 +1690,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_pm_runtime_put;
 
+	INIT_LIST_HEAD(&pcie->ports);
+
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 	pp = &pci->pp;
@@ -1619,12 +1700,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
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
@@ -1647,12 +1722,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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
@@ -1699,9 +1768,31 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	pp->ops = &qcom_pcie_dw_ops;
 
-	ret = phy_init(pcie->phy);
-	if (ret)
-		goto err_pm_runtime_put;
+	for_each_child_of_node(dev->of_node, of_port) {
+		ret = qcom_pcie_parse_port(pcie, of_port);
+		of_node_put(of_port);
+		if (ret)
+			break;
+	}
+
+	/* Fallback to previous method */
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
 
@@ -1746,10 +1837,16 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 err_host_deinit:
 	dw_pcie_host_deinit(pp);
 err_phy_exit:
-	phy_exit(pcie->phy);
+	if (list_empty(&pcie->ports))
+		phy_exit(pcie->phy);
+	else
+		list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+			phy_exit(port->phy);
 err_pm_runtime_put:
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+		list_del(&port->list);
 
 	return ret;
 }

-- 
2.34.1


