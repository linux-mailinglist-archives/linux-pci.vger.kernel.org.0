Return-Path: <linux-pci+bounces-38201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45674BDE111
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 12:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2B694E442D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 10:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A939831BCB5;
	Wed, 15 Oct 2025 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HKZK8+wL"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011062.outbound.protection.outlook.com [40.107.208.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D06231BC99;
	Wed, 15 Oct 2025 10:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525103; cv=fail; b=fbHJYb7IOFo8BCL9RYZkIQZuOwQ5SE46Lr4CrG3ZH2NZkUcAYT7y1fGqb7axqYrVXK2m+Kzu6BXDcj7D2IjoEcP8wCOJ0zt+wF/wGHaGiJjFGaoTw8kvBZMYuOnPaSHlgjv+PCd9TfWOsGYSRSB780XBMF/iRMdTuLNFgqhREw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525103; c=relaxed/simple;
	bh=ostVG3mWM6acjkceQSbQIIXS92J3xZEifhNm29N5qAg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tnPcgjMIiz1AYD3d5OgolQxEHpzVLXpA1PhdgusNIZcr6Wpit1hWdmKUMAYNfKT0ILk1WveqxbLkueVQO2ORGUaBd6YkiRqJUXMsw0weTyPzp+W1REe+G9hcOCPoa2Zv/LcGOZCKZ/+hNQnQBqIruWNjbqXWdD8QdtbZBX26PVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HKZK8+wL; arc=fail smtp.client-ip=40.107.208.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xE4vR0ybburii54M/gPa/kOVbkNvfHObU5rB7v4IMIN08tSWj0SzMCDhodFoTKPIBbJ+jctshkY0S2UUt8U4ACVSHofZQ7HKLSuXNfL/0ueGRBBIn19Wqr5ewRCAO3KtC7WaInP1Ig7f9pBG2hGbefjEVTBIRuy6EUuIuUpDPZwFcFbcD8osyY1jSpZKCW+/XCSiZa6GNq+6dUrz2qKTo+cKLcBWdNBS7JFoOX7/tXfNZwBbQbRM/2kz0mFlisStx6idSlFT8ovvE6Ru6jOd5mMvdHUoeq22VidQ/MMgvdumI+JlMhk68DgCwYTLEzIHyKOeTQ0o3UdoF3UBqnUgQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0t/Rm9R7ijQVitmIF5OySBH8C1drjVs7WEwC7qX3yQ=;
 b=DWKVDiDTN3vckfzxD2l3Y5j9D9iA2L4iDwDO8+M8602wj+SQeIbNQyMxRjU2FGKip9AwbBm4EKxXVQ9kplFjvo7XODNfFMF8OdKP9/k26NqPyv5vkQD0LJzqf1nRhlNRjb6VQ5JdctRqyjAAVij7pkQhWwHjC7n9DE48aXsCAIBJKcHDYlw6ZKBs+Wgdf3GMp98JYiNz4vrCOhkkeX50bgkQs6ZJk9wanv5HYMP6kteQVc6WQV7O5wgxipbpDJYuz00l7flLND8BPkhI5qu1m7Zx2ry1yoruuXgVO5JeDeanGlFPlcxzP6phFKdgEgnk1oV5rUegTfqGvh9xVl2KLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0t/Rm9R7ijQVitmIF5OySBH8C1drjVs7WEwC7qX3yQ=;
 b=HKZK8+wLAk1y5uC2mbqUd5QSGjL480M/aVtAUFvZYYSoHcjK1o4ZvmkcJWMql6iR4tKzA8YWv2+/qNatz0MOccm8/ozXy+tDcw3I9bmYYoAZfuejfa6VRWvIh6iLqUrTmqRxHCYn/zFQkuK/RI4gHM896kHnroUtvgs0jHk2Z0+MGkh4CrVpEA/xXUr8HiY/8k0rkCypGsw+RPzYfUABeQbSy7m+BDRm7SbUq1K3DAwGBEwmmEb0MVNQI4r6148AAETOcPkXfYuHl/Nlrg7cxpPoMBxK2bTyBBDGHGG0U1BaD8E/oraMASNLHrHEa9jixjEaNHKeoQWlQ0IlvSqHNw==
Received: from BYAPR05CA0060.namprd05.prod.outlook.com (2603:10b6:a03:74::37)
 by LV5PR12MB9777.namprd12.prod.outlook.com (2603:10b6:408:2b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 10:44:57 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::27) by BYAPR05CA0060.outlook.office365.com
 (2603:10b6:a03:74::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.9 via Frontend Transport; Wed,
 15 Oct 2025 10:44:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 10:44:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 15 Oct
 2025 03:44:42 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 15 Oct 2025 03:44:41 -0700
Received: from inno-thin-client (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 03:44:35 -0700
Date: Wed, 15 Oct 2025 13:44:34 +0300
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
Subject: Re: [RFC 0/6] rust: pci: add config space read/write support
Message-ID: <20251015134434.041ff777.zhiw@nvidia.com>
In-Reply-To: <DDHGOCNZJRND.129VXJYMXMCZW@kernel.org>
References: <20251010080330.183559-1-zhiw@nvidia.com>
	<DDHB2T3G9BUA.18YWV70J82Z01@kernel.org>
	<20251013212518.555a19ad.zhiw@nvidia.com>
	<DDHGOCNZJRND.129VXJYMXMCZW@kernel.org>
Organization: NVIDIA
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|LV5PR12MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: ebce23a0-40d1-4bbd-0200-08de0bd7e200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cde4/xSuyeAR7XBYXE2frsv7xZmlx+WqBmfrkgvswZguUVwysTG52kH50Jjp?=
 =?us-ascii?Q?y571SSzwjNbraMdFShGqy9mO3QDQKbMhZG5CQ3DaYfFtX3hhRNF7GijIlJyJ?=
 =?us-ascii?Q?Beo4BB6L4TMYFxrExA6ndy+HeK3PiqFvD6DC+orXwqy8aBfaiHYfoCABs61F?=
 =?us-ascii?Q?7FC20ZX3aGP2RRWQ1w95yNL88XLGc+Dca0/aRmuhcj086LYZHRq/rCuuawQI?=
 =?us-ascii?Q?Z8OlGYDt839BBKC0bJww563NZH4MWXB2rt041/WZs0S2x6XJkSWDQkwDJdHo?=
 =?us-ascii?Q?bvjSPuTH9LkPhpSiAcHcRbpLx2zJpLQhuRtk4X9oH6GyE21ue8dEi6djnoYP?=
 =?us-ascii?Q?IYoe/Jrw/p5VmuSQRGgENHxdTn3+0M1tqx/JWMP/4GoRSrAxiTwDfhd9lKRf?=
 =?us-ascii?Q?EeNtOJzHIQX/j4WaYWFzqtHHAMuEqMvFbr67rJNa4CzdjoSjRqHwtd3Q5Aaj?=
 =?us-ascii?Q?qTQI1+BkIYrjFhzCqqNAHljSNDt0R+Cf9dw9bUNDsmbb5lSEJHiWnB3fmGTS?=
 =?us-ascii?Q?yRbpoqAV0rPBeI6WuuZLrDXbpbprNGiLg+19IOYaue4hQPhl1OOV9Pfv4wgV?=
 =?us-ascii?Q?WHeYOJGAnxtg9gm+YX0ykVBmVVM1pYQBYRTa6gJIx6ahmvR1HU/ZNZWEsceu?=
 =?us-ascii?Q?/HNAzA/Q0BMCxxW++8wvc7HITQiYyOX6WvEl/8IS4zZyeR7sNQUhkqKCvpuv?=
 =?us-ascii?Q?kp3CIpFvaXsZHnbgBvMG0ForqzWW0UXQnI0nYWEyttjoy2Ei3TRs0Ib++cSg?=
 =?us-ascii?Q?pyHf9oDjO/5P/9QvMQO3IvF7e62g/EYOmOxeerPhxswrq5gtTV7EwiFKLA7B?=
 =?us-ascii?Q?7kkIYE/gOmq/7OA/mxWdHQTjlyIS8LAq/FyRTFCHBNblhSv6OMuo3jxjzM2Y?=
 =?us-ascii?Q?7GYUbRxS1AycO6PFDkQcj02P8+Oz8mrHkaBDf5OM6bzEfh70S6C0o8UxQxsF?=
 =?us-ascii?Q?yxlXInkIqxBqAJOZAiH3dIUkoggeQBPy+MjylLrWLC8ptyHjQdyTF1PP0LIm?=
 =?us-ascii?Q?oN3qej0FQsuNPqvWjRbYPLMUbik70wHO4xx3KL0nQPgwPEVvt1qAGan+MaXV?=
 =?us-ascii?Q?HZDG/b4HZKlcWkOBv5Thsz8mJc31BRtwbEp/60W3KaFgStdh/ZEpTgskc2Vj?=
 =?us-ascii?Q?DRotEaQkkECH5qhC0FwyrK6twsFnkLiF0OEiwANW+NSlELN1piaGUMYIcwAA?=
 =?us-ascii?Q?79bRyQGnrCmSy4PphkJNXZVHRsvKByWbMIDeeWUedclc0iRHuHZ5ixFqfWIx?=
 =?us-ascii?Q?8+yv/OVZP097KPdieD/Klq/nUwi7uigLo+RHF6BXXavXmTc8T3s5CoHb1u4M?=
 =?us-ascii?Q?SawsZxMBIgLEU+v9U4oalOlleUTtDA+P0tJQprNYXnL32md5nGoKYcVd3unZ?=
 =?us-ascii?Q?F5xpoq2FNY0xwGEMZ60iNw0nlup6VmbvobGX2+bBqH6pp7qsKuhsfIjwZckw?=
 =?us-ascii?Q?YOt5FcPSfTxwjJwfkrUoKxMKY4m6iE6dHYK4Fwaj3+8aOJg+FUkUjGpgypOc?=
 =?us-ascii?Q?NOLEg4MnW9wEqMnesincza40RKOjXnS7vHwyjhjBxhYH71gk/ZbDv6r6CYSh?=
 =?us-ascii?Q?dnjDLxyxBiqHVldENE0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 10:44:57.0548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebce23a0-40d1-4bbd-0200-08de0bd7e200
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9777

On Mon, 13 Oct 2025 22:02:55 +0200
"Danilo Krummrich" <dakr@kernel.org> wrote:

ditto

> > But for the "infallible" part in PCI configuration space, the device
> > can be disconnected from the PCI bus. E.g. unresponsive device. In
> > that case, the current PCI core will mark the device as
> > "disconnected" before they causes more problems and any access to
> > the configuration space will fail with an error code. This can also
> > happen on access to "infalliable" part.
> >
> > How should we handle this case in "infallible" accessors of PCI
> > configuration space? Returning Result<> seems doesn't fit the
> > concept of "infallible", but causing a rust panic seems overkill...
> 
> Panics are for the "the machine is unrecoverably dead" case, this
> clearly isn't one of them. :)
> 
> I think we should do the same as with "normal" MMIO and just return
> the value, i.e. all bits set (PCI_ERROR_RESPONSE).
> 
> The window between physical unplug and the driver core unbinds the
> driver should be pretty small and drivers have to be able to deal
> with garbage values read from registers anyways.
> 

Was thinking about this these days. Panic seems overkill. Given the
current semantics of "infallible" (non-try) and "fallible" (try) is
decided by the driver, I think we can do the same for PCI configuration
space with the case of "PCI device could be disconnected".

- We implement both for PCI configuration space.

- The driver decides to use "non-try" or "try" according to the device
  characteristic. E.g. if the device is simple, hardly to be
  unresponsive, not supporting hotplug, or the driver is in a context
  that the device is surely responsive. The driver can be confident
  to use the "infallible" version and tolerate garbage values in the
  rare situation. Otherwise the driver can use "faillble" version to
  capture the error code if it is sure the device can sometimes be
  unresponsive.

> If we really want to handle it, you can only implement the try_*()
> methods and for the non-try_*() methods throw a compile time error,
> but I don't see a reason for that.


