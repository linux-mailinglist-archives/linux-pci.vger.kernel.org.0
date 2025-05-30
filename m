Return-Path: <linux-pci+bounces-28692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 136E6AC86CD
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 05:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A433A3FC8
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 03:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A48143736;
	Fri, 30 May 2025 03:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jzUbTHu2"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430841E521
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 03:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748574053; cv=fail; b=gVMhQuG6xdsxcEmOUU7PXlslvdtapcBNNDvmeDY0NSV3zCaQGdlcf7Hjb/bBbBKMV+fw86v6fKbbdbv8jESSxIK5ulwK413pF54sWfc/hxmscqaL1uP+aK1yjgqPV2YMtOTgglB4lgkqTmT1gpLsu6tnkxSHmtnrJ21P0tQjciA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748574053; c=relaxed/simple;
	bh=sapPOg1v3w+xlNo3G1qmwOR/GdAkB78lIuvQp0iNQOU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oYDK/bq7BoMVve8N3BCx5CMGnFm0XbMElLI29tFYKgTjt5CC5lO/BmYbaaBsjwZk19a/XD09CgsrxkgkWfBe6UhoVklo2/d9rOaolmABRJaa3lvGwbZJh+QI6saIS/F2aTnV4ViGYtz4QpnucG/l+r+znL6kEw3D5P6B7DCgjy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jzUbTHu2; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lgtkrnyfdgao56MiaS3piYkkwDimLsVG3vYNxkhaDiBlZkQPsVeruqxGhrmkVjSrAyVa8W6IzJKmP+otOibGJFF61xVYKfNYaYt1MVk4Gtp9MDg7IO5GJ/6zCkIGAuHW/W2OlEhCiraEjDxePJI3RvewLOqfBx/U5jkUaz2EwluKKjmIb9Qe7aBs+VKa/T/V2h8hTA1Q8gzOaHabBJnq6v8acjVsZA1PkuKI+sYHGT//x6Jl/HUXdGdhPdhxWawAPd23p+Uh2y1rhLO4wIenNrdGkvybQhOV+d4skgmmSxbFzMz6jtgBIF3ylIJeSrBujRXUMQjL40/ZHLfn444Z4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDOORxgM2QKix4HFTVpMkauUIMAvyA6r32xZehMnhZI=;
 b=Bevs+oePG+2niewbHhIKJwGqGpFuL/JoI94kj5a4Y13MPLOz1D0+4v5GE7tNlTkwjPXQnqpiENs6DRdZ7Agxd57Dh3XM3pqOmyIO+Kwyme7ZJpc5apmyhKXpCjvEPVMXEkhjnHp+oaHvu3Z5ITLQn3YRpGho16HNXYBDLg+/qQx3SC3HdA7EVkiJOisDmwPDO2dY+qTTUqUMhbLhkSZExxq2Mh8gR5ImoY1nLIMQRTsUNKTVVg8eiAj1xpnXES9NJ75y+RNvRaI7Q+kQeL+Zo2uZz4pj3mUtfi14wf4kbAjwQvlTwB0JzWs+oC9YHJx4eCC6Dsc6gZvQ3ebbGAPmoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDOORxgM2QKix4HFTVpMkauUIMAvyA6r32xZehMnhZI=;
 b=jzUbTHu2lMTHKko5RFZ8IiuSubDJR8fdqy+G7thsq8zWfrpDUFaARgVwyzOeabfpgsh1CZhVWJMZ1TgRaGT3l2Bhz0iYrsbkX0V5BE8QSzeUATeUFqC4ESOjU/WAbgSXD+cc5SYb+aLmsS7KIcAF27vKv6JAuUvl4xZjYapPaeY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH7PR12MB6609.namprd12.prod.outlook.com (2603:10b6:510:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Fri, 30 May
 2025 03:00:49 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8769.022; Fri, 30 May 2025
 03:00:48 +0000
Message-ID: <d7f14f9f-9ee0-428e-8602-1a11695690b6@amd.com>
Date: Fri, 30 May 2025 13:00:41 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for host
 TSM driver
To: Jason Gunthorpe <jgg@nvidia.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Xu Yilun <yilun.xu@linux.intel.com>, Dan Williams
 <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org, lukas@wunner.de,
 suzuki.poulose@arm.com, sameo@rivosinc.com, zhiw@nvidia.com
References: <yq5ah617s7fs.fsf@kernel.org>
 <cfdfd053-9e9d-43c0-8301-5411a02ffdf9@amd.com> <yq5abjres2a6.fsf@kernel.org>
 <20250527130610.GN61950@nvidia.com> <yq5a8qmiruym.fsf@kernel.org>
 <20250527144516.GO61950@nvidia.com> <yq5a8qmh53qo.fsf@kernel.org>
 <20250528164225.GS61950@nvidia.com> <20250528165222.GT61950@nvidia.com>
 <yq5a1ps75y79.fsf@kernel.org> <20250529140914.GD192531@nvidia.com>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20250529140914.GD192531@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:610:76::29) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH7PR12MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f2e170-f3db-4a73-9bc6-08dd9f262e00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFo2cVl2YWNOUGNCZ1JpL05vNnFnZTFMd3IwZnFmMHRrTmNlNUttcmRaZ0ZO?=
 =?utf-8?B?R3BXNVpOVVNRRWN6UmlwTmFyTnlkUUlHbHJuU1JrYnI2V0FJUU1nL1RKcmU1?=
 =?utf-8?B?aU1JTEpTQWlnQUNhamRNaE0wMmFZaWNFQXV5cWxsOHVpMUNFNjBzQmVxT212?=
 =?utf-8?B?aitxTVE2dVIxa0RXRXRHNjFMTHFZS2U0amdRTEx2dGdYTmlXUDlBaEhTaXpy?=
 =?utf-8?B?WjN6cnpuOGJZbnlCR0JNTlFhSjN3RGg4WGV3TEVsaEplcnUvSmtoS1JiUkxa?=
 =?utf-8?B?clZxZGJ4NEtmall5aXBLSUo0Z1BEb284U0pSdXlCeDdKQnJEY011ZlpacjA0?=
 =?utf-8?B?TkRMWXoyV1VSY2ZNZms5Z1FmYzc1TnViTlp4WnJhNEJtdENyWnJxaFl3S3dO?=
 =?utf-8?B?YnhHclhyWDl1c1dWeGpabk9KMHZUQVJFMC9ZS2pHYTVmMG1DUmVqWkJxeWlm?=
 =?utf-8?B?SEJsaThUcmdpbm1jYjRZdkZSMW1XS2E2QTZmcHd2WTFHditPbXJiT1FycnNL?=
 =?utf-8?B?empIbVg4QU9yZGJ6RFo0WDgyM0xwdjF6bHVyb2k5VE1xZHB0cVg4bXlQbmhB?=
 =?utf-8?B?RVpkaVhGMWJhekxxUEFETjNUSFVtYjEvaFNNL2R1akJzWS9LSElxQ2hJd0hm?=
 =?utf-8?B?ZytxZTd6MDJiZ2ZYSlg4dXBTZ0FDakJ5QzJtVnlyTXY4ckhBNXFteVdSeVd4?=
 =?utf-8?B?SkhjSFA3dzNQbU5XQkhPQkl0MHZsOTRDWFVWaDEzSkxnTmllVld1K1VycmFX?=
 =?utf-8?B?Qm5EQ2hZaHBPMldGdllBdURDdDZGQVFKbHE5UGVhTUh1VXBJRzB1ZzB1NFVo?=
 =?utf-8?B?NlIxeVJtSjgybkRiNzRTaDhkTU1ZNXN6Z05OanBkM1RGRXQvOVFWQ3ZJdFZy?=
 =?utf-8?B?ZFlRQno3Nm5IdkxscXlqaGQreVRKcXFxemVkSWZSZVgzZm81MEdvc0tKV0dD?=
 =?utf-8?B?bDU1Wk5rUzhQdC9jS2dpOE4rTjd2ekNLMTJHWVkydFFpejAycGJ0V2p3aCs3?=
 =?utf-8?B?VzAzWGdHUzRUN0NLa0VWTm5MdENHM0xBNzBZdk9PWG1US1ZlYXFJNUVwMmpp?=
 =?utf-8?B?cGhKMFp1TFpzcHRGVnhmcTBqcWRNTkdaSm9NSXc2aS9hTG9WaDJMMTJtNXg0?=
 =?utf-8?B?aVNDOHAzR3oxMDNjSDVCaldHZnZjZVFUWmxEN3RGL0J1eTVTSkJvTWplVXVa?=
 =?utf-8?B?N1c4a3AzWFlZdGR5enN3UVdBaDc5YnJzajVnNysvdVBQYnplYmUvVHFqZlor?=
 =?utf-8?B?bXB0UGFWK0oxSWhmT0c5YXpOV3lWZEZJOUp2NnluM2F1NzUxbmZxSWoyTVQ4?=
 =?utf-8?B?VWllMWFKNDMyOVBEek5CTkE1VkhtNGZCUUtFbWY1dzl2MHQ2NXE4dFhmY0tp?=
 =?utf-8?B?TGZScGlQSzBnUWNrWXlROXgybU9pOWFFSXFVYnhEYVI1OVRFRW5HcFlsWlhF?=
 =?utf-8?B?QVFwdm1qSHdCYU9VbXhWRG5CYXZybUl6SnZrV0dlZmdZNEVoUkV2VnhUajNZ?=
 =?utf-8?B?S1VlUnR3UzVQeVhvQ1ZGWmlucVRxRmh5ZHArSjVXaEdOdnZ3WXJDdmdnbDlt?=
 =?utf-8?B?U2FRSU1hYVhUL3pWZVNQcmFobm11QTBsempNQnBEajJLNHVLaklRTjh2Mm1F?=
 =?utf-8?B?ckNVU2dBTFplb1pCbXVDZHZNTDEwczBhVUVwMzRTOS9GMTN0Ykxyb1J6RDc0?=
 =?utf-8?B?UVNjNWw2L29CZ21oSWVaN2N6WHZwNU5Ua1pMdXNrRVpnSHV0NWZEZER5MzJv?=
 =?utf-8?B?bHJ1Y3hLeDViTjFraU9sZEdNNHdBM3lWaU1DVnpIb1JnVlNId2VqR3JGdktm?=
 =?utf-8?B?dWsreW0zY282QVJOZHdzY1VsTkptM3lXVGhiRm1HNStUbTFMOXNIQ3d4dURs?=
 =?utf-8?B?S2NLbzdzNDdWSG1wRFVNSk5CY1puWStJM20vaEMzSWxmV3h6Z0pSWXBIb1FC?=
 =?utf-8?Q?QS9NMCKRkiI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUNMd2d1cXM1ZDdLUTdvbmhIOWo5ZEFJMjZPU0xmY1dnMXhpZGVHNzB3dkxj?=
 =?utf-8?B?VlZlaWEwdkgwZUZ4TnZBcXhHbnoxQkFWMXNYS1dGazVBSk1teHArUDVFWTZj?=
 =?utf-8?B?VHZHZ0RaeURDUW1qMWg5Q0ViemVlYnhEZHlMWGxUN2ZYT1ZpaFBnTEhoSk9G?=
 =?utf-8?B?ZHNWUVRTanFOSFRnVVh6Y2JVMjBoR3E1T0QvRDZBN2RiMEQ1RnRsMmRzWjVl?=
 =?utf-8?B?Y0NPYkFtdmx4SG93ZEd5a3B6eGgzWU5iWEpoc1oxZ3hxM2lYSHlnVHc2SE1O?=
 =?utf-8?B?UFEzb3A1V1NEZGoxUXhpOHpUSHpTVXRDSkVadU1rTDdiYTJWemJkY1ZuT2U0?=
 =?utf-8?B?UUFEdjBPTXVHVWx4Sy82QlVwaUFYQ0ZHdDloTmZ0aG5jOUZrcnFia2N2VDRE?=
 =?utf-8?B?T3ViUnhmYldBQXV3Z0VRRFE2Q3dVZThPazB5dnRrL1BaMW9GMzVnLzBZdHBO?=
 =?utf-8?B?ZGRoRENCak1kOGthbjZhVzZ5MlErME9Ua29qOXV4WnNFRGxFYkFSM002ZnJS?=
 =?utf-8?B?bnNLZzF4NW1KZHFmR2paK1hTMlFOUGM5YkJVWHY1YllBWDBYYllWSEgwcG53?=
 =?utf-8?B?cGw0TUdhYmdVTjJUWXRnQmlIOWQ1OU90NVpRMWc4Wk0wSEgxRm5iVnltUFRL?=
 =?utf-8?B?SHB3Z3VMOHp6TGdXR2JXSkdMVUJIYjhpRzZnVFVYWU82S3BnSnkrN1IzZjAw?=
 =?utf-8?B?cGdBcG4zSm0vaWEyRUUvWlUrenJpVU9HMzRLcHJSc1RHbVNrMlIralRRbUF5?=
 =?utf-8?B?cDBTUGErTWE2bXE3LzA4Mk1rMzcrSFJpODRXWWtRSjVCZURyTDV0L3kxWmxU?=
 =?utf-8?B?dnpXd1o1d0JsbndOSm5CeVJUeUQ3VW9zR29MZ3VIVnBXL0poRHZCc0s1bmxp?=
 =?utf-8?B?clR6QVV0NWdSNjhGQXQrdnF6L1pjcjBVVStRVzlwcEliLzF6ZDdEZjdXSExP?=
 =?utf-8?B?TC9hRHFnQWZSWGRvc2NGb0VvNnY1dTFiTGhWblNDb21RKy80cW8wNVJqejdE?=
 =?utf-8?B?V0tFSE5aeko4cWFDYmxYbFB0Y3dJcitCMUlvTUhlMG1pUkFaRlFkdGkwVllw?=
 =?utf-8?B?clRFcVo0NE84VHFPV0IwSUgweUZLRUtISDFibnFkb3hmb282NEZhcjA2QU5E?=
 =?utf-8?B?WjlvNUJLSE9tSS9NQzBOZkFxTFJkb2pTSWt1dW9KYTAyZEcyOUNtamxLcFll?=
 =?utf-8?B?ZVkrZVE0T3VtYWJSZUlpNW9HTm1zdDhWeExqRURVZFZOZnJqZTVDK3dQTFUv?=
 =?utf-8?B?WHlMMytHcXdFMU84aFFwMGlhVHVYdkRjVndUbkp2UlEyTThmQkcvVDdiKzdS?=
 =?utf-8?B?UWhKSzJuOHVaWWIzMEJrdTIzZlQwcGVsM2dRUExEKzZMNGoxSC9BMldrUnJ0?=
 =?utf-8?B?VERqd0RvbUZLSlQrUjNLcTlGQXdLdG01QkJxbFJMcGMvc0pPUnhKYTloS3R1?=
 =?utf-8?B?bi9tSUlzWnFkY2hwZUtmQW1Mclh5bkdYVnZ1a3pXWW12UXRDU1N2Rk9Eb2Rk?=
 =?utf-8?B?enRDeGF4VmJDT1NDbjk4MmRnY1lZRFVoVXk2MUovRU9JSEVvQVJHWmJHNWJj?=
 =?utf-8?B?dFBPTzZIOEx2Z1UxYWFQM1BOZ2swVHZaWlJNcWdyUkRBYzA1OHcrM0xYREZO?=
 =?utf-8?B?ek1tcGdKVFhkUVliNzFVbDM2L2pzNnIyeXJ2enRPR0RSdmFrYmhoMHRPZzZ3?=
 =?utf-8?B?SFlHaDNyUmdZUnRnZk5wM2RzTXVkZTJtSUtCSWQyWE1COFl2R2pVRHF1MjQ1?=
 =?utf-8?B?SndzdytKL3pCL2R1eGZjb3MzUzUwVWhndUt0Y2I3cDBFeUJZQm1BQWFNTzhy?=
 =?utf-8?B?S3hEeDM0Y1BCbEx5ZElmMTNsSUhZYzlZVHZPTHA5dmRpUGtsRXZSbjlJbFI4?=
 =?utf-8?B?clEwcTloTVdFUVRHSDkzaGVReGgrTzNUeElablpVZkxnNGkybldtcGZON01p?=
 =?utf-8?B?TWRHRFBLekFFM2RBVTR2N1I1eVJmdlllMDkrNDhEOVNWZ1hsSWFROTl0eVdY?=
 =?utf-8?B?c3RKdGJ5NlRFSktXOWNKNnZyVmlibjRsSWtTMHVQZVhZUjNyc2s2SzhVZXNk?=
 =?utf-8?B?TjRsVmtuVzlaZTNKOHEwT3UrNjc5aGVMZHVSWEtMUnRlUFFBQTZud3FhUDQv?=
 =?utf-8?Q?9NBnNijvnC72GvqgmSOqkaeZ9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f2e170-f3db-4a73-9bc6-08dd9f262e00
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 03:00:48.7572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UkSwB/LulKZ6CcSQxmJ8tefanEFhMYpdF3629nZTLo3YQqJsNoU18vSkrDdWqtYDn2W3qp5v5lskRPdq2p/O6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6609



On 30/5/25 00:09, Jason Gunthorpe wrote:
> On Thu, May 29, 2025 at 07:13:54PM +0530, Aneesh Kumar K.V wrote:
>> Jason Gunthorpe <jgg@nvidia.com> writes:
>>
>>> On Wed, May 28, 2025 at 01:42:25PM -0300, Jason Gunthorpe wrote:
>>>>> +int iommufd_vdevice_tsm_bind_ioctl(struct iommufd_ucmd *ucmd)
>>>>> +{
>>>>> +	struct iommu_vdevice_id *cmd = ucmd->cmd;
>>>>> +	struct iommufd_vdevice *vdev;
>>>>> +	int rc = 0;
>>>>> +
>>>>> +	vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
>>>>> +					       IOMMUFD_OBJ_VDEVICE),
>>>>> +			    struct iommufd_vdevice, obj);
>>>>> +	if (IS_ERR(vdev))
>>>>> +		return PTR_ERR(vdev);
>>>>> +
>>>>> +	rc = tsm_bind(vdev->dev, vdev->viommu->kvm, vdev->id);
>>>>
>>>> Yeah, that makes alot of sense now, you are passing in the KVM for the
>>>> VIOMMU and both the vBDF and pBDF to the TSM layer, that should be
>>>> enough for it to figure out what to do. The only other data would be
>>>> the TSM's VIOMMU handle..
>>>
>>> Actually it should also check that the viommu type is compatible with
>>> the TSM, somehow.
>>>
>>> The way I imagine this working is userspace would create a
>>> IOMMU_VIOMMU_TYPE_TSM_VTD (for example) viommu object which will do a
>>> TSM call to setup the secure vIOMMU
>>>
>>> Then when you create a VDEVICE against the IOMMU_VIOMMU_TYPE_TSM_VTD
>>> it will do a TSM call to create the secure vPCI function attached to
>>> the vIOMMU and register the vBDF. [1]
>>>
>>
>> Don’t we create the vdevice before the guest starts?
> 
> Yes, vdevice/vPCI creation is before the guest start.

sorry but I still need clarification :)

vPCI == passed through PCI function (ethernet nic, etc), visible in guest's "lspci"

vdevice == slice (say, AMD's DTE/sDTE) of viommu device (say, AMD vIOMMU PCI device) to handle a specific vPCI


is that right?

> 
>> If I understand correctly, we expect tsm_bind to be triggered by the
>> guest’s request—specifically, when it writes to
>> /sys/bus/pci/devices/X/tsm/connect.
> 
> Yes, vdevice creation does not set the device to T=1.
> 
> If the device is T=1/0 mode is a dynamic choice controlled by the
> guest.
> 
> vPCI device creation is controlled by the hypervisor and is done
> before starting the VM.

I am asking (again) because with PCIe hotplug it is not done before starting the VM. Thanks,

> It just informs the TSM that a vPCI function
> exists, should the TSM need to know that, which it usually will if
> a secure vIOMMU is involved.
> 
> Jason

-- 
Alexey


