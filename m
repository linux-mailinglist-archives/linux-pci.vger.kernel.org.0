Return-Path: <linux-pci+bounces-35156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F58AB3C4FD
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 00:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95711BA20F3
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 22:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CB02D3207;
	Fri, 29 Aug 2025 22:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e0w9lWbi"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244192D0C67;
	Fri, 29 Aug 2025 22:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507009; cv=fail; b=jNs3frRfl0eev1CDYYTGzROKNm3DnPQNfWA5uTW0DlZ5u0sVVZ77I0T9Nqb4pHt3Kq9whigxBFgqro55KQlnRgpWAvMMPn6mCOQUkcZxa2/TmSaM2VSYOkH6nFCGE1L8gDMEWCTi5HolSxQjhYFrZ7YMy6DmVF1GWMz5dygSH0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507009; c=relaxed/simple;
	bh=FZcWZ3GYkNejDWCUGd2H6RE27YxPXNgjR46/vE8cCkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rC6Ph58DDzriTuH+nQYgGwS7Hw7ZMWT9f54h0vZilrYMPquGdCsoxP/BoaZOtAo5fT0YInH84/ge0//Hkv/31SUj3CzOxsSEfubZgaO8k9Das3PIWIBoSUjhRxuQK3knvrITvzzXl3Cb8H0Cfs4b68Z8F1x21BfO3uvXtXtOhdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e0w9lWbi; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ImJH/w9A3F88cGI7arVRqrc2UJDAOLTiG961nkXTvcsrdsXz0QErnIG7D2tgAKiTB7Cv5icY26hD6Awr5PPD27e0DqmNVEtB+nvFkUqAu7tuSa0RQibf7wi/uxJ0tE6Ej1sVKk0wqC/cRLl1AhAX7mQ8Cac1rOvEbrMei4cn4uC7aw7U1DiyYsEcOaQ8U3OjMPRfAkRlLM7LZ6KIK2RNIIFoQRMRRQdjvqTsgLK1ZtrjS9xMLHFjKLSK5stQQvIkkX0RNL5GCroziT+EfvE+zEcSD5GTQq0tRsTnnF/wP4tWhSFzRaQD/RY8lkHQyVQbuR/xfjO/Thc2MbwqcmlqDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BflgXBNJ8btKtrx8LZ3QntEDwaPyewc3byNp5RBUYKE=;
 b=Kh0pd3EhGwnZZg8eOgUTu++ZoD0u1QQm6jcjagdnYye1QNYKr33/O5pLYNiHcNVEAHY80bB/pSgbEc12b2/YnRqW9tT7SpFqVJv8kO8JrR0iSZBWvsbKOrp2vvetNaHN53MHSjLzfsr2YdR0xQZYyABD8r/UQv2LuxCgVMpOolVCstBgQX/w44jcEtDc1NGk7I6/xIF2qxKSx1SsRtrH1xL37eoTlifPeu4QabY36ZbQucB8HOdbLZhopLKiWBsLnEmT2upja6LDeX5ST7YA6JTmJDSUmzO7mGhzNftpAOuu8NlU3TZ1GO43r2Ej/X0ib7GZNf4b6qjzHShpPQSl1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BflgXBNJ8btKtrx8LZ3QntEDwaPyewc3byNp5RBUYKE=;
 b=e0w9lWbiV+js6tWdMA2rZlr5iYVfiq62Po5MzbANz/gmzCLb88rG7C1JHndwensS5wqaqzmqixACnb66aJpx0rGGpDCh9DbFOqPdvGMdOlggjN8mnEr4CdW/dg8uDoq+dVAwF0Lyfhl/3r8nPixbXFaSVPXWONypHzk60AAedJITI4iAn8IUJZtMylGbmkhvYGEwZHg4IjPi7CghZ30escl3HheM7Ip17OCEj8a6O25gw9lWUuwDmfVtJdBEsbv/FzcNa2sry7TIFYHo8XPG1y85vjC8gdfqFHl5B9nRMVSJ93bZRS83Wlz3m6DCcC/W+4XSmDoFn/Oxl4C2qGWoCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by PH8PR12MB6963.namprd12.prod.outlook.com (2603:10b6:510:1be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Fri, 29 Aug
 2025 22:36:41 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9073.021; Fri, 29 Aug 2025
 22:36:41 +0000
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
Subject: [PATCH v8 4/6] gpu: nova-core: avoid probing non-display/compute PCI functions
Date: Fri, 29 Aug 2025 15:36:30 -0700
Message-ID: <20250829223632.144030-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829223632.144030-1-jhubbard@nvidia.com>
References: <20250829223632.144030-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::33) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|PH8PR12MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e7c8c3-96c3-4a95-c65d-08dde74c8617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZzLeH83CHKRrbFavrOW6PyP8c9xrowBYTFUg/XWA4jgT3NkhVVCQIy1AVImU?=
 =?us-ascii?Q?O4SY8v7p+6fXJueO6Knz92ax87kE7j5o4RN/FtvZxp9W2GpCZDe0CLU5/QYo?=
 =?us-ascii?Q?jPGPzOofz9brybcBw2Z2iaefTlxHW57KCL3ifpZ+KLnk2qFRK+IjWFBXgOM2?=
 =?us-ascii?Q?G5CPUaZk2NJ65tPFHoyYvwmO/qHTeM8B5RyDY3+h1b28Zy9bEbil0AjlioJp?=
 =?us-ascii?Q?cTZKg3luKRmFyRjXGgAGNzFgtW5Hid0slHVryI7hH3Vda+amPY7sjYKP01ca?=
 =?us-ascii?Q?dB+G6RsnBOVFc8MiUa4W3dgMP+rjwOjkHiXGMPOZ6emwRYyGsb2KobL99RCz?=
 =?us-ascii?Q?UaBClhPi7MSVzaqOHnGil8j9W5De10PZO6HBsUXlaNlZ1deA1G0uUI887H/9?=
 =?us-ascii?Q?7A+9+hxIf+eLGq3JYVqbfQEA/AN8oM/3a0ojtPjHzFCwaXamkJmpbi5eKppC?=
 =?us-ascii?Q?oThp1c/9i3FR8oty39Z+ufyW/qGBdYw1r4rsk4uc8qsezRiIYctuaRGm2Zme?=
 =?us-ascii?Q?87J7PLD28XcloHanr8af20G13y4Q0BQx8gSzhGV1bWs9mMunu18bJNz5M6mx?=
 =?us-ascii?Q?9US8tDT86C4HrQy632cZVTPW5qKtB4KTORhNAsEpgi8Qdu/dKKt5Fs6SnWL6?=
 =?us-ascii?Q?CVlwVe8TNdJmYnohYw4T27TLVx06/1vMw3B0VhbDVoIoUZIZyXA00TOefLVl?=
 =?us-ascii?Q?ckFm9u5N8QxzX7Gj5BI0ZahwYbnYuqnwpSnVHfchrfCWQopFbsi4yKMYULoD?=
 =?us-ascii?Q?jiEw6oisAE3aPx9xyCoSEeGc0rpuYqEV4EaAx1n/YEJY9CbhZDem0vuFHX5W?=
 =?us-ascii?Q?54zTAO4Hci2Q5rhXx4UDMz7DR9De0hF9PjKaxM5DS/q72/xOfsxN3t8bm+sd?=
 =?us-ascii?Q?me0pa1IGQ4KJwPLTNBb/xGa/AaF6QVEqPpEHGDYHIkJ42eUtGrIiikcrkjNZ?=
 =?us-ascii?Q?x2vaoVCZ9v3bBa6vJIdyBjXXRtUypJ5PHLSpwyz6nOn+rEE8BXjmBo7YJVH9?=
 =?us-ascii?Q?tzSI0AgcrlVCRjWwva7GwHiQ+wpdFAXRYz3yNSS5M+2ZgK5Mb8Wp2CeUZGjQ?=
 =?us-ascii?Q?m5ujXCaykR4iozBudrdWrtFwwiIgBNaJRpoK/Iyv5GQneKUN2gMMMjYU+nlB?=
 =?us-ascii?Q?5GFvf93qY13bn3jwHJ5alnEFAJM2xR4l6Fvt6uslZn7cQ7dqcnOtlXAJKdmb?=
 =?us-ascii?Q?5IiiHMtKtQ4wXAveYj+qLb17zIhD0a8Zcw1AhSOByf3A/i7TfhVNamJ7AyP+?=
 =?us-ascii?Q?sc8cAQLstJkCI7KBLfO8+EX9gzODvkXLNE56Z4bZO1NHQyR//adcKG/iMwMC?=
 =?us-ascii?Q?scoa6jbBnkZwEujTVMLnh3vG9bWCI0b89D4IykXdM6yL/gaZ6hjNsEyvjIOX?=
 =?us-ascii?Q?uoZp1E77esPT6Y1qXyMY3K/twjFkp6DUWied2ZzPYBH6QtN+Dpx2MQs8hSk7?=
 =?us-ascii?Q?sgpBzjb3owg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LprARohZS88x8Bsx+giOlaFxk+SJQY7QGaVvyIC+1Ofnd0PwLeIVvrhmUm5G?=
 =?us-ascii?Q?9QCZuaY0xKWmFScETmje60soCWYcnTUcodB+vwwOzfdiuWlDfimBjWPlCMRL?=
 =?us-ascii?Q?AfDT9lzJwf/gaLzSRse/3VMVlZuKtsd57vtNpTtIREZcCOcjJxv3Nnbs5IPZ?=
 =?us-ascii?Q?qUHZ6yu8Cv54153ORbMifHinZzwR1x+iAWztrGdjVRHQzZsFawHwyPdmP3ah?=
 =?us-ascii?Q?Qs/c0ZwD4FUHdfxoOq50XWIHQAcN24ALCdoqshMr/pJa3y1EUKKZNYlGtq+a?=
 =?us-ascii?Q?sKMy3o6r6Ygg7bMa4V6MPD9LIFRGEcwtuHc0LK2HVtrZ5/KEshr2HxN9vWok?=
 =?us-ascii?Q?7WQRs+aNZi7kV+WpnTM+LO4+17K74EseZA9k1k/GodpRsnVSPuIU/+GWgv/X?=
 =?us-ascii?Q?HOtN3xBhf0BxRgui1wlr70Mesokxbj5in8zeKkMaB8VKDdWyyatqdxOIkWnO?=
 =?us-ascii?Q?+fyooUebyjiOtAj53Haft7ZtzgAcMUA++hI6j19spQMspbcxyV7bZlXJ+0ok?=
 =?us-ascii?Q?fvlh9vJbKy7A0xb8XmCfkD3kO/Uc4vt1jK0Pn7snO1W0sPVc8KXpsqbsQC1f?=
 =?us-ascii?Q?HoBfyvcdOeebdG8A2g0sRMer0J6xvTA9JxACzrcLMYgy06+jSzMr36lxBqDJ?=
 =?us-ascii?Q?dlFOAJqKRVaT0TTSZW0OQTgpy9ITYdRGWCGXck3MYNYodouIbATAIkXym5bd?=
 =?us-ascii?Q?bRDc7MWhkcSXbQYmYb1Y1iuCut77lD35ush4MzutOz7Iqczz7LFEQp0EXmZV?=
 =?us-ascii?Q?in/p29wszfp9MI9ddOojozeNgTZJWUoK+ARxS84WmFYUwlad5ZCj7G970jgi?=
 =?us-ascii?Q?Yx1/IkRDz9nWUnGILe2Xu5NWdCPa4LCVhOzyyRqHp/hrhQcO/nKiPploA52Z?=
 =?us-ascii?Q?FzBbOU9l2XVW+xToLI77XYDXuz4HzRhnQ7ydN86oIrU19FmUPmgCGz0ucqDr?=
 =?us-ascii?Q?yMF4HERhPEjRufvIm4jaVzG/pByfkWx1sNO2gqkn2F6+7lx4DbZHmOpbkX1Q?=
 =?us-ascii?Q?bOrKLNOuCOIwYUvziN4zgNdJ4wb/IJGKfF/qaWnoBwG+nfiKExbFZW3VF4Yr?=
 =?us-ascii?Q?Zli2fBKg4nEKC6kf+T0La8Iv5hz3BENOyz497SJUTUL76Kzf67oHuqRSxd55?=
 =?us-ascii?Q?gUiCeCjw/ksM1fGnCE6FW4yVFXJbkCRhRL+xhCN9MQpgSHNW9Ren8U692m4X?=
 =?us-ascii?Q?pYQxD4bHlXyzE9D8+jXf/ddd7K5OwCwKycHC8ZKxva4gSyuDZI4GmmT9sWMD?=
 =?us-ascii?Q?wRwmHlJAKvQEVol6/3ZSZ3YIPqxrvpwzVV3eTCTurdm9TmJ6bYXan08lhH6K?=
 =?us-ascii?Q?Kiyra4v0T8Jx8wVMrCTJyrpp6FOQh4KWNFoQ7hcIAHQ1nVvMmz5wyg4nK20l?=
 =?us-ascii?Q?dml3eBbOPibG7gtxa0ZXqZJtMTB1P+e3w+4gP42SGktVIycbZqxx1U8W0X3G?=
 =?us-ascii?Q?uq/VBn2u4aqrlzyMZqa9u2Llbq52AydKT5CI1KcnyUK5N4TgjEEvrEf0n4jY?=
 =?us-ascii?Q?rkIsyNzaMUh9JPhTstCdzurRO45WOguaSM6AlFXPguKPKek/E+N+IulargNA?=
 =?us-ascii?Q?CZmJgroiDV+rSbtjAKxLEtuXC13+LqUEgpgVfd5t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e7c8c3-96c3-4a95-c65d-08dde74c8617
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 22:36:41.1586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HeY/BjitmOUTLz3e2GIEgJEWFC0+vrdD8EuwA96cawUt5sGrxXHx45kQVm5YWh/9IcU0ScAcMErblEOsi48EBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6963

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
Cc: Elle Rhumsaa <elle@weathered-steel.dev>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

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
-- 
2.51.0


