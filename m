Return-Path: <linux-pci+bounces-17017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6319D0807
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 04:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C599A1F21392
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 03:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556644437A;
	Mon, 18 Nov 2024 02:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F4b6mp2O"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559C341C71;
	Mon, 18 Nov 2024 02:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731898795; cv=fail; b=e2hIkUXSYwftp3fuGx+/7vKHq4Qh/nBpfHgGYUoRAke7/NLay45x4CHkG5+nUXkZgVvfR8H9nH3n4mW6c3WFfQKNH8dLsz4kmZxH1VJqW5ooOtTFuHKVtJOH7ZjkAq6Y4uCeEgJQMWh6gsWHOx49uqHO5ofX+XqOu0DZrL0YzGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731898795; c=relaxed/simple;
	bh=QXC6F9rWkUy1beWM5TTSbiZ77LjuDvmUoHj9ESfOMP4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DkVMNX4dSVb78ttShnFAiPorcYJ47pl6SlPSEvLe4NATGTWSJnXGbdSmJTyqDzLc7RMwmZeHEy3M51zz5Az80YHtIBDzcj2r4Yu1p2NIEAHft4FKijsN1ytdrU7kVA4QtzdrC3w6spZWG8dhaJqTMNSaJLGfLdNSLMvBZVNVFKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F4b6mp2O; arc=fail smtp.client-ip=40.107.21.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUKjmmQ9hyRWRWj9tU+AqVWfyoPS8W/C32Xnwt5ZcehfX8cV1IqAgycVjZjesrQymECNIggpKm+E8vEkBvVzvPa5J7K24OGR14XmyLYKQY7qpCYAvH5/gdSt3lowCrgyMZolHsX4x6DwqMQyYzztvHCNaZA9Tg2dfHHynnEbnBvyfWdGOJXnwiSc5j2H00VWpj/Z062ppAej3HmnYF9+IEyFy4Lqm38sXPciWOF2n+rxJu62ErAEyz2HZkacS7U3LO0+MWUIkDvR4tVOwJFR1Lsq9c14gPx7J7Ty6hB7QI4+GK3EsZhAjb6OCWQjQXlb7eNQ5hCoQ3m8SrPBbvJHXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXC6F9rWkUy1beWM5TTSbiZ77LjuDvmUoHj9ESfOMP4=;
 b=dE0bHGIaS0qDyp7LCSzAOi9pQQRpKcq2W1tMLiry5Y1MUaEaOEXpzfipNU8M9Mbyxbzy1fH9GDT/pXGHAh7zS6co5VMXkXWTd6T6csmwJdAY5W7YpLxvbWtlkzK2bSDmK/O34D1GzicW9zDZG1c9G8N7ydVkBykTR4AZuEP3P/hrMM9cQ91wGhHE6/dTan4y816TnAbG1aWlUJy1446XNL+dz0ZtqpTg6iA3va2tGKO45fb51wGYVH2QEB2qxYbuReP3jh0Q4dVtzykynNTDzbTfXLcIwxgt5xOToE9jJ1j9Io/Y6sg3TOebUgUbC75tEKtZXtoix8dQtQSBdkdLwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXC6F9rWkUy1beWM5TTSbiZ77LjuDvmUoHj9ESfOMP4=;
 b=F4b6mp2OPPRKt0NiKhOvDUWR4F5M3nqVawlEThqkvYAXas532yHJSh9kTZ0PVoWKeEcDw3/IBh3nm49VK+y5M1BoA70BOxZL27YDX4XoJCfFHHg9IwU45KCVgKKaaPXo/LAW8Iy+7rXRNhMM0pOAu769q5MPK9txe5HLPLxzg9Q6iHeiTDTmhTJiWq6uJPjWmt6vTFL9O3wAtHJO3MWDh0tlyM8jgmO03ff2hQCIhgrW+Ng9s68nPCQSBMMMUiYe/2m+9Lhxcdf1ub0WUCkltfu+mim0LPgEzYynK7uxYW+nwnxYiqp7t2nT+BaVQ8HPLfHaIjdXiLHYeZbpDVGqiA==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8673.eurprd04.prod.outlook.com (2603:10a6:20b:428::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 02:59:49 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 02:59:49 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, Frank Li
	<frank.li@nxp.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 04/10] PCI: imx6: Correct controller_id generation
 logic for i.MX7D
Thread-Topic: [PATCH v6 04/10] PCI: imx6: Correct controller_id generation
 logic for i.MX7D
Thread-Index: AQHbLCsv3WuW0hdrOE6fib5JRKECZLK3+vyAgALmGFA=
Date: Mon, 18 Nov 2024 02:59:48 +0000
Message-ID:
 <AS8PR04MB8676989276C723C26DADFB5D8C272@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
 <20241101070610.1267391-5-hongxing.zhu@nxp.com>
 <20241115064321.3cuqng7bzmphiomw@thinkpad>
In-Reply-To: <20241115064321.3cuqng7bzmphiomw@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AS8PR04MB8673:EE_
x-ms-office365-filtering-correlation-id: 196f0dc2-f909-478a-9ddf-08dd077d10c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d2NkeWFHaVhEdDRRYWdJUHBPa2YvKzFuMmx0Mld6MGhraE1KWG1GaVVQNUlL?=
 =?utf-8?B?VGFWV2pLYnBCK2ZxSTh3KyswMDJrcmJmWDhjL2xHbWxIb2ZIZnhoZkxPTS8v?=
 =?utf-8?B?MGIzMmpWK0M5L3FRM0w1dHJ6UXJ4NGxVYVAzeW8zdjBYM0RnVy9UdUk5NzFa?=
 =?utf-8?B?Nm5WK3p0U2FtRnhzZ3lGL05lUDc5MS9IWFNTNXB4ajVCMHlrOEptKzFXMXFL?=
 =?utf-8?B?ZXRYdEpsZEF0UmtUWjBEWFcxQ3JEblN5RWVVOXhsZ1pQU1ovSVVvQ0FZY2Vm?=
 =?utf-8?B?QXl6cnlUMGc1WTNZRWZYNExvelliZG5NTHJKVjNHZHFUSHRMTlAvTTFqSGp3?=
 =?utf-8?B?SWI1dVZIeVVUTTg2d1Y4cDNBb2t6T3Y2QW9YNFlxYWpIS0trbGlQek9Lb3N3?=
 =?utf-8?B?eVBxalpVSG54VXRUTHBqMkJGN05DSk5lMU40cmZoNVdFMklhSzc4blN1eDhD?=
 =?utf-8?B?am9iVEQrKzBtaFRQL0h4ZjVYL2Qwb0dIWXV3TExmd0Z0NVdPaE91ZGNkMWdK?=
 =?utf-8?B?UXhYYmhUUnBKR1JLdGhnMjVLcmZyVTl1cDNjaDdES09LKzF1a1pJejQ4MmZB?=
 =?utf-8?B?bFpJN0oxcEdMQ0orYWZmc01lK01yZ1V1YkJGdFVKL0JudEZnU1Q2MFBZa09J?=
 =?utf-8?B?N0ViWWRpVzdNL2l1Y2E0ODl5M2dhVnJJbXFBYS9PaStvcXZ6SnlaVlZaU3M0?=
 =?utf-8?B?SVdrREROUGRwZjhxb2F1WXNqdzNFSEF5LzZmbG1UODhmRkova1Bud0RzRkJ6?=
 =?utf-8?B?czFTRzVKT2RxNVJlUnZzTEh0U1lTQVpsdFQzelNtVkg0NjJwSHdLNVBodHRt?=
 =?utf-8?B?b0pYa0ZXOXVyd3QxL2grU1FNZkNUOU5VQXFqaE9qRW9RcU51MFlNaCtBWFMy?=
 =?utf-8?B?VmFDUWxQRjBwdnN4ejZyeHJCN2J4V1FRbU93YXNZQU01eWJFSS8xTy9tMURQ?=
 =?utf-8?B?dEFtSWFwdVd3c1U0YUd5d0t2dW52OVNLMTlKVHRwWWFBb25tcFZ3RVpGM2xv?=
 =?utf-8?B?aFhJbE1URHhGY3RKTTZwc1RaV2gzbUd2TkhsbnV6bThaenZkM3gyU041UlFT?=
 =?utf-8?B?QXNabW1JTXhxajQwY3ZiUUpoL0ZYeFJ3QkZKZjh0RWtJNG1SWmRVNG92dXlG?=
 =?utf-8?B?YU9qQmlRWTRwNC9UNXlqVHVZeVBXclp5cU5hSVg3UjMrR3BVUXFhbTVLV1Fa?=
 =?utf-8?B?VHJWNzJSYit4Z1pBZDdueVNENFBuYURUQkpiYUIxcjdXL1lnTGpoVHl4UFIx?=
 =?utf-8?B?L0tNNTV3N0lKUmIwNnZRTlpNNDRyQjJ2TkZvaXNiNlN1V3RkTm5GVTlUU2pW?=
 =?utf-8?B?bkMrdEYyYi80TjJRUTdlTVFNWFJIdjdDc3NYc3lWb1hNN3UyT0tGTVpmTXc2?=
 =?utf-8?B?VGJBRFNUUERwL21HaGdBa3NvZU5CVjRPVmpwQjl0S2N1djFjUnh2RE5QQ25o?=
 =?utf-8?B?Um9WUm5QVEs2VE9iWCtWVzNCRVZ6VlBsNlNRUFRmZ1RVUExlTkg0SUUyaEJv?=
 =?utf-8?B?ZldLUjRJc0hrMUYwbEovVUlneFV4N1BFVldoZmRsSGFkQlFaMW9lRWx6WXZo?=
 =?utf-8?B?dCtkcnA0MGd1R0d6N2RONllhUDlob0NFNi95Qyt3VnRtczZyS2FmU1BQdlpr?=
 =?utf-8?B?dXdXR1A1V2RzcFJGY1ZtYkREdXEvRHdtdEphZmEwTWpHRmtYTHVDK05jNmJ2?=
 =?utf-8?B?N0RXbmFGR0JLbmk0SkxiUnZpbENXbTRPMWdxOWZ2YUt5WHZwb1Z6MHR4dmNq?=
 =?utf-8?B?RmkrWGJHeitwQ0c4Vml2QytSUEhaZG96TXluN1VYQU9URnkvMmt0QUhDSGFD?=
 =?utf-8?Q?qAsTn0XKqCKB3ju/wh2lf6eH5DAk4UM+R4r24=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RW4xcGN2bWN6MXFGM3ZjU3MzdW4zZ0hHU1E5MGMrOWloMFpJNGRMeURaR2Jr?=
 =?utf-8?B?bzRLa1NPREszeXlFdW1iUyt5WHcya05JdHJ1VWJWbldXTlVWUzh0U2RlOW1D?=
 =?utf-8?B?Rk5DTE85Y1RlVHFGWnlDUU41NHBoQmlheVRScUdZY05qbFUxdkMxMjRMT3k2?=
 =?utf-8?B?eEtWaEVuaXdIUUV1NlZYTjROeFRyR0diRDU1NTNPUTlOa1ZlYWVMY0syNlZl?=
 =?utf-8?B?UDRveDQya0RvbnFzOHJ4YVFEd0JYdHVmZ3V5T3BMZ05YeGdqbk8zMXdXWTJa?=
 =?utf-8?B?SzVyZjhPSGpxeElBTkF4WTVnQnRsSDlETzc4SFdVNVpGV0lZb1U1OVRmT25j?=
 =?utf-8?B?ZHZ4S2F1M3A3UHNzaFI2SVVhbXhIVXZLVWc4OW9JZnJVMkJaWFI2RUdPWWh4?=
 =?utf-8?B?TTRIS2prL2p0WC9wZzYyMktXNUNhRCtEMXBINU8wM1NpUUVMaTE2aG9QY3ZH?=
 =?utf-8?B?YTk2Z0pQdGFLN3JLdGRhZElXS0M3S09qZXozTkhLUWVjQTgvcHFOTnQ3Ukl4?=
 =?utf-8?B?NlNXZzhDbmVMS3pDMG1IM0dNZVRjczBSeUgyUlVqQW1jSitUTlBOeVJERE9a?=
 =?utf-8?B?TnhvZEx4Z2xvZEtMMExEM1RjMUlMSWZnRDg2ZGk0MCtYd2h3RFVnMW5KSDN3?=
 =?utf-8?B?U1dRYkw5djFwNHRoUlpPTHBQWHBhME56clVFZDhRcXFETEFBTkoweDMxdUFi?=
 =?utf-8?B?QlhlVlNKdVF1WVphbmVBVDdkbUJzc1pNeG9uWkNVb0V0WFZ3cmRyT3EyK01t?=
 =?utf-8?B?Z2ptMXFQWGJTYVRTRkdFbm1tV21BUk5lRzNDbXVCMWR2Vzh2cUJkVTRJS3hs?=
 =?utf-8?B?MW4vc1pFNXhDVDJEMk5Qd1FhT1NScEhydHV1d0tDYkNqRC9OM1ZjMytHMUZQ?=
 =?utf-8?B?NXI2K1lmTWxHYVhDNFUwN2hWeEdNNVlZdlNNRGF1VHVJTjI0cVdtQzVLVHRW?=
 =?utf-8?B?QVpoeTg1NWVSUE5ieTB0S1E5MjBOS0hvSW1xRnlaQ2xaQXJtMTVrOC9jTFJO?=
 =?utf-8?B?KzRYWk5rK20yM2hxNWw5eTRmd1hEMkZzZGduQzBLWnhSL014bXpSZW9HYWVH?=
 =?utf-8?B?ekpUV3krMHptSnhUNC8yZnNSL2dEeXV0Qm5hbEwzUXhGSGJRWCtOTkxoRHA1?=
 =?utf-8?B?anhIN1YrYisveGhFakY4dmtLTm1MZkVGMUdXN3RDTStaOHNQUWhqWEtWMUx1?=
 =?utf-8?B?NXhldzhXelZTYjUwUHhQMldKdkVSRXRWemZRbnBoZmxOZDNYUFhDUjhqTmU0?=
 =?utf-8?B?MmdET0pNZFBBVVRuRm1PSDBnMm5iOTZreUIzNENsUDdTangvU3BhZ2o4bjdH?=
 =?utf-8?B?aUpBZzRYblNKbUpoS2djWHdYVFh0V2dBUWdSbzR1akNiOC8wdnRENDQvS0d0?=
 =?utf-8?B?aXZNM2pkU0VJQ2ptVlV4SG91ZVhBTjY1d0FXcS9XV3FsTjJYVTJrUGhkMEUz?=
 =?utf-8?B?WDNGV1hsU3N5ZVplWk1kdVQwdHpmSGZzSksyOGVpY1dIUEowekM4b1hRYXdt?=
 =?utf-8?B?R1hjTlV0VGZEOWxUQXh5RFhaOG5oMGZscFI3eHFlQXVhYncvcmZaQmhVdUxK?=
 =?utf-8?B?cHVESERUV1NLWTI3WDYrSWNLSGZ5MUxrc00xaFp5Z2p5M25RVnplclJzUm9E?=
 =?utf-8?B?VzFtbFhtNnNQZHJtZ2VGWkFSL250QnhyM1MwdmJaMzd2cCtBdVgzckhXWnVp?=
 =?utf-8?B?WFpjL1MySC9icWFSQzlmWE5yeFBQVGk4WTRZNGx2bG9vVUxpM1JBUG8rbVZT?=
 =?utf-8?B?cTBKVjFMNHN3dHg0M2drdWdrakJKZFphWGdtQnJrSVdhSFNVVmM4UnhCVmJ0?=
 =?utf-8?B?a0RwU2FUc1Mrczd2L1NKdWZKWWtXUUFkMGl1akwvNmw5eCtuOTE3eC9hMVNU?=
 =?utf-8?B?dk5DUHBTdG8vSlN5cDRjemVIbGptTTVESnVhMTNkZXd6RnhkY1BYblBYamtL?=
 =?utf-8?B?YkFNZnNMMFFyYnlDaTA3b3BqblpVM01JQXBSb2crWWkvdUZhY3MvQitxQWFw?=
 =?utf-8?B?dDFIZ0RuTHdGcnh0UTZYRUxXU1BtbkVIemNZUnViQ1AvK3loVEIvdVpVMVU5?=
 =?utf-8?B?cG1jcm1leHhKdS9HUkZ0M2ZaRStlUHU4SW8xNWJSMUNYT21kNFdWSFlDVGVy?=
 =?utf-8?Q?iWszlYgsXBgG0XAqiXU/2ydMb?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 196f0dc2-f909-478a-9ddf-08dd077d10c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 02:59:48.9841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MVLDJFt/sblPWkAzUV82NTb55Dxe5DnzMKyrV3ToFyHfThhRlbnQq2KotPbf4Pt7wi4LrKEeINPGxXi9WSNOJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8673

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDI05bm0MTHm
nIgxNeaXpSAxNDo0Mw0KPiBUbzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4N
Cj4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207IGxwaWVy
YWxpc2lAa2VybmVsLm9yZzsNCj4ga3dAbGludXguY29tOyByb2JoQGtlcm5lbC5vcmc7IGtyemsr
ZHRAa2VybmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9y
ZzsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+Ow0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRl
OyBmZXN0ZXZhbUBnbWFpbC5jb207IGlteEBsaXN0cy5saW51eC5kZXY7DQo+IGtlcm5lbEBwZW5n
dXRyb25peC5kZTsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDA0LzEw
XSBQQ0k6IGlteDY6IENvcnJlY3QgY29udHJvbGxlcl9pZCBnZW5lcmF0aW9uDQo+IGxvZ2ljIGZv
ciBpLk1YN0QNCj4gDQo+IE9uIEZyaSwgTm92IDAxLCAyMDI0IGF0IDAzOjA2OjA0UE0gKzA4MDAs
IFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+IGkuTVg3RCBvbmx5IGhhcyBvbmUgUENJZSBjb250cm9s
bGVyLCBzbyBjb250cm9sbGVyX2lkIHNob3VsZCBhbHdheXMgYmUgMC4NCj4gPiBUaGUgcHJldmlv
dXMgY29kZSBpcyBpbmNvcnJlY3QgYWx0aG91Z2ggeWllbGRpbmcgdGhlIGNvcnJlY3QgcmVzdWx0
Lg0KPiA+IEZpeCBieSByZW1vdmluZyBJTVg3RCBmcm9tIHRoZSBzd2l0Y2ggY2FzZSBicmFuY2gu
DQo+ID4NCj4gDQo+IFdvcnRoIGFkZGluZyBhIGZpeGVzIHRhZz8NCj4gDQpJdCdzIG9yaWdpbmF0
ZWQgZnJvbSBjb21taXQgMmQ4ZWQ0NjFkYmM5ICgiUENJOiBpbXg2OiBBZGQgc3VwcG9ydCBmb3Ig
aS5NWDhNUSIpDQoNCkhvdyBhYm91dCB0byBhZGQgb25lIEZpeGVzIHRhZyBsaWtlIHRoaXM/DQpG
aXhlczogY29tbWl0IDJkOGVkNDYxZGJjOSAoIlBDSTogaW14NjogQWRkIHN1cHBvcnQgZm9yIGku
TVg4TVEiKQ0KDQo+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBu
eHAuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IE1hbml2YW5uYW4gU2FkaGFzaXZhbQ0KPiA8bWFu
aXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+DQo+IA0KPiA+IFJldmlld2VkLWJ5OiBGcmFu
ayBMaSA8RnJhbmsuTGlAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAiVGhpcyBpcyBqdXN0ICp3cm9u
ZyouIFlvdSBjYW5ub3QgaGFyZGNvZGUgdGhlIE1NSU8gYWRkcmVzcyBpbiB0aGUgZHJpdmVyLg0K
PiA+IEV2ZW4gdGhvdWdoIHRoaXMgY29kZSBpcyBvbGQsIHlvdSBzaG91bGQgZml4IGl0IGluc3Rl
YWQgb2YgYnVpbGRpbmcgb24NCj4gPiB0b3Agb2YgaXQuDQo+ID4NCj4gPiAtIE1hbmkiDQo+ID4N
Cj4gPiBJTVg3RCBoZXJlIGlzIHdyb25nIGF0aG91Z2ggY2hlY2sgSU1YOE1RX1BDSUUyX0JBU0Vf
QUREUiBpcyBub3QNCj4gZ29vZA0KPiA+IG1ldGhvZC4gUHJldmlvdXNseSB0cnkgdG8gdXNlICds
aW51eCxwY2ktZG9tYWluJyB0byByZXBsYWNlIHRoaXMgY2hlY2sNCj4gPiBsb2dpYy4gTmVlZCBt
b3JlIGRpc2N1c3Npb24gdG8gaW1wcm92ZSBpdCBhbmQga2VlcCBvbGQgY29tcGF0aWJsaXR5Lg0K
PiA+IExldCdzIGZpeCB0aGlzIGNvZGUgZXJyb3IgZmlyc3RseS4NCj4gDQo+IEkgcmVhbGx5IGhv
cGUgdGhhdCB5b3UnbGwgZml4IGl0IGFzYXAuDQpHb3QgdGhhdC4NCg0KQmVzdCBSZWdhcmRzDQpS
aWNoYXJkIFpodQ0KPiANCj4gLSBNYW5pDQo+IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHwgMSAtDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGRl
bGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpLWlteDYuYw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYu
Yw0KPiA+IGluZGV4IDQ2MmRlY2QxZDU4OS4uOTk2MzMzZTkwMTdkIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiArKysgYi9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gQEAgLTEzNDIsNyArMTM0Miw2IEBA
IHN0YXRpYyBpbnQgaW14X3BjaWVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRl
dikNCj4gPiAgCXN3aXRjaCAoaW14X3BjaWUtPmRydmRhdGEtPnZhcmlhbnQpIHsNCj4gPiAgCWNh
c2UgSU1YOE1ROg0KPiA+ICAJY2FzZSBJTVg4TVFfRVA6DQo+ID4gLQljYXNlIElNWDdEOg0KPiA+
ICAJCWlmIChkYmlfYmFzZS0+c3RhcnQgPT0gSU1YOE1RX1BDSUUyX0JBU0VfQUREUikNCj4gPiAg
CQkJaW14X3BjaWUtPmNvbnRyb2xsZXJfaWQgPSAxOw0KPiA+ICAJCWJyZWFrOw0KPiA+IC0tDQo+
ID4gMi4zNy4xDQo+ID4NCj4gDQo+IC0tDQo+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDg
rprgrqTgrr7grprgrr/grrXgrq7gr40NCg==

