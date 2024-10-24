Return-Path: <linux-pci+bounces-15169-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A829ADD17
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 09:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4825E1F22C36
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 07:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7239D189F55;
	Thu, 24 Oct 2024 07:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a2OAFgCz"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2055.outbound.protection.outlook.com [40.107.22.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D53216EB56;
	Thu, 24 Oct 2024 07:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729753724; cv=fail; b=em3pBdUi8w+kEJB+MgB30bkz0krz0IRgViTUuelwGZHQ6nezgEv+50WoMw0Uyp6gm4VyjrnhCckjKWSOFoe6rRHzlONRUnZTUkhEBxBJK+C/2VOzhIYoCdrgA2w6dCRxAIVGI+jWLxurok6WkJSdLBIku0VODUwNkMoXMmnV22o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729753724; c=relaxed/simple;
	bh=tOUDmFt+GerWKX4fuyuWYxCPKwsvxDf9+CGSX5WwmVU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mCInHoo9LToVdwhzdupqznWN3vgOH1nrsKgw46xeUY2K5SH2CfXV7vttoQoCKe7eror7y8v59zOZj2718edIeR2zjGYH/O/BXJOYode7iG0xTggLzJbKXobMWy6j+9YLIx6Upzp9CE9hU7VKl80DkwuqmYBcrWBMnKyhhuM3RRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a2OAFgCz; arc=fail smtp.client-ip=40.107.22.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWSgC9o75EKnFqXu8D3VmAZ1XYmhmUmDjgp5lQE1I01BiXNrexTgHgRONIuSGNagRH21Vh10mz5n4MGWJ47c4lj2UiRe3xBoVvuuamSY3mvo5W3uKIkBMNMfTcKl2X4UJl4/Qc59hF0YMlTpwM9tR/oxzfW7g1frJLpYBeLoS21fznRP8zLAGMek7DG/15JsrkYAhltWmFWT/vjoUM8v3JYkSRFFoeStln8gKO7qsRJ0w2Dl5+5461dzwywd1nO5UljtEyRRl8BFT7mA0zb2TpH/v38uZGVMMduXtVeYePVhD6lhX4hUYSxA8jO8q8CBx9l7jBHD7D54o0fpidRe6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5u7pgGn74EiUJxXOrO5RMfzOWHGWyc7rjQLJieRI5BQ=;
 b=oBf/dfSPDhUud1+ORJgFKJevOPmMkIVo+HxSajxzS9BFErfVTXDIwY5q9/mnoSZFIgu5SgFsuwAauaysij8SEKqs28n8PIiFwlY0mRxrq2bRdXWq0cZQndc41TrocSa0Ty5eqlZc5SqqAaqtQZ0ws9yVJTN7H0JllLfgVlXRkw6pJwQUQow/Lgx/aYQ6wAtf24H0Z4IEPBQU2hcSvoOeW5FE9wt8I0pxVaF4lzGv5elkAudJwEVSSs7nc7Tom/9gE2qlkM9DKczQExaAdEW5ofOrQoROx84zAIvGWIuKzAfmpjKZN/kr/R6YP4iLbetsEwrql5V+TI5T1KaTZ+p4gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5u7pgGn74EiUJxXOrO5RMfzOWHGWyc7rjQLJieRI5BQ=;
 b=a2OAFgCz8InvXt2TFXIXvpo5pO9u0+nqlHs0CuBG2myzXVt0A/UPU8C4vJ2hze9VDDlNs9tXW1RSKU2YNT7nGhVO9k4AjjKdQRALJQXk5P7WysrqBl2au7MOIY45tOkUbykwZ4wmhE8nSOgvaYtgMFHvX9VCO6aKNLanzGp/O69Qu6/8U/PIUKOdUB3mMcVkFh9cLjarNfJ6FiQtslml0IidyYG4LdxdK6XxWul4fW6VYtZXhwc17WI5BCKgD0BxOKXF0QmzJ325rqlVmQXvcI+mPjDbr7wmQ08p58SzDrJVUkrTMAewXeNDIKiC0EKm9y1HhjSTA4SxZfpIjluL3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB9153.eurprd04.prod.outlook.com (2603:10a6:102:22b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 24 Oct
 2024 07:08:37 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 07:08:37 +0000
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
Subject: [PATCH v5 net-next 00/13] add basic support for i.MX95 NETC
Date: Thu, 24 Oct 2024 14:53:15 +0800
Message-Id: <20241024065328.521518-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 912580b4-2c65-47f8-d5ad-08dcf3faae63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y983ZoOV83xnxIBcTpad26SJUB5/HAYn41Vv9b3nN9L98MBq/pdUmIM8uvbh?=
 =?us-ascii?Q?1xq7nmPVVwwk1xb7VpEKNd3Stkm6g+tr2whCUQqKjmooQbdgit0x/x8vnlBk?=
 =?us-ascii?Q?BPUHq6GD1xgUyoZmwJ+IXkXmOIJJsltLWPd6ZjrtnpCPrzGjefAOAMNQKcjI?=
 =?us-ascii?Q?a0k1xTqrBVEGk5lBdjYiXGO9mNdLXuqFCscCgnlrSbt7fKNav3ZevH5L3cRv?=
 =?us-ascii?Q?6htIQd5mJwIsyXdhfnO8D4kfH26aUFCT8as6rATcmC/5aa3xXKLzSfwsz6xQ?=
 =?us-ascii?Q?3Og9VJ4bH1gLwuVfquqqtyfXZG3oWJ1WTO6C9f7rwvl5nOOVXBRoPyLA0Tm/?=
 =?us-ascii?Q?O579joCJPllwtUb9Ntvrt8tpGLZxbBKiSuqlj+YPU87ueXBSoiH+ppNfdVyr?=
 =?us-ascii?Q?uMXO690CUHuJbNiU4u8XOb8lpugGKZFCjdmZ1VEFs5Z4q95pH0Bmnfd5r8ZN?=
 =?us-ascii?Q?DG7hneUb/7LdnuzQ8kMBrmilkxJQPpTyAaMb9Iuw/TNezSKWv6eRHn5jkKVs?=
 =?us-ascii?Q?oM7HdTgJ+aXKGiYqPa9vuxf1JMg9zYS8vQaAo03fn7qcKIti9XSPX/9EZAyn?=
 =?us-ascii?Q?f4IukZcH70WD2B21Wwr3cXwjXGqdwAp/JfmGxSuMvKeINHwtgGvKj+zRbWhZ?=
 =?us-ascii?Q?OCSv7FW5Lynu55cLEDYx71G64/H7ETsL44XeA8l918MiFCJP7IzklJqdYfEP?=
 =?us-ascii?Q?mgTZXmBhx2jIyag7AnszUe/g5GWI9Dd6yqLugevNtbBlAr8/vOTTFZ/A8w7q?=
 =?us-ascii?Q?KUX64gwXy4wdnMhcAhCMDNYPdLexPuCa8bHoSePh+IyXg9K2YDiGn2LHhXp4?=
 =?us-ascii?Q?fIYSMKun1+CE3hSsfaptmnjGN8msUgqKaG6yoTRpfYL/0lbvHrxkJMVFQF2v?=
 =?us-ascii?Q?fuaUHFfwpQYFIYWbIks0myWuhV4Vyj/gwZEngPTHazZd76jFzYTeJbYe4sQ7?=
 =?us-ascii?Q?Eu6g+aRjko0Xu6ht23k/EzVT08KlSWjlGxZhuFsvA0xekmxV3OP37anaS5gA?=
 =?us-ascii?Q?DaKc40TlE0riijucYbRe0D1TtsTLSCBbskE8krlMLxzfIBUst5/weXKxcIhs?=
 =?us-ascii?Q?y3qwEhJMPlFYQzOBVNfWCaxuLgpVeRUW6aSKjYs9FTG93haIPrPgWrUil5gm?=
 =?us-ascii?Q?RzYhT6xX7phkpLvjRWbG+AJKx9bMo9rtJK4w7WH4K933g6ICc+UrdFoDubSw?=
 =?us-ascii?Q?IjliMDLHwXqtts+f/o7hIRrfNGZ7eMmIdoUY9DG+J4/mpLKrgMg9cNGujH+y?=
 =?us-ascii?Q?nXpLeM2UhfkkL20dWhyVQ6CfXDFn6NKPwIqoY4Zi3K6HAJmhuNojt9rgoOl/?=
 =?us-ascii?Q?uKc+MA3VnyQpB3BjNSgG77MbhFiYtmVFZpRbEzUJi1FK1c89cGbeXd1uouJt?=
 =?us-ascii?Q?fqTAJmTchl0fTfeRbt8XCRXsqDG4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b8lyJgLR7C4qpCNje9K+OnBwlzQEMWy6bHvjQPIlfMD88KMLB91uw8KbOsur?=
 =?us-ascii?Q?6yf6pVU3Sn3Nd/l45e7Sn5YEMzpj/jzpW0IGgEBYhAKWPhIWgtcutyRqTQju?=
 =?us-ascii?Q?IziTWXAJ0UwrGiLmlfZ+Tmgta6/1OZtud0jwLshbo9AfAEv6HNHYYHVnPYpk?=
 =?us-ascii?Q?HHle7jihEyRh4xyG+Xh01sLcrheLbNw/P8h3sQS3JxgodezezSXIxUY9+FxP?=
 =?us-ascii?Q?ZUCKGCmQGCS9LqKj/pGaDKPO7F7JNcoPnS++6569wr+MuvSK1koHVliuRU1o?=
 =?us-ascii?Q?5oq77myEGwRBxOJ1cfgh4zMpRNMQwnSGKR6Grpa5DjRtVzP210hLOHNoojzX?=
 =?us-ascii?Q?Qf84QIq5ZOy7M9b6q8GtnzAFP7HwS13JcI1xCmYWgAfogwoJcB/cOwAACHXI?=
 =?us-ascii?Q?69+H3EUrCu7n1RwXj6SibV4UxTHbNGbICeT+10B8kKFFu4JA63b72F2rcTLf?=
 =?us-ascii?Q?+XOH+N1PrSBB7U9/iG04Crn0ROGm+VUr2z8o+KZyA1L5XVv1JD43k2i5t3RY?=
 =?us-ascii?Q?BzoZai7Gzf8VigkFP3zM+rzxXye3Hck/6HpdjvbBIbz+WJRhpuAJIN9xt5eV?=
 =?us-ascii?Q?tN69VSR2khWiAVgr6yMWl2o/7f8LTEPPqx+Mm6GLbeOg8piFtFQ6U/vSp3rs?=
 =?us-ascii?Q?p27O2JU3ZAKLOUYkRkAkM0ee/ui68UWEqdF7VDqjKvP4JV8WkzxyriqWGEUL?=
 =?us-ascii?Q?gswDm0hitCCqRgWyp9QFFGr9bqedUBL3GaM4jMFvPouTpTX5y6ebyZmzh2L9?=
 =?us-ascii?Q?CIu4rfDvz7naa/CCv+yA58ZHL/z/EFV7jV7NN4zzJ9i1QW1BlBD7z97jHXVJ?=
 =?us-ascii?Q?VdDxjialzEHRcLzyVTX3yv+5M4S9jg5kKJvdiO11nQw4dCAliSF4zuqK4lsT?=
 =?us-ascii?Q?96bEVaSFjUsUikdl/1iZXPuz99Z2rc2gDk9bd0mKhqveG57PCc7rGiXrgEWK?=
 =?us-ascii?Q?75p17+qILDvbXrHVqMbxm7g3AROkPhQv9+TdFSu+CJDJYZxEFgee+gobqB+D?=
 =?us-ascii?Q?5mv2/ufTnmZkDYCsm6iXqVbsMHMW4/oF4vMdPQQodQZEPllhdx41a895bisG?=
 =?us-ascii?Q?uFvrTnAU7ME+nLyvlamYFrm3Nnln7yMb4ulm7lW4c1+9FtzJ6i3F2aw63HSG?=
 =?us-ascii?Q?gXrjmw/4tougbHwJDexQlZ4lhwHrK9npp8B+tFT4AOJoVRf2UnJBnw7C96mM?=
 =?us-ascii?Q?//I16vCtpODdYdb/eRetgi3u0AfJnvLlNVneaQ3eJnz2JrNjZQ+aXnGYWn14?=
 =?us-ascii?Q?p8obq8PXlQBcnHiFHgbmqFpxyzJpHRXvQ1JRWkCfv6ROf/oj4lVTmWLSN+YQ?=
 =?us-ascii?Q?vj2DyfxSBjFJ8ZiQtU/i416ZtSI0soKLbqC4x68VXk6orgeSgIOLxMHgTvIv?=
 =?us-ascii?Q?WeE0ouwpV4p/CafDDnyAp3lz0XqJSOdSrYWd6BHuwolhzlc6Ns6pPtiwETQA?=
 =?us-ascii?Q?lkHMFqHBqNSX9nmIcrrmTNfH5Ne24oSzhc7SuapwezYUDgasTiz1uzzw3mSG?=
 =?us-ascii?Q?Og5LxC6gAR30bCkUlsnjulEkQFE4H156EZjwVwUTpiPw1cSltzzjXIfFy84x?=
 =?us-ascii?Q?u/hCgu3ZW0WiqJOhRGhcioFF3fwpUa2uExuGTJ6f?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912580b4-2c65-47f8-d5ad-08dcf3faae63
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:08:37.5708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VlADpL+XLm0pX91v+Rk+2V4q4DiUOu2+QFVBs2WV8CZq2XVX9cekqiSu+vjTcMgdc6eQWC084RsqgxO8sE0cNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9153

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
---

Clark Wang (2):
  net: enetc: extract enetc_int_vector_init/destroy() from
    enetc_alloc_msix()
  net: enetc: optimize the allocation of tx_bdr

Vladimir Oltean (1):
  net: enetc: remove ERR050089 workaround for i.MX95

Wei Fang (10):
  dt-bindings: net: add compatible string for i.MX95 EMDIO
  dt-bindings: net: add i.MX95 ENETC support
  dt-bindings: net: add bindings for NETC blocks control
  net: enetc: add initial netc-blk-ctrl driver support
  net: enetc: extract common ENETC PF parts for LS1028A and i.MX95
    platforms
  net: enetc: build enetc_pf_common.c as a separate module
  PCI: Add NXP NETC vendor ID and device IDs
  net: enetc: add i.MX95 EMDIO support
  net: enetc: add preliminary support for i.MX95 ENETC PF
  MAINTAINERS: update ENETC driver files and maintainers

 .../bindings/net/fsl,enetc-mdio.yaml          |  11 +-
 .../devicetree/bindings/net/fsl,enetc.yaml    |  34 +-
 .../bindings/net/nxp,netc-blk-ctrl.yaml       | 104 +++
 MAINTAINERS                                   |   7 +
 drivers/net/ethernet/freescale/enetc/Kconfig  |  40 +
 drivers/net/ethernet/freescale/enetc/Makefile |   9 +
 drivers/net/ethernet/freescale/enetc/enetc.c  | 261 +++---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  30 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  | 152 ++++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 759 ++++++++++++++++++
 .../ethernet/freescale/enetc/enetc_ethtool.c  |  35 +-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  53 +-
 .../ethernet/freescale/enetc/enetc_pci_mdio.c |  21 +
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 310 +------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  42 +
 .../freescale/enetc/enetc_pf_common.c         | 338 ++++++++
 .../net/ethernet/freescale/enetc/enetc_qos.c  |   2 +-
 .../net/ethernet/freescale/enetc/enetc_vf.c   |   6 +
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 438 ++++++++++
 include/linux/fsl/netc_global.h               |  19 +
 include/linux/pci_ids.h                       |   7 +
 21 files changed, 2263 insertions(+), 415 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_hw.h
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_pf.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
 create mode 100644 include/linux/fsl/netc_global.h

-- 
2.34.1


