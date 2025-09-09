Return-Path: <linux-pci+bounces-35740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203D5B4FB4E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 14:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D13F5E1CCC
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 12:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B31B1E834B;
	Tue,  9 Sep 2025 12:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VHKfVkl9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GH8WGdSw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC19DF9C1;
	Tue,  9 Sep 2025 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421250; cv=fail; b=jLTFIGNrZiwffeYqRwXHmsdgK5+UJGrVev601mSMnh+xWerGL3zVhbjHSfaI8OuSKa9CDb7+U0++3X3AUF5O3WpOAz4zzua03BIUGGfx4Y/lNXsQiqroLF6jjxdHUV+CiDV1vDFdfCq4iVhxueRL/YaA86posApa2hGolUK6soM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421250; c=relaxed/simple;
	bh=CLHFPHakcJMXBVUByYp21h9pzp97EdGFDgh3UpsQ6fc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GPC4gugZfvIbv/hBy/lDYWqIobbFa/GfghqQhlmQDkcKRlYdOH0tb12hhBZEN4DTqe5XVqlqsAkdnvZ0ks5jDFNr/VStLKrO60v1n+YDL8psz+r9Mw6gBh0UERQNGUBHbeBz6SxWHgemC02AmlT0UH4G7qfnZ8yy7um57VrDxz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VHKfVkl9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GH8WGdSw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589CPIW1003529;
	Tue, 9 Sep 2025 12:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=InyzWn6FXyjWNS5QRIBsEYEzjFooCqPoPZTAbHgtEJE=; b=
	VHKfVkl9A3wL2Nh/gkYpc9K5UoWtwzyA5upTGbDpD/Zxvx3pA4YsdLoeV0fzrwHi
	tgjkuOWoL18A7anls37GGdDfPTOJqAow7Nw0Q97XnHV6BAFTrIoZtIqXxlSiEb8V
	6Eke+5p9sTIx8tXwWq4dQut1WC5hmt2WrY3v8jicckG3LeTG4JdhTIMFAPYFsYsP
	LrTYXv7IAxvinNWsmrLzkOLg8w97f2c3scuvo2sVqRftlowalgSkg/9iV1lYQGi7
	vnQ0ysprE9FbSbAx7XXTGYL3ZF7sOjHItp/oXBIOwSc+zkc9I8vQJtCSvY3tDCWh
	+dE7kzkPLM6Y+lbLofkjUg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922961tf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 12:33:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589B0H1S038766;
	Tue, 9 Sep 2025 12:33:32 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013005.outbound.protection.outlook.com [40.93.196.5])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bd9j533-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 12:33:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLnd2cPIu6lfdVkYUhiBZJXE96lR4S4mRwmu3Vybddmahu/wx10z97C78iv9TfgXdZyphOiagoLrwzaGiJaz+DZEoc95JB6ljXhahOprcvBS7cgk58ao0DwO4Y1qz6m7BezBf8rap/X/I8gJh/5mfV6q03ww9J1HbrjcQ70NKs51U5SQsxesQgnmYDuKURjS6FFKG46u162QQRafuhU5VDGDO6vef0dsChsELI5bi2xzHwR+3ZcyWtwLpXfB5NnjKBUvAXiKxdkpkgDUwNT6hsfrWiOy8Hk0wP60wt3jS3ns+WNM9FaW3Ji5eSPi3CDJxtjWAF9asLnZ+GfSUa6+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InyzWn6FXyjWNS5QRIBsEYEzjFooCqPoPZTAbHgtEJE=;
 b=YQzLLThwZrfabXwuthVy9qbw8bn/5pto4PnTGUlgRSlk6AwV3JjETfc2v23gWsrGBOjF1dPhfl2rDiF/EYcuDetR8d8CYb+8hl3+qWfqxaBM3T71ClrHYZmIHs6Dz+dDH9o5THNaK8U6BhUw3QKPwOhoh1FU+/idV2FEop18IaLpie2ole7Gutxecj87SCIUiaInOzgWAdN275JQ70rfKDg21i/a9VN+hKW9jsty1Zo6ep7qyL2YKft6X9KghzX+AthRK+3ujDNqg2DbwJvuKAL6F2q5NGzP/tOilbbAt8NzM5EbhDZbhF7LsTzmbxZKErnGIas4L3RVagU9DEGcwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InyzWn6FXyjWNS5QRIBsEYEzjFooCqPoPZTAbHgtEJE=;
 b=GH8WGdSwMA1cXX4w1AZ0JPqzwCXSgn6iDjsqfFCITnz7hOn4bIA7tWva/kxLhmdfFWkWY0oO3IuiottkL5RB6Lle4iS3Ky72gshJQW7YaakPSjcMeGRQdthfs2Rn/5weZDAIck8+oZrot0NLnUxiMQNKIDebkLRKXGfiUIvTVtM=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by IA0PR10MB7255.namprd10.prod.outlook.com (2603:10b6:208:40c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 12:33:29 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.9073.032; Tue, 9 Sep 2025
 12:33:29 +0000
Message-ID: <c296df33-f9c0-42f7-8add-6966d89d00c4@oracle.com>
Date: Tue, 9 Sep 2025 18:03:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH 2/2] PCI: Fix the PCIe bridge decreasing to
 Gen 1 during hotplug testing
To: Jiwei Sun <jiwei.sun.bj@qq.com>, macro@orcam.me.uk,
        ilpo.jarvinen@linux.intel.com, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        guojinhui.liam@bytedance.com, helgaas@kernel.org, lukas@wunner.de,
        ahuang12@lenovo.com, sunjw10@lenovo.com
References: <tencent_B9290375427BDF73A2DC855F50397CC9FA08@qq.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <tencent_B9290375427BDF73A2DC855F50397CC9FA08@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::15) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|IA0PR10MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: f2050e33-3fa3-4e6c-4274-08ddef9d14c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmptbUdZZXBUb3R2TCszelNZRS9HUFpNOEtIQzVyeVZwdS9qWjdMdGRlNm83?=
 =?utf-8?B?N2F0Z3JIR0lBbkVBWXRVOVJLNllLRWJlRk4vUitBd0FGYmpROU81OFUrSVRu?=
 =?utf-8?B?TzE4R2w3QUlYdkQ5SzRwVmxVOWhrREd5M041amxsOGpGTlQya2dMd2E2T001?=
 =?utf-8?B?MUJQS1NVYVgzdzNoQVd1RGdYTUNYY3pzbytLdEZldW1pNlZyOUNBVDhKaTdT?=
 =?utf-8?B?Q0k1WnlkbFoyN3diZjZtTFRMdjMzcUtEWWI3L240SFJyNjYzWnlXMUV4T3ow?=
 =?utf-8?B?ZVZOdUZPTUVsRnN5QmlGL1FwZzN6TkExRDZMYyt1Q0tJQlUrZFdjTEkyZlBM?=
 =?utf-8?B?MEJEQnRUb3lEazJJRnBEYzFFUDBITm41MzFUNEpZZFdSbTYwYVVRbFlZK0hM?=
 =?utf-8?B?YUtrY0FlNjl4NmxlSVJNNEpHaUFrNTh1WkphTXBaY1ZZeGJ1TVJkNXBoUTRy?=
 =?utf-8?B?VXc0eWFUSjBaYzRUWkNMLzliMExmV3dNcTZCSEt4YXc5eVZrbk9IR1ViTWtU?=
 =?utf-8?B?NWRaU1dCT1JDV0gwdmtOMmZGcjE1M3NPZXBJeGJWeEY5endFdm5NOFJJNzRM?=
 =?utf-8?B?L2gyeUloWjdZZm1MUjhsMmNPdDd2aU54N3FKOElaengrQ1R3SzcwVy9QQTQ3?=
 =?utf-8?B?UGlUWEtLNG9FYXhzNTlZdGxDTE5hdFRGdkk3K0toZFVXUEtEY21RR2tOcmp5?=
 =?utf-8?B?Sm5sY0N0ZTRsR2hNQ2dMdHpIdzRRYUJaRThiLzU3YXI3U253a0hWU3JTYWJZ?=
 =?utf-8?B?SHg2SFp3QzcyaEJ3S0JveXpPMUFJODlwRytsOW9Tbm45NmhPK0E0MUVzaXN0?=
 =?utf-8?B?Q0RqUG42eFdMcDRvRWNiNGJxcFFjYmkwY280T0JkUE5SSFROTHZiRERsZ0g0?=
 =?utf-8?B?Y1NsQkJaTE5LV1JJZmptd3RyOTRkdllXUEVYbkVIbkVOMlEzdUdja0tHOUpT?=
 =?utf-8?B?ejBIbTJiejQ1YnI0ZFJMckcxdysrNzJUTGRtd1VQVXB1UVpoZmNWSG1BZDg1?=
 =?utf-8?B?dHluQUdxS2Y5T2tmYlYwSTVzczJzN2ZlbHQxbHNjaVlVeE5IUTJtUEpiSDhO?=
 =?utf-8?B?Yk9DTDZ6c2V4Rm5kSnJScldyTnl5Q1dlbDQxeHdObG1QN203NXBBdFlEOWhw?=
 =?utf-8?B?b3hhK1dYbFJkRkpXdFhPaTIwZURnZWhaN3BjTVVSUTRCRkpYWlhtMnFpS2Zp?=
 =?utf-8?B?MDVoK0pBNEMreEtNVUdleit2bklSalBSclZBbW9oaEJhZU1zYnp4bGFQanNJ?=
 =?utf-8?B?Mk0xbklXbUl2V041TjdTUTJoSXpNOTViRVB6QnFjMDdkRktKRkk2eVZrNkd3?=
 =?utf-8?B?Vm1VK2lBSHN5ajRRL0MrU2VlZTQwS3Z5OHBMWUZsL0lJNTE5bUFiNU55RXNw?=
 =?utf-8?B?cEN2SEpna2F1QjByTWtwdmdSZnhqeXVrVHkwdlRNdW5lUzltS1VEWHhWbU83?=
 =?utf-8?B?SUZZS1Y2NXIvMHNZNnFIU1R1ZHc4VHVFbEhSejZjQndUMWF5S2s3aXZVUUp4?=
 =?utf-8?B?dWg2U09qbVZpOGxZNDFJVTF1V3NhbEVrNXlnWUlzUnlhUllEM1RXTHRJbGQr?=
 =?utf-8?B?ZG5lQ3h1MlNkVEVxVERhRGVpQUFUdnBBanV5aURQSENDMXQ4TVk2cWxIRjdR?=
 =?utf-8?B?SHFqdGt5YitZT1RrOFJhYlVWOC9WLzlSRUpOaU1yOWRFQ0c0RFpTT1hGeWtG?=
 =?utf-8?B?WFgzTlpiY3Q1MjRMMkFmdlZ6QVdHTnN5MnNEZSswdUJhc2xDeEpCaHlZZ3hU?=
 =?utf-8?B?ZHoyVG4xVmltTStVZTNjZGVvbkt0anBzczNzd3FycTVKNVpMY2ZSd1NXZmZE?=
 =?utf-8?B?WHBGMGNhdlU5bWRreGhOZjhrRVBMRERFSVdVNnV1VmJrUHNiSEJWc3Urd0h4?=
 =?utf-8?B?NjRTM0Q3VWZzcmEyMWtOQTJaUTFZVFdJc0Q4NXlZbnJidEhwMjJWV3pKV1hU?=
 =?utf-8?Q?6O5S+G7/b3M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2dKeVZONWhjYm1tUnZySEt0MGtMbGFGMWdQWWZhUzZoeUtqS3dFUDJHQjVz?=
 =?utf-8?B?OTFDUWRDTzVOcVNCREVObk1ySythNDk3SDRqUnF5ODZwRGZkZTViUnVIenRI?=
 =?utf-8?B?OVpFUUxpVyszYXl0OExHT1Z5VHdkWDRNVVlMTDA0QUJvWWQxeVg3czBXRzJJ?=
 =?utf-8?B?U0J3TkprdWt2SXlmdG5ORklzaUFPQWdjK05MdWNGWDM0bDJhYUhVMjhsWnFS?=
 =?utf-8?B?MzkzaTlHSXFFcUFYakowZ0E1OXFZb3lsRmIvdHVPenJvclQrc0llbFRINWsz?=
 =?utf-8?B?cFE3M3crYjd2c1ZvV0lTSjdDWGlIalZDTSt3NGE3SzdHdzAwemd1UEFUenNM?=
 =?utf-8?B?bDZKdk9tT21KWjZoL0xtODA2SC9NaUFHeFRhNWI5U0k3amQrZkkwUnRrU1py?=
 =?utf-8?B?dmkwWDVJZ0JQUW5oL1BxdlFOY0dZY2VMOFNJR09idmRXVGZ4M1N5SHdZVlBS?=
 =?utf-8?B?eDFOQlZwUlRkMHJpcWF4d21ZRlpPMzdIMHNLSWhOeHlWTVM5a1F5TEZxTUIr?=
 =?utf-8?B?UmpXUWpTc3BmbXpFR0ZGMGdkcWpjQ1RrTURBRmRpSkNpTHA1eDdzMnhCS2Iv?=
 =?utf-8?B?d1A4a1l4VnBYbmRib2FiS0hicCsvRmhBclFiT3JyM3IzUkRvck5KTWFyQllp?=
 =?utf-8?B?Zng3MllFZzd0b01lMkFGWG5nYVBkNExZVHVTRmV4Q2dCMEZJRXFRYkJjLzhr?=
 =?utf-8?B?U3VEZm5NUlRUOCtBMEdLSEVRM1IxVzJzeitQMU5ORTZoTkEyQk5icjAwV2Jh?=
 =?utf-8?B?NXNNM0xOV0lvZDVLdzdDVW9KT2RVcHdWbC91by9WbGlJZUhoWW5xTUJNRE43?=
 =?utf-8?B?MXVzVkFCdm5lN1dCTDBkN1JUeVhNNjBKRUc4RzdMcXVWWFdKa2RPZFVZUENu?=
 =?utf-8?B?OXBTNW50L2dZem5hQTdGTEpsN3ErcENPSmk3cVBYeWpvQjFJZHRHa3QxRDJU?=
 =?utf-8?B?SUJKK0F0dVdNZGI4dmltNjRUclJPbXppaml4dVpBY2JCNkZ1dENLNWpPNWZR?=
 =?utf-8?B?a0xqb1g1emJTc3dTV0ZMT3QydE00akQ0SUY0QmlsbU9seCswQytJaW16M3RG?=
 =?utf-8?B?dzBkKzBCR2hLbjZTRENQeEltamhGV1ZYTEVlb2JnWnNJK0ZrbXpOeEE4OUZu?=
 =?utf-8?B?UThCSkYzQTJPY09sVGkva252MWlVT292UXg2Ykdkc2t3MWpJYkpocG1aeFR3?=
 =?utf-8?B?Sk1nUk9UNEdHbHlJdkZJNUxmOGtlZTJodExpT095Wk9Sc0g3VWlzS2oxRXZv?=
 =?utf-8?B?SHZ1RE1hTzJUVzd3WlcwQnRXNngxTWdwRUhhQzNOVHl0TVJHbU8zQlNjanRP?=
 =?utf-8?B?WjVuL1B6WjBNWnE0alM5OVNNdUZpOU8ralBHcnQ2OFd1YTFsUGU5SUdud2VB?=
 =?utf-8?B?cVE0MitTZWtaMlpQbENTMkEvZGloRklFd0RFbXJ6aXlUWkxyQkIvMXBVZnpz?=
 =?utf-8?B?V1dWck81R044VkRGc0c4eGFRNkhVbXN5QWdtUHpIM0ZVa1VMR1hQTHV0T2VP?=
 =?utf-8?B?OHN0TWF0R3Evak1ZWEliOGdyaVNCa3kxVlZNR3dLaE4yNWw3cEt6YWdmVC9M?=
 =?utf-8?B?UUp2TXZrV2lydHJ1N3pqZDd6cVlnbExhejhCSlE2V2VVM3hXdCtaaWpRZWtS?=
 =?utf-8?B?aVRRemp6UHFrdFJoMlkyMnpST1BOZ1JXN2RJRk5vNnQ2emVpdXhjQXJsTXk5?=
 =?utf-8?B?NzlhV01SR050dU42aVc3bEo2L1VrWjQva2w5dGFIQlVaY0JRNXU2NTNET1o0?=
 =?utf-8?B?QWtpTDB2aUJ2QzNiWFdLWk5sT0lzQXdZTktrNmhabFZLWjcrL0lIWUFRblUx?=
 =?utf-8?B?UFFlcENCUTNWY0JPSGdKam1jT1crZzd5ZGwvNlZiS3VIakxrckMrcXdldTVW?=
 =?utf-8?B?N2hZTmV3L2RJVDFIeVloNFlqNDBaTFVJZHhqOXEzaDh5TXZFaGRGYVVoWDRN?=
 =?utf-8?B?MFd0WVVsYmhhRmhRZTNkNmZJTGVUSTRtZjl1MXFzdDZVYVlhZzQyKzZHbW1F?=
 =?utf-8?B?ZnVOcFhxdVIwRDBpRDNWN2h4NGY1MDJKL3h6cEhvVjhlVXZiVjhmcDhobFVV?=
 =?utf-8?B?UWdXWDFQVmZBVDZtN0dIZlVaUFBIZE1rbTJnTFlSaURrZ0JJSXdQQkhVeFFG?=
 =?utf-8?B?YkR6cTlkN1JreUp3cjVTcjhjem54QTJGZXlVR2pFcDFOSVpJZm1hVmdFVzUv?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d6z+f7qneXzOMp4sugi+Bb+r90FfIJHV2zABFSRKwmYcpWVRL7y25ICVPaooWN735WCPvd4bqQLPRU4mIP8Es+dL624LZTEIBQIwla9Sk1TFUATVv6iSDRdV0k08HTJ8wnOaBKjsUsU5mvlUDd8C96Gp8FuKvTMJkZ9IHT5BE9UVb7y8kgLlug9XOvqm/fxi0+aCxXWS0JZLanWNr7PiND5NDFVE4nlZQQSZlFkA9yMUxIIdrvf9wMZ2d5zz7Bv/RISB6j4786VyT/3MyUa+ABtT4fXHZyPH3cz7h2L4l/mJRfi4LLtwhVqRgS1O9ES1Q4Z1aaJM0414xAPC6I51x8L24BFVMEN3+8Od9OAdMfLlwaAW81FWVBXZQ4xEBA/njOlPBhqJm0TruUqySpWZZmJpLlWoRcyyIVVM1BacCM0CWNLfuU1GkV3U2CH2+1hDI2wioYSksONTje+opFFcjmMkh7jNoWRblq2UMneANkxle43NqaCMAy4KM7PiUtWDsErgCf+ol0YRu5lMBH5ACdtE6CS1BT8szUNcM54pJWrWOjOVZg29kEE0DQXXVDpmnZOLnOpatW0fff3DtU4c/jc9ZuwT7ntUTei0+r2iDVo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2050e33-3fa3-4e6c-4274-08ddef9d14c8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 12:33:29.6329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6K44oOGgHEWKWz6ueP75bhuSXNxymtwcK3vf4T/ByyFHon+Wu7VXm27yRY5x0P+cDTx4pZum12GwZThBS5KapeK41ajoJ3ZS4xa4oA9OuRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7255
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090124
X-Proofpoint-GUID: 9n120uYAzNsVqdbqQS6qQXbHXqdWp-EG
X-Authority-Analysis: v=2.4 cv=CPEqXQrD c=1 sm=1 tr=0 ts=68c01e9d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=8k6WQxmsAAAA:8 a=sq1n6vFs-tvYatZ9krMA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12083
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OSBTYWx0ZWRfX/fTkSVCFf67m
 /RqodAAXpvh7YHD35OWbUsnm5Yi0u2pDD+W+mIAvvi6E42znAy0SpuJcvbJ8Gunlv7OINc1vjTa
 UlbvK8E4cKsciNI2wXIkz9slv5K3q5EmqRe79UzvuayaHWS2LQizrF0Q7H/HyX1mU4/WtWQypR3
 48xoI+7VJBYAkjP7mUlWOtMc5vG9P+xhViDGgi2AMZ2YJqNSMVdHd86SQnlLcOMdKlycRIU+Uqw
 Gx4RddtLUlnZLFOY22nlKAwMpjZ0sXWmaFkzoMyrb1haExOe91KSQwI7KwojGTcmFrJ/gK3EFrf
 5Y8m0K7ekFsnHQk4HW1pDAvL8w9W7dN19aJBv1vqTWg5YeWxSbjW8j867Sv/GQhRK2MPAbvX4M3
 xtDcuj7V4jyKSHLLn6mVBH6qxRpa5w==
X-Proofpoint-ORIG-GUID: 9n120uYAzNsVqdbqQS6qQXbHXqdWp-EG



On 1/10/2025 7:14 PM, Jiwei Sun wrote:
> From: Jiwei Sun <sunjw10@lenovo.com>
> 
> When we do the quick hot-add/hot-remove test (within 1 second) with a PCIE
> Gen 5 NVMe disk, there is a possibility that the PCIe bridge will decrease
> to 2.5GT/s from 32GT/s
> 
> pcieport 10002:00:04.0: pciehp: Slot(75): Link Down
> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
> ...
> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
> pcieport 10002:00:04.0: broken device, retraining non-functional downstream link at 2.5GT/s
> pcieport 10002:00:04.0: pciehp: Slot(75): No link
> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
> pcieport 10002:00:04.0: pciehp: Slot(75): Link Up
> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
> pcieport 10002:00:04.0: pciehp: Slot(75): No device found
> pcieport 10002:00:04.0: pciehp: Slot(75): Card present
> pci 10002:02:00.0: [144d:a826] type 00 class 0x010802 PCIe Endpoint
> pci 10002:02:00.0: BAR 0 [mem 0x00000000-0x00007fff 64bit]
> pci 10002:02:00.0: VF BAR 0 [mem 0x00000000-0x00007fff 64bit]
> pci 10002:02:00.0: VF BAR 0 [mem 0x00000000-0x001fffff 64bit]: contains BAR 0 for 64 VFs
> pci 10002:02:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x4 link at 10002:00:04.0 (capable of 126.028 Gb/s with 32.0 GT/s PCIe x4 link)
> 
> If a NVMe disk is hot removed, the pciehp interrupt will be triggered, and
> the kernel thread pciehp_ist will be woken up, the
> pcie_failed_link_retrain() will be called as the following call trace.
> 
>     irq/87-pciehp-2524    [121] ..... 152046.006765: pcie_failed_link_retrain <-pcie_wait_for_link
>     irq/87-pciehp-2524    [121] ..... 152046.006782: <stack trace>
>   => [FTRACE TRAMPOLINE]
>   => pcie_failed_link_retrain
>   => pcie_wait_for_link
>   => pciehp_check_link_status
>   => pciehp_enable_slot
>   => pciehp_handle_presence_or_link_change
>   => pciehp_ist
>   => irq_thread_fn
>   => irq_thread
>   => kthread
>   => ret_from_fork
>   => ret_from_fork_asm
> 
> Accorind to investigation, the issue is caused by the following scenerios,
> 
> NVMe disk	pciehp hardirq
> hot-remove 	top-half		pciehp irq kernel thread
> ======================================================================
> pciehp hardirq
> will be triggered
> 	    	cpu handle pciehp
> 		hardirq
> 		pciehp irq kthread will
> 		be woken up
> 					pciehp_ist
> 					...
> 					  pcie_failed_link_retrain
> 					    read PCI_EXP_LNKCTL2 register
> 					    read PCI_EXP_LNKSTA register
> If NVMe disk
> hot-add before
> calling pcie_retrain_link()
> 					    set target speed to 2_5GT
> 					      pcie_bwctrl_change_speed
> 	  				        pcie_retrain_link
> 						: the retrain work will be
> 						  successful, because
> 						  pci_match_id() will be
> 						  0 in
> 						  pcie_failed_link_retrain()
> 						  the target link speed
> 						  field of the Link Control
> 						  2 Register will keep 0x1.
> 
> In order to fix the issue, don't do the retraining work except ASMedia
> ASM2824.
> 
> Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
> Reported-by: Adrian Huang <ahuang12@lenovo.com>
> Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
> ---
>   drivers/pci/quirks.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 605628c810a5..ff04ebd9ae16 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -104,6 +104,9 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>   	u16 lnksta, lnkctl2;
>   	int ret = -ENOTTY;
>   
> +	if (!pci_match_id(ids, dev))
> +		return 0;
> +
>   	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
>   	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
>   		return ret;
> @@ -129,8 +132,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>   	}
>   
>   	if ((lnksta & PCI_EXP_LNKSTA_DLLLA) &&
> -	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
> -	    pci_match_id(ids, dev)) {
> +	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT) {
>   		u32 lnkcap;
>   
>   		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");

Sorry for the noise.
As a follow-up to this patch, we are seeing a similar issue in our testing.
After applying this patch, things look good.

Do we have a final fix for this?


Thanks,
Alok

