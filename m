Return-Path: <linux-pci+bounces-19006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321ED9FBEFC
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 15:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DC0C16369D
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 14:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33C21BEF75;
	Tue, 24 Dec 2024 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CKGOS2bU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479B81D86C6
	for <linux-pci@vger.kernel.org>; Tue, 24 Dec 2024 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735049449; cv=none; b=ak6EBSPUuKqlKPfSkNbOkE5WwBx5cAlbt47CuEv8QW4OfDA6+ypAZDmZ+SCqw/3WR2uWplOxo0pQfGgnr31EFHGuGJM8FiSh0q/eC6sd9SxRhc4LoluKAsi2JfG1xshfEzIh6SXTFpLZLUZXHUwD1XuGWOH0Vz+9P2lg1n71f6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735049449; c=relaxed/simple;
	bh=Xw5xh82M6lqdr/nghSYHfW5cBYo0ON32Tui2FZ35TfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nTV53OUneXhwe+23SyVqNdoroWoGqgkQTySSTmlcHwvGYCmUQ21sKHRmXQ7juTetLgkZptyuptpuoKVLQRdw5npGDEpEoor71iIqvZirE9+TNh0A7Ur3La/2Z/LQlZWWg5RA4yVd3XHLcJZj0n1nkUHE3HLfdDGbBbCeuaqiGss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CKGOS2bU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BO7oe13030341
	for <linux-pci@vger.kernel.org>; Tue, 24 Dec 2024 14:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	btH923ahnbPdwp6dWib9PdG9Wrn7QfWHcRe4kSFbGB4=; b=CKGOS2bUm1Q6NdwX
	AvhVhlR574EJazVDZ+795oeCrarSR2l3bruLuamdkM/MvjW2eeS1EZGLFBhZCALN
	YWjw/RVsAh31JBzJHDyvf0A2gQiDB9BuoNHcPYq4dOLkMwmeDwddQi/PcKPBj1po
	JkkUW+bzfLWqCroSNaXH/YJsiz58KePh0b29frN86YOGL0jgfMNJh70ynAZYwKWS
	NIO2VTALN132Byr4EqISgWQssswlYIkT3WsrZkOef4UJEqcTNN+BHHYu1I2upHyq
	8ZljqK6Yy7F7D7icUJ6AWov7/Occ1xARaiyVxm1LPooCNJasauKivk4fvg4BeCw/
	2ame3w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43qrx1a18p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 24 Dec 2024 14:10:47 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21655569152so49653205ad.2
        for <linux-pci@vger.kernel.org>; Tue, 24 Dec 2024 06:10:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735049446; x=1735654246;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btH923ahnbPdwp6dWib9PdG9Wrn7QfWHcRe4kSFbGB4=;
        b=FgdWYtVFscsNGAjUe/83zs6QhdHs6MNJb2e4k2SMNiLiNyPTo/CgjU83BDUayve0Du
         429hGY669Sd4CbPIqVIXpnq6TfYTtSLwMSBHjW7HdLuQ/YTnhFMEzJwHCgs0L8zMKCtf
         UtUJH6kmV0qs4etu2thocGfMcGWYdPauVpLCKCC1kCCoAeC/PZl8hhbb4xZ7f70zuiMC
         5yXBsvKRwVW1dRu13ftIlp6dAxLne/pzX2e3vQUQ2KJC/8KjTzGqXTiR8KHIYOXf214f
         eMyC9AS/Yp4Eai3iZ3wEsyvfmOSsXSXyCPg6hH4YUwmke8KjyR8xaY3V9fviSbl6zKp1
         gXAw==
X-Forwarded-Encrypted: i=1; AJvYcCU+67Fkc0XmCn4GWABiZpBUBTUSDWCRpoEhOcrH0k363npI2LBVZM9dJGfIbFqNQYMWz29kxwAqpSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv83BkNsXk32ALUW6hwD7yXaReqph42/rUP2ZefwrStwEepJ8w
	5HbjzJ0iCn6a9ABixIYNQsv5fC+0uGxwdyVaCQMj0TJS3PuZC+hTWBjE1m/u+Ir6AyHjDzlSMUY
	+p4kLvPCtXQVu2e20IEJgHKTLNihb7hHXY9H7Ddt9yv+SdBI7E5rlCh9G6i0=
X-Gm-Gg: ASbGncsZz+RUIjD44ZbnGjBmAU/XfZ0JgIJvpDFN9sUZnfbKcnHdt7iKEQryw0AqP8W
	JS7UbG34cG6GvBYtZKmo3uPhA39n/mrNsuOaeBJBvkyaaRxDL/PsceeE5ot7FMQfm+Hhwu/Henw
	uxqp0Ch1xfMIbwY+sTJCgXoTyVNaV94kXzLIiKaJ3+n1DmA6X3nvADaE2L24uy0qtmMbKPdU4tt
	UPnGp1IXNQ3L+o+FxicXd80Ef3F2h8TOm3XdpNhAqZgtbggBdwW83vOHGySd8I1IMLWaguZ7EuW
	QWQpVxP/EWLlgUWI
X-Received: by 2002:a05:6a00:4487:b0:71e:744a:3fbc with SMTP id d2e1a72fcca58-72abe0957d8mr24589142b3a.21.1735049445837;
        Tue, 24 Dec 2024 06:10:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDqis4LkXy5VHJ0HegLCjeJKr7+Mw7vi/WgX+RX9zCBHdvxftli3uQAVEKHL28nGypxkG9PA==
X-Received: by 2002:a05:6a00:4487:b0:71e:744a:3fbc with SMTP id d2e1a72fcca58-72abe0957d8mr24589110b3a.21.1735049445432;
        Tue, 24 Dec 2024 06:10:45 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90b8f5sm9691216b3a.194.2024.12.24.06.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 06:10:45 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 24 Dec 2024 19:40:15 +0530
Subject: [PATCH v2 1/4] arm64: dts: qcom: sc7280: Increase config size to
 256MB for ECAM feature
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-enable_ecam-v2-1-43daef68a901@oss.qualcomm.com>
References: <20241224-enable_ecam-v2-0-43daef68a901@oss.qualcomm.com>
In-Reply-To: <20241224-enable_ecam-v2-0-43daef68a901@oss.qualcomm.com>
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
        quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com,
        quic_mrana@quicinc.com, mmareddy@quicinc.com,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735049433; l=1616;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=MfhniBxtocnuTilX1vl9/3VUiJ5IIq5lqt/LvaduY3Q=;
 b=/vxSocfEw7wTbjMJRMiQJH6JoPvSAAPGA4gzAeueswEJpneKJCePMZbPk5yOko/MuSmnrMpQO
 +3r3ZdGGa0KATFu/D+cadzRY/o0e5m1eKIBVS/dEMG41EuzHAcsomOx
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: wRvv41_bLDo976ms6jc003xtfXhzIGF7
X-Proofpoint-ORIG-GUID: wRvv41_bLDo976ms6jc003xtfXhzIGF7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=907 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412240122

From: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Increase the configuration size to 256MB as required by the ECAM feature.
And also move config space, DBI, ELBI, iATU to upper PCIe region and use
lower PCIe region entierly for BAR region.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 55db1c83ef55..bece859aee31 100644
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


