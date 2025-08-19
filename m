Return-Path: <linux-pci+bounces-34317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2BDB2CB55
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 19:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 265A03AA95C
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 17:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA55304BAF;
	Tue, 19 Aug 2025 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dCRgSg5o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="baghyjHx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067F81E489;
	Tue, 19 Aug 2025 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625622; cv=fail; b=lA4r2IDrTb7gexpwGIKNBtB23wB/C+ja++v1+73YKBjoyrPyMKpOWnYDRl5AT4pCcYMJ0zA9rqTO6Fy1TaTdI8uYYRdQye/Xf7HUWmyHOXoLShvtUtLUC8xm6dqVm92tqljwkUZTP1JGpC0mlNJlXAqBZAdgJDJKvnQhd5rSqno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625622; c=relaxed/simple;
	bh=wI5mL8+iTpzx8WbNLMamzhpRBsz1t2Qve2TvYPvckSU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=APSecCfCOPjcVJTWZwjWo4s+Uacocaby2Vgg+GAKsYCSctgdNrx3TTwbh49PcDCDjByqKfNIRNeCV2tPwMu2EyppxPjPSFaykclTw6hXBF67t9fmCcMGG794EDRskefyhLsxrvT9PTaj7rEiSjDlydDh9n2h/8KX7HNgSNXJk9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dCRgSg5o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=baghyjHx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JDj0YO032590;
	Tue, 19 Aug 2025 17:46:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fqe5cI2jNs9D9MEmYptC3UKNZa0uSr33vH5NbuESFkw=; b=
	dCRgSg5oRgJ6M96i5n9wCLHWGyuTZ3PX+poeaBrGv3DbUDm+YaO94hpJiEdxXsYl
	z49YDqN2d3eBOm9zksLSyXrZQF3+ViUSZsdbmoheZaFqTHm328eGqWZArC3Vqa1+
	BSnjhlodBnANrOt7uzfhYxRNrEmXgg8eDRGRDio69uDhni/mKST+vzZLrhDpZfLJ
	BmWdPhbt3tEGjqE1oy2bma8TovuSQA5LJExI3D49LXzq5m31CqzDU2ZQ5bSDomJ/
	IPuw4+Po8TDLkyy+ao/L2wAxn7+eqKyBIhf8nzWsoKUe3y16Kk6Wbc2Qszs4Dx0M
	RGnvhtIPUKML/av4Y3mfQg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jhvddvnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 17:46:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57JHQYQ1036917;
	Tue, 19 Aug 2025 17:46:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48jgeb8txb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 17:46:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CeuhyWonNMw1SmZUSSd5wAo2+8qKLv2vey9oZFF9U4vdmIffqx+QrgEw2NiCSdvAowARa2PqOybOtLCuICsZ33oMM42jjMRV5+NA3wmn6EybLnBrHH/I0C8ofoSFXg0OmFM0OX64DGdlrDmEBjRapSZxr73modPgbTyqexLur6mDtJ+L3iA/kCeaTi/jc3PXxrkm3SZC/UbEXJQJeL7YsHbxN4IbEuLZbsDT3tQJvpgtMkcvJEBs/d7e6yl42qe2j9P6b075pXgAmoKDq9p/5D/cXJ9pQoMAIGbX0GUU3/QV3TEliXMY7RB/XDNaHLBqbc6ryIT42kiZMOdCtRQF7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqe5cI2jNs9D9MEmYptC3UKNZa0uSr33vH5NbuESFkw=;
 b=m2bG1+SYKNqrJC5a+cHHqx0jUt1xDwX/IhsKG3U/GWD/YCRVOK866wi4int/rbF2/zMd3TeyQEgv73NJiNnn2hszrBfcp+1C/iHmEli2I7bzzntgGx+id2yJHLydmB/WCANveGnEfUcEZBIl+7VWdrlHBSv2VEKmRVVkZ32vBD/t3NpVYRkX/bIkX9orq4a/+UoySM9ZvMpvV8Grq33UFwyBNNkE4F8xnIofHI6Cc92kutPvl0lBbQI9YUVKtp7Z3W3ihwqZrXpahjefz/vgGFApQnvJ3/vDKn6eXJrXhsPJ1ip+LOcziwc0UJs0lRQPeXFua1zOwaw1C+v/Xsm8/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqe5cI2jNs9D9MEmYptC3UKNZa0uSr33vH5NbuESFkw=;
 b=baghyjHxrLYQAsLBIx+kK6uWAm+P+TvUOICDI1Z4GLTKJ0m0O+jE+cgRv7IZT8mtg6S8Hml34hwhfy0LUNCgLF2Nu0QBkB1YFpeWl/VJAAjy+c/1jHZnbCmEhhkL18kiI7H182PzD+9gl2Io9nf0SXyBLZKfQDShxJWM5oBQldo=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by CY8PR10MB7365.namprd10.prod.outlook.com (2603:10b6:930:7b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 17:46:44 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 17:46:43 +0000
Message-ID: <55b55773-bc1e-473c-89b9-dfafcd38fb11@oracle.com>
Date: Tue, 19 Aug 2025 23:16:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/15] PCI: cadence: Move PCIe EP common functions to a
 separate file
To: hans.zhang@cixtech.com, bhelgaas@google.com, lpieralisi@kernel.org,
        kw@linux.com, mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: mpillai@cadence.com, fugang.duan@cixtech.com, guoyin.chen@cixtech.com,
        peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250819115239.4170604-1-hans.zhang@cixtech.com>
 <20250819115239.4170604-6-hans.zhang@cixtech.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250819115239.4170604-6-hans.zhang@cixtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0303.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::20) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|CY8PR10MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: b3291016-dda9-4744-a9e5-08dddf485c37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFZTbXJVNHBnV2JCTEltSjZybVZOMk5jRDVXV1d3MEMvbk5QY25CQUs5WHE5?=
 =?utf-8?B?V3BlakR4Z1pBSFNSSWF4d1VyS3pjNm01MHVkUE9GZVl3RjRpVy9TRjIwTE92?=
 =?utf-8?B?UXB0cnNqbTQxdkpIUllmRmhoZ21zR0krcmZrdjlxSjEvd3hoa2o3NnNjUVR6?=
 =?utf-8?B?TGtlZksyMWQxdkJXb0QrcllzaC81Z29NRE1qOXZwWEZBNEtCQmhwR3FZVXRU?=
 =?utf-8?B?azBxSm1iMEtDZjNCS05JSzBVc3BWWWNnWk9kSmtTWXgrZk5CKzdxdDUya0hL?=
 =?utf-8?B?eFN1b0NEZXl4N1lrajI2S0MyelB3TFVkVjhySVFCWGczOFRQMkpkSDFOQlFo?=
 =?utf-8?B?L1gxR2ZNaXRZVHA5bFVlMURtYTk3MG4yd0JMbWtKckxFb2szM0ZUUktkTWE1?=
 =?utf-8?B?RmI1M09KVDVoWURxanU2eFFHc0lqMUhBdUVSY0VBb0NYbmx0TyswZWtqdGRE?=
 =?utf-8?B?ODZhYmx0ZVNZajBSVXcrRCs3VGxIbEpwdHQ2OERCMjMxak5pcjBnM2Q3TE05?=
 =?utf-8?B?c1pRQnJnUVlvN2lSZFRqLzM0MnFQOUJ4dk5wRkNjZmtsNzVoVFlNcS9HVkxq?=
 =?utf-8?B?Sm5sOVlrZFlEaFNVYlo4a1JMSS9rckx1M3NaZWhUV2NmZUg4aGg2UmQzZWN6?=
 =?utf-8?B?dXFYVGoyRnJ4VmRwWkEzWkJZcHJBeHI2RHQ4QVJ6YUZFK1o1OVQvQ3JIQUxM?=
 =?utf-8?B?UlhtbFZtWjV1bnFDcytkT0R3NlBaOU9LZG9MS2puT0MydEJGUjAveTduTTBv?=
 =?utf-8?B?Nnh6VnhtM1V3OGlaZ0t3VlJ2ZjQzODlIaVdPY3kyTCsxNDQ3TEEzMy9icUNa?=
 =?utf-8?B?QW5yTkFZR2k1QmN6VVJjVGJYbytQNjRucjhGRTNyM0pERkZ2dGY5UlpuT1Ja?=
 =?utf-8?B?OVBLQWtnQ0NITXErNXNxbHBRNzR2NEpCaENVWDZCTXYzMFdnVmp2czZKbnBh?=
 =?utf-8?B?U0h2YW1WMllBNkYvdWY4VGd0bjRhNHVhcnRqTytwWmNHNlN1QzkrTlZNSnBo?=
 =?utf-8?B?dlc3U3owbVovVTBFNjJxaGcyTUYxYjBLYXN6bFVuWWlpYUhieW9ZejVIYW9J?=
 =?utf-8?B?VmtpczJNL3plS3JoMjB2R28xSkFuTktCdGsrd3lxaWxjNWtTd0ozdFZaRHdo?=
 =?utf-8?B?RksvV1U2SnZhMmtWUXY0ZFkzNHl5RThWQkxkQ09mWHkxSmJrQzQ2bzVpWjI0?=
 =?utf-8?B?STh0SFY4ekl1Tm5QTi9MdEVVU3ZLSmd1QU1adjcxZzVFb255Uk1UUzl2ZHlP?=
 =?utf-8?B?VUJvd0gzV2ZQQVFtZExBQVRRTitJTjIrV25UQ0p6a2RCWG5lbEJUWndUR2VG?=
 =?utf-8?B?UG5xZ0o0WDFDc1g3TVAxYWZzSkVXeUFCSkFCRnY2am0xQTZCTGVkYzBlMkR3?=
 =?utf-8?B?MEJZMmlpRXVRY2lCS0xGNUFtNG1XaktkQXhlZUxZRnZ1UlViNzUwR3ZYV3lV?=
 =?utf-8?B?dS9sSkdxc2VVVkQ0TFJCaVRPUVpCcjJlWWdxMUZPUklPYzVzVmgva3dEZVB5?=
 =?utf-8?B?bzR6SkgvL2JKRmFFb3BZN2xjd1U1cFllV1ZtNjBUdmFkQnlFUHdXWTNpNXdS?=
 =?utf-8?B?U2RVWXc4dXQ4ZzBuVVpINWkva3VOeGlUNDJLTlI1U0FoZzloMEs3eVRzQmtl?=
 =?utf-8?B?dFpla1hmK2hDZEpjZ3ZoT29rdUlYU20xaWRJaXZTOHp2NjUvSEdoNUExbFZ0?=
 =?utf-8?B?WEcyOEM3R0F6cFQ3Z2ltbHI5QnVtTG9GeHpxem9qczFod3FHTGhXU1VRTXhG?=
 =?utf-8?B?REN2S3J3TDBoZ1JTS2hDY2IyK1h1NkRBeVJtb2RSQ2pmTTYya0tYWUM3UFlv?=
 =?utf-8?B?ZzNVU3RsQzU4NjNkK01qWEVLaExZdnFrV3VrYVpsREVjYVlkclVhZkJwRWI2?=
 =?utf-8?B?VGZzSUdoOEdmV3N3Wmg1b0JqTEVvdzQxR3BPbkFydHRQa0M5RFU2V3JWakYv?=
 =?utf-8?Q?ppVVgqDPl/A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFpYTVBCbzhRZ2MyT3NGTE1XL3ozNHJhK2VFbVUySUVIa0szdkk3VEo5a250?=
 =?utf-8?B?bkxFN0p4cHNWY2pNcHFZNXVOT2x4ZnNGOFg3NFJMSVQxQzdZRzRMZDV6Z0JI?=
 =?utf-8?B?MEZBbzZUZzQ5QlZ6UEJvUUxia0JsSGdWQk9salBIRzV6YjZJT0daZTBTVzE1?=
 =?utf-8?B?WlZBc1NNUDN3QldQbFVub1dBZVRNbmNhZmsxQlRmYUxkUDJlN1pLYzY2LzRV?=
 =?utf-8?B?QTBvQUxIbmkrVTBLSFRkVjdCblJuUUxMY2syekhGdmFxUkVSN29NSlJtVnpS?=
 =?utf-8?B?UzJWbi95ZXhOckZEUmd5OU04ZFBOVDk1ZnREbTVWbG85Skk3b3BnUGE4MWZ4?=
 =?utf-8?B?YmtJaXVPQURaNGp5cnNoLzBIQnBZeXNPcWZ3RnAxR01yL2ZoT0dyNDZ6WlEy?=
 =?utf-8?B?QUpwNkFGcmJqOW5ldis3Vi8vQXlIRjg2OFNSRnFkekFVT0JEcEMxTWZYOFdE?=
 =?utf-8?B?QVRKcUJGWTdtcXorTXk2dHlXekJ4M2N0aStLRVhXaGgwZ0F5SDlRaklIeFZV?=
 =?utf-8?B?b2lBdExCWUFqcTRGSWhFUzE0UUVsc0MwWVVISzZKVTFjZmw5L3h0eDk2bU1J?=
 =?utf-8?B?V0hDZElpcHRhRUlOeFgycHl3bUhpZjRjcnZSL0RoMllKTXFQQVZYRTI4dGkw?=
 =?utf-8?B?ck5keGtpVncrTzlHSXZ4YU9QV1ZTaXdIampCYnRPZll0bFg0MDZpeG5oQzZn?=
 =?utf-8?B?RXdPSENYYzFabXhaTHN2dUlRbVdsZS9waC80ZkRURVo5VnZxOWR0VTg1aDFt?=
 =?utf-8?B?MFRlaVROdUNESmZoMmtVSzVtWEJleEtjTTd6ajQrVWZyMVNpSE81RjlXc1pX?=
 =?utf-8?B?V1JQWnM3SG9xdkxabnI4dXB5V29YNnVIRWlObDcrMVJjdWxob3ZOM01RdTFD?=
 =?utf-8?B?aVl1OVdVZGRUaGRCdU5LZjVqVjZiYVBhV0MwWTcvdzhVTFpQSWNEUDBBY3Bj?=
 =?utf-8?B?T2ZOOEJBQzhMU0RBT1lVMG1NOERsYktnd0lMNmtXSGNoK1VhZ0tkQkdzNWJO?=
 =?utf-8?B?WFVmc0ZpV1ZxVWJJeWh4SWhRTTlEeDFwNEtwT3pBMTBwNGw4QkdINERQWVI1?=
 =?utf-8?B?K2xkRzFTcnU1b2VNZllSenllMEZHeVdTZHZKaWdHMCtVaThBbDVucHRmaTBJ?=
 =?utf-8?B?N2ZlaExPVHZRaFNMdmdFWVRuREErVnNLZWJ1VHJvcXVEOW1weTExSTUrbFhU?=
 =?utf-8?B?T1ZrSnprQnZpVVhnS2ZZdzBuOEtoWGVtVFZ5SXE3UVZuZy92Y3hSNitkUm9o?=
 =?utf-8?B?eXJkR2Y3dzh4U0JtVHFGejkvdFgyTk5WbG90dmdBNVl5b2tYZEhHNUJFWWdN?=
 =?utf-8?B?cVlLZkE4eWkzb0tzdVd6ek1yUEJodzhVNVBaSDJoR1RPWStINDVzQVB2MW1T?=
 =?utf-8?B?dG40Qjh3aUNDMWU2ZmtwNVpFdHVkT1M3Vm1mR2tvbWVvZW0remdVcHBGVUVx?=
 =?utf-8?B?NzVYRGN5dE5oMGt0UzY5eWNRSDcybi9uaEZOcVhLZ3BkNENSQnNuMGdRRmJD?=
 =?utf-8?B?NXhIUzhhaGpwTUdHRjZBdTlsbzloaVBTREhucFcvZkRmVTNLb3RxUXUxdUpq?=
 =?utf-8?B?SFZwaG1JQ09ZR01EK0xiL25vcVlRNG5odkJibk9FSHp0TmZoaytkazFCcEVI?=
 =?utf-8?B?N0VpYTZtWnJ1bkVWVDdxKzFpYUdsRGt5eFRSQmhqZzFERDVtZGFkMkRGMy96?=
 =?utf-8?B?WURYLzNYWE9PN3lZS3luZlp4eG03MDlUSDNKU1R5ZWxuRFpMTVU4MEk4enJS?=
 =?utf-8?B?Sk1keFRHemREYk10TUUvQnlKZjhSMjZibEk5TW5ybXZ5RHk0Tk5Jc044NGR3?=
 =?utf-8?B?RDdkS0swZTVQOTQ4V1NsQXVwYlhaMitCVmo5NWtYRkNaSVpqYnVWdDAxaDJV?=
 =?utf-8?B?WWlRT0srN0lRekRWZENySGo3dkNseFV1ZjlBQ09xTTQyYmdqZnFuaGtlTXZR?=
 =?utf-8?B?ZVY2RVZGVjRrZHdIL0txSHNqYlNvbG5zUzdGYTV4RTFtSlpaSHF3b2E2dmVT?=
 =?utf-8?B?SWV3OTFGNURkbkUxUWRJMTlSbmcxYUYyV2EvSlNvYXhFc2FqeTlIVVR2ajBN?=
 =?utf-8?B?cldXRkYwcUFwdDI1OG9lenVFUTlTdlNGNlRKSTltUElHbWxEcHpJRG12bm1y?=
 =?utf-8?Q?S91FvPiC9/eoKVfp71QdyoWT/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KPJDnj5MP/3OoKP8YgnpObNlf/c2qd3itu/Uu6a3QcptQIUDKBWphzFvQYZT0OJI3nbURJSPP3r56pxq/W88AlExfzawsjlLiFG+Ne/oAkhOm0B/OO9C6CfYq3MtqLtBa+h6IBNbGMuX3SGaUjTeqy5w1yqGHtHtNP9dBmmrVWPzNUu3TmmQffMCyc5ncCqdEhAqOqwrThR0EPRasosG5ublEebjo6+eDRQnF/c5W6DF+1agROvc4m/qpe0zkDNIR2kAs6qasordC84qoVPTlrh4HNR+eogIvJ0PE0yZS4fyTWIKxymInIH+c7FoNOoPLIX3OOEBYDMt8h3SERj4w4xcuyjGzj9GcGnCnsDFV2JW3FatixUMxHzP65MU2LTUVXrW1MiBdHPpRwmkOA5lOBebxQIRXF7ox8HAajzlFF1SpeyTxQoq6lW2DUnOyB8nb+zzzQ6O6dfAg3PVyfu5ZeLi4OG1tTeN/IxjNQ1AwGNL2mYlLimWmk5IsqlDonUXgBARwVztjVu3eAhI0Y1OX55nxod5In0mdw3AsGk8TYZDAwxLrVIKQ+fpkFCoNbaSajrg12m8sc6ouac3Vpz/OmDUcLRDC08Kw4/LKq2BQHY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3291016-dda9-4744-a9e5-08dddf485c37
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 17:46:43.7263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwaCp0M6XcE9xZqHF4SAxI4zclEenBNCNMUpNI9LYuvqFZoRm3VPF4xAx+dbzA8wl3tXHPDsGkOKmw7rw8ea7/0I89iiacvUZiAjyJXFZS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7365
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxlogscore=875 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508190163
X-Authority-Analysis: v=2.4 cv=TNZFS0la c=1 sm=1 tr=0 ts=68a4b887 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=TAThrSAKAAAA:8 a=HbRyE16tn-GFi4KcCdkA:9
 a=QEXdDO2ut3YA:10 a=8BaDVV8zVhUtoWX9exhy:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE2NCBTYWx0ZWRfX9QyWiFvcmUSx
 N3kpxHctqXv4BTu00swAyzCE3oAbUjgOIPuAOKL8SP4tSAqK+frBf+xTgNNJUDTegI6opxch8a7
 bL8jmguPQ2ozW99xOMwda9/pL/V9tsClas9q0Iink7bTLTg6iKMxwL4q/c9kpSnAQmHre80wFws
 X21H61TZQzmBomLTNULQNy8phIPCKSol8etcIf12AX0N5cwt3qiz976FkRHjhOrn132qqGrlbRw
 8dPurmNExZdTFBECDpihYR6aT86770NtpRiLGNH2YUVxr8aYJb9HR/PtK3IU08KcMfXxo6ACG84
 KdUuS+FSzdEnZ8JJgQr1lb0Zpumuuxm7gMQxZhs44AsgXXe77xc8lW3V221Gy18pb2ODjWiMAOL
 EV1qXteR3bxJPv51yr9EikWenkPUCxT+XzOcK6cB4IAH69GBWzvbz6+5PtSgL+XlWaD3aUPc
X-Proofpoint-GUID: G_0ReYLmGZ39Vo5LRGGlIyuDsns8EOR2
X-Proofpoint-ORIG-GUID: G_0ReYLmGZ39Vo5LRGGlIyuDsns8EOR2



On 8/19/2025 5:22 PM, hans.zhang@cixtech.com wrote:
> +u8 cdns_pcie_get_fn_from_vfn(struct cdns_pcie *pcie, u8 fn, u8 vfn)
> +{
> +	u32 cap = CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET;
> +	u32 first_vf_offset, stride;
> +
> +	if (vfn == 0)
> +		return fn;
> +
> +	first_vf_offset = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_SRIOV_VF_OFFSET);
> +	stride = cdns_pcie_ep_fn_readw(pcie, fn, cap +  PCI_SRIOV_VF_STRIDE);

extra space before PCI_SRIOV_VF_STRIDE.
It is from old code, but since this line is touched, better to remove it.

> +	fn = fn + first_vf_offset + ((vfn - 1) * stride);
> +
> +	return fn;
> +}


Thanks,
Alok

