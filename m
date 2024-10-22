Return-Path: <linux-pci+bounces-14973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1301C9A993C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 08:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BBB5B2256F
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 06:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59471448E4;
	Tue, 22 Oct 2024 06:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g6RXMaeL"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011028.outbound.protection.outlook.com [52.101.70.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8434142E78;
	Tue, 22 Oct 2024 06:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729577255; cv=fail; b=GiUP3TUcuAO4RNm8hITv0RmYrHS1YRe7kowPgMfdUmzX47ifVU6u/N/l3sS4PXene3+VJa+9R9VdqMSuR1RqwFPSRn45lBvxQ50Jg7L6fADV73X3hTXCIpsojYli+f2+hku1Ve4lFNqaE4NwjDFdSnzhqA+P2nchUTSPkvauZJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729577255; c=relaxed/simple;
	bh=NjcsmyI4iNjcEFNKTgjGOdEyxWy5GhSuKKlKrbu1cf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UumXh4iRGFgdoAou2JN06YMpphQJGx/5B7VhVljyMQ6AnaG+vEMBllM2ajBO/ccxNazswfYG584AgsG+L+wLnmbrUhHx7dkEaqXEtdZehhPU8Wt5cuHrN/Je4z+qti5OqwAdCxQNf1ngS+9a0+j0UvMDrJVLjqkmL4l+yr7qpks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g6RXMaeL; arc=fail smtp.client-ip=52.101.70.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kt02+ocqSHSka4QZY4j2+Niaj98yTzNKJ8fnoxJ2Nqm+lO6AAivFoKFo67I6RClb7pk+91Kb2iwC/0EJGv7Njn1W8nM2JbXCPgvFHp4GoprLwn6ev7Pe/JrfSD/AWhk2oqT43JxvddDoAuwE09j5NmnNLhZxIGYM1ry/N2oTYP9GF+t9sJMKlHNTkUgol6p3qTnzJxje2Is8RjNDFTlXiAaBIWnUKhhJqXDRvFt3NDU+UD/LH/mrYvXBzThe75PwLvpVAbA/c4TbRVjwZWZ4qi2OCkA1wonvPlmGvL/DO2ZfiwX51zsgpYLGyrhaTd+5VpG1zO47HZ47iBv05BJE2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krMfbsyqfzmwD40cpsm9L6FvHz1xL/UYF2o4Gwb90ec=;
 b=ylE+tE0NCHi2EXLfkUN2j0rwt2NL+dlG3vWt3sdESUnOFvXM5bD5XYnoIONNC/j+VsWA7iIxK56R3Ze291FDwFW+BJu/iHVXEpERqBU7S1bdtl7tWN6w8eMM1oR3zHOTQQ0NJvWhJDdCXu0uwSqJD4ymjDvcF9C5aIGIU3k2eTBAa6PjNlUE0fMzkuiLMQfWKPi0EfYP6h1ITiOSd5Hk9TW9YIDbVrtcH87RONBvU2UdnbutjP+7Cbj8S72785oWjqrjBmllGEvVSC+lXhVQyEuZJPxeQf4LxIi1AlHkkHjS9fYoUdiGikod7GX2HfYb/W2jboeToR5AZiAeUTPfJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krMfbsyqfzmwD40cpsm9L6FvHz1xL/UYF2o4Gwb90ec=;
 b=g6RXMaeLemyyJv/c6XTQB4Jod8rgI/7aQLX0kW22wjCjX4JZ6RZnk41Wjhv91dYMYpn0pVR++tbAEmUDxYZd5HlpvIB5+Kk15q4N6FgeW6/N7U6qElthhDOAoib+E0xQltUEPXZ/xAbk0eLTwM+yF9O2jXn94XraQH9FD3yk7rVnnPGODg29pgh5S59OWfCjxFHFNaRdGtcpPHETeZhoBBsX/caDwxE+XkF4pLDU0Re2hZVTdet2OKOsh505QpcPO8+ioSLUL9+HLfvfrn+X1pWmYJIE+CTi9HNFL+UubMtcDUE8NjA6MJMBcQw/UB57ZInPGobp0nkljqBAqoufig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB10209.eurprd04.prod.outlook.com (2603:10a6:800:244::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 06:07:31 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 06:07:31 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	christophe.leroy@csgroup.eu,
	linux@armlinux.org.uk,
	bhelgaas@google.com,
	horms@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	alexander.stein@ew.tq-group.com
Subject: [PATCH v4 net-next 01/13] dt-bindings: net: add compatible string for i.MX95 EMDIO
Date: Tue, 22 Oct 2024 13:52:11 +0800
Message-Id: <20241022055223.382277-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022055223.382277-1-wei.fang@nxp.com>
References: <20241022055223.382277-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:3:18::32) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI0PR04MB10209:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a3eda1-a227-464a-ae7c-08dcf25fd006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y0fGfU9uqZBcOM3LTe9jHV0btKmWO54ckHFomABOj5+vGv5yZLzRIm/TlQ7u?=
 =?us-ascii?Q?mHHPAHhKXslSjmeZFiom1PvR/2U4YLfdR4dqsQm5pCOmw+l44HYbfU+LsTWl?=
 =?us-ascii?Q?0MC9LV1hQqwMpmzg/vE1QTBPcI5aeDMnCYoBd+gGu0Y+1UmTNsLtUhf6nLtS?=
 =?us-ascii?Q?Bb471tVrj3T4M0t60Lg4PPHsVJofpGB+Qx4zxFK2yZGNNoEcKH9LUBMnzoJK?=
 =?us-ascii?Q?o/UU90IJIYBq/QWNZPzsbvjMttgC+KtvFOxRSjcVQCc063XMaTBFPIUsctan?=
 =?us-ascii?Q?vUoh4vNtpR6q0lNFlkgq5nBqMaEesxsxyn9TptfciR6INyz9OLsdmM/sHmhv?=
 =?us-ascii?Q?x78qugvPHQyCD0k0d5r4pLHZwuXc6X1wmfJbw7yxuI62MExjbRY9rnJcJyQm?=
 =?us-ascii?Q?H3FwefEbt5YeeOfLP5J8yMvnPcyJw6D6aTdvwNy8JCu+wfvIKjCDJEz6RvKZ?=
 =?us-ascii?Q?REYc/3iIuIzjAB0J72BifAw2InkjhOgZ+OYLla+jj+0Q9FCP9MkcpBbX9btK?=
 =?us-ascii?Q?yWFk5etBzB/DE0DCUejirKkAXxSZ/FCBjcOhTl4CKM4o1IP2IuvDHvdBG/qV?=
 =?us-ascii?Q?E9BId23r7YEwLxauzOBRXp1nedtTpuMw02JNCOb40WkEHsdy6IilxupkhCSG?=
 =?us-ascii?Q?2muox0f4/QvIZsU5aO5c1vUDY/WjGdTGtzBcwUJuRI0nXomr5w9CAL+iflyj?=
 =?us-ascii?Q?zyJmw5jR93Yp3gCQ7Jw4tTCqVGrthom2FiDz6r15qNpSs/ng7BlpfRf0tgUC?=
 =?us-ascii?Q?Ehjr4U2k4QZ81Ay3ts/XgtYx8Ds3TQujq29xzb94cQ9IoT1ywX8NeK1Um+je?=
 =?us-ascii?Q?086g+R0TXBhFiuFQy/QkPsnF2tBtAx6PJw4DCy3tOl17GI6/+VKhcjtZLM5J?=
 =?us-ascii?Q?u+r+VAMzs3MnRTirmlyWh993PTNrwcN74IdtT3ryyyjXIg9R7QhbEuKuyPnK?=
 =?us-ascii?Q?YgLI1z1GGxJNBJxoSjKawUR9IKzZswT9A67wpG1ycWNTF2Ra+oIodhV5Qcf4?=
 =?us-ascii?Q?dyJcE2KzOQ+9fNepye4kAHs6Vp1KIaYfhpVdgn7HxNobebB5TOaU8Eo+NmVW?=
 =?us-ascii?Q?sAFXHYfCrlTNRZ7XOAQHvcGOzseYgpLrmgoMSKFvKMZM4dfQNQx1ndErkvj+?=
 =?us-ascii?Q?7tStQp9w2RPL/zUKYyhXvoB1kzH+bLn1XZhDHQHUiW1+JRVzZhZDhVSajm3M?=
 =?us-ascii?Q?i5l5PH/MPkMCt1MYWWDTfg4piWeRzwfhRfH49taYi22YynN5sZCrQbryN8j6?=
 =?us-ascii?Q?hrF8BPsUCmakEKuMDAZ5W8MdqadcQ7p/xCwoe67lZ1LObtnYWV9SidtGgrOa?=
 =?us-ascii?Q?3GjDa9rdqob2q+aKBHONICVuBlIoj7yet4WbtloMIkdF0fk60Uz2SAEx3XJH?=
 =?us-ascii?Q?ATYVcmizdKDztBJ7mQ8LvDTF4bud?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kTIMiM84smhJABfGPYpUwNDW1cYvXxCO6J/GjRFi52LGTUxJ17d8WI1b/C8F?=
 =?us-ascii?Q?j6s/TybZTKd/+6NlKHjDEkV+WnDW1F3dPbHgmi3f7JEnA1w5Lg2En8BcF3iV?=
 =?us-ascii?Q?WS1EG6yCo3urWLnpbEQf/chm+4ztiHyiAckwqJvKoejDOLpQsFsG4lmxza+X?=
 =?us-ascii?Q?bMJi6jtycPpQ2ollw9JmHEjPsO40g7DdQxg9gt+84lzgTT9kY7xg8jMEUKtL?=
 =?us-ascii?Q?0OkHaP1WULmcqponZ16lsj6WgtMJ+cMfnS2QdjLtSlQRHqTUS9fn3bo/KEfC?=
 =?us-ascii?Q?Pp5JXfqPrzsos4hUpFBa8NX1teXQDD7wBLtZUr4ZkZOo6Wf6IcL5QYR/hEty?=
 =?us-ascii?Q?N2uMQ/g6FrB7fZ3g6na2iA88qIcbn95CKtePJCzAilBvCxXWozVcNt26Hdu+?=
 =?us-ascii?Q?lFkipNkBVnnfRHodkQslsZGdUF/Qe45MAzEru3r88NrMslbCyuMtn6ru5Wd2?=
 =?us-ascii?Q?PVbysdYQbX70eAyYR3zjSMTyJVRiA1wteyu12k1qFF9XWY8FeBKCl9dIMyq3?=
 =?us-ascii?Q?B4VdJWt9V4r7ob/4yMDqZx0MnfuyAloDDQrweWmgaKUTV2Awb0SgpXZQV+yU?=
 =?us-ascii?Q?VNQZqOENafvmb2YaioxxFgEwMkIxE4kxZ/X2FEGt+M4iSm/6jkLmJgsxhhH/?=
 =?us-ascii?Q?P2svBsKuUPdd4JtQZosarkUKFMD9jojMNnWknBhBkYORQBQ5HJU+Nalz0usL?=
 =?us-ascii?Q?5WOyGQ8AKohmfnxvWl0+seoOFWN8PE6a/YD5x9Ay5AoUAt2gjObAVWk38B0O?=
 =?us-ascii?Q?PPSz2j/ugZ2pr5c0q0YcOtwwVdHUbcn1x3oocSBqP0su/dwt80KDTKrHayqa?=
 =?us-ascii?Q?mQKX2msMue76Ac9QYCMcgvtOnlfIIPmOLh4C48IGB4C7z9V6iKQA0iImGvSj?=
 =?us-ascii?Q?r2R72v00wfGItUWdXdJk5PIJJi46Mnpq7W71rt0yeTZ31RohBO2PxgMZrF8u?=
 =?us-ascii?Q?AqN82kdrKvDTmfO4M+uBz753g7gTaC2/MxR20eb/PUjR6LWlXP5xGvmHVQpJ?=
 =?us-ascii?Q?Qmyx198u6mWoPoQTSLzyobr4SUbwRuBMeWSAVbovp8wiAQjsarUjZ9+svdTv?=
 =?us-ascii?Q?Xd68AURkn9OCpqYxwZs0El2YfD9nf4Vogfc5sb2LlA6ioAGIOuR4DEL3hPlp?=
 =?us-ascii?Q?r0SmpqE8HHElfUvLEMZ9BlQ/HHfaMlREpr7xy9Cn24K5bAaimgQJW0sKT8lE?=
 =?us-ascii?Q?rrMS6WtB7OipuBtb3ErEo+yQ4skIf5BkkrFyxD2ohYuJ4CTWDKXjTOKTnGOB?=
 =?us-ascii?Q?l6bJ8EYw23ZOaW6hzpuxLIGwHaPPulwjezHRH8wW19NMnd7fYEnYdjUHey25?=
 =?us-ascii?Q?Atxk9HVk4UZQZhLHrq4hjo2ROESmE3fwE8piFMJ9Hww9eJvNuJ+2gtZ/udYi?=
 =?us-ascii?Q?KHU7F6IypzrP0ZAUrA7FPy7qhe+r4GPY6Lk0+KPTb3jbfnX8aL3Sp7QorYG+?=
 =?us-ascii?Q?Uzld59SjrMFBQ8Nn9p4AArwfxBujawpHky+9ZvryWdGzz9GGc9T/71x3JonX?=
 =?us-ascii?Q?HiQnOFoIWCAEvcsxl14lKn5kHcHSgUZYWB35tVz5IERNsNXcXqAr4zwQVpry?=
 =?us-ascii?Q?RSBEcikUZlwJ95bCtRr03BGythE9x14aU5DixPzU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a3eda1-a227-464a-ae7c-08dcf25fd006
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 06:07:31.0453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ChWt8FKbAdcomvxMrxcKM8Cj8nueGVlBuRtUAbVendmPQfHBkLS4r4S825QtFiA+tCZGFdn1kLGYqtApHDf+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10209

The EMDIO of i.MX95 has been upgraded to revision 4.1, and the vendor
ID and device ID have also changed, so add the new compatible strings
for i.MX95 EMDIO.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v2: remove "nxp,netc-emdio" compatible string.
v3: no changes
v4: no changes
---
 .../devicetree/bindings/net/fsl,enetc-mdio.yaml       | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml b/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
index c1dd6aa04321..71c43ece8295 100644
--- a/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
@@ -20,10 +20,13 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - pci1957,ee01
-      - const: fsl,enetc-mdio
+    oneOf:
+      - items:
+          - enum:
+              - pci1957,ee01
+          - const: fsl,enetc-mdio
+      - items:
+          - const: pci1131,ee00
 
   reg:
     maxItems: 1
-- 
2.34.1


