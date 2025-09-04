Return-Path: <linux-pci+bounces-35427-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC797B43245
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 08:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7CB567AD5
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 06:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B2B2690D9;
	Thu,  4 Sep 2025 06:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JtvT/uA8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA4C265284
	for <linux-pci@vger.kernel.org>; Thu,  4 Sep 2025 06:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756966999; cv=none; b=DU6Y2/D3RtIdIMjZ++vuZzFBaT+MWahtfmp4ufXCKw2s0tOnoov//Twi+hBm3kgRqRCdStYNTNaSwW5PL6anzjTNbfvearcywlKun/mEesEFXRxi/Tvgqk8MuAjzUi1jA953d+AIA2pmABvEVFbYo276GwtMXlU5eAR614FJHIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756966999; c=relaxed/simple;
	bh=BUBeTRGlxh5yBy8bsZ3XJSCTZrfRT717lc+uZnjTECA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f3xTwFGDIeI6VQPZRTgo+mhKEkYCQLt+0tH25xSFDJu1NA+GNilhqsPjD+WP1yltvg+FR2S0T5ChSSw9QAyZnxUhaz37uohbIlGwak9wLLqEZjGr4JeCEaHsNg9YBOw77wh/Qzn1zj7nCqFpujojp8sFJtc0/iLH1aoE6FvyVsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JtvT/uA8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5840xVQP021571
	for <linux-pci@vger.kernel.org>; Thu, 4 Sep 2025 06:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AO6iEgJ9nzZiIvfqCr2K7LOo1og6DI9YbUhKFKaY78w=; b=JtvT/uA8DoEYSotf
	/pVsvx1qD3LRNVjl4DN4EtvdqBki9s6xbDdkW83BOIQ6pfSDdC9AvXkpmv6Xo6VK
	KLTkKs0xCG83feZBroDpGE9Hqvw7edP5LCUqumriR5S8lDaqa/3v8ScAKKZodfRT
	Y6ps2TvqOUOBLU5Z5um6boue9DuvKCm+pSUciZQ8lz7txq6qSv9n8Nq6elzlSY16
	SUXPJb0VgmzlxwU5YsBdrA29ymDeQKfGne37i0IAaa8ZgmAFUhSB2Cv9tTamws4k
	YhlctVx1JHzPvYJd3y/klITQXqTZiMzDKrzs5yjYuq4jLUTn22YsUVs5gLaPzs77
	3xb3Zw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0epjdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 04 Sep 2025 06:23:17 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7724877cd7cso792333b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 03 Sep 2025 23:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756966996; x=1757571796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AO6iEgJ9nzZiIvfqCr2K7LOo1og6DI9YbUhKFKaY78w=;
        b=cwL2ZJCx6NF8UVatGrC0z0qUKMziP+BlosbVUbnVuZyyJSJqWLspNY2usTW6PEwTh5
         rhdx9iuJQ10lM+Ke5AWYl/dp0qfW734Pvh1CKJg6UasfeqU9Qop9q0tLdcREB+Q8Gqhk
         qh5z6OjDlliisbkSbg1YSbizOA3rvwqC/aeXO7hxyy948zVr+FcCwYwuAzoHHYlItD5U
         pOcudetJu8pDlOUULebZhGlMhQ7s665vLyvcQKxKnA0rvlZv6oAf24OF/LDLHGK0lry/
         HjHH3jPGICu+SxinaoVLKgNkF/yKeR4FEQQLIVDitdcnRT0GuCve/9OQIAmjRnXMnYZW
         pAXg==
X-Forwarded-Encrypted: i=1; AJvYcCUN3vikxwVPboLKun44Xr2rCTx7ZdUgSL5Y6iLbs2ZJ4wTFtwpl4iSN2yof7ZvCRt9ONS2T3qErR5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyPgYFpfr+TUuiJVNDiOnglNhCVEKj+SAQyUese/ejyydQL3C8
	Qek1/Q3dGfZIul9QWCt4eTOSJNb42W5hm85z1C1MA+ZS7ixw76RCGkK80+1aY7ubV9etjScULbD
	ZwJZ8p1z6CyJZQ24epS2yQLhUrMKCPj2ZKarawCAcjHkf//CDOy3zePcmhyW8eE8=
X-Gm-Gg: ASbGnct6+MrXkGC3lJ3gybqtnkRstmFyE61Gsw4azwHmQpwpGguSzEFLy5uWbtyiE3G
	WUPy8PnQfbHVRWvEpWyAOqUGdh6KN8yv75W1x/3VQFRKaLdgeW8EyLY+0nfB0i34YmocQKi6fw7
	FKWuk7AW/rHnjE8Y6Qr8q+nycBxqh2rpmBoWX+7sm0hZDVk8tBAYwqSmRMxmowNHz+DcXTfYVIk
	houNr0zfg/czQe389eNTQZEtVVkq+CO0Abek1b5imuqs7D/3Z+Qem+VBrAfB0O2P2W2ypIK6Noz
	5VAqsBeLekm8uthQ8XkWYBFpa04sYFTreBY5i5Q0S51i8PSwl9tw5Nc6AAnpOnM5kttzRuY7hcI
	5WapXfheT4eXKzDM=
X-Received: by 2002:a05:6a00:4fd2:b0:772:641:cfb8 with SMTP id d2e1a72fcca58-7723e0d366emr17986391b3a.0.1756966996556;
        Wed, 03 Sep 2025 23:23:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvXohAA/unSga9vVXl1kTHuDcfUmEtv9aPvZ2haTs0//u+0U/pKB3T8NlkE0osq1/WTnYyFg==
X-Received: by 2002:a05:6a00:4fd2:b0:772:641:cfb8 with SMTP id d2e1a72fcca58-7723e0d366emr17986362b3a.0.1756966996051;
        Wed, 03 Sep 2025 23:23:16 -0700 (PDT)
Received: from hu-wenbyao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7723427c127sm17120911b3a.62.2025.09.03.23.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 23:23:15 -0700 (PDT)
From: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 23:22:02 -0700
Subject: [PATCH v4 1/4] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Document the Glymur QMP PCIe PHY
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-glymur_pcie5-v4-1-c187c2d9d3bd@oss.qualcomm.com>
References: <20250903-glymur_pcie5-v4-0-c187c2d9d3bd@oss.qualcomm.com>
In-Reply-To: <20250903-glymur_pcie5-v4-0-c187c2d9d3bd@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Wenbin Yao <wenbin.yao@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756966993; l=1645;
 i=wenbin.yao@oss.qualcomm.com; s=20250806; h=from:subject:message-id;
 bh=DwIAlVG79vEnNxiE7JeLaRZgKTUUwjCwHpMa5vhARMs=;
 b=TxaO/eppeOEGOzYPQ07gElbix33P8l5Tcwej82955emjawk8w3ibEnTEgBuN1Yl74dqCxNpw8
 zb9tA/evQYFD29dcc+y1prxYzZzr83HFgxZ+8QPjidrS/k+bZNi83tW
X-Developer-Key: i=wenbin.yao@oss.qualcomm.com; a=ed25519;
 pk=nBPq+51QejLSupTaJoOMvgFbXSyRVCJexMZ+bUTG5KU=
X-Proofpoint-GUID: Pm-V1ceIAeogyheF7CaBUDWE99J-R0SB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfX+wtJbPg1jeiz
 mh/Wp66fHjBah14eA39caETOz7InFuwyBsoxv/oq1MWfiqcU6tYwwbVD29V/y07aWawjDTrjg/i
 0A0WaK4Q8WoisnnKgbCsnQwMO2UURDuFWiCdvR+XyiuTALkyj8Vdw9D5PZPjYGdCh23PR62ix2g
 KKplF7JsrBlEh6o4H14WvMJQuwVvDBUVOyJAAVfP7/ufuK/7Xx0XZ1qvZaStgArqWOlLEXDqIqS
 mYLl46EJlCR/5I3WO+1Y9ai26xtfkmguPY1M1gkhq/rNkxcZ7ryuNG0lcvenfH6kalO+a6+0B9Y
 xw+hMHHb9WHyboppPsBRWr7xADnbecisVhUwc/vGkkxl3ffNDaDVcRvczSSM2IGOpTm+KehwulU
 iZ2mlCu7
X-Proofpoint-ORIG-GUID: Pm-V1ceIAeogyheF7CaBUDWE99J-R0SB
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b93055 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=prgL3jgsdPShhDvlN2UA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004

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
index cb706cf8219d015cc21c1c7ea1cae49b4bf0319f..1527616902ebeab975c9c79d75cb1eada64ae55a 100644
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
@@ -178,6 +179,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-qmp-gen5x4-pcie-phy
               - qcom,sc8280xp-qmp-gen3x1-pcie-phy
               - qcom,sc8280xp-qmp-gen3x2-pcie-phy
               - qcom,sc8280xp-qmp-gen3x4-pcie-phy
@@ -213,6 +215,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-qmp-gen5x4-pcie-phy
               - qcom,sm8550-qmp-gen4x2-pcie-phy
               - qcom,sm8650-qmp-gen4x2-pcie-phy
               - qcom,x1e80100-qmp-gen4x2-pcie-phy

-- 
2.34.1


