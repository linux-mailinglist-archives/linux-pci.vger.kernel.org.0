Return-Path: <linux-pci+bounces-17224-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38BC9D646E
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 20:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F23DFB2184F
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 19:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94551DEFC6;
	Fri, 22 Nov 2024 19:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fWPXQKrp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEBD1DFE03;
	Fri, 22 Nov 2024 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732302623; cv=none; b=aPiF/A+ENQGy0JJLS6lEpWtBPMjKeaMLXoZjgM6WQHKZZd9LYWrRAxYDSihFDjCi3oq7muc6fToF5Og/vC1CVpfmUaVR/eowBFgMCVmRhNs4FrVX0Bg2jrmjGwaK4bEroAIFpZUuw6kaE+gBB2Uck6J43pFhc3oMG2YVBHLe4nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732302623; c=relaxed/simple;
	bh=84GZ+R2OqQE4rHqhAY6rc/ITnfPCkYF7wzsHxHXg78Y=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=qJT5sIcWpolsTL5iTCN4+ni3blNaCGKgeJ4MtGlzrcnBwMmr58eVI+fDXViTFPHVt0DszLblb3t4fA87KoxKtfuDTTjOhY/z29Z7nIdC2x69PjPjaURMJjys7pblGR9ml7f7p/XYAAg6CmwPLJTqQVNr+vfVo+hf1PqOtFHHz8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fWPXQKrp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM7tZvi002213;
	Fri, 22 Nov 2024 19:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UThjkvtVgCIcIdz+X4z1bc
	btxxw3djCQl/sVcWIyu3c=; b=fWPXQKrpOFOFX8tRbH34VoiDRyViRiAaZh18w8
	E6ykIxoXxBU/+LG8hrFiVPjb/J0cqllUQGtu5iQL0U/+Ww7hwjUXbXN/17Zop509
	Ue5luGFteEnC7vqHoKDQj+vDGfG7PmYRWsPc2MBOYPfifxYJcmvhtHSdF4Om5xDj
	0fhE2sU5GbSonFsCV4KrgdSMCv26DWbGBRDdInXMSmiAZKT+gruC4NymlofEGCIl
	FgpThH79pROXFB0DdTWfDo+VCAlPOc1ECmjQzn9yGArXZynoPuVBe72cVuyEJEaP
	RsjS0wvz2QVR+6qteoRs2v49NgDuBof0aBPlMGhyvVz8f+zA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 432p0d9pnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 19:10:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AMJABrt007593
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 19:10:11 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 22 Nov 2024 11:10:07 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v5 0/3] PCI: dwc: Skip waiting for link up if vendor
 drivers can detect Link up event
Date: Sat, 23 Nov 2024 00:39:58 +0530
Message-ID: <20241123-remove_wait2-v5-0-b5f9e6b794c2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAbXQGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyMj3aLU3Pyy1PjyxMwSI90UUwvDJBMDYwuD1EQloJaCotS0zAqwcdG
 xtbUAabw//l4AAAA=
To: Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Konrad Dybcio <konradybcio@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>,
        <andersson@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_mrana@quicinc.com>,
        "Krishna chaitanya
 chundru" <quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732302606; l=2230;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=84GZ+R2OqQE4rHqhAY6rc/ITnfPCkYF7wzsHxHXg78Y=;
 b=uMHF0GLlsaoaWCq0pHfuLO6JbdRpx/Bhlo6JURHw9Z1uqRT2Mg2lHUX+GrCJRNjnrIV63JKDB
 VrxiwEzKFQbAJRJSKOMM//ShGxrUoUuJGS1KysAFkdhpmFuv3GciD6w
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: B98aWgXbqGtIxOc1vLzZ5FYwNOT5kHZl
X-Proofpoint-GUID: B98aWgXbqGtIxOc1vLzZ5FYwNOT5kHZl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxlogscore=503
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220161

If the vendor drivers can detect the Link up event using mechanisms
such as Link up IRQ, then waiting for Link up during probe is not
needed. if the drivers can be notified when the link comes up,
vendor driver can enumerate downstream devices instead of waiting
here, which optimizes the boot time.

So skip waiting for link to be up if the driver supports 'use_linkup_irq'.

Currently, only Qcom RC driver supports the 'use_linkup_irq' as it can
detect the Link Up event using its own 'global IRQ' interrupt. So set
'use_linkup_irq' flag for QCOM drivers.

And as part of the PCIe link up event, the ICC and OPP values are updated.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
Changes in v5:
- update the commit text as suggested by (mani).
Changes in v4:
- change the linkup_irq name to use_linkup_irq a suggested by (bjorn
  andresson)
- update commit text as suggested by bjorn andresson.
- Link to v3: https://lore.kernel.org/r/linux-arm-msm/20241101-remove_wait-v3-0-7accf27f7202@quicinc.com/T/
Changes in v3:
- seperate dwc changes and qcom changes as suggested (mani)
- update commit & comments as suggested (mani & bjorn)
- Link to v2: https://lore.kernel.org/linux-pci/20240920-remove_wait-v2-0-7c0fcb3b581d@quicinc.com/T/
Changes in v2:
- Updated the bypass_link_up_wait name to linkup_irq  & added comment as
  suggested (mani).
- seperated the icc and opp update patch (mani).
- Link to v1: https://lore.kernel.org/r/20240917-remove_wait-v1-1-456d2551bc50@quicinc.com

---
Krishna chaitanya chundru (3):
      PCI: dwc: Skip waiting for link up if vendor drivers can detect Link up event
      PCI: qcom: Set use_linkup_irq if global IRQ handler is present
      PCI: qcom: Update ICC and OPP values during link up event

 drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++++++++--
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 drivers/pci/controller/dwc/pcie-qcom.c            |  7 ++++++-
 3 files changed, 15 insertions(+), 3 deletions(-)
---
base-commit: cfba9f07a1d6aeca38f47f1f472cfb0ba133d341
change-id: 20241122-remove_wait2-d581b40380ea

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>


