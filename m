Return-Path: <linux-pci+bounces-29020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA8CACEBEF
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 10:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568BB175245
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 08:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A22205AC1;
	Thu,  5 Jun 2025 08:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="li/jv+DK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3717220E00B
	for <linux-pci@vger.kernel.org>; Thu,  5 Jun 2025 08:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749112263; cv=none; b=PY57EBhwIK9UuwSToImoXk4PxI1q0tt7ADuNdHNpDI9aozCRgX4iXaHJn2FsWGDPuN+B8h3vBpIFxD9IFWJfhEykgwq9uHrh0+OJvRfIWaiUpktSiChuD0rYRa0JQxUI3bX5i13m1zaFE62x/aAWy+2yfieXFA/SjUZqt+exLvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749112263; c=relaxed/simple;
	bh=7PP7t7UmIhjpJDUL+UNMb+EFlz+L/Pm7weNLJ5tj9a4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QHKjr5J1BktUX+ePwCXUnKjDuQMCHRlozqpywtgS4iWlbk25sTVH+ol51McxlyyJfYqjnOpY99OxCwY13ME6AXCDT1kKWvRS/CLmDXS4Ndw6ocvgjae8I5UuXAVkZzg90aFZN7HBCIpQlJ7i1SVPw9qAuZXtaJaunwVKKisT6Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=li/jv+DK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5557xgA9010405
	for <linux-pci@vger.kernel.org>; Thu, 5 Jun 2025 08:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qg8pLKziM6sr+0gWlkO+Qxv6q6rues0qiIooWkKwRYg=; b=li/jv+DKX8C5LHh+
	bvsq8J1mJudg8FZ3zSiCtxErtu1ZY4wx3YpViyRHsKHZnWQ57breOfDVyrgMS7WV
	ko6rZB/Rq/QSQu5npobI48nQEImnITrsFWxVkykZ1pZU5DNiozuWabr4jiqkWTd6
	2fGBk5N5ZOLCGAnq2FAJUn+1wW91p1RZqcmzDsRYiQsNF78DfUCH8FcqMbDSXOTY
	DKxbO3tTGk7XBCTKHFHJZzxxQaWLgEDsyCkRq6ov//F9zOo4shjEq8BvB0Va8dHk
	4kYcQ4xbUFh1h5Rxj3x6q1PWSnkOeQBIpL2aPQTqee1eVcKhxsOF/6HNyC9hiCTF
	TRmDeQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8yrnk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Jun 2025 08:31:00 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b2f4c436301so436117a12.0
        for <linux-pci@vger.kernel.org>; Thu, 05 Jun 2025 01:30:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749112259; x=1749717059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qg8pLKziM6sr+0gWlkO+Qxv6q6rues0qiIooWkKwRYg=;
        b=psrzBFkx7wSRLgtm+5lT4K4yEA0im7v3iSAqE2Vb/PxYcH/xxZD714ZZljvAX71BUW
         FhzX6A5zmKls/mJw2uGF/z2+WaEnos51n6IPyI4FsBd2R/6GOneDBixq7+ev23stVCij
         x2QiGKclLKAxEXSE+3cbk4xC2jNpK3bCkOwEiv1N20ABJTLRveZbKYrR6O32r9yCd6Il
         u7ar6+QRVJMwkpAmFvvnPkcEkssaGZ/O75bWhL+3UM193MCMdRT2IP+4JuTmPm00OiBl
         652l78hQTjOYBao1jTE3X+bH0OwK/s5Rk73GOd0Cx1XxgybP2zxDZuhkyfHGecBgGR7c
         HL2A==
X-Forwarded-Encrypted: i=1; AJvYcCX3qEoytEJ2a48R6Wc0u4UUGrHOIY91dKXHmcbS6PtAeC9zae2wHBJgHXzO2ovdOKHHIk4s0fS7zog=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHy4Ulx8gEoaDJ4DwN/s+MAxJGCFR0nnx+rEwzqZVTaDY2GMY8
	oGNNGI4ilqS80TKk02OIriqCWdt1yAtM2obEiW/HRzx9Rsb5MC2kDq/Bde+oh58/T5PL6ezIlOO
	P6HH+YpTK8NhfbtUi0Wp7pyQp2EFEZI813tzE9kmejJCNLeu5vRE17qb/zrCV4y0=
X-Gm-Gg: ASbGncunsz0B0vacDpBa02kAtOEA4bYkyu/KMQoJBNLmQinPvw/rA7+/uaqxO1a/EN2
	I5m7dno2kkzbvOzTwaP0gL/wIuut79+L56zxoij8eeqw6uK3yfM3ZZ0a9spXN9EFas7Vuzmm7tw
	ugNhRIYcr20LNC9WVigq2MsKD3Gjqf/Eu6iLvyLrh8gFQdzsbCs7YD8kguz0oZmZ9lNrA33tLTV
	BSho+1fDPuAR7OpEz0ml5f+jReZJm+avjods5bKuLgyF6LChm3+JYeOW93VKMx3wzLd0iw825mF
	/jBDRiC72lAUZzUi2PFTORywAp9nx1HKWAQjSkGZz9zU60M=
X-Received: by 2002:a05:6a20:3d07:b0:218:1446:dd34 with SMTP id adf61e73a8af0-21d36286b37mr4365654637.3.1749112258680;
        Thu, 05 Jun 2025 01:30:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxDNzph8fe0dAaIJSSuexo1dZeZbrW7mHJocaKH5pkzoj0luOUOXwIsfSjwZe91rmPaJa74g==
X-Received: by 2002:a05:6a20:3d07:b0:218:1446:dd34 with SMTP id adf61e73a8af0-21d36286b37mr4365612637.3.1749112258231;
        Thu, 05 Jun 2025 01:30:58 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb37d5dsm9819095a12.34.2025.06.05.01.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 01:30:57 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 05 Jun 2025 14:00:38 +0530
Subject: [PATCH v4 2/2] PCI: qcom: Add support for multi-root port
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-perst-v4-2-efe8a0905c27@oss.qualcomm.com>
References: <20250605-perst-v4-0-efe8a0905c27@oss.qualcomm.com>
In-Reply-To: <20250605-perst-v4-0-efe8a0905c27@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749112243; l=8532;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=7PP7t7UmIhjpJDUL+UNMb+EFlz+L/Pm7weNLJ5tj9a4=;
 b=zgBmQNTe6v43QHoDdvfXV1jTTvZeGCWXKw4nsEMY4CLCNQA7SY3i/BPQ+5yHSAF1kasy/glyJ
 bWADPxNyWubBgs7y2bMD4cX1rgmCu3OHPuX5aSUXfJXanfe+7JXyM0k
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA3NCBTYWx0ZWRfXxtYZOypbSJcr
 UfrRtE1kFKo0CVtTCYQfeixOdR9/Wb6aDJr/O2oaxituqHZe4lKX24c5xHHOGh1jkC1vy56Sdku
 2ifHJCg0NO1bM+9imK0YTrvK1zHikHVnCrj4pvrRHTSe9QffQPDnVSZKazWZt3AMiRmA2zK0Igo
 XuNBVNHzCRZfb61iTuMosTyZjM1sWP4VAS1w3G9o3vGJwA34xRy5moxqOuY9e6Q75DTqG77xMvt
 P62ugs5jWW0Bv+YG/3qa0IWsGK3gYWk9vLNCKZHWWlUyMdTUcfvOYYMp79vR/UytXR9e9el2H+8
 /49kx+4OuhCEJMZo/6KB+vxwusl/FQUbqBWkeeDbkEv19HCrjc3hgrJVJn6TLafAwqhFnwwrVnv
 deOcnhiXP7kma8B+Sh2YoB5abXVCAB9TxEWtbJveH+JT661tAsJD96l9nGlcecO+9CE2CwMd
X-Proofpoint-ORIG-GUID: UjnVRE5awr7kZgZJJBLmNv8u8DPseHQo
X-Proofpoint-GUID: UjnVRE5awr7kZgZJJBLmNv8u8DPseHQo
X-Authority-Analysis: v=2.4 cv=T/uMT+KQ c=1 sm=1 tr=0 ts=684155c4 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=kQczSkNYjdDqFxC5ROQA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 adultscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506050074

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
 drivers/pci/controller/dwc/pcie-qcom.c | 177 ++++++++++++++++++++++++++++-----
 1 file changed, 150 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c789e3f856550bcfa1ce09962ba9c086d117de05..653be8125a6a0e48f9d09706adafb3ff96b4b52b 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -262,6 +262,12 @@ struct qcom_pcie_cfg {
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
@@ -274,24 +280,37 @@ struct qcom_pcie {
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
@@ -1229,6 +1248,59 @@ static bool qcom_pcie_link_up(struct dw_pcie *pci)
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
@@ -1241,11 +1313,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
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
 
@@ -1268,7 +1336,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 err_assert_reset:
 	qcom_ep_reset_assert(pcie);
 err_disable_phy:
-	phy_power_off(pcie->phy);
+	qcom_pcie_phy_power_off(pcie);
 err_deinit:
 	pcie->cfg->ops->deinit(pcie);
 
@@ -1281,7 +1349,7 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 
 	qcom_ep_reset_assert(pcie);
-	phy_power_off(pcie->phy);
+	qcom_pcie_phy_power_off(pcie);
 	pcie->cfg->ops->deinit(pcie);
 }
 
@@ -1579,11 +1647,41 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
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
@@ -1611,6 +1709,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_pm_runtime_put;
 
+	INIT_LIST_HEAD(&pcie->ports);
+
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 	pp = &pci->pp;
@@ -1619,12 +1719,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
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
@@ -1647,12 +1741,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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
@@ -1699,9 +1787,42 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
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
+				goto err_pm_runtime_put;
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
 
@@ -1746,10 +1867,12 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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


