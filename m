Return-Path: <linux-pci+bounces-18655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1FD9F50E7
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 17:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605891892B1A
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 16:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2080B1F8926;
	Tue, 17 Dec 2024 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Luottuid"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3178B1F76A4;
	Tue, 17 Dec 2024 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734452330; cv=fail; b=G+yoTdSHYH2xVZdM54jvdqLoJOMGcJrHeL1nqHukaCAAYWpEnVaJHuH1mJ4wjywnPPLXUaZlS6h26GUYxlojfRPkx35SeGco6b5HjvcLs80t8Yxj4ugTWSBI+a5QazonTfSymNTnzgZTKIxpecVzJZHWZWfHY4NJxSGeLjbCKbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734452330; c=relaxed/simple;
	bh=kosxgaLDUkYi3jcaO5tdLJyqn/C9r8edvMY5uTyM0QQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hn6P9qdQo9W0I2TY/sCDV1CmkgXeBoA0bAWunPBBwjGawo5QsNtxDsqz73j0mQP088hHMIO+OgM2F4RIWKC83oQ0VRlbepM2aSyhD6wWdCDqz/aEdJD1ylOTa+AQ94T+AyFCXGwruiKKTX5XwxOVaIbO7zRobfi0AlW06Kxz64I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Luottuid; arc=fail smtp.client-ip=40.107.101.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUFyV/paNY1S2e5KMLm1Db5XaSWRNGMvSrMiMF2CAoEjbrpE0HSww3CRO6AGUJvFaZgw8Rgq7ci0/CEYl71fBBfe4N1j7mKVLYF60V5FW9alcBHTkBIYNxR7vNLioaCxvjEIM6LFI9SaaR5pVz3kF59/XpNM0kFctyh5TrHLfcOrv+4e2G8dgGn3ph9Ior2Ens80hjjBxH+BtW+Dj9BBlK6YuAI1r8v23jJkD4XmiKTOOAt10Y/xLSc/L062BGwyX8qbWsdsrQ1pIJkf5tbcincpTIol/gqO7L/JBp7hOVg102g++NlR6s6lF0H0gajQ+s391YUnVZpFeHArjRJLnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7p37QmE61+PaRxly+xIOqsbiUtYurghhzF4lUWi2Duk=;
 b=ndLJrgP9N/t/DdvPlRKAjUx85RZ/Nnp1zIEEONG9t2HVs490He8BLNQ76aTcnJxiugsnHjBI/2JJ3r7Nkno364h+BWOCvI8OqYklNYsxwYQDPVxAWmi5t/qzEJz8xVcyvP27mcvV46ljjHdppe0puXNv4pQcrtKSSl2R8vL8/SZ5ImrrH2BxMxMHc8EP2CE2OB+FqER3t4HL41iwACGcTyWrtt63zNoTvDvBA368JJLbRkxrx5OLmVY0THqovRNAXpzIpLzlBRKypA0memWGjKUTDrEVh2J9HZ5pXjSxZ1R4w7F9xZuzFEd7wNcUJZCtDogd0PR4Nhazaa7uYfTngw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7p37QmE61+PaRxly+xIOqsbiUtYurghhzF4lUWi2Duk=;
 b=LuottuidJ/vOuVlFVCBamUqLOuxR+PamGJgvqMZZBRo5Ih+266J0l4AK62FjccI31OzXWhyA8fhwHx0Fcwq0RwA9CvE6p1yxzAbgW1LajnqOFo9ur1d5U0MM7owI54wPbQzfXse9NqdB3ByXN7wE/kALGS/xWcUo7e3T+1EKB3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 SJ0PR12MB6710.namprd12.prod.outlook.com (2603:10b6:a03:44c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.21; Tue, 17 Dec 2024 16:18:46 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405%5]) with mapi id 15.20.8272.005; Tue, 17 Dec 2024
 16:18:45 +0000
Message-ID: <90625eb1-9e3b-4c07-903f-6d9139c6bf64@amd.com>
Date: Tue, 17 Dec 2024 10:18:44 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Avoid putting some root ports into D3 on some
 Ryzen chips
To: Werner Sembach <wse@tuxedocomputers.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: ggo@tuxedocomputers.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241209193614.535940-1-wse@tuxedocomputers.com>
 <215cd12e-6327-4aa6-ac93-eac2388e7dab@amd.com>
 <23c6140b-946e-4c63-bba4-a7be77211948@tuxedocomputers.com>
 <823c393d-49f6-402b-ae8b-38ff44aeabc4@amd.com>
 <2b38ea7b-d50e-4070-80b6-65a66d460152@tuxedocomputers.com>
 <e0ee3415-4670-4c0c-897a-d5f70e0f65eb@amd.com>
 <90631333-fda0-42cf-9e32-8289c353549f@tuxedocomputers.com>
 <4dac3ff2-e3ab-42c0-b39f-379d5badca42@amd.com>
 <7a9353d3-b9db-4499-a054-c7050bc7b4d5@tuxedocomputers.com>
 <c6110fdb-cc43-4351-be43-63d251fefca5@tuxedocomputers.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <c6110fdb-cc43-4351-be43-63d251fefca5@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0032.namprd05.prod.outlook.com
 (2603:10b6:803:40::45) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|SJ0PR12MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: 452f19c7-6db4-4b7e-9662-08dd1eb67b48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEV1eFdYNjU0MXZOSmpLVlRGWXB1UU8vbXMwVk83NjRoakl0ZFp5YVRtb2hq?=
 =?utf-8?B?d1hRbnIwa3lZZ2J2Y01RcDBROWRKWldnWnV5dFlKaDVoUGJQTjQ0azVKbTlJ?=
 =?utf-8?B?bXdVZFdocGtoRXBvQnVPNGd5SXRycVNQT0dxbTlxbFhIUWdROXprT1NLMTM3?=
 =?utf-8?B?aXBqZ0pvVVNmZzZLTHZ6YVlPRy8ydFpJa0lJZFZoK0YrdEFnMmt3WmVzOFdZ?=
 =?utf-8?B?NkFYK1h6TnhLbEVYZVo5NWxYb1QzamZUSmVWaDY0YWU1djJUaUkvUFUyelM0?=
 =?utf-8?B?ZkhSNXp2aHd4QkV4TE5DSXVUMGhtUnQwb0xoc00xY0pJNEttWUZBejJMaTlS?=
 =?utf-8?B?cmx5cTBaYnRVdjdBNzNlb3F6UXFSUjdkZUM5OXBldHhXeWFKV2hqUTNwYjlI?=
 =?utf-8?B?UGdza2NkdGdFa0VhYklQOHh5VHdTN3cyM29rSmFwVHNWK2I3d2daaUppK3BO?=
 =?utf-8?B?cjVob0N5OXdCbjU5V1l6aWwxTjdFclJ4VGlVZzcwQWJ5amRiU3IzUi8zZ0x3?=
 =?utf-8?B?bVZmTVZKb0FuOUJEalN2TkUrSVA4c1Y2UHZFTXRITUYrVUJDYjVNTWFnQS90?=
 =?utf-8?B?R04wOHo3OU0yZVZtbTV3UGlISlYvajJDT1V2K3lwbC9SS3JaKytLekJrbS8v?=
 =?utf-8?B?bUViNVVoWUFRRDlKeEU1TlBUdGVOQ1RDYU5GTFdub2MyUmxaZWJFQitWOWR3?=
 =?utf-8?B?UWh4NUZ3L21aKy9rK0ExR2FMVGxTWTgrRFQ3ZmVaSTZ4Mk9VRXY4NlBzZ01Q?=
 =?utf-8?B?UjFUR3B3OGNtam1NR3JUVXkwSzhwb0djUjdWWVhBaUlHWm82eE9JbE9ObE42?=
 =?utf-8?B?WnVBdHZWaXMvYnQwNlhQVDlSd2xFK1hUUFkzNkx1dDMycGlOekdZdUE4UmlB?=
 =?utf-8?B?NVpURVM2TFhIL1BPQUMrQXlIdzhHWlNvVUNTWTdCMmdKOGxBRitPT3EyS2dD?=
 =?utf-8?B?YzBidHVRdU9lY1ZBQlUrWmlpN1Q3aWtIU0s2YlIxVWlRNktNa29PcFJqUlBv?=
 =?utf-8?B?ZVoxaTB2MDlYSmVSYVk1bUQzeVZqZXNKbm9McnBGcERwZk13TC90TzJoeWky?=
 =?utf-8?B?YmFaM3JsVVJpeWQvcWg5ZzVLM2VVNm9yam16QldiTUliVWtSdUFyVmI1dWZ3?=
 =?utf-8?B?ZERVbWV0dlkwa1FnTHovSGh5VHZ5dTVYaHBFT0p1a1ZhU0M5Y0g1Tjk0YXJN?=
 =?utf-8?B?RldnYlFPa1VkTzg4K293WTJSbGlDVDVuMk1iNjJHcUczU1FhSHZSb3VSbkxQ?=
 =?utf-8?B?N2NQaU9rMjFVakNJU0E4dFhnZEhNSGY4cXRYdnNSdlRIb1h2by9HQmVJdFFu?=
 =?utf-8?B?dUVFUFoyRU9kMWE1VFRXU2w5V0Z1WUZRcnBORWxXdkpHYnZFWUNKWWFVblRE?=
 =?utf-8?B?czZnS1p4M05oTWV1bitHM3puU2VrZDFQNEdqVHAzMmpIWjNKcS9kaThhMExY?=
 =?utf-8?B?Y1hTbnJkdmMwQWRpV2FISEpBTGlsQVpCdGtSdkVlc3dSQ09PbjQrL0VjYU45?=
 =?utf-8?B?a1NCMEo5Sm81ZmZoQXNldTFyT0hOVi9aL21CRkIxNlRLTkRZWVNXa01Ta2JH?=
 =?utf-8?B?Q0tYbGNwR2hsSkY0NjRZZ1B1TjlMUW56dTh5Y0I4Ti80all6WE5kbHBlc2JD?=
 =?utf-8?B?Mzc3WU5LNmlHcW1PSEp2elR3VkRwR2pzWVhvRUN5OEdqS0M1b3U5a1dLSTVT?=
 =?utf-8?B?SlpsL1RZbnp2bUNIQlp5TmVrdlI0VG52UTBSamdxTlcvRW9Cemp1anhBWE9P?=
 =?utf-8?B?WmxReVNEWk85Q1FEWEhRUDExTnV0eFVwQW1CWDRWdUJjSmpSQ0NDYWhKb2Nh?=
 =?utf-8?B?bitSY2VXN0tuK3ppc1BTVUJIbmVSVDJWQjIrQi96dFJYbVpRZnRrT3lKdmh2?=
 =?utf-8?Q?oLcP0QR2DeoWs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzJFVjZkd1ZOSklKMERFd0FIcGtXbzVLU2dRZzQwUHpCSkhVQ09xMGRGTzJH?=
 =?utf-8?B?WnlZU1pjUkpITU1BZFNLYkZoSE1FQWdML3oyNE94ZzJScTk2elNFY3RNa3kw?=
 =?utf-8?B?ay9PdU16Uk1RYW9QdW1ZZkRCZzNNdVhmeEdXOEdjVnllY25oNXVEZUVaUWdj?=
 =?utf-8?B?ekRESmo3bGZJS0Q2Rk5OSWhheXhzZWM5ZUFoYzg0c1h6ZmRZSDRmMk5xWmNB?=
 =?utf-8?B?ejQrVHhWa2FGS09uZ1FCeXJQMHBkdGZ2U2NPS2lYcDd1ZFVtaDNUUTgzMUQ0?=
 =?utf-8?B?bFVoQU9rZHRGL1BacU9wc3RHVDJlR3BTcjVjUXoxT0Y3cml5U1ZhYnFJSDJG?=
 =?utf-8?B?N2VGaTlSeW9iWDdvZFlYZlZRM0E5MkRSZCtRMjJwc1dNa1JnaVpaMzlGeDBV?=
 =?utf-8?B?ZFBtb2ZqWmlSN0ZlM25CczNNbWpaQVhwVG42Y0FTZy9qSm0wb2oybHhXRXJo?=
 =?utf-8?B?VzFqN29LanZOZ0Nycm9RazI2bm5FVi9ndVVuUjcwSWFMVWFRN0JGWlVJUmZQ?=
 =?utf-8?B?a3JkcGhmT2JaZmdZaHE1eWdTeW5zSFdiZGQ2US9sU3RJMjNQcTRiams2dkVw?=
 =?utf-8?B?TEliMnkrM3RCVy9LNWw3K2VzVWpVNTZOU2tKcEw4azlHNXluOCtFNFRmckVk?=
 =?utf-8?B?amZNeW9nTWFxNGJ2MkdDejg0K2lHdjdlUDNvV3Jnb3l2MFlBS3lSNFhReUF2?=
 =?utf-8?B?U1RJQlQ4d1BnWWx4anl5WTdlLzltWEtZN0lEMmF3L2lNOFhvWHZ3amY3T0cw?=
 =?utf-8?B?TmZqcGs3MDlSdEVVNkRlSjRLSE1ZZkJEWkp5K1EwSFl5SS9ZUnVlNVFDSWIy?=
 =?utf-8?B?ZnRuYmFsNUt0T3FkcTVqMDBWUnBBa1BsR0lTemhURXF6K0JSWnNUSkV1MW00?=
 =?utf-8?B?RGJqcS9rRytmS0VoK2xOTTNPR3F1U2wwdWZ3NTBIWjZ3dnFJdXpQQkh0TWJV?=
 =?utf-8?B?NC9WN3Y4SmFxOEFpWWloTnc0Wklmem5jZVJabVdqQTY1U2tEbkV2NXZsK0kv?=
 =?utf-8?B?TWFwWktvK0FMZ0NiMUxxYTkzZTJiazFDK0lCZkZUT3U3b0lDZ1RwSmlGc21I?=
 =?utf-8?B?bFN5VFlwRkYrdnlzWVh6VmsydFVXQ0xSODVocjFNamRMbkE3YUZaaG5kTEI4?=
 =?utf-8?B?amxtbVhScGdJdFNPakVJNXJvOU9oY1k5UnViMzdtS2wwdVpDcUxnano2Znhk?=
 =?utf-8?B?NXZIalNFQ0FQbjBwZkxpWTU1a1NTVXhOSmR4YXVWamtDTkxlU1JQRDlhUTRt?=
 =?utf-8?B?L3IwSkJGQmRIR2FVQnhUZmRacXpYaHNwb1pVQVY5b1JFOEtLeGpsamZQNU9S?=
 =?utf-8?B?VkNwazVMclZDRzAybGdIQVkxYi96N3hNaG91OVJVMEF6cUZ0ZWRGZVhkNmhh?=
 =?utf-8?B?UkxDbDBJK1hJQmNBV2p6ZEZySWc1QkhNREVOMVdFaVNvT2NDbjRqU1A3clVL?=
 =?utf-8?B?Q01aZmI4OUJhQlN4YkpMenRidno2d09xbVI0LzEvV3BnbGFkdGwvVU0vb0ZP?=
 =?utf-8?B?eE5NWDdLSDlCRWE2M09jSGFpc0Uxc1R2MTk0TDFYSmZIMDlZbDg4d1Jsank5?=
 =?utf-8?B?Vm1lVjVDQ0g3LzFuc05hakhyL3hGOGF0bjN2QkFtM3d3MkM4STVBUDlSM1JS?=
 =?utf-8?B?dlh3S01zTDBvZUkzN2hpTzBucytYNTJNb3NnZmxMMlQyZXFrOVFoOTFxK0xU?=
 =?utf-8?B?ZWg5Y2JIenEzaUFOdUhqanVsL1lrN0hXWmptQnh2SFdsekhqLzlHRnhwUFZW?=
 =?utf-8?B?akYzYkZpWFJNNSt6VEV2NnhvZWIweFVVNHdrM1hUNmNBM1libEh3a0Y4ODhY?=
 =?utf-8?B?YkUzUmsraW5Ea2FFSHQ1UzhkSnlEUm84YVN6c2VMaUh4elBCZkVZa2VzREpE?=
 =?utf-8?B?bkNINmRLNDQrTW1mbDhsZ2xBQ2FCL0lWNGd2RkVWWmloTXQvTmw5eVpoTEJB?=
 =?utf-8?B?N3dWZVdXMm5GOGRxaWxxejMzNGRqZnhpQmJpc2xVbnR5QXhqWnBJYU5RY0du?=
 =?utf-8?B?bnVsNnZpRW5vTXZvTXNFSmpqYXNFeVJ2MVRJS1g3NUVseGNPYkp5MWkxdWFq?=
 =?utf-8?B?eTNTUFQvK0p4T3hsTDVLWENLeG4vTDFZT1RsT3hmemVOZjBiY2lPd1lXb2Vm?=
 =?utf-8?Q?ra7fG/8OE17Le+vOntDeGvo+u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 452f19c7-6db4-4b7e-9662-08dd1eb67b48
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 16:18:45.9195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Arum49fihUt/dN5MK9k1mZ58DVIkbDvFw8tdyab85mdkpsJK5slIxJHGs6MatpvDLoYi5nPNA97QAjLhVnowjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6710

On 12/17/2024 10:08, Werner Sembach wrote:
> 
> Am 17.12.24 um 16:58 schrieb Werner Sembach:
>>
>> Am 17.12.24 um 15:11 schrieb Mario Limonciello:
>>> On 12/17/2024 08:07, Werner Sembach wrote:
>>>
>>>>> '''
>>>>> Platform may hang resuming.  Upgrade your firmware or add 
>>>>> pcie_port_pm=off to kernel command line if you have problems
>>>>> '''
>>>> Yes, full log attached (kernel 6.13-rc3 one time without sudo one 
>>>> time with sudo)
>>>
>>> Yes; I see it in your log.
>>>
>>>>> "quirk: disabling D3cold for suspend"
>>>> On the fixed BIOS I see that line. On the unfixed BIOS it aborts the 
>>>> functions at "if (pm_suspend_target_state == PM_SUSPEND_ON)". 
>>>> Skipping the check on the unfixed BIOS it still hangs on resume.
>>>>>
>>>>> I'm /suspecting/ you do see it, but you're having problems with 
>>>>> another root port.
>>>>>
>>>>> I mentioned this in my previous iterations of patches that 
>>>>> eventually landed on that quirk, but Windows and Linux handle root 
>>>>> ports differently at suspend time and that could be why it's 
>>>>> exposing your BIOS bug.
>>>>>
>>>>> If you can please narrow down which root ports actually need the 
>>>>> quirk for your side (feel free to do a similar style to 
>>>>> 7d08f21f8c630) I think we could land on something more narrow and 
>>>>> upstreamable.
>>>>>
>>>>> At a minimum what you're doing today is covering both Rembrandt and 
>>>>> Phoenix and it should only apply to Phoenix.
>>>>
>>>> I also try to find out how many devices where actually shipped with 
>>>> this very first BIOS version.
>>>
>>> OK.
>>
>> Ok found out that the initial bios actually works, then there is one 
>> in between bios where it doesn't and the next one it works again.
>>
>> So i need to find out if the the in between bios was actually shipped, 
>> if not, this issue is actually void.
>>
> Dang it: seems like it.
> 
> So should i create a v3 of the patch with the correct pci ids just for 
> this bios version?

Yes; the quirk needs to be as narrow as makes sense for the situation.

