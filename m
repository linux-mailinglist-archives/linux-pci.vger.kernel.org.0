Return-Path: <linux-pci+bounces-38925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEB6BF79D0
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 18:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A33484E92BC
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 16:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB20346781;
	Tue, 21 Oct 2025 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kGd1w6FQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010039.outbound.protection.outlook.com [52.101.84.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECF3346782
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761063409; cv=fail; b=XdbVfjTMPDcAw6xy/FcPIsnH+3M6ur4tm953q40pGvfCYKPtQu051c0VunfQV1Nz/IiFvZBbBq1roiyU/j9DrHtcXIYNsxH3GGhCXzp8xfJOqU6U1FSgN7nRGyiu+wxbr2mlTUqm/xWofbe7ocwYncG9zoDZ910kPH4yoGVmLmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761063409; c=relaxed/simple;
	bh=NPbkgwtX/Owum2D7KhUhiEB4jY5dh9QH2dPxeD2GySY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ggnWi/IkMtUjExHTscQHiwPzAiQtrYInNHJyKNT1ZLXp294RjDhQeoXLl+4wEdAmXdPxREw4skBFPINRD2cQSF6xnn16Q5ubeJ0xYbzLOMGIlhDfcLaYOX1duAOA+E4gD33Ywob8Q3gxYQ+L0U8cAYM1F+53F+/H3EabHxrCj8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kGd1w6FQ; arc=fail smtp.client-ip=52.101.84.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PR3jnDh3g1UM1YytLL0lC+VJvXw4v5k/4M0K/uaPpgP8h1jjdGSkpVgxiJr/t65CvvaJkFSIidvcmrdL4Hfn/yKtqtLhqxRGCaymBU8HGgQdUiFIxuUJcdaxAUKuv+8Bm3tpEKHez8mt+3ZdIjf2cP1zYs8/qrvw1QTzhsiZBhtwJHhxhI9yHNwB8657SX/E1Tdw2VWvrbLDaR3yf+sk6QMJZwsoVZbi47Dsgom2OBk9FusW35iHkVVltQ1QVRJBOCPHCWhF23fP4AwVCUrNixqr4Gq0EnIxmjJtWPqPluSsoV93s/6kZzRfuXWqPOOL4rke7ENw9KpmculmaZpOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNOzggdAZmqIrjHTw2Q4EZ31VfMxiyOsmW95eMSZEW0=;
 b=N/tQGcuuB/X3g0jnrKLZI3XPvbpX7Y99BEgAn1cpO1YI0RWIT41VH8ApaK6N5fVhWE8AetOKVCQaAvoaHmdOXoF3TQ6I3GhfaRboYcuXf/6lW2FrrD9jODcex7oS3uQgZuklqWkIow2ukCg3B07FH776BKMYB63yXFN2GvVqEQaZ08O3/zo8bg4gBbouWiAJfo6BngalQzCHIE0RHwPaD8n3PR5qBVXQHMfbecHSq4FRg4jcjvWvnHpR7cQBeJzyfh0oLtKeB7x1ll5wCOgUfh8NvXudN4H1ZrmvAS8zpNQtK8VL4DLxExsR/3Ht66EO6LrzuldyLzls9nE9TlvnfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNOzggdAZmqIrjHTw2Q4EZ31VfMxiyOsmW95eMSZEW0=;
 b=kGd1w6FQfJIk+72aLAi0GRMmYsolubl5JmFqr+OoVS5fF89nYqJI+MtBjbYSGwOQD/Dujk1sl060MYkDtK4HtJU1mjjbEb7xn42Xpd0zLRrivmODFdYJ8VEy2AwRbQVUk1XXxnw1ZPrkyR5iGXm2UsBzcBvozJEcTlqfY4JiOdnbtDSFfmsiLizxSB2fjgMqTjsxybUmiv7SqjnQPnnCeLzdkmj9eU5NWQwnqjAF9/ICm97omSd4ethQ6VKk3L7JkuFFAIkiMC+U6mgKMeV2r9TbGc8ojon9EN0/BD4ri2Gp5bAUkHf7Z1G7+HEKY159z0MXGXcMwNrTSgHKSLk1KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DB9PR04MB9889.eurprd04.prod.outlook.com (2603:10a6:10:4ef::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 16:16:44 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 16:16:44 +0000
Date: Tue, 21 Oct 2025 12:16:37 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-rockchip@lists.infradead.org,
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: of: Add of_pci_clkreq_present()
Message-ID: <aPex5YfxT+3dso2U@lizhi-Precision-Tower-5810>
References: <1761032907-154829-1-git-send-email-shawn.lin@rock-chips.com>
 <1761032907-154829-2-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1761032907-154829-2-git-send-email-shawn.lin@rock-chips.com>
X-ClientProxiedBy: PH8PR22CA0001.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::16) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DB9PR04MB9889:EE_
X-MS-Office365-Filtering-Correlation-Id: a3c99af6-913f-458f-7fe5-08de10bd39db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vuZJXqncKpPHjbNYtgAgE/9EEyEbPcQQmEVe6MsXdFm5y/RMvwZdcPBrAcDa?=
 =?us-ascii?Q?XqjFksLE91DFRt8sDZFRzZmCRqcotI2xBgjlqn7iF61QKlUFxAS4oaWVnOyU?=
 =?us-ascii?Q?qIU6oy12+wsqgaDoQxLSgA6Aknh7g93qPBrBxwxdtn5TMVWtvn//VSvRFFHR?=
 =?us-ascii?Q?MVsphBojyGzJgBZqGe7QFMbdFWnNgVY3zz+zQ6VucTGLnmDloIZzi/vwFfFh?=
 =?us-ascii?Q?cTRHkByApP/w1roD28wDSGP5ECKP2N1ygSTfZcyVnj5b4K94uHYkxsGS0F5U?=
 =?us-ascii?Q?fJNYDIlNjg/79E1EMKcjhyuCiw3oJgDljQM0mkc8wWi7DHTcTrKR3Xmy27R7?=
 =?us-ascii?Q?uXG1kdZ3v8ykRjPcnuhRUUl8hRvKSr9tG/qDClaVjB7vkStuQ9KHOe3s3d1b?=
 =?us-ascii?Q?Jng/5Oo7z1p7Hz/rYp34W/LxQInINuHqQi+K1FE61fSGwDLWG8lhX+VSNN4N?=
 =?us-ascii?Q?zyEOHZRs8ileMNhAimsJXY7b2NizAcwlnBInL0iETuAPJqNJleLvPab4RS3M?=
 =?us-ascii?Q?MLT46aYWrKna2XOJ/1D634HeeYSXbU0VVQj0DK15J7wDBj0vnxAkk2NydRZ3?=
 =?us-ascii?Q?fBoXvcVtZzP0bnkbz90uZLeKnZkx6luBLNfs4o2Y1cFap3F3yuOWpJl0JMGn?=
 =?us-ascii?Q?1qOdjkvaAmqq8DUMlshYb/P+EtdSPyUuSLVhuMlFu1jo7v3VhfJ351MPlTo8?=
 =?us-ascii?Q?wWaQmnXVPEvD6DqFZFKFicnXI3OPgl0ZViKbE/CXfF2Jf0hwGLjX/4zZ0SoD?=
 =?us-ascii?Q?ropIsrEBefkLMgfwcm/Od+JkHhwo7ISMR7XsFwKyDXBjJTBuksfJjzmyU+iX?=
 =?us-ascii?Q?CTD+fNfEkkS6rpvYfgiZE2p+KVaqxOtrqmZRKotWorMDsmMoUXhbfF477w97?=
 =?us-ascii?Q?jKGm2vUvS1ysCm5Og/Ni8azoE+TU8j9WzOS4dpRXfUPDRenzO5bn09z/0XUJ?=
 =?us-ascii?Q?amHEK/fveb2dK/ta/PTLLgxxGpOHF1srfUaIpTnBsOZydaJkcI4OucrJ1XP7?=
 =?us-ascii?Q?e5x49FID6KVeYmpXFMYGKFHlIi4gtDUbH8o3fAECmbtSkr+xL9mDRTHiBlUM?=
 =?us-ascii?Q?absSxvqvqfxmHMfH40h2LPsSQVQQRE+rB6y7rPQ4eprwsJlVUtTsqSTyR1wz?=
 =?us-ascii?Q?FPfGIK0SYO4WlgS1eKIzpQ1U5FoXNRUDiYVmUGqs8NnzJNNKuwnyVHStyZtM?=
 =?us-ascii?Q?KaABAPNUdlzRohTLATPKQycAidVqSq9H4iz8IsMjjOrgSUTpe0PV4ShzTK0e?=
 =?us-ascii?Q?owWC592O2N1eqHnd5l6WrLxdfRy/LtjDGdjgSeL3aJO96v4M2Qnijqa9p+gO?=
 =?us-ascii?Q?C2qvmZy8ZTJTYPlubugtZg2Y8GHNXZJpDETPGzE9T9eh0j88ophwxtwJfVOt?=
 =?us-ascii?Q?QLhojgbaET8ci/TtcJF3gg31zVwJFHhuw+ggA1eO85N36QRH+iJWp9UpThKr?=
 =?us-ascii?Q?v3K8/6tqONtaRwu2RF7XOzkXrjolgXlGiLir+IwE9ZELkOg9n83pVf5NxQ4L?=
 =?us-ascii?Q?JKZ4sk48YiSultVUeXEVX1tFMbV2EhC1918L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QkNY7SqeZV0pURvv38MV57Qu6/bFD9N9kubwnxBhM4rjlWKW8JbPUFFJmD9J?=
 =?us-ascii?Q?B5u6k/bvcUTYmL9yATfttzlhp5G7434Qr2mEeMxYYGz7P3bdL0Il9L3pTCch?=
 =?us-ascii?Q?oBt8Tan/EiY3zRGeruDLfM/KBrcw3WHA+zax9LHzNBWisOTtrl9Br2NuA4Cz?=
 =?us-ascii?Q?faJVeH+/Vjyoiwvn/G2wDs2miAjoOiGq8M+taIqk6Zw3lF1CrQ/lPbevmWMt?=
 =?us-ascii?Q?Ba8nwHK+w9uy8Qzqq2VXaQRkI6YIiQCqUeVLaPwPQpP/vouxM7C8+w1rV27f?=
 =?us-ascii?Q?oJ4mTGIO4nQTSkEV39/0AIwwB5tCudqGesOKVL4xztEIhUqcjN/LZhWtgwcd?=
 =?us-ascii?Q?/CvMf1wYvQrcIsMnGtqiI5hZs01pHFLnP/zUUynPhSO6JDaWWDynj9jjflEc?=
 =?us-ascii?Q?q1hMb9nPzijkiC/vCZuvxvJWWGDrI22yzkDiraQ3KYizgnp8MS7j5/eShkJN?=
 =?us-ascii?Q?0iQASi9xd92wB8qyB3gjP9XxbMMRXzyF8d3QZUHEV+NThHOntZOYSO0hDtTD?=
 =?us-ascii?Q?DLzRDDzwBrBNjvHnqH4gnOmNZySiDSbRGyYYvo+oMlWvzhqyQ9N6TPp3rb0Q?=
 =?us-ascii?Q?JW+cGmSIAGMYIpJiqX8FYRKH7kKj7TGnPJ7mh6sZsoMUEmWzGGxNRMeY84Jn?=
 =?us-ascii?Q?2vTkAzbqoirXr8Q/6wAJ1WCuyR2fttAS5OLn47JG7gn0VimEEn0WKxgl2IOv?=
 =?us-ascii?Q?BZ/0f2QrNgVPaYs1jacQIJyN/IpCdxcvNNKpQ1I02nm6M0zqlL8o7UzQrQ37?=
 =?us-ascii?Q?8tdo9Lsu/+bqUJ9Aa73VCbGAzfp+j8PR1blZ2Dyg8RpoX3HcmetOL1jUqCEW?=
 =?us-ascii?Q?Taj27TA/dAGZ7v5AeWNWC/J+WQc38yBGHl0A7TbUhQRhDHFskM5p4hyc8jYn?=
 =?us-ascii?Q?uvyaA84c6uNNi6sTB6Zto+qgeXUyMvwNUfu9Ks+n8z5Ss6vESTktauZXpAkS?=
 =?us-ascii?Q?heoSYj+TRvNipG0XzkymIXDHfO5WMGwG3LhoaIJk5F6cbvR4ZdAtd2ImxYxJ?=
 =?us-ascii?Q?aydi1zmkQHNWf27kodPOhUa/XoHMlDGj5bix4OWsD7hZ9IfIhL8vAai+ORqD?=
 =?us-ascii?Q?kPYI1v01szTbiZFc4T9iRdoEeCXrj6OiG9Ql1SY5XVeTw2/d08RcU17kDsCm?=
 =?us-ascii?Q?2B/KGunmkI50wmyBLLlAUObQ2xQrd653MlkcNFgYCsYdOsags4rQNsOjVVaN?=
 =?us-ascii?Q?o0PNfcJjaKFzP0F8BZ0V1yj7LqhUEJZqsIhQMlOEzMtyz2rIVEfb+p5aaueu?=
 =?us-ascii?Q?WXKRVMpF6/i+F7zXHm8Ta+4O7DyQurLUUy2FCb6QDtoWIdgfILCqM+LY9qnA?=
 =?us-ascii?Q?fx7NbeFn8dHqu7txxM6ovQCyrbM/2KJWhW4ZpFmvQaqNgB+s5Mcms6ZlcyNc?=
 =?us-ascii?Q?bdhvT4bxp4vrpsh+qzwiaEzllLhdcdsRLyPPutjCFBHk+wxLZJiIdSAO5lg7?=
 =?us-ascii?Q?QG4eRaUJhTWP2YEbIe0uQCj3hnZRn94IoJ/fU3H8F+b8r32lahSkFTsUFhAu?=
 =?us-ascii?Q?dodCAXZ6LQjCkBqye+bxw5bmtRbUmYtxllQQnGi0LONMdtDbPAGJ2ODN9+MW?=
 =?us-ascii?Q?7HWXJNdgfk+VrtAuBHhhfk8J5lTBlT3YoLtKco+w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3c99af6-913f-458f-7fe5-08de10bd39db
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 16:16:43.9922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YpNWEEhrRIPHBPs3gZeyNZk6+ghVNwt3aKTqIW8+3/nsnFMyROimdS2bmD7oKvQ8ZW7FNF7SqBm0E97iKJhV3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9889

On Tue, Oct 21, 2025 at 03:48:24PM +0800, Shawn Lin wrote:
> of_pci_clkreq_present() is used by host drivers to decide whether the clkreq#
> is properly connected and could enable L1.1/L1.2 support.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>  drivers/pci/of.c  | 18 ++++++++++++++++++
>  drivers/pci/pci.h |  6 ++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 3579265f1198..52c6d365083b 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -1010,3 +1010,21 @@ int of_pci_get_equalization_presets(struct device *dev,
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
> +
> +/**
> + * of_pci_clkreq_present() - Check if the "supports-clkreq" is present
> + * @np: Device tree node
> + *
> + * If the property is present, it means CLKREQ# is properly connected
> + * and the hardware is ready to support L1.1/L1.2
> + *
> + * Return: true if the property is available, false otherwise.
> + */
> +bool of_pci_clkreq_present(struct device_node *np)
> +{
> +	if (!np)
> +		return false;
> +
> +	return of_property_present(np, "supports-clkreq");
> +}
> +EXPORT_SYMBOL_GPL(of_pci_clkreq_present);

This helper function is quite small. I suggest direct put inline function
into pci.h to keep simple.

static inline bool of_pci_clkreq_present(struct device_node *np)
{
	return np && of_property_present(np, "supports-clkreq");
}

Frank

> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 4492b809094b..2421e39e6e48 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1061,6 +1061,7 @@ bool of_pci_supply_present(struct device_node *np);
>  int of_pci_get_equalization_presets(struct device *dev,
>  				    struct pci_eq_presets *presets,
>  				    int num_lanes);
> +bool of_pci_clkreq_present(struct device_node *np);
>  #else
>  static inline int
>  of_get_pci_domain_nr(struct device_node *node)
> @@ -1106,6 +1107,11 @@ static inline bool of_pci_supply_present(struct device_node *np)
>  	return false;
>  }
>
> +static inline bool of_pci_clkreq_present(struct device_node *np)
> +{
> +	return false;
> +}
> +
>  static inline int of_pci_get_equalization_presets(struct device *dev,
>  						  struct pci_eq_presets *presets,
>  						  int num_lanes)
> --
> 2.43.0
>

