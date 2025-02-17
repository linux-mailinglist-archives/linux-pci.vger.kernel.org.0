Return-Path: <linux-pci+bounces-21607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABB6A381AC
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 12:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C06918910D9
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 11:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB569218592;
	Mon, 17 Feb 2025 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZXWFut4F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p+ptiLLQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F48E217F5C
	for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739791791; cv=fail; b=mJnMDtEccb1afDUxnK1b9DZb/+9F6dBvDRNcEqPgTpjEjvZHDuf76+46XrwIMAsmgwiMHfwNeUgG6Hwf9QYIURqVTN+Ks9UtGCaNnxeKuIEVQE19jJLZbmG0PPuxb+2DAm/SatqJfeIsIpN7pCi40VAkJuyAn0kALkZoMrF8vrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739791791; c=relaxed/simple;
	bh=rqjmtVJ/XdDlIBjY8tjTSTHlhAY26ZQTfJSNcy4yi2M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KmpuwWDHP+a3n9/Wsv2Om1lilpukKjBpNhFsGP4bImDmz2LoB/+3ifHK9pVEJnpQv43Hel8VaKXfD8FWVZnoXzkglyRhCtU8dXUj2zUL7sBpMidfgiGxCz+BVP/xeYgJbCCzcTuY7DHQSmiymvan51GzTiX6yQ/92CQCRiH56U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZXWFut4F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p+ptiLLQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HBMWfu027548;
	Mon, 17 Feb 2025 11:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=nqAbmzziPw1chYgvUhuPViMaUN/ir4DYqKgunwvebBU=; b=
	ZXWFut4FqRdTNbOef3YmLFRmRFjoAKZiRkXTLtFOjW5Ry0onH/MevC4OcD+B4XRz
	+DuIM7ywoOneaMFFiG9ho0L6QOT5CQY5VtKn1LSzZSUwOCV0vIhI2CMmKADIUP0n
	TgAccP8G6e6Fvw8qjCvhKIVXik0L8T55OdWJIGQpqo0Acbcge3Cxu2kybiUwPoU1
	kgRvqcYIBJbAJKis/POClvIVJEKJ6tVgQzC8lp1PXuZOyzkeBAQ5bK3F3aD0cHKR
	QlplpOcrs6aHxlYukJWeZR33GkJqZ/4TgRKAX1LY+3Z2tenLWo+Ft7t1MucJ3f0w
	4u0X0Q/rv0l248e/zM+ucw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44tkft41sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Feb 2025 11:29:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51HASfmN001416;
	Mon, 17 Feb 2025 11:29:34 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44thce2eyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Feb 2025 11:29:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vr2LKpJ7Bn6eoMLkx096Ic+WqD3tjumiASvmKwMzG+3U5Hhlytfu4ghOAyikZbAhE5qK+1wIUfyBO7kk2N6NSm0zCyB/Kl1mubLPlBRKDkT0q9OPm3GA6y5ts8XPmUZ0jwk+aaxRNlhYB4k50nLEFICKuceXppNIEIpx4l3thUHLTL7zlz/QxLqe0H1s8ME2L/SV98R4zGDao3CZo1yxITieO/55oCiAO/aZFCeAsqLe2NHl2IaQXjehyYqu5LtZkcBxracQew5lw6WYM4ZP7B+tzrvYVWRkh6hQq7Igg5YF4JeUGaDYozLGWGIqCdI1iOoJFvGzt80kR+VTepdcRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqAbmzziPw1chYgvUhuPViMaUN/ir4DYqKgunwvebBU=;
 b=euwpcWhgd4W7e9wlZADbsNp224kVR4PT2bcxAfIM48VLkSqD7KQrSGpqNpMFtx0XbWpu3wl/HjjQ8IVN2j7LRRzMOe15ol2QctAKh/RxkfXpvKWfW1mu9nbP0aBQsFsZQvWBWYSn9zzICQ6BmS2VhqXXkRIKga3tcFnCsiD21LZVBhVyrymU/wvF0WvzFSFxFpQkoLrgEew8drIsW2d2jHRz2RkjSuxcCW8YXF8lc6BAh9SkrhNTwSOw8DBw96jVy7f8LQgou4Ck4407GGbnknPCUqKcSSJ/TKrDUBfuUf69GxA3tn4Cj7QR2SxuAJ5HybDguvXsFShT7rQ0Jnta+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqAbmzziPw1chYgvUhuPViMaUN/ir4DYqKgunwvebBU=;
 b=p+ptiLLQOGeAhqyAiW1LDA/eOMGay3TbAA7ov+W0WS2UHSOWxRuNDk26VCaGlF4CATX1HQH+fuITMWY8HQneDf8t/6tNcIzbLdreANv0z9yGSckztRa2yPQVzBzLulanPrf9TSy8m/JE/UbU5nHJs4WkCNMF79FDePTCEo5HjTU=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by LV8PR10MB7750.namprd10.prod.outlook.com (2603:10b6:408:1ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Mon, 17 Feb
 2025 11:29:31 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%6]) with mapi id 15.20.8445.008; Mon, 17 Feb 2025
 11:29:31 +0000
Message-ID: <07985e7b-98c2-4b77-afbe-07a2338e032a@oracle.com>
Date: Mon, 17 Feb 2025 12:29:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] PCI/AER: Rename struct aer_stats to aer_report
To: Jon Pan-Doh <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>,
        Drew Walton <drewwalton@microsoft.com>,
        Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250214023543.992372-1-pandoh@google.com>
 <20250214023543.992372-5-pandoh@google.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250214023543.992372-5-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0010.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::20) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|LV8PR10MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: c811d6bf-eb1d-4aa0-8ff4-08dd4f465901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHlVU2YyMGt0a3JEMXQzUjA0bzJDc2N5NEJrZ1lRenJwa3RPaE5tdjg3eE1K?=
 =?utf-8?B?ajV3Yk1lU2UxL3pFVTY5b2tTTEtva1pRQmZYVXNSOGw1ZU1Qa1lCTkw0eERF?=
 =?utf-8?B?VTZOVXJYU0tMb3VvYTRZbG0rd2JqcFFWM09aWklZNDZNN0hYUXdrT3lKNTVm?=
 =?utf-8?B?Uld0enoxSHMrdkNDRXdZdnU2SXlUbkpXNlcrRklkV0k5WmVvY3BWQVR0eE1N?=
 =?utf-8?B?RVNqYTJyZnpicnY5bWt3KzM3OGUzWlA3VHp4cnozb3QyeWhTZURPT2xFZ2ZF?=
 =?utf-8?B?U0tiVFlmelJlTUhXRjFsN3RqbkVFNzloOUc3T1g5YjBHRVFSa2E2d0V4U1pP?=
 =?utf-8?B?TkhRUWJqUldqMWRjbmlLcGV2dGxtc0d1OEM4RjAvNTAxUTNIdlpIWDN3Tmh4?=
 =?utf-8?B?YkRZZ2NSNk1scjhsY3Rac3JyR0RQVFlRZlhHdU1NVHZaSEkyclNtTGI0eVhy?=
 =?utf-8?B?d3NLbmVSWHptU3BUR3hVcTNiN2lXMHhtZGFITE9oQU5GeFVlSnR2V29tU05I?=
 =?utf-8?B?WkdUQm5NMGUrTURLQi9aVndjeEx4Z0RZSDBhQUxIc2krRW9QY1Z3YXhaa3Ry?=
 =?utf-8?B?d3djdEY4aC9qQUJsNVVOenp3djhzSDhRY1hxakZJZWs2eXI4cVhmRERXZlJS?=
 =?utf-8?B?N3AyLzFmWVJiWDRQUGphUnpGRzF1NVlYNDc1dnZmelRldm9sUlI5UzlaeTZi?=
 =?utf-8?B?MFpBcThFNHoyVjlUa1VFUk41aHh4THV6bzZaaENBMHNnQkhQMmxiYytCNnhm?=
 =?utf-8?B?dEY1NFo0WWhITitITmt2cHJqZkNvQUZTQ3pQUDM2Z1U2aGJoNjk5cjRUQXIx?=
 =?utf-8?B?UWFNajl4ekpQUWx2MEtkVUVYT0hQNzdjaVcvUHd2ZHRReVZMU0s2aVZZOGhi?=
 =?utf-8?B?bnBGY1FPcjZPbFhhUC8veGxHSng0WU4wbmJpQWwzYndNNG9MU01Zd1dZd0Jo?=
 =?utf-8?B?Qm1YS2JKMEJHL1hCbnJnRC80WXNHcGxMOTdxckQ0MHhGN0MwT09pd2pQclRl?=
 =?utf-8?B?LzZ1NFFJTXQxRHhlbXpTNFgwcXFUU21ZWk1GWlhhWWJaa3RDQUxuVlEzS09s?=
 =?utf-8?B?RDVMZzB1bWVmSkxwcE5OckN0RVJ6V3lEbU5JTFZGMzc4K0hNT3pUcmVGM1hr?=
 =?utf-8?B?OVNMeVNKcWZlZVQzcTgxWmljYXM2ZnlxSlc4WkZsSkcxMHlSK2VqbFdSbEtp?=
 =?utf-8?B?N2hGWTlyTHlacXRtMDJjMlNrLy9HT20vTFcxSUY1UEdXM1lrb0RxbXNCa0h3?=
 =?utf-8?B?WXFkZStnRUJXZ2F5dnRZOEQ1U0kzM05HMGVub28zeFFxZjJWbkhpdURKeXRO?=
 =?utf-8?B?TVlkQWhlUEpaaGE4KzdhdVBOOTJxOUdwNE5VNVhPRnl5ci9DK2xQYmpLc3FF?=
 =?utf-8?B?bG5ld0xTTU1YK2NidEhXTjF4TDhmbE1vU1VPYnFBd2Rvc2xTcEdmakgyK0Z3?=
 =?utf-8?B?YTU4Y1JVY2pWMC82dk1mVTV2K3NFQUw5cGhmby96Tm11YVplc2FJYVBwa0xL?=
 =?utf-8?B?WWlrSGdGelltOGoxRXVWNUZzWGVDWHc4ZXh5TWVvTTZqQUR6em95R3NSYlpO?=
 =?utf-8?B?Snl4bndtSS9FbVdGbUJtUGpRRUhUM1RBaERxVzF1WjNHaFhRTmVYaCtZWmMz?=
 =?utf-8?B?OWRoaUVwYkloRVRPcXJZczNRY3Juc0FidW1uYlBLamZpaS83MGJKdTNjYW1H?=
 =?utf-8?B?UjVGK29LL21iVDVHVjdPa29FdldGZ3l2TXI2Y0tEbEYyYU5FWFRtZDRMcWs5?=
 =?utf-8?B?U0Z0VHREYjZpQlZMS3YrelB0U0tUbW5jbW03YnJ0RVpld0FLN3VMUE82UkdY?=
 =?utf-8?B?d3hKanRxZEZRUk1tVmJjcGxZNlQ0T3VmbEE2aFovV1VvYlRUampSSVJWdmlp?=
 =?utf-8?Q?rFjzXXqz39k7l?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1FHN08xL0dtV0RMYmhKOFBaUm9Wem93R2pqZWJVd25NTWVaQUxzSnB5K1BE?=
 =?utf-8?B?MnRGNm1sL2duSHpVOTZ3ME9ZRnZNUk5meWxFMTBIdnFZc3ZtZnc2R1ZmNzVC?=
 =?utf-8?B?dCt3YU05WExENTgxVTJ0ZEVBOW5zcmFRRExHb2YyaFk4Z0lod1JBNHJ2NDZN?=
 =?utf-8?B?Y1ZTMUNwd0hHWUgzODJrcVJpSUEvU2ZvQWJoNmpCUDJpNmZUWHlIcHNtQ3Va?=
 =?utf-8?B?WWFRTEJvcFFHWVFBNEdqenh3SVVHeWhEY2lScGs4Qi9RR0hzZXhZMUZDMWxI?=
 =?utf-8?B?aGNzMVdsY0twdnBaVk1lMVZ4eFpPTFMxOVpTTE5UK2hOYmR1bmNnU0xNd3da?=
 =?utf-8?B?ZW9jSmFsUmZiVE5CUG92UDB5cHk2dzRIQTdWNlM3eEs3UDIvdGRmYXRRc1A1?=
 =?utf-8?B?SmNpeHFUNHVvRU8vRFNrY2QvNHYxVXdHWXhDVWxnMVBLSmpnWnI4anRnOW12?=
 =?utf-8?B?SEI0cE1uZFYyclUzYUVYVENuUzVmNGFVYWpkbWhlN1NpcS9zZkUvRHhPcUht?=
 =?utf-8?B?cHBSblJJeno1L1RGWUhrbnAwWlNiVGlZQ3ZoQkNrRlhvMStjSjJoT0pWMDNq?=
 =?utf-8?B?OUFRTWtSQTd5ZElCb2V3V0pLY3I3S1RqK2FUa0J0UTF5dWppeU9lRGdkY3NY?=
 =?utf-8?B?ck1QVjVCNXZFaktGQ3BYeVQycVlrYlBncVRVMWJYK2p3MjBZVEJtdk11b25F?=
 =?utf-8?B?Wkp2N3BDbm1Odm04YzAvcGpwRXlXaUNEcU01TEtiZFdQZW9rVnJqOEI4UHFE?=
 =?utf-8?B?R1JmUHNaQ3k3ZHpVUUg0dXNnejNSbDVMY1NKekJ1Y2dUelcySEc3dUJOeGl3?=
 =?utf-8?B?dmRDdDlxSmNUMmxrbHVxTHczN3dMOXU4SjM3NFl5WU1RWC9Ec1ZsbjB0QjBC?=
 =?utf-8?B?WUZJV2trTnNpU29SbFluNVBpTExQSHFCamU0RkZmUkU5VDFsS1JGR2xIM0hu?=
 =?utf-8?B?SWgwZHBxejFSMWVDRU0wSkdLOWtXb2VBd0dtOTNQTjlPLzVZblR4QzBoSVRw?=
 =?utf-8?B?ZEgwakl2Z21HVUxQYjN5YmNwV3NuUXRrU1BMM1ZraXNTNzdnSXNXSHZsK3BH?=
 =?utf-8?B?U2REdEdmTE1YUU1tLzlOZTlTdmhiTW11UnpONTdWQjdnSG5JUCtlaUFQZjd2?=
 =?utf-8?B?VmRHWnlTNDIvMGIvaDYzQlNDT05RR015akFsZFo3TTFEQ0dEMHNEcVZiY1A2?=
 =?utf-8?B?UXJJdytEaTRHWXZQWnFFdDdXUktqay90Q29hVzVObmRmYUZlcGpnSzZ6S1hD?=
 =?utf-8?B?aWVBN20zazJIc2FFRWd4bzVPWFJaemc2a2xzM2VjZWRyaDliLytpL1ZOTHZi?=
 =?utf-8?B?bTc5MUFQSWZGMWN0Wm5PNGk3VHE1d3ZPaUh0RVpBYWw1eDRmT0JPbFdYd3gz?=
 =?utf-8?B?bjhFU2xXZ1dyTGtocXFadHkzUUR3TEVKY1BtQzU2NTJqMW5ZbDlKcS8zMlND?=
 =?utf-8?B?Q1ZmQkdUK3NOaVJTTEkvQkhwdUEwYmN3T1RoemoxZXNNbU1nY0IvYXlmTTFj?=
 =?utf-8?B?a0x1anQvUjIwTkx1TnZRUkhkR1FzUTNiYi9Ca21WRjM5Y09NYlZRVUNyRk0z?=
 =?utf-8?B?RDdFQnFadEVLdG1oQWdYUzdObFlYZFdOVjRRTDlzRGpFSDBvWjgxUDVGRjRF?=
 =?utf-8?B?Q2ovOU5obUltV1FxSXltdTNCRnVUdXZXN0FtNjBJYkJ5bVMvajlkRXoxeW1a?=
 =?utf-8?B?OWNZNjBXbUs5NGoyZWRLNmU3TzFNTWJrTnJiQjE0ZCtCcDVPODhTdForOUxm?=
 =?utf-8?B?a0NpZG4yMDU2MktWMmRKblNMNXF3RXYyKzV4L3BaNDhlcDBPYlZCUW01MFFp?=
 =?utf-8?B?YXIzOHhJdXJudnl4TktLU2E2UXJBN3hxV2NsM2MxaXJaS3NiZEVDZUxoSGV5?=
 =?utf-8?B?TldDNUV3c0Q4U0VpVE1YZDFIcTl2cktFWmRUQWlZQ0U2ek1kR0lCTmIzWis3?=
 =?utf-8?B?QW84MktSYXZ4OG9CN2pxNGRrQ0xXeC9XWXlWajNhUCtQR1JhcDMrNlh4TEtu?=
 =?utf-8?B?dmp6a095Y3c1RittRVltbnhyQjFQZ3ZGVE9YSEx3ZDl0d0tKUmpyLzBWenVZ?=
 =?utf-8?B?dm5Dc1RQRStDY2lPR2ZXeEFpY1RnWVQ5UFRLMS9JSkRSdC83clhFSHhrMzQ3?=
 =?utf-8?B?dFQyamdJR2RrSCttU1poWUgrZEplMHIrOHM2bFE1emhzQzVpb2h2RHZRUnFM?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pIzcuzMXeGA17uW5x2ZGMU86g8W6C6UPbeDKEGdS+i/Dvkb4eGVB6B15/4Pw5I3Z84z9rBUNCpKJXGGaL7OZioqyIBd53RZN1EO3/6DKtZSghFVQ2y+5G/LM7nbRcA6AX6y9yvHnBoPBNxj1YXseVkWItxPsMhmU30sXrGJ2T1KbAA9a1JOtOdPfyZzx7gVtGDgHu/21lVzP8k0pFVzYpvmv8+sW0Cfmo2BMAEL+rDzZ7bxODXvJhxgLdqTiwlPfdU7+B5PPT/NvhEBG4+SvMmuVykhi//6Wzs5wzTsXA0DyD0U1V+eSRgfmX/t/+wQyU/NgmSeGI2SiLLFx5WMCO/nmwu15RCEENXgybUqV9dAI3q9ZHpgd7jIq4Q/ach6qD1Tyd818FmWa177uY4Z7uwbWkeBhTKQNsOWFR0r8xsEhJXeukdSgekE4SiPqUQ95cZvNlllq4wBh4fwDgp3+lLyBHziSaEOZGEt9hKSzs5pKvfht+sD9dV9As9rg0adRM4k7vO1bOKFAnR0ZNor3GZMOeTFlfJ+hZydJ630QVjTGuX7r79nIPR9UkrJUNQ/SGJ54jVz7p8S9P5XZc5iDYt9rFRUQM+ez04GpcU1+pRY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c811d6bf-eb1d-4aa0-8ff4-08dd4f465901
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 11:29:31.8861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9APmsBl2jArr/xTxiCxPIzz7FqePN7NuBgm/hWy4aT5GxFKRdlAdawvZ2FKHnKgvCQpETMftLEa+/D8uRby2QgI+eVya19e5je96WZLEB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502170101
X-Proofpoint-ORIG-GUID: 2bj29FDwBJ-tmDsyq2fH1pYVr6vRZgQ3
X-Proofpoint-GUID: 2bj29FDwBJ-tmDsyq2fH1pYVr6vRZgQ3

On 14/02/2025 03:35, Jon Pan-Doh wrote:
> Update name to reflect the broader definition of structs/variables that
> are stored (e.g. ratelimits).
> 
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> ---
>   drivers/pci/pcie/aer.c | 50 +++++++++++++++++++++---------------------
>   include/linux/pci.h    |  2 +-
>   2 files changed, 26 insertions(+), 26 deletions(-)

(...)

> -	dev->aer_stats = kzalloc(sizeof(struct aer_stats), GFP_KERNEL);
> +	dev->aer_report = kzalloc(sizeof(struct aer_report), GFP_KERNEL);

The rename brings back a checkpatch warning (to use 
sizeof(*dev->aer_report)). If you feel like it, you can fix it. Apart 
from that:

Reviewed-by: Karolina Stolarek <karolina.stolarek@oracle.com>

All the best,
Karolina


