Return-Path: <linux-pci+bounces-20403-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB00A1D6F8
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 14:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 004B37A393B
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 13:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930471FF1C4;
	Mon, 27 Jan 2025 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ocDqO8Vh"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83CF1FDA84
	for <linux-pci@vger.kernel.org>; Mon, 27 Jan 2025 13:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737985070; cv=fail; b=EbmD2E0n4PXuhS3T+/Nw+tKBfGXTkF6WqcbAuZEM/+4MgK/ScR+7w49CbzBGxmUyus8N+imWwO24tij05hXd10AOK/Os8ICVFB+T77BU4ioPyC/TJwrNWcnA6/F6kABcI0SjZmEZyS1n7BE6Mo3Jr6fPirRcKfm63w+xqf4IFdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737985070; c=relaxed/simple;
	bh=h7bDZtKlbejtJ7p/M93wDm8EcVLmsbK/AtvVNyKpNrE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UJ0hU3o35cenYde3AuR+PugubXMShi9DgCGVk9fcBXnnf0M3uyaPMYK32WGlil7AsHBJxNCpfo8CRTk4oUHjnvStD5Ik9QTmWwT/jAJG29g2qI4wmzgRipH0sCJABuVDDFeN4NgrbaD6uC2PNwJibJCJkg8s6kq87qgfIrK3vrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ocDqO8Vh; arc=fail smtp.client-ip=40.107.92.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0oeKFnxlvEJADEFdsSVati7nWVwgcbZkgxm5MXouygZV/7N4a/EdU1oi/BY7MSHJZBl6KhKEVIf9ZiHY91SScKUL6fcf+Tb0EOYbFi0ID43C249RJPk36WFiUzhUwvBnW7U2bnBKn6ADmdePQCSo4QMDTXgqd0Eex6+d2rU/f2HKx9KFBvJ7yT/UWWJrTUTeKm7NbFd0/a6ch39gwudlH4UBTXv0SJtlko6BbYMr+RWV6cxA1MPbMXo0pNMQt7IiYQi3sR+SOMFnCz6JGxYjZUlyHOYe4rEyvmN0ieDQCBpvrPpS6h8eiuXDDPLQzx9mlj0jGHKSXOIYXNbspLf2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4J9Ubij2vAAkaK908lxvjE8/TbPtV+z0Inz4d+9oV84=;
 b=jlCjv1I4+1KFumXo60Vcv/hY/cx22KBaZFNlGQgBO3h0lKYPkiLVq9vJheMLWxmqXKXYcjqQ1P4Sx0kA/Wgp3IOZfRSp5EQ/oNehk5ZrPPnA1S9Fjdg0dUOoI1Wtxq8tF4fqxKQp499rjSrkl3SwWnFb+RwsMC6jFVc4b5Y5IvuTm3JubAnPQjD/h9xRy/9gwgxfPU21B0Ct/ExuTu9NexanRjkmu1kIh6t8k43jIvM59jrMdRJCWoe/mkYnI9vqS9Azb9K6/sTD/OSSwdUQckWpNkYtsv0Y2JVtRUaLq3n4d2fhbJanwArS/Ytt6PfFXnMuNe+vmjUJzQ1wlOsvYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4J9Ubij2vAAkaK908lxvjE8/TbPtV+z0Inz4d+9oV84=;
 b=ocDqO8Vhx2bhZyBH8GY+Yfv9/afLt8SWCvvppjQV9A8H9jwWDTyBHIQj9bS0oXB6hTnuS+dVrmRZqEV4wxkObMYegyQMFrhEdp5J849CpoFOWKmoLLQ9VMN1or6sF8LUUMHItsZPmKiIRE4ezfaiD2YE6YnjliVSi9dmH2DD0XHlS8ReE5LdEGWfS41WPOCldJssStcclJTBwhtf/kIbvL1l1ZcNC2m5YC/F3fwy8nlo5mFNzVhq8Hjja3Wr2JwwKrZK16YRYKB0A9lsXJfu9j8TjGtlLAGoFrlU61r+MQ0m1hb8lAzr/AL3QKfjB6oQ9yF7+JIPfXtPtAj+qkrlVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by BL1PR12MB5947.namprd12.prod.outlook.com (2603:10b6:208:39a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Mon, 27 Jan
 2025 13:37:43 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 13:37:43 +0000
Message-ID: <b324a46f-faf0-480a-a8ed-d6dc9b171ead@nvidia.com>
Date: Mon, 27 Jan 2025 13:37:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] misc: pci_endpoint_test: Handle BAR sizes larger than
 INT_MAX
To: Niklas Cassel <cassel@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Frank Li <Frank.li@nxp.com>, Hans Zhang <18255117159@163.com>,
 linux-pci@vger.kernel.org
References: <20250124093300.3629624-2-cassel@kernel.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250124093300.3629624-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0027.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::17) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|BL1PR12MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: bc9bfc29-5c77-4f18-c622-08dd3ed7c702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aktFSDRGL1NIeEd6NjY0Y09tVStHMG5QSFJHOVJPa0tuRFNkQm5pekEveUY0?=
 =?utf-8?B?R1I3Qm1CbWt0SmY2TnpuVHZUS3Zwd3hpa0NPUzMvd3orSTVJZEtDQmpjNmxE?=
 =?utf-8?B?R29hUWliTS8vUXlmaGlVTDNNN29rRFhUb1o2cVVvL3ZJbmVYWHJNSFU3Q05j?=
 =?utf-8?B?YzR1L09qb0dLMmpsTEV3dzRrUmJ0Tno4WGdoamJ4OHN3dXE1OHY1djYvNkZH?=
 =?utf-8?B?bWYrZWJqTmFMS2pncmZhZWJwTERHZ3h4OUppZk1ZVnVlOUJQdCtTYmxwUHhT?=
 =?utf-8?B?L1FTUWpsa0ZBWGVGTmNFTTNxa25hOGdkakhwQmM2Ny92ZExscm9pbGQ5Nmx3?=
 =?utf-8?B?N0hRRjJLeFVZYXJtSk5tTGJLMzkxZU9YSTNINS9WYkk1QWlpSVVsZHBLcUN0?=
 =?utf-8?B?dEdYRFlsYzlFZ0hUZzkwZmtuL21xNzZib2Y1RUMzOFdpbmtLa2JHRTArVjhi?=
 =?utf-8?B?L2RJa2x2NzNmbEhzUjh3NUZFQjl5blFNRlJ0eGEyMlVEK3dMeGtJOFVHeE9V?=
 =?utf-8?B?dTA2ZlE3UWh4cGp2ZDBiS1NTbXZoWE05S1VNb2FaVmIyNXg0SkdVZExObGtE?=
 =?utf-8?B?K2h4a0dlck1jeURHcmJlQ3ZnZEJNdlVLNDgxNXd3RC9FWFB0YWRBbG5oR2FK?=
 =?utf-8?B?NUJtVVpjTkJXQk1MU3dGOC9VTS9zcTAvRUl4eTB3NW0yVGJTeFVnSjlXZk1q?=
 =?utf-8?B?S2FYSDA3eWlGVFlIVVhMS3NlQ3lHM2dlNTdMazMzb0paUHp0SlhNRWpSVmlI?=
 =?utf-8?B?dk52dTNkcnJHczRNeVpiSXM1OGxmeUx1YVBHWGZEbkFRUmxlLzEwSVk0MW1V?=
 =?utf-8?B?bmFud1lPUFdZVmFtUy9xYkYranI2UFNrM2NCaEpldEF2QUlVMVJwNW12ZW94?=
 =?utf-8?B?OEg0TTZ2V0FQVDBOVjhyenNUeis2M29UMUcxVUZBSDNHZVFFajZjc1JYY1pK?=
 =?utf-8?B?Q1VwRStNTXdmeGdXanJCdjE0TDNEQTNyU3l6VjZpTkRsTyszN1NMN0t6ZGlk?=
 =?utf-8?B?elNucHNDb2xXRDF6NEgveGExRE51NHFhV3l2aXdrSFJIRndsSEd0VHNGRjln?=
 =?utf-8?B?d3o0dkZSWnM5Z0MzWnNZMU5ZUG1vdWdDTWxBdVZvRk8rQ1EzWm44NGZQUjBa?=
 =?utf-8?B?bzhIZStqOGlnZjVpK3lRYzMzL3N1aURBbjc1QjVJeUorZGp2cVBBaG5uQzcw?=
 =?utf-8?B?MGMxT1FxQVZveHdlaCszRDlUM0l5ajl0SERVMVlKc0dwYkVOd2VBd3VQaG1l?=
 =?utf-8?B?M3pnWTFwQnZydnU5dlRXYy9XV1lzem54Sjh1M2hKaHhCVlhqRHpFb1NOaXRQ?=
 =?utf-8?B?RmZNQlZ3dE50UnR2dlQwOFpKVTZOaE1pcEIyblZWNlZMQytiL0xLVzQvWmpE?=
 =?utf-8?B?eHB1dlZzODhIZ0JaaHlndUxZOG8zZGJqQWRJSEJJMHFYYU9xOVdqL0FSeHgz?=
 =?utf-8?B?cmZDQUFQaXhPSXRTZ0UxdWdVaURyR1lnN3ZKSEo0b2R2OGhsM3IyUTErVVBs?=
 =?utf-8?B?R0p6ZjFBTms5WkNvZnE5Zlhncm41OHJVNjJ0bnkrem5Yc0F1SUwybk41QzNH?=
 =?utf-8?B?c1lLWkozc1dSU3dvKzBqZUNFL214UTV4M252dk8zZjh6aHVOV29FOVlIMklJ?=
 =?utf-8?B?M1liOFlBblp6dm03NEcwZEIwUWlJVzVIVmpmYzN5QTA5YWVoVnlwWGZ1T0hs?=
 =?utf-8?B?TitqL0tuWGJwZTQvWHR6K2dscnBCa1gxMzBFZDNDT3RNUDlCTDZsRElOU2RZ?=
 =?utf-8?B?WXN3R205d1gvRkgwMmRvUTFodnZlbW5YT2ozcmJxZy8wRnZaVmRvc1cyUW9u?=
 =?utf-8?B?U3NIaDM3Q1VIbVZydmpjYytMSGwrVm9ST2JsYkpKcjc5d3g5WWpXcWx1RVFV?=
 =?utf-8?Q?uHGP12NwjdNL/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TS94TXNhMjROTjNNWi8zTEo5S0hXQUV3VjYzaTZ1RTd0WHJXd0lBNUtUakVH?=
 =?utf-8?B?dldUUjhaTjQ5NDMrMXBNRXV0NWtLd0RERVFERWt4VjZkMVJmcVhTaGJKYzdO?=
 =?utf-8?B?NGlXeXBQSlNIZVhZNVQ4ZitFekE4WDhBTzNHUDVqekowRTlCS2EwK1U2eGNs?=
 =?utf-8?B?MlRTenU0ODJCT3ZtMmFRNHRtSlFmMmVRTGtPcjF1VGhRZExKSGJoeGNxOTJq?=
 =?utf-8?B?M1dsSVhpb3FiK1pycGJIYWg0TkRwR1YrblVWYndLYnB5V3JuNnJwR1E2ZnBl?=
 =?utf-8?B?MHkxTTRVL2orcDZuRGoyM1ZOR3ZMWWRXQkZiSlBuWko2UWxaaG5kSDlBZHpn?=
 =?utf-8?B?NVF6Wm0zdGE4U2dOZkJjemk0UExpSUxvTjJhOHYwOUYvUnh4eGhsWllNbXNX?=
 =?utf-8?B?dzdCODh5VDV0b1djZXpCQTRiRmU2ZlFUaGx1ek4ySURtNW83YUliV0VYZ210?=
 =?utf-8?B?bnAwQlU3Z3c2R0VkTkFzbGxpL2MrdUpXeU1iMG5EOXV3TUlBQVB2RGNCOTNJ?=
 =?utf-8?B?Y3A2VVc0WU5KYVFwWFhFNis3MUowUVhpRytoa0ZoVm12bTR0VmFEYU1VV1dR?=
 =?utf-8?B?Y29rZk5YSWRwTzlJRFk2aTluK1J1aGQ0Um9ydEZKd25UcEppSWNPbWo3R2lY?=
 =?utf-8?B?MCt3a3A1c3QyNURMVlpBTFQ3ZWU5bUxtYmJGcVdGcUM0V2RHUXEwc2pOU1NG?=
 =?utf-8?B?K1JXVTluVHB3L3B1Zk9LK2FNa3hiZmltYi8vT0hYRFVBRmVUd0pmZU9oQjB6?=
 =?utf-8?B?Wk1JM3R6U1VlZUZvRldBSmZFUHI1eFNaNlBTZm00K0YxYU5iNHpLbm9mWTZO?=
 =?utf-8?B?ZURPTzRDMXNsYjhFaWQxR2ErZFp3L2F6K1NqQmpteVFJbWVmL0paOC83R3Jn?=
 =?utf-8?B?enR5djRSZ0tEOHV4b2JTUjc3SEZDa2paZjQ3RklZbWxoUzA1UUd2QityQnN1?=
 =?utf-8?B?REs3WTNVZmJyZjJ2WHpvWHRhOEM4cUQ1YWx0dldmWDJHNkl5T2JNV0ppVkI5?=
 =?utf-8?B?QVBwSW9NZEF0U08yQ2xEMno0bFdROTlZUEg5cVFnKy8zUW9Iaks5cTZhTGVv?=
 =?utf-8?B?eDhiclRJaWVmVFBiRGVJZUNTTk5PSXJFRzExTXk4U0QzTndyQkVOREMzQmJ2?=
 =?utf-8?B?WE42bXNOeHArOUtZYTkvT2pldHd0eHNzTGNIcHFZa0VxWWJJQnRsWk03ckVW?=
 =?utf-8?B?RlZ1dHdMR25TdVBGZG4xSVNCU3UzVWdCTHgxbGo5ZTVyNVZkSXNTc2dZamhF?=
 =?utf-8?B?QkRjeGoyd1JEL09kSTJ5V3BFc3QxOER5eGl5Q1hubUJPTE5YSENFWC92c3ZO?=
 =?utf-8?B?NnJnR1E4QlcwdGFaT05jUmVoOUVJUmFUWlpyNUZabUtBdjJwK0kzR0d3K0xE?=
 =?utf-8?B?ZGxWcy9VN2tTVWZFemtGdGhyaFpucHpYYndYM3RFOG02cU5WTjhRcXNPRFNE?=
 =?utf-8?B?OHhIaHA4Q3IyRGRMU0QxcGQzajBKQm9ueE4yNzNsRVZ5dzBtcnRNWVBndXNV?=
 =?utf-8?B?K01ZUldOYUpkWW9wbHZKdFVjTUFMOTdOYjlWM0VZb0k3cm83TU9RN09VZWNF?=
 =?utf-8?B?ZURteUJCUWQ5WE14VENYUzJPVWNDTDVXSi9oUHlTYzM5b0VNdlJjWjhuTEtH?=
 =?utf-8?B?bHlVampTbDJXY3lKWHF4L0NaRXc5NjBxR0RMSHFEOWhJayswWTFwRXNjU2pm?=
 =?utf-8?B?Qzl4NW1mUXBkczF3V05nbVVwWDc0N2dPNmx3dG1mNWpURzFkM01mUUljWTZk?=
 =?utf-8?B?dkIvUlhrVmhJYk1rQkdyRXlmRWhJRkJTRDJZcWVFU0tCMElUcUlzdDlvdVQw?=
 =?utf-8?B?QUl1OTZkbVhjcElDRVlpYXlCSytJR2EvUC9HeTBHYlhWZWUxOEJNVk1kSmll?=
 =?utf-8?B?c1hqdTV4dzQ4V2tlS3FrSjVtYmNydzNWOHFld1kxRXpybFBTVHhYMzlJbkZa?=
 =?utf-8?B?RUF3dGVqZ2tkZmlHbVdHV3NRb0haQnJ1azBKVi9vYmIvMlBBOHVMUzFOS0h6?=
 =?utf-8?B?WXNwTEVLTjhhMUR2enhsZnpHUkhUdEZsU2xHTm4yekpDa3F6RHpiY2Fmd0VG?=
 =?utf-8?B?U0NCaVZKazFWTTIzUm1TZ21sWm83ajQrRFJvN3V3NEhIOGNQVGVpOEJ4TTF6?=
 =?utf-8?B?S1habVpEd1N5cUdmdFBUUGtlZjlqak1rUzB5Tjk1Y3pxSitTVEwzSXdXTW1Z?=
 =?utf-8?Q?tmKw+4Yse8KhCLOPI8oMYrWd4UJxcSyv98etAktZpwyn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9bfc29-5c77-4f18-c622-08dd3ed7c702
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 13:37:43.7010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1c2P7H0DRW/3+20mX/S5xY1CO6g8E/ojA2GNpjDnSKbdZoy2PddcQ+oJZ1V6R9t7X+xYxESCLlYppJ/rFM/ESQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5947


On 24/01/2025 09:33, Niklas Cassel wrote:
> Running 'pcitest -b 0' fails with "TEST FAILED" when the BAR0 size
> is e.g. 8 GB.
> 
> The return value of the pci_resource_len() macro can be larger than that
> of a signed integer type. Thus, when using 'pcitest' with an 8 GB BAR,
> the bar_size of the integer type will overflow.
> 
> Change bar_size from integer to resource_size_t to prevent integer
> overflow for large BAR sizes with 32-bit compilers.
> 
> In order to handle 64-bit resource_type_t on 32-bit platforms, we would
> have needed to use a function like div_u64() or similar. Instead, change
> the code to use addition instead of division. This avoids the need for
> div_u64() or similar, while also simplifying the code.
> 
> Co-developed-by: Hans Zhang <18255117159@163.com>
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> Changes since v1:
> -Add reason for why division was changed to addition in commit log.
> 
>   drivers/misc/pci_endpoint_test.c | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index d5ac71a49386..8e48a15100f1 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -272,9 +272,9 @@ static const u32 bar_test_pattern[] = {
>   };
>   
>   static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
> -					enum pci_barno barno, int offset,
> -					void *write_buf, void *read_buf,
> -					int size)
> +					enum pci_barno barno,
> +					resource_size_t offset, void *write_buf,
> +					void *read_buf, int size)
>   {
>   	memset(write_buf, bar_test_pattern[barno], size);
>   	memcpy_toio(test->bar[barno] + offset, write_buf, size);
> @@ -287,10 +287,11 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
>   static int pci_endpoint_test_bar(struct pci_endpoint_test *test,
>   				  enum pci_barno barno)
>   {
> -	int j, bar_size, buf_size, iters;
> +	resource_size_t bar_size, offset = 0;
>   	void *write_buf __free(kfree) = NULL;
>   	void *read_buf __free(kfree) = NULL;
>   	struct pci_dev *pdev = test->pdev;
> +	int buf_size;
>   
>   	if (!test->bar[barno])
>   		return -ENOMEM;
> @@ -314,11 +315,12 @@ static int pci_endpoint_test_bar(struct pci_endpoint_test *test,
>   	if (!read_buf)
>   		return -ENOMEM;
>   
> -	iters = bar_size / buf_size;
> -	for (j = 0; j < iters; j++)
> -		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
> -						 write_buf, read_buf, buf_size))
> +	while (offset < bar_size) {
> +		if (pci_endpoint_test_bar_memcmp(test, barno, offset, write_buf,
> +						 read_buf, buf_size))
>   			return -EIO;
> +		offset += buf_size;
> +	}
>   
>   	return 0;
>   }


This builds fine for me! I have ran through our testsuite and so ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic


