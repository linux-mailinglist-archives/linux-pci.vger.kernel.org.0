Return-Path: <linux-pci+bounces-14972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4713B9A9936
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 08:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69E98B215F1
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 06:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E86F3232;
	Tue, 22 Oct 2024 06:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ShY7pYbP"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010041.outbound.protection.outlook.com [52.101.69.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D69F7F460;
	Tue, 22 Oct 2024 06:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729577251; cv=fail; b=SHVj2O+IBVVBDSTAfRV+d+RnOpAKX1puvOljt2jvqHe5VL8XRz5cJLRCQY/9uRGsiwznfvv6XJ+ueTLpo/XYxF8QsI7MJ2iCKHQmaWAdix6D0MI6B6CXW3VtTiELIn4MXOJA5zSLwScltd+vR78U2w+ygJDKN08sNf2fq4JnMpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729577251; c=relaxed/simple;
	bh=pom7MfpXp3p8quD3twUm6yuA6oe9WRzkxcyLCMtunRA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JL5BGWuyZC+HwV81NrqUKxJwuMHiB9n/2TrNBK5EJimRETgy5+UO9MNrbDTAF0+tB197q/coq1o5wyqwv0JGJYsB+GIqs/YdzMlstGzJ51frrS+yyZXx3IhM/pGHJT+IQJGg6mmPzOBdB2mYAmwbPkvobymBZ8k6mA/DRg5en3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ShY7pYbP; arc=fail smtp.client-ip=52.101.69.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hweSWIJODbZ+4s8XFfO83mHZ2hld1DqdYDznZN5b+7qVwW/YvdcJ5bSSAZhKyhyrRQbC+lu3klgaNSWfi23803jwPWPCY3v3dvTcMW94pyo4qimwsC/CpTfQBLa7mm4uXLRdrgha978B6BeGdEA6a6qhZ+GsYtXSyaPYlJm19vSM6ti3fQ3cnjZShyjzfhiSs4SBDV7EmIOP9dYkRIccTPTeDw9bHQVXs7fAsd8Fivpd/R8mg+phbrP7AWK5ekxuTk2Bx1DLO7swpctJ5lRtao1CtKNfZoNDuPgG801fzCbyyOCVoIZ02g1r77TTLfe4/O+0dJy3av9flJBkPEoQFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+4ktlpx4SBIIMBO/8dxKOh2ibNiCcNeCkJU1x9qPac=;
 b=StfxrDaE+/owYDSlpVxgFi9SzC4+mZAQla/xitFqfYWaxOcvLiTD0zLg0MAxOB9tbTsnC3et3Ld1rHMwrST4DsH2x4iBZO58VPHwZQKKvkqvput1nrYX6NmmWKln2grj/gCNagrR6IOudBJ89ANWtqrDIItkHNqqLnkJ4iB5AluFZX5mGfbzcF8iH52Bx1pFDQEwYLdDsYFfmLrLPgvUwqWqbZlabe7OxGQc/w/zP5uUvswL5eQjwEvBcZ17VGPSefYm5EdVMDDlO1+zePMIFsIw+4Y6+18GjSBN6BjX3RNJnkH601G3qlVyuWH5exhaxWEGwT8z+Ri80eCA4EVvYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+4ktlpx4SBIIMBO/8dxKOh2ibNiCcNeCkJU1x9qPac=;
 b=ShY7pYbPFx6OXX591BJfXYq9wmRP2qdBaVVmF2QEAK5zSZrWKiPPdJyPvypsSKliPk7LEbN8S+ZqFj14aioqLY11jcpvB+ufzZxkqXKAIIImRhRB/FdK2/vAIPO+gq557G3unogSihjFpGT6rsKgN1kIDEiuhJahlLOzIkUBjGC/GaNLRUjpiQSpPiyx/yH+WpzK00bZcgW2o+lYaHirXxT8i0GOZV79MkAqYFOEjjlIEiUda36iSRW89zZJvwnDWBD9F6LwDhPVwMScyGB4k0MksdaWLvUDPGsK2CXwVjFr27FLiyM0Q9aCqR+wgEpOnc1vDoo/0VV7Q2hCN+tFCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB10209.eurprd04.prod.outlook.com (2603:10a6:800:244::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 06:07:24 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 06:07:24 +0000
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
Subject: [PATCH v4 net-next 00/13] add basic support for i.MX95 NETC
Date: Tue, 22 Oct 2024 13:52:10 +0800
Message-Id: <20241022055223.382277-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI0PR04MB10209:EE_
X-MS-Office365-Filtering-Correlation-Id: eb25b2a7-2ff6-41de-6d25-08dcf25fcc62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wo+PBSoKrVedWrquNqTdkNloyILNfnGFHenXpcrwukg1CmghxjdD5wqLHrxP?=
 =?us-ascii?Q?koGvyCt8HZtcXCCqEzuy6H5fMdkQu6nS2D23EJWXCJQ2DlHDIG5SGVUOxQ3o?=
 =?us-ascii?Q?Uo7kKTQHnpfHVHmZuMuCUMI1vUIfQ9kKzsXKjqUsIbZMu2JEMpmxT1aWaEG1?=
 =?us-ascii?Q?fP8/iD1rn9NqzTisVeMBKoxCbphpoudn2K3is6S6RBKXm2bswJgkU7eLbYcq?=
 =?us-ascii?Q?HVyg3Nzu+c+1YlErWtfpDfLL5l04qKEjbcmKjcMHEEVn7a11t+7cCFuyZGbu?=
 =?us-ascii?Q?lKmsDQOmB71GrYN6tDiK8vkTrDvE/NDQXaNYTvAQzO2FFpvgDKz572iMWCC0?=
 =?us-ascii?Q?Em2CaWHSJH7klCNGRIBw0ek3c+/5RBitRwZCxorxyGOpCsdMp/S5CosL0Kl3?=
 =?us-ascii?Q?7p0ggp3OjtM7KCvRpnu9aLx9OP2Zg/VuhgMTyjVarrDMNkQmZTx4CUnUI31k?=
 =?us-ascii?Q?WqJ5ILYfNtq405uFGGSetNOrVKAnoXXoomUdLz0Q4FJrpg07GwXmIrPj02EZ?=
 =?us-ascii?Q?Y1SCuSs8YTH1jRpmWaF6gkFqVw2d+VjpWk4bLp4oVLveRMyYIttavZwZWXEp?=
 =?us-ascii?Q?TDfgkTZIUgUO0LgP5CuKrbpmKT3HSyguRmaNBFJeYA8uI8rI18BLIysYrsFW?=
 =?us-ascii?Q?phor8Wswz3u0gsHY1NP2QoZpODWmuFlWri1g2FKVDDkJv25zI0XcVOimWPKF?=
 =?us-ascii?Q?N1scW/2Zr/7iKxmoW/qVa2eP8TcTeGJ2DH06MMV7VEhm7L1loAyBDE8Uwaja?=
 =?us-ascii?Q?tU4c3804FlYnW1x28vJZgRgevRf17NQjBlnVIkFCs7N0CvC6DnzSHAH07+98?=
 =?us-ascii?Q?kYRv/St0q5K4gbGumUXxvMIWlh/Uyv6J2Qy5D3Aj6v+wD5JljBur+3ZU3iVe?=
 =?us-ascii?Q?ptPOK5iiem+/U/SjZS6zjS4BIH7oLV2nzoQ5Xnxuo+xvkcCdYZsDU2xtEOmm?=
 =?us-ascii?Q?EFS885st6NbhDci4EYUlKnbgFEtzz++DKzXgqviwnh4EpYPCWSXn8YKhX7oZ?=
 =?us-ascii?Q?P+cHv3l7zZ8TWfjbFB1D6oFjU28MsqCwVHaKrIomyZI//tvd+mz3N+bZmGiR?=
 =?us-ascii?Q?E4ggfU6w0Uj1ab5jmwBfgAj795suW6HNa9Mqx4rfKpi+HItJSJTafKKRM5Xc?=
 =?us-ascii?Q?zcXN852swjKQR7Z7sA2gQ+KMCJjf3rxkEyrD/SG4gxUnX4RdzzgpRQlBHiNH?=
 =?us-ascii?Q?oJUR/mNRsGQBtV9t4n4Eo+6xcHyDtcbKYMbM8Ab005d8UP/pitp26YP0gbJi?=
 =?us-ascii?Q?H6Ob0mtqYr8CjMcDeGiDc4XZdNRLkkmpJEsOWjFlIt+KL80Z2FKaRJZNYjDQ?=
 =?us-ascii?Q?n9ud+Uig5CZEoO3Set+aKy3vulVwwy8x0z0N6jECoaerAqun/rxslIf3J2V4?=
 =?us-ascii?Q?DY3dPzcVqOyELFQ5S5maAMUMk1KB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LIy7LXIKGJ37mlYVTCEagbQ2H/A5oOSkAekSAuoEy30cLqSFTy6EijqHUAaK?=
 =?us-ascii?Q?gZxT5nfXg4+mlaFPmD8UwrrDP87OAZkbq9D9lZQAyLJCK1oQqBsGlvqDRUe0?=
 =?us-ascii?Q?mWsmjlSXWVZ/bTaUhF0tedBS51SHimX7Bi2yoDOi063XfiQZhjrhJ/oPlGho?=
 =?us-ascii?Q?B687ntCUwHhXwP1VqRvCs5xuiiAGHBTBzJDNRpUuFIZINzyqvYV9Py2oC/mb?=
 =?us-ascii?Q?BxSXcn9YuboxkhxAHoFc8bu40HB74emSFVvwW4S4ZeeM8ZBgwzAQMiMYAeiy?=
 =?us-ascii?Q?9IkHiAYVT5DHZhAxXigcakJ4SNaoK3Ve6qeBoAqJQms3Z1bDwFoccQpoiDoN?=
 =?us-ascii?Q?xEWf0OZ+7MxUwiwUiFSANnFPEKLdzgRDm8TLPzSVxQWF+FuUPkDPEa9g/4hs?=
 =?us-ascii?Q?GMB/qjLQALWCjnrwwXCq6f0of8CukLHgk6fYWWS83XDsyN19MRcDTGp3Reqz?=
 =?us-ascii?Q?eAgaMrsALuRbY8WQZDorhMhV7KeNuRLSZBq8+n2cmY0iQrf2VMzHpQ0zqXpm?=
 =?us-ascii?Q?vxbrR7RIChAIpq6kCw5/j5tnBtAgcFQOq/NWsy0urfBnmD3LnuVlrVj/iScf?=
 =?us-ascii?Q?vfmnr4SuuOkWmF8DAsKwUuUh8UGmbY/4vPuZBv0m2FLKKwpxdle6/ZTTp8Zt?=
 =?us-ascii?Q?rXDL+THS2qrBGSxAA2+Gbf5BHRPi9SoQ/hIUzwhu48uJJxoZNsqRNYRe5qAS?=
 =?us-ascii?Q?Gw5Lzq4X6S/vVHjJ6CUGeK74WcXxYpag+8jXQc4vNaF8Ng70RpmePCVPycS1?=
 =?us-ascii?Q?3smGFbCVacIVO6OpRc3X9A5dnPro6/IN9dMeIKxyvkQQqAe9vI5dORdoZyEG?=
 =?us-ascii?Q?IcNAujbuKOIx0aOfbmZtJoX5ARClgLXt9s/8M3CLiRsp9sOOVnNgNrFUpKk1?=
 =?us-ascii?Q?VoDrdygjwY/LQpqOOxg+96biuSzYWPamRmQtN9cmYExIwkok7APsqCrDmgb/?=
 =?us-ascii?Q?d0kGxiMiGK0ify0FT854VU3VzcQ7JDAWw0aiEGhZ7b9FA0mweXsvLU1wR+4P?=
 =?us-ascii?Q?1kk9/nm6c44b/5LOTKcAp0hl+1hnSQNik5HZr0IpaWKYrUknE4Ou5/phjtcL?=
 =?us-ascii?Q?q/4UtOqP3owmOQm/yLtDbeASNva91knB2BbTD7VX2tBVzFr3xztnDKBYC2CJ?=
 =?us-ascii?Q?1y8bjiOBYQA7T8Q3BrhqkjDJO99V45QtsxklZNY2xkvDeUmjKwe8K5Ne3X/M?=
 =?us-ascii?Q?iR4LuCb2H/8lThOC+QMGqdTLIbXfVik3p65orWLOZCF8p/VH88J9LCjKb6AP?=
 =?us-ascii?Q?TPrIR8n8RPisdTo0E9+Gx96rqN62g48W6BzU2rgJSoPhaNx5FiXnXyOX57wc?=
 =?us-ascii?Q?u99v62H5TCsRQLKBJ/c0DQdNYkCzNyDaF7Ku9tTnKfUL4ToXMB8OMKrjinWt?=
 =?us-ascii?Q?aYVYEis/E/VRNfSyNPZGQui+YsVrJf3q+DQ99WUsg+Bdlqx7pwZnfe7G/I/e?=
 =?us-ascii?Q?Bkuj7qiYMApTT+gOWZ0sx0fHjqZocGw0B1QYKQf2lATx0Ss1+tZnzYV0/PRp?=
 =?us-ascii?Q?II5+TPixdEYhnN/pZQLxPdW/dzzKsr5dr5bplT7PL57hZj/wcmjjFVfeKTB4?=
 =?us-ascii?Q?2mw3ZJL1EMrpZO8TqBjrNBr78lCdqwDDDiJ3UI+y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb25b2a7-2ff6-41de-6d25-08dcf25fcc62
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 06:07:24.6846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4CxOSSTfJ5ZxCsNUs7bH2dpaZpIpUSzSoOHTeIHj6coNv2OtPHXmD2pTUbD0Lfohtpzvebp7xGeatEOFnsBcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10209

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
 .../devicetree/bindings/net/fsl,enetc.yaml    |  33 +-
 .../bindings/net/nxp,netc-blk-ctrl.yaml       | 111 +++
 MAINTAINERS                                   |   7 +
 drivers/net/ethernet/freescale/enetc/Kconfig  |  40 +
 drivers/net/ethernet/freescale/enetc/Makefile |   9 +
 drivers/net/ethernet/freescale/enetc/enetc.c  | 213 ++---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  13 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  | 151 ++++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 753 ++++++++++++++++++
 .../ethernet/freescale/enetc/enetc_ethtool.c  |  36 +-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  47 +-
 .../ethernet/freescale/enetc/enetc_pci_mdio.c |  21 +
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 303 +------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  37 +
 .../freescale/enetc/enetc_pf_common.c         | 340 ++++++++
 .../net/ethernet/freescale/enetc/enetc_qos.c  |   2 +-
 .../net/ethernet/freescale/enetc/enetc_vf.c   |   2 +
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 438 ++++++++++
 include/linux/fsl/netc_global.h               |  19 +
 include/linux/pci_ids.h                       |   7 +
 21 files changed, 2180 insertions(+), 413 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_hw.h
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_pf.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
 create mode 100644 include/linux/fsl/netc_global.h

-- 
2.34.1


