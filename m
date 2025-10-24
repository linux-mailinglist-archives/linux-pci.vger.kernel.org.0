Return-Path: <linux-pci+bounces-39291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DD8C07CC6
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 20:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497E73AAD18
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 18:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C3834A3D2;
	Fri, 24 Oct 2025 18:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YfonFxZQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011061.outbound.protection.outlook.com [52.101.65.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F91338F36;
	Fri, 24 Oct 2025 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761331466; cv=fail; b=ROZWiceziUpw65DM4HkYD9J50m0D8q7Jw5+tpAY1dNRvoBggUzZCCnHvL10yN1G+i5pU9WT3KpSTFZ2IokcrFpliy8RNqqgy7gpFMNTlsy5Ll1XokgN7l+JL52QC6rMd07e5iTIhp3+BtoJlFs9RkyF3s39uBpBULg2Me0cmAbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761331466; c=relaxed/simple;
	bh=EqGXBxsjAtEw7M0gS5GzbvAp1dFTcP52jjFx03Ps3JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DrLrK2ONbiaObUee/xRaPspfjfjJwKs9by9OIDHjaorL/o2FUvNRtXDCfCMFELnikvB2EQfrP3PcujTYet77p/QR3OJel0gDfc33pmsnXtUnGMRWwKgNiGpdqQhA9RP11KTU546FWsSjYnblEuoLbbG5xFF9dq2j/RtoLDnx7oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YfonFxZQ; arc=fail smtp.client-ip=52.101.65.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nw2fM4Pa3mYshbsFWGuU3MVrT1V5e/EdXIxAo0OFehQveNTG5UnYNm3bREI0FRbKzRBSuX3qap9VS+m0SoZTBBWns9XagX3eFnhWCMu7Tj4xag0CIJVt9S06YYl14Id83ERiLolV1eOjq39/Nb6duWZTLNil6B9P3TGQZQxTSO+swbgWXfRrrG4a5/Rew5do1ulyDQdpzHY8dTpJwVKlMOeWlhPK7AII+vAMLlH+iO64PxPMutFvR2sTul5E1RpSJb1NyBBuXtLBfXh67hOBTBe5gpvqu3C37E1Sk/Y69FId76D8fjxkvmZmvzTy5z0mm09BcAtHVeghxDjr87ArLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdH1zrWOVM4yN3Pxey9j4rkr5TdKpxTJltojxz86ypo=;
 b=u2LEeqR4nugUg6O5u/sEsHztqhzPl8sH1B9BuSS5oVH07wk3wRJ0az2zMx4aQKXy/JWBhI27v+AOWoVSanHiZeJw6P+YGReote4+zGqskUbzAO0n+vMm7YDznw1cAotUc4uTwZMqtvkiLhn8FivN2w+yZ0HfHRRZUn1NfHbwPnqsjnjl2evnQmsB+vRc6nywPX/V/JBClbn0dETzH3ve5DFZ9IgRsjMeg+T2Io+A/ceCIqY/fR+5DNAOIGBlf7m8qr4Wol6rNVdboTu9j14ztLfEKeK4vkiRx8FnsfVGBsQFsWODj/eB7Qi8TKoe1wNYuZYZdmE/gXj7w8GEqg+kFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdH1zrWOVM4yN3Pxey9j4rkr5TdKpxTJltojxz86ypo=;
 b=YfonFxZQB5r74tT3HX8x5lu2bnTByecvuBpIMyl3JEPF265ELGHFL82Ir6qnbkRRmLQVHI0DQGpynxKpmG3FkgQhUrnVZ88SWYsgfBPPeyVXI2Oyd502yapV3Xl1oZ8gMfDNGsgwcIbo4ErHPyes+nnGb5YI4WWvdM8RrOsOv5SiU18OF2O685bx4OBJqXg+58m389vbDbw6JZMYlE7NsAsrHFzYM6p9SAKBSz0SiJSgUeeXd/+jPe1VtYa/XCr3nJzFxTYHp6TpLYZ7lUw0LkJEGEuXXXKwUaWgbYxe+83nF57OOoYzfeZaMnxlzjUT3pF5ouloZam9IWeTA+i4nA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB8513.eurprd04.prod.outlook.com (2603:10a6:20b:340::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 18:44:21 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 18:44:21 +0000
Date: Fri, 24 Oct 2025 14:44:13 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, mani@kernel.org,
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
	jbrunet@baylibre.com, lpieralisi@kernel.org, yebin10@huawei.com,
	geert+renesas@glider.be, arnd@arndb.de
Subject: Re: [PATCH 5/6] NTB: epf: vntb: Stop cmd_andler work in
 epf_ntb_epc_cleanup
Message-ID: <aPvI/WoHwRm33E1/@lizhi-Precision-Tower-5810>
References: <20251023071757.901181-1-den@valinux.co.jp>
 <20251023071757.901181-6-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023071757.901181-6-den@valinux.co.jp>
X-ClientProxiedBy: SJ0PR03CA0190.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::15) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: f85725b7-abef-41f0-5dd9-08de132d58aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|19092799006|376014|52116014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z18FdKuqU6ggBkECQiYwTN6JDJ1+ITMtjTuBkGHkDN4A3pWyCwTB9wfBm9RQ?=
 =?us-ascii?Q?2ZoVBL5tFVkHAYG00NpQyEMeufT1FSxG+nKseO+YsZ5qPXF/TAlTGR2a0Qd7?=
 =?us-ascii?Q?Q0u6E/nbvHNe2MJZgNDnoZgtSX4wsUyURouc0KBVJOt+THwRFaIoE5nD/3yX?=
 =?us-ascii?Q?kFkwPSOMyC3n3ha1iP2SQ98Rjxm5h/aQGNP7vdMiV1Ad867QrEHoFc2DK9md?=
 =?us-ascii?Q?jafUf1r8TnosD5uML5ocqDZWDiWcWvKovjqSflFpbV5FQlINkDH/JIxRLlsV?=
 =?us-ascii?Q?fcXyaeY1q6tBs6It1mA4XNOuo5/hQEFaentExZ5G0UraJuGEkSwlz++3/kqb?=
 =?us-ascii?Q?6E+0hoVu4S+ktzo1w3JHS37fsViHxU7K9AqdrbvCf5WTD1JlxvJbAyX9iYtu?=
 =?us-ascii?Q?Psh1vlgeKFG0LiWyCjcvBWpWO3Zd1WnnLwW4njK5UBW5ysJEJTehi6UimHXx?=
 =?us-ascii?Q?yFxzLvPBoN6BeaXcWIu5bdDZ/QVCGoucBWnKbE0/t6N31xP4m4jfsXXx2Air?=
 =?us-ascii?Q?V4wPWCYqzcbtEh82qu20udf+RTkdXhpywcRpd3YsMPmalT1uEMZy1d4WVTYB?=
 =?us-ascii?Q?J9NGrSmy/iPRJKbvRVCs1ql8140quyrBQTnkfplT4P/7FOf2nfEYblm9KWMO?=
 =?us-ascii?Q?iaRXJxuovFJ2/UovC/a+w1O3ZuSLj46Yr98cW7M5UN1zZ8JHosiNBDv7sf/b?=
 =?us-ascii?Q?74euJLe7WjfZknT1jAPeBhXs0kQyZpCpsuXra7HoN599eYxL10i6x8xikuYt?=
 =?us-ascii?Q?VDXinFOX2MEf7++yD3bcIoQgGHtQq+ahlZSVpoACNewiqtiiF1FrkPaEzLT6?=
 =?us-ascii?Q?YCG/jLEZZ87JjINP5cEoib4gygD6JcCVbIkF1rJdedihGbJkUFr7vKSHo4ag?=
 =?us-ascii?Q?mya8T4C7k3n92gTlqT3s+xpi4VrIwQPgdRwl3ecUlEA/cwBfL/1mtkYJcAEc?=
 =?us-ascii?Q?pGbmMK6qxt7O+v6yvRyT5kZV20KijZRuti7VmRsRB9Z/yYYGQXUTSLSzPeFi?=
 =?us-ascii?Q?J/LBpSaU5aRAxfSAdA4gPOTWr+jy+w9ckL4+cn7NE8F3heCsrqUOqSPIqgVw?=
 =?us-ascii?Q?fDBE4o96RwMF/bXhdKpBmDA8erdjDu7Im0IJch89i1XIhU+9IUFDKPiC6J4v?=
 =?us-ascii?Q?CJOnzZiX+xv2uFDB5Eve1yfbKYWGAUAuXmeYYoyxXQq/M1U6nvEMJTD3nGen?=
 =?us-ascii?Q?sDprWgnaccvU9l6D2DVeTRHXJxb01yn3+6cObsnvquJQMs2aJqqHL6R4Yoax?=
 =?us-ascii?Q?otJhtRt27Otb49QeC6Aejh/Hf4LKTZ9C6AtdsX99BfiOTO22GVOsUUNbIDCJ?=
 =?us-ascii?Q?t8dc0HXxCxTKeAPtMOQnpNUY9/WNrAWDSiKoxzJ530TKIqb44fxVR21yN6Cb?=
 =?us-ascii?Q?F5+/eL6IgoteXRbrXV5WJWjfCDw/pk7boNiz4KkPZgQgnn9eNbt2XIvQNV0Y?=
 =?us-ascii?Q?jpVKB2PeBMdb5j6COyHE0KFuYjzWkiZ73579+mrN8RBC9EFpvpUBIlyI0sm1?=
 =?us-ascii?Q?km7tGyn902r+KOJOD1kCoWFhYOdJr4RqK8lf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(19092799006)(376014)(52116014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7aORYvmDooaHrya69uQ9Vn76JX8JubNMUkFPOFjQAZPcWe5t5QIfz8Pj8U+a?=
 =?us-ascii?Q?2S6HcS+4W+8abOmo7IvrwZARsjI9VoCaVsMJXP2cI9oxAhCoUN6zvUxP+f5M?=
 =?us-ascii?Q?P5/cMobzEX3basrmxXdbLw/lYKgfaM92N/RrEiFD6lJUwEK5qDgmnq98xYWL?=
 =?us-ascii?Q?zeZImphefzrn8vJmBTS4ifb5ZrxHT0X5HYOoOaOANiAaoKQBCVnCOFZpt8UU?=
 =?us-ascii?Q?gEozVXsRVRsVkLflWm4i+Th+VwbcozMJUmj1hvZQE41DFBotjktAmnIiIvzd?=
 =?us-ascii?Q?cO7hihWQrNZ9+NlERlYHpqonR4Q56Rr+giLu5phE77JEVSIb6+A4YDnwcHBT?=
 =?us-ascii?Q?HPtuXM53xcI5isrsRwV2h0TewKuYQI43xuliNnjgnN40c+0HPM0ss8ME9y5J?=
 =?us-ascii?Q?mdjK2NcKZaLSLOrr8nRDwcZEw2KzAzWP1b+SRUCFeZY/Q3OCGXLOnlWo4BTr?=
 =?us-ascii?Q?crTFIXugArubiHkU9y10zVZlz6gUZ+DliUy7i0NoplOCxC19HBGbJpsmS/Va?=
 =?us-ascii?Q?lNsZuJLo6pz33o1eajJA3BhZspe4y53Z8/03AEVLfZrI4CIp4AksDoW6d+H+?=
 =?us-ascii?Q?Wo38ZpuIz3JJfEdg/IwLvf7ziJ0A/Rz6AYjFHaCPXPOnONbztX++Dg9yIOpX?=
 =?us-ascii?Q?o35fOjRgeQ6B8Ws2tIsVuCixl8vkxgQB7s0hkwSkafnYQ/UvU80ZhTc8k7+I?=
 =?us-ascii?Q?6D0zyBlmbx7mCR8/rYlCxwvLws7lrJ4imAkLkL9+Z/LK38K1HQ9U4Wofmca+?=
 =?us-ascii?Q?tMlp4rQhI0V+lvC9nu7X3tn1qMooH0DUNf5NO/BZLeGbAhWtSBeZvzr98ocq?=
 =?us-ascii?Q?jxckHrlT2RF9wMH7ub1krGyS8nuGiH/FGmwYhLpaSxWsZF+esRoMz2YD3ea+?=
 =?us-ascii?Q?FKpNT5K37zfBKvg1cHvyEnL5kg1mgcsx3cYBmQwkfNcJOp0Kcj2dtc0kTaPv?=
 =?us-ascii?Q?Oh7vA4JndLXH3fkp9tqnouhEytsXhzPvcRXrpMB7hFNQMPUBchInJygJDOyl?=
 =?us-ascii?Q?IWgwecNK1eKZfDixDxYY0OmhyMPZ00djHZcN1H/vTm/sGbJYquNII4jIeIyj?=
 =?us-ascii?Q?Fu5/ps8zveutfXXWbyhW6xGc5LfiiQd/3hiBXDx0F82nda4/uOB5NixxW3an?=
 =?us-ascii?Q?G5m50DST6j2KZNSJXBLo4El+Q++gNvjY+tzlDZG9/+rAUhTi6+oWFxWqQadf?=
 =?us-ascii?Q?nGQbI+ukkk8yOkUbuM2dXov0OKHkcqiW5iuZTuQ97eHlOmDXPGJXwUw/DNHG?=
 =?us-ascii?Q?TXURgaE9iqyUanSL3n4xq7pijmXzBAfxNX7S48ed/Z0PBX4U6CNhxcb+4viq?=
 =?us-ascii?Q?otyCu+dEycoAWY0tTRMM3ArkDRNK/Cb8Qz7+sEv4JY6qCZxFz5Cxc5Kb+pot?=
 =?us-ascii?Q?qIhh2kXUAJCfYc1gA39PFpOunItO2OtkvG9UL/NE2GFaDFU7yoGX6aCiV/Pu?=
 =?us-ascii?Q?IGLOAxTYAQLjUepb7409/EMNztOGRYaWfrhfbZeDeGPTKhiXxBkAXVZ2u8Gw?=
 =?us-ascii?Q?mTM1ErKO6A5cEa+0iomhuyzItYhZJ1Q/JD2NROLLk5fbXMI2A18LmyPhsptW?=
 =?us-ascii?Q?B0OaiV25BG6tIDrzZSg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85725b7-abef-41f0-5dd9-08de132d58aa
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 18:44:21.6944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCtZM2nwWTiGcK+A6f2UTaEvrp4O0wm/xmssoDHyNrxyHy5v5D/GXaWezsB+kPari30JIdwqyN4EnOVJKv2RzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8513

On Thu, Oct 23, 2025 at 04:17:56PM +0900, Koichiro Den wrote:
> Disable the delayed work before clearing BAR mappings and doorbells to
> avoid running the handler after resources have been torn down.
>
>   Unable to handle kernel paging request at virtual address ffff800083f46004
>   [...]
>   Internal error: Oops: 0000000096000007 [#1]  SMP
>   [...]
>   Call trace:
>    epf_ntb_cmd_handler+0x54/0x200 [pci_epf_vntb] (P)
>    process_one_work+0x154/0x3b0
>    worker_thread+0x2c8/0x400
>    kthread+0x148/0x210
>    ret_from_fork+0x10/0x20
>
> Cc: <stable@vger.kernel.org>
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 49ce5d4b0ee5..750a246f79c9 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -823,6 +823,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
>   */
>  static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
>  {
> +	disable_delayed_work_sync(&ntb->cmd_handler);
>  	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
>  	epf_ntb_db_bar_clear(ntb);
>  	epf_ntb_config_sspad_bar_clear(ntb);
> --
> 2.48.1
>

