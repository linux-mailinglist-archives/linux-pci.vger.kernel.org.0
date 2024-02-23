Return-Path: <linux-pci+bounces-3915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230D286137E
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 15:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504311C219D7
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 14:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7CF7FBCA;
	Fri, 23 Feb 2024 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aF7w5mQZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3053B7E798;
	Fri, 23 Feb 2024 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697047; cv=none; b=SFYVq91ZRRYQzi9kV10elso7VcOnilkkzsW8jmG1ZWzebH7hgSbYj+BWITt8mrT/GYXcR6cip9ewM2506I4SHA65ClDos+bdZ8TvAp6T+hTA1fk6DLj3gcPkCbUqh/fjTBkCIqe9RBsIFEFsxweWF/su5iv88YNjhLyPZbLd+DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697047; c=relaxed/simple;
	bh=nM40QHzYL1kwG2zb35krcUIqERe+VLJRE/J43CVPmVw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=t0+/I33O8iC1vEMl4u0DB4XkK9oNlxcwrqmF4V3ijEO3xNdZB9I1BHcM51MxGy3S3zN8qOpc6A3wft4bpzZT99gBgcBdH7fmKGzsuAre8x1TXJ1D0Z6iHEi9BkZrWtul5lc9iR8hPuUVf8ZNcvoQylXALk+gQBOL57uooo74O/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aF7w5mQZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NDvndw018420;
	Fri, 23 Feb 2024 14:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=1mgJOW5SMwFM
	2S8R8LzsDNYwGCjSr8J/HH+/75aLe24=; b=aF7w5mQZXV05NkBroo2HHMmUTgtD
	mEZJKnZeVB7APNG0SDY3+ecddv2T5JgIQSaS7etgP9sUSIZE1blHDPUU2IvREkxg
	Z1wNFn4Rqvpvl+bKedTIod69gdMlF+4CPqwuyMsGPY4KbHvK8/6dIIKde8Vw2q9A
	wBoeaB6a2c+U23KJfh8MyoGN4yNfRPFr7IX4xwEHxEEW3eZt8nWCB2ug/rTn4z6Q
	vfXqoqPq/cSAx699PKq1eLk2QqDFpmnXwMot+ff3JpUtiVK56TuzeDXaLkX8XpoB
	+6gDzlp6zgNtN1RaWha/6quDUYl/OdVK8dGAB2KyepL0P3uyQpP2TgH+Pw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wesgg0hsg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:03:55 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 41NE2Yr2026559;
	Fri, 23 Feb 2024 14:03:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3wanvme27t-1;
	Fri, 23 Feb 2024 14:03:52 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41NE3qBo027350;
	Fri, 23 Feb 2024 14:03:52 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 41NE3qSF027347;
	Fri, 23 Feb 2024 14:03:52 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 718DA14C5; Fri, 23 Feb 2024 19:33:51 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org,
        manivannan.sadhasivam@linaro.org, robh@kernel.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, quic_schintav@quicinc.com,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v5 0/3] arm64: qcom: sa8775p: add cache coherency support for SA8775P
Date: Fri, 23 Feb 2024 19:33:37 +0530
Message-Id: <1708697021-16877-1-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vpn7AjzS49pQmA8aqIQKDmgZ30uYzrJb
X-Proofpoint-ORIG-GUID: vpn7AjzS49pQmA8aqIQKDmgZ30uYzrJb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402230102
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Due to some hardware changes, SA8775P has set the NO_SNOOP attribute
in its TLP for all the PCIe controllers. NO_SNOOP attribute when set,
the requester is indicating that there no cache coherency issues exit
for the addressed memory on the host i.e., memory is not cached. But
in reality, requester cannot assume this unless there is a complete
control/visibility over the addressed memory on the host.

And worst case, if the memory is cached on the host, it may lead to
memory corruption issues. It should be noted that the caching of memory
on the host is not solely dependent on the NO_SNOOP attribute in TLP.

So to avoid the corruption, this patch overrides the NO_SNOOP attribute
by setting the PCIE_PARF_NO_SNOOP_OVERIDE register. This patch is not
needed for other upstream supported platforms since they do not set
NO_SNOOP attribute by default.

This series is to enable cache snooping logic in both RC and EP driver
and add the "dma-coherent" property in dtsi to support cache coherency
in SA8775P platform.

Dependency
----------

Depends on:
https://lore.kernel.org/all/1701432377-16899-1-git-send-email-quic_msarkar@quicinc.com/
https://lore.kernel.org/all/20240216-dw-hdma-v2-4-b42329003f43@linaro.org/ [1]

V4 -> V5:
- Updated commit message in both Patch1 and patch2
- change variable name from no_snoop_override to
  enable_cache_snoop
- rebased patch2 on top of [1]

v3 -> v4:
- added new cfg(cfg_1_34_0) for SA8775P in both RC and EP driver.
- populated a flag in the data structures instead of doing
  of_device_is_compatible() in both RC and EP patch.
- update commit mesaage and added reveiwed-by tag in commit message
  in dtsi patch.

v2 -> v3:
- update commit message(8755 -> 8775).

v1 -> v2:
- update cover letter with explanation.
- define each of these bits and ORing at usage time rather than
  directly writing value in register.

Mrinmay Sarkar (3):
  PCI: qcom: Enable cache coherency for SA8775P RC
  PCI: qcom-ep: Enable cache coherency for SA8775P EP
  arm64: dts: qcom: sa8775p: Mark PCIe EP controller as cache coherent

 arch/arm64/boot/dts/qcom/sa8775p.dtsi     |  1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 20 +++++++++++++++++---
 drivers/pci/controller/dwc/pcie-qcom.c    | 20 +++++++++++++++++++-
 3 files changed, 37 insertions(+), 4 deletions(-)

-- 
2.40.1


