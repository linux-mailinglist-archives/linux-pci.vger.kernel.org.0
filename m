Return-Path: <linux-pci+bounces-19534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC42A05959
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 12:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D928165ABF
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 11:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FFF1F76D3;
	Wed,  8 Jan 2025 11:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="p2e60Xj6"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011015.outbound.protection.outlook.com [40.107.74.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D55F1F76CD;
	Wed,  8 Jan 2025 11:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736334792; cv=fail; b=mlf2DjOHsm0oWijpCOtSTa1A/wgr2Ek3/o8VcsI/R8yTRT3JhDx5/tXvu9dA0Aei9bzCAUQmFOBQGJLRBc4FGlqECAupdi0FuhX6zSFvUigPYe1OMxPFfqK8mvZQDg2Wesd3xDBlqPO+haWe5t11srPhgCfsD6KTy6w5F4CGguU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736334792; c=relaxed/simple;
	bh=0Rg/teba7svOhNa9pqhWsIlk6F5Xzt9aK+zX6/ZCx4w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EAAQt9Du6vxF8K88l1fQvwrNRldlLa1sJ0Gfyi6qZLEFh+KFEBB31W3VFuBgXWAC0RObdWx9GhZFQ7N7HIvtZHZcdP7Mnx0OQsIbRJTFw1fFfSQ12f/EVjpUmdnUMuDXJiZHRPvqveRuCayxy+bm2E15MAU9tTcEIIIXtIF6IjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=p2e60Xj6; arc=fail smtp.client-ip=40.107.74.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6hYR5MzpZ7MmalfK0GYwMXDWTyJKH2X9lzyLDG+H4EweHMKug+bK6hZUv/OBPzVaiv6CVaCqYzRDDfyCmN9vAS34eI9yj8nZHFspZBpLJmtAAd0soBcrzA/5YzmKZCUHdP0Nqb9iDAkj7p98yHTjxDRUkZmDg6ZJmSjamnbzjqakbIN5YLm3PQ7p+KoZUZcvTCc+C/DA+Ne4ClCtv1aO/I8tTAYiKTw+7rIFyg+BRXaRT9bmeTvxrCBoIVquAx+uEgvo4F7vTSmBdq28XkUHaVYVn+VKPTH0KBeJeHGVvFADTNd6HUM+SEbQ2GY+FdPJ38XVEodHNrH6CyVjS9ZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Rg/teba7svOhNa9pqhWsIlk6F5Xzt9aK+zX6/ZCx4w=;
 b=N/2HcHBHJCdiY4nqbjnF04jsZpT3E+kS8DJL2FvkZHVR8YqP6yFbI+9mKpp1NlBj0FG/N19K4/P2PFDi3LOR+y2ndQu5oOyNAV2nl4tLu7g0VCmwzUjCnxELOtwv7gabSLEAqNkdrtNqph5J+9fWrsUshE4q+EF12Zsnc4jKv1aV2gPKwwVeMUbgFzvgqeBQz7/tTSBySUY9WajjXsqU9ju/w2hAMsVkRPzTWF7XEDY2SdowhlbsXi36FXWZ62L3X3bLF3jBbNaTG0VlERo9MwJR8YMEC9Nd2Mo+loYP3Z4cEatD+xuOhhig3wnzM/Vrb+6FDcNp/L+FsYx/rCZ0Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Rg/teba7svOhNa9pqhWsIlk6F5Xzt9aK+zX6/ZCx4w=;
 b=p2e60Xj67Xb/8enz94GMr/uTWIARiQYZ1qtEsne/FHxk5XQmfQDvBnzT2uxHemXQobsuf/UCpRBM79m9R+igOy8KZ9HCTb7cR9s6wB6CuJPptRdbLnxrDYCIjng6U07uRf6j+P3vxotfyzW7szCzjgj0JlGUZjkFgEnNl6Bk/nQ=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TY4PR01MB13801.jpnprd01.prod.outlook.com (2603:1096:405:1f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Wed, 8 Jan
 2025 11:13:07 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 11:13:07 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, "kingdix10@qq.com"
	<kingdix10@qq.com>, "helgaas@kernel.org" <helgaas@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "kw@linux.com" <kw@linux.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, "robh@kernel.org"
	<robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: Re: [PATCH v4] PCI: rcar-ep: Fix the issue of the name parameter
 when calling devm_request_mem_region
Thread-Topic: Re: [PATCH v4] PCI: rcar-ep: Fix the issue of the name parameter
 when calling devm_request_mem_region
Thread-Index:
 AQHbYQw8Ov+GrVYXIkOEHDS2QfYjaLML7MqAgABlOoCAAGBE4IAAAeWAgAAA+KCAAARGgIAAAGiQ
Date: Wed, 8 Jan 2025 11:13:07 +0000
Message-ID:
 <TY3PR01MB11346F0645DD928C6849D9EAF86122@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250107225653.GA189000@bhelgaas>
 <tencent_D3EAA236B531BDF17998832CC18EC36CBC07@qq.com>
 <TY3PR01MB1134694A42FADD885D9D7596C86122@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CA+V-a8u--RC2Snmpm2QZxFfT382GrrD1Mse-JW-JJ_KWA-M_Lg@mail.gmail.com>
 <TY3PR01MB1134688B49138EA368C0E838686122@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <CAMuHMdWn8UV2F=YUsOnVkB0hDEd02Lzp1TtpKRPK-keU3Vm-mA@mail.gmail.com>
In-Reply-To:
 <CAMuHMdWn8UV2F=YUsOnVkB0hDEd02Lzp1TtpKRPK-keU3Vm-mA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TY4PR01MB13801:EE_
x-ms-office365-filtering-correlation-id: cbc1854b-386f-4e11-cc1a-08dd2fd56e19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bVhPQXdLZEtPeVZlSlE1OU5UWXdUS2dFdlJlZFovVGQyR0xJcFV0eWdYRDVr?=
 =?utf-8?B?d2J1d3dBMmMvYnliUVJZaFB2YkY5ang0V3gzL29jVFNNeDRrQ0F4VzFzYXQ1?=
 =?utf-8?B?NVFlN1dYTjIxV0laVk01dGxjSzRnL1RhcUpydDFIcGQ4c3A1UlNrVVlBZGQ4?=
 =?utf-8?B?eE1KUW04ajNHbWYwbDFNQlUzVTQ4SUZPT1NoTUlBWjRTSlZmNVB1WmtCOFZh?=
 =?utf-8?B?SGxPUUcvTmMrLzZKMkhyQXJyNUJ4Y3VnOHR1TjhQU1lIaDNKZ2tEU0tiR2Rl?=
 =?utf-8?B?czNRL1BBdVJreVhEZk5lUkpQU0ZHK3RoTUNBRHEwZjZwZTFXS09SQUVkaEdJ?=
 =?utf-8?B?OGZPSko0cUJWQ2M3amxMOWE1MlM1Y3JCelNWcVBENlNSOXd2TmFmWUVrUUpr?=
 =?utf-8?B?OUxuMEFEandmWTFIeWFoejRNemFzdEIrOXF3dVBVRSs0MU1HanpXOXpPT1Ir?=
 =?utf-8?B?SXdnaEkzK3pqVXg3VDBPYTdtNjAzbFJFVncwRDk0bm5KeUJMeDYzWDlnSVlG?=
 =?utf-8?B?TjJLc0FtZFAxcmdMSnZzZ3gvTVl2b2VXSndhN1VyWFM2bFR2R3ViRWMyaEYw?=
 =?utf-8?B?MzlvRlpCMGtzOXNjY1NHRDducC96VkxCN1oveFFxS2JaVzdqcFhtUExGaVFr?=
 =?utf-8?B?VVZPL0xYc2FZblVaWmhJdnh4Zm1KQkpnVGFyVHBTT0pxa2QrNmlaRzloNnEv?=
 =?utf-8?B?MzlRbXNnN2lLUkxWaWVuenBoQTBMeWdxZHRPK0laMEVMQjl4MEFLcVI2QkdC?=
 =?utf-8?B?cGVWWWhVL05Yam40c1dteE5yUkltZEgrS0hTUzFJVlhLKzZqZTNWdTVzTjVl?=
 =?utf-8?B?Um0zSzNkbG5iY1lKZGFyNUpVNFY4VkQ1TjFERC9ITndtelJOTVlEUGx2Sk10?=
 =?utf-8?B?L1FVbzBLMjd1NkJKUlJCemNzUkFCMkRRWlZqVmtvNjRmYU9LYU81NzArVzJD?=
 =?utf-8?B?aTk5RlZMYWwwZkN2MmRFNlBrek81V0FpT0hNNTdtZC9Cd3NaOWd4UGxkWGJo?=
 =?utf-8?B?Q05xRmc4K01IU2ZCaGpxNnBqaGduTjhCSG1zK2x4NWIwcVIxclJlTmtRYnFt?=
 =?utf-8?B?OFJvSjNkRkpDRDFNSXBGTjVwM0xOaFNuaU9XQ050cFErYkxuRms0dDlRajRn?=
 =?utf-8?B?SlhxNStPNm5YM2pZcFU2VjR0MnNqb0xMKytmbXg3dm5qMzgwMEd3T3JtcHV3?=
 =?utf-8?B?bjJEYjVIMnpuOHJVUnpDckF5SmVpTXBkdUxDa2FWQWJ1Tm80d2cweUhaY3lR?=
 =?utf-8?B?YmtwSzA4U1dKTlZwMHVVUDhhRFNRaEs0SVpzaVZoOEpET2QxSy9GSE1NZmto?=
 =?utf-8?B?WVF3MFFjVERZV3liUGRTRzJiaTkyMnlSSWxIb29LM1lTdDRqVHJLN2NxeDVD?=
 =?utf-8?B?WUxqZGo0Uk9tL055YlRvbzNEV3RnaTExb0krS2s0ZkZkNTl3dEphZGUrT3hL?=
 =?utf-8?B?V3pDcUp5YnUwWjNHZ24xemxuYVc4WGxmVlVMdjFhOUs3a1JKQUs3QURMblNY?=
 =?utf-8?B?TkZXZUxHVTZiK0xoOUJabm9kdktyWUJNS3hIcC8xTnBkUGRldU5HYWJuN2gr?=
 =?utf-8?B?TmxTRFpya3VHM0JJak9LRktFQVpmb0RNVFlkdDdENHZ6UXd2aVFodHBXdktz?=
 =?utf-8?B?NXVGbjYyZldFTFZVQW9jZE4zTjJiN3M1SVM0aWRucFRvTXcrWDBXL3k0Mkw2?=
 =?utf-8?B?QlZ3eFlsNFR1Zy9WZUtwWGYxSE9kU2swWnVkNU4yUWpEQTlsTkxJcitydGFI?=
 =?utf-8?B?QzZJNFJmUit6MFdOUHR0OUhCcHMvZUdjZUowS0E1VFpKMTFxbEw5S21JdER0?=
 =?utf-8?B?NlE4UFRoenBickw2Nk4yYzdCRndYQjhsKzZiczhZanVKSm5TMllPc2xid2lI?=
 =?utf-8?B?cmxjUGo1WTcvWStyRnJrRWdIK1ltbGhmNEdyUjAzVE1OdkFJY3ozMWdQZlFs?=
 =?utf-8?Q?J3OMvTv+sfs2yGLk3FubefyKfBITuN54?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SVA4TldPbEpucm9VV2FpQysyQWN1YWpqWThYZXU1bUIvYm8zcTg1QjNGVE1M?=
 =?utf-8?B?QmdOOVBWaUxYRmhEcUVXSnpsN01NU0ZWeE9LRnBTKzdsMlhSMVRhM28vOXpW?=
 =?utf-8?B?Z1Y4VytYNVlCQzVTR0ZpWEhQbkhlQWYwVGllUjFNb3pYZ0tKUXBYOFl2YzM4?=
 =?utf-8?B?bkM0ZzRtcE96R3plbWRoOUIyYkIvMlZPcGVJWUM5N2JpYUZUdmlENkFuYTg3?=
 =?utf-8?B?UWpLQ0h5R1RYeFg3QjIxQTZRTFNnUjVZdllhNDEwMGR2WUJOSUFJQUs0cWFv?=
 =?utf-8?B?OXo1RkxyUTVhMHQwZy9KcnlCRFB2MTBocXhXYndEYmpuY0tmVkZ3anVUYnpa?=
 =?utf-8?B?NVRjSS83NUo1cUUvRHRhNURqRnp3eHZaTnFJK0tkN2ptSzdKcDZOOGZoRmp1?=
 =?utf-8?B?ZWJGWnMxRG8xQWFXMDh3M2oxZWZnTkdmVGpQajY2WkZRekFKbVpqSmdnYTNU?=
 =?utf-8?B?SVhJVFBNSGg2Y1RiSEIwZk90N0JpMWNETE0xSUhzQi9sL1ovTlg3LzN1QUdS?=
 =?utf-8?B?S2lnV3Jnd2dhbzh0V1loWVdnYnJvWElCZGRXWWtNVkl1U0tLSWlHRkRqVXRW?=
 =?utf-8?B?NmJLaGg2U3Ftd2J2Q1FFT1FaanN2dnZYQU5mTEpPenVNdTRlZXd5VHpxdGhk?=
 =?utf-8?B?Wmc2UWlORHhxbXYxYW9pbkxVN3RHcVoxcWVxMitEYS9MbnJtWUc5SW5uYThT?=
 =?utf-8?B?VFhUZURON2p6cEoreENud05FM29TSERCaEpmYWZwNzVLVVJXL0R2TFZVZytx?=
 =?utf-8?B?Q0NNQlY0azNSWXpHWUR0bGZnV04wUjNkUkMyNVd3eHNhM2FxcHk4RG1OSmJR?=
 =?utf-8?B?eDBmb2pGSWp2RHhMUkZBazJ1bXJqUVYvaE1nb1ovb1NZVkc5LytXci9KY202?=
 =?utf-8?B?RU9CZEtCNkE2a3Y3RnphM2tpT0xpMGhrQmU0dnc2aUN0NUxUVkxxbkRuMjlp?=
 =?utf-8?B?N3ZqTUlIYWUxN0lJY2c0akFnRkZaZndJYmhNUXp6MHNpcWtrZXJYUEVzMXp6?=
 =?utf-8?B?aG1XQ1BnTWd1T1RCV2FjQXh6elBNbUtoRGMwL2hGeGxKN2JQOW5YWWxJZzdi?=
 =?utf-8?B?bEd3LzVUTisrNkNnbFhnU3BhVlQxMEczZENKSmNVTFdyQXVacGQwWjlFT1kv?=
 =?utf-8?B?dW5xSDhDam9NOFdCUldKNU9nTllRRGlvVU90U3NVRVNPcTkrdXBCZUpIRk5Z?=
 =?utf-8?B?SnoybEw2d3RXMEVWWFdEVlFDbnFSeUE0TlhqU3V2RDBMZlJYQ1RWUXNRQVc1?=
 =?utf-8?B?VnJyQXVxR0w1N2ZCQ2hXUm4vc0ZBRmZNY054NnIvbVZaZ05HZnZBb2FMVjdE?=
 =?utf-8?B?UFBwKzcxbXpMWXZGZ0hTd1h3M3hzWDg0RnNpSmtEc3JBSFlkVzlrLzFJLzBa?=
 =?utf-8?B?aDlwckJ0azBrb2NORW9aNHJWdi9kdnlOdGZnVFVSUUNJZFArZmZNbTAxako0?=
 =?utf-8?B?ZnJlUW4rekdrR1hMTzVxa2VacDhiR1lSN1hmdE1iK1hZNXRXellFZTdSd0hx?=
 =?utf-8?B?b3JsSmVZbWJHVG9oZW5WR0ZDa0ZYTU04QURlS2p5R0NtbjR1Z2lEZWwyb0o0?=
 =?utf-8?B?ZzdqSTB6aHF1cnYvaS83SFBSL3d5V0pNSEtKNFA3dVRTdmJKeG1KKzFIYmo0?=
 =?utf-8?B?WTZyMnRDWnVxZm4yZFlVbGlpNEZqWFZxSGMvNm9LMDVsaDhFNE9QMkptd282?=
 =?utf-8?B?d2JtK1YrdFRPYTNTcHJvQU5kczNFckdNS2NWcUNrRTA3enlFT0p3MWt5ak02?=
 =?utf-8?B?SkN3Z0hhclpqNVRkaEp5T0wrRmJONjYwdU5LMVNFNnBVZHNIdS8rTWkzVlg4?=
 =?utf-8?B?d1I4UlJNeXZnUFduSlVlOVNBOEhpb1lUZGhSSjVmSXJ3d1RValFZWTZZWWlP?=
 =?utf-8?B?STNPbnViNWJkM2pyRlJRcyt2RTFWcms0OXc1d0JCWG9YNlRkOXIyUnhwMDRE?=
 =?utf-8?B?RVozV1VjYThWR0JiUjJkSmEvUTFlS1I4YStCWFlSQUViUEVwMHZRSVdVVUNF?=
 =?utf-8?B?bXhhK1J4cmxkdDhzNmt6ZkR4U2FtZXNxQ2RUS1JGZFZpVVdibDRabVBaTEFX?=
 =?utf-8?B?R0dzdkgwSDNGMHR0RWtSckNrNjJZRU1tY1R1MTMyN0V3dGZvcjJXOU9uY2tY?=
 =?utf-8?Q?bVnA1i3XtZGewNarKV8rYCWI5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc1854b-386f-4e11-cc1a-08dd2fd56e19
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 11:13:07.7625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CFk4L4EeiNXshJ2ToTI8pCoDCfRO4xLhGZMFiqErNb4gttLWRdjisYmNQPf/Y/bIZLAj8GeEc/pNma3dSRDZfsqfeXHXPKHDTMPzmO8mkI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13801

SGkgR2VlcnQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gU2VudDogMDggSmFudWFyeSAy
MDI1IDExOjA5DQo+IFN1YmplY3Q6IFJlOiBSZTogW1BBVENIIHY0XSBQQ0k6IHJjYXItZXA6IEZp
eCB0aGUgaXNzdWUgb2YgdGhlIG5hbWUgcGFyYW1ldGVyIHdoZW4gY2FsbGluZw0KPiBkZXZtX3Jl
cXVlc3RfbWVtX3JlZ2lvbg0KPiANCj4gSGkgQmlqdSwNCj4gDQo+IE9uIFdlZCwgSmFuIDgsIDIw
MjUgYXQgMTE6NTfigK9BTSBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+IHdy
b3RlOg0KPiA+ID4gRnJvbTogTGFkLCBQcmFiaGFrYXIgPHByYWJoYWthci5jc2VuZ2dAZ21haWwu
Y29tPiBPbiBXZWQsIEphbiA4LA0KPiA+ID4gMjAyNSBhdCAxMDo0NeKAr0FNIEJpanUgRGFzIDxi
aWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4gRnJvbToga2luZ2Rp
eDEwQHFxLmNvbSA8a2luZ2RpeDEwQHFxLmNvbT4NCj4gPiA+ID4gPiBTZW50OiAwOCBKYW51YXJ5
IDIwMjUgMDQ6NTkNCj4gPiA+ID4gPiBTdWJqZWN0OiBSZTogUmU6IFtQQVRDSCB2NF0gUENJOiBy
Y2FyLWVwOiBGaXggdGhlIGlzc3VlIG9mIHRoZQ0KPiA+ID4gPiA+IG5hbWUgcGFyYW1ldGVyIHdo
ZW4gY2FsbGluZyBkZXZtX3JlcXVlc3RfbWVtX3JlZ2lvbg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
T24gVHVlLCAyMDI1LTAxLTA3IGF0IDE2OjU2IC0wNjAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiA+ID4gPiA+ID4gT24gVHVlLCBKYW4gMDcsIDIwMjUgYXQgMDk6NTE6MjNQTSArMDgwMCwga2lu
Z2RpeDEwQHFxLmNvbSB3cm90ZToNCj4gPiA+ID4gPiA+ID4gRnJvbTogS2luZyBEaXggPGtpbmdk
aXgxMEBxcS5jb20+DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IFdoZW4gdXNpbmcgZGV2
bV9yZXF1ZXN0X21lbV9yZWdpb24gdG8gcmVxdWVzdCBhIHJlc291cmNlLCBpZg0KPiA+ID4gPiA+
ID4gPiB0aGUgcGFzc2VkIHZhcmlhYmxlIGlzIGEgc3RhY2sgc3RyaW5nIHZhcmlhYmxlLCBpdCB3
aWxsIGxlYWQNCj4gPiA+ID4gPiA+ID4gdG8gYW4gb29wcyBpc3N1ZSB3aGVuIGV4ZWN1dGluZyB0
aGUgY29tbWFuZCBjYXQgL3Byb2MvaW9tZW0uDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+
IEZpeCB0aGlzIGJ5IHJlcGxhY2luZyBvdXRib3VuZF9uYW1lIHdpdGggdGhlIG5hbWUgb2YgdGhl
DQo+ID4gPiA+ID4gPiA+IHByZXZpb3VzbHkgcmVxdWVzdGVkIHJlc291cmNlLg0KPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+IFRoYW5rcyBhIGxvdCBmb3IgZG9pbmcgdGhpcyB3b3JrIQ0KPiA+ID4g
PiA+ID4NCj4gPiA+ID4gPiA+IEFkZCAiKCkiIGFmdGVyIGZ1bmN0aW9uIG5hbWVzIGluIHN1Ympl
Y3QgYW5kIGNvbW1pdCBsb2cuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhh
bmtzIGZvciB5b3VyIHJldmlldy4gSSB3aWxsIGZpeCB0aGUgaXNzdWUgcmlnaHQgbm93Lg0KPiA+
ID4gPiA+DQo+ID4gPiA+ID4gPiBQbGVhc2UgaW5jbHVkZSBhIGNvdXBsZSBsaW5lcyBvZiB0aGUg
b29wcyBtZXNzYWdlIHRvIGhlbHANCj4gPiA+ID4gPiA+IHBlb3BsZSBjb25uZWN0IHRoZSBwcm9i
bGVtIHdpdGggdGhlIGZpeC4NCj4gPiA+ID4NCj4gPiA+ID4gTWF5YmUgUHJhYmhha2FyIHNob3Vs
ZCBiZSBhYmxlIHRvIHByb3ZpZGUgT29wcyBsb2csIGFzIGl0IGlzIHRlc3RlZCBvbiByZWFsIHBs
YXRmb3JtPz8NCj4gPiA+ID4NCj4gPiA+IEl0IGRvZXNuJ3QgT29wcyBvdXQsIGl0IGp1c3QgcHJp
bnRzIGEgbnVsbCBzdHJpbmcuIEJlbG93IGFyZSB0aGUgbG9ncyBmcm9tIFJaL0cyTToNCj4gPiA+
DQo+ID4gPiAkICBjYXQgL3Byb2MvaW9tZW0NCj4gPiA+IDMwMDAwMDAwLTM3ZmZmZmZmIDoNCj4g
PiA+IDM4MDAwMDAwLTNmZmZmZmZmIDoNCj4gDQo+IFByYWJoYWthcidzIG9yaWdpbmFsIGVtYWls
IHNob3dlZCBnYXJiYWdlIGhlcmUuDQo+IExvb2tzIGxpa2UgeW91ciBtYWlsZXIgcmVtb3ZlZCBp
dC4uLg0KDQpPb3BzLiBNeSBtYWlsZXIgcmVtb3ZlZCBqdW5rIGNoYXJzLg0KDQo+IA0KPiA+IEJl
Zm9yZSBwYXRjaDoNCj4gPg0KPiA+IGZlMDAwMDAwLWZlMDdmZmZmIDogZmUwMDAwMDAucGNpZS1l
cCBhcGItYmFzZSBmZTEwMDAwMC1mZTFmZmZmZiA6DQo+ID4gZmUyMDAwMDAtZmUzZmZmZmYgOg0K
PiANCj4gU2FtZSBoZXJlLg0KPiANCj4gPiBBZnRlciBhcHBseWluZyB0aGUgcGF0Y2g6DQo+ID4g
ZmUwMDAwMDAtZmUwN2ZmZmYgOiBmZTAwMDAwMC5wY2llLWVwIGFwYi1iYXNlIGZlMTAwMDAwLWZl
MWZmZmZmIDoNCj4gPiBtZW1vcnkwIGZlMjAwMDAwLWZlM2ZmZmZmIDogbWVtb3J5MQ0KPiA+DQo+
ID4ga2luZ2RpeDEwQHFxLmNvbSwgbWF5YmUgeW91IG5lZWQgdG8gdXBkYXRlIGNvbW1pdCBkZXNj
cmlwdGlvbiByZWZlcnJpbmcgb29wcy4NCj4gDQo+IERlcGVuZGluZyBvbiB0aGUgZGF0YSBmb3Vu
ZCBpbiBtZW1vcnkgYXQgdGhlIHRpbWUgb2YgcHJpbnRpbmcsIHRoZSBvdXRwdXQgd2lsbCBiZSBk
aWZmZXJlbnQuICBJIGd1ZXNzDQo+IGl0IG1pZ2h0IHN0aWxsIGNyYXNoIGluIHRoZSAodmVyeQ0K
PiB1bmxpa2VseSkgY2FzZSB0aGF0IG5vIE5VTC10ZXJtaW5hdG9yIGlzIGZvdW5kLCBhbmQgdGhl
IHN0cmluZyBpdGVyYXRvciB3aWxsIGFjY2VzcyB1bm1hcHBlZCBtZW1vcnkNCj4gYWJvdmUgdGhl
IHN0YWNrLg0KDQpJIGFncmVlLg0KDQpDaGVlcnMsDQpCaWp1DQo=

