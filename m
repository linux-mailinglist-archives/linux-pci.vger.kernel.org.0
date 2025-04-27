Return-Path: <linux-pci+bounces-26843-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F79A9DEE0
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 05:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 112247A20B7
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 03:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA461FC109;
	Sun, 27 Apr 2025 03:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="XPay6CTu";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="HoYZx8ZC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE5B79E1;
	Sun, 27 Apr 2025 03:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745725968; cv=fail; b=XT8e3SkGpyGpbGQ8x0ZijNBXFjyp93XAKb+J0fcyi+aKNZyqVJwP58cq95NFMiYONZwTShwi2qsrHJPjaQtyYKzepiq89UHavHcKc/LirDdk+nBcZAIvoCVwz9uWjE+AQuW/yHwgou4JTry1kzSByQNN2mzsEyTevREr4BnH4f4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745725968; c=relaxed/simple;
	bh=z8I115DxDqGxGvBfNwfp/UGpqfjUsdoyXSSV0zQAVXY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gh36Wo2+WXNNxkoAMHBPdTGyOLcJoqA9jGZz4DdAcTcGovt1sjnU0mjbyJUBIgfrn62qkEbM7uUKzh7qUeZ5bqrP3+PR7qMe9qAT9wXB96bXyzdbMh2sLl2zKN61aMyMeNJmNYfTcBApvLaP11j1x3X47uN285i/8m5SlZhtiJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=XPay6CTu; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=HoYZx8ZC; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53R2KeoZ016875;
	Sat, 26 Apr 2025 20:52:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=z8I115DxDqGxGvBfNwfp/UGpqfjUsdoyXSSV0zQAVXY=; b=XPay6CTusLBM
	VwhRwJZVLCG6m3g8xSKRtD9NNJOrffioSOZy1cnWiv2bY8/5bPQY0LJmW9hszNHd
	sy43u2sumMziuWoRhVymLiaWRKKPfcRQDVDRX51UmLEoe2jUWEg97TeJFr2CXaq+
	/uDdzaTmse+OTDbiZYEd9cJLjeIPQTbJDAWzMRBQUtH1ZsOUnDz3fK7IzeIiq01q
	LXKdWfMBsrQJfnS+GpU38ntpIdJxdqUe42zOqpNrZqhudAWUFm2VFpfTuHLOFdNO
	QPxuZzw+n1xx2j0ZUyE9f3SI61Ta2qs5SMZ7hCkKoYwnLdO+h7VL1HqYnXvdm4JX
	z8YC8VWA7A==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazlp17012037.outbound.protection.outlook.com [40.93.6.37])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 468v1whs6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 26 Apr 2025 20:52:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TS9m7iLZ1RnExZnejtwQ/MEV1/jm2el03XweTq0PJiTr6OrN13eKUQDpL3nLaWBD/uwAPil7yBDuSsthLvunxwMbSCRpfh602EluU6Rfd5Y18JYqa6g6Rs/5yU0wNaicJsI7/82TTLe25gHnAEwLnuYL52A9++GUKnjfLssN/MJK98fnLmsUKfDzqYH6hPNfxFV1tToGUsH8cou1dzTg7CadG3KS1TbFT05YQ0PZeigPgDkE6FzyB/XPLWspVhhMizS6DSkMK3Pit19hezQMij7FBSMPcxITAeRggkyOIZrproPsK2N2c7TVbLsxPw7kmCG11yT8DT2/pmoeRYITuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8I115DxDqGxGvBfNwfp/UGpqfjUsdoyXSSV0zQAVXY=;
 b=HUvuZkZ3EB18dRlHoPfoOjpSiUJnJ41jaP2tvLsZ/GE5QSmZM0yy8iG7FAIAIEAoF9YIW/PAe543e3+CzNTeflo5QUFFlt6iYHw01TErGYCUAGLQjzgG9pzc5fB7abJbfuRy9PbT3OkMTR10qKHfV8wepZ0QuRX6ubHQcQP1X8iTBOM2MeJ4M0XQNY/b+v4S9Q9kGMOOx3crVFKVlul22yPsyyG7ZOV2cqTsAwCJrpNNVfpcrGSxtEzecMbFQCaXAcEqc1Cty4/13ndlpn2EQY9reEszDZCCWCY6Puo1ZWKN/AShn4/iqItSdWu7B5QMgWpvKvgXMnZiJM09vh1AKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8I115DxDqGxGvBfNwfp/UGpqfjUsdoyXSSV0zQAVXY=;
 b=HoYZx8ZCQj+S5AyvgWH25Q6AHOGag5/hYnuPp3t4YHCl7N4pVPvWloFXi56QGX1DxbubeEOoufC9JN+zhh62Prk6bVOjApmHSv/FpZcMFwA0M1Zx5+HL+c72CExUE6rWgY7PWDR1SBhIIlWNkGslYjtbotXHCHx5WGleDJ3RuRI=
Received: from DS0PR07MB10492.namprd07.prod.outlook.com (2603:10b6:8:1d2::21)
 by BY5PR07MB7315.namprd07.prod.outlook.com (2603:10b6:a03:200::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Sun, 27 Apr
 2025 03:52:13 +0000
Received: from DS0PR07MB10492.namprd07.prod.outlook.com
 ([fe80::44ae:7783:5194:c089]) by DS0PR07MB10492.namprd07.prod.outlook.com
 ([fe80::44ae:7783:5194:c089%4]) with mapi id 15.20.8678.025; Sun, 27 Apr 2025
 03:52:13 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        "hans.zhang@cixtech.com"
	<hans.zhang@cixtech.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com"
	<kw@linux.com>,
        "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        Milind Parab <mparab@cadence.com>
CC: "peter.chen@cixtech.com" <peter.chen@cixtech.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 5/5] PCI: cadence: Add callback functions for RP and EP
 controller
Thread-Topic: [PATCH v4 5/5] PCI: cadence: Add callback functions for RP and
 EP controller
Thread-Index: AQHbtLTqhrOj3n1VWEy0k689YBqH2rO0lFUAgAJQW2A=
Date: Sun, 27 Apr 2025 03:52:13 +0000
Message-ID:
 <DS0PR07MB10492918808B18BF4E619DE3FA2862@DS0PR07MB10492.namprd07.prod.outlook.com>
References: <20250424010445.2260090-1-hans.zhang@cixtech.com>
 <20250424010445.2260090-6-hans.zhang@cixtech.com>
 <25f5e8e4-1b64-478f-84ab-eede2c669655@kernel.org>
In-Reply-To: <25f5e8e4-1b64-478f-84ab-eede2c669655@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR07MB10492:EE_|BY5PR07MB7315:EE_
x-ms-office365-filtering-correlation-id: 2b73da11-41f1-467e-6b0b-08dd853ee511
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eUo3SVVyb3VNSXRlNkx2ZzIzNEhaN1NVc0h5UE5ESDQyTlplNHVSVWtRYmp0?=
 =?utf-8?B?QmE1U0s0TkV4NTlPZlpFL28wYk5RbXVYdGFQY2hwbFRYSnFxRUg0ZFFrNEc3?=
 =?utf-8?B?eUpOdmF0UWlydGxPaDFqZ0NEd3lFU24rWUQ2ZUxGQ2g4UVBUQi9PMVRFNnV1?=
 =?utf-8?B?WlZiYnplbi8rd1B6QUFzSzZsL3hhUStsUVBld1d3OWxOK2xwa2hKY0N4T0Y1?=
 =?utf-8?B?YVlXNUNVd3JTKzFSQ0RrRkliNCtLOGpBRmNJbC9WUEIxbTkvYUNYQm00WkpW?=
 =?utf-8?B?cXlpZFBCTzlFSk5NVjg0SDAxNVd5TnNBd0NZK1kzWisxSzcxNmw4YWhqUGRS?=
 =?utf-8?B?OVBhekJjblRUYXRuSlRJRFdORWpvSWNwMDk0aEdES3BmRWdvTlowUTY1dkIx?=
 =?utf-8?B?cklKQmVJNmllVERaVHdqcnd3akVPNVVVcFdkUElyS2p1aU81Qkk5YVZIKzU0?=
 =?utf-8?B?VjJCYXpaNENTdGhPRnZ5WVF5K3VKeG1GMzVoVTNYK1I2YWZ4c1pFWE5EZU1q?=
 =?utf-8?B?MExvZkZ6eFFwNXA0SW5ueTh2RVlYcnZmVC9LRUY5ZTRIOExJNjZaVVNZRVRE?=
 =?utf-8?B?TFdCbmtXKzNXdnpZdHE0ZzQ3alNWbk1RRVN5eDl6VzFiSDloY1B3a05nV3BV?=
 =?utf-8?B?MnNPUlZJMC9qRVVFb3pJYjErV2gxZ3BKck9KVk9xTlJKMWNMcEEwdGRYZi85?=
 =?utf-8?B?OGg5YU5HRUc5SjdIRkIyUkFHTWd5SnRmM05ZdzhOV2g5cmUxdStTZkdkczll?=
 =?utf-8?B?Rm9kTjNtWmppK0ZjMkU5OHdBa25zTXpPcmw1Q0hnSDR3d3B5MmpFWXM5cnNt?=
 =?utf-8?B?RGJIYTN5VGRuUjJ2U2VVNHhrRlFGRlgzSGRRdXFyeXBGQ1Vrb09BRzZBNitO?=
 =?utf-8?B?MDllSmVDNUdFcG14Y1lJNmNEdzhLSkc2M201dGg2eDBUR1RnNnlzbzg4K1Ro?=
 =?utf-8?B?TURQcCtNdHY4dmlaZTB2eFFmeXJkRzlCanpoc2czbUQ4ZUJKVkw4aE9CeklQ?=
 =?utf-8?B?TlkrcmxlQTY1NEJlYkdEUlZOc2llbVBOenphamRuSmRkWFUwM29iM0RSZ1hJ?=
 =?utf-8?B?ZDBXYTFoQ0hUSmNIbEJyUm9tczd2TkNDYTQ5VWRaU01kVDNhL2xxaUNnQVdU?=
 =?utf-8?B?cXNaYVVmVzBVaUJFVDNhMjZoWS9EY3ExN2xYWjY4b1RhT0U4NmVaekpGUEtk?=
 =?utf-8?B?UElBTERmUlFpanFpY2JMQTFLSWZQbGVHZVgxRU92OEdwak0wOGhQQStFOFRj?=
 =?utf-8?B?ekxwYTAwQ0s5dU5KWFJRa2FHY0N2aWlaM3lsZjMxdkFWb3B1Z21IU0pNSUtP?=
 =?utf-8?B?WTVsdFB1SEpQN0ROMUpuTzVXQkVLczlnc3dWS3VGc0syV29rdWJVTHZQdzh1?=
 =?utf-8?B?Z1Z4NC9GYTRTdkVWem9hc1RWTTVnRVN2ZFQwQ0xwOElWV1dvNmNpRzRSaE1s?=
 =?utf-8?B?SUljUUh6QURzekxpV1hVVm56K1BiUGNYa3dWOG1EZGdubkFRSE5FakRUU3pT?=
 =?utf-8?B?TkJWN0NyMkNiOGNQd0hFV2liQjJKT0kvcHNMYXRMMndXUTh1TTF1R09pUklh?=
 =?utf-8?B?MXYxZGFHemhhUVdndjN0Yit4ODJOZFl6clBodVNpd2VkVnZjbGRIUXdkQlhE?=
 =?utf-8?B?NDFRK1pCRmw0MnNhcHN4TDNtSlNIdnlNeWtwUlFWeTFjOS80bTY3SHU4TDZu?=
 =?utf-8?B?WTZrWlZVbENPRXZNTm1UVzVOcEpvMnRoQWhHZmN4Smd1NlhNMGM5U2o4aFdy?=
 =?utf-8?B?SVJ0QTlRT0NFZ0wwU0ZMcDBzUjFnNFFtYld0ZlQxN21mVklzeU01NkZIS1lO?=
 =?utf-8?B?MDRsWmZCYURXRjZUVGkyRmVrWXpQbDFQWi8zQTQwNnA3TG8yeGprRXR0bStQ?=
 =?utf-8?B?QVJWVW9xOCtxT1d3QWRHRVZ5c1c2cEFLTXpNRWhmS3dPRkZ1VWpLNHl0V3ZD?=
 =?utf-8?B?WTZZcjJDVnVHeHIrYVlNS2ZONjFmZVBXeXJvZm0rWDJMaUQ2Ynp3ZE5EaWZD?=
 =?utf-8?Q?qE6Qx/lsVrXqFIktbjuHcHa7D17pv4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR07MB10492.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d3N0Qy8rWlpCVlRxMjJIN2VLKzB3Nk8rRytrL0ZPYzJxSmFTa3B5R2I2RFB2?=
 =?utf-8?B?UGN5L3grbHV2RVd2RkJPamtlc3dXZDJKTmVhaU9jTEMyRFhUN1R2czRiY0lM?=
 =?utf-8?B?bTBTSmEwMWY2ZlF3eFhEK010UGthRDdDYXJKOFNKbTQ3a1BsR2hlTWVkOVBt?=
 =?utf-8?B?Q2F6MERwek5tem9EMEFvMTZCYnc1Tk5xZ1RsaVhvZ3BJTXVoYkRrYUovOFUr?=
 =?utf-8?B?eXI0WUNWSStlcE1ZdXlrNUIyTjNoSm5LTlJuTjhEMWtCR01QVWxmbWtTdWgz?=
 =?utf-8?B?QWxld2FwQ2ZnYWh5UXhwdWJEUk1zUmRjK0pVaFl6WjhnQmJ3cEV4Tm1BbVQr?=
 =?utf-8?B?ZmdFWFAvOCtHV0lacldiSFJkenVPaTlGZG15YzVRanpGY1dXWmc5TXI5emJ3?=
 =?utf-8?B?MUxUdVhFdStkdHZUZmVGdTJhREVUM1VDVTJiUkFaOUw4WmtkOXRieEhFRUF0?=
 =?utf-8?B?Q3crM3o0WXpQZ09sbnhYNFluVElScEVudGtaNVZyZHVqSnhIWnZEaVpnNTdw?=
 =?utf-8?B?UkpSNEFlcTF3M0dkbXp2b09vTEEwOEg0NnI3ekJEak5QUmNLQkN0R0ZJV0Ey?=
 =?utf-8?B?dEJhTVFaLzlmVkhncGkzeU9zU0lnYWdBMUlXa1NRWUZEMzFSZXNCYmwzYUpz?=
 =?utf-8?B?eENhbFJTNEFMaUU0Z2N4ZVdaVTFCbVo0cksyN2t2Z3dTQWdyWGt6Rm5LUXlt?=
 =?utf-8?B?TW5pMzJjVVY2RlJEV3NYS3BiMFpOYmJpcXhRMHpIS243SS9tc1QvaEhrYm5S?=
 =?utf-8?B?TURIMUdRRzJPbXJhdHpiMDBSdGt4cHRNNFVkcFZmcDhZQnRIV2lZWGEyayti?=
 =?utf-8?B?UUtmYzJKalk2SkRzZEQ1YzRWQXg4bXFtdEg2QVA1U1drdW05WWp3YitaOXZX?=
 =?utf-8?B?SHhTNXZrNFpxY3BWZEFrcTg5OUswaFl0Nklrb0pjZjhFQ1F3alh6a3FMdU92?=
 =?utf-8?B?OGhIcVVWY3RXeFVXa1hrOUFjNG9XVTJLVXk5ekF1TlhaWlBkamVQb1pKTHM1?=
 =?utf-8?B?RXNiK1JIMkorM2xkL2plL0hWaTFBMDI0eGFvU3pzNGJ5N1lLT1ZkVzBwSHkw?=
 =?utf-8?B?dVQrOFpQQVNwdDAvM252MkdRWTQ0L1dwTmlKdlZjWlM1aW13R3UzTktlbUpU?=
 =?utf-8?B?Q3N3bWdOTEFSZXZhUFp3bWpBUHozOFRjSHdUbG5TRm5iVGJrYlN4a0h5ZS9R?=
 =?utf-8?B?c0RHdUV4ZDQ3RHZNdWFCSTgxZGROYW9pei9tYXA1aVloRDByNWpKT1krM3Uz?=
 =?utf-8?B?VjFENTN2dXJhZFl3ek9OOUJvRG93Zzg0bDdkRFV3MGtkcXdyMWpyVTZwR0pk?=
 =?utf-8?B?YTNxbFlNeXJZd1duOFpGVHR0U0o1ckZYRUQ5VGpubWxRbGNzV3pMNjZ6aXZz?=
 =?utf-8?B?M3poczB5UloyT1Y3MFM1S0M5aHZpQS8yNG5iMU9vYzBxMjg4Tjh0MWgxL1lu?=
 =?utf-8?B?ZlFZb0xIb1V3ZnRRMW52WUZkVXZzYVdDSjRUUjhHWVhSUERsYjNrWWpONHRq?=
 =?utf-8?B?dmtEczNuZWxhSzJJNFplbnkwSjFTZEdvTW4zRUxPamcrSGplcGtaRHJ0ZzBI?=
 =?utf-8?B?RThidXoxZXpUaU9zRFEyTmcwT3p3QmdlVm40WFFMZDlFeHlRT1VKaWtCOEpq?=
 =?utf-8?B?Y3dhZHZlMnBpM0RHSlg4K2pnemhjUDgramUyem5wVHgxZXNUdW1rN1FnRmhY?=
 =?utf-8?B?NEtXek5ZdkUvRG9aVEptVlJ5OFRLWHNZcXNhcDRpNEk1ZGZlUkpUanliZ2RT?=
 =?utf-8?B?Ym5HaVZtN0xVVkJkcFlBTmEwS1J2Q3Q0aEtUMFpTeVVrVFhNalBuM3JBSnUr?=
 =?utf-8?B?QmZCTkU1emR3aEcwVFNHSUpkdkZmbURIbS82WVZBYzNya3FqZ0U2K2xyWFBa?=
 =?utf-8?B?L2NKakVDTlVlMWNUYldsamtlMzlBUjdnaTgvM1M3WXVLSmFkV1NTVzBLZEtP?=
 =?utf-8?B?dWlMY2RHT25EMlliVUZhRXcrR1Jadm9SQkZ3aDRqTW1WUnY3NlFzMkpYQzkx?=
 =?utf-8?B?dzRIR1VRcGp5MHR2akpBMEVvY3JjTHR2ZU01TnZnYTJ1czhOK05haE8wVnlu?=
 =?utf-8?B?VkNRaHZRNVZXejdPbXFxeWQ2aFc1WFlOeDhBUEFURHdhSXI3QVN0cDFLTkpm?=
 =?utf-8?Q?ns6wx1B6T97PZPuEQGx5cevYl?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS0PR07MB10492.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b73da11-41f1-467e-6b0b-08dd853ee511
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2025 03:52:13.3913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v6RPK4vBg7BRXZp5yhAcdr4xTzT4I/TO8YqZakC44FN7Lh3Bjj9em9UI2/aY+7uMWnzpl8W0Ndh2qjBJDxWqFm+hmCMeRrZWOw+BhD7+3y4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB7315
X-Proofpoint-GUID: VB6O7VQEoxVKPpBv1g4Hbh_xVAaZw9l6
X-Authority-Analysis: v=2.4 cv=SJdCVPvH c=1 sm=1 tr=0 ts=680da9f0 cx=c_pps a=dnQYvCYIB+Ymp8NUOuD+qQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=Zpq2whiEiuAA:10 a=wKZJZcPKN9drUXq8GXMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: VB6O7VQEoxVKPpBv1g4Hbh_xVAaZw9l6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI3MDAyNyBTYWx0ZWRfXzA9QJiUeSKyz AzJj3ZZVjoHj60E6VohLo7HmhhHVr7+auDL5e6RLsj5dbm77/DpFaNl+up1ds9oMgSpD0wHlesu CEE7V1P+Xa7B4oBqvCAEFDvXWzv72NjTMXkRsliVxkRnV4wWeVyp6LJ+g2XgAMd4LtK4ndpQGe0
 SjOoI6gmqeFbQplEfqIfju0FGB9VAmEFgghnfKgD+qGs56zx5KaKbLMWt/ugeL0c3Bm2mWd0sJ/ Sh5aUp2fkWorFWdYVrvGfxw2F0Ldlk4ViAJOWGIX1kdZKmmBhnEBBbjAHCVohYCDXSpksStURnm lYjltKdMiOWRr/pquzoI7r1xOgUde5ebf979x4gQiABJX4LS2J1yLxvfnJWcQSlPovbimrh+f79
 SHLJhK8qfNlrOjUZHnU8vuBXPnq/GmteSo4t5W5ukvJNhUUfAeX5XRUfsqRhte1a//R0XD9Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-27_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504270027

Pg0KPj4gLS0tDQo+PiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9jYWRlbmNlL3BjaS1qNzIxZS5j
ICAgIHwgIDEyICsNCj4+ICAuLi4vcGNpL2NvbnRyb2xsZXIvY2FkZW5jZS9wY2llLWNhZGVuY2Ut
ZXAuYyAgfCAgMjkgKy0NCj4+ICAuLi4vY29udHJvbGxlci9jYWRlbmNlL3BjaWUtY2FkZW5jZS1o
b3N0LmMgICAgfCAyNjMgKysrKysrKysrKysrKysrKy0tDQo+PiAgLi4uL2NvbnRyb2xsZXIvY2Fk
ZW5jZS9wY2llLWNhZGVuY2UtcGxhdC5jICAgIHwgIDI3ICstDQo+PiAgZHJpdmVycy9wY2kvY29u
dHJvbGxlci9jYWRlbmNlL3BjaWUtY2FkZW5jZS5jIHwgMTk3ICsrKysrKysrKysrKy0NCj4+ICBk
cml2ZXJzL3BjaS9jb250cm9sbGVyL2NhZGVuY2UvcGNpZS1jYWRlbmNlLmggfCAgMTEgKy0NCj4+
ICA2IGZpbGVzIGNoYW5nZWQsIDQ5NSBpbnNlcnRpb25zKCspLCA0NCBkZWxldGlvbnMoLSkNCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9jYWRlbmNlL3BjaS1qNzIx
ZS5jDQo+Yi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2NhZGVuY2UvcGNpLWo3MjFlLmMNCj4+IGlu
ZGV4IGVmMWNmZGFlMzNiYi4uMTU0YjM2YzMwMTAxIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9jYWRlbmNlL3BjaS1qNzIxZS5jDQo+PiArKysgYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2NhZGVuY2UvcGNpLWo3MjFlLmMNCj4+IEBAIC0xNjQsNiArMTY0LDE0IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgY2Ruc19wY2llX29wcyBqNzIxZV9wY2llX29wcyA9IHsNCj4+ICAJ
LnN0YXJ0X2xpbmsgPSBqNzIxZV9wY2llX3N0YXJ0X2xpbmssDQo+PiAgCS5zdG9wX2xpbmsgPSBq
NzIxZV9wY2llX3N0b3BfbGluaywNCj4+ICAJLmxpbmtfdXAgPSBqNzIxZV9wY2llX2xpbmtfdXAs
DQo+PiArCS5ob3N0X2luaXRfcm9vdF9wb3J0ID0gY2Ruc19wY2llX2hvc3RfaW5pdF9yb290X3Bv
cnQsDQo+PiArCS5ob3N0X2Jhcl9pYl9jb25maWcgPSBjZG5zX3BjaWVfaG9zdF9iYXJfaWJfY29u
ZmlnLA0KPj4gKwkuaG9zdF9pbml0X2FkZHJlc3NfdHJhbnNsYXRpb24gPQ0KPmNkbnNfcGNpZV9o
b3N0X2luaXRfYWRkcmVzc190cmFuc2xhdGlvbiwNCj4+ICsJLmRldGVjdF9xdWlldF9taW5fZGVs
YXlfc2V0ID0NCj5jZG5zX3BjaWVfZGV0ZWN0X3F1aWV0X21pbl9kZWxheV9zZXQsDQo+PiArCS5z
ZXRfb3V0Ym91bmRfcmVnaW9uID0gY2Ruc19wY2llX3NldF9vdXRib3VuZF9yZWdpb24sDQo+PiAr
CS5zZXRfb3V0Ym91bmRfcmVnaW9uX2Zvcl9ub3JtYWxfbXNnID0NCj4+ICsNCj5jZG5zX3BjaWVf
c2V0X291dGJvdW5kX3JlZ2lvbl9mb3Jfbm9ybWFsX21zZywNCj4+ICsJLnJlc2V0X291dGJvdW5k
X3JlZ2lvbiA9IGNkbnNfcGNpZV9yZXNldF9vdXRib3VuZF9yZWdpb24sDQo+DQo+SG93IGRpZCB5
b3UgcmVzb2x2ZSBSb2IncyBjb21tZW50cz8NCj4NCj5UaGVzZSB3ZXJlIHJlcGVhdGVkIEkgdGhp
bmsgdGhyZWUgdGltZXMgZmluYWxseSB3aXRoOg0KPg0KPiJQbGVhc2UgbGlzdGVuIHdoZW4gSSBz
YXkgd2UgZG8gbm90IHdhbnQgdGhlIG9wcyBtZXRob2QgdXNlZCBpbiBvdGhlcg0KPmRyaXZlcnMu
ICINCj4NCj5JIHRoaW5rIHlvdSBqdXN0IHNlbmQgdGhlIHNhbWUgaWdub3JpbmcgcHJldmlvdXMg
ZGlzY3Vzc2lvbiB3aGljaCBpcyB0aGUNCj5zaG9ydGVzdCB3YXkgdG8gZ2V0IHlvdXJzZWxmIE5B
S2VkLg0KPg0KPg0KDQpJIHdhcyB3YWl0aW5nIHRvIGNoZWNrIGlmIHRoZXJlIGFyZSBhZGRpdGlv
bmFsIGNvbW1lbnRzIG9uIHRoZSBhcHByb2FjaCwgYmVjYXVzZSB0aGlzIGFwcHJvYWNoIHdhcyB0
YWtlbiANCmJhc2VkIG9uIGFuIGVhcmxpZXIgY29tbWVudHMgb24gdGhlIHBhdGNoZXMuIFNpbmNl
IHdlIGhhdmUgbm90IGdvdCBhbnkgYWR2ZXJzZSBjb21tZW50cyBmcm9tIG90aGVyDQptYWludGFp
bmVycyBvbiB0aGlzLCBJIHdpbGwgc2VwYXJhdGUgb3V0IHRoZSBlbnRpcmUgZHJpdmVyIGZvciBv
bGQgYW5kIG5ldyBhcmNoaXRlY3R1cmUuIFRoZSBmZXcgY29tbW9uIGZ1bmN0aW9ucw0Kd2lsbCBi
ZSBtb3ZlZCB0byBhIGNvbW1vbiBmaWxlLCB0byBiZSB1c2VkIGFzIGxpYnJhcnkgZnVuY3Rpb25z
LiBUaGVyZSB3aWxsIGJlIHJlcGV0aXRpb25zIG9mDQpjb2RlIGJ1dCBmcm9tIFJvYidzIGNvbW1l
bnRzLCBJIGJlbGlldmUgaXQgaXMgZmluZS4NCg0KSSB3aWxsIGxlYXZlIGl0IHRvIEhhbnMgdG8g
c3VwcG9ydCB0aGUgQ0lYIFNvYyBzdXBwb3J0Lg0KDQo+QmVzdCByZWdhcmRzLA0KPktyenlzenRv
Zg0K

