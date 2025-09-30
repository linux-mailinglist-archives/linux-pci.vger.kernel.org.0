Return-Path: <linux-pci+bounces-37301-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1465EBAEA8F
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 00:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C463C3A83C7
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 22:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDBB2C08D0;
	Tue, 30 Sep 2025 22:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XgLa+ZiP"
X-Original-To: linux-pci@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012064.outbound.protection.outlook.com [52.101.43.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5FF2C027B;
	Tue, 30 Sep 2025 22:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759270092; cv=fail; b=L3U55Ubl91IFZ4CG61QigrVW+BxQrvOuFS/c45gpvWhIMEzKff8MQL0++QIXrfTFxIIMGI4KxyMwUBnhLSQK/i9X2ijFOBkmcPP34NAG1IDcF5hHqPNxehn6B/Aukmx8H5ID3QUjYHeHJ7I1/LPndhCQWVB/eYxHjmnMTIMUVWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759270092; c=relaxed/simple;
	bh=AAtZPp1aqr28N5wbX1Hd5yUUBqHdb7FrEvzpsSU0lrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iA65eoCwzA18qXfxh3z8Ao1GgeQwhmvI/mRxEt3aNKue+vYVxyTjQlZ/j85r9PMlpp6v8mfpQ81x12X8k4sSlLUvhkx1J2D+LbKEOO8KkeMEV0BCAkFdeFsBkbgZq/V192tCAvvn0OiXaIc7Daa1qbChRMPiQe6JKdP4dw9I86E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XgLa+ZiP; arc=fail smtp.client-ip=52.101.43.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L54pZuA0oePzTDFobcQHGnoCFBa+zNSffsgIko1hLgq7E/3mH1oiQsxw7tDH9JvL2Z4lWpeLB04j3K2wlMIIG/14TVe5sGR4XLJ8L7Op6BAHhplphobI4GAS1Z6BhV0YhOqk1cCmpR83epz/kjEhdQalBXWcgIVVhCMk7imhOIeshyAlDImdvgf7RbodpiVoJE2K8cZEgJZBU8z8IxbE4JYnvVuMWG1hPie6PoDwtPmptfUoai2tH5GP3SqcSOAtzX8nJBPluFaNFYiAuN1EgX3SMtV+/xcd0nI921UG2aY3QfnndM1cePhVcBBp/Yc5rVe70s6be5Odu/bFFQ+mpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jLaFPpA3z1GzDhKaP8aV61ttgygjuGDUKzJ0az9+oI=;
 b=bW5AlyQOrHpawaZ/6Q3oYqqBdqFu6cQsarX16rrhIioZQVJt2z1ELZMnK5aQjvqxgIHC6T0ttaGjnhuKXk7l2+dXCU2XKCs9kXOklKhJPb/9v+UPSVBXsmrPkXDJ2E7R5gx+EAElIVJP/L9v0Fd0e99a1pR+xeYCsMY7Z4gUjp8KARm5Khu17Ept7FuETC8yRmh04H4/K6NnlTLWbw4wNFHPkz3+HFSiMWrgX4JGCecx7KSRvAQQQPnQsn5jt7Z8zcemJ6X8z+lTAEQElRcwelOvPagLklQRAi4IwIXVBqBvt4tSelxN1Sfqdn19eWfsSuOTGB9bGduGLEgenxmG6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jLaFPpA3z1GzDhKaP8aV61ttgygjuGDUKzJ0az9+oI=;
 b=XgLa+ZiPkveh0CnHfTrTAW7V0kzxwTlv6DfAUv4uhkbTUJUXUG3AY1z4pMNpgOgnJ+gpkrJAaRQ8IdlqELGuy8Eq+2IP1K8oHVChDqirkuxSdGo8XLKGxLi91N1bf4vqtYBeJ+ffLBenn9jmxmsmlL3+O9/Wd7KEFpktD0tSogUiaU/jFpWazsckmMb9iy2SSVulK6ywSMWoNXN0V+JfAtHOlsPaJ78JSDLsSH8/R/kGfjAUeG33Fq/jgLTqrD7jgaDv3d/FcpCJAGu4qjJQLORjiNIJ7BnnxC8KAiUqdkZJU58BA9RbPPxHuOX6GYu2P5LlVmGd5x5xt8E6U3ChCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by PH8PR12MB7373.namprd12.prod.outlook.com (2603:10b6:510:217::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 22:08:03 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9160.014; Tue, 30 Sep 2025
 22:08:03 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>,
	Surath Mitra <smitra@nvidia.com>,
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
Subject: [PATCH 2/2] gpu: nova-core: reject binding to SR-IOV Virtual Functions
Date: Tue, 30 Sep 2025 15:07:59 -0700
Message-ID: <20250930220759.288528-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930220759.288528-1-jhubbard@nvidia.com>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0068.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::13) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|PH8PR12MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f96d83-6af0-4b89-b396-08de006dd384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5ocX1cs5nQjjFX8XAyBICqNvNhkmriIPSi9qSxfvxVE+2O9C5QmBZbC+q5mk?=
 =?us-ascii?Q?/99YEUuy2FsoVOTWgePQVtT0cIdyEM6VWrtrVft7wDa5tCM3hUpI7AlfFCZv?=
 =?us-ascii?Q?NlaQHBlyIDfPnL5jTt5tqjfomL6BFCbzA85CGtQvBBEwT01jyf9ti11Vx0nK?=
 =?us-ascii?Q?b9jum5TCm+rDY5w8Yjn7LmFHcrgoILTxgsf5alvhMsg13GEWiYLiDAF0RFS4?=
 =?us-ascii?Q?fx9eyKSg39uzesFmb+IupIN+Jn4XjOg6IlS7qvDwX293iUPkGwpHI/GN9m69?=
 =?us-ascii?Q?af79uVEBAQFKUH0e211xwjWksvyFwLfZHehWqxcFfhpYBeNhncKFuRuCxgBO?=
 =?us-ascii?Q?Xwt5ZC0kpZlN0fg+E2FKf5wMhU3c8x6zctb6eqS3Z/X9ed4aH9ztLW23RXrK?=
 =?us-ascii?Q?7rVIhTp0/y5yifKQHDOpkINd+CAWDWUUauOUSvxaHBWuZ8hCo4+nZA8ImEQ4?=
 =?us-ascii?Q?DDgdX8bwk1w542kygt8mZWFyNuWG55s+94mvhYmF3U6w26CRkXOqk4gt3HlX?=
 =?us-ascii?Q?xw0zDDHKrz7Yp+Y99A497QYYcBGQi9P9sj51hSE5w0hB+RqpGq4PUGDqygOp?=
 =?us-ascii?Q?lW+TgnMnNDVm9/DRKuGJMF6HQeqMGhSZG5qhInQsjc0Tymjdzs2/I1Gf6dfb?=
 =?us-ascii?Q?3bb0HzCst093URAvs/wWemJ0efIgrCwJN5q1L8iPPbuftkiHvQVbV4dTLePW?=
 =?us-ascii?Q?1o5BRyyJEicpbn1tnffF6spxkss0cuapzcFBX9KYx1WVfPH8LhPBesyDRhkI?=
 =?us-ascii?Q?OY3J5QlotitdsNUvwvlUQSUxruFMSemoLLUHIeDy30i8Yr2t0rD89Ng1INQf?=
 =?us-ascii?Q?Og8oD9gUr3rhZvqjw195lGnw2RAyoytF4h6g65Jw0+Q6FWRe+4bmviNbfuBC?=
 =?us-ascii?Q?mZ2U7Z7L6EGPrVpQ58+sk+oIZR0rX5YLXFf5Q6J8KQsmPzUQHUkcBo06USqk?=
 =?us-ascii?Q?9BarinSyLKqz1hmpj8o3cfzJDddHGntPR7hN5fhcfj8sb4eQ8z4RBv2fdG+E?=
 =?us-ascii?Q?wA5OyGW7UWaazU8V1SbCiyIgor4ZIEiRn2WnJWNIbzdM2xcQEtiqWPxfqFWR?=
 =?us-ascii?Q?vfNVsfIMsDxlJJaZ+jkkfCbDaRFJ5x8tkUv9tD2rO5ByvWPNH4NB0QLytjCw?=
 =?us-ascii?Q?R18I2iBjVEfz9FdGu++3pWWCMQl9gWkSZPCSPGObf98eM45SHNMU0o//9GCI?=
 =?us-ascii?Q?xx5+h7tbGttX19QWda+hO0NVSndJItQHHqB67CPXIN0BsQOYhA6bSlmb26tm?=
 =?us-ascii?Q?lrnqrS1vRxF07psYb3CYmryYF0QSjMhyIw9dX1sHHd0/K9hL3FSM2hqLoUZa?=
 =?us-ascii?Q?JDm6eAZvdMVizWLHSvbvx78cgFC9aA5gc0zfY2VXvhDbJNGznqpCD9KTTwMa?=
 =?us-ascii?Q?n74H1xhbhFrOCRo8e9ITDTT8/LxHtVc+MI2OERwMLDzrSZHmqoLLrYtPNzMV?=
 =?us-ascii?Q?8Y/YqhiDNdT/1VfRN2sp8HNor2kigcI4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YcUqBtX3NBq2rlGcH+u8AwR0ayIaFSeHm4Xuq9XrxBgYmPRgabq73jfknEi1?=
 =?us-ascii?Q?qh2gzaKXiFXL5RPGx6wF0WwKdWR6iD9d6xYrrulHOrWV6c/FfF6O9ASAIr+O?=
 =?us-ascii?Q?5Hl2LQGq6DceE8c3gm7HvEUUYrqmJje8AppeZeYcEcW685+p95jXOjlIa7dQ?=
 =?us-ascii?Q?wOMBvDjSl8sHcnShRtm8EHi5xGWOlYisPKub6/HFIoAa1JzYIZmTWNOZ5mJd?=
 =?us-ascii?Q?TgmrV8GYrunqtun+I+g5JeRT/yQsacD1hi8WZsSsNLvltn3m2F2JXQGTRQNd?=
 =?us-ascii?Q?6nB6H9LJBYRPimcxRpFp3CltDCeJLh1oiH68jsOn9zGkvkYPGts2u1DacdGl?=
 =?us-ascii?Q?+2MuJv50Xapx1Y/BjpUzRexdIev52lLh5Wu0Ki5SgEvy29eKyKMtpfSPkCpB?=
 =?us-ascii?Q?fh8IL+BgpSM7S4ZoNnUvs1wccm+bjELZRWJ+Ysivi6ruWQL6Amr5dSZgZD4E?=
 =?us-ascii?Q?yZqTipQCvrsrtJKOE1YFjVDvKl/o8htA1krnxJh84j/eAECBVtfAbXgXBP/i?=
 =?us-ascii?Q?NR24qvZnQlEHynacaVwJPrytj8C1pPhY6MV0icgXwMI7+5ehC/N/2VoeWrYd?=
 =?us-ascii?Q?iQdMnharHIuD1wpMCnrjaovg/EEnAfkE16OVTPO/nKPkRwhtnIcI28zflo05?=
 =?us-ascii?Q?BdGdfrfaAKAzZwJKqqVfgUqZYWBQt9g+raZOzkfEYVLKlNQoYpsy4Zvofi/E?=
 =?us-ascii?Q?GK0HpT0AZ8ewB2kvoTNlvfki/FVn6OwyI2Sp+keVEPljmXCnbb4syhuUMXni?=
 =?us-ascii?Q?ogRcn+gDKeGekWDTSa28mxqKsJCRr1zRPY+ZEQ93gEJaiVV5CF0wzCf3hj2J?=
 =?us-ascii?Q?ChQgHI5lkJK0YW/Bm3W/6L+6JfTxa3IzOpfImX0kSrTjPlobb2Cg0IdNCPCU?=
 =?us-ascii?Q?A9DwcMRqq6XFSlxzxklCrTqgCgMmIFnPoOlQ3gMpMKHHXZXUL980L+HaFczt?=
 =?us-ascii?Q?njq5Rq7Bmal17/C58n+L47ernPs9kYsBKU+PhSlB//Jbm2b3LxjM7xpJpwHI?=
 =?us-ascii?Q?08297KgPeTcigxQuquOft7nIknrWYxRkgfwxGwPTb+oH5luzPsnisJIOT66N?=
 =?us-ascii?Q?0b/7D0KHbKdtUUQegSFYYOJpIWtFX04QGuHm0IprDLi6Eq+M/GXwuusBJyeW?=
 =?us-ascii?Q?32t7tGRi/9XttWffxSuK7mJljn8sWyN6uOpjSW5ZzKslNIBxv4BunkvCcgNV?=
 =?us-ascii?Q?e8Mw1Pz9jLIbUd3cnAzhzsfez1nnD2FuHXAgJJMaZeNCtROftT21jVZAkLBy?=
 =?us-ascii?Q?hTpy6aSfr8bm3BxIJOKEd3hyUO8uM6lq1WjQt9b7am65h8E36l5m+RfIbWE9?=
 =?us-ascii?Q?z7S0th/Ztc+OGYOgV53hkSkB4V7aDq0eUpnFEeY1qrhhCDdZZ7POTsUbZeG+?=
 =?us-ascii?Q?lBnJY3Fhu6/Sq0+3QE9pjuVviEQfOGolwiysIKAs6whQSVR+MSHsr5ytJbKJ?=
 =?us-ascii?Q?OUPbG5tU6jhTIs7aCbz/PEwlqCcIgsoNH+adp3+1CuMHTvfVjy3Wf2eXMcol?=
 =?us-ascii?Q?3I4YrtSRd9U/UvTksUPH48Tp7mILE8+Tn5i6DaGnmyHybXy1l120NQtXLXl8?=
 =?us-ascii?Q?lb2p6ef2LGbOmaUjcFYM/D6Q1rNIAjaaArI+esz+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f96d83-6af0-4b89-b396-08de006dd384
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 22:08:03.4391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mvkYOiTYQA+aypmVHRcJsOJlyrPuMsaiS1DR/XChaZvPyELILkU1TaWlI2NQflR1TPG0wtDl1lQbrC9AZQU+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7373

Nova-core must only bind to Physical Functions (PFs) and regular PCI
devices, not to Virtual Functions (VFs) created through SR-IOV.

Detect VFs using the newly added is_virtfn() method, and leave them
unclaimed. This allows a VFIO kernel module to claim the VFs instead.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 5d23a91f51dd..004c15763694 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -54,6 +54,11 @@ impl pci::Driver for NovaCore {
     fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
         dev_dbg!(pdev.as_ref(), "Probe Nova Core GPU driver.\n");
 
+        // NovaCore must only bind to Physical Functions (PFs), not Virtual Functions (VFs)
+        if pdev.is_virtfn() {
+            return Err(ENODEV);
+        }
+
         pdev.enable_device_mem()?;
         pdev.set_master();
 
-- 
2.51.0


