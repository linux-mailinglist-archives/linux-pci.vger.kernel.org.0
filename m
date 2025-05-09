Return-Path: <linux-pci+bounces-27468-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F60AB0718
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 02:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E1F1C23158
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 00:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE31C4C7F;
	Fri,  9 May 2025 00:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=llnl.gov header.i=@llnl.gov header.b="JfTTjB3k";
	dkim=pass (1024-bit key) header.d=doellnl.onmicrosoft.com header.i=@doellnl.onmicrosoft.com header.b="WEG+bjkI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0e-00379502.gpphosted.com (mx0e-00379502.gpphosted.com [67.231.147.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFE7BA4A;
	Fri,  9 May 2025 00:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.147.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746750783; cv=fail; b=Rys7jnKiqPN4+1srP/bPNP49QcYNBF+x3MTkbKchZO5eJzQ7TOlgFLJiBoTjA2iejmP+imxkdJDL1yb/fbUqqStk1mvY+VHQ9w5L+yD9rn+CW1bTS5IPupDPszMHrEVJNusI7AeqQ2ughgY8z7A+Nm184wl2gOPrtoROTlaoVts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746750783; c=relaxed/simple;
	bh=HDnVwrIjHPUSuSjsVOtXJcK2aUV4NEY0qEO2Xs6wNpw=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=WUDOHXWaiCpttA9S9JzWrMWYHMqmxOmWgTbPtV8n6owMkysD4JNZxEgB64xXVW9Q81FHob8buaBuJbfldgePoFaj7zfOCJCdQcUURquLvpLZR+JtedgI0pKAKOUDzwaO0QT3m2ffOiKK8QP6kie74CpRpqBH5qywCxM+bPFsaZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=llnl.gov; spf=pass smtp.mailfrom=llnl.gov; dkim=pass (2048-bit key) header.d=llnl.gov header.i=@llnl.gov header.b=JfTTjB3k; dkim=pass (1024-bit key) header.d=doellnl.onmicrosoft.com header.i=@doellnl.onmicrosoft.com header.b=WEG+bjkI; arc=fail smtp.client-ip=67.231.147.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=llnl.gov
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=llnl.gov
Received: from pps.filterd (m0218361.ppops.net [127.0.0.1])
	by mx0f-00379502.gpphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54909cwk026934;
	Thu, 8 May 2025 17:21:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=llnl.gov; h=message-id : date : to
 : cc : from : subject : content-type : content-transfer-encoding :
 mime-version; s=02022021-podllnl;
 bh=N4cSfufwV4qBx3t22Qm/g5UbMIwMmSj+Tw80HhRsLFo=;
 b=JfTTjB3kRcrV8g1GCxtGNwXjhrULkxtOVtkQhrGEg0RhjTR/9rwB8ZF7KCHr5EULQnwA
 J6FVRaJ0GM83Zqzh91/fMPaCX8IJRjPYEFqw3i2aEhUnb4/JQQVIq3U3EVgbLBLKmEet
 LjyaOLt6tL7JTUNXKlSoDVzgjkkVzs6nNCbIFUxggXVBs0k9u2+xO16lclRL/HsSdWSL
 nBevgCvAGuzLYHPZ8xcM/XTSoXd0Q6a5MzH3wi5js8+DHXsbhdbfrsPeoHmq97AOJg/Z
 qVaXZIIImJBcXPTGhU0ikxYyt+Yyi8m6lOuvHVirVvx1V9k9Yt8CtmFdYzMVvyK15Ijs ew== 
Received: from sa9pr09cu002.outbound.protection.outlook.com (mail-southcentralusazlp17010022.outbound.protection.outlook.com [40.93.14.22])
	by mx0f-00379502.gpphosted.com (PPS) with ESMTPS id 46gehpjq3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 17:21:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvXS7aj7PhsdMAzK1RzIiXHSfdKs+NNS04yJY8j7TMg5zdlriJQewPXdFPfS/KLM0sKC9DMw1+A2uwkcJ7W1dQ5icTdjMt+6hR1mA3Ei4Iu6uXUkPM+mJ/FqVFuN6eEWmR7uJ0oxZE3+1ECk15OEtu87hbigEf74tvLdOK1w/aOz1eQ4fx/yp0ZTQMgkjtFrehYps5/g+CCOfl/8A0djAwYrQvoH0SM5diDEGqsmF0pW9wNmI5a5Y6a3X4smKRFDAOYa36QaxTzqOUqKcPYVQQuBXPOQBlm+Ox+jkZ3E30aBYnd0ACn02Rweil57qhW2bycg5iJPJM2B7mWkHPLa8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4cSfufwV4qBx3t22Qm/g5UbMIwMmSj+Tw80HhRsLFo=;
 b=j18fxUtpQohaAeyrNobRAm+ftYrnQ8srtkw/6DviwtU9BTQG8EdkIJDjOe1DhmE2JOwlbcreAkVW5HFR19RimDifTr/iR+J7jOP5u4TfJCHJOvfTOcj35IW+WH8kEh9vF9BFu3P3HoSs0ERbss16ahMr4oW5TS8gJJDRHA8h4qA5meA+sn8ZbGR9zv0JMVHgPElaCLw2IS5ZTthw63kqcqSHj6BqNZaha9L9W3Lecp0UhpEyfjoSW58uUr19WDIOspsXo3ScpK1+X0X743cpIOU6bsnSd6nEGzUlRxCWeFrTacCBvsj9dqImXUfOWZtMD0LlfetmLiOZeonI9CXKkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=llnl.gov; dmarc=pass action=none header.from=llnl.gov;
 dkim=pass header.d=llnl.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=doellnl.onmicrosoft.com; s=selector1-doellnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4cSfufwV4qBx3t22Qm/g5UbMIwMmSj+Tw80HhRsLFo=;
 b=WEG+bjkI2OJH1wH3qnefklrSH9SwHALeE8StjP+0qIEM2+w2k4IY+Qa6TJMpvmIFM29zlhyHFFH7lbsHc6x163RJsuks99ajzF/8WIhdJLOLQoNE2mcDNE2R63q4WSOEYzcB2H2Vun6ugNtzAxAgXin5iNkSBTUvJ6W+74BVxqg=
Received: from BY3PR09MB8834.namprd09.prod.outlook.com (2603:10b6:a03:346::22)
 by PH0PR09MB10416.namprd09.prod.outlook.com (2603:10b6:510:2c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Fri, 9 May
 2025 00:21:26 +0000
Received: from BY3PR09MB8834.namprd09.prod.outlook.com
 ([fe80::9fcf:fc76:1d:f39]) by BY3PR09MB8834.namprd09.prod.outlook.com
 ([fe80::9fcf:fc76:1d:f39%2]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 00:21:26 +0000
Message-ID: <553813b6-1d44-488c-b41b-4be08e1c1733@llnl.gov>
Date: Thu, 8 May 2025 17:21:24 -0700
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        mariusz.tkaczyk@linux.intel.com, minyard@acm.org
Cc: linux-pci@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Tony Hutter <hutter2@llnl.gov>
Subject: [PATCH v3 RESEND] PCI: Introduce Cray ClusterStor E1000 NVMe slot LED
 driver
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:180::44) To BY3PR09MB8834.namprd09.prod.outlook.com
 (2603:10b6:a03:346::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY3PR09MB8834:EE_|PH0PR09MB10416:EE_
X-MS-Office365-Filtering-Correlation-Id: b7cb13de-6905-415b-1e5d-08dd8e8f6fa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUgzeTZjSDVUOUxqZ0F4YVpveEw5Nmo4M2dPRENYTDM0OSs4dkRBUTM3VzZ6?=
 =?utf-8?B?c0RhUGgxMUFSeUVHdmRoaHFUQko2MlpuV1IvY3A3ejZDOEZoV1Vac0lQYXYx?=
 =?utf-8?B?YmtxazZEaGQra2FxR3R6N2Rrenlzd0hOblhqS3k1WUp5d2EvN29vclpXTFRH?=
 =?utf-8?B?c1p1ZDRyUTdZMnJoczBDUXFNVXlqM0dXVU5aOC9Kb0RxL3lyWUZoRkRkUEw3?=
 =?utf-8?B?VmhHWmZYMTVkK1YyalhUajZyR1prd3ZTWEJ2azhYakcvUVk0Z3NlYlJwZHM3?=
 =?utf-8?B?dnNZZ2J2dXcxeGFScVJoS1lvY2t2cEdHUldqWDBnMjlLTldWd21jS1pETTZE?=
 =?utf-8?B?bG4xOFVTbEozZW9QMVFkTEhIbnd6Y0ZuWndMcG9qbGl0MDdyTVhZdTFvYXBw?=
 =?utf-8?B?bGJDc0V1ZzU2N2NBWjBkQ0FxZmNPWmtZUXB2UDBsU2lLYVJ5WnhRdVVnRC92?=
 =?utf-8?B?L3ROUUpQNURqdUx5VVZXamtObGhkTk5jQnBwNTdudFh5K1orTmlFcE5nNWcx?=
 =?utf-8?B?YzVtQ0ZUK1loVk0vWDZtOENVYjNoOGhGdStLRHlEaUJDbHk4YUNEcFBTVTZ4?=
 =?utf-8?B?V3UvWHVnalhHdDlBRjJJZXhwTEZsS2Z3ZGhocUVsZGRnRzlQSnJiTWJnZDVP?=
 =?utf-8?B?L01yYkljMnJnMkhqRGM2NXcwMDFEallRQUxZSkNjeS9UQ010WG02Y2g4S3Yx?=
 =?utf-8?B?VTl0VlBVZ1FVMVdqMDJ1Q1RWcUFla1d1L0NBQitDeUVocDlDT0NqZ1JEUXVP?=
 =?utf-8?B?OXREcHJjaXBUaXJNUlZUR2RKdExYQ3ZtRTYvSTlMMHF3bFR1MStLTGVhTDFa?=
 =?utf-8?B?eXVPMGxESy9rMDRiS0hmb2cvSE9WNkZZcUpaRnEvYzBLTEtwWVRJM2N3MXFG?=
 =?utf-8?B?ektJN2FYSDRxa1RycHZBcjRsUGl5WjYyUzRkNUZPRXIxajdIdW1NSm8yNDhB?=
 =?utf-8?B?UHBEVUJBWERWZjF5ZHl3eUt4QnVPMFJEOW5lcHUrQ2IyNDRsMkVrcUlzeCto?=
 =?utf-8?B?R3pBZmVwNk1aVGtHajBEcjlSUytnUWh6NnhkcTRJZ216ZXhRWjVBZ1ZWUlFD?=
 =?utf-8?B?ajN5eHRrSkJPcjNRbm1LWitFNFE1VTJiWjVDakZlTVNHZFV1ME5iUDZzd3RX?=
 =?utf-8?B?enZCeTA4clJuSFR4WGoxeEg1UWd0OFR2dW1IMEQybkZwNXZUcHVJd2R2SVl3?=
 =?utf-8?B?QWpab2krREVNUkdzS1hScVYwcVV2T2ZpQ3I1MWxmS2hnRitib2g1dUpEOEdF?=
 =?utf-8?B?NFpUTStETlc0dWpGT1NmVWhzQ2lkYStNZ1REaFh2YXROVzQwUXgwWmFrdzZW?=
 =?utf-8?B?VERFbjV0Wm81WkM3WjhISTM2QUxsajAza1FpQmFtOFRMRXprZVA1TDRNZWto?=
 =?utf-8?B?QXdabE1NVU5iaGhQVHNEZnZvL1FPdDlmaHNvSTVjY0R4ODM4bTBoSDgvS2Rt?=
 =?utf-8?B?TDJoam1za21mV0FhRGd0M0JsdXNRSmhialBEY1lDT2tNTHFaK1MzbllaaVl5?=
 =?utf-8?B?VDU4bDhZZkJZUDFDOHAvT1hldnBRbzJ2T2JPcmhPTllVTU1GdW9tR3lZZ3JH?=
 =?utf-8?B?S29oZ2JxNENYOWdiS0F0RFFHdnJtRTAzYWdtY25TYkVYdTUxTkpySXJRcDVC?=
 =?utf-8?B?ajQwSDVFMXRjWEdkYWxTeCtHUGFqcDlxcnByekd1T09KNEMwRmo4aVNtTGRq?=
 =?utf-8?B?OEEzZmUxVEc0N1o5aWU0NkhQeGJzQlUvMDFFZFhSYVRFdy9GTTJGR0lTWGtH?=
 =?utf-8?B?VU9iU2NHOG5MYnlKM20wejV5TUlGT3V1UWcvbk5uaVpXVWVteVVVT0YvZFNU?=
 =?utf-8?B?bzVCdFZ2K1ZmeDY5dkxGNGdjUlJOTUxNMmRuQm9YeUhValFtc2czMkdIaWtk?=
 =?utf-8?B?VTlKenJVQlFBV3ZQWm50cWE4UFNyd3h2eDBCUUtVeHovQjNEUzIrZmswdVA1?=
 =?utf-8?Q?UAmE0tbKQS8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR09MB8834.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bllLUW1UTHVYck84bGt1Q1lzd0VuUHllVzhLcFVhSkJoRTFMMEFSQTJ0dVZa?=
 =?utf-8?B?VUg0VzBsR05qKzVxRDJlME13N01LcDdmaFg2TG03MzJOZVJEczBoK3FobHdL?=
 =?utf-8?B?WW9xZXpyemdBSkxNaFRzYlN3NGpScGwwSzRuYVQyQmtwK0tFRnBaT09NVDFi?=
 =?utf-8?B?MWQrZXVkSjZTQ1NOYVpMNnVCczVUS0REeklZN3hGWkozR3p1dm9QZGZ2VkRR?=
 =?utf-8?B?Qkg1ZWNKVExJeENMa1g0eG1DSGV2YVlpVUZXK0pjdnROR3hzQytlMVgvZHhq?=
 =?utf-8?B?K1hqNURMZ2wrUTlNazdWN2lyRkFQZHlIM3NHNGwweUM1RFR1Y0V5NGNXZVll?=
 =?utf-8?B?eFdLOHVQcUluUHB6WS9TM1VjMktOOEk5dFQ0dHExZzVJeDBIdjh4L01EbENs?=
 =?utf-8?B?b1MzNG9KNGVncXgzNHZWWEpNbllhaUJZcFJNbmUvT2dzV2FoT1F5MmhBUWlz?=
 =?utf-8?B?MFFVUVpaZ0Qxc1RqUU9CcGp1OTN1NFM2WnphZUVhQTFUbHVBUjJrQlFLVnZl?=
 =?utf-8?B?ZVBjSkoxS2NFTHI0aEFrWmFBbE1LMFIvNmpwMzBzQzhmVFRoaWtweFFqK1ZW?=
 =?utf-8?B?UmlVV2dKN0VVUkp6S2JLbkNOUnVqUGFaQjAwcVByQzZlWDRQbHdsZWhtZ1cr?=
 =?utf-8?B?Vzg4Vzc3M3R2V1pUYWhSL1VvK2o4YTZvZVBNczdqWXorQXNTbnVwZElvZ0U1?=
 =?utf-8?B?QW5IYXpFMldPbUlLam56M0YrZjUvR0pVMDY0MUh5VTNFZWxKUitIdkZ0dUpi?=
 =?utf-8?B?L1U2b3JxV3RiVnE4Q2NVekZpckFSNThmS2pILzNtY0J2amRNVDJNVTFsa0hr?=
 =?utf-8?B?Qk9aYXVrNFRGNGprNnkyM2Qwb2FuN3JpaHdyNERSaS9KWGFXWTk5T2VOSi9K?=
 =?utf-8?B?dTlIRk1OcHhhMXdKd0N3RTdyOU5kTWkxWHd4dGVpaXpMQnQ1MGF3d2ZiclRB?=
 =?utf-8?B?V3diSXNGcHpLSFVpSVNNenZyaXV3YTlTNmdwbDlVT2w3c1NyaWZRYk1QWXpY?=
 =?utf-8?B?MFdSb25QWmFNT1Q4T1lDQng3RlVobzZJaXFrbFY4elNBb29pZjN5V3gxVUpV?=
 =?utf-8?B?TytmbjY5aHZaSmpSTzRlV2REL25TbUZCdHppRDU5NjI4REJMNVhiZkFLYnpY?=
 =?utf-8?B?L1F3Z3BQbUtFK2hGMVZLcVQ0azBjTnRuRVZ3UVNtcUVNOW1qYy8vTjRYalYz?=
 =?utf-8?B?cWdDaDdQcE8vRFFpK2JYR2xSRGNpVUdHVHk3ZCtKeDdrcVRDa29KTFVGeEU3?=
 =?utf-8?B?Z1lKNGpIbmpTZXplV1BvRTJrVWEzM2ZlL3paR2V6TzdidGxLNWR5aXQyT3pR?=
 =?utf-8?B?V3RtVUFDMEd0UXh6MGdFdnBRNUhuMm9hRUwvVWptNjlPQ21LQ0M2NFplaysv?=
 =?utf-8?B?WXpqcDErdkh2MHFtZDFLbWR4aDJaREJCb2FtQTV4Q25KOUVjZ01tOWJUSWtH?=
 =?utf-8?B?bTh5WmpvNXovdWo5UVpxL0dTajQ2RzhaanpQNUI2OE44a3Nvckt3RWs2anRM?=
 =?utf-8?B?dGs3V1NuV3JFRkhib3RkdnRjVmhtT1RDdXFjem5VWWJudG9yalNTVHcwelho?=
 =?utf-8?B?eWxFZWVzQ1g3Z0ZjMVl0bnFJbFBaV2FTUmhtK1NsUURkbmJBL0VhVlk0bHhG?=
 =?utf-8?B?RWNqS2NuQ2hpUHc3TFM4QkdhZGEwUWx3eHBRVS80d0JxUFUvVWZMd0dlTHJK?=
 =?utf-8?B?ZGZMYjFmT2dPUkNTUXdGNzF2QjMvR0lXQWpadmI2aG9UN3p5VFNsOWRxaWFs?=
 =?utf-8?B?blZGcGNUMGFqQlUwKzBlaEVFTkdWNWJsK2Jnc0FCcGhoWnE5S2VGa2pyN04z?=
 =?utf-8?B?Q1JjQklVajI1UnM1THFwaTQxWFFZWDdSUmVDSC9jSnkyVjB5bXI4cCtsRmpP?=
 =?utf-8?B?ZCtObEdKUDZFc20zQlNvTmgzZCt4L3ZhVnE0azFBb0haWkxxZHpPOGo2Q2l5?=
 =?utf-8?B?MnlTQkpPRW15Qk9XYUNPcGlFYmovcFEzdWtFV01EcDNudDRCTDNkNVpzUCtN?=
 =?utf-8?B?S0tSOHJRMzZDQWlqcFltMUtaVjZmbHpGM0FYZE5Pa3VsRC9DMDV4UGtOUkZC?=
 =?utf-8?B?aXZCaEJVN2NuNUJ2NzQxTm41OEhKTDk1TWR2UGFTWFdBcWJYd29SS1hHRVpy?=
 =?utf-8?Q?lFfunfkgDbaqw0cMWh0+2ffzg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xp1hR7hfaFKtISH/CdyHEoVs055uVPyn1O6rT17S/7CHCZwX98t8jSfjvHbeTkCMIGO6eQt6XPZmNzqnIgNL+1oHXP+Px+d6J/ye1cVLKxt9JPK6sblS1DWsa/kFLofttHagEjiMd6HBXsp/3bmLCy0tng9E/8mMyNSfPh6dh0wkZoDXNd6++pi5Yav9e7DqnA+lvBGruaG2qTJrgR3ks1+7iFir45ZWtQxFHJkFBwgEkqn0M0lrfBCQnUlftvNspZzq26yKseoORnGqKtJ7FDZTGM4ke/BTqFpQjhIgBNzMPe3ICsjmZP4Fe0Cfq6OaGgWwu0/c6L6IvKqezRU+I5n1m5Z64MDFVhR9Xh7GMiNa3TZNjcA9DuO7BKj5m7r+PlW0QcmSFG8Pfzo+hk1hk8bsIZbeY27q+FqeLIHgLN4zURYugC9IOM8pHT7CaxJK5rCM8HF9cr82jZT59qFjfXWHfI2h7L4AZgE4NvYs9qQ2gBQon1wh+1BXzavtn+2/D9jPIV8kRZQXLfPKtDtty9VcFQQ243V6cUQGlJjzH0aOJH1RZv6XlCPTk60ikB6IUhh6SDf/5ArpgrsC87idlR5VAJ3ywGjGM35xWyBIyxdgNSObMogXHvkqcgTNiB55oT2wLzNyDpnzRD1MWwUFmg==
X-OriginatorOrg: llnl.gov
X-MS-Exchange-CrossTenant-Network-Message-Id: b7cb13de-6905-415b-1e5d-08dd8e8f6fa9
X-MS-Exchange-CrossTenant-AuthSource: BY3PR09MB8834.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 00:21:26.3227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a722dec9-ae4e-4ae3-9d75-fd66e2680a63
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR09MB10416
X-Proofpoint-GUID: cd8XB8dxdDpmLckhyNXU3atMYwY4A_yd
X-Proofpoint-ORIG-GUID: cd8XB8dxdDpmLckhyNXU3atMYwY4A_yd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDAwMSBTYWx0ZWRfX11Dvx5oQEOyu brIg4uJH5Kied/QiZpCpfTOhT/v2+2sd+vz/bswyP9Y2Z1ARGHkMCLKIQqO5euu+GdMd9DokAIz hW0VwdqI12DChescUwte2g0eQspmlLf3BzNBLUpmBzkESUL1GZl2CY8Bv6QvgYvlJeHUv0XYOhk
 T0XtTOZt09XTTEenkc4s8lz9fLeNgPVmj9BNI1IgyMr1+DAIOhWLUl6ueGRP7lIMIBwCoOxxu28 c3IDz2e0BsnzPkkWFz6vMZfWz1pyOiJNR8fCj9Zt4At0Aooke+Z6VPsnqi8c+hMdLsXUd0VQ/UB axmEc3npy4wXph+ZT5ze3Zu1XAQV0nf3mPc57R0rulmPMOtHdsxW4nkvkV7kqgvSmf4Kdc4VbCx wSLPNNNW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_08,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 phishscore=0 clxscore=1011 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505090001

Add driver to control the NVMe slot LEDs on the Cray ClusterStor E1000.
The driver provides hotplug attention status callbacks for the 24 NVMe
slots on the E1000.  This allows users to access the E1000's locate and
fault LEDs via the normal /sys/bus/pci/slots/<slot>/attention sysfs
entries.  This driver uses IPMI to communicate with the E1000 controller
to toggle the LEDs.

Signed-off-by: Tony Hutter <hutter2@llnl.gov>
---
Changes in v3:
 - Add 'attention' values in Documentation/ABI/testing/sysfs-bus-pci.
 - Remove ACPI_PCI_SLOT dependency.
 - Cleanup craye1k_do_message() error checking.
 - Skip unneeded memcpy() on failure in __craye1k_do_command().
 - Merge craye1k_do_command_and_netfn() code into craye1k_do_command().
 - Make craye1k_is_primary() return boolean.
 - Return negative error code on failure in craye1k_set_primary().

Changes in v2:
 - Integrated E1000 code into the pciehp driver as an built-in
   extention rather than as a standalone module.
 - Moved debug tunables and counters to debugfs.
 - Removed forward declarations.
 - Kept the /sys/bus/pci/slots/<slot>/attention interface rather
   than using NPEM/_DSM or led_classdev as suggested.  The "attention"
   interface is more beneficial for our site, since it allows us to
   control the NVMe slot LEDs agnostically across different enclosure
   vendors and kernel versions using the same scripts.  It is also
   nice to use the same /sys/bus/pci/slots/<slot>/ sysfs directory for
   both slot LED toggling ("attention") and slot power control
   ("power").
---
 Documentation/ABI/testing/sysfs-bus-pci |  21 +
 MAINTAINERS                             |   5 +
 drivers/pci/hotplug/Kconfig             |  10 +
 drivers/pci/hotplug/Makefile            |   3 +
 drivers/pci/hotplug/pciehp.h            |   7 +
 drivers/pci/hotplug/pciehp_core.c       |  12 +
 drivers/pci/hotplug/pciehp_craye1k.c    | 659 ++++++++++++++++++++++++
 7 files changed, 717 insertions(+)
 create mode 100644 drivers/pci/hotplug/pciehp_craye1k.c

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 5da6a14dc326..1b83c43a548c 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -231,6 +231,27 @@ Description:
 		    - scXX contains the device subclass;
 		    - iXX contains the device class programming interface.
 
+What:		/sys/bus/pci/slots/.../attention
+Date:		February 2025
+Contact:	linux-pci@vger.kernel.org
+Description:
+		The attention attribute is used to read or write the attention
+		status for an enclosure slot.  This is often used to set the
+		slot LED value on a NVMe storage enclosure.
+
+		Common values:
+		0 = OFF
+		1 = ON
+		2 = blink (ampere, ibmphp, pciehp, rpaphp, shpchp)
+
+		Using the pciehp_craye1k extensions:
+		0 = fault LED OFF, locate LED OFF
+		1 = fault LED ON,  locate LED OFF
+		2 = fault LED OFF, locate LED ON
+		3 = fault LED ON,  locate LED ON
+
+		Other values are no-op, OFF, or ON depending on the driver.
+
 What:		/sys/bus/pci/slots/.../module
 Date:		June 2009
 Contact:	linux-pci@vger.kernel.org
diff --git a/MAINTAINERS b/MAINTAINERS
index 25c86f47353d..a33920820c62 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6122,6 +6122,11 @@ S:	Maintained
 F:	Documentation/filesystems/cramfs.rst
 F:	fs/cramfs/
 
+CRAY CLUSTERSTOR E1000 NVME SLOT LED DRIVER EXTENSIONS
+M:	Tony Hutter <hutter2@llnl.gov>
+S:	Maintained
+F:	drivers/pci/hotplug/pciehp_craye1k.c
+
 CRC LIBRARY
 M:	Eric Biggers <ebiggers@kernel.org>
 R:	Ard Biesheuvel <ardb@kernel.org>
diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index 123c4c7c2ab5..75c77cec0b21 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -183,4 +183,14 @@ config HOTPLUG_PCI_S390
 
 	  When in doubt, say Y.
 
+config HOTPLUG_PCI_PCIE_CRAY_E1000
+	bool "PCIe Hotplug extensions for Cray ClusterStor E1000"
+	depends on HOTPLUG_PCI_PCIE && IPMI_HANDLER=y
+	help
+	  Say Y here if you have a Cray ClusterStor E1000 and want to control
+	  your NVMe slot LEDs.  Without this driver is it not possible
+	  to control the fault and locate LEDs on the E1000's 24 NVMe slots.
+
+	  When in doubt, say N.
+
 endif # HOTPLUG_PCI
diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
index 40aaf31fe338..82a1f0592d0a 100644
--- a/drivers/pci/hotplug/Makefile
+++ b/drivers/pci/hotplug/Makefile
@@ -66,6 +66,9 @@ pciehp-objs		:=	pciehp_core.o	\
 				pciehp_ctrl.o	\
 				pciehp_pci.o	\
 				pciehp_hpc.o
+ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
+pciehp-objs		+=	pciehp_craye1k.o
+endif
 
 shpchp-objs		:=	shpchp_core.o	\
 				shpchp_ctrl.o	\
diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 273dd8c66f4e..ea68ae041547 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -198,6 +198,13 @@ int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
 
 int pciehp_slot_reset(struct pcie_device *dev);
 
+#ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
+int craye1k_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status);
+int craye1k_set_attention_status(struct hotplug_slot *hotplug_slot, u8 status);
+bool is_craye1k_slot(struct controller *ctrl);
+int craye1k_init(void);
+#endif
+
 static inline const char *slot_name(struct controller *ctrl)
 {
 	return hotplug_slot_name(&ctrl->hotplug_slot);
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ff458e692fed..9a7a7b320810 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -73,6 +73,13 @@ static int init_slot(struct controller *ctrl)
 		ops->get_attention_status = pciehp_get_raw_indicator_status;
 		ops->set_attention_status = pciehp_set_raw_indicator_status;
 	}
+#ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
+	if (is_craye1k_slot(ctrl)) {
+		/* slots 1-24 on Cray E1000s are controlled differently */
+		ops->get_attention_status = craye1k_get_attention_status;
+		ops->set_attention_status = craye1k_set_attention_status;
+	}
+#endif
 
 	/* register this slot with the hotplug pci core */
 	ctrl->hotplug_slot.ops = ops;
@@ -404,6 +411,11 @@ int __init pcie_hp_init(void)
 	pr_debug("pcie_port_service_register = %d\n", retval);
 	if (retval)
 		pr_debug("Failure to register service\n");
+#ifdef CONFIG_HOTPLUG_PCI_PCIE_CRAY_E1000
+	retval = craye1k_init();
+	if (retval)
+		pr_debug("Failure to register Cray E1000 extensions");
+#endif
 
 	return retval;
 }
diff --git a/drivers/pci/hotplug/pciehp_craye1k.c b/drivers/pci/hotplug/pciehp_craye1k.c
new file mode 100644
index 000000000000..844b36882316
--- /dev/null
+++ b/drivers/pci/hotplug/pciehp_craye1k.c
@@ -0,0 +1,659 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022-2024 Lawrence Livermore National Security, LLC
+ */
+/*
+ * Cray ClusterStor E1000 hotplug slot LED driver extensions
+ *
+ * This driver controls the NVMe slot LEDs on the Cray ClusterStore E1000.
+ * It provides hotplug attention status callbacks for the 24 NVMe slots on
+ * the E1000.  This allows users to access the E1000's locate and fault
+ * LEDs via the normal /sys/bus/pci/slots/<slot>/attention sysfs entries.
+ * This driver uses IPMI to communicate with the E1000 controller to toggle
+ * the LEDs.
+ *
+ * This driver is based off of ibmpex.c
+ */
+
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/dmi.h>
+#include <linux/ipmi.h>
+#include <linux/ipmi_smi.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pci_hotplug.h>
+#include <linux/random.h>
+#include "pciehp.h"
+
+/* Cray E1000 commands */
+#define CRAYE1K_CMD_NETFN       0x3c
+#define CRAYE1K_CMD_PRIMARY     0x33
+#define CRAYE1K_CMD_FAULT_LED   0x39
+#define CRAYE1K_CMD_LOCATE_LED  0x22
+
+/* Subcommands */
+#define CRAYE1K_GET_LED		0x0
+#define CRAYE1K_SET_LED		0x1
+#define CRAYE1K_SET_PRIMARY		0x1
+
+/*
+ * Milliseconds to wait after get/set LED command.  200ms value found though
+ * experimentation
+ */
+#define	CRAYE1K_POST_CMD_WAIT_MS	200
+
+struct craye1k {
+	struct device *dev;   /* BMC device */
+	struct mutex lock;
+	struct completion read_complete;
+	struct ipmi_addr address;
+	struct ipmi_user *user;
+	int iface;
+
+	long tx_msg_id;
+	struct kernel_ipmi_msg tx_msg;
+	unsigned char tx_msg_data[IPMI_MAX_MSG_LENGTH];
+	unsigned char rx_msg_data[IPMI_MAX_MSG_LENGTH];
+	unsigned long rx_msg_len;
+	unsigned char rx_result;	/* IPMI completion code */
+
+	/* Parent dir for all our debugfs entries */
+	struct dentry *parent;
+
+	/* debugfs stats */
+	u64 check_primary;
+	u64 check_primary_failed;
+	u64 was_already_primary;
+	u64 was_not_already_primary;
+	u64 set_primary;
+	u64 set_initial_primary_failed;
+	u64 set_primary_failed;
+	u64 set_led_locate_failed;
+	u64 set_led_fault_failed;
+	u64 set_led_readback_failed;
+	u64 set_led_failed;
+	u64 get_led_failed;
+	u64 completion_timeout;
+	u64 wrong_msgid;
+	u64 request_failed;
+
+	/* debugfs configuration options */
+
+	/* Print info on spurious IPMI messages */
+	bool print_errors;
+
+	/* Retries for kernel IPMI layer */
+	u32 ipmi_retries;
+
+	/* Timeout in ms for IPMI (0 = use IPMI default_retry_ms) */
+	u32 ipmi_timeout_ms;
+
+	/* Timeout in ms to wait for E1000 message completion */
+	u32 completion_timeout_ms;
+};
+
+/*
+ * Make our craye1k a global so get/set_attention_status() can access it.
+ * This is safe since there's only one node controller on the board, and so it's
+ * impossible to instantiate more than one craye1k.
+ */
+static struct craye1k *craye1k_global;
+
+/* Return parent dir dentry */
+static struct dentry *
+craye1k_debugfs_init(struct craye1k *craye1k)
+{
+	umode_t mode = 0644;
+	struct dentry *parent = debugfs_create_dir("pciehp_craye1k", NULL);
+
+	if (!parent)
+		return NULL;
+
+	debugfs_create_x64("check_primary", mode, parent,
+			   &craye1k->check_primary);
+	debugfs_create_x64("check_primary_failed", mode, parent,
+			   &craye1k->check_primary_failed);
+	debugfs_create_x64("was_already_primary", mode, parent,
+			   &craye1k->was_already_primary);
+	debugfs_create_x64("was_not_already_primary", mode, parent,
+			   &craye1k->was_not_already_primary);
+	debugfs_create_x64("set_primary", mode, parent,
+			   &craye1k->set_primary);
+	debugfs_create_x64("set_initial_primary_failed", mode, parent,
+			   &craye1k->set_initial_primary_failed);
+	debugfs_create_x64("set_primary_failed", mode, parent,
+			   &craye1k->set_primary_failed);
+	debugfs_create_x64("set_led_locate_failed", mode, parent,
+			   &craye1k->set_led_locate_failed);
+	debugfs_create_x64("set_led_fault_failed", mode, parent,
+			   &craye1k->set_led_fault_failed);
+	debugfs_create_x64("set_led_readback_failed", mode, parent,
+			   &craye1k->set_led_readback_failed);
+	debugfs_create_x64("set_led_failed", mode, parent,
+			   &craye1k->set_led_failed);
+	debugfs_create_x64("get_led_failed", mode, parent,
+			   &craye1k->get_led_failed);
+	debugfs_create_x64("completion_timeout", mode, parent,
+			   &craye1k->completion_timeout);
+	debugfs_create_x64("wrong_msgid", mode, parent,
+			   &craye1k->wrong_msgid);
+	debugfs_create_x64("request_failed", mode, parent,
+			   &craye1k->request_failed);
+
+	debugfs_create_x32("ipmi_retries", mode, parent,
+			   &craye1k->ipmi_retries);
+	debugfs_create_x32("ipmi_timeout_ms", mode, parent,
+			   &craye1k->ipmi_timeout_ms);
+	debugfs_create_x32("completion_timeout_ms", mode, parent,
+			   &craye1k->completion_timeout_ms);
+	debugfs_create_bool("print_errors", mode, parent,
+			    &craye1k->print_errors);
+
+	return parent;
+}
+
+/*
+ * craye1k_msg_handler() - IPMI message response handler
+ */
+static void craye1k_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data)
+{
+	struct craye1k *craye1k = user_msg_data;
+
+	if (msg->msgid != craye1k->tx_msg_id) {
+		craye1k->wrong_msgid++;
+		if (craye1k->print_errors) {
+			dev_warn_ratelimited(craye1k->dev, "rx msgid %d != %d",
+					     (int)msg->msgid,
+					     (int)craye1k->tx_msg_id);
+		}
+		ipmi_free_recv_msg(msg);
+		return;
+	}
+
+	/* Set rx_result to the IPMI completion code */
+	if (msg->msg.data_len > 0)
+		craye1k->rx_result = msg->msg.data[0];
+	else
+		craye1k->rx_result = IPMI_UNKNOWN_ERR_COMPLETION_CODE;
+
+	if (msg->msg.data_len > 1) {
+		/* Exclude completion code from data bytes */
+		craye1k->rx_msg_len = msg->msg.data_len - 1;
+		memcpy(craye1k->rx_msg_data, msg->msg.data + 1,
+		       craye1k->rx_msg_len);
+	} else {
+		craye1k->rx_msg_len = 0;
+	}
+
+	ipmi_free_recv_msg(msg);
+
+	complete(&craye1k->read_complete);
+}
+
+static const struct ipmi_user_hndl craye1k_user_hndl = {
+	.ipmi_recv_hndl = craye1k_msg_handler
+};
+
+static void craye1k_new_smi(int iface, struct device *dev)
+{
+	int rc;
+	struct craye1k *craye1k;
+
+	/* There's only one node controller so driver data should not be set */
+	WARN_ON(craye1k_global);
+
+	craye1k = kzalloc(sizeof(*craye1k), GFP_KERNEL);
+	if (!craye1k)
+		return;
+
+	craye1k->address.addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
+	craye1k->address.channel = IPMI_BMC_CHANNEL;
+	craye1k->iface = iface;
+	craye1k->dev = dev;
+	craye1k->tx_msg.data = craye1k->tx_msg_data;
+	craye1k->ipmi_retries = 4;
+	craye1k->ipmi_timeout_ms = 500;
+	craye1k->completion_timeout_ms = 300;
+
+	init_completion(&craye1k->read_complete);
+	mutex_init(&craye1k->lock);
+
+	dev_set_drvdata(dev, craye1k);
+
+	rc = ipmi_create_user(craye1k->iface, &craye1k_user_hndl, craye1k,
+			      &craye1k->user);
+	if (rc < 0) {
+		dev_err_ratelimited(dev,
+				    "Unable to register IPMI user, iface %d\n",
+				    craye1k->iface);
+		kfree(craye1k);
+		dev_set_drvdata(dev, NULL);
+		return;
+	}
+
+	craye1k_global = craye1k;
+
+	craye1k->parent = craye1k_debugfs_init(craye1k);
+	if (!craye1k->parent)
+		dev_warn_ratelimited(dev, "Cannot create debugfs");
+
+	dev_info_ratelimited(dev,
+			     "Cray ClusterStor E1000 slot LEDs registered");
+}
+
+static void craye1k_smi_gone(int iface)
+{
+	pr_warn("craye1k: Got unexpected smi_gone, iface=%d", iface);
+}
+
+static struct ipmi_smi_watcher craye1k_smi_watcher = {
+	.owner = THIS_MODULE,
+	.new_smi = craye1k_new_smi,
+	.smi_gone = craye1k_smi_gone
+};
+
+/*
+ * craye1k_send_message() - Send the message already setup in 'craye1k'
+ *
+ * Context: craye1k->lock is already held.
+ * Return: 0 on success, non-zero on error.
+ */
+static int craye1k_send_message(struct craye1k *craye1k)
+{
+	int rc;
+
+	rc = ipmi_validate_addr(&craye1k->address, sizeof(craye1k->address));
+	if (rc) {
+		dev_err_ratelimited(craye1k->dev, "validate_addr() = %d\n", rc);
+		return rc;
+	}
+
+	craye1k->tx_msg_id++;
+
+	rc = ipmi_request_settime(craye1k->user, &craye1k->address,
+				  craye1k->tx_msg_id, &craye1k->tx_msg, craye1k,
+				  0, craye1k->ipmi_retries,
+				  craye1k->ipmi_timeout_ms);
+
+	if (rc) {
+		craye1k->request_failed++;
+		return rc;
+	}
+
+	return 0;
+}
+
+/*
+ * craye1k_do_message() - Send the message in 'craye1k' and wait for a response
+ *
+ * Context: craye1k->lock is already held.
+ * Return: 0 on success, non-zero on error.
+ */
+static int craye1k_do_message(struct craye1k *craye1k)
+{
+	int rc;
+	struct completion *read_complete = &craye1k->read_complete;
+	unsigned long tout = msecs_to_jiffies(craye1k->completion_timeout_ms);
+
+	rc = craye1k_send_message(craye1k);
+	if (rc)
+		return rc;
+
+	rc = wait_for_completion_killable_timeout(read_complete, tout);
+	if (rc == 0) {
+		/* timed out */
+		craye1k->completion_timeout++;
+		return -ETIME;
+	}
+
+	return 0;
+}
+
+/*
+ * __craye1k_do_command() - Do an IPMI command
+ *
+ * Send a command with optional data bytes, and read back response bytes.
+ * Context: craye1k->lock is already held.
+ * Returns: 0 on success, non-zero on error.
+ */
+static int __craye1k_do_command(struct craye1k *craye1k, u8 netfn, u8 cmd,
+				u8 *send_data, u8 send_data_len, u8 *recv_data,
+				u8 recv_data_len)
+{
+	int rc;
+
+	craye1k->tx_msg.netfn = netfn;
+	craye1k->tx_msg.cmd = cmd;
+
+	if (send_data) {
+		memcpy(&craye1k->tx_msg_data[0], send_data, send_data_len);
+		craye1k->tx_msg.data_len = send_data_len;
+	} else {
+		craye1k->tx_msg_data[0] = 0;
+		craye1k->tx_msg.data_len = 0;
+	}
+
+	rc = craye1k_do_message(craye1k);
+	if (rc == 0)
+		memcpy(recv_data, craye1k->rx_msg_data, recv_data_len);
+
+	return rc;
+}
+
+/*
+ * craye1k_do_command() - Do a Cray E1000 specific IPMI command.
+ * @cmd: Cray E1000 specific command
+ * @send_data:  Data to send after the command
+ * @send_data_len: Data length
+ *
+ * Context: craye1k->lock is already held.
+ * Returns: the last byte from the response or 0 if response had no response
+ * data bytes, else -1 on error.
+ */
+static int craye1k_do_command(struct craye1k *craye1k, u8 cmd, u8 *send_data,
+			      u8 send_data_len)
+{
+	int rc;
+
+	rc = __craye1k_do_command(craye1k, CRAYE1K_CMD_NETFN, cmd, send_data,
+				  send_data_len, NULL, 0);
+	if (rc != 0) {
+		/* Error attempting command */
+		return -1;
+	}
+
+	if (craye1k->tx_msg.data_len == 0)
+		return 0;
+
+	/* Return last received byte value */
+	return craye1k->rx_msg_data[craye1k->rx_msg_len - 1];
+}
+
+/*
+ * __craye1k_set_primary() - Tell the BMC we want to be the primary server
+ *
+ * An E1000 board has two physical servers on it.  In order to set a slot
+ * NVMe LED, this server needs to first tell the BMC that it's the primary
+ * server.
+ *
+ * Returns: 0 on success, non-zero on error.
+ */
+static int __craye1k_set_primary(struct craye1k *craye1k)
+{
+	u8 bytes[2] = {CRAYE1K_SET_PRIMARY, 1};	/* set primary to 1 */
+
+	craye1k->set_primary++;
+	return craye1k_do_command(craye1k, CRAYE1K_CMD_PRIMARY, bytes, 2);
+}
+
+/*
+ * craye1k_is_primary() - Are we the primary server?
+ *
+ * Returns: true if we are the primary server, false otherwise.
+ */
+static bool craye1k_is_primary(struct craye1k *craye1k)
+{
+	u8 byte = 0;
+	int rc;
+
+	/* Response byte is 0x1 on success */
+	rc = craye1k_do_command(craye1k, CRAYE1K_CMD_PRIMARY, &byte, 1);
+	craye1k->check_primary++;
+	if (rc == 0x1)
+		return true;   /* success */
+
+	craye1k->check_primary_failed++;
+	return false;   /* We are not the primary server node */
+}
+
+/*
+ * craye1k_set_primary() - Attempt to set ourselves as the primary server
+ *
+ * Returns: 0 on success, -1 otherwise.
+ */
+static int craye1k_set_primary(struct craye1k *craye1k)
+{
+	int tries = 10;
+
+	if (craye1k_is_primary(craye1k)) {
+		craye1k->was_already_primary++;
+		return 0;
+	}
+	craye1k->was_not_already_primary++;
+
+	/* delay found through experimentation */
+	msleep(300);
+
+	if (__craye1k_set_primary(craye1k) != 0) {
+		craye1k->set_initial_primary_failed++;
+		return -1;	/* error */
+	}
+
+	/*
+	 * It can take 2 to 3 seconds after setting primary for the controller
+	 * to report that it is the primary.
+	 */
+	while (tries--) {
+		msleep(500);
+		if (craye1k_is_primary(craye1k))
+			break;
+	}
+
+	if (tries == 0) {
+		craye1k->set_primary_failed++;
+		return -1;	/* never reported that it's primary */
+	}
+
+	/* Wait for primary switch to finish */
+	msleep(1500);
+
+	return 0;
+}
+
+/*
+ * craye1k_get_slot_led() - Get slot LED value
+ * @slot: Slot number (1-24)
+ * @is_locate_led: 0 = get fault LED value, 1 = get locate LED value
+ *
+ * Returns: slot value on success, -1 on failure.
+ */
+static int craye1k_get_slot_led(struct craye1k *craye1k, unsigned char slot,
+				bool is_locate_led)
+{
+	u8 bytes[2];
+	u8 cmd;
+
+	bytes[0] = CRAYE1K_GET_LED;
+	bytes[1] = slot;
+
+	cmd = is_locate_led ? CRAYE1K_CMD_LOCATE_LED : CRAYE1K_CMD_FAULT_LED;
+
+	return craye1k_do_command(craye1k, cmd, bytes, 2);
+}
+
+/*
+ * craye1k_set_slot_led() - Attempt to set the locate/fault LED to a value
+ * @slot: Slot number (1-24)
+ * @is_locate_led: 0 = use fault LED, 1 = use locate LED
+ * @value: Value to set (0 or 1)
+ *
+ * Check the LED value after calling this function to ensure it has been set
+ * properly.
+ *
+ * Returns: 0 on success, non-zero on failure.
+ */
+static int craye1k_set_slot_led(struct craye1k *craye1k, unsigned char slot,
+				unsigned char is_locate_led,
+				unsigned char value)
+{
+	u8 bytes[3];
+	u8 cmd;
+
+	bytes[0] = CRAYE1K_SET_LED;
+	bytes[1] = slot;
+	bytes[2] = value;
+
+	cmd = is_locate_led ? CRAYE1K_CMD_LOCATE_LED : CRAYE1K_CMD_FAULT_LED;
+
+	return craye1k_do_command(craye1k, cmd, bytes, 3);
+}
+
+static int __craye1k_get_attention_status(struct hotplug_slot *hotplug_slot,
+					  u8 *status, bool set_primary)
+{
+	unsigned char slot;
+	int locate, fault;
+	struct craye1k *craye1k;
+
+	craye1k = craye1k_global;
+	slot = PSN(to_ctrl(hotplug_slot));
+
+	if (set_primary) {
+		if (craye1k_set_primary(craye1k) != 0) {
+			craye1k->get_led_failed++;
+			return -EIO;
+		}
+	}
+
+	locate = craye1k_get_slot_led(craye1k, slot, true);
+	if (locate == -1) {
+		craye1k->get_led_failed++;
+		return -EINVAL;
+	}
+	msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+	fault = craye1k_get_slot_led(craye1k, slot, false);
+	if (fault == -1) {
+		craye1k->get_led_failed++;
+		return -EINVAL;
+	}
+	msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+	*status = locate << 1 | fault;
+
+	return 0;
+}
+
+int craye1k_get_attention_status(struct hotplug_slot *hotplug_slot,
+				 u8 *status)
+{
+	int rc;
+	struct craye1k *craye1k;
+
+	craye1k = craye1k_global;
+
+	if (mutex_lock_interruptible(&craye1k->lock) != 0)
+		return -EINTR;
+
+	rc =  __craye1k_get_attention_status(hotplug_slot, status, true);
+
+	mutex_unlock(&craye1k->lock);
+	return rc;
+}
+
+int craye1k_set_attention_status(struct hotplug_slot *hotplug_slot,
+				 u8 status)
+{
+	unsigned char slot;
+	int tries = 4;
+	int rc;
+	u8 new_status;
+	struct craye1k *craye1k;
+	bool locate, fault;
+
+	craye1k = craye1k_global;
+
+	slot = PSN(to_ctrl(hotplug_slot));
+
+	if (mutex_lock_interruptible(&craye1k->lock) != 0)
+		return -EINTR;
+
+	/* Retry to ensure all LEDs are set */
+	while (tries--) {
+		/*
+		 * The node must first set itself to be the primary node before
+		 * setting the slot LEDs (each board has two nodes, or
+		 * "servers" as they're called by the manufacturer).  This can
+		 * lead to contention if both nodes are trying to set the LEDs
+		 * at the same time.
+		 */
+		rc = craye1k_set_primary(craye1k);
+		if (rc != 0) {
+			/* Could not set as primary node.  Just retry again. */
+			continue;
+		}
+
+		/* Write value twice to increase success rate */
+		locate = (status & 0x2) >> 1;
+		craye1k_set_slot_led(craye1k, slot, 1, locate);
+		if (craye1k_set_slot_led(craye1k, slot, 1, locate) != 0) {
+			craye1k->set_led_locate_failed++;
+			continue;	/* fail, retry */
+		}
+
+		msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+		fault = status & 0x1;
+		craye1k_set_slot_led(craye1k, slot, 0, fault);
+		if (craye1k_set_slot_led(craye1k, slot, 0, fault) != 0) {
+			craye1k->set_led_fault_failed++;
+			continue;	/* fail, retry */
+		}
+
+		msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+		rc = __craye1k_get_attention_status(hotplug_slot, &new_status,
+						    false);
+
+		msleep(CRAYE1K_POST_CMD_WAIT_MS);
+
+		if (rc == 0 && new_status == status)
+			break;	/* success */
+
+		craye1k->set_led_readback_failed++;
+
+		/*
+		 * At this point we weren't successful in setting the LED and
+		 * need to try again.
+		 *
+		 * Do a random back-off to reduce contention with other server
+		 * node in the unlikely case that both server nodes are trying to
+		 * trying to set a LED at the same time.
+		 *
+		 * The 500ms minimum in the back-off reduced the chance of this
+		 * whole retry loop failing from 1 in 700 to none in 10000.
+		 */
+		msleep(500 + (get_random_long() % 500));
+	}
+	mutex_unlock(&craye1k->lock);
+	if (tries == 0) {
+		craye1k->set_led_failed++;
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static bool is_craye1k_board(void)
+{
+	return dmi_match(DMI_PRODUCT_NAME, "VSSEP1EC");
+}
+
+bool is_craye1k_slot(struct controller *ctrl)
+{
+	return (PSN(ctrl) >= 1 && PSN(ctrl) <= 24 && is_craye1k_board());
+}
+
+int craye1k_init(void)
+{
+	if (!is_craye1k_board())
+		return 0;
+
+	return ipmi_smi_watcher_register(&craye1k_smi_watcher);
+}
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Tony Hutter <hutter2@llnl.gov>");
+MODULE_DESCRIPTION("Cray E1000 NVMe Slot LED driver");
-- 
2.43.5

