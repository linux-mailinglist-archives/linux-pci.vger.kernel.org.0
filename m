Return-Path: <linux-pci+bounces-34146-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5E9B29646
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 03:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 124A74E417C
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 01:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E755F22D9F7;
	Mon, 18 Aug 2025 01:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pbpB/+bu"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097751DF256;
	Mon, 18 Aug 2025 01:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755480794; cv=fail; b=VC6i8iurubgdIF/9LlsMfESX/thxBePa9GVx7StT/TFLb0VaKBp5x0uoxStmgYT5KkzK1iA/BisBq0KLANUjTCGfuQWxLTncLCEGYPbstn4PV+yN7Ucu+PRqY1QBAwVa5IRFz4kttnqpEnZjyC+Qxa1ytBeepGDjhBC0GI1oH4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755480794; c=relaxed/simple;
	bh=8Oz0JNxqu27LNPFlipS5p3pEHytsXIq5CsoaOyzzKlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ym17/BLHcHponE8pkDjyLk0N8jAkohDDJkMQ6/2P5qDnzv2Q2RLYrO+zUegQ/T4PW4+D0E4Ae+VS0aOCMUpaowCpiLdTAze1JuI/A8teWUrzXXjkc8I3n+3yKWWbW0yS4eGhoPeLsB7cS991/+9Lig6/tcYOpBxIuhyg+1mGDSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pbpB/+bu; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuE48ADDutohXQygjDjNroxEpQffiO46QzTdwQ/j4iZ7eBkkADu3xa0UjpexWacZAj9Fp4nIUDWFUr0eh+GAQLlGrVSeyxov6gLIQO/0XXEYTd10NRa2jsBlc0Jyj/DZQeTWFdqSMEfP+U59PzEuezVrbATD6ZcbW9ZEhdP5fyq3lFHQUTTl88qHm8D9S6QLaVIQk9ci9BLiW4h4qZg/w/Ii8Ktwz9Zi5PWwxxhOXm44NyB99U2mtz5Uo0WG3rwAyOLcBhm1ZiFi9/x4aY7f3y9eGoPXkNgiV/MTuYNgWL4RLm2ViXdzTn0Qd3qF3bjiPcueleIQsK6FjFZEHK2wEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rT0PylKn4yeSa8tQvME1vmXinyVSWLsklioTWw4CPvs=;
 b=ZkPdkLQ38m83XPe2K4Ax3eJFxoyT3Tk8Hh5pLg4JAqrhRWGRvAbC0QIVjqyEALVudnf0PA0dI2B5l8LPfI4c0i8BpdCO0l74c0l3iIuwTh+lJ6DnL1eCrYPoVEsvBQbYmVMAfM2WuejOAQYEtCZE2JGvrC0IFhPZLS6NcdAqSdThjR47quUONB9eIYBLmf8jCTUuGyH9nq5WSMAbfz2djUJmojcHFP8zI+NnQGipsBo/PssK39fmxnQ2Qc3uLh1d6Ww+rq3pwx7EX9NWWqPM+5upKxT7cdaxfo8y2vNs9Hy3kv/COMQFvIJvE8prFbym5Zd7eNj2A5/61678/xRAMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rT0PylKn4yeSa8tQvME1vmXinyVSWLsklioTWw4CPvs=;
 b=pbpB/+buyaZqAeWhu8A0yfpswIYsR9toN3Reum4bts/cqku49k8pvuTZNgpANxeNpqh3uPsdxj8hBHZyglhjNsvPoI0q88x8Xj8M7yzJvzONpN7VJ+JMPh3Jp3dJdyOAVXnjbsLLpRJIvnho7subrtiS/MRsSlI+x0IUe6f6XcpWtcs8Z9xvbl33/2iPS9nbfm6ShRjQoRkmpQLMkzdQeEGN89jRGAxnk/rdz2itY7Cy1NnG6Xn3T/CFWA2VMyJg6GmYr5Ae2gle/d+d8t/NL3OnaY3b3SFq2LIv6krq1KQQ+g8x8Bv2Gchd7U7luXlWXCF7vEEGzuxSkWtBzO1mKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by SA1PR12MB9513.namprd12.prod.outlook.com (2603:10b6:806:45c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Mon, 18 Aug
 2025 01:33:10 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 01:33:10 +0000
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
Subject: [PATCH v2 1/3] rust: pci: provide access to PCI Class, subclass, implementation values
Date: Sun, 17 Aug 2025 18:33:03 -0700
Message-ID: <20250818013305.1089446-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818013305.1089446-1-jhubbard@nvidia.com>
References: <20250818013305.1089446-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:a03:331::14) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|SA1PR12MB9513:EE_
X-MS-Office365-Filtering-Correlation-Id: ba10eda6-ce77-4bb3-278f-08ddddf7310c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?niWZCt592J78krWghojGrXH9AS6/KvRqFOMXDoOFuZnkoxuMVNMOrfXG93Wu?=
 =?us-ascii?Q?VXzKUmOnfbXGKCKPBAM/YVUODi0wbQWj2W6GxrhexVtW+WfOwrU/mWxmtCKS?=
 =?us-ascii?Q?Cd2wk+jIbKwG+FjsJ0BaIoSOM62nTdBWXEnbN7HDzQdIqelmO1s69WZNc5hm?=
 =?us-ascii?Q?EyyisCohfN4inr6tTlXm7bcpuvq8MrBEvJLzXYqm1wikzhFiYJxk0Te5Q9P6?=
 =?us-ascii?Q?A29NBMmk/T6Zj02E5W0MRLOJgXTYWEaow80rs8AD0238scZ6ZakQZR5YpoVg?=
 =?us-ascii?Q?NLske3/Q2Ztl8jO/p1RqVqT3sQcr/RfDbD7XWqa18vPYPxchA4bIt4nhYOQ7?=
 =?us-ascii?Q?aovTHZ5fHEnOiPZDiEahVqHTsVXJ8AEZnKLw3sbhcu895Xf4CcSPW7nzzw3I?=
 =?us-ascii?Q?muhW0PmMJCgg68WLRkUQvxKvMOXURlxHmuaQv1FKXWI67C5OeDVFUOpFFsOa?=
 =?us-ascii?Q?jgTGkUIrPQgVWgNTzVVDgvwpbe3I92L/na2RDsqA9EdVZiNEPexheVW9ZinS?=
 =?us-ascii?Q?ZyhUfvscBvuA3KJalPU0nbUHhzizplvzzA8dLDrxmhncQEh9oMxnCFjd1V11?=
 =?us-ascii?Q?Q7NrJ72VZPbl3QiUNBdqdadGQnFYZ5Dgrf6bDL9RcLUPtn2ErUA7Gr4sAnEL?=
 =?us-ascii?Q?lU6pLRD5FMpRGfDohBat6GaSqF0Vf7atPEnd7dmJdupoBJ5Iec1dlFyQ4JT0?=
 =?us-ascii?Q?8PRYnDOp2bRK8kx4YQc4g80LDuBPZOK2j3ld6Abcjx2iK4FgnKbx84+FWU/F?=
 =?us-ascii?Q?e0fmQ1RT5tvnvfJyWEpfUjN5wl+dVBW7habeGzvKi1Bl3xvtoyBDhbx1+3Oe?=
 =?us-ascii?Q?wil5KfSWD4VUGM5790q3nA/nJhbaq4No/JxggN5JiaKENncYag30A0LgS6Ws?=
 =?us-ascii?Q?dtC9xh8zUh9Muo+1JESxBIixrBWkv2g+0Tf7UXIGmPbSfIRmZ16yrKrUUtUv?=
 =?us-ascii?Q?e5B/Tbt06eUUunPf9watEuCi1VtksoBNoTfHtv6ZwFwDChv5ZJzMW3r1aEcq?=
 =?us-ascii?Q?QzEf5ctXDN0wY6JPuSVnTJynhkh0k8GNRe/roZZGpsV9LYy/LS07diMEDxd3?=
 =?us-ascii?Q?nn3kehJSfvrA8jb0HETbtRA0pzu7N1OgLi5pFK9+j363ke9dLLBywlgqkYyl?=
 =?us-ascii?Q?Zg++KpSDJQBjPNQgSurYcT8CK4rMYGY5PpIPl1zyft7eDyJc53fj/4hA3XIy?=
 =?us-ascii?Q?ar9toaM6t9reQAmNObXHJFnzBvUjp77B3neGMrMa9w/jIXJztMmb+IGQWNIg?=
 =?us-ascii?Q?MKLSTNpzglLL0GwWOeLbLTdx1XzhUqwfDOgHIRtCoHP3yLuJvcz7PzDS5kpU?=
 =?us-ascii?Q?bTKXs0Y0X4BYpdMEuXtJq8Oq4uBNw8jmI+S6oIw7qOhA2QQUPMO7iE96jBET?=
 =?us-ascii?Q?WwhStEAr5ouC7s8FWhNKkospWsN658yFqGo1weiNoNOCD2WhZ8Ytkgyrpq27?=
 =?us-ascii?Q?Sn0BWkqMepM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+S5MjIHdGbYgOIrGgkK9Ti7ULPvdhckA686Tx6HE0NhwfhOcvYMyF4aCgHVF?=
 =?us-ascii?Q?XtbzBHyDlH2CFMX2F1s/JbsvNLi9PFvy/41G8G6Gob/HNXKaXlgiBEoygk+S?=
 =?us-ascii?Q?I2PB01sWcDXeqqAu2w4N2JmaFPOrhZDLTVweefxl9aSuJlHDpS8zDePFto8K?=
 =?us-ascii?Q?DkjZ5FQx2O9XFOW1OwZ7n4lJ1Bs8zf8o5laDoQ4h7sirsJUpQmmsdHqB3ZF6?=
 =?us-ascii?Q?J2YMxivy4C2R0dSKKbwkjiZY2jukZaYj39bmoMrXnnRPxcOc+nmTdI0iaVwJ?=
 =?us-ascii?Q?8OzBISOXChbtT94YyzJFcqQvyxwlsZzr8N37iVxgJIrUejasQ6OM3SIFPoXV?=
 =?us-ascii?Q?f1IITH0FSQ038Cjsm2IVj3EgUEo2Yop351JBRcSSyZqrWgrj//O/XzZkptzh?=
 =?us-ascii?Q?MrUDVHjAh8JqcCt080wTJg62us2VsatKZyH6LxpnXM4o2hg2bMdvw4G3kEjw?=
 =?us-ascii?Q?ZBvbKqQXNl4HmXifscLPvt9cUTfrBdGiNMS+9P1DeqR/UzZo0nQQsOy4e5U5?=
 =?us-ascii?Q?IQF6oLBSTKDmzvyoEICQQEo7Dqid2R/0xRv7B4fdS0ODT6rtKmx+MhR14fVc?=
 =?us-ascii?Q?3iwd6P7XZAkMfkgFQ6IKpkytVxpDfiyTFicd/pXzIy9CwmR3qh7sKiLFBSX9?=
 =?us-ascii?Q?7zisdme14VQWQwP6XRRn6+G50w81kbZKr1SNkEPTUnkI35T3ZTY1TSSVGXF9?=
 =?us-ascii?Q?pxw7XSMP1G2BNhkzKWBhCH6R856zrus0KQoVt3ULoCsugwENU2bhj+2olHI4?=
 =?us-ascii?Q?ALkx6Ka01w1tAPKvqajq/1cSOyaCnMSEJAk+er5xzGnUYCzuIdwUI1Z7i29W?=
 =?us-ascii?Q?AIB80ao9ZFqKcXmoGvJ7Vjl5bTSc+Iifc9cE/uNjSTGKCI6Tpkh+ttgTgGfm?=
 =?us-ascii?Q?c6NHnLJXC1uNVMiTP7APWkUMz3qcv+sm1dF6VTl0rh0HqRv0t92+gkNnaDZ3?=
 =?us-ascii?Q?bSl70mesi+XEaTPCP3MWUzCXrWzifCTa5xS6vSuXYXPjuwhOIV4iqjPdT1+O?=
 =?us-ascii?Q?vAyDboVpo7yZns4TRRFJ7hnlGcmfESsGV315j2wnYViWp40v8WedMQGrmf/H?=
 =?us-ascii?Q?8E74HMyuYtnbKAe9aU2nRS5QY7w2gzARPNciYikPEZ45EgTp+XadoaeJMVsz?=
 =?us-ascii?Q?NwfHbogUJs8gTj/iuDtH+MlPnxRzibTOkOLt+haypEbBh0MMD6V/TR+Ip6lu?=
 =?us-ascii?Q?706t0CDwUEr57wLTKSex9JsOfw3Wfkg19w5HGEGAE4DmcvO1VZ0er+IWkfWB?=
 =?us-ascii?Q?w6nsOu6zFQpGyRPt9pUXfk7gYfLJ9KJMn2I/8z5dNqxLANuSI30JqpHEsFsK?=
 =?us-ascii?Q?Cfi7mbLP8Kk+KxQK2icIKrpQhtO3h79gtEZhAaNKS4q/4Zs4bky4aNbZXwuC?=
 =?us-ascii?Q?8dghuRpHf4rPHKF+kUHYW770x7ueqq8+3YVhU2HLL+4ClWzEo1zhEx41Nv2q?=
 =?us-ascii?Q?0S9hO/+7ubwdPm5/Izt5syI7E3ceQHTKrHc6EJsFxQup4O/r4WKx6CnGahsP?=
 =?us-ascii?Q?0VyeYtxQ86qeflGmjU5A4ZcQPTZqbxEEU24TMEEbEPGNBLPc18/qN6iekTdP?=
 =?us-ascii?Q?aalj18KgoaNFBKPzwWxHxYuJXJ4jFGMq5CAmkpxh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba10eda6-ce77-4bb3-278f-08ddddf7310c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 01:33:10.7240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFpp1hJx2EeT4MCzwVQJum1mvRvu91Ijtx8yhVOk2XSfi/Eot43f4m7u6tfin0QoWcJFyAUFDAZwzXtws2Ph+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9513

Allow callers to write Class::STORAGE_SCSI instead of
bindings::PCI_CLASS_STORAGE_SCSI, for example.

New APIs:
    Class::STORAGE_SCSI, Class::NETWORK_ETHERNET, etc.
    Class::from_u32(), as_u32()
    Class::MASK_FULL, MASK_CLASS_SUBCLASS
    DeviceId::from_class_and_vendor()
    Device::class_code_raw(), class_enum()

Cc: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 rust/kernel/pci.rs | 202 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 202 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 887ee611b553..9caa1d342d52 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -23,6 +23,179 @@
 };
 use kernel::prelude::*;
 
+macro_rules! define_all_pci_classes {
+    (
+        $($variant:ident = $binding:expr,)+
+    ) => {
+        /// Converts a PCI class constant to 24-bit format.
+        ///
+        /// Many device drivers use only the upper 16 bits (base class and subclass), but some
+        /// use the full 24 bits. In order to support both cases, store the class code as a 24-bit
+        /// value, where 16-bit values are shifted up 8 bits.
+        const fn to_24bit_class(val: u32) -> u32 {
+            if val > 0xFFFF { val } else { val << 8 }
+        }
+
+        /// PCI device class codes.
+        ///
+        /// Each entry contains the full 24-bit PCI class code (base class in bits 23-16, subclass
+        /// in bits 15-8, programming interface in bits 7-0).
+        ///
+        #[derive(Debug, Clone, Copy, PartialEq, Eq)]
+        #[repr(transparent)]
+        pub struct Class(u32);
+
+        impl Class {
+            $(
+                #[allow(missing_docs)]
+                pub const $variant: Self = Self(to_24bit_class($binding));
+            )+
+
+            /// Match the full class code.
+            pub const MASK_FULL: u32 = 0xffffff;
+
+            /// Match the upper 16 bits of the class code (base class and subclass only).
+            pub const MASK_CLASS_SUBCLASS: u32 = 0xffff00;
+
+            /// Create a `Class` from the raw class code value, or `None` if the value doesn't
+            /// match any known class.
+            pub fn from_u32(value: u32) -> Option<Self> {
+                match value {
+                    $(x if x == Self::$variant.0 => Some(Self::$variant),)+
+                    _ => None,
+                }
+            }
+
+            /// Get the raw 24-bit class code value.
+            pub const fn as_u32(self) -> u32 {
+                self.0
+            }
+        }
+    };
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
+
 /// An adapter for the registration of PCI drivers.
 pub struct Adapter<T: Driver>(T);
 
@@ -157,6 +330,23 @@ pub const fn from_class(class: u32, class_mask: u32) -> Self {
             override_only: 0,
         })
     }
+
+    /// Create a new `pci::DeviceId` from a class number, mask, and specific vendor.
+    ///
+    /// This is more targeted than [`DeviceId::from_class`]: in addition to matching by Vendor, it
+    /// also matches the PCI Class (up to the entire 24 bits, depending on the mask).
+    pub const fn from_class_and_vendor(class: Class, class_mask: u32, vendor: u32) -> Self {
+        Self(bindings::pci_device_id {
+            vendor,
+            device: DeviceId::PCI_ANY_ID,
+            subvendor: DeviceId::PCI_ANY_ID,
+            subdevice: DeviceId::PCI_ANY_ID,
+            class: class.as_u32(),
+            class_mask,
+            driver_data: 0,
+            override_only: 0,
+        })
+    }
 }
 
 // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `pci_device_id` and does not add
@@ -410,6 +600,18 @@ pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
         // - by its type invariant `self.as_raw` is always a valid pointer to a `struct pci_dev`.
         Ok(unsafe { bindings::pci_resource_len(self.as_raw(), bar.try_into()?) })
     }
+
+    /// Returns the full 24-bit PCI class code as stored in hardware.
+    /// This includes base class, subclass, and programming interface.
+    pub fn class_code_raw(&self) -> u32 {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        unsafe { (*self.as_raw()).class }
+    }
+
+    /// Returns the PCI class as a `Class` struct, or `None` if the class code is invalid.
+    pub fn class_enum(&self) -> Option<Class> {
+        Class::from_u32(self.class_code_raw())
+    }
 }
 
 impl Device<device::Bound> {
-- 
2.50.1


