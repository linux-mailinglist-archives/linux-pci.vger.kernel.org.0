Return-Path: <linux-pci+bounces-17452-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C229DC1AA
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 10:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4708B162B2D
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 09:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61426175D47;
	Fri, 29 Nov 2024 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VsIV0nnb"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011026.outbound.protection.outlook.com [52.103.67.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221DC1547D5;
	Fri, 29 Nov 2024 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732873915; cv=fail; b=WQBJNBgG5MJJhBfyR13tUuoNzbKbe7itTM03omU6tOrdxoQ44SL6K8PdledbtIR0razdfNiHokdcm3x/MKMUJeMbbDTv31N4PXqqvzU2gHYF7751lL1d90Z2q1SBd2GK1rV85vGN2eGG3k/CvPFBSTJw36OCriGwT3uVB5oX/0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732873915; c=relaxed/simple;
	bh=T6wl8GEbM6ZHlmVW2rJdCfk18Bep/L3Os+C4IXip/N0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QU52XjvdxcV5OJM4XzjRSLe0iiK+oN0KGtOD8//3HPUXYzzZafViATupKN+DAbc4TCChFkazXHNEVkI0KMoen38yaR24cPg9Ie6YYQ5T3dXQJhDi4dPUfCUiA9NnYzbPmBbMGRdbthBrWcLPN1By1TyDKqB/FXG+j39H9S52RMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VsIV0nnb; arc=fail smtp.client-ip=52.103.67.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ig1X5Uw/s2KpTdum1fqIIC0zd3C1x19e6hgZOvjgHe/4rGZK3tD4nK/xbEMYMKvbY8iewqSLCXzC1brCUzlzgaLkF0NdRPAAfpurcIiFrjK2C7vaHEuu4vtQukQRqp2+AcQMWO6QcAUgaVe/EE5fsUKPf3DWPO9DDEGLseDqdBRC6YfzZ4btlXAvS8JvzUvXsSE5UUelE/lEnoDmX2iXQo32vdVS8Kbvu9BNhD5uwnt6UAdnP+xZZPL/2KfSrgJXWYjsIDj/ijjfpoKpX8+PvRYYv1fhu9vZ9ACwDcNTnuBg7DnkX/UKpI2wksBPgb9jlbXdQi/+gIOvco4MGauLXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SH+Npp7zGYpYM+WO4iZx2VW/zbMhGhXlzkbgJ821i4=;
 b=Unkax42Rg8YvZxhNw3jEA0Ve4mYmq6AGUTI0p3ZLVMZ9O5Zn72xezETZ2Xmk21Rf3QmLbTjqjl1S5taDpmE4oFlZaR+DrnDK8c8XIcMqOQ6iJWcwXIALNcv/MGnOGt8pFqa3xBgn8jw/MZ3uqA/5OVwwXw18kLfC08fGlfBh4TmFD13DfF9g4EmiNa0QU6QsZHZJqZkbbPIK8dCR56EdtXyose4pUFwwzUiY1UlUanZh/EOgm9qGNxKwpcDywC8zscVck3BKOySdhPTc1gpmKJkgE8v2gp/YXbQYEkkgNLQyvBAsv0JQ1vACiJJoCHaj1T0Qx718fN6HkuEV/WBB8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SH+Npp7zGYpYM+WO4iZx2VW/zbMhGhXlzkbgJ821i4=;
 b=VsIV0nnbvIsd0fJ6aP18fY/U0+GiSICD184XhqlT+2Dc59pzaF7eFvNKUwvaxlAjDD6LDSNSEB8o8QOi18ICdDN82eVXtoF/ly593wzuucwdI2/h+BcD3q23vp011Je3og/5u5TFTmyR/hE7WO6tL6A0M/DHdr791FxRJ7kN/MlbLxK0hggWPk8DzdVWESS/EvVF+g7RGTfuJgu25wbP28XgwvxdqJ7/UEyOFY+zvjGWwtHxhu688YfuaqVGyxPCrAlTUGbRciNzBdxz3PYIyGzQkGeRt6yioHGodGDaMXprtOWf6mCusHhx0ZpjkUNDEtKDZc0DdigsTDUYIHycYA==
Received: from MAXPR01MB3984.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:68::20)
 by PN0PR01MB6547.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:74::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 09:51:43 +0000
Received: from MAXPR01MB3984.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::285f:e601:b80b:465a]) by MAXPR01MB3984.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::285f:e601:b80b:465a%6]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 09:51:43 +0000
Message-ID:
 <MAXPR01MB3984C307B163E615811A25AAFE2A2@MAXPR01MB3984.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 29 Nov 2024 17:51:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] PCI: sg2042: Add Sophgo SG2042 PCIe driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: kw@linux.com, u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu,
 arnd@arndb.de, bhelgaas@google.com, conor+dt@kernel.org, guoren@kernel.org,
 inochiama@outlook.com, krzk+dt@kernel.org, lee@kernel.org,
 lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, pbrobinson@gmail.com, robh@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
References: <20241112212055.GA1859446@bhelgaas>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20241112212055.GA1859446@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::18) To MAXPR01MB3984.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:68::20)
X-Microsoft-Original-Message-ID:
 <2f2a60cb-265d-49db-af8d-72ca67d75a16@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAXPR01MB3984:EE_|PN0PR01MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 90278b0b-9649-4e6e-f44a-08dd105b6e30
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|461199028|6090799003|8060799006|7092599003|15080799006|10035399004|3412199025|4302099013|440099028|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTJxVHNlRW5SRlN1NUZpcjh1MjhiaGt4NW5MSENBbUduYzR2eFJhTlBqWm1B?=
 =?utf-8?B?UGwzOExFcmFpN1hoMUpuRkdUazJvY0RpRzMrQ1NubFgrVFJqV3Q0V1cwelc0?=
 =?utf-8?B?bXR1S0NCSVlvWkRkbXUrMlhqSzY5YXZzamhPOFprQkpOSE1RRmZDR2pGVUxw?=
 =?utf-8?B?MjB1SVdlUEczNDdjdDZ3WVpsMnBBeDVOcXBuc3pJYmdlZk95OGlLTGVmR0JW?=
 =?utf-8?B?RzJobm5JZ1BCNG9GdmdyTVNOdXR5bDhtaDBEa2hZbHplc0lQRWhDMUNUamRt?=
 =?utf-8?B?OE5Uclp6eUZiZ3JjWkQxUmxLR0JlL2Z3Vzd1c1k2MERGWmNFTXdUTGVvOWJP?=
 =?utf-8?B?cENWSEdtczAvUTcxU2Rsdnk4RzF1K1MvNFFwM2dZLzltVUdwZU41MjlvTnF1?=
 =?utf-8?B?a2lNQXpMQ1cwVnRrZ09nZHVzTkZJV2hVL1krMDJEYVkvTG5WRGZBQTg0TC9r?=
 =?utf-8?B?enFDdHN3ekhyS3pDYmtIaHAvVitKenRwQTVDaG9vZXZKcUtXRmZjd25TcVlh?=
 =?utf-8?B?Z21ZZVhsL3BVTjR0ZlhRUUxDMjRNdXZUZFJyRVZ4akRUTjZxNEpjNmlNdGxa?=
 =?utf-8?B?QjBsd2RsSmxzNEdxNUk2SzFYODZMQWFBS0ozRzQxZVVoL2d5RXh1ZDdhc2No?=
 =?utf-8?B?MWpwVUM5TlVCTnBSU0F4cVVESWpaWUFkcVJad2h5UmNWSDd5Ly9TS1BWTnRC?=
 =?utf-8?B?b0loREM3V3hyWDNqbjkwbWhhZ2IzQzR3ZStRZjFYOGFTYXM5VUxNOGh1VFFq?=
 =?utf-8?B?QlRsaXcwQ3FiUWJTK0NDOWpHTm9rQSt6QjRkWXNZa0U4b3dFbmthcjVwSDlG?=
 =?utf-8?B?RFlxckg2UnhUbktOMW1WRWV4dWFkSU93NmNBUGxYSHgwU1Q2SXY1TkdTRHJQ?=
 =?utf-8?B?TnFzT0V3ZjB4bzdGVkhyTytPZXZ6M1lENEw3bXJDQmYwYzJBODVOZlRtQjh4?=
 =?utf-8?B?OTNKWUFod1lHclpZZTYxSHNFeG83UE9JaVFnbTA3cEloK256OUt6dmlLQU5L?=
 =?utf-8?B?MGs0bGxkV1E3RkE2RTlRNjAyREVQYzExZGVVYkcraFZTTy9sQmVOQjdHR1FD?=
 =?utf-8?B?eUF2bHBjcW1RZEloWGpjZ1VtZ3I0K0RQK2ZLSThkMDZqNmRySmpOUm9uL2Q5?=
 =?utf-8?B?aVBUM0pqMDZaOU9mZFFieHZtVW5uS3BaMGxQU1V4VmxycEllMExWcXRNcVpI?=
 =?utf-8?B?eU1EWCtBK0YxTDRCQ21jTlZBWUY3OU1kbUhHSlVnWDVJaHNZZFdmL3pTTXVP?=
 =?utf-8?B?dFI0RWVTQ1RVSDE5Tlp5RHpzVk0yeFJGcEVDSHF2em9RenAxUFJxUm5mT2RH?=
 =?utf-8?B?N2NqcE1CUk1QV3g3TjBGZVhHV1lDRGR6MVRtWmk3NWFoVXdSR1dXZXRKQ2ZP?=
 =?utf-8?B?dS9ybmZSS3VON1o2RU9NTnhoRUF1a2dKSWFjZE1YY05MQU5MQnFSaXNVOWN6?=
 =?utf-8?B?L3Q4VWNZN0FTd1NJbTZoQ1ViZ1gycksyK0hBbERxS1RPVkxER3FzaEVBV3pr?=
 =?utf-8?B?Q1FtOUpCYnQxK0N6ZklMSTd2S2JVM281Y3ozbzNWN2kzRU1PVDJmUDZsS1M3?=
 =?utf-8?B?N2VCSnJqMVUxVUl3Z2pNdlpnLzVnWERLVjJRZ3lGOUxHKzBOcjVLc1h5Z3Rh?=
 =?utf-8?Q?aN41BPNcMP5LQ/lbj+KcNlNKBCoVjQxFyhH75sfIFNtc=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1V3Ykc4cDM2eTlGWjJKeU9WN3VuM1ZZc0xPVUFxSXE1OVgwc1VTOWVmWVAy?=
 =?utf-8?B?UkZhZHRMWVhyY2NBS1pmZXN3bWJrdlVjZkY5bWFWaGZhbi9WbWNQVzFxbFpJ?=
 =?utf-8?B?YU1VU3FnVnpuaW05WmNTZHpyeGltQ3BnT0xHTS90Q3hrRVVkbk51cjNtUEVH?=
 =?utf-8?B?UUwycHZ3WEUvR1Ria25ONTBaRlBFVnkyRlluQzNET1AvK1Q2MlJwZTgzdTRU?=
 =?utf-8?B?U3ZaVTFpZnh1L1JZMG01MktWM25xZk9uQS8zZlllT0p2YmV6VllwTEJVM0Vq?=
 =?utf-8?B?UTNtcHJ0VWJqOHYzZTh5bjZ4YndvQ3VRL3NWbTFxd1REWGJzdzdNdk5mczYw?=
 =?utf-8?B?QTEvQ3RIOEQzVTQ5cW9mWGlYYURGcFhNbm1VK3NJOVgzZi8rTFlSTXBxY0hv?=
 =?utf-8?B?QWREeVVkUFRiYk1HVE9hemJ3SHFyVXYzYjh1TXoycnM0ZGYrZCtra2xBYmc0?=
 =?utf-8?B?clhTVllmQ3o0eTJXanIzRHE2cGwzQzhtcUp5R0pxZW5ueGVUSTU1Vlladk9n?=
 =?utf-8?B?b3hrYWtpdG9XR0NWSk9CN1pjN0Ewek5HTkU3c3VMM3lRTXE5dFQxZXl0YUla?=
 =?utf-8?B?UGNYNnN0cDhSNVZ3UThjR3RaQXduVkdLcDBNVnlTMTJGMWYzY3pWU2JZdW1k?=
 =?utf-8?B?MEl5aFF4ZEEzZFlmQ2U4d0xUZXVuS0l3VDc3TmFacThBakM5WlNzaXBkOFFy?=
 =?utf-8?B?d0pqL1liWitFR0puMXZ2cTlqSHdDVXF5MVRySFhRT2pDMWdNQnpydTVqemJt?=
 =?utf-8?B?Z0gveWJJVm96TU1LNDBhaEZ5QXQ2cGwrelh5OWVvc00wc1IyekxlZ2VGdWVE?=
 =?utf-8?B?N3o2eDlwVlI2YmdKVEM5UG1TcFdvcHFsSG1tRGdVV3BobGdvZTRacVgrTnZO?=
 =?utf-8?B?UnFUaW9iTFFWNnAyUXluNWJWeSs0bFdxdkZud0ZTVGtmUlFPc1oyY2ZtSjYy?=
 =?utf-8?B?MmE2akZPa1dqejl0R2gwVC9ueDgrL1FvOE4zdWVHWnRrT1FYWmI0eUZnSk9V?=
 =?utf-8?B?MGVOaVh5VDNHSFdlNi84VjhFa01XOFRpblZUTTB6ckZtZmk5dzBvdlhoUVZa?=
 =?utf-8?B?MVRTMXVqYnRjbFJkcTBycE5uWVRkR2wwelRnZUVyTjQ0TE1SVWVHWjc3anJr?=
 =?utf-8?B?KzFzZmxIKzljR2JaRjhocDlUUEJqbDh3bVAwYUJzdkowR3ovTUJzZDgyZ3Vq?=
 =?utf-8?B?ZlhjTHNyRHExaXhaK1RVUjZsVDVNSG5IOE1vVVJQdHFGT3hnM3lzOUpwOG1F?=
 =?utf-8?B?YTJxZFNxWjZybCthQlY0ZTExWVp4akdoM1hqRzhmdzllK2lOZW53bE54dXN4?=
 =?utf-8?B?S0tKR0pmdzZCV1ZMQUgxVjdJWVlvQmw0bnlvZG42VGFYbzhPN0p2RElDekVU?=
 =?utf-8?B?QllxN2FJOHNrWE5nMStXUzNrdzdvRGtvdjBnaHcvdGlHdnUrV01MRllpRG9G?=
 =?utf-8?B?YlJud01oQVlNMmNSLzAvWS9ibEdzVmd0d2VvUXlwbUhYWXlIb0NuLytQMGhy?=
 =?utf-8?B?K2tlL3hEcXo5Q2hUb1RHUG5xMGsvQ3hkMW1ZMm1RbGZwL2Z5YXlaN3R0enpj?=
 =?utf-8?B?N2tuSmhreEdvNy9zeW9iekN4WGs3eHVUL01RWEJzQndhMmlrZ1VhSThTbG5G?=
 =?utf-8?B?aFJZZFhPa0dLQWpONnNVb2hNVXFEV1YxT01xaUhVQ3NXelIxZlZNVGkzZ2F1?=
 =?utf-8?Q?3zauP1m1V0FM6EtNJbC2?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90278b0b-9649-4e6e-f44a-08dd105b6e30
X-MS-Exchange-CrossTenant-AuthSource: MAXPR01MB3984.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 09:51:43.7661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB6547

Hello~

On 2024/11/13 5:20, Bjorn Helgaas wrote:
> On Mon, Nov 11, 2024 at 01:59:56PM +0800, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add support for PCIe controller in SG2042 SoC. The controller
>> uses the Cadence PCIe core programmed by pcie-cadence*.c. The
>> PCIe controller will work in host mode only.
>> +++ b/drivers/pci/controller/cadence/Kconfig
>> @@ -67,4 +67,15 @@ config PCI_J721E_EP
>>   	  Say Y here if you want to support the TI J721E PCIe platform
>>   	  controller in endpoint mode. TI J721E PCIe controller uses Cadence PCIe
>>   	  core.
>> +
>> +config PCIE_SG2042
>> +	bool "Sophgo SG2042 PCIe controller (host mode)"
>> +	depends on ARCH_SOPHGO || COMPILE_TEST
>> +	depends on OF
>> +	select PCIE_CADENCE_HOST
>> +	help
>> +	  Say Y here if you want to support the Sophgo SG2042 PCIe platform
>> +	  controller in host mode. Sophgo SG2042 PCIe controller uses Cadence
>> +	  PCIe core.
> Reorder to keep these menu items in alphabetical order by vendor.

Sorry, I don't understand your question. I think the menu items in this 
Kconfig file are already sorted alphabetically.

>> +++ b/drivers/pci/controller/cadence/pcie-sg2042.c
>> + * SG2042 PCIe controller supports two ways to report MSI:
>> + * - Method A, the PICe controller implements an MSI interrupt controller inside,
>> + *   and connect to PLIC upward through one interrupt line. Provides
>> + *   memory-mapped msi address, and by programming the upper 32 bits of the
>> + *   address to zero, it can be compatible with old pcie devices that only
>> + *   support 32-bit msi address.
>> + * - Method B, the PICe controller connects to PLIC upward through an
>> + *   independent MSI controller "sophgo,sg2042-msi" on the SOC. The MSI
>> + *   controller provides multiple(up to 32) interrupt sources to PLIC.
>> + *   Compared with the first method, the advantage is that the interrupt source
>> + *   is expanded, but because for SG2042, the msi address provided by the MSI
>> + *   controller is fixed and only supports 64-bit address(> 2^32), it is not
>> + *   compatible with old pcie devices that only support 32-bit msi address.
>> + * Method A & B can be configured in DTS with property "sophgo,internal-msi",
>> + * default is Method B.
> s/PICe/PCIe/ (multiple)
> s/msi/MSI/ (multiple)
> s/pcie/PCIe/ (multiple)
>
> Wrap comment (and code below) to fit in 80 columns.  Add blank lines
> between paragraphs.
Got, will change.
>
>> +#define SG2042_CDNS_PLAT_CPU_TO_BUS_ADDR	0xCFFFFFFFFF
> Remove (see below).
Yes, after some testing, seems this address fixup is not need, will 
remove it.
>> +static void sg2042_pcie_msi_irq_compose_msi_msg(struct irq_data *d,
>> +						struct msi_msg *msg)
>> +{
>> +	struct sg2042_pcie *pcie = irq_data_get_irq_chip_data(d);
>> +	struct device *dev = pcie->cdns_pcie->dev;
>> +
>> +	msg->address_lo = lower_32_bits(pcie->msi_phys) + BYTE_NUM_PER_MSI_VEC * d->hwirq;
>> +	msg->address_hi = upper_32_bits(pcie->msi_phys);
>> +	msg->data = 1;
>> +
>> +	pcie->num_applied_vecs = d->hwirq;
> This looks questionable.  How do you know d->hwirq increases every
> time this is called?
Thanks, it's a bug, I will fix it.
>> +	dev_info(dev, "compose msi msg hwirq[%d] address_hi[%#x] address_lo[%#x]\n",
>> +		 (int)d->hwirq, msg->address_hi, msg->address_lo);
> This seems too verbose to be a dev_info().  Maybe a dev_dbg() or
> remove it altogether.
Will change it to dev_dbg.
>> + * We use the usual two domain structure, the top one being a generic PCI/MSI
>> + * domain, the bottom one being SG2042-specific and handling the actual HW
>> + * interrupt allocation.
>> + * At the same time, for internal MSI controller(Method A), bottom chip uses a
>> + * chained handler to handle the controller's MSI IRQ edge triggered.
> Add blank line between paragraphs.
OK.
>
>> +static int sg2042_pcie_setup_msi_external(struct sg2042_pcie *pcie)
>> +{
>> +	struct device *dev = pcie->cdns_pcie->dev;
>> +	struct device_node *np = dev->of_node;
>> +	struct irq_domain *parent_domain;
>> +	struct device_node *parent_np;
>> +
>> +	if (!of_find_property(np, "interrupt-parent", NULL)) {
>> +		dev_err(dev, "Can't find interrupt-parent!\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	parent_np = of_irq_find_parent(np);
>> +	if (!parent_np) {
>> +		dev_err(dev, "Can't find node of interrupt-parent!\n");
> Can you use some kind of %pOF format to include more information here?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/core-api/printk-formats.rst?id=v6.11#n463

Thanks, will double check this.

[......]

>> +	if (pcie->link_id == 1) {
>> +		regmap_write(pcie->syscon, REG_LINK1_MSI_ADDR_LOW,
>> +			     lower_32_bits(pcie->msi_phys));
>> +		regmap_write(pcie->syscon, REG_LINK1_MSI_ADDR_HIGH,
>> +			     upper_32_bits(pcie->msi_phys));
>> +
>> +		regmap_read(pcie->syscon, REG_LINK1_MSI_ADDR_SIZE, &value);
>> +		value = (value & REG_LINK1_MSI_ADDR_SIZE_MASK) | MAX_MSI_IRQS;
>> +		regmap_write(pcie->syscon, REG_LINK1_MSI_ADDR_SIZE, value);
>> +	} else {
>> +		regmap_write(pcie->syscon, REG_LINK0_MSI_ADDR_LOW,
>> +			     lower_32_bits(pcie->msi_phys));
>> +		regmap_write(pcie->syscon, REG_LINK0_MSI_ADDR_HIGH,
>> +			     upper_32_bits(pcie->msi_phys));
>> +
>> +		regmap_read(pcie->syscon, REG_LINK0_MSI_ADDR_SIZE, &value);
>> +		value = (value & REG_LINK0_MSI_ADDR_SIZE_MASK) | (MAX_MSI_IRQS << 16);
>> +		regmap_write(pcie->syscon, REG_LINK0_MSI_ADDR_SIZE, value);
>> +	}
> Lot of pcie->link_id checking going on here.  Consider saving these
> offsets in the struct sg2042_pcie so you don't need to test
> everywhere.

Actually, there are not many places in the code to check link_id. If to 
add storage information in struct sg2042_pcie, at least four  u32 are 
needed. And this logic will only be called one time in the probe. So I 
think it is better to keep the current method. What do you think?

[......]



