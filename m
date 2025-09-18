Return-Path: <linux-pci+bounces-36400-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCEBB82C11
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 05:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7556C1B2510F
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 03:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0CC24469B;
	Thu, 18 Sep 2025 03:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EY+MlRGK"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013067.outbound.protection.outlook.com [52.101.72.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D394244687;
	Thu, 18 Sep 2025 03:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758166022; cv=fail; b=fFUJUPYDurOHDZTTW69UhlC6ak/vBHp9iIA0vdp6cnKIS7p7MdmefvW36tYnm8tCnCqbiEao2IHAAtLAQFnLHHv5+k9EpFu2n41sFgiiaVsZX+4wPIpCHGUatAikONCmL6/LF3SGBfntxTBTs91RArSvDm7UOUoZSsnxm+BjIPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758166022; c=relaxed/simple;
	bh=tMs+pQAE0THowrN6GPuPCot6EgMASdcBhu4Y4TIXuBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FpFrYE5ppq5/Bn1Dw3kJIeVQd+hDux0HL3Fpufd9uuIfpkopxOipUcXhS2S7zZZ7o7RS3XJjGi62az6ryIEyjqBt/ukHPASOieudXws2xUCTxUDigtfWmVtNrtRPdfCoQOyZC70aBsfMMk8s23n/sKd8tHJzy858tlba18lFrBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EY+MlRGK; arc=fail smtp.client-ip=52.101.72.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzHSakqKT8ecDqVgaJEAJXanlW+/Kuhv+rP1Kn6575ghsp0z+zvQ1zHhSPoU07EUYmvnvArkEA66+u0cY+JgXug1gfLD76s3CRLeTBW/oVN2PHjbYqrfqs+RQQ77jhFvo3hBBRMaKOwbAnWDVcE2BUZMynQmVoneqtp9L8+MYhq51+Nmu77Ejr2tdtmMCVWkq+sVrNOHQZev2ZvpNo5vsPMmR9ClfJhRbwgmZLxZyNUIRbj+CXpkZsgwdWmLVJx/kO+omn5PPh35exnEIcRKd6OPNaqs0O9N4TlwGPmH4EOgoUdygFtPulf9xytiN6kR5v/xDnbQ3KOIB+X2izvTlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTTrqX+HkaCVoRz1MJzRcAXhetddL9bhs8lFzjR+Law=;
 b=VholOx3IsYNK3nuWOc+kPGxNot/OqQQMrbwJsDIOPcwZDuZdMJsWhO4mTJ0NpEGDV+YF8D5PfCRD2o30FmskAa+VqJIPMSCBeSeaWSpOgmOnxElgohwpksniXIBpk0dx5pdA1JfI5NjpMquU98r7oKygA2Kn8yNChadJb6wWDaPHcjZOIZODWUhqS/1aK3vgou9MJUxEZJB5H7HnU1Qclk8SJ8AGkPXrSOCAMdQFVzCySgjg2IPqlJdHjLohzRBb6TgQjA6ziBFiscpiOsB/Uty2rjI5l51bCLGm1VS1Hg0Yhd7xI5sGHpXfBCl3cWU5kkYLm6BbogYtLmZ+fonSuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTTrqX+HkaCVoRz1MJzRcAXhetddL9bhs8lFzjR+Law=;
 b=EY+MlRGKZPh0Y6wFS0RvERT1WDZONrwcxYsfm4L+GRZnehYv/Ug9s5yiKuXZ0yZwMytuMTboX5Gm3mWfnYkLNZ40PHTkYgovhE3lg1tO9SA3Vii3vvbE2YeMTx9DWJO5p05hJMq+gB1Pv9rxrenc8SmL8q7HxHcd2WACxAix+rxCb5LfOlGG8KsQo+CnO9mCPUZ3QZ7LfqtLJMqmjopwUgrhgnZ8TqHgwtCIV6T6Ky96XNrE7E7ynI8hUdO9IHgP/yWwyVGVo+9zHPi1i2rS+U6580///4STY7OUzQNpGI6xUXWxiYPjh7GFZJhSJTf8tKpT+CKCN2fWape4p/Dacw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DBAPR04MB7317.eurprd04.prod.outlook.com (2603:10a6:10:1b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 03:26:57 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 03:26:57 +0000
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
Subject: [PATCH v7 2/3] dt-bindings: PCI: pci-imx6: Add external reference clock input
Date: Thu, 18 Sep 2025 11:25:54 +0800
Message-Id: <20250918032555.3987157-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250918032555.3987157-1-hongxing.zhu@nxp.com>
References: <20250918032555.3987157-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0188.apcprd04.prod.outlook.com
 (2603:1096:4:14::26) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|DBAPR04MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b91dce-b73f-4ba6-9db7-08ddf66338dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rV9r3OZaNCvwpd7OMMgHtAVKBaWIU36Ri2Ue2tgpaLA4Vu76CfhVF0jFivKS?=
 =?us-ascii?Q?RTK/xG/XP4frO4Ez4zfPTKErxSbnfZfNtBhC7/ROWBS5Fcnmo2ZiQ98cceg4?=
 =?us-ascii?Q?jXhMwYDI4zc5Dthh+vsAqUxT5kDIKvFWA3KvF0L4c5PsL0qtSJcNbbq2OYtX?=
 =?us-ascii?Q?+sz7SusQrWItdgJ/LGqkuji5OR55Cn5arR5UoN6neNHWl3jXVB9FxXyFvQHo?=
 =?us-ascii?Q?WTLf7udaPc40dI3BZ086DAfowX45nxKHkDoj4odRruYfKaBBLoegIfj7D5iO?=
 =?us-ascii?Q?R1jdvp3ONrfwDDklXzeRMSfBgDJEvrbwyqVsYTS6Bf7KIjtNWA9anRgVg7th?=
 =?us-ascii?Q?zBcBpYmZDN9HdQ+Fix7NIAI/Y0iH+edUEiYng+Yi6SguGCPRe1S48w1jKU3x?=
 =?us-ascii?Q?b9+Tmz7Hnj/Z5qAIS9GEHsjKHFDYYTKgmh4uyddmdwTYrG/dHOIrytC9fd1z?=
 =?us-ascii?Q?yQI6FrELibXHfezeS4XvqAGPtK0PkWYqrVLGVFlrQZrKMJHDCSQ+INVWJhQ7?=
 =?us-ascii?Q?JIynHCtgKSs+JRb54w5QMIhTIzVIpO9hHnIUF4rC9Lzf3qFfEP0+m8nW2FU8?=
 =?us-ascii?Q?E4RvpWtoJH2PsulGhK0FYGK5E2gyXEjqck7JWA5F91HxEkjJLYKND1vGKzgj?=
 =?us-ascii?Q?dxLA5v/jSgaHdcGXkYB56mIDZi3B73U4625bMecEMgRc/BqZi3TxeRCphLkw?=
 =?us-ascii?Q?qQO1MqW8oGJp3UK028Zs+WgzolJ2hCdPDhAx+irxFqh+j/Oyr8JyEYsdlSaB?=
 =?us-ascii?Q?nn+9UbXjz9tuyHh24RdaNcomaEG1rHMkmAjOWg7/l3TiVA6bHa28gky0hqTC?=
 =?us-ascii?Q?ihMvqbs472JAke8XrMiJ4IA9Igm1l1weczI6K6nYMWNMz9nKef0criwguB2o?=
 =?us-ascii?Q?xcq7O67MGcdbxvK6I2LgLEGPxwm/0M8JcKUNCG70B3Z7mqHKdJ+7u8qNTJxg?=
 =?us-ascii?Q?VbqCpetjYbCgRIiERih6/dsMi1GNUZ6J+i4qq8ZdNX5/GWpprujSWQtbC/Fb?=
 =?us-ascii?Q?n/wDzfCz64erYA9k7qLfjnoNQ541ibZqP9/UnbJKMupTVVMVweC0rVTeQ7UR?=
 =?us-ascii?Q?xmLlfpR1KGf8VMmUXNRRJhyt/YNDXluZfb62HsPus8ScJZuYiHPJ0n5SOdAf?=
 =?us-ascii?Q?l+U3iYXa7TSQ0b5ZXgorzr/KzPsVaIaymAQ4qVuCpe0VWGK8f9fEgX+PRmiz?=
 =?us-ascii?Q?CckaOMHi67TS56pZ5BOIhpUXx+MZ/0VSX3VjVyIe4h86Ijq1oa2CBjlGBEei?=
 =?us-ascii?Q?b4NfJMRikeB5Vd7qRzeyvUSPRcE5j4MPVxIZJOMxxXL4hrpzCr+Qlb4GymEw?=
 =?us-ascii?Q?lRUy6tfElq9yS6oaQHqPeVNP/rxPOqJCpLy7NZgfvsxT1YBfjX8DFCq3P+Vo?=
 =?us-ascii?Q?eppmdWlKRBmzVlvuB5fwJauNXlgd+jXQXwWBXRxTMzSStAmZT65yjGeBajGh?=
 =?us-ascii?Q?E6OADhwKxbfRk6CjSH2OcSBkI4ZWrGtuooxx33BDUCC/SSWIJtZJ4+Z6fXt4?=
 =?us-ascii?Q?BFiptsi7iQow9kA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hKj69zFnJr1mKrE+nj5lCl0z2XLLl7rGYSFkEeMKeU08eidOuGEc8gTGBaHH?=
 =?us-ascii?Q?0dN2VwMujW3GlO7xwbBNGBB/ThvBXSaeEQ/gbyTaSdl9UDd+9BDKTS/H15p/?=
 =?us-ascii?Q?f/+zhhUYZJG5p3XHrEclLJ4gz5gApwK6R5iUx7P3ob//DV27Wxky1pcbfghD?=
 =?us-ascii?Q?zSCRberonZopRTwqqB7AE7NZ+YN2S9cJ9itOpMcC+Z4LzdR4wDYpCghpXqgy?=
 =?us-ascii?Q?xA1b8BTGfrwObm4Jug6lexLigwXpj77+j1bkB+Nq90rtzQbCUXLOFoSGSzLM?=
 =?us-ascii?Q?Q09CGP2hbJkOEeAEzCZ0AgrELEgev0jDLZqirl9SG3K9muDhhPirIDq4hYuN?=
 =?us-ascii?Q?9FDx4HO0D+LCwFRYMzWU2+ig8yOd2LRlpFPuv/z/BvWwnyn8t28ZEK7vGce+?=
 =?us-ascii?Q?FBpcmSHPPGDmR3RuB4b/JIpMnnuLciE+Gd7t2yZisRxjqndAc7Bm+hTAMBRX?=
 =?us-ascii?Q?YKwU0SqFpru493ampm2um51Hytr3mXuv9HGVjsIAjU40cgyl6mI2K0pq91Y7?=
 =?us-ascii?Q?GP/rrWJeNK2m84GJ3f9H52LUvrj0DL+zY3Dt8NbMO7P3HSiMaLlkL9zEvRne?=
 =?us-ascii?Q?2d9qoGs9WHPIZB0ByBcoK3oqsdW0u3Y84RtIdGm+i4zXBqlYZbmbg6F9TYSo?=
 =?us-ascii?Q?6zQfIxmFKUj3ctBlemhGLPiLCvL+vXBOzIPcXo2yaeunUn4GjfXLeF5fJYgM?=
 =?us-ascii?Q?CcY+VBNWMqpGsnKsIxL5S3fv2rp2n41h57Ms/tO8VHVrI1e6MTXs64FNMU1T?=
 =?us-ascii?Q?/rYaBRvRkqEdJoofBpIAP1LLTNZwurUteUDpN702HZFbGqlGTw7F/GDfOjj9?=
 =?us-ascii?Q?meCxzGmX1nwmHc9Rmg2tpwO0qOwSEoGg6ERa06uHnSfs/+MLz3oGglPE22r+?=
 =?us-ascii?Q?/HFIi00fsmhvBSDRRCHxvtcDOwICfzpCVp0I3pLnbbPrHDE6PC8bzMkshh63?=
 =?us-ascii?Q?S35wBXa+qhVn1j5U/kXQUHT3McqR6Vt9aH7cp56TdJl9AHtkBHdjyB0eg+iR?=
 =?us-ascii?Q?IPYgD5dYpP4hxIHwS9mlQBBb/UmDh/IPYQoZK+XuP7BJvNeEKY8MJq3mXKG0?=
 =?us-ascii?Q?eq2WW7TDKqtFlBT41uh7rKQYua7MI4RWeDSrDfL69GZw9h3uE0OD6mgrdBfa?=
 =?us-ascii?Q?34qkY03cIgnfnFCfyvAaFp9al0C8Cpjs0fKvTimu8t74tLc9Fomto1v7pUP6?=
 =?us-ascii?Q?4uDP6+EA38DpUT/wqh0cPBCVqwUgMeBFQHh+nla7cy3lSNihARvICyFdAYtw?=
 =?us-ascii?Q?jh0cy78iDdWqT5gP1ynvfiRWCqouPddJLNU0nVXHw6hcT8K9A/lFoHu6EWZN?=
 =?us-ascii?Q?yHgLK6yAIbwpS1AEzzcmM13edLaGLC3V6/T0Z/IfHKdc5SOaGl0UWqVBMyPD?=
 =?us-ascii?Q?SJiXV9NPKjwGj21t5Xl6jc2SNWdjC6R82FW2ZwKaEfoOAKkYmsm4SwMG4dvf?=
 =?us-ascii?Q?wKGp+nFmQfaoR1mo6FeVp8eQMmDSeQBz3KieQv88mQ/P+hbX8/XmKpLH++j0?=
 =?us-ascii?Q?6JsTI3ueVNjZy6PI+YLs/iSnAPMb5dokxBUhEOMiRR7GiEUovF3WW3j9a71X?=
 =?us-ascii?Q?KivCN3xnqRtGPnS0o8ytrA2uWGbPMvd3iaOn6jmK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b91dce-b73f-4ba6-9db7-08ddf66338dd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 03:26:57.5961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uI/wfg+deVqB1BZVl0xp9nNYav499wZOz8lExwpHsXhlNu+hrNj0dlNfldoaVesR/R+8nZ6qvrqDJY+9W9qL1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7317

i.MX95 PCIes have two reference clock inputs: one from internal PLL, the
other from off chip crystal oscillator. The "extref" clock refers to a
reference clock from an external crystal oscillator.

Add external reference clock input for i.MX95 PCIes.

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


