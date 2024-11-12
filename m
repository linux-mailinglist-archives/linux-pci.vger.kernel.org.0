Return-Path: <linux-pci+bounces-16553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9646E9C5C10
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 16:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A5F9B34E38
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 15:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD7D203714;
	Tue, 12 Nov 2024 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fXJfUO3l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BFB201267;
	Tue, 12 Nov 2024 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423758; cv=none; b=gsAIOXTvoPVDGyRqSVLW8ZDySDqGeUWCPRoAmVyMP1Th76v2gpCgXY0z94E285BPccJhtTg7yVauYzUXdL3U86z6sQ7hl95W3B3/RZvxnz5KaLzbKZyopEYfSphAEjMuvlGwH7TPRcQ8sC79pkpkx9o/Q+ZKEcKEnvGAdjf/H4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423758; c=relaxed/simple;
	bh=PK18cavKV5chEiNChjHJQl/inxoZA+Yuo3hykeL9IYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Y3Mh671WbdIaNZTKwgG0iWzeB5q7Gn+7oRS6Bftv8GC7lg0902jh+hO0AUSsROcFkSvwaSXZYHzmex3eoG6DxqfIUH196NAICy8/QPELX11w8ssTrSIXXmpe5O3EJJd79oEknu/yox888UmB1nW60yw0f/fir8+VUSVZpSZamv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fXJfUO3l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACCWwkl012513;
	Tue, 12 Nov 2024 15:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PKyrDsiyCg5jyI48LuKyzuS0PrZR6PHVH8xvj4Alswk=; b=fXJfUO3lm0jSxlAG
	qo9YxqJa9dbO04k9BjKNW43qPpl66MSD+P3J5aTrF27aPlEVjVDvVK454jQB7i9c
	BSpl2f0SWUApB2fs91ohXL8IfL9bheT7w/bCYjZ2xFRZq5fCTLHlDMRG/pGZVc5B
	lRiuwl921mlZHw6CwC8XiFhLI0I31TgPI/sHeLO3uqTUQvg6rE59jr4MSP1DqFT+
	pqhDM14bFopqppAeKCTNCuWlXVCCK3qvjrVenaNEQJCizLye5IUaKqQaIBnA6nP4
	JgoukMCRhzxBUFpNpUBaJN2zMkO5ZcvRJxxAtNxIzdYB+Qadb3AYN7RwFtbk2gO6
	BWmFeA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42syax7n0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 15:02:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ACF2LeA001750
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 15:02:21 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 12 Nov 2024 07:02:16 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Tue, 12 Nov 2024 20:31:37 +0530
Subject: [PATCH v3 5/6] PCI: qcom: Add support for host_stop_link() &
 host_start_link()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241112-qps615_pwr-v3-5-29a1e98aa2b0@quicinc.com>
References: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com>
In-Reply-To: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com>
To: <andersson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Rob Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        Jingoo Han <jingoohan1@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>
CC: <quic_vbadigan@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731423711; l=2865;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=PK18cavKV5chEiNChjHJQl/inxoZA+Yuo3hykeL9IYY=;
 b=61EPtRM5VeUZFJFTGAs1HargGSj3IKyC0tIOYdGfPotWmV7C38nyUrQMe2/me9iu2oTL46E1p
 ZNEv4Pfuyc5BxAHhhM9dTO59divNZbLgoFN11/cJOcRJNyzZLYz9fzK
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WH0ZbntZddgOi2UzgyNnZbWkz2L10W0x
X-Proofpoint-GUID: WH0ZbntZddgOi2UzgyNnZbWkz2L10W0x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411120120

For the switches like QPS615 which needs to configure it before
the PCIe link is established.

If the link is up, the boatloader might powered and configured the
endpoint/switch already. In that case don't touch PCIe link else
assert the PERST# and disable LTSSM bit so that PCIe controller
will not participate in the link training as part of host_stop_link().

De-assert the PERST# and enable LTSSM bit back in host_start_link().

Introduce ltssm_disable function op to stop the link training.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 39 ++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ef44a82be058..048aea94e319 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -246,6 +246,7 @@ struct qcom_pcie_ops {
 	void (*host_post_init)(struct qcom_pcie *pcie);
 	void (*deinit)(struct qcom_pcie *pcie);
 	void (*ltssm_enable)(struct qcom_pcie *pcie);
+	void (*ltssm_disable)(struct qcom_pcie *pcie);
 	int (*config_sid)(struct qcom_pcie *pcie);
 };
 
@@ -617,6 +618,41 @@ static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
 	return 0;
 }
 
+static int qcom_pcie_host_start_link(struct dw_pcie *pci)
+{
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+
+	if (!dw_pcie_link_up(pcie->pci))  {
+		qcom_ep_reset_deassert(pcie);
+
+		if (pcie->cfg->ops->ltssm_enable)
+			pcie->cfg->ops->ltssm_enable(pcie);
+	}
+
+	return 0;
+}
+
+static void qcom_pcie_host_stop_link(struct dw_pcie *pci)
+{
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+
+	if (!dw_pcie_link_up(pcie->pci))  {
+		qcom_ep_reset_assert(pcie);
+
+		if (pcie->cfg->ops->ltssm_disable)
+			pcie->cfg->ops->ltssm_disable(pcie);
+	}
+}
+
+static void qcom_pcie_2_3_2_ltssm_disable(struct qcom_pcie *pcie)
+{
+	u32 val;
+
+	val = readl(pcie->parf + PARF_LTSSM);
+	val &= ~LTSSM_EN;
+	writel(val, pcie->parf + PARF_LTSSM);
+}
+
 static void qcom_pcie_2_3_2_ltssm_enable(struct qcom_pcie *pcie)
 {
 	u32 val;
@@ -1361,6 +1397,7 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
 	.host_post_init = qcom_pcie_host_post_init_2_7_0,
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
+	.ltssm_disable = qcom_pcie_2_3_2_ltssm_disable,
 	.config_sid = qcom_pcie_config_sid_1_9_0,
 };
 
@@ -1418,6 +1455,8 @@ static const struct qcom_pcie_cfg cfg_sc8280xp = {
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 	.start_link = qcom_pcie_start_link,
+	.host_start_link = qcom_pcie_host_start_link,
+	.host_stop_link = qcom_pcie_host_stop_link,
 };
 
 static int qcom_pcie_icc_init(struct qcom_pcie *pcie)

-- 
2.34.1


