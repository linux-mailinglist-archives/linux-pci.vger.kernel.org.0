Return-Path: <linux-pci+bounces-20061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5D6A1529D
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 16:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7221696B8
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 15:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E542B9B9;
	Fri, 17 Jan 2025 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aA2HCXtb"
X-Original-To: linux-pci@vger.kernel.org
Received: from outbound.mail.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0257213CF9C;
	Fri, 17 Jan 2025 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737127053; cv=fail; b=eJGyLSl7utgX31kHmWpE5ggl+zyOnCvyYgvQWqFffxzMPh8d1VLqFrqMBey//J8Y2gLVWEuHIMc/aLLQOLHVuhrAmui3cTUKvwhe5suG4iWqwWl4hyi7EkNAsU9Q8gHc/mRiSFMAbpIaYHh2dLp/WzHcAJfWwywIuvqYWY6xae8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737127053; c=relaxed/simple;
	bh=IQbobRCKx/L7SVgh8uJDOrnadwP8X5Sxpl56jZN5JOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ABdODNVm2TBCy7mf4iVydERPOOLXY4T+wDoOs+leKgJ/Bv6xwt6FcCAeOmqU00W8TbAzjLwqcRGfeM4A/D4zBmlzpW2RHmc3lDxgJ3BFH7YXzYKYGJRmzg+WGFRr5Qzq04qX6hJzo8B6Mkk6EqV4WQyteRBlT9Lb5FFO1v2NqSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aA2HCXtb; arc=fail smtp.client-ip=40.107.21.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvgxRIP+RwacYYrMFLdJrIsUC041Ijr3lydvQm9dUMKWkJyb3IzkhBQat4lMm4EuAJsBJE3Dqx83hdc1C6DKtsy5o2bh75Zzk10ShkdV/yUW++zFfIHdxoCI80hJId+PsgyobtEGJSXZNKaCM64IRuG6+EDFZTBWdwMD5WxW7owH2VG2zSRnRNOGNaMYqAA9fsECiT9HxbHQ5ruN1jPF1CtE/9coF5DxL9dLEuQVEc/D9dfeNGZXQo+TrI3z52u7rmCRet0oypgR4eh4obf7pCymQ41QJnlOy+P86ySbZHDVCaHa0eudC2uau7wWDVFL9shGiG7KsaYlBUuKFfzjVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9u1ojNZCcWdedYBcMjpR819ujtssMeqgdY/ShPo3Ss=;
 b=RTrFVVYhWTK5ZBb7EIl156oLLLbeVh5gZlikuto1OEG/LTsUEtalbQz6Mp3CFk9A3NZ0ZuBqnIYyHVk/KOaNTo3csCaC6PA6eCN/sjzb23Cp4tSv+bVFWulXjBIjaYPRYzA4YD74dRuQylwMo1vh1WAb+rQyaXc6Vg9jqLN8ctLETF2jTYCEQfncP8N+OaEKsZwHgrUWW2Tf294Qqp8oNIIfzIbSsaPxZTJS67l9fbZJTQXOqGLRf/+wcy+TQWnSU/D3dBp1N7LMCEvEll7Crv5DuZxJiB2FlKeZzIc9nibzX5ZArb27QofuE8kqLvMzE7NimyZnblGFI8KvDDEdNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9u1ojNZCcWdedYBcMjpR819ujtssMeqgdY/ShPo3Ss=;
 b=aA2HCXtb22jVA2J482f/QljFP9ZPHbJWeWnk2zjWRg1bWSxkGQxzTIREJ0rV1rlzW1V9SqBKwD4DtPUoHBlRmSQNitePmZ1ZmVdEFknoru8ohn9QZN7wR0plqNx6ne2P0j0nJx6AlH/KH+pervax8VMUunSonVHaBPT2yEvn4UEZ8hCVoyEIgIcUasjRRLYuUD2TvF7JoDgyW5xnFHfW58k6w2QFPB2OPwCgfPgtj/yCPYKfi/X+H8+Wncz4YcttsMAx0TbRP9wZo42hprV6+WA3gm20Rcgov+dyxPXW9zaAkEe7lqGWfnm9CcFEQNeUsSWHhHsUi6Q5/o0dSjf2gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7844.eurprd04.prod.outlook.com (2603:10a6:20b:236::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 15:17:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 15:17:28 +0000
Date: Fri, 17 Jan 2025 10:17:17 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
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
Subject: Re: [PATCH v8 3/7] PCI: dwc: ep: Add bus_addr_base for outbound
 window
Message-ID: <Z4p0fUAK1ONNjLst@lizhi-Precision-Tower-5810>
References: <20250116224902.GA614046@bhelgaas>
 <266CE37A-A50B-498F-8BE7-5D6449F72E5B@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <266CE37A-A50B-498F-8BE7-5D6449F72E5B@linaro.org>
X-ClientProxiedBy: BYAPR01CA0019.prod.exchangelabs.com (2603:10b6:a02:80::32)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7844:EE_
X-MS-Office365-Filtering-Correlation-Id: 41b41761-4ea9-446d-8cd7-08dd370a0de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmNMdTJMejV0SS9COUN4RzE3cm03UlA5YzBQWTdpM3JVZWM0SlArQ0JUWWFY?=
 =?utf-8?B?ci93aXRDVG91cHI2SVAvZXd0NmlPaWYzbVZ6SjdxeW5ObFpWeW00RDZGZm9z?=
 =?utf-8?B?SnZHRCtNbURFV2lML1FZcUhwaVRPaE9mWnM0UkJlVWVhZDIrcTJOYzFENU5M?=
 =?utf-8?B?ZDNwOG9HbFA5OXpQRTkva3dUaEhJRDV0TnU5NTBLT2h2Q0JiQWhXUlo5ejY4?=
 =?utf-8?B?ZHlKS0Y1ZXloek8ycVZYa2xqc0dPUFY2QkoxTWFFVVZoQWwwQVc1enRYSXpo?=
 =?utf-8?B?eDY3Rlh2OGZYWU96Uys3RHN2SG42T0U0Z3dBTEZsSXlWZ3RsSmQ1V1Nwenho?=
 =?utf-8?B?UHd2S01MaXJtbXRTTkpwWkc2SzRYR2UxT1dXRU1UQWVYUmdQc0UwMmtQRGVo?=
 =?utf-8?B?WHdWQVR2RE1ldjliYzF2WHVrRmtaZHJYa0p4a1pkL1NPdGNMRFhoWU5TMGsx?=
 =?utf-8?B?aEEzQjA5bkV0cXpJMzF5c29MUzhNVjJnK2g3QVNHLzFlWHdxMkpKdldoUFRR?=
 =?utf-8?B?blh6RVFhTy9CbWxNMG8yaWNTcW1Mb0t1cnhFT3RmWm9Fd3VlcjBxVmtSMHFG?=
 =?utf-8?B?d01YTk9BdXVRdDFtWGFSblQvYmpxU3JRUGsyUVdZMWpPZlhZNDFTOSs0U3I4?=
 =?utf-8?B?NDVCTVFraWQ4R2FISjQ5N3F2OVM3cnRpakl4Q3B3NkErNTcweDRkR1poQVZG?=
 =?utf-8?B?Z1YyOUI3U1BMQ3hEYWU0cGpFTHBLcWZ0VVUyTlI0UDl3THZIelc0QlV6cDQ2?=
 =?utf-8?B?TERhREFVQi9GOHVjdkhBbmpqbFZoZWRTQW9aYTl0UTlKb21zZzZucFZHODd1?=
 =?utf-8?B?TnRGNnJHMHErT2s1L0w1bExod3NqUjBGZ3pUSVVzWE0rQ0JtSlJRU0M0VjV2?=
 =?utf-8?B?bjBsNGh2aUY2RFlxdlFHckpjcWV0Q0hHYmVBTHFMRlFjYnZZZEdHZU1nNEhs?=
 =?utf-8?B?d2RSZTJiMGdOL0ZrU3cvdWlvTWsxTGhFUGhoTkJYN1kvQkdWc3ZYeno0VU1s?=
 =?utf-8?B?MHl1Nit2VEZQeERtRy96c1hYMmwzUUNCZklTSlhzdzFDZlpEekJqS2pDUjA2?=
 =?utf-8?B?cTBnNVVkaW94UDJtN1M0T1doOFZnSVdaaW84eG5GZjhzVVorQnY3OEdmSGp4?=
 =?utf-8?B?a2RnbThTR1lYbThLMVc2T1BiWWJYS0MraitDaXZvc1NJbUV4Mm5waFFjWTll?=
 =?utf-8?B?TGVRZXFLOFBuSUFSS2VpTHZQWXhtYTV6NVo3bzU4RzFtRk1aZk0vdUpWVnZq?=
 =?utf-8?B?QWM3WTJYamZCMDBEMjRnbmUvS0ZtOWdIUzhqdWxOcVJyWVdmb1YwdE0vQlpT?=
 =?utf-8?B?TFlwTjNVdlQzR01QQS92MzJSdGg1MjhZczVzWFNjaTlXeTNZUG1Xd0Jad1Fh?=
 =?utf-8?B?S0U0MHJ0TGVISkhUSUR6UDhrRFJzemtBcFY4WVpJSjNNdUliUUlTNmZGTDg1?=
 =?utf-8?B?VDFPZm1LN1l4b3UzY09ZRndVa0xoRndkblJYc0lzaFlsWW9rSFpNOU91em5n?=
 =?utf-8?B?M1N4ckJmYU1yY3FMVlV4Sk0wcG1JUEhtekdPQlhmK21uUWtVS2U2N1hUVG5a?=
 =?utf-8?B?emd1VldpQmRJOEp1QmozZ1FHYjhmbSsyemhiK1pnVkZyZSs1b3FHbVdscDBC?=
 =?utf-8?B?M2FaTmVhYURKQmF6alJKcmRGeVQrODZlVTNuNHdwZExOaTVySCtCcFhFMGt3?=
 =?utf-8?B?TmQvVGFHbWY3NHNETHA1aXh1dDZ1VzZ4YjZ2eldiMVhZNEtMTVFpWXhtbWl1?=
 =?utf-8?B?QTZKUzY2MFllS1hORjdvUjZxZHlEU1E5ZWJmRnRkWVBCOGg1VWxqTEczbEU1?=
 =?utf-8?B?VytITExJQm84OWVSTnlJeE1MdnF5Ri9PTXBTRFpDVmtSNysvVU1QbjJlVGYw?=
 =?utf-8?B?UlRsTXI3QVZsWjhTdUJQdFl1TW1aOUpkL1dMNjBEcEdWcVI5R0JvV3hrb1ls?=
 =?utf-8?Q?3J5xV75HblalhMRU3raINvc5WiNpYqN0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUdNakxUV0RiR3pOR2M1eGdRYUxhK2xoWUZsQmlaNzRGWWFUc2ZpaCtCVm80?=
 =?utf-8?B?TTY0N3BYbTg1RnFHVkc1UURLS3ZsT2paZFBqRTQxZmxWOWQwRWJyRDF1ZGdI?=
 =?utf-8?B?VUJvbVB3Unh6dkZ5a3NYYVphdHhHUW1xWGlkNGFVZnNWdStlMzFvOUYzOWpx?=
 =?utf-8?B?WS9nL0NOYklBT0gwMEQ3Vm5oZXJnMElBS0Yzc3EwQlR2dWtTcHhVZzBya0Ri?=
 =?utf-8?B?OGVMZjY0eTNISTZDOUhpakVNZEE4OERXUHE0NWYxSllINk1sdngwK20zUkpX?=
 =?utf-8?B?Qk80Q2xrMktDTmtiSUdjTXJycHhYWXYzSnlvR2UvY21zNlROdkZFV1gvL1Bm?=
 =?utf-8?B?QVlsQlJyRjA0QVlIMjJjNHFkNmFrV0xaOG82Ykg5Y0NIc2dHRFRTSU5EZjdx?=
 =?utf-8?B?SFVkWG1tL3FtRXZZK0hTK3YyZzBoeHF1bXpWYnN6aGQraG93aSszMjJ1RHh4?=
 =?utf-8?B?V21lTHFxbXJoVjh4RWVrOTYva3BicXZkbCtxQlNLOGJtbDBYNUxMR0hra0k4?=
 =?utf-8?B?cUJHd1hyRC9zWFRhbUx1MFpybmpPT0pOMmdKRWk3S2hXRm1VMVVray9uL01C?=
 =?utf-8?B?M0M5VkxuWWYzZEMxVjdaTWxzYUdxeC8zenRKeG90N2F2SXJqSkVtN2VsY1hT?=
 =?utf-8?B?TVJIbXplVHgzMkZyVUlrVWZrL2xYcml1TUkvOGJRSUYrZ1MrS2NQaE8vNS9I?=
 =?utf-8?B?d0xDbzNoT3lvM25sQmVKUEVHVGJrU3c5R25zVkxhOHVpWDV2NTRmOXEzV0pY?=
 =?utf-8?B?YVU3aDRmdFZvSlRwQjVYRUE5RCtEaDc3SEpZQlAxbkM3V0lpVnA5RHVrbDVj?=
 =?utf-8?B?VXkrV3UrbExwNXZENzU0cHVKSXA2bmdqVGRUUlRSS2RGK2dFa1lKNEp2ejdE?=
 =?utf-8?B?YThSL3dNY1B2aHNaNFZGMUpZcnNBL0U0TjBRT1VVMjd0dVRLcENRKzIvZU5L?=
 =?utf-8?B?Z0VpUUV1L2pnbm42dHZ1SDVNQlovaG8xa2kvOHJYNms1MHIvdzNhTFJpTU9K?=
 =?utf-8?B?SmZKcEx4ZmFqZitaaU5FaENKeGEycUVsSXdjQ3A1WW03NHVsTkJNMEordkNG?=
 =?utf-8?B?YThyWXZGWTN0ZlhIaytQQ0lOTnJHVzJTRmFQQUkyYk15bFBpKzdRd0lhMlNG?=
 =?utf-8?B?REdhcFA2UjFvYStsNmp3VlovVnE2ZDl4a0cwRjYyOUxyTHBDSE96UE1ncGVq?=
 =?utf-8?B?aGhBMVhGdXlCdktkaUp6ZUtaZUFHeUJiTDZ3THpqb2xtREt3WVhQRlhTN1dY?=
 =?utf-8?B?NkVMdDdWZXF5M25oeTJPbEdLeENWSXRVM1NuL1ZhVjhDMWM2ZjVFRERtd1Nm?=
 =?utf-8?B?am1ZZkVtYXNVQnBJQjlOZk1Ca2xqVG1Md1hQd0tZaDFWQWRKbElIYnVOVVVN?=
 =?utf-8?B?QzhRSC9WOWhNSkdxczF0MGFKc3lZNHRGQml4bzFCRkNTckl6S2hBV0ZNdFJD?=
 =?utf-8?B?Qnl5MWZKUzlaZkNsRmFoejc4cGc1TzArRFdQbVR3N2dBYmdSNDBFNzNmR0J6?=
 =?utf-8?B?anhObjczT0NpYmJMbHZ4U3lxb3puQTZreHlOaFFSbFpUcVBhYmVaK01Wa1E2?=
 =?utf-8?B?eGJGZ250TXBWM1UveHNqY1pnZWh2SFkxdVc4UkZ3S2piYnlETUszaHQ4MW5k?=
 =?utf-8?B?eUk5Zk1XMHorSUZqVmdvYWpSVVlLcXVBN1UrZzVEc0VSWThhMWRZTTJTL0w0?=
 =?utf-8?B?dkgxZDNrdTF0bzNpWER4dEhla2hTNUFzazhyYUlycEFQbG9TYzNtZllMcVpD?=
 =?utf-8?B?bEFWVjBTV3c5SUVEUTREWXUrY1d6MkQ3SG9CZmJ4MVBMd2pPZ3gxNVpZeVVK?=
 =?utf-8?B?UDYydHVkM1Rqaml2bUNjMUVtbktZcWVQeVhwN1NPVS9XN0kyZTdkdE9Hd0Jz?=
 =?utf-8?B?Zy9TdzlpRXJSaFFQVmZDbnBuMUtTWGh2c0l3WXhjeTg0dFNlZGNHVkZJSzVK?=
 =?utf-8?B?UXJmWVdVQ1h3bVJSbmtMeWFYU0RHanB0WkMzakthekJxdnNJWU54RmlEZWVp?=
 =?utf-8?B?ZW8rNjFURjN1RGdOTEF6Y1llcy96WEI2YjhBbEw5NkJlTGp2aThHbG04aXpT?=
 =?utf-8?B?YXROUTJQd01QdlVMNnAzcjY3SUpoU3JvMml6aTNSRGduTTFVbGwvdlBVV1l5?=
 =?utf-8?Q?HjejimfjbhDsTfpr/8Td64bPA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b41761-4ea9-446d-8cd7-08dd370a0de4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 15:17:28.0713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4762eVs5SJS+RTrgDUDSDErIKPQzyXkzUgwKH5dy7f++1oqv6Y7jNEvYtjFcRaWkpHFaIL3vbmpBi1wJoBlczQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7844

On Fri, Jan 17, 2025 at 08:05:16PM +0530, Manivannan Sadhasivam wrote:
>
>
> On January 17, 2025 4:19:02 AM GMT+05:30, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >On Thu, Jan 16, 2025 at 03:02:44PM -0500, Frank Li wrote:
> >> On Thu, Jan 16, 2025 at 01:45:58PM -0600, Bjorn Helgaas wrote:
> >> > On Thu, Jan 16, 2025 at 01:04:16PM -0500, Frank Li wrote:
> >> > > On Thu, Jan 16, 2025 at 09:32:39AM -0600, Bjorn Helgaas wrote:
> >> > > > On Tue, Nov 19, 2024 at 02:44:21PM -0500, Frank Li wrote:
> >> > > > >                    Endpoint
> >> > > > >   ┌───────────────────────────────────────────────┐
> >> > > > >   │                             pcie-ep@5f010000  │
> >> > > > >   │                             ┌────────────────┐│
> >> > > > >   │                             │   Endpoint     ││
> >> > > > >   │                             │   PCIe         ││
> >> > > > >   │                             │   Controller   ││
> >> > > > >   │           bus@5f000000      │                ││
> >> > > > >   │           ┌──────────┐      │                ││
> >> > > > >   │           │          │ Outbound Transfer     ││
> >> > > > >   │┌─────┐    │  Bus     ┼─────►│ ATU  ──────────┬┬─────►
> >> > > > >   ││     │    │  Fabric  │Bus   │                ││PCI Addr
> >> > > > >   ││ CPU ├───►│          │Addr  │                ││0xA000_0000
> >> > > > >   ││     │CPU │          │0x8000_0000            ││
> >> > > > >   │└─────┘Addr└──────────┘      │                ││
> >> > > > >   │       0x7000_0000           └────────────────┘│
> >> > > > >   └───────────────────────────────────────────────┘
> >> > > > >
> >> > > > > Use 'ranges' property in DT to configure the iATU outbound window address.
> >> > > > > The bus fabric generally passes the same address to the PCIe EP controller,
> >> > > > > but some bus fabrics map the address before sending it to the PCIe EP
> >> > > > > controller.
> >> > > > >
> >> > > > > Above diagram, CPU write data to outbound windows address 0x7000_0000, Bus
> >> > > > > fabric map it to 0x8000_0000. ATU should use bus address 0x8000_0000 as
> >> > > > > input address and map to PCI address 0xA000_0000.
> >> > > > >
> >> > > > > Previously, 'cpu_addr_fixup()' was used to handle address conversion. Now,
> >> > > > > the device tree provides this information, preferring a common method.
> >> > > > >
> >> > > > > bus@5f000000 {
> >> > > > > 	compatible = "simple-bus";
> >> > > > > 	ranges = <0x80000000 0x0 0x70000000 0x10000000>;
> >> > > > >
> >> > > > > 	pcie-ep@5f010000 {
> >> > > > > 		reg = <0x80000000 0x10000000>;
> >> > > > > 		reg-names ="addr_space";
> >> > > > > 		...
> >> > > > > 	};
> >> > > > > 	...
> >> > > > > };
> >> > > > >
> >> > > > > 'ranges' in bus@5f000000 descript how address map from CPU address to bus
> >> > > > > address.
> >> > > >
> >> > > > Shouldn't there also be a pcie-ep@5f010000 'ranges' property to
> >> > > > describe the translation for the window from bus addr 0x8000_0000 to
> >> > > > PCI addr 0xA000_0000?
> >> > >
> >> > > Needn't 'ranges' under pcie-ep@5f010000 because history reason. DWC use
> >> > > reg-names "addr_space" descript outbound windows space.
> >> >
> >> > If reg-name "addr_space" is used instead of 'ranges' for some
> >> > historical reason, we should mention that in the commit log so people
> >> > don't assume that this difference is the way it's *supposed* to be
> >> > done.
> >>
> >> How about add comments after
> >>
> >> reg-names ="addr_space"; // Indicate EP outbound windows space instead use
> >> ranges by histortical reason.
> >
> >OK, that seems reasonable.
> >
>
> Unfortunately not. Please see below.

Yes, you are right.

>
> >Where does the 0xA000_0000 PCI address come from?  I assume that's in
> >DT somewhere too?
> >
>
> No, PCI address is from host address space, hence it cannot be described in DT. That's the reason why 'addr_space' reg property is used to define outbound window region. iATU will map the host PCI address to endpoint outbound window region dynamically based on usecase (like mapping the buffer in host address space).
>
> The translation between CPU:BUS address space is a hardware property, hence using 'ranges' to describe them makes sense.
>
> But the same cannot be applied for BUS:PCI address space. Maybe the diagram had misled you thinking that PCI address is also static.

Yes, 0xA000_0000 come from PCI host side, generally allocate by dma API.
Use other channel (like registers) to told EP side how to map it.

>
> - Mani
>
> >Is there a binding in the tree that would take advantage of this patch
> >that I can look at?  arch/arm64/boot/dts/freescale/imx8-ss-hsio.dtsi
> >has bus@5f000000 that does this translation, but I don't see any
> >endpoint mode that uses it.

Not upstream yet. I plan do this after this patch merged.

Frank

> >
> >> > > All regs need call of_property_read_reg() to get untranslated address.
> >> > > ranges:  use "parent_bus_addr" in [1].
> >> >
> >> > I think we should at least use the same name ("parent_bus_addr", not
> >> > "bus_addr_base") and probably also figure out a wrapper or similar way
> >> > to use 'ranges' for future endpoint drivers and fall back to
> >> > "addr_space" for DWC.
> >>
> >> Okay for name parent_bus_addr.
> >> Do you need me to respin it? Or you change it by yourself?
> >
> >I can do that.
> >
> >Bjorn
> >
> >> > > > [1] https://lore.kernel.org/r/20241119-pci_fixup_addr-v8-1-c4bfa5193288@nxp.com
>
> மணிவண்ணன் சதாசிவம்

