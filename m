Return-Path: <linux-pci+bounces-19950-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC4FA13786
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 11:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE74A163F39
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 10:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4CC1A0731;
	Thu, 16 Jan 2025 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aeq/ocav";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QYVdlyfi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EFA1DDA35
	for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 10:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737022333; cv=fail; b=O/RpJrWzVB8V16zmUUBSc3sdbQHv7f428Y2D7DR3NryBO0huwMPt5eTEOh5kAuEMvlK8QqFf8BSB+Pz2GOcaCRebTtRWdv8LCCkqzMayz/4OEbMtetANDLZU1QRvavjr/6lsTUrHAJOH3fSgpCqce7Gc9XUJ1oWd5YIPrHWhWiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737022333; c=relaxed/simple;
	bh=IEjD2UacCe6pznSTWv6EJrX4IooZk6/agMqoMqpE/Qc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AoqMHiU9X4JXid1lDlZTw+BPJxvAW424Nggng8gPj3mipUtqxqNRCUxMBbluSLJ+0iCCcFUJkDu7Mlp3Elixa7xmvDZz68YYhJwzwGpL7FgUd6h4iNDWTvPLfuAmXN+RaNWUA3RAyj05hsR3hBubFhuR1WFqdkK96R0q9V5PwV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aeq/ocav; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QYVdlyfi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50G9Mtlj028837;
	Thu, 16 Jan 2025 10:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=CIH1gye6XCLdYqbnna+vtIT5GHBneIeuAk9HolxM5ns=; b=
	aeq/ocavaUZ/OyPvguiqaR+897kIT2mSjmXptL13IJ6wRHp7yuMX+4WnsWW19/pL
	guBJMYD8f9y3DdFVDPcx3zzuVbXNyotx/EleAbwUc1wfScp5ZZ5rd2OBTOY1KIXu
	zou/NmRDnMaUHH4oVw1+KcbQEEWS50oWiwU75yWP/5DcBd1KuPhwT4YIxkd16nTK
	7askyvJPiId9Zz8BzavDS10oBQ71Wm8CuwE/uJIm/c0SONC9eJEiD2FtYjhW3xcU
	JSXDRemThyxk+5tsqIg3LjuMou/obCgXVg23HU6PoI0iJX/3YqRLKOLdu8uu+apt
	/0l/iuzXQQfDDfojE0x70w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443gpct5w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 10:12:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50G99fft037156;
	Thu, 16 Jan 2025 10:12:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 443f3b5xjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 10:12:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPBbWEW8lFT1kj5rjwTQIA6mBDdiAFcHPmU4cUN4xxYDbinDJ3p3+JKCf+vDcMF4WOpb5CVi/zg6ehppYNk1HHT8YrACv2Od8JPsDNV0t9COw+C1TbzMNWbRfdGyFB7qXTGC0bgcjk1oBw6p8H3b/kOSPz4z9qzZXhb1Wl7GqYQO7c6uJYk+yrqHIyBHxknAN0ruOPjBcAfmWAiNa8hmEyPhy+ifEKwPSNRoVRNgkHSdz2vzXEfVBt1EkLDB+yncCJ5hH452ZaqmKa6PwZ/ErTZcP8msCNdvjHCo6ugiCv20/KXICyS07kuFT7tZRSnZZCZ5n15GYQXGyE0fpeGWFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIH1gye6XCLdYqbnna+vtIT5GHBneIeuAk9HolxM5ns=;
 b=NFIu+WfmaSkq861LRjwZHOSA6z37jfVzsXoY7lUsDJT4qDC+70OwNS5134oaY6hBva9OKRzm1rrHTqNPdeOWI1tmIOfnXzPNkgAEYfzw4x4bOYaOfv34S2fTxdKITl/jeOwRew/56/UyTPp3soM1ZRipRjSx5TvUsR6fLTC6TDdlorAPOW1zrAAbrHAi+GBciPNP5l4i2WsvoryEWkcx8ZvBaILByMmPbKKDPDgKXmp4IEboaHR38EaNxaDKwHUlEtQVzWLDstdvhJ2vZ6uGfP1mP0ITF8U3B48ORXVxKncNipkhRCqJhNuIHiuhMdZvWHTgYjWYHrM0zNDOEDK5hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIH1gye6XCLdYqbnna+vtIT5GHBneIeuAk9HolxM5ns=;
 b=QYVdlyfijqUGwYeaCcXYr31z+6FqFmvXAC2mnxPCHXL86JZnbsTYi4icPiew6nL147zB/f1nza2FyypF7mDAKX68rD794fXaz9/mvOrCYjTrtTcZrMOksCl/PW5PKgtIndgOj9mCZOZcmF+NOVcCV7SAhw5vf8Dc6lVvcCQlqgM=
Received: from SJ0PR10MB5407.namprd10.prod.outlook.com (2603:10b6:a03:302::7)
 by CY8PR10MB6516.namprd10.prod.outlook.com (2603:10b6:930:5c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 10:12:02 +0000
Received: from SJ0PR10MB5407.namprd10.prod.outlook.com
 ([fe80::7503:9552:fdde:7d4a]) by SJ0PR10MB5407.namprd10.prod.outlook.com
 ([fe80::7503:9552:fdde:7d4a%4]) with mapi id 15.20.8314.015; Thu, 16 Jan 2025
 10:12:02 +0000
Message-ID: <b04d2fc4-6b64-4d44-9af1-31e05918e196@oracle.com>
Date: Thu, 16 Jan 2025 11:11:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] PCI/AER: Rename struct aer_stats to aer_info
To: Jon Pan-Doh <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>,
        Drew Walton <drewwalton@microsoft.com>,
        Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>
References: <20250115074301.3514927-1-pandoh@google.com>
 <20250115074301.3514927-4-pandoh@google.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250115074301.3514927-4-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0089.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::22) To SJ0PR10MB5407.namprd10.prod.outlook.com
 (2603:10b6:a03:302::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5407:EE_|CY8PR10MB6516:EE_
X-MS-Office365-Filtering-Correlation-Id: 763d0df6-1a33-4c8c-ea36-08dd36163841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlFlUklNbWdMVVVXNkxnRTBEeEt0aHJ0bXBPeExBTkpNMXNEUkorYytKWGlN?=
 =?utf-8?B?aS93VkRzZnBuYUg2dno3ZDZqV3RzVVdSbXZ5LzJ4dUtUS1JpcTNEQTNBL3d4?=
 =?utf-8?B?NWRTK2l3VzJvZUZROGlyNkZmaVlidkFpUmlPS1loM1A2U2xWOEJ0R0JzZ2xu?=
 =?utf-8?B?dU4rOVZwNCtpNnM3OGkwZDl5VE00bzAyQ2JZbDR4eGFZc1lHdkIrUmJWSURY?=
 =?utf-8?B?YTBubCt4MlVLRmhTRE9kc0dCOWhuNkh3K3NGL2ZSNE1OYWNRNXp6QXN4UGZK?=
 =?utf-8?B?K3Z3WGRITjUybkRua0IwWnhCSHE0Vk9uek0xZ1BaMjlCaVpNKzFrR1RUY1Ra?=
 =?utf-8?B?TkM2bkRWd1JMY0NydDhud2lLYURISjB6WnZyMlludE1NWlE1NklxRVkybmxv?=
 =?utf-8?B?OFE2OHN0T21RaGZJREpHQ2t1enNKbTNlVituR2RQN2FqZVBvOGNPV2pZUGZt?=
 =?utf-8?B?TXNtZ0hOVUl3UzRIS2E3cWZ2UXBNRjJwV3dOcWZwUlFlTDNzc3JYVGx3MUhu?=
 =?utf-8?B?MkVpaDNNblpvd1dmU0tpSVVienZtdEwvbndCcWhicHkvNWJnVzVyYlQ0VUpp?=
 =?utf-8?B?S3RQWDJqRDQzak1oVFdTRkxmNEtMYVZDWkl2ZVFKb3FwMkdnOVRvU1Z3bnlu?=
 =?utf-8?B?MjdkMVhnWGJhN2dkblVUa0Q2Z0p1VTkwSTRpTG43L3pEMGh5T0diSlg5U3pI?=
 =?utf-8?B?QTMrRVlNODNIY1VQY2w1UHJ0SW5mZHp5T051TUIyL3h1WUdsWlZqTCtxV2g5?=
 =?utf-8?B?NkVjWGhHOXVEdk05WFM5azc2NDM2QmRyRTQrSjM0QjExaGpQMnkxUjdGTnpF?=
 =?utf-8?B?U1pHK2hJcUE4YjFjVTZsTlJ5NGF2VmFwNFJkU1VyeHZIQTJsWlNkMTIrZ2dG?=
 =?utf-8?B?NkFQZnV0Ri9QVUZKNTJpZnlBOW1lVldDODB6K3BJSVgwS2N5RFA1MUU2YWxY?=
 =?utf-8?B?TEFueFo0elhwUHl5aXdwRkZ0L0hpTFYrTEdrWWdHVEtnSElVc1ZIZzBPWUVE?=
 =?utf-8?B?dzZkYmRaZm4rays3UURBZWpEN2JzdXNCV0Y4STZEQm5JZWpGS0Y5UHg4Qmtz?=
 =?utf-8?B?dWlaaXNHOTZtNVh3UTR6bzdUcUlTQU9ydUxROFNvSjhLN2NOQTF2K3lrRGlp?=
 =?utf-8?B?bXNiTFloaVVTMHNOZm5hQ0dSTWpWSDByTlRyVDU0QWV4QkFORHhwcFZlcXc2?=
 =?utf-8?B?SHBJL3VaMVY0anhUa1VLM24wSUIzQkljdnR0SEJZSUVjUFBKWEdESU9ZclBT?=
 =?utf-8?B?N1pkc3F1Z3VTQS8yc1BjOWNCZXhOZHpWc3FFcHVGdmFZbHNVdWQxSzkwcHBV?=
 =?utf-8?B?THlqRU9lQmU5akJydThmRzJjZ2VGTU1ZUnFHc3RDd3NyMjB5ZkEwMWRaQklp?=
 =?utf-8?B?eThlM0tBT0cvcFJvdnRjU21zL1ZBMlIxTE1MZ2hoMklyOVZKYngybk9GN0FF?=
 =?utf-8?B?QkNENUc1YTNlb3VkKzZJRmZtRng5Q3FzVnBOVWRkWmdkWGhxRzgrVG5JeTgw?=
 =?utf-8?B?WjUwOUswWDZNa1ByNlVVdklyRzZSUVVZMExGYmp5UTlXVVdEaWNkeDFVTWNa?=
 =?utf-8?B?TC9sbmxGL0pwdzI0Rk9lbEJCMjZQM0Y0TmtWTjhiK1NrSFgwS21zZ1A4V1Rm?=
 =?utf-8?B?NjRUVzFGZHZESll5aVM5WitWWFZZdmhqWnZZcHhrYnNNNG1aSlBZQUJaRjVS?=
 =?utf-8?B?RDlOSHQwU2pmMVdWSVVqQ3NWSC9HSjlBRElaVHZveXR2dDVlQndRbHZGcEs4?=
 =?utf-8?B?R3ZhRm9tWFd6elFrYTlNVFJ3UFVNYjRVQXBQTGhFQW9xeE1ZQnlDWGNJbytm?=
 =?utf-8?B?T1YzanNBVCtFYUlweVRWamZWaUxQVC9CSUpPSUdCTzllSFpoUVBWWk1DWTZE?=
 =?utf-8?Q?eKliZAiSI22sF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5407.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXlhYUdncFhzSHk0elE4cGpaSnBxWDJHYUJxYWpiRURwMUJtbm9CVVVxMloz?=
 =?utf-8?B?Ri94WEdGdCtOeTlIcE5QV3B5UzlLcXpJcEpPNE9Ld3BjUzF0MlVmMWphOU9S?=
 =?utf-8?B?aG10RVVMRGNaQ1ZQNHNCcVNyL2RvWG1VbGtmdk9kS2VYQWhhb3l0dUlxN1Jq?=
 =?utf-8?B?RUhaSDlSMFIrUVRjbWV6eG81bjJhN1E0SHRyQk55NTExZG9xZzJFREIvQytt?=
 =?utf-8?B?T3V5WEZlTzRoNFZGbXFPdDQvb3FWTG1uOE14M3prV3ZCRnl3Y2drQnpESnYz?=
 =?utf-8?B?TTJDa2NsNGUvRkZKS3NGVGhaWEdJamlhMFNoNUMwb3Y5QXdkR0hNS0h1R00v?=
 =?utf-8?B?ZmxOaW1pV3huK09CY2RDZU45aEdGUkxQVUpwaXlDTFBBSTcvMkk3RE5LZDZE?=
 =?utf-8?B?SG1hV2ZrSmhUWVFZdXEzcmpmblY3WU1TSzR5cFVPdk1YYStvV3N5UGVIbFBS?=
 =?utf-8?B?dUpwT0VER2pNcXZXcDdzR2VFenhHa3BLMUN3L2J6cSt3Wnd3QS9TdjdjNHk3?=
 =?utf-8?B?NjhMWFRpbnMxNEJxcEhBRFFxeGcxL3JOd2VXb2VNbkxqa01FbTBZQ2RNRGxo?=
 =?utf-8?B?bU9pTEJKRkxGVndjc1dzQm9NTkVaNEs3NTVBQVQwTVBEVk5sN1FkVjl6c0Mx?=
 =?utf-8?B?T1lsM1QwM2xqYjhiL0RaSElDVTFFTVBTWG1RbWY2bVFtTGxxMFFMVEsyVlVm?=
 =?utf-8?B?ZXlwbzFkcDBEQjZuNUw5YmRZclJ4cWx2WUYyM2VHclpqSVdRZUtrYXJMZ1o3?=
 =?utf-8?B?eGV0UzlYZHEzZ3FRRTExVjJaTDg1ZFU1Qy9jTHdpTEcwWlpIYTV5L2JWOGIx?=
 =?utf-8?B?MTZyUXc1RG1QRGszL0Vubmc2OHRlV0FmeEJtVlZtWGUyMWdoRUJrcFp1VEkx?=
 =?utf-8?B?T3dqdFNjc3JPZTB3OXUxaFVqaCtURjJFbzRoeERXTE4xZGNyUzJVaTBpUTE5?=
 =?utf-8?B?L0owTnBzZlNrLzJlYlk0ZzRKZjRBenh2L2Izbko4WXhQVkxpVmdTN25iQnVV?=
 =?utf-8?B?YWNmeExBbGdjUFBnRko3cjhVNWxkSHVTeFhXOFJGWkk4Q0RmdTRRWFZ2eTkv?=
 =?utf-8?B?cjVLVVlBbVh0aGRPdDJHYU42R2NSSVNnQjdIdkwyUS9qd2tjbXpITHZkR0NH?=
 =?utf-8?B?QlN4eTlyenZTUVVxSXluakltZ0Q3TCt0bDZicVNicVhJbkk0UmZmMFV5Rlpj?=
 =?utf-8?B?cEREcUhVMmxVeHphYWhSMGxCRzYwYk9JdnFDak9IdXhrTXFPME4zUWx6YmtV?=
 =?utf-8?B?T1Q2ckFRRTBoWW5SckFHaXI4LzYwVzB4ZWFWUzNFVFd5aVRueDZhU1ZiMjBT?=
 =?utf-8?B?SUNFRXpUcEFmWnVQTXk2U3Eya2tLbzVsMzE2YU5vL1p0OHB4aDZvUE1oS096?=
 =?utf-8?B?Mk5PeXI2cXJwRkpYRjlkNVJVY0I5WWtkRUxQY1hVUEZkbHo4bFBXQ1dRUFox?=
 =?utf-8?B?T1NYbVhBbnBENkJnL0Ura2xuMHFiMzNVY21UWTNHemJ6eTdIbitjQWdjbWtH?=
 =?utf-8?B?cGtIVHhWNEs4Nzh6VkR6TmwzeTNlQjVoaUw5dzFxY1RsbVhKcFpvZlRxdkpY?=
 =?utf-8?B?WmEwNFJ4MGdXVHI0cCtyT1BjbmczL0dJODdSMkt1T3UyUzhqbkE5c21VUHBK?=
 =?utf-8?B?QlVwdm9WM2ZZU2pjUXZTMitUV0Y3UFlzd3VFMHdCSGxUaS9lZ21iL1NzVHZx?=
 =?utf-8?B?UU5MQ1hicjcweGw4REdGWFJXdWFWVFQvaGpaTGpXNzAzWFVsVlRWWUJqRlRU?=
 =?utf-8?B?UUg3YkRjYVF0VWtrRDU4UDVhNjhqYmp4T2Z0UERNRVBsdjhid2UvUUhMa0Nq?=
 =?utf-8?B?NERtSGNZdXk2a2QwYURSeG54bmc1ZlZQVm9YUjZSQlJtSVhHZTJJZk1qY3B5?=
 =?utf-8?B?T1o3YTljV09aUWVBSHY5dFBWQzFJTzJPQ3c5M2VvM0ZKWHlZNEpOQnNqa2ww?=
 =?utf-8?B?TERCSDVlcjdOcCtPSW5XZ0svN0R6dVluemFIeloyWnlhZXcxUjMrYWNvYnhR?=
 =?utf-8?B?NjNTTkdRQzY2eXN0RHV4RWpYcVV3QWhReHdQN0lVOVNsR3N6c29BNEJRbUtS?=
 =?utf-8?B?dHVQZWxQckg1RThQcG9QcllVbFFUMjUyaFM2eHJndWlwb1BVc2pFUTdkVS9G?=
 =?utf-8?B?OUsyUnU3VWZJczEwREcrYnBUVC9zYXpQcERMK0c2RldJN2VRQXc5d2hCU0h1?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d1ih17HKjHV4pxmSsJkKefEhlRK2TtIWJ+001agLmYZtG3z44xl6Y8cfGfcTUQLfeQXkyhaQ/2UI1Z5rMAJE51SOflkreDYd2kreuBEd7DZpsAjYPR6oP6ccjxtwJtdU/P/qohnOr+rc++DrsXoQmHmwsvu0R8bxGP0XqfZpfE3NMO+pqEu+OuMZW0yDACMrj5TqFe4AsahKACOZn/TOtc1+lqS4Ds1CKVVolJqS4Uo+u+/KRQbkQSxfNTlBiCom1QX5w1vtQHAQMCfT4hIyfOPEiZEa6JXmctk7c37HIk1xeNCX9ZeT7N9MXxtVV8bWttIwpM1N9b8DW+jv778VaHwFXWMtKk1jaNUaICIxaVPgCFtyxSP+b284YcmPIvNIc7JD64e8e1Q3dsmjgDDhTyOg8X1G5ivn2BMrfyb+yOTGodI4eKmceOOgD82nmPKjllnurHe98wSRLOoufeCkjy/sBQRPBzqpLUXTH8s3l4HUvt3SXhkTILu2kAgI4JCnefZwqfq2BZs/TRBwvkhc6y7u3iNM2ZTO44MPDrXwDQdXH6clb+9qREIKwq+lePM6keNMvek9K2AqxEW36HmQCuTm+q0wWtsP00WncbuCZes=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763d0df6-1a33-4c8c-ea36-08dd36163841
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5407.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 10:12:02.0849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RzCmoplWl0VZAuZGdmB0tHgSmqhO/haxouhxirc/r/9WtkTS98PETTQMwffOEZ2Gps4VrBOiLDde3EkAwxTa7iy394hMSsqM8Gq4A6AzIVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6516
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_04,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501160075
X-Proofpoint-GUID: 08CQItRoECaMUhCeWY0c2pDe1z0scCzA
X-Proofpoint-ORIG-GUID: 08CQItRoECaMUhCeWY0c2pDe1z0scCzA

On 15/01/2025 08:42, Jon Pan-Doh wrote:
> Update name to reflect the broader definition of structs/variables that
> are stored (e.g. ratelimits).

I understand the intention behind this change, but I'm not fully 
convinced if we should mix AER error attributes with the tools to 
control error reporting/generation (ratelimits). I'd argue that 
"aer_info" name still doesn't express what the structure does.

aer_stats sits in pci_dev, so I can see why you decided to use it; it's 
one of the few available places where we could keep a stateful ratelimit.

How about creating a struct to keep all the ratelimits in one place and 
embedding that in the pci_dev?

All the best,
Karolina

> 
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> ---
>   drivers/pci/pcie/aer.c | 50 +++++++++++++++++++++---------------------
>   include/linux/pci.h    |  2 +-
>   2 files changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 4bb0b3840402..5ab5cd7368bc 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -50,11 +50,11 @@ struct aer_rpc {
>   	DECLARE_KFIFO(aer_fifo, struct aer_err_source, AER_ERROR_SOURCES_MAX);
>   };
>   
> -/* AER stats for the device */
> -struct aer_stats {
> +/* AER info for the device */
> +struct aer_info {
>   
>   	/*
> -	 * Fields for all AER capable devices. They indicate the errors
> +	 * Stats for all AER capable devices. They indicate the errors
>   	 * "as seen by this device". Note that this may mean that if an
>   	 * end point is causing problems, the AER counters may increment
>   	 * at its link partner (e.g. root port) because the errors will be
> @@ -76,7 +76,7 @@ struct aer_stats {
>   	u64 dev_total_nonfatal_errs;
>   
>   	/*
> -	 * Fields for Root ports & root complex event collectors only, these
> +	 * Stats for Root ports & root complex event collectors only, these
>   	 * indicate the total number of ERR_COR, ERR_FATAL, and ERR_NONFATAL
>   	 * messages received by the root port / event collector, INCLUDING the
>   	 * ones that are generated internally (by the rootport itself)
> @@ -373,7 +373,7 @@ void pci_aer_init(struct pci_dev *dev)
>   	if (!dev->aer_cap)
>   		return;
>   
> -	dev->aer_stats = kzalloc(sizeof(struct aer_stats), GFP_KERNEL);
> +	dev->aer_info = kzalloc(sizeof(struct aer_info), GFP_KERNEL);
>   
>   	/*
>   	 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
> @@ -394,8 +394,8 @@ void pci_aer_init(struct pci_dev *dev)
>   
>   void pci_aer_exit(struct pci_dev *dev)
>   {
> -	kfree(dev->aer_stats);
> -	dev->aer_stats = NULL;
> +	kfree(dev->aer_info);
> +	dev->aer_info = NULL;
>   }
>   
>   #define AER_AGENT_RECEIVER		0
> @@ -533,10 +533,10 @@ static const char *aer_agent_string[] = {
>   {									\
>   	unsigned int i;							\
>   	struct pci_dev *pdev = to_pci_dev(dev);				\
> -	u64 *stats = pdev->aer_stats->stats_array;			\
> +	u64 *stats = pdev->aer_info->stats_array;			\
>   	size_t len = 0;							\
>   									\
> -	for (i = 0; i < ARRAY_SIZE(pdev->aer_stats->stats_array); i++) {\
> +	for (i = 0; i < ARRAY_SIZE(pdev->aer_info->stats_array); i++) {\
>   		if (strings_array[i])					\
>   			len += sysfs_emit_at(buf, len, "%s %llu\n",	\
>   					     strings_array[i],		\
> @@ -547,7 +547,7 @@ static const char *aer_agent_string[] = {
>   					     i, stats[i]);		\
>   	}								\
>   	len += sysfs_emit_at(buf, len, "TOTAL_%s %llu\n", total_string,	\
> -			     pdev->aer_stats->total_field);		\
> +			     pdev->aer_info->total_field);		\
>   	return len;							\
>   }									\
>   static DEVICE_ATTR_RO(name)
> @@ -568,7 +568,7 @@ aer_stats_dev_attr(aer_dev_nonfatal, dev_nonfatal_errs,
>   		     char *buf)						\
>   {									\
>   	struct pci_dev *pdev = to_pci_dev(dev);				\
> -	return sysfs_emit(buf, "%llu\n", pdev->aer_stats->field);	\
> +	return sysfs_emit(buf, "%llu\n", pdev->aer_info->field);	\
>   }									\
>   static DEVICE_ATTR_RO(name)
>   
> @@ -595,7 +595,7 @@ static umode_t aer_stats_attrs_are_visible(struct kobject *kobj,
>   	struct device *dev = kobj_to_dev(kobj);
>   	struct pci_dev *pdev = to_pci_dev(dev);
>   
> -	if (!pdev->aer_stats)
> +	if (!pdev->aer_info)
>   		return 0;
>   
>   	if ((a == &dev_attr_aer_rootport_total_err_cor.attr ||
> @@ -619,25 +619,25 @@ static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
>   	unsigned long status = info->status & ~info->mask;
>   	int i, max = -1;
>   	u64 *counter = NULL;
> -	struct aer_stats *aer_stats = pdev->aer_stats;
> +	struct aer_info *aer_info = pdev->aer_info;
>   
> -	if (!aer_stats)
> +	if (!aer_info)
>   		return;
>   
>   	switch (info->severity) {
>   	case AER_CORRECTABLE:
> -		aer_stats->dev_total_cor_errs++;
> -		counter = &aer_stats->dev_cor_errs[0];
> +		aer_info->dev_total_cor_errs++;
> +		counter = &aer_info->dev_cor_errs[0];
>   		max = AER_MAX_TYPEOF_COR_ERRS;
>   		break;
>   	case AER_NONFATAL:
> -		aer_stats->dev_total_nonfatal_errs++;
> -		counter = &aer_stats->dev_nonfatal_errs[0];
> +		aer_info->dev_total_nonfatal_errs++;
> +		counter = &aer_info->dev_nonfatal_errs[0];
>   		max = AER_MAX_TYPEOF_UNCOR_ERRS;
>   		break;
>   	case AER_FATAL:
> -		aer_stats->dev_total_fatal_errs++;
> -		counter = &aer_stats->dev_fatal_errs[0];
> +		aer_info->dev_total_fatal_errs++;
> +		counter = &aer_info->dev_fatal_errs[0];
>   		max = AER_MAX_TYPEOF_UNCOR_ERRS;
>   		break;
>   	}
> @@ -649,19 +649,19 @@ static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
>   static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
>   				 struct aer_err_source *e_src)
>   {
> -	struct aer_stats *aer_stats = pdev->aer_stats;
> +	struct aer_info *aer_info = pdev->aer_info;
>   
> -	if (!aer_stats)
> +	if (!aer_info)
>   		return;
>   
>   	if (e_src->status & PCI_ERR_ROOT_COR_RCV)
> -		aer_stats->rootport_total_cor_errs++;
> +		aer_info->rootport_total_cor_errs++;
>   
>   	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
>   		if (e_src->status & PCI_ERR_ROOT_FATAL_RCV)
> -			aer_stats->rootport_total_fatal_errs++;
> +			aer_info->rootport_total_fatal_errs++;
>   		else
> -			aer_stats->rootport_total_nonfatal_errs++;
> +			aer_info->rootport_total_nonfatal_errs++;
>   	}
>   }
>   
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index db9b47ce3eef..72e6f5560164 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -346,7 +346,7 @@ struct pci_dev {
>   	u8		hdr_type;	/* PCI header type (`multi' flag masked out) */
>   #ifdef CONFIG_PCIEAER
>   	u16		aer_cap;	/* AER capability offset */
> -	struct aer_stats *aer_stats;	/* AER stats for this device */
> +	struct aer_info *aer_info;	/* AER info for this device */
>   #endif
>   #ifdef CONFIG_PCIEPORTBUS
>   	struct rcec_ea	*rcec_ea;	/* RCEC cached endpoint association */


