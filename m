Return-Path: <linux-pci+bounces-2889-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7789844379
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 16:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F277284562
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 15:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E070F129A9C;
	Wed, 31 Jan 2024 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mc6aTbnS"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2064.outbound.protection.outlook.com [40.107.249.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55A380BEF;
	Wed, 31 Jan 2024 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716573; cv=fail; b=R6fSu/Px58+YNp7Wque800HIZ4UIGCDjTpwZl5K3y/B/zqI9jZ+dj3FnFU+flRNtJqBHefdb3eG5v2VkwvObWJvXVsOxnbQRet46ZJgAvWA3VdSXsCUK6x/wOx5ERhS0/57bEPqTer2ItGGp3UpkPIdaWhtrfGUCCmYsC7FEzSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716573; c=relaxed/simple;
	bh=1Pjp0U274HP7OUSEEbrhBv+0gckythleXzbkj1ArHOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QlCB0q1MOctyI5HR+OmixzaS+4KNXI7+xBHSUXs5dgGbbkFKNj0B1GAsSuBDqsxxFCu8rZX5IeTW3HYL+3jO96NkAveTKmD3BZYs1RxB1kNZ4uZm1QpDZmqX/6fM9B6cW1rOvkq8JYaQ5A+gf/gAch9+sM+eVK1sESJftLJ8TYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mc6aTbnS; arc=fail smtp.client-ip=40.107.249.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfyIh6F8XFONqM/1OjfiLZJKOBORJEXjczTjzSowDakoWPUYEGzFvYqJ3j9f/NvoI5eQ0/ntIuSrHV4GX1xPgVpGfuYvMmgBhJJ9Glg37KXAQOZ48lfu6ZvYGSAOiFY6EapLm0oEQNjnswHERFHTFKHcsxSFs+05TEVxPIXay7owOLVxMN6exaRViUtx2iD1jXRkEHIHO5Dcbb2mCN+L0zodrbZOZECuCrtS6ajY9c3V9gHrzJh/bpG5O2cG6ejOw0Pagp1gMjL9LrvBWa/46SGju4wBeWJv7ZKvFNZdvxaZvZZG9Y6cDuDcVt93TrhdXOdVMxcat7/H19T4794iKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8gkpSHpzPOLieP0JooUUedzoYAkEP7V1sPYhqAU0xA=;
 b=QJ7475/nnrM8HKML44zay4JWNbOF+8kjM0zyKHUf4WCL1FzGAeQkSf8aSy722Vj3/jimUJWu0czf87/dYq7OxqrsGXenu6xj1eYKghpaS0x+9+iA/rTA8dz9uhjUgA38lozg5HBDNc4Hs1w+T/HF/hs6QbV9lkJukZXG1ZKDh5pcK6bsndmKcD4HlPbg7sIBWDxt/wxy3kzzD84qS1tZROhtDXWzk7sFX+RSW/FmPllfnSTG1pO+ovnuxMPbNiU48n7koVYctPvIb6RLyohe0fExQINrBrxbhcn9eyRkzN53I7sMG8rlTaLYgjcLJcS+/cQjgzjzCwzeDnNCsb9PSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8gkpSHpzPOLieP0JooUUedzoYAkEP7V1sPYhqAU0xA=;
 b=mc6aTbnSotpTYUfcshQTWr3mKjPWKPvV9UuyrazorJIJzjhnmD7ta+4MpSkrl6mVT6UcEHl5SwbwllH3jZ/N4eEkrXaoisOEkXP4Y2aYhNWcoZA01DKRcKk1snABevITBUgDME6EuEvcSyVFY9mCmMWof9v+hmwOwQFTLThwrhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7262.eurprd04.prod.outlook.com (2603:10a6:800:1ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 15:56:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 15:56:08 +0000
Date: Wed, 31 Jan 2024 10:56:01 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH 2/6] PCI: dwc: Change arguments of
 dw_pcie_prog_outbound_atu()
Message-ID: <Zbptka6O7T1tdTuZ@lizhi-Precision-Tower-5810>
References: <20240130-pme_msg-v1-2-d52b0add5c7c@nxp.com>
 <20240131154115.GA587326@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131154115.GA587326@bhelgaas>
X-ClientProxiedBy: SJ0PR05CA0166.namprd05.prod.outlook.com
 (2603:10b6:a03:339::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7262:EE_
X-MS-Office365-Filtering-Correlation-Id: 626f9811-7dc8-40bf-3aad-08dc227523a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LJvbLZ9W5zP5/V65Xy80wESjA7hO5UKiod3CdURlnxm2EMroczj/cCM8VNLvAu8FMwCLn8AIH9gtkq/uipv81AoNXMHcLP2C3BOYNdi5yjnoruduVR7BboeN0IZD6H125iuNzcpDsmqReVus/2XcCe7pqJ3RRc6Lz91nCS4uH58IzsQiusS46CWUGbxrA+Zcn+ziuEmWxaq63xqy9GN/1UM7P2OUvdugkwiCwBQKN+uvbXydjk7XyYeH6eRZF4RMMJZYG2TcMLIDVZbEFHg5g138ONhZHGtOuVHn8JB59HzfWQLg4dQVpi6GwF7qKCmAljlPtbLPXhVkf7pqoVXIPQK9vXhMtHVUW5g7HbtBuOSEJmY1rhJXJZKX8udmqhAujDGS93FOS16SZfdcf34AcOuqZx5zGrfHomkjVjYui10s0Z1PxUiQsW74aTIFMmkg3sEFFUC2YcmNmJIHSHkLlvIj+3jqyppriRCsNLXYVT71pdaEbVBgG9wIX7SIdVVJF1RLsDR7ttlip0LZQd54Yb0OKYu+c7W4ChouIqU6IReC9UYhOLDhYRj6R7PNcEovOkQamxVwQQ9kvWBD7YfklNbgrz92Eh8AqyTOkv6F+2TlyfzriQzCAKI4AnIvphp6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(41300700001)(66946007)(5660300002)(8676002)(4326008)(8936002)(2906002)(7416002)(86362001)(66556008)(316002)(38350700005)(83380400001)(54906003)(6916009)(38100700002)(66476007)(6506007)(9686003)(6512007)(478600001)(6486002)(52116002)(6666004)(26005)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4oO1Tx9K7ty192MYZsOtiLU9oVCffK9t5OBr8DYWDS8UEc33XKvN/xp61I21?=
 =?us-ascii?Q?bN0ZtXKX3aEfYjrC88Qw2XTrugxD+PI4Xv43YohDEKILuDirqt45L6LDmpwl?=
 =?us-ascii?Q?seY0bFuBD7ihakT/X3H7Q0mCLewE3liB75Ok7JrkNCUYx4b0rvXXnQhBlBq+?=
 =?us-ascii?Q?3ff+vOz7BSBS+mkjL9zTEU+jU/mJhndSzt3tzBxWPbQ2mM9JgKhgSgkHb5AA?=
 =?us-ascii?Q?nlrYjlIcUk+gsKcw7EBG5OENRZuMb9D0XYM5UWrQn6CNaqh7HLUsAu4rJqzL?=
 =?us-ascii?Q?vfcmUJQN0NyFWL/i10ar4Qg0EKSd0/eoSdPgKIJLXLy8z8Fee/EjlzAnnGkd?=
 =?us-ascii?Q?Eo5OLTTICPZSa0sA+96BT/UArWB6ZI1m+wyDBdvLWH3lCjcJlLqh1VwXYZoF?=
 =?us-ascii?Q?vRztqXd5ulqb0OKnmt5VuzAnEzD3xusteSfgy/sRt1By/27w8PGdEPb+Szxx?=
 =?us-ascii?Q?qWEdEAx1nj6nO2E+i5YHp1XO3322oJt1Ubf7VIjcbYBa/OnaeqoZNY6777RB?=
 =?us-ascii?Q?8AnWsRqUiBAhNJp7eUbPJmxe18UuFD3yWMM5ICqWLyIVtu+pf4u67p9BHYkI?=
 =?us-ascii?Q?zjtuEWl0ucDMiTxDE0raY5OloFtwe1iiL8omrNhxFLfM8vi+m61Qwmc5gvIR?=
 =?us-ascii?Q?nckJblhHO7ZFXOIKsj19Eajocqlka/78k6CVahPNrOlDkJSw0JjypQVJQh4x?=
 =?us-ascii?Q?1hvlIKBbcZZoAsXkUaXeG6xU2qfdmhRVkTKTQCt1WJVhAei+x21OYOkk4nao?=
 =?us-ascii?Q?QqYF5FkI/2WjXsmt38yd9VW6odrLa/0169PjzHhgGSojTon8aENikDflLuF/?=
 =?us-ascii?Q?TozQ95Nb2Cx202bOb7+vpTZZX93EsMK7Hnuvx5wcU0Jf40i7UiAumqKGq5xA?=
 =?us-ascii?Q?dzAJaB43JWVAMm6v9r+FdQfZSG4gKnDuFUCz89BIHUqZ5xbW0QxrxzBJkMYs?=
 =?us-ascii?Q?9E/GNOg2DnEbkvxBW9SSRU4TEx8+bFELQFWwLMup0UOTX7m0S8SxR/RASpzv?=
 =?us-ascii?Q?T0wMUm3FBn0fNIbU4EcJ3jHfJpSz9s0TGOEoebGAHGx8xFmugv2xUJ9SXkIA?=
 =?us-ascii?Q?cm9fMNQoDQeC0zlkHHqqNp1phAVkGNJVaGEiuB4NYS8ATn1t8sp+MHLg/nKm?=
 =?us-ascii?Q?stBazi6OUIBTN7mK0XLEGGxYgNagFJuyUQzLdqarI0xa6o2BnJP+FZRDmwKt?=
 =?us-ascii?Q?Uz64ogZNtkxAcyhQDE3Jk4FlYYPOgKOsO/CbPOg5YWfpNAe+D6yLtsSCJY7z?=
 =?us-ascii?Q?7d8+CO7ND8gcuaKk5Wb7i4XLkZjWYGl3aEsU7ShPaq5BtiDBhu0RTjWpXvj5?=
 =?us-ascii?Q?D08QaibiYrD+5oOx/ci2PZC53qDgK+U+8O3QkctwqEuakuqKiAESAOxKY4q9?=
 =?us-ascii?Q?L65Y0FHNARMi6cfAnyy8vL/krNs8mr3WELBwebPLMJ1v7RsHpukl3BMKnsKH?=
 =?us-ascii?Q?lM4/WE1MT6WnDBNkgE9wjjJ0CJgQSI+RYb5IjQwgURbapVhp6nqvxB0n5dRt?=
 =?us-ascii?Q?iMVbICisCENL8joecSDyAOlET7/jtlhHg1PScqAFBCzJfPV5qP0lH0ybVWj2?=
 =?us-ascii?Q?blxwk/F0trA0h8uP5K7ywrF2G/Dkhf9Wbg5FxyTR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 626f9811-7dc8-40bf-3aad-08dc227523a9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 15:56:08.5886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcEOabnoJu1nLBgG/z+Gb/ii7v+wSkZBzgpxeDbcqtZg1/YdYdtwLLtsTolr0UrCmpy8C8PgP+51qiTNVopqXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7262

On Wed, Jan 31, 2024 at 09:41:15AM -0600, Bjorn Helgaas wrote:
> Nit: could the subject line be more specific than "change arguments"?
> E.g., something about collecting dw_pcie_prog_outbound_atu() arguments
> in a struct?  If you know that's the fundamental change, it's a lot
> easier to read the commit log and the patch because you know the goal.

How about 
"Consolidate arguments of dw_pcie_prog_outbound_atu() into a structure"

Frank

> 
> On Tue, Jan 30, 2024 at 07:45:27PM -0500, Frank Li wrote:
> > From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > 
> > This is a preparation before adding the Msg-type outbound iATU
> > mapping. The respective update will require two more arguments added
> > to __dw_pcie_prog_outbound_atu(). That will make the already
> > complicated function prototype even more hard to comprehend accepting
> > _eight_ arguments. In order to prevent that and keep the code
> > more-or-less readable all the outbound iATU-related arguments are
> > moved to the new config-structure: struct dw_pcie_ob_atu_cfg pointer
> > to which shall be passed to dw_pcie_prog_outbound_atu(). The structure
> > is supposed to be locally defined and populated with the outbound iATU
> > settings implied by the caller context.
> > 
> > As a result of the denoted change there is no longer need in having
> > the two distinctive methods for the Host and End-point outbound iATU
> > setups since the corresponding code can directly call the
> > dw_pcie_prog_outbound_atu() method with the config-structure
> > populated. Thus dw_pcie_prog_ep_outbound_atu() is dropped.
> > 
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ...

