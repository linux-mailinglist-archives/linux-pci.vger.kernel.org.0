Return-Path: <linux-pci+bounces-44244-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4387ED00BA6
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 03:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C974D3012746
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 02:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456D420A5F3;
	Thu,  8 Jan 2026 02:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="g3LGGV+u"
X-Original-To: linux-pci@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020127.outbound.protection.outlook.com [52.101.229.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4018CEEC0;
	Thu,  8 Jan 2026 02:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767840519; cv=fail; b=ncStZWe3wS8IMa0HyGNbsiSs0fPCQG4ju9jM4wVFpWF6v8E30BaifR5369iWyvsIA3XK2WWYOLrUB+3w93NaVo1UkmFLeUTODjlsanqD88wV/u0fDJIaOcAJaH6gbSR1Gn+No4sBGszpfi0n+yEFD2H3WSZ+TYtumV6zOYuavM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767840519; c=relaxed/simple;
	bh=zwO+q4u8Z/pKyxh/gNulGiMdxKDn70u51cvugB4HGcY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oawaJpFMwj2SF/WgqK6drkF5XN4YR1qiVlagnPpDjEO46QCts0Wpc9/YlOzY02B1EE2EaAqPyCONsBE285TYc4pbkkeW0OPNvuQOhQC2zFaexuOYg6z3qieHqUPJfq4MgH2/5qV667oUBm+uL/xWvWZ7a73eAA3BD0nkbpHPRGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=g3LGGV+u; arc=fail smtp.client-ip=52.101.229.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDddB1DxtVNTUPPOCP90TXrdTRANJdbJ/tckQvgIk2KnVGFwM9GuJO0LORtN5dXVkCDvbFnI7TrsHMYYHmqU0XHEq2ir80r7Pcl7PJj/VisrcZmMwEfNcT+cmiQObj1HhJwBBoaKE0HfR23MabFISknXFrDz2HLYLVdYDSj0aH3yXsPHKADtQLn7zlR7+VQy3qjIn5yT/fdE2t9VDI3a0Zm4tx1gPjdg2XppXyx7P5kQC+Q3UEwFPLZFZMNoBJk+ZseMCfNSu4tE8aEaQVcatK1YyhPrD6xPwvKYTV46Z7iascu4lG/9/dsvjuCHiGsvRRAi2ifFG6hdvVw8ieHh4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9LBCTls5w4fMNl5XIDoBaEJo51+UQ+f3y+B1TZW8qs=;
 b=pgsIQ20W7IQkKAbdB4U0HQEN8SMR5QnjHsc8RA4KnH1+d93VAIoAOR49r7xU2bAZq2TAFN0JGfPU5YjuidRAqaFK4Uio3CgbzOVhS2HtIkU3R+8JKmPdU/XYWx0jhURiQMP5nGsVg9i6je0W0TgA4rYRW3jbMdorox5MmPYJCHGQ8RtRq898/x3xL2VwmPg+I7xD+jI4TOSkwjwR0UUNHznJxKxxluhYkIwWJuibwuvjsY6lmWqRMRnYyvVoPCDuXsW7tFY+RXD465OymOFdd8fGRcc83VucA5omd5WeqkfVRNCcHfZN2Y7MjrYrZWcY8I+bWTY56p/u4TA/yYlxxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9LBCTls5w4fMNl5XIDoBaEJo51+UQ+f3y+B1TZW8qs=;
 b=g3LGGV+uJXFovpYp1Vj9HEfm6c3zO5pfyowUAEnA+8uwMoZPh0xSyPBMb5fdPcxOnhckDuiinDgOlv96sYlAX0dIToTK8RjXGLf/jdMaQxWCjJ1tPi1zuKeLaJtRdy429pD93VCVOuRaVoN+ZJtoQMuEDmzjRNU95ptjixtwJHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2688.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:247::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 02:48:34 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 02:48:34 +0000
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
Subject: [PATCH v3 0/2] PCI: endpoint: BAR subrange mapping support
Date: Thu,  8 Jan 2026 11:48:27 +0900
Message-ID: <20260108024829.2255501-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0028.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2688:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fbaa733-b018-48a5-8d47-08de4e606a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aEn7adDWd4JgGWuHWJuenB6NB/eUmKVR5K+5AbSFmLzdxL42WKwOby1HKEAq?=
 =?us-ascii?Q?ZWbIOzndAtTsyqIo5uKWF48lSgNHxegJBTN1EeXh+iqBfN+TEa3ZXP7RCWaB?=
 =?us-ascii?Q?9+UQHKz9pyGS60McIWFdLoBQV77Sa6SX/NDHl8oysWMH3hXBwhRkJCTEphMK?=
 =?us-ascii?Q?Hw0CM1VgpPV6izx0XH8cZg4qrMeoq7FUeDKJzj7fnoN5HwkeGqEq3O1QOqWA?=
 =?us-ascii?Q?t7eofaAnNTa8t9lraWJ3E4S84m3yFb/ZgtwOKIn7KgpkbDnhYijgALKWGGvp?=
 =?us-ascii?Q?VYly9EUErMFEJTJrmK2ikzVWhGRJPzh1pODVeTPNbOaFlWVUP8J7FMQIPjqY?=
 =?us-ascii?Q?BupfKUyVwzJTdLQ1HaQAc3V6Uc/Vs78R997CBGa+mlVkP4LMzrDPfggzUOZ/?=
 =?us-ascii?Q?agD4PqNwuVUZxICTeYI65Qa7i9FdJQDrswHpFL1wM6lKJwRIBBxEZk5KVc8M?=
 =?us-ascii?Q?ogbSAobObv0HHnQGWWy10caZBcm8asHLvo7jushO7ivtcAEZqNhumUJD39yh?=
 =?us-ascii?Q?DPWbWTLNuoUwAiRRqoaX2c0pJzZetBzzj40yCs0I07Anv37f2Yry2sMrf1+T?=
 =?us-ascii?Q?D8DlUqkfHXulKTy7kOyZEIw6x13OMJoRmLJUiSmcHcIfQNKKxBHR2Diz1zb3?=
 =?us-ascii?Q?JgxQxD/sGGal4RFAqYfLqqrPdMRQUEuAzV1IA5NHrHVzLDNzIu0V2zkcQ9Uf?=
 =?us-ascii?Q?qwKDhEd4cU+wfYzgpw992u909gJi5Pj9Zh/g2FwWvG9DWc7FM7oRss6SR+nl?=
 =?us-ascii?Q?ivWIkl5QcFS85QLZX2LcBULnI1UI0+bSRMIeinYaFQd5mD8Nbejt7KQ+VNSa?=
 =?us-ascii?Q?8B9+nAuhMOv5Y0S6LiD3XdhlP+fxspmWYX/FwcQ2qdaP3EF7JTnB2e51jODN?=
 =?us-ascii?Q?7mTZrbMMPFJUQTt9mObkQiju9hvCZTMn1ZpiHh/qjA+/i5Gfx6kc1uX2uY+m?=
 =?us-ascii?Q?3KUFZiRDDz97Fq3JvlbVn+5pK+6p1x7Hg8OIOOXH2LBuBLvyBTQCgyexpt+G?=
 =?us-ascii?Q?tzBZhwc4P4lR9rFOyT8CkCx59V7vJF8EFbUA7jA7GLSZ573YRM4mV+W8Gw+4?=
 =?us-ascii?Q?zUlTiy8LecvlsZEf8DgCTsTgH0pxgln6HWeNsZlHyDimec/mJv+UeqfSF0s5?=
 =?us-ascii?Q?EAOCiktnH3+idv3sKWhXJAWvKcKsyJbdxq2JdQWa9MxhF+mF2MVnhdLWSKo9?=
 =?us-ascii?Q?Ds88DwNt7tiq/RAAboNObKHZtyyw4Ua1+2VSqmY6HoOTdZytb+w4B571VZdl?=
 =?us-ascii?Q?5X/5m9vKsmEYrzY+9zF5nyYmh8EjG7W5E+dwVgKJyew+mqDSVSaeeX2yjrIo?=
 =?us-ascii?Q?+tJ/D66kgVCu3WvizeLJ+2s8IxyXvJDwOk4Y7GdTSaFa7HK34amWPltLa2GP?=
 =?us-ascii?Q?MtCRlorFvWvcUEmr4LJUmtF4aXi0iiaKE5PNLtU3P8vmZCEF03jtEHW7rWm7?=
 =?us-ascii?Q?Kurh1SuTUG5T6FSowE/uCdchxzkoG9AiBctE1fyhTyt0r58wMirfQg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SnUUmfrG5uY+M+fvME9UR+CDA7aQrCkWdqlArdGHE2rxEyy9PfN3G//+6e1t?=
 =?us-ascii?Q?iW1EHwRn4ridnrgjBuoepCICqSkjD24beHRjdpMidRkVsWsOLN14wenbyrPe?=
 =?us-ascii?Q?00gjaj2bqAhPkLtFtTPHhGVP/vBb328gAlKTgFzjpcuihUCTxtEsufbERO5k?=
 =?us-ascii?Q?NWQCRYOOeCeokgQscjem6qMMiliSt1wBpLJZe9nH96n8ec3udrVvD2zlPb29?=
 =?us-ascii?Q?Jb78Q370xL9e7IbAF87LM05BgNr+iGAQ+GIdBM6KkvWpqjP0oc0xc1b3p2LI?=
 =?us-ascii?Q?2OxFvO0FQZSVl5g4GJjgi9HNkV4E1UuVFaAE6Kvfz3wJY33xeLXPYz1wu8qM?=
 =?us-ascii?Q?RCsXX1Qzu3Cgg1vhA9NY9IXkgAMWMvoXqmA3ub3h4qduo3Oj7HibE5RWjm0c?=
 =?us-ascii?Q?+z/fBiI4KbG50vQg5Xpa1j71XH8yFV0tKpYLNf21NmXDi2ylqps2cH23NoN1?=
 =?us-ascii?Q?Du8jLkTD6llXfClEHuvA1jE9ZC4YOaCRnxK2M45aW1DEmqo4WdzcpdwRNtUM?=
 =?us-ascii?Q?MC8xsqwVlNhMsjSy4GU/AO7+qwAkaeIO0roTgVFRtq6DX6SwDOLRejWYiQ9T?=
 =?us-ascii?Q?O99eJjRML/kvuKxXquah0ww1aqhofcqc9tEHU3avp0i60bohiXpXx3cR5RCg?=
 =?us-ascii?Q?V0XL6pKqE1+2/BUfgBi8FpoWw6mqn/1Q0QxM10iP0U2QxK3rmjqowtwxXuB4?=
 =?us-ascii?Q?c5ekcmnF3SugaeudwCSYfM38h65cuYJm2cMHtdMTj4B1AV/ILkGjP3kXmOTs?=
 =?us-ascii?Q?FzexxiPVHPW3ppkZzFL8pjZTQ/qf6jqLW4Y4N0KOMco4nD17VV8UAMTrEdWu?=
 =?us-ascii?Q?kqpgu1Wd/y+EAinFflANPYOi6JOcKKWJYchALBRHR3/LwwaCYvaOMY0l1osD?=
 =?us-ascii?Q?tv1XJwDSyLWyLi4Z7oByounnmUC4Nq1r2mzAKLO/LqjcgCmvOTVRUvZesCKh?=
 =?us-ascii?Q?u2+/oitWB3MFSlzI3tep+ukTRD/HYXVdodlFglia8Abldcit82PR2NskTGcV?=
 =?us-ascii?Q?labKA694qTUJK8gCPrHHZQcgvDeERc3wjZdV88WDGvRPVudYuMad/dyTP/aV?=
 =?us-ascii?Q?nAFhUjL/Akfv17L6UcyPJHR9iUCqUxDnrf0OtxwxkFTTlH5RysZ8pulT6x8+?=
 =?us-ascii?Q?RBbtA4f++HowMqxtRk+FhiRTAVi9XZ2biArtd2LrZqsZ6iSH8QAGyE3s4ueK?=
 =?us-ascii?Q?dEC2NrsnwuUViLRkVjKdF3SQFoVtPi62R7c9a8oIbdblxgZ5JqlNx70kn+Ms?=
 =?us-ascii?Q?mNJYBkkOiOp6XmUUpvo/YGB8r4Vt4bjvP6MVkOwaDpTTk7Ex4txRu9auAESK?=
 =?us-ascii?Q?rywdtes40pa1eHpeURzp/797tjhB34hsQ2KKuBHiyvXXMhaTHrkPi1euwVpk?=
 =?us-ascii?Q?HGgEY1eUrFec4Y05lS7Kamntx3lvRZpVxJb78dtRIZVUU7yA9Wg3qZmwuD+e?=
 =?us-ascii?Q?n3nrYTLEVqwMtvGg1Ypu/YJpkU+UNVz7KfWJwWTPZ/shWleOzZqit7QKNvvi?=
 =?us-ascii?Q?bFKt1pn5toiknBg3uRtje/6d2ymBY6Q1aT0psW2BZifKvLExtLh/HRTRM6m2?=
 =?us-ascii?Q?cB9QWNk1So17+g1xEQCfI4Z9B6UO8bkBgLB5xRRL1jR3zxsWzXGrG0YKWHqz?=
 =?us-ascii?Q?VMkiI5niMalBFNBFz2WmCD3zQCxkC5iv7Wwxajg2rBPR0slz3SS/UVaCBUJ7?=
 =?us-ascii?Q?FXw4qhtEYVq8jAjLftHGlvA0s40dbNinQR8ZchjiQfPLhF8xPQZHiMgiA+QZ?=
 =?us-ascii?Q?PQBz43syWjcYiRx49SoXma6fHHtLKfVY0rXacMd5fp7THDiW1LSd?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbaa733-b018-48a5-8d47-08de4e606a6d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 02:48:34.3272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3U5xXQ5gGHc/cLhxiuDTk0zQyfpYxAaNojQxCya/ineD1BGiownM9dz7qX3yETdW5SRh37551yyuhT+dvYFVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2688

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

v2: https://lore.kernel.org/all/20260107041358.1986701-1-den@valinux.co.jp/
v1: https://lore.kernel.org/all/20260105080214.1254325-1-den@valinux.co.jp/


Thank you for reviewing,


Koichiro Den (2):
  PCI: endpoint: Add BAR subrange mapping support
  PCI: dwc: ep: Support BAR subrange inbound mapping via Address Match
    Mode iATU

 .../pci/controller/dwc/pcie-designware-ep.c   | 234 +++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +
 include/linux/pci-epf.h                       |  31 +++
 3 files changed, 256 insertions(+), 11 deletions(-)

-- 
2.51.0


