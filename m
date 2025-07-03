Return-Path: <linux-pci+bounces-31324-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F68AF6732
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 03:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9F2522C1D
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 01:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C48C2F43;
	Thu,  3 Jul 2025 01:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="nCmOpnlC";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="X44nf2bf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEDE2F32;
	Thu,  3 Jul 2025 01:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751506540; cv=fail; b=EevAy6Bvck2MTaz2cZvv5WqK66GrP+dU7Hw0fPi7zpON/w8qZzWdDs5/D4UyRq7s2uRVrGdwYHlai62+ggg9CA98ztAAGyunhfi/L9BDhXhKGCnVypyMjkTMrckE9n7Q2zT5p1rSsrV52TPUxI1W+XTbI1xmnfZU4YrQLS+qN5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751506540; c=relaxed/simple;
	bh=4CQpe/9BH1k1I9drRNh/uAouzYc0I2q6G3laE7wR3Rk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NlsrjTbi7oMHLJRdr0og/dV/8U3on0qHm01oMLYi1WRDFuntxcvFgcjZmLQ8MJWvkcUwSWQW3ZljIcg0BWOjKWx9xpeqYNwz5+MwlMG6tIMVjMfiKID33yp+CsXxmuTA1xpYoz+4QLwdM2YoFjKrK07tp/zUza/OmfS0YhA4pFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=nCmOpnlC; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=X44nf2bf; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562M2Tso032520;
	Wed, 2 Jul 2025 18:35:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=4CQpe/9BH1k1I9drRNh/uAouzYc0I2q6G3laE7wR3Rk=; b=nCmOpnlCrqBH
	yUAM+O+KzI9E2QVhc9PyqOV5j4E+FDjnSjhHt3xrTJJMv4l3Y0uUn9mbbQOHTuns
	UvnR4O8eb7rBT5qouQJ7KVyuB2mW33NqplWIA2qaRmXxzB1kkssCISOjCBDkTW7d
	8nunKHlylFiIrTf/cY1gxhGEcockyJYfF4894ML7zpAZwWfhw3G30hGWDOsDdOje
	6/J0VstJH9/rmXu0qXhjHSbPir8gkUMvDP0aSVycjxHJoPHhAM84nnrsAfwGq/bR
	45EJZk17wf4/xCDQE8Tmnt4oqU011Vueb/yy4HPqJyZwSem4PxBZlqOJQmXS84jS
	RQxnWlmftA==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010014.outbound.protection.outlook.com [52.101.56.14])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 47jc00aagy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 18:35:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KhSal6lm+WL4en7BPT15DUIOGk4yhe0yaodrHClSIQjYtepd3eHoV1VYJqcwdRIVW6Lq0Lq75balC5hfDWRHi0upOpNw4eAMKdlKB+rdj7Nq0VoHAZgaxYHsyzD8fgFTv6W6erNVwYxJKBe3vn3gNG9XXznE53pUa1Yn3QeTUMXf2P1BRgOGiRP+EFEuRNtsk78qdmVmZ6b5MF3JZHQubRMFWnHRsr/DVSGHYmpQjXjyX195hYAs5ZGV5spYHHKJAvQN8XJyUuhq2jYWEwJDFsB/fJn6zGmbRma8ErqvU96Qv95mxgZp65+1cwusktAUCFOBlEhS0g5wCbB4ZiqZcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CQpe/9BH1k1I9drRNh/uAouzYc0I2q6G3laE7wR3Rk=;
 b=nxMCLhBdxYomWaMbE3TBbJhAf8/gkAVA2MWcsYut/rMB1ag1Ozu484VKMeQj6P3BI+AJmhSrgorJDELu+ubxSNmAP/8JTXUI63f9/DXKh8DM/yY0q5+xCJ7RPYnhMsAc18DJt7DD67IdAEsYFDxgscK9RMHz2ZJc30Q+5GevYYJmyxolpsOjOf/KW3yfn0XPID0CABc9Tf0ZJEXi+hwyc+Mw7oGTOOCGKgcTTof2x37nizgbIxZ6fE5IsLjT9lhGJQHrF5dJ9vopl7lH3Vh3fRUf9gvJuGjpzbuysl2UKxkXWp+OjJlhBgt/IzabjW5ljo1AJpXn2N5KXTTGt6orHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CQpe/9BH1k1I9drRNh/uAouzYc0I2q6G3laE7wR3Rk=;
 b=X44nf2bfv2Hx2N2yMEcqek9wfO/rbboTOs19g9PJDYZ0nR9nfCt//NIBmuT/vjbJM8f7Ku6OqgRCrgE5qEqmyWdwUzbEWTB2ksTXgZIZbmstIK8RmD6WizSsGYLPvcfUygmDqPNQQ7YTv7qxS9EF8GREcUqI2c/ePWM0sRNMvsg=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by BLAPR07MB7747.namprd07.prod.outlook.com
 (2603:10b6:208:299::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Thu, 3 Jul
 2025 01:35:06 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec%8]) with mapi id 15.20.8835.018; Thu, 3 Jul 2025
 01:35:06 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Hans Zhang <hans.zhang@cixtech.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "mani@kernel.org"
	<mani@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
        "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "fugang.duan@cixtech.com" <fugang.duan@cixtech.com>,
        "guoyin.chen@cixtech.com" <guoyin.chen@cixtech.com>,
        "peter.chen@cixtech.com"
	<peter.chen@cixtech.com>,
        "cix-kernel-upstream@cixtech.com"
	<cix-kernel-upstream@cixtech.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 01/14] dt-bindings: pci: cadence: Extend compatible for
 new RP configuration
Thread-Topic: [PATCH v5 01/14] dt-bindings: pci: cadence: Extend compatible
 for new RP configuration
Thread-Index:
 AQHb6XW6OLhXudgydkKfwI+xEE1N5LQbTsYAgAAJBgCAAABtoIAANDqAgAGeEoCAAiAsAIAAVgcw
Date: Thu, 3 Jul 2025 01:35:05 +0000
Message-ID:
 <CH2PPF4D26F8E1C29A09F1B6C6608DA3145A243A@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
 <20250630041601.399921-2-hans.zhang@cixtech.com>
 <20250630-heretic-space-bullfrog-d6b212@krzk-bin>
 <afeda0c7-1959-4501-b85b-5685698dc432@cixtech.com>
 <CH2PPF4D26F8E1CC95F84FFBB099955A065A246A@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <31415739-88cd-4350-9fd4-04b99b29be89@kernel.org>
 <CH2PPF4D26F8E1C590A00940496AAC9ED75A241A@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <225ea9f2-dce7-498c-a2a4-5b40471b8e2a@kernel.org>
In-Reply-To: <225ea9f2-dce7-498c-a2a4-5b40471b8e2a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|BLAPR07MB7747:EE_
x-ms-office365-filtering-correlation-id: 492d4a31-7fd6-4155-aa13-08ddb9d1d6e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QjNDeCt2em01Q3FubitUQkEybS9NVEFHSDYxUUZqdlNXNEhqZXBOZndBdE12?=
 =?utf-8?B?VmltNUZaQ2o5aDkxSHpnN2E3TjdVSlkzNmo4SUw3d28wcUo2U2RsTkZWRDQ2?=
 =?utf-8?B?aE9NTkZmRm80VWJSNW9jYmtpMmFrNVRORHU5Zis2SkxLWks2Sm5pOWpOR3Jk?=
 =?utf-8?B?Y3ZwcllxQVh1MUk3Zk9OeVBOakZDVFpRajhreFBKcEJCY1djL1c0ekpzWENL?=
 =?utf-8?B?UnFVdW85V3JIOE1pbnNSbVdrdFloSTFSVGhUWXdnVlR2T24xdTFSaTNkZ1ZG?=
 =?utf-8?B?aEljT3hHdkdaNE5QRWNxQnlLQ1lTTUZHK3NNK1NZbHRJUURPbFFwbnFVYTd6?=
 =?utf-8?B?YkhQcW9CQjdQS3lDTnpxYWtZSzBIcnpzZHk1aDFWWG9RMmVOZzFIQTJvZzNR?=
 =?utf-8?B?VysxN21qRC9STkRwWXhDeHQwSzIwc2VFZGExMW9BRThlY3NTYUZ0bGhKeWxt?=
 =?utf-8?B?TFlRZUowTnoxQkdKZHVjWWZGUnJNUFVqQWQ4VTBaRkpnV3JQVVhlMVI4cnR0?=
 =?utf-8?B?MXd1a0lWTVpxeWl1MVR3N0Z3K3hnbUp3bG5kKzRMdU9QWVhnSmp6S211RjNi?=
 =?utf-8?B?L080VUtUa2ZSY0d4RFdPNkZDQ1gvZmxLbndjNUo0eVdxdWRpelRiY3ZYN1k3?=
 =?utf-8?B?cWc0akRmMWN4cFRrZkdWNlVtUk9PVmtmNjdyRGxQa3JFZklqVGRRbzFZekFP?=
 =?utf-8?B?TG5SUnVJZzByZ2RmZUNtL1N4NDlNSmI4Q0hWaEdORHR6MFA4azhzeHBndFBh?=
 =?utf-8?B?WnNUWHRLSU1JR1p0TjlCdStsaXBzNUU2bDVkMk9pQlRRUGpLTUVSL1NubVdm?=
 =?utf-8?B?dkF1dGREa2d4elZ1YmVSZWFCWFRLTDhMZlZxaUZNN2F0RUpGNTIyMWY1RmZ4?=
 =?utf-8?B?d1BqWmdhMHRKWm96UFNweFRNVzIrM1ZrTHJyZGg1RVVxcWVubXBUM25mMkcv?=
 =?utf-8?B?S1BjbE9JQWxUWHduUVFEclFNbEZwNi9DdVYvQXFBajFOcEpWMXdpcXllcWJ1?=
 =?utf-8?B?ai9hek03aVBaNEsyVnNsczhDYSttWHMybzNORVlLL2hicXdSbmo5Q1ZTWFdF?=
 =?utf-8?B?MDhQWWtmZTVGTitYT2RNeTU2QXUzbGl2cFFxdGVhaDJaYlh6QlhXelpPejYy?=
 =?utf-8?B?MllVWFZhai9KQVYrYzkxSElBNUttT2xhaU94YTVkanI4SEZYZW5wU3VMd3Zw?=
 =?utf-8?B?ek5HZWk5NnNtaEpDR1lydEt1cHdRT3NqRG8renYyNHZFNVVPU1p3TUlneGJv?=
 =?utf-8?B?SE0zRzNpWEJpS2xMK05kUllxWjAxcGRaOEpIRkVEYjFrS2RCR0FlSW0zeWZr?=
 =?utf-8?B?U0RQM1hNbkYvdkxoNmxCNEdmUStuSUtnQXA2bHRpeWIrRzJsaW1Ic05jcWtN?=
 =?utf-8?B?aUtSUzBTenJwcHZYWmg0UnY4MWVXN0RHSGdQQ2l4L3cyKzRPaGZhSnJpUWw4?=
 =?utf-8?B?QmFRUHlySVV6L252eWFOdmg2cm1yVTJsMDQzS0RGZnRheGJ1MDgwclNUQ1l0?=
 =?utf-8?B?cVFBbGhFSm1hY0lFcUlCblByMUQ1ZlBGZXBRenFQUmJXNVl5VGpuWE90YUJ5?=
 =?utf-8?B?SkMzYVRndjkvSU8xQjA3TmhlVVpWU0RyZDdKT3pnbjFWQnlhbmdzMzFkakF2?=
 =?utf-8?B?eENWVUVHUEFKNmRPcnd0ejMrYmN1QUp2V1R2bTVHdEYwb0lvazNub1pZQVZ1?=
 =?utf-8?B?MjZEaEdzdXZIV2ZMODRLSTZaZGxBQ3BMWFlkL05uOWl6aDdrd1FKM0ZhaXFw?=
 =?utf-8?B?RXpCT3pDeVIzT256c2pUcGViMldqbDI3T3JMVjRDM3h5REg0N1lWeTRuVUlN?=
 =?utf-8?B?bVQrTWV0N2xqRVYzTjZMNnlZL0ZDLzQ1YkZrWlp5d3g3Q2J3Wjd6cTFUcGhm?=
 =?utf-8?B?c0FQbjNWNXBiN1o0UGJYTWM3VGZNTUtQOXJyYjlDeWJvWW5od3d2QXVkUjJ2?=
 =?utf-8?Q?VCNLseCQdmk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cmJ1WEEray8xRVdYWm5ZblZpSkxneE5lMDJBQ1IrZGNJMGhSNGNHcWVoa2ZR?=
 =?utf-8?B?S1ZCRCtYYXRDRTRFOEVtemhFNjJWUmJuTmFEODgvNnZPcktBU2Y3Ulh1ZU9S?=
 =?utf-8?B?ZDFDWnlVL2R2NnhUbGppeE1TMjBaQkFadUtMQzJKdElKWU1Yc1JYT2RBN3l0?=
 =?utf-8?B?a0prcmtLMXZacExmWFRNYzBGQy9Ib1RDOWtGTUZrN21SMXpwY2pSZnBjUkZE?=
 =?utf-8?B?cGhMY1g1ZXJlUDhxcjU5dUtTb2hJMUcya01tZjBlOFpxNFlnaFpidFFoVUo0?=
 =?utf-8?B?eUJkOTFVS0hKU1dJLzZhcDBzK2h1OFp0YTdXckt5TjAySzRHMS9SMVZPWU04?=
 =?utf-8?B?Y2xycW5uWWdsam1YVXQyMGs1M29EWnh5dnJtc1h2cVZnREQyOFlsVWY4aVFI?=
 =?utf-8?B?Z0dQcTNYa1RQOFNwbm5CQW5UMmVWQU8vQXRFM1ZlSGhWU1pMa25MYTBFL1NV?=
 =?utf-8?B?VU0rTEEvRk14UGhybnd5c3R5MnRkL0JnWE1xZXg0RnA3YVo1SjlDNnZjdTR0?=
 =?utf-8?B?TXRjb1hpZ3gwdzdyT0ttbWtidHM2Y0ZSTi84eTI5Q1pKam9FdkVzU2phVWtF?=
 =?utf-8?B?TkJDT3QvUkFac2ZIbE9rNzBUNjdnak1UaTJMVDd5VTlYSkNSRW5RVlVGNGRF?=
 =?utf-8?B?eEg1L1lsaUxrVlVUM2FuMFZFNWcvTlB2aFJNeUNZTElMT0Y0T3Q1VUZPUEJl?=
 =?utf-8?B?NmVuVW03ZzBvUDhxR2UvQVJSZ21ld2NiVklCbHVHY3BUNmRraUlFM2NqOGQ3?=
 =?utf-8?B?aWg0SSt3bnB6NWFLb204Wm9zVHJDV3E2ZGxxUVFiR3lhR3I1bjBvKzQ2eG5X?=
 =?utf-8?B?WU5GTjFYVFd6WHBtTUlveC9CM01zK0tNRFZxbDZyUkUrVTAxbDhwdExkb3Bi?=
 =?utf-8?B?MVErbTJLOFliSWh0U3Jsb0RYMWVIMlo2SUpqaXZ2MFpxcW9DdXlTSFM4c2Ra?=
 =?utf-8?B?VzU4STR1ZVpyQjdvVmF6RHZIMEdaU3lOV1ZqQmFGZjlMNVFPMFZGM0NUSmpS?=
 =?utf-8?B?ZVpOU0VDeWtjNDcyb25jQ3c5cXNvdkNEL1o2U2owNGc4b0x2N2hrRkxsODRC?=
 =?utf-8?B?NDNsaUdVeU5FSGNsMm9WVXoyYkgyQ2N2b0VaOFhJVzNqb0FwczBzb1ZjZVB6?=
 =?utf-8?B?cW1yZGlRSHUyQnpvWkw3RWt2WEhmM1ZjRXJZSmRqc2RrbzBPRkpyRW9rU3NB?=
 =?utf-8?B?eWNCdm9sMXlxMXBlTjlEc1BEbUpRYWhOS3gxdjRsbzJKUHR3cFArS29XL1oz?=
 =?utf-8?B?UjZwamFkVEd2bnFKSFM1QWcydEZKKzFDNVI0Rzc1Sk9tNk1wK1VmNGkvOHk4?=
 =?utf-8?B?alVzWFk3T1Z0ZDNCZ1JHLzFEc0s3SG8rQmcycjR1ejJEU3VXa3NIZk5uTFF6?=
 =?utf-8?B?L2pyd2pYcVY5Vlc5VlFUNWJXd1RoQXJEaUF4OS9JYUhpQk1MRzk0TmVrcXg0?=
 =?utf-8?B?cWtMaUFKempQaWRtWFJNakE1MDZTU2N5ZnZadFR2djd5bSt3T0pmYVJJVGJ6?=
 =?utf-8?B?bWU4cy82ajBkUnQxYTE3cWNlV2hRblZOcFFPZVZRaDZyUUs1bVJmZkdQY1A0?=
 =?utf-8?B?K3Q4aUNObWJwbXJOMDJ4YyswaUt6UXNrdXA3OFpkbkpITHFLMndoWDdBWUEr?=
 =?utf-8?B?Q2M5empXWTgzdytUcUpOV1lkUVdzUXBKampzOVpYSEM1TjBCd0g0T25jZWly?=
 =?utf-8?B?R0pvYndlK2tqSWUzTjMydXVQaWVDUlIxcEFFUzZNNzRJOG52QW9WbXZDcVlR?=
 =?utf-8?B?SzRPL2hpdmJqMVI1L0Q2S1QyQmdnWUcrNmR0QkZCc0xmenB1VlNTM0kxYnNv?=
 =?utf-8?B?c0N6Tks0cmdWTWFQYWJPYUxEZk00T05IRU5HOVN1Rk9qU0tPcWF1NlV3Z29m?=
 =?utf-8?B?NkY1MFN6S2pVeUNIQ2xaQXRmcUJDQ1FGV1k1TDIrNzB4b0p2cVpreE02M0VN?=
 =?utf-8?B?eUpIWHdsRk1qY0hHbFFHd1d6M05zSXlrMzE1Wm1QZnJNWnloSWVNMjdFcCtX?=
 =?utf-8?B?KzVobXRjTWs5WDEzSGFGQTRINGxZTXZJR1Z4WTZEbXBxaXhIRHpDckt2elZQ?=
 =?utf-8?B?WFZnaE8wQWFUMVhnblhvRG5KMk52SWlLNFErc1MyQ3Z0NHBmZ3Y4Z0lDdERq?=
 =?utf-8?Q?4FzsfD72QdfBQuGI3q/LZuCCw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 492d4a31-7fd6-4155-aa13-08ddb9d1d6e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 01:35:06.0745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yyDmB+fD5mQdCqzgKn55s+fkvfwwkm40M8KRf26+Rc6h34sRemW2tKytjCqFomlLptZR/fnhW+uFhaoVScRIsyHZjhVg6z2PHJ9XmPZiQZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR07MB7747
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDAxMSBTYWx0ZWRfXz9oaBiKvQctg RPMzyil+JjTSZFvfr24d6e7A7RzBEzrV2u3GHPs7UxNoVCKDwJu8F38YC6tvSt4x1q1Q+ka5k8G 4ehbvVVRpRJevzpqRQ+y4019g2IkTnST0TM79CXdzW7BFiVdhr0nHgb/z/ghLfyl9zzbTaSQo12
 QdyUixetJqsJbbIQApKZ5C+4dDMuhpxQleRciajJPOaGu9Oc+/WfO/z7PwNMAjfszkQEP+uL4RM TnQ5Tf4eXgTR8A2dmuvLmUiv4P0skgHw5Ih1bbKicD1mMhA91Y0722eg/ggXats1C0SYVAqt4rC Ukjzb7m8bgmtgHAgRdajv99StvKDAzYnFdcWoaD8XFpa+ilMbjLoRdjfkvV1VNYP1F0TB4ZTsm9
 SrElTOqfbnCXgKAe7x1qDbNqjAXzlGZjRPgEh4VHqrEPp3BYVqMJCOeVoCCS0PzRd7ML76he
X-Proofpoint-ORIG-GUID: XLEcOlVmU9c28yPMVJ-q0OeuDQoVR8nQ
X-Proofpoint-GUID: XLEcOlVmU9c28yPMVJ-q0OeuDQoVR8nQ
X-Authority-Analysis: v=2.4 cv=W6o4VQWk c=1 sm=1 tr=0 ts=6865de4e cx=c_pps a=A0MaZ9OvLBUdx9ibaoeqQQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=Zpq2whiEiuAA:10 a=uherdBYGAAAA:8 a=VwQbUJbxAAAA:8 a=lF2NBqJdVyrw4ViIXvAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_01,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030011

Og0KPj4+Pj4+DQo+Pj4+Pj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xpbnV4LQ0KPj4+Pj4gZGV2aWNldHJlZS8yMDI1MDQyNC1lbG0tbWFnbWEt
DQo+Pj4+PiBiNzkxNzk4NDc3YWJAc3B1ZC9fXzshIUVIc2NtUzF5Z2lVMWxBIUJvLQ0KPj4+Pj4N
Cj4+Pg0KPmF5TVZxQ1dYU2JTZ0Zwc0JaemdrMUFEZnQ4cHFSUWJ1T2VBaEl1QWp6MHpJMDE1czRk
bXp4Z2FXS3ljcUtNbg0KPj4+Pj4gMWNlalM4a0tadmpGNXhEQXNlJA0KPj4+Pj4+DQo+Pj4+Pj4g
WW91IGNhbm5vdCBqdXN0IHNlbmQgc29tZW9uZSdzIHdvcmsgYW5kIGJ5cGFzc2luZyB0aGUgcmV2
aWV3DQo+ZmVlZGJhY2suDQo+Pj4+DQo+Pj4+IEkgdGhvdWdodCB0aGUgY29tbWVudCB3YXMgaW1w
bGljaXRseSBhZGRyZXNzZWQgd2hlbiB0aGUgZGV2aWNlIGRyaXZlcnMNCj4+PiB3ZXJlIHNlcGFy
YXRlZCBvdXQgYmFzZWQgb24gb3RoZXIgcmV2aWV3IGNvbW1lbnRzIGluIHRoaXMgcGF0Y2guDQo+
Pj4+IFRvIG1ha2UgaXQgbW9yZSBjbGVhciwgaW4gdGhlIG5leHQgcGF0Y2ggSSB3aWxsIGFkZCB0
aGUgZm9sbG93aW5nIGRlc2NyaXB0aW9uDQo+Pj4gZm9yIHRoZSBkdC1iaW5kaW5nIHBhdGNoDQo+
Pj4+DQo+Pj4+ICJUaGUgSGlnaCBwZXJmb3JtYW5jZSBhcmNoaXRlY3R1cmUgaXMgZGlmZmVyZW50
IGZyb20gbGVnYWN5IGFyY2hpdGVjdHVyZQ0KPj4+IGNvbnRyb2xsZXIgaW4gZGVzaWduIG9mIHJl
Z2lzdGVyIGJhbmtzLA0KPj4+PiByZWdpc3RlciBkZWZpbml0aW9ucywgaGFyZHdhcmUgc2VxdWVu
Y2VzIG9mIGluaXRpYWxpemF0aW9uIGFuZCBpcyBjb25zaWRlcmVkDQo+YXMNCj4+PiBhIGRpZmZl
cmVudCBkZXZpY2UgZHVlIHRvIHRoZQ0KPj4+PiBsYXJnZSBudW1iZXIgb2YgY2hhbmdlcyByZXF1
aXJlZCBpbiB0aGUgZGV2aWNlIGRyaXZlciBhbmQgaGVuY2UgYWRkaW5nIGENCj4+PiBuZXcgY29t
cGF0aWJsZS4iDQo+Pj4gVGhhdCdzIHN0aWxsIHZhZ3VlLiBBbnl3YXkgdGhpcyBkb2VzIG5vdCBh
ZGRyZXNzIG90aGVyIGNvbmNlcm4gdGhhdCB0aGUNCj4+PiBnZW5lcmljIGNvbXBhdGlibGUgaXMg
ZGlzY291cmFnZWQgYW5kIHdlIGV4cGVjdCBzcGVjaWZpYyBjb21wYXRpYmxlcy4gV2UNCj4+PiBh
bHJlYWR5IHNhaWQgdGhhdCBhbmQgd2hhdD8gWW91IHNlbmQgdGhlIHNhbWUgcGF0Y2guDQo+Pj4N
Cj4+PiBTbyBubywgZG9uJ3Qgc2VuZCB0aGUgc2FtZSBwYXRjaC4NCj4+DQo+Pg0KPj4gSGkgS3J5
enN6dG9mLA0KPj4NCj4+IEFyZSB5b3Ugc3VnZ2VzdGluZyB0byBjcmVhdGUgbmV3IGZpbGUgZm9y
IGJvdGggUkMgYW5kIEVQIGZvciBIUEEgaG9zdCBsaWtlOg0KPj4gY2RucyxjZG5zLXBjaWUtaHBh
LWhvc3QueWFtbA0KPj4gY2RucyxjZG5zLXBjaWUtaHBhLWVwLnlhbWwNCj4+IEFuZCBkdXJpbmcg
dGhlIGNvbW1pdCBsb2csIGV4cGxhaW4gd2h5IHlvdSBuZWVkIHRvIGNyZWF0ZSBhIG5ldyBmaWxl
IGZvcg0KPkhQQSwgYW5kIG5vdCB1c2UgdGhlIGxlZ2FjeSBvbmUuDQo+DQo+Tm8sIHRoZXJlIHdh
cyBubyBzdWNoIHN1Z2dlc3Rpb25zIGluIGFueSBwcmV2aW91cyBvciBjdXJyZW50DQo+ZGlzY3Vz
c2lvbnMuIElJUkMsIHRoaXMgd2FzIHNpbXBseSByZWplY3RlZCBwcmV2aW91c2x5LiBJIGNvbnNp
ZGVyIHRoaXMNCj5yZWplY3RlZCBzdGlsbCwgd2l0aCB0aGUgc2FtZSBhcmd1bWVudHM6IHlvdSBz
aG91bGQgdXNlIHNwZWNpZmljIFNvQw0KPmNvbXBhdGlibGVzLiBUaGUgZ2VuZXJpYyBjb21wYXRp
YmxlIGFsb25lIGlzIHJhdGhlciBsZWdhY3kgYXBwcm9hY2ggYW5kDQo+d2UgaGF2ZSBiZWVuIGNv
bW1lbnRpbmcgb24gdGhpcyBzb29vb28gbWFueSB0aW1lcy4NCj4NCg0KSGkgS3J5enN6dG9mLA0K
DQpUaGFua3MgZm9yIHlvdXIgcmVzcG9uc2UuIA0KVGhlIFNvQyBzcGVjaWZpYyBkdHMgcGF0Y2hl
cyBhcmUgYWxyZWFkeSBiZWluZyBzdWJtaXR0ZWQgYnkgQ0lYIHRlYW0gZm9yIHRoZWlyIFNvQyBi
YXNlZCBvbiB0aGUgc2FtZSBQQ0llIGNvbnRyb2xsZXIgSVAuIA0KDQpTaW5jZSB0aGVyZSBpcyBu
byBTb0MgZm9yIHRoaXMgcGxhdGZvcm0oaXQgb25seSBhbiBGUEdBIGJhc2VkIGJvYXJkKSwNCmFy
ZSB5b3Ugc3VnZ2VzdGluZyB0byBkcm9wIHRoZSBkdC1iaW5kaW5ncyBwYXRjaCBhbHRvZ2V0aGVy
IGFzIHRoZSBTb0Mgc3BlY2lmaWMgZHRzIGJpbmRpbmdzIGFyZSBhbHJlYWR5IGJlaW5nIGluIHRo
ZSBzYW1lIHBhdGNoIHNldC4NCg0KVGhlcmUgd2lsbCBiZSBhIGNvbXBhdGlibGUgaW4gdGhlIHBs
YXRmb3JtIGNvZGUgdGhhdCB3b3VsZCBub3QgaGF2ZSBhIGJpbmRpbmcuDQpQbHMgbGV0IG1lIGtu
b3cgaWYgdGhpcyBpcyB0aGUgYXBwcm9hY2gNCg0KDQo+QmVzdCByZWdhcmRzLA0KPktyenlzenRv
Zg0K

