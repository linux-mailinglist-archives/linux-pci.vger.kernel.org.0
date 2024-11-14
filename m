Return-Path: <linux-pci+bounces-16778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AA69C9038
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 17:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3627B2C6E7
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 16:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A18B188713;
	Thu, 14 Nov 2024 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iQuoyQIR"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348DB1C683;
	Thu, 14 Nov 2024 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731602999; cv=fail; b=aaBGSyOqIhy4wJMVot1TGO1d4vsCtiKvwKPRCduBdks1ym2/Md4Yv4aoHAZc/B1iOv1XnEaExbjSdLQ/2o3zMT2THMZ11e77gK3kU9X9fT31Qc4hE1zItzHjKWH0/OBxpFZjNG2f3da5KAf5Z5Gva+OY7yNEbuQB7Z70qh/brZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731602999; c=relaxed/simple;
	bh=bR8pvo7KPeiKiE8etNnOs1mZ1ZZL0bKtCOreNVfqbKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DPz812R49JdqssVJ8KM+OmM0dcET4gZpwKFj32qsuGRo4akI7tQU8fIs7U9XUJSIaeKO44a9Y58WN9R5P44qvYjjief/22cyunm53VFksDunDfna5Mp25BHLfHgvwtIKHn39Sd0FKZ8w797sWo4Ddn/25ZLBKuf/iYVwOYtmpNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iQuoyQIR; arc=fail smtp.client-ip=40.107.22.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oggrRPKx8HJtXj3pH86RJZX28kjFs+8Jzl3+bbd5/5A1C8e53Vsc8BYPgly9NpbCLZ9ftKmhfpWgduxijoTUMn7Fihxu51YhfSLZjX3F+i7eDxUMHStqUsGbr/IG7gx3ohEfGoqbe/NpV7DHMjGb8AJ/wW7Apv95DWFZuOqiwGvKy88e4QGixUs9ik8Uq785wq9pwj7t/f3RCn0JfZSiqSIMWE9F/15kuVfSr4o6h+w5ETzMvN18D4Cpi+6PzpBqcd8Gf0p7DUjNTqyMldlOB1T8/19Zeo5W/GT8uhgh8q77ctW2Hcodmmw2u+r1mTIpg0kWz8a9O32ZlY2otaS3CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zd6BMCAZbazfElmvvQpeij7TMjhOrrFz9RTN5BfzEd0=;
 b=vVr+2YygH8WqLWyPkDG3IGHi+PuPfrfQn4uPbeHszEwTS6Meq/8JnRaiI/116aobN25pMTzg6dc86ybOiHL5XGwRD3Tnry9NKZrj7B74k1iTOpSl60vahdMaKbEeq6eItkY+MzM2o7xuOlTzjG/TlsOlMyA/E36fShb2H9Lsh4Fnuu6E04wV22ZN6EIYsfw2K04yew8vn2eh/eBfgfw8lE09Rc77oCovVCvBxns6QwGaS0HbBdNhsSG4iAL22f1zO2e4hlqqM4AqQ0Joszl4T/u2D49Esfu6tutl33qavREXBNFiAAgzMMSHHB1XeXzY7WwuH4WCDwglhXnfId2V0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zd6BMCAZbazfElmvvQpeij7TMjhOrrFz9RTN5BfzEd0=;
 b=iQuoyQIRdmbm/VV3N5aPhPWfTGAoL5Kw6YvwiyIuZboErogddyu6xn900ibrXNyOpZeVN1Xu2eQ68E2UuQ8LEoaxKBb/ArREf3ImIbHXn5dgQXStIa6KNJ/eED+lWx+17+7MYQK801IC73UPImW+sDxUgUCAt7vF8FMUcOayMxJbHVj+3LEQmz771DM4c/BJxcl4aVd4biB7bhwM1NLJvAtrZ5heiT8P/z8ZcIe8iCK+VWtA3sWOtLvZ8FN7XtgrZxVPRuX2m3PP/7fBBKIWTaSk6/k4h7AZY2akQ39WRcXawOCLENd+2Uq/Ed3D32514SOFTPCgtclDRsgy5PKntQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB10617.eurprd04.prod.outlook.com (2603:10a6:800:27f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 16:49:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 16:49:53 +0000
Date: Thu, 14 Nov 2024 11:49:44 -0500
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
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
	Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v7 0/7] PCI: dwc: opitimaze RC Host/EP pci_fixup_addr()
Message-ID: <ZzYqKNAWRH6EMiny@lizhi-Precision-Tower-5810>
References: <20241029-pci_fixup_addr-v7-0-8310dc24fb7c@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241029-pci_fixup_addr-v7-0-8310dc24fb7c@nxp.com>
X-ClientProxiedBy: BY3PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB10617:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f56c35f-a1d0-44c1-b0f7-08dd04cc5cd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MURNM1ZOVjUxU0NPODdldUs4amM1OHpCK1FaN3NrN09KbDZMbm90cUpKNjdw?=
 =?utf-8?B?VTBIY3M0VVRxMVZiUHV0RTFYZW9HR0tRMkhRVWdMWWYwUjJDRmluUmJsS3ZR?=
 =?utf-8?B?d2VKRjlBcmt3S0NsbmpFWTc4U281QVJlWXI1M2xUQUwrWHQ1bnlXTUw1OVA1?=
 =?utf-8?B?RFZQWWN1VXljUVZHSjFCZ2N5Ym9pdEV4U2MzMWtuRWo5T1NkN3lUcXRVN2FH?=
 =?utf-8?B?Mms4R3Y3QjJhd3lvam0rRTh2aHhZOUUxSUo0Vk9zSjRTM1R1VmVkc1U0WGFk?=
 =?utf-8?B?Z1RlMzNUeGxOZFFmdENJL3loM1hIcUxUYUxtNHZSNXAyS2dnNWZwdTFnTmgy?=
 =?utf-8?B?K2hFcHlvVDl0Nlo0RjA0YnBOcUg1SjJRWHk5YzdFcXhRYWdadHNlTTdUNTFE?=
 =?utf-8?B?TlJDK1lyT3k5UjV0blFqUGt0cVNKb1o1Q2g5b1BERjlldjNYWUJZTnB2ckVk?=
 =?utf-8?B?SUUra25Sb3VlWWExbHI2UXQ3eVhuRjd0VXVDWW5PSEdvZGUwbVpQSkhMMTVV?=
 =?utf-8?B?bkZPWGNGdHp6d0NjUjM0Zys1UFZXMmQrZkl2YmdBNHlmTkFmUDRzQUNsNkty?=
 =?utf-8?B?Y1FrdE95OW8zaDlyQ0dVVmZuS1FIYWx6bVlhRTZiakdjOEtUSHJlbzZUbFVD?=
 =?utf-8?B?UTA5RncrWVZlQm0zUUYvS3Yva2ZRNXZRYXBVTFJKb081eGkvR3UvYXdKalJQ?=
 =?utf-8?B?aFVWV2ZCcXE3SlZTaEVQQlR1NkNHaE1IUzd1RngzUzkvR2pLd0t3azVpV0tO?=
 =?utf-8?B?dGFKZndRaVdCa1JoV29pd2pSQUpMeGJMS0xBajJwQzA1QS8wd0JJRWV0QmQx?=
 =?utf-8?B?QTNqRUtCc0l1N3pwakhXOEI1c1VNYWVPUGxieHZGc1M0ZzVCazRlWE4vMmpk?=
 =?utf-8?B?VG9FaXhZZzVUZ3FDeUdRaUQ1Z0pVcVl1YmswWG1pTC9oblkwaGFIcFJ3akIx?=
 =?utf-8?B?Uk5ZdC9BSVBKQ00zSUtWZ0lub2lpMGVZZWJneHV1L3JDd3BXbGZaZzF3QWlS?=
 =?utf-8?B?MlJqNHdoWURRUmh2MVVKaHRNbzV0ZVF5VnNlQzJHVHhEelZ5OFBDQmJlVVIr?=
 =?utf-8?B?L3A3ekE5SVYvRE9kaGU2ZEtkb01RbnJmd2IzYlo1M0NRWFNINUZZUzJVSGY1?=
 =?utf-8?B?dVdNSVZXU2RPV3hhN2VTdVRzZnlmTCs0WGViTDRaU1hOQnFyTHdZK3VVWGxS?=
 =?utf-8?B?NlM5UUtTNEJmZ3Z4NE1rVlJIR2V6c2tub3V0R1gvcXVVbFIvZDgrSDBVL2FM?=
 =?utf-8?B?VTVNRlV6aVRmaGYvTUV0OHZPS3FSWnFEWEdIbnVUUlZJNlE2UjFLckhGaTFs?=
 =?utf-8?B?SEdNYlRtOFM5OWZtTUZNZW5UQ3ZQVzN1eWY3emhzUW9VVVJKcmxVZnprbWZV?=
 =?utf-8?B?NnViaitIc2RRQ05BNmQ0RjczUWZlY011RlZwQWdaMU96b1NBTG1qbFFBQ2xu?=
 =?utf-8?B?Slh3V0lMeE5qQjVQa1RWTzNBZ0RpNDNSMlJxbzlRaVM0bWdMNVNJbEp6MGRt?=
 =?utf-8?B?RUZPTjFmM2hyM0VxbElXV3hvSzNYVytTWVdlSFgwVktaY244d1JXK0FqWnkv?=
 =?utf-8?B?cVVpZHBlZHBLd200TTczSzhxSUxWbzg3V3lldlc5Z0JYVFR0ZHYySmhUY0dI?=
 =?utf-8?B?K2VXOWo2Y3FwWVp0OVQwOCtuem92cDJiQWRDVTZzaHc1bTdHSzVEK0RMWEpx?=
 =?utf-8?B?eW9UeU5Pcm9UQmFUbHltZlR5aUZrM0d6ZUFsWUlia0liZzdBUk93Z3FubkJ1?=
 =?utf-8?B?Mmp3aVBXNU9YamlNL3RXd1BUUW1tSUp1YzE0cGhrbU5uVnUvNmdqTzMzTFRS?=
 =?utf-8?B?MXN4bHRXT2txT1dJQ0MwZEk5dFU5aHN2c2JNRkFOYzFrQ1lRVUxUNnBHY1VP?=
 =?utf-8?Q?xSYBOFL/oXr5r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d01tV1kxd2gwWm9KK2dzbVJtZ2JFOFZGSVkvYlVOMmtmTjMzaytQRWZpTlYv?=
 =?utf-8?B?WEoxaml0SHNQbmhTZFByT0xUMlFWQU90bDZDQitsOFliSW9lcU4yaGJ4Ty9R?=
 =?utf-8?B?ejV1MENKZVRhUUZlMSt2QmI5YnhJL2xvbnhkK01PNGE1T3craFBzd2NXS2Mr?=
 =?utf-8?B?SUNaS3h5M21UVWU4YVpvODVMSGZZSndHb0YwbDF3UEJnUkkxcyt1VG9RTVgw?=
 =?utf-8?B?OG5QWXNKS3FncDMyYVVZZStnUG5abHVsTVFyalc4UnY1bVJtNTBJb1cvSW9j?=
 =?utf-8?B?VUxnNzJkNWYvaHpsUkFIemxseS9kTnVsbFd1Tm9GNUpyU1pqcFFtR2E0dmhK?=
 =?utf-8?B?TXBCV2hpMys2cmpmOVJVMklnYXhhYnpNVUNycGhSbzFZemZkUlBCK3FURzU5?=
 =?utf-8?B?VWhLQUpUbHF0N2lVdElEdmRqQko2SnFlU2JUejRsMnZDUFZOd092akNnMjAy?=
 =?utf-8?B?ZVU3MG02ZGlEbGo3V1V1ZHI5WGtDNkh4UHJkT0YrbjgxK2JVTVZadEFlTUNU?=
 =?utf-8?B?dURxWGcrWXdsSm9oQkRkNnJob1BjaWYvZitOeDhJclh3YjlyemVyMGVKWmFX?=
 =?utf-8?B?ZzZocXd2S2Vya2QvaVpXM0FLQmFVR1FJT2txWFEvdXlQWElGMVE4NjZLSXhD?=
 =?utf-8?B?RlViLzFWUW0xRkRaWG1sYVFwc1hZekxxZjBHN1pRVDBVR2h5bHpXL3Vaa2Q1?=
 =?utf-8?B?MzFqc1VGRGhiTCtEVjc3a25iekR3cnpoQVZha2RzYTdQVWQ0MWtvU3JIZzBS?=
 =?utf-8?B?SU5IVXJIOFNTT1lqbTlYTkFHOHBjSU0vUU10NU56d2RoSWVnSmUwVWcxQUZs?=
 =?utf-8?B?ZjA1QzBTQ0FHaFNzTjh5NGs2VllIK0Z5SHdJdzFZdng1c2dyK1ZqQ0Y4MHpR?=
 =?utf-8?B?MVJReWxZaERnZnFDMTBZcnYvYzhTMmNsYzNRRUp1dVFGMit2OXVhZnIxMEh3?=
 =?utf-8?B?T29qSlduSTJCZkFpUkRkK1BNTWROWXg5M0Y5KzNGRkF2MVJJSTZ4VDRuQnVw?=
 =?utf-8?B?QmFNWkYxMm5wVE50SEs0WCtDcndaU2RZL0tCRitsZjdtZlJheUkvQmpsUm03?=
 =?utf-8?B?SWtzM0w3Q1Z3YWRoK3hDaFltdm1xdUpBU2RFeUxhMmtmc2k5VXRKaSs2VTEy?=
 =?utf-8?B?TnRhU2s1a3NZVnFOOVYrSWZJSzhpMC80WFE2RGJtRFhPamRjY0cxemRJREFk?=
 =?utf-8?B?YndtV1JhMURyckVlK2hnTDRvUFgvYlVlZVJ2MGM4cjE3dWVFQWErZGcrOFdv?=
 =?utf-8?B?RWRTTkgrNjBST1lCU21JUVl2NEorUklrdkpsSEJ4SkVBNjcySHY2SHBLeGQz?=
 =?utf-8?B?dDZWN3RHZ3lUZHFWcHFraFhNeU9tdmNiZHp6RFUwcGc1WkpIVHlkRnhTVklB?=
 =?utf-8?B?bGdQdHJGelc5WUM5cHorWFMrNSs3dzNGOFJnRy9MYytsenp6SG1UOG4yOWVV?=
 =?utf-8?B?TFIrUnpQQnlnTE5WZVN5aGVvVmpEcldpT3ZiTGVUU3hOWFNNUWdrS1FVTUpa?=
 =?utf-8?B?U2s5MjA2aGUycmxyeFM3N3cvUmhpWVZSc0VnMVRNNDJ0Z1NyNi80eG5adDBF?=
 =?utf-8?B?ZnF1VmhHMXAvTzRmQ2tqM1RTTEhmRWg0OXZuQUFvRW40dCt0T2xLQWYwZFNq?=
 =?utf-8?B?WjhERVg2NGVEZnFHdWhRa0JSc21ubDVIbzEzQ1pqYUw4UXd6dlF0ekNBb3FZ?=
 =?utf-8?B?UUVoNE1aUFpKaTJuOEt6TnVCb2xpb0IxcFM2MTU2K2kwNXJEdTJTa0VIaXlC?=
 =?utf-8?B?THQvMWg4UVpxbnErb3dCT2c3SlovU0RtNXoxc3hEbFJNMktYUVhBYXFBNk1C?=
 =?utf-8?B?NFlxUC9aTEpYN1ZGT0xUMXF6VThzQUdYSHhpaVJzb0ZqMWVwdUtyQ09NTnhj?=
 =?utf-8?B?Zis5ZVg0ZHowcU5kdndOYVY0T0tqN2MxNnc1emZOK0c1UjBaNnNneDMzTDEw?=
 =?utf-8?B?SUZJbDZmYmIwbXdPUGVaUG9INW1LdHozMHdad3R3aUZYS2RSaTFtRmFVOUdO?=
 =?utf-8?B?ZVBQb1NCMXdXWWZrcjRTL05NNmEwbVN2R2NKRnB2T0c3aWpjSHgwNnJXRlNZ?=
 =?utf-8?B?UXBCL1pjTlZHZFZzVTlpNnJETC85d3QwZUpJN2F3LzhiNlA1bTRIUmFCbjN4?=
 =?utf-8?Q?8qqw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f56c35f-a1d0-44c1-b0f7-08dd04cc5cd0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 16:49:53.5268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DK7mFGlnY7AtPGFW+4dxsWVlknsU7xJ1dbWOhdMTqFLN6F02B/3RSvoaIcBUxMProaUv+w04UwWgWdsHypu6og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10617

On Tue, Oct 29, 2024 at 12:36:33PM -0400, Frank Li wrote:

Mani:
	Do you have chance to check dwc part?

Frank

> == RC side:
>
>             ┌─────────┐                    ┌────────────┐
>  ┌─────┐    │         │ IA: 0x8ff8_0000    │            │
>  │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
>  └─────┘    │   │     │ IA: 0x8ff0_0000 │  │            │
>   CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
> 0x7ff8_0000─┼───┘  │  │             │   │  │            │
>             │      │  │             │   │  │            │   PCI Addr
> 0x7ff0_0000─┼──────┘  │             │   └──► IOSpace   ─┼────────────►
>             │         │             │      │            │    0
> 0x7000_0000─┼────────►├─────────┐   │      │            │
>             └─────────┘         │   └──────► CfgSpace  ─┼────────────►
>              BUS Fabric         │          │            │    0
>                                 │          │            │
>                                 └──────────► MemSpace  ─┼────────────►
>                         IA: 0x8000_0000    │            │  0x8000_0000
>                                            └────────────┘
>
> Current dwc implimemnt, pci_fixup_addr() call back is needed when bus
> fabric convert cpu address before send to PCIe controller.
>
>     bus@5f000000 {
>             compatible = "simple-bus";
>             #address-cells = <1>;
>             #size-cells = <1>;
>             ranges = <0x80000000 0x0 0x70000000 0x10000000>;
>
>             pcie@5f010000 {
>                     compatible = "fsl,imx8q-pcie";
>                     reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
>                     reg-names = "dbi", "config";
>                     #address-cells = <3>;
>                     #size-cells = <2>;
>                     device_type = "pci";
>                     bus-range = <0x00 0xff>;
>                     ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
>                              <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
>             ...
>             };
>     };
>
> Device tree already can descript all address translate. Some hardware
> driver implement fixup function by mask some bits of cpu address. Last
> pci-imx6.c are little bit better by fetch memory resource's offset to do
> fixup.
>
> static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
> {
> 	...
> 	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> 	return cpu_addr - entry->offset;
> }
>
> But it is not good by using IORESOURCE_MEM to fix up io/cfg address map
> although address translate is the same as IORESOURCE_MEM.
>
> This patches to fetch untranslate range information for PCIe controller
> (pcie@5f010000: ranges). So current config ATU without cpu_fixup_addr().
>
> == EP side:
>
>                    Endpoint
>   ┌───────────────────────────────────────────────┐
>   │                             pcie-ep@5f010000  │
>   │                             ┌────────────────┐│
>   │                             │   Endpoint     ││
>   │                             │   PCIe         ││
>   │                             │   Controller   ││
>   │           bus@5f000000      │                ││
>   │           ┌──────────┐      │                ││
>   │           │          │ Outbound Transfer     ││
>   │┌─────┐    │  Bus     ┼─────►│ ATU  ──────────┬┬─────►
>   ││     │    │  Fabric  │Bus   │                ││PCI Addr
>   ││ CPU ├───►│          │Addr  │                ││0xA000_0000
>   ││     │CPU │          │0x8000_0000            ││
>   │└─────┘Addr└──────────┘      │                ││
>   │       0x7000_0000           └────────────────┘│
>   └───────────────────────────────────────────────┘
>
> bus@5f000000 {
>         compatible = "simple-bus";
>         ranges = <0x80000000 0x0 0x70000000 0x10000000>;
>
>         pcie-ep@5f010000 {
>                 reg = <0x5f010000 0x00010000>,
>                       <0x80000000 0x10000000>;
>                 reg-names = "dbi", "addr_space";
>                 ...                ^^^^
>         };
>         ...
> };
>
> Add `bus_addr_base` to configure the outbound window address for CPU write.
> The BUS fabric generally passes the same address to the PCIe EP controller,
> but some BUS fabrics convert the address before sending it to the PCIe EP
> controller.
>
> Above diagram, CPU write data to outbound windows address 0x7000_0000,
> Bus fabric convert it to 0x8000_0000. ATU should use BUS address
> 0x8000_0000 as input address and convert to PCI address 0xA000_0000.
>
> Previously, `cpu_addr_fixup()` was used to handle address conversion. Now,
> the device tree provides this information.
>
> The both pave the road to eliminate ugle cpu_fixup_addr() callback function.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v7:
> - fix
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410291546.kvgEWJv7-lkp@intel.com/
> - Link to v6: https://lore.kernel.org/r/20241028-pci_fixup_addr-v6-0-ebebcd8fd4ff@nxp.com
>
> Changes in v6:
> - merge RC and EP to one thread!
> - Link to v5: https://lore.kernel.org/r/20241015-pci_fixup_addr-v5-0-ced556c85270@nxp.com
>
> Changes in v5:
> - update address order in diagram patches.
> - remove confused 0x5f00_0000 range
> - update patch1's commit message.
> - Link to v4: https://lore.kernel.org/r/20241008-pci_fixup_addr-v4-0-25e5200657bc@nxp.com
>
> Changes in v4:
> - Improve commit message by add driver source code path.
> - Link to v3: https://lore.kernel.org/r/20240930-pci_fixup_addr-v3-0-80ee70352fc7@nxp.com
>
> Changes in v3:
> - see each patch
> - Link to v2: https://lore.kernel.org/r/20240926-pci_fixup_addr-v2-0-e4524541edf4@nxp.com
>
> Changes in v2:
> - see each patch
> - Link to v1: https://lore.kernel.org/r/20240924-pci_fixup_addr-v1-0-57d14a91ec4f@nxp.com
>
> ---
> Frank Li (7):
>       of: address: Add parent_bus_addr to struct of_pci_range
>       PCI: dwc: Using parent_bus_addr in of_range to eliminate cpu_addr_fixup()
>       PCI: dwc: ep: Add bus_addr_base for outbound window
>       PCI: imx6: Remove cpu_addr_fixup()
>       dt-bindings: PCI: fsl,imx6q-pcie-ep: Add compatible string fsl,imx8q-pcie-ep
>       PCI: imx6: Pass correct sub mode when calling phy_set_mode_ext()
>       PCI: imx6: Add i.MX8Q PCIe Endpoint (EP) support
>
>  .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml | 38 ++++++++++++++-
>  drivers/of/address.c                               |  2 +
>  drivers/pci/controller/dwc/pci-imx6.c              | 46 +++++++++---------
>  drivers/pci/controller/dwc/pcie-designware-ep.c    | 21 ++++++++-
>  drivers/pci/controller/dwc/pcie-designware-host.c  | 55 +++++++++++++++++++++-
>  drivers/pci/controller/dwc/pcie-designware.h       |  9 ++++
>  include/linux/of_address.h                         |  1 +
>  7 files changed, 148 insertions(+), 24 deletions(-)
> ---
> base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
> change-id: 20240924-pci_fixup_addr-a8568f9bbb34
>
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>
>

