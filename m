Return-Path: <linux-pci+bounces-14558-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9D799F2CF
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 18:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5178A280D99
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 16:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4981D514F;
	Tue, 15 Oct 2024 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B+0UzjZ5"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2046.outbound.protection.outlook.com [40.107.105.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307A51F7084;
	Tue, 15 Oct 2024 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729010131; cv=fail; b=kdLlIUQOSSxkZ2wrt+nfXW6s3QMGZmVIkKdIm/XdVXZnJkgjzvaibr3tLJQbw2oR3aUjPbtCGJAzitBCoC5Erj0ij1VrE+EohDYlMWKWgfHFVrjlfGLhhrwC5+XAH1/P0EnHbgtWwXLjRC/4LZ8KhfRKfhvbtJikpQUaBpaGJ0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729010131; c=relaxed/simple;
	bh=AjS6ycOKBzJrxji7CGBLlfW9rP/vNksv9jhdTegd9L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kgZBuOQOlyBAExRIDAXSu4NrUvR963xOWIjkFI/ORZyDpx3nBIe57mq0Sl8Y9x9JsSwg0/G+bi0N7Og1Rwj+I+vYFc28b9vwB2YKvMr0wS6PnoQns1DibJOIVjnggO+te/sMsjuGJNYiWUyvlAe0hn13wktOY6hPJksdFW0Of9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B+0UzjZ5; arc=fail smtp.client-ip=40.107.105.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wormBQ4sTwCkwN2VJdiiMIYZKR1gPYSNPYApFAorJnaZnf6FgfpyHEPUWZ6DSekXaU5dwojf5LmEc6idf7q1WWZDtHNgZLK2ztW2AYWj5gt+3PmlQsAt4nizZnqI9UMHVrbLojS1BatMO12LBe6i0fxE7w4Aw2ap6xWDdxRH5wEbfKdsjXZxBcGMct0eZmV9BSkdsXAwTe9Wmxg4oesjXu9ptWK+dDJNn7qoARGMooh5j6wmN4IDlW94e/YAnWwKlGgX3EwTT7KkkHXNEVhh300DlDWTxms6txw1ze7r+ldxpqwdlWrQJUHwnjujUPehCukEaMJjxye6m1yXnq7y8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0Rh1zBDDNCROMNbPrkgwibb5vdY2gFpIQ1mG0fA78I=;
 b=ymRKSg80iu+A0W62w4ytPoSFDWt7ACRZT5poyUcPsaO+a93jII9EU51pP3CG88iIUAZtmwVpGA90t7UKzGBWyIPYgPG8GruoXoGOb1F0C0/Vo2OHkrht4Lc1zpKZ84bJ9awYkie3fPtBN0v9C8dr5jL+7Ypmhnw34u1tgeWOgdUVnezF9NU2csqbyD2q6UccGR8ei8do+HBJmBaKJQQnljPuozXcBTjESsAzTT5L0PH3cswtsQf4o90iWdtUf+oi9XeiBoW8/R1yzjrCT3dU8yjZWE3sfNdaC4cIS0xXhYSZbKpRWEQ4nlS57benACFM7mjF0XWRw4E/QoEwtWyvag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0Rh1zBDDNCROMNbPrkgwibb5vdY2gFpIQ1mG0fA78I=;
 b=B+0UzjZ5ILBishXHbF8R76A3nLhRQnONeqerNQZIXbGv4pp9qtSqeT9JaZZVb0b/3Rcg9wLF+jeAcPAQm+FrwroluKtSeMuI/cQxlvTWp/7PaiydJYfE+yVpQfe1lq57rpEvEj1yh7F9nn0Ao9jiPZjK1rHJ3gqav+xONa2/gmUQPWO/tT2DamuQqi+c+LW1oo0IGnfAlfbMR8AnmUDWeOCzP8pSRxACo0TxHNw/OZ+UWqruxev15V5smAz6EJ7bcfhikOFVZawnecqDXahMvyQMmyGr4lo4KylbJJ6eftehBX/X4b50BqBQZyPCwCN/4FReqpaddvfh3NAShCJ29g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB8059.eurprd04.prod.outlook.com (2603:10a6:10:1e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 16:35:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 16:35:23 +0000
Date: Tue, 15 Oct 2024 12:35:14 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com, xiaoning.wang@nxp.com,
	christophe.leroy@csgroup.eu, linux@armlinux.org.uk,
	bhelgaas@google.com, horms@kernel.org, imx@lists.linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 net-next 06/13] net: enetc: build enetc_pf_common.c as
 a separate module
Message-ID: <Zw6Zwn07it2MJwmD@lizhi-Precision-Tower-5810>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
 <20241015125841.1075560-7-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015125841.1075560-7-wei.fang@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:a03:331::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: 041c3e43-04c9-422d-d619-08dced375de9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TgYs7uEmF/MQA/rW2hFxgCdMbe710H+wnAnBL/cIA8aYvghjjFN80uHdnd96?=
 =?us-ascii?Q?Nws0yz+1uMJFKEoT3WFjzuBZTMvC2nX5Yx4ZQd9NoJk6LaKJaD4sJnaiH4/x?=
 =?us-ascii?Q?5p6guTxxRD1Uy8zykvVdupGN/RG/u7HeY5xZQatcuUnGdueLXAbeBhErO34q?=
 =?us-ascii?Q?7CM/9nlhaMIeboTURGd5Gqwd/M6oCQv59fKCXB+feH5Symixd0vh9A1K0+/e?=
 =?us-ascii?Q?C/PKEk+IV4ApPVK+WVvJ75y4EvsefwMpU+pYAZhsjuNtErATu0Mb+ks9T4yz?=
 =?us-ascii?Q?kxSlsEbuPgx/dO3EnxknsIExpr5tc+s5v0ST7mVbO+XMb3VON5VvuN8G5fPE?=
 =?us-ascii?Q?lq5LndyeOUWlAux7vZY//C6EnCzpTaLU0jvcr0JYtYEz+6mvYiXKfmeI2rxn?=
 =?us-ascii?Q?5rsQj1oBuP2K94Mc/sPUrsUKVqrI4pZVkTxL6x4u1plAKvul4o7wgiFVBCYT?=
 =?us-ascii?Q?SA0GsibTU/EwoJRr8nBiKGSJBBDsay123NPA/71YMek5/IHoPjlaAsdT3AIL?=
 =?us-ascii?Q?j3zf5sw4ZSwGYzZkk3LCpXEgHL390z4cZ4sOSMbFcklQ1cXKjVPctWLguHjq?=
 =?us-ascii?Q?5rWDJ/4bO20w0QGqMkuA9aSP+vrhFeCJt34wi7Qd//utHx7nd3bixKIeNO4/?=
 =?us-ascii?Q?/6KVTPreQxaYFdA8YSupXds1pXzTJEC/tDrOnFLaN28NHkW5nisDSP3wTPnZ?=
 =?us-ascii?Q?NupxVkCWokPX4bh77aXgMeV8K07ee20u17GrGw9R8MY2GYziWlXh2Bdk6pJS?=
 =?us-ascii?Q?YfuhEXVqHr8y0CUWJKRH/LvOVHCPQdmyfv1b8Mpmh6asT0Xa+Ip69mkRTxUc?=
 =?us-ascii?Q?0pB6D10j6sFlmSgckLCc76Tf9N5X7oKHIguMsPA5kE9xI09TpE1A8VEldo2p?=
 =?us-ascii?Q?/3+rnfwP/BKwTldaDkN8peYoRc7StiLODPmQFMILaCj52cXrccIwhiVIZqga?=
 =?us-ascii?Q?G3xwXu4441jZ5hNZWQHdVKE0naR4xiJU/ZWQrngq4Q64pWBWL7V0sU0cyW2z?=
 =?us-ascii?Q?gDHFYQEFdQHkYnQzSMN2REzovG4VzUoUSsFx4/w/+hDTNwgQTU8++leh8PmP?=
 =?us-ascii?Q?OLVCjBike4HnFminqk0qmzaBhnVP0RCVxyYJ4Ty4kVYgZYNW3mNGBq+JVqDF?=
 =?us-ascii?Q?DV69D27aNCNthMb2OzoebYRL7kMFCvVBWTlR/sNvR5qB09CizFR4IIglxwCe?=
 =?us-ascii?Q?ZzrlqHlU7V8t/wqD3WKJ7ns1ianU2pP2mElxs5dkZiTdjVm6+V6QZywtpE6J?=
 =?us-ascii?Q?whx0a8XUX9IBVafwBsv0veUFe3G+6oBEmilnvtzRI8WofPexl8gyQI8zYrbU?=
 =?us-ascii?Q?JO+xJYLBFpVpWDKuINxRcwo5lxeh29ISffNjGHw3LL6xmA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NI3g9BYEH5hlicYctVU0vGtQ9koFsLxKhczFk56OsY/nBuF3zgAJ5/PSmTuM?=
 =?us-ascii?Q?fJ3h1YlNh8KETDT0mwuSNS64LiMuKmx0xFHYLTXqXuZ7e42EspT2fnZCCim6?=
 =?us-ascii?Q?dOefQqprtfVJzbA1IEZvxpHheRK1dSuwo9Ht5pyAhxEJldqACQBp9RdPEv58?=
 =?us-ascii?Q?Vm1P1l0P0Nutzcp4kVzxygSESpvmO9IlPZiYAknRQ1i3PsgAwafq1pF2f6SB?=
 =?us-ascii?Q?dCVuANRUbfgkBxsFszNgKYKWfYIo7+NZe3L4/8ulgUXqbxGMKlgKo9RqUti+?=
 =?us-ascii?Q?wxIYvKHdtWJQcwaKyY66jBbCo9nE4LvTMxp9qXdGotYHtdshCifecFNjwv57?=
 =?us-ascii?Q?wD/VaFzCrFxiE78sLwMDcDreMb7tLfNhUFhvU8SGjP4k80q6N2GmxpbdTL+r?=
 =?us-ascii?Q?adHFm5XPb2fbwLjrcicUMRQg4l7IVuv2T72iPZ19vAtSWlMsKqb5f4xdkgy1?=
 =?us-ascii?Q?F9m023TJg035VRXj/vxRPfxk7mo73KPy07eDDRYTpVkivDIIGfkm7FT/SbNf?=
 =?us-ascii?Q?9DtjNt4mJ2rQ5vpMK9wUK58oHlYbAmtDfszzE2Nx8XN2+1rPeCubckc7Vi/q?=
 =?us-ascii?Q?+99qSbXZJdKvM7zGhZRcbWGlkJvodoFrb35gDEZUvLIBuIUlnHT4+cReij9C?=
 =?us-ascii?Q?etyoD5nIfddXNXhBY+L6bfwPJw8spWtEXO0BHqW/+dwesufkT9ZlkQMTCmtb?=
 =?us-ascii?Q?iap7DcmrkWZiYInnw93CUAFDXrLuE0SMbHE0XzIPxCzgjOpMJH7QmK2ocX9y?=
 =?us-ascii?Q?A26KFUGPoAgU+5RZLmUyVumbzsMMSYTbBh/wjQDQtKs5915e5PGEc0RM65OJ?=
 =?us-ascii?Q?B0YFzw2efOd3t4WXSITtX4vMt59ka5Z/liF9/lhrZAZYZMGu538LLrIZ1iZW?=
 =?us-ascii?Q?IBWdOHvzZKQx2qZx9bwuLuwi9KeBrHtXdFq3plhbFbUuqgJwoH5lwUnJn7EG?=
 =?us-ascii?Q?qO0M4FBU3KyEBnLZBXithJ2sgOPfUb8mhFeaEjR1fHWdDxOE+FI/t1/1Njkd?=
 =?us-ascii?Q?hK7mzRchTDl1Gpg5j+WjxpQzJ6Lt8wFuulUYzIaYTtRCGf5LgQ62JPPPQtT3?=
 =?us-ascii?Q?Rfjxf6HUHjcgk3Y0SzwmOU6nT1ZV3bq3dLuBJSHNDoujVe/NUTZ2UISKVeBo?=
 =?us-ascii?Q?q0bZ7Pc+ZHw7OehVTkbg2D9RthBB/Eromu/xkH3w5APDP0JgG6akdIPzx4SA?=
 =?us-ascii?Q?lSCocbmfI3tuo4C6sHdqbnVw6ZcV2MZ6/OiHc4vAdp8WjdzTeXag05InbZLM?=
 =?us-ascii?Q?ext0dVKUz2l44/DlfsOq37dvrV3C7Gse9G222vwrN7D8qJ6OgIH37+l6skPG?=
 =?us-ascii?Q?Qs4w5JnRsav5xljyTIRTpc5ysRhYuN83oTIU6bSO+XDRfmvVZzIf3r85eBTn?=
 =?us-ascii?Q?qFM0atdQtWmxla3K9v2hA5p+dqYaoSb8xlei3E5qq3U01cQmGhUn46J+pwGT?=
 =?us-ascii?Q?dcjgRdLIjObu87Xqw6akv5fqYE0vH+1wdLsjih+NyubjT7Lw9oKgVauj0QMb?=
 =?us-ascii?Q?xapjZGBFmuJFLpjCZmEoC9EmKwKUQCpuGk2GRBXFUefwdWzIixbHCQEvrGqW?=
 =?us-ascii?Q?jARc3udkbq/GidEy4hum4aV1X907SIxEqIjqN0p9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 041c3e43-04c9-422d-d619-08dced375de9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 16:35:23.5407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zunlDFVGd1PE7qgMDTtXSDg47OdKn5O8XbDVR+rBLCC+H1snfqfkBU2WkYXceKB+4obhf4heuzgTa0TOl1QgdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8059

On Tue, Oct 15, 2024 at 08:58:34PM +0800, Wei Fang wrote:
> enetc_pf_common.c provides the common interfaces for the PF drivers of
> ENETC v1 and v4. So it's better to make enetc_pf_common.c as a separate
> module in order to prepare to add support for ENETC v4 PF driver in
> subsequent patches.
>
> Because the ENETC of the two versions is different, so some hardware
> operations involved in these common interfaces will also be different,
> Therefore, struct enetc_pf_ops is added to register different hardware
> operation interfaces for both ENETC v1 and v4 PF drivers.
>

Is it little better

Compile enetc_pf_common.c as a standalone module to allow shared usage
between ENETC v1 and v4 PF drivers. Add struct enetc_pf_ops to register
different hardware operation interfaces for both ENETC v1 and v4 PF
drivers.

look like this patch only add v1 ops?

> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v2 changes:
> This patch is separated from v1 patch 5 ("net: enetc: add enetc-pf-common
> driver support"), only the changes to compile enetc_pf_common.c into a
> separated driver are kept.
> ---
>  drivers/net/ethernet/freescale/enetc/Kconfig  |  9 ++++
>  drivers/net/ethernet/freescale/enetc/Makefile |  5 +-
>  .../net/ethernet/freescale/enetc/enetc_pf.c   | 26 ++++++++--
>  .../net/ethernet/freescale/enetc/enetc_pf.h   | 21 ++++++--
>  .../freescale/enetc/enetc_pf_common.c         | 50 ++++++++++++++++---
>  5 files changed, 96 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
> index 51d80ea959d4..fdd3ecbd1dbf 100644
> --- a/drivers/net/ethernet/freescale/enetc/Kconfig
> +++ b/drivers/net/ethernet/freescale/enetc/Kconfig
> @@ -7,6 +7,14 @@ config FSL_ENETC_CORE
>
>  	  If compiled as module (M), the module name is fsl-enetc-core.
>
> +config NXP_ENETC_PF_COMMON
> +	tristate "ENETC PF common functionality driver"
> +	help
> +	  This module supports common functionality between drivers of
> +	  different versions of NXP ENETC PF controllers.
> +
> +	  If compiled as module (M), the module name is nxp-enetc-pf-common.
> +
>  config FSL_ENETC
>  	tristate "ENETC PF driver"
>  	depends on PCI_MSI
> @@ -14,6 +22,7 @@ config FSL_ENETC
>  	select FSL_ENETC_CORE
>  	select FSL_ENETC_IERB
>  	select FSL_ENETC_MDIO
> +	select NXP_ENETC_PF_COMMON
>  	select PHYLINK
>  	select PCS_LYNX
>  	select DIMLIB
> diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
> index 39675e9ff39d..b81ca462e358 100644
> --- a/drivers/net/ethernet/freescale/enetc/Makefile
> +++ b/drivers/net/ethernet/freescale/enetc/Makefile
> @@ -3,8 +3,11 @@
>  obj-$(CONFIG_FSL_ENETC_CORE) += fsl-enetc-core.o
>  fsl-enetc-core-y := enetc.o enetc_cbdr.o enetc_ethtool.o
>
> +obj-$(CONFIG_NXP_ENETC_PF_COMMON) += nxp-enetc-pf-common.o
> +nxp-enetc-pf-common-y := enetc_pf_common.o
> +
>  obj-$(CONFIG_FSL_ENETC) += fsl-enetc.o
> -fsl-enetc-y := enetc_pf.o enetc_pf_common.o
> +fsl-enetc-y := enetc_pf.o
>  fsl-enetc-$(CONFIG_PCI_IOV) += enetc_msg.o
>  fsl-enetc-$(CONFIG_FSL_ENETC_QOS) += enetc_qos.o
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> index 3cdd149056f9..7522316ddfea 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> @@ -11,7 +11,7 @@
>
>  #define ENETC_DRV_NAME_STR "ENETC PF driver"
>
> -void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
> +static void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)

Previous patch you remove static, this patch you add back. Is it neccessary
at prevous patch to remove static?

-static void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
+void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)

>  {
>  	u32 upper = __raw_readl(hw->port + ENETC_PSIPMAR0(si));
>  	u16 lower = __raw_readw(hw->port + ENETC_PSIPMAR1(si));
> @@ -20,8 +20,8 @@ void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
>  	put_unaligned_le16(lower, addr + 4);
>  }
>
> -void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
> -				   const u8 *addr)
> +static void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
> +					  const u8 *addr)
>  {
>  	u32 upper = get_unaligned_le32(addr);
>  	u16 lower = get_unaligned_le16(addr + 4);
> @@ -30,6 +30,17 @@ void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
>  	__raw_writew(lower, hw->port + ENETC_PSIPMAR1(si));
>  }
>
> +static struct phylink_pcs *enetc_pf_create_pcs(struct enetc_pf *pf,
> +					       struct mii_bus *bus)
> +{
> +	return lynx_pcs_create_mdiodev(bus, 0);
> +}
> +
> +static void enetc_pf_destroy_pcs(struct phylink_pcs *pcs)
> +{
> +	lynx_pcs_destroy(pcs);
> +}
> +
>  static void enetc_set_vlan_promisc(struct enetc_hw *hw, char si_map)
>  {
>  	u32 val = enetc_port_rd(hw, ENETC_PSIPVMR);
> @@ -970,6 +981,14 @@ static void enetc_psi_destroy(struct pci_dev *pdev)
>  	enetc_pci_remove(pdev);
>  }
>
> +static const struct enetc_pf_ops enetc_pf_ops = {
> +	.set_si_primary_mac = enetc_pf_set_primary_mac_addr,
> +	.get_si_primary_mac = enetc_pf_get_primary_mac_addr,
> +	.create_pcs = enetc_pf_create_pcs,
> +	.destroy_pcs = enetc_pf_destroy_pcs,
> +	.enable_psfp = enetc_psfp_enable,
> +};
> +
>  static int enetc_pf_probe(struct pci_dev *pdev,
>  			  const struct pci_device_id *ent)
>  {
> @@ -997,6 +1016,7 @@ static int enetc_pf_probe(struct pci_dev *pdev,
>  	pf = enetc_si_priv(si);
>  	pf->si = si;
>  	pf->total_vfs = pci_sriov_get_totalvfs(pdev);
> +	enetc_pf_ops_register(pf, &enetc_pf_ops);
>
>  	err = enetc_setup_mac_addresses(node, pf);
>  	if (err)
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> index 92a26b09cf57..39db9d5c2e50 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> @@ -28,6 +28,16 @@ struct enetc_vf_state {
>  	enum enetc_vf_flags flags;
>  };
>
> +struct enetc_pf;
> +
> +struct enetc_pf_ops {
> +	void (*set_si_primary_mac)(struct enetc_hw *hw, int si, const u8 *addr);
> +	void (*get_si_primary_mac)(struct enetc_hw *hw, int si, u8 *addr);
> +	struct phylink_pcs *(*create_pcs)(struct enetc_pf *pf, struct mii_bus *bus);
> +	void (*destroy_pcs)(struct phylink_pcs *pcs);
> +	int (*enable_psfp)(struct enetc_ndev_priv *priv);
> +};
> +
>  struct enetc_pf {
>  	struct enetc_si *si;
>  	int num_vfs; /* number of active VFs, after sriov_init */
> @@ -50,6 +60,8 @@ struct enetc_pf {
>
>  	phy_interface_t if_mode;
>  	struct phylink_config phylink_config;
> +
> +	const struct enetc_pf_ops *ops;
>  };
>
>  #define phylink_to_enetc_pf(config) \
> @@ -59,9 +71,6 @@ int enetc_msg_psi_init(struct enetc_pf *pf);
>  void enetc_msg_psi_free(struct enetc_pf *pf);
>  void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int mbox_id, u16 *status);
>
> -void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr);
> -void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
> -				   const u8 *addr);
>  int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr);
>  int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf);
>  void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
> @@ -71,3 +80,9 @@ void enetc_mdiobus_destroy(struct enetc_pf *pf);
>  int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
>  			 const struct phylink_mac_ops *ops);
>  void enetc_phylink_destroy(struct enetc_ndev_priv *priv);
> +
> +static inline void enetc_pf_ops_register(struct enetc_pf *pf,
> +					 const struct enetc_pf_ops *ops)
> +{
> +	pf->ops = ops;
> +}
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> index be6aec19b1f3..2c6ce887f583 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> @@ -7,19 +7,37 @@
>
>  #include "enetc_pf.h"
>
> +static int enetc_set_si_hw_addr(struct enetc_pf *pf, int si, u8 *mac_addr)
> +{
> +	struct enetc_hw *hw = &pf->si->hw;
> +
> +	if (pf->ops->set_si_primary_mac)
> +		pf->ops->set_si_primary_mac(hw, si, mac_addr);
> +	else
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
> +
>  int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr)
>  {
>  	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> +	struct enetc_pf *pf = enetc_si_priv(priv->si);
>  	struct sockaddr *saddr = addr;
> +	int err;
>
>  	if (!is_valid_ether_addr(saddr->sa_data))
>  		return -EADDRNOTAVAIL;
>
> +	err = enetc_set_si_hw_addr(pf, 0, saddr->sa_data);
> +	if (err)
> +		return err;
> +
>  	eth_hw_addr_set(ndev, saddr->sa_data);
> -	enetc_pf_set_primary_mac_addr(&priv->si->hw, 0, saddr->sa_data);
>
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(enetc_pf_set_mac_addr);
>
>  static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
>  				   int si)
> @@ -37,8 +55,8 @@ static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
>  	}
>
>  	/* (2) bootloader supplied MAC address */
> -	if (is_zero_ether_addr(mac_addr))
> -		enetc_pf_get_primary_mac_addr(hw, si, mac_addr);
> +	if (is_zero_ether_addr(mac_addr) && pf->ops->get_si_primary_mac)
> +		pf->ops->get_si_primary_mac(hw, si, mac_addr);
>
>  	/* (3) choose a random one */
>  	if (is_zero_ether_addr(mac_addr)) {
> @@ -47,7 +65,9 @@ static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
>  			 si, mac_addr);
>  	}
>
> -	enetc_pf_set_primary_mac_addr(hw, si, mac_addr);
> +	err = enetc_set_si_hw_addr(pf, si, mac_addr);
> +	if (err)
> +		return err;
>
>  	return 0;
>  }
> @@ -69,11 +89,13 @@ int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf)
>
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(enetc_setup_mac_addresses);
>
>  void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
>  			   const struct net_device_ops *ndev_ops)
>  {
>  	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> +	struct enetc_pf *pf = enetc_si_priv(si);
>
>  	SET_NETDEV_DEV(ndev, &si->pdev->dev);
>  	priv->ndev = ndev;
> @@ -106,7 +128,8 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
>  			     NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
>  			     NETDEV_XDP_ACT_NDO_XMIT_SG;
>
> -	if (si->hw_features & ENETC_SI_F_PSFP && !enetc_psfp_enable(priv)) {
> +	if (si->hw_features & ENETC_SI_F_PSFP && pf->ops->enable_psfp &&
> +	    !pf->ops->enable_psfp(priv)) {
>  		priv->active_offloads |= ENETC_F_QCI;
>  		ndev->features |= NETIF_F_HW_TC;
>  		ndev->hw_features |= NETIF_F_HW_TC;
> @@ -115,6 +138,7 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
>  	/* pick up primary MAC address from SI */
>  	enetc_load_primary_mac_addr(&si->hw, ndev);
>  }
> +EXPORT_SYMBOL_GPL(enetc_pf_netdev_setup);
>
>  static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *np)
>  {
> @@ -161,6 +185,9 @@ static int enetc_imdio_create(struct enetc_pf *pf)
>  	struct mii_bus *bus;
>  	int err;
>
> +	if (!pf->ops->create_pcs)
> +		return -EOPNOTSUPP;
> +
>  	bus = mdiobus_alloc_size(sizeof(*mdio_priv));
>  	if (!bus)
>  		return -ENOMEM;
> @@ -183,7 +210,7 @@ static int enetc_imdio_create(struct enetc_pf *pf)
>  		goto free_mdio_bus;
>  	}
>
> -	phylink_pcs = lynx_pcs_create_mdiodev(bus, 0);
> +	phylink_pcs = pf->ops->create_pcs(pf, bus);
>  	if (IS_ERR(phylink_pcs)) {
>  		err = PTR_ERR(phylink_pcs);
>  		dev_err(dev, "cannot create lynx pcs (%d)\n", err);
> @@ -204,8 +231,8 @@ static int enetc_imdio_create(struct enetc_pf *pf)
>
>  static void enetc_imdio_remove(struct enetc_pf *pf)
>  {
> -	if (pf->pcs)
> -		lynx_pcs_destroy(pf->pcs);
> +	if (pf->pcs && pf->ops->destroy_pcs)
> +		pf->ops->destroy_pcs(pf->pcs);
>
>  	if (pf->imdio) {
>  		mdiobus_unregister(pf->imdio);
> @@ -245,12 +272,14 @@ int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node)
>
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(enetc_mdiobus_create);
>
>  void enetc_mdiobus_destroy(struct enetc_pf *pf)
>  {
>  	enetc_mdio_remove(pf);
>  	enetc_imdio_remove(pf);
>  }
> +EXPORT_SYMBOL_GPL(enetc_mdiobus_destroy);
>
>  int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
>  			 const struct phylink_mac_ops *ops)
> @@ -287,8 +316,13 @@ int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
>
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(enetc_phylink_create);
>
>  void enetc_phylink_destroy(struct enetc_ndev_priv *priv)
>  {
>  	phylink_destroy(priv->phylink);
>  }
> +EXPORT_SYMBOL_GPL(enetc_phylink_destroy);
> +
> +MODULE_DESCRIPTION("NXP ENETC PF common functionality driver");
> +MODULE_LICENSE("Dual BSD/GPL");
> --
> 2.34.1
>

