Return-Path: <linux-pci+bounces-6443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0448A9F7B
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 18:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1CF281D17
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 16:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E6316F851;
	Thu, 18 Apr 2024 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OsyxNOVe"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2040.outbound.protection.outlook.com [40.107.7.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E3A16F84D;
	Thu, 18 Apr 2024 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456298; cv=fail; b=FufIgDf4JlqUSbFMf/I0A+R8kFJ5SZRPsxe2VEnXWYs1jLVhNuxc2uxJPPpPuUsubQAS34drPbvqWMMs2D0LSfIY+wbRZdBhL6feSe17Jsz9Z3cE7SqNsPxOAioqI871/zQ55TCKZrMNkRdnpyZB4Kx9L4BWfst5ApWMvbddg20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456298; c=relaxed/simple;
	bh=RGiIXYVRmfGJBV1HNXeAiH/lKJo/HvVSSGdFR93iLDE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hIGgqL/5s75tKlFplnBGLQ8gmpTYfBp2k+Lf0TSq3N3+ROXpseCN6nLVdxrHwSmBQpAkQNHCbRyQmQDDKoMpxyXlVLu+efhZk5ilqvL3Ak+uzFgqb53kcGz2R+3wLgMRZgP1cOd9C8ZUdYULRfS2JtInmbc/eRAXbpdnuBVKzVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OsyxNOVe; arc=fail smtp.client-ip=40.107.7.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVXYNJcUImx2L3ngu6YPWxQVXYmIcD/+i0cQA5AJFX4iIHUXLs2nxWia9FhQpjwAdZG0z/YWmI4EUMv4KR2Te2/07hLUlONO0B1MMyWynk7UiaRgvkgAG76NhZPCfS+YCyhO/tsh8R/NL41T7/en73AcyZm4YtCQUgg2fNJxMRVjQN3taajCYklJg7AGVbPhdTu+DxnFUMnKK54+rsU6EdwNsHcKNOBzHkO5qoBGKuDuxoEqAa/wgO0/vKWJ841emwVvSY+GdMlrx0nckHCb0Ommh6Lcf3KyOYVpOPYuo3V99JFCp1AEBhc52a/S4n0ZcUpCXBMoJ0vmqnwN70GsTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XJormfUbxmrv0piWzu3dWXoF2ecnIxqtssuoVKEuJU=;
 b=V6L2wlcwkMNENdQ7A+yveXk+uh6ERgk616JiZhHhi0vJ1zVi+x5CuFTx2wGkNAS2u1daHCjG4bcM8q6yEkkfJzsz8FSkQHohHZzXBbmZo1ZPhBGM9uDJMBi61O7uAPN84MZ+pElY+xg7pZfcw3d0NAgryvO3la5ZeseuUHviQ8Vux3MewGPE+7OTYbHgCykFuwTTRWVpA2QpAZ04IWLnZDyEW+yfRywpRCbdwFPglf6eYfD93WaCddV5vpEzKMmqq0WyCJ5UAQswoMb8kqibj6mHkgswXMUJZm7l2GYFgvrZUmpXyX7aZ562r1hfJTEKMsv5nTI/rji1maRM3BziJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XJormfUbxmrv0piWzu3dWXoF2ecnIxqtssuoVKEuJU=;
 b=OsyxNOVeE/+yk87V4IXMpG9noh1+AmQ0shTl2FnDLVvSgXn4kKo0mIA7ucrn8M0QUxXA9s+sb5bwJpeP6z6lN6THLY1uqan40FwlVBFICyuvaf51x+PyU7GFN0UAedh0pynb/hSQUR/dcXNd/lnjGIwkvGgIJhNv4weIriThpLY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9405.eurprd04.prod.outlook.com (2603:10a6:20b:4db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 16:04:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 16:04:45 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 18 Apr 2024 12:04:24 -0400
Subject: [PATCH v8 1/5] PCI: Add INTx Mechanism Messages macros
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-pme_msg-v8-1-a54265c39742@nxp.com>
References: <20240418-pme_msg-v8-0-a54265c39742@nxp.com>
In-Reply-To: <20240418-pme_msg-v8-0-a54265c39742@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Serge Semin <fancer.lancer@gmail.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713456277; l=1623;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=T7axIIwEU0hBwz5dW25mb2R9FYDj6emglE2AhxS6gq8=;
 b=p4lxDW6VYd3Q8/C4NJtzfctW5Dbm+A7Buf8c2W+dOQwvp5EzcT+NlgMboFEzxs15cUA5pY5oP
 muA6YIDz4uqCof4GrInHdKzDP+qHzxT5Mmxra2M4IOi+jx+iArshC+1
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR07CA0102.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::43) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: 1932e96c-8a6a-4580-01e1-08dc5fc143f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BRn/QL2w07fF4fzSzlGIXzOWRNd9cHyqHuhEPqWidsvtpl2ZTPi4zqW8L/AP5luq9bfjmO05K8/qH6ZcMRf3JHxdPTgiculiJubb1HEKhLW6rq6dPgZiPlkyNe9orvv21Dnnd7KTsNL5i7Le+tHrkr7qw+pLiW+wxYLdJvob7eX1ti3ib79301tlGGHD0kV32KszNFtcGJk7HaGjtklSWw1fJ2ZJbpYToQDuyqUn36ITYkNG0MBMaKmmd46APGIuw1FNPPtzDyR85KIbDClHtEQYGpSAfos0tTf3eoUuoqND9wRqZCddgzDWts41VMNLZHfgSLsXk6i6WPbZnC7/WzVKN6fTuHicOeLxPPxSIB+b8qkz1oG98EInOMKYzUIrqNh9up8hyAK3GwKJiVWFo/Jgth0gQaAddCJamBEJExwJLSU6VA2Mee5djmUo03i4fg1vRWhegGRCyB9LEeKD5sNCxtWZ4wE1eRh7FUxVc8B7bik49P/hor3cGeyq4+k3dLp4+bfGY57fSoORmeSTuF39j5af9lscqg+ZI2CWWYYakcHt9FSlmcZ8pDdlCtUxjqj0V+zLb2VNZNiQW6WMcOa+PFOHYWZQuy0sGW6AVnf01a+snmjJ5LYBkK3+0KXPs76hNZvV8bMlNYsOT6RvqWECZSbKFo11Z0gNQHCN20Jw9yG5OtiuiUrtGBf5G1vp09qwl4ceQSa8Nk1gDx79QNqB/doS+Y59k6MOAcHecR0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(52116005)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUtUQkVkZWVkY2JxbmRXZ0VvOHZiM0ZQRjNBWWpSL1dyeVYyRlFzeGlES3pL?=
 =?utf-8?B?ejJGQUtWSlJVeWpXOWtjL0lsakx4ak14V0FlTnh6dzJWUjc1VkxWUjVHRmpB?=
 =?utf-8?B?U2hhU2lzc2VRRU9scTEzR0hkcmNYbEVOTkVOMTJiZUFuaUQxZG10MFd2YnJq?=
 =?utf-8?B?QnByVTB4b1lRNU5LYXk5dmd6OFpGNitka2xQS2h1c0VqV3U2L2tJK1o1elpW?=
 =?utf-8?B?WVN4NWh5YndHb3hvRnZ1SERwemxBdFZubFJsaGl0Uk8xbG9hbk9BZXIxZkFQ?=
 =?utf-8?B?L25VdXd2NDdqVG5LTXJVUnIyYkhWeVBiRmlXR1ZOMjlZYWNsSGdyQmdtaStM?=
 =?utf-8?B?NkR3d1NPZlRXMmJ1NERTYkJrWUdzL1pYT1ZzV05uc3pqT1VRSm01Sk0yK2lx?=
 =?utf-8?B?cTJjSEtSazc3OVR3RThGQnhoVWRTN3RON2k3NjJFSzhMSVNOdmdCQm41SnBx?=
 =?utf-8?B?Qi9sQTMyN0cvSm5QSExteVdBTGtpMERDUE90Q1RJOW1KTFRNR1B3eHQxRXph?=
 =?utf-8?B?cDI1RStEcmJabEtRay92WHhEZDFCa3dNNG1KeUpxaTdTcGtyaGhrMzVQSkdG?=
 =?utf-8?B?dDMzd0xBWGg1UHdqZUxEK29YeS9TT1JNTzNOdWFoN25ka0EvNmdHUjZrKzFJ?=
 =?utf-8?B?UHNjY21ST0pnMFRyZHAxSHpyeXN4TlZaSXJnSE0rUnZHeXk5TElwM25QaTlZ?=
 =?utf-8?B?VndyWW1jbFNET3BkWUhJTExUVVFjak5mK2NEeFRodXlMMmQ2bDF2VFgvOEhE?=
 =?utf-8?B?WGppUkNMYmNDZnJubFExYmcxbWFOeXRpci8vaFhTREJCL09KQzJBYitYcUdn?=
 =?utf-8?B?TXE1ZEJNRXFqeFBaV0Q1aTZ1b0FlNFcrR1F0cUpTZVFaRFlnMVIvMkcwZjdM?=
 =?utf-8?B?eE5WdkgzMlNOTzcvOXZtOUljM0krSm9jQTgwZjVnWUlZdzhheXBtb0ZMWHNZ?=
 =?utf-8?B?V1NPRTQwUWFkalRzNkhQRVlOLzROUFdqd01qNU8vVWVUcjFIampGamxaMWhQ?=
 =?utf-8?B?OWdmakpDSklYN3F4QW9teWdXbFVuNm5RVTJBWDVTZlRsNTFaQlFkR0lPenc4?=
 =?utf-8?B?RWNSdlJIY05vMEUwZUlpY3BiQmRCZHhiK3VhMTlyaktSVy8rMExaR21LdXpx?=
 =?utf-8?B?c1BoMW02RmU2aTRpMmNDRWlzQ0hKV0xoOHo5OWNZZzZnL0lIZEZoSTRDNmFB?=
 =?utf-8?B?Y3BjU296L1NtUGoweFBnV2V2dVBCMzRLSEVxcHhaQ0dwZVlVK0Y2anFRaXFI?=
 =?utf-8?B?ME44eHRFL2FpVHEyMGN4Q0p2d0duamMyVldhOUJXbTRrSUNhRklaNW5PMTYr?=
 =?utf-8?B?d0NpR2hRWHVkNnF0WXhFUkdKQ2hwcUJtSWhlcVp3MkU0MHcwdjZ1N1N4YVlw?=
 =?utf-8?B?Z2VLTERYMUxhQXRDUXhXbFFJMXlMSWFzZkh4YS82ektwSTVVeW91cWJERmZa?=
 =?utf-8?B?NmhOZ2lWYjBKSHhXQXdYYlFuc0FGVW0ydXBpR3FNeGJkTUprQXozOVN3cDFk?=
 =?utf-8?B?dEdpa1hHNktRSnJwVGtFUFYzcjJHNzJBVm9PK0VPSVdOKzdaN1MyV3pkOWV1?=
 =?utf-8?B?SGtmRDJjRzlBWkhzSUdtWWp1VGJzOXBjcVNXWGIwL2kzRHJSYTNlczFUVWhT?=
 =?utf-8?B?b2kyTjM3WTNQbFNPeGI4emFoWW8wU3VsRmlWUmMwTU9RNEUzclZ1TVRhUW9x?=
 =?utf-8?B?MmUwQWZrd1drTlRqNHAzOWdtcUdQUllybXlkdEphWG5ycFdWWm1aMjI4Rkk0?=
 =?utf-8?B?OTZTTmplbzhiTU50NHZCbHo0YXRHMHdGYkRBLzBQOWY2ZnZUWm5PMGM4UnJl?=
 =?utf-8?B?eDN5UFBTckpZODQ1dHpXTXppdTVmY3ZvcTFkcUJydlRpZHdjYzNJRFZlQlRT?=
 =?utf-8?B?UTJPQUxGTGRxa3ZydytTWUh2d0ZzbVlZUTBidHllYm9JcjdaNDRiTUwwRXNu?=
 =?utf-8?B?eGxmblBLVHpVaHlCbkpZU1J3UDJNN25ZQ3hZYndlSS9jWTdCcEcveU1rV25D?=
 =?utf-8?B?ZjJxRnlIdlNnTlNwOXFPTDRKOHp3RE9pd2UwVGFWdWVDd0NvMVg2Q29MY1RZ?=
 =?utf-8?B?TGxxR3RQbTcvQWhVQVNXU3M5a1Nkbi9EK3d2K3Q1Qm1EVnAxKzl0cUQ4K3JK?=
 =?utf-8?Q?yrnYChN61x7+jYmznZa/6IfCB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1932e96c-8a6a-4580-01e1-08dc5fc143f1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 16:04:45.3967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVgfolfLF+SzLbZPXUQMCcNqVy0RpOcYwQK+VuFEM9Wl9RoWdGS8PXS9d0Kbz7vYLZLGXuJbCc3mH7uQpI1SDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9405

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Add "Message Routing" and "INTx Mechanism Messages" macros to enable
a PCIe driver to send messages for INTx Interrupt Signaling.

The "Message Routing" is in the section 2.2.8, and the "INTx Mechanism
Messages" is in the section 2.2.8.1 on the PCI Express Base Specification,
Rev 6.1.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/pci.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 17fed18468474..02f46875fe2d9 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -22,6 +22,24 @@
  */
 #define PCIE_PME_TO_L2_TIMEOUT_US	10000
 
+/* Message Routing (r[2:0]); PCIe r6.0, sec 2.2.8 */
+#define PCIE_MSG_TYPE_R_RC	0
+#define PCIE_MSG_TYPE_R_ADDR	1
+#define PCIE_MSG_TYPE_R_ID	2
+#define PCIE_MSG_TYPE_R_BC	3
+#define PCIE_MSG_TYPE_R_LOCAL	4
+#define PCIE_MSG_TYPE_R_GATHER	5
+
+/* INTx Mechanism Messages; PCIe r6.0, sec 2.2.8.1 */
+#define PCIE_MSG_CODE_ASSERT_INTA	0x20
+#define PCIE_MSG_CODE_ASSERT_INTB	0x21
+#define PCIE_MSG_CODE_ASSERT_INTC	0x22
+#define PCIE_MSG_CODE_ASSERT_INTD	0x23
+#define PCIE_MSG_CODE_DEASSERT_INTA	0x24
+#define PCIE_MSG_CODE_DEASSERT_INTB	0x25
+#define PCIE_MSG_CODE_DEASSERT_INTC	0x26
+#define PCIE_MSG_CODE_DEASSERT_INTD	0x27
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 

-- 
2.34.1


