Return-Path: <linux-pci+bounces-27367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63256AADCBA
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 12:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 816BC7B3ABF
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 10:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BDC1FFC62;
	Wed,  7 May 2025 10:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uJhWYTyk"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E401A8F94
	for <linux-pci@vger.kernel.org>; Wed,  7 May 2025 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746614879; cv=fail; b=fjypaSlpnOxWH/Q4rHfeQfjXGxzl2nik6XkQbB5qjxDZ38g28VU8K1M8VgNbd4XgKr4hQVBiiG5TDRcxWM8UNK5C3cHOCUS1JxN7s15Lq15sw2IIZK3P1JbW8S94eTrpcv+S8yV2XBAgSHdzf1xMv7T/aVFevRonRTm7OadiQk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746614879; c=relaxed/simple;
	bh=hRU5bBppZ8kM0wpgzcHuJIC+pNnWpEwDcCuHqQ/ej3Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VX0R60JBDK20o+HGtqoamPMmPOWPCCM2CtcH5hbSdhnUWTw8BnDg82lKcqFZHavID7ecLT8HP6JFfGQplBSvRNZxahGbapjeGjKt+PYM4vxEs/o3IxtF+3dZZDdNIVlf+InfpAbkg8lWT3OpGe82ie0QS+S4o2hcFyXkWJx4WIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uJhWYTyk; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmvcRJROsHXpmIqXkjM8n8yGO1eaqcyv0OT+0F+3CFNn6X+CnVvQh5X3ZCJQJxKEYrP39RdrpSLWRt9THOHF7rWt76BTeOQ5NL1adJzca6q9Q+v99ynaK2SRhRFO2Hg7bm/WL3iNdairKumdJVOPQVKuKWXvz/KxMvmQIq2Y+k5eLq/es2tgnmpJH/DBuymtsCYVnz2SmooI6A04DCnjZrFUqxa2XxryjJ5Q8M1XIkzfEBNDjLumUfCdBARUNThuqE5w6gJMDfNOsG/XHfRjb485YhJKB17fQ4Ic/lLfpQmu+uvrudS91bUu1wK073Ik4GxHBS9+OIE5GA6fAqE1yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jaNZt0vPeqcLXUFyyl0V3lKy2iv46CFX3t1dFVpZM4=;
 b=WM1Xf2ojBClaqZYSOjQdNu9UMVg4RYMZlwdlS8oZNambPIq/RIEcj+2p/tl0YTzfJY0udRxYxU41kw5GFV+FShBjIPoMmzsD1Dbpz9Q4y85xE1vUzMrajmTgs+jgs5lyhZ0XmQ95j7EQD4hnkAz96Oovv7PViSHlllMh1rdktxvUTSG0bPZ6ddQmlQTY0k+QK4pyN9AMn25E0mdKz6RQIeEPjWQqYQh/IVJfeI1p56+DZ1j/rRha+iJ6rMF7rSsaHDWgnDL2OczzZsBwsjPZwmnT7fKK4LlixcZXp5kcpqbJLHici8+qlYJC0SI/nB2oY1U8Kz5YHFk+utBigZqzzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jaNZt0vPeqcLXUFyyl0V3lKy2iv46CFX3t1dFVpZM4=;
 b=uJhWYTykakXAoQB7xRRoJ/3yr4H0PMWKqVImIEZrTeDMqe8oc6LbrC8Pe5OvgJYa7N5X7MG9HMzDJ9bx5JRs5P2rKW1TSXdtnoHAuZbMteMOleJeDHf02E83F8t8X8Qc2SJwft4RRPXo6de0jCQkj1uQX0RfFt5eQDnedN/4MV2vH8jbSOVRLJM9NhJJ+6BRJWJo0UWUA6eUvBgXEHPuS0wQUGecsE1uAGyXtwPZ8F4obfeIaCTLgpXE8+urCjFf29LX274wqVsIOeokUL75JqOZ6Plx4ge1ZIxBa5KHQl6ZNEMwXFupqvh6ETpGuZk8KDJdVvxd/xm7tVU4aYDCjQ==
Received: from MW2PR16CA0009.namprd16.prod.outlook.com (2603:10b6:907::22) by
 DM3PR12MB9351.namprd12.prod.outlook.com (2603:10b6:8:1ac::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.24; Wed, 7 May 2025 10:47:47 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:907:0:cafe::28) by MW2PR16CA0009.outlook.office365.com
 (2603:10b6:907::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Wed,
 7 May 2025 10:47:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 10:47:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 May 2025
 03:47:30 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 03:47:32 -0700
Received: from inno-thin-client (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 7 May 2025 03:47:28 -0700
Date: Wed, 7 May 2025 13:47:27 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Isaku Yamahata <isaku.yamahata@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Suzuki K Poulose
	<suzuki.poulose@arm.com>, Xu Yilun <yilun.xu@linux.intel.com>, Wu Hao
	<hao.wu@intel.com>, Samuel Ortiz <sameo@rivosinc.com>, Aneesh Kumar K.V
	<aneesh.kumar@kernel.org>, Sami Mujawar <sami.mujawar@arm.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Steven Price <steven.price@arm.com>, "Xiaoyao
 Li" <xiaoyao.li@intel.com>, Yilun Xu <yilun.xu@intel.com>, "Alexey
 Kardashevskiy" <aik@amd.com>, John Allen <john.allen@amd.com>, Ilpo
 =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	<gregkh@linuxfoundation.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 00/11] PCI/TSM: Core infrastructure for PCI device
 security (TDISP)
Message-ID: <20250507134727.5384d33b@inno-thin-client>
In-Reply-To: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
References: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
Organization: NVIDIA
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|DM3PR12MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a8b2ce3-0de3-4d01-ff21-08dd8d549a7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|82310400026|376014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RWSmwBiIloS9sssC2GpQ71dnegNZ2gQ683xiyAqfZKC38xAw/L+ysO3L20/d?=
 =?us-ascii?Q?LX6+Hf3M4yZehE1gQ3O4jGPHhzATCsiP7C6rFK6sWc1f9MJ8x1S1y18RBtnZ?=
 =?us-ascii?Q?iFKdOBXHt+CaPW8b1tqa2Kfam4vQ6SkoRq/b9BeWQZH62mk3+UvyWxW49P8Z?=
 =?us-ascii?Q?of9cdvMRdmojAb7n5+xGFI+ezKmcUyzDFJ3sgU9H382oqwMIyHhyTBcWwpLn?=
 =?us-ascii?Q?CxZXm/0XC0NJ/tSlGaemkZPzwJnvOjGjXUy8Jf2T9zMXhWeusP3C4kwSYMmi?=
 =?us-ascii?Q?awTUZ+T0BtiELpR+Y3h6y9cxjS5TPFws0GQ31WKb0ya/NhY9B3rZBRW5QxqG?=
 =?us-ascii?Q?pAO+x2s2J2XhFVpEi/XePIWKks9rBagfqy6Jyd1x0FjA+1b4lp7xje0IPGhU?=
 =?us-ascii?Q?eJJbZWihbP0nqr4BDBzOnDd+ChaMdnSMMbg2RnHY0HJRTUKnFQRoxfjR5RZK?=
 =?us-ascii?Q?n/BJI/rJoxUboOKFG8HmD76XBpbvMdskZ8f5yj/u0TuDvS7UWzzLkSkdlxsJ?=
 =?us-ascii?Q?UlUx7mnpvbSLSZxdaqfppucc/SuvewOtOZGD2UnJuXFbfX4tCKEpgvcWWbJ3?=
 =?us-ascii?Q?mIYjhi4fGPsCieiIUm9DwysMOxU5DzKgYRzMsMY651k3SDGruIbObIuUXPV3?=
 =?us-ascii?Q?lnRdnk+sj6t7vJTeDwembEDagdFHucDi39RJ/3DgZLOrcbjaoIrj5ZSH6A0T?=
 =?us-ascii?Q?JlS0ZxdT4kIq40c88o9i4ZtwFSIQsZKeN05pe0e94hZ3YiVvcNnCBgVopRQT?=
 =?us-ascii?Q?TvHApQj6onxXF7y2unY/TBQbIMwqZxft07gW5lTKeWv7eIr7UgWvg9SvjL1I?=
 =?us-ascii?Q?f8/zxycIsZFMrkBeboTZrJr6RnL8IopaXZ8uyu6THPu5cX8fCLp1jhWfbcnI?=
 =?us-ascii?Q?zvxZshSNwtmLNeGkN0nzGup24Hy1xgsYIQM8x7okSNr6OQlVYctX+dujmMeF?=
 =?us-ascii?Q?ZrUBTubzF04qCoFBqJmdpOgYrH6uCbHlQh5ATqlZw01cb6wK4TdlWwxg6lCi?=
 =?us-ascii?Q?z8qp10FXNlJkGV4xjRFpYdQkr5FqVy0kzb8dWzVXgSS99tMEpCEhpJJzx8tk?=
 =?us-ascii?Q?LkdpfowfuTINm3/aQmc1cmQublVtjk8+IKi1CwMSHc9TJc4PvGzbI1Ab4OYT?=
 =?us-ascii?Q?ZOpmDtyZCBvXrsJl9wH4zKKmhe1TAGT6PRHWTU4O+5xATRPgjnmBwcAH0B4Q?=
 =?us-ascii?Q?Z5SKFcPyMRo0k77QSu8dkR8jfsIkSkpqlymiW5290AAOsXYRHsd2NO7S/u9T?=
 =?us-ascii?Q?y22F4mBOmr82BqUdSx/zBBGBvxyuGxofdEh2YIWFr11ZrSK9HTso3P589pnW?=
 =?us-ascii?Q?B5Y5pLMnoPYnwTRWwhZpf0oK8MKoytmcnLtou2mUNHfDRbDg7Yc8VI1kKMxy?=
 =?us-ascii?Q?NVTx0REJpakVK3FnMGSUbHpBot+ATuORAFzpC4mSuV6XJDBZ2xe1HNgBKL6Q?=
 =?us-ascii?Q?TVjwx9EvtmnBEpGKeUe93FOeLoeXRHgxXnZ6Ju0r1zkmIfFaeKRYjaNpOtwQ?=
 =?us-ascii?Q?WTNmTF3+yTBfOj5ZI5I+LCarxvQ4A5uLtC7Vf3XoCIjR1g3wfvwGk5smrw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(82310400026)(376014)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 10:47:46.4127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8b2ce3-0de3-4d01-ff21-08dd8d549a7d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9351

On Mon, 03 Mar 2025 23:14:14 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

Hi Dan,

Thanks for the patches!

I tested this patch series along with the example devices you provided,
and it works well. The current design and interface reflect the outcomes
of our numerous discussions during kernel SIG meetings with Gobi and
our brainstorm sessions at tech summits.

=46rom my perspective, it should fit most modern TDISP devices, such as
GPUs and other accelerators, although the TDI bind interfaces are
still under discussion.

It's great to see this patch series progressing from the early RFC stage
to a formal merge request, definitely a significant step for bringing
TDISP support is in the mainline and benefits end-users.

It would be helpful if a minimal (my gut feeling would be it could be
very much basically functional, e.g. support one device and one IDE
stream, no advanced features) Intel TSM driver could be added later. So
that we can validate this framework basically on the Intel platform, and
confidently gives an Acked-by:

Z.

> Changes since v1 [1]:
>  - [configfs-tsm: Namespace TSM report symbols]
>    - collect tags
>  - [coco/guest: Move shared guest CC infrastructure to
> drivers/virt/coco/guest/]
>    - collect tags
>  - [coco/tsm: Introduce a core device for TEE Security Managers]
>    - Rename 'tsm_subsys' =3D> 'tsm_core_dev' (Jonathan)
>  - [PCI/IDE: Enumerate Selective Stream IDE capabilities]
>    - Fix the reference PCIe 6.2 specification chapter to 7.9.26
> (Bjoen)
>    - Treat all specification terms as proper nouns, like "Stream ID"
> (Bjorn)
>    - Rename PCI_IDE_LINK_STREAM to PCI_IDE_LINK_STREAM_0 to indicate
>      first of a series (Jonathan)
>    - Stop saving sel_ide_cap in pci_dev as it is not a capability
> block (Jonathan)
>    - Add support for the "Configuration cycles over Selective Stream"
>      mechanism (Alexey, Jonathan)
>    - Cache the number of Link Stream register blocks in pci_dev to
> save IDE capability re-reads
>    - Clarify 'from Endpoint to Root Port' comment in pci_ide_init()
>      (Jonathan)
>    - Fix "Number of Selective IDE Streams Supported" 1-based field
>      interpretation (Aneesh, Yilun, Jonathan)
>    - Switch all register mask definitions to use __GENMASK() to fix
>      bugs, cleanup readability, and support usage of
> FIELD_{PREP,GET}() in ide.c (Alexey, Jonathan, Yilun, Aneesh)
>  - [PCI/TSM: Authenticate devices via platform TSM]
>    - Line wrap documentation, and fixup fidelity to specification
>      terminology (Bjorn)
>    - Prepare for calling tsm_ops->probe() for Physical Functions
> beyond 0 and Virtual Functions, introduce 'struct pci_tsm_pf0' as the
>      object to wrap 'struct pci_tsm' in the Physical Function 0 case.
>      Call tsm_ops->probe() and tsm_ops->remove() for all functions on
> a device if Physical Function 0 sets pdev->tsm. (Yilun, Aneesh)
>    - Drop the complicated 'struct pci_dsm' scheme (Alexey)
>    - Fix tsm->state validation, 'init before connect' (Yilun)
>    - Move on from if_not_guard(), but not onto the whitespace column
>      pressure of scoped_cond_guard() (Jonathan)
>    - Rename pci_tsm_register() pci_tsm_core_register() to disambiguate
>      from device init in pci_tsm_init() (Jonathan)
>  - [samples/devsec: Introduce a PCI device-security bus + endpoint
> sample]
>    - Fix CONFIG_VIRT_DRIVERS=3Dn compilation dependency (0day Kbuild
> Robot)
>    - Switch from a single devm action to remove emulated devices and
>      ports to a per-device / per-port scheme (Jonathan)
>    - Fix "Number of Selective IDE Streams Supported"
>    - Use devm_gen_pool_create() (Jonathan)
>  - [PCI: Add PCIe Device 3 Extended Capability enumeration]
>  - [PCI/IDE: Add IDE establishment helpers]
>    - Drop PCI_IDE_SETUP_ROOT_PORT and its related complications. Push
>      Root Port programming responsibility to leaf drivers. (Alexey,
>      Jonathan, Bjorn)
>    - Clarify that some TSM technologies do not allow system-software
> to allocate the Stream ID (Aneesh)
>    - Fundamentally rework the API to stop tying the Stream ID to the
>      Endpoint register block index, the Root Port register block
> index, and the platform stream slot. Add pci_ide_strem_alloc() to grab
>      those resources and clarify that Stream IDs only need to be
> unique within a Partner Port pairing. The 'struct pci_ide' object is
>      updated accordingly to carry all the Partner Port details.
> (Alexey, Jonathan, Aneesh)
>    - Add kernel-doc commentary for all exported APIs (Bjorn)
>    - Miscellaneous specific terminology fixups and pci.h comment
>      cleanups (Bjorn)
>    - Drop address association setup for now given the questions around
>      its value (Alexey, Yilun)
>    - Switch from "devid" to "RID" to match specification language,
> add a comment to address the discrepancy in Linux terms vs PCIe spec
>      terms (Bjorn)
>    - Setup RID association registers relative to which RIDs are seen
> at either Partner Port (Yilun, Alexey)
>  - [PCI/IDE: Report available IDE streams]
>    - Rename pci_set_nr_ide_streams() to pci_ide_init_nr_streams() to
>      clarify why this one symbols is in the "PCI_IDE" symbol namespace
>      since PCI init code is typically built-in. (Alexey)
>    - Fix missing quotes in usage of EXPORT_SYMBOL_NS_GPL() and
>      MODULE_IMPORT() (Alexey)
>  - [PCI/TSM: Report active IDE streams]
>    - Documentation fixups (Bjorn)
>    - Rename tsm_register_ide_stream() to tsm_ide_stream_register() for
>      naming consistency
>    - Reflect that the format of the stream link changed from:
>      pciDDDD:BB/streamN:DDDD:BB:DD:F
>      ...to:
>      pciDDDD:BB/streamH.R.E:DDDD:BB:DD:F
>  - [samples/devsec: Add sample IDE establishment]
>    - Mirror the devsec_tsm_disconnect() sequence in the
>      devsec_tsm_connect() error unwind path (Jonathan)
>    - Other miscellaneous symmetry on error unwind fixups (Jonathan)
>=20
> [1]:
> http://lore.kernel.org/173343739517.1074769.13134786548545925484.stgit@dw=
illia2-xfh.jf.intel.com
>=20
> ---
> Towards devsec-next:
>=20
> As evidenced by a full page of change notes from v1 to v2 there is
> multi-party interest in this core infrastructure, and more
> importantly, many small details to negotiate. That number of details
> to negotiate only increases with the follow-on "device bind" flows
> and the interactions across VFIO, IOMMUFD and KVM.
>=20
> I expect it will continue to be the case that the mainline ingestion
> rate of all this infrastructure results in several more cycles before
> mainline ships a complete solution for one or more vendors. In the
> meantime, I am looking to run a devsec-next integration tree for
> kernel and QEMU. That is, a supplemental staging tree to enable
> end-to-end testing while proposals make their way upstream. For now,
> consider sending a branch and I will aim to do periodic octopus
> merges of submitted branches on top of a kvm-coco-queue + devsec-core
> baseline.
>=20
> The main motivation for a "devsec-next" tree, as I mentioned to some
> in the hallway track at Plumbers, is to wrangle private hacks and
> workarounds in vendor trees to coalesce if not mature.  An example of
> multiple vendors solving the same problem in different ways in their
> vendor trees is: [2] vs [3]. Note that devsec-next is not intended to
> replace vendor trees, and instead reflect the snapshot state of
> cross-vendor consensus before topics are ready for linux-next /
> mainline.
>=20
> I will send out more details as a follow up.
>=20
> [2]: https://github.com/aik/qemu/commit/5256c41f
> [3]:
> http://lore.kernel.org/20250217081833.21568-1-chenyi.qiang@intel.com
>=20
> ---
> Original Cover letter:
>=20
> Trusted execution environment (TEE) Device Interface Security Protocol
> (TDISP) is a chapter name in the PCI specification. It describes an
> alphabet soup of mechanisms, SPDM, CMA, IDE, TSM/DSM, that system
> software uses to establish trust in a device and assign it to a
> confidential virtual machine (CVM). It is protocol for dynamically
> extending the trusted computing boundary (TCB) of a CVM with a PCI
> device interface that can issue DMA to CVM private memory.
>   =20
> The acronym soup problem is enhanced by every major platform vendor
> having distinct TEE Security Manager (TSM) API implementations /
> capabilities, and to a lesser extent, every potential endpoint Device
> Security Manager (DSM) having its own idiosyncratic behaviors around
> TDISP state transitions.=20
>     =20
> Despite all that opportunity for differentiation, there is a
> significant portion of the implementation that is cross-vendor
> common. However, it is difficult to develop, debate, test and settle
> all those pieces absent a low level TSM driver implementation to pull
> it all together.=20
> The proposal is incrementally develop the shared infrastructure on top
> of a sample TSM driver implementation to enable clean vendor agnostic
> discussions about the commons. "samples/devsec/" is meant to be: just
> enough emulation to exercise all the core infrastructure, a reference
> implementation, and a simple unit test. The sample also enables
> coordination with the native PCI device security effort [4].
>   =20
> The devsec_tsm driver already yielding benefits as it drove many of
> the fixes and enhancements of this patch-kit relative to the last RFC
> [1]. Future development would either reuse established devsec_tsm
> paths, or extend the sample alongside the vendor-specific
> implementation.=20
> This first batch is just enough infrastructure for IDE (link Integrity
> and Data Encryption) establishment via TSM APIs. It is based on a
> review and curation of the IDE establishment flows from the SEV-TIO
> RFC [5] and a work-in-progress TDX Connect RFC (see the
> Co-developed-by and thanks yous in the changelogs for where code was
> copied).
>=20
> It deliberately avoids SPDM details and does not touch upon the "bind"
> flows, or guest-side flows, simply to allow for upstream digestion of
> all the assumptions and tradeoffs for the "simple" IDE establishment
> baseline.
>=20
> Note that devsec_tsm is for near term staging of vendor TSM
> implementations. The expectation is that every piece of new core
> infrastructure that devsec_tsm consumes must also have a vendor TSM
> driver consumer within 1 to 2 kernel development cycles.
>=20
> The full series is available via devsec/tsm.git [6].
>=20
> [4]: http://lore.kernel.org/cover.1719771133.git.lukas@wunner.de
> [5]: http://lore.kernel.org/20240823132137.336874-1-aik@amd.com
> [6]:
> https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/log/?h=3Dd=
evsec-20250303
>=20
> ---
>=20
> Dan Williams (11):
>       configfs-tsm: Namespace TSM report symbols
>       coco/guest: Move shared guest CC infrastructure to
> drivers/virt/coco/guest/ coco/tsm: Introduce a core device for TEE
> Security Managers PCI/IDE: Enumerate Selective Stream IDE capabilities
>       PCI/TSM: Authenticate devices via platform TSM
>       samples/devsec: Introduce a PCI device-security bus + endpoint
> sample PCI: Add PCIe Device 3 Extended Capability enumeration
>       PCI/IDE: Add IDE establishment helpers
>       PCI/IDE: Report available IDE streams
>       PCI/TSM: Report active IDE streams
>       samples/devsec: Add sample IDE establishment
>=20
>=20
>  Documentation/ABI/testing/configfs-tsm-report      |    0=20
>  Documentation/ABI/testing/sysfs-bus-pci            |   45 +
>  Documentation/ABI/testing/sysfs-class-tsm          |   20 +
>  .../ABI/testing/sysfs-devices-pci-host-bridge      |   44 +
>  MAINTAINERS                                        |   10=20
>  drivers/pci/Kconfig                                |   37 +
>  drivers/pci/Makefile                               |    2=20
>  drivers/pci/ide.c                                  |  499
> ++++++++++++++ drivers/pci/pci-sysfs.c                            |
>  4 drivers/pci/pci.h                                  |   19 +
>  drivers/pci/probe.c                                |   26 +
>  drivers/pci/remove.c                               |    3=20
>  drivers/pci/tsm.c                                  |  377 +++++++++++
>  drivers/virt/coco/Kconfig                          |    8=20
>  drivers/virt/coco/Makefile                         |    3=20
>  drivers/virt/coco/arm-cca-guest/arm-cca-guest.c    |    8=20
>  drivers/virt/coco/guest/Kconfig                    |    7=20
>  drivers/virt/coco/guest/Makefile                   |    3=20
>  drivers/virt/coco/guest/report.c                   |   32 -
>  drivers/virt/coco/host/Kconfig                     |    6=20
>  drivers/virt/coco/host/Makefile                    |    6=20
>  drivers/virt/coco/host/tsm-core.c                  |  144 ++++
>  drivers/virt/coco/sev-guest/sev-guest.c            |   12=20
>  drivers/virt/coco/tdx-guest/tdx-guest.c            |    8=20
>  include/linux/pci-ide.h                            |   60 ++
>  include/linux/pci-tsm.h                            |  135 ++++
>  include/linux/pci.h                                |   25 +
>  include/linux/tsm.h                                |   33 +
>  include/uapi/linux/pci_regs.h                      |   89 +++
>  samples/Kconfig                                    |   16=20
>  samples/Makefile                                   |    1=20
>  samples/devsec/Makefile                            |   10=20
>  samples/devsec/bus.c                               |  698
> ++++++++++++++++++++ samples/devsec/common.c
>   |   26 + samples/devsec/devsec.h                            |    7=20
>  samples/devsec/tsm.c                               |  192 ++++++
>  36 files changed, 2564 insertions(+), 51 deletions(-)
>  rename Documentation/ABI/testing/{configfs-tsm =3D>
> configfs-tsm-report} (100%) create mode 100644
> Documentation/ABI/testing/sysfs-class-tsm create mode 100644
> Documentation/ABI/testing/sysfs-devices-pci-host-bridge create mode
> 100644 drivers/pci/ide.c create mode 100644 drivers/pci/tsm.c
>  create mode 100644 drivers/virt/coco/guest/Kconfig
>  create mode 100644 drivers/virt/coco/guest/Makefile
>  rename drivers/virt/coco/{tsm.c =3D> guest/report.c} (93%)
>  create mode 100644 drivers/virt/coco/host/Kconfig
>  create mode 100644 drivers/virt/coco/host/Makefile
>  create mode 100644 drivers/virt/coco/host/tsm-core.c
>  create mode 100644 include/linux/pci-ide.h
>  create mode 100644 include/linux/pci-tsm.h
>  create mode 100644 samples/devsec/Makefile
>  create mode 100644 samples/devsec/bus.c
>  create mode 100644 samples/devsec/common.c
>  create mode 100644 samples/devsec/devsec.h
>  create mode 100644 samples/devsec/tsm.c
>=20
> base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
>=20


