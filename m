Return-Path: <linux-pci+bounces-11224-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FB494671E
	for <lists+linux-pci@lfdr.de>; Sat,  3 Aug 2024 05:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F791C20DF3
	for <lists+linux-pci@lfdr.de>; Sat,  3 Aug 2024 03:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4413AD2FA;
	Sat,  3 Aug 2024 03:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BMAiJYTl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A0D322B;
	Sat,  3 Aug 2024 03:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722655879; cv=none; b=I4Epbq7BTPwdJWipKrIvAcNzlelGhlht4Cuj/sW2SyKF8/Wb2hH+uPHj3jHg/PdtZiHcSr4yIngHZfVsKwFqSd/43TnI4yxPyvL9kK3AlA1/A41+Kbj5+ZrgrgnM7FdgLnmyKTad8ZRpF118eAUi8MTQ0ypvJNrd2/6qn2wPmA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722655879; c=relaxed/simple;
	bh=56FUIBy6AsSMDszG2ry1y3h2+Q5iWL0wbSQLpfzMPAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jUpubTkgSDify0ENAP1IUz2HVMMHYt9VaYEz5oxACyBsTLFP82IVY2ZmRbWozc/F3QV2KiB0KV3l+KbHKy5BI0reZuoh4nXghZ8hPqpj2b5VfJ7r1q9dT2fonDjk1G6sK7+t3biLQijzxb79JjwEvDdtDTJjx0MkIsJzZsOcP4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BMAiJYTl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47328307026620;
	Sat, 3 Aug 2024 03:23:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iG1de0z0ZqojfboorcQ5wpos5OY+SSH7FbMRXBdgoek=; b=BMAiJYTlc3tja6Dj
	+0kCri4Xzt4s3hW8Af0Jq0ECX8PE83cOGvdfcMpfNF8wlvnV8owBzO+KhF1y2LAt
	osmqHs60EJ0BDwGYIEPKV+61qHsXCf1RZe0a4Z1O/BiKW3qUzuHxL/dTnBm8QjLz
	diJrRjTlzojhu2Wt1Klnw4ONj3un2QkLxNfnwlu9wwTIKL8OFstRMbkif9KGpCE5
	mK8hlEdZHYisf/4uTLGyiirqne/4wx0qTjVF3GE0ErgtwoV5BAnbLM6kI3RosATx
	XDM8ddJZBjI5eZ62ked6fL2h3iHgU8cB+bbCjSRFqDb5XryQWN44tCrzfgjHsEjB
	qWCuxA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40s9wmr5bv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Aug 2024 03:23:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4733NG56027262
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 3 Aug 2024 03:23:16 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 2 Aug 2024 20:23:11 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sat, 3 Aug 2024 08:52:48 +0530
Subject: [PATCH v2 2/8] dt-bindings: trivial-devices: Add qcom,qps615
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240803-qps615-v2-2-9560b7c71369@quicinc.com>
References: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
In-Reply-To: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        "Bartosz
 Golaszewski" <brgl@bgdev.pl>,
        Jingoo Han <jingoohan1@gmail.com>,
        "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>
CC: <andersson@kernel.org>, <quic_vbadigan@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Bartosz
 Golaszewski" <bartosz.golaszewski@linaro.org>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722655379; l=897;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=56FUIBy6AsSMDszG2ry1y3h2+Q5iWL0wbSQLpfzMPAA=;
 b=hNTPw18sD8WQFD8u4YMtTyafoikAZETeiLQ8kU3x4IuKOoXLPGcz50dNxsGYwj9DOIGYqREwd
 BU4eTuWl23LAxDR1h3khArblwWha2xXbw3U/C6Ga1LDuTwmo1qShi1r
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qpAihopheNpZFXuWMmyeWQPJq90QvxpU
X-Proofpoint-ORIG-GUID: qpAihopheNpZFXuWMmyeWQPJq90QvxpU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_20,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=781 clxscore=1015 spamscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408030020

qps615 is a PCIe switch which is configured through i2c.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 5d3dc952770d..7f44add21bf6 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -330,6 +330,8 @@ properties:
           - renesas,isl29501
             # Rohm DH2228FV
           - rohm,dh2228fv
+            # Qualcomm QPS615 PCIe switch control
+          - qcom,qps615
             # S524AD0XF1 (128K/256K-bit Serial EEPROM for Low Power)
           - samsung,24ad0xd1
             # Samsung Exynos SoC SATA PHY I2C device

-- 
2.34.1


