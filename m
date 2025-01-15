Return-Path: <linux-pci+bounces-19900-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12244A125D2
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 15:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8B4188B805
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 14:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD21078F46;
	Wed, 15 Jan 2025 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VDoViMt/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EkoVbI2H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0382146D6B
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736950715; cv=fail; b=uUD4dDnvdcnJkkWROD0EwWH8XCFHiphaTOgrO5Iq2T5HSBI/y6B+jnPAhO67HyX0LHhJMCA0ToRdDq1SByr6arojIR22dZq5fa93bPLxd82Ay4yMWJ+uTX+mpIkqtZjPuP+8VvayFN8BEC2cf45NZEqa/zgKci23Rrlh3w9P5u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736950715; c=relaxed/simple;
	bh=L18s5ybpHjxiLicwtyeDXtBWuBXje1oTZwsDAr75WTM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZsfRFGEqgVJAkSboUGpvNztt13HtuBYa4Zey4GAiNUgJRCdSVPDzZDuA4F8NaCnb1pdpXzYuPZaBzJZemrU8T4oMXuO4JYj4jkm+gwtXXFiPLhiVr+it/2SQ2LNBbToKR1tMdsV7VgjwSeZWb2iQD9QetXLzyf+/fVas79jI8Bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VDoViMt/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EkoVbI2H; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FCihkd005021;
	Wed, 15 Jan 2025 14:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=uG5arDlWpZCC7sTtgyWwDI90Rci3YAcmBKcKRBIizRE=; b=
	VDoViMt/63eSF5C99K9Tofg2WZjQLX+vDEo+COdg82gdSNAffHh62zq0jzl2CGKV
	Cts04+yfRy0sWGt2sgwIRHd34cemfWzFecseuXLMJbfo/eTjKyBk1txn/m0u/wjh
	id5pu9d9iUbMtZPcx12eXxuMrYbJZR7lMwjK1TALnpN85nFegL+meGfFLUUBFx4d
	pdLwXRZKjb+zfFEfkmmV3BfZ1IhBUf+P+lPOQ+xjnRHFpy9nDQWyTekNXIcudllD
	2Ewl/8nJDPUZxcmsOPPxqiOr+V2ZggYZ2fz+1Q0ZMq5gNUYIUxFdv6MlTO3I4fkA
	a330wW+ixTCU58++26+/9A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443f7y83e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 14:18:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50FEDubK020435;
	Wed, 15 Jan 2025 14:18:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 443f3fu73s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 14:18:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FExHkcUYU7b/X0ukIUdSjyPQAftuLTdi8kfwMOqtqWX1J4NiUwW2sp2rtOn6cA0E13+ZPxFHoyAD6JXPmiyuFC6mZynJYiO6vCXnG1ypDpbYmjzAHTCgJiEP89fpsISRsDepUjB2c7q0RChMIln/VYUBfQFc+lkUgK6A9k8M41FHE0KtD9ry3kd8QZrdjH+7JgoxsaAJhl2klYp0RNT2H7gl3w/mcI6zapj7klGkp7JXF1fZsYzLmvTzx0Q3g+XLdp+e/1LYxw5jhZiODBIK/EOIWce+KYude2pbB4eTXioje0czegu3GLqG5OA5n1Lxtqvqkde8S6z/wSujSRIFCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uG5arDlWpZCC7sTtgyWwDI90Rci3YAcmBKcKRBIizRE=;
 b=x4IIZluRGbKxwEstpO0Wg77x4G2QsJVofY14OURbVbLFPykpD3nUfavlR0CUPDhsgMlADylRAlUIznqcw/sRopu6Hb1gmnfn4xqXABNVKhUqSwNvy1V0Zhx4OuuG0DqvIFnMMaSIWvdsCq+lRvELaL+wb2+7be4hd0UKGrD/RSBeFVjc2l4Z2fpX1+ODoLsSNICaZXKejZBXlzEORJt0qrwiEXtLreCm//C8FOD0MJ+chH7i87iFisEiD+Aq62B7ptwXIoIHaRPj1wf2Yd+V8u90Ywjhn/mh7GNPutJhu8yJEXNq4WtzHtY9KWhhM0gdoRMN8NZeEBh76JR57DB9xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uG5arDlWpZCC7sTtgyWwDI90Rci3YAcmBKcKRBIizRE=;
 b=EkoVbI2HAevS+TP1l2vGVnZMu7zz3mj75ziBnHLDQc3JhUMMQIPCkL/TL4tsVbx8JEgZrm7okYGGPJnJHTFYrBSd70OiZBw00b7+N/aX/BtdFyB9CwshXooYq6130twMEnw1J82FF6H/FAmY2YUYjDq3wHlkFpyaQVaHgCLldhw=
Received: from SJ0PR10MB5407.namprd10.prod.outlook.com (2603:10b6:a03:302::7)
 by PH0PR10MB5595.namprd10.prod.outlook.com (2603:10b6:510:f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 14:18:28 +0000
Received: from SJ0PR10MB5407.namprd10.prod.outlook.com
 ([fe80::7503:9552:fdde:7d4a]) by SJ0PR10MB5407.namprd10.prod.outlook.com
 ([fe80::7503:9552:fdde:7d4a%4]) with mapi id 15.20.8314.015; Wed, 15 Jan 2025
 14:18:27 +0000
Message-ID: <8be04d4f-c9e8-4ed2-bf6a-3550d51eb972@oracle.com>
Date: Wed, 15 Jan 2025 15:18:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 0/4] Rate limit reporting of Correctable Errors
To: Jon Pan-Doh <pandoh@google.com>
Cc: ben.fuller@oracle.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        martin.petersen@oracle.com
References: <cover.1736341506.git.karolina.stolarek@oracle.com>
 <20250115075553.3518103-1-pandoh@google.com>
Content-Language: en-US
From: Karolina Stolarek <karolina.stolarek@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250115075553.3518103-1-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:4:186::10) To SJ0PR10MB5407.namprd10.prod.outlook.com
 (2603:10b6:a03:302::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5407:EE_|PH0PR10MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e31a18f-ef20-4a1f-570d-08dd356f799d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjZBSGZLZVVnYTNJK1VjbUhnL2pIYnVyZGVhTWF3WWlHMFJIRUtNZE1nNi9y?=
 =?utf-8?B?M1AwT0lhV0JmQnFHUWZlWERvTytiRUI1ZlFQODNPa0p6ZkI0d1ZmYWZvMkh2?=
 =?utf-8?B?dmxodFNmQlk4Qy81UVpRWnBuTFFPODY2MzV0MUxKdkNXL0RjSkwybTRDQlRB?=
 =?utf-8?B?UllsVTlQMmZkckpjbmVOY3A2OGdvU3VZSDMyeVhidTh0QzVvcCt5TXFEUzVt?=
 =?utf-8?B?K0h6dzIxQ0pxNVp5WjJWMEg0bGk1b3V3YnRzVmRaOWFiM3NNeXpiZVNaUTZo?=
 =?utf-8?B?M1ZvcDF2N1NTa01xREZ6NUJZK09rcjNKUVRXVU1GMWxrVjhieTV1T2dnNGhm?=
 =?utf-8?B?bXdVUmFqb1VOdXh6OUNvTVVhdndxVURGbSthQ0JTQ3lzUUNWMXFQejBDRGJq?=
 =?utf-8?B?c0ErYzE5REFBWDh0TGsxSVMzOVpTc1NwUWpzd3Y0azlBTzNHRjFrS2dTbVVo?=
 =?utf-8?B?K243d0ZXNkVDdUtBNXFhQ1lvUWVqbldPUWJzQU9JZ0ovMEhxc1pkRFp1YXc2?=
 =?utf-8?B?dFFEcHA4TXh2NVNldHpmMkZha2hHSFdjeHhONFl4cDFMZW5xb2ZkOVpsOHlI?=
 =?utf-8?B?SE9aWkxwZGduM2d0bGg2cjJTcGxFeXBSeTZGdWU1RmlxRmRyVzBTZ3VuQkdm?=
 =?utf-8?B?bUNFM1JnMVhBZzhIRXF0UDlTcDBqdXNHckZQTUtFcEhpaVp0MGxGVGtRZ0RO?=
 =?utf-8?B?TTNvK1Zxam5VOEJPOGUvOFRkd2JmNWdhWXU1a0k0dzNEUndVelRTOUNkZFBv?=
 =?utf-8?B?UkZMZUc0NTlDanM4djAxYk54VXNUVnNTaGpLQTI5enhjQXBBWVU0YkFOczdQ?=
 =?utf-8?B?NW53WHhjZnFlVVlGVTNzeCtyZE1EWmxOMHZ3VTM1b1FpbVRoa044UUNiTmsw?=
 =?utf-8?B?K3ptWE50TUh4Z1NPWUdYejlMSk82YXFKd3luaFJubHl5dkxaRXBKSmVWVjl6?=
 =?utf-8?B?S3N1TFBZM3Vsa0hKdWxORDJsYXpvY3dvN2Z4QTJpYW0ybk0wYkp0b2JaS2or?=
 =?utf-8?B?a05JdWIvaEdydE5GNkxoUkRnZTNXR2VTU3V0TjlIVjNBUFREM1lQMHJUZ1N0?=
 =?utf-8?B?cFV0ZnJJc1RlMUVwNXExMS9XUUZIa01tRUlXZU5SbDRLdWdYVVE4bGFIZ1d5?=
 =?utf-8?B?RnpNTEZ5aUJHR1h6ckRPdFVaRnRKY0phT2RTNXE5bnVGd2x4bGpUaHdONXhk?=
 =?utf-8?B?NGhUenYxQXFMWm5jcnVIUUt5WEpNRE80UDhYd2x0REV4aHNwT3I3alJsT2Rl?=
 =?utf-8?B?aXl3SHpMamlpWUlITjBUbHJCdE9FankvTSsyb1U3UHlDbXY3OEx3cFZOM3RP?=
 =?utf-8?B?dkVhcE45d1oyR29KOE9oVGdGazNFbjlnbXZpenhSa2FqLzZnUldsZGJpOE5C?=
 =?utf-8?B?MjJXR0tEaHMzblFwczVwQjNmVXBOWmQ2aWlTNVhPTm9ac2xNUVJSMnNwRXRz?=
 =?utf-8?B?YnZDRDlkQVJhQUdadUI4OVlmM2lKOTUzeUl2UjhjbjF4ZUVuakVEczRWazJK?=
 =?utf-8?B?SUR4cXVlVFBBdXd3K3FQeFhtUjFZSG1jcnY1TEpFdG4zY0d1MXp1U0VTUHNs?=
 =?utf-8?B?VmdPZHRHdUI0SElQNFBOeUJZaUxzclFCYXFRVFRCZVdIS2E0VWx5b0t0MDNy?=
 =?utf-8?B?b2pxcjB2SGhVUldRU082ZnRYaGQ4SmFZQ0tlUHFNUUUwTnI3MUVhTFAvdy9Z?=
 =?utf-8?B?dWhlQTVlaVY1a2dTak9qamxvYko2TnNPalZtalNWaUxRclUxd1hBb3FzK3Bo?=
 =?utf-8?B?dVBvNHZEdWJDb1Q0S3Z3cVMyRjFLbUFwblF5Q0pHcmtVeVd4dXUzTjY2VEkx?=
 =?utf-8?B?T1MvQ0YxdW9Rb0hCbEJwNC85Y1BDaXVIMXZOeWF5K2gwamsvdlhPS2o5ZDAr?=
 =?utf-8?B?K0NuS0h0UzJaWDFuSjc3c2JIMDJUNG9hNzdnT2xxWlZ0ZkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5407.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZllRSm1GUjhkbWdRYVJ6c0VFSW5qT2xLaXh4YUxPbzNxZi93d2pHZXJKTmhU?=
 =?utf-8?B?QVo0ZVZlWVJPd2NVMW4zVjdUcWZKa3QyUkg2UjYvWmZOcWsxdE13UWd2WFo3?=
 =?utf-8?B?dG9KeDkzUDlPOU5pV2h3T3lrOXl2SHpibE9Rd2lFSE5SM3lJSENDLzIwa25Z?=
 =?utf-8?B?SEw2cW9COWJsUEhpWTREeFMxU3Rvb2YvOGd1T05aZDBRSklEQS9pUUdVNXM5?=
 =?utf-8?B?bTdPcTk4WVJhV1Axc3FkcjB1T0dmdlRYRXJtWE9CQVp6RXhtL0NHSEFGbUV5?=
 =?utf-8?B?Nk9YWUdqdUdMVlZRWFc4bDFSSloxVWJWaElWTUM1V3Z5YXJIcVZ4SmM1aWRB?=
 =?utf-8?B?SFEzazJwNWo4ZEdUMEVtVGd3RGQrSW84WHlYZ0dBUjRLbVJSUVNEUzl4WFJF?=
 =?utf-8?B?K1k2R2lieHl6ZEM1UjV1TS85V2g4SXN3elBBbWxSMDVoQURuQzI4N1g2ZGFx?=
 =?utf-8?B?WGJhZEtHbGlzWGdrc2c3bFhYMGJpa1VEdGZDQ0lCMElOWWM4dHpNYlZKMTVK?=
 =?utf-8?B?NGZXOWFRTWNCaTlzaC9NVC9SMEV2SzRDdGRWVXl3WlJlc3hFeEMzRzlIWHpt?=
 =?utf-8?B?QTBjWDJFU3BCbGYwUUZkbVpUaGxmaFB5bjVBQTRqWkVRdGpQbEtrSXJ6TmhY?=
 =?utf-8?B?eGtxYW9zMWhwdXN2V0pNZkxRalZ4K3JlUXErRDIxdXBmNVZVVGtNRzh1RGJE?=
 =?utf-8?B?akhwbWgvM3BxNzQvTjFmWjhaNUU5clZ5a0d4WU5XTVVYQlkwb0RXbTlBcm5J?=
 =?utf-8?B?bkllNXdmeUtEU3BxNFQxWEYwWCtFY3NJNVNFTStLOVZPaGhRRXhGclJIbUhy?=
 =?utf-8?B?QVgva1p0S2lFeDRUMFFWVlJ0aUJnL2E0bkNTTWRnNTNGSzBSWUxranQ3dE9X?=
 =?utf-8?B?akN1cVZBc2w5MlVKZ1ROTHhqVjFYYkRKZmRMVzhrNDYyU3Q0SWJzUGdIb21i?=
 =?utf-8?B?aTd2a1FHcklzakNHWlRMZjVLRkFkOG51YVNnMDVYbFJHRUZNUjEwdHozRGxK?=
 =?utf-8?B?VlNFVUFlNG5DT1E0dUJSdVFlQklMay90SnJPWDRWS0xZVFAwbjJPNHNiNy9L?=
 =?utf-8?B?bGpyRnU3aFJBMkZWaSt3UVg3UUZjOTZ3MlN6VVRqcjdwSlo2d2UzbHlseTk5?=
 =?utf-8?B?RzBrbks0MVlQMUpPdGpjWTI0USt4QkgweFpRQmFJb3REVDluUkdxUVo1MlJS?=
 =?utf-8?B?QTNvL0prYjVnS1BDdGxyVUROaXJYTkY0eFRYVTlMdVlVTGhWeG1zU3VTYkRN?=
 =?utf-8?B?TXJjbVNlMXdzbTl3aFE2Z2JEdDlFaUJkcW1OdDc1NG9VaTNXdkdKMXpGejZG?=
 =?utf-8?B?NTAvN2R1T1dvUThXdFQzcVM3WDBwcGJQRWpJamhLOUt5WWt1RVlvRVpqWXRs?=
 =?utf-8?B?eHZsRHQxdis3bFpEbGJ3SnpoRTBjMkQ3dGhlNXNXOXZmTlROQWlpSCswdXcz?=
 =?utf-8?B?amV2VjJvMHltSzl2N3Q4SkEzMkdHKzNpaDg5VjFibkdMRlJ0d25raWhGbklN?=
 =?utf-8?B?djBnMHJmVk5CbFNGK2sxZU0vQ2orbmZaTkZtQVRBbWJpWUFMdGhzOXAybVE2?=
 =?utf-8?B?SnFSd1hXVVAwTWhRUU1LMXRPYmhyR0RobExGQ2JKWnAxNzYrWjkyWXZIZVU0?=
 =?utf-8?B?WFpQdWl3YmtBZW1yYWxxS1BuUG0weFpUc2d1ZnJ0bjFybThyQmdSY2NpRDkv?=
 =?utf-8?B?WVRRNklCakZBWEZob0d6YXhzdGNtV1NDZ1VPQlNXOFZmQllUcko4WFIwdjZ3?=
 =?utf-8?B?MXgvendhY3ZUVkEwdmlhbWVhdGlIaHNUQ01oVEhyOGNsSXpwRWlCdUxtL0Zq?=
 =?utf-8?B?RW9teDZXZGlnMk5Dc09Wbm1MSk9vZ25JZ3NGdUhqV0FQYUFBRnZXRHErU0Rk?=
 =?utf-8?B?OE15dEc5Qk9yMklIUmRnVWFVWUVhQ3lDdGh0dkM5WlJyZk1wUzJ2cmRNRXBO?=
 =?utf-8?B?bFJsdDdVTHVoOEsrWWNtVjF6QXpOdVlyd1Y1eWducTY1WTNFelk3eTF5cmcz?=
 =?utf-8?B?VFMrbTg4MG5jWEJYQXR4WDBrZ2hqZUVIRjJPOUhlbFBQeEMrelFWMmM3SFNF?=
 =?utf-8?B?c09kYTVyMGJEWmpSOVlKWEJadWFqVzBqWDVKTUtQWVNuRDJzUXdYZHdiMU1m?=
 =?utf-8?B?aVRIdWpLRGxqSURUOGkrbCthT3VwdXdBU3JER2I0eU8walNNdUdMdW5ubVFD?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A0EzSynZc6HcSEbvgnfNnFMpBlkIbqcnobBbtR7xhr7euV8Qbc+XgFrc4yolygnrvhPPTMdKUm2ofLMPNcywQI+jwklUoHjLttSRCv5e/DwHZBpkXvQq9fe3xWAC7wJddCTcUpBP+ucQmg553NlepayOGh/I4qFNz8rpYrXqWoK75fdSuDyNB68TTeJjuyrfCM8zET3SWx57Na7PKLKLwAWZIyt7VJxeZxSL3JfyIeH8l58eD2DRB+dCOcyLxTTfCVquaUNuLCiImvAYByp73Amsb9gu0sitej5W7kCPTJJdJV7un7ajUwUQXr40e21xwwLk21Zcnz3LTnpIbjD1HBHeAEEh79Ypxfhz4i36nG37in/ASOmjV4kffFrQ8Dxl83YXf3i1hNkeOEW3YUOha3bfjMiUxjOvVj6YuDURhNWfURiUJ2zWMCjQLU6UUn2o6uaMIXH1TzjoLprlw0glZUyQFvf8azVxziSLPTubVPJDBwNNuX/wCnkEwY1yhtemwRNSbG1jV8PMQUDDNI99Ckox+GHLFNjHe89Od3ba7ayJLJzzKEzJC3wVaUl32z/tgK53OI0X5K7BGpzCZFqzpeoZAkBE8O4eztzOCg2LDcU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e31a18f-ef20-4a1f-570d-08dd356f799d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5407.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 14:18:27.6955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0chE2bXiTnzCWWsfWBYXv51g69xx3+e5edQRN0cPJT1YK2J/sCi1N7Mqy0hkrMz0ZNWTa38N9NRiEP3zG1XxhLUnLiirPuWG6jR5Ljvx54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_05,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501150108
X-Proofpoint-ORIG-GUID: aZ97RdF-soHOFW553bg4vxE-lVjPT9OO
X-Proofpoint-GUID: aZ97RdF-soHOFW553bg4vxE-lVjPT9OO

Hi Jon,

Many thanks for reaching out.

On 15/01/2025 08:55, Jon Pan-Doh wrote:
> On Wed, 8 Jan 2025 13:55:30 +0000
> Karolina Stolarek <karolina.stolarek@oracle.com> wrote:
>> TL;DR
>> ====
>>
>> We are getting multiple reports about excessive logging of Correctable
>> Errors with no clear common root cause. As these errors are already
>> corrected by hardware, it makes sense to limit them. Introduce
>> a ratelimit state definition to pci_dev to control the number of
>> messages reported by a Root Port within a specified time interval.
>> The series adds other improvements in the area, as outlined in the
>> Proposal section.
> 
> Hi Karolina,
> 
> This is a common impediment for many folks that want to enable AER. The
> excessive logging stalls execution, making machines unusable. I've been
> working on a similar solution[1] to yours (i.e. ratelimiting) with a few
> differences:
> 
> - ratelimit uncorrectable errors
> - ratelimit IRQs
> - configure ratelimits from userspace (sysfs knobs)
> 
> Hoping we can collaborate on a solution (i.e. take best parts of both patch
> series).

That indeed looks like a more robust solution, I'm more than happy to
join forces and work on this together.

Feel free to incorporate the 1/4 patch into your series. I plan to do a
proper review tomorrow.

Out of curiosity, do your patches apply to cleanly to pci/err and/or
pci-next branches? From what I can see, "PCI: Consolidate TLP Log
reading and printing" series[1] had been just merged, so there could be
conflicts.

All the best,
Karolina

--------------------------------------------------------------
[1] - https://lore.kernel.org/linux-pci/20250114170840.1633-1-
ilpo.jarvinen@linux.intel.com/

> 
> Thanks,
> Jon
> 
> [1] https://lore.kernel.org/linux-pci/20250115074301.3514927-1-pandoh@google.com/


