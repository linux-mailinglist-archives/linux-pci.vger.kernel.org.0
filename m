Return-Path: <linux-pci+bounces-26759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A85F4A9CB3A
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 16:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6A51BC2AE4
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 14:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9556253941;
	Fri, 25 Apr 2025 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZGmSrj6R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="emq3Nq9M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039AD252914;
	Fri, 25 Apr 2025 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745590403; cv=fail; b=QdElmr/FneG3Z+WY91wUuXszG/qMAgWfWdz7Th+99sehG+kws2vDvh/qZjGWhyqzoNv3j5NrvFPfflBrbejydP/uaJTl/ca29Dwa1ZEJTndLyJaYCrpUQY0aM/EtuAs8pHDtkY5FSY3gBKtwliXVnoKPKWWsFbXFl1imQKWQTrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745590403; c=relaxed/simple;
	bh=v7bTHP8P92d6oxwvSqG2JiqoamAb9BiXz75j0vB2f+s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fRKqmgp0BIY1WX4tzVO97PbByQiO2j6lQFqWvFpZzizCLd72rxG6RHLYuyUreHft5J9z4hRAJ9d1aWzeuLw1JR6kjjQGFly3cYmCITV2Vblwjy6rXvuzk85ULTQAfg3bZw/FMKtXaS0bBakF/1IyRgc4EPyEmnTmoV0Y00HaS2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZGmSrj6R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=emq3Nq9M; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PDvYGY018658;
	Fri, 25 Apr 2025 14:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/yJeYviS2adX6L7SvQh0gOAP24ryspzsD/Ao2hEb9bA=; b=
	ZGmSrj6RXaV2wEBMr4xPHx8/7wGyuM0LSy7LoJN+Ke47kN4KjPyGQPM4kjdoGNta
	iriTSzLw+vPZhx7+ZmizjIvl+gXKM+qyz+OisyR5UIwpEY7URIaxzSxrMd3ExtiL
	aE4erT39iSkp+MylAl5KQUvL81eZShmxKmVxc7KNI3PeNb+O7yZa19HOuOl7GQuM
	AWxRF0G7SrivhV/lgFpHKKF3kSGJDBeRzW6/EhYrFp4bE7fPuF+E41RYY59kikM2
	9Z9Q2Uy0t8zWjJTXb4+DouDVG5miR1jIOnV1W/KcR1uVLkGgkh/62od1HOgeDp6E
	+meYRxZKqdkxiHfDbTh0gQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468bqq8207-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 14:12:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PDoM5c013761;
	Fri, 25 Apr 2025 14:12:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jxrpkew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 14:12:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWkUJ5FW2Nf5jmr0swpoxVv0YkGDj1N9W5DKl3W76Q6WWTOmTUfDH1NsMdM97ZMJ/vYIn7Plg4rn/HLual2HGSuqIpxeyf896F6qq32CLOjPYRaJgTtnOs9pMQqSD+IQ8hRpeCW5lR0mvu8nBRIjkbK6REjMhcYgGWhsUV+Soffigw/HByMpcIo2az1DB/sFptIu40nC8VA9Mko1Wnctq6ziTA+jrKmroTBxkj8SMN5douDY8QFqpZejVmRLhlm2TXxIaIXGwZxnwJFJpnGyrDd4yoXOhbkuX8v5eLLMvg8nBTiXgSsgHUbtfk6Ze6Pk1p84yyAFEiNWE+b9PJN2bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yJeYviS2adX6L7SvQh0gOAP24ryspzsD/Ao2hEb9bA=;
 b=D8j67G2aeMdN3/1HPaZ6DciA/wVW2IpecNeW3VLTdiMH/dXhW0We4hVDGQKHt3bS4AOK5j5qmVjSox+jj3cXUF+ym4l1YXirkb/ftySDK67ePxGjliWJOeRacLx+DKeIVDaEZH6PRL1JK+iIz8y0um4DSGtIy0fT1xE/FUFdvttcpqSVusHnVxGfXnkjDJ0oUo151H/hSo9zIExl3ajspiknOTJijkN52zoCdEbLMcbkqF7+xh9jo60azhXgYxeq0aTbptsfKIp5YpD3M60o5cNAwvQJqlxBJvZr6Aj9BCL9qD4OXKiIeRDRVUiJcxiTHQl9Sad9RO4M1U51tcgVKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yJeYviS2adX6L7SvQh0gOAP24ryspzsD/Ao2hEb9bA=;
 b=emq3Nq9MulT38tOPo2RkIB2iZHM5Knt3dTHGBaqX1KcmesBMBbyGIAYCK+FVkKdfFnt755D9oLvhiq4+3dQwhKhg1KlwOdTWMHDGy4HCa9JeaSQBd2XY0GHP8qagG0B8q/8PBbIvnYmUrFtjF4dxikWUPr1QhykHLyRXxDdp1PQ=
Received: from CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9)
 by IA0PR10MB7134.namprd10.prod.outlook.com (2603:10b6:208:403::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 14:12:37 +0000
Received: from CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555]) by CO6PR10MB5396.namprd10.prod.outlook.com
 ([fe80::4487:ae4:5f2d:d555%5]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 14:12:37 +0000
Message-ID: <0f4944a4-fd05-4365-9416-378a7385547b@oracle.com>
Date: Fri, 25 Apr 2025 16:12:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI/AER: Consolidate CXL, ACPI GHES and native AER
 reporting paths
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Shen, Yijun" <Yijun.Shen@dell.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Jon Pan-Doh <pandoh@google.com>, Terry Bowman <terry.bowman@amd.com>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Ben Cheatham <Benjamin.Cheatham@amd.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Liu Xinpeng
 <liuxp11@chinatelecom.cn>,
        Darren Hart <darren@os.amperecomputing.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250424172809.GA492728@bhelgaas>
 <61d3f860-9411-4c86-b9c4-a4524ec8ea6d@oracle.com>
 <20250425141401.0000067b@huawei.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250425141401.0000067b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::9) To CO6PR10MB5396.namprd10.prod.outlook.com
 (2603:10b6:303:13c::9)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5396:EE_|IA0PR10MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: c404ef50-92ce-4895-cefc-08dd84033b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmtTZHZiVGhtR2VBeEp4WndxSmtuNm1aeGFaUGlIekJDMnlqODBOWjVQL0FI?=
 =?utf-8?B?cjBZTC9WVnRkV1FwS1FNWFpaMk1IcnJENlVLeTZQVXZWQUNVNkNiYUlvSGtu?=
 =?utf-8?B?Yi9GT0RkbWNUMGpxY2s1Y1AxbExEQlNYUjVyQkFUUXJZSnlXV3VjMUtESTJl?=
 =?utf-8?B?RUZQT241NXJoVXZnVlJkLzBTV2N5VldhRGxMZjMxcFBBbmpVVWljV1ZMc1pP?=
 =?utf-8?B?SjZOd0x4eGNjdlN5aXk3cG5uTktaYUs3SDRkQnZLZE4vZjlRNGMwSjlxWVhv?=
 =?utf-8?B?Mi85ZmxNR0U4VHNFcFY1QWtLQ3pMSnplWi9Wa3dNT3pGQ2gvdmRQb05za1RI?=
 =?utf-8?B?NG92MWpUNHFDNGIzSGM2U3RIbGFwbG5JSDRjaE54ZVBuQnZQT0tWU1lwSjFM?=
 =?utf-8?B?eWRGeVB3aFBzRTlKbitsNk9BdCtTSGZYc0dweHRZdUl1dU8wYlMvdXRURzg0?=
 =?utf-8?B?QWwvWWt1blJSSnFSWG5WRVlaN1JHYjRvVmgvV0NrRGdZelExclAxaTFTVDB5?=
 =?utf-8?B?cVNzSGlCbHZIVHJuRWJNcmkwelQrQTBuV2NJZi8vbVNyNmpmMm84T3c5bzNi?=
 =?utf-8?B?V2E1RTNQSDhCV0xqdGp6MEJDd0VHV2VvNVozdUZwZ0ZYcnJTM1RCeEVhZnBh?=
 =?utf-8?B?UVVzYUNNZjhITlBoVk9RT2hJTzZJQ1FLV3FnSHJzMmx2Y2I4SjRPc1R0Z0Rj?=
 =?utf-8?B?TWRVRlZsRnYxZkdEVGVZZG1iMmdNaEJEUjZHM2h2YlJtN0pQUmFJMTdiOHN0?=
 =?utf-8?B?TFRHM1hXT2d2MlVab0xSd0ZIcjJqY2xmSDBwbTc2K1ZEZHdIeWZ6K2RFa2p0?=
 =?utf-8?B?Y3FJMTZNUkRhRkdoUDdnZXQ5TFBzVXI4ZGRZK2NBbXlhemVNSi9VazNaYVZH?=
 =?utf-8?B?NVAzSmhUUlExQW5XNkZkSlZDcHlUWXJsSGdRbnNvVFduNkVYcHZRYzRRQ2Q2?=
 =?utf-8?B?QW92VmJsdzFyQWVGRlJLdUJiTFZTcG1zVFpVaWEyUmFnTU9GalVXQ2RVKzJq?=
 =?utf-8?B?eXhPb1BqZWlJY0xhRXdTQXBXdmhiU3ZCUWxscnNBWlo2elY0aFpvNWoxOXBW?=
 =?utf-8?B?NjJTaTJiQVM2MzdsbjdPSTRSQXgyNlBVRmdaMFJrb1g4MEJpb2FxSVlWNHpu?=
 =?utf-8?B?V2k4V05qKzlYSWRYcnl1aXNCcE0zOEQ0S3UxdU1zTUdlTHAwWmVKMStFYU5V?=
 =?utf-8?B?QmhFK0tySndSU0JkQTBXaFRQR2UyODBjRTVSOTNDTUFOc21WckI3eEFVMUhJ?=
 =?utf-8?B?L3NFY2RWazNNK0pwa2ZhS2hEWVhsYWZVcFo1dFgzcjJHOUUzNDYvOGFBc1NP?=
 =?utf-8?B?T0pFT2pvOWw3bm1ka2hETmhpOWkrVkdLSmNtUjdQRnhiMVE3MWtBd3l6d2oy?=
 =?utf-8?B?T3JGR3dmM0pGaDdnRCtjK1l4dHEvMXBlbzNsMkVodVhCUHpVNXRQV3VRZ0Yv?=
 =?utf-8?B?YmVDQVV4SXRTTWdEeStERElHZ3NSbTJzaktVaHozRTV5c1lhWlhjWHNYelY0?=
 =?utf-8?B?ZzVXazZWdUNrYzVjdjMzZTdUTGRDcjRIUmsxU2hlM3A5K0RRS3JLaml0NHNM?=
 =?utf-8?B?V3RNakFwNm9MdjFzL2pBUDdieFlHQ0hTSUdmZ2JXVHRaK21iV3N0b09tWStk?=
 =?utf-8?B?eXFFN3UzUUtkNUdyNXU1Z05rUG9Wb2lEVXVKeTYvNy8wT3NxeDB0dzhuZjNZ?=
 =?utf-8?B?Sk5BQ0FQYUt6RHNUYVQzYWk1aW44MHU3L1NDQWhMWG10OFM5VWtTWVJycEh4?=
 =?utf-8?B?Mkp4VVpUVHZyN1Ywc0VhMlR1cE5rN0M5UWdCZ096TldYNXF6QnNKdDJLaS9Y?=
 =?utf-8?B?RkR6UW12MTZuNVE5eG51dUl5VS9qUVp3dVIwSWtPNTl1NkU4NDhYTUNXaEto?=
 =?utf-8?B?SFVBeG05ZGFLb0VkNEhUNktwOSs0VmgxM3p3ZUpiR2JoVWMzWW85L3d1VWl3?=
 =?utf-8?Q?rTio7bSEHzM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5396.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MS94R2F2d09ESzIyYkJGbXg5MTk5NktoU05BZ1RVU3IwTHNHS2JrZUZkcUFO?=
 =?utf-8?B?T0lHb0MzNk9YcnhHQ0VnUDlKNWdwR2liRXZhL0RTN0wzL2N4RzBrVkU2dit4?=
 =?utf-8?B?dHI3d3dTTHZRUTh1SGZ2SzM2YW1aMGpDOGMvQ0dIZUowL0c3alZWZURLZm5F?=
 =?utf-8?B?UjkyL1NGL2xFOXhUZGlNR3djQXJpQk1vSm9QaENreGRpMEVIczJZT3RyZy9p?=
 =?utf-8?B?T2lsbENLUnRvK2grbjdnYjg5M2xpVGdFUDhCeUg5NG4wSGpNeFYwbXpSZG1C?=
 =?utf-8?B?Zm5kMFljZDd1ZS9QL2JKbGMzNXEwazB0L3E3dE9vdHhla1BnU3phR3pCQ3JX?=
 =?utf-8?B?Y1JUS0twaGRBN0w1d0Qzb3BISlRzYlFTeWp4cEh0M2NIMElBcE5oR2dXd3Ux?=
 =?utf-8?B?VVl3c256U1hPL1V0QVNLUFZ3UW0vQ3cyM2xtU3NJTjNEWDhNMDFzSGowYzNr?=
 =?utf-8?B?Q3JiT0draHNRNVY0aTNobmtSMnNHREM4cllPcHptSjJnSVYrc1UrSmZ0djc0?=
 =?utf-8?B?dHNadmpaQ3hQN1dHVllEUkdFQlhhM2cvNXk4VlhuQTVMVW1SYS9TMUJVVW9X?=
 =?utf-8?B?MUd6TUk5bGc0NVpyT3ZHUjkyUm9NVWlzMjIyajQyanlTT2NZREIvSzdoYWY0?=
 =?utf-8?B?K1BGZ2dCZHJ4UENKdTlRVStHZGIzSzZ1RDhpSmRUMERRVE8weWRuMGcvNDYr?=
 =?utf-8?B?V3M3OEQ3VnBnVGl6c1JmRWRFM2JNM2diYVBpWGdzRlJQRFlobkQ5Mk1NVys3?=
 =?utf-8?B?MS91djFiRER2S0xYRjhWWmtlYkxqcGlqRGRjQ095YzB0emxQU1NIdCtDdXZI?=
 =?utf-8?B?OGo5emJPQ0QxeTVZTFczWi82cEhuaGZna3ZUVUdFeWlZYWE3YjFlbGdaaDRV?=
 =?utf-8?B?NSsvYkhIUEJJaVJ5aFhVeFpnTU9YWGxCV1RMbnZiS2wyNmJLM0hzTHdhektU?=
 =?utf-8?B?MGM5WkZuSW9iajVaZGl0OVpnblUySE9UTzdyd0dxQWpzTmhWdkM2Qmt3WFE3?=
 =?utf-8?B?RHppbTBQSWI4ZVZtWDJ5UFdxQlJ0RnlFWG5mWGY0NUZ0MlM0VzBCS0p4dDBJ?=
 =?utf-8?B?c3lxUmxiM3VPZ1Q0eThzUEU4cW1zM1hmZ3Rhbk9pLzdzTGZGdGNWWEFBdHNS?=
 =?utf-8?B?eE1vSlN0N01XKzNSM2xITVNYbHJFWFRHZkxUUGRKWFpwa3FESFNYRHFlOExt?=
 =?utf-8?B?YmdyM0ZjN2svNVBkZVdZbTFuZ1R3K0JxemhoOUZVQ3d5NTR0bi9namtVWDVv?=
 =?utf-8?B?UVVpY0FadVphbmRnQ2R5TzQxVjFGNFZZSXQrbHIzWHBpa2cyOW5pZnRsdVF0?=
 =?utf-8?B?d0lYdWRzVi93RXg5Yks4N0dDT1F2c1QyemE3bnhvQy9xcE91bFhzRXl0cWFJ?=
 =?utf-8?B?V3FRZmpwRDEzQktGWUVvcjcwNU5hcjZnZEc2VFo4MUFGK0E5VkQyNCt4OXJy?=
 =?utf-8?B?SWtKaDkyY1V4WGRVdnplcjk3VGJURDNrckVEeXNHR25lUkJCSGNQZnRDbFQz?=
 =?utf-8?B?ZFp1OU1uUklHdHNRaUhNcUlNV21mQ3ZIYit4ZEkra2gzNlhoM3J6blY5bita?=
 =?utf-8?B?NmZXdm52b3NmRGd6WWVleTR4ZzIvVVo1dHdjMjlKZkVhM2FmK3pUZXNIcmlO?=
 =?utf-8?B?d3VDSFJzOFdNQ1g5OWtGbGNSdzRZM1E3ektQb2toNTJUZFpRcTRtaGJTUVly?=
 =?utf-8?B?V0kwSnQxdy9QUDgwL2VMbTY0SVVwT0NXOXB3UXpHN1dqS2szOEY1Umh2eXBD?=
 =?utf-8?B?R2VleTBHd0xmblBUTnhSZUl3RXRZd1Z3M2xIcnliZ2haaVQ5T2UyUVhKUzBp?=
 =?utf-8?B?WGNNOFJFbE82Z2pPUnQ4OUJtSDgwL1V1YTNQWktCN1VwcVl1V0MzV25lWFk0?=
 =?utf-8?B?KzRwcGVPOEFzekNOdnBwalczTzZJMW81UVZIaTZNL29WOTRQREJ0a2FhY0w0?=
 =?utf-8?B?THNZeTNEbGZJQmxKcWpJTDJLLzNIKzdpQnV6MUxwUW05K25wR2svTFM3VzV6?=
 =?utf-8?B?dS8zQUJWazMvdlY5dzJMNFlFOFNLeE9ucjZGTENaZ1dRMGUrazc4T2hpNHlM?=
 =?utf-8?B?UWx4MFJEclJpODB6c0JPOWduZ0I1NHdJSmZKNFAzcUVCZzFwclZ3d3d0ZGFy?=
 =?utf-8?B?NXBWdmVabjIrS0IvQXFUYlM2NEhzNHNtUjBDWVlzNGVIQlc2SWFkdDFjc2JW?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IalN9hTRR99eIjf+Pl4opvPDbsZTms/r9S4EevBNcmAEXLh7g6SfmCKZmr/bs/sZ3i/rOWK9aEINeAEQNRDg/oB7KA8aKnbBuXn0QR4BLIvndRu4dvF7HPgXGZNOIj/5DFHANy30QjPF4rKFe1dz3CqdBCCdtnmmg+6g5ZDuS/v5DCY7nIMrnHo4IyKgp/+5Q86UDiWr3iB/4OvO0FDERHWjjcxBc3EG44zxmckRDLtrP+c1lVq0WWbixoianEoEYslj4+MZhp63BcaHZ8w/+orSxOn190gJVyOdMfkenD9Ywz6ewkAAOcinSMXEmv2htJx6Wf6DFZCXtQwX4t495xR2GCHKDwfGIyyj1MSxLwjfE7l2zxFDPvVLr9XvUvn08MVEKIjs5vivlFNShaZfwgtDNrNydX91TZyxmMofAIQJC5fz7ZAba9Qt3r18rt9ejDlYkeoEjggxGFlAgzLSs6lBBI+xcW66evf/sTpDFialqNaovqRltid3YO27Wp5FVwvEdT/isB6n/NEZ9baEA0h3GGtAJ/w2locElDnegpsLy0J/S+EccUyAdtg7/87ZMf4W1nRp/jhNcSQqJB+y7ezWAfpqEs0QPZ4iS+iluX0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c404ef50-92ce-4895-cefc-08dd84033b81
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5396.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 14:12:37.7426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHh2ZMhFFHnyEFMmNVAn4W5l94U3C/hgqes6pl14T+rafva4S5gwTkw8RC7a7Ry2gKF8EjMagMYEbxH7CAhYxWr/mgGETVVZw1W3tSxHD+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7134
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504250100
X-Proofpoint-ORIG-GUID: 90yxMeI-RWHReDX6vgYbxDf6XnpESyAP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDEwMSBTYWx0ZWRfX6vrVRwJIG6I1 CcthNSINd1LtlI3afzovH67m4oeLhsHIr4ouI29mS2LZRMl8e+6MdOE3h53327u/ieo3T74EmEZ BV9FcWmbPxY6q/G4bdI0wYCtc2lCUKhwFLunsMsdo1Xgn5T5U/wV7yANjcyavtVhcytLBVRQIWk
 jTTlF77kH3/HhOHvQNcX9bF/d2bvxfxgMV/WCgdjrKiogboI2QZPNj0nRHLkps/4N67ZMWBNkyS bq3vpjlq4rQrgc9PuFnlfrzgb9Vsb3HxKj06MaTxoD8voiNleqFFUiMtDS7cye8cF9gEeqDXT5R uxuKiyXVnVfecmnJfoayXgVFwZvUtHobV5waAHvga8+4GOQx4uDX3ICvEuZI+wREyvVO9n+zgDO kMqoZ+2Q
X-Proofpoint-GUID: 90yxMeI-RWHReDX6vgYbxDf6XnpESyAP

On 25/04/2025 15:14, Jonathan Cameron wrote:
> On Fri, 25 Apr 2025 12:32:10 +0200
> Karolina Stolarek <karolina.stolarek@oracle.com> wrote:
>> 
>> It's possible that some of the nuances of this escaped me. I decided to
>> pick up the series, as I saw "PCI Express bus error injection via GHES"
>> script and thought it might be useful.
> 
> With Mauro's series you can inject (on ARM64 virt) any CPER record you
> like.  That doesn't synchronize the wider state of the system though
> so may not exercise everything (PCI registers etc not updated as it
> is only injecting the record).  Mostly it just works, as remarkably
> few error handlers actually take the state of the components on which
> the error is reported into account.

OK, that means even if we manage to inject a PCIe error, AER wouldn't be 
able to look up the Source ID and other values it needs to report an 
error, which is not quite the solution I was looking for.

> The aim is specifically to allow exercising FW first error handling
> paths because it's a pain to get real systems that have firmware to inject
> the full range of what the kernel etc need to handle.

Does this include PCIe errors? If so, that probably doesn't make sense 
to try to test my patch on an actual system?

> x86 support for emulated injection is a work in progress (more of a mess wrt
> to the different ways the event signaling is handled than it is on arm64).
> 
> I did have an earlier version of that work wired up to the same
> hooks as the native CXL error injection but I dropped it from my QEMU
> CXL staging tree for now as it was a pain to rebase whilst Mauro was rapidly
> revising the infrastructure.  I'll bring it back when I get time.

I understand, I saw some of your series while looking for ways to test 
my patch. Thank you very much for your work. As you can see, there are 
people actually looking forward to it :)


All the best,
Karolina

> 
> Jonathan
> 
>>
>>> Unfortunately there are some typos in the spec (FIRMWARE_FIRST,
>>> FIRMWAREFIRST in 18.4), so it's a little hard to find all the
>>> references.
>>
>> Thanks for the pointers, I'll take a look.
>>
>>> It's a long shot, but I added Yijun as a Dell contact that who might
>>> have a pointer to someone who could possibly test GHES logging on a
>>> Dell box with and without your patch so we could have a concrete
>>> comparison of the dmesg log differences.
>>
>> Thank you very much. Let's see, maybe we'll get lucky :)
>>
>> All the best,
>> Karolina
>>
>>>    
>>>>> If you can't produce actual logs for comparison, I think we can take
>>>>> info from a sample log somebody has posted and synthesize what the
>>>>> changes would be after this patch.
>>>>
>>>> I also found some logs at some point, mostly from 2021 and 2023, but I felt
>>>> bad about mocking up the messages and tried to produce actual logs. If I
>>>> can't find a way to get this working in two weeks, I'll revisit this idea.
>>>>
>>>> All the best,
>>>> Karolina
>>>>
>>>> -------------------------------------------------------------
>>>> [1] - https://lore.kernel.org/lkml/76824dfc6bb5dd23a9f04607a907ac4ccf7cb147.1740653898.git.mchehab+huawei@kernel.org/
>>
>>
> 


