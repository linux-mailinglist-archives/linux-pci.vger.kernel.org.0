Return-Path: <linux-pci+bounces-26375-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C2AA9660E
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 12:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D153188E4E1
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 10:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88561DDA24;
	Tue, 22 Apr 2025 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Av8NVf9J"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDA91172A;
	Tue, 22 Apr 2025 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745318200; cv=none; b=QtuOxc8U/lEj6lqb4B1zmQVFZdz51U2omxoEzV2hr7stluuuBCZej3/AuSo69FSLCkyTxIyFbNu7CCsix2lb4SpSNggpaNRpdDKJ7x8lWF7tWayqpSPwyiLrbmNI535PH8zvzP9koReAddmPf8A5Zb5LPEzfbY9uQncf0YprStk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745318200; c=relaxed/simple;
	bh=c3N6P9ujSvtfG/aUl3hM320oUh3uU0gg2kmjLd4tDPw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bI3c207RnljbrNaMaMvrABBQgSggUdC7H4z1A9heaGRpw1082TBXe98GEJZEp/kaBBXkBmpuXsx+lRaOY7tJulZBima7j3bc3ZUlsfi5ptvmJXSpctA2dBnGwSVxvrNiVzXOxm/MQ8i6p/0wo29RgSbOCtr7LbQp1Ft3icegGgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Av8NVf9J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M4OoA8031778;
	Tue, 22 Apr 2025 10:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=/RkOP5p07Z33rdDQBQRpfM/n6xuVMvRRhr0
	7IPGnm0I=; b=Av8NVf9JXwwCdQayLvtjG2oHYiJruQWloj9DTx3K5ONX3/8oToc
	Sq5NQEnMH8ZLczPebk6gYQPPKslrjlKTMEtPxRxHa+ObpqHTas0zijl2F6itXjKj
	b+snBhe1coKZyUvKD1mgODnrI+w1BG/tMu8znZPwz9f4Ioy2wCB8gjP16YREJHTf
	yzuIgE3R4sSuhVAfhMAJW3cJYImBMLZSYCQPgUnjk6xnHz6G/3S3ozqnVGbkyN59
	feZPMmQEUz0XCtRryClw7oqZRuJ0E1d99WbzEofa7q8qqj7HoyPL853SZXJ2Sq1D
	NSKluWWHj0jDZ70fWZdMUF5dZZMuq22PeEA==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4641hhq9gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 10:36:31 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 53MAaTO3021836;
	Tue, 22 Apr 2025 10:36:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4644wmrguv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 10:36:29 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53MAaSao021828;
	Tue, 22 Apr 2025 10:36:29 GMT
Received: from cbsp-sh-gv.ap.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 53MAaSq8021827
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 10:36:28 +0000
Received: by cbsp-sh-gv.ap.qualcomm.com (Postfix, from userid 4635958)
	id 60FB040B8B; Tue, 22 Apr 2025 18:36:27 +0800 (CST)
From: Wenbin Yao <quic_wenbyao@quicinc.com>
To: jingoohan1@gmail.com, manivannan.sadhasivam@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: krishna.chundru@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com, quic_cang@quicinc.com, quic_qianyu@quicinc.com,
        quic_wenbyao@quicinc.com
Subject: [PATCH v2] PCI: dwc: Set PORT_LOGIC_LINK_WIDTH to one lane
Date: Tue, 22 Apr 2025 18:36:23 +0800
Message-Id: <20250422103623.462277-1-quic_wenbyao@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=Fe43xI+6 c=1 sm=1 tr=0 ts=6807712f cx=c_pps a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=yNROw-kHB_A5fFGVVUkA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: GBFqV7ZwMheUWEE_jWWpY9tb0_DTMWxy
X-Proofpoint-ORIG-GUID: GBFqV7ZwMheUWEE_jWWpY9tb0_DTMWxy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_05,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220079

As per DWC PCIe registers description 4.30a, section 1.13.43, NUM_OF_LANES
named as PORT_LOGIC_LINK_WIDTH in PCIe DWC driver, is referred to as the
"Predetermined Number of Lanes" in section 4.2.6.2.1 of the PCI Express
Base 3.0 Specification, revision 1.0. This section explains the conditions
need be satisfied for entering Polling.Configuration:

"Next state is Polling.Configuration after at least 1024 TS1 Ordered Sets
were transmitted, and all Lanes that detected a Receiver during Detect
receive eight consecutive training sequences.

Otherwise, after a 24 ms timeout the next state is:
Polling.Configuration if
(i) Any Lane, which detected a Receiver during Detect, received eight
consecutive training sequences and a minimum of 1024 TS1 Ordered Sets are
transmitted after receiving one TS1 or TS2 Ordered Set.
And
(ii) At least a predetermined set of Lanes that detected a Receiver during
Detect have detected an exit from Electrical Idle at least once since
entering Polling.Active.

Note: This may prevent one or more bad Receivers or Transmitters from
holding up a valid Link from being configured, and allow for additional
training in Polling.Configuration. The exact set of predetermined Lanes is
implementation specific.

Note: Any Lane that receives eight consecutive TS1 or TS2 Ordered Sets
should have detected an exit from Electrical Idle at least once since
entering Polling.Active."

In a PCIe link that supports multiple lanes, if PORT_LOGIC_LINK_WIDTH is
set to lane width hardware supports, all lanes that detect a receiver
during the Detect phase must receive eight consecutive training sequences.
Otherwise, the LTSSM cannot enter Polling.Configuration and link training
will fail.

Therefore, always set PORT_LOGIC_LINK_WIDTH to 1, regardless of the number
of lanes the port actually supports, to make linking up more robust. This
setting will not affect the intended link width if all lanes are
functional. Additionally, the link can still be established with at least
one lane if other lanes are faulty.

Co-developed-by: Qiang Yu <quic_qianyu@quicinc.com>
Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
Signed-off-by: Wenbin Yao <quic_wenbyao@quicinc.com>
---
Changes in v2:
- Reword commit message.
- Link to v1: https://lore.kernel.org/all/1524e971-8433-1e2d-b39e-65bad0d6c6ce@quicinc.com/

 drivers/pci/controller/dwc/pcie-designware.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 97d76d3dc..be348b341 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -797,22 +797,19 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
 	/* Set link width speed control register */
 	lwsc = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
 	lwsc &= ~PORT_LOGIC_LINK_WIDTH_MASK;
+	lwsc |= PORT_LOGIC_LINK_WIDTH_1_LANES;
 	switch (num_lanes) {
 	case 1:
 		plc |= PORT_LINK_MODE_1_LANES;
-		lwsc |= PORT_LOGIC_LINK_WIDTH_1_LANES;
 		break;
 	case 2:
 		plc |= PORT_LINK_MODE_2_LANES;
-		lwsc |= PORT_LOGIC_LINK_WIDTH_2_LANES;
 		break;
 	case 4:
 		plc |= PORT_LINK_MODE_4_LANES;
-		lwsc |= PORT_LOGIC_LINK_WIDTH_4_LANES;
 		break;
 	case 8:
 		plc |= PORT_LINK_MODE_8_LANES;
-		lwsc |= PORT_LOGIC_LINK_WIDTH_8_LANES;
 		break;
 	default:
 		dev_err(pci->dev, "num-lanes %u: invalid value\n", num_lanes);
-- 
2.34.1


