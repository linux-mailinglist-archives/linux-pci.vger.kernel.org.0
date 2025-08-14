Return-Path: <linux-pci+bounces-34017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADFCB25918
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 03:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D84F9E057C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 01:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DD317AE1D;
	Thu, 14 Aug 2025 01:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ErmGyI06";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="tqci7moE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9461D61BC;
	Thu, 14 Aug 2025 01:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755135006; cv=fail; b=BIL6Xzqc5Uu57wpS0mi0lYYyiKOo3PkOcqT8ZPh8NQEjkztAyvtlTK+6UzI6H3vUh/DAveOu3yRGYZRCwszZOXFyWchBs/Mu1KC2xdWnAi1+KHZfzn7cwnAZzBRYDlyANC3AVn26iRjacigOT9IXupsSeVjrqmHVX+iafvuMaTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755135006; c=relaxed/simple;
	bh=s5XbOojKzYMQIwUXAVCV+7Ozb6tASswBrLxe2FBd4Bw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jlrH45joP++5LFyIovVUf9+YqwwA+/QHEqFkY3cdFm1nmUiEqrGz8YIwgSVa4ypGp7860MpMkyBmBy8Czpcu/hck6sbMRY8btuTtMIfghBlbteEAPD+4wk7oUM09SlARsdv//A/LaGT69zLcNJTm77hh0dGwxn6Hi+WEMHscNWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=ErmGyI06; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=tqci7moE; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DJXK8h015148;
	Wed, 13 Aug 2025 18:29:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=s5XbOojKzYMQIwUXAVCV+7Ozb6tASswBrLxe2FBd4Bw=; b=ErmGyI0682GO
	/fn/+KX4TfJTCfcSF0rgVr7K2NRgIYCwntExC4CX/HcF/3KUQhFyfR4a/pAyViH+
	1htqx/WE6YpErC6rKylke4HCa01QOQhF5JrXOK5mh/dFrkgAov/Gzyr6zDHdOH7O
	+a1Ri0QUfZxLDwifLF+Tbs1cJtCf6ALCexToh3GikRLIlVdBQTPebVf7n7flsdSi
	TN0Qu5GD64/6q1/P1BlDx7F2GtYxJYvuv59W4IqSvV8S5fivoUucanbhNAt5r4SC
	Nd0v+qg5mxRSLpqZjYE2+mxN9WNy/uKMtf10eIng7WtdE9BLHPPKDb3kSn919gzm
	vZm9dvQr+A==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013002.outbound.protection.outlook.com [40.107.201.2])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 48e2vx5spr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 18:29:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ma4U5iHLUOghBnH0aKKWA8bs7ju9qXpPXblKyfKcrGucxd13Jpw9MfdiOXr2Whkvod8lDCbsyD08r0jXJl6s7RTCl4Kl5kWrGsAGwx2ciNPf6knUDD8rYSWXIbNT7t8tF8wTMyL6+XfbVRxGAsmXP5R7kIZz6ahN/Rjx5MQqSV/AFzS3E4rn5v5IJ0GhzssStIZ1Fr7BM1PgOKtWCubGz3GobrAON/IsAwbmiYsLnSRDjYHISBvCrlYMiS7H7L7ww4+1kUx/x5ebioHIW850cRT2V8PrUBd0zlFMMpnGqHVlm86IoNUrF+j1s+nOUt/nZDzE5e05GmRpxizso64uBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5XbOojKzYMQIwUXAVCV+7Ozb6tASswBrLxe2FBd4Bw=;
 b=xvh66Wz/9jvuofF4pO+Yf1cC6cO0bReF0yX1NR/jwHJkh8EQMeZ0nmkq2YnvFyZhUTcFda4XVT1DLBUhMwgHRcQEd9QdiRsV17Bcb+UnYkYJOQh5lso3XOq6yT9u6EO+HUBqDknQPAUGKLcr1Cs7Ec18XmegvDS2mgM3quNpgg7HOhY9bewEgNvKCZ4ShnNIP3yRlSs2q0sObBeE2K1iB3BC/uOgScwGN4KkdG3i7LmoBb99FRF+lYjt6D1pqp7CcDEKcD0wkHeIEXJdBipgdQ9LuJYEPejHNPOZlbh1PIi/UBte8pIuavqcytzs52FwpTc1H5lyv4X7z/Y300cy4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5XbOojKzYMQIwUXAVCV+7Ozb6tASswBrLxe2FBd4Bw=;
 b=tqci7moEsRkPIS/IXz/jmwG/kTIA0vZoKmPNY37RXAIxGKCVXFYCq8DE0CT4+RKvBvyQh1o9T+PkQRyB7o7OAJOW6pgoOjzyVaJnZqQaFoExNnkSS4nTp9tmySLVwKny2ZIhvJNU2C73l7GMqtFXoFhpin0Qn1u52Ko0vIGxGPQ=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by MN2PR07MB7213.namprd07.prod.outlook.com
 (2603:10b6:208:199::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.9; Thu, 14 Aug
 2025 01:29:39 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::7cef:10c6:11b0:cb05]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::7cef:10c6:11b0:cb05%8]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 01:29:39 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        "hans.zhang@cixtech.com"
	<hans.zhang@cixtech.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com"
	<kw@linux.com>, "mani@kernel.org" <mani@kernel.org>,
        "robh@kernel.org"
	<robh@kernel.org>,
        "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "fugang.duan@cixtech.com" <fugang.duan@cixtech.com>,
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
Subject: RE: [PATCH v7 03/13] PCI: cadence: Add register definitions for
 HPA(High Perf Architecture)
Thread-Topic: [PATCH v7 03/13] PCI: cadence: Add register definitions for
 HPA(High Perf Architecture)
Thread-Index: AQHcDAqR9XJKBGF8xkCOBZ63f9L9XbRg9bWAgABnSDA=
Date: Thu, 14 Aug 2025 01:29:39 +0000
Message-ID:
 <CH2PPF4D26F8E1C1DDDAB9E861818FD3A32A235A@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250813042331.1258272-1-hans.zhang@cixtech.com>
 <20250813042331.1258272-4-hans.zhang@cixtech.com>
 <829069ca-0efb-4375-99bf-ccda52f74ac0@kernel.org>
In-Reply-To: <829069ca-0efb-4375-99bf-ccda52f74ac0@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|MN2PR07MB7213:EE_
x-ms-office365-filtering-correlation-id: 6ea748ef-5f9e-474d-7f6b-08dddad209a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y1h2WUNIVURTVFpkaG1CZC9hMCtLYmUvdXFINjRwRUg4Q0JEUzlpQ1lKclZG?=
 =?utf-8?B?ZkZKaGhabU1PL01ocnFVMW4rdHk5aUZmd05zVSs2VGtBS25tUlhjUHNDdUJ5?=
 =?utf-8?B?LzVOZ2RVeXNTMWNDRk5qdHozWTBtTjRrR2ZiaUJFeThzYWdLQ0k3Q3NiU3cy?=
 =?utf-8?B?WXhqdFYyZE1xTythdkw4SWZtdTBSdHBFNzJob1d5Nkd1TmEvK0NRUFM5SDJP?=
 =?utf-8?B?YzYvSEdDeDlycFh1QTFKay83c2QxRjZPMytLNTZzTGxHOGUxdnN6OW9VVlZM?=
 =?utf-8?B?a29qSi8rRFZjWTMwWW1MOUhtU1NtVjI2dUMydWl4S29hd1J6UEtnZ2J1RnNw?=
 =?utf-8?B?ZmU5Y3M5TlljQ0s4NXRKVWY4TS9NZTFrSG9oSlB1Q1JUYjBCbTBIN2F4VVRB?=
 =?utf-8?B?Snl4UVNGaXFwTDJpUFI3SUhTSm5iaGxHVXlhcFU0S1hqM0p6ODkxWUtVOCtu?=
 =?utf-8?B?Y21tYVViS1YvOGtVSnQ5Vmh4N1Yxd3ZkZWIyY0dtMG4vVDJIczd5ZVRkWUZI?=
 =?utf-8?B?clNHaDhoT0VOSjF5M1U1YS9OSUpyUHc0MmJKTllDV0VleWhQMUhNL0NabTJ2?=
 =?utf-8?B?a1VzMnZzZTcwc0NWMDVWTFRTYlVWM0g5dTcyNUJQN1RMVDAwWmQ5Qno2T0xx?=
 =?utf-8?B?ZytHaGdUTi9TekhRYkMvbDd3TDNOOUpLM2pQek0xQ3ZwWVQ4Z3hGNExYaDhv?=
 =?utf-8?B?T1p3WDdEV1lxRXNBanpMRXpLK0graU5VeVRaUGtwYWwyTDR5NGh1K1hGOXRy?=
 =?utf-8?B?Y3J6MFZFL1g5SzhVQnVjQTRxV3VwNThWa3NUendOZ3pVUnJudXRKRWtLT00r?=
 =?utf-8?B?NXBzUjBLOEJoZ3NnT0JsVWxaYldUK0hKbGwwOVlJN2dFZmYzVjhFRXM5UDFh?=
 =?utf-8?B?MFhtNWo3djgrMlpTbGNnbm9raWZLMXFEWlVTam1Ed0t4b2gxZUFzNmdEWG9z?=
 =?utf-8?B?bk5YTEF3b0kwMXNDbnYxSyt0T3gxQjhGK1RldGthcW05MWVzRWFKdWxJbmw1?=
 =?utf-8?B?STB5aUEwMitBOWZMcVlrbDI2L29KWkp6VmU4SDVrM2xCbTkydGJpbzVUUWw1?=
 =?utf-8?B?ZTUrb2hBTnovZWxtNE9RTDBsR04relowVkxmSDVZWDZsSm1HVHZWdUJPMVZD?=
 =?utf-8?B?MW9GVnkvTnpHbVhpZjZybDZ6Sk51WmE0cm13WmZHT1JLK0wvYndUdjBTNXlI?=
 =?utf-8?B?WXFaTEhYTzV5L2JpdGQ3TUxaelJ5K2xCaU9FODVoY25wODI1M0NJNVFJLzY5?=
 =?utf-8?B?aEIvS3hrdDE3OXMxZEJyZkcyQUdvbHYyeHNCOTVDdk4xZU81eEgzRVRvd1lR?=
 =?utf-8?B?M09DUXhMOGF0S2NJaGpZTU1Ya3I1L05JU21tVVg5VTdDcTRhMnkwMXlOZmIw?=
 =?utf-8?B?RXp4THFndXhzWkVrZk9RTDRxVGhDV1ZURVNsOU9WQ3JTQ29LdGg5QTVpU080?=
 =?utf-8?B?WTZlcFlMWGZITVh5c0ZENVhzUGpDRnBLUkdXWUZGa0VVMEJnNU50M003T1Bn?=
 =?utf-8?B?MEk4QWQ1ZjNDWkFqaFNRV3FnbHlIczNaUWE0OXBzeEJyK2VMZ2NuUUl0d3FW?=
 =?utf-8?B?aTdqSi96SE1Vd1JneVF1cHhOU2hGUEo2ZmNrTWJXUGNML21aVitHU0VGM1dG?=
 =?utf-8?B?OElsdVFqN3paK1Mwb2FuNC9OM1JWcGNYYzFuOHVXVzJQbDdTcm11ZVUxczBi?=
 =?utf-8?B?SWJwd2NiNUUwTDQ3dlY1d2xGS2hJdTVVRTFNWFRGQlBCczdvazdXVFNhMGZQ?=
 =?utf-8?B?UklHeWs4V0lka1lZY0JGdkRUWVpHczR2VE95RmczZk1hUjgzN1BjbDczNmVq?=
 =?utf-8?B?V1hNUkVRNktCWWoyaVdFMDB1Z2h1aTdqb0xyWm8yeW1PM1Zld1dJUWlPMGtR?=
 =?utf-8?B?UTEvY2ZyQUVPZlR3MzcyWmNvZXc3NjE5REs1cFVwZlpLMGdZU1NXeG5jeG41?=
 =?utf-8?B?b0pualRhenNreG9JaVhzVzJZT2xlR1ZMa0FTNDczQVpwL1AyVEs0Yk9QVnJU?=
 =?utf-8?Q?5Ddanhb/O4Uy9hvjPcDCLYxvw21/us=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dC9acWx5NnlwMTQ4b0ZXTCswaWNVQWZFMndXVHUrbzhDRzdpS1lmV0tIWUdX?=
 =?utf-8?B?Wk9ET01DYlU1MXJFcjF1d1EyeW5obUt5U3lvNGZIS3plRW9BK1FaelZwVTZa?=
 =?utf-8?B?bDkvdkRPa3dOU01xTUZVMkt6eGVkNHF2dHc0K0FZL0xPdEljWjJ2NXdaRlhG?=
 =?utf-8?B?UHQ0SzBMZEZLZjc1MDFPY245K01sYkNyL2cyQktaV0VBQ1UzNnVhZ2dTekRv?=
 =?utf-8?B?dS9zVURCL1pwUHNUZnp5THk3ZGR6Y095L3NuOXRoRXduYnpPNkZ4WFR4K2ZB?=
 =?utf-8?B?NlBBRXVJM0xyK2RBU29kNjU2b292NHJST2FpSERUK0lscEFZRnBXVXB4RTR5?=
 =?utf-8?B?aDhuNGxqUFVmR0pFSXM4dkljZHREeC9sbzZ3dFZiY1k3SUo0Yi9aRHF4VFhE?=
 =?utf-8?B?RWVEOVBzVGRWM05jS082cE1UMW9vK2tXWHJodlQ3aFNhTng3TjhwZlZya2ZM?=
 =?utf-8?B?TXFMd2N6ZVUva1NlMG5OWEVrejlheDhwZW5ZdHNUdUlaNkt1dTR3dE45WVND?=
 =?utf-8?B?SkpVRWpWR1BJL1RlUE0zTHdlTUpLOXRkRlVERC9Ea1FzWTZGZE9WTGV1bE9x?=
 =?utf-8?B?WDRNa05vZ0NPZlZGTmRPSGN6a3dtVEN3cXN4WlB6RFByQlBJeXEvZ2NBRlBB?=
 =?utf-8?B?YlUrbGxDZTJDRmRUNnRkUk9vRSthZGx1blhDMjBuQkV2TkRzbkNpOSsweGxy?=
 =?utf-8?B?QXlEUHVzZUZRTjZydTYrWHQ2Y2x5Y3QyNVFWZVpDYUhwZVBFQmlZQ25ZeVpO?=
 =?utf-8?B?VFNTczdnQVgxRGE3VzBadkpTajBCaXpzaDNjRUY5TWVHRHNsM2VxTWMvWVZJ?=
 =?utf-8?B?Mi9iYW5uR0p1dStBZnlqTzhVQzB5ckxEYzMzZHlYM3BNVmlJS3dWaWtwODJt?=
 =?utf-8?B?ZUFMZUVHdUdBSVRjdm02aG1MYW9ZRitNUFJHSW8wMG1WWUlqMzVWR2FOdFNt?=
 =?utf-8?B?WmtvY00zSmN4ZWUzeEJrS0s5MS8yS0JCQk81bHlCOWRMS0w2TnZMeTJDc3NF?=
 =?utf-8?B?WE9uZW9sd1V3VzAxWTRkc0V4K2NOWHBTN2Q4eWYxK1B3UlpmQ082Nng3aWRz?=
 =?utf-8?B?ZUs3ZlNEME1jUW5MbGFKdVh1V3duTFZUOFdha2tRVTkxaEhPQ244UlZYeTVj?=
 =?utf-8?B?dFYxUkk0OGJZaGxNc1hQRDhadVhneE5ENk0xMUo2WmFlcGxPalNJZHpEeGNl?=
 =?utf-8?B?dkpMbVdvdU5xdzhGQVpidW9IeEROZStQRGFobUMzVG9kUENnTVI1K1pFdXdO?=
 =?utf-8?B?aVAzUXFRSklzODFDL05RSThNbzBKcWp4UVhvVjNidTduYlFOTW80VEg3WEp2?=
 =?utf-8?B?djBOSU5QcHl3clZYTWY0b2lLenBZUGpjVFQxVXduTFU2Yk5ueFptajhtNHov?=
 =?utf-8?B?dU1iYzMyYXNwZDNkMVNBeHlvTTBqTzlVMEFReUFoL2U2bDRoWXJZbTY3aVhy?=
 =?utf-8?B?S3FCTDBUdVFWS3g1OFdwenVvdXpQM2hiWVhoQ3Y3cnpFdmpJS21NODBVUW1Y?=
 =?utf-8?B?ZGZrcU1sTmN1a29ZSnVtaEhHMi9ZUktmNWxCWWJnK1hjMkN0MVA0K1YzV2lL?=
 =?utf-8?B?dXhoVHlGSTVMWDlsOTJOcDBJMUwyR1lTOC9oUFJUaTZ1YWpUVVJjNEdvc0wz?=
 =?utf-8?B?bCtCc1RqVzdsYnRDL0FsTjVzUEc2dUFCTzY4eVRzNVpQVS9KRGErcHZXYUww?=
 =?utf-8?B?MklrR095VU0zWTEyMVowUk1HT00rNC8vRkd0MXc3WGhsMG91dEhiclBhdnA3?=
 =?utf-8?B?TklQRVRraXlTNVZmRFQxSGVNQVlQOEFRdHhwVGwxMnZCVTR2Y0QwUk9jQjY0?=
 =?utf-8?B?VExxdlY4dzRJMXF5amNkK3FBbVZRbXQrUTFNcHgxN3U2RHpJL1E5enNQaFRt?=
 =?utf-8?B?bFhoREVyUjN4ZDJ0Y214cTJaSklyb1RCcnVuL1J2WGpTVE5zUE5sMVc1b1BE?=
 =?utf-8?B?K01zeGI0ZEsyVWlvWS9zNGc2TXFOSzZadzR2eVVNQyt3OG5wc0VZSGtodUd2?=
 =?utf-8?B?R1dRUlJGMTJGa1BaWmtDa0JVQlNBdlI1OHJJekNxYiszNUQzSGs5bHZ3Titu?=
 =?utf-8?B?WXdzbTRFUEN1aXV0dUMva2VXaU1CUWtCZ01ZdEZCV254MlRRRFYyWVFVdmVG?=
 =?utf-8?Q?Yc2Xvb0ldaRwgJ7i/H1Ndv7Rq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea748ef-5f9e-474d-7f6b-08dddad209a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 01:29:39.6127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WxLjA2YWrfc6btoTFAJcAPo0Xgl+032+MkRm3e0Ipe9o8AL22KgU12mhM2XK+qe6ecDo7pWkQLKJIvtkCOwZoJyttcxCBTBLukq/q1SG0yM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB7213
X-Proofpoint-ORIG-GUID: 4j_zXFWamemwIXtkXwGLcjCVN5mm7MT6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDAxMCBTYWx0ZWRfX0zgaQgdIxGcb JShOJ73rIrmHV6t+J4WZKs7tOaqHjXXPT16ZLNH9uCsMCltiKNCqQaIKrRncY/RW/tK5Efwc5bV mbfPwIAPjoDwIAs0xJkCqH24Z6cGtKaFmvtezLBB9mi3Bf28LfgZUXGRk2+qC+bz9dnd/HPYVbW
 FkENvmfbymCPvSlI4pXxmNSBwtmG9KY95QFCCC2hJnumI201VTY6YPjgzbAwxEfXD4luUcyPi8W 6eQn5+TsDob/wenwWDnCZOSw5C+nLcSlVIwNojBILvekIQEkmZMCFHWu4xrqN5azdRD0n6zACOJ zhT1+ArkkiN5dwt1EXMZe0joOTKORp6sBPhLPUHWao3nVBbug5YUP6D+uTu6MWuUCTx5bwclslf
 2MBYPa8UNS+oeohh2KDsvUVSD4B9CPd43vNUE9WOW8Y9ugN+L83omjHGxSDzY6vn56Uw2Gq0
X-Authority-Analysis: v=2.4 cv=DM+P4zNb c=1 sm=1 tr=0 ts=689d3c06 cx=c_pps a=uYXQfM3GD41LpGGBCGkGnQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=Zpq2whiEiuAA:10 a=TAThrSAKAAAA:8 a=2wg2n1QX3B7lBbpmqnsA:9 a=QEXdDO2ut3YA:10 a=8BaDVV8zVhUtoWX9exhy:22
X-Proofpoint-GUID: 4j_zXFWamemwIXtkXwGLcjCVN5mm7MT6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 clxscore=1015
 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508140010

DQoNCj5PbiAxMy8wOC8yMDI1IDA2OjIzLCBoYW5zLnpoYW5nQGNpeHRlY2guY29tIHdyb3RlOg0K
Pj4gIHN0YXRpYyBpbmxpbmUgdTMyIGNkbnNfcGNpZV9yZWFkX3N6KHZvaWQgX19pb21lbSAqYWRk
ciwgaW50IHNpemUpDQo+PiAgew0KPj4gIAl2b2lkIF9faW9tZW0gKmFsaWduZWRfYWRkciA9IFBU
Ul9BTElHTl9ET1dOKGFkZHIsIDB4NCk7DQo+PiBAQCAtMzEzLDE5ICs0MTAsMTcgQEAgc3RhdGlj
IGlubGluZSB2b2lkIGNkbnNfcGNpZV9lcF9kaXNhYmxlKHN0cnVjdA0KPmNkbnNfcGNpZV9lcCAq
ZXApDQo+PiAgI2VuZGlmDQo+Pg0KPj4gIHZvaWQgY2Ruc19wY2llX2RldGVjdF9xdWlldF9taW5f
ZGVsYXlfc2V0KHN0cnVjdCBjZG5zX3BjaWUgKnBjaWUpOw0KPj4gLQ0KPj4gIHZvaWQgY2Ruc19w
Y2llX3NldF9vdXRib3VuZF9yZWdpb24oc3RydWN0IGNkbnNfcGNpZSAqcGNpZSwgdTggYnVzbnIs
IHU4DQo+Zm4sDQo+PiAgCQkJCSAgIHUzMiByLCBib29sIGlzX2lvLA0KPj4gIAkJCQkgICB1NjQg
Y3B1X2FkZHIsIHU2NCBwY2lfYWRkciwgc2l6ZV90IHNpemUpOw0KPj4gLQ0KPj4gIHZvaWQgY2Ru
c19wY2llX3NldF9vdXRib3VuZF9yZWdpb25fZm9yX25vcm1hbF9tc2coc3RydWN0IGNkbnNfcGNp
ZQ0KPipwY2llLA0KPj4gIAkJCQkJCSAgdTggYnVzbnIsIHU4IGZuLA0KPj4gIAkJCQkJCSAgdTMy
IHIsIHU2NCBjcHVfYWRkcik7DQo+PiAtDQo+PiAgdm9pZCBjZG5zX3BjaWVfcmVzZXRfb3V0Ym91
bmRfcmVnaW9uKHN0cnVjdCBjZG5zX3BjaWUgKnBjaWUsIHUzMiByKTsNCj4+ICB2b2lkIGNkbnNf
cGNpZV9kaXNhYmxlX3BoeShzdHJ1Y3QgY2Ruc19wY2llICpwY2llKTsNCj4+IC1pbnQgY2Ruc19w
Y2llX2VuYWJsZV9waHkoc3RydWN0IGNkbnNfcGNpZSAqcGNpZSk7DQo+PiAtaW50IGNkbnNfcGNp
ZV9pbml0X3BoeShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBjZG5zX3BjaWUgKnBjaWUpOw0K
Pj4gK2ludCAgY2Ruc19wY2llX2VuYWJsZV9waHkoc3RydWN0IGNkbnNfcGNpZSAqcGNpZSk7DQo+
PiAraW50ICBjZG5zX3BjaWVfaW5pdF9waHkoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgY2Ru
c19wY2llICpwY2llKTsNCj4NCj5JIGRvbid0IHVuZGVyc3RhbmQgaG93IHRoaXMgKGFuZCBtYW55
IG90aGVyIHBpZWNlcyBoZXJlKSBpcyByZWxhdGVkIHRvDQo+ImFkZCByZWdpc3RlciBkZWZpbml0
aW9ucyIuDQo+DQo+VGhpcyBpcyBub3QgYSByZWdpc3RlciBkZWZpbml0aW9uLg0KPg0KPg0KDQpU
aGlzIGlzIGp1c3QgYW4gaW5kZW50YXRpb24gY2hhbmdlIHRvIG1ha2UgaXQgYWxpZ25lZCB3aXRo
IHRoZSBvdGhlciBmdW5jdGlvbnMgZGVmaW5pdGlvbnMuIEhvd2V2ZXIsIGZvciB0aGUgb3RoZXIg
Y2hhbmdlcyB0aGF0DQp5b3UgYXJlIG1lbnRpb25pbmcgd2hpY2ggYXJlIG5vdCByZWdpc3RlciBk
ZWZpbml0aW9ucywgdGhlcmUgd2FzIHNvbWUgbW92ZW1lbnQgb2YgY29kZSB3aGVuIG5ldyBmaWxl
cyB3ZXJlIGNyZWF0ZWQgd2hlcmVpbiBmdW5jdGlvbiBkZWZpbml0aW9ucy9zdHJ1Y3R1cmUgZGVm
aW5pdGlvbnMvZW51bXMgd2VyZSByZWxvY2F0ZWQuIEkgd2lsbCB1cGRhdGUgdGhlIGRlc2NyaXB0
aW9uIHRvIHJlZmxlY3QgdGhlc2UuDQo+DQo+QmVzdCByZWdhcmRzLA0KPktyenlzenRvZg0K

