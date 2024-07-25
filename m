Return-Path: <linux-pci+bounces-10748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B272A93BADB
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 04:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 653C6283D1C
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 02:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DF813FF9;
	Thu, 25 Jul 2024 02:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fee/SN7i"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED331103;
	Thu, 25 Jul 2024 02:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721874777; cv=fail; b=nelry4a6QWoitKFdKiiGXMb8uMTEPNiB64ltQxhcl3V+0U1JaqhgmxUmcrE2M/7DPZ5cJZBvmLwVkClNd6vMGhlPcFK6/pfbGb67qWpxAvvB7gyKcVsWxzRj4GQXWVuV3XqUBx6yu8kswnZLOI7XGKkUiXvu8RYbuQzzRNEP1wE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721874777; c=relaxed/simple;
	bh=21qWiQ60Sl3HaB4VIwHmTGINvLyEQGQf555F1Y5R77E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OlsXZylolzhQA26Xj+cXYVUhc0lSZH4u+8aSc9set7Zp34yneL6vuxpFLKx74cQmw77jv2lxlDdEIoV1kF9SvRlnNNUpEDHAR0w6aqPxebiTkXxNzXwBbYTv2YZunoHJ94knaws3sRjRmjpbudpSjnrqdU+UglxWqSxdKVCqWFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fee/SN7i; arc=fail smtp.client-ip=40.107.20.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVE+uzmwNe9djT950xMngpYlSekW8pF2X2v5iFnXUEzLHhcEYoMK3zix/faSp9jD7+9YT4Dq7LDSyORzqHUTwPqLkjuNhDAM6W4o7mjbyVLmKredtydUzkU2Ebf0zP5C1wD8nVet8jE5Bwcl7yf+XwHCF7uMpo8a7XBuYet8E2JKQsTlqUbTlCis61aTCogcidZLJSw1P0Upi8HxJdugSkZovMnBIkAd0T4d2HmsYRaU4hijlQISXOODbcfvOgpqEVP+6Rubinvv1R/LaU0z1S4A5pJiW7qXZ1o4xHEMYr69yo8v+vK8pUwYaUR780aGW+eXVp34oaSOGxPfj0Kryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21qWiQ60Sl3HaB4VIwHmTGINvLyEQGQf555F1Y5R77E=;
 b=vjtTbJh/5qduYPiXpJvXe90R0YID9dZ1EsMFq8rSLJHSM/PxfRgGTKG4yTdJiN/JWiC+dDT3oIYcz5q1tIwa4LlQfD+k8sfO11XmhclnSixgGfwIMeNpVqcaplQbbrBxwhIXVJPCVSwvpDJBG9oxZlLIBL54HNl589q6bL6cmqTarfa4Nop4FLolhRsV0I0chRcuZPVxBqKjW5neygIgPeUC200lNg/tVmLmkDumWg2qZFKcNncHi1rdQrKURV557HjeX7aL5xSmAUFX+WkSL5f66RfPgmkscx6lFr4ZHHdh0vSZS6RFI6ZBknoUlUQIhtNMThmqc23F/02maNkBhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21qWiQ60Sl3HaB4VIwHmTGINvLyEQGQf555F1Y5R77E=;
 b=Fee/SN7iSgcdMC+s0wJTNWMDAWWIVN3saxZqI+hkU4XovzHhpWYAyQw4IhTFGq9FtoeujSwldRv6vMSEJcdbTlNiCx9J+EA5i9Oc07Ic0ybIv8CfTMBsxV7ZBqq72pQ0XWmAOgT4bmBhCmJsprTdVdhF7yEF8FHeCQmWNc/xAJXYuX04B0uZcuyXwvLu9p1FkLD3itaHTYThQYuIsql5xV9WvNlTgWAZhDpvq+XTpU0RuBoywcqbrL39cj622hvjBLO4EVxixE/odtpscfWFx7TxnGYKVX+uc7lZF4KLZO03rvB7uP5rDZtIhEQpkOiXct0d+9XLoYw6KesN4g88EQ==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS5PR04MB9732.eurprd04.prod.outlook.com (2603:10a6:20b:672::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 02:32:52 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 02:32:52 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Conor Dooley <conor@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v2 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and
 "atu" for i.MX8M PCIe Endpoint
Thread-Topic: [PATCH v2 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and
 "atu" for i.MX8M PCIe Endpoint
Thread-Index: AQHa3XjKPyuG93K/lkCq2rFQl2xS+rIFZFSAgAADLtCAAAQVAIAApTMAgACmL1A=
Date: Thu, 25 Jul 2024 02:32:52 +0000
Message-ID:
 <AS8PR04MB8676F56B927930D509C44FDD8CAB2@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1721790236-3966-1-git-send-email-hongxing.zhu@nxp.com>
 <1721790236-3966-2-git-send-email-hongxing.zhu@nxp.com>
 <dbcd776b-172a-4c53-b33a-3215f7dcfe77@kernel.org>
 <AS8PR04MB8676B0F1385BE39D209DFB698CAA2@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <c9efb8a4-ca08-4e4a-97c6-de03ecea2955@kernel.org>
 <20240724-among-citric-cb3084658ae5@spud>
In-Reply-To: <20240724-among-citric-cb3084658ae5@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AS5PR04MB9732:EE_
x-ms-office365-filtering-correlation-id: 740db009-9c32-4ba1-1300-08dcac521541
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TVBtZU5NTkZsZmozVm5ieHVxU0c1eTFrd3BRTHluYlJMdnNxd0tMcFNGV2lD?=
 =?utf-8?B?a3lXYjBKN2V5TW1sbGJ6bHpMZUZNL1ZhM2dvbmlwS05IaGljWGZubEFIemtY?=
 =?utf-8?B?K2pnNkxDZ1Y0Smh1bXVyeEY3eHlhQ25NQlFiMEtua0w4TXJCNVN3YkNWZEpI?=
 =?utf-8?B?SXhXdGJ3aTlYb0JLUzVreVhYazFiWjA2Y3g5ak84dWZScUxrQXF3Z3U5alpC?=
 =?utf-8?B?cklRTU1hUXQzREJnWWxrZUxJU2VwRDFZSmpqV1JzM0JJUlFwUjJubzlxNG1u?=
 =?utf-8?B?a2FzcVhZWU5CbHRpdHE5SndGc2pnU2hoSEZwaUVyeW1kT0w5MDN4TmdlUExO?=
 =?utf-8?B?aWxCYjFyc1NHc2p5Q3VSbnZKQ1ZrdGpMWnltb3ZSZTBwZmlzZkZPOURRbSt0?=
 =?utf-8?B?Mmk1aHEzTmhWSkFhUHBUL21QWnFkT25RTEhsMlZrVDNnenA0aitKYld2L3JC?=
 =?utf-8?B?Si8vYlFoRWdyeko5aXFLb21MM3BsSHE2b1kydW54Ritmd0x6QVlTTnVVNzhC?=
 =?utf-8?B?cjdBUlRnOXlTZ203R2kzOG1DY2l0TWxXK3A1WVFYS3FVeHZlOUVvc1AyZjl0?=
 =?utf-8?B?K1liQXVyYTJBdWV4cHRCUzJQN1hBQXBiY3VBMiszZjRpVHpOSFFiTzZLQ3pp?=
 =?utf-8?B?SUtYVzJCenN1alRKQTBQK3QwRVIzY3dlWndoTDNuQWltdG1pWWdBZVlqUGUv?=
 =?utf-8?B?SDdjcTVsQ1lBbVZJZG5VczJlUHZtejEwSGZsbWZFeUlJSjhhamV3WlJCTUY3?=
 =?utf-8?B?Zkk1cmJ0c0hjdDNBQnlqZ2wyNGRyd0RZT1crUHZMaHVHMDJGWTdDZlNUTUky?=
 =?utf-8?B?VkZJNlFJNnRJQ3FEbVpZNnVPZGQ0UFo3OXVhVjcyWkhiVEpFU3lzWElHMFN6?=
 =?utf-8?B?QjNSQ3lyVDdYZnBlbG5ZMVZ2NmN6RENnVEcvb0pYTTdjLzZ4SzllRW1SK1ln?=
 =?utf-8?B?TzdpQXUwTXBXSUJ3V0VaWFNQOWVpZUhONm9reVQrYytCc1V2bUtmNUk0SmNt?=
 =?utf-8?B?U08vNUJxOEUvaVFxbG9tZE1XQUdEc1lhRUxQVUxFZklkNWxudkZKQjRKdmhi?=
 =?utf-8?B?ejhJc0hCUmlIcEVwd1NnSnV2MFE5anppT3RjdG15Unl0MjloOS9xUU9BUDht?=
 =?utf-8?B?YmpsdGFaWFNxWjVvQ1d0cXl4RmZHdGtiNDhLbEtCVjY4UnBBYTBqcHVkck1j?=
 =?utf-8?B?QTBFV2J0cGg5WHJXZkpUU0ZyTDJNRm9iMDk4NzZoeW5tTlkzUUZxOUFNMjV2?=
 =?utf-8?B?ZkxjbXQvUkVaODNiVjYrcGR3RnBlbzM5cDZlRDNvcHVab3VwZk1Ia1piZ1NU?=
 =?utf-8?B?UU5TSmFkU2NZWDRTNUVieG9wZDZPNG5qdk4zRFMxcm0veFZLNWROR3NManpP?=
 =?utf-8?B?YURvMXg5aTkyZmdnd2pZR3IrdGdLRnFOVWtXVmJGZ3lFT3BGVFpvRVhEbWo3?=
 =?utf-8?B?TFdOMkwxbUUyUmljUkwwcC90dzE4OGlhNkZVa3B3Rk10aElldjh0dlVwVStP?=
 =?utf-8?B?SXY4QmhEbExuN3B5S0pPUjl4SjFQb0xselg4WERLeEQrUG5yYS9qMUxOY3Vq?=
 =?utf-8?B?Qy9vMmIvWHFKWmZGUFpNZGFSMnR4dm1ITGVzZEJIbUhXdlVQN3VEQVdxK2dj?=
 =?utf-8?B?cUJhNy9lNndtbW5PVHhXYml3V05xWlk4WFlkckZtT3ZjaCsybVdhRGxHT3FP?=
 =?utf-8?B?Z3VWTWx0VlRLUlJMWFpjcFhWc3E5TlNKemkyZ0J2NFhPYjd5Y29XVWlOUXdD?=
 =?utf-8?B?ejFMNlhQUDYzUDZKeEFkUmVGVVJTNXV3d1NNaXhwYU9IcTRaZmxFUTR3NEZs?=
 =?utf-8?B?bDNBYldQZzk0T2YrMXpYcExSY1hkZVR1SjFDZUxoOUpIWTBaek04aXAvWHZm?=
 =?utf-8?B?VHVNdTVVYlcvTE9QbHFrc1Q2SDU0VnMvRnJ5dkpYMWNiUmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YTl4bEo0OVN3WXlDWHBqd0o4V1l3d21FOTYrRVJaN29MNlMrQWpvSFcxVHZv?=
 =?utf-8?B?YXZjZ2UyVUw4MVNhMVF3NWp1VGQrQkRJckRqMzRaeHAyclNTaXJ0NUdab0gr?=
 =?utf-8?B?cHUwb1JwbnVQWnhaaFF1Mm92WVVOd3hGY1NPZkJySzBYR1g4QThpeWVRaFVr?=
 =?utf-8?B?aFR1Q0tBK0lkVXZDRytrRFNkby83amEreFZ1ZXJPRXl3d2lmWkxVcWdoT3cy?=
 =?utf-8?B?WmVYYXl4T2ZJb3U3UVFSbGp0ZkV6UmY0TTlILytRYW9ocTQyRXB2RVlvR1NK?=
 =?utf-8?B?UC9nQXNyTXV1NHpDakZES2hGRkw1RC85WnNJVnJrMnprYnFGazU3ZEp6bmNj?=
 =?utf-8?B?VmZVUnNNa2VubEtzT1lBZVhOQXlMZmNmM2lBVFZibllVejdNeVlwbEViSTRV?=
 =?utf-8?B?OTFSaGpKajN1NWdQQ2tRWCtreGhnMWRZVExBWmFQRE1uTFJVZHlTd1hWMmxs?=
 =?utf-8?B?NDhtbDlCaVZTOTFPNVhYaGVxdStIMzdGV3U5ZFpsVERwcDZWTDhPMlVEaG9X?=
 =?utf-8?B?dEpSZlZoS0lVbi9JL21qQkpqSmtvTHpPUUpBUWthNUM3ZWIwaW5pYTE2Nkpy?=
 =?utf-8?B?YlpTajJCeGhOTTZMRmJlVmJMVzFJamhPMEVSbGtjcTdYTUdwcFdHR1hSNDFF?=
 =?utf-8?B?SUhCQlNiSW9oMjRaTTFwZTluRU1pRWgzcWRKM0RVbW5jbTNSUEsrVWZIVysv?=
 =?utf-8?B?MCtSZGxnaUZGdUZCbDRuTGpReVpOcVlvQnhRbkVIMTF4dWIvQ1V0N00wWnUw?=
 =?utf-8?B?TW5hSVgxb1VNTHluTkM3N0orK2hQRjlIT1lPeDBnVUk3REF2RTJHdkpteFRY?=
 =?utf-8?B?UGQ3QnF2bnlJQlVUbUQyZU1neGpZaTdaeVdYM3g0ME11WGc5YkI0cmdTRyt0?=
 =?utf-8?B?K3lZakxBS2ZqOXV6VUVzQ2lBaVJSOEFhbU1vLzdISm5tTlVQUGlVK0xJL2Vt?=
 =?utf-8?B?RWpNbmNUazZsb1BSMlJXbnZFQzYrNDNOQXV4eGJmSXRLOUNyZzYveDNJTERi?=
 =?utf-8?B?djlMRFhXVVV3TjMvY0NEVHh5QnR6SE9BZUp3QlRhOXZ5K2g5OXpscGNzZlF4?=
 =?utf-8?B?N3FuOXpoSnlkTnBvV0U5Uy9TY1dwQWZvSHNOeGlUWG92Y2dwcCt5ZUtiYjIr?=
 =?utf-8?B?UEluTzN6WnY4S1RWcXlIVDM5Y3dwRU10M0U4UHZKamFSRWZvWXg4aEY2NEo4?=
 =?utf-8?B?NFFyZWZiQnVEQWVHSEdLVXNkN2kxZGR2UzFHRVcyS3ZkWlg2b2l2VEc2WmRV?=
 =?utf-8?B?UnFKbW51T05ZRHJpdFMyQk5OYXgvTXVvTHZZWmdOQnQ5ZEV5cEtwV1RPZFlF?=
 =?utf-8?B?NjVWMCtZL3A0akh2V0R4R2pYUGRPN2V6TXdZZFlOR2lZNGpReVRRQW5zWGVa?=
 =?utf-8?B?Y1J6U3pYejQrVytpdkJ4akREdmYzM3lVSkFuUUVpZUowTFNEeG9MWWZkL3F3?=
 =?utf-8?B?VVlXcThTelZQZ09HNnp1bTk2Q2hHRzV4S2YySzJubHA0UGpkdzY1UHpxdFV4?=
 =?utf-8?B?T29PM3NrNEdWcGgxNnZ4RTF2WkVwU2l2Mk80cVlwc1p4VDd1anpNSFZoakZz?=
 =?utf-8?B?RUlNUmhrK1pUNEVNUlNaUVB2UUx3Sm5Zc0NlcXFBMWtRakRxQUpBWkJTZkxx?=
 =?utf-8?B?ZGppV2NPcWc2UHZDUFhtWEJVSkN2cWxJTnRXTUdzRTdJdmw5b0k4WHdsSXNT?=
 =?utf-8?B?TlVnVmRlUXpoTXVhUkdrMjlkTDR5SWtjYnk4Uk5ySFpuRGd3TGJZSUhMbXlS?=
 =?utf-8?B?K3A2NVZabDVKQjBzeGZZSjZHRDBNV2hLL1lGUkdzU0Y4Q1ZrT2s3Rjg1cjI1?=
 =?utf-8?B?dXhjNXd3ZUpaTzdaRUhST1NlYjhxVkkrT2RTSWJReFhLbjNxR2JnRDl6ZlJy?=
 =?utf-8?B?OHhBT0RTaERwOU40R3VMa3RVVGFuNWpENU12QmZmM05KQWNZMkkwNDVWdEFU?=
 =?utf-8?B?aTVWSFViZ3ZQQ1U5UUVsZVJxdUR0LzhnMWN2b1FmUjNBN05NZnRQVDlud21Z?=
 =?utf-8?B?eTVhTFErOG50NncrLzVtWSt2alQ1eGNVUERLWmJkQUlnNk9BK251TmxtbmZz?=
 =?utf-8?B?TUZQckloSG5Mc3h2T1JydkJ2dFdJaC95WllLUm0yWXFvM05Ia0RRc0FYMTUy?=
 =?utf-8?Q?ONYF/SVfMgl0zafx4WqEKWNq8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740db009-9c32-4ba1-1300-08dcac521541
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 02:32:52.3380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KmdH0CWXhrtuV2I47EMBDNf083vzCxmB7NtxO5SmTzVeetOkI57GqbCB18+gSnr2e45mpugRavo5qjTihjlt/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9732

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDb25vciBEb29sZXkgPGNvbm9y
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjTlubQ35pyIMjXml6UgMDoyNA0KPiBUbzogS3J6eXN6
dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBDYzogSG9uZ3hpbmcgWmh1IDxob25n
eGluZy56aHVAbnhwLmNvbT47IHJvYmhAa2VybmVsLm9yZzsNCj4ga3J6aytkdEBrZXJuZWwub3Jn
OyBjb25vcitkdEBrZXJuZWwub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBsLnN0YWNoQHBl
bmd1dHJvbml4LmRlOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtcGNpQHZnZXIu
a2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGlteEBs
aXN0cy5saW51eC5kZXYNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzRdIGR0LWJpbmRpbmdz
OiBpbXg2cS1wY2llOiBBZGQgcmVnLW5hbWUgImRiaTIiIGFuZA0KPiAiYXR1IiBmb3IgaS5NWDhN
IFBDSWUgRW5kcG9pbnQNCj4gDQo+IE9uIFdlZCwgSnVsIDI0LCAyMDI0IGF0IDA4OjMyOjM0QU0g
KzAyMDAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ID4gT24gMjQvMDcvMjAyNCAwODoy
NiwgSG9uZ3hpbmcgWmh1IHdyb3RlOg0KPiA+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4gPj4gRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiA+
ID4+IFNlbnQ6IDIwMjTlubQ35pyIMjTml6UgMTQ6MDcNCj4gPiA+PiBUbzogSG9uZ3hpbmcgWmh1
IDxob25neGluZy56aHVAbnhwLmNvbT47IHJvYmhAa2VybmVsLm9yZzsNCj4gPiA+PiBrcnprK2R0
QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+
ID4gPj4gbC5zdGFjaEBwZW5ndXRyb25peC5kZQ0KPiA+ID4+IENjOiBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+PiBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
DQo+ID4gPj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBpbXhAbGlzdHMubGludXguZGV2DQo+ID4g
Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzRdIGR0LWJpbmRpbmdzOiBpbXg2cS1wY2llOiBB
ZGQgcmVnLW5hbWUNCj4gPiA+PiAiZGJpMiIgYW5kICJhdHUiIGZvciBpLk1YOE0gUENJZSBFbmRw
b2ludA0KPiA+ID4+DQo+ID4gPj4gT24gMjQvMDcvMjAyNCAwNTowMywgUmljaGFyZCBaaHUgd3Jv
dGU6DQo+ID4gPj4+IEFkZCByZWctbmFtZTogImRiaTIiLCAiYXR1IiBmb3IgaS5NWDhNIFBDSWUg
RW5kcG9pbnQuDQo+ID4gPj4NCj4gPiA+PiBUaGlzIHdlIHNlZSBpbiB0aGUgZGlmZi4gV2hhdCBJ
IGRvIG5vdCBzZWUgaXMgd2h5PyBIYXJkd2FyZSBjaGFuZ2VkPyBIb3cNCj4gY29tZT8NCj4gPiA+
Pg0KPiA+ID4gRm9yIGkuTVg4TSBQQ0llIEVQLCB0aGUgZGJpMiBhbmQgYXR1IGFkZHJlc3MgYXJl
IHByZS1kZWZpbmVkIGluIHRoZSBkcml2ZXIuDQo+ID4gPiBUaGlzIG1ldGhvZCBpcyBub3QgZ29v
ZC4NCj4gPiA+IEluIGNvbW1pdCBiN2Q2N2M2MTMwZWUgKCJQQ0k6IGlteDY6IEFkZCBpTVg5NSBF
bmRwb2ludCAoRVApDQo+ID4gPiBzdXBwb3J0IiksIEZyYW5rIHN1Z2dlc3RzIHRvIGZldGNoIHRo
ZSBkYmkyIGFuZCBhdHUgZnJvbSBEVCBkaXJlY3RseS4NCj4gPiA+IFRoaXMgc2VyaWVzIGlzIHBy
ZXBhcmF0aW9uIHRvIGRvIHRoYXQgZm9yIGkuTVg4TSBQQ0llIEVQLg0KPiA+DQo+ID4gVGhpcyBh
bGwgbXVzdCBiZSBleHBsYWluZWQgaW4gY29tbWl0IG1zZy4NCj4gPg0KPiA+IEFueXdheSwgdGhp
cyB3aWxsIGJlIGFuIEFCSSBicmVhaywgc28gZXhwbGFpbiBleGFjdGx5IHdoeSBpdCBpcyBPSyB0
bw0KPiA+IGJyZWFrIHRoZSBBQkkuDQo+IA0KPiBBbmQgdGhlIGRyaXZlciBuZWVkcyB0byBiZSB3
cml0dGVuIGluIHN1Y2ggYSB3YXkgdGhhdCBpZiBvbmx5IHR3byByZWcgcHJvcGVydGllcyBhcmUN
Cj4gcHJvdmlkZWQsIGl0IGZhbGxzIGJhY2sgdG8gdGhlIG9sZCBtZXRob2Qgb2YgYWNxdWlyaW5n
IHRoZSB0d28gbmV3IHJlZyByZWdpb25zLiBJDQo+IGRpZG4ndCBzZWUgYSBkcml2ZXIgcGF0Y2gg
b24gdjEsIHNvIEkgbWlzc2VkIHRoYXQgdGhpcyBpcyB3aGF0IHdhcyBhY3R1YWxseSB0aGUgcGxh
biAtIEkNCj4gdGhvdWdodCB0aGF0IHRoaXMgd2FzIGp1c3QgYWRkaW5nIHR3byBtaXNzaW5nIHJl
Z2lvbnMuDQpIaSBDb3JuZXI6DQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMuDQpZZXMsIHRoZSBj
dXJyZW50IGRyaXZlciBqdXN0IHVzZXMgdGhpcyB3YXkgdG8gaGFuZGxlIGRiaTIgYW5kIGF0dSBi
YXNlDQogYWRkcmVzcyBhc3NpZ25tZW50cy4NCklmIG9ubHkgdHdvIHJlZyBwcm9wZXJ0aWVzIGFy
ZSBwcm92aWRlZCwgZHJpdmVyIHdvdWxkIGZhbGxzIGJhY2sgdG8gdGhlDQogb2xkIG1ldGhvZC4N
Cg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo=

