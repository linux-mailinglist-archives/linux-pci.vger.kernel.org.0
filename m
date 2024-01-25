Return-Path: <linux-pci+bounces-2552-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 873B183C6C7
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 16:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15EB91F215F0
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 15:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769F47317F;
	Thu, 25 Jan 2024 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C4WjfChq"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDDA6EB79;
	Thu, 25 Jan 2024 15:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706196812; cv=fail; b=tyjbJZ7oiCZGE7dvEzR4OY2e+c3BR+GQP5mGl5C6GNo90CvXZEb3MLFjBCD5BhLxatfiLR6iCC8ATFQf8rCgnWY8ZAT4got3OtaOed8wrbq9j88zmiIWjAAOdLY3lN8mWuPFyAaM5IJ6haSbECQMP0XUPGoUHBqwFMVwvzZ2eHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706196812; c=relaxed/simple;
	bh=NKw2hf6813Lh6ypUkSn8ss4G5gtuq+lT2TfrReZz3RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=En3qd9mmgc0gCSioyjZQPje64jAiY931ETTJzeqIqGD1Py42sx7GwnOThCBzzEe7umYtLWegXZopyIwItmo4LCbmcO81xnUSt7+8nXKmAZFqaWtoL1l24MNvRPEI1HzkbXLOG6ZOAOG0mfIrEFKGdNI1E7qxuj5eJitLB+aTXEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=C4WjfChq; arc=fail smtp.client-ip=40.107.21.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixTn0lrOx19pOvrlvmLLFOrygK0b3x4XDd+DZAN8L3LINS89GDq4Xsvs6e1KdBA4hBwYPVtaU1YjZIkTqaI2YOq+QrP3RrSXgbfgYmxLHduLS82fep842h3PVgZWAebr/VHHE4NOgbYcUrTMlA1AfcgtlwcHRGMoQ1NLXa5j2h24a2Q1wZQ0c4953Zz0TdebHyOIDbpUhhn2fPH8RUaqzXcnBl7zj0R+X01pBTxuXn6Vui6cbw8CsEViKK1TdR0j6VyUbVEzLsXnSkVQ9TJrwHxpmzrBZHjcc9p7l8XZjGuV3EDPPqLU7GMR1jDIzgZF01TKnzdt7HgGYTk5yikyRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8kwLYoOzd5mrJzXOjb67xEHQPGjNewcoIKUMcAwGNs=;
 b=Re4s966h927I7uGmlWaAdG+bB8rwOIz67kONkRtA+KpyoJgyDq0Vy14pFp+j9oQqLHMdZvfMKXHDloeFUb4DY+ltT+u3roovygqJQAExrstiXb60xtNz8mrB2Ss+/1Z/iPr1Nggjxln1GPh2/z+XZxY6Iyn59BPDgU6aifmGbntAGCSPX3oYuOJp4KVPypgbosrSdVbTftmNSkBXtdCPNpcWLKdHnvbWCX13iwCxZ1rinUCaXIjt6lfzSVXPhoAApkWMJdieR6oaiDoRq/ByrLg/H8P//McnKhmPg+129fasTCLK2orfgb6bfHuH9FikLoyNNAae8inHSemgNJ26BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8kwLYoOzd5mrJzXOjb67xEHQPGjNewcoIKUMcAwGNs=;
 b=C4WjfChqP4/6dbqubhUj4H3cldCjUBOOUUi91p/g46t6QmZk2DNsL6M5VzCsy6suc9QVJRDsdRauSBdeqVexMg4V1QL95uJdfWitZ0E/NUxtNEjjYcHV/TtAlGWAJC/iWzyxVZvJgyw66sgual8cBfGeoauxJf/G5NgvKGKJtiE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8539.eurprd04.prod.outlook.com (2603:10a6:20b:436::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 15:33:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Thu, 25 Jan 2024
 15:33:25 +0000
Date: Thu, 25 Jan 2024 10:33:19 -0500
From: Frank Li <Frank.li@nxp.com>
To: mani@kernel.org
Cc: allenbh@gmail.com, bhelgaas@google.com, dave.jiang@intel.com,
	imx@lists.linux.dev, jdmason@kudzu.us, kishon@kernel.org,
	kw@linux.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org,
	ntb@lists.linux.dev
Subject: Re: [PATCH v4 1/1] PCI: endpoint: pci-epf-vntb: Fix transfer failure
 for fixed size BARs
Message-ID: <ZbJ/P5ldcrSs16q8@lizhi-Precision-Tower-5810>
References: <20240108151015.2030469-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108151015.2030469-1-Frank.Li@nxp.com>
X-ClientProxiedBy: SN7PR04CA0175.namprd04.prod.outlook.com
 (2603:10b6:806:125::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: e6090660-df72-44e7-e640-08dc1dbaf8f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ew+IZXT/soWIaOPpC+V/1wQt63wI5vLKjGs3yznA5ceVUf7vmLudGM2+H1woMK+Qmo4+l9LDQml0XB/7PpRYGL6JAgjmi+lNJnHBqVZB72Y3x29v1uyQVUckJFuz69lRkwIdLiOHdVqL64UuvPIPCOKsVyrX85YbhxLXc/hQwXqp5OGv75G2MJhYLg6Lw8x7RVCN2WAqlmwCgL8xeI8mSetoUB749uQ8pDOX5v8KftHnQ0RGmdky64XiaqeWW1s9362g3IOSZ1ezrI/KLMeVLexy4gpUUhYMfcOuwDSpPMqG4I01K0fb7vNkXEP3LnFi7TMLQCTqDXIOjwX35LgZONzNKOEMMLN0j9uhsC/IMorY9i0l1im6X4tE2Vjhs2XmXPV5lQhH5Iea20/HEKRnjxt9NVZr0nHD1H4gfWLo3DWTIXbeKGpOfFru/OtRqF3em5iBJwzzeQvHuARnkzOHOqH9MRhqOIxNe3f01aW99t+Kq8vNJjms7RZNuxNHqfH7umIlQcHb7FnYrjdI7lxVT0cUFtyfyb69477p2yVAa0AUXr82HBj2t4lJhqtzgAUoqbC9Hys1NtBHEGtzcSOsWxnsC2UMrZlcnAdC6WHY72o0s4/W5wPTotJTQMKveBQs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(8936002)(4326008)(8676002)(2906002)(7416002)(5660300002)(66476007)(86362001)(66946007)(66556008)(6916009)(316002)(38350700005)(6486002)(38100700002)(52116002)(478600001)(6512007)(6506007)(9686003)(6666004)(83380400001)(26005)(41300700001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wS1Hj+hrTJkOvYM4Cdt2/A0SypLHcCLham7sFMXohCjsOGfwOgHXOxBma0nG?=
 =?us-ascii?Q?wpOSLmZ+dGmDoptCYT8mbxLLsraPZCnol01l8OqavsCr4zrx1lt5AKMRg+vm?=
 =?us-ascii?Q?hhCdLJXdRK6Y1eGow+a++k+p/doRranYD7iiwP1PmgIfGK/ViLgQONBw6QOR?=
 =?us-ascii?Q?ETIlO5qQTkNVJdYqkA+37tzIKuaJHcTCgrKQiyZE+wzdhx9IaBSy9QyfjFi8?=
 =?us-ascii?Q?AzaLh8iJm+tTQb46DqBPUxnoPr4EBSyN8Hvz9R9htWbq8VFm3NM3SnnkoZHF?=
 =?us-ascii?Q?4mEQSza+00jqMjbeO0psjDECwKwxaK41lSm0PVasVtrA67GVwOopu7ZwjCQo?=
 =?us-ascii?Q?0c5Epuae7iMKmi8QqaCTzEG1NlTlT/L9umWpHjU1ME4yUpLdViJBKJcUr+2N?=
 =?us-ascii?Q?8PXcAC0VPv0wUnKHGcEN/QaMCLPVA+XBqGBGQQ3VtQowSR0jl1yRkbB0efDG?=
 =?us-ascii?Q?zCak5jJff5vX21sT44tpMtLIvqwpwqfX8H8ENl0ucv5haWzIVd6o7JyyS3QV?=
 =?us-ascii?Q?AlvYO5rovbG3X9eKvDwEI3w/xl5wiUHDahbNJKrba4C5bqKfiBW4RNFg4zZq?=
 =?us-ascii?Q?qzrS8vCtnxCDM8Gypw2jtgVVE6+h7kguYLI/JpmjKfZLZrzZI/DT7AYj4bly?=
 =?us-ascii?Q?cfe/3+O8zaQjECWsBKLMZ/G0liE9AqwLElRHkMGnGghWjvle6ubzM2JLAqFn?=
 =?us-ascii?Q?PfsjiWU5B+rQah4/iQPqEunlANAVZRoQyX/wp33EUT291UsSxWwQp2sZr4Z+?=
 =?us-ascii?Q?UABgn9H7tek6KibfecM9VlCAcEoKvgU97HzHu8ifcWbYBx9gVPEFtuCmxIJk?=
 =?us-ascii?Q?p8t8Sbb7QiWcb2FdN3tutSMloL+U0EaiTh5wbRpIAHys2D2uNskCJDEJjxJX?=
 =?us-ascii?Q?QHa4h7AeTJwNNPoT+ahGEF0cPIm9jsEYYz1f+WPrRYzYvGrIP4ZN6ZTvGkug?=
 =?us-ascii?Q?1BQMMzwLp2cFPw7+dye/0RKsw0k4VXPKpt9N2PRctuql8PzDv3It02HlNDxo?=
 =?us-ascii?Q?Z+JQAPNGXUZengvKJZQ63SBDnnq0zhtEJ9R/WWqOsUGPrWBAwStk6P8dGcQA?=
 =?us-ascii?Q?7yA9kjz4T0sAKSSousx3cvHwF/MlJBH0WRhbnuEZy9kTeiafpBADsYeMnhjf?=
 =?us-ascii?Q?rFxj6GrlFOBCyb9H6vOL7z80YKmXpnLw43FPvpEHVsf7hPuyFbcRW0anv9pC?=
 =?us-ascii?Q?2th9tzPYxCQ2v+vqm6prWLXsO2LLcuZViyXXl33uG0P1Jz0WTt7tN65PsMpo?=
 =?us-ascii?Q?jf83Zh47Un3ralSNskLp255y0Jq2U7ONbumuebFExu30dLvrMNrqEtMpV2FI?=
 =?us-ascii?Q?5x7AKOJY1olJexxeiYrWxznG+7QQ24q2z9hXs0/nPWd+51EQO3x/PjsEZ9yy?=
 =?us-ascii?Q?L6GCf79sV8ieDwbi2zbf4XGssoPaeFMe544WNctcwEWWGfLog+VKcW9dqXLF?=
 =?us-ascii?Q?FRDAKKYJum2RXL/UiDiKf43pNuoF+NAEsYDgtOO6oKknZyNysBknrbPOiLZf?=
 =?us-ascii?Q?fvFD3SEj6DvPGvsdrCA2LJZc3BrAbDGLzlCfPvZ9ECmL52FwviE9/KBakSId?=
 =?us-ascii?Q?T/Qy0NlAQ+r3tTDF2+4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6090660-df72-44e7-e640-08dc1dbaf8f2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 15:33:25.9205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P8uyZ/ZBzYQIWotyBnr70ukMwi94KeQpyAeVO3ilp/t3LG0dYe2PzMPjD7PdBiG2IAmXGQonHn6pONnI7ps7jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8539

On Mon, Jan 08, 2024 at 10:10:15AM -0500, Frank Li wrote:
> For the inbound MEM/IO TLPs, iATU on the endpoint expects the target
> address to be aligned to the size of the BAR. For configurable BARs, there
> is no issue because both host and endpoint will know the exact size of the
> BAR region. But for fixed size BARs available in some controllers, if the
> BAR size advertised by the endpoint is not same as of the actual BAR size
> used in the controller, then the MEM/IO TLPs generated by the host will not
> be translated properly by the endpoint iATU.
> 
> So if the fixed size BARs are available in endpoint controllers, always use
> the actual BAR size.
> 
> This only fixes doorbell (DB) BAR. A similar fix is needed for memory map
> windows(MW) BARs.
> 
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> Cc: stable@vger.kernel.org
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

@lpieralisi:

	Could you please pick this fix patch?

Frank

> 
> Notes:
>     Change from v3 to v4
>     - add notes: fixing the issue only for DB BAR and a similar fix is needed
>     for other MW BARs
>     - Add Manivannan Sadhasivam's review tag
>     
>     Change from v2 to v3
>     - rework commti message
>     - add fixes and cc stable
>     - return -ENOMEN when request size > fix bar size
>     Change from v1 to v2
>     - Remove unnessary set align when fix_bar_size.
> 
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 3f60128560ed0..85120978fb8c9 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -550,6 +550,14 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
>  
>  	barno = ntb->epf_ntb_bar[BAR_DB];
>  
> +	if (epc_features->bar_fixed_size[barno]) {
> +		if (size > epc_features->bar_fixed_size[barno]) {
> +			dev_err(dev, "Fixed BAR%d is too small for doorbell\n", barno);
> +			return -ENOMEM;
> +		}
> +		size = epc_features->bar_fixed_size[barno];
> +	}
> +
>  	mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, align, 0);
>  	if (!mw_addr) {
>  		dev_err(dev, "Failed to allocate OB address\n");
> -- 
> 2.34.1
> 

