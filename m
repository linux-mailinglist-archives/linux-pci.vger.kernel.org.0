Return-Path: <linux-pci+bounces-34515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A99CB30D6B
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 06:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42897188E2C8
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 04:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340E928504C;
	Fri, 22 Aug 2025 04:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WbA5RUkc"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3501684B4;
	Fri, 22 Aug 2025 04:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755836005; cv=fail; b=Js3rQKyQdbes0k31YIYzH6V47ZjGBO23QbinswgX2TZOvXKqLKZ8g/GuhlX9g2PpGbK0EuJS/sJcehUnw+9AVWM9zZRMtLnz+F8peVzzaJcjHZTJn5mRdhNy6udYLjgxjlWYeKTYQKMwqyG9ZfaVy6sX3Sikte2OCZlsrBHzDfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755836005; c=relaxed/simple;
	bh=ypP98mmU/pOqQj6SI/S4GQ+hwTzGt9LKSIOzBqF88RY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cIKWDuYbj//25BC8Z7C81EkRxCyzcLisqefF87Vc6T4euwn4Id5VaCt5CQg9wQlQhknBe5eHwx4h6t1RTsrjfu/pxTdTPgxbRNzgxbp2S58Ne4dkp4sSMMEf7XR9wshHjUlW1DSiMHL0UAZqRSGts35ICfCp+WKdYfOrZbW+ouw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WbA5RUkc; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBE7TXyZvGUPvBzLm36SyOZS4Ol+4hDh763ZNmEdyHtfCmEkjVcmrMetbSE/5anH+L6BVilE3gnBF+65IkBjcPvnuX4BM9xqfPYwEyANDGTC7ZSZCJTtMUEo3WxHXrMxVBINggyoP5ZJXGfPB/odcdONAo4P0R+r9ol/stXf47iawwB/FX6vF73RgikHeIIBtsTcCVjzMlBerUxrS6Raee/Gq4fifvl87qihioRWKn6ZSMzyAYCNM6sF8P2pa4SImcBXrIMwUPImXTUCCwQunXY4UC4oqklwm8RzJn50VRaHvLnx04+F3eQGA6ribBkb+EBm95F3jVgG3r4lr5Rzzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Se74OElQjvfUpMTZmOkfI18BCNkbLz8LjSlGAE1KHmM=;
 b=ukS9S3nareg1jlhEcVhATNJfq8kaREY4pFE9dvpzUJFS7z/Y5wpSHKLNkT7DChscruv/5UyE4PY+FdoMJHDvYi4w8arr7E2r99Y+PL/Y98sEWcbXgu1qCLLpTtt1B6FWRdzwitCxXxvbkFRGuo5EPlReyLEICM23SEPLEmbEFeNzDBu3kbLfK8NPs1Y9ha4wZp+g6mc4CWplSP/gCtYP6xrW+YDBGTRYDHHl/yxpMPvk+3o2og3Nn5POAPP0MQVV0Qp6c/eASAR//9JekRP62s8X9IPaMWYi8m+4MaNvbrpzfwPiezR3vUONUIrnDGUL/H2HdA5AZXtIoTx1P4JJNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Se74OElQjvfUpMTZmOkfI18BCNkbLz8LjSlGAE1KHmM=;
 b=WbA5RUkcXCMbzV+hrs6JaKUeRP16vkKaHVBFuA9MxqrX9eCi22ZHss5l7G8cfPHwxPqU/qIjcrAK/9cmviQycJBZwrma8C9Qes7cdCKovOsbB+EGtNi9UAQlmM6MBIflcy62FKYB3+SYh6fxCHgaQwcuZrAvSTs5mp0N1/L9IWrmDvx1IqqUf3zMFIGC2S0Qf2WRr7z2mewr9Ifq2ORkOyYRQQt+2KqehudPeBRCzfU6XmbL7dTJLut3xBaWHD5GHn41Bh9L9U+b7mEBih95AKQUJnswBHoECmdB02nfoCfty8j/fMUmmtRdrQKvy++vVNEIjJqWa6kPjhHSOKeOHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9)
 by PH7PR12MB7965.namprd12.prod.outlook.com (2603:10b6:510:270::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Fri, 22 Aug
 2025 04:13:19 +0000
Received: from CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6]) by CY8PR12MB7705.namprd12.prod.outlook.com
 ([fe80::4b06:5351:3db4:95f6%7]) with mapi id 15.20.9009.017; Fri, 22 Aug 2025
 04:13:19 +0000
From: Alistair Popple <apopple@nvidia.com>
To: rust-for-linux@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alistair Popple <apopple@nvidia.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH] rust: Update PCI resource_start()/len() to return ResourceSize
Date: Fri, 22 Aug 2025 14:13:13 +1000
Message-ID: <20250822041313.1410510-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0040.ausprd01.prod.outlook.com
 (2603:10c6:10:e9::9) To CY8PR12MB7705.namprd12.prod.outlook.com
 (2603:10b6:930:84::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7705:EE_|PH7PR12MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c9e3ce-46d7-45bb-d00e-08dde13239f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TvwG0+ZxX1l0lXJjpGm1cWl9/2oO6oAYYzPxcs3NdIMk5K6ooqkTcvAoSI7t?=
 =?us-ascii?Q?cu0fEMVl70J2vNau57vl4Iu7Pu09CNKImet3xz4USwKT+3eB9+JqnON6IEe0?=
 =?us-ascii?Q?Ntan0reDMRux5XzS1yjbioWBcybsOU4oF59LxmqH7kIs2KDKac7k+3B1RvAJ?=
 =?us-ascii?Q?sj1yyFRPrGmi2T05gpyM3LlqTJ/n3XKfI+WhnVYFN9pV7ezmkLu2+GLqUY+a?=
 =?us-ascii?Q?JCoq2sPbtfvhxosU7yQrSy0ZKEZ/d1vrFC99pSeKacMy7bhTZK9vMbTSAGLj?=
 =?us-ascii?Q?JLvoRO7lkh4Azert7r9qyBZ5lAIMwXEU/LRWfcSxlJBqnwXROE993kLolcVN?=
 =?us-ascii?Q?RIadWOUFp0zTKoBEhy0ZwEn4bXrJzA5X4P9gvbxHvq0n1wNwt98KOQtk17Wn?=
 =?us-ascii?Q?iL0MYNvZa1YVe2ns4uJ9ImclmNocKptLaZZ+ltHsZJ7LbQ3YGdIqnvdGj86Z?=
 =?us-ascii?Q?b8znop4SwcyfqK5C8eq1IZluil/sqHUTJ5/kjtJ289t0Z1GSUEHoQuWeAT2l?=
 =?us-ascii?Q?EvXES2pbr4yC1hVM3QYb4TYZjkNCYm4MP/zFjr75Mjs6b5pH0iXr+kbv/nat?=
 =?us-ascii?Q?5/b5a/ovlFpSYrqiskKG6piUdDb3OlCmlZvkpGFF+hF+gTVgrmp1VkCbfnQc?=
 =?us-ascii?Q?NhlSnzj4By7WCHL/GdcLhqdhPLHO++FccsYW2m75HVbVrXIO2DKeNgaGHfgs?=
 =?us-ascii?Q?L6qgWSkI+XQVNmszigXwFxANnnlpmME2ijQlsdc/YatsXXMQVG7hi99JG6F5?=
 =?us-ascii?Q?PQJZ/AJT/dDXRwjYgS4rx8u7HyDdTNV5KomeSeLPc7zklHxQVe0UbszNnM3j?=
 =?us-ascii?Q?38D2X59n5YU9wWkMfo0m3I/2TH4w8C/OL3LgKFNKXhD2/NF3+vh69P5FY4i1?=
 =?us-ascii?Q?Q7sg9sxKC0YotNh9WNT7HQXvsSR804y6CUje7jG+UnPTyHCYKXWf6LQZbl3j?=
 =?us-ascii?Q?oxGTNakGiL0o1uZDDcwYOeer8bgEpAogMzQlXkXVdSjcKxXsPkOrfzD+ZtYg?=
 =?us-ascii?Q?NVacufU2vv6/ljMn8nwUFHGW9iO0hcNWPcF59B9VaDWZuzvvyxgMxjggCRBb?=
 =?us-ascii?Q?HYI4d8gldo5C04vxD/2kj37ezdFC6eDXO7kKYY5xuWYeerdOjuey7EfX/8az?=
 =?us-ascii?Q?uc3PxafMaXrg1Mpf/2U4c9nOK37i5iTwHAETb//4KeBEkvaU7tVzrJ8+sZs+?=
 =?us-ascii?Q?S77jTMJio+irEQYdlIFfi0o6x3hiVnb2uFb7dSPsCE25KvjJnOvRJJWJ5G4P?=
 =?us-ascii?Q?8dKtEgVFphYEikcFaSPVvKvue3VD5aJwX42xn230ZAqL1JyYe1xs7Ku0xyAH?=
 =?us-ascii?Q?BhHojLWZTephaRC63jbfIlURDKhzqmFLBaj3eM9ywCIFrWBgBDRTzkNelFO1?=
 =?us-ascii?Q?i2OzFNMIXxyDbqnVLLJLmmTYt6uRwcVZ7liYdzDuZB+Aah1hsbIThWs26Ik8?=
 =?us-ascii?Q?ncMkmkiZFTI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7705.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RM4GIbiF+LEV3hdTxHFM6Zi2QkzY3g3JnU+CIp/mCrnH/7jewfCyeECP14QG?=
 =?us-ascii?Q?E1vW6515WLyIfCpKQh8xbTQVIAyq/cRwtJKhTIF9hWooz+wZrRkPOK2niJzj?=
 =?us-ascii?Q?IRCUNmwYlDjemrkVpNpKuSJ1ZQGKcocS5eZFfyw3q+fQHxuTBgYF6bpvIz9S?=
 =?us-ascii?Q?I49wX2u0pCZM4P0aDogLLfVUVImeEmu4d3briQXXN1NdO9ZgiBA5dXTYnFrT?=
 =?us-ascii?Q?nwV2qqRT0cTG3NywmdT3g/VRqS3b45g7Uj4hE3suhKMaca+JUD9A63gUisAl?=
 =?us-ascii?Q?4aj/XRLIlfNSN2LFAn7GA5r1B436QfJb4D8Vavn8WsGWfTV0+CmkIlGviZBx?=
 =?us-ascii?Q?fKPRo+++oGgXih7VFKvwD4ndYU/wpu3U2kDtSBXOMBZGckMI+kjyNc/Q4A6p?=
 =?us-ascii?Q?zz8MxzZoS2r1t+VBApk78ggOHwLGHipjZuGURWqmpATgLPKRk2XMBuCSbjyf?=
 =?us-ascii?Q?0yM/GPkEdu7xTFzYzLlBNHYDtNvkiuvStMbflViSNK2+sLeJGoVMYJRJjbXA?=
 =?us-ascii?Q?fjM57WZdsWhLr/w8AhLR63akn0jcAw2oAQax2YC4xvUFTAO4RU5OIWPz5ZiH?=
 =?us-ascii?Q?y9RFFegiPy+SuX/zTpafE8XJVKoe47HEjK8zHWqa697nkL4LlyCPQ5CkqVc/?=
 =?us-ascii?Q?zqUKTizD8Ce35wPMeUEQ9IdB9koLrBz68alU+yR6Xcs8hZSW0y4CQ7PyeCT/?=
 =?us-ascii?Q?kPpAJiHE/1dNB2M5sebNUQzSJHid0wBQ9gBRebt1aCOZhqTo2Q3p/+UAmm6S?=
 =?us-ascii?Q?HfgNCTxRMPWQOfzVoPuFtsgf+/5jZC7DQ91FN/ZOdr5RHnXrc6Bk+jq/sPuh?=
 =?us-ascii?Q?/+jy4bIHFXgVkMUKGlXMFbSzbBZhhAByGTLk+3rKIa+77u1iLL7tHwfGHKvn?=
 =?us-ascii?Q?q98LWqrXfkPPtua42UAeLCPeECTht7d5Fsfbs11tcbsCxKvo7rd7myNzGn4f?=
 =?us-ascii?Q?f78Ofn8D5QYLnRB0+kRptpYwomS71kjVFJ4XmkytbH0q9egTjuEzgkeq9vt8?=
 =?us-ascii?Q?EHVFIu/wQ0Q0qkfeIZfZjRCXS61Ja0f6boPAmCoQ5N4F4Td+9RF+SjFXC8Dh?=
 =?us-ascii?Q?6Ue2Qfa2FzMXByNxpvQbGwu9VH3tLcXiwaD7qb+jasVFqjnSRhroTRruacog?=
 =?us-ascii?Q?XDygvaHl7q7WbKIGXCcF6ZosJe7nUp+AunH8KgGUTkEwMgpX38TsnO+0vXcG?=
 =?us-ascii?Q?b5cvLMpQmIv7l/R40BSTjBKaE1ictoqoqNrjjG0a+qH+Q3RzJuKkggQRy1oX?=
 =?us-ascii?Q?+z8Sx8CeYbMPt806R73qbRZuM+vwNi1ipAIhcv2/PysXyVDj1Ku260uVVR/J?=
 =?us-ascii?Q?TkSVo/HkdvG3ZjCkxjVKifGoEru8t1bx3LkS/Qf+I+fwVe83FXeRJJyRO0Ix?=
 =?us-ascii?Q?W0bx9QoaCW+DF50uBmWbnrlJl8FwJZ/UGNOWvtnsgokEjmfHD6JMP+9ddjpD?=
 =?us-ascii?Q?PcSLVwQW3wkTyxi7+y9GHqtYu1A6Rm/l0vW6xTC6KAWFHOWFPK7VbbRDK7Ah?=
 =?us-ascii?Q?NseZNE1qZzVSIhVcOlXJv40y64Hhhm/Cf3iNaoJmjSPWqC0A4Mcmuf+n9Fji?=
 =?us-ascii?Q?I64t5RFHWVLt1ozGxeaDv/091r3IfOdme+H1wkAk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c9e3ce-46d7-45bb-d00e-08dde13239f8
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 04:13:19.5018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yH90LPyXWnjxtYlKuZSByIVMWgXN0YcFxhAISqBsDkQ7Tnf2LmeJXNRNoFdF7Zsfpb62LvhdFsnqV04PM8Txow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7965

It's nicer to return native Rust types rather than the FFI bindings to a
type so update the PCI resource bindings to return ResourceSize.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Suggested-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index cae4e274f7766..ef949ff10a10a 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -10,7 +10,7 @@
     devres::Devres,
     driver,
     error::{from_result, to_result, Result},
-    io::{Io, IoRaw},
+    io::{resource::ResourceSize, Io, IoRaw},
     irq::{self, IrqRequest},
     str::CStr,
     sync::aref::ARef,
@@ -437,7 +437,7 @@ pub fn subsystem_device_id(&self) -> u16 {
     }
 
     /// Returns the start of the given PCI bar resource.
-    pub fn resource_start(&self, bar: u32) -> Result<bindings::resource_size_t> {
+    pub fn resource_start(&self, bar: u32) -> Result<ResourceSize> {
         if !Bar::index_is_valid(bar) {
             return Err(EINVAL);
         }
@@ -449,7 +449,7 @@ pub fn resource_start(&self, bar: u32) -> Result<bindings::resource_size_t> {
     }
 
     /// Returns the size of the given PCI bar resource.
-    pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
+    pub fn resource_len(&self, bar: u32) -> Result<ResourceSize> {
         if !Bar::index_is_valid(bar) {
             return Err(EINVAL);
         }
-- 
2.47.2


