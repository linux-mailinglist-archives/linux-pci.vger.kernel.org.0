Return-Path: <linux-pci+bounces-15542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 061799B4F63
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 17:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57BECB22037
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 16:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF7A19149F;
	Tue, 29 Oct 2024 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pspr4iUj"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D349C1953BD
	for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2024 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219603; cv=fail; b=jP3bVBGK35UlBBKupHE+baPVIx79/cMr6iGCO5u3vgh3omSUXTqXKJHdO5qn70a2foFWmDgRCGT7aAgTgdfCfVnxj/x/CgCNExsyXVFNHxl/K3UKgY9hGIWiriiTe7DU1p9KYJgtzbQEe9nhZVX8zDKGOjp1CUVKi+gzhoC+Xs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219603; c=relaxed/simple;
	bh=ae+m4WUJi8B8fQaIenzs9Z2LEXeqj6OIAcecu5XcoP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BprV9Zipd43fQyacEnFICg9khpw3grfKKknE5bzI6+he7aU82IRldbD06yqx2F1SM0ZhIIR2Uawj+xveTxkeCPZaJ6kANltQO3o/P94fQ7XqFRrsfJ5nyNcwtY09VKZZi8r661sF8MzquDLNKuFZOQ2LLpq3lmV2hxDsxAfhZx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pspr4iUj; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utp1tmF7TgnkbNw4p1Xtt+efLDCD9L+EZjGKJBrQtLlTmJOBP3KUcL9ewXiLkVOqCPiwnXIGnKYW9WxSfQFKNtI90cT2oIILkO4drjOtTILE4rJjMaX2KqIkqI3WNs6aYF7xsyJdMRYzna/Z7RoxDj8IiWF3QlB1Jsd8JBfLkR3p+A9nZgk8JCBw3jDLkxGcw7cxg3PzFTZ5VCNFTT7bxCZT7smXklybk3iNlTXQPz3VjN+1B5R0pFvKJ9vuxbAu129mNwNvE9tsdUQW0q9FtnZEYVVBw3PP63F3iRqfCjO8bMQ+EfL2WCdKHSeWPi9wF71/3nUKnnrO79JLEelt8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjvkKfueo0L31Mag0EYaUJ5n+L0rB/ePavD40yESVKY=;
 b=HzeAq2IPccS0P4HTYpr9eNL2B1+fBIDTDCVyVurnsyuRBdGEkTBy+QNqmJw+HqDSpnSPByDmCc3l0JY7Hc4+TCWpeZhkZAoVuzZJw+eSjFORxd5bxQx0SJWb4ljlbfUCx79WGwzBct0I3CglWyGuovrXHFShJK3TdDbZ0B8uLdq4rzjdyrx0ixShIBhoFyWRbvnok5ajmk1/Zh9MBZ1MhZmLV4J2YUa+yqVDd/heF7D3MHkBN5y1HQwI4+Uamt9nF1tlXyBvBrL10ZJU+ScxEWIYh+tBqebnb1hIFsqu6u6AU/wI9HRloBeqYKz0xFNs4X265vePGEcnfT4BP/pi9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjvkKfueo0L31Mag0EYaUJ5n+L0rB/ePavD40yESVKY=;
 b=pspr4iUjCnqacD/wutpmrCHOGq7bG73sMXIaD1ORHPQ0/2tGNHYLQTmV5hIWocXROfB9hgcnOc+ajL6+n4poWeVnEkCWLtVVADErpd03KiTVU6z1bHakgUf/rQDUOnijUmKnJ+K3gc350KxHYPQQ06YuNqEP6cj7/8KyBbJk3dEJsk+Ws3Xl4nQhpICQ7Fc4LKs2q6dr4zegzWLZt+R5PHkfo2u7zhNC2AB5nmUffaKPpOWQdBFeanA1mY3n2bUI5o1wgXDZHCI79ZAQW7tzlPkc5Da/d9geHJvhxf0EUfoUbr4xZ8IoEDTDbuE2gbjMH73LeA4ycBVxV+2js8X25w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CYYPR12MB9015.namprd12.prod.outlook.com (2603:10b6:930:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 29 Oct
 2024 16:33:18 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Tue, 29 Oct 2024
 16:33:18 +0000
Date: Tue, 29 Oct 2024 13:33:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Steffen Dirkwinkel <me@steffen.cc>,
	patches@lists.linux.dev, Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH rc] PCI: Fix pci_enable_acs() support for the ACS quirks
Message-ID: <20241029163317.GA216411@nvidia.com>
References: <0-v1-f96b686c625b+124-pci_acs_quirk_fix_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-f96b686c625b+124-pci_acs_quirk_fix_jgg@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0120.namprd03.prod.outlook.com
 (2603:10b6:208:32a::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CYYPR12MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: ad7e0b09-2089-451c-5104-08dcf8376540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v3WklN/iv3xI/zmZMJ1/TleB4mDs6mUgbe60VKlDqHKRZOBMBT+DWaI12EOI?=
 =?us-ascii?Q?b+qCfXAzQt8wJL7GChePPZHnz3RK5ApZT7dAfh8aIIAoYjO5Xz46tV7kbcFA?=
 =?us-ascii?Q?Kslingy0F9tz6eCYNzzBR52oPnIddChEbOEOVx9mbNeVP/FIR/rufMd6/m7j?=
 =?us-ascii?Q?sOV0I8EULHVgxHcmOFRN8XhEoGgDhDuHezWPjZp7xRgzuA3JO2lEIO2j5Not?=
 =?us-ascii?Q?G1OC+65FV20SIbfjxtwK8HowF6CAe0f6B/4/g0Y3Pn6Yp3pussnBYYUofRmm?=
 =?us-ascii?Q?+uVd6reUNrBapzQ9dKKXpRdN/a04ktE95Hij2dYx+8Xha/Onyj2Ko+LwWLSF?=
 =?us-ascii?Q?q0O4VuZKyWn6QVnmF4R3Bgih6Cu02XRh6rr4GJ02vO38KuApElcp3xeu3OwZ?=
 =?us-ascii?Q?ioy0bwknjywNsLhoSBZJBYjQBbiq1jSQG3f8y8p8wtQeF6UQICOluZoHhCjQ?=
 =?us-ascii?Q?RHk6sfSmohcVoeMftTd0lXNO/rmYzKFtUXNz55aOGYn2zrVJxSM6TRNlfAuk?=
 =?us-ascii?Q?SXt42A6pEUQ+NPupVknzzmNyxiMiJc5cpSeSm0JNxwi8CWN7QbiT1NxRZP1z?=
 =?us-ascii?Q?fYrFV202kDhywOsb7agyNFOSk82aV7JUaAfrR0p/yWYgl0KSzRIrE3FPOBd1?=
 =?us-ascii?Q?kdVB964gBQPt1u+V7N08VBX8B+bTsvw6ANUQUWbuZj7eZ0gRyvSjKBDiPDet?=
 =?us-ascii?Q?XqeOEo0ByO6dBe81jc4nb1gvT5JKNKKaWfXkoGAtgb6CBT/1s3ETbDuOSxQM?=
 =?us-ascii?Q?UffdEKuUXr5jV2O2DKoUabe8MVa2n+ToHUyVh3P0zywz1Vy70WHJXscoXm7C?=
 =?us-ascii?Q?Fwojmqtm1orhwNjOLQr5Z1UHb52Z0f9SVRUDM8k31wLRQeagZh43lzRRkyZL?=
 =?us-ascii?Q?7tb1NjVsqQQIGs2JUTMimqampEatPf+yzelk0mSyXOnpCYltU9ifap7+A92t?=
 =?us-ascii?Q?h/XqExk2m6KnO8rLVRSw7LR3k9HGt9NFnmkdc+v24jK+wJbBY/weq7LYywus?=
 =?us-ascii?Q?Cb7s2g2tguLxOqFT+7SLLFrAr7z+Gh37h1DylAbyA2RlUHVgheyNt/2gfIbm?=
 =?us-ascii?Q?Oqio9CuzI7OGTNKV8eSfVtQsuY7AUB8G4wRqVXc99invwjaiOiELhDe0Idqr?=
 =?us-ascii?Q?WIlL5CZhnxauyCoejJ2z0vodoT7tPi51EZC0w215emehl0VC/HsZWQCeW0WR?=
 =?us-ascii?Q?3y+UUYi0op+i1yN9wjlQVCMQNIS/L0o7bmqJJUGzH0KdpsymVre26SzDI0fQ?=
 =?us-ascii?Q?plHJ2BywRqQAABbBKZXHl35uh4veM8EwlE0YWDOsj33CiXCWT36nFo3FwCC/?=
 =?us-ascii?Q?2etRyBaKSal9w0/VH9LZVVnM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XWAPBtvKxh+EM8GNUt34UuZPzIUPOnzU6fUjPFMl8rXSkeABPiGqFq9beY+A?=
 =?us-ascii?Q?lJJ0YTDJZTGjgXfAu9lizE6E+TpQtC2H8aNlVNMQ5CtArL4OZUoStmOzlGaE?=
 =?us-ascii?Q?dXXE0JS6Pd+xQtuJ+AHpHkLmMsFjYQcFt67W7zT7moqBsYlLqPFj9aQGYUC2?=
 =?us-ascii?Q?5RXY5Mx2vQrc5LfQ9+crrDUXpTocRDN1fTnVDdJgTqZzbrKMgfEHwO1f64B0?=
 =?us-ascii?Q?WBR99W4Mcl/qVApk5rmFDdtA+TF8HjIrZSyr8GsGaZKAe7w1kHpEvMtUaTNC?=
 =?us-ascii?Q?SxxX4iLvky0TbI8A5Q8S4O2m0gULmYxf6NJRzUaRmR3q/CufJ+DLGI6Z55l/?=
 =?us-ascii?Q?RCi1Fsimdr2k8wXWrMuOlEWAVlj+QlyY0rV5nTwOUJrSQN6sQokpBTP/MzSk?=
 =?us-ascii?Q?GBgDmPfGzFGpL6oo1gsslLWOKnOx4T8jfYaJ8a1kAoKhjOFHdjy83IjH5jea?=
 =?us-ascii?Q?8cthQd3ZHK6gw14zSQULOhAkEqPBBNT9ECr/klD9eenzac4cwRMOHddAuZTt?=
 =?us-ascii?Q?nKhPXR33vHuzib3AFzJcTL7E+R4uyfEviKXnwpOlr+Ra0M1H1HeGuZLBfu7Q?=
 =?us-ascii?Q?cygVZzOqnUYhU23/fEPpEYdBI8p+srOCNzY/I3h2tbmgxOEe1kgcVtFHYOZF?=
 =?us-ascii?Q?vutmbGJz7+Zj9QdVx3eIkYAAGllIxz5QL606JRPILJz+BNR4IMTwQ5jcb/QO?=
 =?us-ascii?Q?K6H7zI4TY3n1WacRt37ugIgPD9ajwudT6jtti7QObsOmliTSM0qoY8RzMRJj?=
 =?us-ascii?Q?kq3H3TG1zoipwHvSXy/humUpjX9yIEr/gb5/9GCTzlc36TUhlzAeMuwttfG3?=
 =?us-ascii?Q?tKAfHwbZ6iyDGAI/1gl+u/w9BYwXyrV5aPyyOQo+iirpdWFKiXBnaL1pHOeV?=
 =?us-ascii?Q?yYPU6+MxpnFrYe/zPQXzkcUVE1U8lxvqsuAkYf5vxPhQTXTzM5se8xV8SWCU?=
 =?us-ascii?Q?lO/I5SH4aaenAAMS2Y/cZa33ELS0y9skpcrEHG4TaZA7N+DLq7UpplvPE40T?=
 =?us-ascii?Q?8LYY+kw3CAUZit9GMsP2cr2wBJTSLIikAYF8XJgKkUYLmSJOUhaYi2UEl5un?=
 =?us-ascii?Q?YTsH3qkwfPVD7D/VpkWimTygpZl0VOzzgSNOoL8qK2Pw7hRdYJHOsR6avqWf?=
 =?us-ascii?Q?vW+h2Ax6WwN7oPIS8StO2pVYYzfpZB3ZkwgBA69DethRsLLgpVl4MN+JCm3t?=
 =?us-ascii?Q?dXSeJvqHX2lKl9563IACbBge6A6z6NUWhPm68WHP7/Ze+yexH299ReKTgExS?=
 =?us-ascii?Q?s13Sg05rXdaoYZLMvdCtSpWfAvLk4NTPSQu24eWZ5oulH+boFELu+iFsUTq5?=
 =?us-ascii?Q?T3uVPcu/UizeyANrCM09QYZdCJ/g1YlPEFXJtbaIKTMTEw1RcquE4gRBrJdu?=
 =?us-ascii?Q?p8MYrVf0KGETzLnPhrD4jXZ5X3b2lUfv7dXH3uQ3PgbqJ5TijGoQMsMf5L1E?=
 =?us-ascii?Q?43N+i+IsJA3OpJ/zBtge/ge5WMvZhkwx12tVvDZMMtdgIuHnLVIbGTZd92Tw?=
 =?us-ascii?Q?xJnUA7qxddkI0/AvEtmKDVns5ZhkxiswO6bf08vYKtHTBDC9hU1571d81n5M?=
 =?us-ascii?Q?jkjP7h12WKx1/B0rqVg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7e0b09-2089-451c-5104-08dcf8376540
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:33:18.7363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wChwV8IiQiM9pyZgvWdRwc7cZSuxYoVPsdTPeY79hBFLHRc/STAGeQgwpYNTgSZi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9015

On Wed, Oct 16, 2024 at 08:52:33PM -0300, Jason Gunthorpe wrote:
> There are ACS quirks that hijack the normal ACS processing and deliver to
> to special quirk code. The enable path needs to call
> pci_dev_specific_enable_acs() and then pci_dev_specific_acs_enabled() will
> report the hidden ACS state controlled by the quirk.
> 
> The recent rework got this out of order and we should try to call
> pci_dev_specific_enable_acs() regardless of any actual ACS support in the
> device.
> 
> As before command line parameters that effect standard PCI ACS don't
> interact with the quirk versions, including the new config_acs= option.
> 
> Fixes: 47c8846a49ba ("PCI: Extend ACS configurability")
> Reported-by: Jiri Slaby <jirislaby@kernel.org>
> Closes: https://lore.kernel.org/all/e89107da-ac99-4d3a-9527-a4df9986e120@kernel.org
> Closes: https://bugzilla.suse.com/show_bug.cgi?id=1229019
> Tested-by: Steffen Dirkwinkel <me@steffen.cc>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/pci/pci.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Bjorn? This was a regression?

Jason

