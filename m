Return-Path: <linux-pci+bounces-18729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5484E9F7080
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 00:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5794B1888CFE
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 23:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC6F1FCF57;
	Wed, 18 Dec 2024 23:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ML7XN7tr"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719A91B0432;
	Wed, 18 Dec 2024 23:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734563352; cv=fail; b=TJQ+ON8wmA17UHwW4pZK0Jc5BXTpyUv+JRpFm3Z1fl8U9sn0B6W78WNOwtWWlXc2X4mV8n74ke/EFwVAs4v5OX0f0xuo3yvTtFPgalyJpBguzT2AgSgvgQYcISpbsZIXqI5YMitp9MeWRt5KrTeXIZaV7gJ9QAQsuohTxX2Xme4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734563352; c=relaxed/simple;
	bh=CjpdDETOi2VIxmLfWYm/yAsNYvD4NkW7aNy1uWn3fGs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GYmwuTTKd+yS0gs9lGg167wV3yZj3PHCYHUz+58kTX/C75ydP53PhFliRfZgiI/BU/ZPdNDy6C8TQgOf54TZpfVByN1irw0GEct5zjLRV1rKYMA3gaqfTxPWZmOxWe48nJ7jsoxHVloLxwmBrtNHwFDYJaaU0UihNR+r7a+EEKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ML7XN7tr; arc=fail smtp.client-ip=40.107.22.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTPCMXdEzpd7dJv3fxJoOIpZggpwoWiPPZvysOU1SexVRZRTSP6DIENwuxs6CRWpqGzzJ39GO/GhkICA5ZCIdDctDiWsPNnAxcAQDqbRaWJ6obn9vx1yb0Fb3JcTjeKcjQvnx89ETF+8dBfbs1P3D4MrDjhOwAYPwKhMt89q4pnbt3Bbw3AuQyJKpDofMOB7jgBR15UEifJRvwpoVju/TOKbNwIZ7USiAXxtRmzHtoWrtdIxC+0TCOeC35IIaDX6elqEC/gpgfwZFee8dXQ+RkFw/UALMryLzqHmcLBHy7BvduDYkyP47De5X9L6Yf87HLhdD+V+g4N6lapWqJ7N0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pf/oi8vmEOUmPTe7wYXgmKpdXfPYSmq7cIctdRdF074=;
 b=ezpesn+qj9TlNoARNIBIGNbPcQ8eUz1jS/Oz4bquWXAVG63UqpmCM9asfnkGulY4GA8CGkB2FsemEWzwXyS7cEy0ltwa72OUYuG7OLX0dh8hGHn8arkd7MWWMIrbbnIycjKXydKA4mR8G/SImNl7tSCjDcXjY5I02JZx7z6mo6O0xoflvY9QcEySpSK2Swi54B6Q5qCb/qmOjt4l+lPAc+v5yue8ZgPacIRWTc1TI7uXpM8iPVIFXPWd1D8zoYwBc/IuoAFSncmp+BwQRVRD/mUzBNVMmgwJytq4swHNRjPURjfgbT+Lz/y976Iz3LJMExGrpF5ibKFHhyAlMqEqDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pf/oi8vmEOUmPTe7wYXgmKpdXfPYSmq7cIctdRdF074=;
 b=ML7XN7tryuuhkW1RlMZvxZW7vSj3mRHTizY81xXBuD8O3eBsHZeUc6qVjIVKxuvPyKPfiuE0zjwsrs8EYDlBXHuu5/ZAG95QkZnu0WZ8+6ey+ncTx6osPrjgM6SUQSL6Zz52tvtOdtfFD8+ZVsftYUfhI8lku+2VwMxEY0ME8ilzSmKrP6zltEj46htQ+ZvdSzc0DD/Q6OaFxevCxda0q68fjO5qo+Lbnl/foPo+e2uo2+DtNyCtP3atQ57k+IAqsSymjr8JVzZEjSIfQ3HmMupvyQP5BAp158AiHP0oPEojumIjnFGLIYwnPDITxOFuK8+4He+0drbp0j5a1OwOOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9939.eurprd04.prod.outlook.com (2603:10a6:10:4c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 23:09:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 23:09:07 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 18 Dec 2024 18:08:36 -0500
Subject: [PATCH v13 1/9] genirq/msi: Provide DOMAIN_BUS_PLATFORM_PCI_EP_MSI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241218-ep-msi-v13-1-646e2192dc24@nxp.com>
References: <20241218-ep-msi-v13-0-646e2192dc24@nxp.com>
In-Reply-To: <20241218-ep-msi-v13-0-646e2192dc24@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
 Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 jdmason@kudzu.us, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734563338; l=3489;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=CjpdDETOi2VIxmLfWYm/yAsNYvD4NkW7aNy1uWn3fGs=;
 b=MyLtN5Xnebvp0UjV1seHBr/iqAA/dHH6fsYXDWuHyp3lb2ig+UkGEU44nLIpoyKvuPIKdOijh
 0I0mj1vsg5eBKrxgVWB95Q3e6idWqosEfYo1NhVwZw7832xUyzr1xBg
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9939:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f858bc7-828f-4e3e-cbee-08dd1fb8f984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bW1JVzVCUGZvRi9XcVNqaml1MlhkZ21xVitXbFRvWFliL0poTGV3Qis3alNq?=
 =?utf-8?B?NVZxTXNCbklHRjZiREloUWJ4d3V2ZlRmMjZ2WVBmZStaOTA1YWdlM1RsS0Ja?=
 =?utf-8?B?U3JmaEcvY2cxcUN2OFRzMHEzdGREL0xyaC9mUXozRC85R0E5bXlzMlR1Mzg3?=
 =?utf-8?B?U1pCMnQvVVNiSjMwY1Zta3M4QlVaNGdSd1pMc1dyM29KSjdPa2VyR3d2RVV6?=
 =?utf-8?B?bmc1SVRLK0lEREhmTUxiUFdrM3dFa0NiUWp2MmZESUtsOUdyK0tVZ0RVYlR1?=
 =?utf-8?B?Y2JiSllYUVlRS1JiZVh3bk4vN0FvUTR1WTF6WUFTSUZtUUNWZzlXT05tcFoz?=
 =?utf-8?B?aGMvT2JwOHRoNUVUOWNaZ1BzMi9yeDRJRXRteExMY01CVVpVcENFdlBKYkZS?=
 =?utf-8?B?RldmLzhrMG50M0F6eXhvbDlVUHhnYnN4aHc1V3kzWjdHWEVBWEFrRWZvOC9X?=
 =?utf-8?B?S0h2TEtuTjlhcnJoY3VXOGR5SXZwSER6QTN5Q0J0VVZZV2VHYzQ5Yk1OcnRJ?=
 =?utf-8?B?VUw0MlVIVUpZUzFCNmo1VVRBbE5jYTBVMXlpSVhCQ1k2YjI1TVMrSzR3ZmdD?=
 =?utf-8?B?N2pVcUZuUzZvbFc0TEJuT1I3cWlpRDBKMFo3WVJ1amFBT2FhdW9rbnlPY2lM?=
 =?utf-8?B?TlYrS0U2dnl6NUR3WlBNR1dOM1FVVmo3MU1HeVAwbmFGSVpZTHgyd0hNaEdk?=
 =?utf-8?B?ZXdlQUdGMDRxVStCQnpIdVBpYm03bHRiYU5WVHd5VXFmeVJaUTRZQjFMODBF?=
 =?utf-8?B?ZXVDZG1UdytkWVhvcTVPMXVzYUdQakxUQ1BUVXhkamlwd1NKNVVGUW9IT2VN?=
 =?utf-8?B?V003Q3VOZnkzeWd5RUFzeThBVS9seW1jTjEvckxKMUtmNnB2bmQwYkFsTmdi?=
 =?utf-8?B?S244NWFSTFRhdWo3b01VRkZ6Z0Q3dVNQOUFmUDVHM2VDN3VLYlV2djQ2MmNK?=
 =?utf-8?B?Slh1dnh5R0dOelBmUHhxaFFQUVl4MUZyYXVBblo1YWFzQ281NWFWRVVhUzFw?=
 =?utf-8?B?V2ZhSE84clFlMXE1alNVNWpyaG12MkpLbXg1TEFlbytCQXFuK05rbE9tbFkx?=
 =?utf-8?B?a2JHNkpwSGZSMmhTcEpFbVJobDVSaHhKc2dCT0c4dGNSY3V1d0dOMHNFZzBO?=
 =?utf-8?B?RnY1M1NQRUoyb08zRDA0MVFJSGZNNVltN2drWlRNN3RJb2VRSlZ4VncvZVRr?=
 =?utf-8?B?RVVMVjMyV3dJYktha1haQjl3bm9Sek9pRVdyaUhlVnpiV3B6U1JDKzN0bEFj?=
 =?utf-8?B?blVmVzRmV2RhVnhrZHhaK2tvcFNPVGt5cFlMN1NkUUdNZ2pZajlKU09uMGFW?=
 =?utf-8?B?UU5RS0kwdHhXQVVkS0JRblRvUmhJRnh5THBEWFQ4OEJkbGErc2ttTklRb055?=
 =?utf-8?B?N01oY1VUTVBuL25XREFLcUduTjREaUQrTG0xc0hGYUZqek93eWkzSXNiS2tw?=
 =?utf-8?B?Y0RML0F4bjd2WFRoUGtNUTRKd3ZSZERvTm5Qd3RCcnFGQXJDY1YyQndXVXE4?=
 =?utf-8?B?MTNpNlJvZXFDdGFWU1pQZjN4SlpyT3dEVDF5bXA3NlZjd05UbXd5alFIOWl0?=
 =?utf-8?B?M1M1d1lJWnVacEJIQTFnOUtOUnQ0ZzhPanpRc3FpSlZVOG1SSzY2b3crNmRG?=
 =?utf-8?B?NW5wSCtVcDI4SGN1RWZlQjh2NUJqelpXMjBhZU1WYXFacTNCSmd1TFc3NHVs?=
 =?utf-8?B?c09EcHFJbUkzMzRMRWx6THY5Wml5eEw4UE1rZWZrWkMrZnJQWHpXdUwrcmly?=
 =?utf-8?B?b2NYbDErRlQxczMzRHVzbVhLcFk3cXNPOHB0VWptdjdDZGhvdDE1cHF5N1hv?=
 =?utf-8?B?Y3c5V1hCVWNLMFBSMHQ2ZEhMand1NUl3bVp0R2NVUDVDcjFjQ0NVU0lzRkUz?=
 =?utf-8?B?ZE0xUmJSL0NROW1GQzhYcldsNXRGNFdWTXQ0MVJieFRtaDdQSWVibWRqdlpy?=
 =?utf-8?B?M0JRR3lWeWs3UGRzbUdsYSt0dnJabVdDclRkalVvNGNlZjJiTTlhL1ordU9l?=
 =?utf-8?B?N0kreWx3T3FnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TklKeW9UZkZLTlNsZE5LZGRWZG9SZmd1OUtmMGk3Y1lQQk54VDFYeWF2NHFM?=
 =?utf-8?B?cnVXSXBLUHk2MUcrVDBVUVZzSFZZMUo4UlVnTmlYNEpuWlJ0eFZ1MXB2bVNB?=
 =?utf-8?B?c2tHOUZMTjNXeEg0SFJRU1M1OWFrS0FqME5Ra3F5cC9VZmhZYU5QL3FoZm9h?=
 =?utf-8?B?SndKd1l3Ni9LTm4rNTNFYjVQM001TGtZNTdhTS94NmlhRERtV1c0TTEvajBw?=
 =?utf-8?B?YTVmQXU3WGw0eWcvZUZreHNSMHlnYmthQ21QZjZudy9mYUlIeXhXQlJqYUpZ?=
 =?utf-8?B?K1Z5MzRxOVVQTGJuWWhxVFBDd2JsNnZzRE5yeThxQW1vR0luYk95L3ZXUGlJ?=
 =?utf-8?B?TkxZMTYwT1hzRW1wUmZmNy80VmNwRXNLZ2djTXhwckpjeEdSTjl2N21kS05x?=
 =?utf-8?B?T0xuRWxjOXNYMkdvZmxQV3RqemM3b1pPWkdFa3NlbEZnZFo5d3RweURaUHQx?=
 =?utf-8?B?UWJIUzgyUFBUUG4zcDdscUY3TkxDcTlkUjM0OXR4SDJ5M0pmcnUrNHh1cVpv?=
 =?utf-8?B?Q0kybDJZeWxCSm4wMXp4S1BWVCtOWEoyTWtXS1lnQVFWOS9tNHVacXczaGJJ?=
 =?utf-8?B?eFRzVVlrWTZ1QXhmdlBGalpYY1BWUFQrNzVZcnJSMnVRZnJaUm03TGsrSStk?=
 =?utf-8?B?WDJJdmxvMThOTzVyRjJnaHBGbmZpaWpCRDN1SUg3SlFEYWdIZExTcDlnWTAw?=
 =?utf-8?B?Ny9hRlY0WFdsTFpsR1lxSDJWbDF1T0F0ZTVjQU80WVdKYk9OOXA3WUJEYlBh?=
 =?utf-8?B?enpvN2FpYU13S3RMRGVQc2kxZ1lLYjVzWXZycEJzdVdNV2FvV1VsSzlsbFNw?=
 =?utf-8?B?SUc2WUhXOVVVUjdEbU1QUmlCWjRnS2hUYVQ4UlF1NTF2OUtIRUorVmhpRjRv?=
 =?utf-8?B?WWt4U1lHQUpWZTBySG5ENWxrdDRoMTRnRDlydzUyeGNFeWx4bHd6REFDVDlV?=
 =?utf-8?B?eHZMWldES0xxMFZqdEw2QTdIQUhNUmFwaUhIVDk3MUVHeHZwNmJtdkJaRW5C?=
 =?utf-8?B?VnJGbkxKRys5TjdvdUE2OG9mbE5DQXlzN3pKazZqdnVBd2FOWXlWU2JjQ2xo?=
 =?utf-8?B?eFE5a1h2b2w5UklzdFg1Um1oUzJsTjgyS0t5bk9GaHFFeThqZmFqZjNyQkFw?=
 =?utf-8?B?ZzdqeVV5K2FLSUpVSndVWllVSVZ0YllTMWhQRjdYRjQxTTFlZjM2QmdvMURh?=
 =?utf-8?B?TE9sdzdlYVc4NmVFQU9GRWRYZWcycmg2QTE5VHZLaHlYU3BqbDUwY3FPWFM0?=
 =?utf-8?B?Mml1aE5hU2ZWanlzSDdrUFFONmpwRi9ZYUg5SFhVUDI3ejlFNktHRTlISW1s?=
 =?utf-8?B?M2RZcUdER0svaHo1b0xTTkZyTFdBeS9Sa2ZhM2xHYnJDVXRuTWlpRkJVS0dQ?=
 =?utf-8?B?b0k2b1FvSWhJZGxoMkVTSDFVZjZFOU5lelF5ZnhjVkxYNmNNV1czY1hjUURU?=
 =?utf-8?B?TU1Zb29ob2lyUjg0SXBZcE93czhYZklmU08xWVJRU3RHMXlUTkFJU0wvQWZi?=
 =?utf-8?B?QWdNRVpCZEt1aEF4dEZJQ2lTNVRZblRYZTVkZXBEV3M0RVY1NUZ0RWhON0ND?=
 =?utf-8?B?aG1HMktZN2s3NHllS013S0l6Y0dpRkJJNXFGNThQRVRaZktaeVU0VnpIQmhq?=
 =?utf-8?B?UUFPeXIrWWprSTAzamQ3Z3U4eTZQMWlWcDVTbDYrYW10VXcwUGpmdmZ1amlZ?=
 =?utf-8?B?TzJQR0E5U1M5QTF3Tm1CTVdrcUh1czVRMnZ3MkNzRWR0QzJXUHJnMDE1RUk5?=
 =?utf-8?B?OGs4REQyYys2bVVOdDFGYUtkWG9zWEs3SHFLQ0lGVHY5SVhFeEd5OXVkVWxi?=
 =?utf-8?B?bWMreE9ja3ZNdG5BdURwNEs3STZteWtBWjR1T2hSZjBlZ0xuZHNaL1VRS21Z?=
 =?utf-8?B?Zit6UUwybUxxUXdzTUYvS1lrRUNjdXAwVTdacFF5Wi9QcnJVN0IwQnNHTksr?=
 =?utf-8?B?SnZycndlOHUxWXBydmJpNXdqVXNucnZuOTFFWDNSdTZINWxkTkI3a0xnU2Nn?=
 =?utf-8?B?TnVkeGdZMDRFTVNyKytvVXN0QVlyRjRUZ2pseFNlVHZYTDlTVHRHNGhLbnFI?=
 =?utf-8?B?VmxQZ2RkNU5laDh4aHZVM29GQThISTBwdmxNUldjeWkwamNDUUE4elU2aU9v?=
 =?utf-8?Q?F0brVRWpNRuThU4mmJz0XqLnR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f858bc7-828f-4e3e-cbee-08dd1fb8f984
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 23:09:07.7969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PAxs/fLh5AqOgBgcnhBQKhp/YLgYFjsffk5pOGvLOkEsJY0aMRbDMdDiG1IpAvZd7UrhV+QTle1kXZyKuaJYbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9939

           ┌────────────────────────────────┐
           │                                │
           │     PCI Endpoint Controller    │
           │                                │
           │   ┌─────┐  ┌─────┐     ┌─────┐ │
PCI Bus    │   │     │  │     │     │     │ │
─────────► │   │Func1│  │Func2│ ... │Func │ │
Doorbell   │   │     │  │     │     │<n>  │ │
           │   │     │  │     │     │     │ │
           │   └──┬──┘  └──┬──┘     └──┬──┘ │
           │      │        │           │    │
           └──────┼────────┼───────────┼────┘
                  │        │           │
                  ▼        ▼           ▼
               ┌────────────────────────┐
               │    MSI Controller      │
               └────────────────────────┘

Add domain BUS_PLATFORM_PCI_EP_MSI to allocate MSI domain for Endpoint
function in PCI Endpoint (EP) controller, So PCI Root Complex (RC) can
write MSI message to MSI controller to trigger doorbell IRQ for difference
EP functions.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v12 to v13
- new patch
---
 drivers/irqchip/irq-msi-lib.c  | 4 ++++
 drivers/irqchip/irq-msi-lib.h  | 6 ++++++
 include/linux/irqdomain_defs.h | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index d8e29fc0d4068..cf39f2e481477 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -57,6 +57,10 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 			return false;
 
 		break;
+	case DOMAIN_BUS_DEVICE_PCI_EP_MSI:
+		if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PCI_ENDPOINT)))
+			return false;
+		fallthrough;
 	case DOMAIN_BUS_DEVICE_MSI:
 		/*
 		 * Per device MSI should never have any MSI feature bits
diff --git a/drivers/irqchip/irq-msi-lib.h b/drivers/irqchip/irq-msi-lib.h
index 681ceabb7bc74..5ccfdb14fce1d 100644
--- a/drivers/irqchip/irq-msi-lib.h
+++ b/drivers/irqchip/irq-msi-lib.h
@@ -17,6 +17,12 @@
 
 #define MATCH_PLATFORM_MSI	BIT(DOMAIN_BUS_PLATFORM_MSI)
 
+#ifdef CONFIG_PCI_ENDPOINT
+#define MATCH_PLATFORM_PCI_EP_MSI	BIT(DOMAIN_BUS_PLATFORM_PCI_EP_MSI)
+#else
+#define MATCH_PLATFORM_PCI_EP_MSI	(0)
+#endif
+
 int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
 			      enum irq_domain_bus_token bus_token);
 
diff --git a/include/linux/irqdomain_defs.h b/include/linux/irqdomain_defs.h
index 36653e2ee1c92..feecbc27c2575 100644
--- a/include/linux/irqdomain_defs.h
+++ b/include/linux/irqdomain_defs.h
@@ -15,6 +15,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_GENERIC_MSI,
 	DOMAIN_BUS_PCI_MSI,
 	DOMAIN_BUS_PLATFORM_MSI,
+	DOMAIN_BUS_PLATFORM_PCI_EP_MSI,
 	DOMAIN_BUS_NEXUS,
 	DOMAIN_BUS_IPI,
 	DOMAIN_BUS_FSL_MC_MSI,
@@ -27,6 +28,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_AMDVI,
 	DOMAIN_BUS_DEVICE_MSI,
 	DOMAIN_BUS_WIRED_TO_MSI,
+	DOMAIN_BUS_DEVICE_PCI_EP_MSI,
 };
 
 #endif /* _LINUX_IRQDOMAIN_DEFS_H */

-- 
2.34.1


