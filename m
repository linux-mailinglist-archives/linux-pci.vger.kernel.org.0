Return-Path: <linux-pci+bounces-20936-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 133DBA2CC4D
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 20:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790651885A59
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 19:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1810D33E7;
	Fri,  7 Feb 2025 19:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YwSYasXp"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1E023C8B4;
	Fri,  7 Feb 2025 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738955327; cv=fail; b=RPLTJa3tx+S3Q4N/ud66vaqsQWhrnQQ1MHLy4+WvIv54vAkYc3KArfvj4MGf9Mb4sk58UnN3r7VH1vvZHqzYYuJIG8CLbZUH7VkfN7bfFToriSwR7kXrZeL7BAMWjOhXyiJsu7bvTs4A6EEomQmrJUq03mblHZ3r66NUCcpDGKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738955327; c=relaxed/simple;
	bh=5q8ZYCzHPFEPE8E7ff1VTfm6WYRM8I87UE/xsmH/h/0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZBFEXu0MOydltNBO/UEFBkvRRTYujshpl0BhNpsq1KUf3Ij0oXxS87EesMyj20Xtlw/KpIYLhMDP3fERBCZHTDBmSCIQdLdxiwmSDyPStXRgeINydxA1jYFXMzPGxrDoXThZSYEkGpBD7qMjFM0wwdjZO55p9NgoPvuCD4JBxY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YwSYasXp; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8N6LNjDs6pNK1W/kSmIqosvzvxZpCEShdyj4imw+99tS7tqUhh76MUzfWKvmCDeITwbBKwZB/tXFsEoUkhfbJMWHS0VrUaBAoDcG/L6rjhMCcMlt1TkVuJYDJzH5RF+w7oUsV/Q8DVfxOQm+yNpfg4lPO1FJWYPvMQvMJ3/F7oL2ChTfDOlpFRkFvBYaS4q3AEka+RNPpFFLqN0HELiGWq8tkoZbir2W+AlGNAMDgsC7SgLMbzXFwVlapCzrJmFdaYo7QwMx3fZ9bt6bHsnH4WXc54NdZ9w6HU73k7134MSgvUfozxnDuRhx6Oxp3U2/9nizGymZUtybqgLlAlUzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2W5npEX9WXvbkaoJopPbgR0TRlPqDB6n1n27xXJ84c=;
 b=O3OuPjwuvksMHDuKYkS1Lpt37VthN5swu8PUd90gMWcco9R1u61Q8PpHooXNQ/+SPEMTzRv088a8FPHhukP6orfStviFiMIWcjCNmWOlj5WWmdOhKpxCLpaHJkzRNHkF0aEbjNwLnbr+fhRzlfLtjvlX/PndSVOQ9VLG1XC47fLTSoG3O3Wxp56T1egPhHpTk/koMNXpQJJLXr2IEtz3rhvzPPbUM/TstATc83McCkg4/7GUpyfhI/SVuFuLl0BgPcvIYHul7BOQyTT+3VCAba7kOY9GAspH+HSiFnl5hknW4C7Sf191HquWcaIG51zGxEzh7f2/BEZvLzmyB6dtLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2W5npEX9WXvbkaoJopPbgR0TRlPqDB6n1n27xXJ84c=;
 b=YwSYasXpvEpGn/ulcZFMv9lbEm9xpyTa/05YPBJL5Ka0ONVAj1IHhT+RAwthllzCluImc7ovDxRf8J9JO7tG20KytFit1i3LmD3B1Pi8aJqg2gDjxHIYAoVRTbUgXcyfah2X74+vpfAMYm4kH53jc9x9RYgQIV1fXROJHNkmtdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DS7PR12MB6334.namprd12.prod.outlook.com (2603:10b6:8:95::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.14; Fri, 7 Feb 2025 19:08:39 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 19:08:39 +0000
Message-ID: <6749f386-4bd0-4395-9ad4-a9663fac9bc1@amd.com>
Date: Fri, 7 Feb 2025 13:08:35 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/16] cxl/pci: Map CXL PCIe Root Port and Downstream
 Switch Port RAS registers
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com, alucerop@amd.com
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-9-terry.bowman@amd.com>
 <Z6W2hFI7UsEslB3U@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <Z6W2hFI7UsEslB3U@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:806:21::30) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DS7PR12MB6334:EE_
X-MS-Office365-Filtering-Correlation-Id: 012be20b-37b7-4855-f06a-08dd47aad495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTJGbDNTMlY3R21OL0l5Y1d5bDhSUE9pOW9naU5LbVVpUVdoRXJtbUxwZDhl?=
 =?utf-8?B?UWhWamlMMHpJMUc4clIzWnVtTW9CZmFhcGk4U3gzWXZUdnZ6dC9ISG1OMkd2?=
 =?utf-8?B?c09uc3dCOTFWT0FIQy80MXhmdDM0bnhaYnJ3K2VjQmZKMWRFQTRicURUSFFR?=
 =?utf-8?B?NDRQalFCTWJiQ0FVd2pNOERaakdHbXp0RVUzUVppSmtPS2RidGpPdm1iTVZH?=
 =?utf-8?B?Um5sOXFkOVlLRGVxR0YwMStSOUtSOC8wS1RWTFRhSDBDUDJrajFZMGQ2L2Rn?=
 =?utf-8?B?MytBOFRHQTdHZUJyeGgxRHRZT3luUVVhUTN5NVMvTDRYQTNNVFBEMytmc2Z0?=
 =?utf-8?B?eVptSTY4MDJoZm42WTBiM2pKb0NHR3dEVFdCbDljV0xPejdtWUJ4TmZUeHJi?=
 =?utf-8?B?U2ZjSWlIQkdPS3drVlJiNzdXQnZ0dlBjUHQwcnEzVHJxWElmU2NzVGxHUmJt?=
 =?utf-8?B?M3AyWmcwR0VPbDZVSmM3MzNldVFydE9DWnlQdGNTK2dJOWxYWmJZaWMvYlJK?=
 =?utf-8?B?NFdCYjBQakg4MjJVbVEwTVQ5WWxZOU9NN2ZRV0QrbGFyUzVGV1N1UFd4TkRK?=
 =?utf-8?B?Z0dIRUhCZENwbFc0SzFjTDZLSHhFb3dPQ1lQcHpKTWpTTTRzVm81S3p4NmFV?=
 =?utf-8?B?UEgvN0ZTRWMzbHVKT0NBOWxDcWlib3RRY2NXOUR1MkJZd21HbXZET2oxZXhC?=
 =?utf-8?B?RUVBamNDZGVudmV3ak5UQ0ZhL0NERkhOWXQyUzdYZjBqZWZmRzBKaWs2NTd5?=
 =?utf-8?B?Q2oyazc0RG1YbVZJdjJ1S29VUXFyMEJsblBvY3hQV0prUDlQNUxsbUs3eXhk?=
 =?utf-8?B?c0pDbnF1Q0hwVFo4ZmJqZldVZERSekFFM2tCZThQVzgzeW1YTEhITTIxbVpl?=
 =?utf-8?B?SVlGNFhLTzgxZzRML254Zk1zWmdmdkJrbkVuMlVuNGtyVzZpMlR4MnBqZ1JJ?=
 =?utf-8?B?Y0FqK2pGckhrTUlXdjlYV2Rad1IzZGkwVmdzQmVGV29UR0FySjRNSE5XV3gv?=
 =?utf-8?B?VWtmSlFYd1B1ZWpEb21nTnp0SjlMNUJ2Q011WnpsQzBzT0tSOGkveEZLTmQy?=
 =?utf-8?B?Rkh0bFAzdHcvMGFyVjRGbVg2TWpmQ2lXamhZeFZPMm0yNzhsTkVzaEx3cWF6?=
 =?utf-8?B?SDhBZ04xL0J4MzdCUnozb0l3MHZQZVRqTzRubU1xQzROQlNRbnJKajVicFZ6?=
 =?utf-8?B?RkpsTHhWMFlJSjBEZkxFUUNtZ3QrR2h2QTZTREZzYUw4TEhVcjltMWdJNCth?=
 =?utf-8?B?MCtKaXE4ckJlbk9wbk52NWpjRENtN1o4em5FNjJ0NUtmL0FkcWVYZmFGZCsx?=
 =?utf-8?B?MExqbGIxMjZTcjJHbGNGdXJQS0trZ3lpZ2ZQd2ZLR0dDcVNtV3A2QzV1Y0NF?=
 =?utf-8?B?UVBseE9pNkZ4Zjc2YlAyWHpjVitaTlEvdmlMM3JlM2thQXpNZXpFNzRjL29M?=
 =?utf-8?B?L1pIcmRVcEtPbC8yL25WY3hzNnpZMEhUMXNoWUQzT3pVZitjZy9DTDZoQVNz?=
 =?utf-8?B?eTQ4Y1pkbTE3V0dQVFJKVm1KWlp0WmUrTm5ib0I5U2h5ZVVzVjdocTV1YmZy?=
 =?utf-8?B?VnRidThjZjg1L2RlQkRqakRDeGxiUWp3QzZYQ3grZnpOU1BaRmFNamxXWnkw?=
 =?utf-8?B?NzdvYTBRNzNUM2h5QS8vZGhSNHNCWEZ4c1paS0UzeGs1WVIxWXE5MTJ2TGs0?=
 =?utf-8?B?OUM4Mk5QN0dNdVdsaXdWeU5LSnl3cmJ5UkR6WG9GWXhTZk1vK3phTE9seVhn?=
 =?utf-8?B?ZFpNYjFacFJ4aXdkYmJYVFhJRGxSZ2ppY1FnaXdVK3NHbXlmMXpUcDJZSHJT?=
 =?utf-8?B?YVhoM05rMzNQTm9WaVNYWlVSSzZ2TCtZWWJhekwrbTZqNmw0K3U1NVlmYk5H?=
 =?utf-8?Q?ygxY7at7gjz8H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXdIQVdpcUNOUDVHRmU5ZkVyRnJ6aEVWVmtXWnRsMTNGeU5hM2JlMzBtQm5t?=
 =?utf-8?B?YnRONWZEdm1jUk1SMTA1U2JYRWdGclJUMUlHVDUvNENadmhhOE1iVkV3VzFI?=
 =?utf-8?B?SW96ZjFJemsvS2h5Y2J0Tm5ZQXJTN2QwZWdxaWExUmdBNDI2MDd5bkVWb0k3?=
 =?utf-8?B?VVVia2lscW9TWkFGTi9YN0c0bDdkZ0Q3dE5xZnh2VEhybmorY0tKQUV0ZXU5?=
 =?utf-8?B?c3BSVjNvVXloalFIbzJWUE12Y01jNFE0ZEZpNm8vMk5QbHFaekdhMFkyeVFr?=
 =?utf-8?B?b0hkWmoyZllDOVoraDRkZnpSNk8rVGIwelV0bFJYc2tXMmorVmkwYU8yODhr?=
 =?utf-8?B?bllrVStoOWtQMXdxenQ3NlMzNFZ1RlhxZ2MrZUZXVUpRL3RzaTROTURWTDNu?=
 =?utf-8?B?MjVTQUJZSjRLSEhOVTgyTmxsNDM4eWorUUVnMEpNQ1hOaU5PNHp3ZUxBTXpr?=
 =?utf-8?B?L1VFTmZWOUFzUnlzSGJOaTZranJHSWcyZC9CdlE3eE9zU0tjTFNQcGFUOVZZ?=
 =?utf-8?B?L3M2ZE1sWjNjWXMxalRISVVrQVlvOGI1d0ZmS1NSSm5VWGQ5Sk5VMlg4azRD?=
 =?utf-8?B?L1duK2NKcklucS80eDJsZVdJQkdoaTNWWnpVTzhocXBpUHNVcGlKM0dwQVpG?=
 =?utf-8?B?Q3hZdGtzYng5SGJXMm9aTGZ3TDV4Rk0zbnl6N3ZPTXZ6eCt3eGRQdXNaeUdB?=
 =?utf-8?B?Vm9vNnRCQi8zNTkzYmM5cjlrMWtoVU1hVTlDd296K09sOVYzc0lEMnBJS1dz?=
 =?utf-8?B?Tk9jYXBJRWRqU3owdk1ZamxkZUdad1R4TEIwYWxlZWF0NjVNN2Z5dFN3b0F3?=
 =?utf-8?B?cHNuT1QzWDlRRUNDajdaaWg5cE9ybnVxMjBRSDBxdHV0K3F0YkN4ZnFhK25Y?=
 =?utf-8?B?YlowaDMzS3o5UzhObUV0dEk2dS9EL0pGNlFJU3AxVEpBbDN1U3RCcEpGa2gr?=
 =?utf-8?B?d1JBbWRXZ3MxWURmMUlERnNFRHExWkNyeEt1dGFrRjlUMHBzTVBpRTJzb3Y4?=
 =?utf-8?B?V0haV3JIOEtTNitwQnhJOSt5VmFHbXV2SzdqNTlCM3VhWk9tMkNsWGNlOElj?=
 =?utf-8?B?SHR5RzdtMERxeWRwUDRhbjdNdkVNQ3NIdGh4VitvZ2ptam14UERUUEF2a1FU?=
 =?utf-8?B?dEM4eHpJNjRiUExOTmlrakNUV2wwa1loa2hxYzZPS3RxTXVYbXdGZ3lVcmNj?=
 =?utf-8?B?UnpwdyttbVlJK0tuOUNaQnRRc1FCZUtpSlJWNko5enU2R2dYMFRvU3o3MURz?=
 =?utf-8?B?SEJOVlFaY0FvdjZFUVhCK2VTNHZJU0paY2dvbVNuQmJ5a2hsTjZFOThEN29O?=
 =?utf-8?B?UFRTOW1aNVlFQ2drUTJHQWNVVkFhTFFGam8zYXpqWU9MZmtmS1dwUmx5Zm11?=
 =?utf-8?B?TWhnc2hacHBxSVpOL3prVEdmQ0tybTJRK1QrWUwrOW1Oa3NhQ0dBWGx2T3lQ?=
 =?utf-8?B?U1JIMkN3TDVINmVnSDVWcy84M3dxai80RDVtSDRSLzZ4VEtHNlpwOHZHWFo1?=
 =?utf-8?B?VlJ6U2xzQk0zdUFFY1FFLzlGbENSZFg4WXR4NnRJbVFQMVdiRXhEL2g2eENY?=
 =?utf-8?B?ZjI2cmxaUzlEK01pTnY0ejJmeVJJSVNtYW1iVjdkYklLVmZaWTZMeGF6RWVq?=
 =?utf-8?B?VlJtU1lHWmh0TWh4bVVva3BTQWIxUi9QRFFvdUVYVGpiNVNaSEJPcTd5VUFz?=
 =?utf-8?B?YmtMbDZvV2puYlh5dWR6TGdrbGpNb00vbG1kKzJucnIwazJpNUNJV2JEVFlF?=
 =?utf-8?B?aWtFV1AxYW5WQUpEZWxjakRXaXhKQTJkMG5YUEZUWGdYemJEQzVRcSt3SG1V?=
 =?utf-8?B?TG9WZVlDSnV6WFJvdHR1MEZOcEJ3L1BYRXhYN0RNSW8zeFBVQmpiT0VNVHZs?=
 =?utf-8?B?WU1SSkdxZFd4R3hvbUFiMnl0OFVvK1VPMWkyVTllakNVUHBMVFZXMFpOVXFa?=
 =?utf-8?B?K2Ezb0FyNW5ranZNeDlmK3lqZktHa2h3ckE2TVpRSzQvOUIwc2N3Zzc1Y1Av?=
 =?utf-8?B?WDFqRWhkNlUrVFBIR1cySERNbFZ3NUVFTkdFcHhjZUtoRWl2aVAyck1yWWQw?=
 =?utf-8?B?cEdSS29QMFZmQ1E5OGdqWG9NUU1hRXA0eGhhaHNDd1Z2ZkNDWWxCSUNuQWFa?=
 =?utf-8?Q?ktb+fjfp+5x6l54n/fXuZd9Eo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 012be20b-37b7-4855-f06a-08dd47aad495
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 19:08:39.4778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8rYqwgqqNWrXjVubAT1efymNzJkgX75rQJoGY/FlG6yReiG66kklDmWZ4s3UiI8V6A3yDWJXvlrP90ZzvqboA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6334



On 2/7/2025 1:30 AM, Gregory Price wrote:
> On Tue, Jan 07, 2025 at 08:38:44AM -0600, Terry Bowman wrote:
>> +static bool dev_is_cxl_pci(struct device *dev, u32 pcie_type)
>> +{
>> +	struct pci_dev *pdev;
>> +
>> +	if (!dev || !dev_is_pci(dev))
>> +		return false;
>> +
>> +	pdev = to_pci_dev(dev);
>> +
>> +	return (pci_pcie_type(pdev) == pcie_type);
>> +}
>> +
>> +static void cxl_init_ep_ports_aer(struct cxl_ep *ep)
>> +{
>> +	struct cxl_dport *dport = ep->dport;
>> +
>> +	if (dport) {
>> +		struct device *dport_dev = dport->dport_dev;
>> +
>> +		if (dev_is_cxl_pci(dport_dev, PCI_EXP_TYPE_DOWNSTREAM) ||
>> +		    dev_is_cxl_pci(dport_dev, PCI_EXP_TYPE_ROOT_PORT))
> Mostly an observation - this kind of comparison seems to be coming up
> more.  Wonder if an explicit set of APIs for these checks would be worth
> it to clean up the 3 or 4 different comparison variants i've seen.
>
> Either way
>
> Reviewed-by: Gregory Price <gourry@gourry.net>
>
> ~Gregory
Do you recommend moving dev_is_cxl_pci() to pci library as is? Thanks for 'Reviewed-by:`. Terry

