Return-Path: <linux-pci+bounces-8185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C049E8D866F
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 17:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37851C2074F
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 15:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE6412FF73;
	Mon,  3 Jun 2024 15:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZPGJr5Zu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF1CF9E9;
	Mon,  3 Jun 2024 15:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717429689; cv=fail; b=F6IGgBfa+8n3JX3HSjizUUPtpB+eDipsRlaAGvXSiw4xv9S4N3EO97L6DQirtVlYkPTM/igjbcMYdvG5erd49ZW2OZOVkWBkqD5b2NjZS80ez9/gnAoyBjJxTnr9wwuUsfUj5SJqVr4BkjSAsAkiJ96TeAk5c34tTB1z7hu5WqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717429689; c=relaxed/simple;
	bh=BZPCPEIN4mgXChj/VHxw+CjSKLyPawDuMgc7X8x6nhc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QOkwrBHdWVPYTf/Mum4MTfw26MDX2wvK0/ViFnWrKhsgIGZMlJVlPT+2ezvljRA4DfSAiMGBSvKoegf/k8acCqkaf7rWu3ztqF1GSh64uuLo+F6bYn75jcXA23i63SmapnYjuPSfeILtrLGJ9i0DSOob1v9q7ENe6I8OQ63JHvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZPGJr5Zu; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717429689; x=1748965689;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BZPCPEIN4mgXChj/VHxw+CjSKLyPawDuMgc7X8x6nhc=;
  b=ZPGJr5ZuX1MUjzVdrS46Njbo2Nj37pfEfPhfhBYcfhh/1rj6AJtxdgLQ
   hGzjC3I5yMn4fv4zLB2WR/SeYzMRoyDC26bAnj1HTYfpWfPkss8l9E56J
   V0YLURw2B2qdkuQrQHIPoVbXzOKOX7S6FNDVnVnGc0c/YOFJW5Av7mxUV
   L/HigM5vAYOqWN2kECCZYhWEjK2rfaLIYSNL+1ambW7u1Yhrkxe2tz0jC
   PMJtW8I01d6Loo25yZ+yFkX7InUhZQ6RkgW9ESAFjn6Vbr2EEkwZU3vJq
   LHapgellRSJNBV3SeOVH7mLJXpru4sRYeRIXL3Pf5MiKM9SseIlfoQs+V
   A==;
X-CSE-ConnectionGUID: aDrH/99FRBCD2ZVbj1hmwQ==
X-CSE-MsgGUID: s6Leb7GGTUymz3RMjHCs2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="17716514"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="17716514"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 08:48:08 -0700
X-CSE-ConnectionGUID: i24EYHyFTLGCYpfIUWgosQ==
X-CSE-MsgGUID: 5Qf9WG6fQoKqrg1pqwoSEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="74410437"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jun 2024 08:48:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 08:48:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 08:48:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 08:48:07 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 08:48:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Es7ZFfrBuR8DfoSZvr6TaXhDFASn/RHdzR8ZtKprnDKKWnGpy3xh9NXJhk6gDmQoGE3RG2cx1lMANqov4UBhYjUdd3cMMJKDp/vQwZthxwklrzTNB4B69SPiL5JEwBvXfLypRtySbEtyZtFcX4HqpMQMfyMUBNr5xvGDFwLD86T0PJcivdShDZLRDy/vBQ8Lg0w3+0mWdP1BA60wJigGUqGIYB/nl00ad2vWGE4sP8w/g5Pnh06De71hcrEgyKr7wGjpgL9lmpAljjDGm8YS8pb9yKaLWw2JuTXKOCBaDZ26zR88juWObDs6CIEdUTMpuXIF4UPpkBRpEC6j+1HosA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWMLYZKtWOPH0U6WNge8DYes1kmyAFDCmGFbj+rbf4g=;
 b=cOg2NmmvdTWUmj1bHsB5qcSQiLeD4H12ysHz2Y4ZqeNWCkbKrxq3jE+vopdXN0g565eml8LV2uSDBkB9XByJCTCba+syhIOAhwAcpPd9Usjt8u6BGb9rEzRlvSBdpcL6UrDmnzVYB3Nx8DzVBDYVoIhso2wJwDszOCxcwlAD6LXRc72+mrrbHY/MEciyIPjqsPMBrTaHOFDO9IBMsezf2hWPzsYa3F/SfWtyB48IEwyAjrvBd4/nwYJpOTLJDITUYACykFKvVIcIs6XmdDzZWRMgN3qQrHyG53Zq+XBEpabzN3bdHb1nN9N86/7NJ2RMGJFv1eh9jbtzB76osIxiGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by CY8PR11MB7337.namprd11.prod.outlook.com (2603:10b6:930:9d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 15:48:04 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::6e1a:9fd8:2300:d3f9]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::6e1a:9fd8:2300:d3f9%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 15:48:03 +0000
Message-ID: <e10398dc-53b7-446f-b22f-f992ba1cc37e@intel.com>
Date: Mon, 3 Jun 2024 08:47:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: vmd: Create domain symlink before
 pci_bus_add_devices
To: Jiwei Sun <sjiwei@163.com>, <nirmal.patel@linux.intel.com>,
	<jonathan.derrick@linux.dev>
CC: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sunjw10@lenovo.com>, <ahuang12@lenovo.com>
References: <20240603140329.7222-1-sjiwei@163.com>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <20240603140329.7222-1-sjiwei@163.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0200.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::25) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|CY8PR11MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c528d4-7ba7-4c55-0817-08dc83e48b4e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzZWS3Q0RUlYRFYyYVU3S0NSQy91aW9XQUQyUXE1Q0t5SkFpYjZrTFg1d3Jx?=
 =?utf-8?B?M3ZzVmtWdUxTSlpVdnFqMkhlcmgvNVVzQzkwM215ZWtYNjVZNzZ4UWRIVjYr?=
 =?utf-8?B?ZDgrd2J3U3NBOFl0RTlQS0lXRTlvNmtQRTI2YkxzNTJOVUs4OFhYVEpwWG1s?=
 =?utf-8?B?UkZZTHVNTFNBZ2lQME1EVW5PaDU3M1dOdGdVby9uNG43VnVpQWtXcEJKZkdS?=
 =?utf-8?B?TnR6TGJPSGlQckRXZTZTVWNZamdvczA3eEROQVYySUR0VWVGQ3NjWlVmTzZK?=
 =?utf-8?B?c0FoOVdBeUxBdWZXY2FUWGwzb0N0bXB4SnVhTmFqMjRqc2N1K2pDdjFRVDk2?=
 =?utf-8?B?RGI3ekNaN3VSK04raHM1R0RsYkRiR09lNEVyL0NMTDFBSHpYaDFXN1hzMTdi?=
 =?utf-8?B?REhJV1FWcGFUdlFhNTk1eFAyVW5tVkh4bnJFSmdWV1JLOEQxSHdvMm9SeXFI?=
 =?utf-8?B?MzhHQWo5THUycEEwbTRvM05wMkczdWwwRWxMSkMxM3BhenlGS2ZsNkgvbkgz?=
 =?utf-8?B?Sno1TXN4aUR3K1BPOFJEVmh4Y1BYTzFmMXRKbHBsWTFrZGhGKzNQd1VaQ3pG?=
 =?utf-8?B?NElXeTRxV3I2Q0V3OG1vUHE1MSs3VzRuYlI2SEowSzZmdGdLZjUxcUdBSVFu?=
 =?utf-8?B?b1M4RHFTcmo2QS8vOHNXbVJEUzNObFIxcHU2ZWJZdEdlRloxdEJqWEw4N0FU?=
 =?utf-8?B?cldmR1BGTkg4ejdoVkx1T252Zmk1NUtXZUFCMm1MQmhzUm5nZzAraDU4R0g5?=
 =?utf-8?B?R2gzWXlTM1ViVTU2K2VSU3MyMElIbjZuRktRc09IeSszTWFIUnROZ3lvcTFB?=
 =?utf-8?B?OG5UZnpTOXlraEVyN0JTYlRqeWF6V2VrdWxWVTU3RjFhZCtsTStTdThpL1F1?=
 =?utf-8?B?ZXlZYmdhV0x5dUxrN2V2aXp1b3J1dG02aktodnVMVGlOY0FXWU1ITElXTkI4?=
 =?utf-8?B?eS9Tc01HYjJObk1SNDV5V25xOWVYZlpNUnZKOXhYT0xSQUlCZ1gvYlZQS0I0?=
 =?utf-8?B?MGtQZXNwSnlONUYySE5DYXhiNUlyMzRwOGVWTVU5SkpJckhidGdMbjVsaUdV?=
 =?utf-8?B?cXlBTk1lZ3F3L2tlaHFwTCtqbVh4cHBMQUZ0MUxQaldCekx3KzZ0cEt5dWFu?=
 =?utf-8?B?ajJpMUpSQUpNeDBDRituWG1ySE1hbkVPOXd4Ny9uMDU0Yk1SNGFJSUdLeVQ2?=
 =?utf-8?B?MmpkTVMramwrQ3p2cmFlWDd4UW92UXlTeVd5MFBoOTNLZWZFeWxYeEZ2NGFh?=
 =?utf-8?B?T0QyR045OG00M25IOEJqSHpuV1ZVMkFMTXNKSHpJdUd0eWlXcDM2NnhJWGVP?=
 =?utf-8?B?NmZIY1h5bFVGSVF0eEpmMUJTRnY0c1hHcDhwcWgvQ1dpNmdZRGQzODB0b01t?=
 =?utf-8?B?RDUwY3Z3bUlXRVhsdURqbTFCSDU5K1lVRzAwdTdzbGprQk8rbExRdXdQOW1v?=
 =?utf-8?B?MG55UlBPZzVVYmNacXhkcEdMRElqVFV3d2lqZGNadXliNGRmeE1tK0d4OUU1?=
 =?utf-8?B?MjFFRDhRb2NmWWxBZU1YSmRTN011WEVCWXMzSDUrTk1uY0o4RFY3Nkx4L0dS?=
 =?utf-8?B?Mi9CT3haTGlIa3Jsa1NNdXBza3gwcHFaMy9FSnlubjh0b0RwTGRraEJudkF5?=
 =?utf-8?B?RXhZbFpndmJVVzgzMVJ4a0NBZFZxT0M2NGplazBIbDZqZEJVN2lRZHNUOXZR?=
 =?utf-8?B?Vjk0Q3VzMTZXdjV6U1NOeDZIbTJoWDhlVURaWnZ2Nmd1TW9veDVHT3hnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUQza2h0SHdOVkxvTnF6TncwaXkvSTdmaUVrTW1nSzZyNjdkWFhlM1ArSlNV?=
 =?utf-8?B?RCt2UG9HRTJOVWdBcEFvWVdsa1VjMUF4UWJqb1E1QjR6K1BKYkxLWnBpQkxR?=
 =?utf-8?B?SWYrRFRTT1VVZFFVOCttWmdhZzdMT3BDUytxdkF1TlFJT1Y5alhrTkZqZXU2?=
 =?utf-8?B?cm1TV0VKV0Q4dEVwa2tQTFJ0SGt3NkZ5cit6QTUyL1hnZC8vRkFoU2hJaHRJ?=
 =?utf-8?B?ZEFYcm5TMnd3SlZDaTdxZjI4YTI4U3pmU2xWbVdmTStiQmpCa1lUMjNGMUV1?=
 =?utf-8?B?RWYwVmFkSng1N1ZOL013NEljVHZ5bFNSMmpZdFhveUxGb0UwNlRUbVZNS1Bx?=
 =?utf-8?B?bzlFdmdCbzBtNGNDdlA4ckpubkFZRHdYYmtzZnYwV0lQVWhHL0Y4Z1lzSENh?=
 =?utf-8?B?MnhiZm8xckM0VXhxVVFORlFGM280Ym04Q2RIMW1ta2hUcjUrUU5Ob0Qxazkw?=
 =?utf-8?B?UENhcTRoTkEvanNGTS83VE16TWY2cENJMzh5M21CQm5OOVlXWDdHUkhHU01K?=
 =?utf-8?B?ZFIveE9pc2hBRzBMdUJOY2tCSCttL1RacVd3UWJDWWR6UUlISjZtWnZaTWgz?=
 =?utf-8?B?MmhvN2tTOHc2SlRvTExzdzZUcGhEN090WVpqQ2h0UitraE1LTm9hWjdlTStj?=
 =?utf-8?B?T2xXK3ExdlViRFg3SDlocVhmY1NrTklBb3d4cWFuVmpqb1dLNmhMUjI1dEdh?=
 =?utf-8?B?RmdpVExJblpMQ2NXYnJ3MFI1LzdubUVEYlpHblJhMS9xcnl0WkRyV00vOENp?=
 =?utf-8?B?MVQ4VCtGSmhsdDBNT2Y4cXZ3L2ZKWnpMNU1uNVFHSTMrMHZrUnlPNFAxd1V6?=
 =?utf-8?B?OXRad0NEWmljTTdjb0xoZEFFdlZmUVl0dytQelgweWo5WjhrZlJBczdQNGxP?=
 =?utf-8?B?aFBJbVY2cjhUcW1mdmtTaHJUVm9RNU44aUk1SCtXWWJpOGN1dGZhMzFhR2tn?=
 =?utf-8?B?YjBrMjlvTVhIVkVUYWVEQklrd1gzcXhxSERpKzVTUERNd25HTitvbVhLZEU5?=
 =?utf-8?B?NFBKUmhoN3RjMHAvMHBFc2UzaDVaRW16TUVpSmF1WUxHeHQwR21odzhiQ25v?=
 =?utf-8?B?V3JIaGoxMDBWY0JlL3ZpUHdzd3dueVlBMHJnejZMeDU0ajNQUkFZcVhvK0wy?=
 =?utf-8?B?aUFtMTNsZlFGWUVCaFFZTC9EWlVLZUxFOTJqdG5BUVh4V094b09sUmhWOUxK?=
 =?utf-8?B?TjU1TE1rU3BNV1htY3RiMTRUWXl4bDVJYWc1bnVCRmQ0elBmaHU4QWM4MjhY?=
 =?utf-8?B?M1hrbUNwMTc3ajZHSjFHZVgzaGxScjFRNE1vYWZ2b2VWWU05VVRHdy9kdnFI?=
 =?utf-8?B?OG12TnlFQ3NrY1ROZUNrNVNTRnBpQnFWUUhVcnBxZk1ObmNHR2pGS1NueEpW?=
 =?utf-8?B?VEJWaFgzZkRJemZlNTdlL3BhdDBGbjhNOTVQdmJjd25BVmpxZlF6ZjU1Q3Yw?=
 =?utf-8?B?NlRwQlIrS2NaMWkvUVVPcjltdHdlbjFTblJGWTkwTWljalFlNGlMTHZLbGFU?=
 =?utf-8?B?cWRndGZPM1NVbTdxUDVPRDZpOGtZOFBmNUEyTjZPS3BOcy9xZGU4WGNlNEY3?=
 =?utf-8?B?SzUyaVlKYzBRSnJGc0tFakVtZmF6b1RiRzZPQTR0OGFrODhVSUgvWU02Y3Vj?=
 =?utf-8?B?aVh2cXNnSmFHR3kxNFBrU0VYYWdmaWk4SllnUkJBRDRsSnZ4MGV4cUg3Tlpz?=
 =?utf-8?B?YXRrTHI1R2xLL0JXS0JUcDBaaUE3ak5ZK1hQRC9rOXBhQlJaak1ZNW5NVk02?=
 =?utf-8?B?andGSkV2NVpBNHVBNEdieWFKZTRtMW5ZZThOVEFkTmZtc0Z2WjlPc1RJU2p0?=
 =?utf-8?B?Z0FNcGlwVXBHc0liRXhyL1M1ZWw2OEhLbUZ2T2VpRHQwUGVwK3JISkpHQzFi?=
 =?utf-8?B?bmdVaGxqVWJzR2o1VlI4NUN1YjRaMHc0UTExdWlNTlR6TVVrdkZCM2dZRTNz?=
 =?utf-8?B?YjlIbkd3ZHUwdlA2dVVNR3l1YVRSalZQeFZER3Y5MXFtaktOZ2xBTDdTU3RP?=
 =?utf-8?B?TGUyQ0QxYkhKb3kzencyM1FlS1U0cmxZYjBqbjlYWXA0VDdzWmdheWtkUHUz?=
 =?utf-8?B?Q2xkMVl2b21UUlgrUmMxYzN6SzNSZThMdStWNElvWmUyMStYVklNa2FUZyta?=
 =?utf-8?B?SnI5WkJzZ2M1Mnc1NitLamNHN3J3RmxsYTJDclFreklLejlFbys5b0Erdkpo?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c528d4-7ba7-4c55-0817-08dc83e48b4e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 15:48:03.7172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GEBifjaFRTfprQmjQ5hRk/AcotrAI3uapKXzl4onCyuoddEpPFtStVm1XgjauLB6lFnzcdwPyXbbWGDf17Te9uhoy7BIVoaEfSiKLscntM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7337
X-OriginatorOrg: intel.com

On 6/3/2024 7:03 AM, Jiwei Sun wrote:
> From: Jiwei Sun <sunjw10@lenovo.com>
> 
> During booting into the kernel, the following error message appears:
> 
>    (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: Unable to get real path for '/sys/bus/pci/drivers/vmd/0000:c7:00.5/domain/device''
>    (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: /dev/nvme1n1 is not attached to Intel(R) RAID controller.'
>    (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: No OROM/EFI properties for /dev/nvme1n1'
>    (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: no RAID superblock on /dev/nvme1n1.'
>    (udev-worker)[2149]: nvme1n1: Process '/sbin/mdadm -I /dev/nvme1n1' failed with exit code 1.
> 
> This symptom prevents the OS from booting successfully.
> 

I'm just curious: has this been doing this forever or has this just 
started recently?

Paul

> After a NVMe disk is probed/added by the nvme driver, the udevd executes
> some rule scripts by invoking mdadm command to detect if there is a
> mdraid associated with this NVMe disk. The mdadm determines if one
> NVMe devce is connected to a particular VMD domain by checking the
> domain symlink. Here is the root cause:
> 
> Thread A                   Thread B             Thread mdadm
> vmd_enable_domain
>    pci_bus_add_devices
>      __driver_probe_device
>       ...
>       work_on_cpu
>         schedule_work_on
>         : wakeup Thread B
>                             nvme_probe
>                             : wakeup scan_work
>                               to scan nvme disk
>                               and add nvme disk
>                               then wakeup udevd
>                                                  : udevd executes
>                                                    mdadm command
>         flush_work                               main
>         : wait for nvme_probe done                ...
>      __driver_probe_device                        find_driver_devices
>      : probe next nvme device                     : 1) Detect the domain
>      ...                                            symlink; 2) Find the
>      ...                                            domain symlink from
>      ...                                            vmd sysfs; 3) The
>      ...                                            domain symlink is not
>      ...                                            created yet, failed
>    sysfs_create_link
>    : create domain symlink
> 
> sysfs_create_link is invoked at the end of vmd_enable_domain. However,
> this implementation introduces a timing issue, where mdadm might fail
> to retrieve the vmd symlink path because the symlink has not been
> created yet.
> 
> Fix the issue by creating VMD domain symlinks before invoking
> pci_bus_add_devices.
> 
> Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
> Suggested-by: Adrian Huang <ahuang12@lenovo.com>
> ---
>   drivers/pci/controller/vmd.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 87b7856f375a..3f208c5f9ec9 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -961,12 +961,12 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>   	list_for_each_entry(child, &vmd->bus->children, node)
>   		pcie_bus_configure_settings(child);
>   
> +	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
> +			       "domain"), "Can't create symlink to domain\n");
> +
>   	pci_bus_add_devices(vmd->bus);
>   
>   	vmd_acpi_end();
> -
> -	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
> -			       "domain"), "Can't create symlink to domain\n");
>   	return 0;
>   }
>   


