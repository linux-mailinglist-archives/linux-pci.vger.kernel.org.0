Return-Path: <linux-pci+bounces-28785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA06BACA823
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 04:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5C6C189DC8A
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 02:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B65733E7;
	Mon,  2 Jun 2025 02:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="QUUQTg6B";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="7CxGKVnb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC4C2C3267;
	Mon,  2 Jun 2025 02:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748829949; cv=fail; b=bPXIHuEagfp1o2I5XFZBQz23RaPHDBntDasmKI+JXApt36uxYh9nr8+F5vzfCsYKbgC9S+2DVYMd4m9eqxShqugGP5wYt5ZQyPXWqrj+jWLe3x7VfkbXD38wSG0RaDMEiruFCfFVG/RSSS0J07T8uGT2hl1+BIufDe7jmsodY/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748829949; c=relaxed/simple;
	bh=ZxrTO6gNTFBMHeVxhaCHVfLrwYDfeOAe2EUSLm53r5w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rJsc2Qx80N/L7QIefl1tqbi415xDzQG+UyNW1bQtLGGjZWxMa+AfY12BdbojginyC/vmvsVWh/0qjQiWOCrsqpnbYI6TUjh2Moo9vNxcsVr7D446qNl1XYHTAP5qy1tG1gkYY/bUD6vYnz1g+5VokxWfHhFplvG1zRSZDZm54KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=QUUQTg6B; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=7CxGKVnb; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 551NT02g027768;
	Sun, 1 Jun 2025 18:24:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=ZxrTO6gNTFBMHeVxhaCHVfLrwYDfeOAe2EUSLm53r5w=; b=QUUQTg6B2unU
	cIASyy968QQMUPY9RyNHcibUrRzL2tprz5G/3ttrbG/Js7AJHiujjfNh5+OQ6O4w
	V8gBKoHgIZ8YAOuP5R+8iadXfORubX6zY1Xyh598cD6OKLxWlv5+5xBKnObxx2bV
	JIz+Gx+r57afnhtZjH0kKGe+kgozESeogW54RYw3G4LKUfw1c2bgE1xT2v44xxHg
	I+FACnCUsBYf+bxLd0x84y23MPYYw5RVo9CIBDf3XeF1Ytlg8usC5x++XKFEV8y5
	fKdNt6JKZ8zPAedHQAzjNxnFNt9SO28B0eUKdn50LLQem1OG0I8+wIkuD+t/atU1
	Fo3VTQNcLg==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 46ywbydkqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Jun 2025 18:24:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdIXybo+nNQuidq9G00ob4JKfjNsWYn/EHuSt/qvTfatEa0ZTgPE+Ov++uPhyV487Z2BRFEJcrlNSh6XvCLqfy/8TKDZ8YaNYeOXhVUDe0mgQV5CFW0X/RyyuHhB24QCCbESAhNeeRZSQu8sb/S+gqeZzbgRSL8xnpCUKfNsnXwUn50jRxrtRrYbNzj+RsqPCmB08e3voI46yxgFYEKYS5NhoBrtXI5L0BhZHP0sRaJzIqrGPeLdASaaaFKjYPpsFwcPRRn4MRjpyiHf8LxFJiJCYTrYzdM0YyECRrMpv4Yf1Z3f8dtcEt6Ow/9nh31aedJtMGb7bBMPpL+wRHUFnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxrTO6gNTFBMHeVxhaCHVfLrwYDfeOAe2EUSLm53r5w=;
 b=XoetgwYwdth1PqQGI2Jbe8ey1C8PNrIVoFPKkK6N/bM0GhIVZWQD4ncvd7KiiCZR6Ctp/SqM2GC7qN+LSXmLlfp1OpbPrsqqP5xK+psggrui8HkSYGjoSmapBPvbb9zu4cO5ALRfIWenj97p4X7Xp4GUAYezigQdhlsr8mRMWroyu8pLiHWf94FSYM0J4169Z0yBm0P097G6GHYH+fI1ckGhjwM5Ax2uriskWTdxROkRZym2zl/hX+HoX6Cg8WDgpOzKQPLZsd8zFeCuC8YP4SbCh9OuxeFYPaQWHAq9cCG+EkLMHHD1o9aVHXr/hLZ/Di6HCGy3Lk4zsZtJtK8uyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxrTO6gNTFBMHeVxhaCHVfLrwYDfeOAe2EUSLm53r5w=;
 b=7CxGKVnb7k5CKYsBTy9C1M8ZwWI/CsQ7bLJ6o3AYX7j54+xOOukWu3bVzne6Mbu9u1uSbW4sJYzVfxfgNLMPuVzs1y4DScC8MCECdnmVRGmUs2S758iOL7XQBh/xzsKwVElzBFTur9Sk8PqdUlJ93ZKFmu9CSd/pogUEqLxbfIk=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by CH3PPF582003E95.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::215) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 2 Jun
 2025 01:24:28 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec%8]) with mapi id 15.20.8769.029; Mon, 2 Jun 2025
 01:24:28 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>,
        "hans.zhang@cixtech.com"
	<hans.zhang@cixtech.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        Milind
 Parab <mparab@cadence.com>,
        "peter.chen@cixtech.com"
	<peter.chen@cixtech.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 5/5] PCI: cadence: Add callback functions for RP and EP
 controller
Thread-Topic: [PATCH v4 5/5] PCI: cadence: Add callback functions for RP and
 EP controller
Thread-Index: AQHbtLTqhrOj3n1VWEy0k689YBqH2rO0lFUAgAJQW2CAN7gpAIAAs1yg
Date: Mon, 2 Jun 2025 01:24:27 +0000
Message-ID:
 <CH2PPF4D26F8E1C22F8726D1ABA60E1A819A262A@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250424010445.2260090-1-hans.zhang@cixtech.com>
 <20250424010445.2260090-6-hans.zhang@cixtech.com>
 <25f5e8e4-1b64-478f-84ab-eede2c669655@kernel.org>
 <DS0PR07MB10492918808B18BF4E619DE3FA2862@DS0PR07MB10492.namprd07.prod.outlook.com>
 <7oafcgprthitopfne3iawig53gdkjhpoe2noe7s555hz53uclt@qykd4udbzdu4>
In-Reply-To: <7oafcgprthitopfne3iawig53gdkjhpoe2noe7s555hz53uclt@qykd4udbzdu4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|CH3PPF582003E95:EE_
x-ms-office365-filtering-correlation-id: 5d047c42-afa2-4eac-b157-08dda17437cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NU9EdzBQV0tLV1l6ZUlnZEZiRmhxS2paM2l6ejNqWGhtT1B6N04xZ0xldUFt?=
 =?utf-8?B?MUhWaHJBcjhpeXVCQ1NNaXF5NWVWOVgzYTJFcG0vVXFBaWxvWWV1eHBFNUVa?=
 =?utf-8?B?aWdFMDhvSE1XU3NSQ25GdlhWVjQ2WU1uZVlERnJiUVFmbmZUN0tLZ1d3K051?=
 =?utf-8?B?Z1p3KzY1SlpTT3RlekZjWWg0czdWZ3p3RHFYY1ZUMGppcGxsUkpSejZWNVNK?=
 =?utf-8?B?d0IvZ1RVb3o1VUtjS05IZHVpdjdHYjNHRW83cjdQT21LcXQxWk0vT2locGdG?=
 =?utf-8?B?NjlIR3k1K05jYms0MUNtcThzQUpuUC9lWmtzMzlkc3dTR3VEaDFxTHpqT0w3?=
 =?utf-8?B?RmVxZE5YZTgyVGVUV2VncFU5TWJnbkV0WDJseUhudVdhTFZvVjNGWXFzbXRj?=
 =?utf-8?B?R3VZQkFLYi9wY0M1UEtlYXp3clVJKzZQTGUvY0FSbDB3bDArbTdNU0U1M2R6?=
 =?utf-8?B?WUxZTVM4d1FiQ0RmNFEwdXczSHI4L1lNaTJzYnBMRUpTY3c4Zm9sWDRGZjI3?=
 =?utf-8?B?MEJlb3JIelhXbXVvejg1c016Y1gwN1lraG1JeXlJQmdUNW96cHMzd2NnQUhr?=
 =?utf-8?B?bzVjUzVkdTRyZTFOVnlPMHVtN1hXTUJXdDlsVGZNaWF0c05zRjdVbkVMSTNG?=
 =?utf-8?B?b1Y0NHk3NkhEVHA4UWdQb0pRck9vNVJDbDZhN2FlSlhJaUJPd3pLYWdGTSt0?=
 =?utf-8?B?eHZEWVBVY24zUXdUWkVUZVlFSEV0THNtNnlVc1ozYm5BUnYzVVJLWkx3SCt1?=
 =?utf-8?B?ZWU3UEVocXUwa0lIa0JFbCtzT2RVcjYrcGtuYnA1bHYxSk1pdmJGSEI5dlIx?=
 =?utf-8?B?ZlBzMkIxVEtURC9LZEVuZ01WRDhxdkV1bzhTZnlkdjVZbzNaTVNzZmVKRktl?=
 =?utf-8?B?c2ZGYTBXdml6c3F2cGRjRWVKTEVDdmNZZE1TUTNXUG9RUlU0RFRIRmo1M2FW?=
 =?utf-8?B?RXpRWHJNd1kzY0NlcmR5OWpBWXVmY2NqdnpRRW80aXdvYy9tWENZeEo0bHp3?=
 =?utf-8?B?VzlWZm1TdG5nazh2MExoTmtMZTI2K3p1YlFyY2ZQRlhoZmdzZXdPbE0xeGhu?=
 =?utf-8?B?SDZxcllZQmtkWkFROHNRbWkyL2Y1ZTVRS25oOC81d3dHK042N2piMkRVQWhJ?=
 =?utf-8?B?VzJXcWprRFVVb3B4Uk5ZV1c3VFI4VTZkRFBucXR5TnpBMFFXNUs0RjVwK2w5?=
 =?utf-8?B?TFZQeFd3Vmo5cElIR0tsUENCT3ZDVUp0ZDFnZTV3VlRpS01wMVp1V2V4V3c0?=
 =?utf-8?B?RGNnNkF5eDJzcVpEY3VyajhsdFdPVzZqYUhmaXdNdmlBaFJ2UFdzK1ZlMnRF?=
 =?utf-8?B?VHBySVVPZmY5dEhaM2MzVUEyR0haRkdLcFEwNU9PY2svblZyelQrT1FKZXZZ?=
 =?utf-8?B?UUs4VlNkRk9oeno0MG1CNnBUSmc5cEJkTSs5SHlaNEhuNENuTjFNcWhuN0lP?=
 =?utf-8?B?anhmeGZTZ2x0czVlMXBPdDRteFRuOFZBMTlaWnZTTVpDTjdGNTUvKzNWR3Rw?=
 =?utf-8?B?cWIvbHBLNTk1dDhMSTlDZ2hCSk45bTRYbkYwU0dSSUVud3ltRmhhRmFhMjVS?=
 =?utf-8?B?ZCs0bk9QQVNlVnZIZVcvbWtGa05IdHZiWk9ENGJMeFBtS1pocWVsaE1XVFRV?=
 =?utf-8?B?bnhaM1RYeDdVUVNtS1g5VmkxOGNyWjBGWHJha2NZNWdjQTBxTE1GaVY0dHVM?=
 =?utf-8?B?YUQxZ1VPVUlkZ3FJSUR5UHFMb1FZd2FEZU9hUklyZzN2dHovMzgvc2ZPeWxW?=
 =?utf-8?B?VVc4Y1E4ZUdXeldxL0Qxa2x2RXRGWWRVQmNiNXVsNWpNUWIxTWtVM0pyMjN2?=
 =?utf-8?B?RnJyZXBDYzM5alNLYXRlZHB2bGhqZjlXaWcyZG5BMWdNTXpOZFZndEJ6QWNK?=
 =?utf-8?B?MzV4cDVxVmxqQU1QLzVpWUpZNUJmRzRaVG90N2tiNUxoNDg2RStYeTkyQmF3?=
 =?utf-8?B?ZHRYdXBVajZTZHVEZEk1L0dWTHNsRi9Pb1J0enNkb3B1ZXhGUTduc2RZV0xh?=
 =?utf-8?Q?Wbh7Lq+4OmoXpAQm0fu0fvC/2vEou0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U05vQ1BhOHdRZHV0b1p0YW9XZ2lERHo3ZVFadExlQ0hqR0xkbW4wMERGejVS?=
 =?utf-8?B?RXFsdlU3Tk9LUUR2VGVTcDFYZkNZVzVMTlo4RVBHc0NRQlA5S3VmNGNva2Jt?=
 =?utf-8?B?WkY4ZzB4OUpoNWljMm5QWDZLVCtnM1Q4REc2NHVSdUlHMGtlaHFkcHQ0ZVZk?=
 =?utf-8?B?dDEyVVhxTC9QUUlGTzd6dWVaUU95dUVNT2RWQzRPbVMwdkt6anVDL0xhcW1t?=
 =?utf-8?B?SWFobVNQcjEvMkFBMzliVm80a2RkOFVUU3dzekd2UlFpOWREa0JubEdkU3ZN?=
 =?utf-8?B?TjFpNG9xbWFXaWRWa2MwaDBHeXJHZWNOa3JFTWxiMUFtY3dTWDVwQmVoYURr?=
 =?utf-8?B?M1NlN2QzbjUxSTJzVitUbnNBTEx6RUxCSHNrTDJzQnQ5VnB1K2NOS2dhMFlR?=
 =?utf-8?B?NklYZlJ2aldlNmlzUkgwbzJPbHUxV05yWkxheWkwYUlHL2R0ZjdMSllXSk5a?=
 =?utf-8?B?ZWovQVBvdWRjallMcm1WUXQwdHdWR0Jkc1Y1WnpDMXpoSWRDL04wUGVEMTlH?=
 =?utf-8?B?eTFpQi8rVjM2ZDZHNWc0V21wWUl3WWRkUys1ZVByalJHbkM5b3F5Y1hnS1VH?=
 =?utf-8?B?NzJieDN5VjFDeHByV0l4bUVQS2hxT1QzcEE2WlZWS1BEMmZQSm5qdGs3Wlla?=
 =?utf-8?B?blVTUGhNd1FKdU5iK3BNV3JPdWFtS05yME9xcnovejdpSExBOFJMOTBGbnB5?=
 =?utf-8?B?TGI0YzFjb25adnVCMHdzcmNRZHZLanNGM2JOTUMycU9Vbkx2RDJYQUhacTkw?=
 =?utf-8?B?b3NTMTNuNllYOFdqcjhVc2wzSWtwVE5Mek9rWitHdVRQYThPdko4M0JlNXRa?=
 =?utf-8?B?WndzRVZUZ21VaDNoR29qWThycXJVZmpua2VCWFMzaGhNamU4R2tzQ2ptQUNP?=
 =?utf-8?B?SXREK2d4L2xSNHlNazROVlVQMW84M1pneThyVHprQ2tHaHo1c0RvZ2hyNnhm?=
 =?utf-8?B?blJwQ1VEV0NCamR1a3pwN1FLMTd0RnBZcVVHWVBpUVpxVUtvNUJTYSswQnVL?=
 =?utf-8?B?SnBNbDZWS2VmQnJncGFXbmxwQm5pdmNMY0FsQ1J1ODlPRWxlYS9PYmNKSDVD?=
 =?utf-8?B?RUFmTzQxemk3aEF2K0xRN2J0SFJzMFhMQnNLaDZpdlpNS1ZXOEhrWmw2ekZI?=
 =?utf-8?B?bnRtV3hxSjNRYVJCTXFIRHRMNXg5dHNrT0ZoL08vYktVbmMzbWo1dnRuSXRO?=
 =?utf-8?B?OVgrQlJuUjBaVmErc2g2RG5VTXBkNVNSekRRTDVOUUczcVRzRzg5aDd4S214?=
 =?utf-8?B?YkdFbU5QQUhjblNYVnNpaUgyWVY0L2NPWUFmNGpLeHBKbW5ET3BOVk5VdmM3?=
 =?utf-8?B?SjlXZTFGbGhaT3RqQnByVHltRkltTS9UUmhTU3NDUTU2aVdVQnN0alU4OUx4?=
 =?utf-8?B?c1JqRGVSQnFSaTc1WHJkS0kzd09xdVdtQUFoM0JldkJqOHpkWDhUQzJuaDNj?=
 =?utf-8?B?ZHIvbjE5ZlNvVlVhU21tWk1hdzUwUjR0ZVNUOS9jb1hPbDJ0Q1pOSFMxcGFp?=
 =?utf-8?B?Q0pKZituOXRtbERSdFo4eTNRcGxoS3VMYlF0RnpuZm5ocWhwOWY1NXZTc0VZ?=
 =?utf-8?B?OC8xTFNrWU04eDJ6U2ZZTTRsK3MwQjF0TW1oNjNvMzZpVEpSQXAvbjVzSkh2?=
 =?utf-8?B?UVBOSWFsK0VZS3FoTnhKSmt5T3pXUjVFemxOUmM0ZWtXMlIycGk0Q2h3NWU5?=
 =?utf-8?B?YktibkRvRFY5ZVF4UUpVSzJyT0pqbnY5c3FLWUI3L0VwWHpveEdaVGcrcXdS?=
 =?utf-8?B?MXVCVmNIWlAxWCt6Y2dNVnVLS1F5bk95bW5NNXN3czJRYXcvb29NdkdvYnNC?=
 =?utf-8?B?RmdGdUdtSStyNG5rT3VwdVMrbDVkejc3SVdlYmZ6dnl0QnRlM0F5UEJXUDQ1?=
 =?utf-8?B?K0FrT3NWN3E0S0o2cFRjU2Z0b2Uwc0g1U3dQVVBUa0xGdmdINEt4cGNxQ3Y1?=
 =?utf-8?B?aEFYVzdmQ3RqR3ZJWXlTWkFYM2RRaXlWSUJDUEthQmhwWmMvZ0tLTFA3YkJX?=
 =?utf-8?B?STdaZVZBY0drT0J6b1BJaXdvU0VRWE4yQlZySlBkL3NId2E3a1lVSGpBV3J5?=
 =?utf-8?B?cXU1TytGWXcxd09NOEE2ak83a1dBMkhkUDFya2c2OHVUTkJHVHIxV29EdkVH?=
 =?utf-8?Q?dQMigW8GepX7yL/70Z6j8VDTl?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d047c42-afa2-4eac-b157-08dda17437cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 01:24:28.0528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sHnUT4tUIwJDaranAIZI1JkYuX4r/E07pUu5fxuDqUjGaIOWXvkh9/a8yKbZl6HkH3xpLsEmfoRhK7CUWijHXo3/6nAPJle/Nw1BIF8DB9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PPF582003E95
X-Authority-Analysis: v=2.4 cv=MvhS63ae c=1 sm=1 tr=0 ts=683cfd4e cx=c_pps a=QWqdXKTD4x5QpoVJet23Jw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=Zpq2whiEiuAA:10 a=KKAkSRfTAAAA:8 a=Br2UW1UjAAAA:8 a=VwQbUJbxAAAA:8 a=TAThrSAKAAAA:8 a=1XWaLZrsAAAA:8 a=NufY4J3AAAAA:8 a=apAZQjvuT7ElTCejn44A:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=WmXOPjafLNExVIMTj843:22
 a=8BaDVV8zVhUtoWX9exhy:22 a=TPcZfFuj8SYsoCJAFAiX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDAwOSBTYWx0ZWRfX/GbvVwO41aB/ Ae8iqIZy0KFo7QKgagBxI7EQ2A2inCKG6UERxIITRnGl+qerHR96MRdI3ZTCYX8B6WbLFQrCKTG F2xka9dS0nczS9jb7IYQV9x4dqvICl1twgRfOsLcEOuzLDJlNShV/cSNBhTTdHH4h3hKSCJ4lEj
 liItU+Z67xvhXJN1eA99kvAcGTW3iQg/PZ2pWhIhC9VRS/3K5V8J/rMwDS7wUcImIXFBRkpJHgo H4cTqeyzdpniOu2Vci9+8SzToaxoU6sPSGSCWleHTcqqFJ58mr8bvUIpL0hZxiJGczex6b0u4b1 WiRjg9V/UKJf3Oy7Exh/0jAjPx2KIx5GnJzPYAsEfBiDQ734k/XH3LqT0mZnvgasvhbKn0MyGoh
 6/DndTHZOw6ykk16bSlnfrxNMW1HC35VZc0L0vZIrKaLemPvZqMciCfqrQSJ62wu9O+BK6Je
X-Proofpoint-ORIG-GUID: ygzS4XSs57M8w2bUerr6CjaMyCMjrsBu
X-Proofpoint-GUID: ygzS4XSs57M8w2bUerr6CjaMyCMjrsBu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-01_11,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2506020009

SGksDQoNClRoZSBuZXh0IHBhdGNoIHY1IHN0aWxsIHVuZGVyIHdvcmtzIHdpbGwgaGF2ZSBSb2In
cyBjb21tZW50cyBhZGRyZXNzZWQgYnkgc2VwYXJhdGluZyBvdXQgdGhlIGRyaXZlcnMgZm9yIGxl
Z2FjeShMR0EpDQphbmQgSGlnaCBwZXJmb3JtYW5jZSBhcmNoKEhQQSkgcmVwbGFjaW5nIHRoZSBv
cHMgbWV0aG9kIHRoYXQgYXJlIGluIGN1cnJlbnQgcGF0Y2hlcy4NCg0KDQo+LS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZw0K
PjxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZz4NCj5TZW50OiBTdW5kYXksIEp1bmUg
MSwgMjAyNSA4OjExIFBNDQo+VG86IE1hbmlrYW5kYW4gS2FydW5ha2FyYW4gUGlsbGFpIDxtcGls
bGFpQGNhZGVuY2UuY29tPg0KPkNjOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5v
cmc+OyBoYW5zLnpoYW5nQGNpeHRlY2guY29tOw0KPmJoZWxnYWFzQGdvb2dsZS5jb207IGxwaWVy
YWxpc2lAa2VybmVsLm9yZzsga3dAbGludXguY29tOw0KPnJvYmhAa2VybmVsLm9yZzsga3J6aytk
dEBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOyBNaWxpbmQgUGFyYWINCj48bXBhcmFi
QGNhZGVuY2UuY29tPjsgcGV0ZXIuY2hlbkBjaXh0ZWNoLmNvbTsgbGludXgtcGNpQHZnZXIua2Vy
bmVsLm9yZzsNCj5kZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgNS81XSBQQ0k6IGNhZGVuY2U6IEFk
ZCBjYWxsYmFjayBmdW5jdGlvbnMgZm9yIFJQIGFuZCBFUA0KPmNvbnRyb2xsZXINCj4NCj5FWFRF
Uk5BTCBNQUlMDQo+DQo+DQo+T24gU3VuLCBBcHIgMjcsIDIwMjUgYXQgMDM6NTI6MTNBTSArMDAw
MCwgTWFuaWthbmRhbiBLYXJ1bmFrYXJhbiBQaWxsYWkNCj53cm90ZToNCj4+ID4NCj4+ID4+IC0t
LQ0KPj4gPj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvY2FkZW5jZS9wY2ktajcyMWUuYyAgICB8
ICAxMiArDQo+PiA+PiAgLi4uL3BjaS9jb250cm9sbGVyL2NhZGVuY2UvcGNpZS1jYWRlbmNlLWVw
LmMgIHwgIDI5ICstDQo+PiA+PiAgLi4uL2NvbnRyb2xsZXIvY2FkZW5jZS9wY2llLWNhZGVuY2Ut
aG9zdC5jICAgIHwgMjYzICsrKysrKysrKysrKysrKystLQ0KPj4gPj4gIC4uLi9jb250cm9sbGVy
L2NhZGVuY2UvcGNpZS1jYWRlbmNlLXBsYXQuYyAgICB8ICAyNyArLQ0KPj4gPj4gIGRyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvY2FkZW5jZS9wY2llLWNhZGVuY2UuYyB8IDE5NyArKysrKysrKysrKyst
DQo+PiA+PiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9jYWRlbmNlL3BjaWUtY2FkZW5jZS5oIHwg
IDExICstDQo+PiA+PiAgNiBmaWxlcyBjaGFuZ2VkLCA0OTUgaW5zZXJ0aW9ucygrKSwgNDQgZGVs
ZXRpb25zKC0pDQo+PiA+Pg0KPj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvY2FkZW5jZS9wY2ktajcyMWUuYw0KPj4gPmIvZHJpdmVycy9wY2kvY29udHJvbGxlci9jYWRl
bmNlL3BjaS1qNzIxZS5jDQo+PiA+PiBpbmRleCBlZjFjZmRhZTMzYmIuLjE1NGIzNmMzMDEwMSAx
MDA2NDQNCj4+ID4+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvY2FkZW5jZS9wY2ktajcy
MWUuYw0KPj4gPj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9jYWRlbmNlL3BjaS1qNzIx
ZS5jDQo+PiA+PiBAQCAtMTY0LDYgKzE2NCwxNCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGNkbnNf
cGNpZV9vcHMgajcyMWVfcGNpZV9vcHMNCj49IHsNCj4+ID4+ICAJLnN0YXJ0X2xpbmsgPSBqNzIx
ZV9wY2llX3N0YXJ0X2xpbmssDQo+PiA+PiAgCS5zdG9wX2xpbmsgPSBqNzIxZV9wY2llX3N0b3Bf
bGluaywNCj4+ID4+ICAJLmxpbmtfdXAgPSBqNzIxZV9wY2llX2xpbmtfdXAsDQo+PiA+PiArCS5o
b3N0X2luaXRfcm9vdF9wb3J0ID0gY2Ruc19wY2llX2hvc3RfaW5pdF9yb290X3BvcnQsDQo+PiA+
PiArCS5ob3N0X2Jhcl9pYl9jb25maWcgPSBjZG5zX3BjaWVfaG9zdF9iYXJfaWJfY29uZmlnLA0K
Pj4gPj4gKwkuaG9zdF9pbml0X2FkZHJlc3NfdHJhbnNsYXRpb24gPQ0KPj4gPmNkbnNfcGNpZV9o
b3N0X2luaXRfYWRkcmVzc190cmFuc2xhdGlvbiwNCj4+ID4+ICsJLmRldGVjdF9xdWlldF9taW5f
ZGVsYXlfc2V0ID0NCj4+ID5jZG5zX3BjaWVfZGV0ZWN0X3F1aWV0X21pbl9kZWxheV9zZXQsDQo+
PiA+PiArCS5zZXRfb3V0Ym91bmRfcmVnaW9uID0gY2Ruc19wY2llX3NldF9vdXRib3VuZF9yZWdp
b24sDQo+PiA+PiArCS5zZXRfb3V0Ym91bmRfcmVnaW9uX2Zvcl9ub3JtYWxfbXNnID0NCj4+ID4+
ICsNCj4+ID5jZG5zX3BjaWVfc2V0X291dGJvdW5kX3JlZ2lvbl9mb3Jfbm9ybWFsX21zZywNCj4+
ID4+ICsJLnJlc2V0X291dGJvdW5kX3JlZ2lvbiA9IGNkbnNfcGNpZV9yZXNldF9vdXRib3VuZF9y
ZWdpb24sDQo+PiA+DQo+PiA+SG93IGRpZCB5b3UgcmVzb2x2ZSBSb2IncyBjb21tZW50cz8NCj4+
ID4NCj4+ID5UaGVzZSB3ZXJlIHJlcGVhdGVkIEkgdGhpbmsgdGhyZWUgdGltZXMgZmluYWxseSB3
aXRoOg0KPj4gPg0KPj4gPiJQbGVhc2UgbGlzdGVuIHdoZW4gSSBzYXkgd2UgZG8gbm90IHdhbnQg
dGhlIG9wcyBtZXRob2QgdXNlZCBpbiBvdGhlcg0KPj4gPmRyaXZlcnMuICINCj4+ID4NCj4+ID5J
IHRoaW5rIHlvdSBqdXN0IHNlbmQgdGhlIHNhbWUgaWdub3JpbmcgcHJldmlvdXMgZGlzY3Vzc2lv
biB3aGljaCBpcyB0aGUNCj4+ID5zaG9ydGVzdCB3YXkgdG8gZ2V0IHlvdXJzZWxmIE5BS2VkLg0K
Pj4gPg0KPj4gPg0KPj4NCj4+IEkgd2FzIHdhaXRpbmcgdG8gY2hlY2sgaWYgdGhlcmUgYXJlIGFk
ZGl0aW9uYWwgY29tbWVudHMgb24gdGhlIGFwcHJvYWNoLA0KPmJlY2F1c2UgdGhpcyBhcHByb2Fj
aCB3YXMgdGFrZW4NCj4+IGJhc2VkIG9uIGFuIGVhcmxpZXIgY29tbWVudHMgb24gdGhlIHBhdGNo
ZXMuIFNpbmNlIHdlIGhhdmUgbm90IGdvdCBhbnkNCj5hZHZlcnNlIGNvbW1lbnRzIGZyb20gb3Ro
ZXINCj4+IG1haW50YWluZXJzIG9uIHRoaXMsIEkgd2lsbCBzZXBhcmF0ZSBvdXQgdGhlIGVudGly
ZSBkcml2ZXIgZm9yIG9sZCBhbmQgbmV3DQo+YXJjaGl0ZWN0dXJlLiBUaGUgZmV3IGNvbW1vbiBm
dW5jdGlvbnMNCj4+IHdpbGwgYmUgbW92ZWQgdG8gYSBjb21tb24gZmlsZSwgdG8gYmUgdXNlZCBh
cyBsaWJyYXJ5IGZ1bmN0aW9ucy4gVGhlcmUgd2lsbCBiZQ0KPnJlcGV0aXRpb25zIG9mDQo+PiBj
b2RlIGJ1dCBmcm9tIFJvYidzIGNvbW1lbnRzLCBJIGJlbGlldmUgaXQgaXMgZmluZS4NCj4+DQo+
DQo+SSBhZ3JlZSB3aXRoIFJvYi4gV2Ugc2hvdWxkIHJlYWxseSBnZXQgcmlkIG9mIHRoZSBjYWxs
YmFja3MgYW5kIHRyeSB0byBtYWtlIHRoZQ0KPmNvbW1vbiBjb2RlIGEgbGlicmFyeS4NCj4NCj4t
IE1hbmkNCj4NCj4tLQ0KPuCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprg
rr/grrXgrq7gr40NCg==

