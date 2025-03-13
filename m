Return-Path: <linux-pci+bounces-23662-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A23A5FA47
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 16:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 643B0421C2C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 15:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C9026AA9B;
	Thu, 13 Mar 2025 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DTKu7N7h"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36C726A1DE;
	Thu, 13 Mar 2025 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741880376; cv=fail; b=C0Lx/FHyG83cLX4qpUcPAQb7dXkb1vHh5bffW+HYpPUh8J9YDf1HONNPXA/4fiDIsKOJ8E6qODScKswQEWW7VSJvYVlU1yTY1z+m2FOq9gox18yCnXm+vIj2z0lmn7Mhrg5hvAcKq1TwKIe+6/WIRIKvfkLHSDz/5jlMXAn4u5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741880376; c=relaxed/simple;
	bh=Rq8Oa5GkIvvTxUyjodFICpLbFy7bZ36pcZaWNAcB/XU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UyHBB5V4brLaA0YrsqnFsY7k3Y/Awk/Pt5m3CCbzZJoEDJ53l0v4Y62Cnmf7HvJbSXeqPmaSfJa0BJIHQhA60J0SHxOV//LkCxu586jI79XcrqXcELY24CARhmjz3OjIWU3cyS3sGIoGHqwsATl904xFtFBiACKW+AQ3DyUZoXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DTKu7N7h; arc=fail smtp.client-ip=52.101.66.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnTlgkEIy4joqy61WKa+jBHc5AxVsCzAmeDGZYqqmYatVTXN8UJ/3mS7SGaD55JWjgjnyjUvJSMFu7xjkvw+yd67rXCDuLoYv4UznL3ebWR1p0g+PASHN1WOpE/egJbTKc3yGiCHGNQYjv9mLLmNgrpf65/IeggPkezinEXggGHzstWtFtLjCaDZGpS78FhvmYqIsqs5VnpHewZOJBrdy9jm1dncfKrKiYWbSCkxcVBMfp9mcdpSCijNnBZZWziGNmNfi2jJwBMqNoglQWj6WSC0Io9/kZJBDFeHti/tWfndFjssPZf4qBb1YEinHnkNJOjE0R3SVwikx7J28f2MSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lMdycSzHVi7TmNXrf5R3RNJ5OHuWF6EM9/6AqNYAlc=;
 b=aA0eFWSEa5A70wK4k9SFhNhzv8edEGDh1XKtW4v1Y02DO1sx1a/Nq+Nf71xRAo1K/xq9/JMhXaZrrUaRmanl/y2F3t22zkrimC1sW2/gbYGwmqRFEZlGaU6KTu6VibMCDomBmouMww8dJhAp9AN73dV7fuWtEbba0ymmPtpty7I5sQ7IW4kAKrRbOxgQSHyhpWN6u64Jlvr6WQWZvM95XKrlwGJf5SgBZyBJS3nAml47+kdbuR4doekoKP/3w4KrCh2/jc56Z4qnjoIS+C7yMv4uU0W4lk0ekomBd25CkcWc631UMyPx+HB+f3beCHsdFBAkoWxa7PKyoyGPLC82zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lMdycSzHVi7TmNXrf5R3RNJ5OHuWF6EM9/6AqNYAlc=;
 b=DTKu7N7huYZuSYcNgaD6VSpZGPjJ7x8+sPFN82vxgsJgVRQomM4pstXQsOeGHxRIAlbRtjnSU6iCS3f3mruQIGzH1W+AqDzwOhxNgT7gdFvB0wYJr1muyLtfEoRww3ataYBooFrRa9xJJnlOj5C1/kUElTeNG2mGmb99T8jUb0BWF4RSmoMtAFR2H2MB7JdwwRWBgO7ln3WTIMmDea/+iwUao6lEzezhbaO/4mk2vbC9vLaBS+FKGfCRkUm+RY4E1y9W6XTiF3/fOKylzpC62y5GHzqXKvJOkKRv73XtukQnkIEsh4OMh8lK7TeU++8z4i6ORRJP6KvHNqiX6pTo/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10316.eurprd04.prod.outlook.com (2603:10a6:10:567::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Thu, 13 Mar
 2025 15:39:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 15:39:32 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 13 Mar 2025 11:38:46 -0400
Subject: [PATCH v11 10/11] PCI: dwc: Print warning message when
 cpu_addr_fixup() exists
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-pci_fixup_addr-v11-10-01d2313502ab@nxp.com>
References: <20250313-pci_fixup_addr-v11-0-01d2313502ab@nxp.com>
In-Reply-To: <20250313-pci_fixup_addr-v11-0-01d2313502ab@nxp.com>
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
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741880335; l=1207;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Rq8Oa5GkIvvTxUyjodFICpLbFy7bZ36pcZaWNAcB/XU=;
 b=vI+hXahYOEQ3oIGUt8me3kTp+t4ilhPvnJiXMhd7UgzU8W/AKxH6zooBxrMjwtKgT7oYIjLps
 zBRzXqZX2hBASCv8bsKu+tPX2vCtxfnYeA5HLY+zseK3cB6NNeuvF6h
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR13CA0038.namprd13.prod.outlook.com
 (2603:10b6:806:22::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10316:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b0c4e2a-db3f-45bd-6499-08dd62453feb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFcySWdUSjBzdmRQejM2Nng4cGlnd21xT3lVeG5POUNud292dVlid1FPT0pV?=
 =?utf-8?B?cmRnTVRBTkdvc0x5M1FvOTc3djRHNnp3MS9ZMmFUTDN6cWhxQkdVOHZBVllC?=
 =?utf-8?B?TWV3ZTB2ZkFYT3pSSlE2V3pOWW5VVytlelVPYWtoblZjZ0lUOFpGNGwrcm1t?=
 =?utf-8?B?WUkxNEJoTXVQVWZkd0JpMzdVUVNwa2M4S2RNUWtFQkN2WHhtZm11c2pVemFN?=
 =?utf-8?B?WndxSlZ4TDU3ekg4Z3NsSVV4NkJnQWVSanh0eW0zZnBHZmc4SEZ1M1RnTmNu?=
 =?utf-8?B?WmNOSSs2TzdGc0N5bWVET1d5UVB2ck9KR0pXM0h4bVo1aGFpd29ZR2tzaWVv?=
 =?utf-8?B?ZUZLYktyZzZUSW9JdWNXSEFFWVZDQ1Y2Nm5ZeFgxQWkwZ1V1V2tENUlzV3or?=
 =?utf-8?B?WWJ0em5rckVpaGZDNjh1R2o4eFJjem5vZlZxRUE4ZGwrTHE1aHBjWHNDNWxy?=
 =?utf-8?B?VnplejlSVmhCKyswTlY1TTVxTTFWK0NSUmxrczlZai9LVkgrVWNxZ2JKNkVC?=
 =?utf-8?B?NE4wMXovdUh2RDFCTS94dkN1QjU5VkVCbkQvbmJ3b1Awd0IrMUt5TytXOThC?=
 =?utf-8?B?aVNOZVNTTjQzQUE3RGhJKzcxUzFRbFVWY0tQRXVDZk5yMUJyTnVXb2Nxem1D?=
 =?utf-8?B?M29IbTY0UG5aYnVZdms2TXVKeUVCMVBtZEZUUUhpV3hmTHBvSU1pa3NiYnd5?=
 =?utf-8?B?eWhBNmFzY1IzR3dlR3Z2Y1NPVzZDL3Bqb2Rib2ZrWjNHUVpHZy9FbVBjdWRs?=
 =?utf-8?B?b1pPUm45dlR1VDFVNzBnMFVqZjdoK0g5bk9QNVAwRkFRNU9BNVBDYzhLN2VG?=
 =?utf-8?B?MW9TemlpdUhUVUhVdG5aN0cyOG9HUDNXRlJYcXRCTGd3dytEMW81aDJQR1Vy?=
 =?utf-8?B?Z1FqV2tDdmcyWlBnbHNzVWhzNEgyOUpMOStpZUt0ZEVwV09vdlcxYWVZdERp?=
 =?utf-8?B?dzI0VGYvTnJFQUIrNEYrYkRWclpkNEtuSzJmV0tzSlN2QnpNWkUzbEU1SElo?=
 =?utf-8?B?RExrOTdxYm1zRExSUlRIQ3FKTWJDZmNUalRqSFo4OFg1L0ZFdzdNOHp4Z1hj?=
 =?utf-8?B?UE5WWklNb0xvNTRkWTYvQlhERHZmYk5sdWY2YS80KzZ3WDA3UHZjUkF4WCsw?=
 =?utf-8?B?YVdBOXhoVDlHMmFJT2d3VFUvd2FMMkllUERIazVvOFBNWUVxajBHRk0xUXRE?=
 =?utf-8?B?cEFOUkhxa2M2U3I3YjAvakJGRmhrVFNYbnoyRDNMeUtuUFZjdmh4L1ViVUpU?=
 =?utf-8?B?WU1BUGJ5VzAxRHU4ZHVYWWVTMjVnR1FxNXZkM0JIbDJHV2M0ZzNPczNGUWVG?=
 =?utf-8?B?aDZVcWkyWitia244cHJkZWpUNit2MWZYUVpYa3NLQVV4TjdwcHpuOE5SMk96?=
 =?utf-8?B?eHB5amZEMVJTOWJManNPOE1nYUhJL05YRGc4SlFYcGFzQTUvYThNeUFYYkJs?=
 =?utf-8?B?ZmRRWnNpSmlGajJVbjlyeHA1UkZDWkFJSDFjd2YyKzVzYkZnOXVNSXNPUnZl?=
 =?utf-8?B?NzdERUFzeHczbDk2ZzdNeVh4bHl1dUhHbUNBdzdFeUFXSDRLUXdla2s2aUhT?=
 =?utf-8?B?bVA5bEFQd0FLUDI5djhTTERHb2ZHNGU4WmdFY1c0aWN2RExuaDA4YzVZMDJo?=
 =?utf-8?B?SGVpRmhPdkF0UFdleVhPWXhuR0xuaFlua1VMb09aVFY1WUdzc1ZLNEJPczdW?=
 =?utf-8?B?NlVkOWQvdEkzdmlra25uMWZsNnFKOVZNYzZlc3JObVhBNzR1NWVERFNDQUYx?=
 =?utf-8?B?bzlRdkVtOCtjTUoyMTB6YXR2RVp3a20rM2VhcnRvZVFObnZxU1VmM055cDhP?=
 =?utf-8?B?K2pHcFZET2R4WnFPZGVpWW9OQ3BsbCtQZk0wZXdzR3FqUlNOczlpdmw3amVj?=
 =?utf-8?B?clZSUEtielhoZnFiS3NUSUJQU29rbWZ5ay9BZysrUEl4UGdDdzkrdGczakd5?=
 =?utf-8?B?K0RYK2dITmtIblA4OEJ6TEx2a3BMMnB3UWMyT2NKOExsQWtreHhDL2JONzJj?=
 =?utf-8?B?ZHJPWVhBcVFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVpQU29HV21sWGNsYmZ6OThtalJrczQyUVJqRkE1dWk3cmhlOFFIZHZyL2x0?=
 =?utf-8?B?VG1xYVBBdjE0eCtkQXJ1WEtJR0R4RFFRYXdXT1ZRRHNCeG9QSUcxT1RpZUlS?=
 =?utf-8?B?YVB3S0NaS0J6bllZUUw3QzV3QzBSWWs0L1R3OEhCbFlmQlI0MVF4VWE4bWJD?=
 =?utf-8?B?Y3dRc1NOVHNZbXV4anJYNTRjZFJ5WUVJNDBDbXNFTWhlQ3Z4V0VaMHdEQjRB?=
 =?utf-8?B?TEdNK3hrUFFtOTErZ2RIZ3lpTmkybUtmYXZVRnlBcHNQSHBmSGpIMWEwcjFH?=
 =?utf-8?B?MFdjV2tOdnNDd1pBMVA2bDROODBDOEl6K1RLeXg3UWlGTDF5TEoySDkzZFhl?=
 =?utf-8?B?OFREM1FYKzZEaFFJWXdOMVFwV1ZqUVAraUEwTHJTLzhhbGk2eExqVGdiektI?=
 =?utf-8?B?dHdtQnlHWk5uZlRFZGFnTFVkMERXZ0xrMnJ5dGhFSEhFbVRISThPa2YwTGFS?=
 =?utf-8?B?OEhQWnIwRDdxRFhnT2tzeGFuTFArb09FR1YwT3VGQy8rellleVhCZmdPdzV1?=
 =?utf-8?B?ajhvYWpNTXN4TFFkR2NDeEpRN2xDeUxEd3BKMFlTcWk3MDVHVFdDbHlyaEQz?=
 =?utf-8?B?RHVQQ0pZR2Faak1QTjJFdXBiRkVxSUR6blo0U2NZRVYwVWZDV0lFNUlIdEZQ?=
 =?utf-8?B?dVZ6aGZ5Y3hxTmdFN2hoV2E4OVVwRkRRMDZrdk5QZzBXMjE0ZDdqeW5sNEsw?=
 =?utf-8?B?WXdBQ2dyd3IybGg5L0lKQjM2VG5BVEgwdSswVWw0SmdSNXpDVXN0Y05YYkhO?=
 =?utf-8?B?NGZhcXNTbEhLWVdoM3pDcVliaVBTbjU4RjVid3U3azBhaU85N25yckFjd1Ny?=
 =?utf-8?B?TlR1U045T0JNQWtvTFMxeHJmVEZoNm8zdTZzV2RRWU1zZGZIb2hEV1IyR1JR?=
 =?utf-8?B?UXBZbU4vSVVxZk9pRHFsa0c4ckxNV1paWlI1QVdidDZTUi9GSkk3bUh5dlg0?=
 =?utf-8?B?WFJLMUZSVUxKeUFXbnluVlp4aHk4MitQTEtmdnErbVVFRnBhdUZGNnRFRU1K?=
 =?utf-8?B?TTNUYzBYanB5QVZRTEdjRGNqVlRUNjRHQU1hZmx2Rm56ZzVkMmlQaWZHem83?=
 =?utf-8?B?aGNqNWFiNGJZZjFnRHZoTmtTaHE0ZGFZNXFKSy9uN0l2M1BRYk1ZRElQOFNM?=
 =?utf-8?B?V3JTUVAwNS83QXE1ZEpKNkRXcmtyajFRN3dyN2l3V0VNaWtBYldkRnlvN2xO?=
 =?utf-8?B?Q3VGaUlzS3ZpaG5NYVJQQzhTUENTSmlzMklsUGF4N3MyWk41Umk4SnBEcU96?=
 =?utf-8?B?S01iN1Y1aWxuL2RGYm1GNnZMMjFya2JrY2szb3hvb3NLbURXajlkMnZ3eFRm?=
 =?utf-8?B?Mmtqa1MrZTF3YStucmtPdVlad3hIQW4xTWpUTDY4MnJJc0VVd2hQOVpoak44?=
 =?utf-8?B?T21IMmd1R05OYisydGdVeFpwSDFxN1kyNGxTY014S21zalNBa3R5NC8zUmxk?=
 =?utf-8?B?Z1AvVHRsZy9Ublg3cDdxbGM5VGJURkdiQXN4WENHUC8relU2dG8rNHFnSzJB?=
 =?utf-8?B?YldYVmFRcUVKZHhucDZnRlo3L1Q1L0tZdUkvVUF0cWFXclQydkNQNVFEeGNR?=
 =?utf-8?B?NGxyMUdGSHdNUHpPdXJtMFg1bnJaSmRXY0V2VHlHZ0FCT0RhVU1mUWIxMU82?=
 =?utf-8?B?NjNuTVE2ZytYMXJuQjVFNnBHVkwyWi9yeXpsdENMbXhTK0RwTkRmQnRzd1Z1?=
 =?utf-8?B?bCt4bFFoLzJvTXJUVWdMeDB2OFlnblZ5UmxWM2NTd2N6WnZUZW1OK3hvM2Fk?=
 =?utf-8?B?Vkxyc25pdjlPcXVvVUN1WDV1cXZrKy9raEpYSUZkZXRsV0lrVGF6QWVwNGlS?=
 =?utf-8?B?Y0lBdmErQzVEb0xGdXd6WVBXdTIxRDVyMHBqajJUazFNVTZWUTdGVDg1elBi?=
 =?utf-8?B?NXJuSktnV2d5SytveXk0MFRzY2lmS3BDVGhVSkttaTFWM2FqRDR3UVZFR3Bj?=
 =?utf-8?B?cVJXWnZGODJUeFlvRnJzMHZwVGJkd0tYa08zMlRTZEFnVW1IeVE3SzZPb0h6?=
 =?utf-8?B?VVBuS2VaQ25BVnNzaS9MZUlBRUJoTXVIQnE3ckR3QkIrdnhpTXJueEwvWXBr?=
 =?utf-8?B?c1hBaGhhNkRHQzJ5SGFJSVRCZEU0RjBIaVZ5QWVUeURBbEpxSFJySHkzOEp3?=
 =?utf-8?Q?UrnXDcJV+2aQKFuEESI74f+4X?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0c4e2a-db3f-45bd-6499-08dd62453feb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 15:39:32.2798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qMdQWhPLeSiCgBSwDGCEXxPD0yPWClvr3r0vOpbQ/WLsoOckY5XmoTluXapCLSxSdanW2ZnXvyFdYxulzTN3Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10316

If the parent 'ranges' property in DT correctly describes the address
translation, the cpu_addr_fixup() callback is not needed. Print a warning
message to inform users to correct their DTB files and prepare to remove
cpu_addr_fixup().

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v10 to v11
- change to dev_warn()
- Bjorn: this is opitional patches to encourage user fix their dtb file.

change from v9 to v10
- new patch
---
 drivers/pci/controller/dwc/pcie-designware.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 8b546131b97f6..d4dc8bf06d4c1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -1125,6 +1125,8 @@ int dw_pcie_init_parent_bus_offset(struct dw_pcie *pci, const char *reg_name,
 
 	fixup = pci->ops->cpu_addr_fixup;
 	if (fixup) {
+		dev_warn(pci->dev, "cpu_addr_fixup() usage detected. Please fix your DTB!\n");
+
 		fixup_addr = fixup(pci, cpu_phy_addr);
 		if (reg_addr == fixup_addr) {
 			dev_warn(dev, "%#010llx %s reg[%d] == %#010llx; %ps is redundant\n",

-- 
2.34.1


