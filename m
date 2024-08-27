Return-Path: <linux-pci+bounces-12238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D7E9600AD
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 07:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A078B220CA
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 05:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAE01547C5;
	Tue, 27 Aug 2024 04:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JmKZGy7r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1FE14D29C;
	Tue, 27 Aug 2024 04:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724734737; cv=none; b=K0XFSlFxPojJB3GW0+wGvZaXTH1k0Ym53MgdyWhAH1XuBAF58kqmpkK/0WMCpq6L5FRIK/yGvsyILizh1GngIQNhf/ndBNSX1F8XlezESzc4xBF4p2V7detBFzD6wOIa4dQt9OORTUIfHANEwbP0pMeeSXzytLDEDxfNXbSHgTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724734737; c=relaxed/simple;
	bh=iAoi81BW5X4Vp5HZ66FIVGQAVAHNn6ZlT7QlKZCysdw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ot1FHPpJpUUan+ahhqgO8PAM5a2zrtOy2CGob/B/4Omay4oBfkLjOQiylvAvo8KocaempKtBJIXDG4/KlBaLsqmjn4dBNoG2w1xy/sWlf5pIOglabU5acR+K5YzOUi/a64EVFVPAHkBJcSnYpcgu3iMTsE5OqY7CyCJ/Sa+x5Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JmKZGy7r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QJGc5n026691;
	Tue, 27 Aug 2024 04:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dpGJjLfPrHRXy0Suhj+SCH62KEzjEOJyah7UJSecOkA=; b=JmKZGy7r1fXWKaPC
	VYkj3iGYBpjazYy4Ya7kmD94C/WNAAIv+OTULAC1PAvzlrG35N9JQC8jgjdqZ4XQ
	EH5+3Of+RlCg45Oo84cumgAwBY4QUr8M3lD+ppwJ3QcWmWZ8bUCQ5DfaOVwUnbi/
	tO0pbSgR+rQQy02047Adqdytjwn6H3TWhFO14mjYF8vPB/w2lI5rSpHB9f2oDgW0
	1TNi+qlnh8jT3XhJMz1orxLZklmpehnFrRNspWoCZ5BbMx7yV72XRugFtRG95EoS
	zXQVLlZAFMvbpu/kBOzSykZ3uxqbHXp1053byoDx+jzsjdO+mmim4uSfNa2qKhrO
	9UXUBA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41798ewpr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 04:58:45 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47R4wh84001826
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 04:58:43 GMT
Received: from hu-srichara-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 26 Aug 2024 21:58:37 -0700
From: Sricharan R <quic_srichara@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <p.zabel@pengutronix.de>, <dmitry.baryshkov@linaro.org>,
        <quic_nsekar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <robimarko@gmail.com>, <quic_srichara@quicinc.com>
Subject: [PATCH V2 4/6] PCI: qcom: Add support for IPQ5018
Date: Tue, 27 Aug 2024 10:27:55 +0530
Message-ID: <20240827045757.1101194-5-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827045757.1101194-1-quic_srichara@quicinc.com>
References: <20240827045757.1101194-1-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZyZJRZWOOLtTahajhISDAOdfCcWI_MXR
X-Proofpoint-ORIG-GUID: ZyZJRZWOOLtTahajhISDAOdfCcWI_MXR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_03,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408270034

Introduce a new compatible and re-use 2_9_0 ops.

Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
---
 [v2] Rebased on top of latest tip and only compatiable addition is required

 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 6f953e32d990..e814d6cc062d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1722,6 +1722,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
 	{ .compatible = "qcom,pcie-ipq4019", .data = &cfg_2_4_0 },
+	{ .compatible = "qcom,pcie-ipq5018", .data = &cfg_2_9_0 },
 	{ .compatible = "qcom,pcie-ipq6018", .data = &cfg_2_9_0 },
 	{ .compatible = "qcom,pcie-ipq8064", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
-- 
2.34.1


