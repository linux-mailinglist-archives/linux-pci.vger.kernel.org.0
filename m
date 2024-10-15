Return-Path: <linux-pci+bounces-14541-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7091C99EC2B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 15:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 303EA286F6B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 13:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467EF1F130D;
	Tue, 15 Oct 2024 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EvT2s/Sy"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2079.outbound.protection.outlook.com [40.107.249.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03DA1C07DF;
	Tue, 15 Oct 2024 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998049; cv=fail; b=UNMtBbySQxjXh1AGlkmWZc7ViE0Ouik1xXzCcyyE4r7DSdPxara+NFMVwm8Q8qREO5SaHA+nesTGYJuRVb9Wzj1k58AMQvFn92XPpaWK94dTMmpBEMAwhi+vodvRnXyT05oDeGIqn+AzTHKW5hxXh6CBVD6DC1yOqk/NESFsVa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998049; c=relaxed/simple;
	bh=nMNstx8N/DHc34wc/epr1BcfPX/BDc+MTGNUyWSpM4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qf3aJyeTjJGO9dnyQcItPjHTKWbNNSj717v3V9H7ExA2LI9T88uMpd9SsNvqcfoi/wdeZWmFwLgFhC4XpfkRYk01zHCZx6em7hfUSryCGyfxLwUBm1bpmP3nPSRHnCmU1d9vQgJAw14tYqPUxIec/z1gaAa9sFnTq4F2q2hIuJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EvT2s/Sy; arc=fail smtp.client-ip=40.107.249.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwrSnjMOBK6fgwjTs+Tg5ehCydM/RKWUp0sI/7SW1zYHFyoJWkerJxb8uUqB89oMgk7n9GduZ+4VOd2KNSZmUCmEW7brmDeAl5pIij/S0g6fCMqF+BhK5khY2a84TlXg54s3Hl2fm2wGNbXVo29ZyF65ZdGjHFiaHQLdYXmzOyMtE7qWZn0kurVsFGpS8hwkJ8/UJN3Hoey4Ha2llQeJw7HMZtNqyA7bSZZYtWkhIdhdMPXJ5WUApPhtPSqNTZocGLt43hpqau8Mq0f6tNz2qeVA+oPIikgz7TPlRbwO+z37zqhCUlyvG41OUG1Ts73altVHe77If/B6YjSyRgMG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=et3/3713zFU3WJwXkhw0hKja9HoPGKS9rMBOmB0bplM=;
 b=mHrnjjDyQRaRASRubm0KRWb+jUybVm3ZVZjMsjkKUzwaFi6VkUCf6LAtAAw7tlgTcsneedRYyn5talYQ76Lcaw49d6aMCJ6bi4k4tbsYdoOCS2nX8h/JH5JxWWY98T7TCakCqB4gYH5Wr+Jl11/Q0MDFnmuVCZkv+M2cPRCtlbvPVcK2lGiJvs5kvxT2EWU+Uf9P5svAJHQXm7mBvKCzCPJrtitW9zAcB8HFdbipghXufTsCtuxt60/hNEPWuPgFYGijGZkC3hvRlN7z7l6dNRNPzNWkAq2IeZByPuN5kG/Xa9DEtUGWo5Q1RakKmOcLi5bKY0JGtMzdFm8wD7kK4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=et3/3713zFU3WJwXkhw0hKja9HoPGKS9rMBOmB0bplM=;
 b=EvT2s/SylMZjvJslrkxrEXVpPwVyqgHcKj/2wgF9y3+D8HvI5Tf5p6FygSq+DSKJJ6ILwQTCMW7zrjcOXywfUPFrdkRwHI/Gv5st8yeY2Jcy0c+hXY/CNTPeNSYCVm9n4TbfLTeq48FPmiBpzrho/CZmQsKl4PkEhxRYq3BJhx/IG+SPEq0W789+rgLu1rUo6d7jEhS1NfODlMAyAPl3hG5WmTY3MwBVnMus5Lp3jEI+PMR9cmLv0YdM7I/A6t5oZdzGcq9f/9sKnKg1dMXzrQs5DW30YZlsRagmq1BmvMlxLBJgcBENyzl2hoDB/LgbgvBCgumaX5IAPVRVgo6BfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB11041.eurprd04.prod.outlook.com (2603:10a6:150:218::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 13:14:02 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Tue, 15 Oct 2024
 13:13:56 +0000
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
Subject: [PATCH v2 net-next 04/13] net: enetc: add initial netc-blk-ctrl driver support
Date: Tue, 15 Oct 2024 20:58:32 +0800
Message-Id: <20241015125841.1075560-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015125841.1075560-1-wei.fang@nxp.com>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GVXPR04MB11041:EE_
X-MS-Office365-Filtering-Correlation-Id: 648e28ae-aaac-4ed1-1bfe-08dced1b3911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FTUUW2F+KqBX+D/sTkVaUnljLppPidMWfbxwoNY6qdvQL00EnDGAn8+i69WM?=
 =?us-ascii?Q?OnunbS/tf0WDo4qalxd9Bw+Kmyh/rFWszrm3o6iXpU8ZLHpQH+O3Hey7aQyK?=
 =?us-ascii?Q?cxLqs1WRUMmJkZCtn/oNM4wVbOQo+7kUss65DcKWiB870aGih24Heo4PNbnh?=
 =?us-ascii?Q?Ft5gAON/8mZpSUnKldbWX6V19mSHjEuz7mXAhZ2Pdfv0fKXKKE0vzTzKHRQ5?=
 =?us-ascii?Q?NhmihzMKh6sQe7z05oR3/M68xuhTpaa4yij7VqEuFq7k/f9lVlwKGZwml+94?=
 =?us-ascii?Q?pgrwvYL57QUVUStwuv8Pe0ZX2npFUyh8D51totBIqzFSX9M05my3SdPWDOSh?=
 =?us-ascii?Q?b7aMi25RsKtX6c4bzQp5Z190MlhOSodKi55X0t/QXTYDtdcz1w4H8oR652Zu?=
 =?us-ascii?Q?fM5fz7EgC9JA8s/h4Gnx5azz4uu80CdCHmvcHxjeT8I2GrlH+u4pssOt9ppa?=
 =?us-ascii?Q?WWGV98t92UzL6zt8OVw8EGxZig4vplCERbhoGr7uC0L3jqhztOLBAFE97OUM?=
 =?us-ascii?Q?4f+Yhqqp/sXVGwdPkbmrr5uMOalZFlb499ID2It49w4finpI/8hGIprsV7lU?=
 =?us-ascii?Q?CKQ+lnngWMm7ygqakEc5o59SzsTMCiTahbub1+XdKSVuNn4+ocNe+mXu/HD+?=
 =?us-ascii?Q?1jekfo9+wNLuYUxEDoH9uGv96VyZteiT8E6JUSLJHLCcwCyqS20WaXQqeHCx?=
 =?us-ascii?Q?SF0VZr2PAWddb4GEiPb5RqSn0i0w2G0Zy2BHoTH7g496I/7KBb3+A8R9WXOh?=
 =?us-ascii?Q?LB0PRP76Sp6m3rbZUdeZl+5ySnT1p/M2R3EvT7RJ+f6bRls0Teo8Qi9vf5tK?=
 =?us-ascii?Q?d4KxR4twwauOPXXIUsyLsxKa/7zXo5WnD3zYpkHr8yavb0n9PU8r3ShcgmcO?=
 =?us-ascii?Q?S9dsi0reEfR4qblTMxWKWLYt4qGyZVvjHcy2Qtf4bkN7UeK+jj7cAOtcTUsv?=
 =?us-ascii?Q?pTYmvIMy0zNQDn2JEsVCybhchbd6CCS5Z3Z5dzTzyFPJ6DRdZrnCflEUn3a7?=
 =?us-ascii?Q?gIhijoD7gzZoyMMnAkmPWSj/jKUcrrB1ckq3nqBq7YZwTs4nHOWlH8zgtjfC?=
 =?us-ascii?Q?ystxHbRCJxf0nXIEdLCNHreivI5cjgIDO41pnxIhTJ8Zwjh82QFe4+YrSizS?=
 =?us-ascii?Q?RnCVKVDcuVoR4cENlFE2tS13xkJp9FCz545F03GpE+PtGB2cpxMD9YeGGuDF?=
 =?us-ascii?Q?45HTvVJ340k1uRPmFCuq03h8cdoih1gVjqwMuoPIxjvYYMFnCToRKzVp/38S?=
 =?us-ascii?Q?OxQtc/VqoJdMir6cZGlS6TrVrB7GecyvZ2HwHa529jDqLRgJ38xXmN0GKzIb?=
 =?us-ascii?Q?JbRg9RxkdRSLXbw+/10I/85yV5KiNwdisxpK9/zfVzBeAGLA8CWvl4x6MG6W?=
 =?us-ascii?Q?7sQ0e4g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WIckJxLTV4MCmPDkJMPDxpxFAQ08DpPKuysB7m4eAN3LFR03iuH3kVr57jw+?=
 =?us-ascii?Q?savJw3JvK6G8fgDuBivazAUvvNyIMWRtgP/8z7v7oemY5YeUqMgBZBN3nOJD?=
 =?us-ascii?Q?+uSV0lTLgxtYaAaLFORhDVWYotmfcgHf3tPqcU2kaNyXQUpR3PEUP6dFBfQO?=
 =?us-ascii?Q?67gCgHmJDLDYRH6Upididk4K7/RjJGpb9MGnoNnwKdk8VpmDiMmfUCvUD0gk?=
 =?us-ascii?Q?gvc+aQaxxE4K9UqO/QS8SJtu+xLTp8ZpvswK/yEhVIfgDh1zvZ5ozuosGnYe?=
 =?us-ascii?Q?YagyvMwMXvKcBo8lFAl5255pzd8NYKk7DYP9oxcFsxwY5ErJ/WTBWGZfzKJG?=
 =?us-ascii?Q?IeDzaTciZ2NXcK29cxih3iwSLdnM0XlSBx96AmQ9VtAFTOzFvXQkGB7A2ZEf?=
 =?us-ascii?Q?vKYKRfKnIPdSaqgrsLwXfhYbG6kw2HwXxAHiwQm5l+ZYUXRjrNHilo7XEauZ?=
 =?us-ascii?Q?O456Uel2ROSifxS0ZYpRJ6KcgBwXgDymPfbJKSrmFKdCY+8ZY+51N5ZUEScx?=
 =?us-ascii?Q?IbvAB7qyHhdvhi8Hp4rOt1XgC890cIrQqs6CHFOlZ982ZAzU509NW0cKhxfz?=
 =?us-ascii?Q?5dZey9Yqb0rLF19pI/lN/skAEtxx6C3BU1GPpG+j/rgntuXt72LwgSg9HrUW?=
 =?us-ascii?Q?Gs8n+ExU0Hfc8UVwRCXaJ+w3Iy9f/XdbjlIs2FQtnOO/4bNI+GfbLxRH8avF?=
 =?us-ascii?Q?ojgUWw0rdCi9EKIBHxM28LI2VniqfSVcd/kIS0DbRUrDmY1zsGFhwuuH3qOD?=
 =?us-ascii?Q?MhO/LFa7StdILoDoRTYX11cyL6DpUJmzXrcvcb2CU4O0IzLUNTK6cp15x3oA?=
 =?us-ascii?Q?oyiq114kHE+W0ybsV05scR7fLCaQ7POp7wIH/Jr/ecT2gLovPjWo23rcn5Iv?=
 =?us-ascii?Q?f6U/F1fxUTgnHsWxpB0v39QhD4la0iJiwf/ORvhqU0f8QzNIPQ936Hze5CsX?=
 =?us-ascii?Q?u1v6KEevbYj5EB7XCLMaLCQppHZrx1RaSav5DKSOTS89za2DyuBPacEmF8py?=
 =?us-ascii?Q?NHIV5LCQh43QLP2KscRgmes2XzRgL3JYA0WZOURBRZUYW65nCV1+4zuEufdG?=
 =?us-ascii?Q?a2XFkkWsALKA8KY5THeDP7x4pGDPzm+hTf/8iNywYP0BjccrmOBBZ0wvE4pG?=
 =?us-ascii?Q?De7u7Wms8VmEughsmUqEBlZE70fPIPh2VxgHrug2lzj39OjjMA18amveLiE9?=
 =?us-ascii?Q?v/CHfpgWAOaV8eEDnrdR6PQuNZyjwkCQGSd5THJngSoNj4zMd6QedbpkvAla?=
 =?us-ascii?Q?ZqsSZALhzRrYzpiJny7puqKirZxm9TcaOuUby/F3haFeUTiht7hoNoF+L7sp?=
 =?us-ascii?Q?uJhrFGSBiMbAAzJ2w58+8ttk0XrbnNr9uTVs+9/rUXqxVLKhhvWQJaVGew40?=
 =?us-ascii?Q?9S0OBIlVhVmLJL0qT2Ojs+mQtJ0549zktcKuckRuSLxhVumTQ2GH2EdG6XSq?=
 =?us-ascii?Q?zGO/z8w5jSj/VA0j+SjT9/3N4EMItsC7Crz6KwPayyKrrfVtPyAjTpPIBHi6?=
 =?us-ascii?Q?4cmwSF1SHKtSwWRK+MPUdr9jRakGZYe4xuLpta0/jGuf2A5myw5rny3MbjE4?=
 =?us-ascii?Q?qWATPjQ4vHbmyQsymr5qNd6SWiKSsOL1aeG5pdnP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 648e28ae-aaac-4ed1-1bfe-08dced1b3911
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 13:13:55.9648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gGrFs0CEF9fIlVzq+4xzCmaBbg5ZZg5xYZFoO54LdwPgtBDu1W8GBjgxtOpAZtVPOAaxxMR0bCuGKLM4HoJNKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11041

The netc-blk-ctrl driver is used to configure Integrated Endpoint
Register Block (IERB) and Privileged Register Block (PRB) of NETC.
For i.MX platforms, it is also used to configure the NETCMIX block.

The IERB contains registers that are used for pre-boot initialization,
debug, and non-customer configuration. The PRB controls global reset
and global error handling for NETC. The NETCMIX block is mainly used
to set MII protocol and PCS protocol of the links, it also contains
settings for some other functions.

Note the IERB configuration registers can only be written after being
unlocked by PRB, otherwise, all write operations are inhibited. A warm
reset is performed when the IERB is unlocked, and it results in an FLR
to all NETC devices. Therefore, all NETC device drivers must be probed
or initialized after the warm reset is finished.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2 changes:
1. Add linux/bits.h
2. Remove the useless check at the beginning of netc_blk_ctrl_probe().
3. Use dev_err_probe() in netc_blk_ctrl_probe().
---
 drivers/net/ethernet/freescale/enetc/Kconfig  |  14 +
 drivers/net/ethernet/freescale/enetc/Makefile |   3 +
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 472 ++++++++++++++++++
 include/linux/fsl/netc_global.h               |  39 ++
 4 files changed, 528 insertions(+)
 create mode 100644 drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
 create mode 100644 include/linux/fsl/netc_global.h

diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
index 4d75e6807e92..51d80ea959d4 100644
--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -75,3 +75,17 @@ config FSL_ENETC_QOS
 	  enable/disable from user space via Qos commands(tc). In the kernel
 	  side, it can be loaded by Qos driver. Currently, it is only support
 	  taprio(802.1Qbv) and Credit Based Shaper(802.1Qbu).
+
+config NXP_NETC_BLK_CTRL
+	tristate "NETC blocks control driver"
+	help
+	  This driver configures Integrated Endpoint Register Block (IERB) and
+	  Privileged Register Block (PRB) of NETC. For i.MX platforms, it also
+	  includes the configuration of NETCMIX block.
+	  The IERB contains registers that are used for pre-boot initialization,
+	  debug, and non-customer configuration. The PRB controls global reset
+	  and global error handling for NETC. The NETCMIX block is mainly used
+	  to set MII protocol and PCS protocol of the links, it also contains
+	  settings for some other functions.
+
+	  If compiled as module (M), the module name is nxp-netc-blk-ctrl.
diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
index b13cbbabb2ea..5c277910d538 100644
--- a/drivers/net/ethernet/freescale/enetc/Makefile
+++ b/drivers/net/ethernet/freescale/enetc/Makefile
@@ -19,3 +19,6 @@ fsl-enetc-mdio-y := enetc_pci_mdio.o enetc_mdio.o
 
 obj-$(CONFIG_FSL_ENETC_PTP_CLOCK) += fsl-enetc-ptp.o
 fsl-enetc-ptp-y := enetc_ptp.o
+
+obj-$(CONFIG_NXP_NETC_BLK_CTRL) += nxp-netc-blk-ctrl.o
+nxp-netc-blk-ctrl-y := netc_blk_ctrl.o
\ No newline at end of file
diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
new file mode 100644
index 000000000000..62c912aeeb5d
--- /dev/null
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -0,0 +1,472 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * NXP NETC Blocks Control Driver
+ *
+ * Copyright 2024 NXP
+ */
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/fsl/netc_global.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_net.h>
+#include <linux/of_platform.h>
+#include <linux/phy.h>
+#include <linux/platform_device.h>
+#include <linux/seq_file.h>
+
+/* NETCMIX registers */
+#define IMX95_CFG_LINK_IO_VAR		0x0
+#define  IO_VAR_16FF_16G_SERDES		0x1
+#define  IO_VAR(port, var)		(((var) & 0xf) << ((port) << 2))
+
+#define IMX95_CFG_LINK_MII_PROT		0x4
+#define CFG_LINK_MII_PORT_0		GENMASK(3, 0)
+#define CFG_LINK_MII_PORT_1		GENMASK(7, 4)
+#define  MII_PROT_MII			0x0
+#define  MII_PROT_RMII			0x1
+#define  MII_PROT_RGMII			0x2
+#define  MII_PROT_SERIAL		0x3
+#define  MII_PROT(port, prot)		(((prot) & 0xf) << ((port) << 2))
+
+#define IMX95_CFG_LINK_PCS_PROT(a)	(0x8 + (a) * 4)
+#define PCS_PROT_1G_SGMII		BIT(0)
+#define PCS_PROT_2500M_SGMII		BIT(1)
+#define PCS_PROT_XFI			BIT(3)
+#define PCS_PROT_SFI			BIT(4)
+#define PCS_PROT_10G_SXGMII		BIT(6)
+
+/* NETC privileged register block register */
+#define PRB_NETCRR			0x100
+#define  NETCRR_SR			BIT(0)
+#define  NETCRR_LOCK			BIT(1)
+
+#define PRB_NETCSR			0x104
+#define  NETCSR_ERROR			BIT(0)
+#define  NETCSR_STATE			BIT(1)
+
+/* NETC integrated endpoint register block register */
+#define IERB_EMDIOFAUXR			0x344
+#define IERB_T0FAUXR			0x444
+#define IERB_EFAUXR(a)			(0x3044 + 0x100 * (a))
+#define IERB_VFAUXR(a)			(0x4004 + 0x40 * (a))
+#define FAUXR_LDID			GENMASK(3, 0)
+
+/* Platform information */
+#define IMX95_ENETC0_BUS_DEVFN		0x0
+#define IMX95_ENETC1_BUS_DEVFN		0x40
+#define IMX95_ENETC2_BUS_DEVFN		0x80
+
+/* Flags for different platforms */
+#define NETC_HAS_NETCMIX		BIT(0)
+
+struct netc_devinfo {
+	u32 flags;
+	int (*netcmix_init)(struct platform_device *pdev);
+	int (*ierb_init)(struct platform_device *pdev);
+};
+
+struct netc_blk_ctrl {
+	void __iomem *prb;
+	void __iomem *ierb;
+	void __iomem *netcmix;
+	struct clk *ipg_clk;
+
+	const struct netc_devinfo *devinfo;
+	struct platform_device *pdev;
+	struct dentry *debugfs_root;
+};
+
+static void netc_reg_write(void __iomem *base, u32 offset, u32 val)
+{
+	netc_write(base + offset, val);
+}
+
+static u32 netc_reg_read(void __iomem *base, u32 offset)
+{
+	return netc_read(base + offset);
+}
+
+static int netc_of_pci_get_bus_devfn(struct device_node *np)
+{
+	u32 reg[5];
+	int error;
+
+	error = of_property_read_u32_array(np, "reg", reg, ARRAY_SIZE(reg));
+	if (error)
+		return error;
+
+	return (reg[0] >> 8) & 0xffff;
+}
+
+static int netc_get_link_mii_protocol(phy_interface_t interface)
+{
+	switch (interface) {
+	case PHY_INTERFACE_MODE_MII:
+		return MII_PROT_MII;
+	case PHY_INTERFACE_MODE_RMII:
+		return MII_PROT_RMII;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		return MII_PROT_RGMII;
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_2500BASEX:
+	case PHY_INTERFACE_MODE_10GBASER:
+	case PHY_INTERFACE_MODE_XGMII:
+	case PHY_INTERFACE_MODE_USXGMII:
+		return MII_PROT_SERIAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int imx95_netcmix_init(struct platform_device *pdev)
+{
+	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
+	phy_interface_t interface;
+	int bus_devfn, mii_proto;
+	u32 val;
+	int err;
+
+	/* Default setting of MII protocol */
+	val = MII_PROT(0, MII_PROT_RGMII) | MII_PROT(1, MII_PROT_RGMII) |
+	      MII_PROT(2, MII_PROT_SERIAL);
+
+	/* Update the link MII protocol through parsing phy-mode */
+	for_each_available_child_of_node_scoped(np, child) {
+		for_each_available_child_of_node_scoped(child, gchild) {
+			if (!of_device_is_compatible(gchild, "nxp,imx95-enetc"))
+				continue;
+
+			bus_devfn = netc_of_pci_get_bus_devfn(gchild);
+			if (bus_devfn < 0)
+				return -EINVAL;
+
+			if (bus_devfn == IMX95_ENETC2_BUS_DEVFN)
+				continue;
+
+			err = of_get_phy_mode(gchild, &interface);
+			if (err)
+				continue;
+
+			mii_proto = netc_get_link_mii_protocol(interface);
+			if (mii_proto < 0)
+				return -EINVAL;
+
+			switch (bus_devfn) {
+			case IMX95_ENETC0_BUS_DEVFN:
+				val = u32_replace_bits(val, mii_proto,
+						       CFG_LINK_MII_PORT_0);
+				break;
+			case IMX95_ENETC1_BUS_DEVFN:
+				val = u32_replace_bits(val, mii_proto,
+						       CFG_LINK_MII_PORT_1);
+				break;
+			default:
+				return -EINVAL;
+			}
+		}
+	}
+
+	/* Configure Link I/O variant */
+	netc_reg_write(priv->netcmix, IMX95_CFG_LINK_IO_VAR,
+		       IO_VAR(2, IO_VAR_16FF_16G_SERDES));
+	/* Configure Link 2 PCS protocol */
+	netc_reg_write(priv->netcmix, IMX95_CFG_LINK_PCS_PROT(2),
+		       PCS_PROT_10G_SXGMII);
+	netc_reg_write(priv->netcmix, IMX95_CFG_LINK_MII_PROT, val);
+
+	return 0;
+}
+
+static bool netc_ierb_is_locked(struct netc_blk_ctrl *priv)
+{
+	return !!(netc_reg_read(priv->prb, PRB_NETCRR) & NETCRR_LOCK);
+}
+
+static int netc_lock_ierb(struct netc_blk_ctrl *priv)
+{
+	u32 val;
+
+	netc_reg_write(priv->prb, PRB_NETCRR, NETCRR_LOCK);
+
+	return read_poll_timeout(netc_reg_read, val, !(val & NETCSR_STATE),
+				 100, 2000, false, priv->prb, PRB_NETCSR);
+}
+
+static int netc_unlock_ierb_with_warm_reset(struct netc_blk_ctrl *priv)
+{
+	u32 val;
+
+	netc_reg_write(priv->prb, PRB_NETCRR, 0);
+
+	return read_poll_timeout(netc_reg_read, val, !(val & NETCRR_LOCK),
+				 1000, 100000, true, priv->prb, PRB_NETCRR);
+}
+
+static int imx95_ierb_init(struct platform_device *pdev)
+{
+	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
+
+	/* EMDIO : No MSI-X intterupt */
+	netc_reg_write(priv->ierb, IERB_EMDIOFAUXR, 0);
+	/* ENETC0 PF */
+	netc_reg_write(priv->ierb, IERB_EFAUXR(0), 0);
+	/* ENETC0 VF0 */
+	netc_reg_write(priv->ierb, IERB_VFAUXR(0), 1);
+	/* ENETC0 VF1 */
+	netc_reg_write(priv->ierb, IERB_VFAUXR(1), 2);
+	/* ENETC1 PF */
+	netc_reg_write(priv->ierb, IERB_EFAUXR(1), 3);
+	/* ENETC1 VF0 */
+	netc_reg_write(priv->ierb, IERB_VFAUXR(2), 5);
+	/* ENETC1 VF1 */
+	netc_reg_write(priv->ierb, IERB_VFAUXR(3), 6);
+	/* ENETC2 PF */
+	netc_reg_write(priv->ierb, IERB_EFAUXR(2), 4);
+	/* ENETC2 VF0 */
+	netc_reg_write(priv->ierb, IERB_VFAUXR(4), 5);
+	/* ENETC2 VF1 */
+	netc_reg_write(priv->ierb, IERB_VFAUXR(5), 6);
+	/* NETC TIMER */
+	netc_reg_write(priv->ierb, IERB_T0FAUXR, 7);
+
+	return 0;
+}
+
+static int netc_ierb_init(struct platform_device *pdev)
+{
+	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
+	const struct netc_devinfo *devinfo = priv->devinfo;
+	int err;
+
+	if (netc_ierb_is_locked(priv)) {
+		err = netc_unlock_ierb_with_warm_reset(priv);
+		if (err) {
+			dev_err(&pdev->dev, "Unlock IERB failed.\n");
+			return err;
+		}
+	}
+
+	if (devinfo->ierb_init) {
+		err = devinfo->ierb_init(pdev);
+		if (err)
+			return err;
+	}
+
+	err = netc_lock_ierb(priv);
+	if (err) {
+		dev_err(&pdev->dev, "Lock IERB failed.\n");
+		return err;
+	}
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+static int netc_prb_show(struct seq_file *s, void *data)
+{
+	struct netc_blk_ctrl *priv = s->private;
+	u32 val;
+
+	val = netc_reg_read(priv->prb, PRB_NETCRR);
+	seq_printf(s, "[PRB NETCRR] Lock:%d SR:%d\n",
+		   (val & NETCRR_LOCK) ? 1 : 0,
+		   (val & NETCRR_SR) ? 1 : 0);
+
+	val = netc_reg_read(priv->prb, PRB_NETCSR);
+	seq_printf(s, "[PRB NETCSR] State:%d Error:%d\n",
+		   (val & NETCSR_STATE) ? 1 : 0,
+		   (val & NETCSR_ERROR) ? 1 : 0);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(netc_prb);
+
+static void netc_blk_ctrl_create_debugfs(struct netc_blk_ctrl *priv)
+{
+	struct dentry *root;
+
+	root = debugfs_create_dir("netc_blk_ctrl", NULL);
+	if (IS_ERR(root))
+		return;
+
+	priv->debugfs_root = root;
+
+	debugfs_create_file("prb", 0444, root, priv, &netc_prb_fops);
+}
+
+static void netc_blk_ctrl_remove_debugfs(struct netc_blk_ctrl *priv)
+{
+	debugfs_remove_recursive(priv->debugfs_root);
+	priv->debugfs_root = NULL;
+}
+
+#else
+
+static void netc_blk_ctrl_create_debugfs(struct netc_blk_ctrl *priv)
+{
+}
+
+static void netc_blk_ctrl_remove_debugfs(struct netc_blk_ctrl *priv)
+{
+}
+#endif
+
+static int netc_prb_check_error(struct netc_blk_ctrl *priv)
+{
+	u32 val;
+
+	val = netc_reg_read(priv->prb, PRB_NETCSR);
+	if (val & NETCSR_ERROR)
+		return -1;
+
+	return 0;
+}
+
+static const struct netc_devinfo imx95_devinfo = {
+	.flags = NETC_HAS_NETCMIX,
+	.netcmix_init = imx95_netcmix_init,
+	.ierb_init = imx95_ierb_init,
+};
+
+static const struct of_device_id netc_blk_ctrl_match[] = {
+	{ .compatible = "nxp,imx95-netc-blk-ctrl", .data = &imx95_devinfo },
+	{},
+};
+MODULE_DEVICE_TABLE(of, netc_blk_ctrl_match);
+
+static int netc_blk_ctrl_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	const struct netc_devinfo *devinfo;
+	struct device *dev = &pdev->dev;
+	const struct of_device_id *id;
+	struct netc_blk_ctrl *priv;
+	void __iomem *regs;
+	int err;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->pdev = pdev;
+	priv->ipg_clk = devm_clk_get_optional(dev, "ipg_clk");
+	if (IS_ERR(priv->ipg_clk)) {
+		err = PTR_ERR(priv->ipg_clk);
+		dev_err_probe(dev, err, "Get ipg_clk failed\n");
+		return err;
+	}
+
+	err = clk_prepare_enable(priv->ipg_clk);
+	if (err) {
+		dev_err_probe(dev, err, "Enable ipg_clk failed\n");
+		goto disable_ipg_clk;
+	}
+
+	id = of_match_device(netc_blk_ctrl_match, dev);
+	if (!id) {
+		err = -EINVAL;
+		dev_err_probe(dev, err, "Cannot match device\n");
+		goto disable_ipg_clk;
+	}
+
+	devinfo = (struct netc_devinfo *)id->data;
+	if (!devinfo) {
+		err = -EINVAL;
+		dev_err_probe(dev, err, "No device information\n");
+		goto disable_ipg_clk;
+	}
+	priv->devinfo = devinfo;
+
+	regs = devm_platform_ioremap_resource_byname(pdev, "ierb");
+	if (IS_ERR(regs)) {
+		err = PTR_ERR(regs);
+		dev_err_probe(dev, err, "Missing IERB resource\n");
+		goto disable_ipg_clk;
+	}
+	priv->ierb = regs;
+
+	regs = devm_platform_ioremap_resource_byname(pdev, "prb");
+	if (IS_ERR(regs)) {
+		err = PTR_ERR(regs);
+		dev_err_probe(dev, err, "Missing PRB resource\n");
+		goto disable_ipg_clk;
+	}
+	priv->prb = regs;
+
+	if (devinfo->flags & NETC_HAS_NETCMIX) {
+		regs = devm_platform_ioremap_resource_byname(pdev, "netcmix");
+		if (IS_ERR(regs)) {
+			err = PTR_ERR(regs);
+			dev_err_probe(dev, err, "Missing NETCMIX resource\n");
+			goto disable_ipg_clk;
+		}
+		priv->netcmix = regs;
+	}
+
+	platform_set_drvdata(pdev, priv);
+
+	if (devinfo->netcmix_init) {
+		err = devinfo->netcmix_init(pdev);
+		if (err) {
+			dev_err_probe(dev, err, "Initializing NETCMIX failed\n");
+			goto disable_ipg_clk;
+		}
+	}
+
+	err = netc_ierb_init(pdev);
+	if (err) {
+		dev_err_probe(dev, err, "Initializing IERB failed\n");
+		goto disable_ipg_clk;
+	}
+
+	if (netc_prb_check_error(priv) < 0)
+		dev_warn(dev, "The current IERB configuration is invalid\n");
+
+	netc_blk_ctrl_create_debugfs(priv);
+
+	err = of_platform_populate(node, NULL, NULL, dev);
+	if (err) {
+		dev_err_probe(dev, err, "of_platform_populate failed\n");
+		goto remove_debugfs;
+	}
+
+	return 0;
+
+remove_debugfs:
+	netc_blk_ctrl_remove_debugfs(priv);
+disable_ipg_clk:
+	clk_disable_unprepare(priv->ipg_clk);
+
+	return err;
+}
+
+static void netc_blk_ctrl_remove(struct platform_device *pdev)
+{
+	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
+
+	of_platform_depopulate(&pdev->dev);
+	netc_blk_ctrl_remove_debugfs(priv);
+	clk_disable_unprepare(priv->ipg_clk);
+}
+
+static struct platform_driver netc_blk_ctrl_driver = {
+	.driver = {
+		.name = "nxp-netc-blk-ctrl",
+		.of_match_table = netc_blk_ctrl_match,
+	},
+	.probe = netc_blk_ctrl_probe,
+	.remove = netc_blk_ctrl_remove,
+};
+
+module_platform_driver(netc_blk_ctrl_driver);
+
+MODULE_DESCRIPTION("NXP NETC Blocks Control Driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_global.h
new file mode 100644
index 000000000000..f26b1b6f8813
--- /dev/null
+++ b/include/linux/fsl/netc_global.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/* Copyright 2024 NXP
+ */
+#ifndef __NETC_GLOBAL_H
+#define __NETC_GLOBAL_H
+
+#include <linux/io.h>
+
+static inline u32 netc_read(void __iomem *reg)
+{
+	return ioread32(reg);
+}
+
+#ifdef ioread64
+static inline u64 netc_read64(void __iomem *reg)
+{
+	return ioread64(reg);
+}
+#else
+static inline u64 netc_read64(void __iomem *reg)
+{
+	u32 low, high;
+	u64 val;
+
+	low = ioread32(reg);
+	high = ioread32(reg + 4);
+
+	val = (u64)high << 32 | low;
+
+	return val;
+}
+#endif
+
+static inline void netc_write(void __iomem *reg, u32 val)
+{
+	iowrite32(val, reg);
+}
+
+#endif
-- 
2.34.1


