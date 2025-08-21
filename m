Return-Path: <linux-pci+bounces-34441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF41B2F460
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 11:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D411860132D
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 09:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDF82F0C4C;
	Thu, 21 Aug 2025 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PsAE+VEE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F292EAD01
	for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769495; cv=none; b=kRnJTZNIob7hugSz0cuCrukw3wj+qEqlTqfF6Madgneuh42UtW9Go9/OQyTL4WD4J2rR8598CIm6SkceohexRq5Kqsg3/piFc252zmjpOan90uiCywsSVbRgtQc7PXdh5TBF3xxYVvtHc+pCr26u3+WC4neM7za4/MAI4/jsIGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769495; c=relaxed/simple;
	bh=OYLGPSROlM94Y8YMfz+cAy5T78h70o72gHxUfKcZJ3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YMggQnRf2AE51x0TczTVES6QEk+ipCJ3x3UprjRPkMgU51qsEKPSwFJGXIsGD+2wKvtOxWql1cuL9qlHy9KCrZLm4ouMSnsXPLxt3bdbRwZa+uaA153sm379H2pSxwuHui7nGFVjak8/02Ue1URRrlCvoGLhI4kLfVCs6OcwEqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PsAE+VEE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9b9O7024190
	for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 09:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4HB2uUgg4ObiGLYTjYfuAXBTtDoOjkuI+b7+MZ1F1B4=; b=PsAE+VEEmmQF2Sau
	/CClwvxDl/DVGgLZhQ/XD1sWcoKBxNTTz9sQJXrP98irkOvGQYP/k+Jj+T6NduYf
	AKOsLLeR0+oa3KLCTZ3ANXwFZFbZYHcaz6QR+NVZYqtZkiKOBFX/bYSNomh6m9S4
	GyZscyNIxj6Tbmn6u7zYDp0mIUfLA0GsIMoBm/zdhFa9Q1ALMoMwyFyVnfMyU+aj
	Y7EqOibQw+QMRhI8tm0MhxipKpFrnNLwCr12bZ6MuY7Nn56hlqN8Y5ej+/jcIiVW
	nmp+HEQ+4gwY2oE9O0KzLgwCNhmp+0Rd/nZQfsoRG93uYb4IyuGryeCtifbon48R
	iHGCyg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52ad008-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 09:44:53 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-246164c4743so4461415ad.3
        for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 02:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755769492; x=1756374292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HB2uUgg4ObiGLYTjYfuAXBTtDoOjkuI+b7+MZ1F1B4=;
        b=R7WEjYTHzS6gyzUZil+uOdRLKuWXxG9Px3JH4TvAHSwi4aXLUMcUGpyoMyM186GA4q
         01Zs0ctPILoPJtUjglBeKfcFEPAhUQ0I1cYeRli0qiwJyMmBD0syi5Xq6F/u4UXa/W37
         cWpSz1DC4YeeoNfpPGKk7Y/831vQi+Z3+UHS45LdhmppvN4NU10WEHGb6ilOKSUA9laP
         /jHSd8QtlVnNenRzUZGDKMTCW8zdLX49swBOilMbw7tbPQMemyqafY4n0GEMu4AObC+7
         IhPHe9gCuHF61ItjgmL7+FsbEoznK/sgpCZ6XFQQdFiFB92Aa/Yb+mLOV0wc01r4VU7h
         OMFg==
X-Forwarded-Encrypted: i=1; AJvYcCVF1aL3BJlw/KnKjDgTMEM+YpRaxr2uJw8DSTaHeHs5sVa0JDY8TKTNPCp4Du14M+AvHKYBmMH3JhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuyvk/Buwaq32ijiFJrRr0jCbuw+fW35E3ClDLkeWZUzvTnEDU
	v2BCdTzVY8/ItghyNgeQj4UUSf93ijW2DFEC5WkKEWaUwEftwz6Z55KOQw7wQbsAM+29w/yFhfY
	CzRhT/mzrpNZlAInNDBs1NnT9RFdx8vcZa+eBw/b2Ko73axD9jD/0Tz+3P2nOGwI=
X-Gm-Gg: ASbGncsaQ51lL8buoVqHt8wb2zP76iiaqHju45QwyfwlQtOGaFoJ/86aUOpwP3s5Clw
	du+9uhYKvHPn/NjsyGsY/9UXi3dAXRmh1UNgPJoH5+9erq2NCEf9aZNKtzuIDCSkLHDQfP/kGLc
	+7hZQ4FBT/hlEgSUSIhUA1jrNCYy/3cvSY4vx08gS02D1VF9GmUkCubyQra9D/EEtnukbuJyP1c
	k14Gq5b92gu9L4Js56xTUGlErWzIi4u/rrUfLKFHvJzBcGzpSVEabWoaiF7dsCjlv7NI4pEW7Sg
	PKw/L8CiIvNWR6DQX0vw/uY+2SZfC4Cw+iiHBqR5PcN10MgLTth5YlXiOSL4mjZYUeg6ZXX41jX
	OaemSI0RsxKPmNMM=
X-Received: by 2002:a17:903:384c:b0:240:640a:b2e4 with SMTP id d9443c01a7336-245fede0b63mr26328155ad.49.1755769492397;
        Thu, 21 Aug 2025 02:44:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFx4GHGVHvitiI3tfieiXs12r8JEwBYJ5VY9Fy1i8PQK7RHyuxBxDvyosnXBfmKrzsdVv4Pvg==
X-Received: by 2002:a17:903:384c:b0:240:640a:b2e4 with SMTP id d9443c01a7336-245fede0b63mr26327955ad.49.1755769491957;
        Thu, 21 Aug 2025 02:44:51 -0700 (PDT)
Received: from hu-wenbyao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324f23d853esm1426078a91.6.2025.08.21.02.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:44:51 -0700 (PDT)
From: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Date: Thu, 21 Aug 2025 02:44:28 -0700
Subject: [PATCH v2 1/4] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Document the Glymur QMP PCIe PHY
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-glymur_pcie5-v2-1-cd516784ef20@oss.qualcomm.com>
References: <20250821-glymur_pcie5-v2-0-cd516784ef20@oss.qualcomm.com>
In-Reply-To: <20250821-glymur_pcie5-v2-0-cd516784ef20@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755769489; l=1596;
 i=wenbin.yao@oss.qualcomm.com; s=20250806; h=from:subject:message-id;
 bh=5L5bgft0hY3UL+GD99tTktGev1AZdAzNOUPNY/hYCs0=;
 b=pdeoV5QDRCXDZmT9xtvFBUXUQoDPeo+E8tde+yev8M/WcSKq0u8DjWSJEglrEvd5uQ4Qi4ve7
 fEhDoOWl3GJB8NBi/EMSt+TPtD6W0ZX44pFzz4lXdUPAwolbJYpl/ij
X-Developer-Key: i=wenbin.yao@oss.qualcomm.com; a=ed25519;
 pk=nBPq+51QejLSupTaJoOMvgFbXSyRVCJexMZ+bUTG5KU=
X-Proofpoint-ORIG-GUID: _O4ybq1TJ70Yavkbj0S18Pu57IjSjya9
X-Authority-Analysis: v=2.4 cv=B83gEOtM c=1 sm=1 tr=0 ts=68a6ea95 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=prgL3jgsdPShhDvlN2UA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: _O4ybq1TJ70Yavkbj0S18Pu57IjSjya9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX18prqfT0uYlH
 TBiKPSIJro4DkyojLcaTahia9JXe1GaV79ZCkbgPiQRBeeIY4BNRMCL2k8KyWScc8MrlSdM+FOy
 kXEhBjPzUBgjbdZo2LFJ2kMpatvrxly/4uQPmXk6dvHTLRumkH5v9TTT6mAcLrJVNe7YXb2Txfj
 uAWMnCRRZLyx6hKx9CHqFWNPPmeb9NLjR9f6ZorQIyskmMOjz5iGPAdDx5xjPAM4By9WzEjlisc
 X10FcY34ndwHfz9dF4yBF4s7Ry961vRVowN8sLWsMKC0nEA6yDi6A2AkkpPSnwh40iyx/vxeimT
 9+cpS3vQ2SfpV5Lpt2yrwO/4KVtFgdjmLBKVglHNoSMTs4K2sARYJQK+UdCiaBHM/Tf/qp64nZm
 Jx0M2C2r/sLe6vv3fbFtGnmV8K94oQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

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


