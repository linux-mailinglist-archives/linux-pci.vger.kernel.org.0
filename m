Return-Path: <linux-pci+bounces-29199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C01D2AD1983
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 10:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 030227A4C0E
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 08:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E344281357;
	Mon,  9 Jun 2025 08:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cWNaP7Fq"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010019.outbound.protection.outlook.com [52.101.69.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6072F192B7D;
	Mon,  9 Jun 2025 08:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749456203; cv=fail; b=t1oApdlbG1HErIX3pY7UBGrX07tnVxwBz0iQx2mjkdGhay4AkWOIw+hkb7nDBcLivqgNUpGdE3k0Q3SmEYKVJp11oYNG6OBmeXTiYKZDCJtXhibXeVDO9b6pTKD+icrEaMaHIJfQd9/20SQ5bnkIcfhBPZ7cWs/pssM5HCf1dpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749456203; c=relaxed/simple;
	bh=DstghKZpwOR+RUOcCOqBfvnukifzUfxbDszPq0nrZjs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Phy9hxarX+apLesAV+e2aA9jOUVx2Q2SbsBs67FqmGJhtrGt/N26PjPwQoxCi5q+IHqe/BPIVinlIc4vZbkV3w3KKPYLgCrPyDnMiI2nxQ9xtJXkV0OEytkdFBSUBGyK2Ndi2Qkx5YHoVSu1YvurTlkmqMnEc/8Ov4RKDtMp7BY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cWNaP7Fq; arc=fail smtp.client-ip=52.101.69.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFxCMESTu8LMQDZgquuZw8ojwjkrAY3WA0zP0hyNEXdJA7TaXQt5JVH72s9XpxI/Nunxttf1ZuhxX/pRLhjH+8Bj+xauq576dcZGsWNXk6E1fHzDaPhsJpkEKNVPRxv2a5/kJD/xyCwJDvOPZtx1/336O3IrKkBHXinMDWpR0YTTOdMKMmrOW9Puq873jfCczBB0erk8xf5k0aO0OUhINGK1WBnIKOmU49wXd81Y9UmbNCqn/zmIUxOAt1EBpBJdpJFn8zOjrV5A23vt/0Ts47Jm0iz2YxZnrVJlnuO0DkGNK5Ux2nSVv4Ng9rj4TLwE9cHhpk9LEyS8aZV1bJ+cIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DstghKZpwOR+RUOcCOqBfvnukifzUfxbDszPq0nrZjs=;
 b=YacLVP9MNl8zrY/t0+1N5piQfTeFp2t30iTfwhVbL0OAcpiNPHNAZzZoztSnjSOQRl27bPFZ2mLeJBbLF6NWSWrgjKPWaLCYVaUs7yleyXvYakF3AJ1kEbgYNHZfFi9imxk3oBZcY8bqRm7SUPQ9i8F3vpL2KHnaiAKBtmqxSAyLXcnYtVZq6eSdabFo6kRtnPBmNat9eLcepSSegFCDzZWdeeUXxeF1f9MB5/u0uCOMLY7KNl1nPY/9NoWxbuV6cz7Bthf71vifcMtSE6csQLi1fZxfR+IKR5ASCVMDXvpvdXqJELCBWnTA8ylpsZEnHf94rRreU7NbXd6dopXw/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DstghKZpwOR+RUOcCOqBfvnukifzUfxbDszPq0nrZjs=;
 b=cWNaP7FqMUl9MLhylxxHMWu56Rohdt2vk7Jpj1libNi86cHYfwS8yX/r9S7//EDOsdUfoYWVqP4tDhnB/uChhTISxhw5r8c8hjYIBzO2e2kjD3ihsE+l0IE5ZPC/KetwkWw+eddGG23e5TjUd3KAf4QmPwTNCNq8zRjlhiyG+DQRO7en0hha6shHS/Ggg0GaNBcfIxhzduL0b/J/nS2FQBeyTuq9qAo64WYemRgEZXlS8Mpphelft/9EPU859c9rrlU+B5eVnfNxPdI1wnv3UNh0jSkq0glNR+RD4kv4WVWj4Vfw66UBz5wE0EUL6b1NQ3zdcW2X5aa039igL1sf/g==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by GV1PR04MB11062.eurprd04.prod.outlook.com (2603:10a6:150:20a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 08:03:16 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 08:03:16 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: "tharvey@gateworks.com" <tharvey@gateworks.com>
CC: "l.stach@pengutronix.de" <l.stach@pengutronix.de>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "robh@kernel.org" <robh@kernel.org>,
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
Subject: RE: [PATCH v7 05/10] PCI: imx6: Deassert apps_reset in
 imx_pcie_deassert_core_reset()
Thread-Topic: [PATCH v7 05/10] PCI: imx6: Deassert apps_reset in
 imx_pcie_deassert_core_reset()
Thread-Index: AQHbP9jwKL/mPeFjWkuIr6TbMYW/mrP3zVeAgAPAlqA=
Date: Mon, 9 Jun 2025 08:03:16 +0000
Message-ID:
 <AS8PR04MB8676C1206066A3215DB5F3B78C6BA@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20241126075702.4099164-1-hongxing.zhu@nxp.com>
 <20241126075702.4099164-6-hongxing.zhu@nxp.com>
 <CAJ+vNU3ohR2YKTwC4xoYrc1z-neDoH2TTZcMHDy+poj9=jSy+w@mail.gmail.com>
In-Reply-To:
 <CAJ+vNU3ohR2YKTwC4xoYrc1z-neDoH2TTZcMHDy+poj9=jSy+w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|GV1PR04MB11062:EE_
x-ms-office365-filtering-correlation-id: 8b9af0f4-77a3-4a2e-18c8-08dda72c16df
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RlM0a3hXbjhGSWtRWEUrd3g3c1ZRcm1RdldNa3ZPanZyb0paelB3WGttQTd2?=
 =?utf-8?B?Z1FpTS9BekZzUXZkWm92Qm1CMTRWTE5TeDE1eHBlZ3ZvTXIxR21zbFlzL1dz?=
 =?utf-8?B?dDNXa3d4TjRHZzYvMHF0emQ0WUlhVlkwRmJuYmJYUnJPeGZiU1FVcGdiSlpY?=
 =?utf-8?B?TGRxVCtwaHliL2t3d3FlQ2t2dVBmeHVkN1JGM29xTnlyYWdMZlFMY1BCdG9R?=
 =?utf-8?B?Ym5CUHE4SktKbmk4dUVoSHA0SHJJa2ttdGErM2k4SHJ4OWQxZ1htQ081WjQx?=
 =?utf-8?B?cUNOYVRaR1N3dDQyaUJhRmlqVVMrRUhMc051aHBLaUlZWjU2RUZFeXNRWHdh?=
 =?utf-8?B?YzJvU0F4VWMxeHQ4VGpwOC84NkQ4YzNSaGlsbVc2c1Z1R1I5SjRJWUd0dkpq?=
 =?utf-8?B?L2NLaVhwVDVvNEQrL05rYk1SN2x6M0ZDaTlwbEU1YTdyZTBhSUZacEtucGNW?=
 =?utf-8?B?SzY1WmdVWXQ4QUFjaDU4aW91VE5EbEpyRXFVSzgwcVNNaUdGV2toS1dyMUVx?=
 =?utf-8?B?NFpOWkd6S3hMaklZZFZGbUVpL1NoVStuU0Z0Q2wrV2ROSXRhWEZSR2hpc0pH?=
 =?utf-8?B?Q1VQVm5yYzdwYy9CZ3dGaWtDMG4yY1V0ODZzbURML3FOQmIwZnI1ZUhoWVcr?=
 =?utf-8?B?VElVdTMzT3haU2FkcjFIY3U5OXBTcHFhQ1k1SGpXU0FWd1p3UXpzVUU3b2VY?=
 =?utf-8?B?MURGSWpnT3I2Qmk2ZkZjYjB6MUx5K1ZUUWNoNVdGbjB3a0pDSDRJcHZZT0Jx?=
 =?utf-8?B?QzAvMGE3WDFwZFRzaGZ6V01MdHVEYm43NzA2eWNXbG9YUWpDeHB1UVZRaGhx?=
 =?utf-8?B?T2V5WEY1OXYvMjhmWFJGd0hQRUJGelJQOTUxdzRuMlpQMzMzZlc1WGwxeTIw?=
 =?utf-8?B?OGFMUWhDU1IxNlZVNEc3YzBNdjBiMk91V0xvTktOWTZjS3o0NVJmV0tlOUlx?=
 =?utf-8?B?eE5ScXI4TkZLeXBUdFpCY1RQckhPKzU2UGl5QlFpU3kvaUxnbnh5K3ZjOEIx?=
 =?utf-8?B?QWx1Ym9VQmZESm9DUEdrUExtcUxQVHBxS3JsVjhmbTFvd0ZWUEtIbEcvYW9R?=
 =?utf-8?B?M2ZNRmZPNkswRXlBVXdIdTAxazFpSU9DaDlLODluVG9PT01NT25HQzk2Q0lX?=
 =?utf-8?B?ZGkramd2T2duZ1o2MGpOMUpoZ2pLcDRSVHBJWUtSQkRZbDhPOTBzenJyVGlQ?=
 =?utf-8?B?ZjdSbnlEVkE5WTM5dWN0Q29iOXBiWHRNYmxhbVFtakRTcUJTU0hIc3UrQW9Z?=
 =?utf-8?B?OWVXQjFxR3R0eC9CYkhpcjc0YjU4L3hYWjR6aWhibXcybFpMaHhNZmRRUzJP?=
 =?utf-8?B?SXZlb1NWNDBBY3Q4NWJCSkJlMlFQWE0vTzZVMGdsY1JEdkdsaEpweUhwQ1hk?=
 =?utf-8?B?ZXpFaHZWTG8rREhyamhGMkRVRTk5ODI3T3BXZkx4TnZKMGVUaGtoaWpwbGF4?=
 =?utf-8?B?NVhnZStpWG1WL1Y2NWY3YlErNlQrMitIbENBdnNNVDBFR0R5dGRkY3Z0YkVK?=
 =?utf-8?B?YlVUWDZ6eXVmTmJjd3YwblJrNk1lcjR1ZURyK2hVYS96bzlGNVRnNGl5MDAv?=
 =?utf-8?B?dmRSOE5BOU5pdFRab0wxVi9KaytEeVNSblBUSUczRU5wRUIxdE53UkwyVXdo?=
 =?utf-8?B?aWF5TzFqbmtWWWZ6U2VQWWViUnlna0hhc2tuZE4rZ1BscGkzbFJpQXVtdFVt?=
 =?utf-8?B?d1hqS3RSdVlud080Y3Q5dGtHdllQRnNTcWFrektVWG1iUW1FWVY0OGlLK0k1?=
 =?utf-8?B?RmVtM0ZYZHdVcnlZK3NHOEtBczNHYlpZZFVtblRIR1BjaHUweFd3NTEvQ1ov?=
 =?utf-8?B?dnd5U1dOaEFVQU9hZkFiTEl0MGpCSXlIVVk4d3YyL0MySE5QcDA4V3B3Wlc1?=
 =?utf-8?B?cjdsS21mM0ZwaWtrSk9kNmI4SzhVWWhaQzJ4NXErc1pSalFQVURlQVB6cnBS?=
 =?utf-8?B?WnY3T09OZUZGckZPUFZqRHVFR3NLK29KRkp4N3NWbW4reCtzSmIrVXFvSkYv?=
 =?utf-8?Q?NBJL1tWBKzFoyhrFSL7cSFkR07l2LU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y1E2bUhGaEdTRmdXS0NCMjVHbCtmcVZjU2hHbjFlemZQYitLb0lvdnF6M01L?=
 =?utf-8?B?N1FSUlk5RVJpb1p0OTI4aHp5S1pKQ3JROXBHY1loeUtlZmMwczVGUTNCbTI5?=
 =?utf-8?B?cHNYeC8rcktuNmh6Vm9ZcnVxb2xxSUg2ZGhyNnRkcE5WQzFqODBCNGowZXZR?=
 =?utf-8?B?VFBtUEs2cThvUU40bUtjWUgrSWI1eFJuYk9IempqamJlWkJrZU8zeVl6OGha?=
 =?utf-8?B?Vy9iKzN4RjJIZUpPS0wyUUY2OTEzeWZjcDR5bHc3NmE0NDVoZFBOZXl0c0JD?=
 =?utf-8?B?d3BYNU1Jb285VzFBNkdIS0l3TXZiZnNvWGx4aFhGRE5xS1VNOG1lSW5ram5k?=
 =?utf-8?B?QTRvNExhNFIvMGFHL2FlR1MzV2ZhZ2FnNXJMaGFISkxSK2NQWks1TzFkTUFh?=
 =?utf-8?B?SGFkMURuaFdCRktVZVVDYVRBZTQ3RVh4MVRkbVE2TCtaNmplYjQyWE5EeTJ6?=
 =?utf-8?B?Tkl5eThrT1lsZVhlT2owME0wUUo5cXNWaFVmek44MzV0dXlDZkJ2cllWMjgz?=
 =?utf-8?B?SkVnWWRqeE44c29TbHA1MTZpd1VwVXd2WmVOU3dFeGNsUERHeDdNdFg4aStq?=
 =?utf-8?B?Q3lYQjBBY0J5WTBCR3JLVnlPd0lyRmdKL1NzWk5FZ2FMWXZTWmZYNFplTXlo?=
 =?utf-8?B?Yi9ia2ZzS0JWVDZITGVKblpUQmppRVlCRm4zTGtsVU81QUJhU0xNWTY3bDAr?=
 =?utf-8?B?M2ZiWnE3NDYzMldrSU5kQ3E2akluWUszeWYzaFhUaXFhV0M1YWtlOUZWdEhO?=
 =?utf-8?B?dVN1MG9jcFlwREd4ZmxPMm9CRzlBZWRQcTdwd3VKYmxPTXIyejZjejBZNTlL?=
 =?utf-8?B?V3lNUEkrc3ROVDZPRG5sM2VrK2VEZ0JRNWkrR2pUNExOQUd4YUNBWktJRnVy?=
 =?utf-8?B?ZFVmaWJ4c1E4TzR0ZkFEeUtLVkxHSmdvakpkblpRbmlRWUpCOTZQQTFCTTM5?=
 =?utf-8?B?WkRrdi9FZStBYmZycGNrTWg4R0s1aGYzQzdRV2dmVVBibjZGTStsTUoxUitw?=
 =?utf-8?B?SXBEK1pPaGE1QlRYS0pKMS9qUEk2NnVSUHVXR1Y1RU5DZmZEMXMrSlpONWNu?=
 =?utf-8?B?RFdsOGt0YllCZjJzb3BOcE9pTlR6K0t1dytaTG9UbFRhNmpUNVFtemNmWXVs?=
 =?utf-8?B?VHZiZXB5NEFWcjJHbjJwSUVsNnFoWWJCdnExUWdsRVc1TGNDUlBaWk9kbVY2?=
 =?utf-8?B?bkV0bXNDQmFQSHpjRmRlQWhQbW9LS0lXMlJDYVdkaTMxaEhkMklNc2RLZnBS?=
 =?utf-8?B?NGgyUlVDVnhQMHRseEZRNjRocE9oTmFTUlNPU21aUUxEdFNUQU41a0ZIc0E1?=
 =?utf-8?B?d3U3NUVrUk1sT2pmOWFhUzF3djJ6YmlNVGMzK1dNREw4RU9Dc3Y5dEcrVHhv?=
 =?utf-8?B?NUVzRVNna2VhTHdXeFpYRTR0SmtPRkdiMkQ5amsxU25CVEZLZkhoSkdlelJk?=
 =?utf-8?B?NXZ5TmdkdENuNnZoV3dEWklpeEZrS3J1dWVPc0s3cU85SFdxM3hWNVg0MEJF?=
 =?utf-8?B?ZWZOTTBqUVA3bXM5SG02RVBTSldrMkxVdlpEWHhrdjRJUzd0MmprQ2VMeGFv?=
 =?utf-8?B?aUtkQTA0bUorYTN3MmI5YjA5UjdvNUdub0NTYkpVOE9tTUhzS3N2dmZNNEYv?=
 =?utf-8?B?RmFQVjBaUlh1cVBZbzAzR3FYaThxZm5KNE9FMjNTRWt6MFFCRXF1UG9yL3dZ?=
 =?utf-8?B?bUpIdkNsaTdnVzloMnV4a1UrOUNTRmlTakxUU2ZPaDl0SWFyTDBZOUhJY0Nj?=
 =?utf-8?B?U0NRSHNxYmJOOEFqOVZiWkp5Zzd4S0ZwT3YxbWk3QjFxTytCdUwvTmtuQ1Y2?=
 =?utf-8?B?a0hZNndDNXl0R2RyWFlhcjJpL0JSMVNoYjRrcTMzVHMyTnl0TFYwZ21FTkdL?=
 =?utf-8?B?OG1yTG03alBsdVh6TlpKbnJhV3lIazJrSTdaTE9oOWcrUVU2SkFhRjAweWpC?=
 =?utf-8?B?NWEvNjIyTkZRWnYveFhGR0RIenFtaTlUWkF5cWNmbkU0ZmNLcEh6U2V1cVQx?=
 =?utf-8?B?cThEOXQ2anBSV2hEMmNldTNvR1V5UDJVWFl6WmNwcG54TnpDbWpUOHZ0YmV2?=
 =?utf-8?B?YWJ0akd2Y2RWbWtkTnpWbmhDOUtHaFN0WVI3dHM4clRORTJzU2ZxYVF5N2pm?=
 =?utf-8?Q?kZU/+d3+mf5X+Eh4MoKcq84E/?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9af0f4-77a3-4a2e-18c8-08dda72c16df
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 08:03:16.0317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o6CcwQKENVdffddjwMFTU6e7H1VR0V7gfJEOZK6vVvJbgWhJ49Gja2XvbXNErDtywclYSPWF8UC0neR825LTNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11062

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaW0gSGFydmV5IDx0aGFydmV5
QGdhdGV3b3Jrcy5jb20+DQo+IFNlbnQ6IDIwMjXlubQ25pyIN+aXpSA1OjA0DQo+IFRvOiBIb25n
eGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogbC5zdGFjaEBwZW5ndXRyb25p
eC5kZTsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbHBpZXJhbGlzaUBrZXJuZWwub3JnOw0KPiBrd0Bs
aW51eC5jb207IG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnOyByb2JoQGtlcm5lbC5v
cmc7DQo+IGtyemsrZHRAa2VybmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsgc2hhd25ndW9A
a2VybmVsLm9yZzsgRnJhbmsgTGkNCj4gPGZyYW5rLmxpQG54cC5jb20+OyBzLmhhdWVyQHBlbmd1
dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IGtl
cm5lbEBwZW5ndXRyb25peC5kZTsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHY3IDA1LzEwXSBQQ0k6IGlteDY6IERlYXNzZXJ0IGFwcHNfcmVzZXQgaW4NCj4gaW14X3BjaWVf
ZGVhc3NlcnRfY29yZV9yZXNldCgpDQo+IA0KPiBPbiBUdWUsIE5vdiAyNiwgMjAyNCBhdCAxMjow
M+KAr0FNIFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4N
Cj4gPiBTaW5jZSB0aGUgYXBwc19yZXNldCBpcyBhc3NlcnRlZCBpbiBpbXhfcGNpZV9hc3NlcnRf
Y29yZV9yZXNldCgpLCBpdA0KPiA+IHNob3VsZCBiZSBkZWFzc2VydGVkIGluIGlteF9wY2llX2Rl
YXNzZXJ0X2NvcmVfcmVzZXQoKS4NCj4gPg0KPiA+IEZpeGVzOiA5YjNmZTY3OTZkN2MgKCJQQ0k6
IGlteDY6IEFkZCBjb2RlIHRvIHN1cHBvcnQgaS5NWDdEIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBS
aWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IE1hbml2
YW5uYW4gU2FkaGFzaXZhbQ0KPiA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+DQo+
ID4gUmV2aWV3ZWQtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHwgMSArDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBpbmRleCAzNTM4NDQwNjAxYTcuLjQxM2RiMTgyY2U5ZiAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+
ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IEBAIC03
NzYsNiArNzc2LDcgQEAgc3RhdGljIHZvaWQgaW14X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQoc3Ry
dWN0DQo+ID4gaW14X3BjaWUgKmlteF9wY2llKSAgc3RhdGljIGludCBpbXhfcGNpZV9kZWFzc2Vy
dF9jb3JlX3Jlc2V0KHN0cnVjdA0KPiA+IGlteF9wY2llICppbXhfcGNpZSkgIHsNCj4gPiAgICAg
ICAgIHJlc2V0X2NvbnRyb2xfZGVhc3NlcnQoaW14X3BjaWUtPnBjaWVwaHlfcmVzZXQpOw0KPiA+
ICsgICAgICAgcmVzZXRfY29udHJvbF9kZWFzc2VydChpbXhfcGNpZS0+YXBwc19yZXNldCk7DQo+
ID4NCj4gPiAgICAgICAgIGlmIChpbXhfcGNpZS0+ZHJ2ZGF0YS0+Y29yZV9yZXNldCkNCj4gPiAg
ICAgICAgICAgICAgICAgaW14X3BjaWUtPmRydmRhdGEtPmNvcmVfcmVzZXQoaW14X3BjaWUsIGZh
bHNlKTsNCj4gPiAtLQ0KPiA+IDIuMzcuMQ0KPiA+DQo+ID4NCj4gDQo+IEhpIFJpY2hhcmQsDQo+
IA0KPiBJJ3ZlIGZvdW5kIHRoYXQgdGhpcyBwYXRjaCBjYXVzZXMgYSByZWdyZXNzaW9uIG9uIGku
TVg4TU0gYW5kIGkuTVg4TVANCj4gYm9hcmRzIHdpdGggaG90cGx1ZyBjYXBhYmxlIGJyaWRnZXM6
DQo+IGkuTVg4TU0rUEk3QzlYMkc0MDRFViAodGhpcyBzd2l0Y2ggZG9lcyBub3Qgc3VwcG9ydCBo
b3RwbHVnKSAtIG5vIGlzc3Vlcw0KPiBpLk1YOE1NK1BJN0M5WDJHNjA4R1AgKGhvdHBsdWcpIC0g
ZmFpbHMgdG8gcmVsaWFibHkgZW51bWVyYXRlDQo+IGRvd25zdHJlYW0gZGV2aWNlcyBhYm91dCA4
MCUgb2YgdGhlIHRpbWUgXl5eIHdoZW4gdGhpcyBvY2N1cnMNCj4gUENJX1BSSU1BUllfQlVTICgw
eDE4KSBmb3IgdGhlIHJvb3QgY29tcGxleA0KPiAwMDAwOjAwOjAwLjAgcmVhZHMgMHgwMDAwMDAw
MCBpbnN0ZWFkIG9mIDB4MDBmZjAxMDANCj4gKFBDSV9TRUNPTkRBUllfQlVTIGlzIDAgaW5zdGVh
ZCBvZiAxIGFuZCBQQ0lfU1VCQk9SRElOQVRFX0JVUyBpcyAwDQo+IGluc3RlYWQgb2YgMHhmZikg
aS5NWDhNUCtQSTdDOVgyRzYwOEdQIChob3RwbHVnKSAtIGhhbmdzIGF0DQo+IGlteF9wY2llX2x0
c3NtX2VuYWJsZSBkZWFzc2VydCBhcHBzX3Jlc2V0DQo+IA0KPiBJbiBib3RoIGNhc2VzIGhlcmUg
cmV2ZXJ0aW5nIGVmNjFjN2Q4ZDAzMiAoIlBDSTogaW14NjogRGVhc3NlcnQgYXBwc19yZXNldA0K
PiBpbiBpbXhfcGNpZV9kZWFzc2VydF9jb3JlX3Jlc2V0KCkiKSByZXNvbHZlcyB0aGlzLg0KPiAN
CltSaWNoYXJkIFpodV0gSSdtIGFmcmFpZCB0aGF0IHRoZSBsdHNzbV9lbiBiaXQgYXNzZXJ0IHRv
IDFiJzEgaW4NCiBpbXhfcGNpZV9kZWFzc2VydF9jb3JlX3Jlc2V0KCkgaXMgbm90IGNvcnJlY3Qg
aW4geW91ciB1c2UgY2FzZS4NCg0KQWN0dWFsbHksIHRoZSBhcHBzX3Jlc2V0IGlzbid0IGEgcmVh
bCByZXNldC4gSXQncyB0aGUgbHRzc21fZW4gYml0Lg0KRnJvbSB0aGlzIHBlcnNwZWN0aXZlIHZp
ZXcsIEl0J3MgaW5hcHByb3ByaWF0ZSB0byB0b2dnbGUgdGhlIGx0c3NtX2VuIGJpdCBpbg0KIGlt
eF9wY2llX2Fzc2VydC9kZWFzc2VydF9jb3JlX3Jlc2V0KCkgZnVuY3Rpb25zLg0KSSBjb25zaWRl
ciB0byBtb3ZlIHRoZSBhcHBzX3Jlc2V0IG91dCBvZiBfcmVzZXRfIGZ1bmN0aW9ucy4gDQpDYW4g
eW91IGhlbHAgdG8gdGVzdCB0aGUgZm9sbG93aW5nIGNoYW5nZXMgaW4geW91IHVzZS1jYXNlPw0K
DQotLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQorKysgYi9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQpAQCAtNzc2LDcgKzc3Niw2IEBAIHN0
YXRpYyBpbnQgaW14N2RfcGNpZV9jb3JlX3Jlc2V0KHN0cnVjdCBpbXhfcGNpZSAqaW14X3BjaWUs
IGJvb2wgYXNzZXJ0KQ0KIHN0YXRpYyB2b2lkIGlteF9wY2llX2Fzc2VydF9jb3JlX3Jlc2V0KHN0
cnVjdCBpbXhfcGNpZSAqaW14X3BjaWUpDQogew0KICAgICAgICByZXNldF9jb250cm9sX2Fzc2Vy
dChpbXhfcGNpZS0+cGNpZXBoeV9yZXNldCk7DQotICAgICAgIHJlc2V0X2NvbnRyb2xfYXNzZXJ0
KGlteF9wY2llLT5hcHBzX3Jlc2V0KTsNCg0KICAgICAgICBpZiAoaW14X3BjaWUtPmRydmRhdGEt
PmNvcmVfcmVzZXQpDQogICAgICAgICAgICAgICAgaW14X3BjaWUtPmRydmRhdGEtPmNvcmVfcmVz
ZXQoaW14X3BjaWUsIHRydWUpOw0KQEAgLTc4OCw3ICs3ODcsNiBAQCBzdGF0aWMgdm9pZCBpbXhf
cGNpZV9hc3NlcnRfY29yZV9yZXNldChzdHJ1Y3QgaW14X3BjaWUgKmlteF9wY2llKQ0KIHN0YXRp
YyBpbnQgaW14X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNldChzdHJ1Y3QgaW14X3BjaWUgKmlteF9w
Y2llKQ0KIHsNCiAgICAgICAgcmVzZXRfY29udHJvbF9kZWFzc2VydChpbXhfcGNpZS0+cGNpZXBo
eV9yZXNldCk7DQotICAgICAgIHJlc2V0X2NvbnRyb2xfZGVhc3NlcnQoaW14X3BjaWUtPmFwcHNf
cmVzZXQpOw0KDQogICAgICAgIGlmIChpbXhfcGNpZS0+ZHJ2ZGF0YS0+Y29yZV9yZXNldCkNCiAg
ICAgICAgICAgICAgICBpbXhfcGNpZS0+ZHJ2ZGF0YS0+Y29yZV9yZXNldChpbXhfcGNpZSwgZmFs
c2UpOw0KQEAgLTExNzYsNiArMTE3NCw5IEBAIHN0YXRpYyBpbnQgaW14X3BjaWVfaG9zdF9pbml0
KHN0cnVjdCBkd19wY2llX3JwICpwcCkNCiAgICAgICAgICAgICAgICB9DQogICAgICAgIH0NCg0K
KyAgICAgICAvKiBNYWtlIHN1cmUgdGhhdCBQQ0llIExUU1NNIGlzIGNsZWFyZWQgKi8NCisgICAg
ICAgaW14X3BjaWVfbHRzc21fZGlzYWJsZShkZXYpOw0KKw0KICAgICAgICByZXQgPSBpbXhfcGNp
ZV9kZWFzc2VydF9jb3JlX3Jlc2V0KGlteF9wY2llKTsNCiAgICAgICAgaWYgKHJldCA8IDApIHsN
CiAgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgInBjaWUgZGVhc3NlcnQgY29yZSByZXNldCBm
YWlsZWQ6ICVkXG4iLCByZXQpOw0KDQo+IEkgbm90aWNlIHRoZSBzZXF1ZW5jZSBvZiBldmVudHMg
aGVyZSBpczoNCj4gaW14X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQgYXNzZXJ0cyBhcHBzX3Jlc2V0
IChkaXNhYmxlcyBMVFNTTSkNCj4gaW14X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNldCBkZWFzc2Vy
dHMgYXBwc19yZXNldCAoZW5hYmxlcyBMVFNTTSkNCj4gaW14X3BjaWVfbHRzc21fZW5hYmxlIGRl
YXNzZXJ0cyBhcHBzX3Jlc2V0IChlbmFibGVzIExUU1NNOyB0aGlzIGlzIHdoZXJlIGl0DQo+IGhh
bmdzIG9uIGlteDhtcCkNCj4gDQo+IElzIHRoZXJlIHBlcmhhcHMgc29tZSBpc3N1ZSB3aXRoIGRl
LWFzc2VydGluZyB0aGlzIChlbmFibGluZyBMVFNTTSkgd2hlbiBpdCdzDQo+IGFscmVhZHkgaW4g
dGhpcyBzdGF0ZT8NCltSaWNoYXJkIFpodV1UaGUgYXBwc19yZXNldCBpcyB1cGRhdGVkIGJ5IHNy
YyBkcml2ZXIgYnkgcmVnbWFwX3VwZGF0ZV9iaXRzKCkuDQpJIGNhbid0IGZpbmQgdGhlIGV4Y2Vw
dGlvbnMgdG8gdXBkYXRlIG9uZSBiaXQsIGFscmVhZHkgaGFzIHRoZSBhY2NvcmRpbmcgdmFsdWUu
DQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gDQo+IEluIHRoZSBjYXNlIHdoZXJlIGRv
d25zdHJlYW0gZGV2aWNlcyBkbyBub3QgZW51bWVyYXRlIHNvbWUgaW52ZXN0aWdhdGlvbg0KPiBw
b2ludHMgdG8gdGhlbSBub3QgYmVpbmcgaGFwcHkgdGhhdCB0aGUgbGluayBkcm9wcyBzbyBwZXJo
YXBzIGRlYXNzZXJ0aW5nDQo+IGFwcHNfcmVzZXQgd2hlbiBpdHMgYWxyZWFkeSBhc3NlcnRlZCBk
cm9wcyB0aGUgbGluayBhbmQgcmVzdGFydHMgaXQ/DQo+IA0KPiBCZXN0IFJlZ2FyZHMsDQo+IA0K
PiBUaW0NCg==

