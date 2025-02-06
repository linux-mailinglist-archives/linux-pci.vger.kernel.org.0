Return-Path: <linux-pci+bounces-20850-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B74A2B6AE
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 00:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98A2B1675C8
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 23:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA19C21504A;
	Thu,  6 Feb 2025 23:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FdkH8nm5"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3272417EF;
	Thu,  6 Feb 2025 23:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738885369; cv=fail; b=a02nho/IoqQfrSIMdYBqBbWbhshNA/aEqm4qPhVxkPIutASNQ86NVYLlGT4js6jaIrwKbcfQJdfkuXTVqg26NMr3NOD+Iqz9qdhukjx3g6FRl/Or+GIQzD4xpxDNO0b297tERo1xy1n82gQ/4NnyI2QP2vYOtl+99hh5hxoEBXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738885369; c=relaxed/simple;
	bh=Qk8EPFORV5myx6IHohDk278zBDmQvG6geU0nijytT74=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cp9Tm3YJodLwnEKYDUnkyzIa/+r4xvYAsGEMubB/APdE/88mcsZbfENEagkHgvJOcmBgnstoO6E2RlCym/ABz+HDRrvPcHYnNhMVcR9X477hYHd0uyhWbm5wRagN0w88K1+6kOaNPOF1Nol3f54EaWice7x7RfxwMYxYIoqldmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FdkH8nm5; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTj1r7weWAW/pWZDhQT1TUOn4inCys4WYynHmpwVWUEitps8sStLCPcqQWjzLqJroKzJGJE4VxwUFhtHdFTq0myIShKKkxjeVPKIuWdx1Mi/RWWJbTfEKOuEyrq0s0ZqgTLvN/nMsiQQ2k97zIoMbeIo+ZmVXLdChQ1xm2BJfVeuMoCPeB97XlAg2rf3bqwdFsGA0pqquD8BZvPXkeUXuqmfFFOZcdnmx6MPzvLG4TDKmd3khTGHuu/P5lUYF8w2/5nvwdQPYGWnP41Or7/tvaiFFJVXVIklKdW8sa3L4q7IliupQNhmEfzMuS7v1EqvCt/DnYIulCzDaGJ1qmE7KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtBVAeW+NdfKsfI9Tx/jhi34oQLL8DU7Fbu8PZLwZi8=;
 b=GNxKaksMGu9Z2yVhzMBaBqm93/T/cxNMR5NZEZcPWEQ6SeWU5341yjK/zkMoSob2VhsGunZ1XBVFX1Dctv0h0d/t/7fpFVp76oq86jET2JSHgHaSBtF1HN3i/RfesCN08XOZF6XMs5jaHtLh2Hh+/+i/R/baUAUhxg8zUnZawCb5mahW3Eq28IPHXaFMj/5Vcx9ZY1c4Kby4TPMX1aMlLeoFXsarYejQBwy9PgIH2Yx//yXGKNVuwnC2g9Czom4HVCT01Dr9QB3Ee8B+wgs+xYM+0l07CEfdN9RGKgMdYvmtJAQZKzhGrC10TreEr8NHEXPQrh5kqdGwFoRPk6e9Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtBVAeW+NdfKsfI9Tx/jhi34oQLL8DU7Fbu8PZLwZi8=;
 b=FdkH8nm5AlTJhfiuMCTIQm5kirjCHd+mQm7rvhOHRvy1MBwBjNICLyd1gA03YXF74xBFoyrCCquCjL58ujhikAQ+EgRVcTOyshnC8rBTAp8Kq7X7nmAy/OVmGU7bbobKIlo+jfZ0+rV9f/VkCeNm8rK6mQEmBAWMpQnP7pEv1tgpMk0s/X38AOZX+U5WiQmYpVcCiQqXJ8gSXynLwqKPJVIrEVAxJ6rm97u9wpLaT8s0qQTNkJBKifVymRzU3wKZnscKgSjgGBoV50+pp/qIa7WBq3+ECoyxNESazvo2BNmr+R9IdEU4FDX07Mnr1OL7iUWcy4UUfCUqgCUbpA/6aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by SA1PR12MB7444.namprd12.prod.outlook.com (2603:10b6:806:2b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Thu, 6 Feb
 2025 23:42:44 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%7]) with mapi id 15.20.8398.018; Thu, 6 Feb 2025
 23:42:43 +0000
From: Balbir Singh <balbirs@nvidia.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	apopple@nvidia.com,
	jhubbard@nvidia.com,
	jgg@nvidia.com,
	Balbir Singh <balbirs@nvidia.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kees Cook <kees@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2] x86/kaslr: Revisit entropy when CONFIG_PCI_P2PDMA is enabled
Date: Fri,  7 Feb 2025 10:42:34 +1100
Message-ID: <20250206234234.1912585-1-balbirs@nvidia.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0041.ausprd01.prod.outlook.com
 (2603:10c6:10:e9::10) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|SA1PR12MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 2917f440-9095-4a1c-551b-08dd4707f3a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ysHWtZFT+JtPZiNvI4AzI5n8K6T89yNbE1MScfLUiGSKb4yZ+vhShyrFsWxe?=
 =?us-ascii?Q?jkRgDL08eYoHZhvOBIoRLBeNoaHoCjwk5/gfaeqBx3SscnXlAAw4MLtZVsqE?=
 =?us-ascii?Q?USLg83SDtpZ28rUrr6KpH9JnvSL1Cevphe7mFEFgQM9wByB75MTcigAeO3fn?=
 =?us-ascii?Q?p9BYROZvtNR9/7/ulbHzHgXe8EapYbUlcGVzuGc/LBm9KzEvL1yABphpQS79?=
 =?us-ascii?Q?hEEFPYAPKEvxpZP/b+17Fdsg9IP0G5Enwu1l6CJrIvy8GEyNxe3nkBmaCayw?=
 =?us-ascii?Q?NrK9G4PzZaSJk05d3SsnAPVkF2GCwzoje3i1BXV754UTXhFzJmXU78QjLRPE?=
 =?us-ascii?Q?hclbwuiLFpSlk0gJCRbRn4/KgYR1eeSv02vN0yRRB1jhV2fb7CcV1lEeoOe9?=
 =?us-ascii?Q?yhM/K+TKG3W+hm+s4wjXqcGY/deMRHxyBtzEW534JG7lWvppUUCDU5MyfIFU?=
 =?us-ascii?Q?yNQ493pgGCIQg+r8QVjX3EcCqG9n4bTEjhTLwD1mpFGEV39at2GplLISmBef?=
 =?us-ascii?Q?at3bZZyuiAHT0n5Of7STgOhGZz2U2vASKjkfDohJI6VRX0rj8G+apTGrdku/?=
 =?us-ascii?Q?Kd8Y9PPM9WbCLla1G4AR1lvw28oxXhwAXboMAOAG/T1V37jw9quw1GdrP+Wf?=
 =?us-ascii?Q?xZZHvC2ygGlWi+uMI1FncFg20mBiIcMQBkXSgmN8aVVcakNmWgDM3hNwNvHs?=
 =?us-ascii?Q?ag7mS+4fA2Wt/EOU2qD03Zou8xx8jUwL+e6Q+Ebz7k4ucU0dWQdUb6QoTq7C?=
 =?us-ascii?Q?3QIxmG1wI1WdX+5J1zPzWkBjfSnA4676jc82CO1H6h187gvjLiwy8MK3hKyM?=
 =?us-ascii?Q?VQP4/PyGTSkrg5hYDAkt3/+3LJGpRScY+3Df1jm6ApZ7LPIU/7iCBQj55e0+?=
 =?us-ascii?Q?0DtO1GHmssZUf6GRh99T6ctXXPcSx/eA1m8lzDzzTdCsKOCHlsUvSLoNloTi?=
 =?us-ascii?Q?gPiCg/rvvrQh3Xw4S6zRC7fNuhs+lTx8EebhETU584SdgGqgZaSGKdeejuWO?=
 =?us-ascii?Q?XCLZjrwy883yazzEcjBuXI2XDY+BZe21Roi0SMBT5xJthoMCqvfDG6wa1iUE?=
 =?us-ascii?Q?vtBwsmgdBqIvaTyUThLIWMdi4uR50IkJHp371VWKPzUmfazyfeebyUa2QdYz?=
 =?us-ascii?Q?udxIugtg4QYRfuHqcZ4Eg8P/cW8EiXA97WAUREuNWXD/S3Fo3qrD4EIQhoc5?=
 =?us-ascii?Q?uhszm/bUpjjS/EVVoGebH+fJBIygk5PdNa+2zw82vHA27NalKTJJyk6W0/Ip?=
 =?us-ascii?Q?nOPEABk/WJx2uv0ntXhgI8x6MJopAhaQGa8ivDVrWUfzpEgZ9GC49gUMgB63?=
 =?us-ascii?Q?4pPPBAFu57YHuBXrnWdqqw/Iu3xkanJRmbevnUUlp4hZxylu5F8RYbHHC61G?=
 =?us-ascii?Q?TWYUXwDH8LhHF8JTR5s6n3ArDTs6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZNIQ+0FurPIu8cx3Mxp2MbqRnmbPEAvLS5mInCd1Wdgg2P+TOcBohYWUQR5a?=
 =?us-ascii?Q?mj2iozECGFPC7fdr/4fy6pO8jjA4kXEki44io/YZq/q2FwUgRGGbu+546ABy?=
 =?us-ascii?Q?sVszk/TAaDYxc38YEAvV4/utYBxvMTHkVtwzGiQQl+kTNFl0UUfXrAg/Cdm4?=
 =?us-ascii?Q?720B8RD39lPWbCip5h1O9b/1UKxb7XIwc9I1fICk2H6AyMLDS3sl6LR1Pi9i?=
 =?us-ascii?Q?PDrAe504tPO0fwwdfLawDso/D3c9p8+8CDsafIo0RNYYred2YEs6aMLed+ok?=
 =?us-ascii?Q?nIZ8CBD02FbrHWgKyFMTJvo02RGMUE8EPbM1KbgU955ETx/bET9UIttfyUpo?=
 =?us-ascii?Q?NDPuVtbZCKWJuVV7O5vx5rwFfwY3K72wpeiCqLOWxCo4dlbR3WfbG0KqH75/?=
 =?us-ascii?Q?Rcmog/3yO3jEMByGR0V6AnWVQuWhGk2JU2FpFjXQnNRQD3EYF+q38lH6T6HU?=
 =?us-ascii?Q?WKQQXh4tQ6QtgwCxAgnKxy4phKShqMRH5WOYnXjENh7umI/YshdL3o5d0sy9?=
 =?us-ascii?Q?g05zFSeTTuqTOfsqugs6sMRP4uGSM4vbvHAyEQZ+gLEO6LEgYqlBwFbCTZcu?=
 =?us-ascii?Q?0QRIZ0MqAianHi6xO6BnrXuARpd3jDXareZ56alvQGX4FwzCBNzEguD9bgS4?=
 =?us-ascii?Q?NG83AA20OHOQ8nr4FX3iyIOPK2Df7uFLC9qu7vMPg4QPaVzY/Ph764UHit67?=
 =?us-ascii?Q?+7lxEJR5ZJrYWhuMFGyuLqb2uxHcf+kQptVIsQvMSdC8QYptpdB8gGRJ5Hxr?=
 =?us-ascii?Q?ch1D4sSsQ9+KbJtyzwEgbyFG/ADeu7xVf/SX/jECNzzV8z1toD3iLNX3LF58?=
 =?us-ascii?Q?/h4BiK7exo0Iz8et2kS1SU74JVZsfUjojbG1/aPbeqV7voqSbSkUf7GIlZ26?=
 =?us-ascii?Q?22N+nIpzZQMHdhISJGBGG1yog5BEhEs0CNRdticaTihJ378bdTJydxk+BWUA?=
 =?us-ascii?Q?HefjG0Ifm9vF0XpeENK7FWoev6GDYIX1v2RGJeTNSi2BsdOjumBMpBUWv/oS?=
 =?us-ascii?Q?oB2+IBIDCeFTwJP+pgXxWHocs1FTdPqF81kXMvBF4KbnmN2INb26whR9LTx8?=
 =?us-ascii?Q?22uXnX0n7AqQ8Z+gJ/eHsMH4oPHMAWgIzAJxF/GevuTNcYtAWIYqSNBMoCgT?=
 =?us-ascii?Q?kwILrmpgh51K63ko/SN03bwrVzMrrgPz7RG2ltZSxzFT9UMG8oekSHsKrsPB?=
 =?us-ascii?Q?NGlO+6cuQlwQbD7vUQKLJP7mBj2N6Bec6uyuynuVXz9PjYmL8OayQttRAFHD?=
 =?us-ascii?Q?WKMywSkwvIUHAXZUJKw+/t07p858hQqFtIgWkbYUppad50QnujwuAeA2ImDi?=
 =?us-ascii?Q?VUcsW+EavTFY0QNB07Kzi7yzqgfWx1hmOux9G3gVoXILq8QZ0AuVO99QlH0y?=
 =?us-ascii?Q?yLJSbtgbme5HHMVpf35QWpgXhrINy3kdxmC+Rr/4t1SDD9EDH34AQbQTUHwv?=
 =?us-ascii?Q?e3e5/9sTvWVr0G0PKljNt6Z9YXxeAdK2X3r6w7dPtszKuY/oZKMyAckXB/lr?=
 =?us-ascii?Q?Oy9Bb+ExfypRCkQW9+c5TZx/uHl5vRyo6DN5XmMFnXRvN0CpEGUPvjSn6xSn?=
 =?us-ascii?Q?ep6AOVooO9B+6bYsYaMIHYn0buDf3zAM/hzHV4kX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2917f440-9095-4a1c-551b-08dd4707f3a5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 23:42:43.8263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LuB61HV/G1ktEVUmW6G1pBDWQ4z56K3CDJ1kktIRw74aRdOjApeLwoFwxAY0cIPEp6H83Q+xNWbffkZ3u5wc9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7444

When CONFIG_PCI_P2PDMA is enabled, it maps the PFN's via a
ZONE_DEVICE mapping using devm_memremap_pages(). The mapped
virtual address range corresponds to the pci_resource_start()
of the BAR address and size corresponding to the BAR length.

When KASLR is enabled, the direct map range of the kernel is
reduced to the size of physical memory plus additional padding.
If the BAR address is beyond this limit, PCI peer to peer DMA
mappings fail.

Fix this by not shrinking the size of direct map when CONFIG_PCI_P2PDMA
is enabled. This reduces the total available entropy, but it's
better than the current work around of having to disable KASLR
completely.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/lkml/20250206023201.1481957-1-balbirs@nvidia.com/

Signed-off-by: Balbir Singh <balbirs@nvidia.com>
---
Changelog v2
  - Add information about entropy drop when PCI_P2PDMA is
    selected

Testing:

  commit 0483e1fa6e09d ("x86/mm: Implement ASLR for kernel memory regions") mentions the
  problems that the following problems need to be addressed.

  1 The three target memory sections are never at the same place between
    boots.
  2 The physical memory mapping can use a virtual address not aligned on
    the PGD page table.
  3 Have good entropy early at boot before get_random_bytes is available.
  4 Add optional padding for memory hotplug compatibility.

  Ran an automated test to ensure that (1) holds true across several
  iterations of automated reboot testing. 2, 3 and 4 are not impacted
  by this patch.

  Manual Testing on a system where the problem reproduces
  
  1. With KASLR

     Hotplug memory [0x240000000000-0x242000000000] exceeds maximum addressable range [0x0-0xaffffffffff]
     ------------[ cut here ]------------
  2. With the fixes

     added peer-to-peer DMA memory 0x240000000000-0x241fffffffff

     KASLR is still enabled as seen by kaslr_offset() (difference
     between __START_KERNEL and _stext)
  3. Without the fixes and KASLR disabled


 arch/x86/mm/kaslr.c | 10 ++++++++--
 drivers/pci/Kconfig |  6 ++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 11a93542d198..3c306de52fd4 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -113,8 +113,14 @@ void __init kernel_randomize_memory(void)
 	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
 		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
 
-	/* Adapt physical memory region size based on available memory */
-	if (memory_tb < kaslr_regions[0].size_tb)
+	/*
+	 * Adapt physical memory region size based on available memory,
+	 * except when CONFIG_PCI_P2PDMA is enabled. P2PDMA exposes the
+	 * device BAR space assuming the direct map space is large enough
+	 * for creating a ZONE_DEVICE mapping in the direct map corresponding
+	 * to the physical BAR address.
+	 */
+	if (!IS_ENABLED(CONFIG_PCI_P2PDMA) && (memory_tb < kaslr_regions[0].size_tb))
 		kaslr_regions[0].size_tb = memory_tb;
 
 	/*
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 2fbd379923fd..5c3054aaec8c 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -203,6 +203,12 @@ config PCI_P2PDMA
 	  P2P DMA transactions must be between devices behind the same root
 	  port.
 
+	  Enabling this option will reduce the entropy of x86 KASLR memory
+	  regions. For example - on a 46 bit system, the entropy goes down
+	  from 16 bits to 15 bits. The actual reduction in entropy depends
+	  on the physical address bits, on processor features, kernel config
+	  (5 level page table) and physical memory present on the system.
+
 	  If unsure, say N.
 
 config PCI_LABEL
-- 
2.48.1


