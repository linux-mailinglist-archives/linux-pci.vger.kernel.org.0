Return-Path: <linux-pci+bounces-44098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5934ECF8551
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 13:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18DF33021794
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 12:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128D2326D6B;
	Tue,  6 Jan 2026 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZzCn7GqG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OclxdEJ/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7544B2DA749
	for <linux-pci@vger.kernel.org>; Tue,  6 Jan 2026 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767702908; cv=none; b=sLP7eTAm2xN3gSQ0Endk4zQJBGkj8STUs8nvFO5kFaA+2Cv1UaxjIu3gGABSxHx3JFbLkOYAS73svhxj3I0bVR7EZP83l2oCpb9tLY6vTXi/cvPHObtBf7h8SvFVFLZJHBlb8FrXq5odDoSJLQ9cfGd5YqCAW9OwVmKFGvVFq54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767702908; c=relaxed/simple;
	bh=2RDD/rzxwkAra6ZrjYNETweAEEQKDMYqwdqSTtF1kJs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ptem1TlwuDZ6EzIsk3MNks5XMnxeSiDxQ7xh9zTt+Bcz+VHG5vszGZf1OTgQza60Kg2e5l3iTNVj7BLUqE1SCLC/M0X8Nqb2lNJxg2flMb0t9dvYRAMFyVqwaSY1ajVa1K2L2tFfF+SoUPc40y2Mymv37EMw6tpGCdeNfh16qoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZzCn7GqG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OclxdEJ/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606B24La2255188
	for <linux-pci@vger.kernel.org>; Tue, 6 Jan 2026 12:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=H48IToLSo0oZ7+JTTa9/pt
	0c6xxpM1rP2eGa/2HD16s=; b=ZzCn7GqGr1B/Sh0DSsZiDuNGpIqEIJefsbVN9w
	J2y8p5RJNw2H2i949qs+jpboc3VbTUwPGxP2ON07irNtwT56YMCFRHePR9IX5JVM
	OJneITMUEzTtN/5OokgMkuGqp/gChQgEUsdnIkTyFxFSb9n11mnYJ3LIhzo8AJf5
	9YzG0PhGE3UrdOLrXgm0Ohr1Na8dY55mvjZ19NnTCefnZBbvHlUNI8Osuyq+QXhN
	PivvQ9fLRczfil+HQrUrZ2i1UzLAW7BZCOHOOck1htcu8Ln2lRxnTWS3Roz4045O
	RbFgff/+oCQ2N2yiSijD5NMNiCaaumhHmV3Dq7f+jkGV8MfQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgu421bvf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 06 Jan 2026 12:35:04 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7a9fb6fcc78so863042b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 06 Jan 2026 04:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767702903; x=1768307703; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H48IToLSo0oZ7+JTTa9/pt0c6xxpM1rP2eGa/2HD16s=;
        b=OclxdEJ/kOZBOtANFrLR1faLOeO2uEg9qny/wqvct4ayMHDj75bj1MYs9TF4+InQNm
         m0Y40ttbJVEsMfbhrAFzbKD45+6N7tFLTetgZAjEYUU495BS6gmnOKOOxgkYVMhDWfk2
         S5bue51H7QyanVKqXkl0MI0XKNAnuB5Cah0RGxDgLngc35fA3WuiulX+cgXfbc+gbHlO
         SWMFKQHW5faBIFJFf6GjbZ+ScA8FhjTD7LM2gsGxpXNJLsLibgfHNUmGVG0t0+nhd4oJ
         we0Stx8dQpi/nUd5M7EGjWeZyvcSSRiswHQO2LpXVe6BRWddWs9rDYNVmxxoncABgcH2
         YhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767702903; x=1768307703;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H48IToLSo0oZ7+JTTa9/pt0c6xxpM1rP2eGa/2HD16s=;
        b=U7aRhcMvyqQ3Sp4D/EHKzqkltKCD7QSZsSnlBEvMVXyGLAsvK2BLrvGkC89Bu3xITs
         x56JlNbx76Pu8yMOkGydxTRtmWQQuoZurdys0K2gpHe4GYGh9Z9BuMHmpHgOC88iP06e
         qm5bZc58oQwTVDDyORNUmuIxXwPtcoLzZIkmXISLuFSu3uwPfBywT7/wMX7cMS1XnfL9
         xH2O6W4yo3BPwp3BatlS7MyzJu8vBxkyNEo4EBzm960hXuZg1Fq4zHE04T3WhqSnzIxO
         9trdlzyXmbYiQoS/ne/XkjP82BfBqZjdRcpwcWrf1bPNEPCaopVB6H2XW3PGHKe6mgGt
         JZXA==
X-Forwarded-Encrypted: i=1; AJvYcCW3QNCSCfRRH2id2ZKTbOeMoADIV+ETxtH0+Q+mQzr/oRD2i39xPAOKnN2ji4gidVmkKHT8z75SxX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5yiePftd8cyqxEWfMf+vqXQQOxIztIYDQ2uAHcIzIwKp7R+wl
	cVx6K2WqUQ75y2I3mgsSsvbsydaMq78vgQeXL+k/9oNxMGuSrtD5aqTOJtRlVru7YWkQfGx4GCb
	eCw6060Zz0FNTB8RnlCFCVpp02F4FwMmYHOkCcaVq+pmH5F+l9MCb+wE0SYdO+8o=
X-Gm-Gg: AY/fxX4aUPdIxm9KNPwDysj+ksGbF6UjHzgilrt8OeaUP+VnU/5098qwHG7F1xwUrMm
	8E8RyloQ7+kfxzLJo+A4uiPI0hWO/oV/PIpJnv04txBM6gL0vZrdqn6dO38nKkpEHXOtRI2OM9n
	OOtJPJWjmVMTN/syXjar7or9Yd56Fh2vmHvX88ntdJYJ5yitj3meIaauVxRPFaG4+HawUA94WPs
	t0gC3pRTVhZRHqZn5XD5gkRrTDYP6vdm9fVPuCid9iBIcrCu34U68vOgma/nk11Dgg9HIGAapYV
	lXEXmw4cP71QM/lgX9Akh++VrTCo+k/RKgHiYOHCoRTZibfEorjKPvveTQ/vBaFVA3TyYwlxhuc
	oV6eJ5AMNtBhPGY2lkKDVAspO1u38ZgCfYZGdjLEneEE=
X-Received: by 2002:a05:6a00:3016:b0:800:8fdf:1a54 with SMTP id d2e1a72fcca58-81882ed4e63mr2747033b3a.34.1767702903179;
        Tue, 06 Jan 2026 04:35:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOpXYXpBJuyP7pW/B6ADInveqDxUCY8PGABjDrGn2VzGcMZufzwWDAr64QqHfVmjl12wUTow==
X-Received: by 2002:a05:6a00:3016:b0:800:8fdf:1a54 with SMTP id d2e1a72fcca58-81882ed4e63mr2747003b3a.34.1767702902651;
        Tue, 06 Jan 2026 04:35:02 -0800 (PST)
Received: from hu-msarkar-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e83bcsm2161583b3a.56.2026.01.06.04.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 04:35:02 -0800 (PST)
From: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Subject: [PATCH v5 0/2] Add firmware-managed PCIe Endpoint support for
 SA8255P
Date: Tue, 06 Jan 2026 18:04:44 +0530
Message-Id: <20260106-firmware_managed_ep-v5-0-1933432127ec@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGYBXWkC/33Oyw6CMBAF0F8hXVtCW/rQlf9hDCnQgSbysNWqI
 fy7hRULdDPJneSemQl546zx6JRMyJlgvR36GPghQVWr+8ZgW8eMaEY5oURgsK57aWeKTve6MXV
 hRgzAa05ULjhXKDZHZ8C+V/Vyjbm1/jG4z3ok0GX73wsUZ1hqyQijkmUSzoP36f2pb9XQdWkca
 GED21Jyn2KRAlCSlFooBeUPKt9QlO1T+fIVyIqUitVCHneoeZ6/n279Q1MBAAA=
X-Change-ID: 20251216-firmware_managed_ep-ff5d51846558
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        quic_vbadigan@quicinc.com, quic_shazhuss@quicinc.com,
        konrad.dybcio@oss.qualcomm.com,
        Mrinmay sarkar <mrinmay.sarkar@oss.qualcomm.com>,
        Rama Krishna <quic_ramkri@quicinc.com>,
        Ayiluri Naga Rashmi <quic_nayiluri@quicinc.com>,
        Nitesh Gupta <quic_nitegupt@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767702896; l=1972;
 i=mrinmay.sarkar@oss.qualcomm.com; s=20250423; h=from:subject:message-id;
 bh=2RDD/rzxwkAra6ZrjYNETweAEEQKDMYqwdqSTtF1kJs=;
 b=RcRXJTuHXS3IOCpT9XJohvlvjxO+96rSlKeLrn4BV2krx74hIryOnirhFt60X+Ez5z3jbPLH1
 s1edtGTgzxNB48cNCGfSFDK2dwrn99aUr6/rZ9NSNMhr3k38MHyji1v
X-Developer-Key: i=mrinmay.sarkar@oss.qualcomm.com; a=ed25519;
 pk=5D8s0BEkJAotPyAnJ6/qmJBFhCjti/zUi2OMYoferv4=
X-Authority-Analysis: v=2.4 cv=dYuNHHXe c=1 sm=1 tr=0 ts=695d0178 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=3jyur01tNAjp9li57p8A:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: mbPHlPID4XxDLeymoPfkN5Ha4vx9GF6G
X-Proofpoint-ORIG-GUID: mbPHlPID4XxDLeymoPfkN5Ha4vx9GF6G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEwOCBTYWx0ZWRfX0n5IO4lqijKQ
 mAXWwpllzcpb26QOHhJRwSOdTqvcMCt7Nw9Fu4+aBtQKRe5WnNE6SQ7AWgQmcSZgqwL8YSwMtQS
 ZO2osjEu07a0eRmN/Kf1SrDCCDlFSU2InZAR5z5VqRyx6eJllH+cIOUymhwFHX4mtEZLw4QL6gs
 YKm43kewIovsPwkqJujIMOkxPVP13OFRtpbghR+pe79p5RR+L3Q/vY+wP3ToRSs3kAzGjBGQa0a
 hqisULAmMGgryNhk5UzL4+EjZKcsZ6rpSxPA9LGsxy7HUbjf2Yteq/zNm0Xy1MGgnuwV+fNnat4
 CQV4UlDSZpDnMrp4HVbCKTKZgZVv7/X9WeRu3cqxs48PipvguYosELJw1j3U7Qe4xtG4KZMzy3+
 gNvI/DsFpEpAHP8bx0xt0lCB9C0pI5h8kGHUyf5tWhlghmNYFsST6lrp6Yz3q/AHuqfTFTbrdy5
 10rxOGaoub1EOhXj3QQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060108

This patch series introduces support for Qualcomm SA8255P platform
where PCIe Endpoint resources are managed by firmware instead of
Linux driver. So the Linux driver should avoid redundant resource
management and relies on runtime PM calls to inform firmware for
resource management.

And document the new compatible string "qcom,sa8255p-pcie-ep" for
SA8255P platform in the device tree bindings.

Tested on Qualcomm SA8255P platform.

Signed-off-by: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
---
Changes in v5:
- Added Reviewed-by tag in dt-binding patch.
- Updated patch 2 as per comment by Mani.
- Link to v4: https://lore.kernel.org/r/20251223-firmware_managed_ep-v4-0-7f7c1b83d679@oss.qualcomm.com

Changes in v4:
- Updated compatible string.
- Updated dt binding file name to match with compatible.
- Link to v3: https://lore.kernel.org/r/20251217-firmware_managed_ep-v3-0-ff871ba688fb@oss.qualcomm.com

Changes in v3:
- Updated compatible string in dt binding example node.
- Link to v2: https://lore.kernel.org/r/20251216-firmware_managed_ep-v2-0-7a731327307f@oss.qualcomm.com

Changes in v2:
- Updated dt binding as suggested by Krzysztof.
- Updated compatible string to match file name and compatible.
- Updated driver as suggested by bjorn.
- Link to v1: https://lore.kernel.org/r/20251203-firmware_managed_ep-v1-0-295977600fa5@oss.qualcomm.com

---
Mrinmay Sarkar (2):
      dt-bindings: PCI: qcom,sa8255p-pcie-ep: Document firmware managed PCIe endpoint
      PCI: qcom-ep: Add support for firmware-managed PCIe Endpoint

 .../bindings/pci/qcom,sa8255p-pcie-ep.yaml         | 110 +++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |  61 ++++++++++--
 2 files changed, 163 insertions(+), 8 deletions(-)
---
base-commit: 563c8dd425b59e44470e28519107b1efc99f4c7b
change-id: 20251216-firmware_managed_ep-ff5d51846558

Best regards,
-- 
Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>


