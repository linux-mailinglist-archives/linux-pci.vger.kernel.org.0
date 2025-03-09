Return-Path: <linux-pci+bounces-23202-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF92A580C2
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 06:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5E216C0AE
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 05:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528EB140E5F;
	Sun,  9 Mar 2025 05:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SwSgHKhB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B330F52F88
	for <linux-pci@vger.kernel.org>; Sun,  9 Mar 2025 05:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741499181; cv=none; b=EOfkIGW+PJjJaBOuOe7Kyc7poKf5FDfDnHPQv4UPqcgQ0zd05Mwz2JpcCMQYRyl3VqPVMo07u/YzV+BGqS7lzdI/RXkrvFPMHNPHqu0e/L+G1hh3h5MP7EcKPpU5WBMzMNHehFejs9xuhDb59V8GIPd1Y8jjy+G4gtXCgzTePl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741499181; c=relaxed/simple;
	bh=6JdyMzO3Asj5w7yUT2KkJzLVL1A/xKSGY1cxjeq4fyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uvb3ZLD9S7wWOqULaffGHo5FPvdFqonwd40MkeeHX+HMwNsOEAgdXj3jCqGMXzdeivSiRCYv6sh2xnrLviDxSzo6RhrWssOEicyXWvyF6vGejWq263V+y2FXXDX5cwHbK31kOrKrlVOV9vk2vjU2+vNrJHanpClPeQeo9Nt3cHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SwSgHKhB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5293OJHq021978
	for <linux-pci@vger.kernel.org>; Sun, 9 Mar 2025 05:46:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rQFIRDu578o2U4xSBMhmEMESao5IR5GCeI1b9BmxNfc=; b=SwSgHKhBxmllAZ/3
	8xUDBFWIrxxp2oC8mrMMIMyfRh/Z8pKiBiG35FKT9T0gWtXowpWNgdmxRYJU6lIi
	18nbzLtQkTzVo7ot2aU73wZWp3732EY0RBSEEi09UC8V9lcyqgfXsnyEDelv5Nzn
	tWGD61Dy+LvWjOKp5RVpUuaiK7qaD7KdjOGdMBZP3a95kLB86bWSVP9PhWhn0Qxb
	VHPBW47/r7m0ehxe63WtZIWZkwclh/D8IIvMM9L5kjIMVb0J3R/dIwXzMO9da8Nl
	LfJBEQCuMz1ShKIj7z7gG5bnpmmdEnHWsR9au8IJJIIwyOxmXKIoINJAPNx7JgMx
	esJXCw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458eyu9p3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 09 Mar 2025 05:46:18 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff854a2541so2721308a91.0
        for <linux-pci@vger.kernel.org>; Sat, 08 Mar 2025 21:46:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741499177; x=1742103977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQFIRDu578o2U4xSBMhmEMESao5IR5GCeI1b9BmxNfc=;
        b=ETJkwILCDtl+KwthNgyW9pIaSRqABOrZJ+ls1abQyYMa8CdpM2tuWqU+/aujRYBuVM
         8WkhRg5Hy3f3xliIwmXPPU4KkeeG/myZXpFpyMF/ShmwSofgd98SalTA9x5T8ZNMADFb
         oYvWmNLd6TQPocLfclQ3oW7A/q+5GYn1QmTwffCbVEZldFBsWZKx/APDtQ/VazQ3Dyz6
         I4YosrSgBgFz6oOZWeaWo4GsSXA0RzJpp/FT948l6zyNMhGYp9L3PTQ3lqBWGWB8OBGi
         9OZZFng4liXB0g0Jg9rpGAooSi/C6HxbWZsZmW/sSQTZoEhoWrfhEzQEo798k0FjhdFR
         7Vlw==
X-Forwarded-Encrypted: i=1; AJvYcCUyqwzlyvwh1GLP3QStXpg8jVvrPj+bieh6+cIIbSpUovhRUmjrUwDYf7GQViTDqCqjMohotUtSKCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMDkXEokuwtD3B2pvrcwBoNL9qMATCxSMtz8lgz6JB4yd2gn3w
	XcwJKpflp3QFPDafH8PGVd9kZbMPfYj/gQiMSB+e26NFEpWoAkFX0yh9IGdo23wQ0IlsyU9kD2C
	rIOAfILO+4mKEgZIQOc/Lh116gjvxvSdiOemyPOy8lu3XTrOcovqhBYecaCI=
X-Gm-Gg: ASbGncu0oVTt/BNjudfm56Hn9/fx9bHt4faJoSGUMyl+JLF4nYC+K8WgcnUdRJi+qLe
	TPcqGjyvQA8sY+8YHIQWrYFHH5oDSxE2PeU1Jr/GXdRpYuf1YgmU/Iqr0+rE1KjhOjZTfU/FiDk
	i69daDRT1cxPyKqFYxZIeztz7Wdyxvok9f3YnbEPjuBGed/YOKrOc4iGXOF9ba9cfNIPsefKnFW
	IHl+GGKgjXncK4DzOS1RVWO0z/S/rD7txv2+aL+QuVWhX2hiBQqHdYJIK9V3HSh9wdiJEuCvQno
	VVi89uMdg3ZAMB5ODUa4ECq9H4KMJOAghUZCiWOEljmqEOeEDdE=
X-Received: by 2002:a17:90b:38c8:b0:2f4:434d:c7f0 with SMTP id 98e67ed59e1d1-2ff7ce6f953mr18165038a91.12.1741499177452;
        Sat, 08 Mar 2025 21:46:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpXqA038rP5Ggw9FlFgm2R1a8pt/wT19XpVDrbhWVSi8/6/02dn0OjIxmQlm1MEEX4hHMNXg==
X-Received: by 2002:a17:90b:38c8:b0:2f4:434d:c7f0 with SMTP id 98e67ed59e1d1-2ff7ce6f953mr18165010a91.12.1741499177081;
        Sat, 08 Mar 2025 21:46:17 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddbe7sm54887145ad.32.2025.03.08.21.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 21:46:16 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sun, 09 Mar 2025 11:15:24 +0530
Subject: [PATCH v5 2/7] dt-bindings: PCI: qcom,pcie-sc7280: Make elbi
 register as an optional
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250309-ecam_v4-v5-2-8eff4b59790d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741499159; l=2186;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=6JdyMzO3Asj5w7yUT2KkJzLVL1A/xKSGY1cxjeq4fyQ=;
 b=wz1RB9CXvA8FGeEILDGOtYlFi4p2TQya48Fiatx6S46kOpMoDY1ohGf+sdniCzvoZ2ws8OA/k
 hSP+7NLXgblDQqH1P4Qrrnfs+nYUCwlZ/IZcFXRdsO5ve/HfIVR5Zim
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=cbIormDM c=1 sm=1 tr=0 ts=67cd2b2a cx=c_pps a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=0GabsJuRgD0JYX3L1DcA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: kqU63q5O-3Sab57g7nHwblPJGTIwDQjl
X-Proofpoint-GUID: kqU63q5O-3Sab57g7nHwblPJGTIwDQjl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-09_02,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 mlxlogscore=912
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503090043

ELBI regitsers are optional registers and not been using in this
platform. Having this register as required is not allowing to enable
ECAM feature of the PCIe cleanly. ECAM feature needs to do single
remap of entire 256MB which includes DBI and ELBI. Having optional
ELBI registers in the devicetree and binding is causing resorce
conflicts when enabling ECAM feature.

So, make ELBI registers as optional one.

Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
index 76cb9fbfd476..326059a59b61 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
@@ -19,17 +19,17 @@ properties:
     const: qcom,pcie-sc7280
 
   reg:
-    minItems: 5
+    minItems: 4
     maxItems: 6
 
   reg-names:
-    minItems: 5
+    minItems: 4
     items:
       - const: parf # Qualcomm specific registers
       - const: dbi # DesignWare PCIe registers
-      - const: elbi # External local bus interface registers
       - const: atu # ATU address space
       - const: config # PCIe configuration space
+      - const: elbi # External local bus interface registers
       - const: mhi # MHI registers
 
   clocks:
@@ -94,10 +94,9 @@ examples:
             compatible = "qcom,pcie-sc7280";
             reg = <0 0x01c08000 0 0x3000>,
                   <0 0x40000000 0 0xf1d>,
-                  <0 0x40000f20 0 0xa8>,
                   <0 0x40001000 0 0x1000>,
                   <0 0x40100000 0 0x100000>;
-            reg-names = "parf", "dbi", "elbi", "atu", "config";
+            reg-names = "parf", "dbi", "atu", "config";
             ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
                      <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x1fd00000>;
 

-- 
2.34.1


