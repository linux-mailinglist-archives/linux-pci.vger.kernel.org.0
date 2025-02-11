Return-Path: <linux-pci+bounces-21137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A791A30345
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 07:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88975188A42A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 06:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CDF1E5B66;
	Tue, 11 Feb 2025 06:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2mQuF/D0"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084251E3DF2
	for <linux-pci@vger.kernel.org>; Tue, 11 Feb 2025 06:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739254251; cv=fail; b=N39pIXITNRlO0Qc1nL1wk4qX90HGIRxqrCeHKKt3hHKTkDPw9Q4xqyGhegNAe731YcdhtbXZ/5g8rTNzavQVYZLftObP6QjQYaVrmnJDVnYDQtpzwYhezXyYff/cjtkhURJ89E+nyzuCMKIXuUqIJYHLJr9d1yzcdnAqlcp8e7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739254251; c=relaxed/simple;
	bh=8O5oGIttWXRGXY7WqtiM+pumFawXEumUTpmtMurxxjw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SbbWHDT4d2L3HBm4Weljc3nQNriUVB+wJfpM25MLNdix0QwlwXQcw2g4wbylFcskWel357Sd0EZuQ9u6MB6YTeM8D0xSIAyUHSCcUPnamRC18dGmoj+bCqPjREb9uRJS8ZCfIdME03Hj1pZ5n/jxtpiCD3b68f7E+LC3brON0Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2mQuF/D0; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGUxWOwLt8tuBtm+cT5gGN8N84L21rG/z82ObM6yOUOZYOgNQxuouWqYUGQieJ1gOdWnwxdGlefifS7kmhXQE5PMwWfnZWrmEGVOQeBNbnWQwwYUl6OFWKmf0lHuaFh+CC2aOL13XXuPUXfMIh0lwrxt7XiGh9YrokK7NU1lPxgNBflGY5fNpEHEoxinTbsh2Q6EbnugB2oqvoerF5yWHXn/NBDtJLWjtUDWLoml6M9pMk9Kes9hYzAz8naWqoK1zGVRedrnXxmA8Mm0oio6Ish4NpE1xI7bSyF293mJDchT+HXyC6dWLjJnC/fyOqQOKbZJzIrrUjCJ8KSDcWb2kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAd2k6hA1kkCk0fh5BCEikzLert8/P+o/sU7nBovthg=;
 b=hhvL6ECUes7kypd3sztxxSpxInAw3Yx+MK6zF9WYhpXPwgAYMaOaN7yfcjFcYCJH21Ebv9aCDY+lbTt144xbfmBOFBox7iYYJ+szm+FCd8l6a1rmo+2PKnkU9peNMS561X+Ih9zzyjqWi8WwFGtAjoWuM7ajUY+DEhZI01F/xRwZJSzu2ewCWNgok9CpSzW64QCA2auKDa3ASKf+nezROAmKOym6KayEK41Yn9Cot2ANnRmV7qsZB260NJyK4xVSMHDNV2+omIhtnHkMomNn6KzSwQKl9u23SuxnXO7EZpra7DBngON2eNqBdKLjHBVHvHj+Y9vFSjGXw2xVjVXmLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAd2k6hA1kkCk0fh5BCEikzLert8/P+o/sU7nBovthg=;
 b=2mQuF/D0YKyCWiTXtcHu5tVQLsdOXpcnR1qLyxayJLfgQyErRzr6n8dVCu4zJ4VSQyVeMSoRXb25PttUJI9oapDsj5p2mRM/ePytNwVgDCE64DiodxwbxIzvypXLX5qUFMYu0AzJWcb0SKfsmABixDngWtBcZYjZncxRS1Jw190=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SA1PR12MB7441.namprd12.prod.outlook.com (2603:10b6:806:2b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 06:10:47 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 06:10:47 +0000
Message-ID: <deb682e6-6f08-401a-afc7-890bc48ec6dd@amd.com>
Date: Tue, 11 Feb 2025 17:10:39 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 09/11] PCI/IDE: Report available IDE streams
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
 Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343744869.1074769.12345445223792172558.stgit@dwillia2-xfh.jf.intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <173343744869.1074769.12345445223792172558.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ME3P282CA0062.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:f3::13) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SA1PR12MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: 26064883-c47d-4055-5d47-08dd4a62d327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjBsT2g1dWtCWDQ5bk1VTWFaUm55cmNWaG1KU2UrRytBdGdYTEZKek9RTzVr?=
 =?utf-8?B?ZFFlQW9adDQ2TUNFR1pCL2pxRXozcTBTRTY3VGs2Z01LblVscWE1YVk4Ullr?=
 =?utf-8?B?MlNJYlczRlJnREd5RzZScktFQXVrTXJvaWtjOFQ2T0tSSVh1VnVwdUF5U0hJ?=
 =?utf-8?B?Y0xIdUlKeDUyTWtkM3JaR1lCYVZCdzVjeWJWaWxGYWJhUS8va3VNY2ZIZlVa?=
 =?utf-8?B?b3U0Yll0VTlTUDJjTW9mU0daZ1VJVms1cU4yMkRDMDUwV1R6WlVxTDJJWjF0?=
 =?utf-8?B?MjNrbW04UDlqSVRHZlB6M24yRWJiMStVQ3JTdlNrRnlPSXhPSnduVnZQWm8z?=
 =?utf-8?B?NW9rMGs0WGxIY2t2TENzSVNYd0FMdWlQc3JQS1hkR3RNdzN1VmFjeHY0V252?=
 =?utf-8?B?M203UnFucnEyd3MwY3ozcWxpbXd4MHY0dE1kclhsaDczOEcxUlNkQUYzVG9H?=
 =?utf-8?B?VzhBUHYvVlZkVUo5a1dGbmVQOU15RUg3RGQ5Q21DZklmRUNpblgwUVhJV3NL?=
 =?utf-8?B?bWJtN29NYU9ISm9zNFNKcUxKdVpvVjZZQ09acVlhOE5uUTU2Z3RjWmo5dE1I?=
 =?utf-8?B?dVlRUU4wZzVPYXNYam9XVTc4U05JYjFqdi9CTmdMamVvUnlTUnRQWWVCcGxW?=
 =?utf-8?B?dmRMOVFZZ1g2Ni9wU1hpNHJpNGRCbnRWQVFXWjNmMDFlV2xOVjJNaE1qN1J0?=
 =?utf-8?B?RUg4ZGJvSHBaekRDZ0JwUkE4MmI5SUY4Vlc4dkhhd2pudmYvZVVFekdTb1J5?=
 =?utf-8?B?c0MwSUNvbytSbU5vZGNSN2tDWnNBc3BqNXJqMWJQUjJXUTR0Mit1OW9vUzhk?=
 =?utf-8?B?UlRxV3BSQjZ1VWdyMVFReEFHUEV0S29lL3dYK1hzU2ZjQ1dLRVNFenZMaXhk?=
 =?utf-8?B?dUhqMnFIbkZRVzJ2V0hLaTNlanhQR1FNcTE2WTVTUDBzWkRxRC81NWxXdU9j?=
 =?utf-8?B?L2k5VGlUZ2lrUkx4R3FDYy9iYUN1WEdoL3diSEdBSSs5VWNZVXdMaTVjZWxM?=
 =?utf-8?B?eDE0TkhRZndTbHc1SnRNNXJ0Rkp6MDNhU014Mm5mTU9YaGwvNzByVS8yWGh6?=
 =?utf-8?B?ZHlKZk10ZVdvRVZlNUFsQWpoVEluTGZ1RjlxTCtWVXFyVjhCZGFjUEZsR20r?=
 =?utf-8?B?aDBzS3JnaWZiN2YzUHAxQTFsSmhURFdONXdyb29FZnRJY0pmL2Vhb2lsNk1B?=
 =?utf-8?B?bjdQR2J1SjZ3aXgxaEtqT2huZ2VnVG9yWHkwT3ZRZXJxblFMQlVWVmZpTWJF?=
 =?utf-8?B?NEEzQWpqa2o5djFJanpDVzNHYTJJRjZHdEl0emFXVTRPaGJKNjRFTCtFVkls?=
 =?utf-8?B?S2lybXpaaDl3NER2bmhSTU1VMVJncGhlRTArVksvTEhuVjJ6SEZvaFp5UFNK?=
 =?utf-8?B?T0Z4L3l1aXE1NmpzVkErYlVLZkZhajhyVkpRc0NaZlY0SEttWEZtb3oyWmRo?=
 =?utf-8?B?SEhML0dTancvZTZvdnRmL0ZqWUVsUnZHb2pqcHdKdUxhZFZ6NjV3ZUtLV0tV?=
 =?utf-8?B?Z2h5QU5reHJ2bmFneE5qcjliV3FwQUFZKzVUTDUyOEpVMFRsZkQ1ekhtRXlU?=
 =?utf-8?B?dk50anpjMHRSRkFJNWZTVVJEcTRqeGZ4ZjlReUVQVEpWOG9aTllmNExMWm1G?=
 =?utf-8?B?cENURjhPdWVMaHFJZ1ZiM3lkeHRvWXg5dTJvendEd3BHblJzUjlsQUdPOVh3?=
 =?utf-8?B?Z0FDWlBSVTh5dk5Nc0hQSkllTEVwQ3FmcWhlZWJkUnVhU0R3SkRrbjduV2tq?=
 =?utf-8?B?UTd1cmNqbHNOUEdOMmpNa0xFM1lzdWRSSy9ubTNoRUpXMGJnNGZQY2NJeTdY?=
 =?utf-8?B?STJQN3JRMTRIamt2RjhHUFo3NDZXUFowSkFNS0hkOTY3QWc1ZzVaWGZ4YW5s?=
 =?utf-8?Q?toRgnqiokplXx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXIxTmhOeUVaUEJHZHN5bGpzMVpaU1VMNngzY0U4clZ0KzduYU5ZZnA4c2N6?=
 =?utf-8?B?RmN5cklXQnlmblhRWXRzbGZUNmVZQWRRZ1AwZEFLT0Joc0hpZ00xRlRKejdw?=
 =?utf-8?B?TFcxc1BwazBwRlVrMjFVVWtRYjJZdFJQWDRjNUltQnlnUkZRS05OWlJuTkt6?=
 =?utf-8?B?bUpHNEM3Vmx1RFlPU0FnVDFRTUxXOWdjSzlDbHVRTEFISUhZTHVaOVdiWVY5?=
 =?utf-8?B?Y1RJdk5mWjhlQmZ6eWJqVkhZVzJLaS9qN2QweVB2YTN2YWZQUThjWEZzY2FT?=
 =?utf-8?B?VVV2ZTNrR2wvRXZEaDU1emF4VjZLOHc1VXlpWlZQQVhXdzVQK29RQkE3Q3FD?=
 =?utf-8?B?VGlaMFRFVElDcDI5MDlURGt5ZzQ4T3VybWdQaWdvRTNSNXIzREtTa28ySEpK?=
 =?utf-8?B?N3pTQnhuQnB6SGhkNWxTRWRaaE52cXV0M003RzgwWlZBM3MzRmpKRlJaaXhC?=
 =?utf-8?B?ZnBNVzhPcFFQL0gvZ1V2aWFLMWIyQWhEN2VoTHNJYVBjcVV3Sk4rSnVueWtB?=
 =?utf-8?B?dmhQd3p4SU1kWWlzZUFLYkxiWnVhMml2Nng4SmVWcHd5N1U2OUZzbC9wcXh1?=
 =?utf-8?B?eXhnWU1iRUZJclJoSXRKZHJiRlo4KzNsK01ISWJSNExObFVVcUlLNFVsSitQ?=
 =?utf-8?B?MzhWMXBzZ1daSWJoK0xucTlqSWhyQ0trdmt6MU1ER3V4VnhLTmVUdTdYTitC?=
 =?utf-8?B?QUhPcmwrRHVNSUx1cGYwWnphMmYrdk1qb2ZrQ2ZPcWNSSHZoUTFwMHFndXNN?=
 =?utf-8?B?aEN1emkvRFNrTlAvY2VQL29ESXc1b2plUHhpd29pQWs4TUcvNDNvM2ZCUEpo?=
 =?utf-8?B?MDgrenBIaVdTZXJJaDBDQ2drTmZGQXIzTDh4VC9wL1UvL0YzeTF4MXl5S3Zh?=
 =?utf-8?B?NVMvMlhaamc5QlVZL0JyREVHdnJrQnR4dWpmWW1ZbUJDN1hTc1p0ZHFWa0VD?=
 =?utf-8?B?UVlQUVBYa05HbnRKdlpYNExLODltWVh1NDM3WkVYVEwzalU1MXhkRHFtREhO?=
 =?utf-8?B?QU5EajFVY3BydHNYWTJOZU1sYUkyd3d2M1BRWmhLR1UyQUpHZ0ZacXY4dnZ4?=
 =?utf-8?B?RzVsaGFWbUQxWnhMU0RYV2YvSkQrMjk0bTA4aXNDUGdQbzVFUTRQTXRreUM0?=
 =?utf-8?B?VlZ2TzJRZWoreHZxWWFOMkNTYkJGR3NJY2xubVJiS0JTM0RHakwzaHFreWl1?=
 =?utf-8?B?QzA3SFBxaW5heFkyMmxQWjZRWDYwWGVHc0o1bmRNcHVPUExZR3hJeEZOLzcw?=
 =?utf-8?B?ODdpMGlSdzlPYytKZ3ZzUkpvVmNWaldQU3dVMVpuVDMvZWpTSFAzNEwxQVpJ?=
 =?utf-8?B?SEhuL0x6a0RFQVp6a1dFOVRGUU02R1ArSUV1UFlycGN0NzJQTGMxemprSHR0?=
 =?utf-8?B?cnpsK3BlK085K0MyL3plSkNGMWkxUmtSODMrYWNhcGtjd0xrMmZvdUV3MHJS?=
 =?utf-8?B?VFpueHgzUm00VHpJVVIzajlkMUQ4ZDc0QjFQaDIyelJpTHVadWtETjk2eEtS?=
 =?utf-8?B?QjkwWGZ5TVIyOU01a2ZRdGx2SGdlb1BCTUhkWVlTeEJsd29IenREQmpSZWh4?=
 =?utf-8?B?Wlo5RVhVbnZQVzArV3J2eWJscldBaW9FYWRNRk1iNUtpVVdXcUc1Nk9aWm9p?=
 =?utf-8?B?VWJCelVvUzF0c1FoMlZQbGtpTHE2QWVDWDNwdXB0Zk1QSi9BQXU3VUdlem5F?=
 =?utf-8?B?MVI4RDZuTWJvazM5MWNwNmkzVU95WFZSK0liaU92Y2ZyMGw2TnZFZGFmeTl0?=
 =?utf-8?B?bDRxcjR2QTR4Q2N5aE0za1RvSGk1VU9SOW1DYjNEelpSWXFOaWlwZitOcW9i?=
 =?utf-8?B?TFE2NmY5SHcxeXBkaktsa3BXRVhlcFB1cU4wallvMjFVTlIwcU1lVDdNSjZX?=
 =?utf-8?B?bmQyTk91RTVlYjYvVDllNzRueVJoZk9RT2JJL3NLRnVmUkhrRDdaRW0vaFE2?=
 =?utf-8?B?TE1JSmJpcm5FRXJZaXFxYjM0TFMrQ1RRYlRYa1grZExvaDBvUXlhVVUzTFdq?=
 =?utf-8?B?U2JpYmlwTHY1YWFQeGpnQjAyclFvWUFEWjZWVzBFWm5MRkIzNTVVc1ZPZGZx?=
 =?utf-8?B?LzNjR0gzVlBBa1liaWZPcnhTbnFkdmdRMTVtSmhnNGJheUJ1KzQxY3pDV2NF?=
 =?utf-8?Q?6nLc00NLPoYrc3bfE0EhVHk0u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26064883-c47d-4055-5d47-08dd4a62d327
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 06:10:46.8781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wDlh2HPNCfBf88wtS4AK197m92DJex5q0gk5OwpjrC+qUfFNgl9q1QThaxG6c0kPRFSzTUwiwoFBwbWA5qhxEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7441

On 6/12/24 09:24, Dan Williams wrote:
> The limited number of link-encryption (IDE) streams that a given set of
> host-bridges supports is a platform specific detail. Provide
> pci_set_nr_ide_streams() as a generic facility for either platform TSM
> drivers, or in the future PCI core native IDE, to report the number
> available streams. After invoking pci_set_nr_ide_streams() an
> "available_secure_streams" attribute appears in PCI Host Bridge sysfs to
> convey how many streams are available for IDE establishment.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   .../ABI/testing/sysfs-devices-pci-host-bridge      |   11 +++++
>   drivers/pci/ide.c                                  |   46 ++++++++++++++++++++
>   drivers/pci/pci.h                                  |    3 +
>   drivers/pci/probe.c                                |   11 ++++-
>   include/linux/pci.h                                |    9 ++++
>   5 files changed, 79 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> index 15dafb46b176..1a3249f20e48 100644
> --- a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> +++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> @@ -26,3 +26,14 @@ Description:
>   		streams can be returned to the available secure streams pool by
>   		invoking the tsm/disconnect flow. The link points to the
>   		endpoint PCI device at domain:DDDDD bus:BB device:DD function:F.
> +
> +What:		pciDDDDD:BB/available_secure_streams
> +Date:		December, 2024
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		(RO) When a host-bridge has root ports that support PCIe IDE
> +		(link encryption and integrity protection) there may be a
> +		limited number of streams that can be used for establishing new
> +		secure links. This attribute decrements upon secure link setup,
> +		and increments upon secure link teardown. The in-use stream
> +		count is determined by counting stream symlinks.
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index c37f35f0d2c0..0abc19b341ab 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c
> @@ -75,8 +75,54 @@ void pci_ide_init(struct pci_dev *pdev)
>   	pdev->nr_ide_mem = nr_ide_mem;
>   }
>   
> +static ssize_t available_secure_streams_show(struct device *dev,
> +					     struct device_attribute *attr,
> +					     char *buf)
> +{
> +	struct pci_host_bridge *hb = to_pci_host_bridge(dev);
> +	int avail;
> +
> +	if (hb->nr_ide_streams < 0)
> +		return -ENXIO;
> +
> +	avail = hb->nr_ide_streams -
> +		bitmap_weight(hb->ide_stream_ids, PCI_IDE_SEL_CTL_ID_MAX + 1);
> +	return sysfs_emit(buf, "%d\n", avail);
> +}
> +static DEVICE_ATTR_RO(available_secure_streams);
> +
> +static struct attribute *pci_ide_attrs[] = {
> +	&dev_attr_available_secure_streams.attr,
> +	NULL,
> +};
> +
> +static umode_t pci_ide_attr_visible(struct kobject *kobj, struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct pci_host_bridge *hb = to_pci_host_bridge(dev);
> +
> +	if (a == &dev_attr_available_secure_streams.attr)
> +		if (hb->nr_ide_streams < 0)
> +			return 0;
> +
> +	return a->mode;
> +}
> +
> +struct attribute_group pci_ide_attr_group = {
> +	.attrs = pci_ide_attrs,
> +	.is_visible = pci_ide_attr_visible,
> +};
> +
> +void pci_set_nr_ide_streams(struct pci_host_bridge *hb, int nr)
> +{
> +	hb->nr_ide_streams = nr;
> +	sysfs_update_group(&hb->dev.kobj, &pci_ide_attr_group);
> +}
> +EXPORT_SYMBOL_NS_GPL(pci_set_nr_ide_streams, PCI_IDE);


PCI_IDE needs quotes but somehow it was compiling for months until I 
rebased onto v6.14. Hm. Also probably all exports should be PCI_IDE NS, 
or none. Thanks,


> +
>   void pci_init_host_bridge_ide(struct pci_host_bridge *hb)
>   {
> +	hb->nr_ide_streams = -1;
>   	hb->ide_stream_res =
>   		DEFINE_RES_MEM_NAMED(0, 0, "IDE Address Association");
>   }
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index b267fabfd542..76f18b07e081 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -466,11 +466,14 @@ static inline void pci_npem_remove(struct pci_dev *dev) { }
>   #ifdef CONFIG_PCI_IDE
>   void pci_ide_init(struct pci_dev *dev);
>   void pci_init_host_bridge_ide(struct pci_host_bridge *bridge);
> +extern struct attribute_group pci_ide_attr_group;
> +#define PCI_IDE_ATTR_GROUP (&pci_ide_attr_group)
>   #else
>   static inline void pci_ide_init(struct pci_dev *dev) { }
>   static inline void pci_init_host_bridge_ide(struct pci_host_bridge *bridge)
>   {
>   }
> +#define PCI_IDE_ATTR_GROUP NULL
>   #endif
>   
>   #ifdef CONFIG_PCI_TSM
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 667faa18ced2..a85ad3b28028 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -589,6 +589,16 @@ static void pci_release_host_bridge_dev(struct device *dev)
>   	kfree(bridge);
>   }
>   
> +static const struct attribute_group *pci_host_bridge_groups[] = {
> +	PCI_IDE_ATTR_GROUP,
> +	NULL,
> +};
> +
> +static const struct device_type pci_host_bridge_type = {
> +	.groups = pci_host_bridge_groups,
> +	.release = pci_release_host_bridge_dev,
> +};
> +
>   static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>   {
>   	INIT_LIST_HEAD(&bridge->windows);
> @@ -622,7 +632,6 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
>   		return NULL;
>   
>   	pci_init_host_bridge(bridge);
> -	bridge->dev.release = pci_release_host_bridge_dev;
>   
>   	return bridge;
>   }
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 5d9fc498bc70..eae3d11710db 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -604,6 +604,7 @@ struct pci_host_bridge {
>   #ifdef CONFIG_PCI_IDE			/* track IDE stream id allocation */
>   	DECLARE_BITMAP(ide_stream_ids, PCI_IDE_SEL_CTL_ID_MAX + 1);
>   	struct resource ide_stream_res; /* track ide stream address association */
> +	int nr_ide_streams;
>   #endif
>   	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
>   	int (*map_irq)(const struct pci_dev *, u8, u8);
> @@ -654,6 +655,14 @@ void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
>   				 void (*release_fn)(struct pci_host_bridge *),
>   				 void *release_data);
>   
> +#ifdef CONFIG_PCI_IDE
> +void pci_set_nr_ide_streams(struct pci_host_bridge *hb, int nr);
> +#else
> +static inline void pci_set_nr_ide_streams(struct pci_host_bridge *hb, int nr)
> +{
> +}
> +#endif
> +
>   int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge);
>   
>   #define PCI_REGION_FLAG_MASK	0x0fU	/* These bits of resource flags tell us the PCI region flags */
> 

-- 
Alexey


