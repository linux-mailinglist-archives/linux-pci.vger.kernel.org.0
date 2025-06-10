Return-Path: <linux-pci+bounces-29280-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2D7AD2E4D
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 09:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E6E16E647
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 07:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF4B27A935;
	Tue, 10 Jun 2025 07:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jyZQZRHt"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F347621B8FE
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2025 07:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749539132; cv=fail; b=SFEXnGpzYV4f4ljXZsWKbwnLvMFW8SG8rAR5DhtUuvZC8kCJUJhNwBVPfmspXbgigLdrm6oFkJlQBaQJZoJk5VOqWYqdWZeTb9vb2Lxkrew41BGiuUGbYsfDk3KKm2z5k6G9yk6z3JgRUg/TRlq1CQ1e5Tno0KlG6zP7RSwZ5B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749539132; c=relaxed/simple;
	bh=sqUfQqjxFsk/EeV+ercixtqro47uQ9j1f9XKH/AJ4ig=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o9XHQm6WtI6PqmRXpJxc+aM98LIF5j6OXFXJfpFox5LpXFlnK+voNExLZO/+v2EWWg4ZuiJYfvd+EjUUZMSAp8c8e15aj7+f8Kc3u3D3ACRNr/vNaI355w38V9ZtLH9LmsVgtz5dz1PgbmVW9dy769bt1kooA7qvozzUmEJD3jQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jyZQZRHt; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PzkgABbXwJligRi15cV7DBobFik66mhuh6J+OhZBnt2cJ78GZIs1jdDTo2Az0sSI6hUidU8QJBGCmxjsFeXHjILCMAQmA3AxCRyFpBlPCErsiLN8qZcn0cmUk+FIkzmKT2wLwxQNw92IjBUirdQlZJcncwCIZy0cq96R7nYg9ipwghukMhZTV09NpJX9VlHfquRYrXjyF3VuLpDBhI22UvvDuzJQpg8gcBxxlS8gLkfHf/KgViw+v91MexlveKbcCQxT64o8LROhVtnmGYUBi4F41jXETCsnoVvdU0/Q3XDcA6OnRlC6R5q5tf7m/K15DH0wusDK0q35jMvaDSqcDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUyU2vMPe0KdW5pix5k3RmZBnuWzZKDL7TIwro73pMk=;
 b=DBoMoyrLX1pvGHFuZ/H0HRAAzFb4VSVdMjqt1/V4v8lPkaCi69Mv2icvDTuECNbTNRTgSRpsKiibPul47cg5sqiZwbWx7JtOKOzo5XHVIbqzJ65PUmnWCMHBoAeyo9Sb+vqQoPhvWZu4uj59mDYzaqZUeCsgZy9ct/LlbeK0MZSM2Qx5A+OM04XksN3HOAchHPIT5UOa5Y3+5r+1BbnyYdr7d8BxAmMGOk4vDpItv9K8xT06msZbFvYBbW7unV4AjrCw69cz2+SwCiNU4I+9VD7m4BWhEaC5z7o17BxRXSRhdXVbuZGifGbkfApy2CQiz3SbHZYwERrlxwVNsSqaeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUyU2vMPe0KdW5pix5k3RmZBnuWzZKDL7TIwro73pMk=;
 b=jyZQZRHt+oh3GZ+p0J848FFUMCwqdWvyNWXockzLzO27C0MIZT8YuRU/XkoeVgV++xJVzd/CHhZ/yDctOCJtGRMnLnujU4rJ7dMldb78kGGGJwH/p34ePrf58jw45SCkFbyT04n3p9AdGcsbIye7MxU8B0UuHj4NP2ruy5htTFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by LV3PR12MB9258.namprd12.prod.outlook.com (2603:10b6:408:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Tue, 10 Jun
 2025 07:05:28 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8792.038; Tue, 10 Jun 2025
 07:05:28 +0000
Message-ID: <d56b85e7-3081-4c99-b3db-7adf6604951c@amd.com>
Date: Tue, 10 Jun 2025 17:05:21 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
To: Jason Gunthorpe <jgg@nvidia.com>, Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org, lukas@wunner.de,
 suzuki.poulose@arm.com, sameo@rivosinc.com, zhiw@nvidia.com
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050> <yq5azfeqjt9i.fsf@kernel.org>
 <aD3QcQxtjoYXrglM@yilunxu-OptiPlex-7050> <20250602164857.GE233377@nvidia.com>
 <aD50lpgJ+9XMJE/4@yilunxu-OptiPlex-7050> <20250603121142.GE376789@nvidia.com>
 <aD/gn2tb+HfZU29D@yilunxu-OptiPlex-7050> <20250604123637.GF5028@nvidia.com>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20250604123637.GF5028@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P300CA0078.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:247::6) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|LV3PR12MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: adc671da-4c09-4276-8133-08dda7ed2de1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elRmdzd0ZXlFOHQwQjN1bHFRTUZMdzFPZDRaL1lGRm9Qc0tIT204ZVp1UEcr?=
 =?utf-8?B?bHkzcXdLZmlhTmNpb0V1cVJLc29PbVpWbHhGRXNvemlZakpiWVdNdlFmSFVY?=
 =?utf-8?B?VmQ5T1JqZXk1WEpvQnhsTndDZGNveTFOU2JTOXFvdUFvaXFncFMvRTA0V3RP?=
 =?utf-8?B?dDBRMjV5OURHaVBSRGtubTRWZ3JZcjNWaUJDRmJvRkMvTFcvWTEwanFJa2JF?=
 =?utf-8?B?dlpKdjRaem53ZklmaGhqTWoxWnlFYnlOa0VzeFhhT2UwdVE0ZWhhdTBEWitL?=
 =?utf-8?B?MnV3Z1Q1WU5Gb1oraGRFWHlobU1CZzh6QVo5dG1XdklsZ2Zobi9Eam5qTWZ2?=
 =?utf-8?B?Szk5cnNMUWV2SFJ5VDB0TmozaG9EQ2xLUXdkdEJKRVZXR1lFRVNxS2ZaaVQ3?=
 =?utf-8?B?cmt6dWVPb0s4WkdENHVzQTlLMGh4ZWJCZVRFdENRMGNPWUZiSWlibEF3RHBY?=
 =?utf-8?B?SGovYnpVNkF6ekYwTm1PMk8wUEpFaTUwSUU0VTdUbkFLc0R3QVB6eUdvSDZy?=
 =?utf-8?B?Ynl1M3Fja1pWUWlDTEp0ZWpka2tjWmZMVHgrYk1SeStVRFdyNWJMdEFpbDhk?=
 =?utf-8?B?b3RZQ3hxeUY4TE81Y0tVM3hPNTFxeGNTRytjaStxK2R2VmpyUzJhY1ljYm5B?=
 =?utf-8?B?NXVmMXBnUGx2bDdKeGtoUlVObU0rVVNLVWh0QnUybTYrM1RCOW04RlptVTll?=
 =?utf-8?B?MUJnTVlLR0M5TWlHZDNTTHNnc0RmcFJZdHBWaDhSdG95NU1aRXFsRVJuc0FH?=
 =?utf-8?B?NWh2aVpWeFlGNzlOdjhOc1pLcVVla2RrU3loUnZLVk1Vak5IV0UxOEJCU1NB?=
 =?utf-8?B?OHU5OGxiTkVhSlNvU2NoQXg4N0U4UU9sNk9WVVgwbnVDRXAyOW5CVjJLemw4?=
 =?utf-8?B?YjQvcGtLUXRaRW5KSDRZN3FESTRYMmpwS05NdzZsOFdic0N3UC9YUmZSeUN0?=
 =?utf-8?B?QkNzQjZQQzVMNStYQjgrN1lJeUhwUGRiNFZiZzY5cVVKZ1d4bzAzYUJuNGRQ?=
 =?utf-8?B?L0VVZkd6SWw4dldYWWlzaFBGWUo2cHR5SnB1ak4veTQ2Ymlma3ZYQkxnZmxa?=
 =?utf-8?B?Ym50WWxYSjRwcTNYS1JNOFc3czVRSExYc0JaakxXZ1JOWjRxOTlMUU1ySlRT?=
 =?utf-8?B?dVRhelFtZ3pSTlV5UGZTcnRzRmNmVUFPNmtOVmFqOUxReGJoQzloWUx3OU5y?=
 =?utf-8?B?cUtoYkl6dlRMYUFqUVRFQjVVQ29QOE5Pd1g0VWMzeGkweVBZK1FHSmdrN05H?=
 =?utf-8?B?NDRzdVJ6RlB5emlXSHJDWDR4Wkl2UnFDWUgvTDI5UnBxb1E5bUFvTnhQaDdh?=
 =?utf-8?B?L3ZVVnZpWEkxcjR5RkZvQThBVVJXNytld0Y1WUdHVnYwQ2d5cTFjZXZwck9z?=
 =?utf-8?B?cXA1d1dGcUp6R09SQVhYcjdXOWtqNXMvb2NKTUI4MisyRldGU0QyWmdWUjJl?=
 =?utf-8?B?bTJLUkxLUDJOSmZkNkREU3BzSUNRcE5DbmFlLzFjRFRNbmxBazhKQnlGNzI0?=
 =?utf-8?B?RXVYYldyVWh6RmpDaTVheTVsUUpobnM5TWJUclorMi96dmZQNUZyd2FqdVIw?=
 =?utf-8?B?SG1IK0poL0d0Ujh2MFVGQy9rUDlXYTFpSHA1dzVhU1ByZ0xrUVI5ellrY3VD?=
 =?utf-8?B?NmRELzgyeDVJTHY2aGxpMm5NenpubDJXem15K09WL1hnczhUcXprR2prby91?=
 =?utf-8?B?cmc1Zmp3cE45YmRzdjRyWHNBdW4wa2hNbGZXUGFNYzVXY3hJOVJHNFpFZ29n?=
 =?utf-8?B?QmxKdFR5REZteXVuQ3BjbDRqMC9YN2wzK01XeEVkL0QxNzVvUTlOUWU3dXVO?=
 =?utf-8?B?TTVyWHpkVkhYYldCQjBMb1NCV0hpNEVqaFBtaXBwdm0xOEdncXVzb2N0VXE1?=
 =?utf-8?B?SDRKQ1ltRkJQYVcyMGhlalNrT1lrdmFIYnZkOXk1VnJ4OXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emVsVXU3Sm5FR0VVV1dBRXZxTkcvSzRHZENPNDkrMmRZNU9iZjBRa1NlQ28x?=
 =?utf-8?B?SWdVUGhhK0k0WnJQelg3UUdCbkRJNTRYZnVPMkFyRURjdXhZMkVHeG9pK3E0?=
 =?utf-8?B?UmFwaVc5WTMrUkZXVWdzSUd6Q25MeFlHSXplUWV1M2RVWTVmM0JmQkcyQVVw?=
 =?utf-8?B?a21uQUZmRlJKeEpaUDJlb0NLSXd0V1A4dW1pekZYYVJuNXJsazRXd2I4K3pz?=
 =?utf-8?B?OXI4bVBMcXZnSWdEME45NFlrZ3BDUFNOdjJlbVlhRXAyK3JGaTlrR3FpaTRu?=
 =?utf-8?B?UVA3bmJkeThYd2JoUlNibkhUNEVuWHdpLzhybWhoWW1VTTJpTGUvMGlvS0E1?=
 =?utf-8?B?VUJ2RGNWM1VhdnNkV2F5M3FTejk3Q3d5WllzOU52NTBGdnlUNjQ4U0hldnFw?=
 =?utf-8?B?N2RtVDRlOG1RWUxWYzNRZVpzN1FsdjY1S0w0am4wSEZCM0ZsSHFrYXdlSTkv?=
 =?utf-8?B?TVhTNGZvMDVMNWpWY21OeUVGRVZFZXFHR2g4elpzVFc0ZlA1aUk2OXZmNm5K?=
 =?utf-8?B?S1V6YU5ORzZCdHpCK1UvM2x4U3pxbkg3b3I2NHd5L3NDcUZRM0tTTVlJRDFr?=
 =?utf-8?B?NGlIUzdUYzVpWXJmUElzR3hxM0xZVEJZU25QTWwzSWZpRjlXeURqR0l0UWRJ?=
 =?utf-8?B?djNyRW1pQ0xjUlROOEI4VzRvZmZGT1VlK1NoWDJMUGdXS3h3QzM0TlY2YlVu?=
 =?utf-8?B?d1RLUzdpUGNmSEJ1Z0JJUW5LZXgzSWpDZzhTYWxJdWp1aHJXbjZZVUs1V2tq?=
 =?utf-8?B?Rit5dkFaT1VtNUFXNUlCM204c1ZUcVBVb0E0M3VQMGVMUTNjQ1g0bDZOd3l5?=
 =?utf-8?B?U0IxMGdEeWZYRGZYbEIzQmJhNWJmSy9Xc3BZVzJza1VQNFh6QnhLZ2hLZ0pu?=
 =?utf-8?B?emd1bTBYSUlBTVBPbWgrcTdzYlRNOTkxT3RobldxN3NGdWZNcHVpYzI1T0xt?=
 =?utf-8?B?WVJuUWdRSU5LUXV1dVJkWDZyWFl4WnVRQmF1akYzTTQ3cHE1dm5hdkxlSUwv?=
 =?utf-8?B?OHNlWTNsRzkrVmVTbTgyNHNIMVlVek1aSDlDWFJjUzJSRlpGc2xOYlZaK3Vn?=
 =?utf-8?B?T0dJSFN1aElPYm5ZL3FHekFLMjk5REgrd2VNa2RsV05CK2xsa0dlYWlDMDRK?=
 =?utf-8?B?aGFDb3ZyS1dTMXFDQkw2ekpsN09LT3NJcllxbkc3UTR1bHNjbzJCOEUyQXNw?=
 =?utf-8?B?VXNaSi9jcG41WEpXdDMzTUtTUS9jSmdzSFNBWUdjclpvcTlrd0F5MXhJN1Fa?=
 =?utf-8?B?aitRWitzVmswT1I4QVorVlBqbHc2MW53aE5yRVNEZkg3ZmhpVHdscEM3cXpJ?=
 =?utf-8?B?SFphM0ttb3pad29yL0RlY1VzR2lROEd1M2QwTTFvdFRYc3JoVGQ2YkpReUtL?=
 =?utf-8?B?UFJ6MnJQRUEvY2VhakpBS3FGVmVZSDhjWEpTZ2Jvb2lWVHg2ajlLbTNoUEVW?=
 =?utf-8?B?V241NDhLTGtLUXRqS05raHVTaXZ0SHdwR1RCR0ZpdEtPaW1uN1ZaOStnekxr?=
 =?utf-8?B?cXc5d0Znc0FpbXJibTR3aDJyc0ZmNldJelMzMEFPRWtkU1dWZHl4eWJ3SEkx?=
 =?utf-8?B?TGlXcXkwemtIOUFaOGEvNWkvUWt6U3B2aktQRnNBWVhCQXRVZVNOalRpcUl1?=
 =?utf-8?B?Z0Z3cGNxSXAxalEreFJyNE44VWg4djVtRHZSdFpiM1NRNjR1ejFBRlE3cXJw?=
 =?utf-8?B?TFE3UE81V3FXWGgvZU1vdmM0SXJmVU9aSGw0SVZzcWNYQUhGSTQxOXk0LzNN?=
 =?utf-8?B?VkQ1YWN5dlhRaWVuS3BzS1VCcW1HMUJ4SEIvQUQzUTZidS9nMC9taU5hUzkx?=
 =?utf-8?B?dHA0OXl2UFhPOWFEMGo1dWpTUnJOZzJHdzVsdG10MDBxQmFVVXhVazgwejNO?=
 =?utf-8?B?cC9PV04zV2RBeDE2eUc1T3BxN0d2cnBXVUhoWlcybEZ6TmVGc2JMcVA4cGdL?=
 =?utf-8?B?WHdGV2NJWHY0L3l5Z2RYNGpMcWM4bHB0dkFJNTZnbmFvaW8rNHVicVU5R010?=
 =?utf-8?B?NXFsQXlrcUNLZ3RPTm9ZZXVEQU5wSllSYTkwRW83V0I0SEwrVWRody9HaHlI?=
 =?utf-8?B?ZTV1VzRYNmQzdHdpSkZyeDc3Zlh4OExhVmdCUzNDUzJKSGhRSFlzaWlFV0Vx?=
 =?utf-8?Q?Aen//MF3EIX/TfsKEVAffvT+G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc671da-4c09-4276-8133-08dda7ed2de1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 07:05:27.9677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4D4FvxLPMJgBOx3RS1JzK04Zu4oYKqSFyeNrOqyhanSOeTPxOh6HBZtRaDIEhgzPBCoPNcHU7DKiuKKWbG/WgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9258



On 4/6/25 22:36, Jason Gunthorpe wrote:
> On Wed, Jun 04, 2025 at 01:58:55PM +0800, Xu Yilun wrote:
> 
>> But the p2p case may impact AMD, AMD have legacy IOMMUPT on its secure
>> DMA path. And if you invalidate MMIO (in turn unmaps IOMMUPT) when
>> bound, may trigger HW protection mechanism against DMA silent drop.
> 
> As I understand AMD it sort of has a single translation and relies on
> its RMP for security. 

Well, two levels with the first page table living in the guest memory + RMP for the second page table in the host memory.

> So I think the MMIO remains mapped always in
> the iommufd IOAS on AMD?

Yup.

> 
>> SEV-TIO Firmware Interface SPEC, Section 2.11
>>
>> "If a bound TDI sends a request to the root complex, and the IOMMU detects a fault caused by host
>> configuration, the root complex fences the ASID from all further I/O to or from that guest. A host
>> fault is either a host page table fault or an RMP check violation. ASID fencing means that the
>> IOMMU blocks all further I/O from the root complex to the guest that the TDI was bound, and the
>> root complex blocks all MMIO accesses by the guest. When a guest writes to MMIO, the write is
>> silently dropped. When a guest reads from MMIO, the guest reads 1s."
> 
> Sounds to me like the guest has to do things properly or the guest
> gets itself killed. I wonder how feasible this really is..

What does look especially worrying? So far the process has been pretty straightforward. Thanks,


>> BTW: What is ARM's secure DMA path, does it goes through independent
>> Secure IOPT? So for p2p when VFIO invalidates MMIO, how the Secure IOPT
>> react? How to avoid DMA slient drop?
> 
> On ARM T=1/0 traffic goes to two different iommu instances.
> 
> As I understand it the T=1 traffic will go through an TSM controlled
> IOMMU that uses the ARM equivalent of the S-EPT for translation. Ie
> the CPU and IOMMU translation are enforced to be identical.
> 
> T=0 traffic will go through an iommufd controlled iommu and it will
> use the IOAS for translation.
> 
> I've also understood this is quite similar to Intel.
> 
> (IMHO this design is a mistake, but oh well)
> 
> Jason

-- 
Alexey


