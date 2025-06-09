Return-Path: <linux-pci+bounces-29253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D107BAD2550
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 20:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6E31890CA5
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 18:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0B121A443;
	Mon,  9 Jun 2025 18:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A1e+K8jX"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBD755E69
	for <linux-pci@vger.kernel.org>; Mon,  9 Jun 2025 18:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749492452; cv=fail; b=J93Epl8DdTO7yNVGB0mUfXHKCnzY81FgANfBfthLa77S4etl9qti7z/3oRPZFw1bocb5B6dZAvS5uhzpenTf0G70v2Re1KkLlj1AtT5hzIb1hkAvco0sfraffEEES+Wn3ncQM9kVDaD5d2pV1G+mf8FqK027AjZoAkttS+ud/vY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749492452; c=relaxed/simple;
	bh=78z8soSy9p4chOUR6qXXITCrgoRX/KVLHYLZQBtYES0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YPzSlm4Q4Puw5sn3IaHwQ1c1pIDmjuQGyE0lvjXR/+dNTlDKd/ndJMsCQAnZe5ZOvF/KXpy0T2TlTydpvxhvJcnFGxNfUR8oYZXu7AXie6SLCAmhRaQDV46/9MhprFq+oDo2euTY4T/rxzzyxMVwxrPoGS3ecSMk0EE3OsLjAFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A1e+K8jX; arc=fail smtp.client-ip=40.107.96.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKtBeCcoEJhZrbGOxKhIahLS+CvcljovyzQKGWvdy6HgyPmFprne6ZlLEyiLRIujv2DZ+5CppXv3KQCHxHMoyGJ33tDrmQhWX075phXUkP7vx9IrSv2WXblICB9fyKIcou+usLZG5DJmJ+ZXyO+cBZx9b22lOQqNv6jXmnJdPjb6cRKTRKkiIZGDX9sTfxt46nnsbmbjhKt6n1p1XXuCNcvVwWeZRhL7uB70Orw0o/Fdb3L6VZtVdpfcoyhWwxVFBj8KYd5SC+jYlNgN3u8QLi7Fv8cT2N51ogdfNpzROC4eg4aHja0lrRBK8TjQD9N5bvUl4ziFGpsmGVmvAZZzeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78z8soSy9p4chOUR6qXXITCrgoRX/KVLHYLZQBtYES0=;
 b=cicrxiWbXTZTII7Ali1ai3pPPTDODsIP44vTP8jwOPU+gP/MU2Sx3jYErt2OgGds7u8azSpCnidqYCSloBKKMrvshPXKMb31HW0MWojRnfi1fir1du01T8TLmmtjJ6oUDbsnrKzzSPbyT4oycGjMVrUQbMIdckO4vsmTBg4a74rrb0cQ5zileHg/ktrEbCfwwkowtzX1Cu1O/JNShq3IHJNZA9Ajqr0/IO4xTbfTDJ+bm+3XeDTZaYsaWiuEO00/8IdBxXbW0Tckv72upLqau7yNT5YazQZ1dxJaEkxfak6SQ4XksdcFKB06mjF1mDRXcuGLhTrKxyy7lRRV4EjGSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78z8soSy9p4chOUR6qXXITCrgoRX/KVLHYLZQBtYES0=;
 b=A1e+K8jXKyyjhgKCBiAu3QGpuLxGDNxz44KBg12jrOthPG4G/dQH71ugvm9XCbatXKVA5LVCoHlqVtb+Rh5m7p4PdLsL8ao3t57sMwR4yFNtXE0v6jaZUIx/0uLrCSO+uDmKOABf5y6/d6in4IUUZirKVnuaLsMbT2BWhhNRfwmikgawK2rm5vNSh4rNptb/doCalZYkpmZqk1eLu62kEDcMU1cDsPDY8tWSI2R2flReOO0g+9miVs73khZMZIuJmbhGXdyIbMlH/1MSRySzD3o7+3sC6fPRiol96GanfwEAT7U97zVNDLYQJzAxCzYEVfpWjQ42mXvIQUKbNPsyoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CYXPR12MB9279.namprd12.prod.outlook.com (2603:10b6:930:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Mon, 9 Jun
 2025 18:07:27 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8792.038; Mon, 9 Jun 2025
 18:07:27 +0000
Date: Mon, 9 Jun 2025 15:07:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, sameo@rivosinc.com, zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <20250609180725.GA543171@nvidia.com>
References: <aD3QcQxtjoYXrglM@yilunxu-OptiPlex-7050>
 <yq5ao6v5ju6p.fsf@kernel.org>
 <aD7TZRnFualizeXk@yilunxu-OptiPlex-7050>
 <20250603121456.GF376789@nvidia.com>
 <aD/aOk9jHryygiRG@yilunxu-OptiPlex-7050>
 <20250604123118.GE5028@nvidia.com>
 <aEEOKXxTuUifYxJY@yilunxu-OptiPlex-7050>
 <20250605145435.GA19710@nvidia.com>
 <aEZ65MtawOTjGZ9R@yilunxu-OptiPlex-7050>
 <0e313cc0-b673-4d13-ab22-741c7fde39df@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e313cc0-b673-4d13-ab22-741c7fde39df@arm.com>
X-ClientProxiedBy: YT4PR01CA0247.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CYXPR12MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: 7153d05b-10a4-4859-f6ee-08dda7807e28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m1qq4h1B00diU892TpecCl/26VmFF1ZcW8Aw14UFH8f5vvGyFVOzWl1hxrs2?=
 =?us-ascii?Q?ehe1m/OLXvKlUpNLKiqYkhabZIxLrZJnOupOaRPRJApMy5Ps95LDbGUwDwec?=
 =?us-ascii?Q?dX45vXvdqWMTGjUU1HmgOHwbFDlUwOCu0DG0M5pFsOeZ/kocnOsyhtVclRdo?=
 =?us-ascii?Q?9ugWL+mEBYQ/zP0+LR4RkcOJBMCe1lmwP5xYhBizoFNv7vd5DwUBc+7r9ytK?=
 =?us-ascii?Q?YrJyfoX9rmcbFDTD68u+FrhI0tnKDqkWqPIeZC0OpPu34qZDvLWGlp6wapfi?=
 =?us-ascii?Q?H6LruEWUSYpKwNdiH/n6eb1Isl5t+maWN9xqpROi8eVURVp1WjCwnVtHqINO?=
 =?us-ascii?Q?aUx5V9PEQ7QvZv5lukKTXETdmSSBHsvdhnm5jiEQeEdtqJQcoZccL6oJMxnd?=
 =?us-ascii?Q?mq49Gd2yR8IPE3MMBlb0Q/zGMAcB5HUQcrCc1esqMVoWcvdUZPiMwLVm4QMa?=
 =?us-ascii?Q?XL+6qIrjCn72jAbLO3HxD1uq1Lh1loUEz7kdvZrNZ9kJLQCvujfpDyG4SQEL?=
 =?us-ascii?Q?rbt5sBAPpGTDD9RWmZ0vIpErLjUHcQSKE6MFka09JejkMdJcjD2VzP4fEoi5?=
 =?us-ascii?Q?4JmgE/yWrS7Xo+rRvuFhO7yvJU+Q/rZBfsrd0HC+BGcR5PpI159Ge84cHlKp?=
 =?us-ascii?Q?Q7JbNQ+KK/K0NBw9g7v8icjxSbmMaHFPRmCpVUQXciiWm8zd/F+fwVVOniOD?=
 =?us-ascii?Q?qhFpVAG3BRZc5Dr57u0S8qhslJXyk9Kh+UxoQu+e+vSwWI9OLy6ciIL/P6YJ?=
 =?us-ascii?Q?h7fhPH1WoWZ9syMh4xoey4S4PMwVjRRY6gA6qc1SXRkDAPepKdKq22boBcZ4?=
 =?us-ascii?Q?0gDgzNOCJ0jR4zrqJulBrBkD1MkfIWTqhywlEt5pnPLQATKJdTgkZuYWEgee?=
 =?us-ascii?Q?5bhdkVyjZZAwnEeMzJwVHWxfbPG+oJIyIc6IaBuVqWBLIAVzGYFInnCtTdJS?=
 =?us-ascii?Q?ujapKlZs4OJLfqycN0DUnypjotOepM2IYb0B8LeitYEt66J9wMz1Y9olsGUg?=
 =?us-ascii?Q?9NM/wETqrw9iqg6XJUKWAd6sxL5iOlcqR8ddwZjEdyPEqWwDofgv4BRNZhe7?=
 =?us-ascii?Q?SKNU0s0RHKoOVVE16KZmXAqdNXxTkbSUCXLSDv25eDpYpYiP3hzdmbsS8C94?=
 =?us-ascii?Q?f3BIHG3icL5/nDL4e/8O+fAwH8NZJlopsbMvQWVn5iJWgpu7kSZGtcPjSTog?=
 =?us-ascii?Q?P+p3q0uk9Vu7f31QVfGiHeisn9xUZkF0Nkc7g8/rBXvbgpFHZBoDqTfU2Uo6?=
 =?us-ascii?Q?EJS6I7Ec09x1D17Sz+O18LoqI3NTR7bE9cXzoK8qBDOM5TyVT7LBhS8AwFmk?=
 =?us-ascii?Q?gUD57XA+17J/A+FOIXuhlD7S7nKBinhrgNyax3GTvHQNQYyIZhNxOX58JGBc?=
 =?us-ascii?Q?3TRcbBcZrhRZKfQuMosnOn6c8UXVAeqqI9kU0EdedyIDXgn08w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hqQNZhhDmmSSQDzHYgeVKbeoNOG+VGtWK3R6NUVeHkXZ/Wmq8p7i4dLZbY5t?=
 =?us-ascii?Q?B18nJrNjJf329fs2ujEYCrhAo/StnP+QKF0X9yFuNOZND/YMxhNjIwaF24AD?=
 =?us-ascii?Q?+XVrJSoa9A/YnHzosJlHAtW8Drb5M3N9E3WLpJoQ9QntmPjFMrtoo0wqK69w?=
 =?us-ascii?Q?ACABTBSBe85MwiGjoNGrC3cYCUhgosTLMjNNZKdv8FpZ68U653lfEaa1G40P?=
 =?us-ascii?Q?8xcowxY7kjqJb5jfWriOGgn2n0uWbYNrlkLvMoDduz4oQ/kurBgK8ISGpsyP?=
 =?us-ascii?Q?PU4e90sm1295Q+OzFeoSVW7ctakWPJrWdr7ZIc0MzUpe5n5cTqkRf7T/nR63?=
 =?us-ascii?Q?x2bpOe/5fU9AAkY7slN3yptmZsGDEdCx4WNf7KtZfRXs9K7/jmQipuDG/5Fo?=
 =?us-ascii?Q?FeH4f/Qs1oH065GuyTVNKWC7sp8+WMDRhMA63PwatoLinqYhsmM6czvYJoYb?=
 =?us-ascii?Q?+p7vqwNaALyNetFqChIDvduAo3ZDzyFHVvSL2GNhjqpWSwTJ2ScH0/MoQbo1?=
 =?us-ascii?Q?ObtUaXVWddCdUE2bL9LW15U2cuH7s+ElEowMacV21mg0jXY1r2W9M2Wo4IsU?=
 =?us-ascii?Q?VlYZfMEe+1wmhQ4BgUUPJk/w15F5W7e/Kr3JYW5BYHB+fgNHrH5WcFToD7HH?=
 =?us-ascii?Q?Jxp/M5cv2oR6ltUyiQHplfGMZ6y+Nfwgj9DIxSuXiXAI0Uk1tzQQmKUlU76R?=
 =?us-ascii?Q?71m8hDo+kAeSgV8OZrDBzKJwevacCWsKIa5lbPswm+yAfTmOrEKWrGx0sqqo?=
 =?us-ascii?Q?56+59pTxwtVfbnnnjWtjrLA5WpMJ88GuJDvDCHaYczAEuvVi+PAttP2ZN0Ev?=
 =?us-ascii?Q?b88kZY4GSPlvo6R8lgLErK48vddRp3yXSq7+2RCwlJENB+tgiyE1HREUXMmv?=
 =?us-ascii?Q?sksfLD/SKE9gKaFxhndmggGle4zNV6KG/gfjs1030ba8jQ7WQNaugqzyaY19?=
 =?us-ascii?Q?t3FGjpqRaBnCy0cC8DKQAsj4LE9zjxA9djxMkllYSR/HeAI4XqAzmvNF+VLx?=
 =?us-ascii?Q?P4wRQazfCN4sDffwJUAiQ3bGen9w+md0b04ZwG62B6QHT7VhSxsb6U/AHCR5?=
 =?us-ascii?Q?MLuHezNJXX4f7PJdGcP0/l4uIf+4Dqr51ZPvv5V8gH/hlzP1lDcqdQp/BPtq?=
 =?us-ascii?Q?+k1QfnPFCcYdfq+ptGosx1ZytPWQb1O1jJJRS3/xed0WOK+J5U75SLf5pH3Q?=
 =?us-ascii?Q?AkrYah4K5lfKS9FfoFwNBHAuRvPfoHy71I+3HnCGJIzYidkBU2b05YS+tKOu?=
 =?us-ascii?Q?Dt9zpfeFFbZh8aZGcLtzgq9DHaRvfkGV94Tz95ow2u99u9Pn+11ywbglIDRB?=
 =?us-ascii?Q?4/ZWYXcE4wBcHoxJALptBwqEB418qr+5EMTyIHVdjXD16RY/ZMk0ytOd9j+F?=
 =?us-ascii?Q?FGQxl9+WsFfmR4Ze4x36Sn5QCzmO9kyKoezsMsfXS/qS0fx2JbzD2N1WBw8d?=
 =?us-ascii?Q?JukrKiiG3L+hGK8Q+r85J77qrwFl23x2twoh0Q+TE7gmkMgnsGYoSKXDVTo2?=
 =?us-ascii?Q?AH+Dwy55mat4Zx2O44sPTHevjbdR7allHiSKjKKVZTZNOaXkBn9QTKQFWH9E?=
 =?us-ascii?Q?h2bv6FRtWn82B2QdnS/qagbni4VMNS6bGxjdEO9+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7153d05b-10a4-4859-f6ee-08dda7807e28
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 18:07:27.2634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DFE4RELdRu2d7+lFBshwXDO7yobmcJXEpbn05w8KU4lHzAcVSm6oXJPlzg9tI3/j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9279

On Mon, Jun 09, 2025 at 05:42:59PM +0100, Suzuki K Poulose wrote:

> May be this is answered/discussed already, but why can't we use (vfio->fd,
> offset) similar to the gmem_fd for KVM memory slot ? VFIO could prevent mmap
> if the device is bound and also pervent bind, when there is a mapping ?

This creates a mess of circular dependencies where kvm and vfio are
both needing to hold references on each other's FDs.

Jason

