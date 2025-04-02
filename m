Return-Path: <linux-pci+bounces-25124-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BACA788F3
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 09:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369FF1891581
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 07:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C56423237F;
	Wed,  2 Apr 2025 07:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MeyPglSa"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013052.outbound.protection.outlook.com [52.101.72.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169FC233711;
	Wed,  2 Apr 2025 07:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743579647; cv=fail; b=jSC2NRKMuEcybuSUmoxSU3X/izQBAaNi5wcqEYzr/Kr3wjUJQuheDzo44aRnDoyx3QxXkitEEYc45SgXJSK0fVvl+3bZjZkmty0gqVW0ve6r+VHKOwPKTzh/Y7ne+mqe0t2yBnYH1PUewBPH15z4baaLzCUSpXgEPdr6JejQ91Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743579647; c=relaxed/simple;
	bh=vFGyHiNCUdacXy0R7VAi221njR4JFR4UJ4sgT4Y0T7w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZgEWLR2sfY9bl0ff32Khm11hEv5CrYWOqvH7ZBs3Ww6fyjh+mQ0w349nTdefRmp9u1LPoIKbUUFT9YsIG2OzpqR4ELGgUKTD/dMNI1wnyxVeyXZHIlgA1pLnNX/QU6k2hU9UgR7aZhjs4E2TKhXkrhaNUQ0LnLKK+snafpdWvYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MeyPglSa; arc=fail smtp.client-ip=52.101.72.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0Hf2JEFtEinVVWrLYr0LNkEmOb8S14KkDFrLF9bYFIlwwkPl5o0VHLdtZSdYonjdesghCobw3JRw2fyY6GUNMVzZbs9AO27aLAW8U6XG2jU7214iYLO/b8WLK8tR9Km3e73YrM/LRi9rum9wvNZ5bcoiDBGXfSWburtzNq9VlJ/JMaMwcuTB++2/QGJbbn3MOcyGdygFNG+OQi3CgLq64FoNkdPLZ+HSAgVkxYsz455v8pu3qivwtAwhXA4wqwXgw7TnVf3RRfK5bjTYRvTAOeENFbyYCwFujZId23gq/Hzh1WDT1j4Naiq03zW/gazYOKMdDOPvoeUMsV+HPg44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFGyHiNCUdacXy0R7VAi221njR4JFR4UJ4sgT4Y0T7w=;
 b=VuypxObEzF/xP3nE6fA6ZcpLGwxCsT2lqrVxJw6nI0WqN3B3y6X9PLB3xcyYrD7gYEt+N3Qs8ZD1swWKZ+Aatpj5Q3lMJV3AzOopvuwFkkXtAuNLiGrJjXXJcL/dJO2unOrJ0B2sSjD8nioZ07P3cevhUj8WVldSgBRtOYSHfXt7U90sUv4MAHB0u6rIVwCOsKcBtqfkTM5QX7ffpvVn6QJ4iPMR3VOJCx/Bn8rAQxYfnJTs5P37adUyeZZwLeg4+X2Jx0r6zbpMKQ6cmfzAFtiU6pk+C4hnzjraxP2lmE7hefDjbygEBNOQ5ITAmbv3GTSWbv06sKUwo3XE69SBrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFGyHiNCUdacXy0R7VAi221njR4JFR4UJ4sgT4Y0T7w=;
 b=MeyPglSakaW0v76TRlhIU3cWDKcu69KSJC0k4LWTi3pVDMsQPo9CZQDIJKzj+rjzQw6TdWHIoTL0VzHyKdGOs6Z96zi502jJIBKJRtLTvjvwE344c12dM10agbGsbEz5zi5adlx+G1TouzOXdlpAR07f8gjqflAWcYhnJqS8J6NljxJeqAUvsBHt6K5QNVDGLfLE88F65JWgeGxTq0jreEiSgtXpbGQnItR68El3bjVfTGmtTF1zqyQDyJFbaEdt7JR8/F6JDWbodYXkOeLKJPsEbuse7x3cGiMIt8Y92z/9Myn8ryKoBA9O0gJBaQt+J2OEln5c28/wkr5UMGzdlg==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by GV1PR04MB10775.eurprd04.prod.outlook.com (2603:10a6:150:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Wed, 2 Apr
 2025 07:40:41 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8583.041; Wed, 2 Apr 2025
 07:40:41 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 6/6] PCI: imx6: Save and restore the LUT setting for
 i.MX95 PCIe
Thread-Topic: [PATCH v3 6/6] PCI: imx6: Save and restore the LUT setting for
 i.MX95 PCIe
Thread-Index: AQHbn44MD8AkEJhnmkipfMG9a63ox7OP/g2AgAAAgAA=
Date: Wed, 2 Apr 2025 07:40:41 +0000
Message-ID:
 <AS8PR04MB8676CBDB399711DB1BFE363E8CAF2@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
 <20250328030213.1650990-7-hongxing.zhu@nxp.com>
 <ifq673ok4bel3qe2rsaiblmhnsfbevogrvgnuceewkq6vi6625@7ug7d64bvizc>
In-Reply-To: <ifq673ok4bel3qe2rsaiblmhnsfbevogrvgnuceewkq6vi6625@7ug7d64bvizc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|GV1PR04MB10775:EE_
x-ms-office365-filtering-correlation-id: 379fb710-679d-43c1-8597-08dd71b9ab3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NmcvdktRVVZrb2Z4NE5NYmFic3F1T200QmJYam9xdVlZR2RpY1lLb1V1TmhZ?=
 =?utf-8?B?ditFM0FBZC9pVHJobHZmaC9sU1dWV1hDZFpnWGZjNytLMXVJRjRCUldla2lp?=
 =?utf-8?B?a3JEbUh4enAwLzczLzJzamc5SGpjMWFFQVEzZktkOGFMdmVmeE85dEZsenlz?=
 =?utf-8?B?OFYvU1FPdlo4Sm5GVldhMXRENTNueXRJeUJFa2owVzg3WVBXVjZ4VGhJM29y?=
 =?utf-8?B?T0g3Qldta3QvRzcyTnZpVUhlRXdSRnllZHBZQ0hQUDRONXY2eWVuYnBQUEpW?=
 =?utf-8?B?UHBhTGp1OUZIYmJPdzhVd3Q2UUY3QkJYbkpjS2pDMlAvdDhISXB6RDYxYTRm?=
 =?utf-8?B?NGxvVTUzcWlDU3lQNncwWmJFOVJkWUlmaUlyc3Jkd2pqLzBUQVpPSGY0R3Rz?=
 =?utf-8?B?c2hEUVNSQUQ1TXBGaml5aFFub3Q4eFh5ZFhBdlRoYnl6N0JQNXhRNzZVS1pr?=
 =?utf-8?B?SHZHQUZiVVJEN0dMTEFsSTZ3YWwrU0t1alYyVHE3UnN4SG1JeHNYMDdYY3oz?=
 =?utf-8?B?VTg4cEpBZEkzQ3hidU5FTTlmU3FTRU1iUENIVkRMNk1MZzNycm9RcDcxTVhO?=
 =?utf-8?B?bm4zcjNWODJoSVBSSk9PQXJkSFhud081TDlkTWNISFd0a0dXSkUzaloxS0I2?=
 =?utf-8?B?K3dKR1UvUGFaVDliQldTWndDKzgrNXVidkNUWGh0N3YxUDFCMk42aHMyT3F5?=
 =?utf-8?B?UWNHWmFXQ09EWlVWMCtmS1B2dGdhNzNZTkEvOUhnamU1RXVzamxpSVhwZVZQ?=
 =?utf-8?B?ZHdiMVdCQlBOQWQ4clc2Wm9yVHZqQVZxQm5ka3h6ZkFtaGhpa2psd21WbkNw?=
 =?utf-8?B?blhibklTclJkbFM5YnQ3WEtxYkdjZDc4czBiYy9FbDZOWFRIbThjaHRtVEk4?=
 =?utf-8?B?NW1LeEY3M01VaENNc3lZWUpNNVdVQllpVUUzOXU3NndCNWpJVWI1MThWUk9G?=
 =?utf-8?B?ZHdOeUhoQzNQbVhXd0tBZ1FHWnFiYlN2NEladTF5QlNxTzROUHhGbW1QalRo?=
 =?utf-8?B?VDJJSnprUnBzYVdKd0FTeHJtV0NBSnNUb1p5My9XTktJRXRVTVBvSW91RGZO?=
 =?utf-8?B?b1RrVGFKSFBTNy8wNGxHY3N2MWJTbExBNnFuS2pqcVZ0MXNiaVExS3ozTW9W?=
 =?utf-8?B?ejlrVHpvNzAwTkdHYUVnNjVwTzdsVEJsQmN1emdkUjBOU2RINEc1NlBlZWVN?=
 =?utf-8?B?bnZDYUR4S3QyRXo4aWllK1pUL1IrTE5PaG1rOWdFN1FxUzdxeG5HTEFtNUxZ?=
 =?utf-8?B?K2JwVTRHeTRYK2FFblB3T3g3akp0eDF2emtuQWdINzdjcFA1aUhXQ1JyWSsw?=
 =?utf-8?B?NUlkcGNnWEFKaitBQ2xzZWQ3K3V4cXhLZG15OElSb0xvc2JxMWtLdWorN3Az?=
 =?utf-8?B?cDZpMXczYktHZTVqemZnSENldHZwR2JjdWdPMSs3UnVlTDRKa2hKSnVLSTYy?=
 =?utf-8?B?c1hRR2xsVjR4SjJKV0JFM2hiTEQ0bTZQM25RSU1obnBzM1BVeTRJWThaTXcw?=
 =?utf-8?B?Q2QzbldibUcyNVlzaEZMeWt6MUhUdFFxdzNHNmp6T0RmRVlzUFRoRnJCTW8w?=
 =?utf-8?B?WG5IeWxVK1RSaTFHS1pzamJvRnNYeElDNy9EMjhoUmw3OWcwb2RlNXN0Wmk0?=
 =?utf-8?B?K1h1NUdhVURLd0k0Z0hWNWlJaUE0NU85aUcrL3VISW4vWmtUdWI3MWZEK2xC?=
 =?utf-8?B?WEJJcXBxYmtNMldGWVhMUnd5Y0FnM2ZjamFVVjBDc2cxdGdITm5mcENhT2pz?=
 =?utf-8?B?MzJPQ0FiQmU0MVRZU20vR3I1T2kycjV0NlQ0YUh6cUM3cmh3bHZxWXluK0lK?=
 =?utf-8?B?eWIwQVlFM3pUcmIrdlp0dVdxK1l4VEhnTU90dlFtMWloVVhsUkowcm9makdH?=
 =?utf-8?B?bm1zZlVmUUxDM0ZrZUxSR1BjMzlud2tOeUpsbW5RU3VKVTNKK3oxVjR6WmlZ?=
 =?utf-8?B?TzRHMExTQ051N0FQZUF1QzVMemVkd0Q4aEZ5RzROdldmRnNzY0hiUlFaMFJp?=
 =?utf-8?B?WFJPSmJCUXFnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WDR0ek9rVVBiZFNpSTkzV0lyREk4RmVGU2N0VEI1eXNNSlBYWlZ5WmNWdklh?=
 =?utf-8?B?cEhPQ0ZWWUpPa3JSSXN5RHNGTEV4bTVZU1FTTkU2Q2M0cjdPMEp6YXVoMXg3?=
 =?utf-8?B?b1dLc2hsWUcxMTA5ZTV5VnRmbENLYW5zWTEraU1DZXhteTVIWDZjNXJ3ME1P?=
 =?utf-8?B?eVNBQzlWYmRGb1pKTmFSeUY2ZUlGNnZBSGJFZHF2NEQzQzlQU3h3TWZlODRF?=
 =?utf-8?B?WHBkOXUrOVg5VXhITG9TUk9VRzlWcVA0dWdrU1dmZ2tVVzZwb092OEZLcUQ5?=
 =?utf-8?B?SStnT3pEVEUvc0U2SWZuQW9xOWF2akhyMXR6Q3RVWUdTQ0F5L0NzNG9idVlU?=
 =?utf-8?B?bVV1UnV2Q1FkdkhDMUxyN081cXpUM2ZyRDdlSXVySFI3SFJ3T0c1bUljSlRa?=
 =?utf-8?B?WlJKblpvTEFDMjhhN3czc1BYREFqS2Y1aHFzbmdGYThFMlNPV2FYSEpNZGI2?=
 =?utf-8?B?R2YzK0xnODhzSlg0SHRvajFMRi9QN3dUcGlqaEljMnNPdVpueThmM1AzdCtZ?=
 =?utf-8?B?dHN3RFltditzQmZ3RENhZThJcHI4Ti85d3orMlVldmtZNGJkVElFaHJvMGdw?=
 =?utf-8?B?MEYvUCtHb3ArSmhSTWFUL0xyMGRnRklPV1RNOHV0SnA4bFhCRk1sTTM1Z2pE?=
 =?utf-8?B?ZVN0cUZ4VTMvdDh4MHdyQW80YUhRV1BFWDQwTFI2NWJKUkZUc0plS2dudVNG?=
 =?utf-8?B?SVY4SDVWWTIxV205OURlQktPRnhIQVIveVQ0TWw0QUw4RWhPVUU0TDlmTkxF?=
 =?utf-8?B?VzQ0cElUMWNXNGVLZSt0cTNLOVE4VjFOcmJoZGZlV2svMDBtYXVBa0grNE1h?=
 =?utf-8?B?a3dIamhhRTE4dTJkSVAyUW4zbm94UW1HQ3NXTWtSMWFyazBjU2w5ZTFpanRz?=
 =?utf-8?B?VkplK3pONmU1dE45cnNFWkRoemJWQ29Yb29XblJPcUx1OTRWZEQ4aEJjNlAx?=
 =?utf-8?B?KzBJdnNiRk9kUGx4VVpYNjE1UERqL2ZMbHZZdHUweWZYa21qUmtCUHZpL0pS?=
 =?utf-8?B?UjdPMFNaME5jMitWaWpOa0VKYjJPTXdkcGNCVS8zeU12K21rb1dMQlpYRndm?=
 =?utf-8?B?R01hLzJFVmt0RUF3NHlNOHRhWHZSM1ZMQ3NnaHhZMkxibE02WXQ2YWNVaG05?=
 =?utf-8?B?eU9kcVYyU0RNZ1RYdHFjUVNPVWNVK3pVdXlONTB4WkFSMVM0cksvSTZtRHZR?=
 =?utf-8?B?dUxFS2IwZzBZcmwwWWxLRW1qbHhPbjZkZmZhWXhINFkyc1VuOXAySzlzanRK?=
 =?utf-8?B?ZDJWdXM5VmhyMUF6d3NXZnBvMEVydEMySURTbkZwTnF4QXFMd2J3L2ZROWxN?=
 =?utf-8?B?M0lwdzNpNUdIbWJ5U2FMeG9zcHRZUzQ4T1oweFZSR3QweFIxN3FnS1QydlJl?=
 =?utf-8?B?VmdwZlRkdlVvTXU0MkYvbkZvQXgzYU5paHYyb3g0dFRjU3JJUFovUTRnbHpj?=
 =?utf-8?B?U0FkZ3ZXbHRXMXdyMTVTRWpjOVJsWkNMNU1UWmdsb2tWWHZ5Q2pXbGo0NEly?=
 =?utf-8?B?NWlqQU9XVG5QRnh3TjRvNWtEc3JQNjQwWFFkYlkzZFlMS294cG1ITEkxV1ZX?=
 =?utf-8?B?ZXBqMW5STnNTUktZRGF3c1hkbVFnOGN1bEF0ZlhWOGYwK29lN3V5QWJGNXRr?=
 =?utf-8?B?Zml5aWE1dkUzOGtNY2xkUE5KaU04Vmk4U0dWbE13YXVkWWllSTU3WTg0SU9w?=
 =?utf-8?B?M3ZWYVgyL1NFK215bHh1NlJnZkJYRlN4VTVUR1RiNDV1M3R0MCtka3BEYk5K?=
 =?utf-8?B?N2pvTURONG5IajRMcHZjTUc2YzdqOVpvN3BYRHphZ3VXSC9lL3pMQjZLM2tW?=
 =?utf-8?B?aUJZV0ZpTUFXak93Q21OQVcrYnZQZVFUbDV2R0RkaVRmY2hUSHQxMitkNGRL?=
 =?utf-8?B?cDhDZXU2Tit2cGo0KzBXOUZHSkNVOXpKT08zRnFCNjZ6dDNjY1plSk9kMEov?=
 =?utf-8?B?dUQwOWNpV3BvaVE5dGVSbkh3MldHd2NHTThrOGVvKzl0cVBWYURkaWRjelRu?=
 =?utf-8?B?RGU1SHNwOGJscGZVaXhmeklzd1FtcUFaOGcwRzg2ZFl4Zi9DSUJxTm5sdStC?=
 =?utf-8?B?Q3JoTmhKR1pMMFRRQzVwUFpsaENpbHdMbVE5NCttUm9CV2x5VWViY2svZGZY?=
 =?utf-8?Q?MTtudWC4S/k8gE0vxhVV8KXl4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 379fb710-679d-43c1-8597-08dd71b9ab3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2025 07:40:41.1911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K1c4ovUaF8Q0tuPuaLg3S4Bfaczhks1QrvKzxpqEnMkpb6b8HqYTlrqBvw4YS7QZth/g4vicXG2Jq+MDjCSMRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10775

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDI15bm0NOac
iDLml6UgMTU6MTINCj4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+
IENjOiBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7
IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsNCj4ga3dAbGludXguY29tOyByb2JoQGtlcm5lbC5vcmc7
IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVu
Z3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gZmVzdGV2YW1AZ21haWwuY29t
OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXY7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyA2LzZdIFBDSTogaW14NjogU2F2ZSBh
bmQgcmVzdG9yZSB0aGUgTFVUIHNldHRpbmcgZm9yDQo+IGkuTVg5NSBQQ0llDQo+IA0KPiBPbiBG
cmksIE1hciAyOCwgMjAyNSBhdCAxMTowMjoxM0FNICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToN
Cj4gPiBUaGUgbG9vayB1cCB0YWJsZShMVVQpIHNldHRpbmcgd291bGQgYmUgbG9zdCBkdXJpbmcg
UENJZSBzdXNwZW5kIG9uIGkuTVg5NS4NCj4gPg0KPiA+IFRvIGVuc3VyZSBwcm9wZXIgZnVuY3Rp
b25hbGl0eSBhZnRlciByZXN1bWUsIHNhdmUgYW5kIHJlc3RvcmUgdGhlIExVVA0KPiA+IHNldHRp
bmcgaW4gc3VzcGVuZCBhbmQgcmVzdW1lIG9wZXJhdGlvbnMuDQo+ID4NCj4gDQo+IFRoZXJlIHNo
b3VsZCBiZSBhIGZpeGVzIHRhZyBwb2ludGluZyB0byB0aGUgY29tbWl0IGFkZGVkIHN1c3BlbmQv
cmVzdW1lDQo+IHN1cHBvcnQuDQo+IA0KT2theSwgZml4ZXMgdGFnIHdvdWxkIGJlIGFkZGVkIGxh
dGVyLg0KVGhhbmtzLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+ID4gU2lnbmVkLW9m
Zi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiANCj4gUmV2aWV3ZWQt
Ynk6IE1hbml2YW5uYW4gU2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5v
cmc+DQo+IA0KPiAtIE1hbmkNCj4gDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL3BjaS1pbXg2LmMgfCA0Nw0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBiL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBpbmRleCA0MGVlYjAyZmZiNWQuLmQ4
ZjQ2MDhlYjdkYSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2ktaW14Ni5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYu
Yw0KPiA+IEBAIC0xMzgsNiArMTM4LDExIEBAIHN0cnVjdCBpbXhfcGNpZV9kcnZkYXRhIHsNCj4g
PiAgCWNvbnN0IHN0cnVjdCBkd19wY2llX2hvc3Rfb3BzICpvcHM7DQo+ID4gIH07DQo+ID4NCj4g
PiArc3RydWN0IGlteF9sdXRfZGF0YSB7DQo+ID4gKwl1MzIgZGF0YTE7DQo+ID4gKwl1MzIgZGF0
YTI7DQo+ID4gK307DQo+ID4gKw0KPiA+ICBzdHJ1Y3QgaW14X3BjaWUgew0KPiA+ICAJc3RydWN0
IGR3X3BjaWUJCSpwY2k7DQo+ID4gIAlzdHJ1Y3QgZ3Bpb19kZXNjCSpyZXNldF9ncGlvZDsNCj4g
PiBAQCAtMTU3LDYgKzE2Miw4IEBAIHN0cnVjdCBpbXhfcGNpZSB7DQo+ID4gIAlzdHJ1Y3QgcmVn
dWxhdG9yCSp2cGg7DQo+ID4gIAl2b2lkIF9faW9tZW0JCSpwaHlfYmFzZTsNCj4gPg0KPiA+ICsJ
LyogTFVUIGRhdGEgZm9yIHBjaWUgKi8NCj4gPiArCXN0cnVjdCBpbXhfbHV0X2RhdGEJbHV0c1tJ
TVg5NV9NQVhfTFVUXTsNCj4gPiAgCS8qIHBvd2VyIGRvbWFpbiBmb3IgcGNpZSAqLw0KPiA+ICAJ
c3RydWN0IGRldmljZQkJKnBkX3BjaWU7DQo+ID4gIAkvKiBwb3dlciBkb21haW4gZm9yIHBjaWUg
cGh5ICovDQo+ID4gQEAgLTE1MDUsNiArMTUxMiw0MiBAQCBzdGF0aWMgdm9pZCBpbXhfcGNpZV9t
c2lfc2F2ZV9yZXN0b3JlKHN0cnVjdA0KPiBpbXhfcGNpZSAqaW14X3BjaWUsIGJvb2wgc2F2ZSkN
Cj4gPiAgCX0NCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB2b2lkIGlteF9wY2llX2x1dF9zYXZl
KHN0cnVjdCBpbXhfcGNpZSAqaW14X3BjaWUpIHsNCj4gPiArCXUzMiBkYXRhMSwgZGF0YTI7DQo+
ID4gKwlpbnQgaTsNCj4gPiArDQo+ID4gKwlmb3IgKGkgPSAwOyBpIDwgSU1YOTVfTUFYX0xVVDsg
aSsrKSB7DQo+ID4gKwkJcmVnbWFwX3dyaXRlKGlteF9wY2llLT5pb211eGNfZ3ByLCBJTVg5NV9Q
RTBfTFVUX0FDU0NUUkwsDQo+ID4gKwkJCSAgICAgSU1YOTVfUEVPX0xVVF9SV0EgfCBpKTsNCj4g
PiArCQlyZWdtYXBfcmVhZChpbXhfcGNpZS0+aW9tdXhjX2dwciwgSU1YOTVfUEUwX0xVVF9EQVRB
MSwNCj4gJmRhdGExKTsNCj4gPiArCQlyZWdtYXBfcmVhZChpbXhfcGNpZS0+aW9tdXhjX2dwciwg
SU1YOTVfUEUwX0xVVF9EQVRBMiwNCj4gJmRhdGEyKTsNCj4gPiArCQlpZiAoZGF0YTEgJiBJTVg5
NV9QRTBfTFVUX1ZMRCkgew0KPiA+ICsJCQlpbXhfcGNpZS0+bHV0c1tpXS5kYXRhMSA9IGRhdGEx
Ow0KPiA+ICsJCQlpbXhfcGNpZS0+bHV0c1tpXS5kYXRhMiA9IGRhdGEyOw0KPiA+ICsJCX0gZWxz
ZSB7DQo+ID4gKwkJCWlteF9wY2llLT5sdXRzW2ldLmRhdGExID0gMDsNCj4gPiArCQkJaW14X3Bj
aWUtPmx1dHNbaV0uZGF0YTIgPSAwOw0KPiA+ICsJCX0NCj4gPiArCX0NCj4gPiArfQ0KPiA+ICsN
Cj4gPiArc3RhdGljIHZvaWQgaW14X3BjaWVfbHV0X3Jlc3RvcmUoc3RydWN0IGlteF9wY2llICpp
bXhfcGNpZSkgew0KPiA+ICsJaW50IGk7DQo+ID4gKw0KPiA+ICsJZm9yIChpID0gMDsgaSA8IElN
WDk1X01BWF9MVVQ7IGkrKykgew0KPiA+ICsJCWlmICgoaW14X3BjaWUtPmx1dHNbaV0uZGF0YTEg
JiBJTVg5NV9QRTBfTFVUX1ZMRCkgPT0gMCkNCj4gPiArCQkJY29udGludWU7DQo+ID4gKw0KPiA+
ICsJCXJlZ21hcF93cml0ZShpbXhfcGNpZS0+aW9tdXhjX2dwciwgSU1YOTVfUEUwX0xVVF9EQVRB
MSwNCj4gPiArCQkJICAgICBpbXhfcGNpZS0+bHV0c1tpXS5kYXRhMSk7DQo+ID4gKwkJcmVnbWFw
X3dyaXRlKGlteF9wY2llLT5pb211eGNfZ3ByLCBJTVg5NV9QRTBfTFVUX0RBVEEyLA0KPiA+ICsJ
CQkgICAgIGlteF9wY2llLT5sdXRzW2ldLmRhdGEyKTsNCj4gPiArCQlyZWdtYXBfd3JpdGUoaW14
X3BjaWUtPmlvbXV4Y19ncHIsIElNWDk1X1BFMF9MVVRfQUNTQ1RSTCwgaSk7DQo+ID4gKwl9DQo+
ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyBpbnQgaW14X3BjaWVfc3VzcGVuZF9ub2lycShzdHJ1
Y3QgZGV2aWNlICpkZXYpICB7DQo+ID4gIAlzdHJ1Y3QgaW14X3BjaWUgKmlteF9wY2llID0gZGV2
X2dldF9kcnZkYXRhKGRldik7IEBAIC0xNTEzLDYgKzE1NTYsOA0KPiA+IEBAIHN0YXRpYyBpbnQg
aW14X3BjaWVfc3VzcGVuZF9ub2lycShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gIAkJcmV0dXJu
IDA7DQo+ID4NCj4gPiAgCWlteF9wY2llX21zaV9zYXZlX3Jlc3RvcmUoaW14X3BjaWUsIHRydWUp
Ow0KPiA+ICsJaWYgKGlteF9jaGVja19mbGFnKGlteF9wY2llLCBJTVhfUENJRV9GTEFHX0hBU19M
VVQpKQ0KPiA+ICsJCWlteF9wY2llX2x1dF9zYXZlKGlteF9wY2llKTsNCj4gPiAgCWlmIChpbXhf
Y2hlY2tfZmxhZyhpbXhfcGNpZSwgSU1YX1BDSUVfRkxBR19CUk9LRU5fU1VTUEVORCkpIHsNCj4g
PiAgCQkvKg0KPiA+ICAJCSAqIFRoZSBtaW5pbXVtIGZvciBhIHdvcmthcm91bmQgd291bGQgYmUg
dG8gc2V0IFBFUlNUIyBhbmQgdG8NCj4gQEANCj4gPiAtMTU1Nyw2ICsxNjAyLDggQEAgc3RhdGlj
IGludCBpbXhfcGNpZV9yZXN1bWVfbm9pcnEoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICAJCWlm
IChyZXQpDQo+ID4gIAkJCXJldHVybiByZXQ7DQo+ID4gIAl9DQo+ID4gKwlpZiAoaW14X2NoZWNr
X2ZsYWcoaW14X3BjaWUsIElNWF9QQ0lFX0ZMQUdfSEFTX0xVVCkpDQo+ID4gKwkJaW14X3BjaWVf
bHV0X3Jlc3RvcmUoaW14X3BjaWUpOw0KPiA+ICAJaW14X3BjaWVfbXNpX3NhdmVfcmVzdG9yZShp
bXhfcGNpZSwgZmFsc2UpOw0KPiA+DQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAtLQ0KPiA+IDIuMzcu
MQ0KPiA+DQo+IA0KPiAtLQ0KPiDgrq7grqPgrr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+
4K6a4K6/4K614K6u4K+NDQo=

