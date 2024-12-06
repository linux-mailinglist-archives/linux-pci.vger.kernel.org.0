Return-Path: <linux-pci+bounces-17871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7A59E7BB7
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 23:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AB2828538E
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 22:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7651F667C;
	Fri,  6 Dec 2024 22:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZGqpcpyK"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2058.outbound.protection.outlook.com [40.107.105.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F94622C6C0;
	Fri,  6 Dec 2024 22:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733523954; cv=fail; b=CTEadKgeJYUjl0CBYY6ETbt8x4dcqqJyq8EaspbiQrCXkfPWMd1JYBZAh0Fd8t9RSMfar4m1HybQDdoYsF8K0ZVJZrS1e6BP5vvE9x7PjPQKquSFmUTyb7BblBHrX6YGkUoSXib9JmNmnVhUWNnai7qCS9INcE7P910dLNhAjsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733523954; c=relaxed/simple;
	bh=DhFtITstaTP38tNfP1wMcSqWXtF3HT/2uGiWR9Ki9/I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kISH5bGAb/LijCO0Teuv8HLfI4IGpxPMjrUizrE3at4Lf3xl8eKQl/tyKy0UnceYnFWjzSAvRJa12BxPfdsriKJBHVxZxSj8hLt6/trm5Bj1TuR3+r0mCqhBPI21iKpWxJA9xz62NX+JY9JtBpYrjOFnRNu3A/r1aO3gGXe3WEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZGqpcpyK; arc=fail smtp.client-ip=40.107.105.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUXSQ1/p8NQXrPRu5+81+9F4IVYmGUeICEpRDi7vgE7wRH7eD29sILibumm4z9ibWEiYbG4nq0UrBBRHYtfHwQOMaxYqIAzaZKB7PtEY9Dxu5PQisjXidmtWIWv3rcPc2UKvXr5LmhfH538Szt0OZ8ywVLAU8DEuvg7agqbgFlQEl0/nGykGz8PJH/4yJCQU3qtlW3hyNbnaORGYr0b4qz7Cj5aFm7ISbRjDI7Sfl/PFpGavKXRxq2snCPVooGpkFXps+8YHHlP1IPwWy3lOAgQx6lYnUN8u6UqLt1wLNkb/pk8bR1yAO1SuaKbWZhSq9dqAS/cMDG0Bt6DPAQePqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5TChl6I4bXcRz4tbFzepw85qOuiXcLxG8bUpP+DLkQ=;
 b=B7In4OAcY4o/oxRpPtz/YNDvZzRBHzlO624w6fiZoiXYKvDUsHRNDlQUphFjziem1Ts2kaqN7avy6DQFGXCFzIeZAE3PQKpNXwefBpI2ehRl+0UtxBhC+4zhSORCCLaXhvcFM4RYZ7mzX2Zq/bwQSZexdhgUTQEcobEr3qF/+uyaENi4vaSA+fYZDrP+8UUJUfHrbmgooEx27/2SpTac3tMRdPfHnQKyW6QhUYrrW5QC4bGmAb2uasVd65HN3ibc6l2wTEOuNGlyTg9csSatLarJA/WZdHUrIL4hdkVxT89sDms+egrmYdv+ZDxP0IDNoz3KXoo+JrpvNiCIci3ysw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5TChl6I4bXcRz4tbFzepw85qOuiXcLxG8bUpP+DLkQ=;
 b=ZGqpcpyKt8Jppf7UtEvsXGigwYZye1oohpG0i/iph2DQpT8jB9e8fiRu5Bga24nO9YrUIaIU5jH9ZYuQ8/tkAgczyxfXARYmODUY1ATJcqXXCcgRstJ0ikvZQR9rNLhQsbukMAr0o4Y2SQIcTiO759sImC13ZTCM72n/iOT3I4R1j490HEoOQrXSB4xolB1aBhOkLH7JGOiWTv5HN4Ck+4idgh00Yr62kcE40Dq8jL/WCa026w/GOfoRZMs+i6ehxHW46H2bqz63TGsNQeYjlIF6xPRRDtcBqUgL0J9KUswSxOWgTMxIdqwNgwp5o+zEzHO8Fs4jPdkAZYGCREk+kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10128.eurprd04.prod.outlook.com (2603:10a6:150:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 22:25:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 22:25:47 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Frank <Li@nxp.com>,
	linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/1] dt-bindings: PCI: mobiveil: convert mobiveil-pcie.txt to yaml format
Date: Fri,  6 Dec 2024 17:25:27 -0500
Message-Id: <20241206222529.3706373-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0003.namprd08.prod.outlook.com
 (2603:10b6:a03:100::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10128:EE_
X-MS-Office365-Filtering-Correlation-Id: 39fdd058-9910-4a5f-05d0-08dd1644ee9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N+MiUOlyKmYZYQCNM0YRbtYLd6qI7zpxwtH/6OjFpiuVwShXw5R0MgsUus/D?=
 =?us-ascii?Q?m4QYgxyp3FEmyn3XkmUhaUlalRrz+HktjGNIpyUkV7wBrc8M+GlMl+kOV+js?=
 =?us-ascii?Q?MBbkoRIN7vApTCRQlcKZUizDtWNpHgUm+Lgd7zh4JgjySAMFGAoRK5WlGsYd?=
 =?us-ascii?Q?1Helr4umxpxE3lAhKSJDeOx4P7l5FkW2sOlfVyMyvkrif4r/HuiIg9WXkkMD?=
 =?us-ascii?Q?6MLdenCThx6lSthwzer7U/+MAc9o5dcazI4gP/MYB+wo1nLHNUSKywvy278x?=
 =?us-ascii?Q?xzvdn47/WcLGi15btVxEzLwxWDCEWbBqt0O9OQOxPh0s7t44/SQzaBPmO2vV?=
 =?us-ascii?Q?1j1M8V+BKbgf3WCxw6069P2F5zUWrqZ/eglO+j7xS8B58GMVGMY/iQtBOjU7?=
 =?us-ascii?Q?tQiunK29lCTYEGOC8tJiRxG3NtvGEijiM98eZyC22tbBpqJ3T+kooYO6Kovf?=
 =?us-ascii?Q?kpzf8nxGtDvp9cxNKKenrK4LliVS0pffUyBJ5aKjXNLforIpm2a/NXI0zkF/?=
 =?us-ascii?Q?0uXeCd0E8CvMRMOw3TMwCUpSEM3TQVZlA7dVUBisZpa8uqHhsYCfXdQpN9AA?=
 =?us-ascii?Q?HtMA8vDfUGeFBnNsKwaZ4tAHEfpEMC9Aen+aH56Vl8/kJ6G2HOOvqFT1S79m?=
 =?us-ascii?Q?76lBe8m5galOSLBdYJSbUDhc2Dj5bm8c7/ITF3mldi1zvqt8IMwq9ua8+F2e?=
 =?us-ascii?Q?O5ywv3h8lmvq7wOF4YaHJOZRunma/zkViS5BHcHKWcdH/4b4wBk7cohPVzK6?=
 =?us-ascii?Q?EeJe2ScAFUpjIJ4Pr728WvSN0kI15ZQoLLnnbCqIbHtjvJlMsdqgGw2IH7d2?=
 =?us-ascii?Q?6IsepALIG80maC5Ms4Be2Q0nrGG+T7V+1iU+ubJzSCFLVx9xpwPAWsWtDDk4?=
 =?us-ascii?Q?FZ/dXc6r2Q8Tna7Dg0nI3Ri8N0B+kKAka63D3Q339hH1pr57/CSFISmGKIgF?=
 =?us-ascii?Q?yRXr5ZC0mBCcQvcO4OGBcNjunAjzuYKIW6NvMPsNmYVE/t2N7jBoQJDALNan?=
 =?us-ascii?Q?uMJcsd2FuVjXViJGK8ja1JyHd7WJ854YK0ar6oWCBb2v3MqbRD4UMge7QXqR?=
 =?us-ascii?Q?7KP05/Gd0HWP4r7I7Q5nS+pY8mDLeMu1HhTjFYKLE+pI2IhZ8Qay7YuFYr6q?=
 =?us-ascii?Q?VxNtHbb0ASQ0ijiOduLj0vW9VnsLLSC1nEj1vPDmeYmxVlwflmcel0LInYmf?=
 =?us-ascii?Q?lI2Wxy7wHCK7lOImj8tjHjppSUNKCZSJ7cmSXxRZck1b/hgYwVRllfcBV0ym?=
 =?us-ascii?Q?WAHzCaeD1PRg24xJM2GqhL8dMgI0v09sY/qW8nqxU8ar36H1L4Z8gmq+Pqd2?=
 =?us-ascii?Q?aiPnuW7q1tjGiFGnABnGmTh8+IIMU+ZjL1F2k8MeqWirEe0C3WsPLEy2LPVl?=
 =?us-ascii?Q?oID8yx8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+J5qtibPn5LSPA26n+h6GfX+NOC7AQlSxud1QGcoxJtmaEMq1c96NtBezfkl?=
 =?us-ascii?Q?lbqBNvtBXd8PTbTaJQKo7hXDh950s5cyLorY6OD+ViNu1UJ5IfQ6G6d3meNT?=
 =?us-ascii?Q?vRSbVGn7gMfQ1SLetJs2gTR4qj2EIZSNHVjhJCzBTjRyxReKHcmH8oWRm72+?=
 =?us-ascii?Q?Gc0CH97sosuRnXYhVzxeI4gpRWwaDhBvoSUW/1G0X96a0uaChz/MzPdsLSLj?=
 =?us-ascii?Q?fWui5WNva0DVbelMxxqa1g6zRZdC2niAdz+QJrKSjbm9aJCeUVupiz12wgzt?=
 =?us-ascii?Q?4jG+pKNjmlwJHMuelFYiMyS0U5NR6Ryq1ZbkvG7+F0eSPMr5c3t9+aPFebGC?=
 =?us-ascii?Q?Nm/raN0kgnFKWFMc4w1CGkZ4HgHY87OuJkxUikFR0iOYJXkTfrKRIuYd58/q?=
 =?us-ascii?Q?dV0OxcPGPcnNW4puCZI3Vd9qbW7m8izJDTWd/yBKJjS29hfRSeSKUTvrkdIz?=
 =?us-ascii?Q?N9y8GHrhIgooQ7VxTrrQ7bxx6fX/PEECD9YznITW21AEuLBHnc3HKVsfNVWQ?=
 =?us-ascii?Q?ijpB/caf2TGRHHmVYKnlVnTHjgQfOt09+y+suVMaxTI7fPigBjC1nuGnmtep?=
 =?us-ascii?Q?y6nqDMPbwED9Gflih2BaANOb6e27wcHqRKCQg0esnoYQrexijYt0Lxr1gyBa?=
 =?us-ascii?Q?94JmTvjaOScw4Mq3GvoenbYzcQaH5K6dmACxRFP+C0vm4pk/cZxQ1CdPqcPp?=
 =?us-ascii?Q?pXzROsQvdpYmaua1dOi3RsqlmQNGeItpNf+RuLObb3NYEe9zZxL99hIvSnuI?=
 =?us-ascii?Q?A0BivCY3+yw4wl6kLgaxI9vMKIV86EV9Q7ur9HXfzYYiaMGIFldIK9V+M9RK?=
 =?us-ascii?Q?VwnzoI01uZZHBQup8126ucRzo1YizPfM7dtGrZP5BLgFKXEWpBagAR6mRVfy?=
 =?us-ascii?Q?q+vM1NxBZsueAE24ii5e2sZP67Vxkk0AxW8zIwuLCxyDYdQOx5Q87LopNvsu?=
 =?us-ascii?Q?Xfd/fCK69WZsw2JhSJ52B2HSkCFMRIDKLk0J7Bz1eJZvLpd+cQvqNRMIfJK8?=
 =?us-ascii?Q?sN1uMZ5YJ1TrIG2NQ/g0eO9SmB4HvzoLomhwhB81HtDjyEzFCMsoFEKtzzMB?=
 =?us-ascii?Q?t9TheLj5uhHmk+XKhkg4hW9ycqZ+fdVlJfMgIrT+lzZgsaqLCxn9+7rC1Xgp?=
 =?us-ascii?Q?nvarZJJ/kssC9POoq/dnHPj7frynAb8BIBxyyOKCEnsB0b/GnP/nB0okIqD3?=
 =?us-ascii?Q?JsLKztdI1vfaSJWDwPbnY5aiUd34lfa6NWgaLzJJLyywa8gkjhDfnVKvpaTl?=
 =?us-ascii?Q?TC27sb22+bp1cb48i4e7so+/B9pxBo4TmLzFL1otOWziUVZ8EYMFRYF33LE7?=
 =?us-ascii?Q?Tp4qWC0SH/E/f3Q8thS21ecFFYFmR8+cpSSMMIeKXCezmzUHn2APERMk49Z8?=
 =?us-ascii?Q?1la1P31B3yJtWcvNEIfd4p7/sSb8jGsUvdP8Wf65Wo/NDxwEWG7T7wqHVXI6?=
 =?us-ascii?Q?sTOi/3Hj2DWZmS2AErk74uN4fpPDqNE4WsF3e4lTTG4QVfxNmxyJ3ffcXCIT?=
 =?us-ascii?Q?TYcCulgrnq3nmM2HcTo2IafsxMrOP0q/X/Wq3DSN06kzaydFM9KVvx+iJ6Gl?=
 =?us-ascii?Q?lxwXt2vSguCIGQXuEDheg61x5bBNeTAxufs8L3fm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39fdd058-9910-4a5f-05d0-08dd1644ee9d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 22:25:47.5037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nt4XFmV2WjpXfBD3syG7wGWIUz3b31i7N01lS4Uh/SfTs+iWb2EqLHQSF++8isYhNHz3IL2kF+YjaKB7EMZqcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10128

Convert device tree binding doc mobiveil-pcie.txt to yaml format. Merge
layerscape-pcie-gen4.txt into this file.

Additional change:
- interrupt-names: "aer", "pme", "intr", which align order in examples.
- reg-names: csr_axi_slave, config_axi_slave, which align existed dts file.

Fix below CHECK_DTBS warning:
arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dtb: /soc/pcie@3400000: failed to match any schema with compatible: ['fsl,lx2160a-pcie']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- update MAINTEAINER file to fix below
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412070127.BkBJhnZ4-lkp@intel.com/

>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt

lx2160a r2 already don't use this IP. But someone still complain when I
try to remove old r1 support.

So convert to yaml file to avoid annoised CHECK_DTBS warnings.
---
 .../bindings/pci/layerscape-pcie-gen4.txt     |  52 ------
 .../bindings/pci/mbvl,gpex40-pcie.yaml        | 167 ++++++++++++++++++
 .../devicetree/bindings/pci/mobiveil-pcie.txt |  72 --------
 MAINTAINERS                                   |   3 +-
 4 files changed, 168 insertions(+), 126 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
 create mode 100644 Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/mobiveil-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt b/Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
deleted file mode 100644
index b40fb5d15d3d9..0000000000000
--- a/Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-NXP Layerscape PCIe Gen4 controller
-
-This PCIe controller is based on the Mobiveil PCIe IP and thus inherits all
-the common properties defined in mobiveil-pcie.txt.
-
-Required properties:
-- compatible: should contain the platform identifier such as:
-  "fsl,lx2160a-pcie"
-- reg: base addresses and lengths of the PCIe controller register blocks.
-  "csr_axi_slave": Bridge config registers
-  "config_axi_slave": PCIe controller registers
-- interrupts: A list of interrupt outputs of the controller. Must contain an
-  entry for each entry in the interrupt-names property.
-- interrupt-names: It could include the following entries:
-  "intr": The interrupt that is asserted for controller interrupts
-  "aer": Asserted for aer interrupt when chip support the aer interrupt with
-	 none MSI/MSI-X/INTx mode,but there is interrupt line for aer.
-  "pme": Asserted for pme interrupt when chip support the pme interrupt with
-	 none MSI/MSI-X/INTx mode,but there is interrupt line for pme.
-- dma-coherent: Indicates that the hardware IP block can ensure the coherency
-  of the data transferred from/to the IP block. This can avoid the software
-  cache flush/invalid actions, and improve the performance significantly.
-- msi-parent : See the generic MSI binding described in
-  Documentation/devicetree/bindings/interrupt-controller/msi.txt.
-
-Example:
-
-	pcie@3400000 {
-		compatible = "fsl,lx2160a-pcie";
-		reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
-		       0x80 0x00000000 0x0 0x00001000>; /* configuration space */
-		reg-names = "csr_axi_slave", "config_axi_slave";
-		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
-			     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
-			     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
-		interrupt-names = "aer", "pme", "intr";
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		apio-wins = <8>;
-		ppio-wins = <8>;
-		dma-coherent;
-		bus-range = <0x0 0xff>;
-		msi-parent = <&its>;
-		ranges = <0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>;
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 7>;
-		interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
-				<0000 0 0 2 &gic 0 0 GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
-				<0000 0 0 3 &gic 0 0 GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
-				<0000 0 0 4 &gic 0 0 GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
-	};
diff --git a/Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml b/Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml
new file mode 100644
index 0000000000000..160ddc4bc45bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml
@@ -0,0 +1,167 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/mbvl,gpex40-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mobiveil AXI PCIe Root Port Bridge
+
+maintainers:
+  - Frank Li <Frank Li@nxp.com>
+
+description:
+  Mobiveil's GPEX 4.0 is a PCIe Gen4 root port bridge IP. This configurable IP
+  has up to 8 outbound and inbound windows for the address translation.
+
+  NXP Layerscape PCIe Gen4 controller (Deprecated) base on Mobiveil's GPEX 4.0.
+
+properties:
+  compatible:
+    enum:
+      - mbvl,gpex40-pcie
+      - fsl,lx2160a-pcie
+
+  reg:
+    items:
+      - description: PCIe controller registers
+      - description: Bridge config registers
+      - description: GPIO registers to control slot power
+      - description: MSI registers
+    minItems: 2
+
+  reg-names:
+    items:
+      - const: csr_axi_slave
+      - const: config_axi_slave
+      - const: gpio_slave
+      - const: apb_csr
+    minItems: 2
+
+  apio-wins:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      numbers of requested apio outbound windows
+        1. Config window
+        2. Memory window
+    default: 2
+    maximum: 256
+
+  ppio-wins:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: number of requested ppio inbound windows
+    default: 1
+    maximum: 256
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 3
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 3
+
+  dma-coherent: true
+
+  msi-parent: true
+
+required:
+  - compatible
+  - reg
+  - reg-names
+
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,lx2160a-pcie
+    then:
+      properties:
+        reg:
+          maxItems: 2
+
+        reg-names:
+          maxItems: 2
+
+        interrupt-names:
+          items:
+            - const: aer
+            - const: pme
+            - const: intr
+    else:
+      properties:
+        dma-coherent: false
+        msi-parent: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pcie@b0000000 {
+        compatible = "mbvl,gpex40-pcie";
+        reg = <0xb0000000 0x00010000>,
+              <0xa0000000 0x00001000>,
+              <0xff000000 0x00200000>,
+              <0xb0010000 0x00001000>;
+        reg-names = "csr_axi_slave",
+                    "config_axi_slave",
+                    "gpio_slave",
+                    "apb_csr";
+        #address-cells = <3>;
+        #size-cells = <2>;
+        device_type = "pci";
+        apio-wins = <2>;
+        ppio-wins = <1>;
+        bus-range = <0x00000000 0x000000ff>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+        interrupt-parent = <&gic>;
+        interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-map-mask = <0 0 0 7>;
+        interrupt-map = <0 0 0 0 &pci_express 0>,
+                        <0 0 0 1 &pci_express 1>,
+                        <0 0 0 2 &pci_express 2>,
+                        <0 0 0 3 &pci_express 3>;
+        ranges = <0x83000000 0 0x00000000 0xa8000000 0 0x8000000>;
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        pcie@3400000 {
+            compatible = "fsl,lx2160a-pcie";
+            reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
+                   0x80 0x00000000 0x0 0x00001000>; /* configuration space */
+            reg-names = "csr_axi_slave", "config_axi_slave";
+            interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
+                         <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
+                        <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+            interrupt-names = "aer", "pme", "intr";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            device_type = "pci";
+            apio-wins = <8>;
+            ppio-wins = <8>;
+            dma-coherent;
+            bus-range = <0x0 0xff>;
+            msi-parent = <&its>;
+            ranges = <0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>;
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 7>;
+            interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+                            <0000 0 0 2 &gic 0 0 GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+                            <0000 0 0 3 &gic 0 0 GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+                            <0000 0 0 4 &gic 0 0 GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt b/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
deleted file mode 100644
index 64156993e052d..0000000000000
--- a/Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
+++ /dev/null
@@ -1,72 +0,0 @@
-* Mobiveil AXI PCIe Root Port Bridge DT description
-
-Mobiveil's GPEX 4.0 is a PCIe Gen4 root port bridge IP. This configurable IP
-has up to 8 outbound and inbound windows for the address translation.
-
-Required properties:
-- #address-cells: Address representation for root ports, set to <3>
-- #size-cells: Size representation for root ports, set to <2>
-- #interrupt-cells: specifies the number of cells needed to encode an
-	interrupt source. The value must be 1.
-- compatible: Should contain "mbvl,gpex40-pcie"
-- reg: Should contain PCIe registers location and length
-	Mandatory:
-	"config_axi_slave": PCIe controller registers
-	"csr_axi_slave"	  : Bridge config registers
-	Optional:
-	"gpio_slave"	  : GPIO registers to control slot power
-	"apb_csr"	  : MSI registers
-
-- device_type: must be "pci"
-- apio-wins : number of requested apio outbound windows
-		default 2 outbound windows are configured -
-		1. Config window
-		2. Memory window
-- ppio-wins : number of requested ppio inbound windows
-		default 1 inbound memory window is configured.
-- bus-range: PCI bus numbers covered
-- interrupt-controller: identifies the node as an interrupt controller
-- #interrupt-cells: specifies the number of cells needed to encode an
-	interrupt source. The value must be 1.
-- interrupts: The interrupt line of the PCIe controller
-		last cell of this field is set to 4 to
-		denote it as IRQ_TYPE_LEVEL_HIGH type interrupt.
-- interrupt-map-mask,
-	interrupt-map: standard PCI properties to define the mapping of the
-	PCI interface to interrupt numbers.
-- ranges: ranges for the PCI memory regions (I/O space region is not
-	supported by hardware)
-	Please refer to the standard PCI bus binding document for a more
-	detailed explanation
-
-
-Example:
-++++++++
-	pcie0: pcie@a0000000 {
-		#address-cells = <3>;
-		#size-cells = <2>;
-		compatible = "mbvl,gpex40-pcie";
-		reg =	<0xa0000000 0x00001000>,
-			<0xb0000000 0x00010000>,
-			<0xff000000 0x00200000>,
-			<0xb0010000 0x00001000>;
-		reg-names =	"config_axi_slave",
-				"csr_axi_slave",
-				"gpio_slave",
-				"apb_csr";
-		device_type = "pci";
-		apio-wins = <2>;
-		ppio-wins = <1>;
-		bus-range = <0x00000000 0x000000ff>;
-		interrupt-controller;
-		interrupt-parent = <&gic>;
-		#interrupt-cells = <1>;
-		interrupts = < 0 89 4 >;
-		interrupt-map-mask = <0 0 0 7>;
-		interrupt-map = <0 0 0 0 &pci_express 0>,
-				<0 0 0 1 &pci_express 1>,
-				<0 0 0 2 &pci_express 2>,
-				<0 0 0 3 &pci_express 3>;
-		ranges = < 0x83000000 0 0x00000000 0xa8000000 0 0x8000000>;
-
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b13..e0fcdd8b6434c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17901,7 +17901,7 @@ M:	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
 M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
+F:	Documentation/devicetree/bindings/pci/mbvl,gpex40-pcie.yaml
 F:	drivers/pci/controller/mobiveil/pcie-mobiveil*
 
 PCI DRIVER FOR MVEBU (Marvell Armada 370 and Armada XP SOC support)
@@ -17925,7 +17925,6 @@ M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
 F:	drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
 
 PCI DRIVER FOR PLDA PCIE IP
-- 
2.34.1


