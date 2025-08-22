Return-Path: <linux-pci+bounces-34595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6117B31F0A
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 17:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633CD646644
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 15:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907F6255F3C;
	Fri, 22 Aug 2025 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LvuQ/p6z"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5BB230BE1;
	Fri, 22 Aug 2025 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876793; cv=fail; b=S78uRaySL+uPDnn8q2JgPHnCUgDTDoi3VbbcOxCoioGZ3kSrjuT9aEmwfUGuf263FY69aiC4XXMvOSt81cRbWLBFML6A+cseCMweJwbABhPJD6MEMi2jYYZUVZgBFn5rdnfuyCCLXnqXz3Z7DZ4ng4QlMu1dZkKPd/viNstGuFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876793; c=relaxed/simple;
	bh=O+wCaH9Wdfnv9Dgqtoe/vfLdpyoZ/scJj7qOYlEJW/Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=So76muj9ZB99Uvh3Sv3IFeQjdnRYkaqfS/ZOBQy4+DmQhZ4UgWBkQCExut8ABhIeW3C8HoMcFfzh/D9WYzizaxiRr9nE7F4vWAKchSq9LAAVnGvapnAHniOMeiYYKZRK2RPya356cpij3AfuxDZFwpg8HIvPBg0jcxf1TYpPoqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LvuQ/p6z; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/1k8HvrrdFkdL3Ag7Mg8CI28H8j7+tkFfIwJElJP7blIZj26eV249AZ+wO5rPdG1ThRWniV+d3Ri7sFV84jD92n8YvKzBdU+7MDC1JA5wgTfOXjpdlM9a12Xj5YeT9PrB9kCdmILKchLaQAGa3hF6fq4S8d0EmfMAJZMYvY3v8t/5J0KBPQgsa3seFW/8Kt662wjmVVdUZsudWwe6Oq/qkv8++RNMnembKjW9rm7vAqk7xZFIMewyJkGCTegkhlpsNW0zy6OeelXySdogeg2dgxdjGrxBjLtqWaelm6QHG7NklXXdcEsvwcu7U6PITsxH+jnxljLYdjFXlkR8Z/iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMCGuYc7CBglY1ECjXurKeAEf78L+ageH9uTK6LqIks=;
 b=RUrR0oT7AR7EjXKMJAcMiD51GESn0m2RpoErdXa8ror43tiboB+pjNntCuNG/cIRsQ7Nz/syLvMHaUZkhdsTZZjisfUNaMG5xR7+67NoN6GOZ80c5ZGB+2KtMOo9GJ1CsiuEZV19lf2VbiqdCir+wPOX0yd5HeWYawzEEDI1SKdUMulH7WjiwhRGyb+UCNGdixHmT9G5WpDYBhpF7tI1iunjcPQw23ekQMFCm6yZPwCYQCQrwXbd2wRJ/ND28Xo47EQpQhQ9YaSBdeg8rpdSsch8htrbOTANguQv4y5W+qxQWh/ZhfLIYQcSTkJybb4rZiKUPlIe5A/le9KHOI/WXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMCGuYc7CBglY1ECjXurKeAEf78L+ageH9uTK6LqIks=;
 b=LvuQ/p6zawCEYFMemCRBUpQV3ZTvvHQqpQXykpF+68P5hJlu7karoxCaNq3wFI4SG3Tvhadyyofaetg096Mq5KHoIb2dLRv8k54i0g7WHZbZ0Uj7LCrN7jnsQAwv9eFqx7PoZkYU/gn3h37lCXtM0MDLYCNdb7Ne5XXtKxKSEPs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ0PR12MB6758.namprd12.prod.outlook.com (2603:10b6:a03:44a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 15:33:09 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.9052.013; Fri, 22 Aug 2025
 15:33:08 +0000
Message-ID: <f90ba985-5cfb-4714-bbab-17de471a7332@amd.com>
Date: Fri, 22 Aug 2025 16:33:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cxl: add support for cxl reset
Content-Language: en-US
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Zhi Wang <zhiw@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Shanker Donthineni
 <sdonthineni@nvidia.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <Z7hZZNT5NHYncZ3c@wunner.de> <20250222001321.GA374090@bhelgaas>
 <SJ2PR12MB79630812834531324D148DB8C3AA2@SJ2PR12MB7963.namprd12.prod.outlook.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <SJ2PR12MB79630812834531324D148DB8C3AA2@SJ2PR12MB7963.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0257.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::29) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ0PR12MB6758:EE_
X-MS-Office365-Filtering-Correlation-Id: e009eba9-f432-48b5-7abf-08dde191320a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2RhR0xsR1d3M1dmd3hIMkJLRHdaRjV4RmFKeEVTYXZWUVc0MmREUTNoQVJ2?=
 =?utf-8?B?WHB2cWFBcC9HQ2I2TFJyZ1dpN0d5d2N5SFYybjVRajlDK3ludVF1eVo0TnRT?=
 =?utf-8?B?aWo1QVhiblNLZjdvY29XaUlSWjVWOUwxS1VkV1A0WTZGVXhvUDQxM2gxUGZC?=
 =?utf-8?B?ODVzanh3b293ZGZGRU1EdXUvd3hsUWJTSDhCblJGWWk3ZGU3ZVlRSlJTTlo4?=
 =?utf-8?B?N041aFZiZEFmQStnTFlQRzZreXNIbHBzWW8vZkdWRkZ0TisvcmJ2bTR2TFI2?=
 =?utf-8?B?TmpXclVCRmZqdFlsMC9XSnBiUnNYQmZSN0YrdCtZR094Q2svL3FEQkt5d282?=
 =?utf-8?B?d0xoczlSTTZ5dDg5SGhpbXhTZGcvcnExbUF4cmpmN2lFcVhISnhUUUcwTUh5?=
 =?utf-8?B?dUJUdmE3NEtkS1pBMEE4bmo0S2tPUTR5SDdlRm1OSksrYkk2RkU4emNwZk5m?=
 =?utf-8?B?R3JGcktwL3pWQkpqL01Ba3ZIT1FVcHFNSndJN09GdmpKdW5zU0FYWDBpWVZZ?=
 =?utf-8?B?NlJ0Mjczc0c1Z0VBODZZUWVzQ1dxaGpFSUdZSVcxVmh0ZXVKNGhEWWRlVVd1?=
 =?utf-8?B?QUtKNE84aHNzVzNQbEN2c3RFWXdIelhmd1puR1d1RlgwQWEzb0NqUVR5ZFhD?=
 =?utf-8?B?dFlQWnpiRCsyM3JpNVFpZGZzeldvbUdLN1EvcEExQVRZL2R0dm4zUXJkRUdr?=
 =?utf-8?B?Ri9JYkhSbWRXSnNSMHFsRFNwc2xRYmR6UHVIWEVUVnlGa1k5WUpLU2tCZDVX?=
 =?utf-8?B?UGNaOWlLWkRPYlRIME1ZbVU0V3dQMHo5TUM3K3VTUVUxMjVDUURuY1YzSUNs?=
 =?utf-8?B?NEJUTGtlZGZISXMvTmZDY1NZWHZmdU51cFM5UmFHV0ozNzV1Y2FCK2c2YmlJ?=
 =?utf-8?B?U0tVOXlRNUdISkpVRlovRUZ4VU8rS05OTWt5RTM2NFlSek9QTTc1a3ZvaThM?=
 =?utf-8?B?c3ZCNVNQV1k3ZUVKNEVQYnZIejBXUWxBZGdxSU85aDJjZDl6dFdlMm1XVkh3?=
 =?utf-8?B?TEVOZXU2dEpTaGNkUEtwbjAyTnNpYm1RbmhuRVVQVC83UWRjdlpRcFF2OENo?=
 =?utf-8?B?NDZQVzQ4S3J4NG53T0JsSG9FU0Y3VkNCR2RlQ3ptTnhINUlBNWNoTTRqZ3FC?=
 =?utf-8?B?eVE5bzREMjh4UHlRVDFTT2sybFFEVmVqTTVRTUhvRmsrNnFqMkhTQlBvZGlH?=
 =?utf-8?B?YXFJalJUaFpmN3BUQWxmWFZYcWJkSFJXNW9yclFFSnpIT29nZHV2eWNLR3hV?=
 =?utf-8?B?clFwOHVFUWg3K1lURGdxaXVRRWVEY2ZDb2xjc2VMRlNYNGMvNmd1ZjVCQ3N4?=
 =?utf-8?B?RVVOUTJCbDZlejQ1cnpFeldFTk93TWZiaFlBaUhIak10cElIMUVoemRXREw4?=
 =?utf-8?B?b1ZZa3NuYk5uVnY0bnpRcy94NmJ1d1BQbVRCakVrVWVuMmFjRG5MMmgwM0lq?=
 =?utf-8?B?NjcyeHR4MDBxYVgycnVKVnJDdFVqVk9yR0pIWlhBQkJZbEtubjNaTHpyRGpK?=
 =?utf-8?B?T2ZHaUF3Q0NGMldUTVJaeEFXZ0hZYWQ5T0puOWdsK083eXBSTjkzQkx0RUY2?=
 =?utf-8?B?L0l4UDJNeXJKSWhiOW14ZVp1U251K0I1RXhYTjI0OGNPM0NjbzNpeVFRbm9j?=
 =?utf-8?B?b0tJVkZvK3QrWUFQanBXQ204V01ZQjBoSDgyNi9QMlJDNlZXSWRIenlsY0t5?=
 =?utf-8?B?TlE5STB2OG1ncXhDUzczalpNWThuOTN2MWs1REJpUXlPd0VENEJLSnAydXU3?=
 =?utf-8?B?MXpEQkZ1bS9HY2tROFlOUjhiVWtOZWxoeHhWd0N1MWZWQUU1bHprTWMwK3BI?=
 =?utf-8?B?MmtNZW9TTmtCWEhHOUZxeEsrLzl3ak5kZjJIZ3R6Mjg2QzAxa3pEaUZVZFp2?=
 =?utf-8?B?dFhzZDZvRXgrMElUck9GbXBiOGM4Nk9kOGJ3QTBOT2h5SnBTME5RUER4MWR0?=
 =?utf-8?Q?wgDAJeDwM5M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0Z2dGZtaGYyai9XNjRub1Z1UlFRaTBvcm9BZG9LblZtRHRzcFdkN1E2UDlp?=
 =?utf-8?B?SVRXaXk2Uk41cDVielRvMjg3dnBUMTFTQXJLVzJ2bWZhRm5pQk9zYmQ3aFpT?=
 =?utf-8?B?aTFSVzQxY08zMVZWTUdMOEhQRXVYU2ZhVGNGcWk2OVkvN0l1ZE9EekxYUkhQ?=
 =?utf-8?B?WG1nTUhkanpJMjlWWXFjS2szTExQUmpXL1RDYmFGa0RxZFg5M3FvdVNLZmRj?=
 =?utf-8?B?T09mNDlwVzJRZlQ4RTVieHBuOFordjJwaTdqSFd4WVN4NWlLMGk3V0lBbW5s?=
 =?utf-8?B?YVlhS1ByeElHeDlGY1FQM0ZENElhQVE4ZlJQQ094MlUyd256dlFmbjdqaVJh?=
 =?utf-8?B?QWJWM2VNS2R4MEw1SVU4TTRKOEJaTERJRi9YSURoYkJ4bHVlcGZBeUIzaTgx?=
 =?utf-8?B?RUNiMVNabGxEVFVLWUcyVW1kK1UyQXhmcjVyTHZUQnRGSjRSQm1JYWxEenhM?=
 =?utf-8?B?QlVNNlhHcHlnZm9Gdml3YXltSkRxWWtsUUNVTzBWY0lyRDJvajBiNG56RW5F?=
 =?utf-8?B?YW81dzFuWXJnb3Nsa0JveVJqMXVndUhjdkl0czI2QjZ2MXJESG9FNEx5S1Aw?=
 =?utf-8?B?QlhOdStqb1BqZEsvbGtXTDFTMjE5a0JDZzRSc1RYam50WDBhSmlMYUFiMTFV?=
 =?utf-8?B?Z0xZQTBVNVVCV2NhbnJkd25PdUMrQ3VDekZRY1pLK2tpSmN3WGNwU2l6eE82?=
 =?utf-8?B?K011K3h1bWphS3hmbTdhRmFTNDFxTCtDRHl2U2x0RENsclYxWFQ5MEZ3NGpa?=
 =?utf-8?B?REZoUjJGYm1Jam1Vd2UwKzZaMG1GNEd1MzFuZXM1SFd6SmpQYjhvWXdhMTE1?=
 =?utf-8?B?MDkyNEFldzZaZ2tPR1cvYnlrMi94ZjVReUpydFIwN0hleVlveU5kdWd6cDRQ?=
 =?utf-8?B?ZERjMkRPK3BCeC91bFBOc0RpNmU1TGhCei9tVGFUcnNXMURXMTZOenhZWGlo?=
 =?utf-8?B?aGNCclJpRkM2a0ZzSjVVQjk2SzZCVXoxWi90YTY3VlViS2k5a1VsdjJYdFRS?=
 =?utf-8?B?NU9uQkZQZ3J2ZTQ4Q3UydXRGRjJzWWdvK3kxRnErcjBJekFtd3hDTVpRc1d3?=
 =?utf-8?B?K1BsMDdldFhHTkNRWk42RVJ1MTBlNUNGTG85YzBCOU1KM1pWOENnNlVNcmJJ?=
 =?utf-8?B?MjZLUk9tS1kreUkxb2dBMmpHV1g1TlY3TjRFL2luY3hVT1Nnd25odEVNVXND?=
 =?utf-8?B?K2lWMGFTTUZIeFU2dlJUenEvd1BFVTJNRFEzUitJMlR1WU1XT2QxNXBjNi8v?=
 =?utf-8?B?ZTQzTzVLa0lyemtOczI3RUozbFhWNlg4YzJHd2dPYnpsaUZ1V3I0OUppRXZU?=
 =?utf-8?B?S1B4Q3hPbnA3SUNOaTM2S0pNV3F2bDRzdjRXQlppZUVYOVU4YyttZEQwSnBm?=
 =?utf-8?B?RjNkNllFUDYvVkJLejhjb05wUUhweUx2OTdmeDI4WWRvMENGV0ZvMXVUa0kz?=
 =?utf-8?B?VDYxT2ZMZGxrdEJEcU50VGJKckNFMGVWVGp1Ty8zZnZUNm1DUjNlelZBT2ZV?=
 =?utf-8?B?eUQxN09PUFlOUTF3c1RMM3VMN3hOc3JnaU51ak9pd2k5cFh0a3JQV3dudGkw?=
 =?utf-8?B?VnpQOEdkUWRmb21kZlBWSkRjTDBnd1lQV0FudFNuZ2h3dG9qOGQ0eXE1MFEw?=
 =?utf-8?B?b3gwUFhRU0NGamt5RmI4NHhjTzlITGpsREFRT2s0UmdNcnkvKzVPQjRhVEFH?=
 =?utf-8?B?eEdjemVKTk9uUnMrOGJVZmMydUVBT2xqZjZxMjZ3cFM3N3Q2VER6Qlo4Zjdx?=
 =?utf-8?B?UVdyVEpnQ0lNNDZHUUFNUjJ2Y3NwYVhRekJyWHZFc2U2RENLUzFNZnZ0OEIr?=
 =?utf-8?B?Q1ZLWjA0RWdnYldKOEszQXFVUm5uSHB1NW1Pc2RHWCswOU9OU0UwMUIzZzZG?=
 =?utf-8?B?RjJPYzdIc0Z6S09oeHJRUUhhYmNJQUd6TGJhQzlYcDBpSEhuS0h1NWNZUWRn?=
 =?utf-8?B?b055bFlyZUxtM2F2TVFDbE4yc0JSNTFxRWxNU0tZTVdmOUVHRGt6MjVKdUNM?=
 =?utf-8?B?akJHT0NlYktsd2RQeU96TDNGVXdtZlYzSkR5ZncwaWxYem50ZHRRdHBPK1A2?=
 =?utf-8?B?bCtKWHI2aWVhWnM2bTJjbWZhcTYydnNZQldOMmpaQzRKRmdzQkVPNzdSM3Ba?=
 =?utf-8?Q?OzGTk+gSetZ3EWp0IXNSWSmEp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e009eba9-f432-48b5-7abf-08dde191320a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:33:08.6527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zY21Ywcynau+5MRhUbnXsAopp6MghYyt+QHPW0F2mHYDDkemnnwdZXZxVX7dqHoGxYjqpVtx7EtQllZBHJuddw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6758

Hi,


I'm sorry I missed your reply. Some comments below.


On 4/8/25 00:45, Srirangan Madhavan wrote:
> Thank you so much for the comments Alejandro, Lukas and Bjorn.
> My apologies for the late response. I was out of office for a few weeks.
> I am picking up this patch again and adding my responses.
>
>> I think cxl_reset_start after the *_prepare call makes more sense here.
> @Alejandro, Just for clarity,
> do you mean I should rename the cxl_reset_init -> cxl_reset_start?


Yes, that's my view. init and prepare are similar, so prepare or init, 
then start.


>> I do not know how safe is this. IMO, this needs to be synchronized by
>> the accel driver which could imply to tell user space first. In our case
>> it would imply to stop rx queues in the netdev for CXL.cache, and tx
>> queues for CXL.mem. Doing it unconditionally could make current CXL
>> transactions to stall ... although it could be argued the reset event
>> implies something is broken, but let's try to do it properly if there is
>> a chance of the system not unreliable.
> Regarding this, we feel that the reset framework already
> has a *reset_prepare and is called by the Linux kernel, before initiating the steps
> for acutal CXL reset. During this reset prepare is when the accel driver should
> quiesce its device. In this case, that would imply stopping the rx & tx and
> draining the queues. Is there any particular reason this wouldn't work/be sufficient?


I did not see the connection to the driver/device in the patch so I 
assumed it was not there, but after your comment, I studied the code and 
it is just a matter of implementing such reset prepare function in our 
driver, and I think that solves the problem I saw.


>> One thing this does not cover, and I do not know if it should, is the
>> fact that the device CXL regs will be reset, so the question is if the
>> old values should be restored or the device/driver should go through the
>> same initialization, if a hotplug device, or do it specifically if
>> already present at boot time and the BIOS doing that first
>> initialization. In one case the restoration needs to happen, in the
>> other the old values/objects need to be removed. I think the second case
>> is more problematic because this is likely involving CXL root complex
>> configuration performed by the BIOS ... Not trivial at all IMO.
> Here again, we think that the accel driver is the one that should be doing this.
> In our case, when the reset done call is made, the driver before making the device
> available to be reopened and used, needs to restore the config space/DVSEC etc. to
> their prior state. During the reset_prepare stage these need to be saved. Since this
> is how SBR is handled currently even in the PCIe world, (for ex. AER/EEH handling framework)
> where driver is responsible for save and restore of the regs, and it is also not possible
> for the kernel to know exactly what to save and restore for each specific type 2 devices,
> it seems logical to do the same here.


At the time I wrote that comment, it was not clear in my mind how this 
should work, and I had doubts about the BIOS.

But I can say now all this is fine and doable.


 From you comment (not in the thread but through discord) about being 
the sfc driver the client for this functionality, I think it could be. 
I'm not sure if as part of the current Type2 patchset effort or a 
follow-up work. I'll do some work the next week for seeing the implications.


Thank you


>> +1  The reset-related content in drivers/pci/pci.c has been growing
>> recently.  Maybe we should consider moving it all to a reset.c file.
> This makes sense. I'll prepare a patch to move the reset code and
> compile out CXL specific parts while making any changes for the next version.
>
> Thank you.
>
> Regards,
> Srirangan.
> ________________________________________
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Friday, February 21, 2025 4:13 PM
> To: Lukas Wunner
> Cc: Srirangan Madhavan; Davidlohr Bueso; Jonathan Cameron; Dave Jiang; Alison Schofield; Vishal Verma; Ira Weiny; Dan Williams; Zhi Wang; Vishal Aslot; Shanker Donthineni; linux-cxl@vger.kernel.org; Bjorn Helgaas; linux-pci@vger.kernel.org
> Subject: Re: [PATCH v2 2/2] cxl: add support for cxl reset
>
> External email: Use caution opening links or attachments
>
>
> On Fri, Feb 21, 2025 at 11:45:56AM +0100, Lukas Wunner wrote:
>> On Thu, Feb 20, 2025 at 08:39:06PM -0800, Srirangan Madhavan wrote:
>>> Type 2 devices are being introduced and will require finer-grained
>>> reset mechanisms beyond bus-wide reset methods.
>>>
>>> Add support for CXL reset per CXL v3.2 Section 9.6/9.7
>>>
>>> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
>>> ---
>>>   drivers/pci/pci.c   | 146 ++++++++++++++++++++++++++++++++++++++++++++
>> drivers/pci/pci.c is basically a catch-all for anything that doesn't fit
>> in one of the other .c files in drivers/pci.  I'm slightly worried that
>> this (otherwise legitimate) patch increases the clutter in pci.c further,
>> rendering it unmaintainable in the long term.
> +1  The reset-related content in drivers/pci/pci.c has been growing
> recently.  Maybe we should consider moving it all to a reset.c file.
>
>> At the very least, I'm wondering if this can be #ifdef'ed to
>> CONFIG_CXL_PCI?
>>
>> One idea would be to move this newly added reset method, as well as the
>> existing cxl_reset_bus_function(), to a new drivers/pci/cxl.c file.
>>
>> I guess moving it to drivers/cxl/ isn't an option because cxl can be
>> modular.
>>
>> Another idea would be to move all the reset handling (which makes up
>> a significant portion of pci.c) to a separate drivers/pci/reset.c.
>> This might be beyond the scope of your patch, but in the interim,
>> maybe at least an #ifdef can be added because the PCI core is also
>> used e.g. on memory-constrained wifi routers which don't care about
>> CXL at all.
> Agree, we'll need some way to make this optional.
>
> Bjorn

