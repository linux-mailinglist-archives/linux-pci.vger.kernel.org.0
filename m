Return-Path: <linux-pci+bounces-131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B697A7F4B40
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 16:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7334A281203
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 15:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681D54CDF3;
	Wed, 22 Nov 2023 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T/ke6Urf"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5004D1FD9;
	Wed, 22 Nov 2023 07:42:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuQhpvHQy7S6F9lpzwDOkYd3Nk79dM0qjd7JuFZA6fE0VHa7sxojWFvU88SxAAccu4dobJMBuuDd5TcBlFcFVbfPL0g5dHWsavQ79F1MfWNw4S1gPNSzJEOJ6mBbH6CwOUlI57wfL+KV5QQLiioEe7Xy7rxuwijGZT+Hffz45R6AA3ajgDMc1zzoNNFE+HLWMaZs8Ygkq93SMV1b8lxHtZOXy/wCd6QHP4KQMvy9L1UTQE40648rzYI2htnCW97w6bu6xKiSPeVuU7BqW87zRpRzGBD5mxlkGz4OU7eoqXSDm8Awztf6Fk+2xJQ/zWnSq+0k0K/Hz/pK60AnUbNtNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6l85ZzpKb9ry4EaafO39aR5+l8n0HiD++1PZyw5IJFk=;
 b=kkK6NQfOWWW6/2/h/uRqzenV5FlV4lddhIbmHLHdQitCmdyvr0BS2KTnAzJM8MNSaM4QB4JzZKHBLRnkpor4SIu3SgVOkrbKotvQqI0EphQ5fjjH0uQFaHzM5uSLlYImBDhUZwdsgLaUdtby9rZFa+9tBUhvK7W0j/eV0WTkWZS3R/dfdOLERez2oD4fGszFmFBMdBUT6mnrWNvzxsiXy0F7pqabAs8DuwTMI1FmvBQr3f1X3wTSSPX+r98Icrb/klXB0qX18zqjehygYKuVADvZAm6jJEGkFcE3tZFIW+NAn5cLLg8BJi1VwuaPwBTU9ploXzSA0mHuc8jUyCa7Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6l85ZzpKb9ry4EaafO39aR5+l8n0HiD++1PZyw5IJFk=;
 b=T/ke6UrfAdg/p0qMUO1tMyctEDWATh+hhMISiACizTEvSO4rsN7Yrk81gVlFXwuZYtm+1ym/7tL8RruMXbDDY1Jrsg7Muxml8BJjZiDMr0+sHE9CzAC22XBLRXhe5dL+wswxCsPAcIZeuGXZ8tIcQ0GCf8SFrpCcvIDi9AiTxyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PA4PR04MB9389.eurprd04.prod.outlook.com (2603:10a6:102:2a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Wed, 22 Nov
 2023 15:42:51 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 15:42:51 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org,
	Wasim Khan <wasim.khan@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH pci] PCI: remove the PCI_VENDOR_ID_NXP alias
Date: Wed, 22 Nov 2023 17:42:41 +0200
Message-Id: <20231122154241.1371647-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0108.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::25) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PA4PR04MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: f4afead0-58d2-46a4-69c3-08dbeb71afc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W7fkxxs/PCtPr4Qi0DNcN42T4iaPp6SevUcLdp8Rc3mIbcAFqZyeIbGSQiBBEZW/9HJOEHqQ93mQG4eJFobRtYcQ8kOFL2NZq0SaKbZNZVyIHHtv1iDK3ppM/wU8RC19CAJuBarse2JW+j2E16IGScE0zu31E6y455BsXp7bX8qRqPVqycwaRawY8cZrDBVZvarVcf8L6g+ZiNtYyjhzjXEjDN8QRqjq4XPz2nA99JuRgUAZECdm72S3xtCMHAj4w7w+caBYzV/Wig0W2T+rvqDCYnAsVVHjl6xMzeFC54iQWpt/V1cAGz/5Lt3AfI3c48iYIR7ufVARqgSjNPrHUWW/8DuU3RuAqELxMO2SsIWTiv4vNOpGOC8fWxO/2uxbBOZDPlzedQSWQHA9jsUBKIcVo8YLI4XXTne5TDeoKW3jjPdSyovvuA4aBITu3ca4ZMRIi+xw8K5Y+9KymNbE7ulMV6dYP4CYgD3rxe5INYu1hTyqPayI5RPYIWH73QFtJwlj2Xha1FFEt5COiZw2QFUcdPqVRIBtZn9TN1AHg7H6X8yHJPidfkyAoazNRlgdkN6bF7CvJZZXi18WWpi7GXdKGg/tANmt90EiXnymU2boD5/OxJM+ijPG+x0t6CdI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(39860400002)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2906002)(5660300002)(54906003)(66476007)(316002)(6916009)(66946007)(86362001)(44832011)(4326008)(8936002)(36756003)(38350700005)(8676002)(66556008)(41300700001)(478600001)(6486002)(2616005)(6506007)(1076003)(6512007)(52116002)(26005)(38100700002)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ui3gMjrN3hwclry/PXVNBRt1euOz6ksrDaMbdjaYongjjuJVaD1e15BHokY5?=
 =?us-ascii?Q?JVbESlzgGCGdFjxQ1Cug2b985wrtLQV19pKVSn5W6FO33O3J+qqohrmTwg4k?=
 =?us-ascii?Q?pJ3m9ksECYIZm/YRWvK3GylRrsPpu3zV/qEuqY9oYL+cvhHiqF4Lg8f6yHn1?=
 =?us-ascii?Q?F4hY5UkzS+/Fp5n0ILeVGQDMFQNLmjXenYbj2/84fJlm44xAoUzXIegz2kKp?=
 =?us-ascii?Q?3zx45uVknFl1qYKeQClrHFS+m2G/9Hc5ny0FWlVe8ocC5xn+VP2HxLyvvu9U?=
 =?us-ascii?Q?dTeDuJf7r6zc8mH6J6jxCmGUN45Ruljo/D7DsijBbvWhHZ8rmVYXcGXGWoBX?=
 =?us-ascii?Q?jUJt+prFrAR23RR2yDhLqZTbM6MZBzMNDITuX+q+lBBNXpJMl0j6HX2XbYxT?=
 =?us-ascii?Q?RpsgDCmjNPPWMO3EmjiUANCONkGiaYXaNnpdKm3rplM+eC4s8lcbrYSbofE8?=
 =?us-ascii?Q?tVjAbAqrbGUc/k6mGsFJ9XzQnFoNLIVEqb8Oeee875xSNp5KMZoDKCREfRTY?=
 =?us-ascii?Q?+tAWbEEeiEkbAZ0yrE3Sc9m8VQLVOWu/4JTZXrMMcBj9ivqoLKOMWB+jCx9o?=
 =?us-ascii?Q?lX7EDdvDh1pCPgKvrwKig/4RZXA7f46cVz7O/8Iypr0oxsPe+E7XaaSzL+Dt?=
 =?us-ascii?Q?AAzfaRl2jPP0Ftlfiv+ix75NYMJdsi/sYHRCMRPawXeO+gssPf5zkz3pI3px?=
 =?us-ascii?Q?3s4Aw0mk6yGYrFbbN1YvB7ZeexFVOq6nv+oCHDUjTTDZ0LN+UbqiZpTrE0m7?=
 =?us-ascii?Q?Ren8lQvy9cN2xAVf/BoxPoqh6hKD5JVDbCuvhVbOAVSgeLZN16YfUiWwhkNO?=
 =?us-ascii?Q?N5mvt2WIuyrQy44nV1Ax2hIg1IZOIF9Wvc9MxPjhXlWUv++TLC4raAdKsEiN?=
 =?us-ascii?Q?WzkXRLCFyrpiLApITZ1NGeG+cpSrobnFY018H3UNGdmvokTOLZJV/8nGziKs?=
 =?us-ascii?Q?KR6ccRk1mwArLHFi2ZXOYyWMNuDvhdAA38+ZpS1/UU2msKO7dP1QTUdQcpNd?=
 =?us-ascii?Q?2wsrHcUr1DNJ0aq0GC/6GvwGSUJob0Ggqx7k/sYx22iM1b9/lfl+YLe16h5a?=
 =?us-ascii?Q?NFg2lqrSSl7VG7EzTW0sjgyHzGofvE7lbW1pXPlZ8fArFp6dNssUAiL3VGGH?=
 =?us-ascii?Q?6o+dZtGWmj9Ctzuc2BD4y8CUsWqtpjorLLiojP4SF01NtxRKBpszulpawL9y?=
 =?us-ascii?Q?e0j0ntVBOa54uwCGD1367wZTlCLGQ0EpgYUxULgCfpp04HHRoGv1RC+FoIvc?=
 =?us-ascii?Q?gtbk8+V4PB+jts30hMLQd3rmgjBKQ/537b/Gn4ByFyoJMeM+TeUs3DiZ3Zub?=
 =?us-ascii?Q?k/JrNFY2BP34Ji+hFyCKJfdzjoe6lKX8NnUEpKDbCB8e8LmDyqNAn1ldrfho?=
 =?us-ascii?Q?O4tfjyj3UjyIOZnHjMuv43ERRim3h68VItEU3QUnjlubSmIubu6BCuaUdowa?=
 =?us-ascii?Q?3GqPBpmD/lkJEh67KNTZ7YFkCKtR46ILjAwRBTY786UP2WTjXTUw3Q2lxOGV?=
 =?us-ascii?Q?UAQtwvxNm274FPDSMaT0J48bkQUttrOb0SGTOlfDCPxIdc643yRy0/mBBZMO?=
 =?us-ascii?Q?zC85rEKAq6B65femLxj/uVSbXNpPUcVJT4OAeUcShtMp+Ey0W0TKVU35VqBc?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4afead0-58d2-46a4-69c3-08dbeb71afc7
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 15:42:51.7753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EQPh2dxYlSgVI88YuxWpP2wgsyz4/4kFLV9wwHxwb54OwlCQS/Z2vaOS9tsYoUqtQZDtny87OwidFbpgD2+YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9389

What is today NXP is the result of some mergers (with Freescale) and
spin-offs (from Philips).

New NXP hardware (for example NETC version 4.1 of the NXP i.MX95
SoC) uses PCI_VENDOR_ID_PHILIPS. And some older hardware uses
PCI_VENDOR_ID_FREESCALE.

If we have PCI_VENDOR_ID_NXP as an alias for PCI_VENDOR_ID_FREESCALE,
we end up needing something like a PCI_VENDOR_ID_NXP2 alias for
PCI_VENDOR_ID_PHILIPS. I think this is more confusing than just spelling
out the vendor ID of the original company that claimed it.

FWIW, the pci.ids repository as of today has:
1131  Philips Semiconductors
1957  Freescale Semiconductor Inc

so this makes the kernel code consistent with that, and with what
"lspci" prints.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/pci/quirks.c    | 50 ++++++++++++++++++++---------------------
 include/linux/pci_ids.h |  1 -
 2 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d208047d1b8f..c95701e36d58 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5092,39 +5092,39 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_ZHAOXIN, 0x3038, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_ZHAOXIN, 0x3104, pci_quirk_mf_endpoint_acs },
 	{ PCI_VENDOR_ID_ZHAOXIN, 0x9083, pci_quirk_mf_endpoint_acs },
-	/* NXP root ports, xx=16, 12, or 08 cores */
+	/* Freescale/NXP root ports, xx=16, 12, or 08 cores */
 	/* LX2xx0A : without security features + CAN-FD */
-	{ PCI_VENDOR_ID_NXP, 0x8d81, pci_quirk_nxp_rp_acs },
-	{ PCI_VENDOR_ID_NXP, 0x8da1, pci_quirk_nxp_rp_acs },
-	{ PCI_VENDOR_ID_NXP, 0x8d83, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_FREESCALE, 0x8d81, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_FREESCALE, 0x8da1, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_FREESCALE, 0x8d83, pci_quirk_nxp_rp_acs },
 	/* LX2xx0C : security features + CAN-FD */
-	{ PCI_VENDOR_ID_NXP, 0x8d80, pci_quirk_nxp_rp_acs },
-	{ PCI_VENDOR_ID_NXP, 0x8da0, pci_quirk_nxp_rp_acs },
-	{ PCI_VENDOR_ID_NXP, 0x8d82, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_FREESCALE, 0x8d80, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_FREESCALE, 0x8da0, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_FREESCALE, 0x8d82, pci_quirk_nxp_rp_acs },
 	/* LX2xx0E : security features + CAN */
-	{ PCI_VENDOR_ID_NXP, 0x8d90, pci_quirk_nxp_rp_acs },
-	{ PCI_VENDOR_ID_NXP, 0x8db0, pci_quirk_nxp_rp_acs },
-	{ PCI_VENDOR_ID_NXP, 0x8d92, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_FREESCALE, 0x8d90, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_FREESCALE, 0x8db0, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_FREESCALE, 0x8d92, pci_quirk_nxp_rp_acs },
 	/* LX2xx0N : without security features + CAN */
-	{ PCI_VENDOR_ID_NXP, 0x8d91, pci_quirk_nxp_rp_acs },
-	{ PCI_VENDOR_ID_NXP, 0x8db1, pci_quirk_nxp_rp_acs },
-	{ PCI_VENDOR_ID_NXP, 0x8d93, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_FREESCALE, 0x8d91, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_FREESCALE, 0x8db1, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_FREESCALE, 0x8d93, pci_quirk_nxp_rp_acs },
 	/* LX2xx2A : without security features + CAN-FD */
-	{ PCI_VENDOR_ID_NXP, 0x8d89, pci_quirk_nxp_rp_acs },
-	{ PCI_VENDOR_ID_NXP, 0x8da9, pci_quirk_nxp_rp_acs },
-	{ PCI_VENDOR_ID_NXP, 0x8d8b, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_FREESCALE, 0x8d89, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_FREESCALE, 0x8da9, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_FREESCALE, 0x8d8b, pci_quirk_nxp_rp_acs },
 	/* LX2xx2C : security features + CAN-FD */
-	{ PCI_VENDOR_ID_NXP, 0x8d88, pci_quirk_nxp_rp_acs },
-	{ PCI_VENDOR_ID_NXP, 0x8da8, pci_quirk_nxp_rp_acs },
-	{ PCI_VENDOR_ID_NXP, 0x8d8a, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_FREESCALE, 0x8d88, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_FREESCALE, 0x8da8, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_FREESCALE, 0x8d8a, pci_quirk_nxp_rp_acs },
 	/* LX2xx2E : security features + CAN */
-	{ PCI_VENDOR_ID_NXP, 0x8d98, pci_quirk_nxp_rp_acs },
-	{ PCI_VENDOR_ID_NXP, 0x8db8, pci_quirk_nxp_rp_acs },
-	{ PCI_VENDOR_ID_NXP, 0x8d9a, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_FREESCALE, 0x8d98, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_FREESCALE, 0x8db8, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_FREESCALE, 0x8d9a, pci_quirk_nxp_rp_acs },
 	/* LX2xx2N : without security features + CAN */
-	{ PCI_VENDOR_ID_NXP, 0x8d99, pci_quirk_nxp_rp_acs },
-	{ PCI_VENDOR_ID_NXP, 0x8db9, pci_quirk_nxp_rp_acs },
-	{ PCI_VENDOR_ID_NXP, 0x8d9b, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_FREESCALE, 0x8d99, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_FREESCALE, 0x8db9, pci_quirk_nxp_rp_acs },
+	{ PCI_VENDOR_ID_FREESCALE, 0x8d9b, pci_quirk_nxp_rp_acs },
 	/* Zhaoxin Root/Downstream Ports */
 	{ PCI_VENDOR_ID_ZHAOXIN, PCI_ANY_ID, pci_quirk_zhaoxin_pcie_ports_acs },
 	/* Wangxun nics */
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 275799b5f535..f837ff427b85 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2469,7 +2469,6 @@
 #define PCI_DEVICE_ID_TDI_EHCI          0x0101
 
 #define PCI_VENDOR_ID_FREESCALE		0x1957	/* duplicate: NXP */
-#define PCI_VENDOR_ID_NXP		0x1957	/* duplicate: FREESCALE */
 #define PCI_DEVICE_ID_MPC8308		0xc006
 #define PCI_DEVICE_ID_MPC8315E		0x00b4
 #define PCI_DEVICE_ID_MPC8315		0x00b5
-- 
2.34.1


