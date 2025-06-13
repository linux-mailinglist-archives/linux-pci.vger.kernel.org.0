Return-Path: <linux-pci+bounces-29736-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 117D7AD904A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 16:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB1FE17DE36
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 14:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A3817A2F2;
	Fri, 13 Jun 2025 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PpoqvAh1"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012021.outbound.protection.outlook.com [52.101.66.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E3F1C84BB;
	Fri, 13 Jun 2025 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749826494; cv=fail; b=XNCGYRZAtq7WnlP4WlUyabNeW5JFt0jcxKtW5T1V1gWdgzowLpGht3IhNHP0UuHrd/3pEFt1tlXnZbFxdhihK0ln6rXJswbMBQ8b1HnXAZjynAGAvZhj0S5lbBDcxP1QrzYqJvhaKdavFmQqKZLwsH2TuneowrF9izEgyIjZJYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749826494; c=relaxed/simple;
	bh=dI21Zt5WlYPBj4sOkA0bnxpxVZ64HG9NezDcKaUvoZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M+NWYEojrqC7a0Q01bIEVWOLP0yRP+lItmZYIoeGwqTr41nuXF4Ws5GRZtPz5cKCteIBbXto3TbiXtnLfkZ1lq2bRcv/ANN0ax1tGurAMm6qcX5KPdzUomu3SMQpq9w0iMYqKG4h9ZZhkBmVx2eVyEezbJOEaElxmsiRD1un0MY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PpoqvAh1; arc=fail smtp.client-ip=52.101.66.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyA54tXICFQSnW5lxuU6u5KOvLqqDcjGosOt8/ByXaOeWwZmdPjnebQfVuZLfxBH4TI8Gk1bZFF/ernHvBvrWqFa2uPV1DLAi2j8UeAH5nmMbxHp4sHQa5b4za/zKKJ18Ql7PMWY4Ag4Z26OFESeptYcUeeluxGi4zYiGRW89ZPDthZaieu1TAu+10rhDKKd3qiQmeiLkcHWuKoGbFgO5U+zh2Ai2U9dsI2lVhfECED9sM+S5WHvWU5fh3xlxPupHA3GQ/SctLFVOzciCXULgHC6vweHPslSn0VIhTO0m2P5lRgDfc/GxkzVP7SPHNEmAXVJ0mqE/4nzMLjFQ7VMhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Q1p25N4CNo/1O/bFfOxSi8U3Uq239BTW73P1DpYIec=;
 b=g4k40FaB1mX62DC6nhOUeaFcPGAi/F6JKPZbLa+3Bqsf+Cdp6yUD8L5spPEynX5lh9NHQLAwOLIlqMPqRCmiNy5aHIH8fEEGo4LsS3ChZhVY6BwMw0D3AkQ5od0mO06dSunsYQzCMW7frMQzENNB2iB3m+a/T1sWCLF2n+DUQjDv5aWZJdDBj0zBbKgxnDMwXzd3n9RmWIA3vEEQMPKuDVDh+K8ME1Ao4iTu72AHSFg32flEExlQg9LfPJtkjvUqAFR0HXWnY1E3n2f+DgF7w+OMCVT7me5l7GeY0CQNSlnmEdoyT+k1dJeOcZF1RsJUFTWx1ms/tdfcsk8cIHaNdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Q1p25N4CNo/1O/bFfOxSi8U3Uq239BTW73P1DpYIec=;
 b=PpoqvAh14eBBVBEztBy+fS5S8At7ClsOF/Icm42K/TBRN5C83HueTXNZgVboL8/30B4RizS35ZpbBs+YHLnpNPz2hS6aGixNXsibXAMutDYlbfG+gnNE1bLNx3TxGBg+/moBBPwp64RzntUTQ+ZDxTdIOX5hOCOndDvQTdq5xheVlrF5IPwAbflUgKS57JgfcAlSDWXvWs5gew38pd01W2rbvYvzP3hmLr96nZ5P9XBgNPEzXXZcBE9vJ1zFh4E4I9KATt2DDUpskQTUefg/S1WXhi/gLy2P/PfptW5L0orhNp/VBHDGP5l8GfZaojLU7XepWEVINimng2Sqi0UmLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7567.eurprd04.prod.outlook.com (2603:10a6:102:e5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.22; Fri, 13 Jun
 2025 14:54:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 14:54:50 +0000
Date: Fri, 13 Jun 2025 10:54:43 -0400
From: Frank Li <Frank.li@nxp.com>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, mani@kernel.org, robh@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Simplify boolean condition returns in debugfs
Message-ID: <aEw7s7k1vAT1eMdC@lizhi-Precision-Tower-5810>
References: <20250612161226.950937-1-18255117159@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612161226.950937-1-18255117159@163.com>
X-ClientProxiedBy: PH0PR07CA0069.namprd07.prod.outlook.com
 (2603:10b6:510:f::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: d2b07883-33e3-40b8-5f32-08ddaa8a3f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2N57Mb6Bk2APTZz5HHoPtnTbAGPp9BhVtWUCRrR4ZULPLlfduBjcAIptKmD5?=
 =?us-ascii?Q?yflVVppi4GrsJcxX2/utJ9GQOlANyP8m5RLIsc+Fz25ygSzh4ZFMBpLXOhQ3?=
 =?us-ascii?Q?Kcb75B7+9HG58uX+XK8n2xQd8lFJKOwvJDgAUBlb26LK4sDInQx3LVkcgWzl?=
 =?us-ascii?Q?ygC+sLpgtSnXE4f6sGeAq7+qCGW3JxnZ+wabAT4NgOaz9zxizVO3mcGt554v?=
 =?us-ascii?Q?tMZBUUD9kzvtNe7+ToJ08wnw2Uuvspkjb2v6L4migrnCAohB4ONyXeSdjxsE?=
 =?us-ascii?Q?9GmjU/GpVYV4IFGZmzqdcxWkt4uYcQpsFqiOx/g0d0KQFoD52zKSvwULngZt?=
 =?us-ascii?Q?s/3GlZ7txHziftgREKhQHz4dJZJxceF9XIZvc5/ZZdSbvW3k8fHc3wSrMsqK?=
 =?us-ascii?Q?XYzmHQaDWomXuhliH898wwInJsoIOsQhluWrCjMfJ+uJBCcvTe2x+jGM2UbM?=
 =?us-ascii?Q?jjI3vU+772ChgeX531i7e+UIR3sSER6ufGF+yibDEzjpLBntDE5ckr5MDCwc?=
 =?us-ascii?Q?tp9NqMUhWx+sKo36iI8EHSfXIY3DB4d6AANDSibYb8BEake9QtStNxFd3Ro9?=
 =?us-ascii?Q?YpS0I/RixRe298O1eibM7cXfZOLbRp8laDGKggbhxLUXks/8eZ757a92H8Hc?=
 =?us-ascii?Q?PKurScRT+ZDGxrGWHRoFjQHIhY668UPkvfMU3/m6XbTwTG2v40eAfGvJeISl?=
 =?us-ascii?Q?K+ZPVoSB+bVpH9xuhNWXAhRyfVS0xXqTAlpaq7tfAInaxvRFNEy1PrMntlda?=
 =?us-ascii?Q?gyN9RG00e9jP/XKbFp6cMSBXK3YgUdbSyYTLoRziIJoG4eME0LdGbJVdEqRi?=
 =?us-ascii?Q?wal/grHb3yrcFmC8Rltq/LK0NexTTJcaMcqaaV9wmIjSGkyGQLM9NRxBYqRb?=
 =?us-ascii?Q?EK3L3q1p2Xm9URSaNuxf3ohTG7roTsLLI1hZ00oRGkHgQeAgcXrBxUF/048i?=
 =?us-ascii?Q?DW8QGvYRNVKnXdl9TxPyjiXuNHkFihLICj+n8qNwGhJzQxfLrVyx8Ib55lsj?=
 =?us-ascii?Q?0lWDuPoqwXVXPSTmur6ov5pDc0JR4qB164b6k4Tg41iDgrB6CaN5cGuhDaba?=
 =?us-ascii?Q?so66Tf7djseuGtIsfmAIrkwswCQVnLUrOGI2GNmQsPo0nvTya4HArAlIZldg?=
 =?us-ascii?Q?t4wA2ujHIGjCE2QaWyO2WiCIKvJYQ9JMD7NL+yilcGhJL+YL37HCKS+1siU3?=
 =?us-ascii?Q?nSfmncMzkcLDOLC6PxMohT/H2JV39DI3d+8wSP4EQGGzKrnFqqYf8ppPsRry?=
 =?us-ascii?Q?QBlpxE3y1EUTYwfQWfoXhG1sivoAi/p0+9rdsxiKLxTS1oWSQxIbzam1bEum?=
 =?us-ascii?Q?s7kFLLk/fCBicHY6mijx2ed/002n9nOYiEogvn1VakfpcksYpHfLyBcdfTXn?=
 =?us-ascii?Q?U+l1uUr6UpFnTMA1y/LXru4/vUr+WfjPvnVQalXKA4vlxdERmgbiSoUkG/E5?=
 =?us-ascii?Q?gKrNVc1eu0kjiwaoMJGkfm59zoQeW3pz1mP4Y5nPM8iTfG+w/XJOwg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3IrVkoWCRQ9U1yTnLPCs4meQh7qU6Ghl+xVnkc9+6FWw/YPUhzuRFUpgEPf3?=
 =?us-ascii?Q?+QrOyYmhII3MyCPjyK8VbBSb5miIXQEbWcEzFhCIiLjc3jKNVcwXvU7QHtmw?=
 =?us-ascii?Q?HW+2uQRHGUnn1OvWG9dJxlI7jHyT1iS8wR51Y+Si0b0HGNB5O3UiUQBPw1hw?=
 =?us-ascii?Q?Z7A0mrj5OtNBuag4wKpWThWCyoMJQgpDlUV+MJLBs4QP7OY4xgyWTyXkju5g?=
 =?us-ascii?Q?awMw63UNnCcskXTMAxG+ZmutJ/u57l7ZesP9yrZFODuOiYZkiXseVQDiBHsN?=
 =?us-ascii?Q?Be6bgxP5t1Lkrr2I//m+mBPMYUqaSkVXMY2O1PRElrSRjpUV8qWoez77hTuy?=
 =?us-ascii?Q?ljBi4705cGsBDUjoyso8iTsBswaJyeYOofGzEIgVmCG3URBu0/8iw+vvux0N?=
 =?us-ascii?Q?ZXiADbi3Qv/nOaHDaW2EoTS8eP/56OcteDy536cQHdW8WBsZqR0T64gjeel6?=
 =?us-ascii?Q?8N+RTY4C+2hdsv3UZColH74QLVRjyDmKG2MjkFVNmUBeWUTkxAyPn4bB7dp7?=
 =?us-ascii?Q?uwg1MqAQVln9upcVt0JcmSNoI4kFh2iBRp3CgAdbiRdNgX0yL6tolDH7HWpS?=
 =?us-ascii?Q?z5jaGBSn8HSboSEHDpVSe8zpDpmjiZ3vzj7pEBU1v/40S2bhxmESaLkp8s2m?=
 =?us-ascii?Q?HJwDjsxylr9yLWRBQqd6HgrvQejGtOWW7MOnp2NrDHyf6iX75bx0Dz5a27xc?=
 =?us-ascii?Q?FTPHtRnJE3bNJ6tRrRtuL6swHBEMPBlAd5PtwQF51JMgzSNgs7I7c3B+Of/f?=
 =?us-ascii?Q?mvOJEcXQ2FNqtaDD6yn6Eg5bm3iNsEEe77jh9a3O0oSUH6tU9fPhSSr+mc1S?=
 =?us-ascii?Q?6JIofF5hJl1nVIuCp/iZfAptjo1budSYzbUl4auxH5i+78X5es39/GgXEYdq?=
 =?us-ascii?Q?vgRdKwgHjQJmBUUb4+kHxe5EJ5lOSHOIZcIVN+JCQmLMKZHoQbIpqIXoN3i1?=
 =?us-ascii?Q?jddPvIvTuE4nCh5rwMNOXkG9AfpZEEj/H6KuShadoSX6j6Xpt2HhG5IZRXpc?=
 =?us-ascii?Q?gL9E6dZbmHUKPR5OtA6VDJzvfcsXhYbaapeJtmS1c0w/AlAyqx3HYvyI6Lyy?=
 =?us-ascii?Q?pq2+McKbtD3Gdlk6LJhUrjGphVxLVtRg32VHKyAm+dZwawWWRzsSfnAr7lIK?=
 =?us-ascii?Q?cJOD3k4R+Y5eoZe1/G8afSYteP/uiT3Q24HOdP2J3czJFVgpmI9tDDZE+Cvv?=
 =?us-ascii?Q?aPIBgTM8t7R2iAjUYJgmglIHKLKgcssfutCOavEBYXvNvU5PNZNxtPSfD5ce?=
 =?us-ascii?Q?0exUgq3FJDbt2nwsqiV+PJpCPqY0OfVuVi3yHBr7T+Y8xr/6z1qxf5Mj2oDG?=
 =?us-ascii?Q?1GUKq/GwhrcNynaAS9agpvHk2I2g6d7TPz8D+JgNWteg+4JmWI0uQZany2di?=
 =?us-ascii?Q?VPz0aoHnvfzU4NO0codpQ6gCSYHxs7ZcEmRi9MPMkt4kkCIOhEtQ4ns8kuIo?=
 =?us-ascii?Q?MLIb5GUqcP9RUQhQlXNKWbAKTDujVeUak5GbozBjUiqzfdIGQ5SjEg3EVi32?=
 =?us-ascii?Q?7u7dba8W09mvYhAiRCf8KHFV0QMImjOzObSl4ytq2INYFugO9ibAi6fMMxbD?=
 =?us-ascii?Q?6AyEUuzKBJRbOpUo4lneCRQWnQyr+65cw99U581O?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b07883-33e3-40b8-5f32-08ddaa8a3f33
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 14:54:50.0439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0yJ01KZ7cYyrrnaO/U6nmiMqHvWoui0LpZMgqO/n/ey+HOd9K1Lhj6M9jmN12lzEmfit/TrOw9Ns1td3sntqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7567

On Fri, Jun 13, 2025 at 12:12:26AM +0800, Hans Zhang wrote:
> Replace redundant ternary conditional expressions with direct boolean
> returns in PTM visibility functions. Specifically change this pattern:
>
>     return (condition) ? true : false;
>
> to the simpler:
>
>     return condition;
>
> Signed-off-by: Hans Zhang <18255117159@163.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  .../pci/controller/dwc/pcie-designware-debugfs.c   | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> index c67601096c48..6f438a36f840 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> @@ -814,14 +814,14 @@ static bool dw_pcie_ptm_context_update_visible(void *drvdata)
>  {
>  	struct dw_pcie *pci = drvdata;
>
> -	return (pci->mode == DW_PCIE_EP_TYPE) ? true : false;
> +	return pci->mode == DW_PCIE_EP_TYPE;
>  }
>
>  static bool dw_pcie_ptm_context_valid_visible(void *drvdata)
>  {
>  	struct dw_pcie *pci = drvdata;
>
> -	return (pci->mode == DW_PCIE_RC_TYPE) ? true : false;
> +	return pci->mode == DW_PCIE_RC_TYPE;
>  }
>
>  static bool dw_pcie_ptm_local_clock_visible(void *drvdata)
> @@ -834,35 +834,35 @@ static bool dw_pcie_ptm_master_clock_visible(void *drvdata)
>  {
>  	struct dw_pcie *pci = drvdata;
>
> -	return (pci->mode == DW_PCIE_EP_TYPE) ? true : false;
> +	return pci->mode == DW_PCIE_EP_TYPE;
>  }
>
>  static bool dw_pcie_ptm_t1_visible(void *drvdata)
>  {
>  	struct dw_pcie *pci = drvdata;
>
> -	return (pci->mode == DW_PCIE_EP_TYPE) ? true : false;
> +	return pci->mode == DW_PCIE_EP_TYPE;
>  }
>
>  static bool dw_pcie_ptm_t2_visible(void *drvdata)
>  {
>  	struct dw_pcie *pci = drvdata;
>
> -	return (pci->mode == DW_PCIE_RC_TYPE) ? true : false;
> +	return pci->mode == DW_PCIE_RC_TYPE;
>  }
>
>  static bool dw_pcie_ptm_t3_visible(void *drvdata)
>  {
>  	struct dw_pcie *pci = drvdata;
>
> -	return (pci->mode == DW_PCIE_RC_TYPE) ? true : false;
> +	return pci->mode == DW_PCIE_RC_TYPE;
>  }
>
>  static bool dw_pcie_ptm_t4_visible(void *drvdata)
>  {
>  	struct dw_pcie *pci = drvdata;
>
> -	return (pci->mode == DW_PCIE_EP_TYPE) ? true : false;
> +	return pci->mode == DW_PCIE_EP_TYPE;
>  }
>
>  const struct pcie_ptm_ops dw_pcie_ptm_ops = {
>
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> --
> 2.25.1
>

