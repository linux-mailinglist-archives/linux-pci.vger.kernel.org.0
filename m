Return-Path: <linux-pci+bounces-10474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAA29343B5
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 23:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B86602852DE
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 21:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96849180A63;
	Wed, 17 Jul 2024 21:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ELVs74kX"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730D15B05E;
	Wed, 17 Jul 2024 21:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721250876; cv=fail; b=bTR4ZB+ENDyodmDgqOHqKLBO+20NpvXCNVQD/NDLnZuX+kuTjoPmezi8O9nLtzkSFKu70IvbsGxGHunGaZB+uCQ89DUu7p6b7mza5YyhvIYXLEn28WO5m1lVY5+F1DWBsmM/VRFynsOMbFDMTnMvijN4Zh/f2j48OkTtOTYgREI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721250876; c=relaxed/simple;
	bh=XljSIbrJJ+47vV8NGd/Mfg8uzL3dWpArZT74xo7CIWg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=s9UnepukaOAlub6cgqJH83hrH9SzKpyJbnR6yo7NKjeEB8FZfbM+Ncix7bJRCQf64BFuMWSg8M1SwvcG8E8EXlbGxn1TUBo9VdYy6pM/Ap+gR1CICbmV4mdwD3TFkclVry9SNMey7Wp5fOZqokfHttpoD3o94+x+KkoHR839Gfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ELVs74kX; arc=fail smtp.client-ip=40.107.212.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQi6wBmOpkzTOiPk3f4PuEkW1h9WRDIPvtVW2bkuxI6lrHGiT7MOnyfRCoCrTB4Lbo1zDFJzym9KicNxnB60YbopUuolGBbrIlzB/vOA5UQez//y/28LQKxSBJTDHglgTmLd2tX0Nuqc3R6Tx5lleQ7Y+FCa6T2IUUtRX2Rnqew+qJq2tzsbOy4y1NP2xLxruhOc8e9PfP068Cl+/DYVOOoEFvUiSG3mh2Vcs1eQ75Xo1ceYmOjbzgB6wCYGDTVjQINKv9/SsEaI4ZKGwWzX4+0LVbfANvL6im2mjlHDxGX3PuUss4l5AG4V8UHOTcRlSrjyVmPpOZSPkyAnJr8eUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLdVFGeWcSIaOqUV0J1ND9M1BBNxVFI1Av31aBqV3sQ=;
 b=OFj3tNWHOIkgFu9BP8c5Yp+QNqfdkYMC8GW+zO2FhhIKqBOfDSv8sOpuGmzUbdaA9QYLzt28epWY0KTWsPl5BMy2OkC9T0kpXlz1p8YwYiV8Z6nBjnZOrVtOD1uN7iDY2zqFPmBmprn7+wgwVCK3mmbzzNgENtTunsCOhru/+BiHmv6z9516E293cdRBYL0AS8NQH3esFAVZeadX9kspGVZTntnLG8zZGrDnfriry1a/93+sUCkWAxvgUR7gXLrgLddyahsW7mdR+mwag9LYUAm0M4NOzF+IF3xmlMEULfaElrjHKqCus053JZtOGaxNNk3zZ6UpNGtYGFKhvH5wVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLdVFGeWcSIaOqUV0J1ND9M1BBNxVFI1Av31aBqV3sQ=;
 b=ELVs74kXkjis5SekMgykdqz/Jy2BueMQNZO6Y/zRBKle5IOXZhNqIyzGthKZMAajorLA45NaS4ipdK7gXjnv2VZF8SxqhH1WesBpMC4HeOEcvyzqsmxEUoE5Mps4mPU8SsCN0jg2b3Z386afihNqtSwRwbassLG+T43+xsTgQyA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by SA1PR12MB6678.namprd12.prod.outlook.com (2603:10b6:806:251::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Wed, 17 Jul
 2024 21:14:29 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%4]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 21:14:29 +0000
Subject: Re: [PATCH v2] PCI: pciehp: Clear LBMS on hot-remove to prevent link
 speed reduction
To: =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>,
 Hagan Billy <billy.hagan@amd.com>, Simon Guinot <simon.guinot@seagate.com>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20240617231841.GA1232294@bhelgaas>
 <27be113e-3e33-b969-c1e3-c5e82d1b8b7f@amd.com>
 <cf5f3b03-4c70-7a35-056e-5d94fc26f697@amd.com> <ZnKNJxJwdtWRphgX@wunner.de>
 <73fd7b2d-9256-9eba-70be-d69ea336fd67@amd.com>
 <6014882f-0936-ec31-d641-112a70eb2749@linux.intel.com>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <ca2b8c13-a7d8-e157-fd1a-770ee8cb10c1@amd.com>
Date: Wed, 17 Jul 2024 14:14:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <6014882f-0936-ec31-d641-112a70eb2749@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0059.namprd02.prod.outlook.com
 (2603:10b6:a03:54::36) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|SA1PR12MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: 791733ce-28d8-4bdf-bc37-08dca6a57215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTJWZGU3TUMvdG5yZVBmRk93RTVwVy9KbHFabTh3NjVwcHpBbmFUQmV1TjFv?=
 =?utf-8?B?WDUweWE4dE9RYXk2YTVzempsc3B6T3NxTFRoRDhuckhxY1BFVXp0dE1nTVRV?=
 =?utf-8?B?SnA2eEJUTWxDbllwTUxhbmY1MTJKY3RDc0N5ODAwdC9xMk1WY09tWHFvM1FY?=
 =?utf-8?B?RzFwS1FPRE5meGNzdDhKaDZWQ2Z2QkZVNXlmZ05Udy9UbjVsTC90aXZZSXFL?=
 =?utf-8?B?VnNseU9QaXZzQjJ5eFphLzVDOWM1RmNYV3h5R2RaZThJdUg0TGtGL1UwOVlm?=
 =?utf-8?B?bXJmeGNndVlRbHNzRjBIdUg5ZDZ0ZFRidEZ1cDRMTCsrTUgxcHZrR3ZhSFZq?=
 =?utf-8?B?MG5jYmdtQUlSQ0trUjVxZ3RuTkF6ZDBFZCtzVTljbW50cVg0WmJPMzlBd3Bh?=
 =?utf-8?B?V2EwZENzdTA5dWZ2NDVFZzR2L2Y3KzlFTzJIRmZvYk1nRXBLMXR4UDU5cDZQ?=
 =?utf-8?B?aU9PdTh5eEUvbmkzZkxuVXFLdlpvRDZWVEtyV1ZJT29Qcm5TVkhlTXlUM3BD?=
 =?utf-8?B?QmU2L3grWWhaN25yam4zL0VsUUZCdzFjamNRYWE4NE83eWJxcGw5Wmh3cGxX?=
 =?utf-8?B?N0VpRENheGlVNUdhTVAvZEIzd2pyTlJkWldMVm1UQmdyRnB3WUQ0UUdMMnF2?=
 =?utf-8?B?NU5ab3RJbXREYzdMN00rSTlwUzQvK01TRzViUWNRTzYxbm5aVEIvOXdad2x5?=
 =?utf-8?B?SGM5eXp4Rnl6NlErS3lGTDFkZEJsOHMrVmdwMklkNXI5SmQ5Rlgrc3BIS2JY?=
 =?utf-8?B?aENscXZkb0hKRyswRUI1TEE3VTVYVkw5Y0tKMXROTnJYdlFFeFY0ZFBhQzJv?=
 =?utf-8?B?SmJYYVJ1Si9TeE5iRTJpdmNEMXdTV1Y5Tk9kSFc2ZndRblRIdHhTYXJ1Q0Vv?=
 =?utf-8?B?dXRkeUMzYWFOZ2NDZGkzUDhUMTVKWGFUOHhFTVJhekt2UU9GQXFQUmxpVW1J?=
 =?utf-8?B?ZW44Z3dlZkVyYWNkNE5wVlExd0ovMzE1c01UL2F6WjVrWVZTQVFqQzY3MkV3?=
 =?utf-8?B?TG0xSHFWSkFMdjVZbnQ1RklsS1cxTi9PeVU1M2VvTCtkNStVVTVNMVAvSFNM?=
 =?utf-8?B?RzBJajJSRkFTaTUrWVNBRHhVdjBYSWRRV25HakFOQmpTTzhLUFVFT1loVXZN?=
 =?utf-8?B?cnJVMUU0RVB3U0JFTVNiaHNxbjhVSEZLMm5QRFJLMjhPWTJBazdIemJDOGlx?=
 =?utf-8?B?eWtRSG5xSDErTmZLYnd2VDFwWUlnTjRZK05Fa3YzU01VUlBtSktnK2V4Y1d6?=
 =?utf-8?B?eHUxbFUrbnJqR00zZU4wcVFObnpNMHJsTmlnS2Rwa3JnYzVPMlZrU1N0RVlh?=
 =?utf-8?B?V1ByZzdScnRqUjM4ekMwNDNlTW5CUEtiemJuNU5BbjZ1SFFTTGd5MldWNFRG?=
 =?utf-8?B?Um9uWjNLU1VmT25MMjEzYmFRb1dlRitjVHBvdmo2a2JDUEFSODRmdnZPQStk?=
 =?utf-8?B?dkw0RnlKNENISGFpVkxUNFhtV3U5aUtqRHl4dlAwOVJxWHlJMjI3a3JDZ0Yr?=
 =?utf-8?B?QjM1bXNGYXljRkFHQm1vb1JlVGk0eUduYUFacno1a1hzYkhsV01YZVZ6djk5?=
 =?utf-8?B?Z0RhM2tOWk5YdDhRWGRLVFdvOG53UlVhTmhGSzY4UHBhNHRwdVVNTytOWU5t?=
 =?utf-8?B?SXdVMWlnMjA1MnFNM2swM1p4NDNHZGg1clQzQTl4SXZDYjJSN0dCUnBxRGs4?=
 =?utf-8?B?SzhieER6ZmZuWGsxNUtHL2RwaFd2L1JPQTdMUUVBQ3RlaUp4TlNuOThSNUNt?=
 =?utf-8?Q?5zrp0YkNX3h/tBEAGA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0xFTS9mWkFZcUY3ZDhlQ2JZQnMyemU2Y25rQnFqZ25mUGFtYm5XSE4wZzI5?=
 =?utf-8?B?eHhqU3hQSXNSeE95b0JVa2l6V2dhbTBiZnFzWndwV2lUdTRMVi9wSVVoNWty?=
 =?utf-8?B?cHp2NWtXek0rTlFka0QzN2I3cW02Q0Y5S0M2TWJ4bXZUK1dXTVkyaGZBNktl?=
 =?utf-8?B?MHU4OXZiN09PYkhNbDlUNnZEZklETTNITGVSbm40Q2JOUXJEeCtpOU42bzFF?=
 =?utf-8?B?NzAwVmVXQXpZci92Q2dSVmdnSGZRc1dXU1dJdnhtZmJzT29KOHAvM0lyalF0?=
 =?utf-8?B?QzJpZzdoQkNMVGwyaGorT1dJWUxLZXlDdVVjYzVCaDNMZzlCRS9SbXA4U1U1?=
 =?utf-8?B?a0JtYURtSlBzMk83ZHkralVCd1k3NGNieWVhVVlOVnZ5K0wvUitLeGpKRjN0?=
 =?utf-8?B?QjdUaVdSKzZpUzVuaHVhejkwWDZRL21QNTVUaVRsYUdjb1I0cEozTEhLdnVW?=
 =?utf-8?B?VDJGZHFnQWF5T0ZCeHBmRVhUbkdRSHJZMG1EcnFUa3Z2TGF1MUJtOG1FazN1?=
 =?utf-8?B?TEROcmNaUmxzdUdYbnJkY2IzYVVCditRK2FYVmIyc0NTd3F5VFFJM1luczE2?=
 =?utf-8?B?bDJBQXN2TnNiZ2FaK0liRkZVMFA0Z3FOSjFXZmw3UUd6aVEvMWd3bFZna1px?=
 =?utf-8?B?UEkyWExiQ1VvNE90aDJTeFFsQW0yYXdrem5oSFFSc3NlcXZRUzhmOVBWQXEy?=
 =?utf-8?B?T2VjMkFtakhnQkg4OWpaOWxjQ0ZEMUR0bUhKKzZkMkhwRGNSZ0FjY3BnSnJE?=
 =?utf-8?B?LzRhTzNGTWxQQ1l2cnZtUWxsK2xwbFlRak8ybFo4L251Q2lnRnh1enIxdzFE?=
 =?utf-8?B?aUx0MDhlSTNnNnUrTmVwSVRFaWwyQXYvYzFpT1JLZzNLbkR5VzUxeVFqMHVL?=
 =?utf-8?B?eW5yb21VMW1BK0FEYnRWQWp4cUE2SVZYSlJodUtaMjV1N3U4NGV1aDhlY0lY?=
 =?utf-8?B?SmcrWEd5cW5CNlRDQ0ZzcFAxOXVrUU8rNlFhWUdKYlJRRE5sSGVoS0RxVGFB?=
 =?utf-8?B?eklEMFV6SlRMU3VWSWp2SzE1b2dEeFFzQlZ6NUpkNlRFQ0h5ZS9pajYwdGRS?=
 =?utf-8?B?Y0s5clVLVGIzLzltUXlGRysxT3Frc3VReTBESW1pY2wwWW9qeFRyUUZZbzkx?=
 =?utf-8?B?d01vNjVRRzVnNVkvWXlhN0xMNk53R2RyWkJtcmUvNDZzRnVvN2x4cHRjdjMv?=
 =?utf-8?B?NVJBYklYd1NIZm4zbm9VUXVGakVpbFlSMW1XNTU2M2d4RWN5SkVhSitDTlFq?=
 =?utf-8?B?bnVTTklNMGFTWnhXQW5jN2Zta1RjcnZIVnQzNEdkMHIreTQ0WEo3RGkxcVcx?=
 =?utf-8?B?UndSeDd0ZzFLdXlBb2VQTUhCZkJrR0FPREE0Q0QrUGNQYVQ1RUdFZ2d5bER0?=
 =?utf-8?B?UmNxK2NNQS9QN1NhUE1Jb0RYakFSeFJGdmpyWFhlekFIbE93OG0yc25WYzFL?=
 =?utf-8?B?QTlZYXhJaWVXVlpBSEdpSmlIbTZuRTRGSTFGUGNOZ2xxVWZzWWZTYW8vQ3Vq?=
 =?utf-8?B?TndnSGVNY1VGdUo5YmRIdGZtZUhRMFZzOFhtRFVEY0lNcWdkYW44MWdMeVVv?=
 =?utf-8?B?R1p1NE0wc3o0bkFvcktiNXhVYzVoamZ0N0oxb2I4bGtGRDJwRHpzVjUvaVRz?=
 =?utf-8?B?elRiZzgvRUtrSWJjTVdPQ2JoVEM1RktuWHJjN0hkMFNYWlFLR09CN3FMd0tQ?=
 =?utf-8?B?cXhIZWxEUW9nQVpPWXQ2bU5mQW5Ic0xwYXRpWVlaS1M4blovc0Y0QVhscXdh?=
 =?utf-8?B?bk4zTS9qS2hkcUFraVBjUElqVDJ2RE8wcVBVUlBvWm1sSmlzYTlmQ2VWZkl1?=
 =?utf-8?B?anhiMDE1bDlYRVBPcDErdVB2aFFsYTV6L3N4VTRLL3Boa2Vvb3RTM2p5dVBJ?=
 =?utf-8?B?YkV0Ky80MUNiN3ZNWElWTmtSdm9pWEVQaFNmRnJtRWJqUEYwRzZrQTdmWGto?=
 =?utf-8?B?Ylpqd044YUlUYUpTVFNoVDNvZjNGYkxmM2F2bEV6bE80ZmQ3REpnTEx2Nyta?=
 =?utf-8?B?V2phMlkxYThHeWpQak1YcUlRSWdjWEJUejFuVHVDR3ZwMVZ6L1BtWkFwcFND?=
 =?utf-8?B?cGFaaVV4cFZTZko0NVhVcGYzS3o1ZXBCbjF2SHRBVVdBeHhaanJGczFNOGZr?=
 =?utf-8?Q?pTHW6inslbWLCOBLBBZW1aA1i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 791733ce-28d8-4bdf-bc37-08dca6a57215
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 21:14:29.5396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqUopaG/kMbU+pdRXnH+63wMHl1aTw1w8B3XpjSXhSoU7/Ei4YoQ6noLJv2ysVDPF5lfpykoDVVgkYwb62sZeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6678

On 7/9/2024 3:52 AM, Ilpo Järvinen wrote:
> On Tue, 25 Jun 2024, Smita Koralahalli wrote:
> 
>> Sorry for the delay here. Took some time to find a system to run experiments.
>> Comments inline.
>>
>> On 6/19/2024 12:47 AM, Lukas Wunner wrote:
>>> On Tue, Jun 18, 2024 at 02:23:21PM -0700, Smita Koralahalli wrote:
>>>> On 6/18/2024 11:51 AM, Smita Koralahalli wrote:
>>>>>>>> But IIUC LBMS is set by hardware but never cleared by hardware, so
>>>>>>>> if
>>>>>>>> we remove a device and power off the slot, it doesn't seem like
>>>>>>>> LBMS
>>>>>>>> could be telling us anything useful (what could we do in response
>>>>>>>> to
>>>>>>>> LBMS when the slot is empty?), so it makes sense to me to clear
>>>>>>>> it.
>>>>>>>>
>>>>>>>> It seems like pciehp_unconfigure_device() does sort of PCI core
>>>>>>>> and
>>>>>>>> driver-related things and possibly could be something shared by
>>>>>>>> all
>>>>>>>> hotplug drivers, while remove_board() does things more specific to
>>>>>>>> the
>>>>>>>> hotplug model (pciehp, shpchp, etc).
>>>>>>>>
>>>>>>>>   From that perspective, clearing LBMS might fit better in
>>>>>>>> remove_board(). In that case, I wonder whether it should be done
>>>>>>>> after turning off slot power? This patch clears is *before*
>>>>>>>> turning
>>>>>>>> off the power, so I wonder if hardware could possibly set it again
>>>>>>>> before the poweroff?
>>>>
>>>> While clearing LBMS in remove_board() here:
>>>>
>>>> if (POWER_CTRL(ctrl)) {
>>>> 	pciehp_power_off_slot(ctrl);
>>>> +	pcie_capability_write_word(ctrl->pcie->port, PCI_EXP_LNKSTA,
>>>> 				   PCI_EXP_LNKSTA_LBMS);
>>>>
>>>> 	/*
>>>> 	 * After turning power off, we must wait for at least 1 second
>>>> 	 * before taking any action that relies on power having been
>>>> 	 * removed from the slot/adapter.
>>>> 	 */
>>>> 	msleep(1000);
>>>>
>>>> 	/* Ignore link or presence changes caused by power off */
>>>> 	atomic_and(~(PCI_EXP_SLTSTA_DLLSC | PCI_EXP_SLTSTA_PDC),
>>>> 		   &ctrl->pending_events);
>>>> }
>>>>
>>>> This can happen too right? I.e Just after the slot poweroff and before
>>>> LBMS
>>>> clearing the PDC/PDSC could be fired. Then
>>>> pciehp_handle_presence_or_link_change() would hit case "OFF_STATE" and
>>>> proceed with pciehp_enable_slot() ....pcie_failed_link_retrain() and
>>>> ultimately link speed drops..
>>>>
>>>> So, I added clearing just before turning off the slot.. Let me know if I'm
>>>> thinking it right.
>>
>> I guess I should have experimented before putting this comment out.
>>
>> After talking to the HW/FW teams, I understood that, none of our CRBs support
>> power controller for NVMe devices, which means the "Power Controller Present"
>> in Slot_Cap is always false. That's what makes it a "surprise removal." If the
>> OS was notified beforehand and there was a power controller attached, the OS
>> would turn off the power with SLOT_CNTL. That's an "orderly" removal. So
>> essentially, the entire block from "if (POWER_CTRL(ctrl))" will never be
>> executed for surprise removal for us.
>>
>> There could be board designs outside of us, with power controllers for the
>> NVME devices, which I'm not aware of.
>>>
>>> This was added by 3943af9d01e9 ("PCI: pciehp: Ignore Link State Changes
>>> after powering off a slot").  You can try reproducing it by writing "0"
>>> to the slot's "power" file in sysfs, but your hardware needs to support
>>> slot power.
>>>
>>> Basically the idea is that after waiting for 1 sec, chances are very low
>>> that any DLLSC or PDSC events caused by removing slot power may still
>>> occur.
>>
>> PDSC events occurring in our case aren't by removing slot power. It
>> should/will always happen on a surprise removal along with DLLSC for us. But
>> this PDSC is been delayed and happens after DLLSC is invoked and ctrl->state =
>> OFF_STATE in pciehp_disable_slot(). So the PDSC is mistook to enable slot in
>> pciehp_enable_slot() inside pciehp_handle_presence_or_link_change().
>>>
>>> Arguably the same applies to LBMS changes, so I'd recommend to likewise
>>> clear stale LBMS after the msleep(1000).
>>>
>>> pciehp_ctrl.c only contains the state machine and higher-level logic of
>>> the hotplug controller and all the actual register accesses are in helpers
>>> in pciehp_hpc.c.  So if you want to do it picture-perfectly, add a helper
>>> in pciehp_hpc.c to clear LBMS and call that from remove_board().
>>>
>>> That all being said, I'm wondering how this plays together with Ilpo's
>>> bandwidth control driver?
>>>
>>> https://lore.kernel.org/all/20240516093222.1684-1-ilpo.jarvinen@linux.intel.com/
>>
>> I need to yet do a thorough reading of Ilpo's bandwidth control driver. Ilpo
>> please correct me if I misspeak something as I don't have a thorough
>> understanding.
>>
>> Ilpo's bandwidth controller also checks for lbms count to be greater than zero
>> to bring down link speeds if CONFIG_PCIE_BWCTRL is true. If false, it follows
>> the default path to check LBMS bit in link status register. So if,
>> CONFIG_PCIE_BWCTRL is disabled by default we continue to see link speed drops.
>> Even, if BWCTRL is enabled, LBMS count is incremented to 1 in
>> pcie_bwnotif_enable() so likely pcie_lbms_seen() might return true thereby
>> bringing down speeds here as well if DLLLA is clear?
> 
> I did add code to clear the LBMS count in pciehp_unconfigure_device() in
> part thanks to this patch of yours. Do you think it wouldn't work?

It works with BWCTRL enabled. Just my concern would be to keep the 
clearing in pciehp_unconfigure_device() and not do it inside 
POWER_CTRL(ctrl), in remove_board() as per the suggestions given above.
> 
> But I agree there would still be problem if BWCTRL is not enabled. I
> already have to keep part of it enabled due to the Target Speed quirk
> and now this is another case where just having it always on would be
> beneficial.

Correct, it should always be on to not see the problem.

Would like to have this "LBMS clearing fix" accepted in sooner since its 
breaking things on our systems! :)

Thanks
Smita.

> 
>>> IIUC, the bandwidth control driver will be in charge of handling LBMS
>>> changes.  So clearing LBMS behind the bandwidth control driver's back
>>> might be problematic.  Ilpo?
> 
> Yes, BW controller will take control of LBMS and other code should not
> touch it directly (and LBMS will be kept cleared by the BW controller).
> However, in this case I'll just need to adapt the code to replace the
> LBMS clearing with resetting the LBMS count (if this patch is accepted
> before BW controller), the resetting is already there anyway.
> 
>>> Also, since you've confirmed that this issue is fallout from
>>> a89c82249c37 ("PCI: Work around PCIe link training failures"),
>>> I'm wondering if the logic introduced by that commit can be
>>> changed so that the quirk is applied more narrowly, i.e. *not*
>>> applied to unaffected hardware, such as AMD's hotplug ports.
>>> That would avoid the need to undo the effect of the quirk and
>>> work around the downtraining you're seeing.
>>>
>>> Maciej, any ideas?
>>
>> Yeah I'm okay to go down to that approach as well. Any ideas would be helpful
>> here.
> 
> One thing I don't like in the Target Speed quirk is that it leaves the
> Link Speed into the lower value if the quirk fails to bring the link up,
> the quirk could restore the original Link Speed on failure to avoid these
> problems. I even suggested that earlier, however, the downside of
> restoring the original Link Speed is that it will require triggering yet
> another retraining (perhaps we could avoid waiting for its completion
> though since we expect it to fail).
> 
> It might be possible to eventually trigger the Target Speed quirk from the
> BW controller but it would require writing some state machine so that the
> quirk is not repeatedly attempted. It seemed to complicate things too much
> to add such a state machine at this point.
> 

