Return-Path: <linux-pci+bounces-30124-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB5CADF603
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 20:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3127C7ACBF5
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 18:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ED727E07E;
	Wed, 18 Jun 2025 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nMkxoSXo"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010002.outbound.protection.outlook.com [52.101.84.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B08E3085D2;
	Wed, 18 Jun 2025 18:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750271810; cv=fail; b=BLfwIluN+OqNaw2XjE+Lpf+Bp7QMmdB0C/iBMMsOFP6xjJTg5Fe8UhqLnqpSpdjbVb2QDixGhTxseSdyqhqWT9IC4U4bCqJhQDSNpQn8rLHcTQTbMYUhibBgzbUaCTmEXxcZtr6TTCWOIYnwBNnkl7ciRbNqAtXP5T6UTrZHACc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750271810; c=relaxed/simple;
	bh=gBCOy4nTBYd3OGmMAcI32gqaZ4geYi9NDEBQ83TeGyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uuoh334uFdc3+VfwBmf9pmnricZ9pDkl8/DY8QTDIpv4bacl0LPGZxweTQQ6fDaqinF0IoIkPhvRHMcx0ygSB4IOGhgCdQdXoT3n8GO5kE/66+ddI3q/ajYpyyitzpXslzzoMnC10WueqKre3VjrjV+32V1kj8In3ywwSsBMHQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nMkxoSXo; arc=fail smtp.client-ip=52.101.84.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cW6Tx7S6V0raKAo7BQyylUu95PXoqChn5R65pJoaNRgxTd7wfOelYDYbW86/gs2nJZnsNKpwNk8mxMBuO2SDXgfycFes6SJTh1x1CaEr8WPBfNek5fWrknvSWjYsNtSeJbJPkce10k/5HGG2CKYQrzssJsnNT4Mrp0ytfaXOBK9HO0kbPupbY10ktTA8xWTUDzEUcsoVICTw4TEppe3Hd6r/zFmRqhT75N75JjyrheJsfLR4KF5jp88bZPg7OZQUj+eqDqZdB0Hq9Kl3d4qJsobOo+sEkcM3ub95xGGCRmoXzzLm0vpGIvOwIE40q6hR/wDvPWS2Mtc07VfbtuxdKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eS5+jmiTJqG/ieIUXL7NSISFqEbvsBCvlolqAV81NtM=;
 b=Wnsh41f+68Dyypk42SDH/kTVfNv5amhbmLRxObN+MdDbeJEHUC9/4vggcHtf8Tb1vj+frV6YkeYrnml0sq3YCv3/Ay0yXZaUEabyF0W8ef4FaN+c8aq7onrF9N2IzdRsCehOuXXUCcvSqMnJ62G9X70zdvzUbVcedb8q6iX6Viq3LdsVUxD86/vQ0GlOljTwwLSE5XraB1pe9MIZFy6g9tfP2v14smoNtXbAV29a73UlmrrBX37lNefcW4/ne25uIm7LGoA6HicLXVePf0XZDh6sIklvk+aru5GQXcxUf2hbe5hkR/+J8UmFvNyfK8uiNLxYatSd2/Lk44Z2tBDgbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eS5+jmiTJqG/ieIUXL7NSISFqEbvsBCvlolqAV81NtM=;
 b=nMkxoSXoXluTrQQ/PTc5EPIOUK5KU6oAZHvP1817Xi63SPGL8HPY7dQJnHqaVGkIbsa0p2Uamkk+qvSi7KHnRdH1HjEg7DHwfaW0hcxjezOEK44cMx9f2+QQn2wLExA3eAGwehvKW2C4h8YfiLynRgxSePqptyh7zzlTd5ZT1vSL4OgetZOt7YEg+0lkvjHkHYeA1BvobYV45xIPx9Qq7k07iIol9IGrSf64t494EzZu8rIdkdJl+LWjAwcBYNllxYkKAInX856QV+ZYbMe4O7otFmLzweKK+Ws2N+i/Wuygbc0RbRKyT7GXe+ewhDauJO2M9zn90iZ/iSa+GPEq6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10324.eurprd04.prod.outlook.com (2603:10a6:102:448::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 18:36:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 18:36:44 +0000
Date: Wed, 18 Jun 2025 14:36:36 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] PCI: imx6: Don't poll LTSSM state of i.MX6QP PCIe
 in PM operations
Message-ID: <aFMHNIGV42LbpKP0@lizhi-Precision-Tower-5810>
References: <20250618024116.3704579-1-hongxing.zhu@nxp.com>
 <20250618024116.3704579-2-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618024116.3704579-2-hongxing.zhu@nxp.com>
X-ClientProxiedBy: PH8PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10324:EE_
X-MS-Office365-Filtering-Correlation-Id: a571c085-39d5-429d-8b07-08ddae97135d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cvu1Tvpd++O9Vsx89csRGNXpDQEAQLbytGc/Rknc0tBa29uqDmlxHpDtfEvz?=
 =?us-ascii?Q?qEKbUKAHYVQSYATZrhtLMrfT9UIOO2c942erULTppv7at8t9HZJQTE9yLS80?=
 =?us-ascii?Q?vDcmlGN0/eOBFETI51k2YAmP3nFKGvO4WSJLC8+Vrln1F0pP7BCxYLyM8FIl?=
 =?us-ascii?Q?2Pp4Q0KOR72Q++cbExLDj8lik/lfJC8ChiBKr1eR4+Rm00zOTqC8GGFtg/iR?=
 =?us-ascii?Q?Y424yt3vkM+HbE4daWb7md/d/6ou/VlhCxmM/wTPBfCdSqUne3+A62wnlvuW?=
 =?us-ascii?Q?a8wAYUfHe6F34o7FW6dnuyb43cI/tu8v3SwaPRzoqY/Rg0eRCGwKem2O1UP8?=
 =?us-ascii?Q?/q/6j7TGEqQXarfeLo9rNyB67G/mf/0Ldm7Yb3F3+MWgrLRyKWR9sh9MtSgl?=
 =?us-ascii?Q?xtY0/0byq9YHVxew7ppSV6XEVxD9KLNzbfrc1LsR7StuHBcBbENJ7jurr44h?=
 =?us-ascii?Q?jBiTi2jGjqL21W+6tJJB3WNzx4c/82T0vuZI9JAQ9epGbZPFBaH94VFHyzvx?=
 =?us-ascii?Q?boDOYdcM6DUrvYAnFIWUgzjalK3yM6tYtX4DBA/WqXfVhKCDHufvFSSZmEfF?=
 =?us-ascii?Q?HI56Q1JKl2TLz9jksNafliv7Qth6SSeoK7U2goLaVuqyETiRi0KeP17+D4Jw?=
 =?us-ascii?Q?1Rm37iYMNXPzE88DZXOzZwZEyB2BMWN73FbUOMl9YF4N07OAFKn9pocluoRN?=
 =?us-ascii?Q?JeInOBUKtZWOUJmL+cyUjYmz4RDiegEChC/LT5UGdw9X3yHYk8OkO9uIbFTv?=
 =?us-ascii?Q?4+ZZXCkm58XyRPO83DeFhAZY2lXk6JeJkPqnlyO7yxnBfqxLRjL3vZEeIvTH?=
 =?us-ascii?Q?IBT3LPU7ZwvhKw1EnoE5UoTRKea08Rxi29q/JTVaaPWUNsWezkO6isLOOuvg?=
 =?us-ascii?Q?loG1n+zp5I9t5slewg9iIxYc/LuCLdGIvNATdWeYCYkTSf7v9ssDkJZIfZ3Q?=
 =?us-ascii?Q?CupA7dtG55nWVrUv0SkQtFF8sVeNDxsX9u852qS4D7pmPtQCBc8XFrvoRVDn?=
 =?us-ascii?Q?FI7P2g/DH/bqc9Qs2vMaRoUYgQkDWPSs14273FJfgz+QDo2J1ukajpcdTmWb?=
 =?us-ascii?Q?2D+9WSs0UAoWTahjBXU8erDySF8ryD1qjPCT5896RJDsd83k9K9YylFpzVZM?=
 =?us-ascii?Q?7fymL/WPjLeyy8XZ4RAz/ORKD2OvGGU6w0/FMBkdsJp8X7t2LKKhc/Rz6Ack?=
 =?us-ascii?Q?YE5k5QJmKHYTtNk2ZEh5qvlUC9hNpn24Ny68Zv3VvcU8mwegu/EKKwP0pVJn?=
 =?us-ascii?Q?TFzrm5LlbQD9St14k9EoIUGh1ShW5eKMfDbhom9d3Z6w/HqIgL2LzK2go6/p?=
 =?us-ascii?Q?rHaBZna+uwJUO1ze0IrBdwSEKIn1ElM2ZKFTvFZ2zEy5WHn52WEaN5Lx3P6h?=
 =?us-ascii?Q?nVYQehn9d91+/OdMG2vnCANvbEoYUNXVYa81yb52cfNLWzJjG2LWxgASwVOD?=
 =?us-ascii?Q?zYoPEg2Ls/Uov2/kcI3XyALIU0mTWhY4OOBaMetB+zsxlYs9L/7LJA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ADWChMAXJbhUXUTOI/CpK1D5UUQVzXM0NKVxqTujkKRqeGlTg4nx3A5dsMvh?=
 =?us-ascii?Q?raFlPB8jIgQnduMSaKbdcTjy+nWEtRfntnGDDz3/LLVv6jXCQbwF4IRVwg3j?=
 =?us-ascii?Q?5BRs02YP/4vHK4k1u/LZTBOkou5wFihq9a8WMhvpOYpE4hYSAl3ai3IW/Vvq?=
 =?us-ascii?Q?mST1V02Ds8gVxp+dOrYt1WB5/lUNuZsZaGoWhy2TivAExaTX7X25QvGWAVrH?=
 =?us-ascii?Q?ExF6LqV5jES4PEFIbmgvCBsiKn6bx4dYQUoMWFZKEbXSj4fFjPgWwQZBW7qd?=
 =?us-ascii?Q?ikUiYWQbP71Zr6kxguqXoImxfscmaVXNmQeXboyyXX3gNIhbyuQF0Zbd+wxR?=
 =?us-ascii?Q?j8Kk6h3FOllkp4hmRvbzSpOyyY2R2XPC24jypYuBMUvjlzVQ6QXPi/CQa7XX?=
 =?us-ascii?Q?CbaNQpGcBZxI2HM0DYjBPXQsGNkl82NLI5Bq4lecvfiGePWsxulMuO03zDas?=
 =?us-ascii?Q?lSDK0rsvWS8a8fciN/JficpkCWLbIIxQX1tM79A1D1HnpruOyioWfrFg6PfX?=
 =?us-ascii?Q?mA6nGRlfBQb1QBzAlaAsiOsnXJZnih2xHjnnWHgZeDox0k0uXIPmkkcsqlGv?=
 =?us-ascii?Q?6Bxv4UB7qll2oRmi8vxvoBWBrwSM1C3akdxQ1W2uLOgwBU3fI+zJc3fAJO0U?=
 =?us-ascii?Q?76W+ncewsD1o7M0bZza4/advxkh5mxQAG+IJvQFdtn+xDyxdOicMOVMD69Vp?=
 =?us-ascii?Q?Yv6MNfeJBKS8+FQQudqYtL48dl82qVZ2x0sTHGm5Wh+SFdd5X6Px+k5RvUXU?=
 =?us-ascii?Q?SFf8NjcwZ0klQSDRVDDZGYLywgBxwcvbuvcAMNDl7o4hcpWikAoAsiAplyzf?=
 =?us-ascii?Q?L+vHe//Qc3e4QSKYb0WzE9jQkf/gt0+63ATGgslfCVK12IWGXLir8WnuhlOq?=
 =?us-ascii?Q?gXYT9G+qh1gmUWcnAXapHGO1oqxpZ3Am8XycSmk1Ui3K/7Kqg3zqQHts9nFU?=
 =?us-ascii?Q?HPYBt+6vptwr5opweJtvOtUymNF+n+v+Rkdu79UT9mNUbD+OCDmqlE+q0uJ/?=
 =?us-ascii?Q?iKUGZPSAYjXy+poeD/409Cgi+EYBtnXyPwA2p3LOaCUqKP030E1nkELvYs4g?=
 =?us-ascii?Q?gA5Sl53Z/0oBNKthGGTrLKBDDodtDWaE/06zMeK4S9HTTgB66mNbEkrotoXz?=
 =?us-ascii?Q?kAff6K1Jg20zj+hhGBs1wqITwLpxXQDdnV7SFhT6H/H0gk3KW4Mjm/8S3nZP?=
 =?us-ascii?Q?/6cOQUlHC9RONLAPE0CBgGtZVDGX8bBJoCj++DNOxr1X3dMZVlrqWwTZddHv?=
 =?us-ascii?Q?LLLl0oXWVAKQPlaYhtPiJ7mp0zu0hJwZ1JCveHBbNmu4kLxPeD1x/bkJiBi7?=
 =?us-ascii?Q?XbVrviwr6okWwMrW1iB9SjrsQLeXqucWHGOXUPFN+9Veh/SDYlPG9p9FLsl5?=
 =?us-ascii?Q?Atll8p8F4vaFQBVJfMaALdb5K/xPYNiG0mdX4YbuBCywsWjgXFnvA2C/nvx8?=
 =?us-ascii?Q?zjbGgvDjgpka0Z4I3GBE1msCzWP2EkAXMWrEq7Jew5xbqkL68ucdZbMyzrHX?=
 =?us-ascii?Q?hcTP/i0kLV5iJv787+zvL4mXdkk9eT/RE8FCOq+nIusx4v4zHvIqisZJOsL3?=
 =?us-ascii?Q?OddRzEkTM06RbMd65R+WzOZio9Dkta63xTEY4A1g?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a571c085-39d5-429d-8b07-08ddae97135d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 18:36:44.7726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cUtJ81KFkxPSeQv/9CiypGxcZWzxwulgLwXvDUbaBphlECMYUVRQb1RGPEwel4jB1dv5MXEwA6Jg2/BdGZZF1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10324

On Wed, Jun 18, 2025 at 10:41:12AM +0800, Richard Zhu wrote:
> Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management State Flow
> Diagram. Both L0 and L2/L3 Ready can be transferred to LDn directly.
>
> It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
> PME_Turn_Off is sent out, whatever the LTSSM state is in L2 or L3 after
> a recommended 10ms max wait refer to PCIe r6.0, sec 5.3.3.2.1 PME
> Synchronization.
>
> The LTSSM states of i.MX6QP PCIe is inaccessible after the PME_Turn_Off
> is kicked off. To handle this case, don't poll L2 state and add one max
> 10ms delay if QUIRK_NOL2POLL_IN_PM flag is existing in suspend.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---

This patch should be after you add QUIRK_NOL2POLL_IN_PM to avoid build
break.

Frank

>  drivers/pci/controller/dwc/pci-imx6.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 5a38cfaf989b..8b7daaf36fef 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -125,6 +125,7 @@ struct imx_pcie_drvdata {
>  	enum imx_pcie_variants variant;
>  	enum dw_pcie_device_mode mode;
>  	u32 flags;
> +	u32 quirk;
>  	int dbi_length;
>  	const char *gpr;
>  	const u32 ltssm_off;
> @@ -1759,6 +1760,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>
> +	pci->quirk_flag = imx_pcie->drvdata->quirk;
>  	pci->use_parent_dt_ranges = true;
>  	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
>  		ret = imx_add_pcie_ep(imx_pcie, pdev);
> @@ -1837,6 +1839,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
>  		.core_reset = imx6qp_pcie_core_reset,
>  		.ops = &imx_pcie_host_ops,
> +		.quirk = QUIRK_NOL2POLL_IN_PM,
>  	},
>  	[IMX7D] = {
>  		.variant = IMX7D,
> --
> 2.37.1
>

