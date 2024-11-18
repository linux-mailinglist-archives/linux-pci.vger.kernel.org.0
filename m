Return-Path: <linux-pci+bounces-17016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711A79D0803
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 03:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2B44B21FB3
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 02:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4BB42AB3;
	Mon, 18 Nov 2024 02:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b2/BYC8q"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E99D2AE9A;
	Mon, 18 Nov 2024 02:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731898780; cv=fail; b=QAlQXe7vNpKdST3viN6YDKkxbtbsP+Y0YcP0v80Q2L5rtoQH2BfyNlAWejU7m2+t6ukU7D2q+FLtisZWmWECrOSnxM26Y8grsPL6NjY3XHNSu4h+TLjVz7/doMilvBWn3D6gzqy8aSsxZOnvUVpqoTFXF9ZKsaak196dyb3UCmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731898780; c=relaxed/simple;
	bh=ICdexxX96Jp40LuLeDmC7rxQohqTX5lzlzdKDz/R8dk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rpGz6eBWagwnShH7QVbWZF8JuFCuC48jPUiP+507TPAX4ygKHmTYCt1C7ConHY1/eOYYvn28Inv9YmawDLzL29688w2wmql74L9Uhtvn4dFA0+LAkZxLlyZUspCMyrQrwR+VJV6aiv7PmsN0iApveK+zPJmIM8ObPJD1xaTB6KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b2/BYC8q; arc=fail smtp.client-ip=40.107.21.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8T6IwkAlfFeckhL5OEegnHFXj05mruOZWx1KQeNWFEW7acF1glrGc2dAAzUbODjvYBQy/EmWQ7Dq20ziI0OSyMir3UB+QwuxqW1JrnXf8eoHZpcVvZBtoVihg6JkIOVjLx6SXaewq6gMOPW5FRWpfJuuZOMUD5k4OFz0LDYrjVnaYTqAmkmaXMOTqFcR6tutkzlEt1mzkQo3OBidKdeaBJfrSEBZLyZMGT+u5rH+dq3U0ReMikKnojQcuwaIHIOHLeK39TJ5bn7Cf80A8lTgWU1ywGbhx+8akBE3/5j5Myn0udaStJznhBsB8HFudyK3Eeh7JApDxyTgKqVRI/S2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICdexxX96Jp40LuLeDmC7rxQohqTX5lzlzdKDz/R8dk=;
 b=hkZ6G6fDnp1zuQ4e5S5JyKQnXt5Ba3Gz6WgDm2tGwXBnClqJK9MBn95FxxNWO98SQP5mw9Z50ts6oC3BOcz81VIa2riX36bTL/0jC3eXWQqf3a4Iq18Fc55qkrHNY3nHZII4+tAH1OySVBkSybeY6AnWQsQikMZvkz6tpX2YOkLJLqSPGoDqGWPU81jW2eFmZetNrp1wyR1bV5cak8InwE1JX9O6pcgT8NVqCj/sJqxVE8iNZIEu7wgW7LT9A1bOXsfB7mzgOKEJdFiINmblJGdQ/4lh547e/gZBYVS3HsvbF8LtBZhRKbgTzSfVWe7LBwmpABwJvw8WBt0UGqVFcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICdexxX96Jp40LuLeDmC7rxQohqTX5lzlzdKDz/R8dk=;
 b=b2/BYC8qgv56HptRGe+I/jXV/4skLYJvcw8LS6KnlDwBb294XyGeNc7HXJ7BBI4GPvfUo51bb+ZMovPhhJw0uKZP2ZH9e+toznnPbfY36uQfvVBp4thGfoZ1dLEW21NFdf8GPykPlZM0u6khksHuYEpT485bpe1LZsb7AviHymdrCbOGgD7UdWZTNo28lLaJpR/83llrIRPrHvSD2ERNGlrVOlDwIT9fAuJ8vURmqJBI9+TYKZPRnBvFJsjIxbsNbsGlrDAbrDWH6MGWGifJKABziVLwxgzvvdWCXvZJLQ129ZREDfb6EH8xBhXNFLREzoKVHp+1rW02029NPJWa2g==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8673.eurprd04.prod.outlook.com (2603:10a6:20b:428::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 02:59:35 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 02:59:35 +0000
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
Subject: RE: [PATCH v6 03/10] PCI: imx6: Fetch dbi2 and iATU base addesses
 from DT
Thread-Topic: [PATCH v6 03/10] PCI: imx6: Fetch dbi2 and iATU base addesses
 from DT
Thread-Index: AQHbLCsr6nv2+g5nIkKXX4SM+CmrobK3+lsAgALfdBA=
Date: Mon, 18 Nov 2024 02:59:35 +0000
Message-ID:
 <AS8PR04MB86766F6553A36E75A2B1F6C78C272@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
 <20241101070610.1267391-4-hongxing.zhu@nxp.com>
 <20241115064106.iwrorgimt6yenalx@thinkpad>
In-Reply-To: <20241115064106.iwrorgimt6yenalx@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AS8PR04MB8673:EE_
x-ms-office365-filtering-correlation-id: cb78fd45-30d6-4882-1d39-08dd077d08a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MjhURlJWK2lyYzV4YktJUC8xbUhJWTY0N0UrVjB4SlFoSWU1eUNnOGV6T3Uv?=
 =?utf-8?B?TVAxUmxYTE9iVmtwM3VNUmVMeFJzUW5Sc0Z1WEVDVGV1alU4UWhiZEpwYWJK?=
 =?utf-8?B?TmJ6c1FsR0xmenJ1N0dGcDVnT1hlWXRsMk1KOE9COE10bktzR3NONHl5UFN5?=
 =?utf-8?B?T1JDRHNEaFpmWXE0cE85WlFVbUtJRjdVZCtzcnVTSHVHOGtjZ21lWE1SUjl0?=
 =?utf-8?B?MGdROFF1V25jQmRZeDVRYitqRVprTFE2K0NDYmgwS3BBbkErcENQYlJRK2Fl?=
 =?utf-8?B?U04rcTdqM2tHbVBsL2xKV0srSGxid1JMQm1Makc2Wmg5dkhSL1JjSEZSa2VN?=
 =?utf-8?B?ZWpXK2I5ZFY2NFo2Wk9aQUNKYzhITmZrV2U1V25Kd2hodlRrbUZVNytJZ1Q3?=
 =?utf-8?B?M2kvMGZYOC9lRk1yZ0pCelRUNUFOdkpNalBSZTh4Y0E2SzMzcGFheDI4MjN2?=
 =?utf-8?B?dytPK2FFKzg3N0ZIVVFBdjRVbXVxSkhOczVaUGp4a2FoY2FlYkhjb3VjeHcx?=
 =?utf-8?B?ajBIM3N3RmtLM0J4WFIxbG1aaHcvNHZEbk9aeDlSOXBmaXplTjZZa2FqVktK?=
 =?utf-8?B?cnZYZE4xRlhzcHU1M1FwVXhJLzdxV2tiNWNYT1BkZ0lwVFJXL0F2MG5zQzR2?=
 =?utf-8?B?dW1PeFo5MGRrUjJ3WmpSWHB5MkcySmFCZXBMQkV4L1BNSmk3UWFGM3hKaExx?=
 =?utf-8?B?L0VjaHM5dkNkcXovb1h4ak5nRGxBMWc5anFJV2t0RlZWN3k2WjA5QVpGell1?=
 =?utf-8?B?eWt6TkNoa1JNajJhZ2dXV0VZR2NCcnJQK2J0S1RFOW1weTBWeW9VMDRTanRT?=
 =?utf-8?B?Q0FNN0NLOFlGcnNVMkMraXZSV2hZdnc4bVhFS1U1c290VnlDeHIzTnlQemZP?=
 =?utf-8?B?TzlKeG1wd3oyVHJnWWFTdHh3NUlBNTJwNHMxZk9hOU4zSVVXNThKQTlIeFVs?=
 =?utf-8?B?Q25SR0NCNGZ0dnhlTm1pNzZ0QUdqeFp1SjFkblYwV0ZoUVlUVGRXL3Izby9R?=
 =?utf-8?B?T0JBbXBiYTJlV08yL1ZPRjUwRzArbHlabHNyTW1zUG1Rd1JJQnJhakw3a3Rs?=
 =?utf-8?B?WjRwemlhbDAzdS9ldUw3OCtvbVZ5MWtKYkNHYzE2V1FPU0ZRcjZJNXIzSjQr?=
 =?utf-8?B?dlFHMWt3dUZ2Y2dMMEppQjU2a2ZLL2oySEdNcTl0MHNNSGVxSW94ZFdHMTlH?=
 =?utf-8?B?RnhhTmVEekhhV3BqYXMrRFgvUXYvSS9aWHJzMGRaZVFGWEFpaDloRWN6RTVV?=
 =?utf-8?B?R3cvRzFPNnZqa3AyWkpqQ0FZVGhTaTI2K0ZER0R3akEvbHR5d2U2dnlrRjg1?=
 =?utf-8?B?THI1U1N3RFRlRkVtZTlDMlRTbTZCY0pXcmIzcEp1QlhLSmNyMU5QdVJOajl0?=
 =?utf-8?B?VllEeUN2U2twWkxwTnJ1QmsyMjI0NWhBTVZOTVNIYmtxWmloZDVmNjZRSDFZ?=
 =?utf-8?B?M1JCT0k2Tml4T3Mrd1ZkS2J4RWZNaTJTOTE5Rm9vUDg2YS9zRU9ZcGdJYWJP?=
 =?utf-8?B?L2VZQ01XR1lmT2FsdDhLUlNncEF5NXJqbWFzbVpFTmU5ak5EZll1bGNNdnhS?=
 =?utf-8?B?a3krcDlkN0JiNXZHdkp5Q2kzWXV2RTJROGlTSmE3NU1IQ2FleWttOGZESUpX?=
 =?utf-8?B?YlNrMG9mWjJLTzlmamZVVzQvQ2szZ3h0eEJFMXFRbW55SjJyUCtsNkJsTGtp?=
 =?utf-8?B?Wmo3R2Q0bzRFUzF0YUFxWnJMNitYNkRLMTdpbzJURTB2dDRUUGNSVm0zaWM3?=
 =?utf-8?B?VHhEZmhZbFUwM29GS0Q0RmdiNXZmT1lOZ3lLVFk1dDUwY0tVbGZvclozaEJD?=
 =?utf-8?Q?nuNzljy1/sPVjD2948m0t7XGGdOOnGd/IGIo0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejVRYk1XM0JmZ240NGVwbTBDOFlFTGNqWFNvUWNWMnVNSzNNdkp5SlJyamh4?=
 =?utf-8?B?Q1NCTXU0czJkZk1qU29yMEhmVVMxbnNGaWRFalpXRE5EZWdtbHBkQlBsRm9t?=
 =?utf-8?B?L2ZZNnlSK1cvMFBkYWN2MjZqM3Q5VkMrTHM5eTVWZjdadEFNVXR0MytMMDdl?=
 =?utf-8?B?RkxPbHNJcUw5K0drYnRBS2tHYVIrRlhZaWxxeGFkbHpLT0JjTGNEWnJSODln?=
 =?utf-8?B?QjgwS1Z1VElmdHIwMkNzVXpEbmxnbDJHOEZlckQzRWNYQUk2dDN3LzNnVmo0?=
 =?utf-8?B?SFhBSHl5T21RWHFkNnU5ODF5eG5VeHB6NmIzaGlkMDV4MFpqZXR4eCsxOGZx?=
 =?utf-8?B?WXJ3dWY0cW15d1ZOVTRndU9LaVJrT3poSzJJVms4b0pMdUw0bGo4SFgvaDMz?=
 =?utf-8?B?eUNOQmJjVUZCRThLU0NDWjAvQVgrM1VIK2hBa3dqN0g2em1XblVwUkd3ZFlJ?=
 =?utf-8?B?ZUhVeFR5RFY5bTRHakpFQ05mZmZoVkhtUis0OTBZVHdjTTRqOE93aXRnRFNt?=
 =?utf-8?B?bUcvdllLOUFLSG5rbUx2c2xOUWRzNWNvOUtCQWJ4dUp1UlB5TXV5MGV2VVZG?=
 =?utf-8?B?c0xLckhZVmdDUmhWbmJPVjNUay9tWTNwZUQ3Q3hZMU9OMXh0OHlwK3lwSFd6?=
 =?utf-8?B?OU5scVJXcUY1RnRsVHN3UjIxR29hbGI5T2ZPNHMzQ1ltZ2tvT2RXVk5mcHNM?=
 =?utf-8?B?NERMemFaQ25tZTNZT2RYMnRhL2xCTEV6QUIwVFgrTG81OUNFWWdJTWVnNm05?=
 =?utf-8?B?LzJldzlkb0FBUUdYYURuSnRMaDU5SDFpYTlsdDZYK1c2SHVWQlVxb05DL0h4?=
 =?utf-8?B?VVpVa1ZtRHZnYjhMWUh4TVZvVitYdEJlS2V4d2hkNTduNUFIejVUdXk3M3M5?=
 =?utf-8?B?MWxqYlVXbDUwbnE5dnZpTmxDVklGZ2gvREJXbnIrTml3aEVJWGN2Ny9obUJK?=
 =?utf-8?B?OWFEQ205YWRoanRrYTl6WWg2SStPQjA5alZJZE9FQk00Mk1CdlFDTXh4Rld0?=
 =?utf-8?B?K29taURSYUNwdlRZelY5Q00vL1dqUVpPb2R2RG4vd2tRR2FYajNPWEttVUE2?=
 =?utf-8?B?ZXAzbG5PN0N2Ulp3eDNLVWgvaHFGclRIdjRjY2hBSUQraU5iVUJkSStub0Nr?=
 =?utf-8?B?Q0k1Uy9aRDZMVlpvOG43QjNjSkJyMlJOR2tGVWRvSDRSZUUxbEdQMXgrL1N5?=
 =?utf-8?B?SEtVaDFEWmZpYVFPWm50WjFIZURCQm1jVTlFTjZJKzgvaXUvQ0NJNGpXVXAx?=
 =?utf-8?B?bzdPb2R4bVZyazFwbU1pczJVeFZrZEhKUlUrM0Y2Z0VLZ2x0dXl1enFlQkhv?=
 =?utf-8?B?bDYxOXluNUJyRU5LM1hVVk5KVUxHT251U2owL3Y1eXpJc1dxOERJcmc5N1Zq?=
 =?utf-8?B?RTc3RU9TR09qUXZvOVR0d1R0VllIOWdLVHFndzU2ZkxiVk9wRWhzRHNSRitV?=
 =?utf-8?B?SVZ0UXhhTS8xZlJRNnhBQUxTTXlyZHN6YWtCZ0lLZ0p1OE9XTXJwcy84bXdC?=
 =?utf-8?B?czFOYUtwQUJQWXZNM2w4Sm4rcXpZd2orT09kSWZSMTkzOWRnUnlyZXdXdWJS?=
 =?utf-8?B?OU9Ha2ExT1JuNkNqRzVyZkxXd241c0F2NnlrYmQ3U09rUWQyWEhTOFNzVDE2?=
 =?utf-8?B?Tjhkb25kSnJwelNlRlFDTFdEc2lwOFh6RVVJaWpnYTZJZmNPY3IzK09NZlRQ?=
 =?utf-8?B?ZmJ5QmczYlcxWWtJVUpvdmJSMWRPT1NyMkVsbE5lY2Fpd2lLclVLZlZVY3NH?=
 =?utf-8?B?R29RS3JkVHlldlhkZlBCbWdISFlZWWlQQ3UzKzNUSDBaeGN1MENLMVRCTmVB?=
 =?utf-8?B?SERTeS9XZ3I3Q3IvVzZWRmtwbHoyY2ErTThaOFZEek8yVkJQQkVjcGp4VTY2?=
 =?utf-8?B?QThZUDROMCtvQmxyUTg4SUwxL25ad0RYYW1va0FsTzkzTUhKZFFhOGNHT0x3?=
 =?utf-8?B?SFFDQndab1loK0plNUtyMTJQTlJmUzhqaUZnZDZTNFFmKzVUczBoZGpsMUFQ?=
 =?utf-8?B?OWN5NE9pUHpyU2VtdWNtV0VPb29jbHc1dEhidUhOb1FjZlh4cWs4Q2cwMEZu?=
 =?utf-8?B?ZXNGb1l0N1I5WkpCNk15RFFBVWlqQ1k1UkJWLy9iZFUyZ3lEMEE5cjlyWVpm?=
 =?utf-8?Q?Khod7ofGqKOyApxmvRU4kTIcQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cb78fd45-30d6-4882-1d39-08dd077d08a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 02:59:35.3546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JufmM1WZmY7VF6N/duAiwdkuGya7zmF9WY88B0MjWCyCvEcyLrfKtakgFtEvEbJBuYw2FWrbEtAodXE2VY1QgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8673

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDI05bm0MTHm
nIgxNeaXpSAxNDo0MQ0KPiBUbzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4N
Cj4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207IGxwaWVy
YWxpc2lAa2VybmVsLm9yZzsNCj4ga3dAbGludXguY29tOyByb2JoQGtlcm5lbC5vcmc7IGtyemsr
ZHRAa2VybmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9y
ZzsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+Ow0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRl
OyBmZXN0ZXZhbUBnbWFpbC5jb207IGlteEBsaXN0cy5saW51eC5kZXY7DQo+IGtlcm5lbEBwZW5n
dXRyb25peC5kZTsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDAzLzEw
XSBQQ0k6IGlteDY6IEZldGNoIGRiaTIgYW5kIGlBVFUgYmFzZSBhZGRlc3Nlcw0KPiBmcm9tIERU
DQo+IA0KPiBPbiBGcmksIE5vdiAwMSwgMjAyNCBhdCAwMzowNjowM1BNICswODAwLCBSaWNoYXJk
IFpodSB3cm90ZToNCj4gPiBTaW5jZSBkYmkyIGFuZCBhdHUgcmVncyBhcmUgYWRkZWQgZm9yIGku
TVg4TSBQQ0llcy4gRmV0Y2ggdGhlIGRiaTIgYW5kDQo+ID4gaUFUVSBiYXNlIGFkZHJlc3NlcyBm
cm9tIERUIGRpcmVjdGx5LCBhbmQgcmVtb3ZlIHRoZSB1c2VsZXNzIGNvZGVzLg0KPiA+DQo+IA0K
PiBJdCdkIGJlIHVzZWZ1bCB0byBtZW50aW9uIHdoZXJlIHRoZSBiYXNlIGFkZHJlc3NlcyB3ZXJl
IGV4dHJhY2VkLiBMaWtlIGJ5DQo+IHRoZSBEV0MgY29tbW9uIGRyaXZlci4NCllvdSdyZSByaWdo
dC4gSG93IGFib3V0IGNoYW5nZSB0aGVtIHRvIHRoZSBiZWxvdyBvbmU/DQpUaGUgZHdfcGNpZV9n
ZXRfcmVzb3VyY2VzKCkgZnVuY3Rpb24gb2YgRFdDIGNvcmUgY29kZXMgY2FuIGZldGNoIHRoZSBk
YmkyIGFuZA0KIGlBVFUgYmFzZSBhZGRyZXNzZXMgZnJvbSBEVCBkaXJlY3RseSwgYW5kIHJlbW92
ZSB0aGUgdXNlbGVzcyBjb2RlcyBoZXJlLg0KDQo+IA0KPiA+IFVwc3RlYW0gZHRzJ3MgaGF2ZSBu
b3QgZW5hYmxlZCBFUCBmdW5jdGlvbi4gU28gbm8gZnVuY3Rpb24gYnJva2VuIGZvcg0KPiA+IG9s
ZCB1cHN0ZWFtJ3MgZHRiLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhv
bmd4aW5nLnpodUBueHAuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IE1hbml2YW5uYW4gU2FkaGFz
aXZhbQ0KPiA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+DQo+IA0KPiAtIE1hbmkN
Cj4gDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMg
fCAyMCAtLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjAgZGVsZXRp
b25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpLWlteDYuYw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0K
PiA+IGluZGV4IGJjODU2NzY3N2E2Ny4uNDYyZGVjZDFkNTg5IDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiArKysgYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gQEAgLTExMTUsNyArMTExNSw2IEBAIHN0
YXRpYyBpbnQgaW14X2FkZF9wY2llX2VwKHN0cnVjdCBpbXhfcGNpZQ0KPiAqaW14X3BjaWUsDQo+
ID4gIAkJCSAgIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIHsNCj4gPiAgCWlu
dCByZXQ7DQo+ID4gLQl1bnNpZ25lZCBpbnQgcGNpZV9kYmkyX29mZnNldDsNCj4gPiAgCXN0cnVj
dCBkd19wY2llX2VwICplcDsNCj4gPiAgCXN0cnVjdCBkd19wY2llICpwY2kgPSBpbXhfcGNpZS0+
cGNpOw0KPiA+ICAJc3RydWN0IGR3X3BjaWVfcnAgKnBwID0gJnBjaS0+cHA7DQo+ID4gQEAgLTEx
MjUsMjUgKzExMjQsNiBAQCBzdGF0aWMgaW50IGlteF9hZGRfcGNpZV9lcChzdHJ1Y3QgaW14X3Bj
aWUNCj4gKmlteF9wY2llLA0KPiA+ICAJZXAgPSAmcGNpLT5lcDsNCj4gPiAgCWVwLT5vcHMgPSAm
cGNpZV9lcF9vcHM7DQo+ID4NCj4gPiAtCXN3aXRjaCAoaW14X3BjaWUtPmRydmRhdGEtPnZhcmlh
bnQpIHsNCj4gPiAtCWNhc2UgSU1YOE1RX0VQOg0KPiA+IC0JY2FzZSBJTVg4TU1fRVA6DQo+ID4g
LQljYXNlIElNWDhNUF9FUDoNCj4gPiAtCQlwY2llX2RiaTJfb2Zmc2V0ID0gU1pfMU07DQo+ID4g
LQkJYnJlYWs7DQo+ID4gLQlkZWZhdWx0Og0KPiA+IC0JCXBjaWVfZGJpMl9vZmZzZXQgPSBTWl80
SzsNCj4gPiAtCQlicmVhazsNCj4gPiAtCX0NCj4gPiAtDQo+ID4gLQlwY2ktPmRiaV9iYXNlMiA9
IHBjaS0+ZGJpX2Jhc2UgKyBwY2llX2RiaTJfb2Zmc2V0Ow0KPiA+IC0NCj4gPiAtCS8qDQo+ID4g
LQkgKiBGSVhNRTogSWRlYWxseSwgZGJpMiBiYXNlIGFkZHJlc3Mgc2hvdWxkIGNvbWUgZnJvbSBE
VC4gQnV0IHNpbmNlIG9ubHkNCj4gSU1YOTUgaXMgZGVmaW5pbmcNCj4gPiAtCSAqICJkYmkyIiBp
biBEVCwgImRiaV9iYXNlMiIgaXMgc2V0IHRvIE5VTEwgaGVyZSBmb3IgdGhhdCBwbGF0Zm9ybSBh
bG9uZQ0KPiBzbyB0aGF0IHRoZSBEV0MNCj4gPiAtCSAqIGNvcmUgY29kZSBjYW4gZmV0Y2ggdGhh
dCBmcm9tIERULiBCdXQgb25jZSBhbGwgcGxhdGZvcm0gRFRzIHdlcmUgZml4ZWQsDQo+IHRoaXMg
YW5kIHRoZQ0KPiA+IC0JICogYWJvdmUgImRiaV9iYXNlMiIgc2V0dGluZyBzaG91bGQgYmUgcmVt
b3ZlZC4NCj4gPiAtCSAqLw0KPiA+ICAJaWYgKGRldmljZV9wcm9wZXJ0eV9tYXRjaF9zdHJpbmco
ZGV2LCAicmVnLW5hbWVzIiwgImRiaTIiKSA+PSAwKQ0KPiA+ICAJCXBjaS0+ZGJpX2Jhc2UyID0g
TlVMTDsNCg0KVGhlIGNoZWNrIGFuZCB0aGUgTlVMTCBhc3NpZ25tZW50IG9mICJwY2ktPmRiaV9i
YXNlMiIgc2hvdWxkIGJlIHJlbW92ZWQgdG9vDQogcmVmZXIgdG8gRklYTUUgbGlzdGVkIGFib3Zl
LiBXb3VsZCB1cGRhdGVkIGluIHY3IGxhdGVyLCBTb3JyeSBhYm91dCB0aGF0Lg0KDQpCZXN0IFJl
Z2FyZHMNClJpY2hhcmQgWmh1DQo+ID4NCj4gPiAtLQ0KPiA+IDIuMzcuMQ0KPiA+DQo+IA0KPiAt
LQ0KPiDgrq7grqPgrr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+N
DQo=

