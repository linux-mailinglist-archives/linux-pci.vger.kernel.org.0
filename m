Return-Path: <linux-pci+bounces-44694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A3CD1C3DC
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 04:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD19E300F323
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 03:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4F12F532F;
	Wed, 14 Jan 2026 03:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="P6hzG3xq"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020126.outbound.protection.outlook.com [52.101.228.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5FE2417D1;
	Wed, 14 Jan 2026 03:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768360947; cv=fail; b=eGuP/CJtVu51zD3f6yzMcIwTtPg9J9B1cdW0zu/h5aV0yH8j0QDc5ziMNQYqB/xZrob4Hv+bqDG1fco7zoSoZ46+HOzv1on8pSvvhkW9yBUF3zqP5yRklwDkSaciyJVrSclwYA0I5o8dAVAeEAlIjODXHVPZt2apIU/xVzwQmL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768360947; c=relaxed/simple;
	bh=WVSkzG0GFsjsm8FgHChJ8SS1P44Oulmy4/vO7mPCwJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lloCPj7AXMOONZX/HrWMr0X1k21hraWVq+7zWNbgsQUtqKaSguC/CWovhOVWQQRrqOJIg+iWI+z/gG53S5+i7BPOybouJhpND9dBKUEau4l+iFU86PgO7xp5knO+k/Y8vVreMGdIW9Pce/VHUMZmH1GlWYXYS0eePs3d/IrbYs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=P6hzG3xq; arc=fail smtp.client-ip=52.101.228.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t57giZHydnMihAeT5XCkks72lPxVL4lmCY+8b+T1VJspzPzs+/N1NUuczJhNp1e85h4mF6qwGW+6ZWn24jYiEwbl3Ye5R+kJJkwut74zFE3izzHs6ZNFCp9Dvi7cPcx87IxpmQXvNYGGWN18P+qB4m8UfE03WUt+UIXIydXtlTHzXgJ+wdO/SIv8xgzfOjhCb38U8o24tuCUIoZiv3QiYESILzT9LyeeTGHI8SOXH8uHWXJJeWt9j/wFekGWk2YapZW+krYAWP/99TkXH6SSjSr1KT0xqeJyVAV6k4fdnXfV8JUTKAM/vrmJpR3+GcpeibhdwaHgkJnz/ABca6LboA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VB+aFAGzSbNvprFB+XFfY2EsPBphfen1AxpWMsSBPuE=;
 b=LkG9c4HgKVyNErEYJvRZiAIP/zlOl59khtI1JJxRQKJfs/coHjlHO/5FK2snxq07BIAq/sxsRbq/9KyZmJEXi99L+XeUgVqbrrH0VPIoHNESzxGdGlCNU0zh+AsZPS7jZuqasAEK4yvyH/XEE9uXnOQaVDHxLm4uAvgwHHmk7SDMYgRKeKPLXSv4CLAp9YZUktc7xihvMcD2+8lK0COG6z067xC1b5gyX7URpv4xUtbJ3DQmrwsaDQ8vuNKEu8I4XViL2UukSAgT1D3iOdSlCzURZhYII40WOW0JqpX77h/gV3+zYaieu/RObiktZVkVUEuxZ27BoOvUkkf6cAIyqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VB+aFAGzSbNvprFB+XFfY2EsPBphfen1AxpWMsSBPuE=;
 b=P6hzG3xqvQk3fjSWql3vgtO3r5NyQAgJLBYozCYn/OlOTtmSilEyM8O7znIAIGSJgv3WpaizJkc5R098nSuo10oFh5FseAXHKz0HWw50E5NG4KF5UTxrVAwGOawXoJ7714/d28Hut/08gv3YOBEJroIUDkRCe1aWLr04d98bnZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7440.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:440::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 03:22:23 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 03:22:22 +0000
Date: Wed, 14 Jan 2026 12:22:21 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, cassel@kernel.org, 
	vigneshr@ti.com, s-vadapalli@ti.com, hongxing.zhu@nxp.com, l.stach@pengutronix.de, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com, 
	jesper.nilsson@axis.com, heiko@sntech.de, srikanth.thokala@intel.com, 
	marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com, geert+renesas@glider.be, 
	magnus.damm@gmail.com, christian.bruel@foss.st.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, thierry.reding@gmail.com, jonathanh@nvidia.com, 
	hayashi.kunihiko@socionext.com, mhiramat@kernel.org, kishon@kernel.org, jirislaby@kernel.org, 
	rongqianfeng@vivo.com, 18255117159@163.com, shawn.lin@rock-chips.com, 
	nicolas.frattaroli@collabora.com, linux.amoon@gmail.com, vidyas@nvidia.com, 
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@axis.com, linux-rockchip@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 2/6] PCI: endpoint: Add BAR subrange mapping support
Message-ID: <ngvqrju3bi6sugynhksxsci6rmgqevzpoijjflp2373c6uxlum@vyepxqghbzvn>
References: <20260113162719.3710268-1-den@valinux.co.jp>
 <20260113162719.3710268-3-den@valinux.co.jp>
 <aWaqablKcUnHx/mp@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWaqablKcUnHx/mp@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4P301CA0011.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: b96cff37-fbde-426c-f5af-08de531c21b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|10070799003|1800799024|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WDaopE1OWHcv4hT0vfRXos+ghH5stGSx6Ow+MCchyYqROgSw6elpU7FPZLha?=
 =?us-ascii?Q?feueBw2hGekGHHRITh2CEXR6lXRBfhRGfaJjl9GSJE72TSXagUW6y7IbVQYu?=
 =?us-ascii?Q?mmxAEs17fFGg8EInlg4OVgoHfD373/W0HzX7lpsqclNOWxAvo7VUxxcVvL7f?=
 =?us-ascii?Q?YgLFVYrHecnbr/6qWNl5jNvzrCVPrANjocYmrrAsdTDpDRUvHllCEFYAcQrn?=
 =?us-ascii?Q?g7Ps3Fo9cEqdyuMmXaQYRlbGp4rOsA7S5AohpLSDJQD0yQy00eU19k6oyNyk?=
 =?us-ascii?Q?ltBlx1i86Wz+IQg8JdAP1S7wvDYmmED+GfIT3mxpACDgjzRI0NfEXpkplFMk?=
 =?us-ascii?Q?vOTnwRGA+so5tymdnr/xgUwSv1/ltlmZovfYKNJHiGKD89OlBXDp8y3TOwbx?=
 =?us-ascii?Q?nKKbxM88izG27ythWsiTPV8m+P/f0awp7qWaSZ6YBJmNqfJYuN/4Q8SyE6QK?=
 =?us-ascii?Q?k2pGu+KOgztKA7fFjgdUKUYVcy/eeQN64opdqanPDKM0zfTJ2r+bOMoEjxTg?=
 =?us-ascii?Q?xq5U0jCXyYVxG9ZM+FJaXD9hZEFyc+CRkPDVCjx5+iMQgDsGseE12wm0s4aQ?=
 =?us-ascii?Q?kIz79zBIBK0bhLS2tOncW/3raXHvywcSTK7aiyMp+E5fGCiNK15rHXKEQWK3?=
 =?us-ascii?Q?BA5KfSvyzXeyFbv0E4/xDLLe3wl4kAlS0Pdd1eduEdcffpr/2utdKvjQoYn4?=
 =?us-ascii?Q?HkC0RsKSq14DEcD61lUVE3UfZnJ/+0PtL5OCrKslw5cIxjmDNJHUmIKcEbKC?=
 =?us-ascii?Q?KdnSonulkMzqIfPW5nJLtd/QTyeIXOL5va3WpOxk/SYeL/SYhC8hLvMyiKua?=
 =?us-ascii?Q?L9YMNKETMw+kX2t0S2cfPQ6UX28oQ762KsX6q5dKjTb+6NegI19xcdRbHHNa?=
 =?us-ascii?Q?nlfAD7zVWLNmSqJ1aHEcNmG+xKKRF/oiAzvr6PygbVgulkdjDXOQ2rHoROny?=
 =?us-ascii?Q?/onSvOhZLw/BcZMeDgdoQSgurXMQVqM29y2DV0x8npQYc1bx/JJp7E4nH8sh?=
 =?us-ascii?Q?qMjyB3t3PoVbI3LCtbaQ5Obnsl8xb3+r7wvqop1z7f/bExg0OJMp0JZ3TDYj?=
 =?us-ascii?Q?8eEWQ4YBYlTd79vRXHIM6Cdpbca/NA3lwhAk9j2YNOzfBkh78lLwtiEP++Zu?=
 =?us-ascii?Q?vMsDAJLaZPCE77wqbUJQOWf+3spwxEm5fhSg8+ZVwDCF951PlcPaQFhPhbwB?=
 =?us-ascii?Q?Yb4i2o5WWEnIZZj6P3iLg3StmBlDvAwj9+GQSkbKrgQGlnKJlXggHGK4DDJL?=
 =?us-ascii?Q?JhmgQf7YAQEpWW+XYPgUDPR8bT7Fzr/HXkQcFSNy71ZBHPUHoBINak6LEObn?=
 =?us-ascii?Q?IKKM9IRw0nCkeHITCLlXc2aw/cl/xZiQ7ecZzWc2Y26eeWpLgv5Tn+SDVDKE?=
 =?us-ascii?Q?KiCilg1nObLh96TMWYHMs+gVweyb6lcMgvZdTGYy0UmSmvDveOIe4G8xQrLP?=
 =?us-ascii?Q?HzoWh6aUeFYW5YbtzRHcIjZPdqZ3BJgqxmv39MhyBv4KKKjpi4BuUd0sNuB9?=
 =?us-ascii?Q?wJTK6Z/yaCas0ZmPdP9UareeLUbxif+kvG+0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(10070799003)(1800799024)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mv3FXsCv+pxDwcURpqjEz4MHhlD/xlGT5I1oAAM79T7vehn92Qy8UKhZVBcx?=
 =?us-ascii?Q?kIwfIlHTbaz1LSLITNPHSvn3NqT4gRTGIs/8D1Wc1f9LinrF5wFy538s9RMe?=
 =?us-ascii?Q?2pVw+JjbfQvV8IvQAbaFyf6rQrQeRLPAlH5s9TUgY/pzXu1NT2U3CGSqfEb6?=
 =?us-ascii?Q?aXOKpR/WuXXbMDRDirQ20ccVtifnI9ift+vGVGmyxqrvsaP3mIOaxyGPS4XG?=
 =?us-ascii?Q?x26Amm2oei2fC8MSZp/CISty6SdGZALLw675PMcBUBbKfOQh1/fCXWzuqJ8g?=
 =?us-ascii?Q?zmt8A4b9h2hdQsRusMy8NnQQC19xSHFnpJwmw+D6F3y5cY1XXXojSFWgUNJd?=
 =?us-ascii?Q?iB8YaUk8Dxt2rzG41ABPUX3C2coip5fyrTJyn4CsZNFMbcbuany66hMqFk1f?=
 =?us-ascii?Q?KszZX1Sy13qJFSA8U4jGGbgNw7y0MGI2p+9sUQpSV/PvVyvbI7Zo+OL7HmFv?=
 =?us-ascii?Q?1qVyUKXuNSGRB3F01Ik0QIqH8qmfUg9uV6qw+xPbMojGAOS16zXCP7lkthMn?=
 =?us-ascii?Q?grE/DiyKGiVTOd0vrD5Sya0+1u0KKasiZm3DdInh/b+uDu8gyp0jHqznoDOb?=
 =?us-ascii?Q?ash9AyC8oticQBXP2Ky8oaveWDsXWCijE5lk8BivPbwKcTjnlw8FoDvGr2Vl?=
 =?us-ascii?Q?pBsNYRFXYNruT1CtZI79T8GuezeACNz3OQDfx0qZ0FujhhKH6XmiExf9f9Zi?=
 =?us-ascii?Q?ItORSXuomiZNkDBuGd+9d/ufCXVzAiIOwIwMoXNk2E6UB/qAqB4j6Difb5eb?=
 =?us-ascii?Q?4yCylC/NRmeU0EdhX2x53vXM0majfuC4MrgdW7Bg/QcoCGkN7XvdGGC+xDtY?=
 =?us-ascii?Q?7Df3YW0xuT1Xp9TMYUVM3uhFK63rNl+mskuUveYqoH5dVZmwi7hKYvlSdjkT?=
 =?us-ascii?Q?JS82F+CLBGq/3iHsrxDG9egATdOlc+kvyEC8I8UW13XVyvi4I4kU8XB/8Jjy?=
 =?us-ascii?Q?+fe2SJBcBNjGS69C//zLJL3NrfJBgzQVYEcF6EZ3GrZSuEXhnWJ7LmsGblgx?=
 =?us-ascii?Q?okLw1KxE12BbokVDRJyxyKR39c3MGn1U3ZCyXzKb2xV7l1g5SKG4U8v5fUfw?=
 =?us-ascii?Q?leLNg3ryrKHktgk+9/1Btqvva5h0nCMEv5B9T2k8qqt6aoT4LWdiP/dk5ZA/?=
 =?us-ascii?Q?IKUCLUJahLPCdnDwcNwhWOd5fuNwPHUz2ixe+NGDDTJZ/vW7TynvsJzVAFgM?=
 =?us-ascii?Q?Vt7Js7DOxAHvAWabi0RBt8+F2OeLa69UJxjPCaOBSjrikhzdpy4B4DXp3i2I?=
 =?us-ascii?Q?YcbNEw8zXVQrGO8Dftbuj1CR2etZGgk5IxXZZ7xq72o/VekW9lsdn3TRhkjE?=
 =?us-ascii?Q?d3NtD3GtmWHTWwt+Lh9J6Rfk9u+teO76WfouPH8tlBygWUFAml/FmVxEI0ys?=
 =?us-ascii?Q?Gxld1zF9DXKar0ia4z9zoxRE74bfBdlTi9HGV9NOPeP1llAwDsM2LywkiFQV?=
 =?us-ascii?Q?IYDqcJMKERWc6nUPUm9sivu0cvCmY/uDJVXlu7wXASQ9tcDL/XCnkIDr6Jbb?=
 =?us-ascii?Q?OACsERLwr+QIEtIXypAbEq/wrEfIJovQ55ufVlFImJh/I5aKvekdy0y9PqCe?=
 =?us-ascii?Q?+Z1CjkvVltbEfTpUxeQSRmWXFRWl5kxuNmdkYF7LSCTc61SjWEaHAlB2nIew?=
 =?us-ascii?Q?Ua4ZJTw+lCFfz4OgqFUCK6lenFZ/FQfllHxuAcLk7fPxSF73NhNodrmCtV8a?=
 =?us-ascii?Q?+uNO+tYXLwIYjL9cwrh8IZcr+wJXMW0kH7z8hmcrpp9h8fi0mPVAOVs9dwiJ?=
 =?us-ascii?Q?jadb3TraH9gjIL+oz2SySSDByT6Q7iNLkqMTaTkMBrSUhjuiEfAX?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b96cff37-fbde-426c-f5af-08de531c21b5
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 03:22:22.4457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: veVdJGMSEv791K3EftXbiFSfuYyh6I+Uk5MkA/Sjv+bsvhU/evx8ndVxGH7heWMb/xswUORgDd5HeadJMD5vgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7440

On Tue, Jan 13, 2026 at 03:26:17PM -0500, Frank Li wrote:
> On Wed, Jan 14, 2026 at 01:27:15AM +0900, Koichiro Den wrote:
> > Extend the PCI endpoint core to support mapping subranges within a BAR.
> > Introduce a new 'submap' field and a 'use_submap' flag in struct
> > pci_epf_bar so an endpoint function driver can request inbound mappings
> > that fully cover the BAR.
> >
> > Add a subrange_mapping feature bit to struct pci_epc_features so EPC
> > drivers can explicitly advertise support. Make pci_epc_set_bar() reject
> > use_submap requests (-EINVAL) when the EPC does not advertise
> > subrange_mapping, to avoid silently accepting a configuration that the
> > controller cannot implement.
> >
> > The submap array describes the complete BAR layout (no overlaps and no
> > gaps are allowed to avoid exposing untranslated address ranges). This
> > provides the generic infrastructure needed to map multiple logical
> > regions into a single BAR at different offsets, without assuming a
> > controller-specific inbound address translation mechanism. Also, the
> > array must be sorted in ascending order by offset.
> >
> > Reviewed-by: Niklas Cassel <cassel@kernel.org>
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> ...
> >
> >  #define to_pci_epf_driver(drv) container_of_const((drv), struct pci_epf_driver, driver)
> >
> > +/**
> > + * struct pci_epf_bar_submap - BAR subrange for inbound mapping
> > + * @phys_addr: target physical/DMA address for this subrange
> > + * @size: the size of the subrange to be mapped
> > + * @offset: byte offset within the BAR base
> > + *
> > + * When pci_epf_bar.use_submap is set, pci_epf_bar.submap describes the
> > + * complete BAR layout. This allows an EPC driver to program multiple
> > + * inbound translation windows for a single BAR when supported by the
> > + * controller.
> > + *
> > + * Note that the subranges:
> > + * - must be non-overlapping
> > + * - must exactly cover the BAR (i.e. no holes)
> > + * - must be sorted (in ascending order by offset)
> > + */
> > +struct pci_epf_bar_submap {
> > +	dma_addr_t	phys_addr;
> > +	size_t		size;
> > +	size_t		offset;
> > +};
> 
> I suppose offset is sum of previous all submap's size? If yes, needn't
> offset.

Thanks for pointing this out.

Yes, I agree that @offset has become redundant now that the "no holes"
constraint is enforced for submaps. It should indeed have been dropped
earlier (in v2).

> 
> > +
> >  /**
> >   * struct pci_epf_bar - represents the BAR of EPF device
> >   * @phys_addr: physical address that should be mapped to the BAR
> > @@ -119,6 +141,10 @@ struct pci_epf_driver {
> >   *            requirement
> >   * @barno: BAR number
> >   * @flags: flags that are set for the BAR
> > + * @use_submap: set true to request subrange mappings within this BAR
> > + * @num_submap: number of entries in @submap
> > + * @submap: array of subrange descriptors allocated by the caller. See
> > + *          struct pci_epf_bar_submap for the restrictions in detail.
> >   */
> >  struct pci_epf_bar {
> >  	dma_addr_t	phys_addr;
> > @@ -127,6 +153,11 @@ struct pci_epf_bar {
> >  	size_t		mem_size;
> >  	enum pci_barno	barno;
> >  	int		flags;
> > +
> > +	/* Optional sub-range mapping */
> > +	bool		use_submap;
> > +	unsigned int	num_submap;
> 
> can we use num_submap != 0 as use_submap?

Yes. For the same reason, @use_submap has also become redundant.
Calling pci_epc_set_bar() with use_submap == true && num_submap == 0 has
been invalid since v2, so @use_submap no longer adds useful information.
This can likewise be dropped. I'll respin.

Thanks for the review,
Koichiro

> 
> Frank
> > +	struct pci_epf_bar_submap	*submap;
> >  };
> >
> >  /**
> > --
> > 2.51.0
> >

