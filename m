Return-Path: <linux-pci+bounces-5742-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDC3898EB2
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 21:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCDD61C24A85
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 19:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D91982C63;
	Thu,  4 Apr 2024 19:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DuqQlJQ9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A5D131E24;
	Thu,  4 Apr 2024 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712257907; cv=none; b=Jb7T/4aWQOHtql466pK1CKoQGaFFNxTg5FdlGudrl1EhLvkjR7VD+vl+g+ej+KsJeWsvikr6AcnBujpnSltL7nIfFSMi6cOdiiMnYnW9Rx9g2QfjJ3uE18KYcizHcJKQwKYloPKvxWj3Ajq9uu/cpGkhw6FZx7xy141Gnc0A1bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712257907; c=relaxed/simple;
	bh=Tca4fO60cbZ1yH1gbmQjkZNUVbk9WcleKEQdrpBl/1k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NvOMZNs6xVSaRfKFBb1qrqE4JLFA3I5De436e2UlPzFrM50UxPp5ZjbOlxhl8gEqjJmq0J6FYV/cVeElrIqyYwSnalB+k+mf/Agi0cbnBKJ/qVtVDXw7CRbVb/k5Qn6/xxUkF+IBw7xkuSn76pc2bvFk23lk/Fc9Wk2Xboi8xM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DuqQlJQ9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 434HeDqR004715;
	Thu, 4 Apr 2024 19:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=VlGHNR9rSJpOhaoG6BkRoTz51woq+R/nyE2bRVD5ZyI=; b=Du
	qQlJQ9nIsfsWZqxD5meD8uq2LBLgmOM8oDnikbzr2ofDJATXr233UKAynf9v2qD7
	0yBreamha6JdtW7fFF6s2AFwY5DSuhm2uOVz9uAV0hB86WHNpfHHxwa3D0L7tm96
	Gvhw7X8WECrx4GH2lZVTHCmoj9bbHReHXqPQgfviMrZ8x2bu9uFYUJ5Qh4sxWDX+
	b/1JOF/QnLorwoymREFipmtLI9nHlTwBNIVNE/ZTxpFaS7A2zXBlMbKNS35YvU93
	ilhDpYQ5+JcbT3bQzxixpdqmU18bAWE3WrK36OqoDGaXAzo+xzEYLeYDNVGfcOgP
	9PT6nSLI2LYrrOhmHJdQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9v8jgx7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 19:11:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 434JBcNt012013
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Apr 2024 19:11:38 GMT
Received: from hu-mrana-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 4 Apr 2024 12:11:37 -0700
From: Mayank Rana <quic_mrana@quicinc.com>
To: <linux-pci@vger.kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <andersson@kernel.org>,
        <manivannan.sadhasivam@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <quic_ramkri@quicinc.com>,
        <quic_nkela@quicinc.com>, <quic_shazhuss@quicinc.com>,
        <quic_msarkar@quicinc.com>, <quic_nitegupt@quicinc.com>,
        Mayank Rana
	<quic_mrana@quicinc.com>
Subject: [RFC PATCH 0/2] Add Qualcomm PCIe ECAM root complex driver
Date: Thu, 4 Apr 2024 12:11:22 -0700
Message-ID: <1712257884-23841-1-git-send-email-quic_mrana@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9S1iCTB7-sAuZdlGJYrrxMkFyMciDxxM
X-Proofpoint-ORIG-GUID: 9S1iCTB7-sAuZdlGJYrrxMkFyMciDxxM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_15,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0
 mlxscore=0 clxscore=1011 mlxlogscore=951 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404040136

On some of Qualcomm platform, firmware takes care of system resources
related to PCIe PHY and controller as well bringing up PCIe link and
having static iATU configuration for PCIe controller to work into
ECAM compliant mode. Hence add Qualcomm PCIe ECAM root complex driver.

Tested:
- Validated NVME functionality with PCIe0 and PCIe1 on SA877p-ride platform

Mayank Rana (2):
  dt-bindings: pcie: Document QCOM PCIE ECAM compatible root complex
  PCI: Add Qualcomm PCIe ECAM root complex driver

 .../devicetree/bindings/pci/qcom,pcie-ecam.yaml    |  94 ++++
 drivers/pci/controller/Kconfig                     |  12 +
 drivers/pci/controller/Makefile                    |   1 +
 drivers/pci/controller/pcie-qcom-ecam.c            | 575 +++++++++++++++++++++
 4 files changed, 682 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-ecam.yaml
 create mode 100644 drivers/pci/controller/pcie-qcom-ecam.c

-- 
2.7.4


