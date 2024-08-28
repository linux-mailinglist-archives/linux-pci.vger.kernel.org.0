Return-Path: <linux-pci+bounces-12390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC209633C8
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 23:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CCC1B21223
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 21:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1958D1AC8A9;
	Wed, 28 Aug 2024 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EZAj4jgo"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCAD1AC433;
	Wed, 28 Aug 2024 21:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724880250; cv=fail; b=kV5F8VXx8I/+jN+BBSZGscubUhJWx8lk0ZtI0PEAodwQKFejueySJNLnUoBgAKxMW0vQ4ZKezKn/KBsqtVHuox9aIBjduZGSIGLFQJj0OX8vk0yFYAOfk5J44ltsbFPvKx28YD9unXoFfvihwXakZgSEHzlKTO5a/iI14TP5wDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724880250; c=relaxed/simple;
	bh=up8oknOEGhshV14c3bxUovIF7dvRXXZ5jzIQNQprN2c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DPsEl2wkC1G/vAd6psBz8tVyBwUJVq9Q0FttnlWRxP4VAwbmsjecbALTub1YDhUOb61QA6PfvWfalVgfIqm2SIT3TXnoM7wlonxFtdBkcaMY5qXbKp01d/c6fc6MJm+aErOazxGhTVsD9MCQs1LKrG647xP0x0JIYHnDTLY2oJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EZAj4jgo; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WeQQUtvcxJinE5nNyrHIqQ4yJKJ9C1u0cmQGGO/kJZ9Q1sicJFqTAaDXOaiY6JBB/PAEZe0z4MedvHvDRkFv2tlaKGEDsI53uk+icdRKy8VQmE74QtdYcGt0Z5CDPfganYWB9aTVwIaZxn7ZUvjyUdVAIDa/a8X1Oh6xVkRdU0cmstlVeeZX7OPwGaLF3aRlyG8Gd4KGsADAGzt5sEFsu3lvn6ReakIbXrEIOG8tb2kBb2sHiPANDlR0gKEl1i/qB1SNgdRq5thU1zSmlYxQj846hZv1O+hN68JVtq2LVwW8H0X3HHexnAdzduLb9n5ybgN9n9rFCvcrzM7p9U5yhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bd6kxscnjBayxnIUGGCMHh15JFGpG0cFaAiBfddbbwM=;
 b=EbQ7fKRJZTKNYTRxwh0WihjqRn5aCgcrlvFwBWix1Sp+41M1IPTxPS48u1HtUmOwD+i0Vx7ShX5pROCiZwPlu00spVTbwPud88pEyfwDeFriGYGOx9l5NYzdeqmhxKTf2PWUeCwkyGMSnkzvkkYUm5gK+38aU6gKGsUYKfPdIBA80a9queo4h6QVwxSMypoStKq/t1ZYv7wPZNKCd6/N2cCfKngYBy2K0RWdO7ImaJRtvlKp9Hvro3ymUbddZrdSpkAgXGGwhJDcORLwywGJetrURiI/W2t1vlSycxF7nDrUHSgHAOfAi+uRtAMniMmOPNaq3zqE98BCD5IuKk226g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bd6kxscnjBayxnIUGGCMHh15JFGpG0cFaAiBfddbbwM=;
 b=EZAj4jgobhYaQM8P8eHYnaKEQ3x/hFbwpAlN+Q4WgdZvJsyjjUl+LuaZa1goo7xpiehTBS0TIqEOLxIzR4vPGqSPh5nZW8qMegg1UGrd9y53r5Cpkjwxa8cnEchmKnltq45/Yc0/QnTf1517uk1B6Mm3tjUPIWtrORzAoy0lSzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 21:24:05 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405%7]) with mapi id 15.20.7849.023; Wed, 28 Aug 2024
 21:24:05 +0000
Message-ID: <30d9589a-8050-421b-a9a5-ad3422feadad@amd.com>
Date: Wed, 28 Aug 2024 16:24:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] PCI: Use Configuration RRS to wait for device
 ready
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Duc Dang <ducdang@google.com>, Alex Williamson <alex.williamson@redhat.com>,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 "Li, Gary" <Gary.Li@amd.com>
References: <20240827234848.4429-1-helgaas@kernel.org>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240827234848.4429-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0022.namprd21.prod.outlook.com
 (2603:10b6:805:106::32) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|MN2PR12MB4469:EE_
X-MS-Office365-Filtering-Correlation-Id: cc177a01-bc00-4bb1-b676-08dcc7a7be88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVczVnR5WTFuVEtlYWRKL0ZIL2g1b2gyVWNhSFl0bnVPWUJ1eDBITk9zbmY0?=
 =?utf-8?B?dE51YTBIWVJVN2NEQXVoSTJzR0VSZ2V0NWc1aURWQ0d6cW5pQzdEU0FkVUVE?=
 =?utf-8?B?WU9qQjk4OUZkQjdXT3NCU2NKMGpuTXhSaU5DWUtwZXdlTFNRRGdFRG5MMVJL?=
 =?utf-8?B?SkRDaWdUTHQ3cDJDdGxlUFZYV2ltczFnVHdHN2dqbjlBRG9IWWJHNGt3Tmcz?=
 =?utf-8?B?ZVcrdFZuRGZkVHV0R01Ra1pVOXRMdzcvNFFKK1YvdXJNYmpHL2RrVzRaRmRk?=
 =?utf-8?B?Zk1YWlBmQlZMenhrSEYxbmFOVHVVbWF6RkREeHRHMGNlcVBXTzh1aDNmY0pX?=
 =?utf-8?B?VlJxaG81anpocCsvN1lncGlzUEVoOWFkTExaNVk5c0RGcDhab3NGQzV0Nktj?=
 =?utf-8?B?V3VKbWRXRXZxNll2OWtuQk4zaWwxdy9DbExUSEtXd3BPYzJIc3BqajRKZlN4?=
 =?utf-8?B?ZmFSTnRvVk1mNHFnTUR3Wlovc0ppN1F4VitlYVNuTlUzVTBFTFRjZmYrbTR2?=
 =?utf-8?B?OURrRmpWZG41REpSWnNXWnNyb0NQazBFa1E1MkZzbEI0UUxITlJweG85OHRH?=
 =?utf-8?B?aUdvZDlyQ282VGhMcXB0UWpKaE0wZGg5UjE2ajFEYUV3dFVEQlhlUkVOODZE?=
 =?utf-8?B?NEZiUlFEclpWT1dxK0FBTUtwNEVic2JsZCtQTW9UYWgyWEZTVXE1VkhDRWlH?=
 =?utf-8?B?ZTkrRUVDNUxuU1dvQUUzQmRQR2RsVXFuMzNLODhkL0VwdG5sZ0RPVDNzUE5J?=
 =?utf-8?B?UmJzejhER2NMR2xJaXBoVnVaa2tGYmp4bk9uZ1dpNUdkelNoMDVqeDQ2VmpC?=
 =?utf-8?B?TEx4OU4wbTFiUGpJSU8wdHpwb29iNXZLUG5EaFNRemNZU0wzem1oM1cyUEpX?=
 =?utf-8?B?ZHpKZUZDaEFoSnBPYUN2K0k0SzFLTHdFd0xmRWg4QnU3V3B4aVZ6UlM0RTBB?=
 =?utf-8?B?Q3lyVkRUM0ZZUTczS012TE5YcmpkUkhWQVlXZVlEUnJjZmlVMHVsLzdLK0ta?=
 =?utf-8?B?U3dQcTNkNVh0eU9qcFAzSTFoWjI0enUxakRpeWZiZjRHeFRWRjR1bDNNdGtP?=
 =?utf-8?B?Y1gwdlhjUlFPei9VR2FFY3Z1STJpc0ZieCt3Y0tobU9LN0xhVk1ORTVOZXpM?=
 =?utf-8?B?VDBNRW1VbHBoTHdjNWlNSDZ0Z0J4NEhBdVE1YUVmNGhwYTdHSE45Nk5OOWNu?=
 =?utf-8?B?ZFVDUkhjM252TldrTU1ndUZVZXZrWDJxVjdRdHFBMkdyWGNVakEreVlRaVhX?=
 =?utf-8?B?V0Exa0VwMjZlQjZBNkdCSjZNSkUveVhnSXJyMFZFTXBTditVSkdEUEdONE1M?=
 =?utf-8?B?Q29vTnptODFpdk1wbHA2eXpXZlAwRVViY2FweDRQK2RSMW1EL2Nuc2ZrbTQ0?=
 =?utf-8?B?QkZLamw4VFFrZHp0TGt0WDhqL1JGbVJEM0dMdnJSM0pNeGxQL0VRSTQydm1i?=
 =?utf-8?B?SFMwcmI3T0M5VW11Y3AwV0doNHUwOC8xdEpER3FpV3d6UEJ6UDl5RUFRZExN?=
 =?utf-8?B?V3J5elo3dFRwYWd1Rk5UOHUybk5rSW05OGVPY3N6OTZpcGpnRmhZNXpXN3lB?=
 =?utf-8?B?NHlqM1pkaVF1RSs1TDM5N0ZZMVBDOEZYTHVGRDRVMkVkNEk1MFNCYUtGK0xL?=
 =?utf-8?B?UXJST2JuZVBNYXpUZHlKT3JsenZkcFVSVXloUVpVQVQ4VS9ocS9Ubi9GU2Y5?=
 =?utf-8?B?Z0tGay9laVlGVEJLaDFZVzc1RDJ6UEdldHgyRm1iL3Rtbjg4Q1hHUk8wYkVS?=
 =?utf-8?B?bENnU0Vkb2MwSDVBczNBV1E2YUQxdnpPWTE5TndBUnF2UVVjQ09LeGtZUUhy?=
 =?utf-8?B?K1RZVWVDZWt1VlMwOEw2Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2RJdVBkaEkreDNGYmR3VUF5ZnBUanJLUzVac3NQYkRwMFp5cEpPU2IzbGd2?=
 =?utf-8?B?SGRrbEkzMk9GSTlsKzZpOVdhWUJBMnhhdXBQMHB6Q2JMUENwMUwyaU9tMk1B?=
 =?utf-8?B?b2t6ZWFHLzljRzFydG5qbVdoZWlhL1ZxRzhZNlFiVmNsY1c3UlJwMkJNenZ0?=
 =?utf-8?B?RG5yL1JuZzQ0a0RVR3B2dUljSUZrdzB5QXhnWG5zNEQycVpxY01DMDZsaDk4?=
 =?utf-8?B?UjFpeXl6VVpMclhsN3RvUENQWHdNdWtCUUJBMjYrb0dEK3FHKzJtbDNDa1Ra?=
 =?utf-8?B?RGE5cTJ4SkdLZ1RIR1NYSW91UTFXYzQzMk1oUFZvZHZ4bWErQ3Nsd2VIUkRB?=
 =?utf-8?B?Mzg3RHRaV3JSOEFydlk2RDR6TGlXeW04VHpGUmhEUmU0bjVYRE1sRjIwMnRB?=
 =?utf-8?B?TVdSbjVJb2tGN2hQYVREcy84ZVNRUGlvM1c0TEwvZ2tzaU1QUXRMMzRnajIx?=
 =?utf-8?B?RER2blZyU0pKL29NSzBlM3pFYTUyOEJoQmhHWlFNTVo5QlNNN0VaTGNlNm84?=
 =?utf-8?B?K2s4bjJKQmhJNUx4WXJTcURvVW8zT2FzSys4MXdyWkRnNjZKeEFYL2RQWHEx?=
 =?utf-8?B?Vi9aVWkzYS8va0lWQjdPQ0RHWFhvR1dlUEY0U3pjbEp1dHhEMzhiaEJGNFNz?=
 =?utf-8?B?Q05qMkhGQTdFWUxFR0pPMnVkMU1hL2dNUFZXajNhTFBBZlVrYzAxb1JEbjdP?=
 =?utf-8?B?VHZEdi9kNFRUTnlLS2YzYUUzM09NTGJzNjFCWEJtR2o3cnZOdVl4cjQyKzVN?=
 =?utf-8?B?OGJqam02aE1DT2hwVlEyVXJxRStpT0NlQVdJUVp4R0FTTHVWN3I3TFRpTG1L?=
 =?utf-8?B?NXJEZ3VQT2JpZ3poVTlTaUZOR3IxRnBacWVpQ1Z0UGFQdW5uKzFqMEp1ZzRW?=
 =?utf-8?B?K1dVT24vVlVpSXo0NU5GeXFVVk1JVTNJbTFTb0luSExJZ1VMZjZ5ZFpFYkMy?=
 =?utf-8?B?N0EvQVB6MjI4RUdUM1Q4alB5OUQ0SjM5bWZWejJCWXFIKzFFTk9FdWxvU0x2?=
 =?utf-8?B?NTZGQXNRQ2ZMVEVKaU9DTnhGOVFaZEhqRU1LakZkbjA3MnlBYnlURCt2aTNE?=
 =?utf-8?B?TzNSOGZDcjlVOXpIYVZsRGFYcnZSN21UeUMvNGk0L08xa210S09ZUTF1dk5O?=
 =?utf-8?B?Mit0K28wbGtLQnJIMmlWYTUySWdtK1h4WXR1dnlEL2JRdFlJaEFMd2xBWEhu?=
 =?utf-8?B?bVZ6U09xUmJlQ3NCRlNIeE9HTHFydGthbHh5dEN3L3ZERkNqS3ZOaWhGU0FL?=
 =?utf-8?B?UGcxMkcwMFpJMjFNNmc0MXpIOFo3TlNQTDI4NWVOa25LTk1oYkNkdzF5dU5F?=
 =?utf-8?B?NGE3bmMyaFhRTFNRUGkxWlRINFJsVENUYnVpZS9qZnFVQmYweFFtbmhtbHph?=
 =?utf-8?B?RS94cENJalozTWk3YStxT1oxZDRTZmFWWTdtYzk5VXZaRmdoUUxMNFRKdVdr?=
 =?utf-8?B?T1BITjlBeVNuZkdxSERJeXU5MG5zNHIxSGNGeTVxZHZTUnJNdGN4aUx3My9s?=
 =?utf-8?B?ZElHbWJ0NjhUdkRYeWdHV1d0Z1IrMXA1V3UwY3diWE92cis2VEZ6UnZYdUdP?=
 =?utf-8?B?aFFkTEI0UUNyMXQ5cWVseWM0eEhBN0JKYlVpbktodnA2QVAxdFA3aCtUYTRv?=
 =?utf-8?B?RUJjQWRVRW9waDhDSlFGeFlLV3drQmJvSzdRdzM4VjZZWENaaEUyeWwyb0NV?=
 =?utf-8?B?VDZFL1FxdmRGMG5EVDI0N29qMThqQURpRGRncWFyNHYwZm9qQlRBUzliT3pp?=
 =?utf-8?B?elZienlwd1dadDhDQ2RMc01UczNkUGtiMERZeGJ6RWtUdzJBNm1pRHR5a3dy?=
 =?utf-8?B?d05DVGZqeFBscUpmcUxJUnF6cWNEbFE5eWRzOFhYQVM4UFgyR053alB0SmVq?=
 =?utf-8?B?NU5VSXE1WnJpRVBYUmlZRnVqMEw1ajBycW9FZDdrZlRLMnlXb1VacFVmU2Vm?=
 =?utf-8?B?MUluLzNGQzZlcjg3elRmb1I3UE9IUFdOMHR0eVJyclFtVzM0NlpHYUgvRnlo?=
 =?utf-8?B?b2FBaFgzNWoxTEsvS1MrVVZtQ0FvNElOTWRWOFRrMkM4WlBVQkNyOGVvRXZz?=
 =?utf-8?B?TStsOG9XYlJYbTZwV3FRejFuV2ppVVh0Tm54MXVkVnljcXlHc3pLVlJsbDFV?=
 =?utf-8?Q?861Rf+brOQLlAazLpDpbuo5AJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc177a01-bc00-4bb1-b676-08dcc7a7be88
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 21:24:05.1125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKpyueIznSohDI1/pZNTW5APTygm8ej2aWXmXLUinLR6KDHwcbj31XhYTVBSTYZrJUfuuv2INwJ2IfAxedcE4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469

On 8/27/2024 18:48, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> After a device reset, pci_dev_wait() waits for a device to become
> completely ready by polling the PCI_COMMAND register.  The spec envisions
> that software would instead poll for the device to stop responding to
> config reads with Completions with Request Retry Status (RRS).
> 
> Polling PCI_COMMAND leads to hardware retries that are invisible to
> software and the backoff between software retries doesn't work correctly.
> 
> Root Ports are not required to support the Configuration RRS Software
> Visibility feature that prevents hardware retries and makes the RRS
> Completions visible to software, so this series only uses it when available
> and falls back to PCI_COMMAND polling when it's not.
> 
> This is completely untested and posted for comments.
> 
> Bjorn Helgaas (3):
>    PCI: Wait for device readiness with Configuration RRS
>    PCI: aardvark: Correct Configuration RRS checking
>    PCI: Rename CRS Completion Status to RRS
> 
>   drivers/bcma/driver_pci_host.c             | 10 ++--
>   drivers/pci/controller/dwc/pcie-tegra194.c | 18 +++---
>   drivers/pci/controller/pci-aardvark.c      | 64 +++++++++++-----------
>   drivers/pci/controller/pci-xgene.c         |  6 +-
>   drivers/pci/controller/pcie-iproc.c        | 18 +++---
>   drivers/pci/pci-bridge-emul.c              |  4 +-
>   drivers/pci/pci.c                          | 41 +++++++++-----
>   drivers/pci/pci.h                          | 11 +++-
>   drivers/pci/probe.c                        | 33 +++++------
>   include/linux/bcma/bcma_driver_pci.h       |  2 +-
>   include/linux/pci.h                        |  1 +
>   include/uapi/linux/pci_regs.h              |  6 +-
>   12 files changed, 117 insertions(+), 97 deletions(-)
> 

Although this looks like a useful series, I'm sorry to say but this 
doesn't solve the issue that Gary and I raised.  We double checked today 
and found that reading the vendor ID works just fine at this time.

I think that we're still better off polling PCI_PM_CTRL to "wait" for D0 
after the state change from D3cold.

