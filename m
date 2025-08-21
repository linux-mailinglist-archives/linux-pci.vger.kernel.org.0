Return-Path: <linux-pci+bounces-34425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFEEB2ED1E
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 06:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A393A8020
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 04:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090192566D1;
	Thu, 21 Aug 2025 04:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SLpqtXXA"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4612D27280F;
	Thu, 21 Aug 2025 04:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755751334; cv=fail; b=bhohJPkCxYN3XvgGb/oL9Ib6Z7TjdSCHsWUqUhBsXIwNdPrc7pZpGW9ly70cdv4dYMPk0CkKf0aTrZrCI+Dxi/qF0l6JD+gB3XiY44EdjjaNdkWFEdqw0KN+PsDJL9sCt9ahBc4CdFgiFELNsqrFvPp9NmECwQWh0wgUgMh8GMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755751334; c=relaxed/simple;
	bh=H46msuSn+zFT1t/m7HffePGTU6LJzgCMuZkDGRT0soA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=X4lkcSfX2FMpLtLgtmkOFAENAbw41gKSqeltoD5B0+DfZuwGRyr6jKV0uPoml/sB4vR+LXuPFUS/d7wTtqmICqFiZSrkPwSNAECICyndrh/Ej3JDowY8tv4PX/LDYP3j3bUFWr50oOKZ/cLunW99NRiUrkJ3/n1pD66eAoV+/Bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SLpqtXXA; arc=fail smtp.client-ip=40.107.94.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVrJV0+6o3XHefcXmMlJwKT8oHRV8P5vsnQys4kHiaGDA82Vvxq6pqISyDcE4Qo5ofCFdErC7MOnbLqBktH4Uykg051RH0aquJWqEvQNKPnbCp3Y4vactQUAkXhGnPiVF2lmj7NiC2JUPiFAe0sZIDRYxpuuaAc3uNaKJmrGD7WkaQfGTtdRbwsqko7Jm7JFE4yI3RYcmpmIoBKgcWEjcD1QEzT9WUBLHX3lGma2VI0bBPBWmbDoaNSLIOXXWTfjz53gvfm42nxMcTv9K5x3VN5WDKkoz5qYd/gtfzIyNPWFR0RhFrM15l4QxEYaWp8wdqmfmnzfDld9gCy9pZ5/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pyrKQS7L+dgPRwSx01SUfwOnRQgEB0eoC8qXf3zfTQA=;
 b=W0hfLmTwiAOJ8MqLSWGUIhzn0e3pcLp8xviITX0YHmvpKXijLzzl6KARwu4inDDYqHXI2Pf2WDmRAMQbJR+uCAH30m0AIYKateSAlQzLDfYZk6Y8BazWfVAxw2Esv/M1iYm99OO8figCneXmhgivNZFQO7YHza3qBmexmH/G3eNTwm4/DORqqyJdNFnImDJrYeXo8PMsD4C2MB3ym7+13kXTJaKeTHeiCDx0cuSdA1bAqiQTPJw5TQbYx7lHD+fKc+/FZLnMA+aYb0sX8fqq9JgwispuYdtZO4HFf4Oj7Zs+uiNDjaRMDOsd/JPJtS5ZgI7svgCEGs27kOgDTz9k0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pyrKQS7L+dgPRwSx01SUfwOnRQgEB0eoC8qXf3zfTQA=;
 b=SLpqtXXAr4IvxmeA6GVr/aDTBHC+VB53g4v+4V1SA4hXyvE+3G9g4/OL4nbTZwMaJMxZgmXvCnY5u3R9wL1UWAZj9t78q8MT0KgnIMK316Z2drUgisLO3h2CQCPNFhibaDKa1w+rqxd3LsWHMJurRo8sTk+OJN/SwMxQpjY4zeSnLcfHaRx9GC3wJryJ5CXGLqDKxj29EoY4XLLaEpnOR0cxduLw2jLZa6HVW615jcY0xMTOO3c/kxzBkvAT+JOxX44cMmuF5eTtUOG/gr0M5eNWM/uFuHG+9oYqnk1JElM6OlF1h64dOAYzQvV/15MmHz4SbLnyEai21kv2JJ1jXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by DM4PR12MB8560.namprd12.prod.outlook.com (2603:10b6:8:189::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Thu, 21 Aug
 2025 04:42:10 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9031.023; Thu, 21 Aug 2025
 04:42:10 +0000
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
Subject: [PATCH v5 0/4] rust, nova-core: PCI Class, Vendor support
Date: Wed, 20 Aug 2025 21:42:03 -0700
Message-ID: <20250821044207.3732-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.50.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0220.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::15) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|DM4PR12MB8560:EE_
X-MS-Office365-Filtering-Correlation-Id: 8206871c-bd56-4d13-f88c-08dde06d172c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sXfqe1Ww89sBw+bZkyAUG71zeaeR3IuVyyu4mTyDDoE2HxCYnIO4T7klgnrv?=
 =?us-ascii?Q?5fx6S2pfY+UDI7/pSuJTlm5lWZBL+4YLfrBbbehjS/zPVdbJKfqc5ZVwS6OX?=
 =?us-ascii?Q?5384LEw0gTqJW6hxeYVPVtKyYRypfE+qMjWfXQcqoAcELwKL1CtAE3d1UuTC?=
 =?us-ascii?Q?UFfteeOdxjqsiURBjbyBXH1TEnGQki3V7DhNQRwdmLk2LvsUyzfZnYopLh1s?=
 =?us-ascii?Q?iqFtyES3LxCdWozbU/1fxx4HzB1mvrbW009rAcOfJFqyDbxAuEvCj98+0edS?=
 =?us-ascii?Q?Ai3Qz9MA21nJXxN+8JRdknVm+qh27mih44WnDw3LbRUChmhsAP9JEhAYk2WU?=
 =?us-ascii?Q?lVjI0TsZxCJNGOOSpx4n5dLWlSeMwR3L62t1g9EtVd95cbzOp80rj5slxc+Y?=
 =?us-ascii?Q?1dagEHZvhsShABmOWIahLA5Gtb/wPhJmPkKtuTnn7LZZSgzq4nElohN7Ymwk?=
 =?us-ascii?Q?fTIviYMh4vHfjQQuewLSzuQISHa/9943h0/eEZPYm9plcX5JDa71wTYqHSqm?=
 =?us-ascii?Q?S/FTsbUcJZ8mZEm7PYRoYkYEuUEZh1CF28bj0XAkqer1SlOyLSStMKkaJ0V5?=
 =?us-ascii?Q?3zUJb2ew41ymjVwIglxevC+spieaHXRrTu6w7rk7tBRUvFCQIUZGUMgve1gH?=
 =?us-ascii?Q?HjxvU+BH4nr2UxecNd8bxjnfisQzoHa8ZeINAbaEMZzNuGq3pk4KnCoxCC0+?=
 =?us-ascii?Q?yDeTcL9tX0wr/b8Q16lWLw1aKGiGLVkk0cuVPFp0g9gUZoM7wKmZccjIWUlE?=
 =?us-ascii?Q?yHzEM34AzjMkf681iGwjgF+JdFK3Qx3B0G898k1Pf0Pjfhe1kg48X+Iukquf?=
 =?us-ascii?Q?W0o4fmKthYPev5s1gVg5pAMhoN8+QJxY6P/5Wb0Qxh+DK1ePXE4fAZbUGdNI?=
 =?us-ascii?Q?GgAwqv5eKE28usxU166PzKFfluNsaLnw2EJZvqF6ccTeTj+bZVhskVbmoIO2?=
 =?us-ascii?Q?6UepSMDF3jnOzOtMYHPFZXApOUdqDEzQ5/BKCpePsnoDmgNfTny1rC9L7Jt8?=
 =?us-ascii?Q?J6smysLKlRVaUlsEDBmVXN9SclCfu6pqcr2fABx+lnm7pRaQWO+9/u+uAN3L?=
 =?us-ascii?Q?IElXguwbCxJzlQEmjP4UQl456szzfkYJbsQMkGV2FBGGFvPNbEhilOhIqc0k?=
 =?us-ascii?Q?eCWUpTMiYo7x6LVvDh2NbDwYnP2PEMNs0DhqAJa3xAfmw27CSB+DXTh6vIoP?=
 =?us-ascii?Q?QVbZ6CwbOmEyVkdbU4jLygx6Npnc0uakTYoka1q26FzXutnOUCRyst4JOLPA?=
 =?us-ascii?Q?WhrZbmfjuEKuGv/F5+5RH3NxKOx8yb8t74JwWgtQnxVy6grfFJ0+v+w2lyg0?=
 =?us-ascii?Q?Vy/aevbXdBbFWjKjbrnID5O77ONVnFKw+TXaqMFqPwPo2baKweQecFMPfhvW?=
 =?us-ascii?Q?rVrwpeAFeYkwi+WhJRPJBn2UOhRQUSmzQNMjzILSWbppz5lyknDGt0j7Iiy3?=
 =?us-ascii?Q?YvRYwncREME=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eedj06ngfSwI/nkOpQpaRkbkaZpK1ZudxwHtkh2zLY1PBrKsSJzc0+CRdHhO?=
 =?us-ascii?Q?iL9i/sOxH4FDGjySodG59z1c4db+e6LmNvEUXslllFi+fOGu/FWjyNOSIhpS?=
 =?us-ascii?Q?hJOoVZZ2iYUVmXXBOQi2BRgyb68lSfg73RxfefUtiJFZwx2y8ZWNvEsGtW8m?=
 =?us-ascii?Q?1SGok2+DfzM+5kBXYVF6pV+BsTjymp1cm1+lSSInU2O6XnAwxLEopxhPFEE5?=
 =?us-ascii?Q?eUAsnMR8RjgA5hq7KjKyc5dO1yyd0uBEuITXh7t4PhU5ZMeWiLDDlJOgisid?=
 =?us-ascii?Q?DKabT1P9EAOSAPXUjMwMV3aszmpMT7R1Lou8H3Lp2ppgsHKwXzrLqvdey3wa?=
 =?us-ascii?Q?rLM8i65/xvcildei7JYlyUvf28QyZ3MSb/Igeuuar8ii2lGUFPuDWOMxizVD?=
 =?us-ascii?Q?al4j7YQiRDrISsU2GroWwAzGqocM7kthgRRyf063RoJ4G0/vyChIQVmhjGnX?=
 =?us-ascii?Q?SRbCujdX9dmqa1kt9P0WgC6O7onHDaMZDgH2c3A5ING1XUr4pTa6QaACc9l5?=
 =?us-ascii?Q?EBFPqqCXHtEStCvYBwvTUeXdDSoDU7ZoDsTayDV/rY+iKY2vNneJZPOzoP8i?=
 =?us-ascii?Q?F7Od9IpanYj75a2a57pZyaTWYcLd4R1Iw6KqEK5WUo4LpW5fbjh+1WNw9/aP?=
 =?us-ascii?Q?/oqdRypPcKhOMJeyroWyAY7YV5bipGibgtMuUDd3A/AmL1g/psG5OlgtLKIq?=
 =?us-ascii?Q?cQS4FcBHvDWSv7Pt8mjhUyRw8AlHEx641+k1zLHWOtPSRjgJ6VYJhpWapb6I?=
 =?us-ascii?Q?iPgcdcy69Phd+MjXvoC7FT4wz+s3fHsLzYoD1+otK94x2K+rJrWa2/KmB17M?=
 =?us-ascii?Q?ExvYRd3j/cY5jI/98ruQCbLpEztyhLusifTdKcfDzcXvDienvabjtWeqZMca?=
 =?us-ascii?Q?mbC6bFvp+kiGRrfti756qIdBwe6oUyfhIhzGJZK69Qw6bRy5eMUTlugyhIGf?=
 =?us-ascii?Q?KwELhXuMx+63UmCaKqPw7uRNlyhvPibWuFZeTSytullvKLRGuJVhbJMwS4Kn?=
 =?us-ascii?Q?4db6KeugqQMwqpyiWA3zt+77ZqXZB17yuE5lHEPQWMKaJHQfQ1UYPXqaRBZX?=
 =?us-ascii?Q?XMDIMMpS10an8RuZuJW1ge8f/u0JJEk3nVgewWuhrUtqjzLr/1OzCC058FNz?=
 =?us-ascii?Q?ppS68ykdlHKivSq1LjBCn5KuHQeEYgUJV+houLlNXhQol6ZFS45izRFznnVQ?=
 =?us-ascii?Q?D8K0CJjhrXVzqIj0vcGU6FpPZmfemzik8oDytWle+IZ9PQ3owluih22y1kPu?=
 =?us-ascii?Q?i7UX+DBJkPaBh4Lggfq8gVwadlF211hOIO7y8ZpKDmXAHRiS/bop3hvG778d?=
 =?us-ascii?Q?YQl5sxTLWpLE86DEqJZUChOFedtsSI9LiDkqj0isxdhf73rT+srRdDfw7m0x?=
 =?us-ascii?Q?CM0oPZKevLkioVsoE1TprlrrG5eLMWyuw2yHoqWEYvT3MqVWBgvkEUB3PSJI?=
 =?us-ascii?Q?e1c1Y2JXzRRJ1W+Fl3tweLFVl01bY0s6S506bLlDOoDSLex2dgN8lL2MOyel?=
 =?us-ascii?Q?eiJQBo6lQVtiLR0Tx0XsU4FkzpNz5hndefY8E0MOtHCvAIcnSi8tXA+SCFxx?=
 =?us-ascii?Q?Kx1ZZVmv9m2xRpXGX02KKfV0GavcCT4zijAzkbyW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8206871c-bd56-4d13-f88c-08dde06d172c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 04:42:10.3060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ByNW3+VCgqfjepMaxSB3ewoh74qGt+zw0uMM/yYu/To3AsNJYo+bfdwc0BOlie7VvegwiOWWZg1MmHQB5/dPgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8560

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

John Hubbard (4):
  rust: pci: provide access to PCI Class and Class-related items
  rust: pci: provide access to PCI Vendor values
  gpu: nova-core: avoid probing non-display/compute PCI functions
  rust: pci: use pci::Vendor instead of bindings::PCI_VENDOR_ID_*

 drivers/gpu/nova-core/driver.rs       |  33 +-
 rust/kernel/pci.rs                    |  46 +-
 rust/kernel/pci/id.rs                 | 591 ++++++++++++++++++++++++++
 samples/rust/rust_dma.rs              |   6 +-
 samples/rust/rust_driver_auxiliary.rs |  12 +-
 samples/rust/rust_driver_pci.rs       |   9 +-
 6 files changed, 669 insertions(+), 28 deletions(-)
 create mode 100644 rust/kernel/pci/id.rs


base-commit: 0dfc23ac2c5b3a62ab27fb9b6ee582b4bb5ce33c
-- 
2.50.1


