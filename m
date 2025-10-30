Return-Path: <linux-pci+bounces-39846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C946C21FC6
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 20:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B2CB4E2086
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 19:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F42A2F6171;
	Thu, 30 Oct 2025 19:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GGvoWIWS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705D821019E
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761852991; cv=fail; b=BXMBKViGkQoI2YAyNGR1LV9ybTxvKcNY2HLZ7ba0XRM4tcubS1s0GK147lBl0v2JtP+Y0xaWi5tqaJgV06Us4PK0qY2i9h+uhKYApDMBUebmkPFwrL/7qww2lyCnqsW1HaoiiHgl+p4a91uARPIfo8XIN4TfFnftL7hpN3E2qF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761852991; c=relaxed/simple;
	bh=9yDVaQZ5dIWdvczdw9/Kl3xlS80Zndn6cZyHAUxcVcA=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=fIOovk/gdNK2KAHYdm8WXfxqr9HWRovWqenw+2ZJHRIvsTnng0f4bMFd9AvbOopfSJKivU7rQ/boLRpNR4NF4pT4AaWdQIMrCX2cAwrXHJ+U/MJcb96lGrovZ/zRj1nWLasTCESuql1LNnxk1P3WX5jCcJZHHrszQynZBZRZ0cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GGvoWIWS; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761852989; x=1793388989;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=9yDVaQZ5dIWdvczdw9/Kl3xlS80Zndn6cZyHAUxcVcA=;
  b=GGvoWIWSFklOzFclD1K5m4WhEi0p9HzXNM+No2MB4Y+stPcKrZ7WnjEH
   cajoGbXKBK7M/jFnu3ExvgJ0jAttqMsqkIZ8M/kme4ecggnCZUHecAhj9
   E4igmYiajE1DxOmpqcmISZj5f+Y7TGRepw+7m3LpxH5fNC6EwMxFb8Vbr
   WbSXn75Uh34/Q3gRw2RvEHrInNhKKMOi0K/i/PN/H2UUS7e/W+UaR2Fqs
   tj3wU0PDK3GET3FDNPHroAZZ/qvMXiLqZR1Xw+FcfEVC2zoxTGyT5I7ai
   +pQ5ypXV1NzNHjN69XCKE2xGhi/yi5PzXcoLKoPdLJCsEutvwt0nyVSRz
   w==;
X-CSE-ConnectionGUID: u2r/7RNVRVamXzwm7MGBZg==
X-CSE-MsgGUID: N0x21bM/QH6ZrFgE2bvcXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="63213864"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="63213864"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 12:36:29 -0700
X-CSE-ConnectionGUID: 9P7RZj3BQFWvYbniQ5A2HA==
X-CSE-MsgGUID: CvEW/eLvQgeuSfccYadw6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="186482365"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 12:36:29 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 12:36:28 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 12:36:28 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.32) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 12:36:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnWA1WLZfOi6jzYvzAh6Gh9OmOJhzReHOn0pgcXM3lcJTJIkjpVYO/+SJ5mfFj43BFdDTDiGDf0sgFMeB2AQqmFTp3LXLaJd6NmU6Oc9paINXzA4TkFljeRZTPrWsJDXELRrpCfCH/dDLDkMIxDPtbVrMh1QOnhuT+Sf3wrizUqfEzSMprQ9PhiojF6+erovyr6H54egB2h/vLcIL4UcJQV6YK0cWqVihviiiU8Gho32HHu7mnUbTzODzlf2KbeLpgXJ0U3gZI6U4lJRaMigymHxw78+8AsR0DSgdkEkzfPiG7QHXQbGk8++ff/cOaDi9BKr8i9VBmPuzj1zJEjxgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/SpoV8amtfnUckd1o6dVNwn6lJxhUGvWltU8lXR0CE=;
 b=MFwDsXZUCUhd+QW2zzqGQ0gZi5vS97hyhZEfk7xRqku9BQ0YhFZRWhl4eFUjNobBE+1DnO4IskdfydRLhQmG+srEK723joUvMuGYJFXKD4moZ+cYpVAM6kDMqVdx0l3hyEiqIlkm4BLQxkM7Xt8avcraPu4GLjHVTs4BacF59kYpUqFM9BTPD7kKOFbE2ETfNCdeHbTlz7K/W+9dgUGeJnVRU8kigI2OMEIDi3Am9fUZNSJQ1diaD6VFXChtilxRFHL+Vj7ItW8AwTgx8/B706+9sqzbCBIOiiH3gXRbVEDDZSgA5FuzplCHTuX6E864alDG8IA1cHPMCyarc06sMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA4PR11MB9346.namprd11.prod.outlook.com (2603:10b6:208:55f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 19:36:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 19:36:25 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 30 Oct 2025 12:36:24 -0700
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>, <aik@amd.com>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <bhelgaas@google.com>,
	<gregkh@linuxfoundation.org>
Message-ID: <6903be3843463_10e910011@dwillia2-mobl4.notmuch>
In-Reply-To: <20251029140002.0000596f@huawei.com>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
 <20251024020418.1366664-4-dan.j.williams@intel.com>
 <20251029140002.0000596f@huawei.com>
Subject: Re: [PATCH v7 3/9] PCI: Introduce pci_walk_bus_reverse(),
 for_each_pci_dev_reverse()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0297.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA4PR11MB9346:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a8d39e4-4c59-4b0d-f986-08de17eb9cd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blRvMldJWnh3Mkg4YmxISkVxNEFoZXM2c1R0bUFKVXZqa3VHZ2s2T2h1eEpC?=
 =?utf-8?B?VzJzeDBVYkN0Y3g2WHJwV1lldzEzUEVmRjZRWWZnaVdPTS9SVmlkRFlhcUNk?=
 =?utf-8?B?TWJ2dHN4b2xhM0VtWVNJTjZ1UGREWm8zNVFpN1piZlJCSTkwRFZodGdPNW1H?=
 =?utf-8?B?ZTZEMDF4MGhaalo0S3ZaVTJQRFRKY2J6WG52bEdzdlRIeXZuSFNXT0wvZGp4?=
 =?utf-8?B?bWQvMDlrUml1SHNZL1VRdVdSUkNRbUlsUU01dG84OVNPQXdnOWZ2My9OeTFk?=
 =?utf-8?B?VmRRb0JvVjJMU0tjeDBVT2lGeDdkOXlGZnNsTjVIdTNWZHdVSkFVUWh5Snpi?=
 =?utf-8?B?dW1ZMldnNnNISUhSbXRXRWo0bTFuT0hBeElCaktMcGNlRlhjU0p6a1IxZ2E2?=
 =?utf-8?B?Mm9UWWhIbWs5ZFgxaEpUOW1KOWhEVmtCYjl1WmxSWGlZN3FacG52SjArTGFI?=
 =?utf-8?B?anovdkVlcmRXMVpFd3RlclR5VDd4c3F0VUcraUlQUlIwV2tyMkJzK0oxcE5E?=
 =?utf-8?B?ZU93NE0vTXFJbHhMdW5yV2U2TzB0dldNbzhWbkN3eGZmOU1YdzJSM2xOYmdv?=
 =?utf-8?B?MndQNndwbW1BMWI1VmtmaU5ORS9mRmFxc1l2T0RFV1FzMjFiOXR1SjI5N3ZH?=
 =?utf-8?B?eWNBTEFRTzIzV2h0cnhYUXUzc0RLNk9nR2o0OHF1TTl1Y3pyTWhPT1hWSk9L?=
 =?utf-8?B?TTZQVCtFVnBZS0ZDRTY0a2lkVE1hSGc3YlYzZUZoRlEvdTJGeG5Va3NCTjBD?=
 =?utf-8?B?QlpNK2lIdkhUMUw1VEZjRnhxS3lyY3lEK2NrTTBxU2JFUnoyV0k1Vm1RblRo?=
 =?utf-8?B?emY1ekdsT1VzbFh2d1lUMDNGYUc0RjNPcWZPd2lDZmwzc2dMVUJ0eHgzZEQr?=
 =?utf-8?B?RzBSRmVYaG1OMC8vNHU5WnBpd0R2c0VJZ1UreWFlTktVVVhZN1lNV21aU0Jr?=
 =?utf-8?B?c2NJaVRvZmNyZ2hJTnBEd05McC82OXdnTDJFejlSdGpib2ZtbElEQlJ3YmdK?=
 =?utf-8?B?Z2wxbDYyM0xGd2Rxa0dKSXUxNXFBdTc4aCtEdkFQVjc0RlpWZXZNNnJDdFF3?=
 =?utf-8?B?eHcwNHN3c05GQ0dZVkY4SFhpL1FicFp2ZGVUK2QvdHFRdG90ZmUrMzFIVVBH?=
 =?utf-8?B?eFpFcVJNTEhmMmFwM3F4UnBtbHJHcDk5M1VkQWc4N3BCMXhTNmdEVVdUUnpQ?=
 =?utf-8?B?djFCMVQvYlVialVBWmUvM1cybW9kNk5XOGtYRkN4SnU4RUR4Wi9RTUxkR3hK?=
 =?utf-8?B?TjFUbE45TERKeVVsamhZMHQyL0hleTk0TytDdGFFYnJsSGZNTVNrM2pBTWdO?=
 =?utf-8?B?SGZQOE1OR2ZnOGQzRHQ2b0ppUDJ3cHpsTnhFSW9CYXowRmpYdDA0b2NIMUpo?=
 =?utf-8?B?YjhWY3A2R0M1Z1lZM1J2eWUyN2ZvbVFLS2dEVmhsenNMVnRoWWtyQUZzQWJv?=
 =?utf-8?B?SnY1RjdEQWFrS3NEZkNTMDRQNzFMU2FBZnlFckd5bEN1Y3BBTC83d3hCaExO?=
 =?utf-8?B?Y0ZYWUU2cFFoZ3VTaGtEWVh6MDF3djNFTUQxSXNFNDNETjVRNnV6RUtMalFJ?=
 =?utf-8?B?bXNxOFFTMDhUN2lhVTN1MTE0VDcwMFVRb3QzZENLT3MwYTNocHRJa25jY1NR?=
 =?utf-8?B?d3duOFdqanNjTEtsN2lFcWF2SlhlQyt5b25iWExXeVRhejdlTTRTR3p5WUh4?=
 =?utf-8?B?YkN2YkpreXp0UWxXOC91c3AyZFZlVWMyMDRzOGJkMmt3RjRUVkViOFliVEVk?=
 =?utf-8?B?YzY0TVhMcE1LNi80UVk0eGNqSDBJSWh4aXFEL0FUK1RRSitYeTdRSUI1bEto?=
 =?utf-8?B?NEF4Mm12Y1hXZm5uWWplbG1hQ1pHMDhBNW5PYzVjdjZrc3ppQStTV1l0Rkk0?=
 =?utf-8?B?RzQ0Q1l6amNLQWhTcjNMOUVydTZEeUxRaHdOaGxnZDVlUTJwNml3UytrV3k1?=
 =?utf-8?Q?fKpdB41DOSU9gml5rnKcYeFq87BX6TXZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWJYS3dxMFF3UytVWHYwUXdTTXNyZk5yTlc5WXdxaHVwZDlraXBxSE9md2NX?=
 =?utf-8?B?SUpEZ09teldGZzBWKzgwQ0hzNm1KYXNsendmU1V1eDdOcysyL0FTSTl5dUV4?=
 =?utf-8?B?ZmxZOXFQcDZaeHdMc0VFdVM4b3FBNDl6d1d0aDQ1NFpBSVRBM0lxdVUvN0xw?=
 =?utf-8?B?clo2N0tvdms3WkREc0dEVzlXMGpDdWc0N09uQWJqZEt3RDkrT2dCQTIxK1lG?=
 =?utf-8?B?emdTWDgxb0Z4UUpPWkJpL1JqTWpETUx6S2lqcWFCOEdWNUxpTDZicENYOFBr?=
 =?utf-8?B?dnlRTUNrSHhwREQxK2pPZHN3WHoycjNqajYyVUM2WXVsbytJd0J3cUtrQW5S?=
 =?utf-8?B?ZUp5OGNUczdqMUZ0WnI5S3IzUmQvZUYrUkkzTURYNyt5RjB1ZUVMaXdwZ092?=
 =?utf-8?B?YU1NeWNDMm9DKzdQZ2VJSk9HdERXTXJQYTUxWHJ2N0orQ0Fkanc3K1ZsaEJt?=
 =?utf-8?B?Q0JyL3pyazRsQ21kTGFkbFpKekhYUUozRVBqRTY5eE92TE44blowdTIxZUlV?=
 =?utf-8?B?M3BVNHFVMlE3YlVIZW9LckdJdXRrM0x5YWEvY1p3RlNrY2VLV3IreDcrS2sx?=
 =?utf-8?B?a2tvc09oTUhja1NXOVVwNCtyTDVBeUg0YjQ3bjY3ZHZDakJGSEpuWS9UZmVE?=
 =?utf-8?B?YktWbG4xMXdUOStMTnRSUm5yUWRLa0g4eG01eTNjMzMxSzBTWElpamh3SjVH?=
 =?utf-8?B?RGNHK1VLVDV5a0psUitSNm9DT0oyRjkzaTR1eHUyYU80b3NwVit4cytTMjFD?=
 =?utf-8?B?dmdQVDI4YkRhdlVTREZmS2t1SlpVYlFRWm1jZlBBMmVlMStWVkpwWDZzVWYx?=
 =?utf-8?B?UUFYb0IvL0l4RHFuNWU3M3lnRExyakFxY2lUc2N1aEsxZzcweXdKbmR4Y3VS?=
 =?utf-8?B?RUVvOUZRVVR0L21OYmF0WitBYzBSSU9NeVFHVVBsL3hnN0xtYVRSR1N2b1BZ?=
 =?utf-8?B?OWkraW1MYWhXRmw1bkE4ZUFHcXdLVldTK21sUlpiVUIwQkJPTXBCemlHTU9L?=
 =?utf-8?B?OVNuNWxTQ1czYVRZZW41bmphYWs1OUVqSW82L05PWUI2bmQ1R09TOEpJRFdw?=
 =?utf-8?B?Umg1dXRSamt5RFE3NmxhRTkxRVlBN2t3dEtOSENWbXhYa0NvanRKbjJCRStB?=
 =?utf-8?B?M0VqcHdPV294T3NQanR6MHNNeDh5U1Y3UGxjaUdENXUyM0tZTUhUSkdpQklY?=
 =?utf-8?B?eDF2RVVrQlVKNkhzcWh4SDY3TkViN3VxL0poc0EyZnd3UVJweUZ6QWlwZkMr?=
 =?utf-8?B?VE9lT1kyOTJvZHFYWERxTUVzOElUTmkzUWQ5SitmVFpXYUwzSWE1RFZyNTdW?=
 =?utf-8?B?RTlRTFZQMklQM0VnTjJoTWpMa2lEemZYRTZxMmg1VlBhYVluaWV4dVpqUFpK?=
 =?utf-8?B?aTF6MVFMUy90UVNjdkoyeDByQS9oc1ExWUIvOUtFNE1nTUJuTVkvWTRONG8w?=
 =?utf-8?B?U3hjZmdNSzVBR0xoTXRjK0N3TkgvdmtKcmtpMTExM0JicEtQZGZmQkpMMUNM?=
 =?utf-8?B?Vmw0eXpUR3RyMmlwTFlqTFBzT3lWdHRzM0RoZjVLUkZKb3NzdVhHZ2htZXRy?=
 =?utf-8?B?dXhkMThmSVpxNEtsd2NETHoxeTk0QnJ0N2wvSWRTOEkzTWU1dkJ6YndQWVBG?=
 =?utf-8?B?NVBYNEVhU2R6emhDRmdPR0x4THArczd1YXc0WnhHRHpaSVMvZTBwSm9zbTlq?=
 =?utf-8?B?dGdCTG90dVBaM0NnQUwrSEhXdDF1TjhlYno5UmJ0T1VPUndGQVl5cXF3Qm9D?=
 =?utf-8?B?VWZMSFF5Uk92RlplL3duVlpUbzlWcVkxcUNQNU9BcU9hRy9xaTc1dnNXZEc0?=
 =?utf-8?B?RzhYRlM4eXc0UUJKdDRzR3RPWjNLR3I0d2pYN1NCNlRLdUt3eFFJS3hTL0wr?=
 =?utf-8?B?TVRIa2xKZy9CSS9KOVMxQ2loK0poY0tybFV4OG4rYnNUMHNOZ2VsamdXZXoz?=
 =?utf-8?B?QVRVeWxrdjNNcC9TdWY3a3h3V3NNNjl0R0ZoSXJVZlAxWk9ZUzkxdnVuVDQw?=
 =?utf-8?B?bzdDSktobzR0akRFQ3lxTkVOR20yZGEvR2VYZ1ViOTBCSDJrZlpkU3pwSU1r?=
 =?utf-8?B?c2VPQXJMc1pvVXBtcklsaExvNkgwUkFJYW5KcksyU2lDazY1b1d4S2hRbkFz?=
 =?utf-8?B?dFZJT3QwUC96WTNBMDN2ZU93NnlLYWZ4UXBLOFBPWSt3MVlXQ3kwc2FiU2c2?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8d39e4-4c59-4b0d-f986-08de17eb9cd6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 19:36:25.1348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 113SSqlidz451sOPQj8wZFpNlMfgi7L2Vt2WHPut58NqGqdXZW5VavOu9QUw72M+uD47TQUxARwQ72sKiFKW947dJ/AgYSrEB6aTm5d2/IQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9346
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Thu, 23 Oct 2025 19:04:12 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > PCI/TSM, the PCI core functionality for the PCIe TEE Device Interface
> > Security Protocol (TDISP), has a need to walk all subordinate functions of
> > a Device Security Manager (DSM) to setup a device security context. A DSM
> > is physical function 0 of multi-function or SR-IOV device endpoint, or it
> > is an upstream switch port.
> > 
> > In error scenarios or when a TEE Security Manager (TSM) device is removed
> > it needs to unwind all established DSM contexts.
> > 
> > Introduce reverse versions of PCI device iteration helpers to mirror the
> > setup path and ensure that dependent children are handled before parents.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Bit of archaeology was needed as there are some existing oddities in the
> functions this is based on.
> 
> My suggestions for this are don't use guard() and drop the void * cast that
> we should cleanup in the existing code.

I will keep cleanups that imply touching old functions for a potential
follow-on, but likely will let sleeping dogs lie.

[..]
> > +/**
> > + * pci_walk_bus_reverse - walk devices on/under bus, calling callback.
> > + * @top: bus whose devices should be walked
> > + * @cb: callback to be called for each device found
> > + * @userdata: arbitrary pointer to be passed to callback
> > + *
> > + * Same semantics as pci_walk_bus(), but walks the bus in reverse order.
> > + */
> > +void pci_walk_bus_reverse(struct pci_bus *top,
> > +			  int (*cb)(struct pci_dev *, void *), void *userdata)
> > +{
> > +	guard(rwsem_read)(&pci_bus_sem);
> 
> So this ends up different to pci_walk_bus.  I'd be tempted to just
> not bother bringing a single guard() usage here. Gain is trivial and
> mixing and matching style in a file isn't particularly nice.

Yeah, and violates my earlier claim about being style-bug compatible.

[..]

 3:  f8e6f3d9ba81 !  3:  5ae3e927d3ed PCI: Introduce pci_walk_bus_reverse(), for_each_pci_dev_reverse()
    @@ drivers/pci/bus.c: void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_d
     +void pci_walk_bus_reverse(struct pci_bus *top,
     +                    int (*cb)(struct pci_dev *, void *), void *userdata)
     +{
    -+  guard(rwsem_read)(&pci_bus_sem);
    ++  down_read(&pci_bus_sem);
     +  __pci_walk_bus_reverse(top, cb, userdata);
    ++  up_read(&pci_bus_sem);
     +}
     +EXPORT_SYMBOL_GPL(pci_walk_bus_reverse);
     +

