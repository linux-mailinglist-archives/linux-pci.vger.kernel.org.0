Return-Path: <linux-pci+bounces-39293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F466C07F0A
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 21:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42D93404333
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 19:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163902C0269;
	Fri, 24 Oct 2025 19:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NyUaxQl/"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013038.outbound.protection.outlook.com [40.93.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2582C324E;
	Fri, 24 Oct 2025 19:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761334852; cv=fail; b=DlA7vSKrvHM5x4q4NtKgRtGW0AI9mK6MCvUf9t0t/k1No73RFkKy8p214kqG0/o5N2IclkXJ/YMmFqVKQc6RV4V3khhtwtgQrwxy6qD8rhFeyNIhFoa/NsZyMCAjWOW0gUUM1TZtPZgXZL1LsIB3fhHp2Tzh2YdRk9ynM4xixeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761334852; c=relaxed/simple;
	bh=1SuxWyPBRqAgnNEu4bRZcQcJnB2rjmGiyaGr0V1URNU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kzKfQ44RvVnLpwlaMPhBP9QqwhaQcfJdioU6BKwVvK+bFqgxpxmHGlvZ0S8+0Wa614Hv7VF3Jn94C6rddfuooPeDYBe1vc25hr9RhME6zVbQ+N0JtmF9VUc6CtvWyq3u0m4yhGfGwwckSmJ7vc1NUVOjM//zmeIqNlNnd3rVzRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NyUaxQl/; arc=fail smtp.client-ip=40.93.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGZcUTL6b92OI8lEYQfOosJttlXs3+ZTH+phWoOmAaNU5KTjIRgKKyd72Ejkt8cpHAW+6LoqKboe2WYvAJuDzXmVvmZHnrnZ+mBLGFwqTihbevBcCzmDiFAn2yTEAaR9GWM765PVo2o1yJEu2JuJBCvfQUFm9tbg8i/WvpjspVGVjwpgdNu15jPDtC4K1PcS/ToQKyY1OGWymmQCoWyJThZTdw1Li+r8GCvofePSjkuq2dRZLAn9+5G89gU5AIGZJz2+mjrLPedJeLol9uVEm7WbqatoY3fYh6A11/LnEV+ePq7Mh1/CApJ7aTWNH9Dav7+Ceaj2nmls0rEai19emg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vidQscLnkJjfjdXQuJIi06A1LUsOxf+gDWWDGIYe3ps=;
 b=nkizCk9Mk9srcETVyyOU5Hewp0CTPbbzcJQcIb7ei5KFhZ7B3xvmB7EqikLahWwQvxOY05VnuKazNBl6x09Yxs3BHsnCyPGNuxVaN9Al6tdYAsCgpOl9qCV/MKQoVkGArBGLBL/WBC58UxrodRPOTxR8l7oAJ7uk6+rNecP3y0sjESemFEgbM4EzhzMVjK4vV25nS56ZItTitvgI3xVEJRn6cOr8t9a7BbOaAQEwgHLdEJgU2HiouYSQeXwRTqalwn7fyhlX30BTGUh9yMkdwXC9lB6XXDhSWb1ZJR9Htz/+F7WDup4dZOGyw3lyQD6LDoWdsoRsZiSQB4x/oZYQfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vidQscLnkJjfjdXQuJIi06A1LUsOxf+gDWWDGIYe3ps=;
 b=NyUaxQl/ZmJgp2LakQJ2PpdMABOo2EcJJ16LDsksg/PLi9xz1jLJEzLrhGfvnvfITodpDLfhoC4r6DcVgdVqy+UwFJqLgUmy1vlssX9PFCD/fqZZnSefV/CcSrCiyCOVI44vJtTHS8k8LV8Jg5BndYWzxu7t8R9ap6Gq9BTX5Ww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by CYYPR12MB8923.namprd12.prod.outlook.com (2603:10b6:930:bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 19:40:46 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 19:40:46 +0000
Message-ID: <c34dcf08-7a2c-4e78-b2b9-c9851cf6ab98@amd.com>
Date: Fri, 24 Oct 2025 14:40:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 15/25] cxl/pci: Map CXL Endpoint Port and CXL Switch
 Port RAS registers
To: Alejandro Lucero Palau <alucerop@amd.com>,
 Dave Jiang <dave.jiang@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-16-terry.bowman@amd.com>
 <883ee74a-0f11-414e-be62-1d5bdbfb1edd@intel.com>
 <2f5d7017-d49c-4358-b12c-0cd00b229f2c@amd.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <2f5d7017-d49c-4358-b12c-0cd00b229f2c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0043.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::17) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|CYYPR12MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4fdee3-4d93-4f0f-dc64-08de133539d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVkyalFKRWhFVkZ1QU9ISUhybGlYUXVxT2IrTk52WE5GWTlxSy92Q00zZWhv?=
 =?utf-8?B?SUV4eHF2eFdhSnQxRjJuUHZFNGRHRW96M2kzQTNRdVkxei8rNk9YQWVXVkNW?=
 =?utf-8?B?dENCMjZmSWMwQ0R3Zmk2RDZuNHJ5TXV5U1JHN1o5NTlyaGFsejdjOWVLL3Jy?=
 =?utf-8?B?ZHI1b1M0RjZURGxxUnpvUzBPMG0xUE5SdWhlVVUyNEwyeW1vVDVOYitMRkFr?=
 =?utf-8?B?a0NDVkE2UXYxQXVZeEdySjdkUmdteEpRUlRoK2poT2l6UnY1TGFPV3RleDM4?=
 =?utf-8?B?TlhRNlBBWUg4L0hFbmNTdUhwTEsvN1MxZDhEWlJMenIzN3dQZFJyaVZ6L1JH?=
 =?utf-8?B?SS91MnArYXlHbXhmMXZYU0VFc093ak13bzVFNEJKUWVFTTRPT2hlcXkyWHFB?=
 =?utf-8?B?Y082UFpJN0JGZUpSYWhkZXh4Y2lpeFcyR1RqeHFXKzhrbWQxWnRQdTU5TGFt?=
 =?utf-8?B?aGgzZkljREY0SVo0VHdWbG1zUWs5NkpiMjgrNmIvSDlOUlBRdWlOL3dWaysx?=
 =?utf-8?B?dVdLbC9MdTM5d1Y1T2pGRnd2bWlhRFJhMFBtNmk1emVJcnhMNVh1ZWljaEdC?=
 =?utf-8?B?d2dUMUxFamJ2cWFoUDJFaDVHbUJMVk5IeWtCSlg4VUVWT29MTjlYWnFVK0d5?=
 =?utf-8?B?V2FhMXFmcVoyVktrUU1vaHpjUHkybEpPeDNwREkrMlU5bEZIYkdKekVZYVpG?=
 =?utf-8?B?Q3FCdVNlWWhPWTlsNVBOVTNLd3ZxR2I1eTJuWFN0eFZQMGEvTzR1TTJhQVlm?=
 =?utf-8?B?TkNIc1RrZE1hanZNdisrRzFlb0pGTUtpOWIydHpBcGovcHQ4VDdOQlhDY01R?=
 =?utf-8?B?cGRpWHdCa2tWNnRBTWJmSmE1UkM1V1dOY1lGamwzV0JrcmJTdEgvRVRPUERR?=
 =?utf-8?B?VW12RVRYUjBKdUlwRk8yWGpaY1JUZnpENVFQaEhhM09jRGJqUHlFNStYWENy?=
 =?utf-8?B?eTZKSk5EZStPcHRTdkUyYTU4TDNXQktKb3FYRkdIeEc0V2U1VGNKYUZyZWJk?=
 =?utf-8?B?MDVnVFZwRmhWeWViZ1lZdkdnUGdsektydXM3TU1QSUxiQXhNeU12UXVZOWda?=
 =?utf-8?B?Wk9vMVhTTGIwQWUyTUwyNVRBNjh4TE5HblZUdHhSK2YrRFRyMS9oNXIxcDkv?=
 =?utf-8?B?RGY3UHlVbkRQYlp5Z0lkSVN4UTNFRDdrdzdueUc0TVIwTzRNU0lCaktqMjhC?=
 =?utf-8?B?NGljOGpXTTlyY3ptUmorWGd2ZFY2YlhiUFUyODFZMHhRU1dkckFXNjBKNjdP?=
 =?utf-8?B?VDJKRDZMcXkwVEppMjhGUkRaVXVnU1N6Zyt5YWlVVjBNU1VoL3VWd0VmczBr?=
 =?utf-8?B?dGh0R25idGJVTnB1R05oMmxuR2R6N1dzNXVyand1eDJmZ2ZOYmxadTl6RGRK?=
 =?utf-8?B?bmQ3SnJsZHNLaHNKK0dUYWVQeUcvVm4xUURscVBPalV0T0U4ZkZMeVNTMFBk?=
 =?utf-8?B?cDBlSnJsRlRiQ1FPV09LVDQ1bS9xVUxyUWduMnQ5WHpDblZ1NzNwVXFOTTYr?=
 =?utf-8?B?TGpSQ1dacytVQ2VERmI0ODJZRW84OUJiWU1adFM3My9semc3dU9iN1dvNmp0?=
 =?utf-8?B?dzhpYllLbTZCL0ZuaXpBM0NGV1RJTmxITEZSVS9LZ1hyUDBKYnZDSTAxd1Vq?=
 =?utf-8?B?aEhqVWhHNVdMOXdWT2lJdGhHaXArN0t2V2tVakxjZ2QxTTBZSWd1TjRobFlK?=
 =?utf-8?B?ZDB2L245MnlZeTYyRDJJTzJsK283bCtBWjE5VG05UkJ2MTlLb3RwOG9JSUU4?=
 =?utf-8?B?TmlDWmlGcUxwMGlZNlRaVXBpajhoN1A4M05XNHJ4VXcvaUg1N09uZ0N1YW9k?=
 =?utf-8?B?cmJyYlVLNVVtbDNxV3dtekhUbWtpckU1bjlQc2t0S1k1MVgvQU9VSHUzVUNO?=
 =?utf-8?B?QUxMcnJiOWJranlTeHNrd01VNEtjemQyRW9iK1lGYVRmQ1hLQmFxL0VsZ0RK?=
 =?utf-8?B?SkpEYkE3WGFiWWowbzdFK0Z0ejhKK3RrWVI3bkpBSi9rdjlYNzFjbklMMkha?=
 =?utf-8?Q?7TITayTNFPtpqvQZgiZkhxpx6SooXo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEFLbzBlMnNjMXMyaVpwVHRYZGd4QlpDb1dlSHF0aFE0Z3I4STY4TXdBditW?=
 =?utf-8?B?NXhzUGlyYTlkNHVrSmJEZTNzMEZiNTB2KzZnS3dpSjhIeEN4MkQyWW8yZW85?=
 =?utf-8?B?NFVpZ1g1eCs5NnVkWmNrUzBpYytZTVVMZHhOTVBtM0xZZXJ1ME5XUkpJQ1oz?=
 =?utf-8?B?ZHVTY3FoY1owRmN3WGUybWIwNEx3RnpDYk9ncnUyNlg4QUZGdHNRSEMxZ3Ax?=
 =?utf-8?B?Y2Zqc1Z0UlVLN3VUZElSbGYzTGtzcmpuVEozVENreW1yRDBPOGJjT3IySG0z?=
 =?utf-8?B?QzBYRFNhRGlualRYMk03UkxqV0gwcU1ncHVkRmViR0QwaGVlZWcvVFRvUTgy?=
 =?utf-8?B?NFR5WlNnTUxvbnl1K3VoVWIxQVRPMk5jeTViSzNwRlQ0WjJTUmduVkQxUDV2?=
 =?utf-8?B?NHdWeHg4TGduWmIrR2d0UzB1ODhhQTR0WXM2SGpVWXgyRlJBbDkxbk5SOTFv?=
 =?utf-8?B?RUxObzNUQ1EwRzJIY0tzendLNzlUTnh6dk5CQkM4ZE5XSTNiejkva1BvbWEw?=
 =?utf-8?B?YnB5M3hzQUNjWlhRcHlpcFZYWTNoRXVUWGowTjVoSVVkM2o1UWszQ0xWWksz?=
 =?utf-8?B?UlRSV2FrUzdOVGFHc05FY0RwQ3JCZU9pL0preDBwNzBseHo0aVp5OGdjcUZq?=
 =?utf-8?B?NGhLVXEvclNpeit3cWNWN1VyblBOYTU2U2ViekJhRUp3azhFM3hDRHU0a1VG?=
 =?utf-8?B?OXhyZDdSWHhoVDE3elgwNENLSlFoQU5Ca3prMENKcURmSCtOeTNzekFMc1o4?=
 =?utf-8?B?MTk3bVhKblFZR1VBenVIMzdDMGhQVk5XZEdkZlE5bHhOODlCUldhd3JQNlFD?=
 =?utf-8?B?a3hRREhvVFNObUo0ZkFETUVSWTFFRnJzWWZpK0ZzcGlpeUd3dnoyR0FETDYw?=
 =?utf-8?B?RG1tYmhNWVRrUGpKTTZpK0xWS002VmVhYUs5TnY1YXVGMk84OGVHNDJsZkZs?=
 =?utf-8?B?RzdFVWNRWXE3NUFJRVB2WU5GbDR5cXF0WnlzeUQ4VnhtY1lORXlaajJkTmhV?=
 =?utf-8?B?VWlTTy91RmpxTW9Xa0hPRC83d3FidkhFRHdubEVSL0JtcEprWVVZUng2cEc5?=
 =?utf-8?B?aERsRHppeEFkemtTbVZWNCtsMzhhajNaZ1dwOVNkbmVSdlNPbGEyT1V2Smpt?=
 =?utf-8?B?eVFweHBDaVZWQWt1MHRqVnFQTC9PWStRaWlJWVhIc29ibUp3bFJ3MmxzN0Zk?=
 =?utf-8?B?SThBZEdYdVliL0NXRkpQNDdlVTNPQTNBcjJsbWJIelQ1b1VjY2ovY25VY0l0?=
 =?utf-8?B?eGpYSG13MnE0WDc5UGZsQ1hHL1dCcDdQZUR3ZWJGejR3RDJFOHJkNlU1eGRB?=
 =?utf-8?B?OHpGeHpSOTJrMjBVT3ZaRkovZkZrbXk5Q0RTZld4QXlrbnRidWZPaHdoTzZJ?=
 =?utf-8?B?VDRxa00vS2NKbkFOUmVUNFA1QldHMzN4Z0xYMGRyczE2MzRTWU5taHlmZGQr?=
 =?utf-8?B?VkoyUFVmRnZtdXc4T0ViQVBhWlZtQXJlN1lYVk5venJtc3I2RmxYcTNhdjgr?=
 =?utf-8?B?dUM1QStYT2JvRk9LUyt5dzJ5T3U0TUFydWVCRWR5NXlaMlhMdDU3UlJzdTds?=
 =?utf-8?B?RWRkQmdsYjgvVW92elcya1RtejR2YmhJTFBlTmRLK2xSNjR2T3lpN0c2RWY2?=
 =?utf-8?B?Y1FpMVBjNSszUHo3TDlERTN4QlpaeEtGMnlwK0JwaVZHSG1kREZjTzhwWGJk?=
 =?utf-8?B?Wk5BR1Z0SUxLWFdycWlYS2czOXozd0wrc0lGV3pIcE1vdlkwMmhkRHNzS0Ex?=
 =?utf-8?B?QVpLcDVsMGYxQ0tyUjVtM3BLUFpFajNTbTZoV2ZKUWcyRElBbGdjZExNR3pP?=
 =?utf-8?B?eFRoODI2QnBaOUpRQU53M2lJYllDM1pRS0prNEUzZzh5aFpQY2NEcXRmajF2?=
 =?utf-8?B?Y2dKdVN2TytJbUtQbi9tZHNOTC9wQ284NTNvdGlmbi9nMHE0MHRYOTYvajF4?=
 =?utf-8?B?Q2djZ3Qxb3Y5RTB4TUxJVy81d25WRGpjUG5uTERPV0cyN2NFSndvdTYybDFP?=
 =?utf-8?B?N3FySyt4V0JWNW5xMEdjamNhQ1ZCaThxNDBtSkRwbkZkcFV3TnRPV2ZkcGpK?=
 =?utf-8?B?cEdJdEFCZG9hZjE4VFZkNktwREZaZnVCWEZBc2lsYlBSYnlVNW5sZnJIL0lT?=
 =?utf-8?Q?CqrBnAp7i+bNz+Vp0EzXARxwI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4fdee3-4d93-4f0f-dc64-08de133539d6
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 19:40:45.9005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +h7G81l1K3typ/9vSdF+FrtDQNbXA7woe9ArlMvZZXitiV1LmVrx+sJk4NCOj4kAjtseS8cl7Mxy6tPjmfQ+Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8923



On 10/24/2025 5:25 AM, Alejandro Lucero Palau wrote:
> On 9/26/25 22:10, Dave Jiang wrote:
>> On 9/25/25 3:34 PM, Terry Bowman wrote:
>>> CXL Endpoint (EP) Ports may include Root Ports (RP) or Downstream Switch
>>> Ports (DSP). CXL RPs and DSPs contain RAS registers that require memory
>>> mapping to enable RAS logging. This initialization is currently missing and
>>> must be added for CXL RPs and DSPs.
>>>
>>> Update cxl_dport_init_ras_reporting() to support RP and DSP RAS mapping.
>>> Add alongside the existing Restricted CXL Host Downstream Port RAS mapping.
>>>
>>> Update cxl_endpoint_port_probe() to invoke cxl_dport_init_ras_reporting().
>>> This will initiate the RAS mapping for CXL RPs and DSPs when each CXL EP is
>>> created and added to the EP port.
>>>
>>> Make a call to cxl_port_setup_regs() in cxl_port_add(). This will probe the
>>> Upstream Port's CXL capabilities' physical location to be used in mapping
>>> the RAS registers.
>>>
>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>
>>> ---
>>>
>>> Changes in v11->v12:
>>> - Add check for dport_parent->rch before calling cxl_dport_init_ras_reporting().
>>> RCH dports are initialized from cxl_dport_init_ras_reporting cxl_mem_probe().
>>>
>>> Changes in v10->v11:
>>> - Use local pointer for readability in cxl_switch_port_init_ras() (Jonathan Cameron)
>>> - Rename port to be ep in cxl_endpoint_port_init_ras() (Dave Jiang)
>>> - Rename dport to be parent_dport in cxl_endpoint_port_init_ras()
>>>    and cxl_switch_port_init_ras() (Dave Jiang)
>>> - Port helper changes were in cxl/port.c, now in core/ras.c (Dave
>>> Jiang)
>>> ---
>>>   drivers/cxl/core/core.h |  7 ++++++
>>>   drivers/cxl/core/port.c |  1 +
>>>   drivers/cxl/core/ras.c  | 48 +++++++++++++++++++++++++++++++++++++++++
>>>   drivers/cxl/cxl.h       |  2 ++
>>>   drivers/cxl/cxlpci.h    |  4 ----
>>>   drivers/cxl/mem.c       |  4 +++-
>>>   drivers/cxl/port.c      |  5 +++++
>>>   7 files changed, 66 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>>> index 9f4eb7e2feba..8c51a2631716 100644
>>> --- a/drivers/cxl/core/core.h
>>> +++ b/drivers/cxl/core/core.h
>>> @@ -147,6 +147,9 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>>>   #ifdef CONFIG_CXL_RAS
>>>   int cxl_ras_init(void);
>>>   void cxl_ras_exit(void);
>>> +void cxl_switch_port_init_ras(struct cxl_port *port);
>>> +void cxl_endpoint_port_init_ras(struct cxl_port *ep);
>>> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
>>>   #else
>>>   static inline int cxl_ras_init(void)
>>>   {
>>> @@ -156,6 +159,10 @@ static inline int cxl_ras_init(void)
>>>   static inline void cxl_ras_exit(void)
>>>   {
>>>   }
>>> +static inline void cxl_switch_port_init_ras(struct cxl_port *port) { }
>>> +static inline void cxl_endpoint_port_init_ras(struct cxl_port *ep) { }
>>> +static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>>> +						struct device *host) { }
>>>   #endif // CONFIG_CXL_RAS
>>>   
>>>   int cxl_gpf_port_setup(struct cxl_dport *dport);
>>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>>> index d5f71eb1ade8..bd4be046888a 100644
>>> --- a/drivers/cxl/core/port.c
>>> +++ b/drivers/cxl/core/port.c
>>> @@ -870,6 +870,7 @@ static int cxl_port_add(struct cxl_port *port,
>>>   			return rc;
>>>   
>>>   		port->component_reg_phys = component_reg_phys;
>>> +		cxl_port_setup_regs(port, port->component_reg_phys);
>> This was actually moved previously to delay the port register probe. It now happens when the first dport is discovered. See the end of __devm_cxl_add_dport().
>
> FWIW (other people not going through my discovery path :-) ) Dave is 
> pointing out to his patchset for delaying port probing and now applied 
> to next.
>
>
> Terry, any estimation of when your next version will be sent to the 
> list? My Type2 patchset is dependent on yours, so I'll be reviewing it 
> as soon as you do it.
>
>
> Thank you
>

Hi Alejandro,

It will be early next week.

Terry

>>>   	} else {
>>>   		rc = dev_set_name(dev, "root%d", port->id);
>>>   		if (rc)
>>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>>> index 97a5a5c3910f..14a434bd68f0 100644
>>> --- a/drivers/cxl/core/ras.c
>>> +++ b/drivers/cxl/core/ras.c
>>> @@ -283,6 +283,54 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>>>   }
>>>   EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>>>   
>>> +static void cxl_uport_init_ras_reporting(struct cxl_port *port,
>>> +					 struct device *host)
>>> +{
>>> +	struct cxl_register_map *map = &port->reg_map;
>>> +
>>> +	map->host = host;
>>> +	if (cxl_map_component_regs(map, &port->uport_regs,
>>> +				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
>>> +		dev_dbg(&port->dev, "Failed to map RAS capability\n");
>>> +}
>>> +
>>> +void cxl_switch_port_init_ras(struct cxl_port *port)
>>> +{
>>> +	struct cxl_dport *parent_dport = port->parent_dport;
>>> +
>>> +	if (is_cxl_root(to_cxl_port(port->dev.parent)))
>>> +		return;
>>> +
>>> +	/* May have parent DSP or RP */
>>> +	if (parent_dport && dev_is_pci(parent_dport->dport_dev) &&
>>> +	    !parent_dport->rch) {
>>> +		struct pci_dev *pdev = to_pci_dev(parent_dport->dport_dev);
>>> +
>>> +		if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
>>> +		    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM))
>>> +			cxl_dport_init_ras_reporting(parent_dport, &port->dev);
>>> +	}
>>> +
>>> +	cxl_uport_init_ras_reporting(port, &port->dev);
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_switch_port_init_ras, "CXL");
>>> +
>>> +void cxl_endpoint_port_init_ras(struct cxl_port *ep)
>>> +{
>>> +	struct cxl_dport *parent_dport;
>>> +	struct cxl_memdev *cxlmd = to_cxl_memdev(ep->uport_dev);
>>> +	struct cxl_port *parent_port __free(put_cxl_port) =
>>> +		cxl_mem_find_port(cxlmd, &parent_dport);
>>> +
>>> +	if (!parent_dport || !dev_is_pci(parent_dport->dport_dev) || parent_dport->rch) {
>>> +		dev_err(&ep->dev, "CXL port topology not found\n");
>>> +		return;
>>> +	}
>>> +
>>> +	cxl_dport_init_ras_reporting(parent_dport, cxlmd->cxlds->dev);
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_endpoint_port_init_ras, "CXL");
>>> +
>>>   static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>>>   {
>>>   	void __iomem *addr;
>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>> index 259ed4b676e1..b7654d40dc9e 100644
>>> --- a/drivers/cxl/cxl.h
>>> +++ b/drivers/cxl/cxl.h
>>> @@ -599,6 +599,7 @@ struct cxl_dax_region {
>>>    * @parent_dport: dport that points to this port in the parent
>>>    * @decoder_ida: allocator for decoder ids
>>>    * @reg_map: component and ras register mapping parameters
>>> + * @uport_regs: mapped component registers
>>>    * @nr_dports: number of entries in @dports
>>>    * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>>>    * @commit_end: cursor to track highest committed decoder for commit ordering
>>> @@ -620,6 +621,7 @@ struct cxl_port {
>>>   	struct cxl_dport *parent_dport;
>>>   	struct ida decoder_ida;
>>>   	struct cxl_register_map reg_map;
>>> +	struct cxl_component_regs uport_regs;
>>>   	int nr_dports;
>>>   	int hdm_end;
>>>   	int commit_end;
>>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>>> index 0c8b6ee7b6de..3882a089ae77 100644
>>> --- a/drivers/cxl/cxlpci.h
>>> +++ b/drivers/cxl/cxlpci.h
>>> @@ -82,7 +82,6 @@ void read_cdat_data(struct cxl_port *port);
>>>   void cxl_cor_error_detected(struct pci_dev *pdev);
>>>   pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>>   				    pci_channel_state_t state);
>>> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
>>>   #else
>>>   static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
>>>   
>>> @@ -91,9 +90,6 @@ static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>>   {
>>>   	return PCI_ERS_RESULT_NONE;
>>>   }
>>> -
>>> -static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>>> -						struct device *host) { }
>>>   #endif
>>>   
>>>   #endif /* __CXL_PCI_H__ */
>> I think this change broke cxl_test:
>>
>>    CC [M]  test/mem.o
>> test/mock.c: In function ‘__wrap_cxl_dport_init_ras_reporting’:
>> test/mock.c:266:17: error: implicit declaration of function ‘cxl_dport_init_ras_reporting’ [-Wimplicit-function-declaration]
>>    266 |                 cxl_dport_init_ras_reporting(dport, host);
>>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>>
>>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>>> index 6e6777b7bafb..f7dc0ba8905d 100644
>>> --- a/drivers/cxl/mem.c
>>> +++ b/drivers/cxl/mem.c
>>> @@ -7,6 +7,7 @@
>>>   
>>>   #include "cxlmem.h"
>>>   #include "cxlpci.h"
>>> +#include "core/core.h"
>>>   
>>>   /**
>>>    * DOC: cxl mem
>>> @@ -166,7 +167,8 @@ static int cxl_mem_probe(struct device *dev)
>>>   	else
>>>   		endpoint_parent = &parent_port->dev;
>>>   
>>> -	cxl_dport_init_ras_reporting(dport, dev);
>>> +	if (dport->rch)
>>> +		cxl_dport_init_ras_reporting(dport, dev);
>>>   
>>>   	scoped_guard(device, endpoint_parent) {
>>>   		if (!endpoint_parent->driver) {
>>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>>> index 51c8f2f84717..2d12890b66fe 100644
>>> --- a/drivers/cxl/port.c
>>> +++ b/drivers/cxl/port.c
>>> @@ -6,6 +6,7 @@
>>>   
>>>   #include "cxlmem.h"
>>>   #include "cxlpci.h"
>>> +#include "core/core.h"
>>>   
>>>   /**
>>>    * DOC: cxl port
>>> @@ -65,6 +66,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>>>   	/* Cache the data early to ensure is_visible() works */
>>>   	read_cdat_data(port);
>>>   
>>> +	cxl_switch_port_init_ras(port);
>> This is probably not the right place to do it because you have no dports yet with the new delayed dport setup. I would init the uport when the register gets probed in __devm_cxl_add_dport(), and init the dport on per dport basis as they are discovered. So maybe in cxl_port_add_dport(). This is where the old dport stuff in the switch probe got moved to.
>>
>>> +
>>>   	return 0;
>>>   }
>>>   
>>> @@ -86,6 +89,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>>>   	if (rc)
>>>   		return rc;
>>>   
>>> +	cxl_endpoint_port_init_ras(port);
>>> +
>>>   	/*
>>>   	 * Now that all endpoint decoders are successfully enumerated, try to
>>>   	 * assemble regions from committed decoders


