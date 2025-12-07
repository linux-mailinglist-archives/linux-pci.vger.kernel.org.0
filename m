Return-Path: <linux-pci+bounces-42734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6061DCAB222
	for <lists+linux-pci@lfdr.de>; Sun, 07 Dec 2025 07:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7194300698C
	for <lists+linux-pci@lfdr.de>; Sun,  7 Dec 2025 06:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBD02E8DE6;
	Sun,  7 Dec 2025 06:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g0ancnnL"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012033.outbound.protection.outlook.com [52.101.48.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F1D2C11D9;
	Sun,  7 Dec 2025 06:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765089240; cv=fail; b=OZ+td/7xHDxLMLleEp8jQjfgFXvm7JYpDHhc1hL3v3Za2dlMYN3bzCowR5xS2rDcWCQMLZmkzyEtFUhwhEow6M08v7uAiObMujHS42yWPuRBqRScQ0+ZMMoBWEEtA2Akt90uf8XVfBiqBPrfL1Yh7e88AHeRwdPuS+JLdFYKCjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765089240; c=relaxed/simple;
	bh=2A08k3TvVQlUtcxsx/ehJVuCyrWvqaX0xaW+F6PkeKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fy2Uy7C5nfbsB1vI6nQMr2hOBTEJ3zbHZ2mcHd0QzH9uuTowAJpi3JihCv8805mT2MfMHoSrmCJ3Cjg25FBrHXwM6aSfy5nd5Dyh8JKWlXV1YA+u5SXgkYvizoZBHih3bNbGEKqjpoE4GJecNzjpbEP3PcNZ/KjWyPdzTwAI4rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g0ancnnL; arc=fail smtp.client-ip=52.101.48.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BmsceDOghihdQmR3az3rdV4XsDFzST+lZhLREkinz/hSSP40ECd87qQUjZQcO8/IaKVNe2YBIuyaXblpI7wy02+92mkeLw/jqPkkC2vAvJMt4wa45LZAoohV6mshEOJEb771jU6Mwr0achPl6JfZYbA5OFP/QQYmYa8K5iih37DkwJW5Zzi/8g2B8J2TN07mLi9+wBiyBqmcxrQr93aDXAFXmhjlIZ1sZcFMwuTFrSNw212jhCQJwg+EskEMcLWBeCEH7a6/WK1j2PzYmpv7kaTNfDstM9UpRZk47/tDtIGw3Kk0hITpEEAJYgN0QBRSIGM0iGe4giApH7+0u3TtyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PERRVPFoce/NdlhrGIduUoT4dv0K3YfA3rh3tlwu6oc=;
 b=q+Irqgh6rRYYrtgFnCs622H8p4SH6jIFyXc+ccgBj/vUtiHZANKs5y+MJAosk5LOHl68VD60D4j/t/flghIIV7GNvFTRcCX0eMDkLwxr3TRnAfVNP56M9sKdBQodnmhXTxpvZ+IJibkv8kIgqq6+tYTTy+Z6qYJ0LOUMYUOjwwfHaf8EMw8TWcY6SHBYJVIl8YiWFSDRDFNavX6RzVkIOwM/+96Ww/M/WaTboO2gLnbpWTejB2GNbKTdPR32e2UWK0NFftKwGFc8ZyU8/n9h1xVW61ALqgHUSDQQnq7W+I8JucVsH4auf13a4YCyOx9+cM0uSKK1bGejN8R9MVS+3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PERRVPFoce/NdlhrGIduUoT4dv0K3YfA3rh3tlwu6oc=;
 b=g0ancnnL/TyH+zSIOpvvEYrgGCLTWto0eRz+LxVXrdMMTnS+sSbnUCWSN1FKcOYSsLxRrAaP1/ih3I4sgENJWlJfqIyj0U34JX+BZCgc+w/NY35NmXkJ/elPM1IWgtgWwRrdG4SCtXyTIiNVyJObVG7dXVEJK5R6g31F3/jc+FrlcLwJWYZKlQxq3K87jVazQgVOQtRdJWtT5J/BKDNlC+0YvRZrjpYiEercxMnnPis+7LUpbfM8HMRmuP4DEDzrh4VutbrMEfIh0BpfuJhAaOQaErhZR8sTwVk4IuZ/6QIe1jkhN2CWplTvaC8z/RTVttoJ8hbBrQ5EgHWC6EBz6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by LV8PR12MB9083.namprd12.prod.outlook.com (2603:10b6:408:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Sun, 7 Dec
 2025 06:33:56 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9388.012; Sun, 7 Dec 2025
 06:33:56 +0000
Date: Sun, 7 Dec 2025 01:33:55 -0500
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Peter Colberg <pcolberg@redhat.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 3/8] rust: pci: add {enable,disable}_sriov(), to control
 SR-IOV capability
Message-ID: <20251207063355.GA213195@joelbox2>
References: <20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com>
 <20251119-rust-pci-sriov-v1-3-883a94599a97@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-rust-pci-sriov-v1-3-883a94599a97@redhat.com>
X-ClientProxiedBy: MN0PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:208:52f::32) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|LV8PR12MB9083:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a06102e-f49f-4460-cacf-08de355a98dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gdZY1yvskzPSodUD66GlByWhk186Nd5ZKMiByH+m1iv08a7rTm6SHM10fBp5?=
 =?us-ascii?Q?OLX0arsKJLpYGlqaB1ZGWJ6YXrj9bCj1jQhs6ZPzJP7H1Npam0yt7Y9VfAIG?=
 =?us-ascii?Q?7swQaxp09MG3wUMKSw9FWC8wJ6+qFMXmdilC0AIHDOxn3dDQCgHow8Zaaxwb?=
 =?us-ascii?Q?e4aU3t+fuLWADqS1+UlhXwTTXxX0G5fzo9oqosi7ia+8cjh+UD7IZkIKgZ1M?=
 =?us-ascii?Q?YOl+EkTisbqmsgrqshQSFDq7UxQ32R4k9yCWCPGbD/tzlVRraP3URKwoWpKT?=
 =?us-ascii?Q?eqx1htKHwnRUA2wmxqpe+Cwq3I4ta39VGpviM+DxWtYcV24PYxiACQ/BeJzg?=
 =?us-ascii?Q?rJQ/lZ/6R3B6JrAgS3hxEltECznG6NC+Fz1+wH3+C0qvZiv6A4u4eLO7+aB2?=
 =?us-ascii?Q?phJEaDn10Iz4FNMe+Tcnwq+my2reh2LBd+DT85S0EIo0iv9OfKMATOAThytO?=
 =?us-ascii?Q?bKtktIZ2H+twPeJzd9E1Xkr6fVAfnWk1Z7hgjVPC8VsgD/9RhkpeWLL2FbxK?=
 =?us-ascii?Q?a2hSNUoiVrG7tGQ88NWBeaj/ghyjXb5REFucxXbpKwhuQHgR30QzdGmP/oN0?=
 =?us-ascii?Q?lOp6nn5LNyeq5MPBx6hJN3Bak7f5xsX91hHgHupnJ5VMxYDuDP9PTkjH5xvk?=
 =?us-ascii?Q?wV+0ppFMrgRlAdDqkty8FhlACMXCiA0kajNjNlX/3NpvWtP+2inznX5ETQA3?=
 =?us-ascii?Q?GnkCB3whnh4bgyqaUH9mZMAMR75t7Aq5qOxSY5QFucTZyH2Qz4EIpTXHArA/?=
 =?us-ascii?Q?LX+T5T/07UMKs1xhZSEd7AGauG259mqmaVvDIIRpyy0WGmLWReoL1hpwBdvk?=
 =?us-ascii?Q?JYYuigqPi17bDTtEfNqRTN/LtiNofQGEu6n3y8gQBLcwHGShaw0TJHkeV8wL?=
 =?us-ascii?Q?ugzM2NuaZSIsTpjWJF5wqcz6qK2/ManEsC/ioz3sr0ElpSQw+wjSa2gs6vqs?=
 =?us-ascii?Q?ADRnCYgtbXKg+vRv7I+sRTAwAB72pgHqvvefMhsCycZT8IMZ+JJmi70u31Js?=
 =?us-ascii?Q?7yK7uF3RNKCFiezGc1zmDRPPijcdstcpj/nOv/tks62VjOJ3qSYtDDCv9DJT?=
 =?us-ascii?Q?hSFS7cNyBQ34nyL+3Xnp+lXGCv7uOGjAmyIpUUZ+i1/v9iq6PSlYIsVGH6OX?=
 =?us-ascii?Q?xJxcOlMiu8Qq1aUdRHXwGTk0OVeld2WH/FJulJu6j1mphucYtsDym05TACU7?=
 =?us-ascii?Q?zC/ySqP9vhjC/0OAv4F4ZQ1EXin9giwZHKGmuUEMTJFsRxlUXVSoz5xowxyW?=
 =?us-ascii?Q?0oB89vHF6b2956cmxzgREQO+rVGUocT1B8LhA27JtQ+Jyd0lqG02hbNsJzh9?=
 =?us-ascii?Q?kjr1IuGsoj5n4OsQN3lpviYtc9Dy9l7Z14EHG6sKzAspvgeZaOdWTekeU4hu?=
 =?us-ascii?Q?zLAdO4lLeTmPFGoIWne/RRhe4rtjyz7I1Qk87jzxhudloh8NnpLwzyz6a9T2?=
 =?us-ascii?Q?GlQ8ZdjNID84erARfYA4JdAjlNgBfuaQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0AuuM3QlJoTZ/SN6L4SDqYf3N7oKzyM0Bed8uDm1JHyHGqjIZhRxBjKVRGkq?=
 =?us-ascii?Q?BQ/CdHxdc9Q5wedaG7jgqARBkeuI2Zom6MC8AwwqR1gA7mToO1m4pC7ElL/E?=
 =?us-ascii?Q?L8/GLLTKORxTlMuMp57I7rmDCsOfD4Lcx9d0lw+hUbAmTgfJN4JWywwHIN7G?=
 =?us-ascii?Q?p5s0QFlT4M91qJXZ8vrKTU2G1juQiksJ7NT5h7h+UPHmm746dyqQBE3NXoee?=
 =?us-ascii?Q?VTbQTtrFK4m8HuA6fJV98Hr4CcTAqZScWBtdbAu4WxlwpGN67gVbpHS62i6t?=
 =?us-ascii?Q?h66REba0ffJNV+gA7w3ut7q8VyARVtYvt9mzc2FHTCuQHW3xeLE+YI8peadk?=
 =?us-ascii?Q?lyAJq8Qq7ruCgNFeN+mOvQPR/vanPNGXM1wLfrik2qoxKp5jMxGVQeulcX5E?=
 =?us-ascii?Q?AgkNcl2F4bAt6jidOY7P9Wo/msNcl/Pxv/+/WdTw+SfUtNEJNLJRzbZbAMtE?=
 =?us-ascii?Q?/ovHfZ5qGD43GP83iESe8ZVFt3qgqLvP/mVu/sU4AI9ThOcDboNHvHxKn+3K?=
 =?us-ascii?Q?YfTl1BXlJHfeQOnCZmKBfcW70RLTB1FHqlbkSP/+dhzb34SxKjSxfAiDKYN0?=
 =?us-ascii?Q?TPHgaWkH2e+D9ba+kch/WCQ9Lk5MaQ0wCZFEFue5Sj3patU8qy1NuG/K1bBC?=
 =?us-ascii?Q?QflSmKXvG/rjpU2BN6HNg7w/CwoeSDe8NyD1zAv3lWBjTU0J1lSZ6LSiKiUD?=
 =?us-ascii?Q?+83uSlB6lZBVz7qEMlm2nBR1fgcbDB9giGDiYNFkA+SulPxvW8E6WAMZUQeo?=
 =?us-ascii?Q?QVCADm4VkxLJQlysF1u43NWs5+2TwlYh3AXzAL5RvI7g46nVzs5lIDqQFcsZ?=
 =?us-ascii?Q?ObDTP0cARnx1JRc0ZVKt53pzzpfPD87uWFcuJXsjBgGCgZXUghiAIZkxZlCD?=
 =?us-ascii?Q?nJi1iLLGMWCohSeD4NPLiWmpYAFCiXbqeGdH3bDZ/uEX1nbbKYja5Iufb8j/?=
 =?us-ascii?Q?uPAiGU360Vz22Y/jAfKY//Y0OkhOgouD3gg3MjQaMsX5xdJe+D5VLDsQ9r1A?=
 =?us-ascii?Q?UXB1VXYD9l6fJ5uXhvR9/raG13YEyi+Kw+7hvGuaTvSs3X8y6mpnTA7b/m71?=
 =?us-ascii?Q?BOhYi4JWOZsnPdDfHcqSM45PFPuyZm+PFyoU+mM3ZhdET4SK8z1yLvl+HZv7?=
 =?us-ascii?Q?nPVFETREQedjvPBoib8AOBnPQkI7aHEDiTRTKPwpqQQFbgSZ9383A/v/Vf72?=
 =?us-ascii?Q?AT8K8tREMIX2p5fuFFpRxDZni+XvK3UrwoV545ZPf2ypZyprk84Iov6ZL6Yb?=
 =?us-ascii?Q?wl0LY1ZvoC8ie5+dLfARqIX7Z82kxc0wKHrWK2wBGl2SrCB4Ji/Ys0FHQfO7?=
 =?us-ascii?Q?utl1WIYchMdKWWDR8vH45AeeT+tM3cpD5Yyy/qBWC67PFWBFNxKA+2I4MVVw?=
 =?us-ascii?Q?I/QeDUgRA98WwjQdM0tskW+uka3sZOB76JrlTqiyCbR6ZwDeKeJc5MV/1hMe?=
 =?us-ascii?Q?C4UezNeebbGBgvvOUdsTaqSeLOnsB4/g6FSv/FZRpHp84z2Oxfj1LeRH/6Y8?=
 =?us-ascii?Q?SBoNxaKKWJnksHhc09wv8rMqr+qvzAXfDqqJe/JqwyGbu84gJ6M1lRaKLsNP?=
 =?us-ascii?Q?xQsMGygk7dnJadWrH0U7FZdVp2Ny5WOA0IjHhgT4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a06102e-f49f-4460-cacf-08de355a98dd
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2025 06:33:56.2158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfpfEVsio2wg+hSg08i2haC1QsrRri2cHeyFJCqSljClh8hBMavV9ImU6Upe0Aoku5PFmOzp1a/+KJXBuTCmeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9083

On Wed, Nov 19, 2025 at 05:19:07PM -0500, Peter Colberg wrote:
> Add methods to enable and disable the Single Root I/O Virtualization
> (SR-IOV) capability for a PCI device. The wrapped C methods take care
> of validating whether the device is a Physical Function (PF), whether
> SR-IOV is currently disabled (or enabled), and whether the number of
> requested VFs does not exceed the total number of supported VFs.
> 
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Peter Colberg <pcolberg@redhat.com>
> ---
>  rust/kernel/pci.rs | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 814990d386708fe2ac652ccaa674c10a6cf390cb..556a01ed9bc3b1300a3340a3d2383e08ceacbfe5 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -454,6 +454,36 @@ pub fn set_master(&self) {
>          // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
>          unsafe { bindings::pci_set_master(self.as_raw()) };
>      }
> +
> +    /// Enable the Single Root I/O Virtualization (SR-IOV) capability for this device,
> +    /// where `nr_virtfn` is number of Virtual Functions (VF) to enable.
> +    #[cfg(CONFIG_PCI_IOV)]
> +    pub fn enable_sriov(&self, nr_virtfn: i32) -> Result {
> +        // SAFETY:
> +        // `self.as_raw` returns a valid pointer to a `struct pci_dev`.
> +        //
> +        // `pci_enable_sriov()` checks that the enable operation is valid:
> +        // - the device is a Physical Function (PF),
> +        // - SR-IOV is currently disabled, and
> +        // - `nr_virtfn` does not exceed the total number of supported VFs.
> +        let ret = unsafe { bindings::pci_enable_sriov(self.as_raw(), nr_virtfn) };
> +        if ret != 0 {
> +            return Err(crate::error::Error::from_errno(ret));
> +        }
> +        Ok(())

nit: Why not use `to_result()` here?

thanks,

 - Joel



> +    }
> +
> +    /// Disable the Single Root I/O Virtualization (SR-IOV) capability for this device.
> +    #[cfg(CONFIG_PCI_IOV)]
> +    pub fn disable_sriov(&self) {
> +        // SAFETY:
> +        // `self.as_raw` returns a valid pointer to a `struct pci_dev`.
> +        //
> +        // `pci_disable_sriov()` checks that the disable operation is valid:
> +        // - the device is a Physical Function (PF), and
> +        // - SR-IOV is currently enabled.
> +        unsafe { bindings::pci_disable_sriov(self.as_raw()) };
> +    }
>  }
>  
>  // SAFETY: `pci::Device` is a transparent wrapper of `struct pci_dev`.
> 
> -- 
> 2.51.1
> 

