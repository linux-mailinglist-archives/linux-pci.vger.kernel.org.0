Return-Path: <linux-pci+bounces-3108-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2583984A118
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 18:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49EB81C20B68
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 17:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767A2446D7;
	Mon,  5 Feb 2024 17:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ESDTy84m"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909DF47F55;
	Mon,  5 Feb 2024 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154889; cv=fail; b=JAVc9+SZqd9u5JzBqhFMof44Jvr0MsrdVG8A7VZSN7ZVSkyk8FlBKfr+g6TUfjwzWPt46Ha0k0Sspc/ab3pAyS1aeGlUdYJBvXBL/8OMOjNDsG+xM+9cKp84ak81k38xRVpA9KHss83+KCVYsx34ybZsUdREzhUMIDI9I3waUpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154889; c=relaxed/simple;
	bh=e19/bwEU+A0pVA6HQnefuPKan8DKIo1roohKxF3Sjm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z7EwOIjhJPmz9h4N3+P+6OwUz5+DOI6p2Sq4opgQl51/TGfbm04lRh3Az2obUaA0nM4uXpZ9ATkEUNHG4Ff4FH1lU7h8Il2VMxPaQ6O/r8Uf4FM0OmVSGz3p70h/v1tNZiUcdRoMIrOcFnphOD1eGjy1QRudVzAYS73JVdI0sVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ESDTy84m; arc=fail smtp.client-ip=40.107.104.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOGwCYjt8GHND7Pv3KrBC2gBkSXPz6Th4w61Zljc2G7zMzLnuvEdXPZw9stoGvShdFEus2KXhiQ1k6RHQJYpCfMQ7kPv2ekpyjMq0vVfqOWNO+Ltrdw4WNk217/DBCw2Le/t3QdXC29IGWLG1wvjNctG1fXQZaPuSVT4ocxIZBEO0rmVMUFodVmclbyimo6vr26+NF3k1GFeKKFWOBaOEIUcexOErXgyZlIDOL/mCNmj9YmEw93mNuQFsjGR5xb5z+zesdRZYBSWkN2RE7uWBg4+gvUncsP1Zr5xUgDwWgWDU/RA0zC2KQMdVWWu8DgHv6dTqPSmqbuI2ETyo3ZrLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hx3P+v2Ys/KXxiFtArDpBel0jQj9szRDOd+fDMgPmMQ=;
 b=MrVd1LQXXIKDZ9AAnFpjnjgV7tXeqfIHa25vsTDfbQIpeaOAbmk3AgQgm9it158pCNhggcQsN8JoWsA5dM3GMu4WtU8i+BAIqNbWeyhFSJkVzXk+LWORuerMvP5rG5JSMwup4Jp1sHNfjFdNWXtAEubDCtiTAZuE7bhT81am7L7JYKJhq75jqLv/BDT07YQLk02wgEVk3Hx7jnthm1CGDuyuM4yAUz3RWu0zDiy2hQMdVV1fkVjXfVyVEl8c5aKDKjbeU3vY5VRWAZjieBiwFiM3oVNolGuK7++jITulUv+Zm89UunLes+omi53j2NvP2s40hZLQw56lGvKiNhA5UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hx3P+v2Ys/KXxiFtArDpBel0jQj9szRDOd+fDMgPmMQ=;
 b=ESDTy84m6VM/4f6LMqdOA1cL5M6+gP3YRFC6Vf6dCPlP6WuIZqLhwfv2Cr0tbES/FVC3zpTzvnSREc2PcWCYk/8YjD8oTduDDxDtaTBlkH6HiQMu9XGguSEeaBuPQTNnZLk5WcfA7YsmYzo0TV/fkibnvT+roxmL5VAHf0dMGxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7733.eurprd04.prod.outlook.com (2603:10a6:20b:288::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 17:41:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 17:41:25 +0000
Date: Mon, 5 Feb 2024 12:41:15 -0500
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
Message-ID: <ZcEdu9Jw1k6Kwuz4@lizhi-Precision-Tower-5810>
References: <20240119171122.3057511-1-Frank.Li@nxp.com>
 <20240119171122.3057511-6-Frank.Li@nxp.com>
 <ZbzcOarorCS1MPRc@lpieralisi>
 <ZbztZkNQ+wydticD@lizhi-Precision-Tower-5810>
 <Zb06JL5X8EiHEyFD@lpieralisi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zb06JL5X8EiHEyFD@lpieralisi>
X-ClientProxiedBy: SJ0PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f5e9413-a3d7-46d1-c2c9-08dc2671ac91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e3VVFnKd36LuIY8J8bQceUWfIHWik4cGemaCxJQfs/1EQmot6iJijMHH1/zC9+EgWmIfuFAErxpZAuZ/u3XCy/+9ist0jCX6KjUl4yCHovvV0KBbRnLNyXngTOIzeztAAf1M65Q09ufIkSDVpLntY3EVXJtkk4jBfV7OvSSES7iyW01gSYmQbC1qqHdBWQ7+Jj7gnKzmuRljpr1ocB9gSdI2gN9s+JmtuQHZ60L5N3rPOhbthJO2kQYZRrhPaWnGR5ro7g+E9B+wn063PEZwDBwyBgYRBr09Ulu6nkbbOrKSHmI0rPEcCe+aZMcZr3rD2DhLFDYRm03LqICT4CIkly0LT30EOJT3ji5uPDcBe0KmKpY0Q56UgtgqbrZNqZOdAUZLov4e5/WxjOiHvMS5McYUH6gOw5wdJyfiKSxCAO3kc9J42LTFq+bQgFTZuGN8AX66+GvrwPUFg/lS/VDMfJuaEsRgseUZKeDgEHIdO0gRqhjEOKuoXahLKD5HmWVwLyl8rXGoxwRGz6EXTXbeGOepimKA9YZT9h8GsC0G8NkCvRSgMVD7jtuxPAROYTipdxoTdUJXCQbRAkmLMDYul64+R28YOWDbyMAw9rANVbg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(38100700002)(33716001)(41300700001)(66556008)(9686003)(66946007)(6666004)(478600001)(966005)(6486002)(6512007)(52116002)(6506007)(2906002)(26005)(4326008)(8676002)(6916009)(316002)(8936002)(86362001)(7416002)(66476007)(5660300002)(83380400001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3XUGtfnxay9DDCW85AUdL5RTKuZyVWyXw11gsweQ4jp4wm7nGKxIjdD8IplJ?=
 =?us-ascii?Q?SZqItA+mUd3mMYUf4m1+uL0MqBy6KYzCjRJ6GHVJishb+Amx8ozft5dUCemc?=
 =?us-ascii?Q?znOmr1K0TU2NidIjPCFJrSdf0mDbHHNhd45fr8jBI8mATZ6lZoqx0WvWUX6r?=
 =?us-ascii?Q?GSpDcP1eodpsjPn1R3GE1Xpnb+znNTNwen6uGZTCxwsAl7Yjj9lhA2pthHNU?=
 =?us-ascii?Q?dvJCAHL4vNCx0+v98zvvzSqbTdl1f38lKYAl4ZNSya+dqGq9MYllITfLdgYT?=
 =?us-ascii?Q?nKBCAGOUGbpAO4oX+1eXFYBZLFMJjSa5zPU+89KjfSnOef/+W47dofY3WI9K?=
 =?us-ascii?Q?poQTIYsogLdERCGkJhyhQcbdzaM3GatlAi/Zx6qesMx1V4PstDUj2uHhdSEn?=
 =?us-ascii?Q?M/KqHJvkJHvpDcz8n86NTyhMZho9G/OIq8MtkSMT075uBFTHIvSRhU+a7sCT?=
 =?us-ascii?Q?GndVIlRxVWhdYE1HUuZpZcgo1PY2L7ozLUOBbSeRXdImADxnx/a0tZEFBKdX?=
 =?us-ascii?Q?hXlU90b37WcAoqNYp/JR28CKYUUjG9OEn7Bv5PVEkpyDwfNE2E3ffYOT+ZzT?=
 =?us-ascii?Q?ekTki+hN38FOiEP5kx5lyh2FkDInCtJw5FYROS7Rxjee/OYBa/LbnHY/gPdV?=
 =?us-ascii?Q?WlqaRbz8eUMOGFA2UQSXSx1QCaUVDSNpooFRlNzAKKRxmxgKayHCHRK8T76Q?=
 =?us-ascii?Q?XkxFmiiREuwXYsbL1FQaOpqn5read+ZFiPlIE9BKar5JJRWbABXlyiHSTB66?=
 =?us-ascii?Q?nWsHEkUlihtuqne/mB4cVwsQBkpig2ba4NKAVeKTmilXbnBSYJAfFVUMUKqG?=
 =?us-ascii?Q?/y+bbjGzr30PgHiMa7MuQi/M1k6NpOrOE4x1oAnPjCbMOdZbysmQph3I6IMk?=
 =?us-ascii?Q?0aef/bkyqyunX1Y1K1W2u8/crxxmb6O0dCelmgmdvZ024pGkdRZhrLUY9sdI?=
 =?us-ascii?Q?P2X4nLgPScYX8WA0YGiQe7lnyg2VtmFEODNja3ZdDZkni2w+eAsX+mQ8LgCt?=
 =?us-ascii?Q?LWDrrzF2NdcSE7NL+yAshngpQ5/SGAxrRdKD3ebn6yzL0mMS97xowcuJZNep?=
 =?us-ascii?Q?bJQikO4ZvpXwJwG9cZhE1uc/pMbs8pBg3zerC0IoygmLKZYvXXhDYri9fYAd?=
 =?us-ascii?Q?c/aRCzoZUqZ3lWDO9RqKc4fWzyU/jaZzqsHRtGIFRnjkApxVgyUO1rGeTPOw?=
 =?us-ascii?Q?FvN3072xY3KXf8sS9qJbuQ/rx8ZNPrqJ8kADQrYqJm9AI4PHTBUkwt27O2Rf?=
 =?us-ascii?Q?z4KCV4NkN2BE6nuL6GNf+zZA0MFaTL6SfXtDIHhEvMzN/dqPGP0PeqFQE27t?=
 =?us-ascii?Q?qBei335CGryMlcOgwkV6rnXoA+RyAycMMae9iBefOJcb5VYhq0w9S/0lxdNr?=
 =?us-ascii?Q?4s3JGjM0C7MFTPnUzOwWw5BEf5oR20IXgzBG1IgSFGkfTe/fO0upFJ3i2ajy?=
 =?us-ascii?Q?Uv+3psFmfRyRTDpK+bBNYaJumya1S9HXJSWWRDXz90fe/17MmPiGCZnBejzS?=
 =?us-ascii?Q?VDNspNAdmNA5QGUvbIwon4mMk8eQPHXjxH0Y6hzAN/sKjdIK5F3fdtWx1jtt?=
 =?us-ascii?Q?pmFaxYLXwYCovn/4bxgzJlMQKsIuu+XARtihWjPO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5e9413-a3d7-46d1-c2c9-08dc2671ac91
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 17:41:24.9498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AXZDWo+JhIWHb/1FxB2Ix1vfu6we6pj0UEBoZq0ao4qI4tP9BD8RTMuSEHPG50yA8wru6BR8WXCZCZiOUxfoMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7733

On Fri, Feb 02, 2024 at 07:53:24PM +0100, Lorenzo Pieralisi wrote:
> On Fri, Feb 02, 2024 at 08:25:58AM -0500, Frank Li wrote:
> > On Fri, Feb 02, 2024 at 01:12:41PM +0100, Lorenzo Pieralisi wrote:
> > > "PCI: imx6: Use "linux,pci-domain" as slot ID"
> > > 
> > > On Fri, Jan 19, 2024 at 12:11:11PM -0500, Frank Li wrote:
> > > > Avoid use get slot id by compared with register physical address. If there
> > > > are more than 2 slots, compared logic will become complex.
> > > > 
> > > > "linux,pci-domain" already exist at dts since commit:
> > > > 	commit (c0b70f05c87f3b arm64: dts: imx8mq: use_dt_domains for pci node).
> > > > 
> > > > So it is safe to remove compare basic address code:
> > > > 	...
> > > > 	if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> > > > 		imx6_pcie->controller_id = 1;
> > > 
> > > No it is not unless you magically update all firmware out
> > > there in the field.
> > 
> > commit c0b70f05c87f3b09b391027c6f056d0facf331ef
> > Author:     Peng Fan <peng.fan@nxp.com>
> > AuthorDate: Fri Jan 15 11:26:57 2021 +0800
> > Commit:     Shawn Guo <shawnguo@kernel.org>
> > CommitDate: Fri Jan 29 14:46:28 2021 +0800
> > 
> > I am not sure if it is neccesary to compatible with 2 years ago's dts.
> > I think it may not boot at all with using 2 year agao dtb file directly.
> > 
> > Do you have other comments? I can remove it from this big patch series,
> 
> I will have a look at the full series first we can decide whether
> to drop it later.
> 
> I am travelling so I am not sure I can review it before February
> 12th, FYI.

Okay, I send v10 at
https://lore.kernel.org/imx/Zb06JL5X8EiHEyFD@lpieralisi/raw
which removed "linux,pci-domain" patches.

If you have more comments, please comment at v10 version.

Frank


> 
> Lorenzo

