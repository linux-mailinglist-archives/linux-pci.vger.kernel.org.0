Return-Path: <linux-pci+bounces-40809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD42C4B24D
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 03:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC7984F0DF1
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 01:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F50248883;
	Tue, 11 Nov 2025 01:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k8ccrBiA"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160A42DC32C;
	Tue, 11 Nov 2025 01:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762826284; cv=fail; b=AaHUxgMgQuP7nXcaREo2Nak8YgKp4PJqAaONOgjV1KKsFCCG3KAlcmcK4W629HBFBZQuwejmpAIPiVwRurvwhMBI6F3IlCbO4rb5zUAqHNeF62Ki3vV1eAA8tiF75ARrhJapbyWr2wpkwO/MtN4xm0YmToq17Sm/btvzqxVZuCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762826284; c=relaxed/simple;
	bh=L9n5zDULLyO139PAxyhQc6DjkzM7hfmc6buDy/SYnx0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cjOQQea0dKecgMy5CyimrQjeUroozQBkV8AX/hrDy6PjsUxxZGvo95MCwlBEEG5t3ZlyWmMfMMSBt6RgInvsPuk7Klh28DzsrMy5GuTbh23yHBGwn9BUdRVqZfbHDz8HOERdZ5RdYuMixmW3OXXyACXeA3V3gG3Gc01JqifV/8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k8ccrBiA; arc=fail smtp.client-ip=52.101.56.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LxXMBjukas2W4hPLyAu9e4kW30JbiapuN1MYMlgjoXZw9Xlo/DakPUMCAF52RuaSKsfYF1RUWGF3oAfy6+puLDYi/xeyoUX1pff4gSgcIFRlJS3pAe6AAe8XByhORbGpznEZIurWkdH2TpiXVt4VGz0jaD3Zf9+1zp1ejsFlWlKvpF+J4frHQtH0qrpid1Dr8UNy5n2JLsC98ARZT8wrqAhJ6E0kD+xECf9PtZ+PI9XhsgWvEpI2UZMnvyzFys2lvTn4etietmzYp5rZJNztL1fQiXS5lAbU3T2md4ukU+B2flAOSd7QAponXhi2MdjTyP9sD6ekVioL3HtaoZhfqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qo2PQTCWIhk6QQb98bN7k7dSJuKP47v67XNkmh3VnIc=;
 b=KYx5B6FDeqA9ENGWX/wOs3tQul3BavyMSDfhubZVDxE2N+EVEYb0VgxbZXQnd4sNNN3SZjXW7k9he8/qHO9ZUJGzzE/eQzQw+WJz72OF9GOTUOSyl/tItqmqYDuaofoeMyXc2q0y/1Xfm5/7uA59shOeX7344ZgDXHRUi8x86RXrYl/VrblFPtqO/jHqDwCARVtYkpofk7eqkDx7MYFotSm9jbEItS2mijSEM2W+2hGBRzeYP7mmeOMlJu0m9e4nnJM8Sm/CSkYVmJGHiEhHbXO7X9epDKR8hkxZcfgwEdX7K58SSHsjMTcsuHdHwJT4FDlqMFRxsT1i3y0IK3sRBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qo2PQTCWIhk6QQb98bN7k7dSJuKP47v67XNkmh3VnIc=;
 b=k8ccrBiAMtGVOPGTAh4UmacHx2UysmYQ+MfIgoTLrLv/uHY8Fwccr6Ti7jXrTGOBtm/I/3mbg/jwb33VYsEi3L89t8pMjvR9wuXxFp+hyftuePBFazzCdpqGpb48qTNDWhrN792B4wtRiHl5gdkEy6OZ/3vOqFo8qw6tdwEY2Im+K+PkLjohGpbL4om93dtaNGFQI9GoKr2u+o6bUsH9/GtnmF15gEoVnhsqJ7cTQDmMITkRFQlJeqew/MCTUmB9p8CrQycaZq/FRB9IYnoyfJYL9EV7KiSM3D++sFC5MEknyyLWAZpqht8RpTx47VvOaHmtleomppwcmJxCM7aUJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by DS2PR12MB9752.namprd12.prod.outlook.com (2603:10b6:8:270::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 01:58:00 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%7]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 01:57:59 +0000
Message-ID: <96ea0759-57c3-4482-85f7-63dd9188de2f@nvidia.com>
Date: Tue, 11 Nov 2025 12:57:54 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/kaslr: P2PDMA is one of a class of ZONE_DEVICE-KASLR
 collisions
To: dan.j.williams@intel.com, dave.hansen@linux.intel.com,
 peterz@infradead.org
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Andy Lutomirski <luto@kernel.org>,
 Logan Gunthorpe <logang@deltatee.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
References: <20251108023215.2984031-1-dan.j.williams@intel.com>
 <d6ad21dd-82f1-486e-8a0d-b007b39b4d32@nvidia.com>
 <6912767eb60ac_1d9810070@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <6912767eb60ac_1d9810070@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0032.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::45) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|DS2PR12MB9752:EE_
X-MS-Office365-Filtering-Correlation-Id: fde3d5a4-081c-4203-d0d1-08de20c5bdc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkIzWC8wVFJLcDRpMFhMODRSRXN0cjIzdEtBUmQyc3QzUVlXbGF3Y1A5dlpt?=
 =?utf-8?B?TFNwTCtteHhEeUx5cmdDM3V6R0F2bDJrL05TTkVod25yZjlvbmk2bmpxTWo2?=
 =?utf-8?B?Z1lLWmVzQUZEYWpEZ29EbUo4K29IOGVNWmtXaEJFVkRhTWdLclNkZWhZdkt6?=
 =?utf-8?B?T0U1aFZ4VWttVitoY3BkMmx1cDFvd1pqaThYb2VqQjZicFZ3ZDF6VDQ0WDZW?=
 =?utf-8?B?RVppWGVCalAvOGNCaGhOTm9zdkhMZHpBa2NsWXF4dFYxQ2pBUmRVck5DZjQ3?=
 =?utf-8?B?NERkam9MbldWWGtIMHRNTkswQlhXbThCUVZ6UVlFODBRdGdHK1dWQ1E2SS9m?=
 =?utf-8?B?L21COS9VNGVwWmgyaE92ZG84d2dYZlJqY3Nac2gzTHdzQXhqb2RXMGR6ejJ3?=
 =?utf-8?B?TWJodTBMNWpTa1FmbnBCS2RuMlFuUUUzaTR4dGNGZW05anAyeUNPYy8xcCtG?=
 =?utf-8?B?MCsycnVHS3JIdnlyb3pNSERidjZMVjdLbldIV3JFWlVOTGcvWWxlWGtxY1J3?=
 =?utf-8?B?emJtRTFmYVlKd0tEaGdSSlVWOVBSUGhkcFVJbmdVekJXOXI1aWtUUXF6K3dV?=
 =?utf-8?B?OFIyR29Ba2IyTlNaU3piNENESVZ4bUtOQXRKT0JNZEl1UStsNXdjRGNucERC?=
 =?utf-8?B?SWxrbEM3eDFjWDRMY09Ob3RmODc2WGp2cUs5RnFYcW5YbnROLzU0WXFoeU1F?=
 =?utf-8?B?UTBjTnZvYVZGdHh6eGJjcjQxZ0o4bmN4QzVOQ0NDcnZjQlBidkxoUUxFbHNz?=
 =?utf-8?B?cExSNlRVeGpITExLMEJ5Z3VBZ1BPREhQRnBWb1YxZ1Z4QTEzVW5SVzVZMWI3?=
 =?utf-8?B?SFdlVHdoQmdVVEEvb2hKOFYrZmN4T3d5eDc3QWxKOWhtMm0xeGFRbXgycjNE?=
 =?utf-8?B?MzkzRWZYeUVYTTl3N3ZKMXhuSHVad2FBWDVISUhCckJic2w4NXI5QnBCNzUx?=
 =?utf-8?B?SzE2SE15Uy9OT1BvQXNrcnZ3dWZmdHhtaWMwd2hNc2ZKRzFjMGFoZ0lwallY?=
 =?utf-8?B?NVFuQ3BpREM5c2NRRmVCQ0Y2Zlp5d2lBOWEwZ2tKQ0xkNFRrNm12K1h2dFFr?=
 =?utf-8?B?Q3EwbzRJcDc4WkJ2VWRKbTlHUDV6OTFPMG9ac1QyVDVGcndVbWhxblNCSmRL?=
 =?utf-8?B?S2xMVFZ3NENaMFpwS0s4bm93QUNtRUtZVlNCK2hEc2pJTUNwZUN5clV3NXo2?=
 =?utf-8?B?cG1lN1AxbmI2ZVo3S0l4d3E1cldSa2FodEJUS0hCWTVVKzNIZUdLVXJzV3BO?=
 =?utf-8?B?djM0RHdYWHpVS1RxbGE2SnRkS2lqWlRaZU1UcU9TdjNsclF4ZXZpSXMzNElo?=
 =?utf-8?B?dEpIWlNnaEdlWEdPWVllVHkrQkVsbUlXeXBGMmE5dzd5UjNxZGprWW1zWnYx?=
 =?utf-8?B?S2NWblRrRVJsejZVTjB5akZUTzZzNjRkMXMyS0dOMWhvaDlUdVIvT28zbElQ?=
 =?utf-8?B?bDA4MVVDQU14OG1vSjZacXNIUGllcFVqK1BPaUQ3YzdRTUtPSzY5SUMxd2M5?=
 =?utf-8?B?b0N5K3pGZ0s2RUlBcEw2bktqQmRBaXdnd2lNSGF5VU5MeHZzVWM1MVVnM2VC?=
 =?utf-8?B?amNxMVBrV0EyMW1oZFpMTXV5ZDZGR3FaTVhqSE81WXRGd2JmeE9FZHhHM0Uy?=
 =?utf-8?B?NzZZOVZKOFBlWHdNTDBIMXJEZmwyQU1iK0U5c2hhZDZZRktyZmN1NEw0WERV?=
 =?utf-8?B?Yk5GZGpOZ04zUzhNaFREblB3eXFMMlUxVWVDejFFbnNMVXQ4aEZKdjRVcjJu?=
 =?utf-8?B?dmMrWlVLRHU2N1NCN29OcWYxTnZGRHdLRGVxYkFveExiMlNMTW9DSTB6dzFy?=
 =?utf-8?B?SUUydGtrcFhtVVBnckJ0ZEpLODV3Rk1nUVR6Nmxmd1ZRVWZoc0RLM1dkMkN3?=
 =?utf-8?B?SHZLVUtadk10QkhQdEZoTHc5b0dhM0Rhd0NMNTNBOC9WbzZ5Nk9jcTN2OFNS?=
 =?utf-8?Q?foOMeyLBOLBeD+jvXwyFyUiT7FiKxUxA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmFKQjJsUWR1b3NCeHJXSEh2SWNCa0gyRjVWS3FXWE5Cd0pxRTY0cTZkS2hP?=
 =?utf-8?B?YWtldytSVllnY01MSThWcmtGV2FoTURTK3hJaXdneW55UDNtYUdVZVE0ZVpT?=
 =?utf-8?B?TEVNQTBucmwxQTh2NkJlOVFDblVRdHJidlBNVTFnZ3N1ZHFaNnZFODQ0dGE2?=
 =?utf-8?B?eXc0MGNIaFFucWVXU2s2UlluUUFvbC94amwray9vOTkxRmpZZTRkci90OWpx?=
 =?utf-8?B?dHRnelRReEdDYlNyWWdYZVNOdUxLNExxZ2NVdENob2ZFOFpLa1lEMlczN2tT?=
 =?utf-8?B?RjhYNHpWQVNOcXErWGsxbDN0aHJXU2dpSlJHL2o2ZytSTmlydHJQYWFvZXhr?=
 =?utf-8?B?Q3dXMEd0YUw2VzJmdXhpR3RTWmxVQTBrOUJyQllXZlFLc0xmMDBZU2RzM0Ja?=
 =?utf-8?B?YVFGdnhzSS9hN0pWdFFnRTc2T3RrcUFEbmRKYitOTFhoMXk2eDlaeE5ndGhi?=
 =?utf-8?B?Zm9QZXlDeFZhUjNoWmpLN0N5RCt1TlFGd1FmT0loV242cE1SVjJHSFdEcDEv?=
 =?utf-8?B?MFdVV0pIVWxRMGdiU3hQbVJxMU94YWZqTk52RDVXa2d3YlFERHArcTQ0MXRE?=
 =?utf-8?B?MUNBRGpOeWhEQzR6NUNQeittZGY2SWFmNWcyS09KVnhBS1o2SUVSVFNWdkVG?=
 =?utf-8?B?d1hmRFZ5Z2xmTFhabWxLdEhpakhKemcxVTh2YkxGUDFkclYrMTJ2RjZaT2hx?=
 =?utf-8?B?c3dJN3hTbytqRDBOQUZ5SUxkNWJOOW5qcm16dy94NVF3RTMzQnIrbnhxVkx1?=
 =?utf-8?B?TGU0dGJOb3g1WHpCcE93RlhTQXJUcmJNQldSWnIwUnFLbmRldXhJUGNOaXM5?=
 =?utf-8?B?SVBuQ2o2N28wTTBNQ3pVVk16K2pwck1rd0JSbFgxOSs0WmdENmpOUEVIK1c0?=
 =?utf-8?B?VmJJMVRpelFDdXEySkhQNWRkdmdvNHdsUGswRDBvbGtHd3JsMElXMzFocm5w?=
 =?utf-8?B?cTVVemtXSmkycy91ZWpZMDJnaWRZdnU3c2tscC93Y2tBSWtYRXRYTmttTHRE?=
 =?utf-8?B?eUVkS3VXWUtPcUh4RzRYRzhpZEpVODhmeVA1OGpBZFU3VndVbWNBaTFDb2s2?=
 =?utf-8?B?UWgzc3ZpbFJUTzVkczdXaHFJd3ZCbVRFVVJGd2xrZUhPOG5rTEpSOXRuaWVK?=
 =?utf-8?B?T0RRbThLc2ZTSTJxd1VZTk4rUk5OOGIyWG9Cd3VCeDF0M3RNNERvZUp2bGV3?=
 =?utf-8?B?Vm9yVG1IcTNubG9ycmtHa1VYbGdIczk0U082ZFFzUFA1RTU2S0prRGl5M3Nt?=
 =?utf-8?B?OFczb2NoRVFRd2l5bnh3TE16N3VrTkR0VnFNU0lVYVJWa1RkdDA0bXQrckdK?=
 =?utf-8?B?MStFd0hEV2NqdEw2bWFhZmtKeVNYMEhzVmVNUjA3dlJ0ajhMS3hGL2R4L0NO?=
 =?utf-8?B?UDl6OFRBbjYzMWJ4cFE4UTBjTkVyOVNMb1hTUC9DcmVZdGVZc0Vwa3F4Tzdv?=
 =?utf-8?B?SVMvZHhkTTZBNGxkVk8yQWw0Z2dZbDhjS2dEbHdJdXFpUkNsZUNMTjIyL29u?=
 =?utf-8?B?Sy81TEpMajdzQ1pyZHI1b3BtdityWU4xMnFMekozRGVnbEE0NjQ0NTJwZkJJ?=
 =?utf-8?B?cWNxenZ4alJhdjltZDJhcFJBcERPTmhGSVZQb2RFRXI2SWlpRVZ3QlNzeGJZ?=
 =?utf-8?B?K3htdFc2TGN5c0VLcER0UHpwT3NWNloyU082VkZiazdrVTVkb25MNWxnZXRt?=
 =?utf-8?B?SHBsc3RLVVlYY0xLcHY2alh1WnhDdENKenFsNUNPVzNDVUdiNDZnUENrUTlD?=
 =?utf-8?B?N1QybmdmNk15V3NJcGJPRDRPblRMU0ZKNjFiVWVIMmR4SWJLVGMwdlpjb0gr?=
 =?utf-8?B?MDJjNWdTZVZPd3poSDFzZW92dkZhQXR3d3BoTHdpSXg5VkR0MHZtK0dlbTUv?=
 =?utf-8?B?YVZPY1Ntam5DR3MvS2I3RVNVT3dSMWY1Rzk0NVZIVTFVRjhicDcwTHNuV25t?=
 =?utf-8?B?Mm5IV0FwdS9xRktpcXNxTk1Ob1JKL3VXRTZJTGloYjYxS3g3LzVFZ3dTQUM4?=
 =?utf-8?B?c3Babzd2YWNkYzYzOXRiNzV2aHI4c0xmS2hqQllMYm5Kc2pOYS9ISDZxZWFZ?=
 =?utf-8?B?ekN0MlBFUzdENFVuTXlyYTBxUThjd3A1SVJTQU44V2tRTnVnUzNLaFlkNkcz?=
 =?utf-8?B?cS93bXBxQjNEb1NvK1ZJY0tocUx5SkVKVE8yQno1RkhpQ0IzbmpDbkxDSFNX?=
 =?utf-8?Q?SQxAlT6LVO7oQQ1637tDiE7kv/IZscjsb9sGi2iBetfM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde3d5a4-081c-4203-d0d1-08de20c5bdc1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 01:57:59.8646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5uSWeBlO63273jjimPLGEtGBUNCScl0U2/Bv3nZj1grPFr9Bim/D77GeK8VEtig+Flj/0B2VYnUY+4GpWQyIWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9752

On 11/11/25 10:34, dan.j.williams@intel.com wrote:
> Balbir Singh wrote:
>> On 11/8/25 13:32, Dan Williams wrote:
>>> Commit 7ffb791423c7 ("x86/kaslr: Reduce KASLR entropy on most x86 systems")
>>> is too narrow. ZONE_DEVICE, in general, lets any physical address be added
>>> to the direct-map. I.e. not only ACPI hotplug ranges, CXL Memory Windows,
>>> or EFI Specific Purpose Memory, but also any PCI MMIO range for the
>>> CONFIG_DEVICE_PRIVATE and CONFIG_PCI_P2PDMA cases.
>>>
>>> A potential path to recover entropy would be to walk ACPI and determine the
>>> limits for hotplug and PCI MMIO before kernel_randomize_memory(). On
>>> smaller systems that could yield some KASLR address bits. This needs
>>> additional investigation to determine if some limited ACPI table scanning
>>> can happen this early without an open coded solution like
>>> arch/x86/boot/compressed/acpi.c needs to deploy.
>>>
>>> Cc: Balbir Singh <balbirs@nvidia.com>
>>> Cc: Ingo Molnar <mingo@kernel.org>
>>> Cc: Kees Cook <kees@kernel.org>
>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Andy Lutomirski <luto@kernel.org>
>>> Cc: Logan Gunthorpe <logang@deltatee.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>>> Cc: Vlastimil Babka <vbabka@suse.cz>
>>> Cc: Mike Rapoport <rppt@kernel.org>
>>> Cc: Suren Baghdasaryan <surenb@google.com>
>>> Cc: Michal Hocko <mhocko@suse.com>
>>> Cc: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
>>> Fixes: 7ffb791423c7 ("x86/kaslr: Reduce KASLR entropy on most x86 systems")
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>
>> P2PDMA requires ZONE_DEVICE, Most distros have P2PDMA enabled, you mention
>> smaller devices - are you referring to kernels/distros where P2PDMA is not
>> enabled and only ZONE_DEVICE is?
> 
> There are 2 considerations
> 
> - Occasions where P2PDMA is disabled, but ZONE_DEVICE is enabled.
> 
>   I started looking at this after a report about CXL failures with KASLR.
>   I do not have the kernel configuration for that end user report, but I
>   can only a imagine it was indeed a case of CONFIG_PCI_P2PDMA=n and
>   CONFIG_DEV_DAX_CXL=y
> 
> - Occasions where ZONE_DEVICE and memory hotplug are enabled, but ACPI
>   does not publish any hotplug or CXL memory ranges, and BIOS did not
>   find any large PCI devices at initial scan.
> 
>   In this case even the default 10 TB padding is overkill and more address
>   bits could be consumed for KASLR entropy.

Makes sense!

Reviewed-by: Balbir Singh <balbirs@nvidia.com>

