Return-Path: <linux-pci+bounces-16859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704369CDC92
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 11:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB11CB288B4
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 10:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7832718FC86;
	Fri, 15 Nov 2024 10:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aTHuBZy2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5F318950A;
	Fri, 15 Nov 2024 10:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731666645; cv=none; b=eHEdjQa7meaczO7Cb1qq91rnhLvYDlz7mZPmKwEiIGJOEhXzOcrZMxowP4y0EY1k7WQKtfdlJU/XTG0H+uHb0lUgZSw9nf2QkDMhiDcXUtsgc1xIChL+rU3JzXq9ajcZz9t77o+MiGLNkkcpK+IQbyZ1ZUqU5h9wCHRMROW2ho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731666645; c=relaxed/simple;
	bh=EpdEiIMl6ZRBhz+fEn11/ebqi8FroM95B5oRWx/T7Ds=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Y19QWSFfh3ye8kFrR7rKSGHGxZUXjCKTWHk32PGuIftSSVwR2lTIM714DMVFgjVDe/FQcaGfhOA1ttZvgzXBawyzuLyaSOY87M+kjlKVPGaHgg+Y6QVfe+b8XU/781k9dSPRRLJeg11WClhRM52FgkqvI4hmYJUsM4bURei6oa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aTHuBZy2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF23c4k002257;
	Fri, 15 Nov 2024 10:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5SXAJ5lb9FNKaW0xwt5j9h
	LPgMBwIi1YfFvZn5sO1aU=; b=aTHuBZy2Q4N7HA/t05CPlWTO89520ltWqn4+Zn
	g8FNw89AE+DDCwMdfjg9osg25t65KSgx0uAK4MliUVlf6E8m6bzNo5UNtQczAdkE
	2EdsbeYPx1QGjjHeq/BeSsR4vPqxBFiaOUYvYLJFc9a5X1TsohzlYoBc9mFg2nHC
	xtxgenLLZTW/Fs3HJ7743dNgqZgD8QMs4bsXnbIT4kXscmc6sljvFMCbgAojU9LY
	rm1jB27cC1w3vEpYevbp5DzTj6KtGDyBXz6v0ILxbCJxoqEunws7ouoXqvJFcFF0
	djNXztq9NxiKzueJE6gWPt3+7k9zxuWn0YKRpCUMII8Zl/5Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ww6ds8ns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 10:30:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AFAUW4n001028
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 10:30:32 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 15 Nov 2024 02:30:27 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v4 0/3] PCI: dwc: Skip waiting for link up if vendor
 drivers can detect Link up event
Date: Fri, 15 Nov 2024 16:00:20 +0530
Message-ID: <20241115-remove_wait1-v4-0-7e3412756e3d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL0iN2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHQUlJIzE
 vPSU3UzU4B8JSMDIxNDQ0MT3aLU3Pyy1PjyxMwSQ10jC8uk1NSkRENLC0sloJaCotS0zAqwcdG
 xtbUA52Fbe14AAAA=
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
        <quic_vbadigan@quicinc.com>, <quic_mrana@quicinc.com>,
        <andersson@kernel.org>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731666627; l=2144;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=EpdEiIMl6ZRBhz+fEn11/ebqi8FroM95B5oRWx/T7Ds=;
 b=PdHm+7JAzkpuX3VUgYRhQRjtgy5TBo9aeeho2EFd8gYct/pOkwoAuYuSpSaaucBT9aZFz14/O
 qUMYVvclxNIBULco/sXAL0i5yMiWlpG6VSeuJTXRdU9z2cI9cOvSosR
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: L2JG8irrCwzK7rx9S89UiXRdregN1Lgl
X-Proofpoint-GUID: L2JG8irrCwzK7rx9S89UiXRdregN1Lgl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 clxscore=1011 adultscore=0 mlxlogscore=508 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150089

If the vendor drivers can detect the Link up event using mechanisms
such as Link up IRQ, then waiting for Link up during probe is not
needed. if the drivers can be notified when the link comes up,
vendor driver can enumerate downstream devices instead of waiting
here, which optimizes the boot time.

So skip waiting for link to be up if the driver supports 'linkup_irq'.

Currently, only Qcom RC driver supports the 'linkup_irq' as it can detect
the Link Up event using its own 'global IRQ' interrupt. So set
'linkup_irq' flag for QCOM drivers.

As part of the PCIe link up event, the ICC and OPP values are updated.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
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
      PCI: qcom: Set linkup_irq if global IRQ handler is present
      PCI: qcom: Update ICC and OPP values during link up event

 drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++++++++--
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 drivers/pci/controller/dwc/pcie-qcom.c            |  7 ++++++-
 3 files changed, 15 insertions(+), 3 deletions(-)
---
base-commit: 624ce1863d33298cd1623e51006147e4076ed2ca
change-id: 20241114-remove_wait1-289beeba1989

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>


