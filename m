Return-Path: <linux-pci+bounces-34802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF1AB37553
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31FE67ADCB9
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 23:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83AA3002DC;
	Tue, 26 Aug 2025 23:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PrJsxDqK"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B696E2FF67B;
	Tue, 26 Aug 2025 23:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756249955; cv=fail; b=edBCPEvnDyNZtU3rS+fK+3F8gNH6cSgyj49jdz1EalR5FlLyOuXPxWQHfTz05t4KepopNoA7J5EsbIhac7mpfzX3Q0jwQJWR+h012463zM8B8qfuuPj7GUuX7cmDoIy1QbPge6uG7VJ3Ul/hSwjWrujttdChb30zm5ta5f/kLYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756249955; c=relaxed/simple;
	bh=Q+NSQw48o4qk1v1XN4EONwTkSodhNTnfiS19CFfqdqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uMylnhBdNHs5G95qZcwjRWmtZCjkoL8bIZZFyE2yh8bBmeX8ypkrkMwyUPXVx9ERL1hJXFW8yGflkTzEIJT0FEAceeV+qpKLX7lVQ1wzVlEysVRftDepuXvxpxFrBIcqftTGef7NTITPwrA/SFIeY+xtm/0/gOR1+zA0RJVpic8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PrJsxDqK; arc=fail smtp.client-ip=40.107.100.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXP3VABydRDL6obVKdBJvMPITjMYZdOlbf/5W28yO3HcEnheVZ7rQI0JWZWoh7LiO0HoWRCZdgkSArsbNi43x8S9Ks4R8qFShyvPmjCltMIO97rL4SAGD2w3b696tYl5Q4PQqRdvEQl7LI+wonMvxdDRft0hfo9TJzprHUFHvH9jN4xRdxGPlsQzrjuk6VnKNCVefdyb86K0yfYoTH8JKqgzeACRV4hGTLqmfC7zTdF3PCJ47U6zdJsNdZXjfvqc+XQxQf3Vu8LCyflDPSqWbVia8FLf5YxSOsxeYfIfDyBOMCUVXxvineXjBMVci9Cj6S59i4w/HD8JdGUSgvnmUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgjUKMxmXFpMqaGScf71Evk1ExQBQ7XxgjkBuqzd3yY=;
 b=kx3n2dtgk8GkIi0JzWyAmOiT3QgK0NAu8hMcZ1a+CZ89rAtNVbDs09Iwv2rU1JSI2GhTARtEPnCKFky7MBizCt+2Qufb8nbvbb90BuL7CwNijgLkLg5o9Vet0oKvBtB9doru2/XSPz4bEvrBof7ulh/ZYAzONCANdrRi+fBJ4URb3yMkQAm7aoi7gPMjrs0s54J6W1oB1EOYMCsOCC7fsws672iDoD11aq+39/n+ii5nrlQOs7oJlth5RLwqBxJ11TySTsUt4ZzuU/ken1DDFZyh6K+ajrJcizKelI2hFrS9gBpQeExHwl5XMqTArZ9clQ4y6TqIjb51lNZfxiskRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgjUKMxmXFpMqaGScf71Evk1ExQBQ7XxgjkBuqzd3yY=;
 b=PrJsxDqKYsYn7z0N5Js52HlT8ty+rUfzWaTg0Q/ooktnVxto3tJ9thPB6tsP4XKqkHt+zPxWOGzdwn4pFm/4wuIZeMrec/CXxBUcwQpFHzfbTgZmglTHVsTKNLTmYRHdw3eQa2MI254MgEjsQPtYVoVYPLqeAEgbcUGUQDYbtDlnT3nWn9aQ8QMiJ+hue2dT6RgQfiaUZ5Fw7E8riouGNDXnHzaMBkxBSUZL/HVd20Y4hVuCCeodXxVXYduV8n7uLSuOcXjjNpepw6vDO0nqFV3+fso+bVwc7APTeOOBjTig4uZzTvY24TKszUcolj/ZF7NeSYsDwiwuk2mvsx1wvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by PH7PR12MB7913.namprd12.prod.outlook.com (2603:10b6:510:27b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Tue, 26 Aug
 2025 23:12:29 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 23:12:29 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	nouveau@lists.freedesktop.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Elle Rhumsaa <elle@weathered-steel.dev>
Subject: [PATCH v7 1/6] rust: pci: provide access to PCI Class and Class-related items
Date: Tue, 26 Aug 2025 16:12:19 -0700
Message-ID: <20250826231224.1241349-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250826231224.1241349-1-jhubbard@nvidia.com>
References: <20250826231224.1241349-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0099.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::40) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|PH7PR12MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: bbf243c2-d6da-4688-d07a-08dde4f6073f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/UPpt9QF24KU1s7UjSqJG9zAV1xa+sZaCahzzZw69JTsVniZqeCgO2WoEkRv?=
 =?us-ascii?Q?9BAPZ3DcgQet1Q5IgM/87OeGfocMmc29qO1K4MA9V0qNlZ8B++buR5CyNNQ5?=
 =?us-ascii?Q?ZSw8lEVvyqU0fjfodJnqsedYrk0U3MShs4pY3cUSqpXNAhhXDl+wvaqf/fpw?=
 =?us-ascii?Q?xq1xKDykXLSV5cUXdVbmOGzNLj3m7E3NOS9VQLt2Fu1IMZL4C4zf6w3yteSx?=
 =?us-ascii?Q?qafNGR5TiQPwmugwtURkX34ENvtg5RWnx59M/4S+uMTGgrbZ8ndb5RBdYQDG?=
 =?us-ascii?Q?Hwcjcp5MpjGbptUI2y3sb8PCp2LEzKdhQA9Izn+X/DIDLqpyVdfxkt7jy/0U?=
 =?us-ascii?Q?a6l8FWo/HG+p9i9GI8cryaODU14S4z3DGaMgY4cEROcX+/atkQs4PUPr3H2X?=
 =?us-ascii?Q?aNJcnBBBMlp1XYzGav888gyCY/tvCaEItkJZ6SZr3arbkJazco9ZqNhFgm4X?=
 =?us-ascii?Q?Y6C/qqHmWqoDXG7mb8qKwOSCnkUbj0hd9hVkT8r/bnSpWEypCsjxmrLD27RU?=
 =?us-ascii?Q?LK5vGmkMUsXnd3PkJ3LUZUYPsiaMSjJUY0IYJn7S7vX/xyOvT8K/4qAR5nCm?=
 =?us-ascii?Q?7E/WrYO1OnyD4inMXDwBWKoZUuUayXyZmFALz64mQsf/JC5WaeusbdeQXAiM?=
 =?us-ascii?Q?0yEp3jLovujsJMTGzk5M02X1ALLmzVUr0OsgjSZ7sj2yoqhAbSmJZ9jQBXrf?=
 =?us-ascii?Q?RDySRH8hwTRf31EPCwq2a0A1tHmplic9jaxsgJqxcg+uDqNLBYqRthDFcRvu?=
 =?us-ascii?Q?fFw9vbAJG+uXGxmrSFr6F4YQjtPKHF4RgWMiRNIWuuIq83gbD/CU3Y/EN/DQ?=
 =?us-ascii?Q?D2U8gJV5kvTdyFl+H/14vEYi1elFnnzCqKNHyvq7GPr9jnjPNIl0ynsSeeMv?=
 =?us-ascii?Q?Y7IBmxnJ9ZbwwIbZ03vA2jl4FtwJb9VD1XUP2szW8Jvn9Up6VKzcpYOygoCs?=
 =?us-ascii?Q?X+lJ6TxX5NgsdxS9UG/HeHFM1mmvaapFWCXhGXL5bPOSZsz8j/eArUdUhcqq?=
 =?us-ascii?Q?ZSPoFEPMuE2AHNqkw3iTXTmpyrHo3svFvv2mENprZBFsMT1Z/V3sAxiuOjg5?=
 =?us-ascii?Q?DH4Ug8QTqjOoVZAHBuXWTW0lovQOW4GeQuMKU0xyKS9M6AxCW3/QAWXf3bXg?=
 =?us-ascii?Q?4eH2qEuBCnyKjFGoEz00JNgk5UOmGLRXb8WSSI0KRVEn+PpaNgx1JOYr8xzR?=
 =?us-ascii?Q?MD3SLZSKsOqgBP/35tpJKxEk+u8O5hf22PYPyjwPKoPYTHuGjIEuhsX0z6ra?=
 =?us-ascii?Q?gatejs2SxpjZBuRSMMkfJFVM7w4CI4qIS3YB7EWQ3lG7JhHx+/+ZH5OERIDn?=
 =?us-ascii?Q?4jtSuOffGhyvOan1PRFAMtum3zz0zme9M7Xzg4Rd3mGu9ddMHO9VdIbDFCzy?=
 =?us-ascii?Q?0PbgUmVuVAO+4OmFIwkQavjdpyMOhvPx+8j5VBKTQwsin2p/AYi+mnEq0AFS?=
 =?us-ascii?Q?7U1jt8OUbdk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m/JNz4HT++7gGcDvFOjRTF2875wZAEnsAkttpfIdcNrK6XzyCiWlgbaMkosl?=
 =?us-ascii?Q?8gJn0iIvHiAcvxIldL3jxiozAulTrUgp5HTP2SWPzr4ncL/QSTp1e73QcSEu?=
 =?us-ascii?Q?nwbnqUxWgdC1VBHHmQBQx5gVSabe5shrRvvf3DJDt/c2lerwI5G6vTXO2fyC?=
 =?us-ascii?Q?uOy7Wcf0MQdUQjTAWyGEP95KePHOQTqCXXtXo+dc7vKjnxbMuYp4145SLjIR?=
 =?us-ascii?Q?NR6roQipngNVhaURWj0B/G24cV24b9+uIQcer9wSA+iUy0AoR+TEbvU/1t0O?=
 =?us-ascii?Q?Tl2cMmYLDz0Ply4hVcHTb1fDSksLoa5lQ9ljx4U3SlThmQhGn1z89rWjkMdk?=
 =?us-ascii?Q?EGIZdJ8pS/P1nmZ9+AsX4M1mF3xMDo0kWskkekoy2XF1Jjo43RMpoFAXwl6U?=
 =?us-ascii?Q?mxXOPM81M0FROuHST1UtBav51rs2POsBvwryRBd8GqsXN3omPVb72FScrpXE?=
 =?us-ascii?Q?dysmg+qWtN5IgJlkCq4/150dNywhUj61duFQJYg1KWRS01/3BDX1bcEARprj?=
 =?us-ascii?Q?16e34X5cLMQE00O7507/oggUN+N6qC/G7cPXmqnqzEcL146Y5KeMa7VhinEr?=
 =?us-ascii?Q?vg2zgWYkp9G/4GnZrY33QUwv85n4pcxLDpMsM3mvwvt8gKgSJDYn2H2Br7sp?=
 =?us-ascii?Q?p2ibF1cewNX2v91MT0+nAnB5bfSVGFpYXTZaBk5D1ZgvTz09nq/WeZ8ZqecL?=
 =?us-ascii?Q?y6vnqUX+3rtUcfwfb+6VzLK5zk9zhim06MeITjn/LqY4HphfztM4B7KFlnAR?=
 =?us-ascii?Q?qMNwlNlvVRE7KiZ413osm6JXew03DGEPxj2lcTUwvGPLXS6FzzuwibWAAWZj?=
 =?us-ascii?Q?kJK0BLzCsu+umTGvvvCtjt9ycsb6GFImcu/lCQL6OS1c4hKVawZ9AJGulq6L?=
 =?us-ascii?Q?3wt8pKN4B3n1/Hv23MSn5uQR4tuGyH9kuIfHC+E7aGrS71p8Qz9JWtao12zY?=
 =?us-ascii?Q?dci4+RZTajm0ZYPNgEG57MEbrOKM5nS15pL73zTH65zoSPI3oyUp/BstJoHV?=
 =?us-ascii?Q?EwvIhEgQhC4kpf6ITFSSgWb57bH3o0azYbJfaWHHfwB+G5inlNok+1ZYJWO2?=
 =?us-ascii?Q?BTf0nvwFyq9wIcVqqvIznTFxDUWHtq6cZPaaX/BNSrsr2sPJTiLvhzxvTmEC?=
 =?us-ascii?Q?AqzTMyuNj1/Bis1bw7B/15aRd5a7MKZMo2tGgsi5z5rWuFwaHv5aF75AapDF?=
 =?us-ascii?Q?7DKlWaw4qNxQ8iIcJ1tBlZ8sqJF1DcNR1PKHlEkL03mEVKXPza4nARDBRkm4?=
 =?us-ascii?Q?8P3YXPrQDd9W5WJudEeYOAnOUbFim3xwNJNGzHQ3cNjpsW2V36xAHCEi3tji?=
 =?us-ascii?Q?9ir7654IqvQz8Paznq9M1sfk9gRyF+qHMP8aQ3/wL/P4AiW4R+o7WjEnkUy8?=
 =?us-ascii?Q?qb9bSJYu+oEO/B8jTcmev3YvWHsiTU1Zjr2Ip/i9mA4kaizUp+V/vWayPBBw?=
 =?us-ascii?Q?pRzPgUw0BB+pwCh81N/Vh96x0EVYcttSbLVKsRJ3v1XZv4VNT2HEtONC0EkI?=
 =?us-ascii?Q?lEkD2Ngfjv/Nxvlw2w2gB4RjNZkbWXEWbN726bzS8kFpF13ru1PDdnSBlKB2?=
 =?us-ascii?Q?SieR6GsD3cpuK0QN6v9mbhj0vK6XB+T80WbZCMnP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf243c2-d6da-4688-d07a-08dde4f6073f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 23:12:29.2496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3tAPqwijSx7uOb4vM1laYWmwJ6Ky25Ie7nZ4MbnVqaEGXevXdkgL44ACX3W+LQlAq6hZdEwnU8j3zvEWWimzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7913

Allow callers to write Class::STORAGE_SCSI instead of
bindings::PCI_CLASS_STORAGE_SCSI, for example.

New APIs:
    Class::STORAGE_SCSI, Class::NETWORK_ETHERNET, etc.
    Class::from_raw() -- Only callable from pci module.
    Class::as_raw()
    ClassMask: Full, ClassSubclass
    Device::pci_class()

Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Elle Rhumsaa <elle@weathered-steel.dev>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 MAINTAINERS           |   1 +
 rust/kernel/pci.rs    |  11 ++
 rust/kernel/pci/id.rs | 232 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 244 insertions(+)
 create mode 100644 rust/kernel/pci/id.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..28e200fa9423 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19532,6 +19532,7 @@ C:	irc://irc.oftc.net/linux-pci
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
 F:	rust/helpers/pci.c
 F:	rust/kernel/pci.rs
+F:	rust/kernel/pci/
 F:	samples/rust/rust_driver_pci.rs
 
 PCIE BANDWIDTH CONTROLLER
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 887ee611b553..212c4a6834fb 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -23,6 +23,10 @@
 };
 use kernel::prelude::*;
 
+mod id;
+
+pub use self::id::{Class, ClassMask};
+
 /// An adapter for the registration of PCI drivers.
 pub struct Adapter<T: Driver>(T);
 
@@ -410,6 +414,13 @@ pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
         // - by its type invariant `self.as_raw` is always a valid pointer to a `struct pci_dev`.
         Ok(unsafe { bindings::pci_resource_len(self.as_raw(), bar.try_into()?) })
     }
+
+    /// Returns the PCI class as a `Class` struct.
+    #[inline]
+    pub fn pci_class(&self) -> Class {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        Class::from_raw(unsafe { (*self.as_raw()).class })
+    }
 }
 
 impl Device<device::Bound> {
diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
new file mode 100644
index 000000000000..55d9cdcc6658
--- /dev/null
+++ b/rust/kernel/pci/id.rs
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! PCI device identifiers and related types.
+//!
+//! This module contains PCI class codes and supporting types.
+
+use crate::{bindings, error::code::EINVAL, error::Error, prelude::*};
+use core::fmt;
+
+/// PCI device class codes. Each entry contains the full 24-bit PCI
+/// class code (base class in bits 23-16, subclass in bits 15-8,
+/// programming interface in bits 7-0).
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::{device::Core, pci::{self, Class}, prelude::*};
+/// fn probe_device(pdev: &pci::Device<Core>) -> Result<()> {
+///     // Get the PCI class for this device
+///     let pci_class = pdev.pci_class();
+///     dev_info!(
+///         pdev.as_ref(),
+///         "Detected PCI class: {}\n",
+///         pci_class
+///     );
+///     Ok(())
+/// }
+/// ```
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+#[repr(transparent)]
+pub struct Class(u32);
+
+/// PCI class mask constants for matching class codes.
+#[repr(u32)]
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+pub enum ClassMask {
+    /// Match the full 24-bit class code.
+    Full = 0xffffff,
+    /// Match the upper 16 bits of the class code (base class and subclass only)
+    ClassSubclass = 0xffff00,
+}
+
+macro_rules! define_all_pci_classes {
+    (
+        $($variant:ident = $binding:expr,)+
+    ) => {
+
+        impl Class {
+            $(
+                #[allow(missing_docs)]
+                pub const $variant: Self = Self(Self::to_24bit_class($binding));
+            )+
+        }
+    };
+}
+
+/// Once constructed, a `Class` contains a valid PCI Class code.
+impl Class {
+    /// Create a Class from a raw 24-bit class code.
+    /// Only accessible from the parent pci module.
+    #[inline]
+    pub(super) fn from_raw(class_code: u32) -> Self {
+        Self(class_code)
+    }
+
+    /// Get the raw 24-bit class code value.
+    #[inline]
+    pub const fn as_raw(self) -> u32 {
+        self.0
+    }
+
+    // Converts a PCI class constant to 24-bit format.
+    //
+    // Many device drivers use only the upper 16 bits (base class and subclass), but some
+    // use the full 24 bits. In order to support both cases, store the class code as a 24-bit
+    // value, where 16-bit values are shifted up 8 bits.
+    const fn to_24bit_class(val: u32) -> u32 {
+        if val > 0xFFFF {
+            val
+        } else {
+            val << 8
+        }
+    }
+}
+
+impl fmt::Display for Class {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        write!(f, "0x{:06x}", self.0)
+    }
+}
+
+impl ClassMask {
+    /// Get the raw mask value.
+    #[inline]
+    pub const fn as_raw(self) -> u32 {
+        self as u32
+    }
+}
+
+impl TryFrom<u32> for ClassMask {
+    type Error = Error;
+
+    fn try_from(value: u32) -> Result<Self, Self::Error> {
+        match value {
+            0xffffff => Ok(ClassMask::Full),
+            0xffff00 => Ok(ClassMask::ClassSubclass),
+            _ => Err(EINVAL),
+        }
+    }
+}
+
+define_all_pci_classes! {
+    NOT_DEFINED                = bindings::PCI_CLASS_NOT_DEFINED,                // 0x000000
+    NOT_DEFINED_VGA            = bindings::PCI_CLASS_NOT_DEFINED_VGA,            // 0x000100
+
+    STORAGE_SCSI               = bindings::PCI_CLASS_STORAGE_SCSI,               // 0x010000
+    STORAGE_IDE                = bindings::PCI_CLASS_STORAGE_IDE,                // 0x010100
+    STORAGE_FLOPPY             = bindings::PCI_CLASS_STORAGE_FLOPPY,             // 0x010200
+    STORAGE_IPI                = bindings::PCI_CLASS_STORAGE_IPI,                // 0x010300
+    STORAGE_RAID               = bindings::PCI_CLASS_STORAGE_RAID,               // 0x010400
+    STORAGE_SATA               = bindings::PCI_CLASS_STORAGE_SATA,               // 0x010600
+    STORAGE_SATA_AHCI          = bindings::PCI_CLASS_STORAGE_SATA_AHCI,          // 0x010601
+    STORAGE_SAS                = bindings::PCI_CLASS_STORAGE_SAS,                // 0x010700
+    STORAGE_EXPRESS            = bindings::PCI_CLASS_STORAGE_EXPRESS,            // 0x010802
+    STORAGE_OTHER              = bindings::PCI_CLASS_STORAGE_OTHER,              // 0x018000
+
+    NETWORK_ETHERNET           = bindings::PCI_CLASS_NETWORK_ETHERNET,           // 0x020000
+    NETWORK_TOKEN_RING         = bindings::PCI_CLASS_NETWORK_TOKEN_RING,         // 0x020100
+    NETWORK_FDDI               = bindings::PCI_CLASS_NETWORK_FDDI,               // 0x020200
+    NETWORK_ATM                = bindings::PCI_CLASS_NETWORK_ATM,                // 0x020300
+    NETWORK_OTHER              = bindings::PCI_CLASS_NETWORK_OTHER,              // 0x028000
+
+    DISPLAY_VGA                = bindings::PCI_CLASS_DISPLAY_VGA,                // 0x030000
+    DISPLAY_XGA                = bindings::PCI_CLASS_DISPLAY_XGA,                // 0x030100
+    DISPLAY_3D                 = bindings::PCI_CLASS_DISPLAY_3D,                 // 0x030200
+    DISPLAY_OTHER              = bindings::PCI_CLASS_DISPLAY_OTHER,              // 0x038000
+
+    MULTIMEDIA_VIDEO           = bindings::PCI_CLASS_MULTIMEDIA_VIDEO,           // 0x040000
+    MULTIMEDIA_AUDIO           = bindings::PCI_CLASS_MULTIMEDIA_AUDIO,           // 0x040100
+    MULTIMEDIA_PHONE           = bindings::PCI_CLASS_MULTIMEDIA_PHONE,           // 0x040200
+    MULTIMEDIA_HD_AUDIO        = bindings::PCI_CLASS_MULTIMEDIA_HD_AUDIO,        // 0x040300
+    MULTIMEDIA_OTHER           = bindings::PCI_CLASS_MULTIMEDIA_OTHER,           // 0x048000
+
+    MEMORY_RAM                 = bindings::PCI_CLASS_MEMORY_RAM,                 // 0x050000
+    MEMORY_FLASH               = bindings::PCI_CLASS_MEMORY_FLASH,               // 0x050100
+    MEMORY_CXL                 = bindings::PCI_CLASS_MEMORY_CXL,                 // 0x050200
+    MEMORY_OTHER               = bindings::PCI_CLASS_MEMORY_OTHER,               // 0x058000
+
+    BRIDGE_HOST                = bindings::PCI_CLASS_BRIDGE_HOST,                // 0x060000
+    BRIDGE_ISA                 = bindings::PCI_CLASS_BRIDGE_ISA,                 // 0x060100
+    BRIDGE_EISA                = bindings::PCI_CLASS_BRIDGE_EISA,                // 0x060200
+    BRIDGE_MC                  = bindings::PCI_CLASS_BRIDGE_MC,                  // 0x060300
+    BRIDGE_PCI_NORMAL          = bindings::PCI_CLASS_BRIDGE_PCI_NORMAL,          // 0x060400
+    BRIDGE_PCI_SUBTRACTIVE     = bindings::PCI_CLASS_BRIDGE_PCI_SUBTRACTIVE,     // 0x060401
+    BRIDGE_PCMCIA              = bindings::PCI_CLASS_BRIDGE_PCMCIA,              // 0x060500
+    BRIDGE_NUBUS               = bindings::PCI_CLASS_BRIDGE_NUBUS,               // 0x060600
+    BRIDGE_CARDBUS             = bindings::PCI_CLASS_BRIDGE_CARDBUS,             // 0x060700
+    BRIDGE_RACEWAY             = bindings::PCI_CLASS_BRIDGE_RACEWAY,             // 0x060800
+    BRIDGE_OTHER               = bindings::PCI_CLASS_BRIDGE_OTHER,               // 0x068000
+
+    COMMUNICATION_SERIAL       = bindings::PCI_CLASS_COMMUNICATION_SERIAL,       // 0x070000
+    COMMUNICATION_PARALLEL     = bindings::PCI_CLASS_COMMUNICATION_PARALLEL,     // 0x070100
+    COMMUNICATION_MULTISERIAL  = bindings::PCI_CLASS_COMMUNICATION_MULTISERIAL,  // 0x070200
+    COMMUNICATION_MODEM        = bindings::PCI_CLASS_COMMUNICATION_MODEM,        // 0x070300
+    COMMUNICATION_OTHER        = bindings::PCI_CLASS_COMMUNICATION_OTHER,        // 0x078000
+
+    SYSTEM_PIC                 = bindings::PCI_CLASS_SYSTEM_PIC,                 // 0x080000
+    SYSTEM_PIC_IOAPIC          = bindings::PCI_CLASS_SYSTEM_PIC_IOAPIC,          // 0x080010
+    SYSTEM_PIC_IOXAPIC         = bindings::PCI_CLASS_SYSTEM_PIC_IOXAPIC,         // 0x080020
+    SYSTEM_DMA                 = bindings::PCI_CLASS_SYSTEM_DMA,                 // 0x080100
+    SYSTEM_TIMER               = bindings::PCI_CLASS_SYSTEM_TIMER,               // 0x080200
+    SYSTEM_RTC                 = bindings::PCI_CLASS_SYSTEM_RTC,                 // 0x080300
+    SYSTEM_PCI_HOTPLUG         = bindings::PCI_CLASS_SYSTEM_PCI_HOTPLUG,         // 0x080400
+    SYSTEM_SDHCI               = bindings::PCI_CLASS_SYSTEM_SDHCI,               // 0x080500
+    SYSTEM_RCEC                = bindings::PCI_CLASS_SYSTEM_RCEC,                // 0x080700
+    SYSTEM_OTHER               = bindings::PCI_CLASS_SYSTEM_OTHER,               // 0x088000
+
+    INPUT_KEYBOARD             = bindings::PCI_CLASS_INPUT_KEYBOARD,             // 0x090000
+    INPUT_PEN                  = bindings::PCI_CLASS_INPUT_PEN,                  // 0x090100
+    INPUT_MOUSE                = bindings::PCI_CLASS_INPUT_MOUSE,                // 0x090200
+    INPUT_SCANNER              = bindings::PCI_CLASS_INPUT_SCANNER,              // 0x090300
+    INPUT_GAMEPORT             = bindings::PCI_CLASS_INPUT_GAMEPORT,             // 0x090400
+    INPUT_OTHER                = bindings::PCI_CLASS_INPUT_OTHER,                // 0x098000
+
+    DOCKING_GENERIC            = bindings::PCI_CLASS_DOCKING_GENERIC,            // 0x0a0000
+    DOCKING_OTHER              = bindings::PCI_CLASS_DOCKING_OTHER,              // 0x0a8000
+
+    PROCESSOR_386              = bindings::PCI_CLASS_PROCESSOR_386,              // 0x0b0000
+    PROCESSOR_486              = bindings::PCI_CLASS_PROCESSOR_486,              // 0x0b0100
+    PROCESSOR_PENTIUM          = bindings::PCI_CLASS_PROCESSOR_PENTIUM,          // 0x0b0200
+    PROCESSOR_ALPHA            = bindings::PCI_CLASS_PROCESSOR_ALPHA,            // 0x0b1000
+    PROCESSOR_POWERPC          = bindings::PCI_CLASS_PROCESSOR_POWERPC,          // 0x0b2000
+    PROCESSOR_MIPS             = bindings::PCI_CLASS_PROCESSOR_MIPS,             // 0x0b3000
+    PROCESSOR_CO               = bindings::PCI_CLASS_PROCESSOR_CO,               // 0x0b4000
+
+    SERIAL_FIREWIRE            = bindings::PCI_CLASS_SERIAL_FIREWIRE,            // 0x0c0000
+    SERIAL_FIREWIRE_OHCI       = bindings::PCI_CLASS_SERIAL_FIREWIRE_OHCI,       // 0x0c0010
+    SERIAL_ACCESS              = bindings::PCI_CLASS_SERIAL_ACCESS,              // 0x0c0100
+    SERIAL_SSA                 = bindings::PCI_CLASS_SERIAL_SSA,                 // 0x0c0200
+    SERIAL_USB_UHCI            = bindings::PCI_CLASS_SERIAL_USB_UHCI,            // 0x0c0300
+    SERIAL_USB_OHCI            = bindings::PCI_CLASS_SERIAL_USB_OHCI,            // 0x0c0310
+    SERIAL_USB_EHCI            = bindings::PCI_CLASS_SERIAL_USB_EHCI,            // 0x0c0320
+    SERIAL_USB_XHCI            = bindings::PCI_CLASS_SERIAL_USB_XHCI,            // 0x0c0330
+    SERIAL_USB_CDNS            = bindings::PCI_CLASS_SERIAL_USB_CDNS,            // 0x0c0380
+    SERIAL_USB_DEVICE          = bindings::PCI_CLASS_SERIAL_USB_DEVICE,          // 0x0c03fe
+    SERIAL_FIBER               = bindings::PCI_CLASS_SERIAL_FIBER,               // 0x0c0400
+    SERIAL_SMBUS               = bindings::PCI_CLASS_SERIAL_SMBUS,               // 0x0c0500
+    SERIAL_IPMI_SMIC           = bindings::PCI_CLASS_SERIAL_IPMI_SMIC,           // 0x0c0700
+    SERIAL_IPMI_KCS            = bindings::PCI_CLASS_SERIAL_IPMI_KCS,            // 0x0c0701
+    SERIAL_IPMI_BT             = bindings::PCI_CLASS_SERIAL_IPMI_BT,             // 0x0c0702
+
+    WIRELESS_RF_CONTROLLER     = bindings::PCI_CLASS_WIRELESS_RF_CONTROLLER,     // 0x0d1000
+    WIRELESS_WHCI              = bindings::PCI_CLASS_WIRELESS_WHCI,              // 0x0d1010
+
+    INTELLIGENT_I2O            = bindings::PCI_CLASS_INTELLIGENT_I2O,            // 0x0e0000
+
+    SATELLITE_TV               = bindings::PCI_CLASS_SATELLITE_TV,               // 0x0f0000
+    SATELLITE_AUDIO            = bindings::PCI_CLASS_SATELLITE_AUDIO,            // 0x0f0100
+    SATELLITE_VOICE            = bindings::PCI_CLASS_SATELLITE_VOICE,            // 0x0f0300
+    SATELLITE_DATA             = bindings::PCI_CLASS_SATELLITE_DATA,             // 0x0f0400
+
+    CRYPT_NETWORK              = bindings::PCI_CLASS_CRYPT_NETWORK,              // 0x100000
+    CRYPT_ENTERTAINMENT        = bindings::PCI_CLASS_CRYPT_ENTERTAINMENT,        // 0x100100
+    CRYPT_OTHER                = bindings::PCI_CLASS_CRYPT_OTHER,                // 0x108000
+
+    SP_DPIO                    = bindings::PCI_CLASS_SP_DPIO,                    // 0x110000
+    SP_OTHER                   = bindings::PCI_CLASS_SP_OTHER,                   // 0x118000
+
+    ACCELERATOR_PROCESSING     = bindings::PCI_CLASS_ACCELERATOR_PROCESSING,     // 0x120000
+
+    OTHERS                     = bindings::PCI_CLASS_OTHERS,                     // 0xff0000
+}
-- 
2.51.0


