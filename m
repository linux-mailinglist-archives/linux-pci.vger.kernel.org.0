Return-Path: <linux-pci+bounces-28073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46973ABD218
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 10:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234CF1BA1FD9
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 08:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24E8212D67;
	Tue, 20 May 2025 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0SceTs8c"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CFA1E0DCB;
	Tue, 20 May 2025 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747730144; cv=fail; b=tGLaijSa2IRKdC2rOzf0OPRJjRPV5gWgfyjvLqqicx4lQjVnHwKzOvBphAz33NRXSdUJ4V49QSEhPaxfYdttUV85++cVQ+2xkQVp+bU1UqX6CZ0fdYA18rySDrtKAmxUr9uXSbXS52z6E3pjInxgqQYeLtxnUz3zO8AI22WwwqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747730144; c=relaxed/simple;
	bh=2HxhAfz4z1X49G8axpVI6QP+PxJsNXAJuYi+XeIw4zI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lwfo24sL2pACueD07GKbplJu7RqtRXyjDy7RJGzbX3nJf4PjlRU6ZawuFmrK33MPRuEvMEYTyTQ0SqOlIenejnZ3fXnk2FK/Hkxl617qZFn2Y964MF1CwEPtsNhvleUoxgYHmx3jG2peoHQsFRDPcuTyTNSMH0CxwbOT1+I+m50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0SceTs8c; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xuW1faW0vezSnf38GNMvtLDUNV9oXrZ/RFGI2/p5PsRwGJRR12lrVXlUMg0aZ+TWlasrlXKP75O08ZSw6RZ+b0/OP3vTSNyhvMnSxeZwUY1CcZgT+69zmYGrkHFDe23bQLUMDWmokqAEvAXzr2HG/jDAZlw/9GpdYcHiLL6eP7wVarzCUYTlJFpTs/H62ZxpWJJN5qPQ+1aRbH2BXq7mrVHJnNOa1HTGQFDfLu0g0ekcTeMkkXLo/DZ2mNWxSRyCN3rl7lb/XhvYN9/WOuWuU/3Jrpl+d17p6lKswicy/qMYr/FpJZKYQ3A+umVjORiydvyJOaLS3Tqt4EG2qSgEQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQS48q4Vpa2pznaevv91ePHNkE3c08OdMleodWfTGZI=;
 b=JAaD1l2Y4FDWgU4LLuJ6pYo0s3MjNznEtguvQ7SLZ9ca/xD0SZZFmE1CuEe19CxrE+6GqKFTwHaN+m7H4in2Glnyh21CApGvWDsNMOm053yVVfkhiiD+FBZZJk5mZ7usCIXNshsW78vfZOc985saspnymZm6YvsW7KPI4O0zLmGSasx8QQKK6f0mcLQbiPv6JEe/b/mFCh9Xd6UWyC2Qc1LbOr4u7aHFZqhsfg/UbCitDmdOKLesdeCg5KGM0ukdeWpegaH8Bl73fOLqjZz4RGGIA1O7xVXlAib06kNV59SLy31KPthPnRAOV0AJKjtkedf1vYDy/MichByxhLuF7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQS48q4Vpa2pznaevv91ePHNkE3c08OdMleodWfTGZI=;
 b=0SceTs8cSIiXosgWBzr2BxD/rTyCrtSa2wjjnBVqkrjzBUqtLygplRuZGuNOg3S+52nE0o6h8uZo8LLpKQ9uQ3Zq5H2sE3fnRfcf+zd1DEc/wf0OInxaydKrUidT2E83aKEoiT3yl7rqWw4Rm5ahPg5OB/Vmn5QeC75tQZIB93s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DM6PR12MB4467.namprd12.prod.outlook.com (2603:10b6:5:2a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Tue, 20 May
 2025 08:35:40 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 08:35:40 +0000
Message-ID: <dab69e0c-37c2-41f1-a9db-fe116fe4cbbd@amd.com>
Date: Tue, 20 May 2025 18:35:29 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 00/18] PCI device authentication
To: Lukas Wunner <lukas@wunner.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Bjorn Helgaas <helgaas@kernel.org>, David Howells <dhowells@redhat.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 David Woodhouse <dwmw2@infradead.org>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org, linuxarm@huawei.com,
 David Box <david.e.box@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 "Li, Ming" <ming4.li@intel.com>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 Damien Le Moal <dlemoal@kernel.org>, Dhaval Giani <dhaval.giani@amd.com>,
 Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Peter Gonda <pgonda@google.com>,
 Jerome Glisse <jglisse@google.com>, Sean Christopherson <seanjc@google.com>,
 Alexander Graf <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>,
 Eric Biggers <ebiggers@google.com>, Stefan Berger <stefanb@linux.ibm.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alan Stern <stern@rowland.harvard.edu>
References: <cover.1719771133.git.lukas@wunner.de>
 <2140c4e4-6df0-47c7-8301-c6eb70ada27d@amd.com> <ZovrK7GsDpOMp3Bz@wunner.de>
 <b1595ceb-a916-4ff0-97bd-1a223e0cef15@amd.com> <Z6zN8R-E9uJpkU7j@wunner.de>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <Z6zN8R-E9uJpkU7j@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0095.namprd11.prod.outlook.com
 (2603:10b6:806:d1::10) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DM6PR12MB4467:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d4d1607-ff0d-4489-dcad-08dd97794d43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bm01QWtickZ2d2xIMTFnK0ZiNUZ4YkNMMUp0Ri8wMkpLYVpUUyt4aVdycGNs?=
 =?utf-8?B?dHZ5OURzNkJISE5NZHptdStaNVo0Zzg1OGR5cjV3dXhUOXFmRm1JVk0wdjFV?=
 =?utf-8?B?Z2V3VVYxekJ1YTR2RmRGNHNtaEp4RUZuRlJBM3pQaWNsZkRWcDJnYW1aUFRs?=
 =?utf-8?B?V3FkeFJXR1R0SDd6bzN1N1VHOHpqMGxCeGdPczBNckIwaFZGRGhqb2QrT1ps?=
 =?utf-8?B?N1c0VWRDb2FBbFh2SUFrY3FQMmF2SmhCRkJjL3RHRFNjbDRkU1RCNW1xNVY1?=
 =?utf-8?B?bTBxQVRPc1k2UU5OaklJM3g1WnBaQmtSTGVCNDYrRElNR1AvZzR2Rkp2NHZG?=
 =?utf-8?B?em90RGxXdDZLeUVxaTcwMjFQVjh1dksxZmVXbzRBT0VsSmp6aGtBa2VYeE5t?=
 =?utf-8?B?NE9JOXo1K1hNSmZQbWNubTUzMFBtajJLZG9LbGtLTmZpdmo0Y1hmbVJSSko1?=
 =?utf-8?B?bTdzRk9MekxBQTYxR1BoeXRadkJMajB5cDJTa3ZRbEJSZ1owSHFkNXRWVktt?=
 =?utf-8?B?T2Z2MkJOcVlvNGVGVkZuU0JEUzIySy8yMzZjZ3orUUx6QmhZNHZ3NHFvdy9C?=
 =?utf-8?B?YnpOZXZOeTVIdzFreEpCVnNSRDN1V1QxeC9nVHVya1pQeHZjR29lYlJ3RVFj?=
 =?utf-8?B?VGVKSXJwSHEvY1BBR3QyQ1hFRUdTcVpUclV6SGhyQkMreVpnWHZ0N1BzYVE2?=
 =?utf-8?B?OHhIZUxydUhwRkRDaHVScGIxTkl4d0pFbUlkOXdnUmN5b1lXbEptYzRrd1ZZ?=
 =?utf-8?B?MDBGTkhyN3JPd0ZoaStjUU92ZjJZU2g2dzdhS0x3bGxUNTJ1YXhXVlRwVk1p?=
 =?utf-8?B?M3NiZFoyNERuNFR6MDFDbTlrRWlkN25CNWdRaitiZmczZFA3SFYzWnkzemY4?=
 =?utf-8?B?ZWNvZlhlM25HMnN4TWVlbkd6d0J6VkFJTzhYZkZLM3M3ejQ0TFdPcUhsRXdQ?=
 =?utf-8?B?K1N1ZzRZMSsrNkE0ZFE3ZG9zc3dCenpON2Q0MVRkalRFWGI4UUVOdE5EOERy?=
 =?utf-8?B?SFRxVzFwMVhSYTVTT3EzeUNKeFNwdXFhazNKVVF5TjBNQlE3czZ4Qjl5TmJN?=
 =?utf-8?B?V3JMdDFMZmZ5K1ppaTFvTktXaVYvL0tGSjVzYnQ0d2Y1MW9lSFNNQmRVZEVy?=
 =?utf-8?B?TlpGdWVnc3IvSUp2L1BUTTJFdklKRFkvcmhXM1lYSVhHWFdpRytLYlRSRVRn?=
 =?utf-8?B?U2lkWFR2S2g4Tm9IOTROSDFUakJHajAwUk94YzJPSUJxMG0wZzdXak1zYSs1?=
 =?utf-8?B?QmVOMnJzOC84aTdWZFYxcFRDb3hoSUgwUTFNK3M0NldFL2c3ck5VQU1PY0Ri?=
 =?utf-8?B?Y1ZET0FnWmlJYWs0cTdqVnlVYVVyWWxjcEV1S0FDditwS25HSDh0RkpJUHh1?=
 =?utf-8?B?RnNDK25RcldWNE1kU2E0cG1XQlJkNDQ3UHNrSkFSeXF5YnVSc3AzVk90VWNO?=
 =?utf-8?B?VjdIZDVTbzFGaWlYYXB5OWNrcDJrTlppQ0Vqdk5wNjRKQ0hHWWE5SS90V2g0?=
 =?utf-8?B?eTlxN1R4TWM1a3RQYURjMWNodFl0RDNFcFhLM25ER01ua3MraUYvcUVHRTFU?=
 =?utf-8?B?cTJnTUFNR3RvSUNZbS9oeG9SL0lITURnVWF5d3duYnBDa0RKeVliTVMra3NU?=
 =?utf-8?B?RWRrZXNyZEZlMm5lYkdmNlpKa29sQUJSY3RmQjRxaDFPTW1WL2pMYjArQWZs?=
 =?utf-8?B?aTd5Vk9RUlFRWFJLWGE1VVhyM1NXSkswSll5ZlBQT1IzTWUxQU9rSFlKY1FS?=
 =?utf-8?B?Q3BrVW1yMW5UamJCOXN2QVh0eDVkYWVSZE5GeFE1S2VUbUVQN2JuU0ZCVVRx?=
 =?utf-8?B?eTdDcFdvdkwydExnMkRoaDh5U2R5K0VYSGRjQ3pQTGV5aGZJQ0lPWWUwT2hZ?=
 =?utf-8?Q?i05HS2nv+Duax?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHJRTEQxd0NiRWQ3SzBmRE1zRXN0WkNkOHdoK01vWHQwUnFMLzVDQkdjZ1lC?=
 =?utf-8?B?Y0N1NnNHU1B6TzBrZElwZWNHbEdhcWJ5Z2t0WDM3WGhObTVLZFV6dFdJTGRa?=
 =?utf-8?B?Kyt3TWlZS3pxcFk2RVhJWWJkbE82V2EwWkpodVNQQ2s3SkhkOVNMR2t6RFhp?=
 =?utf-8?B?OE4xRzJ4eHdBcHY2c0ZJbEZTVHhSZGdEcUdQU1IvNytSVWE2eU5ZL3VPeDBi?=
 =?utf-8?B?OS83V294YUpwVTlJVGdRd3VQdFh0SFlXWnFWWTNHMDRwREFRSGxUc0hBLzNY?=
 =?utf-8?B?Y1FYRlpiL25uS0o3V2JNQU1YYjdqNW91TXNyak9IVkp4YnJrSVFYNlZxZVVl?=
 =?utf-8?B?cG53N0w1aFY1bGpsT2lqOE9naGlRTThra1JNYUQzRzhGRGw2VnMxdE9KR1FQ?=
 =?utf-8?B?Vy85aUxSdjlPd2EycHM2ZG9melAyM2trMmhIYUc0UE00NTJKMmhZWEVuWVhI?=
 =?utf-8?B?aHJIUkRxbW93UUxBaVB3TCs2bG5SR29UeDg1VTlTS09UQUxhNjJncEJQeW1J?=
 =?utf-8?B?SE53UGdmcDIrbjJQUFpnR1REVGpWWjQvNk5xQ2lsYlM1Qkp5ZEN3NkdnakJu?=
 =?utf-8?B?Y1hJZG82c2N0dlpmV2ZtaWNEL3pBYllIdmtweTk4N1RFTnc4R0NUYWZRWmg1?=
 =?utf-8?B?M2FlR1RuaWdNcnU1L0xHR2dsQXcxRnJJNFcrRUVpMHhvWk0zajBRV0NjN3R6?=
 =?utf-8?B?K2hSNzRBWG91am5uRkw0MGlYdTJnUWl0amJtTUU3SWpjYkVQc0pwR0tIMEdO?=
 =?utf-8?B?QjhmZXA0dGJRblpDVVNPbjRGZVNQZEVrREFRSDQxSWtQWVdTWVdHREhiYlEy?=
 =?utf-8?B?b3d5YjdKRjlseVdiMGJPTDZqenVjVVRtMEVTUVlkb3l5dWpOMGJYOEFyaHl6?=
 =?utf-8?B?ZHdpc0hwUW85RUUxcmlpTThNNC82L0k4dVJmRHFUV2Q5N2laUnl0OWZyS0tF?=
 =?utf-8?B?TTlROWVhMnpHcXRYa2Z2bGtmMW1zRGZaSHQ1djNKTldxRkZ4K0dlcVk5NGtY?=
 =?utf-8?B?eFVvV1hiWnQxSS9zVmYwb1dQRVZyYThuMHlCaGQrcnluOUdSZWhyaHdMNndk?=
 =?utf-8?B?bm85OWtKbmpXZUFIOUpIVThEWFN3aFc5RURjZnFPZ1MwYUlpRGJNNjc2Qzdu?=
 =?utf-8?B?WEhmaTVmWHVWck9QK2R3T1RyQXUxTjlwdmxKQjhJMW5Ddm1EaFFNVmpuQ2VF?=
 =?utf-8?B?N0ZBKzJHb2ptcElQTjc2TkN4TmxxOHJoOHMxQVB5TTF5T0NkWk9YVmFsc1R5?=
 =?utf-8?B?eDlPcyszODV3WGVSc2hHc2QxeVpaR2FHU0xUWVlTOEdDelJqU3lpMno0MVBz?=
 =?utf-8?B?ejBtdHE4amhBZ1MwN0xkY094NVVybmdPN1c2ajIrODl1OUptV09HMFNWTHZM?=
 =?utf-8?B?WnNZVkg3S3lBYVZtc2VQcmZkSCs0bmVYWDIvdWRCdUVrOFFoc1RGWnFYNk9j?=
 =?utf-8?B?U1AwcXQyVEU1c0lWUnNWMmdyLzNKZGdyc1ZrbmJJTlA2M2pVZWw5WFVteVdC?=
 =?utf-8?B?emxLaEdzZjhnKzBza0R1S3dUMmRzTE1tSUhNT1dweWRBa2VIQS9QRzZSRGI4?=
 =?utf-8?B?V0ttVS9YZ2JrNWh5WnVlRVV6TC9zVUpNbFZtVEp1VWprNGJLWGxWSjI3d3ZN?=
 =?utf-8?B?N01EWE90cW1WMGEvdmovaUdrNk9JUXBTYnZENVFIdzJnSVI0cWwwTVI3bXpH?=
 =?utf-8?B?Vk80RkNmaWp3V1BoZEcxdmd6QzROUHcvbXFpOUd2UlFKTnBoYmdSVzIvQTho?=
 =?utf-8?B?MERmUmJEQU9hYmFMQ1FTTkJMcDV5c0l6Ny80WXRONExZVGl3WDdQOGt2M3FW?=
 =?utf-8?B?KzRWMDhqY2w3SFBRV28vVVVpNXVKQWRvSm9idHZidDhsTG9GaDdTRE5GNjRx?=
 =?utf-8?B?M0IyT3NXY2d2RWNvQm92VmFvZFQ3Q1BJUW5GQjd5NllwdlpBUE9NTCsrQ3dJ?=
 =?utf-8?B?N0J3WmJUUWxVb1UwNC9mSUdZUU5wWnVxQVMzVllIRkgvUnQyb291OWlDS2dV?=
 =?utf-8?B?SEdzT1RPbU51MU40MnUwOTlQT1dqSEh3d0w2UmhpbmxsbnFDc0lzdVlpVFM3?=
 =?utf-8?B?ZEN1eEdzMkhDWHhzSU43dE5YbnJ1c1VOWVRvTnJDdy81VDZXMlA2eWdzK3dW?=
 =?utf-8?Q?2+LFok2O7EwDFpJVFT41cOI0N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4d1607-ff0d-4489-dcad-08dd97794d43
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 08:35:40.1183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5d6Uzul23hOOfHKtMXFOCGWzULDRiggc82qoA3bIfEZ7CH7BSiKr5G6N8ngpi4w5kxXwaUnnoeVGAGNy9VUjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4467



On 13/2/25 03:36, Lukas Wunner wrote:
> On Tue, Feb 11, 2025 at 12:30:21PM +1100, Alexey Kardashevskiy wrote:
>>>> On 1/7/24 05:35, Lukas Wunner wrote:
>>>>> PCI device authentication v2
>>>>>
>>>>> Authenticate PCI devices with CMA-SPDM (PCIe r6.2 sec 6.31) and
>>>>> expose the result in sysfs.
>>
>> Has any further development happened since then? I am asking as I have the
>> CMA-v2 in my TSM exercise tree (to catch conflicts, etc) but I do not see
>> any change in your github or kernel.org/devsec since v2 and that v2 does not
>> merge nicely with the current upstream.
> 
> Please find a rebase of v2 on v6.14-rc2 on this branch:
> 
> https://github.com/l1k/linux/commits/doe
> 
> A portion of the crypto patches that were part of v2 have landed in v6.13.
> So the rebased version has shrunk.
> 
> There was a bit of fallout caused by the upstreamed crypto patches
> and dealing with that kept me occupied during the v6.13 cycle.
> However I'm now back working on the PCI/CMA patches,

Any luck with these? Asking as there is another respin  https://lore.kernel.org/r/20250516054732.2055093-1-dan.j.williams@intel.com  and it considers merge with yours. Thanks,

> specifically the migration to netlink for retrieval of signatures
> and measurements as discussed at Plumbers.
> 
> Thanks,
> 
> Lukas

-- 
Alexey


