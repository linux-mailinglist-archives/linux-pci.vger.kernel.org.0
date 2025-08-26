Return-Path: <linux-pci+bounces-34801-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ABFB3754B
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03511360011
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 23:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937682FF65C;
	Tue, 26 Aug 2025 23:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YB0/ZY2p"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DC22FE054;
	Tue, 26 Aug 2025 23:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756249953; cv=fail; b=YKVAWgR0ELiiVjIXRPdLLnW3H65NYWy5cgMNNsviN0QZe4sm1ICkac2jRiPEuYgbDCg93Df9ggKwZdvwzCj9wNJcc3L0S/bznKT+BIUt8LAmFG277Yfb6B04mKmQ6xu45FajJWq9FptcaIhfkhoZAXOoTfdg/LfhCUQUb0oRpCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756249953; c=relaxed/simple;
	bh=KTALXiXimP6faBjuTBhyqHfGPZiEyPMfTLgthdjhVi0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HnhKzCHp8ro4mReeA6XhbtkQSxuN2VTQPEeFKSoZcVVL1wqUSS+V5pxYkG0LJ4N9Nr9xPpHkIgxrA+S8yrqkmPoPS2Xm5Br1qFZBaqELN+e8MIo5r4bjIGhZXt2nLyraswLsU+1nSvV0UmLXjp9QNnuC6ohYkwLGBzZZF8yMp44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YB0/ZY2p; arc=fail smtp.client-ip=40.107.100.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQqzHJzlUUzconGmZK8v0gr3rJ1O2lSEV8xZPyzgk3LqZiz4jwXG480ridOJGh4FSLc2Nl03zFD1LtHSJ9IVkf24/OCItYvX0kc12YcgFyBDb+CTnS7qZo+XURe82VrFX4w/uamZxYgrgEcYJOS21cRTU0lx78i+JL9eDB4gpqE8U8LZlE/DZQtEdJO4QrbSUgVpSD7OT60iwjbTXdcLVsQlBVs54rJ1MAHoWF6orIX/k1dP42Dq1vk3hpltlLpo6wiFGK7CRafCXRQhN+YXeuOi8Y9+e0sN4jN0NfxNcYD7viEOqauOlxPZq1Sv2LBxfa/StebJY3uWHCqONUAvcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQvDb/ufqIuS8nBQjQBmase2KJtZYMuF4UmRjzGvL4s=;
 b=pYQsdNnrZ7UJynOWt93KFeyq6oKsKqI25iCmSJWmpJ6soewE6Tyhddt+tjdjwJZWOo7nLxFPwpwLOY0tthcBTbCoA2I2rI1omAd1BR3S1kHoX45cXBr6WgHKoJ7HO/NCvvY8XSLosShnHATLtbO8wLNWwfEgXQ48nbmMKzCfnTeYFMr3gxpEt9imVCSatmtv7qWrrpILBoBfVJQf/tuZgN7qYhFgZrI0sAOnM7QsAojafPlMJ9nQU8SV1rH96Y0+4/gwtVMZMdU95E6vYdAGpOdMwteOr8x6Bl5onJcHhe2/cTjAihJYzRN7GTCFWN3o5Bo5zDXc/h1IlE0kFVrZSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQvDb/ufqIuS8nBQjQBmase2KJtZYMuF4UmRjzGvL4s=;
 b=YB0/ZY2pIOluNDcosjcpbJSd/MXvmq5+V7Zbf7bIU6f041a/SQBJirMuXgbiietyH7GOvUUKsbwUu+4lLmx0sF0B3yO3TMDTQOiBj66F25kI5giwgMYynJgXY6qAmIDtTq/033RDh88ft1xgbJAsHnsqca3EiPUm0RKVnocf5uBnMJ/WEEeuDxBTbXm6WihJN/xWU/OAxw6Z4Hilhz88pe5E6vAzH7zaiapQ13NSgVKRFqrQ1n0VWPb1LMTksbxM+8hv80VyHVrt2URq+8WFuk7yURTbda5w7GZ0KUazpdbY3Rpe3TXVBF43RjBjnRHam8oiRFrpnL/IktRNKkUZig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by PH7PR12MB7913.namprd12.prod.outlook.com (2603:10b6:510:27b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Tue, 26 Aug
 2025 23:12:27 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 23:12:27 +0000
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
Subject: [PATCH v7 0/6] rust, nova-core: PCI Class, Vendor support
Date: Tue, 26 Aug 2025 16:12:18 -0700
Message-ID: <20250826231224.1241349-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.51.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0096.namprd03.prod.outlook.com
 (2603:10b6:a03:333::11) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|PH7PR12MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c97337b-c01c-4f1e-64b8-08dde4f60635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VHuz6yz89KOCzDR9xmsC2uyzM5vhDp9nLnV0Gh/q8ANglDSKzJw7KsKlgb3R?=
 =?us-ascii?Q?WOGyz7a4Q8cpeZIGeTPuw5Qaw5yvKXUYro7Kk31gS9/tL9CY+jKCwbdIiiyM?=
 =?us-ascii?Q?HqFU+8KCLbuu1X05RET8ALLosVt2+ZhErOpuk0l4YIHaAeWAN2txp3mkMMaz?=
 =?us-ascii?Q?kQb8oPIaCngZM6yaTZxOflTv1R756U0UOr5jfyAa7aA4Mx7JgjnVqa1REn7V?=
 =?us-ascii?Q?hgdIauWiM2LpgHqbT5tQ41I/83MgsNctSIY0b3vl4kviHstsuN6iNYyNpgxr?=
 =?us-ascii?Q?ew+k7u0KrYfjdFQsNzKsQNeWdrv2vyCeplwVrI8ZV1Ci4+dgUVZHmmtVj1cU?=
 =?us-ascii?Q?Z8PY+xuD0ilf1Fvh7t94OIBZ7KBrT+8NmvuvgA9/sMLpu6YPmp92aYdd0Gjt?=
 =?us-ascii?Q?HzjpqUgB4qDGQeRzjRIaHj9bmEZ/OecUBJB8QYhXjs5oZ8RG5ZcCOq+y7cu8?=
 =?us-ascii?Q?wSCpqIW/iRjXzSs8ZbBF/XXuvzN9kkDkxNlNV3InroC6X5stBX2oOE6wVsDp?=
 =?us-ascii?Q?Txmaz6Y0t3IHP4kqKrmPf1l/HLr0oaM5/ap/ephIK6qi5h7gPhUjahGSjWJS?=
 =?us-ascii?Q?bXOPcR27Ta53PD4r9v71qMDaBo1iKINM1KrpCXU4I6n2LWzLLYTwJGI+ORpA?=
 =?us-ascii?Q?bN4DPV4rYalor9ceVA6yUGWBxjO9/UFQrRMNeeJHFMdYSSbxChWdugDah5Sl?=
 =?us-ascii?Q?iwreGBoXS5Y1ZdoLI+5OZmv4lqfJeJKEQr+H82THm2LH/58/z1ArlDAirlEh?=
 =?us-ascii?Q?0zZovIEEb0Xk8hfdHtowHIyOimMlQphfgRCEB+u8aY6+aXBceXfhq9CUkNJB?=
 =?us-ascii?Q?gjquYc5BPKFtlZhbOya6jiN0NejJRvSttufrpQ/pPvEn64jVxg9FzWTZrmUp?=
 =?us-ascii?Q?7g/zWdBPKf7ulPpV4T0wkq7nMcwWPlYMWAvRB2mS2Ed41fYroQ8O0Pgcoyks?=
 =?us-ascii?Q?cUjLNfGdgQztw8dFLJ94plTof/wV6QoqMoPqu7Y191fjtzDuXvO2sUx8kVCf?=
 =?us-ascii?Q?RXfkWrCZZ53LGD52CPL877QhJ97rSAeaMf90JBQsa6FFApYsHcBAoAwMo5tU?=
 =?us-ascii?Q?m4gPB3pDe4gB/3zkRr0UCEk8oYskAJJVAKVHwuuIaKL4mqy7v21i96PGQcLX?=
 =?us-ascii?Q?zisWm88i8ukA/ryFE/GETNuq6saIj14foMfxsf37kMTCL/9tN+525CYm9os2?=
 =?us-ascii?Q?kQx8kTJw9Vs1V4E+8ka7WWkpLDDm/s+++NUD1k5WUF9c8B6KXl9L6M+rl/8r?=
 =?us-ascii?Q?TBbQ1hpl2tvBdkU0blz0fC6sFVbOk/zZ9cXcAAA3iq4jBwxyr0TMHxSoKn4B?=
 =?us-ascii?Q?t5KVF4pO8Tqs75m45RqwZxsTwE+eh4fljHtegCFby3Grvd3htSv4CHI/pN3e?=
 =?us-ascii?Q?3RdOJLhFgkaC75jb4OiTlOyeNNSwzpRxXcf6E4SR1iBuLpDfetN+IGa9WVuu?=
 =?us-ascii?Q?rhD/5smBjts=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z3IsEH9on3pGR4nHp7BmvZ1NcrdsuGiqYFwRNwF1JxizqgJ7aqExU3/hz/Cs?=
 =?us-ascii?Q?Nrb2A8cYfZ/efMklUZTYY8+AAZ+lMD2LWTvA65bXEQVD1l70cxMWRr+SIMT9?=
 =?us-ascii?Q?OFYSl02735j169hNPg6ZjzOOJ4qSMJfSIjCIimP3ybsYZUXGoDTVWvDoE9+a?=
 =?us-ascii?Q?OwWMHH6OKqujM3Wh9Oq2uQ4/wM/NcMXjZAv9psiu7tBCbldpTqjWMafnaRVp?=
 =?us-ascii?Q?D9p8AgDDEdCqulToxQvPOA7/Ri7ay9LrMIqk00HxnAjsbUewKVpHXYqWLZ+7?=
 =?us-ascii?Q?uZB7jZPwv1+4+TjtDeHDOFH4K920mXr3bvZ+vl4rHWw1E0aqpFJClU+bkn7Q?=
 =?us-ascii?Q?PlOchjdWp/x0+vWf4doEaXw6N0Hg5cavDXgL6TQYv5WusXTS3+5i7KmYGYK9?=
 =?us-ascii?Q?Cv0pAYbd+6axfocA8+k8Pz5R2uZc0jL1RWpTg+RrYfb/DhIXnz7PBhRoOFHA?=
 =?us-ascii?Q?NOm0W/g2BiG3m6dLIc9F30e7a+bzoEYFIUTnh/+DGN++CUh/tsxogmwbpSeX?=
 =?us-ascii?Q?tefldlQwU2U02AeERu1dYZl20B4DchzvGvTz9wZysGoM2RO1w26ToqEyrN+X?=
 =?us-ascii?Q?ka2Ut2v0ttxRBkClr1HFnLcQ+NU+gHgjXeAKrfkv2vXIcIYhQ0l95cCRFp1/?=
 =?us-ascii?Q?KyDWTBQFltGsWEr489LLLJfwnDljyTiEURS8tM3DGOHlpTeID4dTsviKLQVj?=
 =?us-ascii?Q?7hY/rTsXtBV7oyO19zY394UTP863Wx7OocXUxwwfhbA+VhbDy8V7Zpr92ZbI?=
 =?us-ascii?Q?EVZVok45ckjCR7sUOLlI7AFGRbcFPIAhVGmFUdcm4dAMvIhYxIigQC5k1z3Q?=
 =?us-ascii?Q?xZQE6doFDd+1MgkfEcAwbUK9jCVQ2CCaLjkfc1LF0S2NEHIJHBEtsEx7xhZT?=
 =?us-ascii?Q?d4J2qk/FjozK8PFRirLsnnNH3nU+4fzzwmrf3AKHczAZyMVTgPIB0KLd6E9j?=
 =?us-ascii?Q?bu0n4qeFZuw43878ZHHDh1J/T3qsfbAF0zBV8TRowGlKXdG6Vk7d4/bnz4Sg?=
 =?us-ascii?Q?s6BACOwXbisBJqAzLXBfnxVAeoN9wGg1xn/ZIgKYW25PokMjgOizIb40MMTz?=
 =?us-ascii?Q?5OKP3VEPWRSmw89clZn4K8u9yKqUMr2NjKS4LZjkuz5fnnDuG4q1tKZ3bgb+?=
 =?us-ascii?Q?ZTpb5ndqEXwslQqWXeY4IXAeGHcMvk8rNAMbwM+CR6bfkhEYVSkcHU9R3LoS?=
 =?us-ascii?Q?aqwbJ1Lms2qgLOIGFoG6XjLYkg70HEKGklwVmBMG0utx2z1aWBl8r7Yu4ctx?=
 =?us-ascii?Q?RoX1GXitrqZwJiK0zRbYTK3/h3sY3VYeAtDII0hKOzQZPnC2bN/Ugq8HMbNK?=
 =?us-ascii?Q?M8LsMMyovKFdBh5dTHqY03y30SnFLJlbRha21Fz2Voxuh7/JC76XWkw7V/pi?=
 =?us-ascii?Q?SnFKBfOcFMmw9ZJCA/2FoFZDStVpl5NFq32z93+Sn/F+mOxp/IW9agOBI6/7?=
 =?us-ascii?Q?TC5HjTpUhnvLqFCJ2ALELBDp6a1ftiwWkibv1C2zU+qII6NeWIaaRdh8TCiI?=
 =?us-ascii?Q?VYWUcRDdqyRa+T+s8i/+FnT5psbblMx6gnS3i7RFfK9cTMsf1QT7ITLOYDIT?=
 =?us-ascii?Q?rEgnGwxixqxyXpDW1x6yleZ126vMZLsZCGJwlOtS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c97337b-c01c-4f1e-64b8-08dde4f60635
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 23:12:27.5122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cya+U3FPPKQXnbDLk5zT6hAEq6InbkcqwwRabEnwad9GvAw3cQRSdpt2od+TcwQwPXdt0GGS7eSuvLx8PwGjmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7913

Changes since v6:

* Applied changes from Danilo's and Alex's and Elle's reviews (thanks!):
    * Rebased onto driver-core-next, which is here:
          https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
    * Changed pci::Vendor to be a u16, instead of a u32.
    * Inlined all of the tiniest functions.
    * Changed from Class/Vendor new(), to from_raw().
    * Made from_raw() only accessible to super, which in this case is
      the pci module.
    * Restored infallible operations. That causes Alex's request for the
      following reasonable behavior to work once again:

          from_raw(0x10de).as_raw() == 0x10de

    * Added a new patch, to inline the remaining PCI operations. This
      provides consistent inline choices throughout pci.rs.

Changes since v5:
* Applied changes from Danilo's review (thanks!):
    * Split the nova-core patch into two patches, for nova and pci.
    * Added rust/kernel/pci/ to MAINTAINERS.

Changes since v4:
* Applied changes from Danilo's and Alex's review (thanks!):
    * Reorganized the patches so that the Nova changes consume the
      results of Class and Vendor upgrades, all in one shot.

    * Made Class and Vendor types get constructed infallibly.

    * This was all somewhat disruptive, and also required one more patch
      in order to properly separate the various steps. But I think it is
      all correct now. And CLIPPY=1 builds cleanly too.

* Elle Rhumsaa provided a Reviewed-by for v4 (thanks!), but due to the
  churn in v5 here, I thought it best to not add that tag to v5 yet.
  Instead, I have directly Cc'd Elle on the patches for now.

Changes since v3:
* Applied changes from Danilo's review (thanks!):

    * Moved Class and Vendor to a new pci/id.rs file.
    * Added ClassMask, to constrain callers to use only the two valid
      masks.
    * Removed pci_class_code_raw()
    * Changed Class and Vendor .as_u32() to .as_raw(), because after
      Danilo's comment I looked around rust/kernel and learned that
      .as_raw() is the overwhelmingly used convention.
    * Changed vendor_id() to return a Vendor instance directly.
        * Also, validated Vendor during construction, just as is done
          with Class. Both of these items are expected to match known
          values, even for new devices, so that's a reasonable move.


Changes since v2:

* Applied changes from Danilo's and Alex's review (thanks!):

    * Moved everything possible out of the new define_all_pci_classes!()
      and define_all_pci_vendors!() macros.
    * Used "impl TryFrom<u32> for Class/Vendor", instead of .from_u32().
    * Made the new DeviceId methods infallible.
    * Upgraded DeviceId::from_id() to accept a Vendor struct.

* Changed the names to be a little clearer:
    * class_code_raw() --> pci_class_code_raw()
    * class_enum() --> pci_class()

* Added doctests for the items that are not yet used in real drivers.

v2 is here:
    https://lore.kernel.org/20250818013305.1089446-1-jhubbard@nvidia.com

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
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Elle Rhumsaa <elle@weathered-steel.dev>

John Hubbard (6):
  rust: pci: provide access to PCI Class and Class-related items
  rust: pci: provide access to PCI Vendor values
  rust: pci: add DeviceId::from_class_and_vendor() method
  gpu: nova-core: avoid probing non-display/compute PCI functions
  rust: pci: use pci::Vendor instead of bindings::PCI_VENDOR_ID_*
  rust: pci: inline several tiny functions

 MAINTAINERS                           |   1 +
 drivers/gpu/nova-core/driver.rs       |  33 +-
 rust/kernel/pci.rs                    |  55 ++-
 rust/kernel/pci/id.rs                 | 577 ++++++++++++++++++++++++++
 samples/rust/rust_dma.rs              |   6 +-
 samples/rust/rust_driver_auxiliary.rs |  12 +-
 samples/rust/rust_driver_pci.rs       |   9 +-
 7 files changed, 665 insertions(+), 28 deletions(-)
 create mode 100644 rust/kernel/pci/id.rs


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.51.0


