Return-Path: <linux-pci+bounces-34145-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3FBB29642
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 03:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7814E3EDB
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 01:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AE552F66;
	Mon, 18 Aug 2025 01:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gMKw6Odw"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B66D1B7F4;
	Mon, 18 Aug 2025 01:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755480792; cv=fail; b=iZQYdI3oAMQUVLYfEOyDUrcAoyERR0kPWNZoSoLoblAgFLs7KUr9NSL6eN8mgnX6RorORdO8hYaFqHHkfbKmbbv40s3BWtKPkStgUaJ4LcuVI74lCUhWy6SrrYNz67rEwP/Nk9IGfhjqitSkPcUnHmcL7QzSlESlh0yvHuU6tb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755480792; c=relaxed/simple;
	bh=wejdMQbegzjtQKMOsrsJQxYltWBbssCnuJciw50AAPI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Z5uf46C1E9u/Z+BWZkHV2PlOyibpm/sAc+hkaWSo/RrMDquh6+5yB/SuDOB//anIUG7ddeMMVw0Tos6TguHfFidGrnX1IYaAsInqy9UNKblEHObxW7TeJYQxdQ9pHR6iViC+U8Hab4W8RwFYXf/UCYAto9XsNZyiQCoS+u5VEAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gMKw6Odw; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGxYQtcVBE9deKpXQ3gvXfBulSZkUtdc5Tt9qP5BqK8zDCwoVlQvzHy7cHY/qzm7q55B7hPCdS3eFMQk8nO7T5FcRHOQEPIVsMpHesDuHXIyxZiXs4RvuctPeHcVk3Ijwux475TR0bcX4+yWFbCsOSyS3srRX74cW3J6FBBd97BnD0chbfW+mF1j4sphzcUypxg6t+jQuinC8ECS6QP5FYo6zcaTUd2vnrxhRqzkalyEnU0SFXB+PMRKfzmxYswgQkznUKuR+PCcMZQML2DwbY7iY+jU12GMYIPf+MZpN2u4iSnpQsKkF0p8Zja25LhM35l4aLKUpGpmKR8rAV7Z2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+bb0+aepFJc1j6uFctk2z6I7e3GB3JbNFX7ntVY/s4=;
 b=K8inEAx2TLm0DMyNF0275a/wI7CswOJR1pex0FKwtd+f3SeZOVaZfywpFKfnUqlE3wY/beBgpS1A/IlUlHlXAi/UFrOHE3ex/2uRpbbQaMxTMnyklIrmYCl/UhVyQRrdeqa1AyIrS3fkXNDQ7Q6+F1tPdU3/qLWbjMomUt9Q+7hhVDiWTZ5GU5Uod7hY67IvbQdF7XxG/M/cpNLxew+TndJUK5mqO8qsOJJzcmWMSeKraHj3WvCls5cbbfiufCZmAPF1EU9dpYfPeesd2THocSkCopjGLYzexiTgGKk5ohdPhwgJyUoRcL1lYXQAEBozvWPdztwhlfNT3LFWX6uqDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+bb0+aepFJc1j6uFctk2z6I7e3GB3JbNFX7ntVY/s4=;
 b=gMKw6OdwdjKDPFiPWzDtKv31Imv2HssgJFLqClwHByEGaf82ixgunYBZ02pLZO1KYHYyjKtKLX5NQNivUgGLKdFT46JZihiYHGuG+SdOzeEk/uhUaRT2odBrY7VY6by7zJIHcYkz4nQQFQuLc40iN3ByHQ9wf6F8zwLUPWpByiqWgLYS41Uhg4eYboFP4F6bj+l4diBF/Axvfo/v454eI12mPm/+hOd/D1Q5pn5g6ATo23kRdCHSNLN4stcZK1vDssXwXoMyQhf9qQtbCZLS1SPlLxAP+d5XNZR5oRF5sLqebhqOE6lNhvO6zDffmq87pNqS3iuA1heKYoC5fM9Qtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by SA1PR12MB9513.namprd12.prod.outlook.com (2603:10b6:806:45c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Mon, 18 Aug
 2025 01:33:09 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 01:33:09 +0000
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
Subject: [PATCH v2 0/3] rust, nova-core: PCI Class, Vendor support
Date: Sun, 17 Aug 2025 18:33:02 -0700
Message-ID: <20250818013305.1089446-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.50.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:a03:331::19) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|SA1PR12MB9513:EE_
X-MS-Office365-Filtering-Correlation-Id: ca29915d-0b4e-4cda-c3a6-08ddddf72ff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?efUWAg/xRarF6hc7sBkiuwjx5rglwvLl9JLlAX3togEeFFKj7yVEcMbgJMhP?=
 =?us-ascii?Q?UGs6RaGrQkSVCUufD8u1jaFazuAdlMTC5xbH5RQNi7TbOm7uVU+GjRrIRu6s?=
 =?us-ascii?Q?JT8OiR2Dg5D1qalH3yq0/2XCe8U4EtRi3FjPy6Hnap9LK0vdXaFzOYSfCqSv?=
 =?us-ascii?Q?EhB+mbNIGn6RJEv0/3tw0DvDfyTV6BLTViFJ8uL0bkcS/30Dofdt9aj/pGxK?=
 =?us-ascii?Q?VyYelXvy426YsX/cHr65XKFXpPTNhInzvyUjSbY0+MMLTlPCc2E49BKzE4Wh?=
 =?us-ascii?Q?ljzqci+7JQymDfKLLPc65Id+FeQ09gjONVAX14aOIanoIBYRw/DTJ6zrtvPL?=
 =?us-ascii?Q?t0V7tAF3vTmVpX4caACEFK2nEtdzvKz+pXetVuNAfwnx4AAtQrmQKuqB/t/0?=
 =?us-ascii?Q?urFqNUwVokt0v828lrPplJm3mTcPMogks3kYfVL6v/FxfiCGGRg9RoBFeCIw?=
 =?us-ascii?Q?WeUl3lusBbwr0CHUD9JGligUX6afp0bARDf8NPT+zVusaJxUTnW2J6oHmgDB?=
 =?us-ascii?Q?W67yqjqWnufm2wXTB7+WP2fUdEaErHw1hkPdwEkWe3VM4KYBujR6psObTUIa?=
 =?us-ascii?Q?6UsZX7ehoaS/1/WMwecySC9j1kfG9c6fWwhAuNQ5ubI68SAuMwZeuEVDcFCW?=
 =?us-ascii?Q?IEOfDLxsHqSpCJrP/hIodO4X6eRHl21FoU5sd3//SDWQg+TAtUm1b/D9ND6e?=
 =?us-ascii?Q?VXyLIVJYl7LZOQJjROUT5Bb1c9zThp0tNDhNeDhK8Dccj9YF99mZ6gajy7Dz?=
 =?us-ascii?Q?Z6g5gC5Wjpct6CgOGccmJUksET5EmBOA9mo8mZn0qijeu1X3FMKcWwnqZ32F?=
 =?us-ascii?Q?0t4F1Wc5+XK7Bv/iR+3Jwdsqivoi3o4qXshE7c4D06x2k1ewb3e+IWACgYIM?=
 =?us-ascii?Q?MRjXgUYwY4xec64VbgqeJAeOX3xCPZJ7su11Xe4K1si58aWxldJrRLSzQCPO?=
 =?us-ascii?Q?lFwCcahWOWO8HTsc59uC2WI6qd981IkWPqQ+fQSlDhD9KdkaOxZ3iWPzXt1Z?=
 =?us-ascii?Q?n/9jhqR+eWtDPbl0skzqDt20nCaBFXpc/yCQuUSg99cAuQDdDLXRjyPY4cz8?=
 =?us-ascii?Q?Ca31pSlEzVVFZ9EQlUo1LdSsScJhuvmFw84dHWrK/8RgYHEwcNGPr2VzLN7I?=
 =?us-ascii?Q?vmqVe+2lFONzbZLrPJ+SKTySHwDkf2nZLhdgQP5pN7v99k2edCbGkxcx/HLy?=
 =?us-ascii?Q?/UKR+SfPE+errbUG/tLv8gfRLUKg0gB/PESneZFuFKCtOzfTCqiVKAiB3l5O?=
 =?us-ascii?Q?p18lhzy1vBo/84t1nmga70p9eIYuGsf85k/t9yMmWkPWM5Q9MdztBPc2hdql?=
 =?us-ascii?Q?tbj/LGhMhE74uZzh2njgezOqkiVLcBozAmuEzCCOcZHdktRik7FAdmcCjqdW?=
 =?us-ascii?Q?G3QyJHWAlzfsD+7t+gM+cuFxwEnXc7wuEiWkX2A3hfDcetQtJgnjLeQFg0Ps?=
 =?us-ascii?Q?Vi41vQ4ocBQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ktVJNtm2okKAm4sXWrDx8T/90rlX2ngGD/TIGSpvWeV+wASt6gXRciyzP/N2?=
 =?us-ascii?Q?cX3GoY88M3NAOGYI/unNB/ntSRXbEBQdzVVm1nj6K93IowUeUHFFFrFQcwZP?=
 =?us-ascii?Q?Igx4nYmkOElSQLLHD/ueq8hlZvyAiAqddbwiMMF2oHNOYOafZFk8eb5fZRic?=
 =?us-ascii?Q?4VENW0Zn5DOSx1EVinL4mxgepYAgzk6Wo+EnbM2U1lJT5N5a/OQvQ7y4bOHb?=
 =?us-ascii?Q?6jI18DZi53lcdBdD8iqTvUVya4Wkd+2h5czb8tPhKeHQT632NADC/q37fipX?=
 =?us-ascii?Q?H/E6qdwNcEyIfY2yUR79UQn+5KsXYcFl5sXu5fr4UW5B/7Uc37yDV3h/3ZIe?=
 =?us-ascii?Q?XA8GJU6FXDmDij94NBOlJvzgbpMWaEzIL8QJthldPX0dEwCNeSvUZwZRBOf7?=
 =?us-ascii?Q?emg2rt4CAYxUknyCd1ip+qMzxGv/cYR6K8/vR8OOp+M2dK95np0lzEkt0PgS?=
 =?us-ascii?Q?FKT0DsWmpLL75deK+2ip0H7s81cD2s5cN+UdRwFzJhw31WtWVIRfI2E9zj6p?=
 =?us-ascii?Q?oFnY2uhggy1kXMC5pCwSlf7Jg6agxq9Yd/9b2NTZw3nPm/6O/B+5hlzEF0zf?=
 =?us-ascii?Q?uPstAnAHEGoVTco7vjUfJG/Rr1DoDyQdSIG8t6V21cO1VTzI5ZjbZTuKRAU/?=
 =?us-ascii?Q?LvxwFhz/ngcBYmDsC2EHbcggj5X4tccTVenLSoSKt64M8Ig5yF6uBFNIdRF7?=
 =?us-ascii?Q?TBrj0ddbzhjGKWTmhm1HcuEfbd+bxbzlHMVZHZNCkbgISsbfjp9VO6zoLcqN?=
 =?us-ascii?Q?o5lwu40wlJdzLqoOhspnWyewVSXeABqg+F1FEn2FRUQIVM0CvW0u4dgL+fKH?=
 =?us-ascii?Q?tPX+6gy9yrqYqA98CRbsAeCiXwXMtgQjtxNlg2l9OhNoKGwvhavkK+zHmsO9?=
 =?us-ascii?Q?YcJgSgHM1PN3f6WVtSTGswH5LpBIEeUrPS52UP+UUJ2niBgV5rZSSNmBTW5b?=
 =?us-ascii?Q?MO9yIUmdHHaYvI9zjdggyx+BZ1b1y/f7DImnh8qVAD1hcLEmrrtIbvDYyYd5?=
 =?us-ascii?Q?4rX+Tvh7xly0s73oz1uxhhDr3Z4XHZUu/BnRXmes24wc9aciLGUoSkwqJSJ1?=
 =?us-ascii?Q?mwAD+O3ULTu82yCoUm/nyLE5Ph7q2hlKNntCdn77xZVvSVvlj9yvP+/fJ6Zv?=
 =?us-ascii?Q?vmsIS6lLj3tAQH/orPZHEnQ7ftbVN+VI4luoG5xpYPqS8eKFkx7O7YjAa+JD?=
 =?us-ascii?Q?V0QIFWkHIUyUEUNQhAqCBHswFcfrh8UtygKQ3YB4XAYLtUH3A9Bscj3qamaj?=
 =?us-ascii?Q?vknCUA16ODQFJNOgpq4jt1mzfpGQ34PMa8e5fjsj5NGRQA3Q43EeKbOFwM6Z?=
 =?us-ascii?Q?OT3LAk+yuxoyWiAonhEhf/JGuJvS5KxdpoxDYxAXurgArskV1caO2K8WjcPy?=
 =?us-ascii?Q?fYhIhzf+6xsH9C/NlC+XUXfG2N2RzBIwyR2eEC7fnaSJzWwyBg0N8JpU3CW7?=
 =?us-ascii?Q?PUqnQbThOBwPpBTOk8szFbnYzVOC6KD34GRwnaejlEhhqofzFVVaX0CBhUgK?=
 =?us-ascii?Q?ie0y8/yrffQs3HNSaU3oLXmITxPdfLGPZiUV+hSucguS4v8tOdYXyPFd7QIv?=
 =?us-ascii?Q?IMLO84e5XozjvPlddNhj7sxKIfhHPUegdBeE5OOM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca29915d-0b4e-4cda-c3a6-08ddddf72ff6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 01:33:09.0104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7o2aLbb9OMrIefj7zyASMUJK07BQLe0dGnmMNjlVIonfbXOVY3wpehlrEaMVVB0mVSVBWxg/Z+zfBjZRyZ7a2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9513

Hi Danilo and all,

I'm quite pleased with how this ended up! The new code in nova-core is
nicely readable, and now we've paved the way for other PCI device drivers
as well.

Quite a few "use kernel::bindings" lines were removed, as a result.

Changes since v1:

1) Use the pci_device_table for filtering, instead of open-coding
   filters in the .probe() callback.

2) Add PCI Class (class, subclass, implementation) and PCI Vendor to
   Rust for Linux.

3) Rebased onto the latest nova-next branch, which is here:
    https://gitlab.freedesktop.org/drm/nova.git

v1 is here:
    https://lore.kernel.org/20250813232859.224316-1-jhubbard@nvidia.com


Cc: Danilo Krummrich <dakr@kernel.org>

John Hubbard (3):
  rust: pci: provide access to PCI Class, subclass, implementation
    values
  gpu: nova-core: avoid probing non-display/compute PCI functions
  rust: pci: provide access to PCI Vendor values

 drivers/gpu/nova-core/driver.rs       |  33 +-
 rust/kernel/pci.rs                    | 525 +++++++++++++++++++++++++-
 samples/rust/rust_dma.rs              |   3 +-
 samples/rust/rust_driver_auxiliary.rs |   4 +-
 samples/rust/rust_driver_pci.rs       |   4 +-
 5 files changed, 557 insertions(+), 12 deletions(-)


base-commit: 0dfc23ac2c5b3a62ab27fb9b6ee582b4bb5ce33c
-- 
2.50.1


