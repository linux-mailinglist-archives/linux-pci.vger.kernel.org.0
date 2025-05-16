Return-Path: <linux-pci+bounces-27898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE03FABA4EE
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 23:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3DD94A709E
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 21:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977B522DFF3;
	Fri, 16 May 2025 21:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="daW8HKSg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xj2RsCKs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE43822D7A3;
	Fri, 16 May 2025 21:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747429419; cv=fail; b=E0aiH+Uk9bPA8ANIVBsKu5qGhMuJBlwwe9bCZE2ziKVi7mwbTFRMh2pUHbma7SatSX7wjHLW+imvFS5pQQtFvSz5x6/jwZ7hyeFQlOuI8ndXbOXTtzs7GfR40s2fomb9oODJcC4QBbZJyR4ySJWOuXcNAQhGbM2/Kfhe/ZvwsdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747429419; c=relaxed/simple;
	bh=zRTqZaa+62PGSVIUkDDo1SVm1fIxt8GknO1CfssshhI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W9wg7LwN2rwLRrWX+GUM0PH6+gz506bqguftU9E9nfggVwmF4mVqgL4x6Znr/w86YCx54hEYLeTbqFYXMwp3JlhLM8sXwOM+JOecRlRRx9IBHdX+rpyyY5h9bb4XOosvckEOfzzZ0R6GC0ndvo+hObS91Fx/VarxIGEQU1BT9z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=daW8HKSg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xj2RsCKs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GKA1rZ008052;
	Fri, 16 May 2025 21:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=TR9J1Ud45RrxVvbqPGHot6Tu/VGl1a8r+CouB40i2fM=; b=
	daW8HKSg4Bt3KsuM6Huypbaf4zMTun8C3QXJQp25DaReqZGlmEIjDc02a848R/Mg
	ZxkaKv2GzyHOwGbgxVQsRQzEssdg2bXbauNrzgjpxEh2aZZqLRwSZ1XAyH46xjTf
	c7wxR5zJ9SVp4iWhlOEgTHuxzc/gn98JdjOGNAtb1zpSzIWjbhW51D8XTMXIxI8J
	19VOdNSDJaBgCFX2XuC5eFjiowL9cwLMKKHpYJAj7Ixm++4DoP75zDUwEpnP62eY
	LUtmROwFmu94Iq4dcqcDAkCjwhP+2XahzFXVKDrKV+yiF3a0M0h4T7oi3JMMyont
	ecPmCl/nx3ByAqDRVw/x6Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nrbet6xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 21:03:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54GInvpB033308;
	Fri, 16 May 2025 21:03:20 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010002.outbound.protection.outlook.com [40.93.11.2])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mbsc9hft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 21:03:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdKBy7J3t1IQttXlyNOPSwgftnNCFlIxJxjKkI74c5ckqm1twf8qQRGb41OeWZkYVzJGzJ/yVpDK1f+DLidVp/ivNAPe2hDUhbx6cnVU+AicJPhzo3TFjNZq7qIqNUv/lfpkQUwmYb2HsEj8JOS+FqvCpsN6fB8KWN0oA2OXCQy6tfjsLuJcJZCzIq/4fxwAhU5TOCpmneqiOWDnmFWJSIA1tLk3SNDdG1OtssZWE2dQYEaNF6pKMIvfPfbb5TAzkeI/vRafwVabFLrfmNDTikDy4Qts3HhGmuXniKnlFs5z0HwaCJALoeRLAuMQ6Aq764x36NpbHgDyjSd5DEiqnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TR9J1Ud45RrxVvbqPGHot6Tu/VGl1a8r+CouB40i2fM=;
 b=m1VS8xbNElET2Ps1LIhqVaL0GcDsyeFtAx3lBtBp731/qmQIw+Sh4kfL5YxGGRssGDxc0kQiG/sFAq1IQh0OWSDCAFNnOfvzFcgYvr0jNVVJJuGd+KHMs3IgtCl5lUfS5+G1M+69VlY+I/AzqwaILdJmX3VUDrdnTbqVQNpDnK9Geo4rcigSJqmDTsRBsC0HoYp0OR/M/RXOkzJ5XfKAQ5dEJJKd4nmH4zmxoT23XAEm4JHXl3Wv/6IV0Zc5NI3OTmMAp1yt2Wnb7VWeBQPrebEfkacD2iVDTKFa0TDF/D4FlWeRW3dXsKX3WWKW5fKKcC12SEBTpjha8DIVI/6JBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TR9J1Ud45RrxVvbqPGHot6Tu/VGl1a8r+CouB40i2fM=;
 b=xj2RsCKs8JHklWPa1wZVgG/Cco5oLxUOmSXQ2NkvNNGHWT1/G9aAp1eaoKknXV+R166RhIQ5V1ATs5ADLei1Vq1jyCjTwzzujFwT+VyJ0t22JgTTljoWx0WoesZyVjE6SN9bLW3o2/BWqf9PB5Z3WurB+RCX5bZaKT5xHHl4Ejg=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by BN0PR10MB5157.namprd10.prod.outlook.com (2603:10b6:408:121::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 21:02:57 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8699.022; Fri, 16 May 2025
 21:02:57 +0000
Message-ID: <b95a3aae-1f66-481f-b8c5-aa5bfd403185@oracle.com>
Date: Sat, 17 May 2025 02:32:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] Documentation/driver-api: Update
 pcim_enable_device()
To: Philipp Stanner <phasta@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, Mark Brown <broonie@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zijun Hu <quic_zijuhu@quicinc.com>,
        Yang Yingliang
 <yangyingliang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20250516174141.42527-1-phasta@kernel.org>
 <20250516174141.42527-3-phasta@kernel.org>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250516174141.42527-3-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::6) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|BN0PR10MB5157:EE_
X-MS-Office365-Filtering-Correlation-Id: 19af907d-b2bf-4835-7864-08dd94bd08a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVp6WDhyNnpIbUhZWlFJU0VpZjB5SVcxMFpHQ25SSlNVMlJyQ3ZrNVVtdUpN?=
 =?utf-8?B?OXN2bEw3T2l2TjhVc29yZm0yMHpaYmdEYTYvZ2pBbzJaNWw3RWYzMEdpRWRY?=
 =?utf-8?B?a0lZMVo3VzhYbkZKT25hcDcyK3ZlQUVxM2FQcFFRWkkweEJJb2hMVVh1emxj?=
 =?utf-8?B?MHl3ais0MExxcUdGNmI3TElGaU52WWpIN1lnRDlHd2hoTjI3Q0FJdEZCejVL?=
 =?utf-8?B?dE5UVzFOOWE1Z1IvWmFnSjg2TlltaEpzbmVyVkNKYVRwZmdIOFA3MHZrMVZ3?=
 =?utf-8?B?WjM5VVk1aDZrVkp2L3JmWjZDTHM2OWQ0N1F3eXhNd1ZDM0JLcFByU3Raa0dC?=
 =?utf-8?B?T0xJTmlDVlJjbmVxZHFQS2hwRW1OZy9iMnRsZGxOMHFVSWx5YjdHUnlZZnVY?=
 =?utf-8?B?MDFnOTF3WEFNRDBGbFhlVGxjd2tSaFAyellhNGNqSDNSajM5Um10MEsrSFJw?=
 =?utf-8?B?NWxHWk5kMjkzYXdNbXFUNFMzMU4zR1pYWk1LWUk0RFFiTksvUWRTbmUweEYx?=
 =?utf-8?B?R21UUGN6TmlTaDJva1JJUVFqYnB3ZzlnaEJIV28zV1g4bDdlSFAvcGVUSEtx?=
 =?utf-8?B?K0hBbWpZM09DMWppK28yZGI3NktFeGpob1lMd0l0ek1oMmdTa1JqRlFpRlZ0?=
 =?utf-8?B?b0JIem42cTZjUnAxYmtHRmlDVlF6TXR5Z2l3enQ4akhhUEFzc2FiZEg2a0Mz?=
 =?utf-8?B?alVUc0kzZTRVWTFTbTQvd0pOU0hUcEFWUWRaaVh5YXVyWmR3VXFEOTVUTEky?=
 =?utf-8?B?VHZBeDFxUURDR1pNdElSTTVOOEtqb3huN1loazNEdHo5UlEyUmd4aTdaSnZQ?=
 =?utf-8?B?ZWMrZk8yNm1aMVZCaWYxaW1rREk5RjdQdFF2Q1ZNMUVqWEtoekFFMFc3YStK?=
 =?utf-8?B?cVRveFlIS3lIUVhzL3MyVXVrSW1LUmVETmxTTXZXbHI4ZHFPQnJqRnV4aERP?=
 =?utf-8?B?QWpsRTl0cFowcUxqSnhPYzNQYW5RczdOOGcrSDNYUEh5Z0FaZ2paTTBkakhv?=
 =?utf-8?B?TnBQenNUNGJLaGRCWUloUGJpRmw1S21MWnZPclYxYzVGQ3N6czJkR0lmdlZN?=
 =?utf-8?B?Q3B1aWxrOVNpaGNNYWFhK2V2a080RmN0amhWc2wyRWZVeEFPSmRVTzBicDlN?=
 =?utf-8?B?L3lOaWNzS01YVTk3ZHNGNVVsbXkyU1gvUVR6blhxN08zeTRyVDA3ZFZaUlhS?=
 =?utf-8?B?eVZObGVwTS93aTBnVDM3TkhvYmlWSEgyRFQrMHhYdGQyNmppVDMxdnZhWndD?=
 =?utf-8?B?ZXJaVkFYOXhuR1F1eGIrWm9DQmI4YkwxTldRYms5R2Y0ZTdqVG5FYWsxWndI?=
 =?utf-8?B?Q2o1cHdERE5sdTluTjVJYXppTDdFM3hsN3BRRWtZdWNmT0RUWXRnT1dLZzN0?=
 =?utf-8?B?MDNuZmlQenUyNGpnMTduMGl0SFgvaGVGeWcxLzRBMDM3MzBIRUQrSGxHRG93?=
 =?utf-8?B?dG9EOXprekRNSFJLRk5odU5IazZJYm9XcDdscmhIUVFsdkZpV25aTEoxaUlw?=
 =?utf-8?B?ajQ4RHpKQTBoaVIyRmhpdXdsK3FxMlBWSzZVbmdrSkV3ZVMxb1M3TVQ3Wjh2?=
 =?utf-8?B?bTdwbWF6bFovZkRNWUkyZmhxUVJTaVM2WlhxdENkdFFTWTRVVDZRSW1Ec1d4?=
 =?utf-8?B?aFhpallFRWxMeTNyVDRSQ0RPNG9JMUc3YUNDMFp5aTNScWZ3czZ4NXoyWUYw?=
 =?utf-8?B?dzBYVHBucHQ5WGVuMTJkM3Z3VjJzWmhNbE0vL0lGaWpVMng5aVg1TWhlak9i?=
 =?utf-8?B?NU5pTXU0a2M2aHp6ZGpmZDRtUE9VZXE4blFIT29YQlhiT005Vy9tYk9CTEdP?=
 =?utf-8?B?eUJyTEI2TFBLMlo3MnI0NGs4RzlKb1ZGTFBsaFMxQXp0TldISy9STzg0SlBG?=
 =?utf-8?B?N01kZytzbm9Rb3NhQkJKMFA1amVZM3lkVHZIZ1BscDZqalNCQ3lkM0JZU1da?=
 =?utf-8?B?MFZJWkN4b1Q5a0h4aXBhdFJYUWFTWE9lQVdkYVR4NTcwdzBPOVRhUW8zVGpM?=
 =?utf-8?B?Nlh4WEIzbW1RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVF6ZXAxYmRJUWJTVTN2OC96NnR6OCt5ektVVjUzNjRJUWtqTzdEcUMzRlNK?=
 =?utf-8?B?OGJDUitVNndBREJ2c0djbnZqZ1hFVTROc1hpTUFrQ2VMc0RiM1FmaUhUSUpD?=
 =?utf-8?B?ZEw0Yk5nMVRvQW5nYzBKOXVodUZyc0MzR0I4bDdzbWVtRXY2ZEdiYzRxWmV5?=
 =?utf-8?B?azd6aUwvUFNxNUdoU0UyNTN4V3ZISVZYQThKakxtSXljZEJlZEJFUkFNeU03?=
 =?utf-8?B?bnVqNUtsbHdacjNjQW9PMTl6VUpSMkFDd2FOd3dwcFJxQ0lFVUNBU2xSTWg4?=
 =?utf-8?B?eEg5NmRsN2dsaXBydklIb2JqbWVlOXdzRktSMzRRcmg1U1ZvWld1TVNoK1ZX?=
 =?utf-8?B?Y3FHc3hieFBOd1VuUzNXNzhTK0VaSmRoODFtR1Y0TDRPM0pxeGNYRzZpbzJp?=
 =?utf-8?B?RFI5czhVb0d3Q3JqeEFKR0VtVzJGVU5zSUo2RWljNlZtZlNJUW13bHpPR29a?=
 =?utf-8?B?eGUvWGtxSEVIUTdEYkFQTURLMHdPbElZVkVYako0YytsUHBGR0VGRlVMbnZY?=
 =?utf-8?B?OHMzcWZ1ZXI2MlFuZ1h0MnJtMC9FUzZzU0Nha1dKWkhYZkE1bFNVSFEyUkkx?=
 =?utf-8?B?WC91QWZ3Q0dwWm0zN0tZYVdXUXIxQ0ZpR2R0ck1iN1JFMlRFZmxvMml2THF3?=
 =?utf-8?B?akNmbDJTanhZOU4xYy9ZS1A4dlRZcENYR2NTeW1QdGJybFR5eWRIQ1FhOGpy?=
 =?utf-8?B?ekxRUHVZYVc5VzNZQUgrZ0NtNXE3TGYxVEgzT2xEUlpYdFVQczk2dk9uZ3hn?=
 =?utf-8?B?ZU1vU0ZSUU1YRW5UTDVzTDR1V3owa21OZVpzbzROUjFPYzJSbGxEdXZjbk5J?=
 =?utf-8?B?TXFnMlJkeUhSendPdFE1b1RjUzB5cC9VVHo3NWZ0cUcyS3NacnppbzAvUGdp?=
 =?utf-8?B?MjIzRklobVdFMngvK0UzY2l1MSsxU21sWHc0dzlMeWlMREFndW5NZitCb0tS?=
 =?utf-8?B?endYL09XbFRpaHNWTXNBczJRU1VNcVg0dUZWcmgyTHRmcmZDS3JabGVZRGFn?=
 =?utf-8?B?OHJkNmlwK2FjanpYT0ppaTBpaThvVng5MCttaFVyYTdDR21yZ3d5SHprVWlV?=
 =?utf-8?B?WnF6S3VZZGNyYWhCckoxMGlTbzRoOWxHdklLRmVtR1I2VnVjWE5zUytIdTUv?=
 =?utf-8?B?dHJ2cEREM3ZjRCtjUjhSck82eUt2aVhLUDkxZUZ1K2xGeURUUEZ2V2JSOTRZ?=
 =?utf-8?B?bFVSTWRNUGlEcG45OXJJK1FlL1lkWmNOU3ZJUFdZeEdFcnJUR2MyM2VQYkMx?=
 =?utf-8?B?RHZrV0x1TUh1eUo1ZDFyMEhIOTdjN3h3SC9IQzFJVlJwUnJFS0pwQkRxVTZG?=
 =?utf-8?B?WW96TjRCYXpqdFJFempNV0RlZTJyUXg5QXE3ck5PMktCclZRbGVWNXM0RG5t?=
 =?utf-8?B?VkY4SmpXdmxXZlMwVzVEekY0OGNwTmdwbkNuRGFSWWUzSTJkQTAxb3l3eHM1?=
 =?utf-8?B?VktOd0hpd3czL1VyYWZoUXBZUCtjUFJ3YzUvUDdwZm5UUjlZb0JXUzJCVERH?=
 =?utf-8?B?bHMvOTlqcmVoL2M2STM5TWtKaGJvdW5HL005R0dXRWEweHpSMWltYmR5Ylhr?=
 =?utf-8?B?c3hTTXRVdjlQc0VHQkxjaG0weFV3VTdYZEN3TWVMUEdyb25FNXcxN1FvaVZs?=
 =?utf-8?B?UTRTbC9VUGR5dml3dWpkSlhEdkFtOFBWeU5LUkMwNWkwZlJFdFdaMHVTRDEw?=
 =?utf-8?B?QUprT3dOS09tUVYzZDF6djRPUXloNVI5amRxTjBvcG1HN2dBWWpmOUxHRFor?=
 =?utf-8?B?b2c2anRhTGpNQ2ljUFJOWDBKLytBSGdqaHRkSGZuWDEzQ1hRWEY0NThNb1Bu?=
 =?utf-8?B?QmJaak1DWXRzR2FoNnRwK2h3SVc5dmQ2L3dRU3o5dDY5TG93VjRFVldhRDBT?=
 =?utf-8?B?cTJNNk1aYkExK3ZVMGZUZHVSZzlyZTczaStVZ0k3OEw2bUdWVURldUtsZDZB?=
 =?utf-8?B?SE90azdZMEV1aE1peWszS0xsNXJEVC9qS1VGTG4zWVh1R0hZZXZzeVdIWnJV?=
 =?utf-8?B?U0w5RjhtNFhKNDRCTjlSQzFuekI2VUJoazRRYlBxWHJlZWtLdFFBM2htNmYr?=
 =?utf-8?B?dXgzeDBSMVQ5WlpXUlVBVlJoWFZJNXJpVFBHS0IxSjI3dzdtTWVMQi84SlV0?=
 =?utf-8?B?UVVlTDBSNE4vUWdNNW9LMTNNMnhrRXdTc0k5SmloRDJINDc4QWVLQmVIdTZk?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2ADmfG8XMY1uQawmjl1XODUEChKLXRENAnUycBu87N9FrXDMUj/ms/sDKktNIqqZkCcT2eSjdZq5iK8nhOXzIu+a3YcssdE4twRV0qigBZUtQaudeN9UjYOmDQ5GuxbCc/gVLXfBon9ao5rTTcGdr6vLOUvxNB4b/v9kiaC06bEEwM0kb/NBOX42IUxqMKaXREhdocWsLwcgN9FR2K33DaCnQfExtUiDYQPC6PPgFoNJ8q3blzUpbWeiaeKYeWz8y30i5vacYA9EATIB6vwXD4bVWmT5eFJoUUFnqDgU5qAAQQu6kpeRS911+ad/z0R9ck0JO2mqhmka5N1rjUrL1eJg/jTkFMisHGTSB4fyXEZztaPmSpRDYK8fIDptFrf8F2FiQl7gHWv0ALPpcKjMmyXCbWyRooC0nyVZbgAZl2sIeEQCWOwjk0ow1iHqZOgJTKlYb/Spms5K6HxVe8krK9Ab3xzGPA5F14yeH6CbIZ3+7EWsE6+UEriuC5G0Fc9Si9+zOMWjxeuM2ynmIeuKL4xNrbzU7QeysKN9MqR5u5SlwcBSQN2xzXV5zxkniDLjI5iiJ4Ki9UHgGixCYGYKC3xq5Rn0Kq/XbmMOpmhYnV0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19af907d-b2bf-4835-7864-08dd94bd08a2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 21:02:57.4082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46QvWRjFY3cbcB75fbjIjN7DiJ9JEjlfrK/zJ60hr4LCYxPARC7Kyo8cYkI05DtHcifZTEJT/ku4byrTMheALFgOacJtULnlLtBTbclswm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5157
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_07,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505160206
X-Proofpoint-ORIG-GUID: Otx66deWuhfMzHDwIruPzlRlfSXCuqfb
X-Authority-Analysis: v=2.4 cv=R8YDGcRX c=1 sm=1 tr=0 ts=6827a818 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=x8RFK78e1JvtkfpMQJ8A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13185
X-Proofpoint-GUID: Otx66deWuhfMzHDwIruPzlRlfSXCuqfb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDIwNSBTYWx0ZWRfX1d91RIXaCK+2 s48AweSyQcZTXTAW61T6BAZuDE2qcetmc60XCkZarqllGBACy+nepSmGTjvDNZ3mGJBYYq8wrOa mP1WEUzaQQn90AO2pRTWgow/6qCZFuEpvlOgncxLZ1immcaOltv/RdVyZsFW2jgsVLfEXoBxV+Q
 MQMleFNplraZQdGsMgNyjGMEUaYhO+vgl7Cz3Y+7p27cmUNF+zin/yFDz0UkNkyizKXUOUssRot V6OlVAI8wXU1OO5tQC7mKp4zBH3tAla7F7bW8SiiAbp/n7ot8Qw/FF4t0tJ2DTCJGkVWeclGwXg p4LtHkWMy+tbh4iteDSiuaoGQGi3+OfGb68LDc6AGwB8xTcF/39Ra/K7gCo4Rr3SDegC2gzfBxU
 Yc74EWN6H7aJeZQ05M6KN8ZqLmLrqWzo6OJhxotasJcQBQkH0Sdhj36IYakyo2gY2LxGc0/N



On 16-05-2025 23:11, Philipp Stanner wrote:
> pcim_enable_device() is not related anymore to switching the mode of
> operation of any functions. It merely sets up a devres callback for
> automatically disabling the PCI device on driver detach.
> 
> Adjust the function's documentation.
> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>   Documentation/driver-api/driver-model/devres.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> index d75728eb05f8..9443911c4742 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -391,7 +391,7 @@ PCI
>     devm_pci_remap_cfgspace()	: ioremap PCI configuration space
>     devm_pci_remap_cfg_resource()	: ioremap PCI configuration space resource
>   
> -  pcim_enable_device()		: after success, some PCI ops become managed
> +  pcim_enable_device()		: after success, PCI dev gets deactivated automatically

PCI dev -> PCI device
something like this if work ?"after success, PCI device disables 
automatically once driver detaches"

>     pcim_iomap()			: do iomap() on a single BAR
>     pcim_iomap_regions()		: do request_region() and iomap() on multiple BARs
>     pcim_iomap_table()		: array of mapped addresses indexed by BAR


Thanks,
Alok

