Return-Path: <linux-pci+bounces-592-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCCD80760C
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 18:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CDFBB20CBD
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 17:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619D437160;
	Wed,  6 Dec 2023 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FD5X/j61"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953B8D40;
	Wed,  6 Dec 2023 09:07:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWw+fqm7rDyEkKbae+lj0lVP8nNQYgwrrTtHdBF2hCpB9FrpdQUEE0+IzbMfGV3ndgT1AQHBN4kgHBBJBN7me8DEy8BE7K3f7GdA8bzmg1Ic/1S4ekIhsBkCriGFynq1PtHhfphW3k4icUv1CQBLBHphHjl83atwudaMIqRk8C5NwUNuimMd9gjNdXZ0W2w2iK3+BfYjlAApwDbSiYJwJLUinb1tPARRmldjjJeXYiaghispHdy/p8oCiO0oKvSIoLPE2C3LI3cPDMeNTFL3OV1gR/RmNdoSTJLZPQRfcEbugqtr3PYJkPwXSAV8imiBRY/srt7O0von4b71bLdzSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1wCyBM1+eCE7XF3bmKzo4H2Km+WyCO2evHnDVPaJQU=;
 b=g9yuvDQTKtwGS99MbIuwNiHZt7989oa+1MbRNw3/fbDpqZO5XvGrlvHNIKluU9NAQzDjDJdJE+zOlKRcUjJeMFZF9DrCOpyU5ytxBMz0IA3TKdB7TlHdnj/VbPlACWXdL7olcv0kNsxeLmKXgEJwSyglo/V2pZPnzx1l7ISp0ymfwJG3gR+8PoZBqI6Sa+KUAPcrOdsnNcNsIrUL/caN/mEo6umXVtBICw6QvdGhDHN/Tney/iBl4+u7p8wzQi6fuyUFSYL1DYSv+7Wy7UhC+sHh5Y/XhFvu1U1S69JgBH6YB6XmPTWngKbd0OVrtRsdMgg3/NrnOAfG1f6F2kYsMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1wCyBM1+eCE7XF3bmKzo4H2Km+WyCO2evHnDVPaJQU=;
 b=FD5X/j614EfD/1kwvAc7lShPJM8ddMaZzWvW3aQq9eD/3OWfUkW8YOjqDoBOlmeQP+sZ2ZSly8FcwO+Q7JIJUt1CTAsekRfZVVuJGGls8RZbWo6jQZnzOVDv4PSwQ+925TKI7Y9KmhZaoVE9hmigf+nXpI0r2VgI0SehLnx8CZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by PAXPR04MB9253.eurprd04.prod.outlook.com (2603:10a6:102:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Wed, 6 Dec
 2023 17:07:17 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5%6]) with mapi id 15.20.7068.022; Wed, 6 Dec 2023
 17:07:16 +0000
Date: Wed, 6 Dec 2023 12:07:00 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: imx@lists.linux.dev, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	"open list:PCI DRIVER FOR IMX6" <linux-pci@vger.kernel.org>,
	"moderated list:PCI DRIVER FOR IMX6" <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/9] PCI: imx6: Using "linux,pci-domain" as slot ID
Message-ID: <ZXCqNI3VZ8Sn23WM@lizhi-Precision-Tower-5810>
References: <ZXCmSOwTWR6AVpGB@lizhi-Precision-Tower-5810>
 <20231206165953.GA717921@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206165953.GA717921@bhelgaas>
X-ClientProxiedBy: SJ0PR05CA0126.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::11) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4845:EE_|PAXPR04MB9253:EE_
X-MS-Office365-Filtering-Correlation-Id: 470673d6-267c-41af-f3e0-08dbf67dc82b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4a4+9fYg1RfaxzFql1IsMZVeMHdQ2AB3oPeTScfOhKWirSpr7oFZagbdWUCCiaAposO73u/fHU7VkBBqTjSqnvqGClF2LFx4oxFG4G33hQUmGr4WxE8Ilx7Emhut6PCas6ZoA5Y20UKSC5iDIbU2rBgLS98Yq5QbfELChW28e38mQ2ipc5ql0eJYP+JeLXfxGnohJoovf3TzW7PVrstOfd19chiGXNyjt2RoL+2z0deQEIe2PjnfKEOeGRMIYpJ8LNXn1JRUR7w994TY3uUzXDSeRMgjj+vf1bVk5zgY3NQyht9/Io/ngCadKX6+1r6uqpLUEh0ykpzCWn1oUawS+5K5JWyRJ3PF50SUuyp+WM8RSj+UhLYrNatYFpcTJx53JMJPOBtHiOeOhEynbo9N/FWYj8rjmenVrbg49T/EjlnpKKJwt9HsdsAZR3qX/EO4gM5sWnFy56GrJACysMXIRGuEAxY+N2eqcxmahmXHYskw6ErYSwnoXmseTnndfmqlxesrdjYEhGuOXhsRQW1+9kNmKX+W/xpfaMQY+EnbjHT3VMVGaRg7LDVra/liHRIyRP9EE8NIp+yXFkISAsYPD7ETPdJbo4sCscrKPawfRfjaAZOFf93JiKX3oC3NqBhJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(396003)(376002)(39860400002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(8936002)(8676002)(4326008)(52116002)(6506007)(6666004)(26005)(6512007)(9686003)(316002)(54906003)(66946007)(66556008)(66476007)(6916009)(6486002)(478600001)(41300700001)(7416002)(5660300002)(33716001)(2906002)(86362001)(38100700002)(38350700005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iIz5Y76F2jzW29g9dAfkJJINQdSo5eoacjD4xoEiq0+gOe+xwlUJ0sbD2BHG?=
 =?us-ascii?Q?OMzS9avHtS+KEpydpJcfp/7HhzyQFAg0Qf/u4PjmRAr475iUGkcAt7hdq7Z+?=
 =?us-ascii?Q?Bpe861zCkuU4zb2BaZ/NjblRM7ffcsFORovf4TOKdX/Dk97DKWgpgYj9XCAd?=
 =?us-ascii?Q?lcPAjmXcd+cBZvE9/LX2TJcpPGtivhzTsyBGF4djrsJVaAYsFyJNoTujAbM3?=
 =?us-ascii?Q?5PNhoZqyFcB3LmRteps4OO6uCAi8kfsrQaL5ndoBugmLMKK/IpmpwYUbfB4/?=
 =?us-ascii?Q?pHWOJiiJjoqvu6DkZHKlkdgMBCmlVVIIK5187g+G2TJdT06zJ/sCliUpeMOr?=
 =?us-ascii?Q?z7IThryE+VYrFi4mM8IeUQ85c2dHuisr8yopDJBQJqTGjY2lxluJ9TrXODH0?=
 =?us-ascii?Q?U2xML5QoPhxcQKnz/zhddlwSjKvh2A20GYeW47aJ660uXAcA6D6UiySKK5B2?=
 =?us-ascii?Q?jInY6bLouWn32WMYcKoC4HaqNyNa29Dn6W0SafLk8Ce5fG6tNFdou9+ToLGc?=
 =?us-ascii?Q?fLRKdfKzsJBM5T3BeAgBmtbFLqcWl2PyfrHhXobb56ug6Wcf3TsqRocpq3qc?=
 =?us-ascii?Q?5MHQ7UwPEr9EDptqu72HunnWYabzlh2fqx1Oq47Higs6g0XCc1ciiIAGJQ1Y?=
 =?us-ascii?Q?sh/PxCfhdKD+q/wkBuiL4yE/5+enZk8E8Xqw7EEf0xkXix4MGNIM44mAXVFR?=
 =?us-ascii?Q?+THwEv3mbBmWoWqCJJikwBns1U5LBidB5zuaErSg3JeB5ejEv7CfL1jbsiXj?=
 =?us-ascii?Q?QCgdouW1n11o2J8ixPXEzrOAaeB2hKqSiKfJCYKcLEo13bLuAaDV2qOESW17?=
 =?us-ascii?Q?1ybUt4tTzmE68dUMlnKvMunna9nAmy9KPs8m435n6/GrM2ZrCbx7UCrhJJFE?=
 =?us-ascii?Q?pTNDWzj3TkrP5bB+zFt4431KsERk8C8si7NYz+F/FVuHkNZCYIIqFrJROpnW?=
 =?us-ascii?Q?cSianWAYDjF/DVVwf5rMNP6EFWdhJCF9z6T6EHksG4DNU5AoTdXw+bowoOKk?=
 =?us-ascii?Q?Bk/Yz3XP3S4RvABJZ1CMACUF3HBxm2xPl6HAW3cAM2Jbc3QOBj9WwyDdEwaE?=
 =?us-ascii?Q?qUdakuGeNgln7uhdF6yAjFsBomW2EfCAWJX6EEYfNLd+BGzsUMTCTBjjMwSx?=
 =?us-ascii?Q?v3ieWCHdivunjfU1pTY038WOFngDac2t4vZlM6mWL7gfr1MXNFQYcAeY7A85?=
 =?us-ascii?Q?jz/E3Rkwu/Y5gkradbpmsnSYJ2jvtDUY1swTKFnTPbji9rfZs6HsEvU03ufA?=
 =?us-ascii?Q?0DS6Vn9+kwHZeYvtmv1pdiR+CsUZ1SgQRov/wDN321xKvei8qwr4ZKfaglzP?=
 =?us-ascii?Q?nBh8uuDQbxqsHQXsh2Q4lT2cbWAryx8UZvPZQ3+qFG32zfKzPTFl0EepvZ4p?=
 =?us-ascii?Q?p6ecrxH9F4S3aMPerq79o5cPC7QFcwLpdWPK0cJ+ovai1u4JVZ+PsN3bFHLL?=
 =?us-ascii?Q?QFPXgWnSm5Noqw9ztQAe0gRVfXHlvVBH3ZI2ZX+cEH9sjaguj4Bcy6gdxjLL?=
 =?us-ascii?Q?gMhoOvZMlLd8M+PrgT9FaXi5eMH+zZZDxYYFYaitdt1/ctWAkE3wuu8iwcKo?=
 =?us-ascii?Q?+lEvjisXdjhiOacx74KaUkkUzFqNArfNDp+ygN7K?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 470673d6-267c-41af-f3e0-08dbf67dc82b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 17:07:16.2747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdM9Esu3sM9WKT/5C7cQINGq6W6yWR6hHJfmS2wrWA0TXlnp7n1ujW3PvA//TGGy0oYcZqXVFkiw1o1NpUmAaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9253

On Wed, Dec 06, 2023 at 10:59:53AM -0600, Bjorn Helgaas wrote:
> On Wed, Dec 06, 2023 at 11:50:16AM -0500, Frank Li wrote:
> > On Wed, Dec 06, 2023 at 10:36:56AM -0600, Bjorn Helgaas wrote:
> > > In subject, maybe you mean "Use 'linux,pci-domain' as slot ID"?
> > > "Using" is the wrong verb form here.
> > > 
> > > On Wed, Dec 06, 2023 at 10:58:58AM -0500, Frank Li wrote:
> > > > Avoid use get slot id by compared with register physical address. If there
> > > > are more than 2 slots, compared logic will become complex.
> > > 
> > > But this doesn't say anything about "linux,pci-domain", and I don't
> > > see anything about a register physical address in the patch.
> > > 
> > > Maybe this commit log was meant for a different patch?  I'm confused.
> > > 
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  drivers/pci/controller/dwc/pci-imx6.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > > > index 62d77fabd82a..239ef439ba70 100644
> > > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > > @@ -33,6 +33,7 @@
> > > >  #include <linux/pm_domain.h>
> > > >  #include <linux/pm_runtime.h>
> > > >  
> > > > +#include "../../pci.h"
> > > >  #include "pcie-designware.h"
> > > >  
> > > >  #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
> > > > @@ -1333,6 +1334,11 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> > > >  					     "Failed to get PCIEPHY reset control\n");
> > > >  	}
> > > >  
> > > > +	/* Using linux,pci-domain as PCI slot id */
> > > > +	imx6_pcie->controller_id = of_get_pci_domain_nr(node);
> > > > +	if (imx6_pcie->controller_id)
> > > > +		imx6_pcie->controller_id = 0;
> > > 
> > > I don't understand what this is doing.  It looks the same as just:
> > 
> > Good capture. It should be 
> > if (imx6_pcie->controller_id < 0)
> > 	imx6_pcie->controller_id = 0;
> > 
> > for only one PCI controller case. I just tested first one slot before send
> > patch, so not met problem.
> > 
> > Previously, we use below logic
> > 	if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> > 		imx6_pcie->controller_id = 1;
> > 
> > It is not good to depend on register's base address. If there are 3
> > controllers, check logic will becomoe ugly.
> 
> Makes sense.  If the previous code depended on the base address, this
> patch would make more sense if it contained both the addition of the
> of_get_pci_domain_nr() call and the removal of the base address code.

Remove base address code will block existed functions. My plan is
1. this patch upstreamed
2. related dts add linux,pci-domain.
3. removed base address compare code.

Frank

> 
> > > Maybe this is a typo?  As written, it doesn't look like there's any
> > > point in calling of_get_pci_domain_nr().
> > > 
> > > >  	switch (imx6_pcie->drvdata->variant) {
> > > >  	case IMX7D:
> > > >  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> > > > -- 
> > > > 2.34.1
> > > > 

