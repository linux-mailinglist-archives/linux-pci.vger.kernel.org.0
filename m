Return-Path: <linux-pci+bounces-27124-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C19AA8936
	for <lists+linux-pci@lfdr.de>; Sun,  4 May 2025 22:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591623AFD26
	for <lists+linux-pci@lfdr.de>; Sun,  4 May 2025 20:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DF61714C0;
	Sun,  4 May 2025 20:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZkabI7XM"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15138494
	for <linux-pci@vger.kernel.org>; Sun,  4 May 2025 20:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746389820; cv=fail; b=lm5Q1tyu2cH4xR65erGjWBLI504dMep6ngMtppZ3Tpni3EbisKYOEWJSO1JKcGhyd8vywRO8R0rDhUfmTWHh2IJ1NSTxbhgF8GowmDLV3dhJT7zJAomhXlX1XNK80WfFMcA9kBFOk9BZweSd5prwt9ygdBwmQBvO34c3aQ9QLjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746389820; c=relaxed/simple;
	bh=TT2r7EeLeQu/jCQVWTmoFAA/rU1zTpt+XPORtdLw8XA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RwFSsvHLoP12ngzxxDVtYOKnYt62sZoVnBxAgpIIDjoEURrccCtlc12z+YKILk67NdADNeXGXY9EBch8FyN741noWU/c1bP026WadRc42fihWLkXpcreaUhb5h92fP6dwjdDR9JuzIHV+45U/qq2ZJptXpWSIVTSV+SEzMjlm2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZkabI7XM; arc=fail smtp.client-ip=40.107.212.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XnKertOM2y0Iw/g7NoYyLwYweuQGvI9eGEKy1e+o8JKmp/M+APN28l7e8pvp8X8KVUXE+H7CPfuOZi1PB/Ht08VMeu0IPLvksQGIcEZlyj8PXiKlyZoupXuN4xGREedzzJvhyJE3mVIttfXiYiwgtpspVuOR/DPQB8GpjQv4tzqU+UnL10q6t7dT3wiQcZJNh2eDXFJI0ShyNahzRJxfCoAn7nYwFjnJiI4/zwGFcnRSS+G92p9N62zDeQ0XHAOzbXiwGxgQsenUnEF6QEy32OoTtldYAWN7KyIsm+WHU4a3Er3pDksb/MUbhLwKoWE4hPWSKjHgu/Mr4qNAbGY4yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvJ0FWw/KXjDE8k+7yMHm8c68cs2hLwnQ5NJzIuppdQ=;
 b=fH9oMLkdA8a1LcjPdxfWEHliE3nrryJhPe65kfYZGcPivOJTGValbDP69ovHKgoMmuV7KA0Yk42sUGRx7VUikBipwF23GwlzK+37aRQWYVvF6Wr0OAJVzZn0bX1liydEUYsx9CmRudcd0AVdkpKU4DdYB87e3XWRVwYgKW/8Ajl9+SQjDLSfOvJ9l0jnytpZi3s9V6re64Yeg1Jm52jg1tLXhihNna7xx5EMI/6mGxpHRsIZTnVsnciBrI3YUFIAj9uG1xbzOpBQJYIrF9kYapm27EYYV7EhPZe10caQBXZYm6WAPBgR84DgxiRzZUBiWdQXJS04D+kN1nyyKpAU4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=wunner.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvJ0FWw/KXjDE8k+7yMHm8c68cs2hLwnQ5NJzIuppdQ=;
 b=ZkabI7XM8bG467txC+JYm89XVYFB+wjcLMxoCKqjQi/EglPY76IMz/oPDiahzZ4bdMUg8uxpaeoQsKqTeE4XDZuJo9PWwp+l5NIc5Hc0i0vYdQ9/Ho1pMtVQpSkKyJprkj6XGxIl/0X5GE5RX8ngRO3gKMO1RFF9WXzOyZvi/Y7mNdHNn0tOZyh0XdvTkLeMsqMxBonbjgvELSDIpaUOxsUcy8NCggckmxQGMK6jbqFpU1J6f6uOgdLQRVrLx1rTZ4E3SWGDXO+AWjbYzl0FXsPpBVBdiscxoiyJysL4YYPL4xnAbj3Mw0iPAn39z6GoTGR7nkevwAFna7o/kHdwog==
Received: from BN0PR10CA0009.namprd10.prod.outlook.com (2603:10b6:408:143::6)
 by CH2PR12MB4117.namprd12.prod.outlook.com (2603:10b6:610:ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Sun, 4 May
 2025 20:16:54 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:143:cafe::8e) by BN0PR10CA0009.outlook.office365.com
 (2603:10b6:408:143::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.27 via Frontend Transport; Sun,
 4 May 2025 20:16:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.3 via Frontend Transport; Sun, 4 May 2025 20:16:53 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 4 May 2025
 13:16:44 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by drhqmail202.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 4 May
 2025 13:16:44 -0700
Received: from [172.27.33.235] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 4 May
 2025 13:16:41 -0700
Message-ID: <61d92969-2da1-4845-8ca6-0e1e399148f4@nvidia.com>
Date: Sun, 4 May 2025 23:16:39 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Fix missing update in pci_slot_unlock() after
 locking changes
To: Lukas Wunner <lukas@wunner.de>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, Keith Busch
	<kbusch@kernel.org>, <linux-pci@vger.kernel.org>
References: <1746376292-1827952-1-git-send-email-moshe@nvidia.com>
 <aBeplBA5FLjjXktu@wunner.de>
Content-Language: en-US
From: Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <aBeplBA5FLjjXktu@wunner.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|CH2PR12MB4117:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a4abe3-5a64-4420-0051-08dd8b489c87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUpOWjVJOWppN05SM2xiNmhncFNpZkNnZDF3ZmdMSnlaUnI2cE8rWVlOU2Mv?=
 =?utf-8?B?STI1SWFZWk1DSGtDYVFuS01zRFBRdE5MWUgyVUhLdFBvL3FldGhobWFKSVhn?=
 =?utf-8?B?QTBjZ3RndUkwZDV1bzdCR1NqV2VQSDB1M3NsU1hhZ05ha3I1SlliNUI1N2c1?=
 =?utf-8?B?MkVLSTFicXpNcHI4SHQwOHUrNFJ5cVVXUDBnamYvMW5xdkZCeitjRHpoWW1C?=
 =?utf-8?B?cFh3aG1UY0VFSXJOYVc5c2VUcTFOMS82Skhmd08xb0ljZWx1b3hyTTFKcmhD?=
 =?utf-8?B?eEc2dVNqUjBGcWdXY2tlcGZqbG50bjJ1T2VwaFZ5S3ZiMTYrMnBpUXYrSVk1?=
 =?utf-8?B?eTdkb2wyR2lUeW53Y1hzRkNwTWwvM0dLL1lWdlVldTRQN3ZGMGVyZ3lzaklO?=
 =?utf-8?B?ZnBIcWVDcXJMWXZySFlwVTRCS2tVSXB0U2hubTI2REYvbkNwSm42L0JEc2JR?=
 =?utf-8?B?K28rTXVwSnJUWmkzUzlGbHFnbnQ1cW00MVhPZ1RtcGdNdWxPNjNmVTB5eGcw?=
 =?utf-8?B?ZFg4TnFDdHlKT05xT2lHQUxwbWtQWG5jRlNhQ2xqaVNIQjYvSDJMTGx5S01u?=
 =?utf-8?B?K05DY3VVK0dSL0h5aDNIY1JYUGhsOVRDMTFMWUdxSHBtVCt6dkF3QWdrRTNG?=
 =?utf-8?B?ckM0RWZ5Ykpmak83SFZqbWcwSVlCZ1ZCWkh2dnVkM2h5STVDQk5tcXE2Y3Vx?=
 =?utf-8?B?UTM3ZnE4OEU0dDM5d1U5V0FjKzFmMVlZOFdqZ0JrSndVTzFqV0k3WVVkNTJB?=
 =?utf-8?B?Z1F5T1VZMG9SaEJkSGlKVWc1bnkyUUk2NityQ0FXdGtTSllGYmR5OUZ4THJl?=
 =?utf-8?B?clBXc1dDYTBWaXdKZkttQ3pPRmQ3eHEva2hRM1lseEtKdzhIK0hrUEpTc200?=
 =?utf-8?B?dktNV2N0dmliS0w2dHZnQXd4VC9DcDhnNWNFdHYrWWpvWVhrcjN6VFBQazFr?=
 =?utf-8?B?dmNqMmtUczVOVmh3OEhxSkcvKytvMWhpQjlMWitLWTExRHBGT3Q5bVlzZENv?=
 =?utf-8?B?aUVDaElxYzVUeTVFYTBVQ1l0Tk1CSlZtcEx5SDIzMC9GQmZkalgyWUk4VWFN?=
 =?utf-8?B?YW5PdlRYbkFhcFk2OW05NzUyR1VVY2NTR1hTK3lGd01UdUJtdkpJTllWZXlm?=
 =?utf-8?B?UWJtbGdsN2haWWttb08ySTZUdC9JQW5RTld4M3pvOUFpVHJXaDN4MWhrQkNr?=
 =?utf-8?B?WHYwR04rSGIvSG9oKys5dkU3eVhhU3djZmdaRzlHK2ttSXNCelZkOUxlYito?=
 =?utf-8?B?M0R6UVh0bnlMcjExMjl1N2hQWXZkTEJkTGpuM055cXQ5VWttRDNVWnpSSVJ5?=
 =?utf-8?B?K3hwM050eDdWSXhOSDNPSndiUlB3RXAwYlhDZG91WVpnS3BjYytPUTZnZXIw?=
 =?utf-8?B?REVyNzk0Vy9wZTg2ZGVqc0dOUGFFZmwwZzVMeXY4RFl6cHRMVzlEN2NsN1ky?=
 =?utf-8?B?dlBFZEttVVpuN2ZUaUtwZG1LZHhuakZyUGovOFFSdlJSWm4vRVpmRkJLNFk1?=
 =?utf-8?B?VUVmdlVLeWJGeWtyb2p0UWhMbVpOaE5wVmxpSzFVWW5xLzRGeDQvSHRDcXdF?=
 =?utf-8?B?TGFCWGFaVUt5VmEyc1Q0R1B0c1R4alB4dk5rUFc2NE1nN1ozK0JvTHppZ3ZS?=
 =?utf-8?B?c0tnNDlNRVVlZDlEb011ZGkwWGdPQXp2VW40R20zcm1SdUNCRmlpOG8rQ2M4?=
 =?utf-8?B?MHJ5b25nM0daNitGWEJHNGNoazNCeE03b0h5cCs3YjU3SThRYmUvdFlGL1Zz?=
 =?utf-8?B?dXUzYVBicTZpSW5aMUk3OUQ0Skwyb0Vvd20yQW9VY2JXeUV3QkVuYmwzSGJD?=
 =?utf-8?B?RHdONVVCUE5aRWJoNUpTOWI3TW9GVmFwQllqVHI1eS9HazVLRVgzcHBicTBw?=
 =?utf-8?B?VWJTWHZORVV1alp4UHJpRStpT3UyZnlOQURzWnB0djdEemh5czhXOThGYW95?=
 =?utf-8?B?cW1XQUovUzNuMHlDN2l3d3V0UFRTZ0czekJqdkQ3dWVWSmJydG9jQmZvQ1BC?=
 =?utf-8?B?LzN1Skp6L0d0amRMSnJpN2tTUmNCTkNvVmhYRmNKZlpLL3AxQ0Q0N0w4dFRt?=
 =?utf-8?B?amVCNkVJcnhZdU1LWSt0aHhpczBSYUhmTlJOdz09?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 20:16:53.4581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a4abe3-5a64-4420-0051-08dd8b489c87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4117



On 5/4/2025 8:53 PM, Lukas Wunner wrote:
> 
> On Sun, May 04, 2025 at 07:31:32PM +0300, Moshe Shemesh wrote:
>> The cited patch updated pci_slot_lock(), pci_slot_trylock(),
>> pci_bus_lock(), and pci_bus_trylock() recursive locking, and adjusted
>> pci_bus_unlock() accordingly. However, it missed updating
>> pci_slot_unlock(), which may lead to attempting to unlock the
>> subordinate bridge's device lock twice.
>>
>> Fixes: a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
>> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> 
> Ilpo already submitted an identical patch on April 30:
> 
> https://lore.kernel.org/r/20250430083526.4276-1-ilpo.jarvinen@linux.intel.com/

I missed it, thanks.

