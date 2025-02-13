Return-Path: <linux-pci+bounces-21357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85A0A348B2
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 16:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F021619BB
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 15:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CC818DF9D;
	Thu, 13 Feb 2025 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lO8pmwG9"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9607F15697B
	for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462304; cv=fail; b=AjUVcTP3977KHBE6+kZOS/X8kQx+nZR/Iozw76TDBIyLadQJlQ5aZVVE8cSWIsbHLY8+0L7mrRroo7KeqP8lmWbc7qfUE+RG+DFOV5PSOUQir8XLGd9YgWSd3U7+FvQ4hjts+zAd17QmFeC1/Z4EXe3tBH5oIAnBwVF3X9XSERk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462304; c=relaxed/simple;
	bh=R7qlRmi2nMS0bmLGxvcxvwLvxPutVZwqaHS5NS88ifQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g+QK2HzfhkuCk7Zpc28mmHZSTWeLzmlwDAhiBNBDfbRnsDXBZ7xmtxOnd6XGYznMJDpYD0/wELKUpkNLyoDCvz4vMiov0GO+UAYVMZTL8BA95xOPan8q2G/cRFYWgCkJyPPpKxYDiFazE9HVvUipHBkBE5b/i8yIbb59SU+QQOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lO8pmwG9; arc=fail smtp.client-ip=40.107.104.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SN0zR4DaMbjzxP1hwe3xb9OHVP+jTmcV+LKsIHXlSoF9m2vhjCGaqu2WkCFu1ZigDlXIa5hxn5sftM63YIovQdm7QEwWLR0xHgqDIK6snRas9oUVo8qctOVHEV5TSrjdiHVZaoQf1CwX2q/F4YstQqPc0prDVct57VP/wmFxQZdMxckupF/tM6kO3WSiCcAEK6IKpqpuPeraY9ZObOroyroqqYqpDI17O+MnN0ePBEzSMwjvUMeBZluGfZam04n7Ad3Pn9FssbhSsELetQbgUT7ltxMmo0KrDaylL+KQZIzzAGuvMGDBAwhZkM4INfnhTO+zFASVKT1lGnx/kHxbow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swVZ4Llj/ql3qYqaBwL3wSNiAEg35qnckHMm3m8tlZg=;
 b=wj2L60MhIavARyJaHRkfwczeE7w6J1CfVaTkQvvdzJRwg5ann+4Ghh5GHlcYD7dBs6x9kDb7iJVM4gYSMPTr6jqGGR+31D+U7A4b6gSLDbaM+tibUtvvohiIYBRX1F/kk7rmZ0QrqMZTR2/RdsMVSWhn6wRe5f5EcPSdoNqDMzpmq/U3jekxybVpK9LGQt7woixtK5Qd+qtvWzwc8bFIGu0WGKbHkgGHlk/TOYzrouD5pCiLcioh/CeZEGltgkpBJDBX3aSS8EosUBqjU3+zdva36oJhUq+Jv0tSORY2FVULv9p05qWWq8wQOtfH7H0GaQCM0LKwoCAnByzlLK2hCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swVZ4Llj/ql3qYqaBwL3wSNiAEg35qnckHMm3m8tlZg=;
 b=lO8pmwG9uQ28izCXX3GJeZHrE2Brr7yosNPARdZ5Zdtkv/k3JTsW7VaRwIkYfOZbNwwnPQ/AUw0qnhSt5RQoBmkZ9LW+xd5XDELogYP7cfgPkh8JNpxpIlqG+1fhRYCAGpn+EmIu2wNBHEsGtCUh3g1k54JVDrrSDyDyCLla8p6dnMdk3RhZDZZt1t11S4/wLgoj5yaX8e/uhdwiLKnovIvW3quc4j1og5GSN21vI8YzmIiK8tkw0BK1laoO037od8o/zC7sMYLuqFMW5aBaI+AevZcb2IzwyiNeyFG+Pq/yCOs2mf0TgiN/6GetrjtfOb2C22KCmzVTgZe+sGYsFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10106.eurprd04.prod.outlook.com (2603:10a6:150:17d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 15:58:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8445.015; Thu, 13 Feb 2025
 15:58:17 +0000
Date: Thu, 13 Feb 2025 10:58:08 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hans Zhang <18255117159@163.com>, Jon Hunter <jonathanh@nvidia.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] misc: pci_endpoint_test: Handle BAR sizes larger than
 INT_MAX
Message-ID: <Z64WkB6uiqbSRpS8@lizhi-Precision-Tower-5810>
References: <20250213133913.17391-2-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213133913.17391-2-cassel@kernel.org>
X-ClientProxiedBy: BY3PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10106:EE_
X-MS-Office365-Filtering-Correlation-Id: 35902a20-9a9b-4b75-cf6d-08dd4c473b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MCbO+QDExzx4DdYqZj5bP5eUfJcpPZeHxgdSJSupHqsPvbJ54lACmQi2CSNI?=
 =?us-ascii?Q?VaGgLNqKwIVNdxGWRTdPmuu4XVVIa3ChsDD+zhaIKBIGM5cp2CrfeSJ+2Osy?=
 =?us-ascii?Q?MNY6l4IhQH57GXKv2YsTxgSkGbOmC65yzt5MZkth4zAayNm6YFM9F1m9NmGX?=
 =?us-ascii?Q?GHS0ZKZzJ5b4UjWRVG8L2Oo/4ZU4ItJ3C6t8V5suJDvD1+GUHc3TUf+BEd97?=
 =?us-ascii?Q?RBYS29UFZtsJDR2LgUdEgVWRQbTS5w/iCXhPjf3+qUu+uuZMXhZcn3prhNiz?=
 =?us-ascii?Q?YXAYNbGrjXEg679zNRnGVHtavHNFDH0Cuew8ku+pxRViHVtU4jqalMcmbOK+?=
 =?us-ascii?Q?78pDMdjLJl6SXAt9Y8luC+XImVAB/uZ3b5hdmRWfVx+XbensgRXQT6qgOuWv?=
 =?us-ascii?Q?xmQbnFbodOyijDb+NLp+XpwpdbOWcSOlKysiUNcVkViNO+UiBwjwPIubOZN3?=
 =?us-ascii?Q?XxqzTwtm2gqr/OGcTmU+uSlxgbCi8uHJD90lMRTa4+IFDfidVJfsVznTneFP?=
 =?us-ascii?Q?AkRgsFRofC/qxNV6r/crr0T70XXN2hjcsDKEB8PNKmWroLxy9X0sxNYPcKjS?=
 =?us-ascii?Q?rFg9lBEsV8E7BT5JsoIPqY7E5g2pkfsFu0iKeix2l8bsPtd4TtSdi15I3in5?=
 =?us-ascii?Q?CZiLptuYgNoP8vF0TbbCohLQx+8w8rEBBn3O/NdF8xbCesMa//6JFb+nVDDa?=
 =?us-ascii?Q?g65fpmLkvyAzucQ3kPYCmlDY05CsQ1Bs8IGjhoStZdbdUuDYsBidGf+q4TNK?=
 =?us-ascii?Q?F6MMOJeUYaheVlpxX7mtLbJ1Prir0SSw3JrxMFea/uupOhvGzxxAsyhtsE2C?=
 =?us-ascii?Q?uzXyYI6J+1u2+M3DIrk/9THuw86iKR+EO06TwSs5d9A8zKR4RjntySJ7Ib8R?=
 =?us-ascii?Q?n+WtqKwvQF3CNrlQBFTWZ+o+jPZ2orFbMT62EPOaul2TGj2t0wqmbrLq1NkH?=
 =?us-ascii?Q?VxcXT+0v1vb4hSsWmGNhYXH9OpW74T7NkDNk1XPSDSpI1r7CuKnl+mLLcMSo?=
 =?us-ascii?Q?+6WAQc+T1OU8XRLqqxHbDTBz9Ly+SVKkIgDC/VeReIv2hS6QLdDkCrZ7tfmx?=
 =?us-ascii?Q?fJVbI5AfD6QIehnJBfSlYU0lXTKqug7h7OdOqGT4K5u+dwUksQ89a/MwOjc1?=
 =?us-ascii?Q?MnSCgA5gnESdqaFeuG5JCjFMoTp3fvZvXT2JoP4ntdCW0vQ64013UFZ760/R?=
 =?us-ascii?Q?X6D6AEk7xVaGGOLTwkjBnWP7F4HvziSKtKZ3D7xxbHkyUAm/H3uico6DrnxS?=
 =?us-ascii?Q?kcvbYHkN7J0tglRFjnTylz5McegjLiJ9BqRiquPE/uRoUUw0udsT/ijD4Mb5?=
 =?us-ascii?Q?xditNooFVJOymodWNEBp3hfLw03AY32PF86Bda3U0XyzX/9Sw2gi7rSmQi7s?=
 =?us-ascii?Q?J5T1PjqwJy1EM/zwfCZhn5Z0rdk2yDTExTSIRJm7NiV9BgZTPPMBBTFEO0tg?=
 =?us-ascii?Q?wmTEgueyFEa4T4lOYwdk8P1PgIsS3hnu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wXayI+zwBFp96WbzKe1+DmNulOLzsdcBUpqJMIIxWp/5Ca2azsE+z6alQ2ay?=
 =?us-ascii?Q?+px0d3BF50+JM3FnBXu2asHtbfqaEdwJJ0i0hYOZMl4Av+4Tmxt9tGG9guZT?=
 =?us-ascii?Q?5ExQ/QGEd5ycA2pNvllfd11Z/fPTgy/9EgyqyDUSsQeH/e/NuNNUaatbofvk?=
 =?us-ascii?Q?PYScpjnil0zMjkmWU46wupCM2GIT0uFaznrkLEo2DRFein3u7/MLA6nwP/f4?=
 =?us-ascii?Q?iKzRkgeoS1VWfQBR+ZREPa/zcyVwj2wK4eF3AOAauLkzufjy9qEC0r9Mhukb?=
 =?us-ascii?Q?1W/B/j1vGulxn3tzObU1assSYoqZhVZrFV/pqNsH41m4AJ5yxzp9eUvUFluv?=
 =?us-ascii?Q?vccGtCui2eLCqHa3ZR6Ta06B5mHBhdOrQkgcQ0EypEH84tDKHsEW/3fmxmkC?=
 =?us-ascii?Q?o7NdPVqDQliMAdBWcD/ZPm+5xayf2cvRf88ofkBWXpMKm2XEcBthMX/ZXL0p?=
 =?us-ascii?Q?pX5MteuL+PYZIUhLydapOzDZW/2MBqFrBwZEKxeSsoNWCd5oN62TE5L4ITf7?=
 =?us-ascii?Q?TIyLB2ycqRzrAmC40yuFkGcx/NXlMFfAsfntbsE8dpiNbCwoULYkKlZUi1P9?=
 =?us-ascii?Q?Fd0vRLvN9IE8v9bbjCPG6VfBad+hnU1xmxNJ0jFLlTz1+yw7ba2UJt2BA3vX?=
 =?us-ascii?Q?kHmJ5j+uM6OcKSGt1vyYTLab45Dlh5ttIBPF+vmH8aPIPb8/obMxR4ZK7ojr?=
 =?us-ascii?Q?DTZMXUtCFK9Sb/PnvkwsZhh6y/jQX+fIQ3stwtddVdMSf3ZLKnmtr4M+Ym4E?=
 =?us-ascii?Q?L6HGBZFb2GAYDatD2xyjIq64AEEmwaeBDLQZvJ0JKFOo+fa3M6yCxbLj/HxQ?=
 =?us-ascii?Q?LttoJUbFspeLDHv7Mn0xgtJ8jHsgjHvdgV0IjfsmY1WgBcqOjC5kAIhBOYSA?=
 =?us-ascii?Q?EPoIqZo3vXgmYaKQfOfrypIwcX/lThtAs080wKPjt5udeoB83i65GGWd/rUm?=
 =?us-ascii?Q?doaDp74xV4daDB7avw/2itfY+CxDoKDuJrxeYz1rPW3jQXCbpBz4E7VcUEIX?=
 =?us-ascii?Q?2cV5XdkRJA98SkRA0FjnmOJZhG2DfMOKpXW1rNaNKxexYBewDW+jwi0GNoBu?=
 =?us-ascii?Q?9L6XnOLTHAkWJRBASYDgVI2kdGGPKZKiwW3h7sY3jDhk5rHVp7QID5ArNIbe?=
 =?us-ascii?Q?8QYh3SKzwtc+Wz3aBd/fOey+IXKy5dF8SfiUlbdlvvFrB4JrmJySAYdahMf5?=
 =?us-ascii?Q?9Bq/xXbwO7ApK2KHB0/OvgJiOSoAfa6drJ2J3hqpEf+HOOkUUT+w0XKS428N?=
 =?us-ascii?Q?OdUpzEiBnfHVmuFaOh5RhlCWN1x42yG9/Mtw4VRyp6Gh5x+wgx1+PZGqjVar?=
 =?us-ascii?Q?ohtlpTrUJY6+wyu+dROahGI3QWCSaoEVT8YdUrXbLgfdpeaybCNQ4DBV+YiK?=
 =?us-ascii?Q?Cfz2dHEvb+bdaIwjUb4zTgBdYuTme92W7Cup13/9EBpMaDGuvSIfCSnDBuTZ?=
 =?us-ascii?Q?O6pZDZAw0LGm6Y5FojKpM3NRMUr6B7PI5B0LF3IHAwYksLGlNMxrk0ZMsYtJ?=
 =?us-ascii?Q?irzAMAgppgjRCAvnHeyXq7ppSlFtiDDwvCkRUiKY2tNs6L7DEyQyvvY68L4Q?=
 =?us-ascii?Q?R5Ds4Rw9tbUV5NsSeEq6J1oaIra0ENqM9uT+0W0K?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35902a20-9a9b-4b75-cf6d-08dd4c473b3b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 15:58:17.8205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYl7um+1Zq5TtGRq+s4hhH+AxEx9t3XUF+PPGyB/lqMoCzldH54bro0I5rQ/y54IN5+tDMUXflJtwNlwzQ4etQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10106

On Thu, Feb 13, 2025 at 02:39:14PM +0100, Niklas Cassel wrote:
> Running 'pcitest -b 0' fails with "TEST FAILED" when the BAR0 size
> is e.g. 8 GB.

pcitest is not exist now. Does it need update to pci_endpoint_test?

Frank

>
> The return value of the pci_resource_len() macro can be larger than that
> of a signed integer type. Thus, when using 'pcitest' with an 8 GB BAR,
> the bar_size of the integer type will overflow.
>
> Change bar_size from integer to resource_size_t to prevent integer
> overflow for large BAR sizes with 32-bit compilers.
>
> In order to handle 64-bit resource_type_t on 32-bit platforms, we would
> have needed to use a function like div_u64() or similar. Instead, change
> the code to use addition instead of division. This avoids the need for
> div_u64() or similar, while also simplifying the code.
>
> Fixes: cda370ec6d1f ("misc: pci_endpoint_test: Avoid using hard-coded BAR sizes")
> Co-developed-by: Hans Zhang <18255117159@163.com>
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> Changes since v2:
> -Add Fixes: tag.
>
>  drivers/misc/pci_endpoint_test.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index d5ac71a49386..8e48a15100f1 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -272,9 +272,9 @@ static const u32 bar_test_pattern[] = {
>  };
>
>  static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
> -					enum pci_barno barno, int offset,
> -					void *write_buf, void *read_buf,
> -					int size)
> +					enum pci_barno barno,
> +					resource_size_t offset, void *write_buf,
> +					void *read_buf, int size)
>  {
>  	memset(write_buf, bar_test_pattern[barno], size);
>  	memcpy_toio(test->bar[barno] + offset, write_buf, size);
> @@ -287,10 +287,11 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
>  static int pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  				  enum pci_barno barno)
>  {
> -	int j, bar_size, buf_size, iters;
> +	resource_size_t bar_size, offset = 0;
>  	void *write_buf __free(kfree) = NULL;
>  	void *read_buf __free(kfree) = NULL;
>  	struct pci_dev *pdev = test->pdev;
> +	int buf_size;
>
>  	if (!test->bar[barno])
>  		return -ENOMEM;
> @@ -314,11 +315,12 @@ static int pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  	if (!read_buf)
>  		return -ENOMEM;
>
> -	iters = bar_size / buf_size;
> -	for (j = 0; j < iters; j++)
> -		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
> -						 write_buf, read_buf, buf_size))
> +	while (offset < bar_size) {
> +		if (pci_endpoint_test_bar_memcmp(test, barno, offset, write_buf,
> +						 read_buf, buf_size))
>  			return -EIO;
> +		offset += buf_size;
> +	}
>
>  	return 0;
>  }
> --
> 2.48.1
>

