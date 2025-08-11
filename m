Return-Path: <linux-pci+bounces-33781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B6AB21535
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 21:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389593BC347
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 19:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D058B2C325B;
	Mon, 11 Aug 2025 19:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OiJF15/s"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F9FE555;
	Mon, 11 Aug 2025 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754939654; cv=fail; b=Ggpq2IaNaSIQFtlUVoyakHmG0zZC4F3sCRUDacA5hFJwwRRALHOo7BT2yjstIIuK8hrhCWMznc/yZg8w4OD8oj6anZyIXa/flTVsm3f19zwRa8QkOibaPiabVBQMS6mQ97pDLGq8/28I8LtCwlI6MV/eGz9wJH3BGYQIAoKfRa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754939654; c=relaxed/simple;
	bh=k4M5WbvTu9GBP8r4hQ6U8qXGrWcIhZud2P7ou5VjeuA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DpNEPwN3hbM5zdnIMDlzza6M9icrAt2Qh88ZIKdxymloetL5TWl0GC2AoXyfrFZ6aZdu7ZHQxsleG+LCqrQFmrpqSTtkaBoG1lFNPQ/jL9Ft+1YHt8rlXlhnRNsSnWs14pjGXQys130PJdMYVNCURRtUpQz7XD8ErhJzTkvmbzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OiJF15/s; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUQD9aATiQ/+hpHdt9PEvo/5tXVLxa3/mSfX6EdfDYGE9n1e0bI47zmVVTaF7Jl+QScGQqSwwA70DHaG0kmMI7kRkFjDAmp+Rc4HxyqpBwz6cO+PbmUTTwagDVFIiGaf59pRDMG8PuNZglUTZBBNDOWHKsaycaNuZbR0PEFcyhR1EI2kQ977ABlFYYibWuW+rL94uU7U94iTpZFnURiTpMFFPLbaLSX2wIsk+cJdMkk7LeN6HOMaXq5rSx3UMTrqG03/qyksMp81W5VJQLWb6E7YnehPxGW5s3RTGkWzZNpNsC2X9mH3oay5qKbw8Py1THBq0kQ8ylwJdycxfbHLZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBnW3hMa8WvHt9MtQMra1r39S66q3CmQ/oFllwHWeD0=;
 b=ZH4pYonEfSFhPSXqUc1gqnU5hd9wzOK4LfAoUkaOaKENxL/6hNHKKdRJlpadZTMdc164SN5oti/Q1Sb0+PqUlJXhgkG0Q6Ii1CJiANNkOsplwQRXI8o8Ko9MlgB0LVD1pgxiTQCzOT8ByyJXJiTohifsSaBctzMCeZQsPYzpISPV40erJ2/NQBvLU7uzoITrhpV0GZ4uKi1t7SC1bcl/ljHMx3gV54kwzZ4KjZxRFG/RioYi0xEKwVqetyqNhVC9hUZql3gN0g+5x+WNhk4WRQhMdzzQOeWHe0g4aKGYbDUo8xQASPTztGVUZ7i2zr6uNnPP5sf9O4mJe+AmGaWhjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBnW3hMa8WvHt9MtQMra1r39S66q3CmQ/oFllwHWeD0=;
 b=OiJF15/sgX6xDAryddYiqXexI2nC5QTuDATlEnnZpmzPIPDERIhrcWvKX6ZqqS/6xuatHx6sn2iM6+lOwW3Plg8LpT6VfZA1q1n9bMah6kvfI4AoEF57q8BR1Zpf6PpJFxZ6aOPSy27Ptob44veCB+TlvWTxnWBHDE0HRx+PGZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6396.namprd12.prod.outlook.com (2603:10b6:510:1fc::14)
 by MW6PR12MB8868.namprd12.prod.outlook.com (2603:10b6:303:242::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 19:14:08 +0000
Received: from PH7PR12MB6396.namprd12.prod.outlook.com
 ([fe80::c74:f334:4a4a:b1c5]) by PH7PR12MB6396.namprd12.prod.outlook.com
 ([fe80::c74:f334:4a4a:b1c5%5]) with mapi id 15.20.9009.017; Mon, 11 Aug 2025
 19:14:08 +0000
Message-ID: <a490e34b-10f9-4ac4-a053-5d45222ea58c@amd.com>
Date: Mon, 11 Aug 2025 14:14:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/17] PCI/CXL: Add pcie_is_cxl()
To: Alejandro Lucero Palau <alucerop@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-3-terry.bowman@amd.com>
 <d8aee8c3-55cf-4aec-afc1-21773759d193@amd.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <d8aee8c3-55cf-4aec-afc1-21773759d193@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:806:20::21) To PH7PR12MB6396.namprd12.prod.outlook.com
 (2603:10b6:510:1fc::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6396:EE_|MW6PR12MB8868:EE_
X-MS-Office365-Filtering-Correlation-Id: e6ffa43e-4108-4ad9-9f18-08ddd90b3e8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnJ2b0R5VXdEdk93aVJtT1J0VG1wVlhDaWphYkJZRy9mRWFHSTI4NlQ0ZFZ6?=
 =?utf-8?B?SE5vcUV4RTdFOTF4S2xFU25ZalhUK24ybk9WaStSbHpQL1U1ZFR5amh2ektM?=
 =?utf-8?B?dTRBT1BPQ0dpVFMrVUxGVEgxTjJFRHI4WW1UNC9xRCtRY3FCSHlSL08vaUdU?=
 =?utf-8?B?SnhBZk9yN1dCVGdWaFYrRlJleXp5T05nMXBaMWF3S2FnOU1EbkxpdVY5MXdp?=
 =?utf-8?B?SG1MVGM5SEFxQS9GOVliWk50VmtTS2dlTDUxejBPaWNUaWtyU0F5cGxVKzFi?=
 =?utf-8?B?OU9pQ0x1MHQ4TVlUTDE5L3hpdStmeWFFT25EYWxndUp6bGhSMWFsUklUbU4x?=
 =?utf-8?B?OXU3Q2NvTkpGWGRFZllBVG82clpEbm1yQWhrR2lKOHlwR1pzSzdLejNicGtS?=
 =?utf-8?B?cXFUTnZNczRyVDBxRDlxNkRxRW5hem45d1cxMzBsR3BrUXpZQTlkdXd0MVEx?=
 =?utf-8?B?YnFFaVNnekdGRWJBQXhSZkMvWjc5amFnYjl3TVI4NnQyUklqS242M2lLelVv?=
 =?utf-8?B?b052UVRCeXRnSWtneGc1OVpaeTh0cVVhbVB1WE1qL0lSOW9xYk5KendqU3Rx?=
 =?utf-8?B?ODMxZitmRXBvQlVCWTVTdDZRQ0pvaC9hZnlVTVR2ZDFta201eW1oTndTbnd3?=
 =?utf-8?B?UWdWT01Ob0lUeWRFNGp6bEVvUEtsbVV2OEJjRlpmRXZiSGcwbzQybkVFZUcv?=
 =?utf-8?B?ZEl4d25BL0V1ZzFCbUdUU1djMHYwTGxLOUpOOC95R29MdTRNQjNJeEhWcEIy?=
 =?utf-8?B?d0psZFdlOFFueXhIUDgrREZpdjhjbXpzZUcrUE56bzZVRHlFNCthajZsUmsx?=
 =?utf-8?B?WStFdkUwSHlKZFBkU1NLTUY3eEN5eEoyWDNlZEdySmw2Y3U5U3lKdUpjUXNW?=
 =?utf-8?B?T3Fkb2l4dEdhdU0xSC9EL3hIb2lsMXlGM1hFZzhiZmR2d0VMTFNaNWJMa3Uy?=
 =?utf-8?B?b3FLSTB2SWV6bW5nUC9weFc2aW1yVUs5UWlpdmphKytyWEN4MGZLWlNKVDZT?=
 =?utf-8?B?N1ZEeFZURUUwSE1ndkczbmRlVXlaQTk0M0NOdHZJbGt3SHdkZkxVeVlEWDdD?=
 =?utf-8?B?WW8wZnZPbmNsSEd5K1VYWU5yNkVmc1ZhaXBrVTU3TWdRcWp0eEJZa3N1SFJt?=
 =?utf-8?B?YjBTUGUrWXVsRXhPRStKeHNVaWJrWmx0MlBCMUl1ZDlhcVRqdEFxcWIvaWdI?=
 =?utf-8?B?Q3NoclpJU3lNWU9lYXdRR1JkTUtzdm5kOFJYaFhyZDM3R3Z4QmM1OExzNmUx?=
 =?utf-8?B?VEtzeXQ0QUh1R3RZQWI0NzZMYWluMDg2UHJQZENuaWEyUzU4a0tjZUVVakxv?=
 =?utf-8?B?ejhRRklpclZxTFRSeTdyUUVNQlFCRStieFhLd2d5QXJpODFkTWpJYUE2MlN0?=
 =?utf-8?B?MTlma0hlaG5STjV0Q2VKblR3STA2Q05PeDl6TnVSbzZkYlN5NG1JRkZaOWJt?=
 =?utf-8?B?bmR4U0dMcWdJYytBVk9GSjlFNjJhalpuWlEwWXhkSWdpUDUyaGhiK0t6c09L?=
 =?utf-8?B?YjdCRjVHTGxtUCs0SENpbXM5V1FzMWtYV01nSm5LN1lraFE3c1NtZndvbWtm?=
 =?utf-8?B?bVhqdnZyUnJta0F1c0hxQkdhd3NxSEx6dDFUMUQzeklMZFZOS09nb2Vmc08z?=
 =?utf-8?B?ZVlpUmlSWFI1YVUwY3h6M016NlFSRk05YnowWnB5UmFPTFhKaDBYOVpFOHhN?=
 =?utf-8?B?K0g1S3dDSVVNNzdRYlhtbHFONGxyUDluQmJIdTdOQk1tYmxkU1RLc25Tdzdx?=
 =?utf-8?B?YVdJT2l5TTZ5UWNvbnlVVkd6TFcwU2xWcXpvdVJ4STRvdzNPZlgxb2FYYmV0?=
 =?utf-8?B?QnBxcFd1TVluMjE3OWFoMU5WelBldkNIcjViSHBvUmZ3Q0hXRGxtVFlyU1FF?=
 =?utf-8?B?YWhQUm9KSzBlNGZxeEtvTFdlRGwrRDBzVUQveTFwY2VWcDI4OXEva1hENkpC?=
 =?utf-8?B?dXJEL0UraTdFNGpaSnRDeUs4R0dVb05yN2NGK1A3cEhSV08yWlFQTW40MnJO?=
 =?utf-8?B?NW1SR01VM1pRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6396.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFNWRktHQUpIdUMzaHVVeHdldlI4UUdpNlE4YzgxNmtQVzMrcHdETUNsMXla?=
 =?utf-8?B?ZFhad0hULzFWR1R6Y0VIM1RVVmRUNFh6SFVwZlovNWxVak5Xa1QrTzZESGV0?=
 =?utf-8?B?a0YvUFlJVzNKbFRJWVMyVmtlb0NUWXVVcm8zV2taNFd0bDMvaG9UOU5Tek5C?=
 =?utf-8?B?bjhjZElzWE5xQ0twZElvMUVhM2xmS3hrTjUwRmI0cnhwYWUxamtBbWs1SHlV?=
 =?utf-8?B?WVRrRU5saXhjQVVnajJEWFg2MS9QYVQ1d2xVaUZVSnBuSkRJWjhJUGZPczJH?=
 =?utf-8?B?SzkvVngwRUVLenF2M2gxYmJvQkZFL0xwRWhjbEhyNHB2K1J3czRUY0RsNEV0?=
 =?utf-8?B?aDZsRHJrR0NIQTR4d0trY0FmZ0VCTlJSa25KK245dGpWUjdpalNvd1pUTVA3?=
 =?utf-8?B?NXhreDh2MFhOMWtVczJLckRtdzB6ZWtPR1QrclF3VWlNeWUxV21qaG9OUUFP?=
 =?utf-8?B?cTVmNy9IalJETUNxY2lka3NFbVFjbVViK2ZWdWdOZGFRUGplYm5pa08xT0cw?=
 =?utf-8?B?VXE1Q05Jdi9xMjhxTk5vMHJoRXZILzhlZE9vMXZzTy9mUm9HMGFqdmlZRWxp?=
 =?utf-8?B?TC9YSzBSMDBrN2VsNXYyeXd5cmx6a2xKME1QdkdWQi9oMzN6OE5qK050TVVE?=
 =?utf-8?B?VGFCUURtYkJ3eXFDWDJwUTNSSG9XYVRsM2JkYk4zSlZEUDNjN0Vmdys0cjlu?=
 =?utf-8?B?My8vWDI5UHhEM1dmWGhxdkN2U2tGSVkrYzJRTjhrNFJ6QjRUNnZrellwTEt4?=
 =?utf-8?B?cklGei9JRVFINWl2aWluSzMyWGVYRW9aeXJYSnNSaFVjanhEazBXa1ZOTnJ6?=
 =?utf-8?B?dzRxQjJ3ZUlOalUwNXVJVFdFK2R4K0MyOWd1bTY0NkZKSkVYMFgvdmJ2aWxN?=
 =?utf-8?B?VDhqVXFCUUdmeW43UEN6ZDA2L0xqZ2ZHK2U0SGUzRWh3S1gzMzAwWGxpN0VJ?=
 =?utf-8?B?Q2liaW1aVkJGdU12d3pQcXIrVjVrZGsxSUY0TVZnUnZUYVBZeUw5Y3dSY2lY?=
 =?utf-8?B?cCthL0I1b3Bqd2xTVVBwbnhoWmNFZ2tEMzFEVG02QkZDbEl4ZlYweU9BU3JV?=
 =?utf-8?B?a08vREJRWm4wMVRlYTk0UHZwUkxpTWd3Rkg1em9qajlHUzVqYUNqdlN3ejd1?=
 =?utf-8?B?Q0ZUVTBuRURVT0VKUVdrMzRpT2VQN0t6T1M1L1lWT0M4T2VGa204WmxvekIx?=
 =?utf-8?B?eDdPblJjOVdNOEdZOGMwWFhDTEl5bHJxYUUwYjNZRUtaRG9Qcml1dmVZR05m?=
 =?utf-8?B?Uk5LR1BmUm94MWRMNVZ1aks1VFMyT0UyU0htWit5aUVPTmI3M3RhTFBXSW1W?=
 =?utf-8?B?WFUydU1YZHNLM092elFTZ3JVS3M2MnM1YnV2S005b0QzdEQ4dkZNcGxoQW40?=
 =?utf-8?B?azVTNnE5dXhKbU5CVUxrWUZ3ZTMzaHFUZnpvajREcndCM0dNL2s4UFFEbnR5?=
 =?utf-8?B?QlU5UDBJc0VBdkRtSm9qOWlMUkRTQzBaOE52bTlEU3R6aWo0MUQ4VEE5ZmZm?=
 =?utf-8?B?WDF3MWE0eThvVm0yWnFLS1hWUlVPcjJiSmtobTVkaS8vbVB5Q0VZV3hvTjVS?=
 =?utf-8?B?TDZMUVR5U0taV3hyTm9GMlVXV3h0dkl5ZXRXTThPNlYxWk1vb0ZnTEpHY2NU?=
 =?utf-8?B?dlN1MHh0UEo5MzhobTJXS2VGS1ZyclZUL2RBaGM5ZWtTOUNxYTFKd201ZzJr?=
 =?utf-8?B?dm1PUXNZT1pwOS83V2hNZHArczhsRmlnQXBKKzJveldNdkF6bzk0QmVwWWdV?=
 =?utf-8?B?YVM1NHNIblN2SnZhR2RmV084QmQrRkFtM1d0V0lrcDZzZk1UbXp2SE9qMjlP?=
 =?utf-8?B?YVVzcWVTYm04QTJRL245SENWT0M1dVJKOGthR3hTQlpmYWwzdDNtTExuU3BW?=
 =?utf-8?B?NFNJUGpEVVpFTW00SU8vb256M1pXTldPZ0ZNaG9vN2Mwa3R1OG55d1BHbGJC?=
 =?utf-8?B?SXRkUllCT1MwVHFGQ1I5N3IvNTNINlhPenNCRVFZYm9KWGlFcUd6RVVlWmxR?=
 =?utf-8?B?SVFJdUpmVlJ4OHRSZ2kzSzVFTmZhaE1QYW1jRU42VllJQXZhd2lJNWlJRU0v?=
 =?utf-8?B?TzU3d1kwRzluQWhRUitZbHFuM3dQT1pUQ0ZLUjlqSFNXZHlHRURMK1oxZ1VS?=
 =?utf-8?Q?cYkKsX6h6gMU/6jE/89WAe2O1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ffa43e-4108-4ad9-9f18-08ddd90b3e8b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6396.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 19:14:07.8874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ys3o+Zzv7QQYm31Qvy16IqML2Cb5OxnwyaQIx/sjgpz0PzwrlrV9/EJA05laDNGYwdeBPy1Fph+arLqmQIKdmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8868

On 8/9/2025 5:56 AM, Alejandro Lucero Palau wrote:
> 
> On 6/26/25 23:42, Terry Bowman wrote:
>> CXL and AER drivers need the ability to identify CXL devices.
>>
>> Add set_pcie_cxl() with logic checking for CXL Flexbus DVSEC presence. The
>> CXL Flexbus DVSEC presence is used because it is required for all the CXL
>> PCIe devices.[1]
>>
>> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
>> Flexbus presence.
>>
>> Add function pcie_is_cxl() to return 'struct pci_dev::is_cxl'.
>>
>> [1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
>>      Capability (DVSEC) ID Assignment, Table 8-2
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/pci/probe.c           | 10 ++++++++++
>>   include/linux/pci.h           |  6 ++++++
>>   include/uapi/linux/pci_regs.h |  8 +++++++-
>>   3 files changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 4b8693ec9e4c..5d3548648d5c 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1691,6 +1691,14 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>>   		dev->is_thunderbolt = 1;
>>   }
>>   
>> +static void set_pcie_cxl(struct pci_dev *dev)
>> +{
>> +	u16 dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
>> +					      PCI_DVSEC_CXL_FLEXBUS);
>> +	if (dvsec)
>> +		dev->is_cxl = 1;
> 
> 
> Hi Terry,
> 
> 
> Should not this check for the bits about port status like IO_Enabled?
> 
> 
> Maybe I'm confused with the goal, but we can know a device is a cxl one 
> without specifically looking at the FLEXBUS capability presence or not. 
> What this capability can tell, and what I think it is more interesting, 
> is if the link was successfully trained as CXL.io. From problems we have 
> had while testing our type2 device, if the training for CXL.io fails, 
> the device will use pcie and this bit will be 0, same if the device can 
> be configured for using pcie only.
> 
> 
> If this is what we really need to know, changing is_cxl to 
> is_cxl_enabled could be clearer.
> 
> 
> I come here after Dan suggesting to use this functionality for ensuring 
> the CXL device functionality is on, and it would require to inspect the 
> status instead of just the capability being present. Maybe I'm confused 
> because I remember some patches from Robert Richter dealing with 
> checking link up for enabling downstream ports, but I think the goal 
> here is different.
> 

Hi Alejandro,

I agree in large part. We need to check for training complete and any change 
in training needs to be reflected in is_cxl(). My understanding is this 
will be be added later in a following patch series. 

Dan, can you add your thoughts ?

-Terry


