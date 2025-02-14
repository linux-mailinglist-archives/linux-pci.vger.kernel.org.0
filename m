Return-Path: <linux-pci+bounces-21529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D610CA36835
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 23:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC501886B6D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 22:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9D41DF993;
	Fri, 14 Feb 2025 22:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JEf0SBKG"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CB31953A9;
	Fri, 14 Feb 2025 22:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739571813; cv=fail; b=hBnAOe57AxbycSgTAsL5/IJzYlvU6s2C0DTQMaD9MR1ERoGkyRukWzjfTSSAC4JTjdvtYs9WnjsDBvsvrw++hLp6xUnKwNY9HXKvcGZee249lboTanh3dnZsf2Qi0GfM0hyi6rmZvkRke4BkMzwB2Rd5a1JJbeGI1JOvTuF+AmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739571813; c=relaxed/simple;
	bh=c/6M/JU9V5nifIDg8gqgR9VHyYmyxP/7R9GbyY2fDQU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NS2+++RQ/3tfMpHrZe91XB0bgKBU9Vh3jGv/DAjnNJPtNLwSlP7wHoSOnRiYzlRFoThRiRjh2nX9biYUr89hZ7yv425QI7vMVkwbkQIucb+fbbwFyr7mnO5pLZTDjYlkI+gZmSLU9BCYMbpqVG4sLUoY3ZEO9A3IcMK2LDTlKbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JEf0SBKG; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ud4GYJfurJ3IuScpw5KnRAMfmuEg9qbept8rv56N/XMIA2niqIANEtdpC6kwweJ2VbrErFMBDGVov2o5hRoOeuhpkjXnqyH+uvkm9TBFAo8h+L68ul+9k5Byw0QxTbyTtPM2HKrFO1ZG4dTFmzRLo66dVZRO+P6+/yS9HmHG2XwoJYZ6Wlqb5kKh9aP5UO8G3AtLlq3x9ce46jgT3dv9hr43b464MJng93M1Tsh22xjILBEUVj2U29OZ7Ff8KSOwv7FR5Xt+XuwSKX28IMyKrtFg8Lr9B0eJO+0KOv4NGY0lwqZG7E7MKbKTH+N7sBcPRoIVddGKcFNfTS6tuc0c9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwJGJ99xx5XRXMsKKHXnD1WIiUvRbcfJCOwqoM3gGG8=;
 b=cuNyZrkdD1yy37P6EJkoVjBf7WO8UKyEwnSId64a8dc5KwC0gQLwuN9sg4yGXcgfcBZsAiSaBpSJoTjmGAmvbbcU+MJl/ARXWv9LTtxhK9d8u9mAmCTNfcXfgN8fpVlpzWsIXnnwexTf4gyba4t7nt9961CquuTRza4AuhMF0NcDhJBrzdBIFhxEH0GYzhwhCgkQYsrmm1+XcR9QnkZrgqNc83ZwYNDG6HR7XUiehFFhWhAKJrt8psho0HAcnFlZp/auG2VNmjq6BYqTnvI8cC3fOMTtPZFxH8JiSs1nWUwfI9zFepu/pm7ggLSgSZ8mqDq7QlCjafNq4mz2vyUJSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwJGJ99xx5XRXMsKKHXnD1WIiUvRbcfJCOwqoM3gGG8=;
 b=JEf0SBKGqT6IQDNKmdE8YdM/BOmdj6k7ZFa3yCcJcOLvXVZALmPiNqcRy0q7xNA9WUIurpK7J7P89nkE3nRx66oyVVld+ryjEOSGaQpg33FApU91qdewhGP1Dbn6teFf2RGBYVp5jWl/pWgV9ncRmX0l2YrUZORZLUTUTbEqtms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 BL1PR12MB5993.namprd12.prod.outlook.com (2603:10b6:208:399::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.14; Fri, 14 Feb 2025 22:23:29 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8422.010; Fri, 14 Feb 2025
 22:23:29 +0000
Message-ID: <ba21e8fd-831a-4215-9e4f-60b5036d63b0@amd.com>
Date: Fri, 14 Feb 2025 16:23:25 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/17] cxl/pci: Map CXL PCIe Root Port and Downstream
 Switch Port RAS registers
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 bhelgaas@google.com, mahesh@linux.ibm.com, ira.weiny@intel.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 lukas@wunner.de, ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-8-terry.bowman@amd.com>
 <67abf81f4617b_2d1e2946a@dwillia2-xfh.jf.intel.com.notmuch>
 <609a02bb-3271-4021-9499-8b281a959f62@amd.com>
 <67afb4955252f_2d2c294b2@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <67afb4955252f_2d2c294b2@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0075.namprd11.prod.outlook.com
 (2603:10b6:806:d2::20) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|BL1PR12MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: 23cf9115-caf9-4013-21e8-08dd4d4634fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkkxZzhpZG1CUkxvQVkxeitjQS8rU1lFMmpydHV4TGg1ak9VVHBYVDEzMVlG?=
 =?utf-8?B?MkE3YnluSkFub3Fhc01oVXpRZzB1UFVITFJFQWdoc2pMRTZZeHBSMmtkUTAr?=
 =?utf-8?B?RFlrSStlNVhNeDFJaXh4ZXB2enhzZDl4eHJrOTFhOTVOUVE5amdHR3RwMHBZ?=
 =?utf-8?B?MFJLNCtTOXB4aVd4NkFCT2RObUhSSEJjdWQwWWQvcjJGU3hESGozK0NacFh4?=
 =?utf-8?B?VEpvSzMwelZQMWhuV3RndHUzYVhscnR0VG9vZXV0akZNZ2xuMWxvVTBYODlH?=
 =?utf-8?B?anJHZzY0WnhDcGNBL1d5NUZmM2lWaTFlZnpsK1FDbldaOEFGZmhDdm84ZDhw?=
 =?utf-8?B?c0NtWVRaWEJReFVFT0JPUjdjK1J1dmU4OEZYcFlmaFhGa0dpUUVZSTB1R05Q?=
 =?utf-8?B?S24wN1NlWFVqY2FIVXlEbkpEbkZRRjFjWTl1bEZ5cnlaVnlHNXkxc0Q0alY2?=
 =?utf-8?B?a1hqL29ocS8yTEhDTStkdUhYMzBFQjhtMThlL2FmUHpianVsUHB2aE5adExP?=
 =?utf-8?B?czc0QVBLMUtEMFRUZmF5bVhlaG04SkFkVktzOHRrUEZlZlM0dnJXM3FKYXFz?=
 =?utf-8?B?OWhWcDdtSk1qci9sWG9VcnBFZTBBVnRhUTBaeUxNcFpvbUF5dGl4azlmbFY0?=
 =?utf-8?B?L21PRXVzUU1PdThZamtBaE85SzJ1UjdJVTFGclJBTkpJMyt0SDRQWmVuQURi?=
 =?utf-8?B?SGNFNGhDSXpGVXpiUU5wR1V1eHg0bTNxbmcwT0FjRTVKNm5GQ3l3cGp2TXkw?=
 =?utf-8?B?cmhhbHlyS2FIR3F3STE5MEh2OENzcTJKeTJhdUNtR0h1M0tkbXBtdlZSVTNY?=
 =?utf-8?B?SGJSMHQ0T1FVQjdmamJNT2t2VlZ6dzNpYUtxcG54YTRxZUxDWUxTWENnV2FM?=
 =?utf-8?B?NTFuR2R6blV1eFVWMkRJdDhhd2FUQ2oxNjkxVnQyalZ6MjM5SGtaYW5SL0s2?=
 =?utf-8?B?SzNnTmFaUjM5REpRRmhIQlQwYVdQYkl0VW9lZkpYNVFTYytXRnVJU2YreWdE?=
 =?utf-8?B?UzNNVE5qSG1jamxmRVhQc1l6OFd0cnBvc3dBRHMrOG5ZWndHSmlzbWJRQzl3?=
 =?utf-8?B?QkprajZNQldkQUxRcWllWnRLNWNIdUQwY2MvYTg2cUhHRnRabDQyeHlJU3A0?=
 =?utf-8?B?S0d1a2xVS283eCtaZWQzNlZtdWI4VGNLMnhpYUJRK0s5ZCtQbnh5UkxtMWx5?=
 =?utf-8?B?b2FLR29kT3BLUmJ1S1gxRSt2Y2lYMzRBYWsvVTlVbEtjcWZVNmVhdVEwT1ZF?=
 =?utf-8?B?aWtCakpBQ0x0WHZNdVk0SjhkaVhqMlY4ampKeE9RTXdEd1FwTmNGMFoyNExq?=
 =?utf-8?B?bXF4c1IrVS9PaW9iMURaamNlRGFlTDIzbkVkeEhVM3l5Sm5Ub0R0VGQxVHpP?=
 =?utf-8?B?R3A5dnVCS2cyYkVrdkJtWEt1bC95ZTRPWEJRd1lIMmtraC95TmsreGZJOEtl?=
 =?utf-8?B?aDZhU2tZR2VuL29yNTR4OGpNMkVFNEFhKzJDTi9xcnF0czI3N3psNDQzTUVM?=
 =?utf-8?B?d2VZNFQ1dDIxZitCNGNSRGdSUjlTd0JxbDU3aGdWN1pVaDNKVHdMSWZWYWZT?=
 =?utf-8?B?VXlVUUVVc090b1ExS2QzQXVlaXFqb2FyR1BwSzc3NlFJdWl1dFpKd1NYbUNE?=
 =?utf-8?B?ZlNDaS9qd1A3VnJ5enN2dXE5bk1xUUFEZkVSb3drREVTcSt3T1RoWnc3V21j?=
 =?utf-8?B?bGh3NUhYTXBwUTBVR3czM3RTYnFwMm9Ha2drL0RuOHNZYTFEd24zL2g4ZUdj?=
 =?utf-8?B?UTdZSzgvMXBWZy9KV05jQVRvYWYyaTE0N2R5cU03VnZZOHlUemozQ3RSVnd0?=
 =?utf-8?B?YXlOMzIrSm9yRkVRUWF1VTc0clNVcXl1UnNaT2Eyd0dHRGlMTEZFNllZOEVp?=
 =?utf-8?B?ejhDSENDWFZwWHlWWUUya0hxUDd0ZDNGUGZkNDEyVGpKYnUrZzdiYnhHaS9j?=
 =?utf-8?Q?wxCXRVdmRv0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWh3bGI2N0szQU1CSTFQSjlRaVNaMzRYUHVUMVpsZlNYaFlYVWE5bFZIanZH?=
 =?utf-8?B?MDF5RlkydkRTc21UYUQ3MkgzY3ZTODA1djNXMzV6MzZhRG83K2NSaDBxRElR?=
 =?utf-8?B?b3Y3WVh5Y2hKdzVodE9mRElsK3k0bGJBZGdvMm9rN2ltRGQxT3dLWDZITE0x?=
 =?utf-8?B?clhwUmZCL1NxdlA3TGg0d1JzRjBYUUd1MENtUjZMVnlRUjBHczVsQ3IxZUR1?=
 =?utf-8?B?a2hIZHI4YzREckhHajVDelEzdk9MQW00Mm9zZ3htYXNWYkVuVjY3ejduWkpt?=
 =?utf-8?B?NFhyL0xIQ3BlYW5ZTWRGMmJhMThvdnN5RFg1NHhBR0x4ck1NQnhJbXV0TEpP?=
 =?utf-8?B?Y3MxQm9xUXh2anNJNk5jdXJnWXhMekNLVE5PMkJycXREMEVkcm96VlRNZjg1?=
 =?utf-8?B?Q3JLaDVMUm5rV1ovTXJDOSs3SUhiWS85ajVjeTlVakFZM2pGV0gzSFZkWkpC?=
 =?utf-8?B?VEZQRWVCaFZUcGErOWN6aWNpQXBycjNoUDl4WWlpZGl5MHpVcVZuVlZCWmEz?=
 =?utf-8?B?a1VrNnZPTXl2cFNRajFtYUY5Q2FuM1ZXWHhEdW03am0xNHRXYVhEcFBUZVJa?=
 =?utf-8?B?ejF3cU9pQjlqRld3UG5CaGluNks1WFdLV2kzb0g5OUhDTmZRaG9wcnA2N1hN?=
 =?utf-8?B?TUxZT2YwSnNIdlh5dHNRTWtoZ21sTmxwazRnNVNLYW1tTzV4bS9abjVnWktV?=
 =?utf-8?B?OEMvczdrOEdibWI1OVBuWWFSb0J5dXk1RmtuU0hFMndSdEQvQ09VT29aT2Za?=
 =?utf-8?B?WGMwNUFVMW1pd3l0SHhzMURWazhXVlJNOWZRNFRqTC9YaVRFRXVCWjVPYVlX?=
 =?utf-8?B?YkNuSm5YOWdneE5ua3RvTnhRV2JEbXlTVElvNmtaVHBBNWNHT296M0R4MmYz?=
 =?utf-8?B?bm1hWWRMUjlLVG1US25SMG5nZFh4TlZIcGFsZ2lhRzBmVlVqc1RwYXg2RVcw?=
 =?utf-8?B?Z1dpN2ZScHZ2N01KR1QxK2NSRkxyd1VZOVh1dGw4b2tIMlFWNHRTeXZmdTdn?=
 =?utf-8?B?V1dwOWFLSVVGYnphY0ZVYnp0L0htcHNGanNPN0x3WEk1VVA0UnMrWjVsY2M5?=
 =?utf-8?B?djQ0c3FqMUp1TXl4R0lGVEJIbU9yUkIyVUdNVGJMTTZaTmY3dnhqRnpxOXpt?=
 =?utf-8?B?ZmJkWVF5dE93S1J3aEdKcFl1UXlSQ2dYV1NrM1hlQmtrN2xRWjdiZktDanJz?=
 =?utf-8?B?Q2dPRWl6ZTF5bXlPenJiZXpzUmlCRlZ1amNvWk5YTHhuRnpyT2ZIbGlMSnMz?=
 =?utf-8?B?TFVuRzM2Q2RDNVIxSUs2MkJ2cys1bmxMTU9VYU5iS0tTZ0NaVlc4SHhZOW04?=
 =?utf-8?B?V2YvL2YyMmVmUGRyQkJmN0hqMHM4MkVvMlZ5ekZLRFM1UjZSK3FWYi9NTkhq?=
 =?utf-8?B?ZGNybFBxQWNUcUt1ZWY5dTNZRkx3aWo0WUdNazF5d2Z1U2hMTkh5NkhFWWVX?=
 =?utf-8?B?elUwa0NiV2tBZm1TQVJwUklDRHNWUVpVVnFZUkJNUGtPRVBHNkhLM0dqUHFl?=
 =?utf-8?B?MUg3dklTaVpnU2p5bVcrZktadUxiWlBraE56QXhuRDhhZXNXM1hUaXBabXQr?=
 =?utf-8?B?Z21QV0xVWmVETDRORmRvcm1FVWJUSE0yQWdOWmt1VTQrT25XVWhRRkdjajhD?=
 =?utf-8?B?NWQ2VUpvNFlxZXB4S1Z3YVZlV1pXbDdjYmZqaXRMdjQyeVkvY2kwYTZrQ2E3?=
 =?utf-8?B?VCtmWEVyMmk0ZW1XTzF6Y0hWeTRMckNia0VXYXZWa2hQYWg2YUhYWXJKOWVQ?=
 =?utf-8?B?c3h1MU5UNElnY1BldWU4KytvVUp0ODJwdWhWYjUrSTA1RnlzVStDNzdvcjNY?=
 =?utf-8?B?WERwbzh6bkpWWk1LQWZvYTBrNVpMdTB4WWdpWjg2SUZMeHBiVVczb01USlBa?=
 =?utf-8?B?UC8vNFpjNlYvTjNYUEkrWnlIVXhzMnlXMTBKNFFJVldTVU9GRGlwTzNHTExh?=
 =?utf-8?B?S3RLSmU5WFNZMnNhOERyK2NCdUlJSEFrcGlsaEx5OUlNVG5ML0ZEMzF3VlBI?=
 =?utf-8?B?c3psYXpVT29zN3FBelh5SkJLVjBYdUJaRWdDY3MrN1lhUGYxZExEbk8wSi9p?=
 =?utf-8?B?K1Y3R1phdXRDWE0zZUU1M1RveWp1SGw1SFkzbGlLRllJSmV2ZEdWQk5wOVlo?=
 =?utf-8?Q?3La4mTcNdrx9IwjXlWq/D3D7j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23cf9115-caf9-4013-21e8-08dd4d4634fb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 22:23:29.0063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MkuJ9wgpgdPq3wtttf4CmgiEj+tD5IcD0xbROBTvoad3P5Yr69zPZpm7FONPHTG+YHJ4h3FzOyxhSb1eiyfPvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5993



On 2/14/2025 3:24 PM, Dan Williams wrote:
> Bowman, Terry wrote:
>>
>> On 2/11/2025 7:23 PM, Dan Williams wrote:
>>> Terry Bowman wrote:
>>>> The CXL mem driver (cxl_mem) currently maps and caches a pointer to RAS
>>>> registers for the endpoint's Root Port. The same needs to be done for
>>>> each of the CXL Downstream Switch Ports and CXL Root Ports found between
>>>> the endpoint and CXL Host Bridge.
>>>>
>>>> Introduce cxl_init_ep_ports_aer() to be called for each CXL Port in the
>>>> sub-topology between the endpoint and the CXL Host Bridge. This function
>>>> will determine if there are CXL Downstream Switch Ports or CXL Root Ports
>>>> associated with this Port. The same check will be added in the future for
>>>> upstream switch ports.
>>>>
>>>> Move the RAS register map logic from cxl_dport_map_ras() into
>>>> cxl_dport_init_ras_reporting(). This eliminates the need for the helper
>>>> function, cxl_dport_map_ras().
>>> Not sure about the motivation here...
>>>
>>>> cxl_init_ep_ports_aer() calls cxl_dport_init_ras_reporting() to map
>>>> the RAS registers for CXL Downstream Switch Ports and CXL Root Ports.
>>> Ok, makes sense...
>>>
>>>> cxl_dport_init_ras_reporting() must check for previously mapped registers
>>>> before mapping. This is required because multiple Endpoints under a CXL
>>>> switch may share an upstream CXL Root Port, CXL Downstream Switch Port,
>>>> or CXL Downstream Switch Port. Ensure the RAS registers are only mapped
>>>> once.
>>> Sounds broken. Every device upstream-port only has one downstream port.
>>>
>>> A CXL switch config looks like this:
>>>
>>>            │             
>>> ┌──────────┼────────────┐
>>> │SWITCH   ┌┴─┐          │
>>> │         │UP│          │
>>> │         └─┬┘          │
>>> │    ┌──────┼─────┐     │
>>> │    │      │     │     │
>>> │   ┌┴─┐  ┌─┴┐  ┌─┴┐    │
>>> │   │DP│  │DP│  │DP│    │
>>> │   └┬─┘  └─┬┘  └─┬┘    │
>>> └────┼──────┼─────┼─────┘
>>>     ┌┴─┐  ┌─┴┐  ┌─┴┐     
>>>     │EP│  │EP│  │EP│     
>>>     └──┘  └──┘  └──┘     
>>>
>>> ...so how can an endpoint ever find that its immediate parent downstream
>>> port has already been mapped?
>>
>>             ┌─┴─┐
>>             │RP1│
>>             └─┬─┘
>>   ┌───────────┼───────────┐
>>   │SWITCH   ┌─┴─┐         │
>>   │         │UP1│         │   RP1 - 0c:00.0
>>   │         └─┬─┘         │   UP1 - 0d:00.0
>>   │    ┌──────┼─────┐     │   DP1 - 0e:00.0
>>   │    │      │     │     │
>>   │  ┌─┴─┐  ┌─┴─┐ ┌─┴─┐   │
>>   │  │DP1│  │DP2│ │DP3│   │
>>   │  └─┬─┘  └─┬─┘ └─┬─┘   │
>>   └────┼──────┼─────┼─────┘
>>      ┌─┴─┐  ┌─┴─┐ ┌─┴─┐
>>      │EP1│  │EP2│ │EP3│
>>      └───┘  └───┘ └───┘
>>
>>
>> It cant but the root RP and USP have duplicate calls for each EP in the example diagram.
>> The function's purpose is to map RAS registers and cache the address. This reuses the
>> same function for RP and DSP. The DSP will never be previously mapped as you indicated.
> Are you talking about in the current code, which should have already
> reported problems due to multiple overlapping mappings, or with the
> proposed changes? Can you clarify the sequenece of calls that triggers
> the multiple mappings of RP1?
Yes, in this thread I was discussing the current implementation. The
multiple calls to map RPs and USPs occur with the below calls. It iterates from
endpoint to RP. From patches 7 and 8 (v7):

devm_cxl_add_endpoint() cxl_init_ep_ports_aer(ep) - Calls for each port between EP and RP.cxl_dport_init_ras_reporting() - Maps DP/RP RAS

> Also, if EP1 and EP2 race to establish the RP1 mapping, then wouldn't
> EP1 and EP2 also race to tear it down? What prevents EP2 from unmapping
> RP1 if EP1 still needs it mapped?
>
> I would prefer that rather than EP1 being responsible for mapping RP1
> RAS, and a lock to prevent EP2 and EP3 from also repeating that, it
> should be UP1 in cxl_switch_port_probe() taking responsibility for
> mapping RP1 RAS.
>
> One of the known problems with cxl_switch_port_probe() is that it
> enumerates all dports regardless of attachment. That would be where I
> would expect problems of dports already going through initialization
> prematurely in advance of an endpoint showing up. However, that's a
> different fix.
Yes, there is a problem with the unmapping. Your recommendation is a good
idea.

Shouldn't cxl_switch_port_probe() map UP1 RAS as well?
> [..]
>>>> +
>>>> +	/* dport may have more than 1 downstream EP. Check if already mapped. */
>>>> +	mutex_lock(&ras_init_mutex);
>>> I suspect this lock and check got added to workaround "Failed to request
>>> region" messages coming out of devm_cxl_iomap_block() in testing? Per
>>> above, that's not "more than 1 downstream EPi", that's "failure to clean
>>> up the last mapping for the next cxl_mem_probe() event of the same
>>> endpoint".
>> Synchronization was added to handle the concurrent accesses. I never observed
>> issues due to the race condition for RP and USP but I confirmed through further
>> testing it is a real potential issue for the RP and USP.
> It is still not clear to me how this singleton lock helps when multiple
> EPs are sharing a resource that both races init and shutdown.
It doesn't. I overlooked the chaotic unmap situation unfortunately.
>> You recommended, in the next patch, to map USP RAS registers from cxl_endpoint_port_probe().
>> Would you like the RP and DSP mapping to be called from cxl_endpoint_port_probe() as well? Terry
> I think it is broken for an EP to be reaching through a switch to
> initialize a shared resource at the RP level. Each level of the
> hierarchy should take care of its immediate parent. We need this
> bottom-up incremental arrangement due to the way that CXL hides
> register blocks until CXL link up.
Ok, understood. I have already moved over the port iteration that was in cxl_init_ep_ports_aer() to cxl_endpoint_port_probe(). I now need to change the logic that iterates EP to RP to be more localized (just to the endpoint's immediate DSP/RP). And from your comments above I understand I need to update the cxl_switch_port_probe() to map upstream RP (DSP for multi-level SW).Terry


