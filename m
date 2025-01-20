Return-Path: <linux-pci+bounces-20130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7BBA16586
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 03:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799E23A39CA
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 02:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8125A2AF1D;
	Mon, 20 Jan 2025 02:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gYdYQ5xP"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2084.outbound.protection.outlook.com [40.107.247.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35884182BC;
	Mon, 20 Jan 2025 02:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737341357; cv=fail; b=qqOc7brVe4guwXdB2GxDZ0LqTJ8oH1SfJ55ea059lEMRqfkk04aYRaAl2Nih2S8d0tTZeH2Wogjo1uBPe1Tsqy5i1nnCUiYlTIIyrFBdhLJ6QaDCRWL2Zm/6zEthdAVPak16ZusGXIuXhTD/jNUxkiYqhXgMR+CBkhlH7NCAgnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737341357; c=relaxed/simple;
	bh=mdL6mCamH1C/w5sijg36x/GKyawbagvFHZ2UbeNJfx8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AR5HsoHlobgu//j8QGDW1oBtFN4NwUW67zvPbpv8kc8LlxyJ241VFtBxMD+TN8RQQ6hlCDSp/cxPkLu873tRHzEBtIZKS67itpaRaui3vt9ncBfk+CGoWR6JRtw/g5+OtdAUFMOjOx3i27gNRXZND6jLVWcqkAzGP7I8V4BpweE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gYdYQ5xP; arc=fail smtp.client-ip=40.107.247.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onFCMIanQZVqdGD4YKaX11EQwYh5vB2MvMDdu8Ccc7yGkqqYILtUT/jgoUMHj9J+LsQNzh7I82ShhItRiLRbKkamgGmgtFCVPG0nhe78inzSYzACYRufuU/vjDZUQQLbyg29BaLAPCjW2oUN3h5+9kn62UAvqK2YT66MnglUAZhbOzIdAxBy9gT+CK03/gi+NEwlFFGrWJk5RkfPFT/Ejz7TgaX79wYJj5Hy091sndPG8qGhmt9UcbfBiRG6F7pgumqa6HnhQBZoJaD2nS5SUlEygdykOXu8xmlmq5j6d7OUBAiea+GmKqOHaJZ+IclPiSAGMYJDLOvSGVrYRg6ysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdL6mCamH1C/w5sijg36x/GKyawbagvFHZ2UbeNJfx8=;
 b=hC5gkdATEoku9Vc/lGCQK/+vRVFhprUBR+vvmFBLt3qLC5Np2ZNGAafA0LYd5stmEvD3qETwjjknEXalSbkOdv624rtY7V132SLy2xBvCzbsXQbRfcM38ZUWDVY7hMGwOj3E2wghfDRb1ny0uJRzFIqIZP5klBaqMqC9/9zpShLbQPak1h6wSF6MvzVCNLi+p7nGdsh7CNknrKFk4r3tf+VelZ2Ln/BZc8t7irm8rPQCEA72D8mcdRuS4T+hdEddYwLzE/7BUhpvgOsZ2Ik3jKqHrtoFz7BDQDFEYiIdUt93qirK6jGigBx9JxfcmuPQYPResFa4Y/Equr9qijXI5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdL6mCamH1C/w5sijg36x/GKyawbagvFHZ2UbeNJfx8=;
 b=gYdYQ5xPmvc8bL1W5Yj5tGDOd5d5mFA7rcxMDw0l+EVI4nJsnmVS3h5b51Z1eOTm46fcNj02nLC7YySDuheExS+kV+nRv90st06Tz7MsPTAKYZisYjMYe5T1NEcPIfKo6YQlwU70cy8BwhmEpIc9/ZBcsUeciVKs1qwq/TxS0cQJcpbafwPnZKRP4MijNvvhkV346OClbbN7cn3GKy5uJd94ZJDN3BiCi2Eb7rPVhEVaCPFql4fVFo2YwmWQaTVlUTgwX/0NwDsAQeaD5wlVgS1xE9C4nWQZa/NGeU/M4KSPbSQr9nUP5SaKuw1/QGrbs3DOsFLgyHZVnY/iTvs8Qg==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DU0PR04MB9250.eurprd04.prod.outlook.com (2603:10a6:10:351::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 02:49:10 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 02:49:09 +0000
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
Subject: RE: [PATCH v7 02/10] PCI: imx6: Add ref clock for i.MX95 PCIe
Thread-Topic: [PATCH v7 02/10] PCI: imx6: Add ref clock for i.MX95 PCIe
Thread-Index: AQHbP9jhejkwCulgPEarYoQ8WDwaHbMeAJcAgAE/fGA=
Date: Mon, 20 Jan 2025 02:49:09 +0000
Message-ID:
 <AS8PR04MB86762EA8219F8FE76CB48F358CE72@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20241126075702.4099164-1-hongxing.zhu@nxp.com>
 <20241126075702.4099164-3-hongxing.zhu@nxp.com>
 <20250119070246.yfxogn4vv3jqfvzb@thinkpad>
In-Reply-To: <20250119070246.yfxogn4vv3jqfvzb@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DU0PR04MB9250:EE_
x-ms-office365-filtering-correlation-id: f90c178d-8677-4138-7da8-08dd38fd0389
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YzhBU1h5YldSTlRmN3RkUkd4b2kxc0wxdVFXZkZoR2pmS05XK1BodTZrUzBm?=
 =?utf-8?B?YzZnTy9oU2MybFhvbkUvV2czM29XM1NmRnhoNnJUZXY1ZlJ1cTJkQUxNTThP?=
 =?utf-8?B?WDBENlBld0UrMFREYytLQ1NxMkVMbk5aaWNIeW9hMDMrYlo3K1NHVWE3ZFlW?=
 =?utf-8?B?YS9EVDlJYnBHSjZIWTBOaWJ2Zlk5RVBHU0pobWtMZytqV2NEaFdueVdrVkdy?=
 =?utf-8?B?SllIaXhRQW1kSEs1NW1SYTNHRDMwa0VpR2V6VGp5L0JKREZtTmJ3QzJQTzJK?=
 =?utf-8?B?dHZFZmkzSjBPYlZ3MlZGQUoyS3JLWjY2TmZIMTJIS2szcnhkOWoreDF3Rnhk?=
 =?utf-8?B?K0llRFo4ZFlyRUQyZFkvSUdwcERSVUtnUENRcTA2cGxxWEVRdzlyaHlHRXdI?=
 =?utf-8?B?YUxTUTdWNENjRXJ3MTQ5ZENXbGdMR1pjNkVCMzNZc3c2SGQ5dnoyZnVaTXZ3?=
 =?utf-8?B?dW9Vd3dtUnkwYnFCenpkMnRicXVMNks5MXhUM010TmhHbURhRmhnWUFOZFZo?=
 =?utf-8?B?QVhXVThjd25aVFpzS1pyWEFNV1JRS3krU2ZmOTd4YTN3VjRGaDlhNVRDYm1T?=
 =?utf-8?B?VG82cmxKcHBuZWZQYzJtbUg5bC9IbFdZSzdQRE5UMzNvZ092TmZRSHY5Y0xu?=
 =?utf-8?B?dWx1WVJ1b2hkNWppVjZYTFljRDZkTmwya1ovTG12djRHMU9aRTBOSUt3c1g3?=
 =?utf-8?B?ZTNnVkk2ZkR0aUhJNGcyOVRxMUVwK0ZmbGgzWU1sT1RsSGp2ZVZYSXVVWHJO?=
 =?utf-8?B?cGdQWHdsWWROeGJRZVhnUWxiNzM1ZklSMHUwcUpZY0Y3NGQ4RFdHSHhidWZR?=
 =?utf-8?B?eGxxdzZFbDgyYStoK1hQMzJIdjM1ak9hOTArUld0amc1OEZqQ3VWazl5dGhs?=
 =?utf-8?B?a1YyUkhBOURyVHFTMlBtdjA2ZTFUSGdMTVREK2hvZXBVaVBhWWw5cnFZdDND?=
 =?utf-8?B?czJBLy8vZWQwQ25vc3dDOXFzeDJrUU5KZVdPQVdyNk8xMG5FRlkrcjZUcmU3?=
 =?utf-8?B?STlhSXJuRTV5VWFZWnlwNzdzWStMUlRrVzBQOWluQTl1ajY4RzNMb3FvdWY1?=
 =?utf-8?B?NHA5bHVROGh4bE42ZWVZVzFQTnZRTG5rTnRzbGVIS0pwUUJPQkVxMUg3bVJZ?=
 =?utf-8?B?OHVia3Z3UEw2citPUkF1aEZ6U0drL1MrOUU0KzhkZVpRTHl4VlFDTHdMQkxx?=
 =?utf-8?B?Y2xoUkhVUHFLREFSamNMZFdEZGZCS05zdkc1dERMQ3dWWTQ1WmNsTmR0MktX?=
 =?utf-8?B?OWRZUVc5eUhXZTRzcFFlUnNMclhmZmVrcUJlUUMwNkFEQVB5SytyOXJ6ZlB0?=
 =?utf-8?B?M25iSm1FREluN3Y1Z2VzKzBQS1dOdFU5MlgraTZGMFBjUlYwY1lESzd2Rm05?=
 =?utf-8?B?Vi80MGxXMzRvVUU0REVQQjJkcmgyT3haWHRKNVhKOUZlRWhuMUhsM210a21H?=
 =?utf-8?B?OVlNcGJEMzFKaTg5MUVpaXFhcmlKN3JlV3VqaksxaE00VWtFMnZIOXhoWmZL?=
 =?utf-8?B?amRjN0lEdTlDK2dMeks3VnVmSDE2TVBwbWZUWXBnUDlVZ0lqdzBWV3VZSUYr?=
 =?utf-8?B?UFF6VWZSSDNvN0U1K0J3QXpTQlErRnh0dnBOckwrVEJ5dGNCU1o3VndveXBX?=
 =?utf-8?B?a20vSlVkOUczNTVIS0dzRmZFbnljRVlyS2R6aWZOeHZJWGpyVWpjRHFZRTl6?=
 =?utf-8?B?OExNRlZ3bDZVVnBpbC8xelgwVlplUjJmcWVsakx5R0NqditYZ0xwSlg0ME44?=
 =?utf-8?B?bktmcWduK2gyWDhiZzZLdi90SUgxS0tJK3FZb3JqS29ZTzZ3eWlldHpnM0lN?=
 =?utf-8?B?YTg2d0htSmZwSnJCRVMvNUZUTG81Sk1sZUN5eFdxbWZjcFJURittN1hvVGps?=
 =?utf-8?B?WjBldlI4MkpCRXZYNTh1ODdHSXFoKzJ0UWN1OStOL29kUzUwZkRYSUJjY0Za?=
 =?utf-8?Q?38oKck2gnQ6JxpKT5D5/BzXARiOdZ46B?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c244MHhGRDlsa29XUUc4a01uaWtoUjUxbVdwNWZra1l1SmRzTDN1OFJTeHND?=
 =?utf-8?B?RC9udGNvQmZvRHI0b2szVTdFRnFGZkJ3T0s1QVl6YVVhYURpL2JscDVnOW1G?=
 =?utf-8?B?Qi81V0tTdHlVQlJyalR2Nkp3RHJrUWRKMml3ckJQU05BTHRxTUZuS1daRUc5?=
 =?utf-8?B?cU5RSEtTWk1Wc2F6NVZOZld3bGk1L1NyTzFIQVlFSm12eDRiSFQvS3ZkV3Qx?=
 =?utf-8?B?WDhjSFBwanhGQVFkbjVON2huOSt3M2FnRDljOVVDcWpKd2pqS0RDOHpZV1h5?=
 =?utf-8?B?dEhYQ081bUkrT1MxQ1J0bmZoeC9NaS9haGtGZ2xpU0lHWXh4WCttbFlYUmVR?=
 =?utf-8?B?VDVVS1Q4TkZKU3NvYk40anZzN2F0aVh4UjVXWEFwbmRuTmt2OFVrdG84ZmlD?=
 =?utf-8?B?S3RRcG9kREVVN1VPRzAraWRVR2Vzai92ajlCY2JGRElwb3dUbkFzSS9ZWVZD?=
 =?utf-8?B?OVJidVlYdnNBYk5PSDlnem0yVFJXdE1EWFhqL2dEVmc2bVBnYk5FakhQaEVU?=
 =?utf-8?B?OEtnZmN4TGpCQXJDUDlvYTJNU2tZRnFjK0NXMXAwdmwra3YvWkg1Ni9RTU9u?=
 =?utf-8?B?VTgzaCtoeXNhNjloZnlZd3dhRHkzQjk4NGxmU0RrYWxGdWJOVUs4cjZXOTlk?=
 =?utf-8?B?NU1ocldFWHJ2MHpNY2xZc2pzTUEzd1hMWjQwOFpXQTE1N0JJVXVpMDZwOFln?=
 =?utf-8?B?OXdQTUt5eHNKL0dmaDFqd2VHNVhMR0wzaGpVQmtYZWpEOWhyMzdBYUhYbjFG?=
 =?utf-8?B?dzFSaCtHcjEwM1cyYmJHS3EwMmliVW84WFduY1B0NzFnV2JlN0JFelpkNjY4?=
 =?utf-8?B?TkszMUZDNVAvNW5BdUJrNTJEem9aTzdTSkJ0SnVnbE53UDFvUi9jMml4dURP?=
 =?utf-8?B?VzNMMnB4aUZjTnMwZ2ZJTStES1JvamthM1MvemduVERtWEpmMVRjT1FqQWY0?=
 =?utf-8?B?T0RPckNPNnZBWVArUmR6blpLbEtXcFRqM0pXZHdRaGZjQ3ZnVkFiYkZ3UHEy?=
 =?utf-8?B?S2V5enZUQVphdll5cmdES1dwL0MwU2NsYndSc1VCNXcrUDRMZnJNU3hKQ1pO?=
 =?utf-8?B?Ylp6RUR2dHFoVURWZzhwNWtWdFFreDE3NXR0T3h4RGpMK0Z6Zm1LcUNjd1Vn?=
 =?utf-8?B?T3o5ZkpFMzdvZUlyOFI3YmtSbk5TVXlwWEh0clFtNW81WE51SnozNHFVMHB5?=
 =?utf-8?B?V3dzSXdBeWhKRkgwTnFKVGd4NXFpUklhbytsOEUwb0RObFVJSVlpR0lCZW5w?=
 =?utf-8?B?NWpkTHhjRkQ1dDdWSkZUaDRoL1p2eUNQcnYzajBPNDVkRVUvUllKVXhiWnk3?=
 =?utf-8?B?S2tBeUJuRnpwbS80RXZCSFpVbkZCQklUMUVUSjJFUHlXcklFTzE2V3RWYVVu?=
 =?utf-8?B?RThqd2ZWR2p5Y3o4RVVpQzdSWElsMU9TQkxMVVpmZzRzSzNKTExxQ002Undp?=
 =?utf-8?B?c0kwdy92OVV0SW9mNVJrS0gyYmNYalZ5Und2SUh5M3h2amhVVDJTWFBQb1Zy?=
 =?utf-8?B?eVAvY3phQ09BWTVRUnRvTk5tMWRoN21yYWJQeCtmNWJLYi96M25Zb1RYczFU?=
 =?utf-8?B?UzhpZURhdzM2M05QUjI1cDBIaFdRdjBqUmVIUSt4OGlVd1ExU0lEY1g2dllV?=
 =?utf-8?B?Ymkra2lGcVJCanlYWkczWExtNkxxVENIZCszbXFIcDNlT0pIMmE0VVBhc2VE?=
 =?utf-8?B?bzJFZnVsbFQ2YlhrdTdWMFc3b2NNSVRBT1RlSFpaa2xKMFkwbGl1VjVkNEZR?=
 =?utf-8?B?RjhwNXVMQnQ0ZGN1QUdPS05wYm43U01TUlk2YmtVMHh3S2NmUy9TNUpXYjR0?=
 =?utf-8?B?elNYZW9CenRjNzI0bFlyM2JYMFcxMlhWYVJhWFhRQlk1b0dULzA0WTY0bEk2?=
 =?utf-8?B?YUVDTEFEc0c2WDB5ckVZQUZMVkQ4THNVd2xERHEwejhSemlicnp0T3g0THRM?=
 =?utf-8?B?RldMZEQ1RDJWc3VsdXJxbmdjZ2wrdGdQYVN3R0QxamZDMDcydGFnSTI2b01h?=
 =?utf-8?B?U3RjL01OTUFNV3FOeEFwQXNnQkphRnN4RGNUYnFyUk9WMC9ub2VWbEZMd1Bh?=
 =?utf-8?B?UnFOL040dlpKV3RVZy9obVFqVXRCYXRrdHp5blFxb1FxZ3pCQ2p4WGtKL3hT?=
 =?utf-8?Q?KpjdVFYhUiu93FIsT84DHUHZX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f90c178d-8677-4138-7da8-08dd38fd0389
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 02:49:09.3488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZwfrbK+7JLZu6DmvsVR+xtv4bMW1FTtdbyMDybWgZqBwhOMghF4o4hf83kXSTfs/YZcnGMnLKZfqEkoNqjpAuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9250

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDI15bm0Meac
iDE55pelIDE1OjAzDQo+IFRvOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0K
PiBDYzogbC5zdGFjaEBwZW5ndXRyb25peC5kZTsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbHBpZXJh
bGlzaUBrZXJuZWwub3JnOw0KPiBrd0BsaW51eC5jb207IHJvYmhAa2VybmVsLm9yZzsga3J6aytk
dEBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOw0KPiBzaGF3bmd1b0BrZXJuZWwub3Jn
OyBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+
IGZlc3RldmFtQGdtYWlsLmNvbTsgaW14QGxpc3RzLmxpbnV4LmRldjsga2VybmVsQHBlbmd1dHJv
bml4LmRlOw0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMDIvMTBdIFBD
STogaW14NjogQWRkIHJlZiBjbG9jayBmb3IgaS5NWDk1IFBDSWUNCj4gDQo+IE9uIFR1ZSwgTm92
IDI2LCAyMDI0IGF0IDAzOjU2OjU0UE0gKzA4MDAsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+IEFk
ZCAicmVmIiBjbG9jayB0byBlbmFibGUgcmVmZXJlbmNlIGNsb2NrLiBUbyBhdm9pZCBicmVha2lu
ZyBEVA0KPiA+IGJhY2t3YXJkcyBjb21wYXRpYmlsaXR5LCBpLk1YOTUgUkVGIGNsb2NrIG1pZ2h0
IGJlIG9wdGlvbmFsLiBVc2UNCj4gPiBkZXZtX2Nsa19nZXRfb3B0aW9uYWwoKSB0byBmZXRjaCBp
Lk1YOTUgUENJZSBvcHRpb25hbCBjbG9ja3MgaW4gZHJpdmVyLg0KPiA+DQo+ID4gSWYgdXNlIGV4
dGVybmFsIGNsb2NrLCByZWYgY2xvY2sgc2hvdWxkIHBvaW50IHRvIGV4dGVybmFsIHJlZmVyZW5j
ZS4NCj4gPg0KPiA+IElmIHVzZSBpbnRlcm5hbCBjbG9jaywgQ1JFRl9FTiBpbiBMQVNUX1RPX1JF
RyBjb250cm9scyByZWZlcmVuY2UNCj4gPiBvdXRwdXQsIHdoaWNoIGltcGxlbWVudCBpbiBkcml2
ZXJzL2Nsay9pbXgvY2xrLWlteDk1LWJsay1jdGwuYy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogRnJh
bmsgTGkgPEZyYW5rLkxpQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaS1pbXg2LmMgfCAxNiArKysrKysrKysrKy0tLS0tDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBiL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBpbmRleCAzODVmNjMyM2UzY2Eu
LmY3ZTkyOGUwYTAxOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2ktaW14Ni5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlt
eDYuYw0KPiA+IEBAIC0xMDMsNiArMTAzLDcgQEAgc3RydWN0IGlteF9wY2llX2RydmRhdGEgew0K
PiA+ICAJY29uc3QgY2hhciAqZ3ByOw0KPiA+ICAJY29uc3QgY2hhciAqIGNvbnN0ICpjbGtfbmFt
ZXM7DQo+ID4gIAljb25zdCB1MzIgY2xrc19jbnQ7DQo+ID4gKwljb25zdCB1MzIgY2xrc19vcHRp
b25hbF9jbnQ7DQo+ID4gIAljb25zdCB1MzIgbHRzc21fb2ZmOw0KPiA+ICAJY29uc3QgdTMyIGx0
c3NtX21hc2s7DQo+ID4gIAljb25zdCB1MzIgbW9kZV9vZmZbSU1YX1BDSUVfTUFYX0lOU1RBTkNF
U107IEBAIC0xMzA2LDkgKzEzMDcsOA0KPiBAQA0KPiA+IHN0YXRpYyBpbnQgaW14X3BjaWVfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgCXN0cnVjdCBkZXZpY2Vfbm9k
ZSAqbnA7DQo+ID4gIAlzdHJ1Y3QgcmVzb3VyY2UgKmRiaV9iYXNlOw0KPiA+ICAJc3RydWN0IGRl
dmljZV9ub2RlICpub2RlID0gZGV2LT5vZl9ub2RlOw0KPiA+IC0JaW50IHJldDsNCj4gPiArCWlu
dCBpLCByZXQsIHJlcV9jbnQ7DQo+ID4gIAl1MTYgdmFsOw0KPiA+IC0JaW50IGk7DQo+ID4NCj4g
PiAgCWlteF9wY2llID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCppbXhfcGNpZSksIEdGUF9L
RVJORUwpOw0KPiA+ICAJaWYgKCFpbXhfcGNpZSkNCj4gPiBAQCAtMTM1OCw5ICsxMzU4LDEzIEBA
IHN0YXRpYyBpbnQgaW14X3BjaWVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRl
dikNCj4gPiAgCQlpbXhfcGNpZS0+Y2xrc1tpXS5pZCA9IGlteF9wY2llLT5kcnZkYXRhLT5jbGtf
bmFtZXNbaV07DQo+ID4NCj4gPiAgCS8qIEZldGNoIGNsb2NrcyAqLw0KPiA+IC0JcmV0ID0gZGV2
bV9jbGtfYnVsa19nZXQoZGV2LCBpbXhfcGNpZS0+ZHJ2ZGF0YS0+Y2xrc19jbnQsIGlteF9wY2ll
LT5jbGtzKTsNCj4gPiArCXJlcV9jbnQgPSBpbXhfcGNpZS0+ZHJ2ZGF0YS0+Y2xrc19jbnQgLQ0K
PiBpbXhfcGNpZS0+ZHJ2ZGF0YS0+Y2xrc19vcHRpb25hbF9jbnQ7DQo+ID4gKwlyZXQgPSBkZXZt
X2Nsa19idWxrX2dldChkZXYsIHJlcV9jbnQsIGlteF9wY2llLT5jbGtzKTsNCj4gPiAgCWlmIChy
ZXQpDQo+ID4gIAkJcmV0dXJuIHJldDsNCj4gPiArCWlteF9wY2llLT5jbGtzW3JlcV9jbnRdLmNs
ayA9IGRldm1fY2xrX2dldF9vcHRpb25hbChkZXYsICJyZWYiKTsNCj4gPiArCWlmIChJU19FUlIo
aW14X3BjaWUtPmNsa3NbcmVxX2NudF0uY2xrKSkNCj4gPiArCQlyZXR1cm4gUFRSX0VSUihpbXhf
cGNpZS0+Y2xrc1tyZXFfY250XS5jbGspOw0KPiANCj4gSSB0aGluayB5b3Ugc2hvdWxkIGp1c3Qg
c3dpdGNoIHRvIGRldm1fY2xrX2J1bGtfZ2V0X2FsbCgpIGluc3RlYWQgb2YgZ2V0dGluZyB0aGUN
Cj4gY2xrcyBzZXBhcmF0ZWx5LiBBcyBJIHRvbGQgcHJldmlvdXNseSwgdGhlIERUIGJpbmRpbmcg
c2hvdWxkIGVuc3VyZSB0aGF0IGNvcnJlY3QNCj4gY2xvY2tzIGZvciB0aGUgcGxhdGZvcm1zIGFy
ZSBkZWZpbmVkIGluIERUIGFuZCB0aGUgZHJpdmVyIGhhcyBubyBidXNpbmVzcyBpbg0KPiB2YWxp
ZGF0aW5nIGl0LiBEcml2ZXIgc2hvdWxkIHRydXN0IHRoZSBEVCBpbnN0ZWFkICh1bmxlc3MgdGhl
cmUgaXMgYSB2YWxpZCByZWFzb24gdG8gbm90DQo+IGRvIHNvKS4NCj4gDQo+ID4NCj4gPiAgCWlm
IChpbXhfY2hlY2tfZmxhZyhpbXhfcGNpZSwgSU1YX1BDSUVfRkxBR19IQVNfUEhZRFJWKSkgew0K
PiA+ICAJCWlteF9wY2llLT5waHkgPSBkZXZtX3BoeV9nZXQoZGV2LCAicGNpZS1waHkiKTsgQEAg
LTE1MDksNiArMTUxMyw3DQo+ID4gQEAgc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBpbXg4bW1f
Y2xrc1tdID0geyJwY2llX2J1cyIsICJwY2llIiwNCj4gPiAicGNpZV9hdXgifTsgIHN0YXRpYyBj
b25zdCBjaGFyICogY29uc3QgaW14OG1xX2Nsa3NbXSA9IHsicGNpZV9idXMiLA0KPiA+ICJwY2ll
IiwgInBjaWVfcGh5IiwgInBjaWVfYXV4In07ICBzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0DQo+
ID4gaW14NnN4X2Nsa3NbXSA9IHsicGNpZV9idXMiLCAicGNpZSIsICJwY2llX3BoeSIsICJwY2ll
X2luYm91bmRfYXhpIn07DQo+ID4gc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBpbXg4cV9jbGtz
W10gPSB7Im1zdHIiLCAic2x2IiwgImRiaSJ9Ow0KPiA+ICtzdGF0aWMgY29uc3QgY2hhciAqIGNv
bnN0IGlteDk1X2Nsa3NbXSA9IHsicGNpZV9idXMiLCAicGNpZSIsDQo+ID4gKyJwY2llX3BoeSIs
ICJwY2llX2F1eCIsICJyZWYifTsNCj4gDQo+IEFuZCB0aGVzZSBzdGF0aWMgY2xvY2sgZGVmaW5l
cyB3aWxsIGdvIGF3YXkgdG9vLg0KPiANCkhpIE1hbmk6DQpUaGFua3MgZm9yIHlvdXIgY29tbWVu
dHMuDQpUaGUgc3VnZ2VzdGlvbnMgYXJlIHZlcnkgbmljZS4gSG93IGFib3V0IGtpY2sgb2ZmIGZ1
cnRoZXIgb3B0aW1pemF0aW9uIGxhdGVyPw0KIFNpbmNlIHRoZSBjaGFuZ2VzIHdvdWxkIGltcGFj
dCBhbGwgaS5NWCBQQ0llcy4NCk1lYW53aGlsZSwgSSdtIGEgbGl0dGxlIHdvcnJ5IGFib3V0IHRo
YXQgdGhlcmUgaXMgbm8gY29uc2Vuc3VzIHlldCBvbiByZWx5aW5nDQogZW50aXJlbHkgb24gdGhl
IGR0IGJpbmRpbmcgY2hlY2suDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gLSBNYW5p
DQo+IA0KPiAtLQ0KPiDgrq7grqPgrr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/
4K614K6u4K+NDQo=

