Return-Path: <linux-pci+bounces-21311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FA1A3314A
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 22:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F913A6B84
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 21:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC94D202C48;
	Wed, 12 Feb 2025 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1hk/Eqi7"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078A9202F95;
	Wed, 12 Feb 2025 21:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739394497; cv=fail; b=IcuZJK/i0HU9zqgmpOqrFM87iCiyFDJ42zRTcpzwhFvVA0ACmQdgVTmcylzIaZ0WNw825iYdRhsVgxcMJj+9F8ipkIiluHuOHKPIjPCbsCJgsKxVf9Xm7D0/w9jEpeuybpWzg/kpd6NlMW5pvPSdUUXiVUn2b6bJfv7bpn1cn3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739394497; c=relaxed/simple;
	bh=IpbEWdmFAQXHj+opqdBr7I95g0THAisHmSRNVZ9R3/A=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DoLL2sntmE/fkrASCZalQxHek521hCTb71ejGFKQOaGN29niK4BC6H2UXtHJl0L7sVTsS2soU6BiLpAJu+/gJPTfNIW0AxJmnnoLPfmrSejxG5GOs6kJlQJHv5wpXPsB1C1ncZydvGDV7dAe1RP0fcJbORoBmJ1SB2F9HQ3BwBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1hk/Eqi7; arc=fail smtp.client-ip=40.107.96.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nofXTm9Q9B5lwz67W+Bs512yoSu+GNzsTazKpegFGSdKWDbfi9UKT//MRG6EpFWTVl4Adb7TOSxMyw21REtDe9ljChG1cxN6I3b+4DhfQyrA/gUfrTlRszMncL9uDDs1itO1QSCwJWbu4ZI22SD5qXMarX2e/hD4u+GDFB4Lk0pc9vaj7WOQbNsOo9u0i18HypcvQLITiG3j3Ddd8/yzYbyA6BORqLYxJlDpuqqW6C4P8DtAwVAOSZD19TTpZgZpDvDImW8tU5ucofEj3HJz13IepRnd/xa4o3He/OpegBnFJdiB77gCJYsAtFPXoULCmrx9UECZpdkoz7h68pG34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6C3r4rGZJqgJ6HF7PV6oYo1a/Cp2toqoFhBVaAzNGE=;
 b=YnRrcBtTUB+IICveFeyAKSIU1KTPfsNOsnhihRSqM/8OGKWf/YcXI3hHTj5C5R6z1lu9baawQ6qtDWYsmLKO315spkfiBebk6pISsCYcYsGdh6Bk2GL3inOxpx6cp3PDYxJGVFmxfqD85Bf9ujwvoz8iyjimjOfEloxg+boCg4DaJJdNHBnyTgidAg0IWruRiSlgDsgtFs1jiB0VWA4tW5luHHin9rsu/M3XFOqw9kO26P5qPQbMtIW2x1Ks5jbDhybFIeujCgdm0Go7Z6IEG8zY9ZD0ifaw9FqEQYHI78NT9ptoer2P8OGXJzqkAuS99gtKhj4QrOD8jxyG015RIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6C3r4rGZJqgJ6HF7PV6oYo1a/Cp2toqoFhBVaAzNGE=;
 b=1hk/Eqi7E/gIu7DuYY3x4lmvrk/Y5rbD2P9n/zYFO1ZPXyIQxjORYJplbeDi56gDgOENBEtjgSfvrJY1rh7ukRknVrtDohh8cQEX992wvYZqyAsemL9FM8O/TOluk0W4mGMb4aDp8TDTB1i6gGovqKUapN6VJAutCmqSZAlLx+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SJ0PR12MB7081.namprd12.prod.outlook.com (2603:10b6:a03:4ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 21:08:13 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8422.010; Wed, 12 Feb 2025
 21:08:13 +0000
Message-ID: <02c5b364-f97a-44de-980f-e16438ec66f8@amd.com>
Date: Wed, 12 Feb 2025 15:08:10 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/17] PCI/AER: Modify AER driver logging to report CXL
 or PCIe bus error type
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 bhelgaas@google.com, mahesh@linux.ibm.com, ira.weiny@intel.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 lukas@wunner.de, ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-5-terry.bowman@amd.com>
 <67abe1903a8ed_2d1e2942f@dwillia2-xfh.jf.intel.com.notmuch>
 <9035be0b-7102-4abc-a21a-61648211be55@amd.com>
 <67acfd24a4245_2d1e29437@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <67acfd24a4245_2d1e29437@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:806:f2::25) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SJ0PR12MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 765e02a1-98d5-4abe-9146-08dd4ba95c77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFpDQzZEbjZTVGVobVpRd212TjJlUnc2QTBKSVRqaXI5TitkSHFnVUFiVXBX?=
 =?utf-8?B?USsxc2ZGMnAya25wRWFoekN2YmVFOG5MNHBEMkZyZzZlNENTM0tpMXUrdlVu?=
 =?utf-8?B?Y1BYclAxckdKTVB1Wkg2eS8zYWxoQ3djMkQ5TzREdS9WckdGMnZvV1h0RUND?=
 =?utf-8?B?emgrU2w1WHBBQ0hBUGsrdkRKc0lOZHZRSldlVHcvMUVueXYvZDFMcC9LRzY3?=
 =?utf-8?B?Q3R4cDhiK2thWTIyamlBeDQxblp1d0RHazQrQi9UcC9nWWRwMFdac2pLNHVj?=
 =?utf-8?B?cEpFb3VkSE5IbWVxeUtxR0xWMFM5R3NHTEYvNFVOSlJnblhsTmYxZ29WN0w2?=
 =?utf-8?B?Q1FKaWIrbFY4OXlSaWxnYXhWdWNLNVNieVVFNmZuTG03dkF6Q3QxenlXaVZ1?=
 =?utf-8?B?WlREeWJ2cFVsZVgzaVk0VVpjK1VCSmUrTGJYVmNhazNpK1ZvNUlxQW9SWGRI?=
 =?utf-8?B?ejZ5bFVMSytmOGFGOVRhWlhYR0dsZHJtUWk5TzdodFcvMktiMHF0NzBmQ2o0?=
 =?utf-8?B?OFQxbk5NaEhLWk5aTTRleXpGUVErc05CWDVwZXhuVjdXWjJLTGhiRGlIVlVr?=
 =?utf-8?B?bllxUVZTRVgwQnVla3VOODRtZ2UvOUVrVzdNbG5CSUNra2VOQWE1T29nNDk3?=
 =?utf-8?B?YmpNeC9ZNjVVeUVSUHlFTE41UTVQYU1qSUp3WUpqMDVhYWxVckJpdzhLK3ZZ?=
 =?utf-8?B?c0pFeG5SZ3lleCtieko2YmJUdHpHSTF6VU5JelRVSHpOYS93a3E5V0krSm00?=
 =?utf-8?B?TE1rWUZ3cGM4QWhzR1ZEd1NRQ0Q0MUhkWHlicVFzMlNjeCtnd05LcllVTWk0?=
 =?utf-8?B?ckxFaXRNdDd5UVpwamlRMy9IRVNmM25rTXRiT2U5R2hlZGlsMHlnRDcyN0hW?=
 =?utf-8?B?V25UV0ZvOVRqdDRFZUx3Wk81OWN4bnpvVDlLRDJaNkpocWlMaVB0WXFGNmVV?=
 =?utf-8?B?VmZwSEpvdlY5NHhRVVdEbXF1UDdUL082VXBUZG1NZnVrbVc0R2F0ZlNhRHd3?=
 =?utf-8?B?UVBlKy9WOHRaL085amptUk9Xa0gvd0ZhM1NJNHYwMTZGWWkrb002MHUyeTdY?=
 =?utf-8?B?TytybnhFekFVOG0rdkFxejRGSWtMaklocTlWdjdXMm90WnFqaTJ1cWlsb2FH?=
 =?utf-8?B?bDNZMDYzeUFxdklBR1hva2ZHdXJpaUZtL2tNRHpLUnF6T2NmcEZaMmYxVFZX?=
 =?utf-8?B?TUhZeVdkTEgrdmw3T0o4TDQ4V01FWFdUalBWcmRVNFhBS2hLR2Y1MThyVUNp?=
 =?utf-8?B?aGFZVDRybmMvT0hzU0NDMkF6Zzg1eHpxUDFTOTA3K0Zma3BxT25aMGNDbjZP?=
 =?utf-8?B?ZGUwZXZSZnRCRmw4OTl5WitvTzRDTU5wVG44M1hxMDA3TVowN2Y0TDgwVEM1?=
 =?utf-8?B?eEZRRHdiRWN1ai9QZzZjQm1xRjAzL0JkN3RtVXMvbUpYd2FlbHJwcGpFY1Nn?=
 =?utf-8?B?RW9WSW1WdHl3M0JYbmFyZEg5VHRySG01WEx5Ykw5b05oSnp4UkY4R2NGSUJ3?=
 =?utf-8?B?UzNaOElQZzRIT3ZFU2E4WHhUR0tJZStqSHlSd2hqRFhkQ0hPSzZFb29mem5p?=
 =?utf-8?B?WTFOUEpkR0JDajRRak02eFZVNnRDZ0xlNHc2ZFphRXZFeW9Dd1Zwejl5Nzh1?=
 =?utf-8?B?bkt0OVFQTVRQTm9jNkpUL05LVWR6MXBhcG5nNDFJMGJFVzhaVDMwU3JXb29H?=
 =?utf-8?B?eVBlUzMvdGlkcW9XcHVVMFhuaHdlNmZkRklMZTFPM0tiV3pTaWZPTG1kRDM5?=
 =?utf-8?B?M3ZaWjc4d0l0OXg2eTZPdE8xKzVuZnNIYXhSRVphcVlXS3VBL1Z6M3QzSTMr?=
 =?utf-8?B?MUtpRlgwUkRQRytheW9JRW9RV1NvbTJtYmxqa2tqdmlxam5MQUZTd2pVWHoy?=
 =?utf-8?B?ZkMzVWFVMkkrT1BTVzVXaFRJYUYxTlI4czU3NkE0WVh4ZzdPZjdSSFZ1ZUlq?=
 =?utf-8?Q?DRCSHAnYhqc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnRzYkNUWUVjUWFSNWl5SUw1V05MRlFSR0twNmw1T3d4clVnNHppMVNOYVRD?=
 =?utf-8?B?bWZvcFJUMkNOQlYwSVROelJzRXkxMk5lNU1DT3dQSmNsYWFxOWgranRGSzI2?=
 =?utf-8?B?NnF2WmI4c3g2bDZDMThWNHB2OGhkNzZhNWVmK2VqOTBIK1ZHeDZoTWx1NjRo?=
 =?utf-8?B?eWtyV1EyUnlacDdLT0RCay9HNk9IdUdxdGZGRjAwZUFKc3MzZzhQSDcxUkVQ?=
 =?utf-8?B?TjdvZHBtRXRkWk1JVE5KdGJlY0REcVdQWTNVVS9tbzF1ZUZ5TTBTVE42VldV?=
 =?utf-8?B?Z3FFWXNoUUxIRHQxVzFjb0RHekhLTEJqRTgyQ1JwbllYOWRFdTljV1J4c0Nx?=
 =?utf-8?B?YWgyaHc0VElrRkl2MFdNVDhjcUdBVWpkV3JKZUF0NVpSZTJEQURORHdHR283?=
 =?utf-8?B?M3k1dktJWVZTOVlxMHo1bzdGdG0vZ0xhZk4rV01EUXpmSFZXMEZ4Qm5MZVN2?=
 =?utf-8?B?T1pQbG80Y2hhQ3RiQVZxOTY5WUs5YndkZTdjOEtMaWJvcDRNWWhzZE1WR1RC?=
 =?utf-8?B?aFRoNlVPQVlaYnFxNDFGOUpaSFhwbUpGS0xIeDQwSERQQ1FmOUJqczI5Z0FI?=
 =?utf-8?B?WnVKQ0Z4dWdKa0dsSVh5ZFB2YjBkeHBzVERxZllzTEg4YkRoVFd3WWVlWVRM?=
 =?utf-8?B?MmVaZlFhUG42R2NQRTNzd0VOb1JBVWdMZEhEYWdQQVVXVHQ1ZzBZVlFYaUZi?=
 =?utf-8?B?S3hkWlgxN1hFQWZJd0JhbGZ5L29DQ3dwcHIycktJOFJqQ1c1emR0dzNUQjFz?=
 =?utf-8?B?LzU1a04randYVzBlbnpGK0Y4Q1BTTnMxMUZmNnBBTEQ2dlhmdFlxL2s0NVZu?=
 =?utf-8?B?WVBrajRydDdoNmlhdmJZNTlpWUg1ODFFNjBhMTk2RG1zNU15SGhGYkFRTnl3?=
 =?utf-8?B?L3hKQTdxWkNOVWlCV2p5bUdzdWVyTlNrYkxHV0Y3WUNhZmVQbGJFcjZ3Tk5x?=
 =?utf-8?B?Y2F5K1pCVWlLcmFPaitoRE01M3FkYnNWUEkvc2xzQmlTOTM2dHVZN1RERlhj?=
 =?utf-8?B?Zkh1alZPeHRCamplTDAwcUlobnkrMlJUanZoOCtmdlFzdXh6K0MrWjM5bFMv?=
 =?utf-8?B?aGVtNVpTQWRsU0NVQzdacXgvclZyVTduK1RJSXpPV2I3a2lJdWdEV0hEMnlm?=
 =?utf-8?B?TDdpT2RySUlSck5ZeTZCOWpyYUtqLzg0MVU4dXlzRytoVlB3b2xaWVl4TitC?=
 =?utf-8?B?aVNRaVJkUVVwc0pldnNXWnZ0aDJ1Wk1sYUFtMzVTZGt5NUtZb3p1OTdsMy9X?=
 =?utf-8?B?anpDbGRHeU1abjRidGJzVERETUYwdCs1a3dZZVQ2RENFZ2lucThXV2ZtUkFt?=
 =?utf-8?B?c3kyN2tpS3JuYkFZaDc0UGp2T2EyNWZyNmRjMTEvK1g1eEVkTXhHa0R6VTVP?=
 =?utf-8?B?RkpUbDZOUkU3QXlJbEZYNmZEclE0dlJac2F2ZmYzQmFmcjA4NHIyTG1menhp?=
 =?utf-8?B?TUpWTThhbFNwR3ZwV2RCWldzMzlZVERXNDZ3SnBLTU5rQnNZdG1HZWt1bnVE?=
 =?utf-8?B?Ly9lM2piZG9SeVZGU2dicTExSzVCR3A5WnhrUnNHblZQWU5OVGhqdTZrN1hM?=
 =?utf-8?B?LzhaQm9CS09pWkxUbDJ4VU5mVERqREZJV2JMWjBodUZYYmR3MURyelhPelhX?=
 =?utf-8?B?djNmTlduS1ZaL0ZCazhRT2dCNFlOVlY3NEFmWjJqVUFUdE1pMlcwdjFGbVI2?=
 =?utf-8?B?NmNMVEh3SzlrZytaRjlUL3cwRlVLRUFWcGhSTE95cVhTSmdhdnhBaXNLTTJ4?=
 =?utf-8?B?MWNVV2ZPTVdTblczSE1kdkQydFg1c2w3cVM0V3J1bEV0S0hHbHhwNUlPVk1R?=
 =?utf-8?B?VnhNazZqaVRTa0dpUlErUE4rRXFES2N3MmpsU2pjRmpaQ2lBbkFVUGR0dDkx?=
 =?utf-8?B?cHN2elRSdWhuTSt5VCt5YWxXV1lOczViUE85bzd0RWgxa05hTUI0dWxrc0Yv?=
 =?utf-8?B?WnFiaEYrWWZoNlhJdmJBUXp3d25pMXNkbmU4WkpEdkVVVldPR25lb1BiaVNQ?=
 =?utf-8?B?emR4dDRZd2pLZTVOS3JjbTAybXRtZGRHdkN0dm1tdE5lYitLaGppUzJqUEVr?=
 =?utf-8?B?R0gvRUNQTkYzWERwMThPemV4eEN1NHI1TXlUbFI2YVIzUHVBcURJQU5MZFhx?=
 =?utf-8?Q?fxryDK48Ad0bkPz8n/Co+OWYL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 765e02a1-98d5-4abe-9146-08dd4ba95c77
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 21:08:13.1781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1ypfoxjqDv1dG2O6qc0j1SX/2SMBOHxzxwYxJD2n8IowVJYVh40EKz/JsJVkabAgkFs+NWETPwrhyPeVGIk6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7081



On 2/12/2025 1:57 PM, Dan Williams wrote:
> Bowman, Terry wrote:
> [..]
>>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Ok. I can add is_cxl to 'struct aer_err_info'. Shall I set it by reading the
>> alternate protocol link state?
> I am thinking no because dev->is_cxl at least indicates that a CXL link
> was up at some point, and racing CXL link down is not something the
> error core can reasonably mitigate.
>
> In the end I think that it should be something like:
>
>    info->is_cxl = dev->is_cxl && is_internal_error()
>
> ...on the expectation that a CXL device is unlikely to multiplex
> internal errors across CXL protocol error events and device-specific
> internal events. Even if a device *did* multiplex those I think it is
> reasonable for the kernel to treat a device-specific UCE the same as a
> CXL protocol UCE and panic the system.
Ok.

I found in using is_internal_error() (v5) a USP with fatal UCE will not have AER status
populated in aer_info structure, only the severity field is populated (see
aer_get_device_error_info()). The aer_info is not populated because concern reading
the USP's AER (config space) when the upstream link state is invalid. Calling
is_internal_error() in this case will return false because the uncorrectable internal error (UIE) bit is 0 and proceed to treat as a PCIe error.
How do you want to proceed to handle the UCE protocol error in this case?

Terry

