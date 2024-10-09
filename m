Return-Path: <linux-pci+bounces-14064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FB799666F
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 12:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94B41B25F9A
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 10:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3172118DF9B;
	Wed,  9 Oct 2024 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bMNaopU3"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011055.outbound.protection.outlook.com [52.101.65.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1721918C938;
	Wed,  9 Oct 2024 10:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468384; cv=fail; b=ghc5Qpoxw9/xkYYOvnNsGaCpfPkLx0+zNB2cjyCMSrc+DzzK+LMHTQySw4GC2iPrh9CpKOTUQduZp2gFclgX9wfod3TGP05DYx/0Uhq8yQsokMHbax66YPDX1/8rH35z/aJfm+9qhUvKqNR9rWXHlHsYcjqSS7rqcywAxK66/A8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468384; c=relaxed/simple;
	bh=adKFVnVlLM25hgUwCJL/HQ+PUk2KecRo7/KwFr+9oq0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uTuc/OC7AiZUZNBalD47tgLDjaNSyEw+LLNtWvIDwlPwaspTbgmc6gHTGx4SeN/zE/eTPdpxMNFWwmBJPOIQA64pwrMtlr5+3TC4LTznmlYf7QMTAmVS3GdJPDExidDhc6k22mK8Un2GbehjhGJ6kglCV35cIXFGQRnu+cX2VvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bMNaopU3; arc=fail smtp.client-ip=52.101.65.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sv9mwIQ6W0c12ed275aNmaTMgSLqE01sU+Dx58gquGA382/jUUUw17ka43nWx6Lwbcc8HVAdE3xs34jJyRKSQGEYWYi43kthqZvc/kasD1sGnfzk4WnzEO3NG3V4ss8yOIFPj6nKpichoRp/AXN4I6SpD+yraRkNPGvUYUR/PsPv0otsWVpPZmqiM6ijlthi4uGjIpa1fr/9LiTsSwGXvk1klw9V8xoSK56pcHvSGbc9CBpW62wjPesZcPGtYDdnFtKaB7qNnxPgAsq9oWL0UZFu+oJiqcZfgJbjyXIegCp2jrLKe5xuaGXu2xSfwWte3y6NVPAkMJJ5PAkPLGXz5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fj7VSfPIWnhHOAsqBt0QZAwiUGB0Ln3+6cVbra9HHKQ=;
 b=cS8oi4g38hR8qOpZSGMpUkXyPFTibHLQrAjfK+BBgmUGUevkp1QUZYKPMaORSCe4AYA2QrpgCFrd3x3VdCNaBnUuYhSWMeoQ8ko7TkkCdp4IkvFcW1ifxd+2Iih1D0ZmH5kTnuX85ukZFs/9zS7oZ9n32E9ZdCwy1uwWuAzHrrj33jRaxLeTdO3O6djP2WCtdlOSt6cF9uIa/OVgjepJesGx95WLNlxUtvl0+ZvnoAC5qfMUeMTcjwSEl30nWVpcWOufyhKdOY02BjLHpgMoFwiuQR4opbQ8DuOxl4KYDXlbCbK2wKNKxYrLewtFaWsyyjd+NnoH04OCy5zn1cIDpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fj7VSfPIWnhHOAsqBt0QZAwiUGB0Ln3+6cVbra9HHKQ=;
 b=bMNaopU3CcuqXMKO0+o0D9S7uM4iqigBPMXeiyMqSENB2wymiri+k3DAsxEFru+Y6jGanotxl7SqyK0vXD34dk5S1yn4J2dD1D9NCsW5+CH8WJReUMtdkFBz7ageEe70y3sS04n2h+ysUWkrncHEdnJkbfLAl4pj83EGidmP9hyamStribAhYvv24w2kGFR8EK0Op4xNXqxz3wl2Rrg5J+bHwBB4QlqkYxC4i4W5CLR8zq6m3ChPO76jgQ7wvu4J80/EhcSJ7Po3QYl3OMqbRBIDMpaEB/LsVP0rfFAbnhCcn0Bssv204PJzKCjJid/Z44beu3JLf5eGaFTTPAXclA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAWPR04MB9933.eurprd04.prod.outlook.com (2603:10a6:102:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Wed, 9 Oct
 2024 10:06:19 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Wed, 9 Oct 2024
 10:06:19 +0000
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
Subject: [PATCH net-next 00/11] add basic support for i.MX95 NETC
Date: Wed,  9 Oct 2024 17:51:05 +0800
Message-Id: <20241009095116.147412-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAWPR04MB9933:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c4395a-425d-4dfe-cf68-08dce84a052d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?25l1untpBjA+M2UoakTZkD2OWjA89fDsNUi6rV5PduZwTo5DjqefLE8+aavW?=
 =?us-ascii?Q?qwiBQmkl/pW1xvnakJlyOSFYDYuh9UzjBcRtOQln5mPWdREFzg5b8Mi9I19E?=
 =?us-ascii?Q?Qi/V7hCv7Rl34DaENjoVZ7AyiTtulcqpphuIahZRJK1nzXQ66sxHq+IBprX+?=
 =?us-ascii?Q?U2LbEOjoxLQ/WgOIZmlkZO60xqMsk/9SYSQzH+u2cqqWz3VyD8L+EvuOZENv?=
 =?us-ascii?Q?LDz/1l51Yjk7IP0ZZ03SXSRsKxWs7fNGMAa4HTnIPaxs7MkyJiHTkuRgXWV2?=
 =?us-ascii?Q?42AP9+ZbnxRkwcwQNZ+JChIDWjWxcNsLrgEAMwgdbWUeMceNGsIkkiogDWIu?=
 =?us-ascii?Q?AzUh+7iwHY5CNUNto8YXyEcu6QCFISiEwAW26JeKTuloLx7RFPIBoWHWuH7y?=
 =?us-ascii?Q?NP0ib+Up0l5F3tOLW3SdfQHC0Mw9sEo/qXFamnmM8fqBHkXO82K59e4fsV+f?=
 =?us-ascii?Q?kicwW6icb34pb5UIXxEAyLsImvNYXG84Io4wQoFA3aBHjNEfrPrxd2mrrmcY?=
 =?us-ascii?Q?zfFaP4ijoyeMxCY0gYJPZdjH6CxYzgRcEXuIUeqlqNP4a87CM0tLJbm2JAnY?=
 =?us-ascii?Q?yFRFkMZkjPYX2VGSgM3eBx08swoItpZPv+JQX9CyoLfzCfYyvG3gw8ad+dMI?=
 =?us-ascii?Q?WMM5cXWhmtef8PSzvBkrCRz1fqUyMOeMBmkv4KGzMoEAsG/BllmDIPqsSsc7?=
 =?us-ascii?Q?RUwOPDD2P7Wq5Me8qTcYKC9UcpUy+Liiw6FMHS8+sT7MZ7GouvrA61+fh80Y?=
 =?us-ascii?Q?c7Aj2vQikpvgy9ACFITNOVE7IhbeLBjetJ3hUHWOYNwjwN33TPujmdt5Xkix?=
 =?us-ascii?Q?5U9MhKEyd9lP2nHAktgh+bqepMRPI/AK3O6wN9NXHqRQhqpMAH4Hwt53XS2n?=
 =?us-ascii?Q?gllZ8xSHBvKLRf9Lr1UnXdgvIbyiM+nThzoN57L0TSVggebPHKX4AjKJc9Lj?=
 =?us-ascii?Q?p0nuSBwEivuslnfiFOPf9LlWr03AK7t3/Tqxc+KPT4y6X+NeNs5sNizwh+qa?=
 =?us-ascii?Q?9fFyMTlXqms/E+SPK+dqUit3aWdsue9Oo37DBlEw6PnHxxTxKRE2cZ/DqmIF?=
 =?us-ascii?Q?84D7OlTLoWyojUt3hkNVEJjfSlkm1g2BUArfoHZXpp+gIXbVIF8y3TCk2zyV?=
 =?us-ascii?Q?kygYUwuRawcT5j4gCDj8VniOLfLm9pa/cm/WSTRohtNpN24HwrGILzbiTirb?=
 =?us-ascii?Q?8VT4s96ja4CCOWUFcIbwwqxPur+nh9+21a6qskZXPsFJGYftnwhHJsxeUzl9?=
 =?us-ascii?Q?mvhKuPdMoDNDVCHfWu9dt2yCM+c+kYv8tdpmVDv6p8Iyh/xWmNLd9He9exAl?=
 =?us-ascii?Q?7YUgD7SQUYv4l3gXO7yw6Si3nIS4j0N+HL/OIopzHNUCfvRPxpwAzry/eWjv?=
 =?us-ascii?Q?3lkpmGU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RlTYpLxKDEf6LPEmsF1vxKs1+cDOFih5ucaK8oQzsGL0kBvhBFeJ+uAWMGWX?=
 =?us-ascii?Q?yOtTi6iRwasZt67qwHVRcn5/1gR4m/Gg8o9/Yv9CZ3LIZ73WAVVP3fzEOYVn?=
 =?us-ascii?Q?wqei7aCwZnVYdIK6YNjLfU0E08qHoWz+vddi2Hb3xwaYlQ6b3iseNVcX1i1t?=
 =?us-ascii?Q?ob+FOxfdsghrgHV8w/VXqN8m6Z3sdxd5Rc2WWwr9LGEvR4DRGj44vjRuaIe3?=
 =?us-ascii?Q?5Y4HjdYM1W1y0dYpeagHwtrO2K4vvQImbqwbCiY3TathWCbKroF00vRv/R/w?=
 =?us-ascii?Q?UwdPicNjV6dDgrVT+jbGFel+9YPaajn/Ob+lwuh7ail/+afQj/l+8dpqyBnY?=
 =?us-ascii?Q?UYETqq+5bHhqp0IVOpsqE8E+PN3IIHpmO05DgMorgUdZ1aMzyg9sNb8dqNCG?=
 =?us-ascii?Q?xl9ZLmVf/Efjnq3pupdEWVDvqGD0U4I4u6Wh5UgyrFUoMO5AOjJ1fjruwOZp?=
 =?us-ascii?Q?yFWbpX2SFwpg1J0UR34df+bTWjN6qTQeRZleFTZpI9UJZkDGQuXqjstYrrQZ?=
 =?us-ascii?Q?Pe8pk2O3s0WHAkB3rM51p+UUzGKX0foKpWrb1xjPjNP5VaVW8jzkBEOdAozU?=
 =?us-ascii?Q?g67p4L78bpN/i9Xnu/Qrb8CoUtgc7myBvu3ncirAyRw5NVl7aSGiF01q6cY2?=
 =?us-ascii?Q?/4GNyGzdqTvZE4izqsAEyyljxgnTfhfBq44W2GlIRwuVd2cqOvMtlh+Mqtw6?=
 =?us-ascii?Q?AgweS+m74Tnzi5l8026eqPmM8puN1Mlzm+EvGzyKO6RgrBbBLcQyKATmUo3N?=
 =?us-ascii?Q?8AKhZpD0ZKVBQFE5K2O5uwlr8ldKBKBCBG8icD7bl4HxNN4InmFs7fhfJ1vv?=
 =?us-ascii?Q?KNNoOQgcpUX7AXNX5zPkyPnPRTa4FQj2O+2KuFHGtw5qiqMedh5EFBTvmaR8?=
 =?us-ascii?Q?XgqrcZIyL6gGjCiEpEPvwJt7d/MNvJvv89H6RGw8EM3KCtLUtoS6FWihPGow?=
 =?us-ascii?Q?ePjqGegAx9ahK6WSYElamCxcsMBtXgAK+T3T6ujUafCc6fJ6OKuwwEb85XjK?=
 =?us-ascii?Q?pJJ9lQSBXy1JooZ+k30bh6stQwkQnp1bMN7ttl2USez3IsfxKtqkSBrQVwH7?=
 =?us-ascii?Q?aJcAkp9VGANfVj+5FbjGjJ7sf12BUcBObWPopa2/8R5cM5lZztes9Sl6P0mR?=
 =?us-ascii?Q?vjqMn+Uh2NxrlMY+VDAE5G/Uk+Yw6JtMVe4bmj+9j76Jul6CLSuKFjXEX1RL?=
 =?us-ascii?Q?omg4AIL4Np7b8C444JAJRPQ7y/uYe1rsg8eIF0mRA/xIP1p6NeKnAZBVZtx/?=
 =?us-ascii?Q?WOzaX+/9x8LS8F7XNExsF5ERtA3kGy8/M9UnMnBb1oFzjAOBRxPsyZ5g/61/?=
 =?us-ascii?Q?8kMEUoKxhSRled7Ne7UwM04mqOuBXDDV6fn69DivSdSofMgFvoR+EwyxUHvX?=
 =?us-ascii?Q?HszxBzNFnmXF7FG0DZ/dZ5C0vG2EgWX/p+JMsNpPrW0SEbZ9HL5wPRf+LrBb?=
 =?us-ascii?Q?YuLiIDFB663RqgFdNvDSPVgNkwMchoBjRClNY7s9vXqgbCwZjyVBKR2mD7gE?=
 =?us-ascii?Q?vDzaleD5G/VbVVEVzjDUs60k7g8+uZ/nr5MPdtcjI7AdvBsTXkMTBokBmeHx?=
 =?us-ascii?Q?L6wPBPDWf8ER+I9L7C0khl5Wn7rYy6+EAFtBc7IE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c4395a-425d-4dfe-cf68-08dce84a052d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 10:06:19.3438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwaZlxQB8Cn039qtnPqIFB3lfjjB2DgTzbZZ8RL8ZHTk8F5QDnBtoxpjljp4xvVdO4pe5mMXpmBcuhfPwj8y8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9933

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

Clark Wang (1):
  net: enetc: optimize the allocation of tx_bdr

Vladimir Oltean (1):
  net: enetc: only enable ERR050089 workaround on LS1028A

Wei Fang (9):
  dt-bindings: net: add compatible string for i.MX95 EMDIO
  dt-bindings: net: add i.MX95 ENETC support
  dt-bindings: net: add bindings for NETC blocks control
  net: enetc: add initial netc-blk-ctrl driver support
  net: enetc: add enetc-pf-common driver support
  PCI: Add NXP NETC vendor ID and device IDs
  net: enetc: add i.MX95 EMDIO support
  net: enetc: add preliminary support for i.MX95 ENETC PF
  MAINTAINERS: update ENETC driver files and maintainers

 .../bindings/net/fsl,enetc-mdio.yaml          |  15 +-
 .../devicetree/bindings/net/fsl,enetc.yaml    |  23 +-
 .../bindings/net/nxp,netc-blk-ctrl.yaml       | 107 +++
 MAINTAINERS                                   |   9 +
 drivers/net/ethernet/freescale/enetc/Kconfig  |  40 +
 drivers/net/ethernet/freescale/enetc/Makefile |   9 +
 drivers/net/ethernet/freescale/enetc/enetc.c  | 171 ++--
 drivers/net/ethernet/freescale/enetc/enetc.h  |  19 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  | 153 ++++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 761 ++++++++++++++++++
 .../ethernet/freescale/enetc/enetc_ethtool.c  |  68 +-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  46 +-
 .../ethernet/freescale/enetc/enetc_pci_mdio.c |  21 +
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 350 +-------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  37 +
 .../freescale/enetc/enetc_pf_common.c         | 383 +++++++++
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 476 +++++++++++
 include/linux/fsl/netc_global.h               |  39 +
 include/linux/pci_ids.h                       |   7 +
 19 files changed, 2302 insertions(+), 432 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_hw.h
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_pf.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
 create mode 100644 include/linux/fsl/netc_global.h

-- 
2.34.1


