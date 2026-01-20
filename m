Return-Path: <linux-pci+bounces-45290-lists+linux-pci=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pci@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC/UCo7Nb2mgMQAAu9opvQ
	(envelope-from <linux-pci+bounces-45290-lists+linux-pci=lfdr.de@vger.kernel.org>)
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 19:46:38 +0100
X-Original-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A61E49BFC
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 19:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6ED54723D37
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 16:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F1A33123D;
	Tue, 20 Jan 2026 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SFORm1eu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FAE33507B;
	Tue, 20 Jan 2026 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768928043; cv=fail; b=GyPrJJovT59DUm13ye/f6G4yOFoLCwymqC/5w8YDxNY01tw7LdUXNvOwtOkFOgt1nCtAWVFAYIQap6Obmx5ceFP1mtEDon8ELHptfwx3Ydwj97kqKTxOoeCBynexqAy+WP7zy7NRkjG/eX9iqc3rp5PnUvaUCUtLqhj3lv8lpxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768928043; c=relaxed/simple;
	bh=hceXx6eWlHtNohzrFN682MSQBIyCCk01jguRJIUxTDQ=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=ujHamWes2SElTKDNqu1q26yQ8xfyb55DkzZFSkHByQxPfJrYIHxUHmI6PEy0kgPjVlNac5KVHUX76JDF5LYe1O5/zYDLY197wAgyy32AxtqqC5p2DGM457w55e0H56Mga3TpfqmIWW3NXVqCLclKazQlxlYeysAMXhGaLqvBWqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SFORm1eu; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768928040; x=1800464040;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=hceXx6eWlHtNohzrFN682MSQBIyCCk01jguRJIUxTDQ=;
  b=SFORm1euuvsi783nvBvsqV96lljC289N3lqbPcfNCp3yKavXtrpLGrhL
   bpaRUNeJGvZEv2Ct80dES/XSC3wG6sXW1f+JCO0BL6moWxuqrU96YS2H/
   L4WcX+NkVVAMk8dvArTKaZxOohqDUWVmlhZE1zdGApELeocz+vAD3Ytik
   Ia61pICaEdvcd7B/6o49Spa+6u2x+xuTXyrWbGbIegSkUsli4YTvXNqlD
   BN/3lw3UGcA2qVgog1abUC2K10HuqRhogpsdPjFptptzz1ci0a8/vJEwo
   i/+5ONq+cCCgpQGYXn22sY+GBbNjGlS2l0zGWzOY4NU9gVm8AyIZOIYPR
   Q==;
X-CSE-ConnectionGUID: 5fnzNw44QWmX1ihTZubL4Q==
X-CSE-MsgGUID: ye1l7KJVQsqI6oXhbHWujQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="80445758"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="80445758"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 08:53:58 -0800
X-CSE-ConnectionGUID: 6aTCOC8SRl+R8nWGIKLm7A==
X-CSE-MsgGUID: tY03t2AOTvux2c4erjyjpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="243747894"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 08:53:57 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 08:53:56 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 08:53:56 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.5) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 08:53:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZbss+IU3k+w8RF5/Srcf1Ul8MwpeX2ZoTfKsAMT3PF9ldqpvkXsq57fjiAaHjvVt/RICyf8VO1KF5KFKat2vXmE/lsAqcl0PC2Nm2K9Krp8ntNohd7EcFSiTQMJp/ypQosoWrIQ4N2DDDjg5MoERs4cy0R8qBGidKJhxBrDl1VJSoDm3GDVrxNvihwUSREUsKJgkk4LFHk86aWBU/Pr1hE6ie4KEBMjM+jy8MRNgL2aTd7iCxrJ7XPpQj+NKQI+bs7hpl3+Xe1Xe8RsuRh4R5bM6/WlQ0wgarw1W2RKoNFKFgfy14/vNuRFVEB/b+7+oGN/nGz3NtHkw+SHpOBxpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KU6MST8U07v89oHZbBJd9FFsSJN5TMGXQkN9UuS32c=;
 b=LfEwQf5c7WRVJCPtVfz8S3qmHPEHs0aZCVKbDmd0e0YCPM8ZaLvbrMXnxy1a38+gdvS9kJbVsGR9ec/VfgAr49RgF2A4Y91hRmTNQ6Pp7DYXvaTQTEThpj2zimV4l+RcjsHzs+fDCNOlyaCwMqJ7ShRHq8b/gaTovWNL8NYBtsJ2glgw2U7nma3JIC1BaZJ2JAXySnZmZ0wlyhqY6s0BFoxkPaUsGQ34ubiZZy39cA01VZEJFY6hsh3UUNuFpxuwu1G9N06883s0iF3432+gsqrVTuEoIanR2vv3qCcB6mMXhg5Zai4vZCkTZL/o7+RPFBoBI9/lFioxELvCuEmRJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by LV8PR11MB8558.namprd11.prod.outlook.com (2603:10b6:408:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 16:53:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9520.005; Tue, 20 Jan 2026
 16:53:49 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 20 Jan 2026 08:53:47 -0800
To: "Bowman, Terry" <terry.bowman@amd.com>, <dan.j.williams@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Message-ID: <696fb31b99b35_1d33100b0@dwillia2-mobl4.notmuch>
In-Reply-To: <fe7cc68a-ae45-4acf-84c2-1a80921ffd4b@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-11-terry.bowman@amd.com>
 <696ee66c85a1_34d2a10020@dwillia2-mobl4.notmuch>
 <fe7cc68a-ae45-4acf-84c2-1a80921ffd4b@amd.com>
Subject: Re: [PATCH v14 10/34] PCI/AER: Update is_internal_error() to be
 non-static is_aer_internal_error()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|LV8PR11MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: 805dceae-926c-4eb8-3569-08de58447bb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFhnUUZtQndTZlVvRGF3ZnNTYUxyTGxaZTFhUURuVXl2NW1iRmFreDllRi9Y?=
 =?utf-8?B?Z2lPMEZxMGh6SFRoN2J5azVMcnI0V0EwT2FvNE83aGYwNnMvVnNHdVM0THRB?=
 =?utf-8?B?M0JtYjJyR1g0WFgyeExvakVSNFhMdTVsenJSTFMxSTdPcUg4MG5LRStCR3BO?=
 =?utf-8?B?Zk1obW9qTHk3MVFRZkVaZW1RdEpmb0FzdFRlSDJhamFGbGN2ZEI4L3pkV3kx?=
 =?utf-8?B?Y0E4UitldlV3dVJLTjVUc3pCSXJpVXRFRnM0ckEzdWJLak4yUE9QYWNrVTFn?=
 =?utf-8?B?aCsrV3pHTUhBdUkxTEdKZHY0ZGJuaHFicVcyb2VxM1JnRVhvdThaYXNLK1d1?=
 =?utf-8?B?TjRJVWsweWRHcENzTmVvSklDRHJCTHhUQ3pUbGxoR21LRmg3QzNoVlpuS3Nu?=
 =?utf-8?B?NDRPVm13NC9BRmpGNHRKaEx5OWsxd0kvSmw5OTZhWUNUK2hUN3dqVUNZanpk?=
 =?utf-8?B?R0ZFL3F0SDZSY0FoQmd6V2FFT1dDRyswZm0vc1pYL09EV1VyT1hnSldjTEFG?=
 =?utf-8?B?eWVCWlRzK0tINEl3OG9KNVhRVEFJRTRVSjBQOXgwZXJsVDQ4ODYrZW53RlQr?=
 =?utf-8?B?Sy9tRXYvMFBGVmlxZ0l1NFhZT3hvRTNadzBuRFh6OWtZRE0yMkJvbDRHbkYx?=
 =?utf-8?B?RDNUWWNoUm15TVZlU3AzL3dOMDVEaXVWZURjd3F4NFVPdXZSTmNsTHdSeWJ5?=
 =?utf-8?B?ZkdhUGo1TG1XOXJubWdmYS9qTVdlWUNPa0hVUVkxT25KYVNDTitmRElXYlEr?=
 =?utf-8?B?WDhxM1ovd0RmUWdXSmVlN0ZCRkszWnFtR21GUTJIU0RPZVFJY0YvTDR3b3ZG?=
 =?utf-8?B?eHlxM2JiRW5LcytxUC9qZWFBYktMTUR6c2l6dFQ5Tkt3WjVnclFqdndRalU1?=
 =?utf-8?B?cjlXVHJuSnBIUWdTREU1bWhWS25FU00raERCODNDUm0zUGZpV1NXOXI2bjBT?=
 =?utf-8?B?MC90NE9VL3J5MTliUUZWVEI5UWJya2l4UjJCNXhVT1NOclhmbHNkeHlBdzVX?=
 =?utf-8?B?UVE0MHJlYkFYbUV2YTkzd2k1QkZvZ2k1MC9NdWI2a2xyVUdrQmg5dG5oSlg0?=
 =?utf-8?B?d1ZIS01DaVZYd3VvQzV2N3c3WGlHVzNoMDVkWmgrTFNWRG5XdzREcDR3blI5?=
 =?utf-8?B?UUtNSlh6UVpOb2dzc2pkbHpodWRIaDUxK09Gd1plQU9jWFcyOUtEM0dwVHBr?=
 =?utf-8?B?WXUyQkpYRmJKSVc3UUhnbmFlZVEyaVQ3dWU5cVduT0h0R0pkdyt0NWNrcDJR?=
 =?utf-8?B?MWQxVjVQMHJGRVBqZ0dvTUwzRXpzT0REWXNnOThNZm5SU2pSVEo1eWRPMjRH?=
 =?utf-8?B?QU9NN2h1ZjZuazF2YWJiNFRPUnVWdVVXQWlGTnh5MVVvelo4ODZtN1I2Y3Jq?=
 =?utf-8?B?ZXlKb2lVMzZ5d1FNTUxvUkpZNTZiV0J4ZHhpNHYzbDZPblZnU1ZwYnl1K2Ji?=
 =?utf-8?B?cENCUllITTNYRW1HRmZBUU53SHFRVkkzbjh2MkI1YXpQVWs3VlV3clYzRkNs?=
 =?utf-8?B?N2hCbmJHZjg2UVZ6bHJZOE93bHdtYk1FZWF0NFZsV2lERndqNWRhblk1SCtT?=
 =?utf-8?B?VXlZdUZNbzdKYjNnekZtbFg3TE1zakI4bUpsZDd6OWxpM3djV1NBZmhHUGdC?=
 =?utf-8?B?WTcreWdxcEtXclNyNEFIUlZvMFJLZDU0TUFRMG5Xb1Y1Y3ZPRVVGQWNtNUlK?=
 =?utf-8?B?Z2VESEMyZ3pQcFUwNDlYSmlvMm9oSmh2ZEFBRURTeVMrd1M0WDBTSXVxR2hs?=
 =?utf-8?B?MlFBbGRHb0JEdnhoYUlQQWFQcC9iVWc4VlUrVW8zM0hFR3ZxRnA3U2E2U0gx?=
 =?utf-8?B?dXlXa0NqYnBkRW5SQzJ2ZktkVlZVOGRQVHJzdnVQNXJRbWVkMDdpL0VPaWFU?=
 =?utf-8?B?cFRHN2lJVUdZU0diQm5EbXNQN0tkQVdFeGFheHgvNHZUaGZYaUJTZG5WKzIv?=
 =?utf-8?B?bXFEV2dSWEEwSUYzYi9HaFhWMmdGRVV3RDhCQ0E4dDZVSVI3amNKYkNLTG9N?=
 =?utf-8?B?NURXQm81MDh1S1Vpa3A0Z2xUOGRldHh6R1dIOGFsa3JGS1FsaFhrTWsxenNX?=
 =?utf-8?B?S092U0hBNHpJMzBxYnU0YytnaE1wYmE5ZzFTZ3NNY0w2TnJBUzNSZk1VWVYy?=
 =?utf-8?Q?htfgtKVtEh6d+1WDb8E20mNeJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1NtM2Z5akdSRWVMVmpHL24vdkxseDlUUGI5aXVXNVk1eG1kRzB4MUI1a1No?=
 =?utf-8?B?TTFTRzNGR1FnSzVnZmNhaHVOSTIwL2ZEVGpWV045SEFMMlgrUXJ6WDhhdVNN?=
 =?utf-8?B?RFN4RkFQcFFXSjN2S2NPRFEyeFBOUmFBejJISlE3UkUyWlBlY3c4VXVvT3ZI?=
 =?utf-8?B?eXpFMmFnS25vWTJRcENGdFA0dVF3VEFHSHBONy83VTJOWlFyWVFoS2d2NnJD?=
 =?utf-8?B?N3kxR2ZuUmpDTHh2TkNMYVlzV0JTNVFvOU1HNlBpQjV3aXJCaTlHdDJ3M3hW?=
 =?utf-8?B?dHEweDh6Z29PN05ac3BZQWoxblV5K0RPYitYK3plV2xiNFMyRlZsczR2cEFD?=
 =?utf-8?B?bTc4MEdOc2FuZFBBd1k1dXJzUTl0TEJ1SnowcDV1ZGMySit5cE1qNUhhaVQ5?=
 =?utf-8?B?UGdFWFFGODhtQnBvU045d01wNGI4UXEvZ1JraGlBaFgvZTl1Zks4NWMrUi9X?=
 =?utf-8?B?UEhySXFoVkVFSk04dWJHYUFTVGdKeTkxV0IrejN1ZDN4bWxrT3JseVhmREtm?=
 =?utf-8?B?VU93Z0NVVXFYdTVZS2YxOU02MVRpWmxjalB2dUVaQnQxNUhnWE5XMXY4SERR?=
 =?utf-8?B?ZnVUQW5IVlB3S2ovcDRST1VFdTRVVEM4VFM5cXp0OWsyR3BXWG8xSWZpK1Yz?=
 =?utf-8?B?cXBwbEtHU1ppemVaR0lMUVhMdTdBd0VyRUo5NjcwRXlwaEJTY0xIRjEyMXFr?=
 =?utf-8?B?eWhWdnRwY1l6djJZK2pMclZRRDlHcEc3MlgwU3FKU3NMcGVUb0FxSEJ2U0Rn?=
 =?utf-8?B?WVJIV0xnVzIxaGtBRGwwM0lIcXliOHlGNU9wVHpOQlZ4M2V2M005RGdFa2NR?=
 =?utf-8?B?WWRhTDk3UVYyQU9HUXFGMU5QM0s2RlJWRUpUMjROWTlxaU5IWVFTbVovWmRY?=
 =?utf-8?B?VnJ4aWtGeTBhbTRqSUI5bCtFSDdvaHRka2EyTjNQeEk5Y2dDT0M4RzNxUDFz?=
 =?utf-8?B?V0hGcUJyeG05Ry84RENxVTFKNzd6Tmc1WU9DU1krNlpIZENLMHJvY1ZobnlJ?=
 =?utf-8?B?V0t5TWxGOFFibmRoandTbzROYnFtNFBwbXZGaUZnM2J6YXBKQkRVL2RWRHA2?=
 =?utf-8?B?U1c1azJGdTFqYlhqK29WY1NPc2tLZ2VCajVLOEZNaVRGL2ljcUNQeU1rOThP?=
 =?utf-8?B?a2M4M2drRHhweTFwYXdPak1VVXUyL29TUFZFRkZLbkNqSjI0allHVmU2ZGZQ?=
 =?utf-8?B?Mjgxcmp0N1ZlRmc5T2liU1FWM3BpeXhXbnJreEhOL04vR3JnMjB4Y0hTaWdi?=
 =?utf-8?B?WTZpSTZObEkrbVp2NzBVeUo4NnhPT09yQW1VWUxtb2E3YnJOMThjLytBTFIv?=
 =?utf-8?B?Ukd4MHZTUkNRV3ZHeUJtT0hhYjNoV2dKNXkxRlJ5RWtDcEJkTHo5R0NyS1Ni?=
 =?utf-8?B?ZUMveXJRZkV4TFo0MHVlMTdXdDVubG9nQlNEbm9jVmJScThycTRDTndvcWVJ?=
 =?utf-8?B?YTRiTkF6Q29Mb2IzY25UY0lmQ0ZoZUFwQlgwUjBLS0RTN3VEMlg0bWlac2Jm?=
 =?utf-8?B?a2hXc0REbUdzSXpRQjhNamlJNUIrUkpUY2lCdXp1b3RSd1Ewd2N2dWR1MmZF?=
 =?utf-8?B?bWh6VGt0VUduakptdXRRQXlWQkRyS3ZIWDJBTXJMMWdYam9iajhsRDB1K0Fa?=
 =?utf-8?B?eDhZWGVpc1VNTlVoUmtYYUdYZUJzalQ5eVBqY3R1NGJBeUg3SmV0Q21XTk1M?=
 =?utf-8?B?ZU9HRGpublJLVnpyVGx6VEg5c0tuS0RvR1dvcG1SQ05wTnRmaDRqRWMxdTBZ?=
 =?utf-8?B?VkpOZFErMmxkdU5BcWx1Mk83Y1ZoeEw2Mml6QXFFK1VOOEJobm1FQmljaTRU?=
 =?utf-8?B?QkFGZEd3eXhYeXJ4ZWFoWVUvNmlqaTN2SUkvL2FObml2am9nUHJSbXFsVkNU?=
 =?utf-8?B?UkwvTzl1b1NXemE3YmhFR1dpWkhzc2NPd2IyT3lmRDRjZkFMbEVkbGtZT2dB?=
 =?utf-8?B?WDhJbVBQdi9CVlh6RWFkdDlDWTI4REdibHVmUEtoaWVOZGgrelhyR2RZOUgx?=
 =?utf-8?B?bkVyTWZYZUIyeWxodUdlbWZGb1c2S2YycVJyZmkxcllIc0ZFY2R6T3QvaWhY?=
 =?utf-8?B?ODc3TXVBSlh4cjFabWE3N2JxcmRxTjlRUTNBNVg4OVQ3Z3BaUmtKU1g4RGNI?=
 =?utf-8?B?ZjY2c0dteVZoMmNMMysxV09OTHZqcHd6dDdRM0JVV2pZS3pjZUd1Uzc0SjZQ?=
 =?utf-8?B?NEk4TE80d3dwRUFkYnU4eUlkOHFwc3J4K3JHTXBTdm52bThkSDNaRFpMUmRC?=
 =?utf-8?B?UkFmV3pZRGMySGNWR1N3OFVFRjczbUhDazY5MUlHczUxa2lIbGo0NVdSQlI1?=
 =?utf-8?B?cDh5NUhxU1ZlOWkwMUMxd2JMeGFRMGVUUnFYYjR6Rks2cXlYRSt1R1Fkalc2?=
 =?utf-8?Q?CFWkZE2F+FlhKG0M=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 805dceae-926c-4eb8-3569-08de58447bb9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 16:53:49.4468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZzNbeyyJKguOqO26Q4Kngo95HSz2ELEv47zJSloanXrbC7VDZVQeXmohAdwXK0wT7ETddMqRK59Q9VTwg+ijVCW0pjSyxEmnyrTtp68Owx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8558
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-45290-lists,linux-pci=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,msgid.link:url,amd.com:email,intel.com:email,intel.com:dkim,dwillia2-mobl4.notmuch:mid];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.j.williams@intel.com,linux-pci@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pci];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 7A61E49BFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Bowman, Terry wrote:
> On 1/19/2026 8:20 PM, dan.j.williams@intel.com wrote:
> > Terry Bowman wrote:
> >> The AER driver includes significant logic for handling CXL protocol errors.
> >> The AER driver will be updated in the future to separate the AER and CXL
> >> logic.
> >>
> >> Rename the is_internal_error() function to is_aer_internal_error() as it
> >> gives a more precise indication of the purpose. Make is_aer_internal_error()
> >> non-static to allow for other PCI drivers to access.
> > 
> > Not even sure this rename is needed given that it is private to
> > drivers/pci/pcie/ and the sharing is only for cxl_{rch,vh}.c, not for
> > "other PCI drivers". Consistent with the idea that internal errors are
> > not going to become a first-class citizen let us keep this a CXL-only
> > consideration.
> > 
> > I'll update the changelog to drop the "other PCI drivers" comment.
> 
> The name choice was addressed by Bjorn here:
> 
> https://lore.kernel.org/linux-cxl/20251208180624.GA3300935@bhelgaas/ 

Thanks, yes, I only folded in the following changes to the changelog:

10:  417535d35e9f ! 11:  098f14e1d884 PCI/AER: Update is_internal_error() to be non-static is_aer_internal_error()
    @@ Commit message
         logic.
     
         Rename the is_internal_error() function to is_aer_internal_error() as it
    -    gives a more precise indication of the purpose. Make is_aer_internal_error()
    -    non-static to allow for other PCI drivers to access.
    +    gives a more precise indication of the purpose. Make
    +    is_aer_internal_error() non-static to allow for the 2 different CXL
    +    topology error model implementations (RCH and VH) to share this helper.
     
         Signed-off-by: Terry Bowman <terry.bowman@amd.com>
    -
    -    ---
    -
    -    Changes in v13->v14:
    -    - New patch
    +    Link: https://patch.msgid.link/20260114182055.46029-11-terry.bowman@amd.com
    +    Signed-off-by: Dan Williams <dan.j.williams@intel.com>

