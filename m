Return-Path: <linux-pci+bounces-34455-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E94D1B2F9C9
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 15:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8ED1897D2E
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 13:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513B8321F2A;
	Thu, 21 Aug 2025 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pxw4xOvL"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3D32DA76E;
	Thu, 21 Aug 2025 13:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781671; cv=fail; b=S34iOARIL7xYlRRjCSjrHHE1egj8IHiTcs/Ft6cRO7p7xPT/MX+avQzM7tLqtH9FU7xh4DRdcQRmXW3IGWBwgcF2mTU2m/2LgGjULu20fLPtBJyy7wIrscnLzhzK1Mg7jvZdPgygv6SEhUjjNA0CJOznaX5b0jxzvIaiJeir4/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781671; c=relaxed/simple;
	bh=VeQjrre71LUL3UkMO/HfwcPw8U421EXBu/LxslV7Q+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jnzfg1zmqw5sgN7QBYegtWj2p4jv7ohdkiVlyIEfsX5qMsZA+OVpal8TgCiP6OmwXaDma8YjdF65slgficazDHP3fkPDuFVxSri3GWN5FkTJZP9+gBTPYQXGyKDmU840lWjvZUzom6tOZq7mCT8os+BcpBOeAAX/conhZrtVFlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Pxw4xOvL; arc=fail smtp.client-ip=40.107.96.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fi9D/Y2usxGoOLX4WK3MlN7/gaC4s11mXsKZ7j4ftsi18uu4C9X+WJNTfgXtiON1GLHlMCYoQ/O2v+BlAAeB0W+DNRfaAr7TG1CE77+3HBVZJE4VLCHPSB+KlcjyhYFfGpG3LoYiAyIy4GlzaBP5g5H1728T2rDIZcRMF3ubxfY7JT/OMjQNyoNKrAb5LlWe/hmnHG7bqse1YwsJh83vsRpuHrEUpitJAvP8eV+OUaGR60U+Sy9ZI+7y5xC7VMQhZxxCuDav5jc7L5/SC0N/U4k9whWYcWfFpArn0IDH6fJ6q4zCo9m+x9ElBIjz0grrSJpw+2xMlnnME3GPk+oOUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWMYkjtDw3K8m2LYn07A7Ejsx/lWKVU0omqfaCp9OEQ=;
 b=N18Aypof0DNToq1zrlXXPjgpybAX7TBQHXUBjO5oiQzvWWTAMtFKgWM9fbayv/Ysc/niwmE96C3NYirZtguNO+o6N/gy8WcNhFaFRbzwaJtxGEAttbfiTGbUAF59ADhOMlotmQkxdrCNiP8f3/G0C9AzeyFucm9170uS6kBRK7T7T9/Ev38KumYLYCHVB2RIacEQOpgORaPUIcTBtFGxkGseooD1c7JdWzxlikGNyNgp6BcEXMusL79nA9QKJrvXm3coko/88Bfc4H+JmFbBDUkuuhn6mvaF87ttF+BfjrtSacceF4PEWEfY4gqnZzLw+qc8GepueCtxeN6iS2hnNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWMYkjtDw3K8m2LYn07A7Ejsx/lWKVU0omqfaCp9OEQ=;
 b=Pxw4xOvLy5bg3GDrjgS9lEkuiI36lF0RS4eAvwaL2cH/R7UgqZEUdgHlhLr1HZcIGuv9JEJ0EhwKQVQ6+9p4ICTTCCi0J3qznTllPmfQS6fImKlP9fKCwVTjkLkmvVHUdXNGawoI/95uSvQFckCAKMw15xJUNUvgA9rBXygmaHQdtR8njyu9+J4TR2XKfjA1raNS3vVyTCAvz10IfwsYcL7h0ioFYwMaTeicOMAcC2tIGs7CG6pUTW8r0Q5RxdvJqzwRURzvFgmyWZuJHRtK+QjmQ6a532KH3vi+t5uzQQFdt0CIhj5hQ+eBWIr8n4oozH/EKujzIwd11HuaFQbTHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB8191.namprd12.prod.outlook.com (2603:10b6:208:3f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 13:07:45 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9031.024; Thu, 21 Aug 2025
 13:07:43 +0000
Date: Thu, 21 Aug 2025 10:07:41 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Ethan Zhao <etzhao1900@gmail.com>, robin.murphy@arm.com,
	joro@8bytes.org, bhelgaas@google.com, will@kernel.org,
	robin.clark@oss.qualcomm.com, yong.wu@mediatek.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	rafael@kernel.org, lenb@kernel.org, kevin.tian@intel.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	patches@lists.linux.dev, pjaroszynski@nvidia.com, vsethi@nvidia.com,
	helgaas@kernel.org
Subject: Re: [PATCH v3 5/5] pci: Suspend iommu function prior to resetting a
 device
Message-ID: <20250821130741.GL802098@nvidia.com>
References: <cover.1754952762.git.nicolinc@nvidia.com>
 <3749cd6a1430ac36d1af1fadaa4d90ceffef9c62.1754952762.git.nicolinc@nvidia.com>
 <550635db-00ce-410e-add0-77c1a75adb11@gmail.com>
 <aKTzq6SLGB22Xq5b@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKTzq6SLGB22Xq5b@Asurada-Nvidia>
X-ClientProxiedBy: SJ0PR05CA0178.namprd05.prod.outlook.com
 (2603:10b6:a03:339::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: 6840f9d1-da1c-43f7-5ac1-08dde0b3b761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vROU9jV2HL5poXDV0cH7YNHOAwxF9UjqSLkAN/zUVIya+FpfhP1dlvP9dFsa?=
 =?us-ascii?Q?07WNEaICAbuvTXrATtYH7XWhgxm4k7uDHmWmN6IG37I1Q05N3nwxs550s52j?=
 =?us-ascii?Q?SDOB+Z5wGxVHdbo/4+CdmR1nsgaRlqpN6tuAMIJeuCoPQg3FmXrjfO9LlO/6?=
 =?us-ascii?Q?b5MhKfS3jxLB0VwuqyWfWJGfVjsMj4GCL9aUp+8Gv44awg1j7lqIR/tsF+F8?=
 =?us-ascii?Q?lGJSDVT/R4N09ut57Ne/EI9KSwsq1vliJntILQCSSHOOtZLSQwIGm/O/xIqS?=
 =?us-ascii?Q?/dPTdPIhzTO2oEXH2HP/GzrEWjf1oiSgrGLuY55SMEmMD3EpKW1sjgJoACui?=
 =?us-ascii?Q?nrVKm7MeSO3vXuhF0ro/Y43HVT6widPDcYG27pIG3kVUjJJbbJpmcolOIVYJ?=
 =?us-ascii?Q?fpyK5yZeHGfPI/ZdU/Nt67Ci8Jky94Oz2h6afjDDFVBJWO80bAKMbzVQ9UZK?=
 =?us-ascii?Q?maSpukFU2UZEdp8MZzOtL1WVDfeeTWSfPjGroLxK4F2qtxlewVSoBZlBXm6p?=
 =?us-ascii?Q?PPsnN8yaX8bkcB1n/EcFzRuT6lN6r+rOwfwVV07AEA3mKXIkJrrvpXPtsgb1?=
 =?us-ascii?Q?Zln4Tw7VoU8klJP1Wk4DZUd7XifFVBvOItfD2qBERm9grUshIH7Mx1gmyNkV?=
 =?us-ascii?Q?aboM/B26AEWZB1Zp47WGP4bMwBZ3QpVPlcly0XBaFnS/jlujKn5n3YNJkESO?=
 =?us-ascii?Q?RQwh5CLh2RbWQV4cgkwL2TS9VMo2UU6tREht5MMKjA5pzOsC1eYpjtOsPRaV?=
 =?us-ascii?Q?8rgDInogw8AjVGvuo6Ayz8ldmaZODO7ylMMtiEi6vXAR8rC6Vl0lSNVORzrn?=
 =?us-ascii?Q?5hX0+f564ak77F8UoqY7f/HKWqw1qeBKNzyBnKIkEDPFmefQZyQWyp643eHp?=
 =?us-ascii?Q?FAxeznlTKH8UAdPd1VB/KfMWRtvRmn++EiHzHHIwf2OCM6s7276e0S5xqEi2?=
 =?us-ascii?Q?c+i9v0R7zn/MMe4Fbnn2opcHHputkikOK5Khv20Uthwg0anDUfERNIg4ZQsH?=
 =?us-ascii?Q?ShFJtLiQZbJG+SnmQO2PPOdBC4fvfUVLIG1EhysJKkwpORgL+hVG2Sugfzrr?=
 =?us-ascii?Q?leoJPZMtvum6pgf3UakNKDr1WnJazoZI2ZadbQCPnWy3Lw6sDs2OD3VI+8vy?=
 =?us-ascii?Q?nJDhGaPQUnMs2FLBV0QUWdWoxf1E4gkcytROIxwy2UPRnmqAD+meVMTYbnCY?=
 =?us-ascii?Q?rirDz01v3HMRAuN2WHJJNWZTxwFJEwfgs/QqcESS/mIvqjMEJCxMX9imzHb+?=
 =?us-ascii?Q?GN4CYiuZ5WTfA2476HzXnMalv5yCVfa6IjWIQ9JxcfSGyaH64eVLW9OmwdGR?=
 =?us-ascii?Q?EL1hLvJNVuJ46x0gxPdr8PWq8wUYU1lOM5wHUF6/U0d5e2WTHh/fvial9jFO?=
 =?us-ascii?Q?tthr+R0mJDOhbE76+woUkOmMsXht2E0vmd9l3cHEcifN8TsNfKS7qpQaZ0bj?=
 =?us-ascii?Q?gR0HkcvIjwY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eqeD9lxcWqHis5hh+Y1/SFiVT8CbkVDVyV9IMZuvE5aenm6w4f+ecVh8Woaj?=
 =?us-ascii?Q?JpJN91FImSEhXcSWRGQX1s//288clAZ+6nka9Vf46IavDWuuGVDRnzP70uOa?=
 =?us-ascii?Q?pIXacJnyln0H6/oFJSxSH0kojfSTLiFST7zghd3huH4jhf+iDZXvksFdLg2w?=
 =?us-ascii?Q?HUHL6NXMxdnntud5T6Ge+d7FyC8oOWnnOyIXVNrqYq4fPt1vlbXxugi7zAuc?=
 =?us-ascii?Q?OPxBv3HsEy6OH1eOjCuHNQj6NDxCvAnvB39EbNIfLYIa0P8KAlhytpc4p9TS?=
 =?us-ascii?Q?oiN4pJBP18V5WgZ9N1vy69ts/3KBy/JRgCCd9V+KZG0Kk1A9O2bHjqyJsGTs?=
 =?us-ascii?Q?d4iphXFoBH6yrqfYg6ziecvCG19ErecH1aABcCPS4ZC4VY+r9N8zeXi1Upge?=
 =?us-ascii?Q?aA7OpEhkGrzUDv46U5WrG50BpFeajBIFMZPC1AA9GAsGyiXj5Rt7V5zqY5uS?=
 =?us-ascii?Q?dDxDvIsBG+zVkXQJPhiDJk4iAw3uhnal86+28s7U8DHFSPeUVzsKQqBtm5xW?=
 =?us-ascii?Q?/geNqMLBOPItEUPsisVzWOHBX2qQyaQ7ofGHS9jwlOqWb9NwsFYfi21SvSby?=
 =?us-ascii?Q?I/ndnuNwvMYjD9npHS1PmcWcKgcupRs02VTpjYSTr+vXFny7aH1nKXTJQpvJ?=
 =?us-ascii?Q?DGz753wGpvRCJO8w5V0qEHT4rtjZre4MogcS4cdjGotmQT2hSo+1Sqp+PqDT?=
 =?us-ascii?Q?fc/SoZ8cb7YSiuieRF7KJlnVhNzA6tKIteQ4XFJnImkVuMKa17sB+MC41NRa?=
 =?us-ascii?Q?84HvMs8xDY0OKZETfgZb7yIHfwPJ8jUuIGmfk4F6SRaDMA2yqPb5tgdHH7y2?=
 =?us-ascii?Q?uHtlAz+n5dL7Py3ngNBwV75E5F2zcQGEeu0YKD587yj8tP8/Sj7EBWNjAT/q?=
 =?us-ascii?Q?7zqbGJgS7NB/wgz0Q7MS/9WLol7KxThqeftdz9xQPgiEIvQYMv7JnRg2YOKK?=
 =?us-ascii?Q?Qw9DEvhnH8Wp8yTkDKROKkHQmhlShs19TbHqiqPPkVb5MpqeEE8G92WULuZM?=
 =?us-ascii?Q?zbVsOC7nk2oCyFMM0J54pVH6oO56jPt6RRup+Mt6wpt44luwAJQhpIvt2h3p?=
 =?us-ascii?Q?uL4k/7QvX9QYYZE4n9DQcsR2m2APu1IpvSgiIxjrZ2srZgRYLt7Tz2TLe7cW?=
 =?us-ascii?Q?+uNy5GGDEirIBMT81zZy/P0NDiHIcnkiLZ0I5S8aO1dJs+xAFbNgR4kafImU?=
 =?us-ascii?Q?yNUs2YXBTOuIZKU0SjSikVG+qVfe9m75YLEkHy7M3pzCcV9AUA4xODx9sHa8?=
 =?us-ascii?Q?ewyPDUqQatfj+CBZvl+Vmf7X9mNUU05MKL4FHEetPHh5Qjk9DwwtS8efU/lT?=
 =?us-ascii?Q?bL66IiEgdsBf6kj4l3/ZThE+Pqp0W+83b3y9CrdCDNnIHV92j3XN9YYH+6IN?=
 =?us-ascii?Q?LGKro6G+RhSoOF8DZvynUWS5lfE2uAT6Pil1yIkm28/asrpktCy4Jhzn7wAQ?=
 =?us-ascii?Q?eCO6V4zJ2rYfQkYPf1+d76JYoTYjszxcj6UqwLP+sjQzXS0/911o2QJP3tuU?=
 =?us-ascii?Q?beqgI9VZ+rSnqH03VUmbXLo/IbGbB5fpw6Jh8/8Ii8K1GiRc8hlh4ZlXYffL?=
 =?us-ascii?Q?HDF7OUqKBOHrlzzh2+U8RMQ75UWel8o3LEBF27Ii?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6840f9d1-da1c-43f7-5ac1-08dde0b3b761
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:07:43.8992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AouWxZnohcmS2zD6Pv4f2xJEgrSueEdvNbhuckvZfxtNx0/WNUkaJ5GYdKt/4gT2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8191

On Tue, Aug 19, 2025 at 02:59:07PM -0700, Nicolin Chen wrote:
>  c) multiple pci_devs with their own RIDs
> 
>     In this case, either FLR or IOMMU only resets the PF. That
>     being said, VFs might be affected since PF is resetting?
>     If there is an issue, I don't see it coming from the IOMMU-
>     level reset..

It would still allow the ATS issue from the VF side. The VF could be
pushing an invalidation during the PF reset that will get clobbered.

I haven't fully checked but I think Linux doesn't really (easially?)
allow resetting a PF while a VF is present...

Arguably if the PF is reset the VFs should have their translations
blocked too.

Jason

