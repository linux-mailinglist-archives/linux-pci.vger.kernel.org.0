Return-Path: <linux-pci+bounces-39998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FF2C277A2
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 05:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04DF71A268E3
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 04:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE6528689F;
	Sat,  1 Nov 2025 04:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QpfW27k6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FN3aJZmy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1264D285C8B
	for <linux-pci@vger.kernel.org>; Sat,  1 Nov 2025 04:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761971413; cv=none; b=KNO2PxYIEokTBuYncMAEUyULmrnDVl9gDThPlVI1COM63dFromth1xcVfPIaHfHzvd0SjBA9vuylgbnNvMtJ2fkNGPms/0vy+sX5He9CjUbCIZEL3jtcRqDhPUqINUckc2BSq1wBZ9Dm8tyO7+KYnilZtdEdZWXcKo9fCYLhA+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761971413; c=relaxed/simple;
	bh=VrcDCZTTzA+LINiKOMWUnoZKZnxjToLdODEk4F9zscM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y137DtJpRB/wDkX1XT/sFeXZHXrIR4Mro7s2zPrXvFGP1rZi0RVzUMsf4yA3ETnEHJydyJYYi9jHcnRTwVO3EDML4WEZ3scRHSyYzy4mrIjNP7m6vVVa4VqKiioVaX3ZgZHvAzqs9kruFj6byVXCxbCuZ9Cnj2zjUDtlbx7YrGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QpfW27k6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FN3aJZmy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A13Psnn518657
	for <linux-pci@vger.kernel.org>; Sat, 1 Nov 2025 04:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rEmntNzIgvbd3ZfuZ5iUUv+8+XvQ/yURzasHSY5J4tk=; b=QpfW27k6/ts5uivf
	O0Jv5hlAtu0EzN6j07MkZDDnO/qtug/EcMJcALOCtmKE2IASg9lvaeOtddlQMScD
	kiATUwyQTn1msT/NGI57gx0/PQbk8RK8/BYpKS55Xbht5Im/pKu6bwVMMJC5lbEi
	dcLtnvXFJewtbMhH741KAzTA7IWWI9aViLmGAMY6rAyzty8bPliBy0DZ//kpjoLg
	iObSQwVU4uQSS/FK2Q45jW6V0SpXS6AnHufPSvzAEjLAAOTIpQnHdi3JStnoQRKm
	8pTKt2Kw9Z17uNqRxbB0BRiiDXWU6quRtoAzYRvOBWcp5JAbVx1+kq8SayX72wPE
	D7zKWg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5a9vg2j6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 01 Nov 2025 04:30:11 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29526a0d1afso17468315ad.1
        for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 21:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761971410; x=1762576210; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEmntNzIgvbd3ZfuZ5iUUv+8+XvQ/yURzasHSY5J4tk=;
        b=FN3aJZmyz/SpeTngTqfrbiSexFog9P2ONgd4TeoCSWrOqNwr/vmWlmLcnuhxsXxnO1
         PRU6cRjh4zjDt32BUtYgtCQPiaLh3RLJWlu8Ep/WkDdbmhu9QEOgckTxFDFeMYxrNB0F
         1pqgxSENtR+95WG/gXtYLkQp1rjh7kwct3DLUugQtEQVCj7acAslxxz8gWIc1zc9FBMu
         xDiHoqjSpxpQyoqvNhEyhyRg4hnjx+IzUOmVzsuGUzmxvIXKjZiFE6vDeBVgCJnFtSjN
         fEjmQ3DmB7DZiKzJolEUq85oB3V6HhfDeAvRKF9IZ2kPbfccnRQxK4WBcOJdsSA23PWi
         iJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761971410; x=1762576210;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEmntNzIgvbd3ZfuZ5iUUv+8+XvQ/yURzasHSY5J4tk=;
        b=X5HLYUDTUq49CxsgWgEt4zIj5PI+R8jzsig+sUj0AIoAkvWPDsGhSUzos9uIpTFpID
         5tS32UB6HEUOcMwByBx6aufSikaKqF/+GNp5OPHATmSURZ0VwtQ16b7dSvKSAaTqsWGK
         33xXMCMnC5o0hM/rpu9N0GUMzefOJRIaMs8YWlGPvp8q8XQP4pDqrDSdSr1SZrq9taUI
         yRuGiWhmATXjjoONMFFQvGGySCwrVqZXIGD69Ba/LNt6kBNEZ2HlD0/VA59xiBwpJE7z
         jW8qQuTeDe5s6SPh81nvuQ73lreCknySHuAIUVv4V9iThEPB/ipW9n1RksnK9g76zco7
         j34g==
X-Gm-Message-State: AOJu0YxMBddTofPkSBHeoD1Qv8wqNlwzz/6RJzkzj63SAO1PNpyvdYq/
	zVLAxhFWIRrEmHwf2uQW6kAma78y4uIoihlF43ca230XT4HPY06GJ4haPzNebMn5FHl7+v3v0a7
	q4Wtpn5c4toIAhd2Dd3TxRJaPO780ZkJI1FEUjxzS+csBzSDgyCPFVlb4DZThp4U=
X-Gm-Gg: ASbGnct6waPJNQOoZcU3tBFZ29hZrxnTR58UAB9BtGvCmLD2oCKy5E/fFTr5JpEuLWP
	C5Xv9YT5OeVYss6z0AvYX+Yo0r4gnk0spBOGvOYGm1EYz9siqe0+yNYbnCcUXoRGbbIB1mKe2Sa
	MwocguGRsLt3xRvNRSHJjGLPG0soMse/Yg4edgdWYXio1TvQE20Bg/W2eS/I2szZpG/VUJZvHo9
	+5C1umwibuaUYWE2gk/fWccpooy3B7B3E1LCqWqzi0epJ9icpAVEPcOuN5aoxQMWg2dQM2wsLHW
	6mjYHq0F0BUTwwx46J81dgQDzrExupoRy9Rlvf5bSKy18LJIbzKrHK/FEXKcCYZd88CrzqQ9yVC
	H19i1taSwcaZPuiTl0k+1q1F2
X-Received: by 2002:a17:902:f602:b0:295:28a4:f0c6 with SMTP id d9443c01a7336-29528a4f5admr55696105ad.0.1761971409403;
        Fri, 31 Oct 2025 21:30:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVwZ+kekou+fixvG0M2Vz/vgve/y1Kvl47T2KxfST7IaCXT0xX2tM2WuyIGokWq2NTuaVOZQ==
X-Received: by 2002:a17:902:f602:b0:295:28a4:f0c6 with SMTP id d9443c01a7336-29528a4f5admr55695065ad.0.1761971408819;
        Fri, 31 Oct 2025 21:30:08 -0700 (PDT)
Received: from work.lan ([2409:4091:a0f4:6806:9857:f290:6ecf:344f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268717ffsm42273285ad.2.2025.10.31.21.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 21:30:08 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Sat, 01 Nov 2025 09:59:41 +0530
Subject: [PATCH RESEND 2/3] arm64: dts: amlogic: Fix the register name of
 the 'DBI' region
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-pci-meson-fix-v1-2-c50dcc56ed6a@oss.qualcomm.com>
References: <20251101-pci-meson-fix-v1-0-c50dcc56ed6a@oss.qualcomm.com>
In-Reply-To: <20251101-pci-meson-fix-v1-0-c50dcc56ed6a@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Hanjie Lin <hanjie.lin@amlogic.com>, Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        stable+noautosel@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2433;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=VrcDCZTTzA+LINiKOMWUnoZKZnxjToLdODEk4F9zscM=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpBYy9XwQb731Bpv0QhX79igT+SZRYiSopEBiJ4
 W2XERk5uCGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaQWMvQAKCRBVnxHm/pHO
 9Zh/B/9owuOX+V5eWryUwchPVToFhqEvoXpFH2c5lRHxiSrUbe1aaJoP2pPhP1t0wqK49vmI5o7
 UVb8r+OdIcFl+ZF7Kn0gr4dOv3xXCbYKb0+vgmdMxHFTZUUhzt5EMnZd0S1oobqV2hJvmpbMWEn
 bx1QA9Xu9f9Al2l0hUZQm2SrCJPKqW3c2qQbEetzF5MVp4isGqYffd4VI0Tm9vyS73l+60be+2I
 +bnZiDs4mYAkGHM79aBXBZUizbn2qYhm4dP/kPatxE9ipGiiTivqjIfiXR7s8X5mwSSyqM/fvaa
 AjG9aS8O3ekS4FGuOqfCEscfcTNjaHgzg2ieFHftf+S8v6Sb
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAzNSBTYWx0ZWRfX/FYOQcpnDmKc
 ST32bSUOfDmuql1s7bUAJW1C3dMtof9nIsKBo0Th6lPr/i/SQ5vtUn0RH3wyAgFrdmMcjGZwc9l
 X1InzWL93i0dTbU1ihl9t4q8qfTWf+anewmj3DKmNVJA05PUO0eseKSmHifdZjOhqQ+1o54/l9o
 tkQTQR1BT14wi9gC0xYO84ue/D7R2IEOM3El0h6BbpO4xfsGjT0biLa2afEahhX51d0W+FqO65v
 w3diHk4y+Tf4ap3jQZGjgkSwXyQsbj/YICmO2SKHLx573673C+9lTDrsh86A5xk+vUAvebwW+KM
 VGVd6jONo8X1ZMWgIrGG1m1vdNJQzyHK1BuP9YRcHP8bRZ4Eu/O2LEfFRqtuR/BQ8qbPB+UpLV9
 /TXjbL6fGJ2eM0M3bXVd8UZtAC1XKA==
X-Authority-Analysis: v=2.4 cv=c6CmgB9l c=1 sm=1 tr=0 ts=69058cd3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_UaV9RfZZwOaPWMAg4wA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: PTwuVi5qb3M76WdEKWBwMzuF3sGinsIW
X-Proofpoint-GUID: PTwuVi5qb3M76WdEKWBwMzuF3sGinsIW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511010035

DT incorrectly specifies the 'DBI' region as 'ELBI'. DBI is a must have
region for DWC controllers as it has the Root Port and controller specific
registers, while ELBI has optional registers.

Hence, fix the DT for both Meson platforms.

Cc: stable+noautosel@kernel.org # Driver dependency
Fixes: 5b3a9c20926e ("arm64: dts: meson-axg: add PCIe nodes")
Fixes: 1f8607d59763 ("arm64: dts: meson-g12a: Add PCIe node")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi        | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 04fb130ac7c6a498f7e8029aeaa7e511cbfe815d..e95c91894968b2c8b3b8e96a5f5e85cd60f3e085 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -208,7 +208,7 @@ pcieA: pcie@f9800000 {
 			reg = <0x0 0xf9800000 0x0 0x400000>,
 			      <0x0 0xff646000 0x0 0x2000>,
 			      <0x0 0xf9f00000 0x0 0x100000>;
-			reg-names = "elbi", "cfg", "config";
+			reg-names = "dbi", "cfg", "config";
 			interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0>;
@@ -234,7 +234,7 @@ pcieB: pcie@fa000000 {
 			reg = <0x0 0xfa000000 0x0 0x400000>,
 			      <0x0 0xff648000 0x0 0x2000>,
 			      <0x0 0xfa400000 0x0 0x100000>;
-			reg-names = "elbi", "cfg", "config";
+			reg-names = "dbi", "cfg", "config";
 			interrupts = <GIC_SPI 167 IRQ_TYPE_EDGE_RISING>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index dcc927a9da80246da43391f9f90049c3570f10d2..ca455f634834b5a52db8ff4e6ebca35a87ea17b7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -138,7 +138,7 @@ pcie: pcie@fc000000 {
 			reg = <0x0 0xfc000000 0x0 0x400000>,
 			      <0x0 0xff648000 0x0 0x2000>,
 			      <0x0 0xfc400000 0x0 0x200000>;
-			reg-names = "elbi", "cfg", "config";
+			reg-names = "dbi", "cfg", "config";
 			interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0>;

-- 
2.48.1


