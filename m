Return-Path: <linux-pci+bounces-34002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 291ADB25784
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 01:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8B65A7C38
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 23:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA0B2FB980;
	Wed, 13 Aug 2025 23:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jtAWmxKB"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88462D0C80;
	Wed, 13 Aug 2025 23:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755127752; cv=fail; b=ahlkf6vSrmzcrTtvmkgDTkyj4YWUUjUkHgrMosbifuQjiTQbEjTKcO1zkjbEtsAlyYqL6Q+3w3aV7k2QGPEPiw53jKirmR2pxdRVJpv8i1fkRbn55GlwZtyAvvY4UV8CnqQMb4cslBIdU3Mzu3JxzmmYt7cpVMtb2C4chIEE4DM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755127752; c=relaxed/simple;
	bh=3caN8gwVBREgNKDTn1YYCWuiZCKZGWgqUhzyDdqSjBs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XPHuoWBzi+bHiMVXsnE6XZRmY2dpkABdaTgza+OI2d9WxCLCWYwDv4Fjo7nwxvZIw4YreBu9vAsJE2AmqLX1elduRSOx5ZL0gyM3nulgrwp+Tz5A8tr6wa7z7q4ZZKPP00kdkUGTBXYncf5joEwMgL0hCV+yzpPlaqD1HpyZLBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jtAWmxKB; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unp5PIM9byZjHbjeIgym1RCbRmFNm4jHkjWO0H6M8DaRLe86HpVIkjJlYWKhq8xSpMFt/gcFzOhVxglRBfLQ+RVmjMar/CyZGwg2fDW7ai2st6IkBEVIOK2vMlxzOyKPpjKcRa7ixWhaOELxHFMVM36t4giJpQqyg0RxX5cHA/gv4IVcSLpY/onxMSVza1eEpjTQEI1yAevtF+ng/phcMd82pT3czETwmvQvseKUoCwCRKRvIlkHBl5b0dcpTxYFSH1zpAYQX+5pXz9ILcTT4utF2l0foejhH0+P8iR3FuW5guMkZM2TGW6Zlt828pd27E7W6miXrtjKdfRt4mGQpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fR8nqfwuJ6h4HToJEsohu4TFxwylO5/4mzACJaFXck=;
 b=spF00JoeLqGyadQU5Kmpk4MStxMXFztLWDkSgXX+80TuZMNC7a/jBelYFZpdXxM/PmCB4bNID+0sK5vbLZMVMqVzoOux0ufnSsc7fCgYpNwFnnx967WRaOTjLJ7ktNImiWZIFkNqCLbyPZKrnqYTf/d+jECBb8hRuhburGUjUCZveAgIuexs5xghYcNLI8NKGu2j8YwEhF+WToCTsB33jM9KVdYKIe0aaoDUAquo7bgQSQWKSmORr3rGD+iQCIqvJCH8E2xqCon+fZgxFb0Cta5GLTwSk4IEQ+ZfKlBo1i5GbeRjAlKZDL4cjRlHtRcEHRy7NgXBYLJHTgXjoJMWpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fR8nqfwuJ6h4HToJEsohu4TFxwylO5/4mzACJaFXck=;
 b=jtAWmxKBperM0f4vL4bTwQgqUrA90XFxZX4o6KFjz5wACqvRjZqErDAzUGqesTWe9eEFfJMucy/I9w5MOrNLvkfkzb+sL8ir/cHG1hu6tpl3HJptO4litEu4Qdx1TV74YJDyy/UMaWyhg4bEkDddRUFg1DmEgn23QYMRfkZ/s1k8RyvwUCkG2bptA8W410xI5u+nYbcfAZ6MEuO51K9PILS1TQuWt5EvjYxXhjp4YSVdXPbkJsh5aiD/oV6khL0dBKc7YCfkjak/wm0B3fWPCh3oWD9P3aoFUgh1qifxibrQPGjnQFCNNCqO/tmnGInji1Mg/5Rd0awZpuhqRo5Gbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by PH7PR12MB7019.namprd12.prod.outlook.com (2603:10b6:510:1b9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Wed, 13 Aug
 2025 23:29:06 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%7]) with mapi id 15.20.9009.017; Wed, 13 Aug 2025
 23:29:06 +0000
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
Subject: [PATCH] gpu: nova-core: avoid probing non-display/compute PCI functions
Date: Wed, 13 Aug 2025 16:28:59 -0700
Message-ID: <20250813232859.224316-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.50.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:74::20) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|PH7PR12MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 930f4077-a465-4afe-6df6-08dddac13253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dfJYzBrFpoLdeVE785Dk+2i5MTsDrO/DesAY01ptrXipZ12uDxacksHaaZHo?=
 =?us-ascii?Q?p2FvMZLQaULqwYAc4y6R0Xgpcli6TUAfwNBfcA9GmNxAp6RAVSkKxkiqgkvc?=
 =?us-ascii?Q?0PzONQsVVMznzpr+0hR2Gjze2oFSP3jx2vmct/jwqnR6AbWRGjzsEx6QzFXD?=
 =?us-ascii?Q?7gw8L23p7a/AlbF2NYxLKIZvl4P31/vxwN3+juDB34qnkTLBfGzgl38vfBno?=
 =?us-ascii?Q?oXdLyCkV1mL7lxMByYzTXYoUjaeseg3di0OZWu89o0lfQBOcKlv1W5AZv8Uc?=
 =?us-ascii?Q?Czsu5/SRBZ3J8h7dXfbXkNCbN2RlO9qnM8KpZcMWgWNqK58h1/wybyYr7Q3n?=
 =?us-ascii?Q?4RNz5MLqh/6v4butp603axgr8HNeSS96+tKYgRHXqdYqzyQz0aQdmSKRQxB+?=
 =?us-ascii?Q?5bRqdMQf7qZvFpOIfFNl1rCD4xsuGIIKXqSeZmDNVRudXkZDgnJ2wfzEoXiR?=
 =?us-ascii?Q?IwCXFT1MmmfDk2aEBJJxLwH70b6BFqefFrdRJJ7GTVODIRPOKwbZxqGWHjac?=
 =?us-ascii?Q?1ykY6ciSrRDlKpH6S2qEoMxIFHZCoSnM1kPolcMR93PkmFVJQuorwzRiJirG?=
 =?us-ascii?Q?xTZWtMHF40DSNK7+UX61e1uO5T7j/IK6Y9rwciMFyXDR6i2JbYyxjZmaWpTM?=
 =?us-ascii?Q?Exyl56TTM71qYTl5a29Gi+MjJklR8OJoSv6bc8pfEYnUNkSUxgkJJ4W/mw36?=
 =?us-ascii?Q?e6oIn4kiuGIT4UHRF6lsI+HN9A/aDPgRN65n7aasRAR07snhqUXe2JhLpEH4?=
 =?us-ascii?Q?ujakchfV+3Tzwev+FBrJHtKs/rQxp21eqlAuOHgxnktV4stfIcKFyktGAemL?=
 =?us-ascii?Q?xdaCCuQCKRwf/0toIc1QkKzC1iCA5C1157nhlYlsLOjCAFvDafSI1V4YEAdN?=
 =?us-ascii?Q?2ScpJuentpEjb595DT30Knc8jJ8bY2P7WCiji9Vw9L2LX38u9EGs65j/pqyM?=
 =?us-ascii?Q?RiNri8UzGzM0iLT72P8EirqB2EdaSDmU6O0aP5iW/cHe1UD/CKub9MSxQ+kz?=
 =?us-ascii?Q?GQunCuy4gYv9hzuMfKZH8tKNCSsnZi3Sav+RRd+Mk6zgmXbFuw53CjSRdJw0?=
 =?us-ascii?Q?zUE08TU2NYam+O56UDtg4toGzJ5Usck98YsrFmbFitEyfowb/tf5VG4xjVtS?=
 =?us-ascii?Q?jOoIVEuOLEGni0oG0P/IMNkCdNNJHxvAhQnwO9vJ3ijf5edMK/cYmJlWw2Kj?=
 =?us-ascii?Q?evYizw6RZukJ1+LK/kOF+A/PKXJLnhf4i4fIDBohn60GkksNYghNn7SvTdku?=
 =?us-ascii?Q?icHECsLc7H8M0NFL06exeLHPUMFYaBricQwVe+w240dRiDQqjMFXo57DWC/G?=
 =?us-ascii?Q?p6PJnJvGdj0dxT15+FV9/x8tWQLcAt5qPJWTtqljm6hjpwPJ8Njj+J0Uug1b?=
 =?us-ascii?Q?I7CFBhU9x//0ZLpHMQvebryfJuEADsBZFbBxVJfxjiJ2lmHN+ctlnef3JETG?=
 =?us-ascii?Q?UYgExr4hRJg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k1gbTumFMkVu/MPLEYnuI9xTjweGEwe9D2foBSH13FofR+UfIbgnmClSt+v2?=
 =?us-ascii?Q?4QbOeKCpHYztHUNisBHQrXRidfUqGxkFHdxBshrSK4Texb/o6b/f03M0BOt2?=
 =?us-ascii?Q?t79Stw2zp6DtJkaYgtFBcZHHpgayKVjYRH3BXg8CRTzudIoPGuTWrrIQmOkq?=
 =?us-ascii?Q?+jgN05RCuzkG76wfnIFJAOHU/tUd2eeZ2AdE/tJJWtl+eDk6FeEM0Rqhh0mt?=
 =?us-ascii?Q?5JZs9eCmA5KEgQjqjl6IncMjwL4VMIQwKH5Nt+9oCe4P9W/gSXdZiWtJrOrd?=
 =?us-ascii?Q?kPJG6QqKlxKySoN6lSsxsr0cJmpj24O7E6SJSYiEyKs7h4sZYjE4rWs+7156?=
 =?us-ascii?Q?bUoA8aBPjPKQJSvDLJCkXcdixSmB9KTHVFQ4yDgyCR6JATkgq8ylHjyOqIWs?=
 =?us-ascii?Q?8s/L+6sNR7k9nMJAWMyfMM8YI5o4ZX8t0Sk55AKyPRoxlZUxTt3mD1TgXrpn?=
 =?us-ascii?Q?Hg5GTqvi5O/IwiOccl7GmeTCaI+YlnlY+GxE/aT/djne9otTG+AfvADSqviC?=
 =?us-ascii?Q?JFjZA3F5RGBmdE8cNl6wFNdVk4rCTMpukW94Ef+a42u5zpMgruIgMveyiHXx?=
 =?us-ascii?Q?Xl/XEpMSdqwF253/mtWCF8813yS+YmxJp8HBgmpyuqcqaHWp64cmOMD5Amx2?=
 =?us-ascii?Q?XXCj5mTJwcgsY47GC3gnBXl96BP083DRKWlyEMtDpzDa9MnLkZlA1I6IBuRB?=
 =?us-ascii?Q?lMMq+LPDVEEWDCk7ZM6RfWzv/Lcw5NDCRa3RnyNaSgMVueg3LzcPabnck55D?=
 =?us-ascii?Q?CEpnITGqvqAqoAWUXuWf+POBS2zS3ywLsbWnGpcRnLBiOWSizitoRusln8p9?=
 =?us-ascii?Q?kg02zNrU/UjRILPG+LfiW4ZJ0lFk0XuIofVRdq/ZtjZYVWxgHCwpr/lXOjWh?=
 =?us-ascii?Q?zB33C/+IP6/X5sEnt7wF3rPsMe1i01iLXvX13pxHqj35UMgMCxWL8IkVNUfb?=
 =?us-ascii?Q?bHLtn9kqx3Um3DGjHpQHdvPBi1xeuqu2ntSZPgK9PHq2XML7XQW5i1VHayhG?=
 =?us-ascii?Q?crJmZ/xirzN6o+YCXiNL3Ua4SKLJQDElgHi42E0u39y4cdLl2WoHEsLfzrcg?=
 =?us-ascii?Q?MxK0zeQOeOnPFzgOd7RCyEBMFPIluBypG5Y1piVKQnXxL+cpPTrpeZ6BEGX6?=
 =?us-ascii?Q?spldFV12hSQuDbQsHFMUJ92BT+j6aYEQ9qVyuk/R0Vaa5e+W+/lRfCYECsP4?=
 =?us-ascii?Q?yFjNyxqrBSEw9nsjMyAKyOdJZaBP/0jUxml3r0dJQDpl7PwRkFEmLfdKAfmF?=
 =?us-ascii?Q?eFO92If8V2+d+E6BmCprMI34kJxIBl8EAbhqF4pePtEmoXWmcMmghNHLr5bS?=
 =?us-ascii?Q?/oCc+igBexc9B8BBCENsDBUDNY1x2YxyJvGYS5QOObt8/w48YdQHIRQIochl?=
 =?us-ascii?Q?1N0qBMFks5Vx68927EMNQ2/9uIH7rB16vLyzPGFnFDpirYSQ+mxOcTQXC0HJ?=
 =?us-ascii?Q?C+buptO4Ym4603udeWF7ybWpIOUoNJevApg58aylvuHKAna6kLdYd5A4m6Ts?=
 =?us-ascii?Q?yUNFRFliJn/XG9DYaOSQlFdrwsm/2ExLmBEYJNxLqlHOZz9YdFr/CUZ+NAPs?=
 =?us-ascii?Q?kscOqcen1hGXKyv3wS088yBpfgHDJ6PgwQ4CZZto?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 930f4077-a465-4afe-6df6-08dddac13253
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:29:06.5928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hF8hnnnhbk2Fq18dacdOuNDUqSGGL/X7nKK4WycrU0Era/Y8QXzFol5nZKO28JPqKYLkEFh9brJcF2gPojp4cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7019

This avoids a kernel crash that reliably happens 100% of the time on my
particular hardware (x86 with Ampere or Blackwell GPUs installed).

The problem is that NovaCore has so far been very sloppy about figuring
out if probe() has found a supported PCI PF (Physical Function). By that
I mean: probe() sets up BAR0 (which involves a lot of very careful
devres and Device<Bound> details behind the scenes). And then if it is
handling a non-supported device such as the .1 audio PF on many GPUs, it
fails out due to an unexpected BAR0 size. We have been fortunate that
the BAR0 sizes are different.

Really, we should be filtering on PCI class ID instead. These days I
think we can confidently pick out Nova's supported PF's via PCI class
ID. And if not, then we'll revisit.

There *might* also be a deeper problem involving devres_release_all()
teardown, but on the other hand, it could also be a difference of
opinion about how early it is supposed to be droppable. Because failing
later in the probe() path works just fine.

So instead of digging into devres lifetimes that are already correct
when used carefully, just stop stress-testing that subsystem via
inaccurate behavior in the first place:

a) Expose the PCI Device class (available during probe()) to Rust.

b) Use the PCI Device class to filter out non-display, non-compute PFs.

Relevant excerpts of the crash are shown below.

...
NovaCore 0000:c1:00.0: GPU instance built
NovaCore 0000:c1:00.1: Probe Nova Core GPU driver.
NovaCore 0000:c1:00.1: enabling device (0000 -> 0002)
NovaCore 0000:c1:00.1: probe with driver NovaCore failed with error -22
...
Bad IO access at port 0x0 ()
WARNING: CPU: 26 PID: 748 at lib/iomap.c:45 pci_iounmap+0x3f/0x50
...
<kernel::devres::Devres<kernel::pci::Bar<16777216>>>::devres_callback+0x2c/0x70 [nova_core]
devres_release_all+0xa8/0xf0
really_probe+0x30f/0x420
__driver_probe_device+0x77/0xf0
driver_probe_device+0x22/0x1b0
__driver_attach+0x118/0x250
bus_for_each_dev+0x105/0x130
bus_add_driver+0x163/0x2a0
driver_register+0x5d/0xf0
init_module+0x6d/0x1000 [nova_core]
do_one_initcall+0xde/0x380
do_init_module+0x60/0x250

...and then:
BUG: kernel NULL pointer dereference, address: 0000000000000538
RIP: 0010:pci_release_region+0x10/0x60
...
<kernel::devres::Devres<kernel::pci::Bar<16777216>>>::devres_callback+0x36/0x70 [nova_core]
devres_release_all+0xa8/0xf0
really_probe+0x30f/0x420
__driver_probe_device+0x77/0xf0
driver_probe_device+0x22/0x1b0
__driver_attach+0x118/0x250
bus_for_each_dev+0x105/0x130
bus_add_driver+0x163/0x2a0
driver_register+0x5d/0xf0
init_module+0x6d/0x1000 [nova_core]
do_one_initcall+0xde/0x380
do_init_module+0x60/0x250

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs | 13 +++++++++++++
 rust/kernel/pci.rs              |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 274989ea1fb4..4e0e6f5338e9 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -31,6 +31,19 @@ impl pci::Driver for NovaCore {
     fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
         dev_dbg!(pdev.as_ref(), "Probe Nova Core GPU driver.\n");
 
+        let class_code = pdev.class();
+
+        if class_code != bindings::PCI_CLASS_DISPLAY_VGA
+            && class_code != bindings::PCI_CLASS_DISPLAY_3D
+        {
+            dev_dbg!(
+                pdev.as_ref(),
+                "Skipping non-display NVIDIA device with class 0x{:04x}\n",
+                class_code
+            );
+            return Err(kernel::error::code::ENODEV);
+        }
+
         pdev.enable_device_mem()?;
         pdev.set_master();
 
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 887ee611b553..b6416fe7bdfd 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -399,6 +399,12 @@ pub fn device_id(&self) -> u16 {
         unsafe { (*self.as_raw()).device }
     }
 
+    /// Returns the PCI class code (class and subclass).
+    pub fn class(&self) -> u32 {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        unsafe { (*self.as_raw()).class >> 8 }
+    }
+
     /// Returns the size of the given PCI bar resource.
     pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
         if !Bar::index_is_valid(bar) {

base-commit: dfc0f6373094dd88e1eaf76c44f2ff01b65db851
-- 
2.50.1


