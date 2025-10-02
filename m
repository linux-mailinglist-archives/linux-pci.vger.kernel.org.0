Return-Path: <linux-pci+bounces-37420-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AEEBB3DB1
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 14:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB8B3C5F8E
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 12:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8178930FF3F;
	Thu,  2 Oct 2025 12:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="udhhuM66"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013007.outbound.protection.outlook.com [40.93.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018CD2C0268;
	Thu,  2 Oct 2025 12:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759407078; cv=fail; b=UQe9ra8RqS6o9D+HWlNwRfYEMEp2d2UZpvPqJg45NHghqmGLpuzmGktPG99UjPoRZpKNvMn9LUJ36b13+0CU66SIiCH5YZ8o7wzdZ0LpEYlQdgUXjukrSXXGYcStwePB41qIzNCafxc4k6m4WP1UXDuj6Bm59y57d9vXw8BWaEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759407078; c=relaxed/simple;
	bh=yCrZoWrwbtZFVBdM0ImGR0FgOsMzlCD/jz27kXRX2Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NvS+GUvFHHb1w2Njuh3WtbJHdcY6ZyBSAkjBg1tHyUDIh2RGpPpmdGifFfNRuAMx8IZABoMXfTCBRv7pQZtGhSgKKd+gsroPHZIHLRuu3PbIKgdERL4wVhFme0eIWwN726exaaxh7HcnEHJafkfytK1bc5NjiJ5mmxoge12L9rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=udhhuM66; arc=fail smtp.client-ip=40.93.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0bYlzGdrboZ/ewXSvyFHeBj2BVhxUIBdtj+4cA937PF9vybSMpMwMK4sb8hNWzSbHPemnJtjy+QQr00Lh/FOqKIznR2KMkQIF+GCHh3q4y9KjGmLlNQcAceqscSQhdj3z6DHW4MBtcilz4XdG4x9EiOKReX+tYZFtHwbUcVOhb713G3TfLETm//EUEfLIlvw+JpUju+K43FGHFAlIrTKr2e+A7rejvRPTNTMK2z6oUP8oFvuN1+8QuTwwh8Erm9XSqoC2PIBuHHpmhGKda/VzKpN/goBZd+4rWYSWbiHuJHLDpwAxNKpdL/MdXtflCV5dH/va1hMx32prXOcH8/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gQj7FkE0HwZdfw2fDDTO5hIoo3uHTbZr+ig/fwS9Yk=;
 b=fnRJIIf0Wk/s91S6iQZ7c/AFVleRNpVHS3MUnly/FuEXc/Wp2G4CPCPFmGBWCoQYys4hrAkZrLroaynN5r9LyyiKrfZWlesUaWqDnRwWiIQjMz6j+vKdrTW+4ciz8Wr6j0kWvjX/1mtwCdqqBccM4hdHyBo1SD6jbCn8U/Sbp+qDAcaWMO6Z/5qsPPdeVpdYgWS77532LHwA4w9IFSk4bgGC2nZ+7cBBooBD8Dtxtl8Ty49GGL7fdsWK3fKQxLmmLoWqe9zWmzKSA5w5eQLSde0MC/t9GReereIbmWUlm4on3WvCzzY9t6tBI9loOT0q2XV97w+QZ2k5pRd8uaZnVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gQj7FkE0HwZdfw2fDDTO5hIoo3uHTbZr+ig/fwS9Yk=;
 b=udhhuM66NGdpV/NYtKH3u9vRYsvyLO3CS4PXv+6gF5M5CjVNAZ6lAWheNVLcch/EB4eVgv+pcCNEgiSpmQP8A9cgRZkJdtwQr5KWLTVHO2oiUlmwwOszvgfQ+iBuEtzNVqM3X+3RoKkS1u0THcmidpndx1/oSvweDmtZ4wWHoc5UJXBdZbHwqbCYUsMx8xyWdIcrqOKUp+2FwJIESKuVu2lV+Yrc1/+CrYwf0WrfOPxzmeX35TIj6xPtOA6sscP72zf61SSb0Knq6rDideIv9wf+dtPXoW/KkWqOR7H3W0IEXOfgYTdGvkdFfwUfjauqjDMw0aUu7AnzEq2McftrLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by BY1PR12MB8448.namprd12.prod.outlook.com (2603:10b6:a03:534::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Thu, 2 Oct
 2025 12:11:13 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.015; Thu, 2 Oct 2025
 12:11:12 +0000
Date: Thu, 2 Oct 2025 09:11:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>, Surath Mitra <smitra@nvidia.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] rust: pci: skip probing VFs if driver doesn't
 support VFs
Message-ID: <20251002121110.GE3195801@nvidia.com>
References: <20251002020010.315944-1-jhubbard@nvidia.com>
 <20251002020010.315944-2-jhubbard@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002020010.315944-2-jhubbard@nvidia.com>
X-ClientProxiedBy: BLAPR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:208:335::27) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|BY1PR12MB8448:EE_
X-MS-Office365-Filtering-Correlation-Id: 9946220d-5c94-4eab-5ee6-08de01acc743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kHWBgWWJtN0Yqnv8o1Iv04JljDMNwDOuA0+DnYgdWKKqc1hNfZoV3VasWd7P?=
 =?us-ascii?Q?KqVq/jCvS0IxlHi4lpG4liibuV4CQATc5t/FG5ESBFESY7XsoFSz6UVXoJIM?=
 =?us-ascii?Q?5bM8oKbsni/mNTdIswS4uWj4yQs1KjwgXOrG/+6ElQ0588fiozgkmjhlYqsn?=
 =?us-ascii?Q?gmBKicomiG7blnfKcgITm0bKiMWlU9cSYSuVEv+6SL4LoCaDqMUI4eT2FBbL?=
 =?us-ascii?Q?WMuumGOYChlIEC8VpY0IuLpCFPrExIoDogi4eZljfNp4EUdN9DhevA5D7HRZ?=
 =?us-ascii?Q?zoUj5GSk/+q9SyzzuMXCWHZlc+CDsGUamkxhwf6D/lRGZo9FIM66iB6QtW/I?=
 =?us-ascii?Q?SGCHoTix8sieKDWwSV2vSlt2xkzdEfY3turOzWMODOW8Zhewe+ue0dJiRifk?=
 =?us-ascii?Q?Twr+oYnRLa/FN/Cs12l457kR8Nl2IT8Nzx4A9B7uT5nV+64cuOWVXgOfpQAe?=
 =?us-ascii?Q?BSb1PbmIcFe3+woGxjaDORYUh9EPMr4sb19lQkyiYPwjurtligaqIDhRlyqf?=
 =?us-ascii?Q?w66L9fSRkSC1Nl62rQ4q/6L8HeoWUrA78nnfJVDLMkogc4LwqZ11SbLT41yq?=
 =?us-ascii?Q?49FWU1A9weZKLxMWtot7xEycBG2iObwRFNDfFxt2cT473a7ogG76w1dKpxVN?=
 =?us-ascii?Q?WivA19dmzHbbAcRAZ43+KrDoQHXPg9CzwLz7MfxoNPYVTOWFlQt5VMPyaZm/?=
 =?us-ascii?Q?BdY6OMRnr5YpvYuaoV20AY/dl0CIE126E4yrrOdRkaoSO7OmWlTe7hOi4IgD?=
 =?us-ascii?Q?+zd+j4227z9y2K5IvGZDiI3etOtyU9sjxYY5Ls/DasEa7OOnExLx2ks+sVcf?=
 =?us-ascii?Q?G3nZMOTznmnUqwB8xBrv9o0vu5s/xWtEq437Q8eTAiUSyzPLAcdGIysthR4Y?=
 =?us-ascii?Q?PCk4SFEkJaz3rv1bBCgr4N0PVe5XTmcUoGbdN1JUO28G5KJPsrvQmLjybazC?=
 =?us-ascii?Q?pyJ+ADfyIZOH2PXZ+JTrdprLRloipNLtXbTdRfktYAvSiS4PrL8l+MQPj13w?=
 =?us-ascii?Q?dVvMUOxSoHM11iXqolTfpc9vicWJ76pSkMDWRlQtZcYgGKLJYI3RfPzR2Hrc?=
 =?us-ascii?Q?Zqrin8oSJA+PMznCrpIo70q843XWvnkFOE+/ufm1dW/6AcT0HJ7cQzzDgWU+?=
 =?us-ascii?Q?DSqghT53j5wA8jXdrjTpIvFWQ04d0fCk1VA0FVU0GzPInm+WQdZQRiq/Mf6N?=
 =?us-ascii?Q?i44u4BEcorh8N4VHdqmwJqHPMoJy7x1DatVnF1Hiq2dFpQlsnOWiYiCVJ9sf?=
 =?us-ascii?Q?77e0DEF9QzzWVy/abPDLaswvq5ODDYitSVCri9mT/uTm4Jfoz/xDfJOqZWsi?=
 =?us-ascii?Q?V2L1f+sS0Nho9OBjdhJwMqsWAgfGME0ZyLG1sSkGkY4GJdm8ZpzZWQkTrZLH?=
 =?us-ascii?Q?gvLqax5AYsnBmQN9o/KI2yk4vuW2ncRh9gnslkI6gV/SCFuAGPlVz/gjEOYH?=
 =?us-ascii?Q?4yXzq/vuBsooO8GlRoGqLcyT02iL21rD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8gOlM9WNXROoXF49b2chY83+ZmIqJ+9cpm+i/X+U1RyAJTyyT9zQvvJMiMBq?=
 =?us-ascii?Q?/AK5ceB7aVXESCDyNY4xickqOOtsCgB3aWRQuYTP3F68KeFiQV9OOXi7bOCD?=
 =?us-ascii?Q?d843pp0Yd4kIuoV+moKBE4k3VEZdbrTHXSbetSsaxf/hgAUVaWkgm/9Vt51v?=
 =?us-ascii?Q?FsVosRtRtPVQx4sK0WXjDDih3+IR2MRfN0Kky0W5PMz/xG081d1MzWt3qd3P?=
 =?us-ascii?Q?D7MIvQ2wHtBc3/oGs6wjFsZpLxB+BpkQ8j7gxxo4Clx1SWV70LSz9KbkTdl5?=
 =?us-ascii?Q?c3Oz1iojf0y7QRoer6SzddVz4TTuWIyEp/bf+K61ysiw6Hs4nBB11gBZdPNA?=
 =?us-ascii?Q?49oAuL4bA+eYUaongc2Q/Jn+w2WXBpg9k3mJvWGm7GGXgGHyf8OQTyacFWa5?=
 =?us-ascii?Q?JaaeZqBQKBa5ZWBHAqpPXF4dSyt6MossU4+odPVTTba1LU5CRw0G7LtOgqg0?=
 =?us-ascii?Q?aLaCxJRE7Hhqj6i1g+uhK8WqcF/fuPEuJgDNPAbqvGndGrZtIuA6R0b0rpx7?=
 =?us-ascii?Q?UAknS5IXyBpHrZj7IdgbeYwVYNJnePDdEyS0mEipxyBDRHfVIRYUmBafmy3A?=
 =?us-ascii?Q?Ss8WUujBRoNULHQhSpji8i0c7u0DAW65j34RLcfOEFytpYYEwS5gJU8NHgo2?=
 =?us-ascii?Q?IaL3gUIn6lYCF/1L9QTzI+LaXfF318U3dyrE5REasdHKFSTuQNZ7eyqaaKzB?=
 =?us-ascii?Q?v6sNlHdxmkP/JZMUaEL936MVShiFdSOWO7I/HS4l3r+t/4pR8Qx6/ZcspOkH?=
 =?us-ascii?Q?BEE7YmGKTzkBTgj6mPEZ10gmRf1E89k+PgdoeglGf7ucAKYEKIZgya3t/+f1?=
 =?us-ascii?Q?R4YOx3fbItWAmuLCyAxTyCU/+l8lFDhixv+bai5lXqvTnHd+hrkG/14VMJdI?=
 =?us-ascii?Q?EfhTBa1pulOCnUOJmiAC9RrEfSSjeZIRiL43C/jSm/sUy8yeEvwlD2oMYkY3?=
 =?us-ascii?Q?+/Q3W3ngAmINMlbFG+zOe3Jgj18JqORShzObW98XcStJ85ebijSwQEwX+gAx?=
 =?us-ascii?Q?9uazr26ODcgOmNaVn/6ErxQ7YoeLvQTt7NtTSAaLpTI2lv2RWEr+71NvEUTr?=
 =?us-ascii?Q?14+uJQYLJ7ccWmd1cZkO2pquYit5ELBGewmmhlh8iI2onL/3sg/F9pUUwNdn?=
 =?us-ascii?Q?wIq7DcdqhgnDPLw+B0ffHW11PXeTwt1OkMFvtAH6xFIOtQZt0jTWRu3CBKH/?=
 =?us-ascii?Q?uqsKwgbZuM52elweE6JUIdkiEV7TnX4kyycHY7FDvFXS+dg84MM8/O2JXCyo?=
 =?us-ascii?Q?cupX4V4ZNae02/nT4GfrFJ6G8teHl0uPKUnlHgiUWrSk/u8vJWDAQ/4PNGRx?=
 =?us-ascii?Q?zhIHBZAvqidzFkKBsFZZeSos4uPHQ9SVGDcHfByKq1GTmfA7e190/utUeoi+?=
 =?us-ascii?Q?iolInBFWXbvcRV0JUfycmv6g2EWMcDCw5jiiYT1mTqgUUBKKFqtyfwYaNcUE?=
 =?us-ascii?Q?ophTnLFiNRYOMig3B1As8DzMjziDowW4NiQEnw+YGGktzzjldPINJjc2vcC3?=
 =?us-ascii?Q?GZuJR5dp7/euPEGV3njigI7RP1OXgZFL/1vk6yAx5ZpyfazSqr7YyUDPqW1u?=
 =?us-ascii?Q?+RdI/SyuWSoqL1LstweraQgFqOWRqVM/76EL8Zmf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9946220d-5c94-4eab-5ee6-08de01acc743
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 12:11:12.4252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuQED0EYmAKWXKDGj5xRULYjSVW1sXRXCsdixrS40VI9pF4zohTEyx312xgiqcB8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8448

On Wed, Oct 01, 2025 at 07:00:09PM -0700, John Hubbard wrote:
> Add a "supports_vf" flag to struct pci_driver to let drivers declare
> Virtual Function (VF) support. If a driver does not support VFs, then
> the PCI driver core will not probe() any VFs for that driver's devices.
> 
> On the Rust side, add a const "SUPPORTS_VF" Driver trait, defaulting to
> false: drivers must explicitly opt into VF support.

As I said in the other thread - please no.

Linux drivers are expected to run on their VFs. This temporary
weirdness of novacore should not be elevated to a core behavior that
people will misuse.

Jason

