Return-Path: <linux-pci+bounces-31066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF4EAED6AE
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 10:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D00453A6395
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 08:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95B11FDE02;
	Mon, 30 Jun 2025 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Jgji1/TQ";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="F2USULzO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92E84A01;
	Mon, 30 Jun 2025 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751270832; cv=fail; b=YCr5Y72NyYJCuGExlu8SUetu+9AfsGEwJ6KGWU2ikOF5Ag+/VwQ4RpJVEdW0gkl8g3QNXx+sEc57LYDf2k8w7aRt1i2XVLUb4k5Ak176e+kHW7GJJA7MxbJHWKNCpzEV32X0u2reoa9e/LbKq8gx0g7vC4E2rDsSH+lLNhudNlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751270832; c=relaxed/simple;
	bh=Jw54o48Nlc0ASP2XSFUx1nG16gk6xP5K7M3AEAqjEKA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hMXN7Stnpwj/N3upfZxGxnivPaDcjutlg9EHMeKOVDjgXivhUj/s8ROy8sSYLH40KyQKC3o5a9yoOpWmyPhdw5NpQtvFR+nKydLeClbS4vofLLK2SSGfaE0x5rhTmBLZq3famAt1AgskmQksZ3X5rBBkcPV+KqG8FbqAkf8DltE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=Jgji1/TQ; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=F2USULzO; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TNdb8a022767;
	Mon, 30 Jun 2025 01:06:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=Jw54o48Nlc0ASP2XSFUx1nG16gk6xP5K7M3AEAqjEKA=; b=Jgji1/TQWzpj
	pbehxJcRI3zMHWpdMIqIkCUudbUWqicSii1agC+ai7Kf9weWmb6dxyZabfgpeReL
	7aNZCiNGNlfw59TEMs8p4OMdPXuR6wQGQ4zath7ApWDyJ4S5k5/k+ok4RO+BhhoM
	nng2UfnZrA1gE6bYeooXAwUu3gMaiImI2oJwKxRuZF6no94NGGHrTEp74YlfD0Kv
	+tDdu93pV04Mv9ilfn5BNgmVAsEuzn+a9DFSAejjGyWGaoOEup+FII79g2uIPPjb
	eVTaN4kC0R0NiEsUUddOEivnEGEb0wlKpoRTFWqf3GyTYGptQTc0goDGD65NBupg
	Fw+LCXfkWg==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 47jcy34tf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 01:06:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPOIuez4n6ahj/aK4VymT39JDgQyezT83CWxUweMH1rYEg2gTX6doDKMRj+QVpuyYBc21vmggG9xhsccU495eFhTXqcjyiD+hm+bSUaQoqRU3jKRYtU5go7uKRQwYYg/fFrdneoiSq+dUm/nVy39wImAvXr/e9g10wRGBjLy3YAio/0OO5nWSpL1VRN4w3RKxms38rG77dxRr4FeJ+M61g42OvZ/xPCVLvYAAyWJLrogJamuE+3k+8qETrwkUPypGYVsHggsIANjPAL5JRAf6pPxRzNiRKX2426+L3fp5dvmOkYUZoNlEWjlXjHWT86TTc1NwhlPKqXvpW6gMgQMPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jw54o48Nlc0ASP2XSFUx1nG16gk6xP5K7M3AEAqjEKA=;
 b=yRIQBzAcy9OkAbFq5ZlqVZVqaHgrdESPLt0lCkiPglVbPpqygd86a+W5o5A48LJMdAdSZfg9sK5FLcr2KWAF2m65XEuYTklPdCXnPlEMxxQTEJpoOrfbd7p81hHuiGF7yPtREpy5sYFhN5dv9qKqd1iVl/agGmTLtVmz3IPFeJp5I8kRI5xPEUALFXw7f2ZEoq3jr8mE8c4o1MZ78nQ7vR+ZXLJxcJXhnMSIRkOBTBczjSBXdMaYi0llBMo4cC+Yy4eygAMoNHhP+v/d70v5gV9SbJVZwmS3fDumNuXZbCkNYPKyjGMcbE0S9P7YhDpIq42YFzY7n3d72hyMZ6q6kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jw54o48Nlc0ASP2XSFUx1nG16gk6xP5K7M3AEAqjEKA=;
 b=F2USULzOTBleQCdkEwSAgBPM47AUeixoisjzvvevAMa8SxWZfSXnnV15rGXJROl3HX6ZfCcbPZYVP23YB3/yNQp4vZt1mhly5Z9pUpDS1Aq+Z7I2KChAKdLh0esxVZ2jpXk6yTclUHAnPe2kh5VB6wy+RDfGV02+QxZIv9FnZYU=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by CH0PR07MB8858.namprd07.prod.outlook.com
 (2603:10b6:610:103::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Mon, 30 Jun
 2025 08:06:47 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec%8]) with mapi id 15.20.8835.018; Mon, 30 Jun 2025
 08:06:47 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: Hans Zhang <hans.zhang@cixtech.com>, Krzysztof Kozlowski <krzk@kernel.org>
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
Thread-Index: AQHb6XW6OLhXudgydkKfwI+xEE1N5LQbTsYAgAAJBgCAAABtoA==
Date: Mon, 30 Jun 2025 08:06:47 +0000
Message-ID:
 <CH2PPF4D26F8E1CC95F84FFBB099955A065A246A@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
 <20250630041601.399921-2-hans.zhang@cixtech.com>
 <20250630-heretic-space-bullfrog-d6b212@krzk-bin>
 <afeda0c7-1959-4501-b85b-5685698dc432@cixtech.com>
In-Reply-To: <afeda0c7-1959-4501-b85b-5685698dc432@cixtech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|CH0PR07MB8858:EE_
x-ms-office365-filtering-correlation-id: 01935b08-eb50-4e18-7f1b-08ddb7ad0f75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U0RGY3d2Mjd1ZFRxUlZueks4SGNNeUxpMlAvYnpTMGZsV1YyakZRL0VxUTAy?=
 =?utf-8?B?MkNhRW42Y1k3aFBSL01GUmtHRXBOT0p2RkJHcXVjQWNvaU5PREtjckYrMVcv?=
 =?utf-8?B?ZXJjajZXZFFqanI3ampkb1VJTXdqbCt6VmQ5SURJMGN4OXpqbU5Da1RGdm1R?=
 =?utf-8?B?WUFQdjIyTnVGcFcvMXhZc1VKZ3RyRjdQQk85TnlUY2FoNy9vV0dSK3ZGdTJu?=
 =?utf-8?B?SktMWmtqN0E1NUY2Z2JMTHdnZVkrN2dHeUh2UkcyckFxMW9PRUEvUjBXeVhp?=
 =?utf-8?B?bWMrVWhXcVVadnR1b2crU2NYRUFLVGRycWRIQnIrU2g4OTd1c2swTU5HOHhy?=
 =?utf-8?B?MFpMQm1pMTNtNlZvYk5aNTFSNE1wb1ozL2QyODFlUDlGZEdzWG5NdHYzazVj?=
 =?utf-8?B?K2JzQkVLWUh5MzkrOGtJaUUwYVRLbjRodGt4d0Q4VC90NTdWbmdPMnMvZjlB?=
 =?utf-8?B?YkE2c1ZDTVJGT1VsRUh4N05pUGdBajhEME9aOW11RmtIdWo5Q05kdWZlT0Yz?=
 =?utf-8?B?Y3VaTG1acFZXMnhRZVlDOHlTY2tuZ3ZWa01zWDlxR3JZN20vTVl5aDBETnBB?=
 =?utf-8?B?bTlZeDREMUhZd2JWZlpmQmtzZEdORVMzY3BlUkhya0t6WnIwbzVaM05SNzk4?=
 =?utf-8?B?UG9YZGhNcThqbk9xVDJOdDdPVlNZTGI1RjFGczVDRFR5ZjZXRnVjRUxhTi9L?=
 =?utf-8?B?bnJCVjdOZGZRUEtuNm9SaGo2ZHU1cnpYR3hiWFdJUW5Dd3hYb3k4cUFkVm9w?=
 =?utf-8?B?K3pWcXgreXgvZ3VFSFVOOHk4anpMQ1BDWi9XMWN2eGdnQkY4VDZmYUo4WVlL?=
 =?utf-8?B?ejIzZU9xZGRrUGxhWXJkSlk2V25QZHBldk8xRTFtWVhQTno0UERiY2R2OVZi?=
 =?utf-8?B?UHBaVnBwSE9UUGpsaExNM2JMNHFBWWh3Um00TmtiMHpLaDhnZnpjZWJFYnVS?=
 =?utf-8?B?Q250aXQvcDhjSXdTZzlrYStKUzEyTkxhQ09pbCsvdURZWEdEZVVjQU9taWgy?=
 =?utf-8?B?aEdJYTRva0tKdE11aTlZWUlpbUpqTkFFaFRqWmZ3OUtUelY4Sk93cXdwSXpm?=
 =?utf-8?B?L2hBQ2U1eGNzaVNURlRtTFh3Q0FVRTNIblczZTVmQWZZY01rb21FQXFDcG5R?=
 =?utf-8?B?Nm5WN2ttNUF3eGJFSklvWHVpNUQ0WHNOZitSSm5IeUdFazhPcEZwd1ZNVnpy?=
 =?utf-8?B?UHpwbUhzUDBYUVRaRUZLc0NNeXJCUnRuRHpLVk9pZzlyZTBxOVluTXVjTEpa?=
 =?utf-8?B?R3RiUnAvZ0RpRHBaRU9VQmJZUEN1M1lIY0JiRVZCRUsxY0x3ZU04MEpFWFNl?=
 =?utf-8?B?dlg3THZTQlg4QVhvYzNFL3VSSC9zZVMxSmo1VTFFVnJwZUpxaFVrNy9xSmVz?=
 =?utf-8?B?S2ZPTHZOSlNhQUVLdlEzcjgzK0FNVE5YczMxNUpPNjJXSy9VMXZ5eFdESkcw?=
 =?utf-8?B?eTZXL0E3bFZIOFFaOFBpSXNJdk1tS1FCV1U3YXdUWVlJZ3Y1SDBvMWFvaTNW?=
 =?utf-8?B?SzNBM2x4cHBlbHNmaXlnVDBzdDVpOFRNME9RMnpTYUhHUXRkNnhRTUdtakVN?=
 =?utf-8?B?KzI4dFZ6blBJd2RZd2xWejZ3My9aakN3RFZsa3JOUFZ5NVJOTm45ZnJBR3RF?=
 =?utf-8?B?ZVFtYlZnbXpxRHZGdnFjbGE5K1lqTll0MnNYTmJkNWg2eXUyQ2xkOCtCK2oz?=
 =?utf-8?B?SkVoV0lZM3E1OEpyWHIraTlVRWFhWTNMbkhoY0lHOVIxUjdBNExrMWtiVWRj?=
 =?utf-8?B?T3pBYXpKclZ4WWRRMkFxQzBnaVVQaWJ6SFNUUWdLTHo4MGFPZzAyZytXdWFJ?=
 =?utf-8?B?YzZqWXg0NmZaazBQWDlGMW5wUVJVUDJqeDlmQm8rRTRqUDZEV0NXcGdKMXhr?=
 =?utf-8?B?cjBkSUlzaEdVdkhvRXV0Vm1qbTBQQ1R2c1BWM2FKd1g4U3hpR2JhYWNTOFor?=
 =?utf-8?Q?MK9UcgcWhPw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZXVMenQ4T21PVVpWeWxKTmdIVVArQnRmbVVZdnp0cDUxSkV3NGRkdSs3NlZx?=
 =?utf-8?B?SitUMU1FY25VRnpJOGFpNUlUdDVZdG90eVovNC83UzhiVldtYnRFWmdKekVh?=
 =?utf-8?B?OCswaHVLc09PTDEySFQ2TnZLUGNXMHAzM3VFVmNpVDNPaXJIUTN3d1k5azFD?=
 =?utf-8?B?ZmxYWmMzUndTbkg0emlUaXZKVTF4dlJjSWtyWFYva3Y0YWVYYmdObnFtR2wz?=
 =?utf-8?B?SEVRdnpIV3NYeStUR1NJbS8rbWQvdzNMenJFRTQ2WjRpVks0N09VcGF1OFdx?=
 =?utf-8?B?YVpnQUxIclNnZ2dPaHEwWnZQYW9xL2R3Q1kvZW9LbVlWU3lwWnA0SXkwZ2NZ?=
 =?utf-8?B?OVBJbDVJdTV6QWZDN1d0VFJ4WkRramFQbWs1MkRwU3V5L2p0YVJoR213YUV3?=
 =?utf-8?B?cFN6RUtxRms1OEk3bjFLR1F6aGJwTklwZi9ZLzZmV3VGOUpVb0djbFBTU25q?=
 =?utf-8?B?REVUdVRWZG5kcmNWSFM5THJvTWN6RS9SZGF4cFhDKy81clMxeDFBd25OUmor?=
 =?utf-8?B?SjF2Q05RMjl2bnBYWlNyTVczNCtNMlpta0lwZEpOd2VaQkduOWJMeHNvTzI3?=
 =?utf-8?B?dXorOUVYWm9kMnhYMmZ6aG03YmE3OFZFaHJhUjhvaFRkSFJ2N2ZFZjZHY3VM?=
 =?utf-8?B?TEpHU28ydkdBaFNjNXZIS3lDUWwyKzFxRGFNZVVJRm94K1dHdllrY0FmOE5h?=
 =?utf-8?B?S0NLNjdQdTVIcy9hSnpSeEVrVVhpdXhHUTlFdDdmVmZhN1pPSzhPNzczME8x?=
 =?utf-8?B?cVFRSklWVzU5ekxKU1IwVGk5R3dVMXhSaHpqYUxCS05WdStPbmhJblprRDBN?=
 =?utf-8?B?ZElSd3ZhdzFwV01TdlRHeCt6bk1Db2ZUdGowaHRZai9nN1A3bDkzejZrbHRD?=
 =?utf-8?B?MDFKOUVJMnJ0cWgvZS93THJJSE42SUFQVGVLOHVrQnhJY2l1RUF5S3JCV1Mx?=
 =?utf-8?B?RTJldGNqYzNxdENUSU5UUVBzUGZHQlBhbTFkUzkrNlM2c2p3ZWRFbnJnZSti?=
 =?utf-8?B?bHA3Y0MwNXhzeFZJNDB6ZmI0TG5qQzdZQ29RY3Y5N2c3MVhHeXo0dlpXcnVH?=
 =?utf-8?B?cFp1bGZMT1REMjM0TmtvcmwvZEc1RTdONERaSUliYXRybTJscTZha1NITG5y?=
 =?utf-8?B?dWNUYzlSbldPa09kTjVlbnlIRXpvS2JmK1BabnpmYjBEWjZybU1rckV6TENs?=
 =?utf-8?B?SDZJQVo5SkNPNlA4b3h0c2xEUnVlWkN4d1BsakN4VnlWQnowR3p1K1RDWkVm?=
 =?utf-8?B?bis0bi90WkNFQkZhOGhFKzczdy8zdGhDZHJWaWdNdU42OEVxY1kyL3ZhaDdP?=
 =?utf-8?B?MFBINDNocW1QZ0FORzRaS21IU2xlZW53aHU2U2ZFZ2l4R3VwaktVVlhjaHhp?=
 =?utf-8?B?QUxrOFQ2TSt2U3BLWDhNWTJ6bkVwdWs4WkdiQ2lhclAwYnMrZlhRK1poa3Uy?=
 =?utf-8?B?VlhVT2xyU2tIWVIrN0dMOVVnU1haQnQ2N3MwUE8ySzFMTlh2bFRMZ3RuLysw?=
 =?utf-8?B?SHByYjZCcmhSNExyVkN0THVESkdjeEV1MHE5YkxCSmRjam9sb3hKa3U3dTVO?=
 =?utf-8?B?Vm1TNW5SeFRtOUI1M1ZmMTFtQ1VHd1prOFpTQ2FRcTZXRFhQc0xPdjQzOGFF?=
 =?utf-8?B?Y01zM1NIODNpcnNHVExveWNhUjNhNmFDR3p1SWZoZEI1ZnNUbXBwMUExaUEy?=
 =?utf-8?B?Y2xrazlCWXUwaVhNeEROcVpVUFlFOXNJUW1HM014UUdvbnV4TkpQc1NOV1Vi?=
 =?utf-8?B?T1kyLytjcXI1dFZQSWZ0VnMza3JTcGJla1hwVVFIVEpmWm1MQVUzYVlUNG5w?=
 =?utf-8?B?TEpYcU9yKys0bmp6LzZWRDBOaXNhRFpBcUF1dUROWWNWT1dMQURpNm9WZkho?=
 =?utf-8?B?U3RZMHAvMENJdU54dDZNOTRhbW5nZkVKdXZ3Tmt5dzlzZUJIS2JwZUpqVEdo?=
 =?utf-8?B?RVJlQUxuYXpMeEc4bUl1YWtrenIwTEljRWN5ZUthSktIdmY1UnBwRCtjbHp6?=
 =?utf-8?B?UmJ6RUJQaDJuTnBab21yVzQ1V1UxeHllVjVKeEVrUUZZeXk5WTV1dTNJZVl1?=
 =?utf-8?B?cEJLcHZsWFNQTHM2cEtBQ0RZaUhieHlZdmNnWitDeGZnbW13cFZrWUxPNlJH?=
 =?utf-8?Q?MktD14OxG2+pjLqHLC7+qyOHV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 01935b08-eb50-4e18-7f1b-08ddb7ad0f75
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 08:06:47.2742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N5CcVajpuxkvbSDZmESYecFa1lFzF8c8IF0cm8A7W1fXjCaPKyh1ZMJR+1m3OqUc/89j5KcJK/xCWq9LZ+Evq7Yc3LDPa4/sa+dmLdkVbxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR07MB8858
X-Proofpoint-GUID: XkQuNKfFAELrQZJPGFsyVde2wShMfRqA
X-Proofpoint-ORIG-GUID: XkQuNKfFAELrQZJPGFsyVde2wShMfRqA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA2NiBTYWx0ZWRfXyvPf+scHS0HS vyWa1UCKbWcXsbmNaDf6ZSCN1Sd3OSUMaHzSg1Xs9V7wwYPfHRQ8Zn9AyJGlxy7DiRlSoiON39T +nxydOTXCOwFBitIqi44ybV/j+llKe/v70RpJ9zkT5fQWhH7DbQ026g7aGDivEn9x6oLmMFbHHL
 wboNcaH5a1ZIx76knYRGhvDCf+17btHBmibDUVWLlhUi3xYmSl40bbJqWVhbSV90H7yGDW72J5K ezwejpUkH+/KZ+3SPzhNi0VN0i4gfhex0C2YxevD2lwpARVzTECRUV7mt8SBwErojiSIOhOjlUO klLKFOO3JwyoPf8kFuIJP+U2Eqy+rl9vHGJRJqbSVmnBWpclMrXt4WmAVkjVRewBKw3AnUVQXqA
 iXmaFgJLXqh1XON3MZOUf5tErF8hW2kZNU5NXuPaYxEEG0k1cukyKwgkUHxPB5RdJ4f9hPs7
X-Authority-Analysis: v=2.4 cv=B8650PtM c=1 sm=1 tr=0 ts=68624599 cx=c_pps a=OlGsJSUUIKrblIYSkUKehQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=Zpq2whiEiuAA:10 a=uherdBYGAAAA:8 a=VwQbUJbxAAAA:8 a=TAThrSAKAAAA:8 a=Br2UW1UjAAAA:8 a=wEPfRgp8gZVIZINDxZcA:9 a=QEXdDO2ut3YA:10 a=8BaDVV8zVhUtoWX9exhy:22 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 suspectscore=0 phishscore=0 mlxlogscore=961 lowpriorityscore=0 spamscore=0
 adultscore=0 clxscore=1011 malwarescore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300066

DQoNCj5FWFRFUk5BTCBNQUlMDQo+DQo+DQo+DQo+DQo+T24gMjAyNS82LzMwIDE1OjMwLCBLcnp5
c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPj4gRVhURVJOQUwgRU1BSUwNCj4+DQo+PiBPbiBNb24s
IEp1biAzMCwgMjAyNSBhdCAxMjoxNTo0OFBNICswODAwLCBoYW5zLnpoYW5nQGNpeHRlY2guY29t
IHdyb3RlOg0KPj4+IEZyb206IE1hbmlrYW5kYW4gSyBQaWxsYWkgPG1waWxsYWlAY2FkZW5jZS5j
b20+DQo+Pj4NCj4+PiBEb2N1bWVudCB0aGUgY29tcGF0aWJsZSBwcm9wZXJ0eSBmb3IgSFBBIChI
aWdoIFBlcmZvcm1hbmNlDQo+QXJjaGl0ZWN0dXJlKQ0KPj4+IFBDSWUgY29udHJvbGxlciBSUCBj
b25maWd1cmF0aW9uLg0KPj4NCj4+IEkgZG9uJ3Qgc2VlIENvbm9yJ3MgY29tbWVudCBhZGRyZXNz
ZWQ6DQo+Pg0KPj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LQ0KPmRldmljZXRyZWUvMjAyNTA0MjQtZWxtLW1hZ21hLQ0KPmI3OTE3OTg0
NzdhYkBzcHVkL19fOyEhRUhzY21TMXlnaVUxbEEhQm8tDQo+YXlNVnFDV1hTYlNnRnBzQlp6Z2sx
QURmdDhwcVJRYnVPZUFoSXVBanowekkwMTVzNGRtenhnYVdLeWNxS01uDQo+MWNlalM4a0tadmpG
NXhEQXNlJA0KPj4NCj4+IFlvdSBjYW5ub3QganVzdCBzZW5kIHNvbWVvbmUncyB3b3JrIGFuZCBi
eXBhc3NpbmcgdGhlIHJldmlldyBmZWVkYmFjay4NCg0KSSB0aG91Z2h0IHRoZSBjb21tZW50IHdh
cyBpbXBsaWNpdGx5IGFkZHJlc3NlZCB3aGVuIHRoZSBkZXZpY2UgZHJpdmVycyB3ZXJlIHNlcGFy
YXRlZCBvdXQgYmFzZWQgb24gb3RoZXIgcmV2aWV3IGNvbW1lbnRzIGluIHRoaXMgcGF0Y2guDQpU
byBtYWtlIGl0IG1vcmUgY2xlYXIsIGluIHRoZSBuZXh0IHBhdGNoIEkgd2lsbCBhZGQgdGhlIGZv
bGxvd2luZyBkZXNjcmlwdGlvbiBmb3IgdGhlIGR0LWJpbmRpbmcgcGF0Y2gNCg0KIlRoZSBIaWdo
IHBlcmZvcm1hbmNlIGFyY2hpdGVjdHVyZSBpcyBkaWZmZXJlbnQgZnJvbSBsZWdhY3kgYXJjaGl0
ZWN0dXJlIGNvbnRyb2xsZXIgaW4gZGVzaWduIG9mIHJlZ2lzdGVyIGJhbmtzLCANCnJlZ2lzdGVy
IGRlZmluaXRpb25zLCBoYXJkd2FyZSBzZXF1ZW5jZXMgb2YgaW5pdGlhbGl6YXRpb24gYW5kIGlz
IGNvbnNpZGVyZWQgYXMgYSBkaWZmZXJlbnQgZGV2aWNlIGR1ZSB0byB0aGUgDQpsYXJnZSBudW1i
ZXIgb2YgY2hhbmdlcyByZXF1aXJlZCBpbiB0aGUgZGV2aWNlIGRyaXZlciBhbmQgaGVuY2UgYWRk
aW5nIGEgbmV3IGNvbXBhdGlibGUuIg0KDQoNCj4+DQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBN
YW5pa2FuZGFuIEsgUGlsbGFpIDxtcGlsbGFpQGNhZGVuY2UuY29tPg0KPj4NCj4+IFNvQi4NCj4N
Cj5EZWFyIEtyenlzenRvZiwNCj4NCj5UaGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3VyIHJlcGx5
LiBUaGUgcXVlc3Rpb25zIG1lbnRpb25lZCBhYm92ZSwNCj5wbGVhc2UgYW5zd2VyIGJ5IE1hbmlr
YW5kYW4uDQo+DQo+U29ycnksIEkgbWlzc2VkIGl0LiBXaWxsIGFkZDoNCj5TaWduZWQtb2ZmLWJ5
OiBIYW5zIFpoYW5nIDxoYW5zLnpoYW5nQGNpeHRlY2guY29tPg0KPg0KPkJlc3QgcmVnYXJkcywN
Cj5IYW5zDQo+DQo+Pg0KPj4gQmVzdCByZWdhcmRzLA0KPj4gS3J6eXN6dG9mDQo+Pg0K

