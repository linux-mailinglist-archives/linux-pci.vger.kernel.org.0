Return-Path: <linux-pci+bounces-14053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E959965B4
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 11:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC7801C211AD
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 09:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5631218B465;
	Wed,  9 Oct 2024 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="STdqtgFV"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013012.outbound.protection.outlook.com [52.101.67.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898B918A6C6;
	Wed,  9 Oct 2024 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728466906; cv=fail; b=FELizGvtmgTmDhdcG83FRhAVr1NZrw2QkZjF+r4AQU56qY1FLiJNXHet/Fl4CGgcBCA86BRqxdT1RLxsgONtqIZvU/yJ7GS5wF0tRbR9cmjDatMZ6p6/ElCwg5p8PNglgS3pXqzM8zvxeegGBDBB1eImjbi0h0mb6szHIf4QnXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728466906; c=relaxed/simple;
	bh=ivBpcJ2SCZ0haFIfaO0WHqrg5WxHhL2KGehjbDcpqes=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=cuDPBy6RS3iJ/VvNF/NInvY4NN3vtykeyU3cXupefGNTT11v0WlM11TsiSPjHtn79HxG5BlOUb/krGRy0Ve9ouLdrcXo/GXj3y6kPiupeA1/edqq5+tph7rsX72Eog417IRxUC2HHI8oqIJ3yE/fylTUSWqkInbu2rX2t/M7AiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=STdqtgFV; arc=fail smtp.client-ip=52.101.67.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmKKUarqEi5D7gq+F8Zm1KlwGL0Qa/DzyzVUTD2yUnDKuINOnQtl8cAOATuM5tXBTdcZDFzcfURFrBXoiy4xDCvg/0gjGtK9IM9Dw2I4EThU+nFsDP2y0eMnxr9z08t/fLqSyIHgblf6nqM8oACvVUcqjLjqUEPYu3RSK+jqUQmVh+qPvaxCyDmCxshlA1s23D6H2kf9fqS9uRe4+Hf+FE8R3iXOdq+6xTchqd9OdNBoJmqX64apjlv3L7PK0ERDKrTgg4o35IWgXQs5if6ztnuz2Yrq598PKToMiu3HDw7hnJdEEr4S9BeASyo+9PXYw3BPTVpE5zyN7eHo+6jGsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cx3seEEpKe34KsMUC8CLUiN3V8WBcwJm17eLUO7vDyI=;
 b=ATpJ4oA2H0BgFr+y122Qpvo+Lel4Cm+2LKiT4d4ot9qLbgTEadtEBDEjT5LaYA2s0dPg9JKpJoimGlTlWneXT2fSnpCAa+dIbXVZZYIu6JwypyFGVSNxc1ZSUNpS9Dk1jwioVtdVxufcgwvS7MJFIb4SewnFsvJ2L8G4FXRkjoUtsM/wcWN6b9CAS6/WP6qA2QLzfYXJlPR+iwCfJ8NJJ/AEYPMyQXtPH+my5LU9mPboAgo8PO9I9NfUDhL42+F0bAXpWTKpuf4KmPhIQOhTkWMHmA/ftl44HZ6YWbFnlyMwi/TQv/H2Wcdfe0LB/xg1/YtGKLyVychbaqSr9aWxwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cx3seEEpKe34KsMUC8CLUiN3V8WBcwJm17eLUO7vDyI=;
 b=STdqtgFVTKbF2CTDDCOFQGQPe0xLDyKiZQdzQij0PyxRgqmhfNGBfzrerxA49spFWDmqXcbdxFKFtUT8bBLZrK6qAvfRsuzR+d7IIru/OrDrU9PnicTnDAZgoMM2/rNE8QbywOi+P20Zoqy36L5BykmTnMi0UhDAu4js5G5RaJQpScl4evwTtN/vfHFrLSRNNwYFky8gkt00hOupNuYGc5VXO/7IigmVQ+ZTypNTUAJRxsNYb4lht1jXt4Ci3H/Vwnysppl6K55hQUufx+mLNG1E5z02VlTG6dTkgdMQaLNvYfT4BjTpuyg3fE9PeBb0USrICXp5GRzxEKEyNfeYVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBAPR04MB7223.eurprd04.prod.outlook.com (2603:10a6:10:1a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 09:41:41 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Wed, 9 Oct 2024
 09:41:41 +0000
From: Wei Fang <wei.fang@nxp.com>
To: bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: xiaoning.wang@nxp.com,
	claudiu.manoil@nxp.com,
	imx@lists.linux.dev
Subject: [PATCH] PCI: Add NXP NETC vendor ID and device IDs
Date: Wed,  9 Oct 2024 17:27:00 +0800
Message-Id: <20241009092700.146720-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBAPR04MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: 0789cbf3-7845-4567-8f72-08dce8469462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zKbjBHqGYBb/YiE5fngLHhZEzCvlVA4cFwTwZ5mEso/9+vM6dGjxyxe50sGt?=
 =?us-ascii?Q?9So8I/ErhyQxvAi3R4d+ZJtmzMsP8o7wDHZnIIIoBbMAss27kwoTqZjFaDo7?=
 =?us-ascii?Q?ryuTHa8J/eAgLzEvlPXP7aLg7LXrFKSdbVvkrgYYQprdAr5kt5TlNCFXTLj2?=
 =?us-ascii?Q?hvbY6N2dnk6QzhLR0g3k78GTZntF3UjQyDYg4h0WSxsF7QiqxjeXRe+m4AMN?=
 =?us-ascii?Q?KIMBM98300rZZ0UKse1wvl+ttvLrg1itSldGVytniw00672uuofz4nRuUkSr?=
 =?us-ascii?Q?5/iZ1QqzI1lcdTzUeWhsEZeR5JrWDo+fkjkRmr8gCqwuz1g0XLLfBUw8pYDE?=
 =?us-ascii?Q?IXwAjRogS5f6MTF1q/s28EsQ7LN8EEH1Jb5BZbHTbAp/kgYaKdpsNEldRm0r?=
 =?us-ascii?Q?lZSxoK/iy7ebHJSOnRScTNE9PzwijK/6os6xSTdMpXyjc9/EvoYiAEE84RcI?=
 =?us-ascii?Q?EP99ltMXecdzxO3UuPswJVw0L2y3YUdwIhoTqhvmrgOCVk009aYIS+4OOA7e?=
 =?us-ascii?Q?0ryPijdHI2A6dlVkGFLf+p8Pn8n+Rh10vLLCxx4vw3vWN+bK51YeJT7au0pY?=
 =?us-ascii?Q?1VxE9TT5HlTYgBL8esx32PLl3NaLxO9Y8A63O5MV3wJyvUdskhpOYR6ch97m?=
 =?us-ascii?Q?t9z6dW/5dZb5TMDQ/TtPT2HDU9BWXd1PEd0yyz0uHxRi7h/Ym9Uo8fCMZxDd?=
 =?us-ascii?Q?2ZuR90HtKLP0qmF+bXC9GDlREnpUHSsfUiU3swVgGedP21U2D9/o+f/2Q3y3?=
 =?us-ascii?Q?76c9CRXtJgqVVQtIUaFQmIwg3k41g57lUOQ/Zh8BsC7E5/cstsuh02yyPhU4?=
 =?us-ascii?Q?RscWuh29G8H1qnJo1+k+51nrcHBiSrd1Y8VlBpodrw8HrxglZRUUo/kwDIsQ?=
 =?us-ascii?Q?9n/Kcvivf3Dw2rhR+X0RFSuw120j81Lcl/Q93aKb5IwpDelu2jkAzE6aAwwZ?=
 =?us-ascii?Q?fq6DgOUBNVjNQT3ebzZVr6F4UoTVVOVzZ78RnwMkeYFp9ulP0Ir1uFUiHZPd?=
 =?us-ascii?Q?/Xc4XSgT0VuciMSiwUaTSqmfQA/hs1ch7JHZLrgLjo5Q16jg86YTu39JLrfj?=
 =?us-ascii?Q?fTmzglwz6NMBBvPVFxCxq82/xB/uzfaeGb7T909Tb9qZ/MMisVVA5h3dSPNH?=
 =?us-ascii?Q?mfBzKqLXHotktWCyCp/oLHruwbY85amIyzCeAt3TahLFUE9fwanZPM8SOjUG?=
 =?us-ascii?Q?5wnsuCcWmx+IM3a6YQsnx2YGkk20VVenxO/hrf4YVfHTAxhadyJEFTQ+RV8+?=
 =?us-ascii?Q?ydXKzjwbemun9eMWZ2JaLuCrldSykctFCh9Y3Txw6AkxJbUoFGAZvK+ZBgPz?=
 =?us-ascii?Q?5Q0MCSVSELvyp8zmO3nbfhtYbRSNrH3D5aZcFqdjhnuchg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UHa9AZKf5mpLQIXBdo7KVif4iNVUkdA7C/PWVFqORUebuVFvnGbAhAoSkfhH?=
 =?us-ascii?Q?4LMTWhYStd7JLPT5HlfGiF8YxBDt7yxKP3hMDegED8vsvy9P2SahmCMXsAIP?=
 =?us-ascii?Q?x2IIuh1TN7LcJIAmX784mVAT5T4xyKKtcut8nOx2JGM5FnuVqiDuJf0SHjVx?=
 =?us-ascii?Q?4PnnrGjCwDJwb5rOjEPRAd9Jza8fBG6YS9jh6MQ7kA/+2WvtLW1MXyv46ioW?=
 =?us-ascii?Q?5IfJKhEo6X2At+PxRaQZKoJl6Lp8WmN2zyr+cJ/JVji3oMFVJv0rc8QTlkIB?=
 =?us-ascii?Q?WV12Yl17Bxrc/p7ssfauoYoUDQLjec5rj4i57aH8VG8kCQ430396KEvPXmxD?=
 =?us-ascii?Q?2vThMzCU4bSG02Oym9/8Pn9JxJQl6tlbAfaUlPJCXUtGmm6X2K49LectLihk?=
 =?us-ascii?Q?0ZRGubne0x5G7bTV5FX3BWIwJoir+hvlVcA6ROpubK/SKkGBz/eA7JEXwq46?=
 =?us-ascii?Q?JgHAmSPHb1HI8bhMND4B2KrDugzUwoSIhSxfFc27EwPWALbTWz8ZkpofoznR?=
 =?us-ascii?Q?3OZi/+zRFROah65zz48qGfzkJvvt306jEtXFgqrr53nzTHkvqDUaIUO+AOiQ?=
 =?us-ascii?Q?WQR5OOL0WsI1GHc8QloVX+0NKINDG3jaLVaIx3UY9myeNrQVy4FVZnhItO32?=
 =?us-ascii?Q?H08/NS+P05C9/QhfRIbhW7Ci5Pj92JqIrL2fx4DzInNRs5nq6MAwkEN4B26P?=
 =?us-ascii?Q?LYgv571OHKiFdXqm3JuMK/7FBHRAvbm/IL+ji3SaHkOJK7kwwfMxLB2IGWga?=
 =?us-ascii?Q?vdvB6gKg7wMaZ1j0DUqQS74CBxbsYuzd0eyoi6ymzqkMR1ZjUdFG4NiqzfbI?=
 =?us-ascii?Q?SxLSKkWut4o3qzk64a2FsBzSf4lW3J7Bme5OB3syJ4PDVtTau+zoUPnGawpO?=
 =?us-ascii?Q?yw3Ih1y4hS7TTWQA1cpzJUOvPg4QmoM+dI67tYmZRFeu1nV9Nqs1bqwBdM4p?=
 =?us-ascii?Q?XZxM5qO0upbMF6fso/cUB1KNmos8D+dZVe/saszHyBUjYR6s7d5AmD9JNqLS?=
 =?us-ascii?Q?17EwfWCb+vvveOQwEzgihGrzS4f/EupsDGovR/FKbJ6WAD/aE/nApvgpAm5m?=
 =?us-ascii?Q?ZUpQNZPmSmxDJZIV2t+CgjEslOKQwbzs0S3GRkg91gP6SMHI6VBywdOZ481e?=
 =?us-ascii?Q?O4FGIrVLuagUevqEqwpJAjForzGqN9AiK96+SxS1BmXp+vBVLSiS7MfAXqKt?=
 =?us-ascii?Q?BYQ04FZ4i/0pR5Slg+OTxuDjHneiNeQIBRP1NJomszzCJWbTS1zv00G2OKRg?=
 =?us-ascii?Q?KCCBmgoX3WCjNQEOAtg7drCl4FJ3ZgY52HIbFS1EwoQZWGMGEg1fGjnMtrbG?=
 =?us-ascii?Q?9VTBr9bh/H/Mn1As05VDaebmE4gYn98JALKSlWfoeKJFUkAQcFNnPRyOmCLN?=
 =?us-ascii?Q?wD9L0P44B4ziO1n/4l240DC5ZQEFe00D4+1TMwLmkTU7vP4KrXfWeohfMi31?=
 =?us-ascii?Q?73q8AEyv3Oef65iJmklnQTRLhR9nJbD0IAUmsyb3wHnk6fhDelDRlcsXDC0Y?=
 =?us-ascii?Q?qV8TLzyQbSdXAbHbZcPdoJrkM1gfap9Wst1K9RCqW2NLPt/4iA6apWuuxAL/?=
 =?us-ascii?Q?141xJSpe1KnV810+xtucM/7BjvVKu1aQIo2CAcU1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0789cbf3-7845-4567-8f72-08dce8469462
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 09:41:41.7156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDJec8/ibD5u6/uKummQn0g8ZAS8S2M4nELJRonfcGrtjXe0vjK7lL89FdI6oGiAOxZzEMxtZTOkYyE/1GijUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7223

NXP NETC is a multi-function PCIe Root Complex Integrated Endpoint
(RCiEP) and it contains multiple PCIe functions, such as EMDIO,
PTP Timer, ENETC PF and VF. Therefore, add these device IDs to
pci_ids.h

Signed-off-by: Wei Fang <wei.fang@nxp.com>
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


