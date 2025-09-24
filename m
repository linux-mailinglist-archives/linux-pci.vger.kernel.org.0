Return-Path: <linux-pci+bounces-36903-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD050B9C978
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 01:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAFE44A7E94
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 23:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AE92BE625;
	Wed, 24 Sep 2025 23:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jCuRNqUU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09F229D270
	for <linux-pci@vger.kernel.org>; Wed, 24 Sep 2025 23:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756807; cv=none; b=uHfXvMAxP0Vyj1RDakQw2tcIxvTZ3Vhw3lK6FzuojSSC+gfj+k7wZKWAJnf20heHm3UZtS3+HJPFh6/7qklUMLYhCMkAdJbLN/9DzvQmNtURoiyrEE0gguHzbHWcLVN3r/t6sSUpRAjkrrZmlbTo0IwHQIFDZhLA2h1RNyaS5AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756807; c=relaxed/simple;
	bh=tlF/XmDSlCSzHpDbYIYkAuUDBatLs6VY5lZmH+8tSdw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qbQGmt61z9pbAmehvLGjPIhXnzZt3rI6M5i+qifUXTZ7/ElsfeeMDnuliH9EYK2SEkETseU9TP/OJbLeloCxa36jYF951edsw0MFwmWIVuJyPxabnf6STJvCmkSBjZQ6daHm5pRDFhpnoM5Dz4qnkHQmWMJYr04AZSSJWeE9wtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jCuRNqUU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCSwEb025075
	for <linux-pci@vger.kernel.org>; Wed, 24 Sep 2025 23:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=VNIomdy5vQZBr0Xb1zY4tT
	/Acpu4g0XVUwXNo3bXGx4=; b=jCuRNqUUMjb0jv51pmB8cl8BDgQTKqHaV+MSVh
	voWepDXGh7ziPfsJsEKLw8cf8ckByRtvSAITRASobY7Rp+K8OquQQaO8YVgIAXw7
	SE7KoVv0UD8q0q3nmHnH1PYxAFoZwWw6lFzFzOS4Xrs1JlQFFvQRhioBlSzHbQir
	/5Yk6TnrO5U/Qj+w50tkFgR78EyE1p58UP1oJFC+xMT3Q9MiGVnh6OqNv9AtcVzk
	+zZZRXdFujW3s2tBEVxsQShnhWIaiTLxlJcrwmfLpsBHIxUcnB3ALO/f3+nis5Kh
	fKw2uQP9VQk99PGliSU6wISuLZFrOXulKYmQwDyQ5+T8sn8w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyexc07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 24 Sep 2025 23:33:24 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-330a4d5c4efso276096a91.0
        for <linux-pci@vger.kernel.org>; Wed, 24 Sep 2025 16:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756804; x=1759361604;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VNIomdy5vQZBr0Xb1zY4tT/Acpu4g0XVUwXNo3bXGx4=;
        b=ENnrCF2AAfdFIsJmLGMD5VHr2u0prFB/Lsm2ODeGvkmohiK4HeQ76Igdec3U3SRCYQ
         JriD90hDpi16OP9fqvQGKSTJ5ANEJSGqUpGglJeIrpgTjOy0BUCakfXecL/EQGpyGI29
         Zw/ya+GxuyMPYCwGo1zwWB324XpAfzl/kdM0t3Bsg+Yzfw5HKZSRAOZ//wi7riWccYMD
         NzVHQ/DKy9TF5A0OppGMASm+QVrTf1Rkl9nnKvcyKjc0k59gq5Tu+27yi7eniZGzTRj7
         pEi8SbV8/idN7k90SGBS/RGCP88hJgDXeXCCl9szri0jPKYv+qkbZsAAV76DGrsE5daE
         9cuw==
X-Forwarded-Encrypted: i=1; AJvYcCXN7vgYDCpczaTFML5Eiwj86/ps4lHJT8kJVOnLCbIzMJVli/AJeTRvrgnf9jS8FmKHsEqhi8M8Msg=@vger.kernel.org
X-Gm-Message-State: AOJu0YywL40z6L5/caoQFHqAqyVaj4H53/5NlP9VUGQap1Fo/lFdxFx8
	jAcEfo2sUbuJo64dmJQVhnM6icKFQeKiUbrcj6KxSyy32Y4xD7R9VXVK/c0EuiSnnwZ77MXPBku
	+TLbLDrYcxnpQr3H/BfDXnV2lePWLNQ8pLU9Mt6LJrEosihP6Q8vJJ+ggDsiyWtlfjxwM9v42lQ
	==
X-Gm-Gg: ASbGncvui0vE4Cd/cq6AVpfmsdWXt2+wxQKgiugKM1BnmkYWyyKAWbTIUVN8XcsGM47
	BuJjE4bqIGXYpkAf7sW6LiNTerPLx1roGuVpKkSSV93ig5MjPkrwSOcA2QWQ0iUXGQPPkqpI/6Q
	PiIp1BdR9IhJApvWWsVjRsEcMmQ/t5L+3CLtnwMMQlC/VqznzpvHZAoMxD7BqkED5CuLx2fDuim
	oDblfsIP+2rNw2QNII77ELIIoI9OnmGfiW6ibCNnIFq9gN/7UarCbH/yBpnxJ/m2f5665HLrimL
	lozXGdza3CMa3cdpRulc15YvnhBcOaq1lwDWbYk1cgYFoHcIciglKwWTuzIrE7Eq3Y6x3BkJ/rQ
	FzvcfhT/ez4oqOJU=
X-Received: by 2002:a17:90b:17c3:b0:330:7a11:f111 with SMTP id 98e67ed59e1d1-3342a300367mr1473551a91.35.1758756803667;
        Wed, 24 Sep 2025 16:33:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdtlLUNGJJSlyqnknrbjF3ipSmmLDcYIbOKelFSeVIJvhkvC4jn26Ddrkbxi9be3pwqyR8oQ==
X-Received: by 2002:a17:90b:17c3:b0:330:7a11:f111 with SMTP id 98e67ed59e1d1-3342a300367mr1473516a91.35.1758756803192;
        Wed, 24 Sep 2025 16:33:23 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53ca107sm392911a12.13.2025.09.24.16.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:33:22 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: [PATCH 0/6] Add PCIe support for Kaanapali
Date: Wed, 24 Sep 2025 16:33:16 -0700
Message-Id: <20250924-knp-pcie-v1-0-5fb59e398b83@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALx/1GgC/x3MQQrCMBBG4auUWTuQFgq1VxEXyfSPHaQxzIgIp
 Xc3dfnB4+3kMIXT3O1k+KjrqzT0l45kjeUB1qWZhjCM4dpP/CyVqyhYcphCFklpBLW8GrJ+/6v
 bvTlFByeLRdZzsEV/w+g4fuHf7elzAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758756801; l=1250;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=tlF/XmDSlCSzHpDbYIYkAuUDBatLs6VY5lZmH+8tSdw=;
 b=GhjB8yFSJhE3XlM7FLgPQU2mx4t683odAMUdhaUPcxG1u0zlAsRUbnig06Uw5wi57WJUJm3AK
 VABUOcz9YyuBnBBGiNns9LLItEdxBIUGRSTsNbmFS1JSSZCmADYc5i3
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: 6ST5fYhrFvCC1fYUmW1dO3PrIjw2qrgx
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d47fc5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=xicjnEbRADQpFcw3uD4A:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfXyKH4onqMv7+n
 sew9Vm+4hbSpyzu044hXGHmc8qvbVmfEuXA6FvaiLzldavSnIcHE7FsdfhQezVlINtknfozjOmW
 zHavKWCI+3t5by6juWkwwfcG49fRF9mbaFCwghInHqmsF1yh+ykDpQrFvmC3Gx+uu9FkR5aI947
 2NMSze5tn7nYXfKnEvTcuducMtC/W4WHNLxVd/1x/bzWhh+d1rs7dwFRmOTVnkl3mPSHAnE201t
 h2v6XDK07K2vhhBcUaYoZLQaq2W8krfHwPPEqu6P9dNQ8UNAdBjFK1YyYWKw0eu2BrTERg70LwJ
 I8LuKlAJUu5mQmSC6I8mK8iWk9xwORBu6ZcDe9wIIkARpQ8YRGYChIl1obXAWBQbK/dR/E2/GYA
 F/m1L0LQ
X-Proofpoint-ORIG-GUID: 6ST5fYhrFvCC1fYUmW1dO3PrIjw2qrgx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1011 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

Describe PCIe controller and PHY. Also add required system resources like
regulators, clocks, interrupts and registers configuration for PCIe.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Qiang Yu (6):
      dt-bindings: PCI: qcom,pcie-sm8550: Add Kaanapali compatible
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Add Kaanapali compatible
      phy: qcom-qmp: qserdes-txrx: Add QMP PCIe PHY v8-specific register offsets
      phy: qcom-qmp: pcs-pcie: Add v8 register offsets
      phy: qcom-qmp: qserdes-com: Add some more v8 register offsets
      phy: qcom: qmp-pcie: add QMP PCIe PHY tables for Kaanapali

 .../devicetree/bindings/pci/qcom,pcie-sm8550.yaml  |   1 +
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |   3 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 194 +++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v8.h    |  35 ++++
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v8.h |  11 ++
 .../qualcomm/phy-qcom-qmp-qserdes-txrx-pcie-v8.h   |  71 ++++++++
 6 files changed, 315 insertions(+)
---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250918-knp-pcie-cf080fccbb5e

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


