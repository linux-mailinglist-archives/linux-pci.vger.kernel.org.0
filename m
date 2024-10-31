Return-Path: <linux-pci+bounces-15674-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC7C9B75D4
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 08:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C4D0285ACD
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 07:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E6714D6E1;
	Thu, 31 Oct 2024 07:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ffq+yGO/"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E53615443F;
	Thu, 31 Oct 2024 07:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730361429; cv=fail; b=dvGarZn7MEBlFfuxJzIuScToHTso57U8t5Oe/Y0O1OF6R7X2VdZ+E9Vg+4a+DFG5VhZQn/uPBbel1gPoBOTrC+mWXLYJ60gD/jF9P3qY4uhmyQb/92tLlS6OWbnV3UOpXZof1ZOpIbi0XgtvD7ESxmYRzbRBKt1vGBmojzeEsCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730361429; c=relaxed/simple;
	bh=Mmo1xscLTlVQkjVIAV9EfjQZxTeKpeEgRQ6ZOQA/96Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WJ8wdjhM//Y9Ews2ttPuGNjf+olD6D47qtnVPhEVlSsB2seJ+4wrnD3NGpSDoUWjZkGf3uB0rJEKVPy66mcfT8ednGh511siZ4cEl9HSluS1c9y8NR3PYHfg6Jx/cIbV7IJhCdDgQqllDtYMmzyYDfRpNg7/aBQTu1T/ThIL0ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ffq+yGO/; arc=fail smtp.client-ip=40.107.21.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oa0zHIgyEKcswg4Xle2CVg74Zp8EYf7lga58zzNzKUIIrQcM1RZxNmLSEUEjXge3dH8lSGyNzfJ4jKZ746y2VjhtpwPEpT9OVFDrxTGcNC4yPg5+A8GeaLQY+WCYvsrziWEvo74NL56HWRCoK5LUY4hUK5TwjdP5Rdkaf8UYXPEa4EMa5M/IzaIF94UOOl/YXS9Eb4L6iMLgWLDsFk6SNi/duJzLkjJowHY5Nv0mMn3fnXC3G1uK8vdFV3AfyY/l6HiKAv2s/jUUBWGKG2K99hqUuqTtPyIv4uTPvnERSPo4ymHGw+qjggTYDDmIopx53LpsTXVRRWr4K5SqRngG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6bJ8ZdNq0jbMIzriN3qMBzZw9hotPrRliUnnqNdEcc=;
 b=Y05Luh3LjPzlJuayVUlGlYWHcFLILYmCRfsoOYZ0KeVJ2GWO207T50wiNW1tNPX2ecUrguOUrn8J+pdszA0R8/FK/NtOBQnyK1cNnIq3KRD1qiYj3GIxn8zI3Xw4SQUOiFe5TZtYZnb2AAgHKwt+J70pC3IE9wl/uIifaxAPvvBwvzgxRzeIDyGv64GPYRFI+BUio2hWK1Eqhs4RcEaIYYdtTJgblZrKQLmhbEQHwpf1AWDNmGm+DbxTArvlm17gSZb+MalRX/YjmwKc2cDByN9KjTtHtq55wohuN93SewZlX5yI7HVfuqr0FZeCBgMaBxkdw1zwo2hZRC18Jl664Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6bJ8ZdNq0jbMIzriN3qMBzZw9hotPrRliUnnqNdEcc=;
 b=Ffq+yGO/oDwIrN6SsUJCsvyDwrhwt8Xk0C1GmfmDn1h0fnlx48OaH2xAhhcW/dHgQN91givYWUh1ENOBI1s1HCtj4leMf6Cynz/AIjvTjTjq9lRmzHeG48Vqr5GZwDKBxIf/rdoslpHt667YYLhrB17C5V3hYgayIbKzzG649Pycj5XsRwZVxeLWIZZ3Ns6VU73TsceMVon9pg4yote/bEi6YqVIrJBEBRT9uJdkclKTmpsIdwNHJPYN0sMVVi23L/RlFNLX+tg7g3aul9yiKjjyXo50ev5hOmpBCEA7iCGlTAerODsetORCk1PR3+zXeDy1oLyom1nlQebnlzApRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB9PR04MB8139.eurprd04.prod.outlook.com (2603:10a6:10:248::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 07:57:02 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%6]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 07:57:00 +0000
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
Subject: [PATCH v5 01/10] dt-bindings: imx6q-pcie: Add ref clock for i.MX95 PCIe RC
Date: Thu, 31 Oct 2024 16:06:46 +0800
Message-Id: <20241031080655.3879139-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241031080655.3879139-1-hongxing.zhu@nxp.com>
References: <20241031080655.3879139-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|DB9PR04MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: 65bfc6e2-c5a2-4c0f-645f-08dcf981998d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KgtJyVRA/uGEfu5GyBNf1kO6yILWYkZLmqMzfn1I/6dEgTFXkU0sgVvdjbOM?=
 =?us-ascii?Q?CQvP/CRGDSOv+NmBWHNPX4L1a/nF/z/d3SVcP3UIvN0OkwsKpe2/PU1ftbfa?=
 =?us-ascii?Q?H6Ih92qIiuviX2XkC0cjXwXQVXCtre8csZpMEBjxj2Ie6s55w0A/JJ8yk0fy?=
 =?us-ascii?Q?HrGjK5l6T69mxdN7VC7yZk9TnFq8AyaJ7c28gZE5Yni3BbAm1k1DIBrsoZFg?=
 =?us-ascii?Q?qWY8cnba0ojWM0pW1vw8/nFR7kSNmzysfMbsrvOjbqyWHnKKV8+6eNYAzBF3?=
 =?us-ascii?Q?RMz1VhX+9giwSKmzM+6Qf+RumphawAPUQlZ5aLwpo/k96aJgG09OpGJfcdlX?=
 =?us-ascii?Q?WCjJyw9qW8qK7hRddlCjNIFFNg8KAB2RSaVIfIn2fIotCQg+tcYt+hZIa6yB?=
 =?us-ascii?Q?WLysGmFYIjnZ18T5eq2XK+EkSu0kNetkKCWMDNfqP4EY4n9NCPNlRW8A+bo1?=
 =?us-ascii?Q?FOo33UaMaVqt1wdxjPO121f+RmktrEKoLLRAJdgW2Rt7wGOqTf1/VtEw3DH1?=
 =?us-ascii?Q?aX5gJlCv9IJTJ86sqmYzonHD7eNm976gCt58ofPRVC0OnG3NastNL8y76hlb?=
 =?us-ascii?Q?FkTodU56pYiW3c/x2FY/Mqe9hgJe3ZoHsyyHGf7XvI/rBpNi4/5Mpygdth/R?=
 =?us-ascii?Q?/3/FCMOcZOec7OK5uRpSEQGPei9vni94yoRfiJ3ifmVhIK7wSwqQJXt9Xyxx?=
 =?us-ascii?Q?MhtDh0g0Cbofy8vgid9BEil53L96SvgxiaPo1asGc4plr3KWE4KUMnunidbW?=
 =?us-ascii?Q?v64fv3DmicEYiDtTdk5HEGwCS3nx3AP8LI2XRwlKDswGMk6P/1JZSZgof7FV?=
 =?us-ascii?Q?xz4FGSHCsFSALLpqBdnr/H4t1o/1mHDKneaLGTnv6lDvvW8eMAn8vK2wm/Ut?=
 =?us-ascii?Q?2/ps7z7OipxC2h2jeYBXlGuADE688CY8UaSIjtl1NkWIAFMaGF4HvkOnqege?=
 =?us-ascii?Q?Suia1IZkCf+czjD2Ivk90/Cw88JHJIVxpeLrEqhL6xaQm1mc+OanRghBxA7S?=
 =?us-ascii?Q?x1XkeOeDq6Z5/ltlzgTPDdsG47QGmlFhYSuCtHEzjsyFitdew2QixrJCvCcA?=
 =?us-ascii?Q?mUDpOspH4+ea8eQFbWrejLfIidaOduZlrOVnwmX1JvpB+jGC3zJ/F+jydjyj?=
 =?us-ascii?Q?vbnI+Aj9CCy3Q7piXc5nC3Te2imVgWFfLWRBZsXhREbPEXWscM8D/Rzjn2nk?=
 =?us-ascii?Q?sg+kBOKQ685pSnHanaasUz+9n3SAX/UEbIOZTliRLAMD3xLHlubwamjlM/B6?=
 =?us-ascii?Q?UZamss8abr6XYf/X/gl3bBV/KsU9ZCPL5yerVOfaxjCS5rcZ9P/kOoKoZBRO?=
 =?us-ascii?Q?KhoquQ/RvHF5bMzjBO6Qz+WjgEh7+qeKFcbGtzb2TQb8pkVelpQMN9QdkyIV?=
 =?us-ascii?Q?RL2RFocbfsh3YhrvRdDQhinhEzIO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xN11qvhyOjHTjLp4i5o2ytvo/RUFex7UrOUZ2ucQQP5LbLRu3AB0SW+YKWud?=
 =?us-ascii?Q?bTwIZg+mRJwqUwC5bN/n4WXDjrMW+W8D8HjPnj7Gu7Qk8HrdI6sgudzzLpGn?=
 =?us-ascii?Q?mJsRBh/oIT+V4CsGk3MHOxzagauf+GayMXZsBGj5xRZItMR5RlOHuyFD8+nn?=
 =?us-ascii?Q?mpSjXIBkG6PLRGyQWZiV4DHTw++ObDWgtTddgn+5PAlxqOQ93o8zHDjCnZSn?=
 =?us-ascii?Q?Lyeo8eKFwHhm+bbFzkE5y0yjLpE6ITqFZ6MXEO0ek4kk1U1EarEofGZUV0Ui?=
 =?us-ascii?Q?5sXMsuz8fNBSPlWsPbKaeyU+txMY8MRxx0bW/WSRe14FjjVOnG/MVW1jTXkJ?=
 =?us-ascii?Q?upDvoX4Vlek3o/KYi/RMlpuGMgh5YInrIBjxViBYcUaeoVJVU8JqJD2jV08g?=
 =?us-ascii?Q?EGdopseQTk3QbdBX0oHPo2aaBo8cXZw/mvWq6us+sKt9GHup/CvzQIVgPdPh?=
 =?us-ascii?Q?ABiDjm93Mc+aca49SgH5cwN/eEfFqOaDOv0eh+7WPux1RtyBAzoiYLkm5FBs?=
 =?us-ascii?Q?u6UcnQCNcIA3fk9s/Z7KXJ01VmmRK7uKuQ6a3/cKgvEXz7Yi+ribca9hw6Eb?=
 =?us-ascii?Q?lJ+qzgFc7v2tFK3adWbY/1sHuzV8gCenmSOFr9gRC0VgQzR1f6pcW6hSPhW4?=
 =?us-ascii?Q?+2N/Yb8v6lQ4RBE6XXavvs4S+FbKhZkguTxIRp6258qk2fVxUPDnBviIcuZV?=
 =?us-ascii?Q?Swjw49vjutZ+6uZc4a1RkEaRqxFVdjwsaJJR9xYeK9UsMZaRh1j8OQuzGG3V?=
 =?us-ascii?Q?B2fyp46dwwDsk2s0oj5CKCyS0HhA+ltyWv3GFk1xddUpRRaLEinpNuXrBmJi?=
 =?us-ascii?Q?5oG3ECnG04hUpZL29WSZl4V9x4XCCs5sQ4RVPBuEELSCO8pEok5B3gcAWHrc?=
 =?us-ascii?Q?zOBvQcfrXPK3qQp1FMOHKdZ8HNh3vp1zExnhP7joO78cQcZcp2A3T4gOhCdf?=
 =?us-ascii?Q?83cvYJNk2E5xE3BdMKp9hGiHK5IM0ukcvJ/+FymYH1g7SBpoEPTKdknuwtM5?=
 =?us-ascii?Q?c0gaTiOtDlbMnAKHA54mrCavxa5cyGulW7Qyvx42OFt0r5Ejei7/SgEd3mbK?=
 =?us-ascii?Q?AxMXIgY0DxLzo2zpfAOvJFFZOR9GH9E8rJghl6b2IrjfUYAESuQiKhVNheLP?=
 =?us-ascii?Q?GUCJQcMNsO66Re65ysysCye7ax0D7akVAF1od0n5rvO+ki0/EFvd4GUMMQ0F?=
 =?us-ascii?Q?Njae+pwPKtpCot9qzBsxfZs2IGOIGL89cfh22PuKmiDuXKxsDn3EiZWAie0a?=
 =?us-ascii?Q?wu28JFtO0OuF5i9mtB7aem/grdk3TMqu/UBcdYkUiK/LLFB/01IrBy0/NKLg?=
 =?us-ascii?Q?yQrC5iCpHQVb+Iwlv/Wves+Amz5Mw7Rn5uOW0HE6ZeviI802wv5uX7SYLV4U?=
 =?us-ascii?Q?s1FmE5tGjPlJ7BTYHQ4GXc+05d0xNpS6jDKVjuwqj1kNqRhR/maCQuInMNzl?=
 =?us-ascii?Q?uRJE0Rq8RJbGI99tTUNRgQSPt3Va+8OsD3N1rqUMkScYqM34F6fRXrkHrzPh?=
 =?us-ascii?Q?3BRAzCQG+wVEFgX83awmnZLZc0sMZINM9AGlO20UWAAUM5LPUWafV9j9BkoJ?=
 =?us-ascii?Q?Hx2LVnlivHQ/607sALOhURxU9h0DTChf+okhP8XR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65bfc6e2-c5a2-4c0f-645f-08dcf981998d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 07:57:00.4118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4TRK1L/w4MzD1YCLT7TuFYlYUxAIKhi2xtTB0ORR4jFjqpy6SBj5k0J0FK0X55YW2Ep4oDT3fQoBTkeA6cOwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8139

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
index 84ca12e8b25b..f41f704c6729 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
@@ -103,6 +103,7 @@ allOf:
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


