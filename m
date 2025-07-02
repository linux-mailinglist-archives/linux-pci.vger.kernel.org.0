Return-Path: <linux-pci+bounces-31243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8979AF1391
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 13:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2E97188B881
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 11:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73677253F1A;
	Wed,  2 Jul 2025 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MBLzMQ5m"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDEC25A2A2
	for <linux-pci@vger.kernel.org>; Wed,  2 Jul 2025 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751455263; cv=none; b=Kc7ylT1GOpdhm2XfNvI8H3GWUyp1AiFPL0chrQ7OlfUVMzYpuuhVKNtjVC7vr5L4vsiUpzAHG9pTbKCx3jZUo+7sEtvVrCde+rq3Qr97UF1X2VOftdNDWh2CfWvBPtsH1jn2A20Xo+QnXegrbGeP4y2fmPL9rInsp/Ge2w+0w9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751455263; c=relaxed/simple;
	bh=WK7UQCNXLhDU0vyO0sEV1vG45WiJKmQMWd40Yeto5n8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lZbf9zNQxlZB4wJhrBdaCkAq5s6Souf/751D29nd8WUJt8RMdTydClQp6z8eD12iX94dQ3cvbDWdQyt8X+1q85DOt6XS03/SIcBtHBOYZGrIZWpR8R0C5o+9mMXB+Eiex4SrEM5cdO0679PzX6L2EJ29Gg3aGWJZCp3Kn3tB6sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MBLzMQ5m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56260L0a018912
	for <linux-pci@vger.kernel.org>; Wed, 2 Jul 2025 11:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LoOyg8E+dTwOvRlxXE0k3S
	wJHIfP+Cgz6iuEBbKvP3M=; b=MBLzMQ5mhi84p1gk1I2aNOpsVMSZR2IRDorJlf
	DsEV/RqUlLOsj+CLXjJx0p+6A5MEOpL60MH8zwiLMF2fO2vcJ+jVjpcHwUwd5fy3
	wigJjT2DNFNZWWBOKWr73INBq6DW3i0r/KQkYM9mmt662i1vguMbMx5Oi95ZD/ao
	1PEWM+Y6Tv4LCmdP9RQMEmMFkcIAp3Q5cBJCN7Xt6o6hEeimSqtc+LR2EVxN1b/5
	QuA8gr0a6Zq8tg0TZA6gscIWeo8q//IXhDJvmr+vU4MRa9vPUfmmMZn1vyn+XF++
	fT2SAXZdVP9hY/AxQMDGBne8a4heWr/bMwtRV6Bdk5i6hJlQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j8fxmg69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 02 Jul 2025 11:20:59 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-234a102faa3so49841035ad.0
        for <linux-pci@vger.kernel.org>; Wed, 02 Jul 2025 04:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751455258; x=1752060058;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LoOyg8E+dTwOvRlxXE0k3SwJHIfP+Cgz6iuEBbKvP3M=;
        b=lEfCafsyVRYxrnws992NQ5dKKJQoS6tCg32nAZQDundm3V0Q4g1M6MV1NStFR8sgco
         gtbJbI1XIFe1K4+LVqrKStZgkDKiv8os1tk7Atocy9pSXJHiYLW79tLYD6Vu570X79WA
         o9P+akT2ivd/chzwx8fV01x1KLq4YrNPKDuZR5NWmGvbdEptHTXNgzQklO6C23UydB3j
         uiktduZFFV1Lyz2ZJjVgYUVAhmgqmj1AEouJJ3sU/4be3S1t+p0lkgfwMn6ZJFpt1+f5
         dDClrldPYM9Xvw0bTomUOnjwOtgGwrWucHlO0wSgC5iHYBlKLAZi0FYDO9zaHJzT585d
         1Icw==
X-Forwarded-Encrypted: i=1; AJvYcCU5uxGlu3AiOUeWhm88OywpXmQeYa+wlg1SeCA0mKLk20o5bVQB0NN6J4BdQFVFpJXNiSIRUc8lfF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFZeVfnxgnsSem+RyALOVmx4fFf461MJX7M9rV1wgRGqgaYMfF
	amu8Hy1+FCdKNekfP2G4YS9zev3mY+mK0awwYv4G0hsU7WQBkziJfqV4XuqF06OECEENBK+kGrF
	Vf8c0nC5pA8mEhdu++Jj5ZAss7j5Iz6GwVBMSH4ph9tKo6PuhNiNe7TZ4ObNoFdg=
X-Gm-Gg: ASbGncsX6zdgT+3goBu1C7AXSIliqD8hqhI+oen6XrQBSiGpcKZy2/4sg6q1pBqedL7
	LM29jaAXnSCdivmlOb3GBMT6TTe5lVy9dBHI3PdZOA7f8PFIeJaHOKn7Icn52BG2KYMd97MsgS0
	EvXA0DlIINFIC366w/WE1vTsArNf1KVw3j7bq6kcWEaSPV8sE8tlF6myQDh9gDXT9EBgj9xZe1V
	tzKlHfoaM/Tx6LYJ3pyt4ZsLAYJwWfBdPYZ+OvROlFyoHXI36V6HCFrzi9aSREUnq34O8Yunkjv
	y45BHRGYqpzlntJJfh28WKl/OkgLXJc+e5V8KyrllxodJURwR9O2UhXA6A==
X-Received: by 2002:a17:902:ce8f:b0:235:779:ede0 with SMTP id d9443c01a7336-23c6e5b5acamr38280875ad.35.1751455258210;
        Wed, 02 Jul 2025 04:20:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2p2g9Ug4p5+yOGJWRDZMtRBE5V+yLNk34tAjxPENbi7BZoPwW/UcuDD5kEK66geRwefVDaA==
X-Received: by 2002:a17:902:ce8f:b0:235:779:ede0 with SMTP id d9443c01a7336-23c6e5b5acamr38280455ad.35.1751455257714;
        Wed, 02 Jul 2025 04:20:57 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23b0b3bc0f1sm83926955ad.171.2025.07.02.04.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 04:20:57 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v5 0/2] PCI: qcom: Move PERST# GPIO & phy retrieval from
 controller to PCIe bridge node
Date: Wed, 02 Jul 2025 16:50:40 +0530
Message-Id: <20250702-perst-v5-0-920b3d1f6ee1@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAgWZWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcwMj3YLUouISXUtzY0Mjy+S0ZMuURCWg2oKi1LTMCrA50bG1tQDAK7u
 LVwAAAA==
X-Change-ID: 20250702-perst-973129cfc9da
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751455253; l=3048;
 i=krichai@qti.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=WK7UQCNXLhDU0vyO0sEV1vG45WiJKmQMWd40Yeto5n8=;
 b=WMne7DLRCpHtX+CAZBvqMbzA6IYvOj+pa6L17yq7hsQ7tABQFjlG8dwKYnt7n4OXYBBT7KQ1j
 /yHZsyKqgUwCA820sxC8dpk/HOsjelNK9U3vkiCHg0ybtctM/iMzGfh
X-Developer-Key: i=krichai@qti.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDA5MiBTYWx0ZWRfX+DtG4f8rbvCR
 6CpA+0HEYVXpUmA9kNvyATTO7rkkm1swIdbfOUn6ifpCD+4XJh/bplqlsJa6vEDSzbw8FTIBki6
 +rihUXpPTAEdVDqxrgALak4VfibDbreVeMU1K4gFzWgcIM8XK0StVkFCr0GrVj4rhxTEjzdMeQM
 rosHbE/2mzbp1aU/F1V+l9jjWjvTnKwSrMjgC/MlhoM7qDdTX+7osVAi5PJ9G4kzhj5PnO43aAO
 KPUqMhanmYpBK1/KEh/YXcwsbi2YDRCcNtL2OspO0ZLAUaJm2MGaDyg3aV45wQfdZbkCUNbc3BG
 Q6o4fdqXrmihO36ZCpyOVmh7DWwKPP8fMXL4ylALl+EtSHYeI1enXsF0TEDM5K+RTt55Ei6auJD
 91Zm96Os9N6RAU7IJN1+DmfCLaLwN2TtdndZYRAXcIIDlrNiNiiCewtLfnhKsmiXHsQBK3+k
X-Proofpoint-GUID: Dsu0e010M3y3BE2m-We_DH17I79X4Koz
X-Proofpoint-ORIG-GUID: Dsu0e010M3y3BE2m-We_DH17I79X4Koz
X-Authority-Analysis: v=2.4 cv=TqPmhCXh c=1 sm=1 tr=0 ts=6865161b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=DNAdngzMxNmsW-howNoA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 impostorscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507020092

The main intention of this series is to move wake# to the root port node.
After this series we will come up with a patch which registers for wake IRQ
from the pcieport driver. The wake IRQ is needed for the endpoint to wakeup
the host from D3cold. The driver change for wake IRQ is posted here[1].

There are many places we agreed to move the wake and perst gpio's
and phy etc to the pcie root port node instead of bridge node[2] as the
these properties are root port specific and does not belongs to
bridge node.

So move the phy, phy-names, wake-gpio's in the root port.
There is already reset-gpio defined for PERST# in pci-bus-common.yaml,
start using that property instead of perst-gpio.

For backward compatibility, don't remove any existing properties in the
bridge node.

There are some other properties like num-lanes, max-link-speed which
needs to be moved to the root port nodes, but in this series we are
excluding them for now as this requires more changes in dwc layer and
can complicate the things.

Once this series gets merged all other platforms also will be updated
to use this new way.

[1] https://lore.kernel.org/all/20250401-wake_irq_support-v1-0-d2e22f4a0efd@oss.qualcomm.com/
[2] https://lore.kernel.org/linux-pci/20241211192014.GA3302752@bhelgaas/

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v5:
- Rebased with pci controller/qcom.
- As part of rebase handled one err condition by adding goto err_port_del
- Link to v4: https://lore.kernel.org/r/20250605-perst-v4-0-efe8a0905c27@oss.qualcomm.com

Changes in v4:
- Removed dts patch as Mani suggested to merge driver and dt-binding
  patch in this release and have dts changes in the next release.
- Remove wake property from as this will be addressed in
  pci-bus-common.yaml (Mani)
- Did couple of nits in the comments, function names code etc (Mani).
- Link to v3: https://lore.kernel.org/r/20250419-perst-v3-0-1afec3c4ea62@oss.qualcomm.com

Changes in v3:
- Make old properties as deprecated, update commit message (Dmitry)
- Add helper functions wherever both multiport and legacy methods are used. (Mani)
- Link to v2: https://lore.kernel.org/r/20250414-perst-v2-0-89247746d755@oss.qualcomm.com

Changes in v2:
- Remove phy-names property and change the driver, dtsi accordingly (Rob)
- Link to v1: https://lore.kernel.org/r/20250322-perst-v1-0-e5e4da74a204@oss.qualcomm.com

---
Krishna Chaitanya Chundru (2):
      dt-bindings: PCI: qcom: Move phy & reset gpio's to root port
      PCI: qcom: Add support for multi-root port

 .../devicetree/bindings/pci/qcom,pcie-common.yaml  |  32 +++-
 .../devicetree/bindings/pci/qcom,pcie-sc7280.yaml  |  16 +-
 drivers/pci/controller/dwc/pcie-qcom.c             | 178 +++++++++++++++++----
 3 files changed, 193 insertions(+), 33 deletions(-)
---
base-commit: 7c184aa42a3dc9b2630010fbcb06c701c440f8e3
change-id: 20250702-perst-973129cfc9da

Best regards,
-- 
krishnachaitanya-linux <krichai@qti.qualcomm.com>


