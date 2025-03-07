Return-Path: <linux-pci+bounces-23086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C226A55E05
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 04:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D91016D207
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 03:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57BC1CFBC;
	Fri,  7 Mar 2025 03:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z2SxeBzX"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C069916C69F
	for <linux-pci@vger.kernel.org>; Fri,  7 Mar 2025 03:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741316890; cv=fail; b=F1Avem5kRpx9Sh2JZtDPegnpGxeTUX2pfkXwZOotI+FOz9pYJT2HqLyl7nGs2QfVonqUep8/5D8G2GznNyOBt8c7T0B9rBSxAN3++ub0W8Gmw064Ja/e3p4cFJH6Dxb1lHisTyob9Jc7xORHbIhRnhN/yXfDrP6ASdcVgOZ0GJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741316890; c=relaxed/simple;
	bh=2raTjDV+gkrK/f63Po7m/ADnUmC2BtOJGs37CcPH3Cw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VvC5hoN/n/4n84op0sKAt1XP2omnkklb9XLjzXTcoOyyoXGv/xHoz7beqnTc4Tb/UpW+AvB+uxm+ueh9ZnDrfKJK5JGQXWc6An9LArYUhzq6l+AuLRQrxPzbxczcpV2glpCus7eyTpfqBVNgXIZMbLW+94yypSmOfO7DxcEyxuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z2SxeBzX; arc=fail smtp.client-ip=40.107.102.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ELe4EZ64qjQb7MhwUG0Kwk/V36Ju8G5s0Otdur/DX/JA7hbzfnr96HrZGVEgwb0f2uWoIBAYYwvPKqoSq6IPmO6A/bgm+gmELVRvORlkxp30SbJhyyLfeSnYmeHfzykcafHi09iOdeI9eY2HEn6D+A3WU+DqAS2YgQSVWjanVJtatnqdnK3xwlyfEBBBIqxD57hoKOFfFrroXxiZQcgJxUmbZ0rcK2B9G/2xN5qOtkSVQshjmCMrLmVa3My7kCRR/gDONKHdxZepvUxMwJyhEEpwDJLHFcsFkAei4cF8J8ShH/2HwEQGzGX14Vl9IfGh64CR6qV8LbnL452VXQ6SjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2K2v/3dBSUxwyu38g0HhHkUILdbRi5ue57det81SiLA=;
 b=IjG/7QixbMKMJcEU8nvg+4nmhKMWiaqteYuO2zJso0Kc2tRGpY5B3B00EziN5RM5MTlpSNnUjcx9juOc+E7YrGsH8A6v1ZmTEmIHduDz4V/UGj9zQ+D3dyiWnXfuCiXQhNmOhy8JN42s2UdkOYnJ5rbj1IrNlt3l51h+Ldlwp7d48q4SGpnzsqH76SCulSqpLlhu+/fLjOXUH4pL2t0fpwn3uEmvqxHdzwu2dLhoyiP1Uq8AJCYF6oWJ6qjf1/lhTVqJa34pCuMBHBmkc5KmE0e4FZ9mjubBw/otYnzaCuDvkU8JzkMS2JLn+XSt2ou37UzAPpmmHaCBwQRwlxbZeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2K2v/3dBSUxwyu38g0HhHkUILdbRi5ue57det81SiLA=;
 b=Z2SxeBzX03iansgovHHEThTte7Gi81iB5s8OhHI9xtn89ZK2R+x29ie1NIYvQKljzyYJnWV/b8VZkPVo5F6Hnj2IXEg1Idb7LbygRJdHEHkW3zwi5oGTcX1NZlsoHnIjYtyf4W1Jj/2gf6LuYNsMYHjjnua1otzOr8zcqGyMmhc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by MW6PR12MB8757.namprd12.prod.outlook.com (2603:10b6:303:239::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 03:08:06 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%3]) with mapi id 15.20.8489.025; Fri, 7 Mar 2025
 03:08:06 +0000
Message-ID: <177ee064-4416-479c-b2f0-cf150b7c4a55@amd.com>
Date: Fri, 7 Mar 2025 14:07:58 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 05/11] PCI/TSM: Authenticate devices via platform TSM
Content-Language: en-US
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Xu Yilun <yilun.xu@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 gregkh@linuxfoundation.org
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343742510.1074769.16552514658771224955.stgit@dwillia2-xfh.jf.intel.com>
 <efc5ba59-964d-4988-a412-47f5297fedd3@amd.com> <yq5aeczrww9j.fsf@kernel.org>
 <Z71umSkkyV0rAC25@yilunxu-OptiPlex-7050> <yq5a4j0gc3fp.fsf@kernel.org>
 <Z8AHtcYgz2JukdfM@yilunxu-OptiPlex-7050> <yq5aa5a78p8d.fsf@kernel.org>
 <Z8EQsFiVAxtWfulx@yilunxu-OptiPlex-7050> <yq5a4j0e8kn0.fsf@kernel.org>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <yq5a4j0e8kn0.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEWPR01CA0156.ausprd01.prod.outlook.com
 (2603:10c6:220:1d9::14) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|MW6PR12MB8757:EE_
X-MS-Office365-Filtering-Correlation-Id: a47b89ed-b40c-46bb-8072-08dd5d254804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkRpZis1U0NrbjFSTVBSTTBZOUQxdE95d2JrSnhlb283ZVo2cTRLRk44TDRz?=
 =?utf-8?B?OGNwZUFPMVRRZEkvQ00rWkZUWUlRaEJ4SGhkanVHdTkwb2hxWVlvUEw1dHpP?=
 =?utf-8?B?amFzNTIwcHVja1FscEZzNS84Rkk2OFhlT1IySU1MVktJNTZEd0ZOeTJleTdv?=
 =?utf-8?B?b3hIT0tqNUEyYngyUFF4bWJqUG42Ukkrd3E3UnQ5NnNCek1WL3R3dmw5UTY4?=
 =?utf-8?B?aDhhTnAycnBDeDluTm1TZkl1NUU5YlRRUkJYbDduSDhJelJUTjZvNlovM1lz?=
 =?utf-8?B?TDRmQ2lnaUZxYXFzVHI2YkhQbkkxSXRiTUc0dnRQMm1vN0U3cDBlYU8rUFEy?=
 =?utf-8?B?bGhZRmt2Q1pwc2JSUDBodzhCQlBMclRReGx4S3lOQTZVQkVlQjg2a1duTy9o?=
 =?utf-8?B?U3VPZXk5YndyYTdxU3BpRTZKb1hZUWZQL3dBRE1hKzIwNVdiTHpBVzJIS1lW?=
 =?utf-8?B?Y1lJRjFtemJ0bGhvdjhMcFByakRlWkttWVhzQ3liUXBrZWFCak51d091OEpq?=
 =?utf-8?B?UFBJUndmTmRyTHZTTTE5aWthTWNtbDc0UDJ2dTVjeS8yVmNrdkFQTjQybUdz?=
 =?utf-8?B?T1BIQkVnbGp6eml5OGJMdWlnQ0syVWt3TjBlbHg5SUUwbVJJSUlCWVhtSEkz?=
 =?utf-8?B?Q0pSdWpVa1c3Y0F1clJFcFg4c01XYS9aNllRRWFQSE1rQjdlRG5qZVA0ZzFF?=
 =?utf-8?B?ZXpGZDE3OW5XUWFFbGZTRHkzNmtDcjg5SG0zS29tL1FzNThtenZ2ZXJnS29V?=
 =?utf-8?B?azcwa09vdXZSRjFjMHJmc1BSTTV2Uk95RG9ETUx2ZCsva2JsUVRwdnd6d2JS?=
 =?utf-8?B?VUs4VzFLVmNhYTBOUC8ySzd1NzVkMS82dG1DT21LQVRHMDBwOWFzWWFEOHZw?=
 =?utf-8?B?eWdiU25yaURVVGVqbEFlOVdBUWpURm5wRVBjZ082VFI0bWhmakczWE9zcTBa?=
 =?utf-8?B?NmNCR2MvcXlsY1NzR0lzcEI3dDRFZGhmb2VKRXpSUUtPVlo3L3dvWkV0VzYv?=
 =?utf-8?B?MUFpUGRNWjBHUEI2c3oyM1BPM3R5THp6OGlTQ05JRDcxeU9ONXl1NkE3YVpw?=
 =?utf-8?B?SHpibTRnZHJ2UU5jOXd6T2t1ZkdZY3hJVWNjcmo5NDNXWGQ0OTdMbTM3V0o0?=
 =?utf-8?B?N0I2TmFMTFY3ODhWbEo5QWhLcGpSN1NsOWR2SUEwSW02N2I5SUtUQy9tcDhO?=
 =?utf-8?B?aVliWjlxVGhqNmQrSHJXQS9HM01wOG8rVUpQMUZyenNmemFqbEFHbmdqYUp4?=
 =?utf-8?B?Q2tNbkoyOEhvQkZBL3VhU0VPczRBVHAwR3VtZmdsTHEyZzFpUnRzMXhUUDFF?=
 =?utf-8?B?SGxZK2oxVHpzZXBiUWZtM1FsQnhzd1Q5VFhvNkVTZ3VtQjJ5MGxIQmNRZXVQ?=
 =?utf-8?B?UWxlZVVIbCtzWHlDdURYS3RNK2hmZlB3VXhLQURUaUVEMWVUT2ZnUG82VkpZ?=
 =?utf-8?B?S0hlaDNvN0ZlUzRjQzdGbnFEb1lqZHpsSXVmZXQ3Rmk3dW42c2tyaVdIdU5t?=
 =?utf-8?B?UUl1N0JsbXp0UnJDaEJ3cVNZT0I2R1ovZld4MjA4TVpRS2lKbGJ0RWVVNGVa?=
 =?utf-8?B?OGdob1JNb2lsREZTVDBiRS9iczM0MHQ3YTg2V202SXVxa2dFRUYvWEZGSDhL?=
 =?utf-8?B?UHlaYkN5Vm4zK1Z4MEtiaWhPOU0wRjQ3VXVBMTYvYkVvVU1CTXVHRFlRYVhD?=
 =?utf-8?B?bGd1RkVyc0hFTGFsRUhBSXZaY3hmMnlSK3BFY3NubUVpbjBiOW9nckViblRG?=
 =?utf-8?B?K29OT3VjaHRKKzcvSkpZMFZlSXpkaEs5OTBXbXg3dE85Ym9uOEt3WDNwRWI5?=
 =?utf-8?B?ZURENFhFSXUwT2gvV0R6eUcyajZtTWszS1oydlZRVmZic21senJYbkpkd3Fl?=
 =?utf-8?B?dHlIcEVhR3VPcFIwVEZ3NkJjSTYvRnF2c0ZQZ2FacjFDS0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2cyVGZMQ1A3WGN2b2xMbjFFL3lEVDgwdTNDaUZEVk5LVCtncUNuSjRJc1Ra?=
 =?utf-8?B?VHVMY1ROUmF4TG0vMHU2emhlUDlsbFJUTUE4S3Rub1AwYVphbW9wOWpqQXlZ?=
 =?utf-8?B?VkdpZDdOUjdQVHdzbGVlMG9ySEVLWVEzVXVGMWdxMk9EblJQUndqbUIrb2sy?=
 =?utf-8?B?TS9rbkl4V1FqeWVWYXhJSHdVSGNxRjJKU3MrTWE1QiszS1VLeXYxUTZJWGxo?=
 =?utf-8?B?SUgrcVNOejl3WmZkRVJMdTJGZDJHbWZLcTcyeHFSTjBDeDQzRXJ5bGZreC9x?=
 =?utf-8?B?M2FGVnp6SUdyTy9LVHlDUzJ5cmV5MS8rOGt1NmYwaEExa3FyMGFaTFRQUmtV?=
 =?utf-8?B?WDZGSW5kSkRNRzNjZlFrazhIajM5UFRLc1BVT2l6RFlndXp0UCtBWm1tTHpL?=
 =?utf-8?B?ck1VaGtidVhuRFp5UVRiSmhXaDgyUVhDREVzdnEvbUhqYnBCTk5Bakp4d0Nh?=
 =?utf-8?B?YjdGa1U3VXh5WitFV0Urb0x0L0NpazFXOTd4YlkxeUlZT3RxS1RzYW44Qjdl?=
 =?utf-8?B?RW5EK21lNkx2K2srSU1DZVRvc25sYVFUVjArZzZ5cm55OEFjSDdrMHl3ekRR?=
 =?utf-8?B?NHV4d05KSWFmM2FZMVBiL3dNY0NKR21oZlJtZ3BwNmFreTMwVW04azMrMmVv?=
 =?utf-8?B?VEozNXN6UEpQem9xL2xJaldJbDdPdmRjZ3dvQkUxRTlNVlBNcURKdlhHU1hC?=
 =?utf-8?B?M1gzbHdQcjc5OUJ1Yko5MkFiOGVHUmZDbW1ZR3EzNVhHOVBLRnF1NzdqWkR3?=
 =?utf-8?B?Y3pNN0pZWjhpZWxqaGJPWFhHN281em42OTBMY2ZBa1UrZVFVZEM4Y0NHWXE2?=
 =?utf-8?B?RlZ3VW1jeU05LzV3Nkl3VS9TR1pGTGtFS3lES2dMRTF0MW03QUVNd2pERWo0?=
 =?utf-8?B?Y3p6dzIxdjZWMWxWdHpPOVZXS013S3BqQ3phVDNuY3Y4N0JnKys2Y3ZNUzls?=
 =?utf-8?B?UjdqSHE4d0ZuejRqSmVhNEtwZ2pxLy81V2JhM0U2Wkp3NDFQVGcrWjNEMlBP?=
 =?utf-8?B?TDB1ZEIrbko0UFpRV0pkLzVMVStvSm8vYjVRY2FXdlBudUFJZTJOSzJtbmh1?=
 =?utf-8?B?Q3RBM0J5SHBWZ1lnZnZBZ05BQWZKSlZLUnFYeXdqL2lLZFlnR2ZUd0pXbWx3?=
 =?utf-8?B?RVZJcFhqbU1kaEpqVStiYWU1dnhoK1lVaFBtdzhkd1B2U2duSmU3b244SmlM?=
 =?utf-8?B?Mmp3OXVxbVFwYmRUUjVyZk1NeExGMitNN3FTdDd2NnlMRk5VNk5NbDZTMkZy?=
 =?utf-8?B?YktHWUl2Unl2THU4TDdHWlZaSklWeERDWE5iN3NjZTkwM0k2YXVBZTV3WkFZ?=
 =?utf-8?B?b0dKS1M5eGUvMmhOaThHK2g3ZjY4R0NUMUd1K29KdjdMSGVIZlFUTHdpSCth?=
 =?utf-8?B?RXJvb0xLY1NGZDVrL0VIL1JienFpSWZLNzA0RmdLdUUzVEFkd0pyNzg3Vmd5?=
 =?utf-8?B?Q25oa1daQURZYnpBN29pQmtqTHMvMEFIVW5FQ0dPTTE2ZWIvcW1Pakp5cG9m?=
 =?utf-8?B?dnRlbkJYRFc1cjJJOHZ3d3NkRm9SQ2RnSmg4VDRacng5TnlPSWtRL0hnWWYv?=
 =?utf-8?B?MmdvWDBuNFJ6MHhVMHg4bmV5UHlSUGp0Y0ZHRERKR0RNbTFWc0pGTzFvcnkw?=
 =?utf-8?B?V1NacHVFcnNXY205Nzdya1NvTHR2TDYrOXlTZHZ4NzFxdTBEZHhsc3dIdkhK?=
 =?utf-8?B?VTJkK29oNkw3bjNrYW03cURmdVplU0twNTU2YTlDc2NXdDlQSjBMMjc5ZGF1?=
 =?utf-8?B?UlhTSGNjSU5lc1R3UTdLbk5VVGZ3K0hLaVB0amFCV0V0M3dtTkZ5OFpDNTRW?=
 =?utf-8?B?UXJ0TmtqUkxhckhObXB0SFd4SCtSQVBtLysxTkx3cXJmc0VrcllFMkJUT3JZ?=
 =?utf-8?B?QVUvYzhtWEVqTUpmcS9aZCt6cHVKc2xOMmsvV1lZRHVyY2c1WlhkRWxybDZO?=
 =?utf-8?B?bkt4Y21WbUZISWl0LzdQYTQveTBOR0psVTM2YnZVVVc1dGlYS0haeHRRMStr?=
 =?utf-8?B?T1RvQnRjODBsOUN4azd1NzdJMDZLL3F0WlhjQ2prZ2Q5WjNheGdvQUUxMHpG?=
 =?utf-8?B?QVdHUmdHaXE1NGg3UTdHTjBieXQ2N256Y1lER0xhSmFOSC9tM09GTmU5cE9r?=
 =?utf-8?Q?O5e7fpwOQgJCY7406sZrzLnCd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a47b89ed-b40c-46bb-8072-08dd5d254804
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 03:08:06.1435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2D+5mF83IS8Fyu3zRf+HgN9441OGRZEeLXJG1ApE9fV+HjyulwscS2b5kbTBZANLxmAIn5IrZYRS72V+V96/jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8757



On 28/2/25 20:48, Aneesh Kumar K.V wrote:
> Xu Yilun <yilun.xu@linux.intel.com> writes:
> 
>> On Thu, Feb 27, 2025 at 07:27:22PM +0530, Aneesh Kumar K.V wrote:
>>> Xu Yilun <yilun.xu@linux.intel.com> writes:
>>>
>>>> On Wed, Feb 26, 2025 at 05:40:02PM +0530, Aneesh Kumar K.V wrote:
>>>>> Xu Yilun <yilun.xu@linux.intel.com> writes:
>>>>>
>>>>>> On Fri, Feb 21, 2025 at 01:43:28PM +0530, Aneesh Kumar K.V wrote:
>>>>>>> Alexey Kardashevskiy <aik@amd.com> writes:
>>>>>>>
>>>>>>> ....
>>>>>>>
>>>>>>>>
>>>>>>>> I am trying to wrap my head around your tsm. here is what I got in my tree:
>>>>>>>> https://github.com/aik/linux/blob/tsm/include/linux/tsm.h
>>>>>>>>
>>>>>>>> Shortly:
>>>>>>>>
>>>>>>>> drivers/virt/coco/tsm.ko does sysfs (including "connect" and "bind" to
>>>>>>>> control and "certs"/"report" to attest) and implements tsm_dev/tsm_tdi,
>>>>>>>> it does not know pci_dev;
>>>>>>>>
>>>>>>>> drivers/pci/tsm-pci.ko creates/destroys tsm_dev/tsm_dev using tsm.ko;
>>>>>>>>
>>>>>>>> drivers/crypto/ccp/ccp.ko (the PSP guy) registers:
>>>>>>>> - tsm_subsys in tsm.ko (which does "connect" and "bind" and
>>>>>>>> - tsm_bus_subsys in tsm-pci.ko (which does "spdm_forward")
>>>>>>>> ccp.ko knows about pci_dev and whatever else comes in the future, and
>>>>>>>> ccp.ko's "connect" implementation calls the IDE library (I am adopting
>>>>>>>> yours now, with some tweaks).
>>>>>>>>
>>>>>>>> tsm-dev and tsm-tdi embed struct dev each and are added as children to
>>>>>>>> PCI devices: no hide/show attrs, no additional TSM pointer in struct
>>>>>>>> device or pci_dev, looks like:
>>>>>>>>
>>>>>>>> aik@sc ~> ls  /sys/bus/pci/devices/0000:e1:04.0/tsm-tdi/tdi:0000:e1:04.0/
>>>>>>>> device  power  subsystem  tsm_report  tsm_report_user  tsm_tdi_bind
>>>>>>>> tsm_tdi_status  tsm_tdi_status_user  uevent
>>>>>>>>
>>>>>>>> aik@sc ~> ls  /sys/bus/pci/devices/0000:e1:04.0/tsm_dev/
>>>>>>>> device  power  subsystem  tsm_certs  tsm_cert_slot  tsm_certs_user
>>>>>>>> tsm_dev_connect  tsm_dev_status  tsm_meas  tsm_meas_user  uevent
>>>>>>>>
>>>>>>>> aik@sc ~> ls /sys/class/tsm/tsm0/
>>>>>>>> device  power  stream0:0000:e1:00.0  subsystem  uevent
>>>>>>>>
>>>>>>>> aik@sc ~> ls /sys/class/tsm-dev/
>>>>>>>> tdev:0000:c0:01.1  tdev:0000:e0:01.1  tdev:0000:e1:00.0
>>>>>>>>
>>>>>>>> aik@sc ~> ls /sys/class/tsm-tdi/
>>>>>>>> tdi:0000:c0:01.1  tdi:0000:e0:01.1  tdi:0000:e1:00.0  tdi:0000:e1:04.0
>>>>>>>> tdi:0000:e1:04.1  tdi:0000:e1:04.2  tdi:0000:e1:04.3
>>>>>>>>
>>>>>>>>
>>>>>>>> SPDM forwarding seems a bus-agnostic concept, "connect" is a PCI thing
>>>>>>>> but pci_dev is only needed for DOE/IDE.
>>>>>>>>
>>>>>>>> Or is separating struct pci_dev from struct device not worth it and most
>>>>>>>> of it should go to tsm-pci.ko? Then what is left for tsm.ko? Thanks,
>>>>>>>>
>>>>>>>
>>>>>>> For the Arm CCA DA, I have structured the flow as follows. I am
>>>>>>> currently refining my changes to prepare them for posting. I am using
>>>>>>> tsm-core in both the host and guest. There is no bind interface at the
>>>>>>> sysfs level; instead, it is managed via the KVM ioctl
>>>>>>>
>>>>>>> Host:
>>>>>>> step 1.
>>>>>>> echo ${DEVICE} > /sys/bus/pci/devices/${DEVICE}/driver/unbind
>>>>>>> echo vfio-pci > /sys/bus/pci/devices/${DEVICE}/driver_override
>>>>>>> echo ${DEVICE} > /sys/bus/pci/drivers_probe
>>>>>>>
>>>>>>> step 2.
>>>>>>> echo 1 > /sys/bus/pci/devices/$DEVICE/tsm/connect
>>>>>>>
>>>>>>> step 3.
>>>>>>> using VMM to make the new KVM_SET_DEVICE_ATTR ioctl
>>>>>>>
>>>>>>> +		dev_num = vfio_devices[i].dev_hdr.dev_num;
>>>>>>> +		/* kvmtool only do 0 domain, 0 bus and 0 function devices. */
>>>>>>> +		guest_bdf = (0ULL << 32) | (0 << 16) | dev_num << 11 | (0 << 8);
>>>>>>> +
>>>>>>> +		struct kvm_vfio_tsm_bind param = {
>>>>>>> +			.guest_rid = guest_bdf,
>>>>>>> +			.devfd = vfio_devices[i].fd,
>>>>>>> +		};
>>>>>>> +		struct kvm_device_attr attr = {
>>>>>>> +			.group = KVM_DEV_VFIO_DEVICE,
>>>>>>> +			.attr = KVM_DEV_VFIO_DEVICE_TDI_BIND,
>>>>>>> +			.addr = (__u64)&param,
>>>>>>> +		};
>>>>>>> +
>>>>>>> +		if (ioctl(kvm_vfio_device, KVM_SET_DEVICE_ATTR, &attr)) {
>>>>>>> +			pr_err("Failed KVM_SET_DEVICE_ATTR for KVM_DEV_VFIO_DEVICE");
>>>>>>> +			return -ENODEV;
>>>>>>> +		}
>>>>>>> +
>>>>>>
>>>>>> I think bind (which brings device to a LOCKED state, no MMIO, no DMA)
>>>>>> cannot be a driver agnostic behavior. So I think it should be a VFIO
>>>>>> ioctl.
>>>>>>
>>>>>
>>>>> For the current CCA implementation bind is equivalent to VDEV_CREATE
>>>>> which doesn't mark the device LOCKED. Marking the device LOCKED is
>>>>> driven by the guest as shown in the steps below.
>>>>
>>>> Could you elaborate why vdev create & LOCK can't be done at the same
>>>> time, when guest requests "lock"? Intel TDX also requires firmware calls
>>>> like tdi_create(alloc metadata) & tdi_bind(do LOCK), but I don't see
>>>> there is need to break them out in different phases.
>>>>
>>>
>>> Yes, that is possible and might be what I will end up doing. Right now
>>> I have kept the interface flexible enough as I am writing these changes.
>>
>> Good to know that, thanks.
>>
>>> Device can possibly be presented in locked state to the guest.
>>
>> This is also what I did before. But finally I dropped (or pending) this
>> "early binding" support. There are several reset operations during VM
>> setup and booting, especially the ones in bios. They breaks LOCK state
>> and I have to make VFIO suppress the reset, or reset & recover, but that
>> seems not worth the effort.
>>
>> May wanna know how you see this problem.
> 
> Currently, my approach involves a split vdev_create and a TDISP lock, which is
> why I haven't encountered the issue mentioned above. The current changes
> implement vdev_create via the VMM, while the guest makes an RSI call to
> switch the device to the locked state.
> 
> I chose to separate vdev_create and TDISP lock into two distinct steps
> to simplify the process and better align it with the RMM spec [1].
> 
> I noticed that SEV-TIO performs a KVM_EXIT_VMGEXIT, which carries out a
> similar operation unless it has already been handled during VM startup.
>  From your reply above, I understand there was a proposal to combine
> VDEV_CREATE and TDISP_LOCK. However, you also mentioned that if we
> present the device in a locked state to a VM early in the boot process,
> we might unintentionally break the TDISP lock state.


Linux will break it (or/and my device are buggy?), I have this in my stash:

https://github.com/aik/linux/commit/805d6763d349be173a93a4411912c4763ab44c60
"RFC: PCI: Avoid needless touching of Command register"


> I will look up the previous discussions to better understand the
> rationale behind combining vdev_create and lock.

It is the opposite, there is no obvious reason to separate these so we 
are trying to make things simpler for now.


> [1] https://developer.arm.com/-/cdn-downloads/permalink/Architectures/Armv9/DEN0137_1.1-alp12.zip

ah this is the spec. "Realm Management Monitor" is not very obvious 
name when searching for TDISP (but I did not try hard :) ) Thanks,


> 
> -aneesh

-- 
Alexey


