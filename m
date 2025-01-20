Return-Path: <linux-pci+bounces-20134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 882B3A16A9C
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 11:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E86B57A4A77
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 10:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D589419DF4A;
	Mon, 20 Jan 2025 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hx4aStPF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Upzi9HTi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72621531F2
	for <linux-pci@vger.kernel.org>; Mon, 20 Jan 2025 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737368011; cv=fail; b=LxlEhPDIywZqcLEUgw44Au7qVYdVyXbtQfBTmq5bq2w8l6zBPfQDnG/A92oJxv7KGk37OnSbsSNRfXzu+PjChuXUeDPENelUXcJoOtQI5STbSf+X5gGQygKHiEH3eC7vT5DK1YwBKpM7s9h4SFWXywkRpMQzPT7IzI2gA4roCcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737368011; c=relaxed/simple;
	bh=ed8edE4Fhj2QCEjd5qLsvOS1bypQHOWT3uKX7Sqcjuo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jnl34VE1/Iq5i2JaXomvy0gE0Uv1mx98wCzDZ9kD4IySKeUuE0AS/cKfqpTZhPVF9dzmybHTvG1R2+Q/zZgmbK40ue++ST0H2Shw7uXxbvh4760RGF4oE06n1MQrTPr44hF7/a/deGfNJPIttut0mkTfD+zlOi5sWdcGnHaclAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hx4aStPF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Upzi9HTi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50K7fuvq006638;
	Mon, 20 Jan 2025 10:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=9mU1J8D2flLvji1oa4g0yL7l0IM37JXrWwPeN/OMuDo=; b=
	hx4aStPFQLpq8ndh51C8L73as0KFxoP9mwzwooVxYPtYTMHgcvV85HWYWwg/vNxI
	1lFQHjP+dwo17GBnMtRQ1j8tO3zRXAb7rtnThX8eSKZBfEuzhxKBMvVVQh5Jd5Br
	NVt+CBDwjGT2yFIKKSfBEnrF3RXFLKboVjUxCmDqmvm38cY7Vhr+QCbuNsbHYwIL
	jMwgGg3BTMm1s1P5U66J+rTWQ2dCiNoJEcHRcJgMI6wkzWIaM6dw/GjzNhoJf9Xg
	MlfN2PC+C/Yw/veUqj3OMEho/bJhf7Yuogs3KDJ5sn+vT15urpJS7+xCwKPl+Lbe
	dz/Ff64GRQpKXgwxVL5qug==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485qkubhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 10:13:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50K9Evpi038012;
	Mon, 20 Jan 2025 10:13:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44919xpnms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 10:13:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+36IoC798XxbEaEClWx/8rX7RDOulboYl8bdZFFxXMCrGxrfoSxj+u5jhSIP7Zp94bITHrHheFFTolMkUFZW9hTkhel+WICg8tiiheFWmL4FQWrcJuO+mmnNWmFXP1iO+sQq5LlNvBxNgDAA3NLjtV7wPJbNojpIGo6VHvgrVB9b2U/iw42L8ac8UssY7OBZu/jOxMP+MlkGI6BH9/TDVD3thkSXP8LbMbPwqmj7xhbPZhYxsa33QE0ueCsLEDXm/+tb64Gi99XP81t4QxZcRIiqiG+nTgnb/xsuP1zHk+URHjNSrqSRrMHCtJJ5FJTW7yyvR5NlYv+UN5tDYkfUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mU1J8D2flLvji1oa4g0yL7l0IM37JXrWwPeN/OMuDo=;
 b=nVId011ShJoPkYcFxieE/0YPNCD11EwTz4Zv7e2Bs3MvXNQfsa4hgPXIfIQRPm9wWtGTckg2uw4GzsQ8p2DT+kCp7FM/ZLSq8mxJlQiBRL5LG01aJH3Ec8UvNX8e5nB8fSwEn6FltYHMF/GY/D1ErqUWczKlkZLj35aHlafqtT52YaUNl0xTm6r9rAOu1LwZmfcIU5VeHc0/zn8XxL29cE2cOeuTgaemLoWs+Xy5zB5nfZKYegYU0BJ9BKYy5ssLjE4gXST2bQajR/SaV0VXEyc7PS0NwrJXJEQtS5AxY7tcH9f7AwK5elyHYluKdFVtHGrklGH//tuDQgmQFNIiWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mU1J8D2flLvji1oa4g0yL7l0IM37JXrWwPeN/OMuDo=;
 b=Upzi9HTiBmHuD24LAghOHmnleBOfqKBYKEQ7S2i9UhX1khELFNJyC1PC2bufas31o4230D+ee0fR47lrAavQBQWGp6kHBSGLe2Sr8Yy7lxSABsdhz9MGzgYH9TA+lf+rTcHu9D+juSyaLA7wDC78bue35CwznzdwUbYYGpd1Fc4=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by CO1PR10MB4482.namprd10.prod.outlook.com (2603:10b6:303:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 10:13:18 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 10:13:18 +0000
Message-ID: <12d24891-c32e-4a84-a6ee-4501106a6957@oracle.com>
Date: Mon, 20 Jan 2025 11:13:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] PCI/AER: Rename struct aer_stats to aer_info
To: Jon Pan-Doh <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>,
        Drew Walton <drewwalton@microsoft.com>,
        Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>
References: <20250115074301.3514927-1-pandoh@google.com>
 <20250115074301.3514927-4-pandoh@google.com>
 <b04d2fc4-6b64-4d44-9af1-31e05918e196@oracle.com>
 <CAMC_AXUKSSYjRr39E-DehvpfH=b2eYksVwPVZ9BXSNMSU5bUrw@mail.gmail.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAMC_AXUKSSYjRr39E-DehvpfH=b2eYksVwPVZ9BXSNMSU5bUrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0420.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::11) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|CO1PR10MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: 8efbb9e7-5320-4097-9dfe-08dd393b0f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTBlSkV2VGNYV3VlQk15a21PMmxtRVBLdnErZExuRURENHlGVXVMR0p2QTRy?=
 =?utf-8?B?d292a2R5MDVwRWs0NnFYU0tRWVAwd2cweGtBcEI5QzhweTF0eGxvenVsWjZX?=
 =?utf-8?B?WGU2Q3VpQ25TaEdYUm5FaGdNVlRxWWFBWEk0eE4vWHk3cHQ3UmNXaU91eW8w?=
 =?utf-8?B?ViszaW9jdlVGaHBCZTlCeFlaZUovVEMza3VZTStZRnlEYndkRlQ4WmI5Y2dp?=
 =?utf-8?B?QVducWRJVFNmM3NLa0pINFl6OTNBby81WktjTW9qN1RxS3FpQTFWeTduWjRC?=
 =?utf-8?B?WHlKRTZ3enlSSlB0aUNvbDhZdzF5UTBlRWtSVFRmck5YRDZNbiswRTdkSGM0?=
 =?utf-8?B?TjU5N3FHdklnb3RMclp4OUdiMTFzN2dZWnFadUk0K2llUng0aWFRL281R0dZ?=
 =?utf-8?B?ZlNTNnUyRzZrQlovQWUvelJIZEtDdTUvd012WkV0SVNGTlhJSWFQZU13UVhx?=
 =?utf-8?B?SU5MR2s1M09hL09YSWJOYm0wUTNkWmtPQkNKVGtsYlJIQThMZDJyQ0psZkp4?=
 =?utf-8?B?elV5YVVvL0Z0YVlNZjVOQURxRm1ldVVkZEZ2bmJtbi90WkJWZFJCZkNhM2lI?=
 =?utf-8?B?MDZHTHhTSzFwdDJxZFRBWmdQajBUUlZJam5oOXN5QU84Y01jSTlDVnhIZE5Q?=
 =?utf-8?B?TlM1aW9MODIyaVVGMk1aTHRnNVdxd241SmIvVmVvMlhMOEJTSFprWTN5SDly?=
 =?utf-8?B?Z2VXYU9EQ3prNW51ZFFEYUFuSHA0RHJLOTBVTW45TC82UHJtcklTQmo2L0la?=
 =?utf-8?B?dW4ySzFhVktJa05abGloK05nVDh3QUlVeXA2cThGRTkrb2J5UXRSRlVPcHQ1?=
 =?utf-8?B?cVREMGRNZW5FeTljdllWZjNUTHl1ei9ZY2ZDSUF1dmxLWlVyd2k1UWdFb2Ex?=
 =?utf-8?B?cUtYOTc1aHJab0xOWWZ0RjNmTVEySzVCUnlMaUxpS0lTR2ZzRFdMc1paQUdX?=
 =?utf-8?B?eWNKN0hTaWRPVitXVG12dDluUGtuYkZHVCsrQ3FnWkNJb3BhV2ZVMThqekZm?=
 =?utf-8?B?LzJPT0dZN3hyMzJKcmpWbUN4VnJBRlI1dFEybjJpV2sxOWN4azNLNS9qTUJN?=
 =?utf-8?B?aFhxdHJEaFZVYjRXdGNvN0NhY1ZlMkNQSWZia1RYdDFKclp3ZTFUL3lCejV3?=
 =?utf-8?B?enVNU3F3a1ZWREJVQ3Z5Z2dySU0zUlFrUmkwcXpGODJqekRpZlF0TEJnYzNz?=
 =?utf-8?B?TllISWx0cmo3T00wSVN4SytjVjhJcmdPTzJ2RUo2NDNyNGV6UmowMGswb0lj?=
 =?utf-8?B?ZHNZSklYMGVKVXRQeVRzakpvcU9nU0FxTjc2SCtCRFdvOTErQm1FNmV0UmFt?=
 =?utf-8?B?UkNiaVkrV2d0V24zRjMxdmFWS1VIeHJHbDBWa0dIZzF0Zkpkb3M4QXRVeXBo?=
 =?utf-8?B?aUw1bHlqVmt1bkh2RjBmSnFTcTlTVzljSC9UNmJOUGZPdWNEYlN0NXFaRUZ3?=
 =?utf-8?B?WGNFMmdCN0thVnh2aE5OS0lVcGE0S2FZVjF3QVlkU3RCZEoxQXpWNC8vVjVM?=
 =?utf-8?B?WVRrY1cvVDJGdDIxOWVYdFJRbTg4QldDU3B2YUN4N2E1b1lpUTJyRU85eVAy?=
 =?utf-8?B?Y3htVjA5U3RZeXBMU1ZZNDh5WUx6U0JEaVRWNmxldjQ4dDd6SjNQV1R1TERq?=
 =?utf-8?B?L1dhaExLYWduMXNCMUZ1aG1FcFE4Z3o2QitVc0FVVW5xM2xVREFZUDcrbzU1?=
 =?utf-8?B?NUlQcDFTc3RFRXNWUFh3UVZxaVBxWndsa00rYm5OdStBSnI2STl5N1BFMjla?=
 =?utf-8?B?THp2NFdDOTVmWU1xdTlUd2ZxTE9sT3BndVBWWWF5amwrREhNWXE1VFlRVDVx?=
 =?utf-8?B?bUs4cjlsbDg1Wk5HQTRGQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjdubWF2Q2VxWXRRL2dSQzdOaXcvdFNQajBXMDRIYWVoZ3owWHdhenBHT0c2?=
 =?utf-8?B?L3FuRTFrTEt2blBxZW8rV21FY0ZWL0tqcWlrQ0tLWkF5RXFDOWFrVGZFSzhD?=
 =?utf-8?B?UXlaNEIyV1M0VHNlcnplVk1MNTFiMWNhaTE1Mm5maGlsc0s3eFBRSlRYbVU2?=
 =?utf-8?B?VWtLTk9QRmZRbmJzNmZMd3htemJocGsrZW4reGlnWSswU3BIVEZHcXV5dVdO?=
 =?utf-8?B?OGtTVy9ZMWwzTlUxOFBGYTRFZGxSOGxqcTY5RGtxbG1wcTM3aHhqc2g1eENv?=
 =?utf-8?B?TFIwaTZBNnJhNnRaL3g2YWY1aUN2MjNWVk1OMXRKY1RLMFJjMVBPNC83Zjl1?=
 =?utf-8?B?K2l2VG0xY2l3TEo4b1E2RUxPVE5QMXA3SVo4eVY2dnhWdVVyYXc2b0tXMWt5?=
 =?utf-8?B?MFhNRGlPeUIwN0hYdVA3TWJkb3hYdGltVDF3RCtsR2RMSFlnYzduV3RTdWM2?=
 =?utf-8?B?dElXdHdmNERnWlVuU2N2OFF4M2VpUWhXdmdQYjVXMmc0SHhiajVoaDJzN1l4?=
 =?utf-8?B?THArY0V2TGlHempRd0RJcFJkNEUwK2N3dTFST1hiT2lBWDNGZzNZdWczdTdH?=
 =?utf-8?B?Y2hsTUV5TkpGZmZBcWlJOGFaVTN1dzBxQUJTem1JeGczeDJMdk4wK1NSdGZz?=
 =?utf-8?B?N3FHYWtTd3FrUzFGY0JWdkJCTm1wMnNWdnZxS2t5MEo0RytZMVZZZkZ1MXlK?=
 =?utf-8?B?SnZsdVE5WW5ta01DckorU1FQQmFtRWs0RmNWMzU3dXEwemFpZHNUZnJ2VFJK?=
 =?utf-8?B?Sm1tNnB4UFp3SlNrVkhtcGhDc2ttL3N0SXRiaGJPbUtIQ2NBQmh3c280S1VJ?=
 =?utf-8?B?WFFQcFBrMkM4NHRwKzdEdGo1T05BMTlleTBYUDU5Z0FvbEhhQjFhazNIL1pt?=
 =?utf-8?B?cDVUR3kzdUo0RkpQWDFCTXpmQmFXV3RqblJWS2RxNk1jc2VvblJrWFlHT3dw?=
 =?utf-8?B?cVJrWWZyZlhlNjRNUTNRNzBoaXpaNDhMZThUNlc5dmRiOHlVM3VoRzBiakli?=
 =?utf-8?B?djNQNjhlSHVVTDgvRXdyb1ZqWG9KR0V1YUpWTnBpNHpabGxHck9lUzQzN3Bp?=
 =?utf-8?B?VmthNGRUZkhKZ2dzRGVaTnBSZVRORnNJSlRSd1FMdG9leE81MHBhVVlNWDcz?=
 =?utf-8?B?ZXdvSnp3Tmc4eUEyTlRzQ1pWcnphNkJhWUJtRkNzSDJuZDlFQ0x3eUc4NTI5?=
 =?utf-8?B?S1h4bFdObVVRT1FZVTNxbEx1NUhwMk9ueDdOWEpsemdyd2RkS0RxZDJVSkZQ?=
 =?utf-8?B?a0h4QTE3bHREUUFMejAzNXEvS2Rza3BaVEhJeVYzcXdZRzRLU05uNVd4ejhX?=
 =?utf-8?B?MmM0YmtHdnlBS2VBQ1QvbDJSbTQ1QjF6Z2lQczBpR2wwSmo5ZEpLVlNLdUFn?=
 =?utf-8?B?SXRwRzlKRW11dDhPakdZMXpzVzZ5WGgzZ2ZLZlB5aFYrVXJwMHFHNTRlekQw?=
 =?utf-8?B?cEhKT21sN3p6NGtXN3ZNVnBpNzVXcXFScUl2cGs5T01EQk1WSERNN3lBdlYv?=
 =?utf-8?B?WU5tSnU0RWU5MC9MMEQvTVdaSHpUK1BrWGlNdXJNQ0FucWRNZ253QnYzNlBm?=
 =?utf-8?B?YnNrYkw3emNRc29JbWljS1RGdFpxQWFRbjJtQ1p4S0VaaXVYZzJnak5naFdw?=
 =?utf-8?B?c3M4T0RsTkV2dG0xMWFqNnZ0cGVtdDg1aHZDUXJMeXlvaXlRUFJKbzREbnRv?=
 =?utf-8?B?bXgyZlMvNUYyRjJ2Y3U3VnBsbjdjaXNTWkQ1OXpTT1cwanc1UkdkMldmd2JS?=
 =?utf-8?B?SG9tWElhVi9mNENpUlUwNUZlMjI2VjNhQ3VPWlgzd3JwcWNYamtweW9mcjNV?=
 =?utf-8?B?SWs4QmdibElidWM0V0hET3FEYUhyakdKS1ZNK2FKRG94NFpjMm5mSTQ5MEZ4?=
 =?utf-8?B?TWlTMFJ1SzdBa1NTZE1PYlVnZWYzNVVtWVdkVWtqeE1qak5hc0ZBdXRZcUh2?=
 =?utf-8?B?bGJraEJZamRiTDFxZDJUeFlNTXBDb0w0ZzFTQXErdUZlWDZCcVppSlhwYWEr?=
 =?utf-8?B?Q2tENFBvZnZyaGFyZjdjSkV1S2pwdk9kNmU0aVptR2ZLalZUeSsxOGlFYm84?=
 =?utf-8?B?UzhRYWg3THRrWk1BU2lwNDh3ckFHbm5oeU9UV2F0blU4dUNYOVFrU2JSK3hV?=
 =?utf-8?B?NHU0bDZGaWVBVC9JbnQ1SlFLTlRad0JMNlNrN3IrY0JTOXBrWnYyQy9ibFMz?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RUY5yGCBx6f8ZooV+hys55nQSu1xbCUkvjW2sWx4b+xhuhK3WIzkVI30S4nMt7QgWprrXIcXKRqtpcf8qGL8+yLZDqvMn1uRqe5+QQ9mCOTbtULD/3lwy7lS0a+2QvyBY25F2Pek5ujo6dvEQWLVpf3dRtrsCenQmyEqnEFYD8pTkBmotIqfA0KeYd4XRdfQLjAwMnDSUJgBJMMyELxkmtM64XdT+hmDbDcUt4KTIo4VwbJ7+X6XkGK6GoNp/rh6Jd29vWuMRBTp3zInj+64579KzPX2YimUQUTUmcPxdM/2ngRZzooF9hM+77q7rE5dqGjZwzClSBtSu683nGJblLb+rAqIFbPxJ0kc6SYOuFziGFXDlM0//y8xcXvP03r9YXW3HFwZSQCWBvPpT0zPZ3vFa7BZYG/JqnjSrw9rnv3K8ueFepCyn6nC64we0tCCR/+elm8fWEO6FtcnCX5UlZq3ggO17CbaT44fjqsqhZBJNLpkB6ONF8eL9vKNs0mevnXlbuIfzc6Gb1vQerQ0RhR5X4dNNRbni0IOmfiHYr9sbqT9EIbBPPlwIETWnSxQqUCxzx6IIRTtNSIfHHT/7Yq5FWLQ3PER0/5KTZh7nso=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efbb9e7-5320-4097-9dfe-08dd393b0f9b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 10:13:18.7135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTEnHeiWncFOi4uegNl3ORVg20EcZzv66eqFgDoGEYydVOBe20mUYYmmyLTFJBFgfyiUayQzbgUsf64sVgHy39WmHp/yHkjhZ17poR/Z9Jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4482
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_02,2025-01-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501200085
X-Proofpoint-GUID: 2CLXFNEoKdpo_kQVZmSDdcpr4hhO5uCc
X-Proofpoint-ORIG-GUID: 2CLXFNEoKdpo_kQVZmSDdcpr4hhO5uCc

On 18/01/2025 02:59, Jon Pan-Doh wrote:
> 
> In a previous version, I had a separate struct aer_ratelimits in
> pci_dev (similar to your patch[1]):
> 
> @@ -346,7 +346,7 @@ struct pci_dev {
>          u8              hdr_type;       /* PCI header type (`multi'
> flag masked out) */
>   #ifdef CONFIG_PCIEAER
>          u16             aer_cap;        /* AER capability offset */
>          struct aer_stats *aer_stats;    /* AER stats for this device */
> +      struct aer_ratelimits *aer_ratelimits;      /* AER ratelimits
> for this device */
> 
> However, in an internal review, Bjorn said:
>> I don't think we need to burn two pointers here since we always populate both at the
>> same time. Perhaps combine the stats and ratelimits into a single "struct aer_info" or
>> similar.

I see, thanks for sharing it here.

My thinking is that it's preferable to have small and specialized 
structs, with one used for collecting/showing error info and the other 
to control the rates at which they are reported and generated. I'd 
propose a similar change to the one above.

> It seems like the preference is to minimize additional memory in
> pci_dev. Any suggestions for a more appropriate name than "aer_info"?

Like I said, my preference would be to leave aer_stats as it is, but if 
we have to stick to one struct, I'd go with "aer_control" or "aer_report".

All the best,
Karolina

> 
> Otherwise, is this a good enough justification to maintain two pointers Bjorn?
> 
> Thanks,
> Jon
> 
> [1] https://lore.kernel.org/linux-pci/68ef082c855b4e1d094dcfc9a861f43488b64922.1736341506.git.karolina.stolarek@oracle.com/#Z31include:linux:pci.h


