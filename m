Return-Path: <linux-pci+bounces-20138-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4929FA16AE6
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 11:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 761C71619EF
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 10:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8EB1B413E;
	Mon, 20 Jan 2025 10:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qmk+ua+X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OJPAApnA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDCD14387B
	for <linux-pci@vger.kernel.org>; Mon, 20 Jan 2025 10:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737369504; cv=fail; b=nsCH8WA3HvTausdU0vDAlvl9kwUtE4992lqhUTgNtLF4Znj+JkMagpuy1nSua7fbnEYLEQ88/sXDmSxcJ3tjydAs55b6Kmml7iIwpwIchdNESGEB5xAQR3VlkDK4B63jd1RUV5ho7z/Zt9sGrFgOJ7mtIpP77Gjricc/uO/45GM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737369504; c=relaxed/simple;
	bh=M+qoSZNTuN3BbrKd8BlxO3wpk7Nrzaul5x3NV2JT4Ug=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CNRivRHQCIfH00EK0l34ZfjaJGCZGN/7fusrd5Cjkwr0v9Amb+YqZlglpe2uOAQuWKk7HzuiHGWSOZ7+zYfWes7qG36PXm6xI4avmh8snaVUUZyz3m2ZcEnrWhgr4iJ6R9iCougGVBq1+CJUM+OwNVUFIFewMlyKiG3qz8nS87E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qmk+ua+X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OJPAApnA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50K7fuWS006628;
	Mon, 20 Jan 2025 10:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=n7Anegh1oS9NmmBZGQ6bYRDktRlGqF47p5bbBqp7seE=; b=
	Qmk+ua+XNS6wU51EQTxlJgz1ImUGTKuNf5A4vO5DYn7/ywWqwxcL4cRBaIwvSssX
	b/MNlp6xp7E8NpLsu+/WbP3X/TPz8mGRS+8GwGZriXrRCpskKb0O33dG8YVwgTnT
	lqwaF/Qh32nfgUPrP2MmRh+w8R25CRPbf1czRmjq4WNYqRkJ95/hKAw32Qtm/e9h
	AEz3L5z5IMFvJd88hTJCduCtQEnpEHfogAKQD2ejFaB9iF0mkAfmT60IYpBtrCLQ
	YVwhJTujhJxOaJdnNmyxCc5hzw1JvRnRc7paWcFPaWbr7r12L4spGenuJzylUbP4
	UqLlGqp2Hd2Qf0b19p4j+w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485qkucpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 10:38:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50K9PL4n030587;
	Mon, 20 Jan 2025 10:38:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4491917fjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 10:38:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVE17zqwUMTFzv63f0aiD4W7NxK0H23WYaDl/UUlSIu4lTQcjMRj/wYSYWza4Co03loyomvogSqQbHyAzmDQUByhZtSlGXWcRJfLLWZyR2EjMFEM/Y5VZHmYmrTQ4FzOaxs6FiqwOveNQnAIVSHyeiRbKJwz5uNzkSwrMJpz7BABxybWlSyUAXoB5Ue43xK7v98ke68vZauu4hSw2vFVb91pqiAoDQLSdAXVATa27ke/BBP5FJrDCw1QPJCsfJyG/3StVNo26twZIAZRzsB+0ciovR4VUP6sJmR6KMwK3Ft0aaXUKryzSGmHH/h1jVkbfnWjONy8bHnipYz/gLMlLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7Anegh1oS9NmmBZGQ6bYRDktRlGqF47p5bbBqp7seE=;
 b=bQVMUeszv856jxDhVFvtdgI32bmLzf3oEKehLLstYog/AOxDM9xmHOEZOHv3yUYn0cL+vpM+LJFkqDnJvHs6QV1Klh+qs2DI19UNqapdemNZi0ReQtvma3ClLr5LCUlhJfTIfsDfNZdDUied+gZ9pWjwX3G/+VXpJMc4ZBM5KRYw6+wWDm5ijwJ3j4e7/HVhnI5k6wZlpKU0QI+fTHWDemdm3EuQgwInQpXAxSLP3sLZbWnxUD/6v4w3M5c9HIKI8jENnzNm9YZo6j+1567HKoopu5c8V8LbRliAc8MvEmpiHSG/2FEXWnLIIH6W7AbQA6xwdL2QYXCWpl2hV0KTkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7Anegh1oS9NmmBZGQ6bYRDktRlGqF47p5bbBqp7seE=;
 b=OJPAApnAxvHaGJZQ3ZdT8bMZKOGkkxCGyAcF5Cj7RJrFmz38PmeIDCqRCerCDLymyLj5Nh1WYjLg0+duwv+XsX1sSZibAWj8hNbwBKHdt5WhVu/J3PkCh1d5yHSYynWwUQGqnR6GDTs3MAf3jKF8E4dsCAXd9slmXwMSibNG0Ps=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by SA3PR10MB6998.namprd10.prod.outlook.com (2603:10b6:806:31c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 10:38:13 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 10:38:13 +0000
Message-ID: <487cf559-1a11-4997-9ff5-19f667ef652f@oracle.com>
Date: Mon, 20 Jan 2025 11:38:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] PCI/AER: Introduce ratelimit for AER IRQs
To: Jon Pan-Doh <pandoh@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Martin Petersen <martin.petersen@oracle.com>,
        Ben Fuller <ben.fuller@oracle.com>,
        Drew Walton <drewwalton@microsoft.com>,
        Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>
References: <20250115074301.3514927-1-pandoh@google.com>
 <20250115074301.3514927-6-pandoh@google.com>
 <8b6796a1-5504-4d95-a565-a19272d04350@oracle.com>
 <CAMC_AXUeUqxaqd9_rAx4cYq6D9QCEkxUS6p4Sx24xZL4TQ831w@mail.gmail.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAMC_AXUeUqxaqd9_rAx4cYq6D9QCEkxUS6p4Sx24xZL4TQ831w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0587.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::15) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|SA3PR10MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 536a592c-4dfe-437f-5ab0-08dd393e8a4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3AyMWRqUTd4TjRFajF6R2hDWDU4ZWJrbXFUVjZXWkY1emhOQWZKRDBKN09Y?=
 =?utf-8?B?TWVHekszWXBmYjIwY05jNWx0LzBXcEtRMktjTFFOUDFCVnM5cEZWV0dxK05X?=
 =?utf-8?B?NkxXbnJuRHpTVWFvRUJ0bitCVThqMEp6QTJGTzA5djhyMXJ2V3JyM2pFS3dU?=
 =?utf-8?B?YkxPY0FiZUpCbnFzdmVYUHRkZklJZmJRYUp1bFVZM0JGUDAzei9pWHlIdC9m?=
 =?utf-8?B?NmZmV0NZZWF4OXRLekZXTmVGNE0rZnNiVHdHZlVuS0JBTHZJZkR6N3lKZzFI?=
 =?utf-8?B?dkIydkQ4LzNYUVdWc21WRWVWcTc2ODB1SnRCVk5SQjhOeUhZQmdvVkFPZm02?=
 =?utf-8?B?ZDVrYVpoSXNFTEFFOEptak03b0FFVVI3dlFTdUswazlKb2V2c0wyd0lobm5n?=
 =?utf-8?B?a281SXRXMkNoMUMrdHBIbm1VeVRITjg3RlFSVGNISFY4bWR0bzlyaCtDYkxw?=
 =?utf-8?B?Nkd0eG5zL0tGOU5LZTVuRGM2T21vTXY2QVlhdCtSTlNKRGdSbGtuQVJRQ252?=
 =?utf-8?B?eDRmeVo4VlUvWjFDRVY3UnBhdk1nc2xXTUgvLzhrUkgycXVWdnpPNHljemNO?=
 =?utf-8?B?Z0VKZXNMQzYyY00rNGF5UGJiK0FNazk3RllySFQxdmhTMC95VUR2Q2pCRXo2?=
 =?utf-8?B?Z1ZiSjI4ZHJHVk9HUnJUVU5MNTVscEN6WnUxMGF5ci9QdnlhaXJnTW9vZDdS?=
 =?utf-8?B?YmJIakJxa2o5UGJuRjI1aFFUMnI0Ky9xbDlNV0JqeVZPR3lCclhrQU9qVjJI?=
 =?utf-8?B?QmJIZ2Z3ZHdXamVZa1NudFNCUk1lT3YzSVlHY0p3Ui9Fa3BmU0J3aWJ0RU11?=
 =?utf-8?B?MU44NitSL3NLMEo2SUN0YlZXZVVIS2kvWVM4aGhqeWRXclVkVExuaWt1N0w1?=
 =?utf-8?B?SnRQYWEwQmRFdUlUUm1UZE9FYnhJaW91Rmo4VDJzV1lnMG5JS2JmcW02SlZS?=
 =?utf-8?B?bFRIbDBtM2tUdlM5N2JtZWpHVWlhbktwemRpQjBlRTl6YXRMUHl3SXNJWE9R?=
 =?utf-8?B?NUx4b2hMUEhQWDJYZCtyeFg1UXlUTFRqY09xMnEwUnNVNmUrMlcxK0lkR2Vj?=
 =?utf-8?B?MkhhWUJzdFd4Tjk5dW1xOGlGSXBsSkRPcTI1RGxDampuWXcveGt4RHpmVTAv?=
 =?utf-8?B?dno5OHMyU1pkc3BBSWxjemJEaUtML3lXSjg0NlpibUIvZ0ZUMElGd1hINmt0?=
 =?utf-8?B?Y2phdEM5L0c3NExva2I2MWptZ2RBVU9PUVV3ZGVoU0dLNjI5QU1lYWdRclZG?=
 =?utf-8?B?ZHU5L1ZDVGtpdnVIZWdzZmJ4bWdha2NzMXhFZEpLK1pGMlhWY2hSeEkrTVJM?=
 =?utf-8?B?NTZwZFRRVngvU3Q4aHNLTE1BWnNLNXFDRktpMmR5OUVGL1NDQXZHVlg3bEtu?=
 =?utf-8?B?VXJwUmEzQlpKVjVhdnozTjY3RkpNNkczVGV6VmtiR3NFa0tFRkkrMU8rU09a?=
 =?utf-8?B?OEgvME1DaWIwd1VteXhjdjE3ZmU3S3lHbE1vYjhuYVFwMHpXOCt4bEVWVnNO?=
 =?utf-8?B?NXdzU2xTS2xrZmdvYlcvS0NkVEdJNXdvbkFIV21kQmhXRmNvaDJhMzFidVhh?=
 =?utf-8?B?U1krYlJZMmtydUNFQ2NFQTVoOFF0U095c1h6aFRKYVFhVGIzeHJqdThKcGxp?=
 =?utf-8?B?NHo4ak8zTmlTTG1jdmJuZ3RiSG1xdHdvandLTnh6RVA4blora2R5TUVTZXdo?=
 =?utf-8?B?VkI3VXBlcUUySDdKRzZKa1ZCSllmVGp5MXFKWHlQMWV0dVNBam9vbFpzd0J6?=
 =?utf-8?B?bVFTckFTcWY3aUwrTXJVVnFyV3NPelR0RTVwaFJYMHJPWnlJbTBtVHJiTC9I?=
 =?utf-8?B?dFRrcDgvK21iWjhWY1FUNFFraHBYRWw1SU5XbXQrVDlzTXpZNnA0SEZ5MHZq?=
 =?utf-8?Q?tqtuPyjZPnNAb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEk2cnFHb0hBZXVuSHhJazdFZDVaeEYrSFRYUm9MMjNUV0dxVW5MQkFCMFY2?=
 =?utf-8?B?eXJQWGNJNkdCd0p1M3BQYzloVHpMMER6Z2c3SHpzMnFZWWF1UHVscmphRUh5?=
 =?utf-8?B?RzVRb3JlZklxelhVUlN4THMwdlZid2RkeFNvc3lIS25QY2xjV3hHcFg2Mk1x?=
 =?utf-8?B?Qmo0YmNsOFhSMGhCQlZmRDFXbTBxNERaYUdaQSt4Z2Y1RElnMDJOSnFEbEJk?=
 =?utf-8?B?R0hlUkdkZGpOT3h5TVU0cHgzV3ZTT3BoTWRETHlQTkhLR1NnMzNVOGN1emJX?=
 =?utf-8?B?YTlVTTJ3M1krb2twR3ZyUytJTGNDV0pMZEovY2tNcmluaWtjeXFodVZPR05n?=
 =?utf-8?B?MjZMeXdiOFB1ZEpZWHhKUS9jOExXVVAxNlB4WVI4UUJwREFkNEw5YS9aSnQx?=
 =?utf-8?B?OW41UndzeVpiK0ErNm0xR2hPa28zczhoV1VuSzRwRVVmcmZyN2d2cEZwTWg4?=
 =?utf-8?B?NklLOXFSak9EbWVEVHdhL2RYNlFGbXdSUGRJd0syTVlxL0ZvZEdkWk4yTGsw?=
 =?utf-8?B?ZUwxbXVHTFlLWThsaC9EQk1qcGo4dkFqaURVWnBkU0dOcmVrVWNlV25MREZW?=
 =?utf-8?B?cmc4Snl3dXdpME9sN3JDTnpJNTlPeHY1aW04UGk2VHFOQnVFdmdCTi9BZVRT?=
 =?utf-8?B?YlRZeEZVSXoxeGs3Zkk4SUpmMC9QWkZIVHkxaDJwMndFSGdLbzNPTFJaS1JR?=
 =?utf-8?B?eHdhS2d4c3Zna2pVSnM3MDFSUWJvM2tPZlFvbkVna2h4b0ZZaDJCOU95WUhJ?=
 =?utf-8?B?MnFjWCsyem5rdTVnbHdZaWcyaGFWZ09lMDhRTUh4M3BhMUJYK3BwVGwwdVN5?=
 =?utf-8?B?bXc1aVlGdzNRaUdtWGIrVGU1bTZrT1l2WGFJN25QVDEzeHUweXdWT1NheXVr?=
 =?utf-8?B?YW4rWHo1Z0w4aUZoSXhIR3U5MVRxVDI0VnB0UUNBSUxMaDg5QnBMK1ZoUHNS?=
 =?utf-8?B?dkw2OWFBVUtQUFh0OEZlRnJCOHZ1VlcxM2lOcjZVcEZTU3ArK0N5L3hsM2Jl?=
 =?utf-8?B?RFZ4T0ZOUXJ3cmdITEw3THBrQ3BhQ1FaSmJCdEZWaVJnWE1aY1loQ2VIM1VF?=
 =?utf-8?B?RnZYZjVYUEgyYnNqWnBFMW5aZ3RtdmFaclRuS0RGQWRFQ2V3NFUwL3cxVmM4?=
 =?utf-8?B?NUVmV3pCQ2E3UE41VkJzdEEveHp2WEZzL0kwRFh2WkRTdGFlTkYxakIxZk14?=
 =?utf-8?B?Zkp0VWFwbmhRTmFWRWtBWEdIR0dNRmJiTjFkdWQxN1RuNmFuWkVHS2NpYWZB?=
 =?utf-8?B?Tkhzc3lJMHIweGkvUGVsdm5JSVphUS9oNXFhWlhBVnJhSEc4WFFOSjkwV2tQ?=
 =?utf-8?B?bkc3TXVxWGxYdFYveHBuNHpvQjJQMWlPRjk0b0pjYjN1QnUvSEQvb0ZzcUY4?=
 =?utf-8?B?ZFFEL2tnOEcrSEdFQXpIbXB2S3BJVS85LzFzQVR3M0UyU2dmZ0NRcTZLVkRs?=
 =?utf-8?B?MUxJTVZkZElKV0hJUm1YOHRGV1Z4M1pyQWFVVDZuUmJKV2dGMTRTRUIxQnFI?=
 =?utf-8?B?cWlYUFdYSGlYT3BlaStOb0N5NVJ6WjY3TmpHSUlOYnVacjJWM28vY0sySFpG?=
 =?utf-8?B?NHltSXZ3S1NOK2c2YUJZNDFuM2hoMTc5dEtSTEs0SEg5Q29LbjdOQzBkdFpG?=
 =?utf-8?B?Zmc0bjB0UThwdVJDeFE4MURZVVYzb1JMVEo5RlNlVEpKOTFNUmttdXVYbmJp?=
 =?utf-8?B?OWNoTSs1K3FRYm1WQTA5Z1NxbVdUOW9JejNHY1RKMFdZZXRHNTRtWWVSRXdM?=
 =?utf-8?B?cU5MVGFwZk9nL0lpWjk0Ny9LVnNHVUlGaXNxenJHcEltTW5maUFHTklMalZw?=
 =?utf-8?B?MWJ1VDFFNjJTWHdneWRGb0hGNytVazgzNFBKQjl2N0JrckxtUHlJRmwzTUpF?=
 =?utf-8?B?RjRycS90aWdraEp1Yitwd1FaNitYcUdEUFhmeG1pRm1tMTEwc0tEUTA1Qjht?=
 =?utf-8?B?SlNwYzJUZTUzNTkwVVJmMm83dXNYYXgrZFUxUkVXMXNubzhoUk1YNDk5eG40?=
 =?utf-8?B?M0VVK3dzNWlUQlRqeXprcjg1SEhmTlZHditYMHd0ZGNMZkV4RzEzbUExRHFS?=
 =?utf-8?B?Y2dsS0F1RGc1OEdvdkRUNVJrYlI0bHJzYXBmb0hFdVl0UDRSaURWMlNxQ2oz?=
 =?utf-8?B?bjJjSnlQMFBOcmM2NlRtWXI1UXE5czhtR1o2ZmZMSjR1VlZRcENYOGlEeWVR?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4tmcE0Hl/38o98A3I1xvw82pqnteWCCSp7bVi5Eqnshj38M3Mctd7k93enifijtSCByYT+QZrIJo3rldnD9NXSptxhjkmliEkSKMYxu3WAlMSrlHHWnEHKnllaPNlMAD86lSe0ix38cFKlKbLoaTSlE5ey24mk1BAbdKqD6a9vP05P64Avjdf0fuOTnVWtiUooYZD/hr8lSfMO8xOMTbnFpfyG6DdI7Eu3f4HxddxVzABsFMLYlSDTq5sfuI5XkKI7DGOR2sxYXk35yhzo6UPzgJjM79IAjvhxPhRSQ77nr+AWeREy2LdVwnC46uS0IGvWtHuXQ1pYsAAnfjfbwZ+KZTXRQmvScup6/b7oiCJOS9rsAEhJHVlehaxBORIXl4kk53HKXWZY1mL5wEJHhVydMv+iphzU7/cIKDhwY4ktW+E80raGgEbiZjkg7Q5qIAiAB6+G6JPbBqBstEfBN1+TovBHmllsJ7rawemFMffX8gzNRsd4bFyw2SfQHrcDA2EVBTm6CDEW+dK000RoZOcSmHAfjN7Zr04pmmX05o0W8/8jxP9k8pmhBmkxF0y3m2QPmPmVBnrU+s59mLc6YI/WtMPiPUCS1WC4fnCPfKZQk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 536a592c-4dfe-437f-5ab0-08dd393e8a4e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 10:38:12.9804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ke+9bt8k1Q9QTPf74Mq9V0Tt2/jZRhNKr2Be8DS4tl+16A7whxl8JP5pl7qrr+q1h0qAm7yAtLMZ4qddRmQSCyJLVK/00geFgGVyEUIuF64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6998
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_02,2025-01-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501200088
X-Proofpoint-GUID: VIwLnW2u3zoxuL2eZ5wMGQVg-DT7A-R-
X-Proofpoint-ORIG-GUID: VIwLnW2u3zoxuL2eZ5wMGQVg-DT7A-R-

On 18/01/2025 02:58, Jon Pan-Doh wrote:
> On Thu, Jan 16, 2025 at 4:02 AM Karolina Stolarek
> <karolina.stolarek@oracle.com> wrote:
>> To confirm that I understand the flow -- when we're processing
>> aer_err_info, that potentially carries a couple of errors, and we hit a
>> ratelimit, we mask the error bits in Error Status Register and print
>> a warning. After doing so, we won't see these types of errors reported
>> again. What if some time passes (let's say, 2 mins), and we hit a
>> condition that would normally generate an error but it's now masked? Are
>> we fine with missing it? I think we should be informed about
>> Uncorrectable errors as much as possible, as they indicate Link
>> integrity issues.
> 
> Your understanding is correct. There's definitely more nuance/tradeoff
> with uncorrectable errors (likelihood of uncorrectable spam vs.
> missing critical errors). At the minimum, I think the uncorrectable
> IRQ default should be higher (semi-arbitrarily chose defaults for
> IRQs).

My comment was mostly me worrying about Uncorrectable errors. Pulling 
the plug on Correctable errors after we see too many is reasonable, I think.

> I think a dynamic (un)masking in the kernel is a bit too much and
> punted the decision to userspace (e.g. rasdaemon et al.) to manage
> (part of OCP Fault Management groups roadmap).

I agree. Still, if we decide to go with IRQ masking for (Un)correctable 
errors, this should be communicated to the user in the documentation.

All the best,
Karolina

> 
> Other options include:
> - only focus on correctable errors
>      - seen uncorrectable spam e.g. new HW bringup but it is rarer
> - some type of system-wide toggle (sysfs, kernel config/cmdline) for
> uncorrectable spam handling (may be clunky)
> 
> Thanks,
> Jon


