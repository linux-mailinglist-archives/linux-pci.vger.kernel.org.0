Return-Path: <linux-pci+bounces-7144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7B18BDCC1
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 09:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10466B21D9B
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 07:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E47913C809;
	Tue,  7 May 2024 07:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eHCkEoMo"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2083.outbound.protection.outlook.com [40.107.20.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05FA78274;
	Tue,  7 May 2024 07:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715068440; cv=fail; b=OIQoqTxW1kMOIwWLJ63ldakx79BP0WYnK47TkU+ha+05gq1mfstgu6ALqfAfQDnQtYxEnqA/qYhaPMwXWcrLCCUoyVpOaqLVkwzDWTReYJdo7zVkYDq9WQWH3oYIz8n2oZ7+ElooNPVx6TJMlpSUGQAjF/N/epgE7AWHmHOw8bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715068440; c=relaxed/simple;
	bh=TnLfL2J9qivztWvhLaWUfEiEWrgAKzN1viNiX7ORNM4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q2luWwe5fb1ShIw2lPWefe3iGv2UZOP34QPxXpd84AnYq9OwYUe7ypUDrlk6kz3MSrjK8QRhHVHuyPbdae0Am/23SHKlcJenEn1esOW35fuBUvkPn+i991uOYKMenY25hGFuJdh7CNAzoMH3odROLEDT+qx+ShriGhm7IzVS0/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=eHCkEoMo; arc=fail smtp.client-ip=40.107.20.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jvf5vCE2EHozKxizOLP7m8Ari3WJ3EpcsJral463Nx0PBVvz1KgdjRe5dVuaB2Rwni93l7kW9+sGkcjqfXXhCQhAkg/B5q7I5FUyyvkpYhLyb5ieUSq7W55iQPG4mdtuvf1CjYSWq7xrxx4HgRSLGQoKJQ1Dr1q7IGTWmP1S81Ps2emFx4SUQoKocqV3u9ZH3QfsuvFeP6et4b46K9tcbh4jWnMzw1mmgqGm/tM2fg8O8Ny0Q5+5/GpDWn+HC3HLnaYyFcCvW2w6HFhBUEdZXd9popid/oB/d6IjeIwGauGAv94c+aQxhWNUQwZJV9a5/PAxoMHxZdazzSCAMjJSZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnLfL2J9qivztWvhLaWUfEiEWrgAKzN1viNiX7ORNM4=;
 b=GIMDdM8SUnylPNNbxdcAscMo3QdAV3ofEy1OS3QTCOV/TibuxIhtEegi50VpYIu0IqvirbzXrnt8c0eV7ifrXX8kx4GESA16PUWEER3qmGMQlVBbnC7jpNfv1GbH/zmQL59O8PDPsE9RCf7A9pfELjbT3Ay+Fx2YxZJFYlmqjju7DbMLlcAyocWt6lkoFyqj4xTwMq/45nU1CEIv7m83llYDuKd5rSsYPeYOiGWcwC6YDandkIFepHWTj3xbFp3flnmBN4vs5YVjvInApIAPajlo/szYDVY4UpkQFh8Ar/DyjoyHNv38a4eTYI72h2T7CUWN6IvpWBRExf9POOCfHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnLfL2J9qivztWvhLaWUfEiEWrgAKzN1viNiX7ORNM4=;
 b=eHCkEoMobUz+1R0LkkpoUVrRPwtf8kSo81l0UcptbCAsbxDaQ5xmlPqdQc0FlOW0A4MerL+IB74hJgHBKFG9MthSRRDX3rrM273KUrQttBcGbtW75eLzXfaug+fVaVKlKmJ1H11Mbh3wtDYG4icRs2w9v0lYqrHTKRSq91dufyQ=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8660.eurprd04.prod.outlook.com (2603:10a6:20b:42b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Tue, 7 May
 2024 07:53:56 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 07:53:55 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Frank Li
	<frank.li@nxp.com>, =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?=
	<kwilczynski@kernel.org>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@pengutronix.de>, "linux-omap@vger.kernel.org"
	<linux-omap@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Vignesh
 Raghavendra <vigneshr@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Lucas Stach
	<l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Yue Wang <yue.wang@amlogic.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Xiaowei Song
	<songxiaowei@hisilicon.com>, Binghui Wang <wangbinghui@hisilicon.com>,
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
	<jonathanh@nvidia.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>
Subject: RE: [PATCH v3 4/5] PCI: imx6: Convert to agnostic GPIO API
Thread-Topic: [PATCH v3 4/5] PCI: imx6: Convert to agnostic GPIO API
Thread-Index: AQHamh+N7/JPYv0UREicl3G2olSnu7GKKIAAgAFEtQA=
Date: Tue, 7 May 2024 07:53:55 +0000
Message-ID:
 <AS8PR04MB8676BD0B2C6BB61EA28D59E08CE42@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20240429102510.2665280-1-andriy.shevchenko@linux.intel.com>
 <20240429102510.2665280-5-andriy.shevchenko@linux.intel.com>
 <CACRpkdZUsA034L5GjF_-XELX9369PwNjONfsDV-_EC564R0QWg@mail.gmail.com>
In-Reply-To:
 <CACRpkdZUsA034L5GjF_-XELX9369PwNjONfsDV-_EC564R0QWg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AS8PR04MB8660:EE_
x-ms-office365-filtering-correlation-id: 0765ffd2-14aa-41a4-400b-08dc6e6ad872
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|366007|7416005|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?bkkwNkZTQ1k0QmJSTXFnclVUU0lhVXQ1OTZEbUF6TUdlNTUwQmU1VVhQcGdJ?=
 =?utf-8?B?V0YrNmxHV1lTblByVlhVR2lsb2t2SjhoNTdlY2pRMlh2VXRVOXZPUkIyc3g0?=
 =?utf-8?B?K0xPS3hKazMrWFZSWkVLbDRpSnJoaG9OQlhuallZbHhlNEtqMXZBUXNYN2Zr?=
 =?utf-8?B?TUN0VFFzQURKdHJ6SnZURFhiMGp6Y0pHL1BRVjl3MUlWYk96RytaOXdST2xr?=
 =?utf-8?B?N3lmRFdna2p4UWNEdlUrdERoVlQxYWJQanZmbEdScXArYlptTVEyRi81MUdM?=
 =?utf-8?B?cVpOVTg4Mkhlak1LT2N6cWpGVDg0Nk9oYnZDZjJRMTdKbERsMi9vb2pEZkJR?=
 =?utf-8?B?TWR5dkxNU1VGbGQxaEFUajArRysvMEVyNmZ0YVIzWmxXWVZMMDdxY29QOGxw?=
 =?utf-8?B?RCs4dWxMRkN6ZUI2NTdobTR0VEZnM2tVMG84eU9Sak44aCtaWUFxRGg1R3Vv?=
 =?utf-8?B?VlBYL2tlQmEzU25PRHZuM2l4ZTkwTUZaSkxCajVhTXJsOXhhTllNNzJCSlVr?=
 =?utf-8?B?TkxJSEYyeWJia1BuYzFzVjhmWFZFWUs1NUwwbVoxY24wOTBtSUFPRVppbngy?=
 =?utf-8?B?U1hGVHRwRlkrd0hEZ2FMMTMzdlFIN3R6b3BERTlyVkNrZlVJQ1dqWmlXbjFD?=
 =?utf-8?B?ZWtSK0U5UDRveDdlUUhteTlNY2dZNFlTT04wQkxFQUZRdklIaVdNeGh0cUI2?=
 =?utf-8?B?NE9wV0NXNWxiM3BLb3dnd0FHeXg4MEZJMUtMUmVnMnZNSCswamxtYUIzTThO?=
 =?utf-8?B?OTJRbHQvYlRnTlBZY096RWh0RllzbGRzS2V1dms5TEtCazdQUGg3YVFpSEZY?=
 =?utf-8?B?cEVKR3hOL0lkVW5DTjhDeFNHLzFibVR3NFg1MGtWYkplQWp6Y0VyR2k3WHJO?=
 =?utf-8?B?cG9tYUp2WXVVR2MvdVpjSkxGWmxoWXZtVFhLVW1LTExNd0RtZUdzVVNPQ0Rj?=
 =?utf-8?B?RTJlMmlqa1N5Wlp0dVJGY1dlRW1Pdk81S0p0QWdIVFlXRHdvbnU5NFU0WFUv?=
 =?utf-8?B?NUgyTWdoRTJzam56MjVoMjBCbE85azh3SU5kTlN1RkUyRC8xZnZsTUhqam1u?=
 =?utf-8?B?SjRIWloxSFR1MS85U01kKzZVRTBwYUpQQ3oyRXNvYXowK01EQjRMakNXNE4y?=
 =?utf-8?B?YUVZMko3NlpNRnN6ZDZ1dVJVRDkvNVFaQWd4UWZWSkQwdkZNS0ROY1paU05S?=
 =?utf-8?B?TUZoWUN3bFAyTXZxMENLSHRCcVJhK0JGRTJ6bWx1R0JUbWlTVUcxRkpQbXdj?=
 =?utf-8?B?cDJsQ0tPem1ZeUs3OXNkdlArVkpEZmFJY21RYlBPWks2TTdLTzVrY2oyWkJG?=
 =?utf-8?B?QXVkZDRQN3ZKSkJQUkdjdlBuYWV3VFJHWkh1a0ErWTMrczU4WDhoQWdZRTg0?=
 =?utf-8?B?cUk0NEFOVXMxUGw4Wjd2TXhBSFJCeTVyMW9zRGNDZFpVeTJPZFB3NlpaSWtV?=
 =?utf-8?B?N3FTRVFLc0VHNjBWR2pmckxKWGxZV1ovUW85VllBSFdjNmhwdGdpc3JKb2t4?=
 =?utf-8?B?bENRUjZSbjgvRWw0ak5PelNESGFQVDZjajc5dGJKTm9UdkJHVHRIbFYyU1V3?=
 =?utf-8?B?aEJTbEx6NFpzaUk1N3dmZ0pvd2RCbThITUk5TGo2Q3Z4QjJQcTJIM1VPN2du?=
 =?utf-8?B?UGlDeG1vWDB5dUQxTWlxUFdyQ2xPQ2VCSVZXdGZMcGhnQTYzdU5nVG5CaTk3?=
 =?utf-8?B?NUZna3kwTVVqUkw0NVIrTitiaDR2K3cxSmg2eWN2Q0lnQ3daUElmLzZHVW9l?=
 =?utf-8?B?Ukp4Uk5QRXBwd2pYTCtFaHhXMzFxNWpqNElvcW02YmZYMWdQYTl4SE4zWU9J?=
 =?utf-8?B?QTJPR3F1MnhKbldQL0xiUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dzJRckxXa0NKNWRiS2p4c2pDU0V4ZTU5RTExSTdScDUzTGpnSE05Y3d3eWI5?=
 =?utf-8?B?RURaQ0FNc04xcW9CWEFMQ0llVlRpY3pQSkZyQWNKTW5KWjZ0NU9jdm1GcUdh?=
 =?utf-8?B?d2s5WW0raGEzcDNreUhsdUtDQ0UwOFV0QjZ3TWdGbzJzUnJWbXpxUHZZcFA1?=
 =?utf-8?B?MzF1bDRrNEZMLzdpYnZRcTYxaUswZDFXUlRzV1VFMk15VWN5WFlkaUxuQ2V0?=
 =?utf-8?B?b1l2OVdUbjBJUlR3SCtIaytEUTB5VGtQV21FV3cwRGl3LzZoOGYrS3gyNGxU?=
 =?utf-8?B?ajU4bjRtOWxKemtjQlViaHJNejF3YjBFbEp6VFFmY0ZzMU4rRkxETzhmaG5m?=
 =?utf-8?B?Q3ZJT3RvT2QvVEdVNExKM0J6ZjdSR0xIVldzZDFlSTZlN2pEUG1nT1hQdzV2?=
 =?utf-8?B?QWZHQWg5Zy8rNWQ0L21yR0MxVWI0WHk3WDFja1BMeGtSOU9lTTIxY3RPRTlQ?=
 =?utf-8?B?aDBBcWlYQTJLRnFQWW9tZVEzWEUvbzJJTDdPdUNCejRWelh5TVMzRUJ3dDZk?=
 =?utf-8?B?NFdWQlFHbmZKTTJrTmpDSGZzVjg3dkpVeCtjSXRVR1BXUVJ2MEZqdTUzcE9j?=
 =?utf-8?B?ZzdWR3cwcGpxN3J5U1ZHaStGdDNsYlljY2N0dkRndk1ydGhtRjc3aFBHU1Jr?=
 =?utf-8?B?cUFFYjZDU2dEaE1ZcXByUEhhWit3T2xhZkYxVnZuNjNXbHBGM0xqYTNJUjRz?=
 =?utf-8?B?TWNGRG5TMHNWZVdwa2JOR0NLb0g4QWxsUmlES0dIMW5sZzk4RVBlL3ZFYmJL?=
 =?utf-8?B?eUVvNFYyL29KNm5WUTRpQkZPdmc4RmlSTFltT0xQOWNPeFF0bThON29LQ3V3?=
 =?utf-8?B?c3pYd21kU1hORmwyN3JYVUVXOUNmZXBQRzlQTVBGaU01akNJVlFKTU96cFlu?=
 =?utf-8?B?S2NhSXBiKzk2My9sQU9PMFNRZEdMMS8yTW5LQUdGT1lyYkQrRXJmYUFhMU1H?=
 =?utf-8?B?OStEQlljY2FkR1ZTMHpCWEFwK2x6bVExV2ZJSlNYLzlaMDJYZEl3S2d6YXY1?=
 =?utf-8?B?T3paS1BQQjdhbmxKcm9OY2RaeEp6bXIxWmJkOTJ1M0ZGV2ZoV1dSVVZYNStY?=
 =?utf-8?B?cTh0QklVZ0ptaWdLZ0tObVZ2SHErS1hCVUFsVU0ycm5QNm1VTGpNb1NmOGdl?=
 =?utf-8?B?YWhTZ092Q055NlJXemx6dS9wbmg1aUJVN3UwUmJKS2owUExEZ3hPbHl6S1NE?=
 =?utf-8?B?blFlTGxRdlN3TnIydE15dnYray9yRGNrUVE2WVRCMkx1ZEMxREtWWjk4MDlu?=
 =?utf-8?B?S21uWG5vQythYkJLbWpCS1h6TkhxODk5TVRNbXZOS0pJQUVUcGJWR1ZTM2VB?=
 =?utf-8?B?Q0hzMWhEM1VJNmt5NENGOXNNT3NxSEtycjNONHRPZ2g1c3pDNUphMFJkSmtz?=
 =?utf-8?B?eCtLZEJJbnZNZm15VGNHWkVJNjdCMytsQTN3S3Urdm1wcnRiMEJGV0drd1Iz?=
 =?utf-8?B?ek1jU2FETHNJLzgvZVlObWw1MFVpY09MaW5PdFdlb1JJN1JUVzFKYmNVV1BG?=
 =?utf-8?B?TTFxU1dvUGFINC9kcWVJVHZXTUdXR2lUZTNFaXZHS1NQQzY2WngzY3dobEZa?=
 =?utf-8?B?QWplb1ovRGxERS9hR0dnVmwwMVZESWxURHFxVkw1ZmlTaWNqUEpzWmhSa0J4?=
 =?utf-8?B?L0JBQVRIRU5sVVlvcDg1d0twZ1BpY2p2K09GV0R6WHd0R3RkY2Q0NFNlOGsv?=
 =?utf-8?B?a2UzRUY2UFBtUGMxU0pKc0F1dHBET2VhMGVmbk04VFJBOGZsQ0plb21oY0RE?=
 =?utf-8?B?UFNLS3ZCUzNoUFViMXI5a3J3enRjTXVkVVh0SGZLcHdFd2UrMVpGVzFVNldr?=
 =?utf-8?B?SE5MY3hvdDhaQUJZS01EU2FDZGNuaVdYQmxaM0NBb0xlYS9uN0RCZzRyM3ZU?=
 =?utf-8?B?ekdtcFJtbmJpeU9qY3loWXV2VmdPWVhoVUlwSmtpMFFKOGlUWHlhM0VmdlAy?=
 =?utf-8?B?TC8rZ013TG1RYnJnL0pxZjlrR3FlT2xlbWw5WDBlV0J6SHZZaGh5eDZwSW9u?=
 =?utf-8?B?S0xDWmNwWEZsZExVK3JGWFl2c2FVYndERTNXSEFGemRLQUVvdE1mUnpFYmJ2?=
 =?utf-8?B?QXpYMC9PR3hQekVTSno3UCtRM09aamliWENEYjJva3U5czhhWU9KTWx2V1VZ?=
 =?utf-8?Q?QC8dPp+fb/mcjCCxAZaySemfC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0765ffd2-14aa-41a4-400b-08dc6e6ad872
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 07:53:55.6280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HYiIioh+P0wX7+K+EDR5VHGcETKuym2Lr8ZqTe2ccNOCdMLFAjbZwVs8hMHB5S4VZTtkKibbHXP7jqA3RFuDfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8660

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW51cyBXYWxsZWlqIDxsaW51
cy53YWxsZWlqQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMjTlubQ15pyINuaXpSAyMDoxMA0KPiBU
bzogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQo+
IENjOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8u
b3JnPjsgRnJhbmsgTGkNCj4gPGZyYW5rLmxpQG54cC5jb20+OyBLcnp5c3p0b2YgV2lsY3p5xYRz
a2kgPGt3aWxjenluc2tpQGtlcm5lbC5vcmc+OyBVd2UNCj4gS2xlaW5lLUvDtm5pZyA8dS5rbGVp
bmUta29lbmlnQHBlbmd1dHJvbml4LmRlPjsgbGludXgtb21hcEB2Z2VyLmtlcm5lbC5vcmc7DQo+
IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgaW14QGxpc3RzLmxpbnV4
LmRldjsNCj4gbGludXgtYW1sb2dpY0BsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1hcm0tbXNt
QHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtdGVncmFAdmdlci5rZXJuZWwub3JnOyBWaWduZXNo
IFJhZ2hhdmVuZHJhIDx2aWduZXNockB0aS5jb20+Ow0KPiBTaWRkaGFydGggVmFkYXBhbGxpIDxz
LXZhZGFwYWxsaUB0aS5jb20+OyBMb3JlbnpvIFBpZXJhbGlzaQ0KPiA8bHBpZXJhbGlzaUBrZXJu
ZWwub3JnPjsgS3J6eXN6dG9mIFdpbGN6ecWEc2tpIDxrd0BsaW51eC5jb20+OyBSb2IgSGVycmlu
Zw0KPiA8cm9iaEBrZXJuZWwub3JnPjsgQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNv
bT47IEhvbmd4aW5nIFpodQ0KPiA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBMdWNhcyBTdGFjaCA8
bC5zdGFjaEBwZW5ndXRyb25peC5kZT47IFNoYXduIEd1bw0KPiA8c2hhd25ndW9Aa2VybmVsLm9y
Zz47IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT47IFBlbmd1dHJvbml4DQo+
IEtlcm5lbCBUZWFtIDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+OyBGYWJpbyBFc3RldmFtIDxmZXN0
ZXZhbUBnbWFpbC5jb20+Ow0KPiBZdWUgV2FuZyA8eXVlLndhbmdAYW1sb2dpYy5jb20+OyBOZWls
IEFybXN0cm9uZw0KPiA8bmVpbC5hcm1zdHJvbmdAbGluYXJvLm9yZz47IEtldmluIEhpbG1hbiA8
a2hpbG1hbkBiYXlsaWJyZS5jb20+OyBKZXJvbWUNCj4gQnJ1bmV0IDxqYnJ1bmV0QGJheWxpYnJl
LmNvbT47IE1hcnRpbiBCbHVtZW5zdGluZ2wNCj4gPG1hcnRpbi5ibHVtZW5zdGluZ2xAZ29vZ2xl
bWFpbC5jb20+OyBYaWFvd2VpIFNvbmcNCj4gPHNvbmd4aWFvd2VpQGhpc2lsaWNvbi5jb20+OyBC
aW5naHVpIFdhbmcgPHdhbmdiaW5naHVpQGhpc2lsaWNvbi5jb20+Ow0KPiBUaGllcnJ5IFJlZGlu
ZyA8dGhpZXJyeS5yZWRpbmdAZ21haWwuY29tPjsgSm9uYXRoYW4gSHVudGVyDQo+IDxqb25hdGhh
bmhAbnZpZGlhLmNvbT47IFRob21hcyBQZXRhenpvbmkgPHRob21hcy5wZXRhenpvbmlAYm9vdGxp
bi5jb20+Ow0KPiBQYWxpIFJvaMOhciA8cGFsaUBrZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYzIDQvNV0gUENJOiBpbXg2OiBDb252ZXJ0IHRvIGFnbm9zdGljIEdQSU8gQVBJDQo+
IA0KPiBPbiBNb24sIEFwciAyOSwgMjAyNCBhdCAxMjoyNeKAr1BNIEFuZHkgU2hldmNoZW5rbw0K
PiA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+ID4gVGhl
IG9mX2dwaW8uaCBpcyBnb2luZyB0byBiZSByZW1vdmVkLiBJbiBwcmVwYXJhdGlvbiBvZiB0aGF0
IGNvbnZlcnQNCj4gPiB0aGUgZHJpdmVyIHRvIHRoZSBhZ25vc3RpYyBBUEkuDQo+ID4NCj4gPiBS
ZXZpZXdlZC1ieTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1A
bGluYXJvLm9yZz4NCj4gPiBSZXZpZXdlZC1ieTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+
DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0Bs
aW51eC5pbnRlbC5jb20+DQo+IA0KPiBJIHRoaW5rIHRoZXJlIGlzIGEgYnVnIGhlcmUsIHRoZSBj
b2RlIGlzIHJlc3BlY3RpbmcgdGhlIE9GIHByb3BlcnR5DQo+ICJyZXNldC1ncGlvLWFjdGl2ZS1o
aWdoIg0KWWVzLCB5b3UncmUgcmlnaHQuDQpBcyBJIHJlbWVtYmVyIHRoYXQgdGhpcyBwcm9wZXJ0
eSBpcyB1c2VkIGZvciB0aGUgYnVnZ3kgaGFyZHdhcmUgZGVzaWduLg0KSW4gZ2VuZXJhbCBpbXBs
ZW1lbnRhdGlvbiwgdGhlIFBFUlNUIyBpcyBhY3RpdmUgbG93Lg0KSW4gcGNpX2lteDYgZHJpdmVy
LCBpdCB1c2VkIHRvIGNhbGwgdGhlIGZvbGxvd2luZyBjYWxsYmFja3MgdG8gdG9nZ2xlIHBlcnN0
Iw0KIGdwaW9fc2V0X3ZhbHVlX2NhbnNsZWVwKGlteDZfcGNpZS0+cmVzZXRfZ3BpbywgMCk7DQog
bXNsZWVwKDEwMCk7DQogZ3Bpb19zZXRfdmFsdWVfY2Fuc2xlZXAoaW14Nl9wY2llLT5yZXNldF9n
cGlvLCAxKTsNCg0KQnV0LCBzb21lIGJ1Z2d5IGhhcmR3YXJlIGRlc2lnbnMgdXNlIHRoaXMgR1BJ
TyBzaWduYWwgYWN0aXZlIGhpZ2guDQpBbmQgdGhlIGNvcnJlY3QgdG9nZ2xlIHNlcXVlbmNlIGZv
ciB0aG9zIGJvYXJkIGlzIHJldmVyc2VkLg0KIGdwaW9fc2V0X3ZhbHVlX2NhbnNsZWVwKGlteDZf
cGNpZS0+cmVzZXRfZ3BpbywgMSk7DQogbXNsZWVwKDEwMCk7DQogZ3Bpb19zZXRfdmFsdWVfY2Fu
c2xlZXAoaW14Nl9wY2llLT5yZXNldF9ncGlvLCAwKTsNCg0KU28sIHRoaXMgcHJvcGVydHkgaXMg
YWRkZWQgZm9yIHRob3NlIGJ1Z2d5IGhhcmR3YXJlIGRlc2lnbnMuDQoNCkJlc3QgUmVnYXJkcw0K
UmljaGFyZCBaaHUNCj4gYnV0IHRoZSBjb2RlIGluIGRyaXZlcnMvZ3Bpby9ncGlvbGliLW9mLmgg
YWN0dWFsbHkgaGFzIGEgcXVpcmsgZm9yIHRoaXMgc28geW91IGNhbg0KPiBqdXN0IGRlbGV0ZSBh
bGwgdGhlIGFjdGl2ZSBoaWdoIGhhbmRsaW5nIGFuZCByZWx5IG9uIDEgPSBhc3NlcnRlZCBhbmQg
MCA9IGRlYXNzZXJ0ZWQNCj4gd2hlbiB1c2luZyBHUElPIGRlc2NyaXB0b3JzLg0KPiANCj4gSnVz
dCBkZWxldGUgdGhpcyB0aGluZzoNCj4gaW14Nl9wY2llLT5ncGlvX2FjdGl2ZV9oaWdoID0gb2Zf
cHJvcGVydHlfcmVhZF9ib29sKG5vZGUsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAicmVzZXQtZ3Bpby1hY3RpdmUtaGlnaCIpOw0KPiANCj4gWW91cnMsDQo+
IExpbnVzIFdhbGxlaWoNCg==

