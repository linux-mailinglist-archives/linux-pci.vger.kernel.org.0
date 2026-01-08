Return-Path: <linux-pci+bounces-44250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A75DAD00FBB
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 05:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 660E33008FAF
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 04:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964C0291C3F;
	Thu,  8 Jan 2026 04:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="B1tBh94r"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020076.outbound.protection.outlook.com [52.101.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6154298CA5;
	Thu,  8 Jan 2026 04:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767847317; cv=fail; b=ZDFxc2IN3Z6nuspespG0/qJS/CQpxBhFvc52b5H0wm+qmFT4LZRIh7XwJmCkJSYGhK3sAk4IlaXLy1e9er7KAbpG/f3egVc9MP5tOvPXywx4Px2RCHElFYSND1LVY/uDuj+ts/lyFhZ4sPhR/xwLQaUXCadlszn34q+BBOvcOxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767847317; c=relaxed/simple;
	bh=Sube4MZyHVMpRNlgCqRLv97VA7wock/Sy6IzV0Pd/Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=r/QJjFlBinnJbwwbh5d1ooZmLdm1dkBKjL2xSbykgx2M5PvegFPh3SJHj1KjljKrmE/qhYIhAHENRYPvXFYkeCHAVUaJ/PESWGR9g0QF39tGW44SOkZH5mW0e6+dHKNRKievPzdxo3OQEcgNp8fOlwChVku4mGP/hfvIfFzq3Oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=B1tBh94r; arc=fail smtp.client-ip=52.101.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHjAFKuhFTCtP0UnRMcvyR/JtZNfvNbxzXxuV4wJXL5Hik493eM5DKAGGDfSpPyzdpLdbpmJAAvUC/M3wgLM6v7hfwBPWzYbCSeuKvtIJ097BiUmh8Xc7jjWRe+WLXNn97scxQGWxvSiZwNcgFLIVl/Sb0fsZaDZgaHs4hFWcA2RCdrtyusDgm9PbzFAqYBCoMBvqg/CRxA/3P14lLqnCiVD8ECziSbSTk9p2l05YSRiNEjJxr0D6B/KOAlsJNCWj3dvUZtvMlx0Zp3exvrzBu1p58g7J06FZyQSHOB4WDmG3ifM2tkutK1IqXwBotUmGojP5LaZN0rw81LDsItkWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTbLt/FzUnOyCU9nLPXxQ8Zt7tVny7zkTv6J/S/kOJU=;
 b=WnT6pVCxkZZBkFrs2aTEWrS7zVqHzxgxSmtQpvf8xaaJK7yuZvLIPoE7IuN9FLw3ku4qn6bMYTBvAVQLorEErIiz+Pg5y9K5VbK047ewpvHMM5ffLC477on30bWk+PjlIQ+OR6wRyJMIMvyTS+jNSsUm45QL9TUuMRyyKHtqgDlTzj8rgtSUvdl1PcpRvFAe8vwGdRCi5HdHOVXU/6z9d7uBtm7xW5ER1QVHBJbRNGUIQRkhpR65QUq5yf9edyUENvs4N+PuaAtS6XLGYcbUqYMJxoYSIYmqprHB/fi+1NuTlGl0FCjOQhoaZBDrPU2ebP1NRzJGFbclysLKnOkLwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTbLt/FzUnOyCU9nLPXxQ8Zt7tVny7zkTv6J/S/kOJU=;
 b=B1tBh94rXE004+FDk/paiquk4N4//6iWjz4n85vHRIp2DLtCUPmGaUi23kOM3P3eanUzB0vdSnLygfFXZzIZNY5riHChY9/obCcm1O1oCmp98QTUuL9zMYqCioI5SO1Yb2+FNr5U1Xms5fD65QUXJMaMKIHTxT2fjUbmqlL6DDs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB3545.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:394::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 04:41:52 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 04:41:52 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	cassel@kernel.org
Cc: Frank.Li@nxp.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] PCI: endpoint: BAR subrange mapping support
Date: Thu,  8 Jan 2026 13:41:46 +0900
Message-ID: <20260108044148.2352800-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0075.jpnprd01.prod.outlook.com
 (2603:1096:405:3::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB3545:EE_
X-MS-Office365-Filtering-Correlation-Id: ec933d97-c449-4ac4-8926-08de4e703e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2Gg7ob+WdTsZDVgdy4zl3G7YG90clO3Hza6lae8AXxRBYAy6Zwk6LT4DTNNm?=
 =?us-ascii?Q?ouQVwCQf/HIkT8NDjzimskKgckKBbVGQPT+VjF4YIabJ+KE8n5Dttm1xUPH7?=
 =?us-ascii?Q?SS/qYrenc67RGIpbv0dscxYifTHO8r1Uzv4NjTIwG/OmiVyCevk/rR2L71wT?=
 =?us-ascii?Q?PneDW6JEuFVp+tXK3RvGPhTbnMle8yLqQ9+Vi5zgGenR/7fsbOx/cdiEN5dK?=
 =?us-ascii?Q?PtVuyfrfIY1IiWYWwaNf37etov3ibYoDfMVN9CaTD8CIZVz/LQWmg+CriTP1?=
 =?us-ascii?Q?mKB00jeWBIpcLNLQ+qmEF8uum6BjnjUySqtTGVZfJjjtt68779eBMJKD5w0X?=
 =?us-ascii?Q?Pj1W7cAPs1BC2ImWpLtKve1uhzTxB1szFNxjWxzUI7ikBpCpPGm8UhEsmn+c?=
 =?us-ascii?Q?RSf9bbGPZUb50nVnDQsNMeHS5RhA8AU6gxIPJGYMNWBCJCczYl5uWFmLqNyI?=
 =?us-ascii?Q?FRYJpjHHUo8+u2r8gCte+EmY2B+GooyzElbIQs+1SsetlK8aJ3wptpbWjx4C?=
 =?us-ascii?Q?vSwB7JlWufFdb9mwYDv0S5bPkTRIdM820hQ0pjRjBeEvvXKUSkIzTQOrmmg7?=
 =?us-ascii?Q?sozL696ieV2zCEWaMQ4TZgB7NjqpLujtuSMhsaQi+4s82ShkU0nocwI4Hll9?=
 =?us-ascii?Q?j+cEEpwJx0HQ6gUb5yG2qe6+PF6ejvtVD4wPvRGUzks06cw4kKyLVYXCW/3S?=
 =?us-ascii?Q?rHPJYzfrk4iMvj4LI2oKO4t/xI+agPRlQEcU8UQ1T75UATHe/cMzQ9BuR/Kf?=
 =?us-ascii?Q?qb9xGa9bNmfhaXn2u2p/5ChNTxC4ig81PSB/z33iEN2B5FTtlLPp+t2rdMWR?=
 =?us-ascii?Q?suaD0WdXKzU2/4bD2JezytQTDRfgq87pknYa8MrIJJZ5NJEquNQ0Hj6w/QGV?=
 =?us-ascii?Q?em0oCaQ6rMzMUTQoiNAnw+PLEVEMEWfUOgEset8k8rH0eP4WlQ4veBGHsKFn?=
 =?us-ascii?Q?pSePcxTIEBJw7rINu6nvaHsk8fH826X/CfASg/tfQoiZPepjbAmLAUgcr6ZR?=
 =?us-ascii?Q?McK6npjVAcPTmttGoRM0SAzja9RIgX66/5fUIlIWuh3Jb0Rh66uyiZS2niYr?=
 =?us-ascii?Q?uIUEW2wpSBYtKJ+eEQWphq2E0c/VQ7voXbICAkvdzyvELzP9TmG5EcEKg7+Z?=
 =?us-ascii?Q?JSFP1UAQZlkXrHMmZAjRJkWMAx9R77O6Y4723cqhWiZhuTvPprfJ+AgXi/yy?=
 =?us-ascii?Q?x/iyy+AxVWqD9D0gNveY4iDu+SBdcv3JtvVQ8AwgIwQj6Q4ZDektwaIl4PJc?=
 =?us-ascii?Q?/Ohk6v+pXfrJSnZQRkwmSufoVwCAvUyyX7PguB2kuIgNocJPuWNj1/W0uV4b?=
 =?us-ascii?Q?HmJcoDgUhmdOOXaIXO7Qc6YQ9HuTqaskQvKS3JgVx4px9A9kPiYszFgesTLu?=
 =?us-ascii?Q?2IxSt7sKeZTKjtyO60n2i9qsBI41ocvuLmKufHO/W91DwkvULb1fLex6UMKf?=
 =?us-ascii?Q?hNbuYUTb4Z0ksB9pI4g4p24qJcBXUdiISiqu3WsXab+0dCcdylQclw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d8Ua8SGLvfJ2cRvvvuRr55gTYdpa8ba3hBZIEPvIumYRs38BPUZ7ROnxgKDf?=
 =?us-ascii?Q?C9Vge8aGpiD/55+sPLZPMkHY3iVvpBD0hwTdMVwpHsuSRbBZbURifRbvCfNi?=
 =?us-ascii?Q?vE6ugItw9sa0oWbuuEr3y9Olb1b/W1udnaWnFgv47soINRXBCBuDt8le3IFS?=
 =?us-ascii?Q?IH7D1oar+uqydDFsppexnayXR1HvfAU2+Pvk+0gbBJP1z+MtvWEl6TsKU9TK?=
 =?us-ascii?Q?7YBjRi7JlwaKZEsLMo32wzkwoKt275revsxkpsnO4VHz54ST2RzaoLI92eS6?=
 =?us-ascii?Q?cPHwKQDJW5138y+G0xWAMkdb9dNI6Za9SHI8IHNQWnuCAQHYQXz4V3yfzLF0?=
 =?us-ascii?Q?vccUpsTWgcJHOrud22GuDF90QbTIwUCbiyfuAHWpMMC1BP0JG8/SM+3CVjq5?=
 =?us-ascii?Q?mH9jqB6lEpcrUgonYmvXJi4qZ0HiPSUBlpsPj9mSrNv90UadqB7RBmmBMT2A?=
 =?us-ascii?Q?tZp5gYv18oLArIu5g6JeDPKw8nL/3UYJAMtzEt9CpGmyy0/34xnRsgb7lQAR?=
 =?us-ascii?Q?PuZiMFGkHp8nU8XmXqL7m7ct67vZ08dAojmO8GH4pwWLyPVwrQX8xgJszWg4?=
 =?us-ascii?Q?7ZjGGB019lGGPogj0Q3UqjKbdfWCmovp65kqjwfukcflJGVBAJCEXHlxK5ej?=
 =?us-ascii?Q?RekD9OWAQA2bUFhz8c+aIn64c6MGdiefJzzhjZ2zXV82vWGzzZr5m82Oywxe?=
 =?us-ascii?Q?RxZZAWYQcWuS17JlvOayctmkDnmi/7Sr5BepKc29tTrZyk2p9bdY/A8J6x7K?=
 =?us-ascii?Q?6J0El7zd036xZDBasbq0WSeNnCDNDCwBkZ2gpjJR3KLXLXGMupLL2rRORCzG?=
 =?us-ascii?Q?q6tYkg5aOnVpPXlBjNG5qP5eSovxXmZYihFbDlYwrgGGRIZixVXspEWsS9Hc?=
 =?us-ascii?Q?RfR6Ys8wemYcfvwlDleN8upzmgSxRYCNWJv2ex36XZ1cwpuElsSkRf6cCoC4?=
 =?us-ascii?Q?0lxwdIiAzsvU+3IuZKEZVxcZfBvhDblVrvSHXs/uE8QEoukh4KbmphXvnDxJ?=
 =?us-ascii?Q?II286qwMjYNcWm19jtUjMim9dY5pdJsyP8eKOPdxVWYOx0lH3Vr/hwwgOH97?=
 =?us-ascii?Q?8m495jIb4bVv84lmk1XQw68/S0d2MqDTAxG4d1mGccfyrZGqmRYDFp2wHAnk?=
 =?us-ascii?Q?M6f9zHddeCCc51s7KD/A+2tKYhGvw/K/ATQ8+GjOUUEtMZMWSHiTV48eGpd+?=
 =?us-ascii?Q?Z/tBzCMm/9R5LF2TxGcd7QDaPNzPnkeHQl0TJPzU5TrlA2FufVQDyBMSSMbR?=
 =?us-ascii?Q?i3WctYzL251JwhOgtaWMFIZSGaNfmWmNfzc/AO63QaoncOTEUbgY1J1ixz7A?=
 =?us-ascii?Q?8QJSl3vAFg6KF5gMVBdA9fgd/09MiuzqUCGMYCKsgM4bt/jWLn6VM9VAPo5s?=
 =?us-ascii?Q?D1ACaDERRD9pkgNau9Stq5KlkS5FAX1qQFcZZJ6YojTvkynv6nCVLhnZNuwH?=
 =?us-ascii?Q?xH0vFFk0qPwXHZ45bm5vkfOXqPHNAGZfw7S+CPp23SnxBYe2IhKbwxHmM8Kf?=
 =?us-ascii?Q?uRk9u/A76sYGptk9MSFA9woF4unC3/MJfUOYcTTj5yOC3HKHEoaNFvFW2Q5b?=
 =?us-ascii?Q?QB3N/smrXkTg9vkfKURpxrvptzF5tRs/UJBAWL9+APvIEKoWdyG+daN5xUqw?=
 =?us-ascii?Q?yaarOjx74WWNaX7IUwlswJp/qcdWWYUuj8Vtf2+n0K7E1HFfPO6iJ8Ve4M7b?=
 =?us-ascii?Q?IF/qijro6WMNtDmFMLhquiSAb2tsQJUTLlG03CrbcIzcc6f2a4LgzeQXWMPA?=
 =?us-ascii?Q?GC4Z51G1li6ibzSjCvaJTmHIaoEl33yhn7I6q50aUGMXEKv48ZoH?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ec933d97-c449-4ac4-8926-08de4e703e86
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 04:41:52.6022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Pwohr6Yfhck0z+wPGvAcXaqbgbDL2gMDHk2DaidgVImDOlicDYcFQ6ZpU4skZdr1PgmGg3gXlODhW0Ey3SsjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3545

This series proposes support for mapping subranges within a PCIe endpoint
BAR and enables controllers to program inbound address translation for
those subranges.

The first patch introduces generic BAR subrange mapping support in the
PCI endpoint core. The second patch adds an implementation for the
DesignWare PCIe endpoint controller using Address Match Mode IB iATU.

This series is a spin-off from a larger RFC series posted earlier:
https://lore.kernel.org/all/20251217151609.3162665-4-den@valinux.co.jp/
The first user will likely be Remote eDMA-backed NTB transport,
demonstrated in that RFC series.


Kernel base:
  - repo: git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
  - branch: controller/dwc
  - commit: 68ac85fb42cf ("PCI: dwc: Use cfg0_base as iMSI-RX target address
                           to support 32-bit MSI devices")

Changelog:
* v3->v4 changes:
  - Drop unused includes that should have been removed in v3

* v2->v3 changes:
  - Remove submap copying and sorting from dw_pcie_ep_ib_atu_addr(), and
    require callers to pass a sorted submap. The related source code
    comments are updated accordingly.
  - Refine source code comments and commit messages, including normalizing
    "Address Match Mode" wording.
  - Add const qualifiers where applicable.

* v1->v2 changes:
  - Introduced stricter submap validation: no holes/overlaps and the
    subranges must exactly cover the whole BAR. Added
    dw_pcie_ep_validate_submap() to enforce alignment and full-coverage
    constraints.
  - Enforced one-shot (all-or-nothing) submap programming to avoid leaving
    half-programmed BAR state:
    * Dropped incremental/overwrite logic that is no longer needed with the
      one-shot design.
    * Added dw_pcie_ep_clear_ib_maps() and used it from multiple places to
      tear down BAR match / address match inbound mappings without code
      duplication.
  - Updated kernel source code comments and commit messages, including a
    small refinement made along the way.
  - Changed num_submap type to unsigned int.

v3: https://lore.kernel.org/all/20260108024829.2255501-1-den@valinux.co.jp/
v2: https://lore.kernel.org/all/20260107041358.1986701-1-den@valinux.co.jp/
v1: https://lore.kernel.org/all/20260105080214.1254325-1-den@valinux.co.jp/


Thank you for reviewing,


Koichiro Den (2):
  PCI: endpoint: Add BAR subrange mapping support
  PCI: dwc: ep: Support BAR subrange inbound mapping via Address Match
    Mode iATU

 .../pci/controller/dwc/pcie-designware-ep.c   | 232 +++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +
 include/linux/pci-epf.h                       |  31 +++
 3 files changed, 254 insertions(+), 11 deletions(-)

-- 
2.51.0


