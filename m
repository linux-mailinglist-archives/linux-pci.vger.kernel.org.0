Return-Path: <linux-pci+bounces-2904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F16FA84501D
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 05:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D3328680E
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 04:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BFD3B78E;
	Thu,  1 Feb 2024 04:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KBP7Gefr"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3373A8EE;
	Thu,  1 Feb 2024 04:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761114; cv=fail; b=C1gYFsqf2kNERXJU4O1P/9rn4O7odHuOjSUD7ZwgqgRKJyVx7FSHW39basfw5TSVeockOy5fmxXAedvsKB/+YkOEhcpUS+S3NHwmkfTmEvOgZFOk+AXKNvH44UA2/mfh69JEuKGF3Tds9q7CgA4CK5NbsVMwSjRPWO3K1ru9WhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761114; c=relaxed/simple;
	bh=xwjAiWvcrCMyjuZbUNEqMQBx2aeFsAQgX7b7v0HNnHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XjsOvDedUtWQTSrvmTNKO44yeuoZ+JalusKttYWTbSJ4uEIug8qcizJ9y9NhGC024z+ptxzpsSjidXAn/xRp35+24CZeAh+Xdo11h8nmmY5fDJIy/mt5fy+GdqDqn9qr5LhWDSxVcjGUR8esPJ7uLafvnK4P/8aMWe989h+d8JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KBP7Gefr; arc=fail smtp.client-ip=40.107.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3yjf+oCowwbAjD0EOkHZThUhPk2C/ZXGw5XbF6EdYvzAtYBKmQmPhJLzEY4+KHJ/nQwdy0BQeaUxBlnvGStPwFXVCv6rng3EToXbeJCWOyH8XXQ0KwjbQnAe2cp+hPa/cW81cDSyf2bKTSU0OJa7BZ4L0T3rzEwa7Sz0Q388wMhU0n6cO+tFHsDyhliIIj/yicPRoP9VsXN1X0tq7ydFuZXNUHEFszUAZMRzmpmcq4akG+/M/Kf8reeCgQl/5G7SbKbHHt3PPSpZadHBKgLS40bPiztR+Y600dcKdpdlUpJOtzWjBshCMl16FrswLZ+gOjJtHjHhe8yYPoJRI55qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljzjxqwpA+jHjkQAaszeiF6LrGKCR0w7lwApPozWuWY=;
 b=DzcXVTNxnCZWVb/+jk6QFyVkTcaUdKEeIhWXOtCgVNIgwxlNsmdj1iBQ9zY9A797JUf+BIFpeXkBYX4HIAJAG0NI7R/tOuFHWgokK00Gi+FnAzmtWFnZYDvcMdtYRRmeTZQVMuJkvvidEty2ZE8UuVBQCbaWFeBv/vMLMz3InBG1EzEbadbcEoUMK5C5cf9VATKdUYpphY0jsRrSh40BdhloVjbQflXLiX9nnyZoVjflHdiZ2tn1/paYPYrVAyZP44PGM4ffzAQvhMJ41aE9h4HUTbTgWThtKwXZalyFD3jdabkTTcUaLPE18CNQS54Gg50Sy0UPjoRMXJ+ufH2o5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ljzjxqwpA+jHjkQAaszeiF6LrGKCR0w7lwApPozWuWY=;
 b=KBP7GefrX98WBF8xrrDR/9AXk0aXXym6TmRrisQna8REQ01FUN8lVj0FrNpTcJZpieSn6WuWRlagxzQ5AowtXPMDGx7eSmQnYzmBxduEc2PMmLF2In+vkKa8Be6RPVMfEceasLu0Vuh1zeHQ6pwYf0BoMrcbQq80YOVHofAK2GY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6895.eurprd04.prod.outlook.com (2603:10a6:803:13b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Thu, 1 Feb
 2024 04:18:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 04:18:27 +0000
Date: Wed, 31 Jan 2024 23:18:18 -0500
From: Frank Li <Frank.li@nxp.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH 3/6] PCI: dwc: Add outbound MSG TLPs support
Message-ID: <Zbsbig9CFevHFBPI@lizhi-Precision-Tower-5810>
References: <20240130-pme_msg-v1-0-d52b0add5c7c@nxp.com>
 <20240130-pme_msg-v1-3-d52b0add5c7c@nxp.com>
 <TYCPR01MB86137941900C38F89EC2F321D8432@TYCPR01MB8613.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCPR01MB86137941900C38F89EC2F321D8432@TYCPR01MB8613.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: BYAPR07CA0042.namprd07.prod.outlook.com
 (2603:10b6:a03:60::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a8e0300-c84b-4ae1-33c8-08dc22dcd699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A/NkdJzv1H5NqUIroq1JHERAtXWkn3viVkIt3wPzNil5LxRFUGnGQijErLGN3e7cKhhzwiG216F70GYYt+QBuV8Zs5Drm8Q2/WKShAvwziNetVf6lJqGU/axji+K6BSVI42oe0ILdvRVrsJlL7L+d344T3CfG6jMxiHmEMWbuiKZVEx3kjVIpB10hidr5NNL22DtVNmJBoDIaUTfYAtc/HXZahsrSct0I2ExE7p1GL7TlnoI/s6s6dhZInXOG42bKalBhH892mFqA8A0+WtaiLCSBMYG7vj4Qi7ZcYwN18CDvftM/lAZd/W/Xr5rO0H5/Stuwd1O/3waFt8fC4H8Os58l739xZKatpG4xR8nS2QlrwRhRa5V/QVncW5oClC+DYBSmRl3ujWgR075QV2E8MKI3meJmT3j9xksld50kEQYvF3yqBfd8jb+ic9dTOCTWt05Pbyb60tYY8S17AFmrCBNatyn30unWjGCMryRD+W5mDKkPkMOSRA8x5ZFWw/TL7MX+Fn68gIUOfrBG+OtwWVT52Ve97IQyHt0VZOSxGrwLcB4/g1DkMtXwpVEgpbHWzL5bpBtZyGGJjss6BkauWRsyosBC2R1djmA2olFuXK2E5/PA2DYehiNt9gUX0Pc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(39860400002)(136003)(396003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(41300700001)(33716001)(6512007)(26005)(38100700002)(9686003)(5660300002)(8676002)(4326008)(8936002)(7416002)(478600001)(2906002)(6506007)(52116002)(6666004)(66946007)(66476007)(66556008)(54906003)(6916009)(316002)(6486002)(38350700005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gh9dmGMu0Z3rhhQKNx0k0i8qvEWLQyf0vi5j2gx8tkFCxdt4CzYgaii6FoZb?=
 =?us-ascii?Q?28hP8ZpokiOdUi+bvuCjvyaaDzXXDasm5Gs1jheZg0SJXrTMvubF1MzMpz+3?=
 =?us-ascii?Q?3GEAOj1oX7h99oXLY3YwZ4/8Ehoh5amVujRJDn6QOSf4Q7I2Tz0q/b9cKoE2?=
 =?us-ascii?Q?mhkps85FwNYIOzA3D4f16Fdejvpk8/QnhpGfUGrFlSwoaItEqC/v7sOJNDeY?=
 =?us-ascii?Q?V9C11NwbpwU5ODPxPomih+KSA0SBPo5EOpr1E5rxd7y9mUYR8S8M+UC+LjO5?=
 =?us-ascii?Q?4LiNZucsqJrenBGM3vEpLRf7u5AZw6hHMonA0L3eNQqGAxS44HBaDsEJDORS?=
 =?us-ascii?Q?NxqNzhCsIYVfLwDVIF/fI0JYOvHkXBbBskdEFvEzY13/g4+lk7bqR868IxEX?=
 =?us-ascii?Q?659mHHA5INK8s6NJmd/ffk4lxcVdXrCGAvMOoLzFVPHabYKm2w5O40ikvlFx?=
 =?us-ascii?Q?WuDcVqBkMrpXpYUmlaEOZyAepkQ2Z9KAPj6XGid5Tg9REPy/ZMLZ5rt3sa4u?=
 =?us-ascii?Q?bQ5ET/i1DbNVbdp6zGxbYmAjlIm8RpSGs/SKHEdvIEX5mkhUgRFG133ff3ab?=
 =?us-ascii?Q?65XpIwvwYb6GnelfYznd+dWz6xJgHrlU6NyyAza5vQOhhaNMMaAMMi2jCQJQ?=
 =?us-ascii?Q?NENtuwYb/NM5J7pHyEEflDRgYdPjxhEnrH3HZ9v8K0YP9n9jTYTy+v5bpnDI?=
 =?us-ascii?Q?ONa75uhGLpd6sQXOI1gjBeZ69Bek43/Su7h8say1xrjNrtbfwmPsptA5pThd?=
 =?us-ascii?Q?RY1CPKyw+G647lnIdNDfDxawq6Yt43lIgrSVI4vjUnl1agL5tfqFMNU+yheb?=
 =?us-ascii?Q?+sPbb7vNs9EYTWP0xgMUrRJ1uXfxryyZ0VOcdjFqxONnIwuGmtQaBMNpQ1j9?=
 =?us-ascii?Q?o4NdUOdQxp1DXHIwYS/wz8osM15b2d9B7c23gcqerRsv4jdtqt+tIH1B2jqb?=
 =?us-ascii?Q?Nid/ehh90HtO0KrlaLFMQyGU5gtv7FncoZJ/PJ+wbHJ0PmzMN8H0l/TStV65?=
 =?us-ascii?Q?+q7LBQ+WuUyHtincStjuPn5pusN/GpZCAfL6FOVcIJhzzZjEFYBL8HlN1mor?=
 =?us-ascii?Q?LyeK4TNPKfU6e2alEOOwR89sVEYnyQdz1mzuv7K+G535oMgjj6WljjY0E5Zu?=
 =?us-ascii?Q?Y0xVeV+prHRl6DlM6ruj+4Cb14DJP2qRIy3Nbh+OhbQV0y1hf0hbDJOiIWR+?=
 =?us-ascii?Q?nBDWDkGmIXAz35UZ2a4A39/GbWeymTS2kZoiflLtfxZCSeG1KoOQgHSiQfOR?=
 =?us-ascii?Q?vfrMiscI5Vt9Z+CR/Ujv40IMNdmnrsvDANTQaSF5T2LumhwZIuvgIc5HhsZ2?=
 =?us-ascii?Q?0G23m+K99v4BSxq4MYLOOr6+8kmWT2HtDJ+lTbKGk1BDIRim3GVXQtIcX5pz?=
 =?us-ascii?Q?Ah6SvjCWPr/rH2pkAJrs9/SqWKySTHJbyJcd8QsejKPjjxIoxVFQaYeM6KMK?=
 =?us-ascii?Q?uwwognjXHERxaVCGyt0qIRMAZoce3Rzo1wz3Z4tjSsBRNcvNHxvMGdq5PbZg?=
 =?us-ascii?Q?zlONuuwwBOU8srLRazwAmgFLUk65/R6mfY3zlMC/K0FfDYWWBO9Daz4ckn+/?=
 =?us-ascii?Q?hNam5y3El14IdQFsmdY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8e0300-c84b-4ae1-33c8-08dc22dcd699
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 04:18:26.9741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4pXaIMBRl7TGjuWaW+i+Z3buNAUY3MiJEfihIxbWzNCBgetjCbyPkdE75LfMRgEiASd6KdVYqC1D7r07Ty6Y1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6895

On Thu, Feb 01, 2024 at 03:07:24AM +0000, Yoshihiro Shimoda wrote:
> Hi Frank,
> 
> > From: Frank Li, Sent: Wednesday, January 31, 2024 9:45 AM
> > 
> > From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > 
> > Add "code" and "routing" into struct dw_pcie_ob_atu_cfg for triggering
> > INTx IRQs by iATU in the PCIe endpoint mode in near the future.
> > PCIE_ATU_INHIBIT_PAYLOAD is set to issue TLP type of Msg instead of
> > MsgD. So, this implementation supports the data-less messages only
> > for now.
> > 
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Perhaps, your Signed-off-by is needed here?

Yes, I will add at next version.

Frank
> 
> Best regards,
> Yoshihiro Shimoda
> 
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 9 +++++++--
> >  drivers/pci/controller/dwc/pcie-designware.h | 4 ++++
> >  2 files changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index df2575ec5f44c..ba909fade9db1 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -499,7 +499,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> >  	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
> >  			      upper_32_bits(atu->pci_addr));
> > 
> > -	val = atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
> > +	val = atu->type | atu->routing | PCIE_ATU_FUNC_NUM(atu->func_no);
> >  	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
> >  	    dw_pcie_ver_is_ge(pci, 460A))
> >  		val |= PCIE_ATU_INCREASE_REGION_SIZE;
> > @@ -507,7 +507,12 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
> >  		val = dw_pcie_enable_ecrc(val);
> >  	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
> > 
> > -	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
> > +	val = PCIE_ATU_ENABLE;
> > +	if (atu->type == PCIE_ATU_TYPE_MSG) {
> > +		/* The data-less messages only for now */
> > +		val |= PCIE_ATU_INHIBIT_PAYLOAD | atu->code;
> > +	}
> > +	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, val);
> > 
> >  	/*
> >  	 * Make sure ATU enable takes effect before any subsequent config
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index d21db82e586d5..703b50bc5e0f1 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -148,11 +148,13 @@
> >  #define PCIE_ATU_TYPE_IO		0x2
> >  #define PCIE_ATU_TYPE_CFG0		0x4
> >  #define PCIE_ATU_TYPE_CFG1		0x5
> > +#define PCIE_ATU_TYPE_MSG		0x10
> >  #define PCIE_ATU_TD			BIT(8)
> >  #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
> >  #define PCIE_ATU_REGION_CTRL2		0x004
> >  #define PCIE_ATU_ENABLE			BIT(31)
> >  #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
> > +#define PCIE_ATU_INHIBIT_PAYLOAD	BIT(22)
> >  #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
> >  #define PCIE_ATU_LOWER_BASE		0x008
> >  #define PCIE_ATU_UPPER_BASE		0x00C
> > @@ -303,6 +305,8 @@ struct dw_pcie_ob_atu_cfg {
> >  	int index;
> >  	int type;
> >  	u8 func_no;
> > +	u8 code;
> > +	u8 routing;
> >  	u64 cpu_addr;
> >  	u64 pci_addr;
> >  	u64 size;
> > 
> > --
> > 2.34.1
> 

