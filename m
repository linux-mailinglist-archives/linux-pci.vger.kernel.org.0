Return-Path: <linux-pci+bounces-44082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F122CF6D8D
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 07:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7CCA3017387
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 06:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2485F211A09;
	Tue,  6 Jan 2026 06:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aeL7igoX"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802D61E487;
	Tue,  6 Jan 2026 06:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767679593; cv=fail; b=adu+HIHiymiac0bx4AyyN/td0EzLADMoi7EFT9ORSNyFTj1mmzQsylI51m2QJYcU7fF83RKdDPGO7slGkIsx0m6h36Lzk86uUUTjVXR+EzZ3NDAG+Osekqi7CKhcSuXdgIugKMyTJz23GtFHB2oEXXoqEB2tack/Hp99zbLaA7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767679593; c=relaxed/simple;
	bh=eDeTlUI+xdfUJMGwhUO7EPEVd1a5fqkUvQDUyeLWvjo=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mBDFQy9mzNcKBMqT9g/UkofViZ4jxlgOtyIMtk7W3J4XYkUU1TITMp4Vta5duQUv2LF7yFXqAwvXrGSKKONJpwhwSyT5c3vF+VopcBJIHU4RCCLY9Ci4ZEwsgwt9oMat0cY1YP8IXmrP73tXPlaMZOhs2NVtdhJfddU+t/U7Z1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aeL7igoX; arc=fail smtp.client-ip=52.101.48.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=biHHuZCUuuknPGQNU56AHqQzA9f7slZgd+p9NFUApIijAMS8ukxgXLmT0cIlGPP0CCG+ULy5cRsYJz0xr2y0hi0BbUV1jrt7EjiB/bic4/0+dyhaThCJPiboUYH22lTuBTPrVyZmPaWh+H1QNJtFJjjdfgCqK1omf976GrTXdNMC5zs405IhqBlUx2DXUvEVfGKhBiT0sbaMhk245wuqfiaxMylCi6xebrKqYcz4jCz6/UU5IDpQOSBVpgQetZgF/lvVHV9yxRBL8N1UpbvvYTuyQq7K9LU6Bwmp+EJZBp4BMbel8fPAaLHo2oX7OQHqFvM/epMTQ0uNVr43fTAUoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLJ81OUSHpdR9mr2laoQxmpQ+A0h9y4lACpIKzg7Uvc=;
 b=xCZwqHJP5kW53Ii8cz93bpyWDmd4BQ5ClnRDw2mo8BKA9xHqIS4cbBKkay6P2uxv5HcFkmN5Lz0vAmM5jwyIeGdB0cHoXnZ27M9cWVr61CWm32PGucKh5HLZmAww7yYobMf02Gb7Az6o0EWfx436qA6DV/+aHcSL+9CTxyR8BnsBMdPphfPTMvcrb1721aww7CRRiOL0AvRZR+gOSR8gsn373jiFaisiEEbAthozQ1CYQh19lo8QkMEGhr36NYcpmNbCldZt/yZSpNAj8ie5rJQgmTOk0m7ldZuLLpRPw1u4Czgx6JNSO1xt8esLtHTsaZHdLOzUbJu+gPNLH9p5cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLJ81OUSHpdR9mr2laoQxmpQ+A0h9y4lACpIKzg7Uvc=;
 b=aeL7igoXRUa11avToutJmn8uggny34fCjDiZoicnESHUuH4qiK8KZLHVHPfo5SiLJUnMcsSX6a8LQ7HN/aac0E13uV50h0al4R2f8WnvfjKrPwI6dpNKzBfui/3n1TG5sFbPrn4JLVtnXa9GKGrKawRobyDk1bnqmHUSbLybGaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB7226.namprd12.prod.outlook.com (2603:10b6:806:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 6 Jan
 2026 06:06:29 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 06:06:29 +0000
Message-ID: <fcc052db-e3da-4c4a-82d3-67e8ffe07f8f@amd.com>
Date: Tue, 6 Jan 2026 00:06:26 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PROBLEM] c5.metal on AWS fails to kexec after "PCI: Explicitly
 put devices into D0 when initializing"
From: Mario Limonciello <mario.limonciello@amd.com>
To: Matthew Ruffell <matthew.ruffell@canonical.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
 Jay Vosburgh <jay.vosburgh@canonical.com>, kengyu@lexical.tw
References: <CAKAwkKvmdKxRRA4cR=jJEdyadon6uKXe+aFXaGSe=PNSgwDf9g@mail.gmail.com>
 <cecdf440-ec7b-4d7f-9121-cf44332702d4@amd.com>
 <CAKAwkKvmZUGi+gEhr1nw5MV+rfyVP=Exu4AW1_WOPHDH6tSYug@mail.gmail.com>
 <222da706-19c5-485c-be90-2ebda20c1142@amd.com>
 <CAKAwkKu4bePg_NJ9SORcvwgkKyrr7yhGVjFyDQR+d18MtrbyDA@mail.gmail.com>
 <CAKAwkKvoRW9QE5tt+B59sYYpW5DcGP6f_+0nObzVhw15-KhbNw@mail.gmail.com>
 <a69dfa26-9ca8-4f3d-ab27-c28f16130c16@amd.com>
Content-Language: en-US
In-Reply-To: <a69dfa26-9ca8-4f3d-ab27-c28f16130c16@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0095.namprd12.prod.outlook.com
 (2603:10b6:802:21::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB7226:EE_
X-MS-Office365-Filtering-Correlation-Id: 3365cea8-d553-4721-4ef4-08de4ce9bb6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODN3eFcxTGpNWXBMVitCdEhTVmVTcndUSDdkY2NtSmpPNFI2Z0NJUHo1cmV6?=
 =?utf-8?B?MTc2aWFheTJsN3YxYU03Y2RHeFhIZWdjd09IK0w3MXNxZk5VanVBejFMYVZQ?=
 =?utf-8?B?VEdJUDg4am9kSDdVaWNZTEZ3TU12SWF4UTVOcUhMZDVrdVY0QWNnM0g3Zm12?=
 =?utf-8?B?ZDh3UHZWejRtQkt2eElOeERQd3gvUnVEVXlJVDBvRE9ZSHFmM01aQnRXS1hL?=
 =?utf-8?B?VjdOOEtSa1Z6VmNMNVNHd2hCZm9uSGpLQm03UENlUkJKR2dVQmVLSHFuRVJa?=
 =?utf-8?B?WjZjNjFHNTJ0dUtiTVE0cDA3Q0J5Y0RoazlqK2RDNEY2YUVmV1pvZWExWnht?=
 =?utf-8?B?NnYwOUYxTDJpVXlLRGJqYVFtbHZUZWRlRFMyREo5TTlRYmIxL3pjblRsNG50?=
 =?utf-8?B?WG81S0lFMWpyZFVEbmZzNXR6TWJkSTN0VnJFYUVtS09rWkd3NGNHcVlYaW5r?=
 =?utf-8?B?OWFtWmRaWUI3KzVCN1F4cFdwNlVLc0JtejlWQXlpNXp2U1NXT1czMzVhZEll?=
 =?utf-8?B?MituR3F5TXNXenlHY3U3bUgxL0oxT0hJdGpaY1BWbVJwbDRXRzJqQ3piaVMr?=
 =?utf-8?B?elpNNm5SUlgwN0x6OTViY2R2YWdWdXNneEFQNk1Mc1Y1UEJEYnZNeFlFZHhi?=
 =?utf-8?B?ckhXL0hSdWhYNUZUaFhLK0YwMEp4TTFoTTRrU2JyZ3BWTDVVd0ZoY1dyRDlh?=
 =?utf-8?B?cXhYRUlFcU15ejA4b3BSTFRseFNJQ3BnUkxsMHNhUEZUU2F2L2FLdy9VVEhi?=
 =?utf-8?B?dzdzclhCR1M2cGxnbW9sa3VCZEI0SnY5bDJLZDc0MzhYSTlWUWxIa3hVSmdU?=
 =?utf-8?B?TlRaODJ6OGlrbGsyVHhLcWdZRlhpN2srN01ja25Gek15K3RyUWFNOFhjQjRE?=
 =?utf-8?B?NlBnaU1udmxvVmQvL1NMWW9hUmk4bzlmdEUvbm94cW1BR3dGMEFodVhJQ3Rw?=
 =?utf-8?B?MmVNY21zR00yclM2c0RkQTZPM3NrUkhVY0N6dnIrbmU1WXVlT2g1WERBLyt1?=
 =?utf-8?B?Q1VEZjB6dmVkdGRiTjM3Z3VWQmVUdHM5L2VSMmlrV3dieVovQmVZS0NKNHIv?=
 =?utf-8?B?Y0p4MmhGZWpKWE1yNmw5Y3V6aGJzU3NSQTBENlR3NS8yUTV3ZHk5bUFTNi8z?=
 =?utf-8?B?Rnc1cFVZbXRXUnRqZ081MFVheE0yKzFGV0VoMWhEUGtqRnFFbW9rYXIyaXkx?=
 =?utf-8?B?U0g5NzdUdS92TmpLRHFTU3Z0M3VZK0pMYytYK0xpQWVOQUdVb0Z4UVNxU2d2?=
 =?utf-8?B?Um9nQ29SbFd1OVZPNGNCZ3I2Snl6Wkl3WEJvemFhbFVwb1RaTExSem9MM0ln?=
 =?utf-8?B?Q25RSjA0bHkyellwREVPZzY2c0hTZGszNVE5VzdtTVlUZHg1dGkzNko2Y1Rm?=
 =?utf-8?B?WEhaUE95VkdlbkgrOUFEOHQrcG9BVmt3TllycDZKd1R3NXVuNEx3WGdJZm9F?=
 =?utf-8?B?cm5EekowYjJHeTVzUWJzcUljRFdQamV4VFkwYVFwdFVKNmZNVFRwUGJPZU9x?=
 =?utf-8?B?QWpvbGw3NmRuM3NLQmdLQ05kSDRXZUVpRExqanYrT2VuMHFVd2k3VWZNNDU4?=
 =?utf-8?B?QkVHcnM5SWI4SHFJWEIwR1N3NFlCU012Mll2bUFSTGowUk45eUJFQ01OcVFV?=
 =?utf-8?B?TGxYUitxWXh6TlBuTndlbWZCTENHdnBweW5hZG9GTS9kR0FNR2lWTXZNWjBJ?=
 =?utf-8?B?Mlczekw2dm56VmhGbHZlT2c0T1FVM0ZESzBCbzF0R0ZRWUF5MmtBcFJWblU3?=
 =?utf-8?B?bVFXS2tiTnRCaHdZRXVmMzJoYlpqRnNwQmtwWlZaTFJGQXNnZ3Bid2o1YkN6?=
 =?utf-8?B?dU5JR2hacXNGb0xBWU03OWszclk3TTR1MGFYUUw5Qjd4b1M5RUVLRitMUE9E?=
 =?utf-8?B?NG1rVExTTzFFdHRaeW9BOFVoL1piOVhrVlNibzQ0bVNSZG9kem1ndEtxSm1S?=
 =?utf-8?B?TVJjZ2dkdFY0cGpQNWh3MmVRajRLQ3ROSENneVdBNXZscTR4VXd3akw5R3pQ?=
 =?utf-8?B?ZE1FQUVDQ1RnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkN5RDRqR1Ywa0x1UmJLZkNKN3NMR3QvOVl4TWV2MkFSaldHSFNqMURCWGtr?=
 =?utf-8?B?NlhTR1BjelVXcHI1TTZuc3JqdXZHTDdhR0lvaFBpRW1sY3E0RzI2S0h3cXBL?=
 =?utf-8?B?RUFERjA1SGJsaTdWSXhEa0VEVm1OaEtFMnNadk9jMXpDY3kzUmp2SytNTjdo?=
 =?utf-8?B?TENEdmpINnlHc0dwSDkxMHNmdGNoMDJralhtcnNuUjArajdtUVNiT05Pay91?=
 =?utf-8?B?M0Y1aW1oVjcvYUxVZ2t1MmpHTWlOQnluTFJuQS9NdktzS2VEdXRoRkFGblYv?=
 =?utf-8?B?V1pxeXZQd1RxSnZsaG9CbUY3a2JPMWh4NTA2YlUzVk5BVmtCMzBITDRvTm5S?=
 =?utf-8?B?eWNRNWJ6U01McEpZWDhPRlk1MUpyRFVCR2pWL3FxL2szZi84RUI4S0dZaUNS?=
 =?utf-8?B?cDVEdmIvRzVWZHl0TEI1WUIwMmtXdkJranRlVlhFMWxQeEV0eXcyOFFJSzNu?=
 =?utf-8?B?a1dCTDA1R20zSU5jRlhkeGZ6UGJ1Nmd0ODRDaVFFMURmQ3VEWmMxMVBnazBE?=
 =?utf-8?B?TFZPai9zcy9BZyt3RWlqOXdJdHErdGFpWHM2dmYzT29FeTY5TWgzT1BDQnBN?=
 =?utf-8?B?OXdtVDd3VitidUxYYmNvbU1WSnhkL21XVFZrRHN4S2NCdmsvdzlaZmVONE1C?=
 =?utf-8?B?OXlEem4wdUFBSlZEQ0drR090ZUE1czh3bHQyMjZ4Ryt4WE11RnNNTGxDekxv?=
 =?utf-8?B?NzQwaSt2c1BvZlVmc1R4YkxvVUVpRnN5S1pKSmNqdmRGRUQ4NFBmaWkzaVls?=
 =?utf-8?B?TmFWR2pJNUhreEJjWnVsbmJUMzNGTlVPcjJVNGx5Zm56a1ZYbVN6MXhkNWh6?=
 =?utf-8?B?dVFYMUZoZ2E4bE9Ma1RLdFBsWmlxK28zTGJtS1F3L0d4MHo4dm95NS9YVG42?=
 =?utf-8?B?R1lmWHVMdVdPelBMZVRsazNQdXg5Z1dvbVYzeVdSYktDWU83ZlprekI0b0ty?=
 =?utf-8?B?Zy82RGR6Y3NtWU9EeWJuNHpoQ0hKbnFhTDYvM3FDRFdmaVZXK1M4MEVjWE82?=
 =?utf-8?B?VkZDemV5Y2FCOXhWdzl4SFMyblRKeVNDZE9YT0VFVnc1bkNubmFUTmNDTzlO?=
 =?utf-8?B?K0lsZ3MwZStFYWl0R2FYVThzS0JUejVtR1IreVhNK1dydjRucDJ5RlowT1h6?=
 =?utf-8?B?TEdIampPV0VIbldhQ1RMdnI0dk9GcVFaemZDcitaa204aVRIVGk0YmpUbTJ5?=
 =?utf-8?B?V1J5SUhtcVo5MC9yN3AzNlhiZ0J0V21uRTNKaDQ5QzF5TnA3T1dLOGVvU0dK?=
 =?utf-8?B?eUhwTldmQlNYZ1pLbkZZUWFtaXRHQTc1KytRMnREQXROOGJHSnk1Qlp0VlFr?=
 =?utf-8?B?TklvRXJUTk90VDM2THNCY2VDSVI2OU5LbDQwOFNhMUNyN2ZPUGFyTUd4K2V1?=
 =?utf-8?B?OU5wU3FvbGNzUzIzR29mdVJnak9lNWFvV3ZiWXBJN09yRDNPQUorUU5LRytz?=
 =?utf-8?B?emN5eEtKRTJPb3NOSkFKMm1MeXRkVFhuM3RKM3BQTFhTT202cGQxUDRKbmJp?=
 =?utf-8?B?UWpvSnlIS2sxYVQyMEhTbE1DbldCTktjNStiM0FDOHhTUU5McDBDL0ZkYmJp?=
 =?utf-8?B?YUJvTXd4cU4zQ0xraERJMXRiREx1T08zUEpIZDcyYkZ0ZmJvbE9uMTRBUm0y?=
 =?utf-8?B?SXZ1a3VwS1REQk14eDZKZjlJRkI1U3RMQmdBU1Vhc3psQ3RyUXdwYVpJdkFk?=
 =?utf-8?B?WUE0cGJjSkgyU2p2SzI1aDY0U1RyNmxLOHZFdTNMaGRBTnNnaGM2VXNGQXF5?=
 =?utf-8?B?SFU0cXN4d0RtSmNpcElmR0FYNmZBUEhDOHEzRTVPTkFnNlZjRFZ0dVZnQkdr?=
 =?utf-8?B?VFpTNFp0MUZQLzJiZ2pCVjIrMmZlMmxPNUtZOG1CN2dqLzB5N1phc25URHAr?=
 =?utf-8?B?Rys3QjlDR21obGZuTHNhdXY3NDAwdXZ3VHFpL3J1ZmdxTlRZZHlLM0hWNC96?=
 =?utf-8?B?WGVycFN1TEk3UmZITUZkdEpBRUUvbVhRVlBNMjR3dGVNaTcyU2d0Vk9OY1o2?=
 =?utf-8?B?eWRHNjVmSlRCQ0xkYkZQNFRjRnFyZ3psdXhpcFN3cHRiMVYyZGsvVDJtZUNj?=
 =?utf-8?B?UkNmdlNsNjdwRk1BWVltWXhQTHdQK1FrdVMvNGw3dUxrR1hSS2NrKy9JNDlC?=
 =?utf-8?B?SENZYnh6alpFR3dnK0JlelFGMk11aHpIZlVSeGYwdGlhaXRLWmNWZ2Y0d2x4?=
 =?utf-8?B?cGx6NGdNQVcvb3ZxWm9BVzB0Tm1VVVhJbi9jczVDMmF4NGtReDRSMjVRMi9Z?=
 =?utf-8?B?NFJxUyt3R0huWm5pQ051dzhGSWQ1Tnd1a1ZqZFNSekhKTXl2bWxLSkNOaVJE?=
 =?utf-8?B?YjdSUVBVb295dHIrWHV3aVhBcUI3cmI5VlFOR2pkbFVuYUlyMGZWdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3365cea8-d553-4721-4ef4-08de4ce9bb6f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 06:06:29.1193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YxksXFMa9IqgmfBexv3VQLatNnOmvh6nocynJfype6sZCdxZ/8q34qKmd+upit8RonMZwDqlUrS2W0YdCtX9Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7226

On 12/4/2025 11:31 PM, Mario Limonciello wrote:
> 
> 
> On 12/4/2025 9:10 PM, Matthew Ruffell wrote:
>> Sorry accidentally sent the message.
>>
>> The nvme was still in state 0 / PCI_D0:
>>
>> [  109.801025] mruffell: vendor: 1d0f, device: 61, state: 0
>> [  109.819542] nvme 0000:90:00.0: mruffell: Current PCI device.
>>
>> /sys/bus/pci/devices$ ll
>> lrwxrwxrwx 1 root root 0 Dec  4 23:24 0000:90:00.0@ ->
>> ../../../devices/ 
>> pci0000:7a/0000:7a:02.0/0000:8d:00.0/0000:8e:01.0/0000:90:00.0
>>
>> All of these devices are also state 0. Interesting.
>>
>>>> I have a relatively ignorant question.  Can you reproduce with kdump 
>>>> and
>>>> a crash too?
>>>>
>>>> I don't actually know if you configure kdump and then crash the kernel
>>>> (say magic sys-rq key), does pci_device_shutdown() get called in order
>>>> to do the kexec?  Or because the kernel is already in a crash state is
>>>> there just a jump into the crash kernel image location?
>>>
>>
>> I did check this. I triggered a crash with magic sysrq, and
>> pci_device_shutdown()
>> was never called. It never printed out my debug messages from
>> pci_device_shutdown(), instead it just oopsed and booted straight to 
>> the crash
>> kernel.
>>
>> Thanks,
>> Matthew
> 
> OK so to me we have two options that you proved both work.
> 
> 1) Call pci_set_master() during startup.
> 2) Drop pci_clear_master() for the kexec case during shutdown.
> 
> I think we need comments from Bjorn here on which direction is safer 
> generally speaking.
> 

Hi Bjorn,

Can you review this thread and provide some comments on which way you 
want to go to fix this issue?

Here's a full link to the rest of the thread if you don't have it.

https://lore.kernel.org/linux-pci/CAKAwkKvmdKxRRA4cR=jJEdyadon6uKXe+aFXaGSe=PNSgwDf9g@mail.gmail.com/#t

Thanks,

