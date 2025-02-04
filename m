Return-Path: <linux-pci+bounces-20706-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B18A27813
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 18:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFCB9188096F
	for <lists+linux-pci@lfdr.de>; Tue,  4 Feb 2025 17:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D9A2010F5;
	Tue,  4 Feb 2025 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QpjzQraN"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E4A20C494;
	Tue,  4 Feb 2025 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738689187; cv=fail; b=pJnOJIjs1BfWr2jdHJwgdKHw3mZ4U7mZblKLvOn1eO6bbrYdpdsWrBX4fwX0Ai/DUGv6X8CiIX9U2gXJSirW+Z9bCVoma/oQq+CBzU0NgMLsuUYgAmJZ1CUzIiA1FKyA28oGKKT1N6SkkGUe4fcNDqkX5mCMQJep+xvUaNH5rWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738689187; c=relaxed/simple;
	bh=icD8lRuQvaUuK92u5B17ogldeXOEN1tobeEqK4fweKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c0Ow4RQncdD2ts6GSDnEylmQupfqAGq2CdTU2XQ+18KHQcgJaKoNEXZ21aNSzG/O+tmHC5OhEIiZSsuWoQl/wbc2IIgKb9a2U8hDfaod4QYO/OnFV4PZTWhpSZZjBMbKsDxtj0Yo2jTpeUm4IbosDke5i0CiEeNbDF9vfiCy+mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QpjzQraN; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6XRw6A8wfhVCzNJZC/GzRZEFZuX2sNJti9y3vHnDPptatmEFNNq9JGCwpaCIFV+vwyzrFg+U8oM8rX0Yyc4t0hf5T3kdX/lEHvJUtlcgsr1lOUa91f8anW7bvWCRhVFM9YF4ve+ek/u9w29XDm77Cnu9xn/2oUbtwe3b+NgDewIyQa3uSeL+4hAD4v2cnqBY3b0U2wfJSRMo8ui42Nr7Qa8f+Twc142iqfNl43CXp3YvNc7PP8SFWOLt+K5lyeNooGFLzhKXurEuB0Sw/eRhXRTWWyoeTgjhG3cgNzLkH0AIs8iD3aU+ihqLbJd6v4N2ZcbekNSFoPJETpT4gnMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icD8lRuQvaUuK92u5B17ogldeXOEN1tobeEqK4fweKk=;
 b=uGRtQVWI6yvO4FLdrDH35sJ0c2x8BeVP3WoPDvh3FssLwLWE8eVtGbhk7E92pZVXrLr0gkDAYDeFgxg1zgmAcS73E8suMslJwXwjyLPUB0G6wcYEkRnijlV1Hw3AkDiw6vM2TrvzIktgXjzqVPSWgqE3OtROtIGJkxjdGX44x/Z1qS48MiqmmxsyqpkxKLuLREP8SkjOC5QxcWwhQJtOHEXuc347kvQEYuaTnb0H9v8cMgHAosni7bgzu6AKdwbZ7HADqfmPH0SR0vi3eIkzscUdJeUY4enwBIZlPIgj822Zdi9M1RZgrqQ5PHKsXqTUwUfo1rIbuMtcfYyX9Znj3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icD8lRuQvaUuK92u5B17ogldeXOEN1tobeEqK4fweKk=;
 b=QpjzQraNRt+Xh/apD8h+EbsUpFcKw41foWXpkhmtPb7PYoKumNz5PlslSabMl5AP0vlJ1vQP0fG5QRD/v4othCglkY7H0kr/Hvc/c+c2SRp1bFUDN6BhRVlWWgNrmZsMGv9RYC8omyW25KZB1HIupjEHgwSnDfujUHkA3aQHu8eQKIZMrwuwPys/3wXwutVsp+vEPkQ6SKoGvLS++kKYHWFFt3jQGSfymWRCvQIpEb3CFbdQHqrGZ2Id3zb1g4D7UBrmCBTr39LKGGzpvNL1SbAgd5CkbyEkupfEmC8Jl+/6yB+ME+eHLd3D29b4cn7cLy9uL9GfhEP/CTJcCzpZLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) by
 DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.25; Tue, 4 Feb 2025 17:13:03 +0000
Received: from DS0PR12MB8317.namprd12.prod.outlook.com
 ([fe80::8ca4:5dd7:f617:f15c]) by DS0PR12MB8317.namprd12.prod.outlook.com
 ([fe80::8ca4:5dd7:f617:f15c%2]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 17:13:03 +0000
Date: Tue, 4 Feb 2025 18:12:56 +0100
From: Thierry Reding <treding@nvidia.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Vidya Sagar <vidyas@nvidia.com>, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, bhelgaas@google.com, quic_schintav@quicinc.com, 
	johan+linaro@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jonathanh@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI: tegra194: Add support for PCIe RC & EP in
 Tegra234 Platforms
Message-ID: <2xhy6gvpxczcqlchddfti6ymjlsa6fl3xzgxps5644u5w5f3u2@ywudmcu42i4s>
X-NVConfidentiality: public
References: <20250128044244.2766334-1-vidyas@nvidia.com>
 <Z5jH0G3V7fPXk0BG@ryzen>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hxtvu5qkzebnygqj"
Content-Disposition: inline
In-Reply-To: <Z5jH0G3V7fPXk0BG@ryzen>
X-ClientProxiedBy: FR0P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::10) To DS0PR12MB8317.namprd12.prod.outlook.com
 (2603:10b6:8:f4::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8317:EE_|DM6PR12MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: d68e40e6-4e90-4edb-122c-08dd453f2ea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W81bnsGb4/61iKbEUgR0vKbukIP4+purpMe9VZH+toqU807qmEMaStb7RXqx?=
 =?us-ascii?Q?3YM6+7136/Wt85YV/6GD6i6uip+HtnpIMT7AqCZn0iZr8rXLUm6xhsH0zGXF?=
 =?us-ascii?Q?j6vX4y3BpGWmICslYed4sN7BCNsvhvi1k1Jr30ghhcPhRveBCMUrOzxhF6Ih?=
 =?us-ascii?Q?sxvf1fipwV/KcTFZ9nxmAvUcgQ2ZVbMTSrWs9w3DeI8/yxgSr8Td88In4fVD?=
 =?us-ascii?Q?A92XLw5lQF0/pgkFFajSLqLHS6qHu9tl27mH5fres1mk8gdpthT5eqET3L+k?=
 =?us-ascii?Q?r+lUaK9r/gty/hVBTKZJ/PdazvMHSkiXYp9waZPMwaCLmg3g3YW8gteRLE5S?=
 =?us-ascii?Q?+Qp4j81rZiYx500BrFGDbX+oCBkHCYE1wW6uw8RiDVE3RrhL4KSmjz1jKSuN?=
 =?us-ascii?Q?d5TALx8Q9Zh7JFJF9Y0DMqA8FPKoThgeAbA2vtaMrf1CfoNd2Z6cx83MmEsv?=
 =?us-ascii?Q?pfMiJuQaU4eZt3cfRYPBUaeKgSBLiigtKBaaYfM1OGAwFlNHm02BZv+fARqK?=
 =?us-ascii?Q?UL+DFfVEx5QOBmVfmn6gyOe1ePtSayNpJpLqUIklmppA9TW0fJyQxKHHauWM?=
 =?us-ascii?Q?F6+rX8I8AAVzeiO8McNogf8BtWrqGXXNRo40mDpWZ8/qjg5Zhtf4dCOWVFvm?=
 =?us-ascii?Q?agYpZp6jXqHDH9xODfRSQh8fwoJ2T9YpYzKbEJeHBPut5zYcalDq8S6vaJjz?=
 =?us-ascii?Q?XLX4U2s782ZCALU7YGUXWU1CofD+1t9zbzgaCfdmk4t86CageX+QR4EjmAJh?=
 =?us-ascii?Q?TiUTqpk0qpE6rbR5EjhAjU94a/uRD5fmXxKkO9+fcTeWVzuK/P0i/zqvb+R0?=
 =?us-ascii?Q?4iIt7X1dOoPtib/o4/ONFLxf3BDWbcxeYOPWrbQPmDTVvyPXRxA2brGiRUYS?=
 =?us-ascii?Q?AhKGsh87bKURpmtmMXD0L5Pf/iyYNZNs8NKQ3HiKil6Aa/pvKIsE/7vqqKfL?=
 =?us-ascii?Q?1O6+qwgM+JojG+cr8vnbOPvy8yPRdwv7hSBjYFtcLVMMDrrxI1PEnqpz7CVk?=
 =?us-ascii?Q?fajPuTd1sKDuFbMRvJ8px+80g8ulVf9YtRJN7Bt5YsWpvE5DfHMNdQxWxmHX?=
 =?us-ascii?Q?EyNdoFdZCvZHSBSqq9tyNMWs1Lf/HLA4UxjA3PVIrBELIl7XNADqA7B3PVRx?=
 =?us-ascii?Q?B0CPyr8pqX47fqwP52ZSkPvByQWPExAjqw/FSRtX4nqpzMRXcrWS4yW8iPNc?=
 =?us-ascii?Q?9LHHoEVZHcBwwHl4CD46oHOq1hU82QfTLm8WJl2uVk5RuRoMnQJhtow2RlqM?=
 =?us-ascii?Q?+wF0Ue5J6AGV/PvO7mzRUYi66CC/Wa+KmMucdiR+P5A4EaFYtL0z2MUv/ol/?=
 =?us-ascii?Q?57j/dLMU+OXnx3Kfl1Dz6/D/HmEtNN4JouCloEVdrd4AiVupSXCNzHrANWGh?=
 =?us-ascii?Q?PZUUTgefTeewcUtpmw1MAfIDh5+X?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8317.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sP3+0bcDZ3LJfoX2wtnQvKr6cO1bG7q72NXBEX9LIVnt90AmVeNlt+5BPyjB?=
 =?us-ascii?Q?GIVw1AFjvqczRcop8NvUQkFzsMgqc5ThYV0KHoadZ3FiTgHWtcEWIxzSUy7W?=
 =?us-ascii?Q?prfDY2pURrxjC3nO6IHxWoC9yqC4lD/mNgqpY1wmg5PwwtzzGW4LZlZdPP5i?=
 =?us-ascii?Q?SBkW8SGHj4d1eeSZ5w8NuFPakV6VLGD+tAYXpxSrq06R27RkrSdeIyEVojMx?=
 =?us-ascii?Q?pFUMMcHAgr9AI1EEr/ZcCVA/n2Auurkvtok+SeFXAYF2JSlhj8ZxDFvNAtzD?=
 =?us-ascii?Q?C+Gl2TG0lH4T070eBGm59lmv4q2XZnzzwy8KiMBAVwuUj/M0M4p3HybDc+Q5?=
 =?us-ascii?Q?7VwKrPY8m89e4fM294ruehZBNw2W6MY3zy5cIkr6fmhpEZZtHjsRDIgBhter?=
 =?us-ascii?Q?7MbBE660XxnS1P5KKC0f0K4AUB551ISz7aFawM38hqD2Kul3G8WyYlPmC3Uo?=
 =?us-ascii?Q?1ABtMgUUjw+e3L1w7xSoLkIt5Im+L3LBidA2nvyxzdzhvbBua4tsmh0tjca7?=
 =?us-ascii?Q?pExL+zGr39EqjC+AP2oNurMw3qDdGl0az7MTqXXIIP9XCwg/gAJg/pwdh9d9?=
 =?us-ascii?Q?BKmUAVwZD0H7OfRx6SOgMewapdblkOwFKX37u7SSIPhvYvby5QxDrxjg91IF?=
 =?us-ascii?Q?sy+swUBn1v02exOu6GF4jc4W3irkXItrqn4C6MsAzt7kaIaFYxOtaidAL+B7?=
 =?us-ascii?Q?z1UleK4WGrJLVgkrZTGqNWLckMQAeLDOca2KT+v3KvAVAL2nr3L3UPr8kxPZ?=
 =?us-ascii?Q?9yWwZ3dmaIcOgIRnouZ6MMdznp19RYbiOq2BJdtLWsXG2uboS9I4T/p+QuMR?=
 =?us-ascii?Q?tr2jczgxI0eyvMjDx2HFqli+H0SXxImc0xdWisV9sWuO2goN6TKkSQX5mKtc?=
 =?us-ascii?Q?HWEXBtPB2ksW2ho3nKTfybZ/5Sq0sEH6kEGZyBfZvn5BAx/5qyZNOJioM/S/?=
 =?us-ascii?Q?3o60Iv6v1OH5vZqzkdWRofhCiBd3Ed8tVCTGOlOMEEQAqqP0mWAgB8u4vKw+?=
 =?us-ascii?Q?6GWHYloHSt23rCvzNPGNZng7VgZJ1jJ0KZtdradBBShkeT+h2qObDk3kDIFN?=
 =?us-ascii?Q?aFmMGSEM7h0kf/b1NoaSYPUpEqRw3e9qVAHLGqFul3w9oFiS8FGi8G7By4M0?=
 =?us-ascii?Q?ckWUyjnzvFDq3GRd+yKSHfP8wkdNcVKWa8nb35IwcY9yoyj90Vvsmc0F3WMd?=
 =?us-ascii?Q?AOJAuyQ9haR/sYipletWfxOuQVmHbQtfZXT2KUa2gH6MTp5wgMmniQ2Rkq3K?=
 =?us-ascii?Q?xMmCKJou+W1C6BC40BiCppUPKO7e535+/X/ce7fttLekmKdrV+kKkZ97oe+y?=
 =?us-ascii?Q?H9ZD+w7eaChnHI9nE3mnq5i9Q9xpUGcM3huYmbFQKCoqDGBYGG9hWVQXCSeb?=
 =?us-ascii?Q?5e4gy69To0Gb3z/c9Zm5Di9ZiIolWTDY+/s8jh3BgwvXrz/dTAFuQz535Gur?=
 =?us-ascii?Q?4sWu3Z8fUoxu8sQSgf2YTBmP2StbSUaUwkLxgPlDb9LgZbFHB6uM4EOQHETv?=
 =?us-ascii?Q?ezoBLMunDPau9XCVhAzKQAFo7stdHwYYpGUeZlRH9cNmUGVot9cJ1yWb9ccZ?=
 =?us-ascii?Q?Py8D6uAoSwLJeJbnojnxAP0NnR8X788sZOekzPJkrCItsdzIwau0em6exGDU?=
 =?us-ascii?Q?p6Po7oZNyK2HgFb6m8QlHKGlX4E1tt+USEWV5m+PADMa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d68e40e6-4e90-4edb-122c-08dd453f2ea7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 17:13:02.7863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0oqXth+/PZ3j6vJSvRajKNp7Bnl+jmL7Q8hNYdyN4rIJLzfslyZrwIGLp9UpbIbWyWDwwV+JrF0roNXRspd/PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372

--hxtvu5qkzebnygqj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V1] PCI: tegra194: Add support for PCIe RC & EP in
 Tegra234 Platforms
MIME-Version: 1.0

On Tue, Jan 28, 2025 at 01:04:32PM +0100, Niklas Cassel wrote:
> Hello Vidya,
>=20
> On Tue, Jan 28, 2025 at 10:12:44AM +0530, Vidya Sagar wrote:
> > Add PCIe RC & EP support for Tegra234 Platforms.
>=20
> The commit log does leave quite a few questions unanswered.
>=20
> Since you are just updating the Kconfig and nothing else:
> Does the DT binding already have support for the Tegra234 SoC?
> Does the driver already have support for the Tegra234 SoC?
>=20
> Looking at the DT binding and driver, the answer to both questions
> is yes. (This should have been in the commit message IMO.)
>=20
>=20
> But that leads me to the question, since there is support for Tegra234
> SoC in the driver, does this means that this fixes a regression, e.g.
> the Kconfig ARCH_TEGRA_234_SOC was added after the driver support in
> this driver was added. In this case, you should have a Fixes: tag that
> points to the commit that added ARCH_TEGRA_234_SOC.
>=20
> Or has the the driver support for Tegra234 been "dead-code" since it
> was originally added? (Because without this patch, no one can have
> tested it, at least not without COMPILE_TEST.)
> In this case, you should add:
> Fixes: a54e19073718 ("PCI: tegra194: Add Tegra234 PCIe support")

Typically we build the default configuration with some custom options
(like everyone else, I assume) and usually in those configurations both
Tegra194 and Tegra234 support will be enabled, so the code ends up
enabled in most cases. I guess the commit message doesn't do a very good
job of making this clear. Really what this commit does is enable the PCI
controller driver for Tegra234-only configurations (i.e. no other Tegra
generations are built-in).

Not sure about the Fixes: tag since this is fairly harmless. Worst case
you'll need to enable Tegra194 support along with Tegra234 in order to
be able to enable this driver, but that's almost always the case anyway.

Thierry

--hxtvu5qkzebnygqj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmeiSpgACgkQ3SOs138+
s6Hw6g/+P4yw5zeCMvjvxftMH5RckdnSJBDZ+HyAq2tFHApCQMtEbdObzlHan1LP
deprP2PQgZ73zgCneacIrZKAwhEz4qhQAB8018y7yQrX8+HV09Hs+tqEzKVoxD/s
YP/qjCN69mBnPH0QF0pXJRLOvDCPrtBH91Iz2RMhkf2kqxB6xLHI9xXwqLeeRSml
sQWqNEETHCenkjOlIp2RuOJxetT2A9x4I8MVWWC6oYtQEQ7oXcTm2BMlDsoNRz5v
1V52b9ROFqXExWohBwptf6g/qErnVr9gx1UkdtZjCgQJ1lBKwucmSYzuMhzPXsSk
Q0t/ckCULg5CJuq1aRQktZRxu9EJ56pzzcYIuhdOm0Juw7p5KLbLfOk12+8dEq+G
0DiySUp/DbUmwN948gzZ2LAdl4ZGeSy/ogGvqxbIW7z8d9kOsEgsbZ+EU7H/O2Ap
nfRrE3zh8gD4OoaBd+1u6/cRqWqzKWrz73ZfiBSUhdFp4AcEGWeBo61vhjmBk8sk
yATyBx95vEU7lnj4i//pPopYjJg+9+1nNWqL47k4YDRuYdlboRyQC7q5vtnic1m6
UwWGh3XxC12Elb2FTsHzDsO5aUNmoMOADa5pVAjMX06FOKkiU5YF5W/KTjcXm2gv
WRmxG1/pBqwUOM1IgldZBu6rleOxm4FTeJ1SyORBhfwNv8odPE0=
=T2pb
-----END PGP SIGNATURE-----

--hxtvu5qkzebnygqj--

