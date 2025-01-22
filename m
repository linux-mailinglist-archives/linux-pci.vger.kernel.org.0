Return-Path: <linux-pci+bounces-20240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6F9A19269
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 14:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E190B162224
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 13:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38607213242;
	Wed, 22 Jan 2025 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hoX74Ptg"
X-Original-To: linux-pci@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010009.outbound.protection.outlook.com [52.103.68.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2D918E25;
	Wed, 22 Jan 2025 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737552513; cv=fail; b=G2oZ/v1ACWZrHv5WD87s4qsoD18TDZhRccFV5QutQDPWu+W83ZVuldpYztxDVSVPDKTDj6s3NeT4V+ZvlOftIU0JPHjTz0JNRHDBtlTYZyIaqsdazRriAapGe4cmzzP0NnetUY/sV4vFWUp9OGjVPYsMmcfo9QKrcXZwK1Oh60s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737552513; c=relaxed/simple;
	bh=MfH3NVWDuch499eH+nuGd/2UYnuORGKR5SjWAh8nnac=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lJ36Pn5wWA1QMpnyGXXQ4okOiayAZZ+knvqiKL7SVQrEHskpCzjrDMfYy7TsPNxz2kazWMcRykLCrv9MI9TebZ1IeBzZusVbH4kVtCYu0koAbti1odSHLmlT2I8RQXvYsGl0eSZCxGKXJGUtjhv1NPqCdIxmiD4KOk8HtmfyhJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hoX74Ptg; arc=fail smtp.client-ip=52.103.68.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUfL7/KqYebraOA6wBH/Qfj9oohcdQ9B4JoZ54QHRQrNFVRgGof70TO/xlm3TU91lSP0oiAhWkKpQX9xvbNheQnINgp3VfHQjpb/FGRJkeI6o2zV4Bmd2Ww0TwGQVNVJMrAgUXhv8qadyu/abYycsJJ/YzFutlsI/czlYZ1hVPmcnhBiSjikVE3KNRdB7b1uQhPs2dbelEzrNa6XMMPdSAE7Vg3IstY5AqNQ3/AS3KWrCeAY7d/lFQ/fZaesTHQtmRT8WITGdm9zq2nd55J/Z3St4wXoKf/lfZYc4pMaF8LnIhsUjpaC2BVFt7sG7h+XTamDSGghfTiIgs5P90XTww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OG3lTRz4WaQiThOuwDj0Py+GZ1rnbXkhMc2BaiKzLS4=;
 b=rw5XJ1TxlmE4Vcgcf1IAnbeqCbEFbQyJ3uTfE5tRaaDOYMkudOuNwoJE0Wd1jGnbflJtLAJrZLEjDASmsqi3zgggR7mpXScfz7tTAzJX0vzNpvr9jxHzeWgMI/JdlAbXxtgRRohWZVTQXLbd9c9cJnZh6qRgmmzkP1hWEp0+RHwi4rgBYAcI+AE3KoIJ9yh9howUl+U21f+bUWCWAT7kvv9PoBOVNMcM7Dx71+xnGvNbZtKPUKJFSHGY8ZSurZVW4o7tnkVY88gaNpV9HodBfOU6sKGknh54ROXS0LuPggtB/LnIgRdCgO0EGq4RNTmyiXjYhxakkpqNcp0RsPz5Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OG3lTRz4WaQiThOuwDj0Py+GZ1rnbXkhMc2BaiKzLS4=;
 b=hoX74PtgTmK60ijE3HucQ1bN3oxzJEvQyRyHMenxuBlMNQ2k7+eV35rCwerAXOO+m3r2Pnw8hMn+3lV5BKGTRxwlAR7WMO6SqL1I3odTpu0NFnT3MtWrkb+s9fKGmn41A4osGizXstAMNuB8lsW+ygJ9GOR4RMWDXOWkwGOWNly5bx2zFNJfje31TA/vIK1kkn6dGULzfh0+C4/6UC1JzLiYrxm1Hnc/4WqN7Xr1tce/3SUVq+SpsYvABy/I9IJInrLQ1R7Oys4+UaoSMIlmNHLW8oPccQrM99v9mBqeQeuBrHxsP2lyqABd7E8NKZh/k0I5VSlc8/il7nJ/IX1rDw==
Received: from BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:44::15)
 by PN0PR01MB6461.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:72::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 22 Jan
 2025 13:28:21 +0000
Received: from BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::954a:952d:8108:b869]) by BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::954a:952d:8108:b869%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 13:28:21 +0000
Message-ID:
 <BM1PR01MB254540560C1281CE9898A5A0FEE12@BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 22 Jan 2025 21:28:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] PCI: sg2042: Add Sophgo SG2042 PCIe driver
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Chen Wang <unicornxw@gmail.com>
Cc: kw@linux.com, u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu,
 arnd@arndb.de, bhelgaas@google.com, conor+dt@kernel.org, guoren@kernel.org,
 inochiama@outlook.com, krzk+dt@kernel.org, lee@kernel.org,
 lpieralisi@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
 pbrobinson@gmail.com, robh@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
 xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com, helgaas@kernel.org
References: <cover.1736923025.git.unicorn_wang@outlook.com>
 <ddedd8f76f83fea2c6d3887132d2fe6f2a6a02c1.1736923025.git.unicorn_wang@outlook.com>
 <20250119122353.v3tzitthmu5tu3dg@thinkpad>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250119122353.v3tzitthmu5tu3dg@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:44::15)
X-Microsoft-Original-Message-ID:
 <dbec589a-2a41-446b-a9a2-9d4906224866@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BM1PR01MB2545:EE_|PN0PR01MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: 02b491ee-9aa4-4f33-20c5-08dd3ae8a2fa
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|5072599009|8060799006|461199028|6090799003|7092599003|15080799006|440099028|19111999003|41001999003|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sk1TN2ZFZElOMnVleWk4d050OGhkVlROY1ZqV2x4Q2N6VmhhQXBlMlFkdWRK?=
 =?utf-8?B?ajg5UTRaNjdSS3JQcDZpbktiMks1eWNFM3JYdGNmQkVIc3JKRnl2YWIrUGhC?=
 =?utf-8?B?VzcrUkpUOTBTUFh5TVl1c2pzTCthNEpCUnR5RHZIVFRIK3BDRHVGUlV5Z3c4?=
 =?utf-8?B?UFVreDFaVXNkbWNkRWdScDFYZkphNG84dlpNc2N0dFFCemtUelFsQk5ES0VC?=
 =?utf-8?B?TG8vWWJLdDJQLzJTUGZ1T0RkbXNQOFd1UnlyR01GckdzWksrRzdlTEM2MHN2?=
 =?utf-8?B?SUQ2QmVKa3JjNnJDQjJXZGJJNk5MYkFaTlAvRXY4cXNNTWxyb0xTSW9BV01J?=
 =?utf-8?B?NmYrMEVSSkozQ0pyV1o5WldYRWc1TFZBWERxYktUVmlOV1YwN21CNVhmeTlq?=
 =?utf-8?B?OFdocVhaaWZZMGpwSllUanB5Wm1oOXpoK0VTVGl0YzlHUS9tbEFobmJBcWFl?=
 =?utf-8?B?R0NEdk5NWitDSjQ2cVJtZkdIM2tZSkJURStGQzJ1Y3BnSGhzZmtNM0VOd2ls?=
 =?utf-8?B?UGVCQzJlTXVDTnF5Um4wem0zaUdzekttcEl0QzlwbzRCL2tRZWpyWXB6aEwv?=
 =?utf-8?B?WGZYdS9tVWt6NWFLeHdPZGcxdzRDRlEydTNibmpQMzc4OFVKWU1qQk9NUC9m?=
 =?utf-8?B?TFBqTnZ0Tjl6cHFnQUhtWWtaQWdDWWJjZXpKRitOTzFTYjM4RnVrK2w5bGRQ?=
 =?utf-8?B?UWV3Ulp6MnBTeWEzcGxRelFwNXBzQ1J0Q21SWEorTVFENGZYMUczSTBGeWlo?=
 =?utf-8?B?aGVPUnE4MWhYTzRFVU9UNFA4ZXd3dFhXaGVUdVFETzk5dGxTZVljNU0wL3N2?=
 =?utf-8?B?OTNHUjRic01QRjUvaVVtV0xROXpnTG5paTRSbGNNa2s2NFZUeHFUVHNSVkl6?=
 =?utf-8?B?V0pSbG9QdXE4bEI1ZlpaQVRsR21EL0tZdFNaTWY2enlxN1RVeWk4ZkF5dzZr?=
 =?utf-8?B?YzByTDdRalpucE9zWjZOMDJQRjVuNnFOMlhiQzBnM0NWUk5RUmhsVGtPQWRO?=
 =?utf-8?B?b2xDZHRWaGRQQXVudjVudjFSRHNFMU5tQnF1bXhscHV3dHVIUldBTUgvR3ZX?=
 =?utf-8?B?c04rdUY3T2lDVUVuVkpjUlZoVEpQeUs5NHZIWVNpSXlmQnRHeGhIZDhjOTMy?=
 =?utf-8?B?ZVpsNFVsZkV3ditqRXRTdjZFcmZybWJtY1lyWUZRbjd5cUZSUGwxVVZUcEdP?=
 =?utf-8?B?L2lsZmh2bmx2WlJOaE9ZT0QycC9jckRNV21SL3FFS1I0Q3hWZWx6ZURLRGNN?=
 =?utf-8?B?dlhTbGtXdU1NVXozT1RHTkNTTWNLMWxTNTlieEptSEZ5UlBsRWlwSEJOTzZi?=
 =?utf-8?B?RC90VzU5QmdCR2FESm1OL0duQWRhWE5ucXNCWktZc3Rka3JEdmJzOFNrNFlH?=
 =?utf-8?B?Zit0NXpsdHkxSFEyb3MreEliaUlBa1htdHl2UWIveFhxSVFUOHd3LzZ1YTlx?=
 =?utf-8?B?ajJveWROVGZFaklRdzhWR1RmT1lodUExVGhhUk1sZGNXS0VoVFRZRVBlNjR5?=
 =?utf-8?B?SzF2R3NDVStyT1ZPUTJJaEVKZHpSVmZXbzBBS2FaYmZjbVpZbjhLYmxhNGpG?=
 =?utf-8?Q?nnwcD2brwSXYNVCyLz4qy0Ob4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0l0aitwaWlERXhSNFhHL3ZWdEI2UC9BY0tRa1hIOXNPckRnd1NsYlNKVEds?=
 =?utf-8?B?Zi9SMU1ISi9mQTdlMGJQS0VndktSRWIvVjZwZWVUZmljRmJCOERjWnlHeloy?=
 =?utf-8?B?T2lzT2h0bXhtN3hmZk1rWDZJeGdDNmJybDhHajc1Y3F6R1B1cWR5UFhXSUpt?=
 =?utf-8?B?Tis1dU5lUXNrQ01tNmpja21yMUdjR09XM0pnUHRZSkJYWW1hekkxcDdidzU2?=
 =?utf-8?B?RHMxTmxtMTh4MnZsM1pyZTJSYmV0eTJoem8wUHBmWmd1UGh5clFvSlpRWG1D?=
 =?utf-8?B?RXYxaTkvUTJ4ekNQZEhFbURqN2VEdzM3ZnlEZ0IxNDJmdTRDMTdTUjVqd1VU?=
 =?utf-8?B?WFBaMGprTGZubVhSM290MGJFM01rNHNvYW1UZ2hJUklFYThualp3eExYTlhp?=
 =?utf-8?B?Z2dMNlFQRDZvVVQydngzU1BXdm9sVE5qbzg4QzRLVmRmbGJZWUIzaERobHBI?=
 =?utf-8?B?QS8zRmEwdHRPdUdZQlI1VDdrVmFyY3ZxaW05a1k5MXlTRk1lTDhCQzF4TnJX?=
 =?utf-8?B?cHJsK252QUh4QkV4WTJnUWJhdnJIWnordGRpRVIzVi9jQVJTUGRhOHRIUkx1?=
 =?utf-8?B?bGg3WEl6ZFZvMkxkNWhIWXpUVi91bWdJQ28xMGNWTkxIbUw4dVZ6WVdCRE9N?=
 =?utf-8?B?cTg1b1UyK1ViM2tjeWNBVzEwVHB2Q2ExOXU5MlhQaTR2czNGa2g4RGFWTEhD?=
 =?utf-8?B?cUY1Y2NTdHUxRkJUNHNsVlNya3Q1MUEvL095d1Q1Z0JPMVByRDJkZmlQSFp6?=
 =?utf-8?B?b0oycVVVWkdzcVErWG5IaHFrRWl0VmxJUllzWFVuL05TVE9FQmJHdXBEYXdY?=
 =?utf-8?B?S09LZGo0RGtWWExrNGJqcEZsVTFoNlJFMjJlZzRHMjNqeGd1ak43TVB2VGZ0?=
 =?utf-8?B?Yk03U2l6K1NDWm5PNTVDSUx2TEZPUXFkSHUxZ01mNnVmVjI2OUF5aStiZWd3?=
 =?utf-8?B?TUswZVBaQXZLTnJ4OHNtTXhhRVJ6TW4zTmZxY1drK2czWXpnbFVFNVJzTjdG?=
 =?utf-8?B?NWhhT29tZ1RLcDhDVGdoeXdzVUNnT2xpNWp5WkdkUEo0ZVRCeHNYbE01d0Rt?=
 =?utf-8?B?TjZML2l2YUlNalZKYjg5TFEzanV6U3gwYWROQTF3d3RBNkU4SG9adVMxaTJS?=
 =?utf-8?B?WEtCWGJUYi9kR3hpYk5OYXI2S0piTTZ3VXA4TkVGeGVFT00rb2ZvcHhJWWtK?=
 =?utf-8?B?dm5kRkhzK0hlMmRFU3AxNlRubHRWZDdCZE5UeDFmTHpFV3lnWFJvQnkzdXNS?=
 =?utf-8?B?RVpMaU44MTUrSXhDaUVrNFAxMFUwWGJCUlhKSmNiU2Q5TmlDTUdRWDhDY1RH?=
 =?utf-8?B?K2pQZE5aT1ZIRDc4UWwwVFA4Nklzc0M4ZUJPeU82Zk10K1VIenJpZXpJYkw1?=
 =?utf-8?B?RythMDZadmtvNDNJZTRYdmxLa1RMbjBSdGtNeEwycnFsek1OMk9EdW84QVlU?=
 =?utf-8?B?d0R5VzV4Q1BSZ1VlUG00aUp0V1dmMlpKdjc5K2dIZXdUbnJwYUI2SEpiNG51?=
 =?utf-8?B?cDRlS2NVak9OSm41N1ZaU3M4TGVIWXdzSkQ3azVoa2VuMUQrVFcxSy9IT0Jj?=
 =?utf-8?B?SEpzTUUxdndBNUhvMXFJT2NaRmdpbjNoekJXSWhDdU83bys2L0hGRDQrM3o4?=
 =?utf-8?B?azgrZ0E1NVc4RGczWjFobXRxbnVPVWVUc0I0MjBBeGJRaXAydzduVHNranUw?=
 =?utf-8?B?VnJoWUtQNWhQVzBEQlFNbmUzUktiaERnY3R1cExjMHFJaEs2OTVlRTdEcjdm?=
 =?utf-8?Q?FIKR1mUkNRnwVPybRwX8Y/5wnJBDDvj79U8ViNz?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b491ee-9aa4-4f33-20c5-08dd3ae8a2fa
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 13:28:20.0158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB6461


On 2025/1/19 20:23, Manivannan Sadhasivam wrote:
> On Wed, Jan 15, 2025 at 03:06:57PM +0800, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add support for PCIe controller in SG2042 SoC. The controller
>> uses the Cadence PCIe core programmed by pcie-cadence*.c. The
>> PCIe controller will work in host mode only.
>>
> Please add more info about the IP. Like IP revision, PCIe Gen, lane count,
> etc...
ok.
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> ---
>>   drivers/pci/controller/cadence/Kconfig       |  13 +
>>   drivers/pci/controller/cadence/Makefile      |   1 +
>>   drivers/pci/controller/cadence/pcie-sg2042.c | 528 +++++++++++++++++++
>>   3 files changed, 542 insertions(+)
>>   create mode 100644 drivers/pci/controller/cadence/pcie-sg2042.c
>>
>> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
>> index 8a0044bb3989..292eb2b20e9c 100644
>> --- a/drivers/pci/controller/cadence/Kconfig
>> +++ b/drivers/pci/controller/cadence/Kconfig
>> @@ -42,6 +42,18 @@ config PCIE_CADENCE_PLAT_EP
>>   	  endpoint mode. This PCIe controller may be embedded into many
>>   	  different vendors SoCs.
>>   
>> +config PCIE_SG2042
>> +	bool "Sophgo SG2042 PCIe controller (host mode)"
>> +	depends on ARCH_SOPHGO || COMPILE_TEST
>> +	depends on OF
>> +	select IRQ_MSI_LIB
>> +	select PCI_MSI
>> +	select PCIE_CADENCE_HOST
>> +	help
>> +	  Say Y here if you want to support the Sophgo SG2042 PCIe platform
>> +	  controller in host mode. Sophgo SG2042 PCIe controller uses Cadence
>> +	  PCIe core.
>> +
>>   config PCI_J721E
>>   	bool
>>   
>> @@ -67,4 +79,5 @@ config PCI_J721E_EP
>>   	  Say Y here if you want to support the TI J721E PCIe platform
>>   	  controller in endpoint mode. TI J721E PCIe controller uses Cadence PCIe
>>   	  core.
>> +
> Spurious newline.

oops, I will fix this.

[......]

>> +/*
>> + * SG2042 PCIe controller supports two ways to report MSI:
>> + *
>> + * - Method A, the PCIe controller implements an MSI interrupt controller
>> + *   inside, and connect to PLIC upward through one interrupt line.
>> + *   Provides memory-mapped MSI address, and by programming the upper 32
>> + *   bits of the address to zero, it can be compatible with old PCIe devices
>> + *   that only support 32-bit MSI address.
>> + *
>> + * - Method B, the PCIe controller connects to PLIC upward through an
>> + *   independent MSI controller "sophgo,sg2042-msi" on the SOC. The MSI
>> + *   controller provides multiple(up to 32) interrupt sources to PLIC.
>> + *   Compared with the first method, the advantage is that the interrupt
>> + *   source is expanded, but because for SG2042, the MSI address provided by
>> + *   the MSI controller is fixed and only supports 64-bit address(> 2^32),
>> + *   it is not compatible with old PCIe devices that only support 32-bit MSI
>> + *   address.
>> + *
>> + * Method A & B can be configured in DTS, default is Method B.
> How to configure them? I can only see "sophgo,sg2042-msi" in the binding.


The value of the msi-parent attribute is used in dts to distinguish 
them, for example:

```dts

msi: msi-controller@7030010300 {
     ......
};

pcie_rc0: pcie@7060000000 {
     msi-parent = <&msi>;
};

pcie_rc1: pcie@7062000000 {
     ......
     msi-parent = <&msi_pcie>;
     msi_pcie: interrupt-controller {
         ......
     };
};

```

Which means:

pcie_rc0 uses Method B

pcie_rc1 uses Method A.

[......]

>> +struct sg2042_pcie {
>> +	struct cdns_pcie	*cdns_pcie;
>> +
>> +	struct regmap		*syscon;
>> +
>> +	u32			link_id;
>> +
>> +	struct irq_domain	*msi_domain;
>> +
>> +	int			msi_irq;
>> +
>> +	dma_addr_t		msi_phys;
>> +	void			*msi_virt;
>> +
>> +	u32			num_applied_vecs; /* used to speed up ISR */
>> +
> Get rid of the newline between struct members, please.
ok
>> +	raw_spinlock_t		msi_lock;
>> +	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
>> +};
>> +
> [...]
>
>> +static int sg2042_pcie_setup_msi(struct sg2042_pcie *pcie,
>> +				 struct device_node *msi_node)
>> +{
>> +	struct device *dev = pcie->cdns_pcie->dev;
>> +	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
>> +	struct irq_domain *parent_domain;
>> +	int ret = 0;
>> +
>> +	if (!of_property_read_bool(msi_node, "msi-controller"))
>> +		return -ENODEV;
>> +
>> +	ret = of_irq_get_byname(msi_node, "msi");
>> +	if (ret <= 0) {
>> +		dev_err(dev, "%pOF: failed to get MSI irq\n", msi_node);
>> +		return ret;
>> +	}
>> +	pcie->msi_irq = ret;
>> +
>> +	irq_set_chained_handler_and_data(pcie->msi_irq,
>> +					 sg2042_pcie_msi_chained_isr, pcie);
>> +
>> +	parent_domain = irq_domain_create_linear(fwnode, MSI_DEF_NUM_VECTORS,
>> +						 &sg2042_pcie_msi_domain_ops, pcie);
>> +	if (!parent_domain) {
>> +		dev_err(dev, "%pfw: Failed to create IRQ domain\n", fwnode);
>> +		return -ENOMEM;
>> +	}
>> +	irq_domain_update_bus_token(parent_domain, DOMAIN_BUS_NEXUS);
>> +
> The MSI controller is wired to PLIC isn't it? If so, why can't you use
> hierarchial MSI domain implementation as like other controller drivers?

The method used here is somewhat similar to dw_pcie_allocate_domains() 
in drivers/pci/controller/dwc/pcie-designware-host.c. This MSI 
controller is about Method A, the PCIe controller implements an MSI 
interrupt controller inside, and connect to PLIC upward through only ONE 
interrupt line. Because MSI to PLIC is multiple to one, I use linear 
mode here and use chained ISR to handle the interrupts.

[......]

>> +/* Dummy ops which will be assigned to cdns_pcie.ops, which must be !NULL. */
> Because cadence code driver doesn't check for !ops? Please fix it instead. And
> the fix is trivial.

ok, I will fix this for cadence code together in next version.

[......]

>> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
>> +	if (!bridge) {
>> +		dev_err(dev, "Failed to alloc host bridge!\n");
> Use dev_err_probe() throughout the probe function.
Got it.
>> +		return -ENOMEM;
>> +	}
>> +
>> +	bridge->ops = &sg2042_pcie_host_ops;
>> +
>> +	rc = pci_host_bridge_priv(bridge);
>> +	cdns_pcie = &rc->pcie;
>> +	cdns_pcie->dev = dev;
>> +	cdns_pcie->ops = &sg2042_cdns_pcie_ops;
>> +	pcie->cdns_pcie = cdns_pcie;
>> +
>> +	np_syscon = of_parse_phandle(np, "sophgo,syscon-pcie-ctrl", 0);
>> +	if (!np_syscon) {
>> +		dev_err(dev, "Failed to get syscon node\n");
>> +		return -ENOMEM;
> -ENODEV
Got.
>> +	}
>> +	syscon = syscon_node_to_regmap(np_syscon);
> You should drop the np reference count once you are done with it.
ok, I will double check this through the file.
>> +	if (IS_ERR(syscon)) {
>> +		dev_err(dev, "Failed to get regmap for syscon\n");
>> +		return -ENOMEM;
> PTR_ERR(syscon)

yes.


>> +	}
>> +	pcie->syscon = syscon;
>> +
>> +	if (of_property_read_u32(np, "sophgo,link-id", &pcie->link_id)) {
>> +		dev_err(dev, "Unable to parse sophgo,link-id\n");
> "Unable to parse \"sophgo,link-id\"\n"
ok.
>> +		return -EINVAL;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, pcie);
>> +
>> +	pm_runtime_enable(dev);
>> +
>> +	ret = pm_runtime_get_sync(dev);
> Use pm_runtime_resume_and_get().
Got it.
>> +	if (ret < 0) {
>> +		dev_err(dev, "pm_runtime_get_sync failed\n");
>> +		goto err_get_sync;
>> +	}
>> +
>> +	msi_node = of_parse_phandle(dev->of_node, "msi-parent", 0);
>> +	if (!msi_node) {
>> +		dev_err(dev, "Failed to get msi-parent!\n");
>> +		return -1;
> -ENODATA
Thanks, this should be fixed.
>
>> +	}
>> +
>> +	if (of_device_is_compatible(msi_node, "sophgo,sg2042-pcie-msi")) {
>> +		ret = sg2042_pcie_setup_msi(pcie, msi_node);
> Same as above. np leak here.
ok, will check this through the file.
>
> - Mani

Thanks,

Chen


