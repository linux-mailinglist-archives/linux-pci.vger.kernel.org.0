Return-Path: <linux-pci+bounces-36916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0511AB9D08F
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 03:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93333B32CA
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 01:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C45F2DF134;
	Thu, 25 Sep 2025 01:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CNdiUnxH"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010014.outbound.protection.outlook.com [40.93.198.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7512DECB9;
	Thu, 25 Sep 2025 01:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758764055; cv=fail; b=RcBVuLLaJy87W9/GkM1daD1VWKPOfOIf2NflTbSX1wgEv6h54KtXVf0hWaSPPX6ZLgwD9uOtzwcRlbYZ1J2TapSE5S2zjThE98jR+1PGwXvvtDEw3f5R1bQaLHrkBzXHYbCsas3q0uE8RBk+mRryZ42gbYQlEt5czS1Jxpu5m1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758764055; c=relaxed/simple;
	bh=PV7Z5/LfEcX3zOuvm/b4PXKGw/PRNb3ti/CfGQYUzzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kiQBhUk6I/PbRitWEmEXoPcWEQvhvWrDArn4ZUgBHJso3bwn7Xx5KJGqEo3+bCDz1HZ7W9JbrSfK5DJHOQrXcW9yJLxfKG31rzA9MHof7y/yK7YDDtxeJ+PdmI8tbkCE0XB/UNcpM/qJ0bN89JWmgOD58BcNY1+WhAz1gdRPN+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CNdiUnxH; arc=fail smtp.client-ip=40.93.198.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q29bbyfiMgXnzTr2SKzn6Z9HqmaQhod8Nd6qmwGK03srWsxEWvc/6HqY2gH42XQXtwGoKMVGPeMQoCT/sjuSH93V/W8hJeVN8o9Ys2bfCbFRl6QnA8Hp8i1BTh2CyVdreHu1IPGzNXI19xjN5kalyU/w+sWs14WWSK5TYP5QPNsGulGUM8G3ddjE05ARxgUQQ7A/IH9aWNOIGpMH8Mt37jBb9s0wy4/r+nkkjMqbYf+69Ymx5IeAaDZv4O/jLZ2jpUyKeSPkqj6rHCgLJ26UbJ8l+ywI3/98l1eU0VcJyYiDxSuUxMdXiQACSraEy6kQ1lH4R/7t67XzOo9ogLebQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E96EobucgXiGyE6b10cznDoZ/c4Ywns/+s1Ci4QD0Uc=;
 b=Z1lD224H9auX7qvextHedHN/iPmuwaocq01jUj9kLJtFM048QgJ0kCN+hpzTZ9hkU1wZMFRl/50UikoNnnYO7cjRzyfprhZr1lnZIvBX/VagzqztuuuoMcf7xO67fFIDjFDCK3Ma1lZ6hC+98Ig3JV682WyiaCvOAIjcmwEPubLPG+3Z6nNSZQ26YX4aL9jzOJD3f9E5zs/HXe0VieXNCXAeqoR5uiXzv4gRq42jnMSFLDpt8Jam+FJaUV/29lXWxrEQgRIqXAbw7tBanE56aqsXC27h76Eq+YMg1RnepSVOOeRl06+D4nLdq8aTLQHPZ8cX0xdaF87mJwS5iIRrhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E96EobucgXiGyE6b10cznDoZ/c4Ywns/+s1Ci4QD0Uc=;
 b=CNdiUnxHiFOyfXoQ+THpQQ3oSDWrWRuP20nvqs8I7jEL0gmYKdK3jfGinE1QmNGOppumKtyFCX0XVQnHFjbajr+y23fXAcQMyJ5IEofjO1nEfH8yaiSgcE1mwICJZ7ZKb3t5LX4ljDS0bxU6E4jNRgapKEBGMKUS8H7BpgGmQyQGpMA/7Idg6dZLaNniaqSPFpP2YF41ARxJlJf8ko8DOclcGIYr85vwn9OOaT2s2RYqDCX2Nc3mHjin/KWxjeESxivGBQcAQJPF5JrQgDpI1UwyClc4YlDSn++DKbzdJgNbq3UclQo9dDTHEtV3r/6fWk2JAAWOX/T8vuNatnLXRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by SJ0PR12MB6879.namprd12.prod.outlook.com (2603:10b6:a03:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 01:34:06 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 01:34:06 +0000
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
Subject: [PATCH 2/2] rust: pci: display symbolic PCI vendor names
Date: Wed, 24 Sep 2025 18:33:59 -0700
Message-ID: <20250925013359.414526-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925013359.414526-1-jhubbard@nvidia.com>
References: <20250925013359.414526-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::33) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|SJ0PR12MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: 32135fa9-dd14-4e06-0393-08ddfbd39e1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ftG0spg2DBeFjHOTU0xEMHAyp2QV60JlMmVwfURcDlhlholMH/MHXKF1FdI/?=
 =?us-ascii?Q?mX6DWtmb0SvZYG0EBR0T7fIUXZGREnGO1VCdi+pQu1edtxW4Ph/jehjqoy16?=
 =?us-ascii?Q?u2yD36mygcAu2aB4wIUJBrVZp5FUynpFxpnE8PFLraTaUze+CE+dWwEDqjbo?=
 =?us-ascii?Q?Jr/s1tQM9jiIsBMtjGSwerGzrNr97iMnOBCHllkcGiT5oxkPzQBLWrExRDFB?=
 =?us-ascii?Q?Ag4H3uMnfPcTcp7tKokcC8lAdZ3qR2yXlBd47jjBVlo5afoB2/nul3i4rWLk?=
 =?us-ascii?Q?/lOz7YRvz9ZvmKhDvfQ6wB8u5ahBF7HBnOIPu16wkuObwUPya1RzjsyXl8DJ?=
 =?us-ascii?Q?VU10qf/qQWR9NXlfBoMNPjR3lOgU+sO5Tn6pP0Z58mnkR6vCA3/3jeU3XXVx?=
 =?us-ascii?Q?iWylWhllH5ex+OnTD10yOaDgPmRRH7h3e/0Zx3zVblifsgiD3VVZ/vElo46/?=
 =?us-ascii?Q?/yF2la5VguGbVX/9Vik3tFi0fTjYGNSbDrHlpuDHy8AFtWeWOQA7zb6FNpGa?=
 =?us-ascii?Q?PUZnMAp696Kf3nPKnhzv8XgebTjbugKXP+CvzLfwR/m+lYgLNcvKsFaNnGHA?=
 =?us-ascii?Q?ZgH58BOOMUldS4WZMbyJH/qg8FCAo9Rc39teYnlMXuvzvEhB8/KD74FEwd9H?=
 =?us-ascii?Q?AATitkcmMZTQQHwhCDxyFFySqQ2wREqka+Kp7SU31Xl3INFo97LZocgZhtOL?=
 =?us-ascii?Q?f1c4GBl5BkfHB9bqH3CLmuxHsQ0dDSvFPPxvvgjewtbvwtg0V15AEVa2Tdjf?=
 =?us-ascii?Q?TgNmMGtcF/61Fb3U+S6is+msLiCrY/OsqhGs2J1qo/1ZdD7ECJAg78kevGdK?=
 =?us-ascii?Q?+NaKHw6QRd8welQnL3Yg87r8neiWdL5I4tEd3P9ZPPRZSOh6rgQo6AeEWvhF?=
 =?us-ascii?Q?zX9/+uD0O6cLtkcDUoh+C5q2uXadLDuv+Uo5yBBxKdsTIimVGf/HKmteHEwQ?=
 =?us-ascii?Q?N5mZc+1uj+yAs9KC0IphIGAkm6Diw0AWNAXq4jEpwFgO270MlGfpCGcv7Qi3?=
 =?us-ascii?Q?xjvg2A+/9/9/KRba6/hh8X9pH0WF9Gq9znqlHYfcAtyU6HITe61eUwqNrFp5?=
 =?us-ascii?Q?jqMxXakaSgzgSIRR83kP2Jk2B5kgBWIOJUjLewffyn8dAIq5ll3usWU6osdO?=
 =?us-ascii?Q?LP5Pa6D80u2JbsQWd2ACEbwwY1ABVr0I9jPzWyAE6HjCgmrfDNbtiUnE/Tty?=
 =?us-ascii?Q?5qFfKDVCcWdJMFXb5utlL1xed0vznfO9yb8SXfDI13cXQruD0Z1L2r6z3gvP?=
 =?us-ascii?Q?q+f6z4Gskj/SjoiXMNrDKJqXNaTXsL1RdXcn0O/pIXx5IpFomNn+9qCiMtea?=
 =?us-ascii?Q?CZ4aj8njZyCIWjmdlGSSljareXRdIrUPtc4RgRg4PQxFrae4mW4OoSJGgWds?=
 =?us-ascii?Q?A5Rw5cBp/900OsAc5p3LM5zUP4pesJZVyd0eN8cFntgvpfk2DAnNIzCPdtyK?=
 =?us-ascii?Q?/NyHMcf/gwf8+1CNnIHaHL2WtvE7cW2C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rZnjULbXdW2dHfOc95xx0AUM02NrIF0JPp6dbSsLQ49E/SFE4ugdlhQkKoSV?=
 =?us-ascii?Q?eKyXdy/fKBTjpRVioSknvExYnnk/UfYaaBKGu/ownpN/N2M63EUaIjKNoGRt?=
 =?us-ascii?Q?vjiTtHUU4rK/9wqN+Ibzf9xp+GZCTpX/FhVmn66kcgjAkcRGQMRw7n+3gAC2?=
 =?us-ascii?Q?wqEIYm9zKAOxCWTdDpO3av1YJV4UZo6O+QCPVr60nPU3TGsfJ0IoyNjIEf8H?=
 =?us-ascii?Q?J6hLkCTdfDn8r+zUvzwi+BcZWtV4t/HYYa/7Kv9IUhzlwL2xuviWvP2o0lET?=
 =?us-ascii?Q?Ru0QlcmDsklZQYd4OcIIjvfoVAn2/M2JremJtiErUVQKkQo4Yp6PuKicZU4v?=
 =?us-ascii?Q?+LuhfYR2dvE3fnRW4i32UFSXD+IbPJ1Z7oOGa+7jKMGUFpWxR66uvHzTTNwF?=
 =?us-ascii?Q?7CXLUEYY7gkQj/RYDlaPoRVTO7R9EJWiXPBWuPgoKlmwnuiiHlAl03wuJ6gD?=
 =?us-ascii?Q?S7q8la9jvtvybw8B5o4aA1OhDFpGpHD3PLQ1+0vqz0DpMw6MwcIGvsJHZ0zU?=
 =?us-ascii?Q?riAJTQQXFI+jmPABtFR6iFq7gLVlzTIj1ZkgYVtYZ9yoigagIWjuVrR9Qg/E?=
 =?us-ascii?Q?QYvyyP306REuRja/7ZEmsoEBCjku2aKG/+MvWuwl3X9a4IQmWrhFECpS/3Io?=
 =?us-ascii?Q?OK5lTiUTIBSSwIa/nBaXb7fvRGGzsdnNvCuHLu57/uFyFT/RWUeyEVhosx4i?=
 =?us-ascii?Q?5V5uzBpVo4BDN+GYOGLOOeJopCucZrslqeqatVuYJA9GnGZPdU6m8m2HJSbX?=
 =?us-ascii?Q?3Eb5uyBgISk3TyCYBVM3ck1mOqV8PY71o0h6M7pgbvxSB1dPZpfluWwMDfhf?=
 =?us-ascii?Q?TbjwGnSQHauZlcHaRr5hc6RLWeM9U46i5aulVzjHWaPTRu6hVTh3qx1wLu9S?=
 =?us-ascii?Q?XqUmq/EetTlWgWOtgz/dk93arF9YhTECKcE3BtAO9BB0pvVbqr0fGg7dYSj2?=
 =?us-ascii?Q?tib/2VReMheOpruBbXRJzwEDIhdVxb4KYUTsXRqJHwamP7+Pl+y/miz83cVA?=
 =?us-ascii?Q?ZvYeJifr9Rr9zLj3FVpc9Hm9XY9QA1huZaQ9VIGo48gwxMtHvFpJOLEA71pT?=
 =?us-ascii?Q?qRJOb2wrtbVt94RVliNoe7rhjM6tg8CK5GEqXbz4kdRrBSJdtmHryZamJM1r?=
 =?us-ascii?Q?97j8phowiFbVBPS0ixaNReSV7oBl24nBvJNlc1SY9ilBPJNTZXRtL4nSUlJM?=
 =?us-ascii?Q?zyjH8mr91amN3UVBMTLyPBK4xL5eqyy2ZQUgS0kie+dQGchEcREW2DZ1IgDz?=
 =?us-ascii?Q?Pa8nIpRRuwHHwrlWLHCgoomrXfsmF9n+IBfEzogrbjNTcCfyWwt1sr4u4Pfm?=
 =?us-ascii?Q?is4620w02p3z4Wse7eJUvya71S5cG8BiulfACbl5HKZ4KjM8SHX1PAeRdet6?=
 =?us-ascii?Q?hVer4E92cgnWG+nVY8UCyfC8BXy5OG9ucmvBTn3JUmvZaifHXLhnIZsUNCpY?=
 =?us-ascii?Q?g/SNOWGLgTEs4bBPi8XvSY08KBhip3tbiL0L8WDTVeS+awd+iky07MZMXvhi?=
 =?us-ascii?Q?SRjNi6sXVV8aLlFHxsnSt9gvS6r6Pn3BsRosBYex9CCQmlLNR2bGsRZuG/RN?=
 =?us-ascii?Q?3w/5k5GMMx8rGLDxo+1lvVdpZEBdgU7nKzC0cmL8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32135fa9-dd14-4e06-0393-08ddfbd39e1a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 01:34:06.6812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4KphLKPVbAts3RQWRNutyo+Mb8+M7S7T2djYWYjadgFo0Zn+hIWQ+40G5pFtdbJ/AUEA1/AhmWMbc3NnlMUT2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6879

The Display implementation for Vendor was forwarding directly to Debug
printing, resulting in raw hex values instead of PCI Vendor strings.

Improve things by doing a stringify!() call for each PCI Vendor item.
This now prints symbolic names such as "NVIDIA", instead of
"Vendor(0x10de)". It still falls back to Debug formatting for unknown
class values.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 rust/kernel/pci/id.rs | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
index 6e081de30faf..63db4d5f5617 100644
--- a/rust/kernel/pci/id.rs
+++ b/rust/kernel/pci/id.rs
@@ -135,6 +135,18 @@ impl Vendor {
                 pub const $variant: Self = Self($binding as u16);
             )+
         }
+
+        impl fmt::Display for Vendor {
+            #[inline]
+            fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+                match self {
+                    $(
+                        &Self::$variant => write!(f, stringify!($variant)),
+                    )+
+                    _ => <Self as fmt::Debug>::fmt(self, f),
+                }
+            }
+        }
     };
 }
 
@@ -160,13 +172,6 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
     }
 }
 
-impl fmt::Display for Vendor {
-    #[inline]
-    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
-        <Self as fmt::Debug>::fmt(self, f)
-    }
-}
-
 define_all_pci_classes! {
     NOT_DEFINED                = bindings::PCI_CLASS_NOT_DEFINED,                // 0x000000
     NOT_DEFINED_VGA            = bindings::PCI_CLASS_NOT_DEFINED_VGA,            // 0x000100
-- 
2.51.0


