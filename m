Return-Path: <linux-pci+bounces-3823-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A1785DD66
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 15:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F364E1F21C08
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 14:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B467D413;
	Wed, 21 Feb 2024 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fiUyo0CB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EF17C09A;
	Wed, 21 Feb 2024 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524275; cv=none; b=Say+d2Gw5tK+s/BOdjJUYYwaunlSrAgumcsOP9N2EJsAv+AEyclmJiESSYBxtDNF4N/kyO8nOvsfQ1AmUq5B1VM9Of6Q1x9niel842dcObVcRVzOzvBnBQOql0TOp/OaLoKheO/toN+H4qSwW8L5Gc3FWrSxrfGT/Sc7gg+2f3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524275; c=relaxed/simple;
	bh=BKrPxKcNueFBfyqfTI+yCXKdSZ6PsLI13qpU7crpEYA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gOMA6qcvPNSTOepzWADAMvolEnovh4vLwQiNlQz/h3m+gKXlrzNqc5lgh6zyk67rbUEK3kauG9P5mqDpZ+aRn7XIv0JQsykRuhQM/djNIvbImPHdyMKXlZCV8bUoXuJBRytpmUI4IRZY27XImOSsFYpHjTsCjHCBMjfe6ouHuRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hu-msarkar-hyd.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fiUyo0CB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hu-msarkar-hyd.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LDxSpe002944;
	Wed, 21 Feb 2024 14:04:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=D/XNoT3LVPg+OC19k7J9
	BFPd0mH4TA8Vu07Ukic7bnY=; b=fiUyo0CBEkUM8JKD4Qi8H67a11fejD7I6E2o
	O16MmHx29ezTcis0LaWzEqXVE2d00+ry3MUgW1hy6YJp4WwfXCtv45aOD7Sa7uCD
	2Du3zdBNpxaneHlcZtnDqNzko7OKfB+V/7eMD94Z+hzL0JbDA1GjUnb/3EkfurA/
	hE+wUo5lPFcuahsgsQ68cKa/t/mqzekjW9lzp1mwGcHj1mi1aHcJxXjbHEo4y49b
	jqqCxs7Usz4Z+W31YjxG3Yt317S5PxkKsO62JGZVSmnLDclyrLEVj9C9Gzvp9IKV
	shtFJFTH9EkaH0gzQssnfblb6YAUnW7ibZHaqNeM6Ns8D7FpOA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdcrs0u77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 14:04:15 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 41LE4AUb013235;
	Wed, 21 Feb 2024 14:04:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3wanvkycen-1;
	Wed, 21 Feb 2024 14:04:10 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41LE4Aar013227;
	Wed, 21 Feb 2024 14:04:10 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 41LE4AKF013215;
	Wed, 21 Feb 2024 14:04:10 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 0)
	id 7965C39B8; Wed, 21 Feb 2024 19:34:09 +0530 (+0530)
From: root <root@hu-msarkar-hyd.qualcomm.com>
To: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        konrad.dybcio@linaro.org, manivannan.sadhasivam@linaro.org,
        conor+dt@kernel.org, quic_nitegupt@quicinc.com
Cc: quic_shazhuss@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] Add support for detecting Controller Level PCIe Errors
Date: Wed, 21 Feb 2024 19:34:01 +0530
Message-Id: <20240221140405.28532-1-root@hu-msarkar-hyd.qualcomm.com>
X-Mailer: git-send-email 2.40.1
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
X-Proofpoint-ORIG-GUID: dAK7buY6I60OWndzdRr5nyyKJdwWyjCk
X-Proofpoint-GUID: dAK7buY6I60OWndzdRr5nyyKJdwWyjCk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=851 bulkscore=0 clxscore=1034
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210109

From: Mrinmay Sarkar <quic_msarkar@quicinc.com>

Synopsys Controllers provide capabilities to detect various controller
level errors. These can range from controller interface error to random
PCIe configuration errors. This patch intends to add support to detect
these errors and report it to userspace entity via sysfs, which can take
appropriate actions to mitigate the errors.

Also adding global irq support for PCIe RC and add corresponding change
in PCIe dt-bindings.

Mrinmay Sarkar (2):
  dt-bindings: PCI: qcom: Add global irq support for SA8775p
  arm64: dts: qcom: sa8775p: Enable global irq support for SA8775p

Nitesh Gupta (1):
  PCI: qcom: Add support for detecting Controller Level PCIe Errors

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  26 +-
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         |  12 +-
 drivers/pci/controller/dwc/pcie-designware.h  |  26 ++
 drivers/pci/controller/dwc/pcie-qcom.c        | 350 ++++++++++++++++++
 4 files changed, 408 insertions(+), 6 deletions(-)

-- 
2.40.1


