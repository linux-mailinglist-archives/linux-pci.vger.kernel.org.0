Return-Path: <linux-pci+bounces-39837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8BBC2171D
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 18:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C49A04EF553
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 17:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADCB3683BE;
	Thu, 30 Oct 2025 17:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RrJbrviU"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012024.outbound.protection.outlook.com [52.101.48.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189FB2E339B;
	Thu, 30 Oct 2025 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844576; cv=fail; b=PCYM4GRg41tPPk5uYwGqJRUFq7xvwZhhLMOAlINZUixQZ+G7bZlWXE0ZnAyAswCCn5WBBRpKB7/c732lD03uUcjV2jySN3KdGpiB8ejH7BXmA0T+JYwM9V8+T0WDassyzzT0157ZebJwZn1eOgGAJETe5+tJBQlNhrjPbaDLu9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844576; c=relaxed/simple;
	bh=gRBVrszdIO5CVdoe5azvD596ZhIDqNklCOp7RrQ2jDM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q66FgcCqem+CiHBdBoeJkMUBrrqea73FUhfuYsNT9aHqJZbaR13uY55SZcCiC4HXHrppUREA9NCtdawe5zv8cEckfvz5fCpvVUzEcUzyvAooaR5e4K8rdN9uNwv2vxmLIZle6HgyLsJcrEslfCZU+oY15d7ds8X8Gp/aSikBnQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RrJbrviU; arc=fail smtp.client-ip=52.101.48.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvACGcS5loP+lwPRsh3D2RqzFJ7xIWV2heAUC/JwFhHtlWDM4f1dj+xy4JtPbC6CQYRBvvTRQ/b0IVuVhBILxJux5Cj9c0F/5KxnC82vTlc8p/BSW2wNQiODXMjMPNtwSoddLofas1mDn1chustOx41UyhhxREXRaaYSQcY+iW1z2+RtaaCL/RaLfPZcIUtflnsM6SmKcQOcwiqOIX/PPedOx5xCESKh1HQexGpPbY7++EKkrc5abHmzu/o3D+LwsyWycVzH2pgZrWTpwFnICrPPsKYVCfrl0plDTLf0UiH0SrrnUYJhJV2gtye/NRlSvx+lidOzojUJiejO0KaRng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KTOjt0ApASogAqFrvl8NsnLLu/N00fmcruaoeb74NA=;
 b=Q22rynL4vEhqaf29IQC23IY1gX8QhdVYAvJ28UiKB6mIY8lYV4gYcV1AWqnUheIB8kYe7DuH9HEzInkeohUot19mfcUPOSeYYb+6DLorqmSp+jFLWHXz6q8ONbwQk0ZLDexUQgUsKjpsCJkA4oEDWdtzfpD1WZaPI6byZnaFxRLaUVl1kMLvekFxyK0zG/oXJbEVqyo0hT9zUrfj5X1fhJz1e7ZAikU57rP4RV9SN4acyjpiSg+o8017Qop2wPv5Uex9BSxl0kXFq7O8AYBJivLVndjUgvEHDFiV2fOE68u4XE6GiHBfVIBF4080O9SHX1I281PMTapdBLyVllVleA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KTOjt0ApASogAqFrvl8NsnLLu/N00fmcruaoeb74NA=;
 b=RrJbrviUOng1FrMbE1IDuOJ+DJs6+hrtRgf+FYfQ9J+IY735YWVjFVMpQGmibJG+7aAzsYyTC/XMQAuuPmvALeqrzhDamEClrroYfNB1C2c7EZHf4SfXH05SOdsmDea+PCcBfYYRerI9kTQX8Nx9dJ1DPBI95A5MYXTSkB0C5rM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by SN7PR12MB8103.namprd12.prod.outlook.com (2603:10b6:806:355::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 17:16:10 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 17:16:10 +0000
Message-ID: <639cb124-4c92-4d10-a4ce-78d6d862060f@amd.com>
Date: Thu, 30 Oct 2025 12:16:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 10/25] CXL/AER: Update PCI class code check to use
 FIELD_GET()
To: Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 alucerop@amd.com, ira.weiny@intel.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-11-terry.bowman@amd.com>
 <20251001171216.00005fa0@huawei.com> <aN4sWxjrzxeCyGBO@wunner.de>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <aN4sWxjrzxeCyGBO@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR18CA0015.namprd18.prod.outlook.com
 (2603:10b6:806:f3::6) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|SN7PR12MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: 00472e6b-b5b7-4dea-f20f-08de17d80505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkxzbEN5bkZ6dW9BQ2xhb1llOWMySWdvRVNPT0FRK1lrbGMxT0poNjFqbDAx?=
 =?utf-8?B?MW1wak4rSDdnY1VHS3VlWDRXT2tLTzAzRW8vSnUza1MzazFsZDROWDZBelRu?=
 =?utf-8?B?K1ZrK1orSTVnZlhDRVAwNlVrSlZrcWU2cWtJRGFOMFh6SUpUU3g1eXpqYkdj?=
 =?utf-8?B?TGpMODIrdkVuazZ4Mk1GK0I2dU9JSEhkU0V4WTlnTUxQRENxdUszeXk4TGVE?=
 =?utf-8?B?T0ltaTdCSEhEYUtFeCt6M2JDOWJCZDZyQnROcnFKbys1NXlYdnlybzJWdm52?=
 =?utf-8?B?Vm9xeFkwd1VBOVAwWFpKNjVBcjFpQlBiNUpxVDd2MjcraXdJdU5kd1lvVk9k?=
 =?utf-8?B?T0p5QWlyNHRCUXNBV3paNHN0TnhnRWJQdDI5WFdnaXhUeVVGZ2F2MzUrZ3dp?=
 =?utf-8?B?eGgyMTZHd093SHNvTXIxNlpjUTF4TWNyUDBqem8ydnRSUEpLMmZ4Y1BvVVVp?=
 =?utf-8?B?L2J6Yy9mRlUvWjVmbnEvZENRVzBvQlhHeFRENmVYVXJ6dmt2S01WNGY0NzYy?=
 =?utf-8?B?VUtTZVN0Sy9tbHBkTCtRNWsrSzFtSDlqNnJXRmc2eU1LK29aSzh0Ny9iY2ZT?=
 =?utf-8?B?Y0s1Z2xCQnpQeDBVTVU0R3NFOHJXakc3MlNCQnBMZzQyUytZZkpMa0xlbVhy?=
 =?utf-8?B?OG4xcng0RGRTSnc5YnZsaDYwZ1ZtemppVVV6c0tlaFRxNHAxNEREWFIvV2Nl?=
 =?utf-8?B?NGJ3NTlJQlpLdUk2cXhFV09LVlREY3hwR29hUTdXMkdzelY4anA3REdJVjBU?=
 =?utf-8?B?azRGUVB4SEhFdzMvMHl4dWVBMHlJZzZPWE9ZWGQrR0dmQTJjSGYwdjZqRGhv?=
 =?utf-8?B?ck82UnRKcmxHYlBrSHgyM0VyNHZMQlZDOVRpeVZRZStlMWdhcUFMcDlhaUlI?=
 =?utf-8?B?Zm5ISURBK2RnTGpYVTN4bDRqM2VGQ0lzMjROOHRId0I4ak04VTdoOWpYU1da?=
 =?utf-8?B?MHRLd3FJR3VacFE5cWxmUlZZYzI3MDJIeTkyTXYxdnQ3RVlubWRYRXpkMDJZ?=
 =?utf-8?B?RFlHYXlod0xoM1dCNnlBMnowd2JrRFVPWVlMQk5od3RsT1piTVNGZ2tqajZ5?=
 =?utf-8?B?YlZpWEk2S3pGdlp3MngydzhrWGtldWJZcnFCUzhLWC9jcW5ETVJJc3F0ZGlO?=
 =?utf-8?B?WTF4RFNIdXBzaG5xUm5PK3h5bmdGcmIvek9SVmE2QmtMNFpuMHJPWTNnZzBU?=
 =?utf-8?B?N25WcTVjWjZ4c3FzWFduZVEraURtN1pqUXhxYjVqSFJiNk9XS0E1SEE5Q3Jo?=
 =?utf-8?B?S1c5d25DTEVGZ05NeVN1OGYySVFsTzliK3FxcUVhNENzODVLaXppbkxPR1NQ?=
 =?utf-8?B?VEgzL0JyY3JTS01XbjBDR0NOVTNzUGR4UHZHSkl0UDlZTkJvNGw3ZVR6a1or?=
 =?utf-8?B?aXRRSzBNZGl1TEE2MytyMzdFME9NR3ZpbHdwU0hXclFKNW5XSHBpUmczNWkz?=
 =?utf-8?B?dFBqRzgwdityOWJWOE5FQ0JCb3EyTVlyMkVWeEc2a2lKUE83a0FKOEd6VWhj?=
 =?utf-8?B?K3BibVdiMERrZ1E4NnFVcnBLR3NYN1BxOW0vRjBQakp3RmYvNHMyV2N2S1JB?=
 =?utf-8?B?THNRd0R1ZzdJVEZnVnovUjR1ZUxGMWptVi9jMEtKcldZTEdNTU1sd3VMNjJU?=
 =?utf-8?B?RElnWU51VmZrZDFvUVR1VW54aDVPOWFhbW00MGlCMndITEVMbitpcWp1UTNE?=
 =?utf-8?B?TmFtdmt3bUZRTi9tNzdDVDhQTzNXS2FVZVNtUGRLRkhGZmZRQlFQMTBYNUN6?=
 =?utf-8?B?WnZkc2REZmN4ZWt2NG84NzlSazFpeFRuWE8vK2ZHbzhpUGpvQ0VGQ0NMaU04?=
 =?utf-8?B?aG1zWm5BOG0zekRIbzIxNi80RDB5YlZYbHRuVlVPQzRMTzk5UjNEdCtoT0dz?=
 =?utf-8?B?cnZMSWpLd1JsWVYwUHZDOTIvM3NqemVUbEZJdlJ6dDJCaG1YS1U2dTU4V0pX?=
 =?utf-8?B?cVlSbC9IRkp1elRMZlVpcjcvaCtkZ3ZWZ3RhL0pITktBckEvWTIzUkpzMnJI?=
 =?utf-8?B?QjRWalFUOEJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmdrL1oxby9wQ0pUY2VrTmI0dFB0eExhUVVRQmMra3RFamRKK084aXVkZUlr?=
 =?utf-8?B?Rm5HUGY5ajJyb3N4RzlpMm1rVXZFWHJ4RUdqMVpkRzVqc3ppQUJlSWQ0RGVK?=
 =?utf-8?B?UmczdGRFQUdzZjdxK3BMbllvbERqU2hnc3EwMitleHhsNnlXaG04Z3poR2dK?=
 =?utf-8?B?QU5MZlM5Vyt4aDg4N2NtMTVOaGM5dXdiRVFienZ3TjdoY1Z0TDB4UmhwUlAy?=
 =?utf-8?B?a2pxc05vVUc1Zk84WDJWd3RYVG1aakw3Y3FmVVdLVGVMdzQ2RHFqWUl0WDNN?=
 =?utf-8?B?RitoL0VZenBlMTJ0a2lFT0dGSERTWGc1QUZvcGQ3N3c0ZVFaT2hJZkVOVjFC?=
 =?utf-8?B?MSt4VU5iN293ckwvTFNXOVliOWd3a2RVTjF1NGkyR1Jpa2Y3VDRvRlZyOC9y?=
 =?utf-8?B?L0FoUDJhSm9vSjlyWVJQUDViRWtnSGFjNk9LaG5nWlNoOVFJQ1VVV004VU9T?=
 =?utf-8?B?bUcwSi9PNDgzNGd4L0pPWENQaWJJUHBMSllJSlNYYzRXMEhJYWpTNTZWYURn?=
 =?utf-8?B?eC9FSk0yVWNILzJac3lyMkFMcW9kcGQ3cG5aT0hmNzRUL0JZemdIWUxpcmRK?=
 =?utf-8?B?S0pFZFp4ZmFtdERQd01vaDZSRnoxUStYdytnaHN3cm5GSkNrT2dWeDZyT0pu?=
 =?utf-8?B?eVJIRytYTGRPSXB3WFhQZFhRTzdDdE1qWEgrUy9UNWU3dDByNUt6R21KRnNM?=
 =?utf-8?B?S2NKUVhWU2NTN3ZPSXdKd2V3WkZ6eW4wY2V2bGUyNW13d1BJZWVteDdRVkVi?=
 =?utf-8?B?dTlzUXBBWFQyNE0xNlJhZEVYVUIyZ1VYRUwxVnRueW82UkZvQ0Nvb1VNN2xs?=
 =?utf-8?B?cnp2MkJDeUxZOXRka00wZUViSG12TjJiVEExOHQ2L2Mxc3JUUUdlQW1kY2hS?=
 =?utf-8?B?ajVUcWpsakM2OGVHZ01McVpncEtpVzRVcUxNaUJPNHA3elQ0aHQ3a0hLN043?=
 =?utf-8?B?UzlpYVhpclZBcTFCbiswcWlxakNReG9NWXdjN3orSXRHRFNVM2pQN0pPM21q?=
 =?utf-8?B?eXNLbGhncFh6MCtVS3Z4ZEV5cEtScWdmc2RReVM3WXptUWNEeit6U3V2aVdE?=
 =?utf-8?B?WHM1eklaT2kzWUxRMHhTYUt2OXVTM292c1RUaWJTQWZ1TUlRNDVtTnRaakcy?=
 =?utf-8?B?cGNudmtSNkxlU212TzIzYmo1ZG5lYUFONUxPRWNrZFpVazNvakdpWkgrUmFI?=
 =?utf-8?B?Um5SY3Q1SU52eGNpQW5tVkFYdjluT3dhTjRDOC9WblZqS3BzR1dQeWtjQmM5?=
 =?utf-8?B?NW1MbU5ncXcrRFZpcmJwd2s3WE9yd1BFTFhwcDd5aEtTLy9KUDlheVNXWnRE?=
 =?utf-8?B?dFJ0QVprc2VkK2tQR3VNbG5ONGVWaGxGRVlrMUhnQm5Za0djTnl4Q0lZeEpT?=
 =?utf-8?B?Z1htOUQ1d3NUQXppNWNKdUNEaVl1U29IV3FqUVlxVkRvUitVd2JQOTlNcVhG?=
 =?utf-8?B?SjN2ZUVoYWplb2tBMWkzbkd4MEtaeFJqYm9QL1dVVEExUVFnNXpGYjU1MWZj?=
 =?utf-8?B?eHZLaXF3eVdSd1IvQ2p1bEhTZHBQMUdtcU5BdkUwVGZqbmluQTlOenRBcmJU?=
 =?utf-8?B?SGxUSkZiRUJxcHYxOGxXREJBelk2bTJ1d1BzcHdMSXdaa0Y1ZU9QLy9FbXNh?=
 =?utf-8?B?bXRJNlZCN2g5bTFSUHBKdEhwOUM1WnFyRDVSSlJ0S1ZCbW5QS3lJYTJ3QTBW?=
 =?utf-8?B?MHhweWdEeDFNVk9RbUhQcGQ2OHZUdjJGeTFsYXZhQUFuSHk1TXRiWUw5L1hS?=
 =?utf-8?B?ODhPVnhsZ094dkR1MUxzT293VWViWGFpRTNtVm0zNm9ZOHlkNERWcGVxRVJY?=
 =?utf-8?B?bGNwejNGV0YyM0RSbDVaWURXZEZZeU9oYnE3T2pLU0xwTXdQeFZydUNoR0lk?=
 =?utf-8?B?V3FIN3hXSUNORFRKSEd6c1MvMkFwcEs1Q0FiWlFzS0hINk9mLzdzcU9xa2pC?=
 =?utf-8?B?M2pncVdtVEIrem9NNFpsYllOemIyQkpHbXdXR0k5dUI1QU9KcEUwWldmVEZD?=
 =?utf-8?B?VDZyS2R5Rmo0OFFxTmxjQi9TNlZaL2ZDVnRKQm9sWjBIMHNzbDJyekx5Zm82?=
 =?utf-8?B?ckMwaE96Wm0zdWNMQVA0MGI3Q1lUV0NNenRaVzNtTnFheTBnaDBVM1hOckhk?=
 =?utf-8?Q?dVjuqTDI3RAn8Qiwl6x+nor8o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00472e6b-b5b7-4dea-f20f-08de17d80505
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 17:16:09.9307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Ptvh73VxHlKbTrL6+w5GkwRUMw/vnGA8QnQOD92fPFCUrmvHAqlkqqsjxBcZTn8sdSijsUgJ/nRZ41re+Ewjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8103



On 10/2/2025 2:40 AM, Lukas Wunner wrote:
> On Wed, Oct 01, 2025 at 05:12:16PM +0100, Jonathan Cameron wrote:
>> On Thu, 25 Sep 2025 17:34:25 -0500 Terry Bowman <terry.bowman@amd.com> wrote:
>> The way that class code definitions work in pci_ids.h is somewhat odd
>> in my opinion, so I'd like input from Bjorn, Lukas etc on whether a
>> generic mask definition is a good idea or more likely to cause problems.
>>
>> See for example. 
>> #define PCI_BASE_CLASS_STORAGE		0x01
>> ...
>>
>> #define PCI_CLASS_STORAGE_SATA		0x0106
>> #define PCI_CLASS_STORAGE_SATA_AHCI	0x010601
>>
>> This variability in what is called CLASS_* leads to fun
>> situations like in drivers/ata/ahci.c where we have some
>> PCI_CLASS_* shifted and some not...
> Macros working with PCI class codes generally accept a "shift" parameter
> to know by how many bits the class code needs to be shifted, see e.g.
> DECLARE_PCI_FIXUP_CLASS_EARLY() and friends.
>
> A macro which shifts exactly by 8 is hence only of limited use.
>
>
>>> +++ b/drivers/pci/pcie/aer_cxl_rch.c
>>> @@ -17,10 +17,10 @@ static bool is_cxl_mem_dev(struct pci_dev *dev)
>>>  		return false;
>>>  
>>>  	/*
>>> -	 * CXL Memory Devices must have the 502h class code set (CXL
>>> -	 * 3.0, 8.1.12.1).
>>> +	 * CXL Memory Devices must have the 502h class code set
>>> +	 * (CXL 3.2, 8.1.12.1).
>>>  	 */
>>> -	if ((dev->class >> 8) != PCI_CLASS_MEMORY_CXL)
>>> +	if (FIELD_GET(PCI_CLASS_CODE_MASK, dev->class) != PCI_CLASS_MEMORY_CXL)
>>>  		return false;
> Hm, this doesn't look more readable TBH.
>
> Refactoring changes like this one should be submitted separately from
> this patch set.  If any of them are controversial, they delay upstreaming
> of the actual change, i.e. the CXL AER plumbing.  They also increase the
> size of the patch set, making it more difficult to review.
>
>
>>> +++ b/include/uapi/linux/pci_regs.h
>>> @@ -73,6 +73,8 @@
>>>  #define PCI_CLASS_PROG		0x09	/* Reg. Level Programming Interface */
>>>  #define PCI_CLASS_DEVICE	0x0a	/* Device class */
>>>  
>>> +#define PCI_CLASS_CODE_MASK     __GENMASK(23, 8)
>>> +
>>>  #define PCI_CACHE_LINE_SIZE	0x0c	/* 8 bits */
>>>  #define PCI_LATENCY_TIMER	0x0d	/* 8 bits */
>>>  #define PCI_HEADER_TYPE		0x0e	/* 8 bits */
> Putting this in a uapi header means we'll have to support it
> indefinitely.  Usually such macros are added to kernel-internal
> headers first and moved to uapi headers if/when the need arises.
>
> Thanks,
>
> Lukas
Apologies for the late response.

The PCI_CLASS_CODE_MASK definition move to include/uapi/linux/pci_regs.h was requested here:
https://lore.kernel.org/linux-cxl/6881626a784f_134cc7100b4@dwillia2-xfh.jf.intel.com.notmuch/

Would you like this patch removed altogether? 

Terry



