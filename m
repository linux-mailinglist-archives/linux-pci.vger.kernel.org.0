Return-Path: <linux-pci+bounces-36915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 468D5B9D089
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 03:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8567619C677F
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 01:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4DF2DECB0;
	Thu, 25 Sep 2025 01:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IvxWugpg"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010014.outbound.protection.outlook.com [40.93.198.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397A72DE71D;
	Thu, 25 Sep 2025 01:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758764053; cv=fail; b=Vj8rirBRVW9+sA1lQOoo8lEn0At7d0MKC8Q3UAugdF4SvF3qJHwcJDe0h2R9BYASzbTvenzaaW4uIn5wvW7KncRkHmt9cxQmROjz3r7KOSdVjBE2ctqz0NQGJN5kqZeQm+I6fmUotFFYNMbEtG823S3W7pYP80zTBmk4g4kBOZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758764053; c=relaxed/simple;
	bh=fzqIx6Do/4btDuluPbH3Xmq3JYGMbFK+pqFjGyO1Nus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O1SZLFa2jdKPzU6mXarKR5mfTi7ENPQV3vdiXg9jVjBArr/cgWau+SG/BMGPP7tRl6QaBGcgrRCwMzMkY8UTIhWD2P2iFDTs5GVoW4Ec4249+YS168sYcZv/Qbb0Ag/CYQtICmwOYG57NMxSPGnHVstAQtIh6qURfbSwTQEw8IY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IvxWugpg; arc=fail smtp.client-ip=40.93.198.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h95n/0MQNdXbbnYgpw78TCrkJ6aOXXqQ+/Ul5BJ9+fOAe8vUdaO8a9u3IhUAJ+o5tKLZzfml0FlFtpYxXUdUc9mU8+UDSMhsWwnBxK/QPdpQ9Rqo/rjazHPDVzPFh1w9kPRhwg2jkA5AoH6tXThR94X8/OYiOip9BfYPhlhgIPNAQZA32a+8H8PMQrZdpkSuIxrBO8ihq0lzgkULWK7EefMgVT/4pB7eKPsv03joUXOWHjhkmPUaeUlea20T1pQmFUX3qNuEJLADAIKGDPwCsxub/NAHQpLoOcIvoM2Gc+HHXTRLLgYZ/wb7nOjG97WD6qtl1u5btHfml1zynYcw8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxl1aQQEcXGqUSEKUJOvPsqSqFXzbNfQYUt7eWVNx10=;
 b=w/ZARNPUj/vQbD734fH4rKaLSY5tts1xzYnYxL+JHymIFSW5T6fZnpXM6wlGLKYEpbS8QDtzcuykGJw726uE8dA6MgqY0bGQLrK9JQkAbeqnSnOv1565MlNabNbmY6e+Rxv4cWuXVjg537KkKPfFDhM+pxoFDE6qfNjZ2s6K2hspL0ibgiEXvTByMQPOwcnThusBcAn45g/rgqV0zzC3mJvZxgMp9E5zP7zA2wXZyrSeno4Q7vV3mtAhMzvivkTIrGCeJz0wzN/HXDsqUsNmjyU4/G9rHZ/AP6uguzHX2VhYxEz7sz0oaj9WKWVkPe1+AAFtx4Te4+b89zXcHSyMzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxl1aQQEcXGqUSEKUJOvPsqSqFXzbNfQYUt7eWVNx10=;
 b=IvxWugpggVSleCQhxoZWQaFVGRr34cfOia2UEPWR1xdC6ONaIhe+G1Gukrxy/sxAIl0CR57diLhkSHXHRmKoSIXImAKMPSmzT5/TY664xHVu1Wupqs3FnhUivkeon1inx2eR7BvGbB96qtTEnfrAtblGhvz8JzT7hk7bR60YrFHajHcFAf9t8A3gKVne4UB0+j5H3ZigpgKZ2CJu2MticXNlJtP1GHcamtRBKh1GzciN55+9xne5YT4IvzDknKz0bcusWCL9s3Tpzf60Q36imZRD8cgLH2N3MOjXaNL9FhdaZpeKyGB2zmqO9w+XRkhYFITl7WyFsaFMHmZHc3HQsA==
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
Subject: [PATCH 1/2] rust: pci: display symbolic PCI class names
Date: Wed, 24 Sep 2025 18:33:58 -0700
Message-ID: <20250925013359.414526-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925013359.414526-1-jhubbard@nvidia.com>
References: <20250925013359.414526-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0058.namprd11.prod.outlook.com
 (2603:10b6:a03:80::35) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|SJ0PR12MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc0659d-a7ae-4a54-edb6-08ddfbd39dcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U0g2SvCoQ3Smqc2quKeQFG4wo686gfHNlFcyqA+v6ZGFg6nOYylr55yA9y5p?=
 =?us-ascii?Q?1S6dIk/H8D5k7bLCWjOHhfJT+F7ZbrqtL8mQQqD51hv2xK2HDE5r6ZkSIBld?=
 =?us-ascii?Q?mxd3bLBvhrmV3pmam/Cl8KHzVtCMu0hckRvpWuivJ/Gxi5aqID7/yeujeVMt?=
 =?us-ascii?Q?YUfYjM7yqhq5zQeqBn3vYWRdQFu93FfUwqWl+haNt73S4x8JJhA/o09IMufz?=
 =?us-ascii?Q?2vtKDTdFkiOIuD1hW42prpAWQGA45VJqskFWBL400D3InLYTdOA8KAT5EVlS?=
 =?us-ascii?Q?U94C7C/MgCxN7kokPRDkdp67Q37Ym3eGNOVbm7L5hq0sqfHRJEvCoFUob1O1?=
 =?us-ascii?Q?LqI+KQkcFsBSGNtLP8NmgnjjLGoY0URrULNp+rdl+4GBKxa/EcSfLZCAkfFR?=
 =?us-ascii?Q?25Sz23c24YfGbva4E+AzCRYrTl+Pk1fNrLcBE/x4DG4O0A1NdfPR+9HwFp2d?=
 =?us-ascii?Q?YGPZbA+gtElm4pZkjWAfugGabvBZ+Fdv7pDap2WgNdxIQkKjI50BRtR6155g?=
 =?us-ascii?Q?NQkImEJlYYW1dn1zQTxwPZhQLQoRi7K0pnWag0LVAdbNE5sZoTT0r+zlsC71?=
 =?us-ascii?Q?Qge9JtyDBFdHzvSlgpZVjWIkknutRGLigJrjADm57eDaygsx86sQDZ1dwuGP?=
 =?us-ascii?Q?2vhrrWSLKhlAxb/1JaNoDlSxC2o6bfdxKPMhDyxye4Lt7wMvMDSsHTIKl0x5?=
 =?us-ascii?Q?Cy44RqbTm+iegejBptFstMM4ewycWOaD+DlVMKumE4Z8BP0qu9ZBIylXZh/D?=
 =?us-ascii?Q?1YQKzjLBOmF4qnf5iTJy31773w6mCv+aMhGjHiiLHVHE4SmwSvtLF5BlT2Bu?=
 =?us-ascii?Q?N+6aRqCUqhxXliljhHK/DbSCSnQw2R34uxhcvryATuqlTXGzEildfNbnLRRx?=
 =?us-ascii?Q?xcnmemlmRONc92XoDc6LBY+aJwPn8HB3ZUx+L8jIz3aq4ZhF8Oo31FhR6gz1?=
 =?us-ascii?Q?u8bQxf9u/CFvGwDejf7hlOgsRxmMvsQWVOM+eBEzYDSvu4HcD2yilcISaA1Y?=
 =?us-ascii?Q?FGQ9vOChc64MKaMWr8I6/19kujL6PQhj2seIS0t+4KO5gbWwiZf9PwPjUk6l?=
 =?us-ascii?Q?4BKsUnr7H7JNOElVzQYJejYUj8WFsucmSllzOmJ1EugTYSqBpNEs9/Bf8V5Z?=
 =?us-ascii?Q?SXXbVNruz4bBRU8j2mjsL70IGUDLyUK/vCQZ5Bm3CJ3Ec/Xe5OOiYBpaDbh7?=
 =?us-ascii?Q?/nOHE+5UPuTQqUYhBGe1JaJBJWPbYrOxFb6xWcN24Ahepi6CmhmdeYxaP9I5?=
 =?us-ascii?Q?UmYCXlCA4u7b75CtCk7RZX7daq60+ghA50UF7Q72gALYNFRyPvP8k2zC9APK?=
 =?us-ascii?Q?45gl4WE3JH+99ch0bDM/fkSy89o9bxxDe+YSup4ZL437BPDZcDB7HSzHjRco?=
 =?us-ascii?Q?t2CQB88Rf6XyolGA4weOz45VZ4m0e6FblQUOp5Fs53KZzdrslnNyahPnKeCX?=
 =?us-ascii?Q?YIb/pwYcx4fqzrfoxufB9phCVpicBDbn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hxk1O8iN5RxpLl+naVL8pmdNGlKlb+AkT9Gb71V+cQP1Y28IbwrYst7c4vCp?=
 =?us-ascii?Q?RL4xvkEfBYgbH3jE8r8La+Dk0pdMsVB8cyxY5ybE5GMrJH0ohoHDyx2P7T0d?=
 =?us-ascii?Q?M3FwXDft2ia59NlkD+cjPTZlTfQpsyCQ+P/YcSKAi42FJzjIkIuxqZFp7DzM?=
 =?us-ascii?Q?ecjXsMbza6bVxoFSd6KdVrd+lpJQyC1g7oe74yy5wKvMoIU1eTy4Ne72qwZz?=
 =?us-ascii?Q?kQjCBRD+7ImgEIk8W9mniMv1OQJniuYLV1q2/CmfdIBxHUst0NByIiA2fW1r?=
 =?us-ascii?Q?R+0bixeqMfvHgEwVLDBikw9fXbdmN/77F+WQQNuQIWNi5+eLZIJQ4SGMSw51?=
 =?us-ascii?Q?wCDWFjkhe0Areb5K3mZKyamTZFkinjWLpmH+ZHWs7qHJTUUa+I3531mFcEvC?=
 =?us-ascii?Q?4ojwos68bVjE25gCPUvVhj/z3w9uzrQlZdWcce5VEUML+L2TdAEp06Bduteb?=
 =?us-ascii?Q?KHvRBLK6ppQUxlzOFl/uYEdUuFFxgpn+SDFIiOsV4rKk3pfOH4oxqXsUEzll?=
 =?us-ascii?Q?R8yo+AlB7fBE36cZCD8wrIBvw0cOGTQJSmXZIyBh2zUckPrOzbaD1YTk35k1?=
 =?us-ascii?Q?AH9eDvKMiROUmTB+dC4DPaAIwQdhEbkmov0VktVCGnkno9NRnAqLsg5ZXaXl?=
 =?us-ascii?Q?dwndp2ePqZ0FMLyTqd7PxnVJUkZEvDJ7JqWQNOUFrAZ4d0C7SDPir3kfjDty?=
 =?us-ascii?Q?glGp15lS+D1fNaCLH25+kPgo8qvPZYRtUxJHjQDtWSwLiXwU6tUOIQS7EyOr?=
 =?us-ascii?Q?PbCCCRyEi+au/UlWbOBmXaD4+dcUOrvG514q+IduN9hOJ01Eie+KoY3FYe9z?=
 =?us-ascii?Q?C/tq6U45W5Bm242Fpcbasl1Tw2c5CffQ/JqpdbcMZcHiCBAeEG2GYNZVxvm7?=
 =?us-ascii?Q?BWDwFQkVzSYIBRQHuCBC8vLsqQOzDyvYjjqktlLRlggwFcZajFDFMWUtOroy?=
 =?us-ascii?Q?AYsrqdeKI9RjiE0VxKGnB6+shY5hyGm/XNhel0gp9mS3sbLNVpRUlMmd+emZ?=
 =?us-ascii?Q?tbeB+zOe9Yy64pLEdIy9jBEVusD/1a0NCRRtfrLtSFIw6A62AsOWyJNvu3Zm?=
 =?us-ascii?Q?93yU1VXsh9/V4Au0E6tYHPlX8vSenv7gMgU8l0oAVlQesCkQWu/FAY6EZ2QZ?=
 =?us-ascii?Q?kM6ARaPpjZwJ1DZacDapqhX+RPs2MMFD3cvfMg+qV2IsUHmGEi3Qfb0yLe3L?=
 =?us-ascii?Q?9k+mpoiH2qp0IFpALmqbYIuVHY0t1qIqXY2VzU94hjAlTomworopsaJUhwDN?=
 =?us-ascii?Q?ZjdKYw0dXNw5PQ23yDwrEH/bYZn3YLdQ/3HCEmjXkVcrhDHZy9xTsVFu8cx+?=
 =?us-ascii?Q?DuaKK2ZgcT2SZTIKoUROT1RBzN5fb+7fJ/8BDn3AKZjTE0r8Gtt9ST8Ol0g1?=
 =?us-ascii?Q?o1WTicYqQ9qkGQrOljq0FH1sNV9kcbD324nndBgHemLDGigiAwcXmBVm0ocz?=
 =?us-ascii?Q?alFWUb1A3Pp99z3qH51uLmknXcW0JOsXXBH26P57iDrxtHNIBxI7zrzZz9F5?=
 =?us-ascii?Q?DOmc7V316AkbvPamNI3mJ48IW/p32GwlcTvlfQeGk8RriPYx8s1MCC+pjvBP?=
 =?us-ascii?Q?LLwRFpFvYXxdKqasAS62FM+ISwpZQVJXQORWUXmP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc0659d-a7ae-4a54-edb6-08ddfbd39dcc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 01:34:06.1828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Ir21tdpjFIDE61hPcCmBqjvraNpCEobV3rs6OvbwXtcm6Xcsh5C+tyROvFl6UlS4XT/zhtFjvZtEK0KpCdcfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6879

The Display implementation for Class was forwarding directly to Debug
printing, resulting in raw hex values instead of PCI Class strings.

Improve things by doing a stringify!() call for each PCI Class item.
This now prints symbolic names such as "DISPLAY_VGA", instead of
"Class(0x030000)". It still falls back to Debug formatting for unknown
class values.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 rust/kernel/pci/id.rs | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
index 8ee1dc5c3057..6e081de30faf 100644
--- a/rust/kernel/pci/id.rs
+++ b/rust/kernel/pci/id.rs
@@ -50,6 +50,17 @@ impl Class {
                 pub const $variant: Self = Self(Self::to_24bit_class($binding));
             )+
         }
+
+        impl fmt::Display for Class {
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
 
@@ -87,12 +98,6 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
     }
 }
 
-impl fmt::Display for Class {
-    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
-        <Self as fmt::Debug>::fmt(self, f)
-    }
-}
-
 impl ClassMask {
     /// Get the raw mask value.
     #[inline]
-- 
2.51.0


