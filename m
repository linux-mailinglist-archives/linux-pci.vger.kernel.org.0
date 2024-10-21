Return-Path: <linux-pci+bounces-14955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A11C59A909C
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 22:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F44EB2149C
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 20:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD9A1DE2AD;
	Mon, 21 Oct 2024 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fmDkrPlo"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939751EF0B1;
	Mon, 21 Oct 2024 20:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541280; cv=fail; b=MnaFkMoOBCpp1DSFZkLrZ9hg/bmCbsRFAiJGpv8pPH18RBmLWsPpMCdgGsQ64ODH+tYhhI1USM+Qdre2zuAA7SDfrS2gGK+VJLwFqykMZ01aaOJ69SE3LMRggOwgGmbQ/zS6f88g7nXAYNjNn7CS93W2u3xVpXX8CrLX6P3lntQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541280; c=relaxed/simple;
	bh=xOwP7kvEkIrcZ/CeDAklFFYJhRHhXZJV3LaiInaRPbU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VTE6WB5cblEpbOcxfi7J4YXTTz/2NS8iEO9TQT6vDROtu9DKabH7G/pnST50/IsLTaXDB87i5mzw5bfeiPGoV4bORTjtH1/nR/SaLwJ6hCdmTCZKMaAUPrwdcHcI4/QLkzCqsi9uvB1irRtfqEp7VZcqCHNr7oZ0ghUabmQ3Vwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fmDkrPlo; arc=fail smtp.client-ip=40.107.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htzpOipjuoybDnmdpjyJ5WqTwZP8wNA6DjctnBcwHXItQLH7RzovUrnraTqzpCbixAQKLD3zzp5OBr6o1xhG16OpvikottXZOANnSL8iRbTWaPEfUEKjoh0eWDSbNVjfe+dr/AWIevyjW/t4PkgZESAL3oUp2wFaES1QZiubjy8qiDIZ9cJqinMFuyg/XXO7mYyt0gQJ+bu3PbiyHZrjcGWsR8DaerTXNRQ1unEBTsinC8L6Gomsg2eivzuEWJFChggxTHmlJd96XgHTNtyvXKe+k6kTERequNO4FlRolQ+uUA8817hAT4bTJPyNG/ZuZnslJDW0btg6Z9nJCfHJjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EySDpmn2t3TBrfXQwsbftUWGKwgsxNSHHulyrBuHokE=;
 b=d6CgXM6wCCmmpsPluvCbk7ZdKTygSH2qRaxtA3NzsBALfG64tzqb9RLi+2mTZcW1hwOA7tw+EudOxzSk5DZlnikgM7ZD2b1W/Lunt1wHYqdQY5j5byyUqZfLd94TYnMdJ2z3YRJVXWnw5rtc11Lhs3UQpvVTQjwXZdQQeLyLc2N3gMnX7dcgtTzZp8GRHfBwDHEnZ4vxze2WhcgS4JF7ZsvXlYAdKkUW8WD+E2EItX2AfHX27GZpRHmPgGP+ndlHtbd4gWGPoAe6Y3eROR+b4B/7LPCwV9B9lWMcLR9cdWvsRCiDZ+DzSBkvjWmnIu1sJF9YMk+e3HjpwYlCUQROoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EySDpmn2t3TBrfXQwsbftUWGKwgsxNSHHulyrBuHokE=;
 b=fmDkrPlo95SDBnZ/YvSW8mFSpr/aQ0jkCbhXCU79iHz/kYptPBmg72DEsulGXFzRsLQ+2rVWzBxUn0GQXjAPdM30kVD05/OV3Ox1QI2gMoHAQnACfougoah4hN4OHgTAOXvnJQPx3Pbn/0bCU0QtJz6968Bnj9ItdZ2y1RHPJKl+ryoVc4BnRueMG2fsbyIxj5ano+P7x49V7viRmog9mr3OO7BhCXyBZDzTN2IIGbR8GsBpDA4ndJmrTrjnnv6tpVg78qtGZK6w8TQRTXeKevh76d+fDFiB2kWAl9ky1BpG/YI4xjLRrIAUHT6o7ktZkhVaqJuoa6qhOSUbtp0xOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6882.eurprd04.prod.outlook.com (2603:10a6:208:184::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 20:07:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 20:07:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 21 Oct 2024 16:07:37 -0400
Subject: [PATCH v3 2/4] dt-bindings: PCI: fsl,imx6q-pcie-ep: Add compatible
 string fsl,imx8q-pcie-ep
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-pcie_ep_range-v3-2-b13526eb0089@nxp.com>
References: <20241021-pcie_ep_range-v3-0-b13526eb0089@nxp.com>
In-Reply-To: <20241021-pcie_ep_range-v3-0-b13526eb0089@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, 
 Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729541264; l=2164;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=xOwP7kvEkIrcZ/CeDAklFFYJhRHhXZJV3LaiInaRPbU=;
 b=a1F5rE324OXu6nIVpdYsQC3wLw9VVPumrDbJJDApNRRNYYO7OkvDqaBE5k3q5BRt9UBEph2eG
 zmU6UvskXRNA2f6u51O2SwloFlCNOcO1zj6M1kDIF2g6w1gcW+yYsxI
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR13CA0071.namprd13.prod.outlook.com
 (2603:10b6:806:23::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e69eb12-e2ea-4c73-4655-08dcf20c0d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OERsdkM1NmZkcEFSdEs0M0d2WTBKc2szWmxDR0h0NUVJaGduVGxGMnlxSnRh?=
 =?utf-8?B?bHMxRnVUSjBGSTZFWGF0NUMvMjZQdWFNejRhMVo4ekFpb3RUUW9kazlvcEkz?=
 =?utf-8?B?bC94b0RydjA0RHQ2VStiaU94RjYzazUzUFBZeW9zbkl3RnNHeVYrSXRJQUNk?=
 =?utf-8?B?anJTSTh1Y2t0ZUtRaldSOXhGVmxOQnp1OWl6SGs2TUNIQVRxZGVYZ3NSV3JT?=
 =?utf-8?B?ZTdSRDVOaU5DRTE3UFVXcjI5MkZnTHVCU1BxUzhURlJsakcrbFRCZGsvbzVB?=
 =?utf-8?B?ZGg5aFdYL1ZKQ2pTbll0NGtrbjNWSHNYSnZKRXZWUSs5d1U4dzlvOFI0MTBv?=
 =?utf-8?B?dXY0UTZVN3ZZSDFlTGsyMEdhcEZYeGF4NEpDM2lyZU52dDNHaloxUnJrb3Rx?=
 =?utf-8?B?OXRDWUlsNFN5VzFrdG50bG9IMDVPY2l2WWhtdDNDT3BTRldDV2NBQVpMcTNN?=
 =?utf-8?B?eEZSaHBaOXgzQUNMUTBuNzgxNStmL0xySkJ6M0hZK0dUbWl3d1Q2K3VUQm9x?=
 =?utf-8?B?Sm1ZTFE4MTY4ZHUzZ3hBeTgwSWhzSWM5bXg4UUd5TFk3OEVBN3FjUTFKSDRm?=
 =?utf-8?B?Q09ZSk5sYzRRdmVqRzYzeHNmcFhxUGpBMHVSSEZUUnNvanlUWFhzWVNjZ0ht?=
 =?utf-8?B?NzJjTVM5aHY3dTU4SG9ReEhaUUZkWDlTUmxoejE0TTRmNWZaMWVheDMvZlps?=
 =?utf-8?B?NFl1bnRJb0NLbnpoZm9YTThodFp0N3NrSTl2MXpINlpDckNaWXRKdGt5S2U4?=
 =?utf-8?B?NzAvZ1Z1aWZOQm44RWJXbnJKTjc1UzZzQjNOTlJCTlR6RTJSaDBDWFBHSXZL?=
 =?utf-8?B?aU1aSXhaVWpMMXBGUXBlYUxkdkY5cnJzNDMya2xldGZTQVp4aFRwVXJLa2Ni?=
 =?utf-8?B?dEdXNjFiRUlWRjBzRCtQSmMvOUhiODdveFRBdkhhOHNnV0ZDTHFKMW56cHRu?=
 =?utf-8?B?dWJ5OXhOM082eEx0SjYzcmpDVmhSaXZmWWRzUnhzVjVVYUdxVVlvU2t2THlh?=
 =?utf-8?B?bU5zYjBiYjhZdkdjOCtNNXI2cThESUdhSDFvVzdPQUVKQUs4WFl2MHlkaksx?=
 =?utf-8?B?Rkk0Q0hRNDJTWThzbXNGV2RpdkVDZ0xFOXFGNFdRZmd4WTM3UExtbEJCOEg5?=
 =?utf-8?B?UnFFQjVya0o4c2VZeE15cWpEbWIreVFPcW1LaldsdFRHeHlRdnBLbnhXb0Vw?=
 =?utf-8?B?VGVGR0tMdGdmN1NNSU1BZHorV0ROMktLVlpyMHBMb1h6d3pqNnJSZjVqYVF5?=
 =?utf-8?B?anA5TmIyczB2S1MyS09XVTFxU014b1F2dHdQZFhDY1ZuMUdQVFhDbWxrT1M2?=
 =?utf-8?B?akk2LzF3dm1wMzVxaVYwamQ4SjNVdEJvTG53SHpHRWljaldRZDhIbU5rL2Jy?=
 =?utf-8?B?ajgyc2dHM2pjOFVLelJyaldDVDJBVGpOWlVUdFZiRDdGekpUL014NXoreno5?=
 =?utf-8?B?NGwzR2F5OXlpUXIxQ0NlUVJnSGhLcGFSQXQzc3l4aC8vb1BMM2Z5OXEvSlNT?=
 =?utf-8?B?WkQrakFpNm5IOVg4N2l4aXM1NUlpelpxbWFWeWhuY241V0lTWXlSdmxLTlMy?=
 =?utf-8?B?ek40SlRPZy9EV1pheGdhMjhVaWFCMHRjcXdLRldHYWwwU2dnMmlRLzNlangx?=
 =?utf-8?B?eCtCZjZyc3pOb25HTkVPbythYy9vMnZ0cWdxVTg4K01LRm9aSC9oM2xKUGsv?=
 =?utf-8?B?YzRuM1R2QUdDeVZ0RHcxQzc1UXVvUytqOU5iclJVeEZPUGdLRmtEU0I1OG5l?=
 =?utf-8?B?aXNuU3hUNWczbEhSSW8yQUVsRm9KbWp5WGpUbDFpK2hvUVlYUVEyaitqZ2tV?=
 =?utf-8?B?VVRoV0NXYmN3di9URWdaeGxNNDVxOWJoMmtZZ202MzN4RlFzSUlqZCtib2xE?=
 =?utf-8?Q?EFOHmnKtuGwbh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGxEeXRGeUowSzNaSDc4K1RPckZMdHlCQWxJSVVnQWVZMmZaK3M5OEtTc0h1?=
 =?utf-8?B?c0t0enI2Z3ZZQXpRS3Z5TW5HL3VXT1R5SXRIOS9QRm1NQnFyTnVha2JPMHFW?=
 =?utf-8?B?ZVRSUlg2eVBKaVh5cjBuZTREcWxuT20xRnVBR2pIUm1WK01RMWkycHdRL0VY?=
 =?utf-8?B?RTZzdXg5TWtSLzlQeE5CZ2tWOVA3Qld6QzZFdENPNnU4Uk9yUHM1b3BBL0JF?=
 =?utf-8?B?dW5jUE9jMUM1dnBIamIvbm9kc0pFYnBiSWM4dkxPc2pSL09FOWJkQWh6U3d6?=
 =?utf-8?B?UEJ6NlRqbzhCSEJTWkF1b2YzVHFVaENtaHlhU3JFcEtkcFU2NlpkZG9NOGpo?=
 =?utf-8?B?Z3BaRjhvU3lkRzZvbk9RaTM2SFU3ZzRQcDBOTDMxY1NqUjFlNTdvM3hqRjY2?=
 =?utf-8?B?eUVsZWFkNVZiRDA0aUxXaDNwWDlXNld3Zkw2dndBMTZudFlNSHNHOFpTNWpq?=
 =?utf-8?B?ejVqNXROVVJyTnpxbkdqZXFlQk5PbUFKUFNTSlNScHFGdW5wUVAxcXpGRXpo?=
 =?utf-8?B?aDR2YXl3KzZuaGF5NlJTZVRSVEZhNXpralBFbXVGbHlUU2RSUXRMWm5EOUFT?=
 =?utf-8?B?Q21zUTdiRzJmRjNkM1hvUzhsRTJXWGhGd3pqd0MzNkJ2cFVVbHVualA5ZXR5?=
 =?utf-8?B?ZHljWTE2VUQycFg1UksrK1JCY1JhZGNYTHZSblFNZ1Y1aEljeDgrSTd4Lyth?=
 =?utf-8?B?ejhjam1JeGNIaW10b0xhbjBRUStGQ2t6Sm5SQnF0TmdaNFdTV2ZOYlMzbDNQ?=
 =?utf-8?B?eGNYdCt2QWhNNktPNlJRUXNPeEhRNGZuTmdzcGR2M0dLNFZPTXhnSDVWT1dw?=
 =?utf-8?B?Y3FuL2RaVXg5QmppdVdkTks2VjR4dTZxekJmUWtEd2RITHpwQktpeGRuUjJP?=
 =?utf-8?B?eUpDaE4wRmVOQTFmYzdQR2tmdXFmSzlFL2I5V01Fckc2d3N6TFZueXp5VFBP?=
 =?utf-8?B?MC9qRDdDNzYyOFlmcUZ3b0ZIVjNyNi91MEVGU1NqdXhqY2g2M0VxSXVydGxp?=
 =?utf-8?B?amxwWjJkK0haZlRwK0txOFliRkxDTVpvaHFkN0NHRnNWVkR6bGZTTHU5NWN5?=
 =?utf-8?B?Vms2c0xDVnFrdTRBRE1TcERuRE9udUVVZGM4UFhZUHQrZUdTeUdrUk5PN3Jj?=
 =?utf-8?B?a05wSmlGQU9OLzl5b1dJS2JBTDFBbmZtMjQ4amN6dG9raTRoVXZmeG9hbGQx?=
 =?utf-8?B?SkJmTUhiMmhQdDlEYVBqWjB5NlhQR2haemNiYWp0TExaNUtydGRrS1V6cnJH?=
 =?utf-8?B?bWdDdnA0NS9qd1dFeVRoZ2dVMU03QVIzOGo3dWhCRGVKV2N4dTh6cGV0L0l5?=
 =?utf-8?B?R0RnRGNML1N4WCtsL2dlclZra3lLSEZHdkRRV3JiUmtYUzMxUmhlWCt6dDJK?=
 =?utf-8?B?aitHbjlDeXlWL2JkVnFtQ0ZpTktPL3FSOGsyT0Q4Y1dva0xXYmhnUWVuUnVG?=
 =?utf-8?B?RmQ3QWRxUWo5d0hZRHVMb3FEQ25iSEU2ckp1Z3lWNlcyaC9KUmRVTHRDUU1r?=
 =?utf-8?B?eVlJaXJTQ1VZeW52SXovRSt6SGJVQjUya0RZVmlLd1VqL1d3UUFmaWhubGxS?=
 =?utf-8?B?QTROK3dobnVMMlVpUy90aDhzcittZEFyY3dHS3IxYmpENG5RYlBUME9VeGti?=
 =?utf-8?B?Ylh3R1JaUzRxZmlhQW1aMEZZQ2dRSXV4a2lxM3VBanNXaTg1Z2dVZTFRRnhG?=
 =?utf-8?B?cDM1N25yOVdNM0VmNGdCR0pVR3R4dmU4NzQ1dlZTUElqdGJHMmNtWFk5VFpI?=
 =?utf-8?B?QVJtQjVKWkZMcGpicUx1NkdXdGtMQlRsajJjd3VSOHdJSlNuK3pLMEhSOGw5?=
 =?utf-8?B?akt2a0tiTWRGMWFOenNwMk1mdVI4cmVwalVwYjFnTEptMVo1OXMxUDd0WFdh?=
 =?utf-8?B?RGRvS2tvei9jOFkzcUZrS0lvTVNXMWNNOGc3TmxiZkN3a1REMWYwUmpqWTg0?=
 =?utf-8?B?cE5oaldJL1JrbzUyRGxURlgvK3RoVjRzSDRTZHYvejlBNE9PaGMzdUV2Vjdl?=
 =?utf-8?B?UE1mV2hxeVp2aHlQSmhaSDY1STlQT2l1b2FiNDJycGhSRFIvSVFBZjh2bDli?=
 =?utf-8?B?bnFUdUJoR2Y5OXg3L01RMkpzaC9ZYWhsK01VUlk3cnRNa00veG5vTVR3N0lH?=
 =?utf-8?Q?j2iaVJmDf8KzJGXiSWP1hl8By?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e69eb12-e2ea-4c73-4655-08dcf20c0d7c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 20:07:56.0226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lGWx2+F0FVMQQTDOTwh+HGlD8OemZDvY9sO363MvPEKmg60iVdqIv6WVrniKOeHw1Wl4coENR60Hc+WdvFqrlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6882

Add new compatible string fsl,imx8q-pcie-ep for iMX8Q. reg-names only needs
'dbi' and 'addr_space' because the others are located at default offset.
The clock-names align Root Complex (RC)'s naming.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml | 38 +++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
index 84ca12e8b25be..7bd00faa1f2c3 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
@@ -22,6 +22,7 @@ properties:
       - fsl,imx8mm-pcie-ep
       - fsl,imx8mq-pcie-ep
       - fsl,imx8mp-pcie-ep
+      - fsl,imx8q-pcie-ep
       - fsl,imx95-pcie-ep
 
   clocks:
@@ -74,6 +75,20 @@ allOf:
             - const: dbi2
             - const: atu
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx8q-pcie-ep
+    then:
+      properties:
+        reg:
+          maxItems: 2
+        reg-names:
+          items:
+            - const: dbi
+            - const: addr_space
+
   - if:
       properties:
         compatible:
@@ -109,7 +124,14 @@ allOf:
             - const: pcie_bus
             - const: pcie_phy
             - const: pcie_aux
-    else:
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx8mm-pcie-ep
+            - fsl,imx8mp-pcie-ep
+    then:
       properties:
         clocks:
           maxItems: 3
@@ -119,6 +141,20 @@ allOf:
             - const: pcie_bus
             - const: pcie_aux
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imxq-pcie-ep
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: dbi
+            - const: mstr
+            - const: slv
 
 unevaluatedProperties: false
 

-- 
2.34.1


