Return-Path: <linux-pci+bounces-37258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A75BAD250
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 16:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A1B16BD69
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 14:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FB5224AF0;
	Tue, 30 Sep 2025 14:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DTuYi1B/"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012008.outbound.protection.outlook.com [52.101.53.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E08D1DE8BB;
	Tue, 30 Sep 2025 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759241280; cv=fail; b=YYm47jx7KaYnwC4vNpC23zXywxwjeGuC+qxTFeA8I/ZOXt4xTDoUa/EB1OyYodWxkk0gKJi5nitIDvWw6Fz5dipRxp/nAVVF7kE6aJt42JkN4uoAzRKoThsW43m3RtwAMmrVtFpL7+c9i7v9/k52YLGu9bGJcE1esJZL2RCDw/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759241280; c=relaxed/simple;
	bh=v/u4U8EhbXl6JQ+FSIydw9GncSKutBS+qEP5IcBFSug=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xx3QlzbSXs8QXRo0QdKnrJKgoGA9saDCcYm476odGs6X4kpB2Le5RFe8Rg9EU0ezBGCOHtaLwNL/Q64G68PGl+01QU/ld18yN5ka3hrbKqNDtpgvBkRjYD40nAn8zfLG6eKfWGctrqqHCxaysJb4oZJddgvqLTh2WxJ0cGr+ay4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DTuYi1B/; arc=fail smtp.client-ip=52.101.53.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/WpnFNioVwAp1O0IuEI0Ky+I0t8+kaKCcTu6Y+AoiNwohtKK/WKbOI6zamUzv5wq0BZEDVNedce1lUkBYqNCdYhSBOjg28pDbckLF1QMcTZ9Kns0UrM7F1Kxk2fU5K0qKMf/sF7TdOcnW0OYyRnNATzpABSIYFhosE/sGcbzIC54s7P6TGgaotmOUzbOdg4N1zBXQipZhLGYr2U2Zi7MtvMT6cP/nUDOS3YYf0lQGu9K0xavJI+s0oZiE/UAl8DL1c5tvg8Se1MNe15cBhU0Y1BXtJuMMF4TeuArROd/8kwc7n6r/Lu9NGliVD7THHF5M7fsSfYJJumQCZ6dNPK9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SjJcLrfAhBKYFbGvtvb1Ocfck+T597Xj6qZQaXUGhk=;
 b=OYsKFs75kCv+mPINuOX5wBa5rlkoMuVr7o+Uoa3n26qV2o6Q9vMiYZh+ajNgx9aXT9joPt52z25pI6aFGqptKe6NqGk2ifbkv2YFz5LrOWNvg5dUevU/77vgJ+GA7mEHJZb5jQjClCv3U8hW/W+Hk4i9UhBwzfy9H/jbIZ0H5UqLOwtcgTs/vgVsTc8uDaPW58rEwcpbsyjPRRCrYME6VJPSZvdcl1fdgdVrOpyWNiHy+//kTHmIeKDSsPKvv9z2NAnmuAEMH6YvtYVsSYFTOM31uSPXrvggJyIVHEzkJJTSmlOUf38nIlNxmhLRqGlOOUk8uwb8zrw/QUvGu1bNqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SjJcLrfAhBKYFbGvtvb1Ocfck+T597Xj6qZQaXUGhk=;
 b=DTuYi1B/4xyPdZwc5DxV8q+YdKk4gJyZpMY9cpefWrEF1DAED8mUQeFcE9tTT96qnXFia5hkjEm8HOkQmBWAwStm26ANihg5SlOBS/lRlX84tyiMdKY7TMuM/MmVjNVBbgKYFOHe1UNsoQBXVpg8OUP2TwoZVKhjV6Z17lywrq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by DS2PR12MB9800.namprd12.prod.outlook.com (2603:10b6:8:2b5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 14:07:55 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 14:07:54 +0000
Message-ID: <7d54aa5d-bef9-4611-b0ae-04279bb7dae2@amd.com>
Date: Tue, 30 Sep 2025 09:06:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 17/25] cxl/pci: Introduce CXL Endpoint protocol error
 handlers
To: Dave Jiang <dave.jiang@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-18-terry.bowman@amd.com>
 <beecc304-f201-4fa2-b2a7-810c82668be2@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <beecc304-f201-4fa2-b2a7-810c82668be2@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:806:130::13) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|DS2PR12MB9800:EE_
X-MS-Office365-Filtering-Correlation-Id: d35ceeb5-ed7c-4bde-6b98-08de002ac021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjhTRjF6bVVZZEhwbGJqNWpYdWM4Ri9aZlFtQktYaUU5ditPTThMV2ljcVV3?=
 =?utf-8?B?TWdVWDcvQXZ0V055WWVHNCtvenFKdTFvL3JMU3JJWTAxZm9sU2xlYUo3SnZi?=
 =?utf-8?B?ZGdzaHFaYmU2VHBNMUlhdGtwWElvbXJuVmFRS1g5K1hXczl6S1pVMnl4MnNF?=
 =?utf-8?B?YWxiczdMK1pxejNVNC9Odys5eWxremNtV0dVa1UwRVIvTHFiMEFOeGx5ZlVI?=
 =?utf-8?B?cXdtbGdNQ0QwQWVzUm1RU2EvMlVTcURkNHBITnhwUTdscWxMMlBaakdOd3Nv?=
 =?utf-8?B?SE1YWEE0cHNRNVZxMFNWVUdQS2l6a0dBMG9GS0EvSVpOZHN1emhNL2tFM3lW?=
 =?utf-8?B?REs0NjMyR25YT2E3Vll6Sy92dWhqY3NUOWpLbUs4L2Y0QThSVkYxaHBVQ0xF?=
 =?utf-8?B?V2ZUallKd2VZWHN5RnE5TUM0TWxvQVRIb0VkZ0NBdjFQenJMc0ZjU0poWVV3?=
 =?utf-8?B?NUw0Q1pwQXdJTWxkekRINWpDaFFscDVPd21vbnBDenUzbnNWbGVzYk00YmtZ?=
 =?utf-8?B?dDZlREZWMEJxSDZRTWJMbXA1NGNZcVFTdkhNdjJRRmdpUlhyeWJJRGxFTkF6?=
 =?utf-8?B?UFg2ZHZlRkNFa29iK1JWTGxUUXU5OG5EdzE3d0VPRGR6N1pLdm1YNlppRG0y?=
 =?utf-8?B?S3pYTU1ybnZOeWpzaENtOW84eGNOTHBYTW1ZZGpaRmFTeDRrQnpxMDdvQXVr?=
 =?utf-8?B?TVBZLzl6Q24zVjN5RVRTUVdmUS9mZXNscmhDdWtWNkxiN09rYTBzLzVXNXJa?=
 =?utf-8?B?aXB6WWN5NDBia1hqMnNLeUpyRGk3VHUvdE9MQ3Q4SVluVHpwTWVjMk9LTzRL?=
 =?utf-8?B?SzFOVkRFbjlsbGd0c1JqQ2xkZUFhU3lpR3V4SitWSFA5NXc1cG5GQllML3JB?=
 =?utf-8?B?YVA1alZyLzR3ZHpIUmNXR2tJWVVpMU82Zk5iYW13bzdlRXJJaTVrb0VHSjZV?=
 =?utf-8?B?aEdzbmhtRU5nNHhVZzhWM3pqNlB0M2krL0thZS93MWltZHdpUXhxeDhVSVNS?=
 =?utf-8?B?alFpaEFKYTFkdTR1Ums4YnI0WTVLMkp4c3hveDJNSmY1UzlsNHRWbkZkdDQx?=
 =?utf-8?B?U1JUbEVEWktPZ0I5aExaUHRmaUpVdi9uRjN2Z3VLUWg1YWMreWVwbWM5STlZ?=
 =?utf-8?B?MUpoTDRwUG1CTnBobkQ4VzVIOGZDR1ZZU0l3Ulg3cmZwS0g4RjV2YWxMOHRP?=
 =?utf-8?B?b0x4eVN0dzdxU05mVDFZbGEydkFDbnFGNUdqMlJJV3JQRmxBY1ZCY1hFRmhG?=
 =?utf-8?B?cFFFaFRUdWxLSERnaytVWFBPaCtzZlJIYkhCWkppVHNNdXVRZmF0b09oTzNj?=
 =?utf-8?B?a3FrcGpjYTkrVS91RlJHTEdhcVQxT201eG00OEpLV0tPL2VWMlJ2ZkxlN09B?=
 =?utf-8?B?ZEIxVVNNSEIvQStmUkxuQ2NoWXVpUkFEYlFEcCs2cjFnQjFLWHkybWo0d2Y1?=
 =?utf-8?B?ZGswSGt5Y3ZLNmwwRmgzYjBEM3ByTHpPMXQrL0JEN0pPMUZuK01KbkNhZldL?=
 =?utf-8?B?WkpJWkx3LzlLRUVpVXVKcnM3UHljbEJlN09ZTStvcFl1cFRPQnloUXBBREZO?=
 =?utf-8?B?bmtoc3ZRN1NVaTk1M011SFU2U1pMdTZDWXZ0ekhMbHJYL2VYRlRRd2lRbDk1?=
 =?utf-8?B?QWRTWE9aUHRQMmpsRVlQSEhBTVhPa0R4WkNMK1Nlc0UzM3NlTllXZ1pQY01J?=
 =?utf-8?B?TTYvbVpzWlJKTTBjSW41SVJHcGxzZjZ5WHJpeUt6T056MHJ1aVdZS0hVVXo5?=
 =?utf-8?B?KzZHUk1zZWY3ZkcxbUxaT0Q4cFJDVVliRUNOOHY5aHdMNVFPQkNEWU9STUpr?=
 =?utf-8?B?UnYyZkRJeGtzTllIdGNnVEZaejZ4Tm5VTTVCVEJ2OGowUG5hTW9xV0s5LzFH?=
 =?utf-8?B?aDc2YWk4NENJNUYrUElEUGN5aGE2R2V4dml5SWVRT0dPRDJqVUVhdUJYTFdP?=
 =?utf-8?B?c2NkeHppK011SVYyQTZJZnFlNnE4WWlwUnQ2R0trckhyWENkK0NXVkR1TzlI?=
 =?utf-8?Q?pt/Dp68B5nJ91TAiIfQYJZ7vuZbEy0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVIwL3B4ZzlhY2VOdkRFTUlydWZoaVVIMFNNOFhsczMvbHgzUDFoeHFCS3J6?=
 =?utf-8?B?TlVtN1dSV2dlMVpMK25aYkVIQXFYM1ArdEl2QnZ3VmgyOXFCc2lpc2lVRVVa?=
 =?utf-8?B?ZDhyNzdINE5mc2pEeXVQK2VKSm0vRjhycXd1dVdWcnpiTjMvSjl5bUpSZ3JU?=
 =?utf-8?B?K0tTUnBUMkQ0ZE43YUFoSzhmVXdTK1Vhc1NFUUthemdoU2M2ZjY3VDVLYlpa?=
 =?utf-8?B?YXV3ZldLY2gzSTNENW5MYldKYWV5aGJDNjdEcVY2RG84bjh3N3NsR2dLZzFT?=
 =?utf-8?B?WXJYSzlVSnhFellVcXlmK3F3QURNT3E3Y2pyZmwwNVNsMW9aMDRndWc0ZU1O?=
 =?utf-8?B?VG56RFBISnl2YXRyMjViVXFVdWhXOWhhU0crTnRXRng0d29DNlp4eWtxbHpV?=
 =?utf-8?B?b2hLc3R1R3VsaE43K2RaTkcwbUlRbzYxU1FqN244Zmg3SHhHR0xISkt4QkZt?=
 =?utf-8?B?NFI5UHBmbE5XMVJ6dWhMd21TY21YTjhxRWs4U3lYaVFhSWRMUzVwMTdreVdq?=
 =?utf-8?B?bVBaSHZWcW1oajM5TXNiMGJCdHBuRkhMa3VwQU9jMnIwZHU0S3MzVmphd0dN?=
 =?utf-8?B?Sm9SWjFsTnJOYklEYXIrV1hEcGNzMzRHWDRGMGF0c1ZmMHJpL1dFVjZhelRu?=
 =?utf-8?B?ZUhuL3N5aWlCL3E2OUV2STlDdjNzbkZMVFhPRWZYUGU2cjE5N2RDTmxDbHF1?=
 =?utf-8?B?d3JVRGVYOXBDZmJlcmJxSVVqOG43cVdJRVZyWFZaOXZBUUFLQ3A1ZDBNZE83?=
 =?utf-8?B?dStXeEFmV3VmU0lrZnRrY3NWQm8zYjZpbTZIcHNlRVJXcVdVcUJiOHNTUXpD?=
 =?utf-8?B?V0FkalQvUlYwbkNxT3VLN2hpS20rVjBBcW1UUW05QWVnckdVQjc0cCtvQ0M4?=
 =?utf-8?B?My9iY2E4U3MvbGpKZTF6aWZ0RVhhNncvbHFLZ2RMOHFBSC9JZnl5YmlJUitq?=
 =?utf-8?B?NzRmb2xRWDhiVzIwL3dkNGthaWkrZSt4bEFXckRlWXVZaDNLWHFGL3IxWVZK?=
 =?utf-8?B?MmZ4SEpSaWozUkFsSnN4Q3oweHBQL2ZzQ2xybm94QmI5bXVzZlF3dTBCd2Jl?=
 =?utf-8?B?T3NycjV5T3A1WkFGcVJGWFhJNytuN2RvcHRuRWsyZUlxRWJid2pDSFBnVnNh?=
 =?utf-8?B?WWRMandkUzNORjRQV2UvM2F0QmxDejZrYTFlMFNmNFRoZTNCalp6OTF6Um1z?=
 =?utf-8?B?cDBiMkdCSzMzNUljQmlzK3BoMHo4Q0pKb0FSSkZXYXZWc0dQUHFKTGFkYVJT?=
 =?utf-8?B?anBtV1dCQTI3c2xkTmlqVEMxSXNIZG5CcHRRYVFzdi9XYXFrVmhlV04rTk02?=
 =?utf-8?B?WDNuNk5JZ0VXdmF2MG9iMkx4OWtWMzdnUzVlYkxNcXhmTUU5WjkvN2dhcVVM?=
 =?utf-8?B?bVZ0S21EbUlTMUJDdmFITjZmNnVjMDJEV05zdDhyUnNEek9tNFBmUkJGMmpF?=
 =?utf-8?B?czJ1RnFwekhzRXZMbHdLZHBYWDk0S2Y0MXhXQTJNbVQ4QUlUdEJ1NHhIbjha?=
 =?utf-8?B?MUlOQnlRdGNKQmlPMkljYU4xclM4bXoxVkY2QzJQMGp5K0k4emt4MWw2bDVp?=
 =?utf-8?B?blFmNGc5UXZ5UTF0aEgvTGRyWDMwWDNiVGpBb0hiR0RzdjVsM2Ivc1QzMXJP?=
 =?utf-8?B?MDJEV0s2TStQanNYMzZkTkxKUGpRWC9lWDNsOGdneDd1ckhETEtBeWtSbkxX?=
 =?utf-8?B?V3RWRlh2UEpmeUNKbjd6TjhibDA3SVRqT1g3SU9VODJreVZLWFJoMTJtNkhy?=
 =?utf-8?B?OEZ1S3Z6enR6Nkw3Yi8xR1JXL2FwdEs1dWZFZXViK05BUEwxSHVPNnZtbTJu?=
 =?utf-8?B?MUxaWWxVbTV4eUpLRDAwTFd2Wk94OUwwa2g3cTUwY3V5TlpVZFZXSEM2L08x?=
 =?utf-8?B?c0xzcCtoaE5YR1dvM2kxckt6ZEJNbGRiTzM2Zk9QMVZrRXBOWExaWmtjSCtX?=
 =?utf-8?B?UTFrYWtpT2NubGZKdkk3WExQZjFwcHFNS0tuLzdHMXY3OGI1WnBYU295RWF3?=
 =?utf-8?B?cHJsRStydDUwdG1SZXo4dVFhUEtMcXJzS25RMnJ0VWZ3M2tpREFEZS9GMkRO?=
 =?utf-8?B?aWFGT2NBYnlYTVM3Y2hvaXFqZGZWZE94aXVEMnBESCt4cTNyOXpZUnMyNnp3?=
 =?utf-8?Q?K340a5GN4Fyg8WNDsSfYv/uMv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d35ceeb5-ed7c-4bde-6b98-08de002ac021
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 14:07:54.7576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVuMbT0sRIEJQKogyAsYo+8eEb9JOaylGUIPRr28P5VBWt+DrVrqKT0HVIPeAodNlftxQRju0UMFiMOJvlKMlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9800



On 9/26/2025 5:04 PM, Dave Jiang wrote:
> On 9/25/25 3:34 PM, Terry Bowman wrote:
>> CXL Endpoint protocol errors are currently handled using PCI error
>> handlers. The CXL Endpoint requires CXL specific handling in the case of
>> uncorrectable error (UCE) handling not provided by the PCI handlers.
>>
>> Add CXL specific handlers for CXL Endpoints. Rename the existing
>> cxl_error_handlers to be pci_error_handlers to more correctly indicate
>> the error type and follow naming consistency.
>>
>> The PCI handlers will be called if the CXL device is not trained for
>> alternate protocol (CXL). Update the CXL Endpoint PCI handlers to call the
>> CXL UCE handlers.
>>
>> The existing EP UCE handler includes checks for various results. These are
>> no longer needed because CXL UCE recovery will not be attempted. Implement
>> cxl_handle_ras() to return PCI_ERS_RESULT_NONE or PCI_ERS_RESULT_PANIC. The
>> CXL UCE handler is called by cxl_do_recovery() that acts on the return
>> value. In the case of the PCI handler path, call panic() if the result is
>> PCI_ERS_RESULT_PANIC.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> ---
>>
>> Changes in v11->v12:
>> - None
>>
>> Changes in v10->v11:
>> - cxl_error_detected() - Change handlers' scoped_guard() to guard() (Jonathan)
>> - cxl_error_detected() - Remove extra line (Shiju)
>> - Changes moved to core/ras.c (Terry)
>> - cxl_error_detected(), remove 'ue' and return with function call. (Jonathan)
>> - Remove extra space in documentation for PCI_ERS_RESULT_PANIC definition
>> - Move #include "pci.h from cxl.h to core.h (Terry)
>> - Remove unnecessary includes of cxl.h and core.h in mem.c (Terry)
>> ---
>>  drivers/cxl/core/core.h |  17 +++++++
>>  drivers/cxl/core/ras.c  | 110 +++++++++++++++++++---------------------
>>  drivers/cxl/cxlpci.h    |  15 ------
>>  drivers/cxl/pci.c       |   9 ++--
>>  4 files changed, 75 insertions(+), 76 deletions(-)
>>
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index 8c51a2631716..74c64d458f12 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -6,6 +6,7 @@
>>  
>>  #include <cxl/mailbox.h>
>>  #include <linux/rwsem.h>
>> +#include <linux/pci.h>
>>  
>>  extern const struct device_type cxl_nvdimm_bridge_type;
>>  extern const struct device_type cxl_nvdimm_type;
>> @@ -150,6 +151,11 @@ void cxl_ras_exit(void);
>>  void cxl_switch_port_init_ras(struct cxl_port *port);
>>  void cxl_endpoint_port_init_ras(struct cxl_port *ep);
>>  void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
>> +pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
>> +				    pci_channel_state_t error);
>> +void pci_cor_error_detected(struct pci_dev *pdev);
>> +void cxl_cor_error_detected(struct device *dev);
>> +pci_ers_result_t cxl_error_detected(struct device *dev);
>>  #else
>>  static inline int cxl_ras_init(void)
>>  {
>> @@ -163,6 +169,17 @@ static inline void cxl_switch_port_init_ras(struct cxl_port *port) { }
>>  static inline void cxl_endpoint_port_init_ras(struct cxl_port *ep) { }
>>  static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>>  						struct device *host) { }
>> +static inline pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
>> +						  pci_channel_state_t error)
>> +{
>> +	return PCI_ERS_RESULT_NONE;
>> +}
>> +static inline void pci_cor_error_detected(struct pci_dev *pdev) { }
>> +static inline void cxl_cor_error_detected(struct device *dev) { }
>> +static inline pci_ers_result_t cxl_error_detected(struct device *dev)
>> +{
>> +	return PCI_ERS_RESULT_NONE;
>> +}
>>  #endif // CONFIG_CXL_RAS
>>  
>>  int cxl_gpf_port_setup(struct cxl_dport *dport);
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 14a434bd68f0..39472d82d586 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -129,7 +129,7 @@ void cxl_ras_exit(void)
>>  }
>>  
>>  static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base);
>> -static bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
>> +static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
>>  
>>  #ifdef CONFIG_CXL_RCH_RAS
>>  static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>> @@ -371,7 +371,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>>   * Log the state of the RAS status registers and prepare them to log the
>>   * next error status. Return 1 if reset needed.
>>   */
>> -static bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>> +static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>>  {
>>  	u32 hl[CXL_HEADERLOG_SIZE_U32];
>>  	void __iomem *addr;
>> @@ -380,13 +380,13 @@ static bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_bas
>>  
>>  	if (!ras_base) {
>>  		dev_warn_once(dev, "CXL RAS register block is not mapped");
>> -		return false;
>> +		return PCI_ERS_RESULT_NONE;
>>  	}
>>  
>>  	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
>>  	status = readl(addr);
>>  	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
>> -		return false;
>> +		return PCI_ERS_RESULT_NONE;
>>  
>>  	/* If multiple errors, log header points to first error from ctrl reg */
>>  	if (hweight32(status) > 1) {
>> @@ -403,76 +403,72 @@ static bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_bas
>>  	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
>>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>>  
>> -	return true;
>> +	return PCI_ERS_RESULT_PANIC;
>>  }
>>  
>> -void cxl_cor_error_detected(struct pci_dev *pdev)
>> +void cxl_cor_error_detected(struct device *dev)
> Why change the input parameter to 'struct device' to just convert it back in the first parameter? I understand that later on cxl_handle_proto_error() will pass in a 'dev', but since it's going to be a pci_dev anyways, can you just pass in a pci_dev instead of doing all this back and forth?

Dan made a point in previous revision that handling functions should work on 
devices (to include the parameter). This is to be consistent with CXL device/port error 
handling rather than PCIe error handling. Let me know how to proceed.

Terry
>>  {
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>> -	struct device *dev = &cxlds->cxlmd->dev;
>> +	struct device *cxlmd_dev = &cxlds->cxlmd->dev;
>>  
>> -	scoped_guard(device, dev) {
>> -		if (!dev->driver) {
>> -			dev_warn(&pdev->dev,
>> -				 "%s: memdev disabled, abort error handling\n",
>> -				 dev_name(dev));
>> -			return;
>> -		}
>> +	guard(device)(cxlmd_dev);
>>  
>> -		if (cxlds->rcd)
>> -			cxl_handle_rdport_errors(cxlds);
>> -
>> -		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
>> +	if (!cxlmd_dev->driver) {
>> +		dev_warn(&pdev->dev, "%s: memdev disabled, abort error handling", dev_name(dev));
>> +		return;
>>  	}
>> +
>> +	if (cxlds->rcd)
>> +		cxl_handle_rdport_errors(cxlds);
>> +
>> +	cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
>>  
>> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>> -				    pci_channel_state_t state)
>> +void pci_cor_error_detected(struct pci_dev *pdev)
>>  {
>> +	cxl_cor_error_detected(&pdev->dev);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(pci_cor_error_detected, "CXL");
>> +
>> +pci_ers_result_t cxl_error_detected(struct device *dev)
> Same comment as above.
>
> DJ
>
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>> -	struct cxl_memdev *cxlmd = cxlds->cxlmd;
>> -	struct device *dev = &cxlmd->dev;
>> -	bool ue;
>> +	struct device *cxlmd_dev = &cxlds->cxlmd->dev;
>>  
>> -	scoped_guard(device, dev) {
>> -		if (!dev->driver) {
>> -			dev_warn(&pdev->dev,
>> -				 "%s: memdev disabled, abort error handling\n",
>> -				 dev_name(dev));
>> -			return PCI_ERS_RESULT_DISCONNECT;
>> -		}
>> +	guard(device)(cxlmd_dev);
>>  
>> -		if (cxlds->rcd)
>> -			cxl_handle_rdport_errors(cxlds);
>> -		/*
>> -		 * A frozen channel indicates an impending reset which is fatal to
>> -		 * CXL.mem operation, and will likely crash the system. On the off
>> -		 * chance the situation is recoverable dump the status of the RAS
>> -		 * capability registers and bounce the active state of the memdev.
>> -		 */
>> -		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
>> -	}
>> -
>> -
>> -	switch (state) {
>> -	case pci_channel_io_normal:
>> -		if (ue) {
>> -			device_release_driver(dev);
>> -			return PCI_ERS_RESULT_NEED_RESET;
>> -		}
>> -		return PCI_ERS_RESULT_CAN_RECOVER;
>> -	case pci_channel_io_frozen:
>> +	if (!dev->driver) {
>>  		dev_warn(&pdev->dev,
>> -			 "%s: frozen state error detected, disable CXL.mem\n",
>> +			 "%s: memdev disabled, abort error handling\n",
>>  			 dev_name(dev));
>> -		device_release_driver(dev);
>> -		return PCI_ERS_RESULT_NEED_RESET;
>> -	case pci_channel_io_perm_failure:
>> -		dev_warn(&pdev->dev,
>> -			 "failure state error detected, request disconnect\n");
>>  		return PCI_ERS_RESULT_DISCONNECT;
>>  	}
>> -	return PCI_ERS_RESULT_NEED_RESET;
>> +
>> +	if (cxlds->rcd)
>> +		cxl_handle_rdport_errors(cxlds);
>> +
>> +	/*
>> +	 * A frozen channel indicates an impending reset which is fatal to
>> +	 * CXL.mem operation, and will likely crash the system. On the off
>> +	 * chance the situation is recoverable dump the status of the RAS
>> +	 * capability registers and bounce the active state of the memdev.
>> +	 */
>> +	return cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
>> +
>> +pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
>> +				    pci_channel_state_t error)
>> +{
>> +	pci_ers_result_t rc;
>> +
>> +	rc = cxl_error_detected(&pdev->dev);
>> +	if (rc == PCI_ERS_RESULT_PANIC)
>> +		panic("CXL cachemem error.");
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(pci_error_detected, "CXL");
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 3882a089ae77..189cd8fabc2c 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -77,19 +77,4 @@ static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
>>  int devm_cxl_port_enumerate_dports(struct cxl_port *port);
>>  struct cxl_dev_state;
>>  void read_cdat_data(struct cxl_port *port);
>> -
>> -#ifdef CONFIG_CXL_RAS
>> -void cxl_cor_error_detected(struct pci_dev *pdev);
>> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>> -				    pci_channel_state_t state);
>> -#else
>> -static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
>> -
>> -static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>> -						  pci_channel_state_t state)
>> -{
>> -	return PCI_ERS_RESULT_NONE;
>> -}
>> -#endif
>> -
>>  #endif /* __CXL_PCI_H__ */
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index bd95be1f3d5c..71fb8709081e 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -16,6 +16,7 @@
>>  #include "cxlpci.h"
>>  #include "cxl.h"
>>  #include "pmu.h"
>> +#include "core/core.h"
>>  
>>  /**
>>   * DOC: cxl pci
>> @@ -1112,11 +1113,11 @@ static void cxl_reset_done(struct pci_dev *pdev)
>>  	}
>>  }
>>  
>> -static const struct pci_error_handlers cxl_error_handlers = {
>> -	.error_detected	= cxl_error_detected,
>> +static const struct pci_error_handlers pci_error_handlers = {
>> +	.error_detected	= pci_error_detected,
>>  	.slot_reset	= cxl_slot_reset,
>>  	.resume		= cxl_error_resume,
>> -	.cor_error_detected	= cxl_cor_error_detected,
>> +	.cor_error_detected	= pci_cor_error_detected,
>>  	.reset_done	= cxl_reset_done,
>>  };
>>  
>> @@ -1124,7 +1125,7 @@ static struct pci_driver cxl_pci_driver = {
>>  	.name			= KBUILD_MODNAME,
>>  	.id_table		= cxl_mem_pci_tbl,
>>  	.probe			= cxl_pci_probe,
>> -	.err_handler		= &cxl_error_handlers,
>> +	.err_handler		= &pci_error_handlers,
>>  	.dev_groups		= cxl_rcd_groups,
>>  	.driver	= {
>>  		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,


