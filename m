Return-Path: <linux-pci+bounces-37498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 311C8BB5CD2
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 04:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD2D1AE5028
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 02:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17BA1459FA;
	Fri,  3 Oct 2025 02:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M/NIgkx2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750DC242D91;
	Fri,  3 Oct 2025 02:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759458388; cv=fail; b=WO264e4etW6QFqvH3JxadDHCjh3G933Hys43hQMgC028hvm931REkpKNiUtsM8PlmfDeWJP3KvqzSSda59rozasYWHbXVMyulYMWTPhv2nZif4quyTpjdwcd+Buj4YqHkQ8oCesmbr6C7smWXlSKc3yXUG8PHaC40uXX9JAFBls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759458388; c=relaxed/simple;
	bh=SRACL4zBDI55koCF/D4aEgiUBZ60YV3LqqHy1qI/vvg=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=tUz1mo5uUG0/K87Tb46UIQkgYQZAz0GVxdwArMNeB8T6srLq9/K5jakVHyYpq5SQvnoUyB25pwFf4BZ/DydlC9hwq/8G0NVuYCBt53q+cPksXOMj+fPF+7LTOXKXKFWpSc19aewW7S4JaVr8/cPi4tYwiBb4xxUjd4N+aW/Dn1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M/NIgkx2; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759458383; x=1790994383;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=SRACL4zBDI55koCF/D4aEgiUBZ60YV3LqqHy1qI/vvg=;
  b=M/NIgkx2HNyiQD/ozoPSGBGZP+HMTHKgbL6LYs4NNkiJ383gJFVlm20r
   77p69i3q38bvxPQOBF441vYXJ52bdKf/53mKgxAmiRnTV+72dt6a7Om67
   MUnXSKwHNUjruiY7m//aUfx88wRcvSoFJKyi0U5rUgCt73Gwcq4O/Oo6/
   XDdRBiXufAQ1sUyFRryBmK5Yb3YcymAAqTOsV8JCpXBNLv/f95Xs2luBN
   YCEzUgRthptdP66ey4Oqtax4dRl9TUkIBRGAkry1wqyjVbFbHceeX0qyT
   DfOn3/vzxTN984/qfj9x9lDi/qhTbt3eSq1+IbYFnRA7aeAn+zrB6e5/w
   g==;
X-CSE-ConnectionGUID: OjppMrf+SYuH01K5dUAuyQ==
X-CSE-MsgGUID: nG5u6DwiTuS2WC0k3Tuk5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="61791731"
X-IronPort-AV: E=Sophos;i="6.18,311,1751266800"; 
   d="scan'208";a="61791731"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 19:26:23 -0700
X-CSE-ConnectionGUID: wybeS5QCSbGiALCamsaG9g==
X-CSE-MsgGUID: BSjL6quySoCp6yjdr/JnIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,311,1751266800"; 
   d="scan'208";a="178302445"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 19:26:23 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 19:26:21 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 2 Oct 2025 19:26:21 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.52) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 19:26:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SnmTxi1skrR6ByACIvrQk9SqyCKsq/Z8zOzuAt9ejevIfMqn/Syz66+SE+9XKLh9YOVXQ266N9bPHRGzHAlRwTtb41yHxa9cxwflI4EWCKw0Yh/GgNesJwFpReIXWAgOCSH/27bxpgkgZa4P3y/61LyDY2sCT+MuBF9cGmUfZ4DQm5mskuxahCV/38/xT+kddbj32+0WdDPA53KD+UCpQIBjOvFCBS9/YVq14al5l6z0js2TWD8NYl7WqGPAxdD9LmIJ1W4p3ShyTSF5TUL+sTiDj8TNJ67vbBQTpQQOXllo9Vx44e6Kol/v7bMuGqhZAKo0YDvzkyHXzUB69CF/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRACL4zBDI55koCF/D4aEgiUBZ60YV3LqqHy1qI/vvg=;
 b=Wf9FV31E5zcmRiYteO9zIEEAEgtreB0EvOqP8lo5XfSlkRg9I7slf1kCNInIP7rCHmWw0AHH4k0CpkR6COB2/bULFLyAaviGW8FGXjDKPO7lp9MVJ3JQPFARPCfqE6AYQmkArNeL466vGMmwb6PfyqEuBAuL3mZH8RLvzURvtbwFgMEY+ZCg+8gqD2rM23WvVccIJ2jqkZg+Sro2hKxuRFA6IFOtTqDTN1mRCB092/+K173baICiCxtT12Ex+Jz45gkGZ0INiYuEnmu+TVQZuOxFpBXTqcOw4yvCpG13lMHTXguUOUNmZT6D515bCA8pU5+hZ2Yt0RiJzzqWrSD9zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA4PR11MB9010.namprd11.prod.outlook.com (2603:10b6:208:564::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Fri, 3 Oct
 2025 02:26:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9182.015; Fri, 3 Oct 2025
 02:26:10 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 2 Oct 2025 19:26:08 -0700
To: Xu Yilun <yilun.xu@linux.intel.com>, <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<yilun.xu@intel.com>, <baolu.lu@linux.intel.com>, <zhenzhong.duan@intel.com>,
	<aneesh.kumar@kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<linux-kernel@vger.kernel.org>
Message-ID: <68df344061e22_1fa2100e6@dwillia2-mobl4.notmuch>
In-Reply-To: <aN8uEHZzd2cCOYoK@yilunxu-OptiPlex-7050>
References: <20250928062756.2188329-1-yilun.xu@linux.intel.com>
 <20250928062756.2188329-2-yilun.xu@linux.intel.com>
 <68dc74a6b7348_1fa210058@dwillia2-mobl4.notmuch>
 <aN8uEHZzd2cCOYoK@yilunxu-OptiPlex-7050>
Subject: Re: [PATCH 1/3] PCI/IDE: Add/export mini helpers for platform TSM
 drivers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA4PR11MB9010:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b1dea91-393b-4682-5a9a-08de022436f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWZtTzZ4Wk5MRFYreUs3ZllTQ3BuNmRBNll5cU1DYkVQSm5SZGFIVjYzUHhm?=
 =?utf-8?B?NUpFREY4YzJIOVhoNVUrQTdYalJtekRPN3RUUWVSR2VTS2N2aFdXMXRCb1BQ?=
 =?utf-8?B?a2laZ3NkOG44bFlDWnp4bncyUzdRTWRia3dLY3Nmc2szazNPdE5oOEEyN0xp?=
 =?utf-8?B?WUkzWVJEd2pwRmpIVitkd2RvbGx1eGh0MXhHeEtkWmFXdEpwYWFTcVdST0dR?=
 =?utf-8?B?U1ExNGlsMFkxRDBZMGl2OTVzb283b1dyT1o4ODA1UXM3UFBJbmpsdnNoOU9j?=
 =?utf-8?B?MDcvZkxjSWlMblQyVk1Va2hseG96dDByVWxvcXV2WlVHQWdLOGNhUTlMV0NP?=
 =?utf-8?B?bE02UzB4TXErY2IvT25EZ0hIZENvMGRCTm1ScnpCdEJvVC9qMDhiaysvTHFU?=
 =?utf-8?B?SVEyNUlpMTRBMlJmY2JrdGhML1FWNVZudVdDZ09MVkFLOFFWZUxRWjZWMWt0?=
 =?utf-8?B?ZldQU2QyakN1VitsMlRHZjQ3aHVORUFpUTFycHdibmk1azNubGF3SE1mT2Yv?=
 =?utf-8?B?V2JpWVFBQ0dtSk9wNmg3cUdDT0tFSWYwN2d6Y3NsbFN5b00zUzQxNnFKQ0x1?=
 =?utf-8?B?TFl5ckpONHJUbnhqMjJkWXZvczhKUUE2Yk8yZUpPa1lUVzB5ck1NdDgwY1dJ?=
 =?utf-8?B?OG1BdmdSeTcvSmdYekJOTjVQa293VFVFNGJpWHphc3lpTGlvRXpoa0tRa0pN?=
 =?utf-8?B?U2tzblA5SUxud0VXQ3JZaFhuZW5iUE9ybXBsVEJvQy9Yb1RWdWsxV2FBRGMw?=
 =?utf-8?B?M1BaMlVtQjl2SnNwQlhXL2J3aVhQcW5Ha3VWc1VpV3hDUG5NSE14NXlqWktD?=
 =?utf-8?B?QVEycFlEWitFK05MMkJhZzN2NHo2TnZKVEhzdTNIT0I5WTNWSGtKckgvdXFm?=
 =?utf-8?B?L3IzUzFsYVA2YzZsNkhhdk1lNW81ZDZIM3hsTW81L0FrWm1Pd2JOeTFJUGEv?=
 =?utf-8?B?K1QzeTBSWUJjLytvbVFKNE9xSHVMdnlTNGhyaU42VHdMM1FRb0ljNmxCcGlG?=
 =?utf-8?B?d1JmTHMxR25lTThkamQ4U25rVHFlcWlldFJSaE9CUXlvRkd1THJNempyajBN?=
 =?utf-8?B?Mi9hY1hWZ0pGdy9CQVFsaHE3M01uTW9IU2dYaUU3U3daemJ4QVd3aWdIVlJ0?=
 =?utf-8?B?aThvVzlpNmVvSG9QV2I1ZGdSNy9yT2VvRU0yT0JyazRMeHkwWXVOZXhLRFNK?=
 =?utf-8?B?OXE3R0EwNkEzYlh6dk80dWxYRVZGM3oyRHhBdlgrVzludytSeFhoczk5aXlM?=
 =?utf-8?B?VDQ1Y2hBVS9wVEdDR1FoN1Z5VGlScVFmalVGZEVxQzlNVkRYVzk5YVFVYnR1?=
 =?utf-8?B?MkJ6RmdjZERObmk3UGY0N3NBd2RLNVdnQmhHNmpUTUlNTVdQd3cyb3BoQWJJ?=
 =?utf-8?B?QzFucjUvN1A1RDZXZXduTkl6TlllcjJCRUZyRTRUWEhTMWc1YjA5Mm40a2tl?=
 =?utf-8?B?cENYcHd4L0k2NWZaK0dlYlo3WldKOGN4anRNb2VsejB3WGVObEU4NFYzNnR2?=
 =?utf-8?B?Vkh0VG5yU0ZmYjBYcU11MFh0cEFXUUlyWlNwMCttTlc3YldTTlZjV2xrTWRY?=
 =?utf-8?B?YVljcUNQb245TVZtOFRSU1FzTVBFY2w5TXo4UWtNYWNOeHRQOTlZczJrd1U1?=
 =?utf-8?B?d29kQjMxcWsrc1VYamcvZEZ6NWNBejZzWkVDeVBPNklWZ3JQMWV0TlpMR3ZS?=
 =?utf-8?B?V2tXdTduaDhqTm5haFB4U0JUVmVjdmRoV1g0UDNMdWJSaWlYSDhJRHlpa25q?=
 =?utf-8?B?Z280UUdJRGFuU3lJQTc3dmZLNDA3dU9wQlN5aXp3aklyenVHblRmWU1aN1Rp?=
 =?utf-8?B?NWV6dmlBSGpFMno0bTUwc01WaHRZbDZRZUhGN0xjT0tBdnMvRm91MnhCTjg0?=
 =?utf-8?B?WnZMVmRmeStsbDVHT05uNm92WVNYbDB2N2FVbWVDbHZTSVE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cStkTWJBQzl1OFlOMDA4R3liVW1ZcnBhZFUzaHYrZ1V1aEgycjVGbDFRSkZJ?=
 =?utf-8?B?OWxiTDQ0ek83c3FPMkg5ZDNrUHgvcVRNdkZzMmQzNitLckFGOHNjeFZMQSsv?=
 =?utf-8?B?ZlNtNGdLVk1DcE84Z3dZMTBQaUFPV3p1Y3lQRVF2cVFCbVkzcWZuY0R1czl3?=
 =?utf-8?B?WENzdkkyeFJUWGZBcXhUM0c1TGRtckdIaXVsbXo1YU13eGNyOWN2Y040YWFx?=
 =?utf-8?B?WTNNVmZOSm9aYkxmVzR6eGxaekV4dUxnM3VjL3phUXdwZ291MHZwelVxOG9V?=
 =?utf-8?B?a3lHRFZmRXVLbnJuZkwvb3BIb25BUC9iQ2tpRkFySkdMa2RkQ2RERjczcXdk?=
 =?utf-8?B?RzgzYnNZZ1orWVZqV1RRWjhtWFd1MUU5OXJSR1JiZ3pieXRUVkxrK1h0a1Jw?=
 =?utf-8?B?U1NkQ0J3eUFvQUpNeHNSbHJSdVpCTjNabDNGVldKczZDdmdIbWdGdW9EclU1?=
 =?utf-8?B?clZSUjZFbVRzNUYzdkQwclh3Z0VUNWl3Um9WNGdrWVJYUnI4UzA1R3E2UUJ2?=
 =?utf-8?B?Q3VlYkpQUHdUR2h5R2ZxNUtwYVMybndSL1RTeUtWREsrWlZaMHFVOEw2bHlU?=
 =?utf-8?B?QzdBQXUvUVRSaC9YaWJqRWNvL3VBUlVBTWtaVXVzVlBOaU1kQ2lnRm9DRzhI?=
 =?utf-8?B?QkRvTkZNQ29FeTVONDBWQW53NXVxbEZsWGFoYis0WE1QTFZKMGRJQ0g0b2dD?=
 =?utf-8?B?RnhWQzA5UGNMZWo0SnpROUpHOTI1VjVNNHFEcjdLcHpZS1NvZlV2SVZOZkU3?=
 =?utf-8?B?c1ozQTI3WWpaNWpGTzZwVEJwT2ZzRXhVZ01TZm5vNkgzamsxMWpjTmRnVTNk?=
 =?utf-8?B?cTAzVHlldWhVM0tQdnJiell4RWdXZ28rSFBRMllUWkQ2UXhtdEQzZVo3Zmlx?=
 =?utf-8?B?K0NTQWVlVU8xekxEVlZITC9hSHNTK2JQQ1VUT2pqT1RCaFlxemhBOWQ4aWo1?=
 =?utf-8?B?NzVUM215d2Y4S1ZCZ2kzL2xTYkVRcEovQWZaWGlmU0Jia2lMMXc4akIrQ1Ex?=
 =?utf-8?B?UTBFc21TQmd3alhCQ0ZPemQ2eVRvM3B4RkptRjRKeVF4OUlWbk5VTFEyb1Vu?=
 =?utf-8?B?YW5DSXdqcWNHc2VBR2M0WXRQS2k3Z3plcW9VQjRyeWhqLzdpcFg5MnhNbFZo?=
 =?utf-8?B?dGliV2tTTGZrOUFlWDVVUTBLRUdNdG01NHVSN0w5aGpubTVqeTZPM0RGN2Vh?=
 =?utf-8?B?ZGtuNHp2d1lWNXdWaUNrNDJiWUhQVzdEL1pMUHFZdVFQaDhiTGdwYU1BZTJr?=
 =?utf-8?B?MVIya2JEQ3ZjeEFmbXVEazZPbkdtTTdHWFBhZmU4TDJOTVNDckJVRkdyTVNp?=
 =?utf-8?B?bkF2N3lrNE9oc2FYUGk0Ry9uSVZMUDk5UzYyWnJTVzMrRXN2WnZuNnJ3cHRJ?=
 =?utf-8?B?UCs0cGpTY2twK2ljYVRkSTdFNjZ2SmVFZkdFbE1WUmM2L0lYU3QvbFRRS2Z2?=
 =?utf-8?B?VmtDb3FhNnlUelZzLytLRFR6aVVOalpadFpUKzdrN3M5cG1OYVhoMUNOSHh0?=
 =?utf-8?B?UGYzKzdobmRibnZqZlBGVG9FdWhKQlFoUlhFeGpic1ZXVzEvYlhnZjhBNytC?=
 =?utf-8?B?aEVaQWFTMkRrU3Q5MXBoeWRhaEh4WnhaM25mbHVqM0VDL3Y5K3VoQTJOd05h?=
 =?utf-8?B?RyswajlTcTgvOTFPOVdGRVRNVUt5TVpOQm5FM3N4dkxOMEVoMHR0SG5UL0Jz?=
 =?utf-8?B?QTVaQ2VhR29PaS9LT2pLRHlrTjVnVTlacUxibzEzM1B3cHhuUU5oVG16cTJD?=
 =?utf-8?B?S1lkZkNsQ1FXYmRyaDNWdmV1aEdJU3Vtck4wQkpGVmMxQTVJejBCTEp3cGpv?=
 =?utf-8?B?Zzg1NFFhcUFLdjdLV3Y5VVl2UTZMUk92WitaQ2pxUW04a3RlVUp4TUNXOW1B?=
 =?utf-8?B?Q25FTGcvK3hiWU02UFQ2eThTOTBiMGJQRUxFYVArSHRmbmpDN2VEeHRMSi8y?=
 =?utf-8?B?M25jVGkyQXZZOUZTb0o0RTdxaG1wNjJWTEc1RTRYdlVXalhtMGZsaE1HZGVZ?=
 =?utf-8?B?TzJIUit3U2RreGZ6a2VEdWRDdFhkQitQZ1pVa1hWdy9RRXNhaHJBWGlGS29F?=
 =?utf-8?B?UVRmbWs3Unpsck0xVzhqSWFJU283WWg3SGpEeGt4L1ViL3poejZ0M3dTT0d2?=
 =?utf-8?B?d0l4SFNubURnWlpPSytUVEttY2Q0U0Y2NDNZbFBaaWZoeUo5a0pwd043Q3pZ?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1dea91-393b-4682-5a9a-08de022436f7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 02:26:10.0201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePshrhBGhije8US3Dy0Zwk8+DLcqxi8ltjoSoljOjCzrDlvU9YGWBTvSJ+BvAR37xtl/rloiyQqEea7dpnFWXFUJQxAlmZDzZbpnNcxBi44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9010
X-OriginatorOrg: intel.com

Xu Yilun wrote:
[..]
> Do you mean PCI IDE should provide the collapsed raw RID/Address
> Association Register values for platform TSM drivers? TDX needs these
> raw values for SEAMCALLs.

Right, see pci_ide_stream_to_regs() [1] as the proposal for TSM drivers that
want to share the same register value setup code as the PCI/TSM core.

[1]: http://lore.kernel.org/68dd8d20aafb4_1fa2100f0@dwillia2-mobl4.notmuch

