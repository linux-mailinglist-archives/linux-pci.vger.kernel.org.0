Return-Path: <linux-pci+bounces-24821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB14A72A10
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 07:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2739F176D00
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 06:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2EB86331;
	Thu, 27 Mar 2025 06:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hMZ3hDyP"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2080.outbound.protection.outlook.com [40.107.249.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6564C25771;
	Thu, 27 Mar 2025 06:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743055352; cv=fail; b=gE2XYeg3wfqpqW5aiBNfdx6H5xR4NUq4aXqVI6unZsnTkhMK3ex3OTmlGxUqYIQ+1OiHbVk3kPEw45v+1Mg4h/4I5Atk5xacI/osSSOOnXWkW1x41qXPvakQVYpYiURPDWYBzAi1y96JDDZkhXpCVSzRzMqNxkKPQ27FdkI5ZrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743055352; c=relaxed/simple;
	bh=ZqoUpuccWeZAS7BZwEUHbBNJiYCywOtynGcRC8Rl3ls=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uYH0KkiMcVdIoFB2lhBWeZ1bx4riJWsl/waM/fum0QLMDbyqW2w3km8FHco5A9l9lHT9NXw1ULGEjIb4rP70BcOfsygJjvilFCoMnfoSOjW/8u+15teg3WEmCmbrJIkGs4ur9UXs6+gCm/Diom9LbcGFCo7mxFOPDlyTPMGDrU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hMZ3hDyP; arc=fail smtp.client-ip=40.107.249.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yi8+JS2gj7HL5K8mE93DIqErVCECyXG5biDmtnF2CCeNobXhLyFWUJtTuQQ2F+p67t/A0TvVaQpLDUd0PaV9iuaRCAMgN9keekK7DIuhhXWVpUhmFtRhNWB8zGdtSlM5mYNSOkxa91L/yV2nPz1DSklyBktcvM/Ng0TcWjbkPYiSguEPYYuI5T9ccWguWm5UIwQxCMW3g6mEipBDtR26/jxDb/rEcGcDh2Zmv6P8d30sVixysLxTeJZiyiRYEX1oxSM+2OT+yulZ9ZcK1IpwW9Vc0+fzzJFYCpk/X7JmXbbojq2FUlideFQk7lK7QPdVVKXDgrl52LewwFZYpPbtAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqoUpuccWeZAS7BZwEUHbBNJiYCywOtynGcRC8Rl3ls=;
 b=CSwWljP8fb7NPMsahDy4pazjH54uD5EfJQfnoZ1W9dhG8WF9MYEhWjP+iu/Df6oKutM7gY8p2JTXfKELutPczwkSKDfiK0I35zpQQmlyGvnV5Ey+FAezomHU7QFb0jvJEys0EQg2Y93p+SH1VKuFcDHDfnOncxGBPUZNGqS0LQX7FTI/xHVurQVJp4sLD5w3eQfFO7ATcRTsuzHJKKbU2FNbQP0sWiWLc92Lnwvo44B/utirzW+IfC4Xh3eumsmKh6o0a4FDzL0/xPVDN7+FPsfNxzm5UnKWSESPnFXUc7BWahJIoCrJe8G/hTJ9MRbfZPrgyaDTlZzcxpoB+FP5Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqoUpuccWeZAS7BZwEUHbBNJiYCywOtynGcRC8Rl3ls=;
 b=hMZ3hDyPgt/OQHkfjHV3oZxEwyPN+CNYtZ7TGqaxLm4abygz/Rgj2xhviawlNTyNNTwxzqQCPgZBXBxhhZELce1LvGUlRBQvN8TanYUtengMzznaYkHIkaLqMYxIHhNHXK5F5dYPSZs4JSIKRcQcGeOKO0KK1JDBHJcckai9VgxSwpNa681coTOjGaCHqoCCRMRf0MgMvzR+jdgifzQd3NbEvm8T3FCmB7cx7NVJYgzD2T9WGGu3jCH3MVUuthOkleLdtwvEC7In23QvMauPM2aasc7XSPbzqbD7qUxC3Kdcx6iIVf9l4TOsTj4ucCBk79HNjJJW+fmDbaqmFLL8cA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 06:02:27 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 06:02:27 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: "devnull+manivannan.sadhasivam.linaro.org@kernel.org"
	<devnull+manivannan.sadhasivam.linaro.org@kernel.org>,
	"bartosz.golaszewski@linaro.org" <bartosz.golaszewski@linaro.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "brgl@bgdev.pl" <brgl@bgdev.pl>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Frank
 Li <frank.li@nxp.com>
Subject: RE: [PATCH v3 3/5] PCI/pwrctrl: Skip scanning for the device further
 if pwrctrl device is created
Thread-Topic: [PATCH v3 3/5] PCI/pwrctrl: Skip scanning for the device further
 if pwrctrl device is created
Thread-Index:
 AQHbmg0cayhvVFUY+kOmWlFBWATdm7N9A1KAgAAREWCAAWskAIAAdlkggAL/xwCABItecA==
Date: Thu, 27 Mar 2025 06:02:27 +0000
Message-ID:
 <PAXPR04MB851049B520288642141570F188A12@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250116-pci-pwrctrl-slot-v3-3-827473c8fbf4@linaro.org>
 <20250321025940.2103854-1-wei.fang@nxp.com>
 <2BFDC577-949F-49EE-A639-A21010FEEE0E@linaro.org>
 <PAXPR04MB85102429AE77159F8CAF914088DB2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250322032344.uypqhi3kg6nqixay@thinkpad>
 <PAXPR04MB851005833B17C2B78CFB421388DA2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <yzhvxyjb75epv4mkkocjqsqkus44c55zwnxta6ac3aauvswv3x@knyhszmrgfc3>
In-Reply-To: <yzhvxyjb75epv4mkkocjqsqkus44c55zwnxta6ac3aauvswv3x@knyhszmrgfc3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU2PR04MB8536:EE_
x-ms-office365-filtering-correlation-id: 0ed9e809-713b-4acc-3b53-08dd6cf4f3c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OHVIVU5TdTVqUUV0SERabjE1V1I2V0RPUDBJT1ZhVm50MU0vZVMyQWladG00?=
 =?utf-8?B?T2gveTVMVm9nVytRNE1mRkpTUTAzb01NVVFZZUNLNTg0MnQ5alpJMXppaFh4?=
 =?utf-8?B?SGNHYnJOZ2hDVXZReXZLRmFFL081Rm1nakpoMXpSaVZDRXpGWW5hUzF0Uk9I?=
 =?utf-8?B?TUMyZWdLWlY1ZFR0ZGFCVnhGMmJiQ1hXUXVZUnM1ckVBb0wrYWFvU0ZOblhq?=
 =?utf-8?B?SFNaTFA4QXlIUExFeTRsMkNZS3BaS3NYOE96ak9xZUZEeWI2ZVhZVllKSlpB?=
 =?utf-8?B?amJaS1Z1WWFtK1kvZEx5dmJyeDQyVDNiUE55NEFWOFIvZEQ0Tkp2L3BaT1R3?=
 =?utf-8?B?NGlNVHJ5Wk9QM0wycmlDeU50Mm9PMnhRVnNLR1k0Y2R0cXlpQTZLS0F3Q2F3?=
 =?utf-8?B?WXRRRmpVQjJPb2xxbDNKMjg3a05LdnpKemFrRkI5c2JCazNMNStFbzZMQ2pp?=
 =?utf-8?B?NnE0OG9oaEV3N3RPQS9mMzRjZklEanZaaUpPZWpJclNEMHB6dGkwWHBodXJN?=
 =?utf-8?B?MTdpbnhsZ3BPNU9IVjRtSVdNZzg5OTdUbDBqMkIrZ0t1alZ0OWhDLzlIQkpC?=
 =?utf-8?B?cjFTaDFrQW16TDJCRnJjTmU1VWMxbjQxbkpJUmdpTDdndXBXdEVHelNydllF?=
 =?utf-8?B?MEw4WFlYWGw5ZytXWGhabWRaQTc5UytMS3ExbEo1L1ZZYWtyVVMvVzZjYTY1?=
 =?utf-8?B?eG8rdTFvSkFwTjl3TU8vdWh5b3NOeXlKcU8relNuS29CRlFZcjNSb09XcWRw?=
 =?utf-8?B?eWpFUFA0NnlBWWQ0b2xjdE5COTJqN0JveTVjdTVmeldpYnI3RDF0VzJJYk03?=
 =?utf-8?B?M0pPVnUyZ2JnczhnS1NLYWxNb0VFL256eWRPVDMzNEVoS0h3QjN4ODNuQUpZ?=
 =?utf-8?B?SnhndTdVKzk2OGwrdWhHbHRncVJCK25wSmVRN2t6RTM2TmQzTzhUa3l6cXdw?=
 =?utf-8?B?OUxnam55aUN6R3JhbzFFbVdybUpOelBFbndEUjhiZkhsZXBBZmZyOUl0VEM3?=
 =?utf-8?B?U0NRanVuN0lYWWw2OVVWTUpFT3Q2b1QzT0VYV05BamN5S0k0aHZ6STR0MzdG?=
 =?utf-8?B?NnRJMEM0c1ZlbmQyUTg0Ujc3RGVaYjViUnN2cFBpV01RZFBIMFpHQ2hPM0JL?=
 =?utf-8?B?a0hidENzaC9lUGVLREdsR3JhUzBHRUlhZTRXOG81YzBXb1NhaEJxRUs3bHI5?=
 =?utf-8?B?REMzTHBlUklQSHVDZlJ5V3A3a1RZbExTbGE0V3c3YVJYQ05BQmtjVk1CNEVX?=
 =?utf-8?B?anZrNkp6eWl5TlZTV3d3bEtSbndQeC93Wi9tYXJWczJyWU0xWDE0K2I1NDhB?=
 =?utf-8?B?c3Z6YmV3enhxZlFobnNuQ2ZCOHpFZ3BzeTJ3VVArMjIwaU4zZmhCMFpYMnRF?=
 =?utf-8?B?cGJFc0xteFV0NU9QejFaaFN4TlVvOTM1ZVB2ZUMzVkxJTG45Um9lUjFvaHJo?=
 =?utf-8?B?NW82alVkUFEzNmxOanp0cEJobEFOdk9VNFdCSVJxcHE3SGRJdXZkaE5tZjVn?=
 =?utf-8?B?Q1NEdWJwMVRHdlZETWNrRG5uNHZOTTVSVmtZejZKRW1uMGd2bVp5TGdaekFG?=
 =?utf-8?B?bXBsKzlES2s5dm52TlZUQjYxVXNmT0xFeVA3Q0tVdkorcVAzZkJDd0NMQzYy?=
 =?utf-8?B?WVlZNm9sdzRhTXBab05kT01LUXRCVnp6eFFZUnQzOHlFNGd3RFMxU21UTCsy?=
 =?utf-8?B?WVFvM21GRDV1NjBVT3NSdWVFRHZoSGwxZENiSVhVMFBLRmFTalhXdUFIOWlv?=
 =?utf-8?B?OFZGbFlhbkNYZmd6STN5Tk1Xd01CelVUcVl2YVlBR1JicmRwaHhYSjZva0ZV?=
 =?utf-8?B?RVZTZTlGelFJblJ0S1c5OE9pRHMzVDZuOWd1emh5V01POVhQT3F2dlZUK1FU?=
 =?utf-8?B?L0RWeEx4SGJxR1loNmRGejZ6RnRSTEVXdk5IRHJ0WklabStjVS9Ec2RjVHhr?=
 =?utf-8?Q?J//GCq9Y4b+KZ32pdkB9wAZ1XkHSuhlh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dG1pOE41RktYUjN0Zng3VjNnSkxkMDJna1AyMUVoM0p6NFJDTGVwQ2o0elFy?=
 =?utf-8?B?cHJhMUh3NCt0b2w1dHFOZkhQeTJZeHBSNnJOTlA2RlpFandWU2tTdjBpUlRm?=
 =?utf-8?B?dU5laDNlR2VvanZzenpiS0dib2pIT0Jhb3VENDlzTFlvanZ6UHRrUTJlZ2Ri?=
 =?utf-8?B?UjVBdk1wVFNYU01vSnA3UjVHZU9rem5oK0I4MEg0YmNpMFMzUU1FeURkaVMw?=
 =?utf-8?B?Ty9kNnV6ZE1pQ1p5ZVJXR3JLMWJBWElwTzAwdDFYcFg1Y1IrNlduMmdxdHpO?=
 =?utf-8?B?aUtOMkE3K0FLODVEb1NQMlJiN0dSbmZ3U1QvbE1jQ2x5MGR2VHZqUjdQTk9C?=
 =?utf-8?B?QXZzS1NreG55R2hJNkp5ekkyS25FdjRxWUd6MkZuU3BIR21RYzg2MkNzNjBm?=
 =?utf-8?B?dWRSOHVVU3hUaFVmckYxRFBUbXBZR0dPRlJZYlVJSGFlR1IxR0NmVGNOSUsv?=
 =?utf-8?B?SUE4elFyRkUxWGNHK29xTUp6ZnB5YkJEVVdZdDZaQXREbTZkRGFPQlArQjhE?=
 =?utf-8?B?aGFzeDVLazB0VGFzNXREY0hDYjk2eDg0WE10a2hFM1piS05wOElJenFLMGVv?=
 =?utf-8?B?UWRsb3dWYjY5dHg1YlFYZStacjA3amFsdTMyTU93VWsyTGlQUy9ObUplNXFB?=
 =?utf-8?B?UC9BTjZjbm9KWTJ6ejJVT0ROWGdOZmJSSko4aGV3aXZBZVRmTGdCbkt0dXA4?=
 =?utf-8?B?QTZrSmx2bnFmRHRWd2ZwdFhaWExuVlkxUUQ3Z3dLUm51MFIzR0dHck44dUxW?=
 =?utf-8?B?Mng3Rmh5ZnpVR2NGc2lVMU94WUU1bnRYNVl5MTlMcnNkYTk0SEtaekZ1aGU3?=
 =?utf-8?B?RnRHMXRPbFZqSkwyZFI1ekk2TWFMUjZoWHlIQjFtM0ZYRnZxSlcvVmpsNG10?=
 =?utf-8?B?TFZqSHlpejNnQUc0VENQaml1QlA4ZDJnYUpya0FXeVBZOGQrYXRvMFZ4ZTRL?=
 =?utf-8?B?a3c0Vk5Zc2V0aVJkcjZEdHVZUFp6QmYvZUY2cVNXMUt4WWh2c1haNExOTHlS?=
 =?utf-8?B?WGp6dmx5d1VTVkxSV2ZyZElab1VqUDdkc1dENWgvZVJ3ZnNTVlFFTUFWWE1z?=
 =?utf-8?B?RUhnNHdocW1DMXIxRWlRQXkxVzBaWnZtaWE1SW5oNU5pSFI4SGhCbmJLSWl1?=
 =?utf-8?B?MkI1SmZuSXF6bHNMWlRWWlRzeWllaW9JcGxqQ2JPSzlYamZqMktLekFaYmVy?=
 =?utf-8?B?NDlScCsxdEFqbUVXUGNzTzZZc0xlL01uZ2tMaE96Q0k0aGJOanhKY2hUVGNk?=
 =?utf-8?B?Nks5dkszZmViM2tmMWVtZXUrdjZQc2JZZ0EwUkVlMkk3NUJ2RUhCcWpyTis1?=
 =?utf-8?B?Q21LYUlxS2JyemdkSGQ4OEZna1BhWFhrbndOQTBZcms0U2lZY3V5allaL0Fz?=
 =?utf-8?B?Rkl4b0NmZFhiQUYyTlhkN2ZzZm43T3dPVjJINE5vRFhIeTZySVBHaW5SMkVI?=
 =?utf-8?B?MHhKcEkwOVUydlBYMXFwUUthbVhwdjU4MG1VdElkbTE2c1hmTlAwSEJURU41?=
 =?utf-8?B?QzVXaUNvTzBnS2xtZzdWY1owTDlHUWJiakJUdXduNDBOT0dqSGZYdGFxT0pU?=
 =?utf-8?B?M0ZrQytuTnJiWWVOTTRKZDlHN0VXOTlxZmljT1JyN0hXK2VhNjBGdnhQOGIx?=
 =?utf-8?B?S280VUs5WVdRMG9ONk5Mbk15NGEwV3lyeXdWTHc3K0RFK1hsc1N4U2ZnbTNC?=
 =?utf-8?B?aWZvMk1xUnR6TjhFaFFPNUdXRTZVeVlMUVFEeHJHZWN6M2VTZ0ZLcXdWSEN4?=
 =?utf-8?B?TkxFeGxhazNFd2o4V0VRTG5OSXhWam1EU0FmcDRMVEQ4MnREbVdWUFUwMGFn?=
 =?utf-8?B?ck9NVzBtMHhKNjA4ZlVibzdwS2U0TXpKYWFzM3B4VnEzM2NoQnF0NWxWVG14?=
 =?utf-8?B?QlhSOWZzQlg2ZmRVT3BZUjN1SnVOTWlEWTN1RnlwUnVrZlJFazkzWUJsdjZX?=
 =?utf-8?B?YlYwYjl6NFlzSzFSZnNaTHE1aFp1QXAyUlU0MlRsWkUxVFMyeTFzcGxMNHZj?=
 =?utf-8?B?YURZbStudng4elo2a0hYVHJkVkdHQktaMElzS3NEVUlQNEZRd3ZhaDVCQ1dh?=
 =?utf-8?B?VW9RUlQyZkZuSjVZbDczNW5PNUY4cG1PSml4bWNZd3R1TVk2UVlxSkFqUlRn?=
 =?utf-8?Q?+BKU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed9e809-713b-4acc-3b53-08dd6cf4f3c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 06:02:27.3633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jr1YSoUd7AETfNJwKY0jp1VEzpqCl7Jntoj4+5h664ifg7SzBpA0JWTBir5u+Q66Fk0/5Za7YUyQdE+br4Blsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8536

PiA+ID4gPiA+ID5UaGUgY3VycmVudCBwYXRjaCBsb2dpYyBpcyB0aGF0IGlmIHRoZSBwY2llIGRl
dmljZSBub2RlIGlzIGZvdW5kIHRvDQo+ID4gPiA+ID4gPmhhdmUgdGhlICJ4eHgtc3VwcGx5IiBw
cm9wZXJ0eSwgdGhlIHNjYW4gd2lsbCBiZSBza2lwcGVkLCBhbmQgdGhlbg0KPiA+ID4gPiA+ID50
aGUgcHdyY3RybCBkcml2ZXIgd2lsbCByZXNjYW4gYW5kIGVuYWJsZSB0aGUgcmVndWxhdG9ycy4g
SG93ZXZlciwNCj4gPiA+ID4gPiA+YWZ0ZXIgbWVyZ2luZyB0aGlzIHBhdGNoLCB0aGVyZSBpcyBh
IHByb2JsZW0gb24gb3VyIHBsYXRmb3JtLiBUaGUNCj4gPiA+ID4gPiA+LnByb2JlKCkgb2Ygb3Vy
IGRldmljZSBkcml2ZXIgd2lsbCBub3QgYmUgY2FsbGVkLiBUaGUgcmVhc29uIGlzDQo+ID4gPiA+
ID4gPnRoYXQgQ09ORklHX1BDSV9QV1JDVExfU0xPVCBpcyBub3QgZW5hYmxlZCBhdCBhbGwgaW4g
b3VyDQo+ID4gPiA+ID4gPmNvbmZpZ3VyYXRpb24gZmlsZSwgYW5kIHRoZSBjb21wYXRpYmxlIHN0
cmluZyBvZiB0aGUgZGV2aWNlIGlzIGFsc28gbm90DQo+ID4gPiBhZGRlZCB0byB0aGUgcHdyY3Ry
bCBkcml2ZXIuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBIbW0uIFNvIEkgZ3Vlc3MgdGhlIGNvbnRy
b2xsZXIgZHJpdmVyIGl0c2VsZiBpcyBlbmFibGluZyB0aGUNCj4gPiA+ID4gPiBzdXBwbGllcyBJ
IGJlbGlldmUgKHdoaWNoIEkgZmFpbGVkIHRvIHNwb3QpLiBNYXkgSSBrbm93IHdoYXQgcGxhdGZv
cm1zIGFyZQ0KPiA+ID4gYWZmZWN0ZWQ/DQo+ID4gPiA+DQo+ID4gPiA+IFllcywgdGhlIGFmZmVj
dGVkIGRldmljZSBpcyBhbiBFdGhlcm5ldCBjb250cm9sbGVyIG9uIG91ciBpLk1YOTUNCj4gPiA+
ID4gcGxhdGZvcm0sIGl0IGhhcyBhICJwaHktc3VwcGx5IiBwcm9wZXJ0eSB0byBjb250cm9sIHRo
ZSBwb3dlciBvZiB0aGUNCj4gPiA+ID4gZXh0ZXJuYWwgRXRoZXJuZXQgUEhZIGNoaXAgaW4gdGhl
IGRldmljZSBkcml2ZXIuDQo+ID4gPg0KPiA+ID4gQWgsIEkgd2FzIG5vdCBhd2FyZSBvZiBhbnkg
ZGV2aWNlcyB1c2luZyAncGh5LXN1cHBseScgaW4gdGhlIHBjaWUgZGV2aWNlIG5vZGUuDQo+ID4N
Cj4gPiBJdCBpcyBub3QgYSBzdGFuZGFyZCBwcm9wZXJ0eSBkZWZpbmVkIGluIGV0aGVybmV0LWNv
bnRyb2xsZXIueWFtbC4gTWF5YmUNCj4gPiBmb3Igb3RoZXIgdmVuZG9ycywgaXTigJlzIGNhbGxl
ZCAidmRkLXN1cHBseSIgb3Igc29tZXRoaW5nIGVsc2UuDQo+ID4NCj4gDQo+IEFoLCB0aGVuIHdo
eSBpcyBpdCB1c2VkIGF0IGFsbCBpbiB0aGUgZmlyc3QgcGxhY2UgKGlmIG5vdCBkZWZpbmVkIGlu
IHRoZQ0KPiBiaW5kaW5nKT8gVGhpcyBtYWtlcyBtZSB3b25kZXIgaWYgSSByZWFsbHkgaGF2ZSB0
byBmaXggYW55dGhpbmcgc2luY2UgZXZlcnl0aGluZw0KPiB3ZSBhcmUgdGFsa2luZyBhYm91dCBh
cmUgb3V0IG9mIHRyZWUuDQoNCiJwaHktc3VwcGx5IiBpcyBhIHZlbmRvciBkZWZpbmVkIHByb3Bl
cnR5LCB3ZSBoYXZlIGFkZGVkIGl0IHRvIGZzbCxmZWMueWFtbCwNCmJ1dCBmZWMgaXMgbm90IGEg
UENJZSBkZXZpY2UuIEFuZCB0aGlzIHByb3BlcnR5IGlzIGFsc28gYWRkZWQgdG8gb3RoZXIgRXRo
ZXJuZXQNCmRldmljZXMgc3VjaCBhcyBhbGx3aW5uZXIsc3VuNGktYTEwLW1kaW8ueWFtbCBhbmQg
cm9ja2NoaXAsZW1hYy55YW1sLCBldGMuDQpCdXQgdGhleSBhcmUgYWxsIG5vdCBhIFBDSWUgZGV2
aWNlLiBTbyB0aGVyZSBpcyBubyBuZWVkIHRvIGZpeCBpdCBpbiB1cHN0cmVhbS4NCg0KPiANCj4g
PiA+DQo+ID4gPiA+IFRoaXMgcGFydCBoYXMgbm90IGJlZW4NCj4gPiA+ID4gcHVzaGVkIHVwc3Ry
ZWFtIHlldC4gU28gZm9yIHVwc3RyZWFtIHRyZWUsIHRoZXJlIGlzIG5vIG5lZWQgdG8gZml4IG91
cg0KPiA+ID4gPiBwbGF0Zm9ybSwgYnV0IEkgYW0gbm90IHN1cmUgd2hldGhlciBvdGhlciBwbGF0
Zm9ybXMgYXJlIGFmZmVjdGVkIGJ5DQo+ID4gPiA+IHRoaXMgb24gdGhlIHVwc3RyZWFtIHRyZWUu
DQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gT2ssIHRoaXMgbWFrZXMgc2Vuc2UgYW5kIHByb3ZlcyB0
aGF0IG15IGdyZXAgc2tpbGxzIGFyZSBub3QgYmFkIDopIEkgZG9uJ3QNCj4gdGhpbmsNCj4gPiA+
IHRoZXJlIGlzIGFueSBwbGF0Zm9ybSBpbiB1cHN0cmVhbSB0aGF0IGhhcyB0aGUgJ3BoeS1zdXBw
bHknIGluIHRoZSBwY2llIG5vZGUuDQo+ID4gPiBCdXQgSSBkbyBub3Qgd2FudCB0byBpZ25vcmUg
dGhpcyBwcm9wZXJ0eSBzaW5jZSBpdCBpcyBwcmV0dHkgdmFsaWQgZm9yIGV4aXN0aW5nDQo+ID4g
PiBldGhlcm5ldCBkcml2ZXJzIHRvIGNvbnRyb2wgdGhlIGV0aGVybmV0IGRldmljZSBhdHRhY2hl
ZCB2aWEgUENJZS4NCj4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEkgdGhpbmsgb3RoZXIN
Cj4gPiA+ID4gPiA+cGxhdGZvcm1zIHNob3VsZCBhbHNvIGhhdmUgc2ltaWxhciBwcm9ibGVtcywg
d2hpY2ggdW5kb3VidGVkbHkgbWFrZQ0KPiA+ID4gPiA+ID50aGVzZSBwbGF0Zm9ybXMgYmUgdW5z
dGFibGUuIFRoaXMgcGF0Y2ggaGFzIGJlZW4gYXBwbGllZCwgYW5kIEkgYW0NCj4gPiA+ID4gPiA+
bm90IGZhbWlsaWFyIHdpdGggdGhpcy4gQ2FuIHlvdSBmaXggdGhpcyBwcm9ibGVtPyBJIG1lYW4g
dGhhdCB0aG9zZQ0KPiA+ID4gPiA+ID5wbGF0Zm9ybXMgdGhhdCBkbyBub3QgdXNlIHB3cmN0cmwg
Y2FuIGF2b2lkIHNraXBwaW5nIHRoZSBzY2FuLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gU3VyZS4g
SXQgbWFrZXMgc2Vuc2UgdG8gYWRkIGEgY2hlY2sgdG8gc2VlIGlmIHRoZSBwd3JjdHJsIGRyaXZl
ciBpcyBlbmFibGVkDQo+IG9yDQo+ID4gPiBub3QuDQo+ID4gPiA+ID4gSWYgaXQgaXMgbm90IGVu
YWJsZWQsIHRoZW4gdGhlIHB3cmN0cmwgZGV2aWNlIGNyZWF0aW9uIGNvdWxkIGJlDQo+ID4gPiA+
ID4gc2tpcHBlZC4gSSdsbCBzZW5kIGEgcGF0Y2ggb25jZSBJJ20gaW5mcm9udCBvZiBteSBjb21w
dXRlci4NCj4gPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBJIGRvbid0IGtub3cgd2hldGhlciBj
aGVjayB0aGUgcHdyY3RybCBkcml2ZXIgaXMgZW5hYmxlZCBpcyBhIGdvb2QNCj4gPiA+ID4gaWRl
YSwgZm9yIHNvbWUgZGV2aWNlcyBpdCBpcyBtb3JlIGNvbnZlbmllbnQgdG8gbWFuYWdlIHRoZXNl
DQo+ID4gPiA+IHJlZ3VsYXRvcnMgaW4gdGhlaXIgZHJpdmVycywgZm9yIHNvbWUgZGV2aWNlcywg
d2UgbWF5IHdhbnQgcHdyY3RybA0KPiA+ID4gPiBkcml2ZXIgdG8gbWFuYWdlIHRoZSByZWd1bGF0
b3JzLiBJZiBib3RoIHR5cGVzIG9mIGRldmljZXMgYXBwZWFyIG9uDQo+ID4gPiA+IHRoZSBzYW1l
IHBsYXRmb3JtLCBpdCBpcyBub3QgZW5vdWdoIHRvIGp1c3QgY2hlY2sgd2hldGhlciB0aGUgcGlu
Y3RybCBkcml2ZXINCj4gaXMNCj4gPiA+IGVuYWJsZWQuDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4g
SG1tLiBOb3cgdGhhdCBJIGdvdCB0aGUgcHJvYmxlbSBjbGVhcmx5LCBJIHRoaW5rIG1vcmUgZWxl
Z2FudCBmaXggd291bGQgYmUNCj4gdG8NCj4gPiA+IGlnbm9yZSB0aGUgZGV2aWNlIG5vZGVzIHRo
YXQgaGFzIHRoZSAncGh5LXN1cHBseScgcHJvcGVydHkuIEkgZG8gbm90IGVudmlzaW9uDQo+ID4g
PiBkZXZpY2Ugbm9kZXMgdG8gbWl4ICdwaHktc3VwcGx5JyBhbmQgb3RoZXIgJy1zdXBwbHknIHBy
b3BlcnRpZXMgdGhvdWdoLg0KPiA+ID4NCj4gPg0KPiA+IEkgdGhpbmsgdGhlIGJlbG93IHNvbHV0
aW9uIGlzIG5vdCBnZW5lcmljLCAicGh5LXN1cHBseSIgaXMganVzdCBhbiBleGFtcGxlLA0KPiA+
IHRoZSBmb2xsb3dpbmcgbW9kaWZpY2F0aW9uIGlzIG9ubHkgZm9yIHRoaXMgY2FzZS4gSW4gZmFj
dCwgdGhlcmUgaXMgYWxzbyBhDQo+ID4gInNlcmRlcy1zdXBwbHkiIG9uIG91ciBwbGF0Zm9ybSwg
b2YgY291cnNlLCB0aGlzIGlzIG5vdCBpbmNsdWRlZCBpbiB0aGUNCj4gPiB1cHN0cmVhbSwgYmVj
YXVzZSB3ZSBoYXZlbid0IGhhZCB0aW1lIHRvIGNvbXBsZXRlIHRoZXNlLiBTbyBmb3IgdGhlDQo+
ID4gInNlcmRlcy1zdXBwbHkiIGNhc2UsIHRoZSBiZWxvdyBzb2x1dGlvbiB3b24ndCB0YWtlIGVm
ZmVjdC4NCj4gPg0KPiANCj4gRG9lcyB5b3VyIHBsYXRmb3JtIGhhdmUgYSBzZXJkZXMgY29ubmVj
dGVkIHRvIHRoZSBQQ0llIHBvcnQ/IEkgZG91YnQgc28uIEFnYWluLA0KPiB0aGVzZSBhcmUgYWxs
IG5vbi1zdGFuZGFyZCBwcm9wZXJ0aWVzLCBub3QgYXZhaWxhYmxlIGluIHVwc3RyZWFtLiBTbyBJ
J20gbm90DQo+IGdvaW5nIHRvIHdvcnJ5IGFib3V0IHRoZW0uDQoNCk5vLCB0aGUgc2VyZGVzIGlz
IGluc2lkZSB0aGUgRXRoZXJuZXQgTUFDLiBJIHdhcyB3b25kZXJpbmcgaG93IHRvIGJ5cGFzcw0K
cHdyY3RybCBpbiB0aGUgZnV0dXJlIGlmIHdlIGFkZCBzdWNoIGEgInh4eC1zdXBwbHkiIHRvIGEg
UENJZSBkZXZpY2Ugbm9kZSwNCnNvIHRoYXQgb3VyIGRyaXZlcnMgY2FuIGJlIHNtb290aGx5IGFj
Y2VwdGVkIGJ5IHVwc3RyZWFtLg0KDQoNCj4gDQo+ID4gSW4gYWRkaXRpb24sIGZvciBzb21lIGV4
aXN0aW5nIGRldmljZXMsIHRoZSBwd3JjdHJsIGRyaXZlciBjYW4gaW5kZWVkDQo+ID4gbWVldCB0
aGVpciBuZWVkcyBmb3IgcmVndWxhdG9yIG1hbmFnZW1lbnQsIGJ1dCB0aGVpciBjb21wYXRpYmxl
DQo+ID4gc3RyaW5ncyBoYXZlIG5vdCBiZWVuIGFkZGVkIHRvIHB3cmN0cmwsIHNvIHRoZXkgYXJl
IGN1cnJlbnRseQ0KPiA+IHVuYXZhaWxhYmxlLiBUaGUgYmVsb3cgc29sdXRpb24gYWxzbyBub3Qg
cmVzb2x2ZXMgdGhpcyBpc3N1ZS4gRm9yIHRoZXNlDQo+ID4gZGV2aWNlcywgSSB0aGluayBpdCdz
IG5lY2Vzc2FyeSB0byBrZWVwIHRoZSBwcmV2aW91cyBhcHByb2FjaCAocmVndWxhdG9ycw0KPiA+
IGFyZSBtYW5hZ2VkIGJ5IHRoZSBkZXZpY2UgZHJpdmVyKSB1bnRpbCB0aGUgbWFpbnRhaW5lcnMg
b2YgdGhlc2UgZGV2aWNlcw0KPiA+IHN3aXRjaCB0byB1c2luZyBwd3JjdHJsLg0KPiA+DQo+ID4g
QSBnZW5lcmljIHNvbHV0aW9uIEkgdGhpbmsgb2YgaXMgdG8gYWRkIGEgc3RhdGljIGNvbXBhdGli
bGUgc3RyaW5nIHRhYmxlDQo+ID4gdG8gY29yZS5jIChwd3JjdHJsKSB0byBpbmRpY2F0ZSB3aGlj
aCBkZXZpY2VzIGN1cnJlbnRseSB1c2UgcHdyY3RybC4gSWYNCj4gPiB0aGUgY29tcGF0aWJsZSBz
dHJpbmcgb2YgdGhlIGN1cnJlbnQgZGV2aWNlIG1hdGNoZXMgdGhlIHRhYmxlLCB0aGVuDQo+ID4g
c2tpcCB0aGUgc2Nhbi4gT3IgYWRkIGFuIHByb3BlcnR5IHRvIHRoZSBub2RlIHRvIGluZGljYXRl
IHRoZSB1c2Ugb2YNCj4gPiBwd3JjdGwsIGJ1dCB0aGlzIG1heSBiZSBvcHBvc2VkIGJ5IERUIG1h
aW50YWluZXJzIGJlY2F1c2UgdGhpcw0KPiA+IHByb3BlcnR5IGlzIG5vdCB1c2VkIHRvIGRlc2Ny
aWJlIGhhcmR3YXJlLg0KPiA+DQo+IA0KPiBQd3JjdHJsIGF0IHRoZSBtb21lbnQgc3VwcG9ydHMg
b25seSB0aGUgUENJZSBidXMuIEFuZCBhbHNvLCBjaGVja2luZyBmb3IgdGhlDQo+IGNvbXBhdGli
bGUgcHJvcGVydHkgaW4gdGhlIHB3dGN0cmwgY29yZSBkb2Vzbid0IHdvcmsvc2NhbGUgYXMgdGhl
IGtlcm5lbCBoYXMgbm8NCj4gaWRlYSB3aGV0aGVyIHRoZSBwd3RjdHJsIGRyaXZlciBpcyBnb2lu
ZyB0byBiZSBhdmFpbGFibGUgb3Igbm90LiBUaGF0J3MgdGhlDQo+IHJlYXNvbiB3aHkgd2UgZW5k
ZWQgdXAgY2hlY2tpbmcgZm9yIHRoZSAtc3VwcGx5IHByb3BlcnR5Lg0KPiANCj4gQnV0IEkgd2Fu
dCB0byBjbGFyaWZ5IHRoYXQgdGhlIGludGVudGlvbiBvZiB0aGUgcHdyY3RybCBmcmFtZXdvcmsg
aXMgdG8gY29udHJvbA0KPiB0aGUgcG93ZXIgdG8gdGhlIGRldmljZSBpdHNlbGYuIFRob3NlIHN1
cHBsaWVzIGNhbm5vdCBiZSBjb250cm9sbGVkIGJ5IHRoZQ0KPiBkZXZpY2UgZHJpdmVyIHRoZW1z
ZWx2ZXMgYXMgdGhlIGRldmljZSBmaXJzdCBuZWVkIHRvIGJlIGF2YWlsYWJsZSBvbiB0aGUgYnVz
IHRvDQo+IHRoZSBkcml2ZXIgdG8gZ2V0IGxvYWRlZCAoaWYgdGhlIGRldmljZSB3YXMgcG93ZXJl
ZCBvbiBieSB0aGUgYm9vdGxvYWRlciBpdCBpcw0KPiBub3QgdHJ1ZSwgYnV0IGtlcm5lbCBzaG91
bGQgbm90IGRlcGVuZCBvbiB0aGUgYm9vdGxvYWRlciBoZXJlKS4gVHJhZGl0aW9uYWxseSwNCj4g
c3VjaCBkZXZpY2UgcG93ZXIgc3VwcGxpZXMgd2VyZSBjb250cm9sbGVkIGJ5IHRoZSBQQ0llIGNv
bnRyb2xsZXIgZHJpdmVycyBhcyBvZg0KPiBub3cuIFRoaXMgY2F1c2VkIGlzc3VlcyBvbiBtdWx0
aXBsZSBwbGF0Zm9ybXMvZGV2aWNlcyBhbmQgdGhhdCByZXN1bHRlZCBpbiB0aGUNCj4gcHdyY3Ry
bCBmcmFtZXdvcmsuDQo+IA0KPiBIb3dldmVyLCBhcyBJIHNhaWQgZWFybGllciwgcHdyY3RybCBj
YW4gaWdub3JlIHNldmVyYWwgc3VwcGxpZXMgbGlrZSB0aGUNCj4gJ3BoeS1zdXBwbHknIHRoYXQg
Y29udHJvbHMgdGhlIHN1cHBseSB0byBhIHN1Yi1JUCBpbnNpZGUgdGhlIFBDSWUgZGV2aWNlIGFu
ZA0KPiB0aGF0IGNvdWxkIHdlbGwgYmUgY29udHJvbGxlZCBieSB0aGUgZGV2aWNlIGRyaXZlciBp
dHNlbGYuDQo+IA0KPiBTbyBJIGRvIHRoaW5rIHRoYXQgdGhlIGJlbG93IHBhdGNoIGlzIGEgdmFs
aWQgb25lIChvbmNlIHN1Y2ggZGV2aWNlcyBzdGFydA0KPiBhcHBlYXJpbmcgaW4gdGhlIG1haW5s
aW5lKS4gSG93ZXZlciwgSSdtIG5vdCBkb2luZyB0byBwb3N0IGl0IGZvciBub3cgYXMgdGhlcmUN
Cj4gaXMgbm90aGluZyB0byBmaXggaW4gbWFpbmxpbmUgYWZhaWsuDQo+IA0KDQpZZWFoLCBubyBm
aXggaXMgbmVlZGVkIGF0IHByZXNlbnQuIFRoYW5rcyBmb3IgeW91ciBjbGFyaWZpY2F0aW9uIG9m
IHRoZQ0KcHdyY3RsIGZyYW1ld29yay4NCg0K

