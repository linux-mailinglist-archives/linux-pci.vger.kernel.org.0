Return-Path: <linux-pci+bounces-37440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F004FBB44FB
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 17:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C816932493F
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 15:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9F61A01BF;
	Thu,  2 Oct 2025 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JRfw9y8r"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B43156230;
	Thu,  2 Oct 2025 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759418766; cv=fail; b=IDqfhiMKZ6C//Le243vvZM5g14iR9EocHroYYHuIYNOpb23jBng5Z7T9Wh/ksCnWxzL31jVLWRak/HedlAtNR2vgTU0NuGs1EDPXNVxJErisOutvikexMNjJ4sZMsqtply++rbSpuDy579CWqOdAf4zAf+XFaAr97HEkIjZ3744=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759418766; c=relaxed/simple;
	bh=FNNp88+kX4uhrb5RpH7cQusxJ0nxop44AXS72A4VOaI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uPcpRBaUvJ3+l0xMDa+fO2XaFd2q8A94coDwczOOcjqBY3bwhQA0N7s/RlD4Ui3VP+vLhoDkW8oPXToUsxpeU3a3dKe2G1aSuKoHAefzio6VSPAj5KVcJ7naZqPd23H+CubHitOgDoaZvdM7IJ5dnW+6CSOJeTnEIGwQSPARmes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JRfw9y8r; arc=fail smtp.client-ip=40.107.209.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRGE1xFPhDlYjrJ0zJTaGNNRHBJiTtE20FmhGJMpDPG63K+pkMiTZKIYIAWMrPQiiez1LxwqUOPX2VaLSJeFiBS2VJhP6rCfpriruQtXPPWxTq029x1I01seAB2qwF1HuFUjqYSM8+qTRH7CpbONByovVtdHHZGO0V5bDvOlyul3JDf76+4smMA/8G1iXl+n4w6InJUbMhdob7RosHHWsDRJNlscZon9bVb8mnhVTr92DkKn9wnwmSw/whlmm6ZUWI4gonbcGegC7iQlPFS2Pm2Ih7T6EKEWjE+HVtGkAexg/ybWhKU9AZeYwGkmJiqtmqXUEpSMpNdyifEqW7ltDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaEOdULuH4NRFZlV3NcvUg86PlDc4N6dGav2GbMsuyA=;
 b=WV8C7XmIKu8FyhQGz3SS4qy5hxMNx63+DtxiLg/d95aqTTIT/CswIf/gPzAz0PUbL0cWqIggGie9BipVnV4M6ZchL4kqQJyW3NnpSlDOvfmJLQ7PS5WCuMZEfFdUMboEDTQCS1WBhYWW8okqUr6AApZjqyAnAs9TAH45SWmib7TuxuUI5BjqOsfPR9B45L/ZQBYyAguqTKfaVO1J3MybH0HvnSbKJ2ZE2LD2BuLkTu0IRv5q4mQ/CZnFyPFIkbplnJ7DJh4A23uvfT6WNNwdQkJTetyGF3Q8CfP3f7tNqf8QROoL2729JwoeJnk5edjF5LoK4C20luqtg3c2EiQ6Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaEOdULuH4NRFZlV3NcvUg86PlDc4N6dGav2GbMsuyA=;
 b=JRfw9y8rk5+N+AAC52LDatGTNTOsha5xY5dCx1YTnrQdg2SZnDo+41ActyG+tLx/LxVEOZRA0AO2lfQoOKqRsJYg5iwUkMObzpyp/gVJEsFxbauswKUiCVp/6cWIhjTGxwAkWJzxhNviXDSLaduu5aCJridoa2n8Z0HsFl8zEIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by PH0PR12MB8099.namprd12.prod.outlook.com (2603:10b6:510:29d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 2 Oct
 2025 15:25:59 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 15:25:59 +0000
Message-ID: <17f51c55-2355-46f0-84e3-3a76a615d9bb@amd.com>
Date: Thu, 2 Oct 2025 10:25:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 07/25] CXL/PCI: Move CXL DVSEC definitions into
 uapi/linux/pci_regs.h
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-8-terry.bowman@amd.com>
 <20251001165843.0000321e@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20251001165843.0000321e@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0080.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::17) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|PH0PR12MB8099:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d35c63-1f8f-41f3-50d5-08de01c7fd09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmwwclJIVWJJMHJsdzN6MG1xdlVjSS9vWC93eWVOVmR0NEE5SEhBd2IrUlln?=
 =?utf-8?B?SnVTMm44NFM3dzdpZUEvQ21HSHc2NTR3TnVKOVprWFRSblhtYW5jTUk2QXNM?=
 =?utf-8?B?VEh1L0dLd1l2akQvMUwzbElOc2ljcGxkeVRsTy8zTUN1bUxzZUVIOEpnNTR6?=
 =?utf-8?B?OUpoRHJSV084WFdpeFFvKzJOWUN6R1AzZkJiUWxsQWJ0VE55dGhtNzdjQ1BX?=
 =?utf-8?B?eHZ3Znl2SU5Ed1Z4UEZmYlZFQ3JqWjRBTjJSV250WmRnRitSREozU3R3dEVD?=
 =?utf-8?B?WjJ2NHNheXB5WE95bHdDUkpXVTBNNU82ditSUHdpYi9MV1pkM2JhcS90cHAr?=
 =?utf-8?B?S0J0QVF3M2dDUk01MGV5LzJMSWpiSUhKUFVyalNyN3lZQWJRQUhpYU9PRENv?=
 =?utf-8?B?YmtuMTFvanRkRzR6VHZZbzdoRThvNnNvZ0ZSMFRMN0M3RWJvczlPS1FuY1VP?=
 =?utf-8?B?ZXpCeHEyRmJlQVJqWFh5Z1U5M1ZMdXJFR2E1elFoWld6ZE5CSWE1RUc2bzRM?=
 =?utf-8?B?aHhtZzdoOWR2aXRXZGRmWTZsOHl3b3gvZ1BsWDJ5dWxXUjNtbDFSNVRxNXcr?=
 =?utf-8?B?STZIb24vM2pzTWRVcVRUU1hjVk0vaW9LMDVSVFhPMDlpbk0xMFdBTkNQbmtJ?=
 =?utf-8?B?N2Q3RmtnMWE1KzAvZHNHNWFxc0c3QWhoZnNhSTZsdmdOYThOaXQ4YjNIZ2RZ?=
 =?utf-8?B?RnI0ZWV3KzlWYUxQbmd6d01vWTdsNUdJWnphMTYyYVh6WkVBcmR4ZURNMEVS?=
 =?utf-8?B?WFFJMldiMDlZa0t3U29sQllPaTZkdjlzejVGcXEwSXNSOFNLVjk1anBQVmcx?=
 =?utf-8?B?eDh5ZEVGaGlvdXFmeWE0S0NveWZDUytaNGI0YXdUNTlBcmVZckVSQ0FVd0t5?=
 =?utf-8?B?S3o3NWIvdSt2VWJKNDVuYkU5Ri9oK3ZQUkl3SUs2dUdlU29SaHVFT3IzSXdX?=
 =?utf-8?B?TXY5Vm45NFlaLzdPQ2pMNFI5ekg4TlZFbVpoVW55WTVYYnFMT3d3ZUJLbDNj?=
 =?utf-8?B?MVdqcHN4M0tRZHVjRDAvNmtIS1F6ZGdiYjkrdU4yL0Z2aFhmcHM5VkJmdEVW?=
 =?utf-8?B?dGIyTkZWMCtUbU5sb2lERGxzTDg0S2pMM2xKeFVkdFRKNjZDY0NlV2hSUU50?=
 =?utf-8?B?dUJOaWRQeGd4UzdqNDk5RnN1WlpUY1Q2YW5EUTZlNlREN051bUpaN3gyNlJH?=
 =?utf-8?B?NzQ3aXhKcXFVeXArY2IvTnN4dGV6ZlpsekN0Nk9aRFVrZXZtOGZHOW9qZ2Zv?=
 =?utf-8?B?R1J4WEt4VU1LNm9rRXlncEJ5RnpKMWF0VWl3U1hzdFF1STN2ZUtQUFNpa3gx?=
 =?utf-8?B?Vzl3d0k2THlNTG1XS3BiRlQzR3hSMWgzSXVDVVFDWWxxeWh1WXVmQzVzeVR4?=
 =?utf-8?B?WWRuQm5NdkdmSXdrcXlsRE0wclJjd1l6aDZkY1ZsL0UwWFRYbEhoYXNLenV4?=
 =?utf-8?B?NmU0TC9PTjNKTmExYnlEWU80MHc0WENxYjFlRkxWd1B2WlZsU2tuM2h6WlA5?=
 =?utf-8?B?UkxlTjdPa1J3cVh5N3AvR0k5MXZpRnQ4dUJ2VkowVDBHdmxJSmpUN1U4dG9m?=
 =?utf-8?B?TDFXVDZ5VHBRODV0WkhLM1N4SUh1eDBacnBTbmg0MUcwM3duVmRLN0h5Vk10?=
 =?utf-8?B?UG1BUDBFbU1wRVRDTHJIMkd3OXpVWmg2TStkWlVva0tIVm1tMVZzWkFNRlhH?=
 =?utf-8?B?NXRLelBjc2t3TjlhTVhqWEh1djJmL3BicDBYVEVtdDhpcnBmdm1hUXg5YlRn?=
 =?utf-8?B?OVUzMEFZQW80SnBnRnRIR1VaUS9QdXFzNkxOc2g1K2oxN0t0ZFYvY3BHWG5u?=
 =?utf-8?B?aFU5ZWJDNVdhbUtBZG5hSG9ZVlpNOFdEWU44NDdCcnBjK1JHSVUybjRFM21R?=
 =?utf-8?B?aUMrZ1NqUldPbkVPTTJmZGhqTithMG0wTlZjUDlGWDdzZ2ZEbU9DUDNSTXZz?=
 =?utf-8?B?cnVHWitTc2NOZEdhbE05YUxPYkJJRFFZTkhJTGlETWVQYjNpRVBzd1FoZGpt?=
 =?utf-8?B?Wks1TkNhWVF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHE3WUlubjYyZ1NMQkZzK2svU0ZTMWRWdnhaK2JWdmFhQXdBc3Z1S3pYVk1G?=
 =?utf-8?B?QXM5aEFsL1o5Ti80QlBtZ3pqbnU5c0ZzREFDSytJVmZXL2gzSnJ2SGxHQVZo?=
 =?utf-8?B?UlJpNWZ4TUlVZ3VTcFcyWjZVYTFrNDJIM09YL2dmenRDQUdzNEZBTEZVdHRi?=
 =?utf-8?B?WmJHN296ekt4Mjhna0F6a296WGZ3djBzOHJpWmZUbFVZVUtQS010Qno1RnQv?=
 =?utf-8?B?VnVZVFRFdm5hY0hqaDRnaDhDMzh6ZS9OdCtCRWxaREl3OWc1c2JmSGV2L05T?=
 =?utf-8?B?bkdFdWtDdWVJNFNXa1I4V0Jmc0gwZFlhTzROUVFoNFVmSTllQkpPYTlBOERR?=
 =?utf-8?B?NURBSWI3aGdaV1E1T1lHcUxMK0hrY3F0NE83VU1jdVY1Q1phaTNmNm93THkz?=
 =?utf-8?B?VFIrM0tnN1NlOXh4RVZicER0d2w5TVRYWlR3SmR2QUtZdW83K3cvMWxUNnFJ?=
 =?utf-8?B?NlRMSjgzdmh4Ky9MNHBlU0NmNmpzeTFUU3JPWUlyNGJveExVUGE4cUlRbzVi?=
 =?utf-8?B?MGdsUHJQS3hQQjcrZC9oSFR0U2QrcHFWeEcyTVJncEEyM01UcDl5TGdCbThZ?=
 =?utf-8?B?Y1lSbHNYRlVMazJqQ283Nlp1UFZnQzlYbkl5YnVUbEl0RDlRbkQ2eDBjM21C?=
 =?utf-8?B?WEEzamlXNXRCb0lKb3pRdVVOaXlLc3RMNUhCUk13OWV3T0czOUJ3bGN2UEtW?=
 =?utf-8?B?dUpkWTNDNTNZZytLemw4azJsRWZxN0NJWWN2Q0dlRWFQU1JXKzdlREVPclB2?=
 =?utf-8?B?KzdWelVVUElEdTNMUkUxZ3J2dUVBRElEYVhNN1l1cjIrQlJ3RkFPSGpjR0lq?=
 =?utf-8?B?bXAybks0KzdoMm56THUrcWdjRzhWcWxXZ29PMmRhTm1HbnhERDhQcWg5eHZ6?=
 =?utf-8?B?dHdRSlJmNE8zRGtlSEU0Wms0NE1FSHYzcUZWVkhlMGoreWlQNWUvNGhyN1Fn?=
 =?utf-8?B?NjhRV29qbk5HSG5sM0VGYXl2SmFrcmdURThlUktYWXpnQjdxc1MxRysyMHZJ?=
 =?utf-8?B?a0g4WTFOZzQ5elNNdjIxYUlLT29TbHJCZGd3UEVuVkY4S25abmJBSDZjdDlR?=
 =?utf-8?B?N05OVDVYT05tV1RHQUdzMUVPTk8zUzJ0Y09mc3ZhNTNCM3NpWDdqbTV2OVk2?=
 =?utf-8?B?Ui9ESnk4WmxxenRiOXprWUs4WXJONFhscVZxSDAvcjl6Mi8xK3lGSmxQL0c3?=
 =?utf-8?B?SGxIcEFCSEFIU1FsNmFJenZhZTFsamlvUVFOV3VnUldoMU5IN0xoeFpuVVhq?=
 =?utf-8?B?UUpMNERhemp6WmpxU3BaOU9JRGplRHNXN0lMdGx4TnZCaTBKNGFjVnd3aWo3?=
 =?utf-8?B?bHVOVTZGcUZhTGE4eStCbklVcExkRlU5dFBFd3dsQ0dUOWtpajBuOElaVXdr?=
 =?utf-8?B?dkE4ZVBUa05IelFYdGM0Q3pWU3hjSW1KSjRTVEs0cWpweVV4bmpBcTFUTWtO?=
 =?utf-8?B?VDVHU3FGRUJ6OUF3bzhYTksyVGIvQkxSV0ZUYjA3Wk9lMGZteThMMGx6aWJP?=
 =?utf-8?B?TDdOdXYyVWkzZTRSR2pwNXlTYkFGMTNkYU5hYy96R1NtWGQ2Q2xXU1dLOFdT?=
 =?utf-8?B?TmF6TXRyYVN2amVRK1BRRDZSMEFmNDhZOXp5eDY0V2orSTlYV0YyWTZXYVdt?=
 =?utf-8?B?czY0ZDV5YSs4WVE3SkFOWElWWXc0NmNISDhQVkhlUUdmREVTbG1qbmIyempN?=
 =?utf-8?B?Y1ovbFJEWXhXZko1b011c0Y2MkYzOFp6SUlkWUw5cjhVUXlTbWxXS3hTMVFW?=
 =?utf-8?B?N0VBVGtZRU8xRG82WGg0VE0wbGVLT2ExTTloekV5bjNianM5KzJXU2VYaFo0?=
 =?utf-8?B?RGs4NGVDODNnektTNG9QZHRrRVhOUkZzT1hROG1MbEdqMHY0UDN1SHNFKy9W?=
 =?utf-8?B?L0s1OW13TTJqcUNUSXNyZ21seGcxZm5EU1hrUk44SzlsRnptWXB0eDhIdkhh?=
 =?utf-8?B?ZEFJZDZZY0lzSmJWaHlnbHJBNjA0ekpKbHpkaTNwQzc2Zk9NTnlZU1VONUZv?=
 =?utf-8?B?ajYxM2dOK21MNkZCeTZlUHBNeXFNMnRGN2t6K1lzcUN1VzJER3l5c1QzOExL?=
 =?utf-8?B?MWtmM3NuZ3djMzVRMFA4SEtURHZzWldTbzFWbUFBT1VuT2UyaDZ0UTBBS0Vq?=
 =?utf-8?Q?kDiiIgJnhqFccghUmHI4AK3e0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d35c63-1f8f-41f3-50d5-08de01c7fd09
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 15:25:59.0187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Oq5aVSZrhU0GaJvSeiPXj9Lhgj16oaE1zHbUEA7NWLGpeYV/VP9RnTBw2149te+6XO3GJC5GlF1Ug3dMDL0mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8099



On 10/1/2025 10:58 AM, Jonathan Cameron wrote:
> On Thu, 25 Sep 2025 17:34:22 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> The CXL DVSECs are currently defined in cxl/core/cxlpci.h. These are not
>> accessible to other subsystems.
>>
>> Change DVSEC name formatting to follow the existing PCI format in
>> pci_regs.h. The current format uses CXL_DVSEC_XYZ. Change to be PCI_DVSEC_CXL_XYZ.
>> Reuse the existing formatting.
>>
>> Update existing occurrences to match the name change.
>>
>> Update the inline documentation to refer to latest CXL spec version.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Maybe we discussed it in earlier versions and I've forgotten but generally renaming
> uapi defines is a non starter.
>
> I was kind of assuming lspci used these, but nope, it uses hard coded
> value of 3 and it's own defines for the fields. (A younger me even reviewed
> the patch adding those :) )
>
> https://github.com/pciutils/pciutils/blob/master/ls-ecaps.c#L1279
>
> However, that doesn't mean other code isn't already using those defines.
>
> Minimum I think would be to state here why you think we can get away with
> this change. 
>
> Personally I'd just not bother changing that one.
>
> Jonathan
>
>

Ok, I'll leave these below as-is.

#define PCI_DVSEC_CXL_PORT                             3                                   
#define PCI_DVSEC_CXL_PORT_CTL                         0x0c                                  
#define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR              0x00000001

Terry

>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>> index f5b17745de60..bd03799612d3 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -1234,9 +1234,64 @@
>>  /* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
>>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE
>>  
>> -/* Compute Express Link (CXL r3.1, sec 8.1.5) */
>> -#define PCI_DVSEC_CXL_PORT				3
> This is a userspace header. We can't rename existing definitions
> as we have no idea who is using them.   Only option would be to
> add a comment making the old ones deprecated and adding new ones alongside.
>
>
>> -#define PCI_DVSEC_CXL_PORT_CTL				0x0c
>> -#define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
> ....
>
>> +/* CXL 3.2 8.1.5: Extensions DVSEC for Ports */
>> +#define PCI_DVSEC_CXL_PORT_EXT					3
>> +#define   PCI_DVSEC_CXL_PORT_EXT_CTL_OFFSET			0x0c
>> +#define    PCI_DVSEC_CXL_PORT_EXT_CTL_UNMASK_SBR		0x00000001


