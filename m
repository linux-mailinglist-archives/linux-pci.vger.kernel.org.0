Return-Path: <linux-pci+bounces-35313-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 377D6B3F8F8
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 10:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9641B2233E
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 08:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2419526E704;
	Tue,  2 Sep 2025 08:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S84ZD/1u"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2B623AB9C;
	Tue,  2 Sep 2025 08:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802653; cv=fail; b=kruBpBFxL5CpM2OuDooUMTufO/6dOrbkRBm1z2AZxP4wOt2uK0ZhRZcNT3726PtaW+HYK8HHSKkiGk715r0nKJEab6KvTK0HIVnp/JJyVDht5nSbB/FytK3UhGNOrICg2Efp/ghInaRfXVgJcZedR6JnZrmQiLJlFVOEtmDcNKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802653; c=relaxed/simple;
	bh=SbTRKK2bXvlPvYT1Dih/WT3saF5Ys4F2hdKTUKjJrQw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H3aJaf6GpncVer8VmjQ66wUYexQux4AL9BCNtaoJXGZUXP2o67jWo+avH1Xvh/O2c8UEXN6QH+6RN+yJcxA3BzFsb3Gzmi93ph9BGKqLL1GJGDmY+6A2pUYnKDAh+DN7dfLDDQ+wEdXNuZD0L5+mQ2zfQo66nQBYUTYzVTgDpK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S84ZD/1u; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756802651; x=1788338651;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SbTRKK2bXvlPvYT1Dih/WT3saF5Ys4F2hdKTUKjJrQw=;
  b=S84ZD/1uePB6mT/X5nYkwlE2VIwHrg8i/IZh95HYLTG3T/lG86sCNJCa
   AeCC0T8bIYlel5TVZVuFAMRN4nuunNq6n+NEn9OXsuHyd6k1sSv5+Flnh
   0DpC25Jn4eEV8kHGm3cjiW9OcYIWj/aYqK8V5i9DQfEc5uAcP4WIx7lmT
   SgpmIerQUoMMdGzmQKnU3Sc3zfmOyXqxGixD2VU4d9N8FOfBpPRQu5BNu
   U/Lhbx99G24VGHBU5z5/WM+/gb9DHPbuUACMGrcNb041DDlwolE0M4BHs
   afB8EGUtgWC2B5GkTFim1vK3/hX5eyg7pEvXNzYswDC/e2CPTOonq460W
   w==;
X-CSE-ConnectionGUID: Wnz+ZbKrSxOzX8co8wAykQ==
X-CSE-MsgGUID: ihC+MDD1TTe+j57pB0uSvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="59203303"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="59203303"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 01:44:10 -0700
X-CSE-ConnectionGUID: 1SWjy/72QsesgQ0/pHDzRw==
X-CSE-MsgGUID: ohn0uTpSTB6eACY1OMr14A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="171099494"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 01:44:11 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 01:44:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 01:44:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.83) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 01:43:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dkgCgtmvkBWbcvfaZVID8zm56ra7FcfWHBRN+yVN1ySSkoAQz3fV83oKRKhcf4ch1QgPy4lv+bbvqW0jaMPXhJHgEZNfTTqa9rHLrQG4UdTPPi0SgWsVa0fcZ9pUkBKC4FbziF+g9FB7TH2gj1fQnoIWM9pUuYi3ACHe6eLFSqNqNF6TFIQxaL3+B1vTvkWboftNX3df49OTIr4tw7sHDE2FTdQiBOd/kJaAfbEulqreBw9gmddtntJdb4KdhuYLRBgXo/knxVuymHk1eYLxwMS7E9IcJjkAjWzAl3REiC4QJSKVrTXZQYebr71cxfg8z1suga0Ab8vmHqvThKdUgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3s5OY1xNLdm6Vveu6zqb2qQDRBCzMSmmoRmS733zOFg=;
 b=s2nJm3rwEmgI1GGjVFhIx0NjngRuANKmn3dUcpZYIgh9HWhjNXiuudigJbEXD/qZRCxds9dVicUppLrR8rCA5nJt9RjAUUDy1BCetPfJ3UeG6YV7l54hXPAxLIVwBJht/yCMncmvj89OmJ4MHPMBEuZhjBNm/LTS4eoBCbYsVrPP9Q+PdX5qq603skW1Dto1uqKujd69E7lnnmQmrCDfb4Wtvc7r58QAPEiCL2Ur28IDxGlWlJ9/kmkhZLslsCk30WP2wpzvDyEkHsv0rrOlnmuXSL3+gIDWWzRm9UGo47ki6gnxEuarsstuqnmESdisaLt9H+z7AhXOhtOGnp5+uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5530.namprd11.prod.outlook.com (2603:10b6:408:103::8)
 by CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 08:43:55 +0000
Received: from BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9]) by BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9%7]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 08:43:55 +0000
Message-ID: <92b3b8b5-30c6-46b8-81fb-407d1b980995@intel.com>
Date: Tue, 2 Sep 2025 14:13:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] PCI/ACPI: Per root port allow one Aux power
 limit request
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <anshuman.gupta@intel.com>, <lenb@kernel.org>,
	<bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<lucas.demarchi@intel.com>, <rodrigo.vivi@intel.com>,
	<varun.gupta@intel.com>, <ville.syrjala@linux.intel.com>,
	<uma.shankar@intel.com>
References: <20250529111654.3140766-1-badal.nilawar@intel.com>
 <20250529111654.3140766-3-badal.nilawar@intel.com>
 <CAJZ5v0izykarC5yXNbd=Gdycfk7Qdy+U8uehhHK0bmXbt40O2g@mail.gmail.com>
Content-Language: en-US
From: "Nilawar, Badal" <badal.nilawar@intel.com>
In-Reply-To: <CAJZ5v0izykarC5yXNbd=Gdycfk7Qdy+U8uehhHK0bmXbt40O2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::15) To BN9PR11MB5530.namprd11.prod.outlook.com
 (2603:10b6:408:103::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5530:EE_|CO1PR11MB4771:EE_
X-MS-Office365-Filtering-Correlation-Id: 2982eb88-0948-43f2-1f5b-08dde9fcd9eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SG5mR2pJRjQ4bXZuNnR1UW5TbmVUY0svQUc1dDQ0czhvc3BrT0JJNVh6R3kr?=
 =?utf-8?B?VDY5c0wva0dYRmZPeUUrM3pnR2ZDRllRYlVrdnlnVFliL3NZN2VwSzNRMmQx?=
 =?utf-8?B?Yk9oMHVXVk5mQWJmTWU1OHQ2c25CMkRYS1R1RmIvc0N5U09rL3lXdG5UV2lR?=
 =?utf-8?B?eVFkZUVPSzF1YVdEZ3BwdFJKMzJ5WUVuZkUyRWZnT01rMWNlSHFNZGN3dVV3?=
 =?utf-8?B?d3ZmVzFKaFcybk5nMkpuSnFJZzViMm1nb0gzc1NWZlBUVE5aWEhhOXVxZm92?=
 =?utf-8?B?NnJneWcxR1FHUDhDcmZFcTdaU1BJNnlnVFNMenNDd1AwcTJwc3hKd09XZFFs?=
 =?utf-8?B?NGJ6NzE1aG1KUzk0NHV6YTI0NXRzT2h5TDMwSVNrUSsvZEFtaUt1cGtGZURv?=
 =?utf-8?B?amFQaWpxTis5S3FYLzZYVlk4SkhSZEZzcWxqRzc5dXZ3NThmQ0xQUmt0MnJM?=
 =?utf-8?B?MGZyQlZ1SHlXaGNUUzhwUXdDMHNna24xY1o3cEtVT21FaExMRHJBTy9tNzA0?=
 =?utf-8?B?YVFVWmdRMU4ySTh4Y0FuQS9nVlNvWFhkTE00SEdOZzhDY1ZHNjFsaUJ6TGNM?=
 =?utf-8?B?TDNXYU9qTTlBMHhFajI4OXhOcTJDYnIvVUpjK0pXSC8zcVNKL3JZQXBNZTVi?=
 =?utf-8?B?LzdCRzBVcGxTWFBLR0kvRnJ2MXEya204U3NER21LMUFFdVFYTEppRlQ1d203?=
 =?utf-8?B?N3I5NVJPc3pURGRyVTlGTjBHL3FnM2ZYN0xCcm9wdVo4dXRTdS85eDc0Z0JP?=
 =?utf-8?B?U1ZvaDhCZXQvNGp4cExzWTZxQ3dJNGVIRlNjR1hjUVc5dkEvZHdGQjJMa2t5?=
 =?utf-8?B?SDZ5bHg0YXpGMEZ2SUZkS0htR1Z0R0hpUllmRjgrOHdabVJOblNzN0NQQU41?=
 =?utf-8?B?TVRwWW56elJqbFJ2MnQ3RFRVemFTQ3NRUVAyYU9kZjRqMmsrL3pQZHN3YVVy?=
 =?utf-8?B?RDk4OGR1QmFtSVFMaHVKZzVjSlBWaEUxWDFIT1ExK1IxaDVPLzFPSG9Jc3VE?=
 =?utf-8?B?L1c2cWJybTNKcDVIaGN1aFVPRVQxcy9IcUNMRmczTEhYc0JtNlhQVCtPZjlR?=
 =?utf-8?B?Vy9qZkNJcTEvNGVqc3dlQjE2VUpHTDBoejV4NC9tSzlXTUUwS1hHT2VFV1ZQ?=
 =?utf-8?B?dlRnYXd5MXR1NFlIR3I5NW9WV2h6ZHViSzVTd1EzRi9SVFJ1b0ZiRmRTWWhP?=
 =?utf-8?B?NUtMcTZNdGd3OS8yaHJTM3B5Nm1iQjY1TVIvbFVmUTgxanhHVi9MTWE0aGMw?=
 =?utf-8?B?a3NGcnRFak5idmsxcWJ3MzU5L09USzRHQXdEekpqRVRHc1NmNG9nYzRLOFlY?=
 =?utf-8?B?eW9xOFJsaDdnd0lxcC9ZWDZuTVQ5NzI3VVd4Y2tpaUkxcWJoUDVObHpiSy8w?=
 =?utf-8?B?dDdsOHBZSU5VYnhMRGpJcWFUZkpOYmRnMGJNS3ZrZi9ZSDZJQ2hLanBqZ0Jw?=
 =?utf-8?B?VU1oRzF0clFOMjFRcHRlaDJ2SU1icUZuWUpMeElzUWNneTRtZVlJMjNXVGdU?=
 =?utf-8?B?RlA5TjE4eHY0TGVYVEFMUFBXa1BoM3hCeS9SUHlKaFV5elRqQ0QxaEZSaUZZ?=
 =?utf-8?B?VW5oUXlDUkJlNzl4TTRwZmUyOU9PYkptQ0RkcnhkVzhCaEgrUjVJWmJVTXY5?=
 =?utf-8?B?NFd2WUhiNGVwcjZOOW1MTnBkdU9FQnQ5OHNOTnkwSmJaVEJCU0MzSmdBVnYz?=
 =?utf-8?B?Y3ZjcDg5bCtJN1NHNVRMN2NLaVNPVXgxNmNkNzEzYVFwUVNBZmxZb2FEUHQz?=
 =?utf-8?B?RHFjcGZuM3R6NEZqT0paa1lYZWlzb1Q3bXJsL0p3RE5MVlUxbHJ6UE9Edkcv?=
 =?utf-8?B?S1VOdGt0SDRNRWE5R2thSkJNcUtwSDMwVmhTTUYvQXBuNGxrTUtBTzg0eVg3?=
 =?utf-8?B?M05nTFBoNGdrQng5OEY3dTU4WE5qSnlJbEpHZFR6UlNQelNwVzU4VXN2U0Jy?=
 =?utf-8?Q?igvq16TRltg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5530.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUxWQnoyd000cm1YdVp6MmorZTBDMEplNitsbGZHTCtndXFHWlM3amIxRE1u?=
 =?utf-8?B?em1OVkNLeGFkQ1I4aHBHYUlXSU5ldE9kQW1kS3BFMlJ3ZS9LYjZucWJRcTFV?=
 =?utf-8?B?aWRsUGRSZmZSenVEd3QzanZkdFdiWmZ0dHFIb1hhWHZXTGVvZyt4d1A2a2hC?=
 =?utf-8?B?UjByRWFlTnJyYnYzVkN6UUh3bmQ0U1AvY0wvLzIyT29MYTdWS0pwZ3VFMWtE?=
 =?utf-8?B?KzIrekZSb09pYlJHVDdkeUJxODExRCt1bTBNbFZjM0F5WllPVzhQRWpLbTlW?=
 =?utf-8?B?T3phaExtdUl3YzlXYWVIOWdMZFE0dC9ncko5VmpSTHhPbkhScmcyTENldnMv?=
 =?utf-8?B?UjNWTE54UnlIcUlxRHFCS01Td2JkaDJBK052N1lZQWJDSXZLUXZFUndiWGFC?=
 =?utf-8?B?Y0VuR3g3ZzJBQUxMQ3NHaTZLZ2FkRnFCeVpRY0hXTlYzOXFSa3hvWlhwdnNw?=
 =?utf-8?B?YXhjK3RNQ2F1MUhiMmFZNWF2VTFOeWRLOGNRY0hJR3NlQkNKRCtVQUgxRDdr?=
 =?utf-8?B?czNCdVF2dHZ1WXVjblFYTVBJRFQ3WGZGMVU3RmpHNkJTT1ZpSTJBbzFQai9E?=
 =?utf-8?B?SUNadnNqampIVmtHV3F4Z3ZiUTh0c3djcEdoRTcxYkQzWVZrRDk5RmFRd2ZN?=
 =?utf-8?B?Q2cxV1oyWVpDdVUwM2xwT3JrclUxR2gwZ0xaakJKOC80N2VEb044SlBFNHZo?=
 =?utf-8?B?T3F0bytudzlDbWUrQlAzZk55b1Z0Q2NHSktoeFFONmZ5NFFnb1ZzeFdlamhI?=
 =?utf-8?B?RzlaV1FGT0gzcWFUL1I1Q29sdGErRCtmZkVFRm10QXNBc0JhbGVGTC9DMVRk?=
 =?utf-8?B?ajRsUFFOV3dyMHloaC9saDkybkpKcmlPSlZNUnFtY3ErRXJpN3phV3NPVHJV?=
 =?utf-8?B?bGdxS3FiS1h5d0JLR0lCNUk2VUhoYTRwNXNaWE9DdDZEUUhEYjNVcjFEZk5x?=
 =?utf-8?B?YUI3d1d4RmswekZvS1kzTmpJaldKeHFZZjhMcE1KdTM5UTNyazRBTVhPNEI3?=
 =?utf-8?B?RzJhTTJRSEhsOFBVZDYxb1RDVVNCSmt3TVFscHRyenk1R09HVUNCWVh1THli?=
 =?utf-8?B?Z0lyNnlzakdPeTFtc2J4L2NkRzZCb2M4RGplRjNGK29QM0tyZkZxN2pEb05T?=
 =?utf-8?B?dEoyMXF2RUNkakxmdGRKNjlaZWovS2k0Vkk2SFBCMWtnZTJ4a2pwQys4c1lG?=
 =?utf-8?B?YzZlSlVEZmdtU1NWZG11N1dBWlpsV25VRzBiRGFLbTMzR2xrZ2hoSjdtSE5m?=
 =?utf-8?B?TVh6T2lVZytaTlZvaTY4WEtmejFqU3R1WVEreU81OURGTGNaNG9nRzFXN0Zj?=
 =?utf-8?B?WnVKK1Jla1J1em53dkxFMWowc1VaeGp0N1NhVUJBU3BOUkVpTFdNRk9uOUJN?=
 =?utf-8?B?TzczWHcyaWlqa0JEZnBtQ2huZzJtV200UnRzbzk2T0RZZVBqZEdjNVN4cmJB?=
 =?utf-8?B?NklUVjB2cEhSczhmY2FhZVVGTVRXZ2VPVHpiT0RGeVNadktmWWxjckZaSUZj?=
 =?utf-8?B?bDUzKzlWWGlEVTJBZm1zZ0ZoUmVRVnJIMWtUbk9uZHczSXNZUzhJQjEwQWJZ?=
 =?utf-8?B?amdza3E3MDNyOWk5bEM2WUlabUlPYUFoQXdYaVhsQzVOV09oWWI1R0pVK0VE?=
 =?utf-8?B?UkZiR2w0dWJTaDdZaTdWMEJKK1BodHJrK0VxR0VSWkQ4bEJ2STcrL1NZdFhX?=
 =?utf-8?B?TlBHQVdPbkQ4YnI3b293amNndFVnamwzblZ1Mk51YXhXOWgzTGE2c2p2cllt?=
 =?utf-8?B?MFdzOTNQQTB4ZE9GaURqUzdHNHJ5a3JqOFVKSmxTSlVLb0xzcVluWXhMRFly?=
 =?utf-8?B?U0wyK0xNVDhNL1V1N0NUMDFtcjMvNXI4YlI5TXJjZ1pzRGxVOGxydVR5WVFH?=
 =?utf-8?B?cWdXOU5NZzMrU3BqZ0ZFejg5WlcvUkFoZjhhemxXS2JHQUM5UitZcXVNRHZy?=
 =?utf-8?B?dW01OXhoamFDZklqQVJIaUV0OTNjbDZUcXNpTHVMenQvYWFZRjNuNSs3Qkx5?=
 =?utf-8?B?Slc5RnFEelU4KytGQWI2czR5NFY1OFJGYlhsQXYrSDZ1MEE4eXVFR3A1TE9q?=
 =?utf-8?B?eFdibkZpWitUbE5FS2pYTitMRFVRTkhBaUdrSjY3a3JsMXE2NEh4bTdZMkMw?=
 =?utf-8?B?RDYrMjdObkx0RHBvbzMwbHB2SldJVC9HSGU3aEZ6ek5oQW5qT1ZDdDFHQ25S?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2982eb88-0948-43f2-1f5b-08dde9fcd9eb
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5530.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:43:55.6518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tabJf/7p5Fcz64BbHmCaHYa5G1uO5ElB3Fw8HPyBfVT2XAlf0aUUrHuPIJRYrjRGKt1Ztob9v8AnxHZJ7nYZuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4771
X-OriginatorOrg: intel.com


On 02-07-2025 16:51, Rafael J. Wysocki wrote:
> On Thu, May 29, 2025 at 1:14 PM Badal Nilawar <badal.nilawar@intel.com> wrote:
>> For given root port allow one Aux power limit request.
>>
>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Cc: Anshuman Gupta <anshuman.gupta@intel.com>
>> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
>> ---
>>   drivers/acpi/scan.c     |  1 +
>>   drivers/pci/pci-acpi.c  | 25 ++++++++++++++++++++++++-
>>   include/acpi/acpi_bus.h |  2 ++
>>   3 files changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index fb1fe9f3b1a3..9ae7be9db01a 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -745,6 +745,7 @@ int acpi_device_add(struct acpi_device *device)
>>          INIT_LIST_HEAD(&device->physical_node_list);
>>          INIT_LIST_HEAD(&device->del_list);
>>          mutex_init(&device->physical_node_lock);
>> +       mutex_init(&device->power.aux_pwr_lock);
>>
>>          mutex_lock(&acpi_device_lock);
>>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index 87f30910a5f1..d33efba4ca94 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -1451,6 +1451,7 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>>          union acpi_object *out_obj;
>>          acpi_handle handle;
>>          int result, ret = -EINVAL;
>> +       struct acpi_device *adev;
>>
>>          if (!dev || !retry_interval)
>>                  return -EINVAL;
>> @@ -1464,11 +1465,27 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>>                  return -ENODEV;
>>          }
>>
>> +       adev = ACPI_COMPANION(&dev->dev);
>> +       if (!adev)
>> +               return -EINVAL;
>> +
>> +       mutex_lock(&adev->power.aux_pwr_lock);
> Use a mutex locking guard for this new lock, please.
Sure.
>
>> +
>> +       /* Check if aux power already granted */
>> +       if (adev->power.aux_power_limit) {
>> +               pci_info(dev, "D3cold Aux Power request already granted: %u mW\n",
>> +                        adev->power.aux_power_limit);
>> +               mutex_unlock(&adev->power.aux_pwr_lock);
>> +               return -EPERM;
> Maybe -EALREADY?

 From definition it is for operation in progress. Not sure if it 
appropriate for "allow once" scenario.

#define EALREADY        114     /* Operation already in progress */

Thanks,
Badal

>
>> +       }
>> +
>>          out_obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 4,
>>                                            DSM_PCI_D3COLD_AUX_POWER_LIMIT,
>>                                            &in_obj, ACPI_TYPE_INTEGER);
>> -       if (!out_obj)
>> +       if (!out_obj) {
>> +               mutex_unlock(&adev->power.aux_pwr_lock);
>>                  return -EINVAL;
>> +       }
>>
>>          result = out_obj->integer.value;
>>          if (retry_interval)
>> @@ -1478,14 +1495,17 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>>          case 0x0:
>>                  pci_dbg(dev, "D3cold Aux Power %u mW request denied\n",
>>                          requested_power);
>> +               adev->power.aux_power_limit = 0;
>>                  break;
>>          case 0x1:
>>                  pci_info(dev, "D3cold Aux Power request granted: %u mW\n",
>>                           requested_power);
>> +               adev->power.aux_power_limit = requested_power;
>>                  ret = 0;
>>                  break;
>>          case 0x2:
>>                  pci_info(dev, "D3cold Aux Power: Main power won't be removed\n");
>> +               adev->power.aux_power_limit = 0;
>>                  ret = -EBUSY;
>>                  break;
>>          default:
>> @@ -1500,9 +1520,12 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>>                          pci_err(dev, "D3cold Aux Power: Reserved or unsupported response: 0x%x\n",
>>                                  result);
>>                  }
>> +               adev->power.aux_power_limit = 0;
>>                  break;
>>          }
>>
>> +       mutex_unlock(&adev->power.aux_pwr_lock);
>> +
>>          ACPI_FREE(out_obj);
>>          return ret;
>>   }
>> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
>> index aad1a95e6863..c4ce3d84be00 100644
>> --- a/include/acpi/acpi_bus.h
>> +++ b/include/acpi/acpi_bus.h
>> @@ -294,6 +294,8 @@ struct acpi_device_power {
>>          struct acpi_device_power_flags flags;
>>          struct acpi_device_power_state states[ACPI_D_STATE_COUNT];      /* Power states (D0-D3Cold) */
>>          u8 state_for_enumeration; /* Deepest power state for enumeration */
>> +       u32 aux_power_limit;            /* aux power limit granted by bios */
>> +       struct mutex aux_pwr_lock;      /* prevent concurrent aux power limit requests */
>>   };
>>
>>   struct acpi_dep_data {
>> --
>> 2.34.1
>>

