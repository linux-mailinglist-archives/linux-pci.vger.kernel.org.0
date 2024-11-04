Return-Path: <linux-pci+bounces-15901-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 330369BAACD
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 03:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1C941F21C33
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 02:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ECB16C854;
	Mon,  4 Nov 2024 02:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nScjvQzA"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA17166F31;
	Mon,  4 Nov 2024 02:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730687165; cv=fail; b=rEEwI4KPRYuZX68SKVbGIbSxf1YLEzH6wnFo2p1WCSdCK7grkxE8G9oMXSQVvnnWve6NLuPAL9hq+bE3bWeWF+CvbWhlhdNu3OjgXSaykG1FYjUPLuwAVZLbOt3wNmc+hcqz2KQl3M4mAEV/DBWXr3c+vK7gqNddzXvmZkuTJQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730687165; c=relaxed/simple;
	bh=8d9Lz9ZjLzXhAW9x0OE0T7z8v3jQYrspb9xVH3moFfA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AbwwV8o55B0K0M1E8ZVjJd5yI1SnCYxCyAB7vVB9O0aGLBboEffhXUnl2hTFmwUW8iVhONkqA1z6+QCcXNgITPakbPbaijuAF/PQVJGrGJiDo9gvU98pUEWCCFLjOsCZyaDXP5H+qRpo9/B6fdnWxKQfoUilGTXRaDuIX/fHS/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nScjvQzA; arc=fail smtp.client-ip=40.107.22.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEy4haEZ1re+2yP0YBEdThfBaICbuxmtrrjZmQp3rK6UYJt0IX8suMCSZQyaLIpx6wh8lKRxZfP21rGxIUUlm7WzCN1kdCW9xtz53ks1vi7KSZBjR0wQPzbpt3m6fgKOZY6OIZI8W03aaUCKyU8c+7XY2uwXaxeeWhhAfQIt1bxJsEWwPSgy0x++FDVzwecfdXVDfGPNMIc7WwjfEMQm3Hg0nfpRBKJUDudPWkwJPulzZtqknDbcCjhusnYYpGObs8JRaWX38B/rrZxEi4U1wW3uqtz5VaeOANhpSc8DHD7yci5YVfxb2cT9NL5v4gGTlZ7vUYv3FwDDbSFzcsPwrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8d9Lz9ZjLzXhAW9x0OE0T7z8v3jQYrspb9xVH3moFfA=;
 b=Vjbjx68TQykDVpUAtz5gvjX1VUTo/eHuJ5U+TF0DeqKNvHrjc9J9CDd+/ALZ4af4YefATOENPUEVfhvZYvvftTluRDFpXMhgd9DDqMvWubWERTc3TlC7zuCjX5BGXGf1/EwTLVr7hVmDye5rdEDKuf9rI9Z84MAgCCE5D+wbs0BmS/5umP9LeI1hDo19GyGjz5cT+rIb284KPfP4wBl7tY6bt1IsvQrMW7eJZVlg8vwZ0dmU2+k8zWBI2Un+s/vwDxOAF6hCEBgh5jb8QPJHTnJGSOCKuSWYZ4iRiOGXV3zGmKZcgC0aoMspHOunHwLCxNZ60O7xPdvGbSAO+A+R2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8d9Lz9ZjLzXhAW9x0OE0T7z8v3jQYrspb9xVH3moFfA=;
 b=nScjvQzAjYPWjrcZA7jvXJH/BDTe8Sw6xVVcDZmsjxRdpeYeIvVo0k9/Ygml2B/3jY6kP5uMYcHtcl7obm0E8FMQJIDPjtXTt/9Ick47W9J2RJk0Q/c8yEXtHGaGyrKaLfUMeQ/LgBDROaOrA6p+pXB0MVk4Xp7j0yRxLhR0YbteMCw8Ef/KHGvjQLm+M8ayNXZFlUvYu79JUwvKtkWbOusmrGV3CegzuZ76jIc4+x9BkMq70l+kGqqJD1BYmC5p8g0rYQh8FBoKLCQaI0y7Bnq119315e+dcjfWrOwTkt9BFcUt32pef5HpjoJw+xT+1aCnDCjf98Gsr3DDNkmhMQ==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAWPR04MB10007.eurprd04.prod.outlook.com (2603:10a6:102:387::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Mon, 4 Nov
 2024 02:26:00 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 02:26:00 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Frank Li <frank.li@nxp.com>, Rob Herring <robh@kernel.org>, Saravana
 Kannan <saravanak@google.com>, Jingoo Han <jingoohan1@gmail.com>, Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?=
	<kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>, Lucas Stach
	<l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [PATCH v7 4/7] PCI: imx6: Remove cpu_addr_fixup()
Thread-Topic: [PATCH v7 4/7] PCI: imx6: Remove cpu_addr_fixup()
Thread-Index: AQHbKiDLNx0EZULO10uUCiykcU0wZ7KmbHgQ
Date: Mon, 4 Nov 2024 02:26:00 +0000
Message-ID:
 <AS8PR04MB867621820038DE62CA39D93E8C512@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20241029-pci_fixup_addr-v7-0-8310dc24fb7c@nxp.com>
 <20241029-pci_fixup_addr-v7-4-8310dc24fb7c@nxp.com>
In-Reply-To: <20241029-pci_fixup_addr-v7-4-8310dc24fb7c@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|PAWPR04MB10007:EE_
x-ms-office365-filtering-correlation-id: d3f859a7-1a09-45a1-00b3-08dcfc7805ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?TzZVdFVrQ1czblZ6SnRZemUxVUlPejhRdzhiYUZYT0sxLy9ONGtaaXhKcitO?=
 =?utf-8?B?MDFTQ1BmU01pUmpSR3lqZndvcWpmS3VEREo1eENySy83T3RGRWg1RHFvYW5D?=
 =?utf-8?B?NDM5N0JuNVpWSWxMaXNUQW5tajNyL294eHMxTlFmTUVjZDlaOXpOcDBLR3hi?=
 =?utf-8?B?TTRYQTlmaTl2ekhTWlVtK05udXZNa3dtTmI1NWRGQTFDVEtrTmh4bmViZWZw?=
 =?utf-8?B?cGZvVFloNlZoZk9QMUNraTJ1UVJvT3I5QVpwdTRRVm9aNFhxL1MxRnBYVzFl?=
 =?utf-8?B?VUpLVEM2SHh1ZmdvdlpuM3o5WGJzcElZdEh5T1cyTWFueGVPMy9PSk50UXF0?=
 =?utf-8?B?cHZTdlhjbENIWEdKNEE5YXoyNEhOQUJXOVNHSWh4Y3BkSUpYZDlpZEo2OHR5?=
 =?utf-8?B?ODZMVzlGeFRDVFo4OXNlMVVNb1l6TzdIWjV6c2kzOVBhbGl3aW1lZWYzNFpa?=
 =?utf-8?B?WFFVY3pVb0hmUFdLTEhDd1FPRGp3ZjNmQ240ZEtYSlNxZGU3WHNGZG1ZMjcv?=
 =?utf-8?B?RE1BeU04bVRIbDVBK212TkhHVG9KS3NWV1VOclJhNTZ0ZTljOFlpQ0ZlVlho?=
 =?utf-8?B?TDdzbTZRdmpQa0tTbTNzMmpCMVBJNi92bGY3UjNDbEpFZ1pZeHh6QmxvTzV5?=
 =?utf-8?B?YVNXdHgyNzhtVVg2MThJckd4OGhFRWs4NlpBTFg3RjhETkxKdTZsWmc2WG9S?=
 =?utf-8?B?UEJpVnVqUktSUGhYMTJJWitPMW1QaVhINzJQYTJDOExhSkE2SmkrQ3c2blNn?=
 =?utf-8?B?U1hkMXU1dUVUbXd5UVFLNGpjQ01HZE4vUzVaZXkwS0l5bkxrSnY0bjRISFNM?=
 =?utf-8?B?VkhqZFR3L2hkMFFzK1NGeVdpYks3azN3blNscytHbDFubW5CRk5pWngwcnRr?=
 =?utf-8?B?cTRBQWdpME1SZTZCbDdvYkU5Qzk0R3hxZHFuWmFvcDZKdElVUmR1OGZVOXdL?=
 =?utf-8?B?Vm9kSUY4YXJkVk1jZmJZTHl6U053ejduVFE1d0dhTXI0cEN1SDFtd1RKWmhs?=
 =?utf-8?B?YXlkTEE2OHVVN1J6RTcycjlWK1ZFWVFYYit4cnlwNlU2M0V1ZzlIZWMwSmdZ?=
 =?utf-8?B?aHpzWTExcDgyZEw2eW5Od1J1MGpYeDNIUzZXZCtqbXZpek8wS2xOTUd2VXEy?=
 =?utf-8?B?SXN6TUFhbHY3RDNSaStMckh6NTc0S3k2bmJmM2luZEFkZVJJSUlma3ZJRTNt?=
 =?utf-8?B?NnRQRUJHakU2NU5DR3FXaHN3L0lmdnJJWHlWZWJmZEZDaVA1WU1YV253dlpz?=
 =?utf-8?B?VGJMRC9jK2lRSjF0WWxBdkNLaEg5WERpeG53MG9UMU41M1EwNjRBMnBPNWRr?=
 =?utf-8?B?NjZieDNmTXZoUGphdndadzI1SWJwdmlRbDEyeG9rTVROVXA5TDVKSXZ1VGVm?=
 =?utf-8?B?V2kwUWdLOG9oZllqOTdyeHR3VDN1VFh6dDd1cnNKZWx3dWd3dExDR1Z3WEdX?=
 =?utf-8?B?UE1TSVRFdkxRZzJzV1lGbzJ3MHdOdnJNMXM5QVFYMUdNK01taXQyQ1cyTkxY?=
 =?utf-8?B?Sm9YT1VLV2hHRENjeVZSR0Q3MldrSEovWWx0UXFONjRvVjZEeDB6aHdJRHVB?=
 =?utf-8?B?RzU3S3p2M2txdjdwaFJ4ZnVNeFlZS09DZ05NUHlNdXBBNUJwOUdmVGpZbXdW?=
 =?utf-8?B?N25TS1hrZzY3UEQ0SVpjVHA2VExoOXNHNlhUTFpwcVo1OURDYjRtSzNvcksy?=
 =?utf-8?B?eURtSUI2TFBJYmNiMEcvQnZQZTlsMHpsSVZTbWFnSURGYjVYdVFzZkVwOGxj?=
 =?utf-8?B?MWdjQnlKLzNBaW9zeTh3MGtuZ0E1TGk5NHNYN1JPc2RuZEVZTnR1NXA1SitX?=
 =?utf-8?B?MWYyeDBmWEZzRDd2bmsyV05CL1pTeWc1cnVVSlA4dVRrZnBWNGlaOXNTS2Nw?=
 =?utf-8?Q?SGF8F+JXWKj/y?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OVRucmxNZVo3VFRXRGVYQlV4ZjJFVHhTQ3hGanNMYXozQ0RhMUM2Y2NuODVN?=
 =?utf-8?B?TlFkdW1uR1dXbStoQlpYODZHZ2tNMXMyc2dwWjdJS3JIVGRCV3N3YVFlQmNj?=
 =?utf-8?B?b2lob0pDaXFUeHVkQ1lkVnlVemNkcGkxQ0ZhZDI1aGNPRUk0dzhyNWJpMlRy?=
 =?utf-8?B?a09uV205b0IvZWhoQ2x6bmYxNDJDMFE4aVRtRWpKVm1uQTZlbUVXbmwyY2lY?=
 =?utf-8?B?c2VXRStjMGdNVWFadXFLM0o5UHFzUk1tcVY4UXZZbkJpVDF2N2htRkh4dHlK?=
 =?utf-8?B?dUhqVjcyRFpUQVNFZEFCanAwb0RJREhYTHVmNVhDbzF0VGQ1OG1tWnB4OVBL?=
 =?utf-8?B?Wi85TitrNjQvZit1OTIyOVZxQVl2M0hCN0ZIT2pQL3JBeGJLcGc0QXpEdFRQ?=
 =?utf-8?B?ZlIwZWdEM0hwZDFmM3hZeG9PMHp4NTRUK1p2TVNIZE1OZmlYMGZRRytvWm4v?=
 =?utf-8?B?N3hYdmxNb3FvRDRYSk5HbDRkamUxaVZ5b09VZndqdVpHOFAzeTRLVGw4a2hu?=
 =?utf-8?B?OEJITVRXSmFMRmhXaVo2aUdxTkFuUHl1aGJGN2Q5QjVuV21ZSXZ6NUV3U3gw?=
 =?utf-8?B?UkNJYnBzbHQ4Qzc0V1dOUmtGbmFRbk9UUGZCY0lsN3JHQjRMa3ZMSDAvMW1t?=
 =?utf-8?B?SVVuV3M3MmJYWm5LK2NmNk51NHV3NTE0MFhRVHFqclFmWDE5bDl1VHM5bFE4?=
 =?utf-8?B?TEdHa2RFUFVxMWFaSjRGMnk2ajdUcDlvTUE4alFJSlp6VU5mZUpXNldoNTEv?=
 =?utf-8?B?eWM1NFg4d0pXZ1ZueFVjYVhhS1BydjBuU3pSYWJmS3ROOS85STYrRGdXMEtN?=
 =?utf-8?B?eUlkSXFMT3BKSjdkYkFzbUgwcHJKKzgvNGMrVE1JS1cxNjR1R05FVWpvM1A1?=
 =?utf-8?B?Y1Fld0RHVEJlcWFxZU9lQ1dYZmZoeUVnSTNOcy94dHNKTGk1S2ljZEc3QWNw?=
 =?utf-8?B?QjAwcUdpcVgza1ZJSW1wZWhKeE1VTnFZb3krdk9tTm5UZWVnaVpLZ3V2bWhh?=
 =?utf-8?B?RDkyaFloTGRGTG94YmVkaFdhUjMremc4UUkyUnZpNFVndmpxVG9lbzhqUE9O?=
 =?utf-8?B?allFaEorOGRkWnloODN2MWo5VmNPSnFlT0w1azNUWXlYQlB3bzFBaG5JMFJH?=
 =?utf-8?B?WHkrVUFZZm1LY0Z5QUFUeXNWNDN4azZwREhNaEVzZ1ZybEVzOEUzVlJ0WXNy?=
 =?utf-8?B?S000T1lRdFk5MzVPVkEvSzgwZGVVZy9hdmJpR1dSZUVDSWtVWlRZK2w4OHpi?=
 =?utf-8?B?QUJzbzR5czVvT3NZcGZ6dUtDUjVIaDhmVFE1SEYwcXFNcC8wUitHWDFpV3g2?=
 =?utf-8?B?cmdXTnl6dWo4VzI3M0hxb2lDekUxSkk1Ry9jL3NSSHBMcTAwUVFvZHl4NVVL?=
 =?utf-8?B?UnNCQUtyN1J5TzVZNk9mdDcvdVp3dFZJaEkvRzFLNG9Ub1cweTgreFhsN0N4?=
 =?utf-8?B?M1A0U01ZK0hJaFY3MEFiL3A0dE8xRkdtRlk2NWhUWjB0dlRnNXlrWWI4SnIx?=
 =?utf-8?B?MEFuN0VUN0JhNnRaa3M4SnN4bmhvSzZ1ZkxTMFNPS1lJaFFUS0pOcTBndmJP?=
 =?utf-8?B?MnFCenNBb0tlTFdmN1ZoR0NZakVsT0VqWVI2VW9ybkpBWGRNTktyTm1xVlo1?=
 =?utf-8?B?dlFRVzNXNWdlaXF0cXRrQ2xSaUdDSHZHN01yWEpabHRieVhhcUtERnprenF3?=
 =?utf-8?B?MmNwNXNhSTk5K0JWdDBBU3BDc1A4amw5bkN6b3cyVmh3cytMOC9kMlRweUpk?=
 =?utf-8?B?UkpRRGxORGVJWGJUcTNjSkpTMVRiN3hWeXJlTjMvdzlxc3VVOEdEMXJFN2xk?=
 =?utf-8?B?QU83SFY4eHo4UzR1bGdpY2lsWVVtR1JLWFdhZGpaa2VxaEpIMjh2ZDNEVXRF?=
 =?utf-8?B?QWlPR0l0Yi9wcmlRZVlnbG8vRkxkL09uSnlzUEdMZnl6QU1nMUtnc3h0N3pU?=
 =?utf-8?B?ZGdxWkEzUkttWFMzYUw4UXQwV01jZUMrbFM0S29HbmR2dUp5eDVxQ2RNZ3lE?=
 =?utf-8?B?bXEzVzRYUFhweXFZOHBXcE4xdEUyTzJibDNiUWViQ0lSbld2Q09IYU0wOTVR?=
 =?utf-8?B?bDVZdURVSytWaG9ONEVLY0lmdERZdFQraDkveFpJY0tDeEZ2UlNRZEJKZFhT?=
 =?utf-8?Q?sSeoE0aubQsGD1HuCpsm6IB4y?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f859a7-1a09-45a1-00b3-08dcfc7805ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 02:26:00.0964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: exQ8Mr9cHOb51RFO8vZODg2Jdomkg2lyqlYn09MxcUJBshO9qT1IGKk2Az1+GiWhBDItKdehQEk/egh6Zqulkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10007

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNOW5tDEw5pyIMzDml6UgMDozNw0KPiBUbzogUm9iIEhlcnJp
bmcgPHJvYmhAa2VybmVsLm9yZz47IFNhcmF2YW5hIEthbm5hbg0KPiA8c2FyYXZhbmFrQGdvb2ds
ZS5jb20+OyBKaW5nb28gSGFuIDxqaW5nb29oYW4xQGdtYWlsLmNvbT47DQo+IE1hbml2YW5uYW4g
U2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+OyBMb3JlbnpvDQo+
IFBpZXJhbGlzaSA8bHBpZXJhbGlzaUBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIFdpbGN6ecWEc2tp
IDxrd0BsaW51eC5jb20+OyBCam9ybg0KPiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPjsg
SG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47DQo+IEx1Y2FzIFN0YWNoIDxsLnN0
YWNoQHBlbmd1dHJvbml4LmRlPjsgU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsNCj4g
U2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPjsgUGVuZ3V0cm9uaXggS2VybmVs
IFRlYW0NCj4gPGtlcm5lbEBwZW5ndXRyb25peC5kZT47IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFt
QGdtYWlsLmNvbT4NCj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IEZy
YW5rIExpIDxmcmFuay5saUBueHAuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjcgNC83XSBQQ0k6
IGlteDY6IFJlbW92ZSBjcHVfYWRkcl9maXh1cCgpDQo+IA0KPiBSZW1vdmUgY3B1X2FkZHJfZml4
dXAoKSBiZWNhdXNlIGR3YyBjb21tb24gZHJpdmVyIGFscmVhZHkgaGFuZGxlDQo+IGFkZHJlc3Mg
dHJhbnNsYXRlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5j
b20+DQpBY2tlZC1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KDQpCZXN0
IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+IC0tLQ0KPiBDaGFuZ2UgZnJvbSB2MiB0byB2Nw0KPiAt
IG5vbmUNCj4gQ2hhbmdlIGZyb20gdjEgdG8gdjINCj4gLSBzZXQgdXNpbmdfZHRidXNfaW5mbyB0
cnVlDQo+IC0tLQ0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYyB8IDIy
ICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDIwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2kt
aW14Ni5jDQo+IGluZGV4IDgwOGQxZjEwNTQxNzMuLjUzMzkwNWIzOTQyYTEgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gKysrIGIvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiBAQCAtODEsNyArODEsNiBAQCBlbnVt
IGlteF9wY2llX3ZhcmlhbnRzIHsNCj4gICNkZWZpbmUgSU1YX1BDSUVfRkxBR19IQVNfUEhZX1JF
U0VUCQlCSVQoNSkNCj4gICNkZWZpbmUgSU1YX1BDSUVfRkxBR19IQVNfU0VSREVTCQlCSVQoNikN
Cj4gICNkZWZpbmUgSU1YX1BDSUVfRkxBR19TVVBQT1JUXzY0QklUCQlCSVQoNykNCj4gLSNkZWZp
bmUgSU1YX1BDSUVfRkxBR19DUFVfQUREUl9GSVhVUAkJQklUKDgpDQo+IA0KPiAgI2RlZmluZSBp
bXhfY2hlY2tfZmxhZyhwY2ksIHZhbCkJKHBjaS0+ZHJ2ZGF0YS0+ZmxhZ3MgJiB2YWwpDQo+IA0K
PiBAQCAtMTAxMiwyMiArMTAxMSw2IEBAIHN0YXRpYyB2b2lkIGlteF9wY2llX2hvc3RfZXhpdChz
dHJ1Y3QgZHdfcGNpZV9ycA0KPiAqcHApDQo+ICAJCXJlZ3VsYXRvcl9kaXNhYmxlKGlteF9wY2ll
LT52cGNpZSk7DQo+ICB9DQo+IA0KPiAtc3RhdGljIHU2NCBpbXhfcGNpZV9jcHVfYWRkcl9maXh1
cChzdHJ1Y3QgZHdfcGNpZSAqcGNpZSwgdTY0IGNwdV9hZGRyKSAtew0KPiAtCXN0cnVjdCBpbXhf
cGNpZSAqaW14X3BjaWUgPSB0b19pbXhfcGNpZShwY2llKTsNCj4gLQlzdHJ1Y3QgZHdfcGNpZV9y
cCAqcHAgPSAmcGNpZS0+cHA7DQo+IC0Jc3RydWN0IHJlc291cmNlX2VudHJ5ICplbnRyeTsNCj4g
LQ0KPiAtCWlmICghKGlteF9wY2llLT5kcnZkYXRhLT5mbGFncyAmIElNWF9QQ0lFX0ZMQUdfQ1BV
X0FERFJfRklYVVApKQ0KPiAtCQlyZXR1cm4gY3B1X2FkZHI7DQo+IC0NCj4gLQllbnRyeSA9IHJl
c291cmNlX2xpc3RfZmlyc3RfdHlwZSgmcHAtPmJyaWRnZS0+d2luZG93cywNCj4gSU9SRVNPVVJD
RV9NRU0pOw0KPiAtCWlmICghZW50cnkpDQo+IC0JCXJldHVybiBjcHVfYWRkcjsNCj4gLQ0KPiAt
CXJldHVybiBjcHVfYWRkciAtIGVudHJ5LT5vZmZzZXQ7DQo+IC19DQo+IC0NCj4gIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgZHdfcGNpZV9ob3N0X29wcyBpbXhfcGNpZV9ob3N0X29wcyA9IHsNCj4gIAku
aW5pdCA9IGlteF9wY2llX2hvc3RfaW5pdCwNCj4gIAkuZGVpbml0ID0gaW14X3BjaWVfaG9zdF9l
eGl0LA0KPiBAQCAtMTAzNiw3ICsxMDE5LDYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBkd19wY2ll
X2hvc3Rfb3BzDQo+IGlteF9wY2llX2hvc3Rfb3BzID0geyAgc3RhdGljIGNvbnN0IHN0cnVjdCBk
d19wY2llX29wcyBkd19wY2llX29wcyA9IHsNCj4gIAkuc3RhcnRfbGluayA9IGlteF9wY2llX3N0
YXJ0X2xpbmssDQo+ICAJLnN0b3BfbGluayA9IGlteF9wY2llX3N0b3BfbGluaywNCj4gLQkuY3B1
X2FkZHJfZml4dXAgPSBpbXhfcGNpZV9jcHVfYWRkcl9maXh1cCwNCj4gIH07DQo+IA0KPiAgc3Rh
dGljIHZvaWQgaW14X3BjaWVfZXBfaW5pdChzdHJ1Y3QgZHdfcGNpZV9lcCAqZXApIEBAIC0xNDQ2
LDYgKzE0MjgsNw0KPiBAQCBzdGF0aWMgaW50IGlteF9wY2llX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ICAJaWYgKHJldCkNCj4gIAkJcmV0dXJuIHJldDsNCj4gDQo+ICsJ
cGNpLT51c2luZ19kdGJ1c19pbmZvID0gdHJ1ZTsNCj4gIAlpZiAoaW14X3BjaWUtPmRydmRhdGEt
Pm1vZGUgPT0gRFdfUENJRV9FUF9UWVBFKSB7DQo+ICAJCXJldCA9IGlteF9hZGRfcGNpZV9lcChp
bXhfcGNpZSwgcGRldik7DQo+ICAJCWlmIChyZXQgPCAwKQ0KPiBAQCAtMTU4NSw4ICsxNTY4LDcg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpbXhfcGNpZV9kcnZkYXRhIGRydmRhdGFbXSA9IHsNCj4g
IAl9LA0KPiAgCVtJTVg4UV0gPSB7DQo+ICAJCS52YXJpYW50ID0gSU1YOFEsDQo+IC0JCS5mbGFn
cyA9IElNWF9QQ0lFX0ZMQUdfSEFTX1BIWURSViB8DQo+IC0JCQkgSU1YX1BDSUVfRkxBR19DUFVf
QUREUl9GSVhVUCwNCj4gKwkJLmZsYWdzID0gSU1YX1BDSUVfRkxBR19IQVNfUEhZRFJWLA0KPiAg
CQkuY2xrX25hbWVzID0gaW14OHFfY2xrcywNCj4gIAkJLmNsa3NfY250ID0gQVJSQVlfU0laRShp
bXg4cV9jbGtzKSwNCj4gIAl9LA0KPiANCj4gLS0NCj4gMi4zNC4xDQoNCg==

