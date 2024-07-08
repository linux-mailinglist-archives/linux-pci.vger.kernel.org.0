Return-Path: <linux-pci+bounces-9918-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BE2929F80
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 11:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626BD288DB2
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 09:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F9D6A8D2;
	Mon,  8 Jul 2024 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eD2s0Eni"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D187345B;
	Mon,  8 Jul 2024 09:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720432092; cv=fail; b=CU42kzaco7ZZ4R9IYT1Nlj1K/oXZQMvhgebkhx8Q85VU//vjjedNAxUEtrgn3VkKSvs7OUzDBXg9YWoezSlvPypUSZqCidGobCde6oVDvegGT7Zs1G56d5k4ztNU4MRFXgMqMoH7syeamGbeb0099vKJ16nnntvuT/O5Qg9GV/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720432092; c=relaxed/simple;
	bh=4ZRWbnu9170+EwkVyUWpmZB2t7pf9x8b4Vfj1U6IqkA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C+qpRkf8HrCFthnDtWp0VjOJDug56sXFee5ETp2MXymMtkQPJwZg5Cirw1y8h1O9hT/YFE0c5hu/ROfk60Xlovcz9OQt+uPaVfyIkkn4pN8T/sclkdTKTVBYtu35U4xfvoOJztdDlonIyBz1q/3EqVjjzD8cmawmjkcjnmoFndg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eD2s0Eni; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvK1Ku5FF8rYEekpxN5+upmS2myYcK1uhtn2w+2kdwWOUz6ay4GZVskJ4Dlwj9X8KG/9O1OusRo9TFBRSMKc7Pcu5D1zbQevPZDf9Q7gio7OLgxL/37UAMK2KmlLYe/0kTrgOMuPrtWYDCVGUHXfAonHlH9URt5CMhqXvtNZ5VAeP+DlNg74HrRMlF1s61D3DX4AVbDTnjeHhadcudcRHkelR/FYc09fLbQ+SZyDTLK2ezC2bCeEWT0mcqhNX+QIfO3rBO+2uPIb397MGu4jszctOEiIlBkhWwYSTXTmwhRFlWbDUmDw/GiV7uWrJcYne14sWZCFZC6ALhNdvmyb5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSMsT1pIeFf5YylBpKs7jDf8LZnl+Qag/3GVwodO97U=;
 b=TgC2CxuHgKk61OEzNPlbL4XcNyCdbq+rD1BenXnMPG3z9XjhVZMY3bZqRI01BuBPvJViN/d+CQaZLyahHJx+cCLqyFhPlP3IkK2mSdGvA6650whIoW9nQpisQbSnQzGzfbSc30lvuRphPyiktQS1VyN9TRxpcboT3ixdS/3d0DVC7uyRxhhbR4X/SwWTuZW+VD/Ra6w6DAxKA5DUuTn5Fvxm9hDJoA+r7CVuc9FK5S2c7aBT94+kdvtV3z6xOa3bK26PjiHxfbGshfBR3KvDVE3l1Jjzi4GRHe4ZBGfvy1eno05GA0dIIY0iP16SiL+rcgmk461rwhHcjS4si+Mo4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSMsT1pIeFf5YylBpKs7jDf8LZnl+Qag/3GVwodO97U=;
 b=eD2s0EniDEY29c5foz/1xaH8dtPrcO2/J+2Huu2YhEhNs2xU5j7rUcOzu8Z3Ql5gCtdXKd3z7XDl2pp3sdnYlQday/Kd5QwbyCG8+Ufjhm2b9qLRroF/SIbMSzFsn1TqZO/Ugifb2Vcpks3UhgFLec2ohq+MRbBhsyAN4C8qqvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CH3PR12MB9078.namprd12.prod.outlook.com (2603:10b6:610:196::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 09:48:06 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%7]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 09:48:05 +0000
Message-ID: <2140c4e4-6df0-47c7-8301-c6eb70ada27d@amd.com>
Date: Mon, 8 Jul 2024 19:47:51 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 00/18] PCI device authentication
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Bjorn Helgaas <helgaas@kernel.org>, David Howells <dhowells@redhat.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 David Woodhouse <dwmw2@infradead.org>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org
Cc: linuxarm@huawei.com, David Box <david.e.box@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, "Li, Ming" <ming4.li@intel.com>,
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
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <cover.1719771133.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY8P282CA0009.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:29b::11) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|CH3PR12MB9078:EE_
X-MS-Office365-Filtering-Correlation-Id: 844a84ed-5ff4-4c4a-ba41-08dc9f3310a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qm9GNVZnNG43S1JncE5Lb3BhSElNaWRCdjhnV0F0VGw1RUJUdTEyYXE4N0Ri?=
 =?utf-8?B?RCttZldIL3FvYVFFakQ0UmUvejE4V0Y2MVI0NStnZ0YzNURtbkNJOUg2dDRG?=
 =?utf-8?B?Y3JKdXIyUkRhcXFmUzk1ckxKb0IrU1JlY2p3UmdBZXdpUVZrOURqK25mTFVl?=
 =?utf-8?B?VDBuK0FhMWtKa00wcFRlT2RyaE83VzdYOVBHdjBPWmRNc1lzZFBOMnB2NGZZ?=
 =?utf-8?B?VjlaZktsL0x6OTJpZ3A0M3VZYTk0RTFQa1UwQnYxbnVwQ2tpbHZVdXNCQzBQ?=
 =?utf-8?B?WlJRZ1QxMTA5VDZ5ak94bC9yTlVvNDBKbHBkU3pLU09LZGYyUmRYSlBmRGhi?=
 =?utf-8?B?Y0NPV1dka3lzN1dYajE1ODcva3pIM2FjSGpOU0hiTnZ3OENCWmNUWmJWd3lJ?=
 =?utf-8?B?cnREcVpWak5SRDQ5L3R4S1RSM1ExdFNxVEhOVHljNWlqY0dTWE13VWJ2RUc2?=
 =?utf-8?B?Q0wrRUhoR25CMmRFQ3RpelA5UG1WUnozdFdrNVJkbklqbnBaSE1PRnFUNEh5?=
 =?utf-8?B?NGZmeEJGWG5YOVdUWW9RYThkWnpRK3hkeDBOZ2RYWVJPOEVzT0VQT2VmQmhP?=
 =?utf-8?B?WEVrbk5CenloaDZwSEw5R3c1YmpWNnFsUSs0ZjdyWUsxN2JlM1Rwb09KSHdJ?=
 =?utf-8?B?OGRsem5rTVh2M2Z2UXFqVjFzNVdhdC8wQlVDc0JpV2NrcUhvYWhKOHByZW1w?=
 =?utf-8?B?TjBJemluZlFYZTZzL1ZsQU8xcUplRVJobERVc1FqanZMVDl6bFhxNHV4RU9U?=
 =?utf-8?B?TWU0U3VKUUdRK0tjTk5aZURhd2w5enJKc3BQeDI4bHMrWDk0TXArMTRSUUFn?=
 =?utf-8?B?NmY0Szg5N3B3ZFh0TkUvRUdZK3haUE9RVyt3Y0Z6RFc3cDZKRE1MVzhVZmdK?=
 =?utf-8?B?NmRpSnJ6aVh6WkNXLzN4UXZTckZTVFBzNTBpdHdSUEVTRThDSG83dXR0MXF5?=
 =?utf-8?B?U3dsSGtabjkxcVkvS0RpTWxEV2xpNFRzcEVjcnAwY3R3d2tkMmxUTEJnS3NJ?=
 =?utf-8?B?TlU5cDJDQTJqM0Q0enVncE4rSUFpdG1wRU9sdEJSdDFhdzFtbVZZeHhWMlhY?=
 =?utf-8?B?MjcyaEwwVWpsblpHZ01kLzd3dTUvbVNtZm4zSkJvMjNXUm9mcFUwVTM1QmF6?=
 =?utf-8?B?dlNWbWdVYmp1TE5ZRnV0Q25EdUx0QkM0aVdlcUJxMEpHNHljSUVZMEVwVjBX?=
 =?utf-8?B?eURZc0NmT0FGakZRRWxvYVBNVTBCOE45NzBNaG1XbzY3Y21GWU9yK1ZicW9x?=
 =?utf-8?B?a20rd1k5cm9UanZxZk1BTUdLU0xjU0pzRmVqZ0tjSmFzZHVFZ3RMTUNhTGtr?=
 =?utf-8?B?SS9hamR2dHM4ekFuR2hEeEdpUmlad3RYSVY2eUtrN0dJR0U4L2FOSFlHUytV?=
 =?utf-8?B?NGNuVytBMWQxU3NkdUZuTUVZbWVlUUxpUU5taGorUjl4UUMxQWZqd0t0SE9G?=
 =?utf-8?B?aGVta21PRWRoTnJGRXE2Zkx6UmM4RmNhU3Nxa2FqSFBGaEwzKyszOGFoRmxv?=
 =?utf-8?B?d1lGb3BZeHR6dkxRQml2ajIyM2lxemhoc0lOWk1WeEsxVHVZWlVPdFZKeitx?=
 =?utf-8?B?ZTA3V0h4bzdaY0c3ektlamU1cUc2dWZFT0xObFlZSHhHcXJaZzV1RUpNY1BD?=
 =?utf-8?B?WExWaS9hdUE0ZlBkcmZxWmhIampRa3A2L2hMM1hUa0tKSVV3VXM2TTl2Zm1u?=
 =?utf-8?B?M1c0WStHSXUxTW9sQTRIS0l4RTQvVDMwMnllSDBnV3dXYXFkZmtWcWJZUm81?=
 =?utf-8?B?YTkzbWpWUTFLd3VBQjh0WVpGZUZ3SHE1b2xPUm5ncFNoT0xXRU4rRGp3TUhX?=
 =?utf-8?B?aEZ2cUxOS2tneFBlZS9ZQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2d5bXY0SktDWVgyZ2k5MlkxTGVGWklic09pRElEUzJRZHpkckg3R0JQWVJZ?=
 =?utf-8?B?SjBpRURNd3NzQmVSWVVVRDhRQWVaeXZUTWFVRE93YVpaRm50Y2cvTUtGMUND?=
 =?utf-8?B?Um5PNjA0ZDFFc01mNk16dTJMZWhKbk1Kdk9uaWpIRnpmS0JTOEpzelBHRUx5?=
 =?utf-8?B?b3hOck9vYnBxc0U5d2RDU2V2ZXJobFlQL1RZTUUvc2UrN3F2enF1cmpwSVRw?=
 =?utf-8?B?SXM5U2pOZ2Flb1FRMlRQMFVTaHFLam10NFQyR2dxM1JPZXgyUXJaRWtEdzl6?=
 =?utf-8?B?YTFwY0hYZGhheURrSFhJSCtkUURFbUtJMzBta3VyQVdyNTBCeU1tSTNxeE9x?=
 =?utf-8?B?ek9lK0FSQXNSZ0N2WThLT0NwNC85LzlKT3ZPczdnR1BrV2NtOHA4WUY1MGZD?=
 =?utf-8?B?L25hUzl6dWlJRGgrQVpjRWkwYkpnaDM2bHhDdC9GZ0FPdzlqV01hckYrbFN6?=
 =?utf-8?B?dDAvSDdmWHZRa01NWDMvT3BlZzdtZzc5VU1mdXRBMTNJSUxBMndVLzIxRnZq?=
 =?utf-8?B?cmFxTXZOUVpQN1VwYUlrQTdqK2p1TlNSbGdvT1VGdWpkaWhLSW9VbU53bDVC?=
 =?utf-8?B?SWpQbjdTT0R1VUpQTkdxS2wzMVA0MnorMHdjaCtQSGxFMlVnZWlXNFBNaS9I?=
 =?utf-8?B?RDI0N29iNVA3VXA5SW1wSlZiaWVMcll5WFlsemkzQjV0WWFpTlJYSURQNTNJ?=
 =?utf-8?B?V2p4RWNVSXluYUVLNVFnNVA5bTRPbDQ2Q0RLdlNTQmRONWJtUUJHQnNKSUNn?=
 =?utf-8?B?UWpSOTgvVVo0d1JyVFZSRnlMdE1GQ0xkQmIvZHVCT0M3UlQrek4zc1lhSUlK?=
 =?utf-8?B?Y004MTVzSVkzczhDNVBraUYraTFFOGtDMjNPNDVjVUpseUMyaUhVN3ArK0tS?=
 =?utf-8?B?Y2J2WVlxakxpdC9taEpkKzRyY2RseklGbVgycmxjWnMrU1RXdC9QWXdOZGh1?=
 =?utf-8?B?dzIvV0J1R0N4RG9wK045b0NMREdSZ1R3RXJSVGRXSHdTMVNjcEF5N3BVWW0x?=
 =?utf-8?B?UC9iZnR3eHZULzlDV2Zma1BxUzhKTHNwRWs2Yk8zd1FsbGdjL0pQcExlaUE0?=
 =?utf-8?B?dUIrNXB0NWFrZXhpVUluZ3Yza0pyWU5OM0xiMDFGNFFRYm51TW5wUVhUKzlB?=
 =?utf-8?B?R3loY3J1d0w0Mk1FMUFVVDhDT1huaHhmV0FSQWEwNEE1bkpEc0N6emlxWk1Z?=
 =?utf-8?B?Yk1kek1PMWdyZ3ltOElqRlVIUGtqdUpWUjB5aHI0akNuOTkyV3VQTnBYRFVK?=
 =?utf-8?B?VWhzejFvejhxMjdtaWQ1T3Jhd0JpZG5YYU1jbUpxa2wxZW1wT1lwRHFKM21F?=
 =?utf-8?B?RzhxS1M3NGhNNGVTaU5qaUVaVWp3TWFjV2QvMnRiN0YxaHpxeDlrS3F3Y2F5?=
 =?utf-8?B?SGtmNE16SnNHVXk1UlBoYXlTaUI3NHdGUng2enppMTFUa0FFVVRUQU9vODcv?=
 =?utf-8?B?a3lRRi9tRHJ0UnNWa0h5V01zZllzTjllN1lHQk1Ya1c1MUwzM1kyTERzVk44?=
 =?utf-8?B?OU96SzlKN0wzUkVhcUZhcllHeDl4d1Z5RDFmenRNc3ROeEkvYTRrT3NVbk9h?=
 =?utf-8?B?MU0zdWhYZURMYS93eGFGU2JLa1A4Nk9HQklKTnpReXJYdGtWbVRBMVk5V09T?=
 =?utf-8?B?ekdsVEtKMjFIMWlENzV3ODdiY3JIVnNqRnc1L0VaVFkzczlzcWluODNVNHdH?=
 =?utf-8?B?WVg3UTB1R0VvbXNhenl0enlHbWM2N1ZRYkhkWllmTnRmQUJUYUpHcmhXKzFr?=
 =?utf-8?B?NlM0REtHdzl2a1VHNVpCWlR2MkRMZHhsNUhQNEs0bHlwckI0bmtCZ3VEamNI?=
 =?utf-8?B?YmI3Tjl6OXNRaE1LN3VFVzRVVjh6NitIOWtwdmZKKzYvV3F3NURWR0lXUkMz?=
 =?utf-8?B?dEcwV2pDUzNuOEVrMzdiODNDdUZ1U3h6LzlCZisvQnVLZ1plMVBsc1RwYVNJ?=
 =?utf-8?B?cUNWZENOcFQxdnpFdUpjdWQ1a21yK3dnOVh5QWlqK0J1U2JXL0cwSGpBL2Ex?=
 =?utf-8?B?QTZUQWFQZXdpZjdPck1IelA0a0MyeXgxNDVWQWFxSGtsYy9iT29oK2laZzhv?=
 =?utf-8?B?N2FaNUNxWXdYUTB1STQrcFZ6OGlmNW5IYjdYc0JxOFdGSUFiUlF1K25OTnpM?=
 =?utf-8?Q?AD4ZUhVsZzBUO2ho7gTh7bpPC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 844a84ed-5ff4-4c4a-ba41-08dc9f3310a9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 09:48:05.2885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCCckViU2lUVW+pdZMOCQHzc9MBy1zR3tC39IvN9tNwPDtyHtSCDe8Jr5d+gDLgXdxDS9zlRTxSmeOEvH4Sy7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9078



On 1/7/24 05:35, Lukas Wunner wrote:
> PCI device authentication v2
> 
> Authenticate PCI devices with CMA-SPDM (PCIe r6.2 sec 6.31) and
> expose the result in sysfs.


What is it based on?
I am using https://github.com/l1k/linux.git branch cma_v2 for now but 
wonder if that's the right one. Thanks,

> 
> Five big changes since v1 (and many smaller ones, full list at end):
> 
> * Certificates presented by a device are now exposed in sysfs
>    (new patch 12).
> 
> * Per James Bottomley's request at Plumbers, a log of signatures
>    received from a device is exposed in sysfs (new patches 13-18),
>    allowing for re-verification by remote attestation services.
>    Comments welcome whether the proposed ABI makes sense.
> 
> * Per Damien Le Moal's request at Plumbers, sysfs attributes are
>    now implemented in the SPDM library instead of in the PCI core.
>    Thereby, ATA and SCSI will be able to re-use them seamlessly.
> 
> * I've dropped a controversial patch to grant guests exclusive control
>    of authentication of passed-through devices (old patch 12 in v1).
>    People were more interested in granting the TSM exclusive control
>    instead of the guest.  Dan Williams is driving an effort to negotiate
>    SPDM control between kernel and TSM.
> 
> * The SPDM library (in patch 7) has undergone significant changes
>    to enable the above-mentioned sysfs exposure of certificates and
>    signatures:  It retrieves and caches all certificates from a device
>    and collects all exchanged SPDM messages in a transcript buffer.
>    To ease future maintenance, the code has been split into multiple
>    files in lib/spdm/.
> 
> 
> Link to v1 and subsequent Plumbers discussion:
> https://lore.kernel.org/all/cover.1695921656.git.lukas@wunner.de/
> https://lpc.events/event/17/contributions/1558/
> 
> How to test with qemu:
> https://github.com/twilfredo/qemu-spdm-emulation-guide
> 
> 
> Changes v1 -> v2:
> 
> * [PATCH 01/18] X.509: Make certificate parser public
>    * Add include guard #ifndef + #define to <keys/x509-parser.h> (Ilpo).
> 
> * [PATCH 02/18] X.509: Parse Subject Alternative Name in certificates
>    * Return -EBADMSG instead of -EINVAL on duplicate Subject Alternative
>      Name, drop error message for consistency with existing code.
> 
> * [PATCH 03/18] X.509: Move certificate length retrieval into new helper
>    * Use ssize_t instead of int (Ilpo).
>    * Amend commit message to explain why the helper is exported (Dan).
> 
> * [PATCH 06/18] crypto: ecdsa - Support P1363 signature encoding
>    * Use idiomatic &buffer[keylen] notation.
>    * Rebase on NIST P521 curve support introduced with v6.10-rc1
> 
> * [PATCH 07/18] spdm: Introduce library to authenticate devices
>    New features:
>    * In preparation for exposure of certificate chains in sysfs, retrieve
>      the certificates from *all* populated slots instead of stopping on
>      the first valid slot.  Cache certificate chains in struct spdm_state.
>    * Collect all exchanged messages of an authentication sequence in a
>      transcript buffer for exposure in sysfs.  Compute hash over this
>      transcript rather than peacemeal over each exchanged message.
>    * Support NIST P521 curve introduced with v6.10-rc1.
>    Bugs:
>    * Amend spdm_validate_cert_chain() to cope with zero length chain.
>    * Print correct error code returned from x509_cert_parse().
>    * Emit error if there are no common supported algorithms.
>    * Implicitly this causes an error if responder selects algorithms
>      not supported by requester during NEGOTIATE_ALGORITHMS exchange,
>      previously this was silently ignored (Jonathan).
>    * Refine checks of Basic Constraints and Key Usage certificate fields.
>    * Add code comment explaining those checks (Jonathan).
>    Usability:
>    * Log informational message on successful authentication (Tomi Sarvela).
>    Style:
>    * Split spdm_requester.c into spdm.h, core.c and req-authenticate.c.
>    * Use __counted_by() in struct spdm_get_version_rsp (Ilpo).
>    * Return ssize_t instead of int from spdm_transport (Ilpo).
>    * Downcase hex characters, vertically align SPDM_REQ macro (Ilpo).
>    * Upcase spdm_error_code enum, vertically align it (Ilpo).
>    * Return -ECONNRESET instead of -ERESTART from spdm_err() (Ilpo).
>    * Access versions with le16_to_cpu() instead of get_unaligned_le16()
>      in spdm_get_version() because __packed attribute already implies
>      byte-wise access (Ilpo).
>    * Add code comment in spdm_start_hash() that shash and desc
>      allocations are freed by spdm_reset(), thus seemingly leaked (Ilpo).
>    * Rename "s" and "h" members of struct spdm_state to "sig_len" and
>      "hash_len" for clarity (Ilpo).
>    * Use FIELD_GET() in spdm_create_combined_prefix() for clarity (Ilpo).
>    * Add SPDM_NONCE_SZ macro (Ilpo).
>    * Reorder error path of spdm_authenticate() for symmetry (Jonathan).
>    * Fix indentation of Kconfig entry (Jonathan).
>    * Annotate capabilities introduced with SPDM 1.1 (Jonathan).
>    * Annotate algorithms introduced with SPDM 1.2 (Jonathan).
>    * Annotate errors introduced with SPDM 1.1 and 1.2 (Jonathan).
>    * Amend algorithm #ifdef's to avoid trailing "|" (Jonathan).
>    * Add code comment explaining that some SPDM messages are enlarged
>      by fields added in new SPDM versions whereas others use reserved
>      space for new fields (Jonathan).
>    * Refine code comments on various fields in SPDM messages (Jonathan).
>    * Duplicate spdm_get_capabilities_reqrsp into separate structs (Jonathan).
>    * Document SupportedAlgorithms field at end of spdm_get_capabilities_rsp,
>      introduced with SPDM 1.3 (Jonathan).
>    * Use offsetofend() rather than offsetof() to set SPDM message size
>      based on SPDM version (Jonathan).
>    * Use cleanup.h to unwind heap allocations (Jonathan).
>    * In spdm_verify_signature(), change code comment to refer to "SPDM 1.0
>      and 1.1" instead of "Until SPDM 1.1" (Jonathan).
>    * Use namespace "SPDM" for exported symbols (Jonathan).
>    * Drop __spdm_exchange().
>    * In spdm_exchange(), do not return an error on truncation of
>      spdm_header so that callers can take care of it.
>    * Rename "SPDM_CAPS" macro to "SPDM_REQ_CAPS" to prepare for later
>      addition of responder support.
>    * Rename "SPDM_MIN_CAPS" macro to "SPDM_RSP_MIN_CAPS" and
>      rename "responder_caps" member of struct spdm_state to "rsp_caps".
>    * Rename "SPDM_REQUESTER" Kconfig symbol to "SPDM".  There is actually
>      no clear-cut separation between requester and responder code because
>      mutual authentication will require the responder to invoke requester
>      functions.
>    * Rename "slot_mask" member of struct spdm_state to "provisioned_slots"
>      to follow SPDM 1.3 spec language.
> 
> * [PATCH 08/18] PCI/CMA: Authenticate devices on enumeration
>    * In pci_cma_init(), check whether pci_cma_keyring is an ERR_PTR
>      rather than checking whether it's NULL.  keyring_alloc() never
>      returns NULL.
>    * On failure to allocate keyring, emit "PCI: " and ".cma" as part of
>      error message for clarity (Bjorn).
>    * Drop superfluous curly braces around two if-blocks (Jonathan, Bjorn).
>    * Add code comment explaining why spdm_state is kept despite initial
>      authentication failure (Jonathan).
>    * Rename PCI_DOE_PROTOCOL_CMA to PCI_DOE_FEATURE_CMA for DOE r1.1
>      compliance.
> 
> * [PATCH 09/18] PCI/CMA: Validate Subject Alternative Name in certificates
>    * Amend commit message with note on Reference Integrity Manifest (Jonathan).
>    * Amend commit message and code comment with note on PCIe r6.2 changes.
>    * Add SPDX identifer and IETF copyright to cma.asn1 per section 4 of:
>      https://trustee.ietf.org/documents/trust-legal-provisions/tlp-5/
>    * Pass slot number to ->validate() callback and emit it in error messages.
>    * Move all of cma-x509.c into cma.c (Bjorn).
> 
> * [PATCH 10/18] PCI/CMA: Reauthenticate devices on reset and resume
>    * Drop "cma_capable" bit in struct pci_dev and instead check whether
>      "spdm_state" is a NULL pointer.  Only difference:  Devices which
>      didn't support the minimum set of capabilities on enumeration
>      are now attempted to be reauthenticated.  The rationale being that
>      they may have gained new capabilities due to a runtime firmware update.
>    * Add kernel-doc for pci_cma_reauthenticate().
> 
> * [PATCH 11/18] PCI/CMA: Expose in sysfs whether devices are authenticated
>    * Change write semantics of sysfs attribute such that reauthentication
>      is triggered by writing "re" (instead of an arbitrary string).
>      This allows adding other commands down the road.
>    * Move sysfs attribute from PCI core to SPDM library for reuse by other
>      bus types such as SCSI/ATA (Damien).
>    * If DOE or CMA initialization fails, set pci_dev->spdm_state to ERR_PTR
>      instead of using additional boolean flags.
>    * Amend commit message to mention downgrade attack prevention (Ilpo,
>      Jonathan).
>    * Amend ABI documentation to mention reauthentication after downloading
>      firmware to an FPGA device.
> 
> * [PATCH 12/18 to 18/18] are new in v2
> 
> 
> Jonathan Cameron (2):
>    spdm: Introduce library to authenticate devices
>    PCI/CMA: Authenticate devices on enumeration
> 
> Lukas Wunner (16):
>    X.509: Make certificate parser public
>    X.509: Parse Subject Alternative Name in certificates
>    X.509: Move certificate length retrieval into new helper
>    certs: Create blacklist keyring earlier
>    crypto: akcipher - Support more than one signature encoding
>    crypto: ecdsa - Support P1363 signature encoding
>    PCI/CMA: Validate Subject Alternative Name in certificates
>    PCI/CMA: Reauthenticate devices on reset and resume
>    PCI/CMA: Expose in sysfs whether devices are authenticated
>    PCI/CMA: Expose certificates in sysfs
>    sysfs: Allow bin_attributes to be added to groups
>    sysfs: Allow symlinks to be added between sibling groups
>    PCI/CMA: Expose a log of received signatures in sysfs
>    spdm: Limit memory consumed by log of received signatures
>    spdm: Authenticate devices despite invalid certificate chain
>    spdm: Allow control of next requester nonce through sysfs
> 
>   Documentation/ABI/testing/sysfs-devices-spdm | 247 ++++++
>   Documentation/admin-guide/sysctl/index.rst   |   2 +
>   Documentation/admin-guide/sysctl/spdm.rst    |  33 +
>   MAINTAINERS                                  |  14 +
>   certs/blacklist.c                            |   4 +-
>   crypto/akcipher.c                            |   2 +-
>   crypto/asymmetric_keys/public_key.c          |  44 +-
>   crypto/asymmetric_keys/x509_cert_parser.c    |   9 +
>   crypto/asymmetric_keys/x509_loader.c         |  38 +-
>   crypto/asymmetric_keys/x509_parser.h         |  40 +-
>   crypto/ecdsa.c                               |  18 +-
>   crypto/internal.h                            |   1 +
>   crypto/rsa-pkcs1pad.c                        |  11 +-
>   crypto/sig.c                                 |   6 +-
>   crypto/testmgr.c                             |   8 +-
>   crypto/testmgr.h                             |  20 +
>   drivers/pci/Kconfig                          |  13 +
>   drivers/pci/Makefile                         |   4 +
>   drivers/pci/cma.asn1                         |  41 +
>   drivers/pci/cma.c                            | 247 ++++++
>   drivers/pci/doe.c                            |   5 +-
>   drivers/pci/pci-driver.c                     |   1 +
>   drivers/pci/pci-sysfs.c                      |   5 +
>   drivers/pci/pci.c                            |  12 +-
>   drivers/pci/pci.h                            |  17 +
>   drivers/pci/pcie/err.c                       |   3 +
>   drivers/pci/probe.c                          |   3 +
>   drivers/pci/remove.c                         |   1 +
>   fs/sysfs/file.c                              |  69 +-
>   fs/sysfs/group.c                             |  33 +
>   include/crypto/akcipher.h                    |  10 +-
>   include/crypto/sig.h                         |   6 +-
>   include/keys/asymmetric-type.h               |   2 +
>   include/keys/x509-parser.h                   |  55 ++
>   include/linux/kernfs.h                       |   2 +
>   include/linux/oid_registry.h                 |   3 +
>   include/linux/pci-doe.h                      |   4 +
>   include/linux/pci.h                          |  16 +
>   include/linux/spdm.h                         |  46 ++
>   include/linux/sysfs.h                        |  29 +
>   lib/Kconfig                                  |  15 +
>   lib/Makefile                                 |   2 +
>   lib/spdm/Makefile                            |  11 +
>   lib/spdm/core.c                              | 442 +++++++++++
>   lib/spdm/req-authenticate.c                  | 765 +++++++++++++++++++
>   lib/spdm/req-sysfs.c                         | 619 +++++++++++++++
>   lib/spdm/spdm.h                              | 560 ++++++++++++++
>   47 files changed, 3436 insertions(+), 102 deletions(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-devices-spdm
>   create mode 100644 Documentation/admin-guide/sysctl/spdm.rst
>   create mode 100644 drivers/pci/cma.asn1
>   create mode 100644 drivers/pci/cma.c
>   create mode 100644 include/keys/x509-parser.h
>   create mode 100644 include/linux/spdm.h
>   create mode 100644 lib/spdm/Makefile
>   create mode 100644 lib/spdm/core.c
>   create mode 100644 lib/spdm/req-authenticate.c
>   create mode 100644 lib/spdm/req-sysfs.c
>   create mode 100644 lib/spdm/spdm.h
> 

-- 
Alexey


