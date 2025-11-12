Return-Path: <linux-pci+bounces-40979-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DF34FC519AB
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 11:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1960734AB11
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 10:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F29E30147F;
	Wed, 12 Nov 2025 10:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="lUwCgKTv"
X-Original-To: linux-pci@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013052.outbound.protection.outlook.com [52.101.83.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF98E2FFF9B;
	Wed, 12 Nov 2025 10:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942654; cv=fail; b=n/1MzR0ZyZ7IcUOV9NYkiZwCMdsAooDkKKHQT5y5CMwbVsWEl57y054UBBNsb+S0EhJowYwBi3TgMuDlSM+7p0cFpzDNaKJsY1umw0ok5cemMoJE0RxFsWiulEH/fX0bGqfVstC8/yx/evf7EhE2xJJ4WZmtdzxqNM1YyZXqZG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942654; c=relaxed/simple;
	bh=GPrGAwr4nUmcIroIDeaqhigTTdz78P3h5RYyTEFOQYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=npzNy9v1P5+rLOeeSVFi7Bh34IbzDiVegRfM7t/yaQ2FZnEnQEKrjQQFKyaX5DKsJ5WnWXlQNbywVDuFP5z2qCiRa4waMLHRAG+lEDCHQy/SY9jKTMSifgv8mQeHb5IvOWGq943Y3H4/BnCjL+KrUxSxjtL6PwMF3KJGTE6S97g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=lUwCgKTv; arc=fail smtp.client-ip=52.101.83.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9QJQUIx0GD6viMuAL8ifCCITw+kS4WPxxY2Q/0mGUMDo7hfFiqag50bD2bxL20JSF6CD65Ojy9ZlhnsS7TuLzQTo+pwycPoVPfGJQtHhgX+ImsTZPiqYBKm7ns4BPjZHd4BkBdazq4BMxWIZwbBjAYDCQXiOvgXUWZhRXBKL3M6CgUUIrkPh+//26Aow7k6Jomn267w3viuAtSEGj1XwMU657fsKapi7xz7CLfXEAopvWCyv1Q/aFopF8RCiMDZktEaoaG14lECvGxL2B5e8RpQPXIG8EFfQ+nomPoeiQ1rn1RlV119Me01BOG9O4zqVha8F5BwFpK1BD4YhTDZEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xq4y6eFHSdgMq6ZCAy4NcIPKreRt+m7Azjuv9LKrxWk=;
 b=lACkUFT5FFW8/TLtC45dHaVYns2uqzYyHZs3BtozPoxdGPbOVLwCEPc5DGD4j/PS2dgYf2+lV3WlKuAP6hkQNvRE9eRrS9CzD+Jd09mupr29aHBJAI9NkUeg5KwHBMbeKWIG7gMTBuTLYhRTz3nMUjWWY1dq02p8uWW89oZup85X8ItciN/85JGv1+1Oijw4YA4onmjFEZ4azqkZ2vNaj5hK00t6eJO71GDlq0axU5WTz0+9BAqOvfCS/D/X3DkoA0L/LjQ29G5oauCEe/d9kStmEb5ru/CUNVL3PuIoKCCoNI6SrP+tmcliJil3E3F8FADzjzSxLzg6l4++1tgdxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=gmail.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xq4y6eFHSdgMq6ZCAy4NcIPKreRt+m7Azjuv9LKrxWk=;
 b=lUwCgKTvOxJ8WmwH+AGkT84PCuc5TmqB+icX0xx+8AsxNiwQM1/GOUWhpSTL79tBQQJtgqgqBxVVu4IE880SqGXGB8ssL9XhQWUJm3ewEHEGBEfypBMHCxPCmWjeoZvQEWMaLkTekhVC8j704nJRTRMTAZ1zMzt9joaNM4DdG2HWTRUmDODDmNi+R6JJSCLl5kZFrved0EJ8k5kQE3BS4orFtBM1jkNCmTvzy1B+tAlHNVf7+xiVfmrb2Xec51Krpp5l7KkDkOwDJBXubpHloQWaQ39z4TqDCknxz2P/bJInTQeFpqkbJQI1+4Nyg0A/4+nDdKw3dcbfgRmF/twMeQ==
Received: from AS4P189CA0018.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5db::19)
 by DU0PR10MB5726.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:313::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 10:17:13 +0000
Received: from AMS1EPF00000049.eurprd04.prod.outlook.com
 (2603:10a6:20b:5db:cafe::62) by AS4P189CA0018.outlook.office365.com
 (2603:10a6:20b:5db::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 10:17:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AMS1EPF00000049.mail.protection.outlook.com (10.167.16.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 10:17:13 +0000
Received: from RNGMBX3003.de.bosch.com (10.124.11.208) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 12 Nov
 2025 11:16:48 +0100
Received: from [10.34.219.93] (10.34.219.93) by smtp.app.bosch.com
 (10.124.11.208) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 12 Nov
 2025 11:16:47 +0100
Message-ID: <7f3bb267-7cff-45e1-84a7-15245cffd99f@de.bosch.com>
Date: Wed, 12 Nov 2025 11:16:40 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] samples: rust: fix endianness issue in rust_driver_pci
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Marko Turk
	<mt@markoturk.info>
CC: <dakr@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>
References: <20251101214629.10718-1-mt@markoturk.info>
 <aRRJPZVkCv2i7kt2@vps.markoturk.info>
 <CANiq72kfy3RvCwxp7Y++fKTMrviP5CqC_Zts_NjtEtNCnpU3Mg@mail.gmail.com>
Content-Language: en-GB
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <CANiq72kfy3RvCwxp7Y++fKTMrviP5CqC_Zts_NjtEtNCnpU3Mg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000049:EE_|DU0PR10MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: 17410a56-1be2-448a-bde5-08de21d4a5fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHpTKy80bUQxb2UzUC9yUElHMCs1WWwvUi8yWXVPN1d5cWNkNzJabEFJTnV2?=
 =?utf-8?B?U05ncWcwdkNpUVdxWmc0K1VBTCtQVkJ3WG5TZmFLUEtRVGRFNHZWek1FVDlJ?=
 =?utf-8?B?THF0MjdGUDNDME4yZTdwUDR6TTc0MWllNkpDcG54YUcwTUNiWGx2bWdCanlk?=
 =?utf-8?B?MHRSR3hiamlOc3JqNjVEUjZhMUlSUkVLMzAwRWkzZm9TcXEvcEl1TXNleG5k?=
 =?utf-8?B?VzlnL3BmaTRQNmpWQVdJWkMvQWNjNmtSemFaUDhialZuS3N1eWdZdk5wcVlC?=
 =?utf-8?B?MEJHaTR4OUEzczB0YmtQQkpsRWNRTzc1NDBLZXNlWjZhcDdnU1ZuczU1R0Vs?=
 =?utf-8?B?OFZaOHRmYVhJaUpyS3hQQk9SVk5tNjdHaWdxaEp6RS80dERyZnJzVHZPU3Zq?=
 =?utf-8?B?bDVYU09Halpwa1MxSk9uWlBJc0wwbkVIRkJSbmJ0M3JLbHE5SW44QUt0TjNQ?=
 =?utf-8?B?RjZqSWpTTHlZWlJFZDR2YVpnL1V2ODRFM3V5OFVMTURqWmUycGFUYk4vR1J6?=
 =?utf-8?B?OWplVXlOVi8rV1hYMDJlcFVLTWkzbExZd0xVWGY4bWc1eEJ6R0NFWU1BYmVW?=
 =?utf-8?B?ZWJMWUkrV0FFMkRiaG01U2VNYXIxb0hJOEU3MW5GV2FGZzZwb0sxU0J1UkZu?=
 =?utf-8?B?U2lLSUNreTA1OStzekNKNGltcmlVSVlUcnRHVnpCanBmZjJsUy9SVzdDL01S?=
 =?utf-8?B?NGh3aGRhTHdDYWZ3K05pZ1lCWllUN3gxVVNhQzhCMnkzd1hzTHZZRWc2ZGdQ?=
 =?utf-8?B?dnd0SjNBN09zbmV6TEtsYlNnMTRaNTNTYmpkaURKVGg5ekMwbVlMUWpvWVY0?=
 =?utf-8?B?T2V5SjlTT3FROWc3ci9uWmVlSTUwMDRCbmdGQVZMZE90OEZSdGhZTzlHRmN1?=
 =?utf-8?B?bjh5UldXWnVQTlEvazExSlJnT2p5NGdaamVSemZXcTU0QzJ6WTRuLzJPVXp4?=
 =?utf-8?B?ZU04eW5jRTlXZi8wc3JFNGs5T3h2U0xHbk5Wb2dmRGtSQ2RldzdGeGF2Um1v?=
 =?utf-8?B?QlcwRUI4VnJkd3R5Y0Z0VzI5YURLQ3FkeXMyVkVWMG5HME9PaDlDOXN4M1hr?=
 =?utf-8?B?bkFJYmZnQkNwWnpmTUtIdm1GbitENDRMbWUvbnJqeUlSSmJtRFZIeHhxeEZB?=
 =?utf-8?B?akd3MHV0cjFiVHd6ZTNVdHRqdkRRMjZBeVNvZzN5MTZmODRhcVUwWXJoZXRO?=
 =?utf-8?B?cmdJdjBHZEZZKzRobEYwNzBRYWcrNW9OcTRkSFEvcGZVN2M0NGlPeVRyemNk?=
 =?utf-8?B?UXpiY0pqaE9WVTVpSU10UHU3d1Q5eWlkNWlLQklwZGRJRlJpRi8vRU0zMnFV?=
 =?utf-8?B?bkp0Z1pYOHpiL3h5Vlc0SGxCUjJpNytNUWRGeFJjVk5tWWdVUzd1d242THVQ?=
 =?utf-8?B?Zng2aXdpeXBhUkhOd2J1NnNzZEQ4MFNLOGloaTVWTzZ1U2lETDlZSDdHS3dW?=
 =?utf-8?B?OXhhT3oxdUgveUdsbEF6YTkrNGlzNW5Dd3Jyblp4eDVkb0IrbUhidnpBM21T?=
 =?utf-8?B?WVRWMWNHcWhWeXBIRlFxcmIzWE0zVUtJVEFQQlZyMm1zZmxoNjRtdDJjV0xN?=
 =?utf-8?B?SzlwKy9RdGZQUVZNaDZRZXVkWDRmT0VlZTVZWHRYZHNjTzFaYXg4RWN2UjZI?=
 =?utf-8?B?R1p1Z0VvWExKTXlFWWZBenhYWEFDc0JoZTFpdnIrK0RXU04yNnlndlNiaDE3?=
 =?utf-8?B?eWI4WXlQaGU0U0ZCUXdzdlJraTZ1d1pqelJ4SGdiVGtyR1RsblhhNFFiRnM0?=
 =?utf-8?B?cGRMS2F4YmYwbEYxYUxLalFnMkFMTGpxMGpwMFhFQlYzSHBTd1FKNU85VmpM?=
 =?utf-8?B?b3FwWFZSVFZJQ2VJM0d0dml2LzVVUGwzS01qVkVQOHFBRFdjVk85WjYxYW9B?=
 =?utf-8?B?QVFDUVltVS94NlE4N1J6ZnV5ajkwajFoT0txa2Qra0l6eENRK3p4ak5oVFZ3?=
 =?utf-8?B?Z0xQcXVmd1loZ2d3WjV6UGlZRzVBM0s2dHp2NXY2ckprNnlBeXBEMXlmYVNS?=
 =?utf-8?B?OGg0UjlNcjdxNzdLNVUweVVJMjZzWm9BTUxFT2ZIUXhqNFd2ZVFKQnN5Nk9a?=
 =?utf-8?B?S1pwZmVEZFNuRFNTeGFCaFkwUGRxb2xDMzVoZDU1WVErcGhWMVdNMnhXY3Vq?=
 =?utf-8?Q?+zt8=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 10:17:13.4215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17410a56-1be2-448a-bde5-08de21d4a5fe
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000049.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5726

On 12/11/2025 10:37, Miguel Ojeda wrote:
> On Wed, Nov 12, 2025 at 9:47 AM Marko Turk <mt@markoturk.info> wrote:
>>
>> On Sat, Nov 01, 2025 at 10:46:54PM +0100, Marko Turk wrote:
>>> QEMU PCI test device specifies all registers as little endian. OFFSET
>>> register is converted properly, but the COUNT register is not.
>>>
>>> Apply the same conversion to the COUNT register also.
>>>
>>> Signed-off-by: Marko Turk <mt@markoturk.info>
>>> Fixes: 685376d18e9a ("samples: rust: add Rust PCI sample driver")
>>
>> Can someone take a look?
> 
> Your message was in my spam folder -- that may be affecting who saw it.
> 
>>From https://www.qemu.org/docs/master/specs/pci-testdev.html:
> 
>      "All registers are little endian."
> 
> So this seems right. A couple tags:
> 
> Cc: stable@vger.kernel.org
> Link: https://www.qemu.org/docs/master/specs/pci-testdev.html
> 
> Cc'ing Dirk, since he tested the sample originally.


Hmm, I can't find the initial patch in my Inbox. Even

https://lore.kernel.org/rust-for-linux/aRRJPZVkCv2i7kt2@vps.markoturk.info/

doesn't seem to have it?

Thanks

Dirk

