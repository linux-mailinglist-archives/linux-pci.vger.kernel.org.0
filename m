Return-Path: <linux-pci+bounces-20903-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB74A2C59B
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 15:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27FC18870A7
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 14:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D371023ED75;
	Fri,  7 Feb 2025 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hDAqiYPL"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A068220694;
	Fri,  7 Feb 2025 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938881; cv=fail; b=Ja1A6sc9f4rDkTxf4Y88X7lsvVWkCbUdbEuL/3MUy+LcL2py0OugmtnO7e30AwPPH4HUmywrPcuPhiwW8FNbc2cfXNBfy3Xbv1RW2DDBPgAiMD9ZJeiJ2EEYHYungFhHBN/xGaWnIXO6Ulr+iziNKpZG2KDKmWL7MHxAL4xkJRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938881; c=relaxed/simple;
	bh=ZtoVJS0tegkA/d+sl5qqvU7Yjt8d0sqjMCFykEC8vwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NnuVjfxgCf9+fZyY8XzCPU6NUxF0z/3FI/Uvs2GpzRGdx6Jy92mJleFy89eEO1f8Rf2PUIbLSPyd3i3wa7NtbWWozqRtf3T8WJuzaqCRbWFxWlpu/OVvMxlRVXv9S87/pXxPq8ogvTRJk4NzelNoLDvpS/vmhuzYGhNkKF3fihw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hDAqiYPL; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1AZ8Ls/IRjLAxJn0l/cGLTaRCw6l1TnzyynRfK4/IxHDOtoPEJS9pHjrvGkfHLrgVI6vnOTn+fPMn19qq2DUvDIXFWD8cuFtjhyJkkfu20QafQfN+OuZm6fb2vStEN2/IMg0FVTrLrjszW06hznwmuAG2+xR4v6t3NUgTL6u1bV40T2DQnUYfW7Hzu5MQYiLEcMgE8VWtFdoi4wPJW7vI+2OxhQQdCYs7Byt3ogkcV8iFdOx5hufTkkYPbEoc/3kDvS1hNnS0CM5+gMGq1wIGDkCzCQ+MHHIk8762kkBW5o3Sv2hra0Rdg/fUwcKMgwBLvN81p4KsBcTG3JhZa3lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxEUbKPaXvK60Rv7uM8BdZFq4zEdtnJRf7i2bdxoUPE=;
 b=j4GtVYCf9ggha48qltDovUsUjo4N1F0HYy3v5SX6TB2zj1vHbkZSMjRSWwEwllttEC7wH8muXVjdIOlNmrvCQAYAZ/rRuDtbaSo9VOTZU5cj8zwcQ5IRZo+kMw4iBQb0kk2bgi6Xtuc/Hq6wfXO0hvh245sUfLi36BzBnlFxhpwD6qlNsYU0C6OUGLN/5NOJEKFbME2/eClQz6ouH83WsLeKbmagKR23sJK4n15ceqKxZ4HzvOYOZAsQGIg+GKEwiWadQebp0dPf0QFBVPyRXKl3xX4FZJsnl7dI0gtpzuoBsQADrxKsELB5a8eltE8zVVHY4F120hKwBizSwZlNBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxEUbKPaXvK60Rv7uM8BdZFq4zEdtnJRf7i2bdxoUPE=;
 b=hDAqiYPLiqy/oJuYGt4bPts2UwOE6F94/51LwsC19zuA2QYyyenGHhDSZqEGG1n3Y45tlFsU4yWWtUL/E9Xh3+kKtsljZjT8zd2gW0R10DEhLxcHIPQBZqIxkmlm58ANhzcYJ+eoLwm3mDl7C3sV6QWls20LjGrYRTFLKWA3Ar65AzBb9FaonYpECKIgfBV0eFaKj4BTIXgCwFWACy/fodE+efVt0EiI3ymLDFly7B+AbH+9ZHrKz0RgsQOC9+kDbBSwQ8FzvTMjjT89IB28VtEFWcBqdvobPYIzbPEaKpSWBSm0W7y8Ajyeg6orM5pW/Tx/wmLCYvK2TFTniofLTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 14:34:37 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 14:34:37 +0000
Date: Fri, 7 Feb 2025 10:34:35 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Tushar Dave <tdave@nvidia.com>
Cc: corbet@lwn.net, bhelgaas@google.com, paulmck@kernel.org,
	akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
	xiongwei.song@windriver.com, vidyas@nvidia.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com,
	sdonthineni@nvidia.com
Subject: Re: [RESEND PATCH v2] PCI: Fix Extend ACS configurability
Message-ID: <20250207143435.GS2960738@nvidia.com>
References: <20250207030338.456887-1-tdave@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207030338.456887-1-tdave@nvidia.com>
X-ClientProxiedBy: MN2PR01CA0048.prod.exchangelabs.com (2603:10b6:208:23f::17)
 To CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 18d9a92f-34c8-4b50-6031-08dd47848c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f6tU7OuE16EsEL+xW2867xOr2Iz4lbvMNivppTnoTjgIW8RYVMkjhBGE8S1s?=
 =?us-ascii?Q?FUXk8UBCPdQA2HqbwZ/6HlbVlm0gSayaaDdE00DOOCNuEhh17T6oiBu9NAhN?=
 =?us-ascii?Q?EFY/e9FE18Dx2Qn/PUFqm8LdNMw6kc3GmK4EX6hqE8C0bwPEyk0dvAyKi6Uq?=
 =?us-ascii?Q?06S5HsOREBPTPxz5Bf7DtmWvgsmZk9B65kfc1NfI9Jfrju6IM2HH4B0iH5G/?=
 =?us-ascii?Q?N+V90zryQ4S5B3xUQK70lMqKtC5d4+7fujUycsF67DL088yEIQOGkHlo8e3F?=
 =?us-ascii?Q?bO5C6dhLt9oX+qetfCxRXNyDl25aiNvkJajonSNY7eYImOc6u3TUkcH1E8bQ?=
 =?us-ascii?Q?f5y7qVdyLGev82a+dNwt9Mtv6sKDXd5pGypforOd4u8bf1AuSpqOHHG0UYTi?=
 =?us-ascii?Q?6mdVhijBP71kgL+E8NyS1A7UNKGs/BMJs+1acnMON3obt9NgCJ4mBIdd/oQ3?=
 =?us-ascii?Q?y+ODli574s/NB6Oatw+uA9U/mqV2RBAnSca9E3xIj1qX5iaXo1v+6YcbAjbd?=
 =?us-ascii?Q?mLpUzoGaIts3oAhnWY5ajgFa3iiHBcS6VeWHJ9+xiHr7YJ0JX8IK0Y/7wWg4?=
 =?us-ascii?Q?AhGwfZexVfmBieO115Jj3nFoizZukVi/MvrqskaKt84cxJlzueCiR6XFyKC2?=
 =?us-ascii?Q?QmksYzamLIsCOmO9UGlExIxajv++cdZBBSQ1H9fTQUDHKyHDMnAzU/2yMBfj?=
 =?us-ascii?Q?85GjfLN7ipUN3OEooyUXyIy4Eiv4avQdAvpSRbpbKvUAKUJP8AR6xTZx3VkP?=
 =?us-ascii?Q?OIvKE1ZRkH4biq8C/H6eynNGORmMxLUGyxIFokEQfMYWZj8q9jMk2A3CWofp?=
 =?us-ascii?Q?wScGfSnltAZqw4sYtqtDeO9Z3oANfVFyCQIgZe6zjcADS/Ufxyp77b9GVJIP?=
 =?us-ascii?Q?pVPub5VWV+XiQN3xYBe9BwXWvlbEEIW+l8CKBCNknl6wqZaeH6VQbSLdvfGD?=
 =?us-ascii?Q?T3Qoi19K0916vXJtPnZWtATFdypZTWIj+oIndNAMuMcD2serUWFF6Evezof9?=
 =?us-ascii?Q?vRTYcbgD7uT11PmKwV4FSgipzv53ZG1MaZCgqAJUayxK8L607EpntjDMCNEE?=
 =?us-ascii?Q?tb1SCoGmD32uVbdpZxUY7mjaTYTE17mQnsT7eLjL+eD0BzChF6CvRSaIPaXj?=
 =?us-ascii?Q?pyxzOkW98GIRMtsOYSUW78C3Nd4kHPd5UHdatrPycloUy9ssHMbf7KCDf0lN?=
 =?us-ascii?Q?SYHshUzsmiXlkHPWi9W7qYY5acfZOW+f6g/JZx8EbKl3aKEb1qPkwHcqu67J?=
 =?us-ascii?Q?c3xloCcRjCJJyPUNN437WvLamFoJHvsipCDlD21/xYQdAeVt+InYeAgqWMnd?=
 =?us-ascii?Q?1lmUdiVCH3PxhUIpJXEsaDCKW7DzSIm1VnrRGgzDoM0axiHIYK70tVQu/bcy?=
 =?us-ascii?Q?iCsBKQlNhbn7LNZwIjCbCeWsrWZ/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n8TFznpbrtKNwVIhoG7iqdYDdJaRtb/CzfMOCuX6qprxERru2vn3GYQEzaYD?=
 =?us-ascii?Q?cruMXySZjJQD3ECh3js3NBS1qKkzOssC9qyU+Q3lS4/HPCwJwZjJ3XPSXbN6?=
 =?us-ascii?Q?eoDXIVMcF/rUNnS6iRyxv54YZBInKn3S7hrBWs63lOCKCiFmBuHU2G46XNvV?=
 =?us-ascii?Q?T/yZPm4J/2TN6hHc5kzT7lz4RYZakaS3FFC4Xw/emWqHxeDbiz9S6KiG7pyR?=
 =?us-ascii?Q?U+5gurVCsKeBE1aAaa5+Vbje3CS+Hy4JV16l6yB3Qny41wAeGQf0/KFwspfA?=
 =?us-ascii?Q?yocFbf/p9UBCWDlRgVOf49WbJ1pXo0eXLkCzF+ZrljVW/aZRzGM/dqDybstP?=
 =?us-ascii?Q?4RBqUjgww0NhNTLjEn7e6ecEVVNIzeUWHqFhYtPnCGWl5SDqoKe9SV7Twd99?=
 =?us-ascii?Q?vXSt8KO4ORCtKxQuWxUTdheUNfY88xfqh0WEl7Xi1Hcz8/IjJknx+kF7mb2G?=
 =?us-ascii?Q?s8osjU2IYSHLnlHupdGiYPqIj8gM9VXK+CfXN1uZ4Se+yFW3mahRlCObwruV?=
 =?us-ascii?Q?G+C5bmQSnf+IN+fX6h0pDPm3v9XxwkrcPjw+s+34FRhxYKjbOhgiUXlUaOaE?=
 =?us-ascii?Q?2wnRyPw1I567PRaXSiaPd1N8sm5ySwUz/9kMcMkP9536jxJPvQ/WzCtjl7Wz?=
 =?us-ascii?Q?P2v4Z9UJ+b0zyBZhWiMeFq4atgkETndqzFKCKMVcjFBhpsS5/sBb29sqtLg7?=
 =?us-ascii?Q?t/xMNcvYg6wil2H5lGVOSvQFE0tmC6dEWH3cCd4ReoDYO+e3+upC7jxYHzMG?=
 =?us-ascii?Q?5eWHbBzURulF6bRnFwig9U7cISiPEH+7i/bPMeWc5xvt1OCbZcsLoaKkBI5A?=
 =?us-ascii?Q?EiCku1xkrnZqnLO80uyRSAX7f667UcbwlsaKsj7c+86oLTfMubSSjVcs9EL/?=
 =?us-ascii?Q?Tg+Rn2zQ326hQ/Xk6IFj3Cktq1YHs2G+dFWKbd7BY6Exqg/V6LcvMVhDzA+J?=
 =?us-ascii?Q?u3N7aBM9srQxwrULZCiGw36lZK7wmTtjwnCShFr4mOrh+EScsEPpky82pYrO?=
 =?us-ascii?Q?Mn0wyjHsK6DIXzJijU9NHX2c5Skh8En1cepkvieGYOGFtlHOD+H5WKoHMk4C?=
 =?us-ascii?Q?T3b5/g7Rhb1AFkOh7XGftm2gEEYlpmSJFcusr5Rm3BtZIjPSMuURp3vwh2H0?=
 =?us-ascii?Q?ZhvMiKOw01iwsp8m4OZbpMJHX/8IKEfAQkSQPRGSyvwCttTom2vgsQ3yUqyY?=
 =?us-ascii?Q?zoQ3+lKrFnm7gZfFNREH/l7fLbr1aUQBcgu95a1C5YTicXSuZjhRJ96zahSW?=
 =?us-ascii?Q?oXiRQoczjOQa8oYu4XYHNLKE2LehvMnQw/p9IZdIX8O1DCt1MBAj7oCSgB67?=
 =?us-ascii?Q?zjd/rUZnZYVML4VwVuaFEHwJiomp8/YrN2ADB0uqJvg0X47nJqbp8eOAQsYI?=
 =?us-ascii?Q?6ACqM+aO2CBHaFUFR4tW5t5UOUgHCTDqINmQQkQFQtxZ80hk3JVMhrNwzI/j?=
 =?us-ascii?Q?NliIRE3rTN6vncHK61CQ73eF70c0oBKX7Hlz/6r28uqUgmD9EaNlEdetWsLq?=
 =?us-ascii?Q?J5qdVY1yoVGd1VJvrPUj6+1efMuFqH7Lnh327fR0up0ZsSiOOsSeREEQYHou?=
 =?us-ascii?Q?gqxIccm9z326d5MK0LlhBoaWOUtQ1bhCbNysRDIH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d9a92f-34c8-4b50-6031-08dd47848c58
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 14:34:37.3802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjWHOBv9heQXzXg4lPB+c4uIcxPx44Av0Z4QYfgw6/1CUNkWzoawZb4aQlHY5QBv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992

On Thu, Feb 06, 2025 at 07:03:38PM -0800, Tushar Dave wrote:
> Commit 47c8846a49ba ("PCI: Extend ACS configurability") introduced
> bugs that fail to configure ACS ctrl to the value specified by the
> kernel parameter. Essentially there are two bugs.
> 
> First, when ACS is configured for multiple PCI devices using
> 'config_acs' kernel parameter, it results into error "PCI: Can't parse
> ACS command line parameter". This is due to the bug in code that doesn't
> preserve the ACS mask instead overwrites the mask with value 0.
..

> Fixes: 47c8846a49ba ("PCI: Extend ACS configurability")
> Signed-off-by: Tushar Dave <tdave@nvidia.com>
> ---
> 
> changes in v2:
>  - Addressed review comments by Jason and Bjorn.
>  - Removed Documentation changes (already taken care by other patch).
>  - Amended commit description.
> 
>  drivers/pci/pci.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

