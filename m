Return-Path: <linux-pci+bounces-20329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A0FA1B4A6
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 12:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D03447A5448
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 11:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021A8219A89;
	Fri, 24 Jan 2025 11:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EmLqHnf/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323221CDA13
	for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2025 11:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737717785; cv=none; b=pCfxkb7ov55GZkflj878Yn+7RXPd95W5YLnk9cJ+0h9FrE5gwbTDAqXcwiqXePbFAzGOvOrenLW9jhtwoewnoIQOw2jcK7OsO8VSeIumcKtwAJX8GLrkHoYMGgo6ZIBwfLe/gCI2BthVsajHM5ZGT0IfXQJzHpyG04KZFLDMhGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737717785; c=relaxed/simple;
	bh=DpZFnNMp3cO4OUAmgMvMghSHLjbZcw+carW7Us/j6OI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F6h11MxFkSYQoyyF3vjUGm7EX/Q3n1lxMuObYV7MsrBiEatEnFfJft73dj0gEXBFH9TuD+JKxql5ZCj9O0vbBNi6LJSqDkEfujcC5x+e1hqT8p/mis1mAbCfml65CoZrnCTNlVY62nNfJTgKSLJkLK4N0F5gXPYng3LyHwL5ARc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EmLqHnf/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O3ImK7027174
	for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2025 11:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=3mi2/FOT+ZwP5xiq0yBz3H
	cxfPxdLACnXcTnr7Krs/U=; b=EmLqHnf/GkGfSfhdAdz2oXVA/dLHwOTAJIgTCV
	woPpnH5nPVPdvf7YhMq8dAYrIK/A+GX1ZAPF9zHcSscF2QlieMplY9OR3kGHxEqt
	g/aYaKEdQJUyYE2mi0nuqvwxmEJ5E0r3YSy5pFnLK/KEs6Sy1JvrDA6FrG2hZod4
	pHRUZ+NwFrreFCKGP9yEXyGUiHgqM/E9c+LtznwEJpa/52y/+q69Pa4fdCrWfXJZ
	9uDYMWTb6iLJT+fmmRuqXfo1uskmKy+hhuxCeoeaCtm2nQ3wbcikE1gd8pOXfLPU
	2fvhpRcMNd+h31qmYb+mURnCOaNgjikrZhUPRfsFQ234P44A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44c2uj96f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2025 11:23:03 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-216750b679eso27507265ad.1
        for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2025 03:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737717782; x=1738322582;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mi2/FOT+ZwP5xiq0yBz3HcxfPxdLACnXcTnr7Krs/U=;
        b=A9scAogiVNhwFqYQISQC2nxnBjlK34RzDwgXb0Qg53c7W4fDbWjdmBDXzxsDGgqfP/
         kTjyR54AEUUfUNPgrB0+SU96QAA3RAATftCzWKX4AjVyblQlOp6kibxsMi1QtqVf9Orz
         1PCD8aINkgEKzGtH4r0gpiW/yqfeLZP48Fk6V0f5EY3pPxwOxSCd/PbYl5TaeHm5zyPl
         7A9434KVCefh1BjccHJW2lsd8Fw/r0lbva+4B/F80cayKJI/mc3Ng6JoMX/RzrXRIwPj
         bHZN9dHsvgvyRlfIeO76dIfLQd1qlF+bQeJKPQnbqj074NsHmHlxbGGbMO///XnS/6OK
         oUhw==
X-Forwarded-Encrypted: i=1; AJvYcCW78B57unVx39BWRct0lgc8C3A24A0TxWmbjWqV6lLVD3GVzOoY4MFhe+Te98wTCf9P5AjgSc6No+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7qePmoljO2RC+dhJcdVlO2JnXJ2Q9yIZJrmzxYRHQn8PQ1jD+
	LIOR2H6hxfyG5e6FmnjQTRpT69v7N5D2Es8OH8DcMVij2Zn5LurDc9q4wWbVc93+Don4hS01mJ8
	MnuyY86SWxv4HGB9UsfEfBVYKyJRwzSqWb3ydCzQm/f0LVxd1emowIHkymjM=
X-Gm-Gg: ASbGnctRdgTY8Uczy6VwWezQvzJsX3V+p/HNuTDqs5g/HbyOCAr5R0vox37wtT+fC1B
	3UQZm0sEdtl+ePTLvzUZ2CkdgnmCpLyl4sf23LynYmj7tyZcra9sV1fPivqpurhMyzbg6M3Ok1a
	KIQZOj0FE3echenL/DjPT44IgNnaJACpNd9Qc/QkHiWYTEOlJii94pHewkLybFoXS/XDaRUVrAy
	p9hRS54HQDrwt3EyB7Rb2sjHdH0G04XzM6Mv77DYh32ftEbLoKQVv2l7SKJ6fIEi45UYtO4Rsjf
	0Hihu0v6TyP8Kdk1zqJ1ARr/Ru2GaA==
X-Received: by 2002:a17:903:11d0:b0:215:b1a3:4701 with SMTP id d9443c01a7336-21c352ed490mr404143025ad.13.1737717782408;
        Fri, 24 Jan 2025 03:23:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiLWCijDXCj8ttRHTSiQ0uY4s++q43Ps4ZhiIGClibQ2ZxIuCxnlRpKYfB3B5HmtxRwP9HSg==
X-Received: by 2002:a17:903:11d0:b0:215:b1a3:4701 with SMTP id d9443c01a7336-21c352ed490mr404142695ad.13.1737717781997;
        Fri, 24 Jan 2025 03:23:01 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414cc20sm14025385ad.165.2025.01.24.03.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 03:23:01 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v4 0/4] PCI: dwc: Add support for configuring lane
 equalization presets
Date: Fri, 24 Jan 2025 16:52:46 +0530
Message-Id: <20250124-preset_v2-v4-0-0b512cad08e1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAZ4k2cC/23MwQqDMAwG4FeRnlepacW5095jjBFrOwvTutaVD
 fHdFz15EELCn4RvZtEEZyK7ZDMLJrno/EBBnTKmOxyehruWMgMBqoAC+BhMNNMjAS9V3VSoW6T
 B6J8u1n0363an3Lk4+fDb6ATr9kihEhwKoaSwjW7PePUx5u8PvrTv+5waW7EkdwDIPSAJQClrq
 6pSoy0PgGVZ/gjix3nqAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737717776; l=2904;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=DpZFnNMp3cO4OUAmgMvMghSHLjbZcw+carW7Us/j6OI=;
 b=nBtnR8ZMQxp8i3AjvoBOYv5mGfLsxB1A2nKJD55i1qNfv0sbETbA62jNXWz1d7VjhCz/hbF3y
 /5POaZy6FBsBLtAM4Bih8+4ZUp9VR1Z33tSTM+rxRHtEsJ+IRwAO2jg
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: RV8rcRUXERMOm3KqQlmGQGJsEn5Svvse
X-Proofpoint-GUID: RV8rcRUXERMOm3KqQlmGQGJsEn5Svvse
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_04,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=932 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240083

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
Changes in v4:
- use static arrays for storing preset values and use default value 0xff
  to indicate the property is not present (Dimitry & konrad).
- Link to v3: https://lore.kernel.org/r/20241223-preset_v2-v3-0-a339f475caf5@oss.qualcomm.com

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
 drivers/pci/controller/dwc/pcie-designware-host.c | 44 +++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.c      | 14 ++++++-
 drivers/pci/controller/dwc/pcie-designware.h      |  4 ++
 drivers/pci/of.c                                  | 47 +++++++++++++++++++++++
 drivers/pci/pci.h                                 | 24 +++++++++++-
 include/uapi/linux/pci_regs.h                     |  3 ++
 7 files changed, 142 insertions(+), 2 deletions(-)
---
base-commit: 87d6aab2389e5ce0197d8257d5f8ee965a67c4cd
change-id: 20241212-preset_v2-549b7acda9b7

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


