Return-Path: <linux-pci+bounces-17015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4B89D0800
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 03:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13BB6B20D23
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 02:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F7D3FB8B;
	Mon, 18 Nov 2024 02:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nCoQ7uUE"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD77282E1;
	Mon, 18 Nov 2024 02:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731898752; cv=fail; b=bGc61BmMrGXBK6RCzfCmyp+SKIX9gO02qf30xmCnqoI934SROKHKmC2wkEwrAad6bPPjKtFI5qiAyyDxwzVH7vcdClY78Hu+v8yEAFFibdgYKH+H5+XDFD6ZXloAWZK9pmDGt1H/VZwNlgjRB4XCfuKbQPphSCqSDBGQVAkYOqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731898752; c=relaxed/simple;
	bh=eYH0JgPkRGvsxrRoruds5U0FI9KNRc2cFpl0lhtT9Kc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ikOuc7Yx4haMq1pnH2R+SExG5M9EgIpu/xQWwYdkM3k0o267ahvgX/NDINHuVv6D+n6kVllZIPAdJXDEyrH18pUe/P3+fqKGg27SMJ78V55BYePu74QlaQ53q/iIflqOJwNT4Z0gDiNvwMIuFcgqZJ4tagFJVbFs50OtMNGg9Js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nCoQ7uUE; arc=fail smtp.client-ip=40.107.22.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zf7O8yWf4TULkzDnwKv2zJiA5x16RyMvwWqQGQNcI3bQmNIv6dINudwGzD2Z7TTTqvh3UXmFBwQPKLaKGe0it6V3oJRYGahBYWRjwFlgCySi6XhH5XP+fM0tZ6vAKG5lXB/9BTIW70bUoyJV6Jlx9OcloYijbaBZjRGXF+Jc0c2EBe6HI71BlnZAscwHVHKuhCTni0jN6xDFXUigWnR/8Q24f1lOrdqOiF63mdd4toFk4fMYIcNvV1/R4+/Wv2Um1cDe9PGiaCoytld6urjVZ4D9Puqxm5ysxkguuD0VZ3wTcZ3lXtJv3mjXo1ykoT3LAaCrcdGzxLpHeAHQIIl2GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYH0JgPkRGvsxrRoruds5U0FI9KNRc2cFpl0lhtT9Kc=;
 b=jnk0VHUTRgP2g0bp2RPLph6l6R53bFPW+GX5dbHL+0UaRYtJSSrMGnlmZVJR8G3ybgdRi8HJ/ujWkgvpUnixKxG59YOva3eqeDv0YSsx1Phc5/U1n7vAC7eAxjIhhNxgoAmdvGSTIkNE8KDbqiSUzx1P14PvAiWvVIzeqw8O8phAPAuRCYMgVnkpzD5Xv9vJCs4jYw0YZj5pVfr9mPBi3XCpysGEIPh9qqCiozTgZtBLvQW75T4/T7zuJ3lrOyYz7kSjqyPP2DV58V4Y0XDoIHpYj+wNm2XlN5Q5jXJ6pKeu8HNepjiLChsA769jpBgQrIFCDBQIqiVhDpxavm55Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYH0JgPkRGvsxrRoruds5U0FI9KNRc2cFpl0lhtT9Kc=;
 b=nCoQ7uUEnYSUnWP1ctRMdIRqWTILhmQIUr3cMtonQnBr18gZqqdhhWH1RdVc9PHmcmhhPaYTtypuVRR8S/JaqsES72VlfrsWzkUyQSzFgqb6jYvXtSdVZa7OTeFv5EvN4lnzkTFhYRNfUlnntnQ1XJrQYKuc3Xl0d/TAYXLQobrgZ4K19Hfw1/2FcpPyp50cms0OCC2PFywP9ozc0u26YeOhzHi2Z3V88BKDkvTGedkotMYvA6JazX4qfE5fpS2XypnUn6Egafe9AekFT2yRKHMPBjT/mY3oHJZaLc38jIZMqs0L69vEe/9EFNu8mEHnlbsppWvWo0MvAbP+9m69PQ==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8673.eurprd04.prod.outlook.com (2603:10a6:20b:428::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 02:59:07 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 02:59:06 +0000
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
Subject: RE: [PATCH v6 02/10] PCI: imx6: Add ref clock for i.MX95 PCIe
Thread-Topic: [PATCH v6 02/10] PCI: imx6: Add ref clock for i.MX95 PCIe
Thread-Index: AQHbLCso6MuPL2Z9qUKOGDuz4p1bP7K3+ZAAgAMyLEA=
Date: Mon, 18 Nov 2024 02:59:06 +0000
Message-ID:
 <AS8PR04MB86767205982E13C2771614AB8C272@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
 <20241101070610.1267391-3-hongxing.zhu@nxp.com>
 <20241115063816.xpjqgm2j34enhe7s@thinkpad>
In-Reply-To: <20241115063816.xpjqgm2j34enhe7s@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AS8PR04MB8673:EE_
x-ms-office365-filtering-correlation-id: 2d138168-1f96-4b24-b1c7-08dd077cf793
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L0hXczYzMHl4NHN1c3FML2l0cXN1SnFMK1BzaW1MTHBEamtaVkRiZUFSN3Ri?=
 =?utf-8?B?OW1HNlFqTFRxNHYwallQQmhVdlhXRFBVbldCQjhhMlNhV2RKMUpHVzFqbzdM?=
 =?utf-8?B?UFVlRVp3bW13WUpMNitoMDRsUTRoYXV3cTF4VVBHNnI3cmtrSk1kbXorV01x?=
 =?utf-8?B?QzRsSmR1Y00rdW9FNDJoVWtDWFMwOUM4cDk1M1N2VVdpVUNNcUNZK3c1UCs0?=
 =?utf-8?B?WmJRQ1hiQWVKS3VlZkFtM1dGZTZ4YjZFMGVpTUFsNnMwYnI5eDRTYlJVaXNk?=
 =?utf-8?B?aWpNNkpuM1BJblU4SHIzeWdZRDZuK3RVbHZsL3NtVVBIZFhidkhDV3NocnJL?=
 =?utf-8?B?bnhDMCtEdWpmV1FNRG5OMHN3ajVHbkxxZU1SVTJPUk1ETVVBandVM2k4cDVm?=
 =?utf-8?B?ZW5zQjhBTFFFVEJZWlJ3WWRTUHE1L3pKWVQvb0ljUDh5QjJNakdnQzB6eFpr?=
 =?utf-8?B?ZHpHUWExb2dnUXpiSjJVOHpUM0pYNnA4T1M4MlNqN3d3UEhwVy96VjlmcG1N?=
 =?utf-8?B?QmY1ZGdjYWVxeWxkTHA0KzNJRm9XRnFLNFVlRDlhcnpxb0xlcnl6YjNvNHgy?=
 =?utf-8?B?T1ROSGxzZlU1WGgvNW04MW91STNTb2N6UU14N3pzLzVPNUVEVzlBYlBUdlhm?=
 =?utf-8?B?b3VjMlhYc3pMWVM1SmVMdDdscVJmcFFSUUEzbEpEV2J0Q09XdkVuV2lQUjEz?=
 =?utf-8?B?b2VpWU5mSy9FZjNwdXZYODRmK0FQNERiRzV6YWg5MGg1QlJWMkxoeWFzYkha?=
 =?utf-8?B?cFhQanVYM0NRUzlSS3JRWncwOE5qL3FkSlRIMDloQnJOSENXWko3dUVvNkRi?=
 =?utf-8?B?VXlOOERMV0xaUzZJL0xXUzMyUzB5ZHYxVjZxcHlrNFZNNDV3MGw2UGhBdUNL?=
 =?utf-8?B?dXU2S0lSM3NKSDVCT1lWTHQ4RXNtOEM5bk4xRnRGcDRvMW9kQURZeE0ydzBY?=
 =?utf-8?B?blR6NTFwV01CL0piMkRGTGo4TS9GUVFlcWN5Smp2eUZSeHJseVlHZlkvVWho?=
 =?utf-8?B?UThaMWVmVTlFTWpGS1c0cjM4YWJTbXdjcmJQaEhMYlpuYTUvSDFCS0gvWHlh?=
 =?utf-8?B?c2JPQjZlTDV4WUR5WWhaQlVLM21QbE5hV21zNkRSTFYzSDZxSitVNjhpbkhv?=
 =?utf-8?B?MVVTd1NKbzVETEcrTnNFYkF3N2lXcFBnbmpwbVFRa2JJeW1ZVDRFdnJTekpt?=
 =?utf-8?B?b285YUlPMzYycjNGUTJ3V2hieEVTeWZ2cmRERXlkU1pFakJSWmttNkQ5dVl3?=
 =?utf-8?B?NUZERUpmVHR1U0tVSHJSTHFnNUYybXZBanltLzRjUDQxZ2RMUm5YZjBSdzJJ?=
 =?utf-8?B?ZzA1THQwQXhRc09GVEdNcnU1RlhCUVZrQXlWWnJzKzhCYWFBZlZQajJHTk9E?=
 =?utf-8?B?TWtmUWhJSU1ieXVqdG9oY0ViOXc2TlpUQWtHdmtuN2RXemQvNlNnOHlpN2JF?=
 =?utf-8?B?ZWd5QlFIb284eDMySlpaL1dORnRPU09ZWURsL3FPTUx3VUV6VkFadVBmQ0ky?=
 =?utf-8?B?RU1PbXZmaUdvclB1M2JLMXhBdjlCV3BPakYrNWFLeU05MHNTWXBYNWdZaDFC?=
 =?utf-8?B?UC9SRFpLNTR6V05QVklkNERJemZiZlc2UTlLUk1pWWU4VUZZVE80VEdLZkJs?=
 =?utf-8?B?bnRDMzZyNW9xUk9YaEtIY3U5RHRCUGFva3h4SU02a1ZZSEdjUmFyU1BCeU5r?=
 =?utf-8?B?ZitQMzlLMW5LV0lKUUppNGl4ek13YTZFTzZMeFJOUlprQkF3ZnZVVjBRajIx?=
 =?utf-8?B?UzBNbFlMZm4xREZhRTNLaDFRSnE1ZFNyclNNaDc3anI3L1QzUXByNUtTRk96?=
 =?utf-8?Q?o+L4mF/9Ma4qsJWUGC/JnTz54Z/pTsYAl0YKU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a3dvL2x5SmVCRWhOVHZnRW56cC92V0hSdWMxS2RjN29Jak9nZ1ByVktCdHB6?=
 =?utf-8?B?T2NwOHJBZGppcHpqRkZlZ3Fqei82VmhqaW1DMnk0ckJUVkY3eHZDK09ENEJB?=
 =?utf-8?B?MnVGRW5sZ2NSNGJyTEQ2WStTc0pYNFNUYzFLRXpVaThiUUZrbFhlMFVKNE54?=
 =?utf-8?B?M2crSWYxYmJGRHlhVmU2MjhvVTlaeUNqM2RUZ0p6SHZvM2dPNVh6bWM4YnIy?=
 =?utf-8?B?YjVkcE1lck4rVW5kdDVUVnlkTlFyU01KTjg0Ky9xbzBHVjlhZDRQOWswcTBu?=
 =?utf-8?B?N2wyQnh3T09DZjRwaDlIY2pVeWIxQ0ovOU5PTWIwZjVsUUdLcmpSRzU2M3hY?=
 =?utf-8?B?S3ZsNmhWaFBlaG02OG0xcnBHVlBuTkNoU2F1dFFpS2plU2pIS2xPM3lkaWkv?=
 =?utf-8?B?b0VjRzhET0U4bXhXNW8xOWxUbmt0OVRwdEdNUEJ3ZHlYY1dGWEhjOGFsaVAy?=
 =?utf-8?B?RFp1MUpaVDhSdjZpUVhhSjBRcnR0RGdtb3J4U3o0dEVCZVlyRGdqNVkxUVR5?=
 =?utf-8?B?OFFQVlNYQWw2blpEZXlzK3BEMzAyQjBzdUZaQytNb0Z2SVI0dkRuZ0Y2TFAx?=
 =?utf-8?B?MnJuYU9KTHVrUEpEOWRTYlRZSWtwVndQRUFLWnRVOVFleVlQbjJpcTE2S3J4?=
 =?utf-8?B?TzhUQjlnRW4xcEljUjg2RjRvcjJtSnlBK1FqVURjKzVPNFZxQzJYdW9scm4x?=
 =?utf-8?B?dXFTMFRxTU1ocVNoUUhtZ2FJcDBpVzJRUnp2T1pjYXhrVGVubFRjSlQ4aFlh?=
 =?utf-8?B?Z0pMMytzV0dWR1p3L2lrY041WmlYOTB6VWdRcEs5dmRlSDRSMVVyY0I3MUdh?=
 =?utf-8?B?K3ZFNy85Y01Kc3hubUdaTGYyNEYxUDNVOFVBSTVyWnowMUlBYThmZDlRUU1M?=
 =?utf-8?B?Tk5QYi9uWjdENlVSRHVheDFKNlhjNlk4Qm1lYllBc0RuSWgyMlh1SGZzUGJK?=
 =?utf-8?B?RS96eWFTVGZXUGpUMWJQdnhzaU0zWmhkQ1JBQzYyR3FTQlFlYnZRVXdGS3BK?=
 =?utf-8?B?Wjl0UFNaMHBnelp0RW9RVmZxcTEveGVwSmxkR2VSQWIxRDM3cld2VXRJUDJt?=
 =?utf-8?B?ZEo0cXR2cTdkVW5nTlI2b0xmeENldUp5amNqOE5lMk50aEdFZW41UzFDVi9K?=
 =?utf-8?B?djR5VEFVSTliUVIzUU9xZU16blEwS0NSSm5TTDZnRklaeHZqbnJSL3Y3elRI?=
 =?utf-8?B?bVpWOHgzNjlzb281Z1VCeWdwWUEwSWlyMmhmYWpONHpibDJxYzZnTXRXUUhy?=
 =?utf-8?B?SjNJWDZuOEcxYzdWV3M1RkJEeVhQS2dHanFBNTZDZlZFRDhhckxST3ZicXdT?=
 =?utf-8?B?L0NyK1hTVTBUaVVxVDBpMEx3M0pqZXQ2SEtEdW1RcEN4RWI5MDlIU0NWUUNk?=
 =?utf-8?B?TG1wb1Y5VHBENG5wbWVQTnRVbTBkU1dLUDVXcG1UVitTektwdUg4UXNPMkpN?=
 =?utf-8?B?cWxnRVovZ0MxTGltdTBXdnA3b2t2SldSWTFlbk5ZdVVVejNiUElhanZaczMy?=
 =?utf-8?B?dU9GYlZZejRaenFkMzB5ZE9uWTVOOVFQdFUyRWJFdnFGeUtMODlKVDl1aFdl?=
 =?utf-8?B?L3VZWHZJdUxadnJEcEhnbFN5U1R0MU5GRW5TUVRjNWdKbFRyU3V1UjYzN0Zl?=
 =?utf-8?B?VjBLMmRjU3BIYUxRZXV0UmxMWnY3ZWRtWUlkbUV1WDFSdVFMVkZzQWk4eXQ1?=
 =?utf-8?B?UmdSTmJJMUZXaHhOUnp3dHFwYzNsMjZHSS85MSs1b0ZZSnhGYk43ZXN5cngz?=
 =?utf-8?B?aG15ZEV2OEEwL01scStvQ3FvMUJ0WnJNS2Q5ekFUeFlvQVRjOENmNzVpamlK?=
 =?utf-8?B?S2JqN2JlcnRHRzQ1QjJMQVl0eU8ybklLaS9qRnlaeHVlK3JNUW9TbDhGWTJC?=
 =?utf-8?B?YTBwL21WTjR6NDAvSUNlL0tpa2tjbEdPVEszRzZ4V0Vyc1p0TEZBVnErL2lN?=
 =?utf-8?B?VWwxMjEzNmJjbDM0TGRWWXpjTG5zc1J3NkFFQUZ3RmtZa29Ldkd5SkVxMTMx?=
 =?utf-8?B?bTk1UERjR1o3aVFCSWxHd0dZWmFMWXoyY0VFREJZY2hpQklJNzIvekRhd2Fr?=
 =?utf-8?B?UEZWaGwvandBUjBnaExieUVsUUZBNHhhUUE5NGs1UXk2WFBnSjJnaGpCaVhN?=
 =?utf-8?Q?wu4mZzRQPIecimprdGJTKof8h?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d138168-1f96-4b24-b1c7-08dd077cf793
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 02:59:06.7090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VtRs7V7mdH/rhoVzzfMMcsA/yknfI0BpJ9PHeRYMuniVfZHJ2JWCuVNg6xMl/oCAaEpiIQxif7QMsk3ELRDfhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8673

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDI05bm0MTHm
nIgxNeaXpSAxNDozOA0KPiBUbzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4N
Cj4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207IGxwaWVy
YWxpc2lAa2VybmVsLm9yZzsNCj4ga3dAbGludXguY29tOyByb2JoQGtlcm5lbC5vcmc7IGtyemsr
ZHRAa2VybmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9y
ZzsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+Ow0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRl
OyBmZXN0ZXZhbUBnbWFpbC5jb207IGlteEBsaXN0cy5saW51eC5kZXY7DQo+IGtlcm5lbEBwZW5n
dXRyb25peC5kZTsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDAyLzEw
XSBQQ0k6IGlteDY6IEFkZCByZWYgY2xvY2sgZm9yIGkuTVg5NSBQQ0llDQo+IA0KPiBPbiBGcmks
IE5vdiAwMSwgMjAyNCBhdCAwMzowNjowMlBNICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4g
PiBBZGQgInJlZiIgY2xvY2sgdG8gZW5hYmxlIHJlZmVyZW5jZSBjbG9jay4gVG8gYXZvaWQgdGhl
IERUDQo+ID4gY29tcGF0aWJpbGl0eSwgaS5NWDk1IFJFRiBjbG9jayBtaWdodCBiZSBvcHRpb25h
bC4NCj4gDQo+IFlvdXIgd29yZGluZyBpcyBub3QgY29ycmVjdC4gUGVyaGFwcyB5b3Ugd2FudGVk
IHRvIHNheSwgIlRvIGF2b2lkIGJyZWFraW5nDQo+IERUIGJhY2t3YXJkcyBjb21wYXRpYmlsaXR5
Ij8NCj4gDQpZZXMsIHlvdSdyZSByaWdodC4gVGhhbmtzLg0KDQo+ID4gUmVwbGFjZSB0aGUNCj4g
PiBkZXZtX2Nsa19idWxrX2dldCgpIGJ5IGRldm1fY2xrX2J1bGtfZ2V0X29wdGlvbmFsKCkgdG8g
ZmV0Y2gNCj4gPiBpLk1YOTUgUENJZSBvcHRpb25hbCBjbG9ja3MgaW4gZHJpdmVyLg0KPiA+DQo+
ID4gSWYgdXNlIGV4dGVybmFsIGNsb2NrLCByZWYgY2xvY2sgc2hvdWxkIHBvaW50IHRvIGV4dGVy
bmFsIHJlZmVyZW5jZS4NCj4gPg0KPiA+IElmIHVzZSBpbnRlcm5hbCBjbG9jaywgQ1JFRl9FTiBp
biBMQVNUX1RPX1JFRyBjb250cm9scyByZWZlcmVuY2UNCj4gPiBvdXRwdXQsIHdoaWNoIGltcGxl
bWVudCBpbiBkcml2ZXJzL2Nsay9pbXgvY2xrLWlteDk1LWJsay1jdGwuYy4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiBSZXZp
ZXdlZC1ieTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMgfCAxOSArKysrKysrKysrKysrLS0tLS0t
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2
LmMNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBpbmRl
eCA4MDhkMWYxMDU0MTcuLmJjODU2NzY3N2E2NyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IEBAIC04Miw2ICs4Miw3IEBAIGVudW0gaW14X3BjaWVf
dmFyaWFudHMgew0KPiA+ICAjZGVmaW5lIElNWF9QQ0lFX0ZMQUdfSEFTX1NFUkRFUwkJQklUKDYp
DQo+ID4gICNkZWZpbmUgSU1YX1BDSUVfRkxBR19TVVBQT1JUXzY0QklUCQlCSVQoNykNCj4gPiAg
I2RlZmluZSBJTVhfUENJRV9GTEFHX0NQVV9BRERSX0ZJWFVQCQlCSVQoOCkNCj4gPiArI2RlZmlu
ZSBJTVhfUENJRV9GTEFHX0NVU1RPTV9QTUVfVFVSTk9GRglCSVQoOSkNCj4gPg0KPiA+ICAjZGVm
aW5lIGlteF9jaGVja19mbGFnKHBjaSwgdmFsKQkocGNpLT5kcnZkYXRhLT5mbGFncyAmIHZhbCkN
Cj4gPg0KPiA+IEBAIC05OCw2ICs5OSw3IEBAIHN0cnVjdCBpbXhfcGNpZV9kcnZkYXRhIHsNCj4g
PiAgCWNvbnN0IGNoYXIgKmdwcjsNCj4gPiAgCWNvbnN0IGNoYXIgKiBjb25zdCAqY2xrX25hbWVz
Ow0KPiA+ICAJY29uc3QgdTMyIGNsa3NfY250Ow0KPiA+ICsJY29uc3QgdTMyIGNsa3Nfb3B0aW9u
YWxfY250Ow0KPiA+ICAJY29uc3QgdTMyIGx0c3NtX29mZjsNCj4gPiAgCWNvbnN0IHUzMiBsdHNz
bV9tYXNrOw0KPiA+ICAJY29uc3QgdTMyIG1vZGVfb2ZmW0lNWF9QQ0lFX01BWF9JTlNUQU5DRVNd
OyBAQCAtMTI3OCw5ICsxMjgwLDgNCj4gQEANCj4gPiBzdGF0aWMgaW50IGlteF9wY2llX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIAlzdHJ1Y3QgZGV2aWNlX25vZGUg
Km5wOw0KPiA+ICAJc3RydWN0IHJlc291cmNlICpkYmlfYmFzZTsNCj4gPiAgCXN0cnVjdCBkZXZp
Y2Vfbm9kZSAqbm9kZSA9IGRldi0+b2Zfbm9kZTsNCj4gPiAtCWludCByZXQ7DQo+ID4gKwlpbnQg
cmV0LCBpLCByZXFfY250Ow0KPiA+ICAJdTE2IHZhbDsNCj4gPiAtCWludCBpOw0KPiA+DQo+ID4g
IAlpbXhfcGNpZSA9IGRldm1fa3phbGxvYyhkZXYsIHNpemVvZigqaW14X3BjaWUpLCBHRlBfS0VS
TkVMKTsNCj4gPiAgCWlmICghaW14X3BjaWUpDQo+ID4gQEAgLTEzMzAsNyArMTMzMSwxMCBAQCBz
dGF0aWMgaW50IGlteF9wY2llX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQo+ID4gIAkJaW14X3BjaWUtPmNsa3NbaV0uaWQgPSBpbXhfcGNpZS0+ZHJ2ZGF0YS0+Y2xrX25h
bWVzW2ldOw0KPiA+DQo+ID4gIAkvKiBGZXRjaCBjbG9ja3MgKi8NCj4gPiAtCXJldCA9IGRldm1f
Y2xrX2J1bGtfZ2V0KGRldiwgaW14X3BjaWUtPmRydmRhdGEtPmNsa3NfY250LA0KPiBpbXhfcGNp
ZS0+Y2xrcyk7DQo+ID4gKwlyZXFfY250ID0gaW14X3BjaWUtPmRydmRhdGEtPmNsa3NfY250IC0N
Cj4gaW14X3BjaWUtPmRydmRhdGEtPmNsa3Nfb3B0aW9uYWxfY250Ow0KPiA+ICsJcmV0ID0gZGV2
bV9jbGtfYnVsa19nZXQoZGV2LCByZXFfY250LCBpbXhfcGNpZS0+Y2xrcyk7DQo+ID4gKwlyZXQg
fD0gZGV2bV9jbGtfYnVsa19nZXRfb3B0aW9uYWwoZGV2LA0KPiBpbXhfcGNpZS0+ZHJ2ZGF0YS0+
Y2xrc19vcHRpb25hbF9jbnQsDQo+ID4gKwkJCQkJICBpbXhfcGNpZS0+Y2xrcyArIHJlcV9jbnQp
Ow0KPiANCj4gV2h5IGRvIHlvdSBuZWVkIHRvIHVzZSAnY2xrX2J1bGsnIEFQSSB0byBnZXQgYSBz
aW5nbGUgcmVmZXJlbmNlIGNsb2NrPyBKdXN0DQo+IHVzZSBkZXZtX2Nsa19nZXRfb3B0aW9uYWwo
ZGV2LCAicmVmIikNCkl0J3MgZWFzaWVyIHRvIGFkZCBtb3JlIG9wdGlvbmFsIGNsa3MgaW4gZnV0
dXJlLiBJIGNhbiBjaGFuZ2UgdG8gdXNlDQpkZXZtX2Nsa19nZXRfb3B0aW9uYWwoZGV2LCAicmVm
IikgaGVyZSBpZiB5b3UgaW5zaXN0ZW50Lg0KDQo+IA0KPiBBbmQgd2hvIGlzIGdvaW5nIHRvIHN1
cHBseSB0aGUgcmVmZXJlbmNlIGNsb2NrIGluIHRoZSBhYnNlbmNlIG9mIHRoaXMgY2xvY2tuIGlu
DQo+IERUPw0KV2hlbiB0aGUgInByZXZpZXciIHZlcnNpb24gZmlybXdhcmUgaXMgdXNlZCwgdGhp
cyBjbG9jayBpcyBnYXRlZCBvbiBpbiBkZWZhdWx0Lg0KSW4gdGhpcyBjYXNlLCBoaXNvLWJsay1j
dHJsIHdvdWxkIGdhdGVkIG9uIHRoaXMgY2xvY2sgaW4gZGVmYXVsdCBzdGF0ZS4NCg0KQmVzdCBS
ZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiANCj4gLSBNYW5pDQo+IA0KPiA+ICAJaWYgKHJldCkNCj4g
PiAgCQlyZXR1cm4gcmV0Ow0KPiA+DQo+ID4gQEAgLTE0ODAsNiArMTQ4NCw3IEBAIHN0YXRpYyBj
b25zdCBjaGFyICogY29uc3QgaW14OG1tX2Nsa3NbXSA9DQo+ID4geyJwY2llX2J1cyIsICJwY2ll
IiwgInBjaWVfYXV4In07ICBzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0DQo+ID4gaW14OG1xX2Ns
a3NbXSA9IHsicGNpZV9idXMiLCAicGNpZSIsICJwY2llX3BoeSIsICJwY2llX2F1eCJ9OyAgc3Rh
dGljDQo+ID4gY29uc3QgY2hhciAqIGNvbnN0IGlteDZzeF9jbGtzW10gPSB7InBjaWVfYnVzIiwg
InBjaWUiLCAicGNpZV9waHkiLA0KPiA+ICJwY2llX2luYm91bmRfYXhpIn07ICBzdGF0aWMgY29u
c3QgY2hhciAqIGNvbnN0IGlteDhxX2Nsa3NbXSA9DQo+ID4geyJtc3RyIiwgInNsdiIsICJkYmki
fTsNCj4gPiArc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBpbXg5NV9jbGtzW10gPSB7InBjaWVf
YnVzIiwgInBjaWUiLA0KPiA+ICsicGNpZV9waHkiLCAicGNpZV9hdXgiLCAicmVmIn07DQo+ID4N
Cj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBpbXhfcGNpZV9kcnZkYXRhIGRydmRhdGFbXSA9IHsN
Cj4gPiAgCVtJTVg2UV0gPSB7DQo+ID4gQEAgLTE1OTIsOSArMTU5NywxMSBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IGlteF9wY2llX2RydmRhdGEgZHJ2ZGF0YVtdID0NCj4gew0KPiA+ICAJfSwNCj4g
PiAgCVtJTVg5NV0gPSB7DQo+ID4gIAkJLnZhcmlhbnQgPSBJTVg5NSwNCj4gPiAtCQkuZmxhZ3Mg
PSBJTVhfUENJRV9GTEFHX0hBU19TRVJERVMsDQo+ID4gLQkJLmNsa19uYW1lcyA9IGlteDhtcV9j
bGtzLA0KPiA+IC0JCS5jbGtzX2NudCA9IEFSUkFZX1NJWkUoaW14OG1xX2Nsa3MpLA0KPiA+ICsJ
CS5mbGFncyA9IElNWF9QQ0lFX0ZMQUdfSEFTX1NFUkRFUyB8DQo+ID4gKwkJCSBJTVhfUENJRV9G
TEFHX1NVUFBPUlRTX1NVU1BFTkQsDQo+ID4gKwkJLmNsa19uYW1lcyA9IGlteDk1X2Nsa3MsDQo+
ID4gKwkJLmNsa3NfY250ID0gQVJSQVlfU0laRShpbXg5NV9jbGtzKSwNCj4gPiArCQkuY2xrc19v
cHRpb25hbF9jbnQgPSAxLA0KPiA+ICAJCS5sdHNzbV9vZmYgPSBJTVg5NV9QRTBfR0VOX0NUUkxf
MywNCj4gPiAgCQkubHRzc21fbWFzayA9IElNWDk1X1BDSUVfTFRTU01fRU4sDQo+ID4gIAkJLm1v
ZGVfb2ZmWzBdICA9IElNWDk1X1BFMF9HRU5fQ1RSTF8xLA0KPiA+IC0tDQo+ID4gMi4zNy4xDQo+
ID4NCj4gDQo+IC0tDQo+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprg
rr/grrXgrq7gr40NCg==

