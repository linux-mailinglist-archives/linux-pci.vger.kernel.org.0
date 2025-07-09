Return-Path: <linux-pci+bounces-31751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4196BAFDF03
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 07:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 783C0166D93
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 05:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8647A22D4DD;
	Wed,  9 Jul 2025 05:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="jcstiYaX"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011007.outbound.protection.outlook.com [40.107.74.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C372AD22;
	Wed,  9 Jul 2025 05:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752037554; cv=fail; b=goNOe+4pskN1k4VK9gOg88T5AgdzJ09BDX1d+FcHNnRD/TfCyW2mX8FJdX86x8SxN+th2CtPwoWB7L3hv2sR9XOKJ/+CgmbrIrMOCXjHCp8Uz5HklnBOUxlonDy8AYOCfC1XVUx85FbzV5c4dnkpr6o2l9MP9dbf1WmjJa3nHx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752037554; c=relaxed/simple;
	bh=v1MSLGD5ViIgTD+Ev79mMZNlXRobPrkGX7NNN0xcmdE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AHYzM/+JFi1D5Yi66KsYcIX3MaEKs4GlUvA25/cIjb+gGLnCqcBH8h8wBlI5+Pg76mXepr7oEA3HKc9J2tfUG49QlR8NWbj0BkoqXT62X0Oaho0sBsim4/O1pAAMZ0sU1tBsMfA1tupy126u192Gr1ItMuHQ2L89dzXuACnMOfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=jcstiYaX; arc=fail smtp.client-ip=40.107.74.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgOUpwKCGb69N9GzKwcypxJ1KAFxQoZ3VrnNzS7gGsz5mP93XORTjtZH0jpNfPvsO0BViOXmNOhmBC2D41CGhlRd6S9VFB0YVtg796Gwz6ClzXydibKdXZ/gvpfXO+mCFr1BHlC2B4pQAgcqip4cgT0sNo/sstcO/Z4IsvlLBuDZL7OJDR7jbjaURl5jRVCx6/OVVN08l6S0qF/85ERAk3f4CQinJmlfbOFg5qo4F1bh5U80ouTwZqS9nF3dEA846JpbuHPhWJyDQXqAyVLiwmyTxeShdqi6UHOMj7GButYMZPY9Mq6mj1x00iGyFm37b0w5iM1/okFntPgIhzYIow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1MSLGD5ViIgTD+Ev79mMZNlXRobPrkGX7NNN0xcmdE=;
 b=WMpfmsVzDRBvebutH8jqVXNVaTn7uKI/mRDK4Zj9bfYzLW1W+PDNPtjJRZGowgXGeLgVo4XcP2vSBR1RrACAOOiDFMa/YjFQsMR9HEIovJB0HOQUlAO5o/SfP2Y4XTkq/GwMeD0zSgRu+7ffIYqyUj56sDVVSlLQEMhRuuFjSyXvx442qSJJWb751Ga+o/6M/mNjFwvxOxVp7IVPf02BCv8UjgU8/LREQuVfe/eS0zDUlwwpSrP3ZG8NcvQmOXe/20BAYuYiadcdjeAAe2U4ED8jgQP4Qr7I1P90q9J3C+Ofgqa4ZxidTuTx8vcHDnMeVIGLOhqDHH2L1TODg8MOcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1MSLGD5ViIgTD+Ev79mMZNlXRobPrkGX7NNN0xcmdE=;
 b=jcstiYaXpxvk0cOa/DHE/sRDBg+xnlLikVe+7zVx8CfTvEOHRlQ2wW+EDoabtfKOJF8UEaJfohZckjfX8Jofl3IPSKOszp1dllcI+EH6ccmGvWpkWF5KH8WLUMMAv6NWV84DKWJOfdxvX2xaJUDONsEFvVF1FK2oxMDOz42RfhQ=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSRPR01MB11598.jpnprd01.prod.outlook.com (2603:1096:604:22c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 05:05:44 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%3]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 05:05:44 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>, "magnus.damm@gmail.com"
	<magnus.damm@gmail.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "lizhi.hou@amd.com"
	<lizhi.hou@amd.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>
Subject: RE: [PATCH v3 7/9] arm64: dts: renesas: rzg3s-smarc-som: Update
 dma-ranges for PCIe
Thread-Topic: [PATCH v3 7/9] arm64: dts: renesas: rzg3s-smarc-som: Update
 dma-ranges for PCIe
Thread-Index: AQHb7P8PBMpfnLgFvkWQvju7tLKMl7QmU8ewgAGzIoCAATrXgA==
Date: Wed, 9 Jul 2025 05:05:44 +0000
Message-ID:
 <TY3PR01MB113467C09DF7D3D0D7833A6598649A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250704161410.3931884-1-claudiu.beznea.uj@bp.renesas.com>
 <20250704161410.3931884-8-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB113464920ECAC2C3CB89DE2D5864FA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <7c8c7a25-c373-452a-9fe8-8b2d92ddd885@tuxon.dev>
In-Reply-To: <7c8c7a25-c373-452a-9fe8-8b2d92ddd885@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSRPR01MB11598:EE_
x-ms-office365-filtering-correlation-id: cca0d5cf-7dc1-404d-bc82-08ddbea64239
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S1A1Ui83MjJ0ZDNBNjBJYTFCOUtIcjBJaXdWakt0eDlNbUNLbXFRTVorcHNU?=
 =?utf-8?B?YmlLTlBpa21wNnQvR0VNOUlibnN3bTJmdzkzdk9ocXFRTlJwc1lDZU82azZp?=
 =?utf-8?B?MHdJYmNScmRsZFdWQW1WeTdjWVQrZThDZEV4UUp1ZTdUMHpGRE9vOFhGOTNk?=
 =?utf-8?B?OWE1c0xPZHg5eGJBS0xJMHJYRXFhVnJIV3YreVhZWlMwbjZnVGVERlo5c1U4?=
 =?utf-8?B?NjJzMzB2NnVLakJNZWlyU1FwR3czbUxmL0N4SDJzKzN2V2V3bnhYZ3BrUHcz?=
 =?utf-8?B?UHhZRmpDc1NNS0xrcEpLWFV6bnhUTFFOVjhFWDhmbU5CdnZxb3J4WDV0MXFu?=
 =?utf-8?B?RXNYcGxpTTF1NVY5azRaM0xzUXJhc3VIN3lqMWNqSVhORllEWVZmRi9LaExn?=
 =?utf-8?B?ZXZqNzJKOWhubmVvY0VJWXhXQzNXdWdNbU16a3hVMHZuZ1dNNlpYdXpHMCt1?=
 =?utf-8?B?ZFN6QmE4YU1wajZXZ3orL2xFdXg4N1c1UkRBVERBUHdOWUVEQks4OUllY0NX?=
 =?utf-8?B?UlRRMExwWkQ4VFRKK2NtNzgxTEUzWDJXb2Nad01CL1Jnd2U3dnl5ZlZaVTN2?=
 =?utf-8?B?cUZDWlVhOXBRbWdPaTNJeEM1Ky8wN3pJcUpUOHh6QzkwbmQ5NmFqVzhLMzVC?=
 =?utf-8?B?Ynl6TWU2Q0hQOGtLQ1RQT0YySjJRVzVQako2UnhxZXNjSGJVOEtVeFZpa1pa?=
 =?utf-8?B?Vi9aMXBwTzVEQUhSeU5PS0RFQlhpc2NDNnAvMXJlWGtmeVlMdVlzZkxPbm9j?=
 =?utf-8?B?VjY3RzljY2dKWkhZd0JRVG5DdWtpT1NpUUFFdWhPN0tCRGNtUjh5VGNQMWE1?=
 =?utf-8?B?NS85bzQ0R2ltS0ZJUktDWHdJNnh6Ykp2SkUzbDZUb3ZQN1ZqM2c4dmJqc3FQ?=
 =?utf-8?B?eFVaSTZNaXY1cGJVNytiRXlYdFljNUFWRGJyblhxc2tPTVBUVXpFaGRDQnBu?=
 =?utf-8?B?TTFRVG92RWtKb04yTTlRNk9FSFBtdmozblcrSDNmeFRUTUxyc29zMnVqQkR1?=
 =?utf-8?B?OEdRejFSVFJtYlVqNjc1dnhRbTV2d1RqZE83Mk5UbjJFRGFJcG1RR2djKytn?=
 =?utf-8?B?ZHBLUStIZ3dMR0xDVUZOMitGbVR4T1BIUzdTeklYK2dTTlg0UUlRUzhlTlFE?=
 =?utf-8?B?b1pLTWdxWVhTS1VCZzZzSlk4NWlqT3p1YmRrdmlsaTJEbEVQZDh6NkduRC8w?=
 =?utf-8?B?cXU3MXU3MlgrVnNkaktBYXFONHNFQ1UzYkU5TTU2T0pVNEZIZmlzUFpXQWJL?=
 =?utf-8?B?VEJtKzU0VW41VEs0amtzVGtqaERJTS9lRFBsUk9lVWx4dTVGVGRPOTdRQ1lr?=
 =?utf-8?B?azlMUUN2RWtpV3NsNFpZOVBjcDBNeUFMeGdYSnVDc0VScHRoYWh1WnJxRGlD?=
 =?utf-8?B?UTdxS1VxZmZMNXE3OFVyUm0xSlVUUk1Day9CTXdOcTR2bWJyNEFic1dMdmxj?=
 =?utf-8?B?T2hkOUJBWWFZLzNpZHhLSXFMYXc3ZHREQ2pCS29yaDJacXpZVm9RUHJZUlFm?=
 =?utf-8?B?VUJkbVRaS1BQTFAydWtYNi8rRC9wc0FyQnJoSXU2cGM4UWdjVzR6dDJXL3hJ?=
 =?utf-8?B?eFNyMFlCVytmdVFvNDlidnpDZG5PNC9rRkxxU1lmb0V0R0hQOGVQcWV3cjgw?=
 =?utf-8?B?d01YeDV1QlpwSXJMMFNkWEM2dnJabnltc3d4REFXWG03bVdnYmpZQVhnYklx?=
 =?utf-8?B?RWtSaHVDQUFsckt4czdIbHB1eGJHWE1senYzdEhHbFdncXdNQzZGYzYvc3R0?=
 =?utf-8?B?VEltRllDYzN0TS9WcnBQL1dYSURvY21IZjR2YTM4YkRsYnpicW01Z25ldlhO?=
 =?utf-8?B?S2o0UDJiZG0xcEJQejJZRlRQRTZEN1hTeTNIZ2g1V0R5SVNEbDFrbVZ1VGVr?=
 =?utf-8?B?R0lOM0ZDV2RkaS9QWHkxb1F1d1ZQb0NqSTVaTnBrT1RPU3ozNUhsTE9ISmE4?=
 =?utf-8?Q?Rn38qRpVbOhL82t7CS9FlOJo18l1O1US?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SmlUbElINlhyekNzRVRIbjlyZThQYVY5NDUrWWY3enA5TDRHZ0EzSWpaQmhS?=
 =?utf-8?B?dzh0eU9SU3ZTZUhwL2ZwLzd1ay9pZ2M2YmtHbEJiWmRwbm43UmYzNzhMSXVv?=
 =?utf-8?B?QWl3cG9LZGRNdVBmOTZzLzU3dkhvcmQxeVJOV1FvNUVWKzRkNjN1S2xmSHlX?=
 =?utf-8?B?V2l5czczVkZ5OGhRT2Z5dU5MdDh5c1dCb3RpbXVsdi9XMzViQjZMa0hWZmZv?=
 =?utf-8?B?OGk0SUdqN1U3d2NPVW5zZzlZMWtKcldLZ2NNaGZVSDJPcEdUdDExMGdwemRK?=
 =?utf-8?B?d1Z5V2Uvb0hBQkRsYnJRNkNEdy8raDNyRzZpbVcvZHlMYWdQdkh2akZTODhJ?=
 =?utf-8?B?YnNZd3l0dVNyMXFuTG1lMUo3dlhiL2FzRVdobXJpQ3hrQmhGbi9FN3ZybzVj?=
 =?utf-8?B?eHNUOFBFeHhSZmdBSUQ3T0gxeWZ6MDl5M1NqRy8yNkp6S2x6TmJVeFgyZUpp?=
 =?utf-8?B?TTZqWEhFWkJEYXF6TTd5Qy9DQXJRa0xDYkVOSUQxeFM2aUZUM3dhaXExNkVx?=
 =?utf-8?B?S1NWaFdyeFBXVmRvS3JUKy9WYmN5RElOUmlqOWQvTTV6T0p3bXR1a3AzNHBK?=
 =?utf-8?B?YVFpSExpN3U1cFI0T0VDa3Q2RUNmZmZnNmkvdGUyM05BRWVyTVNYdU1FNHRT?=
 =?utf-8?B?em9nZGRlbjNrY3pUOE5JMUhORGRwYzFkR1AzaVR3MW9XNkhzSUFGd1NyWUVY?=
 =?utf-8?B?MW0rM0Z3ZHdjKzRNNVlWT0N1RWo5dXpjdGtGWHVBS1ZnWDRKdFpocmRIRGFa?=
 =?utf-8?B?a05SRDkxeUpycmxpUmlaeFEweXY5ME1tVnRGMUZBRnZnS3N2amRqc1VaYXU5?=
 =?utf-8?B?ZGdXd3Y0MDM3UUhxWUpUQm5NTlFaYWE1SnF5SWxoTXljVFYzT0IwcTFESWRC?=
 =?utf-8?B?YW5kUVZMSGVyd2JrUU5qck0rK3NpQ3daK2xXL204WmdEVGJtYjJETWUxeitW?=
 =?utf-8?B?OXcrb3dISTgrVms0RE9sdmJLNHZ4YVE5Z3pqdXRad2NRTlpQZUVNK3FYanFZ?=
 =?utf-8?B?emJ1S3JMTXMrb3JZcGdjaWplNi9tQklVdG1XcklmZVhUOUE1WWZaZlg0ZTNq?=
 =?utf-8?B?MHYwM2oxcjZsM2NCdG1Bc0JnWVVNQVdZZFVzK3ZvSHJ3RS82VWEyOGliQmhM?=
 =?utf-8?B?UEg3TzhDNnIyTlYrU1djVVdYOVgzdlRUQ2hmN042ZkR0WkwyaWM2WUEwQmxY?=
 =?utf-8?B?Q3l4NG5qamh5RjlHWXp6R2RYd1Rrdm53OTFiWlZjZWw5WVRuaDVBZ0Q5WTNQ?=
 =?utf-8?B?dmttREJtTlRaVkNXaDMvVTBNcmtkUmhKMFB5R0JJK2FMQ21jbnFnSEZVc0oy?=
 =?utf-8?B?NDcxZVY0NU5SRkMwVTQ0TmhaZm1mbHJZVnhXcXRiZkx0Ri9jc29CNTZJeHpD?=
 =?utf-8?B?ZTYxcFVZUDZJVzNkM2MrZ053TloycGYrZnVaRXBjbXpyWVFqUkpxeFhlM3dv?=
 =?utf-8?B?RlVJSVRGNW1sUWRuVm1rcjBrZEJ0REF5cE1VcDBzUzVoSlJwVHZNR0tQajlG?=
 =?utf-8?B?dUMvcVIxT3lZaVN0Ym1EcXJqbnhUSjV3c0N4UzhrL0dGQlZ4T0VhSjcxZWtN?=
 =?utf-8?B?dGMzbG1MMVlQWkR6RXEyMnl4R0pmMmZTMWxmWkowcDJ5dnhIMERrTmR5b2Jn?=
 =?utf-8?B?WERWWjVuMXFncVJjS2VPcnhCUXVMOUwxd2YrL015QkJkMk0xbHFBcmN3QVVu?=
 =?utf-8?B?Sm9sc1A5cW9CV21CNHdaeFZGNCtITS9Gai9ybytLeUErQlVSNkkvQ3lFQzd6?=
 =?utf-8?B?SFg2dUh6VG5pQXhNU1F1NklOa3J4bkJSOUNzb0xCMng5bDVaOVlYMFRFUWVj?=
 =?utf-8?B?VDFsSFEvR0YxQXFiVU93THRONU1tSVYxRkFIVnE3NmFTM0Zla2RJbVBsZXNv?=
 =?utf-8?B?NjZVOURLOFVCWjZ5Rmx6UVhlZ3VxdnF5Ykl3bVl3cmdFUE9tWk5mOWc5SmVC?=
 =?utf-8?B?Y3BTZkQrUHZZVnhHMjN6QUg3Q0NtR1lLMmtxa1ZhZWtGVlNJd3lTZVVYMll1?=
 =?utf-8?B?SDZIQjNhU3FJdEtkUDJEMERtVWNLN2FoZDkxckt6aU96ckwwaVkvRzNiOWlH?=
 =?utf-8?B?SmNObmd6Nm5pdDZHaXpRWU1ZNU0zaVZhUVV5S0Z5ckdydW1QT0RRc3lRV3Ix?=
 =?utf-8?B?RWlMajBldTJMVGRmbGZGdXN1aHBMR1RrSjBENktmR2lRenFqZWsvTGpvM1Zv?=
 =?utf-8?B?T3c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cca0d5cf-7dc1-404d-bc82-08ddbea64239
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 05:05:44.1019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +/Q6JT1c4UjlIfZDbQ8P5xVtainRqFVZaxX82y/2ejb2mtu0UmRrWsof8pVR9u07XkbNDkcUuUMyaiQfXSatEWWIduOlsHFTMibu0r8O4A4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11598

SGkgQ2xhdWRpdSBCZXpuZWEsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQHR1eG9uLmRldj4NCj4gU2VudDogMDgg
SnVseSAyMDI1IDExOjEwDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgNy85XSBhcm02NDogZHRz
OiByZW5lc2FzOiByemczcy1zbWFyYy1zb206IFVwZGF0ZSBkbWEtcmFuZ2VzIGZvciBQQ0llDQo+
IA0KPiBIaSwgQmlqdSwNCj4gDQo+IE9uIDA3LjA3LjIwMjUgMTE6MTgsIEJpanUgRGFzIHdyb3Rl
Og0KPiA+IEhpIENsYXVkaXUsDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPj4gRnJvbTogQ2xhdWRpdSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiA+PiBTZW50
OiAwNCBKdWx5IDIwMjUgMTc6MTQNCj4gPj4gU3ViamVjdDogW1BBVENIIHYzIDcvOV0gYXJtNjQ6
IGR0czogcmVuZXNhczogcnpnM3Mtc21hcmMtc29tOiBVcGRhdGUNCj4gPj4gZG1hLXJhbmdlcyBm
b3IgUENJZQ0KPiA+Pg0KPiA+PiBGcm9tOiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWEu
dWpAYnAucmVuZXNhcy5jb20+DQo+ID4+DQo+ID4+IFRoZSBmaXJzdCAxMjhNQiBvZiBtZW1vcnkg
aXMgcmVzZXJ2ZWQgb24gdGhpcyBib2FyZCBmb3Igc2VjdXJlIGFyZWEuDQo+ID4+IFVwZGF0ZSB0
aGUgUENJZSBkbWEtcmFuZ2VzIHByb3BlcnR5IHRvIHJlZmxlY3QgdGhpcy4NCj4gPg0KPiA+IEkg
c2VlIFItQ2FyIFBDSWUgZG1hLXJhbmdlc1sxXSBhbmQgWzJdIG1hcHMgYWxsIHBvc3NpYmxlIERE
UiBhcmVhIHN1cHBvcnRlZCBieSB0aGUgU29DPw0KPiA+IERvIHdlIG5lZWQgdG8gbWFrZSBib2Fy
ZCBzcGVjaWZpYyBhcyB3ZWxsIHRoZXJlPw0KPiANCj4gSSdtIG5vdCBmYW1pbGlhciB3aXRoIFIt
Q2FyLCBidXQgaWYgdGhlcmUgYXJlIHJhbmdlcyByZXNlcnZlZCBmb3Igb3RoZXIgcHVycG9zZXMs
IEkgdGhpbmsgd2Ugc2hvdWxkDQo+IHJlZmxlY3QgaXQgaW4gYm9hcmQgc3BlY2lmaWMgZGV2aWNl
IHRyZWVzLg0KDQoNCkFscmVhZHkgTGludXggaGFzIHRoaXMgRERSIGluZm9bMV0uIExpbnV4IHBy
b3ZpZGVzIERNQSBtZW1vcnkgb25seSBmcm9tIHRoaXMgcmVnaW9uLg0KDQpJbiB5b3VyIHRlc3Rp
bmcsIGhhdmUgeW91IGZhY2VkIGFueSBpc3N1ZSBsaWtlIHN5c3RlbSBhbGxvY2F0ZWQgRE1BIHJl
Z2lvbiBvdGhlciB0aGFuIFsxXQ0KYW5kIHlvdSBkb24ndCB3YW50IHRvIHVzZSBpdCwgdGhlbiB0
aGUgY2hhbmdlcyBhcmUgb2s/Pw0KDQpOb3Qgc3VyZSwgUENJZSBjYW4gd29yayBvbiBpbnRlcm5h
bCBtZW1vcnkgc3VjaCBhcyBTUkFNPw0KDQpbMV0NCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L25leHQvbGludXgtbmV4dC5naXQvdHJlZS9hcmNoL2FybTY0
L2Jvb3QvZHRzL3JlbmVzYXMvcnpnM3Mtc21hcmMtc29tLmR0c2k/aD1uZXh0LTIwMjUwNzA4I24z
MQ0KDQpDaGVlcnMsDQpCaWp1DQo=

