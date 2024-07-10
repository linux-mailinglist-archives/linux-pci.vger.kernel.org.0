Return-Path: <linux-pci+bounces-10060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E184692D022
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 13:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B811C21CB8
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 11:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F75D18FC7B;
	Wed, 10 Jul 2024 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Cok2fXTK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1138518FA34;
	Wed, 10 Jul 2024 11:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720609718; cv=none; b=AuaOVEySdfr/Y9I2/PSRIYz+vw6bp+/8RbrJFV5EswPVjJRDMibYRsVF0v907YbQ56aY5xTe15crorJ8oR5d977h0VqMYHQucyBSO1hZJ/KCK6mcieMLC06U9Q7lw8IW+cBrSeV6UvVlMSb6Jfj37EMcsAlUmy4JRgUX8i9ujw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720609718; c=relaxed/simple;
	bh=lnEmNUrZVKMUb3Zni61Oi8AYwUR/5XFHpGCQCXIYX4o=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=IzaqOW4OHjjKhSFifJZ07ywamdiz0guMIX0yrx7LOCTscE/Ihrfpm2ldvQI7U7JtRaZI+a+rBhdY5faec3r4ZoPgrsFKk19vIXOVdyety8YCfzR6yjh0e23Oj/XEkbjHJLWLh7nni66FBGTbdrDDOQ8T9cDO+nQn/5qsRBHeGoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Cok2fXTK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A29WU9005080;
	Wed, 10 Jul 2024 11:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rY7ukcT6x6DTecR1+lqSVc
	JxN2MKM+D2xH/UXR4S8Bs=; b=Cok2fXTKPYFGaxIPpOJNjtRhZKsj4wAekRb2t6
	c4ArLVOI3wqz9eY/mt/iuUZQkImYJOlzyeN8K9+P8iVQ8OQox2Af6d6HekAF6FIG
	CC5RmGxLAYI0jDCLz+stUM/HyRwWkdY8pUsMom28QM4qNml0/TC1bjrHMGwLf6ti
	fXilw47oLiZlvRvEKPcrCfAytXt2bu/Fmx+sMTBPtp5TwehJQHl+XinKtYUw9Jdp
	QbYaoVCgA30gColzWWhB702IHajIJicU5VKjvina3dBb91hB0wTp9lGQCgNzzMat
	q1H7m7sjRuqra98ggFKGz2UkYlYD8vq3mImup9udi7zrHtaw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 408w0rbye2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 11:08:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46AB8ONx004543
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 11:08:24 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 10 Jul 2024 04:08:19 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v7 0/4] PCI: endpoint: add D-state change notifier support
Date: Wed, 10 Jul 2024 16:38:13 +0530
Message-ID: <20240710-dstate_notifier-v7-0-8d45d87b2b24@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ1rjmYC/x3MQQqAIBBG4avErBNsEISuEhGlvzUbDZUIorsnL
 b/Few8VZEGhsXso45IiKTbYviN3rHGHEt9MrNloO2jlS10rlpiqBEFW7DgY8GYAT606M4Lc/3G
 a3/cDNMpxYWEAAAA=
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I
	<kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet
	<corbet@lwn.net>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring
	<robh@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <mhi@lists.linux.dev>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_parass@quicinc.com>,
        "Krishna chaitanya
 chundru" <quic_krichai@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720609699; l=1933;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=lnEmNUrZVKMUb3Zni61Oi8AYwUR/5XFHpGCQCXIYX4o=;
 b=V065DTfjdyMA4QSQ0X0j1l94+d0jzwUjy/7IKIBy29ub3y/bs2bpPfCtzKzpv3awNyFJkbVjA
 BKDxS+7Np/hCXQQ+FeDB/lSi+sZPnZRahMZLlRIQQBOnm+mOgHFCycC
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kdssdNB2yapj9PoiaPUzUaTDDZvVTU6v
X-Proofpoint-GUID: kdssdNB2yapj9PoiaPUzUaTDDZvVTU6v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_06,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=837
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407100076

In this series we added the support to nofity the EPF driver
whenever there is change in the D-state if the EPF driver
registered for it.

This series needed by the following series for epf driver to know
whether link is in D3Cold or D3hot to wake the host because EPF driver
needs to send PME when the link is D3hot and toggle wake when the link
is in D3Cold('PCI: EPC: Add support to wake up host from D3 states').

The following link is for older series a newer series will be sent after
rebasing on this series.
https://lore.kernel.org/linux-pci/1690952359-8625-4-git-send-email-quic_krichai@quicinc.com/T/

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
Changes from v6:
	- Rebased on linux next.
	- Link to v6: https://lore.kernel.org/all/20230908-dstate_change-v6-0-b414a6edd765@quicinc.com/T/
Changes from v5:
	- Fixed compilation errors & removed checks in the dstate_notify()
	  function as suggested by bjorn.

---
Krishna chaitanya chundru (4):
      PCI: endpoint: Add D-state change notifier support
      PCI: qcom-ep: Add support for D-state change notification
      PCI: qcom-ep: Print D-state name to distinguish D3hot/D3cold
      PCI: epf-mhi: Add support for handling D-state notify from EPC

 Documentation/PCI/endpoint/pci-endpoint.rst  |  3 +++
 drivers/pci/controller/dwc/pcie-qcom-ep.c    | 10 ++++++++--
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 11 +++++++++++
 drivers/pci/endpoint/pci-epc-core.c          | 24 ++++++++++++++++++++++++
 include/linux/mhi_ep.h                       |  3 +++
 include/linux/pci-epc.h                      |  2 ++
 include/linux/pci-epf.h                      |  2 ++
 7 files changed, 53 insertions(+), 2 deletions(-)
---
base-commit: 82d01fe6ee52086035b201cfa1410a3b04384257
change-id: 20240710-dstate_notifier-2c2f4e2b4eed

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>


