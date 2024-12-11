Return-Path: <linux-pci+bounces-18180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C711B9ED7F7
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 22:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2321882F40
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 21:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ABE22967C;
	Wed, 11 Dec 2024 20:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DJNSExPv"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957B322967A;
	Wed, 11 Dec 2024 20:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950678; cv=fail; b=IkUJwsIaxyepNY9NsHssatzz5MPAj3n3OpOgMcI4+QEI8FGMm0yr9OyEoR0KuziHjplG8Y5OlxYsfnkPObD8qZnXb1VRpL8tpA/floTogsetyY4AhGUv3FNS1SIpO4Z3HEwUlVbHDhR4NUT6hGeDIhMghZeeZEzBF28fpeIpMvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950678; c=relaxed/simple;
	bh=blMI/+6GqgaeMH3OplTDWmsZjonmJ1vPWBWbWs6Lf2w=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=pzv7ZNOZ4Nuvc2QwDFMEBAn/mMwlaQD67WYhl52wkupTguOBocQkSr8Lzy7TvJ1oPG8LT0TR61cb8vAXAXcxmLIEWNeXdFMN84ovqw1puqZCxWj5gk/AfRqzv/eunQh8C1WIXJ1yQ8Umm/ZMH6FqHj1JA/tsqA3qiJYR6rwYiAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DJNSExPv; arc=fail smtp.client-ip=40.107.105.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBYVxK3+/VSqhpm3n8L/tNDgRnndM/V+boV5ryluNAHf6LcdDNKARMupXpBQ6pBJmghm40cEbvr2fQjuIyngCz9KTNtMrF5sdr6vAxbpjiZCC2eGUCoV3uyUk2eLHzNVWrWExnPDQdt+c9886DtAOFtZn5NWjbzm89TObLg0DpfXQNGI3UFM7fcVrTeTFJWKmRf2UX2arPCQdrVO4ZcCv1S466qXTZk246Lfcw8dEuK0zmG4v+NF5o2M21ymWFMm60xPV421CN32HuJO/1IgEKvGlsvBZVNhWfzIu33AmVW1/uiV8sFH61krtIEP9C13VemWAYO0Cru197LoOLh6Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmsRwVwzrtUr4aOyGSQN7OHKMq0pigWl8nBTbZNKaqw=;
 b=kAN7Ze94NfSNQfBPQU5y1uz3NCRLr0VOFpnIQEpLsEXAeZRwiWbD2e0eWtNI4ymsCrHd1PBl7dRKduBE8ENA0l2zxdJ0g5UnTHCSkX8GJsIVCgtRHGiyjN5kkup60/o4vd9fZld8aBpdQXN8+Spyy9ckLWKqngXvr50dy1j+PQ1PH4ajEiBY3M57YwZRCidKAzycfa73EL2hYS2EG/AdYN9ECBOCKNF5neN/POP34Fcx2g0/zHCUtz1ZGRNXKHXvr+xy1ts6zkXbCNfT1PLUkaY8h53NwgM7Rd4bbs3KcOzU4Zoebz+kvqJw/d1n1X1LPjUQ598AotLIAYie9MlZ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmsRwVwzrtUr4aOyGSQN7OHKMq0pigWl8nBTbZNKaqw=;
 b=DJNSExPvhh52cXobVk8rSEZIgKdKq7PmDWwyntI9EiXkjHInFOnsSmCzVe8cunrFMCibjBBv+rnwmW046E5QwXWb32vRkM/L55OcmDsJ+B7ZiMZ4SroOkJXQ/c3I1VH4LGiY4/bZ6K3wPBKBmxQ9a1mfgBfCEOo7EcvntnuUP5FSNp63LfRF2sHwlTByScnVsBBtnA3uuUR6n9WCMBt3kcO0jQDIW1jadO+dzqILHD3Ti8N1hmDGEVJSbBeFxgm+lNEM1S7LCHvGMp2NhDIoLJ1R6Cn8Py1UmaTEz4ycAal9V8tkUQrBak0TF/BiFEvlF0uUpf910lipXJ+wCWNJ2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB7139.eurprd04.prod.outlook.com (2603:10a6:208:19d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 20:57:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Wed, 11 Dec 2024
 20:57:48 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v12 0/9] PCI: EP: Add RC-to-EP doorbell with platform MSI
 controller
Date: Wed, 11 Dec 2024 15:57:28 -0500
Message-Id: <20241211-ep-msi-v12-0-33d4532fa520@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALj8WWcC/13RzW7DIAwH8FepOI8J881Oe49pB8CwcmgaJVPUq
 cq7j1QqIT3a8u8vG+5kTlNJM/k43cmUljKX61AL4G8nEs9++Em0YG0QzrgEBoymkV7mQm2Q0Qc
 hAoRE6vA4pVxuj6Sv71qfy/x7nf4ewYvYus8I9YxYBGU0JozWedAR/OdwG9/j9UK2gEV2SEBDs
 iIDBj1H5wK3R6R2BMw2pCryIJ2CyJAxc0S6Q8Ab0hVJlZ3hPInIX9YzPZINmYpQ+mi8zwF5PCL
 bI92QrUhnyNrmjBDCEbkdcSYacttNmmGIIoNCPCJgvdr3qz/IqDVRGFsl6lcGPXM7g+3ZpZDZW
 +FM6Ni6rv9Qy9sQRwIAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733950663; l=9098;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=blMI/+6GqgaeMH3OplTDWmsZjonmJ1vPWBWbWs6Lf2w=;
 b=XzL7GJw8Gp/TrnJM9pPU4YYZotl30MhgUb6ALEw9h3I1gEOIyMf9kCexj8977qqYJiUkRBjhP
 /q5DqmggnJYAzfAs3rMZHpZip8AfQfYyWCdMVrES0b3X+qzHpSNDKwd
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR01CA0037.prod.exchangelabs.com (2603:10b6:a03:94::14)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 2442bef9-4727-4a11-57e5-08dd1a2677de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmRyMU1ZRG9WUk5qbkdGTC9BaGtMV1l5djV5ejVNcWlaaEhjQ2pFUXNENnJS?=
 =?utf-8?B?Y0dqVHZ6T3R3QnhTZjh6UHJFWWhmdzR1RzYwT0ZwRjJhMmNUdnp2U2hMSDJD?=
 =?utf-8?B?Tzl1WDJ3ZlJxUlJFSElWVzhJL2RCSm50ZDFLR3lqNElLdjJMSW1GaE54Z053?=
 =?utf-8?B?TVlMbFlQRWFndm1BK09HcE5XdUtiNndzc2tNRU9KTzVHZnl1NSt4OGQ2akJ2?=
 =?utf-8?B?ZExkaXZKTytMRk9XNXBKc0dlNnFtcHNsTHBJdm1vTFB0QW00SmFGSGI0akNx?=
 =?utf-8?B?VEN5SlVoQWRvS3lCRnNsK2FOTWk0MjM1N3FQZld3MEJWSmc4RUlZdU93M3lJ?=
 =?utf-8?B?K0dXNWJ2RHdCRGRoclZNNjRxL1RKalgyYm5odjZ1UTZGWGJTRUdoSU1wQjU3?=
 =?utf-8?B?SUo5MngxYkIydWxWQ05tcWU4dzVibnBmNGkvR296dGsyOTVLTXdXWkRyc0Y2?=
 =?utf-8?B?T1psR2V3VDgzZmkrbUUrd1VzcTAyRnRabUh1L2p0NlVUeHgrL1Vhak40dlgv?=
 =?utf-8?B?ZVVPN2V1TjZzaitJajRqdGh4eDNFZXRFSlNRNFMxcWNUUkYrWmY0VlBRaXY1?=
 =?utf-8?B?UnB0dmtoemRUbUFOYlM0S3k5MTJjWDI4dmN1RFNjUEJLb2ZneEVkWjFVM0ZV?=
 =?utf-8?B?VDFZamt2dGVBcG13U1hIWERtTE9BK1RYeWRZZ1M3MXc4bUV2blhGSGJIemZG?=
 =?utf-8?B?cXRMOTBqT0tGOUhJZUxEYklSR1RoS2YwQzFMYkROSWRWeDFUYnk4TGVveUNp?=
 =?utf-8?B?d2VFUVArVStjWjNRY3ovSjBxb2lBV2tqbjhPTExybitmTWZkNkRsQkVhY1lw?=
 =?utf-8?B?d1JPUTM3eVVwNnNNTEVIUFlnNURnUEpuNThTUEhBWm93b1ZLNy9ncDE2b1Nq?=
 =?utf-8?B?dG9IcVJiWWkvbE9wRXk4S043TVFzZUhCb3k5TjlIeGFQdmVxZGY3c3RHRitv?=
 =?utf-8?B?WHoyTkR4UXNvTmdGNjhrNHRraUlGRDRJMWVPRHBjamM5S25mVDVIbXV1WkRD?=
 =?utf-8?B?azkvRi82RmFBODJocGVaNXYrMmhIRm4zaTU2MzNTV0srbXR1MnNMNGNybXU5?=
 =?utf-8?B?TzhlbktZemhBOVpPSTZpaU9mOVo2UDliV3JIY0VQaDdtdE9YMjNtNVJjZldi?=
 =?utf-8?B?NThXUjlHSWZLVmNvK09LOStzNGNod3VVTUJjcWR2OVBuWHVyTENLYmtMMHcx?=
 =?utf-8?B?VUtPUk1hQVF6VzlMbTJIQXJTZkt4U2lPT3VQNDBTS1dYZGtwKzhCaUZyQVUv?=
 =?utf-8?B?ajRXRUZ2WFJnSXFzZjBkUDNIMjBKWW4wU0cyeUE2OVNaMmQ5WTBrbTVCK0Vs?=
 =?utf-8?B?aHF4bjBCajNEMFI3L3drR2hiOFRoL1lVUitGT3BIaHJIUHgwRlAwUjBSN2hE?=
 =?utf-8?B?Z3U0M2x1aGJYU3JDbmI4czU0RHlNbFcyY3M0bnRLU0VuQm1SaHhSY0FZdVM1?=
 =?utf-8?B?SHNGZHR0RktibjkrZ21kVEd1eHN3cy80RHVsRFptWklFWDZVVTg1bDljOFFF?=
 =?utf-8?B?bnhDT0hlbTRHRnBWRWlhblV2L2V5NkZrbStCMHB4UkdJNnR5QU9nZjJQaCtr?=
 =?utf-8?B?UFY0OG93UG41YVRDR0lKc1lRUTFTRUpHbDlyRHpZL1JLT1BDTTdtbUQvNm1m?=
 =?utf-8?B?L2xSVXJMQ1NoeUpicWQ4RDJKRDhqbnVSaGU3dmtXbTZFQ3hacHZXcUp5Tytm?=
 =?utf-8?B?L21nQ2U4ZkZ5YU5vN1hLWGhFOTVLSkt5Rk9IdVg2OGp6Q3RZNG52WnlvVjVn?=
 =?utf-8?B?em1ORTVBWEREYWl2MXB2VFBEZEVZdklHalVqYTd5eWpXWWZWcFB6dTJhSzhG?=
 =?utf-8?B?VllzWHFhTzQ0YTQwU1poZWFCUG1KZStFcVMzM3FIczYyWEVlMmMzSnM4cTha?=
 =?utf-8?B?WDI4SGlVTGU2U1M1OHBJY0ZLbG1TNWxDT3hMcHVHSU1UbXJFQVZVNnl1OEZN?=
 =?utf-8?Q?JVjpuR5ubD0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWZCVm5uRGVFOVJxMFdleEs0TmN5NzYzMGNEY3doT0NhSU1wT2JadkgwK09l?=
 =?utf-8?B?UGhEZktxcjdzMzNWQkFyM0xBeldiVGhSS1IxVE4rcGExM3dXeW1wdjJJYy92?=
 =?utf-8?B?SDdDSG5MdTdvU1pudG5CNmpWUVo5QUZ6ckFLVFlwekZnUU1rU1dlSHZ1eGl3?=
 =?utf-8?B?cUxybGhnajQyaFdyNnRzS3pHWDZkN0NYSHFKY05KQytTanczTzdTYzNQdklu?=
 =?utf-8?B?dmZNM3VKbmFPUDlMVzV0QU9FeWZKVnFkYStxS2xzSng5K2o4LzVlcUlmaVVv?=
 =?utf-8?B?NGFOcDM5bW5WenZ2N3lIMDRSVEtWcjVCbkxXN1VPb21NQnQ0V2Y4OTJVUEw0?=
 =?utf-8?B?OUg1OVlpSHpuRFk2UlloSFZSRXJHZUxRMDhKa2NWOUZ2M1JQVFMyWGQ3Qlp5?=
 =?utf-8?B?aHp0VUNVSXcrWTZLREc1citUY1dsdXl1NXMxbHh0L2ZRYkk4RGZhVThDTUdL?=
 =?utf-8?B?K0d0R3YwVTlXcCsrOFBTYlpKTTBILzkrRU8rdHk0clFoaHhRNnk0UURRRHNY?=
 =?utf-8?B?NlMwNU15TmVFdElJY1RidnVZRG93KzJzaHRkL1hCNnNDOVoyQll1eWtJTFla?=
 =?utf-8?B?dGsya1JlU1VXQkdxdG1xUVRlaU5lWkRyc1VaVm0rSmdNMHFoR1J1OXI5ak5o?=
 =?utf-8?B?VHM4ZmVxUWlYeU1lYjRjKzB5R0tzdGxjb2hreTIxSU1rVXZUMW1mZ3d3aVdk?=
 =?utf-8?B?ZWsraWErNUFJUS80Tjc1VXRvcC9oT0Zoc08zRUl0UERJUWREcktyMzNEaHBx?=
 =?utf-8?B?MTUzWStNS0N3TkUwbHhESDBGRFpCV21nWUM2OFQ3RkhCajUzQXBCYVl6ZDNl?=
 =?utf-8?B?N3dOZnB6Z3c3Ykp4clFPOStpaHpzdm85VURNcEE2TkIvOEd1ZGxwZG1qSWFv?=
 =?utf-8?B?alVyTk5ESDZPZ3dJTGgvY3RpNlJ1Y0xlZE0zZ3g4SWhxMFdwaWloNVFqR2l3?=
 =?utf-8?B?dnFZbWJXTVFiclV3VlZDVmpCVk9GNkdkbzdybGVGTnBweWJjaFBEbU02RnFS?=
 =?utf-8?B?L2VVSUlXejZNSEVlQmRISHVOVTZOOC9WUS9jUUo5d3dlSkZRNlNLMDI4V29J?=
 =?utf-8?B?aGlKM1VZVHZwYmt1b1VBbG9PcFBiT013aDVCTzFDU1NpRWMvT2F6S0oyVlVv?=
 =?utf-8?B?V0treXRYN2gvVTUwUUtNWk1nRm9kT1ROODlCdFF2a3RRNjRjaWhUa1BYbnZE?=
 =?utf-8?B?UjZBaEpwd2pkeERrUElqRGFBbkFuQytLTTNRR2tpN3JwVm5SRmVqVWlELzBK?=
 =?utf-8?B?OWZaWnZsVDBVQzhTeUYzZmJGN21QR013alVaYmVWMW9uSDlNQUE0bDVtb1Zk?=
 =?utf-8?B?OWRLOVRiek4xOEtpNmtleWZXWEJZdmVjVzlFd1hPZmwvQUNVWU9ScjZyTFBD?=
 =?utf-8?B?Y2pmT0pVOVgxUGZaNFdMRHAwZUJNT1NDdUdWUjBONHRwT0FHZ0pRVE84ek8x?=
 =?utf-8?B?dVR4cTJZcnZ6ZDNMckhXUTRjWWZCenRlSnQwb2Y4c0ZBYWlRVVVvd1NURmJp?=
 =?utf-8?B?SEQzZUEzVmJnTGdDTDlYZFNQN0ZtdGFrcnpoR1B2YWROMlA2MVBiTTl3amRJ?=
 =?utf-8?B?c1hGOUoxR3JxY0o4WEdyVkZsbHRPditOcEoyaGhPQ3l2YU53OXo0TXVrUytM?=
 =?utf-8?B?aWcxeWgyY0FiRHpGbGYzQm9xbkFaTkwyeWdGQ0MxcTBkbDFNTGRnRkpaRFlj?=
 =?utf-8?B?Vksvamo3NmpoOTVNV09PbnVFbEVDc1BSaFZFNUtsN2VjV1RHZjdxSVNJZmRu?=
 =?utf-8?B?ZzNKQU1MREk3Nm54bDI4Y3NBWWQvOWU4cG1VbXFVQmJ5aWtjWFVyMk1WekFh?=
 =?utf-8?B?Qkx3N0E1SkxTdzk1MkNLOHVoOVAxTzF2R2VkSnNwNEhOZWZWcGw1VDIxYUlF?=
 =?utf-8?B?am5zZzVRRVZ1RG1nejlqMVpjd01hSVZxaE5Qcm5kNnpBSGp1NFNOeklUSUsr?=
 =?utf-8?B?SnVLWDMyOWVVVTBEeHJremxRUmFjL3JTU3Q4UkJIMWZxZGRidVpwdm5Eally?=
 =?utf-8?B?dXdzekVna01LWjdRTUNNKzVtbmMzSGd1UkVGRWl1QXdGbmhFTUhDam8wcWtx?=
 =?utf-8?B?VXoyQjNhNHlkYVErSEx5dXRsaDBJNVhldUlnZjVvb2lMdVpFdGNmb3ZXN0w4?=
 =?utf-8?Q?n7JUjTWlDhfL+M+TGGSufbcoL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2442bef9-4727-4a11-57e5-08dd1a2677de
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 20:57:47.9611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNjBrd3aypxMh5qxQkD5R6Ha6CxbX8co3m20fji7XxWT93m8On/NvIpAqascV3qzYswgVdMj8iNXwCeIrEOjqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7139

┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
│            │   │                                   │   │                │
│            │   │ PCI Endpoint                      │   │ PCI Host       │
│            │   │                                   │   │                │
│            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
│            │   │                                   │   │                │
│ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
│ Controller │   │   update doorbell register address│   │                │
│            │   │   for BAR                         │   │                │
│            │   │                                   │   │ 3. Write BAR<n>│
│            │◄──┼───────────────────────────────────┼───┤                │
│            │   │                                   │   │                │
│            ├──►│ 4.Irq Handle                      │   │                │
│            │   │                                   │   │                │
│            │   │                                   │   │                │
└────────────┘   └───────────────────────────────────┘   └────────────────┘

This patches based on old https://lore.kernel.org/imx/20221124055036.1630573-1-Frank.Li@nxp.com/

Original patch only target to vntb driver. But actually it is common
method.

This patches add new API to pci-epf-core, so any EP driver can use it.

Previous v2 discussion here.
https://lore.kernel.org/imx/20230911220920.1817033-1-Frank.Li@nxp.com/

Changes in v12:
- Change to use IRQ_DOMAIN_MSI_IMMUTABLE and add help function
irq_domain_msi_is_immuatble().
- split PCI: endpoint: pci-ep-msi: Add MSI address/data pair mutable check to 3 patches
- Link to v11: https://lore.kernel.org/r/20241209-ep-msi-v11-0-7434fa8397bd@nxp.com

Changes in v11:
- Change to use MSI_FLAG_MSG_IMMUTABLE
- Link to v10: https://lore.kernel.org/r/20241204-ep-msi-v10-0-87c378dbcd6d@nxp.com

Changes in v10:

Thomas Gleixner:
	There are big change in pci-ep-msi.c. I am sure if go on the
corrent path. The key improvement is remove only 1 function devices's
limitation.

	I use new patch for imutable check, which relative additional
feature compared to base enablement patch.

- Remove patch Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
- Add new patch irqchip/gic-v3-its: Avoid overwriting msi_prepare callback if provided by msi_domain_info
- Remove only support 1 endpoint function limiation.
- Create one MSI domain for each endpoint function devices.
- Use "msi-map" in pci ep controler node, instead of of msi-parent. first
argument is
	(func_no << 8 | vfunc_no)

- Link to v9: https://lore.kernel.org/r/20241203-ep-msi-v9-0-a60dbc3f15dd@nxp.com

Changes in v9
- Add patch platform-msi: Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
- Remove patch PCI: endpoint: Add pci_epc_get_fn() API for customizable filtering
- Remove API pci_epf_align_inbound_addr_lo_hi
- Move doorbell_alloc in to doorbell_enable function.
- Link to v8: https://lore.kernel.org/r/20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com

Changes in v8:
- update helper function name to pci_epf_align_inbound_addr()
- Link to v7: https://lore.kernel.org/r/20241114-ep-msi-v7-0-d4ac7aafbd2c@nxp.com

Changes in v7:
- Add helper function pci_epf_align_addr();
- Link to v6: https://lore.kernel.org/r/20241112-ep-msi-v6-0-45f9722e3c2a@nxp.com

Changes in v6:
- change doorbell_addr to doorbell_offset
- use round_down()
- add Niklas's test by tag
- rebase to pci/endpoint
- Link to v5: https://lore.kernel.org/r/20241108-ep-msi-v5-0-a14951c0d007@nxp.com

Changes in v5:
- Move request_irq to epf test function driver for more flexiable user case
- Add fixed size bar handler
- Some minor improvememtn to see each patches's changelog.
- Link to v4: https://lore.kernel.org/r/20241031-ep-msi-v4-0-717da2d99b28@nxp.com

Changes in v4:
- Remove patch genirq/msi: Add cleanup guard define for msi_lock_descs()/msi_unlock_descs()
- Use new method to avoid compatible problem.
  Add new command DOORBELL_ENABLE and DOORBELL_DISABLE.
  pcitest -B send DOORBELL_ENABLE first, EP test function driver try to
remap one of BAR_N (except test register bar) to ITS MSI MMIO space. Old
driver don't support new command, so failure return, not side effect.
  After test, DOORBELL_DISABLE command send out to recover original map, so
pcitest bar test can pass as normal.
- Other detail change see each patches's change log
- Link to v3: https://lore.kernel.org/r/20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com

Change from v2 to v3
- Fixed manivannan's comments
- Move common part to pci-ep-msi.c and pci-ep-msi.h
- rebase to 6.12-rc1
- use RevID to distingiush old version

mkdir /sys/kernel/config/pci_ep/functions/pci_epf_test/func1
echo 16 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/msi_interrupts
echo 0x080c > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/deviceid
echo 0x1957 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/vendorid
echo 1 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/revid
^^^^^^ to enable platform msi support.
ln -s /sys/kernel/config/pci_ep/functions/pci_epf_test/func1 /sys/kernel/config/pci_ep/controllers/4c380000.pcie-ep

- use new device ID, which identify support doorbell to avoid broken
compatility.

    Enable doorbell support only for PCI_DEVICE_ID_IMX8_DB, while other devices
    keep the same behavior as before.

           EP side             RC with old driver      RC with new driver
    PCI_DEVICE_ID_IMX8_DB          no probe              doorbell enabled
    Other device ID             doorbell disabled*       doorbell disabled*

    * Behavior remains unchanged.

Change from v1 to v2
- Add missed patch for endpont/pci-epf-test.c
- Move alloc and free to epc driver from epf.
- Provide general help function for EPC driver to alloc platform msi irq.
- Fixed manivannan's comments.

To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof Wilczyński <kw@linux.com>
To: Kishon Vijay Abraham I <kishon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: Niklas Cassel <cassel@kernel.org>
Cc: dlemoal@kernel.org
Cc: jdmason@kudzu.us
To: Rafael J. Wysocki <rafael@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
To: Anup Patel <apatel@ventanamicro.com>
To: Kishon Vijay Abraham I <kishon@kernel.org>
To: Marc Zyngier <maz@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (9):
      irqchip/gic-v3-its: Avoid overwriting msi_prepare callback if provided by msi_domain_info
      PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller
      irqdomain: Add IRQ_DOMAIN_FLAG_MSI_IMMUTABLE and irq_domain_is_msi_immutable()
      irqchip/gic-v3-its: Set IRQ_DOMAIN_FLAG_MSI_IMMUTABLE for ITS
      PCI: endpoint: pci-ep-msi: Add check for MSI address/data pair immutability
      PCI: endpoint: Add pci_epf_align_inbound_addr() helper for address alignment
      PCI: endpoint: pci-epf-test: Add doorbell test support
      misc: pci_endpoint_test: Add doorbell test case
      tools: PCI: Add 'B' option for test doorbell

 drivers/irqchip/irq-gic-v3-its-msi-parent.c   |   3 +-
 drivers/irqchip/irq-gic-v3-its.c              |   2 +-
 drivers/misc/pci_endpoint_test.c              |  80 ++++++++++++++
 drivers/pci/endpoint/Makefile                 |   2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c | 132 ++++++++++++++++++++++
 drivers/pci/endpoint/pci-ep-msi.c             | 153 ++++++++++++++++++++++++++
 drivers/pci/endpoint/pci-epf-core.c           |  44 ++++++++
 include/linux/irqdomain.h                     |   8 ++
 include/linux/pci-ep-msi.h                    |  15 +++
 include/linux/pci-epf.h                       |  19 ++++
 include/uapi/linux/pcitest.h                  |   1 +
 tools/pci/pcitest.c                           |  16 ++-
 12 files changed, 471 insertions(+), 4 deletions(-)
---
base-commit: 102a25797c66c8f4cf7fafe0b0de95cc7126b3fa
change-id: 20241010-ep-msi-8b4cab33b1be

Best regards,
---
Frank Li <Frank.Li@nxp.com>


