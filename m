Return-Path: <linux-pci+bounces-25647-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62500A85264
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 06:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD541B81DFF
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 04:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C02279342;
	Fri, 11 Apr 2025 04:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="UQNbuwva";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="m2txihfd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2621EEB2;
	Fri, 11 Apr 2025 04:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744344549; cv=fail; b=Ib4lTwIJSzRaSZv0L+QtcvaAlBB/qni+MMlVno92LmoLYax5za01uEsX43fwpZrVDTx0+F4HdlTTktUrTlaXzBLE6yi2Uj//FAi2MT4gfW7gmgjxfK778Pqba0+QI2NwaOoaMzt5oNWLGvQy8LlMgq4NBhEpuOKPeDDEi8iQpBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744344549; c=relaxed/simple;
	bh=nnJm88GoJEolMod2gl9OsIx1Z3maot5W0orIRsO6sbo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nl6NrxsaUgZjnhP0LvVeRTgDW/2sLhFXzZq//MCWQWSMKhcke1xPqBq9b/jIEhQkY0YQa24dfUyMXmeyyS3mRubLECxGrmIVcV8WvAO9eDlTdvXhPPirRlyn4IWAYBbyvar+8Sjvp85nbbRdTFfqKx9BiFXZDi6+klhQelHsyn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=UQNbuwva; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=m2txihfd; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AKwfXJ001961;
	Thu, 10 Apr 2025 21:08:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=nnJm88GoJEolMod2gl9OsIx1Z3maot5W0orIRsO6sbo=; b=UQNbuwvaAlcP
	6+PH2hBq8W4KIhyPpXJUW10dn5HY7U19/Zujbah57BoMZg7Y+CnyKQZ9jk4SE9wF
	ZHcLc/PET0iVawbpR6mkCgRiwIHUQiixXzUuPKmDwR6afCZpxrr6qAJqqzUkOBZX
	VfM5ZZlPxNwGHBj22772aFCcUgzDpbf3w5nZVVnPyxlv9qFWU6riy7Kbjf3qHpnf
	/MNZF/zYfiPszplKOqzvie/qFVFgo5f8ppPl9zHHCI1iBXty2xzVUx+Ib81QJ0sh
	E/fAtJ3yVYl5nXpOxPAP3f/e6f0sIE3CK6a2hsRYBPmZqtpKUvAbDaj5XlpGSqvt
	ZawZSLowow==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011028.outbound.protection.outlook.com [40.93.13.28])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 45vbd2wuek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 21:08:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUllf9W2kRtZSvzS/yrbRamOpbR095myEUQqA1cMbr1rMMiuHNwIWDuUGbcwmv9WDEm4Gt/B8I83lLbai7Z80NBxd2jc6BghG2o9PzqqBuebMKcFUoW2jcMk4vjGpntBQU9Rrl+/lmQRjn+Atkuc2em+ggh9wxE5IaXVPjcjdCG+G2D8BxJ+AGg6AChbf9+e4369ZXeGXCbIHtlxwJs1R7QKCOqa4f0J91Wi+rgmRwB5jNMlul90k6FwAozqq74DJF4RSJCbRhYUnzkJ2u3ZhtAiBcTH3h2tRdedkBk+84DP09dqOMIK4jgiNnjWFJGtiZh4jRuh3/CvPjYg2GMoKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnJm88GoJEolMod2gl9OsIx1Z3maot5W0orIRsO6sbo=;
 b=r07O7cu4neEKR6qrPx4tpPN4lkzkkE7GnNqVLyrAeXtGc2hfWSenAwt5/y+B1nQKvCyyG4S9z/g4KXzOyMHM6RHSxki6M/BTQch92kWiP/DypaY5UWwW/4K5XzrPFm8/LuQAIXHBUmlXCNriqQKQ8bxCNoQM34cbLL+iJuCoTJdpFYYNL7rqVfG8uvjUn2mylrukXOUzwHVuCXPj6f6tIu5Zz3cyDZnSGB81RvU3OgjQcritaMMiaw9doRnQ+fSJLRbtJS70gaWa1I/YpW3aVF9Wz8FyHwQ3HISTk6SYK8o3/Xy7L4DBlfb9uMeXHFTqt2yZfX5Zvj4jRB1TAnFOOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnJm88GoJEolMod2gl9OsIx1Z3maot5W0orIRsO6sbo=;
 b=m2txihfdfS+6LSuRyZBb+LWZl+YNcDF+t3JpX4pHlt2Bq+WuIZQTV1kmyHvYtPWnnXP1gqAlFOYnoqRjeKIwpMlvqancotQrY4bFb8BqGXX0fXdcB6f1asKPaF9Ea0MnYk85w/ne+ARPAAmDcFOyctAX5c0WuDfRO58GXSmRx5w=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by CH2PR07MB8169.namprd07.prod.outlook.com
 (2603:10b6:610:67::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 11 Apr
 2025 04:08:54 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec%8]) with mapi id 15.20.8606.039; Fri, 11 Apr 2025
 04:08:54 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Milind Parab
	<mparab@cadence.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/7] Enhance the PCIe controller driver
Thread-Topic: [PATCH 0/7] Enhance the PCIe controller driver
Thread-Index: AQHbnwasjE0SelmZSEibiI56xlER37OGz6YQgBTWdACAAkpQsA==
Date: Fri, 11 Apr 2025 04:08:54 +0000
Message-ID:
 <CH2PPF4D26F8E1C08E292813424DCF669BCA2B62@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250327105429.2947013-1-mpillai@cadence.com>
 <CH2PPF4D26F8E1CA951AF03C17D11C7BEB3A2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <5jc754dnrbytkwrhkj5qjmlxpqa4owhbpeimnr5d7k2aqueysn@uuqdauadlwak>
In-Reply-To: <5jc754dnrbytkwrhkj5qjmlxpqa4owhbpeimnr5d7k2aqueysn@uuqdauadlwak>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|CH2PR07MB8169:EE_
x-ms-office365-filtering-correlation-id: e0baeb73-5d42-4bba-b48d-08dd78ae92f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L05xK3dvRHJac3Z4QTR6OXNYYXd3ajg4NkkvUHdQMUtsUFd0YzljWG1mY3hI?=
 =?utf-8?B?UXdMbDhhcmJJMmxTalk4bFBDTlF5dnNtalBhVW5qSzJXY1BMcmJqMVJNaWU0?=
 =?utf-8?B?Sk1vZENXdWVWYmVxaXFUTzBCdmhYUmtCNEtzQXpSR1UrSk5VSjRZdDdpV3Vm?=
 =?utf-8?B?VDR3MUJLRnkrejVBUG56V0wxNDI0SDNyUnF5M3ZTRDh0OGR1TXVVTm13ay9T?=
 =?utf-8?B?VWZTMFNZWngzcjM4YmVnUzBqL1huOVk2dkoxdDY0ZGV4d0xFYlhsVjVmRVhY?=
 =?utf-8?B?a1IyOEpXRjY4QmhOQUxJeWw2Qm9oMnhFeWFFTVFsNFlhdnNuaDhJRENBT1pC?=
 =?utf-8?B?djBIM041ZGU4b2R4ZGgxcHNOMjV4R2czQVBaMTB4N0NKQ3J6dUhLTWEvR1lr?=
 =?utf-8?B?MWMzZUFpbHYvMkhhNmJDdEFJa0dkSFZQWDVNU0Z1U3ZjUHM4dGtGV05lYVdy?=
 =?utf-8?B?cUcwR0xFMkwvMS9NTnVpZUxEU0ViWjdvdlhidFVkd2NaVFV3UTJoMVlsS3Aw?=
 =?utf-8?B?SkVxdVhxVTZLRmpPTWg1VVlMVlRqSU5qVzU0K1JiNjNTOXRlOWVXcm5RdHZo?=
 =?utf-8?B?OTlPVzZQdzFCV2hyMXNaNEhnT3BIU2V5QTRhVEF0ZXVFQWMvK3R4LzZSTUho?=
 =?utf-8?B?cnhyc3RLVXExZlpPTWhKSFNzbGFWaFVkWDcrYTRBVDAwVDNiZ0FycUcvUGo4?=
 =?utf-8?B?K05TeVg1YlNESFU3NkdvdHczQVBwQmg2RmJhMkRxMXRVUzhMcTNOV2FhUmph?=
 =?utf-8?B?NmhUNDRudVJ3V2tmRkdmeXNJS3BWRjlvOTVJVThmeXBPcFF3VklhSkRaQlUy?=
 =?utf-8?B?L0tuVjhZTGVVNVFPUnpvZVFGWEsrSERWUk14K0ZWNDZKTDdCMjlxdmxsK24v?=
 =?utf-8?B?YkJPamVPb2dQRk9PWVlvMS9DNkVqaEZxTU1zMlRMOGFYVmFuSUx6ejJtazJM?=
 =?utf-8?B?OGU1d08rYkh3MFE2Yzd6SWlRTWs1LzMvbGpkNU9VN25Xdk9MRUdQcUlBOUVu?=
 =?utf-8?B?MWJXaE9icTJkd3hjU05hNkZjRFJQT2tBSUpJMFR4cTYwaVJtNml5ZEpoYkR0?=
 =?utf-8?B?aXBjd2pYSTNQOFZOeGtJcUgzd2pRSTdQY0RVQzAxbHhORHhrdUM1Y0VDdCt4?=
 =?utf-8?B?b3JkM2ZPa3R0Zy9aUEVzU05mWUtpWXNzY1FMRnA4cGVRbXRVc0Q1WmRQYzYz?=
 =?utf-8?B?ZTgrTmtidGhjQUFxVEVzZDdrZXhrcnI1VnA5bEU2ajNUeWV5VzYzSWd4UXhu?=
 =?utf-8?B?OXZmZ09kZzhMVTFTVXhZL2RMaFpYbGNUMlBGZ2VLVEJaZHJUV04wSzkzWS9E?=
 =?utf-8?B?cUw4M25vRkczSXV1UVBHeU9YRUl4WEJpUzBKTXg2VkJhK0tNSDVXUWVNN2Iv?=
 =?utf-8?B?bmU0c3pxenhrZ1JQdGtDVHhYNERsY1lLWFF5T2kyUjBGNzRidjFrZ2pOVEgy?=
 =?utf-8?B?UmVPcEZKeXRKcXhlZStVU2l0VVVkVjNXclNNclVLaExFWTN0MDg0cTQyT2Ux?=
 =?utf-8?B?OHNTd0xab2k4SHhBOHQ3WEQ0aDRmSzJadVpxRW1TSlU4N2owS2pBM2JrWVhF?=
 =?utf-8?B?N0tpOU5hTWhsT0lacWtDeStST01tMU9hNUhTQ0hrbUJPcUNsaW1PWGJsTWVP?=
 =?utf-8?B?bktOQ01JSllCOWhNcUFUbUVVSXA1djNGSFhxMEZYc2h0eDlLdXJiQmc1cEZI?=
 =?utf-8?B?ZWkzY3J4RWo2b3ZvUWFUU1FEdEduRE9pVEZlZFBuaTFBN0xXempWSDhyNzJu?=
 =?utf-8?B?TTdLd0dIckY2K2N6NXNmQXE5dVVheFg5clRCR0xycnBlenRhaU9zSG5oZ3ZF?=
 =?utf-8?B?ZHh1UDFOa0NqWW5DTDRHd2ZxWUd2akJKb0t6YXMza1dGUENWRCtnK21IYnMr?=
 =?utf-8?B?d1B3QTQ1Szk3UlhCYjEyaS9DcU05NjJsU2xzZXBjdXM4N25mczdKRVNlQ1Fj?=
 =?utf-8?Q?SkexicQVMQY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WXB1cmxSYkFsbEhRbmhscUYxMkdYZkdQcksrK2hxdnNKUExrL2lVWmZ2REs5?=
 =?utf-8?B?NmR4Z28rcnFSQ1pZc0NyWER0aUhKNUtZSGVBb0R1TzZmTEJPSG9jRmJKQlRI?=
 =?utf-8?B?bHlhTEYyKy9FNXlITUFRSXVtdlJRTkJoNzJneXZBendDUjNBOW9LSXZncXVV?=
 =?utf-8?B?STdRWDRTUHlFUEVlWFZxS3VoV3VOdElNanV1QkdVK3hyM2hWamtCZ0l6cGJ1?=
 =?utf-8?B?V1p5ekhSYU1HTlZqNStjWWc4elpwczc4R0o5ci9SNllqLzBBRDRCU1B6TU05?=
 =?utf-8?B?Zm9YQnZTYW1waGkwMlZEYThsWVV0N3hQR2UrbU5BM0VhOWQ4cFc1Q2VuWjJH?=
 =?utf-8?B?VHM4Rk5rLy9ReklIakxsbGtBSjBxNjljRWluTFMrclFvNmEwK09MVzh3VVBs?=
 =?utf-8?B?dW1GcjVkb3FqNmZISzNibEIwM1FTb25naUxwVDlEcUEzbm9zT1E0VmNPdHRi?=
 =?utf-8?B?UlBKdStQZFlxV3NXODNqMkQzNHEzOUlrZ1BUYTFWaEFRckZVN1o2dXJ6cUZy?=
 =?utf-8?B?NW9MeHlBNXEzWjdYbEpqQUJmYTMxUys1aThoR042YnBvYU5WZXV1b1dYT3pV?=
 =?utf-8?B?a3dHd0w3dWhraGlERFNUYkc1TTNTR3VRaEVvUXhHS0N0MVptN25HUlIrMkN2?=
 =?utf-8?B?TkYyOVlFK3dTcVdGZG5YQWttN1pzcWtvTXdDWmhwUWlueng0UngrYUg1SG9r?=
 =?utf-8?B?Z1hxTUZYZFNwM0tPR3FjYmFLS3ZHQkU3dmtKYUhNd28vaUV0b1UxcmNUdUFN?=
 =?utf-8?B?dFUyRDc0MlJnT216Z1NmUEZKUjVaTXFVSXN1QTNyY0xhYlJWakV0TTVwdm0z?=
 =?utf-8?B?UFB6TkRqVmxqc3ZCR3YzOE1oOUZIa1htTkJUL0swVHR1ZkFrUjgya1ZSb1lR?=
 =?utf-8?B?T0FUNUFCZ1hJcHNhakhIMER4SzJtZXlBYk5xVDlrZHJyM3RyYjZsemFidVFL?=
 =?utf-8?B?Q0lrQkU2M3pnUTFhdUtkRk83cDJ1bDNOL3NwK0lJTytjZHU4UUJUbGVuTFp2?=
 =?utf-8?B?bzRGdHpaQ1B0SDVGcjV6ellDUi9zbVRrcDZnWDJORVFPYWpGa09hSE5DYkEw?=
 =?utf-8?B?ZGVUNXNJTHJhM2E2K3lNVlF4bXJhMllKZDZIRmNFb0pWNmZHUjBpK1dlN0xl?=
 =?utf-8?B?MFpxaExtQzZTR3hWdjlRdWlWUVY1OUFFK1U2VEdmM00rVTQ1SkpaMUphSWVF?=
 =?utf-8?B?Z0ZNcjdJdEZRV3pBU0ErOEFFYWRyNmJaY1F2NGZHdFFYekN4L1h6dENGR21O?=
 =?utf-8?B?QkxDUk1uNzZFYjdzWlRXaXFJVVJmSXplTEhJUUd3QUx0NFNQc1N2a0c5ZlE1?=
 =?utf-8?B?NE9nVWd5dXNvU2c1Und3RU9qL1BXNlNDbW51OVRaVVRuU0VMdTN5WEk5K1VK?=
 =?utf-8?B?SkNZMEhIM2IyUEtFRHJMelVEbFN1Rzd6aE9mcHRxUHZ4RGorZXQrZFR0VGhv?=
 =?utf-8?B?Ykd6cXUycjNaNUFHNWw2dlpIa2xjcnhwajA1aEZCa2ZGUStxTWREUlA5Z21j?=
 =?utf-8?B?VmsvNlZzOHFwdkpaK2Y3SFY4NTJuMThRaHBpeFR3ZURpWW9UTHBMd3pHN1Jq?=
 =?utf-8?B?ZlhiQlZIVGNpdnhRWUVnaXJhaTZ1a01ueXRTUElkNmhsNnZObDBiZGpHdUNI?=
 =?utf-8?B?M08wcHo1R2gzWUFqbmU1T2pFemZ1RWJsS0RBRXNNZ3AvRGsyQXJlOHJCeWls?=
 =?utf-8?B?ejIxTWlOVWtzVWxBajNNWmY2NWhLb05kM1lPYmEwakJSeUNwUFZ1R3AyV2h1?=
 =?utf-8?B?SXAzNWNNTVdRTDJTWko3NmZPU1RDK1BNeEwyQW1aUEpoSGU3eDlKM2Jrd1Bj?=
 =?utf-8?B?T2w4Ym9uNUFlOXRkcjMyYTdYNVBNN1dzekJSeUp5MWNuZ3QrTzRPTWd5LytQ?=
 =?utf-8?B?bitLYkZYMkVvZHNobklHWVQwS0MzY1MxaXRKOTFqMDFadzM1cm9CODVWUCtD?=
 =?utf-8?B?SFVzUmQ0NVRNUllGUWJQT2ZYZUJORnNXLzNiRCtUb1pTU1VJRHBKblFaTkVC?=
 =?utf-8?B?SytUTWtMQW5NQUJNMXM4eXJsejYvbjJ2UVBBUDhVUTRIUkM2dFRMYmJ2dXVx?=
 =?utf-8?B?UVNUY2hvT2ZIR3BDMURhYm1WVW44T3cvRnBVSTJWZVp2MGJkamhhOGFhYjBV?=
 =?utf-8?Q?k0UiUFuedPJ6jf8ptehiLzLoW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PPF4D26F8E1C.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0baeb73-5d42-4bba-b48d-08dd78ae92f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 04:08:54.1255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a/e/9SU6h9eLSYbDfFaUu8eGS/reUWtcJTbFetWlO7zJ8OfFTS8NQ/IuBSivEUthq3YZCmAjkeEuCvtDI5mwlHmUpxzlW3TFql6IZcvcNag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR07MB8169
X-Proofpoint-ORIG-GUID: YlK-1cFZIWS9PIhpZHMEO1LiiwLONdaM
X-Authority-Analysis: v=2.4 cv=HIXDFptv c=1 sm=1 tr=0 ts=67f895d9 cx=c_pps a=P5WujBTXSBe8sApKbu0jwg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=Zpq2whiEiuAA:10 a=uherdBYGAAAA:8 a=VwQbUJbxAAAA:8 a=Ne7jO0loYpmJZmy1riUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YlK-1cFZIWS9PIhpZHMEO1LiiwLONdaM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110028

Pg0KPkVYVEVSTkFMIE1BSUwNCj4NCj4NCj5PbiBUaHUsIE1hciAyNywgMjAyNSBhdCAxMDo1OTow
OEFNICswMDAwLCBNYW5pa2FuZGFuIEthcnVuYWthcmFuIFBpbGxhaQ0KPndyb3RlOg0KPj4gRW5o
YW5jZXMgdGhlIGV4aXRpbmcgQ2FkZW5jZSBQQ0llIGNvbnRyb2xsZXIgZHJpdmVycyB0byBzdXBw
b3J0IHNlY29uZA0KPj4gZ2VuZXJhdGlvbiBQQ0llIGNvbnRyb2xsZXIgYWxzbyByZWZlcnJlZCBh
cyBIUEEoSGlnaCBQZXJmb3JtYW5jZQ0KPj4gQXJjaGl0ZWN0dXJlKSBjb250cm9sbGVycy4NCj4+
DQo+PiBUaGUgcGF0Y2ggc2V0IGVuaGFuY2VzIHRoZSBDYWRlbmNlIFBDSWUgZHJpdmVyIGZvciB0
aGUgbmV3IGhpZ2gNCj4+IHBlcmZvcm1hbmNlIGFyY2hpdGVjdHVyZSBjaGFuZ2VzLiBUaGUgImNv
bXBhdGlibGUiIHByb3BlcnR5IGluIERUUw0KPj4gaXMgYWRkZWQgd2l0aCAgbW9yZSBzdHJpbmdz
IHRvIHN1cHBvcnQgdGhlIG5ldyBwbGF0Zm9ybSBhcmNoaXRlY3R1cmUNCj4+IGFuZCB0aGUgcmVn
aXN0ZXIgbWFwcyB0aGF0IGNoYW5nZSB3aXRoIGl0LiBUaGUgZHJpdmVyIHJlYWQgcmVnaXN0ZXIN
Cj4+IGFuZCB3cml0ZSByZWdpc3RlciBmdW5jdGlvbnMgdGFrZSB0aGUgdXBkYXRlZCBvZmZzZXQg
c3RvcmVkIGZyb20gdGhlDQo+PiBwbGF0Zm9ybSBkcml2ZXIgdG8gYWNjZXNzIHRoZSByZWdpc3Rl
cnMuIFRoZSBkcml2ZXIgbm93IHN1cHBvcnRzDQo+PiB0aGUgbGVnYWN5IGFuZCBIUEEgYXJjaGl0
ZWN0dXJlLCB3aXRoIHRoZSBsZWdhY3kgY29kZSBiZWluZyBjaGFuZ2VkDQo+PiBtaW5pbWFsLiBU
aGUgVEkgU29DIGNvbnRpbnVlcyB0byBiZSBzdXBwb3J0ZWQgd2l0aCB0aGUgY2hhbmdlcw0KPj4g
aW5jb3Jwb3JhdGVkLiBUaGUgY2hhbmdlcyBhcmUgYWxzbyBpbiB0dW5lIHdpdGggaG93IG11bHRp
cGxlIHBsYXRmb3Jtcw0KPj4gYXJlIHN1cHBvcnRlZCBpbiByZWxhdGVkIGRyaXZlcnMuDQo+Pg0K
Pj4gUGF0Y2ggMS83IC0gRFRTIHJlbGF0ZWQgY2hhbmdlcyBmb3IgcHJvcGVydHkgImNvbXBhdGli
bGUiDQo+PiBQYXRjaCAyLzcgLSBVcGRhdGVzIHRoZSBoZWFkZXIgZmlsZSB3aXRoIHJlbGV2YW50
IHJlZ2lzdGVyIG9mZnNldHMgYW5kDQo+PiAgICAgICAgICAgICBiaXQgZGVmaW5pdGlvbnMNCj4+
IFBhdGNoIDMvNyAtIFBsYXRmb3JtIHJlbGF0ZWQgY29kZSBjaGFuZ2VzDQo+PiBQYXRjaCA0Lzcg
LSBQQ0llIEVQIHJlbGF0ZWQgY29kZSBjaGFuZ2VzDQo+PiBQYXRjaCA1LzcgLSBIZWFkZXIgZmls
ZSBpcyB1cGRhdGVkIHdpdGggcmVnaXN0ZXIgb2Zmc2V0cyBhbmQgdXBkYXRlZA0KPj4gICAgICAg
ICAgICAgcmVhZCBhbmQgd3JpdGUgcmVnaXN0ZXIgZnVuY3Rpb25zDQo+PiBQYXRjaCA2LzcgLSBT
dXBwb3J0IGZvciBtdWx0aXBsZSBhcmNoIGJ5IHVzaW5nIHJlZ2lzdGVyZWQgY2FsbGJhY2tzDQo+
PiBQYXRjaCA3LzcgLSBUSUo3MlggYm9hcmQgaXMgdXBkYXRlZCB0byB1c2UgdGhlIG5ldyBhcHBy
b2FjaA0KPg0KPlRoaXMgb25lIGxpbmUgcGF0Y2ggc3VtbWFyeSBpcyBub3QgdXNlZnVsLiBXZSBj
YW4gbG9vayBpbnRvIGluZGl2aWR1YWwgcGF0Y2hlcy4NCj4NCg0KV2lsbCByZW1vdmUgdGhpcyBv
bmUgaW4gdGhlIG5leHQgc3VibWlzc2lvbg0KDQo+Pg0KPg0KPlRoaXMgc2VyaWVzIGlzIHYyLiBQ
bGVhc2UgdXNlIHZlcnNpb24gaW4gdGhlIHN1YmplY3QgcHJlZml4IGFuZCBhbHNvIGluY2x1ZGUg
dGhlDQo+Y2hhbmdlbG9nIHNlY3Rpb24uDQo+DQpQbGFuIHRvIHNlbmQgb3V0IHRoZSBuZXh0IHBh
dGNoIGFzIHYzLg0KDQo+PiBDb21tZW50cyBmcm9tIHRoZSBlYXJsaWVyIHBhdGNoIHN1Ym1pc3Np
b24gb24gdGhlIHNhbWUgZW5oYW5jZW1lbnRzDQo+YXJlDQo+PiB0YWtlbiBpbnRvIGNvbnNpZGVy
YXRpb24uIFRoZSBwcmV2aW91cyBzdWJtaXR0ZWQgcGF0Y2ggbGlua3MgaXMNCj4+DQo+aHR0cHM6
Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvQ0gyUFBG
NEQyNkY4RTFDMjANCj41MTY2MjA5RjAxMkQ0RjNBODFBMkE0MkBDSDJQUEY0RDI2RjhFMUMubmFt
cHJkMDcucHJvZC5vdXRsb29rLmNvDQo+bS9fXzshIUVIc2NtUzF5Z2lVMWxBIUhIYUttMUNCdjFq
cFJMUDZYTFJIaVphSFhUVkRXN2R0RVhwMWs1R3J6TDYNCj5zRVo1YXZGN25rY1RtVFJjLXhVMWds
ckpMbXlkeGZpX0h2TGt3Q2hJdEZFd28yRG8kDQo+Pg0KPg0KPlRoaXMgaXMgbm90IGhvdyB5b3Ug
d291bGQgYWRkIGNoYW5nZWxvZyBpbiBjb3ZlciBsZXR0ZXIuIFBsZWFzZSByZWFkOg0KPkRvY3Vt
ZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMucnN0DQoNCk9LDQoNCj4NCj4tIE1h
bmkNCj4NCj4tLQ0KPuCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/g
rrXgrq7gr40NCg==

