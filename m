Return-Path: <linux-pci+bounces-31230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1127FAF1018
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 11:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C677B7A9170
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 09:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F77248F72;
	Wed,  2 Jul 2025 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JxBR9aOP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C78D248883;
	Wed,  2 Jul 2025 09:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751448976; cv=fail; b=R4qd+5E/FtlMsKDJyZgmdbTZKzmaarelUxdOEoTbPi3r/ZtkumWzR1YOa94KQHnUU2HXoJgcHr1yZInWaKrnl+5Fo8GlLI+HoKpplswoHREdyH09gjkYFk++Bqt7b84CrqkiUvXprZG9HEJchkEBS26iYoUd5JiqFeQDVz6p4YU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751448976; c=relaxed/simple;
	bh=5XX+d3fHe4QLhFInVHsvXTy1SfIWSbrGHskllA9YeUg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e7mhQLjM2pSaERKGdaKCpuQuMPqA3Le1fcUZyIAWPiOOfjLR1xmfUstsEkyp4sxSxPa/XjaV2Qv9KXO2xsN91YkHESTXvEbb43FPNFFdxCks/sOYkEcVVz3maCcpgA7Yt4U0Lq7BIhSKPXgLfyfYH9VCQpkBg2T9Yjw0qsePDQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JxBR9aOP; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751448976; x=1782984976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=5XX+d3fHe4QLhFInVHsvXTy1SfIWSbrGHskllA9YeUg=;
  b=JxBR9aOPJK/7W8q3k/F01MzexsKhwE2xt/UqY9dw78PzZza9VsvePDiz
   AjzW7iyJYeYqGxLxMD1K4+6XTNro8Bh2CK4YnToEZYzLBaWQwb0+oM5xb
   Bh6x9I4EHB6W7vXUOHj4uo/YLnv4m/Evt5sX0ofpgooQy+3RaIC9VPZPU
   QpdYxDQb67FIr7zJbOX/Q1fwbumaue5NZRsAyA1l+RwbkKehVNQO8uYHq
   RQ38gbfadmuXWeEYcisdapvviD0bz+L0zKe+HMK1gTmWiXdK5oSoOanwR
   2B2LytnJYoV/Tr9fbKwmlebLPPNYL0GXM2SgFRlCuZ46uKBER7HZ+xWy8
   g==;
X-CSE-ConnectionGUID: o1N52KI2SH64IYi/lxN4yA==
X-CSE-MsgGUID: LiGGDEViSpyXFMGLjBhDQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53852661"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="53852661"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 02:36:13 -0700
X-CSE-ConnectionGUID: 6cPNq0BkQTGpTVIy8tDmtQ==
X-CSE-MsgGUID: a2+nMb3DSdeBpjP6YBAGVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="158404620"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 02:36:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 02:36:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 02:36:12 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.75)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 02:36:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YC1CZlwJvJcR2XlyeBSFGcNwIg2Sah/1bFr4+3QGF8u2D25XMZ1jIC/KF3jbYmDcTNwg5Mae35TrKDtv2nerKgsgWB5qW823yY0uF4xD4/WFgQOSJjhwM8sijwj2ocH5zXQ2S5DQH0YyJi+Azznii5SSjwyd15p+coD838VwFOOEBu9l3+N5um4kQu60BizxaqpJRv1DSaygPAtkA5JiFB7LEjs0FE/cjYNPoToqjsOVKN7wTakpIonXpFurSejMqg0H2pbl994BM21sn8Il4PfGDuEsci3OxJnBVOC/AgqpDhq2LkKmkRcfAFXFMohyI4TUnXQNJHlGKij13DqkgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3yisnENRaQOU2rkhz1qn3jrwnDhw1Reyh/cC+8U3ZI=;
 b=b1fz3zQ3xNVEW42GGQjGrAzczDMoLfWZKgUb2qId8JTG7giQ2j4yjYPVvkTLJraCgSoUEldQHXAQuwzF0k0dWHfqmrAJTVwRF/Eb34S4wKX0RJVleub3NUXQ1/9IyGy/AQ1c0lpUO54ZHSC4uHmQeHar3wHJ2VHJTi7kpAJjalpfBXI4eiZbw24Kjr+cTBVh5i0Aye18zat+TxhYSs4cuELGeXEZawkb4nkY2czQrAWfoeaDQ/sS5DSK2M3olK39wmS6nOIUNrdfVrZYts92AXyRNjwiTWcYKVSKY88V+RQMN3LRbnMg22JHcTvK0z+al6hwXuhdg/Uoh6EMTNyj9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) by
 SJ0PR11MB4846.namprd11.prod.outlook.com (2603:10b6:a03:2d8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 09:35:59 +0000
Received: from DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::927a:9c08:26f7:5b39]) by DM4PR11MB5373.namprd11.prod.outlook.com
 ([fe80::927a:9c08:26f7:5b39%6]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 09:35:59 +0000
From: =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Rodrigo
 Vivi" <rodrigo.vivi@intel.com>, Michal Wajdeczko
	<michal.wajdeczko@intel.com>, Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Matt Roper
	<matthew.d.roper@intel.com>, =?UTF-8?q?Micha=C5=82=20Winiarski?=
	<michal.winiarski@intel.com>
Subject: [PATCH v10 4/5] PCI/IOV: Check that VF BAR fits within the reservation
Date: Wed, 2 Jul 2025 11:35:21 +0200
Message-ID: <20250702093522.518099-5-michal.winiarski@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702093522.518099-1-michal.winiarski@intel.com>
References: <20250702093522.518099-1-michal.winiarski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0123.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::16) To DM4PR11MB5373.namprd11.prod.outlook.com
 (2603:10b6:5:394::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5373:EE_|SJ0PR11MB4846:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ceae34-057e-48ad-6383-08ddb94bda18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2tMSDNFd0x0OE5YYlpWSDk4UFNWaS9pSmZ0KzlCTld0NGlBeE1adk5VN1M5?=
 =?utf-8?B?WThoMVJSMHBqZVpGTE5saXQ2Sm5mMm9wbEJRbDROU3N1alltZ2UyalU0YStq?=
 =?utf-8?B?SmhxSjRibUNnNXFWekk1TmhKTkEvM1haTXowVTNZWWhzMjVWQlBWbGF4eXFM?=
 =?utf-8?B?Rng3OE1ISTJoT2t3aGxaNjVTUldKZ3NCc1dMMWlhTVRHOFI4Vk1YNHhtK1py?=
 =?utf-8?B?b3N5Uy96WUNyLzYrekVtc1Zmd2ZMZllmOG1rR0VKYnM2VW54QlRrZnFmQnZ1?=
 =?utf-8?B?MTlsWGZsSDZmeG5XOGhZOTV1alZQNmxGVkdZV2Q3K2V3SkZvNW1Pd0xLRmRk?=
 =?utf-8?B?b1ZibytEQk9mVUpSbEFPVndBYk8wZ1hmQVpLL3hSNlRuTjd2YW1yN1c3MDRH?=
 =?utf-8?B?WFpadTFTSjZzUGcreHV6dGdNVUQveWVYa0RMMmViWTY5VllLNlZqZU9lSTE2?=
 =?utf-8?B?a011QU9kZHZmK0Z5RjJ0NStVc2toYS9oeHdWd0lCZE5QdlFwQ0RvZ1pibVF0?=
 =?utf-8?B?V28vY1R2TUdheGYwQTVmNFFmKy9wVlJ5R01wdzFxb2hFQ2ViS2h0ZnVEb0tB?=
 =?utf-8?B?WHFtUkpEcmhKM0RDNmFyWGtmTFYrandQUUFHc05sOVBoa3ZFMHljVW5JN0tE?=
 =?utf-8?B?a2FrNVpiZVRYOGtOMGZRR05nZzkzWjBmRnkzZ1lsVmpYSVFNMnBxTXpaTGwr?=
 =?utf-8?B?bmVRUmJ4QUlwV2tCTWo4Wi93K1hBR2Q1bEFKajRKdUFINTBNdXBaWmhOaHhu?=
 =?utf-8?B?WVJ1ZmpGbHBSQjR1bGFsbVBIRHl4L3VjdjNtU01MUkZoMzdhZFRVN3c1QXZE?=
 =?utf-8?B?bDNGUzM3Z0FCcVR6aGYzMEkzZmFraFdaZEQvTFQ4c245MDlFT1MwcWJNRkVU?=
 =?utf-8?B?ZDdvbGhhMFVxdExkNW5HMTNMeEFqQUpscjkxOW1xUHp6QVR4YUtXUmxmRzNR?=
 =?utf-8?B?UFJwVVRCK3pITDlUOStOZU9KcU93VjFReDlOSHBxUURLcjg1Ullkd3QvZDJB?=
 =?utf-8?B?VDM5VHJHVWhtZENsU1N4NnVNRDJ5OVhIVzB1SUVEdkpJUmZ6SHVYaS83VlRP?=
 =?utf-8?B?RVZlSEJrMWNoTHB5RUVNeEZMQkhLbFY2bFRhN2ZaeFpWUlVpY2p6d3ZTZ0Fy?=
 =?utf-8?B?d1hFMXRSQzNINndzelBMT0JrSzV2aC9NNTNwbFM1N0h3NFJHZzhhUTRXRU13?=
 =?utf-8?B?N2pQMzdMZ0tiUTBGVFpYYm5mbkp1by93eDliU3BHL052TXQ4Y0RxdnVsdTgv?=
 =?utf-8?B?MjVvTks2WHpyTGVRTjRhZTR5V3BQVmJwNXlDTlQ5MzE0THBjaFdFaVNGUGRq?=
 =?utf-8?B?RjkrdTZIYmtJWU1EaWlOaEdyU3F5ZHBtc2RQYkxkUEtMMkVwN3NSanZ3VnRx?=
 =?utf-8?B?Z3hrd3AzRzRtbVRPMjMxWFhuekV6NWF5SFBpYnZ6cHh5cXBvbDRrbUhnQ3hT?=
 =?utf-8?B?US95TUt0WkZHdlNkUUF5bDZhQjd4NlllL25Sdnh2VHpIb21HQlRhbHBtNjdL?=
 =?utf-8?B?Sm5FU1ZZM0xuM2lxaHc1elF0V3RSd1dVbDY3VXZma3JCeG4xZ2dlaUpNS05O?=
 =?utf-8?B?YTZhNlRjS0N0S3lyWGhRL0cyTERDMTNleWIvQXFHUTVJUVZxNjRmQ0F0b2M4?=
 =?utf-8?B?VXQya2F3RCtJZmdiYjh1aHR6NFk3anVTN2F3VWtNb1FUbUF2dVhFWkpHVGZj?=
 =?utf-8?B?NEN3Uk52UTMxbjJKdzNaT241aXY4MGRoN1NLM3NkVTRCam5GVlhSaDl6N1Qx?=
 =?utf-8?B?U3hzZmNMMVZySEZkOGNDVUgzN3N4YndpMFZJdGhPTFI0SDdIamlIYko3TmE1?=
 =?utf-8?B?V1RITXQ1OGhlUjBvL2ltTXZVQWFvZDZCbTFBVm9tVlduL2dtVHZUV1ZFbjFv?=
 =?utf-8?B?RlFHdUcvcTI2NFBUQzBoakNWMVNLTVRrelJLdVY5OEZYczR3YlMyTTlqRDhC?=
 =?utf-8?Q?b2/yQj542PQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3NkTldZdlVQNnAxR0pCQjViMVptWXhNdTYvalpTekk2ZENOUk1ZaUpCWnZK?=
 =?utf-8?B?VGdMeFdLd2wwNllsckhQNzUzbDVnREdBVHpuQzdaSzc4TXVFeDZpTE9PQ3Bt?=
 =?utf-8?B?MlJuMzFleE10WG5qODFGOVdRZWl2c3I0WXVrajRLZGRCSDZENjJrR3NuWll5?=
 =?utf-8?B?RllqMFg5TGUzWnNXWWgyaU1TcEE4NFZjWVV2dzR0MHdoMHJuM1lub2E1K3l6?=
 =?utf-8?B?UWd6SExvbFc0dTJrRHQvTEhIeU1hUFV3Y1RlU09vKzg4NEdVMDFnVjg4TWxC?=
 =?utf-8?B?ZlNhVk8rdzE4NWYzZDh5aTNzK0pjUUs3b2twdlovMzZaN3ZVL25PWGVkZXpm?=
 =?utf-8?B?czVhbnNMN0hveVVTbURpQ1l4d2dqMEtPT3hDV1NMU1lkaHZrVGZsdU4yTlFE?=
 =?utf-8?B?aGFMemdSaHdSUUhjRkZLVVNnRVJIa3RsTDJvSWZPclpDSndnOGpzdDM1MTVx?=
 =?utf-8?B?cTF3UVRMOUkwNXA2NWhXYWFuQmpORlgybkFmby85OUo4VFVLSFdTTndzcW5C?=
 =?utf-8?B?RWpjbVN3aWNXaFdmNlJFTG5tRzRnZ3lGdERiem1IdTJrcDR0WVNkUzVHS1ZD?=
 =?utf-8?B?dkEzWTIvNUJSTG5uenQzZzI3YUJZVk4vbFBZRFJjdFBkeVYxbHBpbmtpczF6?=
 =?utf-8?B?Vk1pekYxZUx2elRwUnQyTzQ3MHFlNVd1cndMd29sM1c5YkZiZWN4bzVwQkdw?=
 =?utf-8?B?ZDJXdG13dGczOFhkbjhUS3V6WnluUzhFOGxBRlVMTWE0SzBUNkZwalg3alF4?=
 =?utf-8?B?MG1LY3BIVGg3QWRWWDJqcXlXazkzSVZ5TDJMOGpzTDkvY0R2S1NoR3lBSDdj?=
 =?utf-8?B?NndTRFZyNlVIV1RXYXo3K3NSb1JxazVlcGtYcVQ4TENqSnZKbDlBbXNLYlJt?=
 =?utf-8?B?Z3JiMnhLZnl5anlQR2xzZlZTQVM5eVRJMnU1bGhVQ2ZJZkplSzZoN3Y3aHk1?=
 =?utf-8?B?VHpoOFBSdkVuUE9SRnUvcGlpYlBuSTN2OE9lZmhBYm9VdzhOODRYTFE5R3cr?=
 =?utf-8?B?YW5Da2RpeEJOdHJHendLM0JVT2dXNWxySXBhOXFzV00rNi9SWU1JTE9waVJD?=
 =?utf-8?B?NWJVaFhFMCtTRW84UElaMUVCZ1pEa1JTVE5ZQnpSYThubGp3K2FxbWQ3RGdZ?=
 =?utf-8?B?dUdCUHBQeDBLTUVmcWpTZ25ualNlM3RMc3orcStDS3k3ZDBYd1laUzNBa2xa?=
 =?utf-8?B?N1piZkRLNU00a2ZmWGNsbkJPY3lSU082MEp6T00wc21mMTFqVzdjVzRIeUND?=
 =?utf-8?B?QzdaU1pBbmRBUzBVeVdxOGNjWTRpSlVFamM5d1pvMHdBSk1MaEJ0ODl3K0NX?=
 =?utf-8?B?aUNQei9rRTdMaXg1UlVQSEt1RXR2WjE3RTNuekZGRXdPZW9vZ0NCRkR4K2No?=
 =?utf-8?B?bEhtVDNqWmVQWVg1dUFsMm0vemxCSGRhWS9neWNQWnE2SnVtVzQybUxrOXVm?=
 =?utf-8?B?TFhBMS9RMUR2UDhqbTBBa25VNFA1SHI0TEJjRldocXlRTTAxOEkzK1ZIeHFS?=
 =?utf-8?B?Yk0xSWVka21XdmttK24wNzdMcHBkRkxhZEFLNUpZN1p3UU4rQlVnVlJNdzcw?=
 =?utf-8?B?YVVTQVE1Z0kvdTZ4cEMrNDhLQlErOTlXam1HVCtJZXNHS0I4TG5GSy84ck0w?=
 =?utf-8?B?OVpJU0hERkFmNFNFbG54SVV5OGwvcnRYQkg2dm1iaStuSFh4MG5BdWhldyt3?=
 =?utf-8?B?WHdsWjFiQW9UbTNKVnlIeDN5NXU4bk90dlpLUHR0cG1OUVIrOGRrWm80QTZp?=
 =?utf-8?B?emJpM3laMFE1TE8ySE9wbjFiUFJJRGZuc0UrQVRDT2RqMzZBWndxUmVnTm9U?=
 =?utf-8?B?TnFZMTdiNTA2Kzg1Q1Q2MGt2OHBnVkJLc0dxS1V4dDZaQ3ZZdGNYemlJZTRH?=
 =?utf-8?B?TzZJYkxKUHFtcjlaUUthTXF2QlRhSWdRUVRYVFc4NUxibUZ2Y1pzNFpoU3J4?=
 =?utf-8?B?NXJBTXpFYTVlMU0yVU8xT3ljMUF0UTlqTHZKdlhKckVMdXlhN0FFRlIrbEtS?=
 =?utf-8?B?STRmcHVvbURCa3N2MHdTMisvc254UytVdWxrMWRXSVJPN1ZHNDVQTmhxdkov?=
 =?utf-8?B?eWE5dWQvdVAxOXlES0dzZ0xLUVNtUVI4UGJnNUJmcktzalBoa2x3Z1d6ZzRq?=
 =?utf-8?B?TGwveGdocXBrZkp5S0dEeEY3a3pHOWtha0RtZEVSUzB6QXBSbEFFL2dqdDcy?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ceae34-057e-48ad-6383-08ddb94bda18
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 09:35:59.0418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2AZjwMVLVN8BARbK+GUmUbony00lgcTOAo0whM5a5c62WUJ0FUWJoXNf4eittekMm4vFfxPnQkdD3PvXAVv+/GtrVKt12crhraU9mqLvxng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4846
X-OriginatorOrg: intel.com

When the resource representing VF MMIO BAR reservation is created, its
size is always large enough to accommodate the BAR of all SR-IOV Virtual
Functions that can potentially be created (total VFs). If for whatever
reason it's not possible to accommodate all VFs - the resource is not
assigned and no VFs can be created.

An upcoming change will allow VF BAR size to be modified by drivers at
a later point in time, which means that the check for resource
assignment is no longer sufficient.

Add an additional check that verifies that VF BAR for all enabled VFs
fits within the underlying reservation resource.

Signed-off-by: Michał Winiarski <michal.winiarski@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/iov.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 852424cf2ae15..f34173c70b32a 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -668,9 +668,12 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	nres = 0;
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
 		int idx = pci_resource_num_from_vf_bar(i);
+		resource_size_t vf_bar_sz = pci_iov_resource_size(dev, idx);
 
 		bars |= (1 << idx);
 		res = &dev->resource[idx];
+		if (vf_bar_sz * nr_virtfn > resource_size(res))
+			continue;
 		if (res->parent)
 			nres++;
 	}
-- 
2.49.0


