Return-Path: <linux-pci+bounces-35181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47C1B3CB3A
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 15:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B3247ACDEE
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 13:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DCB24A047;
	Sat, 30 Aug 2025 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dj5oS5qT"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF02223DD6
	for <linux-pci@vger.kernel.org>; Sat, 30 Aug 2025 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756560430; cv=fail; b=Jn7ubI4rNyoB+46KKPRULbpp81EHuezU96IZYodfyfyMgNd8WyjJL21AXz9r+P28P/90nJcql/Bo/XU0T4YC0hrl1KttWdgmrVV7ls2AjqNgQ2C/5WYajNcly/eq+/FIjVGgAzxUgRAC8Ipwfp0OiLB6rvfgmg53U80UIJSac+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756560430; c=relaxed/simple;
	bh=OzQomh91NFQNwpt8jKuEcHDTEvfcGkQEyscjW9X6DcU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s5AyLhYVqIG6qyWQyHZ7yvH0KkIXo6B5oEePBDKVx/Q08RW6kWjNOZ6EJHoVqPfgn0KuMFovzR/lKrwIFLhuACGRdvx8xBhCcYJDE6xjZjVnLizJ694JQzXY5ODWRlrXzdTI/izVyZW0weKzY66NIGv+9O/Q8FULLLV3VIZg1DA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dj5oS5qT; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tL/Yz7qcUc7JKMDcd+nYUfsNMazAbxXYLWfO8EN9z64vbYe0nQGhGY02t4t3ILJvurSHwV5H3SvgLHZZSifkduxnjdzcRax0K90x/T0Zc/HDQqWyLbt0ur3q808H+Zq2t/3DW6Sf/jQQx2M87OLjjE+jPSfceE7WtMOTV6Etg6U7Gqju8+5jZcEy003BCnJFbHzBbvJMz5oF+eurxWEIrkPHci8aa3O0nRbkI+vQcKJkLUEM/J4RF3XAMov7tqXAtHvFgF2+q7ZAY1Q4lOdDm22jJX9dHUUJKuFuAtvyuBiau5PUxQrI5Q5EUIYEzMDWDpVpAJ5xeXcHgzCZOkv+dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hS8RqJ6QelK2G9+7MdrtWzybDlWJHS+DMnvBl7FKy1o=;
 b=SlUv2dgYDd6UCO5BYKnMqSJiTmGBKoPQ7NDJJ6CkzTXjJIKVzjDTMMGjzzMYIrazUhjMPHzLgY1eFdti1JHHwnbVX7l86J9DiKK9nnL9MsG+dRlsItWIpXNgc3gWKav0UBPvt83sxb0J7Mli4abhV/I946RoVS4/Tfl97L8nXuSxgtFyXWidLen+25ZZzMXYfXe/8Cn3oCRVP21oyjbw4riLM7c+E6wTuHWp+2HPTreBZ1qnlE42NbU7u7Mg0xq+3BdrzHfhvBJobbhok2OxyuoRLd4+TDF7y8O9x9kefJIikEmUYBFWfJkDsZSSy2NKxfleNFPatpsb37BpGC3yeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hS8RqJ6QelK2G9+7MdrtWzybDlWJHS+DMnvBl7FKy1o=;
 b=dj5oS5qTjJ700Tu/td4teQkG6mCrzZS3FU9gDsqByTwMuPNR/Nbz6d8sI+WXy1BJMLvy4MfZ6naeQqlglWfdfxMZ94Ru0SePeTc2pjoVvcprGxspirxTj3hbILF/GomNX/I9l1p82ckE+IpqEWe6r7wVC62NPpFo0qPGu94+b/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CH2PR12MB4278.namprd12.prod.outlook.com (2603:10b6:610:ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Sat, 30 Aug
 2025 13:27:05 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9073.021; Sat, 30 Aug 2025
 13:27:04 +0000
Message-ID: <00c6ea3a-8c23-44d6-80a5-d2c0cd0d9cc3@amd.com>
Date: Sat, 30 Aug 2025 23:26:59 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v5 04/10] PCI/TSM: Authenticate devices via platform TSM
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: yilun.xu@linux.intel.com, aneesh.kumar@kernel.org,
 gregkh@linuxfoundation.org, Lukas Wunner <lukas@wunner.de>,
 Samuel Ortiz <sameo@rivosinc.com>, Bjorn Helgaas <bhelgaas@google.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-5-dan.j.williams@intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20250827035126.1356683-5-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0018.ausprd01.prod.outlook.com (2603:10c6:10::30)
 To CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|CH2PR12MB4278:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b6cdcce-fd10-4e8e-6059-08dde7c8e8e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDVrVzcxaXVBamx1N3NSTjhxVy9JQW4zOUJzODBuNzU2TDhyS3hwQWZxRWIr?=
 =?utf-8?B?Q2RhU2ZpbVI4Uk11T3pVQVRsWHpNTzRBc2c2ckk4S3hxWG8wS01BMU54TnZK?=
 =?utf-8?B?U3Z0QzR5ZGtyVEVJUHhUSHFGTW53bmJNSWgwWW1SalFOSkF2aHB5UGlVd2pk?=
 =?utf-8?B?b2VNTmN4Y0VwV0tveVRvaTdXOS9pbEQ5VkpDUUh3dXg1THdrdkc2UllYL1l0?=
 =?utf-8?B?b1AvOFB2NmwrSG95VU1TQ2JudlJDcnR3MzFTN1lvWFFqZ09wNXpDQU5ZMWFw?=
 =?utf-8?B?NzFGMm5SdVp5Tkw3MGhzWFdieTF6RHY4WDhWbGs5OHA0R1REMjdMTXNITUNo?=
 =?utf-8?B?SEFuZ3FMRk1EbXU0OXp0TU5YNGpFZjBqZjduc1krUEhvZEJ4eDBKSU1VM2V4?=
 =?utf-8?B?ZStHQnN1bVZndWxDT3Mzbk04WnZUZ0Y4V2NRaFNtTGxrNXBEdVRzeXcreDhk?=
 =?utf-8?B?ZFM0UWM3WWpkcnhHNXE0R0FEZCsyQnQxaU9XS2szQXRPU21CcUJtbTNmcmNq?=
 =?utf-8?B?bG04Unk3NFI3aFM0RTczbzJFaGh0dE9QWlRhVDlRSjU2TXZuSnVPZ2FUb1VQ?=
 =?utf-8?B?L3hXWllpNkhVQ0RrVUhJLzJFRXRLeUo2YVpxaFhlQ0lOOWNCR1l0ZSt5eEFj?=
 =?utf-8?B?eElWZUhxd01HV05LS2M2V0Q5c1E5VU44bmQrY3E4T1crV2NsZm1ZaVlDOENV?=
 =?utf-8?B?ZW1nYXBWcGkwbXdPK3ZDWXZ4WDdtNUVIS0FOTDduN0tFMWZuVEZRV2lMaFJq?=
 =?utf-8?B?VkQ3VGk5QXZXeUJwbUU1cCtDbkhWNmVXdUw1MnMzcWFGK3JMMjlMKzI3RUFL?=
 =?utf-8?B?aWx4R2JXL2R5VVUzRkQ5R2Z0cytQWmdXdWd0Q2FKM1VENS85WFNWTldlc2sz?=
 =?utf-8?B?Y0tNYkJjcFRSQWZoMDVuOFZ1QVFzLy9MdThaelBYdGlMMkt2WkZxckZVKzVs?=
 =?utf-8?B?ZzB1RkY2MmdrSHF4elk2TUZ2dVpwbnJjaTVKdG1TaWZTa1dHZTc1NWplOXYv?=
 =?utf-8?B?WDRGTjNjZGhDNkJaSGMvQnQ4Y04wWGNzN2tqUDBpeVgwL09lSThJQjkvdFB6?=
 =?utf-8?B?V0VsQWpCKzkzLzNxWEc5MGRqbk8wYkN4Zm9oWkJiM2NzSEsvZWw0ZkZHTklw?=
 =?utf-8?B?cUJoVTVycHNuaDZsTXk2bUpxQmFCbmZCWXk5Z2NuZE1rM2dYUHZnelk0V0FX?=
 =?utf-8?B?SU1rM0Nlc0FMcENlbUlVaE1icWk1akNhdWp2R0x2TGtCT3ZWSGhlTXdSdlJY?=
 =?utf-8?B?cUxtZnU4TjhuaWI1a3FBTFZxVEVSbE5UVVI2UC9xUWczOWxiREdrVFVWeXY0?=
 =?utf-8?B?YjJVZG9VakY1RzVlVnJMdVdnaENhQUNwS0hLcHZYWkZIczJGRHJuazkrNnlI?=
 =?utf-8?B?YkpPR3h4TDdDN0o3bTJYU3Q4NGtId1kwRTdJdS9mVXdOUnE4UkdEdVpzaEdy?=
 =?utf-8?B?dWRYRDRnTXNjVzM2aUdqUHhTUGZ6Wjc3YXZXOE5KL3ZSS0x3c013SzRDOHBw?=
 =?utf-8?B?RzNzbmJjUmNNckV4ZU9WZ1VLaXhRbWVZUGRqWUg4NFMxU2hjdGVPdXpINVFL?=
 =?utf-8?B?VXFhN3lJVDVvR0RPZWhxVGtoTFJLSG03VTltSjI4eU9sVStzaFk4di9nemFj?=
 =?utf-8?B?L3FmZDE3SXJOemR6YkxUTHRVbnFtTCtUaGVxUzlQS2RjdjNZdnJGK2ZvZ3hO?=
 =?utf-8?B?YjE3bk5rQ1Z0cXFrSy81cm5rR3BKenFjb2w0eGx2MU1CWUthRC9aaHhUZVlJ?=
 =?utf-8?B?bEJsdmVabldObDJQWVQ0THRMRFNaSmRBL01MZnBZOTlJNGNQaEp0OW9CUUdm?=
 =?utf-8?B?SHJPTm1UZnJhcDArV0w5aE1xUEVmSkJndURPWFBUZUNUS2dLUGJNaXo2cEFE?=
 =?utf-8?B?VmhVeExxMTZVRElVVWdtSU9ISG9KQklnTHdWVjNkejc1Y0ZWZDF4aHBNUlJz?=
 =?utf-8?Q?i3iDsznr2FY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVgxOVIxK3F5N2FmUVdidkhZa0N6K2VnMWNRbmMzUzlicGtvbXk2V1Y4WmRl?=
 =?utf-8?B?NENNRGVxbUk0ZVRUTWg0SEM4MnpFOS9OaW5TamovbmwzMkozYnhNaXFzSlVi?=
 =?utf-8?B?eGtmTUhvbW1iTTJnOEdhcktDaTc0YVVFL2V3L0VPUExrTlFWcXNKdGM0bDFJ?=
 =?utf-8?B?U0dxdUQ4TGV1MVhLK3JERUdKanlwczdabkRpdEcxbnpqdFF4Rnp3UVpaYVBE?=
 =?utf-8?B?bkUralNpajJ4NnZlakMzUHk5aW1nV2FXRkdCVlkyR1dxUUd2QU5nbStuUlFB?=
 =?utf-8?B?ZC9DVXpjNGhOdmxNc252NmVrbW1zdk5ZcXVySWp5bDZucGtialdPbWVreDJI?=
 =?utf-8?B?S0YvanVEM2VaN0djTFAyclpIT2JXZ0ltME9ubzdDSTVTZHhwbXlEZk1JN2Na?=
 =?utf-8?B?R2E3U1VWejRZV3FxeDJEVkhvRUpVdnVyKytHUWZXRGNISStuN3o2UDg4SFgy?=
 =?utf-8?B?UTErQVdLRDdqRzRuM1NFYWRNUXViaXAyY3IzL2JqclZOcnBYeG14Y2IzOFlr?=
 =?utf-8?B?aGRwQ1g1VEJZczhJdzQ3TUJtOG9LZldnYjk4TWpWaWdsNkxsaVVXUXhQS1dH?=
 =?utf-8?B?VkhJZ01DZTBMY0ZNNVZteXllb0plSi9tVG1XZC9yZGVHaSs3VmJ6ZFF3Wmt4?=
 =?utf-8?B?Qzl2Tlp3UkZFeTdUN1MveldFa0FDTWtXbEovaXFkbE43MWNpdzVPayt4UGtN?=
 =?utf-8?B?YjlXWUVrODBaWWxMbmFraS9SeCtDVzk3VDJJY050T291eU55NEcvdXd4Ull1?=
 =?utf-8?B?T3pMSys4d3dmREVyV2Z5c2gvTzRseFpTSnFCa3N3eXNVbVU1SEZYWDJZRDBp?=
 =?utf-8?B?SjlDaUtPb29LWC93VW5FSmZkeTVqY1NKNG8zZmh6SlFiQnkwRGIxWTUzWU1r?=
 =?utf-8?B?QVhXVkFIQVFwV25vdXhvR2NxU3dHK3FEYzdUdFh5ZVRVMzBic1dkVSttNkZQ?=
 =?utf-8?B?L2NSRDJwRTNuTVNhVW1OdmJ6bFZKaFZSRVZhQThGS0k5dFkyUFprOGxmNWVk?=
 =?utf-8?B?YURGOHlnWHZTNTJCV2JFZm5nczRXblFOaGlCTG1uQTdpbitMK0RpM0NHQlNK?=
 =?utf-8?B?TzhPVHFZNlFyWTJRcU1EdElzblhyZzNzMUE0Y2h5czlOQmRuV2wwTFI5MnhQ?=
 =?utf-8?B?cHVRZjlESXZqUWl5eFZ2T0pjcWxuNE0yUlAvdFNHUTg0SVM3eHU5VkxwSjg0?=
 =?utf-8?B?R0NvQUZOTjFyUmVHZUxJL05kMmUrY2tIalplVTlhK1hyeFMzekdab0lraEM4?=
 =?utf-8?B?WFZIaTZEVDAvczhCY3crRXN1QktGUXV1WXFUZ2JDYlF1aG4rTWp0ekNrV1hu?=
 =?utf-8?B?eUk3eElrcEZERHVFellCdlo5TUYrVnYybjFaVHMxUWN2WVNxMkVUdDlLNjRT?=
 =?utf-8?B?S3lZamZ1L2pLLzlPaVh3T29vSUd0WmR4bWRFMnlWby8ySTU4VVBKSnBoSzVV?=
 =?utf-8?B?a2pyZlliUmdjR0RETXp6MDR1RzNIQnlmN0Q2OXMxbUVTOGNEVGxXYXA3dEVz?=
 =?utf-8?B?MHpjcUI5VU0rU0E1ZlRENHZYK3NGRG1rWDFjVSs3V01ETUpOcEIzcDVmY3Ju?=
 =?utf-8?B?YU5RUE5PaHJLWE5zalJsZ0NIbjFCc2pxTHVjSVFNUWdQSTU0Y21WUVprL2xn?=
 =?utf-8?B?czFwckNHSnF4R3Ziak9sSzhjeXVvS1Q2T25DNzFuWTU1VDZwVVhtN08xL2xU?=
 =?utf-8?B?VStzeVIrSzFoTldNZ0w3YWZTRlFDQWV0Umd4eUhxYmQ5RjVMZGRoOGFTaytM?=
 =?utf-8?B?eEpUTDl0a1FnSHJCTTcrY1RkZXJCRGxqeW5Uc25JcnFtTWdZRnlvOE1MSGdI?=
 =?utf-8?B?VlB1cHE3bmZ6YTF5d21JOWZTQXdoeHpGcHZBcWFSbnFoS3FZeGt2b3lWUXhJ?=
 =?utf-8?B?SXZYaWVtcFFGNEl4OFVycUt5YVl6cTJmQ2c4bXczbU05NHhTWXc1TVpDMmVT?=
 =?utf-8?B?d3lDc09ZSVF6Q0FlUzF2bkNGeGh3c0JuT2dVVStMLzV3OEJEcGRKNElhY01X?=
 =?utf-8?B?ZS9LZEJQRzBRRkh5SWpHU1NvQ1B2TlVEWmNvbzBlYlBFSVcvNTNqUkE5K09T?=
 =?utf-8?B?TGpmbzdKbHVRWVNEV29BU251WFpRYko3WUdtYlMwZ0tMMlJMdmlieDBuSlFm?=
 =?utf-8?Q?8h8hT7bcJmuSgPJ5fj1e3i0Jp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6cdcce-fd10-4e8e-6059-08dde7c8e8e3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2025 13:27:04.8234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qRSJBhAW4AMFpsdrsGenehTTh7QOxBk6qdzfxy4JPPGfLsvYBAUqqagEKs8k+QKoLJvG6ubfdHlOm5CJdwHQjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4278



On 27/8/25 13:51, Dan Williams wrote:

> +struct pci_tsm_ops {
> +	/*
> +	 * struct pci_tsm_link_ops - Manage physical link and the TSM/DSM session
> +	 * @probe: allocate context (wrap 'struct pci_tsm') for follow-on link
> +	 *	   operations
> +	 * @remove: destroy link operations context
> +	 * @connect: establish / validate a secure connection (e.g. IDE)
> +	 *	     with the device
> +	 * @disconnect: teardown the secure link
> +	 *
> +	 * Context: @probe, @remove, @connect, and @disconnect run under
> +	 * pci_tsm_rwsem held for write to sync with TSM unregistration and
> +	 * mutual exclusion of @connect and @disconnect. @connect and
> +	 * @disconnect additionally run under the DSM lock (struct
> +	 * pci_tsm_pf0::lock) as well as @probe and @remove of the subfunctions.
> +	 */
> +	struct_group_tagged(pci_tsm_link_ops, link_ops,
> +		struct pci_tsm *(*probe)(struct pci_dev *pdev);
> +		void (*remove)(struct pci_tsm *tsm);
> +		int (*connect)(struct pci_dev *pdev);
> +		void (*disconnect)(struct pci_dev *pdev);
> +	);
> +
> +	/*
> +	 * struct pci_tsm_security_ops - Manage the security state of the function
> +	 * @lock: probe and initialize the device in the LOCKED state
> +	 * @unlock: destroy TSM context and return device to UNLOCKED state
> +	 *
> +	 * Context: @lock and @unlock run under pci_tsm_rwsem held for write to
> +	 * sync with TSM unregistration and each other
> +	 */
> +	struct_group_tagged(pci_tsm_security_ops, devsec_ops,
> +		struct pci_tsm *(*lock)(struct pci_dev *pdev);
> +		void (*unlock)(struct pci_dev *pdev);


So, following the remove() example above, this guy should take struct pci_tsm*, right? Thanks,


> +	);
> +	struct tsm_dev *owner;
> +};
-- 
Alexey


