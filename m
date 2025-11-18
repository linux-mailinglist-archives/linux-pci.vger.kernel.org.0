Return-Path: <linux-pci+bounces-41518-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24163C6AD39
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 18:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 51B5534F23E
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 17:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B743730FB;
	Tue, 18 Nov 2025 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XE/Adj9w"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010010.outbound.protection.outlook.com [52.101.69.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E49E36CE1E;
	Tue, 18 Nov 2025 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763485286; cv=fail; b=ebsH4bweQKk9DK1eoWk4fFvcmiCPohwBFMfp8P4D2Mzvly8PNh/hiF+yU+qN/d7lYL+nYcNZMGaTP8FVVDrDgwxR4IDu1jMo+QvGs0TF1yI9+/Aeyzmh5hU3KWsRDIsCkycIelqjW21Pe711nOP65kplFF0i1gp9dR3w4gQgKic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763485286; c=relaxed/simple;
	bh=Ws7JNkgG70f63apnMpTTdA0zgfy6J/te5p2OMuOn7rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HbnGdaprG/Y26pPZK/nFDV6YgltqSMF5Z+mzCTbXB9DPgx42QJCmAN3+YZZ3t8wS+hI72ky5TTSSZ1MBUrlk39ycb7ca2g6Fk3MCyGBtp59UCJ9R8jsrgthrBo/Z3HeolRwb2aqJUhoyPAZhtzBBgNNc3O09CPz7xcWXK5ZgTIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XE/Adj9w; arc=fail smtp.client-ip=52.101.69.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C809uic5iIScrQqFxUyY7aJebvXPc+KuXVZ4MUFiMnR4daN8BXOJ4w66PbcdAAZbD2A0A7QrYwbHbDqHgP9SLfKT68PRN5eD1TMUfkHFWaNin4hb6jA5sQV+vH8fKzte4LoGDUuSBC+4K7cysjfN3J6aj0BW2t4gt+FAnnE7OgJLXverkQb0fSxTflA0du/GIOF24L6ESpWs83nMuKflCCFSZ6Li151f5HhHsr0Wb63CsGgJWXt3MemJrr6XlnP5spfufXLZ1Rgin9TpZCkoh7RINhAjhDKe9QDvF+GYRcoOZMOGYKniGXdn1tMU7djM+n5W3mSfB39Vj62ftk28hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzN6FpLHyGbpRSrAMIcY7ywwzNsyVcCzZm5nZM6lvwI=;
 b=VyCrFPnX2uXWhImX5LpAKs5M0Cyv2arSNuakIV5BjV0VXNycubncmSJ0ClDZg2Td99Mvk41pFLymuIq6e/2ZpkU/YBeTGoU1T0mm1eMf8RMM/e9oRnJuvQGQwNbFu5wD8/RSeN0ci8qQ8/uu/Z6WdT9DxZ7A7R2Ou4H82LFthdVmxLBR4cSKzeeb1D2juwdfgP1JvyQHx4ZbWSLhIlGX7TikSHi2qty2NClSWPPDXBF4mxsYmbpwV+Tk795H1BV2rhA1yzqpyhemmBPL+pt+eSMG+166g2VHmr8M1YNV7YJ9LnPXnFC5jtUB/phpy64FveI5IvEqhXW/4eS3pS6Izg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzN6FpLHyGbpRSrAMIcY7ywwzNsyVcCzZm5nZM6lvwI=;
 b=XE/Adj9wBuH97TNq4oEhhRd+wwZDzmZ4FXTiw9wb0GrSz53MD7bfFAFWyXd1RAcP5z6jCEJkzAKtLYl5OhPXYcJu10hjCu4bqjTjmk8SYVPw4wzc6eySC5lUF+DAnI7I2JyIvaVrcEJwOzhalk14uRIYusQ2rl9Rt60l3ikvtmd9BsV+mnMhYBWTrczUYQEklQLnWVeLTMjGYNmqMGF5LSfq99s2C+Bn0oEIvWZ0CYIwAYqleZvHRsUpPqybtozg9wUimL7piTxCe1/frCe6f+q7Knth9sds0531B6PisVFo0xqSZWCPJI85bqI6pqWYS//f2mSujHOSnn3uvjl3UQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA1PR04MB10673.eurprd04.prod.outlook.com (2603:10a6:102:480::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 17:01:20 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 17:01:20 +0000
Date: Tue, 18 Nov 2025 12:01:10 -0500
From: Frank Li <Frank.li@nxp.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, bhelgaas@google.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com,
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	cassel@kernel.org
Subject: Re: [PATCH 3/4 v5] PCI: s32g: Add initial PCIe support (RC)
Message-ID: <aRymVtJKtcydh3g5@lizhi-Precision-Tower-5810>
References: <20251118160238.26265-1-vincent.guittot@linaro.org>
 <20251118160238.26265-4-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118160238.26265-4-vincent.guittot@linaro.org>
X-ClientProxiedBy: SJ0PR05CA0107.namprd05.prod.outlook.com
 (2603:10b6:a03:334::22) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA1PR04MB10673:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e9087ac-5b07-4ad8-ded8-08de26c41863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mE5wyScceJD5efhRR2sY8IcHXbXpCXXU3jjP27/64TZ0MyMPtMT+DGCRYx95?=
 =?us-ascii?Q?ZIFkpk7JsulHtf3/xEtrBe6XqZT+ZoB0qNZRXFugA5boEev87KM/ziq8h+3y?=
 =?us-ascii?Q?Rz+/AULZi8gUzVoOoOeOhQFGsBhjJhYSMrscDP2FK7jk9uMVfIaPFhcMsBLm?=
 =?us-ascii?Q?6mGI1ytauEnZOHTdHQ+rhm4tL3FQns2m4/rZhyjhXNfaCJWxl3Dvv1YMShuv?=
 =?us-ascii?Q?2TZ8tmaJgqB/IXX8Y3lt2WlgHXOY02QuOfwMVNw3Eor89GB2shRgsSqr882A?=
 =?us-ascii?Q?/FfP/LaPrUdVCF//IWAZnqb9ANyRFqmbrlc/XI1tJDv3ciHd0KKltQNsIHA1?=
 =?us-ascii?Q?447tZlg3P3N5EFd7/iA+4VbnQrcBWEw24uIiw4qUsugsoTet+3x6rOraIOb7?=
 =?us-ascii?Q?MLfBCooz4n4q0DLefXJ65DisD6McefwNA5Iu1vuGDaiLfmd/KfH5cD2HTo87?=
 =?us-ascii?Q?+dxmzLz3kygrmArmKmGf0VE40h7rX66ID4KIgaz0iP8HwtgDM/gBYw2N9rtD?=
 =?us-ascii?Q?+XO+R8CNS9eTEgCO4SZN2BgNf1aWK35EbmxAx8nmDUiH5eISFQVSfOqUl5vS?=
 =?us-ascii?Q?vLZZEsR9srQvKrBe6RMIchHKoP+4ln+QcTxVwgLKO1WhmkUGNPfK2n0+l01t?=
 =?us-ascii?Q?CjMm+sXgIbVLBSh3SKUDtzZQrkYCpfFr4u148KVbehRng2vvba2bLzYV5kwl?=
 =?us-ascii?Q?qF4qdSYun3ie/mn9JHePjbRg19rTWsrWdeKAysv/sHPW54LQwGGP4EjkcZTm?=
 =?us-ascii?Q?td2bYcJ/5+VmGC+txRPmiIWwreMCGq2/hjEN3mfxpgDC4ucqPnglzv3Ov4fQ?=
 =?us-ascii?Q?9JimC4FE+EooTrGIHN3kMQ2eqgYs+tluQicHzkjdCcKNnFMu7RnaIWoEyWnZ?=
 =?us-ascii?Q?dK6762rodUNH7NpAS6rCTUjyW4q6/fcYJ9TezHzMi2qMlavRA+uMf4jGz4Jj?=
 =?us-ascii?Q?sNVjJszH1ATOnuYSkDhoeOepmBCpcs7Zk4HX0o469KyQOOx/YERsLWWqkrDW?=
 =?us-ascii?Q?dqpquTJyItgwdz4PMqkQKYkjkPA5fuS/zBuDrh6xvl1+sB0NnV9VBmyzYYee?=
 =?us-ascii?Q?9H4zZK9mUfK1LwS3WLCZJMvXyPvXon8yL8x8rWWSt/Fn4VC752nYFqknplbY?=
 =?us-ascii?Q?MP06Jru1/hv5BgSUP94BAlKuUnIxrU1/vXu+tNEdmsMt+Em8j5yG7+sMTeWZ?=
 =?us-ascii?Q?Dw+QRBK7PG0qBneP8BYK0iFovpCX0yiTtznDoQrG4PU/NPetByEoDrm42E3l?=
 =?us-ascii?Q?agcN9Bfs7o2tLtrqw5jnAXgUYMwx5lUS0pdpwBnFUyGwlxenUfw7ZFuzOzDF?=
 =?us-ascii?Q?K3oOxz2JCh77Ib75l3as30XjMeNj3uOlMUMIoIX0zfbEmf4jcO2gXKYGVwPO?=
 =?us-ascii?Q?9OjR3B8uw7UiDzAUT5DTzH9Cj4UjSVaWllF9mmPqwx1q0IxeZxuYHQjw9J9h?=
 =?us-ascii?Q?wOXnM6g1oeBY3nYSOHVj+y5528TuBvBY0k8HFjTVk5rQm6yNTWhdzEbCOCj6?=
 =?us-ascii?Q?YcVOoSgGJB+Nv/8Yhb1gtX/lvRPrnMxT6JDE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8lqsHaurFyvQMpiF+owCiWRUPea4YwF3RsxUn9oq5N5MhCu8XTy26fG3p+Si?=
 =?us-ascii?Q?dyttpgLz/NajchB1YSAS0lQzmbcF6/gLQX9HUU5d7DUwpa2+XByDf831BlMA?=
 =?us-ascii?Q?ZfiKVC+l4sWNPTc1dd2mROpRY6FA5hdXxzcmMqOwhj3BJB3OjW0BPF0jVzkX?=
 =?us-ascii?Q?gOv076jyY7nwh2qOZ1sbjyE8fhmQ/QUtNfy+AJ4VHrxZx6QIjiebkBy7mM33?=
 =?us-ascii?Q?uXEHvq3K/4mleLV92k40sCD4o5GTC1JCnzh3EYaWlZIOOgn1xxPdOmg4yruv?=
 =?us-ascii?Q?tElTncFbgsXOFX3uVDsX4sYDWa/53SC39hhx5DBoxvdUkCZuXzsKBgOQhWGJ?=
 =?us-ascii?Q?vnt/AMofBsWKCx/Fb9rYxnpoi8mIrN6UJVKWR+x1LgoXddo4NuaFYLkdchno?=
 =?us-ascii?Q?CE6m4B9SRLsYzNKocUKy+cdMK4kUekMXScDuoaLjeCb4IWaTOxweILxvvc/j?=
 =?us-ascii?Q?QEyFL1mhHv5k7ozuLWBWyP2m0BnPdOGqlmBrp44up6iYtJSdvp49IqlTeHjA?=
 =?us-ascii?Q?k3gXv9zJwCIlthNLM9R5CSdjf2oJ7/QxV827aqNOAlYpnfGCIUUGS4uNhtR+?=
 =?us-ascii?Q?X4LN6SIbsJl//DvEsZldNCLuBHvSuDjfkB6vQEfq96NTYGI2VxNkK8P8WBYH?=
 =?us-ascii?Q?3Zl1P6dcD8LgpkEgtFre2XMsvZLIhBAZ5aFjUFg+SAKPOOhKprdgzxyG+Ac0?=
 =?us-ascii?Q?Gt1YC8rmr99fcSJRFZv+3gzIxy03sgAgdxSFqI6WkXyad/l2rkS1c87utRiK?=
 =?us-ascii?Q?W9kR8ZcO2W/E7Iw+3dsqS+M3ANRukcOCmBl74UZAOJqiKTD08pTFO772H9EW?=
 =?us-ascii?Q?gROBtxmkZfUrMugN98BM5T3bWW61+GOC88NKiHTA1GsobLWbHpUTIXf84Vhb?=
 =?us-ascii?Q?H58GgflDC72HbxvCyOvfoyDG/xXgDrTQS74dN9rv3KFluFli0NXq6OzW7Yoz?=
 =?us-ascii?Q?u+Kc8A2kI0VGFTzCRICKvG4zHmikXQcR+HM1bkuHk/cb745h3/cP0Myollex?=
 =?us-ascii?Q?qgzaW7sSjOCv+af13yrSDSlqM1oz0Os49SXRoSDio6ndLuS1GJHQ8s/6lCet?=
 =?us-ascii?Q?xDxdVirS6JTOW3SMhjmFaeVyn9NpvIDjcEDZLCeAcbetQPIgieZGdkcCnw9z?=
 =?us-ascii?Q?3tB7YAUACl8FEXsaR4IYBU7tAEoKv7dq64+3pAscPPGqgRmNASe34yc53ATj?=
 =?us-ascii?Q?mqNrpBxAMKyrRXNSR5/dTm3W1aL4Q6EG8svvz1fRUZmiohGpvsoDn65MjUPg?=
 =?us-ascii?Q?neRKkGxvnmAOsPjcP0OMquTiYgdyG/ZdhLwrM8+bPKOMlwerfnJM3lZlUoc+?=
 =?us-ascii?Q?8rCapA7+MtYuf1MUEvdcdyCMfsBiWbC8YpSgENBq8ku7VX2x15mLetOvHeT2?=
 =?us-ascii?Q?bbXGDtKzU2Z2r69ePaMtyQ+mspeSn86RoGQ7gH1IdVWQjTDeJbdxbhKYcu+b?=
 =?us-ascii?Q?rEc+jxpuKUdzBDQaZpvQomIwDqV0tghOkqPMWHIXCEeG/GYGibU4VipcOkxz?=
 =?us-ascii?Q?XXEKxCoyfPoVsywMy3iVGvfmNn3zwDH1nepZJb87N3o85iuI8VHL++JGB5Bm?=
 =?us-ascii?Q?6INwUwayJzQglUi+lc7zSQ/CvgU/42J6okHZLvLu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9087ac-5b07-4ad8-ded8-08de26c41863
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 17:01:19.9460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dt6JRsLPREB7o4+ftR8CJfGij6bK3dzpmU6gYcdbHaAjcVm+H4zZVn1tzho88uHVHlOBVUO9aOY0Sv1qxXuB9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10673

On Tue, Nov 18, 2025 at 05:02:37PM +0100, Vincent Guittot wrote:
> Add initial support of the PCIe controller for S32G Soc family. Only
> host mode is supported.
>
> Co-developed-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> Co-developed-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  drivers/pci/controller/dwc/Kconfig            |  10 +
>  drivers/pci/controller/dwc/Makefile           |   1 +
>  .../pci/controller/dwc/pcie-nxp-s32g-regs.h   |  21 +
>  drivers/pci/controller/dwc/pcie-nxp-s32g.c    | 391 ++++++++++++++++++
>  4 files changed, 423 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h
>  create mode 100644 drivers/pci/controller/dwc/pcie-nxp-s32g.c
>
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 349d4657393c..e276956c3fca 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -256,6 +256,16 @@ config PCIE_TEGRA194_EP
>  	  in order to enable device-specific features PCIE_TEGRA194_EP must be
>  	  selected. This uses the DesignWare core.
>
...
> +
> +static int s32g_pcie_init(struct device *dev, struct s32g_pcie *s32g_pp)
> +{
> +	int ret;
> +
> +	s32g_pcie_disable_ltssm(s32g_pp);
> +
> +	ret = s32g_init_pcie_phy(s32g_pp);
> +	if (ret)
> +		return ret;

Small nit:

return s32g_init_pcie_phy(s32g_pp);

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> +
> +	return 0;
> +}
> +
> +static void s32g_pcie_deinit(struct s32g_pcie *s32g_pp)
> +{
> +	s32g_pcie_disable_ltssm(s32g_pp);
> +
> +	s32g_deinit_pcie_phy(s32g_pp);
> +}
> +
...
> +
> +module_platform_driver(s32g_pcie_driver);
> +
> +MODULE_AUTHOR("Ionut Vicovan <Ionut.Vicovan@nxp.com>");
> +MODULE_DESCRIPTION("NXP S32G PCIe Host controller driver");
> +MODULE_LICENSE("GPL");
> --
> 2.43.0
>

