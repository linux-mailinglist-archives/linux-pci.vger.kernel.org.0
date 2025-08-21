Return-Path: <linux-pci+bounces-34426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E87B2ED20
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 06:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9470D58665E
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 04:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E0E2C11C1;
	Thu, 21 Aug 2025 04:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YMgCm4uw"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1556D27A108;
	Thu, 21 Aug 2025 04:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755751336; cv=fail; b=deQ4jknOznb4OzYSXt2zqO2oexTQltC7unEHu9GYYicnlqb5L4Jj3Za3Z1CgyiVIM+vsAk2vA1Z7nsFrv1vCgKDu5Nx53w83qYPnT2R64KIqWZoYCm3j1MDNlqNrsjKo9SKFshvsX5dJHagkgz20jXO84D+fULjhlmsyIOPVLqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755751336; c=relaxed/simple;
	bh=0KJuPnnPwEFkd5xVKePT/NmqhE3yPcF/Vz4i8Wdybkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FjuweB+kTP94bdaz2H+L2XPCEVAucjP7aU/2tjbOa1LBIZeVOuk0sbExE2Z1jk0af+0k6JX/XZcV6xJl7HZdiCjWsHjLOUUl8M1OKWogEeZYa0K4iJC1OgzG39AVqvp3oZCqt3bV6XWeyjYnlEYVtuNzNSHOkL5LxGOdBJltf8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YMgCm4uw; arc=fail smtp.client-ip=40.107.94.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PeIVI5FCBXX4vf4WW4hOq/kGhACf7bIIR96M0qIlxqOialVXxBOMGS3RCEtEX310Uchk555AHUkbItusu29AP9XV2PfAzcyYV2N2ynCoeUyfrIOcBH32JiNOxf+BPmzV8Ee7LDfkcW/tkdblCuO9fhhLz5QJgwqwOZmcMPu6wsCtGCjXQc4lEElPU+WFQTs94xecpnsl6v2Gl+EexhESi5WKfPwbepqW6j4DYm4vKtpeeLvqQyBxTltDiGTQ621fAbHCrBpZe4w2RPIgSzdMj/bkzqMzlybOi6FUv9hdQmPLKSmh8spgWIiK0IxXOQv3Rf3o/wtpXxT9UDPGHeGkPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVVpvpMnR93tEMYydQCkskHtGaSBs2KXzuHbaXHTdXg=;
 b=wIwDJqH3nbCxxoftzakDGPyR6jn1/mvZpvn/jvQRARVkscz6Rhpp+SKEDJu20jLAX85gdbS/RlKmcV/Lopbx6b3VPWqP9c5HTjyhqrYZm1KpF2U7oeuGjhc2ae2Dh6OWTwh0/20KBe5VrgKhTUsukFtpVDijqmluNHVsr0RhCsDwC9u0YAq21vTnjw4ONypWYkZmBREtciS63g4bjoJdIfndeaVofrQDTvHw9JrkKOQGkJC4WFzzk74pQbygCBP3cmZqqceZs/UqkZxwj8NJQfKFa8lhHGQA+STYcWXIzttjFk0Oelk4LCMXry9mErhlnkbaNOOWAgFp+y5gmnAiEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVVpvpMnR93tEMYydQCkskHtGaSBs2KXzuHbaXHTdXg=;
 b=YMgCm4uwD/XvRHde43NL9K42p87FoMl85W14x5oloObnX8RxLtx4ZSQZjOv28VC8wCMexanIoRFJaQNB5XCup2CrGY/H+5LC+l5Im/EIYChjKB+bNV/W/Njr091wsk+zs9wdl1SbsJOYJvJ04krXIzjzLJY+WXho1OJoPAa1mb8TVMn4fNbgMXchtlTqB85SI4kqEkzqW9FIHv55sxAVGr1wfZuSHS8yu2YcA8shWyVVe6779uhwcZvSdR5rJ54ZP5epOkSw/oJlr3isntJ/D2BO0wo/JuxOHs+sTYvE0k5Buo9+OHwZWAaJd69VeiLGqt6tAlMpd80WNGUHEwvJBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by DM4PR12MB8560.namprd12.prod.outlook.com (2603:10b6:8:189::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Thu, 21 Aug
 2025 04:42:11 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9031.023; Thu, 21 Aug 2025
 04:42:11 +0000
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
Subject: [PATCH v5 1/4] rust: pci: provide access to PCI Class and Class-related items
Date: Wed, 20 Aug 2025 21:42:04 -0700
Message-ID: <20250821044207.3732-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821044207.3732-1-jhubbard@nvidia.com>
References: <20250821044207.3732-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::22) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|DM4PR12MB8560:EE_
X-MS-Office365-Filtering-Correlation-Id: 960f2f96-dbe8-464b-47da-08dde06d1815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nCmAAb4+Xg6LOV75j8w+sw3toTZDZZxHQDoo+zoZxjAj+FgfBgkuCtr61jPi?=
 =?us-ascii?Q?5IrmmqZAnSiALRZjKdLlAaRvkH7QIuKnhEQVSn7KJiM1/EGLFAaSCK10I2Lo?=
 =?us-ascii?Q?3BdWuuc4xflJOQzNniQtmVEMp74cK6boiehYllOQyv69bv638qfoPZtK8lxY?=
 =?us-ascii?Q?iaxv+beOO6/ZWHV+XWlVSrjF3+W8zgC4p0KmEfz0+0IXjaxAMaBNfrBzX2NJ?=
 =?us-ascii?Q?Zez7lfopgPkfRt2xB36mCFACOl9NbRuunNuva0ybu1wL6a5u0wGkVtrnvY3g?=
 =?us-ascii?Q?s7ngidzjJAZm0NzjjJV544jtGeiuUUVFFQvUpAvzl3El7k0nd2UQEApCEJn8?=
 =?us-ascii?Q?kuYap3qnEBWkXzcz5DILKuYZpQN8V5dTsIqV3lWlvdgsuN0Mk7iYg/nqFwG+?=
 =?us-ascii?Q?fSokNniwPGLq8AP6Yb7lnUM9yK1oktD4uG4j7clSDr+kh5rZIt63YrBJCXk9?=
 =?us-ascii?Q?45RcoPynNzuaoYvg/6ASPqFiZ494qFnIiiG958ept3lzM8iXCd0UwZFdedHM?=
 =?us-ascii?Q?9dvmg8uOlmWCIhsaijoBA+wFOXWRLnzS7+BR3cvTqX8ahsQwPnOVDzBuPP32?=
 =?us-ascii?Q?1/PTCWPWP+RQXVNQ6WDaztsID7PhCOCPyISeQq2ZI7uv6iWWJ8cYyg++QmRI?=
 =?us-ascii?Q?8ugkki4J0KYMEwGVr1Z3Juo4JQFsR4thP23V2uCb9rlbPL5UKFZubSU3d63Y?=
 =?us-ascii?Q?Y8GBSI+DbvzTia+jjzAPZObYTxA8487SI3p+sqBKsm7m/RaAQ+4IwnzzO4ZO?=
 =?us-ascii?Q?ZjHu2LyCl0MCXWK6cJdq4WLV37kWfCRirxrLfn7mpvOOa5miSCD2CcBdo0EY?=
 =?us-ascii?Q?2EDly+xx6/NbO5+TQgX6v6jfP80+FbxdD17XorVl/f+c0DcgoIylYFTUNbis?=
 =?us-ascii?Q?Xsn3iaiYMONiJrf9FXljpDr7o7ITChkd2pKSVVyEj6/hjiQ0z03Hsnw127qV?=
 =?us-ascii?Q?oJL7vk1qKfrTFtZeIwBRIt6n6+/ckzg4dC8gzTmMUJwNAgHQK1vbokNvGUOF?=
 =?us-ascii?Q?1PhGWGzufBHCNUJ+MWRn0t0Tzeurtvj0Gao+JH2xDAKs3s423Ii1gj2X8o+e?=
 =?us-ascii?Q?AZs9YQDTdxlTGNEjF7TxYx1T/Ev7EEaWVQ0MMVU/JXMthUbTBM1noNIS5BD8?=
 =?us-ascii?Q?WWHElpum6CEgvk8glm8Jv1T8C2TnSNcZAF1XfWipvbJB+qFomY9uAzc1KM1N?=
 =?us-ascii?Q?Xwn400O7YqMN5mfT29MHtog4cKuqCFqe3mIPBqtbzFhxmfVXk7YYdLY8y3AH?=
 =?us-ascii?Q?XfqoBaxazZ8Nw0//7osVjkKOW1QiYhd+4arv+vt3BLIs/HRu/sDfLztotJHU?=
 =?us-ascii?Q?5kwro/m+SqULZWoyPwrZai6YIzd5qD2o1lsOdORx+aaz1F5h5NzM1LmmfDJX?=
 =?us-ascii?Q?YzcxGJrAuvgBscvM1AXkUlF3EYVgrHBE5dxLSuQGHSIQhEApvHKT+pFC/iH+?=
 =?us-ascii?Q?+5GgeWU35dg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0JOzBZlSvdI/g+WdjWtuQUrEqHIwQLo8poABLm4ylcHs99rOPtiyZRY7UhSj?=
 =?us-ascii?Q?M1Mm+h2c17riPeXYLgupOGO67UTTDwsWKp/chJ725/tCEy8g9Jb1J5ClfLSX?=
 =?us-ascii?Q?wDkH7XgguDdHR1CHE2QbVsR18v76LKGy9O6s7+xRaKbSI4/m7iTGzQjA8le3?=
 =?us-ascii?Q?NthOlzkWYjTN2TRyQmGFV3KHH6Vu952fQZDYEurJk92lxHezJoFTaog8Ad5U?=
 =?us-ascii?Q?nDVrca9FOkLyFRmFCEqg8f9egBvxhHr4bGUlCYMrTKTNJg3152XPYeRHBDNE?=
 =?us-ascii?Q?8rux7wnTo6IHxlrkvTGPQw5Ah8xuu5fZwqsiD08yKCVJfZbYb7nodEkrC/OR?=
 =?us-ascii?Q?gBmVdF/+/ZnkLO0qg06rTTj2LT7L09ucJba6w5EyTv23iofQHGrL4x4TzPBZ?=
 =?us-ascii?Q?JAnn0rSlH49qP8VX3Bct/Fli8+Yh3584F0hSRqpk/jH+RuuwXdPlwdVB/+cF?=
 =?us-ascii?Q?ugKC6+1ldCBqoIT7WlLP3BxPKqRlClaWFxEBjienwhgEFh30AkKgP5xu0/Yo?=
 =?us-ascii?Q?1Sr5TaG/5ocumYPMWH8knkCP32WocUe3fuWMxK++Kplgz1bQVTul7w1YpXUT?=
 =?us-ascii?Q?WXJ6+Z/a858Gy7T497zz2GViobHCLCIJ/ZzOHx9FesU2XxU2bdyDw88zJKLC?=
 =?us-ascii?Q?93dZJOYgkzz9/kDi2uH8xAUUGx3EoO52wLb9U2Y0ffweEK61f6b8XwErV6Rk?=
 =?us-ascii?Q?YqvqOuS7e9Dm3C9Ko5k/8Mxy3MR2+LqM36UrOKing0QxuOGMj6oRZRMsT98m?=
 =?us-ascii?Q?1swMfQC2qcTvOZBpXKH6vA7EP59eUZ4V9px0odCzhKLeLAS6N4N7KmcfwMcG?=
 =?us-ascii?Q?dniPUBNo18G3JRsY2RzKk/934DZeHhppMhV46SY9G173pypthqdqHBS18y82?=
 =?us-ascii?Q?D2tuCizrqt8OarZbG/MCEpEqU12JGSRvK/f2N4dAUh3YbgauZMLzbZdO1AyX?=
 =?us-ascii?Q?53EaDkwUK59SmigHiQY/REtMoG+voMA/EtH+8rjZRUSWMQzdEyjsES+gOkgw?=
 =?us-ascii?Q?APfWYQSXrvdUUQnncd3jfGdTzqpKYUX8anBktBDp0HIiz4kPbhQmvfC5iXCA?=
 =?us-ascii?Q?Q2JK1aJ+ozWm8LFyFcdZE8JzJjjLgTOQBDLhZOfrkSyLnXE+O8V/hG273ugf?=
 =?us-ascii?Q?ihuT8YYoGb1FqnLBRIBOO0LQymA3I7sUDymAjz7FnINqS/SguBqaCjC1LsCM?=
 =?us-ascii?Q?W2uvRD/zvLt+KxdnDwWi35ccHn/1bkADU/KAGx7v0YKhUzehEVA47N6WqfDS?=
 =?us-ascii?Q?1zs3jdO+5XfSd0UBi6TN4w+xyYFdf0knLNsfRnXmn/ToBOECq/YEgeuMriLq?=
 =?us-ascii?Q?M4NfduICBZYfNhVCc/a8qWJkCtk7LiNqBlBHqYwJ3Q27j/Te5Q3/kB1Igxni?=
 =?us-ascii?Q?y2a19t+l2Ls0ALijAP9WG9B/xmfukf0XHiPs3uNCO8SE26sTPpcCurPTp+du?=
 =?us-ascii?Q?aig8i1/mXeZr0tUE5diLCucnL1UoZwwGc8vTupTJtBnJ+nxX4ZUfhxuQCSvu?=
 =?us-ascii?Q?8OKPNVOibFeur3W7E8O7RRYT/pw2H5/OBNN03bH3FYFw0mcNaDCgjP2hWwPE?=
 =?us-ascii?Q?h9Uzn5+FpgQqj6RC3WEc02E5Q49t2oYpoXkPfTl7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 960f2f96-dbe8-464b-47da-08dde06d1815
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 04:42:11.7955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQwtlMucB0xlEoFUK69Gp4AHzfii19RtC/dRi0g26CqM7DGTf2GVOzHkBIE4Xo1/m4ZBuUgh+JJx13DRuWsYJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8560

Allow callers to write Class::STORAGE_SCSI instead of
bindings::PCI_CLASS_STORAGE_SCSI, for example.

New APIs:
    Class::STORAGE_SCSI, Class::NETWORK_ETHERNET, etc.
    Class::as_raw()
    Class: From<u32> for Class
    ClassMask: Full, ClassSubclass
    Device::pci_class()

Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Elle Rhumsaa <elle@weathered-steel.dev>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 rust/kernel/pci.rs    |  10 ++
 rust/kernel/pci/id.rs | 239 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 249 insertions(+)
 create mode 100644 rust/kernel/pci/id.rs

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 887ee611b553..0faec49bf8a2 100644
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
 
@@ -410,6 +414,12 @@ pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
         // - by its type invariant `self.as_raw` is always a valid pointer to a `struct pci_dev`.
         Ok(unsafe { bindings::pci_resource_len(self.as_raw(), bar.try_into()?) })
     }
+
+    /// Returns the PCI class as a `Class` struct.
+    pub fn pci_class(&self) -> Class {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        Class::new(unsafe { (*self.as_raw()).class })
+    }
 }
 
 impl Device<device::Bound> {
diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
new file mode 100644
index 000000000000..1291553b4e15
--- /dev/null
+++ b/rust/kernel/pci/id.rs
@@ -0,0 +1,239 @@
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
+
+        /// Convert a raw 24-bit class code value to a `Class`.
+        impl From<u32> for Class {
+            fn from(value: u32) -> Self {
+                match value {
+                    $(x if x == Self::$variant.0 => Self::$variant,)+
+                    _ => Self::UNKNOWN,
+                }
+            }
+        }
+    };
+}
+
+/// Once constructed, a `Class` contains a valid PCI Class code.
+impl Class {
+    /// Create a new Class from a raw 24-bit class code.
+    pub fn new(class_code: u32) -> Self {
+        Self::from(class_code)
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
+    UNKNOWN                    = 0xffffff,
+}
-- 
2.50.1


