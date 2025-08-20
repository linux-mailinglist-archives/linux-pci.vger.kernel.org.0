Return-Path: <linux-pci+bounces-34333-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6C8B2D24D
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 05:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DFD91C230B1
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 03:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221E7258ECA;
	Wed, 20 Aug 2025 03:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VkS2BHaQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2887E2343B6;
	Wed, 20 Aug 2025 03:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755659350; cv=fail; b=mLJaupV7WKG35NrLkCHJUvoeD6wWP3cBz/xx3gXw1IGJSD+nFgw44avym58kwjZpY+5niKyGvNO2NvKHqBLQ7H4x2co5SsB3Kx9j0D5xAByTMeG3wMHVRgjlk1Dih0Ywf/OB+dktN9dY+Yo2rvTWcbcOx2Bq/8gavZdjalutIMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755659350; c=relaxed/simple;
	bh=SZhFc+jfoD5ZLur0hN23X8Y5vuLFdsr0dPlja9/5rSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t5O7eBJzB/4Q55mtkXZ1bkg6cmbKiwjJNTJ9lF+unYqm6NJF5D7Q/2cW6Ajc7duQ9Xnwxeg5UChI4PFGxFGyQ5XhtwmUFDmQeG2gIXWSGwe65r0HzuXMGU6FUUkhLgYTWvBh+iifkdA/6BvqUauvilP/1lAaozmZK6xQ9U/L8go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VkS2BHaQ; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqDVf9CGvWh5Xr/WdTS+3jI08Ta+96SSV93gek38kcA/ChuxH4Wm6MQnfAiBjkuCWAmk3oglk3yyO5FPqfoLexVsI/rnQTcqvJA6sK6MJFzUYBP5pcoKCd6Wekhz6k3PqvFn0q5hRDBgglqsUiFy6x2OuqXFpcQd4Ap4UcQdUXHvqzy62vyFmSlsKeQ/RPjoXv+alw+0R8HWNsmuuVVfmkE7KYt0b2o5FetLB2b+p8aQ7TIjdmzKOlrnc2w4GyqpNWIjXwlpOzwVF3hI7oImR3DskBEJ6FUt+IEIhdl0GexP9Wo8IC3ECq3KqvUQXqWfKJOnc6rH9sBrDoxBNB85fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+tAtpH9W+mNwk6c+yjINj+L3HKp0ZsZo64XgEt20/A=;
 b=NGiWZ5OKE8MAorGFOwCyz+idD9RdBgI/0sjj7AoawlbYolxbGFMj94+jNl2aK5VsqWYdBilxkbOUSMPyPKhgC5SvkcLU/LVde8Hm8mNdHRawbafnFKNqMmANZkiT/CF7fiColX/fKzIcTWo1uuTUsjBRRLh5PJM/Ts/+ztgSyvLyJurRbqRZVCh/5fyIi8HynSHG1U8TIB79ONyvWXwvyD0Z1b8wUzUQdwZdY3kZusnaO7xOa8xX1qhcHRqdMg3T/Lt+jAcmRawcz72pG9w997vCSFdjUJCsI0N7gphgPlPpjvXv1PD9a7E1lEHbUaR20Kjh9age8OzUM+7NkzpaYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+tAtpH9W+mNwk6c+yjINj+L3HKp0ZsZo64XgEt20/A=;
 b=VkS2BHaQIrEeCdHIPW/EpaYwd1V+S1RO8O4I1cGuFwPWROZltKSe+uFf4VaTsGxgv0UCvWtzMdAMRu99ab/3tFhyuHa/7BxtRttakLuZbmB0IvQT5AiHOptp+9TBHNm0iAfK5CLAp48GUDPDOmxxG8UcHYGwWA0cQGKPDlxm9VUIxLjrVUUmCF/5iJbHzHtJbKgKVOjKuVB138prBzH347GLMqSfScjqA8bTZ33/MWc2DcIziwANZ/ZX6t9+iNkf9JahKADT9EnaHJB0fkrfzAsjiUuM1CAbd9WaZCayXVMYScGoXbh/Cg8shkQNbIJzy82mHZCCL8bYOMCJpDN92Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by SA1PR12MB7174.namprd12.prod.outlook.com (2603:10b6:806:2b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Wed, 20 Aug
 2025 03:09:04 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 03:09:04 +0000
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
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v4 1/3] rust: pci: provide access to PCI Class and Class-related items
Date: Tue, 19 Aug 2025 20:08:57 -0700
Message-ID: <20250820030859.6446-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820030859.6446-1-jhubbard@nvidia.com>
References: <20250820030859.6446-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0025.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::38) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: a73ce9ab-9cb0-4af2-85ed-08dddf96eb42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5kAD7KJ9nIYY1dJ5gKQUaJhI0NNTVh0WYiD3trld70YwpY2VWCIJRJB1JRjU?=
 =?us-ascii?Q?XFX2/0Co8S9rse3skxVzlltzf2qgnjo0/3NmVnGoJxuDPN6jaqgO5XIEnKPY?=
 =?us-ascii?Q?wJ2rTc8UxV30v4KzEkn/P+KR3c8NIt/aLAxWaVWwWrDHbruU4Z6pMC9Davn9?=
 =?us-ascii?Q?9f6JoSqTJDbbsPXM8YbotBXxHjYhOmyrdFbLFtwcQ1YMh8bfEjUZO5vn0YLO?=
 =?us-ascii?Q?atgUUJeSmAKdiW2MZUBn0qcZpt0XoaQ+QuZ3kA/LPRkR1aKAez8GEvkHi3h2?=
 =?us-ascii?Q?VEfGRRKUAXFJME/hbJUezj0eVdzHCYsZ4gZhSRZ4bl18QbrXoSsDO0G+JjyA?=
 =?us-ascii?Q?ofvDIscOQXCzNH1pgtbSTVamisizgbhnD7szHD0CFq9lw9owb8ODFAldHlHv?=
 =?us-ascii?Q?FOWzc2YjC22sHh8KyW5vl2vhvHJ0izFK/btU5yyl28CVnTWDBZqZXvWkPOwe?=
 =?us-ascii?Q?rpudmiiTPWyl/ZbZ/guCUjwe57ktnxnPl9JCEMSxjohlNDP2Pngg3gbVUikL?=
 =?us-ascii?Q?f0ug/wpwSFfKWX61QIdh2dy0PTpveZLGuzOXe/t6jYGcU7XDkDINL5NquGG4?=
 =?us-ascii?Q?ztpM22WANpFGL6rJ2v3r9aPhmSb4NiwRKcncOnVuds5ozpTg9AoR6f8Kw1h/?=
 =?us-ascii?Q?WN+LHDMxMQoVj2hcEGh2Ya/7gEWYn2vH8wnaa4XvMlpydiY5nb2F35NbBUla?=
 =?us-ascii?Q?DOZ2daAAcHhOxKkhzXHNg6qQ3E5m4qJIhr+eTH6LvdrcNrJ1+pPz8mHCGEWp?=
 =?us-ascii?Q?dC/b+vpslVowRxaGnSI7FvIfEBLgPj05vE2oHYkg7lh7dbJh3BUijZQjOV9m?=
 =?us-ascii?Q?UhpeazXY+b/qco2t7KoOdETLq4EXiWHkoJxCJUaezzLNxbwWjg/BZSlCV7/V?=
 =?us-ascii?Q?/wFONlyuSOMnMJqrwLkgoyd0ujQddkTXrLt2d+2c9LHQTAqvH2TF6YQHBEDK?=
 =?us-ascii?Q?DhWmWTXsHkB8tHxgBRdf1faol1vGGTnctRcTwV09bHM/C+pE0cOMo7G82iNk?=
 =?us-ascii?Q?nSg0h4EX15QfpDxuc/aGr58nqzb+BzAhCWrV1uJ1p/Z0kNpy4MtlvzPkng+N?=
 =?us-ascii?Q?y8Zf/tlM0oj8bDdZDEAAJNuTHZzZcS/tVTFuc6V35U/31VyuFGxo578Tb2Ii?=
 =?us-ascii?Q?BiEoFeDLzmP0albLQpMxmMvrnVZIDOQ+KeBWeGXI79dAwnZ5nPozZ2Imli5R?=
 =?us-ascii?Q?azZOZ98VuoQwKHcwKi5eiJb3wxFZJjc4Nsuisjr5vp2Fby3rXOZQbMoOqB3O?=
 =?us-ascii?Q?bZBgeAP7Mlmodft0LBvaVcn6uCRMYfRVmN5Lj46jC8rrkRcPY9Tw3P14HkVA?=
 =?us-ascii?Q?1X9iFHuraZaD7QsRNMQQxRec8c6fzjJDD1Axp3Qy+nGQcjraUEWfYbZ16FPg?=
 =?us-ascii?Q?QrhawjWphd5VAfFxEZTi5vFYVBQOYQa7T26kzYdGnx0Iky1TMJtgu16Z5uqS?=
 =?us-ascii?Q?cLumDnIVfoo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UY6p06Hbwmdkwz6oFm7h8+P09E9FPSc28FDBtzFhi0ylD6Pdmn0cTJCGJ730?=
 =?us-ascii?Q?welculKTlptf/6UMmv3HS2HLlCPshinGiILgpu92cm5Qu7qEWn4elx5sTBcm?=
 =?us-ascii?Q?vdXHEfg6vR9lqXZAp27pFVUeW/x0gCddlNwt0dDu9Fgtz08Su0BI8atJ5Jqf?=
 =?us-ascii?Q?ofXJTB5pzsME9qtsgzKj5DSAv051Y+Jnae+c3yPkNVNZVcvZ/Y5XTHXpnPBb?=
 =?us-ascii?Q?BtuKZ9nCLyanU9OZYMVXihhRmesULcg8IZ9yHwambvAV4NW1KpB+lNAyyaHX?=
 =?us-ascii?Q?E3cihICI322IwsalIHr7+MEweRYhu0OKhygpM1H0cYa4+e36aMbvSYY7Dy/c?=
 =?us-ascii?Q?lmZXMNWaYTQJ/lf7diF1QnkWV0eztdKAUghIf8Y6Fd3oDjtHSFS22e5HZgc2?=
 =?us-ascii?Q?hVm6as/9Qtp8M+DAPbEbpI6uBnWa8QpgKeix3o/jF+5OIlx9fzj8rxbDzhku?=
 =?us-ascii?Q?3NVfEQ59MG8IJyMFSWRkj7ZkVxMQR3GPM19fTE3aKCK0xF9HQxsQr38pNzVl?=
 =?us-ascii?Q?DL1+nhqgWnvyrUvTKb7zufXFkz09xBuM4wA1WtYYrZ4q1UFOP44jahLiSLCk?=
 =?us-ascii?Q?5GwNimeFNKL4DJYlUK5IHnOpmC13ilHGLhYip4dOZXRWL/lefnjmKxE6kTI1?=
 =?us-ascii?Q?rosXgxh6Mwxw5YaYxMCfLLfhxn4h+LZ1JYLrMpeQ3ZcUwGzRgfgvLjdfQcoK?=
 =?us-ascii?Q?4U9h+WsYTh9oxZD5/Ku2ij+CTJtWWbwoKe7rFpfCvqVDGt5tIkD2OrmvwlV5?=
 =?us-ascii?Q?/b3RFMjV2WB2GwwZ5a1IkMjCoeTalQdmqrU8VSTvv3Ie+zdlCLfwQ+1HGRCg?=
 =?us-ascii?Q?7dN+dplVFoaE3clSndHko6DvmgTTVpZ2bSwd/Z3nSVmgFK5nKI2rCtr4CZgI?=
 =?us-ascii?Q?UtBY3i2AKPBRPRT2BC4qX49BDdgh66LFWb4E0YIJWTcUTeWVzOT/S9kkYGKK?=
 =?us-ascii?Q?HKAgqtvGORDmhMYGP8tgtNt0N1cPV41DNINo+jxA8Zc+WZcckQnW/aM7IxQo?=
 =?us-ascii?Q?bpS5zuzJ/ApJEYOiVf9hxymrvjM3Nd/0qcNM+mg3CeQO+N7ApKeubSuzm7kG?=
 =?us-ascii?Q?WWxPjo7rabBMBxhxTWRyHalBLypcPIipREatPr9GqsPg9n8T6nZvfMlr8m+i?=
 =?us-ascii?Q?FnUnRPo71DULoEQibPlDfjtYVmu02JW6mdUHDoHPqKFf6qOwGbyLqCzwTZPZ?=
 =?us-ascii?Q?73ubsZre+5HrRzAHUFtT48fhFgQKtdxtMMaXfiMAzVNaunM8jcG3gL2k6AXB?=
 =?us-ascii?Q?ueiug+Q26Sk/tKYOLaE+DuV8El25igeM9bs+cv0qYI6wvLNI7CgkfBsUE0HW?=
 =?us-ascii?Q?Y8jbGUcx5NpuI3zvr9iIGRexV9n7fHxTuXdaxpRDbZaAZN4RVebX7QfUh+oY?=
 =?us-ascii?Q?HZZm5zJ/6XWsSReFgquKfy75p9H4hBNZIuZGElck165xfMQL7xzxixnI65mR?=
 =?us-ascii?Q?1hQ8NwAyGbPyjMsOY03hr1CtfLyimpZT/SvOyB2UblvnBZe5HEF4JMQk9u3z?=
 =?us-ascii?Q?6fPjpBHmBDkKKGSZsbzgDMgIVu84Q9z54cJfNZx4TsPbuqZdbmJ29pKSv5dw?=
 =?us-ascii?Q?EsbIAm/WsaZe4Cfk5b08W3IXaqq8PYsnwbxCLoeA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73ce9ab-9cb0-4af2-85ed-08dddf96eb42
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 03:09:04.2863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7p3oDArMR5FcK32CXNFB0bRK5ZoGHNGx1k9flVTIF/xMj/cVjnd497zLerJg2eA3Bzi1h+ZKwuhzhetcCVzy0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174

Allow callers to write Class::STORAGE_SCSI instead of
bindings::PCI_CLASS_STORAGE_SCSI, for example.

New APIs:
    Class::STORAGE_SCSI, Class::NETWORK_ETHERNET, etc.
    Class::as_raw()
    Class: TryFrom<u32> for Class
    ClassMask: Full, ClassSubclass
    DeviceId::from_class_and_vendor()
    Device::pci_class()

Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 rust/kernel/pci.rs    |  28 +++++
 rust/kernel/pci/id.rs | 247 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 275 insertions(+)
 create mode 100644 rust/kernel/pci/id.rs

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 887ee611b553..ee887d616320 100644
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
 
@@ -157,6 +161,23 @@ pub const fn from_class(class: u32, class_mask: u32) -> Self {
             override_only: 0,
         })
     }
+
+    /// Create a new `pci::DeviceId` from a class number, mask, and specific vendor.
+    ///
+    /// This is more targeted than [`DeviceId::from_class`]: in addition to matching by Vendor, it
+    /// also matches the PCI Class (up to the entire 24 bits, depending on the mask).
+    pub const fn from_class_and_vendor(class: Class, class_mask: ClassMask, vendor: u32) -> Self {
+        Self(bindings::pci_device_id {
+            vendor,
+            device: DeviceId::PCI_ANY_ID,
+            subvendor: DeviceId::PCI_ANY_ID,
+            subdevice: DeviceId::PCI_ANY_ID,
+            class: class.as_raw(),
+            class_mask: class_mask.as_raw(),
+            driver_data: 0,
+            override_only: 0,
+        })
+    }
 }
 
 // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `pci_device_id` and does not add
@@ -410,6 +431,13 @@ pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
         // - by its type invariant `self.as_raw` is always a valid pointer to a `struct pci_dev`.
         Ok(unsafe { bindings::pci_resource_len(self.as_raw(), bar.try_into()?) })
     }
+
+    /// Returns the PCI class as a `Class` struct.
+    /// Returns an error if the class code is not recognized.
+    pub fn pci_class(&self) -> Result<Class> {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        Class::new(unsafe { (*self.as_raw()).class })
+    }
 }
 
 impl Device<device::Bound> {
diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
new file mode 100644
index 000000000000..ed241af07dee
--- /dev/null
+++ b/rust/kernel/pci/id.rs
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! PCI device identifiers and related types.
+//!
+//! This module contains PCI class codes and supporting types.
+
+use crate::{
+    bindings,
+    error::code::{EINVAL, ENODEV},
+    error::Error,
+    prelude::*,
+};
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
+///     let pci_class = pdev.pci_class()?;
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
+
+        /// Try to convert a raw 24-bit class code value to a `Class` enum.
+        /// Returns `ENODEV` if the value doesn't match any known class.
+        impl TryFrom<u32> for Class {
+            type Error = Error;
+
+            fn try_from(value: u32) -> Result<Self, Self::Error> {
+                match value {
+                    $(x if x == Self::$variant.0 => Ok(Self::$variant),)+
+                    _ => Err(ENODEV),
+                }
+            }
+        }
+    };
+}
+
+/// Once constructed, a `Class` contains a valid PCI Class code.
+impl Class {
+    /// Create a new Class from a raw 24-bit class code.
+    /// Returns an error if the class code is not recognized.
+    pub fn new(class_code: u32) -> Result<Self> {
+        Self::try_from(class_code)
+    }
+
+    /// Get the raw 24-bit class code value.
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
2.50.1


