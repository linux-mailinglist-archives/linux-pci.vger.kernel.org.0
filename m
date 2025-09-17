Return-Path: <linux-pci+bounces-36316-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE36B7C6E2
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 14:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE1616750F
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 04:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE34C270EBC;
	Wed, 17 Sep 2025 04:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VRmGV1I/"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010041.outbound.protection.outlook.com [52.101.84.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1644283FF7;
	Wed, 17 Sep 2025 04:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758084820; cv=fail; b=pX4h9BRf+W0gWPC5R714b1PujSByZJazvLhCeASsKPffOu5MgSt4K55Ynrwwi1IJTcEMaHX89ukQyffTHXiQzGgr/1UwkBXQEx2RL3Fg387yOtu1+rWwy00Js0afdPZuZfspr31ZitzZrVK6bSP2eV7K+gxK/YExD6fGW0O5pyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758084820; c=relaxed/simple;
	bh=V8wd2+JB1N/WJLF0i++xt1ToJsAmfsG/3+v0q6+fuOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=trBIaM5g12OqYLzyxetJ5DDkBxb3h+fpSAzXjhe4LBpG4zw526kqvTXk5WAoQjbW9iz34Eg3mMc8blmaj6cIbb/mDlIVdkMUAYq+qNVfLob4hUCPizKUXuM+uuTb62gWBNmvXf7ahK4n+IATmJtt1AC0YUAJ7Lzjd6gwqLRCNRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VRmGV1I/; arc=fail smtp.client-ip=52.101.84.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ywz7sUN+2rIYsYYd9WdpUAbtLLKWVrMNLDSQvs4ZMmTqnx/vvkmEW+zBPLyENHIuQwm37OJA8p3yqr2tYRmw53JPGGAMqErT3AXL1oXBAcN831a1wEqMlxljnbFc/thasjV5cuiMsI4AhLotzgGJyfiZGSxF33V/8mF/joU8G7y6RCafCn3iZ7PNOPpxiKqSE0iz92xF3ZbxJEMqoYeHRGmkS9e1ckGBxwurZ8BHChs5pGECr/9swcpgP7th9A2D1cxsbf+3i8FBtpQmsGMP7fXR6eH1Jb3Sn1fUSx4G8SAvXMSQUYPcArL+sUZa4p7dpTfM1tEnWbts2ES+vbuHHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZQp2wdxY+1L8s7uluLzeiSpscCbWLNzcRLL4pOJ2Q0=;
 b=F0FEgCRSEq4dl768dNil7fwNdAdvN3e1+LRxnVfX5bLPLcLPYbPBpPSY+ZCHHXs7mz2ivUvscc/8m4QQRr5oppJWXzAC5EKb/AWsF3NY/A8e1j61X4wTo0Cdymm4liLslRGFH6Sto8RoJioOf29wM/yqjSFSRuq5ZN13OevelkxPgDGqB4fA8FG7eVhJpqoUoONZgUvHMlUrDiq6V49Mh7eGYwL/Ho9cwy+04eZtpwUmI4EoA+ErZV3pW2HEWnLoeUiSJRoa5DmZSp6LbykUDMzEllKiOSvr1ZwfhPMcrmLRahWpADn337kw4Eg5xkIcw/n17T3v97c/tCpM6vYdTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZQp2wdxY+1L8s7uluLzeiSpscCbWLNzcRLL4pOJ2Q0=;
 b=VRmGV1I/sA1EM/aSqHRn3jrVG+WJDBBjqFOfxhhhcRZnMyjNxyEj2aibj3nYjiIfMsQapDnts21EoDlTHoVOCcbVZeUuL5z+d2hUUl8vqnL5l2mqZXy+bkpHlr7EOzCVrfBZcb869WUD1yi4FcMVrLtkWLIHZ9HR9nFFTVadKu/mODR4HcxJ09MzXD5AO/JFSlyHesD0lEEet1DvntrGiTpNPmicZ9Ssx6F4yijADhA8jyg1zP9gCNOvSgE5wNDIspNwy6RGIGUdr9VQDLEHPqHABHNNNVOYp47YYLuslqT3F3aoqeaOf034MkL4+VmD5IWWb7T3o8TVif1NikzSkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PA1PR04MB10098.eurprd04.prod.outlook.com (2603:10a6:102:45b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Wed, 17 Sep
 2025 04:53:37 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 04:53:37 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v6 2/3] dt-bindings: pci-imx6: Add one more external reference clock
Date: Wed, 17 Sep 2025 12:52:37 +0800
Message-Id: <20250917045238.1048484-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250917045238.1048484-1-hongxing.zhu@nxp.com>
References: <20250917045238.1048484-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0172.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::28) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|PA1PR04MB10098:EE_
X-MS-Office365-Filtering-Correlation-Id: 8313992b-3ed4-4510-82d1-08ddf5a629a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4mwdAi5Ovu6jcyL+yyc7DBV/3FW37dWxZor9LK0DE+30cLVPC+3uYKaFuO3a?=
 =?us-ascii?Q?K08eqR9vHn2eBmUmySnkQCzKn3rb9CGRk0at69LRcpxkZ00pS0XOfhbwI2Qp?=
 =?us-ascii?Q?Q6siuk9rf93KzxJvCBuHMVzlm02VKyc1eeaaYq2bg+dWKCqDCEsUc+1u0aT/?=
 =?us-ascii?Q?P+HM6/GIGmyU/ImcSQklOflcodoiZDVl9xVav5ai1ThXb6vWYf8/mJwyHd6m?=
 =?us-ascii?Q?P7gguwZgKsO9qJxCPhGyJIKtpEbaEI6xKTXILapxEAngqOhxutukutKvdc1i?=
 =?us-ascii?Q?YfJo6WrEr2nk32tlq/yxhdnMfFhSIxNiXa58HSbpiQNvsmQ33rtW3HQO+J7B?=
 =?us-ascii?Q?fAs+BVZx0Fp4CYAAoYBPvMYK8uspCqYko4DdZ0EY35vgz5Gs9Rztv2+P/u6T?=
 =?us-ascii?Q?ekJvhdSyJJDUkU+pszrn3aYzQGO1CAQ75Q7+cUGn+mrdydVGnDHazJOi1oh4?=
 =?us-ascii?Q?uGRKBS42RkoG/+y0XYYVYtjZElenR5pwqN3qqEDQ/tHyJ2Ojff92XQZpceTO?=
 =?us-ascii?Q?thGLrFOCUmOfs8LsM3CXvnXXwRVO233iyJT2r6LaKmgt5pZ7FBA6BuAQQ/fF?=
 =?us-ascii?Q?UXb1sCumhfQbAjwSedyRemCjbaShNaKfH2f/YhX3qnB0z5G3X93PbM0NlZB2?=
 =?us-ascii?Q?HwtlJ9nHTLy+XXfHXCckVoz5Ox6Gp4zXOjw3UjLssMV06ExErW7KljKv6ysR?=
 =?us-ascii?Q?dZwAZA/t3ZYsbfmzYWQXJPiDpoMoC8hxuQazIidCviWCW/5xsOfDYFZ3UlNw?=
 =?us-ascii?Q?AVUQPnnLUf844225YPZcQE2868TaX+dmc7OzAXAHpV2MSh6hxVv+OYme63T/?=
 =?us-ascii?Q?dkhQaDid+MpVs93+0WG3g1mwg3ZT+OlZWmxJTrdXKDivu9SCVQgCuvuiWtBY?=
 =?us-ascii?Q?85htzQ3/OiyHJzPMUlfmdnad57bCU+Y3hu5ejDZIsoZ7bbNnWFXEca1Gt1Xz?=
 =?us-ascii?Q?XQGd749JiO9VstUQ0cbYdi7uhTJ7AgzVITP4KXDJdhmgCm6V+8+gKX6Ke6Av?=
 =?us-ascii?Q?K8qNryel3WsSxhsGN1isSPtwjG58Nu+8DOiUKbzEh1EekEiqqVcId2ovNQJ8?=
 =?us-ascii?Q?iOkuyWK/3X1iBwDs7Swi5ttgBmMmvnMRMjVr5sVFdeK3luQM/7WmJts0p+K5?=
 =?us-ascii?Q?C0Rcrh1q1PteoRjkL5JiSEt06kOJpaKaSEu7Y/9TKMeGfWGEvQC+CBwrjtgl?=
 =?us-ascii?Q?CCnbk1bIu+9N2luQCdo40P4vh0mRJHUwAsaeYmQ31K1iRotwhp24+oEfSrdk?=
 =?us-ascii?Q?/YTdmCgBTz34S6cPPyKOwpLjNXSWJOKjqwVofeNM5l8OrGIwvZ35KYBwRXVD?=
 =?us-ascii?Q?+c4dITXmElGS6mWiaAf5CcGVTYt+VAvQ65vtFLoInd1gp4N/Ub2ZcC4RHshL?=
 =?us-ascii?Q?YMmujwNCDVTbjMixUlY4xQ40Sxz2tp2+qxc9ov183dBLwuTDoDY8QaHPk6RR?=
 =?us-ascii?Q?VDahwoKCNktqWTqjZCheFPwHjpVbsnRsOx205P8aHgzYrM6bamNlANu7trJE?=
 =?us-ascii?Q?IFO+cqpncZmTI14=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7fQbsV0BVNmxCbBe6c+5bUjaj/IsKhFl4FbqtduSKlWf/YMIx6GVs3H99Ziu?=
 =?us-ascii?Q?UHKByzQjJ641S9zvzSemHowckh2m/YehZ+z4bSDv7qLAh2kTfyR2UWXTZRio?=
 =?us-ascii?Q?BfJSqCmbbadU7r3c0dUg07FFbWtkJzqIlhE91FVExO/ukj6pYxQNDCkQHbZw?=
 =?us-ascii?Q?0nsbVb1m2lOa4oqyWDsxlFx/e5x7E9B/1aGplTSMqeRL1cf93AEDkPZNz6TU?=
 =?us-ascii?Q?352Lpma3FBLgtmubWyO4Bkp9/wRr3M4vYsukiyQhh7OykS176YlmchkrOROf?=
 =?us-ascii?Q?DsBxFhDDVrT1/jYkIPyn9ylEud26awVwwTge+gXSlQG/Bq1fKWHO5i41oGOp?=
 =?us-ascii?Q?13HubHasqT6Hq2SXTgg5aZPg+pIcHUXtHT7+mLe0fCiEnQblkF1zpMgYmb9o?=
 =?us-ascii?Q?cFwpSDsR5GAsDLWLYMUrf9RLT9z0vQccDK/I6L4SNiZvzMa4jo/QiGQK9BAW?=
 =?us-ascii?Q?y94TmszT5ZJO7YjOBwbn1pc2jmF3j9RHvgjSo8dh+2HACG1dzou1aOPcB6v4?=
 =?us-ascii?Q?Ugy2kYzM51gd621j5qyBTJk0Li2Ia6+4CgOkmWUnWhydJb/X1kU5XT9mc4P3?=
 =?us-ascii?Q?pVomCWRmMyy8Pa4sxGTYkf4gheZGGU3xBn7R20M8v7DD+bTfYO/qA14zi6KU?=
 =?us-ascii?Q?ELxET5iCFwVmPbQGKD7A9cwyj3Fjfikf46ee3nNUEx+P7C+qdDUdxGZ6xfaY?=
 =?us-ascii?Q?biEPYQ1L9Q6/bCmFbeamKdg8EtRi5dGSk1877l0y1TexFYLNjWVVl4uloCXu?=
 =?us-ascii?Q?MOdwZheXZXEP2/jKS4IRsTvRbu6BHP83KcZAXV3Yr1wB5h+XXFpooXrEq1He?=
 =?us-ascii?Q?wbn1902o7ePbVxKvD0R4L/Otuvk7ptYcZXfKQGuWnU+1ynGxOsb2gRH5DP/u?=
 =?us-ascii?Q?qT0IlU1JYReaDq+WvLqBKH+SH+sQfJ1/ArKSngeoG5GuUSbxvEwbOPJDcMVD?=
 =?us-ascii?Q?rwuMRRwsL0rpGmYM2OrO//St2tQ8azoUAMuAC+Dl/rVxYwom8cIzwUT3VwHR?=
 =?us-ascii?Q?a5hLtGlY13nCQPHFA8rDXqtoYjVjLk7KBsYZlMqFF9f1AZYLEkZpYFQijg4H?=
 =?us-ascii?Q?ZNkkC6BiBGRRAYqpwU8VvHIvY6NJH8MfOCcXZjFOJOMrBvY3IP3Bt4Lm/+YC?=
 =?us-ascii?Q?DBAbgOZTPgxPF3WcYmkiti+0fBqtPGUNt/bCZ+RnsKhURqN0k891OCKDIun6?=
 =?us-ascii?Q?3JynfLark6SmMROaXJQcuixadZqv8nYyjFTP4SxSakxa/+5F/NZsNtSWKGqG?=
 =?us-ascii?Q?vWQ07hMSQ0C2weC/gqe2SPG3zqbJVkZkhoQOwvuEUhblgILnzUl/iW59S+4w?=
 =?us-ascii?Q?irlTv7toQoxU+QOyGo7EJrBdmKOAsrhjyIbjQ5l0n+5JLSLLxJ8iVy9Z9lds?=
 =?us-ascii?Q?ssN/zFqa8DyYt8XsC4iMxj/cw9j17Lr438PhBsgG4CcMYuGjdAXgzSLv6FQ3?=
 =?us-ascii?Q?11SY/qw/9Amged5OmFcjZQUi9sUma/3lkAlQWromJzO8rIOLiB7+swAAp8na?=
 =?us-ascii?Q?DqR3C+oE94jzWFFiiUpGgh/hmb9o4KwJY0lAORhVaocJHT9cGgOJ8p8cH9k/?=
 =?us-ascii?Q?XVilmSz+O4fUFdYyVxnyYLh41jF3kMekKqxzr07X?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8313992b-3ed4-4510-82d1-08ddf5a629a5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 04:53:37.1695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Ntx+yt8vnaTwbajlLCV9Lp6NtcF6l3RX6m1T/X3L37P/ZMnfTWCVx8FOMggcdOl/aVNFUmDGUF24wg+FpeWww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10098

i.MX95 PCIes have two reference clock inputs: one from internal PLL,
the other from off chip crystal oscillator. Use extref clock name to be
onhalf of the reference clock comes from external crystal oscillator.

Add one more external reference clock for i.MX95 PCIes.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index ca5f2970f217..b4c40d0573dc 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -212,14 +212,17 @@ allOf:
     then:
       properties:
         clocks:
+          minItems: 4
           maxItems: 5
         clock-names:
+          minItems: 4
           items:
             - const: pcie
             - const: pcie_bus
             - const: pcie_phy
             - const: pcie_aux
             - const: ref
+            - const: extref  # Optional
 
 unevaluatedProperties: false
 
-- 
2.37.1


