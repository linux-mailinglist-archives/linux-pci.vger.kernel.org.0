Return-Path: <linux-pci+bounces-8152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F55A8D6C50
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jun 2024 00:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05C911F23451
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2024 22:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203EB7E101;
	Fri, 31 May 2024 22:02:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C4724B4A
	for <linux-pci@vger.kernel.org>; Fri, 31 May 2024 22:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717192970; cv=fail; b=Esbl5Uf5L3Rq7V8zJd5C57XvBQ3a85bmdQDZP8N1wyWdmnHO6q3g7eavI1girJeQmYeO93SlJQRL1Mdkr0dT+jFeYd0JA5eIO9Jrmw1h22crdaluXvRIVOhqqa+X5tz/Zl4GJUNGaHWg2YE0p+Y59X2zSYobfez6M8XzZneKpJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717192970; c=relaxed/simple;
	bh=cqyFw/VuxfQzb8DfnKTttSXpwx6wBAUf5vcoFf1SneM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ibZ4iytFjRWWk2//PViBdNXAWZsaapgrS34beGESPtmWyr6P3Snfz9Gzcv45H9R+KJzftfqYpfeVatTLlodbQTPdJJ2UnC2D5Jp2hILqqMaEYhX5BFX04TLt0eRsASpsZ3Lc06mkpsobabHll0kg8KOX1U1vELPUA3rOifSwHmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44VIcPNX005630;
	Fri, 31 May 2024 22:02:44 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DMKxPScdOfU0HocMI4ozAEi9N0AlcQD1g4SuYaOFFYbM=3D;_b?=
 =?UTF-8?Q?=3DgENjD6u5u5JKnTvm6rfvqM8eEem2/dPPte5WaZjBVTmtdDvq3Y6Vwil2kpaN?=
 =?UTF-8?Q?VTD47iR8_10ns8Xx6rSooBamAeRM9cdy4m+HpvHHtWVesWecnsv0xMXr0H4NRJm?=
 =?UTF-8?Q?QMy3fnoB450sxX_LKhgfMEL9a306GxIM6qXWdQYEgUkfzUlmv2NKKFNRqQpUsj6?=
 =?UTF-8?Q?aQGNNccWys4WGmcjoy5r_PR8QbQX4f2kUud0ztuVJpF71MLO7sNskfPY27tz/CM?=
 =?UTF-8?Q?/KpZyRrijPFAnzfWgLzgRhEN8H_1KLVcWj40tBuX7l+iLKpcVRO566xgIiMh2kw?=
 =?UTF-8?Q?LszfW3rjiv19oTshqXJllynkwwd/Hxyb_Dg=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g4c33t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 22:02:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44VJpr1X026818;
	Fri, 31 May 2024 22:02:43 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50adhb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 22:02:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tk9ree4BigFqnxCq4G/htcHkQUXYVGxBgRv3Qqe1+TP58I/STqnk04V+uyDaVPJX1oJ1MR78n1VdiQ7z5h/Mohvv+FA9F3G/dI1J2JJwjKPVPvooWSnPI3q4VOdLTbONAvbJccJ+4R7cDbz/YDjn/mztetts4oJLEitkyK0gEiKP5BEi7ax2T2+u3c92CDIYfoVrK+F7iYnLLLIJXes2434zKH5t23mNej6cC4zC+zenwGpWQnzgFwiNyHEI/AuCpx8l9y78EsFGwR+qYLGITkTNOE3rblo5sSIckAq6Ul5klsvlFxm0/8H8IOCTH2l4Vsx0eQIanNveOQW7pw+APg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKxPScdOfU0HocMI4ozAEi9N0AlcQD1g4SuYaOFFYbM=;
 b=ndZG1Do9Eu5axKEhiakPR6ErmrhzxQqLUhquiFQ1E72OP0ng9UVMroSIKIrkBfe6Vg+8MeBYzMQMYKH6yxIisNCfkxWvOJWcR8DnXJEsJmDMPO405qCoclgDVVXURzmpRG96CZWJuMTA/nfOpHEWj3moXuvo7t6coRnjxE6/i/wKOO3j+QjqXpfwuhmaXiCZrcmB8cb8dPDhEn03/23qIra7ANBOZF+T32MYhHFsAX+tHartXFvyshKiwsmPrRT/9W4D4xJaoFk+U8pX6gsr35RlJEyUWpVPtmVd5lgoG3Y55b6yWorB3/S9+kttMlWx3kXcMUddvM+d3mY9VeS53g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKxPScdOfU0HocMI4ozAEi9N0AlcQD1g4SuYaOFFYbM=;
 b=uXamRV8VWD5IuEgL5N15uoTcY993Cu6msW9DY9YHXVyuqmrXer2ft5GDNaA3j7h4FV2jQF8HJwv1UPzoaEVEgWauKsjhE3DFu3rIMGSkKfGzGkpO3ta42tQ/02xREsxuMqufITXpAbPgqRMIIfdAAaGP+X8nl2Y0+D7xEJA33yQ=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by BLAPR10MB4980.namprd10.prod.outlook.com (2603:10b6:208:334::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 22:02:40 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf%3]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 22:02:39 +0000
Message-ID: <47fedc77-7a08-4247-8d63-76af3eff6bb8@oracle.com>
Date: Fri, 31 May 2024 15:02:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Spurious DLLSC on a x4x4 NVMe
From: alan.adamson@oracle.com
To: linux-pci@vger.kernel.org
Cc: jonathan.derrick@linux.dev, lukas@wunner.de
References: <c14b0b67-e766-4464-9acb-dc4f6dea0b7e@oracle.com>
Content-Language: en-US
In-Reply-To: <c14b0b67-e766-4464-9acb-dc4f6dea0b7e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0168.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::36) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|BLAPR10MB4980:EE_
X-MS-Office365-Filtering-Correlation-Id: 0190efc4-9e23-4f91-67be-08dc81bd6328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OEdYSWw4ZU9hbjNWc0VxZnI5WGduMW16bkpxSVJhN1duYk9raWVZdjJWWHl6?=
 =?utf-8?B?ZlIzOXFYREFvOGZ5a3BWc1h0T3Jkc09sTENWVkxyTXltRjcvM1poM2pZdU91?=
 =?utf-8?B?ZzY3eFNVSjVGSlVlMzJZRXdqVzAvaDZjVmI1NFN5cVBWTW5lS1UxS1V3R3h4?=
 =?utf-8?B?RDN4UWtDOWRhTWtOWmFON1RTUTl6MVZKTDNOY2pmc0U1NnNPVGN1S3BqNC8w?=
 =?utf-8?B?bVA2Q0JVQ1VoSEI4S1RjNU83aE1GUWRrVU5aSjJrQTdNTCs4Tnc2TExIcFNP?=
 =?utf-8?B?b08vQ2EyelZPa0ptZktSYTk3UVdPVzViMlAwbVlteG5rVHgvcGVVNWljTUxk?=
 =?utf-8?B?TmdsOXFLMGRnMlVxVnV4b3hJU04vZUNQYkRsWDdpQUp6Wmg4K0FsSEJZTHA0?=
 =?utf-8?B?b3JzYVVjQ29WQ2wxU0lCeDRJUWNFaFpSSGRlQmtNUUpSendvZ3hIZFpPdzlE?=
 =?utf-8?B?WlFjRktCRW82N2MrcWNHWlk3VFJNb050RUJ6YmZMRDlwN2FSTDU1Vm9VNGto?=
 =?utf-8?B?MWl2Mmp5aVo0bXZUazd1UFRHc0pudktvTUlxcjEzZ1ZwWXBUYVd3U0VCcXMr?=
 =?utf-8?B?SUxtbnc3NXVYNGlEeUV1SVFQdEZpaXM5Q0hnVndaN0ZSRmJXN2hKdmo1Q0w1?=
 =?utf-8?B?ZXB5S3RWNkQ1S25WdUsxdFlaR0NSUzVWM25ENGJFSlpRQ05SbGpqemhkQkRv?=
 =?utf-8?B?RTdZVEhGSnBTa2I2ZG1zTDBnUTM2bTlQWkJaZThlcm1YcDdEbUNCS0wvREE3?=
 =?utf-8?B?aDc4RmJZTHFMazExa2E3ejh4T3pqVFVGMEJuR3RiZ3I1RDdhVjlQblU0ZWdN?=
 =?utf-8?B?aTRKWmVYUXI2d0I0a1QwMGlJQjgxYmR3elFpUUowNGZYUFJtM1l0YlUwczZ5?=
 =?utf-8?B?RDhycUNsYm40ZWZUc3I5YXNjWjNFYkN2OGtkMVl4YTVkUTRDUjRIVDZUTEp3?=
 =?utf-8?B?TnNVdlBvY1VkKzBjVk1rTStYUjRHMENzalllSWdyWEZ1VHJSUVVLNEQrVEtt?=
 =?utf-8?B?WTJEL0lNY3lQSXhFRUJNQkdmRGZQbzNoUUVWMGo1a0c4djFGUVhHOEJydlo1?=
 =?utf-8?B?ZjdIeUczMFBZcjY1UmpBYjdjaWpYSXJ3ajJlNFR6SUx2amdTQXY4OUVvY1ND?=
 =?utf-8?B?dTNLOU9NcVFnRjBFVk9PejZXNTFiZUd4Y3dwQnV0Z05DRFBUVjJHbC9Vb1RR?=
 =?utf-8?B?bi9hRWp2ekdHalZJTnNFUWw5bmxwODlYY1Y5RlRTQXdFbHJWVHJGeXRmdEVH?=
 =?utf-8?B?L3dPMTZ4ckFTODIzakg2Y3QwT0FhSmtNclRPOUppenFLRmE2dnhobnFwMGRQ?=
 =?utf-8?B?ODdzM3FSRlpTenpQc1BwQ0grd3pSdVBEZEhQdXk3RFczR1Q2MjMrOG84cTFT?=
 =?utf-8?B?cHMvdG5YRHBtNW5zVFpVL0FtSjduT1I0UzN2UDhwYUx0SVVUbkozRmhlblp3?=
 =?utf-8?B?QW15WUJRVmxSK2pEelExWFRlZEVEVzlyNi9xV0JpSW5WYTlRMlQ4STJscWNP?=
 =?utf-8?B?UzdBeEVNVEU4eHBwL0xxMEx0bStNWlVnZnhqQWp2U0dpTU53SmJTdGEvK1Yw?=
 =?utf-8?B?VmgxK0FOdTZwYUJJbEk3Qk9BWXdVS0NhdTRSN1hqVmllcU9wUFo2MWpCaFcz?=
 =?utf-8?B?N0NMMEYrblR6Um5wYkJvQ3VzNWkwVmc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d0VmVDJpZHFvcUNYZmZoZDM5ejU4dE5DZmZUbXdqTFJVQmdrV0tEUjVKQm1h?=
 =?utf-8?B?bGIxSXltV01Ec0NYb3k4Nmpvb2MzNzU0L3hSMnphckllWERydXVCN0RBbFlI?=
 =?utf-8?B?dDVVR2VHdE4yYUphU1AwOHBReFdEdFRJL0tXTnR3Y3pjVnR6QmhSYXdoMEFT?=
 =?utf-8?B?SmxWWVIvS2VFd3FpdnFHVDJFaWRMa0hudk13M0svU2M0VFQ3K24wUTlYSFlH?=
 =?utf-8?B?OGlDR240TkZDdkJOVGg1d2ZsZE02QTQyWDViTXd5ZjNOd3ZjN3IzZUk3S0dV?=
 =?utf-8?B?aVh6ZzJmRG5Ld1ZMZ2lFUnlhUms2ZDNxMHZRbFZxUEdiMXM3dThGc2RURXFV?=
 =?utf-8?B?VzlIT0hTZGgrY1doUStFbXpxbStOLzBaYzY5UzNzZUlnOEJjRnljVlBOLzNO?=
 =?utf-8?B?am4zdWpIL1o0T1ZxRUxIV29EQ3kycFh3bld4cDlOQ3l2OVc4RFBad1ZZSTZN?=
 =?utf-8?B?dzBoZU5yY2JrU2F5NVZQbTdxZ0pFaXdUU1dWdUowZTAxV2JlbmlCcnVkQlBG?=
 =?utf-8?B?TjNRbDVJYU9NSjYyVTViLy8wRmFMM0U2RWs0VjVXOEF2WVFtc1NFWmN0NnRY?=
 =?utf-8?B?emZ1YlJ2a3p3QUowVnZYVzF3MFlabXVMT2d4MUoxZGcrVHNsOTFpc2poR1BN?=
 =?utf-8?B?dFBMeE9uT0hyelloMlZtdkZLeGFHanFIRTZZR1djWHF1MEhIZG8zanA2dC8z?=
 =?utf-8?B?WVkwdnBmVkNmanM3MWt0RkZpMnFNUkJJNjFkUU54cUNiMEJqeWlaNytYdURC?=
 =?utf-8?B?ZDUzQkRaYkVpMSt6ckJHbGIxWlcydCt5SGoreDBZOGV5bUppM0FuNWp3TmN0?=
 =?utf-8?B?OG5rQkVjelo2NXBISm1KNkM5dFUyNFZmc0dhYndvUTRmRlcrcVJoWjlMRUYr?=
 =?utf-8?B?MUxET2xIRm1CaWRuL2NBNlZyTVFTWWJSN01sM0lGclJLV3doMzVFc3NaNkI1?=
 =?utf-8?B?bTVxZlBnWG91Z0krY1lHVWJSb09hTndzK2ZDUXFleDlDT1F5R21nZW5VWU9x?=
 =?utf-8?B?SGpQc0FPb2Z3azBYWEY4UHNSOTFkT0NxcS9iTC9yeWM2cmhQc2VMQnpEV09V?=
 =?utf-8?B?KzF1NkNOTUw3WFZHTG1VdmFSVkd5bitlL2xvcmdoYy9pNzVuUUdxZGJrd0xn?=
 =?utf-8?B?ek5lL1EwT2FSVTdlMk5Zd0lkWEk2UlZRSmtOK1R2d2hQa1RGcUpBVDQwalFO?=
 =?utf-8?B?bFV6QTl4MC8xNjJlYkk5dnF1NTVQZGkxMTNUNFhhUksxMDdpaXo1WTRreTlv?=
 =?utf-8?B?UjQxU2VrejFQZUFSVEwrOExOdU9oSGtYNmE0RHVKWUZCUURERWwzV2kzRGwy?=
 =?utf-8?B?V3N4NzM0ZS9tdTA0bU5vcldWai9LWDg4WDJzSGxSaUdmSTF6QjFLODdaeEJ4?=
 =?utf-8?B?MVR2RU03TC9oY3JBSFJ3VU9MY3J6N3JycllMZ3gvZkUwQWxUV0lUYXdFemtm?=
 =?utf-8?B?UlRtN3BKbUcxVUl3VmRYdnMyUkdtd256K0lkdjBuZ09aSDQ3a0xhTG9KTGtt?=
 =?utf-8?B?OTF2cGxCck5BaWFOZy90SWNnekpLdEZaLzhLU244Wk5QUlFiQjdFUk5HRXFi?=
 =?utf-8?B?cXBuK09XbWU1YlBvK2pSbDlGOUtUOEI5NDRSOW40V1NHbzZYK2Y1KzdnV2dm?=
 =?utf-8?B?dFEyOUVlWUtHUm1yaDhzbWhXZWdnSGttMzA5QXJVUFZoSGJvR2NiYnpQWWd1?=
 =?utf-8?B?NlJXR2ZRR3JjMytpcmEzRHZTVkVUalNhMXRPR2FpYUxDNXUwVUg0ekVlbHlq?=
 =?utf-8?B?eHpGdE5PMEY2cG1ZL2Vjb0E4aVV3WnkraFNlcmxobzhQOEJva2dMTVZ5bU50?=
 =?utf-8?B?WnRDeDJGYnJrenM5anBDL0NUa0tLSVgwL3Y5bG90bkI0YllnWjVGUmlkUm4r?=
 =?utf-8?B?VEdmbWtJaVdPaVk2cnAzR3dqRGZpY094dzBaVWYyY3ZDYzYzaDhJcWdRQURl?=
 =?utf-8?B?eTFhTHoxWGowenFDWmszeDZ6NmxlTjV1Vm5tcXNyckFPZ2dBKzU2OXB2a1dF?=
 =?utf-8?B?ZjViMmwwMWJWSXBVNFNpQlhUQ29xMTVqWGFPYjFPZm5LZXdIRUpjWkJ3RDBF?=
 =?utf-8?B?L01GSXE0ZTlQQkZEUUhILzNidEFzODBRcE5qVXY2U3N4WFJrR3ppdVBlUUxJ?=
 =?utf-8?Q?llS/EjpT1Io7HkoJN49KaGhin?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5CRbb5YxWget9hFsesWXsoMYB09LcrB3gIqp9Pf9Ubnb2Nz4ZXG+j293EHN9pzcBQVTeuGrqo6cJBzKxzvtsaPDYIu5TQkSAvQFfyfM1cOGZn1kNuIZPPJBrVWvxfc899axiMFUCm7P6j+wBuvsbhJI1ezYEnVHptS/ct2TZ8cCbRhrodVIVfN7Fls69rcD5l2slOP9K7CU44bXxQ7IyBzaD26afviDyZgaDaq5SyjR0DnBpHF18lKU40N1c3KaiR004B28jBw8c8fkIU2PLboewVqdJ9w4ZkFJbsmOAQkVDWVuJrdcyNgXYObFGtGhqogB69cHsP1IcICilRj2IjUDl9l/1FKPIAVRvbBjUQvF45qCRam+/zutwa8yvjWETYPPB32d04hBSgylhGQrHe+hCL7CsrnENFCsqZIKFchr5ZbzFlLWzeCqof6RiWO0NqJXp/BcEXu4cT0bSG0++Alk3ZY7auBGUMXNefHBr+vjuXgVUZRBQdk4XEeyp/Vy+P/ZwEjcWmDEMhqLpNYX8HF0VMvoW2racEvbpGVnQPNXrxmtKjdWWUrK0hrVJIn4thr/x18G0Caxccgt62Q8p1TLxOm7i8m2er1c8J6fi9u8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0190efc4-9e23-4f91-67be-08dc81bd6328
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 22:02:39.4969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUdbVdVMjawn8GAAyhQ65IQfVB34ODHjH9W8oBDg2UZhuhVojttA3Ju3YLb7hS5fKtxa0JN6t050jUAsPF5Xdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4980
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_14,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405310168
X-Proofpoint-GUID: E1_4_N6FgofUWNcydPtuX9_-dH2i52Wf
X-Proofpoint-ORIG-GUID: E1_4_N6FgofUWNcydPtuX9_-dH2i52Wf

Fixed Lukas' email address.

On 5/31/24 2:11 PM, alan.adamson@oracle.com wrote:
> Back in 2021/2022 there where discussions about issues when hot 
> removing a bifurcated x4x4 device from a x8 slot. I could not find any 
> resolution or applied fix for this.
>
> https://patchwork.kernel.org/project/linux-pci/patch/20210830155628.130054-1-jonathan.derrick@linux.dev/ 
>
>
> Was there ever a resolution?
>
>
> Alan Adamson
>
>
>

