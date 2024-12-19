Return-Path: <linux-pci+bounces-18750-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0179F9F734B
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 04:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D46BD1882D8F
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 03:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D0386333;
	Thu, 19 Dec 2024 03:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="WQG+DzV/"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010000.outbound.protection.outlook.com [52.103.67.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2683D3B8;
	Thu, 19 Dec 2024 03:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734578606; cv=fail; b=TExflnmWQHdJuYjhdJLrSQ5+vfyvWPd2YPnrdK4a6RBUiL9klBsk+SnNM8TQnSNOSpPYSNcAuia0a77/3NAH+HLCHAyJn9fPZga0GzlSIp9XXCJmPbP2jgZSWw++F2PppWlSnKmrD5lBvITH9TYqKpSoJwVdslGAF5ERBHq2924=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734578606; c=relaxed/simple;
	bh=Nmelp6K8k3Tnse+Z+mWqA54glZ39lXDB3UlILW6cU7Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C6s3UHigUqYlkwVH5yEJhRkx9gZNnsEBAxaAq3ctSzseklIPkRqvbjJtoMLyn2py3NKuX1NNfWAGkB/MeqZPqHYNm28xAsppwSkBL4g9+ZP4QjUJlfG9S4rV0LRnbtygb2Vg8Za7hH2Tn0y6KBcUOC3ZGFedgaD/YT/tJfcskO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=WQG+DzV/; arc=fail smtp.client-ip=52.103.67.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHljrtPVTw5tFi5NLAQxWsclrK92OqEp1A3MN5nIypd0XY36UQZED4ATkMkumg2v5HkXnNklHjd6BqFELq47yTW/HqhjEXLXEJ1vzvQsk1hPw/OwXfYzJ0g6uV8eKlfuljrq7BFVxbZn0sY2ecyLhBqLmswH1lnhFP1O3+eaLv/OwhzIqFjH1pIDojXoZyixiSpXJ/MabMpzoZKxUy8I7dF0DwS+gp5ancUmIvX8Da2ZFlv1mpuF4gk/17GHzhvoeYsSYURVHYnWrzYvmSnBHGt96owXe2t5LHQ3LiuE4nHWq95V02tlYOe11SUeQKj6C41sM5THhkcbA1ThaKvqvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HEgVtk57a5Ze6ykvD1O4ae15Cvhd0NCgYSLF2td/Xg=;
 b=QoMsm6315aPgo9fxre8+3tPNv4hIAAyMxVtXuw+PoBnSMCSUFwvdIqTh6moPuTn8GJIGfxdxi7bUtMY2tpXIDVTbZdmnw4EbhXLzU8k6ZTsVbArSqYvbjQFnkkpRWSajaVUHMN68mJeYk50u25cVFEEnuAFCBoNtwJnsQAeZon1sgEL9sxEhD/KTG+77YI4RzVdAzKX3NW2jz91NfNSDhW0QxqyyYh6kbGbMhKi8fWV46AdjP3Qc4dDrvv/6lb/8GmewokDFEm0lG4qtUJkU2An3ZPWHy1+qjD9UR2epDOjwENF7AUOtxfYg8AySgWJutgACfzYMweMBS0ZtuYal+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HEgVtk57a5Ze6ykvD1O4ae15Cvhd0NCgYSLF2td/Xg=;
 b=WQG+DzV/Mnp9HnYkZeg06gyHHO89BsnhtK1wm45fDpSSo7fi5wwFwrSMDI/Y//0AVGZ2q+7Tgjd7RGf8CwFfWY7/DKblF4aFgEqPpuWjr5rTT+1yfCmYvNQ15GrDVv7USMQhIU3R9lqwpCSo5FsONOX6G1ZCNXdrdMrZo4XbHdYIXfL1u/9D8nrqWXUzLlMdjxnTTK1dcTmAhbkjyOHzX4FUG5AOsjfYdrVWqNzTcdCZhlCWNi2dRJBtKFV04a6ZCtiJIXaCqhIWowDSLM2FrxYpZ6VfVwIP8Ao0nD6Qw0/ltQ3xX25g5azAxTNUFGBm8AHKJJE2gh9OtuK3WFsVDg==
Received: from BM1PR01MB2116.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:46::11)
 by MAZPR01MB5696.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:64::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Thu, 19 Dec
 2024 03:23:15 +0000
Received: from BM1PR01MB2116.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::67d0:f11f:b82f:1f5d]) by BM1PR01MB2116.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::67d0:f11f:b82f:1f5d%5]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 03:23:14 +0000
Message-ID:
 <BM1PR01MB21161E41CA05A919E0A6D64AFE062@BM1PR01MB2116.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 19 Dec 2024 11:23:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] PCI: sg2042: Add Sophgo SG2042 PCIe driver
To: Bjorn Helgaas <helgaas@kernel.org>, Chen Wang <unicornxw@gmail.com>
Cc: kw@linux.com, u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu,
 arnd@arndb.de, bhelgaas@google.com, conor+dt@kernel.org, guoren@kernel.org,
 inochiama@outlook.com, krzk+dt@kernel.org, lee@kernel.org,
 lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, pbrobinson@gmail.com, robh@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
References: <20241210173123.GA3247614@bhelgaas>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20241210173123.GA3247614@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To BM1PR01MB2116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:46::11)
X-Microsoft-Original-Message-ID:
 <c9ca8672-77ad-4523-8277-bf1bb5388a62@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BM1PR01MB2116:EE_|MAZPR01MB5696:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e738c3f-04eb-41df-b886-08dd1fdc7923
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|7092599003|6090799003|19110799003|8060799006|5072599009|461199028|10035399004|440099028|3412199025|4302099013|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2dpN3VqelExQlo3VjI0MDNQSFVpZXh2Sy9ZSjk1bzRoTlZuQXRUNHA3NnJl?=
 =?utf-8?B?QnlHRG04M2kzUEpMQkZuWDhFa29lZE1PZnZRRU94U1JmT3cwTzNBc1N1ZnpQ?=
 =?utf-8?B?aHNQd0dvNXpUNHZMS1J5aHBCdSsxNUZHS2xHZDZnVUd1UWFRVFlFNVErazNi?=
 =?utf-8?B?T2J3dUlkSHd3WGNscWttNktDZnBvZGVZMHpnb1dFS0ZzR1Nrb0QvK2JScFl1?=
 =?utf-8?B?ZnQxalFaU0gwNU5WY1lqWjg4UXh1ODM5Ukc1T2cvM2xBVUJhbXZMT1hqZDg3?=
 =?utf-8?B?WjFMT2pranZWbkpSUHhNNnlKVk5xVUVPemRNdVJNWVVUaGc2emxzM0NyaFdN?=
 =?utf-8?B?UEk2a1l2bnJpa01QZXpkKy9sZ1orOEovVnlqcXZFZ3pvNzFDZmxFeTFoczVJ?=
 =?utf-8?B?SXA5amRIRFpubkJKSVhjTHBsVUZWZURTMklkQTZGQ1o2VHpCZVl4K0hWM3oz?=
 =?utf-8?B?cWUrcnVJSmNhT3dhVjJzOGdsV25qc3l6TWJkTFlWbFVDWC9jemx3c3lhL3Jz?=
 =?utf-8?B?ZUp6eTcvZDVTa3ZQS2NGcURJSlRFbEhQcEIyRW0rcU5BUXJDTWFYcVdKekpM?=
 =?utf-8?B?cEVHbVhZRG5IbWhBNzNSbjd3WVNIWVBTSnNjZE1hOGdwWnpHY1JreTJwU2ho?=
 =?utf-8?B?ZXpyVkRSSnp1OXR2dkt6VG9wdC9DaW84U3JKV3RMQlo2UmdmUXpJdGl1akpK?=
 =?utf-8?B?WC9KU2RzdjB3ODhZNXQ0cGFGejIvRVhUZDZvK21GRi82Z3RnNmp0T0NDamtk?=
 =?utf-8?B?dDJ6VXhmc2o3NmRlNnB6cFlnYkhLZy9YbEg3MFhYdnFKSjhObXovUjBRVDBo?=
 =?utf-8?B?RlBaK2o3QkYweWcwZ2U1MXlmN2JXekdjSjR5NlA4dDZaNW1CdDFISElYbXk3?=
 =?utf-8?B?NTF6YWpNdlZjN3R4cnpYSlJlZ1daTW1qdkRXZllEbW5wZGM3SHByRzdQanMv?=
 =?utf-8?B?Z2lIc2F3MzFXc2g5TXY0MWhrUHAvVkZxVWt3WjFGS1ZhdkVnY3gvRC9QSGxQ?=
 =?utf-8?B?UVJsY0IvaERzZmZwRElDbjdKN045Nmw4VUtVb29rdlZPSFp6THNoZVJmREdv?=
 =?utf-8?B?VXJMWU85Qk9UQVpaYjhOVGpWczBlZVhwVXBuMEVCbTJiWTF2dUIzUlF0ZUlN?=
 =?utf-8?B?RUNCaEtZdHNuNkFsOHp4eVVzbjJ4Y0F2UWdhVk00UkIwdzhndmlkdmJMay9x?=
 =?utf-8?B?YTVrRmVSdzdIWnNXcnJvaUlCOUwzRDVNUGVURWdJVStMOGx4all5T1JYd29l?=
 =?utf-8?B?M09SY2JhRzhEU0NlV0ljMjFMd1FPMW9ZVWN5MlFmQ01WVDZWVWt4cVcwTGFo?=
 =?utf-8?B?ci9HekRRK2swWktYVm1LSGV1YzhCdlkxb1hnMWM5eTRMeHg3NmQ1UDd1SGtx?=
 =?utf-8?B?bUp3by9WZmZ4KzBIckNPM2M4cFI4MVpmQ2VkQTNGWS9KQVQ2NGxiVjdVV1hu?=
 =?utf-8?B?aFlhWGVhU1lTbzUvTzIwNzhDbmtFK1lKMEg4c1pHMVRsUTZBM0gxTGMyMCtC?=
 =?utf-8?B?dlZLU3drVXV6UW1TTHdDSG0vUmxJeVpnOVNnMXlDeENsSVJObUZSNUpCZGpV?=
 =?utf-8?B?dFlobXl5U3VSVnZSZXZXMXo0STdSTmgxVXZaZGg3SVNSRXEwN2IwU25Zd3Zk?=
 =?utf-8?Q?4MOLKKf+BYwMvEDBiYMxI7a+TDSm+1KfCV39ANrpkodE=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmpYbnk5WkRUbnUvYzk3ZUNiOFhTc28yMWpvRUdWbDVLQmdoZFlLYzFtS1dn?=
 =?utf-8?B?YVM5dG9uMkF4V1VScFppWDZFU1dQWjFNc3o3VGtWa2RJMWkramMrdHdHRTN4?=
 =?utf-8?B?MklYVEdQMnVMQ1VGWVI5NTdjNDQ2MFpabCtoZ21EeENQNDFGcXhyaHZmMUJY?=
 =?utf-8?B?Q3pnSGJQSFVTVUx2RGlHdkZZdmpHTld1akYxL3NKekZPMHhhVlJIM2ZuMFls?=
 =?utf-8?B?TzA5NGpudFhvMjFGOU1HNjRnZ3RDOXRGWks2MnNsN25BVDhtK0FBSU1ueTVQ?=
 =?utf-8?B?bVBnSHhpWTI0d25KQ0RRb0V4c1hhUlF0VmhRSVFIVFA0ZTdDaDlBbEF6RWVN?=
 =?utf-8?B?L2JSWml3eC9jVXlRY1RSWmsxbHFvV2RjWE0wYzBONTZ4UDBUUUpiRzNNMlFw?=
 =?utf-8?B?VDNNM0I0b2VGZUFSVzFqMnUrak9KL3ErQkZ2ZnRPdWhpQUlGeTdnYXprYTZP?=
 =?utf-8?B?SGZtRXRybENLU05Dbk1CVER2YlhxVHV4ME1IK3Bmd0Z2ZmVaaDVaNVNlN21n?=
 =?utf-8?B?RCtMMjVpTiszT1lxSitlTW9xKzN0ZE94Q1E1Vzh5ZTRnNGEycUxSQWwrZ0JF?=
 =?utf-8?B?L1VUNFJteFkzN1BTZ09XL2VxVXgxczVJSjBMSmcyR1FkSWpIL2hCNTZ4TTdu?=
 =?utf-8?B?cWR5c1FtMk4vSDlqSERueUZlWnZydEh1OFhaVXN3bUFrOG04T3RoS1JOTm9h?=
 =?utf-8?B?WWV1ZGxVa2t1dVpOWlNJaGZpS2RvamRYb2VkM0dVTkIzdnpWR2IzS0dVUm94?=
 =?utf-8?B?bmVCc2tDVS9PNWtjQW1heWtRSTNNT2lJdXRJbU5LU3hPK1gySWd0SS9La2V1?=
 =?utf-8?B?cUVxdUhSUURsVVVHSzdBRnZTZDFCS2N0V2ViM3ZtU2FXUXdnRVhLSHNvM2xZ?=
 =?utf-8?B?NDM4L095VFFHUTAwR01NWUpTSDYzV2svS1dlRWE3b2JjN1FldUFsbDlhQThq?=
 =?utf-8?B?WGVUdDNpVEtNS2FJdURtMWFsRDlQdUpJcmxVb2NYOEJQKytwRm5SRG1OZ01h?=
 =?utf-8?B?K05xS0JKWkhPZDJRWFVveFlvN09jZHdXYWQ4REs4Zk1oWnFJOW1JRDlXbGh5?=
 =?utf-8?B?Z2dDRzlJWGRjeDlXeFltZGs4ZGsrZFRpSUhENmVHM1BJcjRlY3djYkFPOFd4?=
 =?utf-8?B?S0tWV3llL1dIRzdOalpnam92ZzI5Qjg4OGtlazN6QUdhRVB4b0FRMzFSbFhs?=
 =?utf-8?B?QmtSanFRWklQd2tXS0U2UTdQOXQxMDc1R0J6aGprSHVoT3V3SzR1OStPVDBB?=
 =?utf-8?B?dzZpMjFlM0hmOG1kWFFmdWN5YWUyZmNGNUd1RjNYQXlRQVRlZ2tCR2MvcU93?=
 =?utf-8?B?OHBZY1pBRDBKRWhLQnU5cXlOZGYvVXJlRXNiSGpFZDE0Z2pobXJIYVJhSW9I?=
 =?utf-8?B?d1NQTjcrdVNiL2I5QWV3bE55ckVBc3owcjFPeHp3cFNVd2FuekhkSGZXL0xp?=
 =?utf-8?B?Q3dkVXMyZlgwWXIzam1tbHRHWlJSYkJLdXBWWWRqMTFQcncySTRWd003ellR?=
 =?utf-8?B?YmtjcVN5MVlUWCtWbGhTNUlpK2x0VDJNc09TRTAzYnVNQkRwbkVXUHpWbGtK?=
 =?utf-8?B?NkZoM084eGlGeUtNOVBpWWY5QWZIYU9lVGhuZ3VSTkxRV0ZWOWtHMWJ1cnFa?=
 =?utf-8?B?aTRjanljSm85ZW5ORmJiOE8yb01JN3pDNWN1ZFZzR3BJbktTc3RXL1AvZStW?=
 =?utf-8?Q?9nCeTz1GGUW9n2Dfd8m5?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e738c3f-04eb-41df-b886-08dd1fdc7923
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB2116.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 03:23:14.7300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB5696


On 2024/12/11 1:31, Bjorn Helgaas wrote:
> On Mon, Dec 09, 2024 at 03:19:57PM +0800, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add support for PCIe controller in SG2042 SoC. The controller
>> uses the Cadence PCIe core programmed by pcie-cadence*.c. The
>> PCIe controller will work in host mode only.
>> +++ b/drivers/pci/controller/cadence/Makefile
>> @@ -4,3 +4,4 @@ obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
>>   obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
>>   obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
>>   obj-$(CONFIG_PCI_J721E) += pci-j721e.o
>> +obj-$(CONFIG_PCIE_SG2042) += pcie-sg2042.o
>> \ No newline at end of file
> Add the newline.
ok
>
>> +++ b/drivers/pci/controller/cadence/pcie-sg2042.c
>> +#include "../../../irqchip/irq-msi-lib.h"
> This is the only file outside drivers/irqchip/ that includes this.
> What's special about this driver?  Maybe this is a hint that something
> here belongs in drivers/irqchip/?

This file is included due to MSI parent model is used in this driver and 
I used helper functions such as msi_lib_init_dev_msi_info.

Actually I see Marc is working on MSI cleanup and will make 
irq-msi-lib.h globally available, see 
https://lore.kernel.org/linux-riscv/20241204124549.607054-2-maz@kernel.org/

But before his PR is merged, we may have to include the file like this now.

>
>> +#ifdef CONFIG_SMP
> No other drivers test CONFIG_SMP, why should this be different?
ok, seems it'ok to remove this test.
>
>> +static int sg2042_pcie_msi_irq_set_affinity(struct irq_data *d,
>> +					    const struct cpumask *mask,
>> +					    bool force)
>> +{
>> +	if (d->parent_data)
>> +		return irq_chip_set_affinity_parent(d, mask, force);
>> +
>> +	return -EINVAL;
>> +}
>> +#endif /* CONFIG_SMP */
>> +static int sg2042_pcie_init_msi_data(struct sg2042_pcie *pcie)
>> +{
>> +	struct device *dev = pcie->cdns_pcie->dev;
>> +	u32 value;
>> +	int ret;
>> +
>> +	raw_spin_lock_init(&pcie->msi_lock);
>> +
>> +	/*
>> +	 * Though the PCIe controller can address >32-bit address space, to
>> +	 * facilitate endpoints that support only 32-bit MSI target address,
>> +	 * the mask is set to 32-bit to make sure that MSI target address is
>> +	 * always a 32-bit address
>> +	 */
>> +	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> Not sure this is needed.  Does DT dma-ranges not cover this?
I prefer not introduce dma-ranges, we just need to allocate a small 
continuous space here, and using dma_set_coherent_mask is also one of 
the commonly used methods.
>
>> +static int sg2042_pcie_setup_msi(struct sg2042_pcie *pcie, struct device_node *msi_node)
> Wrap to fit in 80 columns like the rest.
ok
>
>> +/*
>> + * SG2042 only support 4-byte aligned access, so for the rootbus (i.e. to read
>> + * the PCIe controller itself, read32 is required. For non-rootbus (i.e. to read
> s/PCIe controller/Root Port/
ok
>
>> + * the PCIe peripheral registers, supports 1/2/4 byte aligned access, so
>> + * directly use read should be fine.
> s/use read/using read/
ok, thanks
>
>> +static int sg2042_pcie_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *np = dev->of_node;
>> +	struct pci_host_bridge *bridge;
>> +	struct device_node *np_syscon;
>> +	struct device_node *msi_node;
>> +	struct cdns_pcie *cdns_pcie;
>> +	struct sg2042_pcie *pcie;
>> +	struct cdns_pcie_rc *rc;
>> +	struct regmap *syscon;
>> +	int ret;
>> +
>> +	if (!IS_ENABLED(CONFIG_PCIE_CADENCE_HOST))
>> +		return -ENODEV;
> I don't think this is needed since CONFIG_PCIE_SG2042 selects
> PCIE_CADENCE_HOST.

Yes, you are right.

Thanks,

Chen

>
> Bjorn

