Return-Path: <linux-pci+bounces-38965-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80336BFAB0B
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 09:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F029A481FC1
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 07:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4C02FD67F;
	Wed, 22 Oct 2025 07:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KZMVnFny"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EAD2FD668
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 07:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761119535; cv=none; b=J+1UH8BnHLudyBQauRdUQYBUG6WoXTdYZ75DK9s1+dXpZ8uQTsFnmsfJK87UULl+AyqQyVox3JDmWF1xzdMbdPcvyUFtTpEuDp5KX1a53TaA5jRFosC5hjPYKmT34wLdL8XZ5nBZpzCkhrLQRahNM90FFkk+OFC83lMzmLsEJGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761119535; c=relaxed/simple;
	bh=J/90TQbFdCgoh5WWkO3h6Le1FNJsf9C3aI6j07Us/Zw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f9st0/krXTCKPKoXZicBkqBCu4/Aj0x2CG4k+epMrGkLLZLyWg9nxPeKKcyKdoIOAwL1gBT7WwBgn8cppTgS/W664zfJdlDjsKXMBPmskBYX0f4YXQn69mRVQsBIyJ4DK3SF5zx+rxSIJS7ELMoXk0yAmWtgBUod6/Zb9KEDSmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KZMVnFny; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M3EraY025477
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 07:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=DPmvEIE8FlpuHaMWc6yWJW
	SlobjKsCAmEGxrwVOFSo0=; b=KZMVnFnyFxXDany6UgqO8LmgciO10tFG//aHNw
	9AOw68AQgmsfgYjOeObdzI/u6NO96Zr8f2fehgHN0wrlHzRmlbPRjYANaNSu5Hqz
	EWrEn6//gbVeb47fUuB3/+iY7O26Q1noU8tGO5+CTXLYcciDZhpXxkovMhEYaQZA
	VUkzK6zl35gviEsKCrs3iRG+NgsB2gp7inJskrr3WXO3bx2BTYfbE67X2y5Yc/oG
	ZaMwN8A+IyrYDlSR+v7cSty+BVgOy8BOmzLGQHNf/7NtfwHF52LHFhamDad6efft
	2O6QnSV/y6mcqspqvmGS5VEDJ67u3yu9nOkT/OXqOjd1DYGg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1w83tpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 07:52:12 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32eb864fe90so1932332a91.3
        for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 00:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761119531; x=1761724331;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DPmvEIE8FlpuHaMWc6yWJWSlobjKsCAmEGxrwVOFSo0=;
        b=AB/aOzbYYeIgNGiX5vatcqc7qAo8YaG0IsU52SEeDegaAGe0sDR8PaMWJu+enADmnR
         I9LRebkkDTgOQOCFGF7vQNjwUTw3E1R8dKYxkzDMnVeigbfAurNKm6ZM4E1xTuDyP2Tc
         LbXZttOllo745rne1IQTMtOlSzMcG3MtqpSNkE1dsq6suEAoCIrlulwC/qSyo00LMOCy
         WdrVdGZux6mLhXAnoH3H+d8+MBvoqn0qkGrafEADBbXnIdeNAKqZYO584j07y8IIz9fC
         DoTl7cxnVp5XkP8eBate3fhLM5tVE4pmOXCkO60x+clzt/NSaEn0agimE52L3lqVfrxv
         OGRA==
X-Gm-Message-State: AOJu0YzPYraAsXcQHtwsOmfUGjnvA8sRnegJiYlAT/fQaWU5EBv8npE+
	nxzPeMbP2ILP6DAU6YXDH69WGGIaMtKx44uucLSsU00mEsr/WN1f12rGhues6CxFBqBYNzsifBm
	dOcz9n1I5EUODjf9LsI4wiQ51hVffVAQqlWCyZnntML0/WI7YypuBEcb064A8er0=
X-Gm-Gg: ASbGnctPOLq2AebeMpc3DadFFAUOrvJck1kKnAV8jBWkAAOlYX9/kFXitwYPHjV6+VK
	TX/+ihK25p1WIhoZpKUa5m6zGncpCJGqLwEObazGnmYCda432XeFu3geuC6Z12GIQf28HpNt/bU
	Ew0l4gEuWfLyGbL6KbPZD/BX2ODpIznfX5ODUyCgB82x3lVOZeawDlLAxtk9yjp3AUulT2b8wcT
	nuBQUAjBEH8uCXbgouY8tJxMWrfF3nqYrYd3gLSzSxFEE/Wyw1xkzOkHtgnHuDFq1WLNdG3TJ1x
	ho5VdVPMGzunDwrYt00Z1gRC0xQFqDYWShg7NAXZf3RkzRRRMeuF6wx7PpARgwFQqL0H/Y9yHnf
	ewSQoOx7Qeq6DC3Em2HAwH9f1bwPXcv9kEQ==
X-Received: by 2002:a17:902:ec87:b0:24b:24dc:91a7 with SMTP id d9443c01a7336-290cb65c5a6mr230159875ad.45.1761119531222;
        Wed, 22 Oct 2025 00:52:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4K8gARg09FJVPfkVnVqfI6o1el0oPDHVpa0x9imn1Oorz714MewTKuS4CSpiq726izRzsJg==
X-Received: by 2002:a17:902:ec87:b0:24b:24dc:91a7 with SMTP id d9443c01a7336-290cb65c5a6mr230159685ad.45.1761119530739;
        Wed, 22 Oct 2025 00:52:10 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fe2c2sm130962275ad.79.2025.10.22.00.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 00:52:10 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v2 0/2] PCI: dwc: Fix ECAM enablement when used with vendor
 drivers
Date: Wed, 22 Oct 2025 13:21:59 +0530
Message-Id: <20251022-ecam_fix-v2-0-e293b9d07262@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB+N+GgC/0WMQQrCMBBFr1JmbUomNS248h5SJGQmNmAbTTQoJ
 Xc3FsTNh/f4vBUSR88JDs0KkbNPPiwV1K4BO5nlwsJTZVBSaZSoBVszn51/iX6PhKSZBiSo91v
 kqrfUaaw8+fQI8b2VM37tLzL8IxmFFK53xnQkmVx3DCm196e52jDPbR0YSykfVCVdpacAAAA=
X-Change-ID: 20251015-ecam_fix-641d1d5ed71d
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Ron Economos <re@w6rz.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761119527; l=1313;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=J/90TQbFdCgoh5WWkO3h6Le1FNJsf9C3aI6j07Us/Zw=;
 b=vo34Dz7sxlIswBIIP74F0bWqldDvPxdaL8dMP3smt5FIhASG9kExka7DTZX35BoMortsAmyQJ
 qf+N0V9qlR+AJOx1rVcvDZOnLGc/MX6KevnRq9tFQu+O8eFHCbfKJzF
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNSBTYWx0ZWRfX/1mCrKB+Lzce
 S+zvkSeGb0PW56gDeiPrdz6hXy2xR1GXbqBpT2EDuWGVBWysQ5Ww2k/7IzFMTcZyG/JKIth0MiZ
 N8xNpfBal3TMrq+ErSVDcmx0vSfahY4Aom0pq1sBpLnH8I+r66zilOcsO7H79muaR5+lEZ6loM+
 vHf8o81TU3PyaT/6xr7MDAiLzwz64n/hUo3Fs0G6DUYHR34QVCupIicUrA7unQzMlpZnM5SqKXF
 0k/rTShIQNt3WwkI1Vz6jl30OrB39Z/exOVIXREU4yIxcMgsAbPzfAwaHb5Prw51RfdZZXhk7bF
 ympVsRGPDC/iNTvIsxPnDz2jqgPnvg+Vz1+TDGHGidKdvxkpw1PJkF6Oc1HYPa0WMMzgIRexsXg
 qY+0Lx1H8jJzUqNkV5PVM9nTtoz64A==
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=68f88d2c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=qIbWdXD6M1inJYch3NYA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: tD8YhPRdz75DkAYz7yn_c7AeaSvIDP8H
X-Proofpoint-ORIG-GUID: tD8YhPRdz75DkAYz7yn_c7AeaSvIDP8H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180015

This series addresses issues with ECAM enablement in the DesignWare PCIe
host controller when used with vendor drivers that rely on the DBI base
for internal accesses.

The first patch fixes the ECAM logic by introducing a custom PCI ops
implementation that avoids overwriting the DBI base, ensuring compatibility
with vendor drivers that expect a stable DBI address.

The second patch reverts Qualcomm-specific ECAM preparation logic that
is no longer needed due to the updated design.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v2:
- remove bus0 is for root port always(Bjorn)
- Link to v1: https://lore.kernel.org/r/20251017-ecam_fix-v1-0-f6faa3d0edf3@oss.qualcomm.com

---
Krishna Chaitanya Chundru (2):
      PCI: dwc: Fix ECAM enablement when used with vendor drivers
      PCI: dwc: qcom: Revert "PCI: qcom: Prepare for the DWC ECAM enablement"

 drivers/pci/controller/dwc/pcie-designware-host.c | 28 ++++++++--
 drivers/pci/controller/dwc/pcie-qcom.c            | 68 -----------------------
 2 files changed, 24 insertions(+), 72 deletions(-)
---
base-commit: 552c50713f273b494ac6c77052032a49bc9255e2
change-id: 20251015-ecam_fix-641d1d5ed71d

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


