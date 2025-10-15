Return-Path: <linux-pci+bounces-38181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78360BDD991
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 11:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 589F34F9771
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 09:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27801307AEC;
	Wed, 15 Oct 2025 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jcbHQP4T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7929730B525;
	Wed, 15 Oct 2025 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760519092; cv=fail; b=GfFptTOo5ZCg5FPqOWgz9KRikHXcu1RuZnBN3WxTM5iq36WQvoD3l49nw7v9hzFtBPJB5MFODrrID8uKDzTk0jVvvpslAXDJqmoDxnMSXc4P0P0s7i9lHOcRath9bW9MBkOnGhsVfLisVIIz7uBbW6Nk7MT66nAt2Iz+5mMO3kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760519092; c=relaxed/simple;
	bh=jiMQevLVPkUMb4Mo2s70Z4At8W7NkCYLE9qh4LXxrAw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AXGkmsWwzZDliU8AdDsTa0obHgIM3LtHpCecBLtwyL3M/hAVlQuXizJkiahFzB/z13jCPpBg6MppijcBqw6tboign8IVb9NxuU2muHko5JbBQkkUrUA7zHWC1gmy2HRz6o2akq/DbaQfdBO1vUuj4hG+v5stupFRtafIhu4UxvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jcbHQP4T; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760519091; x=1792055091;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jiMQevLVPkUMb4Mo2s70Z4At8W7NkCYLE9qh4LXxrAw=;
  b=jcbHQP4T9GILIN7KAG9YifF1sSWgupPNCa0a4Z3oUt0ssEokHgqB0dHD
   +fBWbJCPqICUKG9sO+f2w7Oz6ufel8weG4nW1CGsSOudESRmeiLQacTgA
   95X8Sq5vEQErZNtzHk24sklU6umR+XaaJAxsjI9/3mhP1IAd82DIaANq1
   AkUvz3vs20BRzpt++td4515fN64k+o8dlSwwWSyA92ZOol9HJTZ+04s0Y
   HMT641NrB6sYkfI4/rwh+Tex37AlneQEcu15ZU1bcSnrR37FSilNh3LS4
   4dEaRK3xJhnnl1xAku3ADD85ru8xKcFecLRJG56D8jv9Z285q8r1RYh+m
   A==;
X-CSE-ConnectionGUID: 73OC82M5SBO6ZW5w89BAhQ==
X-CSE-MsgGUID: 9MdG8agbQiGbnHF6An5Pkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="61896178"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="61896178"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 02:04:50 -0700
X-CSE-ConnectionGUID: nCWjl1PJRjaGaHUs3gcwAg==
X-CSE-MsgGUID: 5MFYoC1HSAuay5Se+R+6PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="181681009"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 02:04:50 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 02:04:49 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 02:04:49 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.28) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 02:04:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lu3UFJRh8p7dKbrzUVuPfWJxMvTAlM0/Ur4aysXC+m5kk7UwHTIYtlbYzhd49lO9UplMTQnQwoOswrgXKY2lm2VzQOjQE3XqMSs02/BZbOXjTl2jnSjWMbBdAm25QELv0OyWcrVsc7JiHJo834dG985Tgfmf1jAJLGzI4Ef3nUEu2VqD/UHYVIMLRGHqQWO+joAqGrAfNjwbqz89uMv1bI6w0b2nWxM8ZfcqCt6DX3/scbJJl8in9MXlx4XUCmBwYKWylRcBlSNqlLjFpAmYTAkzgzdzeQB7heKYbmFvbIrfv65kUI+MWpwK67aTXAmgt9MRsoIosvcGMyqB76fk4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsAKLEAeA1srYh8eCFaAFB+QwOo0SjIwGwZ1eo/jXRg=;
 b=JkH6FvYCwxoRX9f823JMDmvIqBkViuOOu2foy9y9t98d3TMNwEkSqowMMDGs3MuJMe/jSfbsF6t2dqcraJ8OzSV104Dq64JxvNjmheqmwMLPTHUYPeTR1ytiBHDNYfpbUmUykDSy2rHzoOoKrQ90k176WAkgjpp6dinxvZuHfTr/ip8O4HGBtntMjxbXVTID14EVVgL7GRPi9xKmeoT0qZyBRQ4E2qjPAyaV9+haoO+wPJKu+kiVNuDoMvVLUp75lLflULvSX9Lv0PQIKBaCJp4lTyKzIANKFXwMGXaHwLxTBncZMlRW6oovxmI7tV9YfGZibiKMkwjNJBUX5qfRAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5530.namprd11.prod.outlook.com (2603:10b6:408:103::8)
 by MW3PR11MB4572.namprd11.prod.outlook.com (2603:10b6:303:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 09:04:46 +0000
Received: from BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9]) by BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9%4]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 09:04:46 +0000
Message-ID: <18f84e75-ea8b-4a6e-b1b6-1d07dcd4f778@intel.com>
Date: Wed, 15 Oct 2025 14:34:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/12] drm/xe/vrsr: Refactor d3cold.allowed to a enum
To: Raag Jadav <raag.jadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <anshuman.gupta@intel.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<lucas.demarchi@intel.com>, <rodrigo.vivi@intel.com>,
	<varun.gupta@intel.com>, <ville.syrjala@linux.intel.com>,
	<uma.shankar@intel.com>, <karthik.poosa@intel.com>
References: <20251015080710.1468409-1-badal.nilawar@intel.com>
 <20251015080710.1468409-9-badal.nilawar@intel.com>
 <aO9dsvZ-SmGlEh4T@black.igk.intel.com>
Content-Language: en-US
From: "Nilawar, Badal" <badal.nilawar@intel.com>
In-Reply-To: <aO9dsvZ-SmGlEh4T@black.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0082.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::12) To BN9PR11MB5530.namprd11.prod.outlook.com
 (2603:10b6:408:103::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5530:EE_|MW3PR11MB4572:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a06a7a0-d100-48ea-079b-08de0bc9e30b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjF1WldCb0N0NSs3L0FxWWtjOEhRbENwbFlYejBBRVpHbUdNZ2RjUnA0bi9B?=
 =?utf-8?B?QjdGbys0OGNQUFZwd2tnQ2o5YmRTWWF1aVl6VXE5SFp4d1dnTzZNMnR6WjNk?=
 =?utf-8?B?SDd2VUdIVUsvOWJ3MjFmZFFBcUM0MGxVeDBiQ0o4YU5iSVluS25Rd0NUdmtK?=
 =?utf-8?B?R3pla0V3N2RKaVhXWFJxaC8wUmxFK0dJNmxUWFJTWFp4Nm5QWnBqUlJYWkVZ?=
 =?utf-8?B?WmpscGpSTnozbEpGemdIMERNSUZFMWlUYWVBUkNuREk0N21MV1paZ3N5aFp6?=
 =?utf-8?B?L2JwYk5nVUhYaittUlVsUzQ0Z0YvTVJHc1A0MVAybERrbTg2OVVMRGpSTGx2?=
 =?utf-8?B?UHBSVkFYanE1NHZLNVUvSVQrSFVVU1BXa3JIWExNbmlKZ2ZoSi9DYUNwL2F1?=
 =?utf-8?B?amdibjh1S3BmWndBWlhaRlJLbUJhbDlsSnAwTlBZVDZFM2VMbmc0R2pqNSs0?=
 =?utf-8?B?aEFoMm1nTGl4WC9wNDBrUG9LZ1h0d214SHpua1FEdnVEZkZtdW1iM0hlbENt?=
 =?utf-8?B?OHV1UVhib0VuZjN0dkUrOFYvQTNSZFhCSHljbjNvOVR0ZmpwQkVobktDZDhm?=
 =?utf-8?B?WnVHeFRiZXF2TFo1cFFsSVkvdWllOUtqK3BHQ2Z1cnVSZkFqNUNsR1hWRmpj?=
 =?utf-8?B?eFFBajBtSW44dlVtYWxWazhLa2pJMTNHY3dON3A2SytkSjJoOUI0aGw4RVpj?=
 =?utf-8?B?NHN5Y05OQVV1R0lhR1hWSDZYSnl2c0kvOGw3UHpmZjZLTTZIYjdRWkdaWTls?=
 =?utf-8?B?MWk2Tno4YXhuVmZEY2Zpb1FrRnBSYk1WQUVlL290RXREQTJsSTU0U1UwYVdt?=
 =?utf-8?B?Q0tFQ04zZE9lb0tsNXZHc0g4ekF1bVBJNmEwMWhqOFRTWU5VUUNnWGJTaDlM?=
 =?utf-8?B?SCtTcDNWRHFZM3hobjIxbGhsUFgwcWgxbE9wNGhnYjBIOEE1SVNiU1JiODVx?=
 =?utf-8?B?TlhCdUxnVG9ta0pDTXZIVXhyRkMxVDJvWVRLejVLWXBDOFBjaDh4Uy96TGtT?=
 =?utf-8?B?eVRiVEZWU1VuQVI0b3hzeEVHSjFGelBQQVZzV051eFJ2UVYwSUszaXVRTGZE?=
 =?utf-8?B?L3R2WU4wcUNaUXA5dkhUNzB1NXF2YzFWZmZaVlkwOUxJemZOS2c4MDRUdzZV?=
 =?utf-8?B?cTQzS0hGMDBQcXJCT1dBY0pIS25WajJxcEg3eVVvaHVHdllWbWRDSkpQK1Vk?=
 =?utf-8?B?Wk9sQ21iemxBLy9CdXBqRGVZN3EvQXUwbDh4TUJwUHhYbHlYb0JGQUlRL1dL?=
 =?utf-8?B?cFlyeVF5SGR4T24waE0wYUVSa3VtTEtiSWRpT0dKV09VdVdtS3ZYby9ndmps?=
 =?utf-8?B?SE1STVR6VEpMKzZ6R0IxS2I1Y2ZCVWJaY1hKYktXYTlKWmQvRWVBcUtKTk8v?=
 =?utf-8?B?eTNoNEoxRUM5bFlJZGh4MXRSMCtmandhNnZxSVZjMFY4ZFJxUngzVGxJclVs?=
 =?utf-8?B?a1RiNWF2SmVaTjY1L1U2aW9wWXBMbHNRR01XQ0FLclVBMG9CdFlVTE8wbnh4?=
 =?utf-8?B?ZXBzc3JVR2tYUEhLNml3UExUTnNIdjhqUWI4V0JaeGlVSGJ1U0pZaS83elRB?=
 =?utf-8?B?TXgxZ0hpaW50a2cvOS9FLzNLNWo2MFRTRlpodlNaMytoOUY4cjEydzdPY2Na?=
 =?utf-8?B?QTlzem9rWmJWWWxiL0IrOHJCU0xEaitiZC9GaFpwaUMvbkZPWnk3anIvejdv?=
 =?utf-8?B?WUppVGJrNldTV0Mva0h2MjVZVkFYc3VNbjRHeEF4VmNKc0orT1dmamtXWkdm?=
 =?utf-8?B?MVJXbUg3Vjg3TE1hWTVWM0pWcDBHL0ZZOEhrUVZpaWFYTElKT1pwaERveFFY?=
 =?utf-8?B?OERHZEkzeElyc1NFOUhJanFMTmtldHVIVW9MTXJlUDhlV3p0Qks3Z2NZd3RW?=
 =?utf-8?B?bEVsMFNSMitUenlEN1R0Z2NiN01hcWZYQzJnZUp6VHhIZTBCQVhhMU5CenJG?=
 =?utf-8?Q?4QWP7LhgWph110w38nTsPFkKk+ndk40F?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5530.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDdvKzhzdVhBTERYUExpTXgxcTQ3U0E5aGpwWThnM2F4SWhwVmFaeUl6M2Np?=
 =?utf-8?B?aUY5L1dqdmMxWW5aTTFBdGJWMVVNbjFjLzFDdTVWZGtvOGhFWGJVM25oaGpV?=
 =?utf-8?B?dTBWLzJWbk5lVFNjWm52WmtpZURtN0lKUjFHZXR1RjJvTFRzb2pSRHp0ZU1w?=
 =?utf-8?B?WDVpZmJ0YlZRRTM2VVJJZEdZZkwwUGR5Wm13dkh3SzF4ODFYZHJ5VHd4Wmo2?=
 =?utf-8?B?MWJLRVZCbmpoaHVha3o3eHd2K0owL1hQSFAzRzVxMUw4N2pCUDNMdVBCMW1L?=
 =?utf-8?B?dWp3cUhrN2E5czQrZ3NlanZqL0F3alR1bU05RG12b2JQUkp4Z09EWDVueHo3?=
 =?utf-8?B?bWhuM0VGTWdIWVZSM0o3N2RleWdSdjNjQlNRR29EeHkrTFJmaDJ1ODV2cFEz?=
 =?utf-8?B?Y2JjWEtOZi9uZjEzdXVXNm9KaWpqcEhoMFQ2SzVYc3VFUXJEcmRsdUIzNDdh?=
 =?utf-8?B?SkwvdUpQTHhDd0NOVGFqT2xqN3MybDRHVlIwRnhuV0tUbEtvaks5QmlpejBy?=
 =?utf-8?B?d2xpZkRFSTRRYTdBVXNhRGUrOVFJRWl0SnkrNjdreW1GU25vLzlhaE9FN0Jx?=
 =?utf-8?B?R21CRWo2ckswUlVzL016R21ZdW0rQWdtWFI0UVU1TXNZa0gxQWluMUVjTXpp?=
 =?utf-8?B?dk4vVHZwT3VPemFzVnE0VVVIQlZOekVKK3pNUmp2S044VXNDdThxcExDa2FM?=
 =?utf-8?B?UFpmWWkzOGtBdGxZSWJXdCtUQm5OWjBZVFZTVVp3RTFNQUFreTFiK2dGNVFR?=
 =?utf-8?B?cFQzZE5hbERYaFhBMWJ1cG5Kb2VXVEt2NzNnTHJLMnB1a3ZHdW1xbTRKVVlB?=
 =?utf-8?B?U0JDYTdZcmE3cThzY1JQTmtKLy9PTjZiMmViYUNHdEZSTVdmL044ZEl1OWtF?=
 =?utf-8?B?a3FjalVVUkpDdEtnQnkxRnQzQ3kra3RrQk5UakVJQ1gwUGNzVjU5VkJlMEdN?=
 =?utf-8?B?OHFRb0Q3Tk1YY1lnVHY5RTAvWTRiOC8yRzc3eUxaVm42d1JkeTdUTjk0U1VI?=
 =?utf-8?B?OWszR1pxbnhuZ1RXd05YV0NXZWlSYU9YS0lxYTVSZm5URDBWYW0ydVVyRENn?=
 =?utf-8?B?SDVMTUw5aGxOUGRtTElMQ1IrbHI1KzBZbTBNUEJwYTB4YzRJYVBVVlNQQVFN?=
 =?utf-8?B?ZkIvZHloaFM3NEIzNU51THBEMkdlMGdYejA1S3ZqVTgvQU5uNlRPSDFoMk5m?=
 =?utf-8?B?SURmNWlJZkxESHdoelFCWm5vL0RTOTVPZGhSSTNJQmZpZVpHZkpSWWRxUk5K?=
 =?utf-8?B?WTB3dEdIQVZjVUtXeG10RmV0WWxCRVJUWnc1TWd6TUxKbkhxZUUzVnN3KzFs?=
 =?utf-8?B?R0NMeHF5dmNzc3Q3TGtxcWMxK0Z6ODNDemJoNGxkM3JUb0c4TGYyR3M2YmMr?=
 =?utf-8?B?TmRvRlVKSlBucHQxTDcxRkJuODFSWDEyVTNPb3BYMUF1ZUx4QkhKQjI1TjVF?=
 =?utf-8?B?N050VVJMMzV3RXFBcDkyb0hxcnZPMW4yWWt3VXJHTGxvbUZxU3I1TjZYakJi?=
 =?utf-8?B?M1UyOVkyM0Y4MnpGSDd6ajROZm1nd2RkaTN1c0tISUJSNzlFUllXWTE0ZG5x?=
 =?utf-8?B?cklDVDV4amNEUU1TOWdJSjF1dHp3a3FWT09nd0FtN3hUQWIwZHVrZ3pzWWpK?=
 =?utf-8?B?N2NVWVhBeGxkNzI2MW8wYlhJeFAwVXFCZGJWMUo4YXY5a3pvU2hzU3ZyL0Vp?=
 =?utf-8?B?T1c1VytNR21vbmpDcTVVWlFzYmZUN21hallrem1iWkZZbEdzN0tWSXFLN2F4?=
 =?utf-8?B?RE8wYUc2VTZ6UzA2bW5wRU1mTTNvWUwxeDlOdEdEdEZUU0RLWjFHQUhTU1JC?=
 =?utf-8?B?aDhFZTM1S0dScEVGWnhnOFVkY3VrdzVKOTNSTU1jK3FHYWwrbExKM1ZFMy9V?=
 =?utf-8?B?cmpzbkJQcXNWOWtHRWQ3a0tCU1cydlBrRmUvNFMyOFVzbW1ES0F2QTNPWEtw?=
 =?utf-8?B?aUhWOUlVNFNSbllobTd1Q3N4S1BaNEc5RU41ZTNpS3lUcFhJeVhGODdkOGha?=
 =?utf-8?B?V29TVVEwdEFCVnA3Nkg0ZEZRZFVuSytsZDB6Q0l5cDQ4cE42aU4yQnhESlh2?=
 =?utf-8?B?R0ljdFU0aVFPbG5teUt4QUFlY1M1K0ZMSjV1OGw2cTNtcnRuNWQvUzBWTTN6?=
 =?utf-8?Q?Pa8lsRSd4jBPGQm1t1GB/nNEs?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a06a7a0-d100-48ea-079b-08de0bc9e30b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5530.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 09:04:46.3871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VShNBz0BDS+lG3Hk/3l+9M9emKy+Mw5M+gMWTUIqIl962STobX4+u7G8FjY9Sh/Rj1qFcb8KhhPtJUm1LDusdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4572
X-OriginatorOrg: intel.com


On 15-10-2025 14:09, Raag Jadav wrote:
> On Wed, Oct 15, 2025 at 01:37:06PM +0530, Badal Nilawar wrote:
>> From: Anshuman Gupta <anshuman.gupta@intel.com>
>>
>> Add xe_d3_state enum to add support for VRAM Self Refresh
>> d3cold state.
>>
>> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
>> Reviewed-by: Karthik Poosa <karthik.poosa@intel.com>
> ...
>
>> @@ -787,7 +787,8 @@ int xe_pm_runtime_resume(struct xe_device *xe)
>>   			goto out;
>>   	}
>>   
>> -	xe_i2c_pm_resume(xe, xe->d3cold.allowed);
>> +	if (xe->d3cold.target_state != XE_D3HOT)
>> +		xe_i2c_pm_resume(xe, true);
> Does this require an if condition?

Added it to handle D3cold and D3cold-VRSR target state. Am I missing 
something?

Thanks,
Badal

>
> Raag

