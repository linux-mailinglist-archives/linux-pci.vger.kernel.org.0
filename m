Return-Path: <linux-pci+bounces-18951-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B95399FAAC1
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 07:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E33F16289E
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 06:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD3C165EFC;
	Mon, 23 Dec 2024 06:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aK31zlnM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BCD74BE1
	for <linux-pci@vger.kernel.org>; Mon, 23 Dec 2024 06:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734936691; cv=none; b=Gy6oMMeqwtKQ3cdHwwwqKDH207g+PzDYOzfDETGugYF1R63GocbTPtQkuU+1yAXVu3CsM8s7RlYGwyPClNGZFDshkPL43izs9wjYvoYnplAnpQfkCxjsTkfoXzrrARDCwXE1XwnIKG7wacWNTCqjJukEXPfb7XGySHYrUD8bevQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734936691; c=relaxed/simple;
	bh=lBJfTfyy82CFWAqoyStq/YFskmSdscx2DftkuxI1ipM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fcWAzd14w+z0o1D802boBeQCGyjdqVuYeZQCAPchKAxzVpkEd0rCtpfa2e5BE0OQV+GVJLWJHkxkatyriyHWpKN/g9g3Z/9YGkaP5z365GnGVRB5bG7IteIlDlTjn9tlJTvURuVUnW7r61UOeJVMimiv5xmCUSmx8n9SSO3ok5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aK31zlnM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BN5rhkS018516
	for <linux-pci@vger.kernel.org>; Mon, 23 Dec 2024 06:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GJKPKhypiwFlHXXXzSqxMY
	vz477BwD5Vi0ulwANrFkk=; b=aK31zlnMN3kgQxjbVZc71i1pOITRd5d+DG/4Aw
	LwjIeFP6+p3QvohJh+FczO+ssIi4UP2SMpiuj+PoO6mwwWKW9YfXToGUOtylNFcP
	M4pTEefGas7hZmOoRUkpyCGKBux+Hz6IGNzK67znzG02U2Qyio1SexfaQLBV3Qt+
	YO25L5nrJcQTonrdYoPdx19V0tDvgJuq60EOuk72ddlGxwECyezDj7ZDbupnmi8r
	W9axkbim0Io2JWUjI2ssZpVyqCebUI0gf3hnTYC70IWwjfktKFo+XqOGvYZquWe5
	AZLbiWLgs7q8GwQ1zGvzks6SdnyE2ORoDf0O23afko+L3rjw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43q24587a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 23 Dec 2024 06:51:29 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ef91d5c863so3725678a91.2
        for <linux-pci@vger.kernel.org>; Sun, 22 Dec 2024 22:51:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734936688; x=1735541488;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJKPKhypiwFlHXXXzSqxMYvz477BwD5Vi0ulwANrFkk=;
        b=IiismpHxnmh9lr8vvQwDv3uaOfH/fL4dcgiMT+NedOJXL6UjbNFPM4P4pWENMeWRC8
         QcF1zRBgba9qjXpe1RwTimq5esHMfYtnmXw7CSuTuep99HEvPsNnuSb37DbS7ImnbGB4
         NGoAPM6uQF/bo/QvsXuJVs0CJ8wNPx7vwtdtAFsj5J0uVAVsk53B2kdJyjOEmZu6yASv
         1G1NUl2TNlxk58wkIr0uLyhHkQdpp0hF5+pIq0EjwvJ03sO535R2KTmx2r3CuJKB9ndj
         QDu301M8+iY0S9ct8NU5+xNKN1MMshJPM7KiGh+MmY3mMlmGfkIYEvBl5Zuxw6HaDRQP
         4W2g==
X-Forwarded-Encrypted: i=1; AJvYcCUFRvt9XjaSGEa+ONdevmU3Zaut2RBL3lEdCj8gvJGj2q8Zrsq//DHBwAngMpUrn0VzsKXnCg9Iqwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3IX+/K+gcXBZsXaMx7RUy8EHKG3ZxbOhySfmVqhUG6Bw0ksEc
	bxIulTvcHamcue6ureWp4xOHwfoC7JkAGg6+C2ucrfM4L+Qob26g71cOcLK1G+SiKqSLYjicvYc
	pFWOlr9XNQNkNh9k3c2GS2QUitMAnyPJ48B5AZvBb1tD4qKCl+Uy6HYwO/LE=
X-Gm-Gg: ASbGnctnH4ltMYUz4Fxjwjpzr9pFugMKdZc5QgDQhypSEPYaDYdEtMryy+wFaEfCH7w
	yhlKrzfGtPHEVmstlQuxDpanGCj1HdEAm4mLojF1fQDSVh0Pw7p8700bZPrkLNNbE9SvSOX3YUS
	pxncbrqVzniTQ14e6v6sV+Sb/3HKQkxqTM0RY1+rbowddDhYvWNV7zTOM+l6uM9+xfiftFYD9qE
	Fai5GXkoFPRDuTDovFu9zbpFJWmufRxuvkpT/1ZpMuSmv17MaXFMX+a8l8Ze+WSqcKhZcc1s1me
	+CJrK9aQ1lXrFL4w
X-Received: by 2002:a17:90a:da88:b0:2f4:49d8:e718 with SMTP id 98e67ed59e1d1-2f452e214cemr17751568a91.9.1734936688226;
        Sun, 22 Dec 2024 22:51:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+j3ZPH6FPMtFq7GGF7AhVdv+m9FAANNXaVx1byCRhfcHBriueOMCRRzGdo4GvZLUvEOVD2w==
X-Received: by 2002:a17:90a:da88:b0:2f4:49d8:e718 with SMTP id 98e67ed59e1d1-2f452e214cemr17751540a91.9.1734936687872;
        Sun, 22 Dec 2024 22:51:27 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f4413sm66570155ad.172.2024.12.22.22.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2024 22:51:27 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v3 0/4] PCI: dwc: Add support for configuring lane
 equalization presets
Date: Mon, 23 Dec 2024 12:21:13 +0530
Message-Id: <20241223-preset_v2-v3-0-a339f475caf5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGEIaWcC/22M3QrCMAxGX2Xk2o42q/hz5XvIkK7tXMGts5lFG
 X13466FkHDyfZwVyKfgCc7VCsnnQCFODM2uAjuY6e5FcMyAErVChWJOnvxyyyj2+tQdjHWGD3C
 fkz68N9e1ZR4CLTF9NnXG3/efhUcKVFI3su+sO5pLJKqfL/OwcRxrXtCWUr6yHT1UqQAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        konrad.dybcio@oss.qualcomm.com, quic_mrana@quicinc.com,
        quic_vbadigan@quicinc.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734936683; l=2651;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=lBJfTfyy82CFWAqoyStq/YFskmSdscx2DftkuxI1ipM=;
 b=Mm0+o0Kq6oZ3EnHMUbhhhR82hhpsA4bkTYPodrKs2rSh51Nd3e+3IjBwjhNEoVt/lyTcpUiih
 KH5xAWOHyWAC4bm4WycNHQ+ECcbDvuGRW35wAAAiI1asAEFB4AxKaQj
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: anp73qseOOTwTPCR3PL3a2A6NhnkPmIc
X-Proofpoint-GUID: anp73qseOOTwTPCR3PL3a2A6NhnkPmIc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=948 priorityscore=1501 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412230059

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

This patch depends on the this dt binding pull request which got recently
merged: https://github.com/devicetree-org/dt-schema/pull/146

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v3:
- In previous series a wrong patch was attached, correct it
- Link to v2: https://lore.kernel.org/r/20241212-preset_v2-v2-0-210430fbcd8a@oss.qualcomm.com

Changes in v2:
- Fix the kernel test robot error
- As suggested by konrad use for loop and read "eq-presets-%ugts", (8 << i)
- Link to v1: https://lore.kernel.org/r/20241116-presets-v1-0-878a837a4fee@quicinc.com

---
Krishna Chaitanya Chundru (4):
      arm64: dts: qcom: x1e80100: Add PCIe lane equalization preset properties
      PCI: of: Add API to retrieve equalization presets from device tree
      PCI: dwc: Improve handling of PCIe lane configuration
      PCI: dwc: Add support for configuring lane equalization presets

 arch/arm64/boot/dts/qcom/x1e80100.dtsi            |  8 ++++
 drivers/pci/controller/dwc/pcie-designware-host.c | 42 +++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.c      | 14 ++++++-
 drivers/pci/controller/dwc/pcie-designware.h      |  4 ++
 drivers/pci/of.c                                  | 45 +++++++++++++++++++++++
 drivers/pci/pci.h                                 | 17 ++++++++-
 include/uapi/linux/pci_regs.h                     |  3 ++
 7 files changed, 130 insertions(+), 3 deletions(-)
---
base-commit: 87d6aab2389e5ce0197d8257d5f8ee965a67c4cd
change-id: 20241212-preset_v2-549b7acda9b7

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


