Return-Path: <linux-pci+bounces-16928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99019CF4E4
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 20:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7254289DEB
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 19:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82B11D5146;
	Fri, 15 Nov 2024 19:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WVMAhXAo"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91E813D297;
	Fri, 15 Nov 2024 19:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699217; cv=fail; b=PO0TSS7gqirTIYIrM/R9m/FSsvZRjAMskM2kXLH0vq6x12uv4h99OsorCRAIZShVK4y1FKkH+vdjPfkHRWvokKbp7DO2I4K3szs5+3NF1M4QVOeR5ugHCFxZeet4Up2fe0gzJrHIym6pQwsH6BdrjTyTfhmd16YLZTCU0s46pEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699217; c=relaxed/simple;
	bh=eag+PddWfDyZto7eki+kbPHUdwcouxF08JMtjvLpaec=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iaAb2ab9ityruimY1aKtwFAi8hKUfgG6dgCWg13HtyXpbo/w8i/DBo00o1sQo96EK8ePwElQfIYMZL3enekgxA2vLuSzm4S6r0G981zKAYtHoUFiIDnRS/28zEX4zsxSQ2eHoOkoQmsdaaTd6biaSjcFGo/n2NcfMhyodtnbO+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WVMAhXAo; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0od030tqLwhqXpNuuPIggQf1B8CpBPo/Up6UTSatKcYFZtHKiNehaYsX4+LQOtUqNE3zxIMGlby6zsS5GSAyNdEXAA7It/7UjnDYPSFTWNq6f5R/BNB6S892kvR/bAid3MDIE1uzwQ8Zpr2xMWCQzOUYBJsrU5tFTqaPgtQVz9bOKvGP6WAC+FvbgPriT3j4AGNyFKlMMqAWPwaidjPz1yGa6Sbz6UOOHY+q+CIo0xizT+3uPqVLgEwlWk56YP2bBxZ/oVn6B5S8YFEaUGbBHwtZH7QFCzlWb0nQ5+Hjv7BmySaQJm7n0hcwIrdnbc4fKwzZwWoFIr74zXklRoNbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCDHhZlokSo/tK0JqX794sFOgwDaBOu7MzF2Vxv/uQo=;
 b=Oyz5VOTwxAJtSjjVGLmQAI4o7SDEtV1IYIeREwLdl/kZgllZr1F7jKw0SmlANY8k7FauGTyd0RJpCUY4oM9LX62QLRW0V+7c4YhdOLReFbiv9gdm7kemTNKiZwscCadbRn/ahx/xP7/Ynh7MNjDEPKj7HEQoKWTb/zNHVrfl2TYOseORwSaN7ojxs98rGO8p8dT7aRj7TsHJ8Tw9eTy4MSJzddTVhVFLTtxJVdugJ5dtPnZ1jFLoa/Z+NxSn1eXAhBuC24jg7pgAMKmttA3BO2nD2rN9xRA4mvfqj9rydznuRSUkUO2+jrjtkaBC7xkpze+vV/gCetR6CwVJp7umbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCDHhZlokSo/tK0JqX794sFOgwDaBOu7MzF2Vxv/uQo=;
 b=WVMAhXAol/XnRk5nBhDEpvIFikMw/Z40G+WYWtdmmUFW2hDpMl4xrQVZcr7IGx5zsk/mSXEAM1W86PKsSBhtTA3bHTtdPIBgGhNqJ/7+U2BO7jNvqKymifasuV04jG+OsDmMx+FbdQHhQvWSgyzaP20sZyDwglHFwoQ/k+PeX8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH7PR12MB7185.namprd12.prod.outlook.com (2603:10b6:510:201::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Fri, 15 Nov
 2024 19:33:29 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 19:33:28 +0000
Message-ID: <33ba3ef6-6dde-4425-9965-73e40d07d4d7@amd.com>
Date: Fri, 15 Nov 2024 13:33:25 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/15] cxl/pci: Map CXL PCIe root port and downstream
 switch port RAS registers
To: Li Ming <ming4.li@outlook.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, ming4.li@intel.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de
References: <20241113215429.3177981-1-terry.bowman@amd.com>
 <20241113215429.3177981-9-terry.bowman@amd.com>
 <VI1PR10MB2016F4C71BB315D61076ECD7CE242@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <VI1PR10MB2016F4C71BB315D61076ECD7CE242@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0030.namprd12.prod.outlook.com
 (2603:10b6:806:6f::35) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH7PR12MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cbf335d-9e9f-45f3-6dc6-08dd05ac6181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzFxYVAwbTJoUENTazFiSFRqYWJVN3dRbkV6eGMxU091Y1JyckMwMGwyVWoy?=
 =?utf-8?B?YUlVZ2hJeFlwdHVIUU9XNi9DTFdmYjJhbWhtU3l4NEk2Q3ZaeHd4Lzh2azFi?=
 =?utf-8?B?NDBYLzFER0UxM1hVMUd6YmJ0eE4vb2lSRUxNY3N4Rm9mYm1pSWMxTWdyVzZY?=
 =?utf-8?B?eXVQcmxBaFdBUlJWenM5QXp6Z0tWclZlQy9LU3F4WkRtbHlMeVFxMzE5c3Nk?=
 =?utf-8?B?bXhDQkxLdG9MNXBJMjJrME5HMW90VC90VXdpZFczSWUwT2dWQ3BlS2srNCtn?=
 =?utf-8?B?ZUx5NFB4YXNUZ0xaTHVDNmVRZ0dKbnF6YlhCMTFtRjBDR200anhyZW5PRnJr?=
 =?utf-8?B?RGo3RnAzYkRMRkx5bkgyNUUwblB4VTg2VmFNRXBCcnFQUGhlKzdiZUxGMjh2?=
 =?utf-8?B?RkNCZVhxdHVJUDZBRmJvM01xazg0L2lmemx4VFJsRmpMeGZOaWZENThUZ1Nq?=
 =?utf-8?B?MXlQbC9PMVJBUjBsTDN6TVpiVXFnQXdialJZOG9wSlJIbmdoeVNXampoVEtD?=
 =?utf-8?B?RlBQMmJRUCtBTWZzVHd2SkVpWXFQeFpBc2RndFpaWVEveEVLNDh0QlFUNjls?=
 =?utf-8?B?N3YrdHd1bEFXQkhzUVVBT2NCbVNQTzNBdHFRS1JnUGloWlNQbndmNmEvb1ZC?=
 =?utf-8?B?c1FYakFLemQxMzRMVzgyN3A0WXdVZmNHSGFSdnVVR3NieUM4YldEYjNCd1ln?=
 =?utf-8?B?YUtIbDVNeWhMeVJBZUR1ZmVsaDNMRjN0TTFBNGFMdmF2bVdrbkkrdmtZL2lE?=
 =?utf-8?B?ZDhzd1lKV1JKYWIzTk5ZaDNYandib2FlZjF2MFlOZE0yVFZoWUJycXlWTGtM?=
 =?utf-8?B?UkxDN056QVZhemxTYldoSC9veHBPUGM2dW9DOGxUa3IxNlo1STNGRWhaVW4x?=
 =?utf-8?B?ZjN2UDBGZis3OWc0Qm13YmxZR3lyYTV2VlY0T0IxVEZJWnBQaEFBbjdoU2ZH?=
 =?utf-8?B?TWFCb245Zm9IQ3lKdFlNNnpHZ0V5cWFIcDdjZmZVby9EcHlHa0toL2pkQzZO?=
 =?utf-8?B?ejZyeC9PZ3ljdy9SYnZyMHk3MUowWTYwZ01lU3pRN1hJWE9ONmVZTnNVUXZN?=
 =?utf-8?B?QzNvOGdmeThldDBKeU5mNE12bUc4V1IxbXMrbWZTRDFQOGZ1Y016d3hwUy8w?=
 =?utf-8?B?M01KYzlEMEFmWVdINmlNcEVWNWhQdGJkQTVoSUx0eVhrYW12ZjVPdlBCOTRE?=
 =?utf-8?B?N25jcWl0cU1WbTVYRmNERVlabXB3T2VZc3oyQ3Q2WTVTWHk2U2YwZlM2QjlN?=
 =?utf-8?B?Y29FZmphc0RXYUYwQTlVZ0lITUpOV2h0R2dRbmlSMFNjaDJPanVHay90Wnhl?=
 =?utf-8?B?MEZXWjBiZ2ZmZDU1ZVEvYWd3MkJyZ295SnVPcXVUUHI0citPKzF4dE8xbDhn?=
 =?utf-8?B?UWtBS1hQa2hSQ2xjajJyNThFL0NMbm13UmZncVo4NnFKcENKWWJ6ZW5XR3pj?=
 =?utf-8?B?MDg0RGlpNDlzWlVESElLRXhYQWg3WXZkbGxqUFN1a1NVcTBhaDJrQkxqQSts?=
 =?utf-8?B?MlFTTEcrRUtzWFVYMnozWmhlY2FSVWVLT2VrM0xzdVZ3UG5jdjM2VXJpLzRZ?=
 =?utf-8?B?d1VMcW44Mklldmp5SXRlZjhPTkdQdXR2elRoQXpjZWRGR1RZZyt3MTBXRDN4?=
 =?utf-8?B?d3ptODRNTStyN1lDNE9mbWVjZ1FqQlpOWEovYVViVzNKbXErQWMvcUx3VmRU?=
 =?utf-8?B?bkN4QnFlODc0NnNLb0hEWGlhenpMTFRHRnJWSm56cnBTdFVFUTNSZXQ5THho?=
 =?utf-8?B?U1BEcG4yS1BEZW9iNFZyRzNDSldhb2NLeVU3ckJodldzOHRFVUVFRFFwUEN5?=
 =?utf-8?Q?yRCRdQf9VMUr7V9kCefbpGjwtIkXywQc12/Gk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUZKc2htQ3hUTUFLaFN5OFZtVnl5V3ljY1hweU1lSXl4ZC9LWG1OVWkxNDlr?=
 =?utf-8?B?dnRiOGUrcHpWa2hvL0FFTzg3S0pBMlNxd3I2UVQ2dXVxZ0ZrbE1yYlBxRHNm?=
 =?utf-8?B?elFTdVRURkNoNi96S0lSSGduWnpkRzZRRitpZjVoUVFjSzhNamZud2Rycm9V?=
 =?utf-8?B?ekRxMENLTm9SNncvaDBsakJiUUFpYTZodDJzOHkyZksxUytGOWhORVNxVWNU?=
 =?utf-8?B?YkM1NkFlMFFPdHJEdkNmYkwxZmpaYXdsN3Y2Q3BoaFRGcDJEZ3liT2p3a20y?=
 =?utf-8?B?UEc3QXQ2N1lzTWJqUVlSNDgxVyt3OU9ob0hXaTdaeE9kdFdiQStVUGg2VlJy?=
 =?utf-8?B?ZEYvdU4yTlIyYTdsemo5SVU5cHpsbHRGc0xVSnN3MU1LNWJmMDhRRTFXcFUx?=
 =?utf-8?B?bHQwNHp1UkxFUlNBaFp4NUpvdlorMXVxRVBSclpGbDNkZUZmYmU0YlVvQmZH?=
 =?utf-8?B?UVpJYWZMVEZ2ay9WbXFNUmNpRmF5NEI1SFJUUmRiMENLaktKRWg0K0NXalFu?=
 =?utf-8?B?NHdOMjJjNEUrTGltNUdtaHA0REcyVVVxVE56aXdiNVgwT3RqbmRVa1BZczFH?=
 =?utf-8?B?dDkvSDY4NWRNMW5wcmNLNWdjeHNhdUlqOE8zL1RMTlNyOFhHbnhGRmNDTklT?=
 =?utf-8?B?ckFvaDE3L1NORTVRbkI4SDhLUnZjRzBWczNYRG9UTXNOdG5MNkVsSFRidnd2?=
 =?utf-8?B?MkZrQzYvUDNqZzlFa293Ni92ZVlCTWpSMkVGUDltbWIzdVlLS29Bc0doc3F0?=
 =?utf-8?B?Y1daN3IvWFYxei8vRVFlbWdmaHVHQzU2K2k5dHcvRCtoQTF1RXh2VmFyT2xx?=
 =?utf-8?B?ZVpqSDN6c0c2MWk1V2ZEK0NRRTU1NXlXNWc1ZmMyRFJxSG0wRHlleTVMSFZE?=
 =?utf-8?B?V3VUdFU0YXp4dkZ2alNhaFh2Z2JxZllUeU8rNWZsZmVXV3ZHWlQrb1dkdGx4?=
 =?utf-8?B?YUplY2JzZGJRK3pTZytJenZnT3g3YkIwNFRxMlJodXphSUt2Zzk0eGQwdDFR?=
 =?utf-8?B?ajZPbURVbnZTWHB3QTA3dEdNZnhoWTRFVkk5WERmTi9lb3ROcDd3NFhtd2lP?=
 =?utf-8?B?YnpYV0x3R29SNW5BVWVrSDJweG5lSGFUU0xFYk5Ob2R3OUFaTy8wN2lhSmg3?=
 =?utf-8?B?U0RrYmVMbGp6ZGsweHB3TWtqZEZScWppd3BhdldoNXpQVFRmclFxcEEwYlZE?=
 =?utf-8?B?THFjRDBrbmtTVm4xdnZhRTBkblRDQlZZbVR4TTJkN09IL25XZnJYcnorNEFt?=
 =?utf-8?B?YVFVbHNWWGdkc0pVVHhLc1F4QmN1cFpGeWtRVTBacTNGNTI1SGxxQUxYeWt6?=
 =?utf-8?B?ZEo2Zk1aOFpiRGM5NGkzLzJoeHRFS3E3U0xTd3RzYkhCNWRWVW9IRGtkQmpS?=
 =?utf-8?B?OWJqc3dEVC92cXQwOER1WWFzSFdOUWRFL2hsVEFnc013VFB4ejBRQnE5Y2Jt?=
 =?utf-8?B?NWdRaGk4QjVuOE1QdFpoWEJCMzJnZlJZMStHWGwyRVJ3NUhpWWk1ZXhlcmJM?=
 =?utf-8?B?NVNWTWZrUndLT2ZQVDIxbmlGNDVMQk4wbTJ1VnNTeWZwN05pZHJRSnBydGEv?=
 =?utf-8?B?ellmVVlRKzZ1NUpTa1hCOXl1NzgvdlNrdTEvVWNQQmc0Qmg4UUFHNmdXWnZP?=
 =?utf-8?B?ZmxBUlQ4WFhOcm5hc05jTUZLa3l6VmlFS28yb2YwZkNPL1hjVjVVVXJQQmYy?=
 =?utf-8?B?NHplVElucWNYLzY5NzZZdXJDK0hGdVNSODlLeFJDVUcrSTV6eCt6UTZWbitx?=
 =?utf-8?B?K2JQb3B1S1lGeGpObmZxNGdSTXpZa2loWWNOM0MvWlVRdm44YitPSkV0cGFn?=
 =?utf-8?B?TG0vQ05pakU4UTd1QXdia0U5Ukh5eDdYZ3Z6U2Zvc0Z5RFhQVm1FeWs4ZER4?=
 =?utf-8?B?ajJyMnBuWjZuRU1kYlZUR1lQM1lVL1YwdGQrQWRqTXB2RENYL2RZUXNhd0I1?=
 =?utf-8?B?SjJ3a2FHWmVlU1J4S2FIV3REMHlWcUw0eUtJaDBOZ2dZem5oZ3VYdWJhaFk2?=
 =?utf-8?B?OVpoYVhENU5nNHJjYjFmL1E0WjJtZ2QrTlhJZTJiTXo4WE9DbHczQkJjZGsr?=
 =?utf-8?B?UjF0K0wvTUNjTlhrclorY0tUNTdSVy9TUkdvUDh5bGRqOFhoOEs3YWJLZUVC?=
 =?utf-8?Q?/bq0m7kh19nViEwChEe2eH+sg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbf335d-9e9f-45f3-6dc6-08dd05ac6181
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 19:33:28.6725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ggTmhSJdBl1KBF7jovN9YCoiZpsMBwieZdCJ4xORl4R4+SYv3M2YHZ6e9q8J69pDvKJxKSjjq3636xbE2bdp9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7185



On 11/15/2024 9:28 AM, Li Ming wrote:
>
> On 2024/11/14 5:54, Terry Bowman wrote:
>> The CXL mem driver (cxl_mem) currently maps and caches a pointer to RAS
>> registers for the endpoint's root port. The same needs to be done for
>> each of the CXL downstream switch ports and CXL root ports found between
>> the endpoint and CXL host bridge.
>>
>> Introduce cxl_init_ep_ports_aer() to be called for each port in the
>> sub-topology between the endpoint and the CXL host bridge. This function
>> will determine if there are CXL downstream switch ports or CXL root ports
>> associated with this port. The same check will be added in the future for
>> upstream switch ports.
>>
>> Move the RAS register map logic from cxl_dport_map_ras() into
>> cxl_dport_init_ras_reporting(). This eliminates the need for the helper
>> function, cxl_dport_map_ras().
>>
>> cxl_init_ep_ports_aer() calls cxl_dport_init_ras_reporting() to map
>> the RAS registers for CXL downstream switch ports and CXL root ports.
>>
>> cxl_dport_init_ras_reporting() must check for previously mapped registers
>> before mapping. This is necessary because endpoints under a CXL switch
>> may share CXL downstream switch ports or CXL root ports. Ensure the port
>> registers are only mapped once.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> [snip]
>
>> +static bool dev_is_cxl_pci(struct device *dev, u32 pcie_type)
>> +{
>> +	struct pci_dev *pdev;
>> +
>> +	if (!dev || !dev_is_pci(dev))
>> +		return false;
>> +
>> +	pdev = to_pci_dev(dev);
>> +
>> +	return (pci_pcie_type(pdev) == pcie_type);
>> +}
>> +
>> +static void cxl_init_ep_ports_aer(struct cxl_ep *ep)
>> +{
>> +	struct cxl_dport *dport = ep->dport;
>> +
>> +	if (dport) {
>> +		struct device *dport_dev = dport->dport_dev;
>> +
>> +		if (dev_is_cxl_pci(dport_dev, PCI_EXP_TYPE_DOWNSTREAM) ||
>> +		    dev_is_cxl_pci(dport_dev, PCI_EXP_TYPE_ROOT_PORT))
>> +			cxl_dport_init_ras_reporting(dport);
> I think cxl_dport_init_ras_reporting() is needed for both VH case and 
> RCH case. My understanding is that dport_dev could not be a DSP nor a RP 
> in RCH case.
>
> Ming

Good point. I'll look into that. Thanks Ming!

Regards,
Terry


