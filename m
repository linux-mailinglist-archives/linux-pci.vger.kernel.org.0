Return-Path: <linux-pci+bounces-39929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC23DC251B2
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 13:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76D294F6222
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 12:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E7434B438;
	Fri, 31 Oct 2025 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GSov8sIW"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013041.outbound.protection.outlook.com [40.93.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5971E9B0D;
	Fri, 31 Oct 2025 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915071; cv=fail; b=EDqrGq91CQVUKXIsnAeKWYtYL0Ab6Ax4kxhjhhHkUZeEVnqK/wwDpfKzfmwo4qzp60oLNQtO7sA85ZWJ79wrLVRhVJdcH4czbm2IJcjwZat7JNuHDUozqUc/xQpU12p+dvP4lAqsuedBcT696q9YBr6kVn+iiP4SNrzn1fFs99c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915071; c=relaxed/simple;
	bh=Uek1EnabkC3CCQDtZnwrGNp5Ox45ld/WcJbbHUPtgjs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O29hR6p8dr/tNwwu/RZlc4wQnrUGHHZfEqwuURKBDtRQaUMNuDgkB7e98MzRvmm218T2sQ2RYdhQUA734ilJK0O37CEXVeiz/Cb75HhaysvNP8Ph28jqFoyTv3O5zGs5Els7w1hNmBuE0wIi9YuOOD2xTS5dzE96OKLWj9DQsbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GSov8sIW; arc=fail smtp.client-ip=40.93.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUCaGtdGnyF+l21DkOzibxQyBVKyDfp3JbSGm3ZQ1d4TTOo0U/XVJIvnboSAaemfZmk0jrAz0UzLsalmGykxX2qUvNR++gx5uo0gRWSk8i1XOalKdwKqR6pYRE7B9aTc4s+24So7Pjedg6pXJjOGuGqjnHwtQY/eBD1d9KEdfvZCMO70370btxHPcyNUe1ZhOkivcRQ7wmecmfuj/y37yJxAAK8fhxiRphuU45sBJrz9Jtli2w91LtxYhZu3QmCx2o/yGrhLgOc5L/rsTqT5aXaJagLxkbfJe1FYBYwX3U4JgUIG3J2dLaDPNkEHWjR9wnhYMZ5Eeoq3eQsgCddCJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcEig+8rqnfoiqGQ+TAoBZHPamCCc/urWYRSqZMIdlE=;
 b=x93JdNNTBiVft7McgCE62G21HNqJmdke63Edt8rSexoHblTNdrotsYEszorOJAZP4Vx65zjwMRDibCXrRoLKcK7IbXUFHEdyg0jGpPIgwY3kut9+Q1LAq7XeI5BlV3kOYJDEMPnx8cMR7sIVxWbiDSeCeGW53qUMP8wXNnikXrz9HgGVxdK/vDqw+fv3d/FfpXDFJ8/uJQKiP4J8Usw634O/dJOxVF9lzU3Qp9RWGxzmP8ps9i0FYR6PRLJUHPLi0EhwykGYJc3Q2Z9Q/BH+ADvrWCE7N921mgSDKbQCD0Sr7FeESwVIbdVbJ7DdPo237P4YH+dkjLvpnFCC5NBm4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcEig+8rqnfoiqGQ+TAoBZHPamCCc/urWYRSqZMIdlE=;
 b=GSov8sIWHMWNOEFAshbIKaeaM+0S/4aIzhBPv7M5+j1f3MhUa8D8VJHTzG1BUaIAKvtgXlaA0Ae7i9UuVgpwIV09gm/a4aJAKW9XXQABxj+HrAQ+UZEaOKfko5kvkxPIG6rIE7rFWojemL3E4FE3sfU6JDHGm0dOzeML5ZsM21QnlRUa7H45EOd3kQ6EqQ3M6l0sWjPKCU/Ep7EJZWgx+nTCRQav5aifMN/4ZE0h3cmPWcMtC+ohrDkAPm+PIgR7nxsxEvuhmApxDZrxphdytQqwK+w3LMqs2Ntg5HavA92o/YqoOpcSF6f768ejWCtS8TPDXpTV3Kz0jUJ9safuXw==
Received: from BL0PR01CA0002.prod.exchangelabs.com (2603:10b6:208:71::15) by
 SA1PR12MB7102.namprd12.prod.outlook.com (2603:10b6:806:29f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 31 Oct
 2025 12:51:03 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:71:cafe::93) by BL0PR01CA0002.outlook.office365.com
 (2603:10b6:208:71::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 12:48:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 12:51:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 31 Oct
 2025 05:50:47 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 05:50:46 -0700
Received: from inno-thin-client (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 31
 Oct 2025 05:50:40 -0700
Date: Fri, 31 Oct 2025 14:50:39 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: <rust-for-linux@vger.kernel.org>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
	<tmgross@umich.edu>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <zhiwang@kernel.org>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <markus.probst@posteo.de>
Subject: Re: [PATCH v3 4/5] rust: pci: add config space read/write support
Message-ID: <20251031145039.711ccaa1.zhiw@nvidia.com>
In-Reply-To: <DDWIPOOIN5X6.3EJE6QNXV61PX@kernel.org>
References: <20251030154842.450518-1-zhiw@nvidia.com>
	<20251030154842.450518-5-zhiw@nvidia.com>
	<DDWIPOOIN5X6.3EJE6QNXV61PX@kernel.org>
Organization: NVIDIA
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|SA1PR12MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: 60656a9d-8bc3-4a78-ed60-08de187c25ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2LCmGVdhyiMmAKQjuTOgIkDUN+7bRnLgC1VdwVz8sLiJFlJTG8ujTRrsv98b?=
 =?us-ascii?Q?EB2BVdd1eCcbFEyKjS5RGVe4mYgUllU3rzx/Afc3BytclhLEOlS/usgmnF/9?=
 =?us-ascii?Q?G44o1St8TTLeIu3UKrHS5UKL0PSqkYnMlfWaBoj2bRKVSTNfcPFUkF5SjFYL?=
 =?us-ascii?Q?wIbNwyrWLDNOZVMig0fvzA2IHaO5J+bzEfYSwUOcZAFjqoRHAoPU84U2c+0U?=
 =?us-ascii?Q?qLimLO4in70R8WnIXKrd++vNc4Am25FUiL+8rV9AeAqS9d3qEAmnEP2YuUh1?=
 =?us-ascii?Q?YvB2o/CDqLaM5TNKc47fkDIuMP0Hz7IJnQPyiEcR1aR26ZUbIbcSNbakQEvl?=
 =?us-ascii?Q?ZnK8p5U0Q0XjkcR84e/YlcAGiqzr1NYPbzT9qMcZpbhzVJC+gNZl7rgWMhT4?=
 =?us-ascii?Q?R72oMLxl1gE+jomgxtoiX6pky0b27l5VdCEZd3FLoWyblwYJTFWS1tDDBfOi?=
 =?us-ascii?Q?D1ieth/Z+qsRy+FP7N/3ND0wywKEUtj5v6Nc1j5tDJwjOJhyRzJkQUUfPe4F?=
 =?us-ascii?Q?iUzeQjdvtqaOrFJ2p1D6v3W4pUhByxWwzIWTrFLKZVMvt9BwgiBm1sisibVQ?=
 =?us-ascii?Q?RwIck93M1Bs3FpI55s0mFsKJZAXUkT5a4+Zr3gVls/9Bk7aBu8NpUBrIu70m?=
 =?us-ascii?Q?L+6aLQjusQwQYZ2GQSEImqwihZdK/aXRJlC2nlw5S4SgH6mofWFXvXv0fV9m?=
 =?us-ascii?Q?ZB5/ExLUD+rxKWzRMek84K/UfQQ7pY9FkXakvlZAZSSPHWpELd+k8CLkzhVY?=
 =?us-ascii?Q?wMvZwC5KKTSh5EgapoMAOwl7WrJeayGqj8oDPP8DqVSjwWuazWyqwEiUamAH?=
 =?us-ascii?Q?8Rx2/pD3b9gzoKVyxJ0TqEL+UtLkeg9UNmotBTReEeUhlb6h6hms7dQrVDht?=
 =?us-ascii?Q?RPpy9lqZdhyW3tcbS6KNvrjr2Jtdof94sI8bm+jmmRb8P1Xeey0eNIYMaIQs?=
 =?us-ascii?Q?JrB7OA0/6Od8U54tMY7v+sJj7PzZ0y+L8u13W2F8V3AKY+ZKVNsCuoOQEaF4?=
 =?us-ascii?Q?irG+WELAYZRU2UggzEENhnMpruvJeAK0xpdLCH9crw/wFQMNnUXd5gKoBk+a?=
 =?us-ascii?Q?cAMkPnukPSlX7HI8BhdHF//ooB6h7bKLa5Thb0y8heFOobxA0VORfOW1smvD?=
 =?us-ascii?Q?DaMDKGY4JPX58boMTZfAqSo9KJcBavunEp9FDf73R7/dMDw2scubowLpaD+X?=
 =?us-ascii?Q?WpYhs9wjr1jRZnJ4D9/U1QWlVeF+IZUfH3YaoWwJB/i9zm+coh6CnYm14q83?=
 =?us-ascii?Q?B8eiHAnWTDBfkCqHUuvM/15fE/2uR+3B9OYlzZ+z/7IiMeWACl2BCOPe8VpA?=
 =?us-ascii?Q?3I3Kk7xkMFrvPsUp8P7VOyg+WqWpSg42258G6Hdsb5bt0UGR9FOz2e0wpLO5?=
 =?us-ascii?Q?Zh6BUQkjVWgmdbjsTWd/QP7Abt5AZFKpYxc5V4GkDMYYta5PLnOIZOc7zBIr?=
 =?us-ascii?Q?lClOyx28riQgOUb877VOvobj+vrSYEPE+FzOL+KUKmeH1d34jLbbFbjsf5Y8?=
 =?us-ascii?Q?eyudBWeVlzOiVE7A4XHmuGaFDu7JTJnTQtmqDf3Rgq07KVV1IYREpkhB8nz/?=
 =?us-ascii?Q?OLESiD2raIGGXGK9fbo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 12:51:01.9411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60656a9d-8bc3-4a78-ed60-08de187c25ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7102

On Fri, 31 Oct 2025 13:48:41 +0100
"Danilo Krummrich" <dakr@kernel.org> wrote:

> On Thu Oct 30, 2025 at 4:48 PM CET, Zhi Wang wrote:
> > +impl<'a, const SIZE: usize> Io<SIZE> for ConfigSpace<'a, SIZE> {
> > +    /// Returns the base address of this mapping.
> > +    #[inline]
> > +    fn addr(&self) -> usize {
> > +        0
> > +    }
> > +
> > +    /// Returns the maximum size of this mapping.
> > +    #[inline]
> > +    fn maxsize(&self) -> usize {
> > +        self.pdev.cfg_size().map_or(0, |v| v as usize)
> > +    }
> > +
> > +    define_read!(fallible, try_read8, call_config_read,
> > pci_read_config_byte -> u8);
> > +    define_read!(fallible, try_read16, call_config_read,
> > pci_read_config_word -> u16);
> > +    define_read!(fallible, try_read32, call_config_read,
> > pci_read_config_dword -> u32); +
> > +    define_write!(fallible, try_write8, call_config_write,
> > pci_write_config_byte <- u8);
> > +    define_write!(fallible, try_write16, call_config_write,
> > pci_write_config_word <- u16);
> > +    define_write!(fallible, try_write32, call_config_write,
> > pci_write_config_dword <- u32); +}
> 
> Please also implement the infallible ones.
> 

Thanks. Will do this in the next spin.

> > +
> >  /// A PCI BAR to perform I/O-Operations on.
> >  ///
> >  /// # Invariants
> > @@ -615,6 +670,11 @@ pub fn set_master(&self) {
> >          // SAFETY: `self.as_raw` is guaranteed to be a pointer to
> > a valid `struct pci_dev`. unsafe {
> > bindings::pci_set_master(self.as_raw()) }; }
> > +
> > +    /// Return an initialized config space object.
> > +    pub fn config_space<'a>(&'a self) -> Result<ConfigSpace<'a>> {
> > +        Ok(ConfigSpace { pdev: self })
> > +    }
> 
> Please see [1].
> 
> [1] https://lore.kernel.org/lkml/DDWINZJUGVQ8.POKS7A6ZSRFK@kernel.org/


