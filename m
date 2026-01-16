Return-Path: <linux-pci+bounces-45015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7239ED2A9B8
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 04:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DABDA300295E
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 03:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583A3137930;
	Fri, 16 Jan 2026 03:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QEOE6KZo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849FE1397;
	Fri, 16 Jan 2026 03:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768533350; cv=fail; b=EZnW55xfeVC+iZNHXtIL8NvcMEy60H5qhrm9L4ysVdWXeVyb3J4LWL3/q05alfqpEZPkfMQXsFHobP/uygbVbkZTfQ5o31Nnn5cHRW4e+s563Xyuno5VegL5uHXGPeHJYgcahoDIH3GfJ6JEvEne2A9CFFm6AGG3MjDaW2OaW+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768533350; c=relaxed/simple;
	bh=6MSWZtLQL1IyD0uGieOjp4xJm3x9/0iThORCpFOhpHk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=jhbMZcAZ8qgJixnixfcv6chrzdqpva+TNEm1XjUkBYaxgqn89X6wP8uSjLqFbZ7AghNRKYrlxWejxicjURsug0FSllXKQI9qaZt8yN7BQiUU8otF5J3n5u+DkO5n7SQLRR7KYPFjEUm2IfD5TRax6YgqtTI2S15DldHQwh9WSuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QEOE6KZo; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768533348; x=1800069348;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=6MSWZtLQL1IyD0uGieOjp4xJm3x9/0iThORCpFOhpHk=;
  b=QEOE6KZoFbfcx6VdvuPEGIfEQC7+CHgEg5Bm+ojvMLRaufAekaFjjr9n
   /mTHsLms1wfrWLdRm7VrKilLgDaueF4XVPQbk6Xrkv+qpH74VKtpCsLag
   kT8UH7f2mBo3RkBBRYLgxq0//GNzUPJZR7tzqZueLY/1Kq8DBAmzTebR7
   VsN9gvuL+eSHDpZHYzqiZZrxpVwmzHu1hclDMkzQ42lEluXw7ekJVN4zB
   fqGEHnzO6DGE7FGmCYNrXFj1lF6G21mOWPO9nq6O6Z17fqSDxbmQdzlGc
   jd1xQEW/+6cJWU9Vn6l+5q6hlSLSSHsunCIl4n38WWSGPVfvmR/okDBHu
   Q==;
X-CSE-ConnectionGUID: fV/sN/rnSpKKawDZ533mtw==
X-CSE-MsgGUID: 4PG6P2a9S76IJ+/MQDByiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="73478931"
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="73478931"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 19:15:48 -0800
X-CSE-ConnectionGUID: hSIKVsBOToCvnboPfwzE5g==
X-CSE-MsgGUID: FIVcXUzQTruxBR6d6EAEVQ==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 19:15:47 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 19:15:46 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 15 Jan 2026 19:15:46 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.48)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 15 Jan 2026 19:15:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/6G+PlWwKNfJdGjXVKJUODI3UpsKW04GbAxwlx9UYpHKGkiVsP5tuRXOLsaNu3VmZEYRCmaQvJavZJOFJ9qF4XHmq4Djt7fDSOEq+v7nP7UemPz/DMSLgDZNTdWajR8mjh+eBpCNz0rCqauflRd0k5IOue3o9YGeYlvzJWoGoPJ7jEfXisSgP1BR0n2ltBLnJal8YuTDYC5c3BIS1pcFpEi+mfGP7Hng9lsiG/xke/vJtlKHflaKIDsF2CiP2n191f8qudWwOawhc6zzUtUGMICjCLnbfQUiVgDBkZ8K/roXRq7nMUwwvv9nmL0Rg3FihRxyFIQmh5NCYZjhZRItg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXEkxqH5AnCUetEh/elCh9G941laDQWWz2FhpgEWfNU=;
 b=Mjyjt21mEsN7VD0bVih54c9okfI5QyYyQLBvWqYtN8OqJhQhyTNKmGkAGNr3hEkCD6rH6haBE76A/I3sQiuKlxMCBdAlrtNVVPO1+9BhUiJTN/3MCskaFWimC8dz/hdwWFT6hQhSh3/x4vXGG3SASUaWRhaBY4UsNVqz2v4B5U+MwU5opCd3jDipK6biJuKaZQlQNpRVCF8KDRrZsvDqETFQWT1rT/Nlc2I2VeSYAFlPRB73zYn2pVIwPamkzGi80H5m4GVdVP1Y9K4XXyr+GzPt+PW4breBH/NiNabgSrbQH6YzvrUonp/NnRsXnsu4wag8ryet0HgOR137Wn15zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by SA1PR11MB8812.namprd11.prod.outlook.com (2603:10b6:806:469::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 03:15:42 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b2e3:da3f:6ad8:e9a5%2]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 03:15:42 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 15 Jan 2026 19:15:40 -0800
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Terry Bowman
	<terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Message-ID: <6969ad5ca55f6_34d2a1009e@dwillia2-mobl4.notmuch>
In-Reply-To: <20260114195048.00004526@huawei.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-19-terry.bowman@amd.com>
 <20260114195048.00004526@huawei.com>
Subject: Re: [PATCH v14 18/34] cxl/port: Remove "enumerate dports" helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0045.namprd11.prod.outlook.com
 (2603:10b6:a03:80::22) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|SA1PR11MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bea365e-e987-4caf-a775-08de54ad8801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjJleUp5SW85OEhCaFVhK2hOdnh5Q2FLY0xoNHBaUGNxN2VsWGlJb2gwZmxw?=
 =?utf-8?B?Ylc4SHdTRG8wWHNIU0gveXpkeVJzVi9MRGZ1Z3oyVnFZSDAzS3FxYVFWOEdH?=
 =?utf-8?B?ZlVqVmZCVEJoWkRMcjZEdStrenBuUWFEM0lkbTlUUWZ4dGticGZuTUhRRzhR?=
 =?utf-8?B?YWJHSmx3aG85NEJsbERBN3BwZ3VYdVRoMEJ1TjY1cFV6NnBEcjM4Y0FCMFBM?=
 =?utf-8?B?cTdqdElSQitCQnlQTXQ2VTFmcEU4MkdtWTlrWXlHcFhHQi9FdTNvRWtOU0l2?=
 =?utf-8?B?Qm5NRU11cWZTY3NVY3gwMXBzNkVRRlZPUUN2bW4zS0QwTjZrT1I3Zng3cFdV?=
 =?utf-8?B?NXJRdjRxVm5EVmFmV29QVUVLVGdVM3JPblZrNFNwREorNzRRdVBGMkdGelNw?=
 =?utf-8?B?SHMxMmJURml2bDNibFYxQWFJZnAzcWNvajRBb0M1cVVQdkpld3JpdCs4VmVv?=
 =?utf-8?B?YXF3RW0rbHZnQk9HQjNzZHJUckZMUmxZUTU5TFhNNm1KQ01ON2NwUUJsSXo4?=
 =?utf-8?B?N0FhSmozWEY2dVMxWVUyWmFwUTVqT0VhWHRSRDN1YjlvbGt1M3FpRWVmR1FO?=
 =?utf-8?B?UGltM2FtbWNCYVFHa0YrZ3kxUFBmR0ttb2d1bjc5bVoxQmJScm5IZFUwaHRZ?=
 =?utf-8?B?dVJIbDdKLzJ1TldBMkxDakdlWTRZVExmcUJvN2pYZmk0UDhqc2N3RTVONWYr?=
 =?utf-8?B?ekVSc29rZHdaVHJRdVBsVWtYT21nL0poY3pZZ3B1SW82c0FaaGlKVlFLbEJY?=
 =?utf-8?B?V3VyVHo4ZVhsRkwzZU44Z2dRTFJCM0poSEVHVm1Zai9pMDFySDFNajdETkFq?=
 =?utf-8?B?YjRJUlBtaVlnRWk5b3lnekw4TGZpZjdRZGtHWWFtZVJQOThBYlRDeUZITndx?=
 =?utf-8?B?c2pjTFFTa2xEc2k3cHcxRlNnKzMza2dXZHQ5bFg5RklNOHVDYTlSTTZqWGFq?=
 =?utf-8?B?V2NiMFd0N3Z6d3ZJLzlwK2hEcnpMb0hta28wZ1BDaDhqWDFHWG5lRUErbXBr?=
 =?utf-8?B?cmZxbFZIckdITUIrVWdSbnExdjV1R2JSZm5vQko1Wlg0RXdHSk1TUU1EZDBu?=
 =?utf-8?B?YkxnV0hnN0JBbmgyNjRFSlJGWWlyZFVuRkJJS1dPaFd4WjdrNVFiL0g5SUNy?=
 =?utf-8?B?OGtXZEk1K09MMEJKM1BGZlRvcEZ5cEZnUmJ1WUIrVEJUMWlKUWhsRCt2UGl2?=
 =?utf-8?B?RDlsOXNINU9oSVI1dEVBcDRqSlZVWU1kRjhQYUY1YURWWTUzdFM1SE9LQWRZ?=
 =?utf-8?B?cjZLY2VjdmtwTkZ4RHB3NnM2RzRFUlJXSmNvVWxmSklHOGZSdnRQZDM0NUpw?=
 =?utf-8?B?dnhrQmtueitwRXhVVTB3U2RDTW1WMXkxOE5VSnZoelR0ZFgrMmthQU5yQ1pz?=
 =?utf-8?B?YXphaTVpODhZdkVFUmQzdkpSMXk5TFBxTmlFQXdLYXZIMGEyRjJjRTMrSnBS?=
 =?utf-8?B?eGp6WnhobmtSODE4b2ZXbE9NQjBzOHR0OUJ3U1lTTStEV3ZNMG9Fc21iamlV?=
 =?utf-8?B?a251Qk1ZMlV3bDNMVWk4S0RLYnhFOVN4TUhQODdNdmZXWW9iQ29CR20wREFE?=
 =?utf-8?B?RDIrenZVdlZWQS9mTVQxaDkwRnZxZThHRE1OWUtjVjNLTnB6SjVkYzBzSDBO?=
 =?utf-8?B?Sjl0ejBIS1VlWTZuM0N0WHFXUnpuRkI0Ykt5RDJhVVZWbEcrT1JDMk9TUGc5?=
 =?utf-8?B?RFRHTjN2d1ZQaWpUVGN5RXVEU3RPZDBRSjFBV2pCQWowRW92eFBZV2dEd3FH?=
 =?utf-8?B?cnZoNmdxSXZnK0FRQmdqYmdsZjYyN1FpZDRVSlh5eVQ4TWJhSXc3R0pMZnh1?=
 =?utf-8?B?cU5WQ29RZXdqK2N6SnpnbFp2YVA0YllRckhOL3FnWGMwOEl3TXFPT1BkQXhi?=
 =?utf-8?B?RlRibkF1M1YwUnNvVWkzeEtCYXVvNi9zUmk3dWdBYkxOaXZoMkpFOW1SWnlC?=
 =?utf-8?B?Z3JIcWM3cklDVHpvNE44UkNTU3dQWk9HUUdhNXk4S1BRbG1lbG9sTSthQ1c2?=
 =?utf-8?B?TEUzRDN3RDNaZEx5OGxPOGhzbVV2bWVjNnM5NU1HQ0xiTm1SL2xIQ0pidmdN?=
 =?utf-8?B?WFFuMmVkdCtwUk9WSTN1VmJybUh3VW42SXVpc01nUVdvRGxmUWZ1MFhLZENU?=
 =?utf-8?Q?hBMw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckw2Y1dFeVdCdGFGRnJmOVN1VHRhWTcyQXEwejlLMDRDZmVhKzIrTEw2aEEz?=
 =?utf-8?B?MHJOU0dxYTN3M2lzTVh1ZWpBaUM2UEJ1RElJL2cxZ3RzMFlIdy9rbU91Q1lW?=
 =?utf-8?B?clorRzd6TDl2ZXprNnN3WWtxRjAxUUpqV3NzZGNNSVNuK2JXejVpZGJDTDht?=
 =?utf-8?B?enVabk4zWkY2djN6Vy9STDIrLzllMm9lUndRcFczNkNHc044NUltb2xFWFRC?=
 =?utf-8?B?RnJZb2hWOU40dFp0SXRxUURySWNxNk1UYmFmeVdQRDJvTEZXWmhNTFZ4SWho?=
 =?utf-8?B?OGFqbDc1NGN6c3VJN0l2ajkxZ0RvQXRVcDFmS3czcHI0MUY5L0RFSG0rVnBO?=
 =?utf-8?B?ZWhhSEd1elFiUHV1azEweFkxcUoyU3Y3RlpWQ1hieHRRM2J6bnlsQkJnOHNo?=
 =?utf-8?B?bVQ4VGpwR3VZSE5DSDdrcXlTbHZwUlk0MWt5REtqeTFhaG10ZFFadDlYSzFy?=
 =?utf-8?B?ZmozbHJDR3NTZGJXZjc5TkVmZkJJc0JEUmhPdE9Qa3RsNlhkQTdsTHFyK3lN?=
 =?utf-8?B?dGdzdUVCN2FsdUt5Q3UzTnNHWXovbFNJOERLNzBZMm5XWnhVdzBjZ0FFc0cz?=
 =?utf-8?B?bWFZWjExTW5aYTFGeHQ3c0tSeXNpSEh1blBDZlYrM0N3S1kzT0s2WkNjMUxW?=
 =?utf-8?B?UVNBR1dxQmxCYy9pSzYxYVMxZWswS0xzSFY3VGdrZ1BrU1dKOEhEdjd4Tkxs?=
 =?utf-8?B?QU9uYnh4Y25seVh5SnVoWTNqeW9rVDdaaWpDNTdSQ0F3ejM0bEVCNFZTcjBt?=
 =?utf-8?B?dUIyZStpMVhlcXBPSmU4NU12T290T3RpbXE0WEcvTDh2SmluckhaYStoVkR2?=
 =?utf-8?B?aEVqVmw4elR5bUdUNnZ0Y2dza1hnbTJYSE9NQUlXN0RSa2V2eDduRUJuS3NE?=
 =?utf-8?B?T3Jacm1oaHhmcXR6NlVYYzdkWlRFMnp5UUpCYzlGWUgrRUpZU2hOY2hRUHBE?=
 =?utf-8?B?YjBUWkdtd3lxMnoyZGdHdm0zK3BBalZ2T2k1UGp0WVM4M2FTcFUxUlZXNk1k?=
 =?utf-8?B?Kyt3b0krckRxTnZobXVRcUswcW8vcDl2c3hHZlhZeCtkbkplNWYrWWJBSitn?=
 =?utf-8?B?UjJvM0NtRUFqMkRXazgzWlRLUUVESXZQdVBFWDgzYzRkOFNPNlRSNGZlcEJM?=
 =?utf-8?B?eUs5eGhldWRXcFZGV25WVnpacldnRWppUUFUL3pnYUl3cnk4L2k2cjdQMXZS?=
 =?utf-8?B?N3pBQWt3ellaODBkcnhuYnFPL1oxNXl6VWhjQ1lCVDJQVWsxR2lZV3hHQzc5?=
 =?utf-8?B?QUtYWSs2akFjSzN2aWl2cmNhRDFWWTZ0czRrVXZzRVAxeXRId3MyYk13K0dl?=
 =?utf-8?B?NVJyVWorN281N0dTcTNyZWN6aGk2aExUeGVIL3lpb0hyTC9mNEFiQ0NiUlVV?=
 =?utf-8?B?MmFYUG0yVjRwcThQTUYzVW8rMGoraTRadnpYTXZ6NW9MdndSQm1DbmdrVEhk?=
 =?utf-8?B?MGMxY00wU3ZOWkdOV0F4enZSOEFnOS9JbzdicEt0VjQybmZ0TGx0Rkw4aFFs?=
 =?utf-8?B?T2ZTbTduSjdZbFd1UXVEMXBzbHJ3cXBVTTVnb0UweFU4UE9ndjZHT2s2YUFW?=
 =?utf-8?B?VEtpbkNWWTN4UWtJU0ZDVlc1VmFHU2Y4NXFRTFFwUHVjZytwazBwYkdoWEdX?=
 =?utf-8?B?MDFiT2pPRGV5aTdPcm03ZGF3Vm8wYmFESnVnQ3hPRno2WHVMWEhqNkthYUls?=
 =?utf-8?B?cUgvVm5HMUdhUVc0Sk1udTdVMHlJWE1kWm1XTnVJbG9ib1lGeUNaV2dBQnY1?=
 =?utf-8?B?b01nMkRualVMaEoraDViR244d1Y2ZkpVcWcyTnB3T2ZvVnd5U3I5TkRSN3Zs?=
 =?utf-8?B?MUY3SndnTTlmMjhEWGNCNGxYNXg3OUN0THdJNGxmZ1ZFazU0K1I5em52YTNU?=
 =?utf-8?B?YzBrU2N1WmdMejhDSUhvSUN0NW5aZURlSUg3SlRtd1Q3L3FHRytjcUs5Wkcr?=
 =?utf-8?B?dmVFZFBPT0RuYzI4RVE4UjNwS3JzcTRjTzJaQmFLVGFRUGJMSmM1TFQvalFa?=
 =?utf-8?B?WXpYZVY4YUVPcVBhKzRUa1ovK295VFUxYllySXNJRDM2SnptT201NU5zcnRD?=
 =?utf-8?B?TUhVSnhRNmV5SkMzNGxPM242TVEyOE9GOHV6RzUzUWtuK3J6aXM2ODZXdDVu?=
 =?utf-8?B?WU9kK25XSTVlcVBDSU5Pc3Q4QnVaT1ljaDlTaDZqVG83ajUzM1YxbUlXNGtt?=
 =?utf-8?B?MlpGMDRnb0ZDN0VIUzdBWnlaZzFleWhBZXh2dy92UmRqYkQveHpBS1hzR1FP?=
 =?utf-8?B?dUxpUlhVTzl6SjdKZXdjR05mYWxROUErNUZpYWNOblRQbUNBSzBjSG5UN0pq?=
 =?utf-8?B?amJwSWJQYUpTS1pVdzhQOTZ3SVhVc0Ira04vN0VtZmZId25mK3FRK25oemJJ?=
 =?utf-8?Q?gc9vXT6oz4DAmVNI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bea365e-e987-4caf-a775-08de54ad8801
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 03:15:42.2362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vAcohQLZUFy2bA6IvlS5bTmRQ2MnvHP/R7KCaFs0VsLi5Ctn2i2GeyEs0lNgWIzFvTdMYGgp5rDyIPwzw8v1ksngdOryi+CvnBF7KbgbLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8812
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 14 Jan 2026 12:20:39 -0600
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
> > From: Dan Williams <dan.j.williams@intel.com>
> > 
> > Now that cxl_switch_port_probe() no longer walks potential dports, because
> > they are enumerated dynamically on descendant endpoint arrival, remove the
> > dead code.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > Reviewed-by: Terry Bowman <terry.bowman@amd.com>
> 
> Patch description doesn't match patch. 

Yeah, something got frobbed from the reference patch:

https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/commit/?id=ac97e6edd792

