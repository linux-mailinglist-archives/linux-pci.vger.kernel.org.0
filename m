Return-Path: <linux-pci+bounces-20009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7C4A141E8
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 20:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0ED53A72DA
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 19:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9005D190477;
	Thu, 16 Jan 2025 19:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WlwUvBab"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E585D22A7FF;
	Thu, 16 Jan 2025 19:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737054084; cv=fail; b=QpnbZW8m1AaXBnq1AmnkwwMnxAAxgryvzdcJH/rQnpNiILIe5JQ46Cb85reT+Witneh6Be1nIeKqsW70NihvEw8RwPcRe276WFU2obpJV1JEng+VP9kp9HdE4d4xvLeFEMzaqFehksFQUmnK5TZ8QZcNlF7ZoqpWAlTh59tUYBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737054084; c=relaxed/simple;
	bh=FXWPclRptL5Bmu8raYvLa+k86gVuNHBeacOS8kigpP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ohybJWg+31/8Dnr46NJPkYSEaHEDLABHi/L4iF5ed9+frqplPnnprsmWS3h7fzDcdQrGsB2EVXdYAu6rXIuk9FpDHheA4rLKzW1MKa+2XvH/41jakUuhL6XJhhsdJVtYHBo/iAsLeOZpzQgKm10uAvwaOEpNXq5mY0Zm+/TfYuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WlwUvBab; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hUSAFrrlMmrxd6XdP0iL88mbObprZmUXHrpFGhQZsuiHUXJib7vSTEodq4VMIovuJ/Bok+yTQD83tgpGrfuJcJW8C7Nd6zMxK9VXHXbfNTfdOowXIy942Q9vDMsIBM/cvNiXiugT4eOSvgmsazWqwbZzP+3OVY5XrmXNRIzd74n3SaXwCq+97/sYovDI/nCtvJgyEJ1eWsSqihDNuKak+a/WJbpVZWGBfiTniSZNUv90I2qE6BwEDgA63aHGeWzshSdv95e/BimM2i85gTryY/VBc5wwt/shbSysibhJfIAd3gaOvGaSn4jY1C4l/RUKGgJ2WdPkrsAUCXM01pOJMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYVZk4CeR+KFbZa9K2MC6RzHIXLT/3CRbT7GefWV+Go=;
 b=UpIClvAzbAUt1IepYSMg45Pg+NMVZgLHsmbgXYdTyjIG3QkfA4xvCsavkpJpyNXpMtG9qVN2zWqxGPQr/2asUfJkK4xJmF75E8lJo59zM7Mgd+Hp4u/zy3svWButgH1DVAt6NZp3sG68gxQEgRaSVHHcfw/q7Mr5jjveebMvrAOQm7qsPV3EBryepAWQRW3Ezmpfu0PX0CUxBvHwjk+CA0PGk2si9ssOEDL5nPOIMXuOkRI7oi/moXYhxTuKi96kk8UoYlEULIAb9N0GeG4sUaSLIZdAq4izHT8Jrlfdsno0BcXB4e9sFXpFEx7CXcxVgv0o5zDAvJJCX0u01B1Y+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYVZk4CeR+KFbZa9K2MC6RzHIXLT/3CRbT7GefWV+Go=;
 b=WlwUvBabv1erT0k3XWUgEV8xt0f6OcYlFubqHeP/pIek1yMvjUCjzzsA+kYbRxUbAm389U203043DrZRB7Ea9Tqm32l8VFzT6XXGhjU2FiE7ZVKYB05Js/7n1rjAUAWMEE7t4Xr4HVF7AHqdFFgU5tk/yP/Dv5WqcQxytDgcdvmOUMbMkMV6sC6xBKRHkhdOm/1+d3yHPgMEFY4leAeiQlIK4WUevhSZZ1aB1/PS3xKoBqw/IG2fYfcTDZiNRY91dS5Qggf5KSjaf/6WefS0b43yj3Zf3uRYv+EYFPS0ILmZXLe8QUCqJHo/7ShVtv1ep0emDi565H6biUix87sLHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH0PR12MB8823.namprd12.prod.outlook.com (2603:10b6:510:28e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 19:01:20 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8335.017; Thu, 16 Jan 2025
 19:01:20 +0000
Date: Thu, 16 Jan 2025 15:01:18 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Tushar Dave <tdave@nvidia.com>
Cc: corbet@lwn.net, bhelgaas@google.com, paulmck@kernel.org,
	akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
	xiongwei.song@windriver.com, vidyas@nvidia.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com,
	sdonthineni@nvidia.com
Subject: Re: [PATCH 1/1] PCI: Fix Extend ACS configurability
Message-ID: <20250116190118.GW5556@nvidia.com>
References: <20241213202942.44585-1-tdave@nvidia.com>
 <20250102184009.GD5556@nvidia.com>
 <2676cf6e-d9eb-4a34-be5e-29824458f92f@nvidia.com>
 <20250107001015.GM5556@nvidia.com>
 <c9aeb7a0-5fef-49a5-9ebb-c0e7f3b0fd3e@nvidia.com>
 <20250108151021.GS5556@nvidia.com>
 <0ea48a2b-0b6d-49e2-b3f7-ab4deef90696@nvidia.com>
 <20250113200749.GW5556@nvidia.com>
 <6ea9260b-f9cd-4128-b424-11afe6579fdc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ea9260b-f9cd-4128-b424-11afe6579fdc@nvidia.com>
X-ClientProxiedBy: BN1PR10CA0024.namprd10.prod.outlook.com
 (2603:10b6:408:e0::29) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH0PR12MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: c0d97c2c-23e4-4c97-e01c-08dd3660299d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BqMCbr8ydjvr0JgAMLCYXU873WusxqTfiLVjgKeFD+RsUiqTAKa3echOmAMs?=
 =?us-ascii?Q?2Dov9cye/tsWsB6C1ppJsl6RwGjddZKw4rmkqVIBNVLLF/ehz69fbZ+XUyU0?=
 =?us-ascii?Q?GeXICOYXL+EurzSYjuuGUE9kga0LU+FHYUyDYscxHqLehHwSG+XLVGnxheen?=
 =?us-ascii?Q?OZ87lXBdVli1qWwrlN9lzmbGKllTii77ior2b6wg/X4neXeLujCP2eljCmfk?=
 =?us-ascii?Q?YTJibaeqL6Dd2fgvVYlWIbBnAL2hJ/+Dki4Xb0Azx2n37c+MKdUy6YDttSn3?=
 =?us-ascii?Q?zPPjUFBD99ZgorOLrbSBjCdn7+zJzzMam6Xda6TWtph2pnp0zNpUO+pQLmzo?=
 =?us-ascii?Q?3msC2Jw2eQDW8dzuNauCBP4qIifqKEpTAKRV+K54nzJuAu00EgAe5G7Ot+y7?=
 =?us-ascii?Q?qlz3+Ie4/91qGugSqTa0bFWAhLQe0cbG3x33WYMZmz0QxqVh5MxclXtvJ9v7?=
 =?us-ascii?Q?+OpY4UsPIeM2lgL7jwAVvwXHnXPalUAwsJIubE0zmALMuPxtpXepl7NDOGEj?=
 =?us-ascii?Q?TWM9ffMJrSQhmcph51Iw/7WbBNvvz/eQUJh2KNqIZUpuP8ICufXYP33U4+mM?=
 =?us-ascii?Q?O1tXN6k3fZcIFF4bI3mmiQ7SgjOqxT4O/3m7Z6+7mepy9AAsVcgn3ZYRywt0?=
 =?us-ascii?Q?fSFYbk6rcP5dEWEyyG3Ahpd95m0NgtxXYTTHKZ6YIRZdw4RbyuindbWrGW2h?=
 =?us-ascii?Q?dchpG8MPfoaV6tur4YvXSUIGDkilxbS/FzinkeeWK2y4H4MxQRTcXf0yXJ1L?=
 =?us-ascii?Q?ox/pXOSK5DKoPxfa71IuJDCR5ZRzIEonRfBlO1VqUeX24UrIeD/BmqbLUHmm?=
 =?us-ascii?Q?+TrTb8zTtdk3Nen1wD0xwC9toDB4aPX3HXB26I9JuxuzpV38j8Me/lXYnnsa?=
 =?us-ascii?Q?Umf9anTL6ciQhAextVO673c6SloanUGUv3EGR2bPAjgqtjF4kYv5gjSaUQn2?=
 =?us-ascii?Q?gbunkgdd0pUHn7GHp4oNbnwpjMZ4z2VR6Xp5oiYNrSqC+RfGYbRDf9Icoeh3?=
 =?us-ascii?Q?Ep7Xkt8XOHBRPwoyBMQjffRMasjOpAeBG+meMyQm0dugbiyYtwbD11mPa2Ux?=
 =?us-ascii?Q?P/yt8JSkVhtzPjIEdnHxMkZHhZeMaBVZ+Jdg6cbBmarvVhr6agvkRUikGaJq?=
 =?us-ascii?Q?k9MirA0r+nq4E2vZt7mawQkSgYpQleEHa+Bmfd8Kv5W1nruMJHzp60f9PSBl?=
 =?us-ascii?Q?oXN0nTXdbw9+/yCsX2FjzaMlPXV5Q6AVGBrYCWDeyCU+jjalSPOVKEuiEa+t?=
 =?us-ascii?Q?Upxa/J8RyWLBL3ygdNrmd+EzkRbnhQTVUyNIM161bPsgsoghIu1HkPdM3JHc?=
 =?us-ascii?Q?9FwnUhlX3ulSghJyOgudE/MKiLsPhb1y0brZLyZeePrRf8qOanZXy9aV02JW?=
 =?us-ascii?Q?i/dE6gJNdtak4iKU62yJ1JlcEheb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ylm3dqN2lnz48RLizai7W4tUxlCF5l0Cnj9SkPU93bemC1/+/83K4PrNkg0j?=
 =?us-ascii?Q?Dh5pJFOalITmRYvseyGViyfWOtX8RQCbN8daZuqs6pIFGjs9fzp9GStcrbex?=
 =?us-ascii?Q?K2HKvGYrDTPjdzu1SLy8UmPVj8riM4FYuXriQRkTa0HH5F7LRn8cdDXHMDzq?=
 =?us-ascii?Q?yxzuwjuy9uF/Yep57QdS9/ZMpEAEljyC5KMdL5pfu+QufrNj1A3npByfrt+4?=
 =?us-ascii?Q?LBOrEt5lzSma6ukIzY4QSHM5T8rY8x0n7lqeB+p/kDJhP0cAW7NjXvUmfrtH?=
 =?us-ascii?Q?Y7q5VhEA538SlHd+l5O6uXCTKHUJTvb9J3XOFoDV/Q5vz8Q8WAIhdHnr8I+r?=
 =?us-ascii?Q?UyTLJJ6WMFGGkG//gweLKfxGVCLpc4+3FbQt3nez5a1k/OGpNUg4k9mvfJ6m?=
 =?us-ascii?Q?UiGSYmclTTO2+xye/qt9jvHnav8zJAevT0X0oy0g1a3UNv/VSHKQF9DUgAsb?=
 =?us-ascii?Q?jFOEyv9fRG1WQmDVqA+NCLvc59H6cfPF7BsC6Px8zQOsr2DAMlS31bevHd9F?=
 =?us-ascii?Q?o0DjtPqchDhDBL8SgUZNdQ1qLrhNKzGqJbYDSVHR4Sq550qOPKn2v94RgamV?=
 =?us-ascii?Q?GHfGrNYpx8m6LAVhM2XNESOJHho32CnjfzqUxZ01rCedm0JEAwUuzSTqHb66?=
 =?us-ascii?Q?Oxwg8uD7GhmH6+qeHD99R2ALFeAqdCNkC+gIOULZKCbCJRj18pVrM28GF56n?=
 =?us-ascii?Q?SLuvkmzXFrwWEe8KnPhYDyiirjri0Ehqs4gLcq8DUSRykGUmctwy5PAOmWWT?=
 =?us-ascii?Q?QQ4XfhCbCyh8OO9gK9hkSxn8v/Abu7VxlHo/A6xsNLbxy4/zbWSUgovEcJsi?=
 =?us-ascii?Q?4vwubN5d/DIAe9OryVdzYhn7P1n1xnkS0pqOu40HN14Wu2E7dLvuSaY70VWX?=
 =?us-ascii?Q?SJX/6WRXu3AwcH3Tm6SWOM0aBD4SaeTjkow/YGkD0d5NraiGB0QLd5ZqLIdI?=
 =?us-ascii?Q?1vxwZTWnYELV07TUjxEQhMW80pv3X1wmjPfToYqiupjCeNE2RqCpJzLye1ko?=
 =?us-ascii?Q?6aRaOOTwnHyG5E0oBeJelCsilHKttztsxXBOBas5HHjpzGoplpRKpq+S+F0S?=
 =?us-ascii?Q?9A/XyynX/nmt2x0q23qLidn+nXWc8Ar3X4SVUUnzdD+OhStZQUE7EZuMq99z?=
 =?us-ascii?Q?kcAfFPp/gWClSBqKPiszah9ZJaicQUAoW5iDLp2SKSmkrm8ysxW7a/TsLR79?=
 =?us-ascii?Q?ILZ7rslP/DZGwrB3wPK9sUj4hCZrjFSHawVE1+XcDxEqCEzrYOavNsknXj/u?=
 =?us-ascii?Q?YMdzfNLbwBpvrWvl9reCgEX5DFWPp5HWwRzB9hzMMYwOFhGkvH4zNGPZVHdC?=
 =?us-ascii?Q?KimMF2BguRwJsH/q0SHTZoDnlP/6Vo+Cp/IpWIsbRj8i/IAfXCkK0HseG4ev?=
 =?us-ascii?Q?cLlSPKX1M5PAQVpfKMVCikhVJ9My7hfR0f1ZV8EUmS6Q3Citt/2yF6/6M8uw?=
 =?us-ascii?Q?mpQICT9BrLVqpCuiE5sw1CRpSjU3vhMbvV3FnE+skX8QublMxOmxFr9fvnXE?=
 =?us-ascii?Q?pl5xZOC58Q20AUuurWiEbjMEl/ou7Bb3f4HsGwWaSIRmOCdTac9RHCW5j8IC?=
 =?us-ascii?Q?AR8vnP4vELZMFxdk4KXktrccNGCkug2DzSKR/XhV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d97c2c-23e4-4c97-e01c-08dd3660299d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 19:01:20.1641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tw4DwLGSOnTlYUmGMpcB+OEgkODHcKM1atj4iFSzmO1lxE9fWS4ji1yFH0BxxFUA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8823

On Wed, Jan 15, 2025 at 07:11:25PM -0800, Tushar Dave wrote:
> @@ -1028,10 +1032,15 @@ static void __pci_config_acs(struct pci_dev *dev,
> struct pci_acs *caps,
> 
>         pci_dbg(dev, "ACS mask  = %#06x\n", mask);
>         pci_dbg(dev, "ACS flags = %#06x\n", flags);
> +       pci_dbg(dev, "ACS control = %#06x\n", caps->ctrl);
> +       pci_dbg(dev, "ACS fw_ctrl = %#06x\n", caps->fw_ctrl);
> 
>         /* If mask is 0 then we copy the bit from the firmware setting. */
> -       caps->ctrl = (caps->ctrl & ~mask) | (caps->fw_ctrl & mask);
> -       caps->ctrl |= flags;
> +       caps->ctrl = (caps->ctrl & mask) | (caps->fw_ctrl & ~mask);
> +
> +       /* Apply the flags */
> +       caps->ctrl &= ~mask;
> +       caps->ctrl |= (flags & mask);

caps->ctrl = (caps->ctrl & mask) & ~mask == 0 - so this is kind of confusing.

What we want is to take the fw_ctl for all bits where mask is 0 and
take flags for all bits where it is 1?

  caps->ctrl = (caps->fw_ctrl & ~mask) | (flags & mask);

?

Jason

