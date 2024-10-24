Return-Path: <linux-pci+bounces-15180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDD79ADD48
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 09:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D64D1F21212
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 07:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C291B6D04;
	Thu, 24 Oct 2024 07:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VSzR5312"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34571A725F;
	Thu, 24 Oct 2024 07:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729753794; cv=fail; b=Lom5C3J9Uqgqss+jzRGyOiINNezL48vSJXHJxUnHyNb+zp44HY0DQkAFF34IWrWLJnoU7v1GsTvdLBG10uleF/4TSkJbP/QgmNbJ2NLSQbTvct+rGZkhkxCR1OFqmocX90dPiHtKamVJeDUkFtXVvhhTdO6yB+YFHBThrE9MrnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729753794; c=relaxed/simple;
	bh=aXV5z6KSHKTfg+dTWQF+CUh6kvUVILy602ZJ85vUsfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DmWNXAed0ILI8Jr1xstHrhsoRNo7ya0FnflVfeDB3Y8OksvoHw37Dwcjgwl2ZqX9TC5Hyytir5g0gRiqCy7UUTvdg/y3zCyFxKbvMGlNiWcoxGgo4latyMoPM/styq/cPMtp5tyYkkQMgo3K1hj8mnpDuSM2WnmvsQMNiQ8Hgng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VSzR5312; arc=fail smtp.client-ip=40.107.22.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfSqqhj3m6GQMCaJcIPQmQ3F3Tx3NqUaUHb6kDzYZozlG6PZUv0CEiMRpX/mq2P0ied+D56mLF5YzLUSEgB82IBPPKIcB5EY1+spl4c6QyoQEfxNwldqK06NDE12k4yMAd882d7cB7NwzV/8/FRj3yGcH6R9Gbr1lSv0D9eMtTH5mikDxtjJ6cfxA0Egrv0F2NEnFCXOmgnfngNYhCA46SYfmwl93QRV2KBllXS89A3gu8D/lVUMi6CQoUwgrrY4mOZ4cj/JDaZFJpF7rI9wv9nVO3BMIVtmcMcWsOWmYZyf2eRjOMDvQJfmu3IkmdR6sE+fLDvp7qognPPgMy+P8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2CXxVsS2zWpvHDKaFjiJLClkM0z4iHhBVRbyo+drvY=;
 b=H0wrp8OfCCmhISRkNJB2ZpGiTwdaei9VDM0HOCLlVezYG6IE7dBQzi4dxOJMDat86+IGHxtUXlehmsAtG9c570U1fuHhE6WTUjgqxx/JgPf0RWwnQsRRTi3EjtktsVGVB1i4A6Ltz4QF3yHYvqyL7pG1IF9LBIeYDj65FIvgFez3U19/84rIBvdwF5oZOrJJN6bKGnIt+D/w+5QEnEDLz1MUNC6g+S8l6L7FhYA84+gG27SEnr5POESbAm+7Iv3TUKYN4u82Q24X19KKa9rYQm2oCtEAImBFiHm0QzE4IOvRBRjz1RtTO6BSEdDI0RCBcG4beqJT5r0yCqFMW/v9iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2CXxVsS2zWpvHDKaFjiJLClkM0z4iHhBVRbyo+drvY=;
 b=VSzR5312PZfG1Iqsm9Js8pPTY7hESdH8SoYRt/i/UbMlAtR1tg+5+ki3K8yQmcLkpHqB+KsJP9HPgZ2CgABgHu8EZ9WbBPdAoJouZZ6Jr5lv0Rfvc/8M57JAx5TXfzTc/H6uD52vQ7A6MaCvgNjYzBKv2OzOswBqRGsPBQ4xWnLmdGCZoA9qOtdMaY1mNvg3L+w65IQqniJXzBiMVWdZqfIwDUiaYrg4ykoHIrTnlbyc9i/rIM70/5GoxNjOnsWNC67K1zsilanCeM4g63161QtiOQk3EbTpD2Onm9amSUCTeefda3eV0EPlO1LUTZTIbC1kDg3Nk7vqa/XHY+UOwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8627.eurprd04.prod.outlook.com (2603:10a6:20b:42a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 07:09:49 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 07:09:49 +0000
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
Subject: [PATCH v5 net-next 11/13] net: enetc: optimize the allocation of tx_bdr
Date: Thu, 24 Oct 2024 14:53:26 +0800
Message-Id: <20241024065328.521518-12-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241024065328.521518-1-wei.fang@nxp.com>
References: <20241024065328.521518-1-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8627:EE_
X-MS-Office365-Filtering-Correlation-Id: e52f1248-33cd-4d6d-bbd6-08dcf3fad8bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|52116014|1800799024|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?epXpoz4CTojD03bwJ7/T7jbj1mrLU/hG2BDvce3WLvlJep+a5FiV0tVgA0Gg?=
 =?us-ascii?Q?/aARoTOucaAA1LvS9+iSF1Ifz1lY6gtC9kXd+/szXQ6Blcw+EzXrqOvQwvg2?=
 =?us-ascii?Q?Kxb944QAEmNXGZEA0JSeXo+UfrFeS6ZSB+gePy033Q0E5zFI4A+tVSaOp3//?=
 =?us-ascii?Q?Nzn8UC9r0+RkWqm6ipOACsgmoJ3GTHpLoeB0nnwIztRCkPcdXAKOxJqBkEfy?=
 =?us-ascii?Q?QyJzmEr0h6zZMLAjIfGAOH6kod2VdM86qdb37s1lD7NiNV8J3KgIlXJk3yBe?=
 =?us-ascii?Q?MErOVPBUNVmqeV6p+TUg3T/PbSiW5P59TyCzQXDfu/RyfCTBlaZfmuR570+b?=
 =?us-ascii?Q?qFL6lGZLsWQFVPxPePzcC9OkTHi/tkgi/Ckpt9vxNZn8UwVoRP+dFo6najJE?=
 =?us-ascii?Q?OTd/CBY+bI4Fuj00doQDas0OWhlspPbDzEsAvDiyl7asQAOHJNgEmmga7tiL?=
 =?us-ascii?Q?dZaFHQh7nodMDzaOTJGOU6CA+wca4VqaIO/rj1i7D37tLf9WOqq9/HPjkeAI?=
 =?us-ascii?Q?tlzAfuLDG5JpMJQ5SZu3dJPHAUougYal0HgCDbUpK/Chwe/8bpJOivxjTMCr?=
 =?us-ascii?Q?xxZKJa7twDjEfiDwfwI3N2pjMu+g6PEngPpQ/HVxDJm2S2veTt0GW8/lA4V8?=
 =?us-ascii?Q?KVVOIcAoEmuT4MXZ0oYvbTmRaC5pslj+9/Q8R+L1D9IkriRsYP9lWOV3PRr3?=
 =?us-ascii?Q?bcBtWb2qQS6DBe9SfgMmOf0QoYWhV17rweFK+0AkGgaoHjBMCjWXKLArPkee?=
 =?us-ascii?Q?ENfQ+IZVwySn7RtryWJp4ltEZEOHlK7La3XXfi0vnHmDpSVZih+4Oo+jrcx0?=
 =?us-ascii?Q?zeetmPCB5ZM+aEOgDJhCSKduTrq1NvDVtR0hmzQOo/dNhLurjIgMFFhgMpZy?=
 =?us-ascii?Q?/N/pMG2fa0atnv9rs0uJvyMbzWdZquhzBnhEV6GkM4z2JwSgyQgKU5s336GH?=
 =?us-ascii?Q?kWJSPErp0VxfCFhRqYIPr9AYMlPFmwBzKsiqBo8TpayEw5miGmQLr+1fqbP0?=
 =?us-ascii?Q?2KmrZow2skhQW8hkJ4tdPOd64vjykdP/xuHS9QGhPB7LQWl0QKQxoIsR10Jq?=
 =?us-ascii?Q?QOVIKlB/3jtIObGmangNeZamkps26Naf8TltbhhOWVpi4cJ5mgVltg9gMBut?=
 =?us-ascii?Q?UY43nyMhGEubdSCthc+iWFkoe1P0YOZFCbKlud9cTvH9oFIO/tBNuJTZ7/wj?=
 =?us-ascii?Q?8BTLwVfF39n0Z89NZ3+jPjKr81UP0NWxKaILFaO/vFfcMYp8wIHsCod5foOO?=
 =?us-ascii?Q?XT0FaCkd+FaxZ7g8VhbtOoSfmYybEjhsF1sfaroMNdxt6rR30inBd3GhDiCr?=
 =?us-ascii?Q?DTvnwmkAjkr+rbCLOHVKHX5GbBOUWCGOF7g6tNbDpqVFlOLiHMv9dvP1vUc/?=
 =?us-ascii?Q?4/RXP8JVvwfN5ra+l44+AqVZCv7E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(52116014)(1800799024)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ODWjTCG0xxSTEhKGzIvQEuW1BmTj6Ix1H68am3KtEpqWrc8v+3wkh1SbgSnR?=
 =?us-ascii?Q?V2+K3EVDcCz4Pff2PA01P1n6c2NsjDP6NW/M5kxcxzciKyKa1SO1gPJJNg1R?=
 =?us-ascii?Q?BUsR+ZsSU6adCdwpgYVzphKsPoQC4gXiLGzeRbzJJ8zzSxaay9EzY7MommoK?=
 =?us-ascii?Q?IGIpGpQ/M9pIrn+KrChj0nli0+TzGxXHcPbmxwUBZGh+N6HJIgIKgzZD0L37?=
 =?us-ascii?Q?eWl2uvo/0XWwu2SzcJ4QusRDR3FG9HqPmf1ruBXvyaZCaWNrgvsHxZQenOZF?=
 =?us-ascii?Q?nkpNzcfSec8BOJILizBec6Sw6mfWLP30Uww7BUlSUorqO63S4o031z/611X9?=
 =?us-ascii?Q?pcXobQKPQIWnP6H3hvdtijukRRl9M5R+h2cewKYesCzDOvic+50BkNnn/PeL?=
 =?us-ascii?Q?FJyELVaiuVhRJXLwfab+Uqh6vow2ITJDcnn4Qo8Dhwqak9kQINkzRfaTOXIE?=
 =?us-ascii?Q?Fhi/ymxTzJo8H5v0Y/Ic3zxV3INYUzfYmm1xzkrOhNqeLdN2ovrt+qmPK5r3?=
 =?us-ascii?Q?bgHhUcLcB1vz1A0gxieLPkm7Z01cUFgBu8ow+W29EHH8PgQ7QAJmKE2+Fjhz?=
 =?us-ascii?Q?8CiTGJTuom/btpQgKzEGG3afrvovzt50k/RuWwmDWdOXFf3E4/2pMcfgF7Wf?=
 =?us-ascii?Q?wz+YDjN17T3hq7ofufZG6q60Qw+3cFN1CKYofBtSz+DF5WXOO0xVqsplKyqs?=
 =?us-ascii?Q?YCCzipwdqO+9nbD2adFrCWEtJDnj2dDGlFhdhWyXGmFxjmohoP5gRolM8h25?=
 =?us-ascii?Q?M/06Ia4UcDcmAcTAaCPFX4oEGzTp/yuPaUtOdGHri+T6Na8PNc2bb+qK2drd?=
 =?us-ascii?Q?nYvG8ky/gCf5QJojMRHPWuy27eKsxf+PW0bctDuT2WIEqqi6CuDgmODrpf5D?=
 =?us-ascii?Q?5mxuE6af1iEbJwFVPAZ66zIyUkUK7jiFVG4PXRXcqTK5/R8XaxuHJgIWP7z0?=
 =?us-ascii?Q?nXNt1mj+0D27oYxyq/TUhdacGUdYDb1O5CVCAkYgp/owi7/QgrToYCjTJu0C?=
 =?us-ascii?Q?AHnNliNnj5k4PRMzmZ8KnU4JHbMZgyUUYNLCqEb6zhLGuIeQKGmt619q5Rn8?=
 =?us-ascii?Q?AFvJUmKz/1vNAn13LoUMP+2m0iM7XTtdsOVaCoB5HY7TRojA/it3UBaQS1d4?=
 =?us-ascii?Q?E7yvtNurUQEsbnHKGL6kyii3aQlqJN1IeCQ9+fICBWHATVkhnk5x1V0tNDIx?=
 =?us-ascii?Q?bmq/AehJ6koGZFUmJRNfe31HMAXryg3Qm/wRI+CAWNgrI1hYdCwlltpC0IBN?=
 =?us-ascii?Q?A8GdshdgjwlErPoqJpAEWjUXtPWwaur3EZjkMIPnPLO+4KNCVtx3yKNcTxP/?=
 =?us-ascii?Q?uinac6kvOR0CGLCfG8zHEUZC2wMkKAm4FMXz/8mquo98SC0nWA24LZPIOihX?=
 =?us-ascii?Q?NPmjv9v1bvmQykPlQw6FiQqh5UnHwCDTXBigUlnVEq4LCFIku9ZyEK+QPvG+?=
 =?us-ascii?Q?DwWm4W9De4EHvKLqt1jEg7RHC9QEc7AwJ2q/Om/SaiwrTRBpwiELeNB3UwRA?=
 =?us-ascii?Q?M+sMbc5MyT48USiMM8REkN9n0FOcKiKK0bS7RKxsUfWbFR0E1JgQR6SCDVzd?=
 =?us-ascii?Q?bAG+SfW84v9PyydYFpcs1+oekI5pkiihBq2GWQn/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e52f1248-33cd-4d6d-bbd6-08dcf3fad8bf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:09:49.1884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BOUVz46ttoq8k26lzmfWVbw+wSeH3Okhcdc+bpbP6FCygi79G4CTchZJ3jgxhCqsLjggJ13xeYctPDL19l5pPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8627

From: Clark Wang <xiaoning.wang@nxp.com>

There is a situation where num_tx_rings cannot be divided by bdr_int_num.
For example, num_tx_rings is 8 and bdr_int_num is 3. According to the
previous logic, this results in two tx_bdr corresponding memories not
being allocated, so when sending packets to tx ring 6 or 7, wild pointers
will be accessed. Of course, this issue doesn't exist on LS1028A, because
its num_tx_rings is 8, and bdr_int_num is either 1 or 2. However, there
is a risk for the upcoming i.MX95. Therefore, it is necessary to ensure
that each tx_bdr can be allocated to the corresponding memory.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
v5: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index bd725561b8a2..bccbeb1f355c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -3049,10 +3049,10 @@ static void enetc_int_vector_destroy(struct enetc_ndev_priv *priv, int i)
 int enetc_alloc_msix(struct enetc_ndev_priv *priv)
 {
 	struct pci_dev *pdev = priv->si->pdev;
+	int v_tx_rings, v_remainder;
 	int num_stack_tx_queues;
 	int first_xdp_tx_ring;
 	int i, n, err, nvec;
-	int v_tx_rings;
 
 	nvec = ENETC_BDR_INT_BASE_IDX + priv->bdr_int_num;
 	/* allocate MSIX for both messaging and Rx/Tx interrupts */
@@ -3066,9 +3066,12 @@ int enetc_alloc_msix(struct enetc_ndev_priv *priv)
 
 	/* # of tx rings per int vector */
 	v_tx_rings = priv->num_tx_rings / priv->bdr_int_num;
+	v_remainder = priv->num_tx_rings % priv->bdr_int_num;
 
 	for (i = 0; i < priv->bdr_int_num; i++) {
-		err = enetc_int_vector_init(priv, i, v_tx_rings);
+		int num_tx_rings = i < v_remainder ? v_tx_rings + 1 : v_tx_rings;
+
+		err = enetc_int_vector_init(priv, i, num_tx_rings);
 		if (err)
 			goto fail;
 	}
-- 
2.34.1


