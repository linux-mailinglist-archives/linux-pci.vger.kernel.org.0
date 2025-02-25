Return-Path: <linux-pci+bounces-22310-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E9AA439C8
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 10:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02764176399
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 09:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CCB263F2E;
	Tue, 25 Feb 2025 09:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bOwZPU7x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3642676C0
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 09:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476133; cv=none; b=VBnMd9ZKRr+WKgsEB7BxGzGvXuuCkN2n2B/0Beb7uz1o7vVy1tznaVfmgZADYkEyOLQMFhi75c1huMxJIpsKqrxaqDt7LSDxyuO3d78LfAqCs0Teo+RD9HBvEpiriZZrkZx3lLSbKQGEHT1exECwJWSmfWgtnCmDVuwykawIO5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476133; c=relaxed/simple;
	bh=J9FPWpMy4pUYh48OOv9ER9vlynBjXbryZTb/XXp/SPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LXeOw09F2Dibsi/TqDlx668QfApYPHnESHj2CM7r+3cgox/Khvccto6tgP3VHHnL+apWw56pVP5Llj1WI2oMLzyWf6RvO5GlXUpDCyO9vUKrkRaMWOu+ocKJomhawTb5ElWjSfVeXjbgnILSUd6dHc3x+V8p6HEnUi1NstPpM8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bOwZPU7x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P7msxn003808
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 09:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Id9QzYlVF4SSM5ossbE+J7tOH0yV5nBNwKnqTmgpscE=; b=bOwZPU7xYc6egLfE
	Xof6G0gTn+4RBzOFvOeMRkzLWcFjeJ0vq6gVC07z8jfEr+Sq1GW6dvotTK4/TFTG
	tz66NR5MKb/GdFExhm/8qEbCoJBPMYFdhGVxgdxr4xhO+QutN0P0vbwrrWo4Db/y
	1uiitMUSn/Mh7fG2wsC/OWWscDbn2WGjxr9kFf+r23ySwFwv+gzuL8m9FdxRoDqt
	YQ7NHiXzQDvjZvxBtwxLgxrGgRNH6WpkgzFAYhn+itFllNp5L+6Lmbmv0s+rx2mX
	eBu8RITCmNXrJjDAoTIwAMw1vJdxVMG2TKwhCzHPp125zwkyNWjVMSWkuiFPpZ0Y
	prILCw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 450m3dccad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 09:35:31 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc1eadf5a8so11801211a91.3
        for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 01:35:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740476130; x=1741080930;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Id9QzYlVF4SSM5ossbE+J7tOH0yV5nBNwKnqTmgpscE=;
        b=t9crqxurW5YdT1j+lewVZ0lWF+9IsTV1qxs9pJjIKdajnCNSYYaexGXjAjS384HRhD
         RwFZ878SEOX5XBe9phXjYelR+eFwEJaFUeNQw9LUxS70ehE4MEqgWujyeYt1vTYipVyq
         UstppxQQb/tXQF3OkwUAVcH/M+i6PRED8ndV94HTz5pbzcYdF8MH8JGWUULJSmSzQTdd
         35usuCGa71ajwZQYG8IrgVS3ZxeW18sgooXj1AESIgMQwtI0D6excv8mp4015gokejFh
         3dlE8gATVe2UZYkl1LRljOazeghlYY8SRKY7QGd15s/MdgKsb6uErfgl4VjtgHFTAHXF
         TQtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+AXc5dSKp/9wWNrj2K64r07bMQfQ03kZT+jjlB3mRxIF0Nuf7ywljEqRC2uhbkrhtDJNQL8gYj+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPpUrtrlvLB2/KP0r2saztT8v7LFlgr5SI/p9WPMuyls7D6JWR
	ANFY2VPjsFd5+BZG5AF97Y6Kq+EQL1PHvhg9K4NWSebfzk0g5SB+16oYamICBijIXo7GRYuYwvS
	2I8dgfOuGCyuwNI3slBVfP6AXhhyOGDPWmnxRMLVoN+cPDezzsyV65oLtyz0=
X-Gm-Gg: ASbGncuSy9ARXaiq47ivRemyiiGczftQnF6zEBLBNoEACJXAIeRH6yog1/PwSz2m8vy
	5T9LHFBDUo1mvujz5BNI2KfBFjtrF+PtpleEXCc577F15w8dy/SzFpGeB2mOPVv0n0CwFQgghdO
	pgbqeFFzYY3lRpwlhKiVDz97Di62crJAz7HNZquDM9CX3AHHe2jL/hk0AM3cyVRTAU+IgNG//R1
	ebDmBhj9ewA1OVp2bE9INA1t7J8PiVO6DHlEUB61/DBD2IyfXQfAgpsXI7TZkDV75f098HOxMmJ
	sV3DY4FHmxadEdAG8nWpcAAOr+joGoEnf1trLuWLtfKUph5ep48=
X-Received: by 2002:a17:90b:2590:b0:2ea:5dea:eb0a with SMTP id 98e67ed59e1d1-2fce769a8aemr26694222a91.4.1740476130274;
        Tue, 25 Feb 2025 01:35:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHz30ox0pDjSCuTt9O9dB7MKT/+6sp1RCPDV+Hn7y4uwuJiwd9xcSnmP6sOZP+2onXPWAjN9A==
X-Received: by 2002:a17:90b:2590:b0:2ea:5dea:eb0a with SMTP id 98e67ed59e1d1-2fce769a8aemr26694191a91.4.1740476129901;
        Tue, 25 Feb 2025 01:35:29 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe6a3dec52sm1080770a91.20.2025.02.25.01.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:35:29 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 25 Feb 2025 15:04:07 +0530
Subject: [PATCH v4 10/10] arm64: dts: qcom: sc7280: Add 'global' interrupt
 to the PCIe RC nodes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-qps615_v4_1-v4-10-e08633a7bdf8@oss.qualcomm.com>
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
In-Reply-To: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: quic_vbadigan@quicnic.com, amitk@kernel.org, dmitry.baryshkov@linaro.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        jorge.ramirez@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740476062; l=1320;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=J9FPWpMy4pUYh48OOv9ER9vlynBjXbryZTb/XXp/SPY=;
 b=WOlWMX+kIeY2N8YTUwAYj0VddkFeHag0EknvUTM3VaxmVM236/nVGuRz/ImSIHtcCmYtacv/T
 +cR0HO8dFH7BLzzTFlAbRrRlSOW1jZI8utrAjX1hgYW4Mo2UkayZR+u
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: KnQqPZlBcmavpqE21sUl1UbusIc24iDT
X-Proofpoint-ORIG-GUID: KnQqPZlBcmavpqE21sUl1UbusIc24iDT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=682
 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250066

Qcom PCIe RC controllers are capable of generating 'global' SPI interrupt
to the host CPUs. This interrupt can be used by the device driver to
identify events such as PCIe link specific events, safety events, etc...

Hence, add it to the PCIe RC node along with the existing MSI interrupts.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index b2e2b1f26731..6d71353592c9 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2225,9 +2225,10 @@ pcie1: pcie@1c08000 {
 				     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi0", "msi1", "msi2", "msi3",
-					  "msi4", "msi5", "msi6", "msi7";
+					  "msi4", "msi5", "msi6", "msi7", "global";
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 0 0 434 IRQ_TYPE_LEVEL_HIGH>,

-- 
2.34.1


