Return-Path: <linux-pci+bounces-23658-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAE5A5FA3B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 16:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C67DA3ABEDF
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 15:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5AA26A0AD;
	Thu, 13 Mar 2025 15:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fuw6Zx2h"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013066.outbound.protection.outlook.com [40.107.162.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165EA26A0B4;
	Thu, 13 Mar 2025 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741880365; cv=fail; b=WFqR8N4oJ98LI+KXkgUy5OZ47gLOHhJAVnIkx0mFjdEPawb/w/6EySa27gQHCnAiL5mrnlROyPv3gK1XNSNBDf3uHEa6bInd3QrXXx0FbtAjz7Jq/d0R86m4l2LwC8kvGjRhLs/9ITb94/zQn3lmQ50BJaI203QaKrkfmjANU6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741880365; c=relaxed/simple;
	bh=T6DcUiXsxiMNKGaSrQrQ6eumahfF/QN5HLNCR1UW6x4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kz/f1lfATeDlSOi1IVfOMwPRQOfEXZKdCoYU+UNFV/UCZC0hxjoY7pJTXjk2mUve5Xk+lFR1Ms02UEE8ogZue075Gn/gT3pZR4GkKodIbmRGqF+uA16PJUhy8W5Xq0dD4CbR0TSB6WXeXWaSN6jx88j/hz0kk5GTZqa1iuwbo48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fuw6Zx2h; arc=fail smtp.client-ip=40.107.162.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8TtKyEObwESiM20P+Y41cPSHW2AbfyCN+cbi/DDiB+j3WkgXanXnNVM/buMsL1TBzUvX9vz7Jb1kecGXIcPkkgxPGXBQfxvung70busBPVZkIf0h8th2LejLXqh1k/tTGcSNUzFux6k4xRcAMnLqbPhDzAl3jtbl6aswMUSPTQ0UeKa3b2bc733aOddI2K7xDbCErh4u7HSWrG5hARTqhDxMg1YGL/tovObke58vWHz7Ejte/rFq4cdsTkpBeNc/vjBNk4UMNNFcJ0xt/3Z1+Rmw8hNSoiIFWYhdMkjB68rZPDBuITH0sHNr3ZH2Hb7loPlICaUmDsg1wfFgUym8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfU0JrPr4MaKdkMfx6JTx2aF8h6E25TXVjReippGryg=;
 b=btdDdPRjLsLyZLYC0FEP+zA6GJD+Zv0IpWzWULN4zQfDGzYzOMGB8S26Lj8dCo9tSBxgbnMASvWadIhkXZ5e+tcF4WHlts1UMpvoSA3A1MFkdVMZl3v9frw9whKjQwA7hOMnY6L8GUi/1OpFX+2npJPW1KZVT/VoTGk7JYvYiWQxJP4T/NpVLzedemwPTmHlacdgpnKvuICZbY0Ct2Pz+wpM/Yk6itcp0ZcU2wPUUJNYvZo3T6jyz7+OVGpvu2xfoAsfp7X148FScbyuWPSL2JzCaDs25vumhCwneXvn2SUmeK09oxMrYZ4WV4//4X4itzTbRFAO7UdLV125ZCeZiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfU0JrPr4MaKdkMfx6JTx2aF8h6E25TXVjReippGryg=;
 b=Fuw6Zx2htF/Wxpk2hjwfTLUKB3X+vAuw69FGDrUCzCaFHM37v5PXpnSWENkwD9AZY0aiuVytGvWZ7GSJbW7mEWK3XzKGRR5hIuwWXdR8twYrH4dLf08WMK2ofsYPjCkdU35pM3pZf2cSsV6TpzLzeDpUIJWDrECeM8D/tkEKnTfuwaj5IIObrlv2SRRC0rDLeGNgGGeunmclJjU1221Rny2WeZ0K2IdRK8MdU/s2AMxjj8ayQc7je7NBCvQasMWg7RPvs/PNMpwC1jt2SBCwomY2qGxQXhM0mL/OraAwpd9QX890NEyEba8zvDIPRD+c1500TjIx6oiRJxjO1d8uWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10316.eurprd04.prod.outlook.com (2603:10a6:10:567::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Thu, 13 Mar
 2025 15:39:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 15:39:19 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 13 Mar 2025 11:38:42 -0400
Subject: [PATCH v11 06/11] PCI: dwc: Use devicetree 'ranges' property to
 get rid of cpu_addr_fixup() callback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250313-pci_fixup_addr-v11-6-01d2313502ab@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741880335; l=5187;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=T6DcUiXsxiMNKGaSrQrQ6eumahfF/QN5HLNCR1UW6x4=;
 b=KAaLP5HXS1v9w7jPmyGB2znddDj2l5e6QB452U3OSqHcx/5nOBT/WhUdTe2hKJEj7NpH8o9Vs
 +3iPyNj+Tv5A+D4/2l0X62OJdwtLT3ybmgmX/sxnJAX5RLldlIAwETD
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
X-MS-Office365-Filtering-Correlation-Id: eef7b578-d426-4ec2-4d14-08dd62453804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVpWd2c2b01zWDFXS01CNTA5R0RaSHVIOTduaStiS1FUZ2RFa0RIeU1ScERi?=
 =?utf-8?B?S1E2VzZOemxYL0owTlJ5STJsNE10ek1RYWVrbzNIS0h3UE1EZFN0WDJiUFBo?=
 =?utf-8?B?bFVIVDVjZUY2bk91cWFPdnZpcnVhQ2tHdTRDY2JycFN5akthRmplZWFOQnlU?=
 =?utf-8?B?TGJGanFwQU5ENmNRNStTcytmcVpWakw4VTdZWnFtOVZiR3lVTFc2eHVVbmVI?=
 =?utf-8?B?Tk5FaWptSHVyWHNkSkNJUXh1SlBQQWR6VDl2MVNWUmZaMWFtZHpSR09Sa2N1?=
 =?utf-8?B?bXVIVmQzbkNHOE56dzhCMTJKY0ZDdW9DUlA2dWNLa2JSbGxBRk9xcmlhQTlO?=
 =?utf-8?B?RjlkTU8zdFdJUUUrRWdLbFNEV3JYYnJxU0tXNlVYeDdqNnNscm1TdU1MVWh0?=
 =?utf-8?B?RWgvNWl0eXdFM0ZnUzZza3phcmJZUWpWMmdoa0x5aTVRWlJubU9yM1ZKNDgy?=
 =?utf-8?B?Z0N0NE90S1lzNFh0OVNWcnRmeFhmUEdvRm5TU0VhSDh0WWdIVlBJaU9YQzBz?=
 =?utf-8?B?Z0JRT2JVSytyREV2ZHg5TC8rMlpoRXVubnRFZlMwamlDcU5xMmF0aW41cm9y?=
 =?utf-8?B?Mk1OWTJhZXpJYVRtcEZPSTZuZ3duRERISnF2eGhHaGZ2U2RZNG9ENlRaNzRr?=
 =?utf-8?B?Y2MxUDduZm9tdVgwT1N5YVJmTXRrYVR3czB2UVBnUVIwbEJjWElTdUJkd0Fp?=
 =?utf-8?B?aE5BdGM0TlJQRmFoNE0vcWhvSkw0MTRjdWpVZkRka3pHWUR1VXd2aXFDOElP?=
 =?utf-8?B?R3hHc0tPREsvWmhjTzUxMmhSZ2ZOVnZ1WDZmanVSc2VFQU1DdUQ5ZmE2TjJZ?=
 =?utf-8?B?QnVCcUFyaEJMK2lpdnh5a2RSMDVwOU5Ja0x6UnJhZFVNNDJzTURXaHpVMDhQ?=
 =?utf-8?B?QjVHazk3UThNVjFrZlBHekNOeVFicHpTbExQdWJGbVV0QTZYbzRydExOQzI3?=
 =?utf-8?B?NGY4WU5xS2lqSk1IbXZYUFJzbXJWbVhJWDJxOEFGZld2YVgyRjdZdTIwcGNU?=
 =?utf-8?B?UkZXT0xMQ1BzeVNPY0JybC9iSndVTmlpdDZQeWlKSERqRFdURFpWZUlzaE9m?=
 =?utf-8?B?M2V4MVpUWWhPcnV6TVpmWlFRa0tMZWYxdUsvWjRwaWlLTzBGK1UyTVV4WGtM?=
 =?utf-8?B?WG5QYTJZTTc5YmpJM2NKbzBNNjh0UmFudWFJL2VVRlNtZWxQRVFDQXNpMzlp?=
 =?utf-8?B?VWU2VXpPZjdjZExHMzRhN21qd01pcG1VTnlNZjFUbXIveGRRWStaSUo1OFFM?=
 =?utf-8?B?WXl0cFAwck1sb0J4T281cXV0ZmpNaU5pTGdEWnRnd0szK2draWtVcTQzNGlP?=
 =?utf-8?B?NkduenRYSnk3WlFYUHVPbnhhZzBOZmtTeHlEL0ZjdVFkeHl3M2tXcGh4cWF4?=
 =?utf-8?B?UTdnVjhRYkdOZnlWSHhHV2NoRnhtUW9xeTkxaXBESmFLb1QvU1Y3M1VBemVY?=
 =?utf-8?B?TStDRVhiczZxOHRaRnBEc2pJQ1FycG9pNzlGOXQxa2N3NlFSRHBlKzIwTUFj?=
 =?utf-8?B?Wk4yaXFLQUxhU2xpVnV4L2QvcEJWQmJ6VUIwUWhRVE9KRHo3WE9tUVhVWGRa?=
 =?utf-8?B?M0dqbEg1VXZSaDhRcVRLQzN5RHY0aTFkdW9QUkh4Y1FIb3hwd2MxOXNMTGY1?=
 =?utf-8?B?R3pnN296OUhOOVJ6K05JSE93bmtuazhMdE5DNi9ZUmNBYXljSDJkM2xEZjNG?=
 =?utf-8?B?WVFic3h6Y05VakFKc25qRzdHWjJDZjZseXRxT0RyZGROaFZReGtiNWRDL1FX?=
 =?utf-8?B?UFNhK3hSOG92TzFCbjJVaVdXTHJRU2ZaNmlXOGtiVG5SdHFZUFZ5UFdqc2ZV?=
 =?utf-8?B?Wmp1bTNqSnZoSXZSSGFTbE1HbTJ1UE43VzJ3NkMyRHg2NTRyNEZ3eURnVzVO?=
 =?utf-8?B?Ulg3ZGJ0T1RyemxNY1FvbzVZS2R5bXNmMmk1Nkd2VSszdXhuNCtJTDRuMk5h?=
 =?utf-8?B?WVZ1VnBxM2lBU0hpeFRxVGhyelNiN0RlajZiaDdGVWFEOGFYSmRnRUFPNnhC?=
 =?utf-8?B?RkV2eUx2bi9RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmgxbnNZcnV1OFpTc0hPcExtOFlWdE5XaUdrRUhwSkIyODByMGcyakxYbGs0?=
 =?utf-8?B?Mmx2L1J5OFhkZDE0WDBPZDZRRWNxVWVucW5rY0lJWGFYYlFqVnpBODZmWXUr?=
 =?utf-8?B?T3lOTGFXeHNyOHFSbkQyRklOVG5DbmtkeEV3WCtXbmdXSmdldTF5cWU4TnNP?=
 =?utf-8?B?dXNaUVRwOEpGaFlwdGNDdzZwUGhzRXhKb3IweGozMlRXNEpubGdBbmxZSldU?=
 =?utf-8?B?ZUZlRVpuN2drVVFZTWZRY21xdkN1R1ZQNmdZZ1VKc1hZd0NHclVjZG1UY09G?=
 =?utf-8?B?OW9zOW1VRDFqdkRWTVdjTENSOWZhdUgvZldhc0krYi92cElsRE5GOFVvSnZZ?=
 =?utf-8?B?dHZMVWgvTlM0YVgwRE0yVDlkT1c3WTRlQUY5Z1htRXR4MFhub1IvOTVOQjY4?=
 =?utf-8?B?QVpic1RWOGM4YWFjUHlMSG8weGpUK3RZQklaNi9xVk0wMXBzRThHUE9kU1ox?=
 =?utf-8?B?dk45TzBndk13UHZLeFVleTQxM0VKRFpsVi9MeTJQRXFEQ0dyL0plWnJ0ZThW?=
 =?utf-8?B?blIxcXA5TWdkUzhrTGYzdU0xVElIM0ZDL1p1bWVBbFFHZFVCekxRUVRGeW9F?=
 =?utf-8?B?Ty9zTVR4NlVWZVFnRDMxdDB6K2xhWXpnZHhMQktUVFcxOFlGOU5SUFBkcnVN?=
 =?utf-8?B?dUxtRzRjWXNRenBHVDhPM0h6N081VXpjMEUvQzdiazR6K0hmTk9UelNLYWlX?=
 =?utf-8?B?cmJhZU1JMWNIS2lGMHQ5TFVqU3hYNFlqSm5hMVNBMjJhVGduVjhjWktxb3pz?=
 =?utf-8?B?bUllREpVb2ZMenJsSW16cHVPalk1Ym8rblpVRmhLdG9OM2o0anZEU2I2a0lJ?=
 =?utf-8?B?SzRjK280RExLZ2NNR3A1ZDQ2UHBNUzFackN5ZXBkUEh2MmxadUV0Wi9vclFz?=
 =?utf-8?B?elFMbWRXbEhLNGYvRUxzUUpBUGgvOG1ZSTF4Qlo3dVF0Mkg4UXNtdGMwNDFs?=
 =?utf-8?B?Z0NOa3QzL2RlRERENWJkQXVKUjBZSXQxNnBtY0hHUHVZVEJaakgzRytaVy9y?=
 =?utf-8?B?d2c3NU9BVmI2YWtXTG0wcitCcTd1c2hlVDlUR1lWUGkzbWtVUDhTSTN6U1Qz?=
 =?utf-8?B?Uzgvc1dHOWdNRWt4Z2wrYWpnK1FwQ0VSOWI2aHlDNklXTXFENVgrMXhZQXFD?=
 =?utf-8?B?aGZXN3JLaW9zTEZGQ24wSkU0ZXZza20zenNqQnlOS29OWFZIZlVKR0wzMHh5?=
 =?utf-8?B?bmoyVVlsRkUwZGYvQ1FMMjNHQmduenVCb3pKdUhTeUhwNitxWUFmMlI0bVdo?=
 =?utf-8?B?d0hPdkNFaEFxVksvVGJDbVl3Y3c3YjV2UVlTTkFQdjNTTy9IcFU3aTJXb3Zw?=
 =?utf-8?B?c1BmZlVPYzc3WVQxNXorUU9UR3hZMmlVdjd3cm85V0tOVjZ3NzlVMGkrRUtu?=
 =?utf-8?B?RjZUaTZOVmQwUXRYa2hLMDRZSHpHYnAyZHJtdFI1RnNWOWhXOXJPS2dXYzN5?=
 =?utf-8?B?TkltQ0RqektOMGpMUjFvWHhGa0pVUU1VZ2puYnVBdVVtcU5rYW1ULy9tc0ww?=
 =?utf-8?B?NmdlY3BMeUwxTFkxcXRHN0E4bG9EV2l2SHBSeTNKNlljRExiTE1jbDd5QWFU?=
 =?utf-8?B?NTdwOGhvUjdCclNBM0RtWm8wNldqNjF4dWlRUUU5R1pSVG43VTRMVGgxdVFx?=
 =?utf-8?B?bXJ3d2xhSzBuZ3BYaTlYZnUwdk94eVI1RTVQZC8xK2lCUm0yQ0F0ZjdMRkpu?=
 =?utf-8?B?a09raEtBSjR6M1RKZzl6TWkxRjZtT2tXa2xVY0JTTkVuVHcwUUxLOXlWbzEz?=
 =?utf-8?B?eHc1OVNtaTJQcGtoVnI3NTNTVEZ0WVZaMVlxUWNVcU4rcHNIV3lOTzFORnVq?=
 =?utf-8?B?QTNwZk4rK01QZWphcGMzUFYrNmMxRjY3QkRqVVF3MGZoOERLdmswWXVWTktx?=
 =?utf-8?B?K0RHQTl2bXBLTjdESkRqZ29hRCt3cEhuYnVEMnpPeUhObWppZWN1UWNIUTVx?=
 =?utf-8?B?R29DRFZNMTF5QllXMGhrOXdvZTB3emM0ZzU5UTFDemFsT3lGS01ZWjNEMVVP?=
 =?utf-8?B?OHdDMXNTRWY3TUJDN1U5WjJCZDU5dm9icXhMS0FBS3F4ODZlamR6LytFY1JK?=
 =?utf-8?B?eitBWGtRcFZqYms5dDRjNUE1MVJ4WDFXQ0xIQTZvQmNaYkxZdWlvQ25WT1Bu?=
 =?utf-8?Q?fl+XyiOU5RL++Q3dIA+rWQsRF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef7b578-d426-4ec2-4d14-08dd62453804
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 15:39:19.0134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UYQ1no4W+juig2inG4WdyAX0Fz3P7yyG1UyGGl0ExLm93OuAaUmbK23OREjykCTGsJcKqU4YbtPeLCKaFN+S1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10316

The 'ranges' property at PCI controller parent bus can indicate address
translation information. Most system's bus fabric use 1:1 map between input
and output address. but some hardware like i.MX8QXP doesn't use 1:1 map.
See below diagram:

            ┌─────────┐                    ┌────────────┐
 ┌─────┐    │         │ IA: 0x8ff8_0000    │            │
 │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
 └─────┘    │   │     │ IA: 0x8ff0_0000 │  │            │
  CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
0x7ff8_0000─┼───┘  │  │             │   │  │            │
            │      │  │             │   │  │            │   PCI Addr
0x7ff0_0000─┼──────┘  │             │   └──► IOSpace   ─┼────────────►
            │         │             │      │            │    0
0x7000_0000─┼────────►├─────────┐   │      │            │
            └─────────┘         │   └──────► CfgSpace  ─┼────────────►
             BUS Fabric         │          │            │    0
                                │          │            │
                                └──────────► MemSpace  ─┼────────────►
                        IA: 0x8000_0000    │            │  0x8000_0000
                                           └────────────┘

bus@5f000000 {
	compatible = "simple-bus";
	#address-cells = <1>;
	#size-cells = <1>;
	ranges = <0x80000000 0x0 0x70000000 0x10000000>;

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

Term Intermediate address (IA) here means the address just before PCIe
controller. After ATU use this IA instead CPU address, cpu_addr_fixup() can
be removed.

Use reg-name "config" to detect parent_bus_addr_offset. Suppose the offset
is the same for all kinds of address translation.

Just set parent_bus_offset, but doesn't use it, so no functional change
intended yet.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v10 to v11
- update commit message's first paragraph because switch to use 'config'
to get address translation.
- move dw_pcie_init_parent_bus_offset() ahead of bridge->ops = ...

change from v9 to v10
- call helper dw_pcie_init_parent_bus_offset()

chagne from v8 to v9
- use resoure_entry parent_bus_offset to simple code logic
- add check for use_parent_dt_ranges and cpu_addr_fixup to make sure only
one set.

Change from v7 to v8
- Add dev_warning_once at dw_pcie_iatu_detect() to reminder
cpu_addr_fixup() user to correct their code
- use 'use_parent_dt_ranges' control enable use dt parent bus node ranges.
- rename dw_pcie_get_untranslate_addr to dw_pcie_get_parent_addr().
- of_property_read_reg() already have comments, so needn't add more.
- return actual err code from function

Change from v6 to v7
Add a resource_size_t parent_bus_addr local varible to fix 32bit build
error.
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410291546.kvgEWJv7-lkp@intel.com/

Chagne from v5 to v6
-add comments for of_property_read_reg().

Change from v4 to v5
- remove confused 0x5f00_0000 range in sample dts.
- reorder address at above diagram.

Change from v3 to v4
- none

Change from v2 to v3
- %s/cpu_untranslate_addr/parent_bus_addr/g
- update diagram.
- improve commit message.

Change from v1 to v2
- update because patch1 change get untranslate address method.
- add using_dtbus_info in case break back compatibility for exited platform.
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 52a441662cabe..482d8ff751526 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -474,6 +474,15 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		pp->io_base = pci_pio_to_address(win->res->start);
 	}
 
+	/*
+	 * visconti_pcie_cpu_addr_fixup() use pp->io_base,
+	 * so have to call dw_pcie_init_parent_bus_offset() after init
+	 * pp->io_base.
+	 */
+	ret = dw_pcie_init_parent_bus_offset(pci, "config", pp->cfg0_base);
+	if (ret)
+		return ret;
+
 	/* Set default bus ops */
 	bridge->ops = &dw_pcie_ops;
 	bridge->child_ops = &dw_child_pcie_ops;

-- 
2.34.1


