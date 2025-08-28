Return-Path: <linux-pci+bounces-35003-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B142B39CBF
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 14:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903831C82D78
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 12:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A77A31DD9E;
	Thu, 28 Aug 2025 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ErOIrdgr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088B331CA58
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 12:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383068; cv=none; b=ZXuDFqMgB5UM5unB3tciI3Xy7SrVuquEdy0GR2Eyybbq8qRmzug7PhkssHuQRHXNYlqHZNGYRc6qxNBBe/cRJRNlU6LLnqOLt4ZvqYS8a01/aPKR3BGz3OrGY1ZFCcKDpCSPPHhiCXLQDh3KnXmQYhmVNGw1FoRzBMFnDLe6ZHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383068; c=relaxed/simple;
	bh=tq3IuL7wCC29pby6qPkuO/RCGMkeEsQAVfNt3fPCWAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eKfVv+ro1g/kl0qjMDDP8TyThmAlhq9X6O2ItDzsNh1iTt73bRvZsKoW/W4awc8GhGrL9dQAleYS5G53S60NBosPYw23mfDlew1TeTregNzWJLUFFxlbWH7MNc3enacQYV/l6pK80xhV6rpxC+3fGggjMU6gYNWq3kde/4cfbnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ErOIrdgr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SADxn4007076
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 12:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PhePwHpEAaOWHj8GxjUD4EtV9ZXNnl5MLU1KHln2exc=; b=ErOIrdgrwTfY3tXl
	y32VFyZbmwxIbH4eBcHEKhNvVwFOlvexYYFNjCmIVygluAkXDzMaYceLP/rHqREb
	JaWv6kBmuIPvNogTo/f4h7yK3G1LxtA3D1wet2NBmZ6ttB42OFkzLhEBE2mAHFah
	drXmeEGI8RZ1FRGXMdrYTu1JHaHQb94GJX6ARX+mKL1n4JCayKnXyFWl+XT718sL
	JzcMzkysTw/etmKG23Sq1i9OJwSkAQw6+RxyB3O7os0Iujokrdk3GGWdEl1z11Jy
	PtmWNqcZTV6feLg+KPUFUjEYFeCYljRKteXouith/glPoRUa8JI0sL3yXMqZ1iJ9
	o1pyzw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48tn67ga5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 12:11:06 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4c3547bd78so729184a12.0
        for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 05:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756383065; x=1756987865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhePwHpEAaOWHj8GxjUD4EtV9ZXNnl5MLU1KHln2exc=;
        b=kOvePSeoIC/Benv0nX//yO6NfLNiNI1R0O1k3bPtE1D1SrFrkmvc1G61BwGy7yTD3p
         N4TvMNmP5qWljhcwgiUyTMpalBy6hVg5xiseVpHCb5R9L2YAAWUcGJQd6bm1Y2M6MdL/
         mEDFN/+4JIM7jc8iO/00c6PNOnehOnijxn8vNUrdia/nQnddMhhPcL7gBU2ScPaR1kK0
         R/DXMjECXv58Kb9SAyhwSa3laVQL6g2TxViW0dXprIeH//E8fnpwnBLeKRzlODUxZ524
         Eos8ARzMtTMoTltnRzBrRWPPJVFcFQI6dZVWe+dpUShfQTZsKFy1BHlJxpLQvoN37g9N
         e/dg==
X-Forwarded-Encrypted: i=1; AJvYcCXbVbA3ofwdd+ZxcMq0UwaJNcvl7FGxhlbG43181s/kCnc5BfXHhk22etuzK4MorfzagaQhO1qDlb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+PO4Wi/F7Agxn8I8epqwQW/wKxpmIpy/LPn+s3KbjXnQS7whE
	EYbiyftXd992xlKQMAhfOycsMiLPUDb2/jvKnogYcF5BNtGxeVjr/ES/zXIFYQvQPfaDfDOATJD
	VB0yU5Q9pe7SNAb7VLGNrrqAFSTAwcSQ2hGwwlUgZQ2koyQc9kfPYzqpwR/c9dC8=
X-Gm-Gg: ASbGncvDtqLYoVv9XSB/n2anB0vpu5Iug8guDEnettAaTIwsA1c2FIeMD2bceZbBvKH
	1Q0vIVjJ2SH4s38DwU02epl0bW/5dUHpewnykAUyNveKwVbcvCNh71J4iZej6UD9tyPPf/dAOdj
	+EYrQjVaA3iEafQuRed5XA8sPW2d57YIJ4xGKR8tkui+CSl1vJo0YMf4zKXDZhWC1L66X3SRFY8
	TLRenOX7Ln+CHdvlvfuXhhcjVrZOvJUJj08SmaCNTVYI/Dqq4sCn/HLUjCZyik71nU0syUMKj/B
	AkJ9A2B4zpWqNxEv2qJAubC1KbVyTzQPc6wW7a21Ou/Gi+JNVtIZJl8pG6MRj/p564tppRVyUPs
	=
X-Received: by 2002:a17:90b:3d86:b0:327:c934:e5c5 with SMTP id 98e67ed59e1d1-327c934e9c6mr1060054a91.0.1756383065269;
        Thu, 28 Aug 2025 05:11:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzP2wU+CuvXGok9xOucMGBvgqE6LOekvba8Nillw6XuZ8T4Bb1geXsLXy7ey8/aUya6rM7Yg==
X-Received: by 2002:a17:90b:3d86:b0:327:c934:e5c5 with SMTP id 98e67ed59e1d1-327c934e9c6mr1059974a91.0.1756383064683;
        Thu, 28 Aug 2025 05:11:04 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32741503367sm4019070a91.0.2025.08.28.05.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 05:11:04 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 17:39:06 +0530
Subject: [PATCH v6 9/9] arm64: defconfig: Enable TC9563 PWRCTL driver
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-qps615_v4_1-v6-9-985f90a7dd03@oss.qualcomm.com>
References: <20250828-qps615_v4_1-v6-0-985f90a7dd03@oss.qualcomm.com>
In-Reply-To: <20250828-qps615_v4_1-v6-0-985f90a7dd03@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: quic_vbadigan@quicnic.com, amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756382994; l=898;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=tq3IuL7wCC29pby6qPkuO/RCGMkeEsQAVfNt3fPCWAQ=;
 b=bavBQG/YKidnGf9CN7mjFGyftQOzvdExbFhBzxCH8ftSQSOg9DBCr7nJhMBt8rLSZldn4ZdKy
 nnFvOpxZRgTDmfvPkhinzKckUm/4tsly1FDV1zqyHupee0Wu6jTglxx
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA4NSBTYWx0ZWRfX5zeUiuFMT5Ns
 gmc2GAGsInYXImqH7hSix1D7QLaBY/LfyY0t1d/DQjRommMealVIb14kffFJ+u0CcHCxlHVQo2h
 LSmQpWSD8DRW0Y0VFH1eW4FpT6WpvMLhPAa7HyDAJbfoqSslm9xymwRA+LX6qsZsH2ig7C1jr8+
 C1rXIlyFeNfUMPiGYPhxaXEgR9TZTk0h6ZqQTcGzFbqoh+7/DYAUcKkQ/E+8s/J4B9VlyLY4Q1Q
 NNTEPjNUE7QAPUY63qyGEA+/KeDUJjBZ9t0X0gfyik6itxQEY7golMI8Wc9cTqHitGcOE8Hdydm
 3P8d4U34zeQ8rYP3u0475KmnHi4WdNTzzKt0zsgwaTzIsSsW5QWUwfIoZgCufIA6ghGpIYS8vlj
 GgfJl7+K
X-Proofpoint-GUID: 2KuUVNRybB_HQh361kef2hcbvO15Jk1s
X-Proofpoint-ORIG-GUID: 2KuUVNRybB_HQh361kef2hcbvO15Jk1s
X-Authority-Analysis: v=2.4 cv=P7c6hjAu c=1 sm=1 tr=0 ts=68b0475a cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=5PcvmwL3LSb495PBagkA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508280085

Enable TC9563 PCIe switch pwrctl driver by default. This is needed
to power the PCIe switch which is present in Qualcomm RB3gen2 platform.
Without this the switch will not powered up and we can't use the
endpoints connected to the switch.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 58f87d09366cd12ae212a1d107660afe8be6c5ef..c4cc2903c13c526168b592143a81b5e6333b6c07 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -248,6 +248,7 @@ CONFIG_PCIE_LAYERSCAPE_GEN4=y
 CONFIG_PCI_ENDPOINT=y
 CONFIG_PCI_ENDPOINT_CONFIGFS=y
 CONFIG_PCI_EPF_TEST=m
+CONFIG_PCI_PWRCTRL_TC9563=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_FW_LOADER_USER_HELPER=y

-- 
2.34.1


