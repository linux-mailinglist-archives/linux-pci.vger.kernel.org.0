Return-Path: <linux-pci+bounces-16990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C0A9D011F
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 23:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44B2EB23B09
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 22:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9DE198A1A;
	Sat, 16 Nov 2024 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NGoQS37I"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCFB11712;
	Sat, 16 Nov 2024 22:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731794446; cv=none; b=JkYilFGRYA5+sT3CLee3L8s4HZoVv0tvHY6XrT3n3e4M/uo3rUhbnS6i6E6eildf+EfbOyJAhFEKZiPSPGFGw9SUgLq2wFcOMZ+/KuY4d/nnckQvmydHri4Hrs9cKsXWuiGzdSLUmM11Zny3Kwk1HOusjCD/54CsTeRZK4HUvcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731794446; c=relaxed/simple;
	bh=66QrEb+eTUbvvgt8hveUhJrPhRZIfy2WvS7z62h6HF4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=CU8yyIVDga9Q8Urc3pGw2Cp9hUJrdD+XKk8i+6JHgKnH23Sz6+Sqh2NH0UqkbEVX+OOFqdouICObMDk+g6FUk0q2jlj7jfhjud6mUFQ7rvtnxg5BLJT8pvaUjVPNtX8cJOg4e2r41f3meBJe8T/KYb660DosYGJ7tujnuJJjKCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NGoQS37I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AGKuFB9029265;
	Sat, 16 Nov 2024 22:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=s5dXeV/oNNmmXf2FwidyS6
	ClqyCybP6m2ESQ1R+AXwQ=; b=NGoQS37Imbu4xXJ4wnctzbN6XA+w/nSbYdTJOb
	NglMTfNYTmQlMY5Anl2NT9ZDv/6gSsU6oToYuQyu677lz/GtEmB82oH+i0GpnzEZ
	fUydHG7UbfLc6bzIwUpPw9WnQBEGwrwiBECGJIezO3QEs/ryg4NtBJShrpppKuNf
	AoOE0y7CywviYCiVx4Rs/AkF1JJpEEwXHmkE0WbP2f/vA7bTFswOvbkYXxJZNdMY
	HtVhghwaQnTLVVqlCK4AeK1wmARdBU9ivtX/rfr9SL1ZaQK7KzwEkyyLm9kxcVHd
	k4YzIhfvL4+YYDb6ge8ZWR55oGJuDiTKQsLGh19fyV7KQIfA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42xmp79agk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 22:00:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AGM0VHj014234
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 22:00:31 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 16 Nov 2024 14:00:24 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH 0/3] PCI: dwc: Add ECAM support with iATU configuration
Date: Sun, 17 Nov 2024 03:30:17 +0530
Message-ID: <20241117-ecam-v1-0-6059faf38d07@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPEVOWcC/zXMQQ7CIBCF4as0sxbDlCqJK+/RdNGOg51FQUGJp
 uHuYo3L/+XlWyFxFE5walaInCVJ8DVw1wDNo7+ykkttaHXbocajYhoXNaE7OJ7IkSGo11tkJ6+
 N6Yfas6RHiO9Nzfhd/4D9ARmVVsYa7pDQtpM+359C4mlPYYGhlPIBZznOOpoAAAA=
To: <cros-qcom-dts-watchers@chromium.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_vpernami@quicinc.com>, <quic_mrana@quicinc.com>,
        <mmareddy@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731794424; l=2484;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=66QrEb+eTUbvvgt8hveUhJrPhRZIfy2WvS7z62h6HF4=;
 b=RK2/2BWM65Rz2Y+c+RNrbnHt6LwtL5085wjS5TzpIN/Ab/ik0vhZySukU4hxtGugf/CumWlQa
 u+f1QCeoCEEAfYNAHCMqDEIJinhbzDC0Gcpb6pL4w9u2qtlq99GG/IV
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JuysSIYxepgnWMlhLeok3cDHrprbj_rf
X-Proofpoint-GUID: JuysSIYxepgnWMlhLeok3cDHrprbj_rf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411160192

The current implementation requires iATU for every configuration
space access which increases latency & cpu utilization.

Configuring iATU in config shift mode enables ECAM feature to access the
config space, which avoids iATU configuration for every config access.

Add cfg_shft_mode into struct dw_pcie_ob_atu_cfg to enable config shift mode.

As DBI comes under config space, this avoids remapping of DBI space
separately. Instead, it uses the mapped config space address returned from
ECAM initialization. Change the order of dw_pcie_get_resources() execution
to acheive this.

Introduce new ecam_init() function op for the clients to use configure
after ecam init has done.

Enable the ECAM feature if the config space size is equal to size required
to represent number of buses in the bus range property.

The ELBI and iATU registers also fall after the DBI space, so use the cfg
win returned from the ecam init to map these regions instead of doing the
ioremap again. iATU starts after 4KB of dbi address and ELBI starts at
offset 0xf20 from dbi.

On bus 0, we have only the root complex. Any access other than that should
not go out of the link and should return all F's. Since the IATU is
configured for bus 1 onwards, block the transactions for bus 0:0:1 to
0:31:7 (i.e., from dbi_base + 4KB to dbi_base + 1MB) from going outside the
link through ecam blocker through parf registers.

Increase the configuration size to 256MB as required by the ECAM feature
and also move config space, dbi, iatu to upper space and use lower space
entirely for BAR region.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
---
Krishna chaitanya chundru (3):
      arm64: dts: qcom: sc7280: Increase config size to 256MB for ECAM feature
      PCI: dwc: Add ECAM support with iATU configuration
      PCI: qcom: Enable ECAM feature based on config size

 arch/arm64/boot/dts/qcom/sc7280.dtsi              |  12 +--
 drivers/pci/controller/dwc/pcie-designware-host.c | 114 ++++++++++++++++++----
 drivers/pci/controller/dwc/pcie-designware.c      |   2 +-
 drivers/pci/controller/dwc/pcie-designware.h      |   6 ++
 drivers/pci/controller/dwc/pcie-qcom.c            | 104 +++++++++++++++++++-
 5 files changed, 208 insertions(+), 30 deletions(-)
---
base-commit: 2f87d0916ce0d2925cedbc9e8f5d6291ba2ac7b2
change-id: 20241016-ecam-b1f5febcfc3c

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>


