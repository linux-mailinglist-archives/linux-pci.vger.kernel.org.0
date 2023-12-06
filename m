Return-Path: <linux-pci+bounces-589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE3F8075C1
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 17:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36DBD281248
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 16:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1E11FBC;
	Wed,  6 Dec 2023 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gj2UwubN"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2059.outbound.protection.outlook.com [40.107.8.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9D5D4D;
	Wed,  6 Dec 2023 08:50:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4nWo0DI4k1MIcHkHjKXZY+iL78HmqEJNV7/07USgGYbhsFM6OoU1Tro4XLvIpAeL5xymxMXbRRdu7ZvaufU8PaSRcVXKPt5CTl+0d3KMKWkXDcLjHLb1QXsFGK+4Y9Rn9ZGwURebF+I+Isq3f3u+nUk6QiOWgURdiwybc2iuTPmmudCHmpi/KxDxO9zEdhZj383dU1PTXtAOlelPavw7GGHoYKj0BrQbaQJFQNC+UbLxu0HTbhXNfjR8rvxdhXq3FPCiWOaRvjMsdNHH1d6mEehi/hnWZcUMA+LFyl0LCxd2eC0tcAS3YaxRnvkBWpkT5k5+gVuRoC7q/FjzucAVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcYl67cpPl+YCSp3q/YiBjuzK12owfdEkWzGs1XFa94=;
 b=mCy3/usZS/DsE+X6ILlfFdsOK9Wf7v9uqzncsBzim365Cee+ogMyhnu/RLsMOwi4RpkQn+L1Ix+JGQEOaz+Ev9y+Oc+Y78c41oXJPhvpIWQlfKXCzNENeKBeBt5HHSgm6eBRmVxCiIAA2mSpxl5XfajTNUeR6YVxn8xTUUY73nhPV6lD4ccVDFNSX9l7X0IfCcHFUs0Bkg8N8fSmHni9RxO7Ui6Isukv8j3n31gesmYuLl/704m5neY7pdsJmHcvHwZa28EX9hyQhcdwtZk/MjJ18mpNJJEnyIj4oQk2JuSAsfJCvllLHXx2Hc09eFHFPdvv16ra8AVHMVMuFsrITw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcYl67cpPl+YCSp3q/YiBjuzK12owfdEkWzGs1XFa94=;
 b=Gj2UwubNp5xsyjnspeyUay0ugElXJ4/frRJHijg2jjp5PVkQnZpPvK9XnWWV6zJiQSB5QVWed/4YcvHKdxFFmb/EmkYAri2vq/WgWbM7oy/5m2o6whv62ckNef3dy2S3G4WAEJlR1AZGQBzr5Hd9QKqAZCNF3FJDjHnwFMZygS4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9256.eurprd04.prod.outlook.com (2603:10a6:102:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Wed, 6 Dec
 2023 16:50:27 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.022; Wed, 6 Dec 2023
 16:50:27 +0000
Date: Wed, 6 Dec 2023 11:50:16 -0500
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
Message-ID: <ZXCmSOwTWR6AVpGB@lizhi-Precision-Tower-5810>
References: <20231206155903.566194-5-Frank.Li@nxp.com>
 <20231206163656.GA717052@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206163656.GA717052@bhelgaas>
X-ClientProxiedBy: SJ0PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::13) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: eb3f90e2-686b-4113-bc5a-08dbf67b7248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jjYTHhPvwvkfahko1XtIlHRcY/lL6ljKQxtvVAIKH5IwPiijAJKGndsmGd8bPkuum05Xd+gmINMwYNd0N3egHcYTKiQ9it7CLudh11HIP29esXLvdFb5xGq06flnBTaWmZwjd5UPR+XVVVnPgEqwDgtEB12EO+Me7mG07E5SW4GFZKx37vlwJJaGH3bghVltabLEk8w+98gvx7WQnpj3ZaRJEEXsBHg+xAhP5kKXmGjg+dai5KQKw6OVSYwYi1Uu1LGxLTdRcrEa07g6IHO10G8KN5XsapujBT9G3D9iltBC8UiXvFslky9HYzum6Gc2aTVYCBBWTp78jFxL3M3wPORKVwv5hTddUEqUusgFm7c8uM80yxlp+5vivDVyE5Xz3bvXFRKUQVnmU9evt5KvJW0NdK++DOmWaoHMprPuIPKbMehu2qJuoizfdr6DfmjUDVcKblmNBJfc2jKpekX2+O1mUJQrebdZmWzEnIchS7l3PURj1ieJeYUNw78RbWhVPnN3mkxj+EpfEAiWo53D1o+6/px6qoWc4bjBMPTAvDs77CvqiCf7jjPcVoczXdgqcIn/RjmIF4xfZwfr8QyzTWznNLPMres3D+G6+zFc/lc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(136003)(39860400002)(396003)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(33716001)(7416002)(38100700002)(38350700005)(5660300002)(2906002)(52116002)(6512007)(9686003)(6666004)(6506007)(26005)(6486002)(478600001)(41300700001)(316002)(6916009)(66946007)(54906003)(8676002)(66556008)(66476007)(8936002)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WjhjdBp1TIjcFHQneBxTkKOkjZXyRJ0yByLCXUJutuHsKELCvt23AdRBbtaA?=
 =?us-ascii?Q?TeS8H44L3qva6pzJk3aCf0ktJGUeZRtfl0d8AL5zoeLAGALcrfH/qfrRMn7Z?=
 =?us-ascii?Q?sIkVi//pkhcCaGA+b2T1zQOXYLKg4acLWPL2cnUVvoFhNojZKl0vcJQxHABl?=
 =?us-ascii?Q?TIygwD2OZWICKKTCvwEOWe9ZAkSHUZVFzz8lsQ26JvCTtrRQ48wQu3t14uEL?=
 =?us-ascii?Q?bmOOB9BdvsmgAyLeWIvkyNa7sK7ajhbvLVnyc6wScZ+t2f829hdtQIIC6p/L?=
 =?us-ascii?Q?J6BN9cQvK7fBOokxxzqI4DJDwkjdB2fauRPC53pYT+ebWPQpMQMarhybqgNG?=
 =?us-ascii?Q?yefVEVghcD5xVrzvrnGYkK5G40jweJWTQxCCYATyLWJqX1r6jfnUMtdIkGyn?=
 =?us-ascii?Q?TDxi12cljA8sH71obmyl368++KdxkzwaIZfLwrGUwEovxkSqkaXNOgWQlArK?=
 =?us-ascii?Q?x5hewAc3hXIzdHOoH12vWVUK88Yv7vJAPoFsmf9Bey/QDdY6Op+z5REie5Uu?=
 =?us-ascii?Q?N35vbvOz6zs19HGrLQvPLU7Ux2UI+mNweMcDZ3O9ho395cX+gA17EWkTOpNY?=
 =?us-ascii?Q?lExC5MGU6GvjgNPEAlKQyZGT3gB3WMO633vHRlsj36rtbZL11zb1Wbeu/JEc?=
 =?us-ascii?Q?YjVk2G/UuCabSmSXTYo+ggFUp6UXgCKkYod+8v3hq71+rcgDeEIiloA3gnye?=
 =?us-ascii?Q?G2M3nkzzpw5unF+fFQkyOj5R3MRQyvHSxOLSYykNjvLG6inBf9BdQZP7VlIT?=
 =?us-ascii?Q?s6IfrLqnSQzXW9NzcWyPbi816uX9/UOvRubj+xCZQ+ZiALNkVojpGuErJu/t?=
 =?us-ascii?Q?tm1JIhjUcD60NuZ5AtnAIO87RCfJ7ffBTwZ78F6ZG7i4eyuxsPSIkZllnolG?=
 =?us-ascii?Q?C4H4sv++RMb8B00HdO9s+wrglMajXnVLAHpi7BWSChhsLdxAYhmR1J/cTozJ?=
 =?us-ascii?Q?WuanTXyUfwUkMVFrGOj3DYAa4fq08yvUyrxPLo9w+L4EWsyj3kHXbafQXl9s?=
 =?us-ascii?Q?Lm/FNP2KhRRYF0mN7f0UnKf1wb3R8WZ1lIACxGxH0cLGcWrBuhPd+HzyBTdy?=
 =?us-ascii?Q?8Jn55SoxLAGU+cB5lnTXNG0C2l80PbZO01yybK4Flun9A8eg6lwDZA+fbKQS?=
 =?us-ascii?Q?tC3PQfGg+L21egJQ2Ru74ZvXIY2NhkvuelnoB/3jiLhq2y0zL9BUH/ZQemYV?=
 =?us-ascii?Q?jezxZAQWkIVyTUQRemGb4aNGu9SAYthlSp3S400Sll6Q+MeTDblt3pGBRxyS?=
 =?us-ascii?Q?dfnw7/hMKbFOYCazegamvdaNBGZc9K0Wrb2PGR6I9bePnKsnUqZcTS/q1Zu0?=
 =?us-ascii?Q?FR6oaa6cs++1LYEGzKlWHp7xYSxarHnigcK7ztQNeuFVYOZVf0XfRWmODjp2?=
 =?us-ascii?Q?JvjQ9v8ep89WrS3TFFoQxAVW97mpILvjrOVecqFfVvXQq26F0CAf+au4ihUo?=
 =?us-ascii?Q?muBIbRhYs9Zeg/d5TB0xwfk3V4546cxR7IEtpcRP6cAmYGq+y/y0vMoWcDwy?=
 =?us-ascii?Q?YQDHrX+oT1KOA5dxqgtbA6Sgc8WcD8YlZ7IbWoJPhcOIRys4VDffx2a7K3iY?=
 =?us-ascii?Q?jV7hRutPVXuSiZqH5Bc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3f90e2-686b-4113-bc5a-08dbf67b7248
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 16:50:26.5427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yme4eOKs1lPU5NWRe8cTTRzWNbJWStJ6c0zPvpe99hmlJ7x8uwlCs2I2mTOunvwd/VBqWoxi4kQF5RQV7JNR3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9256

On Wed, Dec 06, 2023 at 10:36:56AM -0600, Bjorn Helgaas wrote:
> In subject, maybe you mean "Use 'linux,pci-domain' as slot ID"?
> "Using" is the wrong verb form here.
> 
> On Wed, Dec 06, 2023 at 10:58:58AM -0500, Frank Li wrote:
> > Avoid use get slot id by compared with register physical address. If there
> > are more than 2 slots, compared logic will become complex.
> 
> But this doesn't say anything about "linux,pci-domain", and I don't
> see anything about a register physical address in the patch.
> 
> Maybe this commit log was meant for a different patch?  I'm confused.
> 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 62d77fabd82a..239ef439ba70 100644
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
> > @@ -1333,6 +1334,11 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >  					     "Failed to get PCIEPHY reset control\n");
> >  	}
> >  
> > +	/* Using linux,pci-domain as PCI slot id */
> > +	imx6_pcie->controller_id = of_get_pci_domain_nr(node);
> > +	if (imx6_pcie->controller_id)
> > +		imx6_pcie->controller_id = 0;
> 
> I don't understand what this is doing.  It looks the same as just:

Good capture. It should be 
if (imx6_pcie->controller_id < 0)
	imx6_pcie->controller_id = 0;

for only one PCI controller case. I just tested first one slot before send
patch, so not met problem.

Previously, we use below logic
	if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
		imx6_pcie->controller_id = 1;

It is not good to depend on register's base address. If there are 3
controllers, check logic will becomoe ugly.

Frank
> 
>   imx6_pcie->controller_id = 0;
> 
> Maybe this is a typo?  As written, it doesn't look like there's any
> point in calling of_get_pci_domain_nr().
> 
> >  	switch (imx6_pcie->drvdata->variant) {
> >  	case IMX7D:
> >  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> > -- 
> > 2.34.1
> > 

