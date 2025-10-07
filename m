Return-Path: <linux-pci+bounces-37651-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EA0BC09D3
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 10:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B35C189EB9F
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 08:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1569C2D3228;
	Tue,  7 Oct 2025 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m2G6q8eD"
X-Original-To: linux-pci@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013069.outbound.protection.outlook.com [40.93.196.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D012D29DB
	for <linux-pci@vger.kernel.org>; Tue,  7 Oct 2025 08:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759825477; cv=fail; b=Y/61ROkRzVhsuGu1w0DK1wAZwH1mtjwYEs2YoP/xPpdBO1ytfmrkp9CHoRVQyM4nG1Kg4nlbjbpBKxUHXxtLC9DHyo7wH4LR6WjhHNvNzwffCWyeyWXdOSHB33fgWRjmQNEBr8ip+ymwX0tG5W7dvJGk4HhqAOlyGVABFjCorOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759825477; c=relaxed/simple;
	bh=cnSGHfwgjBDv+ZMfyYFqLHu4WiTVzRuNr6LU8j5IbKk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ge5RUcwWEdC6wvld0YQfqI+0cJztzlL+DPgbenNZg9J9NmPh01PoRNhx9jwFaIoAKGdttV+MnueIhSAmIpDID6fspw4SHEsJBBwi50GRyw0tPjarpDJMJksytensbN9zF0/ELjvb1zQc3kwUBqQf3BHROyY8ScxaUOTWIsRjLak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m2G6q8eD; arc=fail smtp.client-ip=40.93.196.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFXR8msoqYufiyt1lU9Y0om+VhoFoOzog/DkgyhaESQ+uIXKVyCR2rJIetZeRQEAM0i/qGbmTfH81trzz4aqww45jlBghe5XKOcMX2uUEDkfxaCmw+c5dc1AXUGrHh85FMw2nKwsc0UZV1p1zZdEQtHpAT/As6OQmrPte3YWmfBjaPLIYEhK5U6BNrE+LA4IeCQc6NHvm7ljUwD2gzKLrlsU+eEVAhSVqcuEIDLFfLksxSrMmLpgjGObSkGojR6Ot9CMqOxOcj7TOAhPBcSGdyors+bXFFPhqlNMkz8Ls3BH2KLDYhSbC/aq2og0SJDBvdv1Eb7oa9Fakj7IJ2Hlyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDNUrJ8el0aBtPHW81usaeHJG9C25k+yxVQ8WHq6uz4=;
 b=Im1okh/v04mUrgEarpINeMNreaiW0wc2kzqx5a7KQfRKTEw/uh2fC60LCzzz/039cGvSuHBAQd5p8VSBjI48/tzxMdiSS/bA0y9t09ylq4CR+KrmZQfpflqqKZMxSoACX9pGyVeuscKufH4l9CD6SLcubd5OMPJIH0BQcqhZrx2wQHgkhLg+Iqo2UxL+PPbhRSXKNPnAtaaTz6mwadULi8fHyiAdauPJJoboED2hb+qg/k9PGIQAGdDKBfBW0at8gjHSNHdO5sx9lfZHBSQU91ePIWMohi0LxuVJDTxMPMSrDcm5MWyzYzrMx3IQsaxoYXyGETgjZM4mvcIyNI01aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDNUrJ8el0aBtPHW81usaeHJG9C25k+yxVQ8WHq6uz4=;
 b=m2G6q8eDtf3i6CPRY5Qwd7vKWU9oPbyTW8aFHP2ENmguh57QV/MT3z3gmiUP0Vz1as9/ib060GBoOK6eO7iT55En5jXuoEazPlgrbdITtqPq4JEyMsKdv3uhJ6wCYbHWtgjdLsKSujjljkoMdQOW57LL5Kf1Lr9tc9nMa8I45fk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 08:24:25 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee%6]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 08:24:24 +0000
Message-ID: <f6d07595-0009-447f-b694-605625c04b8f@amd.com>
Date: Tue, 7 Oct 2025 19:23:12 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 4/7] x86/ioremap, resource: Introduce IORES_DESC_ENCRYPTED
 for encrypted PCI MMIO
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bhelgaas@google.com,
 yilun.xu@linux.intel.com, aneesh.kumar@kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-5-dan.j.williams@intel.com>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20250827035259.1356758-5-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5PR01CA0045.ausprd01.prod.outlook.com
 (2603:10c6:10:1f8::15) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DM6PR12MB4283:EE_
X-MS-Office365-Filtering-Correlation-Id: 786d19f4-267c-45ff-615c-08de057aec79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEpSWXBHMkcybjQ5Z1V5RG9ocVhicWlhcW9BSXF1OVpjQ3hYdEFSZkM5VEh6?=
 =?utf-8?B?ZTA0c3BKQXVLeHBnQmZlemRHRG1tTWVVNWlVSkFXMExDZmo5MFg3cVQ3S3RC?=
 =?utf-8?B?U0JnYXNqemc5OGNyTVBQMEFhRFpwM2lURXpHNHU4ZGd2elZmcEdMMEMxUDV4?=
 =?utf-8?B?WEJYL1dXN2dIRk5SODdyNFpxNnlHVmdTVG1RYVdwL1BZYk9WRUFKdDZXbGUw?=
 =?utf-8?B?RU82NEN2RlZVNWNRZ3JsVUU3R0UwVGJwNFU3VTJnSjAyejhFZ2pCajc1Y004?=
 =?utf-8?B?aTA4SGhQbjQxcXJ4MkpRWWdJcURMUit0L0RlR0xyVmwzRWJtNFptMysvdm16?=
 =?utf-8?B?N3NvbnNjSitoZ2FyaVFrV2JUam1yY25hTXhnQ0xoUEVDYVdaMklvdVRNb0Mv?=
 =?utf-8?B?aXZoN2RLMTVFT2c0WmtvL1NLSG43dkFxK1A2amJ0WjVibERmZXdXU29XWEFZ?=
 =?utf-8?B?YjJCQndIdkVmZHdjTG9KMFYySFVFNFVQYi91Qk9jRlpXcVFUQ1JIbFFKMVF3?=
 =?utf-8?B?KzNSaUI0NThFYW5yOWdEL3hONldZYURGbHRyc042ZHlzajRWSjREelBTZjNX?=
 =?utf-8?B?Sm5TZC83Ukc4TU5UdzhCbDVxdlVWbm5QRmZlZXBGbUtoVlFmem45NzRwMmND?=
 =?utf-8?B?b2xvVnZVbnhGeWRYUUh5enpReTVSTG90OTZqdDFYYzhxUFNsem1XZXpFTnJE?=
 =?utf-8?B?aWY4RCtYNHNCamNTRExqSG1STXdleXV5ZDNrbjczWGJNMG4wWlhoZm1mSG1B?=
 =?utf-8?B?UC9wemR4M1pFSUgwcVhyMXVQNTNzeHc1Nm9MNEsva0VZMlJheVJQR0lvcFJC?=
 =?utf-8?B?SlRXTGdVVnpkN3VJcENvSkR2cllqUCtPYUt6MVdjdnFWSXI5dVlXR1lVK202?=
 =?utf-8?B?ekoxMFd5UmpkcTRra0NWYVBYejVJTFE0L3lxSEdPR2szZkNTQnBiSkZjeEFC?=
 =?utf-8?B?L1FxUHdsVU5Ec1R1cVh3QmJPQUlVMGlDZFBGMDNSYk45UDBzWXVXUUJXZlRt?=
 =?utf-8?B?Yk83dm5NUTVMSHE3TzV3SmFQNXp0WEVHWW1QZkJCQUo4ZUZVVkxQa0VkTTdW?=
 =?utf-8?B?QlVhcDNaWjVrakdTendrMVB3L1VlZDE4UDczaWlqZXZhb3RTYWUxRnlrbTF0?=
 =?utf-8?B?RDRoVXVjOVl4dU9TNENnd1NENXo4bW9HbVhyejhYZStsbUpKbGd5QUV3cHYx?=
 =?utf-8?B?TXpVM2o1WXIzNHo4L3hKNGVSK2xwSGVYOFR1R0JrSCtMaVhsd3k2UGdpVmVG?=
 =?utf-8?B?cEF6M09PdWlSemhmTkEyMWI1Rm1zY3lHNElIT0RTRjYyelE1T01tVlB0MERG?=
 =?utf-8?B?RzZkRkhoYWNTbXQ0U2lVNlNXakszSG5hM3FZc1NTbWxlcTV4dTdLZXdueUt1?=
 =?utf-8?B?WEsrV1dVODNjKzQ3UFpndWFBenpzUTFUVVE1OHdOSjVjaEsraVFDQm5WUlh0?=
 =?utf-8?B?czQzbktIZEsvdGJKNmh5SGt1UHhIeFRSWUtyVmlJVFhpNzlMOEkwYnJaTTV3?=
 =?utf-8?B?OGUvT2Jsa0g4ZTlXSUZGN2FkNThmNGV6N01FVUtLTXdiL3dQem5vRkwyNXRI?=
 =?utf-8?B?M0lCOVdNZzB3bDBSdVd2YlRnSnFWU2NSeXB1VG5IckZUUkYvZ2llRUpXcVRw?=
 =?utf-8?B?R09KMURzSCs3K3N1eFZEUU4vdHl5a0p3bzBnVHNQZ0ExVmRCODhhcHN0bUFq?=
 =?utf-8?B?UEM4MmYwSGErMi9XTExXMGZ0cGxadHdxM3U3K01BaHpoMFJXaVJvajBsam96?=
 =?utf-8?B?WTRKZGFrNnpFSzVnZmZVNHdEL1lZbnRpODc2V1hEY0ZwQlZFa0pPMXdDa205?=
 =?utf-8?B?eHhSMEZQYUhkWnJ0eTBUNFh6Rk1FWTAzOXZqMVlUZGZCcCt5VmlzY0tPTlFL?=
 =?utf-8?B?dDIwSDJ2VjFiV0xVQ3QyYVRrcFRCVnQzY1V0U1Q1QmJTWEtXVCszVzJwMmF5?=
 =?utf-8?Q?wsXBxXkE+dRtYjB20wTvCB28VL6jAijF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUJHenhSMzBGS3J6REV3bHh4OGR5MlJtcjhxWHhJZnFtVWNRK2dqblRHM2Qv?=
 =?utf-8?B?VFFKUEpVWGZLNTFWRDN3STRXcncyRFFsTXRidlc4MVdvNEJSR0xhQWsrZmdu?=
 =?utf-8?B?ckY3WWFtdHRNQ3BDUzZ5Si9KdWlpTWxjeW1XT1ZVS2c2RDYzUGI1SFhwbXpS?=
 =?utf-8?B?M0VRZnQ2bU9QSDVxR0VJcHlocGc1M1lQOGNSbmh6Z1V2cGRmcGJ1ekpzWHU4?=
 =?utf-8?B?aGVRYUQyVmd6OEw5bzFoNEZWeDdNaThrNkg3WlNWTXV6UzhzWGkyQkdKcWJP?=
 =?utf-8?B?SEJlY0oxakF3c3RmeVhVVThLa0tvUWI1d0ZEMmZBcVdkQlF0Yy9hV0ZjOU5M?=
 =?utf-8?B?WlM0bHAyVUJmY3NzTlBxMVMzZ2p1NENIQ3dqaEVwNEd4YTlGMjZvb2RvV1hi?=
 =?utf-8?B?N055WjdBUElqWUpaWGFMVCtYbUpWWDhvMjNFV1dVdDhLZzRGczlDVndyL2dG?=
 =?utf-8?B?L0pZQnM2MTJvbzdaVDZvWVZ2OGsyNjROUVlGYnlucnFaeklBanZ3SStaN2hN?=
 =?utf-8?B?N1k5Rnc4RDR1OElTZmJVY2VteTFUZTJPOGJlcVVSU2VMKzBYSTMxUWpta0Qy?=
 =?utf-8?B?YXBqVFVtUFc4c2dCanRycHFPWVVPaTJVVE9pTkIzYjkyZUFGYjdtbUJod0k4?=
 =?utf-8?B?d3hDUTRxRWVxdFRuQ054WkZKU04xOUE3QTg3Tmozbk1MV2dOQTB4ZlptODVF?=
 =?utf-8?B?Y1dmTGR5VlIydHkvTEhFeDVnOCsyUjFIeXlnT1NRK0hqS2l5cEd2a3BxVjR6?=
 =?utf-8?B?SUZXbTc3SzQyU1JRa2VoOUdTa0Z5QTZmd3JsYkR3MzFsVStVTnBWdHVraVJ3?=
 =?utf-8?B?MVllcDFZcWFQVVM5cG5JVjhTNVJYSElUWnVCZjVpZ1o1eGxzTTd6OVZHdmM3?=
 =?utf-8?B?WUVsQll3cE93TXFWbnNnSFNtOG9ScWQ4dFUrMWVSejlTUWNzSENTeVVRVllz?=
 =?utf-8?B?SXR2ZFRQaU05WVB3ekFLckE4ajdLWkxGZlRHRUhsVjllbFMzMmxtMENGUEdJ?=
 =?utf-8?B?TzBpbFVZMDh4T3dubnlrbHhwREhZcG5SSHlvZThackdHUmNtZGJVQVFEY0Jz?=
 =?utf-8?B?WnpGdDcybWo1VldOcGNwR1Q0WCt6Z0dvMmhCcXdvbEFyWjBwRHU3V2lxajNF?=
 =?utf-8?B?UTlVVklibzdaeGxEdGZkc3VFZmhJejFvOURHVEhROHZpajNVZ09yL1Z4SERB?=
 =?utf-8?B?S0piVjRLQVhQMmhadlJkQk4wNEZPOUxxM1hOb0oyMWZ3U2tnWW9mcWhaSzB5?=
 =?utf-8?B?VWxES1RvUGZVYWpHTU51OVV0Q2FENDBwcGlNeFpQYVhZM2MybHFaSE93ZzRH?=
 =?utf-8?B?N1d2T1FkalJuKzRSKzV3MFlMUDl5OE54RnhkSUpZWGJzS3U3VVltazN6dXJW?=
 =?utf-8?B?YzBNVVdRaU9oeGxqRnFzM2V6ZHdrQ0hoVjZwOC9zNjZadExUMUR4VXRHSzJk?=
 =?utf-8?B?RXVsRTdlNXBEcU1OckMzUE9CZi9CZjJMSnRnU3o0VDl4cURxU1k3S20zTE5I?=
 =?utf-8?B?alVpakJmTmhab0lVN3RCTFpWTFltcUQrQ2Z2K3k0OWd3T0Nvb1pnazFjVWJF?=
 =?utf-8?B?bHNNaGp4c3ZTNHNWSWpyTG03bklsTU00dkVUVjdBV3VGNzh5UXJ2L0d6WWM0?=
 =?utf-8?B?c09kLy94NVUvUmJBNTB0K1BKdDM3Q0MvdUU1RUxMYWJQdDhML0RKeEVoa2hi?=
 =?utf-8?B?bmN3N3g2aDFkZVhJMG51Q1YwYzQrMmxWem5aQkNGMlAzeUI1YWdMWkRYOFls?=
 =?utf-8?B?OTlXZXlwYTBrN0JmeHpRTEFncU8yd201OVFNVXFIYmRWTmkvTmJaZHB3OURH?=
 =?utf-8?B?bEwyY0RrZk9IOERYNkVDY3M2NDFLb2dmNlRrcjU2LzdUUVdGN3k4OS96d294?=
 =?utf-8?B?bWdXaVVoYi8vOXNQNjhUenpuaXNXanlHbTF2SmIraU9LSDJvTjlZOHV4WW9n?=
 =?utf-8?B?dHcwZzFqdElEVThUSEp0VExRdlZPOU1VRjFJcE9FOEFWVkU1MVVBV1pHM3Vm?=
 =?utf-8?B?bElpRExoSDVlR1ZXRExFY2R1RWdWYStNQ3pQZDhTWGJjcW5yNnd6Ui9TN0Jz?=
 =?utf-8?B?SmJHM1poajdEM2hGU1R4dU9pSUJJVUpOQTFhbTdjS3NOUVhuWEVXVWMydldK?=
 =?utf-8?Q?FI3f7XGjGn5A7cRhwxE/3n2k+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786d19f4-267c-45ff-615c-08de057aec79
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 08:24:24.8403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8We5YujAgEx/BCLCdWJQoVSV3/DhKoVXD+qYI6TXF4mcCd+MTYdxSz446EsPc0q9hlPNXYvEY4qGSVyzIAFSag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4283



On 27/8/25 13:52, Dan Williams wrote:
> PCIe Trusted Execution Environment Device Interface Security Protocol
> (TDISP) arranges for a PCI device to support encrypted MMIO. In support of
> that capability, ioremap() needs a mechanism to detect when a PCI device
> has been dynamically transitioned into this secure state and enforce
> encrypted MMIO mappings.
> 
> Teach ioremap() about a new IORES_DESC_ENCRYPTED type that supplements the
> existing PCI Memory Space (MMIO) BAR resources. The proposal is that a
> resource, "PCI MMIO Encrypted", with this description type is injected by
> the PCI/TSM core for each PCI device BAR that is to be protected.
> 
> Unlike the existing encryption determination which is "implied with a silent
> fallback to an unencrypted mapping", this indication is "explicit with an
> expectation that the request fails instead of fallback". IORES_MUST_ENCRYPT
> is added to manage this expectation.
> 
> Given that "PCI MMIO Encrypted" is an additional resource in the tree, the
> IORESOURCE_BUSY flag will only be set on a descendant/child of that
> resource. Adjust the resource tree walk to use walk_iomem_res_desc() and
> check all intersecting resources for the IORES_MUST_ENCRYPT determination.

How is this expected to work exactly?

samples/devsec/tsm.c calls pci_tsm_alloc_encrypted_resources() which essentially does:

*__res[i] = DEFINE_RES_NAMED_DESC(pci_resource_start(pdev, i),
                                   len, "PCI MMIO Encrypted",
                                   flags, IORES_DESC_ENCRYPTED);
                                                                
if (insert_resource(&iomem_resource, __res[i]) != 0) {
...

By later on pci_iomap(pdev, N, PAGE_SIZE) on that BAR maps as unencrypted. The resource makes it to (hacked) iomem:

c000000000-c7ffffffff : PCI Bus 0000:00 fl=200201 desc=0
   c000000000-c01fffffff : PCI Bus 0000:01 fl=102201 desc=0
     c000000000-c003ffffff : 0000:01:00.0 fl=14220c desc=0
       c000000000-c003ffffff : mydrv fl=80000200 desc=0
     c004000000-c004000fff : PCI MMIO Encrypted fl=14220c desc=a
       c004000000-c004000fff : 0000:01:00.0 fl=14220c desc=0
     c004001000-c004001fff : 0000:01:00.0 fl=14220c desc=0


and btw does not pci_resource_n(pdev, i) make more sense as a parent in insert_resource().


> 
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   arch/x86/mm/ioremap.c  | 32 +++++++++++++++++++++-----------
>   include/linux/ioport.h |  2 ++
>   2 files changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 12c8180ca1ba..78b677dadfdc 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -93,18 +93,24 @@ static unsigned int __ioremap_check_ram(struct resource *res)
>    */
>   static unsigned int __ioremap_check_encrypted(struct resource *res)
>   {
> +	u32 flags = 0;
> +
> +	if (res->desc == IORES_DESC_ENCRYPTED)
> +		flags |= IORES_MUST_ENCRYPT;
> +
>   	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> -		return 0;
> +		return flags;
>   
>   	switch (res->desc) {
>   	case IORES_DESC_NONE:
>   	case IORES_DESC_RESERVED:
>   		break;
> +	case IORES_DESC_ENCRYPTED:
>   	default:
> -		return IORES_MAP_ENCRYPTED;
> +		flags |= IORES_MAP_ENCRYPTED;
>   	}
>   
> -	return 0;
> +	return flags;
>   }
>   
>   /*
> @@ -134,14 +140,10 @@ static int __ioremap_collect_map_flags(struct resource *res, void *arg)
>   {
>   	struct ioremap_desc *desc = arg;
>   
> -	if (!(desc->flags & IORES_MAP_SYSTEM_RAM))
> -		desc->flags |= __ioremap_check_ram(res);
> -
> -	if (!(desc->flags & IORES_MAP_ENCRYPTED))
> -		desc->flags |= __ioremap_check_encrypted(res);
> +	desc->flags |= __ioremap_check_ram(res);
> +	desc->flags |= __ioremap_check_encrypted(res);


Here the found "res" is actually "c000000000-c7ffffffff : PCI Bus 0000:00", not c004000000 (from the above example)...

>   
> -	return ((desc->flags & (IORES_MAP_SYSTEM_RAM | IORES_MAP_ENCRYPTED)) ==
> -			       (IORES_MAP_SYSTEM_RAM | IORES_MAP_ENCRYPTED));
> +	return 0;
>   }
>   
>   /*
> @@ -161,7 +163,8 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
>   	end = start + size - 1;
>   	memset(desc, 0, sizeof(struct ioremap_desc));
>   
> -	walk_mem_res(start, end, desc, __ioremap_collect_map_flags);
> +	walk_iomem_res_desc(IORES_DESC_NONE, IORESOURCE_MEM, start, end, desc,
> +			    __ioremap_collect_map_flags);


... which seems to be the result of passing IORES_DESC_NONE. What do I miss? Thanks,


>   
>   	__ioremap_check_other(addr, desc);
>   }
> @@ -209,6 +212,13 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
>   
>   	__ioremap_check_mem(phys_addr, size, &io_desc);
>   
> +	if ((io_desc.flags & IORES_MUST_ENCRYPT) &&
> +	    !(io_desc.flags & IORES_MAP_ENCRYPTED)) {
> +		pr_err("ioremap: encrypted mapping unavailable for %pa - %pa\n",
> +		       &phys_addr, &last_addr);
> +		return NULL;
> +	}
> +
>   	/*
>   	 * Don't allow anybody to remap normal RAM that we're using..
>   	 */
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index e8b2d6aa4013..b46e42bcafe3 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -143,6 +143,7 @@ enum {
>   	IORES_DESC_RESERVED			= 7,
>   	IORES_DESC_SOFT_RESERVED		= 8,
>   	IORES_DESC_CXL				= 9,
> +	IORES_DESC_ENCRYPTED			= 10,
>   };
>   
>   /*
> @@ -151,6 +152,7 @@ enum {
>   enum {
>   	IORES_MAP_SYSTEM_RAM		= BIT(0),
>   	IORES_MAP_ENCRYPTED		= BIT(1),
> +	IORES_MUST_ENCRYPT		= BIT(2), /* disable transparent fallback */
>   };
>   
>   /* helpers to define resources */

-- 
Alexey


