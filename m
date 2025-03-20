Return-Path: <linux-pci+bounces-24238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFFCA6A95D
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 16:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F4C88233C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 15:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B381D516C;
	Thu, 20 Mar 2025 15:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lXCIAuh0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Fk5Fl5wX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F9274BED
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742483059; cv=fail; b=UlWem/F8Y1YZ6ApY3KZhJogL+fcrqg1FFJxZhVAZdgZNgQt7XPR8G4u60UR7WBfQeSDJs3UWSSVaHipGNnMVQci4B3zM2/NK/IqGnO2gwYNilctOx+PEtEDQxVdn06dO+nK2z6SiDtZb7UDs7WV0SsHxzcZdtVcuoJqYZHWH7y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742483059; c=relaxed/simple;
	bh=/zLLvm4yGHQu/rYGheag1j2yEoCclPwvt1IHR+d8rLg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZyS6x3h6+3m4gXCPTSrqbzUd+F0w9HP4djhDe3I8DKiKJebFbc4MnywreqipOAhAyW6WfJkccWyY/YJJmF7RG+sdaWrBwvY7dEUmFFxUnisL/ICPAgvBZ2wNfx5qxyWvFlriLMx1O16jB/Lch/Q7MINCAMjcGHLJGHXXBfvPpHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lXCIAuh0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Fk5Fl5wX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KDMhB4008299;
	Thu, 20 Mar 2025 14:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=A6wWfb0yjzbN5oQNU4WFP2Rm418oKY1RlPb6qqM9R7Q=; b=
	lXCIAuh01R7NRD/sh22B7M73bSWsNj+LFxDGiFiQ1qb72ayvS8ACvnEHNtRkBX/C
	PNxHVV0af4APkiMcbVCsfVP1SXPWRobI7oZuHSw4TYoeITZVD30y8p9dTcbXsV9Z
	0c+JcgMhV8DCAf6tWCJQnFUai9/r/NkR0ApP7kDorQ/M1DWM0ZvrZEv5QeJBhWLS
	StBjkwu/Aw/zonc5AmOR+ep4916Il8AtkmldvJWYX1Xp2HBO6lQgv6u2gMfx1Q85
	rNolojVeYc7z3hcYwF2epx8Z/fjbn6C+nIIjbQ0Q0GsW52AKYygb/tF6BXlLATn/
	YIRLvmAW7kcD8AwcDv24ng==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1n8p8k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 14:58:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52KE2pJe009632;
	Thu, 20 Mar 2025 14:58:43 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxm2sy2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 14:58:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wr5z1FLs7a2eXk2uHDYMrRVucehvXJ87qQLXfHz2OJpAQWiCXitH9QDAkOmL/8AP6AGFAuvXT3H2+hiPPx6eVoKyGp5dTG1j6uzRSyWbkUdMFeScbRGdaTMndkjdgZkrIFeNpFnUyEeJVF2K+PgorqNBfug39qCNsaOkES7rF1oQ4juDxkEJ+Ipy8nQIo4pHOrPOlyF9nAwuCcNtjOR5rP9w4QMpJdo5U//5UZOqRRwqLk4y7Yi+21B91ewPl11VDQAwzo6yO1eKUQgyaDfjMZSWAVfTzs/zD6ID/7w/KdiZNy/HjusU+kF/4hzcRA2O3CdOsU5MvIIOz3WsaAw0pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6wWfb0yjzbN5oQNU4WFP2Rm418oKY1RlPb6qqM9R7Q=;
 b=UUJYDFo6Vv731LnzEput1n3ZANqwym9wqM3iYjKjm/nx3dvjV0jhvFtimMxb9OdJU/a1pbKl7zetN3ZnWa1r6rDBEptHqO5MDzcKELDtVY/HnNMC59X+BDHBgCb/DSyTMBRAfUlFZSDJguBCAzJsoBOPg5kxnXHvEI/JRzShHiZe+SFgKkuRWEAvRYbMC2Xzf8VemImUhEf36EOi+zIOZSlWR7CJKdxyfvYwd55eI+bT387rFZkm9jo5lpjCkf42fRPqfgyT3mQWRKBIXogrGSb7HAVF0ALNDp0PG/hcVk9mFMjErmwrg6lqDNck2QxtlI7xcA5uLDyFcG/HrrzHQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6wWfb0yjzbN5oQNU4WFP2Rm418oKY1RlPb6qqM9R7Q=;
 b=Fk5Fl5wXWUB7TqHi6SKClXaBGvySon2KLmwXa3HBB3kA3HvQ/r6F1MmbSc6iJ557TmkRMVkmLD9nzquZOL129jy0zBRQOg59MJulzk/DsY7EhXyjchbDlL5eRx63HFqUUWwJOhtUsAWUC/QJM0KKOwQgADh45PLkI7V2ny000+k=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by MW4PR10MB5812.namprd10.prod.outlook.com (2603:10b6:303:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 14:58:40 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%6]) with mapi id 15.20.8466.028; Thu, 20 Mar 2025
 14:58:39 +0000
Message-ID: <d75a96f1-5162-4ec4-971b-9ebd4cfa5447@oracle.com>
Date: Thu, 20 Mar 2025 15:58:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] PCI/AER: Add sysfs attributes for log ratelimits
To: Jon Pan-Doh <pandoh@google.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>,
        Drew Walton <drewwalton@microsoft.com>,
        Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Terry Bowman <Terry.bowman@amd.com>
References: <20250320082057.622983-1-pandoh@google.com>
 <20250320082057.622983-8-pandoh@google.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250320082057.622983-8-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0021.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::9) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|MW4PR10MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: a14cb399-0aea-44f6-c88c-08dd67bfb304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXY0KzkzYzdNSE5RQzREdE9tZnVSSEMrZE9VTHRVajFCWDFudWs2VU55aXY3?=
 =?utf-8?B?M0NMTUhoRjAwaWdNN3FpMFlDK3cyWlFkbzJ1RnpDVnFwaU83cndrblBWNTB6?=
 =?utf-8?B?SDloQ3h3cmwzbG5tZmYyc0tnNnJ2RTFDRldxUHkwOG1JRGYxdnQ4N3VrTEpi?=
 =?utf-8?B?aEl5UnhoZUFTYVpjbERXQ0lMVWtCenpRNXhyeEZFaU1Ealo4ZDNlcG91TS9T?=
 =?utf-8?B?Z1BFbkE4SmRZd1JGQktuSk52TTZjeXdZQ3VBWFdtNjdIaHl3UVVXZ2hkK0NM?=
 =?utf-8?B?RE16QnVkaDlyK25JNFJEYzFmNTZDSlIxUlk0NkhOK21BQjdEMmUvdXRjV0hU?=
 =?utf-8?B?YUxCZHZna1FXVmhNRWxTT283VmtTNk10eFJuaXBkU3lhcjgzK2FFcmMzOENS?=
 =?utf-8?B?Ulp0c3BZNXAzV3FNeGxGdzIvd29kZFA5ZEpldGk1VUxzelhQa3hQa2FPN3hj?=
 =?utf-8?B?SE1hY1hDZ28yejI4MmU2dG54dDRKdUkvc2tHYXl4OUxFSWx6dVByYlRvRE8r?=
 =?utf-8?B?Mkg5d3grR013ZGY2MmJHS2U3aTVTV1JqZFF3N3p3dDFSaDBqNWljRm5HVXFF?=
 =?utf-8?B?Tlc5VGVzRmgwTjJjai9SRGp5ZjM3NEpEYU9oM1JmZTk0eVpYMjdRSEJxZnA2?=
 =?utf-8?B?amN0amRwN0l6YnpBWktsbG9UM3BoYjZqZjFGOUsvbjhFcnBmTTJYdk5RYXI3?=
 =?utf-8?B?b1lLM0dPRlZKUXR3TS9YTkJnbXYrd3creGE1dXJLbVVhc3VweVVWZWlEYXVz?=
 =?utf-8?B?czNCR0JSSzN5c3VSeFdBL3ZNVFBHRDduYTMyaHpsVVBGLy93MmNNTVFvSEV4?=
 =?utf-8?B?bnJrRjJvN3RPRUVPeEprWGU1SkkyVkVsYnFRQXF6YlFpakI3UUdZS0hFWUxT?=
 =?utf-8?B?WTgvSEJLUmxIYi8zelZlVmgxSGtMTXFQcWtEQkxBMURRcEVrOHVrTGZUb2tm?=
 =?utf-8?B?VDIyN2NuMGZ2bFFLczQ4ZlFlOWUvUWNkK2lzOEFXOXVRcThKWjFwd2ZudmFp?=
 =?utf-8?B?UzQwazVEb01VdmdCWmV2Z1VGYzRlVWgzNFJ5anlBNStWckFHQyt1cVFGMnFE?=
 =?utf-8?B?eDJNeXBBekNiOW9SODJvNVgxbUM3UU9PbWlEbkxJTUFBOFdxb1hrbFovTGNJ?=
 =?utf-8?B?T3hnL2w5dkZjODR5d3dWM2cwd2hQd0R2S3Ztby9ZSVp5Y2JqQ0QwOWYzbkxC?=
 =?utf-8?B?NG1XTnFubW1jQmJXSVZNcjM2dEl0cmFOeWQ4cEZiRytsM2Q3TitsbkhzU1ky?=
 =?utf-8?B?RCt1UXkya2d4cTRLRDNVTnpZcWNGdUhjU2FCQlV4T29LdEdPK3FiR1ZLQk5k?=
 =?utf-8?B?OUlZdlVrbXJEQ1JRVGluamdSZFdjb0t2ejFnNHRkZ0hqak9IaDN1bmtKWmh0?=
 =?utf-8?B?cFdGa05kRE1JRWRkQ2d0UXVmeVJ1TU5LalBpUzVUYnIvVkZKQ0x5SU9CVEIv?=
 =?utf-8?B?Q3hYNEt6eFNkcGY2TTJ2cXJRVDhpTFJ4Z08zUE8xaDl1ZVBiOEI4WGJ5QWJH?=
 =?utf-8?B?UittZUg3dXd6QjdlUzlwT1hCaHFEckVlWmFtelRoZElYN1N2SXl0MHhXMmZJ?=
 =?utf-8?B?cFB0ZXBhRmFhNHBtZ0IreE92eTBjektVUTFEWTJ6T2dWcTFIckRSNk1aMENW?=
 =?utf-8?B?bFRGRU1mMFdVR09XcVVxQkxJem5mV1pSYWo5UnpWcisvbXFFdmtrQTJvcHdG?=
 =?utf-8?B?VUhBWElKM0FSSnJ2NjNrdFZtNUY4MVRFczZiOHdvRm1PTVpjNEpQQVJNeWt2?=
 =?utf-8?B?dVMyaU5GZXp3SFRwb3RLK1lQM2R3bmpnd3d1Qmd6T2ZWZStYTCtwT01KS0g3?=
 =?utf-8?B?K2FuZElmc0d3NGNiS0JhTUJRdVBSaXR3ak5mRXRJL1o4MElGNklKM2RqYW51?=
 =?utf-8?Q?FSnUhFh2guPW3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVJHZDF2d0tOVDBORytRT29zbStTbDI3NnRzbjdMZko3VEt1c2FrWFJ5YlUr?=
 =?utf-8?B?K0k2ekpNeXRZT2piMk5LYlVwMU5WMkJUY2lMb2RKei9zV0tKZ25OWWM5ZytW?=
 =?utf-8?B?c2xwZVE4WWc5N2xPeGJXL2VVMnVTbHJYaHRvL0hSaXhYbWxSYkk3dHpOZXM3?=
 =?utf-8?B?bnJkL1Q0cC8xbUVvNXZjZmdVQ250WEtGY0ZwZW1NamRoQ2ZHaWJXdnBtd04v?=
 =?utf-8?B?a2N6N1FGUTdUUjhLb1hKNTVEUUlDWjdvWkVwZHAwSW9qWXJHMlJyNEovcmlr?=
 =?utf-8?B?U0N3UnBhOU0yUStLRjY1T3lIUFlac0RvR0IwNkc0U0gvWnMzVlZPNGhyc1Nw?=
 =?utf-8?B?UmtRZXlUTW91K2ViYlM1amluaUVDb2U1UU9ZQkdaRVhKdkttcnNDaW1YYUhS?=
 =?utf-8?B?UFpFbXFmYlU2ejB0SE9qTDhTdHZ3a3lhZ1MyNXpWdUdMMmR5Rld5SnpiWE8v?=
 =?utf-8?B?dUVIQWtkb05veUVKOHI5S0Zad2FUK0pRTEZhMVhta0JVbnZBaktmYW9QSHhn?=
 =?utf-8?B?bW5XZzZoQ2ZKTVY3bE1jSk04Sldra0NRWkhJYm1idDFWSmgzK1RYME91eEpS?=
 =?utf-8?B?VVVSWGFXRTRTZ0tkSGl2NUgrcFNSekZMTk0xTnkzMXNFSHFGWmhrMWhkMXp2?=
 =?utf-8?B?VWRKOUhCYjNqRjUyR2lHZ3ZkSnZmcTlVM1pwamhudmxlK1ljNzk1RzBZb1lN?=
 =?utf-8?B?eXprTGw1eURDVEZLdXBvblpkVlZKbGgwa3dpMlFqcTdacEtCU3hSNHU2Zk12?=
 =?utf-8?B?ZW5lSGlaYWpraTRuUVVweWNYMzhwbnZHdjhPUjZPb3RhK2VPT3ZWVGM5V0wr?=
 =?utf-8?B?UzFTM0xrQ3JCZkt6Y1k5NDBqZ2t6QVNndWxuNGk1cWVub1VHUzRLK09LOXN0?=
 =?utf-8?B?eTVlU2lFbXhwUWhualF4MnFUT1RjQ05ZV2MwblBkOFZ6aUtoTjg5K1dscTdn?=
 =?utf-8?B?RjlTd3RFS0EzNVorc1ZSdUE0Qnd3RnYvSTlDRzVoWEFVejdtTURUOVJPSVlv?=
 =?utf-8?B?V3RwRkxtSUtFMmpUOFpYMnhrNXhNR0d5OUgvaG05N1A0YkZOaS9LbHh1SXJh?=
 =?utf-8?B?ZHQ0RkZHWVJVTzgrRmEyS213YzA1ZmhJclJFNFhGN2VzM3RENUM2aW1Gd3I3?=
 =?utf-8?B?cjZKT2dqZ1k4dkpDRjVKUFhwQm5NRWlaN3FmRDdGQ3E0NzVwT2MrWFBTYk9i?=
 =?utf-8?B?S2NkMFVLeHd5Wnp0RkhWaERtQ2ozdGtSSFQ0bWlvZE4zNG56cVo3TVk5ZlVm?=
 =?utf-8?B?am92NXVVTkZIV1pCdFIyUStkQWFsZzVTT2dEcUFrQkFIcktQMDdDMThvTXhj?=
 =?utf-8?B?WGhQRXZSWkVHeUUrcDRLWHF5dkFNQkpPakp5cnAzcmdCZityRy9aS3c5T3hI?=
 =?utf-8?B?WVp1cXhSTmE4akJhWThiNnl4OFA5NnFnN2hEWlh1Z2p6R1duRTk4bDVqZWoz?=
 =?utf-8?B?SGJXc24vdjhtZjNyN2V5UExWKzFSWG4xQWowZjg3bU40RlArdHFPSnE1U0hk?=
 =?utf-8?B?azdSODFvaE12b3M3UTFFWjFlZm53ZTE4UmNLLzNLREpLQllYUjFUQjFnK0dm?=
 =?utf-8?B?c0ZMcE5mOG1aTjRmaVBwa1EvK2VDa010RGc0TzZQUjdiT2JZMW05UkF5K1po?=
 =?utf-8?B?Q2RSS08yYVJCRWJCSXI0Ti9iYmV0cjhCRGowdEtwYzQ2dmlJZ2EwTlkrZ3VY?=
 =?utf-8?B?VGl6WWFxZlNtdEJIckRqZ3ZKSFdIVHNJOGZOcFo1bnJkU1hSOGltL2ZCVFFI?=
 =?utf-8?B?S1kwTFVFZEQ4eEh4ekJuazNqSUhHMEU2VVl0cGZMeGJnQmVRbytvcnN5bUIy?=
 =?utf-8?B?UXF5NWhtTDZ4bXd5TCtZRXhZSGtHZ3pmSVNpV0RSakFTY1hzMmRtUmQ4dytM?=
 =?utf-8?B?Vmdvb0ZwQzExMG9oSXFCdTdIek9JTTQ2TnNjZDM1L3RDOTJqMXJHK1BMV2cx?=
 =?utf-8?B?bFkwVDMyT1JKOHJnLzJ0aTBVNTNNZXJiZDdLM0ZuMko1TVpScU9wYi9RRTZi?=
 =?utf-8?B?c2hBdGhhQlhnRXp3c2FtZGZ0algvcVZQSUNicGhsREQ1T090cjVOaEFBazVH?=
 =?utf-8?B?bnVuYVRUWmdraWpyM2h6SGhRNUxUQ1U2QkRxbHNuVGpSYThvUWZTMnJ6MFU0?=
 =?utf-8?B?cDlJSnRmQXhhK2lBL0x2elVZRXY1eUI1bFQ0dy9Pd3hyOEdZcStGeTdYRGoy?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2gD3myDxhxkQtIUPLYDgdgogxpY4LJIPbX1XjdMpl9QFP9AQ6EU7hVZfe8Cz+rKMM7z2IEP16/9xeaGu+jJBFsoAxkiQXeRqf5WeX8aY9Vhx4TpNGpXNrhrLGZAx3Td64CzEpKtfe9t3pYczOGVb2lw1ogvve3C5z+bapONX5S5guifMlwUvFxSZKnKARiZ8dhG7PyoBRKKLMsNIwGQQt0r38z3G96KRNMdQgv/gnarue8C5FbXNoO7+CTTTRfcbhHIm1mrRqO4wknmVUl5G9jYvQ1/Y5FeO7+iE0yxvWgcuaqo6fFw9TBxbnWoSY1BSqOuGD5+kOWRgSNIjWU0etuKlCbiIlAJO3ZwUlU5c45lKgRhfLJFTEaxypS78g7PptLyYpoabT7/aoZyOaZnOzasvpjgZRud6O2RpjmLcO48d4esKv2lru5NdNgLpQHWILkurlbYzgXK9cmjVHN57DzQ070B/VWfgpm9EkFpONy72z77zBfBYWi/TiUTIPIsuiuV5zZUsP+f3fA5qWCaTQ5YcslwmVTNMIoIWoc4GVwh0rIOanf23c2PCbvUJDrF/3HuwVgI4btsh6vwJzDUdH9+JXM9vREOopM2lktk6a0s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a14cb399-0aea-44f6-c88c-08dd67bfb304
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 14:58:39.8816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzzCFN/6vfa65QoJWeS+ivwVOrEJKFhTHvwmKtC6pc0+6Ikx4jt+OUXl/vcxOMy3GMYhqGwKinJTam+XcMRDZfh+RwYtrWRCbxSAbrdMjdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5812
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503200093
X-Proofpoint-ORIG-GUID: EVb4YQEZd3RiOG0YqzXXx0QooS1_AeqC
X-Proofpoint-GUID: EVb4YQEZd3RiOG0YqzXXx0QooS1_AeqC

On 20/03/2025 09:20, Jon Pan-Doh wrote:
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> similarity index 77%
> rename from Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> rename to Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> index d1f67bb81d5d..4561653fdbde 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats
> +++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> @@ -117,3 +117,37 @@ Date:		July 2018
>   KernelVersion:	4.19.0
>   Contact:	linux-pci@vger.kernel.org, rajatja@google.com
>   Description:	Total number of ERR_NONFATAL messages reported to rootport.
> +
> +PCIe AER ratelimits
> +-------------------
> +
> +These attributes show up under all the devices that are AER capable.
> +They represent configurable ratelimits of logs per error type.
> +
> +See Documentation/PCI/pcieaer-howto.rst for more info on ratelimits.
> +
> +What:		/sys/bus/pci/devices/<dev>/aer/ratelimit_log_enable

Having a dedicated toggle for this makes sense. It would be hard to come 
up with a magical number that disables ratelimiting.

> +Date:		March 2025
> +KernelVersion:	6.15.0
> +Contact:	linux-pci@vger.kernel.org, pandoh@google.com
> +Description:	Writing 1/0 enables/disables AER log ratelimiting. Reading
> +		gets whether or not AER is currently enabled. Enabled by
> +		default.
> +
> +What:		/sys/bus/pci/devices/<dev>/aer/ratelimit_in_5secs_cor_log

I think this attribute name (and the uncor counterpart) is too wordy. A 
user can check what this knob controls by looking up this file or AER 
docs, so I'd name it to "ratelimit_burst_cor_log" or something along 
these lines.

> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 081cef5fc678..f84ae1872fa3 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -631,6 +631,99 @@ const struct attribute_group aer_stats_attr_group = {
>   	.is_visible = aer_stats_attrs_are_visible,
>   };
>   
> +/*
> + * Ratelimit enable toggle uses interval value of
> + * 0: disabled
> + * DEFAULT_RATELIMIT_INTERVAL: enabled

We set that internally, but to the user we are just operating on 0s and 
1s. I would connect this comment with what we have in the documentation.

> + */
> +static ssize_t ratelimit_log_enable_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	bool enable = pdev->aer_report->cor_log_ratelimit.interval != 0;
> +
> +	return sysfs_emit(buf, "%d\n", enable);
> +}
> +
> +static ssize_t ratelimit_log_enable_store(struct device *dev,
> +					  struct device_attribute *attr,
> +					  const char *buf, size_t count)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	bool enable;
> +	int interval;
> +
> +	if (kstrtobool(buf, &enable) < 0)
> +		return -EINVAL;
> +
> +	if (enable)
> +		interval = DEFAULT_RATELIMIT_INTERVAL;
> +	else
> +		interval = 0;
> +
> +	pdev->aer_report->cor_log_ratelimit.interval = interval;
> +	pdev->aer_report->uncor_log_ratelimit.interval = interval;
> +	return count;

Nit, suggestion: add a blank line before return (this applies to all 
returns in the patch)

All the best,
Karolina

> +}
> +static DEVICE_ATTR_RW(ratelimit_log_enable);
> +
> +/*
> + * Ratelimits are doubled as a given error produces 2 logs (root port
> + * and endpoint) that should be under same ratelimit.
> + */
> +#define aer_ratelimit_burst_attr(name, ratelimit)			\
> +	static ssize_t							\
> +	name##_show(struct device *dev, struct device_attribute *attr,	\
> +		    char *buf)						\
> +{									\
> +	struct pci_dev *pdev = to_pci_dev(dev);				\
> +	return sysfs_emit(buf, "%d\n",					\
> +			  pdev->aer_report->ratelimit.burst / 2);	\
> +}									\
> +									\
> +	static ssize_t							\
> +	name##_store(struct device *dev, struct device_attribute *attr,	\
> +		     const char *buf, size_t count)			\
> +{									\
> +	struct pci_dev *pdev = to_pci_dev(dev);				\
> +	int burst;							\
> +									\
> +	if (kstrtoint(buf, 0, &burst) < 0)				\
> +		return -EINVAL;						\
> +									\
> +	pdev->aer_report->ratelimit.burst = burst * 2;			\
> +	return count;							\
> +}									\
> +static DEVICE_ATTR_RW(name)
> +
> +aer_ratelimit_burst_attr(ratelimit_in_5secs_cor_log, cor_log_ratelimit);
> +aer_ratelimit_burst_attr(ratelimit_in_5secs_uncor_log, uncor_log_ratelimit);
> +
> +static struct attribute *aer_attrs[] = {
> +	&dev_attr_ratelimit_log_enable.attr,
> +	&dev_attr_ratelimit_in_5secs_cor_log.attr,
> +	&dev_attr_ratelimit_in_5secs_uncor_log.attr,
> +	NULL
> +};
> +
> +static umode_t aer_attrs_are_visible(struct kobject *kobj,
> +				     struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (!pdev->aer_report)
> +		return 0;
> +	return a->mode;
> +}
> +
> +const struct attribute_group aer_attr_group = {
> +	.name = "aer",
> +	.attrs = aer_attrs,
> +	.is_visible = aer_attrs_are_visible,
> +};
> +
>   void pci_dev_aer_stats_incr(struct pci_dev *pdev, struct aer_err_info *info)
>   {
>   	unsigned long status = info->status & ~info->mask;


