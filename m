Return-Path: <linux-pci+bounces-41804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23740C75408
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 17:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 802444E9565
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 15:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A444285C9E;
	Thu, 20 Nov 2025 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mCVQr8ki";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FTA+S23T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5B03081C2
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653580; cv=none; b=HaDU/+4QSnGeZ+n8G1xCJo5ReM9kiTx39BPLPDNlVVsgKG2aWxSilXCGIE8/q8tqLZ/b2QvdeaD2a2zyeLaxa05hS3MFSqBg2lLBDR5e0OjSteq09dM7jBSoabHKJzid4eoW1pTRkEctM8FQ+wqfpzq4gYCtfyk8Iur+oFj2hiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653580; c=relaxed/simple;
	bh=DHkHcDpfFBr1qhVfsx+SKCEt4NV8Sh+Ih+xsw/yHQHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=msy0t8FVmlLsmwPCDW6vN5GUSEVmtG2AFkNX3JFUyk013IkbEB0ZN+hZtH2UGJAEXCMfyJl0bagOAS4KChf9bELq44JsUvNKpjGeDCCDP5Gxvrj9zXWiPakv5M2+No7/uP892UgW3RxuhsiXXXuI3i9RDXDkL1eVMDP4wR/Q4Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mCVQr8ki; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FTA+S23T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AKC3ALl4101208
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 15:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=3IfPR70dqtf7v8/t2p0F5dqViUagK7eelWP
	mfqM0ez8=; b=mCVQr8kiZ/atses/M91hPUXVRKPCk795UEFjfEiK4luheeSabqF
	lALfefDGqfquCKBnxhxhwpEpLWiqSBJ71rA/+pK9RPQC2SYHwtcHTPDPMzPgFMgc
	6dEa0wjsVOm8r9Y3rhJT5Q69uKh3hcLhEQN/oGecSYawRoAKF+gdTErN9+3X+KYP
	HdE81ZWKwGEPE95DHs646a/6Jkpg9fsrYqocaLgbgq5EGz+j8DdmEPfDdRGzyA0G
	SchV99vOh72q+Agqc0Wj45xky/oidEGDFrdkaDp/Z6JeqBZuiDeY9yYlUjIDfeOQ
	TQSrGtvKXsXSeLMLLZGUipQ+FqfYW5SuE6g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ahver1x00-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 15:46:17 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b6097ca315bso2121500a12.3
        for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 07:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763653576; x=1764258376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3IfPR70dqtf7v8/t2p0F5dqViUagK7eelWPmfqM0ez8=;
        b=FTA+S23TFS7laZe4ay9Rro773vwDZNy/vs93lmyv0aT/0ryliyYIh9YgitBz0YT46P
         nJypV79IYLXreLBqNIOB6C7rTbeb0AeKlQlUOdkASB4s6IpLasG60aDjO9tat8pna+cS
         YLBOc4XbsV0wrw9llCs3Zd1LbKDGdLMPgcy+7xy8LFLWsquLjUkhM2ZZOFW9UcvS9CMv
         IzTcoHJqhJ7bAwJlNI9ujV5h0R9bmoa9Ea+o9aOVvLVXgUgn3RWiUKuJOtXdIDwupc2E
         6wM8e0uNIygI+5OzWM8+fen2q3KGpmeqURqf3QG6TzAgaFY1rbXBtUm1tc6Nu7AUj5gk
         TmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763653576; x=1764258376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IfPR70dqtf7v8/t2p0F5dqViUagK7eelWPmfqM0ez8=;
        b=r9gFXFu6QIV8Disbtivg4CDtDSGLoUSMmuZX/U0TMhwi4s9RTNhHSE/vUwtkBom6r0
         6FNcjSTnp7sCpV+Nx7THF3GhNFK7LTpnMfH7WxMKU614ALmMoE/X9whyzYKdd9ZIXyzi
         q4TnUfxWa9MLoGuVYo7PEZFoT961nFxH+IseKAEFq05Jw9UMn8Bf55rsk7GvU5jteXtV
         WW+zQ2dGgUmCBBX1DmZbENHGLrywMjiKbOfAEibqzkKlHmzVflYh5S2IOkC2n1gdG9iP
         aeVfBwQMZAFuRepu6N4cENOSnVSv+TOshaklTIsRqLUohabZtzGQvXQss/a24TJn379r
         dseg==
X-Gm-Message-State: AOJu0YwLESY6KZuSb81oagwem7fBbYrEtarNtXeOaxrKQA3n/56MIfT5
	AdBxkt3tkE0TTLZuhS/H28DlCblttq140vAgRjctEqYp+oc08ohUybhtGqB6b8OJRZJz4X9awwQ
	VdrgoPQzyf+AiaI6r6M3tUj9lbRSdHLZkAoN5k3YN89fkD7lKbn0pnbGAzLcfF7g=
X-Gm-Gg: ASbGnctb8ivqB91SjlhApZ41Eqa6f040eJ9iipatg+PmThIiB4cNHFMKAlLN92ILVOP
	36ZGs0bbIAdUxAVTypv1+9tjyizrIqKzhUDhoL+QVhPTDJaNp+IspcuxmP8CZOoFIKkGdYoThrO
	nz5RrazzskGbLpsrVRq1H1AWRDOBOGu53cbNKwQXaA7BfA97bkSiFpOjeuXkAqF/Z1XplSwGtc8
	520BcU/oNt0cDEKSQU8H2L358Z9h3amgawhxdeLJEv2JQt5lV+zAiHTNx0uXwqBu7TVI+cQajXq
	lGj0AIfe5dcY12AHSwVmhfG6nryMK5rhPAh5W2tktgAKvZHLUztCzgpZfszdnx3G8Oxdl7PUEb8
	=
X-Received: by 2002:a05:6a20:7d9f:b0:358:dc7d:a2cc with SMTP id adf61e73a8af0-3613ca60193mr4176132637.17.1763653576436;
        Thu, 20 Nov 2025 07:46:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2Ojcmi6mZMJXTVeV2/Uxavpxw1QUt3or9RFWrZvT7ZI78gfu3KRgIKf2eN/pT8RWR86Jllw==
X-Received: by 2002:a05:6a20:7d9f:b0:358:dc7d:a2cc with SMTP id adf61e73a8af0-3613ca60193mr4176093637.17.1763653575899;
        Thu, 20 Nov 2025 07:46:15 -0800 (PST)
Received: from work.. ([117.193.198.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0867558sm3196454b3a.46.2025.11.20.07.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 07:46:15 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH] PCI: Add quirk to disable ASPM L1 for Sandisk SN740 NVMe SSDs
Date: Thu, 20 Nov 2025 21:16:01 +0530
Message-ID: <20251120154601.116806-1-mani@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZvPg6t7G c=1 sm=1 tr=0 ts=691f37c9 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=UMbGOA4G/0oMlBJKcU414A==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=tmzfovdghLGN2_Oi6P8A:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: sqAUS_pHBFtHqpG9EzjyNgI4bPFtrEiT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDEwMyBTYWx0ZWRfX5T9qref/xJ/O
 FN4fNlJ1elVHmGo/9jFgmdo0t0UyKH7OJmEmePkZy6CMF241mXhrGIZtVmsJSJhJ9WV2tNBg3YY
 hMktR6Z/bTMoXwPIiYeWrTcMv5WQGbeGZFZCAp2U19WzQCUFgAf0M1Mgf2BFFXkuZgBq0+ILfQZ
 2b6Cr1x09rkGJhIYyvRCZIxh3xcy0VtQ4Iq6EjrYz/NMNzdiE00c5UL44G3uPA6a2UjylddoQt8
 g2GhpbA9YeA/FBjRGLqw2Sh3NhBoKz2u+og/OvVXHuPoZk/v3/X5jjqVkEYYHEcGKwUyIy+G1Mo
 1C83mXAxwpel5LcFZwY1K44U1JqTrElT399qb8Il0P1hHCOHcIfZ2Vi5St6Taa5WQf3pNJkpH0r
 X1HbMtbQ37f6dYgAP5fqsmnP8vvqcw==
X-Proofpoint-GUID: sqAUS_pHBFtHqpG9EzjyNgI4bPFtrEiT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_06,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511200103

The Sandisk SN740 NVMe SSDs cause below AER errors on the upstream Root
Port of PCIe controller in Lenovo Thinkpad T14s laptop when ASPM L1 is
enabled:

  pcieport 0006:00:00.0: AER: Correctable error message received from 0006:01:00.0
  nvme 0006:01:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
  nvme 0006:01:00.0:   device [15b7:5015] error status/mask=00000001/0000e000
  nvme 0006:01:00.0:    [ 0] RxErr

Hence, add a quirk to disable L1 state for this SSD.

Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 214ed060ca1b..a6f88c5ba2f4 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2525,6 +2525,18 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
  */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
 
+static void quirk_disable_aspm_l1(struct pci_dev *dev)
+{
+       pci_info(dev, "Disabling ASPM L1\n");
+       pci_disable_link_state(dev, PCIE_LINK_STATE_L1);
+}
+
+/*
+ * Sandisk SN740 NVMe SSDs cause AER timeout errors on the upstream PCIe Root
+ * Port when ASPM L1 is enabled.
+ */
+DECLARE_PCI_FIXUP_FINAL(0x15b7, 0x5015, quirk_disable_aspm_l1);
+
 /*
  * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
  * Link bit cleared after starting the link retrain process to allow this
-- 
2.48.1


