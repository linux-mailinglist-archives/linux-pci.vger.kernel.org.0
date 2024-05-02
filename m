Return-Path: <linux-pci+bounces-6996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BEC8B9825
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 11:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549C91F2120C
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 09:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1487355C0A;
	Thu,  2 May 2024 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h89sxoQh"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3F554903;
	Thu,  2 May 2024 09:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643704; cv=fail; b=l9Y0cSEapRS30ZH5mIM7e3FS1/vT7seT2IXohpCyejfrXNIthdFMV66NVm75cSUojidtHq1SwtsvIPHse5d289nJebfoscjD3HEN8nwfRzCGxm6A7zUb26Jwmoul/m6mzRlIeOjeLjJ6LQyQMnM5hibBot4gnK+wd4Qt6TMSrdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643704; c=relaxed/simple;
	bh=cGrmtM/pvweRUclZhCyteU+eM/h2QlsT8uwpxg1KpGw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TcWJXC0JrSmt2JqDOL56M2K+RnYUqlmwk0QhkXxXE7avdeTjnKxD7mP7Fjw/c41BzYasBSEi9Mq2dTheOnf60jowJr2XYaMTNiRPOc7PRHn+04rUcQCmMiqR8SmwDHszM5QybFNJzlgqq1K4OtJ3yBdydgwh7r4NbEx6XA8SuX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h89sxoQh; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqGXrg2GZT3/6Y1Rdpg2NiNd6yLnmerRlZpwn+1jAqPSF1TQwEV13fFETMxGeuMFJO8jf/pWmIKnltaoA+S5uXkG1zTmIbumQgvdFRvmWSPN4POLyKT63AYECP1ZF5pBQ5V8mzeTPXGydvSvElfYCoUy3PU81c1zazbWNTrXhnAdoFeUv+dYuC15Mqb9wrq0JHIvYG/75UFgvuQ02mMvJLIyNk9V/MWFt795iJiXiKTXDUNxSU9Tnv3TAfXIOeZ4/fDhdW9hCuYR4WJDb+RuWo6yFPRk5nrUGAFTwT7KO6jxFUEOIYLOkyp7U70AcJGfZZjttaizoz9Fspva/s4uQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBSfYHIcFU9bcEmOtjp/Olrn2UBkrsNcqFsBtFMVKio=;
 b=lKNqn9ijjgsL3TIdnJsEEGoRWkPxUKssj/ZpWBOS6+AFmrnMPITWqVS3xTE1wNpx9Jqsd2hZF1RC4+ZozkpIvg1jiKQIsyBn9kyJUIGSKD+Z9y/XDN7hgAokFeh2S0CPUPQs3i0qjZ5AiYfFPVo/QhTI144LQGcPGTrQn19RaEk9z1OG8aNhAozABnq+65OLcq6jhGuw4C+yd2fdHEI39NRjo5BQ/CkXzPXC172Reg436fJm+8E5TyjooPqZfb3ofG4ZLfutLl/HrkiOT3qbbapVQj5OlbuRRkz4ONQnsWB7jMxLBYnkJ5TENCTZmYJvPYjzI+9GpF6YSvm55ftIQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBSfYHIcFU9bcEmOtjp/Olrn2UBkrsNcqFsBtFMVKio=;
 b=h89sxoQhPGC7Y58U+G609RDNTaEx+ZA1uhQYwX6CFwhbh/13OKj0o0naeXwYErksXsMeupmZrUGQ67fwOXjxRDNGpEfdzOZ6UAXIghtHBHqMzZPSY3WYsBwOCSSRLGcinhvvxwe/tvwhmTBzyT8ncFZSuPLksnQWhL1nrpZETJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8884.namprd12.prod.outlook.com (2603:10b6:a03:547::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Thu, 2 May
 2024 09:54:59 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7544.023; Thu, 2 May 2024
 09:54:59 +0000
Message-ID: <0f83698e-dca8-4296-b969-fdacda39fec7@amd.com>
Date: Thu, 2 May 2024 04:54:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Esther Shimanovich <eshimanovich@chromium.org>
Cc: Lukas Wunner <lukas@wunner.de>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
References: <CA+Y6NJF6+s5zUZeaWtagpMt8Qu0a1oE+3re3c6EsppH+ZsuMRQ@mail.gmail.com>
 <20240419044945.GR112498@black.fi.intel.com>
 <CA+Y6NJEpWpfPqHO6=Z1XFCXZDUq1+g6EFryB+Urq1=h0PhT+fg@mail.gmail.com>
 <7d68a112-0f48-46bf-9f6d-d99b88828761@amd.com>
 <20240423053312.GY112498@black.fi.intel.com>
 <7197b2ce-f815-48a1-a78e-9e139de796b7@amd.com>
 <20240424085608.GE112498@black.fi.intel.com>
 <CA+Y6NJFyi6e7ype6dTAjxsy5aC80NdVOt+Vg-a0O0y_JsfwSGg@mail.gmail.com>
 <Zi0VLrvUWH6P1_or@wunner.de>
 <CA+Y6NJE8hA+wt+auW1wJBWA6EGMc6CGpmdExr3475E_Yys-Zdw@mail.gmail.com>
 <20240502043832.GG3969176@black.fi.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240502043832.GG3969176@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0152.namprd13.prod.outlook.com
 (2603:10b6:806:28::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f92f9b-7b3f-41e7-9100-08dc6a8dedf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3hGbEltMFVXZVh6MURTMGJBS0Z5emZXY3N4UjdQeXBtTi8vZDZRSXZLeE8x?=
 =?utf-8?B?cG10NXoxWEZYUjk0RkFPTXZNVnFxdDdSWmI2bmM5WG1rVTJCVWtEY1prSFN3?=
 =?utf-8?B?eE5YaHFJRHpjcTA5eXhFd2ZoRDgwMTM4MVcvdEtoWktuSkpkLzMzdER1bjBh?=
 =?utf-8?B?TXVlNEpYSTA4UkF6Syt6UVJoeTNkOU14c3ZlR2c1WkErWXJHNm84aW1ZbGI5?=
 =?utf-8?B?Yjg3UkwraklLK1U2WnZ0N2tJbW03YTRieDhiK1ZWZThjMDJaY3FqTjNKYWZq?=
 =?utf-8?B?WUdEZFlVakI4akJ5djE1R0RXT2dDKy9CZVVaVzl0Tml4M0hMYUF6MkpRQW5D?=
 =?utf-8?B?NkxDZEhpaGtZTjh2VVdvN1VKaVdCWHJoS0NWZnk2QXpjVWVjMFB2UkUzU1NT?=
 =?utf-8?B?c3JzMFlRMTcwQmcwVTVYMC9VVU1LNStWL2NNWE9YYm9LZkFwaUkwYUF3T1RP?=
 =?utf-8?B?aTk5Zkxtb2pXRVE5VHBydW1INWt6a2dOV0VlaUZJc2R4NHdEZm1xenFtbFBs?=
 =?utf-8?B?aWlrZ0w2WC9raFVSY0tiME5YUnM1SkRLWDdBNWNHeHNMYVhNNTRlRm5kSUsr?=
 =?utf-8?B?TGdnWGp3ZG9aeGFVUktHTHRuS2o2OEdHSlNDTU5GT3dDL1l2OGR2c1BWZkVL?=
 =?utf-8?B?c1J3S2ExNGNNbkNjODlYUlhnc2tpTklSb0RTWHJxTlhhT052MTdscW5qMzhx?=
 =?utf-8?B?OU8vQmFSNW8vMmQ1TWpTelhoSGtxcHoyZUgwMm9KKzdqQjdldE5QK0VBV2s1?=
 =?utf-8?B?NTVEVjlsWjJ0blRLbXNkNjlhYi9ZbXNHVmZVOWNYZGI2TSt0SlV3NTgvZ2da?=
 =?utf-8?B?UHZTaS8rS1psbVhVSExPaXFIOEdOdGZiUEIzSzFwaU84UVI0ek9kZk5EWndW?=
 =?utf-8?B?YUNiUFNKYndZc1pUWUVKem92SVJIemFjQ1A0cktaY1p5Rmd6ZnZPVXZxMk55?=
 =?utf-8?B?bEg5VWJZWmpick5JUzVrWUcyQ0lzODBxMWhUTm1rTnNiZ0p4VS9MR1VrN1VO?=
 =?utf-8?B?LytOc2QvQVU1SG81VXpvVGppeVdMeEpPV3hiTXZvYXd6U1NQVVJoNVVSeXBT?=
 =?utf-8?B?TXZNaXdwTG5zTDMraW1PUVBRUGtINVFNN1VWSzgvekFMN1NGZGxpU2JqQUow?=
 =?utf-8?B?YXUrRjJGVzBEWEdRd0pRckdZbHdtWGlibCtmWGJrYTdFSHIxZjU4KzdzYVZM?=
 =?utf-8?B?OFgwemhRZXVMdHZnK0xVa3JxdG1aWEYyODUyajF4cjNERkJ4dEFpSDEyVjM2?=
 =?utf-8?B?Mm1HWGxINElSM2pYYytKK3UrQ3h6VXRXNjFWdjNDeDZDU0FBME5MamowMm5o?=
 =?utf-8?B?Ry9oeFJYQ3RzeDFhS0R0ZWpPU2pDSGFsMWloY3VmWURaTFlBdzYranN2eEJJ?=
 =?utf-8?B?Ymp2cGNteEkxaE9WQW4xVkNqQ3BNNmxFNjN6c2NNUzQzMlZvcXk0OEFJZG5E?=
 =?utf-8?B?dEVMOFd2aWgyaW1xM25UTHk2SXI3THNGUEVLYnVlclU1VGFoeWgxVGNlcldR?=
 =?utf-8?B?R2R1Sys4T1drdXI3bVprUVZGZFIwamJnWTd3WWNacFhsN2p0MXRybjh1U0l0?=
 =?utf-8?B?NGNEcGVBWE1jUlhOVTFPOHBnUHcwd3hlVzBFRGpZT2VDdzEzS21sUDNJRnJM?=
 =?utf-8?Q?Wn4U1Kr4hvlgawHlxXYj9KpxRKXLCCSqXFemAupvh0Ag=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHJ0SGVka0NKU2NkWm5VTURyR3RYall3bjhYenNROWRnK0JtUjFNckhXbU1N?=
 =?utf-8?B?MEFabzlRQkNzaHg4Wi9pQ3VIZEhNa0JGd012K2RTNUFad1hwbklGYllSNS9l?=
 =?utf-8?B?bUpndXVNTG1ZN0tJZ1B5Nk12NkM3bnRtaWxieWVjMU9uZnpiNzB4YmRkTTR2?=
 =?utf-8?B?andoaGNDQW9WZ3NMV2p0aGpTc0lDWk1MREpDVktvN2JpUUdiYVpVeXBMMkNJ?=
 =?utf-8?B?OGpQcVVkUzNVRXM0T1dsVlVWQzlTQ2szRWRzc000K0dhS0JlZU84S3hyZEhS?=
 =?utf-8?B?UDNYSEpCSGFwSzl5a1l4WkpxZjM4bXlqanY2Mm9JekJBVDZwV3JTdXhSSGxM?=
 =?utf-8?B?MmVLQjdZNWg5c0pLWW83RXBBTEw4a05NajU5ampxWlJmNUNhWDl1WWdwR1ds?=
 =?utf-8?B?bXZMZ2JBeVZCczRRdksvVkZGaGYxOUpQQ0pJUzhLejNyem9aUVA5NU1xSlRv?=
 =?utf-8?B?SU5jVzdQaVhFNDM4S3YwUlo5OElMM1pSSWF0NEgwUDljVXVaQW9SamVySjQ0?=
 =?utf-8?B?bVN5aEpwU25Zb0xpYUpGZWpwMzNVckhQSEpySVV5VDN6cDFmT25RKzZtOW9R?=
 =?utf-8?B?WkFuM2RKZ0lHTTVvUE9kZWJobVVyNThHS28rQURWcmxvY05uOXloYS9tQ1pD?=
 =?utf-8?B?Ni9CU2lpSHpjbmg3UzVBK1h1cmUwZEhOd0MrUkQ2d1B0L1JaY1lCekJ1bmpk?=
 =?utf-8?B?SlBJa2pUaG9TOXBYTm1DbUhaNlZJLzlRM1JBUXRJVUJ2WnErcGpNSi9OV1g4?=
 =?utf-8?B?eXBLN3NmUFlDMDZyeUtQQWtrM2tuL2lzM1FwWWZ1SllvMS85aVJaS0Z6UG5P?=
 =?utf-8?B?YWFKTllqYVFyN3I5YjA1YTlrMnJoSTE5cmZRL1lJRHZXcDNFTnFzcGZOdXpL?=
 =?utf-8?B?YzFHdmdxZ0lvVWZhT0FsYWtwK1pVY1ROQVBscDd4b2dhQ3I1TVVMVVBwTVUz?=
 =?utf-8?B?S0xJTXluVWc5QWlxMXhOYTF4eG14Q1p1L2U4d2p3QUlYekh0emxXU1hrQU8x?=
 =?utf-8?B?U1VBU3VsVHh4MDhMV1hqNEJSMVA5RVhzVEdpejRtb1QxbG9DOHlvMVdLNkE5?=
 =?utf-8?B?bkdmTjJYTnkzQUV4M2E4U05JVzZHZm5wMmNaNlpuMlIveHNWdFlDY0JUS0JF?=
 =?utf-8?B?RFVBNGlMaHh3YUF0TENwQ1pOaVBHWE5qRkVOU2VybHpTdkhodUNsZ0tQc1Zw?=
 =?utf-8?B?K3VFRUhYTW90YWRRUmVrcUNTcFF3dzBvUmcwc2FRVkhuOUVQSFdqNVdwcFhL?=
 =?utf-8?B?U3VTTHNhZmx2QlBPc3VHME9IUEhDY1I2bUgzdDQweW5BUU9Jbi9lZGR5bE5t?=
 =?utf-8?B?TEpWNy94ZW9rN3A1NCtEWVJYQVlpTDZXY0RINGJKVlhINGFjZ2VZM1BVOGRn?=
 =?utf-8?B?TW9sMlhwaXhoU2sxLzhoZnJQaEVBSTRLYjdLeGh2REMvOHYvUzRuemErM1F5?=
 =?utf-8?B?enl6WkNUcEltRHFuVjNWSDJ5WENLMHF4RkpOM0Z0TDRoWWsyaUVOQkFlUGd1?=
 =?utf-8?B?NThNaWxrVUJ1ZWFUWE5IcHJaRFJ1aysydktuTlVuY3U3ejVXRTI1NytCT09s?=
 =?utf-8?B?VkxvSWZwdEdGeU8vdWVyQTdoUXY5RXJJa0dzQVl0K1QzT3pocDZUS1E3cWVS?=
 =?utf-8?B?REExQWFQbitGQjVBcjA4M0xzYkVXMlkrMEVqSE0xNzVDZGhnNDVVSkt1UURC?=
 =?utf-8?B?YTNjN3VTZkpkOTMvS3dWaEQrY1d1cURwSGhUa2JCcUtaWk5WdE55NFhZVGc1?=
 =?utf-8?B?d1FXTEhHQlNDdjNoR1J2QVZ0ZzNOY0EyWFNNU2c5UmFwcGlQTDd2K1FYZEtu?=
 =?utf-8?B?ZjZuc1pUck1OcUxzS2dBL1Urd2k1cEJSbk9QeUJSTzZLRDRSczNCRVIrNndT?=
 =?utf-8?B?Q1FjcDI4cVVLRUdjS3RqVk83ZUFxcU96SkdvTUc2MFVabHZjaUVsOW96THJN?=
 =?utf-8?B?VzZNRmRSY0V5VE8yK1ViVmJUT0RXZWs4eHZwRTJiSGZXeWtIQmF2ZXl0eGVk?=
 =?utf-8?B?MGFpc1dpTjNJb3pYaDhCN2xEWkZjWFIwbHB6RGxJbHhicDJGQkNMTHF5L0R2?=
 =?utf-8?B?YWdDTWlobU9NZjVuanpFbWhoUFhMNXFocERsZk11cEhHLy9mSUdvWlBEMWtQ?=
 =?utf-8?Q?Fho78pUhjfR4tMPt1R1nZXadf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f92f9b-7b3f-41e7-9100-08dc6a8dedf7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 09:54:59.6365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSRQWPXzDLCpHykxx6fUUinQUIg7I4qx4k7HudB5wI48cs49XKUJPNgY5jmkWtIMjIuzXU/7DPZgdA7t4FT+sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8884

On 5/1/2024 23:38, Mika Westerberg wrote:
> Hi,
> 
> On Wed, May 01, 2024 at 06:23:28PM -0400, Esther Shimanovich wrote:
>> I don’t have this device available at my office. I just saw that
>> StarTech sells a universal laptop docking station with chipset-id
>> Intel - Alpine Ridge DSL6540. Then I looked up the device, and found
>> it here: https://linux-hardware.org/?id=pci:8086-1577-8086-0000
>>
>> Therefore, I concluded that the DSL6540 has an NHI component.
> 
> Okay understood. Yes Alpine Ridge can be both host and device router. In
> device configuration such as the above it does not expose NHI. If it is
> host as in the above list you shared then it includes one.

There are different PCI IDs for AR for host vs device though, right?
But I guess that could technically be spoofed.
Is there a fixed PCI ID for the RP used to tunnel for host AR?
If so you could special case that anything connected to that PCI ID for 
RP used to tunnel isn't trusted.


