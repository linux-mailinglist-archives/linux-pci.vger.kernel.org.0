Return-Path: <linux-pci+bounces-24765-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 498E9A7187D
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 15:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C9216F905
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 14:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A492D1E1DEC;
	Wed, 26 Mar 2025 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hTDfoopn"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6771D4A29;
	Wed, 26 Mar 2025 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742999308; cv=fail; b=i3sITNr2VzuHNPfCDMGZ3OzjGMQulceSYFPSKyY4S/qJfUdblD3hg50xX0+A0y/j7X0bNCtjhlNvMQdjzctaL8KO0qT59kbiI2zpWLqPqSyvLIfvG4YsBgGA3OoFKEobUwDwp7gGHO+dDVwHbYXGyAb9+/vYzBJYdlKhQUk5nbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742999308; c=relaxed/simple;
	bh=ASdgdZ87tlsXt3Nrm6aaxG1D47u7E/odC28FK/mfRco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jyBI5nja498BToMB54iYtfZM2m7zt3HdyEkCuRGLC7hH3lmyOkoh5Va94gCKOkoaJyniIviILFW2cdkh74bFauRb7xjepGYJnpTbuQK65CyvVnhbrhf7ADEIst3lHVSK1n+gFTqd5hDAKqF2Va1fai8WcbULn14MJZYVrDfd3qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hTDfoopn; arc=fail smtp.client-ip=40.107.20.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHoQKOvy2Qwsv0dbf0+gBRV70lLFD/M9yR7uCDb32uugLXnYShbVYUL3M5UdWbiGPIuWysktScRUOkZoqv1lYn0YYxBowLwTV5Db016m7xbqQwDQweKJ7snK3TuwPUyLODa6reCLjU5iSGHvhG7J/JG91i2gqJjskHbQvgjUmZVRt6DhByVkYvdAtwZOXsx3hUrsYucSbjXSYhgwg9vczB4o+pqhun8fNjyyshd7dr7BvbXsHzQIbEh4l0h5FjT1UyCfSLiW5xhOQLYa/Ly9CQWKAWGvik+g8lEOzpeMspPqLHa6s0kZTsLFCxQ8PABMyho7Rn7/L27ecb1Sk4xH2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzh99lp4ifrmWnvu7HoHT/VTvRAvmnLLJkE6g86yvpE=;
 b=eq+Vul6W0D9Y6uMFqCKQF7wkVTYkqGC2LkNRuLCw54EG5iPK6pXksS3L6CBmIGnWPGWEJifJUuRVP14u9dW858p8+R9D3PJAjXiWHNHX+PUkgBjNS++C4UxVw6g41eIFnlA1JG08NZ3VLO1etxeOH6CyNQhrrmgoXFDV/MqoDKnuL+ian448vB/1VbVmP2uzV93MbrdoBGgGCKPyWcW1bAjATssz4nvdROiZ9VKs5Elk6NbKobsY4MgoTkaxYpzW7fHHUbX/HF0vLRU5IUGfhJAR5whnl/GDUPGM/yNoZIRcSpWC5lfWIucv1Vlk+1QkNDdethaxYoRLAy01B63MmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzh99lp4ifrmWnvu7HoHT/VTvRAvmnLLJkE6g86yvpE=;
 b=hTDfoopnYzv14drPMv8fTeZLIZAXMUCP4tx0xnJ5K0XUu3jMTerecy1ULdR9lHKRkx2L6tV06WbIPljp7a15itw3HVnshDr24Yd6Si8rK9W6qEEdguZrgOzfovigLIkoZ9oAJyewvBgHvG8p74tU86qVg6uDxEww5WyxvsW5hWsOvRroqvbsHqiG6PYTyE8nzdRKXc3/Sdp1otAlHmNNPn12YYdTdkM02y9I/F1ThQPCpW1/vTNht16MzRW6NNYN9ea/WqdATBokhovikEkrW4VhCw/a1AKMxZVIN751WeMT+9oDVKdRXDA6aUsF2UXTDI/CzHMH8rzgArWoj3qJGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10275.eurprd04.prod.outlook.com (2603:10a6:150:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 14:28:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 14:28:23 +0000
Date: Wed, 26 Mar 2025 10:28:14 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] PCI: imx6: Start link directly when workaround is
 not required
Message-ID: <Z+QO/rO6nXNUNyVw@lizhi-Precision-Tower-5810>
References: <20250326075915.4073725-1-hongxing.zhu@nxp.com>
 <20250326075915.4073725-2-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326075915.4073725-2-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0208.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10275:EE_
X-MS-Office365-Filtering-Correlation-Id: d44d92d1-1d7e-40c3-e664-08dd6c72769c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VEZYDRJpAx+IsV64nk7uwWAX/dwjCsa5dGme1qizIe2sRLG4ymq1UoSN7G83?=
 =?us-ascii?Q?rsAa/X2EhBeyVEiYz1cNDkUn/FB6N9A21HVSVksB1V3WbcucMrpWraaB82EO?=
 =?us-ascii?Q?F/mniTFd5hfXmnId8o+0WIUQAJ6Qh6b3xHE1jYhGte6XKrGl19BxQAzwbSd2?=
 =?us-ascii?Q?uYTSOYuQvbiKww4r9/H/qwQHozxyei2pYEwM/Z0pmJMuQMa5XaPyjj8LC5QA?=
 =?us-ascii?Q?5gnmvY2Jb6+sQ5lvX5dZ2LCZ3HHpaYSyMWoKw6HEtqLefbn6PJ/cpk3ZBRrK?=
 =?us-ascii?Q?EbsMjffG4Tqm9hML8loMpaOjSr5xXy4dy3vL5hMUIrhMuHF6zNmHH7VZNSxA?=
 =?us-ascii?Q?qZMhk4foyze0/bss2egptKKj6v2/pq/nT8KUlGNpXqKJ9gyucE+nYDgMZnHM?=
 =?us-ascii?Q?Y0CLHsKj6bmqL6EIxbGP5y9K/r+IZWF9tJtvb5Emxm/oS5i9QB2RrvSgXQ2u?=
 =?us-ascii?Q?VwkGHjMZS0Qwu/MGyiYN8xuw7T6mGG+R4rpZyXQz8I13yn03HowG1PhlLGLD?=
 =?us-ascii?Q?q67ggC3hdv550hRAB/NWPAGGtXzKg7bhRw1Ej69MJQyJYl2XNSdjEaBV7TLP?=
 =?us-ascii?Q?uRgiVyp0/JjAaNkfIpNVm96uEHFGY/TMEmbPF3sp3BD+bQpJlBBuCotuqZXs?=
 =?us-ascii?Q?fWeRxNwB1V6Oc3/AEyzfcFptqwySGQthXqL9WGBjGh8rIa3T7R8wkqy07pr+?=
 =?us-ascii?Q?ekububnwN8STyi26dTRfaHWlyTuYYPjwgLJ8dAF1yPE810Db/P7zgub4+Nb4?=
 =?us-ascii?Q?WcXtailxr1t0T9kIA2WyfuEqIpxrsZUOR3GaPD+ib9NhPsWQy7xT4Ghj1ZrS?=
 =?us-ascii?Q?ON4Pg2gOeWPibVL6XN9C8z4N7GIiBUxpYsmLYEUWbYOS1946lv63XeYYCxDz?=
 =?us-ascii?Q?QADQvVWeg85t777WMt+92rNzyX5lxEUwCmg4NtkuKY8SZnlwxMOp6+1/w11v?=
 =?us-ascii?Q?+q9JanDryFVK2QGTlO0Hh7dF7p8YsBpwhebWEQxFlQ3kS1A0qAsHSCq5H/VZ?=
 =?us-ascii?Q?bRapB0lgeXjcj6aPvSq2aMsxUl7vF1JNTJR3i5v+GCy9LqCfxPejXSA3ZT/7?=
 =?us-ascii?Q?mQlsAdMpl5umyQP6aD5epY9ABHJ6zO2WGzdU0U+RQSHls9vUmZTI8i0uK1xT?=
 =?us-ascii?Q?jC0H9KbgHt9EuJWEd0TFmmUZ4A3vunD58ldbtiZisU6EGVFh9NMsyuLXMjBL?=
 =?us-ascii?Q?YRC2sJWJRRd30ZVn9miemVOAXSEtPDuDLFABjO2KdItc+khlHcjn38v2sgPQ?=
 =?us-ascii?Q?VGgmFMaQJpJAmp3YJX457vEgXXdbO+MvVVR94i1OL4prtwQQc+zaR68Kh7/l?=
 =?us-ascii?Q?fW2x+CD/QB5w3k4sefZePuWgDJpTfeRawupWQ/5650T+PXVXCcoQpK2I0aNh?=
 =?us-ascii?Q?TVyh9GW/vi1JzB/mHnDle7WjSSEO6XKwN/VFdYEV2d1rBlpZR0KfNLK3v9tq?=
 =?us-ascii?Q?Pw2mnc//knklES+N9Kovo8HzEa7mNpXtZFE0P0HuvEs15IW0iC3IWYlf4ABh?=
 =?us-ascii?Q?8CFHWfOdzpJg+IA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OqmHYEe9fWcuXnVwaECzsBUzS58vWu7Reoo9Sg9NzFGkTgHH3Fg36GpfMJmm?=
 =?us-ascii?Q?okuLvGDTUYl8A5U2TgpJM0UD7UjWJfhMhn2CltgSy5d6LfICbvQI1d3IbW9c?=
 =?us-ascii?Q?GTDZvFU9eQKZManheognmHsi/9qbp9R9UrBXcWOAf7guFxyrn92yo8Jsvgmn?=
 =?us-ascii?Q?u7xXJ4RepA9uxoCo49YdptapHr2qEJPmSa+y0dttKpL2F/3Pc2bH/GCoYGFu?=
 =?us-ascii?Q?nrpKLs83bDUQ3T3NeQGak3Wtgmjod/csirmWpqF1UOhsERbpKIOEXn39fBuz?=
 =?us-ascii?Q?w+s0x73vhVfVzNXZmuoTi4qe3J/L2Bc+2S+Yv03F6kfG6bFkqeDURXpYzz1s?=
 =?us-ascii?Q?31GT91TLv9AFwiP503VD7mnyJetkNA/TyzKFG6S2DVui/Bh06+A68cSdnIyk?=
 =?us-ascii?Q?DcBC8rNR3MB4n7mw3Rvz9AsF/6yjMFGCRypOcktakMAno9nPahb6qngiEvvm?=
 =?us-ascii?Q?GzW3+ZKFtQ/y9x6j9eNAhFKbEAx4UZTEHKX+Al1IvIi7GWOvZqO70/JYVsvq?=
 =?us-ascii?Q?olrRgcIDgM/y9YNoTKH5NanmBaxeE6jWHPLd1Vj44JWvUpjkU6rRG7DHPkJv?=
 =?us-ascii?Q?meHD9yfhKEr6IGnWZkhz7G4OdTU1zDo6jlg3yeb5QU6CRf3nsnTKtkh+iuu8?=
 =?us-ascii?Q?1XelKRSA9ytb8bZU8Er0LufCB3afEFdxmCgg3bQBTbuCKKenEaM/V3jCrBie?=
 =?us-ascii?Q?4ir56VXivUho9MEs9OtURhOtsDpd6wox5wwvMonC9cRB0ULkmMROaCN58mMZ?=
 =?us-ascii?Q?tGPv9CsPzRamEUzk5zfbCaqhNq8wAj02UzQW5O4JabYYEzyzTgFn9nDBZJb8?=
 =?us-ascii?Q?YBhgpVWVFC+YuxCrmDAF08AtOGfnN/TeuLKymQVW7TP8ZoprC6KuiEHGllFd?=
 =?us-ascii?Q?pIQrhKsyscFZHvdpRAh3Dtee6mC7JkqRjkDZyVdj7b20mBTctoe1cx98Lpi+?=
 =?us-ascii?Q?0s7AbpdDRyaEXx36MXl7AjXXf9WysbUDaQPP0pq/vTqpsDrfIKgVSKTKUu5W?=
 =?us-ascii?Q?EhBkvzRxkj/JRlB4QESAveKTGAqVSHRYGms4LpgHygea15cNsArAdlyKVSR+?=
 =?us-ascii?Q?pw32ZQH5FAxaT+KTSDhoB+cz/2v7gxTRU4ebAjmJj1z+1bDittERpbYbN5XP?=
 =?us-ascii?Q?Gbc3OjyhVhOLowp7wkoqG+qT7H6Ga3N1Gqz0D4euRYiFKVVoQ48cNKafAWr4?=
 =?us-ascii?Q?trFDOXtKQHxAkQ981ccc8W8+aDXqqHIsL5ByiIE3gXb2xdbcM+atgjofcbH0?=
 =?us-ascii?Q?QxQHJJksW1KptBK1vpo2mVjjH0jpjHSXmBkWZNFJT6+9HWvNeUJ6dobRn8e0?=
 =?us-ascii?Q?or+J+ExuTw5HKGh8bmNYoj/ERKb1frOXZcV6MWEKIQUB2NpDkJNXWlDe3J9q?=
 =?us-ascii?Q?gJHFu7FNa8rX2iPp5xlaR9JjCqmMGMA83gnLs8trh35Sgzbiedo46g729S37?=
 =?us-ascii?Q?+REQ2QTP7W5fjLzekl7iE3mbw+NMmEwlIKSouuG2TWtMs0yFPsTGtQvx/VBc?=
 =?us-ascii?Q?PUFMSXgM5mW1+D4URRsrSNirOgC7MpFMPgEeYiVzCgO4X0VeiQk6LajxfEUu?=
 =?us-ascii?Q?D1jdVLeDpBGAL5WXneA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d44d92d1-1d7e-40c3-e664-08dd6c72769c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 14:28:23.1745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZyPpiS+MWlWe57nfXUK3yfiaYSkyZK4TiHyX5xCfo9Lk5wEIUc1w3ax2ScwC0WnrTTg4EOqvwwA570+fbLzAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10275

On Wed, Mar 26, 2025 at 03:59:10PM +0800, Richard Zhu wrote:
> The current link setup procedure is more like one workaround to detect

Needn't "more like", it is one workaround.

> the device behind PCIe switches on some i.MX6 platforms.
>
> To describe more accurately, change the flag name from
> IMX_PCIE_FLAG_IMX_SPEED_CHANGE to IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND.
>
> Then, start PCIe link directly when this flag is not set on i.MX7 or

Start PCIe ...

> later paltforms to simple and speed up link training.

typo paltforms, please run

./scripts/checkpatch.pl -g HEAD --strict --codespell

>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 34 +++++++++++----------------
>  1 file changed, 14 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index c1f7904e3600..57aa777231ae 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -91,7 +91,7 @@ enum imx_pcie_variants {
>  };
>
>  #define IMX_PCIE_FLAG_IMX_PHY			BIT(0)
> -#define IMX_PCIE_FLAG_IMX_SPEED_CHANGE		BIT(1)
> +#define IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND	BIT(1)
>  #define IMX_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
>  #define IMX_PCIE_FLAG_HAS_PHYDRV		BIT(3)
>  #define IMX_PCIE_FLAG_HAS_APP_RESET		BIT(4)
> @@ -860,6 +860,12 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>  	u32 tmp;
>  	int ret;
>
> +	if (!(imx_pcie->drvdata->flags &
> +	    IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND)) {
> +		imx_pcie_ltssm_enable(dev);
> +		return 0;
> +	}
> +
>  	/*
>  	 * Force Gen1 operation when starting the link.  In case the link is
>  	 * started in Gen2 mode, there is a possibility the devices on the
> @@ -896,22 +902,10 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
>  		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
>  		dw_pcie_dbi_ro_wr_dis(pci);
>
> -		if (imx_pcie->drvdata->flags &
> -		    IMX_PCIE_FLAG_IMX_SPEED_CHANGE) {
> -
> -			/*
> -			 * On i.MX7, DIRECT_SPEED_CHANGE behaves differently
> -			 * from i.MX6 family when no link speed transition
> -			 * occurs and we go Gen1 -> yep, Gen1. The difference
> -			 * is that, in such case, it will not be cleared by HW
> -			 * which will cause the following code to report false
> -			 * failure.
> -			 */
> -			ret = imx_pcie_wait_for_speed_change(imx_pcie);
> -			if (ret) {
> -				dev_err(dev, "Failed to bring link up!\n");
> -				goto err_reset_phy;
> -			}
> +		ret = imx_pcie_wait_for_speed_change(imx_pcie);
> +		if (ret) {
> +			dev_err(dev, "Failed to bring link up!\n");
> +			goto err_reset_phy;
>  		}
>
>  		/* Make sure link training is finished as well! */
> @@ -1665,7 +1659,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX6Q] = {
>  		.variant = IMX6Q,
>  		.flags = IMX_PCIE_FLAG_IMX_PHY |
> -			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
> +			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
>  			 IMX_PCIE_FLAG_BROKEN_SUSPEND |
>  			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.dbi_length = 0x200,
> @@ -1681,7 +1675,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX6SX] = {
>  		.variant = IMX6SX,
>  		.flags = IMX_PCIE_FLAG_IMX_PHY |
> -			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
> +			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
>  			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
>  		.ltssm_off = IOMUXC_GPR12,
> @@ -1696,7 +1690,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX6QP] = {
>  		.variant = IMX6QP,
>  		.flags = IMX_PCIE_FLAG_IMX_PHY |
> -			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
> +			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
>  			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.dbi_length = 0x200,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
> --
> 2.37.1
>

