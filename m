Return-Path: <linux-pci+bounces-30169-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E73AEAE017B
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 11:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6C1164D19
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 09:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58011FC0EA;
	Thu, 19 Jun 2025 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TnhE+UAi"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011053.outbound.protection.outlook.com [52.101.70.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0EF229B02;
	Thu, 19 Jun 2025 09:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750324460; cv=fail; b=hZhOhNFwjfVIIN4AQQTqey+gTONb7I6fWsplfWsAKx+qZlZ9JsCwd8+GN0AKN8N8JJ/rBK8BB4MNYkoXOsKzvk5KDH6SAN4h8JmGNakUIrBgdOW6d1wFx0pwJM/+iJdD30XDARwnPql4h0BTIjkm/+0EDTSHZgldfvgPJc3QE80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750324460; c=relaxed/simple;
	bh=twFgTuaGRcwJfGvAptSQIcYcHG+TKOBFzcaMFjytZZs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=n3fItrHkaqX1uVo8LOis63eZgOtEbmFyJyQTppOGEPkML1QbzdSXB+rKCOnnJykt+05oQQXJLUska+Bd0ifgN71HrHF7Jy3eJ9fFPmcE9Axj0iVfh7RgoJkrUlJeVK8eTy0T/nMja//zpYZqnq/6iAHH2rlWXi7Pjy4QhFZfaow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TnhE+UAi; arc=fail smtp.client-ip=52.101.70.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thD1AXB/0yhPKN6N+p7OIn1hzkFPEGzmRBs592amS1V/9T6ukDU4nKjj2pAsyihGtDh+qIbCpq7xFMByaSR40gTDBwDIbrVJNCM5iYN2Vcj4k0Ubs/S587vO0rsHvVZ84LUjAfDlQLkP+HuA8NLP5+l+cLNBcr7VWP+kGYt88bniflHgP95ypjJidF823EASyBLbPF2KH35+FAl61CnLdHpJk5RPfxP/VcMgYGglPPc03f5jUnCts0TimZORde/mej+7/+0poH7vKiwGs7hu/oH9yN96OoRvDNwM7GlWWsQHx4SWPzfHpCy3peCBudDwDEKi6LNN9I0qfhGUmWX28w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvoNAGuFcFoRXA9DN7BUpWk2LUJa75qPYPiPm98lkHQ=;
 b=rEU+55PyLqfVBvN77pHE0HUKChBIVYkfGpMqroRiIIQrzLhoGQL5LIKQFYiZphz5qfShzwatc9ZfqPrtQx9j2y9Jhmu+xZSnKm1miDkkeFL5NUAYY9Q+4VpcoQBRWEF7FDf7YknJ8C8aRUo+1d+F5dHJaAy256Q/qF2L5O5bb0eQaD26lQ1htfLj+VvKn5+e1raM/6mJf4QZIal3g2PjlR0PAh8gsXxumcu6eras5bhof1QsURd5GPxWK4CW9W+2kibUPj6qKb/Fki1PYzcyTl5ggNqqVTBfYYW5Q0r70IRRhWArhb7Md8o/1zdukk8Y78jLb71hJyZChFb0tuSx1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvoNAGuFcFoRXA9DN7BUpWk2LUJa75qPYPiPm98lkHQ=;
 b=TnhE+UAiyYkoAcxvHYZQYZ3EhqkXNi5WZNgSIdOTMej7AK6J7P7i4ttQlARwMwnpeN1rTtbGWwaYt2aicBmQRtzyfu918LUULQwOxBfECfS+df0WdYT3cLHYoLMZbSBLG2AL1DRD//gNMxMM5c9Fcw0s9mbhQ4EyPw8aHXSBUsmfRzJhI4yENk6qly8I979S7FNXhTJP9ikgF6fqtPTxWYzZP6BPlsfLKxQ5PNRS7yocJzpKmXGI1Q2atYjyIKBJFXJ3caswGf869aKDcMaiLajDDs4vRf+pRYeRO57/xzXr6gU5bRJ1hDnBbvURspvd9r4K718+KVXlHYlihGnC0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB7021.eurprd04.prod.outlook.com (2603:10a6:800:127::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Thu, 19 Jun
 2025 09:14:14 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8857.020; Thu, 19 Jun 2025
 09:14:14 +0000
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
Subject: [PATCH v3 0/5] Add quirks to proceed PME handshake in DWC PM
Date: Thu, 19 Jun 2025 17:12:09 +0800
Message-Id: <20250619091214.400222-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::22)
 To AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|VI1PR04MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: b36fca90-4d32-4f83-925d-08ddaf11a957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dvEayUu8albdI+aw4WjGVxBDlsmKis5y4kVqaFXzNHtIj8wM3WDYj87W4KQw?=
 =?us-ascii?Q?yWe6Aw8mOd6v5Nfyf0WnUwdgIxkK9XM/PFCYX/oYjr3bguMFLViZ0p6g5U7C?=
 =?us-ascii?Q?VkcPPyFx1PdwWltAJo++6LZv0ftgv3pjcyEAO5oPL45gd8RzJxcvvMyusMFu?=
 =?us-ascii?Q?WfR3xwiFRMPSsRXb+OuNfSTTU71KqOAsjZ93XfV957rPbY1jZimvLgwS0UkN?=
 =?us-ascii?Q?1faTVuyisP6bq5s1K+MKp72jg8Tay68OnPUdaJBlNjNZTpE/I9ab8tTnNJrW?=
 =?us-ascii?Q?TFNU9BrORb0Xyo7ELkFcC12DlqG/ihlplcHufeFX1/XfhFNukaWAQokhs5Kc?=
 =?us-ascii?Q?GjnEwMBiRV0ZOOtLsbzI7XpY2TtObFtrUAK2PgySJvDcx3j/LdHAP5RjXs6t?=
 =?us-ascii?Q?EGqgfyMboHLq7YdBXJT7/tNHlA1y5xNBSMlJ9MCe0N10gBbm1sHLYSFcpoPh?=
 =?us-ascii?Q?WmhHQaM0Cyl8gGOvrf7wXm6EVS3P2V30Udviw2ggTHJRiclzghybFM7WsP2k?=
 =?us-ascii?Q?aP1sOlsR7iaUkODzRIGaQ/QAD4/OFBtK3IpDBjGPVZDVleTMxF8dnXBwenjd?=
 =?us-ascii?Q?YqlYtWtllP6Or9MWZ/kCmzBALbR2n9pHs5/C2AUssHwd2Fp3y4t/CXPXFW3h?=
 =?us-ascii?Q?q+Z7MQDTlKaRr5+/0dxYBDdUvszxAl8xtI6UGjyrzaTinT6fJpBZHVyUR7zW?=
 =?us-ascii?Q?C5XM0jloFaEkvP9naq9dmUEDxrwmwedlH2kWMmiwGZsOT0NH2Sf81KMUd1cq?=
 =?us-ascii?Q?SqUGMVZA+NhEVsxJBGIQnerQo1UHsGkVPLmReygj+HLfmpqf3cJJlJtEDxd1?=
 =?us-ascii?Q?pkZ+HMRLqwYefge3wXfXGsXl2nwFBxH8FaaAyCjIKG3bS/D9o/7scNjS25eU?=
 =?us-ascii?Q?SK0bGIJKJNsPaM6OUCgvJopvDRrKFczkEVK4Q7gguFOLenR+Im5Z24C0b5Gx?=
 =?us-ascii?Q?jU/CQmpe9kN7L2E/EMvyhvTcIojBx8THylJKiRnLcb706I1jDos6eL1Icj/b?=
 =?us-ascii?Q?6wJe4AIgEvEmLGkqU/PL+FSANuOVEKB9HT8uRyUMMkcxHXqg/05oouw0kp1w?=
 =?us-ascii?Q?o0Yn2AWyYWZGSnaG6R6pG2eRty39ZdK9hQyXM6pBZy6fDJXU9FflzW0oiNdm?=
 =?us-ascii?Q?kXW+CIDq9NJP2zfoaNYkjxCvpOp40w5F9PDPuW8pvakHdm2ToBipR+QGUNtm?=
 =?us-ascii?Q?k74o6j2ZVvf0x7K7wQSKyF2bPTV1DRURgI54CVSv5NDwt0Vttf4Qdb16syje?=
 =?us-ascii?Q?38qGZAUzxXD4SafswKmxUXmAD0DalyvJ1yuTdePg/Gb5rYkPzQVPaxN/LdVd?=
 =?us-ascii?Q?DZEORkgCY5YQtMNLnNmD/JVRbn4jg+2CfYi/YeBDl6ZoxDbCvUbsMNBcLcav?=
 =?us-ascii?Q?GjJPFcnPbN4F+a+Ldgui7OLj+HwdB0c1vNTgwvgnROlG/Y4lwQUaZ9DulM7l?=
 =?us-ascii?Q?nhvapqGP3vMRy4PemUBYlBAYYPU8z9PiM9efITKpnNibfeyekRNoFwPY81H3?=
 =?us-ascii?Q?z8KhZAeGCU1gYGSKPm4q+gE2/+1SdAHdVGtK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nfpo5fOTcsy/HRqgDy6JfBGY0y5fFnNcnW/3y3YaRkZeiOD1cRnRgBRR6f6d?=
 =?us-ascii?Q?+UZv8gY55p8MMbjnlmizRaU8hGEfu4SOM0k/4+Uk/cO7L52zYV2p6EiLfz9i?=
 =?us-ascii?Q?1xoHj0vzoiRXUFhmAxrrfWbPyGnje7QZaVrZdft9vLfFuedeqiUq8PTosFWc?=
 =?us-ascii?Q?LrmxSCZFNhOYb3hoZu12JfpDGeyoiaM9AUATRKGJdLhTBm/qKXHntVxm2L51?=
 =?us-ascii?Q?5AigZorW5V3/xBh6I3MIEnUbFy3vqhA4sZr6RFyeRhDD5oOYJMsRtuhlcxJC?=
 =?us-ascii?Q?LA70ydQOmZ1PJnVpfaCo9nnvL41oRaGQt4PobZimYeJ3Wnnirridu1qdcKLh?=
 =?us-ascii?Q?ObmmBwFmszc4UftuvYlPRU+eKMts9Zc3zgcoySzgGKPZCD99oVgDV4i0imEt?=
 =?us-ascii?Q?W+MTVBi4MuDNUcmhPazPtmy+R7vNxeNrBkqsgR7a3ViXW8FK8hDZK14SG2hy?=
 =?us-ascii?Q?OlhNRPLK4uqWTrTemT1eM1t7nUEvJmhnm2FRHiSrtBQKYAQWuV1X5onmfpTI?=
 =?us-ascii?Q?IM9YHzURYMxXOS7OlH2gLkVv2Y8O2/7j5l2tXg+B5ud21qCLZnmDHTYecpzG?=
 =?us-ascii?Q?AjBIbMhcFxghc5PPruOKhqnuoKdCBB6mpLFMsqiGs/D99ur7hXuJph/+LITv?=
 =?us-ascii?Q?5m3OCE5SE/joLGThoHJOvmj1VJd1R8eG9m/1pDOs39kWPuophERZbsG6fjQ9?=
 =?us-ascii?Q?BKH3NB6NS2LtihgmwrAC8su4FYFWxBZHuLt6Jsr9iv0z2FUGZlKe2P3eIjGt?=
 =?us-ascii?Q?lfAvPxKacdSjBgd2xRMRV66/YG8eLCec76LIDoSQCYH21zLAKYhOHtrby0z1?=
 =?us-ascii?Q?8mCO3zoxNdhpmo06E59r9/ruzRCDUOtOC3Der1sOKWMt26lAAauP0f/vZbiS?=
 =?us-ascii?Q?KeF32oCfCAOwT7qdMG2kWJJJcGjJJgNF1nRY7XtcNDP+MQ5y+jkhnhuijjKe?=
 =?us-ascii?Q?2T7PMCUL83rlZHj4mN4SaI0paIpMA+Kh6x/Vna97zPPQzc5dTBSjHxOydAu/?=
 =?us-ascii?Q?DlSueEDVWTw2ZnZjLov/I4x8J1rPHVOnTDXiCV1YAXZi16lyalSu3E70vodH?=
 =?us-ascii?Q?8E7XDuKcVC3saZv7O/yOYBk7+7CRi4AwZvbayZhyfEdyoVSCILl9/W6VVX3d?=
 =?us-ascii?Q?dnmdX1oTk512/mvJ8ZkAjeelIiDxxarUcOeW2oVH+3SRD0fokuVY++f64LfM?=
 =?us-ascii?Q?gCLYDE8ja1EeEfJqFQxnpZwObh13bCdIR1vWHOB9C3HXwCGOJfY5Y0zOuSq+?=
 =?us-ascii?Q?3wD61HnVB3AS3dCJRf1yd7b4u4yuVLisGWoj1F6sUjzhzgfg0uRpN4XvKa90?=
 =?us-ascii?Q?xZbkCvjaBzI3v/0gXbmPWlbEMY7qFVlDMtnLnebybZoV//i/OkwG9qEezrj4?=
 =?us-ascii?Q?h4nOmyPM0CQkFwZ1jztUIb+a+Eh4PdBSQXzSZ+sDOJPAy+vl0ikur+BZ2+Wr?=
 =?us-ascii?Q?9MQWTCnhAkbWrq/UewTvIw1OJ5qSR2kMJzIvzdvDCHTSbVff9F6Xx2bViWdm?=
 =?us-ascii?Q?+sTitMUlMB9Ugdgk/DKeYiGVMbrqaW6pwDqRWtdhA8KSs4Ph6UGRiLqFaNA5?=
 =?us-ascii?Q?amZkpe8jUw0gVRWJ0Yu0vTs/O4GmtBeOKMAHlDsf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b36fca90-4d32-4f83-925d-08ddaf11a957
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 09:14:14.8522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dmq9u6ta3r5cuHgxZ8ixH5ghbh/CfecGloi/EagAUCbgp3oqxwciHbE4DD8ZkaaAxcrU4doJeQGbCygNkbC67Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7021

Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management State Flow
Diagram. Both L0 and L2/L3 Ready can be transferred to LDn directly.

It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
PME_Turn_Off is sent out, whatever the LTSSM state is in L2 or L3 after
a recommended 10ms max wait refer to PCIe r6.0, sec 5.3.3.2.1 PME
Synchronization.

The LTSSM states of i.MX6QP PCIe is inaccessible after the PME_Turn_Off
is kicked off. To handle this case, don't poll L2 state and add one max
10ms delay if QUIRK_NOL2POLL_IN_PM flag is existing in suspend.

Main chenages in v3:
- Adjust the patch sequence to avoid the build break.
- Update the commit message.
v2:https://patchwork.kernel.org/project/linux-pci/cover/20250618024116.3704579-1-hongxing.zhu@nxp.com/

Main chenages in v2:
Add the following two patches.
- Skip PME_Turn_Off message if there is no endpoint connected.
- Don't return error when wait for link up.
v1:https://patchwork.kernel.org/project/linux-pci/cover/20250408065221.1941928-1-hongxing.zhu@nxp.com/

[PATCH v3 1/5] PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM is
[PATCH v3 2/5] PCI: imx6: Don't poll LTSSM state of i.MX6QP PCIe in
[PATCH v3 3/5] PCI: imx6: Don't poll LTSSM state of i.MX7D PCIe in PM
[PATCH v3 4/5] PCI: dwc: Skip PME_Turn_Off message if there is no
[PATCH v3 5/5] PCI: dwc: Don't return error when wait for link up

drivers/pci/controller/dwc/pci-imx6.c             |  4 ++++
drivers/pci/controller/dwc/pcie-designware-host.c | 50 +++++++++++++++++++++++++++++++-------------------
drivers/pci/controller/dwc/pcie-designware.h      |  4 ++++
3 files changed, 39 insertions(+), 19 deletions(-)


