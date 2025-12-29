Return-Path: <linux-pci+bounces-43783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFC2CE59C4
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 01:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6CC75300182A
	for <lists+linux-pci@lfdr.de>; Mon, 29 Dec 2025 00:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD352AD0C;
	Mon, 29 Dec 2025 00:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XrwlQDsr"
X-Original-To: linux-pci@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011035.outbound.protection.outlook.com [52.103.68.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2273A1E85;
	Mon, 29 Dec 2025 00:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766967473; cv=fail; b=uUmerMLIXkyPFf7nPgCm3FflhIZbRwHM/dvcXO/fsyKJNBUO+gnHl3YrwH0glRMBHuYnHmNZIlHl75F/tq+mZ/Uaik2QFUElSUBH001lqabe201TtDKU661VvFnj2Llub6dPJX5yzuEguQCh9jYTUDv83IWgKtZFDxmpBjb/TS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766967473; c=relaxed/simple;
	bh=NIvoYB9iyKdg9hbdMaa/ihDfKxYBJEFw6Ax8BGPCzGc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FRuYlVqOiBxuaDyFhUzk81Rd5HFaaMTyBkWGrCo46yJ5UTcx+mRQW6+6Evz01ansJY0sBDI5DsOVSMIq8mUHa7iVEmlpzvbmIpNVBhPLVC+aWDVVCUtO/cLf+Jg5bZ24aZ0BtlXrrtwwkZp94yCaNCpSWHoOw0VdndKVT6Dop9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XrwlQDsr; arc=fail smtp.client-ip=52.103.68.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apmqgi4guKhxj0DXxLoclTn4BakaY9CgZBxpAaOLcPM3zX8BNazouXACqmBvfyBqHcKxmiosDcQSre9hBXJKGQZJ3mZWVxONIVbeQL1q37BDRaPehWczhQ/H1BlOBNFf/DDhGYKrUbeC0e1qZTd+qgAMyz+BNfDqP39dkg1pOYE2SMr/Xc97ELEtOVXvz+nq2vHasVl+9FrePrj4Ui2ZeZ8/32iGMguOUO7ZYpVHrNoXX6xmM56W4XzFWW/M0CuSiMFqt06e9ZTmoW4n5roXcPI2NCveJ10cx8SKaUNFCPEiu/ky1XeK+i9pEteQCoOv81mEie1wdYrGSsHPDBSTKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qz1WFvwxtPwL0js/kWKz3rbyq+auqVkPxKAyYv2B0K0=;
 b=Q2+RDn3JBx/qLn8WiUhQhQnMBME7WyFkjQCUOmZ8n3ROKgstXfYSGDnfUUstkmb3LwZsHuHV3rA9qpdg5eb9/YJF702j+XbnG0rFOHFZDzDn8RDfTuTIjQJ0RPmuOLutCK0niN2dTHdkUu5wm2hh++t+RmIlAFSmCtW6aXrBiAA3U/zeFQyA0L/ziBMNTbHOdcqef+iChXVasZ1+2fpKv7TkY/V6maZ4pFEk1cNJ8XrbsQ5XlqEEHacls5GZ6LsAWVDy3KOHhQeVtgNmLBeHFoY+/aP1ydcZXN6vOg3cjvlMSOaIkevwQS5su2cCud3YdvrHhVMe4qht9Qkt7FAApA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qz1WFvwxtPwL0js/kWKz3rbyq+auqVkPxKAyYv2B0K0=;
 b=XrwlQDsrUR5c2rWMfYOnpcv0RwHEsisLmIR7jXbEK+9kc227AJYzr61Vi+znCaVxy34x7jgDWb2wR6rUded6Rt9rTJWxw2O2WPDPzllYSzSG2I+lxiX64eoPlVqt9Ak+ut9AMziiPP5MpJcRSTn/G+5RQ6tQUiAYobk3e4rBiMhPsgZHvhYSr0fPIPoF30EcD3a+wxtiijv/7uOK60qAHzkD7DQ8qwWVaMNAEgeP8uWSPbJT8dUtNSvUJtH/h/xxV4NPrXo990igdRVBVSTBXDicpSF/SkEWEklKagJV0Dh2EvRES6lEU3RgmXPTJq86UmwADNj5lMel0FPY8Wokyw==
Received: from MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1e9::18) by MA5PR01MB11147.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 00:17:46 +0000
Received: from MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8a6b:3853:1bc:67e4]) by MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8a6b:3853:1bc:67e4%6]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 00:17:46 +0000
Message-ID:
 <MA5PR01MB1250074A97978ACB5C88D1363FEBFA@MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 29 Dec 2025 08:17:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] PCI/ASPM: Avoid L0s and L1 on Sophgo 2042/2044 PCIe
 Root Ports
To: Bjorn Helgaas <helgaas@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Han Gao <rabenda.cn@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
 Longbin Li <looong.bin@gmail.com>
References: <20251226163031.GA4128882@bhelgaas>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20251226163031.GA4128882@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0171.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::6) To MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1e9::18)
X-Microsoft-Original-Message-ID:
 <310493fd-dc20-4530-bc2f-0cecb9ec22e0@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA5PR01MB12500:EE_|MA5PR01MB11147:EE_
X-MS-Office365-Filtering-Correlation-Id: a7d09311-fb16-4447-1a77-08de466faffa
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|23021999003|15080799012|461199028|19110799012|1474299035|8022599003|5072599009|8060799015|4302099013|3412199025|440099028|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkVBbjlSb1JTYTlrV2lJaTVrSTA5Nmp6dHdiZ0VWbzFiZzJxRDhpaGFqWVF1?=
 =?utf-8?B?alM2MFhXdElsOStSQ2VPc2lVV3lzaTE4WWtHSkMzcjRzNDRGUWFtc0k0dTJ2?=
 =?utf-8?B?aFR5ZFIreVM5SHlYb1RRZ1VzN2dRMUY5eUVLeHhvc0JuTUNkdC96aUlGaXB6?=
 =?utf-8?B?TEREaTV3d2FmVzZ0enN0amJMUVRLb1ViMDN0eXlBN2ZJbVMvWlgzRDhpeS9P?=
 =?utf-8?B?UllUVkljVFVjUjh6YmNGek5HWStpekQ4Nm9adUZBcHlBZlduSHdPalRSNjlp?=
 =?utf-8?B?cHRERXp4c1g2WE1BSW1KUUpTOE9UL3NjRnAwZ3U1T0N1MnJkODRaaFg2K3Fv?=
 =?utf-8?B?cUZ3Zk9CQzZlVVk4UmNmdHAxNWZLU2dvb0hJOUU3NEMrVHZKUlJQMTE2d2VJ?=
 =?utf-8?B?ekhsRGtkSmUwdWhhZm96WUx3UzJBbEJRaU1XWkpVSzVLejVkUEhkdi9oQzNW?=
 =?utf-8?B?bG9sOFRZcHoyc1VveDJXZGlOenJlWU9XNGQ2djVsbCtxQThWWDZ6M1M4ZmJ6?=
 =?utf-8?B?emZtZGxjc1FEOVdCMG4zbkp6cUNmZVM4dWgrV3dEYzMxeno0Rmo2S21GZGlV?=
 =?utf-8?B?ZTQ4U29CWDdiY05DVTk0NUlieDVtOEtWUlljSzRVajd4am0wU2ZwQnZJTkZI?=
 =?utf-8?B?Q1RPbWY1ZVR4aUNZTFFLMXN6bE03RHJiSmFuUktoaHdKWG5NTkpnOGxoVjNG?=
 =?utf-8?B?YUxTb0c1aHNVczdkL1FjYTFCcmdMd2FZZ2NnMkI5RXYvR1pEcWtkUzFjZzhq?=
 =?utf-8?B?OGRBRGRmQ05tZnlsbFd5eVdHWlIwQUZ6VFVRSjN5cFdENGZWR2NvUFNPTEx5?=
 =?utf-8?B?RlA4cmhjQmE0Z3RnY0d1S09lQTk1UVJjRHUyeVlQTWJNVDFEcituTVlqZTll?=
 =?utf-8?B?bitrYU9ISk1zMU5DQW5YMGhxK09DK1dZK2RVRGJ2SkpuNklJKzcyUENveENU?=
 =?utf-8?B?USs0WWRtRXRYNHh0SG4rRW8xamE0YUkrNTVyUFg5VEpDU1J4K1lhZFU2MDdD?=
 =?utf-8?B?QjlsQzN0OU10U1V5eVZMNXdxOEI1Nno5ckJTL0lWSm53QVE4bUowK0p6RHRv?=
 =?utf-8?B?Nk1QZlJhMEdwbkFvN0ZjdjdaUWxjNmVyTG85Q2xFcUJLZzJnZTVFbVV5OXJy?=
 =?utf-8?B?Qlo3VDVSVXlja0FtdEFOUGUrdTA1cTNNcnljN09iRENqVzV6MzdJQzI5MHBh?=
 =?utf-8?B?OSsrVGVhb2NxbFdHSkJJTGw3TC9sQTJpWmU4djhmRVpQVjZ6bS8wdkNzQjJy?=
 =?utf-8?B?OXJxTndRRi9xUW9naUp4MVZpeTlwS2dyU0N1VWhJNWw4NFZxMlJKNTZyM1kr?=
 =?utf-8?B?UkNsOFlLVXVKK2dYN3habFpnWGZXYVdmUCtuUW5oTVNLZndFQ0c2KzJuTUFC?=
 =?utf-8?B?QWxYZjdKTWxWUnQxWmhObnllK0tiRzQyL0RqSmljV1hva3FIaUY4Ujh5Snky?=
 =?utf-8?B?TnRtbnNPcGNmOVdJTzdMT2o3YVR2aDU0QUNDTkpnd3p5NkJiSjJnU3U5YkY5?=
 =?utf-8?B?SnF6SXdrK09maDJsYkZKdlJFNUszTzdrQnh2STI2dVA3aEoyK3FJUHEwWGM0?=
 =?utf-8?B?TzJXL0x6Z25ZMlppOVBqMzFkWFNHQlpXWStzZlhaM3hxWUdpQkNIRFdsNHkr?=
 =?utf-8?B?ck03RlJuSkVoYWh1VmVGYlRmZ2pkbmY3NGMyVXBoWkFNMkNlandTWTZWUHky?=
 =?utf-8?B?VmsyUVhGTXRtVTBUTm9MSWRQMlZGOWI2OFRtMXpvODEzcEJYcGd2SlNKU3l0?=
 =?utf-8?B?emk5ODJuMlN3NDZWaUozUjhOdDg5UmVFVGdOdjc3MzQyQmVGL0VxMXhTQ0Nr?=
 =?utf-8?B?Z2xwNTlZUk0rNVpmMzBhQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uk8rdTN6V3dtNFBvZUdqMENUTlRSemFhVmswRkZLMnpEc051WnpRRGd4ZEw0?=
 =?utf-8?B?QXBVYi9rTVJER25xU0pWYmhRTERZSzVHWHJZMjRlZFFmeG5nM05kZ3N0Qkpk?=
 =?utf-8?B?SDdNMnM2VWdHRmtKL29hdVZVNWZVZjVzajhjZlVaZnlqNFBMaHpreUdqb1ps?=
 =?utf-8?B?WUphZERjU0Jhbkd4YzFCZ2p6Z2Fhc1B0OWhUQ2JKWEN3ZkhQOExoZEtUTjRt?=
 =?utf-8?B?aVFoN3BnM1cwZTUwQUJueU9kMWtibXd6MGl2L1RuZnVjQjRiUHUxbnNTYVF3?=
 =?utf-8?B?bGt2dldYUHhhdXg5cjFvQXI2SWRkZDB6VnZVT2U3aHBTd21Xa3Z1aXgxZ3c0?=
 =?utf-8?B?UnZXQzlIWk5yMDhnTllvUk52c2tsaVcwaHQvYnFvLzdheFlEZXBiWTBPSlV4?=
 =?utf-8?B?UmorOEtIWlp4ampTQXdtWHBFMVNhU2RxZjhIR1RQZGpFdEQzS1VmdTBCclRB?=
 =?utf-8?B?bGlMcWR3SVE1dXNRRVVueHlrMVd5cjR3ZVJYK2VBdVhwTFVIVjlCOTB6emxv?=
 =?utf-8?B?Y29WVFZwcGNNVlpCR1lyT3YzelRRcmRPQXl5L0dBRElpWnhTelFwcWRsQXpr?=
 =?utf-8?B?Q01nTGxCbXM0YlBVMlZhMUVZRktFdndPSHlVS2ZSdElKTnRrRkd0L25YOFpC?=
 =?utf-8?B?SjdnMmRKaVNBMXJGZjZ3dG9YajVTNWxvMUNUb0o0ak5vMDY2d29Nc1VJYy9Y?=
 =?utf-8?B?ekpHMEtVQTRoY3FtVEZvOEd0amZwQmJRbVFGUHVIOFYzSGNVUElVelNRNk0r?=
 =?utf-8?B?MzJ6OTUxUk1nemdEN1pKOFZIWTRYRmlObHp5cEQxVmlCaHhQUEExMi90blJn?=
 =?utf-8?B?bytPbDN0a0ZaSlhBcE93dWYvOWVHSk9MeXFmdFNqWkZMN1ROMGxJbkF6OW1x?=
 =?utf-8?B?WmhKbjBNbXoyUVZYZzY0U2JxeCt4WGVxVUg2Q3NjNmZUZ0cxVVlwMjlRUyt6?=
 =?utf-8?B?b1E2UzB5YUFiR3hNN2VsK0hDZTdySWhoa1E0ay9ybnRucmhJY2RmcFRVbGN4?=
 =?utf-8?B?VUhId2k1cE5lNmVYSFdKWWs5NjN3RHN3L1gzQkFUdGNTYTdpS2pQcG5SUnhS?=
 =?utf-8?B?cFNnZDg4cStKTjZMVFgxb01yWUhPVkpJbmxOMU00eHhFRmNkdnVaRkVvM0c2?=
 =?utf-8?B?NzJROWZVV09LYnRlZ3JqUXZuRGRVRlZUbEJQWXRXNmEyU01NY1NSekI4SWtF?=
 =?utf-8?B?QkpPOXlwS2F4QkplTjJPbHlIcnJqd3B5RXlhbEhhb0dRQWQ4UXlmaFczUGpy?=
 =?utf-8?B?aTFDMTJOTFozbFYzcFQyTlAyUmpHZGgzdldGdU5zcjBSTmVKWk16R05HQ29o?=
 =?utf-8?B?RU9EMnAwRWYrcFJsMmwzLy9IZG80cmFMc1NBTjYzcE1ReXBWNjArZmtKd1Vi?=
 =?utf-8?B?NGhDTzNBT3NMY0tnT1k4blVBc3dOVnB1VDBOOWUwTmx5bHZQNzhRM2o3R202?=
 =?utf-8?B?bG4xQ2diaGl6TUZuTzFxTmh3OUQ4L2xsUlNYTDVrVTBMVVd5QmR3MU1tR1pO?=
 =?utf-8?B?K2VVYW9wUnFMMUlwRzVMYUhhaXZHNUxNcDZyT0doTlhVd0w3QTZPU1lBeVVs?=
 =?utf-8?B?b09TV3VndFZDMWxXYjlaMDFGNFpaVGd6QWY5TFVNdWNwU1AwZmhtMnczaVRI?=
 =?utf-8?B?bFZNaFpOVFVlQTJuVXAyb0wrZFNEazdvKzhxQjJDVFpEcFpORFZveVBrK293?=
 =?utf-8?B?V3FtNEkzY2lPakpiYnRpamtzTXlJcU4rcnpxdW9oZnNXYnZqRWszb2VDdjNL?=
 =?utf-8?B?TE81eHJBT0FZV1Q2RUJpTWNpWjJodTRCYWFNM1d6eEhPcStPRDMrMUlhdDVC?=
 =?utf-8?B?SlhTOUtkS3F1aFBhUE9CL0pFZVdoU1lZRjNsUWN0Q2MzNUc0a2p3WldiaU1O?=
 =?utf-8?B?WW8rNElrOEU2QmtsVTc4NXBSVmlMM0NaR2FPbmtUblNzMkw3dFZlY3k3U0Uy?=
 =?utf-8?Q?Y7ya5bGE0QdsFHGjggj4/e+7t/qnKQFD?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d09311-fb16-4447-1a77-08de466faffa
X-MS-Exchange-CrossTenant-AuthSource: MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 00:17:46.1925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA5PR01MB11147


On 12/27/2025 12:30 AM, Bjorn Helgaas wrote:
> On Thu, Dec 25, 2025 at 06:05:27PM +0800, Inochi Amaoto wrote:
>> Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
>> states for devicetree platforms") force enable ASPM on all device tree
>> platform, the SG2042/SG2044 PCIe Root Ports breaks as it advertises L0s
>> and L1 capabilities without supporting it.
>>
>> Override the L0s and L1 Support advertised in Link Capabilities by the
>> SG2042/SG2044 Root Ports so we don't try to enable those states.
>>
>> Inochi Amaoto (2):
>>    PCI/ASPM: Avoid L0s and L1 on Sophgo 2042 PCIe [1f1c:2042] Root Ports
>>    PCI/ASPM: Avoid L0s and L1 on Sophgo 2044 PCIe [1f1c:2044] Root Ports
>>
>>   drivers/pci/quirks.c    | 2 ++
>>   include/linux/pci_ids.h | 2 ++
>>   2 files changed, 4 insertions(+)
> 1) Can somebody at Sophgo confirm that this is a hardware erratum?  I
> just want to make rule out some kind of OS bug in configuring L0s/L1.
>
> 2) Why don't we have a MAINTAINERS entry for this driver?  I failed to
> notice that the series we applied
> (https://lore.kernel.org/all/cover.1757643388.git.unicorn_wang@outlook.com/)
> does not include a maintainer.  Chen, since you posted that series,
> are you willing to sign up to maintain it?
Sorry, I didn't realize I needed to submit maintainer information 
separately for each driver when I submitted the PCIe driver code.

Yes, I will be maintaining the SG2042 PCIe driver. Do I need to add an 
entry to the MAINTAINERS file?

Chen

>
> Bjorn

