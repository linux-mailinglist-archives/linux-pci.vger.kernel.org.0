Return-Path: <linux-pci+bounces-40330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C64C34CBA
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 10:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764EB1886611
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 09:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79812FFFA0;
	Wed,  5 Nov 2025 09:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GwHPk0wt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WVO3QXq0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EAB3128C4
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 09:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334216; cv=none; b=G6N2CD5acGGwFAKX1G9nyFyIj3TrPKBEyCRiajIJb3YtjEijqjLpd2OD8hj8WZ2oMwh/4fqG/kqOTmRH8I1AkCRcIjvWi4no+VmqlUUSaAvuGlxiCAJuLyb16+8vIIWa7E9SUZjJ4uSeiKAQe/6i/uGY0+sCQ7ht0oTY/e4+GDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334216; c=relaxed/simple;
	bh=vNGFtql0TkKs5KVaiPU3EbeFeb54nkJVtXGFSv+d82k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sFDNrpibhrv9sBf718uI2egS/47XUvaKTXQjCFFMFAeu2Eqs+NCCcm54XDPNFHcKpBrIHFQP1o7m7Ur1yi5JsUzfcaJI3F9qQi+ZBYv4soDGpY7UMY031whqXKD+CVC4l2pyx8V47Qy83jzv/MFcvBxUBJ8rpElqjJchosZWqIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GwHPk0wt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WVO3QXq0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A54Y3nt4011378
	for <linux-pci@vger.kernel.org>; Wed, 5 Nov 2025 09:16:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PsvMdivlLb1u8imgIMqsYM8vQGjaomHhkwMUSd15O+Y=; b=GwHPk0wtFLVg35Nl
	3QajAS0KVrJXOPgdKKRi1a692MlD331M4JlACtCZUdrh2cuhyLPF4c6M3nECZcqI
	BOmo8ry5/wNlzPTehGxyMFpBjlxEGjwTfQ491YcuUxZsasCQwg2r9TPkxyA50xkf
	lzMXFruxivumaDrOo27Vv/iq/QMo+aTGBTY+hT4g57Qg9fPcKLw99vnQM5DIG9D+
	hkpXUXY/8bwTxTvmyCo8dHt6ycnxNFqio6WKvjhJFNO/XPfoP6x7d2I+ByN73PVS
	q/Co8jAtZS8yLt43x3qiGNC/AOAcPq2aQRMlZzC+d+QjA3J1xcPRQoaaLasd/fcY
	QgWAMg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7ynwrq2h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 05 Nov 2025 09:16:53 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-340299cc2ecso1218654a91.1
        for <linux-pci@vger.kernel.org>; Wed, 05 Nov 2025 01:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762334212; x=1762939012; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PsvMdivlLb1u8imgIMqsYM8vQGjaomHhkwMUSd15O+Y=;
        b=WVO3QXq0aHxZ9dzBM3IXtxPbC+XszyIOwf+Zs4pjZ5ya2A3qThNAa0H24atHrdqXSx
         ejJAyMTxTF+SL8HV1xKGIrL0ehGXigSUxzKKUWHKp0bx4mBuhScDFizu2HeBWknqJSJ4
         9LKvsv6qynyAaJKtPB+Vy7VUBfslk+mnVMI8wUjfSfK+3VXhUsKmNk+dYSoCyq0UfNNw
         5spPE83NQHsnzFRUtqp1GtNWCuZIvxciY60QQWxUlzdCoKbxNFDeWVLIZYaxL+9dcRZ8
         5QQUpBdR5Uye4f7T1Vc2ROKR+1M/a6xZ3jdv10j4L3BheK2PCPyYMmxuEhGZEbGC2tRu
         gIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762334212; x=1762939012;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PsvMdivlLb1u8imgIMqsYM8vQGjaomHhkwMUSd15O+Y=;
        b=NGJYionJ17Qmx8jo0KcJp9gGiV17zENPi8dtne7Bmn279W1A6xvZJmj5pszI7g2FTv
         wfSHBqQJYS+PhrtdCltAy5saMviwwXY25EI+4UdvYT0mk1+segUX3sXuU+ucLkuHLVvx
         lva5nSnSf0RLf5/Asx5n6AGHGZ5iUM7l+ZtYJL6+ANH1fcUJOGGxBNXLrnOYm4cD39fA
         XKslfx4VZLWtpSC2fe1pmuYgc1/ILLrT1AiBdeMBOCPPdM23qhHm9K3u4K5TnTFWUnqV
         qiadDDUGAuVqSClQLKnf1tWZ9iFb/4VsQPikIHM3csHdVODgmqXZVWc6sqaaVM4HTqRS
         WMNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkY3NaMR8+ubxW6IQsydGqyMPQTjQ0Dm/eRrsiumboWh8aIBLpHR33FXjaWhuEm3ljIANNg1CW0H8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBAQSN+33iePGJx5iJcve2aC8xR5B4weQO7Wte/xjgRBrIKSr6
	kdJo7bQ9PZ6WKqMfzFjaxmWxpF/sPqg+ZJa2J+nSJ30RlRwIO1IP4QW9qs2UjNf556yAskP/EaC
	nhR/YYXc8DQreQfefyuqc1zucRZJ2dyqSccKal+zqIS3gAAVOCKX4Uy/Wt5b0r04=
X-Gm-Gg: ASbGncvX+CAc60jHe5SiQkRQK8Msyruw/0m/fWaGcBsmxFTnSVi95mVD6HRRW2LPHAY
	VzwGTgJTcM9A+kqrKCOxTsuXoiAf/W6amRZRI/hdCVwpriP3KDUcfgY2/iwFDcGJ+7wgmZKsN1p
	8V3lpFKnvUI2m3l3rpO2vK3HEOvgia2tXeXVTYWYq0v15MitSHXtwm0psOQm2wQE2zAcT+xXmdk
	KNxmYfsyOfANEpVAmEtxuo96bJx5VnLPmmNa5JuJP3P6ni5eTQKLmfePFoKsUUaDOzjhqmZSJ4s
	hqSCC7gaCVsQiZvTBncryQYMtbUGalQIOIhg+H7e8SWZnZwxaNtSu5NWb/9hhG9LzDQh4Mj1gE/
	lcaZZQ5edLFfp1Ppj8PBpqUxyCI3y
X-Received: by 2002:a17:90b:180b:b0:340:bfcd:6af9 with SMTP id 98e67ed59e1d1-341a2d96eedmr3386121a91.3.1762334212080;
        Wed, 05 Nov 2025 01:16:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdkfEQO5EwZQcqaHfM2ZxF2RJTEyKeZ92D/5evi1SyRPQKg2y7+uM8gEnkID6U/DFqcBS/pQ==
X-Received: by 2002:a17:90b:180b:b0:340:bfcd:6af9 with SMTP id 98e67ed59e1d1-341a2d96eedmr3386085a91.3.1762334211516;
        Wed, 05 Nov 2025 01:16:51 -0800 (PST)
Received: from [192.168.1.102] ([120.60.68.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3417a385563sm2274249a91.0.2025.11.05.01.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 01:16:51 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Wed, 05 Nov 2025 14:45:51 +0530
Subject: [PATCH 3/4] PCI/pwrctrl: Create pwrctrl device if the graph port
 is found
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-pci-m2-v1-3-84b5f1f1e5e8@oss.qualcomm.com>
References: <20251105-pci-m2-v1-0-84b5f1f1e5e8@oss.qualcomm.com>
In-Reply-To: <20251105-pci-m2-v1-0-84b5f1f1e5e8@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1389;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=vNGFtql0TkKs5KVaiPU3EbeFeb54nkJVtXGFSv+d82k=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpCxXokpXAS6e+Gz8ICBzFYRedOVBNudMT1HWe+
 Gq3lKrjwE6JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaQsV6AAKCRBVnxHm/pHO
 9Wb7B/sEZ6BBfOxN6O2UdeREfQI7lxYM4PbKK0OOw/21XuR2RWAFfmH4XUSKvCnIk60/8/6AKdj
 CokyAFjPPeYNKaFciz0y5VuBnMnj+t24gJ9sqFw7q5URzggEKXa/aSaAfYGc2KOeFieiVI3F2Iq
 kXeh9sRFEhhH+Bx6E6gIU22ZKfRYfK3HO9rqHuHSAvTyMlVbpkZZrGsSgu4z7vRzVToPjGBe/1r
 12sArn+8Dc2vQe/G7jqo92ZCQ9WuqhaKWPOYU0gBYbCfZrKsLnj9EKnHsP/SKXiNXoRc9kk0ZKF
 ytYbEq5i1Jl9/F4+tNsdSoh+4DF0+JvLf4t/D6Vuv0R//6JR
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA2OSBTYWx0ZWRfX3FGGlSJ3S/wK
 xBgu7hR3o0uCsQL5MuRdHmT6uqBUcjbLLIu5UZ3ZA85+5a2mwCadIcRrPPBRLtxDc1SWFbdfgVP
 gV5ewMwOEGt+iS/r0RuSxydLjnXFcz9c5chNpy0K3qL/5TiJvca4+Gh29i/nnjqXgoJhoYiFcGH
 Hel1zkBJUJtduFGTqNpz7LOyQuPKakEq38L1k+f1tyTXu473GUNnEi42NKEcAQCVXIZYHvmL5au
 e6mNwfCOU5IapC5InGNvPBVRmRdiQUs5LHEiy60v6xAF6OErKogXtIeHRGAbS2ffk0zyho4n1zu
 uC6tRuf5W3MPKZao5TnWYfLO46Ytki140K6YkX9LuoAq8DK66HJ2IsDBTIIkdSqWENRjtM2LPEn
 euPpeimenfg7NuTMzZK4PWvqLdv7hg==
X-Proofpoint-ORIG-GUID: YqCTRl11BiqYnjobFNwg8tVQswZP7XSG
X-Proofpoint-GUID: YqCTRl11BiqYnjobFNwg8tVQswZP7XSG
X-Authority-Analysis: v=2.4 cv=IpETsb/g c=1 sm=1 tr=0 ts=690b1605 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=adoi+G5QptZiRYWGMQz2cA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=0pvPJS888BSDkZzuOKoA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511050069

The devicetree node of the PCIe Root Port/Slot could have the graph port
to link the PCIe M.2 connector node. Since the M.2 connectors are modelled
as Power Sequencing devices, they need to be controlled by the pwrctrl
driver as like the Root Port/Slot supplies.

Hence, create the pwrctrl device if the graph port is found in the node.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/probe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c83e75a0ec1263298aeac7f84bcf5513b003496c..9c8669e2fe72d7edbc2898d60ffdda5fc769d6f5 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/msi.h>
+#include <linux/of_graph.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -2555,7 +2556,7 @@ static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, in
 	 * not. This is decided based on at least one of the power supplies
 	 * being defined in the devicetree node of the device.
 	 */
-	if (!of_pci_supply_present(np)) {
+	if (!of_pci_supply_present(np) && !of_graph_is_present(np)) {
 		pr_debug("PCI/pwrctrl: Skipping OF node: %s\n", np->name);
 		goto err_put_of_node;
 	}

-- 
2.48.1


