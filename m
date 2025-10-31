Return-Path: <linux-pci+bounces-39922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DD0C24F47
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 13:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 08DDD4E2C48
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 12:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6D52C86D;
	Fri, 31 Oct 2025 12:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="beyXFhZ4"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010044.outbound.protection.outlook.com [40.93.198.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DA91096F;
	Fri, 31 Oct 2025 12:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761912995; cv=fail; b=PzRviYzQYzeRctmtnNjd2/AsCX3UPoVvyEAm2tsqoDTTSMWV/bLqnU8BrB2MXiuhDWkRQ6oO13qkYOmmqQNiBY489UYP7Myl0zcVqD1NbgBrq68CSdPkjAYn6P5YuD4dVb9TKnDDzHiZFidmCcS2WQBmfj+xnt1/MJakT0cP1Hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761912995; c=relaxed/simple;
	bh=k4r8R02AXkRk5nkiEoOeZCFLcPIKR7MHjdQtQXor6H8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P+URcQNz7IMRhgfr+7xWJaCJGVSQcoY8EjNu+o6FAC1TvTUFP9itsSYQd8yg6TADpopzPHxLG1P4z84LlvYiwXgnLyOe18ILHCc7emC+xRWa0ZSYD4Bb+AzxZ+zOIGLCFllMYY3UuYLr8CoP2FCd/UTKvRQQnF9Bqv97I5PRHiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=beyXFhZ4; arc=fail smtp.client-ip=40.93.198.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXI5nBx9R+3J7RsnAB4iOl4RDcO3LjHS1XEoJi/s5gv5ou+5faSWQPWvPZGVtN2RQBb2JLfREQkf34TL5bpgd9PNUlUzJopIu80bal45ByjRTaLg7PdXXuUb0mTPVpp64QDYzxXzNVQN7y7u4SIwFO28roQuTZAeRzi57bEAnK5wlxSymVblSShJ1dnFj2aWWS0vZiJpCu+NBOr29mDncyRgfHpkIptIt+23ZJMQpJQUhem65UDGG70+nW0oEuPF++n2fMlQRZfM6UrcjdglMYMX5gn4shOqQxmqOGQsvEvmTVTXHCQqKUm3yNoPyWqMjj+CpPlQGBzZRkKDq03n9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OxdqA2nNMDE+ntnikEhadoNab19NbjstYHPT6Yq5u8=;
 b=SXtEF2ikcWW/8g/BGCIhukeblK3/zdlWlsRPMJz8qWFBrqQYiogQigXCYAVjdTFr/tI0uKXyI6ZofCqFjrQuzLk9DcVevMmAa9qJ+D5m6b1Ksz/oeTK8TBYDXYpRSDUi3RjEieOfutDD8KDSpFpDQEe546LQTY/muyvLKpPCKpwvzq8NdjRh7XQEpR+4QCU5O+js3YAR11QNPGBK9xhLKJtABH8rAVckdXeVuOYruyhfsNiCCf8cCV9UlQgpqZrJUsozesRds07UooX6TuzwujpS2KtCqf6kaEt8MROEbBbVxthR2j4UDw7cvaIFIJ9zgla0/rcalOHwT0vvNTWlxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OxdqA2nNMDE+ntnikEhadoNab19NbjstYHPT6Yq5u8=;
 b=beyXFhZ4Csk7wB35G/j4a+PNNJU9x2CY7VAaPLsEsIX+cvTJSw6Ef+kD6NwFNydHkpeBFeCp7Qlu6XKdn0FXusY4ICryutPyArCCevRNmr6wkI8WGzw4Hh/L+nkncudKErLNXkMou6BX+/AiMZXFm60sPshuxAHZsXi+moROP/Q3AkW59iULL2zL/3suZ5s4BC8BMkquoLUVJ2EjfNDJR1oJnLph/QN+TUAR0QNovcGJng6XtjIPoTsXUAcQt2HQSQ6oIK4B6qmf0NwmUAN/bZn+QXAMDZTBC98Qydu6wWabEwyWOFTv5au9uaERgJvbmdWH0d8A9YikTmrWoZ3w1w==
Received: from SJ0PR13CA0129.namprd13.prod.outlook.com (2603:10b6:a03:2c6::14)
 by CY8PR12MB7362.namprd12.prod.outlook.com (2603:10b6:930:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Fri, 31 Oct
 2025 12:16:31 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::e6) by SJ0PR13CA0129.outlook.office365.com
 (2603:10b6:a03:2c6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.6 via Frontend Transport; Fri,
 31 Oct 2025 12:16:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 12:16:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 05:16:21 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 05:16:21 -0700
Received: from inno-thin-client (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 31
 Oct 2025 05:16:12 -0700
Date: Fri, 31 Oct 2025 14:16:11 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <rust-for-linux@vger.kernel.org>, <dakr@kernel.org>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<aliceryhl@google.com>, <tmgross@umich.edu>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <zhiwang@kernel.org>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <markus.probst@posteo.de>
Subject: Re: [PATCH v3 3/5] rust: pci: add a helper to query configuration
 space size
Message-ID: <20251031141611.669c5380.zhiw@nvidia.com>
In-Reply-To: <20251030165115.GA1636169@bhelgaas>
References: <20251030154842.450518-4-zhiw@nvidia.com>
	<20251030165115.GA1636169@bhelgaas>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|CY8PR12MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: bd7fa809-bb84-4df3-c1ef-08de1877532f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D+5CZUoYZP7vVhJnmWfTIwyRiexLtUEZigQGeM+n1mjdZmVrkeP6FmuHpcrq?=
 =?us-ascii?Q?g5MDcxJR6JZMQERi/DeicRLYwouxm+15YzA1dzqATg47tPA1YSBQPlHeJ65E?=
 =?us-ascii?Q?Zv1MneuWghNFSEgfeKAw01IGUg2rS86pweGnq35jHvcVDkYuQtFpPyiInxZe?=
 =?us-ascii?Q?QgJh4Ecd7/Pmg0Aar0RTcWD4xcw0L/kZ9NmqSskYAmS/VHQlz+jb/VgR+KCI?=
 =?us-ascii?Q?Cb/eJ0FquCPgeaOESPvFfaNWSPNw3EHiDjxNkRpg/OWjjWDjonqSUlL9Dvb+?=
 =?us-ascii?Q?IDHbm6cHqCoEOQWXM+gUE5hXyJu6bJeKOtJ2i1MFsGWwUKSRfaAiMD0O2grz?=
 =?us-ascii?Q?DDFt6GF2L8kSeCgP7NqvjTK6+K4I0G53qwUk2ERHDxgSomilahFc3VIS/P76?=
 =?us-ascii?Q?iffUUSdMeWIdUekA7qIf+ZHGiqqDddiNeTKZZfRNMGySBTzTOPfSzm+Mvt0X?=
 =?us-ascii?Q?AKOlcHux+j916ppDp+r6a5HzdZkzzTxpKiSeVK8ZvSLxIhOywqEm+869ldkI?=
 =?us-ascii?Q?fB/bAU+ENdaIfKwk2e832t045AlpGG7VHTypcWjlmxzGPpP8mKbJLxJunWb7?=
 =?us-ascii?Q?+xABkTFLg76i37xXzkEXaVnu9hnxn7/0w+MAZaT9i+9gpmWs4e7MiPqSZ0bt?=
 =?us-ascii?Q?+AhxhN9ZwtVVTmapTvEBd7EYTkuYqOCsVr5zg/DHBk3UU5oWAm30IvyekIB/?=
 =?us-ascii?Q?8DTz2X/5WdPOUzhtl6kkpbJ+LKxyZJpN4BmIOaIdu5SdPJ1yB8DWi1u4lsyE?=
 =?us-ascii?Q?TBE5DDf5qSVNqQxK2rg1uyWVQaakXxsddZVK3WQpkp0c9LWtspZqeBfCiLNw?=
 =?us-ascii?Q?MwwreXeAf4EMWb6n+j72BPzzph0frgip6XoJ9byonWiZskwmKEIFYFgQ60yW?=
 =?us-ascii?Q?dcjJrgfD9hLZzqx38E37UtPASPW2V7+mZh2WRMO/aeO9v3Gq9yQ0EcKoDT+p?=
 =?us-ascii?Q?wx7PS7N3wgFtBNykwx8s+CYkMA5Hnw/BAhu2Jg2udU7fJy4qhx7P0TRi7KEX?=
 =?us-ascii?Q?y7J0mcGycPvPDIX282gULkUU3/sU9vU0t/bdD/TOkThtHaBwgAQqJow6b0fr?=
 =?us-ascii?Q?mmZe6i2ox6P0/IBPJSJR4Ho9HjtiEKuUugeK8AD6IHh2Mk5/sEGxTX2DlqBe?=
 =?us-ascii?Q?xgNStl0WpDHiEj2HSlQd/WG67yXXXcyJoZH1BOE7GK8YJDBeCTEZFd5Wm2U8?=
 =?us-ascii?Q?e9LqZ9BocxkvkaoEJEXJjJzhKPNcs4melR2Kb5xLtTJSYKi+O2v5y0qkoaAQ?=
 =?us-ascii?Q?xIBbfOo5aLEkCVhm7vTx3dFqAJY3jqCeKdSoGjIiq4ko9qMcXONXNM61XZtz?=
 =?us-ascii?Q?2MIE1jXdj0M+W2VlB3dZVbwjJojfIg6p335HZGAcB5/71wQJCrFdtrAKEKsI?=
 =?us-ascii?Q?zF8CoCdtHh6fItGWvBDSx4R9A+S56FgLZMd0+yAerwN07YKYsP+ord389DFf?=
 =?us-ascii?Q?FJ7IkecbyVyg9FnX/+khM2Hhu5yafhdnlrq5X0cz6KTaLsfiLkguH76Xy2zA?=
 =?us-ascii?Q?sZX7FU8q6yqfkBnz71VQlASbKOc5uVqu1zJZY1pRU3tZfCflJ+sKObFdSwd/?=
 =?us-ascii?Q?KCwYoqC+OT+8gOIc8bc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 12:16:30.8733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7fa809-bb84-4df3-c1ef-08de1877532f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7362

On Thu, 30 Oct 2025 11:51:15 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Thu, Oct 30, 2025 at 03:48:40PM +0000, Zhi Wang wrote:
> > Expose a safe Rust wrapper for the `cfg_size` field of `struct
> > pci_dev`, allowing drivers to query the size of a device's
> > configuration space.
> > 
> > This is useful for code that needs to know whether the device
> > supports extended configuration space (e.g. 256 vs 4096 bytes) when
> > accessing PCI configuration registers and apply runtime checks.
> 
> What is the value of knowing the config space size, as opposed to just
> having config space accessors return PCIBIOS_BAD_REGISTER_NUMBER or
> similar when trying to read past the implemented size?
> 

Per my understading, the Io trait aims to provide a generic I/O
validation that can be reused across different transports -
MMIO, PCI, SPI, and others - with each backend implementing its own
region boundaries while sharing the same pre-access validation logic.

By design, the framework needs to know the valid address range
before performing the actual access. Without exposing
cfg_size(), we would have to add PCI configuration-specific
handling inside the framework.

> Apart from pci-sysfs and vfio, I don't really see any drivers that use
> pdev->cfg_size today.

It is for the framework so far. If we believe that driver doesn't need
this in the near term, I can make it private in the next re-spin.

Z.

