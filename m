Return-Path: <linux-pci+bounces-16949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E339CFC26
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 02:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFAEC288098
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 01:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F332913CFA6;
	Sat, 16 Nov 2024 01:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ff5DyFGv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D66161;
	Sat, 16 Nov 2024 01:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731721079; cv=none; b=lY2KhBj1ItTO21VAF2Iv0M7cAdwdhW+xNfT1uFHlN5kkV553jXShX0XZGEcQkSMXj303ab2w2QAron7VPKjYRUFuNbiUl4ImAfCQtvO1D0C6+CYcrAWEOi9qF57hxKgcC1pP6qoM324jpOluq28d7GswVn1vK3pIh/q5hzKSEOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731721079; c=relaxed/simple;
	bh=8nCsK2yqyN1I7U2nMMFN3q3U2Szp/zF7uNTwRCgC+CY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=AkpxP8+IuwojQ36ai3h0RQd605VuVGwrSLyS+Gw6PV/7iN1TP2JK3vBVzp1E50P0505sJr12CZR5XJJM000mPgRSGZPZeCtlQkoYX/g0h8pb2YhjshA/jkYOMcnVU26jkH85PThmuYCM+zIhWMVg3cR1wVnvGjaruvXoXXWLzwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ff5DyFGv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFIwEah000944;
	Sat, 16 Nov 2024 01:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=OzEcC6hVqatMryLUuXYNlU
	PIrrbmM7lz2gc7C5tfUmE=; b=Ff5DyFGvwrok5H4jUfNv8745UM18nFHlfEgqUh
	NWJwxLD7uKmbPDn/tVP1ZroXNNj9sWUVhHdmT4AMnnqYchNEbIzHKXg/xzddjuwe
	PP1qMNMTePEdQl0uiDNTaiYfRcUjeUYJKMmyrKT8C0q2M5GeY/tbFe49rTPoHNqE
	CxN7NEvy91vkln7ozBFg6UFmdAPqNVvmTF6YjjO8v4IzyTXV8brS4obpCWSx+aOq
	+bjUx1IktYXQPZ1NrXfwz/vYAd6xWScedy/yNXBwu9QQe/vfcaalhQgVylv7XuRc
	NAd/ZrJoGZDm0Wwv7loyCSOa8Qsnm7Drmj1/kO0LaIg7Ctlg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42w9sv7krf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 01:37:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AG1bjHY022868
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 01:37:45 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 15 Nov 2024 17:37:38 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH 0/4] PCI: dwc: Add support for configuring lane
 equalization presets
Date: Sat, 16 Nov 2024 07:07:29 +0530
Message-ID: <20241116-presets-v1-0-878a837a4fee@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFn3N2cC/2XMQQ7CIBCF4asY1mJmgJbqynsYF0DBsrBVqETT9
 O7Smtgal28y3z+QaIO3kRw2Awk2+ei7Ng/cbohpVHux1Nd5EwZMIHCgt2Cj7SO1BlFxK4TSnOT
 vfHf+OZdO57wbH/suvOZwwun6aSDgt5GQIi0qzQFrxYHB8f7wxrdmZ7ormSqJrSSyRTIKFF1ZS
 K1cKSvzL/laikXyLJ0weylBO6PZrxzH8Q0PH1UVFAEAAA==
To: <quic_mrana@quicinc.com>, <quic_vbadigan@quicinc.com>,
        <kernel@quicinc.com>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas
	<bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "Krishna
 chaitanya chundru" <quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731721058; l=2198;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=8nCsK2yqyN1I7U2nMMFN3q3U2Szp/zF7uNTwRCgC+CY=;
 b=kTN5PNrAZx/PNGwdCJ1jtnPPulbmjgu/PV5SllUhG1fcMQhB7Ge6b41eEsHEAev6opqjCJlMN
 8KcqOrFjVJWDqaxBVuO3AeTgv1/w3Q08thL6XiGbYArd2AZe49OxXQt
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lt5DqAiarWOfJy_QlsdGrOGD6M5MOFU8
X-Proofpoint-GUID: lt5DqAiarWOfJy_QlsdGrOGD6M5MOFU8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=838 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411160011

PCIe equalization presets are predefined settings used to optimize
signal integrity by compensating for signal loss and distortion in
high-speed data transmission.

As per PCIe spec 6.0.1 revision section 8.3.3.3 & 4.2.4 for data rates
of 8.0 GT/s, 16.0 GT/s, 32.0 GT/s, and 64.0 GT/s, there is a way to
configure lane equalization presets for each lane to enhance the PCIe
link reliability. Each preset value represents a different combination
of pre-shoot and de-emphasis values. For each data rate, different
registers are defined: for 8.0 GT/s, registers are defined in section
7.7.3.4; for 16.0 GT/s, in section 7.7.5.9, etc. The 8.0 GT/s rate has
an extra receiver preset hint, requiring 16 bits per lane, while the
remaining data rates use 8 bits per lane.

Based on the number of lanes and the supported data rate, read the
device tree property and stores in the presets structure.

Based upon the lane width and supported data rate update lane
equalization registers.

This patch depends on the this dt binding pull request: https://github.com/devicetree-org/dt-schema/pull/146

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
Krishna chaitanya chundru (4):
      arm64: dts: qcom: x1e80100: Add PCIe lane equalization preset properties
      PCI: of: Add API to retrieve equalization presets from device tree
      PCI: dwc: Improve handling of PCIe lane configuration
      PCI: dwc: Add support for configuring lane equalization presets

 arch/arm64/boot/dts/qcom/x1e80100.dtsi            |  8 +++
 drivers/pci/controller/dwc/pcie-designware-host.c | 42 +++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.c      | 14 ++++-
 drivers/pci/controller/dwc/pcie-designware.h      |  4 ++
 drivers/pci/of.c                                  | 62 +++++++++++++++++++++++
 drivers/pci/pci.h                                 | 17 ++++++-
 include/uapi/linux/pci_regs.h                     |  3 ++
 7 files changed, 147 insertions(+), 3 deletions(-)
---
base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
change-id: 20241030-presets-ec11a3e44ab3

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>


