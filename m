Return-Path: <linux-pci+bounces-14537-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D43DC99EC09
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 15:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555C91F273BB
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 13:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47951E379D;
	Tue, 15 Oct 2024 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A8SuP6l5"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EE41C07FF;
	Tue, 15 Oct 2024 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998019; cv=fail; b=dX5ykfVAAjrhWDaupOrqQYQsih5Dg0gb8Wy/YkBnGni3nz/ILFq3JSAbBAwhlzkCocZGMjHw0t9H8Cs4j/rNyH4nylyUYf44IQiH74niI5WAa8av/gvjFEBzmhr7LXFY7VXFLd+FE1J9Im0q1sZ64g0AeNHPJr7moh89q5Kw4Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998019; c=relaxed/simple;
	bh=xNuR7brCRFLc/p73luP0tIHoGPuxfb4+T9O4p9iVFAU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SNMZ5gXnKtcRdy0Cf4NcP6IEi3HOxNT241plreRmJ/6nGvjMO5faGH8A40l9NG0PVXK+vU7Yg6mn7h+2ilVVr2QfgI3FabeanhImttP+M1P7LBnaeGTYNU/UPt7WWLQ3L2p1kH2LMq43yh6FVr+JBOp6gtBmdnWUNt2jgOsKGBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A8SuP6l5; arc=fail smtp.client-ip=40.107.20.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdhMVPPfI2RHU9r2qupK8jA3W4zPxju/FESQCv6t4E9E+gUGSRpXZrpiE28KGSEe3AChSOMn9cQWtBSXG4OxMeBNOgzpTd+aTFTZCEHqzDwGbdftEG0R1nxp8sdYq37pg6HqM5fzpF6rWWT5zwMARrds1/h6pib5cEt/IqRo71ZezXthZa68H/AuCvBZcU7+uLrBah7a4H99eNj25NT6PD9+vbUgSxzpiNMKuNz1/nkIy4Ve+dv2bmDfTdZLZuUV6gjEsaI1AkjmZYXtuY1tnO1IXQ5i/UZSh+wVt9UetcHw3k3FSIK2I/mYwl7xDLb9dQAlQjPS+EAgHmb2kcfDdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D87dY1jQu7dekKDZc0SO9JQX6BWM88bkIfMual7bpx8=;
 b=XqzYt/NWQ29mcpnltg+1HxGKOMpmmJFX758znrmBUAShMKufY9lNY3naz7lcoLITbyzyuxnb9VeWPoBnV8Dxs84OJRdqlkoz12njNDYkUAo5+3EmsoZiyY0Ugj8MuIdlWAY1lmDbMupD2xj8nNmG5cvVTxJ7izu6KTFGumguTgkQPINxuVFgZFFZ51qEDEzDQRMZ0gngCSfpjyV4Cs4+dqZfzq9UkPGui1U9VOjDDW3f7IOZJSlGGGC8X07gMkJgpURlI+SrC0f5bpEqxEPZQ39dHf1yvWyoid1Z7hZ704i/A/eGCQPoclRjsGr0WJFwC0drVHtBbUQWqRHNs06xbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D87dY1jQu7dekKDZc0SO9JQX6BWM88bkIfMual7bpx8=;
 b=A8SuP6l5EYbRiJiaWclZgkdti80zhAmIx1O7M1GLqHu07jwPQ/nVpUfBbelhHLmqjL13o4BmGNo/xdzY7ETQnBZohoxEmq2hsF1BbJlMFsBL/4AdbM5YRkB7V1w6TR+w9ymf6/W2xX6+DQvtUPkLZ9kgT8+4SbNOiyBlpMafXoSYuTlUUwmSvRnsblt2riCjVkAPaJVR83qaUSxlQho8/AOGyNOmPkzqFJRGQQhRO+pgglrUvvjtgUAVg+h9Wv0eq0xGwrLiHgTv6ABrR7isB2U+12fes5or/pEyqJjKVzPidoYKb3e5hHUSyOnRjMtnptJnVP1dBmJs94oFyLJIjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB11041.eurprd04.prod.outlook.com (2603:10a6:150:218::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 13:13:32 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Tue, 15 Oct 2024
 13:13:32 +0000
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
Subject: [PATCH v2 net-next 00/13] add basic support for i.MX95 NETC
Date: Tue, 15 Oct 2024 20:58:28 +0800
Message-Id: <20241015125841.1075560-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: e57e48ce-80d1-4467-9713-08dced1b2b2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wmg83wuy78lFYP1BW/SQTAqpJwcaHrldMW33ixgveLTIGlpaHQzV8WFrbMlx?=
 =?us-ascii?Q?Of7wYNfkM8e23NeZzx3ylyZLh+58PIWT3eylJhSkSJrDS2XPLhq46a1c2dcJ?=
 =?us-ascii?Q?jOf9hhIJR1fslpRsH+OZCiBUKTQv+qXvmCdTF4fhzEbOQ9HnmGcOrD7fAmzL?=
 =?us-ascii?Q?/Rg/CO/RuG3IJ1/qtfmYJKSJLgEnOcku4qAkPDXRT1a1PNnZc2nDsIw0oLBl?=
 =?us-ascii?Q?biXkIKmiy4HB2PPspebhmZyVG1dJ02ofLKg4Hvw6cUKR+Se6fZAR7W1jnkBg?=
 =?us-ascii?Q?OkatpciRvMmlLkN6r04E4UOB9/UenYf2k8qVmWNTEiYmnv590l7hassVM9wG?=
 =?us-ascii?Q?0zjWMEgJSjiZ1F/lVI/349Ul6/aM66y1vWwQUQ28EPlIM2PGOiEsUNd5Gula?=
 =?us-ascii?Q?sI3V9/PjCH00rK9icFq/9nGH/hHWmrVSk6WFZXOkxRi6xnfrOdKkd5EyyoIN?=
 =?us-ascii?Q?BBkGZY6vbIw5/oLgdwHXdFcDrNLoyhlNURojgN51STc4P9mLGq/dsP49qQPM?=
 =?us-ascii?Q?iwAZRRqko4CGhjKFCiejiVjvc4c7Zfp++tfcz4LNEs64IszNW/uyzRMQtIcl?=
 =?us-ascii?Q?Bk0wLPR1dJf1lagR8kXfP3hphLJtcR5PZ+WR4Xm8GmapqIZ8Cimz3jZQ7rgV?=
 =?us-ascii?Q?bD842hz245uLHB9iuxRRceV8ixvyC2w6PLSiOZ4Co4iHwHCdkmZECi5ujT7l?=
 =?us-ascii?Q?2yaIPuQhutG7tGUqeRF9bMWtc0r4mkD+8cTaPyCQFlkjv2UdD18LXmMFeLWP?=
 =?us-ascii?Q?gfZxpsl56n638+q/DcZPfB+kM55aw+g6WOdEboy1+5T1+fkBD1WkSwoOlFMa?=
 =?us-ascii?Q?c24PbL3X68kjusc52LIRLPDaCelZuYSvNDQH0TXJtZVSD+H98V3+nNIGAjhA?=
 =?us-ascii?Q?PCLLDcjg3+tXhg/Y48hEJKLgn8MWwHAYQV/KYZ5SpMjGU9yLhLqgWNITBqTA?=
 =?us-ascii?Q?WZnjNr9rRO4dRcOcBzZazuaLwQ4heDRQfkEA/zdQORo26wt7c9qEXAe+MvJe?=
 =?us-ascii?Q?LQGhnbwR5W6Zhf0jJNvCj6wdpFCmC0Fw4v4ewmESK6KI1mpVmZtp8HmB1mcX?=
 =?us-ascii?Q?FRR00MUBnPjs28BExe7bFFUrL80OsMTSOCWbEiDfLzbPo8AyT4VDqdlZ7Z7N?=
 =?us-ascii?Q?m0XzpkdaZO5HIwrO9cyyIIaiUT1TzQDpFS1oi5sEC7dyxfUCiBj2QPS83pki?=
 =?us-ascii?Q?W6ODpu9PqMkzSv2azA6owVyoPhnGrYy7FbPcp8O7A6fAy7gKl2d1fK2PkwNc?=
 =?us-ascii?Q?9b/Ni78xAyXEJjAdpw6SA61rGPkJyGaV8RFhEbIEEgZfNhicNx3kz5KiQPFh?=
 =?us-ascii?Q?HMjimI5BmVd5rzctDzWk4WTrQfL5eoag3bJPnLDZ3EG9jfKu5AZEGDvJK0ge?=
 =?us-ascii?Q?7fobodc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oBo0zBvSpDdmA/EJJBJvYnBZhosqhRg3OXg3Vs8nAJfihJjEzsF4lHc7nlh1?=
 =?us-ascii?Q?vgxt7QCIhtT1glW2gAlLrpON7sMq0WRQo8ZCJJW2q0zS6oQWWVVj5sLrHkvs?=
 =?us-ascii?Q?mNvTNQ53XiDQVJYjDzKT+6EAZlbiQP2BYo0JjlEYQSddnZlxWMB48Rx+uJOr?=
 =?us-ascii?Q?13g82rHogE9lcIUOwsH/lCsoluT73TFwCMDzA7bJgDm38Gj095VexJFr9SMh?=
 =?us-ascii?Q?NtHU0h7gL/4uutl+akgXF4tfnUQwHze/gwOb5ww0+euZ7C59EhTZIwJ/7N/R?=
 =?us-ascii?Q?2VBkjB9yTnyf7ONMro9zJ0cGkxSpiZeJ4SIsd84Im5Fijf3RP4jOVjhWzpwT?=
 =?us-ascii?Q?33hZELxi7CyU9Qu9vLUfgMKRNB4Yg3NLUsBXk+oVBCZ1oTTC+bTiZAbuhsbX?=
 =?us-ascii?Q?e3zLtFrI40Gg11eJItEUxUnADRld91ognB7Bpsmn71TugJQQ439x5CqYnbMk?=
 =?us-ascii?Q?Bi30+1K1k/gpY9l6OT7hSRW3mMa01poZxLdeCOncLmTjtnJaCDppnWp9cb2M?=
 =?us-ascii?Q?mOUZxDBTvqc+9iqsmcrMJRMWR73GJQn2efarN1bz/lmTKbMK19Tfyx1R3kJH?=
 =?us-ascii?Q?S0GRF2EOefNay1DOdL4ZfqUFlj02jxVcvdLWoy442z/3mfNjLv0Oo3PMoY3Y?=
 =?us-ascii?Q?Fl3eE74Qyj4MMirr2RJrLyf0EU4OvMqqd/zbHgKu2NOpmmFKKvoSKVsC3Iuc?=
 =?us-ascii?Q?FrLx16cjxVZB5FuTc6WLvJlnm1XNOePDaHzsq2NlI/Ki/DiGq8uWzkuZ8EoU?=
 =?us-ascii?Q?TuhexBeaTQspSvUlgLoP8TaLyO2BmU1zA2OH19pmbdM2NKgUeiKPl6LaVCSG?=
 =?us-ascii?Q?eQ+3XSX0qpSUdWTf+CabBog9D9huDoYB0xvZ8Z4MhwqabadYOmorKzos+BgS?=
 =?us-ascii?Q?YQxBui8w2v31OARyWZv7XVwaKRrbJliczfZEpnUePB8nLYrUVXlAs4H7ADto?=
 =?us-ascii?Q?a7ew/wq34D5KXiHcEva1oQGLWQCev1Amh4e93i2DkomdLCmwLnDGJsconlwL?=
 =?us-ascii?Q?asR6GkGq7byukYmzosxqF5xPxdRX/+ccJG6KnhWueuRwM0rqX7+gzfghpfdi?=
 =?us-ascii?Q?t1SO60ReFia/oO48XhWWYKPCgWdTBIkiq9QM8NYBPUlO+5Z9VoD68q3H4pCG?=
 =?us-ascii?Q?plC9+Or9CWLKzqffRgOBm787Ur2gLhDPfUJ6I+2/eU0PBVXY42XascNe8gIs?=
 =?us-ascii?Q?RgUbxw5q5uuQMJUPSVy1/Wjf41WZuz6OjFak+w8ymqP10V7HgoS7lx92Vgt8?=
 =?us-ascii?Q?HKIeEs0BjGWDWNOpC+gPTFdP8Q506A7IFmC7LiNNpF6I0PNgqPSoI5aWolec?=
 =?us-ascii?Q?gdDGz7kin+BSyDWVm+kR7idvYUvkg0bFTrrO7h+4eTNywn2SJm9bALIucMP+?=
 =?us-ascii?Q?R2Bgu7dVMiK5MHjdMQ6liK8JtJbU7HeVkQZ/8r+KNrMikuALmHnwtr5Bt07u?=
 =?us-ascii?Q?TG2CCSKd3B3cXLWyiLcwvyGN/fbSrlrPpNSdphHI7790FyzAKRI4fQCVsoZJ?=
 =?us-ascii?Q?PPx6N4KPznkLkm3+X7mMj73k1XpbT/4vlbsFCryWKPQ9+RGdb/d3qH38xlah?=
 =?us-ascii?Q?rQAUQftf/9FxRwRNaY79PuUq6tq6BarATCkindPy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e57e48ce-80d1-4467-9713-08dced1b2b2f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 13:13:32.6969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fcdXVr2yHJY0+i4L8qKK6SFwc+gxApGopesN6QXEZYzN/bIN/XZUrRX3JZ1kTNI0rdQC83J2CFplFm+2GAQyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11041

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
---

Clark Wang (2):
  net: enetc: extract enetc_int_vector_init/destroy() from
    enetc_alloc_msix()
  net: enetc: optimize the allocation of tx_bdr

Vladimir Oltean (1):
  net: enetc: only enable ERR050089 workaround on LS1028A

Wei Fang (10):
  dt-bindings: net: add compatible string for i.MX95 EMDIO
  dt-bindings: net: add i.MX95 ENETC support
  dt-bindings: net: add bindings for NETC blocks control
  net: enetc: add initial netc-blk-ctrl driver support
  net: enetc: move some common interfaces to enetc_pf_common.c
  net: enetc: build enetc_pf_common.c as a separate module
  PCI: Add NXP NETC vendor ID and device IDs
  net: enetc: add i.MX95 EMDIO support
  net: enetc: add preliminary support for i.MX95 ENETC PF
  MAINTAINERS: update ENETC driver files and maintainers

 .../bindings/net/fsl,enetc-mdio.yaml          |  11 +-
 .../devicetree/bindings/net/fsl,enetc.yaml    |  19 +-
 .../bindings/net/nxp,netc-blk-ctrl.yaml       | 107 +++
 MAINTAINERS                                   |   7 +
 drivers/net/ethernet/freescale/enetc/Kconfig  |  40 +
 drivers/net/ethernet/freescale/enetc/Makefile |   9 +
 drivers/net/ethernet/freescale/enetc/enetc.c  | 224 +++---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  19 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  | 153 ++++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 757 ++++++++++++++++++
 .../ethernet/freescale/enetc/enetc_ethtool.c  |  68 +-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  46 +-
 .../ethernet/freescale/enetc/enetc_pci_mdio.c |  21 +
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 303 +------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  37 +
 .../freescale/enetc/enetc_pf_common.c         | 336 ++++++++
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 472 +++++++++++
 include/linux/fsl/netc_global.h               |  39 +
 include/linux/pci_ids.h                       |   7 +
 19 files changed, 2265 insertions(+), 410 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_hw.h
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_pf.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
 create mode 100644 include/linux/fsl/netc_global.h

-- 
2.34.1


