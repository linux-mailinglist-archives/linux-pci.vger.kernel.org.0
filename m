Return-Path: <linux-pci+bounces-20614-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635B6A2462C
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2025 02:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68CF77A3636
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2025 01:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B918D9461;
	Sat,  1 Feb 2025 01:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="b95yke1d"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE103AD21;
	Sat,  1 Feb 2025 01:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738373135; cv=fail; b=kDT8vifMX6bNbAvVozxiWoFNcJ9ZkZNV8ic2MQRmI2fd70UCjeLllkEjIWPQM8c7ZM29Op4tGmQ6DoqEtATcnG4CDz/Kg4gS1I++QoKMk7J9ENpFWTD9JOZ5ECh/prRwZaE/Vt7+0OiC4SQjfxbBjfGK3gSm4pL+9+TXsQMP4q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738373135; c=relaxed/simple;
	bh=zKKn58zWdN6d2Swk8jJfWMzy7sbxzNV0ZGyni/r6ctA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D7uK2h1qH3gQ554YdkKHZiMEvqmvDsr7/0J0jOJdO17uIeXZGRzVm4tE6i5qYoIYoZkIka1XRtDs0PMoBb2DBVZ9zO1JIxbRNAogAUUIKAsE/DOXIDpmcUMk0VIiUYIFDEb++rX5GJl5PzyuS5Epl3fj0blYHStKeFBz10DLZnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=b95yke1d; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50VKtdnZ015508;
	Fri, 31 Jan 2025 16:57:59 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44h5y6raec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 16:57:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITs4Q7GQmq1csxUKpns0GH1lZ3Ek0xHptw4YL76HfmMu8krTfrWF+TvPbzl/33y0GE/n+28+8WIIXEV0f5v/r+NZDepxLsSitvrg8OspzHNnvCv7vP4z+JSef889SQT9z5hN3pyQQwhcZ+5O2VtUXIhN6TuSSSEIVLzZgmr2w7wz7ynV+tHnyUCvtVKlkqMlwAWRj5cTO62z45Kp6vOJLXPZzegknRVfedIilyK3+7bXBK8JMdGxhU4fSlq0wnnUrys65BBTDapgk7PsWROh9wgGvvuPwAeLemUjwCKEws49iu8U8fqdQQa5naSCRhafcOW71eE+yt6blwpwTieemQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKKn58zWdN6d2Swk8jJfWMzy7sbxzNV0ZGyni/r6ctA=;
 b=q9gkAm68itIQzxRqNfkGgMlC57qaHskprWCpD14zEAYDiBuiwpkFVrs5hNTWV1N15iQCS7inHKFvoDzDVLehlbTGrjxMclJ36YeCflYN2AnN+YUqrRBdp+ORDtXpCfuN2holzyQT/lJcmR4u/W2ZKyE2gyc5vL9TNiAhR/dkJRp6eEFZeko6/CDMtdBvCGIIHwGpPccAWWm0AK2odZGLu7FtwD+Bp8sO1BJ9bDJ6ksZlNJ0xgPHJ98/rJ3spAC2qTUnOFplGZLJoZHYIiTxaIthoFToBmE+q19QIQpTASd2Xph71BI1Wp18HACPFH7PkyFRmGXDlBFYydZ7l/3lYvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKKn58zWdN6d2Swk8jJfWMzy7sbxzNV0ZGyni/r6ctA=;
 b=b95yke1dRkySPVf/WVNdWiyvrnx3bNa/yGev7by2+dCfkliSbhk5T15CDLetAarf9qL/SNsIisT9zCTZl7TMnmv88d5nrajpbTepfGrgFkSK5k6EX4rU5AkgHnpWAjGZSdIjzKNoN8wtero8rDuulU9xN6Vbvc7HWUh0EllTMd4=
Received: from BY3PR18MB4673.namprd18.prod.outlook.com (2603:10b6:a03:3c4::20)
 by LV3PR18MB5637.namprd18.prod.outlook.com (2603:10b6:408:199::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Sat, 1 Feb
 2025 00:57:56 +0000
Received: from BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5]) by BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5%3]) with mapi id 15.20.8398.020; Sat, 1 Feb 2025
 00:57:56 +0000
From: Wilson Ding <dingwei@marvell.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "kw@linux.com"
	<kw@linux.com>,
        "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Sanghoon Lee <salee@marvell.com>
Subject: RE: [PATCH 1/1] PCI: armada8k: Disable LTSSM on link down interrupts
Thread-Topic: [PATCH 1/1] PCI: armada8k: Disable LTSSM on link down interrupts
Thread-Index: AQHbdD9nYBcYj0YRMUe5aGbFZQ/QD7Mxlmnw
Date: Sat, 1 Feb 2025 00:57:56 +0000
Message-ID:
 <BY3PR18MB467343D941D2F7706FD88FCBA7EB2@BY3PR18MB4673.namprd18.prod.outlook.com>
References: <20241112064241.749493-1-jpatel2@marvell.com>
 <20241112214337.GA1861873@bhelgaas>
 <BY3PR18MB4673E2698A6F465FEB56B5A2A7EB2@BY3PR18MB4673.namprd18.prod.outlook.com>
In-Reply-To:
 <BY3PR18MB4673E2698A6F465FEB56B5A2A7EB2@BY3PR18MB4673.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4673:EE_|LV3PR18MB5637:EE_
x-ms-office365-filtering-correlation-id: 07399b29-53d2-4aae-3986-08dd425b7714
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VkhKZTl2bEluYzROSDhXRXY2eW5TZnhLMmE3bjNhRmc1NDMwNHkzVWVDdzBp?=
 =?utf-8?B?aHhoY3d3TU5xRGJyK0tFTzRiVHB2M3NlbmIrYk1wWHVHQVo1RlZxUUdyZU40?=
 =?utf-8?B?c2FBU0E3NHpzWVE1TE9BZkNOU3VlRlVYTk9tWXFvNzRXQllqRS9ISzNZM2l0?=
 =?utf-8?B?dkpiZUJNZTlma2JoSzZqU3VoSS9GUTY0Q2ZDb0paTVRVOHluMVJWdVJCYTFX?=
 =?utf-8?B?NmpPeC9tV2tJVHpmS2VxWEIxdmdZRTY0U2h4amd0cU1sRnZEUDY3UDNJQlJw?=
 =?utf-8?B?OEp6K0xPczBKUU40c3J0S2JlZTE2Z1Z5U2JUZC9MUmhZZWVZTlJJUlZmaHRj?=
 =?utf-8?B?Z09qcm1JVnRzV3pnVEZYMWVQYlNpTzZvWEZzRnhrbTZIbnN2NkZtazhPZnFz?=
 =?utf-8?B?S0NEUExLWTZNUVVGcUJndmU2aHZ2aTJ0K2ZQdkM1ZmVaRTR2LzF2WTN1eiti?=
 =?utf-8?B?YmhmQUFLRmdXSE8xVUpPcHozbmt1WWFnQ3kvU0NkSmQvczBnc3BjUEpyZW12?=
 =?utf-8?B?dGJIMmtpOElkOXF0SEluSVdPY0hPbG5KN09FazE4MWd3MDVlN3RXdXJRREZQ?=
 =?utf-8?B?WWlnS0sweERsRldDOC9HSHBvU2xSR3g5eSt4KzUxekNsOFJsdGZTQlJOdHE0?=
 =?utf-8?B?TXpreGR5eWpGd1l4YjRUaHpBNk5LWEEzSHcwbkZaZmJPdDZpeFprTlZDT1NX?=
 =?utf-8?B?bTFVMHZCbXdZbVdsNSswNitmQVhydzNpZjFvTWpOM1hrTE5mbWlyaWxGaUgx?=
 =?utf-8?B?TjJqQS9ILzB6dTFQT2FjZnR0UUdIdGZFWC9HL2ZlT3ZIcUxkWUJmMkJGNXF3?=
 =?utf-8?B?QlJhMjY5UXl4dUw0L2RkZFVQeXpVWnRreE14K2sxUDcvbzVxSEFaWWFPWlow?=
 =?utf-8?B?RDhxYmtvakxOdFZJa3NPaHVKcXA3MVM3THFFTmtvcnpuT3hCNGRENEk3WGVY?=
 =?utf-8?B?TDQzbER3WktHdkQ1aTI4bHBLN1plVFhHTTl1SDlOdzVGTzZzYmdGWFJQSXJt?=
 =?utf-8?B?MlJSS0VxcEhHM3JLMTZpYlQzcyt3NWMwdnBsNG04aWhXR0tvZEMxQlBhSEdF?=
 =?utf-8?B?Y1Z0RXVxcEEyak1jS2ZPNFhqamZXbE4xdUV6b25QazZpUmJJTFN0aTY3YnBv?=
 =?utf-8?B?dXZkVkhQUXhiZlhPZGxtOElLZGVqRHJiNy9uVUtQSUhaMTFKWC9EVUF0Z1Zh?=
 =?utf-8?B?bVdZNS94R1ExbGJ3aXowdC9CZk9sZkJHQmFkRjZ0dm5IWjQ3SDd0WGIyWnZP?=
 =?utf-8?B?UjVwM2Myd0h0R3RxbUFnN21nam1rbXhRcWljY0pock5VTFJoUDNGQk1GZ05J?=
 =?utf-8?B?aVg3eG0zTzFGSnNWQS9xb0lRRmlCVll1Rm5TdDNDSnV0bU5wcEhuUm1TOEsr?=
 =?utf-8?B?NSthV0JuN1RsSzJPT3JoV2RxczBGS0pXSzJjbnM5MWdyVElENmRMUDlCS1JU?=
 =?utf-8?B?L1VuRDNKL0x0cHpHSDhMalU5QmFzNFE4WUpKUG9RekhTeUl5QldoUFNkZS9y?=
 =?utf-8?B?ZHQxRzJEcDlQaGFYWjZDN2dUUXdheHhpV2JKT0svVFNsSWxSQVBSaXVNeG9M?=
 =?utf-8?B?MzlPUXBsQ2Q4d053MTREb09mUFlLTTkzWlRCOG9FRUlwRmVJZkhvZElQaDBM?=
 =?utf-8?B?WmpPT2xCdWRXRW02RDdSTVFVM1dTQzFmdGMwQU4yQjVUbmNuQ1g3d0MrOG40?=
 =?utf-8?B?d292b1RrS3ZPeGNGaExZcEpyOHVkckFjVW9oWFNibzRyblEzbWNQZDRqTlVu?=
 =?utf-8?B?N0ZQRno0ZDdob1Qwc0VhSVAzbHNHbTI1RXhYWU9ONkExOXZXdzhlY2huRmYw?=
 =?utf-8?B?ZnJYM0pOOFRpOHprWkUrMnZEcjFrVkYzMkIyem90V09VM0x2NVZIWUNCQUJq?=
 =?utf-8?B?QkJuZW5uS29RNW5YMVhzMVNnMnNLcW9BSUhmMmppVjd0S2JRWDdyWFlNOUxL?=
 =?utf-8?Q?W2zGlKR5fEvnvysI94lBUli7CApJde/i?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4673.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VUwrN20velZrM05oSmsrV1l5Mnh3MmdIZFVrWklIK2RmcUF4VjA4OUZWdDdT?=
 =?utf-8?B?WEZpRnhyOC9GSVJLUEYwSjRhZ1BlUjZUNVRrbEVVZm9Bb1lEQlRSZkpoWnFN?=
 =?utf-8?B?ZkNlU1ZTMkNTT1AxSHBEQSticHViclNHNlpBL3ZsMm9tWTB4YzZqSkd6UmZU?=
 =?utf-8?B?R1E3S3VMb3habnN5OGtRQytLMENWalJnZ29HRVU5MVhTKzNOL0d6bVYrdWV0?=
 =?utf-8?B?c1lyYU1EaEVJVVBJR2UvanpWY2ZPckJjcGtZMWQzQUIvNTE2Z1plWml1TFo5?=
 =?utf-8?B?ZkdoaVpDeHpTM2UxQjlWc0xNd3pwV0pWOVRVWU5ya2NXREJIOVRGaW9YdFVE?=
 =?utf-8?B?V2o1RDJSSGpzdkNJcVlaekFmUWxtSVFOSWhQTFhpa0xueUROMWUvQk11YVpM?=
 =?utf-8?B?RFo3Mld6ajNVTFNrQkk2R3NIWTV0Njg3Ti9jU3Faei9DR2pqbTk0SWN2SUhu?=
 =?utf-8?B?cVNJOVhtQnZHZ0N2ZC9HUER2c3Fra015NHhLMHUrVFU3SUg3cWtuZ1hkZHJr?=
 =?utf-8?B?NFFyWExLMnJWakFiWXB5VmxiQ1IybC8vWVpMUjJPY2hOZ3BLTS9ldllsNmow?=
 =?utf-8?B?eXcvUzJpSWY1d2ZwTFJqTjFvZEEyc0ZaK0hOazBSenR3MWZxcW91Nnk4NVlv?=
 =?utf-8?B?TXJYQ2Y0emxlbVdLRi9oVlpnR09KZWlNYUowZEFGUncyMllTTnVvOEFtS1FQ?=
 =?utf-8?B?MzFWTytuS2daZy85b2pxeGdxcG1VVDdJODFUc2JmNy84ZU44L2pvdzFlMVU4?=
 =?utf-8?B?dm9WcXFaYUE3b29CSzJ1MHZCUkxJOU1Xdnd4N2M3NENMaHRKVHY0OEZJRkFB?=
 =?utf-8?B?UlVQRWpEL29Ya1lBZzRXNWl4WjlROGE4c0RXV3psRzd4WTUxRDY4cDVVak84?=
 =?utf-8?B?cXJ4L1ZyL0tLQzRtK211VzZoVGFkMTIwbFVFNDlmRHZBQWNwVWlFRVZhZnRm?=
 =?utf-8?B?RkZWMEcwcGlhUVdPSHJwMVZWMG9sRVlYQmFLY3IxWkJRQ1dlZExDY0tLa25V?=
 =?utf-8?B?bHBtay9MRXZzZGxoLzZlMXB5Mk9Oc2Q1MWlSS2ZoZkRzc1dMbjFiOVY5ejRn?=
 =?utf-8?B?ZXFtd0VkS2ZWWHY4LzdlMlBNMUJ5aWNNaURMVE45Q3hJUm9iajdscmQ4RWhR?=
 =?utf-8?B?T1BLc3VtVzVPNi9Xb0Z1SGVnTFBrRlpnYTBUQzhLaG55Y3NRN2lCaDlFbkt3?=
 =?utf-8?B?cStxV1NmdjY1Mm5XWEtrSlppeHN3SDVwaHFySUVQdXRTcGJVeDgwYW9MVTh4?=
 =?utf-8?B?di9JZnlkUytrVnZFT3NseGdIL0RZSExvcjBvN0Vkb04vdjA5cXRRcDZ6aWxB?=
 =?utf-8?B?S2k0SEdGM1NYVWx0RGpZOUlPR2h0VTFzMFk5dzJvU25wdllFOHQ0dVlkYkVT?=
 =?utf-8?B?VkNRdkxBakZISk1OSmlwdlhzT3ljb3ZlLytZWGJ3TFFUSUlqUHZBQnk0bEFr?=
 =?utf-8?B?cks3MGRjM1d3MTZqTXd2djJCMEVMZi8zVmplVU0yTENiV3VFeElQSzJwZkVW?=
 =?utf-8?B?VjBpdklReVdaL01rVEYrVWhqeUhyaUlIYXB6TzlQK3daQmEyVlUyaGp3N0Rq?=
 =?utf-8?B?c1Joam9SSzFwT2pBclZNdjB6aXdTS251Q1U1U1FxMkhTUDR0K0NXTktEMHQ1?=
 =?utf-8?B?Y1RZcUhGZVFjM2c1ZEtKRHUvZW1vT2dtWG90YzdrU29kWDFNcTduR0diVDdT?=
 =?utf-8?B?UXU2bUx0TjFpY1B0Z0NXZEFHKzk1eEJiYStDUWdaMjFOeGw1K0Y2TVc4OXhZ?=
 =?utf-8?B?LzR3WldFMTBmbmJvMWNsUUZOSVd6L1gxSWZXZjAyOFZrd09oZC9YYnY0T0Iv?=
 =?utf-8?B?aDVaVDZEemFCcFdQUm9Rd0dPU3h6cG9RQ3ZmQlg4UnhwSWxwOFR1VGRMcllx?=
 =?utf-8?B?cmZJY25xTEZCdCtIaDhma3RCV3UrSXZnbE5oZlpDNUd1bllBaDd3b0huNG13?=
 =?utf-8?B?RWpwTlZ0dEN0T3E5bjZXaFFDK1JsbzVHNDQwUEpqY3NyUTlNaEs0eG0wTTRI?=
 =?utf-8?B?azJnaGJjcFQxdG5uYnlBK05Hc0VrTWVreWhrdmNqRGdBUGg5VG9mbVdJZC9h?=
 =?utf-8?B?eCtQRlB1YkdnNXVTaHk2bFloQzJKN2kraVBBcEdMeXk5YjhLdGVtSmJONVY3?=
 =?utf-8?B?aHJ3UGdhN2NNWTI4VWNkajhLRHo3azU3Mm1JL0Z1bjFHdGpSZkJ6bHVxYVdp?=
 =?utf-8?Q?f8aIBw2Kp3vMoLjKzgMgyBhPO83qhjjeHoIJ5iontnOa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4673.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07399b29-53d2-4aae-3986-08dd425b7714
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2025 00:57:56.3369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5C7Uqdn5LvE2QWgSxE3kn6t195IL9PqLoax6oeVKyDiZvtvjHie/WcfPGOtmp56EfP8WAS8oxOY1Ak+SRYLGBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB5637
X-Proofpoint-ORIG-GUID: dEkWLmpUkJaulDnbcTbkezkPzrtmjNQ3
X-Proofpoint-GUID: dEkWLmpUkJaulDnbcTbkezkPzrtmjNQ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_09,2025-01-31_02,2024-11-22_01

SSBhbSB3cml0aW5nIHRvIGZvbGxvdyB1cCBvbiB0aGlzIHNlcmlvdXMgb2YgUENJZSBwYXRjaGVz
IHN1Ym1pdHRlZCBieSBKZW5pc2guDQpVbmZvcnR1bmF0ZWx5LCBoZSBoYXMgc2luY2UgbGVmdCB0
aGUgY29tcGFueSwgYW5kIHNvbWUgY29tbWVudHMgb24gdGhlc2UNCiBwYXRjaGVzIHdlcmUgbm90
IGFkZHJlc3NlZCBpbiBhIHRpbWVseSBtYW5uZXIuIEkgYXBvbG9naXplIGZvciB0aGUgZGVsYXkN
CmFuZCBhbnkgaW5jb252ZW5pZW5jZSB0aGlzIG1heSBoYXZlIGNhdXNlZC4gSSBoYXZlIHJldmll
d2VkIHRoZSBmZWVkYmFjaw0KcHJvdmlkZWQgYW5kIGFtIG5vdyB0YWtpbmcgb3ZlciB0aGlzIHdv
cmsuIEkgYXBwcmVjaWF0ZSB0aGUgdGltZSBhbmQgZWZmb3J0DQp5b3UgaGF2ZSBwdXQgaW50byBy
ZXZpZXdpbmcgdGhlIHBhdGNoIGFuZCBwcm92aWRpbmcgdmFsdWFibGUgY29tbWVudHMuDQpJIHdp
bGwgZW5zdXJlIHRoYXQgdGhlIG5lY2Vzc2FyeSBjaGFuZ2VzIGFyZSBtYWRlIGFuZCByZXN1Ym1p
dCB0aGUgcGF0Y2gNCmluIHRoZSBwcm9wZXIgbWFubmVyLCBhcyBpdCB3YXMgbm90IGluaXRpYWxs
eSBzdWJtaXR0ZWQgYXMgYSBzZXJpZXMuDQoNCj4gPiBXaGVuIGEgUENJIGxpbmsgZG93biBjb25k
aXRpb24gaXMgZGV0ZWN0ZWQsIHRoZSBsaW5rIHRyYWluaW5nIHN0YXRlDQo+ID4gbWFjaGluZSBt
dXN0IGJlIGRpc2FibGVkIGltbWVkaWF0ZWx5Lg0KPiANCj4gV2h5Pw0KPiANCj4gIkltbWVkaWF0
ZWx5IiBoYXMgbm8gbWVhbmluZyBoZXJlLiAgQXJiaXRyYXJ5IGRlbGF5cyBhcmUgcG9zc2libGUg
YW5kIG11c3QNCj4gbm90IGJyZWFrIGFueXRoaW5nLg0KDQpZZXMsIEkgYWdyZWUuIEEgZGVsYXkg
Y2Fubm90IGJlIGF2b2lkZWQuIFRoZSBpc3N1ZSB3ZSBlbmNvdW50ZXJlZCBpcyB0aGF0DQp0aGUg
UkMgbWF5IG5vdCBiZSBhd2FyZSBvZiB0aGUgbGluayBkb3duIHdoZW4gaXQgaGFwcGVucy4gSW4g
dGhpcyBjYXNlLA0KYW55IGFjY2VzcyB0byB0aGUgUENJIGNvbmZpZyBzcGFjZSBtYXkgaGFuZyB1
cCBQQ0kgYnVzLiBUaGUgb25seSB0aGluZyB3ZQ0KY2FuIGRvIGlzIHRvIHJlbHkgb24gdGhpcyBs
aW5rIGRvd24gaW50ZXJydXB0LiBCeSBkaXNhYmxpbmcgQVBQX0xUU1NNX0VOLA0KUkMgd2lsbCBi
eXBhc3MgYWxsIGRldmljZSBhY2Nlc3NlcyB3aXRoIHJldHVybmluZyBhbGwgb25lcyAoZm9yIHJl
YWQpLg0KDQo+ID4gU2lnbmVkLW9mZi1ieTogSmVuaXNoa3VtYXIgTWFoZXNoYmhhaSBQYXRlbA0K
PiA+IDxtYWlsdG86anBhdGVsMkBtYXJ2ZWxsLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9w
Y2kvY29udHJvbGxlci9kd2MvcGNpZS1hcm1hZGE4ay5jIHwgMzgNCj4gPiArKysrKysrKysrKysr
KysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1hcm1hZGE4ay5j
DQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWFybWFkYThrLmMNCj4gPiBp
bmRleCBiNWM1OTljY2FhY2YuLjA3Nzc1NTM5YjMyMSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWFybWFkYThrLmMNCj4gPiArKysgYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2llLWFybWFkYThrLmMNCj4gPiBAQCAtNTMsNiArNTMsMTAgQEAg
c3RydWN0IGFybWFkYThrX3BjaWUgew0KPiA+ICAjZGVmaW5lIFBDSUVfSU5UX0NfQVNTRVJUX01B
U0sJCUJJVCgxMSkNCj4gPiAgI2RlZmluZSBQQ0lFX0lOVF9EX0FTU0VSVF9NQVNLCQlCSVQoMTIp
DQo+ID4NCj4gPiArI2RlZmluZSBQQ0lFX0dMT0JBTF9JTlRfQ0FVU0UyX1JFRwkoUENJRV9WRU5E
T1JfUkVHU19PRkZTRVQNCj4gKyAweDI0KQ0KPiA+ICsjZGVmaW5lIFBDSUVfR0xPQkFMX0lOVF9N
QVNLMl9SRUcJKFBDSUVfVkVORE9SX1JFR1NfT0ZGU0VUDQo+ICsgMHgyOCkNCj4gPiArI2RlZmlu
ZSBQQ0lFX0lOVDJfUEhZX1JTVF9MSU5LX0RPV04JQklUKDEpDQo+ID4gKw0KPiA+ICAjZGVmaW5l
IFBDSUVfQVJDQUNIRV9UUkNfUkVHCQkoUENJRV9WRU5ET1JfUkVHU19PRkZTRVQNCj4gKyAweDUw
KQ0KPiA+ICAjZGVmaW5lIFBDSUVfQVdDQUNIRV9UUkNfUkVHCQkoUENJRV9WRU5ET1JfUkVHU19P
RkZTRVQNCj4gKyAweDU0KQ0KPiA+ICAjZGVmaW5lIFBDSUVfQVJVU0VSX1JFRwkJCShQQ0lFX1ZF
TkRPUl9SRUdTX09GRlNFVA0KPiArIDB4NUMpDQo+ID4gQEAgLTIwNCw2ICsyMDgsMTEgQEAgc3Rh
dGljIGludCBhcm1hZGE4a19wY2llX2hvc3RfaW5pdChzdHJ1Y3QNCj4gZHdfcGNpZV9ycCAqcHAp
DQo+ID4gIAkgICAgICAgUENJRV9JTlRfQ19BU1NFUlRfTUFTSyB8IFBDSUVfSU5UX0RfQVNTRVJU
X01BU0s7DQo+ID4gIAlkd19wY2llX3dyaXRlbF9kYmkocGNpLCBQQ0lFX0dMT0JBTF9JTlRfTUFT
SzFfUkVHLCByZWcpOw0KPiA+DQo+ID4gKwkvKiBBbHNvIGVuYWJsZSBsaW5rIGRvd24gaW50ZXJy
dXB0cyAqLw0KPiA+ICsJcmVnID0gZHdfcGNpZV9yZWFkbF9kYmkocGNpLCBQQ0lFX0dMT0JBTF9J
TlRfTUFTSzJfUkVHKTsNCj4gPiArCXJlZyB8PSBQQ0lFX0lOVDJfUEhZX1JTVF9MSU5LX0RPV047
DQo+ID4gKwlkd19wY2llX3dyaXRlbF9kYmkocGNpLCBQQ0lFX0dMT0JBTF9JTlRfTUFTSzJfUkVH
LCByZWcpOw0KPiA+ICsNCj4gPiAgCXJldHVybiAwOw0KPiA+ICB9DQo+ID4NCj4gPiBAQCAtMjIx
LDYgKzIzMCwzNSBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgYXJtYWRhOGtfcGNpZV9pcnFfaGFuZGxl
cihpbnQNCj4gaXJxLCB2b2lkICphcmcpDQo+ID4gIAl2YWwgPSBkd19wY2llX3JlYWRsX2RiaShw
Y2ksIFBDSUVfR0xPQkFMX0lOVF9DQVVTRTFfUkVHKTsNCj4gPiAgCWR3X3BjaWVfd3JpdGVsX2Ri
aShwY2ksIFBDSUVfR0xPQkFMX0lOVF9DQVVTRTFfUkVHLCB2YWwpOw0KPiA+DQo+ID4gKwl2YWwg
PSBkd19wY2llX3JlYWRsX2RiaShwY2ksIFBDSUVfR0xPQkFMX0lOVF9DQVVTRTJfUkVHKTsNCj4g
PiArDQo+ID4gKwlpZiAoUENJRV9JTlQyX1BIWV9SU1RfTElOS19ET1dOICYgdmFsKSB7DQo+ID4g
KwkJdTMyIGN0cmxfcmVnID0gZHdfcGNpZV9yZWFkbF9kYmkocGNpLA0KPiBQQ0lFX0dMT0JBTF9D
T05UUk9MX1JFRyk7DQo+IA0KPiBBZGQgYmxhbmsgbGluZS4NCj4gDQo+ID4gKwkJLyoNCj4gPiAr
CQkgKiBUaGUgbGluayB3ZW50IGRvd24uIERpc2FibGUgTFRTU00gaW1tZWRpYXRlbHkuIFRoaXMN
Cj4gPiArCQkgKiB1bmxvY2tzIHRoZSByb290IGNvbXBsZXggY29uZmlnIHJlZ2lzdGVycy4gRG93
bnN0cmVhbQ0KPiA+ICsJCSAqIGRldmljZSBhY2Nlc3NlcyB3aWxsIHJldHVybiBhbGwtRnMNCj4g
PiArCQkgKi8NCj4gPiArCQljdHJsX3JlZyAmPSB+KFBDSUVfQVBQX0xUU1NNX0VOKTsNCj4gPiAr
CQlkd19wY2llX3dyaXRlbF9kYmkocGNpLCBQQ0lFX0dMT0JBTF9DT05UUk9MX1JFRywNCj4gY3Ry
bF9yZWcpOw0KPiANCj4gQW5kIGhlcmUuDQo+IA0KPiA+ICsJCS8qDQo+ID4gKwkJICogTWFzayBs
aW5rIGRvd24gaW50ZXJydXB0cy4gVGhleSBjYW4gYmUgcmUtZW5hYmxlZCBvbmNlDQo+ID4gKwkJ
ICogdGhlIGxpbmsgaXMgcmV0cmFpbmVkLg0KPiA+ICsJCSAqLw0KPiA+ICsJCWN0cmxfcmVnID0g
ZHdfcGNpZV9yZWFkbF9kYmkocGNpLA0KPiBQQ0lFX0dMT0JBTF9JTlRfTUFTSzJfUkVHKTsNCj4g
PiArCQljdHJsX3JlZyAmPSB+UENJRV9JTlQyX1BIWV9SU1RfTElOS19ET1dOOw0KPiA+ICsJCWR3
X3BjaWVfd3JpdGVsX2RiaShwY2ksIFBDSUVfR0xPQkFMX0lOVF9NQVNLMl9SRUcsDQo+IGN0cmxf
cmVnKTsNCj4gDQo+IEFuZCBoZXJlLiAgRm9sbG93IGV4aXN0aW5nIGNvZGluZyBzdHlsZSBpbiB0
aGlzIGZpbGUuDQo+IA0KPiA+ICsJCS8qDQo+ID4gKwkJICogQXQgdGhpcyBwb2ludCBhIHdvcmtl
ciB0aHJlYWQgY2FuIGJlIHRyaWdnZXJlZCB0bw0KPiA+ICsJCSAqIGluaXRpYXRlIGEgbGluayBy
ZXRyYWluLiBJZiBsaW5rIHJldHJhaW5zIHdlcmUNCj4gPiArCQkgKiBwb3NzaWJsZSwgdGhhdCBp
cy4NCj4gPiArCQkgKi8NCj4gPiArCQlkZXZfZGJnKHBjaS0+ZGV2LCAiJXM6IGxpbmsgd2VudCBk
b3duXG4iLCBfX2Z1bmNfXyk7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJLyogTm93IGNsZWFyIHRo
ZSBzZWNvbmQgaW50ZXJydXB0IGNhdXNlLiAqLw0KPiA+ICsJZHdfcGNpZV93cml0ZWxfZGJpKHBj
aSwgUENJRV9HTE9CQUxfSU5UX0NBVVNFMl9SRUcsIHZhbCk7DQo+ID4gKw0KPiA+ICAJcmV0dXJu
IElSUV9IQU5ETEVEOw0KPiA+ICB9DQo+ID4NCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo=

