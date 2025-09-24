Return-Path: <linux-pci+bounces-36905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C78B9C98D
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 01:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1008C3239F1
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 23:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A0F286418;
	Wed, 24 Sep 2025 23:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bRfSLRFd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DDE25484D
	for <linux-pci@vger.kernel.org>; Wed, 24 Sep 2025 23:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756809; cv=none; b=jMcWInVvd6sRyjdLl6KIqOgDDyuw4ZfKaHLubfO9IoRJ5ODLtbFk2oav9BzOnGrsVUix4GRgwPo+T1aHA5KtHagUBQb8dMHb/4fUfOKXl3PnmWoKlu16ntYjvZWE/4b8F3Inp6Sh6hw93Oh+xdFOGrj7JwRXEJOpxcH5tDsFq2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756809; c=relaxed/simple;
	bh=O/HsehNhbUKU+HifRVasrfQoP2B7YYk5FbQ/Y3t9EKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N5KViSvx0XS+KJXjIUYDIF/aeDPn8sbbYrUM5HQf5gZqtfzOGz11LZEx30frYDFJCL/x+waBh5aNdXW4g5qqH19+COycy3JwrNGePJpnXLXt/mAzu7j0jKtoJfgTzEuM0kYTbcIkA3rMj4RzhzfeY0UM+6fTzRNoUE4lIXHmmMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bRfSLRFd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODb2BS019952
	for <linux-pci@vger.kernel.org>; Wed, 24 Sep 2025 23:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gZ7mTakONhQ5MdNM3TgNyHD/Jxj33wLx1vuBQG2ozxs=; b=bRfSLRFd8+s0STCy
	GHxlzxIuhN5Hogkfl/ff5dz9WBUwp3sv5lJ0isd72tyWT4nNOQ0Fog+0H4MZ+pyf
	AZA8foW55TGdkucu4CmYwpK6O4mAxIhX0H7IHz9x/hbsLqJXPslkUl1p412efYz6
	2z7y7Xjb5y9y0gzXZ7eqIspdri23Q5RELHJKT3FIPq31cHJ+xEyEMeRB7DGfktGo
	FEjD6PgmrJadc78QQ6wTkmjFFy36c4dUf3xPTCNuwUbWETUPNOCZZ1NtyoSFPy2V
	0ZoSmgFU848OReIA1TIHon6dBaPtpdevWLnTT0PCNSaFd7Wy74JRmK6Zmu9Uw4Qr
	asaKLg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpdy8vw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 24 Sep 2025 23:33:27 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b5514519038so440446a12.0
        for <linux-pci@vger.kernel.org>; Wed, 24 Sep 2025 16:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756807; x=1759361607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZ7mTakONhQ5MdNM3TgNyHD/Jxj33wLx1vuBQG2ozxs=;
        b=AbATUzEUUykWOSCivtYw82pYK+hKVcVi8LAPiuTdyq2ImizBza9j3K6ZEO8oxL3mUY
         Fw/y1dJ8j6QLR5Vkt/DKLidLiGUSIISNnbA/d9kKyPoaYseC6JCMAl30W70xlTK7ItD3
         WS8F9KuYuzk8/lQ56AcUFvsS/XjDBkwUYkZwIrX2i4g3tMRohbY++aSIBfb7WJlfR1lw
         jmKYfqwEZjaZUBbh69Xqet2r8m5SoUgsYHV2cY5NSR45cTjX72nMKbpLUSEpNM3m9EeH
         t0wZpvkWTgmU46JwSqzUOI+8ieSwO/LzIAAWBawYo/zQgJn4xDrW8Lco/L5z37oDoFeI
         vU4A==
X-Forwarded-Encrypted: i=1; AJvYcCU5bweTeKWm231kdDwDPnu5++pmQQoZ5QuMgdem3yhhWCc7s2maFrdB/w2FvSgvbJf+2fttNOo3j/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt1jrbdjzoVoGFnSyD/SosxJor2BQPdhRgi9xhGG22Auv8kQH7
	xArr8dHXbiSaCxQos4mETWlHTfz0oqQ4Jn/fKBL0FbH6eSkjxaSu4ZxAWfkBamCp4z/nd+MIMLq
	JprTzm0GVFKa8Byw2jP/oZIakOKBWRPslHcwRAkM4GelbfM9za16i9k+A1rVadIY=
X-Gm-Gg: ASbGnctFdUBLpo+fnnxZrpof2mOKlLvP36fF8cHF+YLTHEiEi8Fe8J1ccFLnopi5FNt
	K5qAOaeBA3jywoUPL6Bv/OAzyyUVSE6Ab3aP1Sty8qPcMirul9/yPsum3+FAxcXBOWuBQ8VFfMo
	/g9vjm17HzMD63BZ5cu83yijr2T8pl7rDGrNdwm121pEaNjddT5rhXN9tHFi2TrgHNDNGJF0R96
	i+rb2BLfLhTQvyRCyS/bUkcoBFkwnh55lRwwnpusM1ydUqYRBxPn2vMJfsBBBVC3268UhYfheQT
	nwnDWj0zK+NpgDJDb1UkA8Ov6eoyr3QapjP1v0i+7umfDPAD9bX+czuQ3UmeEu6Wwi6/BevgU2W
	5Dq6JNh1OxkpBk9s=
X-Received: by 2002:a05:6a20:244e:b0:24e:84c9:e986 with SMTP id adf61e73a8af0-2e7c79c5ac6mr1705025637.15.1758756806979;
        Wed, 24 Sep 2025 16:33:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEShs+t11pe4EXtyJY7eq7SxJOc0SFTQM620l2aSx6ms55iEGfKttzOhfcvzJfsawotCzSxCw==
X-Received: by 2002:a05:6a20:244e:b0:24e:84c9:e986 with SMTP id adf61e73a8af0-2e7c79c5ac6mr1704997637.15.1758756806571;
        Wed, 24 Sep 2025 16:33:26 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53ca107sm392911a12.13.2025.09.24.16.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:33:26 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:33:18 -0700
Subject: [PATCH 2/6] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Add
 Kaanapali compatible
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-pcie-v1-2-5fb59e398b83@oss.qualcomm.com>
References: <20250924-knp-pcie-v1-0-5fb59e398b83@oss.qualcomm.com>
In-Reply-To: <20250924-knp-pcie-v1-0-5fb59e398b83@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com, Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758756801; l=1501;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=VBW0kDv69D5tBQeRfHdrmnRiouQM+MGW2Y5Yg0f+6nA=;
 b=NL8BNAGHotEw5Z8jTwt29kGlC7TPmvyCyt7uA2v5QZBwSr1NNNbXHgBi0hJ1RrPRJppICeJ6H
 tnVxRt4czLHAAovxAHOk2m22FOAjgZP97+p/XohA8ec3N6cNZtU7gUc
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: mdduWbwEDohFR8ZkvvdI2AfnBaN-9xVC
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d47fc7 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=ZHoeG76OixanZ4sGZTsA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: mdduWbwEDohFR8ZkvvdI2AfnBaN-9xVC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfX89IFAQUUrsHQ
 U7jLPBxdqHxKUwMCHrmhTG2E2WmqCQ0YNYR/mCBmcyVCA558Yu39SVS6Pzn6WyzQx58xWCvdDrO
 7Agc4hsz3v35EwHkTsbJfSzw265xeHbZxUIs1C/BxtCkE0TAO4zZaq1mCRIX7RSeiWgDqV3KXDu
 5WH/Xp1CVEPHhOPMRMrUF73D98vEk9/PJ0zLuoWyMLOM3NETderrR4l786pChGaCDuFtvfz3Xe5
 GVUvZLuAfphXedXFBN3xk4B50pH45EXqaTauzxulKBcNQHM6cJ79/LaCsaVzjwRE7yC0HQlUCTr
 dyXoEzazEGr2WDpd4qA7am4/dX5vY03masYULhsbIiMQAc5cTSZC2e9nFuT51yjt66yTpepb2Cj
 nPZNcDq+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1011 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

From: Qiang Yu <qiang.yu@oss.qualcomm.com>

Document compatible for the QMP PCIe PHY on Kaanapali platform.

Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 119b4ff36dbd..9f7a276a84ad 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -16,6 +16,7 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,kaanapali-qmp-gen3x2-pcie-phy
       - qcom,qcs615-qmp-gen3x1-pcie-phy
       - qcom,qcs8300-qmp-gen4x2-pcie-phy
       - qcom,sa8775p-qmp-gen4x2-pcie-phy
@@ -146,6 +147,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,kaanapali-qmp-gen3x2-pcie-phy
               - qcom,qcs615-qmp-gen3x1-pcie-phy
               - qcom,sar2130p-qmp-gen3x2-pcie-phy
               - qcom,sc8180x-qmp-pcie-phy
@@ -213,6 +215,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,kaanapali-qmp-gen3x2-pcie-phy
               - qcom,sm8550-qmp-gen4x2-pcie-phy
               - qcom,sm8650-qmp-gen4x2-pcie-phy
               - qcom,x1e80100-qmp-gen4x2-pcie-phy

-- 
2.25.1


