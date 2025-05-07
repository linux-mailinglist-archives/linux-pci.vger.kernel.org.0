Return-Path: <linux-pci+bounces-27362-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D426CAADBDE
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 11:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2408817C638
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 09:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFFF76410;
	Wed,  7 May 2025 09:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="JcBVV5vP"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010032.outbound.protection.outlook.com [52.101.228.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37731BC099;
	Wed,  7 May 2025 09:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746611437; cv=fail; b=G4Wl1ng3c6MteUU5Ai86mhcCwYQIqf9tJCBQpg68G7JmLQ+pdi0hAE6FotLLoJuCYfOzHhM6sb+ZSkvQghvaA7JrX3u1d6drbvWz+GuR6ZjmzG8D17V3BpJubdswlGs8vgDgIpz7T8tT6HYehFY72/s6Xgz04H2V1XSQYvM0YqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746611437; c=relaxed/simple;
	bh=eUwd8ESPD0AYlTIFdjDvDVHVfcQKVPx9sPlVTkty1io=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kw29VNHdKgoqB7PnWos+bCHpFKB7j3FQYandAE1VnIvVV1AnyaKC8NDlJj78XU0Yke6OIxSurCDMe3LmMlWjlC1/+MQ7e0eNH4tslygWKQp4a2fivetFId2AGO+FA74rOpcs8SFY2nuGqEgX28AhMPq7aPgetT0rRRSRNWxkmCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=JcBVV5vP; arc=fail smtp.client-ip=52.101.228.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzKInCOJsfdAtsJt7kD+Y25PV127CZU7ZubaIZwg0jwesMT0Q2a62cYFtXIz38ZVnH+D13bLsR6/O3Sg4AHzQcWuFjBApfZbJqe3ZxSbC9Yvl41Se+x3kR1hxrbxf4ZBfx8cAj6HQ8HOnT9OY+qL8jFZOrrPMcNPkHVn37rUJHW9TXOXUoELkCEBi7JGldjtKIG/KGnQOvYX0CpJ5ddapsmGPV+LR67osqSW/DPh3z7xkzUZ2zwb7DsNDOY3m91TfKmZ9iXsE6jr4zB37AkkaN4KiYBPNfdMQseG2P34PXIeDsYCWYzyqwll2m6AqJXAFtgryBgmxGgu2xmvuyKYVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUwd8ESPD0AYlTIFdjDvDVHVfcQKVPx9sPlVTkty1io=;
 b=W+E7piEy2e/UQVL1ADZkP6iILAV5BCQga4lI5NYT9ivTSi0Ha50mBqFcJ8gOAeD7T7bxE7I++tiCnbNGTRJazqjNc4CUmu9njLdHb/Kn73hTiXxCobnH9AnLPmlzi9M78FN0j+//NhOhaEwtKrq3rSXJEV9HQOoXH9Yp9PKEXyLgdtES10+64ZqqQkRI1Lt+McJTH5swMl005/KrXWJQDRl6cF68u/lTJO/zcvgobJNoO0bIxjfOKmvfW4c4xIRabYWzOs5hrvE6Oenb0YH5ZEoExzb/jkLIXdSMCi6sJEYTXDAODxQXOfVtNaMLi8xnolhte3TvUIp6qxldJTOuXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUwd8ESPD0AYlTIFdjDvDVHVfcQKVPx9sPlVTkty1io=;
 b=JcBVV5vPa7h0OafnYMewFLn0Md1qguHnH33gspPjMA8FMjNGjtvJUdS/K5nTYMDMK1sHbS1F3J1aK8tGXK62gRFntTjxGR5BeYtkc2dElMCrucIsVTwNCP19qzOPZBm+wJBa7CtTZ6AlqiZ0AEJ43zZszvPrYWBGdFdkVBMg6Dw=
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com (2603:1096:400:3a7::6)
 by TY7PR01MB15782.jpnprd01.prod.outlook.com (2603:1096:405:2c4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Wed, 7 May
 2025 09:50:31 +0000
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::b183:a30f:c95f:a155]) by TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::b183:a30f:c95f:a155%5]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 09:50:31 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "jingoohan1@gmail.com"
	<jingoohan1@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3] PCI: rcar-gen4: Add a document about the firmware
Thread-Topic: [PATCH v3] PCI: rcar-gen4: Add a document about the firmware
Thread-Index: AQHbJg0OLlWgHt12lUaRVVSgNsKFl7Org5wAgByawJA=
Date: Wed, 7 May 2025 09:50:30 +0000
Message-ID:
 <TYCPR01MB110406F22A516E4C41A021EE6D888A@TYCPR01MB11040.jpnprd01.prod.outlook.com>
References: <20241024120525.291885-1-yoshihiro.shimoda.uh@renesas.com>
 <xkcifbp4f5ql3luxzsdvkjomhxiqzmcorkbjv2wtq36rsfgbgy@xnilxquk3arf>
In-Reply-To: <xkcifbp4f5ql3luxzsdvkjomhxiqzmcorkbjv2wtq36rsfgbgy@xnilxquk3arf>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11040:EE_|TY7PR01MB15782:EE_
x-ms-office365-filtering-correlation-id: b0a3e796-4c46-45d3-45df-08dd8d4c9ac1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Qm01UlNYOUg4K0pCWGY4dHEvT3VmSEhrMzNvSXh6Q0JWeStSNDhqa2JjT3lW?=
 =?utf-8?B?ZURqd3ZUSm55a3gvY1ZIekJTZ05EVWJUa0ZUVnMrV0d5TTQ0YkkvZ01TVzdt?=
 =?utf-8?B?ZHpZZ3pNU2xJU0lBU1VneHpBMG9JOHBHamRjRit6bllHcytVOHJFOVJ1c3ll?=
 =?utf-8?B?UVZYVXVYRGowWEpIa2NTTFBvUndmamJIdy9kN09pUE0wb3BOUmVQRVl5NWlE?=
 =?utf-8?B?SXVtNi9lT053elRGa2RLK0kxSUtqbnhkSXE0RVYwNEtsOW50Yy8xZnF3UTdU?=
 =?utf-8?B?ZlM0eU9Kdi9OVG1tSEpiM1pHK3ZNMS9VbEFERjZSMzQ0QkdmRjhjV2NuSTJx?=
 =?utf-8?B?NW51VmhMM2swSjRKTnBwYkhZckZsbFJMaHlWK1YvaHFZOEptaVJlU011dXI4?=
 =?utf-8?B?VXc1QnJsR0s0ZUFqUGpOOVNxQjBuYjNSSmFYaFEwZ3BrOEw5TTFuVmEzUWFr?=
 =?utf-8?B?QmRycU9qRU9DKzZ3Wk01Q3UzV2kreGo1c2puZjhJMmk5eDM0cFRXQTlLWU1T?=
 =?utf-8?B?NjBLZm5Ycm56OERTUDZXUUVGMGVyR3pKcG5TMzJuazRueThTZFlwR1NsanNz?=
 =?utf-8?B?Z3d3TWtMQjNmcm5IWk82RmROTTRUdUowbjE0WUhTdWVnWmhBdEhCelRDRkVY?=
 =?utf-8?B?YmwyVjNNcmpDTFFHeEpBblh4UVE2aEhYK1pkaTZuWXFVWkJaQm5PMkhibU01?=
 =?utf-8?B?ZjY1QkhrZU9DNStVRkhxUFpZRkNLaFRxMG43QmMvSjRJajlGZ3N1N1psazFQ?=
 =?utf-8?B?aExLY05MZ2tOK2N6T0FJZzQ2aUg0ZHI3WEZzSGI4YmY4TnA3bzNtNmJyaGlP?=
 =?utf-8?B?UmZqYnJpZmF4OHRMem1xb0o4T1BROTV5WHo1NjlLQkNMNkpjZ1hQTjJ2Y0wx?=
 =?utf-8?B?OEt3R1VBWEl2b1dyNzE2UUFUYTZNQXBpckZNL21acTU0a2JGdjRwME1tVUx0?=
 =?utf-8?B?ajRDVk45TDBHZEdnRHk3U0pOUGlNaElZalJzRThqMGVNc016R3UrbnFjc256?=
 =?utf-8?B?U2JheGg5dUkrQmdBUEFJa1IxSDVLQTFFWUpLdzZHWUJ0clMyMVFVbTFkUUdx?=
 =?utf-8?B?b1kreFpncVptTzcwRUhadHFSNTJmYWNQTE5SL2w4cEhrcTZSb1pmUmdPY2ZH?=
 =?utf-8?B?RFdFaHZrNVJmUzRUUzlpUVFZbmptNnUxYzM4SDh2K2FJZUNjaGplVmlWM2Vn?=
 =?utf-8?B?OWljZm9PU2oza3JLZ1hUOWowY3pKc3hsRkhxRDE0NVBEK3NGODdwY3hibUVz?=
 =?utf-8?B?a1hoaGRCYWV4SzFoN0VxZ0dZTDh5MFRlUjU3YUp2UlhBVExZUmNQaWdaU2NH?=
 =?utf-8?B?STkzY3c5VlpuYkRvam9VZUhENFBhdnFPTnc1enhQMDRVWllvdXdaSEVHdEJ5?=
 =?utf-8?B?azlZQ2lMNEJxTVdvdDhDZjcxdUpFVnN6aDZBbTlENzJvQmdDNnMrQU9NRERl?=
 =?utf-8?B?Ri8yVDZIbExCYVBVdnpaZXRqVEtzMWNyYUZQOWw3Sk5RMjcramkreU83Mmxu?=
 =?utf-8?B?b3BvZXRndXl6MUxubXUwMkdYam0rbDBkcElNWDhaV1YrOVc3cGhFaWhDYWs1?=
 =?utf-8?B?d0pQRmZGWlpqWkV4SjZpQkxKdC9wbG1pVjlwUStVSEI3NUtPU0ZING40TGd4?=
 =?utf-8?B?RXlZa3ZDRDlHNHp4WWRBV3dJQmlGUzUrRzNzY3ZhRnRZQnpGdHBTbU04VXFp?=
 =?utf-8?B?a05WdjZnSGwrOStmeUU4em5aT2t6cEh4Si9SRG5SV0VQVjNvSGpIRmtGY1lJ?=
 =?utf-8?B?NnZxS2NQRG5HL1NGNFpQd3c2U3BxRWp0UVlYMm9tMzRCUTcvNW9HZFlSckVq?=
 =?utf-8?B?b1JoekkwNG8xdVplbVgyaysrVUZlQzd3cnFrK2JOeVpsdWxhWTAxckdPL3NL?=
 =?utf-8?B?dWw5b01SNTVBV2x4R0R2QXRtc3NDczI3RUN4SWFZYkIwYjByT2RaNW51eDFw?=
 =?utf-8?B?aHJlMTdXZk1PSDEzL3d2R3VheFNmcFQ2dFZyeWYrcTRUOU93c09rWHhMc09X?=
 =?utf-8?Q?EvrClN7Oj4ofUCVA2i/41GoIMOtpZY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11040.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cktoVUVmNHNmeWRkMDRsMjR1V0V6bnhZOVExYWplVndQc3VvdFVWMzhseFdT?=
 =?utf-8?B?QW1uVWhnWjdBZEhZWS9naU1ZQkdCMUZGeTM0NERDNEhHWU45ZW1aYUQ1WXM0?=
 =?utf-8?B?c2Mrdi9ObU1DUllvSDZCcE9MT0g3ZnVYVFZDOUZaL05sbnJkdjBhVFArbjNT?=
 =?utf-8?B?NU5DY002bWF3bWdRUEFpMUVaaUhjMW1EdUF0ci9yTXhhSUdVVmpNY3VBcEtN?=
 =?utf-8?B?bEw5eVl2ZHpjdFViVmh1cGFZck05L01vSXNyaEx6ZmlYQUpmSjhydXpEanpN?=
 =?utf-8?B?Q3M1ZjNjZ1h4SnBzd28vOWs0Z1N4eTcvblpHazdVdXEwVTNZb2Z6WWR5UjM2?=
 =?utf-8?B?ZHFBQXhEMXdVNkRlUFRjOG9LemtSWTFmUzM2QytuSEVGVy9GY0pKTWEyak00?=
 =?utf-8?B?azBLVWZkN2NoQktNSkcrdW9VK280YmFIZFJqRHg5dVpUNERyNkN0TSt0M041?=
 =?utf-8?B?UDhMOWZ1YzlXWDhJTEtvRzBRWkd6M0JkNFlZZi9EalpYaGtWbUxaWHI2NlZY?=
 =?utf-8?B?MTZrakYwY3h2L2VSWU44R0tjV2ZWMzhBVE90cGp3NHZPNVlTT1hmWnFZN2tx?=
 =?utf-8?B?dUU5U1E4Slp5MVNmamxTdWtaTHoyMlBOY0ZzWVNsYUxPTXJhdFl2Sk5pSmNR?=
 =?utf-8?B?RlpZa1pWVzdwTnUybTliNFlJTisrRlg5MERVZU9PbkJXU0o3ckhza2xMZzY4?=
 =?utf-8?B?Q2pRL3BvWUx1Q3dZdzBKVGVyNE5jT281ODNSbnM3VjRPWmFTaWZHQjFGY09i?=
 =?utf-8?B?QUNKTG9aZXBGYVg1SlNXOVBJQ3loMVF1RENJb1QvTlByMWdHU3I5d2kyTkY3?=
 =?utf-8?B?Wk1ickdMK2VwWkVqQkZRaWlSOVg1VG9pTWMwR0hoMlBQUjdnVDl2QzAyZm5C?=
 =?utf-8?B?cGN6UVlyVWd0c1FDN2x5RUI1Q0RkTXI5QW13WU9ORzA4anFxUmdaY09WR0Y2?=
 =?utf-8?B?QW9uQ0xiZFF1V3hTMGZIWHVHS05OMzYyVVdNVjZTMzEvRlliMjM3RWhaVHNO?=
 =?utf-8?B?UzR2b25oY0RpRXRvb3dhcE96ZXgvRUc1Z0FoWTZLci9xdk9iMVJpTlJwMThm?=
 =?utf-8?B?R0FpNW1ZVnJCWEUzVy9QTzB0Nlg3YjEwNDVPUjcxTFdseS9ZbDFxNmYrU1Jl?=
 =?utf-8?B?WURZdis4WFFMd2poY280WWwyL2J2UjN2ay8zbWV6VUQ3U1oxZ1FVd2R1MWF2?=
 =?utf-8?B?U2FLM1NVVWl2ZVFHRzEra0ZFeUtvOEtpbmp1NkNmV0FxdjZJYnVpQklSOTJp?=
 =?utf-8?B?Tm1RaEFVTVdLVWcyUnNjeXVvU05SZDQ1N0FLaWZPVTRzb0U5OGlRcVQvTzBJ?=
 =?utf-8?B?QndDd3dFNE0yallPMVVXVW9qTEtvNjJhZmVidUxtZGRmSWdpU3dGQnVGZEMv?=
 =?utf-8?B?d1dYcU45bUhMdkh6aExCQnBnWHI1ajZ4SjRuZE5FMFhMRDRSNEJtUWswZEpM?=
 =?utf-8?B?ckVIaXQvc0lKZ3JhN0VYNGVNZWhPMmU5V2xpTXkwN2d0ZUpDUjNwMWdIR1lp?=
 =?utf-8?B?cDZuU0U0UHBWY1VuQ2dlMVk5cGs1cGk5MmNHaXlBVzcweTZIRW9waTJGVEU0?=
 =?utf-8?B?MjdKM2tpaEpPUU4xbWdQaU9QbEpPSU5QVUJWdXAxbVltMUJiTHBFUjZGTURL?=
 =?utf-8?B?eGdBUHZCVnkwYmxGRldVcDFqMGx3bVR6SlZlT2JJMmtEL2R5Q2V4WUZISm5T?=
 =?utf-8?B?Unp2OWxPd25rZTl2emRLa2QzamZRZE9Ob3dsR3krWVU2TGdLKzFEeEF6Z3A5?=
 =?utf-8?B?Mld2S0NHWFR4UlBNVlY1aHJRRXlPYVFDYUQwaU1LS2NKKzFNZG9XOVpISnQw?=
 =?utf-8?B?dU03NkFTUGdLa3Z1STVGRWl2Q2FWTlgwaTdIWTNTZGliYVgyQU1PY2dNV09M?=
 =?utf-8?B?ZzhlbmQzK3JRVXByQWtGMTZ1RUZ5dmdrNFpWODE0V09sWDMzWmdYdmdFTU1w?=
 =?utf-8?B?dlBhZUpzZlBuRWN1cXZwczlYODRJdHlwTGlaSkZkTDBUQXk3RkNhNU96WEFW?=
 =?utf-8?B?Wm1FeVVlM2xzdmI5Q2lyeFh0YzFaSkVOMmFHOXNEV2VJMlpRL3VESjJXWHpp?=
 =?utf-8?B?MTF4NVhqLzJYSXAvaFE0dkk5bitsRTE3eHFXWnJlMUhnaUdxY09ueTJ4a2NL?=
 =?utf-8?B?WHdza3JLUUN1UUNMVVptYzYxcmxpNXZtOEczRnRZSmU4RGVmbzZrVzQ4OTFh?=
 =?utf-8?B?V2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11040.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a3e796-4c46-45d3-45df-08dd8d4c9ac1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 09:50:30.9440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JCY2tgtC6AnEN5Tu4WDEF+Z3OVRUv9MVLw+1eDZCw/irUFBMSz5TO5UuprZ90zpw450b4ccduUOm/aI02lgM0GLQCcy304Bxlia4D8ByU8dCUr+bhX2FEVFYiFDpKecn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB15782

SGVsbG8gTWFuaXZhbm5hbiwNCg0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6
IFNhdHVyZGF5LCBBcHJpbCAxOSwgMjAyNSAyOjAwIFBNDQo+IA0KPiBPbiBUaHUsIE9jdCAyNCwg
MjAyNCBhdCAwOTowNToyNVBNICswOTAwLCBZb3NoaWhpcm8gU2hpbW9kYSB3cm90ZToNCj4gPiBS
ZW5lc2FzIFItQ2FyIFY0SCAocjhhNzc5ZzApIGhhcyBQQ0llIGNvbnRyb2xsZXIsIGFuZCBpdCBy
ZXF1aXJlcw0KPiA+IHNwZWNpZmljIGZpcm13YXJlIGRvd25sb2FkaW5nLiBTbywgYWRkIGEgZG9j
dW1lbnQgYWJvdXQgdGhlIGZpcm13YXJlDQo+ID4gaG93IHRvIGdldC4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFlvc2hpaGlybyBTaGltb2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2Fz
LmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIGZyb20gdjI6DQo+ID4NCjxzbmlwIFVSTD4NCj4g
PiAgLSBSZWJhc2Ugb24gdjYuMTItcmMxLg0KPiA+ICAtIE1vdmUgdGhlIGRvY3VtZW50IGZpbGUg
b24gRG9jdW1lbnRhdGlvbi9QQ0kvLg0KPiA+ICAtIEFkZCBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
ci4NCj4gPg0KPiA+IENoYW5nZXMgZnJvbSB2MToNCj4gPg0KPHNuaXAgVVJMPg0KPiA+ICAtIEZp
eCB0eXBvcyBpbiBib3RoIHRoZSBjb21taXQgZGVzY3JpcHRpb24gYW5kIHRoZSBkb2N1bWVudC4N
Cj4gPg0KPiA+DQo+ID4gIERvY3VtZW50YXRpb24vUENJL3JjYXItcGNpZS1maXJtd2FyZS5yc3Qg
fCAyMyArKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjMgaW5z
ZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9QQ0kvcmNh
ci1wY2llLWZpcm13YXJlLnJzdA0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
UENJL3JjYXItcGNpZS1maXJtd2FyZS5yc3QgYi9Eb2N1bWVudGF0aW9uL1BDSS9yY2FyLXBjaWUt
ZmlybXdhcmUucnN0DQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAw
MDAwMDAuLjBkOGE4N2NlOWFhOQ0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVu
dGF0aW9uL1BDSS9yY2FyLXBjaWUtZmlybXdhcmUucnN0DQo+ID4gQEAgLTAsMCArMSwyMyBAQA0K
PiA+ICsuLiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiA+ICsNCj4gPiArPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+ICtGaXJt
d2FyZSBvZiBQQ0llIGNvbnRyb2xsZXIgZm9yIFJlbmVzYXMgUi1DYXIgVjRIDQo+ID4gKz09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gPiArDQo+ID4g
K1JlbmVzYXMgUi1DYXIgVjRIIChyOGE3NzlnMCkgaGFzIFBDSWUgY29udHJvbGxlciwgYW5kIGl0
IHJlcXVpcmVzIHNwZWNpZmljDQo+ID4gK2Zpcm13YXJlIGRvd25sb2FkaW5nLiBUaGUgZmlybXdh
cmUgZmlsZSAiMTA0X1BDSWVfZndfYWRkcl9kYXRhX3ZlcjEuMDUudHh0Ig0KPiA+ICtpcyBhdmFp
bGFibGUgaW4gdGhlIGRhdGFzaGVldCBhcyBhIHRleHQgZmlsZS4gQnV0LCBSZW5lc2FzIGlzIG5v
dCBhYmxlIHRvDQo+ID4gK2Rpc3RyaWJ1dGUgdGhlIGZpcm13YXJlIGZyZWVseS4gU28sIHdlIHJl
cXVpcmUgY29udmVydGluZyB0aGUgdGV4dCBmaWxlIHRvDQo+IA0KPiBzL3dlIHJlcXVpcmUgY29u
dmVydGluZy9pdCBpcyByZXF1aXJlZCB0byBjb252ZXJ0DQoNClRoYW5rIHlvdSBmb3IgeW91ciBy
ZXZpZXchIEknbGwgZml4IGl0Lg0KDQo+ID4gK2EgYmluYXJ5IGJlZm9yZSB0aGUgZHJpdmVyIHJ1
bnMgYnkgdXNpbmcgdGhlIGZvbGxvd2luZyBzY3JpcHQ6DQo+ID4gKw0KPiANCj4gUGxlYXNlIGFk
ZCB0aGUgbG9jYXRpb24gaW5mbyB3aGVyZSB0aGUgZmlybXdhcmUgaGFzIHRvIGJlIHBsYWNlZC4N
Cg0KSSBnb3QgaXQuDQoNCj4gQWxzbywgYWRkIHRoaXMgZmlsZSB0byB0aGUgIlBDSSBEUklWRVIg
Rk9SIFJFTkVTQVMgUi1DQVIiIE1BSU5UQUlORVJTIGVudHJ5Lg0KDQpJJ2xsIGFkZCBpdC4NCg0K
QmVzdCByZWdhcmRzLA0KWW9zaGloaXJvIFNoaW1vZGENCg0KDQo+IC0gTWFuaQ0KPiANCj4gLS0N
Cj4g4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCvjQ0K

