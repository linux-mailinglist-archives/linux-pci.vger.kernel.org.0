Return-Path: <linux-pci+bounces-10296-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9B0931A19
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 20:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A62CCB222CE
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 18:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE487CF33;
	Mon, 15 Jul 2024 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lS6agY13"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC36861FFA;
	Mon, 15 Jul 2024 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067289; cv=none; b=oTGcUVnDhedkfsmjTwRmqjVu1YR8bCqLcQNMuj43A4lDmTkgLGem4ZJjt2ay+4PY3d+AOZzrxN1LfL30gVQj+KFHRTPoZKLkS/MnSpFWM/PRZzpL59aYfdcgJATzUwNlGSYOaL8aO9Qgo2DYmyl6Ai+LW7bhdWVsx6qDznGHZ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067289; c=relaxed/simple;
	bh=ytflwCbndf2PIEdosUibN8pAfgS9K0ejUok9EPJ4FM0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMwWGAuqCCWXEAYxbYSwGq8GHnXTyN37Isi4pB6GPIXsfk/MuZWztU6mud+BDB5MuCfqbkumVvoXXQubaAB2Wio7vmct3riBtN/HtXjGAs4jQU3YfUZD5M1BOZu64YvWU2BMH0HmdkgNGxZfG/EHymmvemiRIwlIvQM507ybeFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lS6agY13; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FH8k9F002804;
	Mon, 15 Jul 2024 18:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=N7E2tf/VU0GjmPHehzNC2n8F
	/V5s5MVt9PCvkAORP6U=; b=lS6agY13ZMRvq9kWor5EX0geR2pfbfoXHT0jbzz3
	HRPtwxmyeVPnH8tbTwmy7wHxxuGTioGEYYoLwCKcPGaG65ITXo9H+76ck0ptdngk
	EFvwF9fBSAwmMtATqgPPEtv5K7hN3iXYpcHg/X1Hgt8gVLuYBhSbKBzzo8bRHbDg
	XfvtMZbxt/GXVac5WTDXZfSmWgz9VMck6Et/9hCz9G3qp24lc+hCNXr9AwH5kfjI
	p8D7dCVX87+kOh5AewRkBY1nrOsUdwbzWbNiwvQqxQVDnC3OXE9D2M8I2JlNWBed
	yPs+QhGU2u0jltuk41995E6KjIPUPIjZg0i2erbNQFO87A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bhy6w173-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 18:13:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46FIDqjv001419
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 18:13:53 GMT
Received: from hu-mrana-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 15 Jul 2024 11:13:52 -0700
From: Mayank Rana <quic_mrana@quicinc.com>
To: <will@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <manivannan.sadhasivam@linaro.org>, <cassel@kernel.org>,
        <yoshihiro.shimoda.uh@renesas.com>, <s-vadapalli@ti.com>,
        <u.kleine-koenig@pengutronix.de>, <dlemoal@kernel.org>,
        <amishin@t-argos.ru>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <Frank.Li@nxp.com>,
        <ilpo.jarvinen@linux.intel.com>, <vidyas@nvidia.com>,
        <marek.vasut+renesas@gmail.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <quic_ramkri@quicinc.com>, <quic_nkela@quicinc.com>,
        <quic_shazhuss@quicinc.com>, <quic_msarkar@quicinc.com>,
        <quic_nitegupt@quicinc.com>, Mayank Rana <quic_mrana@quicinc.com>
Subject: [PATCH V2 4/7] dt-bindings: PCI: host-generic-pci: Add power-domains related binding
Date: Mon, 15 Jul 2024 11:13:32 -0700
Message-ID: <1721067215-5832-5-git-send-email-quic_mrana@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
References: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: usOy6gXqrJqfYPRU27urlHDQpNYw_qcg
X-Proofpoint-ORIG-GUID: usOy6gXqrJqfYPRU27urlHDQpNYw_qcg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_12,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407150142

Add "power-domains" usage (optional) related binding to power up ECAM
compliant PCIe root complex.

Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
---
 Documentation/devicetree/bindings/pci/host-generic-pci.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
index 3484e0b..9c714fa 100644
--- a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
+++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
@@ -110,6 +110,12 @@ properties:
   iommu-map-mask: true
   msi-parent: true
 
+  power-domains:
+    maxItems: 1
+    description:
+      A phandle to the node that controls power or/and system resource or interface to firmware
+      to enable ECAM compliant PCIe root complex.
+
 required:
   - compatible
   - reg
@@ -172,6 +178,7 @@ examples:
 
             // PCI_DEVICE(3)  INT#(1)
             interrupt-map-mask = <0xf800 0x0 0x0  0x7>;
+            power-domains = <&scmi5_pd 0>;
         };
     };
 ...
-- 
2.7.4


