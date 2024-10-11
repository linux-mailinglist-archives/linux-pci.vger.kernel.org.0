Return-Path: <linux-pci+bounces-14253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB7B9999EB
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 04:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 667A21F240C4
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 02:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752EE18E25;
	Fri, 11 Oct 2024 02:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Kj+Io3nC"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010025.outbound.protection.outlook.com [52.101.69.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F164A06;
	Fri, 11 Oct 2024 02:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728612128; cv=fail; b=FGjLdBbWZpNWIJT/JfHUkD2oleedX6Siy+aWB4/gO9Y/xfTGhG6jczI0P5J1izq6uJQvHy2b+lLXUPIWZZREN+bJuyOOj6kYTlm/QkYeMV/uLA4c67WlW0Yr6Ms2NWrIIYCILH6PhNmNX/6s8M6kjzFQe2/1+Y57gOGaVLgEmZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728612128; c=relaxed/simple;
	bh=sjQVNxPQ1UVRLlykwQ0ajQ30ZeoZhEbN9ESUTcOqkAA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Se+Y5XMhclAAaTtg8WAhnz7+lcL1PMAAabIFLQ/8VOGvijlmqF35A7utYYh1XtmMIu68MVTKCYjBStJRXwK/GpUBfyRw5VeS9eD4Kgt6Vz0L1SNsbSzojoXHG31paJ3AnlyoyUE7Io75aqiAbhN1YL7C4uddmVj5RrHQHB2dOVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Kj+Io3nC; arc=fail smtp.client-ip=52.101.69.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xa6hNZtTIba8/LmHIbMHmXp9zp29yQdCzUf4hP/hTgfIz29haxM4ZitSYo88a0dMVMd4n0EC9s66nLdlMK3CNhoa9T77crIyBxLto+FPX58QkevHvX3cL33A07jONjN0zC2GZ6aJCV7m2OIckJn2uQebvxIEiBj5fWPCiVajqUom3Ew+Rt2IJpIbioOtN9NK9Nvul+3ZtG/aB+QUQt0jRoMzG6gmrbMEiB4iPQLFKLF6yzgA1e3Uu5lozOjasrBcMTbxVzixSRhmLMKPHiIS5dUrx8zpM0wH3PlWhqgKk7ZfnTqIbBQGg01X1viDi3SHG9PwT0jRm/Y6zxzjTgvjOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjQVNxPQ1UVRLlykwQ0ajQ30ZeoZhEbN9ESUTcOqkAA=;
 b=RO1V/XtAV4V65Lw/Y2ClPaS7iXxvYjFVHQr/XKDJ+hmkbWZ8uA7eUEhTrn+P5CAjP64m5UtniBX17qZSZaCtIJd656sLaZkNjuiua3GnDFusAv6MFdtacuMDRYSIM8+NnxZ/vDD5LstuHUNZeogSQYRammKh3hvpQhn5+rNbfoFvqvJgJ0anyzA0Yr6YDdVfwunx+apPKUo398c2pfcx9XXebe22WPAbjrOrtrog3reK4svhXn+0oweswNhbmUsyWSZqwgLmw9mavL7AVXoYumomouyRbsWzF+mr7bd59WjohXqLkIUEWbd2eNm0c46hM33ceU1oSAO9zfk6x1+BNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjQVNxPQ1UVRLlykwQ0ajQ30ZeoZhEbN9ESUTcOqkAA=;
 b=Kj+Io3nCUKb7JKcvzs7rtF7gjB+TPUhPTjGLEj6+7Y1HkcDuJ+NopyFSV9L7kwHI3AIFFZ8qy4QoMO6j34vbxoaa+BWTPv9YeCgoV6NGOdFgRe4hVAAQIinIKv+0f/aUXyvChbKSV/1GLWWIqWKGJWUjoy6avZ42PaRCc0R4gOLnN3raW80R6lgPdfm8OvShP220uEbbtNv7QlDc/acw/1zQf0yaolyxl84J7DBOIyY5SqfLPmhi8JIx4Rx+u0cEVY9KrB+luNE0oIdVLsZTKd6tNjwvxMxuWpF2mU8NbMcjKaMuq3h3R8KRxNzdaCSF88BjUKAjGATXTLVqVwGwYw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8865.eurprd04.prod.outlook.com (2603:10a6:20b:42c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 02:02:03 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Fri, 11 Oct 2024
 02:02:03 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH net-next 10/11] net: enetc: add preliminary support for
 i.MX95 ENETC PF
Thread-Topic: [PATCH net-next 10/11] net: enetc: add preliminary support for
 i.MX95 ENETC PF
Thread-Index: AQHbGjMCRp6WYylLaEyKPUuJKhwhaLJ+sHIAgAClOHCAAMZUgIAAsT0w
Date: Fri, 11 Oct 2024 02:02:03 +0000
Message-ID:
 <PAXPR04MB85102605C8B2FCE52783BD5288792@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241009095116.147412-1-wei.fang@nxp.com>
 <20241009095116.147412-11-wei.fang@nxp.com>
 <ZwbANHg93hecW+7c@lizhi-Precision-Tower-5810>
 <PAXPR04MB85100EB2E98527FCC4BAF89B88782@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <ZwfxK+vm2HCXAKHG@lizhi-Precision-Tower-5810>
In-Reply-To: <ZwfxK+vm2HCXAKHG@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB8865:EE_
x-ms-office365-filtering-correlation-id: 7ee8cb06-ad1c-45f3-6289-08dce998b347
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?SzZTbzVVcDBIRjJqcytzaHIzQm91aXRIc2NLRmxLSEQxMk9janE5NzZhY0pk?=
 =?gb2312?B?bTFPc0RnNHV4M3U5M2lBUDVudVFxYUY4eHpqWGhYZVUvY29hc2ppd2t0Z3VM?=
 =?gb2312?B?cTNLNDR2a3FjdnRpNHFJRS9HN2JyMUhPVWFTQjVQYi9xVG5Jck1idXlyWW1t?=
 =?gb2312?B?dE5zd2VjQW1WNERpZ1Z0S1pnUENiT2pXc09yUHhicGcvUzJjRG5sWVBmQ2E0?=
 =?gb2312?B?MHlnOFJJOG1aSE0yZzFiMzFid2hnbjRSRjVDeFV6bGpMTkpuUEhKUTJzSXps?=
 =?gb2312?B?cWRyTlI2MDM2NFVtaFNxUUZ5aFJIM1dVc0RVMjFUTm13dmhJSGFWd0I1UWJS?=
 =?gb2312?B?NVZWajJIQlBQMnh1M09lQ3BVblV4ZEx2b3VxSVdkdTNPbGxESGFIeHZlUG53?=
 =?gb2312?B?TkFuajM4MkhscVdza0lqdFZ3ckRKSW1EL1QxUTJTTTY2ZllPODVRcklzK0ow?=
 =?gb2312?B?STZtMGFuOTlTZEtRcE42UjRmUkRodEFocjlhc3owaWxjUW1iZkRoblVWTzFN?=
 =?gb2312?B?K2pGUHNYQ3hjVlZvZUZYOTZGMGN5WGR5Z09hSU8vNkhmTk9XYUJLQXp4Y0d5?=
 =?gb2312?B?VGUySGVTMDk4VE9CNFAvV1NYMmhiOVVKU3VSTllncjE4bk50dmJXQjZGNmxS?=
 =?gb2312?B?YzNEcytDdzhCcFN2eEVsNTFVdkQ2OUR0R05RSkx2UmFPNEVJZC8vNy9YZVZX?=
 =?gb2312?B?OFJPakNpczU4Y2I1ZkFoa0paS3o2ZVpRSnpSOVNDMXB6YXdHdWZBY2Zkb1dr?=
 =?gb2312?B?R256SmM1ZmpZU0huekR4akpWbXZISEpGWk5BUVlVeVREaldNSk93aVFTaGRQ?=
 =?gb2312?B?UC8vVFhYNkRxZDBvQXB6VWNNeU9RVnNBb1pQZ2tDMVFUcHhMY2hQL0h5Tmpq?=
 =?gb2312?B?SkMzU1U2eFdhcllpVlU0SkpFQVFGa1l6dVdkV3ZKbk4zU1FUNTNrandpTTNK?=
 =?gb2312?B?ZzNpZVFVUzd2YmpubFJxYmlDVXFNRHQ4d2t1d2RqTHkvaU0vaDdqNWZyT0th?=
 =?gb2312?B?OWV4SDhPMFRwTDU2N0xWcUZ2NSt0eDJ6WU84TE1abjdPZktnNDdhY3NwNU42?=
 =?gb2312?B?STdTUzgxS3pCM2J2eFRyWU1PeTVzVzh2WHEvNlM3Um9qZDltSEFrbUdoN0h6?=
 =?gb2312?B?b0tGcGpCekwyZCtuTGJmU3JzSHhYYW82NU9XNFpLSWFzMnQyT0c0WlF2eDY1?=
 =?gb2312?B?YndaNnB5Sk9BR0EvSXVhd09xbWxZUWxyTWRyRVl1TWhsYkxxV2pobHA3eGUx?=
 =?gb2312?B?NlhSMzluV3pJK1VsL1dBNjhUaEZhSmw0TTR5d2Fma3JJaCtTSEc0aitzMUFS?=
 =?gb2312?B?a3dtSUhFZVdrazJnTUo2dHlWbXoySkllSnBPSW1iTlByRU9rTGNmSXR4MlpM?=
 =?gb2312?B?NjNsTW4zWmk0SUF3Ymk2MU9hQnpCSWNrcVNGeFp3NHFWZHFSd3Y5U2VFcFgr?=
 =?gb2312?B?RE84aThNVWNhZmhKYlBXMGtpM2QwQzhHOWF6aTFPSUxUQ0FlZyt2YXIyOEdk?=
 =?gb2312?B?S1krWTRSL0FSVWVzZDFyb21xR2dEYlpkTFdHVnJGeUxGdXRJbE82bW9HYTFS?=
 =?gb2312?B?eTlHSkdCY01JdXZBU2p2UGgraWZ3UUo3UmovWkFSR3RiYSt1Ykx0NVRDQUZn?=
 =?gb2312?B?cDFmWSsvdlUwSmMwNkFrTGcwdE0rNHhhN1Y0L2YvZ1RmOFhTY0VaTTRYSi90?=
 =?gb2312?B?WSt3VXdLdmVSU1Q5TWsxNFNQVW9PQ1NKL3ZjQmNoOWcvM0EyWXd3bUllQjdN?=
 =?gb2312?B?bGJqcXMrWm0rSk1UMlFlbHNrc3dueStqN1RobGIrTW54bmFmeHlNeEJBcjd5?=
 =?gb2312?B?ZFBzQ29VYzZ0cUkwM0w4dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?MDJiYmR0eGRvdVJ5d0NOVkZuT25HaVBINjJ1UURxRGlZWldaeFJNMEpiYXg0?=
 =?gb2312?B?TUxkNkU3WVZOYTg1dzBtSmxORmJNU3E5YkVENUVRbjNZVFZ1dm50MW1YeGhs?=
 =?gb2312?B?ajlYUEdxWEYzT3N6dDZvd0R1d0J4SS9kMVdHckplZDg4cFBGbkJzMnJQRDR4?=
 =?gb2312?B?K3ZrM3p5cDNzbEJWZDBXdGVWeElqTHlQTDYzcHN2Wi9tbFlpUVFxVVVxelMw?=
 =?gb2312?B?VjdFVVNXVzIreG9Bbit5ZXdaTzNxK3oxVmhrMzRuV05wbW1IT2xVc21yNGRs?=
 =?gb2312?B?eEFJaEpsQTQxUlVRSDEzQW5XNWtaeU41OUxNbkpqaU0zUnowZVluaml4c2tW?=
 =?gb2312?B?Njk3QkF5YjN3QUphbFEvUHFvSjU1NzdjWHV5TG0zSkNmdGJtSkZzWkU4TGhw?=
 =?gb2312?B?WEZxa3kzMDUzMDhqQUpiRThMa3gvWm1RL1M4UFZaTE5LalJrSUVKYUVQaWpP?=
 =?gb2312?B?K0FrY3JrTWhsWUQySFFiTkFsUUVYazlGblE0OFB4RFRjYUh4RXJMTDB2eUJH?=
 =?gb2312?B?K2xrV0ZnSEhIUmFUZTkyaEdTSzhLY1dma2xFVFJmcjNvcjRRZ0VucWtSdFI0?=
 =?gb2312?B?VmNSeU9DdXdBSzBVTS9VbEVPWUFnR2VEZ0RoQ0wxYzJxSEhhcGwzSnpjYjg0?=
 =?gb2312?B?Nyt2RmhQMnJGbmprVDRNMnNXSUw0dE41dWpSU3hGTDJMS1dLcW9QaW5vQ0xH?=
 =?gb2312?B?b0FIMDhpL293TGUzbGs2L1FoRms2a0VkNVA4WDc3WFJtT3R6TFVJUHF4dC9N?=
 =?gb2312?B?cDJVTkQxRDRjQlQ2TDRaWU1UZGRyamo1YzBCck1xb2sxd3NoQTIxZ2dYaS9v?=
 =?gb2312?B?TEFrR1pSelpiWlBjTUJzQjVTbjczZitncjVYUzhVUUNmS2x5TXBtdStQOUZl?=
 =?gb2312?B?QTZVaFhKVVJDZ2VWZUorN3lzZ01KVEVQRHB1QXVNN0NqR2wxelFvbDBPajg4?=
 =?gb2312?B?OXgyZ1h3S2dQTUUyMGQxaVIvblBoT2NBV2tvNkQ5NWwrQ3d3RUQxS1JlNlMz?=
 =?gb2312?B?cnR2VWZrZy9aRzljVlBieDVJN2ZYSWZOR281TDBBNHczbmFzY0taZmdxWUt2?=
 =?gb2312?B?TDE3ZFBENjNVMnpEYk9VYjZ2YWtnd3dvR01INUZCalhXcTZXZ3UwU09oZ0Uz?=
 =?gb2312?B?K0dPYmJ5SXBudzYrQnRhYjBiK01tc0NvMDZzVTIvS0lVY3E5Wm9KQWlPTTlV?=
 =?gb2312?B?c1NUcDQ2dFRhOFgweU55aGkrd2JYVGdUNGFyWC8zN050KzRaMGJrYUZIb3F6?=
 =?gb2312?B?OWZPL0d0N2o2ekhhNGpxaGRCSWFvMkZPSkU5dVBQVkt1czUvN0d5Q0hSQzIy?=
 =?gb2312?B?aVNiWmR6Q3lFNHZzS3I3cFhIcHpFYi9STSt1Nmk0ZVF5eFNpM2pobkVUZ0Fm?=
 =?gb2312?B?R0d3bGVyc0RrVXJ1cTEzMTF4VFRxa0QzRTVZZFFnbzVqcXFpOFdXakFTeUhv?=
 =?gb2312?B?b2IrT2oyai83R1BYZUlNRUhPajFpRjZIVmtXRFdiSjNGK2s4L1RQY1dkckZZ?=
 =?gb2312?B?YTR6ajFsU28yV2JyQTJiRHdBRlBBRzI1cnN6RnhlYXR1elFGcGhGd0ZQeldH?=
 =?gb2312?B?RlUxbUVHL0orSjA0cXdXM2srWFEwRG0vZWUyOGZyQU5aRkFkTm16L29oaSsw?=
 =?gb2312?B?RWZpZ0pic2loMktFWTJLTmdIY0ptVUFUSTUvUkVsRmpqcXVlYlp3cmlsVDJD?=
 =?gb2312?B?S2krKzMrZWhkRzBFYTNjTzJhcGp1TU1oSGRhZUtIVWI2RGdKTjhpbnBuTnM5?=
 =?gb2312?B?djJSSEgveElxZFQxL0llRi9KcFZGZ1ptYno0eE5UWm95b0kyNWo2SVV0dGN3?=
 =?gb2312?B?V0QvTEJIZHFiUTBPc1Jocyt2VkRqM0NiRnYzN2ZPbmdsbnR0eXZCMGVibFBZ?=
 =?gb2312?B?aEx0dzMvZzNjVkFNYW9aYkJuNEg4b3R6ellwQzVENmkvcTBiT2V2Wm1iNWxV?=
 =?gb2312?B?NEJsOGdsMmZ5Nm5UUTBYMk1EMnhvYmtnTXdlRHRmOVRxNk1HN2pORFBDSE5D?=
 =?gb2312?B?M3FaamYxMUdKcXBwTXdHL1lMVkZHUWtiQndQNjl2WVY3S0E0WU1GSGhrQk1P?=
 =?gb2312?B?SVJKaUNCOURKekZyb244Tmd3eFU3QW5nSzBwak9oK0pnaVo5NkFybE42RTBL?=
 =?gb2312?Q?xtbg=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee8cb06-ad1c-45f3-6289-08dce998b347
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 02:02:03.1562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0OMgMlx13mMaFFQpPFCAQ1C48jtozV6p7wrFTrs1fMgGcN98nlN+ZBt7TMBbuDNt8d5KrPWV3dLgvNrw2ExRMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8865

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNMTqMTDUwjEwyNUgMjM6MjINCj4gVG86IFdlaSBGYW5nIDx3
ZWkuZmFuZ0BueHAuY29tPg0KPiBDYzogZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29v
Z2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBwYWJlbmlAcmVkaGF0LmNvbTsgcm9iaEBrZXJu
ZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IFZsYWRp
bWlyIE9sdGVhbiA8dmxhZGltaXIub2x0ZWFuQG54cC5jb20+OyBDbGF1ZGl1DQo+IE1hbm9pbCA8
Y2xhdWRpdS5tYW5vaWxAbnhwLmNvbT47IENsYXJrIFdhbmcgPHhpYW9uaW5nLndhbmdAbnhwLmNv
bT47DQo+IGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldTsgbGludXhAYXJtbGludXgub3JnLnVr
OyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiBpbXhAbGlzdHMubGludXguZGV2OyBuZXRkZXZAdmdl
ci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIG5ldC1uZXh0IDEwLzExXSBuZXQ6IGVuZXRjOiBhZGQgcHJlbGltaW5hcnkgc3Vw
cG9ydCBmb3INCj4gaS5NWDk1IEVORVRDIFBGDQo+IA0KPiBPbiBUaHUsIE9jdCAxMCwgMjAyNCBh
dCAwNDo1OTo0NUFNICswMDAwLCBXZWkgRmFuZyB3cm90ZToNCj4gPiA+IE9uIFdlZCwgT2N0IDA5
LCAyMDI0IGF0IDA1OjUxOjE1UE0gKzA4MDAsIFdlaSBGYW5nIHdyb3RlOg0KPiA+ID4gPiBUaGUg
aS5NWDk1IEVORVRDIGhhcyBiZWVuIHVwZ3JhZGVkIHRvIHJldmlzaW9uIDQuMSwgd2hpY2ggaXMg
dmVyeQ0KPiA+ID4gPiBkaWZmZXJlbnQgZnJvbSB0aGUgTFMxMDI4QSBFTkVUQyAocmV2aXNpb24g
MS4wKSBleGNlcHQgZm9yIHRoZSBTSQ0KPiA+ID4gPiBwYXJ0LiBUaGVyZWZvcmUsIHRoZSBmc2wt
ZW5ldGMgZHJpdmVyIGlzIGluY29tcGF0aWJsZSB3aXRoIGkuTVg5NQ0KPiA+ID4gPiBFTkVUQyBQ
Ri4gU28gd2UgZGV2ZWxvcGVkIHRoZSBueHAtZW5ldGM0IGRyaXZlciBmb3IgaS5NWDk1IEVORVRD
DQo+ID4gPiAgICAgICAgICAgICBTbyBhZGQgbmV3IG54cC1lbmV0YzQgZHJpdmVyIGZvciBpLk1Y
OTUgRU5FVEMgUEYgd2l0aA0KPiA+ID4gbWFqb3IgcmV2aXNpb24gNC4NCj4gPiA+DQo+ID4gPiA+
IFBGLCBhbmQgdGhpcyBkcml2ZXIgd2lsbCBiZSB1c2VkIHRvIHN1cHBvcnQgdGhlIEVORVRDIFBG
IHdpdGgNCj4gPiA+ID4gbWFqb3IgcmV2aXNpb24gNCBpbiB0aGUgZnV0dXJlLg0KPiA+ID4gPg0K
PiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRj
L2VuZXRjLmgNCj4gPiA+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2VuZXRjL2Vu
ZXRjLmgNCj4gPiA+ID4gaW5kZXggOTc1MjRkZmEyMzRjLi43ZjFlYTExYzMzYTAgMTAwNjQ0DQo+
ID4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0Yy5o
DQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0
Yy5oDQo+ID4gPiA+IEBAIC0xNCw2ICsxNCw3IEBADQo+ID4gPiA+ICAjaW5jbHVkZSA8bmV0L3hk
cC5oPg0KPiA+ID4gPg0KPiA+ID4gPiAgI2luY2x1ZGUgImVuZXRjX2h3LmgiDQo+ID4gPiA+ICsj
aW5jbHVkZSAiZW5ldGM0X2h3LmgiDQo+ID4gPiA+DQo+ID4gPiA+ICAjZGVmaW5lIEVORVRDX1NJ
X0FMSUdOCTMyDQo+ID4gPiA+DQo+ID4gPiA+ICtzdGF0aWMgaW5saW5lIGJvb2wgaXNfZW5ldGNf
cmV2MShzdHJ1Y3QgZW5ldGNfc2kgKnNpKSB7DQo+ID4gPiA+ICsJcmV0dXJuIHNpLT5wZGV2LT5y
ZXZpc2lvbiA9PSBFTkVUQ19SRVYxOyB9DQo+ID4gPiA+ICsNCj4gPiA+ID4gK3N0YXRpYyBpbmxp
bmUgYm9vbCBpc19lbmV0Y19yZXY0KHN0cnVjdCBlbmV0Y19zaSAqc2kpIHsNCj4gPiA+ID4gKwly
ZXR1cm4gc2ktPnBkZXYtPnJldmlzaW9uID09IEVORVRDX1JFVjQ7IH0NCj4gPiA+ID4gKw0KPiA+
ID4NCj4gPiA+IEFjdHVhbGx5LCBJIHN1Z2dlc3QgeW91IGNoZWNrIGZlYXR1cmVzLCBpbnN0ZWFk
IG9mIGNoZWNrIHZlcnNpb24gbnVtYmVyLg0KPiA+ID4NCj4gPiBUaGlzIGlzIG1haW5seSB1c2Vk
IHRvIGRpc3Rpbmd1aXNoIGJldHdlZW4gRU5FVEMgdjEgYW5kIEVORVRDIHY0IGluDQo+ID4gdGhl
IGdlbmVyYWwgaW50ZXJmYWNlcy4gU2VlIGVuZXRjX2V0aHRvb2wuYy4NCj4gDQo+IFN1Z2dlc3Qg
dXNlIGZsYWdzLCBzdWNoIGFzLCBJU19TVVBQT1JUX0VUSFRPT0wuDQo+IA0KPiBvdGhlcndpc2Us
IHlvdXIgY2hlY2sgbWF5IGJlY29tZSBjb21wbGV4IGluIGZ1dHVyZS4NCj4gDQo+IElmIHVzZSBm
bGFncywgeW91IGp1c3QgY2hhbmdlIGlkIHRhYmxlIGluIGZ1dHVyZS4NCg0KZW5ldGNfZXRodG9v
bCBqdXN0IGlzIGFuIGV4YW1wbGUsIEkgbWVhbnQgdGhhdCB0aGUgRU5FVEN2NCBhbmQgRU5FVEN2
MQ0KdXNlIHNvbWUgY29tbW9uIGRyaXZlcnMsIGxpa2UgZW5lY3RfcGZfY29tbW9uLCBlbmV0Yy1j
b3JlLCBzbyBkaWZmZXJlbnQNCmhhcmR3YXJlIHZlcnNpb25zIGhhdmUgZGlmZmVyZW50IGxvZ2lj
LCB0aGF0J3MgYWxsLg0KDQo+IA0KPiB7IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9OWFAyLCBQ
Q0lfREVWSUNFX0lEX05YUDJfRU5FVENfUEYpLA0KPiAgIC5kcml2ZXJfZGF0YSA9IElTX1NVUFBP
UlRfRVRIVE9PTCB8IC4uLi4gfSwNCj4gDQo+IEZyYW5rDQo+ID4NCj4gPiA+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9lbmV0Yy9lbmV0YzRfcGYuYw0KPiA+
ID4gYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGM0X3BmLmMNCj4g
PiA+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiA+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5l
MzhhZGU3NjI2MGINCj4gPiA+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ID4gPiArKysgYi9kcml2ZXJz
L25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZW5ldGMvZW5ldGM0X3BmLmMNCj4gPiA+ID4gQEAgLTAs
MCArMSw3NjEgQEANCj4gPiA+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIu
MCsgT1IgQlNELTMtQ2xhdXNlKQ0KPiA+ID4gPiArLyogQ29weXJpZ2h0IDIwMjQgTlhQICovDQo+
ID4gPiA+ICsjaW5jbHVkZSA8bGludXgvdW5hbGlnbmVkLmg+DQo+ID4gPiA+ICsjaW5jbHVkZSA8
bGludXgvbW9kdWxlLmg+DQo+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgvb2ZfbmV0Lmg+DQo+ID4g
PiA+ICsjaW5jbHVkZSA8bGludXgvb2ZfcGxhdGZvcm0uaD4NCj4gPiA+ID4gKyNpbmNsdWRlIDxs
aW51eC9jbGsuaD4NCj4gPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9waW5jdHJsL2NvbnN1bWVyLmg+
ICNpbmNsdWRlDQo+ID4gPiA+ICs8bGludXgvZnNsL25ldGNfZ2xvYmFsLmg+DQo+ID4gPg0KPiA+
ID4gc29ydCBoZWFkZXJzLg0KPiA+ID4NCj4gPg0KPiA+IFN1cmUNCj4gPg0KPiA+ID4gPiArc3Rh
dGljIGludCBlbmV0YzRfcGZfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsDQo+ID4gPiA+ICsJ
CQkgICBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqZW50KSB7DQo+ID4gPiA+ICsJc3RydWN0
IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gPiA+ID4gKwlzdHJ1Y3QgZW5ldGNfc2kgKnNp
Ow0KPiA+ID4gPiArCXN0cnVjdCBlbmV0Y19wZiAqcGY7DQo+ID4gPiA+ICsJaW50IGVycjsNCj4g
PiA+ID4gKw0KPiA+ID4gPiArCWVyciA9IGVuZXRjX3BjaV9wcm9iZShwZGV2LCBLQlVJTERfTU9E
TkFNRSwgc2l6ZW9mKCpwZikpOw0KPiA+ID4gPiArCWlmIChlcnIpIHsNCj4gPiA+ID4gKwkJZGV2
X2VycihkZXYsICJQQ0llIHByb2JpbmcgZmFpbGVkXG4iKTsNCj4gPiA+ID4gKwkJcmV0dXJuIGVy
cjsNCj4gPiA+DQo+ID4gPiB1c2UgZGV2X2Vycl9wcm9iZSgpDQo+ID4gPg0KPiA+DQo+ID4gT2th
eQ0KPiA+DQo+ID4gPiA+ICsJfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICsJLyogc2kgaXMgdGhlIHBy
aXZhdGUgZGF0YS4gKi8NCj4gPiA+ID4gKwlzaSA9IHBjaV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4g
PiA+ID4gKwlpZiAoIXNpLT5ody5wb3J0IHx8ICFzaS0+aHcuZ2xvYmFsKSB7DQo+ID4gPiA+ICsJ
CWVyciA9IC1FTk9ERVY7DQo+ID4gPiA+ICsJCWRldl9lcnIoZGV2LCAiQ291bGRuJ3QgbWFwIFBG
IG9ubHkgc3BhY2UhXG4iKTsNCj4gPiA+ID4gKwkJZ290byBlcnJfZW5ldGNfcGNpX3Byb2JlOw0K
PiA+ID4gPiArCX0NCj4gPiA+ID4gKw0KPiA+ID4gPiArCWVyciA9IGVuZXRjNF9wZl9zdHJ1Y3Rf
aW5pdChzaSk7DQo+ID4gPiA+ICsJaWYgKGVycikNCj4gPiA+ID4gKwkJZ290byBlcnJfcGZfc3Ry
dWN0X2luaXQ7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlwZiA9IGVuZXRjX3NpX3ByaXYoc2kpOw0K
PiA+ID4gPiArCWVyciA9IGVuZXRjNF9wZl9pbml0KHBmKTsNCj4gPiA+ID4gKwlpZiAoZXJyKQ0K
PiA+ID4gPiArCQlnb3RvIGVycl9wZl9pbml0Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsJcGluY3Ry
bF9wbV9zZWxlY3RfZGVmYXVsdF9zdGF0ZShkZXYpOw0KPiA+ID4gPiArCWVuZXRjX2dldF9zaV9j
YXBzKHNpKTsNCj4gPiA+ID4gKwllcnIgPSBlbmV0YzRfcGZfbmV0ZGV2X2NyZWF0ZShzaSk7DQo+
ID4gPiA+ICsJaWYgKGVycikNCj4gPiA+ID4gKwkJZ290byBlcnJfbmV0ZGV2X2NyZWF0ZTsNCj4g
PiA+ID4gKw0KPiA+ID4gPiArCXJldHVybiAwOw0KPiA+ID4gPiArDQo+ID4gPiA+ICtlcnJfbmV0
ZGV2X2NyZWF0ZToNCj4gPiA+ID4gK2Vycl9wZl9pbml0Og0KPiA+ID4gPiArZXJyX3BmX3N0cnVj
dF9pbml0Og0KPiA+ID4gPiArZXJyX2VuZXRjX3BjaV9wcm9iZToNCj4gPiA+ID4gKwllbmV0Y19w
Y2lfcmVtb3ZlKHBkZXYpOw0KPiA+ID4NCj4gPiA+IHlvdSBjYW4gdXNlIGRldm1fYWRkX2FjdGlv
bl9vcl9yZXNldCgpIHRvIHJlbW92ZSB0aGVzZSBnb3RvIGxhYmVscy4NCj4gPiA+DQo+ID4gU3Vi
c2VxdWVudCBwYXRjaGVzIHdpbGwgaGF2ZSBjb3JyZXNwb25kaW5nIHByb2Nlc3NpbmcgZm9yIHRo
ZXNlDQo+ID4gbGFiZWxzLCBzbyBJIGRvbid0IHdhbnQgdG8gYWRkIHRvbyBtYW55IGRldm1fYWRk
X2FjdGlvbl9vcl9yZXNldCAoKS4NCg==

