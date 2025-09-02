Return-Path: <linux-pci+bounces-35303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBF5B3F76E
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 10:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93E0F16516D
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 08:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D27246778;
	Tue,  2 Sep 2025 08:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ivf0Ofpw"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013040.outbound.protection.outlook.com [40.107.159.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549C91684B4;
	Tue,  2 Sep 2025 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800157; cv=fail; b=bUmGS2usPJzoSndC70B/qpSJj2n7bvRGoBQWmsitK++IUKUnBnLQpguTfMDnUV9qSM1fVwb816c3YxF/DO7r2HK7316y6Yo15fDydxD8X7kx382xY2C9hnuxAv8O3cURNh4w3KqtxBsU8Q3x/DGQH9XHz2bGk9ZaSMfyUl3v+TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800157; c=relaxed/simple;
	bh=1WKIx+bmfferhoMRFmpnmHPhaGm4xqu4GUG424h9RnY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=umBf/MPW0KVH7SS9x1bDTBDOr1buueq2z6/8UrYqCCSePL7o7Y3NhGzrutoSFh+byGiZlYoLm3qeXkAkZURpQwJedimMzXI26wFTVODTK0Rb9+uTMQ9w0xmrqBgtyAuvAWGi04gjs1FAp9y2a8BCCj4AAXoYjqJgcv4q3IvPrzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ivf0Ofpw; arc=fail smtp.client-ip=40.107.159.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWjBhoC+E3E5Eb+YzjP2+p/kTZWESHpXPdCzrvxhtPVW48Kf3jaPzh5EDds9qE3tLUhvJVRpFqtWZZ9Vs/no48t/gmJgnruXQytQNApA0PY4CL/uCT4fQd6BeuMxO7BHNIW4buGv+nJW6prltZmbFASZCQGnfVIRIkVhQhjk2ulPaiUqsSaOCwgd/VNcxUwqgkjBvaFcuScVe0djnfBwQZwc8nlX2Kwt5cEOWLKBFUiTIzDQHeu8bBZ51ixvSDlRqGH3EFCuj+8KhbKW0ukM847BEq2l3PGa527ymWka8kuA5gyLUPyk1DZ6AsPXMJaAK4miZh0/LEMWVNe90hyj0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLiOlvkpMCQuutcpH2G92mwDAaId4H1HJTOeDXHtHig=;
 b=v86aJMZGS3eFNOByVhYwnSFg/5VKi6ABgGPahhkeaF7csLRB1B+AtPHhOcZfx1I7hyk9hFkeQlSwWEB9G4LIkibM41LTI3eG5HyyCMTkAnu5nos8+udYStaY+Wtb+5CPUwuysYnGcOAj0uj8M4ALm9Xl7DSBOk+DuT3vHr6t2xL9Na8YZvJaX+2eUnBaqMPWrdpKeoUAu9Hz02fHD6EFazxhaw/xfJFg+YSf5Bbq1kBOWWrYPOB7g/+l8TFMADXFRgSPF4O/8W+YmEet8MyEWXV39PkTHuKNIY7xNinp2nCA30W23jhUdRCjIXFi5tyqZFFEtH9wSTxijpzpLOm30g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLiOlvkpMCQuutcpH2G92mwDAaId4H1HJTOeDXHtHig=;
 b=Ivf0OfpwQOTQaC+kcqYUrQhIlcadtgRY6thDRvxKU1Bjv3G18lzkV9i2O/o/UljODLA0onubzMy71kCpkEvOEf1ZZ4nwWTT2fbndzFK+UqWH3nWrH4zT6OtnR1H5nl/N8vLFG7QOuQ5HfPj76+USQKxJFjguCSKt/H38N1BAkH1pd7GAItdMboOfhsSQ/Fpvd3b6vIA8Nxt6ctrBLIc89lrBODoDrCBc0bilUcHY2von2vm39MRQa2eb/GzqafY5aNKppjab0ynnLCFdaHgv7Crxcfd4hMLJSeScylFiWTTFUqelDTrab0E2RBHEu0hRAOOBJAyom73dvTqY5ugNKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by VI0PR04MB10880.eurprd04.prod.outlook.com (2603:10a6:800:265::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 08:02:31 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 08:02:31 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	jingoohan1@gmail.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/6] Add quirks to proceed PME handshake in DWC PM
Date: Tue,  2 Sep 2025 16:01:45 +0800
Message-Id: <20250902080151.3748965-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0087.apcprd03.prod.outlook.com
 (2603:1096:4:7c::15) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|VI0PR04MB10880:EE_
X-MS-Office365-Filtering-Correlation-Id: a97d3322-d8c1-4c21-6bb8-08dde9f7110e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|7416014|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NBh3msVcG2KzI7EOfUxhFhYCP1dip0jPmHXJsqGJhpFK3wFtTZqJAxgp/U7V?=
 =?us-ascii?Q?SBPDW9+0MODu/b8++7UXDrWUUBC7XD7EwX4TNZ1VpuB6nIGtHO+9Rjsp72jp?=
 =?us-ascii?Q?on+cjgT9xWVdH1SmYT7OS2zOirFhZpuk+9dBOPR5f1GFPtCLywReChHKhbuJ?=
 =?us-ascii?Q?cShnhIaLPj+MaYtUtjQgwR3s/zje1JzdiubeG7OVHnj1r0S15icrC0Ewv5zL?=
 =?us-ascii?Q?R1ujvu9ihCmSaomytTrlzZydcV4G0yMzp2vDRTcBWQgFxXltJ/f7RWH7+e6j?=
 =?us-ascii?Q?KHjmc7B9rtILR+r59+INS6VrF6PwTwAQFe+BEYET9G1sTYwJci9hGQuhdpQz?=
 =?us-ascii?Q?SpnWmBjKdrvB7XpDRCG3+0YxjXQ0ziLqVSCBYFYIcW+nsmOfMzsZmm8aucDl?=
 =?us-ascii?Q?6/2CqdPO7oLYZR1yqQB8NSF0140G2jQrLOk9A35lXBGcAsYb9/dPuK28vSeS?=
 =?us-ascii?Q?hWvI62PcqZm/jOvlcGKSV9MatdNulCdirALagStrvV2VuBrr2iiW/4gw2zdf?=
 =?us-ascii?Q?Wsq+hlWNzFM8rKYIxgaiVwrcVQyr91CB9UZ14NScuzDQpb7w7jEP49n902RR?=
 =?us-ascii?Q?uFzvQOSm3BUTYqIclXMY+Fps+AnAMr2LhEnWivlNlb848gzA8iGbQFn61Rme?=
 =?us-ascii?Q?tq/0H1dqbE4p9TSG8nPtb/ZXXPVqQ9+UlEtQc9Z9hm/5pq9PUB7PwZoNrG/n?=
 =?us-ascii?Q?rzX/k1Dq+XOXP24WJyU6lTONk6c+w8ddIq0mhyW0N2VHmwW5ciw55idSRs+D?=
 =?us-ascii?Q?Ek6hm3fT0wdeib5JIDI/K/kHHlywjrXpS6V0qn7c0TQ99+uqnjv6zy5Pe6Xn?=
 =?us-ascii?Q?iHgOWbogqDIwY2zx31c8ir4iDOjzesHSE2+Ca5tQXqD88whNUyqDHR2l/Qyv?=
 =?us-ascii?Q?IoUrb6l00WzCf+nBUZF/28VtnCQU7bHiurLfp2JshLfgvKA9OwFlxVHUrFgn?=
 =?us-ascii?Q?N74xNvKj50cCJg4awyboNsy/z3HsAIyFrK6BA8C4ytz5Xl5QR/b9YMgaDKrE?=
 =?us-ascii?Q?R7rxmLRUncwG2cdBZM4N2hkCGlL+17G+ysct+LwxPKchIZYPAr7SN07k/Ypn?=
 =?us-ascii?Q?u4KMu3tT1S7G1UqeoM2n/UCxoRGDnr8cU8JzKcQIpDQXH9T9wgR9651ebytI?=
 =?us-ascii?Q?MAL7x6lF2G+iPwGcfC/VePlOJze85Yg4wldy3NeM91IXAJs3aF7jYQBWQpOv?=
 =?us-ascii?Q?y8wctsQSRI4tew93hJ0d8FWiwjnS+wdXgtU4yrKP07GgWuTPSgg8Op63nLNj?=
 =?us-ascii?Q?VCgEwqOXI13I9dXn2mzaBT9TPoY4tZ0eR+qqr9UR3IvMspGLd/u8mNwJzssg?=
 =?us-ascii?Q?T+5KFwvh0YuyVwRPeCHxlM09S+xQNRyFDkSDc5+XrHy/MAoD5O+pXiGKjtzU?=
 =?us-ascii?Q?qCw0guVf/WonGxj3VVNlCopNEOlf66mUoi4ShFaiMcxDNOh6PlJwq6pvU1yk?=
 =?us-ascii?Q?o8id10ElRcykyqqtjaoVWJ9kWZjIS0AwOaQUimLJ6jrBZXsJlhCnNOY3aVwm?=
 =?us-ascii?Q?hebbEZpCWIM6woRG+J+GZZSlP3bxyTxHG7B/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(7416014)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/KA+5l66s9lWwfWfaYHt3vI2R8dLfoXfXPqXQj0LwdjmfzwR/OYSMSY7Thty?=
 =?us-ascii?Q?EtjDTmTXGxqL0D6wqcLzKwbTeeTR73PHSl4kQWKlvA+vwz/5pn+kpReT1reQ?=
 =?us-ascii?Q?BEi9rIVL9HfRDF4nSDhZUp2qCoDfpziq5EC7qSLMGssZWvBsPRkXr4EDXZP6?=
 =?us-ascii?Q?zBIzWFIKKGnsU+wjwWSSUU2YZGuDagnMOB+f3YsoYgqA3QcTkYuDE49J2UeU?=
 =?us-ascii?Q?wKimFiYmiLzRoZArnloBzTVeT79AeaooKkhlFrDCY5mt8M8r3xM6VggaOiS+?=
 =?us-ascii?Q?M9bMZuchUHBFKu9JWiOpHgHvouf5z5+cNTnI2ckNlMAunYnok031nfTrLVlH?=
 =?us-ascii?Q?9NLS0FzBr6cDIgskkiosPWymmWlOeJUK7cRoSemj/uBf0DXWvMv0kHenRenP?=
 =?us-ascii?Q?CyPfBZlWg//aYqkuu2OFPrIEWeQfFqguAYzr79Vw6LxG/A7MqnwFXWU5eSGg?=
 =?us-ascii?Q?r6A3vfpgAhrb16JmhgLguo/xBDYkIrvBVbRmvP9ohrnHUuL2Qc2wCEzeHVnG?=
 =?us-ascii?Q?g/mOL5+iu9J/FOZ161THWgXJtbhbMks5VD3HK633RBylV8niGsbfyKZB84Qz?=
 =?us-ascii?Q?sBw/5AYIpPRZoyB7JkwqC4ilgE51Vomycv8dhcu6G1SAHPa21bhqB3ydyQON?=
 =?us-ascii?Q?hB4yx4aWtqvBRFaHx1A4peH9hRTbyU97ikvoPhjHIJxNfUHoa5ITl3YeUPEe?=
 =?us-ascii?Q?6ubd4c61rgFiPyzu2TRjGFRTnvDJfzolrvGNP+sED4Iy8xSHm5prPAsjx6UI?=
 =?us-ascii?Q?sGHWIk1g2AWCnUzUiPeXFCUV+U0gfrK6COgqzOO1iYqCud3+v/dPP5Trne+S?=
 =?us-ascii?Q?eWqHRUsmQ6bVJGYjfsGaagsOz3ZTXcjc4N1SMf+6WcedLuADwRJK/qNv00Qp?=
 =?us-ascii?Q?0NEtjEOJTVwm8miXRud8Rm4dBNEg3JHhFTCAX4a8QNChgdQ0qq21cibZYSPN?=
 =?us-ascii?Q?7JyLBYAoeKCDQP5fI6rvYRsg81PEs38XtNJPU+BRldT4ddp2tMkahG/x11zU?=
 =?us-ascii?Q?GRiB1Ht8EP/0rY01EdQCPLIBfIsycdTY+A3VCEPzJ+UapOo+RiSLEs0c6ajP?=
 =?us-ascii?Q?2EtZVlINRrHPpGpbwYngnBdxVnvUBagFUnQgvVRw/qrZ4x7w7fKY75PYijNx?=
 =?us-ascii?Q?oD/83DNgx5y4tzcmg9tnmhzzIOKbuVS3aSfio7OiV2BggqPthwRu2tGq/2AP?=
 =?us-ascii?Q?C2i/M9lGe0q6nwwthA4iLYmOyDXZRFGfOHURFGehx+24LC7H/VWII7NA5JxX?=
 =?us-ascii?Q?tQm46jL8eIOtkJEokVXr8DgQUUKM2cI/8eDfxZ4D6ZDNkmzn88b4rE3Ye6E+?=
 =?us-ascii?Q?GCmZ35vzW/Wr7u+crY+Nx6B0Qnd+WJVfgfSc+Zor/kzsgEld3u78XhBovgnL?=
 =?us-ascii?Q?MeovWQpPnLW0S5NshAuclxnQzeaW7gn4OM6mXCyJGxY5MQ7sSMTrvfenMmqI?=
 =?us-ascii?Q?WTqwZDty7/orDvp38pp3q4CGMZQWRmCAYSwRjV61a+KVPJwJyUvlrtpvBoi6?=
 =?us-ascii?Q?/1mPbTkwGNfVKIWcMekaagUqagQ/QXxo/qd10Tug1dDaje+KQlHtQPuzCWdL?=
 =?us-ascii?Q?Qwb/qqIHy31wNeBFldXPyEzBWg11lpbYtjzq2mAR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a97d3322-d8c1-4c21-6bb8-08dde9f7110e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:02:31.2224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RE5ZPfnh3fya+QrqmQukYc5xgTBJBAWDslDDWRHUoINqmUBXcE4J0rAVYPtmC8kIhK/6omVGQpMMOLAoK42yrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10880

Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management State Flow
Diagram. Both L0 and L2/L3 Ready can be transferred to LDn directly.

It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
PME_Turn_Off is sent out, whatever the LTSSM state is in L2 or L3 after
a recommended 10ms max wait refer to PCIe r6.0, sec 5.3.3.2.1 PME
Synchronization.

The LTSSM states of i.MX6QP PCIe is inaccessible after the PME_Turn_Off
is kicked off. To handle this case, don't poll L2 state and add one max
10ms delay if QUIRK_NOL2POLL_IN_PM flag is existing in suspend.

Main changes in v5:
- Fix build warning caused by 6-1 patch.
v4:https://patchwork.kernel.org/project/linux-pci/cover/20250822084341.3160738-1-hongxing.zhu@nxp.com/

Main changes in v4:
- Add one patch[1/6] to remove the L1SS check during L2 entry.
- Update the code comments of 2/6 patch and commit description of 6/6 patch.
- Add background to 5/6 to describe why skip PME_Turn_off message when no
endpoint device is connected.
v3:https://patchwork.kernel.org/project/linux-pci/cover/20250818073205.1412507-1-hongxing.zhu@nxp.com/

Main changes in v3:
- Adjust the patch sequence to avoid the build break.
- Update the commit message.
v2:https://patchwork.kernel.org/project/linux-pci/cover/20250618024116.3704579-1-hongxing.zhu@nxp.com/

Main changes in v2:
Add the following two patches.
- Skip PME_Turn_Off message if there is no endpoint connected.
- Don't return error when wait for link up.
v1:https://patchwork.kernel.org/project/linux-pci/cover/20250408065221.1941928-1-hongxing.zhu@nxp.com/
drivers/pci/controller/dwc/pcie-designware-host.c

[PATCH v5 1/6] PCI: dwc: Remove the L1SS check before putting the
[PATCH v5 2/6] PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM is
[PATCH v5 3/6] PCI: imx6: Don't poll LTSSM state of i.MX6QP PCIe in
[PATCH v5 4/6] PCI: imx6: Don't poll LTSSM state of i.MX7D PCIe in PM
[PATCH v5 5/6] PCI: dwc: Skip PME_Turn_Off message if there is no
[PATCH v5 6/6] PCI: dwc: Don't return error when wait for link up in

drivers/pci/controller/dwc/pci-imx6.c             |  4 ++++
drivers/pci/controller/dwc/pcie-designware-host.c | 62 +++++++++++++++++++++++++++++++++++---------------------------
drivers/pci/controller/dwc/pcie-designware.h      |  4 ++++
3 files changed, 43 insertions(+), 27 deletions(-)


