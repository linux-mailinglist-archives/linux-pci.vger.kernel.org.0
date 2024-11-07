Return-Path: <linux-pci+bounces-16208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1FA9C0032
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 09:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1451F22603
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 08:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC84818754F;
	Thu,  7 Nov 2024 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Idx0sygV"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2062.outbound.protection.outlook.com [40.107.249.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7C1D53F;
	Thu,  7 Nov 2024 08:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730968864; cv=fail; b=Ef5zBYFDXfADM356ya3NFC6ER3h/1do+xC5y1+hMzBseIZo0UcUHzoSku1fCI6J9jutKtD7F9kO9ZJKFsN+h22hL9aYc8hHUGmHq8YZq65ZdlGAyA1w9G4uPUaEPZf7h/CVqXlspNIeduo1ALFONDLZfbBgfgDF0MEghgP9yrVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730968864; c=relaxed/simple;
	bh=rn9fQXuzYUxz5ZCeChXyG9zoCPIJ/U9SOj6hv8xBWmg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kPR2jH2mTucVjCR84zoICWdL/wRL0KoupLUhHFOqiv0T3NuRRn7YNq/J4pMMO1Cxu9YDJJOVWD3trup575jogJCu64BdAtFEvGa6PqibTrYYyDFSFOzSJz0LgyYy36MMUxTYW/8VfmtRxLx+QTRIqr1nM88MfC9K4PAQt4Ep0ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Idx0sygV; arc=fail smtp.client-ip=40.107.249.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMargfC3+fBqd1hbcJ8xMSzimz6R0Pkp7avhqn5tIK+G0jxloA7HVlU2sT9DOUsZu2f8zq2DS3QYY5hfy2UX8B33L2wcFRZQ53PYsgSKZsxaCN75q10QGVQNgPZY9AobRDZxWnOPOcmhHPM3XdlwBp2o9fH0+SsHLIEVnd3EXElSGkchDxQxEf13kX4sUllsSOSHb3b5Gbw+w/LB9eweq8mVae6OhprwL/OYDEN/W1vnLubrUip32U53RtatYZ9SFEY13DvS8gLf1k407tLd2aMbB2R9a5D2bpF4dPzQMPQiLx1Rjt0BPs927gNfx6hd1pORchO/IyWho3LkkgZ2Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rn9fQXuzYUxz5ZCeChXyG9zoCPIJ/U9SOj6hv8xBWmg=;
 b=ZRK/z1bBI0HIFK6qnyazG3v9jLeA/ndH9Zu2RbH6Yaa3TholVqOV2QZXOvxsaztNe8Cr6pT0OFyzAZdHtmfxSr1DJzKGsku6LwgJrszxjGxeR6s8fxfQERFPNwnJabqD8Y3E5MWT8SP4GsMl9tmnthvy39jGBFXv1Pul/oUMB4dTXdHVikztO44QDQGaGML2bF8VtnoFXTT/oTmu3Rm4sGepueYOkkwjtmq4Fr5Hndu6ktTDUCAns6fsifUBZzgl16X2TqeQOn7L6q3Y9SStnOe448cF29CxhGWt/hbP0O/21wswfnqsRIvPVL31JqZpDbLRi1vkmqhCOXHvVyUZug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rn9fQXuzYUxz5ZCeChXyG9zoCPIJ/U9SOj6hv8xBWmg=;
 b=Idx0sygVaP21+hdcUxJGyV0u7sFq2+bM0YYftqzarzwJLc//YNNwr2/tMuxXImRKH00zxQZ37TQZSMZ2mWjlLrOH1I1dgCV4aXeOdp2S72uMCLulD4YtxrwwWcarSmqhs2DCDKLauG1ORG1rLRA/Ktf+I4t60gpoVeYDpgJO/zpb7Rmqn+kZ8mDQz9DfaIZ/ba2nHsCN83Z5s+zFCafLDr1kTfMPLggLS4ZxHb4i/Wd+DMhbKkFqsaB2lI5YJf11EjCq8wMJRgsL912R+EG9lkeU7iojLWeYKxPfCq40c8OWWR5kYBZONyMkYJ1hZMa65XckcIuGpvtzCbhrum5K8A==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by GV1PR04MB9150.eurprd04.prod.outlook.com (2603:10a6:150:25::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 08:40:57 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 08:40:56 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: =?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?= <kw@linux.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lorenzo.pieralisi@arm.com"
	<lorenzo.pieralisi@arm.com>, Frank Li <frank.li@nxp.com>, "mani@kernel.org"
	<mani@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v2] PCI: dwc: Fix resume failure if no EP is connected at
 some platforms
Thread-Topic: [PATCH v2] PCI: dwc: Fix resume failure if no EP is connected at
 some platforms
Thread-Index:
 AQHa3AEqv5bRdDxqKkSUwsC4eegPdrKp/GuAgAAjY0CAAV7kgIAAfShQgAAXEoCAABUTEA==
Date: Thu, 7 Nov 2024 08:40:56 +0000
Message-ID:
 <AS8PR04MB8676F00E8F76B695772EB3B18C5C2@AS8PR04MB8676.eurprd04.prod.outlook.com>
References:
 <AS8PR04MB8676998092241543AEABFAAB8C532@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20241106222933.GA1543549@bhelgaas>
 <AS8PR04MB8676C98C4001DDC4851035B18C5C2@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20241107072005.GA378841@rocinante>
In-Reply-To: <20241107072005.GA378841@rocinante>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|GV1PR04MB9150:EE_
x-ms-office365-filtering-correlation-id: 0b5271d9-2ce2-479c-e856-08dcff07e5dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?OSt2WER0bGxnMW0xZkQvNWZMR3lPMVlRbmtxWDhoWS9Zc3FhWGRFRE5uNmVI?=
 =?gb2312?B?c3pudmtsQllncEV1RHZXanQ4ZDNrMWx0L1ozVHcvZ3RnQ3NIclRLYVdZSFlz?=
 =?gb2312?B?NElSRDZTUzY1VS85cFR1clEvK0UyVEpvTTBDWDRUcjJJOHZrTDhQWTZLOVA3?=
 =?gb2312?B?WXJBL1M5VmdDZG94ZUtyOUxxVWt1c3Vzcm9sYVp5M2N0MTFnOCs1bmdGZjdo?=
 =?gb2312?B?NEpQTW1ZdDBKWitBdEZITU5NZEFkeUFSZXIyOWpQUnRmaHB0dUpDWDRUTnhQ?=
 =?gb2312?B?MVRGTlppN0UzWE5pV0YrMWtIMlBvc2x3MGhzNS9iNU9PbnFOeWt2dmJSMCtF?=
 =?gb2312?B?dDhSYWh5M2hpRkROQS81SXFocW5CdG9adWVqVXNSalFoYUM2cFhTbi9zbldR?=
 =?gb2312?B?SUZsZThOUVhuUmZTV0VKaUlaaktjdEkwcVFWS0I2Z2k3UjVwVE9idVpIYWZh?=
 =?gb2312?B?SVR5TDhPaFliQkNmMmxJQSt6a2FhSlB6RVAzQ3EzTW5sOEZZZVRmZ05YdDAw?=
 =?gb2312?B?dUxnY1FtMVVGTjBmQ3ZFSGwrdm5pdDQ1bmpneWdzYkxQQUZsQ216OGFMZFlI?=
 =?gb2312?B?S05YYmJzNzh3Zzc4TWxBTkdFVXRKd1VOWXVaZ1hxbnk0cFRhNGFkSjBxNXNj?=
 =?gb2312?B?a3E1U2hyakF4MWhPQ1FOZVgrVU1PeStnWGpxMmg1NDJwNUxTb0FNRkxwVFps?=
 =?gb2312?B?d0pWUmhXemNPU0dINFF6U0hra3hDSGtkZFkyNlhtWmM1MDhuT3hsZmo1RTlG?=
 =?gb2312?B?Q041ZW5ic0tURlpGK1ZzZG9XQVNnNVlYa2xXVlY4S3JncWJLaC95U3c0TjJS?=
 =?gb2312?B?OWhPdm0weTZmMVZET3ZmTEhTeTcxWjFNdnROQjltdUtkV01xMml1SmhSVlpN?=
 =?gb2312?B?SGo1THhpY0dIOVRDUjJicmp5WW4wbjlDQ1diN1QreW12MEMxRFZObVpiQVhN?=
 =?gb2312?B?QUZLWHhiSkNCU3FoNnhZTG5wYS9oMkQzUG5KMEE1MWdHR29ZdWM0blFucmgr?=
 =?gb2312?B?U0lTMW9xY2ZkOWZTalBONEEwWW9UQzl5RWkxdGpIT3UzL2pITGx2cmlNM1J4?=
 =?gb2312?B?VE1EKzg3NVFhcGJBZGlod1BFb2J6ODBLYWpQckF2NU5MQnNVVENwZ0V5YzU2?=
 =?gb2312?B?WHh1RWUwWDFaUFdOVzZtY1Bka2FaTXlLYjlqTHZGQnBhV3dWSkpMOG1DejF4?=
 =?gb2312?B?YjRmRTRScy80bFkyMWJHckpZNDVIVGtCQUFZTFYzUVRSc2J0aWFZVzlvREJv?=
 =?gb2312?B?eGIzczFQek1BbjZsY2tyVjBQSGpmUHNFWUNET2lMVUNGYWpsQlZ1elNJL2Zz?=
 =?gb2312?B?R2hOWVRlWXQweG5YcXJvaENDZVp4elk2MUdrSzlhYm9WY2NzOXV2MDg5OWhX?=
 =?gb2312?B?d0pFRGc1ZkVGYWQ2bTAzOEJ3TE1TSC9Ea1QwMlFkaUl5SEpLMnhzN1RYVmdQ?=
 =?gb2312?B?VncrVjJrNDRJVDRZbTB1NWcrMFg2K2p5eE81bUJZMlA0eTY1d0MwVXdMNjJQ?=
 =?gb2312?B?MUVadVlYZ3RaMGhBS1k4SVY0eWQ3c25DVmRsM1dyUUZ1ajUwQSt2RnRTemdN?=
 =?gb2312?B?Q3Raa3pENHdGejdKTnhSOUxXR3BURVg1L09ndVhINDh3dmRyZk03K283cnJi?=
 =?gb2312?B?WGRVbWk4VTcyK0V6ZWxLVmdiNEVKdml6dEhkcTFSN3Y1TEhlYzVUbGVGNjc3?=
 =?gb2312?B?ZGtxVjFwL1hQcDN2OVJBOXFLMSs5b3JKcURxekMvZ3ZxTUViaDlXZEZtdm5a?=
 =?gb2312?B?d1VYd1YvRURNYjBqZFBGQVg4RjJZTUdGekJlWTRLQTZHc1RMWU5XSnN4V3RU?=
 =?gb2312?Q?Am1Bp2L1dG3p0/PeBMFA+S4FJPHBYrXI3Ty5U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?WjN0Wi9wRVBlSXN5RnozZUUyNHA0VEV2dDA4T3V4UnlrQlhSNnQ3QSsvSmNq?=
 =?gb2312?B?NllBeHpKWDRkVFFjVHE4clBFenhqUmovTy92Q2d3a0RyMHBBR2ZmOUU0U29x?=
 =?gb2312?B?dWJrVXRLZXVYOUlVL3gzeEtxakhIaHl6aUdVcnBtQW5VUFo1ZVlnUDI4Vy9Z?=
 =?gb2312?B?blVjM2VMQ2t2c2hZNk0waExvbHpVTG9IUkVqYWVrL2ZkUHpVZ0ZJMTd0Uzkv?=
 =?gb2312?B?NGtpVmtiUkhtd1BKSm1UckR2WFcvMnA3aUxtelhLd2FxUmJiTE9kWWs3bkt1?=
 =?gb2312?B?bkg5RisvbzJvaW9XVlpnamlHbjlwZW5leURpRU9laW1mZWl2aHN0b1JWRXpo?=
 =?gb2312?B?ZVd4eTVwTjgwNTQ4T2sxZ3dJVVRKcGhpSkZHcjZ6OFQ3NW1XcE94MUNLSzB4?=
 =?gb2312?B?aVpKdU82T2s4SmpFcldtb3R4b0xwVTYrbDg1SFlFeTdsU3JUMXlnV1NPemh2?=
 =?gb2312?B?U2s4UUZZTko3TStNUWZTaDVLaUJCYU1kYUVkQ0ZTUDlxMkRuWkZQTktuTFRT?=
 =?gb2312?B?WUxQcjZ5T3MrQTVaalIzZjRFRnlKQ0JjU05WWkNSSzhDSlh4ZHNkNGtHaTR3?=
 =?gb2312?B?SzZhNWc1TktuYTZMUkU4NzFYcE5CRW1mMTFVVGdQd2tKQ2RpVWUvb2xCTnhQ?=
 =?gb2312?B?ZER0b1cwNk1PYU1uMDFJOWVpeWhzZ2dmeEJkaXRad3p5bTNxcVBzbEJ2aUtR?=
 =?gb2312?B?QlpIbXNNVFRBMSt2Mi9Xc2FoR0FtcElwY2Z4bkdvS0hQY1lDYjQ1SXUyT2kz?=
 =?gb2312?B?WU1JbzRMdTE2ZXU1UmNxRS8vSGt2MVZrU2orSWtJNE5IcDhLblR4L2daamRs?=
 =?gb2312?B?T3phbzFEakZpbkhJZHlIWkphWDNjdVBwTjVDWHQrTlE3eXNtZEZkbmZobEp6?=
 =?gb2312?B?RTJCSytabCt2UWpYR3dYWjNock1LLzlnekQwOCtOMVZtcTRrNHNTS1BXanRQ?=
 =?gb2312?B?R0NiYWVDRkpXLzZZRzhJMWErWjFIVjFyMGpuajdwQWFySzdUbW1jNzVTZTQz?=
 =?gb2312?B?M0R6Vk5LZmRtR1hITXJiNHVrS28rRUdHWHFEa0JoV1VGV0JnVEM0MzRtWE9h?=
 =?gb2312?B?SjVFNW11KzJydzVSejdsVkhJMWdKOTRMS1ZwNzl1K1dnNUFDZGFEeVkwUmJV?=
 =?gb2312?B?S0Jnc0FrMWZaMGtpcnQrWUJWU3BwRHNvRmpNTVFGSUVnSFRjdVZubXIzS1ZT?=
 =?gb2312?B?ZVVBaWRyejVKb2g2UWZUaGNzbkpYWDBqMC9XRUxveXp1SjF6dnE5cXdNOWM0?=
 =?gb2312?B?RHRnL2RPTjNGQWRBcVI5clBwOUprQ1JJK0JvQnA2UmY3Y0IzSm90VGNVNHRp?=
 =?gb2312?B?NGdyNUdWeUJOYnRsMFU5NU1XRm1xTEppRjVZTWpNb2ltZ1JBOUx5Vjk3b21y?=
 =?gb2312?B?dW9QVWhIdjc5TnZzU3k4VlE2Tzk5K1JwakpSb08wRDhYWndsRy84MHVUd2dn?=
 =?gb2312?B?MDJ4YjRPbW9RZlVQVHZJYUUyVVIrYXU0N0pjdEpEMy9jSU9YK2ZxOEh4emE1?=
 =?gb2312?B?L0NUNlhBOHJpZGJacHhHL1h4YkNadFcwamhIWmlHdFh3Mko3cUlMcmNwUTB2?=
 =?gb2312?B?OTRZKzVvRngvaFlodmdGL2xUZG5OSll6bXdXbjlZcUo2cDZOVTYrK1NSQTZQ?=
 =?gb2312?B?S1NpQ1N4WENwLzZucXM3a0o0V1dpVkl5OHIxUHBUSm9lektaMkNRUDdJbXk4?=
 =?gb2312?B?MXRMRHpjUHBCdTRWdmgvb3F0M0ptZjNaYk91aytKVWQxek4vZzUvK2pydmNP?=
 =?gb2312?B?QVo0NUV3K1ZsYlErazExSFVRQytObUoxYWsvVDFiVytUVEFzK1dMSm5aZExU?=
 =?gb2312?B?UmJHajFoYkJsd1lsTi80UDhYai9LOHZSSG9QVktabmdXR3Roam9Db0YrUlli?=
 =?gb2312?B?UHRlNFhHNmxJUmIwMnZzTjYrZmhjbUF1VXhKcFBHUWlsZDdFQmVXdCthWnBw?=
 =?gb2312?B?SVM1S3N6VEdTZWRGQnZDOWg1ditLeW5WQ1psU3lra09wYlJOQ1RabWE0UDk2?=
 =?gb2312?B?WnpOeW5vMXppSmRUS2RIdHhPYzlSWVNDc21qNzMxYVV6R2JickJNdW4wWlV1?=
 =?gb2312?B?OVJrZlB4T0t6elZjK1JxWFk3dkRGemFlVEp1d0FQSTJkZ0I1SnRQWkNHR2k5?=
 =?gb2312?Q?0djC4WJ0Kij74T2Bs8/Iy6FqJ?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5271d9-2ce2-479c-e856-08dcff07e5dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 08:40:56.5704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wQXWkjehK9cT6Ob0MQE8seColzG/thVnR0kYa+VZDT+Au8IKBEIK3DPYPi1t9H56tr/e2g8EXpCMhW0TScNBlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9150

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgV2lsY3p5qL1z
a2kgPGt3QGxpbnV4LmNvbT4NCj4gU2VudDogMjAyNMTqMTHUwjfI1SAxNToyMA0KPiBUbzogSG9u
Z3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IEJqb3JuIEhlbGdhYXMgPGhl
bGdhYXNAa2VybmVsLm9yZz47IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGxvcmVuem8ucGllcmFs
aXNpQGFybS5jb207IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsgbWFuaUBrZXJuZWwub3Jn
Ow0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5n
dXRyb25peC5kZTsgaW14QGxpc3RzLmxpbnV4LmRldg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYy
XSBQQ0k6IGR3YzogRml4IHJlc3VtZSBmYWlsdXJlIGlmIG5vIEVQIGlzIGNvbm5lY3RlZCBhdA0K
PiBzb21lIHBsYXRmb3Jtcw0KPiANCj4gSGVsbG8sDQo+IA0KPiA+ID4gQnV0IEkgZG9uJ3QgdGhp
bmsgeW91IHJlc3BvbmRlZCB0byB0aGUgcmFjZSBxdWVzdGlvbi4gIFdoYXQgaGFwcGVucw0KPiBo
ZXJlPw0KPiA+ID4NCj4gPiA+ICAgaWYgKGR3X3BjaWVfZ2V0X2x0c3NtKHBjaSkgPiBEV19QQ0lF
X0xUU1NNX0RFVEVDVF9BQ1QpIHsNCj4gPiA+ICAgICAtLT4gbGluayBnb2VzIGRvd24gaGVyZSA8
LS0NCj4gPiA+ICAgICBwY2ktPnBwLm9wcy0+cG1lX3R1cm5fb2ZmKCZwY2ktPnBwKTsNCj4gPiA+
DQo+ID4gPiBZb3UgZGVjaWRlIHRoZSBMVFNTTSBpcyBhY3RpdmUgYW5kIHRoZSBsaW5rIGlzIHVw
LiAgVGhlbiB0aGUgbGluayBnb2VzDQo+IGRvd24uDQo+ID4gPiBUaGVuIHlvdSBzZW5kIFBNRV9U
dXJuX29mZi4gIE5vdyB3aGF0Pw0KPiA+ID4NCj4gPiA+IElmIGl0J3Mgc2FmZSB0byB0cnkgdG8g
c2VuZCBQTUVfVHVybl9vZmYgcmVnYXJkbGVzcyBvZiB3aGV0aGVyIHRoZQ0KPiA+ID4gbGluayBp
cyB1cCBvciBkb3duLCB0aGVyZSB3b3VsZCBiZSBubyBuZWVkIHRvIHRlc3QgdGhlIExUU1NNIHN0
YXRlLg0KPiA+IEkgbWFkZSBhIGxvY2FsIHRlc3RzIG9uIGkuTVg5NS9pLk1YOFFNL2kuTVg4TVAv
aS5NWDhNTS9pLk1YOE1RLA0KPiBhbmQNCj4gPiBjb25maXJtIHRoYXQgaXQncyBzYWZlIHRvIHNl
bmQgUE1FX1RVUk5fT0ZGIGFsdGhvdWdoIHRoZSBsaW5rIGlzIGRvd24uDQo+ID4gWW91J3JlIHJp
Z2h0LiBJdCdzIG5vIG5lZWQgdG8gdGVzdCBMVFNTTSBzdGF0ZSBoZXJlLg0KPiA+IFNvIGRvIHRo
ZSBMMiBwb2xsIGxpc3RlZCBhYm92ZSBhZnRlciBQTUVfVFVSTl9PRkYgaXMgc2VudC4NCj4gPg0K
PiA+IFNpbmNlIHRoZSA2LjEzIG1lcmdlIHdpbmRvdyBpcyBhbG1vc3QgY2xvc2VkLg0KPiA+IEhv
dyBhYm91dCBJIHByZXBhcmUgYW5vdGhlciBGaXggcGF0Y2ggdG8gZG8gdGhlIGZvbGxvd2luZyBp
dGVtcyBmb3INCj4gPiBpbmNvbWluZyA2LjE0Pw0KPiA+IC0gQmVmb3JlIHNlbmRpbmcgUE1FX1RV
Uk5fT0ZGLCBkb24ndCB0ZXN0IHRoZSBMVFNTTSBzdGF0Lg0KPiA+IC0gUmVtb3ZlIHRoZSBMMiBz
dGF0IHBvbGwsIGFmdGVyIHNlbmRpbmcgUE1FX1RVUk5fT0ZGLg0KPiANCj4gSWYgdGhlIGNoYW5n
ZXMgYXJlbid0IHRvbyBpbnZvbHZlZCwgdGhlbiBJIHdvdWxkIHJhdGhlciBmaXggaXQgb3IgZHJv
cCB0aGUgbm90DQo+IG5lZWRlZCBjb2RlIG5vdywgYmVmb3JlIHdlIHNlbnQgdGhlIFB1bGwgUmVx
dWVzdC4NCj4gDQo+IFNvLCBmZWVsIGZyZWUgdG8gc2VudCBhIHNtYWxsIHBhdGNoIGFnYWluc3Qg
dGhlIGN1cnJlbnQgYnJhbmNoLCBvciBzaW1wbHkgbGV0IG1lDQo+IGtub3cgaG93IGRvIHlvdSB3
aXNoIHRoZSBjdXJyZW50IGNvZGUgdG8gYmUgY2hhbmdlZCwgc28gSSBjYW4gZG8gaXQgYWdhaW5z
dA0KPiB0aGUgY3VycmVudCBicmFuY2guDQpUaGFua3MgZm9yIHlvdXIga2luZGx5IHJlbWluZGVy
Lg0KVGhpcyBjbGVhbiB1cCBzbWFsbCBwYXRjaCBpcyBvbiB0aGUgd2F5Lg0KDQpCZXN0IFJlZ2Fy
ZHMNClJpY2hhcmQgWmh1DQo+IA0KPiBUaGFuayB5b3UhDQo+IA0KPiAJS3J6eXN6dG9mDQo=

