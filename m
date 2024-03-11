Return-Path: <linux-pci+bounces-4725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 797B0878161
	for <lists+linux-pci@lfdr.de>; Mon, 11 Mar 2024 15:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08A0A1F2430A
	for <lists+linux-pci@lfdr.de>; Mon, 11 Mar 2024 14:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63813FB93;
	Mon, 11 Mar 2024 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R4CJoUl9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB0A40BF5;
	Mon, 11 Mar 2024 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710166329; cv=none; b=KkYDJSOu9Not3sHypF6dgGVO+GiVYW8B8bwDfoyFwDITZam8TO4PfHqtSL08oewZvCiMs/RD26mjZPxQ+cUOX6wqx+mCGzDdvq2mA8qP0w5JnWRdqgNXxMRocvHF+hWBndgR8aK5edUkk6wLiV2U5agRY26LLbJFY1J3CcJG9lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710166329; c=relaxed/simple;
	bh=p17h7cnshXjqOHplB90Y1LjRUCbP/fgVQt4Tof1OndI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=n57R3zCEbVDrVoUKPyLzBV8ZubEgdH4qm44T+Fl7BjW/faTmJ2ZU8RgHAnQO1+cZh3pgzVurpN9tN1Tidoik25hi/HanNdz4S5bWgJ37BFlIGUnltKk/ZCkrTVPbQPdtt0MQewY4zFNauCMXBtoaslD2vjVUlnFoipl3fXEmpjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R4CJoUl9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B7dXRU028694;
	Mon, 11 Mar 2024 14:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=yvMGZSaaQ1s4
	15vCsd80iY/qNbhmhoBdJ9MIzP3HoOQ=; b=R4CJoUl9k6CrWf8UsRTQ5hcXBrZw
	unUPfdaoE8xVq4v1ncJDnYLJTKVMoFdC4YtWtJ40P3OhS0aw15PqjEwSfAilTGip
	nfilPubsU3AVIOVQQOEHewEuAcitKwzT+AFWX0rLD+tWP23BnlfmExqJgVC00y5M
	hP6cyF6+i5gdGfvgXK4Bl2OaEPaJGtERAEHCpUrA8/HBYvqMYQ1hUqCpF3RYkCfH
	31Nu/HrKdqVrsYM9AFzc86vTQ8CNW8zMFPeRQBWOGlimgPEE3o2W/NX4Y3eLMWuv
	gDN7VjsYMAvTq451fTX3PJYRnZpv7due9pX+KYbaScOSeOgpQTmQEjfTMg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wswrss283-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 14:12:02 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 42BEBgrr009634;
	Mon, 11 Mar 2024 14:11:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3wrguks1vn-1;
	Mon, 11 Mar 2024 14:11:42 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42BEBgSA009623;
	Mon, 11 Mar 2024 14:11:42 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 42BEBg04009622;
	Mon, 11 Mar 2024 14:11:42 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 190B73A4E; Mon, 11 Mar 2024 19:41:41 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org,
        manivannan.sadhasivam@linaro.org, robh@kernel.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_schintav@quicinc.com, Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v7 0/3] arm64: qcom: sa8775p: add cache coherency support for SA8775P
Date: Mon, 11 Mar 2024 19:41:34 +0530
Message-Id: <1710166298-27144-1-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Oao1XsS82IRibvd8GLZ6imECiztuH_aG
X-Proofpoint-ORIG-GUID: Oao1XsS82IRibvd8GLZ6imECiztuH_aG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403110107
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Due to some hardware changes, SA8775P has set the NO_SNOOP attribute
in its TLP for all the PCIe controllers. NO_SNOOP attribute when set,
the requester is indicating that no cache coherency issues exist for
the addressed memory on the host i.e., memory is not cached. But in
reality, requester cannot assume this unless there is a complete
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
https://lore.kernel.org/all/20240306-dw-hdma-v4-4-9fed506e95be@linaro.org/ [1]

V6 -> V7:
- removed redundant comment in both patches 1 & 2
- added Reviewed-by and Acked-by tag

V5 -> V6:
- updated commit message as per comments
- added Kdoc comments in patch1
- change variable name from enable_cache_snoop to
  override_no_snoop
- sort reg offset define in patch2

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
  PCI: qcom: Override NO_SNOOP attribute for SA8775P RC
  PCI: qcom-ep: Override NO_SNOOP attribute for SA8775P EP
  arm64: dts: qcom: sa8775p: Mark PCIe EP controller as cache coherent

 arch/arm64/boot/dts/qcom/sa8775p.dtsi     |  1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 19 ++++++++++++++++---
 drivers/pci/controller/dwc/pcie-qcom.c    | 24 +++++++++++++++++++++++-
 3 files changed, 40 insertions(+), 4 deletions(-)

-- 
2.7.4


