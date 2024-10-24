Return-Path: <linux-pci+bounces-15223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 356A89AEEAA
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 19:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E98622855AC
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 17:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605001FF02F;
	Thu, 24 Oct 2024 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MutHc0Zu"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2047.outbound.protection.outlook.com [40.107.241.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D3D1F76A4;
	Thu, 24 Oct 2024 17:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792299; cv=fail; b=EebfGov+1SPcPgbddOajKhG1LrbBrnVHqxieOQz2VCk4vREZMpk/Ybs8bZWjo1zEC9Q+yxQoqnjzgyVH8aip5MnYWDwTbCz0uOb+jeTuLlfdV4V2nMk4ePK353EY8rzGWvn0hcJMA/sSIBTRJckC74rxzSQ0iApJN79GfCeW6UQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792299; c=relaxed/simple;
	bh=DYT8f4iUSB/JlBHIWMxV1kx1SVRSjAdfxAt2DZzVwuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YQR7C2V5YA5wMSRr2BH04C3br/g75KtBqTtTryav7mQiw5VPX4+DdxykgmB2pf8COjg6mUaO8f7/qA3shjXyN/JnLmvuUeWrG271h/wd1cXEXJGxyJLDbnEWvHwheG0C35az2HnVblESst3KwXAAEJgDYx2WTFbJ+xX2W5LQ3tQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MutHc0Zu; arc=fail smtp.client-ip=40.107.241.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpaFgA/8aaZA8y8QAn0ZHKQTTyo9511v2Ajs728FZ3EjhuPMc9lYTAoTUE4ZRLmmiSco19mkavNFDp+r77uOELHybCXbxwyCRrYDh2RgAYOczL8kn3fAcXZHBvmdnb0QOiyqkHEYlVQnoJgYsC/TO5/eUglRRw4MkklKOKCVs4260+iTr1HHNJ2bO3KFQaZFPDp57DgrDfhJhQiZOkxSX1g/mmDUbYReUQ1qiYlUiihXEaHLMNM/91wyGL40JTJqVux5CagWN+dlr4E3lP8Ct2wvVo8xqtJQrvpze9TH02gCMRFTWsB3dDOjOyFa9FkudEUr3jkDLf5q6ZqNRQGWTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDtl3CWHoNS3Tq/dfebht33rH0XHTo/mvpQhZCazfks=;
 b=lo4NMuOkwS2bQyZiyHtuhKXVo9zcxAR6bZLPApaXs/7bB2ugEvKT6AG3t6p8z4uo9q0IvKkfMnqIZNRoQA0XrRp5K1TvCqupHHfr4bx1JxN+s4ErGMnLvZF1TWcuo2ZzEYjS0UInvd8r3jpw8/F51A82XyuHeaTGq7ttvY9+o7rvV3O1JOiReomLP1e1bC4Ibl95qTjWhAuE5rKcv+JwpjpxFZln/Tm/x2Slm5++BXLy2EG+NyABqISKvbnHrPJhbwE3bTENS7UMGTdL0iEn12uQAxR5uglg2D0oCppe4f96a7PjRbbHJLoG/wEtR/gLdn96NRp4tNs5N2y7IYm87A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDtl3CWHoNS3Tq/dfebht33rH0XHTo/mvpQhZCazfks=;
 b=MutHc0ZuuNVJJALVk7nCuQ+aWF5uMsyaz3CyeOfsEIGaIyjQw7cgWlzq2Zpw0DyoIOcA50lagcN6TD75+QH0xwwoXpVTwAam6w0uFpX30pJXYQBrAIQo/CvCCXBMqT9Pprvl/tkASZak0+I0ypwuqYfk38a8/NpStggqjmjabSGmbcQH3cTpVGP9Ih8oA6ePT126YdozknsLdRK8+qNYuFVP2Pg3cQ1URK3i05hGNEmxEiqUlz2xI65TdaNpZ6YvgDTQxQUsIl/NTX5q9vnalnFZRqHMhfnGzR+rDhoALcfmfeWtrtAAxR9rDGyP/bg55zWE/AIJdtOfEENRkqp0xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GVXPR04MB10564.eurprd04.prod.outlook.com (2603:10a6:150:215::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 17:51:31 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 17:51:31 +0000
Date: Thu, 24 Oct 2024 20:51:28 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, claudiu.manoil@nxp.com, xiaoning.wang@nxp.com,
	Frank.Li@nxp.com, christophe.leroy@csgroup.eu,
	linux@armlinux.org.uk, bhelgaas@google.com, horms@kernel.org,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, alexander.stein@ew.tq-group.com
Subject: Re: [PATCH v5 net-next 07/13] net: enetc: remove ERR050089
 workaround for i.MX95
Message-ID: <20241024175128.7pdwpqr4mlok43cb@skbuf>
References: <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-8-wei.fang@nxp.com>
 <20241024065328.521518-8-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024065328.521518-8-wei.fang@nxp.com>
 <20241024065328.521518-8-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR04CA0067.eurprd04.prod.outlook.com
 (2603:10a6:802:2::38) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GVXPR04MB10564:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e92805e-c489-41c6-cf37-08dcf4547e5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IdROgnuxl+wSfqUcRXj5OLU5vm/gc+KAVGPq7YqERyYvjC/PvuuCO3Gyh8jn?=
 =?us-ascii?Q?mo/KBO53eND3DVACDwdgpIuTTZbI5tx27m8x6wGQtds7hzDummhN+u6KMOXq?=
 =?us-ascii?Q?e5tAQkS4fVhJUBzEqmelbUDw2D2RybvOn+3FVIbjqIdzT/+hvXyHyzrqnG93?=
 =?us-ascii?Q?uohxJyISdYjNgnzI23c22SneFhGuRK9aj8zkFPtflhj33TXRJpd47u3HsZxQ?=
 =?us-ascii?Q?A2PB8YowEZ6kYDGQ6Q2KEq55c2N9KQAWPl/ztPyPxDbRYpdh9JwYU+DYv6I5?=
 =?us-ascii?Q?z0iJ2tuN+Ru4VUqkaQn7j20DB64IDvSAPPGkofN8gvkqBsbINcZ/CQz6EG+r?=
 =?us-ascii?Q?1EEJ/3E/SOyUPvI/+RGR9m+K9fEbO/4gxLmeyKOM80IGHMZtHBqvROrTPyxi?=
 =?us-ascii?Q?Kg99OkwvJ7RMjZCb7vxV8HNAcf3wfUo2GmY1WHlfcOXwI+0RL8pyKIuzRuru?=
 =?us-ascii?Q?JXKBjgXCptfzYlh0bfN5P45ZiXhc2dOfg6MHWfOUqV1YoQkhjCgyYhGShq2C?=
 =?us-ascii?Q?f8tc6JqygxCSYBUoL0dR5Cfk8VGRb1DdDp2RjuAoALu3NjKZEV0vMVtk4O0S?=
 =?us-ascii?Q?67KebajRCWI2ysvLsu+jvTMHo85O8lv7R0mk/tc+K4LuFRR4FzXO7H1aODyG?=
 =?us-ascii?Q?mjWRwFlUMrOpknt99BY8wB8rGPArPTiF6jqNXEnD1sNGRoKoLQQ5OBNwOcGk?=
 =?us-ascii?Q?c8gJqDA3eYVBV30NM2OX6MPzpk8TwlzNjElWbZHqZs1lrPRrDN/ArBokVPTa?=
 =?us-ascii?Q?SUTrE+WyXgHMTqPjVbGl7gc0FHinFt/MTeCOcCYy9Uszrekdob54nrR5dsAD?=
 =?us-ascii?Q?gLSxJr+DAmAGWiTfwJNm9j3ap2U/4AiU8lGu9/wSr/BmgjS2d3/soghmcexi?=
 =?us-ascii?Q?rm2l4IQ0HPwBlI8vzqOGFmLnl41WLkkDIjLp9CcAmOSz/BU7mRy+4msDk+TC?=
 =?us-ascii?Q?iP5DCSX8uzd1ZgAkVxT5rN4Rr1mYljnbTpILl+ErsiMNyLoAPyDgquzWoWDh?=
 =?us-ascii?Q?yiWzgTCptAZ9FAq1f0VLJwkI+ulz/v2kFwGJkBx68aGMwhBK71ZX/F80p94W?=
 =?us-ascii?Q?Nj7hbX42izlH4tmmntYjkyHRZz7pckrexhNnyrhgqglX1a5sJcsGDLkHE+NV?=
 =?us-ascii?Q?lOlrQL7pnwv7dGAxHH/FyQ48am50/fOYFmBYK5PtBuQAqIGffG5xHZLmxRQ0?=
 =?us-ascii?Q?D/74kvNmNg/dhkNi3tlywHDAxFpQxn18I0WHRBAOMkrP8Es//Kicdn5wdjr0?=
 =?us-ascii?Q?mRUNpYmaFReHM4emU3ewGUzWKog2ksr7tY0/+6GB2Y6RP5qI2Qe3JNJWhqml?=
 =?us-ascii?Q?x6ao93gqxmX00nZYqxU2muN+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yASeQHcIO3EAINcFDkCnSJjjYi0xgo2L0nnLDzWknK/kgN8HJgMNUeuDp2SD?=
 =?us-ascii?Q?9Tnen9L/4l7jElW7Tz06OSKrTv40srdHkcv4cA0ighAiOvmwSy5ZF2/+NJyP?=
 =?us-ascii?Q?N2QxIuCtDM/7W7/n0zxuHKl4xuVtufkLXZAMpUInXqrFkdCHjGkKWaSBpYy1?=
 =?us-ascii?Q?ZcCd9jnzRoDkqlBl2Tu5ptCXxe6VNexe0qjdVxToZfUnNvSENCxPvVxsfG5D?=
 =?us-ascii?Q?f0YVqDnYodhRVFBLnL4FmeTEQsUXfgnYoJUY0JxLOAJOYvzOIvDSFABG0UIO?=
 =?us-ascii?Q?4SWBwHqbFgFI4WsATfZqxiHoPHw89727k6AtRkA7gQuDLPbHiyvpxriOBrQy?=
 =?us-ascii?Q?r3tTa8KJ/c6HqXYmiH63PiK1e9+PKyiRHKOZ6riLv/KoEiyPvxAIaZ7BSJb6?=
 =?us-ascii?Q?Z+Cuw4FGfrJ5TRt2hOjGVkRI6aCXP7DnKsg/DPNkiwGzTEAShxZF6Ws4UpRu?=
 =?us-ascii?Q?mHCUk1s3xoEeDE2aXibJLc3OtXlE+jU0th1vmkIUTPG+0/a05/fVOvaJRqs2?=
 =?us-ascii?Q?BCk9kwHe4VeyUqK0BJZlO484KgH1UOnjrgMnF3mbDblG95L0CBwSt/NtdPZ7?=
 =?us-ascii?Q?WtvG3yhUEJmunyJ2DxroPX8h8z++B8AI+kagxfd291PcI9IJ5DtzSIYXqNYf?=
 =?us-ascii?Q?Mpa4Y3hViuOg0L8tU3Rxmv1sDOen8JfC2dIHZRPU692095k2GYUOEDmUc7rv?=
 =?us-ascii?Q?bJQaPwrKimoMmHbfsqsO3eeMoc3JKkqhW+mKeFj9YXOBXWmz2+z8N2XShk3x?=
 =?us-ascii?Q?W+r3ioHGzHbNWkocMsJvycD2EIdg4uELpzA3pXky3izPen3AR8BGv1DhYjgP?=
 =?us-ascii?Q?g+o3+oahwL/ms7o7uwxPN4VSxWPiDCqgrI4TcI5NXlXGDJ61SRAyDDXz4x/1?=
 =?us-ascii?Q?Yh0E03gjJA4slpiZoq59QoOwOt5HGRh62g3ObmhA9AtIvpVO7oROQAr6Xgcm?=
 =?us-ascii?Q?OwUoubw4DIyO+1RTCTu3O6aV27LrbJvUz1Wmn3kL5/GmPITKMjbT1LThkjHF?=
 =?us-ascii?Q?5vy1HS3l8up2N28+9OmjOBT1kUnQMG+W0lAJI15fydDDC3xEyRymfEZ89Y3s?=
 =?us-ascii?Q?EFJC+UUIwVfIERyz9cfvSpNIkgDfpqm1sdeICRiuyQXB0dgNdbPo5XrR7KMg?=
 =?us-ascii?Q?zLez6eQc17GgjVZw2kiwvS56alDVVqEGbA8QqS6TPBBNgiaimrYuyfU/IOHw?=
 =?us-ascii?Q?60fTuxWcAcSVbrQ1qMvgA119nbFV/UrWePM/sDMN1+Dx0FuwyftDNIjKlxm9?=
 =?us-ascii?Q?3XnAmORWtXqrbW0no4pBGn7Q2yUoYj8cusIw842foZMGeSOBtZXMGs9OnJnq?=
 =?us-ascii?Q?UKqDywKNTXV6eRCI5QZONYrZThDwaUR1XolwJAya1JUroL86XVjRK8wDyjEU?=
 =?us-ascii?Q?CwRInhTqdllX/XVzW/lKGnwa7YCNFMBFZS5UVifJs7ZKBFUfJ5O1yRaND6/T?=
 =?us-ascii?Q?x583DqYrUlzj1Koex1nNx5IZLxs4Sho0R3jqOm6K+UqKiIRo9Z6l3H/+CDyK?=
 =?us-ascii?Q?rsnCSbIK8pNC1rcu38pngArPaSmM/HOu5Szau/DQ26hgd34W7XRF+iqhi26I?=
 =?us-ascii?Q?LnrBOoqDFYnIx6YYbvfk+/PRRvc3FG6nvefDnTVL06yEisC6x/8iz513hRvG?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e92805e-c489-41c6-cf37-08dcf4547e5c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 17:51:31.5635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C52sScw1lDtPHDYIdem9KWNq+cdUWrXA4uAKn6akkVcNYIt2JmMF5jrmc19Oj2r8q83/KzyDWsZginLA76urQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10564

On Thu, Oct 24, 2024 at 02:53:22PM +0800, Wei Fang wrote:
> @@ -62,6 +65,12 @@ static int enetc_pci_mdio_probe(struct pci_dev *pdev,
>  		goto err_pci_mem_reg;
>  	}
>  
> +	if (pdev->vendor == PCI_VENDOR_ID_FREESCALE &&
> +	    pdev->device == ENETC_MDIO_DEV_ID) {
> +		static_branch_inc(&enetc_has_err050089);
> +		dev_info(&pdev->dev, "Enabled ERR050089 workaround\n");
> +	}
> +
>  	err = of_mdiobus_register(bus, dev->of_node);
>  	if (err)
>  		goto err_mdiobus_reg;

If of_mdiobus_register() fails, we should disable the static key.

Perhaps the snippets to enable and disable the static key should be in
helper functions to more easily insert the error teardown logic.

