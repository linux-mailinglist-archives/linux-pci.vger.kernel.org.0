Return-Path: <linux-pci+bounces-34918-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C4EB383A5
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 15:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1783C7C6088
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 13:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48F3303CAD;
	Wed, 27 Aug 2025 13:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jTwE6Kmf"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC490284B41
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756301171; cv=fail; b=OitbMo6nZ95GzUF229YqB7BiO0LQvJJ56LHitH9A+FAvzWa6fngO2eVP9elsYajWaE/3blmiBFm2mNfZE2/5s2qcGSGYhd+mX5UiqZZ6nDDYCaCNJZms9Z3vZtaT9u8EmIphI9O0Zpz9G6tgBd5Q9fQ2AOKoxn8/h0qpirUaprg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756301171; c=relaxed/simple;
	bh=PpNlJe/2M9dgDKnh8cdCR7zIjGru6sYR2B/oi1qz2y4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VhXAkcNS79tSVeX8lW6A1qHQ9gnAuLjzDFiI5txz3vtw4mmlyOJrHBagRl9tb9f9FkzBQ7U/gFQVmhF17x2rNkg5hBxWgRwbQKUbuW6X0rmjqP3jIkexd56bODETwB7HoU9lPg9aDb/0/Yddyjo4dtaSpmKgZWHBX6QEw7hKe1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jTwE6Kmf; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBLHkP1D1HD/Dl78ORpAQtKKYsaNZJTClwRqmAcDrtp5Gp0Dpi43rH15iTxQUU5mS8ewOjLotiVEdV3fdZwbNjAb1lAps8elrg/0QpPk7ZsXxdmX7hHJuphR52b7EpebEeKOiL0xnyzT8BqdVPxXq/SxSJ/NtfwWl6BEjcfJPWLMUsdOJBtQ6ssymATr5L0fxbynKEfdXLcnqJTkbpNmnqLt5tq6Hoi1Qy/+6+Lpo6OUfmPN9fgkWxHJOOnPLNR+IRUkD1o7gC3mRhXY4ShqUUZXCbP7SJP0D1fOLNfYi7qKMbQP4TuHo/+xgdUVEVQ/UPYmtISqDOB79ndSxCfp6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzeQUjXhv6K9a9FUfvRQK6fBtHH9vw3R9UoHGLiSFdk=;
 b=ARjh5wsg0mA8yZm5bKW0h3THZPahV/w2xY8Y0Jc8G0h3ivnOGifGlJ40cf81WqRvWXYK4X3HNsX7lVuN7EUAg8LGfYL7nzsMAGiTWzrvFLgv4BWEHKoGAEr2ihNsFcd5Oczjh8s9naQFeQwwqJW4nwIsS5uo5bIvRAq84azgz2WI3VCNxqp6uPB/Kp5O6Y25CRERmYGYrZuuZpBwODnx0XtP1JmVJTMXuisq/+Y1HIFfARVEaf510HZ96jVudxi06TgBXBUy9AeJgqoxDSk1csdkpb+6rCuRZLh4L9FnIpBSGuJcUl15al86t2sOA/GLa1fDDZj5c4oBos4Ojt1PAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzeQUjXhv6K9a9FUfvRQK6fBtHH9vw3R9UoHGLiSFdk=;
 b=jTwE6KmfdTZOYRCpuZvX1u4eUFzCcaqE8/yJ8MMI7O7dIyUc+yw/WNjm9kHpdJwDv4bQQPOZ+gDN/h+qXjO3q4coQkbWxXYxyosZz7l77KQrrGFaAmrDJmW7O615dXPfqcp9MBarTvy9aX05AITzQTCnGOssj9hXKVyEcB8ex38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DS7PR12MB6285.namprd12.prod.outlook.com (2603:10b6:8:96::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Wed, 27 Aug 2025 13:26:04 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9052.021; Wed, 27 Aug 2025
 13:26:04 +0000
Message-ID: <c2019b3e-f939-49c8-82e8-400b54a8e71f@amd.com>
Date: Wed, 27 Aug 2025 23:25:58 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v5 04/10] PCI/TSM: Authenticate devices via platform TSM
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: yilun.xu@linux.intel.com, aneesh.kumar@kernel.org,
 gregkh@linuxfoundation.org, Lukas Wunner <lukas@wunner.de>,
 Samuel Ortiz <sameo@rivosinc.com>, Bjorn Helgaas <bhelgaas@google.com>
References: <20250827035126.1356683-1-dan.j.williams@intel.com>
 <20250827035126.1356683-5-dan.j.williams@intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20250827035126.1356683-5-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0066.ausprd01.prod.outlook.com
 (2603:10c6:10:2::30) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DS7PR12MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: 8218c32b-9dea-4a50-7c68-08dde56d45b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmJJMGR6UHFRQWNXRmdFSi9jMFZ6L3RKWjdWZTBiOW1IRlhFUExlQ0NFdldT?=
 =?utf-8?B?YUd0UXc5LzJUM2NkVnpzZ05OUmFhdndnUWl0SURxa2hFQjZvVUU0c2YvbUsy?=
 =?utf-8?B?NkdRVVpLQk5KVmhPQk5mZEJyWkU0T2lNbVZjWmY5cFpvRmpEUjBZMHpyaVV5?=
 =?utf-8?B?NlNVTjhGTitZMUY5anc1RHJ5QmI2NzJmRXpiSUtva2tXdTg0RDR3VVU0cjJq?=
 =?utf-8?B?anl6L2VzWGlDby8vWFNlOVVYTzR5N0txK1V5TU1zZXYyaFFBY2R0UjEwakg3?=
 =?utf-8?B?TStsNG45c2xHTGd4bkdILzk1bUtaN1doMzhBdjJ1dGxzRFNMSHN4bXgzYUpN?=
 =?utf-8?B?djZtNUNXMW93Q050WDJ3VzdUS2xTdzllZlY3dFRMenlQMk83QldFa0U4dmlS?=
 =?utf-8?B?T3RSVjh0eG80bm9YU21TbG9FUGxWRklTZGtEdHdMUTFFRWE5TWJVamRFR2cw?=
 =?utf-8?B?d1A2Zk5UT0JYSlh0VWpEUjlldmVlNDVWdk9xNzY1UTNiWTE5Tk51bytUeHJn?=
 =?utf-8?B?NUF2eExYTGNqZkJISFV5ckZvS0F4NlF1WkEyTW1GamZ3NUI0NmdPd2xOaTRG?=
 =?utf-8?B?VVFSWDVBMGYzWW5RQnlyZzFibjZ5V1FqRTVXTDlPQkVxMDRWczRFSEhUSWNi?=
 =?utf-8?B?aFZJK2NxZ2I1MTUzUjFnUDNPT2JIU3ZXa204YU92WTFsbkh1d05NcndKRnd0?=
 =?utf-8?B?cm9hdkpuL1pYOFhJWmJXUzI5dnFiK1hmVTk3S05ZWHkrcDZwRnJYVTdEUmJB?=
 =?utf-8?B?SFh4M3R5Mk9ZVlNtalRuNEM3NUJZWFBiUFpocWRmUDdSVE9pckxEaUdFdjhD?=
 =?utf-8?B?VHFOTlZsYmxjbmRwOXBXYWtGRDFOOWU4UFhDbXhJOUQ3L1czc3ZpVFZOUmh4?=
 =?utf-8?B?ZENBQjNGY0J6dCtRd2FvSnpBeVBvZFhheDVZMGZPcGwxVGxwbm1YdWtpQ3Fr?=
 =?utf-8?B?SXVOS0QraXpvSXRwVDVkVGVrKytrZ0VVMzM3UW9md2VOM3VnNmdxQ01oc2t0?=
 =?utf-8?B?ckQ3K050YmNqYTFDeVZ1STd5VlNLcDlwR0Y5dHdQVXNTRjhIRGRCdDZjYWFX?=
 =?utf-8?B?b3MyVlBqR0pmOWhJZkREUno3VWk0bk1zRjdNWFo4eW4rd21JN1poTVoydkVh?=
 =?utf-8?B?OE0xb1Zremp4QytJdlRFWEZ2ODkxWTN1R2x6Q3lZeXZxb2Mrejh4UGt1MlRK?=
 =?utf-8?B?Rmxwb0FLcURCQXJ3ZEU2eWFMZGJrNUxPZm1YOGFhZnFidmtBQlVwV1FlR21S?=
 =?utf-8?B?Q2FTRnpEdndvclZnSWpBc3JkWFpNblRKR1l3Zjc5K3RDaUk0cUlsa0RaM1pW?=
 =?utf-8?B?bXpkU0lFVnFDczJMakRhWE9NbVdoMWdmc2s0VlhzWk1SWm5xVTFSVkhLODlO?=
 =?utf-8?B?V2RnRUdLR1FEeUlIWEVxY01FMzZQcGg1Q0ppbXFoaDFqOEQ0WDVSdXcvRS9I?=
 =?utf-8?B?UFlIVmxkcmlWV1dHVlVoMmcxZ2VWSmwrZ3Y1NDc5WndUbjN2Zlc4NWtwOUty?=
 =?utf-8?B?SEJjd0xIUCs3THF3SWZMTDNuN2RacnpnUlFWMmxkVnpVY2dGOEpYTnlGYmlu?=
 =?utf-8?B?dFpkUXJteGJjY2xkSVNPTlBOUUlzNnNwN1BNNlgvN05zQVVsbGdXU2RtdXA2?=
 =?utf-8?B?Tm9LdWx6UWNPclVFS1hyQitzZVRGQi9CSVJjK0Vma3V3SEU0YVZPWVZRck04?=
 =?utf-8?B?OFBSLzdTdDhEdmQ3WEE1bTdNbTRZT2Z3QUhVM2s4WXQ0eHJmaGNIUDBuRzhs?=
 =?utf-8?B?S1A2WnNoVVk1UURYcVZmOW9zcHUvdGtJanVEMlFIbjdlK2dWZzVkekVmUnBR?=
 =?utf-8?B?RWZPeGhNYy9vcVRqRi9ZOTJhRTNWb2FtbjM3eGFoN05rdThRUUFVWU5zb1hj?=
 =?utf-8?B?ZjFyOVkyWUJRT2c0WDlsMDRrQVUza213bklaM2x4UjZQM3ZSaXVlcUtwVVpP?=
 =?utf-8?Q?r9RvT+lZ5ZU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aG4zZS9UVmhUcitLcGJGanpyVm5jamNuY0FoL2hDRHJVb0NQWlVNekdYUlZS?=
 =?utf-8?B?a0FuRkxWaHVOTldCa00rc2Y4ZEJzVE9XMnhhOUYrU2RjTmNXUmVKcWxJOFp4?=
 =?utf-8?B?TnkzVGsrRThqTy9DYUdQbVluaHU0eFNZSmUzek1FbmR0VGFnS1JQUU5JeVNp?=
 =?utf-8?B?NzhBcyt0QUdQNmgycUlCY3pXdXhGejBTMmR2Z1FGZ2d3SGhrd3VSSDY4TFdo?=
 =?utf-8?B?cURkaE4va2pIeFBrQ2xEMFZTNGtxbnFWcWJ5dG9sRzgrTW83N2hrWXFIelJ0?=
 =?utf-8?B?U1NWRWdZRkhOQkl2bHFOS0lQcWtRZzR2Ky9zYWpJOExOQjBka3dWWnVzVDNa?=
 =?utf-8?B?bTNHTlNkMFl4ajJoaTJ4NGI0Z1UrZm1zT1MzZGZRbStzUXJidCtWdm9uVTVn?=
 =?utf-8?B?WEJ1V1BWVjhHTHhsckpHR1hqQ09oY1R0Mno2WXJxUzBrbHgvYTdLdytZaTZ0?=
 =?utf-8?B?OGcyVkVUZnhZeUY0aS9FT1JYQXBpNGZQQ25tcHZGN29ObHpJOXF1dk9EK0FX?=
 =?utf-8?B?TlJDeTdXMU94T01JRlpySkY5TmorYnhHcHZQWGtoMTVLY29qZ091L1ZwM0RK?=
 =?utf-8?B?RDhSbER3Mml3RnZrVm8zMXN4Q0JtcW80Z2xJVkRQN0FGNytaR1ZCQVFGNGJp?=
 =?utf-8?B?WFlkZ285QXZ2Ym13OWNiRHdselZiUjNmSi8rbnpHT2VseVA1M28xNmRJaTFa?=
 =?utf-8?B?R1M0VFovQ3BwVm5sc1NMa0Nnd2FQNlBjRGxoeTBaalIxQm1ZTVA5ZFhKdElT?=
 =?utf-8?B?cFkxdi9zUENFU0RCTHYvVDhnRy9XVGpvOEs4YTFDQ0EwdXBOZE9kbzRNSDQ5?=
 =?utf-8?B?aGp6Y0dpck1iWUFqZktmSkZndnhDZUg3Sk9OY3A1YlEwOTZQZkFFMGlqdzZh?=
 =?utf-8?B?aHBNMGVKaTFFYm0zMENtOXg1WS93SnBOSEI4b253SFQ5anBSc2RaQWZLTGtN?=
 =?utf-8?B?bFp3NGVsd2RyM0xkWWZtcm9VcVQ3SzVWSFkwOTJFQzgrWG5kQm1nTU5KbU9C?=
 =?utf-8?B?Rzl2c0NOeGN4NHRGRXpFRU5scjNyY0ZnMGJGSmVybEsyajlkUTZLN0xHVTFY?=
 =?utf-8?B?WHphYkRFUVZ4RGR2L05RMnJnLzdxYmdaRUN5TzFicFgzSWVGWm1TTURrYmVy?=
 =?utf-8?B?YTJXSmlrL2IwVHQyQ004MlNNQktkeXgzV21wVk5mUFFlYk1VNzBmZjJseDd3?=
 =?utf-8?B?UmlGSWJrZkRGNWVhbk9NQ0RoenFBdG05d0szQ1lORTgyd2M0SFRiZW50dHdG?=
 =?utf-8?B?aVR2dmhwR3JldStXVGcycHpmT0JhYzNublNGd3JDRlFrVWdsdUFESDUyWUln?=
 =?utf-8?B?N0ppSmVlZzcybEJ4NG5ISHNnYnJJWkVWVWFXUkNGTGdsb083SVQzQ09hTWVP?=
 =?utf-8?B?N2dLS2I0OER5ZEFoL3ZZWStkSzRxcmNvczBJdmt6RkhHZEJwRlJiU0tWM3hI?=
 =?utf-8?B?N3hLenMybm5WZjIrZ1N5eXZpK09pdlA2dXJvNWZibmNiK0ZvSWdldmpJQkdF?=
 =?utf-8?B?dGVBWHFRRUNzTlVXKzlkb3IvSklUOFFRN0o3cmFIQ2EzVnJZUU9QeGcwZ296?=
 =?utf-8?B?aXl1WmpQNFc5a2tORWRuNzJMNExpNWRzRWVWN1NoQytWaXoyMnF1NzJXRVVr?=
 =?utf-8?B?QzBoOVJUeW9WYVcvaFdvZDBxUWlZZ2Jvb1pSVFNNWlV3eGFkeWd4UCtCV1oy?=
 =?utf-8?B?cXBPTFNnQ0paNnRZWTRJZWliZWlpZUZsdzNrd2VFUXBJOEoyMlR2K0xtY2xM?=
 =?utf-8?B?cHgrSmQvRlUySmRiSmJveXV6czBmUjFRSkVFcDdnYXR0eGJra3RFd2YxYlBt?=
 =?utf-8?B?dVNLKzFoTVRrUlZseFJRQURLdVc0WjZRRk1JbXY4di9xUjlXaGUvRHZNbUlW?=
 =?utf-8?B?SkxaUnZLUWtnZWEwOGorQkZiYUJnTUFMTGdzaHhFUGVITzlmOWp4aE1WcFdX?=
 =?utf-8?B?MHREVElxWFV6SkhzL3dMNXhURWFjZDYzWG1qenYwamV2TmlaWEtXNHA5SFFa?=
 =?utf-8?B?cS9oT0F6cnVsQ3cvUWd6UXFjUGtJNmV2LzRDemUyZVgyaEt0T3kzbDVVcU5p?=
 =?utf-8?B?OXcyYXVmc0RtVTc4KzZZU2dSRnpzaGpESnZpYmU1M2t2SjVKa1dkR1I1dFpu?=
 =?utf-8?Q?bv+lAQf9frJd++JsVFN+Tmtj2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8218c32b-9dea-4a50-7c68-08dde56d45b7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 13:26:04.4092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oK7FB3qrdUg2wu4WjRjZZDXgRTk5pLpYJf1558UpzeKQJDxeE+dWeloVJ12R8IzV2QCqGo0B291WlEDVNy4D+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6285



On 27/8/25 13:51, Dan Williams wrote:
> The PCIe 7.0 specification, section 11, defines the Trusted Execution
> Environment (TEE) Device Interface Security Protocol (TDISP).  This
> protocol definition builds upon Component Measurement and Authentication
> (CMA), and link Integrity and Data Encryption (IDE). It adds support for
> assigning devices (PCI physical or virtual function) to a confidential VM
> such that the assigned device is enabled to access guest private memory
> protected by technologies like Intel TDX, AMD SEV-SNP, RISCV COVE, or ARM
> CCA.
> 
> The "TSM" (TEE Security Manager) is a concept in the TDISP specification
> of an agent that mediates between a "DSM" (Device Security Manager) and
> system software in both a VMM and a confidential VM. A VMM uses TSM ABIs
> to setup link security and assign devices. A confidential VM uses TSM
> ABIs to transition an assigned device into the TDISP "RUN" state and
> validate its configuration. From a Linux perspective the TSM abstracts
> many of the details of TDISP, IDE, and CMA. Some of those details leak
> through at times, but for the most part TDISP is an internal
> implementation detail of the TSM.
> 
> CONFIG_PCI_TSM adds an "authenticated" attribute and "tsm/" subdirectory
> to pci-sysfs. Consider that the TSM driver may itself be a PCI driver.
> Userspace can watch for the arrival of a "TSM" device,
> /sys/class/tsm/tsm0/uevent KOBJ_CHANGE, to know when the PCI core has
> initialized TSM services.
> 
> The operations that can be executed against a PCI device are split into
> two mutually exclusive operation sets, "Link" and "Security" (struct
> pci_tsm_{link,security}_ops). The "Link" operations manage physical link
> security properties and communication with the device's Device Security
> Manager firmware. These are the host side operations in TDISP. The
> "Security" operations coordinate the security state of the assigned
> virtual device (TDI). These are the guest side operations in TDISP. Only
> link management operations are defined at this stage and placeholders
> provided for the security operations.
> 
> The locking allows for multiple devices to be executing commands
> simultaneously, one outstanding command per-device and an rwsem
> synchronizes the implementation relative to TSM
> registration/unregistration events.
> 
> Thanks to Wu Hao for his work on an early draft of this support.
> 
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   Documentation/ABI/testing/sysfs-bus-pci |  51 ++
>   Documentation/driver-api/pci/index.rst  |   1 +
>   Documentation/driver-api/pci/tsm.rst    |  12 +
>   MAINTAINERS                             |   4 +-
>   drivers/pci/Kconfig                     |  15 +
>   drivers/pci/Makefile                    |   1 +
>   drivers/pci/doe.c                       |   2 -
>   drivers/pci/pci-sysfs.c                 |   4 +
>   drivers/pci/pci.h                       |  10 +
>   drivers/pci/probe.c                     |   3 +
>   drivers/pci/remove.c                    |   6 +
>   drivers/pci/tsm.c                       | 601 ++++++++++++++++++++++++
>   drivers/virt/coco/tsm-core.c            |  49 +-
>   include/linux/pci-doe.h                 |   4 +
>   include/linux/pci-tsm.h                 | 143 ++++++
>   include/linux/pci.h                     |   3 +
>   include/linux/tsm.h                     |   6 +-
>   include/uapi/linux/pci_regs.h           |   1 +
>   18 files changed, 910 insertions(+), 6 deletions(-)
>   create mode 100644 Documentation/driver-api/pci/tsm.rst
>   create mode 100644 drivers/pci/tsm.c
>   create mode 100644 include/linux/pci-tsm.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 69f952fffec7..e0c8dad8d889 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -612,3 +612,54 @@ Description:
>   
>   		  # ls doe_features
>   		  0001:01        0001:02        doe_discovery
> +
> +What:		/sys/bus/pci/devices/.../tsm/
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		This directory only appears if a physical device function
> +		supports authentication (PCIe CMA-SPDM), interface security
> +		(PCIe TDISP), and is accepted for secure operation by the
> +		platform TSM driver. This attribute directory appears
> +		dynamically after the platform TSM driver loads. So, only after
> +		the /sys/class/tsm/tsm0 device arrives can tools assume that
> +		devices without a tsm/ attribute directory will never have one;
> +		before that, the security capabilities of the device relative to
> +		the platform TSM are unknown. See
> +		Documentation/ABI/testing/sysfs-class-tsm.
> +
> +What:		/sys/bus/pci/devices/.../tsm/connect
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RW) Write the name of a TSM (TEE Security Manager) device from
> +		/sys/class/tsm to this file to establish a connection with the
> +		device.  This typically includes an SPDM (DMTF Security
> +		Protocols and Data Models) session over PCIe DOE (Data Object
> +		Exchange) and may also include PCIe IDE (Integrity and Data
> +		Encryption) establishment. Reads from this attribute return the
> +		name of the connected TSM or the empty string if not
> +		connected. A TSM device signals its readiness to accept PCI
> +		connection via a KOBJ_CHANGE event.
> +
> +What:		/sys/bus/pci/devices/.../tsm/disconnect
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(WO) Write the name of the TSM device that was specified
> +		to 'connect' to teardown the connection.
> +
> +What:		/sys/bus/pci/devices/.../authenticated
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		When the device's tsm/ directory is present device
> +		authentication (PCIe CMA-SPDM) and link encryption (PCIe IDE)
> +		are handled by the platform TSM (TEE Security Manager). When the
> +		tsm/ directory is not present this attribute reflects only the
> +		native CMA-SPDM authentication state with the kernel's
> +		certificate store.
> +
> +		If the attribute is not present, it indicates that
> +		authentication is unsupported by the device, or the TSM has no
> +		available authentication methods for the device.
> +
> +		When present and the tsm/ attribute directory is present, the
> +		authenticated attribute is an alias for the device 'connect'
> +		state. See the 'tsm/connect' attribute for more details.
> diff --git a/Documentation/driver-api/pci/index.rst b/Documentation/driver-api/pci/index.rst
> index a38e475cdbe3..9e1b801d0f74 100644
> --- a/Documentation/driver-api/pci/index.rst
> +++ b/Documentation/driver-api/pci/index.rst
> @@ -10,6 +10,7 @@ The Linux PCI driver implementer's API guide
>   
>      pci
>      p2pdma
> +   tsm
>   
>   .. only::  subproject and html
>   
> diff --git a/Documentation/driver-api/pci/tsm.rst b/Documentation/driver-api/pci/tsm.rst
> new file mode 100644
> index 000000000000..59b94d79a4f2
> --- /dev/null
> +++ b/Documentation/driver-api/pci/tsm.rst
> @@ -0,0 +1,12 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
> +
> +========================================================
> +PCI Trusted Execution Environment Security Manager (TSM)
> +========================================================
> +
> +.. kernel-doc:: include/linux/pci-tsm.h
> +   :internal:
> +
> +.. kernel-doc:: drivers/pci/tsm.c
> +   :export:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 024b18244c65..f1aabab88c79 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25619,8 +25619,10 @@ L:	linux-coco@lists.linux.dev
>   S:	Maintained
>   F:	Documentation/ABI/testing/configfs-tsm-report
>   F:	Documentation/driver-api/coco/
> +F:	Documentation/driver-api/pci/tsm.rst
> +F:	drivers/pci/tsm.c
>   F:	drivers/virt/coco/guest/
> -F:	include/linux/tsm*.h
> +F:	include/linux/*tsm*.h
>   F:	samples/tsm-mr/
>   
>   TRUSTED SERVICES TEE DRIVER
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 105b72b93613..0183ca6f6954 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -136,6 +136,21 @@ config PCI_IDE_STREAM_MAX
>   	  platform capability for the foreseeable future is 4 to 8 streams. Bump
>   	  this value up if you have an expert testing need.
>   
> +config PCI_TSM
> +	bool "PCI TSM: Device security protocol support"
> +	select PCI_IDE
> +	select PCI_DOE
> +	select TSM
> +	help
> +	  The TEE (Trusted Execution Environment) Device Interface
> +	  Security Protocol (TDISP) defines a "TSM" as a platform agent
> +	  that manages device authentication, link encryption, link
> +	  integrity protection, and assignment of PCI device functions
> +	  (virtual or physical) to confidential computing VMs that can
> +	  access (DMA) guest private memory.
> +
> +	  Enable a platform TSM driver to use this capability.
> +
>   config PCI_DOE
>   	bool "Enable PCI Data Object Exchange (DOE) support"
>   	help
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 6612256fd37d..2c545f877062 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>   obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
>   obj-$(CONFIG_PCI_DOE)		+= doe.o
>   obj-$(CONFIG_PCI_IDE)		+= ide.o
> +obj-$(CONFIG_PCI_TSM)		+= tsm.o
>   obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
>   obj-$(CONFIG_PCI_NPEM)		+= npem.o
>   obj-$(CONFIG_PCIE_TPH)		+= tph.o
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index aae9a8a00406..62be9c8dbc52 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -24,8 +24,6 @@
>   
>   #include "pci.h"
>   
> -#define PCI_DOE_FEATURE_DISCOVERY 0
> -
>   /* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */
>   #define PCI_DOE_TIMEOUT HZ
>   #define PCI_DOE_POLL_INTERVAL	(PCI_DOE_TIMEOUT / 128)
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 5eea14c1f7f5..367ca1bc5470 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1815,6 +1815,10 @@ const struct attribute_group *pci_dev_attr_groups[] = {
>   #endif
>   #ifdef CONFIG_PCI_DOE
>   	&pci_doe_sysfs_group,
> +#endif
> +#ifdef CONFIG_PCI_TSM
> +	&pci_tsm_auth_attr_group,
> +	&pci_tsm_attr_group,
>   #endif
>   	NULL,
>   };
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 56851e73439b..0e24262aa4ba 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -525,6 +525,16 @@ void pci_ide_init(struct pci_dev *dev);
>   static inline void pci_ide_init(struct pci_dev *dev) { }
>   #endif
>   
> +#ifdef CONFIG_PCI_TSM
> +void pci_tsm_init(struct pci_dev *pdev);
> +void pci_tsm_destroy(struct pci_dev *pdev);
> +extern const struct attribute_group pci_tsm_attr_group;
> +extern const struct attribute_group pci_tsm_auth_attr_group;
> +#else
> +static inline void pci_tsm_init(struct pci_dev *pdev) { }
> +static inline void pci_tsm_destroy(struct pci_dev *pdev) { }
> +#endif
> +
>   /**
>    * pci_dev_set_io_state - Set the new error state if possible.
>    *
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4fd6942ea6a8..7207f9a76a3e 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2738,6 +2738,9 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>   	ret = device_add(&dev->dev);
>   	WARN_ON(ret < 0);
>   
> +	/* Establish pdev->tsm for newly added (e.g. new SR-IOV VFs) */
> +	pci_tsm_init(dev);
> +
>   	pci_npem_create(dev);
>   
>   	pci_doe_sysfs_init(dev);
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 445afdfa6498..4b9ad199389b 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -55,6 +55,12 @@ static void pci_destroy_dev(struct pci_dev *dev)
>   	pci_doe_sysfs_teardown(dev);
>   	pci_npem_remove(dev);
>   
> +	/*
> +	 * While device is in D0 drop the device from TSM link operations
> +	 * including unbind and disconnect (IDE + SPDM teardown).
> +	 */
> +	pci_tsm_destroy(dev);
> +
>   	device_del(&dev->dev);
>   
>   	down_write(&pci_bus_sem);
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> new file mode 100644
> index 000000000000..092e81c5208c
> --- /dev/null
> +++ b/drivers/pci/tsm.c
> @@ -0,0 +1,601 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TEE Security Manager for the TEE Device Interface Security Protocol
> + * (TDISP, PCIe r6.1 sec 11)
> + *
> + * Copyright(c) 2024 Intel Corporation. All rights reserved.
> + */
> +
> +#define dev_fmt(fmt) "PCI/TSM: " fmt
> +
> +#include <linux/bitfield.h>
> +#include <linux/pci.h>
> +#include <linux/pci-doe.h>
> +#include <linux/pci-tsm.h>
> +#include <linux/sysfs.h>
> +#include <linux/tsm.h>
> +#include <linux/xarray.h>
> +#include "pci.h"
> +
> +/*
> + * Provide a read/write lock against the init / exit of pdev tsm
> + * capabilities and arrival/departure of a TSM instance
> + */
> +static DECLARE_RWSEM(pci_tsm_rwsem);
> +
> +/*
> + * Count of TSMs registered that support physical link operations vs device
> + * security state management.
> + */
> +static int pci_tsm_link_count;
> +static int pci_tsm_devsec_count;

This one is not checked anywhere.

> +
> +static inline bool is_dsm(struct pci_dev *pdev)
> +{
> +	return pdev->tsm && pdev->tsm->dsm == pdev;
> +}
> +
> +/* 'struct pci_tsm_pf0' wraps 'struct pci_tsm' when ->dsm == ->pdev (self) */
> +static struct pci_tsm_pf0 *to_pci_tsm_pf0(struct pci_tsm *pci_tsm)
> +{
> +	struct pci_dev *pdev = pci_tsm->pdev;
> +
> +	if (!is_pci_tsm_pf0(pdev) || !is_dsm(pdev)) {
> +		dev_WARN_ONCE(&pdev->dev, 1, "invalid context object\n");
> +		return NULL;
> +	}
> +
> +	return container_of(pci_tsm, struct pci_tsm_pf0, base);
> +}
> +
> +static void tsm_remove(struct pci_tsm *tsm)
> +{
> +	struct pci_dev *pdev;
> +
> +	if (!tsm)
> +		return;
> +
> +	pdev = tsm->pdev;
> +	tsm->ops->remove(tsm);
> +	pdev->tsm = NULL;
> +}
> +DEFINE_FREE(tsm_remove, struct pci_tsm *, if (_T) tsm_remove(_T))
> +
> +static void pci_tsm_walk_fns(struct pci_dev *pdev,
> +			     int (*cb)(struct pci_dev *pdev, void *data),
> +			     void *data)
> +{
> +	/* Walk subordinate physical functions */
> +	for (int i = 0; i < 8; i++) {
> +		struct pci_dev *pf __free(pci_dev_put) = pci_get_slot(
> +			pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), i));
> +
> +		if (!pf)
> +			continue;
> +
> +		/* on entry function 0 has already run @cb */
> +		if (i > 0)
> +			cb(pf, data);
> +
> +		/* walk virtual functions of each pf */
> +		for (int j = 0; j < pci_num_vf(pf); j++) {
> +			struct pci_dev *vf __free(pci_dev_put) =
> +				pci_get_domain_bus_and_slot(
> +					pci_domain_nr(pf->bus),
> +					pci_iov_virtfn_bus(pf, j),
> +					pci_iov_virtfn_devfn(pf, j));
> +
> +			if (!vf)
> +				continue;
> +
> +			cb(vf, data);
> +		}
> +	}
> +
> +	/*
> +	 * Walk downstream devices, assumes that an upstream DSM is
> +	 * limited to downstream physical functions
> +	 */
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM && is_dsm(pdev))
> +		pci_walk_bus(pdev->subordinate, cb, data);
> +}
> +
> +static void pci_tsm_walk_fns_reverse(struct pci_dev *pdev,
> +				     int (*cb)(struct pci_dev *pdev,
> +					       void *data),
> +				     void *data)
> +{
> +	/* Reverse walk downstream devices */
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM && is_dsm(pdev))
> +		pci_walk_bus_reverse(pdev->subordinate, cb, data);
> +
> +	/* Reverse walk subordinate physical functions */
> +	for (int i = 7; i >= 0; i--) {
> +		struct pci_dev *pf __free(pci_dev_put) = pci_get_slot(
> +			pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), i));
> +
> +		if (!pf)
> +			continue;
> +
> +		/* reverse walk virtual functions */
> +		for (int j = pci_num_vf(pf) - 1; j >= 0; j--) {
> +			struct pci_dev *vf __free(pci_dev_put) =
> +				pci_get_domain_bus_and_slot(
> +					pci_domain_nr(pf->bus),
> +					pci_iov_virtfn_bus(pf, j),
> +					pci_iov_virtfn_devfn(pf, j));
> +
> +			if (!vf)
> +				continue;
> +			cb(vf, data);
> +		}
> +
> +		/* on exit, caller will run @cb on function 0 */
> +		if (i > 0)
> +			cb(pf, data);
> +	}
> +}
> +
> +static int probe_fn(struct pci_dev *pdev, void *dsm)
> +{
> +	struct pci_dev *dsm_dev = dsm;
> +	const struct pci_tsm_ops *ops = dsm_dev->tsm->ops;
> +
> +	pdev->tsm = ops->probe(pdev);


Looks like this is going to initialize pci_dev::tsm for all VFs under an IDE (or TEE) capable PF0, even for those VFs which do not have PCI_EXP_DEVCAP_TEE, which does not seem right.



> +	pci_dbg(pdev, "setup TSM context: DSM: %s status: %s\n",
> +		pci_name(dsm_dev), pdev->tsm ? "success" : "failed");
> +	return 0;
> +}
> +
> +static int pci_tsm_connect(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
> +{
> +	int rc;
> +	struct pci_tsm_pf0 *tsm_pf0;
> +	const struct pci_tsm_ops *ops = tsm_pci_ops(tsm_dev);
> +	struct pci_tsm *pci_tsm __free(tsm_remove) = ops->probe(pdev);
> +
> +	/* connect()  mutually exclusive with subfunction pci_tsm_init() */
> +	lockdep_assert_held_write(&pci_tsm_rwsem);
> +
> +	if (!pci_tsm)
> +		return -ENXIO;
> +
> +	pdev->tsm = pci_tsm;
> +	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
> +
> +	/* mutex_intr assumes connect() is always sysfs/user driven */
> +	ACQUIRE(mutex_intr, lock)(&tsm_pf0->lock);
> +	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
> +		return rc;
> +
> +	rc = ops->connect(pdev);
> +	if (rc)
> +		return rc;
> +
> +	pdev->tsm = no_free_ptr(pci_tsm);
> +
> +	/*
> +	 * Now that the DSM is established, probe() all the potential
> +	 * dependent functions. Failure to probe a function is not fatal
> +	 * to connect(), it just disables subsequent security operations
> +	 * for that function.
> +	 */
> +	pci_tsm_walk_fns(pdev, probe_fn, pdev);
> +	return 0;
> +}
> +
> +static ssize_t connect_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int rc;
> +
> +	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
> +		return rc;
> +
> +	if (!pdev->tsm)
> +		return sysfs_emit(buf, "\n");
> +
> +	return sysfs_emit(buf, "%s\n", tsm_name(pdev->tsm->ops->owner));
> +}
> +
> +/* Is @tsm_dev managing physical link / session properties... */
> +static bool is_link_tsm(struct tsm_dev *tsm_dev)
> +{
> +	const struct pci_tsm_ops *ops = tsm_pci_ops(tsm_dev);
> +
> +	return ops && ops->link_ops.probe;
> +}
> +
> +/* ...or is @tsm_dev managing device security state ? */
> +static bool is_devsec_tsm(struct tsm_dev *tsm_dev)
> +{
> +	const struct pci_tsm_ops *ops = tsm_pci_ops(tsm_dev);
> +
> +	return ops && ops->devsec_ops.lock;
> +}
> +
> +static ssize_t connect_store(struct device *dev, struct device_attribute *attr,
> +			     const char *buf, size_t len)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct tsm_dev *tsm_dev;
> +	int rc, id;
> +
> +	rc = sscanf(buf, "tsm%d\n", &id);
> +	if (rc != 1)
> +		return -EINVAL;
> +
> +	ACQUIRE(rwsem_write_kill, lock)(&pci_tsm_rwsem);
> +	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &lock)))
> +		return rc;
> +
> +	if (pdev->tsm)
> +		return -EBUSY;
> +
> +	tsm_dev = find_tsm_dev(id);
> +	if (!is_link_tsm(tsm_dev))

There would be no "connect" in sysfs if !is_link_tsm().


> +		return -ENXIO;
> +
> +	rc = pci_tsm_connect(pdev, tsm_dev);
> +	if (rc)
> +		return rc;
> +	return len;
> +}
> +static DEVICE_ATTR_RW(connect);
> +
> +static int remove_fn(struct pci_dev *pdev, void *data)
> +{
> +	tsm_remove(pdev->tsm);
> +	return 0;
> +}
> +
> +static void __pci_tsm_disconnect(struct pci_dev *pdev)
> +{
> +	struct pci_tsm_pf0 *tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
> +	const struct pci_tsm_ops *ops = pdev->tsm->ops;
> +
> +	/* disconnect() mutually exclusive with subfunction pci_tsm_init() */
> +	lockdep_assert_held_write(&pci_tsm_rwsem);
> +
> +	/*
> +	 * disconnect() is uninterruptible as it may be called for device
> +	 * teardown
> +	 */
> +	guard(mutex)(&tsm_pf0->lock);
> +	pci_tsm_walk_fns_reverse(pdev, remove_fn, NULL);
> +	ops->disconnect(pdev);
> +}
> +
> +static void pci_tsm_disconnect(struct pci_dev *pdev)
> +{
> +	__pci_tsm_disconnect(pdev);
> +	tsm_remove(pdev->tsm);
> +}
> +
> +static ssize_t disconnect_store(struct device *dev,
> +				struct device_attribute *attr, const char *buf,
> +				size_t len)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	const struct pci_tsm_ops *ops;
> +	int rc;
> +
> +	ACQUIRE(rwsem_write_kill, lock)(&pci_tsm_rwsem);
> +	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &lock)))
> +		return rc;
> +
> +	if (!pdev->tsm)
> +		return -ENXIO;
> +
> +	ops = pdev->tsm->ops;
> +	if (!sysfs_streq(buf, tsm_name(ops->owner)))
> +		return -EINVAL;
> +
> +	pci_tsm_disconnect(pdev);
> +	return len;
> +}
> +static DEVICE_ATTR_WO(disconnect);
> +
> +/* The 'authenticated' attribute is exclusive to the presence of a 'link' TSM */
> +static bool pci_tsm_link_group_visible(struct kobject *kobj)
> +{
> +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> +
> +	return pci_tsm_link_count && is_pci_tsm_pf0(pdev);
> +}
> +DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_tsm_link);
> +
> +/*
> + * 'link' and 'devsec' TSMs share the same 'tsm/' sysfs group, so the TSM type
> + * specific attributes need individual visibility checks.
> + */
> +static umode_t pci_tsm_attr_visible(struct kobject *kobj,
> +				    struct attribute *attr, int n)
> +{
> +	if (pci_tsm_link_group_visible(kobj)) {
> +		if (attr == &dev_attr_connect.attr ||
> +		    attr == &dev_attr_disconnect.attr)
> +			return attr->mode;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool pci_tsm_group_visible(struct kobject *kobj)
> +{
> +	return pci_tsm_link_group_visible(kobj);
> +}
> +DEFINE_SYSFS_GROUP_VISIBLE(pci_tsm);
> +
> +static struct attribute *pci_tsm_attrs[] = {
> +	&dev_attr_connect.attr,
> +	&dev_attr_disconnect.attr,
> +	NULL
> +};
> +
> +const struct attribute_group pci_tsm_attr_group = {
> +	.name = "tsm",
> +	.attrs = pci_tsm_attrs,
> +	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm),
> +};
> +
> +static ssize_t authenticated_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	/*
> +	 * When the SPDM session established via TSM the 'authenticated' state
> +	 * of the device is identical to the connect state.
> +	 */
> +	return connect_show(dev, attr, buf);
> +}
> +static DEVICE_ATTR_RO(authenticated);
> +
> +static struct attribute *pci_tsm_auth_attrs[] = {
> +	&dev_attr_authenticated.attr,
> +	NULL
> +};
> +
> +const struct attribute_group pci_tsm_auth_attr_group = {
> +	.attrs = pci_tsm_auth_attrs,
> +	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm_link),
> +};
> +
> +/*
> + * Retrieve physical function0 device whether it has TEE capability or not
> + */
> +static struct pci_dev *pf0_dev_get(struct pci_dev *pdev)
> +{
> +	struct pci_dev *pf_dev = pci_physfn(pdev);
> +
> +	if (PCI_FUNC(pf_dev->devfn) == 0)
> +		return pci_dev_get(pf_dev);
> +
> +	return pci_get_slot(pf_dev->bus,
> +			    pf_dev->devfn - PCI_FUNC(pf_dev->devfn));
> +}
> +
> +/*
> + * Find the PCI Device instance that serves as the Device Security Manager (DSM)
> + * for @pdev. Note that no additional reference is held for the resulting device
> + * because @pdev always has a longer registered lifetime than its DSM by virtue
> + * of being a child of, or identical to, its DSM.
> + */
> +static struct pci_dev *find_dsm_dev(struct pci_dev *pdev)
> +{
> +	struct device *grandparent;
> +	struct pci_dev *uport;
> +
> +	if (is_pci_tsm_pf0(pdev))
> +		return pdev;
> +
> +	struct pci_dev *pf0 __free(pci_dev_put) = pf0_dev_get(pdev);
> +	if (!pf0)
> +		return NULL;
> +
> +	if (is_dsm(pf0))
> +		return pf0;
> +
> +	/*
> +	 * For cases where a switch may be hosting TDISP services on behalf of
> +	 * downstream devices, check the first upstream port relative to this
> +	 * endpoint.
> +	 */
> +	if (!pdev->dev.parent)
> +		return NULL;
> +	grandparent = pdev->dev.parent->parent;
> +	if (!grandparent)
> +		return NULL;
> +	if (!dev_is_pci(grandparent))
> +		return NULL;
> +	uport = to_pci_dev(grandparent);
> +	if (!pci_is_pcie(uport) ||
> +	    pci_pcie_type(uport) != PCI_EXP_TYPE_UPSTREAM)
> +		return NULL;
> +
> +	if (is_dsm(uport))
> +		return uport;
> +	return NULL;
> +}
> +
> +/**
> + * pci_tsm_link_constructor() - base 'struct pci_tsm' initialization for link TSMs
> + * @pdev: The PCI device
> + * @tsm: context to initialize
> + * @ops: PCI link operations provided by the TSM
> + */
> +int pci_tsm_link_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
> +			     const struct pci_tsm_ops *ops)
> +{
> +	if (!is_link_tsm(ops->owner))
> +		return -EINVAL;
> +
> +	tsm->dsm = find_dsm_dev(pdev);
> +	if (!tsm->dsm) {
> +		pci_warn(pdev, "failed to find Device Security Manager\n");
> +		return -ENXIO;
> +	}
> +	tsm->pdev = pdev;
> +	tsm->ops = ops;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_link_constructor);
> +
> +/**
> + * pci_tsm_pf0_constructor() - common 'struct pci_tsm_pf0' (DSM) initialization
> + * @pdev: Physical Function 0 PCI device (as indicated by is_pci_tsm_pf0())
> + * @tsm: context to initialize
> + * @ops: PCI link operations provided by the TSM
> + */
> +int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
> +			    const struct pci_tsm_ops *ops)
> +{
> +	mutex_init(&tsm->lock);
> +	tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
> +					   PCI_DOE_PROTO_CMA);
> +	if (!tsm->doe_mb) {
> +		pci_warn(pdev, "TSM init failure, no CMA mailbox\n");
> +		return -ENODEV;
> +	}
> +
> +	return pci_tsm_link_constructor(pdev, &tsm->base, ops);
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_pf0_constructor);
> +
> +void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *pf0_tsm)
> +{
> +	mutex_destroy(&pf0_tsm->lock);
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_pf0_destructor);
> +
> +static void pf0_sysfs_enable(struct pci_dev *pdev)
> +{
> +	bool tee = pdev->devcap & PCI_EXP_DEVCAP_TEE;

IDE cap, not PCI_EXP_DEVCAP_TEE.

> +
> +	pci_dbg(pdev, "Device Security Manager detected (%s%s%s)\n",
> +		pdev->ide_cap ? "IDE" : "", pdev->ide_cap && tee ? " " : "",
> +		tee ? "TEE" : "");
> +
> +	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
> +	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
> +}
> +
> +int pci_tsm_register(struct tsm_dev *tsm_dev)
> +{
> +	struct pci_dev *pdev = NULL;
> +
> +	if (!tsm_dev)
> +		return -EINVAL;
> +
> +	/*
> +	 * The TSM device must have pci_ops, and only implement one of link_ops
> +	 * or devsec_ops.
> +	 */
> +	if (!tsm_pci_ops(tsm_dev))
> +		return -EINVAL;

Not needed.

> +
> +	if (!is_link_tsm(tsm_dev) && !is_devsec_tsm(tsm_dev))
> +		return -EINVAL;
> +
> +	if (is_link_tsm(tsm_dev) && is_devsec_tsm(tsm_dev))
> +		return -EINVAL;
> +
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +
> +	/* on first enable, update sysfs groups */
> +	if (is_link_tsm(tsm_dev) && pci_tsm_link_count++ == 0) {
> +		for_each_pci_dev(pdev)
> +			if (is_pci_tsm_pf0(pdev))
> +				pf0_sysfs_enable(pdev);

You could safely run this loop in the guest too, is_pci_tsm_pf0() would not find IDE-capable PF.

> +	} else if (is_devsec_tsm(tsm_dev)) {
> +		pci_tsm_devsec_count++;
> +	}

nit: a bunch of is_link_tsm()/is_devsec_tsm() hurts to read.

Instead of routing calls to pci_tsm_register() via tsm_register() and doing all these checks here, we could have cleaner pci_tsm_link_register() and pci_tsm_devsev_register() and call those directly from where tsm_register() is called as those TSM drivers (or devsec samples) know what they are.

(well, I'd love pci_tsm_{host|guest}_register or pci_tsm_{hv|vm}_register as their roles are distinct...)

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_register);
> +
> +/**
> + * __pci_tsm_destroy() - destroy the TSM context for @pdev
> + * @pdev: device to cleanup
> + * @tsm_dev: TSM context if a TSM device is being removed, NULL if
> + *	     @pdev is being removed.
> + *
> + * At device removal or TSM unregistration all established context
> + * with the TSM is torn down. Additionally, if there are no more TSMs
> + * registered, the PCI tsm/ sysfs attributes are hidden.
> + */
> +static void __pci_tsm_destroy(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
> +{
> +	struct pci_tsm *tsm = pdev->tsm;
> +
> +	lockdep_assert_held_write(&pci_tsm_rwsem);
> +
> +	if (is_link_tsm(tsm_dev) && is_pci_tsm_pf0(pdev) && !pci_tsm_link_count) {
> +		sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
> +		sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
> +	}
> +
> +	if (!tsm)
> +		return;
> +
> +	if (!tsm_dev)
> +		tsm_dev = tsm->ops->owner;
> +	else if (tsm_dev != tsm->ops->owner)
> +		return;
> +
> +	if (is_link_tsm(tsm_dev) && is_pci_tsm_pf0(pdev))
> +		pci_tsm_disconnect(pdev);
> +	else
> +		tsm_remove(pdev->tsm);
> +}
> +
> +void pci_tsm_destroy(struct pci_dev *pdev)
> +{
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +	__pci_tsm_destroy(pdev, NULL);
> +}
> +
> +void pci_tsm_init(struct pci_dev *pdev)
> +{
> +	guard(rwsem_read)(&pci_tsm_rwsem);
> +
> +	/*
> +	 * Subfunctions are either probed synchronous with connect() or later
> +	 * when either the SR-IOV configuration is changed, or, unlikely,
> +	 * connect() raced initial bus scanning.
> +	 */
> +	if (pdev->tsm)
> +		return;
> +
> +	if (pci_tsm_link_count) {
> +		struct pci_dev *dsm = find_dsm_dev(pdev);
> +
> +		if (!dsm)
> +			return;
> +
> +		/*
> +		 * The only path to init a Device Security Manager capable
> +		 * device is via connect().
> +		 */
> +		if (!dsm->tsm)
> +			return;
> +
> +		probe_fn(pdev, dsm);
> +	}
> +}
> +
> +void pci_tsm_unregister(struct tsm_dev *tsm_dev)
> +{
> +	struct pci_dev *pdev = NULL;
> +
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +	if (is_link_tsm(tsm_dev))
> +		pci_tsm_link_count--;
> +	if (is_devsec_tsm(tsm_dev))
> +		pci_tsm_devsec_count--;
> +	for_each_pci_dev_reverse(pdev)
> +		__pci_tsm_destroy(pdev, tsm_dev);
> +}
> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> index a64b776642cf..6fdcf23d57ec 100644
> --- a/drivers/virt/coco/tsm-core.c
> +++ b/drivers/virt/coco/tsm-core.c
> @@ -9,6 +9,7 @@
>   #include <linux/device.h>
>   #include <linux/module.h>
>   #include <linux/cleanup.h>
> +#include <linux/pci-tsm.h>
>   
>   static struct class *tsm_class;
>   static DECLARE_RWSEM(tsm_rwsem);
> @@ -17,8 +18,28 @@ static DEFINE_IDR(tsm_idr);
>   struct tsm_dev {
>   	struct device dev;
>   	int id;
> +	const struct pci_tsm_ops *pci_ops;
>   };
>   
> +const char *tsm_name(const struct tsm_dev *tsm_dev)
> +{
> +	return dev_name(&tsm_dev->dev);
> +}
> +
> +/* Caller responsible for ensuring it does not race tsm_dev unregistration */
> +struct tsm_dev *find_tsm_dev(int id)
> +{
> +	guard(rcu)();
> +	return idr_find(&tsm_idr, id);
> +}
> +
> +const struct pci_tsm_ops *tsm_pci_ops(const struct tsm_dev *tsm_dev)
> +{
> +	if (!tsm_dev)
> +		return NULL;
> +	return tsm_dev->pci_ops;
> +}
> +
>   static struct tsm_dev *alloc_tsm_dev(struct device *parent)
>   {
>   	struct tsm_dev *tsm_dev __free(kfree) =
> @@ -42,6 +63,29 @@ static struct tsm_dev *alloc_tsm_dev(struct device *parent)
>   	return no_free_ptr(tsm_dev);
>   }
>   
> +static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
> +						 struct pci_tsm_ops *pci_ops)
> +{
> +	int rc;
> +
> +	if (!pci_ops)
> +		return tsm_dev;
> +
> +	pci_ops->owner = tsm_dev;
> +	tsm_dev->pci_ops = pci_ops;
> +	rc = pci_tsm_register(tsm_dev);
> +	if (rc) {
> +		dev_err(tsm_dev->dev.parent,
> +			"PCI/TSM registration failure: %d\n", rc);
> +		device_unregister(&tsm_dev->dev);
> +		return ERR_PTR(rc);
> +	}
> +
> +	/* Notify TSM userspace that PCI/TSM operations are now possible */
> +	kobject_uevent(&tsm_dev->dev.kobj, KOBJ_CHANGE);
> +	return tsm_dev;
> +}
> +
>   static void put_tsm_dev(struct tsm_dev *tsm_dev)
>   {
>   	if (!IS_ERR_OR_NULL(tsm_dev))
> @@ -51,7 +95,7 @@ static void put_tsm_dev(struct tsm_dev *tsm_dev)
>   DEFINE_FREE(put_tsm_dev, struct tsm_dev *,
>   	    if (!IS_ERR_OR_NULL(_T)) put_tsm_dev(_T))
>   
> -struct tsm_dev *tsm_register(struct device *parent)
> +struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *pci_ops)
>   {
>   	struct tsm_dev *tsm_dev __free(put_tsm_dev) = alloc_tsm_dev(parent);
>   	struct device *dev;
> @@ -69,12 +113,13 @@ struct tsm_dev *tsm_register(struct device *parent)
>   	if (rc)
>   		return ERR_PTR(rc);
>   
> -	return no_free_ptr(tsm_dev);
> +	return tsm_register_pci_or_reset(no_free_ptr(tsm_dev), pci_ops);
>   }
>   EXPORT_SYMBOL_GPL(tsm_register);
>   
>   void tsm_unregister(struct tsm_dev *tsm_dev)
>   {
> +	pci_tsm_unregister(tsm_dev);
>   	device_unregister(&tsm_dev->dev);
>   }
>   EXPORT_SYMBOL_GPL(tsm_unregister);
> diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> index 1f14aed4354b..7d839f4a6340 100644
> --- a/include/linux/pci-doe.h
> +++ b/include/linux/pci-doe.h
> @@ -15,6 +15,10 @@
>   
>   fstruct pci_doe_mb;
>   
> +#define PCI_DOE_FEATURE_DISCOVERY 0
> +#define PCI_DOE_PROTO_CMA 1
> +#define PCI_DOE_PROTO_SSESSION 2
> +
>   struct pci_doe_mb *pci_find_doe_mailbox(struct pci_dev *pdev, u16 vendor,
>   					u8 type);
>   
> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> new file mode 100644
> index 000000000000..e4f9ea4a54a9
> --- /dev/null
> +++ b/include/linux/pci-tsm.h
> @@ -0,0 +1,143 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PCI_TSM_H
> +#define __PCI_TSM_H
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +
> +struct pci_tsm;
> +
> +/*
> + * struct pci_tsm_ops - manage confidential links and security state
> + * @link_ops: Coordinate PCIe SPDM and IDE establishment via a platform TSM.
> + *	      Provide a secure session transport for TDISP state management
> + *	      (typically bare metal physical function operations).
> + * @sec_ops: Lock, unlock, and interrogate the security state of the
> + *	     function via the platform TSM (typically virtual function
> + *	     operations).
> + * @owner: Back reference to the TSM device that owns this instance.
> + *
> + * This operations are mutually exclusive either a tsm_dev instance
> + * manages physical link properties or it manages function security
> + * states like TDISP lock/unlock.
> + */
> +struct pci_tsm_ops {
> +	/*
> +	 * struct pci_tsm_link_ops - Manage physical link and the TSM/DSM session
> +	 * @probe: allocate context (wrap 'struct pci_tsm') for follow-on link
> +	 *	   operations
> +	 * @remove: destroy link operations context
> +	 * @connect: establish / validate a secure connection (e.g. IDE)
> +	 *	     with the device
> +	 * @disconnect: teardown the secure link
> +	 *
> +	 * Context: @probe, @remove, @connect, and @disconnect run under
> +	 * pci_tsm_rwsem held for write to sync with TSM unregistration and
> +	 * mutual exclusion of @connect and @disconnect. @connect and
> +	 * @disconnect additionally run under the DSM lock (struct
> +	 * pci_tsm_pf0::lock) as well as @probe and @remove of the subfunctions.
> +	 */
> +	struct_group_tagged(pci_tsm_link_ops, link_ops,

Why not pci_tsm_dsm_ops? DSM and TDI are used all over the place in the PCIe spec, why not use those?


> +		struct pci_tsm *(*probe)(struct pci_dev *pdev);
> +		void (*remove)(struct pci_tsm *tsm);
> +		int (*connect)(struct pci_dev *pdev);

Why is this one not pci_tsm?

> +		void (*disconnect)(struct pci_dev *pdev);

and here.

> +	);
> +
> +	/*
> +	 * struct pci_tsm_security_ops - Manage the security state of the function
> +	 * @lock: probe and initialize the device in the LOCKED state
> +	 * @unlock: destroy TSM context and return device to UNLOCKED state
> +	 *
> +	 * Context: @lock and @unlock run under pci_tsm_rwsem held for write to
> +	 * sync with TSM unregistration and each other
> +	 */
> +	struct_group_tagged(pci_tsm_security_ops, devsec_ops,

Why not pci_tsm_tdi_ops? Or even pci_tdi_ops? pci_tsm_link_ops::connect is also about security.


> +		struct pci_tsm *(*lock)(struct pci_dev *pdev);

pci_tdi?

Or why have pci_dev reference in pci_tsm and pci_tdi then.

> +		void (*unlock)(struct pci_dev *pdev);


So we put host and guest in the same ops anyway, what does it buy us? Thanks,



> +	);
> +	struct tsm_dev *owner;
> +};
> +
> +/**
> + * struct pci_tsm - Core TSM context for a given PCIe endpoint
> + * @pdev: Back ref to device function, distinguishes type of pci_tsm context
> + * @dsm: PCI Device Security Manager for link operations on @pdev
> + * @ops: Link Confidentiality or Device Function Security operations
> + *
> + * This structure is wrapped by low level TSM driver data and returned by
> + * probe()/lock(), it is freed by the corresponding remove()/unlock().
> + *
> + * For link operations it serves to cache the association between a Device
> + * Security Manager (DSM) and the functions that manager can assign to a TVM.
> + * That can be "self", for assigning function0 of a TEE I/O device, a
> + * sub-function (SR-IOV virtual function, or non-function0
> + * multifunction-device), or a downstream endpoint (PCIe upstream switch-port as
> + * DSM).
> + */
> +struct pci_tsm {
> +	struct pci_dev *pdev;
> +	struct pci_dev *dsm;
> +	const struct pci_tsm_ops *ops;
> +};
> +
> +/**
> + * struct pci_tsm_pf0 - Physical Function 0 TDISP link context
> + * @base: generic core "tsm" context
> + * @lock: mutual exclustion for pci_tsm_ops invocation
> + * @doe_mb: PCIe Data Object Exchange mailbox
> + */
> +struct pci_tsm_pf0 {
> +	struct pci_tsm base;
> +	struct mutex lock;
> +	struct pci_doe_mb *doe_mb;
> +};
> +
> +/* physical function0 and capable of 'connect' */
> +static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
> +{
> +	if (!pci_is_pcie(pdev))
> +		return false;
> +
> +	if (pdev->is_virtfn)
> +		return false;
> +
> +	/*
> +	 * Allow for a Device Security Manager (DSM) associated with function0
> +	 * of an Endpoint to coordinate TDISP requests for other functions
> +	 * (physical or virtual) of the device, or allow for an Upstream Port
> +	 * DSM to accept TDISP requests for the Endpoints downstream of the
> +	 * switch.
> +	 */
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ENDPOINT:
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	case PCI_EXP_TYPE_RC_END:
> +		if (pdev->ide_cap || (pdev->devcap & PCI_EXP_DEVCAP_TEE))

PCI_EXP_DEVCAP_TEE says nothing about "connect".


> +			break;
> +		fallthrough;
> +	default:
> +		return false;
> +	}
> +
> +	return PCI_FUNC(pdev->devfn) == 0;
> +}
> +
> +#ifdef CONFIG_PCI_TSM
> +struct tsm_dev;
> +int pci_tsm_register(struct tsm_dev *tsm_dev);
> +void pci_tsm_unregister(struct tsm_dev *tsm_dev);
> +int pci_tsm_link_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
> +			     const struct pci_tsm_ops *ops);
> +int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
> +			    const struct pci_tsm_ops *ops);
> +void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *tsm);
> +#else
> +static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
> +{
> +	return 0;
> +}
> +static inline void pci_tsm_unregister(struct tsm_dev *tsm_dev)
> +{
> +}
> +#endif
> +#endif /*__PCI_TSM_H */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 6fb0e8a95078..78c1e208d441 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -545,6 +545,9 @@ struct pci_dev {
>   	u8		nr_link_ide;	/* Link Stream count (Selective Stream offset) */
>   	unsigned int	ide_cfg:1;	/* Config cycles over IDE */
>   	unsigned int	ide_tee_limit:1; /* Disallow T=0 traffic over IDE */
> +#endif
> +#ifdef CONFIG_PCI_TSM
> +	struct pci_tsm *tsm;		/* TSM operation state */
>   #endif
>   	u16		acs_cap;	/* ACS Capability offset */
>   	u8		supported_speeds; /* Supported Link Speeds Vector */
> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> index aa906eb67360..c99d85fe56f4 100644
> --- a/include/linux/tsm.h
> +++ b/include/linux/tsm.h
> @@ -111,6 +111,10 @@ struct tsm_report_ops {
>   int tsm_report_register(const struct tsm_report_ops *ops, void *priv);
>   int tsm_report_unregister(const struct tsm_report_ops *ops);
>   struct tsm_dev;
> -struct tsm_dev *tsm_register(struct device *parent);
> +struct pci_tsm_ops;
> +struct tsm_dev *tsm_register(struct device *parent, struct pci_tsm_ops *ops);
>   void tsm_unregister(struct tsm_dev *tsm_dev);
> +const char *tsm_name(const struct tsm_dev *tsm_dev);
> +struct tsm_dev *find_tsm_dev(int id);
> +const struct pci_tsm_ops *tsm_pci_ops(const struct tsm_dev *tsm_dev);
>   #endif /* __TSM_H */
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 911d6db5c224..4a32387c3c4a 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -500,6 +500,7 @@
>   #define  PCI_EXP_DEVCAP_PWR_VAL	0x03fc0000 /* Slot Power Limit Value */
>   #define  PCI_EXP_DEVCAP_PWR_SCL	0x0c000000 /* Slot Power Limit Scale */
>   #define  PCI_EXP_DEVCAP_FLR     0x10000000 /* Function Level Reset */
> +#define  PCI_EXP_DEVCAP_TEE     0x40000000 /* TEE I/O (TDISP) Support */
>   #define PCI_EXP_DEVCTL		0x08	/* Device Control */
>   #define  PCI_EXP_DEVCTL_CERE	0x0001	/* Correctable Error Reporting En. */
>   #define  PCI_EXP_DEVCTL_NFERE	0x0002	/* Non-Fatal Error Reporting Enable */

-- 
Alexey


