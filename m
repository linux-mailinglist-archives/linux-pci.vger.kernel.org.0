Return-Path: <linux-pci+bounces-29039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 581B8ACF3A3
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 18:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A717B1887D78
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 16:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03387261A;
	Thu,  5 Jun 2025 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sWii+LnI"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58341199E89;
	Thu,  5 Jun 2025 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749139295; cv=fail; b=pylNi7L43uefDyl0sCXoFD78mzN9PGVLyIeTvb+ZNceVzTIP4rubVud/bi7y3GyTHm0TeHObZAzMZziIzpM0Zo5SsbuN0wuO2iQJyNf/D7EAzma7KOhW589nZ0dQWwEV8YBnOgItWAdXWybcyQyJuFZ8UNds+THvnfn+qCEoBlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749139295; c=relaxed/simple;
	bh=rxer7jdLiY2aJNx0GvhTRLeIZwyk5GaCYT3CUlpGV7c=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hV3Z7yfzBM+dtu36inTCTJYQlkJVTzAhzQw2nUiVKtwa9Mg7kL7iNtwtZ0AUMlgBh9zPz+CEM95QSNlVfQ0kQ3yaTzATVt78q2f/2xed7PhkxqxQI7OKOJib5Zmhssb46L0+pso/zzXmDfWOUmZ0vz3wezaT/n43LZdaOo3031g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sWii+LnI; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CsSYl3h/q5VQZBu5Bi8/T668nAMQVqNhG6FNH9UaARIKADdyku0cs6wOCYgaGVqfUyyKocD6Sb+ncjbn0zf/AWq/AokuABZIASxZNAmweftIWhk8PC87fhOdOBqDNYhN1e7rJRR75UpmCoO3MTaFcDL7GAhNHVcq9DawHiHXq6aeNf/6d9lDeYX+v80ZvlCcXBs6p5Tj2kLAuBDJ865JZwMPNQ261lei1dvpY/kUDsolIRwN8dUDNImHAB+QOmIKvgOKjrir7zXwPEsfIsh5rdwXmxTDNpTP+etH0wNtlVfky2B+75F1S0A81vsFhj10hLOcUa223ZB1LZlEwc9jLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I8F5meKzh/LwybhbM769pQgdV8lhxL/4Zvh9Ocsf5tM=;
 b=iKhRK0r5Q5e/feP2FDP90+oWQYOsPdtlUdfecE2+jXIg0A8ixMgvcNCzWOKMn8mABioI6jyVhphX3T2Tl17oh5Q0W+XyUOPT9mR77oDeGqeVrziAhZ/eRzgKWltKlmcQ08MMQClwRDLDD7lIlJNrUeq8cOTtN8tRg3fHGTNEqbC+tnlzFaEB3CJ7nfYPO9f37a3WdlzK0jgkwyLu0ouecfb7QzF1fHX+YaR7Uvi1KkAN34hdEcl3se9eDzoEQEfMeUZc1IYexQLMwk1MIvimgx+yOUDVQNXjz1/e7xt0Sc3kWrJPqgTeHXMoMALgJZzC/PqV9lVKTHnJzApOLKqLpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8F5meKzh/LwybhbM769pQgdV8lhxL/4Zvh9Ocsf5tM=;
 b=sWii+LnI864Lizm2nxEVkbehQwon7ISX/WrJK6k7MdIWthMIQElC2iTLdPySXR3TJ6xRTxNF1CrcAoaaORQ0HAg/sV1lxHhh9CCoTkGgypJMmupLocD/zST4MEhEgVmKrxYYk+tqQ70yBA4YITpNMjUDCvchIAGcp7sZNmzljTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SA3PR12MB9159.namprd12.prod.outlook.com (2603:10b6:806:3a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Thu, 5 Jun
 2025 16:01:28 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8792.034; Thu, 5 Jun 2025
 16:01:28 +0000
Message-ID: <9df8deca-a34e-4f0b-aa02-084260b14c55@amd.com>
Date: Thu, 5 Jun 2025 11:01:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/16] CXL/PCI: Introduce CXL uncorrectable protocol
 error recovery
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 PradeepVineshReddy.Kodamati@amd.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, bp@alien8.de,
 ming.li@zohomail.com, shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org, colyli@suse.de,
 uaisheng.ye@intel.com, fabio.m.de.francesco@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, yazen.ghannam@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-6-terry.bowman@amd.com>
 <4ceb5bef-d5f2-4552-a1aa-c282286bf10f@linux.intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <4ceb5bef-d5f2-4552-a1aa-c282286bf10f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0029.namprd21.prod.outlook.com
 (2603:10b6:805:106::39) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SA3PR12MB9159:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ebda5d-449d-419f-3045-08dda44a3b09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2o2MmhmNkc4aXlDejAyYXFGbVF5aW9DQkFlNldxWkMrNEJRNjJ6ZzY2Y2xs?=
 =?utf-8?B?bHN2SnpzSld2MjY4MzBVWm5nQ0lHQnk3QWFhTDRVRloyTVpXYmFVVUNVdXoy?=
 =?utf-8?B?UVk4b2o0L0d2N3lnSW56cjVzdklBUEYyWUxjcXVIWjI1MWluTVZYN3JyTW1K?=
 =?utf-8?B?SklzQWpKekZ4NUxScjhpV3BLMnhaOENrdUlzczVEWUZaVHo0UXRKVEtCZTJs?=
 =?utf-8?B?aTNrSUJ6WXVaWmdPVmVuMnIxbS9mbWNoUVlVdFB4L2JxdzRiNnhwUnpoS2Nr?=
 =?utf-8?B?dlpUVCtwMld5ZWZBSUgvU2RDRXR6ZGVFSktDQkduUlQvWmFOOEcrTFlBZmtl?=
 =?utf-8?B?TUFnUkRkWVU4SG1sQ1dwbHN1K3pMNGZndmpqUVhlQTRGT0NtK243SkNKV3lj?=
 =?utf-8?B?QmtTRnV2SkRldmNISmxpMjhkSFJsYXUrcXFmOTdZZFFRdFZCbWlxQmVxYlU5?=
 =?utf-8?B?UWtCSGlNRUw1NDBRRmUwRHpuZU0wTzk4TmpBdWVDWjJXL1hQcnZuUEhINXZj?=
 =?utf-8?B?QlIxSldDTDlxdGMrUUpTS3RnOGRMUkwvWmxuTkx4OUhaTHFhY3pmS1hGRExp?=
 =?utf-8?B?Zyt2clpTUzYycVl1Wm9nMWI0THI5SjZnQnhvVlRtTXdVLzBjNFlMSWtQVjA0?=
 =?utf-8?B?eTJPcFRubGU5UGhDN3l2Y2tjajJUeE1UQi9SNzllWUp0TXphRGZyZVpnbjVq?=
 =?utf-8?B?ZDFhT0RjWkpoemQ4eW1uS3RZY3pkUE5STW05TzRzTGdUcEN2REFnUjJ0RXJF?=
 =?utf-8?B?UW1MbUZhMVoyOHB2TEE2UE0wZkVnNTE4Um8xNGhKU3Q0UE94UzM5K2pYRlVw?=
 =?utf-8?B?N1d3N0pCa2R0TWp1RktqS0hSRnRieklqNGtjN1V0YkNDcjd2UHZwU2U1MUJo?=
 =?utf-8?B?L1NjeHhCV0RENk81YU5rZXMyci82TUl5NEFoNHlvWCtIaUxMSmRPMU1CV09v?=
 =?utf-8?B?SEo2QVRzOFpvdEwrQWVPM29RVjdTeStLY0JmYkJPN21XUGRZYllGSTN3Yk55?=
 =?utf-8?B?NTRreWZjWC9NT3dkaC9HVGdkb2JkWmZYTWkzcTlybzJqemM3NlcwbVRaZ3Nq?=
 =?utf-8?B?SS8wWHQxMmMrYWxSc3VTdUR1eWNpNWFzVDd2OHVvY1drZ1RwZVZkbG5FcWkz?=
 =?utf-8?B?enpWZFUvMEhZaWE0ZUdEc05FdDFsZE44S25IZzQrbFVrcXpNT3ZWcGJjamZu?=
 =?utf-8?B?Z0J6QTBrZHlvSjhpYTNjeTYwYUFMQjhuVU9CMldUcXlBWExFcDFQaXlGaVlt?=
 =?utf-8?B?MGdoZUhYNkZCKzh3c1ZITEFQQ3oxRU1YUnJJMnhLU1phZEdqU1dadjNkR1d3?=
 =?utf-8?B?aEFRM1V4RFZoUFRTRHBESUUrMU94UnVsaUk2aWZBZk5USXREZ3FRL1VIcGJ5?=
 =?utf-8?B?Y202LzNkVW1mc1A4dWlpdVJsZC9ubWxYNmtmTGlKR2p5UFcvdGtWTWdNeVk4?=
 =?utf-8?B?Y3orQUNJSVNYYWpUdzRFdHZBT1BhczNVWVd6QTFPY1dSd2R0akNDdTF0RzJB?=
 =?utf-8?B?TXBoQzBZRTdKNzQ4MUxWejhNL0lINkVoV2ptUWwzSDgwaGFCdmdzRFppN0JN?=
 =?utf-8?B?dFNKai96aytJZk5QenpYYmpuUi8xQ3IydVZkL3lMMlAvaW1iTWliUEE0bnRy?=
 =?utf-8?B?QSsyTWFNTzY0Nm0xOHVSYmZpNHV5T1ZJZHplckZaRHRQZjVucVI3ZDlPQU1B?=
 =?utf-8?B?QVZXTERHb2JxT0NrVkx0dEpUcU54NjZuUC9CNXB6eVJQMHl0MFh6L1k4YWVx?=
 =?utf-8?B?WDQwRjZjVXRXL0pOUjMwWWJVZFB2L0lxblJHQ3FBeUtYTnQyM2dnRFZQVThT?=
 =?utf-8?B?aFJ6UHBKV2lkTmNJaENXTFhjN3RjTXFuZzJjOWZNNjNqYXViN2NIcE9BZ1Yx?=
 =?utf-8?B?MTl1QXlVVi80YSt6dzNZcHQrRWRtSTUvR1JDREtWZWhZSGd2L01waVdZWGNU?=
 =?utf-8?B?NHRRcW1idDFEdVpmZWxYSzRPVmVLMityT280U204NXp1NVUvRUdaL281ejFr?=
 =?utf-8?B?eG5STGJJK2RRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THluMVNDL0xMUWVROXNDWHMxMXdvcnhBWnovZG0rdHpjVUhVWU9aRGdlVjJt?=
 =?utf-8?B?TEF2STNHT2dtb0gvY09iQnErMXl5bXB2NGhFT0FIOGtZdXFWa2RmZk9UamtD?=
 =?utf-8?B?ZVhmTWdnTngyMWI5cEJJWnY2VjRzNVFPMjNuUGt3UlBXdU5PcWViRU44dUZE?=
 =?utf-8?B?c1BXUmIrZ0dMdzQzVVBaY2RIL0szaU5oK25helhIOGpNT3RXU2pIRWZFbG9x?=
 =?utf-8?B?OFpsNXljODJJNzc4WUVHL2JuL0lub0JEUkVJQ3FTejBGaUREUHREY1U5U2xE?=
 =?utf-8?B?TEpmVlhrcWZZS1A0cG1SQ3dmNUIraFpKSkptRGpaWjdHNm5ZaUU1NTFMdWlG?=
 =?utf-8?B?QjRBU25uV0U3NGJJL0d5eGhjczBRakQyeGtlTHpxd2dUV1I0WUs1VU5OYXBN?=
 =?utf-8?B?SlE3MEtERkhyL0ZqUXNtNTlVWXIycm4zOGdaV09tWXcvdVJobElORXFBL2ND?=
 =?utf-8?B?V2pFMDI0OVBZL3ltZFExR0Q4WWw0L3hOV2pqQ1BkWmY4Y2IzS0xUZ2U1cHhL?=
 =?utf-8?B?OGFVU2RrSVZXZFFrRXNnVndubXFFTWFTb3JzWE00MXBucTdLcXF0TzZuT1V1?=
 =?utf-8?B?Vzc1Lzl2V3RPaElQUUxUZzBTdkk2eFdzWDFKODZKSjlML0JOUVMwS0R1emM5?=
 =?utf-8?B?STJWd0xORGgydU5icXdiNGszWTFSKzdnMjN3RGRQUlJOakNkRjhhbFhvbm5O?=
 =?utf-8?B?N3pPenNaRW5tS0FHY1pCcjRKbFZVOVM4elEyU1cvOENpd1Fuak1TVTU3T2RK?=
 =?utf-8?B?VXQydlJDa1VjSzQwSmYvVVFBeEtURWpVNnBJMFdjbUpGcVhyancwNnRZY1RB?=
 =?utf-8?B?MEp1NmZ6ZTZjTkRSYzZnUDNJYldPek84SGpGSlFIclN4dGhnMkJQWEFHVXdZ?=
 =?utf-8?B?eXpxWlBqd0RxQTFIUGNwSHB0aVZwTDZQTW1Cc0gxQXFlemtqeUQ0WUJ3Ukdn?=
 =?utf-8?B?U1czTFpHeStkUEhDZU5hK2tXcHk0bzBOMXlsYlJ1RzF1bEdKdTNhTjU4d0Vi?=
 =?utf-8?B?eS9NOUE1bWJwbjF6YU5DNXVySGh2ZkJncjQwb2tndEdHU2wzSHEwMEErTVMr?=
 =?utf-8?B?RTMyTkxoVmNlMU02NFFCU3dBT01UNEltRk9iN01BOUF3ZUZJUERyR1JVSTg4?=
 =?utf-8?B?ZlYySUdOVGN4Y0dWUGx1TTBIZXQwU1Z5cnlmZzYrb2dYT29UT3Z4TFh6akl2?=
 =?utf-8?B?RUF1WU1ZNGFUbDIwVjY4NE5CeXFMeHNMVDVRQXlGNFFNWndmNERka0ZrZDQz?=
 =?utf-8?B?L2tLQVVzdWl5Skp2eXBWME9xend3R3FHdXduaTNNNmIwblJXNno0RWpTeVAy?=
 =?utf-8?B?QWFpSGVCWkNEdXVxUWhJYnd4R0pSUk1rZk16em1wb3BUSVo2dGEyRDhIc3Bl?=
 =?utf-8?B?VWhBK24yYis2VDZobWlwQkFVd0dLbk5IWXE0TE1yUHNJeVVkQVo2ejVJaHFZ?=
 =?utf-8?B?MTZ4dE9Xc0tUdTJ5YkdwSS91VWhJdDFZY0xiVzF0VTFqWTIvUDEvamN0Mmo2?=
 =?utf-8?B?ZkVPQW5Rcm4rWnAxZ1VoU1dUU3pEcVVvWmRZOE9nZGRnK3ZudmxOa1FrM2w1?=
 =?utf-8?B?ekl3ak5JQ2FuNnFlQkJETHRHMWVvdDRuMWptL1loOFBXSDZYcXNPdmVyYTFC?=
 =?utf-8?B?bnd5Z2hieEh4OXdDV2RSQWNuVlFVVGkyUlFraGlYdU8xMjJQTThlTHRpS2Jr?=
 =?utf-8?B?QVNOa3J5SkNxaUN0VEhnWlFBYnZoVjRaRitTbmxXQVVtM2tpLzloV29nbnNU?=
 =?utf-8?B?KzBkT0YxSnVFZzJSN29XMnBYNXVRaWh4MlZTbjlWREJQbklUZW5hdTZUR0Nl?=
 =?utf-8?B?a0lFUDQ0dy9SalVnMkVMdFg0SjNzOHpRd1BUUmFQMEpvcTNhZ2lXTmNwM2VI?=
 =?utf-8?B?YzhHMzA2R3lqMlMrWkVXSSt4YzYweGlGckFvampRVkpJZGVsUkNmd0oxRzA0?=
 =?utf-8?B?QjJUUG9yUC94RUZNY1NoZW14eHNyQnVUN3QweGlkZzNXbkdXM3hNdTZZSVJB?=
 =?utf-8?B?V0cvMjZSNGFqTVg4ZlNDV1MvVmIwVGRWZVd0T1A4Tm5aS2Z5OXY3ZDFOS3JM?=
 =?utf-8?B?YUZzL1VPWjZkZkFrUi8zZUw1SGZ1ZWczUEwvU1RSa0lUWVVURG4wRXVGYnlh?=
 =?utf-8?Q?99YtzvsCy6SpauOJWgj8htOLH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ebda5d-449d-419f-3045-08dda44a3b09
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 16:01:28.3957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbhIxIrGFvSy0nXh6TH+7motU3Y9pR6KJLycGmgQEyidX6RGmTfcWw5J3B5hv4YoLY8sJ8VqA6HkDf7VrfqgeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9159



On 6/5/2025 10:14 AM, Sathyanarayanan Kuppuswamy wrote:
> On 6/3/25 10:22 AM, Terry Bowman wrote:
>> Create cxl_do_recovery() to provide uncorrectable protocol error (UCE)
>> handling. Follow similar design as found in PCIe error driver,
>> pcie_do_recovery(). One difference is cxl_do_recovery() will treat all UCEs
>> as fatal with a kernel panic. This is to prevent corruption on CXL memory.
>>
>> Copy the PCI error driver's merge_result() and rename as cxl_merge_result().
>> Introduce PCI_ERS_RESULT_PANIC and add support in the cxl_merge_result()
>> routine.
>>
>> Copy pci_walk_bridge() to cxl_walk_bridge(). Make a change to walk the
>> first device in all cases.
>>
>> Copy the PCI error driver's report_error_detected() to cxl_report_error_detected().
>> Note, only CXL Endpoints are currently supported. Add locking for PCI
>> device as done in PCI's report_error_detected(). Add reference counting for
>> the CXL device responsible for cleanup of the CXL RAS. This is necessary
>> to prevent the RAS registers from disappearing before logging is completed.
>>
>> Call panic() to halt the system in the case of uncorrectable errors (UCE)
>> in cxl_do_recovery(). Export pci_aer_clear_fatal_status() for CXL to use
>> if a UCE is not found. In this case the AER status must be cleared and
>> uses pci_aer_clear_fatal_status().
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>   drivers/cxl/core/ras.c | 79 ++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/pci.h    |  3 ++
>>   2 files changed, 82 insertions(+)
>>
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 9ed5c682e128..715f7221ea3a 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -110,8 +110,87 @@ static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>>   
>>   #ifdef CONFIG_PCIEAER_CXL
>>   
>> +static pci_ers_result_t cxl_merge_result(enum pci_ers_result orig,
>> +					 enum pci_ers_result new)
>> +{
>> +	if (new == PCI_ERS_RESULT_PANIC)
>> +		return PCI_ERS_RESULT_PANIC;
>> +
>> +	if (new == PCI_ERS_RESULT_NO_AER_DRIVER)
>> +		return PCI_ERS_RESULT_NO_AER_DRIVER;
>> +
>> +	if (new == PCI_ERS_RESULT_NONE)
>> +		return orig;
>> +
>> +	switch (orig) {
>> +	case PCI_ERS_RESULT_CAN_RECOVER:
>> +	case PCI_ERS_RESULT_RECOVERED:
>> +		orig = new;
>> +		break;
>> +	case PCI_ERS_RESULT_DISCONNECT:
>> +		if (new == PCI_ERS_RESULT_NEED_RESET)
>> +			orig = PCI_ERS_RESULT_NEED_RESET;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return orig;
>> +}
>> +
>> +static int cxl_report_error_detected(struct pci_dev *pdev, void *data)
>> +{
>> +	pci_ers_result_t vote, *result = data;
>> +	struct cxl_dev_state *cxlds;
>> +
>> +	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
>> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END))
>> +		return 0;
>> +
>> +	cxlds = pci_get_drvdata(pdev);
>> +	struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
>> +
>> +	device_lock(&pdev->dev);
>> +	vote = cxl_error_detected(pdev, pci_channel_io_frozen);
>> +	*result = cxl_merge_result(*result, vote);
>> +	device_unlock(&pdev->dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static void cxl_walk_bridge(struct pci_dev *bridge,
>> +			    int (*cb)(struct pci_dev *, void *),
>> +			    void *userdata)
>> +{
>> +	if (cb(bridge, userdata))
>> +		return;
>> +
>> +	if (bridge->subordinate)
>> +		pci_walk_bus(bridge->subordinate, cb, userdata);
>> +}
>> +
>>   static void cxl_do_recovery(struct pci_dev *pdev)
>>   {
>> +	struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
>> +	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>> +
>> +	cxl_walk_bridge(pdev, cxl_report_error_detected, &status);
>> +	if (status == PCI_ERS_RESULT_PANIC)
>> +		panic("CXL cachemem error.");
>> +
>> +	/*
>> +	 * If we have native control of AER, clear error status in the device
>> +	 * that detected the error.  If the platform retained control of AER,
>> +	 * it is responsible for clearing this status.  In that case, the
>> +	 * signaling device may not even be visible to the OS.
>> +	 */
>> +	if (host->native_aer) {
> You don't need to check for pcie_ports_native ?
You're correct. I need to check pcie_ports_native for case when the user commandline includes
'pcie_ports=native'. I'll add call to AER driver's cxl_error_is_native() that checks
pcie_ports_native and host->native_aer. Thanks.

>> +		pcie_clear_device_status(pdev);
>> +		pci_aer_clear_nonfatal_status(pdev);
>> +		pci_aer_clear_fatal_status(pdev);
>> +	}
> Since you want to clear all AER error status, what about correctable status?
I intentionally left out the CE status clear as it should be properly logged
in the CE handlers.
>
>> +
>> +	pci_info(pdev, "CXL uncorrectable error.\n");
> pci_errr?
I think this can be removed. I believe this was left over from debugging. At this point the
UCE logging has already occurred making this unnecessary in production. Let me know if
you want to keep it with the recommended change.

>>   }
>>   
>>   static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index cd53715d53f3..b0e7545162de 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -870,6 +870,9 @@ enum pci_ers_result {
>>   
>>   	/* No AER capabilities registered for the driver */
>>   	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
>> +
>> +	/* System is unstable, panic  */
>> +	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
> Since this error state is specific to CXL, add it part of the comment. Otherwise,
> other PCIe drivers may also use it.
Yes, good point. I'll change.

Thanks for reviewing.

Terry

>
>>   };
>>   
>>   /* PCI bus error event callbacks */


