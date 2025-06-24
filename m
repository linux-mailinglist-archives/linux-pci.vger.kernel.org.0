Return-Path: <linux-pci+bounces-30489-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2C7AE6271
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 12:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92E2A7A2662
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 10:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE961279DDD;
	Tue, 24 Jun 2025 10:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TRYNQs+Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3C442056;
	Tue, 24 Jun 2025 10:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760976; cv=fail; b=SmrKoHHVJhEal5SJ+S0sNww1qQDUvHB7cVJIRqclalSbg+LuYmctE2tXD/StC1cHgPV+wBHLHnw7/gi3buRJ9jmj6BbmL9j6Spo19nIblYOk/vLMt1hEGWbWBg5d7Wqj5nLZmgk5lEC2lvM8yUKjqj9oUWMIlzHP6XgWuENWsso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760976; c=relaxed/simple;
	bh=eYSZ3oXKWRkWLKtDqAQJW1MWO9RputEKITwAja6NMSU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rGwGKR7bQqocjNY7GszGt3A1ekJuKnFCKYZftqi4+PQCMsUTitcnSrMUYVg5xfF2P9bwZ8OhvmSo2vQtaQzfNObfMUhSZ4ySKDYqp3eW/qofGRNzNVOcF9kfNusoMXfwTyDdQ2Y6fqdUj5yvAXi4ic2iGS01k7HfQ2Fuo5kdJyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TRYNQs+Y; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750760975; x=1782296975;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eYSZ3oXKWRkWLKtDqAQJW1MWO9RputEKITwAja6NMSU=;
  b=TRYNQs+YqS5zAaY6cWmlt38Jtar+tJ+EHSKxyGDIDDnPeNd9YtOOpi8m
   3JLzTubfyN95mdyIqfFjV1YRFiuHqxHGoJEEv4pv4SE7ISC/X41s/DucK
   Dzz4hGw8DQP5X5PJF+Usf6SpNlvjcNQfbviOeyK2bPDRc9pNcqpihod08
   fK0eYjibOEVCDGKfkP4OEoc2D5kLTgscFQnaEa9Wmf4fbaAeEUeSWhlP+
   dpIErq0gbUMWJBlMLJRzi0TMVmKUdXwm7dGHhdjCAw+qU36EKcZfrl7Kr
   Gz4yXb/o5nFOMBYJnO5ci7ar16vypml3KbUZafdTwXxPUzF0BxxdFg0jQ
   A==;
X-CSE-ConnectionGUID: W1ImpV3XR5+PvmmObJKjtg==
X-CSE-MsgGUID: ZEouT7jeTHSGKtZaC57/3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="56778118"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="56778118"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 03:29:34 -0700
X-CSE-ConnectionGUID: GE/3/m71StywiMF4ps1D7Q==
X-CSE-MsgGUID: 7hzAEda1TPiokvk49Ur7Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="152169735"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 03:29:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 03:29:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 03:29:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.70)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 03:29:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdVmJaaMX7InIcHbmY/CzB/FEdgIrklrMgpRsndCiA71Yai/eVqQBU/jLMtSwHenjnbuF2v/5tMBjw1W2cyalJo8Vz91tSHTMYcFyN0ue6nh3GwsOD1a/9+zwW4vVWkpOUWSAA0N1MRH9V1CB6tPVrY2IDgsp9LMfcRm/PLu+4R/Fzj9KdL6EMVEZORC4HRwGNNa0q9O6wb0Emow3ct1j98Tz9icLoqRe6VeSF0MbgP626WvuJrCdJiUXi8rLTxZZx8MctMDd2i7d7nzxh++qciJ7dMNWTHS6lMWk8XpYnSjjBpGVaQHDI9VjUCqCuqYlRNEpAtC1nhHLu5c/BUpVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eb0HabOQ16r9j0yyFz4AM29UsHPboMytOltBj7Ym2ss=;
 b=fbgKcSbBfp04dlXaBxrquugZpE6ePDZ3UN+FH9LWvKonsh2Q42fj95e4QssuyUMYhAkbuNXGOgwIAO/E3ExfmiDTbV5r9W2dceKinI9P8dWYbLt1u/Y5f9GcIico/4P3M6g1Zrr+XJNw/lXcLU60WZdSqdI7DXjMB/DHBIj2Ryufw3sDLRRRicmU9XMUIEr4e9IxQAyfCoxm5MjiIeqzhoNJqFZ/1W0z4vDGqKPWJ9xQEEpDr9M2p7Zj5qb1wP+7C4staUHOnFIKOtagn7xJmVOsT8ruCHMlT8mhYjkflRq+fnLdCvZz7YFRNzMBVpK9HQ8vC4PYSRt2W3HQGdC/wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB5249.namprd11.prod.outlook.com (2603:10b6:610:e0::17)
 by PH0PR11MB7562.namprd11.prod.outlook.com (2603:10b6:510:287::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Tue, 24 Jun
 2025 10:29:03 +0000
Received: from CH0PR11MB5249.namprd11.prod.outlook.com
 ([fe80::a665:5444:d558:23c3]) by CH0PR11MB5249.namprd11.prod.outlook.com
 ([fe80::a665:5444:d558:23c3%5]) with mapi id 15.20.8880.015; Tue, 24 Jun 2025
 10:29:02 +0000
Message-ID: <b0092e98-4f2d-4d29-8200-ef71099786ee@intel.com>
Date: Tue, 24 Jun 2025 15:58:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v4,06/11] drm/xe/vrsr: Initialize VRSR feature
To: Badal Nilawar <badal.nilawar@intel.com>, <intel-xe@lists.freedesktop.org>,
	<linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: <anshuman.gupta@intel.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<lucas.demarchi@intel.com>, <rodrigo.vivi@intel.com>,
	<varun.gupta@intel.com>, <ville.syrjala@linux.intel.com>,
	<uma.shankar@intel.com>
References: <20250529111654.3140766-7-badal.nilawar@intel.com>
Content-Language: en-GB
From: "Poosa, Karthik" <karthik.poosa@intel.com>
In-Reply-To: <20250529111654.3140766-7-badal.nilawar@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::12) To CH0PR11MB5249.namprd11.prod.outlook.com
 (2603:10b6:610:e0::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5249:EE_|PH0PR11MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: 42dae9f2-f6d7-416b-5b9e-08ddb309efc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXNORUpUVldyR1phZ3Q0aFFabzRZODhrMHRQaDREYkJJbXJkWnRSSkVKVzZh?=
 =?utf-8?B?Vk5SMnpHd2U0NTlmTjVXcGtMUlpOSnFuaDhmbU4rR2JKQjlITXZSR3luRUNn?=
 =?utf-8?B?Ry83dDB4b1VhK1lTOTFVaktlSmdnWXBQUGp6U1plb2l4Vk5ZaGU2Wnc0Wnhl?=
 =?utf-8?B?Rm9EVWE1NFJCRHJxcjlvUDg1dWxUOHhqb1RMUnUzQXdpUVJkR0orWThqVmdq?=
 =?utf-8?B?TDdldUtPQnBsd1hWWUlJeGM3d29aQjgrcWZOWHV0M0ZXNjdoWGV3TW4xdVRQ?=
 =?utf-8?B?UkVWSTVabzVJeUQ4dk53T0IxaUtUNDZ4c213M2pGV0lXcFRsclExMGdxK05j?=
 =?utf-8?B?dmpKWTc0czJpRzhPNEhTQlkza0owbklsM3k1MjZ3bjdFZ2lmU2lTZlc2N2dn?=
 =?utf-8?B?Y2dzR2E2QVpTY2VabFJVYUdmLzFuMlpLME9DVlRLN1BFK0t2ZFJsUzVyS0xx?=
 =?utf-8?B?RGl0a1oxQmpNcWczOS9IUUV2UmgxdnRVdFdZUm4xT21HdUQ4MThvcmJtVkRP?=
 =?utf-8?B?MXpzd1REQzRHa2tyanNXelVPWHd3VzJrYmxpZW5FbkFhMHQzeXNkajRHQ1li?=
 =?utf-8?B?eE5jMVpvek9QTklZYTRTZEg4ZmFpTFdVdzFoSmxvQWdMMFhtNDNCK21EYkJv?=
 =?utf-8?B?WU1kSHhPaFRsRXdqZWdzUExhb1c5Y3R4dVN3WldEM0x2UG00WXcxL2U4N0Er?=
 =?utf-8?B?SHNycml2cDZueUZnL0pZdlhZdmtQZE53S3FRdTdyNzRYY3JxVWhORjREempH?=
 =?utf-8?B?akNQUGFHYi80TENGbm9BWTZkYmpaRUljNjloZEZsYVNWR2JnZ01mdDZsQ2dO?=
 =?utf-8?B?UTZ6b2VaMU1pRHhwS05LRTF2WHRUTWpBWXNDdnBQSktndGFLWmdEVUZCTkV6?=
 =?utf-8?B?S1BULzBpKy9mOG5qd1RkZkpIU1ErU3NtajhiakZtY0dEbmVuY3NlZTgyZEtE?=
 =?utf-8?B?Z3VyTTlrZTVEZXJtVWh1cUpRays3NFdkdVJSTEU3K1orbVNQdEZpYU9ldGFs?=
 =?utf-8?B?d0ZUbzZ2YWh6eElOc1pPei9XLzM3N2pVeWtid0xPZTB5VnU3bUpEdnFKYzlp?=
 =?utf-8?B?THM3M25jOTBMd2ExN3JkeG90QnFNbjdoNHVKb0lFUVZSTzFZSWs5VjREU2NU?=
 =?utf-8?B?REZoT3F6anVVSWF0OFB4UVlyNjVyTUxhdm9kMEVqM2gzK3FjYU93VkdwNUtw?=
 =?utf-8?B?Ym9LNzVCcFlXR2tYOVN2cjFYRWJDWnFxaGkvMGFYNmJTS0diTHFldzhxSDF5?=
 =?utf-8?B?WlFsVWxrVTdDd0tBa3dJSEM0YWdxTzdreUFMZE5NZms2b0REMG0zbjVaY0lt?=
 =?utf-8?B?MWl1Yjh2ZmtFT2YyNkJOVlZmOVp2a2NaSWxURUdIS0g3WmJmZERxMUFvV2NC?=
 =?utf-8?B?TGV0YWFRczRkNkRhUmxDeGowRkRmYmoyTnRHWlhBYzRReDA5aHVLbnV3eWoz?=
 =?utf-8?B?Z2s0RHFtbnhOTWlnZklIQklKMWFOT1pJY29EVVd1MlcwRUF1WTFKZUx3U1g4?=
 =?utf-8?B?YTZXVDJiTGtYZDl1NklyMUZ4d0R5SzEvbWh5Q1BibWtSVTVXNTBwTXY0VW45?=
 =?utf-8?B?dWVxMlRNcFFVK0ZpdGZ1VENtZlhTMTRuNTZxUUIwUXdyaSsvY3h2NmY1WHBv?=
 =?utf-8?B?MVp5U3cwa2dNY04rWFhlc1NHVVlmWmcrTWpNUFFteXN2RStDWGhUMWh2cG0w?=
 =?utf-8?B?dlVCcC9QeGN5eVRFLzM4bkM0U1ZFK05keGVLYjg1bmhqeWdUR3RDZnNPSXF1?=
 =?utf-8?B?KzhCOTRlTm9KcUlXU0tKamh2ckRGbWNEa0JhaHdYVU85MXc3Z3pHOFcyNWVs?=
 =?utf-8?B?MjltZHg4Y2E4NXJ5cjhkM1d0Ull4Yy94Q05lb0VXWnA1TzMxdDhMV25wWDN1?=
 =?utf-8?B?VjVnbU40M3hOQVNYbTNSdUR3N2poNEQ0YmtuV01lMlVVQlRDTzMwV0Yxamg5?=
 =?utf-8?Q?SRsXwdEPhDc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5249.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3ZJWHRqaW5GNkdERnAxek9iOWpKY0dzQ1pUeHIzNjYxak1UT0xJbDE3OFVy?=
 =?utf-8?B?Uys3N1hzN2puZ0dYak9jMk5PbTZUWlJ2M0lzNG5vSzF4N1liZGxMdHZuNEdr?=
 =?utf-8?B?eVA4VEgrZzAxNENUVVZaMUR5VXRHb2RmMmJzWU1maG9hdnI2RDBYOGFmRUtx?=
 =?utf-8?B?NjVZb0txVWFkbWQ5V2tvb29LeDEzRmQwZEU3NW5nSlJiNFlYZ0RnR2tUQTJB?=
 =?utf-8?B?YmVoUFkyS0d4MlliZWMvSVYzbVF0VE51TXVyekU2bC9qNXFLc2h1dWFTWkFZ?=
 =?utf-8?B?SS9EbGN6MVpHYTcwRUNQcHc4dE52STZjb0dORG01b1V4bDYxNmYzR3NKcVdU?=
 =?utf-8?B?TlYrYmIzZCs2cEZreDQwV1FjY29ZaUdQbEJmUDRwQmc3a1pEUUFiTHBlaUxE?=
 =?utf-8?B?MmRoVGdtbXpyVEFzV0JuV3A4eXJhUS9wWTFIRzA0alVpbk84aFVmdW8zdEo2?=
 =?utf-8?B?Q3JnS0xHeFhRRm80WjgxVjB1OEZuZXZEV1RrSEttVFExZmRvaWY4ZUNpU2Fn?=
 =?utf-8?B?TlVjSHo0aEdLTWpaaVkwQTlqQWFyQXJFVVo4VitIWmlQQUs2OHlKMzBYVDNw?=
 =?utf-8?B?aU5UVkNOaDVBQ2g4SWJuWTNJRlFUU2lYdjdYNTdEcHVUaFBnMnhna213cTN2?=
 =?utf-8?B?R1hqWmJlQk5QSXJRM29uTlNKZEUzNGdYd29pSW5NeFpsOXhkN01zYVFPaURl?=
 =?utf-8?B?WXNHckNZUkpGRi93RDdKSW1yL293ZHROZ0t4eU1iYksvWFo3UFF6a29jOXhi?=
 =?utf-8?B?d1RTY1l5VnhlNkFleFZsVmJ0SVBJTnN0WlExKytkOGQya0JXVTQ0K1RGQ0FY?=
 =?utf-8?B?aG1YVE9rRTZOTUYzeGttbmNjdVBZY3JjcGtRelJIS0pwZ3hvVlE2c2RZRTVT?=
 =?utf-8?B?c2d1Qk9EOGplMUptRndQTzF5ODFBSWc2SFViR09RU0t2WHdNc3JXNllnTkpq?=
 =?utf-8?B?YTYrN0RhdDNLZGZOYThHYnZPZXpQZ1YvaEVrTFQ4bUxSdXlMZFZtRC84WU5v?=
 =?utf-8?B?aUt1ZkdEekN3S25McWdONFl1VWphY1dkL2lSVUpLSzk1OWFMUnk1ZnlqS1Qr?=
 =?utf-8?B?d3B2TEhKVXVNb0p5eTBVQXF1THhlaDJHTGorN3RaanV4WWUxVVJZREpla1do?=
 =?utf-8?B?R0FtNE5KTk9Fckc4UjlDbkxpdlY3Q1AwZ2Z3NTBqQjJaS2VvS28yMTFUcUd5?=
 =?utf-8?B?TXcrM1pxKzZrNkJLRGFLTnRWckNmYnlwOHNrYXZVbjQ2eGcvcytSSm5VQ0tn?=
 =?utf-8?B?elBhVTFIeVNMbS82bk8wb2QzUkVKQmZCaXl1Y1FQUi9pVFZ0UDJPV2l0Tm9N?=
 =?utf-8?B?bk5ZT0U1OG5uYkRKU0REUTA3OWlXcEpMVEdMbXkvUk5ZaFBiTHhiMmVEbVJi?=
 =?utf-8?B?QjRremxPZkFIUlZOZWxHdXJvU2g4Z0U3ZGNCV0M5UGtoQzlXbHRCUFRDcHdJ?=
 =?utf-8?B?akpDRzh3bFdKSFdVazdQZFJVdkJkcFQ1Z2VFcjBYTkhuVmJXVkZkRGl0bnF2?=
 =?utf-8?B?eER3UTJlNmdvbmxuNU5RUTN1dVI4Vjc0Y3ZhTW1EZEt0bXk5ck5lall2NEhj?=
 =?utf-8?B?T2VpOGdsRXZpNE1lT1cydmVrNzYxdnNYYmdFTHM4eFo4bjFuc2gvRkV3TW1m?=
 =?utf-8?B?VUx0cDYvQmRMMVdKVzRHN1Z5TEF0dlBUN1IvaHdWbDdmbUgybUovdnh2VDQw?=
 =?utf-8?B?OVBlendOTC9iTC9CVm5KR2VCb2FuNHdWbVA1UkZBRk5YOHFQa0UzdVpUUGc2?=
 =?utf-8?B?RXJUcE1za1l0U2hhNDNjZXAwbC9RbjcvaVA1d0QyL0tMTHJ2OWRIN2c4NlRU?=
 =?utf-8?B?N1lSM1Q5dXlRMXhXeHZrQTk0R3JRWGVUNUVDemJKOFM3dk9CMXRzbzUwSDln?=
 =?utf-8?B?S3JtQXR4eHhNT0tmSy9GWGM5SGlCNnRodkcxZWFvZUhFVGx0NEYxV3BGeHpx?=
 =?utf-8?B?K1YxVis0S1VBbUxwRlZKKzJZVTNPZ0RZVFlMNWZnRHE1M0g2TGg5M1Z4WUhK?=
 =?utf-8?B?dDlxRlM1RVpPZWxwSXNZYjlMK0pBT1pUSGxIQ0lQdGVieUhuY2ZWMUpPbjRP?=
 =?utf-8?B?VUt0S3p1ZGNtd0pLTGlzZVoyWnpFdDRWR0NmbFNuTmM1clhwNm01TE82Rm85?=
 =?utf-8?B?Y0ZXZkxabWFKbTVoQ0hXQ25sblU1QjNUcGNkZjh4Qk4wN0hIMVhIWnFwMURV?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42dae9f2-f6d7-416b-5b9e-08ddb309efc2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5249.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 10:29:02.4705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MpBcaaeM3aXhnf8HImZJx9puvqo1Gls0I/9MS4gBxYSACMphSdQQmuBkqS4LqVhH8tUqmiETyjnOhMH/LdUPvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7562
X-OriginatorOrg: intel.com


On 29-05-2025 16:46, Badal Nilawar wrote:
> Add the API xe_pm_vrsr_enable to initialize the VRSR feature,
> requesting AUX power limit and PERST# assertion delay.
>
> V2: Add retry mechanism while requesting AUX power limit
>
> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_device_types.h |   1 +
>   drivers/gpu/drm/xe/xe_pcode_api.h    |   7 ++
>   drivers/gpu/drm/xe/xe_pm.c           | 105 ++++++++++++++++++++++++++-
>   drivers/gpu/drm/xe/xe_pm.h           |   1 +
>   4 files changed, 113 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
> index 3a15b3a252fd..5f9a1a358468 100644
> --- a/drivers/gpu/drm/xe/xe_device_types.h
> +++ b/drivers/gpu/drm/xe/xe_device_types.h
> @@ -7,6 +7,7 @@
>   #define _XE_DEVICE_TYPES_H_
>   
>   #include <linux/pci.h>
> +#include <linux/pci-acpi.h>
>   
>   #include <drm/drm_device.h>
>   #include <drm/drm_file.h>
> diff --git a/drivers/gpu/drm/xe/xe_pcode_api.h b/drivers/gpu/drm/xe/xe_pcode_api.h
> index 127d4d26c4cf..f54ef03799d4 100644
> --- a/drivers/gpu/drm/xe/xe_pcode_api.h
> +++ b/drivers/gpu/drm/xe/xe_pcode_api.h
> @@ -43,6 +43,13 @@
>   #define	    POWER_SETUP_I1_SHIFT		6	/* 10.6 fixed point format */
>   #define	    POWER_SETUP_I1_DATA_MASK		REG_GENMASK(15, 0)
>   
> +#define	  PCODE_D3_VRAM_SELF_REFRESH	0x71
> +#define	    PCODE_D3_VRSR_SC_DISABLE	0x0
> +#define	    PCODE_D3_VRSR_SC_ENABLE	0x1
> +#define     PCODE_D3_VRSR_SC_AUX_PL_AND_PERST_DELAY	0x2
> +#define	    POWER_D3_VRSR_PERST_MASK	REG_GENMASK(31, 16)
> +#define	    POWER_D3_VRSR_AUX_PL_MASK	REG_GENMASK(15, 0)
> +
>   #define   PCODE_FREQUENCY_CONFIG		0x6e
>   /* Frequency Config Sub Commands (param1) */
>   #define     PCODE_MBOX_FC_SC_READ_FUSED_P0	0x0
> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
> index c9395e62d21d..278f2eeeaab6 100644
> --- a/drivers/gpu/drm/xe/xe_pm.c
> +++ b/drivers/gpu/drm/xe/xe_pm.c
> @@ -5,6 +5,7 @@
>   
>   #include "xe_pm.h"
>   
> +#include <linux/delay.h>
>   #include <linux/fault-inject.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/suspend.h>
> @@ -23,6 +24,7 @@
>   #include "xe_guc.h"
>   #include "xe_irq.h"
>   #include "xe_mmio.h"
> +#include "xe_pcode_api.h"
>   #include "xe_pcode.h"
>   #include "xe_pxp.h"
>   #include "xe_trace.h"
> @@ -260,6 +262,107 @@ static bool xe_pm_vrsr_capable(struct xe_device *xe)
>   	return val & VRAM_SR_SUPPORTED;
>   }
>   
> +static int pci_acpi_aux_power_setup(struct xe_device *xe)
> +{
> +	struct xe_tile *root_tile = xe_device_get_root_tile(xe);
> +	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
> +	struct pci_dev *root_pdev;
> +	int ret;
> +	u32 uval;
> +	u32 aux_pwr_limit;
> +	u32 retry_interval;
> +	u32 perst_delay;
> +
> +	root_pdev = pcie_find_root_port(pdev);
> +	if (!root_pdev)
> +		return -EINVAL;
> +
> +	ret = xe_pcode_read(root_tile, PCODE_MBOX(PCODE_D3_VRAM_SELF_REFRESH,
> +			    PCODE_D3_VRSR_SC_AUX_PL_AND_PERST_DELAY, 0),
> +			    &uval, NULL);
> +
> +	if (ret)
> +		return ret;
> +
> +	aux_pwr_limit = REG_FIELD_GET(POWER_D3_VRSR_AUX_PL_MASK, uval);
> +	perst_delay = REG_FIELD_GET(POWER_D3_VRSR_PERST_MASK, uval);
> +
> +	drm_dbg(&xe->drm, "Aux Power limit = %d mW\n", aux_pwr_limit);
> +	drm_dbg(&xe->drm, "PERST# Assertion delay = %d microseconds\n", perst_delay);
> +
> +retry:
> +	ret = pci_acpi_request_d3cold_aux_power(root_pdev, aux_pwr_limit, &retry_interval);
> +
> +	if (ret == -EAGAIN) {
> +		drm_warn(&xe->drm, "D3cold Aux Power request needs retry interval: %d seconds\n",
> +			 retry_interval);
> +		msleep(retry_interval * 1000);
> +		goto retry;
Instead of indefinite retry, can you retries with count, ~3 times, after 
which we can return failure.
> +	}
> +
> +	if (ret)
> +		return ret;
> +
> +	ret = pci_acpi_add_perst_assertion_delay(root_pdev, perst_delay);
> +
> +	return ret;
> +}
> +
> +static void xe_pm_vrsr_init(struct xe_device *xe)
> +{
> +	int ret;
> +
> +	/* Check if platform support D3Cold VRSR */

This can be rephrased to, "Check if Xe should support VRSR for the platform."

> +	if (!xe->info.has_vrsr)

> +		return;
> +
Can you add a comment here also, viz "Check if GPU firmware supports VRSR"
> +	if (!xe_pm_vrsr_capable(xe))
> +		return;
> +
> +	/*
> +	 * If the VRSR initialization fails, the device will proceed with the regular
> +	 * D3Cold flow
> +	 */
> +	ret = pci_acpi_aux_power_setup(xe);
> +	if (ret) {
> +		drm_info(&xe->drm, "VRSR capable: No\n");
> +		return;
> +	}
> +
> +	xe->d3cold.vrsr_capable = true;
> +	drm_info(&xe->drm, "VRSR capable: Yes\n");
> +}
> +
> +/**
> + * xe_pm_vrsr_enable - Enable VRAM self refresh

as this function does both enable & disable VRSR, this can be renamed to 
xe_pm_set_vrsr(xe, flag)

> + * @xe: The xe device.
> + * @enable: true: Enable, false: Disable
> + *
> + * This function enables the VRSR feature in D3Cold path.
> + *
> + * Return: It returns 0 on success and errno on failure.
> + */
> +int xe_pm_vrsr_enable(struct xe_device *xe, bool enable)
> +{
> +	struct xe_tile *root_tile = xe_device_get_root_tile(xe);
> +	int ret;
> +	u32 uval = 0;
> +
> +	if (!xe->d3cold.vrsr_capable)
> +		return -ENXIO;
> +
> +	drm_dbg(&xe->drm, "%s VRSR\n", enable ? "Enabling" : "Disabling");
> +
> +	if (enable)
> +		ret = xe_pcode_write(root_tile, PCODE_MBOX(PCODE_D3_VRAM_SELF_REFRESH,
> +				     PCODE_D3_VRSR_SC_ENABLE, 0), uval);
> +	else
> +		ret = xe_pcode_write(root_tile, PCODE_MBOX(PCODE_D3_VRAM_SELF_REFRESH,
> +				     PCODE_D3_VRSR_SC_DISABLE, 0), uval);
> +
> +	return ret;
> +}
> +
>   static void xe_pm_runtime_init(struct xe_device *xe)
>   {
>   	struct device *dev = xe->drm.dev;
> @@ -374,7 +477,7 @@ int xe_pm_init(struct xe_device *xe)
>   		err = xe_pm_set_vram_threshold(xe, vram_threshold);
>   		if (err)
>   			goto err_unregister;
> -		xe->d3cold.vrsr_capable = xe_pm_vrsr_capable(xe);
> +		xe_pm_vrsr_init(xe);
>   	}
>   
>   	xe_pm_runtime_init(xe);
> diff --git a/drivers/gpu/drm/xe/xe_pm.h b/drivers/gpu/drm/xe/xe_pm.h
> index 59678b310e55..ba550281b130 100644
> --- a/drivers/gpu/drm/xe/xe_pm.h
> +++ b/drivers/gpu/drm/xe/xe_pm.h
> @@ -35,4 +35,5 @@ bool xe_rpm_reclaim_safe(const struct xe_device *xe);
>   struct task_struct *xe_pm_read_callback_task(struct xe_device *xe);
>   int xe_pm_module_init(void);
>   
> +int xe_pm_vrsr_enable(struct xe_device *xe, bool enable);
>   #endif

