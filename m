Return-Path: <linux-pci+bounces-30810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8498AEA529
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 20:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E2B3A1EA9
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 18:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3273F2EB5C0;
	Thu, 26 Jun 2025 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="qXfF0l8g"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010011.outbound.protection.outlook.com [52.101.69.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384222EAD15
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 18:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750961796; cv=fail; b=lCLxmue3akuz/i+/1V8aE8/+THf/AtsuMP42/YO1eMHUOUDlg+V9AeGZiO0TsXWlOC8BmU5x8MarcrUWgVVhn2gvereSUF4oF1uwkCONprtT2KJ9VtkO65wn+ocRBU1QCYaEvKIT7xwyLiDda/6dfcJYeawFwZntdl/gQI26GcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750961796; c=relaxed/simple;
	bh=KyGWs18ZG3H1RlptsLMWE/7sFodmOQPPlUz7yO3nhNA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DByJK5s07UZdVPHcxYjZ7tS+iTqxclxf9a+wqqkTgHuPVV2z9baLydpsqezL4vJbhxIdSERXOPCKtApUtCQ0wK+T+m3oL5uRqF1uOhv45TPtmM5Wf+LPpTpyYrEcMM519pyeS+QCmiI46VgIZaZinvgj+6M2cLmj3mhork6vl3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=qXfF0l8g; arc=fail smtp.client-ip=52.101.69.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOLj/xR41sE5Xzj/khk/yUG/jZDo9cFS1C96TGmjSTsgdhBWUuZoV32bFvHSc8OSSnF3pCGCvO7yHd+dbSvKo4yVG4pqrBQE9a3UIH0ra45XE9eGiKuiHzhR8eSFmyxgzuO+BMBFrA+ToQkb+/o7dCMHc6y9SP8xYWTi9tAQY5kS5Uj9kdja6liAcLBBEZlM83xxJRTZ/oRV7sjvoKdpN4KdRcKFjCjwBS8KNepzFxt8uoixrLq+jdG9nY2I1MDi4uau8UqjxUmaPla9f4bCzd5Ysye/uxFilYhm4n2rqpXFPd8RBVkp6uEXHq30mOPWCPQpFxKD6ae8D2HsgJ2NZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyGWs18ZG3H1RlptsLMWE/7sFodmOQPPlUz7yO3nhNA=;
 b=gNmkKgbgvtERzFNSsp+AGbTfGdN/UvlLl3FyjKbsTb3lhKHS6Z+RS1ZvUU1SRMRkitAO40Fm1cz3P8KnnRYGJjf29uAHbWAoUaqtWFSjbBg2zwWZeDsr8CBd2NWiF9b/oqqfc2RQvvexCr5qKSsUXY4caV9WQWD5uwDCGbBFfch4Fl3xhCVsRd7o7WKIUdxGW2CmBYjw5twNOerp2n6DX9OFAw7robXhY46usfOv8rkmRG56fUwYt0+GXDynCdzslmfzeDFAvv9ljvajPPBx0P8bZ/eIA0GK6k7YzlDWXf+oA1e0LiBr5xzSLpLvBArUNzBBnhkl0QKhjdRiXBZ4+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyGWs18ZG3H1RlptsLMWE/7sFodmOQPPlUz7yO3nhNA=;
 b=qXfF0l8g/lLkbSnrKKoMKFZ/pZRuP0Yoc0Stwpewb12rCpNntP6EieHT+Fx6qLGTPtGQPPAqG5BflrxGMMZW5muwfXLAh9rb3OTw+TfJ+gnJcy9bQHjDK1TBEsPdR9vLSTxVSWvEU1QgxSQfZB6BMOJsDbex9I53r2rMr80p6r9KUnQXYF/FLxE/97a9pmK6KIj3iSswrdTRenmwiWPFUz/dpB65wYsFfY96rQoKw0Mq2ZfcPDGZP7Nez+reFXRtmFeduCQTJTZ6whAGj+muJsir1wPnOUOrgmdF/fLFlu/S5yIjTXYIPFeofSYwKgwBPNpUgFRtzNwLuJvyDRcZHQ==
Received: from AS4PR07MB8508.eurprd07.prod.outlook.com (2603:10a6:20b:4e8::10)
 by PA4PR07MB7597.eurprd07.prod.outlook.com (2603:10a6:102:ca::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 26 Jun
 2025 18:16:31 +0000
Received: from AS4PR07MB8508.eurprd07.prod.outlook.com
 ([fe80::ac1a:46d3:bbd7:ab11]) by AS4PR07MB8508.eurprd07.prod.outlook.com
 ([fe80::ac1a:46d3:bbd7:ab11%5]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 18:16:31 +0000
From: "Jozef Matejcik (Nokia)" <jozef.matejcik@nokia.com>
To: Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: pci_probe called concurrently in machine with 2 identical PCI
 devices causing race condition
Thread-Topic: pci_probe called concurrently in machine with 2 identical PCI
 devices causing race condition
Thread-Index: Advmgv6S7GDW7X3MS1+pFxVcKASISgAEAmmAAAAW13AAAI3RAAAGz7wAAAUhm1A=
Date: Thu, 26 Jun 2025 18:16:31 +0000
Message-ID:
 <AS4PR07MB85088754E7FC20E462E4A071937AA@AS4PR07MB8508.eurprd07.prod.outlook.com>
References:
 <AS4PR07MB85085806C2BF5CC518D52808937AA@AS4PR07MB8508.eurprd07.prod.outlook.com>
 <aF04PxJ5WqIA7Je0@wunner.de>
 <AS4PR07MB8508CA1516E932B243AC5139937AA@AS4PR07MB8508.eurprd07.prod.outlook.com>
 <aF08kFNy8qrI8LvD@wunner.de> <aF1qRv0XlT4EDN-Y@kbusch-mbp>
In-Reply-To: <aF1qRv0XlT4EDN-Y@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR07MB8508:EE_|PA4PR07MB7597:EE_
x-ms-office365-filtering-correlation-id: a741b27b-d3f9-4cae-85b4-08ddb4dd93c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Wuu3IGEzYVSEyAVPp2BhV8enKlO6x2pLrA/KjcmGs4gYUTpSODQoj914ZvKr?=
 =?us-ascii?Q?8GGbLbbP/S7u6T/8bKnKJbwdzISFjWnPXrwJPN1ZIZzxZ7UbxtIGS5WD5eFk?=
 =?us-ascii?Q?0mZUwkub7lP/ALWj3/6DgD5zMiIPJUsqDlk1RbQ7EsJLB8xsxGD2Wp6jwdmM?=
 =?us-ascii?Q?gF+wvMM4nF8Zv3+kibGkfQPif/EGd1kSULhZRoYMX5B91W1TP3lapzmENjvG?=
 =?us-ascii?Q?lcVDm9MmqF16Aov8Yju0eebWmPmYW8hGYrNVsAu9m3jk7eL7xjK3Rk32yZft?=
 =?us-ascii?Q?Hun1UmOfVdlGUJnbAMIK4+AJSasDaLCz0tie8xjJXB9X48HQCFk8iZzPlf3d?=
 =?us-ascii?Q?otau17uXTSBXCtfF7wUBxoa7x9clte8hb0op4/ieTf7r0cVcpFHOuM5xVibc?=
 =?us-ascii?Q?IFa1EWP7Q7OwTkq6APWWv7/sNhFRk6iBeJn3caU5hunJThCgb9ndhOhJKmY7?=
 =?us-ascii?Q?ib8zC0lWNvvseneUW+PDm43fRAzCn/WA1h208aLAZzIpm04hGkn7vnu//+xL?=
 =?us-ascii?Q?/Dt3qGjQhR+WeyzZl/zug/c7yJ9YsC5b6xB2AcLvsCUWHc1w5qVho4NTyFqR?=
 =?us-ascii?Q?rSnuoG0L14VSa11uv/Q1fBU3JfMgp8xuXxpVpe0xzwmHmEQ1QrDoP2HpU0H8?=
 =?us-ascii?Q?g5ct0ADNBZ1lpnXZzRXL7uJramd2fAsr0/GcjfArCGp9tYjmUHZoZEzqz8xm?=
 =?us-ascii?Q?ROFKvBlN2jFWdLrjoVNtF/SJbFZaq+hBKprM0o9MWV1Rj6vmquk029rgt3Tb?=
 =?us-ascii?Q?DzI6hB84A+U63/i84j0yb1NEaBnReJcrRpSrkWdUC79dmonMmHyu8GJ28Y4X?=
 =?us-ascii?Q?q8BNOhGB9H26lyCQGXNKWisdBQnKBKNDKa3fEvFN7Q5ahmEs/YpZ0jlqWUt+?=
 =?us-ascii?Q?tsKbg5zYHRTJz9XsF6p/Teb/Un38orzUAIMf0REnQwsm6x+9WijyE7LexSF3?=
 =?us-ascii?Q?6+nOcsp0RlmLLc6jQuERL+cZgW3pGE/ka4rE2vMOcg1Vme72azBInxU/aCap?=
 =?us-ascii?Q?MMYqZzohDCiCMhSmgkP/8PWFt/lCzXx0gZjaOEuEvDYPkFHUEivhRIc9hO+N?=
 =?us-ascii?Q?TX+DMTPOoKKlrdJDxby9kjcoNaD5UcXLk8QQeksQ7TDkSs/oJIVDR/JnsBLc?=
 =?us-ascii?Q?zqiyIqMXa1PEvKUsIk/aaUgvzC7AFf+ATvRBJNgT87uH8gobUtZegZbFewi/?=
 =?us-ascii?Q?MtgenKgDuYHZqbW+pd38HOdNcilLt1Ob9zxQC3jr3P3kjsr0gogaTLbPIkjc?=
 =?us-ascii?Q?S+kwwKCdjkvJLoE4dOcDL5o9br8yYfoQ1sL7ToCKcY8BF8+XCJN2iMBMbM/d?=
 =?us-ascii?Q?VmvrD6qIFNzEzJa6gFEPr2abTr02LV5PhAqZBjXr06l+86ZwLBWzK1r/+1pj?=
 =?us-ascii?Q?9FWKl+at7nr/uP45MdmdmwoXr4h+H/rZ9b8U/gzg5K1IZ3N/4PnTPR2ZIasR?=
 =?us-ascii?Q?DrJDsFjQ7rVI/BzIksuSnxn6HYmz4nmbc+AZOQJViAtkLLKCNfQvEw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR07MB8508.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RNm8scSCsWZVkmiLRH4bmEFj8UeKgmgQC2ES8Ts383bI3GKD556bvz1OoREw?=
 =?us-ascii?Q?2zYStaxp+JBv6KWFl2DjNdmIX12mpTSC9bN0EZ42CbvdX4HO9ajZow6id69R?=
 =?us-ascii?Q?rKX4u5amKnbx55yQLptJdfc8Q6m1/O4XJcHrLz+6XdDLNIyqKrgdFJs8sTwa?=
 =?us-ascii?Q?jEm1SEUfDSmjFoWot8818HZiXtBE39Bnm2gLgBgnQpo0erhixHRyoWuGf3pW?=
 =?us-ascii?Q?uyNg3WwyyxM13d4gVSsT5Ko9f2zlQCoEjwB4ujhp6Z4cHNOjJyJxfdwAaT3r?=
 =?us-ascii?Q?MUZoTmH9pXrjbJ+kE5JLyD5nwkM/tC5SZ79iOmhr1qyruwy7i3IaB5rTZVhB?=
 =?us-ascii?Q?1ywyVhEHVqYxcv/hFSVQYMF1fIwz0JBPgEvvTAznP+6aGO6r/g4B8XAxIkMu?=
 =?us-ascii?Q?qCu4DFXbbZ6ctr+8TnqKzr5U+xYoIJUjjBsnhUuA4xVRGXzVe1bvX8cZhGRa?=
 =?us-ascii?Q?489biiGNk+ULAC2c4nBCygyUpILk5MLE3FviE4R6NOtI63mk1gwkdAmQjheW?=
 =?us-ascii?Q?DIla9JCC4/J6SK0v0bAVYCs3kBOu4kZnBFffcer0ZW6nXtE6BIziH3c2uDaS?=
 =?us-ascii?Q?KPIMjW1dI6+uj5D+sH9X0GGguPwZHexEBRGaV0360vxm3sXkmkB/kWjQoZGW?=
 =?us-ascii?Q?rcjvYF7SYNOQPyqIsDfhVjIZwZLnOEslIqrYB+d8SDdh2UxCJGrM9W5eDJ5V?=
 =?us-ascii?Q?vP1nJwDblFY3N0xw9/zu21YfkjIbNWspiUzQkXu6f4c+4hAqjKhjVlRiXTi9?=
 =?us-ascii?Q?nfBsNPsQK2dNZFOYwdRtqjs+JAk77jWabG4LXfnbgo9a11eoMtfuHIki9sGB?=
 =?us-ascii?Q?uEheoogKVDXMorYRLHAmUTe9tkNZmuu1d2U7tk/r83RsoK08P1QoubPIZHxs?=
 =?us-ascii?Q?aMOodUzsR9VLB76EHiKGdaKuBIHAyMWNn3pOHbAB4KBhfaPUJXUBs9TqvjST?=
 =?us-ascii?Q?BtxTyMgX4dQaObI/cibs2Ckd85aV3OlXtt7jbN0wEqGABFk30rbV1NTBAV2e?=
 =?us-ascii?Q?r3U4PXkg6WqljDvxoDJX+n//xw98aBH6ihB/vJv+EFyT3Dl+0tB7TFoCVnPz?=
 =?us-ascii?Q?CdKpRz5hKA3DX5SF6XraLxO/BTAbwx7KJtYN0zJIYM9EfQ+6CWEbR6JAhYwt?=
 =?us-ascii?Q?w2XPShvAiE8zqKpSfisvohvh8NyVMcuZJe3zv3EEji65+jpLfE9DyFBlw790?=
 =?us-ascii?Q?L2rMsKdmQnKBGpyjXDgAHj1HNxUfRmpApUHXoVjs3ElMzk+Taqi27Na+o5yy?=
 =?us-ascii?Q?IdbISVOb+v54CpJd6hKAtZOzVxG9JoEz9UUsrfqMB8hx2e9bOHuJsPyHtZHt?=
 =?us-ascii?Q?AcF4+7q+0e4QhYkp86t9nsEBUC5pI7ZuaHTPZ3/bI13J52OrXHx4cqkGwWvd?=
 =?us-ascii?Q?p063IlLOIYOTDAoJwjWwqMPMz4T2oJlcfpGfSfwZ9ljHi+N9ODBxALHz6Z7g?=
 =?us-ascii?Q?HvBsj3G2SNZAvoG1pWrrpxfZFHCFQaVbOKjiPGxdkiUHCCWqEV8CTGVbcMiI?=
 =?us-ascii?Q?xVst6Zk648Uoip176llWtcAgDpeTs4MBuJjM9vjk2QBsW552cfDUblYTFagv?=
 =?us-ascii?Q?q1c7tVxNcjh9WwRtH9rX3xoCznig9u6c7nNP8nYV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR07MB8508.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a741b27b-d3f9-4cae-85b4-08ddb4dd93c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 18:16:31.6313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sVSUmpmi2dpZ9B/J9+/f/VpSuH2vBB61yK6uOuTHCoQTyeLCdyrbK48EJiseIwDcwTRqDcvNhf9P8q9tG9B10FWaGF7W+YqSYWPB2SKs0p0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7597

On Thu, Jun 26, 2025 at 02:26:56PM +0200, Lukas Wunner wrote:
> > > On Thu, Jun 26, 2025 at 12:20:48PM +0000, Jozef Matejcik (Nokia) wrot=
e:
> > > However, I think this can happen in any machine with 2 identical PCI=
=20
> > > devices, because as far as I know, existing PCI drivers usually do=20
> > > not assume that probe function can be called from multiple threads.
> >
> > That can happen all the time and it would be a bug in the driver if it=
=20
> > caused issues.

> Wait, is that true? I thought that would only happen if the driver indica=
ted probe_type PROBE_PREFER_ASYNCHRONOUS. The default > > appears to still =
be the same as PROBE_FORCE_SYNCHRONOUS.

Hi Keith, thanks for stepping in. The implementation in drivers/pci/*.c see=
ms to be pretty agnostic to probe_type. I did not find any place where this=
 enum is accessed and some decisions are made based on its value.

If the probe_type field of struct driver is relevant for PCI subsystem, I t=
hink it should be documented in Documentation/PCI/pci.rst.

In any case, we will push the vendor to fix their driver, but if there is a=
nything that should be improved in the kernel, I can assist.

Regards,
Jozef

