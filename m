Return-Path: <linux-pci+bounces-12494-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F439659B3
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 10:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE1EE283E72
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 08:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E2D16C6BD;
	Fri, 30 Aug 2024 08:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f6gk6D9W"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524DD1662E9;
	Fri, 30 Aug 2024 08:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005552; cv=none; b=Wsv+gS4wNQmZ2hj6zH25Lwoeol1tTtEQNTHIJyoNKHubOBfXx/im0wUxO/b5JboNDIdswUbrhEtAdRyi31VU3VIkqhrg38XZ0k/ekERxJjXmCDfTrzHg6VQ+Mln83iZdAdxddpF7x1ZhqHq26HlmlIVkOJrxSZjf4khGUG5NyhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005552; c=relaxed/simple;
	bh=Uhxa9m/XpteOfUJZw2Q2F5tehPi1ofHMzr1Dy9LkPvo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BcqzqLgPtdSoa7ZGjNWk93J5c7U3N8Dp1SlJX2m8Vnk7rD7jG2SE8n9Nb5rXgLHRfNr87QnusCh4ZQRqjdHPrlYQMESFnL6qZUtulY+stlSl+4o/BQaMNbpiod4Fx1FTu4ab8r/MYVQ+Ns8wlkTevxYDybwb9qoPhfHc2R6LdYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f6gk6D9W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U82FKK014817;
	Fri, 30 Aug 2024 08:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=WzhEQEwjdllwj0vXOBom7x
	uTc7Ztg2B5E/X6dg14QpA=; b=f6gk6D9WwtGHIt5gkp9TZb/NKW/a/XmVQI1onI
	jq152p+AlX0oOialE1DmqF/+NkUa6z9dmiPJhLMN3QGZaGPippSTnwtLpZmoZvg6
	1xvHWmfabPu9GBIBCbpktvM2ASvR8mOVKmCEQi7uf01UoirwxMnC03WlrteDupL2
	ao3snsyT+uvQJnZni2YuHoTDoFKQG7np+4tsDn/hY9B3OiguwOPNOGL4uNWNaXp9
	TAXnaYuJBHR4562m8wSypNZBRIEri+FJ6ya2QDUbKRyjzWsj7J8oiDULT0v35qfm
	rPM7oRnd9w7PxNfMQz1AhWyMaTypqahK7L2mriOs0F3/mqLA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419px5qsyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 08:12:10 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47U8Bqr9006343
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 08:11:52 GMT
Received: from hu-srichara-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 30 Aug 2024 01:11:46 -0700
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
Subject: [PATCH V3 0/6] Enable IPQ5018 PCI support
Date: Fri, 30 Aug 2024 13:41:26 +0530
Message-ID: <20240830081132.4016860-1-quic_srichara@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: q7F81tEDt44XnZU3hI6WA4efSH2nwZDP
X-Proofpoint-GUID: q7F81tEDt44XnZU3hI6WA4efSH2nwZDP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_03,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 adultscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=887 spamscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408300060

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

This patch series adds the relevant phy and controller
DT configurations for enabling PCI gen2 support
on IPQ5018.

v3:
  Added Reviewed-by tag for patch#1.
  Fixed dev_err_probe usage in patch#3.
  Added pinctrl/wak pins for pcie1 in patch#6.

v2:
  Fixed all review comments from Krzysztof, Robert Marko,
  Dmitry Baryshkov, Manivannan Sadhasivam, Konrad Dybcio.
  Updated the respective patches for their changes.

v1:
 https://lore.kernel.org/lkml/32389b66-48f3-8ee8-e2f1-1613feed3cc7@gmail.com/T/

Nitheesh Sekar (5):
  dt-bindings: phy: qcom,uniphy-pcie: Document PCIe uniphy
  dt-bindings: PCI: qcom: Add IPQ5108 SoC
  phy: qcom: Introduce PCIe UNIPHY 28LP driver
  arm64: dts: qcom: ipq5018: Add PCIe related nodes
  arm64: dts: qcom: ipq5018: Enable PCIe

Sricharan R (1):
  PCI: qcom: Add support for IPQ5018

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  35 ++
 .../phy/qcom,ipq5018-uniphy-pcie.yaml         |  70 ++++
 .../arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts |  37 ++
 arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 168 ++++++++-
 drivers/pci/controller/dwc/pcie-qcom.c        |   1 +
 drivers/phy/qualcomm/Kconfig                  |  12 +
 drivers/phy/qualcomm/Makefile                 |   1 +
 .../phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c  | 346 ++++++++++++++++++
 8 files changed, 668 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,ipq5018-uniphy-pcie.yaml
 create mode 100644 drivers/phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c

-- 
2.34.1


