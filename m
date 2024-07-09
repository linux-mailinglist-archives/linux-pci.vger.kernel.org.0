Return-Path: <linux-pci+bounces-9981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E6892B04B
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 08:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D271F23FCC
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 06:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E312BD05;
	Tue,  9 Jul 2024 06:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ol/phP0x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376F213B7AF;
	Tue,  9 Jul 2024 06:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720507006; cv=none; b=R3FU44nJtce04USl6A9OIA8uvDcscQ8qGxE2lID4jdrcxK8YZ/ZXEFL6h5ezSfi/0T41h7JyrM4FbGyPQEQ3AkQwRxawh7UKNFJJyfTMl00sfm6xHd2U8CRZbFDF0OJHgN3Fwiwja2dvAmwq3NJZF4h/JfrhHDAjhw8TiffMgyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720507006; c=relaxed/simple;
	bh=RpAXK7DqvVegnwp8Vh3nGtV1F/CCyp0yIh0wn9fYZS4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LONzBzIun1pebEd5kdoecxYIZvGqUrT+ui1uxQ0zUSFksV7lwUBytP4rHLELwtZaJBk+2g3Z+BelyeG/wKDpFP5M66XJwb4FZtUytxJuw2xfCudj6+OzOLNVqRTTsTVurKO2vaa10ozDCHNgfj1+iVb1ltIj202XyNL5VYXm/K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ol/phP0x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4690WDSt031488;
	Tue, 9 Jul 2024 06:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=mu0GfX41Pj6F8M+OZgbvFj
	ssGrwjbceCh1fDVyP0xic=; b=Ol/phP0xgPjMUhrQ1fgkZTTgJKDzRO6AYEMV9f
	PJTZaj/wp0+bv+Z/iX76wbyBUAnYjr7B5h7aNEktfkLlOm6D9H1IvXiHT5vtgHTn
	38mCkbMc67yf0Qr9OoBi44VH/ijiDj9KKkWd7QJx0IDIVMx1ZWe2nd3emev6ltgE
	+HDsush7P1yAP1QFmyAk1+h1L7IyUytVG35/eooDo/0mXP8pPJ6UeiO0ztRMRA0f
	1ogLUHEjv1no7IvDmL1yS5NfqNkxQ6qZCwS6ORJq8BlwrmR+flbLdJjKZI+Cv7dT
	qsg+nsod/D2R6qENgTMF9QWrFvJ3Tq9fccWtpCPbGd1Eq3sA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wgwnhk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 06:36:36 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4696aZsP020080
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 06:36:35 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 8 Jul 2024 23:36:32 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <manivannan.sadhasivam@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <quic_krichai@quicinc.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v1] pci: qcom: Fix 'opp' variable usage
Date: Tue, 9 Jul 2024 12:06:20 +0530
Message-ID: <20240709063620.4125951-1-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: shdqdnuhQ0HTffvqTa2nbHrdiTVArVOU
X-Proofpoint-ORIG-GUID: shdqdnuhQ0HTffvqTa2nbHrdiTVArVOU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=866 mlxscore=0
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090043

qcom_pcie_icc_opp_update() calls 'dev_pm_opp_put(opp)' regardless
of the success of dev_pm_opp_find_freq_exact().

If dev_pm_opp_find_freq_exact() had failed and 'opp' had some
error value, the subsequent dev_pm_opp_put(opp) results in a
crash. Hence call dev_pm_opp_put(opp) only if 'opp' has a valid
value.

Fixes: 78b5f6f8855e ("PCI: qcom: Add OPP support to scale performance")
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 26405fcfa499..2a80d4499c25 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1443,8 +1443,8 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 			if (ret)
 				dev_err(pci->dev, "Failed to set OPP for freq (%lu): %d\n",
 					freq_kbps * width, ret);
+			dev_pm_opp_put(opp);
 		}
-		dev_pm_opp_put(opp);
 	}
 }
 
-- 
2.34.1


