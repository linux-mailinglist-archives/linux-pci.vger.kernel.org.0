Return-Path: <linux-pci+bounces-21608-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9A6A381AD
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 12:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7231890D9D
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 11:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C9C21882C;
	Mon, 17 Feb 2025 11:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XxjwhKU3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Vsxa8S2T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA07218593
	for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739791803; cv=fail; b=KNVSIYXceEKLgt3ih3SLCEymGaZdwLdMAxBk8dsya3rzwmvxuX37Uam7BUxBqpXa6+QYjI2D/BEAu5ubrP9klzALbF8+hPs9LqF+Jh1qJeYhf1AQPWNdOHbrTFYXB5hXcfCjsWdo0RbpwBIzF0ZevV2aM4ToUGQK62joUT9I6kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739791803; c=relaxed/simple;
	bh=IKU4Qan5enBBZjKGCjUR5M86HvxEst9XxmZkLBSHxkM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z7lG1NkMc3JLxYJNFJO8047ci9qv0o2rvo/IuoIk4wNrOMaLpos8fVOQR5Nce2OBqv47FAelwxe618pu2SS6FRrEoFXXYIShkxR1RaPqVOjyWJ03akdbCEXkKoTszYvQ4y5mVYv9mXDMqx136iI1/QZVCw5aI3ZA0L/LAjiRKMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XxjwhKU3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Vsxa8S2T; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HBMWg4027548;
	Mon, 17 Feb 2025 11:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=23UaKQo4i4z9mLQ1RLtFnduobk3663+CM33qFGsQcGk=; b=
	XxjwhKU3PmvZgRTzwKJTRzqEaS+CAYz5+t5bEcHK6G9bBpHfFb9cjAdEnDSd/KDz
	bX15ppbgcCY7w0XhinvpOd/J1iDbu88tRk51oxCFk//+9WX/9Z12qK5kbmYojYPw
	W5P9SfZTq9YS/2oQ6Hpf1FSbQc/V2XSOUus45sQLwu9KAF2bBuwujOYz+B8vk/WN
	kWAx3TeFfGVuMshLmzJxNeKOpkxCXHfwIvDQ/+Pl1+nLnWu4KKk+5dNosFayf1x1
	vi7krMr2yvPVLXT4S2OWv/OfO6Z6cgjP6DYyelCMm7L9dp6zI1baf7wvN5Zj3qIL
	kuC4CwXSLY4LlR36LmwQGQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44tkft41uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Feb 2025 11:29:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51H9PmiS002071;
	Mon, 17 Feb 2025 11:29:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44thce2f95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Feb 2025 11:29:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EhlXGI+5gcX7mcptp81d7WAiujBFqEYlqtw/oaoiYuxleYckWQB+CZd+XBQEWXf1BE8NFvSX2/1ToGIZGR6SqnPlPR2Fn+Jomm73DWDRnzwxLRwdiBXDhu1xucL4ZdqIBaF6+t+bnw8jhIsvsUuNeAOfdXocq/dUJrb3Dpq8F22Uzu+tlmM6eY1mp3lQ1LEaZglm5LOnqy17bnLWg+ufx/dDIPSt0I0U5Gm4PVZa3fHogcoKBD3v/e6UOUjygTpw1dB6+haguv48uqVrtY039UwXA+GxCe5Dq9Ubs0TGT4fZcdtVP7ALfYJXHdhFLK/Le3699MUYHY1dhSDkFnYnCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23UaKQo4i4z9mLQ1RLtFnduobk3663+CM33qFGsQcGk=;
 b=HoJejVldKV0UiDRaj5zs9ayv2C2mtvbO9sumzAYTSrskqxDK65Z9eUkmzzvtaZpPuaUFnhvAX0tBS/YygIiDzsjZBp0DxwmDaxgNc5wyYqRWLamr1ZvYXHqzJ4LcS5ctbsUKGp+vl1ovHnE+lCXqnzuCrUFA5mM28XJTdfxqlLot5FLJkLHlWi1oC8nhPkX/9pI3jW3plJCqXJxhq0U5jWwkDZt8jBHOUD7JhwZbd7JraM7lVAIiynBSvvudIKpOjPSC3R5VqWaHOKXmZ8zy68CRgd74nnOhTm4hVKTWgD/W1tjk5TyXzgLEuXhl+nI2cQx5bWCmKF+n3wzqH4282w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23UaKQo4i4z9mLQ1RLtFnduobk3663+CM33qFGsQcGk=;
 b=Vsxa8S2T4EzuxDArVhT4tT3AVboUVZCZkpmvyYYhM5iiH0Tfu9MF51F7AP8+lwLHrpa5qa8+zhhu+iO1EfBaJsFxrbKo9GYPKxrvHr5G56cTco8BCS3QjUIWJsPIpMcUJppp3f1qcv7PPuHLv4R+XIGSRdGA8t2B09Bw+3CpSes=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by LV8PR10MB7750.namprd10.prod.outlook.com (2603:10b6:408:1ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Mon, 17 Feb
 2025 11:29:48 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%6]) with mapi id 15.20.8445.008; Mon, 17 Feb 2025
 11:29:48 +0000
Message-ID: <ba1b05d1-d77e-4f35-af1c-836fc881135d@oracle.com>
Date: Mon, 17 Feb 2025 12:29:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] PCI/AER: Introduce ratelimit for error logs
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
 <20250214023543.992372-6-pandoh@google.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250214023543.992372-6-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0075.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::16) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|LV8PR10MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 8801c186-4496-4c04-bf19-08dd4f4662dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmtsLytiRTBKUDJDZ1R0cUVRQ3c3UkQ3dnFxb0tIZUNjVVI1ZzZxKzhwZ1N4?=
 =?utf-8?B?UEhxWHlNenBFU1ZsSkRKVzZxMFZIMDBGcWVNZlNOYUNHT0dGdTUwTGh5ZW9Q?=
 =?utf-8?B?SVBLZzFwV3dOaHV5TUZRbnA5SDlWSjBoUnhoT3BYcGh2VDRmdUZXZlZYOHZ6?=
 =?utf-8?B?RTVXcVNmUHdXc09lQktKQ2FLY29xd3lkNFlaenJJN1dXNFdKZ2NsQnBxa1NL?=
 =?utf-8?B?ekd6SkdKNC9MWUhXSlFBRWxyVVUyUUU4OWRIcmdScFFENU91U3BpRlVmZDdY?=
 =?utf-8?B?MVlzSzlrT1BUYUdRc1RBV2daOTlBY1ErVzdPeXJOVm10N3RjL29kMklpS0ZC?=
 =?utf-8?B?c3B6TkozaXFTT2I2UXpDNVBITGpRTXpmUjI3SDI2b2ViRkhSd0pqV0FFU0VD?=
 =?utf-8?B?TGZyazlJNStQS2JKVGhGNUREVEZxT2EvNW9YazlqK1lUcUoydkpaN0tDUndF?=
 =?utf-8?B?NlRVRnRmalJWQThXOC9JYVl1K3lYT2o5MEh6bVN4SXh5L3NLOHhKRGdZOXR1?=
 =?utf-8?B?MFVaT3lrNXVFeGE2ai9KeEtxZ2tGSjNzajhLMmhlVGVUNEpnVlA0WS81MUZ3?=
 =?utf-8?B?M1Z0VnVMcjF3SGc0L1MydDVSYnpkZ2p6V3pOekg0bWdqSFNXWGVPbzBZNXdO?=
 =?utf-8?B?ZG9tRzlwaUdpN1dPbThmSktEREZqYldoRitzNUpLbzdueVFUU1JlSW1CdE10?=
 =?utf-8?B?cWp1NGhvUlJZb21rWi9mQmk1TnRDeTM3cVpCV0YraXFzUUlyekRBUjNMdGtE?=
 =?utf-8?B?UHo4SUVZU1owdUhESENHNFNXWVJOYXY2bldwVkJGMm1pdmh3ZDJDYkFjMG9V?=
 =?utf-8?B?UGJNRHFZVzdFczhFMTJkSEtUZXpsdzk3UWZvWVJUcmdnN01vNFpWSmZLMEg1?=
 =?utf-8?B?UjRnOTlWaEV2V3o2TDJ3OTNIT2dLM2dwcnNjYm5JdE5Ga0dUNG54RzNjOC9L?=
 =?utf-8?B?dVVkb0d3SGM0NzFHWTRmOGEySGlhNEowY0xXTEVzSHNiMExuS0xrZThucUhm?=
 =?utf-8?B?Vk9LcXhPSCtheTVGYnFYVmQ2QzJxU01XV3o5OG9kbWg3MnBBSWdZWVZvWTBi?=
 =?utf-8?B?ZGp6RUREWFU1cDhaNldub3VrcUNpTEo5RUlwZlJmcVE3ZGhrcVU1T1VxZkhq?=
 =?utf-8?B?YXMyVU12eEVjVGp0RFBuVUhpZTAyNloyTjNmN2Y5blBMYTV5M29jbGs2MjhT?=
 =?utf-8?B?NEI5MHp6bEVQQWJUcDQvdHdDMS9DVDN1UThsMnVnUzhOeVRKN2p1SVVQVTho?=
 =?utf-8?B?ZGswV3VjejJVU2xzRlRQdjZvTUFLUmlmVUFIWkZhbUdsOFlVdUZUd1FmS2ZU?=
 =?utf-8?B?a0JSell6bFI3UTVaREFQeGlaU3BDcCtuc0U0U2JLdTJZclNKN0lVU0RLQWUr?=
 =?utf-8?B?cHdKUUNFdGM1RVV5cjRaT3A0Mk9YK3dZZXhDYjQ4ODJuVmF4aUNzbXhoR0Vu?=
 =?utf-8?B?dm1YTWpZWEZJeWovOGtKYWdXWlZFMVJvUHhFUHRQSVhaTC9jVWtFd2xvckhm?=
 =?utf-8?B?ZzhIdThsS2ZLQm9PNldEVWxCcmI2QVRpUElEN2RkOEttcS9WZmNCempzUUx3?=
 =?utf-8?B?bUYxbFc5MS9CUzZ1c2xLeXVubjEwajFUVHJnTWlCK1NjdEpZa0JNQjlnT2Fi?=
 =?utf-8?B?WlFyTGRIMVpaTWtZOXRFWXNVeXBPR3BtOENNM3pkMmhQbVh5dGt5K3RsaEhP?=
 =?utf-8?B?aW0rY0NmY1JUTE9GZlloOHVoTkdLYkVhS2V4NFIyNW5DNXFMakJaUmpmckI4?=
 =?utf-8?B?UHV5QWRoNm4wNDZ6UjF2OVBRZmdwRnQxZmRPUk0wbk5mNW1SdDZCRkkwQ1FV?=
 =?utf-8?B?N014U1VuRHREUjMyTVJRRzJ6SEhNdy9yWWQyZ0hUZkpzdm8yZlB5UWlFMDlh?=
 =?utf-8?Q?e0aeK5e/sjBG9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUVuc0E4ODBZTWdEbjRRS1ZGZmNqTXZkNGIwV29jK1EzZ0FXYXlhOGZOcSth?=
 =?utf-8?B?WHlYeDNOdG9ZS2ZRZnQyMlVZRjJiWWxZdWtXMnA5bHdoUUVYSUlQTTVmN1hy?=
 =?utf-8?B?bTZJT2YrWHp0b1c2MnF6ZlVlT3Q0eVJZYnlwMGlIS3hReWJSUnI0TVRPZG9p?=
 =?utf-8?B?ZWpwOE1mZzlaMFc3TUdUbGNkS3picFFtVjJISVFFRVd1TE1ZSURWT3FXUFZU?=
 =?utf-8?B?d0UwQjNaa2hkVnowK1hsUElZcENHTTlnZlRodW1QTTg4ZnpKK25VUTdlcEd2?=
 =?utf-8?B?SW8reVRublJkMWsrckRpK0NLK0JOb3JkVGhPRk9JdDVFeC9zeWROUEJEajlv?=
 =?utf-8?B?elBlL1oydWt5d0hDMVlUWWllZjdjODZtWWNWWGxGRzhvUXpKWDRHeHVMUDU3?=
 =?utf-8?B?SkFmS0s0WWNrdTJEMS81K2ViMTI1dmd0UFNRbFcrRTdTUUh2M2pWWnV5QTJj?=
 =?utf-8?B?dmY5Z280cTA4TTNwdFpaQjV3MVkrWnB4TnV0akViWmwvYVNFZmlEcXhGd3RV?=
 =?utf-8?B?Y0c0cDEwTklHYW5tOFl6a2RvM0lZdStjOGs5RWUyTzlGSW5tM0pYTzJBQzFI?=
 =?utf-8?B?MVYzSXRIQXljTG45NnVsaDFTQ2FlRnV3MDNXNGVrbFd0TjdMc1BYa3NMT1M2?=
 =?utf-8?B?cktub2FDclpSZzlYVVlsMHNkMnJGcTZNdHZRZGZIWWxnb0l0aHFlM3lLV2k1?=
 =?utf-8?B?UTVtallsVExLUnhXUjFaWlVRUEZudUhkZmpUWDJXY3JIOG4ycXZseTJsZ2Vl?=
 =?utf-8?B?NWZSRFpxMTFmM1E0OXVyRVVQVGlZV3QwSlVsaWhtdmo5NURtTnZ2eUxTb0Jm?=
 =?utf-8?B?Sk13a3IxbE9oaXByblNLd3kzMklyZVYzYnJsNEN0blpNNGdsSE5nc0ZCNFBK?=
 =?utf-8?B?dVoySy8yY2ZtN2ZHY0RzY0NOQ3p2Ym5GWldQYmhMVnZtUEQzWXEzY042cjY0?=
 =?utf-8?B?TmxEU3NpMmUwQjZHMFF5YXc5eU42SjY5NFo3TUZ6ZmxqZ2VnaVJrU2I0bDAy?=
 =?utf-8?B?QzE4U1dRK2wxNkJYWDdkTkhGTmZMeFRSMGVyV0t2ZFlpRDk3MHpGeDd1OVhp?=
 =?utf-8?B?aEZMVnhCL0gwYS8vd2xSdFQ3clAzY09GbVJaOXMzMHhzaXBjMWNqMEsxVnlP?=
 =?utf-8?B?dGJIMjNZNkRURjNLRzgvOWY2WDk3TlR6T3dYVzVWbFRDcjU5VlRYQURGSFdj?=
 =?utf-8?B?dm8wVjVJbm0vQml5ZWdieHY3bjhxZFVFZVFsbkRtL3NzY3YwQjAzQXBxWThW?=
 =?utf-8?B?UGp1OHhqdlZiWEp5aWhUdWFsUU9tMTlvbzdXajk0TERBdnVCSEVWZU03dTd4?=
 =?utf-8?B?MHlIRzZpZEF0MmloU0V1Nm84L3VmZkxmeFhYN2pRenhYU1YzZ29SR0JINlRM?=
 =?utf-8?B?MkVzWUszeHlxR3c2VzlqRlp5Q1NYYmNCaFRTQ2k0RUNjRENJMU9lcmlsNWEy?=
 =?utf-8?B?dmZqbnBDbXpYV0JZdGlyVGsyK3ZSOCtmemY2L3N6NFNUenR1aGVoMDBuazFm?=
 =?utf-8?B?L3NKS0t0M0NJc3d6azZZbXd2aEVhT2J4SHV2RWliYWVkOUdjeksxN0lSTHJk?=
 =?utf-8?B?cU1URE50b0g0QWtqaDdXNzRzaUlVV0tIMHJGMjc4WE9aRjMxeFBlcC8zdEtL?=
 =?utf-8?B?eHZzVE00dFQ3aHk5QldlbytHakJrS1BEVkU2Nk1CNWRGOFBJa2swUzhkamZ4?=
 =?utf-8?B?Zk5GVkIyRDZUeElNaUZEb21FOHV0anJGMDlPZzQyUGJFNXJqZjlTODRSK0lq?=
 =?utf-8?B?WDMzUG9Nb3RtdlVzbXBwWlpNQTZSMmJtOUVRZkRpR1ZRYkxYTXVjaG1jYmlG?=
 =?utf-8?B?S3gvbjZGelEybTd5dk5vVXY2TjIxV2M3VUZxUEZBYUZZd1dXdmxDUDJCTzZC?=
 =?utf-8?B?Z0UwM1N6OUR6UUhLTWlZSjc2ZHl0OW5YZ0tRdFVkRHY5dEZvYVFYamJXbTl0?=
 =?utf-8?B?clJXc1RqaFpmdWJJc3ladFI4YjNuOUhmM1dIZmhWUTdnS2ZkZHRNcGxZR3k3?=
 =?utf-8?B?SWxKMWFpajdrV1lUYXpoY0lYU0xQOElMYTN0S0d0eHdMS1pLMCtPMEpzOFQ1?=
 =?utf-8?B?dmxBcDczL0x6QXpneDdTc1RQVzdyeml6cDdyM0l6b0pMM3dSeXErZ3VLS0Z0?=
 =?utf-8?B?Yy85dUp5aWd2SEl0dmpWbmZCRm5Od2VIVTdEMjdBbktqZXg1QmJLNDNyaHJJ?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zQrOvwMh5ihLfDdAiUHdO3dth1MqeAToniTVjSobhd31LVINWuxbf0pS5bStshz7O8BC320kWH3hVSksEy32UEsPJCJrMo7RciOLelLwJKRzjPgqF0HtZnXXas/Gz+IEGx5gw9na+NGXkE2y0xVCxSHw3ElVn+JM3ycQxlDVLTnJF6sG4S5h1nP+RUbuekqX+x6zFknKNdOKyxddCytPrnv9D8p2Kriz0dd9om0FdzUaTePzoxUuppdjreYIFQzEyM/MMg06OcCzovirV2ieze3M0Sh/ke9p8UbwZGCj8YzNel2v7vNkWdUErWvw90jm9CsCZB+J8w43EnkQ5DRp5+/FxdswBKFLF7Fsu3lHsjwO/3WIGM9YLJqrkyDv8v1nwINwKLQK74XWt8IfPiXe4NowLAqEfQ3l4jH2+OFD4Tli4M/CbbkCrKeCuDZJYthB0IjO9hF96E4iI0yPobt36RczuwVocHBMA7dRq7hBZdx8M0/A5TTi3MYE+aODuDaah7p3H+KMTCGnwT4VlZ3fl6mwsxXVBajtQbVuy6UhjzMVoL6NiLfOzTGOGUAKUAH1mleNRnKh0VV3gPfS8n9g/hKmDDWOdsURJam/hSfGmq0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8801c186-4496-4c04-bf19-08dd4f4662dc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 11:29:48.3895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pSFJ8JgEC5oCT/7J+MMP3Jp/TFH0Nvj2HkOpb2RDVXLMdkbiPWVCPFf0JIB3LMFvJH2sEsOtp/rb2hnfuvRwEK7vqGKqw23enAULzr616mI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502170101
X-Proofpoint-ORIG-GUID: 0conLSwypqnjMGXqxhsk3ttoMbkizi9f
X-Proofpoint-GUID: 0conLSwypqnjMGXqxhsk3ttoMbkizi9f

On 14/02/2025 03:35, Jon Pan-Doh wrote:
> Spammy devices can flood kernel logs with AER errors and slow/stall
> execution. Add per-device ratelimits for AER errors (correctable and
> uncorrectable). Set the default rate to the default kernel ratelimit
> (10 per 5s).

I'd rephrase the last sentence to say "Add per-device ratelimits for AER 
correctable and uncorrectable errors that use the kernel defaults (10 
bursts per 5s)", but it's just a nit.

Overall, it looks good to me:

Reviewed-by: Karolina Stolarek <karolina.stolarek@oracle.com>

> 
> Tested using aer-inject[1]. Sent 11 AER errors. Observed 10 errors logged
> while AER stats (cat /sys/bus/pci/devices/<dev>/aer_dev_correctable) show
> true count of 11.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git
> 
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> ---
>   drivers/pci/pcie/aer.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index b4f902fd5ef6..c5b5381e2930 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -28,6 +28,7 @@
>   #include <linux/interrupt.h>
>   #include <linux/delay.h>
>   #include <linux/kfifo.h>
> +#include <linux/ratelimit.h>
>   #include <linux/slab.h>
>   #include <acpi/apei.h>
>   #include <acpi/ghes.h>
> @@ -88,6 +89,10 @@ struct aer_report {
>   	u64 rootport_total_cor_errs;
>   	u64 rootport_total_fatal_errs;
>   	u64 rootport_total_nonfatal_errs;
> +
> +	/* Ratelimits for errors */
> +	struct ratelimit_state cor_log_ratelimit;
> +	struct ratelimit_state uncor_log_ratelimit;
>   };
>   
>   #define AER_LOG_TLP_MASKS		(PCI_ERR_UNC_POISON_TLP|	\
> @@ -378,6 +383,10 @@ void pci_aer_init(struct pci_dev *dev)
>   		return;
>   
>   	dev->aer_report = kzalloc(sizeof(struct aer_report), GFP_KERNEL);
> +	ratelimit_state_init(&dev->aer_report->cor_log_ratelimit,
> +			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
> +	ratelimit_state_init(&dev->aer_report->uncor_log_ratelimit,
> +			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
>   
>   	/*
>   	 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
> @@ -697,6 +706,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
>   {
>   	int layer, agent;
>   	int id = pci_dev_id(dev);
> +	struct ratelimit_state *ratelimit;
>   
>   	if (!info->status) {
>   		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
> @@ -704,6 +714,14 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
>   		goto out;
>   	}
>   
> +	if (info->severity == AER_CORRECTABLE)
> +		ratelimit = &dev->aer_report->cor_log_ratelimit;
> +	else
> +		ratelimit = &dev->aer_report->uncor_log_ratelimit;
> +
> +	if (!__ratelimit(ratelimit))
> +		return;
> +
>   	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
>   	agent = AER_GET_AGENT(info->severity, info->status);
>   
> @@ -749,12 +767,15 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   	u32 status, mask;
>   	const char *level;
>   	struct aer_err_info info;
> +	struct ratelimit_state *ratelimit;
>   
>   	if (aer_severity == AER_CORRECTABLE) {
> +		ratelimit = &dev->aer_report->cor_log_ratelimit;
>   		status = aer->cor_status;
>   		mask = aer->cor_mask;
>   		level = KERN_WARNING;
>   	} else {
> +		ratelimit = &dev->aer_report->uncor_log_ratelimit;
>   		status = aer->uncor_status;
>   		mask = aer->uncor_mask;
>   		tlp_header_valid = status & AER_LOG_TLP_MASKS;
> @@ -772,6 +793,9 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   
>   	pci_dev_aer_stats_incr(dev, &info);
>   
> +	if (!__ratelimit(ratelimit))
> +		return;
> +
>   	aer_printk(level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
>   	__aer_print_error(dev, &info, level);
>   	aer_printk(level, dev, "aer_layer=%s, aer_agent=%s\n",


