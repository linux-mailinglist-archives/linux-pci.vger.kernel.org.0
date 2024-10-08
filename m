Return-Path: <linux-pci+bounces-13991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5689942B7
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 10:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08B928779F
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 08:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2871E008B;
	Tue,  8 Oct 2024 08:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="it7yxh4g"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012047.outbound.protection.outlook.com [52.101.66.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538E21E009D;
	Tue,  8 Oct 2024 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728375940; cv=fail; b=hImyeWyNQhiF8tA2i1+xwCN/E+72iHmsDGuy/jUjq3NWUaFQGmj3p28/sdJ6L0C03dLIHAO1gO/38jPBmyX+T9zEeKfHwUUoz1GFugkx+a9Jd9GC/AdARL4b5Q9XHud11zGdQ8om8T+wNOfvH0K+9QSa2g0bArW1D52yGmSls00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728375940; c=relaxed/simple;
	bh=3oGnaE3mto8g/0f3Z8np3e5mjVWbHD10ZLVR86J9XqQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WdT47UCtxnrr3zPowmIHBMnXTFczAWjaJZjBn1TXwqB+fC98yU3R73ughktbpuUcayg895iSr0EqEGego2/ZP/YSABbO0KBR79vC9ilf/w2IE3BxIOK6y56OBDoDe+b5ZmrPeQlZbI7GFZQrH7JQ3sXtlv43TTUO7DsH+9B0kCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=it7yxh4g; arc=fail smtp.client-ip=52.101.66.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5a+PC8yECsseJeAAmbrzxsTLBzwlfFCRh/dez6LV283ZNCK+SqHLVV8yMVRKroQ8imN+6wFw74YQLr/YhipbZMzWw+J58fkA5VjfoRCGxcR+TDjGE4E6TuGZ+tljpjHfl+30o+YzCEz4OCQogPeyRy4IMs4Xdg0Hp1cIDMyZjUsnxy8Pj++9AGqLpeQMva1W/nberqNqBlzu2bCQ7+rYwPBnvdXUe127KxGTFZ56xDFzN7/BigSEtEfsSKdT2SOfAzIjEv0Aztx//jQ2NFce+k137j2mr5lHWIoBWkpz7pvG0bex/zFpKns0CEp/Hhh5irWD9ywAGckbsExLahR8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oGnaE3mto8g/0f3Z8np3e5mjVWbHD10ZLVR86J9XqQ=;
 b=jJlsHv+J7Sdexv25qRXUjhWb1lezdpTogzBdsuZyKhgQuhY371JVNHhoDj/3PN1sMLLgUwH/5CDL+SH6Gi8SZiIu81iwmuIz121AS5JfOZvMpIWqp95pSCf1USY+darMGkxslG9hsrjmNW9EuPDDcVKuEfpl3/L2nNaAtDqeyJhWX1GP9SCxedfkkOn0Hc0HniwfXJlX3DrOya6UmAOzqNyF0NPfHaHAOd74uCgVe8p4r9ObC5ooK4xDbQ0o2TD4ubbyFNY7zn3bC9eff5XwcDF12qj26MtgLzRzdf9YkaLBGmsWBldelhgoStYRc9VpRhKTWB4L6Rq2qF4A5Fe18A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oGnaE3mto8g/0f3Z8np3e5mjVWbHD10ZLVR86J9XqQ=;
 b=it7yxh4gSg8m0YT9peHE3Me4Gbm5/hmeE/0udUlwUkbAMropAyW2vCdySpvCopiPJlikf1dLmZxGwfM5D6T9Lxpya3vVYrHML0fWI7F0LNw8FMHhlQgkvMs7A9Yqt5RLPCkDP3Jsv/52U4oUkHlyNmqLoVeJD3m6FjsodSFEKUPawrsJoU/YMR17yIMFKvD7pAJw8u/gxQY7JWLUJWXUSd3/c9I+oDNkTCT90CfdpESgFxQx8WXyB8gGU5/9wVFl99ax4RoK5rz4E0igNiTnYrWDWKiJ0cBZ/p3dJ4Buh0kUmPtvq9MTjW91YvTCN5ham11I48iTI7cvUERzZq8oMg==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 08:25:32 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 08:25:32 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: "jingoohan1@gmail.com" <jingoohan1@gmail.com>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, Frank Li <frank.li@nxp.com>,
	"robh@kernel.org" <robh@kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v1 1/2] PCI: dwc: Fix resume failure if no EP is connected
 on some platforms
Thread-Topic: [PATCH v1 1/2] PCI: dwc: Fix resume failure if no EP is
 connected on some platforms
Thread-Index: AQHbDxG7OBg57RuiskaTk2XLb7UfNLJ0lgmAgAf2FoA=
Date: Tue, 8 Oct 2024 08:25:32 +0000
Message-ID:
 <AS8PR04MB8676495DB585E7F2C9F6659B8C7E2@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1727243317-15729-1-git-send-email-hongxing.zhu@nxp.com>
 <1727243317-15729-2-git-send-email-hongxing.zhu@nxp.com>
 <20241003060421.lartgrmpabw2noqg@thinkpad>
In-Reply-To: <20241003060421.lartgrmpabw2noqg@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DU0PR04MB9496:EE_
x-ms-office365-filtering-correlation-id: de2d57c5-c350-4ee7-eacf-08dce772c664
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N2pkSjE4bmJKVFdzb1JRQlNOeVdQa1drRDM0ZDRwdTdCYmczaEJIK1hZMGhq?=
 =?utf-8?B?VE91NDYray9lYlpaK1JZWlV3R3BVdmFxeXJTeFNxQUF6SFlidCtsTTQ1WVUy?=
 =?utf-8?B?UzVVcmR0MXJZOWw4S2tXc20wV3NYY3IxcUcrY2dBdlA1dU1Qa1FsMTBZWE9u?=
 =?utf-8?B?eWNHRUxLRVNMdHoxZ0dENXJHcExNejRnL293MGt3K0hLN2FyNU5lMWFSSENL?=
 =?utf-8?B?bldPdFBYakVtaG1XemdOZkl0Zm0vUWo4cE5pN054Tlh1dUUzamg2RGlxZ05N?=
 =?utf-8?B?V1NLbFVuczNpMFByZnRtUDlaTWxOVi9Xd3o2cmdMM2VhaXpBMVRFM3RGL2pF?=
 =?utf-8?B?ZFBxWGxQWGx1eGtXWGFkU0JZaE5WNjlQTjFydmxCem50dFY1dytyVGE1cFJK?=
 =?utf-8?B?bDBrWVlSNDRhR2lHZ09Sb0tFOTl5N1dHOGN4cEpsMDFFbUp3TmoyYkZwVnhX?=
 =?utf-8?B?UTZPVld2Z015S2lFRWtxVFlHdkRRMmVvVUtDcG5NZHV5TUhQdUZ2RnJWMkRp?=
 =?utf-8?B?dzBQcUxjNkhDMURFbTN4UEJydzYzTjAyTGF1T1ZPZnhuc0xsOUhlMGJycVZj?=
 =?utf-8?B?OGdDMDB6Y0dIK3Nrajh6UjlVZEVjaHB5bHphblVSdTB2aG00NGxpMHNuMXVR?=
 =?utf-8?B?WGtmSUt2K05xSGoxclgxT1gwZGhCRjlxUEFWWGFtQTc3NDhFZEFDUFhyMWp0?=
 =?utf-8?B?WldVSjh6MTJrb0xNanlaWmY5ZjR1eFJBbDBKeDRQell5NmZGbFZYbVArRkhz?=
 =?utf-8?B?VmNXVmhLbDJuMjU3MzBqbTNHS1hoSlZGdVR0RWJKcFEzYUVNWldNVG45NW53?=
 =?utf-8?B?QlNoNHhxeEJBWjVhczBHWVlVMnRvQkRVSDI4UzlkeGFjckRJRUtxSkc4ZVRx?=
 =?utf-8?B?ZWV4YjdOYUMwY2IyeGJzZkdVK21sZFFuYkMzYllsd0U1azJld1lYcHBac2NB?=
 =?utf-8?B?d0txUG51M2dsOFBGY3pldFFWZGVlT1pwaElSOUI1cCtQcnF6ZFlMVGRuRGtC?=
 =?utf-8?B?U1puYTNzVEIvT1VCQTRkU1JwMk9TL1ZYWVEvVGlLcWxYRHNaZy9wbVo3ZXNN?=
 =?utf-8?B?Y0IzVjNMWExuZWJnT3NTYkgrdll6Z2dqV0ZtYVVmaWJlaDA2ZGY4RVZqWCtw?=
 =?utf-8?B?aSs2OEFVV1lTcEs1ZG95c3J1dUl1ZDVWclN4S1ZMT21NQmhyQjZNWEd4VTFP?=
 =?utf-8?B?Rm1IZnVKeUJPQXIzbmZBdDFIaDd4Wk1OblhvNDdCSmRXc2F6VHVWL3l0RVNZ?=
 =?utf-8?B?SGlPb09FUFpIQ05DeGNwN3k3UWtuNVA4V1BoQ3h0dDk1cDRTd0lQMzFzZGcw?=
 =?utf-8?B?WHgwK1loclFSOVVaU3VyWjhVZFRramtaM2VUWjl4VDVBUGpkSFFjWENWeWJr?=
 =?utf-8?B?S3ZnYkZJWjdmUllpVDQ3WUtYL29GSEdCblVwVHZWcnEyRG5manlXRGFKWWVG?=
 =?utf-8?B?V09xa2E2Z3RiRVAzMlJoTjJiWHFEbWEzRlJNMmVWNjZtOXNQR01GMEtnN0lF?=
 =?utf-8?B?QWhMT1MzaEJNR3A3Yi9ja3ppTC8xM25ET1Ezb3hYK0NMdWEycGRneVFEM3dF?=
 =?utf-8?B?UHJHWDhxdjFobk5zUkFrNUJzVFp1OVE3Wk9wU3ZkVlZPa0lxOWhvUmFDRGFJ?=
 =?utf-8?B?aFJ0MmpPcTM0Y0ZoN0VHMUxTcVkzeG82bTZINkRoVy9Zc3ZiMlF1cnpMTC9r?=
 =?utf-8?B?N2FPQXpvbGFyL2gwSDNybGJFbVBtb3oycWxUa0lrdlpaYno0UEVxNVN2QVRL?=
 =?utf-8?B?NFQ1M24wWHREaEdjV3Y1SVFQUmpaYmpRa3RCNUxNVTA0OUdoZEo2UGM5SzlV?=
 =?utf-8?B?aGJ4anVpMlJXOFpGR3hFQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UklpNmRvK1h3aTlpN3ZMMlQ3OEpuT25PTWNlRTlWa2ZVbElwUXR2NTZTMWh4?=
 =?utf-8?B?blV4L29jclhPclRpaTJGUHpuZ0phL3IrMkxHYnJsakNIbmhrVW13M3dra0RU?=
 =?utf-8?B?R2xNVzRsdHoxYTg0dS9CQk1jQ25XajYxdlZJOTlFODlUWlBHZFh3YTdDUFdB?=
 =?utf-8?B?aGZzbzMxbHh3dW9KdGRUNTJ2MEJNenVTeEV5SlRCM3UxSUsrNXptSzZKaHNr?=
 =?utf-8?B?aVNMTmp3S1BpNFkrOFY5UXArb0NEVXVmSXZvaDhTR2JxdjdvTHh5S0FpWnJK?=
 =?utf-8?B?YzdJdUh3cG1oT01iMGZvTklEZmhSMlBWaDlZYVJpZlBKMzhrQkIwa0VMZjYr?=
 =?utf-8?B?SDFRMUw1dWRxNnRWdmFJeUpyQ2F5TUZBRlpudVYvY0g1dTZneXZKRWVjTnE3?=
 =?utf-8?B?K1V0MmpzMXlBNzVVOCs2Snc5dDVZK1VEeXJSQW5aRlhvSUJ3VFVhYUl4V2E0?=
 =?utf-8?B?aU5NVXg3ZEVWQmlPTmxadVpWalBwQlg1TTBVL1FtREM4V2gxRHc3cVQyS1N4?=
 =?utf-8?B?NnA4NTRCZXpycnBuNGY1akQ5UGNlK0I3d2xjdUJvTHZ6dE92VXlXM01EZW5o?=
 =?utf-8?B?eTBiRmMzcFV1ZUJaOUZieGlBa0h0OTFwcHNNRGI5MXBCY1VEOUx4YjVkLzZz?=
 =?utf-8?B?eTZiaGtscmdLdEs0VFNXeXVGTnJia2JDY2ZuZXV1a0g4YnJWZHY4WWxabTZF?=
 =?utf-8?B?cVYwQ2FhdW5hcjNsYmF6WS9ZSmxmcEpVOGJHU0V6OVdoQmVwY3ZLdGFRc1BR?=
 =?utf-8?B?Y05SU3hIdThYZm5meFdvcUVYaTdIV1hXRThHMG9FbE8wK0h5d0ZoalNaaDJI?=
 =?utf-8?B?RGl0aENjR3FtTkxydE4ydnNVMWdTS0NTUDcydi9ET1BlajBUMDMzOFZROGRs?=
 =?utf-8?B?OGdsS1NhdE9Cblhqc3lnZzdyajZESk9yTTY5YnF1YTZPUTNsZkUyTmJldWNs?=
 =?utf-8?B?K1V0cGRoWDVwU0w3SWdvZUd1M2JITHlyZks1VWVJUkpHb2lteDBtd2xmM0U1?=
 =?utf-8?B?TXF0aktqL1dVaHgwNWlaNXhrNzJibE04aUdDY1RCUGFJYmx3SDJXM2dROSsz?=
 =?utf-8?B?Q0t6MmxtNVdQZUs3d2R4L215dDNNUWxBZ3R6RGVTZTV4RXZzSjBJS0doTExV?=
 =?utf-8?B?ZmxTaXR0ODh6U1dMUTczL01HZ052OWRiR3ZDUVdZRU9WNkhOMHZNdmdObVFJ?=
 =?utf-8?B?blNsU29YZzJLdmdXVU5Ndjl1VEtmTkJtbStyWTJvSE54UEhxbTJPUVRQaitx?=
 =?utf-8?B?OGRnMXQ5cTBwYnEzdGFqb01hdS9VVndNbWc1Mmg2UG9rRmVzQmdGZit6RE9s?=
 =?utf-8?B?VVFQUlYyVjFMam9jWFMvR2xHRXcvR2h4ajdpaUNQakFqVGZUYUdKY1cyRGVH?=
 =?utf-8?B?WmR4Ry9iR0wzTllaRXlEVlVGZU5OSy80UlZWYnVnSHYzN2h6Mzc5ZWI4ZzNR?=
 =?utf-8?B?dGVpVExCTGFoRlY2RC9Lcnl1b1VrV0RzY3NKN0hxSG5CbXZ1K2pzSEhVekZj?=
 =?utf-8?B?Q1RxM2VtVk8yTWJxbnlybHExajFFUU01bnNrazFWSC81ektxWWpyMXdMQk4z?=
 =?utf-8?B?cG9WaW1ST2N0NENEbUNodzkwNkVtRFVwUHE5elpyOW9mc21Zcmd3RU1rT25B?=
 =?utf-8?B?aHV0MGszVjZMQUp3UWY2MjZtTHhrWEtpUHdqSWk0bkZQYWhqamw1TFlrWnc2?=
 =?utf-8?B?V1RxK3JqSjc5V0tTV083d1E3ZTdDM2EyTjJSTGFGN25xQXgxSGd0ZHppUjBy?=
 =?utf-8?B?Y0p2K1JCNkJPWVNqWmJiK09Od3p6Ykl2WW8ra3dmcW5CN0ZvUC9OcUdTQTQ5?=
 =?utf-8?B?ME11ZDdjZW0wRU82QXBjTC9CK09iamY3TFVRU3lUbHNVUmNhOFVmK2pobXZj?=
 =?utf-8?B?dGhhVFRNWlBCYUxVZmEveTZhbWNpN1VNZGpyTGhUVG1sRG0xT2xFM3lzVDFs?=
 =?utf-8?B?aFFrWDQxQlB2Znk2dmg4UzhXMGx6Y1p2cm9Lc0NVQVNnOWhqTVRYeEZ2Tno3?=
 =?utf-8?B?VkM4bTZlMVNVUmpnL29RandpL3RPUVI5eDhJVjNnV25VQUt1R2VkY2dwSEE1?=
 =?utf-8?B?Zm1Yc2s3TGtJWm9FWGp5a2NGeXN6OVFIYmp2Yk0zV3BKTUZVcmM2OGtiVzZI?=
 =?utf-8?Q?bKJWq7O8AgpiHmVh4tKMFNydx?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: de2d57c5-c350-4ee7-eacf-08dce772c664
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 08:25:32.0340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l7ZRPBAy9fNLXTTVq079R/yrlxA7cnZcFPu/YFXo/DtntVDL0c023ebsXVPFQTfBG+fTD2O/ZzO9WTeiiuYrYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9496

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDI05bm0MTDm
nIgz5pelIDE0OjA0DQo+IFRvOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0K
PiBDYzogamluZ29vaGFuMUBnbWFpbC5jb207IGt3aWxjenluc2tpQGtlcm5lbC5vcmc7IGJoZWxn
YWFzQGdvb2dsZS5jb207DQo+IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsgRnJhbmsgTGkgPGZyYW5r
LmxpQG54cC5jb20+OyByb2JoQGtlcm5lbC5vcmc7DQo+IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXYNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MSAxLzJdIFBDSTogZHdjOiBGaXggcmVzdW1lIGZhaWx1cmUg
aWYgbm8gRVAgaXMgY29ubmVjdGVkIG9uDQo+IHNvbWUgcGxhdGZvcm1zDQo+IA0KPiBPbiBXZWQs
IFNlcCAyNSwgMjAyNCBhdCAwMTo0ODozNlBNICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4g
PiBUaGUgZHdfcGNpZV9zdXNwZW5kX25vaXJxKCkgZnVuY3Rpb24gY3VycmVudGx5IHJldHVybnMg
c3VjY2Vzcw0KPiA+IGRpcmVjdGx5IGlmIG5vIGVuZHBvaW50IChFUCkgZGV2aWNlIGlzIGNvbm5l
Y3RlZC4gSG93ZXZlciwgb24gc29tZQ0KPiA+IHBsYXRmb3JtcywgcG93ZXIgbG9zcyBvY2N1cnMg
ZHVyaW5nIHN1c3BlbmQsIGNhdXNpbmcgZHdfcmVzdW1lKCkgdG8gZG8NCj4gbm90aGluZyBpbiB0
aGlzIGNhc2UuDQo+ID4gVGhpcyByZXN1bHRzIGluIGEgc3lzdGVtIGhhbHQgYmVjYXVzZSB0aGUg
RFdDIGNvbnRyb2xsZXIgaXMgbm90DQo+ID4gaW5pdGlhbGl6ZWQgYWZ0ZXIgcG93ZXItb24gZHVy
aW5nIHJlc3VtZS4NCj4gPg0KPiA+IENoYW5nZSBjYWxsIHRvIGRlaW5pdCgpIGluIHN1c3BlbmQg
YW5kIGluaXQoKSBhdCByZXN1bWUgcmVnYXJkbGVzcyBvZg0KPiANCj4gcy9DaGFuZ2UgY2FsbCB0
by9DYWxsDQo+IA0KPiA+IHdoZXRoZXIgdGhlcmUgYXJlIEVQIGRldmljZSBjb25uZWN0aW9ucyBv
ciBub3QuIEl0IGlzIG5vdCBoYXJtZnVsIHRvDQo+ID4gcGVyZm9ybSBkZWluaXQoKSBhbmQgaW5p
dCgpIGFnYWluIGZvciB0aGUgbm8gcG93ZXItb2ZmIGNhc2UsIGFuZCBpdA0KPiA+IGtlZXBzIHRo
ZSBjb2RlIHNpbXBsZSBhbmQgY29uc2lzdGVudCBpbiBsb2dpYy4NCj4gPg0KPiA+IEZpeGVzOiA0
Nzc0ZmFmODU0ZjUgKCJQQ0k6IGR3YzogSW1wbGVtZW50IGdlbmVyaWMgc3VzcGVuZC9yZXN1bWUN
Cj4gPiBmdW5jdGlvbmFsaXR5IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9u
Z3hpbmcuemh1QG54cC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBu
eHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdu
d2FyZS1ob3N0LmMgfCAzMA0KPiA+ICsrKysrKysrKy0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMN
Cj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMN
Cj4gPiBpbmRleCBhMDgyMmQ1MzcxYmMuLmNiOGMzYzJiY2M3OSAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQo+ID4gKysr
IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+
IEBAIC05MzMsMjMgKzkzMywyMyBAQCBpbnQgZHdfcGNpZV9zdXNwZW5kX25vaXJxKHN0cnVjdCBk
d19wY2llICpwY2kpDQo+ID4gIAlpZiAoZHdfcGNpZV9yZWFkd19kYmkocGNpLCBvZmZzZXQgKyBQ
Q0lfRVhQX0xOS0NUTCkgJg0KPiBQQ0lfRVhQX0xOS0NUTF9BU1BNX0wxKQ0KPiA+ICAJCXJldHVy
biAwOw0KPiA+DQo+IA0KPiBUaGVyZSBpcyBvbmUgbW9yZSBjb25kaXRpb24gYWJvdmUuIEl0IGNo
ZWNrcyB3aGV0aGVyIHRoZSBsaW5rIGlzIGluIEwxc3Mgc3RhdGUgb3INCj4gbm90IGFuZCBpZiBp
dCBpcywgdGhlIGp1c3QgcmV0dXJucyAwLiBHb2luZyBieSB5b3VyIGNhc2UsIGlmIHRoZSBwb3dl
ciBnb2VzIG9mZiBkdXJpbmcNCj4gc3VzcGVuZCwgdGhlbiBpdCB3aWxsIGJlIGFuIGlzc3VlLCBy
aWdodD8NCj4gDQpIaSBNYW5pdmFubmFuOg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KWWVz
LCB5b3UncmUgcmlnaHQuIEl0J3MgYSBwcm9ibGVtIHRoYXQgcG93ZXIgaXMgb2ZmIGluIHN1c3Bl
bmQgd2hlbiBsaW5rDQogaXMgaW4gTDFzcy4NCkhvdyBhYm91dCB0byBpc3N1ZSBhbm90aGVyIHBh
dGNoIHRvIGZpeCB0aGlzIHByb2JsZW0/DQpTaW5jZSB0aGlzIGNvbW1pdCBpcyB2ZXJpZmllZCB0
byBmaXggdGhlIHJlc3VtZSBmYWlsdXJlIHdoZW4gbm8gRVAgaXMNCiBjb25uZWN0ZWQuIEknbSBu
b3Qgc3VyZSBJIGNhbiBjb21iaW5lIHRoZW0gdG9nZXRoZXIgb3Igbm90Lg0KDQpCZXN0IFJlZ2Fy
ZHMNClJpY2hhcmQgWmh1DQo+ID4gLQlpZiAoZHdfcGNpZV9nZXRfbHRzc20ocGNpKSA8PSBEV19Q
Q0lFX0xUU1NNX0RFVEVDVF9BQ1QpDQo+ID4gLQkJcmV0dXJuIDA7DQo+ID4gLQ0KPiA+IC0JaWYg
KHBjaS0+cHAub3BzLT5wbWVfdHVybl9vZmYpDQo+ID4gLQkJcGNpLT5wcC5vcHMtPnBtZV90dXJu
X29mZigmcGNpLT5wcCk7DQo+ID4gLQllbHNlDQo+ID4gLQkJcmV0ID0gZHdfcGNpZV9wbWVfdHVy
bl9vZmYocGNpKTsNCj4gPiArCWlmIChkd19wY2llX2dldF9sdHNzbShwY2kpID4gRFdfUENJRV9M
VFNTTV9ERVRFQ1RfQUNUKSB7DQo+ID4gKwkJLyogT25seSBzZW5kIG91dCBQTUVfVFVSTl9PRkYg
d2hlbiBQQ0lFIGxpbmsgaXMgdXAgKi8NCj4gDQo+IE1vdmUgdGhpcyBjb21tZW50IGFib3ZlIHRo
ZSAnaWYnIGNvbmRpdGlvbi4NCj4gDQo+IC0gTWFuaQ0KPiANCj4gPiArCQlpZiAocGNpLT5wcC5v
cHMtPnBtZV90dXJuX29mZikNCj4gPiArCQkJcGNpLT5wcC5vcHMtPnBtZV90dXJuX29mZigmcGNp
LT5wcCk7DQo+ID4gKwkJZWxzZQ0KPiA+ICsJCQlyZXQgPSBkd19wY2llX3BtZV90dXJuX29mZihw
Y2kpOw0KPiA+DQo+ID4gLQlpZiAocmV0KQ0KPiA+IC0JCXJldHVybiByZXQ7DQo+ID4gKwkJaWYg
KHJldCkNCj4gPiArCQkJcmV0dXJuIHJldDsNCj4gPg0KPiA+IC0JcmV0ID0gcmVhZF9wb2xsX3Rp
bWVvdXQoZHdfcGNpZV9nZXRfbHRzc20sIHZhbCwgdmFsID09DQo+IERXX1BDSUVfTFRTU01fTDJf
SURMRSwNCj4gPiAtCQkJCVBDSUVfUE1FX1RPX0wyX1RJTUVPVVRfVVMvMTAsDQo+ID4gLQkJCQlQ
Q0lFX1BNRV9UT19MMl9USU1FT1VUX1VTLCBmYWxzZSwgcGNpKTsNCj4gPiAtCWlmIChyZXQpIHsN
Cj4gPiAtCQlkZXZfZXJyKHBjaS0+ZGV2LCAiVGltZW91dCB3YWl0aW5nIGZvciBMMiBlbnRyeSEg
TFRTU006IDB4JXhcbiIsDQo+IHZhbCk7DQo+ID4gLQkJcmV0dXJuIHJldDsNCj4gPiArCQlyZXQg
PSByZWFkX3BvbGxfdGltZW91dChkd19wY2llX2dldF9sdHNzbSwgdmFsLCB2YWwgPT0NCj4gRFdf
UENJRV9MVFNTTV9MMl9JRExFLA0KPiA+ICsJCQkJCVBDSUVfUE1FX1RPX0wyX1RJTUVPVVRfVVMv
MTAsDQo+ID4gKwkJCQkJUENJRV9QTUVfVE9fTDJfVElNRU9VVF9VUywgZmFsc2UsIHBjaSk7DQo+
ID4gKwkJaWYgKHJldCkgew0KPiA+ICsJCQlkZXZfZXJyKHBjaS0+ZGV2LCAiVGltZW91dCB3YWl0
aW5nIGZvciBMMiBlbnRyeSEgTFRTU006IDB4JXhcbiIsDQo+IHZhbCk7DQo+ID4gKwkJCXJldHVy
biByZXQ7DQo+ID4gKwkJfQ0KPiA+ICAJfQ0KPiA+DQo+ID4gIAlpZiAocGNpLT5wcC5vcHMtPmRl
aW5pdCkNCj4gPiAtLQ0KPiA+IDIuMzcuMQ0KPiA+DQo+IA0KPiAtLQ0KPiDgrq7grqPgrr/grrXg
rqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+NDQo=

