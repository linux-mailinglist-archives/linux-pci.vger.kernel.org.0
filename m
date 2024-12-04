Return-Path: <linux-pci+bounces-17662-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAAC9E41A9
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 18:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7500B24ED8
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 16:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5473182D9;
	Wed,  4 Dec 2024 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CITSfbab"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CB54A28;
	Wed,  4 Dec 2024 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733330132; cv=fail; b=jWN38ya8mOnpUCPpOjz6nfqfQKHrN/i9bQEhBZM1E1GToX++6cowfDs2jdzNtDnWYgF/e7koWndEXQKAI51prSSfi2HUYF6ldWGJ77AsPdyd4Kh6N5ZT+VdiJU9i163QgXLKIsKMOmLLcIqAqq8H7Xf259lRZt45HbJ9/t2zCOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733330132; c=relaxed/simple;
	bh=A5WmZu++0CYRHoBKnYb4HMSlpFxdRFL70ldALhSo4fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tg2EWZ6UcuC1JHXBUUPPcSh7dZqVEZQyfs8Jk6xvqljTDSHGIZVdOJdTrW+yIYeHrJllYS8GhJUTCr0pzKgcL6SgnZ0wW2uuRRQrU98KMy0K8UWsQa5GH/Q86K36a1hRT0ip1Ez8yHStTQlovxmJZYwUYHDkcNGFigUGWuNvPk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CITSfbab; arc=fail smtp.client-ip=40.107.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTEf4tSk6KdC+nV26yWRdWYy+arBm1dhETD6ZUpZKOUVn1cc0aSlcmEun6Nj1Xgqrg7S5112gSGUGJ0bmQm7y7o+qWd+D8VWegYWHr8zhcBA2KpJ9Kf9r1ACchkvDlE/5RsjNWwZAOa5BlBfRM9Enms8CgGgNRX7LArLpvhh8qRXgev2BzjnCgqc9IbusEZLkKBuRvopT7JVhF+LCJjZEIKhoCkm96oihI/FlBAsKJN627CHcwXaAwrkmzixLFujYu3rJuhRpfh5OrKAvLAUxfdidw5JOpWr2Arnga9ZNTN6qli/CnEVw8gjds3312BE0EfhmMBJ1iZnjvXcdlOu5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsIBRYUuFM0899T9WNw8x3+NfNa18s1BEWfwk2AcC7E=;
 b=MsCOrMd0QkfEXVgRFPJID0KEMNcjBy2Q7QOfmJGcGVea0C+BxxMUz2ZSe9cQEi3Dr+y3uY0ip+aC3fOkCKbBpvfqh0MDWxnx0002P94JnkyFYiOkVFnSxT6feoXFDAvw5LPyJDZXv9jYmnTjCBXJaxZ46rwstEKZ9m0Gv/e6DpdVrgoidL9Dtk/XFhM58Z0YBzgNkgpIxD0oyXXdn7Zg6cW9Y5hObG8I5aDui/+SRNS7QB6TYowfmHsVIpctcDcxOWbA9SZheJSj669RSemFqgQVgOY3KMa5hBeHShEhjGVUPouR9foPvVgWNoDxMKn6JR1N2bTbQjBnzro+dI+zGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsIBRYUuFM0899T9WNw8x3+NfNa18s1BEWfwk2AcC7E=;
 b=CITSfbabPsN8MoMS8JL1NJq1vONYee0sCNxiYG1PebxdNb3W1i6BeMQ7CshZuJNc/4H2KMo2UKLqsq+bnSOb4FPAlojgRr/XnuiQP80FG6D43aGmMdsimFfOeUmcxDzkEEG4fvP9ATanWW0hjTmJKx9qNYMjH0eSPbGSB8zHyegaOE66E1/8jZ3UfKlHoo64o5acmetfo0RRxKJvuqgjrsfP/w4OwGnYBlKXExL0abq8B4tqEvPccwZ62BfKbHweCwDZbnhmXqLn27mve+ZxCpc9YTz5e04zLTvgvmBpNlDGGkATuDJ9Odif1BE34Bcj/Qo4OKIRPApehgzy3W0WmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10807.eurprd04.prod.outlook.com (2603:10a6:800:25a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.10; Wed, 4 Dec
 2024 16:35:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 16:35:28 +0000
Date: Wed, 4 Dec 2024 11:35:20 -0500
From: Frank Li <Frank.li@nxp.com>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH 1/2] PCI: host-generic: Allow {en,dis}able_device() to be
 provided via pci_ecam_ops
Message-ID: <Z1CEyAJn8OnxEHUO@lizhi-Precision-Tower-5810>
References: <20241204150145.800408-1-maz@kernel.org>
 <20241204150145.800408-2-maz@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204150145.800408-2-maz@kernel.org>
X-ClientProxiedBy: BYAPR02CA0065.namprd02.prod.outlook.com
 (2603:10b6:a03:54::42) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10807:EE_
X-MS-Office365-Filtering-Correlation-Id: dc05042d-89b0-41b8-8156-08dd1481a944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cf9Bh60T2hKpfgaAagypNZiiu9wRSb2uszIxf89AIn1mzqCY3Vuio/yx8Slh?=
 =?us-ascii?Q?wSPxpkGkpzBbbL78aNJURvw0Hqnli14aiCq5VP167/8UFNtkUxExDguQxIzU?=
 =?us-ascii?Q?t0dqqKICmWlBn+x0o67g6dFFWV6Q43kkT94HuVgX1D5tBS4uD+2lD+HKozPC?=
 =?us-ascii?Q?VU7I0ftQBTgnrP3i3TL6hHgjanvuEhu+VBck6YV4jAHsZLRvyINnkbF0moGR?=
 =?us-ascii?Q?PrWUIoPRvitEmF68F0UUOIuZNYPE0F6oIooy2AhWRmkFdssj5fCy559NlOMH?=
 =?us-ascii?Q?94vB93HcZk03b06nmJZklgiQR73OzGUa7oNiFTuwgetU24ZiPYnqjS0/jdpD?=
 =?us-ascii?Q?m0zRNCC2XoIR510CLNsXEb67udCF3hCvHEasxPw2TCswgOyxRwUacCsK/BGt?=
 =?us-ascii?Q?WgYoU7b5w9CIQU8wSdooB9uhpB7GDMXB6roM/Wo1EsmNc30j6GfBds3VAb4a?=
 =?us-ascii?Q?Pk8o5MOjpMzWIir8e1tPA4LXKnZLjq/EANuAiZZ6J0WQUwlWirhsfflhSvxu?=
 =?us-ascii?Q?iBbelRc8TUq/oBCzxUXDyGxZ9s2PXw4XaZDbvK0S7qHLnLodmEi9zOFJc3a3?=
 =?us-ascii?Q?yBNcU2pNIulX2l/qC7FSdwTi0mp265r5zSYoVnovPW4cux5TAbqlRIwe+BcA?=
 =?us-ascii?Q?IpgwYmFjqCCVGLT+n2nYhAL67O3d7V3D3t0GcEQ3OYEMvxPCKu6in68BSx4W?=
 =?us-ascii?Q?GHNmYzEL0p1b70pd45iAM449RTGriOjLFD2yhurFrtCTd3GioZZvRH5jPu7A?=
 =?us-ascii?Q?h2pIBbNz/wMsLFYiRDcAxMMOYjP+0rObDekui6u10m2Xi3bf9lv/7bugYqtA?=
 =?us-ascii?Q?rm5XLIYaOvD5qIzELN0Jhjgi8pM2VyJU0fDur0bEejC16g8LNqEvoR/IyJe2?=
 =?us-ascii?Q?biO55exvl7zwvtic15gv96Hwdw8G4ig6H6OFQSmfij/rsyOteEqNGvDBw5w5?=
 =?us-ascii?Q?Qipp5nSVkzMK2THUMj/+i5lxyz3vmQ+GBAV0bwCwXcTC310Zx9/qXTc2qOZr?=
 =?us-ascii?Q?/HNouR8Hk4vkvR5oDmRsA9y9s/LeMRfeJSefhcadHVt2RmO3qFgLZcVwCrAr?=
 =?us-ascii?Q?kqGEf2ci0nn1l25rOBjwHtRNUcQjs0pnhjL2i4XwuuyCyc+PwswPv+V7+5wm?=
 =?us-ascii?Q?md4NONp6bCG4Vv2WO0Ek0Ig84v8cJb4xXdSoadzFqueapY+x5R5OdNPGjL24?=
 =?us-ascii?Q?7YTupB2gRg6gM2EDjqnsloxu3v3Qtevf7lXf3d5lJPYh6+5Y179IS2snd1ZQ?=
 =?us-ascii?Q?sfO5CO5o6JKF1tEsfI6eO2WR5V6ysSxpH+xQdMG/by3lftqG4YytjaCRUX5W?=
 =?us-ascii?Q?1xImtjaICuKQMcAqdO3Io/ZVpILRd1JLXD9Cy9T8jUsPzLhnR+bI0m3YOvzC?=
 =?us-ascii?Q?o1dpUWF5wMvyr2ZhyHI8ew45GrBlnr3MEe4i9vHljbVcUUnT3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tc2pAVrsuyrm09cgv5su3siSeXOtGTsp+FnP+2cmxdwznCL/MVrcESNPd3tK?=
 =?us-ascii?Q?u8guosWCXfcBfpDNnPbsiyOozbqXFES0AlFaWlhTWGk5lzL9jfNCVoAgH59T?=
 =?us-ascii?Q?Mgbx/YwBF7f5432QT/n5vIcBWPzPHxRL9JdbF1K72JFapfJNV1gifzilwNgT?=
 =?us-ascii?Q?2NfiNyD5wVGiX9DvU+jqPuGcoj4Li7vXy+wf6IQhNolpgzTZ1SGtsNwIWOxj?=
 =?us-ascii?Q?+USCyAq/p7SnOYqS7XK5D2f8yfezdruWd9UImdn5ZIcfWypoV5tWhGQgT+LP?=
 =?us-ascii?Q?gI8vZ42F5nAcK9GexYZc0YD8/K+lls6LodZ7Q0Z7IE37th/UAFClS+VH7IN8?=
 =?us-ascii?Q?FrR+tdBbK9gxVAwU3qZhdMbJUmEofvxbxVTef+ZMdZfZQmhPj1XJC5d4D7cA?=
 =?us-ascii?Q?2go4CGif4HWjdB5dZ8/C1CvU85GdQ51O07Enl6kiqSZXa0CpYdyFsINAb+db?=
 =?us-ascii?Q?JRyRTeow5PHZ4Vn3ihIeN5yt7OakXIHUEvvblwIaH8Ybidilv4kJHmWSeBbJ?=
 =?us-ascii?Q?D4bxtuMGN1/7FLFn1jKs3sghOoVXN1PoP2LdL3aFJERyl98mf2lJnJoq2TF5?=
 =?us-ascii?Q?fx1YOQIsIJxtHyPaoyPSHJKnbpM3taJYzNQ3S2jCIYM/40EighNhOqvLTb1P?=
 =?us-ascii?Q?WQ2CruQ5NBOLF9Icu0BW0oUsEtmx+lPvDo49ozx2CcmiDhaZ9i2o5aZ2O+ZR?=
 =?us-ascii?Q?/3HsXBYkOFw1Y/a2hmQbDVj1xzynLUHnCojPpbIJ2s0IQEAXf4Sbx1VynX08?=
 =?us-ascii?Q?1VDq6w74IV1grCMXYec0bCVN0yiZKlM67UpLPOGLtzQKMiln7sEGmKLJzkt9?=
 =?us-ascii?Q?/N75EzODgYZS45PSm/bwADZqT5HPoYiVW8Shn218MiGIMfE5NPWS3SOaHZ2/?=
 =?us-ascii?Q?kmxKG6wqBy9pLFpgTRg6WHlcAZaql901hddbycf0cm3I3ofJ11vdxf5c5S26?=
 =?us-ascii?Q?TUaI2wM5eX43OsB1OY6M8ARfs6MwbuDflRavgckFDDe3tUGIX0T8v8AIRZT6?=
 =?us-ascii?Q?C1eqTGNJ5ZekfalBHtwgXo/uxjUvDRkxn20R5OHbRVYcIx9RLWwpsh1/uB9R?=
 =?us-ascii?Q?Ef4cZrpTn0g+jtYsM/PANiJfMXDjvXN/5NIaJLmgn9puWeCYdf0eNkwE3MQO?=
 =?us-ascii?Q?dmlgKWpu+HbdhnpZXVC6y/PUoXSxO0XZOhbgfD7nCKnohyp+734nGkSI0q7W?=
 =?us-ascii?Q?GwnypcfuGHSg6S1sE6NqA8KIjmD0PJHDnI9Wus7dv7hxcwvYXY4gOZLXpYGi?=
 =?us-ascii?Q?VsD31GrgdsdsLtmQ5Eg72U9Dosz5vk4/nhfDEwSJNNJ0RI+ydE0tfqLBNN6E?=
 =?us-ascii?Q?tTPATN0kodVugQhKEBNe6NiAaVaxsMr8Wvr3zEhj1LUQEqZB0LXXkG1gCUbr?=
 =?us-ascii?Q?0xSumoqKs5qEwt8DLqujL+cVBbJh0GbrO8JiHgfEqu7b17OXNbF+rWrBkG89?=
 =?us-ascii?Q?eclWNJVOZBN9rwF9TfDG3WfVZkMFhjwOdck2oVBV/WvI0KPiVUJSt6bgv+ME?=
 =?us-ascii?Q?cI029niPjVzxOfeurzKAFzdmgg6EA/aQiqEDHZ7Rl8HUYJQb2MntT2KJK7QO?=
 =?us-ascii?Q?7PgpjUWA7Wejfky19pmmYQ+fjAfc4eaXmna4X/2m?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc05042d-89b0-41b8-8156-08dd1481a944
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 16:35:28.0800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhtnVA21dzEkvUTBwrNlnDr2mvsrLMwxdJB263kWPEctviZzExu7T4YGhV9LouPq7XTLwFqX/4aaRdzDyj+OAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10807

On Wed, Dec 04, 2024 at 03:01:44PM +0000, Marc Zyngier wrote:
> In order to let host controller drivers using the host-generic
> infrastructure use the {en,dis}able_device() callbacks that can
> be used to configure sideband RID mapping hardware, provide these
> two callbacks as part of the pci_ecap_ops structure.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/controller/pci-host-common.c | 2 ++
>  include/linux/pci-ecam.h                 | 4 ++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index cf5f59a745b37..f441bfd6f96a8 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -75,6 +75,8 @@ int pci_host_common_probe(struct platform_device *pdev)
>
>  	bridge->sysdata = cfg;
>  	bridge->ops = (struct pci_ops *)&ops->pci_ops;
> +	bridge->enable_device = ops->enable_device;
> +	bridge->disable_device = ops->disable_device;
>  	bridge->msi_domain = true;
>
>  	return pci_host_probe(bridge);
> diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> index 3a4860bd27586..3a10f8cfc3ad5 100644
> --- a/include/linux/pci-ecam.h
> +++ b/include/linux/pci-ecam.h
> @@ -45,6 +45,10 @@ struct pci_ecam_ops {
>  	unsigned int			bus_shift;
>  	struct pci_ops			pci_ops;
>  	int				(*init)(struct pci_config_window *);
> +	int				(*enable_device)(struct pci_host_bridge *,
> +							 struct pci_dev *);
> +	void				(*disable_device)(struct pci_host_bridge *,
> +							  struct pci_dev *);
>  };
>
>  /*
> --
> 2.39.2
>

