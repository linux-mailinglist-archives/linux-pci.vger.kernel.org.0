Return-Path: <linux-pci+bounces-39619-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05763C191EA
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 09:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26721B230D3
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 08:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79BE1B3923;
	Wed, 29 Oct 2025 08:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AkF1K2GU"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazhn15011023.outbound.protection.outlook.com [52.102.137.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260D02FB990;
	Wed, 29 Oct 2025 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.137.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727008; cv=fail; b=UqfAZt9Pz1EuboAqlEx5DF1VUQ4sgmOTRKFw9Q/6D4lm2yV6tf22gmI0iZXhtAzS3eHV4WMrYaKnFYJoO66gCBHxewRh03muw+nP7QWGPItdRtEanFHIkQLIMRDmH+ZnnltnORFU5tgOImFt4VAyMrwkpbNHgslYzPaaq/Kb6GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727008; c=relaxed/simple;
	bh=pwogg0fdLQ7NcaFbFQ03x1bG97cTftwukpWHlhNKWvY=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kpBZ2pPW4r9o7HPpa/cH8nc/fWe73etKhyP443zZ4t8jzodTuYkAEDT4w7G7qz8WBp2Tbb86gaIwYrIjGb3dOIafkdIi7rP1b4d/4lvG1EA6jEgtZDlkX2qzrwBe49Um7fRScMZjLG2GVsoBZKpcZOVCVUtFAbdPrRcKHwdbF+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AkF1K2GU; arc=fail smtp.client-ip=52.102.137.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFaUE21tMNr4elRi53hke5fFMufxFBnpWYmtFUepdLX5HeTEfNwAWU9AOqIqSnp2RH0uZfX8l5i5H+Y2k5sdC1NMVFByU7qnPFm2WOpyw0TQfUELLHaXKZ4XriI6m5PJrXt+Lg97cftwMRUgQ13DkLT32fyvoRtpNK97PjLAsksa+XsWHfOgB7E7nF0e2CptxVEXmjF7QomA0Y9Y5lJfYVEJHUIlvz2bQmxnHtL/Ds/Cr52WFvjG49xV5WtBSeOK0NmK/0g9RtdmQkKRxAYA9CQAoxD9AuVSbi6pq5XG4CAJCffRg6wHQ1J5f0lwOGx7e5qkI+K++HpqIvXvutZrOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCizaXr2hS8IKoBcmsgqzaZlNURiyqbvjq119FC4LzM=;
 b=fHMGHp86x3QmKY67EOdu9UslaPf4UtPDbzA2AGDwvWM3rIcGyaZn8z+nxE1oFnBXKjchZutmMlSlBBz6Ie0EWSRdRpfz6ZYZfwAZXcUxLwTG1YKHQEx2ASM2Sw4IyuBLTZzdPVxdvainQ0hI5mt9r6zuR5ahQFMLiJL/LXwNwT+85+c9OYij4bEuCB6UiPB/PY36zVdC58XN4/0tDmnsiQ4X5+1dW3EOAtiLAfh8jvEAI6JsL9pkGn/TfsaLv3+FlGrK+rRod19/SlzvOkznWdGkxMEKR6ZEnd8/a5fBJcukwAMz516ZE8CSY92+9B8JWUo6yRyogHtCW4VZq3on/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCizaXr2hS8IKoBcmsgqzaZlNURiyqbvjq119FC4LzM=;
 b=AkF1K2GUBc+Nzz5pVYk9SmTN2B0F479c4e1j9cbn7J5X7dL2jTp3GNoONoTFP1ZCFYG6NX9FS1I8DzpUQFcPTDKsGYgKiXZmCYLvaK4gZ59RTFiXsa0ne/rBmMmFq/TX3uZi2qFuq2hE4BfuOdcQTyMD0GoKkB6OqnFSAeYzBRg=
Received: from SJ0PR03CA0362.namprd03.prod.outlook.com (2603:10b6:a03:3a1::7)
 by LV3PR10MB8131.namprd10.prod.outlook.com (2603:10b6:408:27f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 08:36:42 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::7b) by SJ0PR03CA0362.outlook.office365.com
 (2603:10b6:a03:3a1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Wed,
 29 Oct 2025 08:36:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 08:36:41 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 03:36:36 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 03:36:36 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Oct 2025 03:36:36 -0500
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59T8aT7i3717378;
	Wed, 29 Oct 2025 03:36:30 -0500
Message-ID: <6acc369fa1c8b7d09d96d80143da6d265c30a1e0.camel@ti.com>
Subject: Re: [PATCH v4 4/4] PCI: keystone: Add support to build as a
 loadable module
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: kernel test robot <lkp@intel.com>
CC: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<quic_wenbyao@quicinc.com>, <inochiama@gmail.com>,
	<mayank.rana@oss.qualcomm.com>, <thippeswamy.havalige@amd.com>,
	<shradha.t@samsung.com>, <cassel@kernel.org>, <kishon@kernel.org>,
	<sergio.paracuellos@gmail.com>, <18255117159@163.com>,
	<rongqianfeng@vivo.com>, <jirislaby@kernel.org>,
	<oe-kbuild-all@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, <s-vadapalli@ti.com>
Date: Wed, 29 Oct 2025 14:06:41 +0530
In-Reply-To: <44b90ca1a10fe737cb20b76327846c5cda420924.camel@ti.com>
References: <20251022095724.997218-5-s-vadapalli@ti.com>
		 <202510281008.jw19XuyP-lkp@intel.com>
	 <44b90ca1a10fe737cb20b76327846c5cda420924.camel@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|LV3PR10MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: 529864eb-8b26-4da1-398d-08de16c6491e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|34020700016|36860700013|376014|1800799024|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1ZFemt0aWJ0dkd3MXNWdVNid2xicnhDNE5OeDNXTVBrdS9QVTlmdjV4ejZS?=
 =?utf-8?B?cTRHSHYyZ3FvRE4rcmR5Q05WRE1yZ0dNenIxOFFncmNoRVhpVWVnZGQyaXo2?=
 =?utf-8?B?SjFOb1VCa29Hc05iRXE4VS9kc3V1TFhoQ25xckFDWEZxemJtOWxhalBHMmxy?=
 =?utf-8?B?SElkLzZhWXB2WnpxRlVnOXpTM0NuemRURTV6dEJ0ZlF2Q3lnazFYMEJRKzV0?=
 =?utf-8?B?dHliU0U4enlHdGs4eUwxeEp4MDlrcEVvOGNPVUtVK1BpMUZRUDU1V1JzZW52?=
 =?utf-8?B?aUROUEQrU0pjeTdsQkx6cnpXT3l3MFJrQ0NUQmdFZnpxaGlqU2NyZkdKV2x2?=
 =?utf-8?B?UTczK0tUWUxHazJSa2liZm1hVEhOMWVjRm9oRm9JWFBXa09PMTNmcE1vQkNY?=
 =?utf-8?B?eUU5MGJMOFBQWERad1BBSVdWR1dxeHA5SXRFK0VVUXJkanpGcDdYdEYvYUtK?=
 =?utf-8?B?SU5OV3VrVGtwbnRMNE9EMXVxbzZ4OTJCK0VsSGJIdFVrTWFmRzJEalRoOGJI?=
 =?utf-8?B?K1Y4QlF1UzBSM1IvRC9ZanFMbjdNVmdNcE5sOE1KRVB4ZThDb1UrMW9sL3hW?=
 =?utf-8?B?TlQ1ZlAzdjZKQlNyK1h5bHF1RjNlU0h4bmtZTG5VdWxoZXEvQmpOemhiS3ds?=
 =?utf-8?B?WUV1dTcrS3dDWWlWMHFnYkJZWXBVRUR3bTVxbU5nMytTYmxZVnZmVEhueTgv?=
 =?utf-8?B?Y3gvbXNYYjUrZzN5UFhJVEJzSGYyMTJ0MG1LVmdQTW5YOFVlZ1BiTDc1K3F6?=
 =?utf-8?B?N3pEbFVHZEFhTk02TEZqQkh5QkxqdThnbDNnUmRubklQdWpWQXJqNUtlZ200?=
 =?utf-8?B?VTNraldwWFMyZ1pDbGNWSFhPMG5sTEJFYVVucXFSNExrbmgwTlRMWmpvWGN6?=
 =?utf-8?B?cXBQMldCRzUyNHNuYkpmSkF1TjF3UFJVYm10a0taOHhpcWlwcGhVZVlYdzBQ?=
 =?utf-8?B?NEdoWGdVUUQxYzhxLzJxaVFONGViT1VBK243M2p1YmFWQ3pmWG41UExYYytk?=
 =?utf-8?B?N29EdUdPUVEwQnRjVGIzZ1NTT1c0cWdQVlVXTDQvUWNCRGptWU1iL2xOOGN0?=
 =?utf-8?B?aU5hZWtUS1A1VXp4NU1oczUxOVZncGpMejY0RDNWVGFHSU9saTh6ZkhLSXNx?=
 =?utf-8?B?NVZSbXBuZ0xhYVZlLzNnOUVoSWE2THBueGxLZmFyOFNZa1hEbEhQc3hRMzIr?=
 =?utf-8?B?TGhNUTM2dnVDUGpJbHU1ODJVZjdHVEJZZ21ZeWdHWDhnM0FyY1FuTkpWWUVP?=
 =?utf-8?B?R093WHJRRFdBU2dORE0zTkVCQXRiT0NQL01Ld1FwNkhKVnpOUWRwUlBnSVJC?=
 =?utf-8?B?RzZsWnNqL0I1Rkl2bXYwb005MUtvMWdTYlZTMitML3dQUjVRZmxrMTVSOHdX?=
 =?utf-8?B?alJQZHdTc3V4R0RMbWFwUGtUQWgzQ2VSdjFZTFBGbW15TGxQV3B0ZmRseDFq?=
 =?utf-8?B?K2luV1ZHdWN0T1NBbmlyb2VwODgvL1V1RVNGVVRoRW1SRUhmZTUvbm1IVk4v?=
 =?utf-8?B?bFR3TmVQTE9aSkMyMXlwdnd1UWdpTnR5bDczcDFYWTlCU0syN3JhUmF0ZS9X?=
 =?utf-8?B?YnNsdFFzQVZIYkZZMFo5ckQ3UkhZWENjOWhzMW5NVUlOcDBkYWNVZEZLSmhQ?=
 =?utf-8?B?TjA5endGQWNScnB5eWQwb1d4S2ZidVNWKzE2eEtwS2RqNGRySit2OVFUcGVC?=
 =?utf-8?B?bXlJdlRDQ21WL095ejhQZVhTZ1RwcW9hRUc2VnlzRmR4MVBMSnZyMUZ5em1W?=
 =?utf-8?B?bFZCM3NnMm40OWRiQ3lRL25vRXVzT2ZhTGVRd1R4K2dLTTYyTm0yZTdxdUFt?=
 =?utf-8?B?aVJZSElkSWlsM1V1QmFUVVdLd3hQc2N2NEs1ZTBxSnBvRVhFZ1cwSExld1NI?=
 =?utf-8?B?VUkyR1B1enNlZy9HTGVZUHoxU3BXUHZwSXJYbGNnV29hK3huMXZET2phM2Ev?=
 =?utf-8?B?ZlhqYkRNeGpwQmFCcEZ1NXV1RXdHZU1zNFJJT1UvMS8zSjdQa05Jems5QmE2?=
 =?utf-8?Q?o3zgyuHN4a415iXTdpF6C14gDpwoSg=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(34020700016)(36860700013)(376014)(1800799024)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:36:41.8228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 529864eb-8b26-4da1-398d-08de16c6491e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8131

On Tue, 2025-10-28 at 10:24 +0530, Siddharth Vadapalli wrote:
> On Tue, 2025-10-28 at 11:06 +0800, kernel test robot wrote:
> > Hi Siddharth,
> >=20
> > kernel test robot noticed the following build errors:
> >=20
> > [auto build test ERROR on pci/next]
> > [also build test ERROR on pci/for-linus linus/master v6.18-rc3 next-202=
51027]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >=20
> > url:    https://github.com/intel-lab-lkp/linux/commits/Siddharth-Vadapa=
lli/PCI-Export-pci_get_host_bridge_device-for-use-by-pci-keystone/20251022-=
180213
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git nex=
t
> > patch link:    https://lore.kernel.org/r/20251022095724.997218-5-s-vada=
palli%40ti.com
> > patch subject: [PATCH v4 4/4] PCI: keystone: Add support to build as a =
loadable module
> > config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20251=
028/202510281008.jw19XuyP-lkp@intel.com/config)
> > compiler: arm-linux-gnueabi-gcc (GCC) 15.1.0
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20251028/202510281008.jw19XuyP-lkp@intel.com/reproduce)
> >=20
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202510281008.jw19XuyP-l=
kp@intel.com/
> >=20
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> >=20
> > WARNING: modpost: missing MODULE_DESCRIPTION() in arch/arm/probes/kprob=
es/test-kprobes.o
> > > > ERROR: modpost: "hook_fault_code" [drivers/pci/controller/dwc/pci-k=
eystone.ko] undefined!
> > ERROR: modpost: "__ffsdi2" [drivers/spi/spi-amlogic-spifc-a4.ko] undefi=
ned!
>=20
> I had built the driver for ARM64 platforms but missed building it for ARM=
32
> platforms. I will fix the build error for ARM32 platforms and will post t=
he
> v5 series.

I have posted the v5 series addressing the above at:
https://lore.kernel.org/r/20251029080547.1253757-1-s-vadapalli@ti.com/

Regards,
Siddharth.

