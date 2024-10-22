Return-Path: <linux-pci+bounces-14976-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C979A9947
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 08:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B9E11C23266
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 06:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24277149C7B;
	Tue, 22 Oct 2024 06:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gSK5Yo9o"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2813149C51;
	Tue, 22 Oct 2024 06:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729577276; cv=fail; b=eeIMnaMywu/ha4oth3uP6FY8epFFDhiEWgSfYcWKvr9gfLlmN4gKRmXAQHCn6edBOKHmw3k6KdVBtGYmfl98ZrNHyWHMCf7BJwRPAGL/GCHwEBL9HYxhVgYFMqGIQk/i4FNlTwRVZxqlySu7Sn24vTpF3oidOR0V7eip5S/pnmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729577276; c=relaxed/simple;
	bh=EMe0qxhzkQNzdrM1UvXF7Xb1oFXJXS0WTTygW+049Qo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rTCyEZXO6zNNf/8tNAGJU6bKpRfC9+CTMjdazejKeehnD4oS7lx1JZ67JA9/tC+DLtCSIydeXS7GvnqyFuMlwGAnBuG/KaAM7gQqxiz59NmWUpYhEi93SWeIhllF3XXtcR7/69wnZxaHDXuVgGDfJ/1An/IM577gGhpGtLE1W6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gSK5Yo9o; arc=fail smtp.client-ip=40.107.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flFEDzZxSVDa/QJJN7QbzDV5ooziVpWBrEqsZvxczNNVIDE35mm/DDEjW7xbmkGKwOxR9e6SrD/Y69bUP6tLLJUSVSXWQWAauvdn+0wGjpeycDK0nQCILIU2ut9xcnIfQn+6K9b0h+qCk7/vEb5z4LdjxkmD4J7O062a0BTPU1JFqdVEOwyadxZ/WLBq2jR3nOBzxK+4R+z7OGnQClcxtSUI+PO7xdONC6gnAryMcdQE8HEXf2mlC7ABy2j9liXSyhDhMtpEuUcYzAFC8r9MXHnROZqGk+PQTxb9FHtwbZq/AsSZ7VB/yjwKexDoqPK47awYOXJmANu37C5roY9m9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0njtcfeOs39sheiSPfv86/NXkATMpdr//Cgps91jrI=;
 b=TteMQbc2/Do+0+UMNbcOlNDJZtikZIN/2hSbmhB2tALzXRVmfFI+s/IH2tP706uR+XN7J7wMySjeVI9qIh0NRF7RWH7/29L4OeWHPBdfyPO/78hb0jeH5YqXxPz0kEoa1NEXTPC7oQFPKW0s+SREu0lQflMDRLpa85Z9K4AE8DN9/TIrpixn/JGCgnpu/4olA37C4ow7exfAOGXOEomeoj0V1ZXlbqHNdL14Dy/k4lu3Xzjlh74kzsr56bBJ7ExqrIN/crVR2awHfIEdTpGDaW4th/zUc6q/j9ML0JOeJSfgFqedHkMsKutCJVwTwveYc6CUUZfOIJo5PVZYhW8+0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0njtcfeOs39sheiSPfv86/NXkATMpdr//Cgps91jrI=;
 b=gSK5Yo9ozF7Ggcx1FGNCkahpmrwwo3XELsmpWBF3i6L+6TkYQu7iUw9JswA/k5KsKHIUS/x+f1FvWsWniEEO+GuhzwB3htHb600Bsecbin7CRRRUb5UYwAjiBZqubBqtXkIDO2boxoFfi65189UqQec8XRK8onEgp5eqXKbgcT9gjjEr7FKq+iR1kwlviSmuLH6WTLjmGDRfxZfr+bw0fa1hBvKNyOVwRjJjWrj1ljNmXXrhvtT2qDdB15oRRuHqK8uePNq4uD8EtohjJQI836CqoDIDpcdAUXF7MuVYwlOzYVate5vye5zSNlSoo0Oa7y/3oUtsi87zAGbfHN9FZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10178.eurprd04.prod.outlook.com (2603:10a6:102:463::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 06:07:50 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 06:07:50 +0000
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
Subject: [PATCH v4 net-next 04/13] net: enetc: add initial netc-blk-ctrl driver support
Date: Tue, 22 Oct 2024 13:52:14 +0800
Message-Id: <20241022055223.382277-5-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB10178:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb4edca-69e0-4943-2b04-08dcf25fdbe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y65oLl3ZnJyLekszxeXrvMwQDDvTNd9BfVCadXm5b8uKaqcTK38HwhpTNoV1?=
 =?us-ascii?Q?E/lVJpYXMp5902tCKNucHnoXcxmqg8ypGAQKDsbf9TSv/9kEt6Ky3SLJbXHA?=
 =?us-ascii?Q?SAxgIRxlpIThG3boXGtUXvSOvsbdsg3CdWmjEx/T7rMl1n18chdJ17wYJO+G?=
 =?us-ascii?Q?OWFbifz1H1xxHqALaI0Spu20orXbF3zJUyrt2Dysq/P9Pl/qq3HKL9GAM319?=
 =?us-ascii?Q?eyUWc26zxPHP6Jk8l110s8PuOWAs5RaTM3zHAJ87hI9wVrcLZdj4zjvyUA/v?=
 =?us-ascii?Q?Re22/vK7ytySq8QRXfd2RPnreWHaUhrBDIpsI2diGYC/I8lgawZkFvVKnLs2?=
 =?us-ascii?Q?StjvmmkJsdSMPGjPhIkn2Ecym6DeqeBsdiDchbIWWtOrnEGyP4nZi8mbem6W?=
 =?us-ascii?Q?OgkH/F78UWjOP8VdDvb5FRPexUiGngd/J09zfQCaKiFszADs0ACA4+rR8L0J?=
 =?us-ascii?Q?fu0+zPZCGUQhDZM9LArLXDi722vWmNll02/R6J4kh3VYPT3zhRDTAZYNCGQ/?=
 =?us-ascii?Q?Rkg/rpkFexgrLQosenwjrO+Pyv8Kjw9AQKjHJugpQrouga+ekToMzbh7DKx7?=
 =?us-ascii?Q?JxHblTNuBq0O+Op+O3m9rp9dOZBfBLLQkHSQJ9A9HSscBjqDOHadLyNegLM3?=
 =?us-ascii?Q?Vmm7LcvMsqhGgfExpcJwWoOelFzxtCKdHKeqKWo+cPnP3+xVFfWlQY9PPxcP?=
 =?us-ascii?Q?UhokNySoTaLRk5N+Z5jGDYk4bBGNOaN2V738u29+N2JbiSl8JExGKzGixM4b?=
 =?us-ascii?Q?lE2vLRqrM38snZRk0zZLleCG5gYv0S3V8nVPXr49jTHBQqQMtdbt8RSi7vkS?=
 =?us-ascii?Q?nawkTzYDu9BjTLHEz7KGkUdKpd2mCpSbzendECxobkuB2qRkNL168NQb16r7?=
 =?us-ascii?Q?Ku71yor8f8IcBeehYd9P4C3EiOhRt7k+30PG61q/domh846iyLAarD1HMPp6?=
 =?us-ascii?Q?qbtV7vC4uzZNFsx0ogOJff7nNrK7vk2ktnaaoB1ernBzendlUvCPYEmaGM4O?=
 =?us-ascii?Q?DUGSZStUT42Odw37q5HN0+ARBCQdcPIZH/U3/DsfEMjBlIS691HhvRy86KN4?=
 =?us-ascii?Q?ZZ8NXTP3KuOOVSSY9HoCvTdriKLXZhRSGFce2CZQzp4vRmTOuzjukkaTr/yL?=
 =?us-ascii?Q?jj41eNpLIfX/ACUPhaNDWjhPOLa1HaPwhbGKG9fBK31kfhMj4KegtLRhaIPs?=
 =?us-ascii?Q?FY7p7kGHtNOrIOyiAk1nRewl+Bv2OwJAl4sLnnDdbq8GBfGXJmkQ5l8AoqSq?=
 =?us-ascii?Q?IptwzNsRfZZUUKPNt7Ysp8nmLY0oQe/fDYMQBhg2QbaB3uWW4tgD1RzvWzIV?=
 =?us-ascii?Q?TYWnJQOzKIisTthS8yHpmUgz8JAX27FNyGBtx7JAKLEIIqp5g5lANg5eKh2k?=
 =?us-ascii?Q?NaWmwQaKXwBjtF0O68C7ueSb5zjQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RF14f2H4jliovwA6CyeH5K6ZYoDs06uk3H/2ORGQ9oxH/LtrbMEkWq/jtX1S?=
 =?us-ascii?Q?AfClObsaR8j0DMU54pVSnVuA7vgva9EryPbHEsowEYUCNr3MOHkOhEJkg7DN?=
 =?us-ascii?Q?aKXCUuX8DSFaSPfNvxPkLY6PWMb6p9hB87ATCbRUzalOEtYkenUTnn7zaIzF?=
 =?us-ascii?Q?1v6gntOj2YsdukEiod3KeYlfgk5A1E0YaHeKIq6bYRx2PuCBqDf3uzA1wk+g?=
 =?us-ascii?Q?pdKE4sJovKa3ZLmhJZg15LX2UxXZSpMlN77QllEITtBTUEAXlL0IKrSlJYBH?=
 =?us-ascii?Q?1Hx6J4r9r9LcDfqkButhD4Zm7vIl51/Bq/P2gKWf8c7glaJIim2hsO2b9D45?=
 =?us-ascii?Q?uoZgovdy7uRWQMh7tUOELjdNspDp+n+1Kj5oSIjvnFd56aW+yHqT4lE4EfV4?=
 =?us-ascii?Q?Er8taciQJ8uxDPqJk5+C/5CrwdwtKuliRXr5vB5VM+R6ZnlqUsBjQFIvfRmQ?=
 =?us-ascii?Q?H8nKD1zud2A2uGchejbiOCXK6BLDxBUmu1z+poZ0qjir86pRIdt5ecBu4jn4?=
 =?us-ascii?Q?AvQGPKvTI5IEQoRkJFpwbOJ9UC61UJ1RraWZOksjAHrmO1fP1+iutxBenDRH?=
 =?us-ascii?Q?RJBRMyPPC2YhV//hwJySguayQFDz708YmnukpFwD//lNql1dQo2cPe1AVF6B?=
 =?us-ascii?Q?Et2Kb0mo2eEm4h+wbf4mxYL5EoVyoHLpBOkEerEFFbTbWmY/Tlif233Wjkhr?=
 =?us-ascii?Q?+FaE6TVLahN+M/yLIBCvxUwj7323fLqyXRl0XdAm0IE/tjbOoL/UNKGxY340?=
 =?us-ascii?Q?TZlqZ9iljHMny46o2UMTt0WuTVVEyD03KXtIMzOlUA1AAS8v+3Iq3aVNZ9QN?=
 =?us-ascii?Q?FlIsdonAPT0NDgG2lJkVkfn8Rj5AzjBzF2A+EPqmWorBJqbt7hyxW50T1Eqf?=
 =?us-ascii?Q?0WK0BAyTM0rjY0JarEfwDTZSraspSO34gUvQa+jtlfOrBAu+zZbR8u2JRV8W?=
 =?us-ascii?Q?KtHGQm8x2b1hrCGkngefcoDnPxQEnkmBexc+zJ0osUb6tAuOW4NEs/y68Foc?=
 =?us-ascii?Q?sdtGWQCNGBrDaOvPR6ivLCQl1HDaCBbQvlk7g3hbVqarBcDpqjlH1cm2A14P?=
 =?us-ascii?Q?dieRA/EEKd5OoWTyaUvlOeQJgutScz4ojE+EgzMnOLKOCjnyfl6e0srfbRjf?=
 =?us-ascii?Q?l4rwee9DJKU/RqsZsUnwjtpWEwkgH6h9NMO3kN9o3HxfWg5m3O7N5E1+hYFj?=
 =?us-ascii?Q?QWEgTFKkNTvRNiBY5rQKhKbkfLZtDjZDscomcZivLVKvrCIhE7r6EPsvE5u5?=
 =?us-ascii?Q?m+vLBRlYuJFSYQzE9/6rBXOTKHucwNEIYAAGUF15PfZudzN4bU87uIdFtken?=
 =?us-ascii?Q?UXSx0Gt8hd0O61qq88DRboSSuaVlnRoyyfW58Q6+/MbuLGmCseY1+Oi7qqev?=
 =?us-ascii?Q?5gGwuWt6Wok/LkyQed3DauEBZb9M857/u3h1EbBiJMlnWPO9GwIVnr0Dk354?=
 =?us-ascii?Q?zf1IiHQHlzZ+ZwKs3ABMwOmID6OeINmsyjcASH2817NgjU96hKj9ictA7bnd?=
 =?us-ascii?Q?U2FF9ilwMfi48FMsaQMx0/E5BVnKqpoztm/5m5ErdwdvNF6tVqOhaSszrdlx?=
 =?us-ascii?Q?PaLiGkaK7warYYi6fqLEc2DyxHgSetPfELpcNZRx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb4edca-69e0-4943-2b04-08dcf25fdbe6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 06:07:50.8577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRc9Rea/YtFy06EUGQ7opJclq1RrlLV4oa2fdPM062OGYe+P5PW6xRID7EEORp3GFfjkBKdE7A0a5fIzD+gWLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10178

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
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
v2 changes:
1. Add linux/bits.h
2. Remove the useless check at the beginning of netc_blk_ctrl_probe().
3. Use dev_err_probe() in netc_blk_ctrl_probe().
v3 changes:
1. Change the compatible string to "pci1131,e101".
2. Add devm_clk_get_optional_enabled() instead of devm_clk_get_optional()
3. Directly return dev_err_probe().
4. Remove unused netc_read64().
v4 changes: Refine netc_prb_check_error().
---
 drivers/net/ethernet/freescale/enetc/Kconfig  |  14 +
 drivers/net/ethernet/freescale/enetc/Makefile |   3 +
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 438 ++++++++++++++++++
 include/linux/fsl/netc_global.h               |  19 +
 4 files changed, 474 insertions(+)
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
index b13cbbabb2ea..737c32f83ea5 100644
--- a/drivers/net/ethernet/freescale/enetc/Makefile
+++ b/drivers/net/ethernet/freescale/enetc/Makefile
@@ -19,3 +19,6 @@ fsl-enetc-mdio-y := enetc_pci_mdio.o enetc_mdio.o
 
 obj-$(CONFIG_FSL_ENETC_PTP_CLOCK) += fsl-enetc-ptp.o
 fsl-enetc-ptp-y := enetc_ptp.o
+
+obj-$(CONFIG_NXP_NETC_BLK_CTRL) += nxp-netc-blk-ctrl.o
+nxp-netc-blk-ctrl-y := netc_blk_ctrl.o
diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
new file mode 100644
index 000000000000..9bdee15ef013
--- /dev/null
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -0,0 +1,438 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * NXP NETC Blocks Control Driver
+ *
+ * Copyright 2024 NXP
+ */
+
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
+			if (!of_device_is_compatible(gchild, "pci1131,e101"))
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
+	if (netc_reg_read(priv->prb, PRB_NETCSR) & NETCSR_ERROR)
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
+	struct clk *ipg_clk;
+	void __iomem *regs;
+	int err;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->pdev = pdev;
+	ipg_clk = devm_clk_get_optional_enabled(dev, "ipg");
+	if (IS_ERR(ipg_clk))
+		return dev_err_probe(dev, PTR_ERR(ipg_clk),
+				     "Set ipg clock failed\n");
+
+	id = of_match_device(netc_blk_ctrl_match, dev);
+	if (!id)
+		return dev_err_probe(dev, -EINVAL, "Cannot match device\n");
+
+	devinfo = (struct netc_devinfo *)id->data;
+	if (!devinfo)
+		return dev_err_probe(dev, -EINVAL, "No device information\n");
+
+	priv->devinfo = devinfo;
+	regs = devm_platform_ioremap_resource_byname(pdev, "ierb");
+	if (IS_ERR(regs))
+		return dev_err_probe(dev, PTR_ERR(regs),
+				     "Missing IERB resource\n");
+
+	priv->ierb = regs;
+	regs = devm_platform_ioremap_resource_byname(pdev, "prb");
+	if (IS_ERR(regs))
+		return dev_err_probe(dev, PTR_ERR(regs),
+				     "Missing PRB resource\n");
+
+	priv->prb = regs;
+	if (devinfo->flags & NETC_HAS_NETCMIX) {
+		regs = devm_platform_ioremap_resource_byname(pdev, "netcmix");
+		if (IS_ERR(regs))
+			return dev_err_probe(dev, PTR_ERR(regs),
+					     "Missing NETCMIX resource\n");
+		priv->netcmix = regs;
+	}
+
+	platform_set_drvdata(pdev, priv);
+	if (devinfo->netcmix_init) {
+		err = devinfo->netcmix_init(pdev);
+		if (err)
+			return dev_err_probe(dev, err,
+					     "Initializing NETCMIX failed\n");
+	}
+
+	err = netc_ierb_init(pdev);
+	if (err)
+		return dev_err_probe(dev, err, "Initializing IERB failed\n");
+
+	if (netc_prb_check_error(priv) < 0)
+		dev_warn(dev, "The current IERB configuration is invalid\n");
+
+	netc_blk_ctrl_create_debugfs(priv);
+
+	err = of_platform_populate(node, NULL, NULL, dev);
+	if (err) {
+		netc_blk_ctrl_remove_debugfs(priv);
+		return dev_err_probe(dev, err, "of_platform_populate failed\n");
+	}
+
+	return 0;
+}
+
+static void netc_blk_ctrl_remove(struct platform_device *pdev)
+{
+	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
+
+	of_platform_depopulate(&pdev->dev);
+	netc_blk_ctrl_remove_debugfs(priv);
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
index 000000000000..fdecca8c90f0
--- /dev/null
+++ b/include/linux/fsl/netc_global.h
@@ -0,0 +1,19 @@
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
+static inline void netc_write(void __iomem *reg, u32 val)
+{
+	iowrite32(val, reg);
+}
+
+#endif
-- 
2.34.1


