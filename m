Return-Path: <linux-pci+bounces-19733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0034BA10AA7
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 16:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65DA3A2D30
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 15:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B46E157487;
	Tue, 14 Jan 2025 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P77ynB6Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE9B23242C;
	Tue, 14 Jan 2025 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736868300; cv=fail; b=W+BE4hMLpdtfyNcNnyuGPdknNc05XR1OdI+kabUZlLbhQ0ISBZNZ8IZyCQP72k5TDDJ/JQafP7V9/VVMzavvg0UCWbEd2k4OjkVd6EPlPMKf6ALAMqjslCD43hpgYfiWR1k8Eq5Oy9dN7rrXhoGgLpLiTtnGiI7IDCPFBuKMPTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736868300; c=relaxed/simple;
	bh=6A8lIzGXJQ2Hh7hDl1qJRVR6UyyTNK4Zf0fDoMz8FNs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iQITzr9rYbu6z2DhB0ROlyn6zP+hCP/pAA4ts+a5oC4SOQmFUmpAxLu5kBMTSa6KkeeovPqL2ibbg4osV6Wqxm2whM8HoYGQyWVNa/ckDYCCscjgvBSQoGjWCdZB39EamT/SIJxr6xzhSYRuxW4Gq9jls9mAID/4svBABsIj2O4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P77ynB6Q; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/QynXQFnbcsojxYU1UrSBk69TnZAEr64VqjbKLT0mP+bvPC88jEMRz2BoXGAIbv2UTlM32J6u7c4rh3wYQB9RiUlhz/Nua5rBM5CIuV1fNIzMkIJTHiYoctsiecZElGtZWFeAPkPdy2dU5G8Y03apDj+0GTOdKsXvi9sY34bnXA3dTaeagJcPUfpKUPw3fr34T1QTVP/Gn968uw+IYAi7kqjaL2CbEillBYd64ASJAh1DARUfm8Ha0BURkKxfR57Wdauf2HN7Xou8/yVPeajMWqtk87QzyFeUqPBWSt7Dz8DFAbvYKjKG0Ya3ZP025sDVGIwCx6LPKQKi0/eCKoLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdhqC9yTRj9bWyactL3TFgQ5SrptMJ9AclF3nv0Xrc4=;
 b=lBEYqGlwh8iZrdBsE0DesxCO0ISXYgreiEeRmb5T+RHD3i/1I+3Muo8s3LlSVQ2iwlpE5LZnFja9eO9IwhcHNLu1g8cpJh1Zsmpsic2kCZRO7HJlOSlhCd1CM/Bc4ZnF7ecAbs60otSzxtTv2nwD4Qws45IbSNqa4ZDWkeDDbRyBqkhgy6QHxfwrj5CFGL+0pEOr18thDJ06JBkm0rwlrcpkEUm4J33B9dR0yNg8YfrgpgP6ZmVlcrejB1usgXoT/tHYrUttSYzttoon3r9Y8i3GUVS6GM8Xop3HFbPM+lIZGSYyRsAb8nZ0ap1iWox7rnlsKbeR2peF3IrBgGKxbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdhqC9yTRj9bWyactL3TFgQ5SrptMJ9AclF3nv0Xrc4=;
 b=P77ynB6Q7NSd6UKLS/zcNYB0zXvQN7b3MVpyazxPI99OTN+BoLes5XQ8eiwvljxfqH/Rg5NaIkCvAasx4pxhtS7Ia+3ziGDuZBlUAJbMTAbs9o+KCj5KFmlK995FJpyqQJKs+fDNhpH5Zyix9MlNvVKDyjrR3DL4MQ9Nj8mlNi4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 15:24:56 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 15:24:56 +0000
Message-ID: <2e88ac60-b99e-46f0-b021-d88192ad891f@amd.com>
Date: Tue, 14 Jan 2025 09:24:52 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/16] cxl/pci: Map CXL PCIe Upstream Switch Port RAS
 registers
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com, alucerop@amd.com
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-10-terry.bowman@amd.com>
 <20250114113540.00006247@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250114113540.00006247@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:806:a7::6) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: 485eb4e8-af1a-42e9-f515-08dd34af99b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnZ0ZTlCWEVYOEIzOFpKMlVCYkhBTDZONTFpTzFZVVpmaG9HY3U3QXc0MHBT?=
 =?utf-8?B?aUl4eUdlZjhCY3pySFh0NnNxNEpKYUxVOHdUT2RWK3JpK3l1WDZQV00wa3lL?=
 =?utf-8?B?MXcrSHFVODN0RWY4R1UzTVZjdzE0TkFHVXNSTytYaUk2Mkh1dGJaRUl1TE5w?=
 =?utf-8?B?ZW1qVTNuQ2xqNEd2UGRUbVQyLzREeGwrcFAzQjFib2xqalVYcEdQOVNaNWtS?=
 =?utf-8?B?b2VMM1o1TmQ2NzdxdnNwbnpSUjlZZmtwby9vQWoyNnNPS1NpM3ZzbVVRNU1K?=
 =?utf-8?B?RUp1WFpRdG9ZbEJucC9ra3VuL2Z4WlZkNU1oWE9lTkVQd3gzZ2N4dzAwQ3Jr?=
 =?utf-8?B?U1VrdHdZK25OWmNreFoxRG9MdmI0ODE5Nk4wZ0hXbDhXQWhsS2lSc0Rpancx?=
 =?utf-8?B?NDArMzN3MXVpd3E3cjB6S2FaNHh5d2xCVW1MaXRMS0dvV1k1K0NSVlhIZWpv?=
 =?utf-8?B?Mmc0a1ZjUmVOMzlLK0VuRCtlV28rSEx4YjZFak5FcU5rMHErTzRmVUlWMGxE?=
 =?utf-8?B?cUs1TUU2eVh6TXlIYTdZTWlvdGJUazZjZERoRFdJRzQ2SlhzTU5Ic3ZTang5?=
 =?utf-8?B?eDlUK3RMTFVFVUJmT24xUzNhWkxGU3ZjUzcxU01kZGw4YUtqVUJ4TGk5RGpl?=
 =?utf-8?B?SDNwYTF3dWNUaTZYRWZNQUdwTDB5MjdrR2gwYkRyUFU5OVFtd1Y2VGN4MjZt?=
 =?utf-8?B?VkpiREhUcktHWldSazQwbGcvR2IvQWNtOU9kNVZ5Z094emsya2ZtUmJkNTFL?=
 =?utf-8?B?Z2dXVTNIcm04ZmJ6b2lSMksyVjBjNnM0T2lEQzh2alRoMEMxUkwxeHBscHdL?=
 =?utf-8?B?RUs2cWpOQm9IR3hVOEV3a0lvaUc4QlRoc0cxbXhmS1NFS3A1Tk03VmdCUjFU?=
 =?utf-8?B?T2wxVS9IeVlOOHRYcVZmT3FySzc2QmswREpzNEZ4dmd5T3dKd0p4Q2VYN09D?=
 =?utf-8?B?WEhtL1ZUTGM5eDAwMm5mUHlDSHNLNURIWHlKbnBkV2RzZlFnQy9TVzN1RTM4?=
 =?utf-8?B?dGdXbjQzTE5pMG1Idk9wSGlZYWVUSkR3YnpHN0VoVjlhRnNzMGxTVHMwY2Ew?=
 =?utf-8?B?WFdTVVRYTVl4Rk1mUE5BR1F1OVZZWDBsdnd3d3lmdEx5R2lYbk5iT1QwZW1J?=
 =?utf-8?B?aHpqS2dVRjNzOGJOa2NwQ29KaTRzd2t0ZnBOWFJmbm1pYzR1cGtzM1VDT3lI?=
 =?utf-8?B?VGZPeWhvQTRXR012ZWdUdUdMTWN6S2kzZk9VZUlqeEZheDFKTVExWFhKZEhj?=
 =?utf-8?B?OTlHcmFVZm4vc3hYMkM5dkRBOVpDNmFlZHhkTS82UHZ2UlhoRnA2T1dyOTlG?=
 =?utf-8?B?dzFKclZKdisvbWVEUm82K2N5Uno3OWVGVUhJYmFiREFqeS9td2FmSnBDd1dj?=
 =?utf-8?B?alBodXMxZk5Wa29QeVZPSzJTelpId1FIYzVpNkJXZEtTbXJnaUVCUXdLcVVl?=
 =?utf-8?B?MWVKbHAra0xvZlI1Y2d2YnkvdmpJeFYwTUhBWEhrWnZrS3M2enBUM1V5d3Bu?=
 =?utf-8?B?ZDVoMkpCZ0E1dmQ4bG81NmsvZ1NZMXZDTHF5TDNSUVBNcHZ4Z2l0Z0UrbzEy?=
 =?utf-8?B?aEEzTUl5YURxeUxXZVcweUJyeFJINGIwOXBjQXlQVmpDRDFEaXBCUDAvL3lO?=
 =?utf-8?B?dWNnK0pNa3lYVE5yMisxWEZWK3ByZlBVRkpzL05YY3JOeWpNQldBUjgyK0d0?=
 =?utf-8?B?VytITXlONWswWmxtMGYrWEJKVTdBdmVGdWxabkZySXFiakdxenNnR3I5WUZF?=
 =?utf-8?B?MDFBMnJ4ajJkN1E5a3JIZ1lnOWFEcGZhYnkrR0MxMy9neFdsWWhvR0NvVmJJ?=
 =?utf-8?B?Z3hzbkJHbzh2Q1VHVndpeFc5Y21DdEUrOEVlZTVNa0V2cFN3ajB5SWhGZ2Vp?=
 =?utf-8?Q?tilfKep6jL+lx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1VySFQxb0JvbjMzdkV3M1Q4aDBrQUJHYnlFVTFOZXViUXQzSG5xYnhBTmVI?=
 =?utf-8?B?b1NhcjhaVUpudVhhYWRjRHhDWnZkQVk4ZU5KYkdrVmJXYWs5NDhvTGJHeUdW?=
 =?utf-8?B?dld3M3AxN2d3YVJZNldkdUdPYWgwR3puOW5qL2M1dW1XK3FvQnhoSkN3dzRQ?=
 =?utf-8?B?UzVjMTlUYkV6cWw4MWtBZmg0bDR5MDRvVzh0d2RSSFZQTTJGYm84UG9Gd2FU?=
 =?utf-8?B?YllXL0hHV1dPejk0VGI2Z3gzOExmcG5pTkd3anJIUU94NEJsZFFTMERmSlY3?=
 =?utf-8?B?dGJjWmpZc29jd3NWNmRGRnYwUThZR0VmMUpiT0s2TGtrd2E1N2IxMmREb05k?=
 =?utf-8?B?K1luSlF6dzVkclJwNENtdUtVYjVQc0VjWnZYNnlKeGF3TWl5REZTV2hIdXFP?=
 =?utf-8?B?RFJycXFaREFpNWVUQzBGM0VRT1NkRVArTU44SE05bmtVZ1Z0ZFY5bUkvdStr?=
 =?utf-8?B?YVF5R20vaU00WldQL1ZLcFlISnVySmNZK2dqaVMvbVpvUk1MejQvMW96L0d0?=
 =?utf-8?B?RkRVUzZQZHVBeGwzT0VVRTY5cVI1UXh3QlMwSC9NOGU4RGExL0dzbGpYbUkv?=
 =?utf-8?B?UGt2YUk4WUpQL2lvSGR2cTRGVnZYRldpM3lucVkraWdXejNnV1pPWXI0b0t5?=
 =?utf-8?B?a2RtQW5wQ040WFA5SURWaUcvSWQ5YkVrUVVmWkdnUFBGR053UUlXNzByS01M?=
 =?utf-8?B?RmdudXZFcVlBWklPSEF1L2lwbWxIWEJ4V1dYemU0dUw2enRqUWZ5cml2SDEy?=
 =?utf-8?B?Ukc0Z1VmM2xaV1FjSnI0M0w5eWdUUkMzTmtUZFBKcFlVc1JtREhpSXYvdVhi?=
 =?utf-8?B?dm9sdERBeE10YllBZGhzTEs1Skc0SU5ldEphMDZiL2ZyOFBHc2NtZE4ydVVz?=
 =?utf-8?B?L1prdE9HTjlxNWdaNnR2aEhmTXVBUDZ1YVprWk1TcDhkMTcvZktwdHZTWTgy?=
 =?utf-8?B?T2ZuMGJ6eFNUUVZLMXlMRnlnQXlHVXJnKytQeVVkU1dZbWYxdmV5b2h2UUlt?=
 =?utf-8?B?TSsxdjFMc1JKeHgycHkrbFRpb3o0TjNVTUdNK0N4Mk14YnNnOWkvMEFpOE1H?=
 =?utf-8?B?T2pzZlFSSU1OVmxoNkRlZG83VThIc3VFOEZkNllOUDQ2YUVoZHdHdGY5cStI?=
 =?utf-8?B?SVdzZmxMRHBNb2JLUGFrTG9zUkF6dXpIM2FKSXp4VktqY0xsRncvZFp1Q0V6?=
 =?utf-8?B?NmhlNWNNZ091bXBrR2lqenlHWW0vN0JRYWFBT20wRXVsTENLRUtQczJ2VnNF?=
 =?utf-8?B?S0NIb05qSnQ0amhKakhLbitBUkl2d0JhMDh4SUh4RlVPNUROeWJncTdINmY0?=
 =?utf-8?B?elE3Z0d3Vkk3QjdTMUk3NmJhSExWVjh5NFhSWkM0eGRDVE90R3FaOFUrU2lO?=
 =?utf-8?B?dE9IODkvVVZZRm5TK3BCQU00cUZHa3lPZmt6anNrM0R5K2pwanJTd2hCaklF?=
 =?utf-8?B?RTVRbG1Ycjk1bkdkWGE1QWpJbWkwUWUxWUFjNUZzOGlmY0RMcFdSd3RJMk1P?=
 =?utf-8?B?dmVSTGI2RWdKQkJGQlpqUXp0eDFQbGNieWVWQ1RNaWQyZlFUYjFrMG9FZDAr?=
 =?utf-8?B?N3VrZVVJVjN4bXZYT2tPQkF0MC9CbmtuNGhWZ1hMd0ZPOUxuWTZ1aGJaRm5B?=
 =?utf-8?B?V1V6OXdqMFpwT0UxZVIveDQxQ1FOWEZaM3lCRXk4Z3VnSVFDeEVKbERRMFpJ?=
 =?utf-8?B?aWd1K0lKQThVM1UzTzU0ZWN2QTZzaHBhVjNFZFczdmFuenVQOFpNbTEzV2Nm?=
 =?utf-8?B?dVdhY3JyNUYxR0l5dDNFZkFPSWFLUzhESGlTTEZNN29nVXI1d2NOTGhVM29D?=
 =?utf-8?B?N3hjK1VXMk40N2ZySE84SWdjVjVYZ0w3L3RXQWtMdTVTWHFod1RSVjB4Q1Ju?=
 =?utf-8?B?WmQ1WUxlNENqRlNnOFdzTkhVU2hvMVBEYVJaWnlXaUpoYnhUY0dKaEZkOHNq?=
 =?utf-8?B?MmdSN2hzcXhuK2Y4dEp2VmlQaCtRc1FFamFBSEM3cVRzS2R0NzlVVlE0MHhM?=
 =?utf-8?B?SXBOVUVMMzZzc3lJcmZHb2tnSE1qR2EwekpvWGRrc1Z5YkhOeHlqV0VQa0tO?=
 =?utf-8?B?eEozQTNrSEJUZ1liSTBBQUdJb1lzQTl4Ly9XNHBsSEhhN0xyZW05akpFYVNE?=
 =?utf-8?Q?ihlsnUk9VieVYqk4/S1w+Oo8l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485eb4e8-af1a-42e9-f515-08dd34af99b6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 15:24:56.1490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8IxUKQO/VFNx8/XRWkls0p9BbLrbUjDRyxAawMCdgqob5ZFwVkfTbm6RQkZLkyz3ZxsTGCfd3q4bG2QOSyig1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305




On 1/14/2025 5:35 AM, Jonathan Cameron wrote:
> On Tue, 7 Jan 2025 08:38:45 -0600
> Terry Bowman <terry.bowman@amd.com> wrote:
>
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
> Is it worth a lockdep check in here on whatever lock is stoping this racing?


Yes, it is. Thanks Jonathan.

Regards,
Terry

>> +	if (port->uport_regs.ras)
>> +		return;
>> +
>> +	port->reg_map.host = &port->dev;
>> +	if (cxl_map_component_regs(&port->reg_map, &port->uport_regs,
>> +				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
>> +		dev_err(&port->dev, "Failed to map RAS capability.\n");
>> +		return;
>> +	}
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_uport_init_ras_reporting, "CXL");
>> +
>>  /**
>>   * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
>>   * @dport: the cxl_dport that needs to be initialized
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 727429dfdaed..c51735fe75d6 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -601,6 +601,7 @@ struct cxl_dax_region {
>>   * @parent_dport: dport that points to this port in the parent
>>   * @decoder_ida: allocator for decoder ids
>>   * @reg_map: component and ras register mapping parameters
>> + * @uport_regs: mapped component registers
>>   * @nr_dports: number of entries in @dports
>>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>>   * @commit_end: cursor to track highest committed decoder for commit ordering
>> @@ -621,6 +622,7 @@ struct cxl_port {
>>  	struct cxl_dport *parent_dport;
>>  	struct ida decoder_ida;
>>  	struct cxl_register_map reg_map;
>> +	struct cxl_component_regs uport_regs;
>>  	int nr_dports;
>>  	int hdm_end;
>>  	int commit_end;
>> @@ -773,8 +775,10 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>>  
>>  #ifdef CONFIG_PCIEAER_CXL
>>  void cxl_dport_init_ras_reporting(struct cxl_dport *dport);
>> +void cxl_uport_init_ras_reporting(struct cxl_port *port);
>>  #else
>>  static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport) { }
>> +static inline void cxl_uport_init_ras_reporting(struct cxl_port *port) { }
>>  #endif
>>  
>>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index dd39f4565be2..97dbca765f4d 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -60,6 +60,7 @@ static bool dev_is_cxl_pci(struct device *dev, u32 pcie_type)
>>  static void cxl_init_ep_ports_aer(struct cxl_ep *ep)
>>  {
>>  	struct cxl_dport *dport = ep->dport;
>> +	struct cxl_port *port = ep->next;
>>  
>>  	if (dport) {
>>  		struct device *dport_dev = dport->dport_dev;
>> @@ -68,6 +69,13 @@ static void cxl_init_ep_ports_aer(struct cxl_ep *ep)
>>  		    dev_is_cxl_pci(dport_dev, PCI_EXP_TYPE_ROOT_PORT))
>>  			cxl_dport_init_ras_reporting(dport);
>>  	}
>> +
>> +	if (port) {
>> +		struct device *uport_dev = port->uport_dev;
>> +
>> +		if (dev_is_cxl_pci(uport_dev, PCI_EXP_TYPE_UPSTREAM))
>> +			cxl_uport_init_ras_reporting(port);
>> +	}
>>  }
>>  
>>  static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,


