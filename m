Return-Path: <linux-pci+bounces-39637-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6F8C1A112
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 12:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA45F56176D
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 11:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99334341642;
	Wed, 29 Oct 2025 11:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QZljZNyU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L5T9/TTR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE58340D84
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 11:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737453; cv=none; b=PxqU6IHzif9AxO3R3Gq8MbIMm72SmgPfaSKGkKGKJ23znND0sBhylHVi2k4py2bYR+olrufUO96QF1Ly0y8eHMbWHqCBB/DxR/LVY2pXP7iJHL9jEHyu/WD8C1HRRFPxXR0RgLfTHvDKxXyis6yUgAGR34prvVXZ4q8yYryk6mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737453; c=relaxed/simple;
	bh=Qp8Mmp7bx4J2E1JhmAOqVGzqZtEIMBaTUoGYrEMgWiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iN7vgLo5jtlnTIWG9M1NQLOMFayNypGjPR6iWUGUZW72z+z4rvsicICejjtaYHD+Cpcj397f9Vn3P9cXwYgIIW8zCMA/8LbgHXDhvQNRR/jaPF7hEzAqz24A7+gD9X2Www4vDu7VBHcPjyCh+xuGA7/naQ6FuMMG4K1P8aW1D5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QZljZNyU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L5T9/TTR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4v6Ue3755078
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 11:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lgDEHTIbutVCIfjWEkDZtgrQs+c3+lk079qYfyA3JzY=; b=QZljZNyUqyObmm+B
	Qo6Fma1Hu1xbCpKQZ0eVPDgipFqom3gbmpHTpBw/zPpkmQoH301GgSlA8tnNmDM6
	/JQmMCAaHkfr/Kgwh15zqzPrj7a8R8hTU9J+xzjH4oOV0wr8/1MFntHOd+wBayjI
	j0Z5kTgnIQR8qeJMsM3n6UvfBL+Pq4RmWDUuheuKU9W4hSL4+HeLNSf2ivvTTm0M
	O8Lnqkyaxf3MhH6KIyQ6+JgeFkKmEGho2hEr536ttLUQSrskLUhfU2/+PRS4XTnk
	GykaEKE+qfuA54bvidcRYIDsK6bul8bCyXQbSroANjKefF7Dfk1z+hcV70eoJhlI
	bV4pPg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a02bhs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 11:30:51 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-290ab8f5af6so46102265ad.3
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 04:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761737450; x=1762342250; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lgDEHTIbutVCIfjWEkDZtgrQs+c3+lk079qYfyA3JzY=;
        b=L5T9/TTR57m51FpKyD2IiDzkcJ6N4DGwfSfRwLRFzoRUqAb71t3F9UzzhezvsM4jPi
         HSa4RQfG+vkY1/fh6YjHa0ALY4+qVqSc7OqtcN5LNw9vhcM71N+k0P5lxXsLzJSO90gw
         sCmlZVkqaKTWk3495jE8yblial+Z8uwhaImYNTgXibuwg9voe/4EuKOMAeHS2wPzqlk7
         LcAuNWD3dDIPFFrmAUqTYOX2kzC/MRJUGWecjJgpWxaCb3Ym9HfN1VAL6TZdb94spKB7
         ylPEz0hvi9LjPBQkjyIcLvyDDVCvOMFOKntuCij3AaFwgetrdHERfnQ5e7WT6whlDQEV
         3yyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737450; x=1762342250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgDEHTIbutVCIfjWEkDZtgrQs+c3+lk079qYfyA3JzY=;
        b=qiWRPNcChkm4we0X5gTKiuc+xgcOA3qk+LRhyYv/PW03jBnFSTU4YQXz591PkbL7tI
         f//V1u8jy2hjJWLKgOJSop6WgzMPhHzwXP/uCLa4/g5j2PLShpsrgaIyM6VbO34pR6tu
         AqEvAAf6TmBfkB1ieGtLuRevmkza/S8I+/vDBs1acsJbti9b3nuSy4mP+WagZAfIOy+4
         gH3g9Q4d18MlGzegrkuHxOi4ZTHi35GqSy8/1GURbKGYblgTXZRsFAZuwir84r7WCwuG
         iO1znk0XJNMaxLp6VjFiJ9KpCrFhC6GYPgCB/Ypyt+nb2hp5L3ZIPu7sCb0kgkuzt+Ee
         Qurw==
X-Forwarded-Encrypted: i=1; AJvYcCVTOcudYbTnMPSYBjlImRvWUgpGJiRMEzupEmLfw89BCDxLNWGtsgOEsEpaIlzuRFso6F65VaZKs2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YybEtXlIO5KgMjkiVaGPUs1RL7yFLZRxi/UBdCjBXiq8EYEb05a
	Tq2N2gSCdVZWERgI9spNhGAs7lfA+yWjy8EP55tm+gSJ4/gS5ifxpPMlB1tR3uqqSwpkxr5L/Kg
	sS5snICH+sF7EXJNMDSMN2pSv231MT9Z26AUuDSO4SD1ONSlaUmK/5mPosXgeqhc=
X-Gm-Gg: ASbGncsDk08rSbw+ezX6pCwD70/0qs6vQcQT/R+BRgTPgD0aTKS2n7zMoTJ/eMjXau8
	/VstqD8T9s9Qlwsp0Op6FEdO9x6ZBsJbsoYDYhDeQPWlHr3pdQjN090fTt4PCY6g+LIX064xZ/z
	Wu03Jrr9W/azAyw4+/ACTp+ak1dx1byVSMw6PQzxzpSduamutJif4Es+Qx5J76+iVYwtiS4Mazn
	4nlvqbcjbB5Akm7CeX0Ze1hyTvkg8gHpoBfET60M87TjTNs/dBEYGODhQQh5TpQePLbsUCk3mle
	6iBgWPlBGyDPXieWBAbbW6Adys3H95hh7vpop5wPEY0SNkPTsLGhSlqrDZKQnXxYZPD8pIRJKU9
	VQFmD6qY0p0G33ECWIqZJiq8qvkVkYbG3MQ==
X-Received: by 2002:a17:903:1209:b0:28e:681c:a7ed with SMTP id d9443c01a7336-294deec8d5emr30915645ad.36.1761737450402;
        Wed, 29 Oct 2025 04:30:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyBGfitnJb5d72matMvOP9OSygmcBCg8ayvZYCaCiH/ZIAXmdr6Ioo8zux7z78Nl4JrVJz4g==
X-Received: by 2002:a17:903:1209:b0:28e:681c:a7ed with SMTP id d9443c01a7336-294deec8d5emr30915215ad.36.1761737449747;
        Wed, 29 Oct 2025 04:30:49 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d429c6sm152154935ad.85.2025.10.29.04.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:30:49 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 17:00:00 +0530
Subject: [PATCH v7 7/8] arm64: defconfig: Enable TC9563 PWRCTL driver
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-qps615_v4_1-v7-7-68426de5844a@oss.qualcomm.com>
References: <20251029-qps615_v4_1-v7-0-68426de5844a@oss.qualcomm.com>
In-Reply-To: <20251029-qps615_v4_1-v7-0-68426de5844a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761737398; l=898;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Qp8Mmp7bx4J2E1JhmAOqVGzqZtEIMBaTUoGYrEMgWiU=;
 b=oS/tFzkDw9Orhio33EJ56o8TloT8Jc3fUOBu1nVbqbG1oVR33d72oI95HFn7cfImCLcd3tDqi
 X/CyxlbjwjxAYLVNF55aHWSDFgcqTQF0hz6Ru3wb+KN2ZiETXSXA/II
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA4NSBTYWx0ZWRfX1PtpfyQQJkVx
 JtEyP83FbCtSPeZcS5XnQqM6N8iyAGWDFR0TQ2mk3wXJp0ClMbkx0HuuwK6EoRV2YeDIxG7LUaK
 2g+NXjuY6oUXoeGXakUUoLLfvyahxgzoXs/YbnoVXHEsOjB7NDYU0vTOeCY7zzhUSnB6U/mG2M1
 hbhxJ2S7c68ZEYtS5vE40zZC7KZeTBQSvaqV7zew+hFxxUPpkhXQIxY1AbpnrTZ09b7gpwkoBG+
 dNZpYmMK6UqrNo+8h2zJ0vVGnemURpx9gWPZJxjpjuVHzwEOh76LYUDhpHnQ5RC8nP+sw9pNK5p
 BSiMEVk2B8r9JOoZ9wmJxztfoPpVCMRf92W5qwyvHXI31CY9igAPMNi1Agc+vaPghIgnZVU+G/i
 kmcJRUM5F89JBa6jI8ZdBlY5d28AIg==
X-Proofpoint-GUID: FLysnA1dHBTHao5eaZ_4SYLuH0TEsBXr
X-Proofpoint-ORIG-GUID: FLysnA1dHBTHao5eaZ_4SYLuH0TEsBXr
X-Authority-Analysis: v=2.4 cv=epXSD4pX c=1 sm=1 tr=0 ts=6901faeb cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=5PcvmwL3LSb495PBagkA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_05,2025-10-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290085

Enable TC9563 PCIe switch pwrctl driver by default. This is needed
to power the PCIe switch which is present in Qualcomm RB3gen2 platform.
Without this the switch will not powered up and we can't use the
endpoints connected to the switch.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e3a2d37bd10423b028f59dc40d6e8ee1c610d6b8..fe5c9951c437a67ac76bf939a9e436eafa3820bf 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -249,6 +249,7 @@ CONFIG_PCIE_LAYERSCAPE_GEN4=y
 CONFIG_PCI_ENDPOINT=y
 CONFIG_PCI_ENDPOINT_CONFIGFS=y
 CONFIG_PCI_EPF_TEST=m
+CONFIG_PCI_PWRCTRL_TC9563=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_FW_LOADER_USER_HELPER=y

-- 
2.34.1


