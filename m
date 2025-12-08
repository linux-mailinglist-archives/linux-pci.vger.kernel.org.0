Return-Path: <linux-pci+bounces-42744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD542CABB49
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 01:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 595583015EF6
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 00:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D921C4A20;
	Mon,  8 Dec 2025 00:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FkgFcFVV"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010051.outbound.protection.outlook.com [52.101.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CBA1F94A;
	Mon,  8 Dec 2025 00:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765155469; cv=fail; b=dE4qllczyjTaZUYbZMr9S7gfqh/mF+51jmSOuWilUT+k6s0DjcmnxDyXGvOx/kY85o0nV/MiJ22/pH7ArW/02wkxbsW//JnrIafnrBDKzclzBgPKgRD/uQt1mcQ28yJBfi0VcTcxxAMKNN7Cqp/vNeSN+QeFACukysStNiLAbsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765155469; c=relaxed/simple;
	bh=Nv4Wmji9cH4xYom1gh/cUYOxHwbLHgItidE/sv1LCCQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g/qFjJ06MHnjjqewP9VvNuzeAAZj0TZJbJUiDG3hMpnSTmR8ZaTMNAygHTd5vSZvx99Q69tycbjIDKiMmO9wZEDNmn/jaTZVygJEqgk1NVMuSmgzcrv7P32P5Pe8SKHbX7QKSFKZNgSsvKbTjPcElYlnbkko3fLFpJBIAoFNfts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FkgFcFVV; arc=fail smtp.client-ip=52.101.193.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NeVZVfcj0+BDqdAuqzdkBrdXjlwyFiRzsTPDZnOg5yASPgsUfih6qmXu0AqGKIL9BZebLT0vDfwoP1qcFom8TtKP0qCIht6DoKkyT+XZKTD0hEvzi0NdDV9TX90vU+c62ryKg5tYYVNYy/6ftpezz7amUYX/V+mVqbanHPgOeKSDgs7yeM61Q9x/AksC3NBN6ndA+ByCPb3m9fnRSwQ71qnvPrVEwoc5Dy6mRZkla6EKjbFY5vlAfBcCfgfOZfSARz/cXsnreihJWwdohn3n6AfKR5lyr31s2De/E279HlI8JkpPQ9kT0VXo1dnGj5f1Bo/Yd2Svv1H7g3s3lsLqHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMPxL8R3ahPlt5tqKE6AfbVj1wvdAKa269QMaJLaarU=;
 b=KZmxWo5fTTz1fc91GDliqmSQXx8+0NP48wQ9ZdvsHqi5QxXUvqDRwI7JDCuQJDO018wn209pYB6vqkYei6QSJqmz+2e0OC9HiXT6OI6W0R7DBdyHnr+MaT4KHwk0pnFYJfy64PwkNpn2nl8ds3OQn6FvoeuPX80dZTx+6jodwYSf3WTuz0UcCSwRycbDEfCbGaRSvtgpIFVkA0FBQW7F9oXM9pOivY8CW/vV052JXi11siipsTlkjJpc8CoXiNkthhDYPjWtSfRIkZ8Q4orUYMDWjMgz55g1g8dicHTMwJNNalzUUdI3x6yqKMHo2g1cASeaq2IGJnbABC4Z8hJZng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMPxL8R3ahPlt5tqKE6AfbVj1wvdAKa269QMaJLaarU=;
 b=FkgFcFVVwhqo++7YIqo5DXMXl9bwAY4X+LIaiZe5TwaOYWVNb40Tw15SB/c2nskZQU8VWbHPymV0/M9echhzpQqDsNp1lixLetjoOa6vM/c02ASXFPvWmcV5nemLpW6kBn+H04BIC0aEFU+onvYjgWw536LE3ukak75Nw0a5Jgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.13; Mon, 8 Dec
 2025 00:57:45 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 00:57:44 +0000
Message-ID: <6a2f2abf-4e9a-4569-867c-1aebfb921a0b@amd.com>
Date: Mon, 8 Dec 2025 11:56:34 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [GIT PULL] PCIe Link Encryption and Device Authentication
To: Linus Torvalds <torvalds@linux-foundation.org>, dan.j.williams@intel.com,
 Joerg Roedel <joerg.roedel@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xu Yilun <yilun.xu@linux.intel.com>,
 "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
References: <69339e215b09f_1e0210057@dwillia2-mobl4.notmuch>
 <CAHk-=wh9dTX5eg0+NruSDbOCT_tafsO=a8m3cbhxFBvt-21bxQ@mail.gmail.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <CAHk-=wh9dTX5eg0+NruSDbOCT_tafsO=a8m3cbhxFBvt-21bxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0001.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:208::15) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|MW6PR12MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: a4aacfa7-2f8e-4320-b756-08de35f4cbef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0Z0M1BacnphQSszdGFUaUxhZ3BuOFowOHNxSnhYV21oMm1BOEJkempoWWJr?=
 =?utf-8?B?NmNoNWRVMFBMWnVDcjA4WStuWDRvYjVNVGJQTXluUFRqR2JUWVdPbjlvZ255?=
 =?utf-8?B?NE4raWh0UHpTMXordExYSUFCSC9NMVk3ZzE3eHczcVI1cVpxR1l0bVZIS1Jn?=
 =?utf-8?B?N2xwMjJiTHlHdG85eXJMR05Tai9Xd2tKUDRaa1dBNDZRTThKU3VBM0dmTm9Q?=
 =?utf-8?B?SUhjcE1xMzd1K3BtanRTWnlFSGVXSHppSU8ySUNWbnlEaU9HTFN1RU05SlFX?=
 =?utf-8?B?cS9mb1B6MnZiMW1Gbkk2VkVSZHk4MVVoK2ZUSmkxOEc5UE9CT1phSkhiOEdl?=
 =?utf-8?B?SFFVUC9LeVN6ajV3ZGlwV1RRM0hxaS8wYXEvSEp2a1FFRFYrNVBCNnhKQzhj?=
 =?utf-8?B?ZFhnOFFNK0JRTFlveTRSY1RseVZ0RGFucElOME5TU3JuVXE5SEkxZVhRY0lC?=
 =?utf-8?B?WU5hUWV3czBIaXBiYUpLUVdrOGtZdHB1Y1piN2ZCOXFRS0dHN0VyYTZkZnps?=
 =?utf-8?B?ZkRTNUlqSkEzSWtrYkdTalNocFBJdWVlM2h5Rm5DTEN1cjBPeXk1aEhZZml5?=
 =?utf-8?B?S0djN0NiUkFCenl5Y0NLZWlPeldZcXRrYnBVTndoK2MyZnQ5T1BNcUNvTnlI?=
 =?utf-8?B?SUdyTVZka3dDTzlHaDFJRmQ3Ukorc3Vma2MxcE5ybkxScm9OcWFUSzdrenRz?=
 =?utf-8?B?L25iUXg1VmpWYmJFMVNtY3JCc1llQ2hhakxRYmtWYzJKOTZWWHhxZy8rU3Jv?=
 =?utf-8?B?Zk5BTldGNzl1UXRLZmptK3Z6ek5qQTBzdTFzYlNsVGs5V09LckZ5azZLRVJw?=
 =?utf-8?B?NHFlRWtCUlVycERMWWJNSUlrOTVVVDIwZ1QydDFLaWRMZjZrRW1NeWUydGVS?=
 =?utf-8?B?SmFZK3hXRmNaZGVkZ2xxNFFtT1Y5L2dQQUpqWTJwbmo2ZmhrcHp2ZDZtT3Ni?=
 =?utf-8?B?b004czJ4Tlc0TFY4QTRQWFJMWE5qY0svUU5DMjQ4bE5HaWpSbzAzS3FuQUtX?=
 =?utf-8?B?dzQrSHkrdGxzNWN1K29FV296aGFQRkwrTlFmaFgvaFlnbGd6TjhHdFhtaUtT?=
 =?utf-8?B?bkhoOGxESnJmMWFSSmorZzRPVStCeENybjVBZGkrRUZFV1lTRFRJU2o0QXBV?=
 =?utf-8?B?d1ZpUUtQWWpIYnRSSWdGL1lzVERGRmhjNGdIWGQ4aytMajFTQlhvQ0JLTmtD?=
 =?utf-8?B?NzZTVjhsbnVpMWFoNDdwa1dRUGt2NUZ3aVZ3K0FYbUk5U3c2MXFSSWkvTXY1?=
 =?utf-8?B?WnBlcHNPTDg4YWJ4TllVVEFEMWMySnZFOUx1MzB0VXNaSFlpRHV0b0t2SEJm?=
 =?utf-8?B?Mnhsck4wRElnbmFxM0VnOW9vcUM3ZUdybU1YK1dVN2o0a2VNN0d2V1BSSXRF?=
 =?utf-8?B?SzBmVWF5T3BPYzRaeXg5anRnR0FBZHVnM0hXZzcyWEc1WldUak5qaEhJdkNX?=
 =?utf-8?B?emZVZlF3KzJKMVNBaTA0Q1N6WWxWeTZabkNqZW9YVHc1RjQyZXQ5RThtRkVi?=
 =?utf-8?B?L21HQkpPTEZoTzlzd05VRHVLUWZZN1RQejV1ZG1LS3BCbFVqVjJDc05jNGVZ?=
 =?utf-8?B?UlhCY29UaW5mekRzbURpZFJhSUhnVTlkVDhwcW41aUVXTUtKVEFqZlh4QjlY?=
 =?utf-8?B?aUtpbzNHaGgwTmZMekRCYTkvUzVxdG1xVlU5b3JTN1BRemJtNWRGVjNEZ0hl?=
 =?utf-8?B?TUZCc1EwKzY4K3FuTm5pOVdEZ0htNnFQTVhlVE55N2lFSTM4MllWQVllbE8z?=
 =?utf-8?B?VXBQeWQ4Vm1LcE10amw2UHZCKzRxTzhJYTNsL0ZuWEN1U2JrU1M0WjJxajZO?=
 =?utf-8?B?TU56ODZRWFVOTGtLaXN0V1lkMmxSdzRNenpZWm5ZT0kwZ0NkSjU1Vmd2cE40?=
 =?utf-8?B?LzRaa3J5c0pvbjBQZ1JDbFl2RXR1a0VIa1hJS3VvMmxDdVVlWEIzaEVzZVlM?=
 =?utf-8?Q?VUH4TtHf+Xd0J/b75g8Qj41EjkmvLeXV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZC9SSFF4VE5BaXhGN0dESkdCWE5XM2x4OXl5Vlp2SC9MVEVvQjdhQmNTVTNV?=
 =?utf-8?B?S1M3SDd5Y0ZUNFVOWVBNSm80R1BCMkZRNVZyN3JYVStQaDRVeXJtSThzdTFL?=
 =?utf-8?B?TExzdFVnM0Q2a2g1V1BSZzNkTURiWkNXMXdKbHc4dytvWmJDVytBWmhLU1A1?=
 =?utf-8?B?UGVDU2pkWDEwMFlld2VhMGFYbEFPNEVxNVJRaFNvbkR0d014aDhib3haTVQx?=
 =?utf-8?B?Y3NhQjhteXB5RVpzOWF5ZTZLajFqK0FOeTNPaVUxbTRreFRUQVlIeDNrYktS?=
 =?utf-8?B?V0tOamRhUGJuc28yV2hUNFhGeXRaNUE1Nm83VzhOckgxcno0eU5OanZZN21j?=
 =?utf-8?B?dUlLZTZwN3NLMFp1dmNZcThLQ2lDRnF3aWcrSVZURGxnT3JLaFZBRzYyajY0?=
 =?utf-8?B?V25LVlpacjBPeHR2N3JHcDMza2NjM2FZZGZDb3RjcC9jVGdaWk5Da2hjYzlt?=
 =?utf-8?B?VmhJWEpTREdkSmM4YjVLYWR6UkFKb01Ic1VJL25LZXlrT2M1WG42NnBjcTNZ?=
 =?utf-8?B?Q1hYaVNJVDVQWnlMdnM3R0YzRUthR214d2RmUStoaTFWRko2MDA2VGc2WWVa?=
 =?utf-8?B?VUJWcmtsZS9sZ1d4SStTTXprb0I5V1ZOYTNrZVRBZlI5M1RZV1l0R00rMVow?=
 =?utf-8?B?bW1GQm9mNEJyMzJPdEtQWUpWVUM3RnpLVGlnRk1xV1NGUEFXd3FCS21FUTZu?=
 =?utf-8?B?RFovOWMzMjk2dzVLM3dqY0lOSmJ4Y1ZFRXlsZGZZT0R1UkdCaVJNWkZpSFhJ?=
 =?utf-8?B?bGJhb21WeGZlSU5kb01aVmZUT3kzUm5pTTVmeDYyOVp3MTFteFFDSzNxQk1v?=
 =?utf-8?B?aG93N0hobXkxNVVKOVJ1MU0vb1RNNnNxd2VSR1RGMmVIaS9ZVTFPWjN1ODZP?=
 =?utf-8?B?aEJzMHdkVEE5djY3MzF6bExZMjdSeXJiUExSTy8zclowbTBMZkE5a3IyRmNZ?=
 =?utf-8?B?U0YwL3FkbzNOMk9hb25qRzR2M1BBbi95UnFLSStEZ0RaQStSV1dneHZ3Y1R4?=
 =?utf-8?B?aDJ5a3pSVTZmdVd5cCtteDRHVFFPZW5RdzR4YXVyVURLdlVST3BVU2NWV2pk?=
 =?utf-8?B?S01GbEhxSXcyRUx3d0RpZUtpZkNudU5jS2EzR2tKODBDUDJEMTdsOVhLcWVt?=
 =?utf-8?B?YUpRSUZEdGFhUnpKOFNXNGErOUErMjRtMXRidkhzUXRBU25KRGlrNDMyOG84?=
 =?utf-8?B?UjZkbW9VRHhkd2duTUFUVzFyYVNGcUlLbC9ZRHMvMVhtT3NlMnoyVGpJRzZm?=
 =?utf-8?B?bXFVK1VBRFZhc1lVMXRFa0lIYnFDZGNXQm93LzVmdkN2RFlGcjFPVk9remF2?=
 =?utf-8?B?dkhlTCtwaG9IdTlxZWVMWnQvVTBjWHFaSEVYNUNpS2ZId25LWlc0bEZOMkhU?=
 =?utf-8?B?RFFjKy9lQ215U3Y0c3Y3ZUIyYWQ2THZ0WTI4Y1doRElNRVN2cXRhSmhvQW5j?=
 =?utf-8?B?UmU4SEEyQ3hhWEVsWndFa0lOZzh6UExXUWIzUnZzSDdya1JBTzRDOUpqVW5I?=
 =?utf-8?B?cklrRFRYbjVZN1BEYWhqMXN5Qk5Wa2RHc2J1NUt6OC85emsxQ05KTTBsMmtr?=
 =?utf-8?B?ZXNIYmpwVGtyVHhOanR4NnB4YUlVMzhiWkY2MldTUTFmSFVweGk0QjBKUTRV?=
 =?utf-8?B?VnBwOFR1OEJ5TWJGb3pGTi9ac1Y3aXZtN3BGdnkzK3lIRmhLTHJ2a0V3WEpo?=
 =?utf-8?B?UjZJRFQ2aFVTWTdXVXVUbjlwWGVSV2FOdTZSOG1IZjdNcHV5UEsxUWcxM1pY?=
 =?utf-8?B?aVRjakdEUmI0WjlMSEQrS3hBTFZ1MTJ5Wkhsb05tcEJZK0Era1lDQXFrcXpz?=
 =?utf-8?B?ZWx5N1JsWnBtYXRPNWhYWncwVE1aSzNOYVA2QVZ6ZUpwb1dKNS9nR3V2T3ZY?=
 =?utf-8?B?UEExbkFiZkNxWE56R3FoejZMWllZV0lRaWRpdWJ5Mzh0TERrK1pjYkMrT1BQ?=
 =?utf-8?B?T04xSkRrVGJHSWppY25LWGFFNHdpcVRxeWNWa2dSNmV3V1hocDJKOXpyNGNj?=
 =?utf-8?B?emRPelBwUTRmZzlOYldoMWJ1d2xCeW1FZUE5WVRmUVVyMDNpVENZTm10TkVu?=
 =?utf-8?B?N3ZVcDA2U28zOXpqSk1yNUhwRHVkajRXa3BwSVEwTUd4bEdHSWNzMlFUempl?=
 =?utf-8?Q?aoP2n/ES6jN5bzYpdT+uGG7TR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4aacfa7-2f8e-4320-b756-08de35f4cbef
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 00:57:44.7197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWhc2cfcC8oZFs3ahlK1zQF6AiyBXtASdojzxxiMKoyySAENBT4cp/bLdJRsG5o3JmOZw+SGhcIGF3YvQ2iYYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8663



On 7/12/25 06:21, Linus Torvalds wrote:
> On Fri, 5 Dec 2025 at 19:08, <dan.j.williams@intel.com> wrote:
>>
>> Alexey Kardashevskiy (4):
>>        iommu/amd: Report SEV-TIO support
> 
> Bah, I've merged this and pushed things out, because my allmodconfig
> build was fine.
> 
> But more testing shows that this is broken.
> 
> The amd_iommu_sev_tio_supported() function is only defined for
> CONFIG_KVM_AMD_SEV, but the <linux/amd-iommu.h> header put it inside
> the CONFIG_AMD_IOMMU config option block.
> 
> So if you have AMD_IOMMU enabled without KVM_AMD_SEV you end up with a
> broken build:
> 
>     ERROR: modpost: "amd_iommu_sev_tio_supported"
> [drivers/crypto/ccp/ccp.ko] undefined!
>     make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
> 
> I've pushed out a minimal fix that seems to work for me.
> 
> Please check - and be more careful. This is _not_ some kind of odd config.


thanks for fixing this and apologies for the late bugs! buuut...

... how do you find these in the first place, just by random configs? It would miss a lot. Dependencies are so freaking complicated (with all these "select" and "depends on" which auto enable/disable options) so trying them all is going to take years :-/ Any advice? Thanks,


> 
>                Linus

-- 
Alexey


