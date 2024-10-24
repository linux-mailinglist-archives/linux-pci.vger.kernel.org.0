Return-Path: <linux-pci+bounces-15201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 066EA9AE8F8
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 16:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB941F23B1C
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 14:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4CD1E4110;
	Thu, 24 Oct 2024 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Edt7LwMl"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037121D5AD7;
	Thu, 24 Oct 2024 14:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780343; cv=fail; b=hSUCI7nDqGHukV/og3vccpJ16mrXwA1xSuDOPaHlfF8BK9p3H6hhvz57Gwkh8VKXNZ4uqlHXraokDkWyNHi1NsrNC8goXSyum1w2gQ9/LyPrnAVHKRglswRCOHS4CMKvooy3O3uKbTNXNGe3djcCUhoBeoeqhO2mJic1QW3+x4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780343; c=relaxed/simple;
	bh=oVTVJCsinDFUc/ibIOvgY+7QGQ1VlkPpgJOFTGD2T4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vFFk24WOS7V5+iezq4boyzDPug60h9rd8XDiWceeOKp2uJXGq9taLGfT5KLU23kUXqV4gJ8mEOh1lhEWFoofkzhEKA2mmr2ENJe9kaU4wO35k+5LtYYdPqt7Ga8GVTu3S/9C381JaEj0WKLCbjijZdi8li3jBBUdRhX6u3ecWr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Edt7LwMl; arc=fail smtp.client-ip=40.107.21.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lguWlbZij5JC8RwUCPLFypx9Goqonv7uOSUFUPslIKsFcjhvB3Eo0WpLaorQWvTCdVphBB2CjUF0TZDl/uRbsy5YpAhmAFdy8nK8JLw1xYmwqdlCZ+B/1Os6ML84sOidQVVdoHyiN99hhIHLqYqp2x8OZphVvI2Ut/406xHiGyLyfYLfyfVwGO89qddRfS/Ovpttt2cziGgGZqPY8wm2ptxPq5T4AW9VPjMz80SQ6Bs8duztOznIvlP6MCGh0gDT7aTdujRtNhlqGJDX/Ro9yAA7jgGOEVbGEgub1SsSxUB17UFYUgo73+XFRhdP30lFer8+MCx2IAjpupi45BnU7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jd8tz3D9o0UyUxSkVxSLmpvqo/s++Jb/DYkt2Ab6XcA=;
 b=ldEjKZ4Q8kpgiOUMOiHtT8MkO6ZNJy1ZM81qjPEMHJMfa6DvCUuBysIRh9lv5RYhWbpAFGM9sPiSvobZioPCQqtzHpbqQ361tw+JOUKW8oTJ6kjb/MjP9RvrKMnLMUrTMnHP3N2yrbGqHIllViRy848yTlFFbHOChHgYkswL1y+lql75omKs7IopJFtgiKA/YbXdRGOWbeOT8E50xYcjlWBlROXIgMace3Wsym+vou88ZBmjfYRRpy6PVcVY7tQcHsWomiMldnaZkeopDaSPPb+VGLssk/y7n5yaEnYBPPirkPGj9NLDPnHlXvcfYDgqrGqZNfOG89ESSM+1Yf0wxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jd8tz3D9o0UyUxSkVxSLmpvqo/s++Jb/DYkt2Ab6XcA=;
 b=Edt7LwMlJrjI4deyUUtru5aaYNYvWPmwvgOpcFCQ+AcZNe7NztqRMXr+b1vb14GC7IITLWyj4jkfE49Vyu/KNma3V+xYzdyyuGava/+6YT7xzAJOzZ8XJ4H4yuYkcw4+3XvvKSF5gkoQJM/V0e6wMkWJpd773T39qSM0AAWLTJsWI262OgFOV0BllNLMZ2OIKiD+tnBXAsNZ9O8bKZBBYSl8o7e0APkvKzIZpoOcXigO528WCIJehZf9ry9KK3fobrKnGfcqq62eAbaxy1ubZCgzKI5ozN7G5GNvTaEco/z/jv4fypAz7AuEr5MWdwzJ7qRcclHl7E3wpt7d+F4alw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB7741.eurprd04.prod.outlook.com (2603:10a6:102:c6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Thu, 24 Oct
 2024 14:32:18 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 14:32:18 +0000
Date: Thu, 24 Oct 2024 17:32:14 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Frank Li <frank.li@nxp.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH v4 net-next 03/13] dt-bindings: net: add bindings for
 NETC blocks control
Message-ID: <20241024143214.qhsxghepykrxbiyk@skbuf>
References: <20241022055223.382277-1-wei.fang@nxp.com>
 <20241022055223.382277-4-wei.fang@nxp.com>
 <xx4l4bs4iqmtgafs63ly2labvqzul2a7wkpyvxkbde257hfgs2@xgfs57rcdsk6>
 <PAXPR04MB851034FDAC4E63F1866356B4884D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB851034FDAC4E63F1866356B4884D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: BE1P281CA0193.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8d::13) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 12e8b853-b1fb-48f7-8f35-08dcf438a97d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OyPVzSxQFjv/NnEPkgAn23FI5SOdyRJr6jDPsQAFByc9GOFs1l0sJhcnJGki?=
 =?us-ascii?Q?j7XgF4VXwc8GfvNqvifuxS0pgCK86flptz62+IMdTBjzODLhc7Y2Tw1AAf3v?=
 =?us-ascii?Q?D1VxP6ct+R//ILYoMfHej2CwXs9h5z7DpzC+0OfUXvMKoUC6sTmgQLte3OVK?=
 =?us-ascii?Q?iRUpiIi267Vu75TOEh1U4SjxyN891nDUUM2Nrr3/DrUl5dqdzdflWMJoofD2?=
 =?us-ascii?Q?Huo5E5WUfsF+w0bxPdKOyXY2gl1qFE+/PMRisl8sX/pwVNjDbPfp6xBVxE0Q?=
 =?us-ascii?Q?wUEdp0vck0zZc3P50qLw0lXmJ0PQvJo0/DQ5CzZYf9W7xnOwpG9JCCzBMm3S?=
 =?us-ascii?Q?z39VuwFERdnpRA5bmcuzuPA05U0mRh/3ZnamIKhrzzznSOlfMs/0JrzDXxv7?=
 =?us-ascii?Q?lrXyKiLTH2IQHyYjgq0ulC5OhpOWiXyk+qQN5wdZlb6ZW6d4mCWV2UPBzYul?=
 =?us-ascii?Q?CBX9NYwZUMLQiWPyYXUnpd5gZR+jkcNRYTUkeLoJIrWIw8b8+3iDN6Lns1pP?=
 =?us-ascii?Q?21Zl3OXDckk8sqfZ7KqXY2mw1hrLWuLfvJO99ngmoPloTfPpylJ3HOXng0n3?=
 =?us-ascii?Q?0REMRSBRufMP29ntIV4aOhgq/br1PVA17wpKfvQanALUhL1UtAfoW94vyrEt?=
 =?us-ascii?Q?xWCf24bVnvRX7E0gXnUrRZc1cVwhux30B7n9aLy/mZQq0MLdz6fSHizyDo4x?=
 =?us-ascii?Q?gTn5DiGmHCBdGjDLj7IP9gaHOdZalZUpXE4gIwbi591WX5JrVHI80b/SqHAj?=
 =?us-ascii?Q?GL+TPZTz2WOushiKC2JVbH7LtN+FsvkhQkw9jwrgZL0XEfLE8ds9/HcbnxSw?=
 =?us-ascii?Q?jiMJijHGfVeDKHcEDCKatvxJH0J3GD4/1ZhHG0oFfCBxduPZh1LjmjeXOiJb?=
 =?us-ascii?Q?78gxkmVrDDR70zKrhvOJa7ns/GTMo/88+PlpKYoQjS0TlT9ndKy2PkXa5ppi?=
 =?us-ascii?Q?jX3cWmvd8ISMEmz4ZGMG/Ko4RiIrTGLkMu3skAiRJ6HqGiRQUreG/6eam+34?=
 =?us-ascii?Q?N/C/3y6musnJyKf+2FTEYZ8cpqNr1mY59YAM07VC2f9VkZrLg2HBJjAqX5aq?=
 =?us-ascii?Q?SliuQMK2Nz76GpADfQM7MxIix8mHDh0L2mmIqLU8qyVr92LyZkQtJZHF/nIF?=
 =?us-ascii?Q?F4/sQkXK5LMPEg9a3CNE4d4lyDv1EKnVJTwRjDd91qOeNi4xKUA/ETZVTj33?=
 =?us-ascii?Q?KjbriGRjYbJ2CGSTJXXQBsgF+1Yv/ARNF4Hzr8yPOiQtqCiL7kNxkMgMutga?=
 =?us-ascii?Q?6kLP+xOUmc+Nh7gbNdeMJ7CmMyi0O+yrCdokyfMfDqZKSGVVvawRTjNDf6tw?=
 =?us-ascii?Q?151FhxAqs4uq3I1oXA3MgrK/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tafOzX9yeLMHciFyDPPUCtS3NsmYdsbY2gwmwJYvCcemz/JsyXdXADbKQOLA?=
 =?us-ascii?Q?BKFn6gkgnYDI2r7sPZ7i61ZysBrjrTfW6cEC8OdNxwzghGuvQyI+dpt4JVrR?=
 =?us-ascii?Q?kuNJzIcDk9YOsdw7aIItp/KmZR7cwchPhd0edRl9bHKOunBIb2qTvJGjWyF/?=
 =?us-ascii?Q?vp9oXT8ng5oydTyogIkPmDJy3pcnAyP3Up24CYXP8XhDkIeqZMQy1qZjARn1?=
 =?us-ascii?Q?2czt/LkUheRvomI+AVvzMy1CORuOEvlSsPN626vRwAOd6S5wAHWdaNGRiK2H?=
 =?us-ascii?Q?y1A9J7eM4agORPGsXgXCcYJZFkZP/IxtoA86Y5xPMwIpGnyq1NnOYbUhfhXc?=
 =?us-ascii?Q?LVtmxsplbbz7CPiiwKhFMQ0DXPHkh6mq96bDIqkt2ZQj7w1nlVvvCV5DlVGQ?=
 =?us-ascii?Q?qTCV6Nzc2BOP8dHcCJ/X0ACwWSwyh7fRRRFSSreUQbwisSPIFUUWLUUYoO+a?=
 =?us-ascii?Q?miU5J8nj/bqa4jpASh6R9IbXsePOJXCWqmIN5CU7MiB4IXB7uxQv+vgd5ByV?=
 =?us-ascii?Q?KFN4rseBz0NEJRWw9xCyAYceNSCNL9DQUQot/BMaYsoNlEdS8kUzqAkOhTdT?=
 =?us-ascii?Q?VTFUApah4JeJkm0IU0Dc9dIMjPbsJUVcZCkpjaxvNmTeEPvhM70S0hhQPJPY?=
 =?us-ascii?Q?v81bKGDOZvaNhOCxXrxn2zlR5AQ8UFeY3PEfpr0UvPjfQJrBKv4T9Vft6bDf?=
 =?us-ascii?Q?c0Bey0lilzvQF0Hu2r13pL7lu4xvEc319myl6tNlZ28yneRLSDUYqWr5YPpf?=
 =?us-ascii?Q?r+YzfysdsLoNe7ePCCyi2xFXFecWZjnmF2r7dwphKHpnIN+pwmXl0M83Nlzi?=
 =?us-ascii?Q?XnN73fhqD8G+ShDr8LMA3aJNiYxReXt2X4DuN1nNErJXxCuki9JtetFl1Mpc?=
 =?us-ascii?Q?m9qAdsrpkYaGn+g4Vlwc5drtOKohPzvkLKpnPKNDxAfxAchMohztBp5vSCRR?=
 =?us-ascii?Q?4Z8bsXj0ro3jopnn8mP/IZ0OafKg02JzL4SxBFzQgNJ7u/H8Dhy8xMuyzWa1?=
 =?us-ascii?Q?8n63B1Yyt7gzpkc6Y0ZOvDa5G9C2WMMKTndJLIy4ACmXVL+iBZhqSiK75Hyi?=
 =?us-ascii?Q?jF+jA+GL65PoTuoCS87ZbFbrXvy4qmtrDyMTGVmaAlYFlXX86BNUn3MvTtxw?=
 =?us-ascii?Q?5UaUBegyi3vF/DvD7K0wUgzicgXRlwKRYxcUpEa0BTT4giHIpF+tYlnTHFbC?=
 =?us-ascii?Q?GmVrFpx9lrg/aG4VCsqbD5o1cEsf2DT1mBvYo29SSuzCo3M1fqFlhs4jJy7L?=
 =?us-ascii?Q?XQycjb7XMeK9YxWllX1nOu5o32llxqN8iZ2mnw7N9Whsbt4s86CYYOXiQo/C?=
 =?us-ascii?Q?UathnXzLMyjoBiyuHmuS0QUEJnz2bbBn6FG1Mqpd/45H2GGcuPPBYCo3ohbx?=
 =?us-ascii?Q?IFx/RR3f/qAJzhF+bdTTiks9VqtlikQqnYSwaRwVV5s+lBgfg1Pllxj4LV0F?=
 =?us-ascii?Q?Y5U5841lowyVxpP1VNrlZFhPe6nwOa1bKYWnuwjvsfUbok0ck+cv2ERnGFK0?=
 =?us-ascii?Q?GFhzFwFKW1y8MyaaAq1fDe5PPNso96neXx4gh1OB1H9v4Qa71uQvrxB0FvVC?=
 =?us-ascii?Q?ZIvJJbMkMEkSEIji77JQWEcSvSfCAmMV9YHA5tmU/dqbKfyBBROfAGN5jYfe?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e8b853-b1fb-48f7-8f35-08dcf438a97d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 14:32:17.9660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 182u9pEIP20807ZvlIuTdliem1U6QT6bW2rnMjC17YpzsMycWVOT3RA3k7RNG7dORFjK2FgQVTa1cY/lDF/zTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7741

On Wed, Oct 23, 2024 at 11:18:43AM +0300, Wei Fang wrote:
> > > +maintainers:
> > > +  - Wei Fang <wei.fang@nxp.com>
> > > +  - Clark Wang <xiaoning.wang@nxp.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - nxp,imx95-netc-blk-ctrl
> > > +
> > > +  reg:
> > > +    minItems: 2
> > > +    maxItems: 3
> > 
> > You have one device, why this is flexible? Device either has exactly 2
> > or exactly 3 IO spaces, not both depending on the context.
> > 
> 
> There are three register blocks, IERB and PRB are inside NETC IP, but NETCMIX
> is outside NETC. There are dependencies between these three blocks, so it is
> better to configure them in one driver. But for other platforms like S32, it does
> not have NETCMIX, so NETCMIX is optional.

Looking at this patch (in v5), I was confused as to why you've made pcie@4cb00000
a child of system-controller@4cde0000, when there's no obvious parent/child
relationship between them (the ECAM node is not even within the same address
space as the "system-controller@4cde0000" address space, and it's not
even clear what the "system-controller@4cde0000" node _represents_:

examples:
  - |
    bus {
        #address-cells = <2>;
        #size-cells = <2>;

        system-controller@4cde0000 {
            compatible = "nxp,imx95-netc-blk-ctrl";
            reg = <0x0 0x4cde0000 0x0 0x10000>,
                  <0x0 0x4cdf0000 0x0 0x10000>,
                  <0x0 0x4c81000c 0x0 0x18>;
            reg-names = "ierb", "prb", "netcmix";
            #address-cells = <2>;
            #size-cells = <2>;
            ranges;
            clocks = <&scmi_clk 98>;
            clock-names = "ipg";
            power-domains = <&scmi_devpd 18>;

            pcie@4cb00000 {
                compatible = "pci-host-ecam-generic";
                reg = <0x0 0x4cb00000 0x0 0x100000>;
                #address-cells = <3>;
                #size-cells = <2>;
                device_type = "pci";
                bus-range = <0x1 0x1>;
                ranges = <0x82000000 0x0 0x4cce0000  0x0 0x4cce0000  0x0 0x20000
                          0xc2000000 0x0 0x4cd10000  0x0 0x4cd10000  0x0 0x10000>;

But then I saw your response, and I think your response answers my confusion.
The "system-controller@4cde0000" node doesn't represent anything in and
of itself, it is just a container to make the implementation easier.

The Linux driver treatment should not have a definitive say in the device tree bindings.
To solve the dependencies problem, you have options such as the component API at
your disposal to have a "component master" driver which waits until all its
components have probed.

But if the IERB, PRB and NETCMIX are separate register blocks, they should have
separate OF nodes under their respective buses, and the ECAM should be on the same
level. You should describe the hierarchy from the perspective of the SoC address
space, and not abuse the "ranges" property here.

