Return-Path: <linux-pci+bounces-34272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33700B2BE22
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 11:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5FC5A1AE5
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 09:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A0931CA6F;
	Tue, 19 Aug 2025 09:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D3aZM1X4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6707F31E0ED
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597169; cv=none; b=BUWiDnH9ViOS9UJu+aDQJHV8E4d3/0C1LZ2BpEdFkbbwEJu8g9iUJLff90uS4BqcFJH2Apl89CzdZHWF8qr50yZYhPdvN0vSVrL6zF52qBQOFc1qI0qmXAyPVnA/6TBtSnFyk4c4w+SCbnrK64cbtKS1jAsAsbR0I/sRGrv/PnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597169; c=relaxed/simple;
	bh=OYLGPSROlM94Y8YMfz+cAy5T78h70o72gHxUfKcZJ3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WYVJGTrkRH2AH5LsZuhdHpGrHGK7FiIpJSgFs5SR4kX70ZQBLJPTUitTtKr6iP/r2UzxzR361V2jQcm/RMaqQtswTTBncnAHJHKw6qcF3/ARzW+cEeRNmhJa+1h4W98l89TX+jKQ1L0zDE8bm2b0udzX2sv2yy5O+FnPQcPEXQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D3aZM1X4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90psg023856
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 09:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4HB2uUgg4ObiGLYTjYfuAXBTtDoOjkuI+b7+MZ1F1B4=; b=D3aZM1X4B+HF/L/z
	KdsFIuNEcRM8a/tWk2IWn+TNS7sPwOBYXWwMMnIhoqF4frlheK3Vw8EFA5G3nBfP
	/oTv+FierlwtsDUhX8inf+frGxFiVp0wscVHwuVwBCiI87YcV8mnVHw52R2erMcB
	SgdzCOKpreAXtIDwIjm5QrUQhTYPbj+ynliQIkBOtgSxdVvXMZWAfSSqEp4b5W42
	GBtHFkkPMN1RyHc0b3HrKRDn5cQq/tpf7lOjuTqQBpm1en3qBIDKF4mhm8WD5v05
	6swlUG0cjB6DMOEbOmZfum8jidMEJd5T7ORy+QDDufAzito3Iz7NROtM/82EKs1C
	c/YK4g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48mca5hrs2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 09:52:47 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e1ff27cfaso5325394b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 02:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755597167; x=1756201967;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HB2uUgg4ObiGLYTjYfuAXBTtDoOjkuI+b7+MZ1F1B4=;
        b=n6+lOoJ58B8TN4PmACCtO00noh6LqHwZom1O8cXa5qxp+HjDcXiYYjOUlYvHRvYfkG
         jQmziv+cOldAs7ttQgYN0D5KnvRYIUamjTP2OjnYnQ3E0hYOIMR6l+4tElfsiS5fv63b
         9pH+skFjVc/bCVBDKVPJIlbOmcLNrez7mrfnSu7JFlpno8aaDIU3df5mMGXYBtB3sW4s
         G8jp7nqPhScl5LtKSAn2v3lGFXBK3l1tYx02IizckorgJvoszdyY85kQ1F7Hn4nPJ2o5
         Sk9q+sFGQwx+o5n4C4g+Gz1hlWpfxBUMRxVzOYbMrgFlSdNYp+hqSDCSAESiELXkzdBp
         nL3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPoEANsmXJcaniQ9ZU8KObfHueXwjuDjeChj7XpUulUzV7wdSTdxyxw+M7+Scedv91N+K7zBwYdsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz55BslVQ5+jTd3AuFA3MKGoLMB+rCGG3f5lAlmKtm2mE2jDYci
	UI+PD8Ogkxab/fSkIIeMgFydtWIopeIvIO51fUUpkZ0H11harPr4Kmv1d/iiH3GC1TGJbkawilb
	c0PNCty3gR4TZWvcs4PCJWz4CuqcdHUNyJWTIEDUcYUuFF4qry1Q2qM7d9NhuDu6nuOx0/9ralw
	==
X-Gm-Gg: ASbGncu8yDhah3hIoRsv6NeblKFxR8AsLbU45ipDgGDUvrpFudR5b9PFIGICfqsF/Mc
	0IiTqDoonwOrsFpgJFfH6XwzxZxsUGX+/KBsMc0sOv40h0HpvImWm2dZFVQ/2RN9wuHu/Sdodr/
	EiKnYqcqaY0qyLNWQT4i4Txd5fpusBHwRlQPoX6OzavGh3EKocOoNDi8idM/1BS0VBxVNiKiEke
	d3dnQAeGzw6wuVMR4jiK2ClDC/OYTdqi09/KC7m0thSolwe1vYFRcWM9n0ahQhlM4xLVwwRPTvI
	7FamGSO+Ma4xkdl3KmVe5s2+0tZPfMYoYdcYEPwi0YFJlcocdqJ3VRGcDgtSNi5Lp10UqY/3zCt
	5Ii2gl6q8fbItD9Q=
X-Received: by 2002:a05:6a20:9143:b0:23d:45b2:8e3c with SMTP id adf61e73a8af0-2430da566bemr2343288637.6.1755597166605;
        Tue, 19 Aug 2025 02:52:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK98AH04v86DoafQcwelaWJ3iL3gQkWuwwa/UBd5s9Smm42EVUfqRGbSC923jHrqHy28a7HQ==
X-Received: by 2002:a05:6a20:9143:b0:23d:45b2:8e3c with SMTP id adf61e73a8af0-2430da566bemr2343266637.6.1755597166153;
        Tue, 19 Aug 2025 02:52:46 -0700 (PDT)
Received: from hu-wenbyao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4f7cf7sm1998291b3a.69.2025.08.19.02.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:52:45 -0700 (PDT)
From: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 02:52:05 -0700
Subject: [PATCH 1/4] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document
 the Glymur QMP PCIe PHY
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-glymur_pcie5-v1-1-2ea09f83cbb0@oss.qualcomm.com>
References: <20250819-glymur_pcie5-v1-0-2ea09f83cbb0@oss.qualcomm.com>
In-Reply-To: <20250819-glymur_pcie5-v1-0-2ea09f83cbb0@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Wenbin Yao <wenbin.yao@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755597163; l=1596;
 i=wenbin.yao@oss.qualcomm.com; s=20250806; h=from:subject:message-id;
 bh=5L5bgft0hY3UL+GD99tTktGev1AZdAzNOUPNY/hYCs0=;
 b=iSxkRvwPR0upKVd4VfCSpydV5AIWuhTgF5bNTgzrmAQMKSGHkafm6fwJOSYukO+Z8sRfTNEnN
 zVYCLHdo1m5CkxFG3qY7uMnOpRWEnekdHJPHAK5A2R3t7B4Hbw1jPjd
X-Developer-Key: i=wenbin.yao@oss.qualcomm.com; a=ed25519;
 pk=nBPq+51QejLSupTaJoOMvgFbXSyRVCJexMZ+bUTG5KU=
X-Authority-Analysis: v=2.4 cv=FdU3xI+6 c=1 sm=1 tr=0 ts=68a4496f cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=prgL3jgsdPShhDvlN2UA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: rATXnNmYC-NT8psPDZh3cmdDRTDu23Xq
X-Proofpoint-GUID: rATXnNmYC-NT8psPDZh3cmdDRTDu23Xq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDIwMiBTYWx0ZWRfXwS3f9WfEf6c7
 YHTScHZ6cBwuDlHmptkOqfdHNPlqAoKjqdx40DgoSzbZMw/PWp0HOpAhEB185QcngMaOKReW0pq
 IcgmSdpyL58fwQyxLXsA9H0bEggfb6zxGHIuDjwO2PiY+gl5K5vSnH1kDYDeM4HNDsv46qoGr5O
 h1/1gIBCQTgdSyfnGMUHUfzAeFSGXKA492Sn4Nf9UoFDD5p8t3eHcVxli1nVpVufLIAqMUfFLrS
 Tgh1dfzg2GPRs/e0SJNzwlwMpCehR27/FtpWgYWvo74EoRQj7Ez74WZTtGVdX+YhhTWPcZ1e5AW
 Qsr4KB0Qagr2UIoyh7+gnI2gMIYVljjaV+VJMUmT0eFSLl+dJpnrkiygykRgovIhtr9qw4HPsKV
 A8bTBmms
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180202

From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>

The fifth PCIe instance on Glymur has a Gen5 4-lane PHY. Document it as a
separate compatible.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index b6f140bf5b3b2f79b5c96e591ec0edb76cd45fa5..61e0e2f7ec7f9cb08447e4cd9503698c0a2d383a 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -16,6 +16,7 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,glymur-qmp-gen5x4-pcie-phy
       - qcom,qcs615-qmp-gen3x1-pcie-phy
       - qcom,qcs8300-qmp-gen4x2-pcie-phy
       - qcom,sa8775p-qmp-gen4x2-pcie-phy
@@ -176,6 +177,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-qmp-gen5x4-pcie-phy
               - qcom,sa8775p-qmp-gen4x2-pcie-phy
               - qcom,sa8775p-qmp-gen4x4-pcie-phy
               - qcom,sc8280xp-qmp-gen3x1-pcie-phy
@@ -211,6 +213,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-qmp-gen5x4-pcie-phy
               - qcom,sm8550-qmp-gen4x2-pcie-phy
               - qcom,sm8650-qmp-gen4x2-pcie-phy
               - qcom,x1e80100-qmp-gen4x2-pcie-phy

-- 
2.34.1


