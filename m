Return-Path: <linux-pci+bounces-23201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 729A4A580C1
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 06:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB0C18906D9
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 05:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1010916ABC6;
	Sun,  9 Mar 2025 05:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vl3U9mCf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF9C1607AC
	for <linux-pci@vger.kernel.org>; Sun,  9 Mar 2025 05:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741499179; cv=none; b=Knlu688HzyKI4FjWquh2KLV+0kLgp8B+ixSQyjVA3+UlFgzL4i2w8f9hokyG4hQnMwKvEblXdTVoCcBi/mo0TY+/EgEKxAEQlx71CsJV+wURAL+DCpcBQykMK8NF/ovYCYHkJNqWOy7dEUtuiWmeTWhRHuy8CfO9VHphAmYJJzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741499179; c=relaxed/simple;
	bh=s3bIi9NJPl7GvWtItHLAYMBhKKwwbJNGn6/L6WX4Qbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O/PGwyKKKx/vdTc95qc4jvgjhq4sSl6wTrW+9vBRUGXuXBE5cNifCoHhzdDZGhdZKgmwAVGqUxMg8nLR+io7wTDzviUSRUv1CLWcUqLIdBXJnE0b2SS5hp3vS7WbcSFXX/3qi565IxqhVWumfGbSfkZnjdFX+wtXSAzBkXlei40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vl3U9mCf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5295EWJX030743
	for <linux-pci@vger.kernel.org>; Sun, 9 Mar 2025 05:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XzVhPReZf2sVqu2mJY4+qLpMOX5OmiFM5s04YydtgQI=; b=Vl3U9mCfzSixJZV8
	kR4jnHrcp8gWec++MJIW106LNOzBsk//1OBS7FDHsBrn9/bfsgc41OdOvUIcJ4tt
	pDP5OVCzvLu6l4r8VdwLUnen6X0q91liAAaL2DQbIKit4JwgMmlEmObTLOZsm4fQ
	8pcn5ZvgEU1lq/U+y0gj6hKaHPHgJ8E8kAg0654F5PPskMfcMB5vhhkuXbPzJJdL
	VDMUbjRK/pyaC3iH+g4kbLBmVaGwRcHJBUO8+xitZFPbmNo8zZ3cDmrZ3TF4/Ecu
	zslgnNWTHKHd8pUaub5RP+/hQ5SDKhcfSQd4d0nisF2PithZQX5E+m5JN6+o8dGU
	oaxJOQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458ex6spr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 09 Mar 2025 05:46:12 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2240fea0482so81608735ad.3
        for <linux-pci@vger.kernel.org>; Sat, 08 Mar 2025 21:46:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741499171; x=1742103971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzVhPReZf2sVqu2mJY4+qLpMOX5OmiFM5s04YydtgQI=;
        b=KTewGvecL59S+7RFV2HzWBU/r51X/zGsgHxomHzgQGaiILnEzzv0jpzplDUgqS3Ex6
         42svEDXdoqXCrvsej8SzMNwWsSaVAUafFJRiJs9kB261piDNqMRtgzqO/dDKT/r9WPtF
         z96Gyl5JunfvxtAi72LmYF9R7RaERX3Kg1dYv4C6l+6kgiqRBCswVYR9uB49yqD6kg6/
         ZZC3OX/0oXqP9T2j7i9PloaYjnn+C9TeOyZm7OE8v7vjh6YJr1c/OEr8olQ7t1WbWWdV
         SOiaET3T4xINlRZazNXSa/D5dbKuMV2QKgKzjuGCkXhZFWR3iUFmAvoiKyudWgAuaAB4
         JApA==
X-Forwarded-Encrypted: i=1; AJvYcCVB75tLECvgQDrtppb0GYZOJ15FuZlcbTIQJu40SkrMARwIHsTAMW9bNGtml0Oy/lkfmLZ1yV6kd5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxdV6lZOy/2KRvKtXwp46jgFpERIqyl53aDMN63nzKQtnEwdDc
	LGRn1w+ZPGjR7iDrq9/gNvaX8X6R3Ph768jNNQ2jprDyVVb9YpVkOSN8RMDX/SS4QSoW8k7Gt2k
	N1QR6l4UhdTj2ufNzReEUe2dSY2ddUkTKmGptWgpMcNK5qFG4Uv6ZVkuNk9k=
X-Gm-Gg: ASbGncvg25wmuyxeq9EUxavgWMr8OOMn46kcrfqM5pq1bUm7U5dUXsGqz0Tvgon1m6O
	nUf8p/vsd4PGWDwP0e2xVqK5McUL9VIFFYhg7q0xmPJY2NwYBGKau5C1uq7W9lL/125ABWjr7ve
	/n4Fnn4EYlckH8a6IrJApvFQ7WW+hi1cfgs+VmJap73MZ1IiFogNkJ2bPBBqwWD6VhzGUt4hFJL
	+URnZOozdz67WpXhL5Qrpxu8nS/RaSwNkVFYEmRhosrHPrBFRzeJtaxM1qObTWYZuiySBQLC+o6
	PjVRySBdSRKNNyFEkHXkyEVw1QFbvnxlqIK/ENXJm9o2tIo1YYE=
X-Received: by 2002:a17:902:f54e:b0:224:7a4:b32 with SMTP id d9443c01a7336-2242888b350mr136722045ad.20.1741499171542;
        Sat, 08 Mar 2025 21:46:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3bg0rW7rtDWMCRe7tmBqrbNnxpZ6tLtGVRRwzQJbS3AtIPLP74RL7wxV0A3XhS7GK8/O6SA==
X-Received: by 2002:a17:902:f54e:b0:224:7a4:b32 with SMTP id d9443c01a7336-2242888b350mr136721835ad.20.1741499171165;
        Sat, 08 Mar 2025 21:46:11 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddbe7sm54887145ad.32.2025.03.08.21.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 21:46:10 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sun, 09 Mar 2025 11:15:23 +0530
Subject: [PATCH v5 1/7] arm64: dts: qcom: sc7280: Increase config size to
 256MB for ECAM feature
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250309-ecam_v4-v5-1-8eff4b59790d@oss.qualcomm.com>
References: <20250309-ecam_v4-v5-0-8eff4b59790d@oss.qualcomm.com>
In-Reply-To: <20250309-ecam_v4-v5-0-8eff4b59790d@oss.qualcomm.com>
To: cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741499159; l=2049;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=s3bIi9NJPl7GvWtItHLAYMBhKKwwbJNGn6/L6WX4Qbc=;
 b=D5d0uujyVuCC5S5h345Cga8/2HZHU6ubamWgpIroAAj/12dVHqTSHFlUihS3mr6t/tD0bJZaZ
 EHJVPUsgseAB3dBrih5xvJCxwABnWKNSX2aXGojz+k6jh9+TT5RzUrB
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=G8bmE8k5 c=1 sm=1 tr=0 ts=67cd2b24 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=3vADZrDGUz89oz24Pk8A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: iMPAys4ND45WC--8of6QMDfxW-UJPEP8
X-Proofpoint-ORIG-GUID: iMPAys4ND45WC--8of6QMDfxW-UJPEP8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-09_02,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=714 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503090043

PCIe ECAM(Enhanced Configuration Access Mechanism) feature requires
maximum of 256MB configuration space.

To enable this feature increase configuration space size to 256MB. If
the config space is increased, the BAR space needs to be truncated as
it resides in the same location. To avoid the bar space truncation move
config space, DBI, ELBI, iATU to upper PCIe region and use lower PCIe
iregion entirely for BAR region.

This depends on the commit: '10ba0854c5e6 ("PCI: qcom: Disable mirroring
of DBI and iATU register space in BAR region")'

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 0f2caf36910b..64c46221d8bf 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2201,10 +2201,10 @@ wifi: wifi@17a10040 {
 		pcie1: pcie@1c08000 {
 			compatible = "qcom,pcie-sc7280";
 			reg = <0 0x01c08000 0 0x3000>,
-			      <0 0x40000000 0 0xf1d>,
-			      <0 0x40000f20 0 0xa8>,
-			      <0 0x40001000 0 0x1000>,
-			      <0 0x40100000 0 0x100000>;
+			      <4 0x00000000 0 0xf1d>,
+			      <4 0x00000f20 0 0xa8>,
+			      <4 0x10000000 0 0x1000>,
+			      <4 0x00000000 0 0x10000000>;
 
 			reg-names = "parf", "dbi", "elbi", "atu", "config";
 			device_type = "pci";
@@ -2215,8 +2215,8 @@ pcie1: pcie@1c08000 {
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


