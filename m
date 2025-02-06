Return-Path: <linux-pci+bounces-20807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A09A2AD47
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 17:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88CCF16298F
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 16:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857521A316D;
	Thu,  6 Feb 2025 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bzPVK3R9"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4961F416F;
	Thu,  6 Feb 2025 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738858049; cv=fail; b=WcCVyItz8oKGi8NMDwAtFJfR8EjmZuc6RAFUMw/HUrKJtZxC8ber6gf82VeYaYSTgCkTIkJwSKOfY8bz6AfgvGwsGEo9MX7xiwrlP4nw1CxB3GuchY9vBOBfJ5F3JISgxfaHFX2/fS8spUm4q7o3T+TxR3Kgs5LdyrjHIEJhSR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738858049; c=relaxed/simple;
	bh=qY9HfpiBch39SEAcRWOkmP66PhIGRp/qaNNk0hbij94=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pP/yhTif0B/DbcPwEY/o4swjlEJzhpZ9BnxNC4jEEek3nnxpr1NrmA7ZWe3uRc+Pxqe1yrI5riZ+bHsS5ZFlvIm3iBN9XcSTS3faQC8pcKraeCS7sItusIYsZlCPUHHcv+TJMslcxT3SSajrRV+UscId7Udooc5fIbSyjTz8Mjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bzPVK3R9; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFFRtMN9ulMnC4hrObM5p63s8N02Ea22diM5r0LK4Zt92jvdkkpnS9CJI8U2/zZj+fVz74o663BIQ7Llm3bzBrdha2zLW1EzzKm2xF8GmrSaRSXy26TQ0zAz8GCSE/8Jx9lljXdXCrJFv4wQwmris44dyKJl/FomHxDOKrx1ZlB5h/4ngAeAsdl0Xc30/qpCEOi11cbvA69xbdvILSya1U9owJd0ahp6ZzbKOMaVHRiY+bR2MB60/ilJk2FGYp/r4FY0Lx5uwaztLrCiz6ZXC5fmZPgiBEpy8zvB26y5IT1IZCAViHNjkI1OsTeUi+QgupFtctNprg5vd1Hy9aBkrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qY9HfpiBch39SEAcRWOkmP66PhIGRp/qaNNk0hbij94=;
 b=clscVmE005HLJyxdvDH0G7FYo5/hDkIN7UIqu2LG8I1+ggjrgs/4cCyiLBKNZmA1gNB15MVqRZ9cOijMfPprOR7/0nH5JMPELnnAiwH6vmygzktizUL3XG7Ao0Qirzy0o/qRlV9/puHBr33pgLzei9BsdooSu9BzpcBS/1AiFPMbtysH70wkIKrNeRixNuxhCL/D9eYjmhQoE5RiK3kMAbY4eoXapH8fV4Pq1Vu+CiRmSjLmNQCwWVBlS3iycws+GiEWbjUr0wdODFGhahCvUa7Ji4XjkJvg8zhNmM1sZeWQ6lwhzSgngjAb5BhzbimOpofp7ckRlr+UQYGs9ISw6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qY9HfpiBch39SEAcRWOkmP66PhIGRp/qaNNk0hbij94=;
 b=bzPVK3R98uinZuiK+phWxDYQWQOUQsxmgBFZtvW59+Wbndz6COL2KS/IPhVvG5h5DUIhJdJOG1PeGjQ9cN57/CtmxHFJWHWuZXMq36at6i/tMZIg9uOcTruiga+gBWMg5xybaxzwlvP25D0MmvAxy3YNI5Py3ASRo+k55XNXg2I=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by DS7PR12MB6285.namprd12.prod.outlook.com (2603:10b6:8:96::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.10; Thu, 6 Feb 2025 16:07:23 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%3]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 16:07:23 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: Markus Elfring <Markus.Elfring@web.de>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Conor
 Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, "Gogada, Bharat Kumar"
	<bharat.kumar.gogada@amd.com>, Jingoo Han <jingoohan1@gmail.com>, "Simek,
 Michal" <michal.simek@amd.com>
Subject: RE: [PATCH v8 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Thread-Topic: [PATCH v8 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Thread-Index: AQHbckFGnEXox34FgUW7RyRWX+Tmz7M426yAgAGggTA=
Date: Thu, 6 Feb 2025 16:07:23 +0000
Message-ID:
 <SN7PR12MB7201C9D05D5E4AB4D5D091F88BF62@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20250129113029.64841-4-thippeswamy.havalige@amd.com>
 <f5462109-1603-4866-895c-b5c349261296@web.de>
In-Reply-To: <f5462109-1603-4866-895c-b5c349261296@web.de>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Markus.Elfring@web.de
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|DS7PR12MB6285:EE_
x-ms-office365-filtering-correlation-id: b0fe1b3d-25a3-451e-6f9f-08dd46c85797
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T3d2STJQNjc5aVVZOHdsUkhIam15S2dOeVgyZnlNaDQ4THdOZjFYZjJSbE1h?=
 =?utf-8?B?NWlZVmlFWmNDdlc5MWhFd0RlRURWZDhKY2tKS1Q4VmpjQVAyUDlKZEo2RTRI?=
 =?utf-8?B?cXZ4SHZ0YlB5ckU0dG5qUlE5SmtZZjFBblR2SlpwZllmRWVlbCtrZU5hTWh6?=
 =?utf-8?B?MUsyV3N6U0E2b045M3A2WGF3THgrSC9kT0l5aXEzRG5CeE5nR2dWM2lXNExL?=
 =?utf-8?B?K3pLdVdqaW8vck52SDRsVWpOVnNmUUFrSU5DalZ5S2pPcUVoWlRhUDZjOG8z?=
 =?utf-8?B?OTFaK0xJVyswVnJ2UTI3Zk5KMVF5SDZobmRxMDJNZllRcGI4aXc0cnB5MEl0?=
 =?utf-8?B?YzdBT29iWUh0WXNDbkJCS1I4R0xMTDZGNVMxZUt2bVlVSGt5N2JGOWxqY1NB?=
 =?utf-8?B?Q1orYjdpZFNqUGhGaTN5MTBrMDl2Ti95dFNuSTZ5UkVUdkowWXl6MlF6cFd5?=
 =?utf-8?B?ZGJHUXJoQVd0aUxwQ2MvK052K2dzbVdpSkYwblNpUnBlRFh5RDVFQ1RDa3NK?=
 =?utf-8?B?amhLOXI1ZlJZaXRHVDhkeXhoQzJqckp1VkI4RkRjclpNY1BPZ0ZyZGVQdmM4?=
 =?utf-8?B?WEZURm5Ham56V3hwa2dRNmFkWFc1RjI3czRlM0JTMjA2TWVWSEJWT1R5QnE0?=
 =?utf-8?B?VE5pWEx0bkgwWTBMNGQ4UGtnWEtSWGxRSXRUUUxteHdsUTNBVksyWEpneENO?=
 =?utf-8?B?Z0VSbFJPYmxnckt6Y0tLdVZPdC82aUhGTitwWHAwM01VdmFpOU0rSEFwbjc3?=
 =?utf-8?B?N0FEZWpPZzhUS3FPYTVPR2NCTzR1WEYzZUd1aTdkOHJESjY4c0VnSFB5WUc3?=
 =?utf-8?B?di9raFpGbENFQmtLU3ZISjljOFVERGRwMVdkckkvVjFvT1JMYnNnbUJRa1Iv?=
 =?utf-8?B?N3l5dGVGWlBvaFYya1R5T1NVS295MWNFZW5Za1RNMGtweGJTZWxlamcwK0pM?=
 =?utf-8?B?R2FvUDRFWVMydlVnSlZQdVh3L1RLM2RWakRGSUxFVUpmYjZBek1PZkVkUm1U?=
 =?utf-8?B?YWhXd0NmZmQxWUVzaHNhTElQOERuSXNnZ25QSE9UOUtSMGdrWERNTTJJeFdk?=
 =?utf-8?B?bDFaRGtKSThRb0xnOWFoVkxZeE9kWVZyMjVydTg5YnY5SmFGVC9wRUFQOWNU?=
 =?utf-8?B?eW9Pc3Q3ZlVYMDFlNFFEbjlLMVVaMjFIelZzZTcvM3RyNkV3OU9lUXplbkto?=
 =?utf-8?B?OVhmbG83MU1tdFN6S3paYVpKMVVVQW9Eb2VkNlhQMUJCSitXdTVTY2JucUR5?=
 =?utf-8?B?Uk9BR2VOczN3QmF6aFI1SlZ4QTVVV21zK0xzSHNBbmEraitXMmNOOW1KcDJP?=
 =?utf-8?B?cjJZODhWRjBwUUlQcm13c0t0U3pTZkRGbEJIUlpDTG1XM2hyakRvK2pJWG5E?=
 =?utf-8?B?S2svemRpWWlmUjc3WDhrcW5vc0tJc0VucWxpdUE1d09PdWQyWFVERXYrYStN?=
 =?utf-8?B?MStmQnlWc3dZUUYrek9tZ216YlVzTEtHMEZaQXlKYWNHcVhBT1BJaHp4QTdE?=
 =?utf-8?B?WVVveEhhMzVLN3I5WVFTUDdlTlh1cXZ1WEhVZ0tBL29Lb1dhM1hsa2J5dUVn?=
 =?utf-8?B?THZEWDRNaDVXTWlnaFRFcmhpdG9YVi9XSFFlbi9FdGdQd3h2M29pWXJkZCt2?=
 =?utf-8?B?QUpLL2VIL3lWZ2I0NENuOXByd3JXaFN3VlRjcGdmOUlXSXZHSVREcnVMY1RR?=
 =?utf-8?B?T3F2Z1d0VFV0ZU9OZDNYMGYxUTVkWUVpaEpoVElhd0JGUWhTQnozbCttcDQ1?=
 =?utf-8?B?WjdnNUQ5aUNBQVRIcURFWVc1UzBRaTRkWm8xNktBR1Q2Qng1MDBYT2E1ZXRz?=
 =?utf-8?B?a00zdThhNnFuUWxHSkl4blVtcVlpeWI2UExNZDdtV0tNRDhmZHJRenAwSEZP?=
 =?utf-8?B?SXhrbmltSFVMZk9vMzVnUTNBUXhUWFU0RE9YdlJNWUJjTkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UnhvaWpNcE83bHlMSXdpY2dUZk5teTZqajEya3NqREhKTTQxa0NpNkJLc0Ra?=
 =?utf-8?B?cGllNC9RamRFQUplazZHbW16eGtFbmNHMEhFZVE1aVZiREhQVStUd3l5OUlM?=
 =?utf-8?B?bDJrNHVrS3ZkQkRzd1VELytsdHRueTB2bGNLTkluTW5CM21PM2ErU2RqSFV4?=
 =?utf-8?B?OGRMTThLU0h5Ykd5UEJMUGw2TlNSeE84MlVzRy94Q2Vib3pudU5haStpaEJX?=
 =?utf-8?B?SGNwczcxdDFLZ0JUcXNkeFh6L2xYMkRMSG91UVJuVEY4dTZZblBZVGhPZjNV?=
 =?utf-8?B?S1lQK1hoNFlGL0ZiZCtRZlMzZm1lS2hFc0NxTkNHdmpmM3h4cmhTQkdKczJk?=
 =?utf-8?B?ZFNhUjJ6cUpIUEJmU0oyNjdvYzNGZVZpNDZaOGoxU2E2RVpKYTAwRE5tSENv?=
 =?utf-8?B?cVFwVzdzZ1NKb2FSTysyZVZoWGZhRjRqUzlmSWU4V29pbEROM05pT0x1ME44?=
 =?utf-8?B?dEdBV29YT2JwbFdLTzljTXQ5SUJ6M082OU5HY3VyVTJzay9sUVNydVlaSWZI?=
 =?utf-8?B?SkhpRHYyWTAvSmFHbHB4TlU0U1h2clNzNGc2ZmpIV0dUcVF3Q3hOV08wSURh?=
 =?utf-8?B?bW9qSGVHd2ZTaDFTbzNNNS93VTBIOUNML09PRnlsWG9qUXBLVENLSDJvV28y?=
 =?utf-8?B?Qkt3NHdTcWNERng0MUJGRW5rajdnWks3M3NkdThnVEVpOUs0ZS9tVzV0cERw?=
 =?utf-8?B?Z3hjRXMzbExkSnJYTkJIRXdBVldDbnphem0rOHhLMjFHT2pIbHd0cUwrN2ZV?=
 =?utf-8?B?cGxwa2hubDdSM3B3NjRscWplaWVrazNpSnB2bFRhdXRoSFNRLzNjbi9kTnlS?=
 =?utf-8?B?N3NwREVaYSszbTJTMHpqd3VTNkZtZlJJOGhPM3phcGhORFlBRFpZdmFxbzJh?=
 =?utf-8?B?ZmhLNUNETm5sZXgrRXYxMUlGTWlBUVVxdWwzTUNURjhjYXhoQzBsZWR5dkJ0?=
 =?utf-8?B?TzJXdVFXRXd5cVNxYUlTd2hKOFRyZStUb0UyanZPRU1taER1VHB3NVFRTmwv?=
 =?utf-8?B?RzVNQ0IydXM2aHJGZFlOSVNjbXVKVWQ2Zk5IR2hwWWk4SWRyZFdiWUVFWktM?=
 =?utf-8?B?RUI3cjdrOVVOVmMvcHlRK3NDUHF6QXk3MHVJOHRjNGdUSnl3M0ZyWFo3SVVw?=
 =?utf-8?B?VXlDVFR3Mmk4R2xhNGxmNy9wWlVjbHg4MXRvQ3VWcHVFcEthUm9YQnlpVG0v?=
 =?utf-8?B?bUhSamFSb0tqRG8wTlpMbmNCSE4vYm5YSzBaMEJ5ODhNZko0cTJLMTM2QWVF?=
 =?utf-8?B?eXFNUE55bGxrK1p4VlpCdktuSldEV2lkcHZsZzFCZXJVOGx3Z3JPMHo5eVNa?=
 =?utf-8?B?QzJOYU4weHMxMU41b0RxOUxNN3k2Qm5IcUl5UVdzNllnWFZsNlhscXhMem4v?=
 =?utf-8?B?Zm9Cc0NsYlEvU2JoWmdHWVlPY29SQ2xVOGtENkZ4V2RQa0Q2VWJrS3RHb0pE?=
 =?utf-8?B?U2tvYzFYaFZ4MnlFZG1jcTBmWkkxa1l3VUR0Q1k1VGZIa2hVVFRsMGJPSnhZ?=
 =?utf-8?B?TVNCMExZampWbDB0eTZxMFNkVTd5eDE3S0xnNy9jc2xLaUJ4UVFUZmY5eXJJ?=
 =?utf-8?B?aC9oTEpETW1QbW5PVEhlNHIrYytJL3lqYUczTTN0N1R3Qzd3clNlRnFmUmJo?=
 =?utf-8?B?QVZPcjd2cktIUFZrbnhXaHh5bmRoaERUdDZzVjcyc1VkV2RGZ2JiQU5uOVNS?=
 =?utf-8?B?QkladklYOUxrTklOczNFV1NRa0swbFp3Ly93RS9YaDZKM3hpWGFoMmNiUTRp?=
 =?utf-8?B?NzVpTjJRaHFnbkx0K3ErcUg5aGtXaXpVU0xTWmVPL0Y4QmphRHMvY0x1TEw1?=
 =?utf-8?B?VGFKZnUxbFE4MVB1TGJBb01IUllsdXhHeURaWFUzL0dPQWFITnFCN1hiNDRy?=
 =?utf-8?B?TVk4YWtJMExjU1lIdDJ3OXVDRm1vS3AvWjZwcTJIQU5DK1FmMnNXWFB6dkFN?=
 =?utf-8?B?ZGVFQndHRFNwd3BJRFd6MnNHYSsxL2o2WGpQTHZ4N05NaXFZOWU4UlpQZGdK?=
 =?utf-8?B?YThmelhCYnJtcVpEMjVPQ0F6Qk9ucGo5RFltK2xmRjNLYmpVdzZmSnRLa1ps?=
 =?utf-8?B?ZG50dzJoSjhjQ1VYQWNXNWZDdWhBaC9PRGJiTCttZFdQczBWTkZXWVJrMnBs?=
 =?utf-8?Q?XVSA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0fe1b3d-25a3-451e-6f9f-08dd46c85797
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 16:07:23.2820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D9sp+/gxPSkZU6Cy7IibQDUuihZ1F1trEWk431gvXHBzv97YW3GTeJuFrugxBr098Mn8yYvfObKxptk0LmxkmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6285

SGkgQE1hcmt1cyBFbGZyaW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogTWFya3VzIEVsZnJpbmcgPE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4NCj4gU2VudDogV2VkbmVz
ZGF5LCBGZWJydWFyeSA1LCAyMDI1IDg6NDAgUE0NCj4gVG86IEhhdmFsaWdlLCBUaGlwcGVzd2Ft
eSA8dGhpcHBlc3dhbXkuaGF2YWxpZ2VAYW1kLmNvbT47IGxpbnV4LQ0KPiBwY2lAdmdlci5rZXJu
ZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgQmpvcm4gSGVsZ2Fhcw0KPiA8Ymhl
bGdhYXNAZ29vZ2xlLmNvbT47IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz47IEty
enlzenRvZg0KPiBLb3psb3dza2kgPGtyemsrZHRAa2VybmVsLm9yZz47IEtyenlzenRvZiBXaWxj
ennFhHNraSA8a3dAbGludXguY29tPjsNCj4gTG9yZW56byBQaWVyYWxpc2kgPGxwaWVyYWxpc2lA
a2VybmVsLm9yZz47IE1hbml2YW5uYW4gU2FkaGFzaXZhbQ0KPiA8bWFuaXZhbm5hbi5zYWRoYXNp
dmFtQGxpbmFyby5vcmc+OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiBDYzogTEtN
TCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IEdvZ2FkYSwgQmhhcmF0IEt1bWFyDQo+
IDxiaGFyYXQua3VtYXIuZ29nYWRhQGFtZC5jb20+OyBKaW5nb28gSGFuIDxqaW5nb29oYW4xQGdt
YWlsLmNvbT47DQo+IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHY4IDMvM10gUENJOiBhbWQtbWRiOiBBZGQgQU1EIE1EQiBSb290IFBv
cnQgZHJpdmVyDQo+IA0KPiDigKYNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2llLWFtZC1tZGIuYw0KPiA+IEBAIC0wLDAgKzEsNDc2IEBADQo+IOKApg0KPiA+ICtzdGF0
aWMgdm9pZCBhbWRfbWRiX21hc2tfaW50eF9pcnEoc3RydWN0IGlycV9kYXRhICpkYXRhKQ0KPiA+
ICt7DQo+IOKApg0KPiA+ICsJcmF3X3NwaW5fbG9ja19pcnFzYXZlKCZwb3J0LT5sb2NrLCBmbGFn
cyk7DQo+ID4gKwl2YWwgPSBwY2llX3JlYWQocGNpZSwgQU1EX01EQl9UTFBfSVJfTUFTS19NSVND
KTsNCj4gPiArCXBjaWVfd3JpdGUocGNpZSwgKHZhbCAmICh+bWFzaykpLCBBTURfTURCX1RMUF9J
Ul9FTkFCTEVfTUlTQyk7DQo+ID4gKwlyYXdfc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcG9ydC0+
bG9jaywgZmxhZ3MpOw0KPiA+ICt9DQo+IOKApg0KPiANCj4gVW5kZXIgd2hpY2ggY2lyY3Vtc3Rh
bmNlcyB3b3VsZCB5b3UgYmVjb21lIGludGVyZXN0ZWQgdG8gYXBwbHkgYQ0KPiBzdGF0ZW1lbnQN
Cj4gbGlrZSDigJxndWFyZChyYXdfc3BpbmxvY2tfaXJxc2F2ZSkoJnBvcnQtPmxvY2spO+KAnT8N
Cj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMTMuMS9zb3VyY2UvaW5jbHVk
ZS9saW51eC9zcGlubG9jay5oI0w1NTENCi1UaGFua3MgZm9yIHJldmlldyBjb21tZW50cywgcmF3
X3NwaW5fbG9ja19pcnFzYXZlIGlzIGxpZ2h0d2VpZ2h0IGFuZCBwZXJmb3JtYW5jZSBvcmllbnRl
ZC4gDQpBY2hpZXZlcyBpdCBieSBub3QgcGVyZm9ybWluZyBmZXcgY2hlY2tzIHJlbGF0ZWQgdG8g
cHJlZW1wdGlvbiwgbG9jayBkZXByZWNhdGlvbiB0aGF0IHdhcyBvcmlnaW5hbGx5IGluIHNwaW5f
bG9ja19pcnFzYXZlLg0KSWYgeW91IGFkZCBndWFyZCBhcm91bmQgZ3VhcmQgYXJvdW5kIHRoZSBy
YXdfc3Bpbl9sb2NrX2lycXNhdmUgdGhlbiBpdCBzaG91bGQgcHJvdmlkZSB0aG9zZSBhZGRpdGlv
bmFsIHNhZmV0eSBjaGVja3MuDQpJdHMgbmVlZCBpcyBiYXNlZCBvbiB0aGUgZW52aXJvbm1lbnQs
IGlmIHlvdSBuZWVkcyB0aG9zZSBjaGVja3MvZmVhdHVyZXMuDQpXZSBuZWVkIHRvIGNoZWNrIHRo
ZSBpbXBsZW1lbnRhdGlvbi9jb2RlIHRvIGV4YWN0bHkgc2VlIHdoYXQgYXJlIHRob3NlLiBTbyBj
aG9vc2UgdG8gcHJldmVudCBteSBpbnRlcnJ1cHQgaGFuZGxlciBmcm9tDQogYmVpbmcgYWZmZWN0
ZWQgYnkgbGF0ZW5jeSBwcnVuaW5nDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IE1hcmt1cw0K

