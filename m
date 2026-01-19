Return-Path: <linux-pci+bounces-45198-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3BFD3B51C
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 19:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F2FA30695CC
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 18:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5D8339857;
	Mon, 19 Jan 2026 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DkzaorZo"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010059.outbound.protection.outlook.com [52.101.193.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031F82C21DD;
	Mon, 19 Jan 2026 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768845631; cv=fail; b=O0R1WOlxph5uxuaL4vA4VaNp92CJdtsfW+YawfG2UXRBS+dfu992nPwM60KImxyJKDlFG5EKpKFdGBSHOVoDD62au8+VcMV3O/JXygO/dHm5zCCF4s31cZeNFAodc1EoL33iDL3rw8H6tRd3YEotKOFpUqbJghVuUYmKYfUFaC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768845631; c=relaxed/simple;
	bh=wdfDZYI3FX08ejwaUOGlTfmjfLibKjvsIEWmikFU8RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dEbnwawUC+junpPjRa2b/pEBQ0B0TEmRjRkWo+Atk66lsb56HfJZUAJgUSme6KrVW9VQrT5AQeQFJUa9Ju0AZBdrm/dtmzdq74nCRXBCFQ+YKHsbl8gIza2WQS3AWyG/LRFg7v7THo+KXyeRqIoCIkVPuTv6UiWlQLg0KgFDFIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DkzaorZo; arc=fail smtp.client-ip=52.101.193.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lv6ufgEpOG4bozB/ZNFucRJQ6HQ/bysDiZSzVWJ6QvKLFHsc1Fg6IIUsGBVRJxyXJljQfI1ZMjvlyojCcLGLDA6RDCDOgmlCPfv53oeXddJFSCOh5nQCv1OgLVwFnENwLQ3hu/dcbsh+HJwF4pENFFSjvN7aUxQXwN0z/nA+p/FwzXq3dB8wwng09W7ptUu4LxkrpghaL3a7OaUtsGakdlNGw79MJkeGCkQbaB2BmLlgr4FvgxTzQQs78cEDnfdmJvMQ2uB+kfE1wzUbzC8jJKKXmYXeGGmclshQXysRly8XGEa77a6DDJIAFJMbgmTTmAtr8519CvB03dbWDcPfvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdfDZYI3FX08ejwaUOGlTfmjfLibKjvsIEWmikFU8RU=;
 b=l9QnNCq0IjuZEWP1OjcQ9/gffVhtCnkcPvIGW77xn1IZhWKSKnyPsO8yg7Q5HUlmiECqw2XGjdyzaId52qhWAXL/6vQJsXWOB/4BupjKNBsipv/eM1goyNnrrAvDQE6qw2h6GGw5XCq4l5uiD0Cwn+gLMFQEGqfuTwZezUlHA+/q2qHKahOq0rug2vhKpZWSa9P30xP3/bDZdjObbw3HhKcIwIXDMO+y0HVzQcaF+k98TS4r0fKsl5waV8V0iLPz3VYQ96azxKZQ8KtReW26AQzUCDzR42BF2iSqXLC6pu3W8R/QxYIn/BGkZvTia9HRNmJF5EnopnF1nJbugbKUZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdfDZYI3FX08ejwaUOGlTfmjfLibKjvsIEWmikFU8RU=;
 b=DkzaorZo+9ej7NHnL1jlTEuzrpulGzbQaf2mWnYpiPZqpMqgV5qSpdi/14RhcIHDr4BfbrQkXmJMypF+bcoish29HchDbmZDUAFAa3eOCPAaw1NyZRkI9EvBZTNeKb5890FDUXrw4aaj1RM6bvRzGf9iHi4XwHoI9jvLE2E4hZpW5fh51YajLLNw/gD1f2LhfVN7uo/WFV1lV2iLZNOup0YCWx9sU39L3FmGOKYruPjUOxuC3ljek7BO8cgbNgzFbpnXtvsZccgsuVyBy0DHgw14lqOCRh6jxIeGb8EBX0qInYbP9GFxU5ehK9DNe96mlK4EA/+3R04XRHUN/kDctA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH2PR12MB4182.namprd12.prod.outlook.com (2603:10b6:610:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 18:00:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 18:00:27 +0000
Date: Mon, 19 Jan 2026 14:00:26 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
	joro@8bytes.org, praan@google.com, baolu.lu@linux.intel.com,
	kevin.tian@intel.com, miko.lenczewski@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH RFCv1 2/3] PCI: Allow ATS to be always on for non-CXL
 NVIDIA GPUs
Message-ID: <20260119180026.GN1134360@nvidia.com>
References: <cover.1768624180.git.nicolinc@nvidia.com>
 <61388f3f7d660994fa03e77bd37aa84b6c5fa3b8.1768624181.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61388f3f7d660994fa03e77bd37aa84b6c5fa3b8.1768624181.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR11CA0023.namprd11.prod.outlook.com
 (2603:10b6:208:23b::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH2PR12MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: affc7685-9fb9-4a26-818c-08de5784a081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qJ84Qod9AGjAqHpYxjVmv6DirZRR5OtP6lJmP1M3spuhaiNeh514Q0d7QD/5?=
 =?us-ascii?Q?X/dGwYE0N6wKkgSKQIA9jxWg0yuVxXi/lphPr6+J4AVGiYtCg63vUWK1HjCl?=
 =?us-ascii?Q?9xazhMBvhLTeqg4idgTftN7Lc2yhmlZNCabP345GW+zPa9eJEE7xAsD1YG/L?=
 =?us-ascii?Q?gjX9Z7LdHrNgP6ox9X8fsfc4MgUOCeATqbgztobhxHIv6hFMVd8MTN0AmX+B?=
 =?us-ascii?Q?p1wKSAF+k/eEyNu2VVlGDffIy8ZUa5yrtc3qpSwDF5fjgDUJuT8K6mSKm2EX?=
 =?us-ascii?Q?d0vEDEzFraxzN5521pZO5kOBrhBYiL1yJl0bNf57Z7qNbXzRnOJxTNOd+RlZ?=
 =?us-ascii?Q?1ZgvkSHrosB7SAN6eKx3ywCirLQVAdo43DrAEGfSFkPwKKz9h4NbZjF14T7Z?=
 =?us-ascii?Q?NfXGByXYYCtUYscRLHefpbhmYpRPAurglY57gdvo7iI0jC55bjzCGq41SaNd?=
 =?us-ascii?Q?4HcGXfVTEuGTeoMH7gJ4e6FyGmTWVvJW3ERMtYga3Yo5ECuRBE8joM3KnO19?=
 =?us-ascii?Q?oClCEBhYQHTl8lFi9FCtHXLzEOPOWrPVWQTBmyqX0gSiSnPZNzvlqiZ2hfga?=
 =?us-ascii?Q?Y3r85wyZNNMLHRrQ+8Tz7vJ/qUHH+661ndCZc17uOmKVabRwI7oRKP2+TwoP?=
 =?us-ascii?Q?rDV6zzLKoCrqbS1y0mdxOJCt86UAVKfACwIbNlrTknZnuR2hS7nRm1BgAnxL?=
 =?us-ascii?Q?A6kj9c8uvqgXAqtfaDaokQ5eX8k0nh/RMDOFK6RhFoM6/xmtBAYa/AqE+e1m?=
 =?us-ascii?Q?D+XRQiSctLb0cSST6lfuhS82+oh7Fh+I+bN7fClT0KfM44MIgqUc/frX5Zoh?=
 =?us-ascii?Q?Apa1FO6nRiQtpC3GBOhJmfIi4IBRB7T+FcwsJCrcHKMrgg1Tt7CLtzQhq856?=
 =?us-ascii?Q?wYKdbtN9t6Ako+XRiduOt0u2q+1BJ2wk9GE25vLYh3uKlpskhjxVNAGVARpY?=
 =?us-ascii?Q?8JGwLrjt5gwLVbSnaug4VjIM5MSPlK7itX5W6qaCY8snL2vCszmgZ4qpRysp?=
 =?us-ascii?Q?Tl20Xkk1qwcmmHeTCxlWfNp7l2IhuSvbimuSPtR99ZIug1K1CGpJ7Q+b3XJJ?=
 =?us-ascii?Q?SC4iwv/5rxYi1bUn/+HLer+bCmSP+o7l8Ts9KaGbNHcm9nqtghzbP2tqoPlU?=
 =?us-ascii?Q?JWEef5T9uE+6OMoV5Ht41gUX90oFP1Zal0zF8qpyzjklnw/X7GkUDV/K4yO3?=
 =?us-ascii?Q?Y7SoO8GPrG0ueb1uaqApAgWkkIOGTR+/iNszdgtF6D7smvj+3jeXI1iwCi+5?=
 =?us-ascii?Q?HiE2i4XwIByyvMKBMt8VdEGq6H5lnNtRUZFh2tm9S3brDTkkpZeP66dJ9zOs?=
 =?us-ascii?Q?sFCHqz4jR2rD7ImWizmSwh3lndTwrhnEu0pIXyUPkERXYrBT5SE2tTWHzLUc?=
 =?us-ascii?Q?j6tpe6bfY98Qhqbc33onmXIpE/te6N2Ydl2Mexi8MQr5EFWDYPza+nGVvLj+?=
 =?us-ascii?Q?Wx/WotBS8UYGkhzd5zrbMQJozMZkSOTWS6VyY3glEx0rFOyEiNX1aKzJVDWM?=
 =?us-ascii?Q?IWsmceFJpJdst8aOqPVFnOJoboqX1/Z95Pc/3GWrUURN0e2MgXccmdHQfbPd?=
 =?us-ascii?Q?n19ZTkgQg9aRdJnmK20=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DDPOOw1YlEd2TRLOlRfBE+Fa7QdTZN3JSL6CmF/JK91w5AO1ON6229ermKXQ?=
 =?us-ascii?Q?hUgzi+5EY69c3OAgMyTl7gKOQ/KVqf37Bn9rUIEqUdCS3KvxL+hWCGggHf2C?=
 =?us-ascii?Q?Rxo3nWsPoqSA6dlZULfH/sHM3OsdlMKC9r9sBWkTRTOj9JjLNLA+E9WkXk1c?=
 =?us-ascii?Q?sqVgYFWW5BfhOESN6SbUDkq2zIyik+nfLX+hLGk6qyVC3z2NMDpdUPMnVpyi?=
 =?us-ascii?Q?Ddp9ikRXi5rU8sDuqtGaoXqLBwm2TUeds7ACtxplDAFtGgf05MqkqVl1KHde?=
 =?us-ascii?Q?pc/r0YM30lSsOuhr6NOoPXmZMAWtVnHJbcDjYR9wQRPkrgexRnw21yFn7jC1?=
 =?us-ascii?Q?nI4A0H+VqrQf720xXRuGlu9Ez67jszuDYMJJOOurK9CsKkGwU4xCbzlafY7u?=
 =?us-ascii?Q?2DAywHOVUcdNTkjRedq+F1C07BwXDKPyzjfSkOWK/tXWjiEpTE92BUs3SgjT?=
 =?us-ascii?Q?qbUTnU0g+hjAayXX5PCto+K4A5dx3KAxmo++ixy3PeUGvdlG1fHooqrJv1q0?=
 =?us-ascii?Q?0eq3iJ1phZEREl1hVwix7nCoABYSb8RJI1lzI055D1nAWjCKKIB+TRR+kyG+?=
 =?us-ascii?Q?MPDXJvQCzoBhrh5uXzKTevD7LiumNkh5aIFf0n4a60JH0ip7JTwJruluDwAj?=
 =?us-ascii?Q?IVG0cF8acsd/HHadIVPN5IApbIAGQK/uoZe1KLATHsUC+o9Vub/F+D4cXuC9?=
 =?us-ascii?Q?fiSfe3vxfs+LjjLV+c65tf6Y98Q5qH+Jkri+FaI0t8Y3vutUo309JnU//zGT?=
 =?us-ascii?Q?Aig1uGdofNZOTMDpPStyPE+0+bsH0U4q44TVtj5J0yn/h/h4MOIcFdl913um?=
 =?us-ascii?Q?cMMkkeO3bDpxAeJ78IrznixEuurZjDtfLAkb8baqdQoKK9UGwveXjew8ylIh?=
 =?us-ascii?Q?W/l69Ddj/3+4L/18mENk3b7/jp4fxs6V0qU5g8cTHbesFAvspZ0jQlZFcuF2?=
 =?us-ascii?Q?SaPc3vQckLxHhRqoSyhnXH9tYo1pChKMMBEowBzuNW3kaC9ul8N+XqO9YnMP?=
 =?us-ascii?Q?tImj9l2Y/vt8e0CW33OJmiiegoum+M9uOXerMIqtbzGeUfSrd8op5qHGZT6x?=
 =?us-ascii?Q?DJGUf6xeudC4rxmxn0PuUVG4t3uKbgBPg3j8WBO2Ip+D03e1cWH03YgCHhhq?=
 =?us-ascii?Q?dfZxHwWaEcPkfu2bV7xz+p07RfUAmulp3u5MUkfu2bHJolUh73UaIT/dgt+h?=
 =?us-ascii?Q?+Iw5oicJZ1Ruyweg58o8kOz2AX2FlSdGSnr4e7AUVNSU59MUNjZwelORJbZy?=
 =?us-ascii?Q?CiR+hyJWVtTS/U4+aNzXCbutORquyMoD88UUFxqHtTMs7WWeGb2BbmKos+WA?=
 =?us-ascii?Q?fKibgpGXiuf8zBCO4WJ1YKCzg0zkPrOt9RxywpKF6K5EVPgQBH10oR5tfiCt?=
 =?us-ascii?Q?Filct9Fdt0gnwxzYCcOO/NJm8V05CtHnCpks5Gl9ZMBH+cO3nzy9qKsq+pHZ?=
 =?us-ascii?Q?c8bhtUMRTCFS6LDxNItFLIS+WteD//6Z2rkskiVtDs0EcM6tMFVhAQZmthz5?=
 =?us-ascii?Q?Zeupgh1evzORJKI5q8GwseSu9n3Zvl3ahRUFUlROQVHnu9zEAvY0Tvu1M+TX?=
 =?us-ascii?Q?xEpLslexQuW+HyMZaYL6llGoz7gCjXcGZCLHTgBnKIfj3ueZ7s2Isv1rRwvu?=
 =?us-ascii?Q?H5a2EywKb9nCUanDAwHm+apbCIMNyI4K93ZJRiE2CNfuUG12/JkCti1BAtWA?=
 =?us-ascii?Q?jtd12wEDiF6c9S2T7syA9qyrlsB/UM++ybGoaj6/VrlhWrhSLwLKkG37aEMb?=
 =?us-ascii?Q?qE0qeR7tuw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: affc7685-9fb9-4a26-818c-08de5784a081
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:00:27.4908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGfqRg8QDp9IS1rXahSGSUaoR7AJcE1tt2LJbJlAPhuYJ00Rw7b4dMlzwI2AlpYn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4182

On Fri, Jan 16, 2026 at 08:56:41PM -0800, Nicolin Chen wrote:
> Some non-CXL NVIDIA GPU devices support non-PASID ATS function when their
> RIDs are IOMMU bypassed. This is slightly different than the default ATS
> policy which would only enable ATS on demand: when a non-zero PASID line
> is enabled in SVA use cases.

Not support, require non-PASID ATS.

I've been describing these devices as pre-CXL, in that they have many
CXL like properties, including what motivated the prior patch, but do
not implement the CXL config space.

> +/* Some non-CXL devices support ATS on RID when it is IOMMU-bypassed */

Require not support

This also looks OK to me

Jason

