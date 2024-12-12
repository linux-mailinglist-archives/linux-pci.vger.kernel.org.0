Return-Path: <linux-pci+bounces-18222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 446979EE121
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 09:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D3B282F00
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 08:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5953520B7E6;
	Thu, 12 Dec 2024 08:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="chU9ngdz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8284020C018;
	Thu, 12 Dec 2024 08:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733991654; cv=none; b=o0Qa0segcW5Y11pPaB7eFo1fPnKYcDSh8nzToAiIcbJkddpfEMi10JQwniq3lWRCdJxJ36Sej+lfqutoSKR5qqlLryemSW1HU1qsugdu+L2LUWvlFk7r6k4FDfT1F8tPy2Myg7HhwFmXUChteYNnZho81HbfS3UYGhV9S8F8ykI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733991654; c=relaxed/simple;
	bh=5hbva0ra1WgEeS0msvoBjcB4tt/jwYhd3Q1X0RsoUmU=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=U3/IDsJhW1ouMBL+KMiMof2mabGCM6OtF2FoOSR8XMhAND03495OQrrMjNj9d9guEMdGV5y7AgHK6Vb9KA3wVZTtEdpXAXwcu7B2tnux32sDaJbOJCTGC/fznkvidAYXnBg9lx9j2vKbWzSQVcarc8zOvSW7cNSuMRzuqB9eBZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=chU9ngdz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC7dTOn027247;
	Thu, 12 Dec 2024 08:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=RY2XHyRT98M51wFIDOeTWd
	YXbB3NyzBkPbM/GJSC4qg=; b=chU9ngdznHSysrQnX0NI72Fjpk8++3izbGFgA6
	BdPN9TVMtSFgXqwKNVQFowVUvIIonU1kqXgonABabe3AQccpQbmf3p+HHC3MA3Xm
	G2ZAk6OpSJIsxQaiprIn0h2CiFpTkqK4UU3PLnAzxUVTa5mXYIZipnwRUAGLNBdA
	7mAruym5eeHbi+tcVvqxHpzdVq+8JMyByj+z+uaZlhRvffAjyqWdgkAgqXuarMtE
	If6R/KOAV9O+6gJKRH8/bjZAZIrn9mOgVkw8tWS+UOAFgHuIwPRsLmNmvosw51H5
	nleHF7mCxzU6rn15zBeEq09b5kBHwskSTwIipVRV4WYMC3bw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43etn8wfxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 08:19:19 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BC8JItT007947
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 08:19:18 GMT
Received: from [10.239.28.138] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 12 Dec
 2024 00:19:15 -0800
Message-ID: <1524e971-8433-1e2d-b39e-65bad0d6c6ce@quicinc.com>
Date: Thu, 12 Dec 2024 16:19:12 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To: <jingoohan1@gmail.com>, <manivannan.sadhasivam@linaro.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <quic_cang@quicinc.com>, <mrana@quicinc.com>,
        yuqiang
	<quic_qianyu@quicinc.com>, <quic_wenbyao@quicinc.com>
From: "Wenbin Yao (Consultant)" <quic_wenbyao@quicinc.com>
Subject: [PATCH] PCI: dwc: Set PORT_LOGIC_LINK_WIDTH to one lane
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yk5AQikQeuvfqi_BdniJ95yqvb4M4z1G
X-Proofpoint-GUID: yk5AQikQeuvfqi_BdniJ95yqvb4M4z1G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=870 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120056

PORT_LOGIC_LINK_WIDTH field of the PCIE_LINK_WIDTH_SPEED_CONTROL register
indicates the number of lanes to check for exit from Electrical Idle in
Polling.Active and L2.Idle. It is used to limit the effective link width to
ignore broken or unused lanes that detect a receiver to prevent one or more
bad Receivers or Transmitters from holding up a valid Link from being
configured.

In a PCIe link that support muiltiple lanes, setting PORT_LOGIC_LINK_WIDTH
to 1 will not affect the link width that is actually intended to be used.
But setting it to a value other than 1 will lead to link training fail if
one or more lanes are broken.

Hence, always set PORT_LOGIC_LINK_WIDTH to 1 no matter how many lanes the
port actually supports to make linking up more robust. Link can still be
established with one lane at least if other lanes are broken.

Signed-off-by: Wenbin Yao <quic_wenbyao@quicinc.com>
---
  drivers/pci/controller/dwc/pcie-designware.c | 5 +----
  1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c 
b/drivers/pci/controller/dwc/pcie-designware.c
index 6d6cbc8b5b2c..d40afe74ddd1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -752,22 +752,19 @@ static void dw_pcie_link_set_max_link_width(struct 
dw_pcie *pci, u32 num_lanes)
      /* Set link width speed control register */
      lwsc = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
      lwsc &= ~PORT_LOGIC_LINK_WIDTH_MASK;
+    lwsc |= PORT_LOGIC_LINK_WIDTH_1_LANES;
      switch (num_lanes) {
      case 1:
          plc |= PORT_LINK_MODE_1_LANES;
-        lwsc |= PORT_LOGIC_LINK_WIDTH_1_LANES;
          break;
      case 2:
          plc |= PORT_LINK_MODE_2_LANES;
-        lwsc |= PORT_LOGIC_LINK_WIDTH_2_LANES;
          break;
      case 4:
          plc |= PORT_LINK_MODE_4_LANES;
-        lwsc |= PORT_LOGIC_LINK_WIDTH_4_LANES;
          break;
      case 8:
          plc |= PORT_LINK_MODE_8_LANES;
-        lwsc |= PORT_LOGIC_LINK_WIDTH_8_LANES;
          break;
      default:
          dev_err(pci->dev, "num-lanes %u: invalid value\n", num_lanes);
-- 
2.34.1



