Return-Path: <linux-pci+bounces-42649-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 594A1CA513A
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 20:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B3BC305DF94
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 19:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2710D34887C;
	Thu,  4 Dec 2025 19:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2cfqfy+Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010031.outbound.protection.outlook.com [52.101.46.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C263491CF;
	Thu,  4 Dec 2025 19:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764875396; cv=fail; b=O89+e9p6Ups82evmXHuD9/rkco8DZBGVrItfa7YLvvgBjO4hZyQCE/3VIQMaENhYWL1qxq0fX9Tvoz4oqbBXubemQemGxyhRxvnx8PR8d2wcj5icS6nxS//2DjvG909Kf9jDim2XF6S83/p5MiUr9ssscRtJ28lD3w3njbooSJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764875396; c=relaxed/simple;
	bh=w1WHbN5w6e9LS0KY4ZOf6taQubxgjTC5uNNeQLGeQJs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=Lj3Ya60SRgbnI7DBtS+MwGcMz34BNMWCcBCndnVoJAhLINvlaRmVKQj5UT+c8Adecra6adCGUh2iiCBlmdJng2OHaW0Q+c7aWjmmCo4DQr5Xso7WcPLn7XSd69efC63Tv4P1IDjLFBigRYkwi3K96wUc/aHFxAX9utf6+EsNcZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2cfqfy+Z; arc=fail smtp.client-ip=52.101.46.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fc7PxwdAVb86L2LSRmbBL5oQgpDMHhtAYaXkjRzZYq63AaAaSRN7zjYsUApWQEJCd9McNlUGtl2YVbbE2lsdGJlLolcXUC8+8f58lU0lbhvvMyv4qK3vzER8zXX0t0GF6HDKFVqs4v8PYDkVB8KvID3kDqZth+CCXctPbriIEUzisCtBPHB9eNzDNyWlkHOpQ6iVqtBuvwllgd67H0nWOPe0ggww3CSKh7Udw2USNZY0kDH6zWfrdyk9+k9a9TFUwkl9bJ2kqk/4749nwNGE5o1mYGJEneiUftvwTUCh11Jdi/FT8cep/udHuHp9fAO2X58qlMwVDMm3XbLlETcrrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tif8pHntfSulARpp2obgwN7bUDAnpECU37yLznaQoYw=;
 b=ppL/YB1vcyhUPPL6N5kM2uT/HVkjvHqJmBedtd2GRel9l14rf8TwgSscNGhO2eCBL8q1cdXtCTW+/HfzHJ1cJRYfNMdZhp9mwuykZGJoXPQRMZUsqn1NohNKa6eYje/roRdy0jw0qACt6p5LwiJANR98W5F6gavhXtsFohmm4wpu1xcdUyQFkjIzie2+C87hpMZKygkzqgXOlwE1fHttKHBTCYO4U7aldayBvhDYyD4nO6nxQ0Pj9zuvBiyuOO0FfEOMWK6UIDp4QpuDZQVLtDTgqHmX5wmxPIKjoLVAEX+ezCq52m4VlzA8tgaRe8Ng8dP6vV8V5ho0isI30+qMbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tif8pHntfSulARpp2obgwN7bUDAnpECU37yLznaQoYw=;
 b=2cfqfy+ZtH48RqvagCTAGVVnXoPYs4qZ+3M9RLruX+RyuEAadglQLZT8ESIUUE7lkReOMtwbjcCQ6UoEU/UDOijopwbgplZZqyCulDA3pcmiCMPptG0K3ok6iO+bc7C3atJgNfMygGkNH0nFYRUkp6D/aVNmHmYPKI9JgvkjWvI=
Received: from CH3P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::22)
 by CH3PR12MB8911.namprd12.prod.outlook.com (2603:10b6:610:169::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 19:09:50 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::34) by CH3P220CA0017.outlook.office365.com
 (2603:10b6:610:1e8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Thu,
 4 Dec 2025 19:09:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 19:09:50 +0000
Received: from [10.236.179.173] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 4 Dec
 2025 13:09:49 -0600
Message-ID: <22e47fe0-e2fa-484b-8fa1-2bff55cec8a4@amd.com>
Date: Thu, 4 Dec 2025 13:09:48 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 3/6] cxl/port: Arrange for always synchronous endpoint
 attach
To: Dan Williams <dan.j.williams@intel.com>, <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, <alison.schofield@intel.com>,
	<terry.bowman@amd.com>, <alejandro.lucero-palau@amd.com>,
	<linux-pci@vger.kernel.org>, <Jonathan.Cameron@huawei.com>, Alejandro Lucero
	<alucerop@amd.com>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
 <20251204022136.2573521-4-dan.j.williams@intel.com>
Content-Language: en-US
In-Reply-To: <20251204022136.2573521-4-dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|CH3PR12MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: d71a1458-caaf-428b-d039-08de3368b2bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|30052699003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1Z0ZDJqNCt0ZFJyVTYvc21IK2VuNi9lcVZHMGNoeGZ2ZG5NUUN1a0N0b0tj?=
 =?utf-8?B?d0ZVY2lBZFp5eDlHc0hBMytBN09BbkVxZ0JvMnFVUzZsYk5NQy82WUQ1TjRC?=
 =?utf-8?B?bG15QmZYbUpyQlczVk1uZ3VkT2YxRDEreXJzODZzSGh2SUQ5YjdncFNnTTFQ?=
 =?utf-8?B?SE9MRlBJY1VzQXl4ampRZjUyTnBoUE4rT1RpdVAxRHBieUxMWmNsQnRNa24z?=
 =?utf-8?B?RW5NODE5MEhzSjR0cWg0WWd4ZXZnYW5SYU9qcm1uL1ZvWDQzUmhxUFN2Lzlw?=
 =?utf-8?B?dnRXSFZuR2xzMFV4SmtCMlNGb1MwMzVReXBVMHlCSFJ1RVBndWZTQUVGNVor?=
 =?utf-8?B?NkRJUUZ6eUlnSXVhSENPM1pjUmI4V2puQjc2K1pmb0xvNktXVWROM0RYRzVn?=
 =?utf-8?B?SkdXbmEzdituMFIrbU16QjNCMzd0RVAwSnBwazN4NFNrSFVXcWFQN3pHUTh6?=
 =?utf-8?B?L2E3eEx3TXZTMTNzV01tbVlXWHlFWjV4dDVoSCtvblNacGVjZ2dKRldveGRY?=
 =?utf-8?B?S0NQczc5MnpJYy9zLzhnNVRqUFFVc1lPYytUSytPWjVVV3ZsU0FuTS9STG9p?=
 =?utf-8?B?VEtLcUVEVjRqMlFNK0RFMmJVcGhDQWpkb2xUYXpaQ0N0R3EyU1FEUGE0L1NV?=
 =?utf-8?B?czA1SEw1OEJnQzYzVDhZdWlWeUdNQllUQ0NpUVpaRHJmbTQ3RGZYWVlsdTVa?=
 =?utf-8?B?d21RMDZpaVhPUEUyWmRRdHZVamtOM0V5bXI1THhpRWZEU1dtbEoraGFNeXl4?=
 =?utf-8?B?SUJZSyszN0VMclEzeGNuSEFtcDh5ZDh6M3NIYjZyNDVkQ1VVbUFMaVBXdGU2?=
 =?utf-8?B?V1lHcGNOQi9mNkVJaHEwU2k5UVpyanozSmhGV3ZST0tNcXZjRWd6UTcxaGNM?=
 =?utf-8?B?MkRORTNsR08rQlhOY2o5QkF1M0JaUVY5WHNzenppTG14YmxnNVNIUHBkQ2RQ?=
 =?utf-8?B?QjhtanJlSDJLNy9MNSs5Nyt1R2crdU8rYlY1N2ZQNHRIVjVjK2ZZQU5DVUx1?=
 =?utf-8?B?MnBqOG96S2Y1NzhIblJtUUhOYnAvTWhIS294YU1lVWVGdStLbS8ybTNKQUtY?=
 =?utf-8?B?SFhGWi9aYTlreXUvZzlycVlUQ1FBWE53MExxWWRpb0JWZ0c0d2U4MVlScnZK?=
 =?utf-8?B?cnNVTUdjeHgyeHFjL3pnVmVZYWhlVEtxYjFaK3JuaG1nZkxsODFrWm5MSzg0?=
 =?utf-8?B?dFA3MXRYNko0OUZQRzd1OHlyNjYvZXZTQ3orancwT3FkbkcwWkFhQlZabWdu?=
 =?utf-8?B?WFRKUVNaaTEwbHdYODhqZHIxNC9Cams2UWRWZDlNckJmR2N6RVgzZ2J1UnRS?=
 =?utf-8?B?Nk4valZUT3cyWmpqbUR3TVkySnRjTllWMXNQbzlHVUpHenY1QU9XUUdMdHhB?=
 =?utf-8?B?WXlnYkJxYnpaZDRsaFVhOWQ0anpBdUVvRFhxN1FlZHdzeU9tTjROUzhpUWlx?=
 =?utf-8?B?UGhwaUc3M3VvZlpkbXFIeFBEUUhtMnNyUnRjOXBMc3RBZCtsVzd3clAzamVO?=
 =?utf-8?B?cTl1VjRnSjByZWJtZUliSllDb1BXbWxmSmlpRlg4V3NvRC9tWEVtTkZxTmVp?=
 =?utf-8?B?c0hmVE02dmh4Q2lSdkJJNVVEbU9BcVdZbVc3SVRaa2tFd0dYNEt0am5lanFI?=
 =?utf-8?B?YitidTlVN3NWRTlqV05LOTN6UUVRM2lTQzlvc05ZK01DMzNyanlHb09SZFNS?=
 =?utf-8?B?TVRNQzI3SXYyK0F0cUVnU2JqVHVMRnQxbHlZZkZ5NlZpTFVSNjlwYVlOTlRz?=
 =?utf-8?B?dmRBRmh3VVpuS1UxTW1PZDMxdnFGQ1JYQmlDK1F2eitlREV1K3hBMjN5eEhu?=
 =?utf-8?B?TnFkTVZ4THhRYU1KUGQ0WFR6M0gxcGUzR0R3TjhyNDA3OHNSOE9VUjlPbjZX?=
 =?utf-8?B?enYwMXpKRHZVQTVsUTZIVHNObnRxWUN2N3I1VllhSTN3aktRaUZDMHY4U2pt?=
 =?utf-8?B?Rm1xRWovQVo3RmpoWXQ2Q3BsTUQrQ2pVS1BONlVrSmFiamN1ZHpYY0Q1NzF5?=
 =?utf-8?B?MEZvK3o1dXRhTjZmNG1sSDZ0aVRBMDk5MCtJVjVRU2RDSEJHbjZRZmk5SU9t?=
 =?utf-8?B?ZitRd3FWVEhpb2pTMEhPSXBIV3RoSDZsbVhOUkRGN0VmQ0hKNU5EUTNycENh?=
 =?utf-8?Q?6+eg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(30052699003)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 19:09:50.0894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d71a1458-caaf-428b-d039-08de3368b2bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8911

On 12/3/2025 8:21 PM, Dan Williams wrote:
> Make it so that upon return from devm_cxl_add_endpoint() that
> cxl_mem_probe() can assume that the endpoint has had a chance to complete
> cxl_port_probe().  I.e. cxl_port module loading has completed prior to
> device registration.
> 
> Delete the MODULE_SOFTDEP() as it is not sufficient for this purpose, but a
> hard link-time dependency is reliable. Specifically MODULE_SOFTDEP() does
> not guarantee that the module loading has completed prior to the completion
> of the current module's init.
> 
> Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

