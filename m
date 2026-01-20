Return-Path: <linux-pci+bounces-45282-lists+linux-pci=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pci@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHeJIImub2lBGgAAu9opvQ
	(envelope-from <linux-pci+bounces-45282-lists+linux-pci=lfdr.de@vger.kernel.org>)
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 17:34:17 +0100
X-Original-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C96C47A84
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 17:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AFDEB56D16A
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 16:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912DC2DB7AB;
	Tue, 20 Jan 2026 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dzgbkusb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8C131D735;
	Tue, 20 Jan 2026 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768924775; cv=fail; b=Dj4uJgxXVCXVdnZwJjBUXJgmxT1xB6T1HbvFO16/W+RReCdxjwwnXZzUBI6BQS/sVHyncQA9h1q2D3IvYDjtlYe8yVpYKc0DK3dwTdjjnS6AIBeLKCsmHl/45HnQH+94RQQETzSkqwknsiHUcZLqQ8OVmH6knv8PkPh1XLVGJ24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768924775; c=relaxed/simple;
	bh=+hYp+rEIf+gy3iHKoJyzscXmE7ja8N1LMfix2kaubEA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YAtrDcqCKwTHyXmj/wwy1voxwHCZBcaTvWDuRhtmV9BXanNCyAJaZvVE6iNVED6AV4t+6Ech0nnphICIgeOIOqKmlH3Rr1Zwe4o+9NL24wYh88QKvxLX1AyiHKRq9LSaP3njIjgvJN56ldfx3jU4jFM0hMA+cJHiQeU32XHqbhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dzgbkusb; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768924774; x=1800460774;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+hYp+rEIf+gy3iHKoJyzscXmE7ja8N1LMfix2kaubEA=;
  b=dzgbkusb1vkatn6dPPJxFptWn6lDbay8b3lzEkkHsTHqhm9Orca4pnhQ
   Fubvdc6KvSryEFA2mODfh8PQvvMhBLxu6zIZ8eQa/lPQZy5ckVrZ9uQ9x
   M1LBVE248Rzz5n4vUKCQWT9FdoyQ1UiAdHRVaMJMDzDD6xW/3I+rAXeyI
   JB9YpAMZkG6R3UCjniIU+RpAvvl26huXvsTLRkNGGAktE3zy0hEIker7W
   Q5vKdwK5pd0CaZtvZ69R9xProB6532zcwk5mBT1FVuTZ3fAB+AkK/Md/E
   K8UqUQClqoqTL1o+BAEASJUofrQ/Ut0zLz2z4Njb2y/urKh5RsQ92bEpn
   w==;
X-CSE-ConnectionGUID: JF/YZau9T6Cyq4uFdPFmVQ==
X-CSE-MsgGUID: VBHhzK88SL6WKFUT9WVRiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="57696738"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="57696738"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 07:59:32 -0800
X-CSE-ConnectionGUID: gqcpkxooS82civpgrpwIyg==
X-CSE-MsgGUID: 4liQo9vYR9mQaUNSOJiAEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="205771278"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 07:59:31 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 07:59:30 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 07:59:30 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.47) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 07:59:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyfUpBYoQ2j9QFiqvYnCsmSrP8oIaIRbWOx07cc4dgUXfG/Q9s11ljnTKaZE1KK4v1gMAEdrShbTw+L1oztMgOhslNypnFzMEFCT5yN6/JqXVqvyElG9UBSNyqpDlzVDBo4acE86Ip1GliPwOPqW6ySnygOW5wyEud0CRFvDUQrNSmPS/4Yo9TM7BPtliyg7zyk6vGcoFjCa5wosBuJTdYB0aGA3Q97/d4oNYZFciWl9vuH4/8+BCzhQh2hT1o4JGVymWVLI5jAaUFtlrGHY3iVNCSbBhnO55Ha6SUCh9Uxf84UT1lUKQVZHfZBvZJbEqSOt5Q4MMj/GKlzRYEx1fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5kgz/4mJ65avMn1ic8ID/O2rFBhXYqdXUIYZl8eaTfY=;
 b=tBA17rKRuPECgvxquP5uaKMDvzJWIXISdqR8ljwFNbE5Y7jpuXo/onmS/TSvTCEqVyq04t82rprpzRDcKYLlpASxJFozPrgWrQD/DUxOwKSdP1gzAl3kWeYsOPDMrk8Oxtkj0lXNTOBpUIDaXQPbHeNGXaNlG7xLL9jeu2Xi2y6tAnMXcwaLdZUqj//TMadcSK5rSxsEUm8/i+ozo7O8Fzp8FrwPOfigCo+y5ginVWVWVaB72oHHgdw9DL924Tx0qAYHCT79kbQVLa+fnNA5fCJxolipq8MjTUoCN8PG11HGEUjNmnLnvnldXPl+onI4kKOzncpzIBim2ranHGxixg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5530.namprd11.prod.outlook.com (2603:10b6:408:103::8)
 by PH7PR11MB7594.namprd11.prod.outlook.com (2603:10b6:510:268::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 15:59:28 +0000
Received: from BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::1451:ad37:6612:37fb]) by BN9PR11MB5530.namprd11.prod.outlook.com
 ([fe80::1451:ad37:6612:37fb%4]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 15:59:27 +0000
Message-ID: <531f2fe7-7a17-42cc-8747-ea122fe1c95f@intel.com>
Date: Tue, 20 Jan 2026 21:29:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/12] PCI/ACPI: Add PERST# Assertion Delay _DSM method
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <intel-xe@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <anshuman.gupta@intel.com>, <rafael@kernel.org>,
	<lenb@kernel.org>, <bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<rodrigo.vivi@intel.com>, <varun.gupta@intel.com>,
	<ville.syrjala@linux.intel.com>, <uma.shankar@intel.com>,
	<karthik.poosa@intel.com>, <matthew.auld@intel.com>, <sk.anirban@intel.com>,
	<raag.jadav@intel.com>
References: <20260114195516.GA830795@bhelgaas>
Content-Language: en-US
From: "Nilawar, Badal" <badal.nilawar@intel.com>
In-Reply-To: <20260114195516.GA830795@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::6) To BN9PR11MB5530.namprd11.prod.outlook.com
 (2603:10b6:408:103::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5530:EE_|PH7PR11MB7594:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e2bb0b-e659-478f-cf45-08de583ce3b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXUrK1Q1dS81b1doc3hTUU5xeVFXSjU1c2JZVmtrY2JPTGduckNEU0Fud2c0?=
 =?utf-8?B?bXVyeitDNE9mc2pYeUl2ZDlURHpVcmdydmthQWZ4UlNqQ1VZNnVrdWJRMjBq?=
 =?utf-8?B?VkRIYzhvakIzcVk4Z0hzMVp5eTJGYTZvTFZGaFlRcXdsVTFIR2ZOSGNxRkxQ?=
 =?utf-8?B?REZXMmw3VmtiK1dQd2hxYlZOMXQ2OWdPNGRscGdDRGxrWkZrYmxyajR2SXhu?=
 =?utf-8?B?Tis4b2ljRHJSVWxhc0oxZkdNZ1BUOG5xV1EzdXVVZjZOV1JaMGowNzQ1emNt?=
 =?utf-8?B?Ui9DeW12VURac3pva25JV25BYWtTM3ErQ0ovMVd5d2h5VGR2NmRXM0gzREZG?=
 =?utf-8?B?eUhMSFRVc1RKWUEyZEFQVnM3SWJleVRJV0FrMVdkaENqLzJjL254R1pGaXQx?=
 =?utf-8?B?VUtIVmY1QmI1WCtsSkY2RUcxcURGNTBvcVZscjdaYTJuNHlDc0M0eXVWNllu?=
 =?utf-8?B?SHRmZCtMTmdXbmJFc1BxR3BqWnJiN2p6dWo0VWZaeG53VmRqdWdod1pvZ2o4?=
 =?utf-8?B?NzcvSXpJeXIzaVU4L3BnREpuVHg3TjdXM0tPYVVMWWYzeXZ0dERFNmVhaW1L?=
 =?utf-8?B?NUtKeEExOG9ia3lCZlJRcUE5Sm5tVTZMRytGTE5hbEhuRmVKcnNwQlhZdFgw?=
 =?utf-8?B?RDV3czhQb0hySjdGMVEzczdKOWFJem02UHdoMHdpRUF6TG1IT3k4NmZJMjFo?=
 =?utf-8?B?cmFHUHhRMzNoTkNiYk45dVRKUTZTaVFlUWdVYkVkbENyK0wxQURGWloydDJQ?=
 =?utf-8?B?Mmc1N3UrcHAyOGpHdmdxTVY5anlEMU5pMDR1a3FBS0ZubFhST1hnaEQ5bW8z?=
 =?utf-8?B?eG95M09ZN3JrUjdGS25KeUNuaUNvZVM4cVNMNW9uTXpzK0gwRTF1RGVteUkw?=
 =?utf-8?B?QW1mdlQ2MndZcFJIb3RBaktFQXh5RlhHSW42Qm9hVjFmNmx6VlpLMXNQMWtZ?=
 =?utf-8?B?eFdKZ1B5RldTOVVwVXl6c2xaeUw0M1RmTmpSMWt2ZVY1Z2xDbTYycXJqUk1Y?=
 =?utf-8?B?SHhxdU5MZDRjdXhXRGZLYUFhWWhpMXhMNTJJREhqOXFKekFhQVZQbXk3SGpj?=
 =?utf-8?B?S2FZbjNvQVFUS2x3alRsVzZXM2FvSTZiNjNtU0VrTDk5ZVFPWXA4NU83RjRK?=
 =?utf-8?B?alVMYjQ0Y3ZvRTRCNTZKaTNHZ3A4MS9DSW84NlV3eXVOc2JLSGQxRHVHeXhL?=
 =?utf-8?B?Z2hWL01Ca2dNaFF6MzdocGVoblR5KzdoMlR4bVRtaU41M2pvL3BuMlRoZjNF?=
 =?utf-8?B?TXZXMFRFOEVLWEVOcGNMaWd3NWFnNTdXdUxpYkt2b3AxZGR6ZFVrU2JnOWw5?=
 =?utf-8?B?MWIxMURCZGJaT2V4TFRGc2tCdENyWlRWTHFwdWNNQVpoakhhbExlY2hrQWhM?=
 =?utf-8?B?eDVrZkhyRFBvSmZ2N3R2TGgrQzQwbWNBOGZ4bkE5SzZLMXhSK0JMOHYrVEZw?=
 =?utf-8?B?ekR5YVY4V2I1cDhtVGJMczZ5MldNclFWUzB4OUd6a1NCY2RKWUpaZythZ2ll?=
 =?utf-8?B?Mnc1RU5pMUx4M1gvV0g0OU5uYUtBd3JWSWxpanRhNkpCamRNRm9idG5FWkNx?=
 =?utf-8?B?RGpwQndjSmVjVThvMWxCdmtXcUlidFB3dFN6WHBDMkUxRkdPbW85Q2kzRGR2?=
 =?utf-8?B?WjQrR25VZFNqS1JJa0RCSEtFSmxXR0hDVEgwYTJYWVNweHR4NEViRWVZQnNF?=
 =?utf-8?B?K3lKWk83ZTZmRDYvSFQzTUo1NytrQ3JKeDVwMEppYURJY01rT0UxWlM4cFlk?=
 =?utf-8?B?Wi9wTXJCUkJIMmpaUTh6ZUVBQ1Q2bXBjZlIrd000a1FVc0pKQWhvQkZxakRJ?=
 =?utf-8?B?TkxEY29YUEhRUlo1SEwwdytrVjkxZ3dJRWpMaE9JSXJQTVZxSGxPQWxPUmVj?=
 =?utf-8?B?UWs1VlVNajY4d2F0VEhDcnI0N05PZ2g5dDZZWnhkcmgxRE5LWlJ5aWxYdk03?=
 =?utf-8?B?cStpcGI0UjNOTmk5a0c4Yng0eTlOY0R2eWRnY1NmajFnajVpYlpRNHYzaWlZ?=
 =?utf-8?B?ZjRQQS8yYzVDQllVQ3lJZC9jT2JCVjlRcktoWWhhbWVWQnZmUFYwOXpVLzl4?=
 =?utf-8?B?MDNUVFY3bkZIRGk3YVlmZ3R3STRhYlRlNlh2TnZDVlhYMW9lSVk3VUgzWDhS?=
 =?utf-8?Q?EVH4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5530.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1dJUmt2VG9IS1BDZnl2bTIxTSswaS85cXFHWS9aNnpUdGphWExjRGxRQWJC?=
 =?utf-8?B?MnhuN1dWTlFGRThieXExcUhSdEoyUzRYdkpsbEtVQ3JOS1RGU0JQV0ZzUnZ1?=
 =?utf-8?B?OWxPZElDcXdZSkFlS0xBbG90aUQyK3RTdkxTQUFmMmVuZkUxckkreS9qdURL?=
 =?utf-8?B?ME1PRnpqNU0zclV2STh0TkZaanVLSnZOSEpOVFJBOWxFTDh2TGViUmFQbnc4?=
 =?utf-8?B?SzNicFRra21YbVYxRnZpOGdhVjJxS3hXY2hIZEgxelJWak1IQVlua2ZVa3ha?=
 =?utf-8?B?N3YxeUhyTzdoWVRuR3F1cCtXV2pQMFhta1JqVSs1dEJQQ1hSb0ZSMmFCNXFs?=
 =?utf-8?B?UTRPOVZ1T2dPRUJMZFpuK3VzVFFWdFMrVEZQU1VqNHBiR1FvbmdlQjRnWXd3?=
 =?utf-8?B?VVBkdG5JYWVJTTRpSTVsMjl2N3lEcDJqaklQbkJrMDE4alBQQkNZdk9UbmJ1?=
 =?utf-8?B?bm0vNG1HR1ZTMGU4UVo5SFBhZ2F0MVlFVmt4TTZOeEMybHd5TEFBVnRSeTJW?=
 =?utf-8?B?aDJXWjE1T2VreEluWVV5a1ZCY0RLeWE3dWpYVFBidTNDM1VMRGsxNlUwaEgy?=
 =?utf-8?B?aUowNEJFSXNGbVE3bXRoNnE0eEdVYzlZbjNOSnIyZzN3U0MvV3FyYWtGMURK?=
 =?utf-8?B?c2NaRVVYQjVBZ3dpZmJXSXhOeWwrMmpjb0FrRDFOMy9yUkw0dzJIK1VlZDZu?=
 =?utf-8?B?NzVUbmo3NEZaN1RHYmFhYlRPdHkyOGtLUW94Q1FneU9qVzlmZjg1WnVtV2d3?=
 =?utf-8?B?T2NTUk9WYk5aYXExRVloUHVnQVgxMzlXbTlBV2VUbXBENVVBN013UzhPclRT?=
 =?utf-8?B?eGpHNGwxUTMyc0psOFhmWG9zMU53Q29EV2pjeWYxQVk4YitDQmk1MExRVmh6?=
 =?utf-8?B?VDlacUZpQXJxL0VkblRUTlYxSytqdlNzSUZZQ3c5QlprRUFoMCtITVlTNUZs?=
 =?utf-8?B?Yjl5L0RyQjAzZnhwVm1ubENTSW5ZSFBMNnpwT0Fyejk0SUJCSkdIazY0MVFS?=
 =?utf-8?B?WGFEYmZWQ1VBSFRCQXdsdkI0amxtaFBiTkdjZ0ZXWVJXWmhTQzdjZnZ4V1NQ?=
 =?utf-8?B?Ky9qVWs5cEFUV3RVM3liSWdOemQxdThhNXpvbytnR2NvMStaN21UVCsxQktn?=
 =?utf-8?B?WlhzRWhpbjhadkV0bTM2R2pCY0hoY0FCZmZ6R2F1US93Ujg1b1ZpM09udktm?=
 =?utf-8?B?bHppakh0aHBNem5LZ3FvMnBtR09RNDI4VnExZ3kvTmVMVnFFMzRMRzdpZUJ3?=
 =?utf-8?B?ZEFzVmhZZ1J5c3hLRXBxQ2xLQVlCblBocTVqS1E4VGJUaDRkanAxYVVrN2R4?=
 =?utf-8?B?S2phY3YxN2IxUHoreU1IRGV4UHlBSFNhM0R3NnJYdjBRRndLVUpiR1FTenNQ?=
 =?utf-8?B?Q2Z4MTNwUGxVNEFZNGNTRW13a3NvNlY0eUpEbDd5U29hUFd6c0hUUGJLWjI0?=
 =?utf-8?B?MnYzUWd5VVBmUWNVc3lzQ2R6dCtkWjkxRHlCSUgwOFM3VDdRZnFScU9vNVlO?=
 =?utf-8?B?UkZxK0dOSUY0NlVxakUwWkozOE5iR1pOQXlheHA1azh4aTRpM2RMZjNmdDAw?=
 =?utf-8?B?d1hONTlLUUUyV3hvbU0rTW1WM0pyZ1pBM2l0VTN0K3JndXJwMUJKbHlqUGZl?=
 =?utf-8?B?RE5XNml4TysrRWF5SkVZdWNwc1M1V0QvTS9URGJuVFFPUHp1SU56Umh6aVFn?=
 =?utf-8?B?ZUNDWUhSQXNJVHJXM0MzdkswQmFUUEdpYkhDakdDcXBROGMrczVpWU1QYlhp?=
 =?utf-8?B?dXFXU21wMDY1VVUzZWRvTEY0Y05uSGFQODYyOHBQOUJhQlFTMkgzbUxNQ0Jz?=
 =?utf-8?B?bjB6dll1bkgvOTRiUGs0UlgrY2t6Q3VobU1mWDVVbnM5TVVvSmZyMEVDMlM0?=
 =?utf-8?B?NWZTKyt5Qi8xbmJqTndid0dTMVhGa2VrVk5WVjFDRG9NcnFab2tFWXlLckdK?=
 =?utf-8?B?bUlGcUxWaERTbTcwb1ExQTcrUG1JZm90bi85LzlCeXpDVm5iUkFST0Mxa1Zr?=
 =?utf-8?B?RStUMEZhT3BUSEE0SGVvc05JbHExMSt4S3BwcldRVFBSaGp5OFhJSldnRTJW?=
 =?utf-8?B?VGY0R295dHAybkZKSG5jWFYzSjF2UmpuK2VpcjhtWDBjenlmbVI5cFdmdVNJ?=
 =?utf-8?B?QzQ3VUdtQmUwWFNtc3ZUcGszNmtpUEVqZWljL0RkamxyYnZQb1hvMlJua2dw?=
 =?utf-8?B?dWw5dUFuRlhKTXFkNndUTUo3U2JJRmVDSEtoK28xQ1EvaUZJTHZMNGc4QnlK?=
 =?utf-8?B?OXVHZXdjZ2FVdG9rbVlRRG55UXYvMjlzMURka3lsWG1VOWJDQnNVRElqY1g4?=
 =?utf-8?B?ZnIrTGZtd20ybTQrUlBsYUhIRDJTRkVvTUNaaGYwcDNQQ2NhZXZDZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e2bb0b-e659-478f-cf45-08de583ce3b4
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5530.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 15:59:27.8375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DDt96H+PtedBulD8JHvrNUh8A0GzphKqU78YL+iF2EGytAIWo4plvfr4a7TKbNVGfu40SDOOkKnOE0fJe6Tq7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7594
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-45282-lists,linux-pci=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[badal.nilawar@intel.com,linux-pci@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-pci];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 5C96C47A84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 15-01-2026 01:25, Bjorn Helgaas wrote:
> On Tue, Jan 13, 2026 at 10:12:03PM +0530, Badal Nilawar wrote:
>> From: Anshuman Gupta <anshuman.gupta@intel.com>
>>
>> Implement _DSM Method 0Bh as per PCI Firmware r3.3, sec 4.6.10, to request
>> fixed delay in timing between the time the PME_TO_Ack message is received
>> at the PCI Express Downstream Port that originated the PME_Turn_Off
>> message, and the time the platform asserts PERST# to the slot during the
>> corresponding Endpoint’s or PCI Express Upstream Port’s transition to
>> D3cold while the system is in an ACPI operational state.
>> Host platform supporting this feature ensures that device is observing
>> this delay in every applicable D3Cold transition.
> Thanks for this work!
>
> Add blank lines between paragraphs.
>
> s/D3Cold/D3cold/ to match other uses in drivers/pci/
Ok.
>
>> Co-developed-by: Badal Nilawar <badal.nilawar@intel.com>
>> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
>> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
>> ---
>> For VRSR feature with PERST# Assertion delay device will get enough time
>> to transition to auxiliary power before main power removal.
>> ---
>>   drivers/pci/pci-acpi.c   | 60 ++++++++++++++++++++++++++++++++++++++++
>>   include/linux/pci-acpi.h |  9 +++++-
>>   2 files changed, 68 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index 645d3005ba50..73eaee20a270 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -1554,6 +1554,66 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_mw,
>>   }
>>   EXPORT_SYMBOL_GPL(pci_acpi_request_d3cold_aux_power);
>>   
>> +/**
>> + * pci_acpi_add_perst_assertion_delay - Request PERST# Delay via ACPI DSM
>> + * @dev: PCI device instance
>> + * @delay_us: Requested delay_us
>> + *
>> + * Request PERST# Assertion Delay to platform firmware, via Root Port/
>> + * Switch Downstream Port ACPI _DSM Function 0Bh, for the specified
>> + * PCI device.
>> + * Evaluate the _DSM and handle the response accordingly.
> Add blank line between paragraphs.  Actually, you can just omit the
> last sentence because it doesn't tell us anything useful.
Sure.
>
>> + * Return: returns 0 on success and errno on failure.
> s/Return: returns 0/Return: 0/
Ok
>
>> + */
>> +int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us)
>> +{
>> +	union acpi_object in_obj = {
>> +		.integer.type = ACPI_TYPE_INTEGER,
>> +		.integer.value = delay_us,
>> +	};
>> +
> Spurious blank line.
Ok
>
>> +	union acpi_object *out_obj;
>> +	int result, ret = -EINVAL;
> "ret" is unnecessary; see below.
Will take care of this.
>
>> +	struct pci_dev *bdev;
>> +	acpi_handle handle;
>> +
>> +	if (!dev)
>> +		return -EINVAL;
>> +
>> +	for (bdev = dev; bdev; bdev = pci_upstream_bridge(bdev)) {
> I think bdev should start with pci_upstream_bridge(dev).
Yes.
>
> IIUC you intend that "dev" is the Endpoint or Upstream Port for which
> a driver wants PERST# assertion to be delayed.  Per sec 4.6.11, the
> _DSM must be in a Downstream Port, not the device itself.

Yes. _DSM is in Downstream port but not device itself. For VRSR use case 
_DSM
is in root port. From the description, my understanding is Downstream 
port (bridge/root port),
which has sent PME_Turn_Off message, will introduce delay after 
PME_TO_Ack and then initiate PERST.

>
> Sec 4.6.11 also says we should track this per Downstream Port and
> request the maximum of delays requested by any child.  So I think we
> need to:
>
>    - add a perst_delay in struct pci_dev
>
>    - when we find this _DSM, set
>      bdev.perst_delay = max(bdev.perst_delay, delay_us)
>
>    - pass bdev.perst_delay to the _DSM instead of delay_us

For vrsr use case delay requested is 10ms, which is maximum allowed by 
this _DSM.
I think we should take care of above suggestion when we implement aux 
power aggregation.
For now, I can create another list let's call it acpi_perst_delay_list, 
similar to acpi_aux_power_list, and
allow a only one device to request a PERST delay.

Thanks,
Badal

>> +		handle = ACPI_HANDLE(&bdev->dev);
>> +		if (handle &&
>> +		    acpi_check_dsm(handle, &pci_acpi_dsm_guid, 4,
>> +				   1 << DSM_PCI_PERST_ASSERTION_DELAY))
>> +			break;
>> +	}
>> +
>> +	if (!bdev)
>> +		return -ENODEV;
>> +
>> +	out_obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&bdev->dev),
>> +					  &pci_acpi_dsm_guid, 4,
>> +					  DSM_PCI_PERST_ASSERTION_DELAY,
>> +					  &in_obj, ACPI_TYPE_INTEGER);
>> +	if (!out_obj)
>> +		return -EINVAL;
>> +
>> +	result = out_obj->integer.value;
>> +	ACPI_FREE(out_obj);
>> +
>> +	if (result == delay_us) {
>> +		pci_info(dev, "PERST# Assertion Delay set to %u microseconds\n", delay_us);
> I think this message should use "bdev" instead of "dev".  I know the
> request is for "dev", but the delay connected to bdev and applies to
> all functions below the Downstream Port.
Since it is set for the device which as requested I kept dev.
>
> Wrap such that the string itself isn't broken across lines, but the
> "delay_us" is one the next line (as in the "failed" message below).
>
>> +		ret = 0;
>> +	} else {
>> +		pci_info(dev, "PERST# Assertion Delay request failed, using %u microseconds\n",
>> +			 result);
>> +	}
>> +
>> +	return ret;
> No need for the "else"; we can just return error early and unindent
> the normal path:
Sure.
>
>    if (result != delay_us) {
>      pci_info(bdev, "... failed");
>      return -EINVAL;
>    }
>
>    pci_info(bdev, "... set");
>    return 0;
>
>> +}

