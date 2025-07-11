Return-Path: <linux-pci+bounces-31977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0418B027C5
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 01:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC8BA478D7
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 23:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3011C6FFE;
	Fri, 11 Jul 2025 23:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gGiwmUys"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EF1225768
	for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 23:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752277398; cv=none; b=Mp4Qz80eAHxUsCf3iHxd1qtfziSz0nt1krGcZym+HdyIw1hURFqUi2b46RGOIVVDODig9SuaXGq4k9AG46V0Lr1Ydo+7mzxr60JL12yDso/2oOVHgYP+AsIgsMUTGJ0Y0DQBqZX7ysMdPp7qqzMdFs8m4fM8X8UeDFdVQV6hdPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752277398; c=relaxed/simple;
	bh=o+TxdKplz7IMXK+MXPpI9M1keWjAcNlhY5NAxQmThus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WyIEHmPEXFnV0ktqomTPTmh1/s8h6CLk2gmsnrMHKE2SkoWFX+0ZL48af+0qY8JTYgfWcYbgq1+zH435/y/9K8HNhJhH8L8CGS6YxLkNKgbOK+sSeH3IRwkOcRc+iDbqG/+OYomIl6+NJNlybEck37kI93XhAqy+msXhrMDn4Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gGiwmUys; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAv4Gk026139
	for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 23:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+OCt6BMCpo5v7w/ZAICBixmXIHidhh0RrXTKdHTXIxw=; b=gGiwmUysF5M/RsNp
	QvbJMX3YsNt/rPD53/kEILaFzH/5UF3Aysw692cwQllFe5TI2dZt5BQ3LA4awlaq
	hZlFYBs3olkLuZrGJ7BbhDU4/cIdCcQwhJ5DZ/4H663wM5Fu4tlhvBL2ARm6PdyA
	AEDrKKybErlw9w45qtnriHtdrneHKctfm2HEhQsBTXflP5MjizIESqoh4ydBMuaM
	JokfMzOj7TNshoINkXak6TQZuHdf77nmbHW+EkU03nwsgZz+91kHDtvNsO4iuOl1
	YofSg4i53NWUnJrGv6Ff8dhBQ1w/s47DEZKtFGHRT9oGB6TLIBGjXluRr3cP4m0W
	hr/c4w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47u1a2htcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 23:43:16 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-74ea5d9982cso2030607b3a.2
        for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 16:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752277395; x=1752882195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OCt6BMCpo5v7w/ZAICBixmXIHidhh0RrXTKdHTXIxw=;
        b=k/PQ7iQuUFEMRpHxABAVCtbyFDwxHVG2aB5PKdLY6lZkp2vPX4o2J60NNBEXDA3+zb
         zzd7C3lDoyYtpVuaZH9ZmMhYz/BaVk5xW3uAaLxajAVCctOJk2ZUdy8TpB1OSJ3re6xw
         QB00l3YqE4zOMpvYdeZM+wUkWSz5LF8AgLhP3f1HsHv1lolcZHqj/JuIL4DWdKpZP41D
         u6/1iQJad60eERgQ4YwjYgOO6UyoPHdUavPeLray6j/UJm4ASH3Gd2o0OZW7RJERqT6k
         w6GcSSuLnYmI0tjO8z6k3Y8xHV676J3eFwDXa36qALNG9yE2194CqZDDFh3G1pJ20p9L
         V3mA==
X-Forwarded-Encrypted: i=1; AJvYcCVWZWzuEQucLSV8rQRyn4WeVscaDDW3kgxyrNe4QcS+8CqJMpuZfG6Vgww277988K8qKA+3p5hESLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK2dgoi/hojFlxwpMu28RrHD1EM/zjZ14EB3MCTGq5a4jQDCBx
	1qscZ8IvSRKiC8XMMu56RguT9nEU4Ek5sXaEhI1hXiMZ3whECZ6de2xVoXTNfkIZbb6lH0ppUg1
	AJLeSGszHT4gF5oac0pAzPvvpPt+FDGdcB23YhicmSCzHADGkNGuZ//ZtcjkTrLI=
X-Gm-Gg: ASbGnctWIMNPtR2ulZBIF+ec+IGmLC5sZdDk96ZYbH4iS9OQ72n0VwC08cffHwa4+Y5
	T1ZwJa0zs2XLWVbEkrlCe717LQg/2FCbi/dzZ3IB8e40dPYyey7HsiyG/3XSQMSsGSrzZGUmHY3
	0hgeUMToWfSMgTmbk4PbmBKleNbfKedfWi4V2uG4BV0aHRrDNzRddJZ9DkhQG00wB1yPtYoG+rN
	UMFhExKT1XTav7a0wvmVwBa8aN4Y0ZwaDgRGw6mtyESjzb/CLB/tRbKQfRsxXIgcBCVNTYVnUAC
	H8PcAxTemuENw+VCG5IVuna37zIB3WQfUqKt7GR/BsmNv/o73u7OdTrcZx2d4CzOLzIa7qgC42M
	=
X-Received: by 2002:a05:6a00:178c:b0:749:421:efcc with SMTP id d2e1a72fcca58-74ee0baf892mr5310899b3a.5.1752277394908;
        Fri, 11 Jul 2025 16:43:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXejt1aDsFNoUQC63cutRdVOsMdt5NZCZV6i0r5vMKv23uKSleEdP9WbHLGSbKiYefG+m3Gg==
X-Received: by 2002:a05:6a00:178c:b0:749:421:efcc with SMTP id d2e1a72fcca58-74ee0baf892mr5310853b3a.5.1752277394266;
        Fri, 11 Jul 2025 16:43:14 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1a851sm5869781b3a.82.2025.07.11.16.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 16:43:13 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 12 Jul 2025 05:12:37 +0530
Subject: [PATCH v6 1/5] arm64: dts: qcom: sc7280: Increase config size to
 256MB for ECAM feature
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250712-ecam_v4-v6-1-d820f912e354@qti.qualcomm.com>
References: <20250712-ecam_v4-v6-0-d820f912e354@qti.qualcomm.com>
In-Reply-To: <20250712-ecam_v4-v6-0-d820f912e354@qti.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752277383; l=2217;
 i=krichai@qti.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=o+TxdKplz7IMXK+MXPpI9M1keWjAcNlhY5NAxQmThus=;
 b=ZWca0Ddc7W5T0rXsIYEqzD9JUgbVM3QMnjkdtO8USzHrEMvozJ7XuYmNl7Y+kfD1Tv2FYNSEw
 S205oL5qy1+AEYJSU4szvvogE6297IfGIGQBIXjZUw4VoIvTEccBMuh
X-Developer-Key: i=krichai@qti.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=MKJgmNZl c=1 sm=1 tr=0 ts=6871a194 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=bvY3E1ByFFb03tV5gjAA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE4MCBTYWx0ZWRfX6GHb4HwuTC6m
 7yu/848Qh1qZCkLfqADixXBQWWGvLuTsSNnpX9ur7c2T4tBTT4IWaN/0OcEAGEIAy+9FSZajNkf
 DI7LSXA2jcsj4fe5K2+TgBQGHGXfRmPN98glE9R4+EMyYYNNoKg3/EgtGR9JreRCBMiqxws91I0
 jTufloHjYXgNJfbdHcQRbyRX3FcwTKJF3um/JTRlmQ7/odVmIPUBFxnNSlRCTNlcjqM7H1cI9KH
 w6rQFrweXOscyrQibS5B67XvNgWUI16F9uuY+a7HDFDdZrX/vtSmDyCzdyAhNuJwSGlMNQixYNF
 VmeZ3nHnlFGfDjOv7zD9nnOC9zPTUtAEhIc6VYjXv5YMi86ybdMMCt07kTJpNIZ9tNEP1SyNpxX
 6FVbW3YMqhtrE3YZHPUJuJk6+S973TfWDv8dOeXfTv4MBBzwv42jBHdXASDCbRDRpTo+lXfC
X-Proofpoint-ORIG-GUID: YDSyIs0i7Caa7zZHqLbeCrBUg6Kyx2oE
X-Proofpoint-GUID: YDSyIs0i7Caa7zZHqLbeCrBUg6Kyx2oE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_07,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=825
 impostorscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110180

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
index b1cc3bc1aec8b769021cdc25c8d66845e7bebe70..def0254ee0b6ee78153b9b10f534ddf8d6f1b50a 100644
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


