Return-Path: <linux-pci+bounces-26265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35423A941B6
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 07:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFDB919E7BA5
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 05:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A2D17A302;
	Sat, 19 Apr 2025 05:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AuzFEXd7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF8715747D
	for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 05:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745039989; cv=none; b=ZfNVx6ANKOtm0i7AojGZIgXXV0WdhspG0CeuIo0xskac9c6QlSgqfH0nB4u+i0+aEiEWhI7d7U4wk/ZzJLg60gP8MPJHP533LAN1ULp8p1rD38vKprO6eO7BSLE4q1JNojfgnSPNqw+OwdcKehQzWTIRlp9hO/ykepwFPYay5zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745039989; c=relaxed/simple;
	bh=D316g5aWbCAO9Vig+hOWDXQ413eJGS6rGu5Q1O3MWFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=etNPYtb+kcHDfYAlL4Nsy1vy3LrU+2Rt9A5kkXiZuMYwIlL62hv7MSH9GsqyqiIWAPtylw6oZN2UxLkKRLwZXylOoGVHDmIfdT/JLga1Jqqe2ZII84VIBgWJiVwTZowbw0/OKi+3pnHT8923Ya577hRNAU7+PEdyXwzKQKWANZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AuzFEXd7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53J3kgqH003091
	for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 05:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wKr5iCxtrLgnSa5yWtBwsbzzzyWFbruUEa8PkiNudHk=; b=AuzFEXd7ulYYS0ig
	8POFxtdJ/MJok65yxLB9JcRRN32z6RsgmaOobz3VKbKmYzDrOa5zcTdR8+KHC5Y/
	xKf31yCvpZM0ZAT9Anjb2xIUVIHzkik2l6n6IhWerC6jJHUNHDl0YHlav74EspjA
	niJsWACH/vNmHdKlWQ1AOVC/KEhqZ9AhiqQ4fcKTdJoZqouhKSDeCUPqV2ipBG0B
	XEOfWU/X6xcMhsJsKklwD7fpQW8WvhYYLnfuPlLj7NFUR+U4uJUy7/HqoXkrQeqM
	sxxyoLdBfd4PjGcC6tTkcbE3Z0Cby1IReT+3ihrCoyAVoK+4RBNvJq3NJdJY6nvB
	TI2CDQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 464478r2r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 05:19:46 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-736cd27d51fso1968529b3a.2
        for <linux-pci@vger.kernel.org>; Fri, 18 Apr 2025 22:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745039985; x=1745644785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKr5iCxtrLgnSa5yWtBwsbzzzyWFbruUEa8PkiNudHk=;
        b=PrsNXNPTktgcpDVzdLuQJF3rWbC4GT9hwSNMDFViXjY84KoDHrvISgdqlhzOn0m+Yv
         w6puw73+bgPCkfkgevx6SKgNH3P22GsSGtw3G4fmdDY8PDa1jzvJfKpv9f9h7H1IKI7E
         Xwee1Hx+iFwosWYJGC11uh7XiOf1m0u9cIlRBwLHntLSn+C8TpWvvr4lrwYIdW1Sew2G
         p45LvxT+GfMJRbqccR5u0WzgrbrD1KfFnf0vwjbrhqpZ6sJct/TIs+U99c52Cgw2Pfd0
         ennfUfHLWwzl9USPr9lxEBmMDhFUIHNAZiy1lzA3AnAa/DAPzlAYt2C9w3CYcoVbqGr0
         5+Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWMbP8RqY4+b1xMGexGVrcFeoaBIZfXOq1+unfPB1BAsFtJeeFl4XuOP+Ht4n9YfBoJRH7vJvcuF5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdz2BOn7zK6nYKY3bFkTmHXpH2Dv0rfuwZHOXZLqoxt+WNLpfs
	ci4rfbqyD0nkUs4DhgVzIb2GYal1wAN1jd2+qz64loorqyMIsFjLIUtp75ul1lHzzhvuQiqxrRl
	9TOVNBvMdBwt4kbQuJm6TUYQqCmZp1J7bZxGel08nL6Dp1bmEcngoHaiNzB4=
X-Gm-Gg: ASbGncub0kC9k4qlrOhqS5MuyPXVFc4Z9iNRMRZ0jOfmHuytsOntvHCfl5eeBcte/Fz
	0LeT3an2Qdzd0b001dOdpiw2Ey2bU7goV0wmC94BSmN9wjy82XduHcbmkM+UKTtWE2xjubj08Fj
	IsiV0IxFqEueYv0cd5lHE19Jw5wvkW2kOgTN4W7ptdTNF+mrD21e5mHsH4k60SAVbFp7r5IDQDG
	dP5+SF6OnHJ9bEl+/zV4L6I/wpV99OYXG0dKgDVyzXlpBxz55MA4JSNfLBGuQtv+TpANJEm61QS
	kCKYCyau3kzWCq989My9mYDu92N05QmTOiuKhyPCycoiOcE=
X-Received: by 2002:a05:6a00:4acc:b0:736:b9f5:47c6 with SMTP id d2e1a72fcca58-73dc1566938mr6532791b3a.16.1745039984547;
        Fri, 18 Apr 2025 22:19:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPh2UeIFjUcCzHCt69mzwi3ZCMKTL2uPeLdpaaSj3UslSxHPnSkJhYpDWJ3gVtSp9W80kOGA==
X-Received: by 2002:a05:6a00:4acc:b0:736:b9f5:47c6 with SMTP id d2e1a72fcca58-73dc1566938mr6532756b3a.16.1745039984023;
        Fri, 18 Apr 2025 22:19:44 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaac258sm2607932b3a.144.2025.04.18.22.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 22:19:43 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 19 Apr 2025 10:49:25 +0530
Subject: [PATCH v3 2/3] PCI: qcom: Add support for multi-root port
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250419-perst-v3-2-1afec3c4ea62@oss.qualcomm.com>
References: <20250419-perst-v3-0-1afec3c4ea62@oss.qualcomm.com>
In-Reply-To: <20250419-perst-v3-0-1afec3c4ea62@oss.qualcomm.com>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745039969; l=8331;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=D316g5aWbCAO9Vig+hOWDXQ413eJGS6rGu5Q1O3MWFA=;
 b=dbnVmQwuH+/3RhmySFa2p8x9QvpRGzH0cB4aK3JGzGeJ6d0bzTr7YgegXUa/8+iue5zdUIu7z
 qSonHf1j5vGDLCYoNglIwLByPU2q68eMsq1Oh88kENgjNgNV3qbGTvB
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: 9shwO-cj_QV1VH6QqMV_qHNCrl59wO00
X-Authority-Analysis: v=2.4 cv=CYgI5Krl c=1 sm=1 tr=0 ts=68033272 cx=c_pps a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=kQczSkNYjdDqFxC5ROQA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: 9shwO-cj_QV1VH6QqMV_qHNCrl59wO00
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504190040

Move phy, perst handling to root port and provide a way to have multi-port
logic.

Currently, qcom controllers only support single port, and all properties
are present in the controller node itself. This is incorrect, as
properties like phy, perst, wake, etc. can vary per port and should be
present in the root port node.

To maintain DT backwards compatibility, fallback to the legacy method of
parsing the controller node if the port parsing fails.

pci-bus-common.yaml uses reset-gpios property for representing PERST, use
same property instead of perst-gpios.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 169 +++++++++++++++++++++++++++------
 1 file changed, 142 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index dc98ae63362db0422384b1879a2b9a7dc564d091..e97e5076f5f77acbbdfb982af7acc69daf9bf307 100644
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
@@ -276,22 +281,35 @@ struct qcom_pcie {
 	struct dentry *debugfs;
 	bool suspended;
 	bool use_pm_opp;
+	struct list_head ports;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
 
-static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
+static void qcom_perst_assert_deassert(struct qcom_pcie *pcie, bool assert)
 {
-	gpiod_set_value_cansleep(pcie->reset, 1);
+	struct qcom_pcie_port *port, *tmp;
+	int val = assert ? 1 : 0;
+
+	if (list_empty(&pcie->ports))
+		gpiod_set_value_cansleep(pcie->reset, val);
+	else
+		list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+			gpiod_set_value_cansleep(port->reset, val);
+
 	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
 }
 
+static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
+{
+	qcom_perst_assert_deassert(pcie, true);
+}
+
 static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
 {
 	/* Ensure that PERST has been asserted for at least 100 ms */
 	msleep(100);
-	gpiod_set_value_cansleep(pcie->reset, 0);
-	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
+	qcom_perst_assert_deassert(pcie, false);
 }
 
 static int qcom_pcie_start_link(struct dw_pcie *pci)
@@ -1229,6 +1247,59 @@ static int qcom_pcie_link_up(struct dw_pcie *pci)
 	return !!(val & PCI_EXP_LNKSTA_DLLLA);
 }
 
+static void qcom_pcie_phy_exit(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_port *port, *tmp;
+
+	if (list_empty(&pcie->ports))
+		phy_exit(pcie->phy);
+	else
+		list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+			phy_exit(port->phy);
+}
+
+static void qcom_pcie_phy_off(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_port *port, *tmp;
+
+	if (list_empty(&pcie->ports)) {
+		phy_power_off(pcie->phy);
+	} else {
+		list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+			phy_power_off(port->phy);
+	}
+}
+
+static int qcom_pcie_phy_power_on(struct qcom_pcie *pcie)
+{
+	struct qcom_pcie_port *port, *tmp;
+	int ret = 0;
+
+	if (list_empty(&pcie->ports)) {
+		ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
+		if (ret)
+			goto out;
+
+		ret = phy_power_on(pcie->phy);
+		if (ret)
+			goto out;
+	} else {
+		list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
+			ret = phy_set_mode_ext(port->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
+			if (ret)
+				goto out;
+
+			ret = phy_power_on(port->phy);
+			if (ret) {
+				qcom_pcie_phy_off(pcie);
+				goto out;
+			}
+		}
+	}
+out:
+	return ret;
+}
+
 static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -1241,11 +1312,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
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
 
@@ -1268,7 +1335,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 err_assert_reset:
 	qcom_ep_reset_assert(pcie);
 err_disable_phy:
-	phy_power_off(pcie->phy);
+	qcom_pcie_phy_off(pcie);
 err_deinit:
 	pcie->cfg->ops->deinit(pcie);
 
@@ -1281,7 +1348,7 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 
 	qcom_ep_reset_assert(pcie);
-	phy_power_off(pcie->phy);
+	qcom_pcie_phy_off(pcie);
 	pcie->cfg->ops->deinit(pcie);
 }
 
@@ -1579,11 +1646,41 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
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
@@ -1611,6 +1708,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_pm_runtime_put;
 
+	INIT_LIST_HEAD(&pcie->ports);
+
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 	pp = &pci->pp;
@@ -1619,12 +1718,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
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
@@ -1647,12 +1740,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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
@@ -1699,9 +1786,35 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	pp->ops = &qcom_pcie_dw_ops;
 
-	ret = phy_init(pcie->phy);
-	if (ret)
-		goto err_pm_runtime_put;
+	for_each_available_child_of_node(dev->of_node, of_port) {
+		ret = qcom_pcie_parse_port(pcie, of_port);
+		of_node_put(of_port);
+		if (ret)
+			break;
+	}
+
+	/*
+	 * In the case of failure in parsing the port nodes, fallback to the
+	 * legacy method of parsing the controller node. This is to maintain DT
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
 
@@ -1746,10 +1859,12 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 err_host_deinit:
 	dw_pcie_host_deinit(pp);
 err_phy_exit:
-	phy_exit(pcie->phy);
+	qcom_pcie_phy_exit(pcie);
 err_pm_runtime_put:
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+		list_del(&port->list);
 
 	return ret;
 }

-- 
2.34.1


