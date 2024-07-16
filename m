Return-Path: <linux-pci+bounces-10360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AAF9322AE
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 11:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F331F22015
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 09:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A677F196450;
	Tue, 16 Jul 2024 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S/823h3C"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9C85336D;
	Tue, 16 Jul 2024 09:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721121872; cv=none; b=eIJdG4z/9735xzrXkI57WALjLA9gewEu/FN1zeVhswNo240dWj8NM/5ZiHENaTMLq5VwfwZ9WEVl3nsklPiqIDV2Ra8qA3Q+OFMkmP+J6fnlrBbZo0JtVVsMKupwvqwtL6nAZIA9iwExi8TNgzGJt4rEfVxZB5zV57dkBCRfs2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721121872; c=relaxed/simple;
	bh=wef1JGvu74X+bpbvmhBlEm1H4dua05vnL616hcCyRx8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tcqe9qkgLjCqs4NVJtVqivXzE2NPkHBdTjvaEVBBlPdCTmabO2R1Fn3er1FTp+WRNW0QG0ofyML1cUbjDRHJazSZA0+KvWGy+RERJTHM0jkQ4C5XpVbSLo2DORFwY9e1cHP4f80V3EpN+8Bs9r6B5rFu+XTJXF8DWeLQOokMkPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S/823h3C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46G4WH8b006904;
	Tue, 16 Jul 2024 09:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ThkklmF4aIqUAmdDZMJ0A8
	NmJEzY9YvplURwhC+RDPE=; b=S/823h3CeelyqssKZN3aicAOhqQpg5UQNciCyw
	omHPudViL2UbPJd9YaHW2exd4TNjRrKx7EIezcYlCghsbWDIqHTshP/wJEnXQPdt
	43bRxD1tLSg5bl/Yl8OC1yd2kj1kArFIzbT4rorcTy16Ho22FqiXOHE0M/x72RiU
	WhzNHCmtdKvtwgCDIajjQvj7SN+cxkBIpF7bw8qVe5qbuwFeVBYlvCc990VSEVEB
	mlEFtAewOAqtMBnpzpLERCpR5QtWbyjHqlBiZ+sZEvA4H24P0ddyT1OdKguFmYYq
	mTZmojjCbxQhP0i0YH5BkjCxedbD/KpknAXqjXy5bLu5kBvA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bjv8pfx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 09:24:24 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46G9ON33020177
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 09:24:23 GMT
Received: from hu-srichara-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 16 Jul 2024 02:24:18 -0700
From: Sricharan R <quic_srichara@quicinc.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>
Subject: [PATCH V6 0/4] Add PCIe support for IPQ9574
Date: Tue, 16 Jul 2024 14:53:43 +0530
Message-ID: <20240716092347.2177153-1-quic_srichara@quicinc.com>
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
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: crxM83Td0YbXE-lvOGUsIb8eLX_KdvDw
X-Proofpoint-GUID: crxM83Td0YbXE-lvOGUsIb8eLX_KdvDw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1011 priorityscore=1501
 phishscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407160067

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

This series adds support for enabling the PCIe host devices (PCIe0, PCIe1,
PCIe2, PCIe3) found on IPQ9574 platform. The PCIe0 & PCIe1 are 1-lane Gen3
host and PCIe2 & PCIe3 are 2-lane Gen3 host.

[V6]
        - Dropped patches [1] and [2] for clks, since its already merged.
        - Addressed all comments from Krzysztof, Manivannan, Bjorn Helgaas.
          Specifically dropped defining a new macro for SLV_ADDR_SPACE_SZ.
          Letting it at reset value is fine.

          Both dt_binding_check and dtbs_check passed and tested on ipq9574-rdp433

	[1] - https://patchwork.kernel.org/project/linux-pci/patch/20240512082858.1806694-2-quic_devipriy@quicinc.com/
	[2] - https://patchwork.kernel.org/project/linux-pci/patch/20240512082858.1806694-3-quic_devipriy@quicinc.com/

[V5]
	Change logs are added to the respective patches
	This series depends on the below series which adds support for
	Interconnect driver[1] and fetching clocks from the Device Tree[2]
	[1] - https://lore.kernel.org/linux-arm-msm/20240430064214.2030013-1-quic_varada@quicinc.com/
	[2] - https://lore.kernel.org/linux-pci/20240417-pci-qcom-clk-bulk-v1-1-52ca19b3d6b2@linaro.org/
[V4]
https://lore.kernel.org/linux-arm-msm/20230528142111.GC2814@thinkpad/

[V3]
https://lore.kernel.org/linux-arm-msm/20230421124938.21974-1-quic_devipriy@quicinc.com/
	- Dropped the phy driver and binding patches as they have been
	  posted as a separate series.
	- Dropped the pinctrl binding fix patch as it is unrelated to the series
	  dt-bindings: pinctrl: qcom: Add few missing functions.
	- Rebased on linux-next/master.
	- Detailed change logs are added to the respective patches.

[V2]
https://lore.kernel.org/linux-arm-msm/20230404164828.8031-1-quic_devipriy@quicinc.com/
	- Reordered the patches and split the board DT changes
	  into a separate patch as suggested
	- Detailed change logs are added to the respective patches
[V1]
https://lore.kernel.org/linux-arm-msm/20230214164135.17039-1-quic_devipriy@quicinc.com/

devi priya (4):
  dt-bindings: PCI: qcom: Document the IPQ9574 PCIe controller.
  arm64: dts: qcom: ipq9574: Add PCIe PHYs and controller nodes
  arm64: dts: qcom: ipq9574: Enable PCIe PHYs and controllers
  PCI: qcom: Add support for IPQ9574

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  50 +++
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts   | 113 +++++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 425 +++++++++++++++++-
 drivers/pci/controller/dwc/pcie-qcom.c        |  31 +-
 4 files changed, 611 insertions(+), 8 deletions(-)

--
2.34.1


