Return-Path: <linux-pci+bounces-34707-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3E2B353B8
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 08:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B85683C99
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 06:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB322F5307;
	Tue, 26 Aug 2025 06:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AF71+VjF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD2F2F39C8
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 06:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756188192; cv=none; b=gttjzJPs2Rbb+81sc9XuB6KFPzzSiyqoMhamI79cwOwySPLAGo5GkucJrIfDzkU8ytTaYojA/g9EVgz3MaxAcHnp7elqNR5J9OdXDUEU9Qdj4oqwgUasbAkUfy9JayHnETFk27iUiTsfW4AubA9rHFYG1b7b4GXiBsu79YGZFl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756188192; c=relaxed/simple;
	bh=bK7IjrY7RIF7sDIzpn8NtOwFgdMSpX3iA8qa1hyDEWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DKn3AGGnndGgR0BXRXHVnfp72NxYBI0/ZT0+3273ssMZdT3y2A4A05tOmU1HY4hZPVKxR1XB6p3fay00b+VVoRpbBpbuceQyIDC3A4wllZIoC5NMBqvvkwhLtrD8QSReKpG+KfW31Opy8jhAQkTI94yBamlpv2ik5vz6oOi0t+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AF71+VjF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q0V750026012
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 06:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c7vY6EzZz6OX3dW8SAYR/iSAmvLfxB0jaIKM7TBpzz0=; b=AF71+VjFxN7xHoaz
	Lz2GeGUquY7+D1RICUB/r8FvWNlKFs50iPVcTTXCnwYK2272zd2dWYgvKlhvlkje
	gIcZg629Kuj3qw1CMYuwjnsCj1865MDeAVqadSV6vpKgE7BeqHMv6OSsTtJYcI/w
	yG8keS4q7YGQ7D+fWnZp2ZmG2gX/1J8OJ2hkcjTqAerUFilP/vo1xTcl3UEUEN9Q
	9QaqAmoKUhnEMcQqyMvdRrrJV0wYiITOIpD6cayecKeAIvPI7bpaOmQox0h892qo
	u+jjuRX/BrJ9lHsxh9kt0eebdXgRlrqOpchnBupz4Pi8rPNMQg4lqAU2ufOargNL
	TQ/j6g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48s2eugreb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 06:03:08 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24636484391so41514755ad.3
        for <linux-pci@vger.kernel.org>; Mon, 25 Aug 2025 23:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756188188; x=1756792988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7vY6EzZz6OX3dW8SAYR/iSAmvLfxB0jaIKM7TBpzz0=;
        b=c2KEBuXNXSHifXGQY0lu7qMjoDPIxt+pGA/2HsoKbC2oPYBNIUjp9ECyHLQFcJWjIL
         mkUp/A4VpzxT0GoEe9bqJMg5bGfykFe35XJ9zwtRq2HBpiqNEQcvGA9GEa74/4nmJq4x
         IX/1XIJiU09Seg98kiB2JlHrNn+l8m0TwS5lY8Zn0B5kvw6y6bFgz3GYvshSaOL1Qqtw
         qISznpy4GUkSZzlU6SRex3BRMkbkKbEF+S/djiD8BmyoDc/1PY0qYhdwYv4LhMTsOi8N
         R+CqvKT9o6fn4cmEoKAGKuEuzNim7YRRONYQfHRSybrhMraeskjawzAyR7ep0H/2J0pU
         0r+w==
X-Forwarded-Encrypted: i=1; AJvYcCVcZNfOHnaXcJ3jGJrL7X7sWvoTpgeIvW7ywFlIUkoHXqI5dD4x6K7xaqdoo0ocnfaQm+w1N426qno=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLHfWVTB+kLoC/+YI+JSXSOPgZwLSjLfBhFStagJQwrTZ4r4gY
	BovSwuCIx+nKTfP4ZR2wsoUKPiO0EJR8AVcFmH4c8vRLrtctdWd8BeQRqEh7JNmTZfPQOT2b5E1
	izfLgmAlJDqmF3MqjXgiR4q682uMMiyS+SLhjF7CwaZ2mG3M7kh1OL+B3ugXfK0U=
X-Gm-Gg: ASbGncuHnWpRPCLsU7wA/H6ewumLByWOsmJFPyw1gipMmIHO0qE+j9cmuWjRVwrz533
	PcIUGiIHHL5WVQ8bjfj6vZ2TyuI6t15YkXuDWkWhL/iHyVfFC5tK19i2Iwb30+Bzvv9vqEA/DLi
	wOLpNax8tA0HKYwODChJCtVaG0cv0mgsDEeI1VEhelJaUKdb6vzGTVA0ac0L2LWhu147u/PXeKz
	u+1B+HyViTgtEGd9MvNxUjCJ8S+zilf5BxWLqt8c9imLflbQIj3WxvMMkY0plIIRu/4gVV55DGH
	TSBZgJvaURdfNotY3Axky3Xmftj95fz0d7kdTj7Gm2FEtvIZc4WCotnxgweQdIvUtG5E5iekQGk
	UBdf8Ff48u9C9lw0=
X-Received: by 2002:a17:903:1af0:b0:242:460f:e4a2 with SMTP id d9443c01a7336-2462ee54a58mr173688385ad.23.1756188187841;
        Mon, 25 Aug 2025 23:03:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm4pbzLBk/0e4mduEsQN/9isTON0Dv+q5J0zKrA/VOOs5zXfa7ktJR6RMVvs1bvXxEGMj10A==
X-Received: by 2002:a17:903:1af0:b0:242:460f:e4a2 with SMTP id d9443c01a7336-2462ee54a58mr173687795ad.23.1756188187330;
        Mon, 25 Aug 2025 23:03:07 -0700 (PDT)
Received: from hu-wenbyao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668864431sm84989705ad.93.2025.08.25.23.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:03:06 -0700 (PDT)
From: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 23:01:47 -0700
Subject: [PATCH v3 1/4] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Document the Glymur QMP PCIe PHY
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-glymur_pcie5-v3-1-5c1d1730c16f@oss.qualcomm.com>
References: <20250825-glymur_pcie5-v3-0-5c1d1730c16f@oss.qualcomm.com>
In-Reply-To: <20250825-glymur_pcie5-v3-0-5c1d1730c16f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756188184; l=1643;
 i=wenbin.yao@oss.qualcomm.com; s=20250806; h=from:subject:message-id;
 bh=oxNK7rpfuxJFlxeq6m4yP+Aq+2bgn1813OA7/GzY/5Q=;
 b=MZ8ddF79PBfDlVHSJattDrGGBwdp99PB0M+w5COnVmkky0eJV2DGL/c2eFVLP5DdTGOrbvOOY
 8oF5DsRhWCFA7Plr5/q1FeyT9puSqYtWLsZ6O9oWeFKcFVYFh5a14aj
X-Developer-Key: i=wenbin.yao@oss.qualcomm.com; a=ed25519;
 pk=nBPq+51QejLSupTaJoOMvgFbXSyRVCJexMZ+bUTG5KU=
X-Proofpoint-ORIG-GUID: eoEi1n21EojmBMCnBhtp81988e4x5XBw
X-Proofpoint-GUID: eoEi1n21EojmBMCnBhtp81988e4x5XBw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDAwMSBTYWx0ZWRfX9GTBPKVKTxfB
 bRoHL/UFh2yLiCk6Q7036+Sm6sBDeIsUb37R9nh7O67b1HG2nDtjWGY7BxwODXLaA5cV8q1F0Zl
 yfh78AdOOPA3EZIuCbfK0mzKfxgXqzcrecDko0AHhlpkbcxLWhYUxikDPuupBTc5GIyzUrKo36Y
 A+x0OWD13kMCVkOYJaPElo345cCRIbFmjgfeomUWDa6XOTCWSa/K/K/UgX0R0OnuYRRIlqoZRKv
 mCWH5lL+YDXVeU9FXg0d0Qy3ailp2/bGg/o2KF3nda+Glep+7Y2a73EbhZNvEosM3RMSJP1Qiaa
 6RABxg0vS16c8u/Zue/8XCWdIeZK+pnYEEhTac6CeH9WzWk35USHIQMBM93x8mEtC199nZDb9Te
 Vk+JBh72
X-Authority-Analysis: v=2.4 cv=PJUP+eqC c=1 sm=1 tr=0 ts=68ad4e1c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=prgL3jgsdPShhDvlN2UA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_01,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508260001

From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>

The fifth PCIe instance on Glymur has a Gen5 4-lane PHY. Document it as a
separate compatible.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
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


