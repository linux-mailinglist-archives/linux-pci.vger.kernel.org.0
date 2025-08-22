Return-Path: <linux-pci+bounces-34542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78763B31327
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 11:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41C9624961
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 09:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8E02EFD9C;
	Fri, 22 Aug 2025 09:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Aifvqgzh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5249A2EF671
	for <linux-pci@vger.kernel.org>; Fri, 22 Aug 2025 09:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854873; cv=none; b=FsB672uftHgYdr25uZtGRe5Y7L5AmdYvyQpJ2wW5hLNM/pohBnE7iVTpEAkkQmkEg4QHQ4fMxfG4pTht4rGyhhf3RAY009tbOj54Xj7aAepilR1ok4qdnqRm4ZHQpSVJtoGDIvXggLdAL0yRsqd/KHzvEVk8WasWEwYYudJ8ssk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854873; c=relaxed/simple;
	bh=9CBfmxAvq02vasDOK9GiRt9O37eldSDYJzZR+Ih4/NI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dk6+2lMTVENEncC747q7oQ1P8ous2fgqIuLTOMGXgFf5u/dN/lxWPaJZrEBYj0tmCFJRS2+nF3eOo1uWPGTli6i4+n+xdT6riIxKdrOL3sNBXafiVLcDnGAAB69ycRGWyyIrvlIyrGG3GYJ7E4Cj5hLgL8SN0i7NLD/UbWPF2XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Aifvqgzh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UWiN028822
	for <linux-pci@vger.kernel.org>; Fri, 22 Aug 2025 09:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q4BKfFv3tKNplKEqotWZto9ii2lZDoPptOc//ona8r4=; b=AifvqgzhCiOb2XJO
	QxQOQRL4bKx8YbTfZI50fNgjK/uOAf8cNhPd93U4yR+k/jqHTLEk9vMYgDhZv+KI
	oRU7w8cbig3/dX+GOr7O88VZKSeG+vUdZiJcLu6uBfQd8HEXI446MMCf+zmQ/Ip7
	SHSU9evdievigBs4JiDwq5IDdgAt4gqAbwSvJH6+m3crZaMcMD9KwzywnI59EfPF
	MzWR651S0y2+yrnuLPmA1BcTomJRnkn36HXuto/L0SiDQYmGCj2V8IXsCVyVZ02A
	+tQTRNuOwCmi5aq9rQyKNrW7c6Ad8hDRHvOfK/XsFw4gTSjGk1uEWFH4/l+8hj1Q
	kjT8Ew==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52crpb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 22 Aug 2025 09:27:51 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32326e2f184so3381669a91.3
        for <linux-pci@vger.kernel.org>; Fri, 22 Aug 2025 02:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854871; x=1756459671;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4BKfFv3tKNplKEqotWZto9ii2lZDoPptOc//ona8r4=;
        b=lalW/nwig50C0lKINQn+4C48imwHFDsTLxkHUtxCYNb3Bssm/HOzwJabjkIOiBkPzu
         ve1Rngt7tsY1oA7bniaNNVxrlrEU6srXFxg3wMeJRcBIA2B7LNe68FgTZApTkM1vP35n
         KDCwb5Wvsx8lGTatarULTeC7ARs+GfWtR92SeKwXGOBlLiO8LetHWscynZlzzZopE3hW
         i90HnBdKt6+NjSmONMwjLeQNwyNEq0zvvsKb5NF6KoZkCBc+FolFRR3iIuC53YDpkmNI
         ytSyJupmAS4ECwhE+rrJZwz4UMxim/f+W3RZSlSXwYafdRKTea3FPCEODL5tdsY0D97C
         3vQw==
X-Forwarded-Encrypted: i=1; AJvYcCVUkl7Sk3de6V9eLbE1lO0HAiTXB1ijQDmINMO7T2v93/gHeTLrkJ0cArycaPLExhLeE48cNpoWPlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQg5RUiVD/BkAXoAZOwpXEhYW0aIsn6NgEFRcZ7JJUPdHeTnlE
	YShrllSqQjgSTZsQ5jaUDXGyy3i0OGQlgyHpO31abFpzof/ZiC1YtKKasTfYoOZat/pM/CFulH6
	Oen2lrYDc7fY8rQNhrjGx4A2ZxWIIO9QiVuFW7IbE6BAqJQDCyFtFcuUOTSHf/XQ=
X-Gm-Gg: ASbGnctA0Z2luu1b0lyfbWX8hMhGRDYSaAbkfH5Zv43mzL0Ychq84+6ZASERkSanLh/
	Cn2vL05KyqjtifL21g+/CzfTli7cxIqLXciMBhNNWRKMRoC0UjwNRX/xZGXc1Nzd6DySSc2VXOV
	ZSqEe2tgs+QQUNZvtQSFI0eak2RmunrHqj9aa0jnu4je72PfkkGOWcdfKgRE0seseC8rNRK2Chb
	Isb/+kTY17WTI3K8GZuub5JdrQEEKgi3mgLpwT081PyrRGleJ3DaHfB9exaYjuF0evA8JgInG/d
	zogBZVsXJ73odSFwk80E8VRxXFlo9bIgWNK3l3GyPo4a67nBacMpFwdvK0X8yUl5z6og5ua7MVU
	=
X-Received: by 2002:a17:90a:b388:b0:324:e4ca:136f with SMTP id 98e67ed59e1d1-32515e41261mr2612519a91.13.1755854870495;
        Fri, 22 Aug 2025 02:27:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIlK4D99AL3hLwtqlCeMEf+I64b5jD9J4a/BKrHbWVevdo6V+xZVWh6EFFsUPnS1bL4GOKWw==
X-Received: by 2002:a17:90a:b388:b0:324:e4ca:136f with SMTP id 98e67ed59e1d1-32515e41261mr2612499a91.13.1755854870048;
        Fri, 22 Aug 2025 02:27:50 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32525205d1csm549417a91.4.2025.08.22.02.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:27:49 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 22 Aug 2025 14:57:29 +0530
Subject: [PATCH v7 1/5] arm64: dts: qcom: sc7280: Increase config size to
 256MB for ECAM feature
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-ecam_v4-v7-1-098fb4ca77c1@oss.qualcomm.com>
References: <20250822-ecam_v4-v7-0-098fb4ca77c1@oss.qualcomm.com>
In-Reply-To: <20250822-ecam_v4-v7-0-098fb4ca77c1@oss.qualcomm.com>
To: cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755854858; l=2217;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=9CBfmxAvq02vasDOK9GiRt9O37eldSDYJzZR+Ih4/NI=;
 b=TuRpqCqsTiw7VmBmKck4eZ43pIeiO6WcMzI6tjMM35Nt3gw9jDIMfztWQFJfYAh6RlOSaZcFw
 b4yJDbP1DlIBnBLx8WypcbFATIEZKF6LhMKUvCnNPmKp6R4yged/F1T
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: Y-PRnytpqNq750UKKs9WcqOVP8Je2LbY
X-Proofpoint-ORIG-GUID: Y-PRnytpqNq750UKKs9WcqOVP8Je2LbY
X-Authority-Analysis: v=2.4 cv=Xpij+VF9 c=1 sm=1 tr=0 ts=68a83817 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=bvY3E1ByFFb03tV5gjAA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX+bfmNEn/KcLR
 eQy7ligGAFAAWheIXmdaAwZxjur/tgJnZrsMbklx5A7WL4Evy1CkNqNHxLkRj/N5dX9JBifPXjg
 rjgVyW2p1wzFgWtIzmoMLrmCcggMF9+jT/+GShUDUvXOCtRWqKq6nxhWQtizFFxq9y25Y3hgf6u
 is+LQi13zkQVWjHlZsW26UvJBCDbNq/XtO9Oxql+2xFqvxE4ac4wdyG2v7Pn5cJdwU2iO3bchGu
 tl8kAUaqodsBTqxU4DvgsyM0bO9QAE8uEXITN8MCV2G7am0Uw+FBLi4+T7j03QYVz2dlWIzr7h9
 VJWf/ygsFgpz7PjR1Bdv/L+PQQ7UmSZgJOxBbk7oedRqDC50vc5bt7QGLm5PWYWmwGt0BMkevMn
 +o97dzlBwUPOV8gKunTlhxPXKArjMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

PCIe ECAM(Enhanced Configuration Access Mechanism) feature requires
maximum of 256MB configuration space.

To enable this feature increase configuration space size to 256MB. If
the config space is increased, the BAR space needs to be truncated as
it resides in the same location. To avoid the bar space truncation move
config space, DBI, ELBI, iATU to upper PCIe region and use lower PCIe
iregion entirely for BAR region.

This depends on the commit: '10ba0854c5e6 ("PCI: qcom: Disable mirroring
of DBI and iATU register space in BAR region")'

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 64a2abd3010018e94eb50c534a509d6b4cf2473b..36afeb2e45937f8ad301c55caf296babdb499820 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2202,11 +2202,11 @@ wifi: wifi@17a10040 {
 
 		pcie1: pcie@1c08000 {
 			compatible = "qcom,pcie-sc7280";
-			reg = <0 0x01c08000 0 0x3000>,
-			      <0 0x40000000 0 0xf1d>,
-			      <0 0x40000f20 0 0xa8>,
-			      <0 0x40001000 0 0x1000>,
-			      <0 0x40100000 0 0x100000>;
+			reg = <0x0 0x01c08000 0 0x3000>,
+			      <0x4 0x10001000 0 0xf1d>,
+			      <0x4 0x10001f20 0 0xa8>,
+			      <0x4 0x10000000 0 0x1000>,
+			      <0x4 0x00000000 0 0x10000000>;
 
 			reg-names = "parf", "dbi", "elbi", "atu", "config";
 			device_type = "pci";
@@ -2217,8 +2217,8 @@ pcie1: pcie@1c08000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
-				 <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
+			ranges = <0x01000000 0x0 0x00000000 0x0 0x40000000 0x0 0x100000>,
+				 <0x02000000 0x0 0x40100000 0x0 0x40100000 0x0 0x1ff00000>;
 
 			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,

-- 
2.34.1


