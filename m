Return-Path: <linux-pci+bounces-14562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE36F99F368
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 18:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1FB1C256CD
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 16:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF6A1F76C3;
	Tue, 15 Oct 2024 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TvS0kGcP"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2045.outbound.protection.outlook.com [40.107.103.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC5113A3EC;
	Tue, 15 Oct 2024 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729011232; cv=fail; b=JTtw8GB0Xlx/mL6DCZT2sFVahnpF2ohYpruqIGqNlTTTVMTep0j6LH5QTGycL4yfs/fFCFGJs1N44GmiiElUzALwT0tG6qKc2eAOt+Sh5zvpYGzrz8s9g9bKCa8KerLqmB/kB+ImjlkY/eN9qV3sWyR9z1ekx7cTvzOC2dWKD70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729011232; c=relaxed/simple;
	bh=3DxNaBnIs4Gy+b2neZroktAF6/va3rNIecMq5/qtpnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TPKcuLMviT7WM8D7aU+63CrovWXwMrDxd1sqpVp3d+e+O+vmobz7m1FAIYUl80IGWBxJT+JW/ofpoCgmNJDcPD/OfUsU1s76RBoBmpC5FZq8BHgS6O5uIVrqel8XoQy6dA4G4UH0rqNb98ee2CcAOBz1aR/yma7P9WAvot0zScg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TvS0kGcP; arc=fail smtp.client-ip=40.107.103.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+u80ttENsPwoYrPTZZdpFkAQeEXABBJ+JkfQB0fmf+CPZX2tn1/qgTM8tx43xJQ2SxnYZmqEozjQjAnhYVA2j+RPwAtpw7J8ko77nrrPdKfRSPz0UkV9rU0ASLdMJQZrQkDDpiCPxe0JHyE7Oq4SI+ugZaH2LbvD79b4uGkkWdp2vATxR9Cruld9VpEshB3arnvsOU5V2WMq6LCG0c2t7VN1FMf30ZX2jfKp/UMHGW3UsyE1kGCesKBnS3JFr/HZO6ZoqVuqOtvvbGZd9eEZ87Y6jHwR99fGdrUi5QIABkuVu7M+xQAY2FoWjwdAuPduVF7DuvEtfK3Cz9jcCPzSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgIvncAylXb5S/0+dybJvWyKTpzSmtntQlp2tO7mi0w=;
 b=eF3AvwAljf1bMzywKKDqpEFxSb0vM9sfmRrlDFWZJU8dgEU51ANLdbs4zU0Bl/b4eV1M3mzOqBTF3ohaO83cz0chDR8SHH95LtUSxqdJHr0+rgJ98xSQE5h3wfrKOnFIFvVPciHzkF/BxKqbBg/42tmhxFnGxsGp4cY5mUSwwS7s0oxg8YyI6gwGckXEaDTvGR5xDwnbRISwaHeDXUdMBFkMmUhGKXI3oKem5v2es2Bor2cwoZ/dL5N/1lbOS8qrmCrfpBgr2ftXRbpVf6hd0n7w960Q6+SydfIKtn1zKTpZs+fE/xaetDri0a5c88fI1j7rX5ZfTGOA9+0SnwaRsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgIvncAylXb5S/0+dybJvWyKTpzSmtntQlp2tO7mi0w=;
 b=TvS0kGcP2InoEmAMBuV/cVnO8s5oNZdcbL+hkvtLglA68iueCfjXpDWVHfETmDBQtx4yV06Oq3NBam31wFkWysSvVz/HmdW2nim8IZVJAxB2YUoNUAJgL05PiVQMq2X6mvXJFnVGBvDpZUwyHlQu37s4oQHkuWkmHNuNRB6Kkcfxrn3MI/sajeqnQ0uJ7CU6vc0dFRqbLsk/vkZwH9PsR/V0tDLnV5Q7h1dCzcfaWabqiC468MtXTsB/EMh7Vt0/jVTUyo29pBmxz8SRAIb7vPQwaepmgHJCmMhRe+9W3GBjycOFKfvLiVf5kqYK7nlfwm8cure89ZALibZRiHIDQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10091.eurprd04.prod.outlook.com (2603:10a6:800:22f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 16:53:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 16:53:45 +0000
Date: Tue, 15 Oct 2024 12:53:35 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com, xiaoning.wang@nxp.com,
	christophe.leroy@csgroup.eu, linux@armlinux.org.uk,
	bhelgaas@google.com, horms@kernel.org, imx@lists.linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 net-next 10/13] net: enetc: extract
 enetc_int_vector_init/destroy() from enetc_alloc_msix()
Message-ID: <Zw6eD6/KG2ufNr/G@lizhi-Precision-Tower-5810>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
 <20241015125841.1075560-11-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015125841.1075560-11-wei.fang@nxp.com>
X-ClientProxiedBy: BY3PR10CA0022.namprd10.prod.outlook.com
 (2603:10b6:a03:255::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10091:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f2f143e-1ea4-4f05-adf7-08dced39ee7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Oy3SuhYH3ccCeniPoGvs3BK9q07TapQVETzxjizQCiIaE61H6NW7lsgDfidY?=
 =?us-ascii?Q?ieZ2Mqr/6WKZz4mtPQOKjW5utaUeYPhRk3PFL6TMEzlI2mqAT61zV74RVDF4?=
 =?us-ascii?Q?/QsLf3qrhAglUpX/jRae7f2OXtK/9nDF49yZ4tdes2nlmPA8EzuOUTwXxXSJ?=
 =?us-ascii?Q?5bXgx6Hs3fchyLPIUuLEsETRgEM+tUIxCB4dbzo0hc4dqYATU7xMZKOFa1bo?=
 =?us-ascii?Q?Td6qU0SfKiTH9GQlRnV7ZzeWbpmLnZxrelWmf6FrjH0BYHGJ6BYBKpb6Xw5I?=
 =?us-ascii?Q?Obe70pb5ppZRhHPiie5OmmS5z/Cxf/jcwj9L6DI1M7CMHrCwfX1Un3kfE2O4?=
 =?us-ascii?Q?iTgKhBuCQZbXZA5KHGY1BgWkHDiB5HIGOLiquGd8yqwmPKXj1aaZKsmG/nig?=
 =?us-ascii?Q?y6ip5yzJ+qDO/4DkTAL4oqm9wLPKdhywvIom3eaxlgMxcZ4gzgPa0VCeuU9C?=
 =?us-ascii?Q?9iZo4pkUcTZyesO1inAtV3bcFBiHIh2c//hgO0b3UulR4x4Jpu/BhRI9Fz7Q?=
 =?us-ascii?Q?kO9FKFb9zzdukh/p/weRsCqQXQucA6FB540odGCvRxfQv9BtdIqSHCggSr41?=
 =?us-ascii?Q?Yflwt2LDcH4RbXnKOVrfC90jbp6zFsE8lmIyDjIvvH8CHuGU5O+dirmM76XR?=
 =?us-ascii?Q?J5xoWfmIQAIZW973TfzyBx6uxjRUJGOxPLWazh/lWqZbeocaDdENo2+fmR/M?=
 =?us-ascii?Q?F+2Sb0/DkGvSI11G9WDG8e/HRutRT4o5RTuKSfkLpOcjtnptiUnP8ZS1oUlr?=
 =?us-ascii?Q?pxwxood6zhrOzCYfts8XTG9VuxU8gyN9D+LU5m1s8Vl1QxmEAhU190hf5qiL?=
 =?us-ascii?Q?KbtdJhmsfwJst8jC4Ie+A3r2HiJfVdL0GBMqDgj43UZGGIpzxiDlWMTme6Lr?=
 =?us-ascii?Q?jsgeRzOmM5ZteR7jjBO/odB4NMze4hZIS8RdMwtUExivs/TSo7IjDWiHYpcE?=
 =?us-ascii?Q?/7gFhgUjaDsSYIpJZ1IceXTgaNPjvSs91Y7tZDc3H3v0c74Jct0eTKC7dyJq?=
 =?us-ascii?Q?BzKCNAlGZ85n/wSgsxmtKL7LMkrQFcEcaseAf6gMOJrTa8J8kjZvA0HBXBLZ?=
 =?us-ascii?Q?Ha5bBu5hQd8I01nuxR8/nRKTGGpbvveCa/+B+fva5V4wRR5CHzN2V2MEmA7i?=
 =?us-ascii?Q?C2tJLepm06ezzDlgm+8blPh0TiwEXwQkzNJKxJX/GYEQjUcu7gAWcgs1TudZ?=
 =?us-ascii?Q?wM6T6/xIyjsfQ3a02I0upjxx+NAXD7+n4s1652cZr2pWjzAeYnDJciqW2bFx?=
 =?us-ascii?Q?z2FgzworMohNauWCvwfC9NJkSxNy8fwedE21k34pPWb2Yvm+3LZdRUe6Mj+D?=
 =?us-ascii?Q?s4e13KTSBHUhHN9nvwsqpvC5WLZeSPcFZO3Nj9XZbPHAQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DNjgIqNpgUUfaA2NMqr+ARjRqztnRngnI8FNQ3EtO6vJWF4tcg8/o+YAyqtO?=
 =?us-ascii?Q?OF2+SNAtFjS9W6A4VqAWuNGtnpuBIkBmWuFCjEltz7bHrg8/1CJGin0NFxe2?=
 =?us-ascii?Q?T3lfVnQKn3a433ibN50+EC0Xg26w45miZqEMQnm5gmgeIJfktNZyw8PiD8BR?=
 =?us-ascii?Q?kfqeirtdMg+kD+XsFtGtqNb8QqfhVnw2jJGDgPjViVYFj3LJrKWk+HqrHGdH?=
 =?us-ascii?Q?sNTe+XckiFl7X3iKMlKASBurS9qhRcn1HygF5GvfYAlGpW7LHXfVvtr1eFRl?=
 =?us-ascii?Q?ISiO7720k1OVTQXtcHwXv8MmrVC2wP3/IrOedeHzu1EMp62+0pMFk2F4kJOB?=
 =?us-ascii?Q?v0tJtcmYPTavDHARU3+2sMgJ6okyQSR0G15WnPlyfBBt7CpesuqRjJ7A2urg?=
 =?us-ascii?Q?p8LpyULIhOynkrhDA15r0R2YTStstsjfW8dN0mxSZ4Md2NTQywZgiosf78qS?=
 =?us-ascii?Q?NP4J0mpMqzuEDqZZ7NH87NdU4kpcQV2ZnVLUTr0NJeCTxA89Vmh+/DmooEG3?=
 =?us-ascii?Q?a0RBXxA0BPQjlckUJnqY3MRp+BWDRiqLsUDNJ36dVMxbZk+6VLzCwdXjwH5X?=
 =?us-ascii?Q?q233jdqtws/LlPhbW3y2Mb8EvFTc3BmNLEswS/AH7VFIlTRppbNrqutxNyRR?=
 =?us-ascii?Q?BoKoo2mUJQTKbotHPtD5dLpVBX6ldtkArBtV3N48TIZjJDrCBS9ga/812Dtn?=
 =?us-ascii?Q?EWpKlUda7pczNUGF/qesbNbHP6E9lRBNCO2lZdS9SImFMajCSQc57PGdRYar?=
 =?us-ascii?Q?GzJf10ttYJ0OZ1Pk0xafqqGGe6sbcjJ812EcCYnL+w5KNo8YHsledwEKo/Mf?=
 =?us-ascii?Q?mVMkmua23tbDDmVagHEa6NcRqF7qvNFe+ftQsuddy4i5fjLV7A0tiGhy6q4d?=
 =?us-ascii?Q?wifaRtRwGcLD894qVjeChnAouMulNSoTgSQW3uqukHah14ulVfDSMuqpKz4n?=
 =?us-ascii?Q?z5SO/WeQnsZ+xypEKgXiY9RBdBtntbBqWR5C/o33HQ8Bnh2hikKnaphAknVO?=
 =?us-ascii?Q?/A6RuL5Sg+MyVu+9eulBm2z3Ep557vPs31aPZZqBJUStrkT2E+JOyTeXppAm?=
 =?us-ascii?Q?jScxZ/ggzYfXNB/G9FlkCJwF/P/vQq2WD92w9QlPoKNG4yheaPrYwVWFAUFS?=
 =?us-ascii?Q?ltAcFOFHzKQLuUnv23ZiZpfYp7SkS/iANpuzBhv6dGfO5UCfRuWTupbTvh/h?=
 =?us-ascii?Q?s9BbAyGxEUjhaZVK01DlHJ4iE4/cK9wHbA+1QcBNLOX4Xi00ajT+j1BKtA5j?=
 =?us-ascii?Q?yWuQnlpKBuCX1fCuFtIDUou6FSQ02hRizvT8XyHZRbllc9bWm494poVwaoOW?=
 =?us-ascii?Q?rZnpfdEeChQfgyXBYK9i3AO3zZXm6Eua+w+TbinffR1clTFZr6J/JFGIwLok?=
 =?us-ascii?Q?07cKfeiABTmXdYatIS78udsAYiaW5l33ZkGspKN2F6An2wryRlrxJcPVmx9D?=
 =?us-ascii?Q?8BNhIPnI/2yo/cfMBuSlAS0GpR4E8NfdDulk/X9TLUBvO33YhPjQu8KZpbp7?=
 =?us-ascii?Q?yhaAdtKiB2MJzVp/L5z8i+jj7YHSiJe3mv62Zl6bY7LIe9HQGsKIYDqI5qD1?=
 =?us-ascii?Q?147et+0Z6XzdqfDOCl0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2f143e-1ea4-4f05-adf7-08dced39ee7e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 16:53:45.1759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKovPOv1c5lRZwy6kwoTGHCRPa8RZM+3WK6t2qCjb0j0BMYrz99g01XPARB/H5BayTyJrefmzBUgCE9WnFJ+oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10091

On Tue, Oct 15, 2024 at 08:58:38PM +0800, Wei Fang wrote:
> From: Clark Wang <xiaoning.wang@nxp.com>
>
> Extract enetc_int_vector_init() and enetc_int_vector_destroy() from
> enetc_alloc_msix() so that the code is more concise and readable.
>
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v2 changes:
> This patch is separated from v1 patch 9 ("net: enetc: optimize the
> allocation of tx_bdr"). Separate enetc_int_vector_init() from the
> original patch. In addition, add new help function
> enetc_int_vector_destroy().
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 174 +++++++++----------
>  1 file changed, 87 insertions(+), 87 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 032d8eadd003..d36af3f8ba31 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -2965,6 +2965,87 @@ int enetc_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
>  }
>  EXPORT_SYMBOL_GPL(enetc_ioctl);
>
> +static int enetc_int_vector_init(struct enetc_ndev_priv *priv, int i,
> +				 int v_tx_rings)
> +{
> +	struct enetc_int_vector *v __free(kfree);

Old code have not use cleanup. Please keep exact same as old codes.
Or you should mention at commit log at least.

Frank

> +	struct enetc_bdr *bdr;
> +	int j, err;
> +
> +	v = kzalloc(struct_size(v, tx_ring, v_tx_rings), GFP_KERNEL);
> +	if (!v)
> +		return -ENOMEM;
> +
> +	bdr = &v->rx_ring;
> +	bdr->index = i;
> +	bdr->ndev = priv->ndev;
> +	bdr->dev = priv->dev;
> +	bdr->bd_count = priv->rx_bd_count;
> +	bdr->buffer_offset = ENETC_RXB_PAD;
> +	priv->rx_ring[i] = bdr;
> +
> +	err = xdp_rxq_info_reg(&bdr->xdp.rxq, priv->ndev, i, 0);
> +	if (err)
> +		return err;
> +
> +	err = xdp_rxq_info_reg_mem_model(&bdr->xdp.rxq,
> +					 MEM_TYPE_PAGE_SHARED, NULL);
> +	if (err) {
> +		xdp_rxq_info_unreg(&bdr->xdp.rxq);
> +		return err;
> +	}
> +
> +	/* init defaults for adaptive IC */
> +	if (priv->ic_mode & ENETC_IC_RX_ADAPTIVE) {
> +		v->rx_ictt = 0x1;
> +		v->rx_dim_en = true;
> +	}
> +
> +	INIT_WORK(&v->rx_dim.work, enetc_rx_dim_work);
> +	netif_napi_add(priv->ndev, &v->napi, enetc_poll);
> +	v->count_tx_rings = v_tx_rings;
> +
> +	for (j = 0; j < v_tx_rings; j++) {
> +		int idx;
> +
> +		/* default tx ring mapping policy */
> +		idx = priv->bdr_int_num * j + i;
> +		__set_bit(idx, &v->tx_rings_map);
> +		bdr = &v->tx_ring[j];
> +		bdr->index = idx;
> +		bdr->ndev = priv->ndev;
> +		bdr->dev = priv->dev;
> +		bdr->bd_count = priv->tx_bd_count;
> +		priv->tx_ring[idx] = bdr;
> +	}
> +
> +	priv->int_vector[i] = no_free_ptr(v);
> +
> +	return 0;
> +}
> +
> +static void enetc_int_vector_destroy(struct enetc_ndev_priv *priv, int i)
> +{
> +	struct enetc_int_vector *v = priv->int_vector[i];
> +	struct enetc_bdr *rx_ring = &v->rx_ring;
> +	int j, tx_ring_index;
> +
> +	xdp_rxq_info_unreg_mem_model(&rx_ring->xdp.rxq);
> +	xdp_rxq_info_unreg(&rx_ring->xdp.rxq);
> +	netif_napi_del(&v->napi);
> +	cancel_work_sync(&v->rx_dim.work);
> +
> +	priv->rx_ring[i] = NULL;
> +
> +	for (j = 0; j < v->count_tx_rings; j++) {
> +		tx_ring_index = priv->bdr_int_num * j + i;
> +		priv->tx_ring[tx_ring_index] = NULL;
> +	}
> +
> +	kfree(v);
> +	priv->int_vector[i] = NULL;
> +}
> +
>  int enetc_alloc_msix(struct enetc_ndev_priv *priv)
>  {
>  	struct pci_dev *pdev = priv->si->pdev;
> @@ -2986,64 +3067,9 @@ int enetc_alloc_msix(struct enetc_ndev_priv *priv)
>  	/* # of tx rings per int vector */
>  	v_tx_rings = priv->num_tx_rings / priv->bdr_int_num;
>
> -	for (i = 0; i < priv->bdr_int_num; i++) {
> -		struct enetc_int_vector *v;
> -		struct enetc_bdr *bdr;
> -		int j;
> -
> -		v = kzalloc(struct_size(v, tx_ring, v_tx_rings), GFP_KERNEL);
> -		if (!v) {
> -			err = -ENOMEM;
> +	for (i = 0; i < priv->bdr_int_num; i++)
> +		if (enetc_int_vector_init(priv, i, v_tx_rings))
>  			goto fail;
> -		}
> -
> -		priv->int_vector[i] = v;
> -
> -		bdr = &v->rx_ring;
> -		bdr->index = i;
> -		bdr->ndev = priv->ndev;
> -		bdr->dev = priv->dev;
> -		bdr->bd_count = priv->rx_bd_count;
> -		bdr->buffer_offset = ENETC_RXB_PAD;
> -		priv->rx_ring[i] = bdr;
> -
> -		err = xdp_rxq_info_reg(&bdr->xdp.rxq, priv->ndev, i, 0);
> -		if (err) {
> -			kfree(v);
> -			goto fail;
> -		}
> -
> -		err = xdp_rxq_info_reg_mem_model(&bdr->xdp.rxq,
> -						 MEM_TYPE_PAGE_SHARED, NULL);
> -		if (err) {
> -			xdp_rxq_info_unreg(&bdr->xdp.rxq);
> -			kfree(v);
> -			goto fail;
> -		}
> -
> -		/* init defaults for adaptive IC */
> -		if (priv->ic_mode & ENETC_IC_RX_ADAPTIVE) {
> -			v->rx_ictt = 0x1;
> -			v->rx_dim_en = true;
> -		}
> -		INIT_WORK(&v->rx_dim.work, enetc_rx_dim_work);
> -		netif_napi_add(priv->ndev, &v->napi, enetc_poll);
> -		v->count_tx_rings = v_tx_rings;
> -
> -		for (j = 0; j < v_tx_rings; j++) {
> -			int idx;
> -
> -			/* default tx ring mapping policy */
> -			idx = priv->bdr_int_num * j + i;
> -			__set_bit(idx, &v->tx_rings_map);
> -			bdr = &v->tx_ring[j];
> -			bdr->index = idx;
> -			bdr->ndev = priv->ndev;
> -			bdr->dev = priv->dev;
> -			bdr->bd_count = priv->tx_bd_count;
> -			priv->tx_ring[idx] = bdr;
> -		}
> -	}
>
>  	num_stack_tx_queues = enetc_num_stack_tx_queues(priv);
>
> @@ -3062,16 +3088,8 @@ int enetc_alloc_msix(struct enetc_ndev_priv *priv)
>  	return 0;
>
>  fail:
> -	while (i--) {
> -		struct enetc_int_vector *v = priv->int_vector[i];
> -		struct enetc_bdr *rx_ring = &v->rx_ring;
> -
> -		xdp_rxq_info_unreg_mem_model(&rx_ring->xdp.rxq);
> -		xdp_rxq_info_unreg(&rx_ring->xdp.rxq);
> -		netif_napi_del(&v->napi);
> -		cancel_work_sync(&v->rx_dim.work);
> -		kfree(v);
> -	}
> +	while (i--)
> +		enetc_int_vector_destroy(priv, i);
>
>  	pci_free_irq_vectors(pdev);
>
> @@ -3083,26 +3101,8 @@ void enetc_free_msix(struct enetc_ndev_priv *priv)
>  {
>  	int i;
>
> -	for (i = 0; i < priv->bdr_int_num; i++) {
> -		struct enetc_int_vector *v = priv->int_vector[i];
> -		struct enetc_bdr *rx_ring = &v->rx_ring;
> -
> -		xdp_rxq_info_unreg_mem_model(&rx_ring->xdp.rxq);
> -		xdp_rxq_info_unreg(&rx_ring->xdp.rxq);
> -		netif_napi_del(&v->napi);
> -		cancel_work_sync(&v->rx_dim.work);
> -	}
> -
> -	for (i = 0; i < priv->num_rx_rings; i++)
> -		priv->rx_ring[i] = NULL;
> -
> -	for (i = 0; i < priv->num_tx_rings; i++)
> -		priv->tx_ring[i] = NULL;
> -
> -	for (i = 0; i < priv->bdr_int_num; i++) {
> -		kfree(priv->int_vector[i]);
> -		priv->int_vector[i] = NULL;
> -	}
> +	for (i = 0; i < priv->bdr_int_num; i++)
> +		enetc_int_vector_destroy(priv, i);
>
>  	/* disable all MSIX for this device */
>  	pci_free_irq_vectors(priv->si->pdev);
> --
> 2.34.1
>

