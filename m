Return-Path: <linux-pci+bounces-36154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 310E4B57CDA
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 15:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E951AA09AF
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 13:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5DC2FA0F1;
	Mon, 15 Sep 2025 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hNLZEoWK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X9bFoy9t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7EE2C027C;
	Mon, 15 Sep 2025 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757942745; cv=fail; b=mgg9OVxv7TaQVUgz95RIjrHWXq539xFtXtV6iiz11aLw/FJhvJCw8rhCZzniPUf3DAyWC3SyTWgU81OWXGt/BWULwhDldZJm62yNd6DOTUio4BoaJSRGI1i3F0ysHyFkORgcHJ8kKLBx2bs3i0tyb3BhwbifFo40QcfnuDKYa08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757942745; c=relaxed/simple;
	bh=C4tIEGrv7Ecu8oLJUCSODtiaKfX0MYYT6dhOkHrNmVE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NZGBo1QDrAXKdGHL7qKXndjqG/ZfOZTDeJ0AVAR4lb4BOhc613j+CvfIxQO+oZn6TDApswRRK50XB1fD5RjlS6X57olOqv7fQrPgxeHwgPPBCpQPrRsG7sTfHl0QgYvNsdRHUCzqnFFeMoKWuuyK7wATlYQM0yRDNBfC1iRyiuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hNLZEoWK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X9bFoy9t; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FDBu96005240;
	Mon, 15 Sep 2025 13:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZnuffU36NOglzW0tJ3h7qPr923abV4TFsvU7ark+MjM=; b=
	hNLZEoWKp/ZWYs5HUN3fswyGrhbQk7MhtgZItHGP8PZQBRmDRCHbKolvqpfvxOBp
	Z8/vwbshQNnI6OPhRCbbTwRWk2DE/8YRHNuxwBs80uXy8Q/Gqu+2jjgevGLTAUMT
	nhszG3v5n8CZ78lOAb6bKVC5GGRLipBgPZvOBZNvaLs02A7n2fTe4nz0amE2qVJB
	MJtK1IssTSsiAdVWGgwSv8rK3ZyfcKe9BX7IhvwXQPQmKhsP0krq5phoo3Xlj8td
	6tdUKGFyo5Ikrh0UuM60p1CMkNziJ6sCekC1wYdimqlyEZSoaTgJJB1cUfZowRrf
	ieIavUyPR7Ex9n+dyC6qfg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49515v2bfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 13:25:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58FCfBxp019162;
	Mon, 15 Sep 2025 13:25:38 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013031.outbound.protection.outlook.com [40.93.196.31])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2b9hax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 13:25:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvQkENjAiwvz+aoatmQInZFjCniyDzGpHAM3UV010Nzuev9WS6QiTd84814vk2uzt2m+r4+GL84oZ296lOSVcRjrFVQBFNaJl3KA4WIDf5NQbOubE0PPn1vNAUot+hPmFpXT8T4e/PR/upKXnFQGwnZV0MGS6DE6QD5SWVEGdRSkuYemeebJlf76m9pn/77tHJGLWDZ1WhNqyVV7n0+0rR78lOcIVOK5cz2eU47+VyujfSvdDwhNJ2AV8Z0hmMSQGiN60Vu2JhoSZAW/z3BU0S8HjvH1skrTAeJ8rD3UsiCNTRnjc2EO08m65yFjEMVGPr+aQF4FertrkFJJNoDmIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnuffU36NOglzW0tJ3h7qPr923abV4TFsvU7ark+MjM=;
 b=T6BXtJyoeqsZoIypxOc9qT7BjFTnGnzXX1MO9h23tAucloRUwHvJ/gutlKmm/wEFtI4+pncU8Y61vhf6CyqVSO4ot3iBZ6ptukS5qb0pdnwkH6DHYeHM1SkHD843KfDvEWi+H8QDzj/1YaekTXRRI/G4yu7oYqyGhscTdRUmHbykfcRkE/VGZEXKtwXxad1Z6b6GGtkb6vUh+yPlO7CaRZDSjbwHtw6y0W9HNLyDOG0S4nl5K9V8wHSh/12x+tGPVtcckGy5vvVCaB1HhjBck9Ze09QEZkZkpm4cPETD2ErMMAEjcNNvoiNuDMbQ1tdSgUNO9a33L8TP2azGfDO8qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnuffU36NOglzW0tJ3h7qPr923abV4TFsvU7ark+MjM=;
 b=X9bFoy9tfkNmEKPiGwdYx8sYalpqYgtxrl5ZVuFu7yL1dR0ZJShBC8E38yKhzRNs9/bDAaxUHjBfFhkNiiQ6vPqxxIzrGFSpG7dIpy4LNBw8sKzyuWODZmP+jN4OLs0xe26MpQ70pSaKGgcDZ//OF8KgWt+exHk0VwnQXRGTD7w=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by CO1PR10MB4740.namprd10.prod.outlook.com (2603:10b6:303:9d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 15 Sep
 2025 13:25:36 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 13:25:36 +0000
Message-ID: <cf18193a-5a49-4e0c-b07a-a4f705fc5c8c@oracle.com>
Date: Mon, 15 Sep 2025 18:55:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH] PCI: plda: Remove the use of
 dev_err_probe()
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: daire.mcnamara@microchip.com, lpieralisi@kernel.org,
        kwilczynski@kernel.org, bhelgaas@google.com, robh@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xichao Zhao <zhao.xichao@vivo.com>
References: <20250820085200.395578-1-zhao.xichao@vivo.com>
 <cl52jts26ulfcanbzz42w35g3bcjlwfhteph2oze4drveajzg3@a4kq3cxfzn2l>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <cl52jts26ulfcanbzz42w35g3bcjlwfhteph2oze4drveajzg3@a4kq3cxfzn2l>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::20) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|CO1PR10MB4740:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f4155f7-c08d-4875-4264-08ddf45b5ae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUpBMjkwdkNaRVNKaU1OcktSTE8zUWloRVBEd1VIdkdaY09YbU1WSW5CYVR6?=
 =?utf-8?B?ZjVZeklUd0thSjVJQVRRKzVDV3dEQks4KzdVNHM5aGlDZjJXS29sS0xqU0lx?=
 =?utf-8?B?S3lOMnNTTjl5aEF0QzZNYmVhejdxMTZmN0NCMzdFbnZnR3UvS2hWck9iMGhh?=
 =?utf-8?B?QU5KbEUyV1cyUWxKTVlNWWNQS2s4a0JsamlOV05FQkVtTnhvOVU3VlhxN3JE?=
 =?utf-8?B?QW0vRDZnUGJNNnFtZ0dhNjB2UkQrR2NUWVpBTXRvNGpTVm9sWi9ZTkkvYkQz?=
 =?utf-8?B?VnBPOFhML2dwQ3kvRlc0Q0NBN0NUUmFDOEw3QzB3dHljZE1WRFpBUUJTRmlP?=
 =?utf-8?B?T1ZwSDE0YVJ3eWxYbVV3a01JaVhFTjhSQTlnZkppNGE5M1lXZzRZWkdKMzVU?=
 =?utf-8?B?Rld4Ym9tWVZ2N0VyNmNxSE5LMHZBMHZmdjhuUjZQa3hrd2c4UzlSVTZVRDEr?=
 =?utf-8?B?ZDhjZmxlYStreTFlWC9XekRXRXVSYkVVMGt0VG83TENLZXgydGVQRENXM0ZG?=
 =?utf-8?B?a1pNcUJuZ0hRanUrVnQzLzZmNkRyRlBWeDVWMnpESWRPMVRkRDFNOHNPQkhq?=
 =?utf-8?B?RU05dlppWGJ5MWRoRldLbE1MYll0TDhXZzJTZzRUR3d6TEhDUk5PZ2hFdDlC?=
 =?utf-8?B?bEs2d01zLzhrbHV5aTdVb0F1V2cvTk04K1RwOFYzb0lvbjNXbjAwTEJ1clVY?=
 =?utf-8?B?aWR6TGJCSTVGUnJuZGwycXdDdDVSSzB6VHNzSUtTRWVIazdrWXk3WWlFNGdt?=
 =?utf-8?B?ckhWTFEwcnJoTUFkSkJOd2h1K1pWb0tCSjZ6QVR2MGhDcGtaNzlNbGpsVEt2?=
 =?utf-8?B?Y1Z5R2pEZlhFUFZhVS9jVVlSU2UycjVCV3owZXl0aXVsdHlpVDN0N1hkZjkw?=
 =?utf-8?B?Tll3dEFiT2RsOGI2MWZPYzlMV1FDc1FDQ0RYbnVoSUh6VUFsTVkzblB2bERU?=
 =?utf-8?B?US9wZ2NybjgydlBjcE9BZWlsMWVoUmVFK29KSjl4c2dielBBZ1pmWUYvTjBr?=
 =?utf-8?B?bEFlUVUzY2lubjFlMjdYb2RFbFdGeS9ncngxUWQwSW5TSWgzWjFkMndXU3N5?=
 =?utf-8?B?Y1VVRFdKYkI2YVNPZUFpR3Q0R1dlUEhTYy8wWlg3TmpWZll5L3Bpa3gvdGg0?=
 =?utf-8?B?enFmMW9KTjN4WnRvNWw4WGplNnllTFpCQ1hOMTh6Nm56MitGbUxhMWpIc0dp?=
 =?utf-8?B?WldxSnBnQ1NHZTAxZVp6UnNpVVRrbHE1RlhiVjA0WjlvTk83c2NBZGxlWHNl?=
 =?utf-8?B?dURNenVvTzNZR2J5SXJUOWxIWmRZWWhISFBZem1oMkp2ekdxci9IT1VCUFpx?=
 =?utf-8?B?RHlqa2d2bEFtdEw3c3RRODRkd29LRHprVzN4NEVHRTcwZ3pDMVJQVTVvRXor?=
 =?utf-8?B?SEhOaVpQOHdCM0NGRVZVaFNlWWhDcktEcUNsTXJiVS9FaXBKL2poL2loVzZo?=
 =?utf-8?B?SGtyRk0yZEtHTEdySXdxQTVER2VuY2VTc0g0UmFVdktjcld2TFBUU2ZyLzdQ?=
 =?utf-8?B?QzczMHBQRmpWdEhkOFFsVEFCdkhLK3R1K0dYTXpTajh3ekpBT0tpRGl1c1B2?=
 =?utf-8?B?RlVKbGUvQ2FsbmF0R096V0JtdFQ1MGV6TUYyWEw2K2VyaTl5a3J2OVlGbkdI?=
 =?utf-8?B?MzY1WTIzNCtnVmxndHRPcFc2ODJsd2ZuU2htWmt3elJrTC9NMlVua21Ubm1u?=
 =?utf-8?B?UzB3dytXbFB3QTBOZjNBQkppNVlVazMrVUJXcmdvMXZaNEI0M3JPSjdIMkVB?=
 =?utf-8?B?OW84RlNFamtGbHRLa2d1YkpUUFF4R0ZlU3ZYUTRPMnBjT1orY0NlUzZJWW0z?=
 =?utf-8?B?Rjk2R0g0MFdKM0Z4NUxmMVBSalBZSXBEdzZwWi9nd1Q1dGJPUytUeWhJSWs2?=
 =?utf-8?B?dUJPd3J5YVMvTGVGUUlxazZMRUgxYkdEVFkzYXhTWTlhY1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlQrSVRhWkhlT1pmMEZBV3NodkJQVWpLM2dzQ3Y4cGgzSm1ZRXpWNndOdUZH?=
 =?utf-8?B?OFRXc2czendWajZFaEpHS1U1QXR6VUF4ZEdQSDRWU1Q0ZXp0WGNYTkp4N29S?=
 =?utf-8?B?NDBBSkhZT2ZJYXVzblZFZ200UUNUbzBHOThubm5EL2gwNXdCNm9saDcwaW9K?=
 =?utf-8?B?cldVRjlaOGgzWWFmdmhGK2E4blc5N0tGbUpqcnZWV0Y3VkNFTStRY2JEbnln?=
 =?utf-8?B?dnd2OGo4M1RTeDFCSlJONGtDcUYvVmt4OTZNRUNTWE93TVkyYWIxdEFibjRQ?=
 =?utf-8?B?VlpJSHNmdjc3SXNmNUhLWk5qeUYzVElZVFQzZlVqRlNkYW5TNTdQMWlzbTh4?=
 =?utf-8?B?d01qbFpsMEZTNTFTa014cm1pSkJYMkhsU0ZYcTBibS8xYk1JeWFkdWYyeUwv?=
 =?utf-8?B?d3lQNUl4UUlnV1VlMU5QQjg5a1RLRFVxN2piaUlJR2xpOE9lRDB3YVV3NExj?=
 =?utf-8?B?VkxZcGFXcUZ1eDZRbnpuWFNsWHN6MEw4QkJwdmQ4VVBqT1dUVzBid0lKL3hI?=
 =?utf-8?B?QWNnbzQwMmhLcUwvVFFDNXZONU0yTEQ1Mlg0QW8rbjNnQmNOUVROL1lEcWs2?=
 =?utf-8?B?TnFVY2JiSDBHblduZC9XZUtPdy9xUk5oRlM2WUp4YkVDMlZGUnZtc0pxQlYv?=
 =?utf-8?B?TVBEbk8rdGFyTWt1Q1NnVDZWeS82dE4raTFKU3I3QjR5NjNnNExzVmxncFJ4?=
 =?utf-8?B?Y1BKcWNmNjZ5Ny9pdVROTkFQcGllZDBBcXY2TkFHa0V4ZThGZUkwRmdIeTdh?=
 =?utf-8?B?UVM0NTRBeEEvUDh4VVY5VitjczF4ZzRZclAyakc2Q0RyNVVwdDZTdURHZTg1?=
 =?utf-8?B?bUxsU2FJZ2pCdFlPeW5CZmg2WHVlTk43aFBEcEUvTkp5cXBJbEJVdXhSNGhq?=
 =?utf-8?B?bEJjSFlSZ1NwNU83V0IyeExUUytSTlRoQmY2QzZDUFgzZUVCcnpDSFQ5WUI1?=
 =?utf-8?B?a1ZFN1Z0ZHJocjhOY2dsU241S04vUkxzQlJqM0xDcFNtMnZuOGVaRVV2VldO?=
 =?utf-8?B?ZzhRL3RReGJWRXFCUVN0cmhsOWw1QWNjSjY5UVpneFRicGtuT015bWNxTktW?=
 =?utf-8?B?TjN2TmNXTWp3RlZZUWNsUFpOYzFRcHk0MDVjTW5YVTBITzUvZXNtQ050V2p2?=
 =?utf-8?B?Wld2Y2ZCL3pmSnV1VkpNaHBPdHJIaTczS0FVMC9YSnMxS0UxSzJyNUNpSUlY?=
 =?utf-8?B?K24rckRGTTN3VXkyNWNXaGhZWWN2UisxS3hCQlllbjIxOGhwS0RCcEt3Mkt2?=
 =?utf-8?B?SGNxK2dyc2xSNExaV0RUM0t6eXBvMmY5cmY0ZUhabVE4cGp1QkR6NTBvRTZH?=
 =?utf-8?B?VmgrSnVsR2RodDV5SnlrMFBJeERySkRXRXdjMWp3NHQvWkgwY3VyaC92Um1h?=
 =?utf-8?B?OWNuaE4vYzVRVHhPNG9IRkJXMzRtTnI4Y3hSRmVHUGI2bG1ITU14L2xpclhk?=
 =?utf-8?B?dzRjSGtvVDl4WUZpYWZhWElpNzR4TU1mQjNsU1MyclVMclNldjcvQmhvRk1M?=
 =?utf-8?B?S0kxRWYxWFNUWUpDc0dtSlluUm1BN3ZvSlo3WWNuZ3QxYmliZWZON0hDeGVY?=
 =?utf-8?B?djQrSDlGTkRNQlZJc1RZenE5RjBjNGxGRGx2azZhSzJhZWNiYnFPMnlmL2Yv?=
 =?utf-8?B?cWczMjExTGM1RUJ5dFdWVEM0NHFXN0JMZWI1N1llcWlLNzliSGxwZ3FzUXFW?=
 =?utf-8?B?YjhFNkpMZDJuMlc3blQrK2hnQS9wbEZJWm81eHREdHdsNjlZNnlhWUF2STg4?=
 =?utf-8?B?ME1jMGpYSlc2NnNDSGI0SlA1Q0RVRS85SXVVZWFoYlJSNUhmUGt2SnNwa05B?=
 =?utf-8?B?RkFXSmdPR2FxVDYxTnY1Rmo1eVFVdlQzandHa2tDTkZuME9aN2JHN2pMMHMv?=
 =?utf-8?B?TmVFRy91UGRLWFVzNEUvcDZjeThhN0NzVmRuQzEwMW40WFRLcXp4REhvdHlS?=
 =?utf-8?B?K2svOG92N05TT25YVGFKdzNDRDFGaVJNS2FHcXhkZm5wWnZhNXpJbGhNS1Fs?=
 =?utf-8?B?T29oSUpTQUwwZ1Z5V3d0dldEVzVrTDNCcUlzaWlsRHovZHQwc1d5Ujk5OHNR?=
 =?utf-8?B?UUdrTnEyVnR5d3JWWDBTbjAxS0cySXBYK2pPdHo4SElvWkJYejlKTzVrdDRq?=
 =?utf-8?B?eDFJVnBiT0JqbUt0a0FPVGlFMjY4TVZmOGh4Z2MwSlpvODBYR3drR3VZMTU5?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	azd6dblYeeqWvSteSYNpKuxkchvAZyCw3EaW/9FCnFHbXnivPhFTH1hG5r3QLHZtyWQ6ECkmzKk48Qwtfl+hDRYkQYfALhe3NY599cMSaN1Jx+NOe+c5ERE5GH7gTaUzH28PhXOsbUZ/XbPI0AKCNQB0KBHZ4qIqnUv4z+Mnnq3u14J/5B7I57ae1m+ccJTioKs5L17OZLmzVxq2MSQ0YQX5vbP7xKw+M30yW27mSCPNFjJ1H12QZ8esemUK5+IFAWJ8I99GV46K9gzEr4zCUvGWq67LyNV1k5brt+CKUCmnTyQLHcuJtASF9AfStIa+L2/hz6DBTM9UHeQkkUPg4gbVfZ0bRw9ep5F4vfPD5M4PwmvzPrKNIP21Wjp+6xd+6lJ6N/2U7mm5bdgF0Yesjc23xr+SWUN3XNwSVreajSs+qKvkkXCMSuq6Gn5l8ty7zIAP5A3fhlel3JOnjWcAp9kHIL61gFnglkZ9IIwFl5/8v4Du70KBlhgj3eESMks1L16RRvDBQyknsGeQ+ddz2HEbp56kvSrj/MTX8BIaVQcfqUKoSceXywkcI6j8LEsxA+WgW/KX0gE8xKenvBE0ARFcc+X850IM5Egzu8HV0sM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4155f7-c08d-4875-4264-08ddf45b5ae5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:25:36.2084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mcsI5Z/4XP6r/5YYzOVQCy8RKaOXQX/fVbNCfufqgL20iBJqvnYiqCy0HYGykBJOTPlPz4OY99fsJiDHumvLQx3qPgLaPJ78I/GtselNAUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4740
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=679 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509150127
X-Proofpoint-GUID: Y5yrA-TfVyuhCoN2ujMsK26hP4WHksK6
X-Authority-Analysis: v=2.4 cv=RtzFLDmK c=1 sm=1 tr=0 ts=68c813d3 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=csUpRe9sTNLB6gj19VcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzMyBTYWx0ZWRfXwXucpqklYzzW
 uS9/B6JZWbtWjhy/7+824vZorvv2Jf63PCMilMD35q1dni+wv8ufhy1PBUYnA0LdXGE2S8BBONU
 61hL1DL12noP6xaEcLWDD9IkIpOTOdQhrq8Z8gFERtqXr2+gV99mCznoH/7hudNNG3ts8Et9jyd
 wVWmWgF5Jg/QG3UXgYwuOg3n7XVxepqOk1pi7GonuKjcARczy+ZornY5YacwHVit58U4frzHh4r
 bHWWawYyh1BYUte35yxjdQ87MtSmXeRSSiOnVnbvM50b0XYjgRQVV3f17oaWbQNqkfYrPZuUCwV
 bgxMjUG+CyDB88w2FdKhC6SLtSesIlsxtKx/GjaJSyva3Q6w83Q0OBhHJIuFDa5uf0Psv//bWKr
 eYwmKcIB
X-Proofpoint-ORIG-GUID: Y5yrA-TfVyuhCoN2ujMsK26hP4WHksK6

Hi Mani,

On 9/8/2025 3:43 PM, Manivannan Sadhasivam wrote:
> On Wed, Aug 20, 2025 at 04:52:00PM GMT, Xichao Zhao wrote:
>> The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
>> Therefore, remove the useless call to dev_err_probe(), and just
>> return the value instead.
>>
> 
> Change is fine as it is. But I think devm_pci_alloc_host_bridge() should return
> the actual error pointer instead of NULL and let the callers guess the errno.
> 
> Callers are using both -ENOMEM and -ENODEV, both of then will mask the actual
> errno that caused the failure.
> 
> Cleanup task for someone interested :)
> 
> - Mani

Did you really intend to do that,
Should that be an RFC (for cleanup task) patch ?

Thanks,
Alok

