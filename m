Return-Path: <linux-pci+bounces-21313-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BC1A331BD
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 22:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F08167C3D
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 21:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFA9201270;
	Wed, 12 Feb 2025 21:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q83duBVb"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602CB1FFC6B;
	Wed, 12 Feb 2025 21:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739397185; cv=fail; b=l0Eg8qERysomh/deYDbwxVJTdCngjPDqseTy3gbSAyix7aPjthtgTu7OCs9bu3c4a59X3bSRVW9vZa/X/wQNQJPKoE16iNkfFZFxmy7Fshy6worAJkCWKpm5zS0ChgsuCFJeVxJVJ24vpb8iIHyQOfch7cle5sDs8hpcygBY1SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739397185; c=relaxed/simple;
	bh=Lgl/wqlwJrr10NfoijX+ID8Vpk8NftBO6DCimQpD0Mk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c5N2yT9tRI/VPp4jpAzOKugDldsFiZ2fYl7936xlzUe4DY9XJjnZa0vBC3UQ4AnX7dyrvFski8cr51T92zYdP4J7Bx+YJQ2JMEmahAVA8t33pxlClMz3Cki2P9AkbiO3jwfMtAtcsfvxL7lzLd97Qn4rCTl7A+IiKGhZf7Qz9PQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q83duBVb; arc=fail smtp.client-ip=40.107.96.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WW3OeA4eJrE7MldR3wjjAwtIPkWck7OzxCnhWbVUvM486qQ2268iRiA39WWPU6+ZQ9gQ4dLU8WiUm8O8zuDSgZ6ALItngC+OL4ICs7OEmEu4NPCxwSOazcoYDZgpAtb1nHn8t6sSiNVL41fwWL7LNgUYZTUY/H/yDcvJcW67OrxAObFNx+Z/99wIV44GQpPAgDUcnqj1lREPvSdEdl9M4Tk9v1XlFNLx8GNLg9a7S2Bol2lABlBQLoTohVQe+Zt3FCwd/KCvIt3AUR6DHh4HbxNK0U/Xu449Wo1fwKHxvSli5Q168OuTDDJXMI0xoLOs/nnfH74zChpbLQtybLa0CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAXu/d5XosrabzpdkkPa6qi7pYX2xdygFFVUgG3mU34=;
 b=DAyFnYjmcTyKcHs0Gix0LvjOpVdVVSfgZ5T+HUCMNVAXOAJ4oMxpremJs3Wg4NurW2UjlgnxIZjA4rrZa68C6EmDIRt8xldh105zBwGX2eyBo9p356dE70emKS9Ob+euT13UORd+53BEtnZfdfcVjQly+fGyOTgLPafnkIZd/lwa9SZBK4YCP0G358hOWd2Iqe0Utg3v6brcU9IfbCf7mpJyZ9Ac3VQZzNSnH38F77yShVKZmAgMBJ+dvsEdua4K23nG5+tXPdH94Ug05x+R4kEZRTNL9Ac6jqYYp+6GUqERqSJG+EkjISu3HdWibEl6th0u2GMi3cBjYdswK8hZEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAXu/d5XosrabzpdkkPa6qi7pYX2xdygFFVUgG3mU34=;
 b=q83duBVbVxsYbKy/O8vfsjyfo1EogBpHA0N7HgMJ3ma3Wdsu84OFAzVsxZXo/M8KnkrAu7CZKC2HnLXbGUo4QxTG9miJl8x8nc2tb91WOcqaVTGx5vQo2red6m8Q6nit+htIkgwCii1h0Amr19R/aXw78y2M6TGM6lomzVsv0uU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 21:52:57 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8422.010; Wed, 12 Feb 2025
 21:52:57 +0000
Message-ID: <765352bb-a8fd-4968-9ce4-c4a17d071fed@amd.com>
Date: Wed, 12 Feb 2025 15:52:54 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/17] PCI/AER: Add CXL PCIe Port correctable error
 support in AER service driver
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 bhelgaas@google.com, mahesh@linux.ibm.com, ira.weiny@intel.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 lukas@wunner.de, ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-6-terry.bowman@amd.com>
 <67abe412e153e_2d1e29469@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <67abe412e153e_2d1e29469@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0088.namprd04.prod.outlook.com
 (2603:10b6:805:f2::29) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SJ2PR12MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: fcde327f-86e6-40df-4afd-08dd4baf9c83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czhhbkNYMUhHY3Eya2h6WENieStOK0tBcmhmT0R3Slo3Y2ZEbmg5RkV5Z0Rq?=
 =?utf-8?B?R0hRZHMrSDl6SkYyaTZTTlRaSHpLZGREODdxS0p1RmlPc3REcm5XS2hVQXo5?=
 =?utf-8?B?eEhEbXEyYmw4bkJGZHFRTGpqc1QzZHYwR3htM2tNTHZZQlBGcE8yTW9RcE9v?=
 =?utf-8?B?Q2xxb255RFZNTTkvV1FtckVmcms3VWRvdU5xVmhpZlYxdG5SMzkybnRMOGdT?=
 =?utf-8?B?dkZVVjdOeFRXVmZmTEkzVXlPRWlvdTFUTHV5cjZUTWkxUnU4cnlTZC9NOEVO?=
 =?utf-8?B?am5WMzdCSStuSWVxYkprU25xdE1iL1g4WUNXRFhEVWxaYml3TnN1KzNEeWZv?=
 =?utf-8?B?c0E0R2M2dFpXRGVvbDB6TndiY2E5WnhHdXkyMmlsZlRZb2txaHZhOTVKYlFJ?=
 =?utf-8?B?VUY0OWx3ZVZUNFA5alUvdkJpcVFyK3U2SG9PVFVSYzY0T1IwZGd5RGdrUmoz?=
 =?utf-8?B?WlZoM0daN3ZOOG82RlBvb1hDNEh6ZXpFK3lxY1VpRVZLUkhJUjZ1U1hvRlVE?=
 =?utf-8?B?S0JSV3VIV211STRqWDgxVmVCY1RHNXc3cmNrYkhqYk1ZeXhlVkYxeGREaWQv?=
 =?utf-8?B?VVc5bUt1WU00WkVRK1htVTdzaXFNTEtjN2xlVFZqRU55NE5od1c0encwQ29x?=
 =?utf-8?B?RElGYVNlb21jb2J6Rk51OGtHZEwzeU9IVTNYZzFNb2RlY0Q0VThIWjFYbXlB?=
 =?utf-8?B?bzVEekNJT1VJbHloUzM3VUFtUVg0WlZoS3VNRkpWVEN3eW92cGE3TGlYd0ZO?=
 =?utf-8?B?L3lkVkRrcmgvbjE2THk1dXJPWVNtYTl4ZEJONU82MWptYzFLcnRaSlBjRGFF?=
 =?utf-8?B?R0UzTjV5ZUxqR2tVcEdScGovVzgvQmxPb2xGaVpGM21BanczY3VpZkNkczMz?=
 =?utf-8?B?SkxoM3RCbnpyTGl4UVlpUGt5NW9VZFRNalpyQ3loSE9HL0liNTNGaEhNUXg4?=
 =?utf-8?B?eXdKaFhCaENFRVBaWUJKa01vbzBnRnR3NE5MWnIwWlhVZHNsUUlrYzlnblZQ?=
 =?utf-8?B?SVAxdFUxamJxQ1hhY0ltWStVMVZtNzFhWG5qUDFWNzd1SDVRYXJNLzBiYXNx?=
 =?utf-8?B?eXB2SnRRQ1hwa1NjWndFOU0yaEZyOTkvOTJlNTBydUtNb29Wci8xMmlTY3dZ?=
 =?utf-8?B?WTBXUmlhZGRHcUxtNm5qbXFMSlkvMVMzaThHUy9DMFJYQ2RxRlQ1QitkMDhj?=
 =?utf-8?B?M250d3R6WDh2ODBqb2wyRHdYdllqZmVUaTk2RVF3WnM3RW51U2plSG40NHcz?=
 =?utf-8?B?NUdxWHlJWnErUzJzS0hHSXIyUk94UjVXZUtyenF6aEduVFIxdmVOa21Rc1pB?=
 =?utf-8?B?WktvOEZ4d2dYSVlnS2c5UWo0dCtnTmFoSkpTaVR5ZVE1QWZrZTMvNXdzSFpB?=
 =?utf-8?B?QlJVWDdyOS9scE81bFZUR2dWVUlWTlVKZFZwZEpwMXViNi9LK2gyVlVnZ1RX?=
 =?utf-8?B?aU41UEFZc20wR0hrTk9oc0NiUG1teGF2NUNsN2w4UldUVFBnOENDempNUnJS?=
 =?utf-8?B?bHR0VHIxaFZiQzUvcTRFRG5BelVISEJoUGdIbDQzZ09SelF3V1hGRGk5eS9J?=
 =?utf-8?B?OC9ScTVpQ2lnamJUdzFQa1BnVytVZXFpNHpsMDBrMWZNSmp2YjNROWRYN2Yz?=
 =?utf-8?B?YmEzdUFUd1p0cWFKR1BHcGE0OWpEd2hWMzhEMEJ0YmtTK25sbHRmZC9NQU1L?=
 =?utf-8?B?YTR6UU1YME82MFQvaVNHZVFyWjY5aC81L01tMUZ0RHlMMU5VOU1VaGZ3a0tH?=
 =?utf-8?B?VFBGV3dKTUREWUM4YWdybXRQSUhnRVVWb1JIOVgxZi93MUFjMjVKaXZ0MGt4?=
 =?utf-8?B?NGFNN1M3R2pKQkhHUDNtOHpoRlNFUENHSFRKRnBHN3hFN1JUYm0yY0JFQURL?=
 =?utf-8?B?WkJtMlVqblk1bmRVbVZIOHU0dkdTMEJOQjdFcG5iRGduemtXTklnL1ZXMldo?=
 =?utf-8?Q?nWDP3YTVhPg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGR1eEVZVVk4c25tUlRlNnU3VFFZbUlDM3VXUmoxMFRVckJIMG1mZUdKV3Ni?=
 =?utf-8?B?bStoTXp5OTZyb1I5TlQwek5EbVVZdis5UE1RS1BDY2drcytCaTBVOTVIQUNw?=
 =?utf-8?B?MW9aRXRsWUlOakFNSHo3V3ZBQVNqVEp6RFlEU2xJb1p6SjJvdUQxUnFwaUZU?=
 =?utf-8?B?WHZKM0x0MnV5Kys2NzlsV3hwMWxMeUUwNFUwaCtIM29BSjZ2c0o0bGkyUVMw?=
 =?utf-8?B?VzRxRzA4NFVGbEJIMHhlVUFCbHJrampDMit5OE5UTVZ0ZFJpWk45Z0tlWlE5?=
 =?utf-8?B?czVYeGs4NU83QldOWnY5STNCY09YL1FWM0hvWW1XUHNERkZNVldFVlJwM1pZ?=
 =?utf-8?B?Y0ZRU25ENlFsV1htM3JWNEh2ODl1VnM5Lzk4bkp5VHdXeWtUcjRHZ3djMWxS?=
 =?utf-8?B?WVMya01CL2tjcnA0aGFmVEdQb2YxSkMyRmU0RHZHOFM3QnVLcUpacjluNE1q?=
 =?utf-8?B?RCtWVjFTT1l6aThHT29zbXY0WUFaTGdPeGFsOWZjMUxzU0Jta1FqMTltcVZH?=
 =?utf-8?B?MGFBZ2hDcGRxajFuQzU5dng4VW1NaWtyUnNCNHFrenF6R05obHIxLzZkZktX?=
 =?utf-8?B?SnEwU0hSU21MQkc1VGhXaGZoZHpvTHZndmRtVTZ3eGkweEtPNUNIL0g1Kzk4?=
 =?utf-8?B?WnJGUExHc0UwenVOYysrcE5hN0ZZTy9Lb3lHSkx3bzFhWVJtYnZvdDVLVkpF?=
 =?utf-8?B?WG9FSzQvNCtydEhITVlrZDBmdVpBM2huTCt2bkQxNVVBbk5wU2NjT3o1VU5B?=
 =?utf-8?B?dGI5ODlNMzA4YjRQQ2VvaEN1RjhvYmFjN0dROE1US2ZuRkU2bXRZMXRQU3ha?=
 =?utf-8?B?QXlJN25wZ2N5SDdsM0VPNE1FVzQ3c2ZuckJONUJ2WFNadTJiekNYTms1UjA4?=
 =?utf-8?B?VnpvNzBTZXM4SlM2VVA2cnViQ0t2NmpocFhtVHZEdk5DYTkxZ3FjTVB4T1FX?=
 =?utf-8?B?OTQ4TUJvaGZ5bDdnYVpGcHQrSm5UYWw5RTBYZGZkSU8xKy9XcEhSMzBWeU9s?=
 =?utf-8?B?WXZPVmRJdCsxaGJseVBEV1dKZXREcGN4d3NadEs3Q0h2RWdBL1diNmhlY2hD?=
 =?utf-8?B?dk5zZGRJZzAzNGNCakRkSHhsVm1MS3YrbzRUZW4zZ2svcFBnWHk1MVpldFpu?=
 =?utf-8?B?TUtSdE9lZjBWNHBrR3o5dFZKOCtMbnptdVJMeEYvNVFnQVVyOXlLaU9sbEUw?=
 =?utf-8?B?SnRsQmNKcmFtSER6VGFmY0RtTFJlQURmRVhkek9oN1Y4ZTBxcWZPSTVIOWlq?=
 =?utf-8?B?YS9vclJoZEQ2NCsxSERXYnl4YkpJT3JXWmNnakh1amRCdVpJb3dzQlZnS0lN?=
 =?utf-8?B?OURja3lyN0RrdjVpNGZwM1U0Z25ZMm9BbXJnczcxSjZ4Vll0L0FwTzhjUXp0?=
 =?utf-8?B?V2w4TjYvYmw2dXNPUTJ3bFk5Q2ppMUw4MlY0WkpDVVcvc2YzM3FTTzFieGV2?=
 =?utf-8?B?WGs0Q0VTZmNVanY3ZEdwSlJDNGVRZGRFU3J3Qzh4akFXaEVQdTByeFg4VTNH?=
 =?utf-8?B?c3lTTzQ5ZHZmY0tidkF3K0ZJOVF4RG4yZTBBbDVPTDF1UmZUcjBldGhNZEJw?=
 =?utf-8?B?WFpDUDNTd3dqKzdpZnNHamg3STZPeW9vbmRFRkxvcHBaWjV0UnVTbnBjSVpr?=
 =?utf-8?B?bXpLdlM5Ky9WZE5kTCsvT1Iya0Nic2tnemhYV1k3Y1gzdEpJZkl0VDVWNk9F?=
 =?utf-8?B?RkFyb3FSWlduSmVGVjJLM1lYY0I0N3BFcUNzSmpVdVdNK2lBNGF0NW42NEdR?=
 =?utf-8?B?MnVYYjNkUy9tRVJESVVpSVJZZStGb21tRk1XTHpUaFJ5a2xRamM2Tm1ESXNN?=
 =?utf-8?B?djFPWGhSYmwzdlZaK3FwSzlsN1JFNXpuWk51bzk1a2ROZXozUkhQVlE2NFhn?=
 =?utf-8?B?b3BTeGxYRy85S2NRR1Z5S2JMSFhGTkU1THY4MEJLaXlHK2I3Tks0MWE0ZWJN?=
 =?utf-8?B?RDMxRU9PbCtYY05OaDZCRVBVd3cxaXpEUVh4YlFVTU9mWjlyY21CODhFKzhh?=
 =?utf-8?B?VWEvM2JLYTRQQ003UVd2THNHZUd6K2h5V0k0aXppdkd0b0hmNnJubmZ5V1JY?=
 =?utf-8?B?YU5jdzJnUThlRWlXRFpkc1VvVzRiZUFxb0FjdGl5dEhYMXQ5UHRDWkFjU2h4?=
 =?utf-8?Q?OL2+FlqS+Rpjz6mdamJKeFV5o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcde327f-86e6-40df-4afd-08dd4baf9c83
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 21:52:57.5506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5XPxbFHyykbvCxGrms5bO641PBK7I5/zF2kmXIqhRj2XCnglNdZ/cgrZSQ/pz1dhHuGuluAJkKusKMxE948Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210



On 2/11/2025 5:58 PM, Dan Williams wrote:
> Terry Bowman wrote:
>> The AER service driver supports handling Downstream Port Protocol Errors in
>> Restricted CXL host (RCH) mode also known as CXL1.1. It needs the same
>> functionality for CXL PCIe Ports operating in Virtual Hierarchy (VH)
>> mode.[1]
>>
>> CXL and PCIe Protocol Error handling have different requirements that
>> necessitate a separate handling path. The AER service driver may try to
>> recover PCIe uncorrectable non-fatal errors (UCE). The same recovery is not
>> suitable for CXL PCIe Port devices because of potential for system memory
>> corruption. Instead, CXL Protocol Error handling must use a kernel panic
>> in the case of a fatal or non-fatal UCE. The AER driver's PCIe Protocol
>> Error handling does not panic the kernel in response to a UCE.
>>
>> Introduce a separate path for CXL Protocol Error handling in the AER
>> service driver. This will allow CXL Protocol Errors to use CXL specific
>> handling instead of PCIe handling. Add the CXL specific changes without
>> affecting or adding functionality in the PCIe handling.
>>
>> Make this update alongside the existing Downstream Port RCH error handling
>> logic, extending support to CXL PCIe Ports in VH mode.
>>
>> Remove is_internal_error(). is_internal_error() was used to determine if
>> an AER error was a CXL error. Instead, now rely on pcie_is_cxl_port() to
>> indicate the error is a CXL error.
> Wait, pcie_is_cxl_port() in isolation is insufficient, right? In other
> words, I would expect that when the response may escalate to panic()
> that the code should be reasonably certain that this *is* a CXL error.
> At a minimum that is:
>
>    pcie_is_cxl_port() && is_internal_error()
>
> ...or am I missing something that it makes it unlikely that a standard
> PCIe error or other internal error type will not be thrown by a
> pcie_is_cxl_port() device?
I thought it was sufficient. In the CXL path the AER is logged. The PCIe handlers are not
called but then again the portbus driver doesn't implement a CE handler and the UCE
handler only updates the return result. That applies to all port devices.

And obviously CXL RAS is logged in the CXL path. If the CXL device errors are
handled in the PCIe path then CXL RAS will not be logged.

I have changed directions to implement what you want. I'm only replying here
to explain why I implemented as I did.

Terry



