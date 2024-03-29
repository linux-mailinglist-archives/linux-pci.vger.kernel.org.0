Return-Path: <linux-pci+bounces-5419-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCD689208E
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 16:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF0301F2967F
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 15:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546D017E;
	Fri, 29 Mar 2024 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s7ZPEg6Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2112.outbound.protection.outlook.com [40.107.104.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47815386
	for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711726609; cv=fail; b=nuO3r/aZ92FEklnqCcS9Tv1UokQ+A97XYxC8umNCuuq7Umo2BDYBgb4oNIW7yzeUjZuIbB3gLUWog6WBvPfeLfi2l6O73o7gk8XhHXrNUEGhy+n3Pkj3Q2Xq3pggXWf4SaiPrndypcSyLOgiwefaoEqc56zgV4WglnBrAvISWjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711726609; c=relaxed/simple;
	bh=JFNFKrxNGefakeSQLP05HPMpwiL8oJamTFPndPoY0gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oQ8V+M1pFsDhjGZujOA5wE5vcsgGSew7X/TLOXveuhT+6rc8hpTiN94jJCC0v5ykpWFfmpnPuYg3V+lb4yj/EnP01o+gowO3RJ2jNyPHFeZ1TefyhZ3135xTu/dmbda0mdKY1ky1RystQ93U0Zc4GxbQiyBVJRUf1ErinJ6mDN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=s7ZPEg6Z; arc=fail smtp.client-ip=40.107.104.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3T0/AHaSCGDFDRgfjyjob449/f5jFcuzh9Dncmvsia/tsjE3mv0Zk83f7y5M2K/DiAGj4yRaAxuu/8axYLw0jo3Rj2YCvvg2N6cJa25p7O5QayQChjxKt94Fvdf/1dQ0PZXpG3WvFHon9M2keV4+ehWJwA0Nmj6jk5s+49ckul92qgite+kRwUu8cBSgttLaVpMtBVUmz5pJ7/QigWEcDJMxT2/2QffQTWanhdiucpGk7SEMKf33dDC/ypvifkSpEQAJ25QwBX0ec85ajqDt90gwYtGnmfzCgL2YwQKJ2+1S5wSW74wWY0R3fNyhyhHoj59b4mDE/MjoG1zvLn05A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7B1XRDDNJXIRMVzXrPwXdunOrpKPbd1T31hQg3+0+/Y=;
 b=EG0OqeJZeK9DjOWR9GuHbhJEYvvALVNEdY2RJOSdpJ75ncE2oOU6IHa/rBJNo183tkSU0ncDt6+tUoqO6buz5FkJJo+ZCwJ8Vv038IqJr5KcCdPlTDq7Ud3aO2noyrXYeR3Kwax3nbgPjtFXNw3B0BJ9YCWMtm4WhCoQHvEMrnoPIO8p5uy2iswitnRnME9gbiXv7zYBE30Y9Kw8f7432G9m5CALHI+1liKlyqCE6T0gX0xvWQhbwdpRBUtVWJNqBNy1ef6qJv23rDmxNWYroNr1vf+qhwXN+9JRYCUEZ5SiR7DxQxYRFtTymjJoZ194FSngWXZ/5sNfFjVrQ7m3hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7B1XRDDNJXIRMVzXrPwXdunOrpKPbd1T31hQg3+0+/Y=;
 b=s7ZPEg6Zp5d3Yir9WUubo8rha4hxn5JZN3+GxfeAGBM3InmwGvTVJpaPvu7x5/QMeNzMyOyfRHeh7pwq17CfUVK8HoJdaHjEf4DV3nfYca+dqMKh5C9NC2DSZkTOQ6QD4ZPmIDWrXqhWcdfq1yjWccaMDi/6EZ42Ub50KEof3iQ=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB8059.eurprd04.prod.outlook.com (2603:10a6:10:1e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Fri, 29 Mar
 2024 15:36:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 15:36:44 +0000
Date: Fri, 29 Mar 2024 11:36:38 -0400
From: Frank Li <Frank.li@nxp.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 06/19] PCI: endpoint: test: Synchronously cancel command
 handler work
Message-ID: <ZgbgBizknMIza+bZ@lizhi-Precision-Tower-5810>
References: <20240329090945.1097609-1-dlemoal@kernel.org>
 <20240329090945.1097609-7-dlemoal@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329090945.1097609-7-dlemoal@kernel.org>
X-ClientProxiedBy: SJ0P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB8059:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O3bx0MkIU8y5SzhaxEgYgE+UW98o4ahqoLdfy9IPLWoR1u3A46S6bnW/cSYjQFgyFj1qsMEbao/oy3qp2h67lSaqc7/8ZtJz9woCY86lvf7zZFweecWssHxTaBze3mIbdl9FM3lE6b/sXZ1IIryhPqaULkeZFWjLhmJ6HAKQkiO/rcjc9zrxqE5zwk+Weop/d/rWK1CzJNbsekgsOf9qFyTU1jITpCFnoesY0aOWepw/kZR02K0/e7uG1WbS/onBfQPXBoq+rId/0kvwXK254Wkg3QGy1cwahD2ngO0ftRbl6hL+sfxqOHrnn0XQzYbCV9JgS0aQx95+8k/YfchjPeEZF1aE6KRhMLH7vh5tjgqqWZ7uvL+DT1oM50g9fYu+fT4LFjD8HhC4vIE+CwFIWY6YuoQsH/v5DBFynEfj4Op5qZ0xbp415zM0bVmWN1SE2/TmfwR2bnHTpaRG9bAeEORCJ7jevOG8i0NUV32G/44cy0HzfxoBxznVHjZLiIvkPHOFLOmsvjv8XB0WfEXwdG6ID/lrr7y96S54Yj7KIoXCfl+5lt9OxAUH6ekmNFnDt5xDGiCXxVUNKnghpjdsLkIvKw/X5vSaFvikCj607ZBdGj3uQfCUf3bS7PVgSiocJhIgFrwuKtJG7tZrjI2YKoMnhScW8VxwZBvHPcRVBQ7+uVARLD+CQmfFTsv+yPsQaEk1kI69fIgcqxpPHJKOuCR0xSp/Z5Z8nLuU3mLGn04=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZE1J6l5xeQWT12H5rTc2Bdiy9eBPKuXMOtvB5OxBg09EFr/ctEokLWzUGtEr?=
 =?us-ascii?Q?DPnIfuWErKlapcctJFSJem50StmIqN3bzBGG5AjFzemmDJEH7pUmLjMk4l6B?=
 =?us-ascii?Q?88SKXFZGtVfhip9AHtrNzaAzHnhYTTV83Ibr6k7CJ7v4WQ1yJzAi1YbVbv2m?=
 =?us-ascii?Q?JZjQOjRfqUnASp6wvD3HjSgkWYuAWYJpOIPMx5hw85E8ScFLijnJP1JKc0FU?=
 =?us-ascii?Q?hTwJ+tWTpjkarC/jdBR5aRDunvLoF9LT52ErtL5jVqdargUwggiUsuf+cFsP?=
 =?us-ascii?Q?1rm/DCfq60Eb0YVve0m8zkvg67fAbIJRwH3WPM1RiNkNI1PRPBhI3qEmRUvo?=
 =?us-ascii?Q?80aMdInypJAIIz4k4TnwCeoC6WAS7PH4dFwrWuILOyQqaDtIX8cpcChLiphH?=
 =?us-ascii?Q?E5RlUOP4Wrtr6Ab3HGtfEKiGXkVFyOQfEPVmJP2IKAlQ3PLDd00bBZls7uu4?=
 =?us-ascii?Q?Nh+6wLNrt0DBA+mzJK/oYB3FoiCVgm4rXOzin/2hky5y60RYZyXsk3dLV66y?=
 =?us-ascii?Q?l9N/+Y9U+of2C8tWlraQrjTx0MGLgD5/7krfOA8A5vKI/XCzPW2O6Zfm/yQ3?=
 =?us-ascii?Q?p9ied+snrTV1TZJNQ3Opv93rWZUERji928+DnNmFC36S+UOmK0NwdzxMhHiT?=
 =?us-ascii?Q?OI/aQETyZspiyR0NeHDUVj21WRsIwgJ/KgoiqN7rOqjHb4tQ14boVrl/DWRk?=
 =?us-ascii?Q?/y8czx6R1wIXXBd+3OVtGt+R+bNyagj1o9leWErzA0iPq5J6ILwpYKvOvr15?=
 =?us-ascii?Q?XNu0XrmA7dQ/1R9z09tmoUFA7IDX/MWT6ksh6DGzeV4VImEFBOxErgVmNFEA?=
 =?us-ascii?Q?Vk4yn7lBDuDmSxHdWiJGml0QDF224aUpQMnET+349d/k08Q4zv3zU3adTjQD?=
 =?us-ascii?Q?RdFx9JIXWSms3d4n0p1N8AQgnQRAHAlCmHvpE6Cm1zU8zaYNO+/jVSh2PDLG?=
 =?us-ascii?Q?iTGnRIgk4oytxdKL+eQ0iMXDyplNWsGa7wbOJm/n8xeNbUJbyrAjRbKt3UUn?=
 =?us-ascii?Q?a9b2Te8IM6147WRcFWhFK5FeJnuNeuHWipKJVTDj8tDz1Ns3SXeDvBfmZ2xR?=
 =?us-ascii?Q?69SDXZixn+60vlSE0g7ct9sS11JHN8k7+FnDx9mt1eElgb5QBV5l4gfAe39w?=
 =?us-ascii?Q?BgPE+y6qePzI2xdv83HoPUHs3BkOdcO8CQbQGH36UhtqkWkiZjzRyN25V7v+?=
 =?us-ascii?Q?KebAZhnai3oU+2rRSfD7O7P4RUNzJPswm6+NcaUcE7aZWpFvwZIcOdn5zhw1?=
 =?us-ascii?Q?9gK0oXz0rbv0Susp4SrDsJ3UbEM/Oito/x28SPy9TVa0Z6to8r0JWNb2Hd2s?=
 =?us-ascii?Q?2jAWIzF4Bw+4IjmZLMHqXHd5Nu4MunhvVNv7rwN2RaQtQKvIGf52RSBQIv/D?=
 =?us-ascii?Q?qrG+WeD2PH9W0uUc/HCJrMiUg7bdko7Bb4TuX1frGiS8gx7pnp6/R0TvpSZV?=
 =?us-ascii?Q?TsiR0NI8jotzCyGH19AyI2MEuNhq9rdx+Cj8CEk3r4K9lwJ2JbLTfKhe7J1S?=
 =?us-ascii?Q?UM4lGyN+GeGvFYJTASf76EhIOqsc0d/dxmoWZm6Y9BUabIgQMyGTiVIo7xKn?=
 =?us-ascii?Q?RtpuKuHYMLqXsxOLTkipAlrOi+ixRO9bSOb92O6Z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c50652d8-8911-43c9-5a00-08dc500609eb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 15:36:44.9050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hb4JW6CQj+IF1ck9cZMDoKDh2FPto+baghakKVhhdgJs+gd0eqFUqrNLYEwbKbTZYOULuPjrWaK0lBLkjMhE3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8059

On Fri, Mar 29, 2024 at 06:09:32PM +0900, Damien Le Moal wrote:
> In pci_epf_test_unbind(), replace the call to cancel_delayed_work() to
> cancel the command handler delayed work with the synchronous version
> cancel_delayed_work_sync(). This ensure that the command handler is
> really stopped when proceeding with dma and bar cleanup.

How about simple said

"Replace cancel_delayed_work() with cancel_delayed_work_sync() in
pci_epf_test_unbind() to ensure that the command handler is really stopped
when proceeding with dma and bar cleanup."

> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 0e285e539538..ab40c3182677 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -709,7 +709,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
>  	struct pci_epf_bar *epf_bar;
>  	int bar;
>  
> -	cancel_delayed_work(&epf_test->cmd_handler);
> +	cancel_delayed_work_sync(&epf_test->cmd_handler);
>  	pci_epf_test_clean_dma_chan(epf_test);
>  	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
>  		epf_bar = &epf->bar[bar];
> -- 
> 2.44.0
> 

