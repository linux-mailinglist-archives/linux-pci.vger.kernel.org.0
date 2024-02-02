Return-Path: <linux-pci+bounces-3019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F9F847111
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 14:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158F128BFA3
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 13:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739C94643A;
	Fri,  2 Feb 2024 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N2IjOBvh"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE43E210E8;
	Fri,  2 Feb 2024 13:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880373; cv=fail; b=OK+s7JJCGM3F2L1X6/1f5dce56yn7t36oIa7B/64+EdSKl7bdB2Mds0DGLuFCg5FErm3aJzR6qNt/zw/DCULVMrAxL2rG5hSheoJKn6KReBwUK8P2ixlm4wTV9iLAVY4hqJoTnx6Xa36jicFRe5sAqGnVeaXqyjGOJtDghdmLW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880373; c=relaxed/simple;
	bh=fEx5tH8/QI8SJbM2wYTD3nRXjMkKzUs9JETjEgGzHbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uTZzPCxlsZlf/qp9fqFZWVB/veM97p1giJ44C76XlxunGE61wikoDRaSi/eoCvSlz8V7X0dN0bq9YHtOTrc8holNS9f2V0qJEWTixlTrVDk0znaPXcKQuuMfZhBCSTbtHGXOdu6HH3TvgOxzqLqWj+6MX7zIs1oZ25Zn99D8lSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=N2IjOBvh; arc=fail smtp.client-ip=40.107.20.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4PSAhXE809OdL2JP29M5uix7/8JIDqqzr4RX5vktUJO6ZmAUaALT8Rh9BhMVIg293NIoCMVwixedKk9fZyhuhF/GRueQaEp2KRrieEZoi7fPNlBDkDo02eBg4+wSYWejsnye5zNcBcyu32wykBAY3IJ6pYu8CI8dtYxzVNZSyh7Xp4Txs1ki+hPkoXgRsmBfAMgDebzriEvHtf3+nYrHIlsNEVwie+Y5278kPahZs/9jrF8omrdJsLidb79jIV1/1fxcPz3cmp2Aw1Bpr1S2EWv2FBi3vxW71nk+uFLg/jKQTeMqjOsGdMq22uVjw0JGPquXzqojV2Oty2JlIHwYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7pi4B2NFJkLtnOevrmp6XYBuI2k2+MwNGP65iSofQA=;
 b=nZ2q/RGUhtd6Y742ssIJReb/nOYUiSYKok4FklhDslufKe8mrBUei6u6iYi+AsoNggIxYF7aCR3DCqvHmrAzk5w/tzQnebsPpBydiexeSBugrnNA3ZexDQSzvWGdC/TNgbGt+A37mGRjAfYIwlFh3Rkib+rEcuFt/vOr2wrp5+wE/aM82W+kSMbY4Roe5OtYPasZGaxtMBaXG5apl7qPZKZN5FrebZ48G8xxiM8MBBbJeKbOuvs0ybIjSHceYssKsgg0/j6WemnGOW9ffzlRAPXPXBXgdOnzOajZ8I9j1MyahkGyzzMF31IKDO0dXjvjNmZPhawpFgg+e7YSnTneLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7pi4B2NFJkLtnOevrmp6XYBuI2k2+MwNGP65iSofQA=;
 b=N2IjOBvhSULX1eOPYDQr5YqfwGoJIdcBSczwyKaSXPPhMzrBvj5AASyX/dga0VEzbdmUHtf8diAvgW285Vde5DgaxGGcrPn084lrbkziIbEwjv/laXRDoEvdV7mMz4vsyhCZk3wjBxgA7Ygi3CSpSmlcQ8aICpmCE9PHTSU29Us=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9706.eurprd04.prod.outlook.com (2603:10a6:102:24c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 13:26:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 13:26:08 +0000
Date: Fri, 2 Feb 2024 08:25:58 -0500
From: Frank Li <Frank.li@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
	helgaas@kernel.org, hongxing.zhu@nxp.com, imx@lists.linux.dev,
	kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org, kw@linux.com,
	l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, robh@kernel.org, s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: Re: [PATCH v9 05/16] PCI: imx6: Using "linux,pci-domain" as slot ID
Message-ID: <ZbztZkNQ+wydticD@lizhi-Precision-Tower-5810>
References: <20240119171122.3057511-1-Frank.Li@nxp.com>
 <20240119171122.3057511-6-Frank.Li@nxp.com>
 <ZbzcOarorCS1MPRc@lpieralisi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbzcOarorCS1MPRc@lpieralisi>
X-ClientProxiedBy: SJ0PR03CA0198.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9706:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e74bfc1-7cb3-4444-06e2-08dc23f28397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QnpyA8AusP/n1RCwBfhUrL8oyf+9AhEBBeEu8zH61kJF6Vdr4R6/M8fs5gNOYLOtAwV8aXAH1YKugLNyrOcK8FabB5tXEcxwTdCCbN5LiX6LASjiEgEMQKATLtWbdbDWlwGX1bU9Acgqsp/LDKi/GE8eKzBM9shefPOoN5cZu+SQh7aEa9HNoyv5kpksb1fPcX2RWuWtxGvmHbWpIBJ7ZViWWHtfmX8xPMToQfQ/Kk3Rb5U/pzhFjT98LhYu4uDGukwSm6U/0b6uM6lwSamNNYH4jxEHQlmoEUwdINRglV90aeXqBRYMjEtY9h4RhDmXzFL0c50un0weiscp3XHZOWrmxUioER6aK3H074HRwxsAczLxYef8svyrVtE+iNZuSK6cRn64QxN5K2YVWIfl3VuK6tbqESn8/2ZMTw/iavYluUPS/vVu4497Ai9VuHd0ooXwrrXEm619C6Pgpsr4orj5q8L5Epb8RQSvp3m1l4pZ2+Fr3b3gHwJXZEh0VuH/DxX7x3scFVrkWXrXCyDD/tRx8GqScdlm7byISh+2cAJoZS2/GVLTFbKsFiSR3u1fr7INP7DtDqccH5VoeiBeX8Rubi64WO0HgFpeTNhZ9QYshyQjUtH+NDZOxgYS50QAfqm4H6pgA3Z6LUVgvtGTSw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(396003)(366004)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8936002)(66476007)(66556008)(6916009)(66946007)(4326008)(6486002)(478600001)(316002)(8676002)(86362001)(2906002)(33716001)(38350700005)(5660300002)(41300700001)(7416002)(83380400001)(26005)(38100700002)(52116002)(6506007)(6666004)(9686003)(6512007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pTTDrNlNfuV+KWuhHw6z+VaDQm4eHLZXbjzfgB+zoJ5RGbMGwSwJLdRPkRrh?=
 =?us-ascii?Q?90uHRZSHcGj6FdAfOdkjnaq0+ILBCd/bsT7Xd3vdDivEx6b9QzKjbv0p+DnN?=
 =?us-ascii?Q?kY6ENRWq2EBcRSz7WjK/i8vOrZ9fWgO5yAoOghAgPJlYRcV328zEiqwBoqkN?=
 =?us-ascii?Q?ZWiJusvvct2crRzabEEWxNcVHGOhzZL7PnnYKBqciRyYvwtool4bcyBSVt4z?=
 =?us-ascii?Q?DUNEQvxQGW3RD78SFhaHZXb7cs80l4LuJuQAlupXLTX+rLuxYnlETTiGrvWG?=
 =?us-ascii?Q?JKDlI5FyiMQaZHQi/uGFBstcL/qodKdgkCOSi4+Eztxw04ViWOfC82035u4U?=
 =?us-ascii?Q?Dh9zrese4vRG/oMueeJdpBbXxnzSY8ntCB/pnf0lsZjY8rm+2gbbngtjZYmg?=
 =?us-ascii?Q?OC/lJqNlTWBwb3EyKSnRJzMg2CsH3TwHRbpOXJJUa42ARRgJ3bxS9KkHA3XT?=
 =?us-ascii?Q?AgTWBke39PY4m4e84hILOgVhC2kD8KopwsSToC8x4mlpXHXgytZu2o9ZYF4y?=
 =?us-ascii?Q?KMgklncGBN1W4XYvHa8d3JKhdca2vnX89Tyo5nZ5SQ/jK4J7vaggdQu9nAyJ?=
 =?us-ascii?Q?vvparDZEYYY3r+QseXk+56ymFIEUzr++QtfV36FjSBBVE9K2c+OcELYzfBaW?=
 =?us-ascii?Q?CBDe6+bU6NLa04/Qu8ugeGYBmiKDS1GR9pAU8RXG/eY6EmqEcT5otValUX8x?=
 =?us-ascii?Q?/6JJ0Uif1gOdbn97nyy0EfDH9b9UrxBAgfcjHMwA+jJKs8PCkljnaik8fvxs?=
 =?us-ascii?Q?stHzvCYyEn3rVMJ4SONk13Wnr5fO4RqrZuzGAjzm430b88bf3Jwec8Ns32Lj?=
 =?us-ascii?Q?aGaqGWLmCedG73LZBiN3AhaJPknJ6l9pyfQQeF4cMNzTpKdD0izJNvYHq0ID?=
 =?us-ascii?Q?L0FklH1mA3gomM+nMI1uYnQHIuiRsyOiwjJdoMtduG2selstG90pKmNQQG1G?=
 =?us-ascii?Q?qjcz809c+94FH/Rv+F8JULjXnz6H7W1fUHiui+Y2hL1msRWKQo0lljlojGAU?=
 =?us-ascii?Q?CHtSLw1PoYd7HIZBXvmv6ThuifCDo2TYoe1CLiNgnsY2rxYuT8HuAyReXq8J?=
 =?us-ascii?Q?BCPPfE4FPREP011YyTa08kq3koapyptgc1pf3R3RwuAxF5KvfzaoPadVZ9xn?=
 =?us-ascii?Q?p0nZbbo4cnqqVRs6IhNvoFWCxsID0x/MM8lHmae43XEUGXemcgzNpidojWSa?=
 =?us-ascii?Q?HdThTecgmVj3ZR229Wf4A3V25cA5ci+wN9Rum7dVWxo294m4ncTvuftnZwGZ?=
 =?us-ascii?Q?RwHhUYYeDjtEBDNKYozbTVgW7ubmMIlsYa9DDiK3hJvodhwlOCg0unw5yfPa?=
 =?us-ascii?Q?S3NR7KsxWBPJUD1RyAstNmqUGgZIaNRbnY/X/ZsuJM2eX4Oi2XYKqXTmvjjC?=
 =?us-ascii?Q?3QSjtyP0FegHwcVwMRH3TAS/9FG4u6sqmgiV6+dPBesSaWKpcDi/3RYaEyKg?=
 =?us-ascii?Q?Riu47+WZ4G2UbGh8SQaI+XWHss0r4ItEPIeZJ+nYtStLaMej/M+kDEFegetX?=
 =?us-ascii?Q?3c/BYxbxndJ3YR3OMWKs3+Dhj3ICk31HN71C4YnQz8c27kkyFyd7BGZ28s1r?=
 =?us-ascii?Q?VmEQ6uevy3F0PwN7wWqr1M0tbO8NXuxNMI8ZBgCD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e74bfc1-7cb3-4444-06e2-08dc23f28397
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 13:26:07.9400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTdlZ74TXA/afwpeziy6yNLTo3eJevDhlpsIf+U6T70GcrGg7prod7EGD18eywgRzRgFMRXcCBEHMU/aP5xWLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9706

On Fri, Feb 02, 2024 at 01:12:41PM +0100, Lorenzo Pieralisi wrote:
> "PCI: imx6: Use "linux,pci-domain" as slot ID"
> 
> On Fri, Jan 19, 2024 at 12:11:11PM -0500, Frank Li wrote:
> > Avoid use get slot id by compared with register physical address. If there
> > are more than 2 slots, compared logic will become complex.
> > 
> > "linux,pci-domain" already exist at dts since commit:
> > 	commit (c0b70f05c87f3b arm64: dts: imx8mq: use_dt_domains for pci node).
> > 
> > So it is safe to remove compare basic address code:
> > 	...
> > 	if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> > 		imx6_pcie->controller_id = 1;
> 
> No it is not unless you magically update all firmware out
> there in the field.

commit c0b70f05c87f3b09b391027c6f056d0facf331ef
Author:     Peng Fan <peng.fan@nxp.com>
AuthorDate: Fri Jan 15 11:26:57 2021 +0800
Commit:     Shawn Guo <shawnguo@kernel.org>
CommitDate: Fri Jan 29 14:46:28 2021 +0800

I am not sure if it is neccesary to compatible with 2 years ago's dts.
I think it may not boot at all with using 2 year agao dtb file directly.

Do you have other comments? I can remove it from this big patch series,

Frank
> 
> > 	...
> > 
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > 
> > Notes:
> >     Change from v7 to v8
> >     - fixed comments
> >     - Added Manivannan Sadhasivam's review tag
> >     Change from v5 to v7
> >     - none
> >     Change from v3 to v4
> >     - remove compare basic address logic
> >     Change from v2 to v3
> >     - none
> >     Change from v1 to v2
> >     - fix of_get_pci_domain_nr return value check logic
> > 
> >  drivers/pci/controller/dwc/pci-imx6.c | 20 ++++++++++++--------
> >  1 file changed, 12 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index eda6bc6ef80ee..773411d20329f 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -33,6 +33,7 @@
> >  #include <linux/pm_domain.h>
> >  #include <linux/pm_runtime.h>
> >  
> > +#include "../../pci.h"
> >  #include "pcie-designware.h"
> >  
> >  #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
> > @@ -40,7 +41,6 @@
> >  #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE	BIT(11)
> >  #define IMX8MQ_GPR_PCIE_VREG_BYPASS		BIT(12)
> >  #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11, 8)
> > -#define IMX8MQ_PCIE2_BASE_ADDR			0x33c00000
> >  
> >  #define to_imx6_pcie(x)	dev_get_drvdata((x)->dev)
> >  
> > @@ -1279,13 +1279,17 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  					     "Failed to get PCIEPHY reset control\n");
> >  	}
> >  
> > -	switch (imx6_pcie->drvdata->variant) {
> > -	case IMX7D:
> > -		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> > -			imx6_pcie->controller_id = 1;
> > -	default:
> > -		break;
> > -	}
> > +	/* Using linux,pci-domain as PCI slot id */
> > +	imx6_pcie->controller_id = of_get_pci_domain_nr(node);
> > +	/*
> > +	 * If there are no "linux,pci-domain" property specified in DT, then assume only one
> > +	 * controller is available.
> > +	 */
> > +	if (imx6_pcie->controller_id == -EINVAL)
> > +		imx6_pcie->controller_id = 0;
> 
> See above, this breaks compatibility with old DTs (and -EINVAL is not
> the only error code you should handle).
> 
> Lorenzo
> 
> > +	else if (imx6_pcie->controller_id < 0)
> > +		return dev_err_probe(dev, imx6_pcie->controller_id,
> > +				     "linux,pci-domain have wrong value\n");
> >  
> >  	/* Grab turnoff reset */
> >  	imx6_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
> > -- 
> > 2.34.1
> > 

