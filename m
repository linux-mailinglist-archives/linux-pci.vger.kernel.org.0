Return-Path: <linux-pci+bounces-6252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EBF8A554A
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 16:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963651F219C0
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 14:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661BE76025;
	Mon, 15 Apr 2024 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CYoJ4++7"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2048.outbound.protection.outlook.com [40.107.8.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8135D69D05;
	Mon, 15 Apr 2024 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192175; cv=fail; b=dDyyt0Ss41UAS0KG/1Ram9GEtCNoC9tDw2iFynv6mTbqqhP809k2HytGsOrlVRalf65h7UIenBoDW3bdNl3VK/7rXPkxb82PELwqKxvN0JGSV1ajsPO3slL4ZbOCbLsVOWdXJhcOK3bFoGNRzr/ZGNnK1s9lGwnNFM+YeWl+o4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192175; c=relaxed/simple;
	bh=7ZFEmwfsQB1o1k16Or8DCgkCnsiFDFxZt/1hkIecxhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e5b5eRX6lHhN+9UCrVxS1psT8avhy//5dl6winoSmXPljjROz1xkNsSx7I1kTCwAqfP9Iy0DIahQS2Vkfs4vjCmzVnDK2DnckUtzr0X8nvRKqm+eL2FsPnU6co2r+WdSIldV3DDfPEFHPJeuYzyXc60zT5ocPJv2zA11p02F7AA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CYoJ4++7; arc=fail smtp.client-ip=40.107.8.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqbFd4cjw9eR28RllLBBlTi+y+ecvSO19MZTCK/WmCyrFZLlZR5gPYXWm6B7DeD8VkgC5bBWAWb2uuHGTV+mJTGqISaNBlr6o04msuR3ieAJkkaUpZic4mFWE5fSCDg4kocwvkvHHvlkqYEH5sLU4h4kJCutLvegYJxQUiKDxfD3syYM7kCXPUWN8+x92you2b39CSceShB/a4IqhnV+XzzJWRQ1clETYOvu1kv53SoHZNGr4Y7zQd2Dzb+WiQ+1K1kSVTGcwaRSbIVpovpLNh0AvCKUFHGvt+9i//MurF0wpBtV+KNiuFKlU+fa+nKu1iS8AmGYVQdHaTTxPVX2Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJUoUvASjbC6QSsm/rrKR2kUiJ/c+3MiqLn2Ghbwi7k=;
 b=Aahpi1/wIK0S7r4vJp/tX6t+wDN66RYsKf6ueKNI3jBt4+yW/Tjj0xByZoZgIg1SfHWD6Rtw+JcUdn0PftEXVcExiQFSn291Y9Zj/rNMYSGL/OilALjvfinx5mlC9Nlwcy1w926XO3pBJvKevy7ynkMwUpLRe4ZTgQggfawk6SoQLsMh+wkV6Hobz0NCjQqF7TiYp3XQD/PpahTMgz9voA0Oq5IXw5n7Xo6gfHGbIvSu9ReyYiLa+Gre2PQBjGQ1jynQ5V6EP/fCbgm1kL2ADtPvr76qjLVZ4Pe+oTVENFD1pZs2+W3zh02pJiffhjgIqQKBZLDvdORNdLVuip8Rxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJUoUvASjbC6QSsm/rrKR2kUiJ/c+3MiqLn2Ghbwi7k=;
 b=CYoJ4++7Tf6hD/fmByak9yYNudbOQvYzf9DgLF/DrhOwWnOzbtvgicha6n5OvsR/Npt6curQw0NbTrnsoLjjQyuxwzEXzUnV2O2TOcq27PPJTHWMu96p3kX3og8G7rewR/YzMyr69Yo1Bw1DX7FKJ+DK/egOtxxiJqs3oikE6GQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7080.eurprd04.prod.outlook.com (2603:10a6:20b:11b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 14:42:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 14:42:50 +0000
Date: Mon, 15 Apr 2024 10:42:41 -0400
From: Frank Li <Frank.li@nxp.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jingoohan1@gmail.com, mani@kernel.org,
	marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v7 7/7] misc: pci_endpoint_test: Document a policy about
 adding pci_device_id
Message-ID: <Zh084f91cwNF+J+i@lizhi-Precision-Tower-5810>
References: <20240415081135.3814373-1-yoshihiro.shimoda.uh@renesas.com>
 <20240415081135.3814373-8-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415081135.3814373-8-yoshihiro.shimoda.uh@renesas.com>
X-ClientProxiedBy: SJ0PR03CA0380.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: ac98085e-faaf-4a12-b397-08dc5d5a52fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vzE7tuWtINSuS8tSNO1saZza3LKjpLAZLLtWHGg4/UpLtRh3H0YAI7gzG4OqXmmnrHfzdYLf/Qo2YyOse9yNHi17/dTDTaM3vWv1JOghhHUPJ/Bjm/7jfhPYzezRQjXrigDrbfPOj+I7PRwgGAZlQ5cjK4T6z1AjdmtOyB8ayWDRcdUFRkWwz3UT4qh+xhArDAZGF4qjv+kZ9/wixPxgd6Di1l9JE0oOD0SqjjTdMkmY1NYm3gqkX8zMbwNM1pL70v1F4WNWzYeCGsho+DNf/3LwRA4GQXJZswp5a5DHPvb6zTTC0DvZA866zjxT6N5xauz3PQ1/Z6KZJ7nSd66UDtQdNG8ERug4KDqX/cizjko7uimnsDL0jJ8xk9OqIydxprh1IBK6/tbsOE534phqwAy31n36MRWJwd1QizrDSc+f9MYLHvtogm6NsEF9jW9IXf2kCWdOsOji9JnzEZAzUWklSBYObiAGGP7uCdu/7F7evRw0i0VDU22f175KOdbXuwwLhnkQtO+/tF9uwIugVdpbdSaOVHkoqWL+UYCp5sg5g6W9tie1cmBSO6APJY1hT2ZVVnUZz/yBZZL/b6UpUt8Ki7CjtWoIFDifV916wlp+lPj2HzG/7WNO/gDXV6ti3h3FEtDXHYTi4pmXbDbPuINi9uADyCNGIOorI7olv9BX0lqyQ8jyw2qeor87l4YJye2aE4cfKcxWLJIZnYJaAooT734d3iTq9qy5KEe2F1o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kjkt9MoLOOSgYey/ZrK0odXzIMR25G3y29pfg/7d+cOybILfH2UQcgBo2fS/?=
 =?us-ascii?Q?cVZmlUDOOOLLPSWCD1kmA7J46O4jFxFDxA9o2irbwrEiMmImnsuBjBZrvJ1H?=
 =?us-ascii?Q?ppus2F22LoVZBDWwXQ2+osU+RAiZlx9As+vYI90R/DZ6NiR2HRx2k/BTeo28?=
 =?us-ascii?Q?R//fvydu7Urd3/4nkWTapiEmTa68VMEOSq1NUtXUutntzymrZaG0J5mz50PQ?=
 =?us-ascii?Q?Xa4qFoVv9blgSevbLPkPV2eyvYQkLCob923ukgYQuhWGmuBp61heZvxopzQi?=
 =?us-ascii?Q?4YhUYiSwe/LoVvhephMnu9C2SX/fMdnP6dKIDCHFt8X+dtEkyivYi7Uab8tz?=
 =?us-ascii?Q?Hmn8nuwsGs60RZd0SMZ3S5T7W+5LP+/J7P+C3Ztv2oyhk0omB5baI/JAdxd/?=
 =?us-ascii?Q?sopAWzA25/E8wii9r7SnU929KxJp5TMSL2tp66WdSXYUqNWQmdMvQT7YvM0X?=
 =?us-ascii?Q?4IVOqcYS+jc5+vqsDGR0FZUCLt8iTNwDD2uMGAVh0bAVF+65yJkjR/k7CT+S?=
 =?us-ascii?Q?peRAZTK6G8A2Dy4uv+3pG2ty4n3pZ4sktdcjGHLQOpFwp3bUaq9+gAIKvoTb?=
 =?us-ascii?Q?Y7zQDUF5yl6g+gAnSExXHyADplmHIJeMJPqJtO/dTZNoWViTUakr+Uo8HKyt?=
 =?us-ascii?Q?KcEoTILoyEX5gM50vG4W/zeOOtz9sMJnLCkJFMXolveDQTLZRVi6RaDmsVVm?=
 =?us-ascii?Q?oWYIV31AhYlTQzQL5DMLiyTtH0bIiyJMBCq3ZnGdmf1025Wj0pphO5R7Suop?=
 =?us-ascii?Q?0vsrPoIihnrvmCMdXGXazZ4ng2mhDW101hN1SxyO0I3CydNqLBnuddlS6OsS?=
 =?us-ascii?Q?7B3XADJBHcA+mdLTQ8j9bwLXbw/SG0Iciqdfl7tpfULReZcbmjo87w/S0C3a?=
 =?us-ascii?Q?n7gLHNePXIV5YTryiohA1CQ54QUXCF6gxMyknVHmdYBcS20JykKM1ycthwXF?=
 =?us-ascii?Q?8RAk2+hABT6FwtLZTLBq6VWwHgZYaS8gaV8jctbW4kyQfO9jR9KJ8BMSkIjn?=
 =?us-ascii?Q?nd+MyIDv312mxgqyl3myvbMOWRpg7RNpDxdi9wPBKDZFKe+piz47e/hMoS8n?=
 =?us-ascii?Q?0l1EN2vnGe65Uw18YzKzNiuz+m68UNuuPOaR4V0KEocLZ4/sQoHwYd+tv8kY?=
 =?us-ascii?Q?DxKMUBcMbgUdrYwvZBg8xLuFscl8+Hh3SA0hluK8qpigpAGiQgfar9fnLks2?=
 =?us-ascii?Q?ztoHdlH4I7y2uGZ/w0xcjaAJuq7Td0sUuis5qL8B0lA4D19Hk5FQSbkBr2zG?=
 =?us-ascii?Q?rANZ26x9mMuiwifl3m7TDdC4JFaPcBJ24/LqTPIEYOR+1ynSROdhfrWljHdz?=
 =?us-ascii?Q?+z9YnlWwXTuUupfDlFH8LGY2vA4+JoCyzq2CEdKExhEoZ1eSd1SlbeMjGQUE?=
 =?us-ascii?Q?bKcQeK1XbONrNDoRzQiXAGTgEbsha/LJqpVSXzxhC/I+TRvLaiWxO/N+Nsiz?=
 =?us-ascii?Q?cTuei/AZoGPfeerI/168OpW/MhuNi0NF1oTsKcj56nDg69ya5EYUNGM+/N1b?=
 =?us-ascii?Q?3uUftPTKmB26pYDEOMJj8a67y2DtLfJlfiV/0mdsRC5E78pR3ccUzdhg58LG?=
 =?us-ascii?Q?OHNKx6yXcjvO//i3xXo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac98085e-faaf-4a12-b397-08dc5d5a52fa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 14:42:50.1611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmr3TJBIXF36z4N18M4/RuRprp6M8UH9rmhjDJ76wf1bpKVlUQWqpdgCoO4njhZzqQ+xxVRuj7J8jGSi3Zykgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7080

On Mon, Apr 15, 2024 at 05:11:35PM +0900, Yoshihiro Shimoda wrote:
> To avoid becoming struct pci_device_id pci_endpoint_test_tbl longer
> and longer, document a policy. For example, if PCIe endpoint controller
> can configure vendor id and/or product id, you can reuse one of
> existing entries to test.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> Cc: Frank Li <Frank.li@nxp.com>
> ---
>  drivers/misc/pci_endpoint_test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index c38a6083f0a7..727db13b6450 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -980,6 +980,7 @@ static const struct pci_endpoint_test_data j721e_data = {
>  	.irq_type = IRQ_TYPE_MSI,
>  };
>  
> +/* Do not add a new entry if the controller can use existing VID:PID combinations */
>  static const struct pci_device_id pci_endpoint_test_tbl[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x),
>  	  .driver_data = (kernel_ulong_t)&default_data,
> -- 
> 2.25.1
> 

