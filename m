Return-Path: <linux-pci+bounces-31718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB99AFD5C2
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 19:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213BF1C23C5C
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 17:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11622E6D30;
	Tue,  8 Jul 2025 17:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mWC2RkfD"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011021.outbound.protection.outlook.com [52.101.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E81F2E540C;
	Tue,  8 Jul 2025 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997159; cv=fail; b=OTpcFrAUDiIvSVipnpPpwmupVLaMbOZ67IF0YzJ2Ps90okZTq6XGG3wxJYxfNh/noYUrib1aq5+1PvsSX8Plh+12F0wjBev1zkwE18za3f5LZAa+Ymq4SSmgzVCC08CdQChEEr5QBTGRsMea9j8C3MUDlhAMcVZIYrCB7yrf2uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997159; c=relaxed/simple;
	bh=seaPSbWumajjggfBS6i68E6a6TxAWvjdIOeD2a6QGpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eVQ5q7jA515pDeibDS1LvDxpkot45eBTBB/9XkyDUQ3Ed54MTvoyDjkk70bjwe+6KK7YtkKiavUj3fYm0vnqZpsiGS98sVgxUy+hssY8RETyxuYJwpjDtBN9oKrex/6+fWisGa/e6bKRF2bUuap0Uk/dDLz3jrlJHJubQWroUt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mWC2RkfD; arc=fail smtp.client-ip=52.101.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rj0CM8kP/6fOo5gb9X/AgB5IFrMcA2ItZU8P35T2uXz7hCK8WDRtRicPDFCy9jlaJx8eHGIJIFRbYyiiAhspOHWQBEDxReJYHe0or9brq0fFdR5xiGmdJfcPpKTVMk24h6yCy4Q4AEQbyUzWI5S3+IXXtXsMQ+6WfoyZy1KykvagatSq4WvGmwVU7twYmmXnvJp8zuDK3RiRXEllJXqncl8EjGUBYbJMonebAhV3kAB+rDe2TTEN30xGxATyFjArHEDTQJfpV2rs8/NrNtdK1kQi8l4l+ZjwBYS+8EZtSnqhECfyTfBYVgekBIbVba4/T2nW8JCYKbj+YQNpKBewHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gc4LRkY9aVExtAb1rfYm3BD/kal2CN1SFphnc1pLvH0=;
 b=Sn2U9AxwWZXcvE/OMlb2qMTgIvWs+KUP+2QA/Jf5X7TbQeRzk36K54CCPRPKgK8YJB3nmd8pvCDAa4Q/IeBjnipYG9uTEns+rJayduSVMdOv8F+8uKTI7YegiQZigpmNisXpINJ0VPRBPtM7kCq2d62eQ1OfE48EjfqLRrvj4sju6SI2G/zpEncUCplVyj9B+BDqMfDQhxU4m44VSSHSthBqeByKq9d58Ro+F/npHVk8jHvlUp++8uo3aIUicnY85vduTIinh5vpECyUL9yBaMXlu72S0E5p4ig4hcQFvT83tXXOywkSi8JGSm1xMdjI5jk2kgbZhi8cJJx0sQOILg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gc4LRkY9aVExtAb1rfYm3BD/kal2CN1SFphnc1pLvH0=;
 b=mWC2RkfDdAadM2SlwtnUjT4t2cibRKG28HZIGsEf3GDu+DVlz2ukeHEzGdTCtqd0zvI0YWtFtusGnQ/h+vAg/jnhExlMiGj9vzpmn2JEaC4S48WGEZ6BgymBdfmp/ncHAnyyPYuvRDShYr6M3ZumgFhhCATEhC+Mw3sGSLn64YoP6dxjQRD1PXJXFMxDWiIi1ItrRGNFwJb1M8MVQ9DBgzz6yUZz7scLTHLa2dmTJ4o348W4qS+XCleu5TxMNEEwQ9vdvFS4OL6cOsbWZThmZh1iurpjwP3AYP/B0lSaL3JLqllTywdKJxZYQNaP7oqy+Xd+yX23vB85wjCnE3TB8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10154.eurprd04.prod.outlook.com (2603:10a6:150:1ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Tue, 8 Jul
 2025 17:52:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8901.023; Tue, 8 Jul 2025
 17:52:32 +0000
Date: Tue, 8 Jul 2025 13:52:26 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-vntb: fix MW2 configfs id
Message-ID: <aG1a2iy1/2RWd2FX@lizhi-Precision-Tower-5810>
References: <20250708-vntb-mw-fixup-v1-1-22da511247ed@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708-vntb-mw-fixup-v1-1-22da511247ed@baylibre.com>
X-ClientProxiedBy: AS4PR10CA0020.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10154:EE_
X-MS-Office365-Filtering-Correlation-Id: ab7deeed-b8ea-4831-2964-08ddbe4836d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0SJKnVwtmaWupAjUOyY5e7mmK6XpG/KF4BvOHkTYsvq5QNTT2TtDt1aAKkkM?=
 =?us-ascii?Q?LA/D8/VLG9qihwIZRbvGH8uz2IvMV9vC3xfsbNP9/O/8miQQQA6sdF8t6AIg?=
 =?us-ascii?Q?DbwNcsIGG5aUyEA75ozd1diDvZiUDe6hqaThUI+31ZnYbW6pSx5A2J40SgLt?=
 =?us-ascii?Q?/Kp/52lRQPUyPltCKzH3fwTzEYEqlbvt1NIh3QaUrUgWCKrOEGsCG10Vh2YS?=
 =?us-ascii?Q?5Schv9SyfqkgBW2v/wC5UnZBK4+HVw4cwhKYDMTUjjHk2stGmmaWfiGpfkmf?=
 =?us-ascii?Q?oadjfEI02mLGzk1zgMpI4Yn+EMgC1lp+fCuKBYQhni+Ic2uRg5NaMFBH4I+4?=
 =?us-ascii?Q?wt11HR0wAI+kZO/RVGj5XFcq+0MNbhn8poQ1NS5rQVc3XKyowyurLePia+ai?=
 =?us-ascii?Q?evsyPz47AggUmUgItmlzQkjXKvUNWQMMKuQ+hsqi5z6irawNEk6qL0WJFZ6M?=
 =?us-ascii?Q?a6Ji48L7o4IT3P/Mgvn+sAxkmLfCv4wKjQ1npmrFDWm9TMWjtNwytj3LOb+k?=
 =?us-ascii?Q?ddSKjWrqfJpkph5Iscfq9INo/iH80Do/wMlRKquYjGMc4zkrrwd0HbmgdmUv?=
 =?us-ascii?Q?R8svhAs+11wHDvvxIIBcu7i65dLK6LSkA3lZPyqSLbSTjw5s6kFho43Qbi0L?=
 =?us-ascii?Q?ghKLz329BE4aSDcyZEybl7r5F0tWI+bTNOT3T7lD/Yfpt1OccolZ0jzDmN1v?=
 =?us-ascii?Q?nwxu4Mekay2J0VGaXSf9O9qKcKADltTmkvl2/tD8L9eJFbGiv26/Sw+cV7z4?=
 =?us-ascii?Q?bkwMoYMiiQXzJwXRSts7jvY/Dlc9M/XZtwF+hekbIWU8NLdaADH7T5Xux1JY?=
 =?us-ascii?Q?PaZ7TCR/rtckpNCEx7QqbBqYWDjwmaODbbs2oGkWmAs7f3moQ61pRFdBTCvS?=
 =?us-ascii?Q?qbbxICHa3Uoa9RLurw5bDZalRRundVvii+dbCEpYTsvhMxdYp2t8gfYfEcUe?=
 =?us-ascii?Q?Vex9ShxLgbuSDIc0O0YJUTigpp9KPGbfJzuPTSkzwxHFpzDGmEmVRk3oK1C/?=
 =?us-ascii?Q?A6y59qfh9NFr/SE425F+emEWCd0zeUZl5povBl2KjwOL6oMpoOA6PkUYm4Co?=
 =?us-ascii?Q?Y6iXYSPNU0NWUJOYshQwrr51eQXrxUg9KCs16Xd1DRnFdrfLEq9flmeqDo4w?=
 =?us-ascii?Q?Fqi4p4qI5jx3EvGnYLKi845uKX5s/Rg4HBsXTeXx4SAd8/zIcCzin2DGF4xY?=
 =?us-ascii?Q?VUWUsxXuNVrUZztEksReIELCuhzFQmE0PQyVhgRPpEF4j74mq+AydIdCcO42?=
 =?us-ascii?Q?4AuqAeB1xwrWE+k0gZ+QamdEeFwOS8mNC8kxGVYpfxArgSHSZpyRp5buwzOt?=
 =?us-ascii?Q?K4F//E80pnBqq5Nk/N8FXGFT1rt0fq8sUdKIfKb3JdIyUiTPQSQtdeuH9Xb0?=
 =?us-ascii?Q?EELqGKQ44H9FGAcBaA/aRuTpdSrVgTmRvT9OquRo0aTJncu7lUgQ20LAfs7I?=
 =?us-ascii?Q?VFgU8mSX4PEE0gVTTFIG1bFOVitPtufIszhMEbUJHzklY7ePYdFvtw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UGVwlC2HUt6nCIyeOI+MzLGJ0IkIMhZgitdLutxG4fvAcoMaLHouz7TXCasS?=
 =?us-ascii?Q?z1h6469qjsiicgS9qJXo/2RUIR9ivyK08qtIoeE6wpLBm+NlEXDSn8IOeBT1?=
 =?us-ascii?Q?NPVIAzYG3eK+g/bM1YnWi4v9nI5KL4ZNADqpL6LbA2KgELjQUzqPIcb56NNm?=
 =?us-ascii?Q?Kz4SuEsB0xXdn5gSRbxyDHQgpdX/s4xlwk495Wja8N/hlusztx6M7o/aQUqe?=
 =?us-ascii?Q?mRhkWjwFCsrKWG9BQkfUDf/IQWYNV6En/yg8eflMhgER3ytcYS8eOSgR0XQm?=
 =?us-ascii?Q?bw+Jhzg4HP3ddnmKflC6XnuZ+HQYZXFqWe2+nZdT94ENJc2t5NtSu2toGHu/?=
 =?us-ascii?Q?M6SnB0lFzS/irh+C9pdM4e0d0Euro6Aqyz4f8O7dI/XVkz3Yc/a6woAycv2Y?=
 =?us-ascii?Q?ZUW8HD+fDquYqqcRoNQ8+M10PTFF+uSgEYMgKlLjudz3JKHVVKMpV6nnHOK9?=
 =?us-ascii?Q?2Dpl1uUichGyAfm27r1gHNXUW6Hlv/sFzqgQLNCLWDDL/AcItT0CyHA0XFin?=
 =?us-ascii?Q?OEwcA8hCpp4ZDQ6WUVV0oA6NUL8Gax+DamIHO8XhLstX0fbTTJb+zbdftOpT?=
 =?us-ascii?Q?+1TUnmeQ2xUREdjOUUvN9imFQlcVDo7eTjNfsD3HJwloLnxii2Me5T3h3BS3?=
 =?us-ascii?Q?cqQJW9Y5V8QRekEDZZplsUqR3EOk5EQ4cosOJV1MJtLu0PQzJiltsTOyA089?=
 =?us-ascii?Q?lwOyVCYJ74+3y8D5CZwMlYLcHAK5qQIW9DpquRBgomqkntgWPk9/sEFlwInz?=
 =?us-ascii?Q?H8h7E5TAPbNASg7T46b1kT9bBdGp9oCk5YPKxuKxIJCL0Qrx4/ENRtMAMsOx?=
 =?us-ascii?Q?UxH1QwieIRXE5eitkunOtIgtl9aSX8KfWTiel5LK05LNrWjv92MYiZFH9YB2?=
 =?us-ascii?Q?YnZc+6gJ+qUNTKizYaSrJ9Li2qFAhwwC4PsPFb9IMhLLyA97GPQ6Z920BIfa?=
 =?us-ascii?Q?MH0CVtCNlGUX2273TXNEkup5k2xIRUiXHuMiUGgM14Lt5JP3X4DL+sJUeVDx?=
 =?us-ascii?Q?Q82Aq8nEh61z+dPec7NVnj/WFfEFMslfQd3BSRUiZ4k2c0J3icba/+AWWP7O?=
 =?us-ascii?Q?PyxjfBoxYoaGnRVfk3D7Ux120YiUXL5nv8RbKxduO89+rHA034mrN9Jo7S5N?=
 =?us-ascii?Q?Ylva0PbNdI7QXbUEVZj8MBBuvQ084xf/IZ+7RvCEo5q6UHCIPCM+6lf3cLx4?=
 =?us-ascii?Q?UNESLDkWLJYS9mdXyQhn4i23NWjWrxFHYZghp1fPaq+d69ansqB6HGVfgb2J?=
 =?us-ascii?Q?ryMWUIlIJhJmQ8pFsGMte2XVuvcJSLtD8XFNSBtVxgWrvABIzdN0Yk3j1AmE?=
 =?us-ascii?Q?HNRfdgoSUtADZSJptZjClppsTdR2e25juH+T0QuFJkSlQZf4g5O+QUQlVWdJ?=
 =?us-ascii?Q?wHVHaWwsshYbH9UW0JkDvPkQPtxKlGh0gRQg9mGTd/4+5hc2sBmxMZqHpoIn?=
 =?us-ascii?Q?ZJE6OUHn4fKpL+emfU7d7ySBlE4ip8ogYWu11JkQ2IT/0xtQGgonG/fr7k0H?=
 =?us-ascii?Q?adYvaRKQr3hSFx7h7PKPPxLndHkhgzjPgCCGaoKsSB8H16tU0I1jgPZ0Ja3Q?=
 =?us-ascii?Q?DKGe5LFnHiM6Hh9PY8newl+7mbe9WwQ9hGhJ1NYA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7deeed-b8ea-4831-2964-08ddbe4836d3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 17:52:32.4944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U/+phubKKdzIG50yQZ6TBtOvqWQB6Rw0SFX/MQ6zBsMOMhbwybClpFALLa63Gbj1+ACB9pKikM3DoKev2AI5UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10154

On Tue, Jul 08, 2025 at 04:49:57PM +0200, Jerome Brunet wrote:
> The id associated with MW2 configfs entry is wrong.
> Trying to use MW2 will overwrite the existing BAR setup associated with
> MW1.

:%s/id/ID

need new line between two paragraph.

Frank
>
> Just put the correct id for MW2 to fix the situation
>
> Fixes: 4eacb24f6fa3 ("PCI: endpoint: pci-epf-vntb: Allow BAR assignment via configfs")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 41b297b16574558e7ab99fb047204ac29f6f3391..ac83a6dc6116be190f955adc46a30d065d3724fd 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -993,8 +993,8 @@ EPF_NTB_BAR_R(db_bar, BAR_DB)
>  EPF_NTB_BAR_W(db_bar, BAR_DB)
>  EPF_NTB_BAR_R(mw1_bar, BAR_MW1)
>  EPF_NTB_BAR_W(mw1_bar, BAR_MW1)
> -EPF_NTB_BAR_R(mw2_bar, BAR_MW1)
> -EPF_NTB_BAR_W(mw2_bar, BAR_MW1)
> +EPF_NTB_BAR_R(mw2_bar, BAR_MW2)
> +EPF_NTB_BAR_W(mw2_bar, BAR_MW2)
>  EPF_NTB_BAR_R(mw3_bar, BAR_MW3)
>  EPF_NTB_BAR_W(mw3_bar, BAR_MW3)
>  EPF_NTB_BAR_R(mw4_bar, BAR_MW4)
>
> ---
> base-commit: 38be2ac97d2df0c248b57e19b9a35b30d1388852
> change-id: 20250708-vntb-mw-fixup-bc30a3e29061
>
> Best regards,
> --
> Jerome
>

