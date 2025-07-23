Return-Path: <linux-pci+bounces-32850-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE78B0FC66
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 23:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2741F3B5319
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 21:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B71270559;
	Wed, 23 Jul 2025 21:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4SdIMJU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67BD1DFCB;
	Wed, 23 Jul 2025 21:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753307968; cv=fail; b=XwUDu+O0RF/qTRroMr+xAW2wTAjH3qcKRlyOZCRKUxzWUusybgQmqWUClEMSgpbE/NLvd3zy4w+FZKF/VT2JQOfHYlVF7zoPBeTFmWxQ48qcGxzwbk0DOOj81VEf+NAu83nSQQlPZvlYYY3GgyPZqfqtNDjvLu2f7bV70ZYBSNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753307968; c=relaxed/simple;
	bh=7RA1oSilTRyDHnk2YGijV0JrOT3drG8JgJApTYnKZWI=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=Wyc8NTWDQOwvB4tb6sDQTUvzrR4TXcyl6bbGWJjXK+3SsxsmChPh5FndTfB7lVuOOwhhe7rx4YNOxUyStwlxAuq4Gq1s/UVSKh7zeI1xFLRHRgO6Y1yI6NdvUw9fuOiDi6K/MJdMZ+7e951XLXys7JzUxQEtHW2Dln+ocyimv/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4SdIMJU; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753307966; x=1784843966;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=7RA1oSilTRyDHnk2YGijV0JrOT3drG8JgJApTYnKZWI=;
  b=e4SdIMJUlgnnuR4VcF+0OoQCcPNrQBukEdmbRZmVOOjit1VAqoAwBI67
   bk5qUyAusoDi4uRO5xUSaYZvoQc0DrVN2lueQdW9x8HIAtnLlYy6jp9b3
   vKWi52TMpzxKOf84+Cwh2eyc9NN+v5CUeDsWdnz/0/PU1QMSOQjJEjlt5
   kNhX3iKEjD3cf0+ZphEXeiq21P7YHGDhigYK0ECNM1JaL2cvjwC4RDSzz
   fztgoMrN65pS8A8cXaikjV9V4FC4z8ui4/I67wtk2D3OyFzKdi/vgAArE
   hRsQ1Q7j/gpucB9d04Tr0IFccXM5VJ2VTl6osBvyG2FT6j8Tt4vgQNR1z
   w==;
X-CSE-ConnectionGUID: nWRoBvxxTvmCteMNvp8ylg==
X-CSE-MsgGUID: h1PRBHj0SmK98R2OgHQ52A==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="54819881"
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="54819881"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 14:59:26 -0700
X-CSE-ConnectionGUID: G5LdrnEyTViUQgNw2ceIKQ==
X-CSE-MsgGUID: KvhSya0lSSeKGxwrnrlNuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,335,1744095600"; 
   d="scan'208";a="183415807"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 14:59:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 14:59:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 14:59:25 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.65)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 14:59:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEBgR6VtOTgDRPEzihPO7kM5qqsTijNxjckNby6NtLR/HkigjiMJahsG0iNN3QwGxafszySF84IzVv9ToHPla0DtM3OUSchbU12ZlMwp1EnzQyPN6hg7N3i7IQjX8qWPJSnOjIpY40NL3AB6jDa02gFShludApU3y/AUADogGODfnV4QjZIBPQFwZM+HuYRlDPUFxqyP7wG8nXBQSQGLdRVOI/1/kItLI+iJg1qSxG81+YF+fLMCYzOTlRV221SRD2GGhitgeMSPQVy30w+ICecKNYOCRk6BtmIsNkzkKjj9w2dTRovKnLL4Iri2EYbleLHXG+ooF5I2XoNCg6sZpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Tz2ziSnqUdmwsFuBneZEl7LymxJ45U92tdtFQV3QCI=;
 b=B09AzpnQr7nsd0OaVVb35p4PjE20M1xy1+5kHuO5C5RgPsY0pxcoEADEaXp0U9VT7C78aGwn/jBe1MU4Ki/oVrkVfDWCbdZlwIubDDRo6MjSmEsTBhkXs54QxY9GhqK7OgQ3qK9EYu+nqhAzZkCFEzssVAcfPqB5Ob4Ehwjd4OmSrZP99BovFR3QEm3OB27nIjhhHWfHPGedyammsMX+jKrTiF8IFD9lHDHBXlTMlv2+6RB93Exeod5/LV5u7HdZz+bvs/0SLheDQZghV9xIhar5xY1w6dDf5w4gAzMT/P5IrLQ54xscyYrcFGtQ4+9P7Ot0DP9Tu9rAEX57W7OPCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7209.namprd11.prod.outlook.com (2603:10b6:208:441::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 23 Jul
 2025 21:58:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 21:58:41 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 23 Jul 2025 14:58:39 -0700
To: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <terry.bowman@amd.com>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Message-ID: <68815b0f224d6_134cc7100e7@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250626224252.1415009-2-terry.bowman@amd.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-2-terry.bowman@amd.com>
Subject: Re: [PATCH v10 01/17] cxl/pci: Remove unnecessary CXL Endpoint
 handling helper functions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0146.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fcde2a3-bf59-46c4-f82a-08ddca3415d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0x4dVd2ZkthUTdHRUtaTlhhRk1kZmhpcSs2NGFBYVVYODhscHV0SzNKVDFy?=
 =?utf-8?B?aHYrRStpYWQxeEJGajBQWURFS2gzNzJMeXlXcVJLaVprT1c0SHZtSFFqYzhL?=
 =?utf-8?B?MmdmcnNrbHpQRHhRODJLaWxGNUJ5bHZGcXFjSG5SUllJb2k4SlB5cnZkRm9y?=
 =?utf-8?B?alk4TEhJVXFHcklpeXUvODZaRmRybHF0cjRqblNMd3lOMXU3eUVnQ2grZnBu?=
 =?utf-8?B?WDhqUG83Z3BmZDJRaHo0blRVd1Z3L2FNeVZORy91Um5UYkhNaldIRGh4N0dh?=
 =?utf-8?B?U1RjSWcwVjRJZkFLRlhWK0ljM2VzTW10emtTMGVYemZXbFpNZS9sTytrNjFs?=
 =?utf-8?B?NGhLSkpwc2l1emoyTHhhaWhJRDM5OG56YzBsUXlZZm9XQVZHSlQxckFQQWdl?=
 =?utf-8?B?MVR5ek1TMzlqZ3VCbzJ3bFpDeE83ZlNRbTBmdmx4enpOY2VuK2lENTVVVWwr?=
 =?utf-8?B?UHhYWjdFeHFBQUdIZk96Z2NQMk12Q0sreGlHQnFZSDJFSmYyUHBJV2VnaTM4?=
 =?utf-8?B?NmJnV1k1TXllOHZsQTNFVWVUc1B2d2NDRkY4L0xvanl6dVNyZG85emZRbS9K?=
 =?utf-8?B?OWY1cXB6dDhXaTR4OTZCMzZ5cCt1QjA3UEx5QnBacDVBUzhkYlozMmVRbURX?=
 =?utf-8?B?bEtjcFZPdDVyWW1mcWNyR0FPY05naWQ2TldRVjRPN21sVW9LazM0aTErZFBL?=
 =?utf-8?B?cUxqREs2Wk93Z2FtZmtYOUUwQVdTalpMQldIY3NYdFBhalp6MmNVVk82YUk3?=
 =?utf-8?B?ajRkb2hoYzRxbmp2TXhEd29BU25zaU9Xa25UQW1CcXltNmlVRmFINndFNUph?=
 =?utf-8?B?VUdaZnpva2FNcDdPSkFrSEFEMXJBRjNmVThIQldKU1dRYXFHMWpYa2t3Z2s5?=
 =?utf-8?B?TDYyYTMvOUxCVTIyYkRJdmlidVF1K3FBWkE3YzU2TVJVejZuVStkc3FpSmNY?=
 =?utf-8?B?NExVMWh4cmxYalJKMUFQUUtJZGIvRG5JTE5pN3FRamc1a0o0RmhQRWlJeHR6?=
 =?utf-8?B?bjU2R3Jpc2trN2hYNWhNeG5wbnRTSkhBVlVkRjBSSERzTzNFUnBxcjc5dEI4?=
 =?utf-8?B?dTBueGU0WGZQTW1LbEgyN2t0VWxVTlc2UXVOWE1ZMndFcHNVVXBjMzdFUVYw?=
 =?utf-8?B?SWRsamk3K203REp3OFdpKzZTRi9uMmF4QjY4b3ZnWGRDUnJEV0hkazlNRDlh?=
 =?utf-8?B?UXBYeTh3U3pJM1Q3elRMaGhJNEUwY2VwODRteko2bGVGTHg1R3dpNFFqK1c2?=
 =?utf-8?B?MzhpTnFTRHdncmo4TWY0SkNFUGphNzJKdHJHaUdCdEorWVlVc0svMVcwRTl2?=
 =?utf-8?B?cDdvVVc0bkEvV1JHaW92SGhuTFdaZThlUG5KVUZHcS81bEFTMmZISFIxSnlN?=
 =?utf-8?B?cWZBaXFRb0dSRnhIenQrTUU0OEYvMjRDRjZnanRLTkFQbXNEVU84RmtjUnE0?=
 =?utf-8?B?N3orY3hYTDkxNjY3aEZNS0VLdFJZeXJYeUxLUWQySkIyRnJWWVYxVy9TWVR2?=
 =?utf-8?B?akVaZ3lFMDlGQndmOEM4bnN4c1BSY0hoYzlHbzJHWFBXM2NYQjc0U3RRTDAv?=
 =?utf-8?B?N2EyTFBrdGJSWXlQQU9rbXBiOWZWeVI2NnZlL0RlUlhRWXJXSkp0cVFHZlA5?=
 =?utf-8?B?akdvOHEwTjY5VnNQRUY1RjZZajBPTkhWbCt4Z3A5YVpXdXJ1QjBvY0tIZW45?=
 =?utf-8?B?R2F3Ykoycm9oY1ZsMTdKUjY2akF6SmRseXE5TitYdjN5NW9vU0RQNlVEK1N5?=
 =?utf-8?B?blJuYTJzSW5yV1puOWpad3IremZBOXl3aXdJQnBNYjdKYlhGRVZYZ0hmM29y?=
 =?utf-8?B?eEZBSlRVRlZ6ekdLcUZJOC9Iemp4UE1OY3R4aXQxRlNUM0NzeEY3dHpwRkYv?=
 =?utf-8?B?aGpJZmZhUmxJWitQamVPbVJicEpEY0d1bUN1WFBvenZyb2xmUXpuVm12M1NI?=
 =?utf-8?B?VVhzV3RwNlNldVBIbmJ0aGFFRmFxT2lIMWxndTNLeitZWnZBZW9JcXZEWGl1?=
 =?utf-8?B?L2wxaS9DMEp3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TExsQkhIbHQzbWIrU2xTWGpYaUNIOWhKQm9qYVljQ0FITkFXZll5VEw5SmxH?=
 =?utf-8?B?WUxralJqaEZ0M0k1TTRZOEEzejU5d0JaV2RVZjVrbThWQndldVdBMGNPSS9x?=
 =?utf-8?B?d0lZQ3FHL0ZhVUxIN1lmVTR0MVhDK0VDcWFTWjhrcmFEVmlPd1NEK0FIUjJM?=
 =?utf-8?B?SU5EOU1kTkFHdk9FRUhsaFI1amR0SnUxTG5xSU5Hc2JRRkhzNmRyVjAyOWk0?=
 =?utf-8?B?UkJGUVhOdnRXLy9Ka2FpU1VBa29qMGxYVytmalNGL2xJaks4ZjErckpSWnJH?=
 =?utf-8?B?WlB3N3NNRzhveG50eFZnZXkxenliWGE0RHJyVkJVaWVNeUYwUlVEL01WbS9E?=
 =?utf-8?B?TEdDQmZTVlQ0NkVCTVdlQ0R4TWpHUzdFN25EYWRBRXRvVEJ0OElYMFNrMVhG?=
 =?utf-8?B?bW13bkI0Umdjdkg1cmpoY1pQRDNjbFpud1paYXI1MWZvWDBuWUxoRjZVaXUx?=
 =?utf-8?B?QVB0UmtIUTd6bEM0ODkyMlZvcVJIaXMrb3ZUSVA3T0tLamNYZ3JUYVRLM3Vw?=
 =?utf-8?B?aGwwTEZiYUR1VlNIeFZRbGVUMTQyaHJ0MzcrQTlqMjJ2NGtYL0kwaTVaakpo?=
 =?utf-8?B?cExrYm1PQkErdndMUkQzQ01Jb0xocENsU2l5dGtubC9qVFhvVG5WcHY2WVR4?=
 =?utf-8?B?Zy81emlHS0FRbE1qNWxVZjdxNVQ3OUpnVnl6ZHQvMy8xZjNvYW1tUjhhLzNZ?=
 =?utf-8?B?U0wxbXIwcm11R0tiRnZZUExCN0pkbjJpWi8yeWcrbzVBWVl4dS9mcWR6QTdK?=
 =?utf-8?B?YnNZajZsODVndFBqZXRNZDlrZG5IMTJPbllaeU1TSmZTS2V2SjdITFNYNlpn?=
 =?utf-8?B?VXAvcmVJMTBTZ3ludHV3SERYUVhSNEFyN0luYzBIcElQcVJUdHFKbnhiMDF5?=
 =?utf-8?B?QmpiaDVTV29XMmt3Q3M0RkRycVZrYWxITGtVNzQ0dE9VekVXRFBjakhLQldP?=
 =?utf-8?B?bEJkZXZPS01SQllWTEVqS3puait0YWJwQ2Z0YmRVZldoVWh3UFBOYmQzdHhZ?=
 =?utf-8?B?ckJqbng1TmNhN0NjL0tmdWhyclZlSnpqczNPM2dLVFN0Q3N5R1NGWnFHMXpp?=
 =?utf-8?B?dTQ1WWJDdExISU5wUTFGenZPTEdDZUhKNEVhUHc1OHd2NDhIZUppbjNOMTRz?=
 =?utf-8?B?ZU9kbklhRGxwa3ZiUDFZYTNnN01IK0FXS3BEbjdWM3crZGhYTEozVWV1NHlY?=
 =?utf-8?B?ME13Nm5GczhNWVE0bjZHUk85UDY1cEMxUmNFTkZoWnJFYXFJNmNvcGUzODl3?=
 =?utf-8?B?dmE5VzhIU2RNdERoQXJkQkhvTjJOMTNDUXRXL25NMUJUUTAwL29FS3EzY1VK?=
 =?utf-8?B?d2RIRnpObHF2QXJ1cjFGdG56MWlqN2w5c2MwQW5nVC8zeFUyTlpWUGRmTkFt?=
 =?utf-8?B?VVJhUlRuSlV5U2ZSSFFucXB4ekhzLyt6UXNDcWVtSTlJNzR5VGRRbmpCV3dH?=
 =?utf-8?B?cS9SQ3RQUmY3VVZnd0YvWTZXNSttY3JFZ28weUttWVJIUlMyWG1sWm1xV2l2?=
 =?utf-8?B?NFR0ejJ4YnhRSmE1VVU0SUdUUGNSUCs0NmEyU05yWUwwTWg4RnVtMjB6WEx0?=
 =?utf-8?B?UWcvRk8yVnlta1lwSnhVejFRUUtpaWNjeGVoNWh0ZGs1QWtNOTFqRytHaDBl?=
 =?utf-8?B?elFMZzB6M09BVWpLMm42OXY1UHF5bUM3cXdxMU93M2RYQkFsNTY2RktSWTZY?=
 =?utf-8?B?TXFRRHNXWGpPV1ErWTQzVzk5QUFsRFEzTm9YZ2xNMGJFMHd3c2ZNNUxGelhr?=
 =?utf-8?B?eHY4eCtRbmxZRHdjQnRQWTA1WDhUODZtMjc5QytJR1JoWWtCRzBmVUpQYVI3?=
 =?utf-8?B?T2ZNUU1Nblg4MUtpNVdscTJGZmd3NHhYVVB5WTB6RVpIdkF6Tk5qQWN0UEJU?=
 =?utf-8?B?dnNTTG1JR1c1dG1ReFhmUFBJaVZuS3IvNm8ydTJFenVaTHFpb0syOWZTWU95?=
 =?utf-8?B?ZGIxb0IrcE0vL3QxTjIwUlpaanoyTmJ2ZDM4QTQvcDBMK0F5ZkNmQVVVNW5y?=
 =?utf-8?B?QWVlVFdHcEVDRENFWDQ4eFlrRlNSb3ZYRndBL0ZjbDNDaXBLK2hNRkZ3S3Mw?=
 =?utf-8?B?Q2Joc0ZGZ3NiVmxMdXNYZXpEUFdjRW14Z20vdWcxT1BCd0JYL0ltaFl3OUhR?=
 =?utf-8?B?ZkpCNlJaY1NkTHFwa1d3QzdQMEJEY1A5THg4bHhWUUJaY2E2RlZMUWR6VDh3?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fcde2a3-bf59-46c4-f82a-08ddca3415d0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 21:58:41.0841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zXASmHqDyEfLmDf26XRHjxYETX7JBnjg3uy9N5fzgpEpW+UqU5fMOARthS3I/ZyiRccVjiWG76yvzKNV2umCOM6lpwebDH0DFlAKLlNHfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7209
X-OriginatorOrg: intel.com

Terry Bowman wrote:
> The CXL driver's cxl_handle_endpoint_cor_ras()/cxl_handle_endpoint_ras()
> are unnecessary helper functions used only for Endpoints. Remove these
> functions as they are not common for all CXL devices and do not provide
> value for EP handling.
> 
> Rename __cxl_handle_ras to cxl_handle_ras() and __cxl_handle_cor_ras()
> to cxl_handle_cor_ras().
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Perhaps this and any other pure cleanups can go into a topic branch for
6.17 so that it does not need to be sent again if this set gets respun.
Dave?

