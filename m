Return-Path: <linux-pci+bounces-34506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 096F1B30BA3
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 04:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00CB586814
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 02:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048AC21256A;
	Fri, 22 Aug 2025 02:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O0gU1V+h"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405812101AE;
	Fri, 22 Aug 2025 02:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755828247; cv=fail; b=GSggs1Y8j48jaKLbRHklevOs+zO2PO9E97vV0bxA8sIAY0L67VZ1TtG3mLdzLeIYjEhZTitzL9Gudp/bl1Js2aWZea08zyEgz/BJC1/A4rv5nFQprbMB6R3s6jucIpZqMnciYWvjGp7bHgMnTvaxBP8zqz3B+WIXjqsG5M8hZi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755828247; c=relaxed/simple;
	bh=gJVGVgmPJULYZc2O/HmwRnUBDTz1MshPTMqu7UNhhag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GkIc4BKlEqRn3ceKhII1m9bznYrId/O0rgXWP3wF2dcJe7sYxlr79T5oPDRTySJjX3sMvZ406cX2vbeWkN80D7FtT07KrMoVPve1fgXpcBVA03JBhOLJtwDZHZG5PfO89J4ANP47MVqPRo8gXBXzigF7s9U0JgdU/YenW8xjkko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O0gU1V+h; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ow3YhKCzmFWBfTwy/RNT3GHW2WE5snXH1EwrLAx99XYmYTVsNAe3HgOeAZOZ/McQT8Y7QsVrT1xxqy6jXS8B5dgU4tHlSWk7qJSLrHfqGowvmvtbZhAybB/7r8SyKO30kfU2S1oNQ277/6yZIO7mgxe3QGSCgHvkJ8Usl40dHSNHeNIjgLjLWvsTc/Vzmn1SZzKboPv3e70RM5Rh4JR71q4MV4a0uUob5ImFCMlQA81Iz6j8bf1/ssm7erJg+PKDMamJW44yqlqEaAyaxjWHkeLzh+9RT1lE+oUwrLefYvrv1TBu/wsa4Wjt64AsBl7CTGc02Hjg5zh228zNCmZsLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbEfdLwhoaC7iQITFG3BVrx0LY8hd2RLOOpPZQxcSkQ=;
 b=PYTSMqo1PDozZNsrnOG2AXJMwRTD95KLauZJrXbxGmcxePkwbzkGz44gPdEt5Lgjia9n8JoxLMQdrQs6Q/DYCbKuBrCYECZSOImghT5qvHEMOsv++biZNsOS+Mqq1boDYO+YkFeiYvmAP0ibS+aK/Mh1CYj4f4VhMiE1AbwQu6Bd7BmxZXgKMfutZGXALH7UT25FK77a7yy2sIoA+2lojwVtJVZLT5yfat55jKiylpiDV7PlEYQ++DSIrbEkUxCkwEXBF7Xw3IRuEdr6ZS+o/gUguO4+0DLsyJBcFamQ6CdrwPxkQA4iZdsSdD7LaEFXYhX/xsakCXEBAPlPi/oqmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbEfdLwhoaC7iQITFG3BVrx0LY8hd2RLOOpPZQxcSkQ=;
 b=O0gU1V+h1gInYDH/fCzuRLz2+/pzR9bIMMBvxHN9AuWY1GBgJPtj2NIVFBrHuRAF8NqzAOlVruf581LKEDjGs1T9bIVXk9hstvYBy7xvH8ZGkDMtRZOnKFR70KBQ/Li9AEDj/XxdKbIp1enPojLpqSJ3c1pKzRsMJ89Yczj9ClnTjBMwWIfMTl9NcSdgZDXUMN24D2iJjzc4UEmMwhZIR8EIf4WTF1F4G9v40Z5rJsisqs8Mznac/M63mS3cEyc6TlhE0nLzNUMHUUx98Gleww9VVn/ntZ4NirEVdwwo+JSCXURMLtY+TMAmRAMX4xG+bKVQ+qKQAOs4XFWGBfTdqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by PH0PR12MB7907.namprd12.prod.outlook.com (2603:10b6:510:28d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 02:04:04 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9031.023; Fri, 22 Aug 2025
 02:04:04 +0000
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
Subject: [PATCH v6 4/5] gpu: nova-core: avoid probing non-display/compute PCI functions
Date: Thu, 21 Aug 2025 19:03:53 -0700
Message-ID: <20250822020354.357406-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822020354.357406-1-jhubbard@nvidia.com>
References: <20250822020354.357406-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:217::10) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|PH0PR12MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: 92a44324-aacc-4a54-39d8-08dde1202b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LEWxI+wejpLYEUk0pNLhJOmX/C8r9msi4HGN9k+smhw9XqeAJ3tGZqksM7Ch?=
 =?us-ascii?Q?oStj26APdCwyja7/O5N16sV6G/83b0L1NCWKxyM7pmjqMa+H3t+xe2PXyNYD?=
 =?us-ascii?Q?Ji2LwhaW04GjQK4UxwLYxcbBuk/d6hY48kTAyScFZ4sKzWbDhwNosVl4kaVr?=
 =?us-ascii?Q?MQ/y6XuS9+cnUGnIlIhLL1dtENItD6dmBq9/B8c/jkt+3r9hsdgfWSJj6Fmx?=
 =?us-ascii?Q?7ZeztZ9qY/njfJLmLVN7l1SlEWv4tHNaQVC4ffzf3Uan9kpRgk58TVFv1wTs?=
 =?us-ascii?Q?0VMNnqTPbcke65Q7GLWcMmB2Nzn1ECAOjGnYihzPJxMTUU9pDtKuu1RB3RxL?=
 =?us-ascii?Q?jSO8kZNTBrGwG5Nd9YFfQe44bdhH/kchf0sEB3fU+fqtPzpVMqOa6QRCZk+U?=
 =?us-ascii?Q?ds5b9ZWdhHOzdeV1s4Xd9lIpMo3DT6bEF0bNC5QepQNUhMfBsgyXRPxt9jQ7?=
 =?us-ascii?Q?z/4ys3wM1O8pFLcMX5nobDHNTFsuyTPcDpxvxbNO/CO5664yaPNYhZe1Dn7r?=
 =?us-ascii?Q?e5aS2wj/X8l9efSABW5+opIg/5J1Jd2JNGfPpbDONyxVoC7nHN0lzL0J6FGX?=
 =?us-ascii?Q?8HpXt07IEt/vC20uLB9fFcQmj+xAWA+IulLA0F2HdPQU0SiQrtg1dNF5PUoL?=
 =?us-ascii?Q?ICplmTTrNhgAokLmVjPKDK8qYTp8fAyYvsZiMTsU4m30khcbGmMKQSQz1qBx?=
 =?us-ascii?Q?8gt81oArUzc5Yso+2asSra4vgKNUlC4i7DTPpMl2l2I0j7AcRebhOCVsyx0l?=
 =?us-ascii?Q?LWblzs8rdItqEV5mJxXd6tcHCYOyIMkvmEZfvqwPnPAUXWm+41OuyjAJjJ+R?=
 =?us-ascii?Q?Wpm9WfK8VJf6e7Nkimlu9rqC3Q03tb2dIC9J/kZf7tQV5x2c/DwcIy8Htr1q?=
 =?us-ascii?Q?0IbENkt9hwTe0ygLRVkC2COUSTzN0CHDpXjLKiw68zqRIOSbNDMvAMLodS7g?=
 =?us-ascii?Q?6Fs1PdifR7knDHpDnjSpuYTI+UtgmY/UaKrp3UhM2LgP9qszTUWa7E6SUae1?=
 =?us-ascii?Q?z0EKDkz3XchMammb+3VdMTLkBVwRvmRcphtNJprOb6IC534A0yiyDztnFjJc?=
 =?us-ascii?Q?RfqQfrA9x+YU2kB06Nrj5/iMQsrysQ03LCL025p0mW67nbZUIFhjU12+MI0e?=
 =?us-ascii?Q?BsNmRh7ActO22HHixvIszYgLSmdqOev7WB7aBPpaVRGvBAjItd2nnnzhrLeH?=
 =?us-ascii?Q?u7uZYPVLspAwtaLwsrJG/Jdw+Xo9L1vriuQBnmOkLd6JuXfsEEQmXSe2sKtW?=
 =?us-ascii?Q?P/Mj5CgAlM8O2iZCaZTKvh0n10z9IDMebnAl+3Gp2mAuXErn6MRkWoGJWI7P?=
 =?us-ascii?Q?2gjbVDxYXCnaT2RdFB0kYqiL0KNNk3FjcfisiOcMTKVwz4vrp3fEEoQPKCML?=
 =?us-ascii?Q?CtKDByf8wuOQvmvNzMFjAQUEGDXQ2p4LZO3w3WPPBHEu3jDIzDhHxmJVfw6H?=
 =?us-ascii?Q?qWcn9GqB4rU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mTZnmOQZcVdmn28lB/V9pNLzsiFR7aK2QCZV/fZBxI5wcOgMNWZTxPHXDVjm?=
 =?us-ascii?Q?aUXOUnv3/JO2eAkZg7/+9YpguPGsfN6J345IfLBr268RKHdCyOnN5bWdLK+Y?=
 =?us-ascii?Q?Nh0npj5kH+erMsGwHoHIWuZlJx2vaAuPBP9TMdo1UIO7dnzh3Zusx8J1S5l0?=
 =?us-ascii?Q?0i7QoXSlooLK5s64uVTmyvk/g804cBz5OoT64LQj4lLzSWjRcD4idsCBuUYt?=
 =?us-ascii?Q?CcQh133/FH3WkPi1ARBI0dSwbCdF+Dvj51iF55CoixpEmx207FzVyfUL6c8c?=
 =?us-ascii?Q?482OVvUVYQx1ffTeF3zLuw0zw7r34UQJ2zq83vo49BNoCeNt2jlnzVvT1nlf?=
 =?us-ascii?Q?TfigOJo2ModnQK5iHiZcHmMlK35i9h0cloco4k++pJ3xhWzKQWvGMeMo1vqf?=
 =?us-ascii?Q?WtfdWyNnFzvgQYFtgsAeuq3UPbVfv5Ttwk9ghYni2m6+6et5zvDMLv+59tnl?=
 =?us-ascii?Q?g59XcAEvYrINvP0+T9hWGyI0E7W7TMnvKzA/6wK0MgSuemBhI31OeaX87172?=
 =?us-ascii?Q?+2FQyF+gKa2FeYsO/aBoM8UuurzW7gFYNFjj+rNVn9KKONHywLGx/7L7WF5W?=
 =?us-ascii?Q?i6f23BNqKl5jCAZSkSa7eHUQK4qK3dGJ2Bvp8i42uJ9H7y+ij2ZPaIDDNLqy?=
 =?us-ascii?Q?tEQ8L/+GZWCCEvOG6cjLbZXGeLxnOofBdvMPO+FHUayryF5tCtn6paYjw96P?=
 =?us-ascii?Q?aF+AK38tPKHDctLhIkMLMKZ2exvT3nIQOWuXVQ76LD9GHH5I7NCvR0tAeoqa?=
 =?us-ascii?Q?9Kj0kIiUZ1yngLhYQXlRO0ga8eFrlKqjSu6WTkSZhJOtAhrSCLb8VzyWFuEa?=
 =?us-ascii?Q?21qr6LTFM5U13h725bHPRuF8twNDNZnUAODhb4U//FaAjYbIDasy175PcVTb?=
 =?us-ascii?Q?pOJ+fSj3vVSwRaVG0ZGtXAHwXNkzDUZabN22Lm08BfwZjNgTsGLy1mMFEMxp?=
 =?us-ascii?Q?h47uhCUAk3NRuiKW7M61YKiR/8yjbiltClNgIBVxXzYInNp5qI7n/7iPZXh/?=
 =?us-ascii?Q?ImxlizT0zhIbIvIOsCGlDfasRVyOgYdQNxY9SkeSHGIR9cNcaxNdt70aAzns?=
 =?us-ascii?Q?vczTIM3CjI/dF46juFFG5cmcYtUge5SvrZAp/b26LX8N6kYGv4tmobiZTITC?=
 =?us-ascii?Q?37sXMrqlVt3oWGKI16NaT0ywbsYvklK16HlF9eADwWzrlN3fJRfWPJCxfIXM?=
 =?us-ascii?Q?pEUpEJtwpxjnQ1Ia5OUCul/kQojppZqez3HdObvj7yC1YVFkIaw9zCQFHmVy?=
 =?us-ascii?Q?qgalHcwL5r/nK7yA1wDKFHgkyAi3YQXIukS9eLm/HwpNJbNHTL97xTP5gnvK?=
 =?us-ascii?Q?cb6h38gxezflM4Kmrzwheackrxyg+0NWe2xZdaoRWR3lx3qhAf4mTDqaIqQc?=
 =?us-ascii?Q?AKc6JEnAazXMUBJ6wcmdQOxX7VhKnXhzKJe9Q1mEznhGMAyTWTIT27GR6bF9?=
 =?us-ascii?Q?kmE8SU//larxuY2g+fUeu3eJiUsdhIWVccUjoDcHOMicqaF0wEbHW6n1Ql7t?=
 =?us-ascii?Q?+m/S7K77Wc2H0Y4fTW8KpJxx/EtwG6G+pgKL/49NhVX3ZxKAXgui0PUqZGMh?=
 =?us-ascii?Q?O2+lK53TM2GjPjnApA9J+zcxNWc1qd+f9dB9qmBI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a44324-aacc-4a54-39d8-08dde1202b63
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 02:04:04.1750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rb0RUJeK5cKswOH1yNZy0LiOoCDqeU7eGFvDZT6bdtPABepdbAWJsBWtJ1iTifi6Ej+drDL1CYwWgLV3mQ8Szg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7907

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
2.50.1


