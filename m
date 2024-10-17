Return-Path: <linux-pci+bounces-14745-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 238239A1C6A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 10:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96A121F210F7
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 08:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB3B1D79BB;
	Thu, 17 Oct 2024 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GtL2OXVG"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE48A1D86DC;
	Thu, 17 Oct 2024 08:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152166; cv=fail; b=Kanj3IcOTxayqmYEauyixvVKuWcnejerziHwjbedXPdZkyI4VyrjSQwAcqRBwV6Kd8WQDYNtCyeTkrR4zQdDqH0MapW0F8bMrs9dKFh6VNodz8SX4VhwDKqS7LKIR1aquMa97lIlhSk9azokBmd1AzA3eF92kk33nGKN9f07rdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152166; c=relaxed/simple;
	bh=VufHridRwUuPyWBJbQ4rC8YLe+mxC9hDJHp7xOtsPyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bZzfqc3qbELtu6vtcZFPU/75yEDyIc4ya6QwWcGY81flkuemjDlnw4qTqp5XqSUFwAoMnW82+jpfI4lBGAY4QsZnRNRTRTt3Ma2gG6ynWmu57Pwh0apW76rCIeGTNAHXU9PGc9N+kCyeqViiSbfb6rk0wDXm6QEr68KHAUTOHH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GtL2OXVG; arc=fail smtp.client-ip=40.107.22.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4kOTnDhLwMTNUgI3JbDmieXHnsw8w6/Rj3pyTMe3sj8LFf33gowbKlbh2M1QZQW+DulgZdx9eOCTL55i6L6401hNaaeGaKO8iOdrEicTE0WzA64N2OKG2Dzx5laNCjI1vdkbKgDIxqlCGfJ5rZ0cbrDhMlt9veuYfE7NL9qeOSMyQSgvq6DS2uflilay8LiHjSh2vNvN2hjDFWfGnQ/BuiYFhEueL6W4DGjp4KawJIMQTnWJIGngelXDmyf7fc4RtMYM9H2hb+jZmz4JAVEQKUB/ecuKb83RB7AiGONdIjxuAvXIaB+1bNQElKA0r/lR10PgbBkXjHazO7pR14iSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXIygbXzdMsDz63C7B+Z08157W1zhQtFSCOwv2kbeAs=;
 b=Kr3b3zgeOOxGpJFFiiwQ83llEtWeNDCVQEbfDhhtb1UcbTRz4BPyI0recJaabFS/vR86tAv4q8fSxxT9IYlXjfIYt+ebki07mzDOTLVz2hIKkZdFvrej1f9ToGnoH1O8g7HLCV3/k6zPMJRCOUo+2/foRT22WUhHfIFt8uKPr6lbCFRvBUOJ1aGY/tQDhJtbSLV4K8myP2Yyz2NV1m8tocRE0HqSTO5sWTedQPAezGKIAOQ8Vqe7U2qWmKUTj+uavnHBFUAt5am0CR1OObaSgnO+KGyNMAewI3LvgMrhgoIyi0YmgxlFX6Zn7fctb0b/ggQsH+0nibhTM5j6/5RM2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXIygbXzdMsDz63C7B+Z08157W1zhQtFSCOwv2kbeAs=;
 b=GtL2OXVG7nR3o+B9/c9oVQhxbGv9gL27hudWMLoXBxq+p7ds0Cj278XWf6x1ManLjbI55TA8KItE4LbgiDQkTlDwe3sqjJRedqYb2vfzMZ8lcQPkAfIanTriqT/zz5BavgYt0vJWacPxuZK0zpy9zryT9XK6cgtFCp1vyz6c5akgQdmpaXh0VOi69c5+QzL1oXd6/3hyYPlY3F++vYrAI46bvBoHpebrKoz9UwuXY8GS/nIvFeQ/1GWQtsEAB882jY4iY5B+/ZFyx+r3vpMSlhaSTfqtN4QBY0wsEUTSAhh78hHl7KWRj/3CMei1+DkzJ/X3mVPQY5xM613vFYdaqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBAPR04MB7304.eurprd04.prod.outlook.com (2603:10a6:10:1ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 08:02:40 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 08:02:40 +0000
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
	linux-pci@vger.kernel.org
Subject: [PATCH v3 net-next 08/13] PCI: Add NXP NETC vendor ID and device IDs
Date: Thu, 17 Oct 2024 15:46:32 +0800
Message-Id: <20241017074637.1265584-9-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017074637.1265584-1-wei.fang@nxp.com>
References: <20241017074637.1265584-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBAPR04MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: 253d976b-c94e-41c5-bd11-08dcee82122f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2Ba6Ce36AtftDgiQ9p9TaDlFcVAxT+Y+DuX/q0dUrofxC95NEUsaDbZviXwp?=
 =?us-ascii?Q?GgkC6228IIv/wXETFaktMvgcTaoGfNolj6TsrZP+X0+xxfC5V+kRK595vbuj?=
 =?us-ascii?Q?UFzH9CBdqe8Ph5ktsjJrdYupHCc5fnlgXyc2T/CYogXoSitEmV5/gAmPhOIC?=
 =?us-ascii?Q?5q/zRnf3hDfwUDXi7q+oPZ8aHRM9Dca9DakaOH4OiUA7fkMKtAmWpaWOJ/iZ?=
 =?us-ascii?Q?TxMdSOsOq4hM/tqjWMTH36mbsUWj1TQjd/fW4QhmglOJOacdIxcIoluiuTlC?=
 =?us-ascii?Q?ygxRQH6g8LTod0BAb0DJsHAu5WSG+YW71J8BGzlM3HRjxXHLsvWGYHlhV5Kn?=
 =?us-ascii?Q?6rMYVfRnOTqsnBabOQMNoGn++bSN1KfRQ3WCornZgjNYabLja51EndL5RpXt?=
 =?us-ascii?Q?Us+hb+GVywA1mPrCF1oYezmebPf7D1KuVMCaArS7TYnDXYyP+RcErL933bgP?=
 =?us-ascii?Q?hhZVrWCQY35y+t+hQguZFwWn2ye4K/TkapTIvO9fUwTLWMGuvHs/Yqn/Y1UO?=
 =?us-ascii?Q?bXhwVhW0RajV1MWNdRyZ7ginUeviRYKz7j3347WVLI8VEjaYJQFqItSoWycF?=
 =?us-ascii?Q?2LS/ZGOuHv/uNePGBxMMNu65M6JzumdUXpDn++8zHvWoPDv/HwSpXSzWbwp1?=
 =?us-ascii?Q?Bc4Bu8PFFNrz54dDrZifDShEtosLG35sSjgTMKYWIr7PYV7udgJvssiB4sgN?=
 =?us-ascii?Q?dCcu3yFCAASuoSU71w4xju6Fa5zGSvQNKpy0ZkeNP5vH/E2gA47LI/Am9Ihe?=
 =?us-ascii?Q?z55k6O+AqfI9w6OduW3L7e43XY0TKedv3ui+Ejc43bRh/x/mooSAcyqVbKx+?=
 =?us-ascii?Q?bwJMkZ8wKmNFIvWqDedvS2p3FVvy7uONhjrahLZVXmMNr+ajsKTIZx4A+J5b?=
 =?us-ascii?Q?Y2DsMNwwn428xzuRHOhAyZBYjQr041/OlNYFPupeQJa0Dqg5bUe56ZHVDpAa?=
 =?us-ascii?Q?gaOT/ekDQOIAsyetgImPfJR6XN++PNTsxp9OtIfsp9ea6YLp629kazZaZ460?=
 =?us-ascii?Q?qvS7/qe0y4AfwEp1Cz860ZTEf/kA4NpEU8/mmt5wpv5m4ALMt7d4lTprohje?=
 =?us-ascii?Q?xwDzuJuGn7h2ISRI74R09M3Va2wYbu3jzv3VLuJMVmM6Roc4teVLFae1ThAn?=
 =?us-ascii?Q?VIGdhaZJzSH6sSsTjZD/KnYey/yYO6ETzGBoQHpQwcLo65C0zCKtBZxyofTX?=
 =?us-ascii?Q?QBKZmJZ74WGif7QwhoXvNkpe3BDafbn2i6Jt/k5PT518odjRxKXqCITt4TLK?=
 =?us-ascii?Q?09Thr3WRno7arCu/taEVGiFmKAAgzmz7ulQzS1ByWF68tDQnJHVJ/WUXJWlk?=
 =?us-ascii?Q?HGubpUO27punBbDOR4mJ64SQbJRLDJHVL5IRvbvsvV0sEwIlKK2w+cEVb7Rl?=
 =?us-ascii?Q?9mz6NtYuUNkKaaIHV5omBMUkNoCd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sYVJUPKN5LTRWhJGlvsJnB34fvNEp0J9RJKDA6US3/TKORlly0cfoNNTW3Ln?=
 =?us-ascii?Q?hEoT8db+7y8fo0rXn1e7lJ1XmzVKmjcnRO2l3ugLFmrR4gOble6phdfAxBxe?=
 =?us-ascii?Q?31JzejX/qnQXd5DQgUVHHE1TKJdVRZosA45QuzxcSSCzvJyu4/unlTFLMmBO?=
 =?us-ascii?Q?L4LNvEmhXZet10c4rxu7Bsyd8uQZhWDYCqxN0OcFAmqNKmB7Vd3nj7a2ojNI?=
 =?us-ascii?Q?PhlyDU2x2WErk3yTG/yz/HCmfmwvdsevQGik6uUdsoHqsmQNrARgSPBkA9a2?=
 =?us-ascii?Q?OqYXp+FCykgg5d00mfXc+WrU1qSjGiy9IxdVjoDdJsKZZq6KfvaD3ABYwaPD?=
 =?us-ascii?Q?x/tburt9r0D8H8+QyuBoP4eQxsSwrV4x6E/otwKe3m1AR3VjLuT2jpw9WuK8?=
 =?us-ascii?Q?jMDCL3q/TDD/lOnVgMIb1bPiNOYS2TnogTRPbtuXohubtV5nU1FhRFWq0ez2?=
 =?us-ascii?Q?/77wtX5ukT8SQaXJs27cWulyWoILDarM16DhV80aN59ag3ILNSTdxGAAiHt5?=
 =?us-ascii?Q?KC9qUUJqdj9QNB46Vpa/Z7ozJR2repZHDX3NVqNjd9ZEqoOlzIM2mUsgCiET?=
 =?us-ascii?Q?NSqND+qWw0JH4B8zj9ri75fGjqbO2+dzWPXO3A0vMnXEmOcj4rgH7u0d7SdW?=
 =?us-ascii?Q?NITkEz1QKoMLrlDT537Ig0wVG2hA4pyPkr6+A0Sj44q9Kuix6t6VsmepM7N0?=
 =?us-ascii?Q?2y+F3t8r/Qw5ixxZRhu5UVvfVokbSOu65p7fSRkGpm5e149J/5b6pcYuvEx2?=
 =?us-ascii?Q?F2fbngcilfJM4gDx+oLVXCVfJ9t0obKRxNt14mzIOpOQ9MFFJxYaEBjvrRdh?=
 =?us-ascii?Q?w75q1dtUhlo9brKLSX+FSzlzLNWnnrcFMpBW1UT4zlFWjvOs8b7siZSgBhHP?=
 =?us-ascii?Q?r8JBevXUVMOAL6JjaE1bxWpemSbNDgzx5W+Q+mVhquMSzd1zF7hPsoKr35mJ?=
 =?us-ascii?Q?bj7krl5u8lJYavjf3PVd0BxkC5sR8HyvChR1X1RdXDKa3bBSxT38MVCJAbzM?=
 =?us-ascii?Q?OOeRbjOM+9oT08nLpSH1MV7jbFKXsb1UjY1xmKffcpvCfcwpP6CCCgaAw1Yw?=
 =?us-ascii?Q?96Dkonekhb8VOmJGpsfZ/4f/cvG/IVOVlEXhE6V3IIweIiUTc3slB2shmVjE?=
 =?us-ascii?Q?oAprFsHY9WfIlyqar03zxOdoz/03Bt52UyBb/ZvrjAbXWuLLxxwdpMOM+lXB?=
 =?us-ascii?Q?USYdCfOYmPM+3eRZ0Y2eyGZ5W4UvHxh6mW+IYepUBqvpEBl2Ilzo/PihpGAn?=
 =?us-ascii?Q?G3AjLq9oyv/Cx94XO/kUW1hRvM83IA+DZmTxd5C5RJEGaQ1I8bra9vzAikuX?=
 =?us-ascii?Q?BFl6OrU+XZmziB6iSYgoDS/0cCJoUJ59rtMoEFv1kPwc8eSQp/XQqCK9nvdb?=
 =?us-ascii?Q?uL+DDdUdkf0gCuWnqMCHUYBmeJtReXyZ7iBYxfmMV0p9r6LeuwX96t8PVg0b?=
 =?us-ascii?Q?SjY3gr0mVnlpvVp3esgfqAIS9XzZoYD655KpfikToh/mBjZj0SEZUmlpowWE?=
 =?us-ascii?Q?yvgTsRcIF+WhC7JrFsjTwkuq6FGhnQBHYIQw6YvHQNll4FH1OTlKcjyTKAO7?=
 =?us-ascii?Q?4XTyYjPG1gnwm3F7rt+SPgPSK/STKOnifNerpvwB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253d976b-c94e-41c5-bd11-08dcee82122f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 08:02:40.0978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1kZqrdb9rvwBGv9xh1fKmA+DjSG7WVqeltM0CpxqlzNRD799iaqf5fRhUZZnlbIDWznCwecuOuvQA8R7kGHHSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7304

NXP NETC is a multi-function RCiEP and it contains multiple functions,
such as EMDIO, PTP Timer, ENETC PF and VF. Therefore, add these device
IDs to pci_ids.h.

Below are the device IDs and corresponding drivers.
PCI_DEVICE_ID_NXP2_ENETC_PF: nxp-enetc4
PCI_DEVICE_ID_NXP2_NETC_EMDIO: fsl-enetc-mdio
PCI_DEVICE_ID_NXP2_NETC_TIMER: ptp_netc
PCI_DEVICE_ID_NXP2_ENETC_VF: fsl-enetc-vf

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
v2 changes: Refine the commit message.
v3: no changes.
---
 include/linux/pci_ids.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 4cf6aaed5f35..acd7ae774913 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1556,6 +1556,13 @@
 #define PCI_DEVICE_ID_PHILIPS_SAA7146	0x7146
 #define PCI_DEVICE_ID_PHILIPS_SAA9730	0x9730
 
+/* NXP has two vendor IDs, the other one is 0x1957 */
+#define PCI_VENDOR_ID_NXP2		PCI_VENDOR_ID_PHILIPS
+#define PCI_DEVICE_ID_NXP2_ENETC_PF	0xe101
+#define PCI_DEVICE_ID_NXP2_NETC_EMDIO	0xee00
+#define PCI_DEVICE_ID_NXP2_NETC_TIMER	0xee02
+#define PCI_DEVICE_ID_NXP2_ENETC_VF	0xef00
+
 #define PCI_VENDOR_ID_EICON		0x1133
 #define PCI_DEVICE_ID_EICON_DIVA20	0xe002
 #define PCI_DEVICE_ID_EICON_DIVA20_U	0xe004
-- 
2.34.1


