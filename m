Return-Path: <linux-pci+bounces-13578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B52B79877CB
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 18:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D6E1F27551
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 16:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DF815D5BB;
	Thu, 26 Sep 2024 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dINAPUZV"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013002.outbound.protection.outlook.com [52.101.67.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A1B15CD60;
	Thu, 26 Sep 2024 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727369276; cv=fail; b=sfLIl1/1/FTvqqJpeWZFP5a/syhXa60pLyeHOeh/qBPKV7GOBQpY0fk51/X2VVAWGSJyTB/rhrVNXa91CMYkbHTGeU1rTJTwqn0xUFla6YfjuP881/zTOVzbceEeYYJQ+LlHh9tj1F4jVjm4TBaF6WYi5v+zISDp9MlmsawT/DA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727369276; c=relaxed/simple;
	bh=9UjixEiIWjU2Rw1R//IY4okKQq5e+4Lm/9kG3kM4QOQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RHoJZ/ad0jxUxGisaHzEMyb9M60vuTdp/kIwcMvwx97fK4g69T+mjsR4wlxusk7WsNvXc9ZDPAl7xBvL29fGlRx5r1QMohIX66iMT4tusFooCXtlkw4EndYm27UMb1hxxwnCKjY8QykdA5B9T7xFMMsku2strwVKO/z8VPfmGBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dINAPUZV; arc=fail smtp.client-ip=52.101.67.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YX3YkgoLnrL4/vDW0eMDcIQ0PUvwwa6WdoTswSv7HXzGfWeWx00Wcm+yX6CZ2/hcQkZuTWPzBA1hzJYjwwk21/PI5tCPtikXadlNSMUCuoSCB9IXgTD3tfsGa8Rs0OWQdGAYGPN0LgObawCiR2o5gIn7GSBndSGYMozFgOMOzzB4cysIH6L8vymuWaSTJxmGXPZbk5UNJscp26Niud90pIgYrvx//acv2v7HANPxDWbYvf3m/5fpa6ur125Wuma6wDCv/cJrNfW0r5e59GFmYVsJg1UYyWh1UF8M+F6oDu/hLEo1Is0Pn/VThfxHVZ0Jk7VQMA5ZLrYjA5L09uYu3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUBWLRM4foMjxqfM+aG3qnhroBHRstX4Wda+VTgndrI=;
 b=H7kNMMAn6of/VkC4Gt1miqhZo/0CHRGiMay3xwT6eHBtIaWFFQsBo7hNViHMi8JeRsBCgL0Vxxh39Vttiyi6Wyaq1Y3dXb5HQfS+kZWxX4wO8Jf0Sa4heCIbCppYslpuHUYs6hWQ0b1xLFR0iGI1bze//RxKO9RICPLQETWGSGqHrPtbtYhJGpnfxRKX8I7JTM5vCI+de5PIAZWDPPuLLMuupvLHT0xyw0MWcwSdLlR8nD09zyfmGpvAO9lBVfUFcwzGaBHSDizxoNlJxB/KQMSotGjP4nSZYHjaAEWDW74JshRZ4jo5NzhLjm5pyql+Nl6FDyWlodpzFJDMd0yN2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUBWLRM4foMjxqfM+aG3qnhroBHRstX4Wda+VTgndrI=;
 b=dINAPUZVZAg8jJLagqhjnJ9iSUKoASqrgN9KbVlRBHU4iJu/Yo5XgVw3PcixttcVCcNoikBeABGsSZEx3RfGR2BWQutadizOeFCImUZntSQmHrI2uY+OC6klvK4IMozPhFHZto+kQ2llq9T8httyaTqG5lI63s1Qs222HESRanGfG/e4vjlgKrqaDdOdhV/Cwe/JsAN3kLFHivV+aidFM42Q52rLZv3AKKhvcDu71CgzXgKyd61FmA8ysMd9MubV3Y9tkKiclwbIzrAjWUD/RiQCEHF4xx7L1jQ8cPp0FZ6dJZGTTFHntyTtubVi3cc2QBV4UjDpg9AH1Y5rXveDkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7768.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 16:47:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 16:47:47 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 26 Sep 2024 12:47:14 -0400
Subject: [PATCH v2 2/3] PCI: dwc: Using cpu_untranslate_addr in of_range to
 eliminate cpu_addr_fixup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240926-pci_fixup_addr-v2-2-e4524541edf4@nxp.com>
References: <20240926-pci_fixup_addr-v2-0-e4524541edf4@nxp.com>
In-Reply-To: <20240926-pci_fixup_addr-v2-0-e4524541edf4@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727369253; l=6330;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=9UjixEiIWjU2Rw1R//IY4okKQq5e+4Lm/9kG3kM4QOQ=;
 b=q9h9KFax1bOFqYOQT9j41i+XoLB60/QqkG3o6i3uWdyqfh4+ocMXLrofzpIpfprWxamA4TAwY
 r+alQ/+SJAwDNmS4W3Njt7ovEv5qmQudOSNVvuxrDiFy0mDhTRtR05s
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0091.namprd05.prod.outlook.com
 (2603:10b6:a03:334::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b0b3112-1ef3-4863-f5c0-08dcde4af372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlJSTHpMWGdBZC9nTXZBTzBQYnlOM3JvZDQ2bmNjL3VGbVkyMVZ3N1ZmN0oz?=
 =?utf-8?B?Nng0dDhieUFGUW51Qk5CMXJseHJhSUJjL0xDanZhV3JjNko2NlJ4RHFGd0wr?=
 =?utf-8?B?WFdkcVg2QTE5VWdkeEw2UElZOWJjc09nVWhQWTQxK24yc09Vb3JYS3dyeDN0?=
 =?utf-8?B?UU5PNjgzcjdrVXpNcEw1WVE5bXB3ZHpEVFRrdWNWbjFHZ1UzSC9BR0hSTzdY?=
 =?utf-8?B?ZFZHazBXRk13bGM0MHJ2ZS9JbzBVZEtwc2E5elY2Z2I5Q1J3Z1hxT1JmdUpT?=
 =?utf-8?B?VXBCNHo1amZnUEtJdVhUTFh6b3k1aEtMVGdROE9CblNXaXFxMzNVWmN3QWJ4?=
 =?utf-8?B?YjdvN3RmbkxMYjNyeVQwdkhsU0VvVjJIUFRWRUxUVWthU080STF1NDByUDV0?=
 =?utf-8?B?b1BwUjBFM2lrV09wdmNQeGxvY05xU2ZFUUZIQ0FlM2hkMU5oOStlNHRGa3c0?=
 =?utf-8?B?MnIyNGIzUFNTTjNjYUpLODdEZndKTEhFdWNoeGlqVGdJbVFkanVJNlh0V3Ni?=
 =?utf-8?B?dEMyeUxpakVPRzZlL1Q1QVB6LytyM2UxMzB5djd5dkRFbi9Dci9SWFBCcDV1?=
 =?utf-8?B?b3pCM05IamxUMkdSVGlyMnN0MyswWDdVOVY5cWVsOFl2Nk43TDJsQU1ieFh5?=
 =?utf-8?B?bW9Lc3lZQWdpOFA1bTlrejBwekY0NVFSZXduZk9kS0twMngwQk9DRDBSUWFy?=
 =?utf-8?B?Z2pZSklaUkRQTTl6RUwwMEI4aGROUnYwZnE4OFhtMXVhUTJSbGZrQXYyb1Q1?=
 =?utf-8?B?Qys0QnFhMTVEUWw1R1RJYmlLSllzUDFjankvY0ljSDQwLzN5dVV6MmlzbzFz?=
 =?utf-8?B?Q1JudXkrazVuQ1dlS0Q5QnlINmpQR0tOR3VncFkxdUZvNXJ2MnJuZTBmQzlp?=
 =?utf-8?B?ZTR5NXJ0SHBpNTR1bWhHbkhJSkEwZnl1ek53cWF2R3JWelZaem9pSVVZTXhv?=
 =?utf-8?B?UWpLNW5oYXgxYVlBeDhqeEVOYW51TSt2elhBdjI1cGNyTjdNZWNEWkR0U2U3?=
 =?utf-8?B?c1ZVd2pwZlgvN04wWVdxNm9yVUJWdWYzcG9DdCtVUGZCNHdheHZqS1JQNkI2?=
 =?utf-8?B?V1haNVkyQUN4bVlXWk15UUEwd1Q5Mmp0V1dJZkIza1ZSZk83dEQwWTdSditG?=
 =?utf-8?B?NGhXdFNCYjNLSDZIUVFoS3pZY0Y5V3VvZWxSdWpSOThnd3NlN3lDNEkwS3BL?=
 =?utf-8?B?MUVpNGgwNFVaV3pqTE5rNmtkMnRuV1M5SnFlclBtVEFqNS9ST05EYlJRcHJV?=
 =?utf-8?B?cHpiYkRWT0t4V0dvRjNrcW00TWNlYis0TURFY3VEbmZDY1lzS2xnUzQvZ0tl?=
 =?utf-8?B?d2lxWVFmS3RIdS94MW9GelA3d05nT01pdURkSm9kamYxc3IzWG1CL3pQMGxx?=
 =?utf-8?B?a0xWdGUrSVQvTjIramtZMSttakIvc3ZLWWxhb3NxYlVKU1ZBbCtJZDNTQ0xL?=
 =?utf-8?B?RHZ4eDREWDdpL1JaRytYVXdUVW9BemJBdzgyVzl1aFQ3TkVjNk5rZXBkRHNy?=
 =?utf-8?B?bnErZVRnRUtNSDR1WUY1clIralk4QnJQYlpna2VHVGw0SnVCOTg5Z0JCUWhx?=
 =?utf-8?B?QWpBdzVxdXJnendWL0VDQkFPeExiSzJKbyttZFh5RzE3K25GcjQ1MWJkeS85?=
 =?utf-8?B?QU5YNGpxaU5KcWtKZzBEM2hhYmFYNHcyeXQ3ODVta05oNGpPdFhMRXpMK09J?=
 =?utf-8?B?NVFpZ1hxT3dNR2pQOFhyZHZhb3gwOFIwTGV2ZVEyOU5JNGxPSVR6YUw4TTUw?=
 =?utf-8?B?bWNXd3ZKeDBOVXVQbFUzZ1RnYlNXUjhkcjY1bk03eUVDdTNvdkRTcnhvV0Jw?=
 =?utf-8?B?aU44cHZlenB2aHA3VVQwZTBuRXRrT2d6Zy93RzcxdTFjZHZQcnRLZzJjU3ZP?=
 =?utf-8?B?OGFWQkRrOHNhK0pxWXk0MWJCS0Q4VW90M1BRbllEdjBxZHcrcUxwREN3MFcr?=
 =?utf-8?Q?VEzxhHl7/HM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzBvbmFDMWVuM3ByUTdMa0ZRTDFjTWEyZ0V6MncrelRvWE5CQUozME9DQ1ps?=
 =?utf-8?B?M3Q2NXFhaEk0cXdibUNLMDJCcFNQTXdWZlVDQWlkWVR2NUJxdWU3WVZ2QlVq?=
 =?utf-8?B?S2dRK0Jya3FDYS9oeVdXb2FsMnRvajVKdUdxclFvOUgxbW1oV1ZiaUdCTDl4?=
 =?utf-8?B?aFkzYm5IL0RNajQ0WHFyOWlRd2FFRzBxeGRVNGNHRk9RSFlwM2g2WnhsRHQw?=
 =?utf-8?B?Y1kzQWV3djZIejhENXAvOEZHK2hjRkd4dTNEU1FUV1NZS0pXdE5rL3lJYlEy?=
 =?utf-8?B?Z3c1b1kwbEJzWkJnQmxvbm1EV1llY0ppTUNpNHBJVStrTWtPZDcwbDRzWUU4?=
 =?utf-8?B?V2pxejI0b05kNldESjltT3RZVHlvNXVxQWs5cU80UDBjNWFMaEZkQ1N5UGcy?=
 =?utf-8?B?bHBwbEZnOXF0Skhob2tXUjNUS2tkN3VNUFhXMDVicThRS00zNlZVUnZUc2tq?=
 =?utf-8?B?YklQRDYweElpYjhSb014NGVpLzBPMlVKSzg3RXZtOFZZWWtibDN4NGViZVZD?=
 =?utf-8?B?aDZoaXg2Q0tTK2g1eTJnRFVkc3VIRjl4RWV1SGF0aDExWlBGM3hPRlVrWUY3?=
 =?utf-8?B?ejZsWTRtVUQzOW5DcHBQWjdJL2FaT3FIdnp2SFNzcmxVWkVVWXYrOEpTdm5U?=
 =?utf-8?B?UDdCU3ZVQnB4aTlpR1dQNXJVeWZDZ29RY0grcmd2bjhwSUVEeE5CcTdSZk9a?=
 =?utf-8?B?NW93a3N0TFdCVlQxUFZrNTBvdGJpa2czYkVVZGo0NFVwb1BGOWx4NVRuZ0V4?=
 =?utf-8?B?QjBTUy9WUE5lMW1qNkRra3dSUDlCNTJpMkJERlJ4K29zdkxaVnE4Y21FdmJK?=
 =?utf-8?B?ZHRUY0RlSkJ2ci8vS0pEeXN1bnJsdnJiRTh3NmtxYzZHT1RYNXJ3Tm1OUVMr?=
 =?utf-8?B?RUtrYnZZTlJQeHRIMThFVFFKeHE3Mjh5eUhsaUlDTWlZa3AyWFo0RFltQXFl?=
 =?utf-8?B?S1RSWjI0VGQzQkkydFBYdnM1WHcrejhlMTdWcThyTXA0aG83OGcybDZPUko2?=
 =?utf-8?B?VExTVUR5cUVGRVA1M1VPRkxYdm1uaDJpNlhZcEZWZ1UzZ0QvNDRhRkZ6Ykc1?=
 =?utf-8?B?Nm94amlNMVNkS214ZFF3Y0VZK09md0o5NFh3a1NhSDlXQS93cmtsSHdLNnk0?=
 =?utf-8?B?UG5JUHNnbi9XMjc3WmQxc0lXSEQraVNzcFRRS1R6NWhpczdidU9IVDVIZkt4?=
 =?utf-8?B?eFkxTkRvMzVoa2JIQkp5dUcvSnVEaTBKcTlKWi9tRVloMElBSHZLV21jOFdH?=
 =?utf-8?B?cWJqOTN0a2lRUDdjL3Q4aXF3NFE3QThtbnhrMVpDWTU1MnFKYXQxbUV4SnFV?=
 =?utf-8?B?Z1FablNpa0M3d0FhRUxTYkJFb3kxbW9OaVdTWEdDN092S2V6SXFkM0JvWWIr?=
 =?utf-8?B?YkdaTnUwWWJ2TVc5dXJtR0MrbktXeURtemRxQTlCV09hL1NENHltODBHcElW?=
 =?utf-8?B?dm9GNHdjUTJZVEQvNnBnTjlINFI0OW1RMzJ4YUFIREFzUCsrUmZOanpZN1g1?=
 =?utf-8?B?V2lZaFVhczZ0eW5XVnkya2JVdzRPR29RUU0rcGlLUnk0NFUwcTVLRlJ6emd2?=
 =?utf-8?B?clJFeFQxb1pITStQQ3N1Vks1NFVQZzFxRy8zSUo2cW5YSDRBV2xBVU4rMEoz?=
 =?utf-8?B?RDBHZHVjc3FGWGI1dGJ6K2I5Wko2cnF1bit4dTVDSlIvRHZtNnN6SDd1VjEy?=
 =?utf-8?B?a3NxbGJLYXp6QmJDL0ZJb2RJaU9iTnE5RGJkcDQzZFBmUUZXc0VsYXVKWXFI?=
 =?utf-8?B?TTNJVlA0RWNUbUp5czViM0w2enZMSlJreTZOdlN3QUxHR0FETDR3aStaVzN2?=
 =?utf-8?B?U0NBSEFKMkJ5VSs4MFlXNXlOTjBhRFlIbGlGeE94SXZVSkp0VHJtNDF5NUVs?=
 =?utf-8?B?dStVOHE3TTNvSUg0eFJHcmNydm5ENDlGZTMzUnBCWEs2VnJFL0h5UUdWOHQz?=
 =?utf-8?B?aGd6eWhNNkZCUlQwSUcwTjdqZWZqaUJUK3EvUytrRG53ZXY2emp0UUp5WmZo?=
 =?utf-8?B?MzUrczh6ejZTS1lhVFBLbk4zR0xlZU5KNlFCWWN5dlY5NnA4eTYwUlFMNnlx?=
 =?utf-8?B?OW50K3J4S005bXV2eVJNYm1aamp2Zlc5bjBPRmU4QlVPTk5YK3dQTUR0RXZP?=
 =?utf-8?Q?0Jj8GxcU8nUtrF6ZQwU4lqmLg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0b3112-1ef3-4863-f5c0-08dcde4af372
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 16:47:47.4004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FIQW7J5AEGVscQ4iCnuFX78Jk1gedLLPgkobYdQUl7asNhTZbzqZHr4GnObPZ+xHjh/zwIvqRMRsR98ZTY1xJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7768

cpu_untranslate_addr in struct of_range can indicate address information
just ahead of PCIe controller. Most system it is the same as CPU address,
but some hardware like i.MX8QXP convert it to difference address by bus
fabric. See below diagram:

                ┌─────────┐                    ┌────────────┐
     ┌─────┐    │         │ IA: 0x8ff0_0000    │            │
     │ CPU ├───►│ BUS     ├─────────────────┐  │ PCI        │
     └─────┘    │         │ IA: 0x8ff8_0000 │  │            │
      CPU Addr  │ Fabric  ├─────────────┐   │  │ Controller │
    0x7000_0000 │         │             │   │  │            │
                │         │             │   │  │            │   PCI Addr
                │         │             │   └──► CfgSpace  ─┼────────────►
                │         ├─────────┐   │      │            │    0
                │         │         │   │      │            │
                └─────────┘         │   └──────► IOSpace   ─┼────────────►
                                    │          │            │    0
                                    │          │            │
                                    └──────────► MemSpace  ─┼────────────►
                            IA: 0x8000_0000    │            │  0x8000_0000
                                               └────────────┘

bus@5f000000 {
	compatible = "simple-bus";
	#address-cells = <1>;
	#size-cells = <1>;
	ranges = <0x5f000000 0x0 0x5f000000 0x21000000>,
		 <0x80000000 0x0 0x70000000 0x10000000>;

	pcie@5f010000 {
		compatible = "fsl,imx8q-pcie";
		reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
		reg-names = "dbi", "config";
		#address-cells = <3>;
		#size-cells = <2>;
		device_type = "pci";
		bus-range = <0x00 0xff>;
		ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
			 <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
	...
	};
};

Term 'IA' here means the address just before PCIe controller. After ATU use
this IA instead CPU address, cpu_addr_fixup() can be removed.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- update because patch1 change get untranslate address method.
- add using_dtbus_info in case break back compatibility for exited platform.
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 42 +++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h      |  8 +++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 3e41865c72904..95b927efb5e46 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -418,6 +418,34 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
 	}
 }
 
+static int dw_pcie_get_untranslate_addr(struct dw_pcie *pci, resource_size_t pci_addr,
+					resource_size_t *i_addr)
+{
+	struct device *dev = pci->dev;
+	struct device_node *np = dev->of_node;
+	struct of_range_parser parser;
+	struct of_range range;
+	int ret;
+
+	if (!pci->using_dtbus_info) {
+		*i_addr = pci_addr;
+		return 0;
+	}
+
+	ret = of_range_parser_init(&parser, np);
+	if (ret)
+		return ret;
+
+	for_each_of_pci_range(&parser, &range) {
+		if (pci_addr == range.bus_addr) {
+			*i_addr = range.cpu_untranslate_addr;
+			break;
+		}
+	}
+
+	return 0;
+}
+
 int dw_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -427,6 +455,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	struct resource_entry *win;
 	struct pci_host_bridge *bridge;
 	struct resource *res;
+	int index;
 	int ret;
 
 	raw_spin_lock_init(&pp->lock);
@@ -440,6 +469,13 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		pp->cfg0_size = resource_size(res);
 		pp->cfg0_base = res->start;
 
+		if (pci->using_dtbus_info) {
+			index = of_property_match_string(np, "reg-names", "config");
+			if (index < 0)
+				return -EINVAL;
+			of_property_read_reg(np, index, &pp->cfg0_base, NULL);
+		}
+
 		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
 		if (IS_ERR(pp->va_cfg0_base))
 			return PTR_ERR(pp->va_cfg0_base);
@@ -462,6 +498,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		pp->io_base = pci_pio_to_address(win->res->start);
 	}
 
+	if (dw_pcie_get_untranslate_addr(pci, pp->io_bus_addr, &pp->io_base))
+		return -ENODEV;
+
 	/* Set default bus ops */
 	bridge->ops = &dw_pcie_ops;
 	bridge->child_ops = &dw_child_pcie_ops;
@@ -733,6 +772,9 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		atu.cpu_addr = entry->res->start;
 		atu.pci_addr = entry->res->start - entry->offset;
 
+		if (dw_pcie_get_untranslate_addr(pci, atu.pci_addr, &atu.cpu_addr))
+			return -EINVAL;
+
 		/* Adjust iATU size if MSG TLP region was allocated before */
 		if (pp->msg_res && pp->msg_res->parent == entry->res)
 			atu.size = resource_size(entry->res) -
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index c189781524fb8..e22d32b5a5f19 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -464,6 +464,14 @@ struct dw_pcie {
 	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
 	struct gpio_desc		*pe_rst;
 	bool			suspended;
+	/*
+	 * Use device tree 'ranges' property of bus node instead using
+	 * cpu_addr_fixup(). Some old platform dts 'ranges' in bus node may not
+	 * reflect real hardware's behavior. In case break these platform back
+	 * compatibility, add below flags. Set it true if dts already correct
+	 * indicate bus fabric address convert.
+	 */
+	bool			using_dtbus_info;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)

-- 
2.34.1


