Return-Path: <linux-pci+bounces-42392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BE7C98C3D
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 19:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 713EB343F36
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 18:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAF4207DE2;
	Mon,  1 Dec 2025 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kza3YnSx"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011009.outbound.protection.outlook.com [40.107.130.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85E91C8FBA;
	Mon,  1 Dec 2025 18:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764615124; cv=fail; b=mCYJ9wI6hCzKtdUMdIefaK5zyGoJteiJ5UQYP+2hB/9VoC/ORKZkrRKFLLETfL5G4ZqCVdlhia60D5wTt1HoNQXhlKH/KcoFAqnnPsP3M2MA9q+WxGKfLgLIKVbMUqwpuBw57Xul7JV3nas3iWxvkfM+93KJpDpF4/oHs1X6+no=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764615124; c=relaxed/simple;
	bh=a87RIkVCviprR6gJg6o3KN0wbzS/2oveY9d3mFn7Oqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z+oW7It4s7MF1oTcS8mCkzXmg4bZqrSuHTU0seED3RrFPEClbRNFktuxANBYjpC5Yzu/VKKpJvQBVdh2RzDPvxcf2b8/bJ1b0wjhWh3Hr6TVXbj5OAD9+t5h8hCCFZmq7OPvd1uzibHJdjkcu01aT5sW2NyhIay47WXg819TPCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kza3YnSx; arc=fail smtp.client-ip=40.107.130.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQougm2nm3sT5LIxNmNYdgEqDKiyOWc9gYrxnU7II3WjV66JwcXfbTbd3ENSZI8I//PqGBfiCh0B9kYVLf+zcHgovRDsKG4+bv7Ls9K9x7JGFIrtA9QS5DQ61mxbtBoZf7LCtnFwkznX5tWtXJij7Kbodf2gV0e2o1/TP4ufzrIAzwHCXxrCk8ZJddS7iPYBXcxM/WsvZzagX1uRr73fd/9T7Q2LE7uN3RTvENEVY5kqODxPXF6ghIzoo12tQ/rHF+ACk36nw1QjuzQaxCo5gDmcxd6leRIGMRMOzOQtThRv5Ikz0h+fLQwoS+pAZm+N7R3tEhw8omBq7kPQujDvug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuFgZk9JLRtDp/6ABqN1eW1GSx1RsTOPRbreWR9NmCQ=;
 b=gB/aTUnhcbIKOgyVddaCoVWTi218hu9LSldTYtkUqOe6wZXInmb13gPVMy/QVBu88a6XoemvfIPnnmerfVlYcOAm0gn2Pc47q7QWU1OtQexhPTVhlIeE58N1EtZOW6zrnFZ8H/wHoudcn4rkDKWCQzQaH1gKm2kDP8jQDTkVG05/dsuf1SM338wGDt/2uzeTUlMb7oHrSEU4I2J4Lza3kMuQ1BAvUeUY9UH3znwqKhg07dpSrVTI8svSYR5MsoQuDoz7jDMiUc4nhFjBy2axSA7TAMu9I5UF+vWvJ1mZCx0wpDOZv2+HVwumJBEkhIs1XYDCF0cYO4bdWeSw5OEA7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuFgZk9JLRtDp/6ABqN1eW1GSx1RsTOPRbreWR9NmCQ=;
 b=Kza3YnSxcRSx/StDURpAa/fYC49kkhHP2xHRBmz+bOLFrtuRUEbiDWtBz2PnWT9nwcCIdWoe8OfeW+Y8QvJH7hY0ZHKGBSns0+jXSRTC+AtRpkjJHrP0dXQmuG9Fb/Qw89hLj5zAiMxjiefsmB27x+KpliC81qM43cGuru2c/LUbNzXPkWr8hn0jHGtbjnrWCODvSRgMkJffGVEc8sdbEn+4yNF7DQiSKqYV+2xXfyUN+r7QtDs8dzY54FNa8NvAn2/VjcWbCXjOG/YakdDU80dCSTLAb3S/yD66+qS9VWofyS+LVVqO69IX24XAeBm1dKaH9O6MtO8KbAtDAekmaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PAXPR04MB8893.eurprd04.prod.outlook.com (2603:10a6:102:20c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 18:51:58 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 18:51:58 +0000
Date: Mon, 1 Dec 2025 13:51:49 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, mani@kernel.org,
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
	jbrunet@baylibre.com, lpieralisi@kernel.org, yebin10@huawei.com,
	geert+renesas@glider.be, arnd@arndb.de, stable@vger.kernel.org
Subject: Re: [PATCH v3 6/7] PCI: endpoint: pci-epf-vntb: Switch
 vpci_scan_bus() to use pci_scan_root_bus()
Message-ID: <aS3jxR1YvjWZKYYO@lizhi-Precision-Tower-5810>
References: <20251130151100.2591822-1-den@valinux.co.jp>
 <20251130151100.2591822-7-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251130151100.2591822-7-den@valinux.co.jp>
X-ClientProxiedBy: SJ0PR05CA0152.namprd05.prod.outlook.com
 (2603:10b6:a03:339::7) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PAXPR04MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: cc507eb8-fdf7-418d-8390-08de310ab48d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|19092799006|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aVRLPZ75AYCIJDLIJT2b7E0nIeyjUnNQk0yt/oSBhevgCF6D8RwWP5Xc2Ssm?=
 =?us-ascii?Q?Fo/UD9clcZ06qEnFDBwK4lTmbe7/BLZcjAL1cFfp7gAoTVjxYhdcMaf/YZjA?=
 =?us-ascii?Q?yhcauMZk6FRPatTm85bOhFoxLDITdKBtVexl+q5tuFNp1RK0CWh27F6ch5dN?=
 =?us-ascii?Q?1drXbUmKdRQmJShFozbOPH0RoBYBJcBowP9iDQYpcM+GuvzoDdtsoeakQuk5?=
 =?us-ascii?Q?2Na9gZKSGKGJiLXL93PPFpaJOgrgjBqz3aH63E8h0wIXDGwFOoSzpvhDZemZ?=
 =?us-ascii?Q?/UMpREabx6ObdiFnvpfzU7l4S1ce/l7Mo/agzQGF+sp5x63HhiR3MEk6k3e6?=
 =?us-ascii?Q?IcFJMOOtjTKh3EOZVBVYdbtDnj92RMHLziLmdL/JOMn4dnQdLWrT8dluYcRN?=
 =?us-ascii?Q?s0xU8eJf5+OkIKE+fR/qC8e7sjrOAomTyZYryTW292RLqMirRz8fmbXJxVgY?=
 =?us-ascii?Q?kB7am53ByrK9TJoN/CRWJDwRqDcGkhnfwCw/c8L4PqWOrGl2yTNize2XhWLE?=
 =?us-ascii?Q?+VmVJg67qWJvFcvkLi2Ken5TjFydnOj+dlRciEpY3k/dLS49BOyWQF2bgfIB?=
 =?us-ascii?Q?RcG2hgp7iKC/ofBSaM+tI8hUO/O6vnrSpwmUqRDimZo2b/d2kjiZklQ7F0eE?=
 =?us-ascii?Q?HL3O0SXAIf3tBGCLwfT14lJs391I8XSeowRbab2Y6d6p/C3+MWZyTN6hOC8R?=
 =?us-ascii?Q?m0PtKzD0+FUxMEVizSp++wVWVPi0Am0vvPKHJajhtPWX2gzV4wQ2Ztw2YnH3?=
 =?us-ascii?Q?tvdAiOxPoX5N+kVId9a78ywRSmBEWtK6AHVbKfRU52eyLlhR8SEK0yPQRMcg?=
 =?us-ascii?Q?AdUaDlDNV5KP7fw/A5TbDPtLcVbcgUjyaJg3NhRe7JaTwgK55Z9JthZBYxGC?=
 =?us-ascii?Q?+0OsCysEiotbonmtrYGHebe5zcnM0k1Fr+cEauUSWNMQIH5zZ8BuLcIGDVjc?=
 =?us-ascii?Q?Hxn1z/H7UmAE4sonxqHbS4bffQ6EbLhcllon8m15rZtCyYIzrAm30dpAViDX?=
 =?us-ascii?Q?LkApK+GNHR9LPsZkr3X86qDz0tv7cG/AV8p5vf9Y9YGam/0/3nt4i9yIbA0/?=
 =?us-ascii?Q?ykRACoGs1l1ouOqNetMCcrscLeyKK/DaAyEYpGQmmnP1TlLRjc1ubjPhORsx?=
 =?us-ascii?Q?8dWjd9/QDMmPq8Sl+dKalwCfZI+L7XCWuxfhqTPxAdVfOmdVWrgrXCfEJ/3A?=
 =?us-ascii?Q?GoeCUdk4LgfyC1A6LUfsB+UHg8FYbqxi+cRffAGCrvoVwME51HKfkcxzbIOG?=
 =?us-ascii?Q?2ER1WWGOEH5lf80NXV7GJ1cUujPcwEP1aZwuaUtsPNYgHHrCti7a3EVd8qel?=
 =?us-ascii?Q?j3PA0X0rQWe365Mbv81Vvzbnz66MFl0/Fc6rK+SBwHl0bD+xUQr3TIFYFYXU?=
 =?us-ascii?Q?xKSM2EbIMhd1vsufd6qQDvyH2k+5vvTnOpYNo8w6Vcok9E2kWvdqh/ULLrh+?=
 =?us-ascii?Q?AvhBfFwbgwuvyPRLYylGkwPOutI8UD+t+GVts/NbFTcA5byWJjCzLJN+5ZmS?=
 =?us-ascii?Q?DqCAXldyVyQVWQUsy0xgqF3eOzfvCVlY7ywo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(19092799006)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kgnd4Ir//u8lI7clotgxH+PKn6x1WDS0VprIlfBOZYNjdyd3kJ2+O+Zxtvma?=
 =?us-ascii?Q?xR8EOfcMkdkFPdpAj/XsVTSrHfAky9fXwRw/64+Xqk+Uejnnd8VSxkeQiy4m?=
 =?us-ascii?Q?r4ngh0DqZNbY7hJpPVlJZz0cowfkTgkCG+nmVZ3BOc+iIEH2oGPCpw7jKVti?=
 =?us-ascii?Q?ANVj1XFzP87J+bt0aBWOlFbp/Mw0LsuL+KgNRAtzuZ1gub2wOGE7rm79KwPz?=
 =?us-ascii?Q?Tp1Ax4vLgQj8TVfj8tN/ubJM8gDG1FQHrA2j87k2aHrRfCL3LUx18+12GfOY?=
 =?us-ascii?Q?TQIKH98OhuLMf/meVwjTWVYfxfB773PZiQU10lfIlEW8rdj9x2AnBY49EhXt?=
 =?us-ascii?Q?e/xpWWptDa06pg4KRkWCD229JNKFuFsPPg/XVhgNeQSdA7pHCq+9CSu/aF1l?=
 =?us-ascii?Q?CiAdljG0Ft4NU4Wko/Jq5+MipRNS7O9r+oBVk8N77I8px7V6MGV4DvwpniVT?=
 =?us-ascii?Q?n0GtjORzbSgaXFrIJiT+3a5U1xKkG7mxmyyIwI/K5CVS34nFSuxZy0g5NV1F?=
 =?us-ascii?Q?2Ly5JbxEJzeSiTVbQiwYgKoDS67fPZudt+OaqhNQBrLb2kh69pXeqTYaj1xb?=
 =?us-ascii?Q?/t6yD5Vl6AXkSdab5MTGjhqMU+hi/W9Tq0vaOGCxaAUMEarZMxwlWScB3WRf?=
 =?us-ascii?Q?N9CDVDWZ+bL/DQniBY6DQbIXqRL1oeubeRMVAimfUa2bu4Ojv7XsMSO/u9wn?=
 =?us-ascii?Q?yaq9ag+XyLFb2mvsV7Orr0nb30i7Bnq9VqrtAhvU3mmu6RqF3t0NUlSvVI74?=
 =?us-ascii?Q?1/YeAtbI0viB4dX26oc3OBasaQEob9HGs41+pt1eY61ta4XqEjv1KEJAFfhK?=
 =?us-ascii?Q?jYhZbOYeXlfkk168wCruBeZ17IYadk/Jxmt4K9VKsO+OlBAWEQEWz8YSPjcf?=
 =?us-ascii?Q?seBAWjxFSS/EWoIJBg/XcGdV1Opw05Ti2GV7LgFFt3CBNv5mmqJzH4UgaORJ?=
 =?us-ascii?Q?QZtDKAPoEit5U5QiR9hH7qdlMTNz9v5gO4JDKbZdkZAPBtOw1iDIyxCx2CVH?=
 =?us-ascii?Q?M9UX0ZvkeI7AzrimxdzRW2fEdmrbayAVArFSlF8dOFmgWya00/oXIx9PEIPs?=
 =?us-ascii?Q?o2fgZFOTeZDVEWXFzJThmHwwncLr+y96zt92gwqbLz0ilipfXbSQbpA+TrWl?=
 =?us-ascii?Q?7OD248Y3U97RJhE+FvqFRDm2a7H4TjhVT7VHlJKYdoPz/GzSJXQpOCXGdyDM?=
 =?us-ascii?Q?o0g91XQS2lWKAzKNFzxmPYRfAEBQi0sxRJBJ8qz0jEz4bdjTEHer7bjqwfl3?=
 =?us-ascii?Q?GgXvENGbb7hdGpnBF4Pu1wKu577dJEjSA3VtWm7gwDb9sk4qB+Fv1IhMTcek?=
 =?us-ascii?Q?aYNZcy0uJe/SL5nuzQitDiJrpJ0ZI4ToWtZ8N5EyhlAOhp3+ZCshDVnAMu6J?=
 =?us-ascii?Q?qJb94X1VErkvYlRuAnN5ps5qOuR+hMNUi5nm20OKWvGNrrL2mHLsWgy+8iOh?=
 =?us-ascii?Q?vwny0KHdaKXRqqJMliwyVEl6S0CmbkuqUReewAb4z0D20emlME9jx2BYunjB?=
 =?us-ascii?Q?T0NpsUy7TFcO4d9ccKBdzaM/OsxkghJpw5GnzCN8pFNiALjOTHM2Y48L9qVi?=
 =?us-ascii?Q?7riBv3gX34usDxTlRAXe6DUKtAtX+9YldTN1p0DL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc507eb8-fdf7-418d-8390-08de310ab48d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 18:51:58.3136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OiXm7OM3/ay1nxH4WM/Gz64wzyo1Xy/D8itNPtcUXpJahQDUSNiY3Gb4Z8g9JMhPyAPsTm2sbaghV4h1gCdFVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8893

On Mon, Dec 01, 2025 at 12:10:59AM +0900, Koichiro Den wrote:
> vpci_scan_bus() currently uses pci_scan_bus(), which creates a root bus
> without a parent struct device. In a subsequent change we want to tear
> down the virtual PCI root bus using pci_remove_root_bus(). For that to
> work correctly, the root bus must be associated with a parent device,
> similar to what the removed pci_scan_bus_parented() helper used to do.
>
> Switch vpci_scan_bus() to use pci_scan_root_bus() and pass
> &ndev->epf->epc->dev as the parent. Build the resource list in the same
> way as pci_scan_bus(), so the behavior is unchanged except that the
> virtual root bus now has a proper parent device. This avoids crashes in
> the pci_epf_unbind() -> epf_ntb_unbind() -> pci_remove_root_bus() ->
> pci_bus_release_domain_nr() path once we start removing the root bus in
> a follow-up patch.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 750a246f79c9..af0651c03b20 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1098,7 +1098,19 @@ static int vpci_scan_bus(void *sysdata)
>  	struct pci_bus *vpci_bus;
>  	struct epf_ntb *ndev = sysdata;
>

next patch's remove empty line should be in this patch.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

Frank
> -	vpci_bus = pci_scan_bus(ndev->vbus_number, &vpci_ops, sysdata);
> +	LIST_HEAD(resources);
> +	static struct resource busn_res = {
> +		.start = 0,
> +		.end = 255,
> +		.flags = IORESOURCE_BUS,
> +	};
> +
> +	pci_add_resource(&resources, &ioport_resource);
> +	pci_add_resource(&resources, &iomem_resource);
> +	pci_add_resource(&resources, &busn_res);
> +
> +	vpci_bus = pci_scan_root_bus(&ndev->epf->epc->dev, ndev->vbus_number,
> +				     &vpci_ops, sysdata, &resources);
>  	if (!vpci_bus) {
>  		pr_err("create pci bus failed\n");
>  		return -EINVAL;
> --
> 2.48.1
>

