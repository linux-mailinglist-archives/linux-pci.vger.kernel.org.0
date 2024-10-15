Return-Path: <linux-pci+bounces-14549-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7326C99EC5B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 15:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED131C22A4D
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 13:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAEF227394;
	Tue, 15 Oct 2024 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rg1hxEyA"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868621B21AE;
	Tue, 15 Oct 2024 13:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998089; cv=fail; b=INe7CQoBDFcquQSowk1DeP/hV2wJTInzh+Dbnl8uxejP3XKGTEwgMz+ioqgPmJ9euZSpyTahjYyga7hB34GTK1na15hQSguMXPmNSJAxiBaItz29SdNZiGbgUP5AVWqKL5+qz0yZeZGSgqioyS7zkdbVeA9UzMR9thDNFPOmYoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998089; c=relaxed/simple;
	bh=6TJLSHMobtuA5qbBaO/1aZa41MYkdwkjSPf8jbThMWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U9UQfus9n7RREmBGkOr09/nYqEZ0vIitC2AtxLIY8d14RnUfu0ngk2nytjdPPoHqwS4eV7VJ7WedlRinrOMsIuMXZ05sPkcb8JWJrMW5cAH2gQWNUpBTl0IFeFlkJheflJKseMwaBtWACPRh4i1RN5SlC3m38IdQWdyu6Ppgjas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rg1hxEyA; arc=fail smtp.client-ip=40.107.21.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+CyGSK8Pda4ZuBubqKurUEZxKUT4zELigt4Fh/B5oTxErszMVDWyZqxRdhgNvoniTBP0wM3iqC4nbjnNke05QybrlkeaA0thmY2Psn8WGtHdKZqgFQImp01w5A6cj3wtKkcEuthwv3jswb/40ilHubF523vGUs++2bB/dQiFvrgsliVhUdKGJcR+rKsMaSnFZPjp0HVTAVfyYjYyPc1t0O+oXpI6lqk4HD2iQW+MUmKVAeiJS6nY9RzJO98MNZBCpx9RHcEqyl9ajaQAV0ay5oGmNV4Z3w58BE47Y8PpW3R80w1swkNWjc9ZIvA4Q8oNAcMY5fH5713kspOdTqitA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNAVmboS3Sq7TLBeQrAIgV93YxMaE8w21gI4KK0O8d0=;
 b=ioTvnR03H13YKNFvzEQhrd5b+G1lbGGfR3YMBSLkW/LTBgHdEp5WjhLP1WP+Ng5L0Son/d2lnjXFq1qdRhbhDqtD3niCVoPfzTCjsZ1jt0iLYKdlxslkxoWJwxqech/u47PzrXiWBQ9sYeMKVlWRN1+1/JTfWN/LbiTPWe8rksV8Zs0S671+vvhxTt4bqGOaddcA2cFBecIUYQOR/g4TRaJvtoTGHVZ5vk+z0Eg9IcJtyCUZm7xG5Y6Mew+L9serWv0KsGgWjA/qa48xm6if+l6KEAEeTuoSM9rjR4tYAzBUORgAPWGHBNWyLC8iRMJ7jzlvPYlX0zf/506WuQO1Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNAVmboS3Sq7TLBeQrAIgV93YxMaE8w21gI4KK0O8d0=;
 b=Rg1hxEyANR+0l3DRwWcZlujGU4IDLaHQJA8lfXY/xF1bzyFA7YSg5q+z4LHF674ot2XMR63rtu1+ieM3TR/1aQiHK3DDCV/cdARoJB51BcsPVq69dgSCQU9qzYJsFg3kbk/cPZgZjNiQULjRmDCqL7AfVO20G1i5WkHNttI718rGSCRws5uRnG3d8mCLX25ClC2S0JVkL4jSxr1RoJsE9l7hX9D4NvXNtca7FpQt4KJT8YIkr2WAr7EFqL96AGN2SLrbusU68IB9SqAjGW5k/e6DQvhsfIoDSpI3lvluZxQSimuwv5z/WH9uBekHVkuFVKzRx7aYqXIuOdXDDy0p2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS5PR04MB9876.eurprd04.prod.outlook.com (2603:10a6:20b:678::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Tue, 15 Oct
 2024 13:14:41 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Tue, 15 Oct 2024
 13:14:41 +0000
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
Subject: [PATCH v2 net-next 12/13] net: enetc: add preliminary support for i.MX95 ENETC PF
Date: Tue, 15 Oct 2024 20:58:40 +0800
Message-Id: <20241015125841.1075560-13-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015125841.1075560-1-wei.fang@nxp.com>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS5PR04MB9876:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6724fa-d766-4f2d-05ff-08dced1b5404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YdxyBDA8gGEn4ixAnNlx1VeCl2de2I0r8KMaojeYCev7zv5cOyIHExVbDZHR?=
 =?us-ascii?Q?wGK0ps6aJpKtboh/VrBeq4KGgEvJnHymvYAZVUEUBVcCXgKH0jSrjoAvrJYH?=
 =?us-ascii?Q?Nzgin4/aTxgQeBIznRkKiDvZiEqd29iaZp3Zk8jtawIZ1W9Cz8jmZkAN7Dcx?=
 =?us-ascii?Q?tDXrccS29QSkaUE2AhP4yFrcVLwrZL4y5QVVfCkPM8fvNd7iC8BiPOrb1/yg?=
 =?us-ascii?Q?2ihWeihWw0yKHlpztnDB+G84L1P/9GEYGa9fuxJV6DwZooUzoYMkD7bh1z3U?=
 =?us-ascii?Q?w7798HePwEji9qZU566EVgNMKZlXRxMiaDx1V7Tp7pUdRy4+W+erZeOT9z6o?=
 =?us-ascii?Q?qX1ao4Vv7jb7V8koWF4wSUa38ZRAvxOXkOA/uUGGLnZP3i8BWHrxZOKrmRVm?=
 =?us-ascii?Q?JnX98Sw3ZJ5Vm6YhETURgyx6EfZ6mvJhbli8KuJlHkvljF6ZdQHQ8W+wzD3X?=
 =?us-ascii?Q?vad/7fA5BKLkdHZEUYLaZJ/z7gJdx/cwc8m+VunctLkLyA/6ZxPIxMmAu08+?=
 =?us-ascii?Q?gclnNekGgv37d/k6hoETXbo/ESGuP4/nprgQxFTEnVrV/mG7aFJGTcYFmgZ0?=
 =?us-ascii?Q?joKqzOlOfv74/gNpsUGVx5p8IzO/w3GvQJxXMUhoutO4rOtF2JDCq5d97ZNp?=
 =?us-ascii?Q?neF/spDAm+ueAAh3t5eQGKrZZPg9orJsV7RfLSKHMHGFipaklVnRoR58J6hO?=
 =?us-ascii?Q?Ah9n8izwB9/t8E4GCdltfWkcgCEpSmglcm0ESPlI4az53vDHP1LyxNIe6XKF?=
 =?us-ascii?Q?IU10/JS2/dqpKe2DMoLjbpfxN9kDhrnNqJh38kNDJI9Eda4YFlOBRMgnDkTO?=
 =?us-ascii?Q?FBgoJ7E8EM8QcygmpGQB4WyvXa/9bxObCP+WCCxF83AvJoEmlhBR0DLuLg/i?=
 =?us-ascii?Q?waSt/pHTn/uk6jDeJsPZxLqK+k0EQxGevoVhTU67k6012/eEMpXg9UddnGdL?=
 =?us-ascii?Q?I9QTvpRH+HuxKrKvOEJAl2GG1GAC7ylzDLbuKZeFcO+2FR8fAFe50SMIsFY8?=
 =?us-ascii?Q?oEzB4vVXEw5n4tnI6pRJX4ty30K/MVW6eERgUjMzroNsyLGkFFufpq94/mks?=
 =?us-ascii?Q?vIcJm00XCTy1EaeaMmO0TmGGJkhip2jdB/vM/SUmbcC1LeeTt2Vmp93qn4lb?=
 =?us-ascii?Q?bBkcJAyusxcf5CNVaHxyf+oYIHOPpN/Y7WG1UJJWaNIOgf012HV8EVIO+vlx?=
 =?us-ascii?Q?SbYoe5UloVstzqUtEHVYEfkj3YFUgEuMFIkTWM26TWel7hQmgslpLJ2dyLoY?=
 =?us-ascii?Q?hT0h3bHiClR/MlAQP3BrRLlZtTnSQLwZA8O28Qk6RIvoOkU9BoqL9q1jxqCF?=
 =?us-ascii?Q?uxNq+wEfyPpvqrG77hfvgerFa5AqIGmXGdCLLFFKLolsp+l6XWcj/xctUogW?=
 =?us-ascii?Q?up9SaT8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rwIsdIt7GKIL0nzRk1mZtttFVv3pt5Qhv3qFtCX+tAlLwykNZmcHgmHsDl+c?=
 =?us-ascii?Q?JO9eohy8fqbTLnkTnaf7yH6PzWLA8z9E2yC/VtK6xX833Kt7hFnbpNHxZNrh?=
 =?us-ascii?Q?RfsYq6EA/YJizVkoNYKmHq8b5Suq8E7Y0cbxRnZFWfVekmloCktwgDGbjIl6?=
 =?us-ascii?Q?xLE+4Y6M1QRkjfMLbJu4xpm2gjfOxC+4K3Mxg/oSXmqFygsFmjxn+ycZhHaY?=
 =?us-ascii?Q?DVZN9N/M6sTZgYov7xXIAb8S2Ol/anVogJidNAmsRnh/zDBSbFOGKWWt87oF?=
 =?us-ascii?Q?9uVJyBwk2zYwVWYy8lTRa8UyxKy5KTYbZ0YTbIfYoR6Z5RtCpOcROCnV/rf8?=
 =?us-ascii?Q?GuH6n8eSVAvXPkSJ6rBX9cI9NL3LHG9YZyPepW6ablLSmwOL44/AJ/n38aRx?=
 =?us-ascii?Q?ObQ20zu/WP8ukI9hKUjMFJlkArfw1iOxUOOwfCODG991ConSWqgmbdoIE+MS?=
 =?us-ascii?Q?0R4ZIp34r+naVTFwr8KGdK7umOuez/cwVONRpadLVTbwLIG4MRjbCj4E7ewF?=
 =?us-ascii?Q?BVOQI6ExRewMYTueeJ40urTe0Oc7ZI0C9aQRxKG/rBgG8V74xA/HBZg9dvr9?=
 =?us-ascii?Q?ob0xy7FL+Fawh4JP/yIyNM7K9dhmMCQuTNdHwzR/BDmglXbR0rZ6IGcG/moj?=
 =?us-ascii?Q?K1i1MgTzO3/x7GZGBvKOLE1DwWjYi/sVD3qzFQmhfYQyqj46nxarjtksWVZ5?=
 =?us-ascii?Q?hPcFHnkkta/egXIxUzxr+EbclIzU8aowXtNYlT6HreqWkaAChE404ZY3PBaa?=
 =?us-ascii?Q?FoQb6U3IkVd9SRTgZBVOSutEqXWtCvKPG0zamzDyeOmAE8PFafl+dyfhGbo9?=
 =?us-ascii?Q?slearFzQmiiuf69F3+HEcvf7rajYxP8bhpLk+myVAOqGyBZgtcZZtO9A5LBv?=
 =?us-ascii?Q?52LB1dCNMx85wGdqHZTn5I/35EqnvOy7mzNXqYGScTIZUZufXxi8WL+N94Ve?=
 =?us-ascii?Q?8FMRCcGWkE7iAsQ8f2cRgVBVX8+kK35h+zanZZYduUzQbNsAJxlq7gOrhf0t?=
 =?us-ascii?Q?OpPtujam5sL5cPhlrkGxrYpa3DOBjrXS/v+jF38dj6Y3ZNfLsiRrktfCuH5Z?=
 =?us-ascii?Q?Ejl5ld81wzXhNjL03wUs1iKz/4APcxhvoaal4SZKEYY3LifqJR2tZHNERZc7?=
 =?us-ascii?Q?RzxzH/NEHZFRb2r1RByxs3GlWAgqJUktT+6uYG5uoNjG8vFC0LYu1SNy6X70?=
 =?us-ascii?Q?bptMnBBAW07+KxiJ3xk4k6BTpdCyj/yAFCv5V8d0H5AeKuDC7KHQ2J2jxthb?=
 =?us-ascii?Q?ucNEkQVUKoWV/ELb3hDqfGMRQYXvxpG2T11niC6E+posu9kmL9c/mxQiooEa?=
 =?us-ascii?Q?dtnCBsJnx3acxowKBAx9SC10s8l1bUiF9qUvXPG6xvKEy4C659f93usZooc7?=
 =?us-ascii?Q?UmqSFyEOQvBi4syC88VogMoq0uLP9XJxLke88S9JStorJ+UQHUvB+joT5KG6?=
 =?us-ascii?Q?VpWPMCRBugoY/jCFkDGI+jtx6ErxKzdtYNBkOcreprgAhahqv0Vgvw7Ymrqa?=
 =?us-ascii?Q?01m1pBPGbiQh3ffwzzpzhz+TS8yL3T0fgMfc5KVUMmOKiQd8j16Ls1bnGqzz?=
 =?us-ascii?Q?uLq22TkwEUl5aCecScJgGfMRxMHiPtMzftXMMpJj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6724fa-d766-4f2d-05ff-08dced1b5404
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 13:14:41.3474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmA2RT+3ujKvp2sfNre3QfQJm5LSR7A/IgMtJM/ukrgtlPEdVyqvYDhYbeFdcURWDTTUY49Yzdz8lOdNGkAYJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9876

The i.MX95 ENETC has been upgraded to revision 4.1, which is very
different from the LS1028A ENETC (revision 1.0) except for the SI
part. Therefore, the fsl-enetc driver is incompatible with i.MX95
ENETC PF. So add new nxp-enetc4 driver to support i.MX95 ENETC PF,
and this driver will be used to support the ENETC PF with major
revision 4 for other SoCs in the future.

Currently, the nxp-enetc4 driver only supports basic transmission
feature for i.MX95 ENETC PF, the more basic and advanced features
will be added in the subsequent patches.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2 changes:
1. Refine the commit message.
2. Sort the header files.
3. Use dev_err_probe() in enetc4_pf_probe().
4. Remove unused variable 'pf' from enetc4_pf_remove().
---
 drivers/net/ethernet/freescale/enetc/Kconfig  |  17 +
 drivers/net/ethernet/freescale/enetc/Makefile |   3 +
 drivers/net/ethernet/freescale/enetc/enetc.c  |  50 +-
 drivers/net/ethernet/freescale/enetc/enetc.h  |  19 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  | 153 ++++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 757 ++++++++++++++++++
 .../ethernet/freescale/enetc/enetc_ethtool.c  |  68 +-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  12 +-
 .../net/ethernet/freescale/enetc/enetc_pf.h   |   9 +
 .../freescale/enetc/enetc_pf_common.c         |  10 +-
 10 files changed, 1076 insertions(+), 22 deletions(-)
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_hw.h
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_pf.c

diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
index fdd3ecbd1dbf..750281e3d285 100644
--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -33,6 +33,23 @@ config FSL_ENETC
 
 	  If compiled as module (M), the module name is fsl-enetc.
 
+config NXP_ENETC4
+	tristate "ENETC4 PF driver"
+	depends on PCI_MSI
+	select MDIO_DEVRES
+	select FSL_ENETC_CORE
+	select FSL_ENETC_MDIO
+	select NXP_ENETC_PF_COMMON
+	select PHYLINK
+	select DIMLIB
+	help
+	  This driver supports NXP ENETC devices with major revision 4. ENETC is
+	  as the NIC functionality in NETC, it supports virtualization/isolation
+	  based on PCIe Single Root IO Virtualization (SR-IOV) and a full range
+	  of TSN standards and NIC offload capabilities.
+
+	  If compiled as module (M), the module name is nxp-enetc4.
+
 config FSL_ENETC_VF
 	tristate "ENETC VF driver"
 	depends on PCI_MSI
diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
index b81ca462e358..5417815957b5 100644
--- a/drivers/net/ethernet/freescale/enetc/Makefile
+++ b/drivers/net/ethernet/freescale/enetc/Makefile
@@ -11,6 +11,9 @@ fsl-enetc-y := enetc_pf.o
 fsl-enetc-$(CONFIG_PCI_IOV) += enetc_msg.o
 fsl-enetc-$(CONFIG_FSL_ENETC_QOS) += enetc_qos.o
 
+obj-$(CONFIG_NXP_ENETC4) += nxp-enetc4.o
+nxp-enetc4-y := enetc4_pf.o
+
 obj-$(CONFIG_FSL_ENETC_VF) += fsl-enetc-vf.o
 fsl-enetc-vf-y := enetc_vf.o
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 72ddf8b16271..fd7a9dae9e14 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -2,6 +2,7 @@
 /* Copyright 2017-2019 NXP */
 
 #include "enetc.h"
+#include <linux/clk.h>
 #include <linux/bpf_trace.h>
 #include <linux/tcp.h>
 #include <linux/udp.h>
@@ -21,7 +22,7 @@ void enetc_port_mac_wr(struct enetc_si *si, u32 reg, u32 val)
 {
 	enetc_port_wr(&si->hw, reg, val);
 	if (si->hw_features & ENETC_SI_F_QBU)
-		enetc_port_wr(&si->hw, reg + ENETC_PMAC_OFFSET, val);
+		enetc_port_wr(&si->hw, reg + si->pmac_offset, val);
 }
 EXPORT_SYMBOL_GPL(enetc_port_mac_wr);
 
@@ -700,8 +701,10 @@ static void enetc_rx_dim_work(struct work_struct *w)
 		net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
 	struct enetc_int_vector	*v =
 		container_of(dim, struct enetc_int_vector, rx_dim);
+	struct enetc_ndev_priv *priv = netdev_priv(v->rx_ring.ndev);
+	u64 clk_freq = priv->si->clk_freq;
 
-	v->rx_ictt = enetc_usecs_to_cycles(moder.usec);
+	v->rx_ictt = enetc_usecs_to_cycles(moder.usec, clk_freq);
 	dim->state = DIM_START_MEASURE;
 }
 
@@ -1721,14 +1724,25 @@ void enetc_get_si_caps(struct enetc_si *si)
 	struct enetc_hw *hw = &si->hw;
 	u32 val;
 
+	if (is_enetc_rev1(si))
+		si->clk_freq = ENETC_CLK;
+	else
+		si->clk_freq = ENETC_CLK_333M;
+
 	/* find out how many of various resources we have to work with */
 	val = enetc_rd(hw, ENETC_SICAPR0);
 	si->num_rx_rings = (val >> 16) & 0xff;
 	si->num_tx_rings = val & 0xff;
 
-	val = enetc_rd(hw, ENETC_SIRFSCAPR);
-	si->num_fs_entries = ENETC_SIRFSCAPR_GET_NUM_RFS(val);
-	si->num_fs_entries = min(si->num_fs_entries, ENETC_MAX_RFS_SIZE);
+	val = enetc_rd(hw, ENETC_SIPCAPR0);
+	if (val & ENETC_SIPCAPR0_RFS) {
+		val = enetc_rd(hw, ENETC_SIRFSCAPR);
+		si->num_fs_entries = ENETC_SIRFSCAPR_GET_NUM_RFS(val);
+		si->num_fs_entries = min(si->num_fs_entries, ENETC_MAX_RFS_SIZE);
+	} else {
+		/* ENETC which not supports RFS */
+		si->num_fs_entries = 0;
+	}
 
 	si->num_rss = 0;
 	val = enetc_rd(hw, ENETC_SIPCAPR0);
@@ -1742,8 +1756,11 @@ void enetc_get_si_caps(struct enetc_si *si)
 	if (val & ENETC_SIPCAPR0_QBV)
 		si->hw_features |= ENETC_SI_F_QBV;
 
-	if (val & ENETC_SIPCAPR0_QBU)
+	if (val & ENETC_SIPCAPR0_QBU) {
 		si->hw_features |= ENETC_SI_F_QBU;
+		si->pmac_offset = is_enetc_rev1(si) ? ENETC_PMAC_OFFSET :
+						      ENETC4_PMAC_OFFSET;
+	}
 
 	if (val & ENETC_SIPCAPR0_PSFP)
 		si->hw_features |= ENETC_SI_F_PSFP;
@@ -2056,7 +2073,7 @@ int enetc_configure_si(struct enetc_ndev_priv *priv)
 	/* enable SI */
 	enetc_wr(hw, ENETC_SIMR, ENETC_SIMR_EN);
 
-	if (si->num_rss) {
+	if (si->num_rss && is_enetc_rev1(si)) {
 		err = enetc_setup_default_rss_table(si, priv->num_rx_rings);
 		if (err)
 			return err;
@@ -2080,9 +2097,15 @@ void enetc_init_si_rings_params(struct enetc_ndev_priv *priv)
 	 */
 	priv->num_rx_rings = min_t(int, cpus, si->num_rx_rings);
 	priv->num_tx_rings = si->num_tx_rings;
-	priv->bdr_int_num = cpus;
+	if (is_enetc_rev1(si)) {
+		priv->bdr_int_num = cpus;
+		priv->tx_ictt = enetc_usecs_to_cycles(600, ENETC_CLK);
+	} else {
+		priv->bdr_int_num = priv->num_rx_rings;
+		priv->tx_ictt = enetc_usecs_to_cycles(500, ENETC_CLK_333M);
+	}
+
 	priv->ic_mode = ENETC_IC_RX_ADAPTIVE | ENETC_IC_TX_MANUAL;
-	priv->tx_ictt = ENETC_TXIC_TIMETHR;
 }
 EXPORT_SYMBOL_GPL(enetc_init_si_rings_params);
 
@@ -2475,10 +2498,14 @@ int enetc_open(struct net_device *ndev)
 
 	extended = !!(priv->active_offloads & ENETC_F_RX_TSTAMP);
 
-	err = enetc_setup_irqs(priv);
+	err = clk_prepare_enable(priv->ref_clk);
 	if (err)
 		return err;
 
+	err = enetc_setup_irqs(priv);
+	if (err)
+		goto err_setup_irqs;
+
 	err = enetc_phylink_connect(ndev);
 	if (err)
 		goto err_phy_connect;
@@ -2510,6 +2537,8 @@ int enetc_open(struct net_device *ndev)
 		phylink_disconnect_phy(priv->phylink);
 err_phy_connect:
 	enetc_free_irqs(priv);
+err_setup_irqs:
+	clk_disable_unprepare(priv->ref_clk);
 
 	return err;
 }
@@ -2559,6 +2588,7 @@ int enetc_close(struct net_device *ndev)
 	enetc_assign_tx_resources(priv, NULL);
 
 	enetc_free_irqs(priv);
+	clk_disable_unprepare(priv->ref_clk);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 97524dfa234c..7f1ea11c33a0 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -14,6 +14,7 @@
 #include <net/xdp.h>
 
 #include "enetc_hw.h"
+#include "enetc4_hw.h"
 
 #define ENETC_MAC_MAXFRM_SIZE	9600
 #define ENETC_MAX_MTU		(ENETC_MAC_MAXFRM_SIZE - \
@@ -222,6 +223,7 @@ struct enetc_msg_swbd {
 };
 
 #define ENETC_REV1	0x1
+#define ENETC_REV4	0x4
 enum enetc_errata {
 	ENETC_ERR_VLAN_ISOL	= BIT(0),
 	ENETC_ERR_UCMCSWP	= BIT(1),
@@ -247,10 +249,22 @@ struct enetc_si {
 	int num_rss; /* number of RSS buckets */
 	unsigned short pad;
 	int hw_features;
+	int pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
+	u64 clk_freq;
 };
 
 #define ENETC_SI_ALIGN	32
 
+static inline bool is_enetc_rev1(struct enetc_si *si)
+{
+	return si->pdev->revision == ENETC_REV1;
+}
+
+static inline bool is_enetc_rev4(struct enetc_si *si)
+{
+	return si->pdev->revision == ENETC_REV4;
+}
+
 static inline void *enetc_si_priv(const struct enetc_si *si)
 {
 	return (char *)si + ALIGN(sizeof(struct enetc_si), ENETC_SI_ALIGN);
@@ -302,7 +316,7 @@ struct enetc_cls_rule {
 	int used;
 };
 
-#define ENETC_MAX_BDR_INT	2 /* fixed to max # of available cpus */
+#define ENETC_MAX_BDR_INT	6 /* fixed to max # of available cpus */
 struct psfp_cap {
 	u32 max_streamid;
 	u32 max_psfp_filter;
@@ -340,7 +354,6 @@ enum enetc_ic_mode {
 
 #define ENETC_RXIC_PKTTHR	min_t(u32, 256, ENETC_RX_RING_DEFAULT_SIZE / 2)
 #define ENETC_TXIC_PKTTHR	min_t(u32, 128, ENETC_TX_RING_DEFAULT_SIZE / 2)
-#define ENETC_TXIC_TIMETHR	enetc_usecs_to_cycles(600)
 
 struct enetc_ndev_priv {
 	struct net_device *ndev;
@@ -388,6 +401,8 @@ struct enetc_ndev_priv {
 	 * and link state updates
 	 */
 	struct mutex		mm_lock;
+
+	struct clk *ref_clk; /* RGMII/RMII reference clock */
 };
 
 /* Messaging */
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
new file mode 100644
index 000000000000..0b2a35189e9d
--- /dev/null
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -0,0 +1,153 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/*
+ * This header file defines the register offsets and bit fields
+ * of ENETC4 PF and VFs. Note that the same registers as ENETC
+ * version 1.0 are defined in the enetc_hw.h file.
+ *
+ * Copyright 2024 NXP
+ */
+#ifndef __ENETC4_HW_H_
+#define __ENETC4_HW_H_
+
+/***************************ENETC port registers**************************/
+#define ENETC4_ECAPR0			0x0
+#define  ECAPR0_RFS			BIT(2)
+#define  ECAPR0_TSD			BIT(5)
+#define  ECAPR0_RSS			BIT(8)
+#define  ECAPR0_RSC			BIT(9)
+#define  ECAPR0_LSO			BIT(10)
+#define  ECAPR0_WO			BIT(13)
+
+#define ENETC4_ECAPR1			0x4
+#define  ECAPR1_NUM_TCS			GENMASK(6, 4)
+#define  ECAPR1_NUM_MCH			GENMASK(9, 8)
+#define  ECAPR1_NUM_UCH			GENMASK(11, 10)
+#define  ECAPR1_NUM_MSIX		GENMASK(22, 12)
+#define  ECAPR1_NUM_VSI			GENMASK(27, 24)
+#define  ECAPR1_NUM_IPV			BIT(31)
+
+#define ENETC4_ECAPR2			0x8
+#define  ECAPR2_NUM_TX_BDR		GENMASK(9, 0)
+#define  ECAPR2_NUM_RX_BDR		GENMASK(25, 16)
+
+#define ENETC4_PMR			0x10
+#define  PMR_SI_EN(a)			BIT((16 + (a)))
+
+/* Port Pause ON/OFF threshold register */
+#define ENETC4_PPAUONTR			0x108
+#define ENETC4_PPAUOFFTR		0x10c
+
+/* Port Station interface promiscuous MAC mode register */
+#define ENETC4_PSIPMMR			0x200
+#define  PSIPMMR_SI0_MAC_UP		BIT(0)
+#define  PSIPMMR_SI_MAC_UP		GENMASK(2, 0)
+#define  PSIPMMR_SI0_MAC_MP		BIT(16)
+#define  PSIPMMR_SI_MAC_MP		GENMASK(18, 16)
+
+/* Port Station interface promiscuous VLAN mode register */
+#define ENETC4_PSIPVMR			0x204
+
+/* Port RSS key register n. n = 0,1,2,...,9 */
+#define ENETC4_PRSSKR(n)		((n) * 0x4 + 0x250)
+
+/* Port station interface MAC address filtering capability register */
+#define ENETC4_PSIMAFCAPR		0x280
+#define  PSIMAFCAPR_NUM_MAC_AFTE	GENMASK(11, 0)
+
+/* Port station interface VLAN filtering capability register */
+#define ENETC4_PSIVLANFCAPR		0x2c0
+#define  PSIVLANFCAPR_NUM_VLAN_FTE	GENMASK(11, 0)
+
+/* Port station interface VLAN filtering mode register */
+#define ENETC4_PSIVLANFMR		0x2c4
+#define  PSIVLANFMR_VS			BIT(0)
+
+/* Port Station interface a primary MAC address registers */
+#define ENETC4_PSIPMAR0(a)		((a) * 0x80 + 0x2000)
+#define ENETC4_PSIPMAR1(a)		((a) * 0x80 + 0x2004)
+
+/* Port station interface a configuration register 0/2 */
+#define ENETC4_PSICFGR0(a)		((a) * 0x80 + 0x2010)
+#define  PSICFGR0_VASE			BIT(13)
+#define  PSICFGR0_ASE			BIT(15)
+#define  PSICFGR0_ANTI_SPOOFING		(PSICFGR0_VASE | PSICFGR0_ASE)
+
+#define ENETC4_PSICFGR2(a)		((a) * 0x80 + 0x2018)
+
+#define ENETC4_PMCAPR			0x4004
+#define  PMCAPR_HD			BIT(8)
+#define  PMCAPR_FP			GENMASK(10, 9)
+
+/* Port configuration register */
+#define ENETC4_PCR			0x4010
+#define  PCR_HDR_FMT			BIT(0)
+#define  PCR_L2DOSE			BIT(4)
+#define  PCR_TIMER_CS			BIT(8)
+#define  PCR_PSPEED			GENMASK(29, 16)
+#define  PCR_PSPEED_VAL(speed)		(((speed) / 10 - 1) << 16)
+
+/* Port MAC address register 0/1 */
+#define ENETC4_PMAR0			0x4020
+#define ENETC4_PMAR1			0x4024
+
+/* Port operational register */
+#define ENETC4_POR			0x4100
+
+/* Port traffic class a transmit maximum SDU register */
+#define ENETC4_PTCTMSDUR(a)		((a) * 0x20 + 0x4208)
+#define  PTCTMSDUR_MAXSDU		GENMASK(15, 0)
+#define  PTCTMSDUR_SDU_TYPE		GENMASK(17, 16)
+#define   SDU_TYPE_PPDU			0
+#define   SDU_TYPE_MPDU			1
+#define   SDU_TYPE_MSDU			2
+
+#define ENETC4_PMAC_OFFSET		0x400
+#define ENETC4_PM_CMD_CFG(mac)		(0x5008 + (mac) * 0x400)
+#define  PM_CMD_CFG_TX_EN		BIT(0)
+#define  PM_CMD_CFG_RX_EN		BIT(1)
+#define  PM_CMD_CFG_PAUSE_FWD		BIT(7)
+#define  PM_CMD_CFG_PAUSE_IGN		BIT(8)
+#define  PM_CMD_CFG_TX_ADDR_INS		BIT(9)
+#define  PM_CMD_CFG_LOOP_EN		BIT(10)
+#define  PM_CMD_CFG_LPBK_MODE		GENMASK(12, 11)
+#define   LPBCK_MODE_EXT_TX_CLK		0
+#define   LPBCK_MODE_MAC_LEVEL		1
+#define   LPBCK_MODE_INT_TX_CLK		2
+#define  PM_CMD_CFG_CNT_FRM_EN		BIT(13)
+#define  PM_CMD_CFG_TXP			BIT(15)
+#define  PM_CMD_CFG_SEND_IDLE		BIT(16)
+#define  PM_CMD_CFG_HD_FCEN		BIT(18)
+#define  PM_CMD_CFG_SFD			BIT(21)
+#define  PM_CMD_CFG_TX_FLUSH		BIT(22)
+#define  PM_CMD_CFG_TX_LOWP_EN		BIT(23)
+#define  PM_CMD_CFG_RX_LOWP_EMPTY	BIT(24)
+#define  PM_CMD_CFG_SWR			BIT(26)
+#define  PM_CMD_CFG_TS_MODE		BIT(30)
+#define  PM_CMD_CFG_MG			BIT(31)
+
+/* Port MAC 0/1 Maximum Frame Length Register */
+#define ENETC4_PM_MAXFRM(mac)		(0x5014 + (mac) * 0x400)
+
+/* Port MAC 0/1 Pause Quanta Register */
+#define ENETC4_PM_PAUSE_QUANTA(mac)	(0x5054 + (mac) * 0x400)
+
+/* Port MAC 0/1 Pause Quanta Threshold Register */
+#define ENETC4_PM_PAUSE_THRESH(mac)	(0x5064 + (mac) * 0x400)
+
+/* Port MAC 0 Interface Mode Control Register */
+#define ENETC4_PM_IF_MODE(mac)		(0x5300 + (mac) * 0x400)
+#define  PM_IF_MODE_IFMODE		GENMASK(2, 0)
+#define   IFMODE_XGMII			0
+#define   IFMODE_RMII			3
+#define   IFMODE_RGMII			4
+#define   IFMODE_SGMII			5
+#define  PM_IF_MODE_REVMII		BIT(3)
+#define  PM_IF_MODE_M10			BIT(4)
+#define  PM_IF_MODE_HD			BIT(6)
+#define  PM_IF_MODE_SSP			GENMASK(14, 13)
+#define   SSP_100M			0
+#define   SSP_10M			1
+#define   SSP_1G			2
+#define  PM_IF_MODE_ENA			BIT(15)
+
+#endif
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
new file mode 100644
index 000000000000..cde529a19f13
--- /dev/null
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -0,0 +1,757 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/* Copyright 2024 NXP */
+#include <linux/clk.h>
+#include <linux/fsl/netc_global.h>
+#include <linux/module.h>
+#include <linux/of_net.h>
+#include <linux/of_platform.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/unaligned.h>
+
+#include "enetc_pf.h"
+
+#define ENETC_SI_MAX_RING_NUM	8
+
+static void enetc4_get_port_caps(struct enetc_pf *pf)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+	u32 val;
+
+	val = enetc_port_rd(hw, ENETC4_ECAPR1);
+	pf->caps.num_vsi = (val & ECAPR1_NUM_VSI) >> 24;
+	pf->caps.num_msix = ((val & ECAPR1_NUM_MSIX) >> 12) + 1;
+
+	val = enetc_port_rd(hw, ENETC4_ECAPR2);
+	pf->caps.num_rx_bdr = (val & ECAPR2_NUM_RX_BDR) >> 16;
+	pf->caps.num_tx_bdr = val & ECAPR2_NUM_TX_BDR;
+
+	val = enetc_port_rd(hw, ENETC4_PMCAPR);
+	pf->caps.half_duplex = (val & PMCAPR_HD) ? 1 : 0;
+}
+
+static void enetc4_pf_set_si_primary_mac(struct enetc_hw *hw, int si,
+					 const u8 *addr)
+{
+	u16 lower = get_unaligned_le16(addr + 4);
+	u32 upper = get_unaligned_le32(addr);
+
+	if (si != 0) {
+		__raw_writel(upper, hw->port + ENETC4_PSIPMAR0(si));
+		__raw_writew(lower, hw->port + ENETC4_PSIPMAR1(si));
+	} else {
+		__raw_writel(upper, hw->port + ENETC4_PMAR0);
+		__raw_writew(lower, hw->port + ENETC4_PMAR1);
+	}
+}
+
+static void enetc4_pf_get_si_primary_mac(struct enetc_hw *hw, int si,
+					 u8 *addr)
+{
+	u32 upper;
+	u16 lower;
+
+	upper = __raw_readl(hw->port + ENETC4_PSIPMAR0(si));
+	lower = __raw_readw(hw->port + ENETC4_PSIPMAR1(si));
+
+	put_unaligned_le32(upper, addr);
+	put_unaligned_le16(lower, addr + 4);
+}
+
+static const struct enetc_pf_ops enetc4_pf_ops = {
+	.set_si_primary_mac = enetc4_pf_set_si_primary_mac,
+	.get_si_primary_mac = enetc4_pf_get_si_primary_mac,
+};
+
+static int enetc4_pf_struct_init(struct enetc_si *si)
+{
+	struct enetc_pf *pf = enetc_si_priv(si);
+
+	pf->si = si;
+	pf->total_vfs = pci_sriov_get_totalvfs(si->pdev);
+
+	enetc4_get_port_caps(pf);
+	enetc_pf_ops_register(pf, &enetc4_pf_ops);
+
+	return 0;
+}
+
+static u32 enetc4_psicfgr0_val_construct(bool is_vf, u32 num_tx_bdr, u32 num_rx_bdr)
+{
+	u32 val;
+
+	val = ENETC_PSICFGR0_SET_TXBDR(num_tx_bdr);
+	val |= ENETC_PSICFGR0_SET_RXBDR(num_rx_bdr);
+	val |= ENETC_PSICFGR0_SIVC(ENETC_VLAN_TYPE_C | ENETC_VLAN_TYPE_S);
+
+	if (is_vf)
+		val |= ENETC_PSICFGR0_VTE | ENETC_PSICFGR0_SIVIE;
+
+	return val;
+}
+
+static void enetc4_default_rings_allocation(struct enetc_pf *pf)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+	u32 num_rx_bdr, num_tx_bdr, val;
+	u32 vf_tx_bdr, vf_rx_bdr;
+	int i, rx_rem, tx_rem;
+
+	if (pf->caps.num_rx_bdr < ENETC_SI_MAX_RING_NUM + pf->caps.num_vsi)
+		num_rx_bdr = pf->caps.num_rx_bdr - pf->caps.num_vsi;
+	else
+		num_rx_bdr = ENETC_SI_MAX_RING_NUM;
+
+	if (pf->caps.num_tx_bdr < ENETC_SI_MAX_RING_NUM + pf->caps.num_vsi)
+		num_tx_bdr = pf->caps.num_tx_bdr - pf->caps.num_vsi;
+	else
+		num_tx_bdr = ENETC_SI_MAX_RING_NUM;
+
+	val = enetc4_psicfgr0_val_construct(false, num_tx_bdr, num_rx_bdr);
+	enetc_port_wr(hw, ENETC4_PSICFGR0(0), val);
+
+	num_rx_bdr = pf->caps.num_rx_bdr - num_rx_bdr;
+	rx_rem = num_rx_bdr % pf->caps.num_vsi;
+	num_rx_bdr = num_rx_bdr / pf->caps.num_vsi;
+
+	num_tx_bdr = pf->caps.num_tx_bdr - num_tx_bdr;
+	tx_rem = num_tx_bdr % pf->caps.num_vsi;
+	num_tx_bdr = num_tx_bdr / pf->caps.num_vsi;
+
+	for (i = 0; i < pf->caps.num_vsi; i++) {
+		vf_tx_bdr = (i < tx_rem) ? num_tx_bdr + 1 : num_tx_bdr;
+		vf_rx_bdr = (i < rx_rem) ? num_rx_bdr + 1 : num_rx_bdr;
+		val = enetc4_psicfgr0_val_construct(true, vf_tx_bdr, vf_rx_bdr);
+		enetc_port_wr(hw, ENETC4_PSICFGR0(i + 1), val);
+	}
+}
+
+static void enetc4_allocate_si_rings(struct enetc_pf *pf)
+{
+	enetc4_default_rings_allocation(pf);
+}
+
+static void enetc4_pf_set_si_vlan_promisc(struct enetc_hw *hw, int si, bool en)
+{
+	u32 val = enetc_port_rd(hw, ENETC4_PSIPVMR);
+
+	if (en)
+		val |= BIT(si);
+	else
+		val &= ~BIT(si);
+
+	enetc_port_wr(hw, ENETC4_PSIPVMR, val);
+}
+
+static void enetc4_set_default_si_vlan_promisc(struct enetc_pf *pf)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+	int num_si = pf->caps.num_vsi + 1;
+	int i;
+
+	/* enforce VLAN promisc mode for all SIs */
+	for (i = 0; i < num_si; i++)
+		enetc4_pf_set_si_vlan_promisc(hw, i, true);
+}
+
+/* Allocate the number of MSI-X vectors for per SI. */
+static void enetc4_set_si_msix_num(struct enetc_pf *pf)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+	int i, num_msix, total_si;
+	u32 val;
+
+	total_si = pf->caps.num_vsi + 1;
+
+	num_msix = pf->caps.num_msix / total_si +
+		   pf->caps.num_msix % total_si - 1;
+	val = num_msix & 0x3f;
+	enetc_port_wr(hw, ENETC4_PSICFGR2(0), val);
+
+	num_msix = pf->caps.num_msix / total_si - 1;
+	val = num_msix & 0x3f;
+	for (i = 0; i < pf->caps.num_vsi; i++)
+		enetc_port_wr(hw, ENETC4_PSICFGR2(i + 1), val);
+}
+
+static void enetc4_enable_all_si(struct enetc_pf *pf)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+	int num_si = pf->caps.num_vsi + 1;
+	u32 si_bitmap = 0;
+	int i;
+
+	/* Master enable for all SIs */
+	for (i = 0; i < num_si; i++)
+		si_bitmap |= PMR_SI_EN(i);
+
+	enetc_port_wr(hw, ENETC4_PMR, si_bitmap);
+}
+
+static void enetc4_configure_port_si(struct enetc_pf *pf)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+
+	enetc4_allocate_si_rings(pf);
+
+	/* Outer VLAN tag will be used for VLAN filtering */
+	enetc_port_wr(hw, ENETC4_PSIVLANFMR, PSIVLANFMR_VS);
+
+	enetc4_set_default_si_vlan_promisc(pf);
+
+	/* Disable SI MAC multicast & unicast promiscuous */
+	enetc_port_wr(hw, ENETC4_PSIPMMR, 0);
+
+	enetc4_set_si_msix_num(pf);
+
+	enetc4_enable_all_si(pf);
+}
+
+static void enetc4_pf_reset_tc_msdu(struct enetc_hw *hw)
+{
+	u32 val = ENETC_MAC_MAXFRM_SIZE;
+	int tc;
+
+	val = u32_replace_bits(val, SDU_TYPE_MPDU, PTCTMSDUR_SDU_TYPE);
+
+	for (tc = 0; tc < 8; tc++)
+		enetc_port_wr(hw, ENETC4_PTCTMSDUR(tc), val);
+}
+
+static void enetc4_set_trx_frame_size(struct enetc_pf *pf)
+{
+	struct enetc_si *si = pf->si;
+
+	enetc_port_mac_wr(si, ENETC4_PM_MAXFRM(0),
+			  ENETC_SET_MAXFRM(ENETC_MAC_MAXFRM_SIZE));
+
+	enetc4_pf_reset_tc_msdu(&si->hw);
+}
+
+static void enetc4_set_rss_key(struct enetc_hw *hw, const u8 *bytes)
+{
+	int i;
+
+	for (i = 0; i < ENETC_RSSHASH_KEY_SIZE / 4; i++)
+		enetc_port_wr(hw, ENETC4_PRSSKR(i), ((u32 *)bytes)[i]);
+}
+
+static void enetc4_set_default_rss_key(struct enetc_pf *pf)
+{
+	u8 hash_key[ENETC_RSSHASH_KEY_SIZE] = {0};
+	struct enetc_hw *hw = &pf->si->hw;
+
+	/* set up hash key */
+	get_random_bytes(hash_key, ENETC_RSSHASH_KEY_SIZE);
+	enetc4_set_rss_key(hw, hash_key);
+}
+
+static void enetc4_enable_trx(struct enetc_pf *pf)
+{
+	struct enetc_hw *hw = &pf->si->hw;
+
+	/* Enable port transmit/receive */
+	enetc_port_wr(hw, ENETC4_POR, 0);
+}
+
+static void enetc4_configure_port(struct enetc_pf *pf)
+{
+	enetc4_configure_port_si(pf);
+	enetc4_set_trx_frame_size(pf);
+	enetc4_set_default_rss_key(pf);
+	enetc4_enable_trx(pf);
+}
+
+static int enetc4_pf_init(struct enetc_pf *pf)
+{
+	struct device *dev = &pf->si->pdev->dev;
+	int err;
+
+	/* Initialize the MAC address for PF and VFs */
+	err = enetc_setup_mac_addresses(dev->of_node, pf);
+	if (err) {
+		dev_err(dev, "Failed to set MAC addresses\n");
+		return err;
+	}
+
+	enetc4_configure_port(pf);
+
+	return 0;
+}
+
+static const struct net_device_ops enetc4_ndev_ops = {
+	.ndo_open		= enetc_open,
+	.ndo_stop		= enetc_close,
+	.ndo_start_xmit		= enetc_xmit,
+	.ndo_get_stats		= enetc_get_stats,
+	.ndo_set_mac_address	= enetc_pf_set_mac_addr,
+};
+
+static struct phylink_pcs *
+enetc4_pl_mac_select_pcs(struct phylink_config *config, phy_interface_t iface)
+{
+	struct enetc_pf *pf = phylink_to_enetc_pf(config);
+
+	return pf->pcs;
+}
+
+static void enetc4_mac_config(struct enetc_pf *pf, unsigned int mode,
+			      phy_interface_t phy_mode)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(pf->si->ndev);
+	struct enetc_si *si = pf->si;
+	u32 val;
+
+	val = enetc_port_mac_rd(si, ENETC4_PM_IF_MODE(0));
+	val &= ~(PM_IF_MODE_IFMODE | PM_IF_MODE_ENA);
+
+	switch (phy_mode) {
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		val |= IFMODE_RGMII;
+		/* We need to enable auto-negotiation for the MAC
+		 * if its RGMII interface support In-Band status.
+		 */
+		if (phylink_autoneg_inband(mode))
+			val |= PM_IF_MODE_ENA;
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		val |= IFMODE_RMII;
+		break;
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_2500BASEX:
+		val |= IFMODE_SGMII;
+		break;
+	case PHY_INTERFACE_MODE_10GBASER:
+	case PHY_INTERFACE_MODE_XGMII:
+	case PHY_INTERFACE_MODE_USXGMII:
+		val |= IFMODE_XGMII;
+		break;
+	default:
+		dev_err(priv->dev,
+			"Unsupported PHY mode:%d\n", phy_mode);
+		return;
+	}
+
+	enetc_port_mac_wr(si, ENETC4_PM_IF_MODE(0), val);
+}
+
+static void enetc4_pl_mac_config(struct phylink_config *config, unsigned int mode,
+				 const struct phylink_link_state *state)
+{
+	struct enetc_pf *pf = phylink_to_enetc_pf(config);
+
+	enetc4_mac_config(pf, mode, state->interface);
+}
+
+static void enetc4_set_port_speed(struct enetc_ndev_priv *priv, int speed)
+{
+	u32 old_speed = priv->speed;
+	u32 val;
+
+	if (speed == old_speed)
+		return;
+
+	val = enetc_port_rd(&priv->si->hw, ENETC4_PCR);
+	val &= ~PCR_PSPEED;
+
+	switch (speed) {
+	case SPEED_100:
+	case SPEED_1000:
+	case SPEED_2500:
+	case SPEED_10000:
+		val |= (PCR_PSPEED & PCR_PSPEED_VAL(speed));
+		break;
+	case SPEED_10:
+	default:
+		val |= (PCR_PSPEED & PCR_PSPEED_VAL(SPEED_10));
+	}
+
+	priv->speed = speed;
+	enetc_port_wr(&priv->si->hw, ENETC4_PCR, val);
+}
+
+static void enetc4_set_rgmii_mac(struct enetc_pf *pf, int speed, int duplex)
+{
+	struct enetc_si *si = pf->si;
+	u32 old_val, val;
+
+	old_val = enetc_port_mac_rd(si, ENETC4_PM_IF_MODE(0));
+	val = old_val & ~(PM_IF_MODE_ENA | PM_IF_MODE_M10 | PM_IF_MODE_REVMII);
+
+	switch (speed) {
+	case SPEED_1000:
+		val = u32_replace_bits(val, SSP_1G, PM_IF_MODE_SSP);
+		break;
+	case SPEED_100:
+		val = u32_replace_bits(val, SSP_100M, PM_IF_MODE_SSP);
+		break;
+	case SPEED_10:
+		val = u32_replace_bits(val, SSP_10M, PM_IF_MODE_SSP);
+	}
+
+	val = u32_replace_bits(val, duplex == DUPLEX_FULL ? 0 : 1,
+			       PM_IF_MODE_HD);
+
+	if (val == old_val)
+		return;
+
+	enetc_port_mac_wr(si, ENETC4_PM_IF_MODE(0), val);
+}
+
+static void enetc4_set_rmii_mac(struct enetc_pf *pf, int speed, int duplex)
+{
+	struct enetc_si *si = pf->si;
+	u32 old_val, val;
+
+	old_val = enetc_port_mac_rd(si, ENETC4_PM_IF_MODE(0));
+	val = old_val & ~(PM_IF_MODE_ENA | PM_IF_MODE_SSP);
+
+	switch (speed) {
+	case SPEED_100:
+		val &= ~PM_IF_MODE_M10;
+		break;
+	case SPEED_10:
+		val |= PM_IF_MODE_M10;
+	}
+
+	val = u32_replace_bits(val, duplex == DUPLEX_FULL ? 0 : 1,
+			       PM_IF_MODE_HD);
+
+	if (val == old_val)
+		return;
+
+	enetc_port_mac_wr(si, ENETC4_PM_IF_MODE(0), val);
+}
+
+static void enetc4_set_hd_flow_control(struct enetc_pf *pf, bool enable)
+{
+	struct enetc_si *si = pf->si;
+	u32 old_val, val;
+
+	if (!pf->caps.half_duplex)
+		return;
+
+	old_val = enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
+	val = u32_replace_bits(old_val, enable ? 1 : 0, PM_CMD_CFG_HD_FCEN);
+	if (val == old_val)
+		return;
+
+	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
+}
+
+static void enetc4_set_rx_pause(struct enetc_pf *pf, bool rx_pause)
+{
+	struct enetc_si *si = pf->si;
+	u32 old_val, val;
+
+	old_val = enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
+	val = u32_replace_bits(old_val, rx_pause ? 0 : 1, PM_CMD_CFG_PAUSE_IGN);
+	if (val == old_val)
+		return;
+
+	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
+}
+
+static void enetc4_set_tx_pause(struct enetc_pf *pf, int num_rxbdr, bool tx_pause)
+{
+	u32 pause_off_thresh = 0, pause_on_thresh = 0;
+	u32 init_quanta = 0, refresh_quanta = 0;
+	struct enetc_hw *hw = &pf->si->hw;
+	u32 rbmr, old_rbmr;
+	int i;
+
+	for (i = 0; i < num_rxbdr; i++) {
+		old_rbmr = enetc_rxbdr_rd(hw, i, ENETC_RBMR);
+		rbmr = u32_replace_bits(old_rbmr, tx_pause ? 1 : 0, ENETC_RBMR_CM);
+		if (rbmr == old_rbmr)
+			continue;
+
+		enetc_rxbdr_wr(hw, i, ENETC_RBMR, rbmr);
+	}
+
+	if (tx_pause) {
+		/* When the port first enters congestion, send a PAUSE request
+		 * with the maximum number of quanta. When the port exits
+		 * congestion, it will automatically send a PAUSE frame with
+		 * zero quanta.
+		 */
+		init_quanta = 0xffff;
+
+		/* Also, set up the refresh timer to send follow-up PAUSE
+		 * frames at half the quanta value, in case the congestion
+		 * condition persists.
+		 */
+		refresh_quanta = 0xffff / 2;
+
+		/* Start emitting PAUSE frames when 3 large frames (or more
+		 * smaller frames) have accumulated in the FIFO waiting to be
+		 * DMAed to the RX ring.
+		 */
+		pause_on_thresh = 3 * ENETC_MAC_MAXFRM_SIZE;
+		pause_off_thresh = 1 * ENETC_MAC_MAXFRM_SIZE;
+	}
+
+	enetc_port_mac_wr(pf->si, ENETC4_PM_PAUSE_QUANTA(0), init_quanta);
+	enetc_port_mac_wr(pf->si, ENETC4_PM_PAUSE_THRESH(0), refresh_quanta);
+	enetc_port_wr(hw, ENETC4_PPAUONTR, pause_on_thresh);
+	enetc_port_wr(hw, ENETC4_PPAUOFFTR, pause_off_thresh);
+}
+
+static void enetc4_enable_mac(struct enetc_pf *pf, bool en)
+{
+	struct enetc_si *si = pf->si;
+	u32 val;
+
+	val = enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
+	val &= ~(PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN);
+	val |= en ? (PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN) : 0;
+
+	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
+}
+
+static void enetc4_pl_mac_link_up(struct phylink_config *config,
+				  struct phy_device *phy, unsigned int mode,
+				  phy_interface_t interface, int speed,
+				  int duplex, bool tx_pause, bool rx_pause)
+{
+	struct enetc_pf *pf = phylink_to_enetc_pf(config);
+	struct enetc_si *si = pf->si;
+	struct enetc_ndev_priv *priv;
+	bool hd_fc = false;
+
+	priv = netdev_priv(si->ndev);
+	enetc4_set_port_speed(priv, speed);
+
+	if (!phylink_autoneg_inband(mode) &&
+	    phy_interface_mode_is_rgmii(interface))
+		enetc4_set_rgmii_mac(pf, speed, duplex);
+
+	if (interface == PHY_INTERFACE_MODE_RMII)
+		enetc4_set_rmii_mac(pf, speed, duplex);
+
+	if (duplex == DUPLEX_FULL) {
+		/* When preemption is enabled, generation of PAUSE frames
+		 * must be disabled, as stated in the IEEE 802.3 standard.
+		 */
+		if (priv->active_offloads & ENETC_F_QBU)
+			tx_pause = false;
+	} else { /* DUPLEX_HALF */
+		if (tx_pause || rx_pause)
+			hd_fc = true;
+
+		/* As per 802.3 annex 31B, PAUSE frames are only supported
+		 * when the link is configured for full duplex operation.
+		 */
+		tx_pause = false;
+		rx_pause = false;
+	}
+
+	enetc4_set_hd_flow_control(pf, hd_fc);
+	enetc4_set_tx_pause(pf, priv->num_rx_rings, tx_pause);
+	enetc4_set_rx_pause(pf, rx_pause);
+	enetc4_enable_mac(pf, true);
+}
+
+static void enetc4_pl_mac_link_down(struct phylink_config *config,
+				    unsigned int mode,
+				    phy_interface_t interface)
+{
+	struct enetc_pf *pf = phylink_to_enetc_pf(config);
+
+	enetc4_enable_mac(pf, false);
+}
+
+static const struct phylink_mac_ops enetc_pl_mac_ops = {
+	.mac_select_pcs = enetc4_pl_mac_select_pcs,
+	.mac_config = enetc4_pl_mac_config,
+	.mac_link_up = enetc4_pl_mac_link_up,
+	.mac_link_down = enetc4_pl_mac_link_down,
+};
+
+static int enetc4_link_init(struct enetc_ndev_priv *priv,
+			    struct device_node *node)
+{
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct device *dev = priv->dev;
+	int err;
+
+	err = of_get_phy_mode(node, &pf->if_mode);
+	if (err) {
+		dev_err(dev, "Failed to get PHY mode\n");
+		return err;
+	}
+
+	err = enetc_mdiobus_create(pf, node);
+	if (err) {
+		dev_err(dev, "Failed to create MDIO bus\n");
+		return err;
+	}
+
+	err = enetc_phylink_create(priv, node, &enetc_pl_mac_ops);
+	if (err) {
+		dev_err(dev, "Failed to create phylink\n");
+		goto err_phylink_create;
+	}
+
+	return 0;
+
+err_phylink_create:
+	enetc_mdiobus_destroy(pf);
+
+	return err;
+}
+
+static void enetc4_link_deinit(struct enetc_ndev_priv *priv)
+{
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
+
+	enetc_phylink_destroy(priv);
+	enetc_mdiobus_destroy(pf);
+}
+
+static int enetc4_pf_netdev_create(struct enetc_si *si)
+{
+	struct device *dev = &si->pdev->dev;
+	struct enetc_ndev_priv *priv;
+	struct net_device *ndev;
+	int err;
+
+	ndev = alloc_etherdev_mqs(sizeof(struct enetc_ndev_priv),
+				  si->num_tx_rings, si->num_rx_rings);
+	if (!ndev)
+		return  -ENOMEM;
+
+	priv = netdev_priv(ndev);
+	priv->ref_clk = devm_clk_get_optional(dev, "enet_ref_clk");
+	if (IS_ERR(priv->ref_clk)) {
+		dev_err(dev, "Get enet_ref_clk failed\n");
+		err = PTR_ERR(priv->ref_clk);
+		goto err_clk_get;
+	}
+
+	enetc_pf_netdev_setup(si, ndev, &enetc4_ndev_ops);
+
+	enetc_init_si_rings_params(priv);
+
+	err = enetc_configure_si(priv);
+	if (err) {
+		dev_err(dev, "Failed to configure SI\n");
+		goto err_config_si;
+	}
+
+	err = enetc_alloc_msix(priv);
+	if (err) {
+		dev_err(dev, "Failed to alloc MSI-X\n");
+		goto err_alloc_msix;
+	}
+
+	err = enetc4_link_init(priv, dev->of_node);
+	if (err)
+		goto err_link_init;
+
+	err = register_netdev(ndev);
+	if (err) {
+		dev_err(dev, "Failed to register netdev\n");
+		goto err_reg_netdev;
+	}
+
+	return 0;
+
+err_reg_netdev:
+	enetc4_link_deinit(priv);
+err_link_init:
+	enetc_free_msix(priv);
+err_alloc_msix:
+err_config_si:
+err_clk_get:
+	mutex_destroy(&priv->mm_lock);
+	free_netdev(ndev);
+
+	return err;
+}
+
+static void enetc4_pf_netdev_destroy(struct enetc_si *si)
+{
+	struct net_device *ndev = si->ndev;
+	struct enetc_ndev_priv *priv;
+
+	priv = netdev_priv(ndev);
+	unregister_netdev(ndev);
+	enetc_free_msix(priv);
+	free_netdev(ndev);
+}
+
+static int enetc4_pf_probe(struct pci_dev *pdev,
+			   const struct pci_device_id *ent)
+{
+	struct device *dev = &pdev->dev;
+	struct enetc_si *si;
+	struct enetc_pf *pf;
+	int err;
+
+	err = enetc_pci_probe(pdev, KBUILD_MODNAME, sizeof(*pf));
+	if (err) {
+		dev_err_probe(dev, err, "PCIe probing failed\n");
+		return err;
+	}
+
+	/* si is the private data. */
+	si = pci_get_drvdata(pdev);
+	if (!si->hw.port || !si->hw.global) {
+		err = -ENODEV;
+		dev_err_probe(dev, err, "Couldn't map PF only space\n");
+		goto err_enetc_pci_probe;
+	}
+
+	err = enetc4_pf_struct_init(si);
+	if (err)
+		goto err_pf_struct_init;
+
+	pf = enetc_si_priv(si);
+	err = enetc4_pf_init(pf);
+	if (err)
+		goto err_pf_init;
+
+	pinctrl_pm_select_default_state(dev);
+	enetc_get_si_caps(si);
+	err = enetc4_pf_netdev_create(si);
+	if (err)
+		goto err_netdev_create;
+
+	return 0;
+
+err_netdev_create:
+err_pf_init:
+err_pf_struct_init:
+err_enetc_pci_probe:
+	enetc_pci_remove(pdev);
+
+	return err;
+}
+
+static void enetc4_pf_remove(struct pci_dev *pdev)
+{
+	struct enetc_si *si = pci_get_drvdata(pdev);
+
+	enetc4_pf_netdev_destroy(si);
+	enetc_pci_remove(pdev);
+}
+
+static const struct pci_device_id enetc4_pf_id_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_NXP2, PCI_DEVICE_ID_NXP2_ENETC_PF) },
+	{ 0, } /* End of table. */
+};
+MODULE_DEVICE_TABLE(pci, enetc4_pf_id_table);
+
+static struct pci_driver enetc4_pf_driver = {
+	.name = KBUILD_MODNAME,
+	.id_table = enetc4_pf_id_table,
+	.probe = enetc4_pf_probe,
+	.remove = enetc4_pf_remove,
+};
+module_pci_driver(enetc4_pf_driver);
+
+MODULE_DESCRIPTION("ENETC4 PF Driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 2563eb8ac7b6..13ce771e0c43 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -44,6 +44,9 @@ static int enetc_get_reglen(struct net_device *ndev)
 	struct enetc_hw *hw = &priv->si->hw;
 	int len;
 
+	if (is_enetc_rev4(priv->si))
+		return -EOPNOTSUPP;
+
 	len = ARRAY_SIZE(enetc_si_regs);
 	len += ARRAY_SIZE(enetc_txbdr_regs) * priv->num_tx_rings;
 	len += ARRAY_SIZE(enetc_rxbdr_regs) * priv->num_rx_rings;
@@ -68,6 +71,9 @@ static void enetc_get_regs(struct net_device *ndev, struct ethtool_regs *regs,
 	int i, j;
 	u32 addr;
 
+	if (is_enetc_rev4(priv->si))
+		return;
+
 	for (i = 0; i < ARRAY_SIZE(enetc_si_regs); i++) {
 		*buf++ = enetc_si_regs[i];
 		*buf++ = enetc_rd(hw, enetc_si_regs[i]);
@@ -229,6 +235,9 @@ static int enetc_get_sset_count(struct net_device *ndev, int sset)
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	int len;
 
+	if (is_enetc_rev4(priv->si))
+		return -EOPNOTSUPP;
+
 	if (sset != ETH_SS_STATS)
 		return -EOPNOTSUPP;
 
@@ -250,6 +259,9 @@ static void enetc_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
 	u8 *p = data;
 	int i, j;
 
+	if (is_enetc_rev4(priv->si))
+		return;
+
 	switch (stringset) {
 	case ETH_SS_STATS:
 		for (i = 0; i < ARRAY_SIZE(enetc_si_counters); i++) {
@@ -290,6 +302,9 @@ static void enetc_get_ethtool_stats(struct net_device *ndev,
 	struct enetc_hw *hw = &priv->si->hw;
 	int i, o = 0;
 
+	if (is_enetc_rev4(priv->si))
+		return;
+
 	for (i = 0; i < ARRAY_SIZE(enetc_si_counters); i++)
 		data[o++] = enetc_rd64(hw, enetc_si_counters[i].reg);
 
@@ -331,6 +346,9 @@ static void enetc_get_pause_stats(struct net_device *ndev,
 	struct enetc_hw *hw = &priv->si->hw;
 	struct enetc_si *si = priv->si;
 
+	if (is_enetc_rev4(si))
+		return;
+
 	switch (pause_stats->src) {
 	case ETHTOOL_MAC_STATS_SRC_EMAC:
 		enetc_pause_stats(hw, 0, pause_stats);
@@ -418,6 +436,9 @@ static void enetc_get_eth_mac_stats(struct net_device *ndev,
 	struct enetc_hw *hw = &priv->si->hw;
 	struct enetc_si *si = priv->si;
 
+	if (is_enetc_rev4(si))
+		return;
+
 	switch (mac_stats->src) {
 	case ETHTOOL_MAC_STATS_SRC_EMAC:
 		enetc_mac_stats(hw, 0, mac_stats);
@@ -439,6 +460,9 @@ static void enetc_get_eth_ctrl_stats(struct net_device *ndev,
 	struct enetc_hw *hw = &priv->si->hw;
 	struct enetc_si *si = priv->si;
 
+	if (is_enetc_rev4(si))
+		return;
+
 	switch (ctrl_stats->src) {
 	case ETHTOOL_MAC_STATS_SRC_EMAC:
 		enetc_ctrl_stats(hw, 0, ctrl_stats);
@@ -461,6 +485,9 @@ static void enetc_get_rmon_stats(struct net_device *ndev,
 	struct enetc_hw *hw = &priv->si->hw;
 	struct enetc_si *si = priv->si;
 
+	if (is_enetc_rev4(si))
+		return;
+
 	*ranges = enetc_rmon_ranges;
 
 	switch (rmon_stats->src) {
@@ -593,6 +620,9 @@ static int enetc_get_rxnfc(struct net_device *ndev, struct ethtool_rxnfc *rxnfc,
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	int i, j;
 
+	if (is_enetc_rev4(priv->si))
+		return -EOPNOTSUPP;
+
 	switch (rxnfc->cmd) {
 	case ETHTOOL_GRXRINGS:
 		rxnfc->data = priv->num_rx_rings;
@@ -643,6 +673,9 @@ static int enetc_set_rxnfc(struct net_device *ndev, struct ethtool_rxnfc *rxnfc)
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	int err;
 
+	if (is_enetc_rev4(priv->si))
+		return -EOPNOTSUPP;
+
 	switch (rxnfc->cmd) {
 	case ETHTOOL_SRXCLSRLINS:
 		if (rxnfc->fs.location >= priv->si->num_fs_entries)
@@ -678,6 +711,9 @@ static u32 enetc_get_rxfh_key_size(struct net_device *ndev)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 
+	if (is_enetc_rev4(priv->si))
+		return 0;
+
 	/* return the size of the RX flow hash key.  PF only */
 	return (priv->si->hw.port) ? ENETC_RSSHASH_KEY_SIZE : 0;
 }
@@ -686,6 +722,9 @@ static u32 enetc_get_rxfh_indir_size(struct net_device *ndev)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 
+	if (is_enetc_rev4(priv->si))
+		return 0;
+
 	/* return the size of the RX flow hash indirection table */
 	return priv->si->num_rss;
 }
@@ -697,6 +736,9 @@ static int enetc_get_rxfh(struct net_device *ndev,
 	struct enetc_hw *hw = &priv->si->hw;
 	int err = 0, i;
 
+	if (is_enetc_rev4(priv->si))
+		return -EOPNOTSUPP;
+
 	/* return hash function */
 	rxfh->hfunc = ETH_RSS_HASH_TOP;
 
@@ -731,6 +773,9 @@ static int enetc_set_rxfh(struct net_device *ndev,
 	struct enetc_hw *hw = &priv->si->hw;
 	int err = 0;
 
+	if (is_enetc_rev4(priv->si))
+		return -EOPNOTSUPP;
+
 	/* set hash key, if PF */
 	if (rxfh->key && hw->port)
 		enetc_set_rss_key(hw, rxfh->key);
@@ -775,9 +820,10 @@ static int enetc_get_coalesce(struct net_device *ndev,
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_int_vector *v = priv->int_vector[0];
+	u64 clk_freq = priv->si->clk_freq;
 
-	ic->tx_coalesce_usecs = enetc_cycles_to_usecs(priv->tx_ictt);
-	ic->rx_coalesce_usecs = enetc_cycles_to_usecs(v->rx_ictt);
+	ic->tx_coalesce_usecs = enetc_cycles_to_usecs(priv->tx_ictt, clk_freq);
+	ic->rx_coalesce_usecs = enetc_cycles_to_usecs(v->rx_ictt, clk_freq);
 
 	ic->tx_max_coalesced_frames = ENETC_TXIC_PKTTHR;
 	ic->rx_max_coalesced_frames = ENETC_RXIC_PKTTHR;
@@ -793,12 +839,13 @@ static int enetc_set_coalesce(struct net_device *ndev,
 			      struct netlink_ext_ack *extack)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	u64 clk_freq = priv->si->clk_freq;
 	u32 rx_ictt, tx_ictt;
 	int i, ic_mode;
 	bool changed;
 
-	tx_ictt = enetc_usecs_to_cycles(ic->tx_coalesce_usecs);
-	rx_ictt = enetc_usecs_to_cycles(ic->rx_coalesce_usecs);
+	tx_ictt = enetc_usecs_to_cycles(ic->tx_coalesce_usecs, clk_freq);
+	rx_ictt = enetc_usecs_to_cycles(ic->rx_coalesce_usecs, clk_freq);
 
 	if (ic->rx_max_coalesced_frames != ENETC_RXIC_PKTTHR)
 		return -EOPNOTSUPP;
@@ -843,8 +890,12 @@ static int enetc_set_coalesce(struct net_device *ndev,
 static int enetc_get_ts_info(struct net_device *ndev,
 			     struct kernel_ethtool_ts_info *info)
 {
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	int *phc_idx;
 
+	if (is_enetc_rev4(priv->si))
+		return -EOPNOTSUPP;
+
 	phc_idx = symbol_get(enetc_phc_index);
 	if (phc_idx) {
 		info->phc_index = *phc_idx;
@@ -942,6 +993,9 @@ static void enetc_get_mm_stats(struct net_device *ndev,
 	struct enetc_hw *hw = &priv->si->hw;
 	struct enetc_si *si = priv->si;
 
+	if (is_enetc_rev4(si))
+		return;
+
 	if (!(si->hw_features & ENETC_SI_F_QBU))
 		return;
 
@@ -960,6 +1014,9 @@ static int enetc_get_mm(struct net_device *ndev, struct ethtool_mm_state *state)
 	struct enetc_hw *hw = &si->hw;
 	u32 lafs, rafs, val;
 
+	if (is_enetc_rev4(si))
+		return -EOPNOTSUPP;
+
 	if (!(si->hw_features & ENETC_SI_F_QBU))
 		return -EOPNOTSUPP;
 
@@ -1090,6 +1147,9 @@ static int enetc_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
 	u32 val, add_frag_size;
 	int err;
 
+	if (is_enetc_rev4(si))
+		return -EOPNOTSUPP;
+
 	if (!(si->hw_features & ENETC_SI_F_QBU))
 		return -EOPNOTSUPP;
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 6a7b9b75d660..230e94986091 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -25,6 +25,7 @@
 #define ENETC_SIPCAPR0_RSS	BIT(8)
 #define ENETC_SIPCAPR0_QBV	BIT(4)
 #define ENETC_SIPCAPR0_QBU	BIT(3)
+#define ENETC_SIPCAPR0_RFS	BIT(2)
 #define ENETC_SIPCAPR1	0x24
 #define ENETC_SITGTGR	0x30
 #define ENETC_SIRBGCR	0x38
@@ -971,15 +972,16 @@ struct enetc_cbd {
 	u8 status_flags;
 };
 
-#define ENETC_CLK  400000000ULL
-static inline u32 enetc_cycles_to_usecs(u32 cycles)
+#define ENETC_CLK		400000000ULL
+#define ENETC_CLK_333M		333000000ULL
+static inline u32 enetc_cycles_to_usecs(u32 cycles, u64 clk_freq)
 {
-	return (u32)div_u64(cycles * 1000000ULL, ENETC_CLK);
+	return (u32)div_u64(cycles * 1000000ULL, clk_freq);
 }
 
-static inline u32 enetc_usecs_to_cycles(u32 usecs)
+static inline u32 enetc_usecs_to_cycles(u32 usecs, u64 clk_freq)
 {
-	return (u32)div_u64(usecs * ENETC_CLK, 1000000ULL);
+	return (u32)div_u64(usecs * clk_freq, 1000000ULL);
 }
 
 /* Port traffic class frame preemption register */
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 39db9d5c2e50..5ed97137e5c5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -28,6 +28,14 @@ struct enetc_vf_state {
 	enum enetc_vf_flags flags;
 };
 
+struct enetc_port_caps {
+	u32 half_duplex:1;
+	int num_vsi;
+	int num_msix;
+	int num_rx_bdr;
+	int num_tx_bdr;
+};
+
 struct enetc_pf;
 
 struct enetc_pf_ops {
@@ -61,6 +69,7 @@ struct enetc_pf {
 	phy_interface_t if_mode;
 	struct phylink_config phylink_config;
 
+	struct enetc_port_caps caps;
 	const struct enetc_pf_ops *ops;
 };
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 2c6ce887f583..18fe7861a6fe 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -120,10 +120,17 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
 			      NETIF_F_TSO | NETIF_F_TSO6;
 
+	ndev->priv_flags |= IFF_UNICAST_FLT;
+
+	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
+	if (is_enetc_rev4(si)) {
+		ndev->hw_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK);
+		goto end;
+	}
+
 	if (si->num_rss)
 		ndev->hw_features |= NETIF_F_RXHASH;
 
-	ndev->priv_flags |= IFF_UNICAST_FLT;
 	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 			     NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
 			     NETDEV_XDP_ACT_NDO_XMIT_SG;
@@ -135,6 +142,7 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 		ndev->hw_features |= NETIF_F_HW_TC;
 	}
 
+end:
 	/* pick up primary MAC address from SI */
 	enetc_load_primary_mac_addr(&si->hw, ndev);
 }
-- 
2.34.1


