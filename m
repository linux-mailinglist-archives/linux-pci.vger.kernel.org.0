Return-Path: <linux-pci+bounces-25035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7EFA773DC
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 07:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3704B3AC010
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 05:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C79E1A5B93;
	Tue,  1 Apr 2025 05:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lrnfGo1K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4114685;
	Tue,  1 Apr 2025 05:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743485091; cv=fail; b=OtAx4SBuDhbEzJRZahKBzKXkOiLOd7QRubrTY25aRTPiHm86efA9gcmPNf6dBGb5cdKIcfn9L1O8cx+TopmZD7QH6ToLKgLjg/U6zaGCjOLli0+azCKozsgnfy3WjUkLpe2xmS1blWuBrVczWdXXiKuhLqiiWTRNwGPbgrn6YnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743485091; c=relaxed/simple;
	bh=b71GrkwZfb6Ysau8zyZMi43BFhffTH+n+9zs+tv2y8Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VeUKk3+AZEhV8tvwfllqwUs+PAv1+a9o2fRUXtevnkE9xfkkj5KVjlNin7bCEZDl5g3kyxW5nQxL/C0mgofAQWqhzmY2nWwo09c2BymyFPvlxvutVnJM3eeovV6v5xGxiVd1Ms7S4DrVnQMMJHVT39mPKq+1Me2khmRmjjIW/F0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lrnfGo1K; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743485089; x=1775021089;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b71GrkwZfb6Ysau8zyZMi43BFhffTH+n+9zs+tv2y8Q=;
  b=lrnfGo1K+aYpnqmK8eMbCMK0Ax3k88FhQsTuAuOjxvOYkBkoRGELe5Qe
   B1FKSdVNBr1xK4xAIXEXjDCbwk4qKSaVDYuf5m1ON+n/YzB9mZeC5JoBs
   iKyX2ciZR4Wt/LUEc9QAnnhSHogGw9tKhLK3WqDbmt9N5s+WxC6mgIdhJ
   P97jYRE9RrSW9I8XjlhbaKIRLo5Fz/heN4fyeQO/kLiU9RnyTjn0K098d
   CZThF00ddg+UTEDciKAAfufvmB5f2oEmMnHx0OHN5F6PCmh/+NjU2tFEh
   leU+tU6rtQ/FLTr6/3HaC2ntd+BPXpNI+ka33SqB4Ru2C0xygrjt0VOi8
   w==;
X-CSE-ConnectionGUID: 8cBTXNVPTXi5cr4XQdVZLQ==
X-CSE-MsgGUID: ZWGHNI4vQuqw3OajEq74EA==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="44963191"
X-IronPort-AV: E=Sophos;i="6.14,292,1736841600"; 
   d="scan'208";a="44963191"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 22:24:48 -0700
X-CSE-ConnectionGUID: nQcLmXs5Q6ixFJgiCaqzHw==
X-CSE-MsgGUID: AKeEEyvZQ2mttNZtNLrrKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,292,1736841600"; 
   d="scan'208";a="157193065"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 22:24:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 31 Mar 2025 22:24:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 31 Mar 2025 22:24:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 31 Mar 2025 22:24:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pyge5c9P5E2lAyKXd9nenFag34nFSMzDUi9xcV1vGikLFM89mxTW5rXdfyhYhQ7t/9VRxYP1/p7iodfgFhZQH3S5DWmnTHuZyDevY+eGzvq6F9JwZBXKDHFSVrcETWD6C3W0X7Z3BtQwxuSV5eLWsDZaB5DyFuzHsmL/K7T7fiSi/S/fq2QXLBPF1oNvgRixV5ytJXwiRfUko+RWfZyFZZ/jBscLpF+kkOeVpUEXacEpQlgvC8Fcf5hPhBtCUCqNlPaItcd7RQ7ti3Jcr4W0/SQYIheNTfQM02o1GE074atJWbN0kDqrBjlylic26HS4/z5u8hGWS+2N/BAq7alYsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNxafj9OAdnHQrIvtuZLJ+xkmGlunVjsxRW0OLTO3Co=;
 b=JJFXKSqvvtot7Pb6n/EtjU0jlplLtuwgjTT2mMGTtK8Scq+WTGhaN3qWKyW4/x3n7NLfpLzMiykNSg/Wu573sLytdjf+FEfUO5mthmUkFFXlDbJG6FIrRO4Hc1KP7rdifybLqq+8V1XvPq6pN5h+XO67uBE4jhKZpHUtSM3Um4QDw9KZt9WL4tzy9V+fvdwHgVhzRkd24xJ14fTjsjhH3nmE/Vv4SQlxmZCUnuZ4triolOFlxL2AGF/VLiH4/aEFZodDpDveAkGFBDFsxjju62oA+ca/FgJwzN3DhwlyDYOVYwBD6aeWn/FdKqlWeBH4WRel170RBay5XN+yeQQonA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM8PR11MB5703.namprd11.prod.outlook.com (2603:10b6:8:22::5) by
 MN6PR11MB8194.namprd11.prod.outlook.com (2603:10b6:208:477::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 05:24:32 +0000
Received: from DM8PR11MB5703.namprd11.prod.outlook.com
 ([fe80::f734:e507:3083:e454]) by DM8PR11MB5703.namprd11.prod.outlook.com
 ([fe80::f734:e507:3083:e454%4]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 05:24:32 +0000
Message-ID: <68e05f3d-96e0-40f4-b2af-d6e297195de5@intel.com>
Date: Tue, 1 Apr 2025 10:54:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/6] drm/xe/vrsr: Refactor d3cold.allowed to a enum
Content-Language: en-GB
To: Rodrigo Vivi <rodrigo.vivi@intel.com>, Anshuman Gupta
	<anshuman.gupta@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>,
	<bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<lucas.demarchi@intel.com>, <badal.nilawar@intel.com>, <kam.nasim@intel.com>
References: <20250224164849.3746751-1-anshuman.gupta@intel.com>
 <20250224164849.3746751-5-anshuman.gupta@intel.com>
 <Z88hR4PN2wuAhdE3@intel.com>
From: "Poosa, Karthik" <karthik.poosa@intel.com>
In-Reply-To: <Z88hR4PN2wuAhdE3@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::11) To DM8PR11MB5703.namprd11.prod.outlook.com
 (2603:10b6:8:22::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR11MB5703:EE_|MN6PR11MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d85fde-7e20-49d9-5c9f-08dd70dd7b8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnR3MTAxOG9sOHdrQVRKL3VlWUs2MEtacVgwenk5bFBWTFpHZUYyQUJuZjVR?=
 =?utf-8?B?KzZTWnpVKzdXQVlTT0xYZ3lBZ0xHRlF4TGJhZExRNWNNQ0kzTCsxZW9KbzNp?=
 =?utf-8?B?SUh3aUhkbHV5YUxIU1c0dWV0MGlsak1aVEJEaXVHYVJ0RzM4alhsb21NcUdR?=
 =?utf-8?B?N0cxZC9NbzZrVkpWTWxLL2lwdUxiM2xFLzBEYk4zR0RGVDFKN0xublNnbWVI?=
 =?utf-8?B?eldoUnUrNGQ5RDV5VytQMVZGWlRMT1NaUm5jVGdWNFE1eUdoVUhwQmNYOWoz?=
 =?utf-8?B?NEtGOWJYck5LM0lKUWp5aDFQbkR0N0pzd2FqeEZTMmhzNVl3R3N2MTRhODA1?=
 =?utf-8?B?c0FHakh3bnkxTjNnQWpiNkFINklnRUV1cnora2w5T2VweWlVY2hrV0lPSmlo?=
 =?utf-8?B?d21GN2k5Qmo2aE9aYnRUNWhvUG9BSzYwczZRc080eGxhVzZuMDZTaG9sblNm?=
 =?utf-8?B?Z3dwdDZ3ZHN1cXp6QjN2enJ3WEd0VUdwczh5TFQrVE5PQXpFMTN5WGVIYmNU?=
 =?utf-8?B?N0VTRWpHeUllK0ZlQUJOOGp1alc1Nmd2VVNrYWJmYkhDc1Y0UFlBNU5jQ1Nu?=
 =?utf-8?B?K2NoOHQydVJERTRySzlBOXVPZVcrR1pHN0ZDQ01PdnJGbG95SUNxWjdXQVc5?=
 =?utf-8?B?ZTA5d1BRdmxuc2R6REtxVVdsMTFQKzkyMFl4NE9xTDh0TmNaZzdITmZweDJI?=
 =?utf-8?B?MU54MmV5bnVoSDVZYlV1b0xJckZxQllqYmdSNFI3Um42R2VEeGlWamRNNG91?=
 =?utf-8?B?ZDY2R1NmdHhHWHRWNjcwRGg1L051VzEzNkpJT3JLRTI3SWtTZml3bGIrSlJB?=
 =?utf-8?B?OFVtUitwT1VEdExJclYra3p4TjZCdHgzbFhHZWNnd25nKzd6K2k1LzExNmsz?=
 =?utf-8?B?QzIxNXFqRVNxb1JJcVVhalVFWksyMHBkamhoUjFoL1RTVkNGOXY4TWs3b01I?=
 =?utf-8?B?b09IdGhrWnJlZDBUWkcwQ2hpUjBKY2cyM1h2em1iSzVuS3A2emJjWktqR0U2?=
 =?utf-8?B?dW0rNkVieGppUGl0Mmp0M1pJL2NwZ1BibkRyOVcwZEdOVnV0dlFrRkVSc0Zk?=
 =?utf-8?B?N2xmZmFIVWpjUWRCaWxaNE5saFpBaXdUSjhkTXI3ZFdaZTB4Y0l0aGJiTEJ5?=
 =?utf-8?B?aVpQOU5SZFd5UUVoWXYwNXlrSm5HZ3ZKeXJ2aC9HcEgwMmtyRXc0VDBwNGR6?=
 =?utf-8?B?QXhtcTRpb3IwWkZ3TXFyZThFaTV3QTJWVEFOdzlIQ0NEcWdsblE1VjRNTndh?=
 =?utf-8?B?cFJiSVUwd2VWVm1VNUlRaWxtcThVKzhHUkM3TlF5bWhkcEh5djlvamo1SjlB?=
 =?utf-8?B?aThpNVY1T0hiSWIvR200eEtCbFZZT0Z1VWt6bXlGdzlMWjluWlNwVnB4aEd1?=
 =?utf-8?B?a29UUlJLMWEwRU9KTytRUWRHSEVLbFdIR1JidlFLQWZXTzBFdC80MGtxN1Yv?=
 =?utf-8?B?ZDA4Yk9kUmcrTUdtWTMrUTQzWDkwNTliYlBtdTJGZWZ6bS8zUE1rSlhOcGtQ?=
 =?utf-8?B?bVdtVEtTQzd5MlV3Y0VuZkp1ZDNZaml0b1ZaM095amZhaEpqZHRmUzZtWlE3?=
 =?utf-8?B?VUNEc3VmQmNHelFEeElxRytURjNtRHFBOHY1dTljSXhrbkRRZS9CVTFDaXMv?=
 =?utf-8?B?Q3pDK29hMzMwT0tmUm9aS29EcThuYWdoejJMc3R0NTd5VHF4bnBnOThEemlw?=
 =?utf-8?B?MlNabm1VL1BKRTVUakdUalgxazhwc2FENXBMek9vZTgzaVRhazdzNnlVRjFn?=
 =?utf-8?B?RS9kamlxekNSMjVvNFNzY1hiVklBZWY5dFNsd3lCNFpxaGN0Z1VzUzhhc1hQ?=
 =?utf-8?B?UWFKeVBzbnN0a2pFSWRYSFNLTDZ4emxTY0lLVHVnUkRxejdCZjZPZ2x2OGtP?=
 =?utf-8?Q?nv+iFVn5xYjTB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5703.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWxTSTV5RURQRG1vd0FUZUxuYzJSZjlKaXVNODNqTzBDZ3pxeFU3K0hEZ2du?=
 =?utf-8?B?RWtPQjluRm82bEk2SDF6dFYxc21PL2IyVE92TWNYN0YyM0tLZVRobHdjZ3Ux?=
 =?utf-8?B?eE5hZzF3YVdOdUlYLzljVnhNeGRodG5HNmdjbmhjWVk5Y2pFK3kraTJrOEN6?=
 =?utf-8?B?Wkx3VzdFQzRsU05lZjd3TU03U0krbFJsdFB3R3F5akw3c3AwRG1lMTlzcUV3?=
 =?utf-8?B?VHlubDFCcjZjeU05VTZEMVRlREw1RTIxNVIzc0tPOGx2WXJhSGtMcU1Xck8r?=
 =?utf-8?B?NFZVckRjK1B2MWlyTnhSUDdWWGpnK2g2eVg5Z1YyQVFrb3RRQXZDQ1hnZDdw?=
 =?utf-8?B?ZW55c3hEU3J1Q0dJNTkvUWt0Y3BTell4NnpNZTZTdEdZOHVyb0pHd1hjTnFu?=
 =?utf-8?B?MU1OakpLbFZrazN4KzNqcGp4VjJZeDAwMzN0SmRNQm51N1g1cVBuU3gwS3FR?=
 =?utf-8?B?dXJ1ejgxamZiTzIyaEJKMGxKMVcxd3Z4OHFhbUNubFE5UWN5Y1daRFpVS1FQ?=
 =?utf-8?B?QlR4dzNtbXgycjV5TUN1eXlhd3BuRFJnMGV1YTZZR0lKK0VTcm90ZE0xV1Ri?=
 =?utf-8?B?eE1HNjBlSFd6OUNRR1RZeHhITlUwWTlhL3BhR2hSMXJHY0dkc1F5MFdiMWcw?=
 =?utf-8?B?SHVibENvVksrd3Y2SlE4LzNRWWVXOWtNSDR2cWRBMUVNYUhBRDlhOHJCMmt5?=
 =?utf-8?B?MnVzMEtib1lzK25TRFEvTzA5RHVWOFJEQ0t5dVlhZnRob1ZVV2xWL3JIaGRC?=
 =?utf-8?B?TDIzZ0xDREkrSVRDOE5xc1lzcU8rT2hMOU9DNE5xWFpQTXRnVVY5ZjhjcU16?=
 =?utf-8?B?RlBtYkc5Qmx1WXhYRnc4MytqQ0hxN1k1UTJvNWxFZ2xFNXpoa2hUaDVWRDlp?=
 =?utf-8?B?VVk0dmdJUWhwRnV1dTZkZFZvcktNc1lFbHllL1h0eURGbWZKUkxhVlRMcnRN?=
 =?utf-8?B?MCtsdmk2K3FtUHJ5Q0hSNHpsNy9ZdExXYW9nRzJlTngvbit5OXg4TnJKcGc3?=
 =?utf-8?B?SHpwMnQzS2QxSVdjUVluUTBnbFAvZUxEdHRDVU5raUhsUFN2UURZTC9QZGwx?=
 =?utf-8?B?Vk9Wb1pPYVNCbGI2SlJJcGpVN0dnVGVPWWlqbUQ1NVZ6R3RlZFpjZ1lsdDg2?=
 =?utf-8?B?d3FaUldES1J1MTJveTh0eXRUamRaY0xuRGx5VjBxZXlWeTB1QVdrZkxWRVJH?=
 =?utf-8?B?bVZRL3NJbG91eFYzZzdTaW9oUFlJMWtXcTYxQnd5bDVDRzFTNHRDelZ6Rkp2?=
 =?utf-8?B?YU9lcHlmM2NFbS9xMHJCM3hzd2hRWkViTTV5N1lnMFBqa3VKRDhHL3RiOHZo?=
 =?utf-8?B?S1Y4VzVDejB1c1plVnlMN0tzY3Q2eUxWREErRk9HTGdoRU9TSjVRVDRHbzhY?=
 =?utf-8?B?ZWVsajdDWTl1bFJ1R1VUR3RCNFFmZUdQWHlrdWlzRmxoSEcyMjg0UmVqOGZq?=
 =?utf-8?B?VnRoWFcvR1diK2lpOGlDUzlUYmVZRi96dDV0bSt2WkhiSkVzM1J3YTBHakVX?=
 =?utf-8?B?STdzZFg0NitDREFGd3RlK3dWaE5RWXMwL2VkSVdMc0JaRjBJbVpxNlZxN3M1?=
 =?utf-8?B?QzliQjJDSUhPVXZFOERiSkRXbWErMTE0M3hXQVRQTnRkOVQ2RFZrS3kwRW5V?=
 =?utf-8?B?aWxCZEdFU3ZEVmU2c1M2d2o0UUw4OHBZcm8zYUhUNzhKU2RTMWtDdXJwbFlE?=
 =?utf-8?B?dmZzVkpvOHpwZ3NkZmJoYmprbjh3SnRmNVgvQ2loc0g4RlEwODdvRWlQYXhI?=
 =?utf-8?B?QlpxTXVXSEZsV1RkS1dMcTZNaXFZUnR2WldtdjE0VFlFekVkS3J6Z0xnclhD?=
 =?utf-8?B?a0J5M242b0VUeFpJU2FBazV0RHlNUWoyeHhEOVYwZURkUk05bTMxYlpiMXVE?=
 =?utf-8?B?OHJINFFwcnZ2WTdPR0E1cEE2ZkNMdGZ2Mldza3FuRm5LempIVTNoNGdSWDlx?=
 =?utf-8?B?bTdTSnJmSnQ1WkFrcFJjbElUcHBURWRKUWhnL2pqQmRMRldZcDFMdTZwNjM2?=
 =?utf-8?B?Nkp3QWtPR3pwWFIzdmdzV0xscUFwKzU4NFV5YlJSbFNrb0dqZHRJeEZQR3Mw?=
 =?utf-8?B?bmVFNURRYTBkd2VNS3lDVHJvazRkTkNsTTJSQ0t2SDhZQ2RtNXM4YUF1a08v?=
 =?utf-8?B?WlZHVUVheGZ1N1NDcmxnM3RidlNmTy9PWEZwQmFreFc4VytObXNwMFNnYkdP?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d85fde-7e20-49d9-5c9f-08dd70dd7b8b
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5703.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 05:24:32.3727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: neOy4iFwhL0tYZwvxrVmWXmzyE53buKHw/JvQx9LgSsHB5ZpsDkimA4z+mec2qhAdf8Es0ZQLF04aakHWEaExg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8194
X-OriginatorOrg: intel.com


On 10-03-2025 22:58, Rodrigo Vivi wrote:
> On Mon, Feb 24, 2025 at 10:18:47PM +0530, Anshuman Gupta wrote:
>> Add xe_d3_state enum to add support for VRAM Self Refresh
>> d3cold state.
>>
>> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
>> ---
>>   drivers/gpu/drm/xe/xe_device_types.h | 5 +++--
>>   drivers/gpu/drm/xe/xe_pm.c           | 6 +++---
>>   drivers/gpu/drm/xe/xe_pm.h           | 6 ++++++
>>   3 files changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
>> index da7946b75cd5..937461939ecc 100644
>> --- a/drivers/gpu/drm/xe/xe_device_types.h
>> +++ b/drivers/gpu/drm/xe/xe_device_types.h
>> @@ -19,6 +19,7 @@
>>   #include "xe_memirq_types.h"
>>   #include "xe_oa_types.h"
>>   #include "xe_platform_types.h"
>> +#include "xe_pm.h"
>>   #include "xe_pmu_types.h"
>>   #include "xe_pt_types.h"
>>   #include "xe_sriov_types.h"
>> @@ -488,8 +489,8 @@ struct xe_device {
>>   		/** @d3cold.capable: Indicates if root port is d3cold capable */
>>   		bool capable;
>>   
>> -		/** @d3cold.allowed: Indicates if d3cold is a valid device state */
>> -		bool allowed;
>> +		/** @d3cold.allowed: Indicates d3cold target state */
>> +		enum xe_d3_state allowed;
> let's also rename the variable name to 'target_state'
>
> or xe->d3cold.allowed = XE_D3HOT //becomes strange
>
> xe->d3.target_state = XE_D3HOT sounds better imho
>
>>   
>>   		/** @d3cold.vrsr_capable: Indicates if d3cold VRAM Self Refresh is supported */
>>   		bool vrsr_capable;
>> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
>> index 32583651988f..81e67b5693dc 100644
>> --- a/drivers/gpu/drm/xe/xe_pm.c
>> +++ b/drivers/gpu/drm/xe/xe_pm.c
>> @@ -859,7 +859,7 @@ void xe_pm_d3cold_allowed_toggle(struct xe_device *xe)
>>   	int i;
>>   
>>   	if (!xe->d3cold.capable) {
>> -		xe->d3cold.allowed = false;
>> +		xe->d3cold.allowed = XE_D3HOT;
>>   		return;
>>   	}
>>   
>> @@ -874,9 +874,9 @@ void xe_pm_d3cold_allowed_toggle(struct xe_device *xe)
>>   	mutex_lock(&xe->d3cold.lock);
>>   
>>   	if (total_vram_used_mb < xe->d3cold.vram_threshold)
>> -		xe->d3cold.allowed = true;
>> +		xe->d3cold.allowed = XE_D3COLD_OFF;
>>   	else
>> -		xe->d3cold.allowed = false;
>> +		xe->d3cold.allowed = XE_D3HOT;
>>   
>>   	mutex_unlock(&xe->d3cold.lock);
>>   }
>> diff --git a/drivers/gpu/drm/xe/xe_pm.h b/drivers/gpu/drm/xe/xe_pm.h
>> index c9f176912b46..b7b74757ce21 100644
>> --- a/drivers/gpu/drm/xe/xe_pm.h
>> +++ b/drivers/gpu/drm/xe/xe_pm.h
>> @@ -12,6 +12,12 @@
>>   
>>   struct xe_device;
>>   
>> +enum xe_d3_state {
>> +	XE_D3HOT = 0,
>> +	XE_D3COLD_OFF,
>> +	XE_D3COLD_VRSR,
>> +};
Could you please reorder the enum based on the level of power 
consumption as shown below ?

+enum xe_d3_state {
+    XE_D3HOT = 0,
+    XE_D3COLD_VRSR,
+    XE_D3COLD_OFF,
+};

>> +
>>   int xe_pm_suspend(struct xe_device *xe);
>>   int xe_pm_resume(struct xe_device *xe);
>>   
>> -- 
>> 2.34.1
>>

