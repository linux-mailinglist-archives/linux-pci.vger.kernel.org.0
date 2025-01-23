Return-Path: <linux-pci+bounces-20288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BCCA1A6EC
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 16:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09B93A5564
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 15:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EB1211A1E;
	Thu, 23 Jan 2025 15:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZN1oGmR3"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013018.outbound.protection.outlook.com [52.101.67.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5C620B22;
	Thu, 23 Jan 2025 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737645712; cv=fail; b=hxbEH3zJKcPlM9h4+A3/7jkyvqRZ3u0bka7iabO7Cj59lHW9R9rZaLKjU5OwnovuIYLwt12sqc5Qt5ay9NTw2g8CmN/ERkI6X06vuwb5wpU1otIPFv1BMBa4aGQT+skYONvkGTRTX4IN57hGcLRzVSdq0B1C1yKSi3rykxb2ag4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737645712; c=relaxed/simple;
	bh=vDcAv05Y/z5w6Jd4u6WNtYb7kdYSbBBMReRv7IwjOFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=afrCxVr4MtB1VfM+kv6Iwivmxhyb9c5dCrmoENHnE6FrUIkkt7YUnKgDqLjzo9cd8rMXNgxtplaoEYhK0w2t2ZNwC+IvEmme7odD7m2w3Eb2IXopJPu+uTuLzf1O/12l5zagUhINCAcRuumBuu7c0/MX4uWV1jZSIGM0/QOe1CI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZN1oGmR3; arc=fail smtp.client-ip=52.101.67.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0OMcagwCgVOpe4spqfQXnnrJytytM9eCDWupfqywjpwkauMg9bCtURPWwHWAyNxtqGwQ04yJI4WU+jpy5H5OyAaGr+/7htDSzSUBlnhn16G9XyCcuxJ4M9AL+WNo8sViOldhf1oO1FVSRJ5X/snQ1TMB2d4f3wvB5RH2qlfvhEJf1939qz/mE7lQybhCXgyXsmDQbsCsigNdCEIpNi7yag98BqbvBsrrygx7dYqjG8jevTaSVe96LemVL+E7NN/2RL9SWbOLhFtkz4GWCKJzuYLhQUWc7wBlIjfsgnX0gDF2RdRRuJ+Z1Z/ZGvRsYmqu/N+nUOeaUXfQ2OUKDs+9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6FwZ8xkWt0jwnBw5XnNwK4jazRSqAXPTvOXNz8cCYk=;
 b=jT6qOO0037im0SYOFPM3mB3QceLsJybwzx3y7ElDr2EEVByho5AUQMOa2d2lK99Ee5SZPI8LjZUoffEkFMKTCcvFn8K1iuTeGyaXLfkrwUMT6FcWBhRjwsDU1mXpvfoFN0VkDctxht3tlaJpydYr5/RklFe1eG8f22hQaK21xHqexAB1+iBDfkZfh6SEss9wyvOoypvoscleCTFQOfN2ibTyUMIjX0nxlbYsZeDxTncqO6QV6nTDxDjguuQYNiUEcUAvtriHrLmXwFSllEYquijZFfr0VyEwLF1D/1peD+RbzOSGp8ZjInEytX+lk96uvCXhzbuZf+apqhZS000MEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6FwZ8xkWt0jwnBw5XnNwK4jazRSqAXPTvOXNz8cCYk=;
 b=ZN1oGmR3HtuHe9Y7CCEPs4l64Hv1QaLr5vLQBwWnKg1PhO5U0mVO+gWr7DhHUouIwqkm63mXvdDdbErks2rHBIw0qs5pGw6WX4nd/AfbC9Y+DwomQieJ88sOxXo4sVM5ixVkxR8zOS4TksIA96yhuk/cMRz8ZjcVZOyYYyX6jHzlLon21X+ddWacBtJXaQf96wEMTCP0oFK7ZU1EM4c6TwIpvsXTiYMXM31KcFmOwNjEx0hy5Koagfpgpv+ChxEKGvsqzULoT1c04A1/pe3qxf3fTiPm4HxdOHlS9zNy9Fe2EoGCMbrDZ0Z7aXyGhrgj1p0V2pNCdYh33PRTPPCpwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM8PR04MB7956.eurprd04.prod.outlook.com (2603:10a6:20b:241::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Thu, 23 Jan
 2025 15:21:47 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%7]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 15:21:47 +0000
Date: Thu, 23 Jan 2025 10:21:36 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v8 2/7] PCI: dwc: Use devicetree 'ranges' property to get
 rid of cpu_addr_fixup() callback
Message-ID: <Z5JegF7i3Ig2pLYB@lizhi-Precision-Tower-5810>
References: <20250116231358.GA616783@bhelgaas>
 <20250116232916.GA617353@bhelgaas>
 <Z4p6bekWQ7t7ZDS8@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4p6bekWQ7t7ZDS8@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: BYAPR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:40::14) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM8PR04MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d7a7799-a0cb-4368-88f8-08dd3bc1a6d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTk2d2sra0lqbmtiTSs0a2ZDbnY3S2NGc2JiSVNGK2tUdE14QXR6ajV2U09w?=
 =?utf-8?B?R0RtYXo2RldLMmo3THhGcGlZd0YrVm9UTEFRY1lFREpyRlQ5UTJzSDNRRkZD?=
 =?utf-8?B?Y3MyMUd6Q29hNXpsOG9UMFZDMHV4cDdYamVibmdkSHRweHZueDVkR3NteDFG?=
 =?utf-8?B?U2NZRDlqWndEOHppekk2V3FHOXptRDI4TVM0WVBkUUFkQkFIYmVkWUtnbExQ?=
 =?utf-8?B?SWZVZ29GUkZnVGR1Z0JZWDJJN1d5Q29ad3ZsWngxMHFnMlY0QzVGTFVNSFp3?=
 =?utf-8?B?MlJScHhNWUFkblNNQlp3a0FRQVpvWGhRMFBhaXdjNy9sYmVIaG9pQjg3bmFM?=
 =?utf-8?B?djBZeWhlSVAzUzJKUTNrN0pJNllmaVRoWlY5dDJueUVNRkNpSTdmUjRQeExi?=
 =?utf-8?B?U1VtalFibnVQaWtQVHBOM3dxQjFJMG1WYXFyTGlUVitGazBpV0JUWlpoSHBu?=
 =?utf-8?B?S2NFai9BdC9xR1FUUE10VlVveThDZWNGS3k0WVlJaTZjT0tmbFNmbDFQb1dS?=
 =?utf-8?B?dStpTjdMYm1hOGYzKzJJL3g0bVkyOVo3RFhIdEptQitMYU1zQXZxSFpaVncz?=
 =?utf-8?B?SXR0bTd5VEtwcTdycVc1NGMzNVRFYjdBSEJuUDYwRmdNWVFjN2E0eE9FT05h?=
 =?utf-8?B?dWlmaXB2bFFvWU1OdFZiNXJHY0J4L1J1V3lyZFkvY2N6L1JtajEzWWVhajl1?=
 =?utf-8?B?MXVDMVFEc2NTSGtuMjlEVHJEUE9HME11RGttZzBpMzAxWXI4T05LTHRaZUU0?=
 =?utf-8?B?WXlucnU3eWk1eno1ejB5aGs0Nk9NUmVxbVJWWnUzeVhMTis1VmY0K2tNMXFJ?=
 =?utf-8?B?U21KaVZjYUhPN0laNkZ3bDAwYzN6bFo1Vjk5NUlVZTVhSmg3c2VvM0VORTRT?=
 =?utf-8?B?RjNpNUJ2OE5maWZQWXJtU0NRRTkrNzFBTTY1Nm9aUDVqTXhDbEFGOHErZys3?=
 =?utf-8?B?ZlNxWllPd2x0WGVITy9XUzlXSEFDSTNld2cvZmw1ZnVqL090OXJ3TGhmY0dj?=
 =?utf-8?B?K09meEluK0xSL09INWNTNDROQ3RQNWtocDdPb0xMM1daSm93NjBXU0pVc0Zr?=
 =?utf-8?B?VGtjRHhsS2hnYW9HZkRJT2xrZzBRTnlkTzd1Nm00cXl3MUJjYmc5SlNkQjZi?=
 =?utf-8?B?SDd1VFllNldyeGVwWEdMeko3YXdMTDg3eTNNTGVLRUNYSzhpYmN0QWk1VXpI?=
 =?utf-8?B?dytTdEZUL1dRQVpac0JuLzR4Vlk2RGduQU4rczB1aEgzVGhqU0VYZlUwaVBY?=
 =?utf-8?B?TnA5cFFNOEtZWEVJY3AyL3pRWk1yNnRmQlhuUTBTYmhKUjE5TFlNVnh2Nnda?=
 =?utf-8?B?QTk2MTNyaW91ZDhMaE4rL3FCd0FGSndKbHcwNm50aUwzR2dSMUpIVHpWMkNN?=
 =?utf-8?B?WE1RRy9STXhsRThZMEhLajdMU0FqOW54NmRQTVBwbnIxTW5YNFpHMEtvS2tQ?=
 =?utf-8?B?SkthbzZaYzBFVzUvZDljZk95cFY3UlEzK1JyeHFVK2EyWHExaENLOVYvUjdt?=
 =?utf-8?B?UlgvUExjZ3dwRmQ0L0RvUEwwZE9CY3RrS2lUdUtCem9XSUR6YjRlUXNLTm9B?=
 =?utf-8?B?QnZHNEtLQkVITm5pNG4xWFpEOStKaVNjNy9HaUJ3TVhTVU5rYkY2emRVUjlO?=
 =?utf-8?B?MXhxRXJ3bkt2QXZJWDVRalVoVWo3Y01RUDVWMUgvZ2lWRzNlWDFzVm9oNmdq?=
 =?utf-8?B?S0ZTcFRmUTNaUEVNaTJDVVFia1ZkSlBOZWhwdFZEbGxMNkdDTUVnalpsazh0?=
 =?utf-8?B?R2FJS0JkSWNuanVXM3ptTVdLT2tvalVMamp3UnBneHZoNXdlOTcyTDBHMmUr?=
 =?utf-8?B?bysrd1VPamJadTRObG9lNEpscWdLNms4ZlVpTFBvUHh3bldIZkZ3NFQ4TENX?=
 =?utf-8?B?OW9zKzJUR0NpVldKTWRqSlg2TzdIVDhEeVBkMW1rZWFRQ2V0bWdBQVBOc3pa?=
 =?utf-8?Q?Nx1enj3RkMMOz7YbMWmHfkzTE3vbhONc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QSs1ZUxQaGlqQzBLYVRVNGh3R2hualFFSWJZbXRMd0E2Qm16c1RNSCtWcGFQ?=
 =?utf-8?B?VWRSMzYyYXhzaHV0TzdLWk1ocHJScVI3S0RDWERVWkhxQ3QyclFhNG13R1BJ?=
 =?utf-8?B?ekNJYWNnWVFYVmxmOHlGSkxlUDBvMEFsd3FNeEJqNE9iRFVFQjJBRXNGOUhz?=
 =?utf-8?B?cVZlMUNLMmFEQzFOMUgrRnVZa3o2d0dlNzBoOGp5aEtGbmZodFYzd05tVE5K?=
 =?utf-8?B?RUk3TUNIMnNNWkNWa3NScTBRSGFNT2RnM1FQYmhPKzgyL2dCaUNrVFkyVmwr?=
 =?utf-8?B?QndnbnBxQ1pMR0xVdjZvZjRuM1h5TkdRN1l1MXBpUG03MjR2OVdoQ3hRT2hm?=
 =?utf-8?B?MzlEUEo2ZnBiYXREU3lWMzRtelFDOS9JcWdVKzNGeUl3UFU4bG5aZ05rcEdj?=
 =?utf-8?B?OWFWVkQvd0JYNC9BQm1EUmttU05jZDVKb2N0ZUdsaDIrdkhYaDdTK3VaWm51?=
 =?utf-8?B?Wjk4TXk2THNoYnJvNDlsbzZOaCttdW9CalVLSmtZR1R1TEtOZGhHaDQ1aGFr?=
 =?utf-8?B?bWpMYnk5Mm9XeHZ0Ui9QRTFrUHFBaWIrMWM0UXBKZkVPNy85dUdob0RlS3Vj?=
 =?utf-8?B?MTZlSWxRTEptSXdOUnZZZ0tBZ1F2aHJMd1NtcUdtR2NlWUZFVk5wZ3pudGhI?=
 =?utf-8?B?bk9qRmZUZnIrcEtsa0haVFZmd1FTZDI5Znp5YlpCOFozaHFXQURxL0RBT0hZ?=
 =?utf-8?B?Z0lRbm9maXVrVUFneERmTTNUdk9vZXdLUUZDQkxMYXIwQXdsQzlDK3BSbjhG?=
 =?utf-8?B?UWNCa085NHBKaVBVUXE3VjR0TVpjWVhrWjNORkxlTFNIRHlFcnROSzB0M3FQ?=
 =?utf-8?B?dTdZeXNHSGhFTlQ3Yjh3QkdCM2VXbjR1LzRSVUM3d2VpcnduSHo5VUQwMkJY?=
 =?utf-8?B?TGUwU1RoSzByTm54aFZPZDNralBpcmNTUFQ1cGNEZVA4SVIzYk1FUkN2QW5r?=
 =?utf-8?B?ajIzSTExajAxTlg2MGZHZ2xGNDM1RC9ydDVWazVxeklUM05rOTFWRXUxUFR1?=
 =?utf-8?B?UkNyekl2M0h4bEZ4dGtGWjBQRDVhQ1U3SE5Hb0E1MVBHUmR1cGx6azlvYmJk?=
 =?utf-8?B?bU1WdFZ0cmw3YjBZSjJrbFVYZGlaTldZcmFrdVg1RlJwL3pyYTF3dzBuODVy?=
 =?utf-8?B?bkZJbHJZZEwzcHhEbzAyQVlBdEJaUVdBWlYyNWpLVG41NEZURnNnWkZXbVVk?=
 =?utf-8?B?OGM3VVdUeFVpT3dzUTlKTDd4c3o1V0ZuVkV3dzg1dUU5TXdka1hwK2xmdzU1?=
 =?utf-8?B?U29TMlhpdXptTVkyU1MzdktIakF2WDBIUFpUNGlvOTlWMHhmdXdaZlJkSnlz?=
 =?utf-8?B?QWM0UGFLTXVDKzFFaE5wUmNlb05iYnZxRVNPNlVRS0hQdTJSVWNoUEwwZFNo?=
 =?utf-8?B?NVZVaHE4bWJKWGJOQTFKM0xkeGlpS0QrOUtGb1ZDcENJNm05MDJQRDBTakVq?=
 =?utf-8?B?RGtoTVJZWGdkSThBUzdITVFIa2Zic3BpZVNNbnRDaDNKU2lLVm1FRStkaU9t?=
 =?utf-8?B?VlBqUi9DOEljQ1cyMnB5VmRwbmxyVEk1ZkZSbmFTY05wUFlEZ0RwRkxrcS9P?=
 =?utf-8?B?eFRJWHg0N21MSVZzMVRkU3h1QnI0K3NDMHgxUFhNcUtwVHRPdTBIVWIrQ2Nr?=
 =?utf-8?B?UDR5VGloZXlDZGlubGs2ZzB1ZFRHYlRsQ21Ec1AvdWJQQ3o3bEpvc3A1S0VC?=
 =?utf-8?B?ZndPRkJMR296VDFlV3JDRytaOCtWR1diQzBIc0VoSDRlSTYzay8rZ0JDYmZn?=
 =?utf-8?B?cmxudUNmUEJXOXpacjFWMUlCWFRzQ0hoZFZFSWRLU1VSZ0h3ZjNUUUZpWXJQ?=
 =?utf-8?B?clNsM2F2aEcvcTVJSmtjV292dlJMV3F1Tm5ZRzd5ekZPSXlqQWdhMmZYU3I0?=
 =?utf-8?B?eUJHS0pBaXRkMVQ5cTMvNVc2MnJQWDQ0MDZPbDYrZEpEMi9BQVBxV0ZYd3R5?=
 =?utf-8?B?dWVKdzFHeG02cFVPOHl5YTA3Y28vOWdlZk8zRldscm1ZcDRrY3REY0dEQWMy?=
 =?utf-8?B?a0NHOGk4dnJQa0FGTHhVQ05HQ1FXSGlFcE42dXVQcHBvRFB3K0ttWER0NnEv?=
 =?utf-8?B?R1NTQ2JzTWlzVkgyQ1lMd1RzS1dUMitsWk92eTk0ZFQwWlQrQzNENWUyUTVx?=
 =?utf-8?Q?pjqE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7a7799-a0cb-4368-88f8-08dd3bc1a6d8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 15:21:47.3408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljJowjT3V6u/fdJZ6iS1exWGbE6dpCJKuQnuNURKTWRJgm0McxATiUn/MKqXDMeS2cJl5pCJQgG+WFya9/zqxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7956

On Fri, Jan 17, 2025 at 10:42:37AM -0500, Frank Li wrote:
> On Thu, Jan 16, 2025 at 05:29:16PM -0600, Bjorn Helgaas wrote:
> > On Thu, Jan 16, 2025 at 05:14:00PM -0600, Bjorn Helgaas wrote:
> > > On Tue, Nov 19, 2024 at 02:44:20PM -0500, Frank Li wrote:
> > > > parent_bus_addr in struct of_range can indicate address information just
> > > > ahead of PCIe controller. Most system's bus fabric use 1:1 map between
> > > > input and output address. but some hardware like i.MX8QXP doesn't use 1:1
> > > > map. See below diagram:
> > > >
> > > >             ┌─────────┐                    ┌────────────┐
> > > >  ┌─────┐    │         │ IA: 0x8ff8_0000    │            │
> > > >  │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
> > > >  └─────┘    │   │     │ IA: 0x8ff0_0000 │  │            │
> > > >   CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
> > > > 0x7ff8_0000─┼───┘  │  │             │   │  │            │
> > > >             │      │  │             │   │  │            │   PCI Addr
> > > > 0x7ff0_0000─┼──────┘  │             │   └──► IOSpace   ─┼────────────►
> > > >             │         │             │      │            │    0
> > > > 0x7000_0000─┼────────►├─────────┐   │      │            │
> > > >             └─────────┘         │   └──────► CfgSpace  ─┼────────────►
> > > >              BUS Fabric         │          │            │    0
> > > >                                 │          │            │
> > > >                                 └──────────► MemSpace  ─┼────────────►
> > > >                         IA: 0x8000_0000    │            │  0x8000_0000
> > > >                                            └────────────┘
> > > >
> > > > bus@5f000000 {
> > > > 	compatible = "simple-bus";
> > > > 	#address-cells = <1>;
> > > > 	#size-cells = <1>;
> > > > 	ranges = <0x80000000 0x0 0x70000000 0x10000000>;
> > > >
> > > > 	pcie@5f010000 {
> > > > 		compatible = "fsl,imx8q-pcie";
> > > > 		reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
> > > > 		reg-names = "dbi", "config";
> > > > 		#address-cells = <3>;
> > > > 		#size-cells = <2>;
> > > > 		device_type = "pci";
> > > > 		bus-range = <0x00 0xff>;
> > > > 		ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
> > > > 			 <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
> > > > 	...
> > > > 	};
> > > > };
> > > >
> > > > Term internal address (IA) here means the address just before PCIe
> > > > controller. After ATU use this IA instead CPU address, cpu_addr_fixup() can
> > > > be removed.
> > >
> > > > @@ -730,9 +779,15 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> > > >
> > > >  		atu.index = i;
> > > >  		atu.type = PCIE_ATU_TYPE_MEM;
> > > > -		atu.cpu_addr = entry->res->start;
> > > > +		parent_bus_addr = entry->res->start;
> > > >  		atu.pci_addr = entry->res->start - entry->offset;
> > > >
> > > > +		ret = dw_pcie_get_parent_addr(pci, entry->res->start, &parent_bus_addr);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +
> > > > +		atu.cpu_addr = parent_bus_addr;
> > >
> > > Here you set atu.cpu_addr to the intermediate bus address instead
> > > of the CPU physical address before calling
> > > dw_pcie_prog_outbound_atu().
> > >
> > > But what about other callers of dw_pcie_prog_outbound_atu()?  Don't
> > > all of them need to use the intermediate bus address?
>
> All should use "intermediate bus address", RC side only call it here. EP
>
> side is here
> https://lore.kernel.org/imx/Z4p0fUAK1ONNjLst@lizhi-Precision-Tower-5810/T/#t
>
> >
> > Somehow I expected the patch to skip calling ->cpu_addr_fixup() if the
> > driver had set 'use_parent_dt_ranges'.  In fact, I think that's a
> > requirement.
>
> It's fine to add check to call cpu_addr_fixup() although I think driver
> owner should take responsiblity to make cpu_addr_fixup and
> use_parent_dt_ranges exclusive.
>
> >
> > Since dw_pcie_prog_outbound_atu() is the only dwc caller, maybe the
> > parent_bus_addr change should go *there* instead of in the callers?
>
> I am not sure I understand your means.
>
> EP and RC parts need call dw_pcie_prog_outbound_atu(). EP and RC use
> difference method to get outbound windows informaiton. So can't move it
> into dw_pcie_prog_outbound_atu().
>
> Frank

Bjorn:

	I saw you have not picked all of these patches during you rework
pci git branches.

	I know you are busy, do you have chance to pick left patch for 6.14.

Frank

> >
> > Bjorn

