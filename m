Return-Path: <linux-pci+bounces-14068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400C9996682
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 12:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D9D3B270B5
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 10:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475EB190688;
	Wed,  9 Oct 2024 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KITbfP/K"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011060.outbound.protection.outlook.com [52.101.65.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0B618E354;
	Wed,  9 Oct 2024 10:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468411; cv=fail; b=WqvBfyO1kzA7FImwTN4CqVG7/A41i7/fCmAmyKPv5ZFN/xlNy0AcLoGYZg4RA5reWWkRDN2HKex+vA/jRm3I08EWxdlIWZwJgtyYtsRv2a5CyZKiO8jyV8bxK8viZ6w/+fZikub74mevJwWPAX3KlIKKrpgs2o7o43BYkafPRUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468411; c=relaxed/simple;
	bh=Md+ckmUz0NRVKqq9DdMLSqwcm7vr5oUvp8RzFFTrCQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R7U3m8W5reHtiEspFCJxl0Ex7VC+afxn7pNzawfl2X+DW/nnLkwOuzOuHqcIuXCUxGij3sAUCB7rqGzAnORYk2ki5NljikqK7fz5YoO07Y0FPBFgXVKNf9+Cmdx/dDsykNBk8ImRXdvU/6kwcHb4THVR2HMltDhm8PPlKdg2/9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KITbfP/K; arc=fail smtp.client-ip=52.101.65.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilEVUTdMyVwScKX9zWIckiAooY5GtUDOiIT/kECVwqaEV3WgReo+vEOc+drcgDAdgMPThJVe4PZagtAYgdRqkluRP/XWuTiNYe4BEnoBjw0rDpNCJBKP0Qhy2nMMKZ6Egq/vF5UjZvOToPqC3SpJvPoYKCVw0fMA8BK5bNLrmVpeFyJmuG8W49DxnZqHisNFtpRSQ8+mt3d19Nz+AiYMYT6kBl/dgYy7YulOLSO34+7bogJNaPhyam0CaUCeTohLtWwmxTUyNL2cSJdf6W2HR33Mg5P7bJ7zrM001CLdPS0l1ll+vcRHq3dh2KmqS8ipvXxlRs050WxnV/jo4rhWIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycU0wNh20KnF0RlOA6bdchKNrqgyQvwWgnHeyi1qmAo=;
 b=VajpKBbf0m9ZqbJHhyMuLvGlVet8fSRFAn6Djz/2hhV19LLZa6TAkiUqcUfaDT9HIA9upWgqRptBhY/QKkulglwz4J/h10DErv1v9IrUd2ME3alSPGaz9yawsstQ5pK9K2ACGri+CPuY8BzEQrLd+uDmJ4Pxn+IHJdSex7mNwIsU+BTZ5JluEmY66pc2jIr9a/tp8205/2q9uD57GbF6O//ZXDxsWoRTkSKo1ipLXT7wUu1Y7a3p1Gv+BbYndTCaogvqphOh/rRYVOW0PArzcoL/B31sQJKxNSkmMb5SlEGwoa7MP9OStxH9xT2QRe4SRnOqakitrC2vzGAAxOQJFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycU0wNh20KnF0RlOA6bdchKNrqgyQvwWgnHeyi1qmAo=;
 b=KITbfP/Kuf19qlwdMbXWUB/RsryX/LntdeRAxPDR4Vxca8MdeVJZ5y1F20Wt3vjet3S29WtvHmjCILhnzCy7vsjhRwAvs6nzGRezpzd+qiEkjTTlMeeAL1afZJsG81/0NM7PTX3k6GTqtcsN2QtDGGysnBFk8u7oR0haeatBMe6HFyqFgr90310+Gybp3qtcJz1Tltl4Fw3Tzaz1bc7BhF1Y04tqGgcRs+pQq9CYwRzMZK8kHbKTsvTRzSf0rhhi1SLUNmThrtAfMNfss+xxIWBMwplpcBqWcWSxxdtZ0h+/RNPqnGmenNGf0nskpF4j0IizmvD6hfruO+VktHF3NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAWPR04MB9933.eurprd04.prod.outlook.com (2603:10a6:102:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Wed, 9 Oct
 2024 10:06:40 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Wed, 9 Oct 2024
 10:06:40 +0000
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
Subject: [PATCH net-next 04/11] net: enetc: add initial netc-blk-ctrl driver support
Date: Wed,  9 Oct 2024 17:51:09 +0800
Message-Id: <20241009095116.147412-5-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAWPR04MB9933:EE_
X-MS-Office365-Filtering-Correlation-Id: 4404ec3e-8a56-40c3-093c-08dce84a11c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mAm9V0Gv9dfXl9onVmPVR6FzJSG9+3JVRiYICbK8cLI0Wm/XMYvhi780RvD9?=
 =?us-ascii?Q?s0VFLlnN4qMUBUxTAgtYrMihnd4AuDbQBIySuXeVkC9FCmD428jtAq5wmdQZ?=
 =?us-ascii?Q?f1ljsIQ04c6v0XFy//Ikn8eM4wnLUNplpCJug76OjmOOUBPaifoq5BaEtq74?=
 =?us-ascii?Q?xb5XVcIi0TFyZGYU0vZn6RUctvTAjPwxTiqsnoku4OaFOCbfvOIlgxIofK/h?=
 =?us-ascii?Q?OLOwkbGk8dAtUepFviyh6GJfzV8o6xZPqFKmyvsQX12iRrOWdlYWOOrD+UdO?=
 =?us-ascii?Q?Ykx2XH+OLj+uMDuN6dFJakiAJYXICb7gYuXPZgT1xH21CFjW+74qTPqZ5d6k?=
 =?us-ascii?Q?UKFH3Z/68w0dhwVJAE+hUcBvnKEwYKlVZUtAAyAEYEHuV9Se8bgOQeM62uXZ?=
 =?us-ascii?Q?FxIwGJxypCnYVCIBcQY/xivN9k52bwYkTAmwP2TP2QdiYZt0cP7vGhtq8Rqc?=
 =?us-ascii?Q?ftRFWvQTO6nP2nbzEfbCB/rZykA0V661uC3BbmE0hem7SejRJJ4k1igf9blg?=
 =?us-ascii?Q?noZtsVJSXr9+pIVu6EkML9ITXed2Gf9CLsRDnZI8+S1BtJv89JQ2Lbh37Z0i?=
 =?us-ascii?Q?xBg8dmLQFW1ijM8eiZ4gqqGaLiX+iV18/NTOelvmg/1TYJgVHvozFkH56o+8?=
 =?us-ascii?Q?Tnm4+eRlz1h1fjd+0pmwo5gcSrDuYQY4pNgKPpB9G3qxiDR8t+j/8xnMuqFR?=
 =?us-ascii?Q?g0GviuU3iyxX5gfFZLAlpL8qcVjesYyQ+cqH1OlJdavZvLT3zMK4kq2OsczW?=
 =?us-ascii?Q?vMEEDLD/Zv5JbfVTJuzq5KPZSU5S6WO7sUgq3ntO42ES62I2za1IrXqH+HFC?=
 =?us-ascii?Q?YKwM06kBMjQpPuTCsuuHfLxVNWk+qtFsvutItnWytb8Xd4PsE8ta1RLqt0nA?=
 =?us-ascii?Q?amzUGonAY/0I0Hv9vWoL29kZyGGxXniWCsI/mGM1847iUJMWSC6pu2wzr7cy?=
 =?us-ascii?Q?w1c8/2q/+P8NUKk5cVaJ62Cu7dFdOsDBp3o86pDlLjukJgHV0i82WlVcNxMH?=
 =?us-ascii?Q?1oKi7mKzwUoaJu0CoRk5kKljPO1i6nL1u3VNBsiXasJROlm3Tl5EA3PR9lpw?=
 =?us-ascii?Q?mPrda3ABelCskfFi92ig0blFIYzURTSYo4Uv+p3a8r/TpKmojB4tBieClNH1?=
 =?us-ascii?Q?gNOBiQXuVbFPO8yjW/9zm8laPiLaPSc9eQlsbBTHAkKj/pmXnZKy3YpaSvz1?=
 =?us-ascii?Q?SGyosraQ3F3A33wWvAcplfdpkEn4pjQbkeApVCaWQ9vw+CpHya1rlfWbM5Sn?=
 =?us-ascii?Q?xadcx4nccw5NuE+42t9ZADo8N7wEHf0ka8aDXmF9rIeaKjYzJ1ps5UU7gZ+8?=
 =?us-ascii?Q?Qswdke9sAvAg0VGKfHbhkK8JJp+q/U+5QknJ4HV5Br7O0zj+w6GY3NVypNaa?=
 =?us-ascii?Q?2wgUc1s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bkGY+o36SAtXQ3suBdEuVaYYAlXrBEY8ZiO2lQNaN4gIhvVXexbVJbaAg4dg?=
 =?us-ascii?Q?xCOKHbLzqLjezLbSqLLOSvSbMV+7U3S3C/QyfPK3RirgxQMasN4A5lZTTOfz?=
 =?us-ascii?Q?lMJH6wOxY3EeZnocT47VVfCypczP8ctcBHVQHcWjptJrfyFN+p+mysLOAtTn?=
 =?us-ascii?Q?9IlGqJVO2Hkpfe26JktkRjsa/L8oe/Ku/GXpkhXtvB/d2dFYl0iippTRuZ6F?=
 =?us-ascii?Q?NvQnHjeJG73bzoxvXWP0faBzRom9slHRUCiBPnkTYDqWMc1RJsTtKPjtWCAe?=
 =?us-ascii?Q?JP6o2tPbxZuqworGZ/P5HGKkOEuvo3Jg1AeCKJ8AmHhFEKfStL0cnpRmrJ/i?=
 =?us-ascii?Q?RV9md6SgHxWYeqPo7sZIPH7rY6RzWUXaZGYBG+s81i0HtNFSQmFQkkeq9NoD?=
 =?us-ascii?Q?ASwOB3418u1nDLty6iOA4CA4DhRRKQ/5ZbwVPaUAehdw1qe4gnszadftXnyh?=
 =?us-ascii?Q?gPUiAkF/LDIK0nqRJ9iXxVEG9HDRQtZjl0L71AlYbYz+U3x1/OHncZ4j42LE?=
 =?us-ascii?Q?QSWTGp86OH+k0gZQzxBXKDcmp7vXSBWEuQAs192p7Zd8gJ3s6/2I2vsqQZFg?=
 =?us-ascii?Q?XJyL8F8f/moTnuaw6s9PpL3FHbwbmDc0BfXH/KNqIU10CGYg4dUBMuKby93b?=
 =?us-ascii?Q?K8ampbRkupdEt2mCLSeCtIY26clVbRopYALVxnlP6pcQobYH3EXgY6ZjORDn?=
 =?us-ascii?Q?FUck6KHEcGviPBLTlk2nNX16YSx7Ihc+vu5gPE83benbduAVoavo6twwMUhv?=
 =?us-ascii?Q?1l1D2NzRJ9rG9dPDpsGd/mWG8mis9VOggVd8fv47rG/rZyeyVJrgROhGMgJj?=
 =?us-ascii?Q?aOr+VAtrhimPFKt5fWm1I/rXesiuVNWv8mgDVAlfvLMFgoEBG36R5ebZAeuQ?=
 =?us-ascii?Q?eEXpfMYk8rmmbHTGsOpyXpvQ2mtfCwsO0+2fUTZ7wdTY5cGUqa48zDya/3He?=
 =?us-ascii?Q?mtXrt3u7xXWtr9gTf3AmMb/VL6Bg1jeUxIJz0FB1ip3u4TmKhuG8CK4mOw/e?=
 =?us-ascii?Q?9AoW2D1v1xcF5k6ZNgZRycCtGZwTNwTgzRhf2QzO8ijpNBlXMIqV/KbpHUBV?=
 =?us-ascii?Q?VdJzC9m8JmzpgMcme756bmJNFa203pDIJLXYgSanPSY7smcmzPTyuEVQeGqN?=
 =?us-ascii?Q?bRs8nawn5fw6lUxSNU6DlLmn7tq/U0RxZyt5hyjIsd+G+cScM9tEqKLy/W7E?=
 =?us-ascii?Q?dzGv6ubx8CqL+wPbLQn7Ezed2dz5bw5sSf6WL5FDEykp76gjdGHOHnG0Ppdb?=
 =?us-ascii?Q?McswpDEO1Vv3GVbSd98LtZSP1G72X62RKcxGhQsKYIXtHcbeHeJxnNZOmaL+?=
 =?us-ascii?Q?agd2UdYO4bte7Fb+5BqrHozd/jRsMaWmpqIHCxRQRF4SUWy/7Yy9AR2SIeOu?=
 =?us-ascii?Q?v+e+DoI1aZwhxQ+J8J432J2IT7boU+JXu9BePjP4B5pAF+vRjnMwa3djDuv7?=
 =?us-ascii?Q?D7QMB63MzKcvy1shl8zKdXVSZmSqQyeFUWxdy2ZLnD+RvMdiDCBmnBx7BCM+?=
 =?us-ascii?Q?satEsWhTxMEiXfP48UIXu5ZiW33t2pTLit0hQvG08FodIwuQVWyekI/m2l63?=
 =?us-ascii?Q?eG3jaCHQqZMGUcmuDZ/JezLjv/GshSgtqZ2HgTHo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4404ec3e-8a56-40c3-093c-08dce84a11c3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 10:06:40.5564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izLajfMRDfwCZrEkAPxM3iaZ8WE5BjLMTzTJ9JMPAC/tQS0z2D8cb3io3YAeHrkqwXROBdh+7fyKQ1dgY/R7iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9933

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
 drivers/net/ethernet/freescale/enetc/Kconfig  |  14 +
 drivers/net/ethernet/freescale/enetc/Makefile |   3 +
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 476 ++++++++++++++++++
 include/linux/fsl/netc_global.h               |  39 ++
 4 files changed, 532 insertions(+)
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
index 000000000000..b8eec980c199
--- /dev/null
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -0,0 +1,476 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * NXP NETC Blocks Control Driver
+ *
+ * Copyright 2024 NXP
+ */
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
+	if (!node || !of_device_is_available(node)) {
+		dev_info(dev, "Device is disabled, skipping\n");
+		return -ENODEV;
+	}
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->pdev = pdev;
+	priv->ipg_clk = devm_clk_get_optional(dev, "ipg_clk");
+	if (IS_ERR(priv->ipg_clk)) {
+		dev_err(dev, "Get ipg_clk failed\n");
+		err = PTR_ERR(priv->ipg_clk);
+		return err;
+	}
+
+	err = clk_prepare_enable(priv->ipg_clk);
+	if (err) {
+		dev_err(dev, "Enable ipg_clk failed\n");
+		goto disable_ipg_clk;
+	}
+
+	id = of_match_device(netc_blk_ctrl_match, dev);
+	if (!id) {
+		dev_err(dev, "Cannot match device\n");
+		err = -EINVAL;
+		goto disable_ipg_clk;
+	}
+
+	devinfo = (struct netc_devinfo *)id->data;
+	if (!devinfo) {
+		dev_err(dev, "No device information\n");
+		err = -EINVAL;
+		goto disable_ipg_clk;
+	}
+	priv->devinfo = devinfo;
+
+	regs = devm_platform_ioremap_resource_byname(pdev, "ierb");
+	if (IS_ERR(regs)) {
+		err = PTR_ERR(regs);
+		dev_err(dev, "Missing IERB resource\n");
+		goto disable_ipg_clk;
+	}
+	priv->ierb = regs;
+
+	regs = devm_platform_ioremap_resource_byname(pdev, "prb");
+	if (IS_ERR(regs)) {
+		err = PTR_ERR(regs);
+		dev_err(dev, "Missing PRB resource\n");
+		goto disable_ipg_clk;
+	}
+	priv->prb = regs;
+
+	if (devinfo->flags & NETC_HAS_NETCMIX) {
+		regs = devm_platform_ioremap_resource_byname(pdev, "netcmix");
+		if (IS_ERR(regs)) {
+			err = PTR_ERR(regs);
+			dev_err(dev, "Missing NETCMIX resource\n");
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
+			dev_err(dev, "Initializing NETCMIX failed\n");
+			goto disable_ipg_clk;
+		}
+	}
+
+	err = netc_ierb_init(pdev);
+	if (err) {
+		dev_err(dev, "Initializing IERB failed.\n");
+		goto disable_ipg_clk;
+	}
+
+	if (netc_prb_check_error(priv) < 0)
+		dev_warn(dev, "The current IERB configuration is invalid.\n");
+
+	netc_blk_ctrl_create_debugfs(priv);
+
+	err = of_platform_populate(node, NULL, NULL, dev);
+	if (err) {
+		dev_err(dev, "of_platform_populate failed\n");
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


