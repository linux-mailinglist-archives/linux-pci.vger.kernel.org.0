Return-Path: <linux-pci+bounces-17724-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D639E4DCB
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 07:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF282817ED
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 06:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D9A1990A2;
	Thu,  5 Dec 2024 06:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TOgbeKN9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FD717C208;
	Thu,  5 Dec 2024 06:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733381687; cv=none; b=D6o/GoYlwiXnLNtvSOaIBw4kpPCWjeIXj7ydC4tWmLlVr2DCkAYPtsWyQBEkUgw28iuM/0VquMsBgXwc+t/jr/C3mTWgBGj2ymMEuFTEf6qccdwfZrIA6Tyfc3cIZi7qsKqUrg6Yu9a6hQNsTGb5r/kMjQzqtxZSA/Fe283N430=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733381687; c=relaxed/simple;
	bh=nCrwlCRlUmSmRryR/1WprnfMf/sEwmbB3xEj670GLZM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BO2Pq/1CMaFloK/3gvREwgxXFevNg8P3aET5vT7aVa1FpXv/I64ZecQ2eTQRudfZhzZL+vdabqn9WD1Sv+ExJz/c4dIPzjFTn6Msitwbhxg8FqUGPrFNZAYzb3/PNV1baJvg0W+Ea1IRzy4MQOdPkYWw2tavuTogAv4cJzL90eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TOgbeKN9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4N29cl026498;
	Thu, 5 Dec 2024 06:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=N2hHxwoRVaT7PhGq5S08LXhb/7vcgs2aTzV
	Q0VkESyQ=; b=TOgbeKN9tsaJSZKs1bjzkZK2zsS0I10T7Ey7oaui4VmEMY8sPPa
	U1nBLJl1Kku1PD7K1t/dSSQ8rRyDy+bQBeG9h2MKTjQ7LOLIilYfWitZis6l2h72
	oC67Cl+hps4a0EiJAS+aurSUmJZey/2iffM6JuiMTr8b0eFjhWr07+hjLduCkMzc
	eYWZwZICNGdGC6FPRIddmPsn3Rr50bDw5YUqUGnG2SAREpC1O2cFwRe22ORjbn52
	m1+8FcJl0ZMKu8wVfO/BYomXgbP1M6By4ITcpjLMGi1UfQg/hTNZcUJOFc8ZER8i
	PHe/LHCZ4am0wkjOgCDoBAcJAXDd6/F8W0A==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439yr9p30j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 06:54:29 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B56sQdO022751;
	Thu, 5 Dec 2024 06:54:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 437usmedrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 06:54:26 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4B56sQYj022746;
	Thu, 5 Dec 2024 06:54:26 GMT
Received: from hu-devc-hyd-u20-c-new.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.249])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4B56sQJd022745
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 06:54:26 +0000
Received: by hu-devc-hyd-u20-c-new.qualcomm.com (Postfix, from userid 3891782)
	id 08FC1213F4; Thu,  5 Dec 2024 12:24:25 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: manivannan.sadhasivam@linaro.org
Cc: quic_shazhuss@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Slark Xiao <slark_xiao@163.com>,
        Qiang Yu <quic_qianyu@quicinc.com>, Mank Wang <mank.wang@netprisma.us>,
        Johan Hovold <johan+linaro@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Fabio Porcedda <fabio.porcedda@gmail.com>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v1 0/2] pci_generic: Add supoprt for SA8775P target
Date: Thu,  5 Dec 2024 12:24:18 +0530
Message-Id: <20241205065422.2515086-1-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-ORIG-GUID: pxNehPPz4R8txES-ho1ZbUhV3VY55kPE
X-Proofpoint-GUID: pxNehPPz4R8txES-ho1ZbUhV3VY55kPE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 clxscore=1011 priorityscore=1501 mlxlogscore=553 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050051

This patch series add separate MHI host configuration to enable
only IP_SW channel for SA8775P target.

And also update the proper device id for SA8775P endpoint.

Mrinmay Sarkar (2):
  bus: mhi: host: pci_generic: Add supoprt for SA8775P target
  PCI: epf-mhi: Update device id for SA8775P

 drivers/bus/mhi/host/pci_generic.c           | 34 ++++++++++++++++++++
 drivers/pci/endpoint/functions/pci-epf-mhi.c |  2 +-
 2 files changed, 35 insertions(+), 1 deletion(-)

-- 
2.25.1


