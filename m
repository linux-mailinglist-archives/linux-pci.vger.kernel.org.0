Return-Path: <linux-pci+bounces-14071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 109DD99668D
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 12:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2871C22339
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 10:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF3618F2C5;
	Wed,  9 Oct 2024 10:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lzt6/rWe"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010059.outbound.protection.outlook.com [52.101.69.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF3E18F2D4;
	Wed,  9 Oct 2024 10:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468428; cv=fail; b=jOJwa44EOyh6+a9B278pZXop2tWJu1lqA1BbmuZkwQ7ak2cvPreDibrWwcMRzBMsPvDOHsJZ69YaWKR/wGDZzMyzZ6/g2pHUCNuglfH+mzgLRH/FkVPRFLKFjYzRtsSPgIXkLb/0bBh/0Lb598avUPE6sgyAH4y8/lE+2cXRYRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468428; c=relaxed/simple;
	bh=ivBpcJ2SCZ0haFIfaO0WHqrg5WxHhL2KGehjbDcpqes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FKbcdxotrD193xpVEiW6ETkNZ8CM9BlkPdLpCp3fIJv4ohhHreham2+kQNyU5XwPH9lYw8djT9uDsqE5U505QnE6QICvA4uDG6vdz8HwcsshS8wPcQcl5ZXkWZFgzj5kRrTn5sBN+Kv8iHx9ddQX69Qyhw13CmiYHYnrmghckvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Lzt6/rWe; arc=fail smtp.client-ip=52.101.69.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSE/ldxOTCho61kV68bMp+S/HYoWhDFY3f61XJ/9tZcSqoqGujvuLsRdSmi464gmknmiXZePI0oqHwBQp+Upqh4bx6++go6pkESpuvfeBIxkdk9aUgqQiwtI/w3q02LOZMi4mspRcGDPjKXxsh1tXf4xVYIs1jSudxifGO8TMD8uzGpfNrYyXWTEsjtqJoNwGd5gBpTY8MWZwKm9elHBxTdGtf6FssWIanX/8brZDbSO7Oo/YjdLXUwfqldOD8u/8MKPJC9QUtUCi7W0pWxgwuLDIwJQsNGNlKBQgfvN2agHvxwecQ9x5HzG0cRH6FvFYVCAog8uIAq2Q4Jp16peOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cx3seEEpKe34KsMUC8CLUiN3V8WBcwJm17eLUO7vDyI=;
 b=EiHAikIMu6EvwM3/QtPuBc9LUATtU/y/c53mmKb9/Z5CBx6HcGAztJK2+Xdjm7oEVFi6/mp0CGzIbhesXy/L4nhqzkGVCK+MVXfq4JypPp9WC/2DkTljZzedVcAr8eeGg3hplThKdEe9kFTsJ03ussiai9e2A9ggwJI5GfaLqkl7lggfzQbsm82NmKHMTRQ0RV2mzUGt8v+LuyDn1w1aMtws3GA988ZJJNI9ZNKh/dPhNjfHj24YDwl2YATgDa9ja5+rTlbdvbBRhqlH3p1hmS/Vjq4RKalnbt/JabYM+cNoV/bKdEWaoPgjGY/wNYrNHAjK/G6mJ+Bnw2NDFCq/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cx3seEEpKe34KsMUC8CLUiN3V8WBcwJm17eLUO7vDyI=;
 b=Lzt6/rWeWM3BkdD7mbPobtHkx2T3hoxZ+2dh/SBjnxGSvdae67+RjVvED2NcEGn91mXZ0hqB9Kh6VKcuZMGQbGPoefk3xOQTzc+FvTJ7ApXKa5mOyxMUfM/yyzIsWoZCZ8lHYKgvmYia6VXEBoGJPDqS52KZv3AiMphsGP7mHYQZ1GH5wefcxYvds4vxeONwPoHcixWIG8N/OvURYSyweQ1NeZ4aEZ0N+EWbZl54+OjS++ZfRNm92JFlB0HoklumeQ6NdyPxTvvdSDUR6a1HpiwG0ycHj5Go8PtV1UZy3Qfgl26R2gTxUNEWXNDlL09l4GF4yOgIWCf1uCAbPn49MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV1PR04MB10154.eurprd04.prod.outlook.com (2603:10a6:150:1ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 10:06:56 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Wed, 9 Oct 2024
 10:06:56 +0000
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
	bhelgaas@google.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH net-next 07/11] PCI: Add NXP NETC vendor ID and device IDs
Date: Wed,  9 Oct 2024 17:51:12 +0800
Message-Id: <20241009095116.147412-8-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009095116.147412-1-wei.fang@nxp.com>
References: <20241009095116.147412-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0175.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::31) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GV1PR04MB10154:EE_
X-MS-Office365-Filtering-Correlation-Id: c0950e16-8eb7-4494-a6dc-08dce84a1b35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5MUSQSFKjC4JQkujCxW/oSHeNeLC3oOZ3CnJs2RVpQs7ER+RqnyZZEQ51Dq4?=
 =?us-ascii?Q?HG41hOrealIBU4fURNYQt7zYF/xDU/IQl8Fa7n4KcPcM26Xh5JFDELU9ldB/?=
 =?us-ascii?Q?O3KAfi3ao36aSE3GvGPV5IC+qlDT14X/gZm9f3jzi7HXG+P7HedZI4djEeLd?=
 =?us-ascii?Q?mZeZiU7IdhXwtEjyORTMK+Z+pg30mfC02H7+NiTTa7XgckEPDe/HUePfHd+G?=
 =?us-ascii?Q?xjL28+nGt3lknf8IlMda1LMEZyuCvA/lxkBjP6kxibWfWaUkNXMkiVOMdesc?=
 =?us-ascii?Q?h9kDfa582RVqGx1nSFGy4VwfwCRZMnYacaZb2LsLlh7UMVxyDb0t75+c6z2a?=
 =?us-ascii?Q?QLUDZk5t6pQ0Ve73XGgNndLXgPcSKZWVemHQXm9OIT28A5MHHjXwwkHjxGns?=
 =?us-ascii?Q?UFLfhNFYtIHny3pT2VYdgOOghXBZJI3egD17IxavaVpzb28qLbpQIJliK5qX?=
 =?us-ascii?Q?g2Q1znDcuR3ZdDAE6SAVP9YTu014PcaM/o68wUE/Okf1pOjWkSOBe/UnSPOg?=
 =?us-ascii?Q?4H+hFMtJfeVus2isVWPGKNlvH6xv+4sY6H7e9VTxd8r0Ozk5LOaHpEfzydE2?=
 =?us-ascii?Q?uGvDsxv0Pb0InKgYB5sXkRP8cP5XSrDp3UFz5NK1mXbzzJz5+uCtlzGhyxVf?=
 =?us-ascii?Q?ZGWbWN6jThQZSu5sKharttQcl0fvnJrgs/UHGeH7oDNFL41q/3J69Yzk384s?=
 =?us-ascii?Q?k+IuzUieX1u3UgxHzRKyf31WHcbjQJdQvT19S9jv8BYjWqJ5O663+616PCpm?=
 =?us-ascii?Q?L6L1J3CTJy0tByhDm/qLkw8d12m3+ghiOB35D7qb0xswVrCO2lZAX5n7T7Xy?=
 =?us-ascii?Q?xKPn1VPiFCWmhmZ3Au/CwT5YRfr2TFQU+CKJXQnMKFyO3z3+/GCPnXZWYtI1?=
 =?us-ascii?Q?Ii3M0cEl2BJC0o0ZAeARuUbUAvAxlVzkGkbJGxWl4SFfktcb5s9MtjTivees?=
 =?us-ascii?Q?5bNWVn2yS4CSfvIqSngDrTV2AiqUn2mYWb7D1D5hW08CdAAnDkIIvtytQMnC?=
 =?us-ascii?Q?QBaz7xcb0PwV6xE6W4o3JyXIrMTzT1Lmnei7ag8YFPvY/p16FSjWThzjiGhH?=
 =?us-ascii?Q?58GOibpbqDIn+162O1YHwVTOEdduxVqsMWB5Vgmz7O5/SueBYt+AqJ5ZMbcZ?=
 =?us-ascii?Q?VOYopoThRLahyQDvYae0kpJ52rp6W2XT7CSiVir0+oAMxH/MnKgaYD09uuIM?=
 =?us-ascii?Q?quRBCRz+mLqJhsf979B8faMpVGtDECs2yk85NA6lXRVrZR8D8v83rav7OUhl?=
 =?us-ascii?Q?Afd0FwM4I7V4lLS8fpIcd6D2wOUufZnrOT4jbbvLWy/LgkFuWWh/h8qjLXJr?=
 =?us-ascii?Q?IO3WiJvhN4HrvTXIxcmFZ+TA6dU36rzuN8oWMnUH3Ck1nqLfj/KtUvmp6fpv?=
 =?us-ascii?Q?zv03vMM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i7BHmiwi10yxS/lhdK17M/90Dj6NfahOMVWzHPX2/DA9BUYbHDB3HfMqvfWt?=
 =?us-ascii?Q?Lxk4wW74ecWBs1JsTLo/95/M26FpBTZGBuDxGtgWDA0Ui9+5qoWMGyJYiUl/?=
 =?us-ascii?Q?eDE6e3nBjPBdznPp6ZPqh3WAx0zYtjQqxWQbAU5psjOm5BJJxbRDxVWVNV/E?=
 =?us-ascii?Q?ESKid4wSAevtt5NBAHbOFoCdYkqv8cE84VoOwxw+UERl+ap1TTkWXFMfSCYs?=
 =?us-ascii?Q?yrlJvQgh2JH46REmA8svTU8gDjsslktd2EJdBf7XCCB4YeIkf0oT6BwWQ5km?=
 =?us-ascii?Q?EzUxZUrge3OIuHtNFqFQgikpqe1JmBEAO6wBG0WuoRO4LYe2Fk38kUN9WC7m?=
 =?us-ascii?Q?UCqLcLb0OmYEUFMXMQxAZ0scZylCQSacB9Q2dbJUiBQcNugD0g4+X7hXROGq?=
 =?us-ascii?Q?SGVgzXbYWcYUZypDyHU7jtwXzyqxyK/i+hGhJxPIRcepZ1vqltex1pv+kjod?=
 =?us-ascii?Q?fqwwpnQtothfnFY67jvGNohrRO0l03Ys1jBXwEsiFiUjVqd5bNfY7m6djAHf?=
 =?us-ascii?Q?rzxeIwcuUR7iNGqAYMa06YbO20PohQ6O1jGT+ywpdw5/KVhNDn17w7ZcsHbp?=
 =?us-ascii?Q?Wq8TOA1thD0rXppqdzYT9NbyzNM8t80N3pOOAAdCCorAqMbkcKcb7XxVUHcK?=
 =?us-ascii?Q?k/Vro806EYL+hrfLvrVQxyThwm2xypzCpiUGEGz5jjpwPfowqW+2hBMzDahf?=
 =?us-ascii?Q?8CVPe0HkZn3NnmKWhqNHBXT5B4Z0sBeIWjSWVWB8oeiXsHp33WLOSG6W9v/W?=
 =?us-ascii?Q?oz18aTp3eqn/mN6DwBHmW6P4qBcRD9LKpvtyYHGn+33oCh4rFnzQVVgfAk1y?=
 =?us-ascii?Q?uJ09/tpDZ+BqpR9VvOGtOMD6y+YPim2W5mSYrAm7VV9piEdEDCQQxQlRt5P/?=
 =?us-ascii?Q?c5IZPoawJhGA1Dff+ecnPIbGxOMvCR3/tGLkEcKXPEU6s2Y5fR0Y8idaXxYC?=
 =?us-ascii?Q?heM2kp/kYzLLZsK4IuV2UDLfnjcQT1es+rDkcmWOTHgeWlLWwZPy0z03i/Qm?=
 =?us-ascii?Q?ZudD5FIVw4xjUGfizms8Ro4+7KBsB86IcZ4zXDIDUzaVrcT1mT9C/XNnHmn5?=
 =?us-ascii?Q?GXGHi407rc/G0p99HKQpoXi1hFW5S7U1V343PVm+qOq3oJswvSoEtVCivAWX?=
 =?us-ascii?Q?O4sNHMUvep6sIl+LfDVEdB1iBGWKwa+yZPBhM2EU3Vwa2HCKaT0Hbzmx4q3d?=
 =?us-ascii?Q?eaXX8PjgFUB89Qgz//nI2IYgGB7ed8awaJjAUE0LQPO0s69G7RpW99xM2CwO?=
 =?us-ascii?Q?Mnoc+cEynBz9nQYR+W92hI9XTmAEFTXY9nBCsEyj0uyDsIIiZY/KdMy4Sv1i?=
 =?us-ascii?Q?ojEjaRVDoTi5AgNCwSrKlHTZ/MsVoXGrGSvHfD7UDR9ezYR44WlM6PSqT3r8?=
 =?us-ascii?Q?Q76DtBMoltdJWCUcIw1EMYCMzfRZv7VWNpA0yLF8x42Em8UcBDJ+TsUN/Wlo?=
 =?us-ascii?Q?HyOVU0aMafzdrWFeB/277ihRkG0EWRtpgF8M5upNr36EHcezPIYH0NfgGu2/?=
 =?us-ascii?Q?rxgHlcKfz4IJX53OWpoyMzkVC7Vz+c9LXL30QnsFh8ryEc39eUmDmhrwCvmn?=
 =?us-ascii?Q?MRSlNYVG3UV4lXYLZOV5AxviPpLSHT8k/GhN1lwh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0950e16-8eb7-4494-a6dc-08dce84a1b35
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 10:06:56.4627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZlgP/hhEA7No2nkT0GQqzCcmJM9EqxvbgChhL/s9Sg+dnl0CK6K33xtg9m+brQWL4Qlfyr3gs+H97eCqA2qNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10154

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


