Return-Path: <linux-pci+bounces-40492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87102C3A8F5
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 12:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58B81A43643
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 11:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A9B30EF96;
	Thu,  6 Nov 2025 11:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FK9xHrWK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O7ogLkbU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1095730EF7E
	for <linux-pci@vger.kernel.org>; Thu,  6 Nov 2025 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428471; cv=none; b=SIs+6f5nJKQK3dv853oG0JnpEH/hmYV9Hl9WixNbT5lv9WIyAGIqTmsVz+WqumQD566GFu1GUy/eTArQR8pwAnLhiXf2W1XQr6pfLjgDT0nwJqu2ysdo8M+GZ6Cn5D8Qy5hxr1nICr5sycblkHNr6YVUe3ZMxtwgQPWe/PZB/F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428471; c=relaxed/simple;
	bh=/d0RShmJ4EWGDBU9WbnbcZYTaEbVunb7gn5q2MpqXAo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=INhlty4VqLEWpO7FBaDg4wjRql3pW+ryP06HmL2qkodND9wJ4/KPKk4PPigQGzmEJfEKmEDtJm6mn/y4P+Ti+lrmiMICIJnnZNHbC+ZljngDHOzI63PXF53fMryZ7PUVnopaLZQ7RSovOwHl2H+yiF7ZexdNkCRcQOxN+oBWLbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FK9xHrWK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O7ogLkbU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A68jdOO3383360
	for <linux-pci@vger.kernel.org>; Thu, 6 Nov 2025 11:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qdqjiv+hovojXSdUMbYsbi
	YZLigYh+pRDD7bJDGZx3k=; b=FK9xHrWKa8IK4dxgW6tFMjtZ7A72GfKf/xqJlJ
	a7X9bLg/5EOmagFa4/lyeAMnbTGftZ2xhvnZOC7CDG45jMT/dGze1/J0RCY0ZKGK
	2A34jbHBk/MwUUtHEeotatbCk6S67r0L2vvX/HkVlHpNel8HpCvwuEg+yFLKs1cV
	UJ3ywO+GvOeQibwzDA1fV03Og7iuiOH+AXLiHGaKm+3FMq04FT3NFYMvMkKHZwfa
	WlNGuAHH+K+X5U9oet918gA6rAisXg3ZFXf4OwulCVfS8r4gO+CCmpscXVrIAXgN
	uIuDZd3A/7WeaAJ+Uw/0VqZIB49DGOSzjSDPntNcJdK/eO2Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8reurdw4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 06 Nov 2025 11:27:46 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2958c80fcabso8233185ad.0
        for <linux-pci@vger.kernel.org>; Thu, 06 Nov 2025 03:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762428466; x=1763033266; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qdqjiv+hovojXSdUMbYsbiYZLigYh+pRDD7bJDGZx3k=;
        b=O7ogLkbU86GrPRqp2HfX8BtN+LoKZDlqjKJYvp5XED4uYN5BPjMsXbRCPsBfEQdKNV
         FK8Zx71tG+3vZ2vO2mV4iSZ+onP2Q/lX6Y5DooIHBlSfek+A73G79s75xwBzzz6rBWjp
         R0dVKq2p22i4OsoG598KXPcF4V8ugkFU2ftcqoY+k+DawTbf0kJmE88dJGEnO/2Q3z17
         Q+0DOPPOcBiQtlfRnE2BpLNyn03GPhgyTz69zYeeYyAsg1ZW1lfm6fOLp4ZnTYOrQSZM
         o7DuRTJK1tGSktQD67oH8jFRoIhh55m9Z/KDoUq8P+6gdOA67A5mTYx5bWePHfIySxsO
         wNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762428466; x=1763033266;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qdqjiv+hovojXSdUMbYsbiYZLigYh+pRDD7bJDGZx3k=;
        b=AaLIX9zrlQ4wVDPphAoYzvUtoDO3smd4lNzqyjHdDeiIC5OIB1tHBsb+tEktw2MZUL
         JHzOebfWlLkroo6Z7cQfjkSJ7pNSy3dyv5ntpKB7fk7rpRbm1J/EVgNhoZQZCRXwC4lS
         Hw860KBcvviE5zFcRjHoWZxZGv6x2Dkg4q7PEYKFCCcDo0dF6QnL1/cRMMU2t7tNFhxv
         xO25RCR4GoAOVnprKWjanV3XYAemr0QgQBU83nJYgeldSqLCa+0VDlC94CvpbdkKAUd5
         R6oGts0Y5/2K4DqwP/sPZrdetOaaQTpbCZseICqEs2rl4gz+ubfDshDeUINmgH4YOaOW
         wHEA==
X-Gm-Message-State: AOJu0YxSi9XAyI1IdzlfCZvwkao9ind4W0MX79nHm/QjbVRZ/diskPLa
	I35W4IDHfI4LlJgEnH/feOP7GB/a1YDO3qQNoMUABsxj7nIZjY4RjS2apQVvq+OnDW92XOSJQ/y
	4MR3alrxpvjJSwFzPX29wxWYb14xid+Ej/lvRnVtrakMEbBRNGENsq6zu5Xk6SVU=
X-Gm-Gg: ASbGnctFEklB0pEX0pfEBzGBLRKr1j38cGAzWuhKeOosg/+9AJKAJoKSYNwXUyP8IKb
	L4mXHwvE2NrFi/MaZ+OvmsM/wjp+2pn5Qm4ze0Jmv6VTtH5KJj5y+tTl2ZuMWHu8ohsfDhRdvF2
	bcQvwF94p61qJBq8yZSDtHCZEQw7Xs4Pip+QIMBT0KpLG90tdDr5eF4pTcwMHytHm/KAbogR5xE
	edkX+9tF8101BfAJO9p3gap+okGoQiiHuctlRr73chuzopQYB28GvwOlrslJKA5QR9O9Also3B5
	F7+AUQfxJM2/uYme11xH/sIzpnai8+6PQ6BeNBGy/VOkcnp8fsSnYyW9HSbbq2CltDIpmHvu+Qm
	Y1YX3+j5gIvy4YUdy0EL1pWARD3xLMQ==
X-Received: by 2002:a17:902:e841:b0:295:25d4:ff3f with SMTP id d9443c01a7336-2962adb1a92mr98456065ad.42.1762428465734;
        Thu, 06 Nov 2025 03:27:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeoXA/51ndlFT/zmxWq+rMEBEoTgVSD3HozP5DN0cQLxY4c870YiGuNmS1Wir15urf492row==
X-Received: by 2002:a17:902:e841:b0:295:25d4:ff3f with SMTP id d9443c01a7336-2962adb1a92mr98455665ad.42.1762428465218;
        Thu, 06 Nov 2025 03:27:45 -0800 (PST)
Received: from [192.168.1.102] ([120.56.196.127])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c94ac5sm25577495ad.92.2025.11.06.03.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 03:27:44 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH v2 0/2] PCI: qcom: Binding fix
Date: Thu, 06 Nov 2025 16:57:15 +0530
Message-Id: <20251106-pci-binding-v2-0-bebe9345fc4b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABOGDGkC/22MwQ7CIBAFf6XZszRAaAme/A/TQwvYbmKhsko0D
 f8u9uzlJfOSmR3IJ/QE52aH5DMSxlBBnhqwyxhmz9BVBsllJ7jgbLPIJgwOw8y0U05rY2zvHVR
 jS/6G76N2HSovSM+YPkc8i9/7v5MF48wobTlXU9cbc4lE7eM13m1c17YODKWULyeo9netAAAA
X-Change-ID: 20251010-pci-binding-7d4d7799c6ed
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2952;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=/d0RShmJ4EWGDBU9WbnbcZYTaEbVunb7gn5q2MpqXAo=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpDIYkETQWTjUMuA7NrFtSDVEROBzJJckkjDjQJ
 kvP306at/mJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaQyGJAAKCRBVnxHm/pHO
 9WRgB/9CK+8W6hpe+je8rt+P5MO7F2HlFlrO/wgz5Q3vlwqMf0cCV0SVOXvqVA153jb6rf6YSSV
 49YV/+tw3xDISgE/5dUp4TwxFCRXHX7OI10ZucJ6Nr98e0xJJSjKWcfXTihmbj6cHNIPI25zXiB
 D2PDILBPagpxfMtGeh/bbeaov++70JUBJCy5I7dRQwkm39OOyLA7U5AKRPjlL6tf8/4EImhCUgg
 SjJskjDDEJHCMT9eoX73O52iu3GAl/O1SmkLC6/1gCftETfx5lQcib1IrrEOmGE9pVENgdAyOFe
 F/ize2NIZe9y8rh5PrtBOPj2lDwfA47vUPLKiU84rRDFbo8O
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA5MCBTYWx0ZWRfXya1YzJzlBYU0
 84zvzPSv/FIogepOl4urZy7yIvq6T2vuo/156g5fOs8vUAz2fYR9EzmtwB3qLLhVnIEz1bI8bsH
 Y9iexbisYzONxAa9a0OCAJAOwpDqUKc4OQrioiWZal3vYEjOHoSZmInvrCRkqE51XBOD2adsoDd
 OAn3/ueeenev16bOg2onNEKeDF8dyuAANYFD088bA6n9eNwFgisZbaQxj6C3ulS/0eV1WHsCAyQ
 aCAs/pAtHm+FrpKsfvKRyWrS1Wt2+F6SI094QVa1yV5j+BsXCfQmhg1ypjVSCkBQ3seJ9EytlGf
 4BiWFcoTH0h5keTG4bv0wv+NDzlhvDn90yT6Lyhi4SgA9WCqxXEAcMKZFwYd4f0qLjrFWPnKLoo
 BH2zvBnZNYoTgnsdTxIH5NkGq3UcKQ==
X-Proofpoint-ORIG-GUID: iZmc2k_prg93-UNTRtsfcf0SG8I0bISc
X-Authority-Analysis: v=2.4 cv=RrDI7SmK c=1 sm=1 tr=0 ts=690c8632 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=NqeMpCPRvvPHbudmJ2rC7w==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=30HXYaYmheVzExRkvwwA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-GUID: iZmc2k_prg93-UNTRtsfcf0SG8I0bISc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060090

Hi,

This series fixes the binding issue around the PERST# and PHY properties.
The binding issue was reported in [1], while discussing a DTS fix [2].

The binding fix provided in this series is not sufficient enough to spot all the
shenanigans, especially keeping one property in Controller node and another in
Root Port node. But this series does catch the DTS issue fixed by [2]:

arch/arm64/boot/dts/qcom/sm8750-mtp.dtb: pcie@1c00000 (qcom,pcie-sm8750): 'oneOf' conditional failed, one must be fixed:
	'phys' is a required property
	False schema does not allow [[148, 102, 1]]
	False schema does not allow [[148, 104, 0]]
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sm8550.yaml#
arch/arm64/boot/dts/qcom/sm8750-mtp.dtb: pcie@1c00000 (qcom,pcie-sm8750): pcie@0: 'oneOf' conditional failed, one must be fixed:
	'reset-gpios' is a required property
	'wake-gpios' is a required property
	False schema does not allow [[34]]
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sm8550.yaml#
arch/arm64/boot/dts/qcom/sm8750-mtp.dtb: pcie@1c00000 (qcom,pcie-sm8750): Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'bus-range', 'device_type', 'dma-coherent', 'interconnect-names', 'interconnects', 'interrupt-map', 'interrupt-map-mask', 'iommu-map', 'linux,pci-domain', 'msi-map', 'msi-map-mask', 'num-lanes', 'operating-points-v2', 'opp-table', 'pcie@0', 'perst-gpios', 'power-domains', 'ranges', 'wake-gpios' were unexpected)
	from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-sm8550.yaml#

Thanks to Dmitry for suggesting the binding fix!

[1] https://lore.kernel.org/linux-pci/8f2e0631-6c59-4298-b36e-060708970ced@oss.qualcomm.com
[2] https://lore.kernel.org/all/20251008-sm8750-v1-1-daeadfcae980@oss.qualcomm.com

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Changes in v2:
- Dropped the binding patch that got applied.
- Dropped mandating the WAKE# property in binding as not all platforms are
  supplying it and also fixed the binding example reported by the bot.
- Reworked the driver patch to just make 'phy' property as optional since all
  platforms specify PERST#.
- Link to v1: https://lore.kernel.org/r/20251010-pci-binding-v1-0-947c004b5699@oss.qualcomm.com

---
Manivannan Sadhasivam (2):
      dt-bindings: PCI: qcom: Enforce check for PHY, PERST# properties
      PCI: qcom: Treat PHY as optional for the new binding

 .../devicetree/bindings/pci/qcom,pcie-common.yaml        | 16 ++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie-sc8180x.yaml       |  3 +++
 drivers/pci/controller/dwc/pcie-qcom.c                   |  2 +-
 3 files changed, 20 insertions(+), 1 deletion(-)
---
base-commit: 5472d60c129f75282d94ae5ad072ee6dfb7c7246
change-id: 20251010-pci-binding-7d4d7799c6ed

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>


