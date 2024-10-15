Return-Path: <linux-pci+bounces-14561-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 343B299F341
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 18:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97BA1F214C6
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 16:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A7A1F76AD;
	Tue, 15 Oct 2024 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mPJmRc81"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB0E1F7065;
	Tue, 15 Oct 2024 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729010980; cv=fail; b=MdQl+XNRmHlxL39gUOjr7MIb2rn9Rw0aFmJHIfXtLWWEEYTILB/MO34oj+0NCDQaOh2fOEcxmXZopfq77oNw5fYe1v78t7MEv46kUgBcoc74BWOUES6niwAlNLsVtAvdV2oLI9CHl+YaWWNMTDXYRVPQtGXjrZ6rgr5e9Vamv3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729010980; c=relaxed/simple;
	bh=T8N44BfjPbgVmC+P8HdFj3B/qOs5QqRXsM3vxhNqQX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H9IUnp6bcwsqUBzHFans5QhmSv6WXBuR9b10Isl9RJyCAP73A58saMH3lnxE+D3f2qf1Vg8kv2OrbPiVOQr6d4ubDsfNlwaNVstTzkC/b+wjoB+9d1VY7EtPvxZz7t/u4sKcm1HDiqdEyoI9V3LXrTJ3mGYMqDs+1OWnrpzGTdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mPJmRc81; arc=fail smtp.client-ip=40.107.20.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwXBwJ2uyZNRoja1H0LS/DL1AqDvlQ/0oIpUo4erZAGf3ldiqul1kM9b2Bf9XbFdSE76GWPX2yQiN69CEkdeULMsIPDuqdCrgZeBY6SeMhQsOatmsP90vkMZPCD9Gsq3QpALohAw8Uw0BAV12IURlIu67qdEs5VzDFm3SYGgVaYpMUMyNrwrwzqqtIRTGy/+o68plfiJvbfW9ed3pKxJ+RbG8pbKsmhlElk00HEgMBE8skZUhsDXp4HHuejoQGEUeUpyA+XATnzPFpEP9aCkHb4I9lF2l/59uy3rF1HYhDDRltVobPQWpAUWb8dCh0cpJPeojBD5YyNM4Q0CQffNDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ER1pgN62Hp0FUkEu702Aezk09kdsfP/zh90HeD3lPCY=;
 b=jbRw77RKdrNoMUelqSm7pnzYY8Ybslv8RhIn9tsrMdVLgBR3bcJkqL4eRy0cNrRgRXILNdPn7paPFFF3aRv2rZFRzeiJYuQN5/ruXPEPr32Arq+NokNE90imAvjtNNcb9/HZ13c+no2UnGNZZhXjmYT9WHb18diDiUvor5n686Opg9tbzbZ3OPXu5mQtBrdUa4S83EtUTujPz+3Qf/ANA+GmDcN830DqUYdXRXyLyqvCiXeKst+XOnqsuo5jmqNKmIWc5bLZJzDnNqSDaiWXeCKmRF09zqzvcmQYVXkF3DMoCnQPCaaeT+Ei/XFqCashkO9/ZvGUvAmrIS1f+lYm8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ER1pgN62Hp0FUkEu702Aezk09kdsfP/zh90HeD3lPCY=;
 b=mPJmRc81pLwiVrgEMBPmwQbAwG1xm+N6u7cq6voWk+oaDHJjNwYPJqa3gSkjBu6V4f8QrYe2CFMR5K9AQPxzm+voHb+KFzdIwQQWdIFfyop9+nFmrUlbZj843TBRDttXhDzfj2DewqVChqPYZUX9ju8L7ajcrAEGvgbWGaAJc/59tA3QOBERmZVl8A8OZl90uU7P3szgmju4bAFe6UzJqlB51ZeqVVYjwwcsN6q9XVHNzxcwElJUQHxR3jVMakveuBY1UqyoQuKKLi5niliy9cCyNPW2ocHk+jNJSvdliLUNu+wJE/MJevwsOd238N1HizFvQtcFJ+PHcWDxjmoRZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8929.eurprd04.prod.outlook.com (2603:10a6:20b:42c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 16:49:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 16:49:35 +0000
Date: Tue, 15 Oct 2024 12:49:26 -0400
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
Subject: Re: [PATCH v2 net-next 09/13] net: enetc: add i.MX95 EMDIO support
Message-ID: <Zw6dFr9GlOLCtwHw@lizhi-Precision-Tower-5810>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
 <20241015125841.1075560-10-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015125841.1075560-10-wei.fang@nxp.com>
X-ClientProxiedBy: BY3PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8929:EE_
X-MS-Office365-Filtering-Correlation-Id: 78a28d7c-7517-4568-7d89-08dced395948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pg40jtUI6AAsM50XtJ6nHQSnm/zGc+24la/7afP7h3KzDP1r/9GF4a3FLbP2?=
 =?us-ascii?Q?cPpGg6dVfLZ2634PmPIvO8lntJ5bNmO4QUWSL0/5xdTpastbOnQyMue680kA?=
 =?us-ascii?Q?SCyDqyEM4k2qMxENzl6qZIHQUE7AY2HH4ZHNjK1BdSHpOhdsam24Yjc2zuno?=
 =?us-ascii?Q?eJZEakNJ9e9HI8wPlFDxIYoeDOW76Bjx+pyWL2zkgUea4ZYIa/VrzyI5HAur?=
 =?us-ascii?Q?pmv1IALzyJg8T85HwQVgAWvN/6X1rfKQjfsrVDcpksnNMuwVRY7Zo0ZsXa6G?=
 =?us-ascii?Q?KfQGqJSwYz9c/gCN4eUU+JhbhX0KZdwCaWIjX2uJhHktobyLKuD6uB/K3nT1?=
 =?us-ascii?Q?BnLIAs3Or8ZyZFk2bAWfDILcYQlB1AV3PEvCgTIS44uzGzmiLQvGhgJxKDke?=
 =?us-ascii?Q?Wya9qhZukXFC5xmJu0HprCiZ43AOGZbe6B/ByOH6PgaMoJ4ytgu8aTER/e9P?=
 =?us-ascii?Q?YGbFUOan3b4CZxKJ9GwMvv564Aamoliwk8MyFFgsDChZfrduWsKuM3aaF1qi?=
 =?us-ascii?Q?Z9G7/IU7yYg65kW/0fzSfDaDDoguj8wVg8DGOaM40r/D0xKMnEf8OXAnbC8a?=
 =?us-ascii?Q?quOgMp50Uzgw1r0uEsnUnYlcuEwYVxfNYW+UjredRp2dCdfGTfzcCdpQziqt?=
 =?us-ascii?Q?bMhWztacurTOG26QMddJqkTui6QE5wA3HGstIoeLrXX9j5LsD6mj5ieKyE0t?=
 =?us-ascii?Q?4RLHwP5XqwcyeFUZnnDpxfp/RPr2gtkta3FtUtleBmifC8T0D0LGCiYlgofw?=
 =?us-ascii?Q?akAWllKmf3/8zYjIHId7ANv4y6TD5oVEqpdJxYZ0n9EMl9AQiZ91WqY2xgbf?=
 =?us-ascii?Q?IqfVuzOsc/BRel8H4Nviu0yhiXUtz9SSsDCyW/L5YmQNw3zA9l6df5hpyFO/?=
 =?us-ascii?Q?vUX4dwyTRX6Gpi1+vZCOFsHdIElzxn3fi1mefSf8n1BsHsIsipqI6O4KE5NM?=
 =?us-ascii?Q?n3n3AUQr60QKN3W96l22GSJZgZOqvvw9QSSijNOXBeSdZx+Z4UKWT2vGTpyt?=
 =?us-ascii?Q?/wI916OXYApij07X5zh2KEvnLKUxsmT6t5tDb8Ttui2Z+JfSijcKphw9r2HP?=
 =?us-ascii?Q?SNQFv4mD4SjxwqzOzE60vUU4HgKZXqtWjAw9HB2TzMzZJ2QS2wMHvqSk8rTO?=
 =?us-ascii?Q?L70vg4CI+vFP9Fjr4RJtz55NZLsiNqvhCy/AMvUqNcCZA+zgkek5dfhsbxnl?=
 =?us-ascii?Q?4t/gcKzkMAtPvjk7FXP6F+5cfM+35veLmeqbONwhHGsJI3SiTyqrHq3itgaH?=
 =?us-ascii?Q?90L8iZUpMgv+2WOUjAumJcQFpLzQ0GSmAWTujNpR5gfOwN4YVg9IcvtQzuG/?=
 =?us-ascii?Q?P1Nj7yTD7jw3vvzDPYE2J8mYUNmp666dupChfMj8pud+Qw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uEHizEepVpOI3jE4x6IASHG1hhFPSGks0sQb0N3QsuFJUjN9SdNi2kEYq/B4?=
 =?us-ascii?Q?KD81x9WJQaYow4/plLk7meQrPCjJ2Tg6XboeBRqChdAE1/ySNz+I+5XcPFIV?=
 =?us-ascii?Q?5RFH8usDP7FQILHolRzdckuA9crskyngTCeeR53ft+511xOFJ7vkTtrqXHme?=
 =?us-ascii?Q?vPBSzKpEe/a/LNCL0sgx8il0vdfZI1XgkuqypH1k/T7r729SVwFX6PX5e+JF?=
 =?us-ascii?Q?FkeH1pXiHCBZlirGc5IkN0V3aU/M76sIGsTyrBKY/iTkB+Dts5G223gwQtXF?=
 =?us-ascii?Q?EAqP8KrPH1wXFSpNfhl6ZJ8qTqjo98XCAOsLXy4LQzWIfYkZoQS/F0ATUagf?=
 =?us-ascii?Q?AKW17WzOGmsw35Buc0BvNO9/IZza06FJwYZ50XE/h4fmzvHjGvR4zP2Dcd0T?=
 =?us-ascii?Q?5wp8cNxcz2TQYWkt0P0PX4kt5VzkjUXMD3ErMrl6q4S1JofE6M4iQULa14a/?=
 =?us-ascii?Q?chA13sP4D/wlu2cithXm7LOqzQci3UQpaMzT5L7rlcDEe3DPKKouVKwpzOW5?=
 =?us-ascii?Q?2DbzL27QOw3q7du4HyZ2F1l7j6Sdjc3W0m8BT2Honrlj3qUxkXyF8zaSDV4e?=
 =?us-ascii?Q?EqUzAYnNvfkmInq+Q1krZhJs8c0G22N+Q/CFcGhh/ORLmReX8idOTEwC0B5v?=
 =?us-ascii?Q?6D+iXfYEQ1gid+iC7d+HRbKbmC41dh2WWsdCDiZIFPA4vYowZ6LxgMYrWkIi?=
 =?us-ascii?Q?KYucNv0DvQ1KAE6iZh0eViLYSSk6GEyFtcYpWnRzfvAtkEeXT0wLHn87yfoU?=
 =?us-ascii?Q?MqezayKn9lOg9lMuSvG4xbAHCVwdlErjNm3mGhHRb9VO/VF16L3UWMph3fqU?=
 =?us-ascii?Q?jPh6QB1LDO2YrRI49F4uCuGrrxSXVgrHDHqFLZrTs+iSp4rBpBg7/Pw/F86w?=
 =?us-ascii?Q?30GgTzUZwU8/oHoWnifr4gqzZgpK5lMOiIBV98eSMFTGjNbmtncDbPuqqXUg?=
 =?us-ascii?Q?GiuW1hZ/jlN0ZjP8cyHEaz3yHYwzNR/tjXSRwGXwEUCSOgvqef+rcpfjG+oR?=
 =?us-ascii?Q?VCxfahoGULQAIAiiYMTOZAwNuwJIq/JQI5vFVuajD3OBuN1MNZSTT6xCWomw?=
 =?us-ascii?Q?ckYfeClK1ns1hqlFr2qinIvnfEGO+lhJkQmdTv/58e8gqhQL9y8aAlFK07tJ?=
 =?us-ascii?Q?J7e9Gq7UeP71hpGjM5LC5Yl5Yr36o+lCegAjhdjdknzFqMru7FAh4F/YKMIH?=
 =?us-ascii?Q?0mYV4Q1Dt98qda1TB4ufrMYzrNu2VYE2biyui3MOsQQep/aQPN2w5/o4Cc1H?=
 =?us-ascii?Q?1zwGvn1sy9Fqnk2b4ItjXV6gZExKDlQ4t4HHlvHN47YM7/pAyCBq9H5X5P3v?=
 =?us-ascii?Q?/AT2R/ZS09KDjZ0aESdm7Iy3q7alcvr3j3lxDG7W3W0rZkG9T1TGX+IhXIWL?=
 =?us-ascii?Q?F1YxHaB4zTuqg8BUitbxgUy1OJR+/3UIt6Kc+xPtTnBsxQ/sIMzgN1E8paHp?=
 =?us-ascii?Q?U1iH3Hdkq8D+byOGacXp4QNZOOkN3ySxveoHesPMAPCvu+JNRAtR25h/Bu90?=
 =?us-ascii?Q?RPuetoOUdsjOevCv9CSYlYQKIpETxiLmmw4QVd2pRSX9NlmgrF1lkiZyCL6s?=
 =?us-ascii?Q?aBGY3sCJgDq7WZ2rRXKPnYb8WkOS5mSPLzM7lAHC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a28d7c-7517-4568-7d89-08dced395948
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 16:49:35.3145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMdo07EU0h/fdj+G3T7GVX+MCtNEUihedbJeejAZgbp0cG4Zp2TLaOxY7cFdob0q7V2f15zv31SZx8fmve73MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8929

On Tue, Oct 15, 2024 at 08:58:37PM +0800, Wei Fang wrote:
> The verdor ID and device ID of i.MX95 EMDIO are different from LS1028A
> EMDIO, so add new vendor ID and device ID to pci_device_id table to
> support i.MX95 EMDIO. And the i.MX95 EMDIO has two pins that need to be
> controlled, namely MDC and MDIO.
>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
> v2 changes: no changes
> ---
>  drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
> index 2445e35a764a..9968a1e9b5ef 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
> @@ -2,6 +2,7 @@
>  /* Copyright 2019 NXP */
>  #include <linux/fsl/enetc_mdio.h>
>  #include <linux/of_mdio.h>
> +#include <linux/pinctrl/consumer.h>
>  #include "enetc_pf.h"
>
>  #define ENETC_MDIO_DEV_ID	0xee01
> @@ -71,6 +72,8 @@ static int enetc_pci_mdio_probe(struct pci_dev *pdev,
>  		dev_info(&pdev->dev, "Enabled ERR050089 workaround\n");
>  	}
>
> +	pinctrl_pm_select_default_state(dev);
> +
>  	err = of_mdiobus_register(bus, dev->of_node);
>  	if (err)
>  		goto err_mdiobus_reg;
> @@ -113,6 +116,7 @@ static void enetc_pci_mdio_remove(struct pci_dev *pdev)
>
>  static const struct pci_device_id enetc_pci_mdio_id_table[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, ENETC_MDIO_DEV_ID) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_NXP2, PCI_DEVICE_ID_NXP2_NETC_EMDIO) },
>  	{ 0, } /* End of table. */
>  };
>  MODULE_DEVICE_TABLE(pci, enetc_pci_mdio_id_table);
> --
> 2.34.1
>

