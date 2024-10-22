Return-Path: <linux-pci+bounces-15034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5B59AB605
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 20:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34DB21F241B5
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 18:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933ED1C9DF7;
	Tue, 22 Oct 2024 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oYNPtp6f"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6C417C98;
	Tue, 22 Oct 2024 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729622429; cv=fail; b=QmzApZRPq0cDM1XPYCH46EXPOt9dr8laRhZTQNseK76QjKHT+5z7kslScEmFZcgbqFZMepCGZiavo8Xtm81t1CoChduajCX/OULhitem25Td/IUtbRm7vFXad8i6d0fObQ9qzLH+jDyG+7sfjw5b22ERQ3BxdQk9MhRcoV/xG1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729622429; c=relaxed/simple;
	bh=PNm4zBAc1z87nVplBGofxrR5PO7RAwbMhuTrOD1vjhs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IkHwgbKS4PIVLXh+jnkCsufRV8oXVpz/7ufwnvT70aaUUMEq8hvAXT7lx8Q9/ujrMpf8DdxMO08lCMtvds2YYjn3yfFrgvwCEJwSVdf7cU0t/+w/QAPHfpzWInZrujm93mLrw+yXVgJxN6L7tbhBrVEMaeB4XhtjE2v+w8zL4FI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oYNPtp6f; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2HfQvSXPGiFK6p8xHHlBKsjFPj1hGRn4EhoZ13Tnrg5qxAMAik3Nj3L0Yr2Mz4dfheWmzFQzkDfFq5/Ev4DcE9uEUQjF6jdwi/J9AUEWA9QcuAvvYXXYxE5TN8CdgrdX9zm4omNucQOaPv9VPEY6s6SSg6kuUVIcPsDI1HDFWpyYAACOwpwKj3wTwLP/DrhOcBuyg+I3EWMvdxorWYJ83uHmV0kQ2pIBpTM6KiVzv5fbPdf49JbuHPmJs3EkChjk5tnh0kxhb3NIljeM7Oy5SxP9KTotn1aQpWMa/Wj2gffH1Z7fB/LoQLlS1ANOc1zjuakYMcO2jamNDULKcTrmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRivFC6r4/KLfs0HJcqOLRotBT325sIBNaTO04f9uZU=;
 b=rrISrfTRXdDwJyGUOddpFKYulDEBYp3wejaDxs3M62FhjLM/2nvASirtyIazy7+7B0s5CO3IMpg+fKo/fXyMpkTOPqyPFtgzURBpUrufG3VFXDonHiv8ANo0QGiVSG7PXcIhrNSbHHFuQ+wGn9EuSXg/jXtA+4nz2DdGxw2EWykaLMsgAzJQ1518xtg02P6cEu4/2MHbNOc3vsTEx5tlQ1yYUmRaDAUK9WY2I2xKi50rCD8T6eF6lEnUqd/G1kHojdC0EaSJ7kcd8w0sXEKC36eH5S28fCdoHMtu0ZtPaTy1diCdBwUdyBArXj446m1qIG9mcbMg1e2BAlZsXGRLpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRivFC6r4/KLfs0HJcqOLRotBT325sIBNaTO04f9uZU=;
 b=oYNPtp6fMF5dwd2M88KZ1DOQ245NdCcE/jDBjCwLF/VjyHkxYQGc7gGphXLLrOaDOlaHZgas6l+25xVmYjGVZWYV1zfHpGnj/EDGC/H2MN/h9Ma2Fnx0ll9KHQ0QfhBu4g6T/a3RSQgbsxzg60lRoqOotuPl/RXDIip7m/DdYcI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CH3PR12MB8509.namprd12.prod.outlook.com (2603:10b6:610:157::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.17; Tue, 22 Oct 2024 18:40:23 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%6]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 18:40:22 +0000
Message-ID: <b3fea77e-1103-40ab-b7f2-adc545273be6@amd.com>
Date: Tue, 22 Oct 2024 13:40:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] cxl/aer/pci: Add CXL PCIe port error handler
 callbacks in AER service driver
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, ming4.li@intel.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
 Benjamin.Cheatham@amd.com, rrichter@amd.com, nathan.fontenot@amd.com,
 smita.koralahallichannabasappa@amd.com
References: <20241008221657.1130181-1-terry.bowman@amd.com>
 <20241008221657.1130181-2-terry.bowman@amd.com>
 <671705b5bb95b_231229468@dwillia2-xfh.jf.intel.com.notmuch>
 <0cceca3d-f69e-4277-bc9f-2556fd212ebb@amd.com>
 <6717dc2ec6c90_231229487@dwillia2-xfh.jf.intel.com.notmuch>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <6717dc2ec6c90_231229487@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0151.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::6) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CH3PR12MB8509:EE_
X-MS-Office365-Filtering-Correlation-Id: aa167e90-5172-4d4a-283c-08dcf2c8fc88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmUyL2lIVjJSNDdkanNmdjR1ZS9COExJL2JzTUs5Q1NpNldvR2VyUjNBNmhh?=
 =?utf-8?B?aGdrcUwva25mVFcxMkFnbmV3ZE4zU29tcHBnSVlTL3hDYmFGcVBNa21BTHpu?=
 =?utf-8?B?M2xndExlNzRUbE16UDg3MmxxbU1wQjNRUmRkQTVjZWsxa3JIWUR6KzJGVmpP?=
 =?utf-8?B?Zkp5TkRnY3NBZzZMUU1vTEVvUk5RbS9uMjFNUWlEQWwrb3JHRyttbU5McmdW?=
 =?utf-8?B?SnIvLzR2akNRRzU4UGZWRlNpbTN1Zi9wYnE0b3EzTEIycGdXb0lZNmVXcFU5?=
 =?utf-8?B?Q2hzVGxvd05MNXlDaG9FQmlmQkxqYzA5cnlTNEw1SnBURWQ3QVpjZEl4eEhY?=
 =?utf-8?B?dHhub3cwaFltOVhhTUErRnc5ejVtdnRhazFoMVUyL1NUTElPMUtSZTBDaUtv?=
 =?utf-8?B?RlZDalhoK1psc01zaXpTQ1hHRi92ek9wMnpZZXRPcHY3aStwSU9XQTdITXBX?=
 =?utf-8?B?OWFjeHZjSm85SFdVVEhiLzdMU0J5L011blQwK29RczM1L1dDbW05bWsvTDFK?=
 =?utf-8?B?ZjFrM0xtUmNLbXFoa3dIVEFaSFlkRmNOMDN2bmQvOE9TcnJ4c00yK0twQkp2?=
 =?utf-8?B?NWFyQkhrcnhHR0lGL1JXcnh5d2ZsbzQ0c2FTblJJUUZBdENocFRuUm1XZFBQ?=
 =?utf-8?B?VGdHMXp6UGN1TGI5VTdIcUluWStONlNkQlpHVDFzSGFpTTF4aWVWcFJhT3Rj?=
 =?utf-8?B?dFRPNlF4emhzcENMVjRtMXJObGJla25WVVJBZzNhSUhMUGd6QUNETW0xUkZY?=
 =?utf-8?B?MitTck03c2RLUEFsWUIxUHdGOTIrSHRnYmwzUVkxKzBtazRCR3lOSjhlYlc2?=
 =?utf-8?B?M0dQbDRERlpkNzBSRFlSTmh2L2xhNkl5T1pRSmE0dis1MHhZNklVTDgrdTQv?=
 =?utf-8?B?ZTQ1NzdHbXFOVmcvcW5IM0xzd0NZMjNJY1hRVEx6NFl2WWlONHVmR3lPa1lC?=
 =?utf-8?B?TG9QTW5nRkRIOXl1YjdIOHY2dTRHYzh5MzJmYlp5ckl3bDh5MU15NU9nemN1?=
 =?utf-8?B?U3lPWHdlUG1pU0RsRnNQMGQ0WnNMUXJTb0FQTzVaNG12cFFEUFRLcXlvWDdF?=
 =?utf-8?B?aHd3Yno2UDVzREJUcUU0Vm5xM0tMU0h2SGVWN1pQdzdPTHdMeGUxa2wzVWNq?=
 =?utf-8?B?M0hUdGYzZlZHT24zSlBwZmphelZxZnVQSHVtVlF3SzJKejNRbm05RWVnclR2?=
 =?utf-8?B?alRjQ0NvYnVIQmtHNDMzc3dqRHlkZnB4VGRrWGI5clAxc3d6dEtkamZ6bHFJ?=
 =?utf-8?B?ODBwUWhtTktqZFBjQ3VpSEw4Q0duVyt3VTBWU2h2VGhWQkFHWXBKWU5pTFlw?=
 =?utf-8?B?b0cwZHRQSnk4OEljRGJsSDI0cnB5Y1NLT3gwdStza3BPOEVLellHaDdlMjE1?=
 =?utf-8?B?aE5BNHJsZlh2NFV4NWgxYVF3WEJ2d2k4ZnI1SG5oNjZFQ1ZuVkpObVFWSU9M?=
 =?utf-8?B?SzVHNXR5ZmFXNzBsZmpTN09UZDZTbXpaQlZzd0UxaC93QVUxT0dwbHZlMlZD?=
 =?utf-8?B?bkMrZEx1bkZmbEFpTGF6SmZ1bFljZnc3Y2d2bnNsR08xbUVvazhEbk1nbmNM?=
 =?utf-8?B?Tll4NHRGTm5JMGViamwzVERnRUEzUHFXbDZkYVovS0tDUkdHVDZOa2dYSXdt?=
 =?utf-8?B?MEhwVUQ4UTNGa2luejh0SXVJOFJVT3Rna09ZcTE4Vmp3Tm82OXNUOURGQ1VF?=
 =?utf-8?B?ZDZHL2RIRkpIbjk2dGpXdVppdVZnYTE4cTY3Q2J2ZGFBWEZoQWNIOFZYaTBT?=
 =?utf-8?B?WVFSWUk3UGRmR1dnMXlZT0ZxMWNRV3hoUk9pdGRXQkI1T1pqMVNWR0FjU1Mx?=
 =?utf-8?Q?+3Iq71QeUyQ+MkJBIdvLPXVlAkJoFXDbACX6Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDNxSVR3blA4TnlSeWJQZGFDVnhKaWRXWWRtVkRXcXJrWXVwNXl2RGF5dlhh?=
 =?utf-8?B?MVlQc3dLK3BTYURiU0c1YkE0U3hteDhDbTl1Rm4yUkRhdTVtaDNYOU1wVE9S?=
 =?utf-8?B?cUFpeEZTYU5tNFpOMmhOOHNldVRpTUFnS0EyeHpVTm9uc1cvT1g2ZFUrdDVE?=
 =?utf-8?B?ZE83bU5PeW5kaWZaby9pckxqZ1MrNnVPVEt5TE9sNW5rc1FZN0dKVUJ3Wm9y?=
 =?utf-8?B?RDBZRDZLemtwcHhiNEUxYjhlOGNyY0lDNElCMFBCMGpwcXVWTmZ6ZldlYXRO?=
 =?utf-8?B?OGZ0RVlPMWova211YXFKLzBkajFGekdQWnR6UVdreDVCK05yemhRRmllaVZx?=
 =?utf-8?B?SVlDUkRPZlM3YVlrczlqa0VBRllOTk5JMFlldmF3d3gxME43VGMyb2l0UkZC?=
 =?utf-8?B?V3B4QkdGVmExZXdSendHSkRRWEZqN0pVUlNHU0pGSld0a09vSW5MZUNmZkc1?=
 =?utf-8?B?MnNKSzNiOEJBdVA5ZDM5TGR1U1o1NEh6a2IwSHJJMS9HYnQ2Y0J3b2gxRDda?=
 =?utf-8?B?WVE4WFp2NWVBNUZoY2JqMExERVpvZUkrVU5zNUEvTW1wVTRHQ0dlYWlWQ0Nl?=
 =?utf-8?B?bFZjUHRDVElBV3dPWkZEMkpOZ01qRStoWEF6cnc5bDVBV2FsUG5KbHNyTUxa?=
 =?utf-8?B?N3ZEcmlHWVFEVDh5dDdJY3dWOGxIcm1YaWR5NENic2tCRGY4cmpWcitTTldz?=
 =?utf-8?B?d3Yxa29BM1l5MDkvNGZ1TFppVVFqVGdYS1R6M1ZDdzlTNjh5cHVMQnRIdUxQ?=
 =?utf-8?B?WWIyeGsySGpnSlA0eUYzc01sbk1vZzRZVzFpRUR2VWN5OGRtaXdqSjlZSlZG?=
 =?utf-8?B?cW45ZmtEbThxa0paWGduVC9MdFFSdGVHald5UjU2TFdSWm1wWmZnVnBCZkhy?=
 =?utf-8?B?VDNyZ2RNRVFpbVVCenVvWERKa21PelRBWjZXZklqa2JPc2QxWFBmQnJYVzFR?=
 =?utf-8?B?dWdaSDROZElmSmJvVmlRcTd4Sm13ZEcwSTl3N2hBTENadjN5VUk4ZDh2TlF5?=
 =?utf-8?B?UFZMUDd3VUQ4WEpUa0txOTZaV1dOekRuQ1hydnphQ3FqbHpxcGNNOUlBdUhB?=
 =?utf-8?B?VERIRFBWdW13UWJRSTAvcUlOOVkzKzRTbmEyc2RGQXBDVmJ6UmxEZUcwZnR1?=
 =?utf-8?B?NUtvVGtWRjJOdWVSYVhZM1lkZ0pReW5ydTl6cFZoek1FbGp0dzROSmI0YmVm?=
 =?utf-8?B?MHRsRytiUUxIRkNIVnpHRzNrTGVXMVNxSHl2c0x6YjgrbG5YVTQzdVB4Q0ho?=
 =?utf-8?B?U2p0b1Juc2JjdXp2NzlyQzM2c1VtbklKUVM0MlBpbmUvUStPZDltSm40WFEr?=
 =?utf-8?B?bzhyZy81WFR0QlRPVzVTT3MzeXBlbE5kRmpZcWVGWDNvYnRiZFRBcU9NWWpQ?=
 =?utf-8?B?ZWNxUVhEZ1lmby9yNEc3T1ErTUV2UFNDSkxEdWFPa25XM0g1L2h3TzRlRnNp?=
 =?utf-8?B?dC9Jb3BEeTE5ajRwNE9kM1pJc0dxVDg1TGU1NlpBbFZhQUVhS0F6b1dyRVJW?=
 =?utf-8?B?a3AxR0FGUnJGRERhamFoa0tzcGk0WUxiSEp4d3NxNzM5M3prakhYZm1EM3R2?=
 =?utf-8?B?bEIvMTYzODNRRFlmV0VvSWhrLzBzZDlXL3g0UWJiQ09nQUNSbHk0d3JrblM1?=
 =?utf-8?B?d1l2Y09GOTNjd1NwZk91VjFyR1F3OGhtKzBvTG9YVTRmNTErL1VrWWUycVVz?=
 =?utf-8?B?blFiZFhkcFArTGVVOVg2N3kvR2pYbTVkTkpKTnV5R05EN2svR2JOWVBKTUpt?=
 =?utf-8?B?SmpETFpncUVDNjIvZlBQdHg5SjZxRWlJVDFCNC9PWW85K3RhcktOdjg0QXlE?=
 =?utf-8?B?V1lLdDdWYTIrWmt1Q1IwNkJsaUsremJGOGg3UjJsa1RNQWlZeXkyUFNoM2tw?=
 =?utf-8?B?d0l6MVQ4UHpEN2I1YTBBR0Q4YVQrb0JzU2M3WklDOFdWTklPZ0l1YnpNS0w0?=
 =?utf-8?B?Q2ZYd1I5Y0p2Zm9lQ1BuOFZtbnVnbE5pK2tpN2FPQ1dPVk9zQW53US9EbnpZ?=
 =?utf-8?B?RzNpWHh3dCtzNWZvWGtsc1RqWGtoZm11U3FSay9pRDBoa29DZ0UzMXRUaS8x?=
 =?utf-8?B?Qi85S05DeWpMWFphNDFLeWRHV0sxRjRqcUtIQnAweTByWkI5eC9JMmF4SHlD?=
 =?utf-8?Q?nopD9lj5u5cSskrZQymoZ/zhi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa167e90-5172-4d4a-283c-08dcf2c8fc88
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 18:40:22.6282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFLF1WJQV1eu5HTkHOsUJ+MOEuj2MZf4z8uYgmJFWJHuYVnx95MXeU/3vO8UMWkTH2gs50x8+ZKrlmW44VttBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8509

Hi Dan,

On 10/22/24 12:09, Dan Williams wrote:
> Terry Bowman wrote:
> [..]
>>> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
>>> index 6af5e0425872..42db26195bda 100644
>>> --- a/drivers/pci/pcie/portdrv.c
>>> +++ b/drivers/pci/pcie/portdrv.c
>>> @@ -793,6 +793,7 @@ static struct pci_driver pcie_portdriver = {
>>>         .shutdown       = pcie_portdrv_shutdown,
>>>  
>>>         .err_handler    = &pcie_portdrv_err_handler,
>>> +       .cxl_err_handler = &cxl_portdrv_err_handler,
>>>  
>>>         .driver_managed_dma = true,
>>
>> Ok. I'm thinking to add a definition for 'pci_dev::cxl_err_handler' of type 
>> 'struct pci_error_handler'. 
>>
>> 'struct pci_error_handler' contains a slot reset(), resume(), and mmio_enabled() fn 
>> pointers that are used in PCIe recovery if available. The plan is for CXL devices to
>> call panic for UCE fatal and non-fatal but it might be good to use the 
>> 'struct pci_error_handler' type in case there are needs for the other handlers in 
>> the future. It also makes the logic to access and use the error handlers common, 
>> requiring less code.
> 
> Can you give an example where CXL can reuse 'struct pci_error_handlers`
> infrastructure? The PCI error handlers are built around the idea that
> operations can be paused and recovered, CXL operations assume near
> constant device participation in CPU cache and memory coherency
> protocol.
> 
> About the only reuse I can think of is cases where a CXL error could be
> sent down the PCI error handler path, i.e. ones that would send a
> 'pci_channel_io_normal' notice to ->error_detected(). Otherwise,
> pci_channel_state_t and pci_ers_result_t seem to be a poor fit for CXL
> error handling.


I was referring to reusing separate instance of 'struct pci_error_handlers' for CXL 
UCE-CE errors. 

One example where it can be reused in infrastructure is in err.c's 
report_error_detected(). If both PCIe and CXL errors use 'struct pci_error_handlers' 
then the updated report_error_detected() becomes a bit simpler with less helper 
function logic. But, it's not a reason by itself to choose to reuse 'struct 
pci_error_handlers' for CXL errors.

Looking closer at aer,c shows there is no advantage in this file for using 'struct 
pci_error_handlers' for CXL errors.

If I understand correctly you want a new type introduced, 'struct cxl_error_handlers'.
And will contain 2 function pointers for CE and UCE handling.

Regards,
Terry






