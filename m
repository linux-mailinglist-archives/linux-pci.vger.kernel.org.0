Return-Path: <linux-pci+bounces-12753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F19896BEC7
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 15:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B118F1F23FEF
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 13:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0C326AED;
	Wed,  4 Sep 2024 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q+YILJsb"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625961DA312;
	Wed,  4 Sep 2024 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457128; cv=fail; b=oSGgL5zBsQ3bqdH5WfDJqwYVFFimktmAqCSr9TWGjKl4+jagPAG6slEgJoWQ5IbSBE1pOyAsSpZDw/1VD5nB9lPIDDPa7BYfOQrEIRmGJIEs+HeIo6GEVs5u5LWDMRvq6/3BOvbx+E+VOgBfBcNgaNasekx7xKBCTVvAkdOsyt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457128; c=relaxed/simple;
	bh=rpSvO8MxBz8Lhd8xkcNhtB4HQDwIGv8OrxTwgPz1Vrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WRaCgJxuXTMhhdJsGAWTjcWAnT44srKgzsICMol/Ujt03IrOwNj8zKDUgrEmQtpmsDRT759FEGp91hGxW4olTkpYKCh1YtGuIIlykLAx0cd8N127hxyZH+j7sMSrqTS3LJfDkO8aEjJb9RqbSyRzzTtUluoydsocFe/NTItr9po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q+YILJsb; arc=fail smtp.client-ip=40.107.22.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lga4/PagAJlY9KJVutHyvaz7kevHsjnhDfjJVOVkpZB1lFKYkODHR0H/7nadboeRFNJ7qaLTcf27SROP9h5/xR1FzFa4Q+5B+niu4kUglqbkaj3bL7x3m6qcLgmksgsOC5mdQUKa5129i+bCygBgYWV5D2WI4JWCxBIhScKWFm63bdZ4AiO1f+GeBCs83ty+CtPB+h00uaJ84mwz30xVSaezUiZ5OpW2mX1IDH/xbZYPufeo03uIJCYA+EedkWtfudcRcZSYw0+mZqmKQaVIbssZ0oGoTu8qRWlrTMJVxYo2+zSOyVOkYeCZqos3PFd8AKWcA1W5sLifajSMk+79LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dERWUCEbTFgQDcNrSmoVbNLoOAYiobekG5TEeLBLxgY=;
 b=jeuMRsjJsKPDCDIrS5hXDXstQIJ/dJORMmbx+Qy3F94UjIqsAQwkydILki9ML09epFaq4p+gPlRDUv5z9A8lIpGL0N8Kt6NUjyJngoX6IpolTW+sd/FEwD720+vA24BQrPlkyESg2PxXcDdXY6y0Ar7KiBg9cgf3fI2124+xo0CogNlqwKg2XjN1ROOhXFOEzx0JpVExXtGuuEpGxYSeGczcjPoRmJBW13NafzfdMhhYedFMWD6++I5FAlCcS6ATkqTh/te2+SRQ/caKCIZarsom9+fzTUVDKa/M6ghEZEGmt3LCuT8fGWK2nWeZvhdpPVCwXIzAiBxwMsDwnkWMsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dERWUCEbTFgQDcNrSmoVbNLoOAYiobekG5TEeLBLxgY=;
 b=Q+YILJsb6u5QA6h6b7/yek7PUYILOCkqxT7epktpESrhTorY+cdyKWux9kHKJ6XDp1JoJdWu7s+vzPHXWt4EaocgF9trpE6PPP84nvHmdm+bR3dKem5MTyBkSn+40bl2O4IRyG3za82MITzi3RZ5+wkafb6+Bylb5jQS6rM9ehrw3tFtyQ7/5/9v4GC3Tr9zDkB/P6wdTwfjqzPrLlFTKjzgis12ip7S/ha/ndppXoHvvvZXnMD8MptrkUzLTKslZ1+o4uBW4f37VP3ddIVoRKB1RzNcKizr4kl19PTHCl5/GMejQsaWtM8Zn2/FLY1TFJW0ke7TDTdiNkUIv0+d5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9508.eurprd04.prod.outlook.com (2603:10a6:20b:4cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 13:38:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 13:38:43 +0000
Date: Wed, 4 Sep 2024 09:38:34 -0400
From: Frank Li <Frank.li@nxp.com>
To: Hongxing Zhu <hongxing.zhu@nxp.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Shawn Guo <shawnguo2@yeah.net>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>
Subject: Re: [PATCH v5 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and
 "atu" for i.MX8M PCIe Endpoint
Message-ID: <Zthi2m0uhTjE6E3p@lizhi-Precision-Tower-5810>
References: <1723534943-28499-1-git-send-email-hongxing.zhu@nxp.com>
 <1723534943-28499-2-git-send-email-hongxing.zhu@nxp.com>
 <172356674865.1170023.6976932909595509588.robh@kernel.org>
 <AS8PR04MB86767916B0539B339120C2218C872@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <ZtMTybL79ui5ocPM@dragon>
 <DU2PR04MB867735122DF54CAB00353FCF8C922@DU2PR04MB8677.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DU2PR04MB867735122DF54CAB00353FCF8C922@DU2PR04MB8677.eurprd04.prod.outlook.com>
X-ClientProxiedBy: SJ0PR03CA0343.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9508:EE_
X-MS-Office365-Filtering-Correlation-Id: 628b2e61-b85f-4d8d-7212-08dccce6e4a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tk1XQitEcHl4K1FOa2RBbkJGQmtUSW1md0o3V00rRW9vS200Y0dER24yL0NJ?=
 =?utf-8?B?djJmSUY5VkwvU3p5SXZvRmJiYmtiaTVNRERiUjM2djhDb0NqNmsvcE5EdERx?=
 =?utf-8?B?dVVheEZTa092VjNOcDdlM3dBTjBzbzFQd0hnTjNwTzZaVTJKRFFzTnpJTnFz?=
 =?utf-8?B?a0U4azVsYmFCQ0xpaE8rNUpNSGRMS1ZBZEowbFNocnRJRDBKT1Y0L2xURkMv?=
 =?utf-8?B?ME5XYzJvOHNXQkUveTN1VWRzRklCeEFubVcreTZTcFh1NWxoR3M4NGtCRTRU?=
 =?utf-8?B?QWQvS3VFNzlKdWVFd09NdERlcEp2eVc0M09mZ3lDSzVLT05obkc1V2hzVHV2?=
 =?utf-8?B?SUJmTkphbDkvYW5xZW8zUGIwWlc2Y2g3ZTFGMTdxZUFQcnZoT0psMjVzcm45?=
 =?utf-8?B?Sm9TdUZqUHBkTEcvNVF6djhOM1Fud090L2ZkMXVpQmRQVFdHcWh1SHFZdFFL?=
 =?utf-8?B?TEQ5ODdFdGZ2WXlrMUJBa0h5T1I4eCt1OE1SREVIaWZkMENFMUF6RzVaUGYv?=
 =?utf-8?B?d3JqUVB2dzA5c1Joc29XT1JocHlkaXMzdURaVHByOE9JYkhlMlYxNGtwMHZ1?=
 =?utf-8?B?VmVXeWVGYXBzZEliTUtXOFl3eXpBejVDT0JMQ0o5Qm45VWtaRlRwMEptUGpK?=
 =?utf-8?B?WlBBeW9RZ2RGeUxMQTg4aTJxZTBUbnNNdU14MnJYa3U4TzVyakVhWUEwRTZ2?=
 =?utf-8?B?Y2RtRkNaL0djSGFmTEhNVW9DcEV0SW9vY01VckZxRFZqUVRDWUJmOWJ1NHQ3?=
 =?utf-8?B?VWdvS1lwVHhSakRZdXk0YzlIcGJYYTJZN0hWNjNvRnFjeG9YMnY1TEc3akZF?=
 =?utf-8?B?ajFOOFZSQ09DQ0dEV3lrdUpsNU9FRUg1cUtGM2drajdEaGFiV3BIVU45WUVw?=
 =?utf-8?B?UXdyamlaTmZydml4TTA0QmlMSUVvU3M5YzM5VXJXRkJZR3ZkbVRaTEJsWlZy?=
 =?utf-8?B?YysrREhlbE9NVythdGw3cWhaRXdnenZUR25kd2hXZ2xXZC9KdjMrUEg2Z2E0?=
 =?utf-8?B?R21CaHYxV0FtZEdqOEVhQjNNay9ldjFmRHBXcE55S2w4MDZGK3NuWllwVGVF?=
 =?utf-8?B?TVpoMnpTRHpOUXZGeTJ1Z1BhQThlQXNiY1hLblJGc2cycnRTeDc3MWtNd2ps?=
 =?utf-8?B?OU9oSDRSSnJZNkpKK2krNVNjTWpxOWxyYlkzY1VDZTBaSUxtM0RLWTZGamhh?=
 =?utf-8?B?M0hOMGQwKzdBK2RjbEE0STlheGRPMFB3OTNUY3N3N0JNUXlxMndHRTZUaSt1?=
 =?utf-8?B?ZmFVaDlpSXY5S3djMHo1QTIwRkozRUlYa3ZPS1U1ejRJai9JRTR0dVVmbFlv?=
 =?utf-8?B?RFREaWFTWGNISHJTUFZnbTV3YkJocldUWlBNKzZuWnlPSlk1QmZVaWo0QmVO?=
 =?utf-8?B?MzU1cnZnWkVkTmgxa3JGbDlBTWVZeGpteXFzUm4raE0wZEQrZ0xFa2NsbHVZ?=
 =?utf-8?B?NldmRk9nbmZKSWlOcGMxNWtZK2tRSVpOSitsR3RrZjBuaFhZYUFGZ24rOHVN?=
 =?utf-8?B?NnZSQnBWNlBxRFhkN2lOQ2NJTlFqUmlkSXQ2dmUvZHdvVCtSQ3AzODhKUkcw?=
 =?utf-8?B?aEkwdGxRN1RSSUFBWEN4dTRLZm5WaGxqOHZIKzdjdzA5UmVSV0lRWFh4QUtQ?=
 =?utf-8?B?bnduNnc1NVVWQk9Rb1F2bS8zUnluT3dvdnlRRWI5ZHFmemltUGh2VHRuajlM?=
 =?utf-8?B?dWgzK2NaTEVOa3dWeUZWUEpVU2NzOXN4eXFwZUVIMHA2M3dwbkF1TGFiV0Rz?=
 =?utf-8?B?dGVRMXo4dmo5NmxCb2g0eGVCV0FFQnBpZ0dCQ1hvVk44ZC9lYzVwMEZ0UEw5?=
 =?utf-8?B?MzVjYWUwODRyR2Vob1VMdVE5L3dFeW5HSVJuYUpDUjQxbTlvTWxJeUZ5R2Ix?=
 =?utf-8?B?dHJyOG9GZVlvMjIvYmRsM1FUcnlyZU1TYnhCTUR1V1NqMWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGV5VXpZcFpVckNqQ0J5QmZrZzV4aVdsUHd5L0FnZHRuOGJTK1ZzVXA2Tzhq?=
 =?utf-8?B?am1MTzlMN1kveG5LRUZSNngrd2RUR1BWQnN4TmxZSnMwTzBGY0k2d1NuNndn?=
 =?utf-8?B?T2I0OVZVR2FJYnZKdWJyWXhpNzkrZVVHalYwUUhrVFVaSTErZTNqTVJLNzVy?=
 =?utf-8?B?MWJiUjlZL0dDOTAyOWRnV0s4YVE4SHJtcEZSQlpPRVhTUHQvMlZZakQzaEhP?=
 =?utf-8?B?RDRzU0hrTzRKWVFTWkUzNVl4M3QrU09RQ2lwSTFvWWlCRm14amFHMExSKzZW?=
 =?utf-8?B?aDRpUlMzQno0RzduLzYxeVV6cHlNRGptLzdXY01WUTVSUTBubzVVYmpKWllP?=
 =?utf-8?B?em94cUkvL1VlNy9XaFJBVEJuNzAxYzdNVzkzYXZvUmI3VEx1RE9tUEpqcGVl?=
 =?utf-8?B?dmFZZXdFZXoxZmR6SVJLRU1ZaXVtNFpQWk9jL0g3ZzlDVTgzL1lRTzZjV1Zi?=
 =?utf-8?B?L2laNjlLMzQwdkhyVnRqdEo4TnFHejZ0bGtHdFhiaHhkczFTQmlia2tSUXpC?=
 =?utf-8?B?bEFrbTFkWFZ1QW51Qnl2emJrZUJPNHdoV2ZvQmhyMEFPRnRabEt5YUFPUzhU?=
 =?utf-8?B?MWJ1VlJFUUExcnNHcGhSU3BwR2pyQ2oxLzFRLzVTWTdOMDRTeFNrYjBlbVZ0?=
 =?utf-8?B?eVB0eEVtYi9hZ0VUSUtyU2Z0ZGI3UVBUbFd1YkhrL2w0U1BmTWVXTzlVWDVo?=
 =?utf-8?B?UnhVNy80aWM1Zm1DVXd5cHdsa1RXTkxtdkpxOTJtZjFjRis3WFlORzdhYmRt?=
 =?utf-8?B?N3hEWXJQUlpwa3RWZkFJK3dGS01iZEZENjZpV2Q3MzBFQmpFT3NtdkovSVov?=
 =?utf-8?B?a3hSR1Nob3hBeithcXh6M1dzM2V1QzZRTG1HU3FjK2UxNFlrcjgrSTFrRW82?=
 =?utf-8?B?SDFhaVNQbmt4QzErU2lPdTJEdm1ianRaR2JEQmg5ZTdscktmQjg0SU44MlBU?=
 =?utf-8?B?UWs1aDdRUG95OGsxSm00b3BsenlvcXRTVlZFV0RzblRBZzVXZ0JIUFVDb2JO?=
 =?utf-8?B?VExMTzNyQ0RsQ1NLbkI0SWtVdlVtOFFRcXh5S1BEMVpIeWdYNTRHK1hmN3hx?=
 =?utf-8?B?enR5NXVYdTQ2dDkyVXRNemRIUmlDZ0gyMCtMd1U0RDBnamxjZDhIekhzNnJh?=
 =?utf-8?B?cUZ4TWxJUG5lZ2R4T3J2K01nZFNvZzM1NDFaUW0wV1RQa2l2S2RtR1BMNnk4?=
 =?utf-8?B?NzR6VzZYYlVESnhnUVVpUEt2NHJRc0ppQTRHUmppcFVXeTllTVJ5S2JLd3lL?=
 =?utf-8?B?T2p5WWFnbFM3Q1JqaWNsK05DVjlIZ29kS0UwRlRic0RYTDBmRlJTZ2tCSTRI?=
 =?utf-8?B?V0piOFZmc3QvZEhiRHAvbHVBU0d1aVg1RkIrWmc3aW1IY1hTKzIyeWRrUnRV?=
 =?utf-8?B?bXlVWmkrUWVSM3p6dStHTHlWbFV5MnpWcE9Hc3dzYnVxN1BYY25pSk1DczY0?=
 =?utf-8?B?bzdjMEpGRUJvTFJ0TGN5aFJnemV2SG9lb3NDbVg3UDF0TXJvRTJnbm5NV2dM?=
 =?utf-8?B?TVFrQmQ1bEMyVm00Z0RibjZjanhIWEVveGkrV0xqeUVRcGxwSDBMckNvTm1R?=
 =?utf-8?B?Z3FiN1VabmxDZUh2WVhLamNsYzVDdldsdkdTMWtkZWN1aUdPVUc1c1gzQVlR?=
 =?utf-8?B?eEdzNXlYUXR5NXdWUytGSlVzc1pJK0xwMW9YaVVtQzY3R1pweWRRRE0zMFZp?=
 =?utf-8?B?K1pqOUNjWHJNazJRSHptUnVGdHdMZm42RzgxU0gwVnhlTDNiNG0yeWRKelRk?=
 =?utf-8?B?cUl6dTJ6K0pOc0pwY0ZsTWpMK1F2Uml3MSt3bE9nVWRsOGhjcml0SWQ1TVp4?=
 =?utf-8?B?VGFTaVdtN3VJbEgyRzRzWWNMVndoRTlTWGJtdXBxWE16ZlBGWGE1QUF5NmZO?=
 =?utf-8?B?MHNEQng1MWVYQi85b0NPYjhRTjRSSFFOMU1va0lQclA2R3FQK3JPb3RIK3Bh?=
 =?utf-8?B?Z1ZESStPSThaNHRHNU1LRzRnNTdMbXdyaEVHK0lRNjBMVUpKeTIwc2gxN0tE?=
 =?utf-8?B?VlZkeStoRjVVWHVPMU9tL2tYbzFtZEFxbFNpTEIzZEs4YWVOSEcyNzhTRWh2?=
 =?utf-8?B?SmxMVTl5RnRQSjVLV2dDM05jTEtWY3VEN2E4NUNhOXptSkdqVGV4ZjJ6akJ6?=
 =?utf-8?Q?ZpT0/UgIVu7HNvZ8HXxwxaKcZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 628b2e61-b85f-4d8d-7212-08dccce6e4a2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 13:38:43.1465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBlEjmuLurefbDrDlMPKsoE8k4RxcO2CZZTqlXVuqpfrD0xyN03/fOyeWte9g5eRIfhezX2aY9plIVZnEQ6DUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9508

On Mon, Sep 02, 2024 at 02:08:05AM +0000, Hongxing Zhu wrote:
> Hi Shawn:
> Thanks for your help.
>
> Hi Krzysztof:
> Can you help to pick up the #1 patch?
> Thanks in advanced.

Add Bjorn Helgaas, I am not sure why origial To/Cc list have not bjorn.

Bjorn:
	Could you please take care this patch, which already acked by Rob?
	We don't want to missed this merge windows for this trivial binding
change.

Frank

>
> Best Regards
> Richard Zhu
>
> > -----Original Message-----
> > From: Shawn Guo <shawnguo2@yeah.net>
> > Sent: 2024年8月31日 21:00
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: Rob Herring (Arm) <robh@kernel.org>; shawnguo@kernel.org;
> > linux-pci@vger.kernel.org; devicetree@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; conor+dt@kernel.org;
> > imx@lists.linux.dev; linux-kernel@vger.kernel.org; kernel@pengutronix.de;
> > l.stach@pengutronix.de; krzk+dt@kernel.org
> > Subject: Re: [PATCH v5 1/4] dt-bindings: imx6q-pcie: Add reg-name "dbi2" and
> > "atu" for i.MX8M PCIe Endpoint
> >
> > On Wed, Aug 14, 2024 at 01:49:30AM +0000, Hongxing Zhu wrote:
> > > > Please add Acked-by/Reviewed-by tags when posting new versions.
> > > > However, there's no need to repost patches *only* to add the tags.
> > > > The upstream maintainer will do that for acks received on the version they
> > apply.
> > > >
> > > > If a tag was not added on purpose, please state why and what changed.
> > > >
> > > > Missing tags:
> > > >
> > > > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > > Hi Rob:
> > > Oops, I'm really sorry about that I missing this reviewed-by tag in v5
> > > by  my mistake.
> > > Thank you very much for your notice and kindly help.
> > >
> > > Hi Shawn:
> > > Can you help to pick-up Rob's reviewed-by tag?
> > > Thanks in advanced.
> >
> > Hmm, this one should go via PCI tree.
> >
> > Shawn
>

