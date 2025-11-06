Return-Path: <linux-pci+bounces-40530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA13BC3CEBE
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 18:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F3B53AD3E2
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 17:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FD1336EF7;
	Thu,  6 Nov 2025 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UXdPbrgH"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010060.outbound.protection.outlook.com [40.93.198.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0C230E0F7;
	Thu,  6 Nov 2025 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762451060; cv=fail; b=lQJPHIP2Ud9rFIlP3OjHkeHUcvBmb7pS7kBIgcw2CKW7C1JsX0EPQU7ke0jS0tF8GX5MKqB008NDecwKqih3SjaQc5q5E4A5ANc5oF2eeXjZlRFkN9x0D/vmgbA9RlCXyQUB/QTLUisC70h67hpfWENokqnc+xhMFLbNR1KWlpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762451060; c=relaxed/simple;
	bh=bs+7BzCDJUXOmsOEu8G9oaOTKkly+JII7iTokZIKuwc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZhnxYKvfTnIJd3VCgiDXgKK1HE+bxav5kquQJsLkE1RS06KUAoTTxslNmrRupAH1NgpFJ2e3VFay9Vz86HbvOY0qYHka/3JOjYh02QLUloYndpGakn9EXaNGvfJUqs3No05hzO7rHtpssYmenMFklJ3zQP+1aSnz4bV8k90vqvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UXdPbrgH; arc=fail smtp.client-ip=40.93.198.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4cCg6CCbD69JrdB8UIAcFqkEcIxgPql/V7ukHud2TytkMH2luHjsaC7WBZjmk2KJBqYT5AfSjVmdp7YaeBbIjAXxj+Vl7uurjLgtyzfNHoetvkNpgBZI7ZZxlL7JJJfN74tCo8/18RiiDnvw4g80O0Gpma03Yvjv7iTzdkndlxsg1MOOlZjfHtlFEBykyhOElKq6yRmQuxpbMEpS1VbbXgpbTUXwhAX2NJtPqMB0HBs2nHyUV+jPvKcfU44dtzZkzQOfYcx/y/4gLxBMQ908C3NmGct8Jtmn/rC4FIrfXBMb7Odm9wcVuuF+BSq/wduss3wzS9ZopIA3lmXwPa+Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MX6DOv+0vCiTwEPXm5VMhxIVYBpENvlZFNgyJM7yckI=;
 b=NKGxgCAzVqvoRdevvLT7eugjFnD8rHLw14lug8aAafb4rCrXpLZug03SwP9lwwTr24yQDTri3R170YWex2fGByMLproFKAU3AC+4/v23gDDUG2hxYaEfKkCRs/Ya/FXWubtRfXrqX4M4Zfni9IS3ZJMyTz1JpUGmxjo0N1to25iBfeExg2qnjSn7K0X4EEqxh/3k7v0nqu9V1OK3etTbLam7tcWCXGKqzLRc/Wh3IVTYyY6dLeIj4hrjFxcG1SQcsTzshM9TtXw8WAdOF1Rke+gWMZVqhAMgF63mLsVmsnRa87M4KmYl6n2TZJAqi/SV3HnY6VKNQB2/k/jofQGMQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MX6DOv+0vCiTwEPXm5VMhxIVYBpENvlZFNgyJM7yckI=;
 b=UXdPbrgH4kgLYrZk5XaVjfommQxnCx3kA2H5yNCAU9KK1oR2XPYUmDBYJi9poYRz0KMKXV5vIiKtbKM07mTZFmZ92+M02HR0/tTeL3my2NL/UIM13PUT3eoSgL3VF3OjLkfNE1v2qn8pdXLQU9TKUGLoNwMuYUwaT28kzyJk1pZoW511XmCwJ+e0RuUsE6ank8ZYbZBU9FxLDcDbqj0JIss9Edfv2EvMTXcMzaefajPpHeabALKxg/ynAjX2WPrHiy2SWi5jmoC/r6U/2N5RGQOD3ZhKEBqpjzR0D57/B/Rw/pV6/NEChmB8tqIzIbHJ2YS4nW/LvosyNCGXNo3dIA==
Received: from SA0PR12CA0020.namprd12.prod.outlook.com (2603:10b6:806:6f::25)
 by LV2PR12MB5872.namprd12.prod.outlook.com (2603:10b6:408:173::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Thu, 6 Nov
 2025 17:44:10 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:6f:cafe::84) by SA0PR12CA0020.outlook.office365.com
 (2603:10b6:806:6f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 17:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 17:44:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 09:43:51 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 09:43:50 -0800
Received: from inno-thin-client (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 6 Nov
 2025 09:43:42 -0800
Date: Thu, 6 Nov 2025 19:43:40 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <aliceryhl@google.com>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
	<zhiwang@kernel.org>
Subject: Re: [PATCH v5 6/7] rust: pci: add config space read/write support
Message-ID: <20251106194340.4e8aa79a.zhiw@nvidia.com>
In-Reply-To: <d6b4df47-87f7-480b-b837-0835b8df54fb@kernel.org>
References: <20251106102753.2976-1-zhiw@nvidia.com>
	<20251106102753.2976-7-zhiw@nvidia.com>
	<d6b4df47-87f7-480b-b837-0835b8df54fb@kernel.org>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|LV2PR12MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e5849cd-6a2f-4120-56ff-08de1d5c17a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b2OC4p4E9wJ+T+78fdPIDMkDKuKfVVuYPRQwK9CbfXQB5iPqYjFTpoaU3+Sf?=
 =?us-ascii?Q?NH32ta1C4M3pz1l7ybxEwH9a0ZJxGEqG4XXiGWwKCDJiiJH/q+MwCEpGv7io?=
 =?us-ascii?Q?QC6GJIRe3JKWUqNRxYEKJWsxdN87DI+Ki8V5C5edqSyeJayPJ0oMdS7csCYy?=
 =?us-ascii?Q?SyAk97D1Ck7bGHsVIFvdP3ky78MqQOJCJkuq2G+0vLfM+vRbssv417MporXT?=
 =?us-ascii?Q?PlMdMmVIY1KG5SKqLFKw1xvB77AhlrTa9W+kQK3v7rESBF5F+lOdDzOIjLav?=
 =?us-ascii?Q?BkhyWc28bgoDyqSz3DxPySjWgdX4VHIdF5Ci9h83dY0E1HdVXTNg/4ippTWA?=
 =?us-ascii?Q?4VPbr+3wgeTBFtjWfOYPoB4yK9loLrkTWmaXGAG5y6mjY6oghWkDFhpkeDmi?=
 =?us-ascii?Q?AFq3sEABtle8fSU4EzzAgrqgRSoTA+znAdm7NbngkVW5zid5CfznC+Y58FcZ?=
 =?us-ascii?Q?8zuWzyG5zDfXqgYq2DgYuFK5D94vzywAJ8diku11BZUG23ARTzBAYov8w98n?=
 =?us-ascii?Q?m1cOvDg7qi6X9MUYngDW6H2U29XmgMfxaC/ybZbZjij6cQqxvr93k+pg4muC?=
 =?us-ascii?Q?f/4LpflsMo+5aF264lZ4gV+I2IU3w9DfPsqCB6Ismr1qSnymJTxrnphYFz5O?=
 =?us-ascii?Q?XS+IC4C0qHg1xqceRw+GyWiM9LXpKtaJFuxeF8Ubg11rxmR9Sknh62hmPOMH?=
 =?us-ascii?Q?BSjXfxxzBesdSRs3CkwXGyvf6ze3dsIrl8WlUtJmj8xFHG8HKRjbRus5+B4r?=
 =?us-ascii?Q?YmYMN6++7+4e3ULBtHCr2NKlNi9voK5AhD44z2D0TnMVmatdXYXQ8OAx43pv?=
 =?us-ascii?Q?MkupIDiMXhcxqSyLEYBCSB5FoYOnlgSeygG0rxWCE8K9nG8YStjbWWiFz346?=
 =?us-ascii?Q?/k5wvc7H/PmC7+MAvW5GALIXX5Nav6qfXBRmCgcoKvVtgtWjXSVovf3MseA5?=
 =?us-ascii?Q?Jjw/NMJdXVw0QCtpwiVIVAJG+Hna9KEgGPZ2IU3ZMdQ/OSCr4fahkZiLoGvm?=
 =?us-ascii?Q?ROE8Ucvg2fz8OkL2QWM38OIHk2wVysUO5mvHlXi5JqjMCBMZZ3p6shCpM/CH?=
 =?us-ascii?Q?UpELgaT4sC/DQtPfgKlBmWgyuoRYbP/9YaVMB5TWyddblEwwATgywQUtXhl3?=
 =?us-ascii?Q?UrCSW58lln5JczPx63zH44vD6ssbaLB13+FDsiOBPD0kLrOSyBrJR8KeSW0h?=
 =?us-ascii?Q?MzFpCsvO6JzTewiipXpeG8H0pXOoouSkw93axp72SNUSC38EbMQ6XGrdW0gU?=
 =?us-ascii?Q?xMWyNcmLoe2XrROwT7rqrEdEwxLlygBhaJJpXkmw8Ez1ppxEXGU3MfcbvnVH?=
 =?us-ascii?Q?0jI19p/kRnEgg4GgrlyRXBSjIGzAQ/YYVsvTlvfnVKCi3wHDieccrnWuWORe?=
 =?us-ascii?Q?mZNZQ7veR/2Wn/WkUs7dlVb4UzNhNJVTnN4BYyfL29ap5DmjbIg0akjz1P1Y?=
 =?us-ascii?Q?63FxZdcsWUF4D8U9AcDFMM5OCXDhMZelAONKc71mUhyDMl4/sb3sv2oHe2u1?=
 =?us-ascii?Q?6uAs/kPdGzXUCuS80c5Y953z50gOVs3gFeb2CbhBko6V0Jiqky/f81fIOl+6?=
 =?us-ascii?Q?ziyrZJYaZR6TgVAfSu4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 17:44:10.2517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5849cd-6a2f-4120-56ff-08de1d5c17a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5872

On Thu, 6 Nov 2025 17:30:39 +0100
Danilo Krummrich <dakr@kernel.org> wrote:

> >  impl Device<device::Core> {
> > @@ -441,6 +480,20 @@ pub fn set_master(&self) {
> >          // SAFETY: `self.as_raw` is guaranteed to be a pointer to
> > a valid `struct pci_dev`. unsafe {
> > bindings::pci_set_master(self.as_raw()) }; }
> > +
> > +    /// Return an initialized config space object.
> > +    pub fn config_space<'a>(
> > +        &'a self,
> > +    ) -> Result<ConfigSpace<'a, { ConfigSpaceSize::Normal.as_raw()
> > }>> {
> > +        Ok(ConfigSpace { pdev: self })
> > +    }
> > +
> > +    /// Return an initialized config space object.
> > +    pub fn config_space_exteneded<'a>(
> > +        &'a self,
> > +    ) -> Result<ConfigSpace<'a, {
> > ConfigSpaceSize::Extended.as_raw() }>> {
> > +        Ok(ConfigSpace { pdev: self })
> > +    }
> >  }
> 
> Please implement them for Device<Bound> rather than Device<Core>.
> Also, the methods seem to be infallible, hence no need to return a
> Result.
> 

Oops, I missed this one during the rebase. Will fix it in the next
spin. Thanks for catching this.

> > +/// Represents the PCI configuration space of a device.
> > +///
> > +/// Provides typed read and write accessors for configuration
> > registers +/// using the standard `pci_read_config_*` and
> > `pci_write_config_*` helpers. +///
> > +/// The generic const parameter `SIZE` can be used to indicate the
> > +/// maximum size of the configuration space (e.g. 256 bytes for
> > legacy, +/// 4096 bytes for extended config space). The actual size
> > is obtained +/// from the underlying `struct pci_dev` via
> > [`Device::cfg_size`]. +pub struct ConfigSpace<'a, const SIZE: usize
> > = { ConfigSpaceSize::Extended as usize }> {
> > +    pub(crate) pdev: &'a Device<device::Core>,
> 
> /Core/Bound/


