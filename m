Return-Path: <linux-pci+bounces-1751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3798262FD
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jan 2024 06:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E6D1F21D88
	for <lists+linux-pci@lfdr.de>; Sun,  7 Jan 2024 05:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6836F11CBB;
	Sun,  7 Jan 2024 05:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aFg/uuIq"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2070.outbound.protection.outlook.com [40.107.15.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A50125A4;
	Sun,  7 Jan 2024 05:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Euv5h1wQ2weDPQTN502qOmWHsnWAkb+LrzQhpNehMZ5kSX0KJhBMiJoHylG3EnZeyqCybGdxB6lqv6QB2ctK0lWg3pQuE+mQDDL+LumKJdmdo1IU5T1THkqPQcHwbhWV/TZYoNvBBeFcacjrB1yItwlQjeAHp7Lp6d5trchTUami5JDcP6vlOe/Zg0uR+LBQjpu5CR2FDEns4ray7FG+55WNwBLIlPy8TTNjXOorF3oxysnwSZJAKcW5nyr39gh0dQOpZMd3Bodsz6WpWUe2MPKEfBftnVMypis15awAZugvZc3ZZTd2B597TRUUm4OGOLZgAZWJ2NyILLXUbYeHJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMYTIQhEZ2iYwCsvfgly0+ACk3hldCB/5SXFMR/fbYE=;
 b=hL7wafB8iV1o9UPK4Cj2zc6AZVmnXjKnJFaFL7zJKbJXWcXxM8tZad2Utj15/Go0wp++Y4M43HtQEyQw7vojAFIoHNAN8cAe2sCO3Ba+PSfbBMfA3HjWwKX+27Gx/VYqjrSuvpP1Uk5jOUNAlTpqlXX1QLo7zL9ktITd4AKfJcUx+q+RV6Pul9ZytPRmAKiq1rE06CfUH411tuCUK4wM2LOyFuR3FPdtEM9LfmYgzWo1zlaxhAX7jFst2v9mxPA5gBkhk3HQ8HLlN742lmvgOruDzyUCs1xL3AxkL6HI7EGJs5+oKFPPBkLIJt49Xb/OASWr/2YnRdKeGCjWaykpaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMYTIQhEZ2iYwCsvfgly0+ACk3hldCB/5SXFMR/fbYE=;
 b=aFg/uuIqqsPY+dE2IL/a2fRQWV73ZUWw0bOvLgpE2P258htStTvQwZC6PQcIOpFvV0eEud3W04U9z9jcnE3noh5U30DXKbGNJ4+DXJSTUH0lVZ2nYZh00lbLTGsfSnJYhiTKfdbhx7S8cbGpgtN26xTNbZHPLg++zs2i6283Izs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by DB9PR04MB9283.eurprd04.prod.outlook.com (2603:10a6:10:36d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.20; Sun, 7 Jan
 2024 05:32:23 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Sun, 7 Jan 2024
 05:32:23 +0000
Date: Sun, 7 Jan 2024 00:32:14 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, bhelgaas@google.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
	helgaas@kernel.org, hongxing.zhu@nxp.com, imx@lists.linux.dev,
	kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org, s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: Re: [PATCH v7 07/16] PCI: imx6: Simplify configure_type() by using
 mode_off and mode_mask
Message-ID: <ZZo3XpYkzxDolK47@lizhi-Precision-Tower-5810>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
 <20231227182727.1747435-8-Frank.Li@nxp.com>
 <20240107051655.GF3416@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240107051655.GF3416@thinkpad>
X-ClientProxiedBy: BY5PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:a03:180::47) To AS8PR04MB7511.eurprd04.prod.outlook.com
 (2603:10a6:20b:23f::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7511:EE_|DB9PR04MB9283:EE_
X-MS-Office365-Filtering-Correlation-Id: f595db06-be02-4e56-bda0-08dc0f4206a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0RVzagaeVyqD6Qn4jpJlEJtXFIm9dNEmhpPmdrHSAMEF1t0Gv6X+kOczn1gEEluaqrzmtPES4YVnQoJ4onA7kfWXPfzVLwSjn0o4UqWtU4VzV9/I5OreOqPFdEwGe1n2owxQHeAZtiR0+mc9gAun86W/+lKhR+ugAt3gvLzlvrYnSvQ+tDGjtfn6oNcUcIEXisIjKPFRZjzbFDqspU1CLKVd7nggKtl8Wn9Q6/dguplHF9Z/F+NYMY7Ru1nwLqzJYsNjxAq4wiWQVE5okyq73xJAMMBK/OMfKn4705sJk5BY/NGjlRLUkQ80jk9wlu1uxoGvvxf6BcM8SunS2Ytb8eDcaq2TlXO2uNKd5qhhHqfI+5wGa5UtZSgKG/AgJ0VTItJAGCbwgoG2m7UDDoeaNKFt00H3nWEdRZavg6pnjrJNikezXPk5pnybT4ipQnfx0al5WQVKSmL2XTniI0OQvrK1cyH0GPjc87mXaPvr0gRzf9zOhawrEa68Gfirpk1s28ElcoXMw4dT9p39ZJSXK/djxTr0qCZfVLjapDGuzMJxzAeXqe5GTKhjrrsrlha6VkWjuIrjj7j/fxqt/V+tHqr2sHyn7RAPMW5Qo9tqzbXukwaeqfmPBOCmpkceUwAQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(6666004)(478600001)(26005)(6512007)(6506007)(9686003)(83380400001)(52116002)(38350700005)(66946007)(66556008)(66476007)(6916009)(41300700001)(38100700002)(2906002)(5660300002)(7416002)(8936002)(8676002)(316002)(4326008)(6486002)(33716001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RW5NcEZaSFQ1RlBxdEloT1puUUxHMG1RUWN4OTd3aVpSdkJDalZ4QWcyNHJr?=
 =?utf-8?B?alR1RjVDQlBWY0hvaCt4d3ViUTV4WU5BcGRDVHp4VnNPZ3h4WTZ2Sm1NRHFt?=
 =?utf-8?B?citOUjJPK3JHWG1MTjBxYkpVU0FsRGg1bFo2Um1JeS8rZnRRRklDcU1ha3Uv?=
 =?utf-8?B?UWJwRmY4MFZvWU1IY042TDJ3cUZHVERFSFdNdzYrNC9mb21IWXZjMDB5aU80?=
 =?utf-8?B?VENFdkY1V3U1NWdncThmRDNQclRYRUcwSDZXbUhiTTdFWDh1K2NQbzRKQVhE?=
 =?utf-8?B?U05XRHphVVNQYklzbjBWVm5iQ3h5QTVUbytVZVcwaERKd1B0NjkxemNQZzBX?=
 =?utf-8?B?NXJYdlpOUElzeFl3NXJTNkpkOXgvVVRrNjROVGt5TzFKZkI2K1BuRkhRaUlS?=
 =?utf-8?B?eVE4T09IVzBGdlU3aWNYa3g3eGtWSjlwQ1pQckdNamYxN1Nyc05KMzBKMUth?=
 =?utf-8?B?eUhpR2l1QVIvMlo3eE1nRFl3YktrdFpFaEdyTDVIU0htbEEyUHV0MElGNjdO?=
 =?utf-8?B?V1pBeWVWZGNQSWhiVTB0MzBadkh5NERtb1B5RnpaYUJWZldjU3YvWXFBVWVF?=
 =?utf-8?B?dE1TeU5qMUR2TjkvSUZnSXpRVGVCYkZHTFlhUWVZRGtMWTk3dnJsa3hVVlA4?=
 =?utf-8?B?UkNiQUtKZ1NLSks1WXVERFR2b1UwVW53S1FZMlhrczc0NFlFZkhGNDYxWVhV?=
 =?utf-8?B?Q0pTWWlKaU45Y29rTk9wNGhwQzRpeGw5U3lvWEVSZml5eTgrUFpObXBpUjgz?=
 =?utf-8?B?ZjlPZXA4RjRkenArL0dHUnZoUWs4T09BK2lQaDJHMTB3emEvTHA4SEJqSHUw?=
 =?utf-8?B?UDVTMGZlMk4yR0N2dXdFa1VCTlZhQ05qN2RqUGx6QVBYRENOU1A2N2w5bEcv?=
 =?utf-8?B?V0xmM3VzZzJUb2cvOWNiRzhmUFNSamxLbkRsc2MxSkFUVm9qQnlyQzZ0QXpG?=
 =?utf-8?B?dTZmdlRjMS8zNURDVGZBWnlZMkFXU2xFckRrSDVxbFlwVldTNzBhTEh2dUYy?=
 =?utf-8?B?cXYvbmZXSmo0cHNQRmpOMyt0TytRM3kyc01uR2pLcS8va0U2WWl2ME1vaElk?=
 =?utf-8?B?MzErMzdlQXVwK3lpb3UwQ2lRT3J0VXFoUVN5YS9BSWhXUG02bUlhMEtkSnNo?=
 =?utf-8?B?bmprcmx1N2hZZHhWRXhiK1JrVkRBMEtVaTEzS3ZTL0lybjJPVVFTK254MzFr?=
 =?utf-8?B?dDFHcElJa0luakkvWCs1akxjM21qeHN3c3hkUlgySFBKVTNQQXg2YndhekVt?=
 =?utf-8?B?Z2ROZkhoNStCVjAwZ3B5c0Ntam9ueUR6TmxOVEpNSkswTVpsazNjV0RXeWdZ?=
 =?utf-8?B?OG1veXRLTHBGQ3ZpbXZCMmVmdUVueEhMOXQzUXpVcm14RFlaZXpVVlZvOWxI?=
 =?utf-8?B?MzdMdUZaU1JaVWxRVHk2YkRZSEg3Znh3b1YxL3pqTnFNMWtiWjFnajRaeVJI?=
 =?utf-8?B?REFoM3JZTUlyUVMrcXl2c1NZRjVrM3luY296ZTRnSS9YVjJoYU1wNnl1ODNG?=
 =?utf-8?B?M0JSUFAyRXRqTGlPQW1FYnNNL3ZTZmk5OXlRSC9iYTJwZGxHWmRYelVpbFpv?=
 =?utf-8?B?R0JHRmdGcXRtSXVsVTVOMnBPUFBiWklLRHRTWUdSMndET1BxdkUxQmFmQUM3?=
 =?utf-8?B?MzhTeFZodGpVVTM0dWpTc0R6emhqWGhaYk52cW5NS2hQa0xTNncya0JCMUZt?=
 =?utf-8?B?bXQrQ3hBZXlWU21raXp3b3c0YlZ0Y0thOEh3cW0xd3BSUktQWU9yZDBUUTdn?=
 =?utf-8?B?dGszeFRpRmV4U2p4UzlFTlJmUkluZ3ViU2I5WkhVQXloWFBDendwTGRQcnJn?=
 =?utf-8?B?K2V1YVByU3Z2dEJsbHR6WGZmVEZOZzBLN3M0bUswRmN6T0NUcmJDb0poeHdI?=
 =?utf-8?B?b2h1ZE5rZHdSM2dIOW1CK3RLbTZUR3VLVEVMQTJRNXVtZzAraFJlaTZaQXQ5?=
 =?utf-8?B?d1dlUnlZNGtlQ3crMm02NzJ3aFVJZDBLc2QrYk9YUmJBazV3ME1RcmRJT1RX?=
 =?utf-8?B?U0txSjVNVEhRMjFScWhaQmkyYTVNVTV0Z1liSkozRk9qb0IvYk9teUM5RktK?=
 =?utf-8?B?dXNBZEQrN252dnNhams4eTI0eEZYM0tEcWZUSnVMWkw3Zm5xdEVTQkpWcXkw?=
 =?utf-8?Q?hJhM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f595db06-be02-4e56-bda0-08dc0f4206a5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2024 05:32:23.5017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FrlR+/ef9HYq/kfBivvIQqs1bWYdGFJ2YyxkqRwpifaHYGBw6M5ksqh9C5DWc5e/LDy04npvEWZewcKFyii0vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9283

On Sun, Jan 07, 2024 at 10:46:55AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Dec 27, 2023 at 01:27:18PM -0500, Frank Li wrote:
> > Add drvdata::mode_off and drvdata::mode_mask to simple
> 
> simplify
> 
> > imx6_pcie_configure_type() logic.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> Couple of comments below.
> 
> > ---
> > 
> > Notes:
> >     Change from v2 to v3
> >     - none
> >     Change from v1 to v2
> >     - use ffs() to fixe build error.
> > 
> >  drivers/pci/controller/dwc/pci-imx6.c | 60 ++++++++++++++++++---------
> >  1 file changed, 40 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 588bfb616260e..717e8fa030deb 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -68,6 +68,7 @@ enum imx6_pcie_variants {
> >  
> >  #define IMX6_PCIE_MAX_CLKS       6
> >  
> > +#define IMX6_PCIE_MAX_INSTANCES			2
> >  struct imx6_pcie_drvdata {
> >  	enum imx6_pcie_variants variant;
> >  	enum dw_pcie_device_mode mode;
> > @@ -77,6 +78,8 @@ struct imx6_pcie_drvdata {
> >  	const char *clk_names[IMX6_PCIE_MAX_CLKS];
> >  	const u32 ltssm_off;
> >  	const u32 ltssm_mask;
> > +	const u32 mode_off[IMX6_PCIE_MAX_INSTANCES];
> > +	const u32 mode_mask[IMX6_PCIE_MAX_INSTANCES];
> >  };
> >  
> >  struct imx6_pcie {
> > @@ -174,32 +177,25 @@ static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
> >  
> >  static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
> >  {
> > -	unsigned int mask, val, mode;
> > +	const struct imx6_pcie_drvdata *drvdata = imx6_pcie->drvdata;
> > +	unsigned int mask, val, mode, id;
> >  
> > -	if (imx6_pcie->drvdata->mode == DW_PCIE_EP_TYPE)
> > +	if (drvdata->mode == DW_PCIE_EP_TYPE)
> >  		mode = PCI_EXP_TYPE_ENDPOINT;
> >  	else
> >  		mode = PCI_EXP_TYPE_ROOT_PORT;
> >  
> > -	switch (imx6_pcie->drvdata->variant) {
> > -	case IMX8MQ:
> > -	case IMX8MQ_EP:
> > -		if (imx6_pcie->controller_id == 1) {
> > -			mask = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE;
> > -			val  = FIELD_PREP(IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
> > -					  mode);
> > -		} else {
> > -			mask = IMX6Q_GPR12_DEVICE_TYPE;
> > -			val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE, mode);
> > -		}
> > -		break;
> > -	default:
> > -		mask = IMX6Q_GPR12_DEVICE_TYPE;
> > -		val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE, mode);
> > -		break;
> > -	}
> > +	id = imx6_pcie->controller_id;
> > +
> > +	/* If mode_mask[id] is zero, means each controller have its individual gpr */
> > +	if (!drvdata->mode_mask[id])
> > +		id = 0;
> > +
> > +	mask = drvdata->mode_mask[id];
> > +	/* FIELD_PREP mask have been constant */
> 
> No need of this comment.
> 
> > +	val = mode << (ffs(mask) - 1);
> >  
> > -	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, mask, val);
> > +	regmap_update_bits(imx6_pcie->iomuxc_gpr, drvdata->mode_off[id], mask, val);
> >  }
> >  
> >  static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
> > @@ -1376,6 +1372,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
> >  		.ltssm_off = IOMUXC_GPR12,
> >  		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
> > +		.mode_off[0] = IOMUXC_GPR12,
> > +		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> >  	},
> >  	[IMX6SX] = {
> >  		.variant = IMX6SX,
> > @@ -1386,6 +1384,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"},
> >  		.ltssm_off = IOMUXC_GPR12,
> >  		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
> > +		.mode_off[0] = IOMUXC_GPR12,
> > +		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> >  	},
> >  	[IMX6QP] = {
> >  		.variant = IMX6QP,
> > @@ -1397,6 +1397,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
> >  		.ltssm_off = IOMUXC_GPR12,
> >  		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
> > +		.mode_off[0] = IOMUXC_GPR12,
> > +		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> >  	},
> >  	[IMX7D] = {
> >  		.variant = IMX7D,
> > @@ -1405,6 +1407,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
> >  		.gpr = "fsl,imx7d-iomuxc-gpr",
> >  		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
> > +		.mode_off[0] = IOMUXC_GPR12,
> > +		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> >  	},
> >  	[IMX8MQ] = {
> >  		.variant = IMX8MQ,
> > @@ -1412,6 +1416,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
> >  		.gpr = "fsl,imx8mq-iomuxc-gpr",
> >  		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"},
> > +		.mode_off[0] = IOMUXC_GPR12,
> > +		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> > +		.mode_off[1] = IOMUXC_GPR12,
> > +		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
> 
> Is the mode_mask differ between SoCs or fixed based on instances? I mean, if
> there is a guarantee that it is going to be IMX6Q_GPR12_DEVICE_TYPE for instance
> 1 and IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE for instance 2 etc...
> 
> Then we can avoid these SoC specific config and simplify the code further.

No, iMX95 will change it. 

Frank

> 
> - Mani
> 
> >  	},
> >  	[IMX8MM] = {
> >  		.variant = IMX8MM,
> > @@ -1420,6 +1428,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  			 IMX6_PCIE_FLAG_HAS_APP_RESET,
> >  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> >  		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
> > +		.mode_off[0] = IOMUXC_GPR12,
> > +		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> >  	},
> >  	[IMX8MP] = {
> >  		.variant = IMX8MP,
> > @@ -1428,6 +1438,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  			 IMX6_PCIE_FLAG_HAS_APP_RESET,
> >  		.gpr = "fsl,imx8mp-iomuxc-gpr",
> >  		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
> > +		.mode_off[0] = IOMUXC_GPR12,
> > +		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> >  	},
> >  	[IMX8MQ_EP] = {
> >  		.variant = IMX8MQ_EP,
> > @@ -1436,6 +1448,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  		.mode = DW_PCIE_EP_TYPE,
> >  		.gpr = "fsl,imx8mq-iomuxc-gpr",
> >  		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"},
> > +		.mode_off[0] = IOMUXC_GPR12,
> > +		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> > +		.mode_off[1] = IOMUXC_GPR12,
> > +		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
> >  	},
> >  	[IMX8MM_EP] = {
> >  		.variant = IMX8MM_EP,
> > @@ -1443,6 +1459,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  		.mode = DW_PCIE_EP_TYPE,
> >  		.gpr = "fsl,imx8mm-iomuxc-gpr",
> >  		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
> > +		.mode_off[0] = IOMUXC_GPR12,
> > +		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> >  	},
> >  	[IMX8MP_EP] = {
> >  		.variant = IMX8MP_EP,
> > @@ -1450,6 +1468,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
> >  		.mode = DW_PCIE_EP_TYPE,
> >  		.gpr = "fsl,imx8mp-iomuxc-gpr",
> >  		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
> > +		.mode_off[0] = IOMUXC_GPR12,
> > +		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> >  	},
> >  };
> >  
> > -- 
> > 2.34.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

