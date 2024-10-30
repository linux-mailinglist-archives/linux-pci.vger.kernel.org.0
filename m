Return-Path: <linux-pci+bounces-15569-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D91AC9B5F51
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 10:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 666AD1F220B2
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 09:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453A71E25F0;
	Wed, 30 Oct 2024 09:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HBiwBNMF"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2076.outbound.protection.outlook.com [40.107.249.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1007F1E2016;
	Wed, 30 Oct 2024 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730282088; cv=fail; b=r+jAHi9o4v6qByldTXusJ+Y8ayBye/cbTh0Hb0bxTUSqWRmxWu9THHU//nQUZmthdiFQDEzoKIQqPSsXo5LdH9VEQ6GiNsoMPonoA4wMtSMSSNrdLHWJdvHRkWzbdzLFzVuWbEoii/khZ88LpTYEJMZM/ODW0KHOWfP+5KBmG+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730282088; c=relaxed/simple;
	bh=i7F1I+7wb6aKUfGKNSQzoLFc8tG35sqo/MGtSMeZeXY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LIdgZkDDw5fKc2vLY3Jp/OPxvwWCqfbMyYfLdJhQ8WmiAOdcp5peiZskRVovn0IdT4zUzUR7NcJpyg7heXxliWIqMPX6PkUSOBlbp3Cl4eLTN/JhFWhRmeEUMBLokz/MG/dMfCo0d497/egP8OHfi57ok0b5FHpKVQRNS5Ltvoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HBiwBNMF; arc=fail smtp.client-ip=40.107.249.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iB/oCf6gr/eACeR+joOMLFtv8gXWaTeKLztRRiJ1KmzuTCxTok8wL1O30ezLonmMQQALt7JbMW7vo9ENWHAZvhOo/BZndxDmMVKcR2j6O4WSjQQAiiKTOT1PaYuMS6TLkSCvJk6gWZ7QPjbNdWHc+M/0JpWhIUVPMfFcEKUZ3B16lDLfkrbkeDyESTOvrLAzZrzkhNnFNneGJRcJ0flLWFBx5qobp+oZ/SlC0c2oT1rbiPFYuVPCnJ9zG5VDYQVRpwd2swkO/Phn7tPQ+XZoYmLoOIXdRH9DVGKohdnfh/Mq0Fen9YsMPwXgSx6B9U5khihylTtdC+hevstRXUO5yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRQrisq1/OSLlrFrxX8ZURIIcd074L/H9pcciKaz5Xg=;
 b=h2BZuLPU4/owwAdbudWDohwMgxwBLAZQR02DFE2FyOrjFwjx/PfzMb5WtSlcqmf5RMP4SkdfB1z5oB7MnaA5GDGhOIZNDN9cQrlNqdsmjVn4CnTtVUqbuPTtWNWSFhZXk4nPY8MSh+PnBRy2cLcau4yjdNdItpeoLXDG0aX5z2b6xwiyOhbZnNkDfbJfTXUctOeVyu6fA1Am93SHwLcJie7si9QF7oxqg9NEy/8mP7YzBp1L1PXoMBM2c87d79emHycGkl3NNK7GGiXVD+lL9tvACztF9X9Bada3TNGvbjvhSKh5idTRhuDBdEtlIr65BgPmwAPs8iBadLe2OqEH0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRQrisq1/OSLlrFrxX8ZURIIcd074L/H9pcciKaz5Xg=;
 b=HBiwBNMFd8s+yz4Zbr3+QM/hoNNBujes8x5UAxEtL2SduoY19UtUMePL7CBYAP8fCzvA1Ze0J9J4+n/ke+XEdH/BpNDqcsb6axUkGjM+4cXt7fWgg9Qy8Cr54m0v/r2GIbVeK6h0kVUc0qYoHy7jgMDvMIOcy8H1B/TOBHOTeimqTKkD3/pMQC6z0tFYGytAWPGko7Lgy+2oXHa7giy5pXqy9ETuqid6fmfY2A/nZ1/Ak36X99SqaS0QHveh58vFLmg2srf7PjROXPoH/KuLplHeyXf5sGHzxhXmX1Yo8QIr1h3BS7g97TCRoTZfexbnpKnAookJSBwUwbOPlRgwvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA2PR04MB10347.eurprd04.prod.outlook.com (2603:10a6:102:424::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 09:54:41 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 09:54:41 +0000
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
	horms@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	alexander.stein@ew.tq-group.com
Subject: [PATCH v6 net-next 00/12] add basic support for i.MX95 NETC
Date: Wed, 30 Oct 2024 17:39:11 +0800
Message-Id: <20241030093924.1251343-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::21)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA2PR04MB10347:EE_
X-MS-Office365-Filtering-Correlation-Id: 2707c906-1cd1-4a3d-a776-08dcf8c8dfb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CZ7VVDX7G4ElUqmTcmvJKQt7afKWaUp1ZaKhiTdN1ICkSgC65KBbHTderymX?=
 =?us-ascii?Q?rxPzOyRQQTs9TKoXmgeYlM3CNsKgNuLZM7S3aDNTOanIfDKNqXe3jjcqedEt?=
 =?us-ascii?Q?BQc+0UYAHLbmvw8Jgm7udGk353yg2zzgNIk66uRTj3tSpTe4XpA9rTh1/wty?=
 =?us-ascii?Q?5ZlZCKDnJdYAnwGHzl/wyiE2iIuV32KuwrbdV/flapVCx+qeAmG/En4i61BP?=
 =?us-ascii?Q?SEUvx4zTbGgEr8B93Ko9Dghr4zotDf0T6zcvphfPvqbyaB2SJTOfdgONUCFm?=
 =?us-ascii?Q?Cjpz9XgqRTYrP1vTFoBkCAW/NmgIPxucUxm44MoWeKT+jQZRiN0u56viQ6Br?=
 =?us-ascii?Q?AZG4FsK1izKf4fPYpGOZyhk0djlLFEuNU4mguE8PSKCY+sGD6t7n2BDUTasQ?=
 =?us-ascii?Q?FZqwBJg8oi21wMqS3264exv3F8QkPsGkWFkZbs8kTHPu1hsaXguFXSgjDnQb?=
 =?us-ascii?Q?zGBCA65RnSqTNo+hh5gylF6BPji+bK5yLPPzhzDpc9X8qu6IOusBptplPkZ8?=
 =?us-ascii?Q?vTF8IfGV2SJn3649d2H3yY+KbDLMa0W5mfKQnIqMeyL0b3vNA4VmVgNAi4EX?=
 =?us-ascii?Q?JEruJ1IxWUPI2MfxHy9AcZ5nvI8QW9YahrsNgpUdH+pB5jN4wHUDzxoaa5Zu?=
 =?us-ascii?Q?aXzVblqRogpaovHlGKtz8G+HnYnMoBoOnI79UU9edmDCm6lfkMbyj31gR5UX?=
 =?us-ascii?Q?ZzZMnbX9qqcRkwvgAzh4rrXxCTBFMdYyGWL3eshWV7VTUATudOxtZKIEKet7?=
 =?us-ascii?Q?V1sH9wYMbKy21ORAHAmcqzbNh5jbSx0JcxHNkGkSvhywPTLA3rimlLkERhhh?=
 =?us-ascii?Q?Be45Xo6sVz7QLRrQKFgDaAgNcxAVEiEgOSNGhN3v0gT5sSh5Q/kvy3jLGIPi?=
 =?us-ascii?Q?F8ja4rE0RYJereCzGTUmWYGmT28fCvCGGxR0lyliDYwzORYYoCXDH3p0a+zT?=
 =?us-ascii?Q?uPkQBcnjHa6WHO8K2Q3ntJ2Lfaj0h8DSh+yVYLRp76DyTIrhpAA8KD9o+VuB?=
 =?us-ascii?Q?7GUXxu3wlIM/krsyCIL7R7amb3zQpg7nfTqVsdK4mn3TCqhjB9Y3oLRKeJv7?=
 =?us-ascii?Q?L0UIFow4GIj0re/oXifapCxibs3xJspkw3TAqdHGF4QFANC2KQjBuhnxZ+f5?=
 =?us-ascii?Q?MPKQqlVCvZBH8pgxrhoCKjXZ5hPnBnPp1RzmfsXL8nU8CDACbU1iGUL1zzI4?=
 =?us-ascii?Q?MMoeWEDCT4Vq2t1kezvQkY8UOPhzNZBxGPD9llZhkKRdcK1zFmuUnz12E7yC?=
 =?us-ascii?Q?sXYIbDDvBvCB5/wVfRujdcPyLBQ8YyNsTQ7QMlOvyubFRnJ6RCym4QW8A99n?=
 =?us-ascii?Q?nZzwFN/J2W//YHNV2D+RwUpfGnOU9sP87bFdE0/TouwGFqL+ZowM0NHZu4NT?=
 =?us-ascii?Q?vsz5BJ5vnY3ImlNm9Gg7B5RYUtGJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SdJvDnsND1KROTXczQwyXTDrCAUgor9g7PbQlrm+oBUNzvZ/SkNXyQpqRE7B?=
 =?us-ascii?Q?wiMM5XGWn2qfMELCLScLtxCy6TNR8qA1N1vWpCmFmgQuw2jpZbyOgaNUlj8j?=
 =?us-ascii?Q?ciWgb81hu7a+c2V0SxUInlNpaaNAGnKikAtlliQr4+8q/oEFhV0z4PmzH0ig?=
 =?us-ascii?Q?btbzAIRrst33l5hReUtN40FLs/VrEExMj3RrdFNZPGOcLC0PmtFNMns2GJXh?=
 =?us-ascii?Q?KMRJcPXE9eIno8qUgkkxDdWNMJCr+2Z3384h5EqYIYDavpb0AsdRoavoO7Io?=
 =?us-ascii?Q?J4nMp0T73KYSPWDyRuXhBy+YOFeU988weDGryPvlm9yovZsra6tX/pP26Fq3?=
 =?us-ascii?Q?mrLy2Q5AtrespUdj4qr52zr6UexAK6AQMrmztYYcPWRMa2AjeQNi9xXeXQWF?=
 =?us-ascii?Q?+O19kmx8VneGEJLVLnykqxkMFo4U7faYn5ZHtU2cMlgExzCnC+M6slwArzqR?=
 =?us-ascii?Q?0uVAkAOdiaUu7FinFf4Eo956Mix+kU3Acd36lfVF99I0yo9C8lGppdKIUQFG?=
 =?us-ascii?Q?4zz2qiCAS8uCp1X3AqCzdimfwtQqFx7nPGYgMMHSJ1oFLGWya8/N+CIANYiF?=
 =?us-ascii?Q?Uvx5R4L06jREhwEoF31ncixC4V68jGbrhJD5htW7HJFvX4d0efypdmdwdFpM?=
 =?us-ascii?Q?04I7GBYlLf5MTsUHjxGW2HdOC9ATFOgpQYAA00akrPeMjc3uQ4nybHa8PhEZ?=
 =?us-ascii?Q?tA/qMb2xDao/tc2DXfilOqWZzO6tsEgWGPZ8isQgHOVkFtQR68zezW8RGhqv?=
 =?us-ascii?Q?7+bsu4ySb1ftIdJYVVgjWEiOgdbk3xFpGTtqBnLt2Q7d1U4NrMpdMA1YOm+K?=
 =?us-ascii?Q?KBUg0MdkNq2URZjNwGmdl/j+j3lL6bbrZs8YfAnvvQRGBEmQ9LbLioG6XiWT?=
 =?us-ascii?Q?v58XhzO25uSLfN0StHf+8PYqwkw6kx9qL+B/d0INqKHiQJBlqkz9HN4IZxrv?=
 =?us-ascii?Q?7J5PCAyJ2gcMOayzLmI6ZaBZgfkGt3qgbj85wDf04lYDi/NCOD49/+Z6XYJI?=
 =?us-ascii?Q?P8+9DOeXw2rSwjJJDKXxRMolrHuPIl1/fQjApFJzSqD1/AfhQg9l33o3jysc?=
 =?us-ascii?Q?6jQ9V0U4g4sMW5WMynO3c3yOF+FLuJiz56G3VbbiuCjs6iBYmz8tJOfoukpf?=
 =?us-ascii?Q?/TiApj/nN0YrsLPtvPoyQksYAWKfR33ynclGhAHC4F4ue3JiiNXVnpUGW0o4?=
 =?us-ascii?Q?6aZ2Q/BritjjuQDai5wvSOMwk7BHey6prba43qAB2Ihg1NXfZ7/P/swOrmYy?=
 =?us-ascii?Q?OTu4KM5coUbuMn/gK6Xe27Oe7Jngdv00B/qf0d6Ii3N1lZc4EXn7MOvhaKdc?=
 =?us-ascii?Q?T4wotRPmaJB/wqgPqwCkBekq1wsfC6n1ZRIOIicH9nNknTHQAHUeJQSaU9Mi?=
 =?us-ascii?Q?ArMX4vzCTeQfphukJfSEL40a9aPbj7s/Ue7zIrZmOvnDg6ria/+NnbCvxx9f?=
 =?us-ascii?Q?r6Q/31bKdO3TLIoGBKiOVOxUhoJGqBI0rN1uK7naTZ9R4JjPQSARzbq1Ap1r?=
 =?us-ascii?Q?av7Kg93VB8NAxj8FdkaLVQRjTaVK0ByWHLhXKgV0cZCye2xxCU4JOzm2XQlK?=
 =?us-ascii?Q?ktepJJCvtBQ6gzziP3mxRBQ2K4UeM0UxXqjzP3kt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2707c906-1cd1-4a3d-a776-08dcf8c8dfb8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 09:54:41.3044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQ/t+1pWoqfMshdhoNzAO5lAGZSJQBElC+b5xt7zymIxjCPWIAKBBGZwQqqya4xMN7o7mSr1u/x9Ud/XdneMwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10347

This is first time that the NETC IP is applied on i.MX MPU platform.
Its revision has been upgraded to 4.1, which is very different from
the NETC of LS1028A (its revision is 1.0). Therefore, some existing
drivers of NETC devices in the Linux kernel are not compatible with
the current hardware. For example, the fsl-enetc driver is used to
drive the ENETC PF of LS1028A, but for i.MX95 ENETC PF, its registers
and tables configuration are very different from those of LS1028A,
and only the station interface (SI) part remains basically the same.
For the SI part, Vladimir has separated the fsl-enetc-core driver, so
we can reuse this driver on i.MX95. However, for other parts of PF,
the fsl-enetc driver cannot be reused, so the nxp-enetc4 driver is
added to support revision 4.1 and later.

During the development process, we found that the two PF drivers have
some interfaces with basically the same logic, and the only difference
is the hardware configuration. So in order to reuse these interfaces
and reduce code redundancy, we extracted these interfaces and compiled
them into a separate nxp-enetc-pf-common driver for use by the two PF
drivers.

In addition, we have developed the nxp-netc-blk-ctrl driver, which
is used to control three blocks, namely Integrated Endpoint Register
Block (IERB), Privileged Register Block (PRB) and NETCMIX block. The
IERB contains registers that are used for pre-boot initialization,
debug, and non-customer configuration. The PRB controls global reset
and global error handling for NETC. The NETCMIX block is mainly used
to set MII protocol and PCS protocol of the links, it also contains
settings for some other functions.

---
v1 Link: https://lore.kernel.org/imx/20241009095116.147412-1-wei.fang@nxp.com/
v2 Link: https://lore.kernel.org/imx/20241015125841.1075560-1-wei.fang@nxp.com/
v3 Link: https://lore.kernel.org/imx/20241017074637.1265584-1-wei.fang@nxp.com/
v4 Link: https://lore.kernel.org/imx/20241022055223.382277-1-wei.fang@nxp.com/
v5 Link: https://lore.kernel.org/imx/20241024065328.521518-1-wei.fang@nxp.com/
---

Clark Wang (2):
  net: enetc: extract enetc_int_vector_init/destroy() from
    enetc_alloc_msix()
  net: enetc: optimize the allocation of tx_bdr

Vladimir Oltean (1):
  net: enetc: remove ERR050089 workaround for i.MX95

Wei Fang (9):
  dt-bindings: net: add compatible string for i.MX95 EMDIO
  dt-bindings: net: add i.MX95 ENETC support
  dt-bindings: net: add bindings for NETC blocks control
  net: enetc: add initial netc-blk-ctrl driver support
  net: enetc: extract common ENETC PF parts for LS1028A and i.MX95
    platforms
  net: enetc: build enetc_pf_common.c as a separate module
  net: enetc: add i.MX95 EMDIO support
  net: enetc: add preliminary support for i.MX95 ENETC PF
  MAINTAINERS: update ENETC driver files and maintainers

 .../bindings/net/fsl,enetc-mdio.yaml          |  11 +-
 .../devicetree/bindings/net/fsl,enetc.yaml    |  28 +-
 .../bindings/net/nxp,netc-blk-ctrl.yaml       | 104 +++
 MAINTAINERS                                   |   7 +
 drivers/net/ethernet/freescale/enetc/Kconfig  |  40 +
 drivers/net/ethernet/freescale/enetc/Makefile |   9 +
 drivers/net/ethernet/freescale/enetc/enetc.c  | 269 ++++---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  30 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  | 155 ++++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 756 ++++++++++++++++++
 .../ethernet/freescale/enetc/enetc_ethtool.c  |  35 +-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  53 +-
 .../ethernet/freescale/enetc/enetc_pci_mdio.c |  31 +
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 313 +-------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  21 +
 .../freescale/enetc/enetc_pf_common.c         | 336 ++++++++
 .../freescale/enetc/enetc_pf_common.h         |  19 +
 .../net/ethernet/freescale/enetc/enetc_qos.c  |   2 +-
 .../net/ethernet/freescale/enetc/enetc_vf.c   |   6 +
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 445 +++++++++++
 include/linux/fsl/netc_global.h               |  19 +
 21 files changed, 2273 insertions(+), 416 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_hw.h
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_pf.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
 create mode 100644 drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
 create mode 100644 include/linux/fsl/netc_global.h

-- 
2.34.1


