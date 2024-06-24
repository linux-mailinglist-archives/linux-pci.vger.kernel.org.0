Return-Path: <linux-pci+bounces-9203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE0491560B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 19:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F8F6B20991
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 17:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4FA19FA92;
	Mon, 24 Jun 2024 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rJBXvWJe"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AA519F48D;
	Mon, 24 Jun 2024 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251797; cv=fail; b=i3AWih/G2AMeqYE8jwdVqgPqWkhOzR3+9H2uerX2wAkn1tokSjl1FxqRRyaYSnEGzEdQ0pXQzgfujxBtVYTGx+2RUqH1zMEaiGXbVgBgxUZjyqjvGIYjTqSchA2MxON2EjU1NXZVXufDnCep2oe9UsiIrEJn3lnDYpOck7SLylw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251797; c=relaxed/simple;
	bh=WBBeSxYXBXZy2Wqu5D6Pj8Gbstv7vS/UbFTg9ubyodo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NVOEMJHNX4Kzq2FY6j/b5rGf28HlfzEy/18zU6jKhg5UgPG9WCyvTYdCnWzTRqPzSc5Gem/hHuiOGo7tAfvpo/Tw6nuY+DsvDgl3YT4JcXoBJEUF7r8ysYgloYmTEcRrXkFs23J/w/VzPyuyb72ves8whVNbZAh0ZyochqSrNbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rJBXvWJe; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/5FENQcjDRSjloLSSLsJtNGa/VMnYq0o45KQSrQj3O0IATfm3rU5LfhXgWO5SzcFcA3CWNSV9hoacn6xBYM1jph+afC4pUrzmGyUZcBcq3d3byZz2JwWJN72vsiB8ir3stbRy2e6qu5jDsxQO/kThS6otj5IZyig588X2eRlWGYE5qA8q7K5j8u4vIDoE5GQMyG7Hrymdsp6aUdlcXQb/76tHQ93uOq2YLvouhjsz2lwaatSKstPdgKXBTLCl9hvCK0xNcQy3ccGDZfAoYwOLxkNILz+/YUm+am7XNhzvZjuOCT2UIlflc01M9P8s/LGlmTEecjQpnooRT5gfSf3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v44BJyW+uW3EIX0DLDPXcqLc3QyIINFcVrFXE5ycM8c=;
 b=Z2hb2OEK32GW15lJO0CivYM3aoX/IvXt1Rj/oNbm1h3hbTPg5HP3R8vp086McoZHSNFrjbx6VotWkosAIJxZMqddHSnUU2NRTpO57LU3fL2rDzBC9KVJ/1MBk7pfFrtmD1xkDIBqCOPz1uVpCqXH3dj/0sf+sCDyTeF0LUHPwxH5R6CFkLHUsPv7SYq8wEwqvlgB2Hm1nroEpocwaDE4dVyGqS3d9chWHJYlm/tau0uBXHG7A1trE3VWwjcfXRitg0Mp5xY5wNehpnUrBl2W6eI26Mz99ovYnl+R51qDp74VMVIz0jbp/xP5FF8xpFsaVaqIFnyTu5iePfCaqfcZZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v44BJyW+uW3EIX0DLDPXcqLc3QyIINFcVrFXE5ycM8c=;
 b=rJBXvWJeg/d7tk0FG5C2T87TqHTTw4F7yCDtExlghhQGaHNaExTIc22m7447FlRQDIaXvKRbdnyBHnWOYnFMHuwvPD9DK7zuWEOmyKtWjr5L4kFWB4t1+Ak2nYJxjnqByF+TFNMN3sKxzpYdTwxL579YuKlqxcmkCqCaFFL4uIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18)
 by MN0PR12MB5761.namprd12.prod.outlook.com (2603:10b6:208:374::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Mon, 24 Jun
 2024 17:56:32 +0000
Received: from BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::66cf:5409:24d1:532b]) by BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::66cf:5409:24d1:532b%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 17:56:32 +0000
Message-ID: <ecc5fbd0-52e1-443f-8e5a-2546328319b2@amd.com>
Date: Mon, 24 Jun 2024 12:56:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/9] PCI/AER: Update AER driver to call root port and
 downstream port UCE handlers
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, ira.weiny@intel.com,
 dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 ming4.li@intel.com, vishal.l.verma@intel.com, jim.harris@samsung.com,
 ilpo.jarvinen@linux.intel.com, ardb@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yazen.Ghannam@amd.com, Robert.Richter@amd.com
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <20240617200411.1426554-2-terry.bowman@amd.com>
 <6675d1cc5d08_57ac294d5@dwillia2-xfh.jf.intel.com.notmuch>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <6675d1cc5d08_57ac294d5@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::19) To BL3PR12MB6380.namprd12.prod.outlook.com
 (2603:10b6:208:38d::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6380:EE_|MN0PR12MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: 543b7e76-96fb-4370-905e-08dc9476fb0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|366013|7416011|376011|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVJhbVZ2Vzh4V3RmdWlyME1YRHpjK2tyUjY0VEZQSnBXSVNja1FYYUxMbHcw?=
 =?utf-8?B?T1hhb2J6c3hNYjJpRzNsczVzdXBPVEhpemZqREFvVHdEc1ZzU2w4VkMxVjV0?=
 =?utf-8?B?NkVNZFpkUWgrUmNreWpSVzRXY0tPRFdZMmRPV1ZUTFA4bWxUUmNrc2RkcFFk?=
 =?utf-8?B?cG9GdUJtdkh0bUhaajBUeGp0WDNGQkJYeGp1ZjdXdDRDMVNVemlBV0tkdlJD?=
 =?utf-8?B?YjRSdDQ0YjFVdXR3UkZIK1dGbk5hbXlZV0RpaUYzMkpsdGdFRFZYZFJPNnk3?=
 =?utf-8?B?Und1MGtMd0kvOVdKNVpQejJPSjJmdHU4Z0lZOElTRmw4UHpPUFRTQlU4K0Ux?=
 =?utf-8?B?OC90cjdlNERJSHlsU2U2R0dZeExOd05aaVFmeFdMbTZhYkwvK3NvbWs1UFZy?=
 =?utf-8?B?NDZQRCt4Ync4ZHdzZ0pqbzFmU3hObG1PZEVKeU93Nk8xN0dDdWVmM0wxSnkz?=
 =?utf-8?B?aUliMFltSWl2a2ZVYUgyT3BQclJCQjhTQTE1RDRFSE1vWDBFbkxubm1RK2RU?=
 =?utf-8?B?MUhHOUhxYmNuOFRvYkpIVElTdnZ1L2JacjQvazJkc1JDTDEyMWUzbnRUNXZP?=
 =?utf-8?B?YmF1OFBKdWRzc1ZVcnl3S3FhMjkxekdaWnJxS3E5emJ0RkZVYi9OQW5kWWps?=
 =?utf-8?B?SUVRSUcveGQzVUF1UCtyY1p2RnZNNmVMWHRQRnIvRHdqb2I4L0d5MUNnSkZB?=
 =?utf-8?B?NHJhVjlWKzBDUEhHRmo4bm02Sk5Hclg4ZytQaEJ1Wi9VN1RWZDJYaFkyL0Ew?=
 =?utf-8?B?YmRoK0p5OTcycU0rWFBUOUl0RERwdmtzSnluMkRwV0hUSzFPK1BsZFBTaXRZ?=
 =?utf-8?B?RUw1VE1SUVR1VUdFVjlDWmhQdWVKT2RyOWxodkNVUm9xRFBHUzgxdTVKamdU?=
 =?utf-8?B?QzlEaDdXdkpySkpRZUFTWnhUZWNKQzBGSzYyTDdZeWNDSVp1dG1MNVlqdkdz?=
 =?utf-8?B?QytORWJrenkyMWNjNzc4N0syYTFyMWVKbTArM2ltaWZPMmdrTlMzaW9oWFRi?=
 =?utf-8?B?ZlZ3YWtlUmUrU2RmRHJVRmp4bXVCWFU4SmtnajVhZVpHcVVId2FqdUNpTWFR?=
 =?utf-8?B?RStXNkk4MzB1N2RyVGFhd1ltSTFBRFNqcGRMb0xkdmJReE54eTI1akFOWWo5?=
 =?utf-8?B?R1VBdDdtTGNhWUNTb0FXem5LM3hERjdqTjN3blJNUnVBWWZiOEJzU1RIYVRj?=
 =?utf-8?B?Tk5lUEtUajJIU2syc0VkbkdMUEd1Q2RkNlVCNi9nR0dqSkMwVW55NkhvYWhO?=
 =?utf-8?B?ZzBHTkdXR2dhTEh0anMyTVhsNFcvNExKdm1MRVJpRU1kMjY2QWliNHVWZHZk?=
 =?utf-8?B?T1ZpQWVNeHE0V2tvTmNuR0JnN2ZYOUQ1TWN4N0diSUdWdGt0Y2duWWtzaGdr?=
 =?utf-8?B?cW05bTZKUE82NXNzQzQvSm03TkYyS1A3V3VlVWZUMFFXdm83emNCbTdCNnRU?=
 =?utf-8?B?RFF3ZytQUVh5WlppQi94cm1ra3k5QlFLbktDM1M1TDk1bWxoUzltem4vNDRJ?=
 =?utf-8?B?ZVhxYWl3ajloMm1heEkwUUtFcU5DY1RiaVNTZDZJZndkWE9vSmZ3Rkw3aXA3?=
 =?utf-8?B?UW55eDk0TFJScHB4Z2tLUTRNZ1YzVzVtMEs0UzVUKzlOVE1DSC9ZUFNHcERR?=
 =?utf-8?B?WVRxNmNQSDVjSDgyYW9RbHZTcTNPMjAzb2lnbDlPVUcrWVJ3bHJEYjlKSXNr?=
 =?utf-8?B?SWl0NTlndWhhN293b0pnd2MrSHJtck5hN3BSWm1zMkZ6dWR2NzZDNmRhYjBS?=
 =?utf-8?B?ZG1aTzhxejdUUFRnNG93SnVrZWxsSURkWTBlTFdNMDVabHhSM2RsazM1Sy9N?=
 =?utf-8?Q?Mzh23Xe7ktaGHH6wgqDgoKxBOigvSFSOhTU/o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(7416011)(376011)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1UwdTg0dkthbEJDM3hhTEtLMTFISjh1QTJQeGlGZTZhYmFmK2o3cUNVTXNk?=
 =?utf-8?B?SU1rTUc3clRIdmlQblFIY1B0SWFPK2M4SS95WWRqTFBZTDI4NnNtVFBYWUg1?=
 =?utf-8?B?Mm0zU1A5czQ5SkJJSTlqNm8vR2VsREV6OWFwSXVRalNDMGdQT2lkUTBpOTJi?=
 =?utf-8?B?di9wbTFRNTdOc3Nhb0VGSGljSXN1YlNsVldJQ0grVXdGQzlrem9JYTdhdDcy?=
 =?utf-8?B?cHZ5ckYrM0ljdlJQa1NIejVUcVF0NHFWR0h4WFYwRkVFRmJCK01DcWJUVjhQ?=
 =?utf-8?B?UXYycWNUWGlEVU0vbkN1QWxrT3dwb2VFb2ZIK2pnbzVGbUh6dEtYZnAyd2k2?=
 =?utf-8?B?dWs2WDZnM25VRUJiU0l3NXplcXZzc2JGcXFMcG9iaDdpN0w5Zy9ZaWtNOE95?=
 =?utf-8?B?RXdlclNreG1IdUcwZENPVGpMd3lDNGRsUVgvV3oydzRSVWhCbkE2ZFNTWHpT?=
 =?utf-8?B?dmhmTk9vbG5nTjlRUkhvUCs1ZERtaDYzUUdNRHpaVTBuMm52MWRVSjRGV2Zh?=
 =?utf-8?B?dkxqQmxKM1hOaitpU1MzZERXTkk5ak5HRzlYbkZxWXcwckloT3haR3V1c2hW?=
 =?utf-8?B?VzJsWFJVaHlBcU0zRmJVZ05FdHdDYVlUR0NMZEtRbjdaaXNGNmx0TCtPampI?=
 =?utf-8?B?eFQybUw0a1gxSHQ2Q0s4MXpWNHZkM1FVdEpJclNzYnJDcmltOXpxcDhzSW9V?=
 =?utf-8?B?MlFjMmdrZnRhMFZGNVluRmg0RkNSaVRzbkwxRWxzYzNUaVVLalBUcTRyVWhL?=
 =?utf-8?B?emdHc2xyK1FCbmRFSytTMUdXUENpZW5tTks1OXpzYlZZMnJTNXU3S2RrNk10?=
 =?utf-8?B?cEtnM1dGR28xTmZwY3NaNVdIM3pUT1FhclB4dTMxZno2Ulhjdm96OFUxVm93?=
 =?utf-8?B?eGVjUTRZM2NyWnhyQ2lLdHRzaUppLzJFaHlCN0JXTzhkd3BGN2t1ekQ1dzVT?=
 =?utf-8?B?ekZPWFh0YUVmUmE4U2VqaHN4R1VSc1VaZEkwbXNsRHhxK1E0RFo4MldzNjZ0?=
 =?utf-8?B?Z01JQkRwVUVLdHREbENmZVRzQVl6SXpyYUxrUldlajM1ejg5RzVFcHZTcHZv?=
 =?utf-8?B?N0E2aVFXRE44VFo4bjBPcHo3eExhT29VQkIvQXBJekMzUGg5NGVXOUoyYUpP?=
 =?utf-8?B?VDI1Y3NlNFJZY2Nid0FrVnhrTXFiRjFqenRZNkk2NVdGOTllVFBwY1RXRVpH?=
 =?utf-8?B?OGRwSUY0dkl1aWtpVDBsN3NVbWJJbjdHZ3dMcWFGWWFpUytIaURqQWNEM1F2?=
 =?utf-8?B?S1VrWDJlMVRlalRNem5wMmVPNmVLYWk3VW9pWGFsVHFXY1VJUnk1Rmk2NnVU?=
 =?utf-8?B?ZHo2VWNlOWxrTU5HRlQrKzlEN1ZsQXBjSUl0ai92U2d0eXpOU1hMZ3c2azQr?=
 =?utf-8?B?TklVUlltVXIzcEpvWDF4QUErckZlUllZY3hVaHplZUpvWHNqM2Z6aHkvVXpv?=
 =?utf-8?B?VjZ5YWRxT0l1ZmpENTBJanozRmIybWVCaFVsVHE0QnpldzdBQ3dnVmxLL05S?=
 =?utf-8?B?L0QraGtnZEFtR2lTY2h2dW9PWlBrUWp1MkhlRDVyK3FNRXg4cVFnQXpybVEy?=
 =?utf-8?B?R21pZHJVd1B0aEk2V2lIeVVGcG9TTG9tcDMydHNHY2tFZTJwNVkxb3E1bWQ0?=
 =?utf-8?B?OWZYeDNRNzZXZnRnQkRkZ1hGRjlaVWZ4MzhXdUxYQVlwYS9sc1NGMkdPRDFn?=
 =?utf-8?B?OGN2ZENpWjNJVCtrQmtZRWphRGlCL25xaUpkWlJqdU5GOXN5Skl2UDh3R0tU?=
 =?utf-8?B?SmlqcE5aQkEzQ1hYYUExaWd5bjRuVENSNG1kOC9CSy9Hb0R2aTZLelJEM3RU?=
 =?utf-8?B?SVArMmYwWXlQL0JHZFJEOUtvc3k0MWdRVUdOOVBaM1NnZno4K3FtTXNNN2FJ?=
 =?utf-8?B?eGF0Zmpya3V4T1ZHR0Q5TXJyZ3phelJadUhMOUI1MVRGV2x1bWhrZVdzN3hC?=
 =?utf-8?B?SXRuc29zL0JKUU9FWTBMSEc2bEZDT0dEcllKdkgyOWNlbElnMExSUzIxUkYr?=
 =?utf-8?B?UXRRQXpWeHJIeDVvWHQyZkdBWkFFdXdyZXdPV2hlQVZlZkZvTDAzZlBsQm8w?=
 =?utf-8?B?SGl2eVV6M0loRGs5M09mVjA0bVFtY05vSjA1WlRhdHNYTWRzNktIZ1hqazRy?=
 =?utf-8?Q?OR2HZxhJw1hLg3oeKtmrjYoWD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543b7e76-96fb-4370-905e-08dc9476fb0f
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 17:56:32.0745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0OGKlTXZwCH173QO9gwy9TWQ29cYKKzL3nFcPDDpK97Bz8+PQKS4eOLQ3jVgQoTtiFTq6i89RQallwEWCSLfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5761

Hi Dan,

I added a response below.

On 6/21/24 14:17, Dan Williams wrote:
> Terry Bowman wrote:
>> The AER service driver does not currently call a handler for AER
>> uncorrectable errors (UCE) detected in root ports or downstream
>> ports. This is not needed in most cases because common PCIe port
>> functionality is handled by portdrv service drivers.
>>
>> CXL root ports include CXL specific RAS registers that need logging
>> before starting do_recovery() in the UCE case.
>>
>> Update the AER service driver to call the UCE handler for root ports
>> and downstream ports. These PCIe port devices are bound to the portdrv
>> driver that includes a CE and UCE handler to be called.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: linux-pci@vger.kernel.org
>> ---
>>  drivers/pci/pcie/err.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index 705893b5f7b0..a4db474b2be5 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -203,6 +203,26 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>  	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>>  	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>>  
>> +	/*
>> +	 * PCIe ports may include functionality beyond the standard
>> +	 * extended port capabilities. This may present a need to log and
>> +	 * handle errors not addressed in this driver. Examples are CXL
>> +	 * root ports and CXL downstream switch ports using AER UIE to
>> +	 * indicate CXL UCE RAS protocol errors.
>> +	 */
>> +	if (type == PCI_EXP_TYPE_ROOT_PORT ||
>> +	    type == PCI_EXP_TYPE_DOWNSTREAM) {
>> +		struct pci_driver *pdrv = dev->driver;
>> +
>> +		if (pdrv && pdrv->err_handler &&
>> +		    pdrv->err_handler->error_detected) {
>> +			const struct pci_error_handlers *err_handler;
>> +
>> +			err_handler = pdrv->err_handler;
>> +			status = err_handler->error_detected(dev, state);
>> +		}
>> +	}
>> +
> 
> Would not a more appropriate place for this be pci_walk_bridge() where
> the ->subordinate == NULL and these type-check cases are unified?

It does. I can take a look at moving that.

Regards,
Terry

