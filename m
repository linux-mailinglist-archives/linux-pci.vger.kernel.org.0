Return-Path: <linux-pci+bounces-35158-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46297B3C500
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 00:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB5D1BA2229
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 22:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C292D8379;
	Fri, 29 Aug 2025 22:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DM9DqaL1"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689612D481C;
	Fri, 29 Aug 2025 22:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507013; cv=fail; b=QMbt2o5svbPq1SXNt8XiJNTSBIoz5n4KkJBvoOzVZgRopyGanJ9If42vBr1v2zLCvKlSaq0HFGwr2kL2oGyF8KbUvJTbPA4SnuegVkoY1OwIIXKh3Z63pMyEBOEYTOcu9v+JfW7LrzWpNJLvKCLtU+hWaZRBQ6zcNoy7dBzYVnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507013; c=relaxed/simple;
	bh=WMLul84FVN+7/CzXJMqmGeO44W/cVfDB+00F8u8TeKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XVM6UYBSflgmkVofsjSpkAoyJg3fAfG2eTaMRbxToqN16Jru7vnDCRlFdkOy/Dlv7YBn+s/oGjLBALgUBY6/tmsWFbbINVbxAOoy/L/n6MK2NmokcdxBRIdvs8goJ7gH7LEVOEgIgZAgH/BP+vjSNtWTaJCt12IaVG4fab0m6Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DM9DqaL1; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1F31/OZtwYomefrAmBye7IQ2giH1H5mBs9Sd7n9w23WJViUWTg8vIjF0J4DDeSwMKXwmokxVJNvA/c1tK/02ZwSy0+JNzdihIQYHXemiusfA8Qe7szn3t2qs2mlOGnqE7pCmKPPD7s6wwwsUBmAbUtkdcICmO1l7/a6BcS/x9zKm4KK2aP4reycIxNK0cQOLhhzV/LX71V/Vi6SMYfyPsABnSejV+3nYCCJPSXwJmtoeF963zn+GY9lGu/dcLzVfGwHe/BYP1wo5h4Jcy876SQtORcBKegC/R96ToBm82B69dOfpieiEkC8udpESDC5BVEtFpteYg+Mf7tgPyaX4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ky2Qo6dSKY4Ga+SaDGuMbOKGnAFyvTfBbPZDhDe6EB8=;
 b=HdiqoG8mHd50EJZdGzEDTZwvQWfbPBYZUkzvWKdPZgtCdbi6bhopXNYRDU7xzKNjHZtpUvuRUfCipOxXK/GYKBKJ3aftXtubBxD5wLBEmEhwBwfMc1V9f7opMwaqExSXqhmSMVGJUGkNi+kgxlCX5DZwXi7bPDdT6mnqTmLxsKgBw2VGBBBEwHfpBvj/pZ0NO1NMCL0oxKcZoAx88tFUpGsCtY4HxwNGUwqfSnmrl3DP3dLjw1LRz6b+gPfnl8Dn1BaJvPwEhY86a3VT93d5/cpjYF0+gsPyO7T9VVTF2iO5tqrnCyHs2U8e2O1/MiSYcZzujBnfVCtaHQnMP413Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ky2Qo6dSKY4Ga+SaDGuMbOKGnAFyvTfBbPZDhDe6EB8=;
 b=DM9DqaL1qWy4qecadVldcucEliKvZC3qX8tiVSLPIVBndGuc+d02FdlO+JPwr8W9Z8/n4jN9uDfYPFY7DAIKUmGmQiN2PFKzeXT8ErESrVFLu2uNS8mC6RkUfGXZKQZPNbuFgai1hiqjTYp3flVRSdK/KA11bgkb/1FmenIPqbRwgRRdI77omZ2qbuSmqNiCRW5p7lMc1gH9PrCF5XFcZi/aaeW6BYEOxXCx8vC6484SuV6iqNEMFSeKnZ6/AVUnrp+TFaVV7WmEepMUhgeFM2ZrqzBpV4BLJV7OAW6Z/wnoSxkGOWpBVQ65+7m/DpW57vIPlAofujMCezlj1rab2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by BN7PPF0D942FA9A.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Fri, 29 Aug
 2025 22:36:43 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9073.021; Fri, 29 Aug 2025
 22:36:43 +0000
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
Subject: [PATCH v8 5/6] rust: pci: use pci::Vendor instead of bindings::PCI_VENDOR_ID_*
Date: Fri, 29 Aug 2025 15:36:31 -0700
Message-ID: <20250829223632.144030-6-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829223632.144030-1-jhubbard@nvidia.com>
References: <20250829223632.144030-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0027.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::40) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|BN7PPF0D942FA9A:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c14e52-faaa-4fb2-05dc-08dde74c871c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZBGVf1yn8A5HSGn3gXZJdtSqs+AMeYray+g0Tpi9ZP1WFWPkf8nXzSAlPFx3?=
 =?us-ascii?Q?ZekVAhylVC7lV4+Zsw1isytraqCFTPtkb4hbVSM5puX1mcFBZvGVvl0+AN4Y?=
 =?us-ascii?Q?wMxQ8M21lO1Em0R+r2Gin6wc4JinNdpF32HgEH0cHrQrwuMDAwajDvuvlvyl?=
 =?us-ascii?Q?qmj6ePUBdOiP7qUYQYW5JMGZCxcHqgIz8vnyZ1C365g3dVgW7U1487iOh0k/?=
 =?us-ascii?Q?xbMSUDhCcMhYoVlcZZrXh1rGJtSZOIzZ0CJlzNixSFrubL3LBf9reLsy8odY?=
 =?us-ascii?Q?I85Y0/0FsbM8aw0i53WyxTV2XZ+jrlAhiP+MJ9z3qBdhO6UDLZcMeTBRuJKk?=
 =?us-ascii?Q?/66vcW+BgnUBFzLmK8EVcJAEHKqNdnvnWVdTJAgj50pkze1mpS3qKfAk7YjS?=
 =?us-ascii?Q?oBSCSDja1PR2mh+36OaOGtM/E9+ykAgpD7AmpKHAuTD42FOvSvpTvzzexlq/?=
 =?us-ascii?Q?msmP+tWt77E3CYGBEE+iQIuQUCaQYU+p/AvxO6wFhRwjb2KrgqGNRNOzByy+?=
 =?us-ascii?Q?qzR8Sc7AXzWzTx38oZTHTGwZfs5tjG4LeEADntDbtNjqJQR1zSRtFrmC25MO?=
 =?us-ascii?Q?blnw77A7Cs5fd5MkXqRVHiG2qYOg2b7yQUvmbYWvxhV3TI679FSIrUte/0gH?=
 =?us-ascii?Q?sytMK54KeYLJ54gdPcnFJYJ3VS6y1890NNUw0CVnA6FCtFn1FEuDhv2k3wQd?=
 =?us-ascii?Q?X/K5IgBb/PPKiWhcwwMPQLn0XURfyD+IHZ0ctim4fbp78UOn/3qT2Thm97BT?=
 =?us-ascii?Q?RzMcW3CWp0Gwi40J+DDiHNDSoDRTx2Zfhva53EzH8fQaOG9Okvv0+greqgZU?=
 =?us-ascii?Q?k4CPsCl3Ah38YlxowmjeRhoNVdSj7TYR3ljIPDE/tE8NWCfHjdZtMO5Io3ce?=
 =?us-ascii?Q?9HzqF23e3SjbSYEj0qP43Y497tliPAS96adz5v/6at3+VGIfL7c/4f/RMs2u?=
 =?us-ascii?Q?lBnXy7TiKMrzyO0cCBMrM+m3hxFEX8ZrXvzO4eAAQAGDB+GDAAFV6FRx/yn9?=
 =?us-ascii?Q?CMdIE1HW9P4+mHyc512qvtr12+qLH+1QeHmtS+OjtHMOd78ZEVJs29AWVatS?=
 =?us-ascii?Q?85n+7jDdsc++J0l6U+RaU1H//3KVd7e3pM5IX7xPKGToD6uGxWVHNGtvGDhe?=
 =?us-ascii?Q?260LnlYi6tqoSVF8vFXK0L0ZJi6MGrsj+tKSqXOh274xP3NvwYz+vkizWwtT?=
 =?us-ascii?Q?n0mDNOxTj8PjsRD5E2h6P68OLlAuqeRmkDIyPF2ejMp+T6gU+nWRuC1I+OyC?=
 =?us-ascii?Q?McpzNx3hkCjdXhYhejQ5/E+zfGCJIMwNvr4vobEM5B+QJFXAKzC0Xo58UTm/?=
 =?us-ascii?Q?ckMjKkH1Vwx5leTDcwzu14oYcA/jG8y5IqcRsWn+RxqrTbvuudjcXGKK0S2Z?=
 =?us-ascii?Q?KYsA1xpy7j99u33OnPiFkiWKPIMVJUmaEyVI0zoJIrficVXL1vL5bmtLYqw4?=
 =?us-ascii?Q?6E6X9zAD5+U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ys4Vlm6oTwuN71G8lMTZKibmYuov9PkWEXsdfl921QiuRC8gDZyX49anoDtA?=
 =?us-ascii?Q?0xka+CnMECc+07Iof7zaCjzDiaHU0ssNVPKw9/4VwATXhYgk+LD+bYNDsFWH?=
 =?us-ascii?Q?PjJZ+hFHo4AppdqTnQvzcG0RVqoIEJVxnF78feHc0I49vdWfXo2RhyTRS2iS?=
 =?us-ascii?Q?1cYJ08izX2FrJ2At3GcRKTaZajJgzydBV3VNAgFPGKW+/sQ62CAJQ9dO+gNN?=
 =?us-ascii?Q?5Hrt0bp2KCSaadDnQIi1ihpQDMjLQsDTdu7a5443jEjUp4+dOPS/owa8Oy6M?=
 =?us-ascii?Q?8UUf7Yy+2aKmKKuTvyfA0sg/81ZCA4rsJ7sgTAUGZ+vqcQqYkxLGALR8+SYC?=
 =?us-ascii?Q?Zz2JBw2uWNIpV794JH6n/OQuBhI55yW7KqVQr98yxv9Kq/55wu4pt4oz4+I2?=
 =?us-ascii?Q?T4cdqD5EJ/b/1al/R4XPezXhKlKgg8N5YbOJyF7noJagi/h0YwZKWNAFSqIi?=
 =?us-ascii?Q?7OaKmQDgOr8wnhm2wHHHWyL312kvGQxq+ZG2gSBYSVCBLaqNwaSFpbzpkHSF?=
 =?us-ascii?Q?ue5XSKjN7XaGVt61iGr7HoJp/FgcSsS9YjQAXRP1W6HUhBysd3Nczk+w2XDN?=
 =?us-ascii?Q?VG4Q/lEl9Q9xnF/MbtuG50gXbmdzVRK62gYzlVZEwM+NB7GovDXcru0YwWm4?=
 =?us-ascii?Q?LKZCRxlfGE3jSe3WKJrPpiaI/UC3gmEaGeubQXUiLEUDuE3L9VwFJe2hvpCU?=
 =?us-ascii?Q?DbHs/C+uTtFYzQAXDTtYeqW/hzoEasgNn42qhLfdjnTqmR56aQ9fZvQ18Ymh?=
 =?us-ascii?Q?Vw4uhdavrud7rlMObA0okAUQEfdSgdg1Evk1g5bxU3XL2kjw4FREQrCTJSlY?=
 =?us-ascii?Q?y0kjiMLM3G/fv4jFlUj/8Ol+wGtG3Id9wGM9rDS8lnRRtq5Xpx/GSs0BNyOK?=
 =?us-ascii?Q?FGle+xnsYQxJvSqa4VaL8SK73HAMTxbx0bloDtrbnXhXWvHlETb3NrBzO3u+?=
 =?us-ascii?Q?W5k7kowFukceTJNXdew8jGzeNQJWNciIvv6Y5kB1+O2IB7WcQ4RA/W4W/B2t?=
 =?us-ascii?Q?lp9tGqnNlaFIu7foySExD3Xx/BzmHW48FTanR+9kntfuM/AzoUJ3AkupGpwN?=
 =?us-ascii?Q?Bs4RpSGiY+8rdkBjcKqPDPTE37hBB8+nob3uin6sb9Z72SFXr+4WrRcttOa2?=
 =?us-ascii?Q?lPLuFGAVpR0uD/Az8rf7g8671cXxyhbD3MhzQ/e0jJJnILbJRpzi7SNrR3yL?=
 =?us-ascii?Q?D91KrUwRDNogb4EnbhM0TeNlsIWq3C/+e4EPLqKMz5l0CitLyIlP7t5AVzjG?=
 =?us-ascii?Q?z8FvJTHtxJbSzJZ+elm2934m0BCvl7Jllr9acSKWBWShVjKlAA0MABlYqWry?=
 =?us-ascii?Q?Y9nPe61a3+LWsmO5uZn47gRkAhlCPAytWN66d5aLkoX0Uvohq6HKmqNuIDeU?=
 =?us-ascii?Q?VhO7rXW0zalCZWaf7+PQW9Lojg143DnDyk5RXlEPH024OlOUnYX9OkPUXVP3?=
 =?us-ascii?Q?6aPNJaLUAROF5r6Eo7Rr/vUd1QZT3AjZo7O9hpHXFFw55bByJaLKNKr4ofcZ?=
 =?us-ascii?Q?lu+i6pQ8IS1n3FOxAsHSTTguSFTt6Dk02Am9H8pGbBheTE4gTPW79wk0bOjk?=
 =?us-ascii?Q?rwI/D9daHqjQywdjAiJxEjL3O32xr36HraBcqLDI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c14e52-faaa-4fb2-05dc-08dde74c871c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 22:36:42.9331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6NLjfCJ9lDAImmfAfcu23vQHJJL3xDgMppAQu6RzsnisBt+Ye8wXZMrBKpKbtDjTdyDZG3vXtVA/wRgUs2rNZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0D942FA9A

Change Device::vendor_id() to return a Vendor type, and change
DeviceId::from_id() to accept a Vendor type.

Use the new pci::Vendor in the various Rust for Linux callers who were
previously using bindings::PCI_VENDOR_ID_*.

Doing so also allows removing "use kernel::bindings" entirely from most
of the affected files here.

Also, mark vendor_id() as inline.

Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Elle Rhumsaa <elle@weathered-steel.dev>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 rust/kernel/pci.rs                    | 33 +++++++++++++++++++++------
 rust/kernel/pci/id.rs                 |  1 -
 samples/rust/rust_dma.rs              |  6 +----
 samples/rust/rust_driver_auxiliary.rs | 12 ++++------
 samples/rust/rust_driver_pci.rs       |  9 ++++----
 5 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 26974cae4a22..39a152da297c 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -132,10 +132,10 @@ impl DeviceId {
 
     /// Equivalent to C's `PCI_DEVICE` macro.
     ///
-    /// Create a new `pci::DeviceId` from a vendor and device ID number.
-    pub const fn from_id(vendor: u32, device: u32) -> Self {
+    /// Create a new `pci::DeviceId` from a vendor and device ID.
+    pub const fn from_id(vendor: Vendor, device: u32) -> Self {
         Self(bindings::pci_device_id {
-            vendor,
+            vendor: vendor.as_raw() as u32,
             device,
             subvendor: DeviceId::PCI_ANY_ID,
             subdevice: DeviceId::PCI_ANY_ID,
@@ -232,7 +232,7 @@ macro_rules! pci_device_table {
 ///     <MyDriver as pci::Driver>::IdInfo,
 ///     [
 ///         (
-///             pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, bindings::PCI_ANY_ID as u32),
+///             pci::DeviceId::from_id(pci::Vendor::REDHAT, bindings::PCI_ANY_ID as u32),
 ///             (),
 ///         )
 ///     ]
@@ -413,10 +413,29 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
 }
 
 impl Device {
-    /// Returns the PCI vendor ID.
-    pub fn vendor_id(&self) -> u16 {
+    /// Returns the PCI vendor ID as a validated Vendor.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use kernel::{device::Core, pci::{self, Vendor}, prelude::*};
+    /// fn log_device_info(pdev: &pci::Device<Core>) -> Result<()> {
+    ///     // Get the validated PCI vendor ID
+    ///     let vendor = pdev.vendor_id();
+    ///     dev_info!(
+    ///         pdev.as_ref(),
+    ///         "Device: Vendor={}, Device=0x{:x}\n",
+    ///         vendor,
+    ///         pdev.device_id()
+    ///     );
+    ///     Ok(())
+    /// }
+    /// ```
+    #[inline]
+    pub fn vendor_id(&self) -> Vendor {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
-        unsafe { (*self.as_raw()).vendor }
+        let vendor_id = unsafe { (*self.as_raw()).vendor };
+        Vendor::from_raw(vendor_id)
     }
 
     /// Returns the PCI device ID.
diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
index a7712df1fc43..47a3595e75be 100644
--- a/rust/kernel/pci/id.rs
+++ b/rust/kernel/pci/id.rs
@@ -132,7 +132,6 @@ impl Vendor {
 impl Vendor {
     /// Create a Vendor from a raw 16-bit vendor ID.
     /// Only accessible from the parent pci module.
-    #[expect(dead_code)]
     #[inline]
     pub(super) fn from_raw(vendor_id: u16) -> Self {
         Self(vendor_id)
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index c5e7cce68654..f3385c4a7e5b 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -5,7 +5,6 @@
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
 use kernel::{
-    bindings,
     device::Core,
     dma::{CoherentAllocation, Device, DmaMask},
     pci,
@@ -45,10 +44,7 @@ unsafe impl kernel::transmute::FromBytes for MyStruct {}
     PCI_TABLE,
     MODULE_PCI_TABLE,
     <DmaSampleDriver as pci::Driver>::IdInfo,
-    [(
-        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
-        ()
-    )]
+    [(pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5), ())]
 );
 
 impl pci::Driver for DmaSampleDriver {
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index f2a820683fc3..55ece336ee45 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -5,7 +5,7 @@
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
 use kernel::{
-    auxiliary, bindings, c_str, device::Core, driver, error::Error, pci, prelude::*, InPlaceModule,
+    auxiliary, c_str, device::Core, driver, error::Error, pci, prelude::*, InPlaceModule,
 };
 
 use pin_init::PinInit;
@@ -50,10 +50,7 @@ struct ParentDriver {
     PCI_TABLE,
     MODULE_PCI_TABLE,
     <ParentDriver as pci::Driver>::IdInfo,
-    [(
-        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
-        ()
-    )]
+    [(pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5), ())]
 );
 
 impl pci::Driver for ParentDriver {
@@ -81,11 +78,12 @@ fn connect(adev: &auxiliary::Device) -> Result<()> {
         let parent = adev.parent().ok_or(EINVAL)?;
         let pdev: &pci::Device = parent.try_into()?;
 
+        let vendor = pdev.vendor_id();
         dev_info!(
             adev.as_ref(),
-            "Connect auxiliary {} with parent: VendorID={:#x}, DeviceID={:#x}\n",
+            "Connect auxiliary {} with parent: VendorID={}, DeviceID={:#x}\n",
             adev.id(),
-            pdev.vendor_id(),
+            vendor,
             pdev.device_id()
         );
 
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 606946ff4d7f..f3819ac4bad6 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -4,7 +4,7 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{bindings, c_str, device::Core, devres::Devres, pci, prelude::*, types::ARef};
+use kernel::{c_str, device::Core, devres::Devres, pci, prelude::*, types::ARef};
 
 struct Regs;
 
@@ -38,7 +38,7 @@ struct SampleDriver {
     MODULE_PCI_TABLE,
     <SampleDriver as pci::Driver>::IdInfo,
     [(
-        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
+        pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5),
         TestIndex::NO_EVENTFD
     )]
 );
@@ -66,10 +66,11 @@ impl pci::Driver for SampleDriver {
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
     fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
+        let vendor = pdev.vendor_id();
         dev_dbg!(
             pdev.as_ref(),
-            "Probe Rust PCI driver sample (PCI ID: 0x{:x}, 0x{:x}).\n",
-            pdev.vendor_id(),
+            "Probe Rust PCI driver sample (PCI ID: {}, 0x{:x}).\n",
+            vendor,
             pdev.device_id()
         );
 
-- 
2.51.0


