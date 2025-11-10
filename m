Return-Path: <linux-pci+bounces-40760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E76C8C49123
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 20:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95D6E1884267
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 19:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078FA33A01A;
	Mon, 10 Nov 2025 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z/cT4Dlk"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010027.outbound.protection.outlook.com [52.101.69.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3CE336ECC;
	Mon, 10 Nov 2025 19:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762803038; cv=fail; b=Iv793U++MHpd4QJy0TCx3pJHy/hbt/TFej2QkTxYnxmD+0pG97NSIN2cZnGMurTB3ZV0tAZa/RY1REdcBR6+M0brXBhYqpfXllVuo22Nha8mZ+8eux7W7whNplPZNnQp7Vt8MGHndn19IZTkFwZXvdHBxqvAmhJToeewtEGBA4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762803038; c=relaxed/simple;
	bh=UY3cVvCnPkV4/ns/x6onguzmF5fGH6/iptGazlmd8zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z6Z04G+cusNrFXpKT9Eg4joJHuAFj+zNB8peBKezAZi9MUyt0qU9oYR8u+qkEcI2da/T2MY51MwM7dHs5iq4aCTjo0oaxSGB7sCALYK5yo+bkpp5GQ0XhUG4EoSQDVPjLOzr7BpQO2CQ5DjlG5ljH9ws/C15lvlXH4FGaAhHsN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z/cT4Dlk; arc=fail smtp.client-ip=52.101.69.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnpdonMpMAsyYBXL9g/lmxflIjsojze0gewPJ55TPSJoSMK8vyoqtfBg6s1DT6HEYJ74jaHsMCb3hNHDlZ8QxNbu4Vo0MWGomX3a7BCC6GdZHYioOjKDf4/8DDXnP7GlO/Syr9rEYXTQ8SEC1zUa3VTC2TahFW/hAoK25cctgDZevRDb9x2EX7reVwvO28a+5HoF5nxAdF++8/L865LxxK/RgJHjZJFlFvLt5bYoEgzTSiIK7BdMnKdkrmsaex0oXP7h8mIZlQ/5sX2efCus71iW/aBAw5Tgwsv2Q7DXfkwPzAyT5WCVLuZNrn7T5T7oEON5k6ZsUhAVdC//lx/BNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmoM2mJZkcaJnsfnkXWuWfhe0ne56G7XC5iAvnKdEk0=;
 b=R6hPyd/FADZGojebkKgjJpUMe7GMwTkNaQeJFC9J0KIvcJN2cxGgdFJEhcNas3c//4Znkr7UhZhRIWS9R0YZ7oOBIgWxymy2N24v3Sh0SkTN3MV5RnwvuZ0eUpjcFbxZqegkr4OXR6EUP9y4V1GGBp0QXPRPcCzwYtnLerXquHkC+Nla5P/iVarSARPkcTyo4vLah3uKGLipF9IUsEVI3FTBOjRkmVp3dHKxUqcsXxqDrPh951coii0kIo2G/X1ny+FTROYsDyofiDHmNZBJLwnMQEpQpqSUCOvPiBO194VOfqVc2Xh85crJSBCNCBpW4akX5elUDEurVXvBXWtP9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmoM2mJZkcaJnsfnkXWuWfhe0ne56G7XC5iAvnKdEk0=;
 b=Z/cT4DlkRdhZKaVsh7C0PgEhFGds7P0VY2Z/BCzbx3s2neBc8IpZcQauO4BoT8hZd/W/2KX4vmabxXxDa6a/5VAq9A6vGxOr+EquPRRIS5Puvc4DZ57+EjmfrucyEDGdGTUiH0gA6Jrq8ytxjj5dMwNAZb9ySHLHY8OCyvWB7tzGt7cm6JYM2b4rsMehEf0fCszcYKZ2L1dbV25pTfGKvjCRWKPG6E7G3KcGLArInYjjyqENXC408g3l9zs4zpVoxlv5Ai/0kqa4bL9bWXpCzU2KwTBTic2052N8TjKIlkbOT8O3N1UfyF0QThMpJkjLmvWzOxIIxZFlLvJV20x4XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB9PR04MB9889.eurprd04.prod.outlook.com (2603:10a6:10:4ef::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 19:30:32 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 19:30:32 +0000
Date: Mon, 10 Nov 2025 14:30:23 -0500
From: Frank Li <Frank.li@nxp.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, bhelgaas@google.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com,
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, cassel@kernel.org
Subject: Re: [PATCH 3/4 v4] PCI: s32g: Add initial PCIe support (RC)
Message-ID: <aRI9T260bl9bok4W@lizhi-Precision-Tower-5810>
References: <20251110173334.234303-1-vincent.guittot@linaro.org>
 <20251110173334.234303-4-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110173334.234303-4-vincent.guittot@linaro.org>
X-ClientProxiedBy: PH8P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::30) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB9PR04MB9889:EE_
X-MS-Office365-Filtering-Correlation-Id: 284490b7-f924-401b-915d-08de208f9d05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8mXfDr3rFHr5Y1ebNc3HQmb+rzxJyPkEoKNHkMfY9Ahf8faIUi9gxJps1LQx?=
 =?us-ascii?Q?QTIjz9pUyLBl97oipMIwuzRYp2bwC1g+p+HcQ/Vlft5YMw95x5rJagjkgCGh?=
 =?us-ascii?Q?chMS7FAlhiIUBG+J1i4A0+SHi+pIz2IrlbpfHbh9sIXb6Z1g1p7A0B49iAE7?=
 =?us-ascii?Q?UMnU7lof+B6j50dMsUnaoMRp79TJPbKB3ZZ2OrX6o/PBUxu/fuJeA9WNAYhF?=
 =?us-ascii?Q?Jz0CoPZiQa0WgBbwJ1E0WXMPJe6kjTM3qHBmW7SO3SSVE4Lh00MqzlkCHf11?=
 =?us-ascii?Q?5xPQ6mnvqS/RxExlWdFEwOLpEDsKLYuppBLOuw6SJ0vk9FZo7LKdMqqqsCMY?=
 =?us-ascii?Q?FPJ9yQTDMKzuMUzGxpCa0R+ZueUGfdXTPe7xO2DOkmq5ZD67k+W0UyqkO6Kc?=
 =?us-ascii?Q?czLhBacWkhNyIPDDT2tRfc0ezRTBdX9gTs19LKK7D/+jpbKOG44W8T8ljtJs?=
 =?us-ascii?Q?KX/riMYgA/vtWvlR3CWRLzLdDLtyaCHii/hsy/vXua7UWbPQQSygtYdV9VRv?=
 =?us-ascii?Q?AfwkTReepg980vTyDkM9zKoCd1UR80jHos3YzZKRUkoaOblMdRFTlmXKUTOM?=
 =?us-ascii?Q?MA8a4fnK0D2q8NJXz+Bn2FtH+5NzdDWjXXIIsw/yZcuhsrvAtctzbQhBaVyr?=
 =?us-ascii?Q?XXMMr7XbVq9Z0ZnDnMSDbGsVVpK19dMbhqMfAjLpNIDBv0BzVmAu7lkqACsZ?=
 =?us-ascii?Q?onOwbT3ENCzk7GrcrxmnAxenES+SSae8WHK8FdHVRu7iQlJKxu4D/5WcsEhT?=
 =?us-ascii?Q?r7p5qDN79CMUScjoIZhuLmAOz3wQeLQOhfcyIYNu0j1XGETOTDOyOE7BtDVc?=
 =?us-ascii?Q?tcd4kvvi6afYU0N/ho9Zu+9+jclR1bt+0MMT5IgmveM/ggoXSRDjPEWwQ3uC?=
 =?us-ascii?Q?sVnK3uf30mgx5muRm4VG/8zTAk7uKpYl2sPABDxSOCTqYoy+c2bMbiKyNjk/?=
 =?us-ascii?Q?s8mxqZe5otBndGL4aHT9BH2WuTv8G+NoS2WQPSwS9en3NC8GcfByMHfItfNW?=
 =?us-ascii?Q?gVzIm1k6dn0soNISey/7iXv69sFlI+MSipIB7CveJ3BeLbVo2Iq3w2Si5Wt6?=
 =?us-ascii?Q?7PQLuE3rOuQzaUBZGWiE60UshCWbel3QicYztP2qmgLmbbA4CEP78AfaRBCp?=
 =?us-ascii?Q?fkr9GTFlt6aSTSyXV00UzemPYr7jNerZOBDaNNcXU3JqPdlNcELJOK5iXW9p?=
 =?us-ascii?Q?0IPtIuE2dmgd/CsbKvlUvd4tl4e93g5mozYHoCiDuFVtC1ON4mVJBBvesrP9?=
 =?us-ascii?Q?+V22Or6yfbMuSgvo/XWS04m7wP5YlsnUmvzoZRNgnR7TwQPxSpvj0epfLVG+?=
 =?us-ascii?Q?BZAnKRXgkOG+IwI/7vnnbyND++xtqvHghP96nPNZPVTqJMgLn3IpwuU/IKKk?=
 =?us-ascii?Q?pKkKYPTuRsKPOK5/et6SUNH3b7sWBphO5oE+J3+qTJeHsxdp7aGw1ph0EX+0?=
 =?us-ascii?Q?HBRtOSuycMvppAU5AI4gYB1WJYc7Wb42ZEo9tQJ7GIFfxNFJXNx/x6mrf6l1?=
 =?us-ascii?Q?faqR6CrruhD2VS2EMo4oAmQ4hsJduoC1pfw4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5mIPzCewYBtbfibh7GMlTy983CC9czzXNsbkuDKT67w8/4TA+5rYHM+saCcg?=
 =?us-ascii?Q?bZnZvXEiKfL+66WjyKaenmcicsU0l/ggdeG+p8LvISAufkUI6n+PqyAciYZH?=
 =?us-ascii?Q?hZPAgKYnI+aLZejELbv8A9/wgirIQNm+hW1+h9iA8dWY1Q6L9WklHRZ5aTI2?=
 =?us-ascii?Q?GUNlD1SOnBcVgcWunUzb9zmBPg67WqzF1N2Nmngh7ohN1w5V86ccJXbW3zjY?=
 =?us-ascii?Q?6GDyvO4Kw1SzfWQesoZ8iNwVYxkiswndJyZjw+bcPPenOGxBDcjB7C5Xo2W8?=
 =?us-ascii?Q?dcSlgO79cSm0rEK/54Fw+g0QfnW0YdyEliQBAD3dpEzWvvTHYF0sRx8XeFEQ?=
 =?us-ascii?Q?s9EDhHCfmL9BLuPxOmwYHnxqKriSCGpfwOls4Sol7pMbTWmpKs6N3gg+OgUX?=
 =?us-ascii?Q?DolBffrS0Fely4h/bGV0rdWTOfbJfq/51jHUX42m8elJv3DYe1qJz4Uj8PN0?=
 =?us-ascii?Q?NhW4C4ha47l/DuSl9vgY1/RtXTT5aIvnHtntORHWGZ2JoPeX1aCsqI7gLseE?=
 =?us-ascii?Q?WC8B1HttndqA7XKbgfbtF2ybWbDHVMx/aGPr8V8Pidy4j+UCakCErQ642x0y?=
 =?us-ascii?Q?5SD6dWEvZhEE8v+SMb6lyuATEhlpL9acIYF9zdjvsF98Ohb1yK3/w8cFz7NH?=
 =?us-ascii?Q?ZErNrcUwzO6QUxdI35SajnRMGY3Iw3/CPorvO+ORcdKUd+A1VNuzTXDdOmhv?=
 =?us-ascii?Q?7xxQy84ParmtoXzdnYjL2v0O4g1eufiSV4Z6a+PF47w6V4ta2+M0uBdA6tin?=
 =?us-ascii?Q?fbQTp7peM3H+3M/AjQ59GNEIx2Kr9BzOHQB9oaENiaxmCczmXw9aE7mJ1q24?=
 =?us-ascii?Q?OuL2kJWHmspXOXBC0Y/oylS/pquS7B7RXgcxyQeAlP5fYk80CGU2zmDcAJu1?=
 =?us-ascii?Q?Nw9BbmaFkV6nnQ5oOsRrDl3HsDrA5DZI/jSjrEAuORsvtMMlZGRIo/DrdSXf?=
 =?us-ascii?Q?XPduLjaex7BLGXoW5NWSchIDJ/8VPyj74XtrO9ovoFxAY4NfUj4loJlQa3t5?=
 =?us-ascii?Q?9mgOCsHQjzpwO9PSamODDRPIhGY0hehYCqJZ060TXfR2uSXYq6j24KOQqYxB?=
 =?us-ascii?Q?dVswghrf8kv9AhzhumMKcWQiQDc6mIZgGufyZBUnrZ5I5PXKrAdxEUst3dWq?=
 =?us-ascii?Q?FTwoap5WKFWKG4HFGgz3P2q3DvAt/r3hu/wGtXLAEq5JLX2C1PkS69MBQ5Lp?=
 =?us-ascii?Q?UpgjAeCskZWklwT1Df/5TYFYQBgoUdlVPSUdLt9EAs1dsxoml4l2PrWRGgF/?=
 =?us-ascii?Q?S0rOaRet8UEDIHOell239lae976rxv5Eg0OpCrO9jtNZ+Tf0yZHJtjhQAzP6?=
 =?us-ascii?Q?J2CIJvw2G5GbQTw1ajfw/Y/MccREoglgGUCOFSkA0S/Cz4pC18SLuNwxF6++?=
 =?us-ascii?Q?i5GrN5vjjEUEbIUzt4eCHZdg/OvYHKY6n+J4vzIuAKr2Yih7hSwHlLrj7rVX?=
 =?us-ascii?Q?QoBHFerOHG11ErsHcXOmexXxZW7SuBpYmXi8yZs4GXFUZBj0WSXi2bEyI4Wq?=
 =?us-ascii?Q?SLw1ht1eAclAVeoaACkVCNX4Pwg8617m5eaDLTlgbzLYeeTGpGrv4jUdwoMM?=
 =?us-ascii?Q?cyBQnezdi+U2T2vsa1aR+qly4/KfJ8drEIoW3gnU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 284490b7-f924-401b-915d-08de208f9d05
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 19:30:32.2526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3NOeDLLwKom7eQgXSRz1CrpQfNiOu9zYL6CEqrj0Np90MYkIluW+8G3kK7d5bGwecuH32tphNQ9ZDNM68c6Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9889

On Mon, Nov 10, 2025 at 06:33:33PM +0100, Vincent Guittot wrote:
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
>  .../pci/controller/dwc/pcie-nxp-s32g-regs.h   |  27 ++
>  drivers/pci/controller/dwc/pcie-nxp-s32g.c    | 435 ++++++++++++++++++
>  4 files changed, 473 insertions(+)
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
> +config PCIE_NXP_S32G
> +	tristate "NXP S32G PCIe controller (host mode)"
> +	depends on ARCH_S32 || COMPILE_TEST
> +	select PCIE_DW_HOST
> +	help
> +	  Enable support for the PCIe controller in NXP S32G based boards to
> +	  work in Host mode. The controller is based on DesignWare IP and
> +	  can work either as RC or EP. In order to enable host-specific
> +	  features PCIE_NXP_S32G must be selected.
> +
>  config PCIE_DW_PLAT
>  	bool
>
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index 7ae28f3b0fb3..3301bbbad78c 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
>  obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
>  obj-$(CONFIG_PCIE_FU740) += pcie-fu740.o
>  obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
> +obj-$(CONFIG_PCIE_NXP_S32G) += pcie-nxp-s32g.o
>  obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
>  obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone.o
>  obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
> diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h b/drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h
> new file mode 100644
> index 000000000000..c264446a8f21
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2015-2016 Freescale Semiconductor, Inc.
> + * Copyright 2016-2023, 2025 NXP
> + */
> +
> +#ifndef PCIE_S32G_REGS_H
> +#define PCIE_S32G_REGS_H
> +
> +/* PCIe controller Sub-System */
> +
> +/* PCIe controller 0 General Control 1 */
> +#define PCIE_S32G_PE0_GEN_CTRL_1		0x50
> +#define DEVICE_TYPE_MASK			GENMASK(3, 0)
> +#define SRIS_MODE				BIT(8)
> +
> +/* PCIe controller 0 General Control 3 */
> +#define PCIE_S32G_PE0_GEN_CTRL_3		0x58
> +#define LTSSM_EN				BIT(0)
> +
> +/* PCIe Controller 0 Link Debug 2 */
> +#define PCIE_S32G_PE0_LINK_DBG_2		0xB4
> +#define SMLH_LTSSM_STATE_MASK			GENMASK(5, 0)
> +#define SMLH_LINK_UP				BIT(6)
> +#define RDLH_LINK_UP				BIT(7)
> +
> +#endif  /* PCI_S32G_REGS_H */
> diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g.c b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> new file mode 100644
> index 000000000000..18bf0fe6f416
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> @@ -0,0 +1,435 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe host controller driver for NXP S32G SoCs
> + *
> + * Copyright 2019-2025 NXP
> + */
> +
...
> +
> +#define PCIE_LINKUP	(SMLH_LINK_UP | RDLH_LINK_UP)
> +
> +static bool s32g_has_data_phy_link(struct s32g_pcie *s32g_pp)
> +{
> +	u32 reg = s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_LINK_DBG_2);
> +
> +	if ((reg & PCIE_LINKUP) == PCIE_LINKUP) {
> +		switch (FIELD_GET(SMLH_LTSSM_STATE_MASK, reg)) {
> +		case DW_PCIE_LTSSM_L0:
> +		case DW_PCIE_LTSSM_L0S:
> +		case DW_PCIE_LTSSM_L1_IDLE:
> +			return true;
> +		default:
> +			return false;

Are you sure code can go here? I think IP set flag PCIE_LINKUP of
PCIE_S32G_PE0_LINK_DBG_2 only after LTSSM in above states. Do you know
which case PCIE_LINKUP is true, but LTSSM is not other state?

I remember I asked if DEBUG0 register work? any conclusion?

> +		}
> +	}
> +
> +	return false;
> +}
> +

...

> +
> +static int s32g_pcie_parse_port(struct s32g_pcie *s32g_pp, struct device_node *node)
> +{
> +	struct device *dev = s32g_pp->pci.dev;
> +	struct s32g_pcie_port *port;
> +	int num_lanes;
> +
> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +
> +	port->phy = devm_of_phy_get(dev, node, NULL);
> +	if (IS_ERR(port->phy))
> +		return dev_err_probe(dev, PTR_ERR(port->phy),
> +				"Failed to get serdes PHY\n");
> +
> +	INIT_LIST_HEAD(&port->list);
> +	list_add_tail(&port->list, &s32g_pp->ports);
> +
> +	/*
> +	 * The DWC core initialization code cannot parse yet the num-lanes
> +	 * attribute in the Root Port node. The S32G only supports one Root
> +	 * Port for now so its driver can parse the node and set the num_lanes
> +	 * field of struct dwc_pcie before calling dw_pcie_host_init().
> +	 */
> +	if (!of_property_read_u32(node, "num-lanes", &num_lanes))
> +		s32g_pp->pci.num_lanes = num_lanes;

Can you add this to dwc core driver?

Frank

> +
> +	return 0;
> +}
> +
...
> --
> 2.43.0
>

