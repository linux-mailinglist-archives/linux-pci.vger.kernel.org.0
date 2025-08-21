Return-Path: <linux-pci+bounces-34442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 180D0B2F462
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 11:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801D460268E
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 09:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BCE2F1FD6;
	Thu, 21 Aug 2025 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OLN+NZp8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFFE2EF647
	for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 09:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769495; cv=none; b=enk5KGRLzEdKFmTaNRbqrN9FksqJfyVHDMmrajk3N/GlnnThsT/vMEBgxRKht5mZo8eCnjUokvWQjNOVlkHKPiLPNrjo95GovvKqeTk1J385EqFWAPPyt+BiW4Eynx1+C+y0POhCgNKC9ppdO3fOVsoT7eWJXxVfwpNOYxewrjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769495; c=relaxed/simple;
	bh=QAfC8/GKZlOXKe0IiJ9ssRTYFtHubuURyiBbBpoQUlE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ErYROS/2Mn+ppi3sglqBE0I1dfHgEYywG7Qi9aXWYq5kZrkTP+DoW8VF6FwLO7AUZtwDf3YYVk7DJd2ml3jqCmXH/442jkiI8X98Vfh6krf0sAVxYvDaay1Vy1PY/Ar2jn+1Hx00lBuSivihjR6bp1Lg9vBpqoBMmZWNRnzsf3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OLN+NZp8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9bHgb003824
	for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 09:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QR5+6bjiJwUUppAX6bVNei
	izyY9p2bkovmr5KiOMzjI=; b=OLN+NZp8h+L2NxVQWdIAzOLr3CzcNKJkAuN/aL
	fKBu15qNauNOPeK1GisS8uI9hsqE8tjdG5aN+g3Sx0fKIZNbmRIynjNQNv1m3YjB
	z0b3PvOKOtIg7zP4c1bbp2fdo/7EkF4t3AJJE2zLOQeiI2D60qsml/FnTe3KUleR
	hJciazn16GQ0W1DgUqhOy1XApNQCwG3+sD7UOkJUhaAdZBFtiBbZ1LOSN/GN4+FX
	D7/+NYdsaXZQM3O99rysNLqzWkUzr6/wfUt/yphVfEJTYSBCiB+tiXKIy+1WhgJh
	XBoFHd8fAa+KbvjOHIV+uJJLBqh2Qvp5ZpxgvBNHXmDST7VQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ngtdjswy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 09:44:51 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2430c5d4d73so24707785ad.1
        for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 02:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755769491; x=1756374291;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QR5+6bjiJwUUppAX6bVNeiizyY9p2bkovmr5KiOMzjI=;
        b=qS+9PYXFP5QqrkH7800KbDoAOJOKHJtJ4vhwlGmOOCK+VHiHxiFQOeBsR7z8nOhyCT
         N3H1oZHXcnpDWNWdkYghZv8Y4/LcdzGxM/DdyFT8Tkop51KROTIwUiqeF9BNVrAC+vkr
         Gdcjs+sG9OhgyDUm5A7zMQ1YOQ8E3VD9jb8pWvJc83ww8QIZRhNbfvdeS8SQKGf41ecS
         ceDrkUk7dExGHfTCLlv6N4RyZbqBF0eO2Naizgq8f7Xb2IOoQMe+ispbNvVLgw2s9bjR
         Ryw+ffDl8M4z9O8IkRIGadOcg0Cg2jI+tXlNY2kvv1hv9HJjI/VqiAv/uXg7gnfbjyt5
         huJw==
X-Forwarded-Encrypted: i=1; AJvYcCVVgWJK1vGsVY6Pl5A7RyG+sWFUnyrCU/4qoEaeTDBuEbp1mQq+2Q5cmACqA0LrLlDuREFUmkcvnFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLo2VL68dMayRToKJjYcx9H7/lq42eCTIPm+wfIDC/CJPg0vyi
	OCz6lPinEp1JbqDL9CRV2tK5WwK/kIWaeOu8AUxUcUF+9SeJRuEA7NplOpneL4a2XETKdQgdPzg
	bhOJoR1cu0AxgOTsNdXl8XzQBgaKJefi1u7YqB6eq2jwG1YRuIwUREEYgF7n8tik=
X-Gm-Gg: ASbGncsdj5Yz8oA6PZ5Q7T1QUUZW+lq9ynA1rR52LXg+SoqqK2b2nvU2cSCbKCZI94N
	MMRPixK3281k8Wk5BgTnnRhEE6dPTjLT3YciHBxc1RGa4DlqCHyODVTXrAVMHZLdMDy1JPkyA4a
	Yu/geKarhCRKwNPRq3rNmDOydWx+MADC1oPXrPNZEGvGYsQbvbKf6pdRfu6xOjh1ZBVIBfg4xHy
	aYVMzeGz8JnFv/Ysy+LHXM2ieyu40inqJ0QV4AOCyqBumT3cajjptzmRuxGqabloJHZYjSxBZ7J
	r+zSfP4ZfP/TKFgxRmye2FyogtbnXzinEeGSaE0UtEwHeNO5oAb9RHoppATtXDt1RHBAO4YOMyj
	j8lNgj5SsUelvgCc=
X-Received: by 2002:a17:903:1a68:b0:233:d3e7:6fd6 with SMTP id d9443c01a7336-2460248450emr21737935ad.19.1755769491053;
        Thu, 21 Aug 2025 02:44:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMszws1ocRhnckkCp/+DaksXRFNJDySLzb7VqhWeHwwuRPUApCU9iQxTyzeCjI5T8Y7UPNIg==
X-Received: by 2002:a17:903:1a68:b0:233:d3e7:6fd6 with SMTP id d9443c01a7336-2460248450emr21737575ad.19.1755769490594;
        Thu, 21 Aug 2025 02:44:50 -0700 (PDT)
Received: from hu-wenbyao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324f23d853esm1426078a91.6.2025.08.21.02.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:44:50 -0700 (PDT)
From: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Subject: [PATCH v2 0/4] PCI: qcom: Add support for Glymur PCIe Gen5x4
Date: Thu, 21 Aug 2025 02:44:27 -0700
Message-Id: <20250821-glymur_pcie5-v2-0-cd516784ef20@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHvqpmgC/5XMywqDMBCF4VeRrBvJxWtXfY8ixYkTDdRLkyoV8
 d0bpbu2CzcDZ+D7F+LQGnTkHCzE4mSc6Ts/xCkgqim7Gqmp/CaCiZhlPKP1fW5HexuUwZhWEKF
 mUqCQkngyWNTmteeuhd+Ncc/eznt94tv3T2jilNE0B9SphDhR0aV3LnyM5V31bRv6s+U/Nv9hd
 apLJjgHSPVRG0cakxwRBIOjVmDJcp1JBcC+bbGu6xuRjCjhYwEAAA==
X-Change-ID: 20250818-glymur_pcie5-db4ef032e233
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755769489; l=1713;
 i=wenbin.yao@oss.qualcomm.com; s=20250806; h=from:subject:message-id;
 bh=QAfC8/GKZlOXKe0IiJ9ssRTYFtHubuURyiBbBpoQUlE=;
 b=hjDHizvCmTAIWNi3O5kn7CLcEJfo89l/8R0D8hRr2p5iAeNmzVL6igb8B1gAi992fModJgPvK
 E2f0M+vVoyMABXxh3EesKONtWGN5B7B3jplFwJKQc8WjnC726wNGKuq
X-Developer-Key: i=wenbin.yao@oss.qualcomm.com; a=ed25519;
 pk=nBPq+51QejLSupTaJoOMvgFbXSyRVCJexMZ+bUTG5KU=
X-Authority-Analysis: v=2.4 cv=LexlKjfi c=1 sm=1 tr=0 ts=68a6ea94 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=450xJL59MvcON_dSg4wA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: GSHIckcJsC2shdjBaZg7UyDsQ9suiHA4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEzNSBTYWx0ZWRfXxJpuktpEaZUI
 kvNPQcj4UIyWqCmDppo6WtqVf/kksEFHivMXmTbfgQlE4dVuyypocMy0PmMVVMH9DyiqbtxYTKJ
 zw2CjHkCnA7mNhDBB+hL19XuxIE003+d1bEdhIBtB3Of7I6fy+S7ZVb0PbZ9PELWDSm+b1QWiov
 MX68G8a/I1r+ijqsMtOD5m31zBdylAaHIS5WSuePD97QurvD7PJLeU7NNXQiRiABzqwpi8nNYfr
 dXDA6pAlGs3gcIqWuAfhNhMS5wkbLcMZfHhKz7lEIkf8NcqL1fqIEHL4469LynYuxJD2nH8rHjV
 XOfcPpW5bWOgaqNYEvrztikPg97FyOWJBOfaXTH6ikxhkn2C5CnHhO8kHxGm/vO7QVrQUTd9TjQ
 PEov9Oz12DdoLlYO2RhdMpkvV4fWyg==
X-Proofpoint-ORIG-GUID: GSHIckcJsC2shdjBaZg7UyDsQ9suiHA4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200135

Glymur is the next generation compute SoC of Qualcomm. This patch series
aims to add support for the fifth PCIe instance on it. The fifth PCIe
instance on Glymur has a Gen5 4-lane PHY. Patch [1/4] documents PHY as a
separate compatible and Patch [2/4] documents controller as a separate
compatible. Patch [3/4] describles the new PCS offsets in a dedicated
header file. Patch [4/4] adds configuration and compatible for PHY.

The device tree changes and whatever driver patches that are not part of
this patch series will be posted separately after official announcement of
the SOC.

Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
---
Changes in v2:
- Add offsets of PLL and TXRXZ register blocks for v8.50 PHY in Patch[4/4].
- Link to v1: https://lore.kernel.org/r/20250819-glymur_pcie5-v1-0-2ea09f83cbb0@oss.qualcomm.com

---
Prudhvi Yarlagadda (4):
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the Glymur QMP PCIe PHY
      dt-bindings: PCI: qcom: Document the Glymur PCIe Controller
      phy: qcom-qmp: pcs: Add v8.50 register offsets
      phy: qcom: qmp-pcie: Add support for Glymur PCIe Gen5x4 PHY

 .../bindings/pci/qcom,pcie-x1e80100.yaml           |  7 ++++-
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |  3 ++
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 32 ++++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v8_50.h      | 13 +++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h                |  2 ++
 5 files changed, 56 insertions(+), 1 deletion(-)
---
base-commit: 886e5e7b0432360842303d587bb4a65d10741ae8
change-id: 20250818-glymur_pcie5-db4ef032e233

Best regards,
-- 
Wenbin Yao <wenbin.yao@oss.qualcomm.com>


