Return-Path: <linux-pci+bounces-35824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 321EDB51C41
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 17:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62D385456B0
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 15:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B898E314B67;
	Wed, 10 Sep 2025 15:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b1RHwcQQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F25321F4C
	for <linux-pci@vger.kernel.org>; Wed, 10 Sep 2025 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519161; cv=fail; b=ZRsuLaMBvaZLmTnQ6lLikBxGqX8PQZ5FamYJzmQkPFqdwiN1f7PBotOAkd8caE9OkukUe89gEHnDRzFGJGZVjaftcmFbHtSwCKaJ6eF4EYDagyW+av7osYChJBFWyMB4LBInCqQlc+giFedHQ0LYAvR2la+VAEyf977yL9Dvf6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519161; c=relaxed/simple;
	bh=zna9BIXuvaEJQVhdjwtBzbROu0d0C/Qi+STNDVfw1kw=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=i2r9NYr/EDDyny3t3gfzx6LcKlsnnY0VHZqykBEGSJnMHDfNcWtnYALMGz4ibfD01FtG37DCx1D5gEIs2dF98zyl5iqaKpyK7fOaba0qrnyWZ05jj2LlY4xgNeiDD28dQ0TUiz5KNW+NUVfYEkcvtRblIVwyp48BukeMF45aNFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b1RHwcQQ; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757519160; x=1789055160;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=zna9BIXuvaEJQVhdjwtBzbROu0d0C/Qi+STNDVfw1kw=;
  b=b1RHwcQQfiLlJ0c/QY+QeFh/W57ksNVJKtAdR5Ywdnikp5tOnrc2Uxxt
   eHavf4WXP+BSGP01/vSr83SX6LsQ8Gvn1X6tsmvFxR5JpBSFxEA8vuUf8
   W7NlVCycP0szfXy/0OcNv9LNug3I/4+bPtn21tELVOW+AMrnTkFzaz3Ea
   CM2PawV4NR7+4yNKB75GofY8dN1VxRO+5NwYV9l808vpFBLYHo/9iCxHp
   O73lLLG2+T1GNS+2nqtsR+ZL0gc3soevyh/LbnpFyjki8DBjK6+x+RiaS
   e11F2/JLA0QKP0aXk49VWr1/YTITqZihoCxPb+3Bq57N9ryo478iaBPYN
   Q==;
X-CSE-ConnectionGUID: tlL1ch7JRDiBS7NAu22MXQ==
X-CSE-MsgGUID: uWQ7NDkcR3qgEbMeaJeyiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="70525472"
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="70525472"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 08:45:59 -0700
X-CSE-ConnectionGUID: j1F6nuHeSaSXyaXBuu6Hqg==
X-CSE-MsgGUID: 8W9i2tRvTimxO/inlKximQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="210551133"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 08:45:59 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Sep 2025 08:45:58 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 10 Sep 2025 08:45:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.71) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 10 Sep 2025 08:45:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3UqR35GvNxoku5Jxl6xTpwRCKw7Y64Qynr+FxMo6Qg3y8uoY9qKV+2slY+IWBj+Yc7nlnKec93BDkbaeLv7sO/drZVxBiMsqS+Tyrs27CRBu/EJQ2kqoAdYZq4QVyoHZVrunbDOMX5hgqLgQ6rx0uyA+njYdzG5C6fu+/QAquiVmhUFvCvKq8eNlGGIKRCEG+hQ9UERNGnYZzFKGjiYzDokBQRpWv0wpnOc5D9DYXVJfX5ys2kpgv0IGr907mb3GPhpANokYtVkoBxpdOI1Eksybri0/O5wNKB4meHkhl9ac6T8kVmGwygu6Z2YVsHz2mSP0IF84euWmGufBiTf8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQWcpKY6KYsZkYn4RLJJoaCsrGd3jZ5EyZTdgo8QcQM=;
 b=FogXhJQP/FwviHjNlKvk52gmYrQCvVvZtxwWjqf3SgneiRqs4ezYS92FnEi3vTDAOv2nbOujyBMNeyFgU8EEnPCefjTRBZvy+L5t8Mgjn0TuPErXIWw05V5qGGozMKf++wfktZhLwcf+7FvD1hQEpulv+usDL36lFKIJvE6eydUDVU/wtTHCTefKCeytVsNviCO6f8CezAdWVJ9Q59Cqpolc/Q5y3Vp3x5gQ0LUT6bRBnZzjt8mQ8wgzeeF0RiA42K+PP6IwqAbunKAp0QSdL/0XrhWY42dP3MnRr8UhArus9OTD+DXv39t1uisqNKwWy6if2zrx9Mg4ghQ2hmwqaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB7703.namprd11.prod.outlook.com (2603:10b6:a03:4e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 15:45:55 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 15:45:55 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 10 Sep 2025 08:45:55 -0700
To: Alexey Kardashevskiy <aik@amd.com>, <dan.j.williams@intel.com>,
	<linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>
CC: <yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>,
	<gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Bjorn Helgaas <bhelgaas@google.com>
Message-ID: <68c19d33eabba_5addd1005b@dwillia2-mobl4.notmuch>
In-Reply-To: <47a21e9e-5749-40bd-8207-efccc747e7e5@amd.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-5-dan.j.williams@intel.com>
 <c2019b3e-f939-49c8-82e8-400b54a8e71f@amd.com>
 <68b0fd1ac2ade_75db100a3@dwillia2-mobl4.notmuch>
 <a7947c1f-de5a-497d-8aa3-352f6599aaa8@amd.com>
 <68ba33dfac620_75e3100a0@dwillia2-mobl4.notmuch>
 <67382369-d941-48dd-92f6-8bbad7b26b60@amd.com>
 <68bb97518dea6_75db10067@dwillia2-mobl4.notmuch>
 <70c5399e-debc-48ed-a60b-e1921c111690@amd.com>
 <68bf77c923ff4_75e31005a@dwillia2-mobl4.notmuch>
 <c920fde0-0241-4ca2-a75f-384f6f18a255@amd.com>
 <68bf886bc9271_75db10029@dwillia2-mobl4.notmuch>
 <47a21e9e-5749-40bd-8207-efccc747e7e5@amd.com>
Subject: Re: [PATCH v5 04/10] PCI/TSM: Authenticate devices via platform TSM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB7703:EE_
X-MS-Office365-Filtering-Correlation-Id: f40ebbbc-5627-4c5c-855b-08ddf081210b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VU9FV2ZUd0xhak53bU94RlBVR1dHZnJOOFZtMnhER05ZLy82RXdUU0J5ODJI?=
 =?utf-8?B?N0I2WnByTmtkMEs0c0psL2NvQ2lvMGtMZTh4OUlrN3A5UTNyRVl5aUFrbTlK?=
 =?utf-8?B?WEt2SEw2RXdoZmtlbTBJVjJ0NWZrcFp5eCtqWjVIVDZRSnJDS3IzN0ZMc05M?=
 =?utf-8?B?UXJLOGxsbTZFdStBckc0NVBOVTlWWjVlUVZnNDVkdkl1RTBSM1kvMEM0ajMr?=
 =?utf-8?B?M3F5MXJuVXdIUHlPYkJRbmh3YXEyL1E3UWZFcUdYemIyeHBFaS9JbVBNcStl?=
 =?utf-8?B?U203eS8zTDMrTDV6d3hqZUNOTVUrdE5tcmxCR0szNHZqWDBJQXY0cHhBSzBP?=
 =?utf-8?B?amxuZlM5ZW1RKzFKTnBuSGpmWEgrcVRUWnNkR0g3Ykp2WHZjNGdxTFI4blNp?=
 =?utf-8?B?OStPajJaM3NYc20rKzAyV0ZqK3RyT0pvMmpTd1FSRlFpQXF2cEp4cWl5MVVr?=
 =?utf-8?B?SXFqclg4UjBmeDVseUJtSWJLaXZMSU5mMGUwL1oycDB4dXp3RU1BTVIwT1VH?=
 =?utf-8?B?RXd1WXF2S2dGdmxldERKWWxWVW93Q0RxUVY0Z0NZcDFLc0ZuYlpFS2ZKNDd3?=
 =?utf-8?B?b29ENlVTUVVETTdHY0pKajR1QlpuTTVIMjBxWEFUT0E3MjlYT3pGdlhnZncy?=
 =?utf-8?B?UHZrQVgxMlRCV1RjQlh0T0V3TDl4TUU2WGZHdStQNUkrbW10N3V6TFhiRWVH?=
 =?utf-8?B?T2ZVTVFwOUc4cWFhMmxpbUJVTWtsSGJROVFRenNkeHNURElTZkpLdlFZQzJE?=
 =?utf-8?B?cEFoa1BScjRFSkh1NjNjblovYXVQRGFQVytzbDl5Zld2UENsU3lmNlRCdmJJ?=
 =?utf-8?B?eXdIMkg2RzZGMlZZVGNlVHp0TWhSRDROUWtDTUhrV0xoQnNYamJqTW84cytt?=
 =?utf-8?B?eG1GQ1I5cUtFVnN3MUl4TFhZOHBTY3dNR01MeG9neXR4cS95dldlYnQyWkNF?=
 =?utf-8?B?bm14cDdoUHh3cTlHR0dURDRiRlU1YXZDb3BXUkJTK01UMkQrYTY0SDhsM04v?=
 =?utf-8?B?WjVweUN4VTdCOFpnWDFJVzBhOE1PekZjZmJlaEFoUlpjSVkyRzhjeVBNMHZ2?=
 =?utf-8?B?elZWd3BzUkp6aDFFTk9WS1BZeWs0YVdvcllBRG50cTNQY0tqZXlPR200MlRO?=
 =?utf-8?B?RHF3WTBhMy90TEZmUXNUUEdNU0ZYM3p5UXhZSytsTThDSEgyZUtWZUpPN0JO?=
 =?utf-8?B?bXo2Zy9xOFNRM01NYU9sS25WSEJMaFY0eEFhd0JzTWVTVk9vbHNsTG5CVnhu?=
 =?utf-8?B?cFJxYm5vdGpIU3NIVWVydFgzUVM0TC8wMHE0UHJFenRTN1ovT2JrTUV6aEZs?=
 =?utf-8?B?T1VPU0pSNWdtbnFvRTJpUWxJOFd0UGZGZnc4NFIwcEZVQjNqM01yRWZPcGhH?=
 =?utf-8?B?Sk4wbWl1TFhPeDIxa3JpZjViM3NjcDZkajFTMjRISVFvTHJHSjQ0MDRJNm5J?=
 =?utf-8?B?b2pwQjNGVFJhZ3JTR05wM3JweGFkRXkvZ3VIeXdRSytZZmt5K1ArcU0rRXVZ?=
 =?utf-8?B?TXFBZ0RpeDl5WVAxM0gyeDRwSXB3blA2Z1ozWlVYQ2dzWHp1Nnp6bUg4eE5Y?=
 =?utf-8?B?NStmem00ZWgybERtTnBKcUJ6aEc3Qnd3bFdhVStrWGI3Sk5BSXRrd0VVRG1J?=
 =?utf-8?B?TWV0ZDF4SlRlWW42Wk9IRWtmZEFGaEpMeFpsMHV0UjlHZU43dFRxN2lzTGxa?=
 =?utf-8?B?Rkg1emk5TkovY2Nac2pBTS91NGk1a2JoK1FZSHJUdFNiL01WanExSGF6ZU5w?=
 =?utf-8?B?S3B0ak1qWTRMYWk0SWU4UlhnWnN0NEJnRUgrd05VWGRTTURCZkhpUDhmZjZa?=
 =?utf-8?B?cStOS2hWOHBDb0lnNStFaHU4MXl1aFBNYkVuUjJqcnB6bTNqVTdhNFI2L25J?=
 =?utf-8?B?TW1rN3JCRnYvU3RtS0dVZVNrOWc3S1c3VEhrY3dRWUkwWlFJQ2pFUk1QNEVS?=
 =?utf-8?Q?w08WKbkOkns=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUdPNmE5SW9VNGJoNkNObFpzZnd4cEc3cXVCeGlPSjU0Q3FnVlBta05OYjJM?=
 =?utf-8?B?OEVOSGNQbG54ejZOZlRyWHgvQ3Z3NTNZeW9IRWFXRW1OZ0lVbU05T2VEYlha?=
 =?utf-8?B?U2gzdFJ6alBsS29sN3ZHeHNQZ2oydTlBUWNzV2hDSXNZZHEzM0pjRU1ucTFS?=
 =?utf-8?B?YUZRem9VdTRaRGhxNVNCRkM4aVdzUEozRVVyRVY4RCt2MkxuTnhnNGxzRkRP?=
 =?utf-8?B?TzhxZ2dVbjNqY25INzM2QjhVNmxRdzFOQmlxZTJpVXR4dkZiYncwSGx2dEEv?=
 =?utf-8?B?R1hHbHlHQ2k1eXBTQWg5R1R6L0J4Z2pUT3lzTi9vR2FmYWZnU0xCeUM4cmNF?=
 =?utf-8?B?eVRNZFpwTXB3WGc5WEY5eDNyUEJqR0Q2VDZJczVvaUxiSi9PVG5mTHBnbGg4?=
 =?utf-8?B?Z0pPZ1RycEhzaWVXL1FSR0x5ZXNONXR2ZmFhNno1K0w1WlBsc0xtclNCWUNk?=
 =?utf-8?B?M3RXbk8wZW1TQWdHbjc3ZHpNRFFMd2tCSDRXT3ZNd0RCa2ZaNUlwQXhySXdK?=
 =?utf-8?B?cmlsTzJkWGxPUEF2NVRQdDZ6YVFJaDUrcThKZnRXcjh2NWtaUENkTnBWVklK?=
 =?utf-8?B?SEdyWU1McWtETzVKSjBlaXRqUXNXQXl4bHEreGNsNm9qRkxEYisxSFRQT3ph?=
 =?utf-8?B?RTBpc0JmeDNsZ1dxNlFud2xjZjZUcEZIVnF2TUlNR0gyK0wvYVMwYXFsWjQr?=
 =?utf-8?B?VWw4S0FpUEN5SUpVSlp5enJ4bEkrVXl5YVJVb09wbUhHT1FvY2RkTW5WS01N?=
 =?utf-8?B?dFVOT05lLzdwdjdqQjU4SnJhbjZsbTQyM2ZJbk9keTg3Tlg1RW9BVUFjS1V6?=
 =?utf-8?B?YXVvN2hmckRFbkhkYlVqQVdablgxSVJCeks4M3JvMk1xeG4wUXFXd21PT3dB?=
 =?utf-8?B?OGQ0WWg3VE12UUoyVWcyTUM1U3VBT2ZCN0ZFZ093ejdwUVlyZktaMzNHejgr?=
 =?utf-8?B?d0ZQT3h2TVViMWtqVjdGT0tXLzgwUnRUcTAxTDhhMWNlbVZsVHlHU05TMnBR?=
 =?utf-8?B?MWpHM0RucFRSU05iYldNZE9zVmNmUEEwd0FvNGw3ZHphaEVhMnNJRTB4d2pq?=
 =?utf-8?B?OURMOS9TVUZ2c2VTdlg0aERlT2pLVzlMbUlYcGp0anQycURJTUlBZkU3U29V?=
 =?utf-8?B?VElja2NNMVRyR0NtTzQrb1BaUFVDZ1F1RFVpYjFyU2RJN21Dd2JyaHpFY2xv?=
 =?utf-8?B?WWRXQko5MHIwTmFSWDR6eXZBRVFDK1paZGtMNkttUUdKSEtibWpjWlRoTmRJ?=
 =?utf-8?B?cTFNc004UTVxMENGL3preHpoSWxQUEVYdkdnYTZXYWhYNExlRHplOHhLWDJq?=
 =?utf-8?B?SFJacFl0NTNwdUtWMTBWN0kvOU1wclhuN1BnOS9oMkFDTnpabC9qNExQemFQ?=
 =?utf-8?B?ckRualZvSzJiejZzTlE2QUVmYlB6TXZaYVFydHY1N0tZeVBGQ3lGa00rM28v?=
 =?utf-8?B?M0RINXd0MXpaK1ZkdWxCeEhoM0pVd0gvdG5oQ0p6ZWNkaWdxR25nQzY2MGsw?=
 =?utf-8?B?Ym8xN1dJUndQZTlRV3RDOVNwcUdSdkwxM0laYzRKTFltYitsTTFTN2NqL093?=
 =?utf-8?B?SHZpdXpNSXg5cVRFREFTL3p5and0ZVpqV2x1TUlPcmN5QnZtTWd2OVVTYVM5?=
 =?utf-8?B?OWpqM0RCTlhPR216Y1p5eE83ejZ0ejVBOGxBdWpCdWw2MzJEK01qSVRaZEVB?=
 =?utf-8?B?OVlxdnllcVRwVGlwN3VROWJsU2xuSDhmODB0RXIva21KZ1REM09qY0ZtLzdD?=
 =?utf-8?B?UHdRYi9UaTJHYzd3YS9KdkhGRzNETkJWNzNrOHFMOVphbXZ2WTFHazVkcHV3?=
 =?utf-8?B?MHdrUHVFd1NxeEdLNEFmZ2c3VVljVTRzeGxVbG9zZTRWc0pBb0dtd0VxeVp4?=
 =?utf-8?B?RFVpN0RCRjdTbnA3TFlLRzBZaEt2aVp5cHNvaGxZVzVkMTIyRUtCVGlpek14?=
 =?utf-8?B?bHRKTm1scEgvU0hxNEVNUEdIR2NaUElKTXowczlMTUpJVGdjbmdueC9md0Jw?=
 =?utf-8?B?VzZXeHd1WklEd0IyWDZjVlB0a2Y4K1IwSFIxbDB0VmRZSURGMVh6c2dPTmx1?=
 =?utf-8?B?THVVNE5mdW1XbEFKUHVTTXRqTW42amJ6UWpvYkczd2UrVW8vc3hERGl5K2JJ?=
 =?utf-8?B?L3dPYk5lYzNLUlZWWm1Rcm1qa3JHdXJiM2N6bWdnZkFlQ0VrWHIxdmpOck1a?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f40ebbbc-5627-4c5c-855b-08ddf081210b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 15:45:55.4424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMixdSDYJdFdOCLn5NFgVFyWkvO2OcMqaM2/ENfmSOwxUQ25TblTNWXh+Q94FRmQXgxjGH6zlXtxbrs/HR5s5zeZeQ+Dl7Hjt8RTPgVDc5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7703
X-OriginatorOrg: intel.com

Alexey Kardashevskiy wrote:
> 
> 
> On 9/9/25 11:52, dan.j.williams@intel.com wrote:
> > Alexey Kardashevskiy wrote:
> >>
> >>
> >> On 9/9/25 10:41, dan.j.williams@intel.com wrote:
> >>> Alexey Kardashevskiy wrote:
> >>>>> So PCI_EXP_DEVCAP_TEE means that there may be a DSM,
> >>>>
> >>>> This bit I am not sure about. A bit hard to believe that PF0 is always expected to support passing through to a CVM. Thanks,
> >>>
> >>> I am losing track of your specific feedback, or what changes or being
> >>
> >> I've reread the thread, I wrongly assumed "tee" is used to decide whether to show "connect" in sysfs or not. I guess I was a bit tired^woverwhelmed when I made that comment, my bad.
> >>
> >>
> >>> suggested here is the summary of what the spec assumptions and what the
> >>> core supports:
> >>>
> >>> Spec assumptions:
> >>> - DEVCAP_TEE on a physical function is independent of IDE cap
> >>
> >> Right, I just want to make sure that PF0 that manages TEE VFs does not have to have the TEE bit itself.
> > 
> > It does. Otherwise, how do you tell the difference between a device that
> > that only supports Component Measurement and Authentication (CMA) in
> > isolation vs a device that support CMA *and* TDISP requests?
> 
> I'd check for IDE (not just CMA)

Again, IDE is optional for TDISP.

In section "11.1 Overview of the TEE-I/O Security Model as it Relates to
Devices" it says:

    In some cases, e.g. for an RCiEP, it may be possible to ensure by
    construction that communication is not be susceptible to tampering, and
    therefore may not require the use of IDE. The TSM and DSM are both
    responsible for ensuring that Device/Host (and, when peer-to-peer is
    used, Device/Device) communication is secured by IDE, or by other means
    that satisfy use model requirements.

> and then I'll ask the TSM about TDISP (my PSP asks the PF0 for TDISP
> version at the very end of DEV_CONNECT). It is the TSM which does all
> this IDE_KM and TDISP stuff anyway.
> 
> And how do I tell if PF0 allows TDIs or not? Try binding and see it
> failing if it does not? Same thing imho.

Yes, the specification does not define a way, unless I missed it, to
enumerate the valid set of interface ids that the DSM manages. So the
best Linux can do is say "device is a function 0 endpoint and has
DEVCAP_TEE, lets assume that it manages SR-IOV functions, or non-zero
functions of the device. If the device is an upstream switch port, then
assume that it is a DSM for downstream secondary bus devices".

Those assumptions can not be validated in advance of trying to bind the
function. I.e. punt to userspace to figure it out the dependencies.

> > Now, the PCI/TSM core will still attach if that PF0 device has IDE,
> > without DEVCAP_TEE, but that support is incidental.
> 
> Sure, I am trying to clarify the PCIe language here, none of this is a
> showstopper really. Thanks,

Again I am confused if you are pointing out a functional incompatibility
with the hardware you have in hand or are just trying to compare
interpretations of the specification.

