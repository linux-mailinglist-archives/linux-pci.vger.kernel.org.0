Return-Path: <linux-pci+bounces-17987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 072B89EA8A9
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 07:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51DB28516A
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 06:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590E4228397;
	Tue, 10 Dec 2024 06:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hp74BJyj"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A40D227560
	for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 06:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733811514; cv=fail; b=ColILq1XHlsxK+ORTIp7S07AuN7i0UQ4CjjDDE60uniSJwlT7HfsN1UbALcOS1OHN4jC3NRyRRVZk/6YiWmWncuyWH9MYld41u/8R25WnYgfZSQVkTZPvg6bdJI6fHD7hmDsULgHfzqCAPb040xhYR73KJkCIrXL8H18rJ0jduk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733811514; c=relaxed/simple;
	bh=kE8groECKBQ9CEQYSyQ8zvovehZPPM8UF8EUsG9nzS0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mXIx8Gwk2NHYHhQcBy22t0+xFnaWvtVpZdlD45OFshoxSaPv0d5EWfBqzzmb3750wzyeKbYF83CkcSFN9EQtl68ijPdFnbUhIPYj0V/2xHMXKHbkgKlZPIlloU36cnIsCcbnUKW2rY5Ck+GI8XpsbxnRXi1uAxCKA6md7gyz1MU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hp74BJyj; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0rOp9xUacZhWRgf29cbY7VUcXQhwIpyXnwMEhaeZw5GThPJwgV6aUj5RFiNymgSF8uQjiONdQlUJY/YFOW8nZQQMuRzsn8dLVuibXCxFrjv6hbyP1j3g4C5Qn27Vdi0a+2vVyHeoluEB15gE5A7Wv3Xu4vvzCXyrsdUWat4rmy6l07U7fr5+x26tA4b+jSj++C/PId0kBU14x61c8ZiMa281rGz+PECyoExJa2qGd1x7wCUsGAGKKa6GFzkbGW+qmbItNKbbhugGA4PEFdAzbw8wHp5nnvNZ05bMFYFX7qtWvK0LF3in5MKP8GTTMlFqZ3Ck2vwP3OCayYDNgBj4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6bHGRLAVqkD8pRgrhDfGKQIIpXj3uaUYobKaPWCQIQ=;
 b=jH4CGmYILfJTwlJBBZ2lLF0MKPcAmLzXYP+xH0wCzV6nVXqAI7IW2UhqY053GMPfXIl5JfSO4fFWz5FEaLEFACPF1+StY19GOmNI7gNQSk0Ue12zaGJplf8zEBmi2PiBwiuOyXOxFNCNcyDroizblsx24khp5xkPxb9Un90EDcrJDT70LtxAovIql6jU/GeL22TgbKZk8MM/QlDf9x7rEE9CpWq6R2/eEi0mC6m3vQjae+STALsXf45xkSKoBeo+L9Do2DIFpHPntacrftHGU3P/pzP8alQrmcl657xc88LxHlWHUCPwgygUp2EIcNaeRKMtnOZh1C0pkBfD0LQ2rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6bHGRLAVqkD8pRgrhDfGKQIIpXj3uaUYobKaPWCQIQ=;
 b=hp74BJyjjyeOSNHJfkIVEHSPoYFogvEAuXqkYUIM6un0h/M9cQOgFRCg+cx8AfXIl+4jiENZtKzaDYIeXH9BHYNJuizVV8B/CNbuK0DKP7FLI4FChoQWK3pYk5hciJFC8XD9LSTrP4xM8BALA04hhLw/zPXkwI8cEtOJhO2hk9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by IA1PR12MB7711.namprd12.prod.outlook.com (2603:10b6:208:421::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Tue, 10 Dec
 2024 06:18:27 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%7]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 06:18:27 +0000
Message-ID: <4a50bcf4-89d0-466b-a27d-6036882e5fc3@amd.com>
Date: Tue, 10 Dec 2024 17:18:22 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 04/11] PCI/IDE: Selective Stream IDE enumeration
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org, gregkh@linuxfoundation.org
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343741936.1074769.17093052628585780785.stgit@dwillia2-xfh.jf.intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <173343741936.1074769.17093052628585780785.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY4P282CA0008.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::18) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|IA1PR12MB7711:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a4c7fa-5e81-4ddb-c5e4-08dd18e275da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGNzTUd6RDVYT1BSOUZXOHpFU09BQ1IvSG1RYVB3ZFlQUHBTN0ppNWkxZ242?=
 =?utf-8?B?Q25zaXh4ZVp4TUJjenNybnhweGdCUVl1WXRxRllKdmlaaFpzU1QrWENXKzUw?=
 =?utf-8?B?VlM4OU92NFdEbFF3eU9CdE5QVkQwWGZBTzNxeXZGNXN2YUlkZER2TEVnSWNz?=
 =?utf-8?B?TVlDdG0yS0ZIWVViYmtOelBpWmorOWgvdXp4U2hidGhsQmRvREx0NitNdjdm?=
 =?utf-8?B?dVdteURGWEJ2eEUzeWgvcHdxZlFNT2x5SENGN1lzRU5LbWJ5QWxyWlFTWDRv?=
 =?utf-8?B?K1Q4K3dKRVkrUUNSRXB6SHU3TlhTZ0Jvcm5jUExIayt3NHU0Q1hXSmZUMEt0?=
 =?utf-8?B?RDNwb2FsVE9LQmV0c01YNm1oM0hGaCttRzdvUDNXR1RLTWFkWG1wQzBYa2FO?=
 =?utf-8?B?eDBqeWtiRzdoUSs4RlZjSTZsa2lXTUJWVmFCb1pGVEliTXA2aGVsaURmRktW?=
 =?utf-8?B?cm1rbmZyOTRqeVN1WlYrR0RWaXp4TkplMXVJRGhpRURZN1VUTEtCM25GcHlE?=
 =?utf-8?B?aTQ5OGZZZ1Y0R3h2T3NaYTAwb0c4cWNGRmtXT2lRSmdNL041L25aUCtOR2hH?=
 =?utf-8?B?emxaVkxzTUZWTzVLL3lJK0hYd3dZc0tkWlNTZVdlemlVd1FXUDZjQmU1Vk10?=
 =?utf-8?B?Vzd4ODRROXBmYnNaWGZqK0Njb1hhQ2pEOGJDRHJ2OWk4REdMNHRoSDFUaWJv?=
 =?utf-8?B?RXV6ZXhmZW84NGV5c2wrVHI2Nk9vNmNoUDk4dE9iT2RraWtkdjhRVmFUNTQ3?=
 =?utf-8?B?MmhDdWRhQm1ORHFNVjZ6SzhLalV6ZFpuZVZZUUg3OXEzY2thTWtkdnNaUlRB?=
 =?utf-8?B?NEo1Vzliem4vZ1VOMGc2M2FWQjZzMnd4Z2gzU0RSTVNlRnd3YnhGN1g2NXFN?=
 =?utf-8?B?R3YzbWdtWjh0VTI3OEpjdjFjR0xkdlUzeGZRRzlDQTgzdVk4V0FZL3JneGhu?=
 =?utf-8?B?NlE4SHkzWmFlZ2NRaW9URDljOERiSTV4ejJ3Q2IrSk9DRVFYUnhtQTJmK214?=
 =?utf-8?B?NUVnaDNpRmJraFViVTkvTW9pOW1CMHN6UGRsNDBSRXhFdzhtSXJkYlVZTXh3?=
 =?utf-8?B?VXd6Tk1GRDBrdDNUamsrNElaa2NER1gzRVBISlJZMjNRZnB1L0lFYUthaGR4?=
 =?utf-8?B?dldScTdUOVUyMnh5c3pQS2lyaHpwV3NhZDYrbU9XUUtIMzR4dUFIQXlnNjYy?=
 =?utf-8?B?NDBzRWF4R3FDYXg4cGgyb2xoSm9pNFc4blhBbnRMdXBqSHI4YjdMR09uU0lL?=
 =?utf-8?B?d2s1d0pKcmxQUXNsa1p2Y0UzakNiY1pGeDdYZlQ0ZFFVY1ZoSXZ4YmpmZ1c4?=
 =?utf-8?B?THdOK1AyRkVxT1dmZWpTRkFFd1lKenhrVHJPblJnNm9mb0hsclpMQTFZR2dT?=
 =?utf-8?B?dHRTT2haekZRNGhzWWZjRit4NkJLRDJONkxCUmJnRjY3VmFjMHdqRjVvcUdj?=
 =?utf-8?B?aG5odjN3UEpsSFZKa21lbEUrZXFIb3d0UUhWNnBaaGNvYys0bVpydVo0UzVy?=
 =?utf-8?B?aDlHYUlidjdCSm15TExxWk90b0t5WUZpQVRDSTB4Rlh1eTdRVlB3NGtuSjll?=
 =?utf-8?B?WHJ1dmM3SmdhZW8xRnNyT1NWb1ZCVXZIS3doSGo5dWxrQ1E4TjJHLzJrbGZ5?=
 =?utf-8?B?L1NRcm5QeVNtQnJ0SGZ1WnZ2MVJ5U3c1MHJ5bHAyTnpJMExWMjR4cHdheitI?=
 =?utf-8?B?MkJHckEwZmRxdVlSbExlSVJvRmttK1BjaW1EWXZacWh3ZTE3bTdXbEFzVW9i?=
 =?utf-8?B?SHFIYmYrclRzNW53U2JLNit6Y05WR2o3L2lDait6anQ5cW1RdzhLbXYwdVZw?=
 =?utf-8?B?OGFQMmZkbitWM2xMUExRdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sk9xR2wzVXVDYU0vUWdmM2t2ZzlOWXZFUDVKSlA4TDFTS1BPckZUWmFmd0JQ?=
 =?utf-8?B?UkVFNUdQYW44VzlJK3JGMXlRbWV2SUN5S3ptZ21aeTBwbm9kSERrWVRPVklz?=
 =?utf-8?B?MTVsY1VQZkFYdnU4UmNodTZwTGt6ak5jR2dWNVRhbXh4S2NWRC95VmZzL2hp?=
 =?utf-8?B?czAwNVlRN0F3dGFKN3g2dGt5cE1hclpUR1hhQUFROE5rVzEzM0E2emNobVB4?=
 =?utf-8?B?cVZ2b2hhSzVQakhXakRqWTMxc0hST1o4L0pjclRLODM0M0IreTNKeVZmQUhN?=
 =?utf-8?B?VWExMTBJak1yKzdmcFphM1B3cVdCeWVsTWE0bkRlL3RHQ3lFZm9qYTkyWmhH?=
 =?utf-8?B?Wk0yZVhCRFNJR29FYWJGN05aaXpUZ2Jxa2tscUswMDloVFR5cHFNZ3hkcDk1?=
 =?utf-8?B?d09oWEZ4Q21ndmRoZnZvTjJWcW0wU2M2YTdLcnRYTUhBQjVrejJXU0JTSzk0?=
 =?utf-8?B?NlhKMHlHVmNQNVF3NFhvZzRESnNPclkwTWs1VWNWQnhvdG5TVXJQOHhEcVht?=
 =?utf-8?B?Q2thdzdQK0YvTnp2aUJuYTRZdVJ2czNPTkIyWUtXc09MRTFybFZybGdSeFRX?=
 =?utf-8?B?MWROelh0T3o5MDl5OTZlNStKOHhCWFBEVXZjd0JqMGZ4MUxjenBxMXpTaG9X?=
 =?utf-8?B?K1dTVG51cU9Pb1lvemlXcjROekF5aWVDUlNYcWZlWDBnZHRlcTA1MTJBOEpV?=
 =?utf-8?B?Y3NBTzExTzdKY3Q2dW5vdW4ycEt0U3dZalpFY3k1V1JaeW5RM3I1elpDZm1S?=
 =?utf-8?B?UkNLU1ZheTV3NUxRK0M1ckNCcW1ZMlNGZXNSMFFlYThieXNVSnIxR0xGN1oz?=
 =?utf-8?B?VXVkUmIzWVBOVDFHRzZkeGp2R2JYZXRSVjNFUkViRWxtQlFwbXp1YU94K25R?=
 =?utf-8?B?YnBIdCtxYnk0MUhLeEo5OGxMTjRMQ3Fpck03dUhhajMvcnNpeVc2OVBSSjJu?=
 =?utf-8?B?cnFoMWFmdjBpYzlFSFludDZKdlI2Q3RxeU1tOVQ5V2xVVEpSTnRJYWpnQXR6?=
 =?utf-8?B?ZFNYc2NUeUd0ZTB4NEllK3lITnVuYnJnWEM4blU5alJ3OU1mOXVLdHlyem0v?=
 =?utf-8?B?SFJqbGpFdzFsRit3OU5lZzdNd0lkcXNBS0szQVVENlU2TEl4WkhqOVhLdlVS?=
 =?utf-8?B?ZFBDS0JiV0paSEN3ZkluZVl3bUtXNzY5OFlJaWpCZWxCekdWV3NqaU9FOThk?=
 =?utf-8?B?RWZrVnJrMCtUbkxTQm55ditIeUs1MFl1dEQwUFhHL3Y4VDNoczdaeHFCUGdr?=
 =?utf-8?B?RzJwVE95S2hmT3NIMHNxUTZOZDM4WjAxSXhXK0FFMFVyeE9hTFBlM0lSMm1h?=
 =?utf-8?B?QWwvTDI5akg5WkNFNXRZN3VPVUtmcmZnRFI2cnVpd01ld3ZaY1VxUm9reVlD?=
 =?utf-8?B?cWFONUl4ZW5MT3hPSi9KLzFQdmVSL1IrZyt4TVFMYXh5Qk9pWFFGemZ6ck1H?=
 =?utf-8?B?WWpGcGtmckpJamxGU0VHWFFSU1dWZWs2THRRTVducmhXRWNLekpDaVlGSUUw?=
 =?utf-8?B?enNVNFc4TlMrajUzTFR6eXh5K3Y1Wjh4QVBtY29MN2hKZWN6MmIrMHhRdUll?=
 =?utf-8?B?ZTFZMlFnOUNBYVNJTDIzTUx2SFlFanA1ZE9QUXJFM3V1emtuQ0RmNHlWNitU?=
 =?utf-8?B?dmpON2VZRDVEeTZZWnR6V3o5b0xiM3hYNFhMaUE5cnBpTENPWWlNQVpZY0xu?=
 =?utf-8?B?U2FEVEVkNVN3aEsvK0RwdUtyWXg5T3ZnY0dKaTBaM3d6Sm5tOWhZMnlMN212?=
 =?utf-8?B?M1dMZVI3cnRLcUF6R3lvSGUxRm1KZisyVHlVcm10VkpVa0l5L2ZDSG51K2kr?=
 =?utf-8?B?bzZWK1k0QmFCS0lmRzd3M1NxVUU3UTEwdWp6cWlwR0NQOUgzU1YyOFlVMndr?=
 =?utf-8?B?ZllCdXhpUll1RXo3YTR0L2lpK2k4OUI0ZmZhUEJ1Y21WOFhCSk5aajNvcC9D?=
 =?utf-8?B?NTBkZXdrSmJBZlVhQkZCVU81WU1waC9VKzB2USt2cXpkY2U3R2xxaXFoMFMv?=
 =?utf-8?B?TWxzbkxVODR2VWJXcHRhN0VSNHZoYmwwUExEWUlRa2JTNmFETCsza0Q1YUdZ?=
 =?utf-8?B?K01rMXdOaEVxUXEwM1FWNHFzVnhVc054T1VlMnBVeDRESVpKT3dISHprbWRk?=
 =?utf-8?Q?K8gQyysSjU0+8BnLZnwkFbdHW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a4c7fa-5e81-4ddb-c5e4-08dd18e275da
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 06:18:27.7068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpMajl1Wn3w4mJOMEk8okkOZDpUsCSCW1N7bj15caOLahvqYZibD7dLOOfgRhodz7DEl1BMExLlFAdArKpzPbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7711

On 6/12/24 09:23, Dan Williams wrote:
> Link encryption is a new PCIe capability defined by "PCIe 6.2 section
> 6.33 Integrity & Data Encryption (IDE)". While it is a standalone port
> and endpoint capability, it is also a building block for device security
> defined by "PCIe 6.2 section 11 TEE Device Interface Security Protocol
> (TDISP)". That protocol coordinates device security setup between the
> platform TSM (TEE Security Manager) and device DSM (Device Security
> Manager). While the platform TSM can allocate resources like stream-ids
> and manage keys, it still requires system software to manage the IDE
> capability register block.
> 
> Add register definitions and basic enumeration for a "selective-stream"
> IDE capability, a follow on change will select the new CONFIG_PCI_IDE
> symbol. Note that while the IDE specifications defines both a
> point-to-point "Link" stream and a root-port-to-endpoint "Selective"
> stream, only "Selective" is considered for now for platform TSM
> coordination.
> 
> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/pci/Kconfig           |    3 +
>   drivers/pci/Makefile          |    1
>   drivers/pci/ide.c             |   73 ++++++++++++++++++++++++++++++++++++
>   drivers/pci/pci.h             |    6 +++
>   drivers/pci/probe.c           |    1
>   include/linux/pci.h           |    5 ++
>   include/uapi/linux/pci_regs.h |   84 +++++++++++++++++++++++++++++++++++++++++
>   7 files changed, 172 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/pci/ide.c
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 2fbd379923fd..4e5236c456f5 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -121,6 +121,9 @@ config XEN_PCIDEV_FRONTEND
>   config PCI_ATS
>   	bool
>   
> +config PCI_IDE
> +	bool
> +
>   config PCI_DOE
>   	bool
>   
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 67647f1880fb..6612256fd37d 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
>   obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>   obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
>   obj-$(CONFIG_PCI_DOE)		+= doe.o
> +obj-$(CONFIG_PCI_IDE)		+= ide.o
>   obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
>   obj-$(CONFIG_PCI_NPEM)		+= npem.o
>   obj-$(CONFIG_PCIE_TPH)		+= tph.o
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> new file mode 100644
> index 000000000000..a0c09d9e0b75
> --- /dev/null
> +++ b/drivers/pci/ide.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> +
> +/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
> +
> +#define dev_fmt(fmt) "PCI/IDE: " fmt
> +#include <linux/pci.h>
> +#include "pci.h"
> +
> +static int sel_ide_offset(u16 cap, int stream_id, int nr_ide_mem)
> +{
> +	return cap + stream_id * PCI_IDE_SELECTIVE_BLOCK_SIZE(nr_ide_mem);
> +}
> +
> +void pci_ide_init(struct pci_dev *pdev)
> +{
> +	u16 ide_cap, sel_ide_cap;
> +	int nr_ide_mem = 0;
> +	u32 val = 0;
> +
> +	if (!pci_is_pcie(pdev))
> +		return;
> +
> +	ide_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_IDE);
> +	if (!ide_cap)
> +		return;
> +
> +	/*
> +	 * Check for selective stream capability from endpoint to root-port, and
> +	 * require consistent number of address association blocks
> +	 */
> +	pci_read_config_dword(pdev, ide_cap + PCI_IDE_CAP, &val);
> +	if ((val & PCI_IDE_CAP_SELECTIVE) == 0)
> +		return;
> +
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) {
> +		struct pci_dev *rp = pcie_find_root_port(pdev);
> +
> +		if (!rp->ide_cap)
> +			return;
> +	}
> +
> +	if (val & PCI_IDE_CAP_LINK)
> +		sel_ide_cap = ide_cap + PCI_IDE_LINK_STREAM +
> +			      (PCI_IDE_CAP_LINK_TC_NUM(val) + 1) *
> +				      PCI_IDE_LINK_BLOCK_SIZE;
> +	else
> +		sel_ide_cap = ide_cap + PCI_IDE_LINK_STREAM;
> +
> +	for (int i = 0; i < PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(val); i++) {
> +		if (i == 0) {
> +			pci_read_config_dword(pdev, sel_ide_cap, &val);
> +			nr_ide_mem = PCI_IDE_SEL_CAP_ASSOC_NUM(val);
> +		} else {
> +			int offset = sel_ide_offset(sel_ide_cap, i, nr_ide_mem);
> +
> +			pci_read_config_dword(pdev, offset, &val);
> +
> +			/*
> +			 * lets not entertain devices that do not have a
> +			 * constant number of address association blocks

But why? It is quite easy to support those. Yeah, won't be able to cache 
nr_ide_mem and will have to read more configspace but a specific 
selected stream offset can live in pci_ide from 8/11. Thanks,

> +			 */
> +			if (PCI_IDE_SEL_CAP_ASSOC_NUM(val) != nr_ide_mem) {
> +				pci_info(pdev, "Unsupported Selective Stream %d capability\n", i);
> +				return;
> +			}
> +		}
> +	}
> +
> +	pdev->ide_cap = ide_cap;
> +	pdev->sel_ide_cap = sel_ide_cap;
> +	pdev->nr_ide_mem = nr_ide_mem;
> +}
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2e40fc63ba31..0305f497b28a 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -452,6 +452,12 @@ static inline void pci_npem_create(struct pci_dev *dev) { }
>   static inline void pci_npem_remove(struct pci_dev *dev) { }
>   #endif
>   
> +#ifdef CONFIG_PCI_IDE
> +void pci_ide_init(struct pci_dev *dev);
> +#else
> +static inline void pci_ide_init(struct pci_dev *dev) { }
> +#endif
> +
>   /**
>    * pci_dev_set_io_state - Set the new error state if possible.
>    *
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2e81ab0f5a25..e22f515a8da9 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2517,6 +2517,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
>   	pci_rcec_init(dev);		/* Root Complex Event Collector */
>   	pci_doe_init(dev);		/* Data Object Exchange */
>   	pci_tph_init(dev);		/* TLP Processing Hints */
> +	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
>   
>   	pcie_report_downtraining(dev);
>   	pci_init_reset_methods(dev);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index db9b47ce3eef..50811b7655dd 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -530,6 +530,11 @@ struct pci_dev {
>   #endif
>   #ifdef CONFIG_PCI_NPEM
>   	struct npem	*npem;		/* Native PCIe Enclosure Management */
> +#endif
> +#ifdef CONFIG_PCI_IDE
> +	u16		ide_cap;	/* Link Integrity & Data Encryption */
> +	u16		sel_ide_cap;	/* - Selective Stream register block */
> +	int		nr_ide_mem;	/* - Address range limits for streams */
>   #endif
>   	u16		acs_cap;	/* ACS Capability offset */
>   	u8		supported_speeds; /* Supported Link Speeds Vector */
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 1601c7ed5fab..9635b27d2485 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -748,7 +748,8 @@
>   #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
>   #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
>   #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
> -#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
> +#define PCI_EXT_CAP_ID_IDE	0x30    /* Integrity and Data Encryption */
> +#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_IDE
>   
>   #define PCI_EXT_CAP_DSN_SIZEOF	12
>   #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
> @@ -1213,4 +1214,85 @@
>   #define PCI_DVSEC_CXL_PORT_CTL				0x0c
>   #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
>   
> +/* Integrity and Data Encryption Extended Capability */
> +#define PCI_IDE_CAP			0x4
> +#define  PCI_IDE_CAP_LINK		0x1  /* Link IDE Stream Supported */
> +#define  PCI_IDE_CAP_SELECTIVE		0x2  /* Selective IDE Streams Supported */
> +#define  PCI_IDE_CAP_FLOWTHROUGH	0x4  /* Flow-Through IDE Stream Supported */
> +#define  PCI_IDE_CAP_PARTIAL_HEADER_ENC 0x8  /* Partial Header Encryption Supported */
> +#define  PCI_IDE_CAP_AGGREGATION	0x10 /* Aggregation Supported */
> +#define  PCI_IDE_CAP_PCRC		0x20 /* PCRC Supported */
> +#define  PCI_IDE_CAP_IDE_KM		0x40 /* IDE_KM Protocol Supported */
> +#define  PCI_IDE_CAP_ALG(x)		(((x) >> 8) & 0x1f) /* Supported Algorithms */
> +#define  PCI_IDE_CAP_ALG_AES_GCM_256	0    /* AES-GCM 256 key size, 96b MAC */
> +#define  PCI_IDE_CAP_LINK_TC_NUM(x)	(((x) >> 13) & 0x7) /* Link IDE TCs */
> +#define  PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(x)	(((x) >> 16) & 0xff) /* Selective IDE Streams */
> +#define  PCI_IDE_CAP_SELECTIVE_STREAMS_MASK	0xff0000
> +#define  PCI_IDE_CAP_TEE_LIMITED	0x1000000 /* TEE-Limited Stream Supported */
> +#define PCI_IDE_CTL			0x8
> +#define  PCI_IDE_CTL_FLOWTHROUGH_IDE	0x4	/* Flow-Through IDE Stream Enabled */
> +#define PCI_IDE_LINK_STREAM		0xc
> +#define PCI_IDE_LINK_BLOCK_SIZE		8
> +/* Link IDE Stream block, up to PCI_IDE_CAP_LINK_TC_NUM */
> +/* Link IDE Stream Control Register */
> +#define  PCI_IDE_LINK_CTL_EN		 0x1	/* Link IDE Stream Enable */
> +#define  PCI_IDE_LINK_CTL_TX_AGGR_NPR(x) (((x) >> 2) & 0x3) /* Tx Aggregation Mode NPR */
> +#define  PCI_IDE_LINK_CTL_TX_AGGR_PR(x)	 (((x) >> 4) & 0x3) /* Tx Aggregation Mode PR */
> +#define  PCI_IDE_LINK_CTL_TX_AGGR_CPL(x) (((x) >> 6) & 0x3) /* Tx Aggregation Mode CPL */
> +#define  PCI_IDE_LINK_CTL_PCRC_EN	 0x100	/* PCRC Enable */
> +#define  PCI_IDE_LINK_CTL_PART_ENC(x)	 (((x) >> 10) & 0xf)  /* Partial Header Encryption Mode */
> +#define  PCI_IDE_LINK_CTL_ALG(x)	 (((x) >> 14) & 0x1f) /* Selected Algorithm */
> +#define  PCI_IDE_LINK_CTL_TC(x)		 (((x) >> 19) & 0x7)  /* Traffic Class */
> +#define  PCI_IDE_LINK_CTL_ID(x)		 (((x) >> 24) & 0xff) /* Stream ID */
> +#define  PCI_IDE_LINK_CTL_ID_MASK	 0xff000000
> +
> +
> +/* Link IDE Stream Status Register */
> +#define  PCI_IDE_LINK_STS_STATUS(x)	((x) & 0xf) /* Link IDE Stream State */
> +#define  PCI_IDE_LINK_STS_RECVD_INTEGRITY_CHECK	0x80000000 /* Received Integrity Check Fail Msg */
> +/* Selective IDE Stream block, up to PCI_IDE_CAP_SELECTIVE_STREAMS_NUM */
> +#define PCI_IDE_SELECTIVE_BLOCK_SIZE(x)  (20 + 12 * (x))
> +/* Selective IDE Stream Capability Register */
> +#define  PCI_IDE_SEL_CAP		 0
> +#define  PCI_IDE_SEL_CAP_ASSOC_NUM(x)	 ((x) & 0xf) /* Address Association Register Blocks Number */
> +#define  PCI_IDE_SEL_CAP_ASSOC_MASK	 0xf
> +/* Selective IDE Stream Control Register */
> +#define  PCI_IDE_SEL_CTL		 4
> +#define   PCI_IDE_SEL_CTL_EN		 0x1	/* Selective IDE Stream Enable */
> +#define   PCI_IDE_SEL_CTL_TX_AGGR_NPR(x) (((x) >> 2) & 0x3) /* Tx Aggregation Mode NPR */
> +#define   PCI_IDE_SEL_CTL_TX_AGGR_PR(x)	 (((x) >> 4) & 0x3) /* Tx Aggregation Mode PR */
> +#define   PCI_IDE_SEL_CTL_TX_AGGR_CPL(x) (((x) >> 6) & 0x3) /* Tx Aggregation Mode CPL */
> +#define   PCI_IDE_SEL_CTL_PCRC_EN	 0x100	/* PCRC Enable */
> +#define   PCI_IDE_SEL_CTL_CFG_EN	 0x200	/* Selective IDE for Configuration Requests */
> +#define   PCI_IDE_SEL_CTL_PART_ENC(x)	 (((x) >> 10) & 0xf)  /* Partial Header Encryption Mode */
> +#define   PCI_IDE_SEL_CTL_ALG(x)	 (((x) >> 14) & 0x1f) /* Selected Algorithm */
> +#define   PCI_IDE_SEL_CTL_TC(x)		 (((x) >> 19) & 0x7)  /* Traffic Class */
> +#define   PCI_IDE_SEL_CTL_DEFAULT	 0x400000 /* Default Stream */
> +#define   PCI_IDE_SEL_CTL_TEE_LIMITED	 (1 << 23) /* TEE-Limited Stream */
> +#define   PCI_IDE_SEL_CTL_ID_MASK	 0xff000000
> +#define   PCI_IDE_SEL_CTL_ID_MAX	 255
> +/* Selective IDE Stream Status Register */
> +#define  PCI_IDE_SEL_STS		 8
> +#define   PCI_IDE_SEL_STS_STATUS(x)	((x) & 0xf) /* Selective IDE Stream State */
> +#define   PCI_IDE_SEL_STS_RECVD_INTEGRITY_CHECK	0x80000000 /* Received Integrity Check Fail Msg */
> +/* IDE RID Association Register 1 */
> +#define  PCI_IDE_SEL_RID_1		 12
> +#define   PCI_IDE_SEL_RID_1_LIMIT_MASK	 0xffff00
> +/* IDE RID Association Register 2 */
> +#define  PCI_IDE_SEL_RID_2		 16
> +#define   PCI_IDE_SEL_RID_2_VALID	 0x1
> +#define   PCI_IDE_SEL_RID_2_BASE_MASK	 0x00ffff00
> +#define   PCI_IDE_SEL_RID_2_SEG_MASK	 0xff000000
> +/* Selective IDE Address Association Register Block, up to PCI_IDE_SEL_CAP_ASSOC_NUM */
> +#define  PCI_IDE_SEL_ADDR_1(x)		     (20 + (x) * 12)
> +#define   PCI_IDE_SEL_ADDR_1_VALID	     0x1
> +#define   PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK   0x000fff0
> +#define   PCI_IDE_SEL_ADDR_1_BASE_LOW_SHIFT  20
> +#define   PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK  0xfff0000
> +#define   PCI_IDE_SEL_ADDR_1_LIMIT_LOW_SHIFT 20
> +/* IDE Address Association Register 2 is "Memory Limit Upper" */
> +/* IDE Address Association Register 3 is "Memory Base Upper" */
> +#define  PCI_IDE_SEL_ADDR_2(x)		(24 + (x) * 12)
> +#define  PCI_IDE_SEL_ADDR_3(x)		(28 + (x) * 12)
> +
>   #endif /* LINUX_PCI_REGS_H */
> 

-- 
Alexey


