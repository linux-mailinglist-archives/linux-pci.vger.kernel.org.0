Return-Path: <linux-pci+bounces-37243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E77ABABA33
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 08:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC813BF568
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 06:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769BC25FA34;
	Tue, 30 Sep 2025 06:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZeKnPmI+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413C7211290;
	Tue, 30 Sep 2025 06:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759212704; cv=fail; b=dYUNITC6VczCNEHMky1vxKjOgfLutlB69N0IMMnU/Yl4r8FLEZ7KTH0mAXe095bO9mXxHgQpJJoPgyC519fivJckiCoDIl+rleWoS167Y4ZhjcAeborzuDTeNM51jD5PgBRXBeKe64Irw40yHX9q1M3TA7gIVrv0gGzrX3Zhv3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759212704; c=relaxed/simple;
	bh=vjEmujGouTtzjdRWtWZC2KQZm2cqFKqI36ns5O4H98o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GbjrlbSDVZwiaOOtIHCA5+ws+pVA+1xvQKH3Oz9LuHHBIG4paIVbTWsjKuY4RrwFqyfw/KG5uyUD7NVaXD/Yr3zJRnPoZCRDF1Z+9+LofguXn7bZGBUTp5F8urmCmkmw1qGEV21dL31TxlRj83TkVUkSWHb/QC8oLD04xO63Dns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZeKnPmI+; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759212702; x=1790748702;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vjEmujGouTtzjdRWtWZC2KQZm2cqFKqI36ns5O4H98o=;
  b=ZeKnPmI+ISucfm9gq2i6H7CbRZ14lAV1toiXt7GkfQPzoeTRycu3+hxT
   /EZf3hxXXsItLzKChKyHgHsW6BirunnWQCGGLDvQf5Ij4whK0qxZ/srv/
   ZshUmxB0OwOOY+PkQ6HJOd5BgdZ1Yxy0Nijw0rqmiA9KvPz2morVH7PDz
   poX1EYyLNGQkpB9tz7W1cnk6/ZEcyJo1SvDGQqlW+i+E1Ieqwp7Cekv+O
   FgYrmxXl0L3lkarybJx81PxEabZSFMVeuvurOffyjmQvjmKLy4eEyy1iP
   F4iOGHNQKmnvA3K43oRSRYeo2T8Lgw8rMAmpA1L7f5m+HZDzw8KKvQRyv
   Q==;
X-CSE-ConnectionGUID: 9gb0v0G6QJaJrRN4y52spg==
X-CSE-MsgGUID: whcMnfvtQ6ShKnugdb+FXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="49022593"
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="49022593"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 23:11:41 -0700
X-CSE-ConnectionGUID: V4XAiSHkSPywe9c7BHyHWw==
X-CSE-MsgGUID: KSWQYjMiT/KHSUtr4WJ7oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="183617831"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 23:11:40 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 23:11:40 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 23:11:40 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.39) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 23:11:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIRVTEk+5zmGRhzJrpYdD5fM6kuwW3wU12JkfmeBCYJiPuw9tFjQqCVtpS+JVcic7DdDf44Cb/4yWjRmN1IhFhwgaSw36cUb3moz8yCMFyvm70kMCWpF9vw945bohZixxaCD/vOH2BZjx6v5kzT1Tknrv3+gnr/V9p9g56cn2waLOmo7KuFabn3qhLRDDWpC6+8pru/KqQWYxXFJ4smJwufByWCBTSAkFmfHPJGyWYmr1xLvh4FH4CW+NWWUeSiMEl3/f+fsMdE1YCrYIsgefYT6vxCmH/pfxzlowsi1Og1ftrlOoIS5ltb6Y66ThDqAes6vcUR3S1X3G3a62+V3uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdZ7zEZYqRLwdHCOzjat6xzb6jIl2qwQ6MZoyEuKRmM=;
 b=hd8477jYoK8RghGp1ASCfucIJmklG/dUK59/05H2JvLN1PSBW01nxsKg3vGKHUfFbmbZ0065LBZQYgLeO/PYj+n8xGA2pPcaz7Ef35twrGMUIiTHKrsHUu/QGA7y7jscuJwXkRkB2m+I1mWyCypE0wlicBHWFQ23ylinkVJ3yKtw28nvDR3pwatabBJIHbvEb60Llya6yPKUarmIy42p5XFCA6ZjqZbcWxyl5yfNOrHof+ss9VSCYr+XGDAeMD9xc4J8MZIQogP6p7rfG08dTLFF3bjSdXJlyIsipygGnRDL3DqbOHm/xQfhSO403HKecCuOS1J3c5Kqo9AGNBRYGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5530.namprd11.prod.outlook.com (2603:10b6:408:103::8)
 by DM3PPFE50071912.namprd11.prod.outlook.com (2603:10b6:f:fc00::f57) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Tue, 30 Sep
 2025 06:11:35 +0000
Received: from BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9]) by BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::13bd:eb49:2046:32a9%4]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 06:11:35 +0000
Message-ID: <c29496e7-a2a2-40bf-a39f-0a8b2608f939@intel.com>
Date: Tue, 30 Sep 2025 11:41:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/11] PCI/ACPI: Add D3cold Aux Power Limit_DSM method
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <anshuman.gupta@intel.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<lucas.demarchi@intel.com>, <rodrigo.vivi@intel.com>,
	<varun.gupta@intel.com>, <ville.syrjala@linux.intel.com>,
	<uma.shankar@intel.com>
References: <20250904183046.GA1267851@bhelgaas>
Content-Language: en-US
From: "Nilawar, Badal" <badal.nilawar@intel.com>
In-Reply-To: <20250904183046.GA1267851@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::17) To BN9PR11MB5530.namprd11.prod.outlook.com
 (2603:10b6:408:103::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5530:EE_|DM3PPFE50071912:EE_
X-MS-Office365-Filtering-Correlation-Id: a99d00bc-0aef-4376-0bb3-08ddffe835a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzhodE9tWWQ5SE1LKy85ZzFMTlNiblJLMUdaZlVZWEswQnJMYmFkTDFkWkZn?=
 =?utf-8?B?R20yUjUvWUMwd1RHV1hyUHRYbUdlblVocE9rV0lCUFVhMkxyVVRoWk41cjRR?=
 =?utf-8?B?TkhlL3U1cEJKV3FzYUVqS2UvbXZyY2VLZWNOOVNQMGhMVUUrVHcyNmlqdG1j?=
 =?utf-8?B?VTFtMlNUZDkyanFob3lvMVNTOTBzVDJtWGN3TVRjZGdsblJTSThjUDB0RG5S?=
 =?utf-8?B?eTZPM1VaYjFCMnZJVGtIMFlUSW5wNEJSak1MWjVCM0NQMkxwVHVzMWRJRytq?=
 =?utf-8?B?Z2EwL3pCdVJ2ckxFanVrUnhZb3g2M2RFMFZDai9GWFRQRTJYZUFWdGkzd1o2?=
 =?utf-8?B?clFFMGNwRU55bitvSStSQjZsL2NDa3JrTjUzNmVRSzBDeUp5a0ppYXlQdWhX?=
 =?utf-8?B?SDhOQjcvTGJCV2Qzb1dQeTFBSnNicXdFbGp6Q0twbFFZeDhRM1RMdzdjZ05x?=
 =?utf-8?B?WmRpZkh3bHRIM2ZDYUxCejJ6ZFI1cWNxdEUwRGp4Q3pKcGtLTUhQemFCRzNT?=
 =?utf-8?B?OE9hVmE0UlFKQmRac1Q5SGJaTW16ZUVlNE4wMzcrOE1iYjltNzk0WHZQaCtG?=
 =?utf-8?B?dzhRU1daT3M5MEhsUlVWMkVwNGxIQ0E4TmN4dDhLdW1GcVRMUk9ML0RkeHpx?=
 =?utf-8?B?L2E1ZUZQRkRlaGp5Unk2VklxWmVrRFRGUHN3V0JPd3pzei9za1RTTUdDUWw3?=
 =?utf-8?B?UEszbXM0dHp6cEdVTGxlVjJnM0JOMThUUXhUR2JvdE5UTzJxZElYYkM5T01h?=
 =?utf-8?B?ZG5CWXZpQUpKbDA5Ymd1bUVsSWczSE8xK2lBdVBZSXNGQ0tMSEVTVE9TV1dm?=
 =?utf-8?B?MjZ6blc1K243VjFaNjZ4QUJ4aUZsUFdlckZHVm5CcHcvT21yQ1ZkRHlHMjFR?=
 =?utf-8?B?bGlWMHk1NG9lUW5aRTVMZXpHT01aOEhjdEVxaStEMHpmWFZkN1l4ZlhYNm9T?=
 =?utf-8?B?bStHR2pVL1o2TEIzZVl6NUQ3cnJMb3Y4aFpYakVjaEJNaXE2bHladWp6eGFG?=
 =?utf-8?B?cXo1VmV2aVJhMWNpYVlFMGN0YW51bi9RQmIvVXJ6YzVDVUwzTTdObi9uUE1Z?=
 =?utf-8?B?bEZnRnBkL2lUTVFsT1BvTnpwR3htcDg4NHNsR1U3enM0eXJja29HMHF2Z280?=
 =?utf-8?B?bjlGSHVJbE11TlVpcG5xdXlwSjVlRzkybXQ5QWVIektITVJnWEFuVVRvRU95?=
 =?utf-8?B?cEtSSy95cEhZbkFRdno5YXc0MlNtM2hITjkzQU9kT1FGajJLU0dMOFFSdFpL?=
 =?utf-8?B?NS95dTAwejN3TVU4eVBKczduV1FyR3BPV1ozVGhLTDNKck5zeE4wZDg4eWli?=
 =?utf-8?B?M2VjT0hzSUtZckFzQncxOUlHaTlyRjY1Tm4xQndtRzNCRUgyd0Z4dnM0MDlT?=
 =?utf-8?B?RkErR0JlWUQzclVhWE5Zd2JOYTZhVzNtM2djNHp0NHJvdkNmMi80SEF2Wnpq?=
 =?utf-8?B?TkxxNU5sa0tLMmNsQmoxUnJ3VnZ6QjJ1eHpDNHd2dU5kY20rTjdzZ2Ftd3lR?=
 =?utf-8?B?WmFjM0JLT3FHaEJ5RS9SWFVLbHpCSUJqdlQycEsrQnp0TEozbEtvL1ZONkhD?=
 =?utf-8?B?WGVQTGxzbVlSYi8wbmZIdzZFNDg0R1ZyOXVSZVNLZCszR25yem92ZTdDcnFv?=
 =?utf-8?B?YU83UXI3T3FodU8zOTBjQlFCYzE1Mk1HU1h1ZXJBV29wL1lCQzU5eUVad0lW?=
 =?utf-8?B?NXRWVHByWktDTzhkbXlrMGxXdUc1MmNaNWlxOGJXVHM1aldvb0hPL21HL3JX?=
 =?utf-8?B?Wlhkcmt5bEtTUWNwOCsyM0JhNm4vTHg5blBYdk4yaTdkVERLRnh3ME5BZXZX?=
 =?utf-8?B?SDgvTUtocDNkT0lTdHhsVGpBcVEyMDZmWW82UVVObS9VQlE5cG9JOWNyeDE0?=
 =?utf-8?B?dW02Q1VIdXJhRmxkODRIZzM5a255bEM2ZUtGU0RVV1FFOVhINFU1OTl3VUh5?=
 =?utf-8?Q?mgNk763rHzolmntm7idyGBmaJ5LRII1O?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5530.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG1IWjZBRWtBRlpVbjd3R2pTeStyZjl1bTlXRlZTcGZLVFBLZWlzaXo1S0pI?=
 =?utf-8?B?N2pka0YzYmRaZ0Jqak5Mb083Y2ovZ3cwYXRIZEhPcVZGek10RU50ejlvZlpS?=
 =?utf-8?B?RmczY0p4OXI3NDBiT044NnNYdlJOcDdEbk1nV2tHczUyVVowOWhGRDZVWEFR?=
 =?utf-8?B?NDZaM0VGTTBXdE8rRm9LZEg4T3REZEdrbG5jeU9YU0ZpQ2xBNi90OUFKb2NQ?=
 =?utf-8?B?UWs0OHNJZ2ZROWU0K1UzYnZFSDBsbE13WGNoQ2l1Z0NKQmR4UzFGZVJWWW04?=
 =?utf-8?B?Mko0bWRQWkVnQllqV2NCV2dIZ0dkdE1EZyttV1NEdDVIbDNzOHkxZS9VZ0Nn?=
 =?utf-8?B?ai9TamVEL284ZWFtK2V1RysxWkJQMXR6Qkd4cU9EeHhzb0cxa0QzYmlZWWRm?=
 =?utf-8?B?MDhpQVVlNUhGQVRmNmxoZ3J5d242UnNCWWIxNUdOTHBwbHkzNytub0hQdEk1?=
 =?utf-8?B?YTNQZ0EwU0czQUxZZTRVTHNaS1RuclBpK056aC9YdVowU1RDRlNvbUttTXVU?=
 =?utf-8?B?M1hWamFRYmZTOEYrSWJrU1Z1c3BCYTVEVzZ1RHVUNmxTRm5reTNQVlNjZ0lh?=
 =?utf-8?B?amNFVkowOWFtNnpITWs3TGhGcGVTQWZESUVSZHZZRnhxcmdhL2hKZk5NdUds?=
 =?utf-8?B?V0E5WHRtNFNoektLYTBSSVA5dk5DNVBkL09FZk12SnE5MWlMR25YVkh2dHMz?=
 =?utf-8?B?VWRiR21EY3pLeG5IVTlhODJTaUNKdXNBL0dwOUNXN0dPWUp3a3RpY0U3QUsx?=
 =?utf-8?B?eFAzSGJxaVlSVnJ4eXFMNTZTb1owVzd5MnJCdUZqUjhJT2QzYUd2Q0FnUEts?=
 =?utf-8?B?aXRzKy9Oem9vZDZSL2Myd3QvQzVLMk9yQ2tWYUpNTHhXbEFmU3FmOUowK2lw?=
 =?utf-8?B?VnN1M25RVS9vSTNFTlZlOCt5aGRvSFpsQ1JDQ2toT2wrRm5LaXN2UjJISGZD?=
 =?utf-8?B?VEQxRTJpR0l6OHNBeFRTZVZ3emJvcG15dEpsaDl1YmlxZWt5WUZWRzhVWEha?=
 =?utf-8?B?bDlpUnhWYy8xaUpEWGJUeUVGKzB2SmRCanhJV3gyZ3RpcjR0dHBsTDhBVkMy?=
 =?utf-8?B?cnhvdVNocXJaUFQ5KzFmMTllRWFwbjZmdHlhS1YzZlY0WWxkbCt1bElVYzd3?=
 =?utf-8?B?MW9tNldzTDJJR0hMUG9QTzFNbGNTVTMrSkJ1MjFpallYcXNVck9WeWV1NTE4?=
 =?utf-8?B?TVhoOGhGa3ltMXUzdmxaejNlUk5ZYWtXeGtqZ1Y4Um85Q01HQmU3ZWRoenVI?=
 =?utf-8?B?clhIN3R2em5mS3BaUlQ3T2FFT2VWY3h2Y0FzSDNDMCs5NG1RaFRTUlBVdXFE?=
 =?utf-8?B?RmkyQzJPTU5DbFlGSWVidzBxV3FiUk4wUHFsWjRISmM3SnVpZ1pTdDBNcFc4?=
 =?utf-8?B?dXlJaXlwRU14bk1qV210WHdwbHRqWU5Wd29CQ2hZdEk2UjRaSk5ETnhMVmc1?=
 =?utf-8?B?UzhPU2dRMWkyWWFMbzU3Yk03SktYbmxyMmlJRlVIZEsyUm9PQU16OXpjV3FM?=
 =?utf-8?B?L1h2NlBtSDk0MExCQzhqdWM1UEZoNHYwWE9NRWtOaURXOXJJU0tzUkQ2Risy?=
 =?utf-8?B?d3NKTE9hKzIvQkI0YjhZd3lLbzMzSXRlcG0yUlBBUndYem1ldWdUcTdZMjZZ?=
 =?utf-8?B?cWxyTWxUTllST1JuYUNWYUhUUTNHMUxBSEh2VU52NkVpQjBjbk9WYnpuYm50?=
 =?utf-8?B?ZTh4bmtPZ1R5Z1VKQURkcHBwcFV3R3M2K2g2NXIvNTVtMjBHM1pZdXRGejVn?=
 =?utf-8?B?ZXpkQzFxVCttd1RadnArZ3BmUkZFeGJtaVY2bkFhVm1oQUNsdG5OaEJESXcz?=
 =?utf-8?B?cyt5c0JlMXhJdkF0RjZVc0lpS0hmeVFjMDMwT1dBVkRFSWxBbzZIQmJmTGlM?=
 =?utf-8?B?dHhmbjUwQkFkWERzQlpwbVJyNjVrMmtJdmc2dGtZTnJoYlRPTVdyd2JQOWpR?=
 =?utf-8?B?ZW5aYkc3bXdyclpyQXRYL0tyVFEwTVQzeFVwOEtoWldBdGpNOG5DNmxCNSt1?=
 =?utf-8?B?eC91aHF5blh3QjJaaUFsbUxvanJiZmdjQmN3MDhoWGRMOGxNRHF1bjZxS3dK?=
 =?utf-8?B?S1kyMEcxNUkwd1VaRVpJdmg0YXFaWjlEeWQ2NE1CL0FDcy9Tb081S1FyZFpI?=
 =?utf-8?B?bXFCUTJIUGZwUjdIbUhyU3FBSCtqUVBUVGtKSmlCbE15N2k1N1lnWk00a250?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a99d00bc-0aef-4376-0bb3-08ddffe835a9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5530.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 06:11:35.8174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ocglrSuc4+vYxatPRXGYRfqNBhpRZWDRcwIA5X9JtDGWjVxSj31nidO11HD8JiuJmM5dXDzStKOr1XkTs376vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFE50071912
X-OriginatorOrg: intel.com


On 05-09-2025 00:00, Bjorn Helgaas wrote:
> On Thu, May 29, 2025 at 04:46:44PM +0530, Badal Nilawar wrote:
>> From: Anshuman Gupta <anshuman.gupta@intel.com>
>>
>> Implement _DSM method 0Ah according to PCI firmware specifications,
>> section 4.6.10 Rev 3.3., to request auxilary power needed for the
>> device when in D3Cold.
> Cite as "PCI Firmware r3.3, sec 4.6.10"
Ok.
>> Note that this implementation assumes only a single device below the
>> Downstream Port will request for Aux Power Limit under a given
>> Root Port because it does not track and aggregate requests
>> from all child devices below the Downstream Port as required
>> by Section 4.6.10 Rev 3.3.
> Wrap to fill 75 columns.  Update citation as above.
Ok.
>
>> One possible mitigation would be only allowing only first PCIe
>> Non-Bridge Endpoint Function 0 driver to call_DSM method 0Ah.
> I don't quite understand how this mitigation would address the lack of
> aggregation or how the mitigation could be enforced.  Maybe just drop
> this?
Ok. In patch 2 this is being mitigated by allowing one request per root 
port.
>
> s/call_DSM/call _DSM/
Ok
>
>> Signed-off-by: Varun Gupta <varun.gupta@intel.com>
>> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
>> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
>> ---
>> V2(Bjorn/Rafael):
>>    - Call acpi_dsm_check() to find method 0Ah supported
>>    - Return retry interval to caller
>> V3(Kuppuswamy)
>>    - Add NULL check for retry interval
>> ---
>>   drivers/pci/pci-acpi.c   | 87 ++++++++++++++++++++++++++++++++++++++++
>>   include/linux/pci-acpi.h |  8 ++++
>>   2 files changed, 95 insertions(+)
>>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index af370628e583..87f30910a5f1 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -1421,6 +1421,93 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
>>   	ACPI_FREE(obj);
>>   }
>>   
>> +/**
>> + * pci_acpi_request_d3cold_aux_power - Request aux power while device is in D3Cold
>> + * @dev: PCI device instance
>> + * @requested_power: Requested auxiliary power in milliwatts
>> + * @retry_interval: Retry interval returned by platform to retry auxiliary
>> + *                  power request
>> + *
>> + * This function sends a request to the host BIOS via root port ACPI _DSM Function 0Ah
>> + * for the auxiliary power needed by the PCI device when it is in D3Cold.
>> + * It checks and evaluates the _DSM (Device Specific Method) to request the auxiliary
>> + * power and handles the response accordingly.
> s/This functions sends a request/Request auxiliary power .../ (imperative mood)
> s/the host BIOS/platform firmware/ (non-x86 firmware may not be BIOS)
> s/D3Cold/D3cold/ (twice) to match other usage
> s/root port/Root Port/ to match spec usage
> s/It checks and evaluates the/Evaluate the/
> s/and handles/and handle/
Ok
>
> It's not quite clear from this description, but the code assumes this
> is called for a Root Port.  I don't think that's quite the right
> approach because the spec only says this _DSM function is implemented
> in the scope of a Downstream Port.  That *could* be a Root Port, but
> it doesn't have to be; it could be a Switch Downstream Port.
Agree, I will rephrase with "Root Port/Switch Downstream Port"
>
> The caller shouldn't have to traverse up the tree, checking whether
> this _DSM function is implemented at each level.  So I think the
> driver should call this with *its* device, and
> pci_acpi_request_d3cold_aux_power() should walk up the tree looking
> for this _DSM function.
Agree, will handle this.
>
>> + * This function shall be only called by 1st non-bridge Endpoint driver
>> + * on Function 0. For a Multi-Function Device, the driver for Function 0 is
>> + * required to report an aggregate power requirement covering all
>> + * functions contained within the device.
> This last paragraph covers two separate issues:
>
>    1) Sec 4.6.10 requires driver for function 0 to aggregate power
>       requirements for all functions in a multi-function device.  We
>       can't enforce that the driver, e.g., xe, does this, but it seems
>       like this is a hint that we should only evaluate this _DSM for
>       function 0 of a multi-function device.  So it seems like we
>       should return an error if called for a function other than 0.
Fine, I will return error for function other than 0.
>
>    2) The "Location" part of sec 4.6.10 has a separate restriction
>       that system software, i.e., the PCI core, should aggregate
>       requests from child devices, which we don't do so far.
>
>       If drivers call pci_acpi_request_d3cold_aux_power() for their
>       devices (not the Root Port), there might be a way to do this
>       aggregation by tracking the sum of all requests at the Downstream
>       Port where we find this _DSM function implemented.  But I don't
>       know whether it's worth trying to implement this now because it
>       seems complicated.
Aggregation is complicated and not required for current use case.
>
> I don't know what "1st non-bridge Endpoint driver" means.  How does a
> driver writer know whether the driver qualifies?  Maybe just keep the
> part about this only being supported for function 0 and note that we
> don't support the aggregation across multiple devices?
Ok.
>
> Wrap this all to fit in 80 columns like the rest of the file.
Now it is allowed to fit in 100 columns but I will fit it in 80 columns 
to maintain consistency with rest of the file.
>
>> + * Return: Returns 0 on success and errno on failure.
>> + */
>> +int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>> +				      u32 *retry_interval)
> Name the parameter "requested_power_mw" or even just "requested_mw" so
> we know the units.  Also in header file.
Ok
>
>> +{
>> +	union acpi_object in_obj = {
>> +		.integer.type = ACPI_TYPE_INTEGER,
>> +		.integer.value = requested_power,
>> +	};
>> +
>> +	union acpi_object *out_obj;
>> +	acpi_handle handle;
>> +	int result, ret = -EINVAL;
>> +
>> +	if (!dev || !retry_interval)
>> +		return -EINVAL;
> I think it's reasonable to allow retry_interval to be NULL if the
> caller doesn't want to bother with retries.
Ok
>
>> +	handle = ACPI_HANDLE(&dev->dev);
>> +	if (!handle)
>> +		return -EINVAL;
>> +
>> +	if (!acpi_check_dsm(handle, &pci_acpi_dsm_guid, 4, 1 << DSM_PCI_D3COLD_AUX_POWER_LIMIT)) {
>> +		pci_dbg(dev, "ACPI _DSM 0%Xh not supported\n", DSM_PCI_D3COLD_AUX_POWER_LIMIT);
>> +		return -ENODEV;
>> +	}
>> +
>> +	out_obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 4,
>> +					  DSM_PCI_D3COLD_AUX_POWER_LIMIT,
>> +					  &in_obj, ACPI_TYPE_INTEGER);
>> +	if (!out_obj)
>> +		return -EINVAL;
>> +
>> +	result = out_obj->integer.value;
>> +	if (retry_interval)
>> +		*retry_interval = 0;
>> +
>> +	switch (result) {
>> +	case 0x0:
>> +		pci_dbg(dev, "D3cold Aux Power %u mW request denied\n",
>> +			requested_power);
>> +		break;
>> +	case 0x1:
>> +		pci_info(dev, "D3cold Aux Power request granted: %u mW\n",
>> +			 requested_power);
>> +		ret = 0;
>> +		break;
>> +	case 0x2:
>> +		pci_info(dev, "D3cold Aux Power: Main power won't be removed\n");
>> +		ret = -EBUSY;
>> +		break;
>> +	default:
>> +		if (result >= 0x11 && result <= 0x1F) {
>> +			if (retry_interval) {
>> +				*retry_interval = result & 0xF;
>> +				pci_warn(dev, "D3cold Aux Power request needs retry interval: %u seconds\n",
>> +					 *retry_interval);
> Seems like pci_info() to me; the user can't do anything about this,
> nothing is really wrong, and the message shouldn't prompt a bug
> report.
Ok.
>
>> +				ret = -EAGAIN;
>> +			}
>> +		} else {
>> +			pci_err(dev, "D3cold Aux Power: Reserved or unsupported response: 0x%x\n",
>> +				result);
>> +		}
>> +		break;
>> +	}
>> +
>> +	ACPI_FREE(out_obj);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_acpi_request_d3cold_aux_power);
>> +
>>   static void pci_acpi_set_external_facing(struct pci_dev *dev)
>>   {
>>   	u8 val;
>> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
>> index 078225b514d4..6079306ad754 100644
>> --- a/include/linux/pci-acpi.h
>> +++ b/include/linux/pci-acpi.h
>> @@ -121,6 +121,7 @@ extern const guid_t pci_acpi_dsm_guid;
>>   #define DSM_PCI_DEVICE_NAME			0x07
>>   #define DSM_PCI_POWER_ON_RESET_DELAY		0x08
>>   #define DSM_PCI_DEVICE_READINESS_DURATIONS	0x09
>> +#define DSM_PCI_D3COLD_AUX_POWER_LIMIT		0x0A
>>   
>>   #ifdef CONFIG_PCIE_EDR
>>   void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
>> @@ -132,10 +133,17 @@ static inline void pci_acpi_remove_edr_notifier(struct pci_dev *pdev) { }
>>   
>>   int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struct pci_dev *));
>>   void pci_acpi_clear_companion_lookup_hook(void);
>> +int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>> +				      u32 *retry_interval);
>>   
>>   #else	/* CONFIG_ACPI */
>>   static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
>>   static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
>> +static inline int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>> +						    u32 *retry_interval)
> Wrap this to fit in 80 columns like the rest of the file.

Ok.

Thanks,
Badal

>
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>>   #endif	/* CONFIG_ACPI */
>>   
>>   #endif	/* _PCI_ACPI_H_ */
>> -- 
>> 2.34.1
>>

