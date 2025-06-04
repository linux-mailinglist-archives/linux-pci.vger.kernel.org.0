Return-Path: <linux-pci+bounces-28951-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B4AACDAD6
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 11:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8213A55C2
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 09:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A8128D85B;
	Wed,  4 Jun 2025 09:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h8y441Po"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EF028D841;
	Wed,  4 Jun 2025 09:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749028810; cv=none; b=aIxzgDRI4FAy0Zn4TM/J0c9osnrQbud7Hr+Rj0Y95532WsqhCJ8FxkFZFQI/lJaxFJ+MFIe++I/Fk3lPIqHh+i0M1aQ4FYGPWOGeDlwJRUj8PvnuhCWkN3xhq11ON9V4YaR78teEaqohCudizXX/k0dW83qGdu5If9dEqjXf3XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749028810; c=relaxed/simple;
	bh=cNaCil0gJZpgGRs7Ox2udGrktOvU6cHcizpq93pLZXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S3vShb6ISpd5YNq2/wjTBoOv1KFRKII9XGmFtkoJShgXZOfAMrp9YGlQf+aqqoBNQ26QgAqP4SYORlra0AfIeX69nUrhFOb5uwbmVlDWN0raeO79Eqifjkepm9wZPTJGnWAvxwKMOcdPTCEZN8OwdF3zyWJxOtWemZYbTqgZcN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h8y441Po; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554810od004261;
	Wed, 4 Jun 2025 09:20:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=W8N7i2L/i6AYCDylNiiZl/m365luZzBqXlm
	L45hJbV0=; b=h8y441PoMGqvhHZCHCm/3d/QINHQYDT1YGlPBZNmNTN1yW7vATQ
	oXyWx043SIOYwPYZMaO5Hbe6S3+e+VIlVdN89GJjEEEQbqyNcCXDC4hYDkmzuWWD
	Kjyq2a/EgeOzBBZuviyNqLRvHaPqf3CkCoy9R1Nyq+W/dwNdZgRjEsfGAZPI/wQH
	BNjgw+zwAjc4FcvOJGWsyR+reGDTZC5JE8VElWS690qGOsVAbyFgTapok4KM8MSI
	ZXsF8m2rroozVOcPP2VGND20PVniSHaDe54gPvgbhmbVBLe5eNkckzPxceA14U2a
	IKwvBu3mwz71i4faEVRdTmuDxev0RtuGXKw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8rwjhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 09:20:01 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 5549JwhB004853;
	Wed, 4 Jun 2025 09:19:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 46ytum70ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 09:19:58 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5549JwEH004839;
	Wed, 4 Jun 2025 09:19:58 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 5549JvTL004834
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 09:19:58 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id DC6E635E1; Wed,  4 Jun 2025 17:19:51 +0800 (CST)
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
To: lpieralisi@kernel.org, kwilczynski@kernel.org,
        manivannan.sadhasivam@linaro.org, robh@kernel.org, bhelgaas@google.com,
        krzk+dt@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com, conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_qianyu@quicinc.com,
        Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: [PATCH v1 0/2] Add Equalization Settings for 8.0 GT/s and Add PCIe Lane Equalization Preset Properties for 8.0 GT/s and 16.0 GT/s
Date: Wed,  4 Jun 2025 17:19:44 +0800
Message-Id: <20250604091946.1890602-1-quic_ziyuzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Dd3bulXl8YwclfFWjSNQTsmumIW-juD5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA2OSBTYWx0ZWRfX3koqlSDJioCY
 2duGTTBrTkhqBetfYF6zR0KFLj3/qgYhpPHx8TWWd/xZ97CxEoISk6xPKQss5dlqeTlI5oOdMnY
 vWQNAjMXRyuYQ7Alrvg2xPTXBsNutYFeosWPxDOTKsA8/FbdrnMyDNCXNo9ZRiIGnW2ZGtlLShc
 ogOfJLFHsKpainqdEH4RglzdD4KB5ztzIPuxsBPTn+aS4d2aH4MeJ/CvFWt8gJKrsa+k5Kgst/u
 P58K4k0szUwa5D8+hGU2omps58eC2DaLWfkfGeqCfqfUguL6L+byJM2alPSd2GjRJdCPqyiO3sx
 iZxMha9ppQMab7X9vltEzvXGh+XoBOT0EPnfiX8/9gTYXHFhUTW28g1gu5mMaeY7jHPIKlhsWrI
 DrEW6iuoVI9JonzSRTY4Q+CpBflGtkYZB2i6cpl5rqb7FF6ch4hiU07ZExHsCeb51QFt927i
X-Authority-Analysis: v=2.4 cv=RdWQC0tv c=1 sm=1 tr=0 ts=68400fc1 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=pGW_TeUqoRlRwQqC-JsA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Dd3bulXl8YwclfFWjSNQTsmumIW-juD5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 spamscore=0 mlxlogscore=707 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040069

This series adds add equalization settings for 8.0 GT/s, and add PCIe lane equalization
preset properties for 8.0 GT/s and 16.0 GT/s for sa8775p ride platform, which fix AER
errors.

While equalization settings for 16 GT/s have already been set, this update adds the
required equalization settings for PCIe operating at 8.0 GT/s, including the
configuration of shadow registers, ensuring optimal performance and stability.

The DT change for sa8775p add PCIe lane equalization preset properties for 8 GT/s
and 16 GT/s data rates used in lane equalization procedure.

Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>

Ziyue Zhang (2):
  PCI: qcom: Add equalization settings for 8.0 GT/s
  arm64: dts: qcom: sa8775p: Add PCIe lane equalization preset
    properties

 arch/arm64/boot/dts/qcom/sa8775p.dtsi         |  8 +++
 drivers/pci/controller/dwc/pcie-designware.h  |  1 -
 drivers/pci/controller/dwc/pcie-qcom-common.c | 55 ++++++++++---------
 drivers/pci/controller/dwc/pcie-qcom-common.h |  2 +-
 drivers/pci/controller/dwc/pcie-qcom.c        |  3 +-
 5 files changed, 40 insertions(+), 29 deletions(-)


base-commit: 911483b25612c8bc32a706ba940738cc43299496
-- 
2.34.1


