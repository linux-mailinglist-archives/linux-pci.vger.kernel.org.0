Return-Path: <linux-pci+bounces-23551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30352A5E7E7
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 00:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 194EA7A2958
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 23:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581F11F12EF;
	Wed, 12 Mar 2025 23:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TgiIqU+M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B85E1F192E;
	Wed, 12 Mar 2025 23:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741820450; cv=fail; b=LYempoQGMdL0YKRuuNXmGrz95uwxZJ9K8ToK57Wzb9/tO9tot1E80XMEn8gLmxsAsXxpHecYnTunozVjvg1jY5AQQpAwtT1qboWftuw30Ev8KM1cJgRnn4C9hTrHDJeDPzghXQDieH4L1bHnFxEj9Scdg+Bacmz8LPXPXIkZVi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741820450; c=relaxed/simple;
	bh=TtMSUusmWmjB1rwNvgEx+sIgB1ocbc17jU5tWGuzdu8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s89P3aJyU4lzBvGc7rI4EqQwsSsQLhKqlAVZqGs7WCu41Od5BoFOC3XAjgLmNPlFeuHD8vP36o3ZZ81DcfmC5r2lHPadz4U3goftz2qtYnmIpJCMfye4+z6mMqoVd8myy5oofMzk3N33fgDuMiBIZFtikewaCQpayxMymkTzfbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TgiIqU+M; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741820448; x=1773356448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=TtMSUusmWmjB1rwNvgEx+sIgB1ocbc17jU5tWGuzdu8=;
  b=TgiIqU+Mi9upenxvEzb8X5oi0xHi3D+N169d+aO5yyaaSaG6g3/JxTE4
   a6DEIZanDuPqrrwf6i/fotZnfyx54U4guGe2kTi2XrI74AJ7P2ujtshB+
   qRUvNSJMaf3glGnvdryJCDMkkz56kORJWMVHjPNEJPDZZksOdHDZl+iiB
   P4YJooUcoqm+6/4HloGai+ZcFSG6c0AzwG9SuoJgiVStOhCJYoeR3Bb8u
   WDlZ1kOXjsQAkRyWAkRkBdbbyCe6GeqjQjnW/hspC/SVwb4cPnXSRsA0V
   3CmAqvdP+a/4WFnxU0LrU9tnFnsZdGCgCepJ9ejFsRHSLgGgm6UJBu2bS
   Q==;
X-CSE-ConnectionGUID: r/r4C0S8QhO99AfuGszZ4w==
X-CSE-MsgGUID: wVRt8He6Tauxl/zHs27LaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="43103786"
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="43103786"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 16:00:48 -0700
X-CSE-ConnectionGUID: hZOL3AeRTLOnZdUja6Z0Kg==
X-CSE-MsgGUID: U8Cg4+C3TrCBOnv23X0RIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="151604547"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 16:00:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Mar 2025 16:00:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 16:00:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 16:00:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6S2VM2pWqVLpH99LGbvelWuPGRRdPHHRhFCfEQLqcwVghNqlDQXVptVNVdO81Sir7HUQsH6TJU+D4ck7px3emj6/dYwPLAtkK2GNjGtTOQfOfqp88ucHafQCrUy+4/0gIouKZpyn1HQuSIBqlUEydIrvIbBkodtfTK5kXFWfyNEEdv2M43Oi3VkOoK9GF8zkLf1POrjccRsqGesaBmBJKUTMPeB3e180RTpL/jEis+8/IicoWCsuESrDREn1ZvlRgNTnhxu1GXpJ2QgeFa3m+SxCnEbWDtD2yGVhKn+NaE4xYFnRFQtnAxTJrMocraQqPRwWsI+KUW3ssA0V6ffxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfIWIC/7sl2+W7J/a5Gjhp+3q+DCpTS4//M8bZQbVWU=;
 b=QvYeeAsg0yejhO123Rwr/Zk1UFUG+ABVTAyUzNSzkVwD2AM8ue1wsiVzbbxEtZ/hT9BYZMtWaMqG4lwgbf8DwhCTUXT7zgaqpGQfaHEbuXsTUxmR39nfc+ZaATAXwTWYkgMcEyEV4XojWBKU13MjICc2cuXiO/lodg5NsPf3KsYP2TxlrMp4lTUL2CNunX+yCgrlOZCWlA6Jt7m+2/StVs9g05/fUIEomgfpz2Nl/D6nq6lIaIlsAv9VDgrNf05t2iK7WcDPHg7snYD4pivowrCE+W8JoPykNDmp8KN/q53nc28H+kE7uCWHd4kULGEVmlhDN6Ky5N05ia1Ev2lCbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 SA1PR11MB6735.namprd11.prod.outlook.com (2603:10b6:806:25e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Wed, 12 Mar 2025 23:00:42 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::927a:9c08:26f7:5b39]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::927a:9c08:26f7:5b39%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 23:00:42 +0000
From: =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
To: <linux-pci@vger.kernel.org>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>, =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kw@linux.com>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>, Michal Wajdeczko
	<michal.wajdeczko@intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Matt Roper
	<matthew.d.roper@intel.com>, =?UTF-8?q?Micha=C5=82=20Winiarski?=
	<michal.winiarski@intel.com>
Subject: [PATCH v5 3/6] PCI: Allow IOV resources to be resized in pci_resize_resource()
Date: Wed, 12 Mar 2025 23:59:46 +0100
Message-ID: <20250312225949.969716-4-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312225949.969716-1-michal.winiarski@intel.com>
References: <20250312225949.969716-1-michal.winiarski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::13) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5373:EE_|SA1PR11MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 330bd5ed-34f6-470e-8ae6-08dd61b9b6b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?czJYeHlCWDhXSUlWYmdCOXBLaG1hNnh1TE1DYUZ5YThuR0l2YnkxcnBQbjEx?=
 =?utf-8?B?VkVNVzhwSjMwYUFVejJnWnlxNExxdFR6YklvWVBXSnFITWdvWnVmVEt4T2Vi?=
 =?utf-8?B?eG56VG1GVUJFejkvWkozblpRNTkrc2ZBTXlMUlZIY3RzdTNMcG1OWG80clND?=
 =?utf-8?B?RldkS2xIejNEdXlQOElkSTFXbmU1emcvcXRNM0ZRTytKYjR6N0J0NjZrdm1p?=
 =?utf-8?B?R2ZrcGJuUGMvb2lmYmxBODc3YzRkRVBUTi9HZ3l3YlpYelRRZGV3aFEzMzJG?=
 =?utf-8?B?UjluMnpiSW01V04yeDRxOVd5bm1ZZ3pINFQzTWp0dFpaaE1aZW10NlpJb0Nv?=
 =?utf-8?B?clpPRjZlMDhocSs1SFVLR3dCb25KUTBNelFaQVgzQ2o2dktJRGhzOWU3cUJC?=
 =?utf-8?B?bnNBaHp1OXFWL1ZnTmdpOGd0REpJelF5Rm0vTUhjSXhSMVIzMXRqdnRGcTlz?=
 =?utf-8?B?YXI3T25qdUtORDczUVcrOHBwY0phZktmdW5GY3lIdWdMcHE2Z0NCN05QZ2pa?=
 =?utf-8?B?cDFtQXlkSHVlYlhHQ3hDRXp5MUNzOXJDUWc0OW50T280bVVWZzVGMVhIQlIw?=
 =?utf-8?B?ZUUreXBXZmU2d1F6SVJmZjdsamt6VG1FSWhXdXkwRkI5T05jRVBndjRoTy83?=
 =?utf-8?B?OWNvSHJITkdGWjdDRTZueDZTR29OSzRRUE9mczZRUDBEWHRnL2x1OG5ETVJE?=
 =?utf-8?B?Mzc5VjJIa1BCd3ZFNWVGNzROcG13cmJUSlB0M2ExWGNMRm11UjdHNHdoQnN5?=
 =?utf-8?B?SHZpNDQ4eDVyUnVhK3p6by8wUzRMcHhSTE5RY3JtZHF1S05ybzBDTGxmbTBi?=
 =?utf-8?B?N016QW5lalBQc1ZlY0dWd3dwSkpzU001ZGR6VmZlM3R0SnZESStvQWpCdXNK?=
 =?utf-8?B?OFhOSms4bWdlUGpua29OdW52ZmdVN2hRT0lMY2NSbHVlQkRZcmF3SFJMOFlQ?=
 =?utf-8?B?Vlg4OUYvc1BrMGRWemdNV2cyT1FlRzNUOE82aDFlL3oxWmdDT1pVbzFucFAw?=
 =?utf-8?B?MXZ5dDZnaUdSWFNFNTZCbGxiVjFLc0JqQU1tNjdSSEJiRVd3YmJoUUlQNU81?=
 =?utf-8?B?VG16SldCNU9udVl5dWMybmluNnlWTlRIeWJXbnBKU2JCWG4vVHI0cGZqQTkv?=
 =?utf-8?B?SnBicHpWdXJieTI3OVlhL0g4SjlLSWtHOFVITjlLaUw3NzdWM1BrYnN0WWJ6?=
 =?utf-8?B?dTdoK1QrMGg5NEYrREs3T214a29NYVptRW5VK09Wb0F3U1piVC9LQUo0eTJC?=
 =?utf-8?B?VFZPRE9GZFhpcEtSajRHT1F4S0Q5SlcwR2ZueXNNTlUzR09vY09YSThBa0NQ?=
 =?utf-8?B?d0d1dG1kTzM3OUd6cGlTc1doOFpvdzJOV08rN1liZjNtdmVkMHVSQlp3ZWxQ?=
 =?utf-8?B?SmFWSUd5T1JTN0I5OGZ3NEUwNGU5L2R2MFFaNS94RFZ6cGxKYndvOENkSUlm?=
 =?utf-8?B?YUtQVnhEb3IrdUY0RVZ1VkN4RjJGeVRVMFZUbm5UMXZXdmZWRFI1dTB3MnU2?=
 =?utf-8?B?YVg2KzJlR0pIYVM5TzdBN2R3UXpHemYxNTlxbkxoOFVTRkJBTXFZNHJvVklv?=
 =?utf-8?B?N213NHBHekF4eXllek14R0JQdkRza1lnemw2eEhVNWxreGRYdTgwUXFJNVVS?=
 =?utf-8?B?R2cyYmEzL3dVOS9kUWtzR045L2tsdnRaNUp4c0JqMDRPVnM5dlhsdXlGM1ZF?=
 =?utf-8?B?RE1rTThISVhNRGVPYTFmcVBOa1orYjlRK0xiQjNTZzl6WXF2NmhXTktiRXhS?=
 =?utf-8?B?bCtpS0V4VU9WSmZtZXA2ZVVVYWM0QmRjcEE5MU1RQ1NjM2svU2h6aTBMN1Qr?=
 =?utf-8?B?U1RVM0xRYjNOUkcxcVRvRk03NmxoWjRYZmlmdXJIL1F3OFpQR2l6REhWN1Rl?=
 =?utf-8?Q?oiI5j3yZHijLT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlJ3UHpIZi9ZUjF1MU14RDJDV3FWZ1I5dm9ON3ZhcGxkMzYrdTQ0MTVub1lp?=
 =?utf-8?B?bTVtV01ROHhrTk9oRFRlOThVZVNqT1Z6cXFaZU4vNE9FSGE1WFViWkdEZUlO?=
 =?utf-8?B?MVBETm9YaUxZZVdTWFBpL2RUZS9sbm41SmZKOXpqRDU1Z0doTlZyT1RjQVdm?=
 =?utf-8?B?bXI2cXNRVUhMc0tNUGVCUjRBdktYTjlYZERURGM3TnFEVklhNjlQai9UMGQ0?=
 =?utf-8?B?MzBzYWZzdGN2NWU5YjVVclJCUHhKN2lyRHV6bjNNRTY3alQrMmxvRHh2OWNU?=
 =?utf-8?B?MVhabGpxOThYZUR6UGMzWEgxVVBMRnJOTTF3aldFRldNdWFIa2grWHZCM2Fz?=
 =?utf-8?B?cDMvYmdUNk81RDdtUE1jZXpPVitsVDJlR3ZIdnFUVDJ6dXVzZUZmaGt1aSt5?=
 =?utf-8?B?QXBjYkVLc2l4ZkZZLzF3VXNHd2cwN2srUnlHSEVEaXE0NGdQR1dKOFVubzVt?=
 =?utf-8?B?NFlaTDYrckI0TjJ2a2VEYzQzK0ExSzdWM3JFMkdZaUdPa0J4MisxVDI0OXR1?=
 =?utf-8?B?RFhwaWJrQlFURWg0WUFqQUEveVBpR0ViYlFsdXBwWjFEM0ZvVFl4b1dqZEMz?=
 =?utf-8?B?WlBFQ3RNTEFSY01nK2o4QXhRRHNoWEUvR2w2NlIvNlU4ZDV1Y0xsKzJnRVlB?=
 =?utf-8?B?VGtncys3ZlVlbjNUdExmYTNHSjZyTVdMeVVpZFgvK3Q1VEMrcm9uNkZaSzMy?=
 =?utf-8?B?QkZqbHVmTlIxR0dHT2UzSzl2eTBwWDFZUHRyaS9jZlU1YlVMTC9zai9qUm5v?=
 =?utf-8?B?Y0plaHZpRnZsUU1DWlQyWTU0KzN1S2VpdW5PbGhQUk9sZ0R5UmFvSys0dGMw?=
 =?utf-8?B?QzFsL25BMXhzam1ISFBNTmExemJMRldFZzNycnAxaTN1cDVwOWEvWWFBQ2lX?=
 =?utf-8?B?aTNsenJDZURqOW5jd2lQTnRLaEN4b2pXSDRHdGtOYUNvVUwyZGlFbzUvb1Jz?=
 =?utf-8?B?S3JsUllPNWg5Ly9EaUY0VGovc1BXc2lkRGJ2Mzg3cVd4ZU52TDViaE5uZkF3?=
 =?utf-8?B?NzVVMTljM2F5Qm5RcFFWOS83NGJDNmNwVXlKalBrS3ZkcTdaQThxa1Z6dXFu?=
 =?utf-8?B?WnhNZXArazlNL3lYK25LNlp6cEhKMUNxdjVMb2h5a0o0dFlKZHhicmYzSTBv?=
 =?utf-8?B?ZFg5eHZhdlRHRXpPa3p4cE01OUFBNjlpNGpCQVFOZWExYW1kRU5RbE9MY2Za?=
 =?utf-8?B?WUtWa2hqRHJPanUvUkdpeVp3Ym1IWFNrN3BNY0hOVm1lL1BIYXRLQWRaWHpU?=
 =?utf-8?B?Wk5jZ0ZPaUNwN2Nud1dLSTd0Yk5lY2pOVHM3MzFOSlNoZkJ2bXlBK0F6UGth?=
 =?utf-8?B?ZEFhOXRUSDBLVGxQK053UmhUMmJtWnNXQXJyVFI4M1JWR3ltZnV4NmF0N2tV?=
 =?utf-8?B?UWtwZUxjWkpYcWhhVXhTVnhOVEYyV0RTMDJxRnNjcElGRXBCbFZIRDkrQ0dU?=
 =?utf-8?B?dlVXYmpDejFPSHFOQlltWUt3V0t3WStkQU5UQ1dKRlpCU0JyYW0xbnpWSm1l?=
 =?utf-8?B?Y25oRjhzUVppdUY2Mm5UR25Id21yNkplK3UyNG1aSTNLZXNJTHpNUVI5a2pp?=
 =?utf-8?B?RDU4d0hKR044cWZvcXZHTmExU0ZtZFhYdTVhWTFVaXFjMmhvV2NzRW1USVNF?=
 =?utf-8?B?NG83N2lhNTZMUzBXRnFCa0NQTUF2c3dKSXFUTUVyRkJZVEhKWTRCeG5nd2Rs?=
 =?utf-8?B?Z0RKWlFSVDUrNko0aGlWRkNmQmt0aWFoTUR4NUpZUnVOak9HbVFmaFNTQ1hR?=
 =?utf-8?B?Q0ZEbkp3N1pwNCtPZ1NyKzB4enVrVmZMWHo5c1pYOGlhZ2ZDSngzVXdQS2th?=
 =?utf-8?B?bXc5MW1FSG1NUmFLeGc3YklpNFdsdUMwcytHc2FXc1ZvcTZIblA3RjRTWVEz?=
 =?utf-8?B?R1NxWm5VWENVSklzSTdiWjN0U0hiQlhDTWU1TUpMMnBvb0ozeHVveTB5SFdT?=
 =?utf-8?B?dE1PSjZqd0VGNStkSlpUcytiVUZHUzJvTjF2S09raVlXcTRJZW5JbTIvV2ND?=
 =?utf-8?B?dHFJaXhjOHlwTG55R08vNXdEQTBGODVUWkQvdjJ2UnVaVHNNUjROMFA2dHgx?=
 =?utf-8?B?Nm52NE50YVl1U09CRE92RUw5NVBpQ3hLVXNUZVh2NjBhRzlPVTlseTlJVU9a?=
 =?utf-8?B?WWNUOTFtS2xha05MNGw1alhKbEwzSERxZnVYNTVtMUFacjMybGkxMllrRkZX?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 330bd5ed-34f6-470e-8ae6-08dd61b9b6b0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 23:00:41.9580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QD2mj7Fow11/Xq6k17oSiwRudqAsQswxlNCAqBwez6MF3R9FnteLiFjvmfTWQL2WKZ7VflcKOxdi94AvBwqUdpw2u+UExvBE8uSS6b90RdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6735
X-OriginatorOrg: intel.com

Similar to regular resizable BAR, VF BAR can also be resized.

The structures are very similar, which means we can reuse most of the
implementation.

Extend the pci_resize_resource() function to accept IOV resources.

See PCIe r4.0, sec 9.3.7.4.

Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
---
 drivers/pci/iov.c       | 21 +++++++++++++++++++++
 drivers/pci/pci.c       | 10 +++++++++-
 drivers/pci/pci.h       |  9 +++++++++
 drivers/pci/setup-res.c | 35 ++++++++++++++++++++++++++++++-----
 4 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 23c741e9ede89..7cc17e898cea7 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -154,6 +154,27 @@ resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
 	return dev->sriov->barsz[pci_resource_num_to_vf_bar(resno)];
 }
 
+void pci_iov_resource_set_size(struct pci_dev *dev, int resno,
+			       resource_size_t size)
+{
+	if (!pci_resource_is_iov(resno)) {
+		pci_warn(dev, "%s is not an IOV resource\n",
+			 pci_resource_name(dev, resno));
+		return;
+	}
+
+	dev->sriov->barsz[pci_resource_num_to_vf_bar(resno)] = size;
+}
+
+bool pci_iov_is_memory_decoding_enabled(struct pci_dev *dev)
+{
+	u16 cmd;
+
+	pci_read_config_word(dev, dev->sriov->pos + PCI_SRIOV_CTRL, &cmd);
+
+	return cmd & PCI_SRIOV_CTRL_MSE;
+}
+
 static void pci_read_vf_config_common(struct pci_dev *virtfn)
 {
 	struct pci_dev *physfn = virtfn->physfn;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 72ac91e359aaf..e6a986ad24d61 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3731,8 +3731,16 @@ static int pci_rebar_find_pos(struct pci_dev *pdev, int bar)
 {
 	unsigned int pos, nbars, i;
 	u32 ctrl;
+	int cap;
 
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
+	if (pci_resource_is_iov(bar)) {
+		cap = PCI_EXT_CAP_ID_VF_REBAR;
+		bar = pci_resource_num_to_vf_bar(bar);
+	} else {
+		cap = PCI_EXT_CAP_ID_REBAR;
+	}
+
+	pos = pci_find_ext_capability(pdev, cap);
 	if (!pos)
 		return -ENOTSUPP;
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e3cd9b8f9b734..af41f6c24451f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -655,6 +655,9 @@ void pci_iov_update_resource(struct pci_dev *dev, int resno);
 resource_size_t pci_sriov_resource_alignment(struct pci_dev *dev, int resno);
 void pci_restore_iov_state(struct pci_dev *dev);
 int pci_iov_bus_range(struct pci_bus *bus);
+void pci_iov_resource_set_size(struct pci_dev *dev, int resno,
+			       resource_size_t size);
+bool pci_iov_is_memory_decoding_enabled(struct pci_dev *dev);
 static inline bool pci_resource_is_iov(int resno)
 {
 	return resno >= PCI_IOV_RESOURCES && resno <= PCI_IOV_RESOURCE_END;
@@ -688,6 +691,12 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
 {
 	return 0;
 }
+static inline void pci_iov_resource_set_size(struct pci_dev *dev, int resno,
+					     resource_size_t size) { }
+static inline bool pci_iov_is_memory_decoding_enabled(struct pci_dev *dev)
+{
+	return false;
+}
 static inline bool pci_resource_is_iov(int resno)
 {
 	return false;
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index c6657cdd06f67..6cce3e19f22b0 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -423,13 +423,39 @@ void pci_release_resource(struct pci_dev *dev, int resno)
 }
 EXPORT_SYMBOL(pci_release_resource);
 
+static bool pci_resize_is_memory_decoding_enabled(struct pci_dev *dev,
+						  int resno)
+{
+	u16 cmd;
+
+	if (pci_resource_is_iov(resno))
+		return pci_iov_is_memory_decoding_enabled(dev);
+
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+
+	return cmd & PCI_COMMAND_MEMORY;
+}
+
+static void pci_resize_resource_set_size(struct pci_dev *dev, int resno,
+					 int size)
+{
+	resource_size_t res_size = pci_rebar_size_to_bytes(size);
+	struct resource *res = dev->resource + resno;
+
+	if (!pci_resource_is_iov(resno)) {
+		resource_set_size(res, res_size);
+	} else {
+		resource_set_size(res, res_size * pci_sriov_get_totalvfs(dev));
+		pci_iov_resource_set_size(dev, resno, res_size);
+	}
+}
+
 int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 {
 	struct resource *res = pci_resource_n(dev, resno);
 	struct pci_host_bridge *host;
 	int old, ret;
 	u32 sizes;
-	u16 cmd;
 
 	/* Check if we must preserve the firmware's resource assignment */
 	host = pci_find_host_bridge(dev->bus);
@@ -440,8 +466,7 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 	if (!(res->flags & IORESOURCE_UNSET))
 		return -EBUSY;
 
-	pci_read_config_word(dev, PCI_COMMAND, &cmd);
-	if (cmd & PCI_COMMAND_MEMORY)
+	if (pci_resize_is_memory_decoding_enabled(dev, resno))
 		return -EBUSY;
 
 	sizes = pci_rebar_get_possible_sizes(dev, resno);
@@ -459,7 +484,7 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 	if (ret)
 		return ret;
 
-	resource_set_size(res, pci_rebar_size_to_bytes(size));
+	pci_resize_resource_set_size(dev, resno, size);
 
 	/* Check if the new config works by trying to assign everything. */
 	if (dev->bus->self) {
@@ -471,7 +496,7 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 
 error_resize:
 	pci_rebar_set_size(dev, resno, old);
-	resource_set_size(res, pci_rebar_size_to_bytes(old));
+	pci_resize_resource_set_size(dev, resno, old);
 	return ret;
 }
 EXPORT_SYMBOL(pci_resize_resource);
-- 
2.48.1


