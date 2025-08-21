Return-Path: <linux-pci+bounces-34427-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C901B2ED1D
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 06:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB3D2B631DE
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 04:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5533B2E0919;
	Thu, 21 Aug 2025 04:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FwNLdvXP"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DC72DEA9E;
	Thu, 21 Aug 2025 04:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755751341; cv=fail; b=XC9Llq2u/wLpYKb5uizLyNwpFbXxl4zYjpAgZpsCaUVQIDrELJ6cvlBr19KSckh5jJbu1oVXCG930K73jcB5sNX4naSALxETzgLNzFreUon0nnhLK3T3tnU7lov3QNIYUMU26Qj2vjrvlsiX9gQqS8uDeRgtS8z0uOa+OUvXNuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755751341; c=relaxed/simple;
	bh=KPbSH6G8RfMAJeeiFhciEDtFDQotaM4Y953OXo0Ve+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZZe00EDkT1UJCx+NrM/lAWVUXF2+gAoaIEdYeXD5GYdJs+C1K/483lU7e98tZ0CyDhEjkvL1EbHbma4/1014DfpgKITeEcKSEu7Hv2Njzg33drGMcZiqPusWAzoChtN9I2S+9z5scJRev94oRHLp/kSua8ROB+wBywdA3P+2po0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FwNLdvXP; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pcqHYEHP+hHLw16J2xg+ZLM0YiCVtd8y6gwEkFgy7VK/YLxIXNaWiLMSbdqbvWshHPSDLYVib8ud/iyjPeJo2p9QNsbt3T3KvWJIBK+dRKzLb2fsWBfR8VeE4JtoSK6nH7MQT/TT64DZPtLGsI6iaKD1fqDO1jBQx4W6/jiyjWpX9IQXu9wOMrChHfmPdEYVe40QkjE0CujnjtqtHcjiJtgoHcScXYGgKq2hWw9dUeoPbo4pntkyfCJg2G/r52fk+GIZqy7Z+n6WPwiCxBGPjRrqMuivg/XdlkuE0X47ZDRyWacvtrcExG07VyQZpbV3YCCIrs5S7FKMfZeurqo5tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwcVoIiFz90fEbygT82/emIxsyy11uu40QeP9/daVGw=;
 b=uKNvVLFk/+/f9JRIOPpSf4mvH4BbHmh5kRasuvtI48LPXtiJZq3k5qS1Wy92YCW/rbUioE3aTTcrHYABYOGSe8JOQ1q4qVtyrdGofTJGh6dM+mKFjPYlQUPrsbyelMbtDVoYKBE19AjcVW0wLLzAiHQF/+2EFxjFK4Gh8dAd2D9LbscqOTrekcU1v4Wwf7QafdFPpTysfCUXqQyPd9MuqUjugHVfed9ozMJqoKwHKOJNO7XrpiFDAVIs/2/z392L3QmcHrnhuBg+GaqkNeTokHuJjlojoCaDHzaQEABAZlOzmi0ApvKbhvSz9DTbkUCZUq3jC9Uapzij0hgCpiEnng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwcVoIiFz90fEbygT82/emIxsyy11uu40QeP9/daVGw=;
 b=FwNLdvXPz4+fw00atiCxSmThw2op/v26p7lzNXYxHq5X6ICveGqvBtSBNWcjkQLZVFNxLlW7N3x3yeRWFzT27NyzQQjc4VCRgG86I/VrRrYFIyu1KbMBGLsARmmW/vepPjwTyDupWZ6/8IgXvTG7Fcia1iLZUJN3bGtwpVVRnTjEPscocqxboQYrcyC6Y7jY8gQhzHZYPhEM3e5ndljuqfO94fea7SWaloW64i9QoYTGr+N2lNfeci7npbxB5r+0l77/gy4tv2QupsT6I1nXVdZdnMehvvT92+UYw0KGzLAHE0AG8kajCYNCvhU4EMfPxIMeZeAkh2glVhl910Esmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by DM4PR12MB8560.namprd12.prod.outlook.com (2603:10b6:8:189::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Thu, 21 Aug
 2025 04:42:15 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9031.023; Thu, 21 Aug 2025
 04:42:15 +0000
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
Subject: [PATCH v5 3/4] gpu: nova-core: avoid probing non-display/compute PCI functions
Date: Wed, 20 Aug 2025 21:42:06 -0700
Message-ID: <20250821044207.3732-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821044207.3732-1-jhubbard@nvidia.com>
References: <20250821044207.3732-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::32) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|DM4PR12MB8560:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cfde08b-9882-43a6-c175-08dde06d1a3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NdXo7djIl9R7pE851AUJGp6N8S4aZiXetXPEG/mpkx3ZZly4p3sKlgF5Ublp?=
 =?us-ascii?Q?hlOdpoYhVdbQA4AP5bH/kou3fKsGcEtvGXX3UQwB0tE6r821OkIthb18yG9z?=
 =?us-ascii?Q?fHG9BEX+fGvv5OLHMeMAeWVFRz3hQm7fcsWRaO2V048RfoUFEacwhVOgG+g+?=
 =?us-ascii?Q?kxMQrVpqu0fA8dD73iam9DUUI5Ex7ZbshlD55j+Lve/klXa3CyibhNScjiiZ?=
 =?us-ascii?Q?4C8Pg5EX/SMGeMyYpK5TiJWX0LRm6iqAEOr8wx5p74JWKoDmh7duiZsd58fm?=
 =?us-ascii?Q?hDnw46Bdrur4WE2UKnteCFoQFuuyJSjGhYBSLLGNKTrf5859FmkIfEgyrL9s?=
 =?us-ascii?Q?ebzy6CgrrtJMGgtL56zoR4l0ed7LKdoH4sAmv1PnLzYJtA/NRjbgQrtS0f7z?=
 =?us-ascii?Q?TY9Fi4EowVVZyuQ6dP05tNPzvUSoIwr/oLNhoYbJs2sCbzsqJzISdcc4Muy7?=
 =?us-ascii?Q?S1LAP0mgKEw7OSMQ9cCFGYhp5ebO63aXOXZEU7OleNICLQjq4u95o5xYeUjk?=
 =?us-ascii?Q?hmVbGTUTiZiByvuHmjiZD6OtqCYnBLWHsQxlfH7cPWeSCCrt4H47zymxCQUZ?=
 =?us-ascii?Q?UelYpE6Jmckl+ggB23X012fywCk3op4r9j4ZxTybYPsAGbFAvUtgvzzxcSeh?=
 =?us-ascii?Q?0ygKzqMDM5UTD28OtY7OgXlWLKwIGDrtY0/NYQiHgCCjwD1WinT5wMeGb70V?=
 =?us-ascii?Q?0E3wMbqMovJ60Rth2/iPa+BaLAqnSj5BrE7GRuML3wjq6/C+quHbvR1jvWw0?=
 =?us-ascii?Q?RVn/hisRQY6te2acsJXTWjPqAt40nerSZO8qj3Ue5O4I8kFAI7LXn39oyTZA?=
 =?us-ascii?Q?XHuQoFggWJQ1wv/fIu8fIk6Hi4BOnaxceXRNMACz0T9gN5IHf8aw/EM+fS4L?=
 =?us-ascii?Q?QNv65jIolrKmKQM04Dxp8pqHPUE2rHFda0qlXRD9qPjTkZU1JSCc9M7zkQfo?=
 =?us-ascii?Q?HiqYXuKCHcikoQiBl5zm9yHd69vqM/iOJN4RXLv4W2rhfEYCsyvr8JIhbBJn?=
 =?us-ascii?Q?eHLztCn1YZKTXd2CdXI2R4RYUxZN83DGvl4lvcSOyOuaje6xTXUaWTQnNpOp?=
 =?us-ascii?Q?34YBvuQH9Orl2t1MNqSXyDUu61aFkvcxi+lpxWK8ZyR8P4YLa3N1GgyZdALn?=
 =?us-ascii?Q?aoN+nVR2CyEcyBIDj4COULlj4tNgbdhfHRaK2Wr9cbONHvQL7QMi1vrjxGlw?=
 =?us-ascii?Q?m/udkrRJFztDQH8FMv2o2KkvZnxTfCB91jJriCPd6ribWeLvFiVpGy6OtKMz?=
 =?us-ascii?Q?OfhntEqistpMIGzQ8NAWrbZ+JvFKJH+fYSqh7fQzD1ZmgI2SLYUh1xW3lECb?=
 =?us-ascii?Q?ynhkWen3qSvL8Quo00Dzy9thler4x7ya7fucQQ5eGqaV15/8wWkqjMGXpiO/?=
 =?us-ascii?Q?Gr9Nxsiq5VWa8KildT7hguGixJdhCetzfiFW0JsOJc1MJiDufBWpw2m/aiM5?=
 =?us-ascii?Q?numyqQ4goFs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R7h/G9SphVwA5knDKMVbbOinKu+ofa6eXuwfZIqpwc3sthtOjcEHjBET7bFC?=
 =?us-ascii?Q?ZBc7MehNakK8YOk6cIntdwcw8rlnlZZzAL8dY1Rx3UR7ehmdQ443Q82Rgib6?=
 =?us-ascii?Q?I/Gq+xrVqEA9GaDv7uwoEFnD2REEvghMTWGOpudopl6j8vyTpgaermSsiEbG?=
 =?us-ascii?Q?MubO0glQm3o7mSWrlvDe9SOmAvJPwrRxNh77qOOhJqSbKHOND6vC6tSkDDLd?=
 =?us-ascii?Q?zTwLXq+Kwbh5XFYy0zbTYvDZXZauuaB0lV6alB6tlPkEcmaypt2Cu3XzC++o?=
 =?us-ascii?Q?D6agCRObPx0t75JWeFKRx47UgK/WZVu0PSWJpYfR1DI3CR4+npuxdk/RdJ3G?=
 =?us-ascii?Q?A84xRNGIcaSpf0fa7oAA5yPsEGdU5yXDvnFoplQSKDIIMbnajYmpw7DS9ijr?=
 =?us-ascii?Q?AikvlfwdnXjpyWphnEj+lcE1uYXv37FWJFZAoJ09DKJvRT8vbehR7Soj1Asm?=
 =?us-ascii?Q?R8bFU/B0RxSe3FC5EJhSH0v94b+yhsH4FRH8zamdqNDLkj7LQKKzPDwT53CF?=
 =?us-ascii?Q?3H+07w3B9BriQl3RfZKF63Im4xvksUmTVRDzrV0rVsVEqxz6Xb7zFQYf+AL2?=
 =?us-ascii?Q?2H7pbvFsiIESQQD1uT9gl1KwfI0b24yNiERkoE7pyb68HTNXKEa/6m9305KC?=
 =?us-ascii?Q?6+xnZirdieosplyMtj+JPf86wSTeN66d5SZzUHQ2CjtqF6TUraHDZ4R5gOBo?=
 =?us-ascii?Q?j0Bj6h2bpQY2GnPrzYQJCVl//EABy5Sc/sl4RpYmbCl73LCIvmd0Smwk6tQv?=
 =?us-ascii?Q?8I03OkkvQUARCQhCNAOtTRMqRYY1T8ubMk/pDGcVU/mCaG0PuY4ca2E/Hjfy?=
 =?us-ascii?Q?WwBzjutiRW5YvaNdffaMb9BbP92y8z2fB1tk4GxwGHX2+X6lQSCbKqp695wy?=
 =?us-ascii?Q?xjS6HfcQB4Nj56bF682q1ZOQoOGS6tJBHLowhpsoLG2+kskcZy2nMOeTsj0z?=
 =?us-ascii?Q?NuG6vaREDGeoejgirUPRAb8CGkGVPlcg88zqm1ZMNm//0dU0DvmKyf7zwkPk?=
 =?us-ascii?Q?q5Jb/obAbFV2Z9Kn1EYoNapNDKhJJcUJMQY7C9EMPlV/x+3fQkxLb4qq6zGn?=
 =?us-ascii?Q?Z+yiG71G6uhww4QBhLJHc/w1LCyxavaYg6+sCxWBzYqdIyg8C3Sh2GC+jxW+?=
 =?us-ascii?Q?WclaYo6BVV7LLKaINB9YolGaP6YXRq5s2P6CP47YYU6AlJ9BxbsUgP+1bR5K?=
 =?us-ascii?Q?4oAPF0J9BXBy7FDpAFpZ5XC+7X72FqVJjRTwHNjXQIINYcbKG1mBuv3UZ0TT?=
 =?us-ascii?Q?uPbuL6pjPbst9+D/iumUCHBgc/CO0iHhpcGzxn+Q2w09+w3yHgFU4IRxono+?=
 =?us-ascii?Q?T/3sCV1Bkp1p3d+3YstJ3uuyUFI6CMYUrhR8dHg01b1KPm7PXVEKEU2/DCKZ?=
 =?us-ascii?Q?j+4EfJZuTJc+RcbjWA+72erWaKF1ne104or29a35Ay6LSJ7wt/bKnaNxHbh1?=
 =?us-ascii?Q?9mJXEVa2g/s5jgT2aa0VLpWE5FhNb/+YPoEz/J58CSy6QwsbEO8PvluNDQ+D?=
 =?us-ascii?Q?el9toHWzkk9faSIsmldVluaXxDeXVichie0/CHx67PQ72oaLrEBImJ5Lq7We?=
 =?us-ascii?Q?AZBTk11RPUcHyDz/zLj6ol95VjdfVRxg0F8H/2H1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfde08b-9882-43a6-c175-08dde06d1a3f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 04:42:15.4707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLQdtR5WyLMDd5h5ktqQEWSRoyWMVjtkcpTsXf8mypZC4FNNBqJTQxvzwPox1c3Gq6VM9EYpDdiZXJexDHtMvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8560

NovaCore has so far been too imprecise about figuring out if .probe()
has found a supported PCI PF (Physical Function). By that I mean:
.probe() sets up BAR0 (which involves a lot of very careful devres and
Device<Bound> details behind the scenes). And then if it is dealing with
a non-supported device such as the .1 audio PF on many GPUs, it fails
out due to an unexpected BAR0 size. We have been fortunate that the BAR0
sizes are different.

Really, we should be filtering on PCI class ID instead. These days I
think we can confidently pick out Nova's supported PF's via PCI class
ID. And if not, then we'll revisit.

The approach here is to filter on "Display VGA" or "Display 3D", which
is how PCI class IDs express "this is a modern GPU's PF".

Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Elle Rhumsaa <elle@weathered-steel.dev>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs | 33 ++++++++++++++++++++++++++++-----
 rust/kernel/pci.rs              | 21 +++++++++++++++++++++
 2 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 274989ea1fb4..5d23a91f51dd 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -1,6 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use kernel::{auxiliary, bindings, c_str, device::Core, pci, prelude::*, sizes::SZ_16M, sync::Arc};
+use kernel::{
+    auxiliary, c_str,
+    device::Core,
+    pci,
+    pci::{Class, ClassMask, Vendor},
+    prelude::*,
+    sizes::SZ_16M,
+    sync::Arc,
+};
 
 use crate::gpu::Gpu;
 
@@ -18,10 +26,25 @@ pub(crate) struct NovaCore {
     PCI_TABLE,
     MODULE_PCI_TABLE,
     <NovaCore as pci::Driver>::IdInfo,
-    [(
-        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_NVIDIA, bindings::PCI_ANY_ID as u32),
-        ()
-    )]
+    [
+        // Modern NVIDIA GPUs will show up as either VGA or 3D controllers.
+        (
+            pci::DeviceId::from_class_and_vendor(
+                Class::DISPLAY_VGA,
+                ClassMask::ClassSubclass,
+                Vendor::NVIDIA
+            ),
+            ()
+        ),
+        (
+            pci::DeviceId::from_class_and_vendor(
+                Class::DISPLAY_3D,
+                ClassMask::ClassSubclass,
+                Vendor::NVIDIA
+            ),
+            ()
+        ),
+    ]
 );
 
 impl pci::Driver for NovaCore {
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index d4675b7d4a86..504593c882c9 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -161,6 +161,27 @@ pub const fn from_class(class: u32, class_mask: u32) -> Self {
             override_only: 0,
         })
     }
+
+    /// Create a new `pci::DeviceId` from a class number, mask, and specific vendor.
+    ///
+    /// This is more targeted than [`DeviceId::from_class`]: in addition to matching by Vendor, it
+    /// also matches the PCI Class (up to the entire 24 bits, depending on the mask).
+    pub const fn from_class_and_vendor(
+        class: Class,
+        class_mask: ClassMask,
+        vendor: Vendor,
+    ) -> Self {
+        Self(bindings::pci_device_id {
+            vendor: vendor.as_raw(),
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
-- 
2.50.1


