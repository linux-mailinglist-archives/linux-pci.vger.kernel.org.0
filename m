Return-Path: <linux-pci+bounces-10000-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A45E392BDC4
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 17:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5049B29C89
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 14:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC5019CD01;
	Tue,  9 Jul 2024 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D3AoGA5t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF38615B57D;
	Tue,  9 Jul 2024 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720536855; cv=none; b=i6+zhKEw3R7bm3jAuRjRKwxXzOsPyy2ZWI7j0VYCqXsbBB1TWQjGayqLeIgv8KI693oJOJ37GU6o7hDX9d/6sD+r9OFccfCpFZHERRsVnN155gFX4i0babUjDLZMMIbme6T1fKAecGMEZFuEegLbijFbzYVKCuFfe61kIg0b10k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720536855; c=relaxed/simple;
	bh=/zFwBnlg/7QhbWzuK0Kw7bo0fw9QCxuJiesC8/hJAz8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=InzCNGG6BOHXqpz87n3rvTN326V1/dNi6Y/iMD9//NK6HuovCf4i5EoW1xinx/N8peOon/CtXcYreXe8uasiEfyWIBvy1/gwA3bdevAwrLDF9vJc782oCRN0W8oSHUeYrc8nUlEEyjIWh122qpIj69HGwqFICez5uTw7iClH8iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D3AoGA5t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469CtIPo003747;
	Tue, 9 Jul 2024 14:54:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ByYyUoUCXDmKa6frPSvH12
	XGR0SDHbCJv4LoQVI0IlI=; b=D3AoGA5tMIeom1j0UzXBpQS1ZEL5DX1oz9MCM8
	+/zERGSMY4meT9NYGgnZe/h0bC5SPiyOaaKo/eiQJjoll8pzRMu8/I9rWA4ELwG+
	aR7MsJfVhqsbKPUfpPh5hTYZ2AKqd2oEPTMmslGxa+t7BMIftIXV3nSyg3PKoUo3
	O5yqIngWPkWg3cn524nh91pxYSk9Qwvbtm3W/IEm+el5x+A1nks4Z9PPAJ3jpOIa
	TxjJMVDNh4t0huB283593g1l6dnIFAX/0lz3+/SV/BBuCloDBCFYPx1CsGyBGZQL
	WGnibSTIhV/BzC4quVOZI1S9eTOg02ZZsOlJE30BsDCmQ17w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 408w0r9m8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 14:54:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 469Es39g022682
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 14:54:04 GMT
Received: from tengfan-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 9 Jul 2024 07:53:52 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
Subject: [PATCH v2 0/2] PCI: qcom-ep: Add QCS9100 PCIe ep compatible
Date: Tue, 9 Jul 2024 22:53:42 +0800
Message-ID: <20240709-add_qcs9100_pcie_ep_compatible-v2-0-217742eac32b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPdOjWYC/zXNQQqDMBCF4auUrBsZo6J21XsUCXEcdaCNMbHSI
 t69Uejye4v3byKQZwridtmEp5UDTzZCXS8CR2MHktxFCwUqhxJqabpOzxjqFEA7ZNLkNE4vZxZ
 unySxMDW1KlO5QRFPnKeeP2fg0USPHJbJf8/emh7r/zoDVVQFJCotFUAlUzm/GfVCduiNvR9gi
 0lsiWbf9x/t1UGNugAAAA==
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <kernel@quicinc.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tengfei Fan <quic_tengfan@quicinc.com>
X-Mailer: b4 0.15-dev-a66ce
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720536832; l=1660;
 i=quic_tengfan@quicinc.com; s=20240709; h=from:subject:message-id;
 bh=/zFwBnlg/7QhbWzuK0Kw7bo0fw9QCxuJiesC8/hJAz8=;
 b=vTMLIjAii09hHbzfot7PcRHtKJiWnAa5wwjz1cnCN+5VCw1CsyGvmLgfrSxpCJZcp8yxd8XuK
 QvIbfU6HA9yCRvDqPv7AEIAIVpKyJ05V2za5sG+n9djHp6pXL2qG2Ns
X-Developer-Key: i=quic_tengfan@quicinc.com; a=ed25519;
 pk=4VjoTogHXJhZUM9XlxbCAcZ4zmrLeuep4dfOeKqQD0c=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kdQypOQDxD7kAjSc-05lgkgZxO7x65jn
X-Proofpoint-GUID: kdQypOQDxD7kAjSc-05lgkgZxO7x65jn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_04,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=614
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090097

Introduce support for the QCS9100 SoC device tree (DTSI) and the
QCS9100 RIDE board DTS. The QCS9100 is a variant of the SA8775p.
While the QCS9100 platform is still in the early design stage, the
QCS9100 RIDE board is identical to the SA8775p RIDE board, except it
mounts the QCS9100 SoC instead of the SA8775p SoC.

The QCS9100 SoC DTSI is directly renamed from the SA8775p SoC DTSI, and
all the compatible strings will be updated from "SA8775p" to "QCS9100".
The QCS9100 device tree patches will be pushed after all the device tree
bindings and device driver patches are reviewed.

The final dtsi will like:
https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-3-quic_tengfan@quicinc.com/

The detailed cover letter reference:
https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
Changes in v2:
  - Split huge patch series into different patch series according to
    subsytems
  - Update patch commit message

prevous disscussion here:
[1] v1: https://lore.kernel.org/linux-arm-msm/20240703025850.2172008-1-quic_tengfan@quicinc.com/

---
Tengfei Fan (2):
      dt-bindings: PCI: qcom-ep: Add support for QCS9100 SoC
      PCI: qcom-ep: Add HDMA support for QCS9100 SoC

 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 2 ++
 drivers/pci/controller/dwc/pcie-qcom-ep.c               | 1 +
 2 files changed, 3 insertions(+)
---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240709-add_qcs9100_pcie_ep_compatible-c5a9eb2324ac

Best regards,
-- 
Tengfei Fan <quic_tengfan@quicinc.com>


