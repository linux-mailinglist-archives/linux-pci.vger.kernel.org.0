Return-Path: <linux-pci+bounces-13458-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D650A9849B1
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 18:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529041F215CF
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 16:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080BA1ABEDF;
	Tue, 24 Sep 2024 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sWKBsz7A"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BB01AB6D3;
	Tue, 24 Sep 2024 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727195648; cv=fail; b=ff+14pmCchWsN03tFveBrQiiiDFd6E0g/fS7VZ4dRT2vq86nzhE9MO4DkqDZNLsWqnjJnEnRNoeQg/T6KxJb8vzckjxraOWqE3OZjRMX0MEQkh2+5w774RZKf7aehJ5twUyF+xgTQo7Gv4grJGeYoa+6UupPHgxiuM9qOZnPoAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727195648; c=relaxed/simple;
	bh=wtr6iQZ/+bkTxQ8EdzXFi25EeFdtkEfIsBXs36Gi0LU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eGPukbKTtnfMMSmG1cdHQJjkdHIwS7PBGzsEvgMB9lLLuE3B51fQwzbtulzPV60h/yQxFSMfJGV7waYUO+XOx33y8JNTnTptHODh8T3tZViDPpTSM+ulWgld59JYzT2QLotPYrC3pDS8Hti3nvyXR0Hs6is9aB4fSKwxmUiQ1Qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sWKBsz7A; arc=fail smtp.client-ip=40.107.236.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUxKItYmY0Lx8z4Q+WPmjv0faHxJl7oRzaMT/2kQ/5e8UAP65b4OBSF93jTTM0ZgHcaqwJSR+H2O9si7FuE4+P7rl1UPIG09shDja1Kpo2QZO+HUWIGwiEnJG5Fa3C5kz7wrnuxUKR9ZXCdZlu3iy3Q4cX4kd1KCO97roWHlZXa4RT6uruHLOeHEbTWynn9mV63iUwNrNGnwIo+rRJn+ACGtrFwW/ZJ6TZxRR9BdUW3EewI0UFmrbSN8duRvqkYbdM7elA7eOgwT3W6HpoWd2FrOAiF/yPjFD2Eic0kSahcm6L6tA2OUwdjGrPPdnHLvZzAgSi1IPtV1xo8SZfd1fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5WACd+xgwPM9QpgZEKBcp5qYuiWUgwNvyD39dveRZ4=;
 b=D3yisgw/5gX7zjvc+KdCswWLzCEjGprID/aQLB0EkrPiGDELXU/I6wAK9eptktfd53XHPWi1Fck2fTyLzzWJovDv6MG+ELlrAbWK0PuyDFmD8xNxEznrTyHBWJYRWyQeyvYBWkg9nM1FtkSrgvH1aNngrVpgJBliGxSUIiDzrfZH527ebmxHEZgU35f/21M8Ub+acpRYisERCHB7BlQnANh2BZWmDlrcJ/2fsMvNwzs/l2aYLRhCv2ccGcFpaQLmaNjJy643uf3U0XtiV7477zj+h1R0pwKxluW5hmQZZSa4qjWPiK+WyvI9nOkDxMUoBol3tOPFX4w6WYYmqbecgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5WACd+xgwPM9QpgZEKBcp5qYuiWUgwNvyD39dveRZ4=;
 b=sWKBsz7AWXqg4rpo6utY+zcs8JLKf7716bXYF0qkHbSPSKNE9oIHRppeYZyVnqkiNG4LTi4tDgJIb/l3J2ER0lCF3wdODlLMwTSdce9K3LCFZEGpx9zcXAg/K0/C8iUkuYY04IsXblv0F0fF1C99fhYuOMZ0JuxZrvF3z/qq/0s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by IA1PR12MB7568.namprd12.prod.outlook.com (2603:10b6:208:42c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 16:34:03 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%3]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 16:34:03 +0000
Message-ID: <5a524007-6071-47e6-8982-3e541302099e@amd.com>
Date: Tue, 24 Sep 2024 11:34:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 1/5] PCI: Add TLP Processing Hints (TPH) support
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 Jonathan.Cameron@huawei.com, helgaas@kernel.org, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
 michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
 somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
 manoj.panicker2@amd.com, Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, bagasdotme@gmail.com, bhelgaas@google.com,
 paul.e.luse@intel.com, jing2.liu@intel.com
References: <20240916205103.3882081-1-wei.huang2@amd.com>
 <20240916205103.3882081-2-wei.huang2@amd.com> <ZvEcBLGqlJMj3MHA@wunner.de>
Content-Language: en-US
From: Wei Huang <wei.huang2@amd.com>
In-Reply-To: <ZvEcBLGqlJMj3MHA@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0085.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::28) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|IA1PR12MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: fae2690a-bd40-4f5d-d4a0-08dcdcb6b362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1c1d2IzemNadjYzYWNDYiszL3JiaDN3MjVHQjh1SHRpbldjb21kSjFVd0ti?=
 =?utf-8?B?bzJieFdFV3orVUIwcERHUWlMRXJaVFMvb002ZDJBV2dRZVFGbDFGQmpaZlE0?=
 =?utf-8?B?NkxqT0hrVGVFek5zWWtJK3d5eTNTMGlPamRwSHQ2bFBPZ01QdHd2UTg4dGRJ?=
 =?utf-8?B?cFdiMUZ2M1NlT3EyeXNmbHlqYmlHOFFsVzhmbmJkcjFuSHVJbEhpSHlJNzVi?=
 =?utf-8?B?dCtCc1VJU2JPWnNLdWRWYkhXZDdQUWk0bnZXS2F0QmZnNU1wb2FGUHYxdHBU?=
 =?utf-8?B?N1FWbHRUY2FqazRsamE0b3RUcHJkQ2owSHJoV25URlI2bjVUbEtRQlhQQnla?=
 =?utf-8?B?bllsOW1EMVZwSXZ5alZwRmFDUDFaR0JhN01sN3AzU05xeURRSmlaMHlJK21V?=
 =?utf-8?B?bmp3YkJnU3FwbVdFblNNcUZVd2Y3Tys2eFpRTzlJS2pYaEE0NGdINnhsemFz?=
 =?utf-8?B?enM2aUdSd0NRZlR6c0V4SXJJeHRkR0FuRzYzY2lGdHkwOTJ6MFNzSWdldWxn?=
 =?utf-8?B?cUVFY3lRV1FkQ1B4Vldpa3BFV0xxRlVya0dCQ2luL2hQeGdNOWNSUmNXLzVP?=
 =?utf-8?B?RVB3NmZkTWZNRUpiQWRiak5neEcxZVJsc1BPRk5TL0tKa3U4Zm5OWEx3d0dQ?=
 =?utf-8?B?MWNaU3ZoM096K0hqalVlclpuMjZDRjJ5ak5jWGpZRVA4VVVMQkRncEJzazN3?=
 =?utf-8?B?dHE4N2tWaWtPT0xzcFpsdVpLVHJOcXNONTJxVU9tQ3AxZXRqaGdqM2hVbVEz?=
 =?utf-8?B?b3VFaHBJQ2VGeUF2eTkrd0xzYUQwU2pISFp4YXJ5VG1tK0s3QmdycXUxUzFX?=
 =?utf-8?B?a3laNVJsb1dSVlFQNVMyNWdKamRVQzFWb1YzY3R3NUE2TGo0ZmdVUDgvRlRa?=
 =?utf-8?B?OUIybXVieGl4MEMwT1JlRmwzR2UwUTJkL2J1M1graEl6M2JramFjNVRYUDJX?=
 =?utf-8?B?M0hZc1Bsb1BVUVlnM283VDRIL2ttREtsOGFIczdySjI2aGdrOHh1cWxmVXFW?=
 =?utf-8?B?VjVnL2RlcUw3bDJCVVdRUFBXY1RBUVlCb21GR2JYTkNrbjVJUHY5NXVBVlB2?=
 =?utf-8?B?bGpBbGd0VEs5VDRLSUZlOGxud2srNUVBV0p3TkNQQUYreVpmZjNwangreVdk?=
 =?utf-8?B?OXdhSklVdkIrdVZ6U1JtY2RxZXdZd3UvdzRxYXpPSzJnL1dNc2Y3REg1MEdB?=
 =?utf-8?B?anIzbExXRG9kRzk2STVBMktNamNQWmxQZCt3UXRJTDgvM1RTOEdSYnRtMk5C?=
 =?utf-8?B?QXhQQkJ0azFuTExiTitWUzBMWWVaRVRnc3NncHUxR2U1SXNtdSszMUdTdFlw?=
 =?utf-8?B?TUJEOURRL216ZklBQ0Z5VnlldERDRDlidzc4UnhXTU12QlpibjlVOHdYVkZI?=
 =?utf-8?B?ZXFscWl0djZjMFVUL1Q2dDlrRzI3SEpzOHNid2lrcWUrMW52STFMWDNUN1Vv?=
 =?utf-8?B?ZVdwaTFzUzNibUVWaUtuQnMzbW1SQmc5RXFUZkpOMnJzNVBuYURLc1dEQ0F3?=
 =?utf-8?B?enF0bmNRaUFTczd3ZmorZ0d6MDc2WjZCVFJJek40R0F5Uy9BVVg3L0RpKzNU?=
 =?utf-8?B?VkxibFVvNUlGRWRtZ2ZGRmZCYW9VOXE4LytRWEE4VUtEL2VoTmt1UVpzRkVw?=
 =?utf-8?B?VHpORVc5SlI1ZTVweDZnbnNXLzlLQWhJejdac1Y0dTk1Q1NtL2NDT29xOG44?=
 =?utf-8?B?VWNYN1gweDBEMVdudGFid0w0YVBJaEFZS1I3OGU2amJ2OVkvalRxcVBPOXJ3?=
 =?utf-8?B?VE5BelpIMmxHSEViR1JLa0U5bzRwWUtEZElNMlQzb2JQcVFhWkpmOTUwdVpk?=
 =?utf-8?B?blB1UXlIN0xIZDZUaFVKdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUo3RkFiZExLbk9OeXlPMTNwWHowZmc2QTJMT3JNOGk4STVGU1dvMFZ5WmJS?=
 =?utf-8?B?TWR2dU80NkcwV0owRndaSUM4ZjdKVjdwaTJSTHN5OVNSNjJTektEamI3TnR0?=
 =?utf-8?B?VkxVK0RGUlZiaTFmbzJ3aG1CWDJTM0FsY2dtMXVSb3FzaTZNcnpRT0NJV3Ra?=
 =?utf-8?B?bTNnTCs2UGlqcmt6K2c1OWRHR0c2T29zY1c0b3V4Q1VoWU9rekorbWRQYTFn?=
 =?utf-8?B?em1lcTJNS2F3RldIWDZEbnRvVkFvV1QyV3p5V3JLdDh5bzM5d1hkbDEzd2ZH?=
 =?utf-8?B?TUFwVUwwR1lVL20wd05yTUcrNm5yenVSTDFxTXZUVEJLOWg3aFFFeldhTGtv?=
 =?utf-8?B?VzErcjM2SE1jTUJFYzhSZTlaNCtxbXk2bEVlUlhLenB4cWJLNVViVURja0hy?=
 =?utf-8?B?ZGE0WFdyRnBFWGN5cGdSQzFvcGtSQWJyblMwZmpIQldGTTBidlVXdTZMaXBB?=
 =?utf-8?B?Rk8ydzFHdTBjR29nZHF5TXdCcHp5d0laUjVpeHhxVGFCVFljUWcyK29iR1Zn?=
 =?utf-8?B?d2JmSy9DSXZHRkt5blVuZFBzdHBobzlEaFlqYm52QXZFSVBqT2p0VEVnZTZs?=
 =?utf-8?B?c1VFWXNHR3phTXBsMXllRWJCTFpnbFVVZkY4aWZ4c0pSdEdOSkZ3bjRRdGV5?=
 =?utf-8?B?bncyVlpuRmVsUmZUTVl3VSttdlpvM2hyS3JieUkwMXdpVUpiZDcxaVgxUmlm?=
 =?utf-8?B?Uk1DS0JPSUxvSUFuL3ZRcmtFUHhzUlBtTnl2NnZ0VkJhK0s4Rm1WejNBUjRK?=
 =?utf-8?B?QTFXRXZNN3hJc3JwY21WTXN0eWZSL3JqUWIxVCt4TGszbTlCOWdFeXFmYm1s?=
 =?utf-8?B?YXdSL3hYR2JFR0o1Q2VhbXk3VVJSQWdoY2FnamNxQ214UC9HTi9QUHhMNmhE?=
 =?utf-8?B?RkFUT0RmT2trTXJ2UVdHUHdNVzNWZlJqNTJEQkd3RUNFcGJ2RE1ibkR5cEQ5?=
 =?utf-8?B?NzkrcFRhYUNLUTBnL2hGTUIySTBxWVFBaysvWUpCKzI5cHZZWEYzd2g2MG9X?=
 =?utf-8?B?RTFSYW5qMWZCUzJteUd0SGZMNnk4M2Z1d012cGJKWGRtTURhRzMrejh6RHR5?=
 =?utf-8?B?N2djVm0yemV3aVdlQWdqYWUzdzRNTGtlNm50NzNXbkdNQXZPTkxTR1l0Vms1?=
 =?utf-8?B?QkN3dmpFOStRdXlMRkJHbXd0bW95bzNRakYxNThOMW1ERVFPdkhlYVpPeWw3?=
 =?utf-8?B?TCtPcFFjWUdXYmZqcFFiUTcvT1JDeXZVR2xGVzlGdE9UZ3N2VFpMTTMwc3VV?=
 =?utf-8?B?cDd4OGRvWURiYTZJbzdTUFhNU3IvWTRlZkZETS9WdE1MdHFIc3lQYW5MS3RS?=
 =?utf-8?B?NVFtNC9iQkU3Qy9pNHNSWW1rMCsrazFkcTdRMmwzTytaamlZVnZTa2pPbW12?=
 =?utf-8?B?cC9wdDhPSUJtQnFydXZibEZFZnhCSENuajB0TFZKMEMxV3JrNm9aOXlUNzA5?=
 =?utf-8?B?Zjd1SW4yd21Tei9veWdoNSsySGVFUWFHUGxPckpRU1lFWTVLa0podzlkcXo4?=
 =?utf-8?B?SUZXdjIxQ3RqbTVnK2c0bTdPdVdxOTlrU2ZFMWU4ZitRVjFXLzdxOHNDYUZs?=
 =?utf-8?B?VUxETSttRHRzVmJGeDc4SFhSQ0RxaVM2OGlxSXZLKytVTWx3Q21GVkt3aWxU?=
 =?utf-8?B?bDlhTE1wb0k4eUZYK3pEWW9iRE5RY3hZQVA5WjlISmFOVkt4RGg3cHFQTVkw?=
 =?utf-8?B?YS9VRWN3UUxGTlhmQVUyemdRTTFiQ2RMSkptR1l2bkllSUxNQ3Uya3JkQnVQ?=
 =?utf-8?B?MUk0NU1Ea2tlQllSY3ZDNklTQk5sY245YjlTQkhNWHBualJuK1lsVVk1cW1B?=
 =?utf-8?B?MGZTelNHcnMzQyt2UHdEU1JnYUQ1bGtEbjlxbVJ3eHdaNzZtN1JGVTIzSWFh?=
 =?utf-8?B?WGhnYko1eVpiT01UMWJvcUhjd09LS1lTUmRJTnlJOW82a0ZuWFQwcjZENVJu?=
 =?utf-8?B?QXZLQmx6djlkbHRCeityaEM3eW9jYmdoMHdIRjk3aUJQSklhSkZDTjFhRTVo?=
 =?utf-8?B?N2RoNnpYNUk5Vm8vMTBuR3JoaG9qanc4eEpNRGhnSCtvYytLVVNHZVFEUzdP?=
 =?utf-8?B?Z2V3MldUN09wL28rV3o5RnQ2MDc0NEI0Z1VIbjFvZnh1cUlDTTY2RlFkZzgw?=
 =?utf-8?Q?6XBk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae2690a-bd40-4f5d-d4a0-08dcdcb6b362
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 16:34:03.4239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxmRU42NlEIGXV/CDt/wa/UzkDhVT3kskwDj9ZAFG8dUATC08PzwcXNKPAoCmfmt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7568



On 9/23/24 02:43, Lukas Wunner wrote:
> On Mon, Sep 16, 2024 at 03:50:59PM -0500, Wei Huang wrote:
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1813,6 +1813,7 @@ int pci_save_state(struct pci_dev *dev)
>>  	pci_save_dpc_state(dev);
>>  	pci_save_aer_state(dev);
>>  	pci_save_ptm_state(dev);
>> +	pci_save_tph_state(dev);
>>  	return pci_save_vc_state(dev);
>>  }
>>  EXPORT_SYMBOL(pci_save_state);
>> @@ -1917,6 +1918,7 @@ void pci_restore_state(struct pci_dev *dev)
>>  	pci_restore_vc_state(dev);
>>  	pci_restore_rebar_state(dev);
>>  	pci_restore_dpc_state(dev);
>> +	pci_restore_tph_state(dev);
>>  	pci_restore_ptm_state(dev);
>>  
>>  	pci_aer_clear_status(dev);
> 
> I'm wondering if there's a reason to use a different order on save versus
> restore?  E.g. does PTM need to be restored last?
> 
> 

Will fix

>> --- a/drivers/pci/pcie/Kconfig
>> +++ b/drivers/pci/pcie/Kconfig
>> @@ -155,3 +155,14 @@ config PCIE_EDR
>>  	  the PCI Firmware Specification r3.2.  Enable this if you want to
>>  	  support hybrid DPC model which uses both firmware and OS to
>>  	  implement DPC.
>> +
>> +config PCIE_TPH
>> +	bool "TLP Processing Hints"
>> +	depends on ACPI
> 
> TPH isn't really an ACPI-specific feature, it could exist on
> devicetree-based platforms as well.  I think there could be valid
> use cases for enabling TPH support on such platforms:
> 
> E.g. the platform firmware or bootloader might set up the TPH Extended
> Capability in a specific way and the kernel would have to save/restore
> it on system sleep.
> 
> So I'd recommend removing this dependency.

This is reasonable - I can remove this dependency.

> 
> Note that there's a static inline for acpi_check_dsm() which returns
> false if CONFIG_ACPI=n, so tph_invoke_dsm() returns AE_ERROR and
> pcie_tph_get_cpu_st() returns -EINVAL.  It thus looks like you may not
> even need an #ifdef.

We might have to add #ifdef around the ACPI related functions. The
reason is not because of acpi_evaluate_dsm() or acpi_evaluate_dsm().
Instead the compilation will fail due to "pci_acpi_dsm_guid". In TPH V2
series, somebody reported the following error:

"
This seems to break builds on ARM (32bit) with multi_v7_defconfig.

  .../tph.c:221:39: error: use of undeclared identifier 'pci_acpi_dsm_guid'
  221 |         out_obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid,
MIN_ST_DSM_REV,
      |
"

> 
> 
>> diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
>> new file mode 100644
> 
> The PCIe features added most recently (such as DOE) have been placed
> directly in drivers/pci/ instead of the pcie/ subdirectory.
> The pcie/ subdirectory mostly deals with port drivers.
> So perhaps tph.c should likewise be placed in drivers/pci/ ?

I am OK with it. Some extended features, such as ATS, are indeed
implemented in drivers/pci/.

Bjorn: Any comments on this idea?

> 
> 
>> --- /dev/null
>> +++ b/drivers/pci/pcie/tph.c
>> @@ -0,0 +1,199 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * TPH (TLP Processing Hints) support
>> + *
>> + * Copyright (C) 2024 Advanced Micro Devices, Inc.
>> + *     Eric Van Tassell <Eric.VanTassell@amd.com>
>> + *     Wei Huang <wei.huang2@amd.com>
>> + */
>> +#include <linux/pci.h>
>> +#include <linux/pci-acpi.h>
> 
> This patch doesn't seem to use any of the symbols defined in pci-acpi.h,
> or did I miss anything?  I'd move the inclusion of pci-acpi.h to the patch
> that actually uses its symbols.
> 
> Thanks,
> 
> Lukas

