Return-Path: <linux-pci+bounces-28510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B26AC6E34
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 18:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3CC93B6CBA
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 16:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5E228CF43;
	Wed, 28 May 2025 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TAAm/PoD"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA1028BA8E
	for <linux-pci@vger.kernel.org>; Wed, 28 May 2025 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748450553; cv=fail; b=cN+PuoOVJUtrc01j4YRIzL133wfU1Rm0nOeCPMPndT/utxgqm95r//1jt3jnXxPGkRjnLzM2SRv06zNjEuhJJPCQ6zkM6oZfmgxyaag05/jtseWbAVNMF9KAtxPxNA3pdY8Z0aZCGoQuIcOpb7q2tuMlhD3iIatSWYuYIdM5S2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748450553; c=relaxed/simple;
	bh=KbnM+yWo33Rfcxe7vtvDBSDdhaMJGgk+da8HS17/njE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EO1XxWQ5uTZ7NZW3J/iVfWUflQ4qMMkFtHBuXl/xYiarwhb2k5y5yiA4zF/6WoH2sRmZ2RYX/9/zvm+yDzgSK2IZvkit2Uv+A37VdLTQJ39Z6NxhuwA+PZfQ1zaZib6gmVf3ncroIkAxAgDeqgR3lWmXz1cSJiVyXNBjN3G1Iz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TAAm/PoD; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ioVIsYGHM3WTREdDLcgdTtZsEqcB0fVQUrRwVQ7ne6y9y6Xp3ntc+IGRjPfGWyBEyxIgfHk0a3rShZUAYc93ZUYjmLH8ztK+63SmWL8QEQPh7jQWhvheAlxBPofQqILFYAAlH3N7JHaU3lO2DsAUU2T6cMIDounDS7950eUcDoy6i0+sYb2XTvSlyi1yP5sJU1IUOSMW0cWxeixW2soacZxdfMRqyJCZA8tZUybpUXsIbrzazyG3gT0desPRIiZdF+kksNqVuI521OeN9ayLKbmueblZgfrGKKDGKCxz9qxuHaG9uTGBpVLXZsE8niNblvoa7XXHeAU3OVfqSIQ8og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcdZF91U/gTElAPY0imlh9C4IvtvfkQYEKggRcyS+8E=;
 b=U1c3c05n2Q7KmXzZrMHueV//aYYXLy4LqMKjHlbqMWRB7VWrhe5qalv2tFkRZY3RQbYuTGHiUqT46EifePXtCGGYeUPi0Dqb+TFV7zJcY75yghHoDT90Bg3wCpbY31mkwaqxWdYGNgvz5tdylhwHNYEMLhIAcZydW5dWkAmWL4tRPbJbKU9/lodq2H8gEjjNvWsE8jmgzdQFmRH2azBCwUJ1rk6dq6ic4ZTyFkEUSUoGnLQwGzX6uvmBNdVOS4wigu06R4B3gfluIMk1Cz3EWKzQaKl26DcG8VqbUmjdAReq78k3T9sAgMVQ1EJmkF4SgsYUkEJDVVzV+PVjM2V85g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcdZF91U/gTElAPY0imlh9C4IvtvfkQYEKggRcyS+8E=;
 b=TAAm/PoDVTJEGR0nJy3ViLTXG37N/juHG5t4qSW5fhV3VV1f/Pze28BRf32HmjBW2EQ096L5zCw316m1sUVDlK+uyHUXw5d7LmV1tr89pPJgs78PbcZhLBcFyKg1Amoc6g54+ppYaO2OD6JLAYAwq/N2y+YTCcZh1ssjYk7UvxEbHJXWcNYSOYZ97B0Lwhw/gaNooIDVkxV60q/Whh3PWmlVhFZ7cLDRmum7ej4cNuOMGo2tsaJnA+6F17W32RNj3nXVxMcosXSekR7g8Ie3lYz5HECL+UkbeqmL3aUHr6H5uN8JAck18Vfi/pkIQQ6ZfbGkgnIq4BzcSgWQX54TKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 16:42:26 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8769.022; Wed, 28 May 2025
 16:42:26 +0000
Date: Wed, 28 May 2025 13:42:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
Message-ID: <20250528164225.GS61950@nvidia.com>
References: <aC2eTGpODgYh7ND7@yilunxu-OptiPlex-7050>
 <yq5aa570dks9.fsf@kernel.org>
 <1bcf37cd-0fc4-40fa-bcd1-e499619943bd@amd.com>
 <yq5ah617s7fs.fsf@kernel.org>
 <cfdfd053-9e9d-43c0-8301-5411a02ffdf9@amd.com>
 <yq5abjres2a6.fsf@kernel.org>
 <20250527130610.GN61950@nvidia.com>
 <yq5a8qmiruym.fsf@kernel.org>
 <20250527144516.GO61950@nvidia.com>
 <yq5a8qmh53qo.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a8qmh53qo.fsf@kernel.org>
X-ClientProxiedBy: MN2PR18CA0022.namprd18.prod.outlook.com
 (2603:10b6:208:23c::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: 01e904e9-8a01-496e-1335-08dd9e06a0fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K8Wp07DxGWDpiRn06NXRbghi/xd4/dBxVW1k2tK0nhNms0WTPoBca0VCWENF?=
 =?us-ascii?Q?8Z2HonCa/BRqqQ+K76Ti5iq0nYgBW6z6yr8BbRfZhTjQ/1/ppWK2HKiOHQAe?=
 =?us-ascii?Q?3js41EH7kk/Z65IA6giJEjiqPUJjzyMkFtxbyf5D1CwYxV6uZadFDIvzUZiB?=
 =?us-ascii?Q?XFj06LEzyLfdSLc/sme7LlZy4haapoXWiH4h+MG8ogtp6neuDPB3sKg6vmqx?=
 =?us-ascii?Q?lwt3x2YdNxPi9xxkLkkabvodW0Qylz5WC7QJEioa24nx0/udXXfVvK9CjZah?=
 =?us-ascii?Q?/Wn65s1uzqDmu926fUVzWMJZZ+BNiksH0Kx+gNNqr5vsx3gVheCslOhsMoV7?=
 =?us-ascii?Q?JnYcByRSA6OZL1nrE8vx0JKEAhlAbkclmVhgGgaNFljtRAhbR19EBfUOjHdY?=
 =?us-ascii?Q?A4PbeNjmF3iCu3XjzznLIceE40rg6BwBF1Kk8BkYSQmDSSXEGcuq/C2HuLRD?=
 =?us-ascii?Q?btuo+UnvAFPFhQE1WuNSToEq9PPaUMgVjyhyalHvwS28VpdThg9swbugL4/m?=
 =?us-ascii?Q?PKjPXE7yTzbkOcA+C4u+fd3LRIgL0o1PXVf0w67NUOecFiotkZdmHGj5Xuh5?=
 =?us-ascii?Q?LJjGqXYER1sHs2pqSCK3YoGoIAnnWjB2GNcyvcvvoyQK/6HHRFpUaSDUxU5g?=
 =?us-ascii?Q?mB/WDSj9W6armpYvptFLkUtQp/zEMM9LFK4wwYV59Zwfb1cxElFpGJ8jdiXN?=
 =?us-ascii?Q?OnTCZh+XKpsp3ktjIDhUdhI8fY7SwTbvpJTHruFoiHeM8bD8EDFS46YaixJH?=
 =?us-ascii?Q?6W8DQMkLeKvAay61A9FyYTKrvzZNWOGm7P0Upa7YJML8mdZM0cYi/cFgzGyU?=
 =?us-ascii?Q?dLv89CNCMz5UhMJLRAIbMCUWX8RE02ox37C6oTI2gwBRqc0R0oL8VucHHzjR?=
 =?us-ascii?Q?OxR4AQMpx4jqP+X00meoJJgq4/1+HTCmjtUSCI2a0nv7Ky5zznMmSj6TdagY?=
 =?us-ascii?Q?cViuF1APuS1UmZIn2nkpfETNR3FIb9tDdtN82uFVEdLSleX4dEOZ9eZdUZP7?=
 =?us-ascii?Q?9B+G2lA4Iq5N1ykZL5YLWClddqkbIHj3JG5DT5HWrGhZP9B8IMBovq7nbT3V?=
 =?us-ascii?Q?mFC7K0/+0qQ58Be41j6aHP/jWB6iNmIWCDjcNPlHqUL5aVkYqsNhzHt8zGvE?=
 =?us-ascii?Q?QiXgwhvX3MKWvEcroR1X5mox7tHhhZYj75dfuPDUQnAtHFAXKrw+9lwCez3B?=
 =?us-ascii?Q?HBbi1wyxf2S+WNFHxxN6EX/xzVjowS7RIDZ2hg3lflUxseKaGhB/byFss8+Q?=
 =?us-ascii?Q?yjlqo2FV+ww1jjGI3HQJzBBIOPgizQNQXwfuNlw3zOs4b0uXZNOX9e5TFAd1?=
 =?us-ascii?Q?67rnpRivukGod+8R1COg4ZgIi7qeD36dk0t91Xw1PK9IjvwCrxcw08EpAUYf?=
 =?us-ascii?Q?Kh5Sw4jRTXb43G+bNrfbTejlxsj99F0qTzgIJvgqByPD4w1VfuHBylEO3Sgx?=
 =?us-ascii?Q?xWYe2kHQdJI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?td+QyOR0iulRmZSubxaTv0YQZa9W5B9HmnOD2/Iq+8cGfh8TGZfwZcAPGYQn?=
 =?us-ascii?Q?nBwGWHo1Kea5r5LHVRq3clHZWa0ZF0ZAq4plGuaL+0NP0GNQe6DBHUdHEf2C?=
 =?us-ascii?Q?ZC25dQp3uijfQgyaTacAbP9qFv+LYzidCObShT8HqrTaSX9zrkpclxDZNmqq?=
 =?us-ascii?Q?JH/9ccRK8mxND+Ap/r3d+Gb4HWJG16IZlbckncysFnjQ6vRWHFGmLWFMPCbf?=
 =?us-ascii?Q?ehm9J0+GNGS+KcLg1l44GShRvWf4U8mkNyBzmSZqM+KquzKupSvm5tihCnA3?=
 =?us-ascii?Q?IQgwMQR3H99sAvWuXM5XaOdZLcF2eSf77n9p0g1CzkHDDO+Qz4tRP3rBfgeX?=
 =?us-ascii?Q?x5ttHkOIF22N/AY3vF6/Gqxq7NsYRtveaSLp6A+2g6jvtX0W7ETLBueQ+q6H?=
 =?us-ascii?Q?XqSjri6LerhJRnr/YMaqj6xhg02Zr4f82/CW0Htbl/hFyGwjGxTbrcuyPC6e?=
 =?us-ascii?Q?5o2Kd/vfPtnL2J4l6WiimVihKf3W+US8uONty0i8bTUrfiDLjZEwyAU8c2EJ?=
 =?us-ascii?Q?yxaaX3WprICzJfivSFseXdhabrO8cC/sKmBJkZYvuk1Z0Am9UIGO5NUSgPop?=
 =?us-ascii?Q?Lcw0ffYfxxEaWrgkj7xReU8s3rRhS7cN3PaBKq/+qR5S+mgeX9/h4T0bjZXg?=
 =?us-ascii?Q?W2hrYhwbWKdjKDmPYU1cVA0wrC+3FwsYVgRnEDBVepfIuMfc6c8tWbsPGhVD?=
 =?us-ascii?Q?B3VlC2XKiAy9/hMUqjt+SfhVpn5WbVpwDFKgYuv7K/wvgZL6ec7RMclKQ6xe?=
 =?us-ascii?Q?1tFgLLC5Cx7mHhw7TtpfsQOiRBfDYbHdmGIeIxj3ilIdG8hVi33Gc+G08U20?=
 =?us-ascii?Q?7Z47KTb88qB2DFjgc5rTpc8CX/dS0FCnegbSmhFASFNRZUviz4KC2kjpA8iu?=
 =?us-ascii?Q?koev57jlX5yMKGfzikZTE/0PfEWh+yEvSZFy1QCJBf41q19Rbq2cVuEJziAE?=
 =?us-ascii?Q?/vO64c0gY1kH4GTFt1erYSjHmwMDUgqA0fPgmpcWCItnwgiwN0C1ayhyFjTh?=
 =?us-ascii?Q?ZV3DgyQp3XK7mETqxkWq9GAFoDsqZxEjLtrCv9kjRI1eGtrxg9LyUfyrgZER?=
 =?us-ascii?Q?GvhM/n5Or5zEZk9+awRRjgxrv8EI/eHbQ0qyA5yGYZqT0kbpDi+3vBmmwC5c?=
 =?us-ascii?Q?cMmLjWW9/XYVXx99TAzbXp84BGMYIhO6Z7VsqC1OcOyGBxUVpQ3WpyU2IYBM?=
 =?us-ascii?Q?YuETOP8M0Lp8JcQmjtYgk6dLeNNpZJRAtIlFrOI4aWIQSa3oiQ3TQFbY6aAC?=
 =?us-ascii?Q?RFxeBEkPVrOFnjvbescXvwM4u1Ic0Kp0pkg+8+wkzkjwAjucsZWyMW3+lO9f?=
 =?us-ascii?Q?KHmzx+CyYbS8gZE8fh0+v+n0/6WDxNxRgRfCK4U/sjgg7kRbT4778kODkYtu?=
 =?us-ascii?Q?enii7BiM6FoyB0zmS4MLDfTU3ZlLQTx5oyUdu00pEUD51oCNv4mZN6geqO8e?=
 =?us-ascii?Q?SI5kooF85D/vjZBpbOAK4Ivf0zLg6pehlL2U20KZoMlDR+WAVByKgv5wKh9/?=
 =?us-ascii?Q?RLo5OdJItMS/veKnjdHhh/wNdAsAiusZuUybP3rCwddtBbsgyCpDod3b58I/?=
 =?us-ascii?Q?DZ/9+c0NQoHYmENaGWVp5V+gGh+ELa4avG8DUbiZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e904e9-8a01-496e-1335-08dd9e06a0fd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 16:42:26.6403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vYBxHBTQLOlXlCswqPe+3aguWRItLz28ILl7f5JJy4sHGAiY6SScsDDVKSpCc82p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5805

On Wed, May 28, 2025 at 05:47:19PM +0530, Aneesh Kumar K.V wrote:

> +#if IS_ENABLED(CONFIG_KVM)
> +#include <linux/kvm_host.h>
> +
> +static void viommu_get_kvm_safe(struct iommufd_viommu *viommu, struct kvm *kvm)
> +{
> +	void (*put_fn)(struct kvm *kvm);
> +	bool (*get_fn)(struct kvm *kvm);
> +	bool ret;
> +
> +	if (!kvm)
> +		return;
> +
> +	put_fn = symbol_get(kvm_put_kvm);
> +	if (WARN_ON(!put_fn))
> +		return;
> +
> +	get_fn = symbol_get(kvm_get_kvm_safe);
> +	if (WARN_ON(!get_fn)) {
> +		symbol_put(kvm_put_kvm);
> +		return;
> +	}
> +
> +	ret = get_fn(kvm);
> +	symbol_put(kvm_get_kvm_safe);
> +	if (!ret) {
> +		symbol_put(kvm_put_kvm);
> +		return;
> +	}
> +
> +	viommu->put_kvm = put_fn;
> +	viommu->kvm = kvm;
> +}

Shameer was working on something like this too

I would probably split just the viommu kvm stuff into one patch so you
two can share it.

> @@ -68,10 +121,32 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
>  	 */
>  	viommu->iommu_dev = __iommu_get_iommu_dev(idev->dev);
>  
> +	/* get the kvm details if specified. */
> +	if (cmd->kvm_vm_fd) {

Pedantically a 0 fd is still valid, you should add a flag to indicate
if the KVM is being supplied.

> +		struct kvm *kvm;
> +		struct fd f = fdget(cmd->kvm_vm_fd);
> +
> +		if (!fd_file(f)) {
> +			rc = -EBADF;
> +			goto out_abort;
> +		}
> +
> +		if (!file_is_kvm(fd_file(f))) {
> +			rc = -EBADF;
> +			fdput(f);
> +			goto out_abort;
> +		}
> +		kvm = fd_file(f)->private_data;
> +		viommu_get_kvm_safe(viommu, kvm);
> +		fdput(f);

I mentioned this to Sean a while back, but can we just use the fdget
reference here and forget about kvm_get_kvm_safe()?

> +int iommufd_vdevice_tsm_bind_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_vdevice_id *cmd = ucmd->cmd;
> +	struct iommufd_vdevice *vdev;
> +	int rc = 0;
> +
> +	vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
> +					       IOMMUFD_OBJ_VDEVICE),
> +			    struct iommufd_vdevice, obj);
> +	if (IS_ERR(vdev))
> +		return PTR_ERR(vdev);
> +
> +	rc = tsm_bind(vdev->dev, vdev->viommu->kvm, vdev->id);

Yeah, that makes alot of sense now, you are passing in the KVM for the
VIOMMU and both the vBDF and pBDF to the TSM layer, that should be
enough for it to figure out what to do. The only other data would be
the TSM's VIOMMU handle..

> +int iommufd_vdevice_tsm_unbind_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_vdevice_id *cmd = ucmd->cmd;
> +	struct iommufd_vdevice *vdev;
> +	int rc = 0;
> +
> +	vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
> +					       IOMMUFD_OBJ_VDEVICE),
> +			    struct iommufd_vdevice, obj);
> +	if (IS_ERR(vdev))
> +		return PTR_ERR(vdev);
> +
> +	rc = tsm_unbind(vdev->dev);
> +	if (rc) {
> +		rc = -ENODEV;
> +		goto out_put_vdev;
> +	}

But there is no locking here so userspace could race tsm_unbind with
tsm_bind, which doesn't sound great. Shouldn't iommufd protect against
that?

You could abuse the device_lock(vdev->dev) ?

I think we still have an existing bug where the vdevice can outlive
the idevice, but that is not your issue, just FYI

Jason

