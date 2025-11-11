Return-Path: <linux-pci+bounces-40824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5103C4BA1C
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 07:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686F93B6754
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 06:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FC62BE639;
	Tue, 11 Nov 2025 06:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aW/O5v1h"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011019.outbound.protection.outlook.com [40.107.208.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7012882B6
	for <linux-pci@vger.kernel.org>; Tue, 11 Nov 2025 06:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762841963; cv=fail; b=lFqnQQunSV323/DHKZ463JN+4dEVEd4uu0VMtg0G2suYYRLioTgf61AxVHMHbGhsxe3ChAwVV6HxKpu2Pze69DPLlSiWZuGz4aMjIB/VvcnbNGklJEODYbq05hdEgCSpD1FEnxtlP67hfRIk9yL8KaZeJTW4AYEd2ePYzGwZUZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762841963; c=relaxed/simple;
	bh=eQAn9Z6P1wakCbcVdVyBdElY85o2Jh6w1GQW1dWfm90=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vd+IR+rHTQKOHpNs73x2jbQL4LZ9kaZEHMmfQGODZapDu4QnvynMZrH0/L8RR59o6lG73q9bOd9oSl2G15Gt9uHZqMEb3M5P9FDXJfsaufmtrRn5n/r83O3fE9cByVwJ/sTzD7YgRzICAHQ55mJbbLPWDI4Z4ce1t3MBH7Lc4a8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aW/O5v1h; arc=fail smtp.client-ip=40.107.208.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HFha2LgE38zhNhJCgn79BE9WTUFqIoHVzmke0qJQBbDsZUAWrknT6mbOmLwU4USEoFMQ6wGLZKccLx1SKb27auKxuINTt9LUMToIWJ+GVZGKZt7nNwlef7oiy//G7+Bgsz8C0EHmE1ylHuWTgVmCwbh2y/B0NdCmpF5VoJS+mKq34vv7E2bwScpJhyR1ShmEVa3CIpw0AKo8psX7PK0aXcMUu5FIoqvkUvXWLyFPjey9wxEAFx9LIIDYL2mwAAPj3XQF1JlxzZOF7mKEx6shys/yoYX4mPtYqCPN/eZ0l7LfA5aNJ61VXwge84prqD60UZAnrz1n2E4OGUw9pxFjtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjchM9fhh+pZipHzIFv9lYqyrID6MUNSNf1w4k5lnEc=;
 b=KsULSj0htuXv4Lz9rB1cc3VKze5gq7NV5CSVp2yqOv0sjtTt7k6LHocar9QnHdOyonNCowDrKjcm65KNd/2sXrafIzRgytFIsDsPcUUnQgmHV4aCrpKtdTZfhFEnMN5mOZHWvAvNYJ3x7kadmHh5B1x6M4RQ/L0MF2OPZBzgW+37pKr5w0BfjJZds0r/NXqLBz+wZenU7eZqLPhGAv19bv5qNJIhOEjtQ6cP/qHe/+R7LOOp6NVIvwLnR+CEbKvzx/HzBe2K8lT9exlKt7x/ayf1mn7s1LqKBCqC+YT5dmyM3SFTZee8dWF4ctetpTHgWW9wPkO57psmPhQBaNM+5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjchM9fhh+pZipHzIFv9lYqyrID6MUNSNf1w4k5lnEc=;
 b=aW/O5v1hpWc6DUblBbks7TjlA4RKixjUHYIv+MRYuttXM+bA7YtvIMLaSLYVKebvznRpw8+ohwuqjug9/SPTsf7kK24ehNO5xpVd72jVImbZKLRuDHCITzv1fHOnvfsi9QKQUYcp1/i/4Ek27G797n5VPUEcy/GeEDxPODlzJr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH8PR12MB7230.namprd12.prod.outlook.com (2603:10b6:510:226::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 06:19:16 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%7]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 06:19:16 +0000
Message-ID: <d8ea14c0-857e-4e83-9440-cf590e8b2b4b@amd.com>
Date: Tue, 11 Nov 2025 17:18:58 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH pciutils] ls-ecaps: Add XT and TEE-Limited support
 reporting
To: linux-pci@vger.kernel.org
Cc: =?UTF-8?Q?Martin_Mare=C5=A1?= <mj@ucw.cz>
References: <20251023071101.578312-1-aik@amd.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20251023071101.578312-1-aik@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0171.ausprd01.prod.outlook.com
 (2603:10c6:10:52::15) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH8PR12MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: b3b28110-ff93-4b58-a6ac-08de20ea3d80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTMxZjhWcEFGRWxxL1hKRzhGbFd1VE4xeHhEcGZXWlByY09TUktMTXVPbHBi?=
 =?utf-8?B?cGRlL2dZengyanVxcXQwWXNJcnRsZndsSXFTZUNNQWJkWWQ0cElJczRxUzcv?=
 =?utf-8?B?TFFoVUxkMEd1WFgwa2J6OHk1VzBZMEpBUk52WHpWZ1VmV0p1TExuWUhnRFgr?=
 =?utf-8?B?eC9zYlBxRlZEbS8vdXgrUFFEMWxkdE5ManFsZTVTcFVpLzBSZkdDenM5UkhU?=
 =?utf-8?B?SWVMUVc5RlY2ZUNjMzVXcXZ6NFM5Q21zUjkxeHpyT0JBcGtITnRVN1ZNUTll?=
 =?utf-8?B?M0pXTlVKZGdzUFd1Vzg2TmtwWDIrN2RtRmtrVldPcVJJUm8yakdIVlJ2bUR3?=
 =?utf-8?B?L0t6ZC9nWHZmV0VhNWw1ZnRvTnVWWDFFSUtOZEo0R2E3dkIxZ3B3VjNUZklE?=
 =?utf-8?B?enNyK1VPN1RNV0tlS0d5K0VKUnYxektJRHdNUUdOZDFpQmlsdVh0S2Ryc3ov?=
 =?utf-8?B?QzNYQ3J0ZUVaRDUvbE9YanRsQmdxV1V0aGJvQUxGMEdwQ0c0VXRkOUI1M0FQ?=
 =?utf-8?B?djlodzFJQU5sTGNia2hEclNtdzRMWFhtQkk2SXVJeGlHaHVNSXhvdUVkQktu?=
 =?utf-8?B?ZUdHQnB2aTVXeTViTlhiNUE1amRVSTJaNzFGUGd1QUZGUUpiZU0wUVVmd0V1?=
 =?utf-8?B?cUxRQnBzTzhKM2dGRUp2d3lwL2diYS91SkFkd3BoNzBaVlpBdDI1alVKWUVY?=
 =?utf-8?B?VVhwN2FnR094dUxwNlhET1JMcnU2WjdrSHRySUNueHliR2JlVk9meUwyMXpD?=
 =?utf-8?B?bGdyYzdoa3NJNWxPZXo0b2ZLM1RhZGh3Y2cyVDVkQlJlUHJ2QW9JRG52Z3ZU?=
 =?utf-8?B?cGhXaEJIUkVmVnZlbE81Vmhpelk5eGg1N1N5N1pxWVozWlhFWTV0VWhCenAw?=
 =?utf-8?B?WHJSZFZzYkhhTk5QbHpuMm13NGgyaWUxSU8wT09HQ21GMUFIVFBZV1BGY2hi?=
 =?utf-8?B?K0hkb0xIRTdrWHl3YW1jeTl3aUxOdmpKdXoxdHByK1RnQWE5T29nMjJYNEVJ?=
 =?utf-8?B?c0p3b3puWEtrdFI3WXNDMVpRU1AycTZ1dTZGZVdEc3pGbWFXczNzdmE0RjN5?=
 =?utf-8?B?bDlGRzhtYWthSWF0c0Vld2pLVXR3S2VKQ1pxWVFZU2h1R1YwNVdLa2hXTUFq?=
 =?utf-8?B?U1NDejR3M292eXV3eHRVek9RTFhtYkRQcW5lQ0RjNFowaU83TEo2a3BuK3Jh?=
 =?utf-8?B?czg3a1g4VTNtRVBoVHlQd1dveVFjSG45OFYveVFoQ3gzZ1A0aFJwY2NURzQv?=
 =?utf-8?B?Z0dHL2xGZlU1Zngrc1QxTFoxT0tsblNCRXQvZHRCb1Q4OWtSSTdqWi85M0Fy?=
 =?utf-8?B?WVZ2NTF2bEJERmlwUHJ0dmdtNTRpekVtai9Cajc3QXBoblV1OGIxTjNEQW5I?=
 =?utf-8?B?c3RvMkhmaVpBMmE3aURvU20vOGIvY0FtQVMvZWNuZUxNOHBrZmI4L05QNHZ0?=
 =?utf-8?B?aTgzWGtTc01OR1dtOGdITW9sSVdRTm4zSFNRMVRFMHVNZ0FNbjNnU1ZsZzhK?=
 =?utf-8?B?TG5xTUJDNTR2MnZXakl0R29IU2dLbDB3UythRGpwKzBsUEQ5ZHR3aG9FbXc0?=
 =?utf-8?B?RkR0dGlxaHUwZ2daV0FXWEZ2Q1E1OG1UUmhwZnZ5Zjk5RWRwem9Va1k4bDdR?=
 =?utf-8?B?eE5QUWs0eFdSVklBWEJCcEtzVmg1b0g4cEJ6VCtUbDZPNWdFamI5QjlqZVcw?=
 =?utf-8?B?ejlkRDQxNzdma1FVMjA0R1pnZlp4YVI0YTBSY0EwVXNxVDVYK2QzYTYyWmhU?=
 =?utf-8?B?QVJ0S0c1ZWZFaWJOVVhVWG9jS1FRZG04eXUxM1A5Uk9MWUtzNEdNb0xqdXpS?=
 =?utf-8?B?NWV2RGlEVFVEREliM0grOHR1NjJycVpjdncwU1pRekZjWEhxL29kekRRb05z?=
 =?utf-8?B?NmFYR2k1WFA1aExBeE5mK1ZFczhpenN4MVp5d1JMZ3B4OGtLcnEvaGFCNzAx?=
 =?utf-8?Q?vbM40j5WC2C+E2B3FUL5OmZ3hMUbzYK6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3RSaEFoQWptZkVOODRvSXRESFh3TjBNNmYwWUNWamVmTEh4ZHJob005R2wr?=
 =?utf-8?B?OGk3bUFyV3M5cVRMd1JVMWQrWmlpV0E1emJVMTRxOG42OThhMXE0ek05K0l1?=
 =?utf-8?B?K2tOaGVCbVI1S3hmcXVsV1JFTndwNWFEUmtTTG42UzgwOXRVcXNrL24zV2Fn?=
 =?utf-8?B?VGNEMllqcHcxQ3duZ1NIR2pzS3IyTjgzRXVvemRJa0lUcm41MGFxZjBjMEdt?=
 =?utf-8?B?MWR5bUxJUFowaXc3cXZBcFpJM0g5UGhyL3NxbENJQzZtWVBRdnZIdDFlaWFr?=
 =?utf-8?B?ckpsUis4WUpCWHJtU2JFcCtKTWNnRjFNZnZ1L0c3OUpvcWdSUU1naWQwSHc3?=
 =?utf-8?B?TjRnODNLM202dm0vLzJCTHpPMTJ3VE1hZ0w4OTNIUitxTlNKaFdmRjYwVW1X?=
 =?utf-8?B?VUFmWW9COUFiYjZUU1JTOWJiNHpjSEM3c08rRTlGZE4xSTJlVXRtV1JpRENp?=
 =?utf-8?B?a1B4K1lJWkw3TlliMHdHWlM0MHNETUdJUEh6RlA5TFc3c2llc0h3UkEyOXRk?=
 =?utf-8?B?QkNVSGxmQm5KZXRtU0R0NWVER1REZUU4M3hIUU1NMlViNk1VaEN6MXpkenkx?=
 =?utf-8?B?YWxmYklMWFpTTEpLdkNhbmVrdkdVRGlxV1VGSG8wTzZ1NEJVajRKWXNaZm5l?=
 =?utf-8?B?SWh3eHJVZlNnMDNPSTVlTWpsZERBd2hyQzFqLzFaOWkwa2U0ci94QkRpRXpo?=
 =?utf-8?B?cWZZaElVRnYxZXY5VTlzQ2RiQTFWQ3hRT2UwOGI5Mnk5NW9QY3ZWdFQ1QmFt?=
 =?utf-8?B?bUVsVVd4R0VUblUyYTVQVUlOUVlPcldkdWo3Qi9WbHRaL3AzcUl5UVE4N09j?=
 =?utf-8?B?OUtKeHNVU1l0L1dJamVLU3pjSHRPVXFmZkRlOEFhWXRmK0JOTWlKa3hlc0FJ?=
 =?utf-8?B?cHZYMzcwNGw2U25HaDYweDlBNmZUYjFlZkd5ekhzNmdURVh0Y2hFaFlJZDBv?=
 =?utf-8?B?S21kcnFNallnMWhPenEwRE1qbldwYTIxbVEwdlVzOUQ4Yi9CMmFJWnhTQ3hF?=
 =?utf-8?B?UkVobmt5QmhqZ20xK3JnUFA4aG94a3lUTExMOFQ3RGhQTitjcTZXeTE0QlMr?=
 =?utf-8?B?enRIU1hpVnFvYldlbHJqNHFkeUcwWFgxME9oZVEyb2JzQ0dQVnlueVlCd1A0?=
 =?utf-8?B?eTZlbXhHc1FjQS8yWGxUUERienZHVzlBWVNXelkybUoyM3V1alZXZC9TbEVp?=
 =?utf-8?B?c0tkdkx6Zmc4KzZ1V2p2bGoyS3dlNHZBYWZLTmRxaEdTK2NSSVpaUWI2RW9K?=
 =?utf-8?B?dVFNSWdaY0Z5T0tXRlVNNkhKYUZtaFpuRUZFbHE5NmcvQmJ4em5tQnFZYTFW?=
 =?utf-8?B?ZXVOSDJuanNiQ1MreHM3bmNpQmJ0RDBjeFhib2p2MExvR2FObU1HUjVFSHZt?=
 =?utf-8?B?cjFKTUhtaDZ5akgvTTlNWGtJR1FGWlFsZTV2MjV2MnFROXVQMTlYOS84UnZI?=
 =?utf-8?B?cXBDT2pCWkVZTXF6MWZhQkgwaHFQMVlJRnBraFN3OVZ5OEZmak1NQWZiSXFI?=
 =?utf-8?B?ekN6TE5yWjdQLzAxZWhrV3ZlbnBlRytpdEkrdmJZZDdjSnJyaHRmLzcwejQz?=
 =?utf-8?B?TkdiL0lpa1JMaUZkakZ3Y0N3ZHVwMzRpcktrUTNRM1JrVXJtb2o3UEZzbk8y?=
 =?utf-8?B?azVqTE96S2oxSWZZeHdWbHRZV2dFWnJ2ZGowa0lPQUhqdlNGWFdtWWpqU3JW?=
 =?utf-8?B?bEk2Wkx1S1NTc0tTQ1A5SjA2bmF6UGN1cFhYR1BoSkhFdWhYZ0pFUXhJbndV?=
 =?utf-8?B?cnVxQVdlYVBGQlJtc1RPdnRndjR3aTZxOUx0M3ZqZzZROWpCR3VTSk0zZlJz?=
 =?utf-8?B?VEtZeHYwV0NFM25Hdm9mdVpIOUw2S3U1Y1BXN2pqQ2xZS1p6bHYwS0ZlNkw4?=
 =?utf-8?B?YWRwZUcxQmxpditPOUZQRE8rbFJBWXVvZHF0N2lwcnQxTnhIRFhMVm1uTno3?=
 =?utf-8?B?M2MwYTQySWg5akIyclVObVFpTThhb1E1M2c4bTNmaEJqd0ZSeVBOMFplSUJz?=
 =?utf-8?B?QlpraEc2Y29NOUM5clNkZFFXUmhkd2g4RGdEMUZqZjB3TllERXBoQUpuQUZq?=
 =?utf-8?B?c1RTck5ROFowVzlKZ1g4eWtJcUw2azd1M2dBOXZPWktrVzNyd1dsREE3RHZZ?=
 =?utf-8?Q?YstYCZ3jA1mHYy+g0nmZAzNmZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b28110-ff93-4b58-a6ac-08de20ea3d80
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 06:19:16.1835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZcwnXt3GzYC5qZRVwdvQmzrSVuJ2cH8QDxtrrx5Wrap/Ixz7xlXAJ0W2MtX6+gnoCVLN4EaAovYhqrx14nMLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7230

Ping? Thanks,


On 23/10/25 18:11, Alexey Kardashevskiy wrote:
> PCIe r6.1 added TDISP with TEE Limited bits.
> PCIe r7.0 added XT mode for IDE TLPs.
> 
> Define new bits and update the test.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> ---
>   lib/header.h  |  5 +++++
>   ls-ecaps.c    | 13 +++++++++----
>   tests/cap-ide |  4 ++--
>   3 files changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/header.h b/lib/header.h
> index b68f2a0..c84b7a8 100644
> --- a/lib/header.h
> +++ b/lib/header.h
> @@ -1540,17 +1540,20 @@
>   #define  PCI_IDE_CAP_AGGREGATION_SUPP	0x10	/* Aggregation Supported */
>   #define  PCI_IDE_CAP_PCRC_SUPP		0x20	/* PCRC Supported */
>   #define  PCI_IDE_CAP_IDE_KM_SUPP	0x40	/* IDE_KM Protocol Supported */
> +#define  PCI_IDE_CAP_SEL_CFG_SUPP	0x80    /* Selective IDE for Config Request Support */
>   #define  PCI_IDE_CAP_ALG(x)	(((x) >> 8) & 0x1f) /* Supported Algorithms */
>   #define  PCI_IDE_CAP_ALG_AES_GCM_256	0	/* AES-GCM 256 key size, 96b MAC */
>   #define  PCI_IDE_CAP_LINK_TC_NUM(x)		(((x) >> 13) & 0x7) /* Number of TCs Supported for Link IDE */
>   #define  PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(x)	(((x) >> 16) & 0xff) /* Number of Selective IDE Streams Supported */
>   #define  PCI_IDE_CAP_TEE_LIMITED_SUPP   0x1000000 /* TEE-Limited Stream Supported */
> +#define  PCI_IDE_CAP_XT_SUPP		0x2000000 /* XT Supported */
>   #define PCI_IDE_CTL		0x8
>   #define  PCI_IDE_CTL_FLOWTHROUGH_IDE	0x4	/* Flow-Through IDE Stream Enabled */
>   #define PCI_IDE_LINK_STREAM		0xC
>   /* Link IDE Stream block, up to PCI_IDE_CAP_LINK_TC_NUM */
>   /* Link IDE Stream Control Register */
>   #define  PCI_IDE_LINK_CTL_EN		0x1	/* Link IDE Stream Enable */
> +#define  PCI_IDE_LINK_CTL_XT		0x2	/* Link IDE Stream XT Enable */
>   #define  PCI_IDE_LINK_CTL_TX_AGGR_NPR(x)(((x) >> 2) & 0x3) /* Tx Aggregation Mode NPR */
>   #define  PCI_IDE_LINK_CTL_TX_AGGR_PR(x)	(((x) >> 4) & 0x3) /* Tx Aggregation Mode PR */
>   #define  PCI_IDE_LINK_CTL_TX_AGGR_CPL(x)(((x) >> 6) & 0x3) /* Tx Aggregation Mode CPL */
> @@ -1567,6 +1570,7 @@
>   #define  PCI_IDE_SEL_CAP_BLOCKS_NUM(x)	((x) & 0xf) /* Number of Address Association Register Blocks */
>   /* Selective IDE Stream Control Register */
>   #define  PCI_IDE_SEL_CTL_EN		0x1	/* Selective IDE Stream Enable */
> +#define  PCI_IDE_SEL_CTL_XT		0x2	/* Selective IDE Stream XT Enable */
>   #define  PCI_IDE_SEL_CTL_TX_AGGR_NPR(x)	(((x) >> 2) & 0x3) /* Tx Aggregation Mode NPR */
>   #define  PCI_IDE_SEL_CTL_TX_AGGR_PR(x)	(((x) >> 4) & 0x3) /* Tx Aggregation Mode PR */
>   #define  PCI_IDE_SEL_CTL_TX_AGGR_CPL(x)	(((x) >> 6) & 0x3) /* Tx Aggregation Mode CPL */
> @@ -1576,6 +1580,7 @@
>   #define  PCI_IDE_SEL_CTL_ALG(x)		(((x) >> 14) & 0x1f) /* Selected Algorithm */
>   #define  PCI_IDE_SEL_CTL_TC(x)		(((x) >> 19) & 0x7)  /* Traffic Class */
>   #define  PCI_IDE_SEL_CTL_DEFAULT	0x400000 /* Default Stream */
> +#define  PCI_IDE_SEL_CTL_TEE_LIMITED	0x800000 /* TEE-Limited Stream */
>   #define  PCI_IDE_SEL_CTL_ID(x)		(((x) >> 24) & 0xff) /* Stream ID */
>   /* Selective IDE Stream Status Register */
>   #define  PCI_IDE_SEL_STS_STATUS(x)	((x) & 0xf) /* Selective IDE Stream State */
> diff --git a/ls-ecaps.c b/ls-ecaps.c
> index 0bb7412..ceeefd7 100644
> --- a/ls-ecaps.c
> +++ b/ls-ecaps.c
> @@ -1665,7 +1665,7 @@ cap_ide(struct device *d, int where)
>       if (l & PCI_IDE_CAP_SELECTIVE_IDE_SUPP)
>           selnum = PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(l) + 1;
>   
> -    printf("\t\tIDECap: Lnk=%d Sel=%d FlowThru%c PartHdr%c Aggr%c PCPC%c IDE_KM%c Alg='%s' TCs=%d TeeLim%c\n",
> +    printf("\t\tIDECap: Lnk=%d Sel=%d FlowThru%c PartHdr%c Aggr%c PCPC%c IDE_KM%c SelCfg%c Alg='%s' TCs=%d TeeLim%c XT%c\n",
>         linknum,
>         selnum,
>         FLAG(l, PCI_IDE_CAP_FLOWTHROUGH_IDE_SUPP),
> @@ -1673,9 +1673,11 @@ cap_ide(struct device *d, int where)
>         FLAG(l, PCI_IDE_CAP_AGGREGATION_SUPP),
>         FLAG(l, PCI_IDE_CAP_PCRC_SUPP),
>         FLAG(l, PCI_IDE_CAP_IDE_KM_SUPP),
> +      FLAG(l, PCI_IDE_CAP_SEL_CFG_SUPP),
>         ide_alg(buf2, sizeof(buf2), PCI_IDE_CAP_ALG(l)),
>         PCI_IDE_CAP_LINK_TC_NUM(l) + 1,
> -      FLAG(l, PCI_IDE_CAP_TEE_LIMITED_SUPP)
> +      FLAG(l, PCI_IDE_CAP_TEE_LIMITED_SUPP),
> +      FLAG(l, PCI_IDE_CAP_XT_SUPP)
>         );
>   
>       l = get_conf_long(d, where + PCI_IDE_CTL);
> @@ -1697,10 +1699,11 @@ cap_ide(struct device *d, int where)
>             {
>               // Link IDE Stream Control Register
>               l = get_conf_long(d, off);
> -            printf("\t\t%sLinkIDE#%d Ctl: En%c NPR%s PR%s CPL%s PCRC%c HdrEnc=%s Alg='%s' TC%d ID%d\n",
> +            printf("\t\t%sLinkIDE#%d Ctl: En%c XT%c NPR%s PR%s CPL%s PCRC%c HdrEnc=%s Alg='%s' TC%d ID%d\n",
>                 offstr(offs, off),
>                 i,
>                 FLAG(l, PCI_IDE_LINK_CTL_EN),
> +              FLAG(l, PCI_IDE_LINK_CTL_XT),
>                 aggr[PCI_IDE_LINK_CTL_TX_AGGR_NPR(l)],
>                 aggr[PCI_IDE_LINK_CTL_TX_AGGR_PR(l)],
>                 aggr[PCI_IDE_LINK_CTL_TX_AGGR_CPL(l)],
> @@ -1744,10 +1747,11 @@ cap_ide(struct device *d, int where)
>           // Selective IDE Stream Control Register
>           l = get_conf_long(d, off);
>   
> -        printf("\t\t%sSelectiveIDE#%d Ctl: En%c NPR%s PR%s CPL%s PCRC%c CFG%c HdrEnc=%s Alg='%s' TC%d ID%d%s\n",
> +        printf("\t\t%sSelectiveIDE#%d Ctl: En%c XT%c NPR%s PR%s CPL%s PCRC%c CFG%c HdrEnc=%s Alg='%s' TC%d TeeLim%c ID%d%s\n",
>             offstr(offs, off),
>             i,
>             FLAG(l, PCI_IDE_SEL_CTL_EN),
> +          FLAG(l, PCI_IDE_SEL_CTL_XT),
>             aggr[PCI_IDE_SEL_CTL_TX_AGGR_NPR(l)],
>             aggr[PCI_IDE_SEL_CTL_TX_AGGR_PR(l)],
>             aggr[PCI_IDE_SEL_CTL_TX_AGGR_CPL(l)],
> @@ -1756,6 +1760,7 @@ cap_ide(struct device *d, int where)
>             TABLE(hdr_enc_mode, PCI_IDE_SEL_CTL_PART_ENC(l), buf1),
>             ide_alg(buf2, sizeof(buf2), PCI_IDE_SEL_CTL_ALG(l)),
>             PCI_IDE_SEL_CTL_TC(l),
> +          FLAG(l, PCI_IDE_SEL_CTL_TEE_LIMITED),
>             PCI_IDE_SEL_CTL_ID(l),
>             (l & PCI_IDE_SEL_CTL_DEFAULT) ? " Default" : ""
>             );
> diff --git a/tests/cap-ide b/tests/cap-ide
> index edae551..eabf5ea 100644
> --- a/tests/cap-ide
> +++ b/tests/cap-ide
> @@ -76,10 +76,10 @@ e1:00.0 Class 0800: Device aaaa:bbbb
>   		PASIDCap: Exec+ Priv+, Max PASID Width: 10
>   		PASIDCtl: Enable+ Exec- Priv-
>   	Capabilities: [830 v1] Integrity & Data Encryption
> -		IDECap: Lnk=0 Sel=1 FlowThru- PartHdr- Aggr- PCPC- IDE_KM+ Alg='AES-GCM-256-96b' TCs=8 TeeLim+
> +		IDECap: Lnk=0 Sel=1 FlowThru- PartHdr- Aggr- PCPC- IDE_KM+ SelCfg- Alg='AES-GCM-256-96b' TCs=8 TeeLim+ XT-
>   		IDECtl: FTEn-
>   		SelectiveIDE#0 Cap: RID#=1
> -		SelectiveIDE#0 Ctl: En+ NPR- PR- CPL- PCRC- CFG- HdrEnc=no Alg='AES-GCM-256-96b' TC0 ID0 Default
> +		SelectiveIDE#0 Ctl: En- XT- NPR- PR- CPL- PCRC- CFG- HdrEnc=no Alg='AES-GCM-256-96b' TC0 TeeLim- ID0
>   		SelectiveIDE#0 Sta: secure RecvChkFail-
>   		SelectiveIDE#0 RID: Valid+ Base=0 Limit=ffff SegBase=0
>   		SelectiveIDE#0 RID#0: Valid+ Base=0 Limit=ffffffffffffffff

-- 
Alexey


