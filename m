Return-Path: <linux-pci+bounces-45197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA274D3B4FD
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 18:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC8DF3045F71
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 17:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD33732AAB7;
	Mon, 19 Jan 2026 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ae24E7/m"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DD331AAB8;
	Mon, 19 Jan 2026 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768845513; cv=fail; b=iaVPLvO1lljjxFLJ9up2HWUZ8XHwwwUem0gKCL7il2JXr/nu8D+sWrcvs32cCoioMqqbYIlZm4Xsbg9GeLELJBocaks10tbx83M8BPaGWTTUIqEUDU4Ztaq223dMvFuCrkVU42KxPSF9qvyCoidKLMkWEh2fGX/50NQazBASP7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768845513; c=relaxed/simple;
	bh=pWgaMhpOyHSp9QXDh0DCBdKZFlyxaiFZmoaoofBopYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HOW7umQg6hkOyqfH5lsCwSNzHgNTQlbe13/8fkfRB9pou9vMDZmaQC13oQeWrpXf/wTBH8ycxSPA5pTu1p3tVhKT2B0voN9xqalujbrWLBgpx0oveI4+zowYAi0DFmi3brAjW+Mfj5EmHhmSjOiZjWWnMBlW2rR5KhTnYFAiOmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ae24E7/m; arc=fail smtp.client-ip=52.101.48.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfB2zIsyO1Qw8DsnxJvWzJ7m++25VUVF6hReILs4EAI5YGURxQgGiZbA54X9hAiTKs5H5UBMefiP5Xae6LBCsQN4OkYKMWMIod9lyltG1R/DoajJ+b9txK4U2bkqz1JSjX1ByRDo7fg3cA5A+2wBUtFoUo/b3hFuH6bBoCNJOJ0G120uUqu6/+8NArX7hfCSiqW8b3f8VMdgEFUkneFJKtZPqqkHA441aLxTApwg7FLP5RcHkXgqPHhlTNQb4NRq5GXbcd64MfkwIWgbMuCbcgOPuCTE2gvmNVlQT9TSrmUfl8E6SSgEp3+MBr3dZPwj6+tTD0MgL4YI7pmiaqEOxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpeHolm045HSXMoKHVAKhsTZ+TtNNnZMrsJjjCgBeC4=;
 b=WgC0Kiq7tejgfkt0jpLYZ8U6nIzGeFo7xUTumV9JzUQtHPOWvHbGHgh3zfjztbn3KEwq8834XGmaQ5q0xW+pmlnc1yvNdTptXgVx9CmO+1IW9kKLtZq6I8A87R7HkAmDi15Q9Sn71X7u2FWt1761nL4t7g8GqLolmOEhJpzOQJ+o1reNhtJ/0ABsliJcSuhK9SQFeKsjkr6XagnlTTNYaKye5QmERrZEDVa6KNUGxNuHCDn0yK2CywLZrvmQ9oy0ShT71UFPX2sccQSeVohMyL5bGNjAHwPcbAQIMFSmOarm6bMcfnWA9NBybhdUHXf5O6tF9mgV9nIQOVyjINv4vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpeHolm045HSXMoKHVAKhsTZ+TtNNnZMrsJjjCgBeC4=;
 b=ae24E7/mlIEYd0cSlQ8gAezJdRIttwpYof7B4rPKjbRRmZhlSWbbtim+pzaZFCXKp5nWbq2y4XoSe5Hfe2w7bdw+bS04vYQerCzE1NefuBXpdnj0n/srgGvnUoygpE/C3fVa8dunvzL4rZ3L9yh8nVRAIyPkeoHhX/aFfc3LdvWENlUDH95XDgMohci9sYGHfakIVboAg3W38RVgntB0uJMfLRR8PHiqegyVlJlRvw+TouPLNfeMko4VVhkCImldJEJ8/RYJ5ztyRs+ya/6mGJ97JwMzDQx1dAzUHK6U6yAcwVpZAAoI/o6r4XKItSeHN2YoAfdKFbGY7btrUeBvaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH2PR12MB4182.namprd12.prod.outlook.com (2603:10b6:610:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 17:58:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 17:58:27 +0000
Date: Mon, 19 Jan 2026 13:58:26 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
	joro@8bytes.org, praan@google.com, baolu.lu@linux.intel.com,
	kevin.tian@intel.com, miko.lenczewski@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH RFCv1 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <20260119175826.GM1134360@nvidia.com>
References: <cover.1768624180.git.nicolinc@nvidia.com>
 <d1768bb6384050a23769f20ca28216f520f77e26.1768624181.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1768bb6384050a23769f20ca28216f520f77e26.1768624181.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BLAP220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH2PR12MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa01a93-40f5-4a7d-036d-08de5784591e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o/eollQGlXD9VJJHoM7TlTFNed30QMlaIm/ZqjquEtfWRLnzIGnsHAWD0XNS?=
 =?us-ascii?Q?iB70ifEgpHKLvo9iKROT12mm3OR2F46rA1rlUbaci9IdPM011l1LfQ92KMcE?=
 =?us-ascii?Q?+pFN3DO3Vsu6oPv57TB58RljaXkrlSTHBYjcKxMKntoJWVI384QGfy3B4vMa?=
 =?us-ascii?Q?/xrXWyUK74PItV1YJGgSB8ux6Cd14PDlKDNP3sb/L3EgKjWkmdeL7stykYnC?=
 =?us-ascii?Q?HQjtHBKJKKNUZmq9VKrfA/LBxCSqDHasJcBDmbvzv9TSOyzGRVmfXRUCGlp8?=
 =?us-ascii?Q?5gcPJBEZvX6CAEuiUA1Bij6OqW1eN3IxoylZxNpgMZctR+XElygggj4J9UCV?=
 =?us-ascii?Q?dP4uXGnRt0l11j3Pr1U0kRub5ixcTePmIpyvxq3lrbkzqtjvvyn1LM0va7Pw?=
 =?us-ascii?Q?wMwHoLNS4TEdSL6ICv3FCBs0InmiR3wBKmu4dVcVaaZCBBqSN+vgCjholMeN?=
 =?us-ascii?Q?dGcb9bKjGI1iyR/t9PG/8Jf7NT5GSuiwxR/mXOx2JVRgNfDupU5rMLN6NKEh?=
 =?us-ascii?Q?tuEdHo9xGayJY+Oj/7iLprNf7CEDmHxEifM6y3vB5e5MrrWTkzCjVw8ali9d?=
 =?us-ascii?Q?DG7V55ROQPaopWZW/DZ/tnCV5XeGaTe1DpW9sQyPSJFzrrI64rT+6WcZ4/ym?=
 =?us-ascii?Q?QE+l7aEuykBTlFDu0+D0YHdWUW4fjljO9nWa5rpcefflYyxkNQV+IGT0C504?=
 =?us-ascii?Q?A1qCsyGH7z9xsxyDDKr7SnpeSPzLzbGJKV/zxbqQ02+aFPZT6DUfye2tFKKp?=
 =?us-ascii?Q?CR6MFoRSU6c5aaiNkDDmw9SnZcwHgTX8W301IHYY/fcATgXr2EvWKcJe6X5b?=
 =?us-ascii?Q?TO7EPFZebxI5KKCvU253ivi28aBH5NDrbcA+Yw3qMSj0vSqBmJIvTSzqVBvB?=
 =?us-ascii?Q?KcFMa1BnHI6U/2/+28qa0AfjKtwlzctdS4HuYqfYkpBLVEVGRBTZHvFWNxJ4?=
 =?us-ascii?Q?bkfuyprk/8SW9gYHNLYQdrFo2lYZcewdvoSj+1AiXNiEKO+2BFVUMOYE6pLo?=
 =?us-ascii?Q?Ciz0z7eb51v2kev15WoiVtftQoEXAc1dNFTyRfEbyy80LLhjq1Ltu2BSOqBX?=
 =?us-ascii?Q?iP09WEL7pVOvcGwNohBWm/FwPL8SostB7EyokYz/nexXIwfWztAn7kotIJFW?=
 =?us-ascii?Q?rhtm3fvX3z+t/iBAyUEN8aFV/uRk3yruznHfQZ66CK27ZugbFcafGFLo1R9A?=
 =?us-ascii?Q?vtxAqtknPjGZP7Im2edZI0KmRnejmE32znLUH86GiIv1LVes9NZ2UXc9pTJh?=
 =?us-ascii?Q?azS6gjp38q7ABwBXek4yCzrXceYuJ9uRpjCkXYGmUCzATh27IuLhRW5almp2?=
 =?us-ascii?Q?EghznSxx8TYUtzj948TxDfFVAAdhN98oNsR/RwnfpPx7EIESmmCs5WunKnrF?=
 =?us-ascii?Q?TuXdX1Iocyjcw8Xh5HIXeI8aQLXy382eecBslDGgE+MTScBORKTH/ZIO/RXv?=
 =?us-ascii?Q?3cOOhXpYe5UPtgcoUx64Urh+ByHkYLEqikjNkfs2Dmzn7iFDQT101DD0ySRw?=
 =?us-ascii?Q?XMcI2oISIzbJaIEyky2ALWUWGN1sMzoE1ZPJVYg1fjvc/rFpsmi9RkN2H6Rn?=
 =?us-ascii?Q?DrhYzC6G8oIcLYaYBQM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B/icAHrfbwIt8iUp4K79CULpDPpOu2b5ysKuisKJGJ+UEoRAGmaeOqPTLhf1?=
 =?us-ascii?Q?ewVw2SKtKv5zh7BoqJaW+eDwnnxEqvRTKSzAvYN069HICitFS50nlP71F03q?=
 =?us-ascii?Q?jwL4GbK7ITPbbP4JLWsXUlZl/FVuQ7RPDWlD5a9VlaJf62D9iII70+WzwT+4?=
 =?us-ascii?Q?53rJ1VJEs1CyLSA8/nICknycMv0Bo8m/NCZWphDfEl5t9XTpZnOdcnMRHg8Q?=
 =?us-ascii?Q?yffHMDduBqcRWfyzK/mGi5J3mg1Mm9pRch4xyabuYSpF/Az0fdZGL1A5vk7X?=
 =?us-ascii?Q?uAWAE+ly62cOCVdMPeyq21PvgZlkobcdBGGbEpIvkxE78gu2QLvC0tkJvVjR?=
 =?us-ascii?Q?PfBq6sQavWtV8Asb+mzjJUumpWOuSe7a5rBxKauUa6oDhdsbNieO4F8jxfYS?=
 =?us-ascii?Q?TVwncYwSxML6aZzyoZ4loPjn9EBQZb3yby6oEM8EYivPDN6rA5HZO890ZYA5?=
 =?us-ascii?Q?Ooeo5pDJi3GBy5mJ+Shq/dx835CUltM0TfBwOI8eTAB46Zb8jfziT9ecgg68?=
 =?us-ascii?Q?RrturVPken/25Axibi8wQMUkz7eavcRpK3ZdETjln/s5+D8/0Xc5JEhI9T0o?=
 =?us-ascii?Q?KYyLynfe3KS1H9Y1D1VlwUhyuxuOupZ6v49DfxnwLBS4UHa98MBIfYUZXBo0?=
 =?us-ascii?Q?vq8shIuGP2PokQcqfN9HBRkuAJ6ynHE3jMGObk+4l4Bu4rWWY/PocjYr7v/I?=
 =?us-ascii?Q?VslJi3uKd52snz9ONuSRE630TJ1mI3Wdlrc7uxC+VOwi6CSYgLlb74nittnF?=
 =?us-ascii?Q?sdukdpJi6zlSDAvJ5HWSrItMQbpziP8LGosgKpHEBeLGGMNg+VRILlUEwy/r?=
 =?us-ascii?Q?dTDqdnQhik0BPqa44jw/plsBfYE+bClpUqTewrTUK5O6/dwFjIdpr0cagBWd?=
 =?us-ascii?Q?zzPKwEkj503YBknBx7/Ky9ARBDdFT+LsLe75m/z3bZsVs9Gp/pTIZkuBLJEl?=
 =?us-ascii?Q?RYqNFFA+HEo400YNcGVXpvqH4GDR4L33/NPIsoC9st3B1QTz6+teajTv6Swd?=
 =?us-ascii?Q?AUmzmQXiJ2iiQjjv/937WKBAL2v3VHfgJ32SCR7jjER4ckqDyvob0ugvGHFM?=
 =?us-ascii?Q?vWcJeUESx9afXRu1wZQTh7oi7REDlGa/DeKqwRnrI2TqOq9LivgF6U99W5vX?=
 =?us-ascii?Q?in98P5Mnx+S1NWmS6O4bsshzqDGgw+5dkpuDt6BGudSJnzWj4yMUtt9wdyE+?=
 =?us-ascii?Q?VftRVixvf1WcWStNkqObG33jEC2+96q3fqQG4gDUtiHDuGM71EwkC8lTFoRP?=
 =?us-ascii?Q?CrXS//xcwmVFCNHs7KY+RCnz3DcgG7HLi8BzEJGcIit+w0rvR98U7teqEvNs?=
 =?us-ascii?Q?uFV9IV/UP+ydEyXAkR9iaLmv4+K2WTn3QRUXKQ/9OhiFflfh8rNSeoEx6vkD?=
 =?us-ascii?Q?bjUd0Dv0gUTaF/eFloVPuBrsQ3OLdRWCaijQVTWygm+KDLpCWXJCxoiLYhAZ?=
 =?us-ascii?Q?aPTpX88dPT37f/YWHCETfAiU4+txjqgxlyqQBEDYLwmobrT1bQgh3WgHGJjl?=
 =?us-ascii?Q?KC0wTNoziJQ6KPSYCV/AJP2KG7uIK7RsVmjmTk6CFYrZ0DhqdiMF3oeU7Flz?=
 =?us-ascii?Q?Kw8j8zDQmEy9a9j2ZRQbQtQHnzJrURKKGe6tIue6SeXlXg6l9CodSTc1O0d1?=
 =?us-ascii?Q?rh2luPsK8OUuE9uNi2A1Pxnk6F9AhgCkw++F9igjikkX9OxGYYci9ngNP9vo?=
 =?us-ascii?Q?8yKEAQc57VdO7J+hKmBSlCClGRamH3QRG4mGnjvPFvyoTJeQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa01a93-40f5-4a7d-036d-08de5784591e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 17:58:27.7199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjdcdLJDap8dKDnzlcgLLoovt4FfHDByE619iYR9w2btDgIT1oKQawAVzEZJSiSU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4182

On Fri, Jan 16, 2026 at 08:56:40PM -0800, Nicolin Chen wrote:
> Controlled by the IOMMU driver, ATS is usually enabled "on demand", when a
> device requests a translation service from its associated IOMMU HW running
> on the channel of a given PASID. This is working even when a device has no
> translation on its RID, i.e. RID is IOMMU bypassed.

I would add here that this is done to allow optimizing devices running
in IDENTITY translation as there is no point to using ATS to return
the same value as it already has.

> For instance, the CXL spec notes in "3.2.5.13 Memory Type on CXL.cache":
> "To source requests on CXL.cache, devices need to get the Host Physical
>  Address (HPA) from the Host by means of an ATS request on CXL.io."
> In other word, the CXL.cache capability relies on ATS. Otherwise, it won't
> have access to the host physical memory.
> 
> Introduce a new pci_ats_always_on() for IOMMU driver to scan a PCI device,
> to shift ATS policies between "on demand" and "always on".
> 
> Add the support for CXL.cache devices first. Non-CXL devices will be added
> in quirks.c file.
> 
> Suggested-by: Vikram Sethi <vsethi@nvidia.com>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/pci-ats.h       |  3 +++
>  include/uapi/linux/pci_regs.h |  5 ++++
>  drivers/pci/ats.c             | 44 +++++++++++++++++++++++++++++++++++
>  3 files changed, 52 insertions(+)

This implementation looks OK to me

Thanks,
Jason

