Return-Path: <linux-pci+bounces-33470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D71BB1CBF7
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 20:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FBD166D78
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 18:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8CC1FF1B5;
	Wed,  6 Aug 2025 18:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lJG5E4IW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788191C7017;
	Wed,  6 Aug 2025 18:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754505207; cv=fail; b=L/mXkEyIFvp6yabUy709g8U4X8NVONEsHJAgghG42n3/1YE790uVpOqiyCphymSFifSv0trHtnp2GdScs8ixOyhaAw32T4+mfaPTw17NCsZmMRx9eQv7FVNF0XPEp0iUsIYQ7va7YusnbPr1ogMJDspDFkFneTbUD4O3OIRKXEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754505207; c=relaxed/simple;
	bh=Vm1mh+1pXFXzWwFnlrkeq0KHXRRnwL8Ma844zQjHmuE=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=OCFfdHuRQqGePzt9vBb5FqtVSD2gwNAyHfyCeUxExrVCevjrHGmvS7CsXxyXLM5g94S03py7Qf5iFVkgjSoyN2QzcTC3KXI5Txi3xCuBPwVHzaaGXEuyvyOwiKCem+VQet6H2qjeOsshBqMA2JeEPmVIhdABt72XlWjEggGJQWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lJG5E4IW; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754505205; x=1786041205;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=Vm1mh+1pXFXzWwFnlrkeq0KHXRRnwL8Ma844zQjHmuE=;
  b=lJG5E4IW3icQx6PVDKAkYV9dg2Q7RhwgT1HjGai3cRa9vmObGnCvUTOd
   o323YKE/BY4X2VrA6YY++sX2HNqoglZn3RIFnWPgQbAteHD2D7yBEAc5x
   kkxa8AcrzIvPNf9pXiaFEptDbbh9onmu2DF5XtRYpHwuqyO8QvWooNvEu
   X5bOhD3FxYcJub87vHRIF+K9sg7pqYtjg2w0VL+YYmp7SN0vRIo5OfBN8
   PmOw1aaDl/AdS/vqnSZdxHh++IquDrs7S0uTKprLIzPkGuPzPfyoM8Hly
   yVn8DTIN2VIcu6u+6J4q+zaPmrvZvegJKKy9ZxMpgeYmKs+5nsgXfIr0X
   g==;
X-CSE-ConnectionGUID: eIYJxQ0LTJOrNKGQtrLmYw==
X-CSE-MsgGUID: ErnoDVm9RXiMMIo6RoEbTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="82279757"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="82279757"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 11:33:24 -0700
X-CSE-ConnectionGUID: ZSCbBmHKTtW3lQxQLBFe/A==
X-CSE-MsgGUID: QewnGGJXTzm58B0EWCdjIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="165256541"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 11:33:25 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 11:33:24 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 6 Aug 2025 11:33:24 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.55) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 11:33:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R80VkhD7xdIP/ccGApjA9eLyAwlgR7BcxVzMHKtRbRywIRkduFVdjGrfDT56vKeKhVomiFhBSZXvyjL9n62d2LR3sbG8myJ9u9d+M9XE3rJEAKhE1hpQeO6bhl/YrUhgttlmOX+9EB/nUYcF1OcNKQSCx+iyVAHqe51iBsHVpyN/jS/Zd9Z83ssNp2L9Mqg3yzo37yQai9VI9Zr0uiR0UbsdRrjkAY+j/pYPDQW7IPycbT0+y0dlmVM7ZrlozA+PuXvZnDWvNSvi+l3do4r7+m7QG3RxrFB7SCTMKVr9VWsS6w4Z9JSwwwjIP8/hhwL2IepNsnaD2stDmVwDZAx4Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EQRzkAoOEzHbM9AzdGG9Wu9Jear16obEarp83QAr0g=;
 b=GgadUEGoUzDk2rpOnErJTdwjSSTlEb43AbLvS/8/mV+IDMjI3YHG45k2YsrkfXUBN3xPEHOsCkEU9flJBjzo3YK+sVSfgzTfVEJ+z7SVkdNotxFFgvUgdp636JRSpEI79/ganmqWNWIjiXf2fSvhWdkxFtvzvzpRLpKJqlwCK7HTb+G+acfpEP+6O/PF5jkhPmf1vOQBn6jdRxwCKujHgUQvt6cf7aSq9Ala3uc+/oLihbtrLSfEfYgyz8U7JPE5uQ36JLJgioTTC5kL5u4vGH22mC2udg+WyXnhCNe5DdujfZ/nQ/jF0uX53mVH9y9EXWgpRH3zlf2hd34JXifMpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW3PR11MB4713.namprd11.prod.outlook.com (2603:10b6:303:2f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 18:33:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 18:33:21 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 6 Aug 2025 11:33:18 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <68939feeef7d9_55f09100c7@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <20250806121625.00001556@huawei.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
 <20250717183358.1332417-6-dan.j.williams@intel.com>
 <20250729161643.000023e7@huawei.com>
 <6892c9fe760_55f09100d4@dwillia2-xfh.jf.intel.com.notmuch>
 <20250806121625.00001556@huawei.com>
Subject: Re: [PATCH v4 05/10] samples/devsec: Introduce a PCI device-security
 bus + endpoint sample
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0011.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW3PR11MB4713:EE_
X-MS-Office365-Filtering-Correlation-Id: a5da696f-9ad4-4857-c702-08ddd517b870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzVFZEZETzA0SFpna0FpR0hyTWF5K3VqQTc0NEJ4NE5aWTBzRGtoNFg0azBC?=
 =?utf-8?B?YlZaK0RlZE90N2lCMXpBOFRqbUl3T29YR0lLbkNFNy9ncjBNMnFJWkNVUjhz?=
 =?utf-8?B?YnN5bmJKMi80aDVaNXR3ekhmWElqZzVDbDhMc0c4ZGdIT1lGVWZJTzdGVHd1?=
 =?utf-8?B?MkRnRHM1bCtkcmdHNitMb0xIbThyeDMyZlRIdzd3NVZlSmJHeTlqUG5pQTFw?=
 =?utf-8?B?VE1OZGlPQkhNdkRMSk1aOWZZV2UwMldadDB1L3NIcnBtTTZQM05xa2hLM3kw?=
 =?utf-8?B?dW92RHdOdjh1T21BQmlNd3A5N2kyZ1pwdmdVZlpCc0tod1pIeldBeW5rWUNP?=
 =?utf-8?B?L01yTHoxdHJFUkdicEhQZjJoMTJHbHVjcDNVOHJNaWRCVDlWUjZVc3g5NG10?=
 =?utf-8?B?ZVliTVB1NEJNU0lIdzV4M25pQnpPNEdWVXVsMkhoRXZVNXA3UHVaWHZkR1BS?=
 =?utf-8?B?T0k3eWdBYlE4Y0ovRXB4VStjMzJnbXdnaHE4VUxzR0VtcFFvRVBsQitNeThu?=
 =?utf-8?B?UVRSU2ErT3FjYkwvTktzUjlUa1AyeFpmN1R6UnBtczRrNmtmQnZTWWxXRWFJ?=
 =?utf-8?B?OGwzVGFnQVg5MCt2UEVCbGZpck5QNGZCVVVLZjVUQVo1cnBUYjFKTnhoRVEz?=
 =?utf-8?B?N0s4Rm8zdTY2bWloVmVPZEpZK05BTEkweFRST0x2N2N6NWoyRjEwd1RFdndX?=
 =?utf-8?B?dGdjWlJ2OUp1dmhETGp0Y04rbnZIS1NWd2pFeEp1eWJqcXBINUZ4d0J2YjNY?=
 =?utf-8?B?eThzM3pLVVIyMlhiblZnUlZVUEVXV2FUNmc1RDFKODQybEI3VmhsckluRkxz?=
 =?utf-8?B?V2xFTEJ1ektLNW9wbTk2N0cxR3piOUt2WnNxL0FFMGF0UGd2VkVlVlptZWQ5?=
 =?utf-8?B?dEYxWlRVOTRXdVN1Z0lyWXMwUHRaanhMQUNvc3gxZVZBRmh4SlhlNXRwVytI?=
 =?utf-8?B?TjFXNVp3cjZWUVllYnVUdXJsbkdnMVdsTUZUOWVidU9QaUtHeGJxTnpPR05s?=
 =?utf-8?B?b2w5aDlFd0xWQ21RNGZuWjQ0ckxkTitpUDNQZml6SVUwS2liZXhTcC9XcXlC?=
 =?utf-8?B?SDcveHZCQ2RqVU43K1NJU2N3dWM3VEFtaFBVUmJ0ZlJJSGlCZVg1REpaVEl4?=
 =?utf-8?B?WFE2andWWU4xcytRRjV6d0c2UHltb2FIWDlYcXF6cElJaFg0WGJabngvUkhX?=
 =?utf-8?B?VzRoa2VpcllCZkQ4aDMvQ1FBbll5ampYM3JtdjRqNUhBQ0NZbS9zb2lWYnFV?=
 =?utf-8?B?S3B1RWFqUy9ocXJTSVZkcFFDaXBoOXBVZ2lHMDRZQ25CQUJydHFEY2FQNXlU?=
 =?utf-8?B?dldnL3B6VDJQNEVOUnc1cGx4dlo4S0RIekhrbEhDR25pc3kzeG9jRnZJTjh2?=
 =?utf-8?B?R252RkVRekp6SGJDanFVbERUZ3VnVm5yZHZtYStIcnhxU1k0TDEydENtSjRO?=
 =?utf-8?B?NTZiYjEyN1NUOTAzWlNHdGQ4dUl0K3VYZWJjTVA4Mk5sb2JVZWpKbXRmYXhR?=
 =?utf-8?B?Q2t1R0pyTkphTmMxMGFkd0dBQ1B0aFBXbE5QWjJ4bFBnczJ5bzBXREZoUzNU?=
 =?utf-8?B?VnRzUWF6RVNXQ0N1TGZjSzRkNEZlc3VIUmFZLzNpYVhyR0RxelIwdFlzaTY0?=
 =?utf-8?B?SGRVaU5vWWdSTCs2TllxWGVkRWZiQ2UxVU9MZlZVWGJGS1FVRmwxeEFMc1pU?=
 =?utf-8?B?ajVmbnNHanFtRG1id3JUeERxODJ2R0MydW90NHlLRk9neDNPSlhYVU9XYnFl?=
 =?utf-8?B?Y2J0b0FxbzlJUVhoOWhwK1ZtSWZJVjQyMXhWYWJ3ZWYxT2RmY0IwdHJCWS9x?=
 =?utf-8?B?elo0aFVHc1JhRjBPWm5CRTMwamZydzdadFlLZTR2NUVQMjJ4OXNseDlhcHUx?=
 =?utf-8?B?NVlkcDRtUklRdEt6azJpd3J4a3hRR093bUVRWHpHMjZWaExyL1h5b1YxeWJC?=
 =?utf-8?Q?qDSmqSASCe4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czNGbHk3eXJIdnM4YnNtYjVBbUF4b1BDWHRtR2RDT0IrZWliaFlqQWZwVTlJ?=
 =?utf-8?B?eGxnSWRTUlorVlozRzN5M1lua1RhS2VBY3c0cjRPckJiMFU4dWJCNXcrNHFJ?=
 =?utf-8?B?UzB0amVpdHdyZm1icUlsZ2Q3Smd1clhlcHVENkJOSUs0SENZdVFKOVdjcHVT?=
 =?utf-8?B?R0wvYjRoSHZzYmQ1ZGRxVDgvRzUyUC84V0daQ3hLa3lJVjBtK1lmazRERnB5?=
 =?utf-8?B?Q1RrNE8vYUtyTDExMTM0c0dXWU9IS1pwY01RemxvV0Z5RXdQMU8vU2svN3E2?=
 =?utf-8?B?MFlaR2VPZU5Da2RlaFVreUJNR05wWGpFU2c0TWpuL1BJSE5wT1ZVK0hGRW9h?=
 =?utf-8?B?RFJTb3lpY1doa2hWcVFlaExpcjNCWUxyYmdSUFUwcEh0c1VENnRjSDFGdnQz?=
 =?utf-8?B?c0dyMmlMdlRISTFKZkpMTWRoZzV0TkJyN0pUaWJvZWt4eEROMXE2d0gvS3BC?=
 =?utf-8?B?cUljYkZNY2pwQkpjOTAvM2p5byt1VTE4SDRTS3QrT3g1SDFlaWZJYW56QVVm?=
 =?utf-8?B?S1pmbmIzZ0RPQ3FQUnY2aFAwMkVxbjdJSktNK0tlNG1INUFPUkxiOUhEdlF2?=
 =?utf-8?B?dHVuMnorWm5Bdkg1UVB1T0NSb2pub3dMc1Bsai9TNDlvZjBSOGJyNVZiMHcy?=
 =?utf-8?B?VE81Y2hwTWRscWpSMzBsTXNWSFdreHNlMVVSTVpYZmZ6eFVzd2txT0VBOG5J?=
 =?utf-8?B?RXFwajcvZ1QxZ2hla3FlQ3lLYzg5dzk1MkE2NDcyVkt1UmlmT0tadVB2TWZu?=
 =?utf-8?B?WDRYQjFzM3F0YVEydFRKK3lrNnRJR0lKRm8vQ28wSkVvU2YzNERsbDRDTlhK?=
 =?utf-8?B?MDV3MjFXWG80aDFnaWF2NFFpSFFhOGo5dFNvd2xNVWFVaTEvZTc0TVJ0bDQy?=
 =?utf-8?B?d0J1T1I1MmFMOFBNaU5tWE1mL0VUTWRTQStlMUJQYVRieVd0ZzQ4UzRxVmIv?=
 =?utf-8?B?eFUySnNONWExcXB6VHNqcmZJVjk0Sm5UWEhvY0IxdnErbWxXREdTVkdmNWNt?=
 =?utf-8?B?MEdqeWJBcVYwMi9uVUV1eXE2VTJ3ZTlQZ0NJMUNFSjNSNlgyenRtSXhnd1pn?=
 =?utf-8?B?MEEwYi9HbXZVc0I2NktEdXIyOStnd041bk00bk5NNVVjUWhmak8rYVVPRW5Q?=
 =?utf-8?B?Wldrem9JSUJ3bUFma2ZvTm9WL2l5UDBReWE3L2Y4eDRYVkJOYVlQTys0S1Nl?=
 =?utf-8?B?WlhWSlAzYVU5alRMZ3NKbWl3dHNHMzAwczgxcEJKSTRSeXBOL3NUTTJEL096?=
 =?utf-8?B?RGV5dmxvT1piZGcvYXlLR1FWUWtpVGhickowYXVyQ2RqdWlUUElIMTF5UG9S?=
 =?utf-8?B?WEpCK24zcE5YSzBtOHFPNXBEQUpNYXpYVHhLWng3WG9LM01OTmRYUGNWV3FL?=
 =?utf-8?B?cXpQL1R3U0pmSjFIWWQ2K0VzU2hXdjRwd2V3RGR5Q1liYXcxZkRrOUVxSm1x?=
 =?utf-8?B?TGlGNTJ3RE9mM1psOG1JeHVaR0NLcjN6QzZoWUEvZGtZbVQ5ZE5uWHdOc28x?=
 =?utf-8?B?SGx4UGp3RnFETzRzUnNHcnNjMlBGQUZDeXhIYjZPZng2SXZ3UVpIY1lpRHJS?=
 =?utf-8?B?UmhpTnZnRjZrSlovYmVXZGkyaDZCRkt6VGh5bHY3NnU0YVVPSzkyREJ3dkk0?=
 =?utf-8?B?enJXYkZkbXBJS1ZnOUx1VXJsNmEyOTFkbllMWi90TWFCdmg0SFlnWDJwK3hY?=
 =?utf-8?B?TTVzNStRbUhzcjFXR21mRTYxUnpGdjRPaXNmdkcxR1Y2WDZXbHlzTC9CWUdF?=
 =?utf-8?B?RWxUOGh0THN1QWc0Y0czekM4K0xCYUdsWHpLQTJrRkIwOXBQTFptU1JodFlq?=
 =?utf-8?B?VlJOK2ZNQmZvcTRQajIyb1VPSGljNGdId0hpT1BjaXVPeHV3R2Irc1RmU1pt?=
 =?utf-8?B?ZXJWVEZQeVd6cEdnUnRMQ0pHQTZmc2RPeXpzT09yYmRoUzQ0aVQ3MVdxMUwz?=
 =?utf-8?B?QWJXNUtLbkFTcG50YlQyeFAzTXQ1NHU0SXJnK3JzRGlUUUtBSCtENTlkS2Js?=
 =?utf-8?B?QjdudVpjMlZsUjEvaXhkWmR5OExPODdqWm1vL2Ntem1tZGh3eGhlYUtZa1lj?=
 =?utf-8?B?MEhaSzVvQzhEZ0ZmbW9ST0NIWnBNRCt6U2RhSWFNdk9tYk05b2U3QklJc1pv?=
 =?utf-8?B?R1lMNEJNQlNOVnhma3IrWUpnYWw0bGJIYmJYM21PODJCUkdzY0xnaE5LZ1ha?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5da696f-9ad4-4857-c702-08ddd517b870
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 18:33:21.4819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CFlR2zmJhJKp6SojZpiZXdYSEg8ZFHq3KCPvi7KVEMRMnZmGfktNx1iIgzwB8TQzAcvCTus8m3tBd7mDB4pNC4Pd/WzDoHGWvAt4CQeWEv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4713
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> 
> +CC Gerd, of off chance we can use a Redhat PCI device ID for kernel
> emulation similar to those they let Qemu use.
> 
[..]
> > > Emulating something real?  If not maybe we should get an ID from another space
> > > (or reserve this one ;)  
> > 
> > I am happy to switch to something else, but no, I do not have time to
> > chase this through PCI SIG. I do not expect this id to cause conflicts,
> > but no guarantees.
> 
> Nothing to do with the SIG - you definitely don't want to try talking them
> into giving a Vendor ID for the kernel.  That's an Intel ID so you need to find
> the owner of whatever tracker Intel uses for these.

About the same level of difficulty...

> Or maybe we can ask for one of the Redhat ones (maintained by Gerd).

In the meantime I added this to the Kconfig because I also received a
report of an AMD platform being confused about this extra PCI domain.
This protects against allyesconfig builds autoloading this thing which
should only be used with unit tests.

diff --git a/samples/Kconfig b/samples/Kconfig
index 8441593fb654..9ad822d4e808 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -327,6 +327,7 @@ source "samples/damon/Kconfig"
 
 config SAMPLE_DEVSEC
 	tristate "Build a sample TEE Security Manager with an emulated PCI endpoint"
+	depends on m
 	depends on PCI
 	depends on VIRT_DRIVERS
 	depends on PCI_DOMAINS_GENERIC || X86
@@ -339,7 +340,11 @@ config SAMPLE_DEVSEC
 	  devsec_bus and devsec_tsm, exercise device-security enumeration, PCI
 	  subsystem use ABIs, device security flows. For example, exercise IDE
 	  (link encryption) establishment and TDISP state transitions via a
-	  Device Security Manager (DSM).
+	  Device Security Manager (DSM). Note the emulation uses a device-id
+	  (vendor: 0x8086 device: 0x7075) that is *assumed* unused and some
+	  architectures may be confused by this emulated PCI domain.
+
+	  If unsure, say N
 
 endif # SAMPLES
 
> 
> > 
> > > > +			.class_revision = cpu_to_le32(0x1),
> > > > +			.pref_mem_base = cpu_to_le16(PCI_PREF_RANGE_TYPE_64),
> > > > +			.pref_mem_limit = cpu_to_le16(PCI_PREF_RANGE_TYPE_64),
> > > > +		},  
> > > 
> > >   
> 
> ...
> > > > +static int __init devsec_tsm_init(void)
> > > > +{
> > > > +	__devsec_pci_ops = &devsec_pci_ops;  
> > > 
> > > I'm not immediately grasping why this global is needed.
> > > You never check if it's set, so why not just move definition of devsec_pci_ops
> > > early enough that can be directly used everywhere.  
> > 
> > Because devsec_pci_ops is used inside the ops it declares. So either
> > forward declare all those ops, or do this pointer assigment dance. I
> > opted for the latter as it is smaller.
> Ok. I guess in emulation that's a reasonable compromise.  Maybe leave
> a comment somewhere to avoid repeat of this feedback.

I expect all the low-level tsm drivers will struggle with this, so
expect to see this pattern repeat outside of emulation.

