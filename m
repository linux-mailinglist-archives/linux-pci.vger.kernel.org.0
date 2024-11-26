Return-Path: <linux-pci+bounces-17318-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C209D92DA
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 08:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D990165196
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 07:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD2A194C78;
	Tue, 26 Nov 2024 07:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qyuja7RK"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2087.outbound.protection.outlook.com [40.107.103.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07769194AF3;
	Tue, 26 Nov 2024 07:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732607865; cv=fail; b=Qx1motJ+x9aK+7+A7WIdqiELROLf3d93PBHTooXQLSr2Wf9XMyfRS403vLXybBNUb14q1RXhWgeESAxy1oE66pVmCwLucwroscbvUcnOYcorhCtjkrC8zaTPNU8SBtafbAkOuD+pHsxOhAdVyjzTX4lFmEY3lpDFPKZIUkH2jbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732607865; c=relaxed/simple;
	bh=gFwGN6ityCrq0ZxQdq2M/7BBTCUW81qEOGOy2Gn49HQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RwzYcjkVtEEABP8I9ZZh/lP1mxaCWO/lfDlRsvMYy2FCed+S4opYJDFGFBPBnM1hGv4uOVhqIhxPyXydQFsroinCy8dG8rhIx08Vbk4GyicsLRqS0iwUFhiQ9+XTMeIaANph6qbsVDIVMJlNjTnmRjgJXPacByXNJ/ztJskHl44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qyuja7RK; arc=fail smtp.client-ip=40.107.103.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJwk/5Qfje2vDGri7Uxo/IsRXRglUMzvaEc6QMiDDEwM3LLucEWN0bJ2u4smRFezpQo3EyrfVdZMFrp09V2y65B9G4X5WkfAd/YM9CW5hz9CU6wxr7aY3pFVoUNuZ3Ltwqt0MNPdKUMrLTvOApMROTvXM6rgRqKVqoQL18xA62EH765DhKE7kqsI99jfX4dkc9sN3MDCehgZwGVd0U5xOnepRf4Szr0P54ydGWpUhMOAIkVb0dWMuVFU3MWiNjMoaviLWUe6cE/B7K8j/1JNJt16sz4Z8Dp6/nHx61LkaMKKZaQxFP2WJHvJQvCab/lU0l8AuPX4GIxZXF2yEI+l9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lEthi81Gsz1Kd1TZJ99UEX/wS69W9ebgwoPRJ+SDZk=;
 b=BX525OW6A52lWrk4WtNGozWrSTjtAZZs1Y0yDnNuwev4HxjG6ezZbq+rZcg+haInwbye8pE7DptMu2IkRrpW6HK+K6ba+Wc7fFi8d6pXN3LD0nG4x5vIcxB2KWPRIf1SckSWjZ9TFLQAuuiUL1e9Ui/IpgD7CoksgjFtGiN9MGJPyj2uhCB7lrhf3UllvTkz5JdES5j0w4PUiRdyD9sZ4gCZ53HfNr1q07kScmAHdlWZxenWwTaEA2Kz8VZCLKF1jJPSNakiX9nGdOvlnDPcrzV6ahaF7oET9Vh4PfnLae9HwLYkbCZHQx6ZtBQuv+VuLxmJsArjzkxSJpnTE57hLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lEthi81Gsz1Kd1TZJ99UEX/wS69W9ebgwoPRJ+SDZk=;
 b=Qyuja7RKhErvGHe5V7Yq4GLf372I1N68w/hRzaRmvaY16FnOvU3nCQmaGgtWyfGpl/GkxEPLYgpPVMTsL2OQm8I1dQfX6a2lDgSYqWfmATvOnT7C7hlpbApR1CbXPnJuZFmxRzzt3Xr4AsaAQnCkO9+EIpEmRBTw11G+9aVFTmJdpFnei1F15eHEKHWj0jI7WlZ4Hh08ScAb2JMgGrQ1aMOV0Qxr8mxS/ScP3H9y84b8O5UL5bIAqR/8/DQrv5Nvd3U10iWODJijvPYIbbLHQhOehuRklVDMe+zYgAJRclP8rh58mIjVqMGJT9rP3AbodHHXsXCS4PhFP+Rm41xzWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB9PR04MB9401.eurprd04.prod.outlook.com (2603:10a6:10:36b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Tue, 26 Nov
 2024 07:57:39 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 07:57:38 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: l.stach@pengutronix.de,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	frank.li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 01/10] dt-bindings: imx6q-pcie: Add ref clock for i.MX95 PCIe RC
Date: Tue, 26 Nov 2024 15:56:53 +0800
Message-Id: <20241126075702.4099164-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241126075702.4099164-1-hongxing.zhu@nxp.com>
References: <20241126075702.4099164-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|DB9PR04MB9401:EE_
X-MS-Office365-Filtering-Correlation-Id: 865cf392-f374-4030-b1e5-08dd0defff25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/b/QkmvxPUwqxg5zhuAyCj0brZMfhMm4LGxQFV48tJwE7oyWQ1Kz3IeywVS3?=
 =?us-ascii?Q?TGwFWy0aTNwhoT4ZkvYOpWrg9fNCUh7IEdy7u11iS1ZskBflEY6dgepWnJQh?=
 =?us-ascii?Q?e0T7OM5XCaNE+WUP2K3Y2BrbPyITeGlmAvQuL48lsjixaVrGGw6QyvbovD4r?=
 =?us-ascii?Q?bVfga8RCORmHd6R96ne6er0TPqdpbhA8MR4owgPnrtdgNNIobMWysN3TNExC?=
 =?us-ascii?Q?ZRMSc1uETBd1ERDrtwUdR0cyQuMl2Wwvg4W25NUhy2A9DTpDOzSrIsB/mcOK?=
 =?us-ascii?Q?RE5xxfsY1e7C4EC0HuF2aQH60bOgCEoDv7SU1Y0BIp15wot8tUJPtmej2/2O?=
 =?us-ascii?Q?yZAWprtZFwP3PWeQTFIO+j6dBcgZq148VcfUVHCBlubtbH69v6JkICga55DW?=
 =?us-ascii?Q?UvYiZLp2r6dFPaW1CbFNMt0NSPGxQK/D4BbWkx3Fa1VIHrr1IxiyHHTJet7V?=
 =?us-ascii?Q?Lg+5J/0dh+wKiJnelMcFdyj9rhTWxMAlGfYwxiaHNLoPazRs3bD5RRulCY7g?=
 =?us-ascii?Q?tWxX05O0fjsUb/gdxXYE/pfydvoDwcSAtik32A2SAJMimUBEuJB4PKmiZ61h?=
 =?us-ascii?Q?V9xXlFwkXiYYCZhjQoTUfamvh1EkfGxmTgEKHs5z2fUhH9/JWoWaXO8Z1qgb?=
 =?us-ascii?Q?YpaB6i+9wttlj8pHMzaX4F09UmVSnCMjvVkih0BkINVs/r/Y9CJ3hkeOH7mC?=
 =?us-ascii?Q?6vzA6EPBQ3slYN3ZXu0EwTUX9gVRL5efLdDuLXl+nsbd1CS3KNKTiHroCrSf?=
 =?us-ascii?Q?30XgnQYD8Bn0MNQNDwIkeZjNXf22Kzp+RoQTi/+cb3qrcHhWv6m0VRLpGKNo?=
 =?us-ascii?Q?fy77vcUWI0iS2VB7W1Mrbi7pN5R0HzPk4lnUGTZ6u4Fzxc2PjKdRgQKSRBIg?=
 =?us-ascii?Q?E3xpJrKlV3cXkXvtMfipDpZJRSXW9RXLyGVpY4ZfBfHYgeA+lDDio6eIlsoF?=
 =?us-ascii?Q?xA7xQZu6QCMQDPG9WIBfh0cdkKJ3RVN9eobU6ZaLPyOoN7u5YZAy8wuyoeD6?=
 =?us-ascii?Q?Ib4kzVQtPJ3WeAOBe5+q3dJhT6N/Q82EDeapm8gfxjJdVqGFXTc/pXgcQq2h?=
 =?us-ascii?Q?FLusWhyFdvr6rbr9mHmdgg7eNlgw31PJy8AMReW6aQIoW2RH30TIcbzLJQwC?=
 =?us-ascii?Q?EyqT0nz1cSatLSvLJbTrHxDNkixNi1nCZxXnoSJJeB3KW1+9V/2qlhOFiC0m?=
 =?us-ascii?Q?ZNytD8IVu5AbmDU5+t31mHf45wingo4+oe+IAM+qq2pHlcAMFCq5ie/oIH69?=
 =?us-ascii?Q?uOT6OqX7yMp3QA9WElltyHOlaGYmvWsCYDJrLXttvFoEEupr+EYkS3B3PJ69?=
 =?us-ascii?Q?vHJwO0NQuUnIWbdEhh2yIPLqShxfgyu07brVkxbsdKBtAZSVuaTvonOMO+ob?=
 =?us-ascii?Q?olK+5Kg+UGDefgLD9nXGH68sQm9D/aO7dv4JDwKOE8t2RTMJPEg6gI5K8du6?=
 =?us-ascii?Q?Z+oaaqoSWVg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8sVrHGD89rXAMVzzi2IREJs6l+dF/0L3EN0qgJ6mic4NGw7zudktfcV/MuBO?=
 =?us-ascii?Q?zq03MzJQ8toZ50gzYBohOcRdmMymwPdafVWS9QpCrs8qx4yoJEki/F0lBYSV?=
 =?us-ascii?Q?/Ez0BL8mkKnlox0kn4p2p2/Vs9xw0LZDctuFmFd+YRYd1zFQOuMa0qr6879E?=
 =?us-ascii?Q?aC+5AbXmn8d8JwwpGB3ho+mWPt+3k0SJU40lPB736if0fQs0Aj6nLXMc4DKi?=
 =?us-ascii?Q?2lqsPaX1CO8Z1L/B3rcgWoSAI/XnLMnHyosSHynbMIriZrOQxTduMg1xE28M?=
 =?us-ascii?Q?hSAqGsyNXyAlZwbAK8YGjsVj9fXlLU2c19B0EBZkZBREzgeMGaO5LKd3LK2Y?=
 =?us-ascii?Q?9Ij8KF8TTMol/qrQ89QkbvumA60Uv2cbcrPIsTlgbQ0QbjQzjGry1SiIjAUI?=
 =?us-ascii?Q?QppYEROBaKOkjy7tUfVGNwVA+w06mfWbCA+aEDyz3RU9Gy/O/RAVMDV51dIP?=
 =?us-ascii?Q?jwN8mcX4Jz4hsH1Qs83SL1AGL6tB/PhHLDvKW3D7Z/il/yn39PUX3pikQBfb?=
 =?us-ascii?Q?Y0iAG9h/l3UjkMA5USUeXD539fOXX/z4gcWUtDxoTJFPby2Tu2ca8wJjgpUk?=
 =?us-ascii?Q?Yxg5xoOOY7sprOW0LeXc7BUi6HEPd7uopzVcEGY+j4k5tXQW1TGImbZysmdX?=
 =?us-ascii?Q?Ofebd5wFqVRoxfHf/9JlP7vWw+uL36IAMTcfZ3WeBjibGE1sPcJ8QgzfLPzD?=
 =?us-ascii?Q?e1NJAvVfh350UNr62UsCTKFydFwcTYA3bG+ZBA27SArEVSThSHheqzFbflew?=
 =?us-ascii?Q?0BkaOS4sJYYJlMRB+s+9+FnU8sg58DPFbtVQIkVnX0mStRiLNaUtDVW0G7yc?=
 =?us-ascii?Q?ZjAY8wG5q3qhivc0XC3WMdDFvm/VXwkGGC2++pZAv/QhY0fNAe9sTA9zr5pe?=
 =?us-ascii?Q?H7MibNPaT12Krys1Q6izL3KQFWtPIdtNHRDR5sVSH0X1LJUvImBCYixr8G3t?=
 =?us-ascii?Q?6h3D8nq5HcDQM4jSSr2cTsuRF83t1brcVEHpaCUg5iaIqWNJO9yxyOw1JfPo?=
 =?us-ascii?Q?XRW7/7osBT07vG+n7cgLUog/D6OPHT/Xzi5NIp6/q1WJyoKhbLxRoXKBNsGf?=
 =?us-ascii?Q?sH3x/lO/kCyr8x4ytWtU24qxLJiatq7tMyPMfYZHJeeSu4sJXUKYT2wGKWeo?=
 =?us-ascii?Q?eQxVu8WR4HBm86MPYKnT22Z2n2fm9GOSjjviOnw4a9vyiN0Hw6bC+3WNksoa?=
 =?us-ascii?Q?BTtwaYgmh/0XmH85kg6X0kjvSyXNewhq4UG2lhH6/8BQtYYrU4JjMFknhyrO?=
 =?us-ascii?Q?gbFbXit6jFdbKk3iaMu9ZQTaMxuE45coBe3qhAivED6EDz9rYNyIi9jmZIc5?=
 =?us-ascii?Q?scgk6z3NCHij+2B93218Esac5ij/wvDwz+TPknsi7Et0B4shyuVEeeCYXDol?=
 =?us-ascii?Q?VRZTy4Rl4B3pz+HHv4On0AaAVMahGQ4Mrgq2A5uhVlwsX6L89UFwOafY6SCA?=
 =?us-ascii?Q?nNxj3Ew77gi9EIRvv2WHP/VueiVslCT7mdG/c9x6lZpCiGTUSeC1EPAmdkZn?=
 =?us-ascii?Q?NWkUD7HjxdhQ79R07L4x1BFCRwwgmBcMB6HG9mYDfwHyDn+64zuz5mgwZvyB?=
 =?us-ascii?Q?ml8iOkWkvL5AsvJ45Pfla7hWuI+nFQ5aqOQy9WI5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 865cf392-f374-4030-b1e5-08dd0defff25
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 07:57:38.7517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dmh8Anjl67+9j1Xzq6HlRlJuP/SruxtQdIO18exoy8Ax2kYjm3cYJShgaWJM4KHzcGBnwM/cMSvxWVi6tJ+68Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9401

Previous reference clock of i.MX95 PCIe RC is on when system boot to
kernel. But boot firmware change the behavor, it is off when boot. So it
needs be turn on when it is used. Also it needs be turn off/on when suspend
and resume.

Add one ref clock for i.MX95 PCIe RC. Increase clocks' maxItems to 5 and
keep the same restriction with other compatible string.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pci/fsl,imx6q-pcie-common.yaml   |  4 +--
 .../bindings/pci/fsl,imx6q-pcie-ep.yaml       |  1 +
 .../bindings/pci/fsl,imx6q-pcie.yaml          | 25 ++++++++++++++++---
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
index a8b34f58f8f4..cddbe21f99f2 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
@@ -17,11 +17,11 @@ description:
 properties:
   clocks:
     minItems: 3
-    maxItems: 4
+    maxItems: 5
 
   clock-names:
     minItems: 3
-    maxItems: 4
+    maxItems: 5
 
   num-lanes:
     const: 1
diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
index 7bd00faa1f2c..0b3526de1d62 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
@@ -118,6 +118,7 @@ allOf:
       properties:
         clocks:
           minItems: 4
+          maxItems: 4
         clock-names:
           items:
             - const: pcie
diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 1e05c560d797..4c76cd3f98a9 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -40,10 +40,11 @@ properties:
       - description: PCIe PHY clock.
       - description: Additional required clock entry for imx6sx-pcie,
            imx6sx-pcie-ep, imx8mq-pcie, imx8mq-pcie-ep.
+      - description: PCIe reference clock.
 
   clock-names:
     minItems: 3
-    maxItems: 4
+    maxItems: 5
 
   interrupts:
     items:
@@ -127,7 +128,7 @@ allOf:
     then:
       properties:
         clocks:
-          minItems: 4
+          maxItems: 4
         clock-names:
           items:
             - const: pcie
@@ -140,11 +141,10 @@ allOf:
         compatible:
           enum:
             - fsl,imx8mq-pcie
-            - fsl,imx95-pcie
     then:
       properties:
         clocks:
-          minItems: 4
+          maxItems: 4
         clock-names:
           items:
             - const: pcie
@@ -200,6 +200,23 @@ allOf:
             - const: mstr
             - const: slv
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx95-pcie
+    then:
+      properties:
+        clocks:
+          maxItems: 5
+        clock-names:
+          items:
+            - const: pcie
+            - const: pcie_bus
+            - const: pcie_phy
+            - const: pcie_aux
+            - const: ref
+
 unevaluatedProperties: false
 
 examples:
-- 
2.37.1


