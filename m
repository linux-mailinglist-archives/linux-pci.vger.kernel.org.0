Return-Path: <linux-pci+bounces-37070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE8CBA2205
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 03:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DD007A8362
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 01:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3EA187554;
	Fri, 26 Sep 2025 01:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n/ranSXu"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010013.outbound.protection.outlook.com [52.101.46.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9D378F2E
	for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2025 01:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758849326; cv=fail; b=B8LbDTf/PlQfazl0wO/9D2eR/9gYDS4hVC+0JMYVZDH02P63dyuxPuQw7XGOh4Q+DvZpz8bf12kNVDVg+8Cz8XkhY4Aa7ZO2r3hqKPJL5gZz9fyJtdGNgYFSDSmGgLyRK/E7BSGmlpF5tLcPAudPs+I3F1VHXTLgGQ1Izoj7NEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758849326; c=relaxed/simple;
	bh=IRQE527PREsi39jrCEs0IDSY9P8+latu2twARQKOTGg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BiM4AGrRDNZJjLo83sE9KcP3fY7WT2n2HsA7/k/9xONqWwVGzpBdmgbReF985Ywoh62Xea1vDFNnQAmp4nz0J40pSkDgpFCa+NaG0WbMGoSJSuLVIV3BqXabvZYSjMsQDPbFTubyaEU/gPOPmfhlmAr3ec2NJFtX6yDRH7xPnaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n/ranSXu; arc=fail smtp.client-ip=52.101.46.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ADkh0GHwJN6oVDMsKTE0ki2Qumi8Ko3LTqN8dwCXuY4Lqrde7lsjkRx2n45izSDiFENBMRr1K3h2Q1ebk2GsTx2NwxpwzhkBMmvcYG1s92accKd/dKPUCqMh1yAN3dTmouZHE3O4dNywcGQWIYwSSR69Yl60PO/1lxIu3tNR87BIQroWIJR3RX1tmu9uX3iUofxq1L7IuHL6uxWYc/MFKf9IWhNuF6KuRXZw+UwztG3be3+1lTeJT8LAKYHMOz20UR5lKSCMIXTi3vEoNFdVbgkrbGW5wbhNtDIJ8pdSZwlwXInNVgbqwTUyBpIHMtwaVgTAV6RLCogvdrE6aYE2Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLK3WYwF6ndBvBRSFmF6b0HD1PGlgjFwjNWv4hjNv9U=;
 b=WwA1EYYeNQ/l/kyQwhQjSIRFYg88M2wgIgNqXVJkgdLSA1UpsOnhgGmyXtvbfhMzmW1zzQXIo1SyxbkCO0LrQzjXdTR6QcUUkhC1gdPAFm7CaX84s/OD4MJnO0N8NzajevttfDP+Pf89gKjsv+aracAcsjbP0wpTwV4P7koqrItto4EbvRLWBUAtSZjpVt+eZdGxE83uOKeR7RP/P/JK1hLL+ZuY4odKc9uJsrGt8w7fB7rAO9u6TxVXcLkA0wkqP0jShyqDV+rEggLRqWX73hMjFC591oOb5xV0Z1+35fEpAqTtfJEJo6k4iM3VamhjaTwKM4OgeXjf0SjLOHh+JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLK3WYwF6ndBvBRSFmF6b0HD1PGlgjFwjNWv4hjNv9U=;
 b=n/ranSXusAgcU1Qu+r1dK37Qc7NfBN78U47uI5dmZKeUsgSka7PI+ShANpMIBfJ41Py9Yq9KcrTk0uKWVQyFROayuIJ9hmAY8HB3D3pQtKia7w5ScjJd+OfGF7G/zc0zBQCRji6dZ0FLK7eIJvQJG920/ANJKgnNC4aGJ2dCUJo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SJ1PR12MB6266.namprd12.prod.outlook.com (2603:10b6:a03:457::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 01:15:21 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%3]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 01:15:20 +0000
Message-ID: <d7de6b3e-957b-4ea0-bf00-585ec1467174@amd.com>
Date: Fri, 26 Sep 2025 11:14:37 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH resend v6 04/10] PCI/TSM: Authenticate devices via
 platform TSM
To: dan.j.williams@intel.com, linux-pci@vger.kernel.org,
 linux-coco@lists.linux.dev
Cc: gregkh@linuxfoundation.org, bhelgaas@google.com, lukas@wunner.de,
 Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>
References: <20250911235647.3248419-1-dan.j.williams@intel.com>
 <20250911235647.3248419-5-dan.j.williams@intel.com>
 <22cbe028-c1ad-456f-a046-12b4559394b4@amd.com>
 <68cdb9f271b46_2dc01001e@dwillia2-mobl4.notmuch>
 <b99b2951-9f09-4f9d-a132-f05ab1f8928f@amd.com>
 <68d5c99fbb056_1c7910082@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <68d5c99fbb056_1c7910082@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5PR01CA0072.ausprd01.prod.outlook.com
 (2603:10c6:10:1f4::8) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SJ1PR12MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b034e3b-e4ee-4541-d6f5-08ddfc9a28f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0haZDlzRFpBM3ZHTVppM3gyRFgxaHExMHVDemdOYzAraDB2aFFiZnpyMUNK?=
 =?utf-8?B?U0ZuQmZLZVVYS1BSYmZEWUxhbUk0bHFNVTRSZG9xVU4xTG9jdlhtelBCQWtN?=
 =?utf-8?B?Y0lKWlJHQXh0Vk1nb0pLR3krU05xaXBnajRNc205c2VWakl6VjlQRnJ6bUJH?=
 =?utf-8?B?MFd6blpaSjExS1huMjRNQ0YzaDJWUVc3MTVKR2puWTdLa2czQUFMMU5nNjB5?=
 =?utf-8?B?S2J0bVZoaUU4WnFuYnl4OVJ0L3JvQ3E4UWZXbElWN1lkY2p6dzMxbXlqTU93?=
 =?utf-8?B?SVRJdjFTYjRybVA4MmVLUjB2dUQ2bUEyTk1lbTMwcHU2YWwveXlLY2EwdlEx?=
 =?utf-8?B?WEJlb2xSa0FMWEorejg1NGlDMXlHa0pRSVdmYmg2T2JiRkVkY3h1Q29NSGE5?=
 =?utf-8?B?S0lXMDBCNy9HTGZGWEhXem1HZm1mcmtEeStaeXNQUHc4N2ZGREJ5R05aWjc1?=
 =?utf-8?B?ZVJRNVlVK0ZZbW9tcXIrUU9OVzNMQjltc2NLTXRWNThUNlBSUE9IKzRMd0FN?=
 =?utf-8?B?QTVwVmNtQjd3WHlMWm5yUFRDdXp5Z2ZJVHdNWGx2TWV3SnJzaTBSTmYxQ1NE?=
 =?utf-8?B?SlhTNzhCeTRMcS95M29LYmU1Skd0R05IamQvU2kxaEEyTm01QytpZUdqNmpz?=
 =?utf-8?B?K0dzVDk2ZHV4c3BsSEpMWXV6djZ5MEhQU2dBMzNrMVZucmFGdE1Bc004dkxE?=
 =?utf-8?B?K1NjOTUzWTB6N29IWGVwblMwZGdKWDBFNkZDNUtsSTg3ZUF1TmpCZU9YbnRs?=
 =?utf-8?B?dkxCbWpsbVpFaUhqYTBuNnYrRjF2eVFOZUF6Mys4UTl3bHArcGFBVHlNOGRR?=
 =?utf-8?B?SGRKeWMvbVdwWVk0OXBwNnFiQko5NUVSQ2pPZmx1VGVvM2JRamdrWGN1U2Q5?=
 =?utf-8?B?VHFabUo0bWlrVmxENjVuZkI2aFdmTFlzRVpRb2JyOWpIMUJvZGRsckoxZ2dJ?=
 =?utf-8?B?UXhKbnpMb2FCeHZ6WlZ4dGhRbHZ3Wm5CNGtJeXB4SWsrRWNBUytZakdoRDlQ?=
 =?utf-8?B?bEgwY09wdk81azBYbSsyZFhBeC9vL2o4dmtEbUg0Rm5HNFF5bGJuWi9oYys5?=
 =?utf-8?B?ejV3N3VrMityTHhNakRzdERBTk1IMURYTGJyMHUwd2FmdEVlQWFFRjQwdmh1?=
 =?utf-8?B?YWpaWnlSMkozS0VsbmxocTZEQm4zRFJ3amt3bzlHMDVWeE1qQ3RqK2pxdjRw?=
 =?utf-8?B?WHNPcExEUUwxZHJnY3h2Z2QxUzZRaktIbVBacGNOdzZsL0NtbmFxS25OWk9J?=
 =?utf-8?B?a2xyaXc5eWNwMy9ZRTJpV1dpV0x2RlFObzhhNmVUcVFHV25Bc0pRL1ozNUN2?=
 =?utf-8?B?SEtLMHF5VVRiSHZjMkdLUXFBdkxQN1hCSjR1OWRlbGhRVU5hRktrNVJHRXlz?=
 =?utf-8?B?ZkdsNENrOFlWRmZGUTNwVEUzU2VtNW9BTkVJQ0ttQ2tETitCcGNYczlrK2o4?=
 =?utf-8?B?N2lUU3lPYzZqSGtHcjVyL0lCTzJmUzlFdG81WmJJR0RqdmFURk5samlrVEtN?=
 =?utf-8?B?RE80NFNZaXVnSm8rQkdYS29ZZUoxaGZWd2pJby9oVGVBQTl0cWIxNEUyODY1?=
 =?utf-8?B?bG9aWExDemxzbHhlbFNQNFZtckMzdG1jQ29uYXZacTMxWEIrRkIxODBqd2pr?=
 =?utf-8?B?WVFhWkJ1L0JMRHYwZnIzNkFjczArbXlSVkhrcGN5QTNnYXhYdlQ5SkQ4T1ly?=
 =?utf-8?B?c1dvZ2lUTjRiY29rTjVFNXBwSVdoRGtMYldvMmJkZUZMT0hIcWFReGVxRTZW?=
 =?utf-8?B?cmI5RlhJTzNYRlVxUGpWRmlvWWJnSUxoNGx0UEZVZ3pTejNLYUtpaGpPMTky?=
 =?utf-8?B?Z3R5L3dGSEM5c2ZjMVJCa1BnbGRCOVVnTmdKSVp1S0tOdUx0Q0xzTEJjVGVV?=
 =?utf-8?B?SWhqL24ra1g5dmwzcmk2WlVUdm04TmlpZWplN2d4SzBIU1UvaGtsRHVZVDAz?=
 =?utf-8?Q?HTLfDMSlzTY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEd5QjA3WnUwNVlXdjVPbmlyUzFKOC9WcXRMSkMzU0VHY3BDdmd4aE83MmNu?=
 =?utf-8?B?bVR4MHNiQXdnQ0F1VERZR1R2R2d5ckE3b3Y5K1Y0SjBEbXNqU25sNEtRaFJy?=
 =?utf-8?B?T1FrbW5hQlBNMzIwOEFzYjZUd290eWhkMzVIY1VJZUdhRGZ4UmpTLzJQZ0Vk?=
 =?utf-8?B?S04zcnRlRFlraEFVQ3lQRVNoaUdtT1I2a1h5OXU2QU1mMVpBallhUTlVdmlP?=
 =?utf-8?B?dkorL2FueldURVZ5Q2pGYVBKWUgwR2N4NlRlZ0hpRlVzU0VwSDVSNm8wKys4?=
 =?utf-8?B?Q3djRVNLTGFPODBsTzJ6MVo3WnNpbGV3S3pzMXQrKzM3RjdWZExIQ01ua29X?=
 =?utf-8?B?MHpKNFVOVUd0b2JXUVFVNWhDLzkraGV4TWg1ZTNGQ1p2c3E0NTR0RnVYeDhY?=
 =?utf-8?B?aDRTaXByRGFBWkNCSm1iaHNCNkdrM1g2UXBHNGZFcm1XV2c1THFxcXd3bXpD?=
 =?utf-8?B?dm9hZzZMV3grQ0pOTlo1TDloWGltejNCajhOUlM2MWlvV1o4WlFSYkNuK0R1?=
 =?utf-8?B?UU92SnhSTzBKZE1JVkdKTk4yMHVoenJNNUJ0WloyQUZ5bTVjc3o4K01jd095?=
 =?utf-8?B?T2pjNTA5djE5Q1pNTFlpSm93YSsyVkxZUTU5R0RSMXJidkRWbnk4NmQ4eU0r?=
 =?utf-8?B?UzBLNmxCSElPQXR4Ny9ld1k2eVNMSUF1VERwZFJNbGRORTh2cGJIV3Rwb1ZO?=
 =?utf-8?B?b3RUY0VocnZ6ZG5nRUxQeGZhZURiRDQ5aE50WEI0NjJyaEhTcmVKenBod3JI?=
 =?utf-8?B?TmVxRDV4NVAxbHZFQUYzRnRKNW02dDRLc1BJWTdON3czVVBWS3RuaHluNjgx?=
 =?utf-8?B?OGJSQXlXNU5tbTNSU0IvbWtLYm1zZllTaXMrSlJqWFE4dzNBVVVVa0RRWHJx?=
 =?utf-8?B?OWR3QmNaNGZjRnJoTU9oK1EwZ3VjdzdROVhUUVZKanU1cUZNcW9JSXFFN09I?=
 =?utf-8?B?c2RVdDRpbHRQaVpOTDFzNE9WRDZEZVUraWtqZk11UW1RQ3NSczlhcXpZT1NG?=
 =?utf-8?B?RHgxcWlUbm43MWVUcUFDTFFtS3dhSjY2d2NkL0wrLy9LT0xEMXdGZnlJclIr?=
 =?utf-8?B?clI0MjArdi8zbTZUK0VMVmtBY3h0QXM1dEJmNjF2dEtjbG1GTGFMUkJjaEtr?=
 =?utf-8?B?Wk5vVmErL1IzMnRBbWkxTnRjNjBDV2RCbDIwc1VsOHBGb2xKYlZIN3B6empQ?=
 =?utf-8?B?VURNbEwyNXM2WFFhTm9ISkcxYUt6NFhqTmZHNmlJMURBckM4U0hYRmZUb0Qv?=
 =?utf-8?B?MkdwVmZ4U2hOYThxQXhNdUZzQ0VqUy9ZYktYYUdxZWFFVVpaMTRQMXM1d21Q?=
 =?utf-8?B?b2NYWmJIMFhGQjErcUVoUFBIeU5QVm5ic3ZTdUZUUEFjVWJVNVZlUXRZb2dF?=
 =?utf-8?B?MEg4SG1lN0J1S2ZBNURSb1dKRUR4R01LZTNaMjVWTWg3OTUvRG5naks5L1dU?=
 =?utf-8?B?R3poM2xZOFEwNmsyVnBocVd1TVJiUE1iMFd3Z3JROHJBdUtTY042TGVodjVB?=
 =?utf-8?B?K0tieGdFeUFkWTR0NVRlTFB4WXRUdkpCaDJsa0hQYWhOM3dpTGJIeFQ3LzBB?=
 =?utf-8?B?L0lCenloUWRxbGF0YmUyN1RrR0NVRWYrMnkyZDM5TzhnZzNWR2ZkblNabTRl?=
 =?utf-8?B?VGl2MTIyUHBaMXVQS05BUW5ZRW5iY3M4NWhqWGJDL0hMeFRWVDV0LzVrMGVF?=
 =?utf-8?B?ZXg3djNEd2ovbHRWOWovS0oybFNzOG1wQzhUNHFpOUJmNTFEQ2NINkxSSGRx?=
 =?utf-8?B?UFFRNHZ4bkN5OU8wR2haMU5LL3lHUjBTeENVRmpwMjMxakhNaTV3bkZ6NVJk?=
 =?utf-8?B?WmVUSUdYZzJDQzh2MzdCZk1wSjRSbHNuZkV5SWdVaEE2d2VjWDMrdC9SN1VS?=
 =?utf-8?B?U2hPN3hsSkV3WkJNS3RNNjlXelRCRnArUmsvbmxmRStneEtmOThUdjNzZlRm?=
 =?utf-8?B?R21MbXNaU0ovckNoZ2tObzhxOGxmdWNhaTdXQWxWdVZQdDFhNFlnWmI3dmhH?=
 =?utf-8?B?aUo2elJ3d0FCQXpMWEVVNWJUeEJyRmYwZFYybWEwWVVWenlnVzFiMEJINGtD?=
 =?utf-8?B?aXQ2TlJSRk5Gc3R2RlNueFNUNUp0aHlLLzl1Q3dzSkt3bEQ0M3RESlRMUXZh?=
 =?utf-8?Q?FasVTh7yN0Ip+ZIZeC1vj+6r1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b034e3b-e4ee-4541-d6f5-08ddfc9a28f1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 01:15:20.2424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /kgrh1MCWUFYE82TPvCK9Yo27AxaXLOCEN67BiehtXaCEvG/3KHzQ+PPz9FWHpBhZWInFA8B2G9CrYcuoA+kEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6266



On 26/9/25 09:00, dan.j.williams@intel.com wrote:
> Alexey Kardashevskiy wrote:
> [..]
>>>> It is still a rather global thing. May I suggest this?
>>>
>>> I am not too keen on this.
>>>
>>> Yes, it is global, but less often used compared to @ops, and I do not
>>> want both @ops and @tsm_dev in @pci_tsm.
>>
>> Why exactly?
> 
> ...because it complicates the data structure merely for code convenience
> which is often the wrong tradeoff.
> 
> Here are the current options:
> 
> 1/ Current:
> struct pci_tsm {
>          struct pci_dev *pdev;
>          struct pci_dev *dsm_dev;
>          const struct pci_tsm_ops *ops;
> };
> 
> 2/ Alternative:
> struct pci_tsm {
>          struct pci_dev *pdev;
>          struct pci_dev *dsm_dev;
>          struct tsm_dev *tsm_dev;
> };
> 
> 2/ Proposed:
> struct pci_tsm {
>          struct pci_dev *pdev;
>          struct pci_dev *dsm_dev;
>          struct tsm_dev *tsm_dev;
>          const struct pci_tsm_ops *ops;
> };
> 
> I rank 3 last because it implies that @tsm_dev and @ops may have
> different lifetimes or otherwise may not be related to the same object
> until you read the code.
>
> I rank 2 after 1 because most of 'struct pci_tsm_ops' do not need the
> tsm_dev parameter.
> 
> Now, I would maybe go with 2 if 'struct tsm_dev' could be defined as:
> 
> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> index 376139585797..3619ffa8f8c1 100644
> --- a/include/linux/tsm.h
> +++ b/include/linux/tsm.h
> @@ -112,7 +112,7 @@ struct pci_tsm_ops;
>   struct tsm_dev {
>          struct device dev;
>          int id;
> -       const struct pci_tsm_ops *pci_ops;
> +       const struct pci_tsm_ops pci_ops;

Either variant of 2 (with "*pci_ops" or "pci_ops") is fine by me.


>   };
>   
> ...i.e. a container_of() relationship, but that makes pci_ops mandatory.

Do you need to be able to resolve tsm_dev from pci_ops pointer?


> It is already the case that TDX has as a few host-services in mind that
> may end up sharing common infrastructure at a TSM device level, so 1
> remains the preference.
> 
>>> So the options are lookup @ops
>>> from @tsm_dev or lookup @tsm_dev from @ops. Given @ops is used more
>>> often that is how I came up with the current arrangement.
>>
>> I am looking at:
>> https://github.com/AMDESE/linux-kvm/commit/9e3caf921ad6ddd6bd860ec307b986649322a618
>> and not really sure "more often" applies here.
>>
>> And do we have to check now if tsm_dev passed in probe() is the same
>> as the owner?
> 
> @ops are not passed passed back in probe so ->probe() can not verify.
> Also ->probe() sets the operations to use via pci_tsm_link_constructor()
> so at that point it does not matter how ->probe() got invoked the result
> is still the TSM driver returning the ops associated with @tsm_dev.


Any pci_tsm_ops::probe implementation can be called with any tsm_dev. So every probe() should verify that BUG_ON(tsm_dev::pci_ops::probe != itself). Although it is not possible right now. And I do not see a better way. So I do not insist really. But my head explodes at this point :)


>> I struggle to find any other _ops doing the same owner
>> caching easily.
> 
> struct file_operations::owner looks like one example.

Not exactly the same - struct module does not have back reference to file_operations. And the file_operations::owner is an ELF with some code but tsm_dev is just some memory from kmalloc(). I guess "dev" implies "module" though.

> 
>> Or merge struct pci_tsm_ops into struct tsm_dev to stop pretending
>> that pci_tsm_ops is an interface, and then we won't even need that
>> @owner. Dunno. Aneesh? :)
> 
> Not sure what you mean by "pretending that pci_tsm_ops is an interface"?

Most of these _ops are stateless (so no "owner") set of hooks, often "static" (and should be "const", and live in .ro sections, not sure if they do). And this _ops could follow the pattern. Thanks,


-- 
Alexey


