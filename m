Return-Path: <linux-pci+bounces-25650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69748A85273
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 06:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2369A241B
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 04:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E681E0DD9;
	Fri, 11 Apr 2025 04:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="GQunaPpg";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="tLC2U2ea"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DBE3234
	for <linux-pci@vger.kernel.org>; Fri, 11 Apr 2025 04:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744345284; cv=fail; b=uZ1Ans7LCzlmfGrYad2bxb/YG58vXGlGHYqnSEsUE1k/rZCGJxXg220sl1Fw+fKxdMjXEDa9b/yWggkruq+Gpwy8kndfWspM8YM+82aE6f44o3MzP8YGtrFeMuoZK/W5JQz4rVMZ/Vb0QWwF4uK3wRhdfqlPAU7Rf+BfWVGg1/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744345284; c=relaxed/simple;
	bh=RI4c2rKQ3Oz5TtahLwMLCo60NwZV5hOS5Ds6P1Kh7qg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XcvlRydJE3gQov4zOx7/cJTNjEsFYnA4hVprR0IR7UJlqJvvE5eWxCYU9iUURrFsdKlSogqr7GaVPWey/HdOFifFlg/rRLILMhSRQi7CgGBBfFGcPhifdbfazFWSysPnhff0K4Fn4R0SaQA7DqBy5BNCKfpZmqt0I3a+BTGKEjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=GQunaPpg; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=tLC2U2ea; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AKwgdL026734;
	Thu, 10 Apr 2025 21:21:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=0roi7aO+NoirQgkMskGiKzJXXJMBnCDZ5oCGjZVv5gg=; b=GQunaPpgnOAT
	2NXxiKBaA26IIrjBbP4w4NxVUP6t6nyRKLePFsMsijmcPvuHZOh6FnnSy6PmhHOF
	eVEtS4xQX1/K2v5TKDwLapSRdjdzX1kY2bWYmE19AprLEHq0andSWYQePa1W5J5P
	6RNEnnNH5uy9zYhQOUcPE/0r/3o0eCJj06RkgsPDkI+0dcdqVkPVD+IFX56VNT99
	6480DyxQnnCploqsEguTjt4YgLRabfHKaCraFd4JWKRvqVVAK1VUC5JAnXY0vuXz
	Fzqebpun6lGNOr/9sa9XQTqsy2mq5r/tuwXFwkEBolh03FJShHvFI8rEyCMtKhP8
	YMCRYs0igQ==
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013075.outbound.protection.outlook.com [40.93.1.75])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 45u03wuenx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 21:21:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZytDqwEfswII7bILStOLgUmaIWDMct5PiOsxKEHYEUprP2UqrES1BHy+EcW/U0LW33YvOG3AZneuk+a55ULui/vdvqXhxgO2ctV+/71m/hes/vp+/tb4XcteJf0wpvM7HCdK2X33cd1Ezvv8O3yZc/3o2eGF+cRbuNpBS2zD5YBMgSUSueduHf+VoTVQ7uloGougfU+cOlDSflQfhpQiY29kBwnTwza+7NF3Jo+GL7XWDRGFu8TTbV1CIpOiVsROm+94bFf7gpF3+LeazPM6+by33Miho9T0+cpcVlHp5OyFWZ/YzukXZxurbFdOyipEpzuWdrb2CruLJpFO57x+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0roi7aO+NoirQgkMskGiKzJXXJMBnCDZ5oCGjZVv5gg=;
 b=K1H3Nj68KIcktHDMMHbV3MiHe+z2A34UZOEbivq1eIL7JD/LoOrALIc0GKc8SPv/9K1ZsG8e5zpDSbdRHT4xqowNK3ShmncfJRH3+L7WWjR3BcP0F9pTzaHogPBENrV43cfrAfIR4y1hFzwK1di9SARABzRryNLV8/E9CN0i4ZaRIpZHjRaRmnQBSScya3sq9Aps+nVN1Xi1lWL7YCx3n2Q7RpXfSzbC7MhJBYGNleMyOUL1KQ83lmCbQ77/LnO+8KQgjRhaK2qPHtBcKvK1YH7Ja0Mykg2IWSj9JFN2TCga9CdCMR5oU40nRCBkEd2mABjUHxJlxEj0X85DXrxIGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0roi7aO+NoirQgkMskGiKzJXXJMBnCDZ5oCGjZVv5gg=;
 b=tLC2U2ea1mBbgcUPXiC87IVSIbA9AVDRs+4UkeOMutfSzL4VBuCL+yy+RUdp9DGADl7yGp0asMA4794h5Xtxmyy83kMFj6OUYH36kNWhFwyAZHca0I8cjG8GTffi7nrve87x9XECfI2C85qtDjMmit3q0D1ABMZR8TOMyWxGyx8=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by PH0PR07MB10693.namprd07.prod.outlook.com
 (2603:10b6:510:337::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 04:21:08 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec%8]) with mapi id 15.20.8606.039; Fri, 11 Apr 2025
 04:21:08 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: [PATCH 3/7] PCI: cadence: Add platform related architecture and
 register information
Thread-Topic: [PATCH 3/7] PCI: cadence: Add platform related architecture and
 register information
Thread-Index: AQHbnwkMJekZ5LC+V0e47zdOm6rTRLOG22qQgBUepwCAAfom8A==
Date: Fri, 11 Apr 2025 04:21:08 +0000
Message-ID:
 <CH2PPF4D26F8E1C2AA84E71B898A015E363A2B62@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References:
 <CH2PPF4D26F8E1C5086A79888CB5AD0A01AA2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <20250409220932.GA299761@bhelgaas>
In-Reply-To: <20250409220932.GA299761@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|PH0PR07MB10693:EE_
x-ms-office365-filtering-correlation-id: a6846be7-ce8a-4aa4-8460-08dd78b0489a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Mh/ZpW4cMU+kcMbkqqaVELrLtzuVfj3wSzAQKbKveeFuyljR+bTm7mFQw9MS?=
 =?us-ascii?Q?W+RD2Byj3ZFNExgs6JhCjpcaVWXrTNX1EHY6OklZAI8lp7OEieguFCZdJGu9?=
 =?us-ascii?Q?m+NoJjcN6ey/cvgdkbfKmhS5u/pNhw4b/BzR+Utir5rXYdrOefgAPL+oJJGs?=
 =?us-ascii?Q?5nlfBLDl1G+1tkqAcFGHswXYqeXBQJ/KS7eJOhlwLPdFzIdg8M968dZxK2il?=
 =?us-ascii?Q?jrPNVL3zywItaluj5jLuLcRgp0Mc7140w9c/o4z8AvMZZAZkcMHPsS7Teq0L?=
 =?us-ascii?Q?uxE915eF2LWJMiUK/TiCHxB716hkDxw8jY2MqZyyTVBz3yADO+RpNtHLxKUt?=
 =?us-ascii?Q?lCRJrFNhemb3RNoV+uhkcrUYl/Fjz9DqeSYpgBdcCL4t8AD2hBFOp3JQHu8c?=
 =?us-ascii?Q?/WLdywTZT6RYF5C6ZC4T7+ETnztZQK2KIdZ5wPwLfjcY4oIFfh2hxSeFMhzj?=
 =?us-ascii?Q?Dov+4z1/I4ZncBtiA+GyICZAGZLpS6quB8O/uaIaXEZ/+lYxN4x/lhaYIdJY?=
 =?us-ascii?Q?37BMKd8BC9BTHBbQygsXUBD3P03dtnx8gJxjYbDsp1v7ehBLuHQo50OBLUc+?=
 =?us-ascii?Q?05F+gO+2Hx/EZa839aqWhV3bbI2Wkn34jiAH9QNMEm+WEYu/V/nOhsQ0S6mM?=
 =?us-ascii?Q?/bDrBbqbqhlMfAB8L0rYhnT/HRH3mpCnsN/lPFlsQtteL2b5XewQzyqHsjXe?=
 =?us-ascii?Q?jUy/NRt0EVgiwYZ2G2BNcYVCxgJb0VM9KLM79/Xm77khm+DJhmYLrF4zg7El?=
 =?us-ascii?Q?YO+2ZpIbC1vbPoPE6pqrceWBoge8Z8/mCww+JdeSueoksZgAxxdqNE2qb7c1?=
 =?us-ascii?Q?fJEXg7luXfMKPtylDx/+OMDDEyaOj6OPoscNUI52g1VU0tiO6WQUdWaJCM/Z?=
 =?us-ascii?Q?vPKYVBLadJQxTrgiGgDwAHBjovfqQ3HWQzGHsJFPhSCN39kBZSpJ7z002W3h?=
 =?us-ascii?Q?3NwE6WuwM7z50nXgLUKDm1Uzlcl/rYI1iHubfInqOW9UtcnEiXHTB2mHuMbj?=
 =?us-ascii?Q?M1XwavtVpywIKhJjM/FrxHV6kHll93GF2TPJ/dAGYTzc9xLJDTgZn0jmqr8/?=
 =?us-ascii?Q?YEBkXGSX5SMayD+kjlbr99sQDPtKty/kkl68CXwSUMAPV3NTBxQMfKAMFWEV?=
 =?us-ascii?Q?aLy8Bfgw3nlRYyXtQchyFl6j+AUmUR5X8KTIstBY531+c9IbXpVrGt1MKFw6?=
 =?us-ascii?Q?72AsRFYXKuTOJSwAfN8sx/BN5LIhif1AL7j+aKdudeEkdNmqVXosApVJHoRX?=
 =?us-ascii?Q?a8u5aCSPVZK8DaA+h0IreIvmWtTqzAeaLQNuXSFDDlVUCTy/bcIeQdTrVsXB?=
 =?us-ascii?Q?5oMj3A9KP4v8hsN9s1wo81jYhFlSxGNhrmW8MWgBOjYhpq4646lQEydbFyN4?=
 =?us-ascii?Q?DA96Q16fbdMh4pp8nESPzmGIuvv7nVtzoWH6BRTZvDSfVDX8/ynsgQeFn/e5?=
 =?us-ascii?Q?SXV77K8I39m5gYuiDe0OMwJtlD/ReajhmurM2DHABKruMR0JTD6epEyfVeiP?=
 =?us-ascii?Q?5qHQdkRBvoPcGwI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FvYM1EeOzDQEzm0q7q3xAnwawipbbiI5HP+6K0u2i1Cnhc8qNymvEHDtNBwn?=
 =?us-ascii?Q?bPnDyoESphLdDRZwKogUO6ffO1EunKROu9tTIx59029KluXH28ZZZZX9OD4b?=
 =?us-ascii?Q?iIBqgzD3o/tJdfK5yyjc201NfOsOIw8rJyP30RIBkdcXPpEg+wJ6uIpdnd0j?=
 =?us-ascii?Q?sYKLHdviTxfqzUr+UEsKMJNTZwex5IDY05tuUmsQnV8TZpl+ncY4E+K7Q/IO?=
 =?us-ascii?Q?BjA7l1WJCvwmXU0DJmL9K/5YlkszNZNJ18qLm0areHU5kQdH/ZqA5lnhNNXI?=
 =?us-ascii?Q?K1A5yFfLBrKZW3HQ+rBsoY4aOx+m3QyugllPOOzeyasyx6R1GnxNA0zaMolU?=
 =?us-ascii?Q?RCuCuTi1AaeKtFrsWHgeX3wyeSObIfirhoof0kfHE3BdolKNvhdPi1ObBaPs?=
 =?us-ascii?Q?EdA+pIz+KqSxEboPQK8L9lo4vRtGyIRwhujmap5pe5lBwxshdavtKZA35o24?=
 =?us-ascii?Q?gkpQPcxuu1qll/t9qWI8HsyCpZdNxz4LQfhMhioXwKmTp9KZsL+X0g2c0a6u?=
 =?us-ascii?Q?veJHG4xZi10FbjWi/mMg+ZQOJFfZouPTatp968G/qB+Z6koogkyfLPrTP9JK?=
 =?us-ascii?Q?mQIEfUcV0o6KF+Tjk1lZweSiN1Ktxnkn6V7DWIaLPFLFVSuWQ9d5+mMmGzlY?=
 =?us-ascii?Q?b2g3tOxk+exGDKsUQiCWcVSI0E1PmWs290mZPhDKSUU1hlUoKbeKi6c92hka?=
 =?us-ascii?Q?w7uul759wT0tA7Y6ADNSFgRILIX2tdnso9G1rqIs+6hvPFIDlHF6YE9sQxTy?=
 =?us-ascii?Q?tXCuMYSsfCBL7CzX0r2fd1ClJGdq6+AdvdH0dVKHw2GozSc4sJ6HtlXIdaTa?=
 =?us-ascii?Q?YTDz9cvcaVyozEp4fbmpENNnMFfOb6EdJj5mZ8UDtyGUzSgOeN3FdiNlxe6q?=
 =?us-ascii?Q?mZCWx21atNLZxCyP4ENfNWcSirufBdUiC/LdTEcb4qdl5lA/RX0EsK2igPmu?=
 =?us-ascii?Q?VUXptDbycABp8JfNgL/+98QrSd0Xypij1a1uiql7OzfbKpcEBkDxXHRQVIl6?=
 =?us-ascii?Q?DzA6j+nOVDOzbFl8CKitG0our1sMMYAUjyKUNRPX77CvTnG4v9yyKd4pcakD?=
 =?us-ascii?Q?p1eJkC9Z8EqSS56/j7y3az6BBimXmqLW4pgWEHAxca51RsrKmZhMkeqnk1G0?=
 =?us-ascii?Q?yXP6QKnAmRZAc2/eEyzaXgSUqKal2NFxXOeNa801iwc5f026I++J7qQLUeJT?=
 =?us-ascii?Q?YLUoOByKrFthswJCFDl1UMlnSMNazDTOLfyns/TOvDxq30lewvNefD3FqBEC?=
 =?us-ascii?Q?Br4/6coTM6XLr0e7F8wYVXm9bJwKjW+I4D29Jk2CCgcz1W/Y5+SN7VmWaOkK?=
 =?us-ascii?Q?uFf49ul2hOp0f4GC9yCtlp3z2Ucd9DMvpIwKQ5R2GIjWkohC+I1MZvo94/jb?=
 =?us-ascii?Q?tQaE2r5JDSXOlWwhn/pR5mvlvIUqcVyTLAXg4KX2Kyjr0Ulk/sxxOYd5vxUj?=
 =?us-ascii?Q?ZXzq/xgg5+utqTe4qP64q3gXbqrDl41uv3YjZlF2aLre08QTMi5JRcX51KUg?=
 =?us-ascii?Q?nLEm9dmeKCqpFquGfsol+U0/WxJlp8oY16DrO/2mEj59kP5M6qWqNjj4RD0f?=
 =?us-ascii?Q?GVb9gxC1IWZ0NjPNJbEt2LJE4LNcELhvHpj2eeAbRZdZog0MbQSAmn0ju+Ad?=
 =?us-ascii?Q?gw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a6846be7-ce8a-4aa4-8460-08dd78b0489a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 04:21:08.4050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DVJyd7NQK/fyVBk7XaxvgnI8S67BWUaNbL20wQsDBYb8SI6Q7+vuqzrCWLz5M/reZTj/heZZ4TlPetFTSIUjZSidU5D3J0bzH0p44BEUl8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR07MB10693
X-Proofpoint-ORIG-GUID: aljtdJCOqMHKRQ8JNTLOfVKet9PdUZlv
X-Authority-Analysis: v=2.4 cv=Qcdmvtbv c=1 sm=1 tr=0 ts=67f898b6 cx=c_pps a=nstxx7sbfik0j6lNDJSLGQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=Zpq2whiEiuAA:10 a=Ei-8OBM9x-_DUzRUI78A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: aljtdJCOqMHKRQ8JNTLOfVKet9PdUZlv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 clxscore=1015
 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110030

>
>On Thu, Mar 27, 2025 at 11:39:43AM +0000, Manikandan Karunakaran Pillai
>wrote:
>> Add the register bank offsets for different platforms and update the glo=
bal
>> platform data - platform architecture, EP or RP configuration and the
>> correct values of register offsets for different register banks during t=
he
>> platform probe
>
>Add period.

OK

>
>> @@ -72,6 +81,19 @@ static int cdns_plat_pcie_probe(struct platform_devic=
e
>*pdev)
>>  		rc =3D pci_host_bridge_priv(bridge);
>>  		rc->pcie.dev =3D dev;
>>  		rc->pcie.ops =3D &cdns_plat_ops;
>> +		rc->pcie.is_hpa =3D data->is_hpa;
>> +		/*
>
>Add a blank line between the code and the start of the comment.
>
>> +		 * Store all the register bank offsets
>> +		 */
>> +		rc->pcie.cdns_pcie_reg_offsets.ip_reg_bank_off =3D data-
>>ip_reg_bank_off;
>> +		rc->pcie.cdns_pcie_reg_offsets.ip_cfg_ctrl_reg_off =3D data-
>>ip_cfg_ctrl_reg_off;
>> +		rc->pcie.cdns_pcie_reg_offsets.axi_mstr_common_off =3D data-
>>axi_mstr_common_off;
>> +		rc->pcie.cdns_pcie_reg_offsets.axi_master_off =3D data-
>>axi_master_off;
>> +		rc->pcie.cdns_pcie_reg_offsets.axi_slave_off =3D data-
>>axi_slave_off;
>> +		rc->pcie.cdns_pcie_reg_offsets.axi_hls_off =3D data->axi_hls_off;
>> +		rc->pcie.cdns_pcie_reg_offsets.axi_ras_off =3D data->axi_ras_off;
>> +		rc->pcie.cdns_pcie_reg_offsets.axi_dti_off =3D data->axi_dti_off;
>
>But what's the point of copying all these offsets?  Can't you just
>keep the offsets in a couple separate structures and save the pointer?
>
Wanted to keep the register offsets as a struct in the global cdns_pcie str=
uct and hence copying them
1 time during probing.

>It looks like cdns_plat_pcie_host_of_data and
>cdns_plat_pcie_ep_of_data could use the same pointer, as could
>cdns_plat_pcie_hpa_host_of_data and cdns_plat_pcie_hpa_ep_of_data.
>
>> @@ -99,6 +121,19 @@ static int cdns_plat_pcie_probe(struct
>platform_device *pdev)
>>
>>  		ep->pcie.dev =3D dev;
>>  		ep->pcie.ops =3D &cdns_plat_ops;
>> +		ep->pcie.is_hpa =3D data->is_hpa;
>> +		/*
>
>Add blank line again.
>
>> +		 * Store all the register bank offset
>
>>  static const struct cdns_plat_pcie_of_data cdns_plat_pcie_host_of_data =
=3D {
>>  	.is_rc =3D true,
>> +	.is_hpa =3D false,
>> +	.ip_reg_bank_off =3D 0x0,
>> +	.ip_cfg_ctrl_reg_off =3D 0x0,
>> +	.axi_mstr_common_off =3D 0x0,
>> +	.axi_slave_off =3D 0x0,
>> +	.axi_master_off =3D 0x0,
>> +	.axi_hls_off =3D 0x0,
>> +	.axi_ras_off =3D 0x0,
>> +	.axi_dti_off =3D 0x0,
>
>In my opinion, you should only initialize fields that are non-false
>and non-zero.  Then the differences are more obvious.
>
Wanted to be sure that variables are initialized to a value that driver exp=
ects.

>Bjorn

