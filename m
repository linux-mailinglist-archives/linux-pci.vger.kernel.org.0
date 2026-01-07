Return-Path: <linux-pci+bounces-44132-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF72CFBC46
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 03:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A867130245A6
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 02:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D366AD24;
	Wed,  7 Jan 2026 02:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H3cToDAF"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010015.outbound.protection.outlook.com [52.101.69.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9BA800;
	Wed,  7 Jan 2026 02:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767754011; cv=fail; b=KoWc9B93kzadUjJeL19jFXJvQ/bBHMYgfr/X4uQ1qSazM3VzC4pf5JD87iMbTWD2Zlvkv9buphLc/H25e3c+mXlBhLP155J9bOJz2hoHdlE4G4sV6Or/7qsfdnCc+ySNjExEodnyEorm5A90YCP+UvW1PYoOVFUnBeHJw47CThw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767754011; c=relaxed/simple;
	bh=65+TxZfaw1JjQ+wHcigee3hSmSE3asLgFcg+N0BthtY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=V3U3fPaJFqVfcoxxd8EhFW5PDXiyImfwc/4tRj0ghc+KGnfs8oVGev/H/yLFLHRwnXhtxASSGyMs+m/xc7bpYwqdOW7j+36uHt2uiUKVCt4OuOwEczZUZ+7X3DxLQ/bpm07Y9h6+i85znohbrUKLPZZlH7e4Z1W/muw3fsjE0ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H3cToDAF; arc=fail smtp.client-ip=52.101.69.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCBK0IorZ989ujU4l0uwJxIy6hoEGoqohF7YPwqiamteX2+CED5ZkHJ9TlZ4eo9eh6w/emf6Cp5u7h41kN56mC8dxLwQty34f57FEPmGwc7xODqn3Jh9T1t16MmuLhV+9bJfCskrry5KRZHHykkRMDuHfYL7uyvpOOX7/+ybMRYmd3UqHTGD39dycmJXmlIcr6ja8ilGwC7K7i1gP6NBDuNUPi8fgZXjS9HSf2tMPIKQuaHZ2PvjOP+wNk/LemclYBbPp6rQqZvnTxgBoZCBBXi/xR18vXfzKrCy32+g8pCdbvZsFLpDeBBXCS6BJGZW9G2Gccvm+a7mDUaxxbhKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJqMghaIHyHeoPCx93ZoyCliateH4U19zhgFy5WKKTY=;
 b=xkK8C1TmDiH9SrjuZawiK7v7Gg+fPXzDk1l9yyPAn8YLsw9YdqoZZ8GerifZ6w7iBBaz07jug+jO65sO/4cbPSepkAw4ri4akIPLSkryfkQac9l0e7yRWvtCAaUwKnVL8bVgJD0jzv81ZYny5fYu0Tetfl3QMEXU54/jOznrqXEKVNduJMHuP6160mXfpGAIxQU1axnUdBrCldswWZfZK6Vw5VdDyJKUitrZCQPOZNIbMDdzQKjxxUZtW1NY8JIEU1B71ufQ2KiDit3Osj/LIgvRQMceDEvgyTQfZI/pHvwLSi5ODSRSHyShnVtgUOUeKrjpAmzWKfa1ueOqG11BnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJqMghaIHyHeoPCx93ZoyCliateH4U19zhgFy5WKKTY=;
 b=H3cToDAFO56GBe/6ShtkvxH71shMP5Nomy5joqqohWoeK3mCNMc3nQlaQ3H4RSAJe1TvVRaKauxhnxVy90TFuea99lBdpOMvNcol7IOi+ZIGl7C+QJRe50jhFlnNunluMClWI6+/FQmlaouNkbNras3pf2CiiVFi4Z4z/mrw5iFuX63yibupSgyhYhPfTwesc+2A+e4riRVX8zINdMgt39kJYYWpVgfQ4sf0kdIC5rGwiiiSbxPznUMIO8sCMEjrlEUUwBSYG22IlzfCxmZFQSg+TKhJwcOk3/Xbw7Jhek9DLZM6zcAFMn/VqqQDYPFdpX7ghnjNwOwdaVnsJ1sTEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by GV1PR04MB10332.eurprd04.prod.outlook.com (2603:10a6:150:1ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 02:46:44 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 02:46:43 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	jingoohan1@gmail.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/2] Add quirks to proceed PME handshake in DWC PM
Date: Wed,  7 Jan 2026 10:45:51 +0800
Message-Id: <20260107024553.3307205-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0113.apcprd02.prod.outlook.com
 (2603:1096:4:92::29) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|GV1PR04MB10332:EE_
X-MS-Office365-Filtering-Correlation-Id: dfea40df-7313-4a79-e830-08de4d96fdef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|7416014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?32CzGAyiYjnFHItcFvG9ZGi97eq3lmY3RjczxzduWeYyzULAuj7ofqJFraqZ?=
 =?us-ascii?Q?2mra0eWb1xDPvY8AaVrjJ8a3XwQB4ffqNgBdc7Hiz9RrEU0Pln9xFSTben6g?=
 =?us-ascii?Q?qselBPMk6Wk0vmkf180GGTWt+kRbaU+P1XBbsPmGrHgzlCZc3o/FCsn2+4I3?=
 =?us-ascii?Q?NLNlQf+Qno3WLZqs6/0eSZMOnlO3aAOWuPmN/yzlM3wwQdrNj3iDgWt/raYR?=
 =?us-ascii?Q?bPif10eiHfUiMZxiYWyR9QK3Kmn70gCS3We5GH2YBRi+oRQGoiGuExdAYzSX?=
 =?us-ascii?Q?jTrX2sxzTasPROhVvSqOj8qgi+yuMS1bjo6RHazAxbPkNEQPn+x7vTzMi50g?=
 =?us-ascii?Q?50bJSOvvXosF/XeCld3hfOY08FpUsj+lQZ/nTL7Xe2r/1JBEahhsy9ZBsV6w?=
 =?us-ascii?Q?CIJvsYCiTmVk1JCLyBGgVc+mj8biGh8cr0Q5grrg8cFxem031fNFySoPqgfQ?=
 =?us-ascii?Q?n1NtFfn9juUBHWudwZTyaPVYswQy6jtJ7leBnlmwO3pdsRFB1Wiar/PZ+082?=
 =?us-ascii?Q?u29eYEXA9QfDg2Wlwz4yl3vcj9cjHBIhl5/+dewRuAX7lObwtmw8igDfZv3r?=
 =?us-ascii?Q?T2QTnrWFN1/BztMp1OE8uq/vh2JZw4fmBV1CbNBwXoO5LYC1eiSibcRLXezD?=
 =?us-ascii?Q?HTJIP6tp76VSA3pHKhH/KcqvmjdC06S0hYVV5qPhr23pqCzxunohOQp3Lg4+?=
 =?us-ascii?Q?3WhTTb1zTrnhGGtiqpK/4EoFDcOiQQXi0mxtBlSvLYtLb2gQ4P6kjIPKtsZr?=
 =?us-ascii?Q?fgM6+h8lAxOAzjjHKS57ZdTqnilNOf804kN075/FisGekpcUhyuGl4eGIgDX?=
 =?us-ascii?Q?KnMCrYoro2FX0B6a5DspRIfVD+hgNv3gKnU6yzb+8tbo7yi4JS9tXvgwIeSZ?=
 =?us-ascii?Q?JMWF8Wzpw9DAmjAjx+4+dTqxzqBlDByTmm8c+uC95rLJbsTVSsKgOay2lKTc?=
 =?us-ascii?Q?bpf2pUbcTWjLIVtnNiAeRYmY827q5vU81VrWoQS5XNTHXTPIT5+6C9vZOPOo?=
 =?us-ascii?Q?bDviEHzL3rz3zLQ07/Z+kqCNHOTKV0cJ1mhXWh1p+kFqCbpMuj8jcY+MDS1x?=
 =?us-ascii?Q?cGLtf99BGU/WbJlEODNqgkCnfjCc5nKO6RvahC8JL3j3i2V16ycp33aoYnM1?=
 =?us-ascii?Q?yuOUeCEYuiC+sXAhze951k/rg3ACthfs0OQFCVQMfS7XcQUT3TBJLfN48pdx?=
 =?us-ascii?Q?oA8qa4o+712Ps4VXNMVcGLQClVBR4nSx3acP4x1S7l3dTwvKJWr/tMXwFSSp?=
 =?us-ascii?Q?3ulqkUHI7kk2At55E3eisp6Wbj5p2Orma/qYU2XSXEU6ebDaUj8Hmn7Qqr9y?=
 =?us-ascii?Q?vK9dFvq62eyiC3wh1fYe+JaISuyYtosR3/N0/5oMHAhhyNKItFsnds1N7EbO?=
 =?us-ascii?Q?RBblISl4SKztat61YQs9k8EtEAtPRD7yJnu1XF/k0SWORLeQNsF5nlJGQ2Yt?=
 =?us-ascii?Q?cNbzybDH2vKVGP5lMURUe/qgEhIi6YcUIa2q1vwRXosYyOO1uv080toazYDQ?=
 =?us-ascii?Q?RxJMWPkYK9jKfU4KDQyEx0fkAIWxU1WGoGrKjuUXab0EF1dSwvBFOkUapN/B?=
 =?us-ascii?Q?7ArMZHsvY7+R6YnYQuo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2Bpkzwc6vLFZiPV7j+9Xohb/hgZFc044VrJXCnvk7VWufSVTLurFVZEgjp1Y?=
 =?us-ascii?Q?FwrKxM+Ps5R7vVT488UYP6eiR9npoAx97tC9sOK78i7MZHAP2Uvv6XnzZqLw?=
 =?us-ascii?Q?scYSJpnx+heiNS/dIkLdx86qLfgaVfcD86x2Y82RzVXCgPZCFXi6ZyBrwiwl?=
 =?us-ascii?Q?k336ratAIxao9fFqqscD5tJsWsdohbUI6yO7Ss3pey3x538y9DHkvA3PvvUu?=
 =?us-ascii?Q?/YCdKu2q73Jw0KsloWrZ9uaEY5IesLWOVhWBG5PYz4VIWlGCOvMijRohrGyj?=
 =?us-ascii?Q?tMMh6MhqBU6G4eqRC+0G1AnlhsTM7LkzS3k82KlvbBZvdR8mhIAOewCL79AU?=
 =?us-ascii?Q?DJcUuQ+u9DjLia30bd06O9x8BxRJlimF76PzfGudP/ymk6wD5DyYk4yvBhkr?=
 =?us-ascii?Q?4eVnv1ZAAhylSDUvEsTcOZb5xmi3xJIY0YfK8Rd08K1CgxpKlmCZrgoCPRgq?=
 =?us-ascii?Q?bijTa/nII9ADqRyPtwv9/VD9sZqIij8hXfbV634IsY+jSZaIL1tchjTrtETu?=
 =?us-ascii?Q?n3gMgnMCf/hmEAu5zRiN7cIb0f80VusrVGu/07uMXZPl/b5bMaUK4EgNVek+?=
 =?us-ascii?Q?oO+SfNE8kM/xUIkE0GKOuHsJg2UJSZYLt9xz9Ujv9WT40ds1Yxc7gyrMqicv?=
 =?us-ascii?Q?tu/85dNg4vX/ox985pd6AvXahQGhpzjiTi/N884xey2MuduGv2E11ILJEBvU?=
 =?us-ascii?Q?8hnnvBZuIo/58B0jFhoq16DOn2BrNDblb7rlcEMKa44Ze1M95cxf3OvsUDRM?=
 =?us-ascii?Q?y5wMhhoK7RCY0BKADg8ZF3B9O1ynLPzKMACmNuIuzMBb7ws731/2Yez0lncU?=
 =?us-ascii?Q?NrfppMvf32Y8xWxqoRTtR0MKHytIi8bCkuE382o6DHIRyoiUp8oB0l7WvMq7?=
 =?us-ascii?Q?vNnr0/i86K1euz31i20NLFsZhwSxGKQSXmUPpqjCtu9L5nPWGMNtafPtlWpe?=
 =?us-ascii?Q?RCgnbN1TDCLyxnYLtmiS7xn3JTFmNiLdTrt+KqzpJOOqQwqcheC6WFc45Thr?=
 =?us-ascii?Q?yauHO/qbECSZcnXpU7k8/Pp5Ony6nhZuh3bvaVz0ahNwk9BiW1EDQ2fMcI2p?=
 =?us-ascii?Q?HyM4Gv4uPBqF8G0Q3HxduwYzSTzyCpYhb15qHdedQkCFljLG9PP1B6oFTapY?=
 =?us-ascii?Q?fJLdrRCV0v88ypNqsicKdducWBb4WEMzFz7Z6BOvj+VuZM5iZlcnXM7tcsEI?=
 =?us-ascii?Q?EmLPHAMHGH2clw/cco0lFo5kFxdkrym4wC5Vrb6DaLmZ8P4oXTqs6X0v+OUu?=
 =?us-ascii?Q?NI99NstGOHPA0z84wQfq4RhWPEM13ehzyn8gzEbYbnc6JfCxJzdjMs2R6TVm?=
 =?us-ascii?Q?Z0FtvzLbuUrMWuYPORC49cSiK/e8SYfI+MAQhsnAn2W8SIbv6Kbt4Xllm+/w?=
 =?us-ascii?Q?aZqrsVAf+PDZ6DThHcSwE7hRWXwOP1jhBU7pf4TB2TZSecgIpCLOnYZ2QAWO?=
 =?us-ascii?Q?oDhVV63A6Q/66S39alByBI6Ix/ampAMVNqwREFEw7p0XviMsjFuLrO6TLcPV?=
 =?us-ascii?Q?6Sm8rTpGXJq0KA0zewqMfXVD/q8PKkVKK5PNT2asdGritSotM/OF30peVBh9?=
 =?us-ascii?Q?VkQNXFObAUM2nXYwkwBcPF05T9Bl9f3Ossvx7O15iYYAJF8qcERUqMfw1lhQ?=
 =?us-ascii?Q?fXxL5Qe4+ItKved4e+32Jm8YrSWCGdoPHV+Hm7iohwpMQ8Hr1eBwjml1YBSn?=
 =?us-ascii?Q?yDxma8ambiSmun/X5xADA4N+8Hvgt4pNfAEAFKkwOVCHLGjsbZuREEg4OQoS?=
 =?us-ascii?Q?Yy2F5q/fjw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfea40df-7313-4a79-e830-08de4d96fdef
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 02:46:43.5836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HjfXEucXJUYfqm9odlV7nqnEa3UPWOmkjARwzgWMAFr74/8k9QrdVGKpewtI/jrXuHP1u1oeAhYONbZpaplRuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10332

It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
PME_Turn_Off is sent out, whatever the LTSSM state is in L2 or L3 after
a recommended 10ms max wait refer to PCIe r6.0, sec 5.3.3.2.1 PME
Synchronization.

The LTSSM states of i.MX6QP PCIe is inaccessible after the PME_Turn_Off
is kicked off. To handle this case, don't poll L2 state and add one max
10ms delay if QUIRK_NOL2POLL_IN_PM flag is existing in suspend.

Main changes in v8:
- Rebase to v6.19-rc1.

Main changes in v7:
- Rebase to v6.18-rc1.
- Drop the first patch of v6, since it's not necessary part of this topic, 
  and it seems that more evaluations and discussions are required.
v6:https://lore.kernel.org/imx/20250924072324.3046687-1-hongxing.zhu@nxp.com/

Main changes in v6:
Refer to Mani' comments.
- Update the commit message of first patch.
- Squash the 6-3 and 6-4 into 6-2 of v5 patch-set.
- Add the Fixes tag, and CC stable list.
v5:https://lore.kernel.org/imx/20250902080151.3748965-1-hongxing.zhu@nxp.com/

Main changes in v5:
- Fix build warning caused by 6-1 patch.
v4:https://lore.kernel.org/imx/20250822084341.3160738-1-hongxing.zhu@nxp.com/

Main changes in v4:
- Add one patch[1/6] to remove the L1SS check during L2 entry.
- Update the code comments of 2/6 patch and commit description of 6/6 patch.
- Add background to 5/6 to describe why skip PME_Turn_off message when no
endpoint device is connected.
v3:https://lore.kernel.org/imx/20250818073205.1412507-1-hongxing.zhu@nxp.com/

Main changes in v3:
- Adjust the patch sequence to avoid the build break.
- Update the commit message.
v2:https://lore.kernel.org/imx/20250618024116.3704579-1-hongxing.zhu@nxp.com/

Main changes in v2:
Add the following two patches.
- Skip PME_Turn_Off message if there is no endpoint connected.
- Don't return error when wait for link up.
v1:https://lore.kernel.org/imx/20250408065221.1941928-1-hongxing.zhu@nxp.com/

[PATCH v8 1/2] PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM is
[PATCH v8 2/2] PCI: dwc: Don't return error when wait for link up in

drivers/pci/controller/dwc/pci-imx6.c             |  4 ++++
drivers/pci/controller/dwc/pcie-designware-host.c | 41 +++++++++++++++++++++++++++--------------
drivers/pci/controller/dwc/pcie-designware.h      |  4 ++++
3 files changed, 35 insertions(+), 14 deletions(-)


