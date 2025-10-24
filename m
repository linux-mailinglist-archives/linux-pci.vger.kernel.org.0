Return-Path: <linux-pci+bounces-39227-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E2BC042EF
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 04:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB293B1795
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 02:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE352E63C;
	Fri, 24 Oct 2025 02:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ba7Z2sEX"
X-Original-To: linux-pci@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013000.outbound.protection.outlook.com [52.101.83.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4782772639;
	Fri, 24 Oct 2025 02:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761274620; cv=fail; b=JdnBXE1gh3kHh6H4Ycm07CL7V/iyNpwttFIS/4wGlDeDENxP44iL4284kqhK9eVDNwuOcDvXnSzuED1y3ffbmzeUxjA07Ml/HQYvdVtm3JbW6v5/wqyKH7vTcZHGbSCCaeYF/VSy5oM0AlISB2jr5B/5LEVC2H61lwxcnE9wC6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761274620; c=relaxed/simple;
	bh=6DoNpc+ucDjsCcUmT/7K8UXvOVBQ6xWbvDe9m10GdIs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=K8MDB8TAbBAR4SbuSW9wVWL5vjXn3VVRZuY4HD9d4noEkM/KEnOdpKUBv8U2AjqQvWmvqMj/Glm3RB8RU0sKXzmNpTyms1al8fqmbDvevcwA/9NYh0jsOhQ+r+ufzDuysj/HwaGU3XMt0ZFAKp8SisKyMI/afgV7B1TjMAyRmKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ba7Z2sEX; arc=fail smtp.client-ip=52.101.83.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dES1ShBlDkW+KK4MtmJJrvxtDTl0b8/JXLOFMCIfbtt0jDsniK9s0fFBae3nPj+ZJ5g/58r6IrLe8ALDlIANISl318EvwvEapyvP512vAlJS6O+uC2Z3sIJBymuTHYKYYBRmQ/mQFeqVRr9JfDI7QRWSdOjTZHErXkkqCJdDEodZ1eAV6C14Ajx+B7nIu1l+eDjjL3OUrBZqS55ffxFxv0QNRetZKyZL88jy16U1me4r/1Ou0YwFz//QcmGHNSKJspuOclwzCMVCsGqheReIg5TlQ5PadYZCJqZrK01STLkjyXvN16Nr1xBZdoFnaKsJhOLpok5wCHlWXNwjzRvlbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXuW8IYR63LGxEoufULUtSz8wEwORl1p1Lw1yJ94h3M=;
 b=AC2Jywj9CJZqDBcQ4+hDchGpbkqYAu6EF2v21ZJ+g4TzGbzAXTZAIURbfbeVKu6R6CNbht5ovZwzHGTVMWihW8S0ozfrMr9lFsjE1TnqRa1PNyylMmc+31TlnAv3OH+jBud46AqaYu18pWC8tq0r3MNCsTcMJZTgz4qZ7mb3AvhAQqkcJukY+o5lJSCNnd4E34KqLsLasYjyxNK72vsrU04EAKgMNR2MTJ3/xGZsMkNpNYWgBfR4MvoV70lWFIf2uMf6QPuxGa7tUq08iD0W2nQcF1YWMKikHHW5iPN3AzvClRM27YxhpaFz17qTlNfqMiL2Kod9yPQQ9o8OFRTD5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXuW8IYR63LGxEoufULUtSz8wEwORl1p1Lw1yJ94h3M=;
 b=ba7Z2sEX5wwYO/hIWe7jZC5ZUeJuEA/MKpn39ysskw14cuUnVKtrlmxcoZw3VdQqOBAUh7g4w0nLRsRlXnjFkz18GuNjyJrO8vGW6wilW1EKjop6dXoy7oLIVaQMmk0Tona6Z0YrN/pn5F2QycsEY3x78ekfDMKnjg9uXknPl0u523eTKcvoBeJ5Xwnt8xaCjF0wv8wn6ws0tR5nhyV2ippch9yhA+MKOyJUIj9sH+qJSUreQqcjxy/cxBDfEJ93uKfwl6jBtDtWRHle3ZRn4xwh4jugDxjWxb77WjFiPa+HR7eg+5blXHBK9XWimHmDm+NgqOIb1eAwcfBG2NgB3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by FRWPR04MB11150.eurprd04.prod.outlook.com (2603:10a6:d10:173::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 02:56:55 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 02:56:54 +0000
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
Subject: [PATCH v7 0/3] Add quirks to proceed PME handshake in DWC PM
Date: Fri, 24 Oct 2025 10:56:24 +0800
Message-Id: <20251024025627.787833-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|FRWPR04MB11150:EE_
X-MS-Office365-Filtering-Correlation-Id: d225d1c3-d9be-4870-8f24-08de12a8fd09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|52116014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bm8jGQdROCRGMlg0/nuJz1ukIU1zFomNZIBA4cv3FWlsEI0DzMLw39WcqooQ?=
 =?us-ascii?Q?7jb7YIvp2VoPmG8RdG9HtLgYW6YzujW02/zM2BbOxMSywUzRDxMw8nGDw97u?=
 =?us-ascii?Q?u7wFyGX0r5RcYwrMGKOjZahKMPXg4YJPlX8SnaTvbMq38EPxJ5E5glqg8WRK?=
 =?us-ascii?Q?IjFKDjha5aOp53bM6T3Fa7OqcakyOqEfJD9seetYKEeMonmdVebpJdLTiDNX?=
 =?us-ascii?Q?vrf2S0Pf2bHUY+ji+e9k4vUFP+abc+wgQUhv6r1nCVL4lBh6euboviBgb7Wq?=
 =?us-ascii?Q?EKxiRWrCYOMAL0OMCV4FPvEsZY39zDQFy/6wofb73aT7I3Atdpa30ftDficm?=
 =?us-ascii?Q?WU6EMlGgdeF9Qom5uTKfnVu8wSA6Awk9nTG2nyddI8aKxmwkP8inmFATNINU?=
 =?us-ascii?Q?EvEnkd5ARYaT9IWkXwa67n2cE0dk2w+jgB48etmzwxfd8QhqvWJspRNN9J5z?=
 =?us-ascii?Q?/OCgKZCJw5EwgM+Eh3SxnyxNgZeWeVMafvslRlyqhT/uiU27rlbofoAOsPX8?=
 =?us-ascii?Q?Kv6qfaKWlrcYFdu3jqVR+o8QDnlt3nJe01oq+Kz8woAj1mPsO5rEvZ0h+4dB?=
 =?us-ascii?Q?Vr8OYu8ksEFBmcHo+72zb6ePMbx2UQy4+0MCsejuAESqspw4vguomAC7hKq2?=
 =?us-ascii?Q?I6jIhRL9tbBgyZFMT/aOkQ1oLIvL+8+cAKBkspu6Dz0klVGkNZnDNiGDAjln?=
 =?us-ascii?Q?DjYfsAMbJLF3RwiZuhlyODWPY5xystdvdiOMP+qXVsyQDv0TJPoUCYN9vaER?=
 =?us-ascii?Q?wqxodgBjHngztTqRevWift1er405RHknfwjoBRAorqOKuHN4ubPRLaieY+vy?=
 =?us-ascii?Q?lSA20NGSoYuS9vg1f621fLf6Zq1KumMQzVPRIZ1ZTsY/Ij9lMUoH8CDOf37O?=
 =?us-ascii?Q?5chyGN6wAYH8nkT/NFodz45k5PY7UahsWFveJ1RY+eeaNp3h698Ni/hIL4uM?=
 =?us-ascii?Q?STcbhY5Cz/u+wxKQy+nOpK5wTprtE1gOAdIODwo67I1puQ9kpShBTkDrLP/l?=
 =?us-ascii?Q?CPZysgE8PZ9zIh5PoNSh3cdEWr9EHcrUzlO7fr4fdbAbCQedlMaqieFROq+1?=
 =?us-ascii?Q?yGWfguPayGe1L1McqhSMCqRlYAQgs/DdzhoAwiNZqfEC1+ZDCA292+DcWjS9?=
 =?us-ascii?Q?Q0hPQZiEqBc3iy7XpIuKgDWhrOdzDp9QOA4mjjaVpU6tMzZ98Saf+GIDYeTE?=
 =?us-ascii?Q?Ax+YjLanHifsnARQUegSslbG9GW0gSlT8KeT19WbnluJGawtMXRuavLGftEE?=
 =?us-ascii?Q?fJRTfknGXvALtpY/0hyJMCityOmLioWAken6bGqqkDELER0U1bmPGKTDdKsz?=
 =?us-ascii?Q?MefC7UTHAhG3N2RSbyjM/k7HFsHL4YsX87aGIvuk/pedQARHFTpJA3SqVemg?=
 =?us-ascii?Q?fzkIuL2nzqDLI3YSgD8lrb+OX6wWf9sT7Pq+dHCYlKJQEf+9nx63p56KCF7x?=
 =?us-ascii?Q?8FFxzjxxfOAKYpXzQkKdHGCR1mb5psC1Fufm999wfSpTbJAJ8na/WxJtvf/l?=
 =?us-ascii?Q?ZtCaliOmZuyrOZgyTM4GsxVX4J3STwkOl7AmT8fwWRoRl1Pcy57CyzVkkQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mieX6ntBCIkR5sMF1iZnLPOMxou9YdYQCmEYp0d/glP1QTpXiHSiCVd6uchy?=
 =?us-ascii?Q?17O8XbZxkKMoQqD2h/XqvIIYh+i83ds9crEIV+qWxp4IgCjTRAIYX6I2HQMO?=
 =?us-ascii?Q?eJ1+TCGwM1oYNdshG52kkbsNDhyYN0z0VcpuZZE9dwMQ9XR60gLD37U/xb9I?=
 =?us-ascii?Q?IlJKBrhuRCysPRwF92KE4cNzQImZzfwh5o0dNEOQQp7xf9zJg+V+tlBBoQSD?=
 =?us-ascii?Q?eDno3b3H4oCNmbX0OBmsfU38QIT/+x1LhJ5JrFG4Lc9SfCMqzbh9vGyrM5RC?=
 =?us-ascii?Q?CsNkava9y/gQ+S47TLCjGG+FliNzjZPu1xU+20bpo4t+0i+PExvmDIWqqZOx?=
 =?us-ascii?Q?r1ADs6i8nUHDbH6yH/FDIjkaRfGPeRs8WDAM/KaP4SF7yHfVkkgq/yK7r3OB?=
 =?us-ascii?Q?E+jmnPqi6GmLj0evnt+iIcHalb9q3l9t+1c2WmG/eDCeXO6b4Vno3Y6LZOxU?=
 =?us-ascii?Q?I2mXdzlr679QtVemyfY4KjRBvXotz7AC4SF5Dbk2IBylQHZX9JexuIr95CRT?=
 =?us-ascii?Q?6OfQcSzjefJXIwzVGP/yi0rXZ2bPLYd+Y+zFR6pOH1mY/fpyobAdMK3WS8p2?=
 =?us-ascii?Q?obnx0d+eOegERcq3ZATnn56mo8kr9xgFrmex0OxBEvgXnDElI2WuNQPcfuWV?=
 =?us-ascii?Q?ne8xSCFwkdyyHt+LBle2i0CkXTx9/6ysQS7NiiQoK6Mu3epfFjBQicT2vdb1?=
 =?us-ascii?Q?d47cr0gbkDnDuwE9NX17nTQfr21wVsqm7vUc5E4Xfr4BVYYkW7SPTySyzNZh?=
 =?us-ascii?Q?BKn+7qXSZE+JDwxINK+XvpknidUEfKLOkd1iD0Eex5N+ed4hmpysil5dR9QQ?=
 =?us-ascii?Q?1MWgBj7O8rXKrbTs6whj8IIBK08efbSIMegjE5Eh7VLa6jT/1Lq2WZSTzILh?=
 =?us-ascii?Q?/1vJjhremSDf3IZJH0N8dtjzAq5kFdpJ53YETORfNHh74ZTbWQ1V+nnP+tvu?=
 =?us-ascii?Q?VT9MyrDzUXHKAxyq+eF4OgibLzTzNqGFp7ZYLi/QkvBBY1Nc8DYX8ruHPWmG?=
 =?us-ascii?Q?RH9Q8MzBJ8VQ9p0jShb5RIPEgeF7kywSCJtpoIwywHMuSiaoP69lfsODG8Xt?=
 =?us-ascii?Q?65t+0nq4TGnPQAZFbiRqhJJvKBNXRmBt1teSTuzgp77X1yQA3fgtqfQMU6yY?=
 =?us-ascii?Q?1Q8BQsIXMhPc2wKC1sZpd/iCTa5TiOrir4u3SWosj+bZdcfepzPUZ96OeypJ?=
 =?us-ascii?Q?hdHeMq7ih+vJ70J/dOsEGz3Tiu2DHZCJHskQ7qbXVhMK3wbjDf5rTF9OBo4m?=
 =?us-ascii?Q?a2hbocGA2uic0pZedBbYmGKL/FdWvAAfr4/We4juasYkDNo/umW5NJSKvBwM?=
 =?us-ascii?Q?eDCSHKKuzXxl2utP2tXM/PoD+znpWMbzBN8NCBMmXIDX07ZeE53wcWwIe0Xo?=
 =?us-ascii?Q?8YOPv1oO88Xj9a+hc+JGVVEFdv5vdA0Ug6GVPn0df7ROelUn4n7fFWCZ7pox?=
 =?us-ascii?Q?6r4U+el7UdANWHSaey1c36skc3HZ3EslcaeDXgQlEFod504Z502pRp+wKcl6?=
 =?us-ascii?Q?telJpIhgYXtpp0cD7QDdJKCjodJ+i+jamRj/pmP3DQmBX+EsRwIyA3eTu1iZ?=
 =?us-ascii?Q?btHBLjQs4UlOtJplhmp0QpgvAhn46Ol10p23RD7H?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d225d1c3-d9be-4870-8f24-08de12a8fd09
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 02:56:54.5174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/iGAQavRx6G8ImmL9WqPBCC0cv+jOByvMDWL+oCKftMiNfDGKwH8dJLNeOshNuH4hg8HLrsxZYIDcCcsm4X4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11150

It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
PME_Turn_Off is sent out, whatever the LTSSM state is in L2 or L3 after
a recommended 10ms max wait refer to PCIe r6.0, sec 5.3.3.2.1 PME
Synchronization.

The LTSSM states of i.MX6QP PCIe is inaccessible after the PME_Turn_Off
is kicked off. To handle this case, don't poll L2 state and add one max
10ms delay if QUIRK_NOL2POLL_IN_PM flag is existing in suspend.

Main changes in v7:
- Rebase to v6.18-rc1.
- Drop the first patch of v6, since it's not necessary part of this topic, 
  and it seems that more evaluations and discussions are required.
v6:https://lore.kernel.org/imx/20250924072324.3046687-1-hongxing.zhu@nxp.com/

Main changes in v6:
Refer to Mani' comments.
- Update the commit message of first patch.
- Squash the 6-3 and 6-4 into 6-2 of v5 patch-set.
- Add the Fixes tag, and CC stable list.
v5:https://lore.kernel.org/imx/20250902080151.3748965-1-hongxing.zhu@nxp.com/

Main changes in v5:
- Fix build warning caused by 6-1 patch.
v4:https://lore.kernel.org/imx/20250822084341.3160738-1-hongxing.zhu@nxp.com/

Main changes in v4:
- Add one patch[1/6] to remove the L1SS check during L2 entry.
- Update the code comments of 2/6 patch and commit description of 6/6 patch.
- Add background to 5/6 to describe why skip PME_Turn_off message when no
endpoint device is connected.
v3:https://lore.kernel.org/imx/20250818073205.1412507-1-hongxing.zhu@nxp.com/

Main changes in v3:
- Adjust the patch sequence to avoid the build break.
- Update the commit message.
v2:https://lore.kernel.org/imx/20250618024116.3704579-1-hongxing.zhu@nxp.com/

Main changes in v2:
Add the following two patches.
- Skip PME_Turn_Off message if there is no endpoint connected.
- Don't return error when wait for link up.
v1:https://lore.kernel.org/imx/20250408065221.1941928-1-hongxing.zhu@nxp.com/

[PATCH v7 1/3] PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM is
[PATCH v7 2/3] PCI: dwc: Skip PME_Turn_Off message if there is no
[PATCH v7 3/3] PCI: dwc: Don't return error when wait for link up in

drivers/pci/controller/dwc/pci-imx6.c             |  4 ++++
drivers/pci/controller/dwc/pcie-designware-host.c | 56 ++++++++++++++++++++++++++++++++++++--------------------
drivers/pci/controller/dwc/pcie-designware.h      |  4 ++++
3 files changed, 44 insertions(+), 20 deletions(-)



