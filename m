Return-Path: <linux-pci+bounces-18372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5AA9F0DE0
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 14:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3780F16AA8A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 13:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D0A1E284B;
	Fri, 13 Dec 2024 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l9F57L+u"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E505C1E0E11;
	Fri, 13 Dec 2024 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097864; cv=none; b=KcbxW/6xMMfFd3FgIaE1dArsLhZdJyyDaYg1E625GYyq/RcA0PWRUHWxOoU6c6RP8XrPxLlFwdVuD2kbBTTMGUiO7eDteVltu8MSAdJkvubTF7P5rO8IfAHXP4shL7zjYSOf7TRLUQn/jCmAojhL8X5NFfDIT0fx4/J/XpIU55Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097864; c=relaxed/simple;
	bh=+pt97p/V0tj8vTmjacL+OERmsbqFH/R1gdECrEcJbpE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BzXxDW3m+1q/lujgPXx7CQhnHdGa93pSKLHFeFPmlRUnm5DyXOGAsGi3SMwIFHL+LPD4zOqSt8xny5a5cVXrs6sS1jk2ECJ+IiT2qlMHaxQLmSd8CH0cW1yy8caqX2qGagd9GdqomRD15S87TrPS2/SgPWXjIMHHMO0oo+u27n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l9F57L+u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD81XTY022106;
	Fri, 13 Dec 2024 13:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jOC9nOhDr9jq4AtuIBHj+8
	zR/D+ZeUbHj/hHK/7AGvU=; b=l9F57L+uQz/Dkc6XkGG3delsj1IpuaWxs7r2WQ
	k3MZxB7/MKbf0xL07tdoF2jIesdgMdfm5W95myFxsKLl/605oEuErxPkc8p8PH0L
	C7BvTDSKhqUu7PttbxdK3FkqJ9OJVq/PRmiWc0Gkm41o0kXsdiFOAnu/OwEhBfwd
	SjKdd0GZeepddVkB9GU1FsPSsBXJHKbqR4ij/K4X6XyEd8MEDCr5VbrQhYGx54XT
	X3d6uXNOXr6RipGUxumKtiLnENAnrmb6LIiInMAW8lUC4hS9xl/yUWjwydTFXZrJ
	t9kZjARnkytr2QY9wbhIbwCWjogh18cbkALbrfij/uNhzchA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gh271043-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 13:50:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BDDonZU014540
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 13:50:49 GMT
Received: from hu-mmanikan-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 13 Dec 2024 05:50:44 -0800
From: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <andersson@kernel.org>, <konradybcio@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH 0/4] Add PCIe support for IPQ5424
Date: Fri, 13 Dec 2024 19:19:46 +0530
Message-ID: <20241213134950.234946-1-quic_mmanikan@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nbneuj_EhbWNdlFAkyiJQC1rtLKTGG4P
X-Proofpoint-GUID: nbneuj_EhbWNdlFAkyiJQC1rtLKTGG4P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 mlxlogscore=719 impostorscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130097

This series adds support for enabling the PCIe host devices (PCIe0,
PCIe1, PCIe2, PCIe3) found on IPQ5424 platform. The PCIe0 & PCIe1
are 1-lane Gen3 host and PCIe2 & PCIe3 are 2-lane Gen3 host.

Depends On:
https://lore.kernel.org/linux-arm-msm/20241205064037.1960323-1-quic_mmanikan@quicinc.com/
https://lore.kernel.org/linux-arm-msm/20241213105808.674620-1-quic_varada@quicinc.com/

Manikanta Mylavarapu (4):
  dt-bindings: PCI: qcom: Document the IPQ5424 PCIe controller
  dt-bindings: phy: qcom,ipq8074-qmp-pcie: Document the IPQ5424 QMP PCIe
    PHYs
  arm64: dts: qcom: ipq5424: Add PCIe PHYs and controller nodes
  arm64: dts: qcom: ipq5424: Enable PCIe PHYs and controllers

 .../devicetree/bindings/pci/qcom,pcie.yaml    |   4 +
 .../phy/qcom,ipq8074-qmp-pcie-phy.yaml        |  21 +-
 arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts   |  43 ++
 arch/arm64/boot/dts/qcom/ipq5424.dtsi         | 482 +++++++++++++++++-
 4 files changed, 539 insertions(+), 11 deletions(-)


base-commit: 3e42dc9229c5950e84b1ed705f94ed75ed208228
prerequisite-patch-id: 8ca651806ea679db4420e18aaa9f43aea27a519d
prerequisite-patch-id: 3c4107e3b3a47df73db7ae672b55fa5d995c1f30
prerequisite-patch-id: 56470ae6a75766d02d7db8f04c03a028de0c901a
prerequisite-patch-id: abf79dda8233d882c345774ca693e48dafaeadaa
-- 
2.34.1


