Return-Path: <linux-pci+bounces-39997-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08921C277A8
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 05:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 488A4407695
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 04:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E12E219A8E;
	Sat,  1 Nov 2025 04:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="grlhPYuu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QnDammbi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28992877E5
	for <linux-pci@vger.kernel.org>; Sat,  1 Nov 2025 04:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761971409; cv=none; b=lVWD3LY4BukC8o7gJSI3rpTHs99CfPAm+t5bugCR22QLT2lx7EODT5WRw9c4B1JNerkrbfOS+uRlTbah60zjT6ML9IEUzBBtMLR7d+s3mTRKxcTSAPzlS1JNPRGyD249hQKprPb80SIvRnKP+DklyGJX6UlsONj09BZaTYaUOaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761971409; c=relaxed/simple;
	bh=hOzRlMRlpIFq50j9dDHMLuFdaWiwUzshHPxiwOpWbK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PCGF9Tr7MU83YvhzM5MoKOAO1/diXLYeyx4dKDRY1uGQM3AsCzeEVnUx8k4AbeC4mYkIqNoCx1oY+3ZksBjHBRizQ+spdX265xttoU/xjLsCZ9XuD9KzGnnO2ZDNPrzVIH5pdDAYbqBNZiOkz1Dv9jqq4qnYVFC7D+6RoRJ/evE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=grlhPYuu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QnDammbi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A13Ps3Z518658
	for <linux-pci@vger.kernel.org>; Sat, 1 Nov 2025 04:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VCqahWxJSH0GJ6HwC5OvL8qeWdhWmEk+RK3OoYwwn+M=; b=grlhPYuuRy7u9HPb
	hY5dmob/1WLH136XMzDHSCFS6OvyQW8uz9rDf7Fze8B4zbOepisIZrdLNtyK52/P
	hhhmY3eLqjZv30PmuAn8IHpFZIyY6ekTm+psFlrfaw0Di2U6zAwSYsdnK8iXMY9i
	f1p0lIhi8hw6R7dGyDdH//g6MDAyZCi/geNQKUsculA+EBiVXpf/QfhYSRuw1Hvh
	xdFfJ7rPE1ECCBMEppxpMYJO1LAQf8u8mrm9TIyZZwZDiAMaA+tPqNc55vywRCEU
	WJy/fVbdl847A9O7BjXvX98VQVxqotmNbln/2XG7u/heTHkktF80e1yCDomo1gXz
	2WcaXQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5a9vg2ht-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 01 Nov 2025 04:30:04 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b522037281bso1961276a12.3
        for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 21:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761971403; x=1762576203; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VCqahWxJSH0GJ6HwC5OvL8qeWdhWmEk+RK3OoYwwn+M=;
        b=QnDammbiKNZODLocg70nxJZvNkEvsstldn1ZJD7MVD7DvcLTCbdJfeC4/kXDUuhgdp
         GlSmOxSRqAwd2WrZycbBNPkj9Y+WKj/Ule+p+jd1zbfy6KiY55vNE6N8L3p2sC+XZMmE
         CVHs0Xqzu7YBy+NWUGbNhBnRBZE6q/JQ4ZUvi2NJh3aUWnxpbiyjMKKIniH/Sq6P3DnF
         hpix/lih5tftQg7EMECqVE6dDZYkhANo9sETmXo77TkSSTlTuMt5rr7Y0Gj5ibu3HtYj
         HoBIIVKBsSOVtB0yMJTIErDvkArc9KzzCIWc5req9DTuylMNhA/888SjalUUYwKTQSiW
         12EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761971403; x=1762576203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCqahWxJSH0GJ6HwC5OvL8qeWdhWmEk+RK3OoYwwn+M=;
        b=BORWJqS03OmgU5mfnGaf8dj+3H5xEFdJiHPJ+nZh9TMazorFGw6uJ8/MHw0BGPF0Zu
         Vwovpnqr0KAqSNNESU6QFgxgl/fFf2T04yTckSnuJbFoaATJiOmGaxaJikefiV9dqZyM
         o47D8dqAgz2B9wpujQArlenFU3PO4qYe1tyXyP7lNYuFQHrhvrf+BAM4Qc77S7T3SUfX
         HfCpJ/OTO6VpfUF89RxPKt+OKzAmekXlTXoIugtZoIP7fSh0v8tC3WEzoRfLC7vuasSr
         BDqFCXUHFb/BHNHia3scwUAy42p0xcQdYMN0wx965rGbaC5d9YVgsmTl9Pptucuj1l5H
         p/8A==
X-Gm-Message-State: AOJu0YydeHV6pX3rAGKonukMbdamGhTCroN5GKBm2tL+MnmAeyym7z20
	S+FMII3lyFB3dxdfXvnyiHqZSp8kzPBbxAkqwpL+IyclX4I2gq5ohzksU76hjJXGaIq32jrc3q2
	5khBN35PkCOgWxRWqNy62LhOOQqmG8sSuLGlGJTfNHN4/T0iigmcwB5FGH3waKq8=
X-Gm-Gg: ASbGncveWoycbzyNEmk14E4/D7VeENZy2jbbHmLtlapISTqRAnZ4dLOs5saxFkGVBXw
	ROa2Ti0iTDpwXt+ep5Um/J+SYuydAvh5x9EXOb+0fTquQxh6Nt0FpMNERP4pmvPp5/m3FrcqI55
	mItK/T1J6zIXzX/B2rJu49v1JbZydOy7rp53/yyx2y6dVbHRotxdMCavVmhsb/8O+YWKWIjNjGK
	DnUWFXwd+aT4Bl/n0u2UMtbcSbi/wfgpX72z1ie1w7BBs4oQuJsnALYF9+0NOtCJ8ukkLXxYIUR
	7CsBxiIpsvmkd0/kT9A7r9BpHTxWEiALLRi4TUHWuQKAqoWFIO1JgGYD6Tt3ntPjBm+Uz9BZ46L
	TnAuGJysTaXHo1FPLNTYmaeN5
X-Received: by 2002:a05:6a20:94c9:b0:334:9649:4754 with SMTP id adf61e73a8af0-348cab90586mr8300611637.13.1761971403123;
        Fri, 31 Oct 2025 21:30:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWduze7ttH0fM3SXqrm9M7DW4Z/7xe/Nc3XYQeEd4wKVo1kiDZdb6XskF1v6a8AcaNd0i4Jw==
X-Received: by 2002:a05:6a20:94c9:b0:334:9649:4754 with SMTP id adf61e73a8af0-348cab90586mr8300585637.13.1761971402661;
        Fri, 31 Oct 2025 21:30:02 -0700 (PDT)
Received: from work.lan ([2409:4091:a0f4:6806:9857:f290:6ecf:344f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268717ffsm42273285ad.2.2025.10.31.21.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 21:30:02 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Sat, 01 Nov 2025 09:59:40 +0530
Subject: [PATCH RESEND 1/3] dt-bindings: PCI: amlogic: Fix the register
 name of the DBI region
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-pci-meson-fix-v1-1-c50dcc56ed6a@oss.qualcomm.com>
References: <20251101-pci-meson-fix-v1-0-c50dcc56ed6a@oss.qualcomm.com>
In-Reply-To: <20251101-pci-meson-fix-v1-0-c50dcc56ed6a@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Hanjie Lin <hanjie.lin@amlogic.com>, Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1877;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=hOzRlMRlpIFq50j9dDHMLuFdaWiwUzshHPxiwOpWbK0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpBYy9zq4wJrz0r3+6uCkCvsMmwRZUlT46YYvOf
 J+G28QVziGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaQWMvQAKCRBVnxHm/pHO
 9T7WB/9nIC9CiMtsjFOltn8J1++MX+wQ/k98V/p+0MAawJkUXXMpCNwLStWI1NmCyUkr8N20efv
 MeYn4YxpBpJesUMCtMvd8rY0ZTPNM9eygq7GWsxlcIkJlD2vnxBlSgXs5sHGSzcgIIaXIaxG5EQ
 lPY6zr6SEfF6KM7y43ow45Qon28ey0xRI1EbMExZKnmclQKdqWq9HntetUgaZVMOvQTf2bXsZGA
 wTvDOztHqK9IKShy3PiYFTZc69Sp8rh6DLOV1pHf6lKsPPCeRfN9Cke2ROnJvnKvcXZIdTbDndf
 ymyWWbXKvW+eKG4O1aQbRvM997tza5KQp3LFXjTU1VPlJNz8
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAzNSBTYWx0ZWRfX6M8aI5CrOqE8
 UP27Dn5Slbzcgum2m8ySSmQrf1HLwIHC9XciAXpsrdhadLEOgO2mlfqmDC8v+AgjmspYoIiTMcL
 /PaDEKr9KSG4HoE+Cz2VaM7RKgVQY29Meb8mWPhipqN6fc6eSoecOqvLUa17VKtEXm/o++aqiXt
 HBBRkLLZ/RAQkX48XeyUOv4+yJkPpLFVTufcX3odVaUWx2iJePvYSGG523dUx0cf8XjjtUYXta1
 aClOGr7dbdZ9Sk5Qyd/42qSH4H55VMtk+Ee/iUyQAGGU5p3YIe7mbJjjnOOlZDMer2oX+BgRhqx
 ViLt4Kx2ytJqPh1e8CxAJoodpdPGawDt1hQNMFCrBbIwqzSjpJNmWNXhvXi1HDUviGiOTNvd5gc
 Ts0ldGiQmpbI9QI111fJVuStdbx44A==
X-Authority-Analysis: v=2.4 cv=c6CmgB9l c=1 sm=1 tr=0 ts=69058ccc cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=tsNw8QEO8ZJO9lGSRLYA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: UJqmtYdVtJ7Kqzm6WbirVVrxuTxkvfdF
X-Proofpoint-GUID: UJqmtYdVtJ7Kqzm6WbirVVrxuTxkvfdF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511010035

Binding incorrectly specifies the 'DBI' region as 'ELBI'. DBI is a must
have region for DWC controllers as it has the Root Port and controller
specific registers, while ELBI has optional registers.

Hence, fix the binding. Though this is an ABI break, this change is needed
to accurately describe the PCI memory map.

Fixes: 7cd210391101 ("dt-bindings: PCI: meson: add DT bindings for Amlogic Meson PCIe controller")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml b/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml
index 79a21ba0f9fd62804ba95fe8a6cc3252cf652197..c8258ef4032834d87cf3160ffd1d93812801b62a 100644
--- a/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml
@@ -36,13 +36,13 @@ properties:
 
   reg:
     items:
-      - description: External local bus interface registers
+      - description: Data Bus Interface registers
       - description: Meson designed configuration registers
       - description: PCIe configuration space
 
   reg-names:
     items:
-      - const: elbi
+      - const: dbi
       - const: cfg
       - const: config
 
@@ -113,7 +113,7 @@ examples:
     pcie: pcie@f9800000 {
         compatible = "amlogic,axg-pcie", "snps,dw-pcie";
         reg = <0xf9800000 0x400000>, <0xff646000 0x2000>, <0xf9f00000 0x100000>;
-        reg-names = "elbi", "cfg", "config";
+        reg-names = "dbi", "cfg", "config";
         interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
         clocks = <&pclk>, <&clk_port>, <&clk_phy>;
         clock-names = "pclk", "port", "general";

-- 
2.48.1


