Return-Path: <linux-pci+bounces-26352-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05105A95D3E
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 07:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C545B1890EC2
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 05:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1EF19F420;
	Tue, 22 Apr 2025 05:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="oazXYVOL"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB18DBE46;
	Tue, 22 Apr 2025 05:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745299021; cv=fail; b=YgSxIAJ8ZUwX2lEoTzKFo9fCtPFI19QCuXfBsmOTRgjqW6+VtkmvlJHlZgubdfaMsye5kpUeVZSgKBFteql5fPcgRflkTw4yn70iVkNnlUwIVewCGQmHNiZWPFkPBsvnW2nmiASouTYQ28MVIA9DTuBZOdO9VF5RVFd53FNCbb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745299021; c=relaxed/simple;
	bh=G6g5Yb0GCrgs1+bfGNU/KTnE2nRy7VV0mLPSU2fXevM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QDj3r3DNaE4Ew7sVAfB9qsCkXuvH5ioK+yM6bBuqdItxphPQtOL28jFOdXn/qaDEdWgyYkzJqdL1ejpH6+CCx1uD06lymGiMNPzNhD1kHy4t9Epgdy0qHQwEY/+d1omnghh5bqkPMK+QZl7uB70gkDA1L4efeoReUWNegz1N3go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=oazXYVOL; arc=fail smtp.client-ip=40.107.21.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gc+I6/sRpFsXrw7vdKBHIXPHW98bCWYnzzF4uE98NZpur7uCAWhTuRByyjhm/BRhNikNOq3ed4tYKWR4aOz/mSEfhWKq/FKXVAHAW2MOgba0dZ58ujfAgSJdauPNg/Z7oJItvJ60eJN/25G6/f9K+oinYM335TcleJ2WmN7SoQDX7IgGtffm2LeQq++hKxifO1B0O0IDaF2kF7iwODg20wrr6qF+OsAST5OVFgzPYh0k/O9lC9/2UQxXJiMEGBJUTaWFMb7qkVPgFHgBpkY+2xB1MAAHcyXfcIdzhV1Ngd6STKctWXdFVAz3h6Dni3RahUczuiQrJxv+GvSrJ2F0Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6g5Yb0GCrgs1+bfGNU/KTnE2nRy7VV0mLPSU2fXevM=;
 b=ThPlvgvPeEI79wMtVtI1mGYJTKl9lGOaPWAXzoqdBctSgbpyvxp+wVrGh/WWzN/fT0Wg49fCTyQT1vlVj3HG5qZhnxPRGFOGhqYVt7SUvl1Ry2gP/TnfWAK05x/HVqZ6AOeIhF1cdiQquHrSaL7PTSp8vJE6Qr1lQnAYJefYe7qxZEuN4a8of9Ah5Jpv0i2z5uV6W7Hh/+rfGbqfe+S03NrZvTgrASunix0/DjlSBg7Ju53fc3RnqTXFzNiUN9XAByK+OldmhxePHvDOYLNBW4beUhEb4gRoC4dLuIrNQiVTBG5NASN2kVmaLDYs2PRpMBE29M7sQ24u3WcUBgvRuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6g5Yb0GCrgs1+bfGNU/KTnE2nRy7VV0mLPSU2fXevM=;
 b=oazXYVOLiNpUIY/q2AGPzknB0LNIEvwRN4Kwu7cQiQGdJuNMkzrYj3kHYxSLvdilo5XX4XzkJiiBkz4VQStmipukXshVNoaPFt7pVM/DS8uZeneYM77zsH6yiw6di1wObdBnc6bNr2fOi6/3E09YxvK4ApHEwvVf/ergOl3pdOX3mROXjg9sY/mLPp67jC9MR/NZLwnSGS0S87fDQy3RSl2ekIq0HcC15luZ8dRJNCB7iFRUTJWleMYJddQIBFHKHtEZuUXA3RR74G7mSu6BZea7XbJVEC2AC+gRXsAhj2NEis39UiC/SkFOEy6QzVTo49OhCdswZyi3BFFleuc4Ig==
Received: from AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a4::10)
 by VI1PR10MB8136.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 05:16:55 +0000
Received: from AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::380b:e782:af48:75d4]) by AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::380b:e782:af48:75d4%7]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 05:16:55 +0000
From: "Li, Hua Qian" <HuaQian.Li@siemens.com>
To: "nm@ti.com" <nm@ti.com>, "helgaas@kernel.org" <helgaas@kernel.org>
CC: "ssantosh@kernel.org" <ssantosh@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "kristo@kernel.org" <kristo@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"s-vadapalli@ti.com" <s-vadapalli@ti.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "Su,
 Bao Cheng" <baocheng.su@siemens.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"vigneshr@ti.com" <vigneshr@ti.com>, "Lopes Ivo, Diogo Miguel"
	<diogo.ivo@siemens.com>
Subject: Re: [PATCH v7 0/8] soc: ti: Add and use PVU on K3-AM65 for DMA
 isolation
Thread-Topic: [PATCH v7 0/8] soc: ti: Add and use PVU on K3-AM65 for DMA
 isolation
Thread-Index: AQHbsDPMicsFTVqYB0WmwY6YOxQLWbOpb04AgAAvq4CAACoMAIAFYhOA
Date: Tue, 22 Apr 2025 05:16:55 +0000
Message-ID: <aa3c8d033480801250b3fb0be29adda4a2c31f9e.camel@siemens.com>
References: <20250418134324.ewsfnze2btnx2r2w@country>
	 <20250418163401.GA159541@bhelgaas> <20250418190430.onhuowuu4bwtlm5f@sequel>
In-Reply-To: <20250418190430.onhuowuu4bwtlm5f@sequel>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6993:EE_|VI1PR10MB8136:EE_
x-ms-office365-filtering-correlation-id: e0833e46-0598-4f8e-6652-08dd815ce610
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SHBNb05NRmxsUng3alViR2djSnRzTWRDdlpwSUMvQUNRSjZaM3pvQXFrMzFE?=
 =?utf-8?B?dWk4SmpOLzJKYXRrV1NrMEFCNkRNMS9PZjZ4dGdIMVlseGF2QlRXN2VBSmxo?=
 =?utf-8?B?dkVmbE5QeVJTNTdnc3MvRGdUN2dEL01jb0hWMkJmNUdodWhaY1p2NDIxUllm?=
 =?utf-8?B?bmMwNE5jZTBYeGgzT212S0E5bWhQVHkxVG1lYUNTbHdSOUtOVnlEMjdkSHg5?=
 =?utf-8?B?cWMxN0NHNldYTm1veFQvS3l1NExyNmtncGtjK3lub0Fra0F4UVVoRjZsRTc3?=
 =?utf-8?B?blB5M0VpUkU2YldzSytJanFwWkRvTlNBWDZKdUJRSk1nR2E0UXZaaVVoK2pr?=
 =?utf-8?B?QXowOEh0dTByeTl3am9jZXdBcW1VSDMwdlI2TysrNjZhVWRpeXlHUHBTTE1k?=
 =?utf-8?B?R2JHZmhZeGQ3Tm9UQVduMzdhVjNOdUJZT29uUENFQnZvaFo1Y3pWOWpONmEx?=
 =?utf-8?B?T3V4elI0RmNYQjJaOHRsNlZ4N05UWUJFQjdPOStDM0dqVVp2dXk2ZVJ0TDlt?=
 =?utf-8?B?c0xJQmN2R3Q1dUVVRVNXUEhWMXAreDAwb3NKNzFUdXdENHMzYW1XdzMvWHQ3?=
 =?utf-8?B?ZkVvenVLendCeER5akVnTWhKOGIwa1JNSlFqdC94akNxSG94blpQQUpTbG9M?=
 =?utf-8?B?emNUZzhock5iVWlDYXhxWlZhS2NlL1BVS3pobU9JVUZNMUdSalBiaEo5MStC?=
 =?utf-8?B?WitJYWgzMXdHZzlHd1JXbGpHUVIvNG1kSWVKRlNOekxiUDFZM0xjQnNUZllw?=
 =?utf-8?B?eThPREhZek9WQ1E5L0hjZm1mVnFCa3JwL3k0eWIzdzB6cG4wTnBoT1ZXQXBp?=
 =?utf-8?B?VmV0UURqODJ1b1FERTRRWStuV0dxekdtWkxBblY4NG9hWjZGb253TGsyRTVE?=
 =?utf-8?B?aXZwWHN3b2RaQ3dPQzRsUzl2REpvVTBkbE0yQ2pzMlNaYzJXVFBJaGdHcDRs?=
 =?utf-8?B?U2ZieUVhV1pTMU8wWUh2N05DYXlGamVram1saTF1cURvYzVYWXFyek5pak4z?=
 =?utf-8?B?Nno5QXBUemdaeWNFVXlvck9pZXAreUYrVFd5a2t6aFluMjhhWkh1U3dZNW5t?=
 =?utf-8?B?cm1RUld2T3Rab3U4WVg2SVp2d3N4eldNaElZM2hwYytkMzEzQ3o2enI4Y1Fm?=
 =?utf-8?B?UFQvTUFFT0paUmQycW11djBhSnZHREIwV21pYUMyUnliclYzV2k0QVpEcWh0?=
 =?utf-8?B?eTZwVkRDQUlVZCsyNjcrUjIveFY0N3FuT1RadHBoNlNCSUFZRFpDYTBPREFh?=
 =?utf-8?B?RHhxMjFVVVZSZzZTVDZFSkFXMkd5WDVySWJhSWFNbjJxUTg1MXdSQWduWFEy?=
 =?utf-8?B?S0R2alRYY210clBvbzJaeHpTTWdnWDVxeWJkRUlCcXVsVmdFYnNNRllSSGkw?=
 =?utf-8?B?bFYzWkZRTXl5SUVQeml0eU9OQ3R5Q1FFSkU2bzJIdG85dzUvVGFhR2lrWHJ3?=
 =?utf-8?B?dlZ5YU1kM1lYcGFFQWFFTUFoOVZZSUwzYWloYXpLNzZNMjRYWmh1aUJlUHcy?=
 =?utf-8?B?djNHbXAzM2xPTE1rcThsZGtEYmVDN2xYRWNPMHI3Sms0ZDBPNVBJY0pTNjlv?=
 =?utf-8?B?U1FOb0dTbmUyM0hhU1dCR0dNcXJNcExabkZNczRmd2V3cEc2VWs4QWtnU1ov?=
 =?utf-8?B?dWt5aWpMZk9qeDhiSE1BazJyOTVMMlJqc09Xa0ZEbmlhM05DcytQMG5RbkVS?=
 =?utf-8?B?a0VLSHdCTXRSZ3dyTENHaThVcURyZVA5YlJ6L21yRjJqMlFsWlZOMk03dFZK?=
 =?utf-8?B?UFk0SzNlcXZWSkNLM1VvMncxbWZ1WXY1QllzZTNOL0ZxMTVjL1JNOEpvUjRv?=
 =?utf-8?B?cmlKS3JBTmtRTk1WYlFKTGczTWdvaVRXdEVQeXZqK2NQaTNrR2NhRmVFUW5p?=
 =?utf-8?B?dStlRWxHNDNQajVFandweWJvaURHVnJlRm5Ob1hKV1RWejBvM3dYbnJHNWV5?=
 =?utf-8?Q?vLIMxaSxev8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QW9MZnZUcHRwWVVUSlFjS3poWDRFZk91ZS9WWFJyRFE1QXkwMTRaeUpseE5R?=
 =?utf-8?B?VVIvUEpGUENYWGs4bFZWK0RzV09aUE5QQW5PVGphOFkxRm1KeUVpQUU3M2ky?=
 =?utf-8?B?TXoyd0ozL1YwWlVhSE91OUV5aFhqYmZNSDRTWnd6SGRqOFU2TEtuN0NLV0FL?=
 =?utf-8?B?Y2hUTWpraElkTWc5K0Z0Sk5YblZyWURwT3p4V3pWWThSRzJtWWE0aTVxRlVC?=
 =?utf-8?B?SDlTVU9mMWtTRFNyY3JRNFR3QlM1RnRtL21aMHZZMGJSY0ZDV2NURU5wV3ZU?=
 =?utf-8?B?TEl6ZDhxRW45cmJlSU5QT3lSOEdaNmliaEV5TWZSMGd4TW9zSUlkcTJ2dWFD?=
 =?utf-8?B?TlR0RDlTRXJyckkyOEJvTDZDTnpDeGRaK0tFWnlvZUJrWW5LKzUrU1dxTFp2?=
 =?utf-8?B?U2NxVC9TakcxUllQMUdWUHVneHAvZDdOQkJwTkVNQjJrQVVyeG5LL0p1ZjB6?=
 =?utf-8?B?WVhUZ0Z4RlBoc0U3UnhaRXZXcnV6NVNwTWJ4Q053V0hSL09xTUJWN1RzTnlZ?=
 =?utf-8?B?aTNlLzR1a2tWbXIzOFNEME1qZ2pITWVSZExtQ1E3d2lYdzN1K2ZOTHVLMm1F?=
 =?utf-8?B?U3RWS0NXeGJadVZScTVHMGpWQ2VNZ01oaDhlNXYvQWVsVitZQ3FhWml0djkv?=
 =?utf-8?B?REhsR0NnRGNLRTByRXVPM2F0eHZyckxBYTkxc3ZaODlSR0J4Q1RsL2ZjNlVh?=
 =?utf-8?B?cW9nQXhDSFVhNjZLazhUSUw4b3pwd2VYN2NZaXpaQUtYa0x6K2dza25kbk83?=
 =?utf-8?B?Yytycjh6aVJ0dy9UdGlZK3NoWC9zUWVKWVFoS1JiRW1wYnYvdDl2ODBJOFlI?=
 =?utf-8?B?ZDNrS2tyZnV5UnVQeUpCOUJWdmdRMlB1cTZYWTFlWDdhS1BHQnFUMXJEbWdY?=
 =?utf-8?B?ZjRvSWwyQkQxd0ZhektvZzZjNEw3UXBySTJFR3g4STZTSzVsYTlHa1hoalFx?=
 =?utf-8?B?bEtkRGhaU05KTFFNbHR1bHBuaFVybEF6cU1kVWE1OXYyMFhqUTdDSWFORFdu?=
 =?utf-8?B?dWVVMHNaZ1lCZ1RCWEJLTE83eWZTa1hRTDFUdkg3Ky9rMlRQemkxcUdUZEZ0?=
 =?utf-8?B?MlNpZEVYZWoxZ254WnV3b1FiYzlsdnJVRU1FelRSQjRIbHpMUXp5OVoySDFI?=
 =?utf-8?B?cElDY0lQdUUzekF6V2JiVTlHUmQ3aUNJQWtDRHF5TDU1cFBBdVNSWktUeHBT?=
 =?utf-8?B?eTJSZktuL0FjSHZ3NHp5SnJwTTNvRVFXYmdmVi9hcmw2aUl0TFV1TlFiVVdL?=
 =?utf-8?B?ZjVobDFEQWJqSGNBaUF1WXZzbjFHUHBVby9BK0lzeWpEaDhJQmswY04rSTA5?=
 =?utf-8?B?ZFVuUXZ5anZyWkg2em13a3B6QTJmeVhlZVlaMWsyTk0zcXpEcG45MVZSZzNh?=
 =?utf-8?B?bW9VUG42b1JXMGhDTVNOSUlUK0NPcmRpVXZkci84VllRSGk4WkM0TGIyMHYy?=
 =?utf-8?B?SERLZk1vZ3VPTk8xVURwOEJnODhYM3BxTStXU0ZsRVA4ejJXd3RGTE1MdkJk?=
 =?utf-8?B?U29WNThmaE14YmNFdXFGQUI4aElsOFgxc0VRdkFRcmpneWVYSC9FNHYzaFo2?=
 =?utf-8?B?MEpKeDZlWFh1bkxxNS9SaVhMRkloWjJRVWE0VEd1TmpqdnNzZXJHaUhKQkc3?=
 =?utf-8?B?ZlNvekJzV2dVeEgxYzIwZGtFVzRkc2ZRSlNjRTI4akJFVHFkQlJBUTYvM1pV?=
 =?utf-8?B?czBUbGd0WUtQU0pSWTJldkV3L29zYkZLSThQeDBYQzkxeUxFUmxMWmNsaVlM?=
 =?utf-8?B?WmY0K2s2K01US3J2UUN3dHVTZG1XaGFsU1F5WkthdGlnVGF3bFZlM1d6cTJI?=
 =?utf-8?B?QmxWS0lCaW5sT2pjUVZ1M0wvdGhoYWtsMko0bGxiR094ZU9HVDJUM010ditF?=
 =?utf-8?B?VVo4R3ZWeExRRTR3WGt2ck4renVienc2Tkwwc0tqOG9RbzlEeFE1WXpUNDN0?=
 =?utf-8?B?T3JQQUVOb1FCay9vWnk5bW96Q0hwSkNWYXBpdFpMVTJXby9qQkY1UGlONHRZ?=
 =?utf-8?B?YllGZTdlVnZONmtlWDNxeXBSb2ZkMTJKaWJ3OVFNMEhrdTBxa2VlL29FdkRC?=
 =?utf-8?B?ZktFWFVDL1FEL3NNVkNkNEF0LzJDSmJGTGxOcWJiYkJWTXNrZXY0b1Z2T0t6?=
 =?utf-8?B?SVVRTXRmWGZJUXhtQXhjN3BQbTdGZWo1dGIzNEZjbmc3TFRhYW5pcW5xbjdU?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <042720729C18994FA67E64376C4D2E97@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e0833e46-0598-4f8e-6652-08dd815ce610
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 05:16:55.2761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MxycWZbfDdW3aEqa87xnUh7bJDUUEbTe2l5VNmNoRtUvkoJLI/PNvrWziWgd6ZkPh+3Rkj8LR6uCUaHrOMq6SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8136

T24gRnJpLCAyMDI1LTA0LTE4IGF0IDE0OjA0IC0wNTAwLCBOaXNoYW50aCBNZW5vbiB3cm90ZToN
Cj4gT24gMTE6MzQtMjAyNTA0MTgsIEJqb3JuIEhlbGdhYXMgd3JvdGU6DQo+ID4gT24gRnJpLCBB
cHIgMTgsIDIwMjUgYXQgMDg6NDM6MjRBTSAtMDUwMCwgTmlzaGFudGggTWVub24gd3JvdGU6DQo+
ID4gPiBPbiAxNTozMC0yMDI1MDQxOCwgaHVhcWlhbi5saUBzaWVtZW5zLmNvbcKgd3JvdGU6DQo+
ID4gPiA+IA0KPiA+ID4gPiBKYW4gS2lzemthICg3KToNCj4gPiA+ID4gwqAgZHQtYmluZGluZ3M6
IHNvYzogdGk6IEFkZCBBTTY1IHBlcmlwaGVyYWwgdmlydHVhbGl6YXRpb24gdW5pdA0KPiA+ID4g
PiDCoCBkdC1iaW5kaW5nczogUENJOiB0aSxhbTY1OiBFeHRlbmQgZm9yIHVzZSB3aXRoIFBWVQ0K
PiA+ID4gPiDCoCBzb2M6IHRpOiBBZGQgSU9NTVUtbGlrZSBQVlUgZHJpdmVyDQo+ID4gPiA+IMKg
IFBDSToga2V5c3RvbmU6IEFkZCBzdXBwb3J0IGZvciBQVlUtYmFzZWQgRE1BIGlzb2xhdGlvbiBv
bg0KPiA+ID4gPiBBTTY1NA0KPiA+ID4gPiDCoCBhcm02NDogZHRzOiB0aTogazMtYW02NS1tYWlu
OiBBZGQgUFZVIG5vZGVzDQo+ID4gPiA+IMKgIGFybTY0OiBkdHM6IHRpOiBrMy1hbTY1LW1haW46
IEFkZCBWTUFQIHJlZ2lzdGVycyB0byBQQ0kgcm9vdA0KPiA+ID4gPiBjb21wbGV4ZXMNCj4gPiA+
ID4gwqAgYXJtNjQ6IGR0czogdGk6IGlvdDIwNTA6IEFkZCBvdmVybGF5IGZvciBETUEgaXNvbGF0
aW9uIGZvcg0KPiA+ID4gPiBkZXZpY2VzDQo+ID4gPiA+IMKgwqDCoCBiZWhpbmQgUENJIFJDDQo+
ID4gPiA+IA0KPiA+ID4gPiBMaSBIdWEgUWlhbiAoMSk6DQo+ID4gPiA+IMKgIHN3aW90bGI6IE1h
a2UgSU9fVExCX1NFR1NJWkUgY29uZmlndXJhYmxlDQo+ID4gPiANCj4gPiA+IEkgc2VlIGF0IGxl
YXN0IDMgb3IgNCBtYWludGFpbmVycyBuZWVkaW5nIHRvIGNvLW9yZGluYXRlLCBnZXRzDQo+ID4g
PiBjb21wbGljYXRlZCBhcyBJIGFtIG5vdCBzdXJlIHdoaWNoIG1haW50YWluZXIgbmVlZHMgdG8g
cGljayB1cA0KPiA+ID4gd2hhdA0KPiA+ID4gcGF0Y2hlcyBpbiB3aGF0IGRlcGVuZGVuY3kgb3Jk
ZXIuIFRoaXMgbG9va3MgbGlrZSBhIG1peGVkIGJhZy4NCj4gPiA+IENhbg0KPiA+ID4gd2Ugc3Bs
aXQgdGhpcyBwYXRjaCBpbnRvIGluZGVwZW5kZW50IHNlcmllcyBmb3IgZWFjaCBtYWludGFpbmVy
DQo+ID4gPiB3aXRoDQo+ID4gPiBjbGVhciBpbmRpY2F0aW9uIG9mIGRlcGVuZGVuY2llcyB0aGF0
IGlzIHNwcmVhZCBhcm91bmQgYSBjb3VwbGUNCj4gPiA+IG9mDQo+ID4gPiBrZXJuZWwgd2luZG93
cyAobWF5YmUgZHRzIGNvbWVzIGluIGxhc3Q/KQ0KPiA+IA0KPiA+IFRoZSBrZXlzdG9uZSBwYXRj
aCAoIls0LzhdIFBDSToga2V5c3RvbmU6IEFkZCBzdXBwb3J0IGZvciBQVlUtYmFzZWQNCj4gPiBE
TUEgaXNvbGF0aW9uIG9uIEFNNjU0IikgZGVwZW5kcyBvbiBpbnRlcmZhY2VzIGFkZGVkIGJ5ICJb
My84XSBzb2M6DQo+ID4gdGk6IEFkZCBJT01NVS1saWtlIFBWVSBkcml2ZXIiLCBzbyBJIGNhbid0
IHJlYWxseSB0YWtlIDQvOCBieQ0KPiA+IGl0c2VsZi4NCj4gPiANCj4gPiBCdXQgSSd2ZSBhY2tl
ZCA0LzgsIHNvIGl0IGNhbiBiZSBtZXJnZWQgYWxvbmcgd2l0aCB0aGUgcmVzdCBvZiB0aGUNCj4g
PiBzZXJpZXMuwqAgSSBhc3N1bWVkIHRoZSBlYXNpZXN0IHdvdWxkIGJlIHZpYSB0aGUgZHJpdmVy
cy9zb2MvdGkvDQo+ID4gbWFpbnRhaW5lciwgaS5lLiwgeW91LCBOaXNhbnRoIDopDQo+ID4gDQo+
ID4gTGV0IG1lIGtub3cgaWYgSSBjYW4gZG8gYW55dGhpbmcuDQo+IA0KPiBUaGFua3MgQmpvcm4s
IHRoZSBzd2lvdGxiIHByb2JhYmx5IGlzIG9uZSBvZiB0aGUgZmlyc3QgdG8gZ28gaW4sIEkNCj4g
Z3Vlc3MuLiBJIHdpbGwgbGV0IExpIEh1YS9KYW4gc3VnZ2VzdCBob3cgdGhleSdkIGxpa2UgdG8g
cXVldWUgdGhpcy4NCj4gDQpIaSBOaXNhbnRoLCANCg0KQXBvbG9naWVzIGZvciBtYWtpbmcgdGhp
cyBzZXJpZXMgbW9yZSBjb21wbGljYXRlZCwgYW5kIHRoYW5rIHlvdSwNCkJqb3JuLCBmb3IgdGhl
IGV4cGxhbmF0aW9uLiBJIHdpbGwgdGFrZSBwYXRjaCA4IGFuZCBzdWJtaXQgaXQgYXMgYSBuZXcN
CnVwc3RyZWFtaW5nIHNlcmllcyBzZXBhcmF0ZWx5Lg0KDQoNCi0tIA0KSHVhIFFpYW4gTGkNClNp
ZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

