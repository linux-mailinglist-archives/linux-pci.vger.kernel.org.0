Return-Path: <linux-pci+bounces-23404-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA736A5B94C
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 07:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C3AA3AFD69
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 06:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F4F1E7C06;
	Tue, 11 Mar 2025 06:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qt5/Kl8x"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A09313C3C2
	for <linux-pci@vger.kernel.org>; Tue, 11 Mar 2025 06:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741674801; cv=fail; b=plYR3fX6DQycWNuxygRMXppvo4jvwVvD1oBr9P9QGhvH3UnMcwLWvBkTvsz+t0eyUf1bAY3TUDvmKEidpRF/Bpc08zQ2x+am+XBE7A72zy5Zb4rSartWTne3lCKcWa7Z6H3FQ4OQP7QsG8n3NgggbU3JfwZhcqdr9bXJfx5psPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741674801; c=relaxed/simple;
	bh=ok38Lvuo6/ZdWOQtcyJYd9KUPrD9eBY76kRAFygz7Cg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iuksPwglnAG6WjGbNVmZaFfInJG6alovi4NUIb2+3GKgq5am6D01mqjzqA+KKNokWWbQlC6FYJGU0y+W/S+VhuEU6ZTwBHSd2CRLjRDytoZqbcv/D4807WureAxpP4bSf8I0NBzra8LWjegZM/AVhWNRIUVNjEFDHDXyLM7877A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qt5/Kl8x; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDLPIqdfgd4Y3kqGy8KKFA5hcSL3OBsH+xWZd58BVwaZM1N/ou39oZc270dLAkS4Fx6RRK/nS5qGDY5hMR2ymbbV6fQNe8r03IibDjAOuWaHRmxfdvxAlbFLy7cLfkISsnr5NOOhnjRNMCyXB+ldzaoxjj9mdr6lxaQ9VR3aDK+fE8B+LRBnDtIV+0GX+MDW0xdFgdcyAyZwzR1dSEvX+CyU5GcHTDWmvdPgu7cqZRQbl+0AcJX7dymZWeWdJptPDVDhsX9gfl6oivkejoeZGYWe3vpZodba2jzeE88xUaM8PTQ+AE1M+R3F2GxuyHqpeZFAABreQwfwxtHiNWj5LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOhfSrGRjkURh1fF+FMiNg2UxFik+gqI16YR2VAYXro=;
 b=Z7dngU2itMFxJPFJ+YCqRq2g8TFTG92FxoEC6o4BOJnMno3rJ7kXqWpE4VxCONInrODcyYsuT6Q5iWyRudQU60McEzPBu4UNS2R/Tc0rPwvGYgubmJbsQKzM9/cmc4vNdw/LeZodBQ0pTzxosRtYIP4l7r4HoUs08wdt0nPv7EZkTQSd4uNAthUlbTur8+H1DdsQ9XtV7dMqKD494XMp0SsOPJyerWn6by+iu6pTlFRy6TIeQPZriOBqPUQhpvYEttg5twzWxZyA8h4QaQTfPiOVIIfsKUGqJ+Y0wVdbV86uQinZM4pDENAWezLwxb5jLPH4IQYIPHtgmUKV9mauUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOhfSrGRjkURh1fF+FMiNg2UxFik+gqI16YR2VAYXro=;
 b=qt5/Kl8xRNqij1BaAPISQ3lVxxWh+Gs8WZdrGNQJDDZWK2EImJbGaqbREw5xvQrNXLyNQJYqP64ITVGGdBKUWBCnSfTE+OKWhlKA+I5xtNHe+WfWWXkHw1z5Go16oVIPmZDyQwTd39qVeEd+s6Boid603nCaeiFNiYYlS6IY1to=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV3PR12MB9213.namprd12.prod.outlook.com (2603:10b6:408:1a6::20)
 by DS0PR12MB7725.namprd12.prod.outlook.com (2603:10b6:8:136::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 06:33:16 +0000
Received: from LV3PR12MB9213.namprd12.prod.outlook.com
 ([fe80::dcd3:4b39:8a3a:869a]) by LV3PR12MB9213.namprd12.prod.outlook.com
 ([fe80::dcd3:4b39:8a3a:869a%4]) with mapi id 15.20.8511.025; Tue, 11 Mar 2025
 06:33:16 +0000
Message-ID: <114ef970-0603-4084-9bd7-6b25be54cef9@amd.com>
Date: Tue, 11 Mar 2025 17:33:03 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 04/11] PCI/IDE: Enumerate Selective Stream IDE
 capabilities
Content-Language: en-US
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: Yilun Xu <yilun.xu@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, gregkh@linuxfoundation.org,
 linux-pci@vger.kernel.org, lukas@wunner.de
References: <174107245357.1288555.10863541957822891561.stgit@dwillia2-xfh.jf.intel.com>
 <174107247873.1288555.8934248700370548272.stgit@dwillia2-xfh.jf.intel.com>
 <yq5aa59sglvl.fsf@kernel.org>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <yq5aa59sglvl.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ME0P282CA0053.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:20c::20) To SJ2PR12MB9212.namprd12.prod.outlook.com
 (2603:10b6:a03:563::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9213:EE_|DS0PR12MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: e2d54786-455e-4b16-769e-08dd60669a3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2lSYWQzVWEwcjF6Tkh1aWVIcXlMU0k5Ly9xWU9WbDkxREpUU1V1SGEwY1V0?=
 =?utf-8?B?Q2t1UUEzTGJoTzRCNm5iT24zVlBjRkhSa0dKeFdNSFFIUlF5TGJsWXBhdEhu?=
 =?utf-8?B?RGlZZ3NKdUhMaXF6WUl2ZjczNzZMaUhTbHl5TUhKQmJBSmk5SlMxOEdDUGRW?=
 =?utf-8?B?bVJ5ZWpTdUxjSDFhL3prODM3eTJ0cmkxbjNtSCtqaHdqc2c5ZVIvMlVrNEpL?=
 =?utf-8?B?TUdlT3haN2JnMThJZmZyUEFZQzJvQ3JGWVlCZDUwZStIQTE4eTA4S1MvVlhT?=
 =?utf-8?B?Qk90bUlwY3I2ckcwMGRSS25BV2hoTGd6d0pJdTdzRklhNkwxMzg4Q2xoMTIz?=
 =?utf-8?B?em4xaFllUFEzbmN0WkN0OXZZYjk2VDNQdFlyYmNmT3p1bXIxQ2JtaCtTbDBW?=
 =?utf-8?B?d3BiUEgrTkdxWXhnbXIweFZVK3lVZG0vbTd6RE10aHJId05kUjVnbUZKNFFX?=
 =?utf-8?B?SC82T21Ob1RQYmZzOWJYMDh6eUdlMWZKakVramVDTGxYWWQzZkxIRGdMbGJT?=
 =?utf-8?B?Rjc4SXhmNkVuejN3ZWJ6WmlmVStNWTFLR0JJUGM1cCs5TG1TSU4wUVRSMzd4?=
 =?utf-8?B?Wm80bVhaSUl4bytkZ3lTTEthd0s1T0VXMGZVdzNCUFhKSTk1VENuQzk5akl2?=
 =?utf-8?B?Wit0eUZ1UHB2Q0pQMDRFQ3JTUjQyemtkR3FFcWRhKzMxeHVnQkdKVll2MXdJ?=
 =?utf-8?B?eE1nOWJtdEV4VmxFbzc3S1N4NDdCU0hkaElCMGNRSkNhSGtEMHFDMlk3aURq?=
 =?utf-8?B?b2hQSS9lQTRlZExGR1JwdUN3NTZiZm01VGkxa2JibCswN09nbmFWNjBUcnNZ?=
 =?utf-8?B?aWF2a1Qyc0l2VDRnWXYwUXdCNHozb3VDQmg1aUpvY2V1WlpJWXZxaXllTjVM?=
 =?utf-8?B?UzJ0eFkyVHd6WC9uOVN5TmVvR2NpTlN5b2V2RTBycncwQkpsaVVqOUVITTB3?=
 =?utf-8?B?em9vRExob2tqcXBZd1V3NG5lOEhvaWtyZ09hU3JTenZVd0FGaVhLVk9MSEdy?=
 =?utf-8?B?cno0dWxHcnJRWEtDamRxdWlEVGJBL3VsdEJoZ05FZ0hjY05aSzdPRlIwZmQ1?=
 =?utf-8?B?REM3RUxlVHRTTHVEckYwVjBhalEwcE5EeG54TnBJTWwvOWpWSWZrTUlLR21w?=
 =?utf-8?B?M0w2L21tWm84bFRnV1hHZUJBZ0oxS2U3WWVRWExjZkFLV283NTNDNjFQTFUz?=
 =?utf-8?B?c0l0OVhyR0paZ1hYM1c4QmdWLzF0YTBVMys5ZFJIL3J5MFBZYU5JclgvUVdw?=
 =?utf-8?B?SnJIaXF5QVp1emxDalE4ek4rbGtrUXQ2SnB0djUvejdsK1dlWnNFVy9pV2or?=
 =?utf-8?B?WDlsVEQ5aXlsSllTYmxGUGRIT2xGZDgwK0ZsZDJxRnA0UU40b25CKzgrd1k3?=
 =?utf-8?B?REg1alhLL3VtQ0J4Wi9YOG9SWGtYY2pZaTF1WFJsMkNpcHpnMUxmbFNIc1hr?=
 =?utf-8?B?VXRiWU9YR0IwejV5QThnQkhNKy85cktWM25BbWF5TGRiMk9NWERIcGtKWW5C?=
 =?utf-8?B?RVo5aFA1UVdFQ1d1Mi8zL0NxR0g2R1VMb25HRzNlYkt4WlpZdnFTTnpld1Bq?=
 =?utf-8?B?ZjIyc3NhYlRDVjBseXhlNTAraXgxdVVMVFNMVUxLRnNUUkFNUlhLcEEyZmxX?=
 =?utf-8?B?aHpBb2Fmd1dXZXZvYjEwT1htbVdrcnpadDZlaUJaVzJkTzRxMUFscm00Undo?=
 =?utf-8?B?NkNrdlEyV095VVg5RWprZGYzOVRHTW0yZ3Q5TzU1UTNIWEFuN0RFYU52M1Ar?=
 =?utf-8?B?MWI5RUUvM0p6a3RabmJLeCtWOFMyRnZjMzR5MDhLKzJvR2xWdDc5eTRLVXRD?=
 =?utf-8?B?bThjN05tKzRnVGdGVGwzN3dsQlF3NGo3aFlhMHl6SCt5WHJjYU9wVVNOTjI5?=
 =?utf-8?Q?BRXSk0NvZ7dlW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9213.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFZ4N0lEQ003b2prUWpyQnIvcnFRaVV2SFJkNHpuNmhaQ1hCN3V6L2toOXVI?=
 =?utf-8?B?YXcwT3VZMnRSeFpvZ3Bha0ovek5OUEdpUHpHamdUT2Z6SW5YUlZMTzFvZ2gy?=
 =?utf-8?B?TzFmV3RJcFVmMTJSclJDemg5UVF2eklzZC9GSUVrTzJUOEdvc2ZFaDJocVZR?=
 =?utf-8?B?Q2FTVUNzM2R2d2psOTkwNjRjVzVoQXlBSkJiZnVaT3FWSWlaT08zamx1M2NY?=
 =?utf-8?B?L1hSa1VGTDlUQXFDMmZhNy9TTHBtYTBGL3JpMk9GTWxKc2p0YVdDUFNZcjBL?=
 =?utf-8?B?dmNMd2grK3Y5L3pYV3Zxc2N3OEF6ejE5T1k3SlgyRS91Wks2UW1BZHhXQjJ4?=
 =?utf-8?B?R21JcnY0QXFWTGdCa05TUDBYa1dMZ3hpRUdLUVA5NVRmcitxTDFndDlNNXJI?=
 =?utf-8?B?OEt0UG9HSXYydzh2K1BMdzl3VU9oWmxLdjRrc1BEZktHSENabHNvdlZYbGRp?=
 =?utf-8?B?Q0x5QVFvby8vTzA2dGt1WlJ5VWJLd3BVMTlvcHRaMWtpSTExYVpHajNNR2VE?=
 =?utf-8?B?aVNrZHdxTFBNdW40VUplSy94YjZPMEhiS0t0NHpQNkhOaXZEM09TMFBYRUh5?=
 =?utf-8?B?aFNIeDZlY3ZDcEFaTVNodFZOV2hBVk8xZW1KbFdhb1poc3YrUEpIa0pzSW1s?=
 =?utf-8?B?ZUVCWnIzY003bVI5SnBzbGZhenZIMTh2WHBoNXExVkloMmhxSWF5UDBUbzY5?=
 =?utf-8?B?NDQrbXRlamI2Mk5SWE80V2dHeEd2WVJPOXdLS2NaWGNnMWV5L3dCSzE0OG1U?=
 =?utf-8?B?TSt3ci85S2xPajd2MjFUU3M4K05qSUFjT2F4T3g0SVRNQ3h0Ti9QUmpUUlU1?=
 =?utf-8?B?M1lGYzlDWEU5Z25YM2VxcW5PVkhoemI5eTBTVXljRkd0MU1DTFJLaWtJcjZS?=
 =?utf-8?B?Wm01QldGZUI1SHJ0OHNQbk4yVWx4dUdpekgxZEZEa2RYbDdlN0Y2NXdZTUVZ?=
 =?utf-8?B?UXk5aXdBdC9yZ2lla3liTkdDTTdPRVBKNWV3MTQyK1JpUUJiYnN2ZGsyd3dR?=
 =?utf-8?B?TlIzTFh6VUJvYlRCQTBNeDE3eWVqSjBUK2x4SmZKUDVHd0tkWlZGUGdoYk9i?=
 =?utf-8?B?WnhQSE9RT1NmMzhlVjIrZTViTUtKbzRjSnYwMlQ0UG5XbDFCd0ZTQXd2a0ow?=
 =?utf-8?B?dTRNWXZuMERTdDBlM0Vub1BWTjRDRXI3ZzNkQnE5VnJWZ1poWlloSFF1czJJ?=
 =?utf-8?B?dWg3Tmd5d3gra1BHVEZ2UTB4VzdkbWkzd0xrWDNvbGMrZWxObTkyUXhwZkcr?=
 =?utf-8?B?SzNCMDdKc09lcnNBOEhNelpvcnNkQW91L3FvYmQ1eTBmSStPNnViRWYrTGtX?=
 =?utf-8?B?UVhKYk9RWVJVZGNNeVVicCt0bUtobVlZVXJNQU85aFVWdWgyd09QRXF4d1JC?=
 =?utf-8?B?VWw0bWt3YXVMT0QwMnl0NEpxbFkrMVMvTm9OZ1Npa0MvMHJOMG5XZTF4aTlL?=
 =?utf-8?B?VWxxbFJGNk9zVWZCZDA4bGhvVndob2pveHNqRlQvTjkwWDJaNlROc3VZVVpL?=
 =?utf-8?B?Q1lvSWpiK09qUGJ1UE1HcHVya3RPbEUrUEZ1YTdKWDRWb0dJcmR4Y3ZYci9V?=
 =?utf-8?B?blpWZ3pKb3ZRMW5FMjBKdmppRFhyZUZmWHp5czkwMjcvdXdvWk1IYk5aQ2VK?=
 =?utf-8?B?ejJJakVLWGEycUt3VzZhS0ZrQ3RjbGhjRzB2NXdldlQ1Zm5uVXJxSjhWOEdR?=
 =?utf-8?B?M0w3VHRLRWRUVG92YlVEOFc1bVlkbUU3QjR5c3krTnRlL0prZ3JYMUU2RzJy?=
 =?utf-8?B?NGU2Qk1pdU5TZW4wM2Z2bmkwYjJnR0xubXdrVVJ4b3B6SE5hem50RThCTzdV?=
 =?utf-8?B?VGt1eUJ6a0JJb3I1LzRDTWxHbTNwZTNMRHIrSGtQdzE1bWprOHBlT0VQMDRt?=
 =?utf-8?B?Q2xPaVROa25NTmhqSmkwY1RSZFJTazJmelJ4MnFpYXNpY0lNZGxBV0dhejVa?=
 =?utf-8?B?bExxT1VBUnZZSEVpUEVCZHI3Q0FON2FIa1p3SzZlV1RCRys3R3ljQURsZmZH?=
 =?utf-8?B?VXZDajNXYWhZMzc4Mjc0UVVON012bHFzOGZQRG1lMmlIbUFtMUFtbTJyZGN2?=
 =?utf-8?B?enVFdGszVFVRRnFhUWVtQ1JwNEVQWGh3R0pvaHdOZlVhRlVveC9sNnR3aW1u?=
 =?utf-8?Q?9MoNHVujuiNALkkXapA7ckVav?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d54786-455e-4b16-769e-08dd60669a3a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9212.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 06:33:16.3090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNJfFXn9dWbD7WMjUWwFYW+cotg8St6RBoOJ/na+gCem/F5f24KYdYpRX8iiZWPk8gyObFB54ifv42oO/Jmw4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7725



On 11/3/25 16:46, Aneesh Kumar K.V wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
> 
> .....
> 
>> +void pci_ide_init(struct pci_dev *pdev)
>> +{
>> +	u8 nr_link_ide, nr_ide_mem, nr_streams;
>> +	u16 ide_cap;
>> +	u32 val;
>> +
>> +	if (!pci_is_pcie(pdev))
>> +		return;
>> +
>> +	ide_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_IDE);
>> +	if (!ide_cap)
>> +		return;
>> +
>> +	pci_read_config_dword(pdev, ide_cap + PCI_IDE_CAP, &val);
>> +	if ((val & PCI_IDE_CAP_SELECTIVE) == 0)
>> +		return;
>> +
>> +	/*
>> +	 * Require endpoint IDE capability to be paired with IDE Root
>> +	 * Port IDE capability.
>> +	 */
>> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) {
>> +		struct pci_dev *rp = pcie_find_root_port(pdev);
>> +
>> +		if (!rp->ide_cap)
>> +			return;
>> +	}
>> +
>> +	if (val & PCI_IDE_CAP_SEL_CFG)
>> +		pdev->ide_cfg = 1;
>> +
>> +	if (val & PCI_IDE_CAP_TEE_LIMITED)
>> +		pdev->ide_tee_limit = 1;
>> +
>> +	if (val & PCI_IDE_CAP_LINK)
>> +		nr_link_ide = 1 + FIELD_GET(PCI_IDE_CAP_LINK_TC_NUM_MASK, val);
>> +
>> +	nr_ide_mem = 0;
>> +	nr_streams = min(1 + FIELD_GET(PCI_IDE_CAP_SEL_NUM_MASK, val),
>> +			 CONFIG_PCI_IDE_STREAM_MAX);
>> +	for (int i = 0; i < nr_streams; i++) {
>> +		int offset = sel_ide_offset(nr_link_ide, i, nr_ide_mem);
>> +		int nr_assoc;
>> +		u32 val;
>> +
>> +		pci_read_config_dword(pdev, ide_cap + offset, &val);
>> +
>> +		/*
>> +		 * Let's not entertain devices that do not have a
>> +		 * constant number of address association blocks
>> +		 */
>> +		nr_assoc = FIELD_GET(PCI_IDE_SEL_CAP_ASSOC_NUM_MASK, val);
>> +		if (i && (nr_assoc != nr_ide_mem)) {
>> +			pci_info(pdev, "Unsupported Selective Stream %d capability\n", i);
>> +			return;
>> +		}
>> +
>> +		nr_ide_mem = nr_assoc;
>>
> 
> What is the purpose of the loop?

It is to be able to implement sel_ide_offset() as simple as:

offset = PCI_IDE_LINK_STREAM_0 + nr_link_ide * PCI_IDE_LINK_BLOCK_SIZE +
stream_index * PCI_IDE_SEL_BLOCK_SIZE(nr_ide_mem);

as each stream can potentially have different "Number of Address 
Association Register Blocks" (which we do not want for some reason).

> Should it use the minimum value to
> ensure we select the lowest supported value for all selective IDE
> stream? I assume that, in practice, the number of address association
> register blocks will be the same for all selective streams?

This is what we are going to support now. Since this "Number of Address 
Association Register Blocks" thing is to be programmed on the rootport, 
it is probably a reasonable thing to expect from SOCs anyway. Thanks,


>                   nr_ide_mem = min(nr_ide_mem, nr_assoc);
> 
>> +	}
>> +
>> +	pdev->ide_cap = ide_cap;
>> +	pdev->nr_link_ide = nr_link_ide;
>> +	pdev->nr_ide_mem = nr_ide_mem;
>> +}
> 
> 
> -aneesh

-- 
Alexey


