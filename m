Return-Path: <linux-pci+bounces-12872-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA1096E928
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 07:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49B01C22BA9
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 05:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C7F46447;
	Fri,  6 Sep 2024 05:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QYvLec4T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830B7182C3;
	Fri,  6 Sep 2024 05:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725600167; cv=none; b=APZu3Yfg2gyAJK6e8GB2ry4B2fARCfWHW6NgfCujgDEvyac4JUiYmOvBmg6PnVjWS46voNA3LoS2yq9at0nOo7YzdnOGs5IiVDbQ6cDhP9TbHOM+NTiYfRvrEToZEtJ3Iu4daO7jadX8vr+9zUazeJuBaLwZU1N0PC6pFNTyeNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725600167; c=relaxed/simple;
	bh=LVuUlMwyzvzWLDZDd7wwdvmaa0aPjj9BgTayKKGoFnU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B+7L+0OJEZ0Fk0awhk4M+Erhis+6kHpTn6iXQSkvIk3QO8+Gqw+dgld6wHMPo2MuUQSNabg4OMCKpbDPQNgHLr81prDfW3sS4zDoKoMw9wkrWLaD4ENxp84cCdYQXANjD56WXOz4p5twX9HoVva3dgq3+j+WePkYa1mI9n6mxYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QYvLec4T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485IPx2m032622;
	Fri, 6 Sep 2024 05:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Ab+IaklRQePKOAY4pSdCb9I2/tfAKXmYqAR
	pfe8Goh0=; b=QYvLec4Ty3+v7HPZrIrA7Gmrav2UpccwVdbGgJWR5c+DXS02bfL
	WilsmyyYHuxt9pIhnjtMyM9+ehjgYQZvrOSz7oNCHgCwa1LHt8DUu12DXWhJyIqj
	i5igc6w4GUlryz9wmrvete1U+ky44KVqYSBEWDyV5imb3Pz4u98F12G6XNcuJJ1T
	jOOY2OZlfpJqODSeOrVJonjdQqoOI0EajzQVAbKaKPR3tXVvMW4um5vX9csq30Bn
	xTPe32kg4CzxKryxK9uf7hlPSGiltVh3FoqNdIBY8dYszkSICX/ZfZd3vnm5h6GS
	6hd+NcZQS1m8+q2lo7M6cUNSHOTXXiqF/LQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fhwt95qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 05:22:42 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 4865MdhX018665;
	Fri, 6 Sep 2024 05:22:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 41bv8mt7f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 05:22:39 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4865MdQ2018660;
	Fri, 6 Sep 2024 05:22:39 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-skananth-hyd.qualcomm.com [10.213.96.172])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4865McAp018658
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 05:22:39 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 432606)
	id DB15F3B2; Fri,  6 Sep 2024 10:52:37 +0530 (+0530)
From: Subramanian Ananthanarayanan <quic_skananth@quicinc.com>
To: bhelgaas@google.com
Cc: quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        linux-arm-msm@vger.kernel.org,
        Subramanian Ananthanarayanan <quic_skananth@quicinc.com>,
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1] PCI: Add ACS quirk for Qualcomm SA8775P
Date: Fri,  6 Sep 2024 10:52:27 +0530
Message-Id: <20240906052228.1829485-1-quic_skananth@quicinc.com>
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
X-Proofpoint-GUID: ZFWS0tuLyzXi8cldvXRv5M_6-sLtxs1w
X-Proofpoint-ORIG-GUID: ZFWS0tuLyzXi8cldvXRv5M_6-sLtxs1w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1011 priorityscore=1501 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=868
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409060037

The Qualcomm SA8775P root ports don't advertise an ACS capability, but they
do provide ACS-like features to disable peer transactions and validate bus
numbers in requests.

Add an ACS quirk for the SA8775P.

Signed-off-by: Subramanian Ananthanarayanan <quic_skananth@quicinc.com>
---
 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 507006ff13dd..bc739f04d4b1 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5087,6 +5087,8 @@ static const struct pci_dev_acs_enabled {
 	/* QCOM QDF2xxx root ports */
 	{ PCI_VENDOR_ID_QCOM, 0x0400, pci_quirk_qcom_rp_acs },
 	{ PCI_VENDOR_ID_QCOM, 0x0401, pci_quirk_qcom_rp_acs },
+	/* QCOM SA8775P root port */
+	{ PCI_VENDOR_ID_QCOM, 0x0115, pci_quirk_qcom_rp_acs },
 	/* HXT SD4800 root ports. The ACS design is same as QCOM QDF2xxx */
 	{ PCI_VENDOR_ID_HXT, 0x0401, pci_quirk_qcom_rp_acs },
 	/* Intel PCH root ports */
-- 
2.34.1


