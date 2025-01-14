Return-Path: <linux-pci+bounces-19777-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D42A113E5
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 23:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6383A34D3
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 22:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90884212FB4;
	Tue, 14 Jan 2025 22:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BoZTUBOY"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F5820CCF5;
	Tue, 14 Jan 2025 22:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736892679; cv=fail; b=V5yMyqAh14bYvwjimAyN1Rz2QApqAO2LutPvohgYLCN0OIgeh5d7nUc/BWhY8/1t9D5hBvcKWsgouhqRkW9VzIfePnV5GWY9JHKavYhRKRsMEXt8HE8cOxmmZwPXvkGfJ+IDFgqQC+krxL6wXUIxM1Vi/HfytBGbnZBqXU/iacI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736892679; c=relaxed/simple;
	bh=AnwBqSDij7io/BVl7QybJgcFI8WxmHntmr9SyDJ9Awc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U40rO+XyLBOXRF23Pa4nMdQWs+ObewniFAI5F9CKmeikKuTiS/ekW2jZx+QyMA1EUiwjB37d169L+gMN3hbkeHbhdgqbb+bU7NBqqBTCzOub0klJzUhrEH4AmIJGV1XcBvk0/IVKOd2hJeRiSGnJWQGkLWDlItx/lIWFIdLigZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BoZTUBOY; arc=fail smtp.client-ip=40.107.95.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l59ldG9mRMEJxNJKlmVek0wb38O2A+vds3EBEkRYiazvtauNPKWMjBTrBQj+HO89xspVYdTMbvWVnUcist0uVvUJ3xx84TCGrgFpTjihNRCoclaqv7gIJC2WvkjbCtKxidTlsuJWrsEisjetkHYkC1KX51pVGPZh6ooIzYJgAJBx2Qpv2sIxDvGFr1d0kIi0/bFnHV0t5pRl0y5zC1OmZGL+PyaP/55GD9YjqQt1dLC1KeXtvA5dUQX7xUSaHUPEuIl43DvVH/6gWispBAMFTkEtqP1B7iAxATZpfKSNMshtbaVD9mLeq5t5FZYbL9Vahalwcd6KEk2/Vbw9Ym2Gfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDuSCxnhzVTfQduirzlQMy6zlOq1H+3tsO5GToQ6nzw=;
 b=Wbt1pdZE9RPYMroZof9fOMx/0BUzMhke5BG0b/q59mKSseFUQESA/H4OH6q6Xg3Dpa3jbDbbvmtDD3XMk0LuwSYDL+Hm5lLjPMPOvAWFgI8r6tOSHV23GcYsBqFPolQPdovYg7yOzVfN9OWhttQRLZTWjtouM6obopPyAzT5d6ttrIBrL5SnkjqK0K4Ja0q1P4p/1yD9QTJdAsaf2f4S8gYwj78LSp5l7grTaZ/niEgdFVI2TqRPAbyAUrdHPRn2UDn5JaQMG9IAOKhBhib271864yYOYiS6xzjG60hsVqgj6dxCxMWGwz7Q4+DEUxaVbKLkZqGwXCummlcnR7Bd5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDuSCxnhzVTfQduirzlQMy6zlOq1H+3tsO5GToQ6nzw=;
 b=BoZTUBOY0TUgYikUe3sC1B5NIDv6suLtSjne0FXV/0pZy4POdwSFL51YDZs+3W+Z0XntGMdete6IitiKar7Ni7wYsMviCUqCaGlyIsKKmjeMsiN67wBoH9V0JdmCGhDTE8Z9aaLEr0lKjHIAMDYgz7LtoC/XWwKlfDGCGhsarmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH0PR12MB8150.namprd12.prod.outlook.com (2603:10b6:510:293::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.14; Tue, 14 Jan
 2025 22:11:15 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 22:11:15 +0000
Message-ID: <73855ef4-7540-486f-9a4d-e73cfd286216@amd.com>
Date: Tue, 14 Jan 2025 16:11:12 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/16] cxl/pci: Map CXL PCIe Upstream Switch Port RAS
 registers
To: Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 lukas@wunner.de, ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com,
 alucerop@amd.com
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-10-terry.bowman@amd.com>
 <6786df12594c5_186d9b294ba@iweiny-mobl.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <6786df12594c5_186d9b294ba@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0007.prod.exchangelabs.com (2603:10b6:805:b6::20)
 To DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH0PR12MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: 51292743-abce-408c-4624-08dd34e85cc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzJTbWszUjk1NjBrbU9nK0lMeVpzREtBcmpJeXNObzdNYTMrRE9rd2dkUlE2?=
 =?utf-8?B?aTZGSmlpSEx0dFpPZkhheFBWVmVwZjYzL0pwSHRUVVk5aDd6SUczUWg0eTky?=
 =?utf-8?B?VWFtT3VHNldYV1FhUlNVWmE4VUVyWmpqcFVXalpWVEVZbldOZncrRzFOZUp2?=
 =?utf-8?B?VEFheEIvVnpYZ3hwbXpaNTRsV00xVDNMVnJDSzdpY0xQbmo4VXhRazE2bWEx?=
 =?utf-8?B?NjA5bXczYTdYbGlUajRYVExoSlZmeXJUNVh4cjNjZGNQR01IbzFEQXVFa2tJ?=
 =?utf-8?B?QzFpNy85Nnh5dzJ2NG1hQmFDVmlWNS83V1cvOGErcFlLaGdHMDBHNitxQnJL?=
 =?utf-8?B?V0VYNXd3U2kwZ3g5UVZBU2hqczZEVUlyOXZSNWxBOGlGaVQyeFZYNHlCaGFD?=
 =?utf-8?B?Z1FPT0lTMnNoM2o3MGs5K0xjVTdMdG5RRWErdWJacVl3blQxOG5uZ0Nhd3hM?=
 =?utf-8?B?cVRyYzNlYmFQMFFtWHRwd1hIMW9TOG1kYTc4dnA3NVNNQnFOdThWQlBZVlhi?=
 =?utf-8?B?TnR4d2hDcHg1Ni9YckE0OGNJT0YrMExXUk9xc0lxVDNUbEd1QjhrQ1J4NHdm?=
 =?utf-8?B?RFBqSEpITk5qUWtnUmo3TDY3bG5WQnR6dXV3UGFqMEFXek5xWlRHV0ZsL1JN?=
 =?utf-8?B?NGxPcDdUNDZmVk4yOVVWdkw4dGNxUU5FazY5R0tVaUExWlJ5UGJhVlk5UG9D?=
 =?utf-8?B?UUNTejhFTXVIMjF2aDF1R0RBVHVQWGV5a1Jpa0ZyOEViZkd6cStZLzgvT2Er?=
 =?utf-8?B?ZFl0UXhCdHU5YWE1L0xjQUlmLzV3T29ocmpwdTFyK0NWejhxdHBiKzNERFJy?=
 =?utf-8?B?N0Faa1dMMElidmhwby9LbE16OVlvZm9BaGhHU2xKM2dpVnZ1VGpaeEF2RmNF?=
 =?utf-8?B?cysvNTdnZ2ZvYlBPbllERXhyMmNTTm1PaGxjYm1vOGxoeWQwNmtiSTJZQ2px?=
 =?utf-8?B?U0dINnpCUWZiMGVldzBnd0tqR3hmNXlVLzdHVjh1K3VYSG5PWnMzbUtuZFM5?=
 =?utf-8?B?WUZzalZmS0x2UVhDRENrSThZdlZpR1BWdWNYZlFTZHN1cUV1UjY0Rk5KcGhD?=
 =?utf-8?B?UHhhcnc4M1BYcUc5YnVDczFMZXQwVDJscE5zSG5mbkV4d2d1dXJFRlpPVGJs?=
 =?utf-8?B?OENwTzJ5QzJvUXdlb1c4c3ppVnZETjJuMVhxOGlleXlneDRjd0xGZ01hb0l3?=
 =?utf-8?B?c2VkZ2pHMUpESXRwemR6UG9CVzg4eVpiUjkzODljMkNYQjY1aFl5Rm5wd0F2?=
 =?utf-8?B?VTlTSEk1R2xYa1hKc1FObkJRaTdQdENreERsODZtdXQrMlpOYTBpc2llbGFF?=
 =?utf-8?B?WUIzWmpUNGZMUjkyM3ZITm9JK3d0WUMvYWVEeXI5aGw4N2NRQWZwajZUc1Jw?=
 =?utf-8?B?eVQ2ZlhuNzg0NE5LZE4xTDZvemtnUldUdVVETEtrVzJkdmhoL0JiU3pJaFd3?=
 =?utf-8?B?UWgzZUl3ZW1laFlFYTVoUm43UGNrVzJ0SVgyaTBrU1BkY2c0QzQ3QXpIOEYx?=
 =?utf-8?B?aitQMTZyOEsyeTdqRXByeTV6cWY5SnFHWXU0YmZicjJyMTJXaTlpM3o3b0hQ?=
 =?utf-8?B?K1EwTm9JZXBpVXdoV0xqN1lndis3STRhVk1qZWpCRno1dEdrbHFFc2J6dDlr?=
 =?utf-8?B?dVRLRFlQKzRJc1pScGlROFM4T1ZZSkNTWUh4SjhWRDZ4MmVibnlMWldvYXlP?=
 =?utf-8?B?TGw5TmpIN2NBbCtuQUhWWlFVdzlXc2dKZHo0Uys3L2ZQYUVNUHg1RUx3NFdM?=
 =?utf-8?B?SVRPL0VzU0E0cVdnZ2J0VnRMcmZ2aHFIaE0rY0pWL01jVW5Ka1pvYlFwQUh5?=
 =?utf-8?B?Ly9DbDNyaU1LZVJDNGpvczI3WElpdjdncUNWQWZ0WElwNldwM0U5WGRJSURN?=
 =?utf-8?B?dk1DWWlWRWdYRjNTK3pUWWJsL01QTlMvRVBRMzB0TkZaNnpnTnNCT3dNbW9Y?=
 =?utf-8?Q?at9qRXGLjFg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MG9kYUR2RUhydkI3M2Fodng1V1ZCdnVTVk5xNkMrZnRRUVVDK3UwbUgxZCt2?=
 =?utf-8?B?OEJma2M0T1cwdU1CeVBoTU5HKzVWaUgycXJOQWhhNTRPWUtialI3NFQ0azZ4?=
 =?utf-8?B?aWRCcFV4UDhkWFFLV3haVjFvSE5PdmM1ZC9DQ3cwUjA2YmFjVUxpWU5GNDZ6?=
 =?utf-8?B?ZHJNWnZHVGFZaEJvN2QyWG5VNDBvL2NQTkVIeTlaTWV4NnpSQlFGS05YMWhI?=
 =?utf-8?B?SkNFLy9VN1EvdmFUekpRdFk3cXBkQzJUV1AxdWtjaHdOem54b3BPL210cjMz?=
 =?utf-8?B?Z3hxQk5pVWVYdTB3cndxendaY29abEprOUhTZnNNcjcvOHY5Uk1yWWR6ZDhq?=
 =?utf-8?B?T1k5cWswSWtUcDNkVzJQc2JIb2p2SGFnOWI0OERSUVd1RXZKMjJlRGpyTkU0?=
 =?utf-8?B?UlVnZjkrTlZ0cThVaElRNWtlU1pSd285M2hmWW5YekcrbUVMZ3I0QzMvbHJw?=
 =?utf-8?B?Uk5nVGx2bG1FWU5ERU5iTldMUmh5S3NHbGxPMHdpTVRHZFdOT1Rmc3dIaWRu?=
 =?utf-8?B?dlY3djl4T29hRXRaZEExajRiM3YxMFROcGJnUmVYNGxEWTJNVlkwQ0tOQ3JP?=
 =?utf-8?B?T0dOdjRGeldGRXM3SXhJVGJqcXVTa0dJeU9kQWNvSUxjZHNJcHZST095aEho?=
 =?utf-8?B?Z1VRdWE4NHNpamlsemZhYjFxNXFjUTBqOVB5SjZwN3Q5Z29CanBra2ptK093?=
 =?utf-8?B?RmJxOS9XRzcwUGF3dVNaOEtWb3ZlSkFlQmNYZGRMbmlxSXBGOWx1Y2gyNGJo?=
 =?utf-8?B?QXVIOEJpSWF0QTJJTFVRNkpoZjFUWmJRVWFyYkE0UlF3d3hsNUlRVFdCYVFQ?=
 =?utf-8?B?cTdyYXBmK1V6bWE5bTMwSkhtNjZFYnAwZ2YvUjBUZml2MElRa3RQTzNad1lP?=
 =?utf-8?B?Tm1hblFJTUhGa2svRWllNFJlalJ0VDhaczI3aFNqOEM2Zm5PTmk0K2VqMEdr?=
 =?utf-8?B?QnFoenFRRUJKdk9sdGh3NGFCL1VFQ3UwSWdnQTVqYW9YSTdoQys1V1BPTThx?=
 =?utf-8?B?enhhQ1dXRUxNa3ZHMTY4YnMwUnNNbklVMXA2Njg3L1lTNGs3YWlhZHFDWms3?=
 =?utf-8?B?TXZvNTY5dS9Namx2RG5sOFVjVDdQTFg0RGR5TUR5OSt3NmZZL1kxNC9rdmdG?=
 =?utf-8?B?SXFmT0RVYjJxWWFUV0xla0p5eHJlQmRPTkppRmlLaUJySFVsQUVrRExXakFq?=
 =?utf-8?B?UDVWSWgyMzRBWXZObStseFlTNWRjbitaNlpwb09nVGpnYlFFcmg2U2V2ODN0?=
 =?utf-8?B?MmpaUDRTRGhGWnZSZEsxRHJzMUZLVHJsQ0FCcStMKzlMQlNtUFh1cDBXQitl?=
 =?utf-8?B?aUdUc2tMRzBFblRCN0QxVnVjMmcwTEpwc1RSRDc1RXNlL1l1N3BJaW41Qy8r?=
 =?utf-8?B?WmpOcWNKc3pOcG9VbkEvTUFheTY3ZGxnZWVkcVRuZFlTZ240d1ZXaTZDVWV2?=
 =?utf-8?B?TUNCVk56N0Z6dndSRDgzVnFDaXFJbkVTdDV5UW5GTWZIcTR5c05ZV21Wc3ZY?=
 =?utf-8?B?TXhVNHRSckZPY2VIcDdwdytBQnp2Ry9JVWp6TWlIbEl4RnZ1ZVRwc0hCSWFD?=
 =?utf-8?B?YU5hSHJsVlkvYjlKRWUybVhkQURvRFdaOHc4TDdZTjhocCtJS091R2huMkFs?=
 =?utf-8?B?dmVPOVFHcXB6cHBKKzZVclorMkZoWkZLMVF0QWt1aVNGbDhoSlRHRXQwaHN5?=
 =?utf-8?B?Qno2blJnZWVrM1IzUVdjeG9oQndTTTIxcW5yclZHVlhNNUt4UlRpdUgyS2NZ?=
 =?utf-8?B?Z2NLTCt4cE1nc3AyQmdrUW1zeStqaUZhUk90c3p1dnM3V1dPYjRSbTFoTHVD?=
 =?utf-8?B?ZVV5MG91ZWV1ZFgzeEZ6VExIRWVIT0MzVFpacmZBQXBSdDM2TTJyQ3diUUUv?=
 =?utf-8?B?M3Y4UVJDcDI3YXZYNm4yaHhVQU1SakdIaTNzd3JISWVHOEFLd0poQ2NYN2Ju?=
 =?utf-8?B?OURONW1PWk44aFFXYTRVWGpic2l2VElqRkdRTkZQTEJ3Q0svcHZGcVdCa2dM?=
 =?utf-8?B?ZFpsSlRuZUVTa0Y5ZlBod0VXVmU1RkFtVG9iQk40SDZsVi9OMDlnMUtMTHl5?=
 =?utf-8?B?K3NyWmhsSjlKeGNjMmFjRFo3U1VYRGUwRDdtdkNJYXF1Qk1ZKzl0UHlYdW92?=
 =?utf-8?Q?KzAGLeTZs3n4ElhH7mPMx5PUF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51292743-abce-408c-4624-08dd34e85cc4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 22:11:15.1910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHv8YUvPbed8MGTZqbfDvNEm8DOW7SB1+cV3lKMPLT7y7wo12JOT/xP/PQwcAoiU7UqvCJ7KTt+/31M74KILNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8150




On 1/14/2025 4:02 PM, Ira Weiny wrote:
> Terry Bowman wrote:
>> Add logic to map CXL PCIe Upstream Switch Port (USP) RAS registers.
>>
>> Introduce 'struct cxl_regs' member into 'struct cxl_port' to cache a
>> pointer to the CXL Upstream Port's mapped RAS registers.
>>
>> Also, introduce cxl_uport_init_ras_reporting() to perform the USP RAS
>> register mapping. This is similar to the existing
>> cxl_dport_init_ras_reporting() but for USP devices.
>>
>> The USP may have multiple downstream endpoints. Before mapping AER
>> registers check if the registers are already mapped.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/core/pci.c | 15 +++++++++++++++
>>  drivers/cxl/cxl.h      |  4 ++++
>>  drivers/cxl/mem.c      |  8 ++++++++
>>  3 files changed, 27 insertions(+)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 1af2d0a14f5d..97e6a15bea88 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -773,6 +773,21 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>  	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>>  }
>>  
>> +void cxl_uport_init_ras_reporting(struct cxl_port *port)
>> +{
>> +	/* uport may have more than 1 downstream EP. Check if already mapped. */
>> +	if (port->uport_regs.ras)
>> +		return;
>> +
>> +	port->reg_map.host = &port->dev;
>> +	if (cxl_map_component_regs(&port->reg_map, &port->uport_regs,
>> +				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
>> +		dev_err(&port->dev, "Failed to map RAS capability.\n");
>> +		return;
> Why return here?  Actually I think 8/16 had the same issue now that I see
> this.
>
> Other than that:
>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>
> [snip]
If RAS registers fail mapping then exit to avoid CXL Port error handler initialization.
The CXL Port error handlers rely on RAS registers for logging and without mapped RAS
registers the error handlers will return immediately.

Regards,
Terry

