Return-Path: <linux-pci+bounces-22638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C14A498A3
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 12:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F913ABCC0
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 11:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260EF25F781;
	Fri, 28 Feb 2025 11:58:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23AA23E32A;
	Fri, 28 Feb 2025 11:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740743934; cv=fail; b=BiaWpTcVaQzy+tLQXKnBzgNimzZ4uF58TfAFSDiD7OASH3FPBcxpIPDWPC/nlchC762evrgABb5GViu80soZKuCQopsG4dwfVv2ufcPhF8g8uA9dlWb9n1tKWqa2mLdedmX2aot95fhIsCa6LbbqXpTN59szGKd4ehFAKus18XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740743934; c=relaxed/simple;
	bh=snVAac+6SQHkf80AY065xSj2krEPXEbs7CXuiCiI6gw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nw1nKWwawoCrIAZT/eIBbdzLNZUbgfhtzOVBqBqmRD4tyKGW5+sTCvwrT3D4U4U9TsQCCJdBnP+vnUK9bO9gCzdK9vYtllNVCziu/n0llj05ZUZUjjfb6Lsh6HqTzSliRiExuxRYqmbj2WvYNTgpoZit50X6lALx09Z7wQwIMDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SBapxW027114;
	Fri, 28 Feb 2025 03:58:25 -0800
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45342k8euc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 03:58:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lEcYafnpXySmmsiy9qP8mDNlXDmodJbSSMwMr0ctURzEnA0tjzhlsNHdreGTlIqvN6foUCoD2cPIHjpoKFWLN0/kMNzxGt4M05AKn9Uc3PrWHzky1T4nBrY/fjxtUtVGZ7Rj3KaAY5rkx2g3s9VhHLhuJgooC+0plySl9+Bp9fbe8QHjXpcnaO4UGyhCReIenzU/YmIMCrfW7mxFv7JAxdClZXVmFXHsTLB54N4YsNjopuZumOcknUKiWDJN0qb7EJtvfsWR7aiYwJzUj8ldBvWYRsW00gf53l65G3NCOdioxmGbZYBmsQVCxwsLMlNvmB3u964rw5B3DwLNSvgV0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kO7ccoCtksvNDLKm4E81zBq3ahxK9NZGkisvCs3HQIE=;
 b=kcPETNRY+HRCGu2w1LokKflNebOGYUgiQmddjXQzq5h7b6tsX22S03KV3f78XndSG1Ad6A6Yju+9jEtVi4VsAPG7aCEcnFhw0sl7SKGQ42WWbxuUut++55xbPp+R6T9hUo9kltu7fq0UOZIFYl4vq6gE3XaeItcwner8rxJALjb2Hwvvkwr6o6U2kwTeEFkguzIw+d42DpzITa1iLT+wuO0I1Qo/bt3t+lzj17qTB0QQ/skCzBu31C2/hjFexjDrZ3SwMtdJQsx87oPKVyc+Jde6N5iQblPp+QTOiElAWLlHbSv9WKLlgxNyG8YCPjT2pTfwUIKImclkn4vIAhV7zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by CH3PR11MB8519.namprd11.prod.outlook.com (2603:10b6:610:1ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 11:58:20 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::265f:31c0:f775:c25b%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 11:58:17 +0000
Message-ID: <55a33534-bff0-488c-a2a2-2898d54bd62f@windriver.com>
Date: Fri, 28 Feb 2025 19:58:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: controller: Restore PCI_REASSIGN_ALL_BUS when
 PCI_PROBE_ONLY is enabled
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kexin.Hao@windriver.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Vidya Sagar <vidyas@nvidia.com>
References: <20250117082428.129353-1-Bo.Sun.CN@windriver.com>
 <20250210103707.c5ubeaowk7xwt6p5@thinkpad>
 <df5d3c54-d436-43bb-8b40-665c020d6bb5@windriver.com>
 <20250214170057.o3ffoiuxn4hxqqqe@thinkpad>
Content-Language: en-US
From: Bo Sun <Bo.Sun.CN@windriver.com>
In-Reply-To: <20250214170057.o3ffoiuxn4hxqqqe@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0334.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::12) To SJ0PR11MB5866.namprd11.prod.outlook.com
 (2603:10b6:a03:429::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5866:EE_|CH3PR11MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d82d588-c6cf-4564-ba0a-08dd57ef3034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGFDdnJsb2NCa2oxWEsrS1hkYlJnZ2JEVnh6b0NkNzNsbkZaWnJTSXBjYW50?=
 =?utf-8?B?SjBWUVhpQXJrYW9PZHU4SzFmejArQldTM0NSSkxRTzRFMTZPNllFd244MGdB?=
 =?utf-8?B?ZFZsY2cwSytCRHVwSmpYdFdIUjU2K2kzMXZ3SHZiL2t0dExCbG5xK0I0OU4v?=
 =?utf-8?B?a2J4enY3TFZFemVEVVhkaUtiTTRLZzdxU05MR1dLdDY4OHJ1dk54RE9kUVBv?=
 =?utf-8?B?emJpaVpWSUphV1ZuNlpSU0NRU01CL3lEZTF2RnFBT0FSWGN4MEttZm9jaUFr?=
 =?utf-8?B?VXRhTWVWZTJlaHdSZHZ2bUtrWjYzRjMwQkJTTGE3UnhSNVRiTDQ3MFhIbUk0?=
 =?utf-8?B?T3dOaWIwbVBDSXlLNkFLa2ZUb3JyU2VDaTh6US9MdmNWaGM3N2t2ZUdZVUg0?=
 =?utf-8?B?anA1d29MU2huMzdlMit4dlQ1bzg0empoOG1YNjRHY29SaTRJNnNZNXRBVEhI?=
 =?utf-8?B?WEUvSmE3SVA0S09oWlNEa3N5VmZUMm1pNjdraVBKZmEzc0FadjhlNDM0bWZi?=
 =?utf-8?B?cmFNT0pxZFFGaHNNQy9LMFlTYldUdG05d0N1dXRSOGw2bEhBdTFKMW8zS09t?=
 =?utf-8?B?aU5EbnNSZUtrZU1KTVNhbTI0K3NzSHEzeW5IRGlQLzhicGUxdUp4dGZvQ0lF?=
 =?utf-8?B?YUtRQ2t3TTIxL3ZmQzhUV0ZyNzBCTlRtQXVMNXBaZlkzNW5NNDduQnJjTVIr?=
 =?utf-8?B?aVVwRE1ielBwZnQ0UTVJdkk2SUFjZ1hlNHFpZUhrNlBoSW8zdHhZVjNqRUhT?=
 =?utf-8?B?RkNrWHFROHZORkI5MWtJMjZuaUt2UTJKV2MwdmRKMlo5NDNrbGhBclVkekVH?=
 =?utf-8?B?TlNpRmxtT1RMUGxCNHQwb3RPdUdEU1o0MnVOdHUxN01qZFJQdTJQYTVNNS9F?=
 =?utf-8?B?RU5ZenhqUFlOUnRFYS9HWUljUTN3bUNBV3oydytsZk1VNG8rWEVNNUNNbTZV?=
 =?utf-8?B?d2d0MFdudFhZYXVndCtCWnE5bTZNSE8vZDk3YktLQ21rMi9MZTdrM3lUVGdo?=
 =?utf-8?B?NHk2ejlFa21KTVozVm5GdVdIbEE2VEU4SHBhUzlwcFhpWmpHcVJkODhHR0Fr?=
 =?utf-8?B?TnAvempVSDRST05WMFdtOGh0bVVDVGhSaldqK3VqdVVTZndUQkJuNHNDM29M?=
 =?utf-8?B?QmVNZ3VVYWxDNDV2QmFTSXRSaEFnVjV0ZmpLdWZraVloUHZ5V2ZEY0hVVnlt?=
 =?utf-8?B?aUphazJvY0R0ODRNZyt4a1FvdVcwek5pWlprSDdvQ092NnZkSE9KdnpJdDY3?=
 =?utf-8?B?YnFGQnRVTmdtTTVxT005VDJ4dGZBNEFqWlNlNTBnWDh6bGVaNEtoSWw5Mm1I?=
 =?utf-8?B?TTNrNlpvQ0VnNFFqZnhqUE43TnJBUEdYS3ljWHd2TGR0REwvRGtKZENPNFZY?=
 =?utf-8?B?b25BZmJuMTJ0UDhzbjJWWGZ3cjg1enRWZDFjN0FnN1ppREVhOTBDOGsxYmlY?=
 =?utf-8?B?Nkt4SVdkYzVvZDBxcmgxcW0vSzRRMnhqQnJnWUVDbGVDdW5BVTJ1dEFybXZQ?=
 =?utf-8?B?NWQ2dkp4RE01Y1I4REtiY0ErOGkwY0cwZTcwbmZYak1nMnBmSCtueVh5VVg5?=
 =?utf-8?B?aGhBY3BxUnFXME1oS01DOUVIdUx5OVk4cmkzbDZPUTFrb21qeVoyaTRBRU1v?=
 =?utf-8?B?bHNkR2l4UFUzU1lCUWZreXVCZXNqQXNRVVFGditPVkNxeUx4WWxISlh3Q2tB?=
 =?utf-8?B?aHdBZ1VDczdoRVhDTUpqV2pIbGlQYlJmTmtXbHBZTm03VFliWENMM3h4S08y?=
 =?utf-8?B?OW9wbm9yK0xMais1UE5pWTZoeXdrdG5XWTVqN0s4NHJLMy9KbStWWjUwTGxZ?=
 =?utf-8?B?ZU1jQ0R6U29VNS8ycnVZQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cC9DbUhxdWtMZmVMY0xPQytMc2hJMlAwWGlqQ1V5TDFHM1B5bm9CR25iWXB1?=
 =?utf-8?B?bHdFZmt0VXNMSmFQdVlHRitLZlJFTkNVRDhXM3NyWU9jMTZFdStQUWxBb09B?=
 =?utf-8?B?WjI0NXREUmxyWnNiOENmaWdZeFVyakYwQ1A5dE9lWCtZU2swdlpQeHNLN256?=
 =?utf-8?B?VXA0VEtyY2RhTGlDYnJXTVplQXNLSlBucFZLZUliWURReXk5SXpiMWtuSE9o?=
 =?utf-8?B?dU9seHJ4R0xyVlJSZ2QzeHFvcFE5Y1VDcGh3c25Fak92L1JZa0RlQktaOHIw?=
 =?utf-8?B?UlliMU8rdjBLeENOdGtzZzJKUm1Sd2JBdlNFNDRyT3UwdEo1OHFBWTJOcUhR?=
 =?utf-8?B?eFZva3VZSmh4cnErcm0zODl3MjRFbEo3Z2ZjNytMZVFZTGJZTWJFRWFkb2p3?=
 =?utf-8?B?MnNBL1pQOEZHcDdQend4ZDF2dlRyNTkzeDlxdXRyamh6VXVtMGZDdnUrUUh4?=
 =?utf-8?B?YUlmdVhiTVM2dGJvYm9XQU11ZVV3RzI5QjIvN3M2b1h6dGU3YThSQ3A1NGRu?=
 =?utf-8?B?amJocGNBRXU1SnRRRG9saFErRmdrY3k1SFU2dkFEY1F3aWt5bllqQkxsN1l6?=
 =?utf-8?B?MVU5L085NFhRS0l5dEhTUEswZGZKck92NEZVeGVPUFdUMEZraVJaNWFTVHVu?=
 =?utf-8?B?TUdUdy9iNEhWOExmNTRwTGJoVTl0TmhxZkdsM29PTTY5d0lQL2hMSEh6b291?=
 =?utf-8?B?MWxUTmRFME1kTElmK3kzVlFiSTZUMFRUci9RY3hsUTBGcmQwTVhBS0UwWllR?=
 =?utf-8?B?UjE4bkFEd1hxaVNYZ011S2dxeVFyenhCdEtnMFAxVG1XN3NGWmk2dElSMHRR?=
 =?utf-8?B?SElLTUFYWW1NMGlWdXcrMk5jRW1NWDgyRS85ZzZFZmt2RWpwRHplRmc3THBH?=
 =?utf-8?B?bGoyU0htbjJVTituQU1Qbzk3Uk1wbXhRUXJMczFQa3FFZUZRclUwQzZ0RzNq?=
 =?utf-8?B?cHBIQ1orZ1RxVXBKajI3ZllhNzJ5YmFzdGViS3JLa01HdTQ3bHNiZzhkS0pX?=
 =?utf-8?B?Y2pMTEUzcEczSUdsdzE2MXUzRlVNZjNOcFo0cnZnZ1phcUlJR0dBanFIWVVt?=
 =?utf-8?B?YVRhM2JOMk02bXR6dHFFNWFIcEtTNHNYZTV6NjhtbkZ0VnFiR0l6SmcyZlFp?=
 =?utf-8?B?WG9uYzZqdk9iSXl1ZmZIL3RZcWs4V3lIeEl1NTJhTFBWdEpPVmFXbTgvQ0VO?=
 =?utf-8?B?UUFqbTdXTEJhcktrM0xkTncrQ0JwcisvNDVNTTFWUmdxLzk5SVZhTlpHNEJB?=
 =?utf-8?B?Njc3ZTR1RXdmdzc0ZXFQdHQvYlJJTUZ6djFxNSt0T0dxdFZ6aE1HcnhRSmIr?=
 =?utf-8?B?MWhteHlLT3JEWmY4bXJjZjdJQzh0RTdtQTRVTUhEcUJiWUtuZTlZNXpYVEVj?=
 =?utf-8?B?YzBtcjZzNG5aZ0pWVGhwVnNDcDh2aDFqemx4dHVyak9xamVlZGx2TndUUDh2?=
 =?utf-8?B?ckx1YnhtVk1BN2VScmt0MUlmMVN6Q2c3OUdBdjI0cWpsTFY5QXRVNGxiTGs0?=
 =?utf-8?B?VkRFNVhVNXRyT01jVFBZK0NJRXB2NEtlZ0JLYThRU0FhY0Z1WVQ5dHYvS003?=
 =?utf-8?B?bCtNZHl4Q1V2VS81ZU5NMGhOWFlTUzI0aGlEckVOaVVXU2RsOFdjRTZqcnZx?=
 =?utf-8?B?eTFqbXFZVWNDMzVTK3UzUkpSNlNCZ0N0b2JuTzAyS2pjUXdtTUErL2xDc09s?=
 =?utf-8?B?N1lWZDg0NjZFeWtuYkFHbFdHRzV4TlBZWWNNeHBpeUVKYVNrQlJjQ1NINjBa?=
 =?utf-8?B?bVAvSEo0ZGJhL1Y3Nk9vUGkrOU8yeFJLanUzYU55KzNjNHdlKzM4RGZ2T0NY?=
 =?utf-8?B?ZXRDc25tWkpBTVUyelNUcEdDeklYcGkxb09lVEdrTjE4bmdaU2FQK3ZLYmdZ?=
 =?utf-8?B?eE9CQ1lnby9nOFYxRGlWajl4d3hQcGltMlBGcTBocytzZ2x5cm5NVmJjcUl5?=
 =?utf-8?B?VCt1ZDNvNHRzOFBkMUlzRU8yVjFuWnhiaW00eFpTVVNjT054WEdkYy9rR0d5?=
 =?utf-8?B?VDJobUlNcW54Rjc1VHQzYkhLUjhkVVFxL01EWXZQNWltK2lVaE1GVmEydjNw?=
 =?utf-8?B?NGhBVWFMcVVsN2FNWk5iWWxsUG5jTTRxdFZOWDZFdkpzaWdNdml2cmtlNG9Q?=
 =?utf-8?B?NG0rTmw3ZG9GekY2ZzZZNmdybUZEbmx5YzhjNlV3QU1IQzBuU0ltS2JWbnJQ?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d82d588-c6cf-4564-ba0a-08dd57ef3034
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 11:58:17.5938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nk7a8VJvsZv5V/F843UXowCIo3y9lFbtlUPqzC4yEyEz3XCqMYe4/xlnl463weJLPc7AuG2Rpl+cUGw6c07b/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8519
X-Proofpoint-GUID: gQieS9_MhYVuZDfCmU7pYYdCHkdVZSJJ
X-Authority-Analysis: v=2.4 cv=D9y9KuRj c=1 sm=1 tr=0 ts=67c1a4e1 cx=c_pps a=Odf1NfffwWNqZHMsEJ1rEg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=VwQbUJbxAAAA:8
 a=GrWWodrxpXb3fdPBP68A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gQieS9_MhYVuZDfCmU7pYYdCHkdVZSJJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_02,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 impostorscore=0 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2502280086

On 2/15/25 1:00 AM, Manivannan Sadhasivam wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> On Wed, Feb 12, 2025 at 03:07:56PM +0800, Bo Sun wrote:
>> On 2/10/25 18:37, Manivannan Sadhasivam wrote:
>>> CAUTION: This email comes from a non Wind River email account!
>>> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>
>>> On Fri, Jan 17, 2025 at 04:24:14PM +0800, Bo Sun wrote:
>>>> On our Marvell OCTEON CN96XX board, we observed the following panic on
>>>> the latest kernel:
>>>> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000080
>>>> Mem abort info:
>>>>     ESR = 0x0000000096000005
>>>>     EC = 0x25: DABT (current EL), IL = 32 bits
>>>>     SET = 0, FnV = 0
>>>>     EA = 0, S1PTW = 0
>>>>     FSC = 0x05: level 1 translation fault
>>>> Data abort info:
>>>>     ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
>>>>     CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>>>>     GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>>>> [0000000000000080] user address but active_mm is swapper
>>>> Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
>>>> Modules linked in:
>>>> CPU: 9 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.13.0-rc7-00149-g9bffa1ad25b8 #1
>>>> Hardware name: Marvell OcteonTX CN96XX board (DT)
>>>> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>> pc : of_pci_add_properties+0x278/0x4c8
>>>> lr : of_pci_add_properties+0x258/0x4c8
>>>> sp : ffff8000822ef9b0
>>>> x29: ffff8000822ef9b0 x28: ffff000106dd8000 x27: ffff800081bc3b30
>>>> x26: ffff800081540118 x25: ffff8000813d2be0 x24: 0000000000000000
>>>> x23: ffff00010528a800 x22: ffff000107c50000 x21: ffff0001039c2630
>>>> x20: ffff0001039c2630 x19: 0000000000000000 x18: ffffffffffffffff
>>>> x17: 00000000a49c1b85 x16: 0000000084c07b58 x15: ffff000103a10f98
>>>> x14: ffffffffffffffff x13: ffff000103a10f96 x12: 0000000000000003
>>>> x11: 0101010101010101 x10: 000000000000002c x9 : ffff800080ca7acc
>>>> x8 : ffff0001038fd900 x7 : 0000000000000000 x6 : 0000000000696370
>>>> x5 : 0000000000000000 x4 : 0000000000000002 x3 : ffff8000822efa40
>>>> x2 : ffff800081341000 x1 : ffff000107c50000 x0 : 0000000000000000
>>>> Call trace:
>>>>    of_pci_add_properties+0x278/0x4c8 (P)
>>>>    of_pci_make_dev_node+0xe0/0x158
>>>>    pci_bus_add_device+0x158/0x210
>>>>    pci_bus_add_devices+0x40/0x98
>>>>    pci_host_probe+0x94/0x118
>>>>    pci_host_common_probe+0x120/0x1a0
>>>>    platform_probe+0x70/0xf0
>>>>    really_probe+0xb4/0x2a8
>>>>    __driver_probe_device+0x80/0x140
>>>>    driver_probe_device+0x48/0x170
>>>>    __driver_attach+0x9c/0x1b0
>>>>    bus_for_each_dev+0x7c/0xe8
>>>>    driver_attach+0x2c/0x40
>>>>    bus_add_driver+0xec/0x218
>>>>    driver_register+0x68/0x138
>>>>    __platform_driver_register+0x2c/0x40
>>>>    gen_pci_driver_init+0x24/0x38
>>>>    do_one_initcall+0x4c/0x278
>>>>    kernel_init_freeable+0x1f4/0x3d0
>>>>    kernel_init+0x28/0x1f0
>>>>    ret_from_fork+0x10/0x20
>>>> Code: aa1603e1 f0005522 d2800044 91000042 (f94040a0)
>>>>
>>>> This regression was introduced by commit 7246a4520b4b ("PCI: Use
>>>> preserve_config in place of pci_flags"). On our board, the 002:00:07.0
>>>> bridge is misconfigured by the bootloader. Both its secondary and
>>>> subordinate bus numbers are initialized to 0, while its fixed secondary
>>>> bus number is set to 8.
>>>
>>> What do you mean by 'fixed secondary bus number'?
>>>
>>
>> The 'fixed secondary bus number' refers to the value returned by the
>> function pci_ea_fixed_busnrs(), which reads the fixed Secondary and
>> Subordinate bus numbers from the EA (Extended Attributes) capability, if
>> present.
> 
> Thanks! It'd be good to mention the EA capability.
> 
>> In the code at drivers/pci/probe.c, line 1439, we have the
>> following:
>>
>>                /* Read bus numbers from EA Capability (if present) */
>>                fixed_buses = pci_ea_fixed_busnrs(dev, &fixed_sec, &fixed_sub);
>>                if (fixed_buses)
>>                        next_busnr = fixed_sec;
>>                else
>>                        next_busnr = max + 1;
>>
>>>> However, bus number 8 is also assigned to another
>>>> bridge (0002:00:0f.0). Although this is a bootloader issue, before the
>>>> change in commit 7246a4520b4b, the PCI_REASSIGN_ALL_BUS flag was
>>>> set by default when PCI_PROBE_ONLY was enabled, ensuing that all the
>>>> bus number for these bridges were reassigned, avoiding any conflicts.
>>>>
>>>
>>> Isn't the opposite? PCI_REASSIGN_ALL_BUS was only added if the PCI_PROBE_ONLY
>>> flag was not set:
>>>
>>>           /* Do not reassign resources if probe only */
>>>           if (!pci_has_flag(PCI_PROBE_ONLY))
>>>                   pci_add_flags(PCI_REASSIGN_ALL_BUS);
>>>
>>
>> Yes, you are correct. It’s a typo; it should be "when PCI_PROBE_ONLY was not
>> enabled." I will fix this in v2.
>>
>>>
>>>> After the change introduced in commit 7246a4520b4b, the bus numbers
>>>> assigned by the bootloader are reused by all other bridges, except
>>>> the misconfigured 002:00:07.0 bridge. The kernel attempt to reconfigure
>>>> 002:00:07.0 by reusing the fixed secondary bus number 8 assigned by
>>>> bootloader. However, since a pci_bus has already been allocated for
>>>> bus 8 due to the probe of 0002:00:0f.0, no new pci_bus allocated for
>>>> 002:00:07.0.
>>>
>>> How come 0002:00:0f.0 is enumerated before 0002:00:07.0 in a depth first manner?
>>>
>>
>> The device 0002:00:07.0 is actually enumerated before 0002:00:0f.0, but it
>> appears misconfigured. The kernel attempts to reconfigure it during
>> initialization, which is where the issue arises.
>>
> 
> Ok, thanks for the clarification. I think the bug is in this part of the code:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/probe.c#n1451
> 
> It just reuses the fixed bus number even if the bus already exists, which is
> wrong. I think this should be fixed by evaluating the bus number read from EA
> capability as below:
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b6536ed599c3..097e2a01faae 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1438,10 +1438,21 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
> 
>                  /* Read bus numbers from EA Capability (if present) */
>                  fixed_buses = pci_ea_fixed_busnrs(dev, &fixed_sec, &fixed_sub);
> -               if (fixed_buses)
> -                       next_busnr = fixed_sec;
> -               else
> +               if (fixed_buses) {
> +                       /*
> +                        * If the fixed bus number is already taken, use the
> +                        * next available bus number. This can happen if the
> +                        * bootloader has assigned a wrong bus number in EA
> +                        * capability of the bridge.
> +                        */
> +                       child = pci_find_bus(pci_domain_nr(bus), fixed_sec);
> +                       if (child)
> +                               next_busnr = max + 1;
> +                       else
> +                               next_busnr = fixed_sec;
> +               } else {
>                          next_busnr = max + 1;
> +               }
> 
>                  /*
>                   * Prevent assigning a bus number that already exists.

You proposed solution doesn't work on our Marvell OCTEON CN96XX board.

When probing the bus 0002:00, the bus number preset by the bootloader 
for the bridges under this bus start with 0xf9. Before configure of 
0002:00:07.0, the 'max' bus number has already reached 0xff. With your 
proposed fix, the next_busnr is set to (0xff + 1), which evaluate to 
0x100. This results in a 0 being assigned to the secondary bus number of 
0002:00:07.0 bridge, causing a recursive bus probe.

For reference, you can take a look at the code in probe.c and the 
corresponding log.

     pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses); 
  

     primary = buses & 0xFF; 
  

     secondary = (buses >> 8) & 0xFF; 
  

     subordinate = (buses >> 16) & 0xFF; 
  

  
  

     pci_dbg(dev, "scanning [bus %02x-%02x] behind bridge, pass %d\n", 
  

         secondary, subordinate, pass);

pci_bus 0002:00: fixups for bus
pci 0002:00:00.0: scanning [bus f9-f9] behind bridge, pass 0
pci_bus 0002:f9: scanning bus
pci_bus 0002:f9: fixups for bus
pci_bus 0002:f9: bus scan returning with max=f9
...
pci 0002:00:06.0: scanning [bus ff-ff] behind bridge, pass 0
pci_bus 0002:ff: scanning bus
pci_bus 0002:ff: fixups for bus
pci_bus 0002:ff: bus scan returning with max=ff
pci 0002:00:07.0: scanning [bus 00-00] behind bridge, pass 0
pci 0002:00:07.0: bridge configuration invalid ([bus 00-00]), reconfiguring
...
Kernel panic - not syncing: kernel stack overflow
CPU: 12 UID: 0 PID: 1 Comm: swapper/0 Not tainted 
6.14.0-rc4-00091-ga58485af8826 #16
Hardware name: Marvell OcteonTX CN96XX board (DT)
Call trace:
  show_stack+0x20/0x38 (C)
  dump_stack_lvl+0x38/0x90
  dump_stack+0x18/0x28
  panic+0x3ac/0x3c8
  nmi_panic+0x48/0xa0
  panic_bad_stack+0x118/0x140
  handle_bad_stack+0x34/0x38
  __bad_stack+0x80/0x88
  format_decode+0x4/0x2e8 (P)
  va_format.constprop.0+0x74/0x130
  pointer+0x204/0x4f8
  vsnprintf+0x2c4/0x5a0
  vscnprintf+0x34/0x58
  printk_sprint+0x48/0x170
  vprintk_store+0x2d0/0x478
  vprintk_emit+0xb0/0x2b0
  dev_vprintk_emit+0xe0/0x1b0
  dev_printk_emit+0x60/0x90
  __dev_printk+0x44/0x98
  _dev_printk+0x5c/0x90
  pci_scan_child_bus_extend+0x5c/0x2c0
  pci_scan_bridge_extend+0x16c/0x630
  pci_scan_child_bus_extend+0xfc/0x2c0
  pci_scan_bridge_extend+0x320/0x630
  pci_scan_child_bus_extend+0x1b0/0x2c0
  pci_scan_bridge_extend+0x320/0x630

So, I propose the following solution as a workaround to handle these 
edge cases.

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 82b21e34c545..af8efebc7e7d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6181,6 +6181,13 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 
0x1536, rom_bar_overlap_defect);
  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1537, 
rom_bar_overlap_defect);
  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1538, 
rom_bar_overlap_defect);

+static void quirk_marvell_cn96xx_cn10xxx_reassign_all_busnr(struct 
pci_dev *dev)
+{
+       if (!pci_has_flag(PCI_PROBE_ONLY))
+               pci_add_flags(PCI_REASSIGN_ALL_BUS);
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_CAVIUM, 0xa002, 
quirk_marvell_cn96xx_cn10xxx_reassign_all_busnr);
+
  #ifdef CONFIG_PCIEASPM
  /*
   * Several Intel DG2 graphics devices advertise that they can only 
tolerate


Thanks,
Bo

