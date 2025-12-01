Return-Path: <linux-pci+bounces-42391-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B36FCC98C34
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 19:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EABCD343F1D
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 18:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741A936D513;
	Mon,  1 Dec 2025 18:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mo81w2HO"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013062.outbound.protection.outlook.com [40.107.159.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A3C1C8FBA;
	Mon,  1 Dec 2025 18:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764615012; cv=fail; b=iQ/+AwBFlkvOYLQcZt7PHtUhc/qxaLzb6CoAkMVHbKmjVFwMZH2fdbkgnfkcpcdjjJnWcz/pamEa42yW9oQgb6kgzBY13gwcmHWxu5M+nNdgKJdo2s8LRa7CpvdU2pT7+5OnH/w+BDld54C6BnuGNoj4O0p0O8UIVl+8Kdo+cs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764615012; c=relaxed/simple;
	bh=lultBoYLZCwCvddn0McKX1BtuVn/i96euq9pBnEJ4BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=stbrwkk2tH8w6WZUi2Mj3kYptdyFny4qktlMYvlC8juVFCU6ETb09p0c6udf7UNPcsTKxy3yGKKcaK4T96VJHMUn6xA9S0EXyxUuJ8p2qb/U1pWOTxHlRxP41DrZeSasS5ttOGo6er3OVMHIoX8ElLCgOZjl3an8AfFNupSyRzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mo81w2HO; arc=fail smtp.client-ip=40.107.159.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nn7dMuGfW+YnyPwDKiLOpPo5kmPNgUyVwxonys6mP4o/KnK57rStCDFVKGjVIkeoJKcRRVlx5q50OB6opVromUwytAvYYUFODZi8DyImKW2Ozwhg2JDKa49FKDWYBntuHAXP2RV6kOjXFEiPNCfHctrD7oU0YcnWFjs91kjX08gdGa4i9LvTK2LiqjD6dbDwUMGLnxge/WBV1Bpvnw6l4kyDODF+Zz5RfgGaI5yTae16On7Ng5OWCX34mqWrKjHsTdwB0Bv20wh5w5fA0C14Fo+xlpHr7FD9upZyOONgx22a79Da6CFk/08mKOJcwyAFJchVw/i4klr/lTNjKt7G0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnDY6ECxyQJ6Qb1TXENhku6YK8hg26cLbYPAVxdDS3c=;
 b=P4pnGVSuBboThK+FvBqguU+X1SFup6lZxKNrqx3RN2KDooMWyDgV6KxJnt7Q26voezYgGcTVSIdf3xAGErXXJDhOCUUMocqo7nPO+xQr+K0RXdyEQy95FXDlO/FL2GIejVpd+C9JE27naQ4pi5TMj1uOrTeFJY0TrKYQOZJVk33Wv2c/zwnYQGwJTF1Rb/HA4ftnewqy0igE53t1w2uO7svU1m4jm3ZmT06cflOPhSIv7wtn4I77cTx6Kln5MqNIELE6xxbOZAORLSuYOU9W8uLvpDuwggSivhNCy8zgnKvV0uvUZbZtPLe/eMs/JxdrypHIgT0wMJzcRKVUsXuQhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnDY6ECxyQJ6Qb1TXENhku6YK8hg26cLbYPAVxdDS3c=;
 b=mo81w2HOZ4LVBa4OHEQkxSomZzkwA020phQQFtPXneoX54LIpWBxoNNgWM7qDlxJyiYdcQWszCl9e0aslH1MKonzMo1Mpk+UbU05nl9m5LXTpDIwjaFr79oxOjwRAdQ4cYQcus02NOzUYJqbMl6QtBS5pakngr6Mmyrz+ltQdvZFMYcznyxDEtWwlWSerZJS4H1YP/YmRSV0d821wkrz8/E/RNDxdwdCglNTj3mGom+HFEVn1cvu3LyWgxsMcWNq6F9iQFmX6YOJgUEh43tXjDVys/lsB89jQIeAJQMMbB/VSc9W5T2IDvDP2oMym3pVfva+6MCrrqVS4H0tTTAT2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PAXPR04MB8893.eurprd04.prod.outlook.com (2603:10a6:102:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 18:50:05 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 18:50:05 +0000
Date: Mon, 1 Dec 2025 13:49:56 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, mani@kernel.org,
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
	jbrunet@baylibre.com, lpieralisi@kernel.org, yebin10@huawei.com,
	geert+renesas@glider.be, arnd@arndb.de, stable@vger.kernel.org
Subject: Re: [PATCH v3 7/7] PCI: endpoint: pci-epf-vntb: Manage ntb_dev
 lifetime and fix vpci bus teardown
Message-ID: <aS3jVC5//QYT0DfL@lizhi-Precision-Tower-5810>
References: <20251130151100.2591822-1-den@valinux.co.jp>
 <20251130151100.2591822-8-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251130151100.2591822-8-den@valinux.co.jp>
X-ClientProxiedBy: SJ0PR13CA0228.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::23) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PAXPR04MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: c414de15-a30f-4f74-886d-08de310a70cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|19092799006|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FaR+VOgk1PXNf7FDedAECqrxKL+g5ZYrPWUrnhHr1+T6caNL1kdd2rrDmsAH?=
 =?us-ascii?Q?vk/AWCZNRCjEQE8FTWWF7RgbPKGqAu+COGronrzHz3niPlw2ItruDAJaswOY?=
 =?us-ascii?Q?+7aY2FzEBLMRzpWGM3Tv3Y7dGS6kS9TrNKUAw3e3Kbv3oQHxI0DitjQ4wFPs?=
 =?us-ascii?Q?1W/ez5qpSQ2FOzc1OlvJRJwty3QPC0NYChoei23gzWZl/ZgKgUJ0grpGoQz4?=
 =?us-ascii?Q?G943e3t5Zsm5vmHNYwqFTIposyg7rbJAeRRKWVMfeabDQskuJ3aGKsdd+VKZ?=
 =?us-ascii?Q?elOQUeq5q7B6a7eqbBAqb2pGk9OFeOWgxoh6gNWDduhZoKd2aCTMltF0uNGE?=
 =?us-ascii?Q?X1BRAD7ec5dSOh6IFyIyHTMPlgs5iW4ADFiRDNrRtjTQKKDi9XO9+22gCoGl?=
 =?us-ascii?Q?WsoeoaZ77PF92BFyr43VOOdSOvFZKMeY6Hq2x/xKEsz2hqj8pY0vOASTErXA?=
 =?us-ascii?Q?3VLByNOI9IQqeY7VXY0pgr5BciRVoDmygP5nxDgNBqG8OW2NtmjUt8DzpJwr?=
 =?us-ascii?Q?mNzxO5y73TIwINuLT9WdD7c1EB7LgcsAzasaMJQxzGmYXeQaa+PrMb+EjZLh?=
 =?us-ascii?Q?Nb9PDxdedw/JQE3LZU9JTjZQTMKqf3cRVHGkpLPgXASce3ChjiFA9RAEHLH9?=
 =?us-ascii?Q?f8SHla9UE1rAMTMB8skR5djX7oDaOZwtDoYHeEKlyCm7JIem1r5CbqQy2Jnd?=
 =?us-ascii?Q?ZRTDdKR07cCWa3nDql2cjw0LzmC1ctz9IXS8IbzAbjYQu4dqkmuEzJ9mmkxz?=
 =?us-ascii?Q?70lORiTC7TaHO0djkkkxxPdLatC7Wub+U+YbIxUt+Zud+Ot8GV4YT5JPjENF?=
 =?us-ascii?Q?ci/Bt0PIkEQlKXur4YdI2Xsqn+4+Z7MPbNCWS9pN+FlIdXtcjrTEGsCRL+08?=
 =?us-ascii?Q?5pY1c2F/AhAOBzoJaJ9zLxWm5dbh2uB9Y1EQmG8Cc4le5SgimlPp8h4kVxTV?=
 =?us-ascii?Q?sqQtZYWRbUJMMD4+/Nbql0YKlzjJLhpsyx23T1fSMLmM9Yyvmu0I6L7vTGRW?=
 =?us-ascii?Q?aNGpW0xDrCsCp798Z2FYFMWyx9iL0gt4dSpin7wXDhZfBx2ISDL1OGHrFVWh?=
 =?us-ascii?Q?6thwed+C2x2S3AIt0AxZ8bnAqL9cwbjuLA1PJedwpBlVQ+foAwag2fiZToQ0?=
 =?us-ascii?Q?AisX9qfRP54qNlkcXZG7/c62p1uCU1PnfpZHILxFMUrKKYK/gXoQhCSgJhOW?=
 =?us-ascii?Q?u6VMjmcxFdXrX7A1rCGr4YKW25KdO5CJzpJtD8FjboXxDEUqZT6Uv9AhgZXf?=
 =?us-ascii?Q?w1E3eMz3du7/P5r+KMD3RHvM91urIpdgXNgiUoD+mpVdZ349yyg+tP/VUSO2?=
 =?us-ascii?Q?dl3wzwmxG4qxtjv7JQwLbfz1lB4rqbKg8ow6ehoPY//GLuE+dwpdwA2eJzaz?=
 =?us-ascii?Q?k7EBBE9s7eBlv3NQ92TVCjcm5Kv6fKWnCz0KPpfwu5OjTTc4ZDw1bTZodUzb?=
 =?us-ascii?Q?UR2ZiRCHSPK8/ojBm/Mm/LfY4up2f0/jlfNgQfqiLMPv0wcxtRBeM1dAY2H+?=
 =?us-ascii?Q?kIIytTVXgGmq0JAh8PS8Gzrs99j5Os5UdRZZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(19092799006)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mk5xNA2Qtyc9kKkhZeT0vSjC1dLw9bDZ8cgsaoG/3qDO6sNAciEWCEup3gIq?=
 =?us-ascii?Q?m4FU8JM1JvpqGjkMMPClXd1X9Jsaw1IBaNFmFIGK+GaaCokVFL8rO3uqRKuu?=
 =?us-ascii?Q?hVZhS1V9myTLAhe+2yrIN6kuA/2WCZtNoidYUkG/tefYZL1kpKSc0Awe0B+i?=
 =?us-ascii?Q?At+zR67yo/f2xIqNlUoemQ8Z6iZk+dHSj1EjwI6gKazxeOgU2Gtpdfh+eWEa?=
 =?us-ascii?Q?8wnEa7PmrN4MyOw7XHMDwzvwx5P6YnMBAbMDwXB7L5OOHbVX8+aPnFMvuXDe?=
 =?us-ascii?Q?Rt6dRcvZSy9VQc+l5KehIvKmncdWv9sAyEEQMkSgeEtnHefbvjiJ11eBckcE?=
 =?us-ascii?Q?NdiD3DBU882/XBErdJkgKwe4oBMv3bUS4OrFOu3jrbPAVNi0d4TUh2I4YN0R?=
 =?us-ascii?Q?TKrtuSDWsIsuq2/BR9QtywCpRhrEEyuVHdiJ669Bcd1bWpSk/nDzHPCc9fUY?=
 =?us-ascii?Q?XhY+/VxZxIrYJkjRtL4ITR+ojqLjZZ1ZVlceBFEz1fRGdh1a8kIEYTT0h1vG?=
 =?us-ascii?Q?HZj1kVvsBiMXNEfVPJWiQwlgR39mUHHLEBGY/53cfeCtrA+RkLf4EoYrbWuu?=
 =?us-ascii?Q?zKPpbF05O2/wlAD4xIB7B11uxar4fvOdAxN+gtpU2INZx+U0jAS09GXaRgaD?=
 =?us-ascii?Q?BadBQta3FrkApZDurJvYiBltkOcJlaGZtnd65pa3Cf82HlD6TgFSk3f6gLli?=
 =?us-ascii?Q?0Z+FQutvTHE2fgvJVD0FwUi+/nS/S/uSxT3asn5J5E5Mpx1v2eCiPjC+I5dA?=
 =?us-ascii?Q?yFct+356qlDcA6C02z2DGFjOoYMGX/YW9y86ADBRxWaRjwyH+3Bhc3UX7XA8?=
 =?us-ascii?Q?4xjrm+8IVZUr9Ah4jvnpn8yRuwwH7bhSV6IiBspA/4UxW40oeN0MbYQCWRcI?=
 =?us-ascii?Q?WFDMjtSmc1Kj22CGqjqoQdDjxRI4PQvk3d3k9HnyL/GISE3tuiE9/jXDz3GG?=
 =?us-ascii?Q?df4VJWkAyUBsUZxyho9UuTaqB3p1yP2pViJh+F8zQAnU3Nx8x3JEFzn6APoY?=
 =?us-ascii?Q?E8jmEYhS0YeKPulsdBCbiFupX5QJGTfLmX1VYCb+RaIY4oQcTKX9uwCQeJNS?=
 =?us-ascii?Q?zU4q87YOuvTpexTMD7sz1VlRN4lv+L1wtbvhf3Tz4u2EsuieRzKBTimXexxb?=
 =?us-ascii?Q?RU3YZS+bVdHYHVfRtdxjxgKqBr0iDxgVTtD1SgfZoiInqY8VaX+/svUqU072?=
 =?us-ascii?Q?nVQnApEH20DI0ZLe1Vnl9HexBctoy66FR7novBG3nxEAdgtZdx9RXu2ydgiJ?=
 =?us-ascii?Q?K05/vuFVvwywD8QsHTlUwho2wr6tRaWWd7iv4QiKS23AbWa4eJp575u+KBfm?=
 =?us-ascii?Q?SRRbrZrotPRx2gc+XP4A+lwL843jmy0AiIbLDEGuW2Fsra8pIueSx/gmNVrA?=
 =?us-ascii?Q?EE+T9Lq0JBRJXPvwRSadolNgCMmfIf/ZJCtVXGcHyXDBriPVWPlgYrcMfiKs?=
 =?us-ascii?Q?zQBSPsErxY+PYCjEtt0/TDAdSTJFyf4YRYk9T9eWn7rOkKK/i4Rzo7ldTFO+?=
 =?us-ascii?Q?BvGD8BDyORE2JY8YsWA3WwtQwPpMWFVu7oefLlX/hKDBAYKZ+amL+2JoAWBb?=
 =?us-ascii?Q?3DnjZ5V7ypo4l3RF3GPrl+ECI/a5qvIcxe6HvYzv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c414de15-a30f-4f74-886d-08de310a70cd
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 18:50:05.0131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yX5sWP8Vasj+CD+5wDZGc36dqqaLOLVnUk9NJt6PPRO9HokUACVWiq4M2i+yZictEf0jDOdMFMVqkCqxmD96dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8893

On Mon, Dec 01, 2025 at 12:11:00AM +0900, Koichiro Den wrote:
> Currently ntb_dev is embedded in epf_ntb, while configfs allows starting
> or stopping controller and linking or unlinking functions as you want.
> In fact, re-linking and re-starting is not possible with the embedded
> design and leads to oopses.
>
> Allocate ntb_dev with devm and add a .remove callback to the pci driver
> that calls ntb_unregister_device(). This allows a fresh device to be
> created on the next .bind call.
>
> With these changes, the controller can now be stopped, a function
> unlinked, configfs settings updated, and the controller re-linked and
> restarted without rebooting the endpoint, as long as the underlying
> pci_epc_ops .stop() operation is non-destructive, and .start() can
> restore normal operations.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 52 ++++++++++++++-----
>  1 file changed, 39 insertions(+), 13 deletions(-)
...
> @@ -1097,7 +1103,6 @@ static int vpci_scan_bus(void *sysdata)
>  {
>  	struct pci_bus *vpci_bus;
>  	struct epf_ntb *ndev = sysdata;
> -

Unneccsary change here.

Frank Li

>  	LIST_HEAD(resources);
>  	static struct resource busn_res = {
>  		.start = 0,
> @@ -1115,6 +1120,7 @@ static int vpci_scan_bus(void *sysdata)
>  		pr_err("create pci bus failed\n");
>  		return -EINVAL;
>  	}
> +	ndev->vpci_bus = vpci_bus;
>
>  	pci_bus_add_devices(vpci_bus);
>
> @@ -1159,7 +1165,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
>  	int ret;
>  	struct device *dev;
>
> -	dev = &ntb->ntb.dev;
> +	dev = &ntb->ntb->dev;
>  	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
>  	epf_bar = &ntb->epf->bar[barno];
>  	epf_bar->phys_addr = addr;
> @@ -1259,7 +1265,7 @@ static int vntb_epf_peer_db_set(struct ntb_dev *ndev, u64 db_bits)
>  	ret = pci_epc_raise_irq(ntb->epf->epc, func_no, vfunc_no,
>  				PCI_IRQ_MSI, interrupt_num + 1);
>  	if (ret)
> -		dev_err(&ntb->ntb.dev, "Failed to raise IRQ\n");
> +		dev_err(&ntb->ntb->dev, "Failed to raise IRQ\n");
>
>  	return ret;
>  }
> @@ -1346,9 +1352,12 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
>  	struct device *dev = &pdev->dev;
>
> -	ndev->ntb.pdev = pdev;
> -	ndev->ntb.topo = NTB_TOPO_NONE;
> -	ndev->ntb.ops =  &vntb_epf_ops;
> +	ndev->ntb = devm_kzalloc(dev, sizeof(*ndev->ntb), GFP_KERNEL);
> +	if (!ndev->ntb)
> +		return -ENOMEM;
> +	ndev->ntb->pdev = pdev;
> +	ndev->ntb->topo = NTB_TOPO_NONE;
> +	ndev->ntb->ops = &vntb_epf_ops;
>
>  	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>  	if (ret) {
> @@ -1356,7 +1365,7 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		return ret;
>  	}
>
> -	ret = ntb_register_device(&ndev->ntb);
> +	ret = ntb_register_device(ndev->ntb);
>  	if (ret) {
>  		dev_err(dev, "Failed to register NTB device\n");
>  		return ret;
> @@ -1366,6 +1375,17 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	return 0;
>  }
>
> +static void pci_vntb_remove(struct pci_dev *pdev)
> +{
> +	struct epf_ntb *ndev = (struct epf_ntb *)pdev->sysdata;
> +
> +	if (!ndev || !ndev->ntb)
> +		return;
> +
> +	ntb_unregister_device(ndev->ntb);
> +	ndev->ntb = NULL;
> +}
> +
>  static struct pci_device_id pci_vntb_table[] = {
>  	{
>  		PCI_DEVICE(0xffff, 0xffff),
> @@ -1377,6 +1397,7 @@ static struct pci_driver vntb_pci_driver = {
>  	.name           = "pci-vntb",
>  	.id_table       = pci_vntb_table,
>  	.probe          = pci_vntb_probe,
> +	.remove         = pci_vntb_remove,
>  };
>
>  /* ============ PCIe EPF Driver Bind ====================*/
> @@ -1459,10 +1480,15 @@ static void epf_ntb_unbind(struct pci_epf *epf)
>  {
>  	struct epf_ntb *ntb = epf_get_drvdata(epf);
>
> +	pci_unregister_driver(&vntb_pci_driver);
> +
> +	pci_lock_rescan_remove();
> +	pci_stop_root_bus(ntb->vpci_bus);
> +	pci_remove_root_bus(ntb->vpci_bus);
> +	pci_unlock_rescan_remove();
> +
>  	epf_ntb_epc_cleanup(ntb);
>  	epf_ntb_config_spad_bar_free(ntb);
> -
> -	pci_unregister_driver(&vntb_pci_driver);
>  }
>
>  // EPF driver probe
> --
> 2.48.1
>

