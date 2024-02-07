Return-Path: <linux-pci+bounces-3227-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9288384D5C2
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 23:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4891E284E2D
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 22:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A59149DFE;
	Wed,  7 Feb 2024 22:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MKbGsuFK"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F98149DF3
	for <linux-pci@vger.kernel.org>; Wed,  7 Feb 2024 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707344618; cv=fail; b=HjwVjD4MRc60qMLYc/QqDRMy6uzZtrRHGiW1x/qYdFSX7vfSPB+ZtTIyvK8mqjikzhsVRQxbAXv3L/TgMjysle3XXTCNxTOIz7w9SZjogVXUmJmyV7kxDpWH78W4ER6KzUedBI0kAJuUFdbuknnxlX597zCBddLmEp3gxXUD9sY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707344618; c=relaxed/simple;
	bh=NsAZweAREils+OkxJRNARl3RMnLjO3xv7vBvNLQw0AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HTs2TIRQlwFRAuZX0pozk2Y3CNkpmonCtT/IsO7ORAqT50q/hchdQOykuITHdBMeP/w294Ha5tzjr7qnqkG3lL5gIu3lsx5IV5kvDOqaD0xfviY/BxS7r74G3sc7kTZ2aHTH1rQUobuLFvwJt0m5A0B074kPN9DCnt14WTU/So0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MKbGsuFK; arc=fail smtp.client-ip=40.107.20.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/Qn1LWKcgkRNDq/pKcZvGpy6vnPY8YPO2m5raNz8PsrXh/bG9kvlLG3MDnE5hE2E90iYmS81e+NAFH1eewRSvfcpLB6uOTrrFK4WeMPl6r9M1+2j5dcp9FgpbAjmNdapz+mpxF1xL2WDY/GJvxEEKffu9b8T42VB4GfGR4eDtHndXYEr9+DNrBU64YF76LYabGl+o5HkAtRqE5UxhyZBHGxPIXP9Z+OTqKkUYI7PTnO6C861cxD6Nm0yut6Jdq3cqI4flh5FVIumQRBgQPFkaOGWvaGgcGSAzhgkaoIl0QXKHo1eX5GgO7R1gT2ZfDBpVh3tPz5G7kQ9Ehbxkm9ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LceejBxWiNIVizW0SkZoxQjTdM4sI+sjmnOMqhzCfH4=;
 b=YzUoZJe65SAdZYRv3aiDcDuQhtn6/EsmRu+nFNpdAjwcTUDlgJShzNHKqjvt5ZAMaKtu4yJ5dDko9SXZThYaSFagpZvDz8hVZYJCt2IPyk0s/YOeDKODtodu9u6/iSJonXKJ40vLqkLrpUmRwliO/0dWSlpBUufqepPnYo4/DHBbZUkrwtvJrvwSwMqd2v51FlKnz2a2YLAqoN/6K1/oTHUQe8je0GLRfztBC5NdIQRa8i0OCb+idnvc23sJqRlO4fCSs4pHINGkypjItGSe32wGNb1xYlT54LXx6hD9amhkG0lmXPkmASWt+xcYLUC28ulNByOUuh23V3fl0jTZvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LceejBxWiNIVizW0SkZoxQjTdM4sI+sjmnOMqhzCfH4=;
 b=MKbGsuFKlA0+GoUqoX8LA/nK7Tg89gUTna4qrWKr5lt4/gFecvvUSKsAZPA37seCKwrZj+ZNO7PEyaP+0LQnUJuv0dXwVePt+ZIpAbEPx+SESt8wgAN7xa65r0V1Knoiv9lToTag/3pGbTAJbiGZLwpCJNyM8VtMC0piQ6QDBh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9488.eurprd04.prod.outlook.com (2603:10a6:102:2af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 22:23:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 22:23:31 +0000
Date: Wed, 7 Feb 2024 17:23:23 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/4] pci_epf_alloc_space() cleanups
Message-ID: <ZcQC20/uOOoNJfjh@lizhi-Precision-Tower-5810>
References: <20240207213922.1796533-1-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207213922.1796533-1-cassel@kernel.org>
X-ClientProxiedBy: SJ0PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9488:EE_
X-MS-Office365-Filtering-Correlation-Id: eefe796f-31ef-440c-a244-08dc282b6a37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	msQShQ+d5EzYc2QPpOHsxzFDKHNQIF5j7jeM7A0HNvuKwpgvFrUNV4DTQmEKGtcAcBLUzK82XBirHngQkYG+qrN8AJdI0mSthTInfiHB0HYxhlajhBP+QVJpTUu3T6j6Dp0go0rO7YrrClIboLgM6EwvP4EvEeGPwdeQ0rERHnqQ6CfswsDATi5kdyXb1Hs4KOaf/CC9Dvd2lIq7kFn26m5AshMNWywhpw/h4EiYpjiQzEQMTHjMObfEWlGhoLkVpVE+RyagHoLb2ObdMGzQxj+GHFKA2GIyYg1fkiIwT0RqQT9B01osgbYo0sJLPe3GeTb/9OnxQYq5fJF1TNz4Qo0943qwV7sRY1KYbypY6omDOjHreLxQRe0hczZrZ6gNjsm0AUIgjqVI8L8/sAQ3vtr0ofsdtfFsngN1rR4VSQlVtnZKvLcxMuNMqjBIBRRWOBU/Afcbr5dHdp0s7QX+J8e7DhwTujeXBxd3+MTAYKFpuplH1rP8IJCYp787ky6OXk4vd+0Y83X1kKquM4IFU7aoN8MzE+eV1myBLWZJ+T+kbh64vw6Er/ISiojrJIAEvNsaC7oEhE1sduqOwO4PMMdK/Go2IgMgbfRBvV/SjRgGk5aDeQN4NEOMIyQtAFNa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(41300700001)(33716001)(7416002)(26005)(86362001)(9686003)(5660300002)(6486002)(478600001)(2906002)(38350700005)(66476007)(54906003)(66946007)(316002)(66556008)(6916009)(4326008)(6512007)(8936002)(8676002)(6506007)(52116002)(6666004)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HSDX1sT9D5/rPWJClcfyk0qPH02S00J15vJoLpypHg0BuUfuaRhd7MOXeDFq?=
 =?us-ascii?Q?n2jOn9Nt5OSUgTwfLQkyzK03Ut71UK42Ay/Y8ZhgoZypqxbB9IrC38s/oMLp?=
 =?us-ascii?Q?sBxJROzXJOxgpt0i9Hw1I1Fkx3Dgy+g8Bv1xmUYPNd1+iYwH2qKOAqhVhnmP?=
 =?us-ascii?Q?LuMNwwOKzR5Q7jXjadHYgU+RCfSWc3c2Py/YxL9a9KLxfL1K1VDal3Szljnh?=
 =?us-ascii?Q?ye+so3HtBQXIrzDVkBltZHdTERK4c8QR3kt6OY/I/mE8OjvjnKKFsDU9wUZh?=
 =?us-ascii?Q?KC76WeaEnbTiL9Xjyt0bhbobbbHLMPhM8c4Dlogv+7Ixo2pcKTK/jE9fOaRq?=
 =?us-ascii?Q?L/S8VR6vQYnfIxMDkIYzI5yh5jFN4YeazKTZ32d0d5p1irxdklp/AhTRp3Bh?=
 =?us-ascii?Q?OJLJugLUH5VQ+Y6xBrfa1YlRsl6nWyIewD8EUrSGw4ZojNSukxkY297RRKjv?=
 =?us-ascii?Q?QU0cJc/rYw3fjd4cYoZRqYjXvub1ODtsXVif/fbdYW96sDSo60GCmYtrUQH1?=
 =?us-ascii?Q?3noiCDagn85neIgKIT93FTtmcVD2pgy+7R5kG2I4cuHDOYLwrJU3+rv3e+PQ?=
 =?us-ascii?Q?TiYSeG6jg97s/8EqKhr+B/9DbRHYMt0gmeAOe4CMruckIXPUGB9n4Yz3BW8R?=
 =?us-ascii?Q?WPYOpIsMV6DuswozT5qvv4IEC9vXBvC5mpi7g59sWHZlJbKbij8MyawlvirU?=
 =?us-ascii?Q?p50IQmQp/KE+8JDwgTJtubBsCUL787aw54q80JgQeDjj4XOMRxmHzWhRPnCj?=
 =?us-ascii?Q?u7//9IHf2gwhFzW5Y8gq4Po2BdzquAslnmtoqtoX4YPCA5bjEt3k/MI4+O6+?=
 =?us-ascii?Q?tOdZ4PrTjwyjr1oaJBgkwbKHoTwyfCQ0r9M9WZiOifoHA3qVSf6B8L7Rl2ax?=
 =?us-ascii?Q?FcvBR6EHVXHVgXYTkGYaIh4tsEJIt2D03ZagdHPF7fIkiVdfVIFLPvBdDhul?=
 =?us-ascii?Q?i5xM00hQnAkhqgO6QTAuVQh0pHbL7ubnzH4AGINmeXa1lpLFcMe3xEwJ1fA7?=
 =?us-ascii?Q?H3+9/J+KMkHT4c6WbQnh4WwjaRKL1CPCT2iysop67WsQkTHoaEFn42xwO0Od?=
 =?us-ascii?Q?kIMDj8OKwFRCptQlva/y57hy8Aq4wvUUmNhQwI3+FoCmuGhxIqwOEM4Y1Y4h?=
 =?us-ascii?Q?V/6UiruTKQSrtY3dQ4X36upoqBpnW3ORcM6YGLgIGvEIPa6dSwWNEzEfYNaQ?=
 =?us-ascii?Q?j3wlq4ye6ljgro4lGAhGvx8qw34X4fbZ8RGOSEnW0NZ34yjxFcPrhv0PB9sE?=
 =?us-ascii?Q?gVZ1/zcefppaaeqRFKcaLMeAnbNVWk11YPBOpz3drxeN+N5Uo/qrVtfuSXY1?=
 =?us-ascii?Q?hLjWk9LAmWYH2XnIPuI9wShlH9bhHFTPVQkf/VvCFDVqj1QEAhNVcV6fBHp+?=
 =?us-ascii?Q?FZrdpfsUkddaGxU1qcBP0kPAgrcp5rsvTFazCG5YLUmyJ7HoGsDMBVXcjBsj?=
 =?us-ascii?Q?VXveJJUc3AzMFefhFrTrLZZN81pz9YH0BB8oEm/0moIeEBZqAN6WsQSOig2X?=
 =?us-ascii?Q?FyWfgmqzN5Icdishz/lwsF0KBQLIBJ6pgGUFKg2p/ldaRCUrtwx8fHbrkOWM?=
 =?us-ascii?Q?rclULJvO6o3vK16jLSpe2wbODs/dxIZBqwnUtelQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eefe796f-31ef-440c-a244-08dc282b6a37
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 22:23:31.1814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ccl6Gx1Dg+nmTrRqTA3vXHdCXOtDsqLUAVaUUkv56iC3xKWOzB5QnEk7neMffPrb49bcY0tQLOz4wXGlwmmiLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9488

On Wed, Feb 07, 2024 at 10:39:13PM +0100, Niklas Cassel wrote:
> Hello all,
> 
> Here comes some cleanups related to pci_epf_alloc_space().
> 
> Changes since v1:
> -Picked up Reviewed-by tags.
> -Fixed kdoc param name to match the actual param name in patch 1/4.
> -Split patch "improve pci_epf_alloc_space()" into one patch changing
>  pci-epf-core.c (patch 2/4 in V2) and pci-epf-test (patch 3/4 in V2).
> -Perform the alignment even for fixed size BARs. We need this since:
>  1) Some platforms have fixed_size_bars that are smaller than the
>     iATU MIN REGION.
>  2) No longer doing so would be a functional change and not a cleanup.
> 

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> 
> Kind regards,
> Niklas
> 
> 
> Niklas Cassel (4):
>   PCI: endpoint: refactor pci_epf_alloc_space()
>   PCI: endpoint: improve pci_epf_alloc_space()
>   PCI: endpoint: pci-epf-test: remove superfluous checks
>   PCI: endpoint: pci-epf-vntb: remove superfluous checks
> 
>  drivers/pci/endpoint/functions/pci-epf-ntb.c  |  2 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c | 13 ++-----------
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 15 ++-------------
>  drivers/pci/endpoint/pci-epf-core.c           | 15 +++++++++++++--
>  include/linux/pci-epf.h                       |  4 +++-
>  5 files changed, 21 insertions(+), 28 deletions(-)
> 
> -- 
> 2.43.0
> 

