Return-Path: <linux-pci+bounces-36144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7CCB578EB
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 13:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF0F447B72
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 11:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6451C3009EF;
	Mon, 15 Sep 2025 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RWM9fpuJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010022.outbound.protection.outlook.com [52.101.193.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DD73009D3
	for <linux-pci@vger.kernel.org>; Mon, 15 Sep 2025 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936833; cv=fail; b=oQhqbT6oc2YmYnxDL4JTY2aAjdviTORNrg5K0qRQHef80McosOmcpL9P5j8jhCM4PugAa+g5i5g3ZiKggjap0womic5/xQoSA5BrB1o2ZZ6iF80KoCWqKybmMyhVx1/xueFju6sKqoCKWuvsgWiDtoHbbWJ0trYXOvuIWmVLAMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936833; c=relaxed/simple;
	bh=FtsqYxLGo5TwOKy4d1WApFekRSB5SBJ6aY4ZLZalNg4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dEjg0hrDrs6x2PNCv5+N6xPMwKkvfMN+xfVABj1qqdOUb42Kx+S0QHOLS0nt02B7kiAnmMAOG3v0Sg9Lff070mCBU/LFimRJqF8nzqqdbl/gmmeg77Nnbg9mxfMB7xBQfLX/MER72iCLxYggYG+zITdZRRtR04K0vGEZW7ywP14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RWM9fpuJ; arc=fail smtp.client-ip=52.101.193.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0OTgGcG1yRLtt2aR1sI1WUgKT7Dl4/8Nv3UiZOYVkXNNdi0q135BEuEaAmMmelOZy5AndPyew4hYXbImiahjsu+DoDI+2xVCJvndekZn51pm2wiGGW0kVLppCVkRF4QOMCoV9PDAOXNUCBZH8fg+BOgQX4FPHpcNUFNs2AYUXNqWCwPuenkCqBPBaTUsegtI8RYTSNE+OQzekEM1agn2aKFqkr5BZUIhxYINJ293fTrCoaFfv7pooHY4sOxDCWZR9YZIHQ9/BSOUnr3OzoVwraFgaaV8oN/u5w/a5WvGATqJZuztA25pXuSeJL8WjkbVVfVXKIrnBFOoxM9b/yQog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MR45P0l3OB3xFMcBzNIVa7U5E5ZoJDNas5SfpxdM5qI=;
 b=ThboRsMuab1S6m8vPWUG6IKfIXx15/LVfzt+yPIzw4RKY7ggdmD4BH3UMDdu39Kc1Bp75IAKvbuZSmpK+JmgYwId29IApVYBHuWe7NERBERsoEVZGobWDQRcuRNKFxKO9akoLvRrL4cbYBSiKNaSiePOufPC3afWlhRUOUO/iLZDfk7BqglCcHl8OQG9h0a4yfixvbjsiS2aD18bKCB3cIQiO5IXSUw/tXNoR0jp41PnPx8Cdaw3MaYOnShRFdBdi2JobJ1vIpN14DuEvvHHGstw2bZk8pNIp8gTnCndE0pm73+qW0rhXNVu8z5RI7BBrfR3528tcaLFkojvPFIQ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MR45P0l3OB3xFMcBzNIVa7U5E5ZoJDNas5SfpxdM5qI=;
 b=RWM9fpuJ7rBPdbxPKyISkLbJ6lKnSpq+fNwmXQ4oW9EbIp6rExDkqhWIJW2uGYm6+WwqBBxLhzoC2Msk2/yLJVf5o6k0XKv1C5Pi3FgsC0dkTaGIsQ4cl4RIbMEFlm5OGa7Loy2vWfuCoDVDuK+38QzB8AwtzcDfr9L1z0eqAkE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DS7PR12MB6262.namprd12.prod.outlook.com (2603:10b6:8:96::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.19; Mon, 15 Sep 2025 11:47:06 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 11:47:05 +0000
Message-ID: <0e8e709a-97f5-4482-8763-709bc323ecdd@amd.com>
Date: Mon, 15 Sep 2025 21:46:59 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v5 07/10] PCI/IDE: Add IDE establishment helpers
To: dan.j.williams@intel.com, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: yilun.xu@linux.intel.com, aneesh.kumar@kernel.org,
 gregkh@linuxfoundation.org, Bjorn Helgaas <bhelgaas@google.com>,
 Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-8-dan.j.williams@intel.com>
 <eeca3820-01dd-4abc-a437-cf46dc718ab6@amd.com>
 <6608a45f-b789-48c9-9418-5d6c2956975f@amd.com>
 <68ba3f725b284_75e3100a5@dwillia2-mobl4.notmuch>
 <14144093-c3e3-49a1-96d3-acd527cfe32a@amd.com>
 <68bb95a07043f_75db100bf@dwillia2-mobl4.notmuch>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <68bb95a07043f_75db100bf@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY4P282CA0018.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::28) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DS7PR12MB6262:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d7fd48-a7dc-488c-4da1-08ddf44d97eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlJKUDloVHBac2VtQjI1dkRPOGYzNkt4TkZIQzhBWlhOdmRhTERxdjZKek9i?=
 =?utf-8?B?dXVtajhocXRpMUJmMVRGcUdKYkljT0hHMms0cEczdnF5amZTOWNQcnhPL3lu?=
 =?utf-8?B?TW43S1JPNE41TTVoOFZadHhacW91THB6UEZKNXFXMGdzdWRDNFAwTFpkVVV4?=
 =?utf-8?B?eTlGa2hRUWlDdUhZTkZGdDZsNlVaTlJKK2ZMdmlnaVV5T2QxTGtWdTAyVWlH?=
 =?utf-8?B?dytxRWhZMlJxUVRlb1oyVzZObFRwVGlGUnV5bDJSWXVqaTY0UXRoMWJ2RjFl?=
 =?utf-8?B?SmtJOEJvVVF6NWVIT3VEaVM2ZHoreTF4dUo1SmU1eGxKV3FncFljVjI4TlNE?=
 =?utf-8?B?My8rZnpnTGROUDRiNnA4RFdXVVNYcEFDS3VFdjJzY0VRcXB2bFQ0cGFmdEJX?=
 =?utf-8?B?bkJUZjA3R2wzcWpRL21iYy9ZdnVvSnIwYmFDUElaRnBSdmNWQkl1d2VWTEUv?=
 =?utf-8?B?VUxzL3l6SkVnNDMybEZUMjg1RnhLTzdUbG8xdVh1TUdUOUtZS1V5S2R4S1d5?=
 =?utf-8?B?SU5hSnJZeG1PQ2UxQ3hVSkhNQmh1NlJsTFlNUW80MUQwL04ya0VKT3RGUmVT?=
 =?utf-8?B?cFQwR2ZMajFudTE3ZVVZMHlvSGhlVk5XaXhNYW56TkdsOGlKUlREYVhKZDlS?=
 =?utf-8?B?VndPdkpYUGh0bzR6SnlQcHUwNjVxNGF3ck5wMG1NY0wyb1RSSjFTeTVUL29Z?=
 =?utf-8?B?eFdPWjFnU0g4QWlWd2tXaGxnaDZSb0FSS1hycm40UWgwQks0ZmtxbngyMUlT?=
 =?utf-8?B?cjd2bHhNUGVmMXFKbEtRY3cwb3RxeDl1UHlVMmI0VU9wK0xPRG9lYlpzZEFa?=
 =?utf-8?B?ZE5tYzBwcnpCelUzOVduTVR2VUtSZEg1dHZ6NmFMeVhrcE5PZEx3cDVtcVdK?=
 =?utf-8?B?V0dIekE4bkRjRUpXbWZid0xQY2hUT2s3VW9mK1g0OGxHRXJSZnJQczJ2eWFF?=
 =?utf-8?B?N21iRXlyd2YveFdRdk9BYzRxMkVpNlJkRnZTa1hXYkpNV2pRTC95VlZadVdR?=
 =?utf-8?B?WTBEWFIxQWp1M0N5KzB6ZTNIbit0UlA4elREeFdpaGFCZnU5UE02SmM3aDI2?=
 =?utf-8?B?bFIrNDUzdWV0VFRvWU9JVVZzanlQUllETnZRZWJRYmNpZWxZaG1SWUREZHhK?=
 =?utf-8?B?SmhmSU0vZWlHNm1CdGV6b0QwU05HV3lPTW5xcURPYmNQWDZORHZsRFFuRTdF?=
 =?utf-8?B?NkxoM2xXWmVTZFUxRTIwcGZZbUlIMDg0b1RsOHRGRkhUdTQ0bGxSUlZiemxD?=
 =?utf-8?B?bnRIQ2dLVFo2Uy9nS2xHSktVVkVNRnEyWnBvNFc3cUNodnVyUGpOaGFtZTMy?=
 =?utf-8?B?a3BNaE1IWFhWUnZHRnpxZ2FwcXFwY2UrYXBoUHVYOXY2TlZoZU9naXJ3NXY2?=
 =?utf-8?B?UkRNalRkbUtPWjFFR1lhdTQ4clJxT0pMVWV6blNmTXNGaEl1Mk5PTGsxcVhq?=
 =?utf-8?B?QUE4UTdFQTVwN2tucW50MGU2ZXhPUU9UR2xjRG5QWVczYmZFVTg5TlE2amdD?=
 =?utf-8?B?dmVmTWRQazhlM0l3Q1ZlTkFkYlNwOWIzMGdoZ1FkZTlkbEJmNTd0MWtxU2U4?=
 =?utf-8?B?QThrallqazVRdUhXRWhUajRVMkF3alRqVnB5L0JKSWJIeXNMZHJUQzlUcXJz?=
 =?utf-8?B?YW9hVjlUbzRZV1A0cWQ5M2pnUGpuWk1KSkM3YkZmTHZsbHBtZHFuUUhxa2VC?=
 =?utf-8?B?VExIRUhxT2JRYUNJOHlnRXZWWjUxL0VEQW1rcVVEaHpGbVJ6ZFJVVXYwMVYz?=
 =?utf-8?B?VlUxMWhCQzBIWFJhaVJ2THlreDJ6MWtGUjZLOTYyVjRiQ3RaaldpdTlpVFpM?=
 =?utf-8?B?akphdnpNY2Z3U0NweW0wWXJmV1oxLzgySDBubzNuUFdzRmtlK051aHdDUU16?=
 =?utf-8?B?SHdTWjI1WTk4eUJyMC93QnN2ZFJvaGNlWVNvSXVFTzhPMjBwSEdGUU96cG9P?=
 =?utf-8?Q?HCTyKLSCVIA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0RUSThaSmErU1hzaGJIMzd2Q3dMY3JkNG4wR0RRa2toeFdiT0s0ejQ3Z1dn?=
 =?utf-8?B?Wm51MnFyR0tkN0tBK3pyTHhUYnk3RmpiVEt6VFN5dFpyTDZyWE9jYUlQcitC?=
 =?utf-8?B?QXRtRGFJdHNaWDhLS1R2R1BrdWp1TjEwOFFLTnZVbGJRN0lvYmJYMXRyOXhr?=
 =?utf-8?B?NUYvRWhmcEhOcFhxMFNHU0RlR2Z6V21jTUtrcEhTMDhlTmlBYXZ1YWpJU2xj?=
 =?utf-8?B?MnZKVk50OU1DUHFyczFNV3R0L3N5d2ZVc3NWVGI2N3FKQ3hSMUxZYmZtdUgx?=
 =?utf-8?B?TVVPU0VQdnF1NjZ2V0Fydk1KeVN0WGNESEQxR3dmdjBQS2VJcm02Qlp4VS9C?=
 =?utf-8?B?dWhUaW1WcE9NQVFuSVhuYkg1WS9iN3ljNzg1amkraU4rSTMzZ2o0bFhkQkdF?=
 =?utf-8?B?UHF3Nllxa2FYVzlPald5VlBoWGI3R1VrUC9SNk8zWm1uUlVmREMrVWRaMHZK?=
 =?utf-8?B?MEVCUGlJMG1hSmJva3l5VHdBVytVbml0RzJQZDFjM1hjNHVPUVA4V2h0dHp6?=
 =?utf-8?B?b1lGVjJmdUlBMUxMZGRoeVhHM1FCbU1QNUNGaWlzNm9ldnNZZWJoYmJMOTVn?=
 =?utf-8?B?UWZwTjZ2WUVIb210Q2pXT3JNM0k4ejNhVVJObkdoUklhd0doUmF2QUJpN1Rl?=
 =?utf-8?B?UWJxcUl4SG5pTVF4QUs3SWR1QVZHZy82RmZzREE2MnFQUG52M1c2akFiOVhQ?=
 =?utf-8?B?R2hTUE5vWWN5b015MlhTOFVHSWs4eDRWbk01U1ltdVZZa2Q1VjZkdmEwNDJs?=
 =?utf-8?B?QXBxS1NUaDJsNmJFSnVhNVByOC9tK1VqaDMwQjdzdW56MkttZUxETW0zcFN0?=
 =?utf-8?B?amU1blJET1g0UjNkTDBUdFZpSUFSZkZCMkxuVTA1SkxkWDJvdk5XRUFxUE1H?=
 =?utf-8?B?dEowQ29HUUdqaXRRbkE5cDB4MkdhZU9zSU9heDdGaVJhRFRGYW9HajRGS2xa?=
 =?utf-8?B?ZGtFNGRPUjE1NGR6WWRIclc1UFJYeFlYQUdzcEUzVlZCZXBCa3JhTGlxNFJY?=
 =?utf-8?B?bC9XZUpyLzUzMlhLdDcrdUg2VkdpU0x1cXEzZ0tTTDdkazNLa2RKY09ITFF0?=
 =?utf-8?B?NmhpMWNsaFBkQ3VkOFU0eXpmMmM2VktPSUtuKzlpODNLNWhteXVkN2VhSFNa?=
 =?utf-8?B?d0Q3NzM1SjZ5S3l1TjRxUXh4Um1Zdi9VVVdxc21pS1FPSkNDSHZTenhZM1Zy?=
 =?utf-8?B?Q1ZmanVuS053WU1pN1RMSVVlcGRwOXZjbDkxelB0MEM0UjU1ZkJ1YkJTUmZv?=
 =?utf-8?B?WXZMUDVpcE01bk5Ed2REUzlJS0hkZmJ2M0tWR0ZzdHlOaFZOanVLQVNabU5s?=
 =?utf-8?B?cTBRQ0NSZGw5TXlZdGorM2Y4ejZ6TVJaczZYQldXaVBzZXY2YzloSVpZM1Zj?=
 =?utf-8?B?TTI2V09WTE1NSm54bVNodFhQQWZKZHhBZ0NOUENaYzZ1N1doWWRMSUlsNjR4?=
 =?utf-8?B?cWI4Y0g0WkVOK2l4VHJVOHR0andFbDNPMUl6ck1ZQ1NVYy9zTWR3YXpPZ1pR?=
 =?utf-8?B?WitiZ0E1OXFwbXd4eVU1cjg4bGg5R0pobzJkS3dCM2FrbTZSSHRlanl5MWY0?=
 =?utf-8?B?V0dKY2VmVXVoNW51OXdFWE04TmU2NFF1WU43bDZPakd3bG8zSno3OXFENlVl?=
 =?utf-8?B?OE4zMmlQM21xU3lPNGQrZDJBbTE5Q05QUEo5M2dLVzhlMGtkeUZhNVk3Q25h?=
 =?utf-8?B?UmdDQ09hdTlzVEx4L1pwSXVGYVFDQlNTamRkNkpRNWNNeGF1T2FwQzM4MXZC?=
 =?utf-8?B?K3MwRmIyVk1pOGxwdFpuR0FINm91eld2dG5wUGVVRkx6VHVqbnRvdnBYRTgr?=
 =?utf-8?B?cTNHUlNCTDJQVmFVZUVnb045eTR2NEpLbFpTa3J5Um1xQ1JPaVM5UHdWRTQy?=
 =?utf-8?B?S2xIcEVwQitZQzRHcUVSbElIOUtsYW1kVmh4akVYYm9VWFhFbFNzb2x6dU81?=
 =?utf-8?B?T0NLbHVFUWlMdHNDN2h3UUlJQUI3U3Z6S1F0dXZITGo2TlFyZlRjQmFUVEk0?=
 =?utf-8?B?clVNUW1xcm1HN1dmejBwaTRDTFBVUk8zZHljdWVQUDF0ek1SRVVLL1I0OEdq?=
 =?utf-8?B?MGRNRXFzMDJjMlRyZExKQXZFb3JSa1c2VVZFcGV1OHJ6S0xhc2hGZnZvMFJC?=
 =?utf-8?Q?gEzEnmD1VETFaBGy70/MZEsmQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d7fd48-a7dc-488c-4da1-08ddf44d97eb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 11:47:05.8742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvpjg4Zcx1FAGtG15NLLfLTvVvviKs1jZRyX/s8K+q4nhfTRm62hGfyJflpoJrI21elLCs/q/5gbHO4NNQ/Wpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6262



On 6/9/25 12:00, dan.j.williams@intel.com wrote:
> Alexey Kardashevskiy wrote:
> [..]
>>>>
>>>> Ah this is an actual problem, this is not right. The PCIe r6.1 spec says:
>>>>
>>>> "It is permitted, but strongly not recommended, to Set the Enable bit in the IDE Extended Capability
>>>> entry for a Stream prior to the completion of key programming for that Stream".
>>>
>>> This ordering is controlled by the TSM driver though...
>>
>> yes so pci_ide_stream_enable() should just do what it was asked -
>> enable the bit, the PCIe spec says the stream does not have to go to
>> the secure state right away.
> 
> That is reasonable, I will leave the error detection to the low-level
> TSM driver.
> 
>>>> And I have a device like that where the links goes secure after the last
>>>> key is SET_GO. So it is okay to return an error here but not ok to clear
>>>> the Enabled bit.
>>>
>>> ...can you not simply wait to call pci_ide_stream_enable() until after the
>>> SET_GO?
>> Nope, if they keys are programmed without the enabled bit set, the
>> stream never goes secure on this device.
>>
>> The way to think about it (an AMD hw engineer told me): devices do not
>> have extra memory to store all these keys before deciding which stream
>> they are for, they really (really) want to write the keys to the PHYs
>> (or whatever that hardware piece is called) as they come. And after
>> the device reset, say, both link stream #0 and selective stream #0
>> have the same streamid=0.
> 
> Ah, ok.
> 
>> Now, the devices need to know which stream it is - link or selective.
>> One way is: enable a stream beforehand and then the device will store
>> keys in that streams's slot. The other way is: wait till SET_GO but
>> before that every stream on the device needs an unique stream id
>> assigned to it.
>>
>> I even have this in my tree (to fight another device):
>>
>> https://github.com/AMDESE/linux-kvm/commit/ddd1f401665a4f0b6036330eea6662aec566986b
> 
> I recall we talked about this before, not liking the lack of tracking of
> these placeholder ids which would need to be adjusted later, and not
> understanding the need for uniqueness of idle ids.
> 
> It is also actively destructive to platform-firmware established IDE
> which is possible on Intel platforms and part of the specification of
> CXL TSP.
> 
> What about something like this (but I think it should be an incremental
> patch that details this class of hardware problem that requires system
> software to manage idle ids).


Was this lost in rebase? I do not see it in v6. Thanks,


> -- 8< --
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 0183ca6f6954..2dd90c0703e0 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -125,17 +125,6 @@ config PCI_ATS
>   config PCI_IDE
>   	bool
>   
> -config PCI_IDE_STREAM_MAX
> -	int "Maximum number of Selective IDE Streams supported per host bridge" if EXPERT
> -	depends on PCI_IDE
> -	range 1 256
> -	default 64
> -	help
> -	  Set a kernel max for the number of IDE streams the PCI core supports
> -	  per device. While the PCI specification max is 256, the hardware
> -	  platform capability for the foreseeable future is 4 to 8 streams. Bump
> -	  this value up if you have an expert testing need.
> -
>   config PCI_TSM
>   	bool "PCI TSM: Device security protocol support"
>   	select PCI_IDE
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index 610603865d9e..e8a9c5fd8a36 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c
> @@ -36,7 +36,7 @@ static int sel_ide_offset(struct pci_dev *pdev,
>   
>   void pci_ide_init(struct pci_dev *pdev)
>   {
> -	u8 nr_link_ide, nr_ide_mem, nr_streams;
> +	u8 nr_link_ide, nr_ide_mem, nr_streams, reserved_id;
>   	u16 ide_cap;
>   	u32 val;
>   
> @@ -74,14 +74,13 @@ void pci_ide_init(struct pci_dev *pdev)
>   		nr_link_ide = 0;
>   
>   	nr_ide_mem = 0;
> -	nr_streams = min(1 + FIELD_GET(PCI_IDE_CAP_SEL_NUM, val),
> -			 CONFIG_PCI_IDE_STREAM_MAX);
> +	nr_streams = 1 + FIELD_GET(PCI_IDE_CAP_SEL_NUM, val);
>   	for (u8 i = 0; i < nr_streams; i++) {
>   		int pos = __sel_ide_offset(ide_cap, nr_link_ide, i, nr_ide_mem);
>   		int nr_assoc;
>   		u32 val;
>   
> -		pci_read_config_dword(pdev, pos, &val);
> +		pci_read_config_dword(pdev, pos + PCI_IDE_SEL_CAP, &val);
>   
>   		/*
>   		 * Let's not entertain streams that do not have a
> @@ -95,7 +94,65 @@ void pci_ide_init(struct pci_dev *pdev)
>   		}
>   
>   		nr_ide_mem = nr_assoc;
> +
> +		/* Reserve stream-ids that are already active on the device */
> +		pci_read_config_dword(pdev, pos + PCI_IDE_SEL_CAP, &val);
> +		if (val & PCI_IDE_SEL_CTL_EN) {
> +			u8 id = FIELD_GET(PCI_IDE_SEL_CTL_ID, val);
> +
> +			pci_info(pdev, "Selective Stream %d id: %d active at init\n", i, id);
> +			set_bit(id, pdev->ide_stream_map);
> +		}
> +	}
> +
> +	/* Reserve link stream-ids that are already active on the device */
> +	for (int i = 0; i < nr_link_ide; ++i) {
> +		int pos = ide_cap + PCI_IDE_LINK_STREAM_0 + i * PCI_IDE_LINK_BLOCK_SIZE;
> +
> +		pci_read_config_dword(pdev, pos, &val);
> +		if (val & PCI_IDE_LINK_CTL_EN) {
> +			u8 id = FIELD_GET(PCI_IDE_LINK_CTL_ID, val);
> +
> +			pci_info(pdev, "Link Stream %d id: %d active at init\n",
> +				 i, id);
> +			set_bit(id, pdev->ide_stream_map);
> +		}
> +	}
> +
> +	/*
> +	 * Now that in use ids are known, grab and assign a free id for idle
> +	 * streams to remove ambiguity of which key slot is being activated by a
> +	 * K_SET_GO event (PCIe r7.0 section 6.33.3 IDE Key Management (IDE_KM))
> +	 */
> +	reserved_id = find_first_zero_bit(pdev->ide_stream_map, U8_MAX);
> +	if (reserved_id == U8_MAX) {
> +		pci_info(pdev, "No available Stream IDs, disable IDE\n");
> +		return;
> +	}
> +
> +	for (u8 i = 0; i < nr_streams; i++) {
> +		int pos = __sel_ide_offset(ide_cap, nr_link_ide, i, nr_ide_mem);
> +
> +		pci_read_config_dword(pdev, pos + PCI_IDE_SEL_CAP, &val);
> +		if (val & PCI_IDE_SEL_CTL_EN)
> +			continue;
> +		val &= ~PCI_IDE_SEL_CTL_ID;
> +		val |= FIELD_PREP(PCI_IDE_SEL_CTL_ID, reserved_id);
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
> +	}
> +
> +	for (int i = 0; i < nr_link_ide; ++i) {
> +		int pos = ide_cap + PCI_IDE_LINK_STREAM_0 +
> +			  i * PCI_IDE_LINK_BLOCK_SIZE;
> +
> +		pci_read_config_dword(pdev, pos, &val);
> +		if (val & PCI_IDE_LINK_CTL_EN)
> +			continue;
> +		val &= ~PCI_IDE_LINK_CTL_ID;
> +		val |= FIELD_PREP(PCI_IDE_LINK_CTL_ID, reserved_id);
> +		pci_write_config_dword(pdev, pos, val);
>   	}
> +	set_bit(reserved_id, pdev->ide_stream_map);
>   
>   	pdev->ide_cap = ide_cap;
>   	pdev->nr_link_ide = nr_link_ide;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 45360ba87538..6d16278e2d94 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -545,7 +545,7 @@ struct pci_dev {
>   	u8		nr_ide_mem;	/* Address association resources for streams */
>   	u8		nr_link_ide;	/* Link Stream count (Selective Stream offset) */
>   	u8		nr_sel_ide;	/* Selective Stream count (register block allocator) */
> -	DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
> +	DECLARE_BITMAP(ide_stream_map, U8_MAX);
>   	unsigned int	ide_cfg:1;	/* Config cycles over IDE */
>   	unsigned int	ide_tee_limit:1; /* Disallow T=0 traffic over IDE */
>   #endif
> @@ -617,7 +617,7 @@ struct pci_host_bridge {
>   	struct list_head dma_ranges;	/* dma ranges resource list */
>   #ifdef CONFIG_PCI_IDE
>   	u8 nr_ide_streams; /* Max streams possibly active in @ide_stream_map */
> -	DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
> +	DECLARE_BITMAP(ide_stream_map, U8_MAX);
>   #endif
>   	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
>   	int (*map_irq)(const struct pci_dev *, u8, u8);

-- 
Alexey


