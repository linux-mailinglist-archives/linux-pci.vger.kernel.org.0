Return-Path: <linux-pci+bounces-25652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17162A85278
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 06:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03FCC4C11C5
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 04:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17F71581E0;
	Fri, 11 Apr 2025 04:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="oTi+yazF";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="w53lNV/s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B003234;
	Fri, 11 Apr 2025 04:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744345624; cv=fail; b=Ci+7I5FphBU0Nvg99pTx0OTDqg+6hrKbTSGU163fnBvi6mHV2i7ILDw1SQe5CSnauljrWqwmk397cgBTrdYwVsauZVK4fmQAlzMe0g7NMWuYB/G/vY8mxckjtZjRDbR3YWtnB6oT3O/WkaatxQLeFYf1xRZcgClKtIklJEiKnMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744345624; c=relaxed/simple;
	bh=WAu+vA4PjkAsyN2egsoNGvmabPuYT/HzKr7Rxr5TSPA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t+IhE/byxWinSsgXbrCdWlGD+F5fCOW/ViZheXIJKo3q7UZgO/yQEH5ncOVVJ1CFkkAIlbnRHVW++6ejPUytwrVBnD6rQeaOeMratHtTL1K+zHZwZ42xwnGZzDIgQ0js7fVa2zBY5nxW366aIde7di9NjeVTqKV05IjkxJj+Pfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=oTi+yazF; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=w53lNV/s; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AKwjFN026792;
	Thu, 10 Apr 2025 21:26:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=uV4DPvgMMLRWS1vwd5TS9bbhrWQjpGFnCRoV+BaA3cI=; b=oTi+yazFJdO+
	1Xrd/hub6fv7E87+p2o5TXpMnXrHWlk51Wr0inleFlmYVHpvg3pmpGT0UH8aBzQD
	2xE69Y8zhmvQNqr4PW/TQLYN1IRiCNeaO3uSiHSVMea+12WCU9PmdGwc311Pg0Uj
	/dKCnhNCGQ4KLs//UA4fpcW5pmNV/He2AU6UEaspC8qlakWBtxY3f57KAWfxrVUw
	lRKClZWg7Jrq3C+CdpWQ7EEJKfpTt8eWo9YzYhI8k1K9ZUuFtvvTfxyTEKw+fEsc
	u+4vW0kU3x28KButRCCQsDTOcFpra4hy8Yp79hPXVSId5tzf9gcWFit1NALqKeiv
	oJahfyzkEg==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013078.outbound.protection.outlook.com [40.93.6.78])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 45u03wufa5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 21:26:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5ij5uN7eytXnXrnoVQyKETOCnPh8QfL7yHItvzlHIJBSZh96t0h/b420Ylz1Gb33iAmiHs6w5XsNTviqolNif1bs/mhJT6fH7NxRif4pqW5xxuvAN+YYa/lUqPhhWaRqjZKtwSjIaGi3vR5xAkBZ1ZbaDZkW2xcs62Pc8DLJPkqnt4UJpC0UKQif6fX1iGH87gOvGUehY1+8drhDX1+Vg0LpO+F5Rjn947pTqJRLyBB26hAW5ZbcTu1LONKNkAJJ+b/vfqIMEHA+qTJAF6yNZ1K3IHgzIS9xLFIFQc2jmn1h8LdgMxnEDJH0mHANFGsrcmWnfnzX4BTg0i3lnIqEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uV4DPvgMMLRWS1vwd5TS9bbhrWQjpGFnCRoV+BaA3cI=;
 b=nma44ghM6LAwE2YoyqOSQ4ApYmoy+ga6d8WVVN5Q1llNbf6GizrM3qidopxFS5C92pLEaOTpinuzQkfHaofxvcrekhucEqHP1jirqta6BbqNql73jIw6SF5Fp3HgYq1qpvMGMtUrQFlJv1MC4zk4tt/wxhatOnHokcaP5iqsY1HX5ZH7HSIxsFbxHGE3srukIzncS6E7nZzwwqJ8ywJ0KC593m+gZtOZlPDGtJcGtCUGfRHV9I6d8+hRvzMS4bhCZwj4jHn9w83nZe82dSET88m0ulRJkJtK6cevn6piua10iwECEC/spJ90LN8PeN85gBo5nmLZeQK784uLXavz9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uV4DPvgMMLRWS1vwd5TS9bbhrWQjpGFnCRoV+BaA3cI=;
 b=w53lNV/sgqJYqMtHmVZre3i1/xAf2FCJTCu/dlysg3Hi1PJ5oNAvqiAKPaTqZm4jmGfOhxN3/d3aqHb3gTOQc6Ncb/dWPnn5XVzJ/a9c4gjEfWPq29eyogKq+wWEJcNcWfj/sXwInuh9hYbhkgEl6XwBORLaSIYrHqq0+qLDBXE=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by SJ0PR07MB9170.namprd07.prod.outlook.com
 (2603:10b6:a03:3fb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.36; Fri, 11 Apr
 2025 04:26:47 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec%8]) with mapi id 15.20.8606.039; Fri, 11 Apr 2025
 04:26:47 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 6/7] PCI: cadence: Add callback functions for Root Port and EP
 controller
Thread-Topic: [PATCH 6/7] PCI: cadence: Add callback functions for Root Port
 and EP controller
Thread-Index: AQHbnwk5HS8Gr8jva0mrXd6LPp1H17OG3FPAgBUnr4CAAfDgsA==
Date: Fri, 11 Apr 2025 04:26:47 +0000
Message-ID:
 <CH2PPF4D26F8E1C1BE8640F6C59501DF49AA2B62@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References:
 <CH2PPF4D26F8E1CD797FF6A6A2698036717A2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <20250409224507.GA300150@bhelgaas>
In-Reply-To: <20250409224507.GA300150@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|SJ0PR07MB9170:EE_
x-ms-office365-filtering-correlation-id: 4a00cc23-12de-4031-a4ad-08dd78b11276
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?IGcELsd5khCgL+nUQuZTzksYuW1sLDEFPdW+msOE8ESqF++l6c/yY9kjZgHO?=
 =?us-ascii?Q?6w3y73YPNz5snSHhjncnsO7VrJLV1wP77s3MAJYTJJkwBWBIEkJS1P3zftKq?=
 =?us-ascii?Q?mF1cM7Ma18S9ddkYSpiXdLrQ9dXi3DuvcKPFOn0nJ67HquB+darX57nq0z0a?=
 =?us-ascii?Q?233Ecdo1bNXpzfPubCcl99oP1lzX+szCVrQO//+bQr6fi8mU1FbuSjLqyIPm?=
 =?us-ascii?Q?FBWrs3wDTVCHSKpI5Q9fGRndb3JN3iLZMkRED2fBI66dRALb3oScSMBD3Z1G?=
 =?us-ascii?Q?JPQmx/1Bc7AUxuFWV/LvLc/XWStbdxbLAqeXdMhLguxewPlCeBvhfFQz8iCO?=
 =?us-ascii?Q?uDv0u63omLVu6Fl5HvNMMOXMreZKNsZVo/Zn/YOo7mSttDf/O/1zafdoE45X?=
 =?us-ascii?Q?oc2vRdZBvVRJay3tForJM8B57wmKtYhoZoXgYdQN50hMh+zdMy1q8q05xTec?=
 =?us-ascii?Q?S9IvhirFLiswbB/FgTzzCiZ4u6KMguPTHaR/btc3h4fX1QxwYFcIZKRu7LTQ?=
 =?us-ascii?Q?7EQsMqMgk+IL7XCdXceYlVTKq6qcCxySaIVCkyvcWRFO+QYPN1Xw5sL1BvX5?=
 =?us-ascii?Q?mdtuD8g3tUu7xeJv8bVuo2TpOBMnApw0Cycm/v7P8mwy60l9eFNtxp5kTJcD?=
 =?us-ascii?Q?USlKa0TP04wW7ioq6SI4WZsLrMWbxB05Iwoc4E4kJ6ZeXRnjKM2yzSjaCUXF?=
 =?us-ascii?Q?1Ut/sEpMu+B0B2nr4v4kJ6qPBNhJuQTuz0djYzTH0NOCmd8pQfN5s4vbKVBd?=
 =?us-ascii?Q?a45CaA0vAqaeiLuvNWd2NkjuUxSqGPG+KWKTJ0xW/OCYggBTRBmqMITBooH7?=
 =?us-ascii?Q?T8Uul4DfqznwFQSVyWl3ZVCW6G5/4R0eo/OODiCwVGac8Oyy3emdHrPW5aDC?=
 =?us-ascii?Q?Y7zenUvHwr5qkMdJlbw64+/oeL5D98VgrYqhyCbvKNrrgFRjH2SooQJu4LRw?=
 =?us-ascii?Q?lS/mMi4eh97OdCVc9M3WotvUty8fRHuwoguyk4LIo+BSLat10P0vhk9PlZvi?=
 =?us-ascii?Q?G9g0st0o4YqJiAaU9mTlz+MFSaz7PjTEhhONKTSzztckA85accTy8ip2+B4T?=
 =?us-ascii?Q?hQ55p7/f78PVw4OMQU7pgkV5IctmLk3Q5v54C/czcbdW7yLyLQxeUJt5BCk9?=
 =?us-ascii?Q?JuMJKRgMNd0fvnh8pQAyIGm35g8PdxBqFsAW6J3cRlWQZVgAep7pYXh0nBW0?=
 =?us-ascii?Q?7RTNy7oxfrRD04RaXrvTtt1mPulqzZQvO2ENKjPUVqeHUhTeEAlgTkVMgxg4?=
 =?us-ascii?Q?aJO4blNuPmWv3dU/jNje982aJ+dCxkdG1T8U39l2pVKtIFK1MVgJbKLI2oER?=
 =?us-ascii?Q?imt+pzCCG0TPo7U71eh+UiNYQPkPZZmiNsBvBXe+FOXKwDXFKMbYCjGtjVRw?=
 =?us-ascii?Q?efNTMlrBCI9v5BdoK9apkmzPZY/4Swgrs4Ga9JqPZrzWYc1/UFtP5iDEm2IS?=
 =?us-ascii?Q?uS0WvnTyfeY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8urBTsEx1+aZ0vdzOGXYzOaGINMJHDt9z6LltGPPKaFnzGmNyRdl6Ib9AM+F?=
 =?us-ascii?Q?nqMHPeNf603yYge+WLtonqfumRAEJ3FHSqW0+Dgdf9kfAsFgLhBtvjw1yNc3?=
 =?us-ascii?Q?a8yuoWvSmFZBaAy9Z6nx/wdsv12Il/BZKKCZ9RTV0Mja2XMV6/h39RxuN+d2?=
 =?us-ascii?Q?YxWzFSfgHLnkb+XVgkYA7n9I8mk0vYgzlpGLrcGx6wjVqwwXzLJ1YWtic/+0?=
 =?us-ascii?Q?UrLKE8dT1fZyNRCVZFqLGRuT/1XztP9qHf0BuNHrZsOS9JSffBd3HurcdtuT?=
 =?us-ascii?Q?SeVMt343oenvn+A/umgo63nLgX18pXEBXs8xr6u6tbZyIgWTamBd2Ixvyx+K?=
 =?us-ascii?Q?89UWyZZsZhwpYTUuwdhGYrATrG5fGJ+w6L8gdj8+clbAjhlv797fv5KoPEXB?=
 =?us-ascii?Q?PgR5+9exN1zMoEAflhpBo2FkGxW9PxuvsCFJ6wlIabXhBJ1P/pwg8RXoC7zX?=
 =?us-ascii?Q?5qnJI1CJFF+rVG9kJWg3CIqNMhgrPIHFdr98Sml3mgWHjKk+0fvHtRdV7xEM?=
 =?us-ascii?Q?y/bNon71pPhdUeGn4QUyQHb8bgPgydmuXbzeP4s8+aZ0PpxI1NNMtKzZsKlp?=
 =?us-ascii?Q?x3R4t0Zxk7N9I7qEc31ZBYbmw06YM47oDgaELPP7O28ljiCjXyN9vvxMnqo4?=
 =?us-ascii?Q?6MNCnAQNRj1QaU4lJ3JzEE95K4GdNwwKBmBh1G4R9ciWDqoeLrkdSalz2xoJ?=
 =?us-ascii?Q?PJKwrsFjxoK7UKwWywVIjTQXrEFHwxei+e6I1WxUcbJQaCo8j302z+tZTV2e?=
 =?us-ascii?Q?G1Upl8sTDxt/RNuPJpBalXVfG2A0FQVDCG6EhgxhL9R4UEAnsMnRSxR7RiSB?=
 =?us-ascii?Q?V1gI+7AeA57M1baaT7179LRN1Hf6x1JQtTbmbnOAw1aT+30OkCuSHeyzQedF?=
 =?us-ascii?Q?LCA4zxqs+42u4btoHCfgJymsR2sNkql78NYPgwAMSSOG3bArja9sYq2xTQQz?=
 =?us-ascii?Q?hna4W0Mpa4vxyAcF3vM3Em6OD1L4MnRXvmE3RA7uTqn/AtxrdNmRDvTtq2j/?=
 =?us-ascii?Q?E1+lX0cdbpGbTPwLZBlsPbhQaXPL3NT1I3JoGX+slYk0PdoIS8gM6iJmHecc?=
 =?us-ascii?Q?waV7S5lgy6kDPJc6BNekf/7uh1HnaQByYdSTgSHX8RqW0Ye/rzy3370/QA/f?=
 =?us-ascii?Q?fxB5gD6yodWhvhXksXDnGcMsW/qS30JR2IdZbsEucFTz1m2v94l09CWY0ywd?=
 =?us-ascii?Q?iMw61fWkYbFkdvKR4BmRGEw0FU9ezQ/D41lj+yezK0wCRZjqHANTAR5rVap/?=
 =?us-ascii?Q?8PgFZ0rw82u/T3ZF1w+u9pjQ2RNl+YwMCwvrA2ku0wN1SaHzhBV50Qkl4bP0?=
 =?us-ascii?Q?/iHRyeQD8aqxbzGB1GSloGIHJiaFYKlmpPco8Kbze48fx2gDF8R9vWUXkb2k?=
 =?us-ascii?Q?XuBvCK4EPgmeAZFzKSuWeDvYVn370+zNvrn24D+kTU0piISVcuctcMnksufp?=
 =?us-ascii?Q?9sz1xoEy+U7c8+kaNdA2NZEVx4o1B3ES4NzWgl6LpmGh6JK7zRO5WpsF+KVH?=
 =?us-ascii?Q?2U+QrbczV34FcyE0ReXrqmzOvjvo0gEaddHJFypFt447TA/hzEjlmUQF5LNX?=
 =?us-ascii?Q?ihnqgFjjibnvKiNsGSAlj3VcnzjRRaihVYqgvyIvaSy7CjaytfnW+NK6hekW?=
 =?us-ascii?Q?cA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PPF4D26F8E1C.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a00cc23-12de-4031-a4ad-08dd78b11276
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 04:26:47.0553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qxbiHX2bF/OFiJAaRb/Gk3fN/4bgwDccklidBf/BdhcQJpGfCD8SM/hs1mke5Ed7m/6Jyi4RQJyRkGjYY9qVcCiAtdKlEJtbwZftOC0pMoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB9170
X-Proofpoint-ORIG-GUID: QuXPCYqaSjNfp9BZuxZ8xNjDreBW3vuR
X-Authority-Analysis: v=2.4 cv=Qcdmvtbv c=1 sm=1 tr=0 ts=67f89a0b cx=c_pps a=BALyy5icRfvvzfOMzojctg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=Zpq2whiEiuAA:10 a=uherdBYGAAAA:8 a=VwQbUJbxAAAA:8 a=Y9OXOndnX01x1UINIbgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: QuXPCYqaSjNfp9BZuxZ8xNjDreBW3vuR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 clxscore=1011
 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110030

>[+cc Frank for .cpu_addr_fixup()]
>
>On Thu, Mar 27, 2025 at 11:42:27AM +0000, Manikandan Karunakaran Pillai
>wrote:
>> Add support for the second generation PCIe controller by adding
>> the required callback functions. Update the common functions for
>> endpoint and Root port modes. Invoke the relevant callback functions
>> for platform probe of PCIe controller using the callback functions
>
>Pick "second generation" or "HPA" and use it consistently so we can
>keep this all straight.
>
>s/endpoint/Endpoint/
>s/Root port/Root Port/
>
>Add period again.
Ok

>
>> @@ -877,7 +877,7 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
>>  	set_bit(0, &ep->ob_region_map);
>>
>>  	if (ep->quirk_detect_quiet_flag)
>> -		cdns_pcie_detect_quiet_min_delay_set(&ep->pcie);
>> +		pcie->ops->pcie_detect_quiet_min_delay_set(&ep->pcie);
>
>Maybe the quirk check should go inside .pcie_detect_quiet_min_delay()?
>Just an idea, maybe that wouldn't help.

After going through the code, the check requires to be outside.
>
>> +void __iomem *cdns_pci_hpa_map_bus(struct pci_bus *bus, unsigned int
>devfn,
>> +				   int where)
>> +{
>> +	struct pci_host_bridge *bridge =3D pci_find_host_bridge(bus);
>> +	struct cdns_pcie_rc *rc =3D pci_host_bridge_priv(bridge);
>> +	struct cdns_pcie *pcie =3D &rc->pcie;
>> +	unsigned int busn =3D bus->number;
>> +	u32 addr0, desc0, desc1, ctrl0;
>> +	u32 regval;
>> +
>> +	if (pci_is_root_bus(bus)) {
>> +		/*
>> +		 * Only the root port (devfn =3D=3D 0) is connected to this bus.
>> +		 * All other PCI devices are behind some bridge hence on
>another
>> +		 * bus.
>> +		 */
>> +		if (devfn)
>> +			return NULL;
>> +
>> +		return pcie->reg_base + (where & 0xfff);
>> +	}
>> +
>> +	/*
>> +	 * Clear AXI link-down status
>> +	 */
>> +	regval =3D cdns_pcie_hpa_readl(pcie, REG_BANK_AXI_SLAVE,
>CDNS_PCIE_HPA_AT_LINKDOWN);
>> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>CDNS_PCIE_HPA_AT_LINKDOWN,
>> +			     (regval & GENMASK(0, 0)));
>> +
>> +	desc1 =3D 0;
>> +	ctrl0 =3D 0;
>> +	/*
>
>Blank line before comment.  You could make this a single-line comment,
>e.g.,
>
Ok

>  /* Update Output registers for AXI region 0. */
>
>> +	 * Update Output registers for AXI region 0.
>> +	 */
>> +	addr0 =3D CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
>> +		CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) |
>> +		CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS(busn);
>> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(0),
>addr0);
>> +
>> +	desc1 =3D cdns_pcie_hpa_readl(pcie, REG_BANK_AXI_SLAVE,
>> +
>CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0));
>> +	desc1 &=3D ~CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK;
>> +	desc1 |=3D CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(0);
>> +	ctrl0 =3D CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS |
>> +		CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN;
>> +	/*
>
>Again.
>
Ok

>> +	 * The bus number was already set once for all in desc1 by
>> +	 * cdns_pcie_host_init_address_translation().
>
>This comment sounds like you only support the root bus and a single
>other bus.  But you're not actually setting the *bus number* here;
>you're setting up either a Type 0 access (for the Root Port's
>secondary bus) or a Type 1 access (for anything else, e.g. things
>below a switch).
>
Removed the comment in here and in existing code for the next patch series


>> +	 */
>> +	if (busn =3D=3D bridge->busnr + 1)
>
>The Root Port's secondary bus number need not be the Root Port's bus
>number + 1.  It *might* be, and since you said the current design only
>has a single Root Port, it probably *will* be, but that secondary bus
>number is writable and can be changed either by the PCI core or by the
>user via setpci.  So you shouldn't assume this.  If/when a design
>supports more than one Root Port, that assumption will certainly be
>broken.
>
>> +		desc0 |=3D
>CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0;
>> +	else
>> +		desc0 |=3D
>CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1;
>> +
>> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +			     CDNS_PCIE_HPA_AT_OB_REGION_DESC0(0), desc0);
>> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +			     CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0), desc1);
>> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +			     CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(0), ctrl0);
>> +
>> +	return rc->cfg_base + (where & 0xfff);
>> +}
>
>> +++ b/drivers/pci/controller/cadence/pcie-cadence.c
>> @@ -5,9 +5,49 @@
>>
>>  #include <linux/kernel.h>
>>  #include <linux/of.h>
>> -
>
>Spurious change, keep this blank line.
>
Ok

>>  #include "pcie-cadence.h"
>>
>> +bool cdns_pcie_linkup(struct cdns_pcie *pcie)
>
>Static unless needed elsewhere.  I can't tell whether it is because I
>can't download or apply the whole series.

Used in other file.
>
>> +{
>> +	u32 pl_reg_val;
>> +
>> +	pl_reg_val =3D cdns_pcie_readl(pcie, CDNS_PCIE_LM_BASE);
>> +	if (pl_reg_val & GENMASK(0, 0))
>> +		return true;
>> +	else
>> +		return false;
>
>Drop the else:
>
>  if (pl_reg_val & GENMASK(0, 0))
>    return true;
>
>  return false;
>
>> +}
>> +
>> +bool cdns_pcie_hpa_linkup(struct cdns_pcie *pcie)
>> +{
>> +	u32 pl_reg_val;
>> +
>> +	pl_reg_val =3D cdns_pcie_hpa_readl(pcie, REG_BANK_IP_REG,
>CDNS_PCIE_HPA_PHY_DBG_STS_REG0);
>> +	if (pl_reg_val & GENMASK(0, 0))
>> +		return true;
>> +	else
>> +		return false;
>
>Ditto.
OK

>
>> +}
>> +
>> +int cdns_pcie_hpa_startlink(struct cdns_pcie *pcie)
>
>s/cdns_pcie_hpa_startlink/cdns_pcie_hpa_start_link/
>
>> +{
>> +	u32 pl_reg_val;
>> +
>> +	pl_reg_val =3D cdns_pcie_hpa_readl(pcie, REG_BANK_IP_REG,
>CDNS_PCIE_HPA_PHY_LAYER_CFG0);
>> +	pl_reg_val |=3D CDNS_PCIE_HPA_LINK_TRNG_EN_MASK;
>> +	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG,
>CDNS_PCIE_HPA_PHY_LAYER_CFG0, pl_reg_val);
>> +	return 1;
>
>This should return 0 for success.
>
>> +}
>
Ok

>> +void cdns_pcie_hpa_set_outbound_region(struct cdns_pcie *pcie, u8 busnr=
,
>u8 fn,
>> +				       u32 r, bool is_io,
>> +				       u64 cpu_addr, u64 pci_addr, size_t size)
>> +{
>> +	/*
>> +	 * roundup_pow_of_two() returns an unsigned long, which is not
>suited
>> +	 * for 64bit values.
>> +	 */
>> +	u64 sz =3D 1ULL << fls64(size - 1);
>> +	int nbits =3D ilog2(sz);
>> +	u32 addr0, addr1, desc0, desc1, ctrl0;
>> +
>> +	if (nbits < 8)
>> +		nbits =3D 8;
>> +
>> +	/*
>> +	 * Set the PCI address
>> +	 */
>
>Could be a single line comment:
>
>  /* Set the PCI address */
>
>like many others in this series.
>
>> +	addr0 =3D CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(nbits) |
>> +		(lower_32_bits(pci_addr) & GENMASK(31, 8));
>> +	addr1 =3D upper_32_bits(pci_addr);
>> +
>> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(r),
>addr0);
>> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(r),
>addr1);
>> +
>> +	/*
>> +	 * Set the PCIe header descriptor
>> +	 */
>> +	if (is_io)
>> +		desc0 =3D CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_IO;
>> +	else
>> +		desc0 =3D CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_MEM;
>> +	desc1 =3D 0;
>> +
>> +	/*
>> +	 * Whatever Bit [26] is set or not inside DESC0 register of the outbou=
nd
>> +	 * PCIe descriptor, the PCI function number must be set into
>> +	 * Bits [31:24] of DESC1 anyway.
>
>s/Whatever/Whether/ (I think)
>

Ok

>> +	 * In Root Complex mode, the function number is always 0 but in
>Endpoint
>> +	 * mode, the PCIe controller may support more than one function. This
>> +	 * function number needs to be set properly into the outbound PCIe
>> +	 * descriptor.
>> +	 *
>> +	 * Besides, setting Bit [26] is mandatory when in Root Complex mode:
>> +	 * then the driver must provide the bus, resp. device, number in
>> +	 * Bits [31:24] of DESC1, resp. Bits[23:16] of DESC0. Like the functio=
n
>> +	 * number, the device number is always 0 in Root Complex mode.
>> +	 *
>> +	 * However when in Endpoint mode, we can clear Bit [26] of DESC0,
>hence
>> +	 * the PCIe controller will use the captured values for the bus and
>> +	 * device numbers.
>> +	 */
>> +	if (pcie->is_rc) {
>> +		/* The device and function numbers are always 0. */
>> +		desc1 =3D CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(busnr)
>|
>> +			CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(0);
>> +		ctrl0 =3D CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS |
>> +
>	CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN;
>> +	} else {
>> +		/*
>> +		 * Use captured values for bus and device numbers but still
>> +		 * need to set the function number.
>> +		 */
>> +		desc1 |=3D CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(fn);
>> +	}
>> +
>> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +			     CDNS_PCIE_HPA_AT_OB_REGION_DESC0(r), desc0);
>> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +			     CDNS_PCIE_HPA_AT_OB_REGION_DESC1(r), desc1);
>> +
>> +	/*
>> +	 * Set the CPU address
>> +	 */
>> +	if (pcie->ops->cpu_addr_fixup)
>> +		cpu_addr =3D pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
>
>Oops, we can't add any more .cpu_addr_fixup() functions or uses.  This
>must be done via the devicetree description.  If we add a new
>.cpu_addr_fixup(), it may cover up defects in the devicetree.
>

cpu_addr_fixup is removed.

>You can see Frank Li's nice work to fix this for some of the dwc
>drivers on the branch ending at 07ae413e169d ("PCI: intel-gw: Remove
>intel_pcie_cpu_addr()"):
>
>
>https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/gi=
t/t
>orvalds/linux.git/log/?h=3D07ae413e169d__;!!EHscmS1ygiU1lA!HirY7Jqq13s65vE
>sm8Xtx9gMxZHrQDFP83kcJl16q69IqZNwZ8uRfTlSISvAIeG6vWCI2sIr8sP4N64$
>
>This one is the biggest issue so far.
>
>Bjorn

