Return-Path: <linux-pci+bounces-36608-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4074B8EC93
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 04:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 234534E042D
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 02:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A31313B58C;
	Mon, 22 Sep 2025 02:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g5ttm7uW"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011045.outbound.protection.outlook.com [52.101.70.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448EC288AD;
	Mon, 22 Sep 2025 02:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758508702; cv=fail; b=qXC3D0vw/UTPV08yrMwhwX7+Ldh6fju43QXnDERtEJuC/3SPD6pq/l1bkhhnOQ0BopCt7kZBbvbm+T+p+FJKEnvkp7ryeKvQJGFRXMqYy5MFl6+GPS8sHjNGD42QxW6kxpsW5SrpnNMJblaVk/Pfx+oODgQvdN98A06ZXpxDbWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758508702; c=relaxed/simple;
	bh=CEewslAFYc3waBfAd6A1KwL6V3ZIvHlzkG6bJYBZKnE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ruCtsExqa03w+PWHGFMOqN44Iebth8Bz50SscmaTdru3tOoi4Sd9c7q3jvhGE1EcsMgtMyUC9fkvDjaTe0PrmHgt/Xof6VHyF/xUt1ypCuz3Ra+fw0GPmZTFUx8mtKX/yplfAFtMlO5qhbOgduPB2NkVmxaq2YsJ1m3r3uDXah8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g5ttm7uW; arc=fail smtp.client-ip=52.101.70.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Am5o4KiZn60eVjXkn3kOLXJ3X80zPCM1HfekAg6KNQhMkY/cdrpTZdsgMYsBxhji6yX0hScAzcWVwQwRjBk+9rICjcfQ8/DC959mr3s2dn2y9n2+5r/gUDwkKPg9yt/kYIuGhejiLMhY/K0feDa/ANwstU2gGXcacA+18TA3e28LLjeZ/F0fToj/jf8qY08JIhCh95OXVlmHU4r+IJSbSjzojjTLLozlIEV8om5zlrVxkj+BQRGo/tItPJ6I5E5VRNcQiIxwhyls9Yo5yWGxU+XlCQ9/Lkgc8kje3sLbEFLuBO3VuWJhi3Mip069JT3JZRkNVWHce+KCGm5F9j53WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BlVNNjVo2JNMeACpg/Z+uolDfE9TC00BYVvFhuyX6c=;
 b=sL+9Z+rp7XER+NpIsh6SjQ+ic15JZZzl1/p+BILAjZz+YI4XVB2/qeTe0LJghMXoCCZZIflGVr2/T2RBmlbumAKWROoa4hX8QbPs8BgfX6N9wqtCesxfWizwecQ6pYrPqZBon+jhEa6GvI0N/eOvlta1Ryueu/sb+N+o1hkOx9qyFADBRG4+RYqGGy6U66lTremLoYPg94hcTT7wlVXo0QSIHZrfDOwcMbxpbZrWAEf5K2vAt7aMpYHNy7Vy71iCuC/2bipPkAqUc2Xn5ZTWmpdz2lgteV69vUEwDpraJ9hjGFbnniOldOhQ9CJZt1XZnMrJm6lrs1j+EyO3oB0xDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BlVNNjVo2JNMeACpg/Z+uolDfE9TC00BYVvFhuyX6c=;
 b=g5ttm7uWL9ErBXhqsjYozNhg3ZsXQ2yj4gNiM5zbskEsdokKC8ujMwBeCBMtUjuTHXDK7YtrosWi6E2iRerLNeYmYs+8GHPsu0JfU1ZPzFoBQmMK1F7XTYwzIpR7jMto3BraD3GSlKorVoQ+wjOTVr9m7enGbwZQ86i5QAhgpqOo8PVIOxPQCRG4zanxgWSo42jGHS2Svd8bggFIQ6iHjy3OcNE+SzgRiWfZGgdid+0aYdUle3K/f4MYYPm3ElXpaxudVX/EN0aumFWwlMzImy4iC0KfV70OgPzNv1o+uxPIJ/AWTDKAS3Df+6Eu47T0fmo5mvazcC5eoMyUwzkfrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DB4PR04MB11280.eurprd04.prod.outlook.com (2603:10a6:10:5e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 02:38:15 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 02:38:15 +0000
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
Subject: [PATCH v3 0/2] PCI: imx6: Add a method to handle CLKREQ# override
Date: Mon, 22 Sep 2025 10:37:39 +0800
Message-Id: <20250922023741.906024-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0136.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::16) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|DB4PR04MB11280:EE_
X-MS-Office365-Filtering-Correlation-Id: b0cc0382-d856-4a0e-0197-08ddf981148b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DEE99jasefacN56+jCufK63wsg8NATvq298gczh7i3DIjBUUXODLmbJrc2/N?=
 =?us-ascii?Q?wvClFlwY7HHfYnzvHyxOCa4633/oTgO3Ao5nEYNaffFrmHjQWRnJrhYXU1Ad?=
 =?us-ascii?Q?JknOT97vWc+s3stehi3JNzUXMPi/vr/dEBWLv8Ce5X2kBSiXODP4UGqAtmq9?=
 =?us-ascii?Q?GL/unkppdnk7RDBl3QbZF6uBzriwGVc1JrtpUw72Ed86MIwMkWFnh/BXSsDV?=
 =?us-ascii?Q?Igx4X1ZsaPlFfYpjK2EPHhHGwV3W5mNZVagSKV2a91Q/Ec09PYU/Y3QfagW0?=
 =?us-ascii?Q?g+Gf/TuVVCpYO+0uOFG30BCycWCBk7oB3L6RS2Eol3gn65KRGW4b324+I1Ox?=
 =?us-ascii?Q?g/VMH40w5kCdJg/JtDCfK6I2vQqtysDy3MuX37SLo2jJfnJ0bSzJeIBB6Nt3?=
 =?us-ascii?Q?jpY77noLFmGPT+//STxipytQfTx+U5w9cx9KvzmV9tiShXNIdba2XIFxddr8?=
 =?us-ascii?Q?QaxGpsPUyQy1cY1NsQnw+Ytd8hzh4yw7L6YFFiQrZYmNK3CV1RXkD3QjaQnO?=
 =?us-ascii?Q?6t5DSW4Jw2A4GPn0feFLlUP35DjbrUkq5M2njMVVGoCokIgJEqT1bhLh0fgA?=
 =?us-ascii?Q?bxRVawN0U/qhmtRttB5Q+wshBFdTaS1lA8wUP5UUKdBRCr0FCZ9cSSckAAQt?=
 =?us-ascii?Q?UeANtFlyED6fECNFJK4EhBbY/9phfYqsrWVg+Uk+A083mikYuGlDeV0f4jup?=
 =?us-ascii?Q?vrBabOGlGvftGxQCvasj2fewHTrVSETiom3kTdsAJddAZtW0LPw8jAKf0XJn?=
 =?us-ascii?Q?AvMJZ/EhdLiOkqU4girMcLwl/bdWCo1Beb8Y5XESlIhEvVA5j50+Dronzh0Q?=
 =?us-ascii?Q?+bffV2NQItnUub7RUNE+w9pHtubQ9iSCMWTvpYEb4yB66xieia5Tsf7BCali?=
 =?us-ascii?Q?izgaS4KIF9lPZEBq1vvj6EG+SFG/TDOKFUGQKIY+LlMqq/5ktmeRHoUgcmep?=
 =?us-ascii?Q?JW0XbGsHz0KglfoQGNflrlhPYPK7KFXXbnBBlTF7YKq4ZwWABYkvhlpPcEdK?=
 =?us-ascii?Q?0VF2zugAtXSPIjfJGMv9bw/4Ci2aqJPP9AFmZAF1cA9+IM0KSQuWzxnLVK7G?=
 =?us-ascii?Q?TeT933zHSPWxFNKoxeJBwrPXl8PlgHP6TEwxXbhLXlzpg+PDgKGGsVqpnidu?=
 =?us-ascii?Q?dv8jJDPTi2hePH3xY8EQAZo0hxQJ4U/82WYKW6d4aFnYZT//hLJOOUKtja1D?=
 =?us-ascii?Q?DFi+7pId0wMQ/RjDnku+HLU417hCt72jwbuNhPIlse7hqwC/AmoWfGVZrlg/?=
 =?us-ascii?Q?xgzA4PPCdXXkvNmkD6FIPhQ0DuZ5GkcCN3xrLb8pLc157jcmphS+V5uuvLos?=
 =?us-ascii?Q?CdA7xIcrRRPND4QAVzKPjB/hmmUGgPW2y1KMiWxT/4RLaYjFeqT0jn8RpVYc?=
 =?us-ascii?Q?uclZJupRzPgjpmNFYoio5TtN12iv+dCzymkZlVqH7/ciH7x3OrzY4sYNqTer?=
 =?us-ascii?Q?xpIY+ROOYYuMZNckwaEfUvFzMKLU61mPsmilJ8xWnpwNP0OOIzHnXsJpPMX9?=
 =?us-ascii?Q?lNpOSBXloj8yNGU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Su8XNO8Z98NQyKC5VGiGJDSnQ39r2O9NsMTZo3PP+j8ykvOMTYoQgpIL9ee9?=
 =?us-ascii?Q?316JmEh8Tih3PDMTsY/1zo7V1Ddp1Otfmq5feKYBdIlf7QXNagRrtyhy+zbm?=
 =?us-ascii?Q?D2RdoKZm8MU/dkJuaoISLXW9HSmGyEhlrNiWM8e2RBQ+Q0EzgfW1TZ0CGQBx?=
 =?us-ascii?Q?BMGFt55D50ajvO6sf1MwJqVuaPtTmUSaNxICuxoFAtuT/lmw20qRtGR6X0p1?=
 =?us-ascii?Q?YwRHROGScqhoa9O/lfrGoPYlwyRXOB0FYf+2qYOTUAUmUsoiyqtQkGw1O9cO?=
 =?us-ascii?Q?k+/cjDeH+G/Uhn1CchFjUJsrJug6SDz7otDAaGjxYKaKo3UdNPPG/c6PPcYU?=
 =?us-ascii?Q?PoYKV8oAEZp+aDEhH4lF3b7+ItWnGRO6hV3W4zYnRKIkkuBAZrZOwPSgQV0F?=
 =?us-ascii?Q?7EhCuBX5MxQYTaC9ZTRF0ITxrvDOFY5HDvcyZRvSfUACFPmWNbX6BdulnMiC?=
 =?us-ascii?Q?d/bVVg6fE/TWwrOc3hgrKp5jW2dC17uyuQGDa+vbxerZU0V8FnC+DLtv8ZSK?=
 =?us-ascii?Q?il5zbpRTqH6/ZIbIBRs2UMfewgI3Ql+rdiSTlKH9oI/zFBg2yrE4yv1CYlr2?=
 =?us-ascii?Q?u28NEwJW0bJ34p1Kg2t41KJs1/h6hjPTbNzV8dn69bjKGDPcLuSe4ovnRsZg?=
 =?us-ascii?Q?XPapbqlVGsa3o1GM/LN0Q5qEhB2qlS+uZrgaV8rUXpnOYPK+jbcTVfk4ghxY?=
 =?us-ascii?Q?KUh8RT1+hBF1YOwdrrpLmWdi3/nOJ0RA4EIVOUK4r8CjuO/l1RLMXfuyscWP?=
 =?us-ascii?Q?4jX9HUS/ZtFkA304VIJJjh4xXHGOH4Ra3oL83cEJ19gud/6jKSz83sEGSJlP?=
 =?us-ascii?Q?IOzOOPYplOWFGAtBOg1CRlDbx00iQhIEtg79GJF6UpvjBrfvz3TIVteLI+rE?=
 =?us-ascii?Q?ASTppCnS2zsOIxF7vZgHGyAbn52xUwMvyqe5jppYS2490Z967ozYZxKahkBc?=
 =?us-ascii?Q?550xQKMDJ9q05YgMyaX/Bp0drNTQuztjlZim49BLuhBp6+oMdW7E33Tyqe0b?=
 =?us-ascii?Q?i1VqhqpIPCi2mqWhsCuEvf79OsgNPYRMpwtJOW4Ksc1hDtOXDs+3rRPwDtSM?=
 =?us-ascii?Q?/EolS6FWgQqk/QggKvtT06fpgkjxjrSLMifHS8XwqyXTp13v0qmWXwWJiX8m?=
 =?us-ascii?Q?Z3aVpa0+Er4+HxMYEn7p3F65t5SpTkWep3gFhg+2T9K1b1IT2kaP6Ubf/zIu?=
 =?us-ascii?Q?zcqBRYYxWJdLH3ktEELKxb4zAdy5eGjrwYuzOtBo5Du089slpOeTWrM+juE/?=
 =?us-ascii?Q?jTNBUc9VFUN0xU/o7WFwNWP+YoJxVDFBN53SR/6kJE4Ewiiq/v4CbL95tB+N?=
 =?us-ascii?Q?WxF3uesiksoOOAyqg1pdOygTqd0Z3p7oXG60Lc+DR2bx36MuSA4C3E7ArYQE?=
 =?us-ascii?Q?8r/JsFfloiV/0FJI3sGQrkOKuR24FxFPbbgZ+IqmeEAhzey8Xy3cSWKXTdpx?=
 =?us-ascii?Q?VqakrjRs4D4V4XAfQ1Pk5uzB3Ko1SKlo24g745tbr+pbLB+ZOYovK4JfRyVg?=
 =?us-ascii?Q?wguzHtfV6KeTq86D9vvQQU16D1xkJKH7ancSPEhHgWtukAbbTALIRWf3Lwf+?=
 =?us-ascii?Q?XrJyntaNYEBQh5B8Yihn3aeNQ+0bt/rHnq7HNxYp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0cc0382-d856-4a0e-0197-08ddf981148b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 02:38:15.0820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGKzWvRxYu6SfNRKfjMARFLb5MzdqU8HnNj6hfi993qJPRDL42TQMmbRQa5UTV+zk66aMEyzeBxrto+rumLExA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR04MB11280

The CLKREQ# is an open drain, active low signal that is driven low by
the card to request reference clock. It's an optional signal added in
PCIe CEM r4.0, sec 2. Thus, this signal wouldn't be driven low if it's
reserved.

Since the reference clock controlled by CLKREQ# may be required by i.MX
PCIe host too. To make sure this clock is ready even when the CLKREQ#
isn't driven low by the card(e.x the scenario described above), force
CLKREQ# override active low for i.MX PCIe host during initialization.

The CLKREQ# override can be cleared safely when supports-clkreq is
present and PCIe link is up later. Because the CLKREQ# would be driven
low by the card at this time.

Main changes in v3:
- Rebase to v6.17-rc1.
- Update the commit message refer to Bjorn's suggestions.

Main changes in v2:
- Update the commit message, and collect the reviewed-by tag.

[PATCH v3 1/2] PCI: dwc: Invoke post_init in dw_pcie_resume_noirq()
[PATCH v3 2/2] PCI: imx6: Add a method to handle CLKREQ# override

drivers/pci/controller/dwc/pci-imx6.c             | 35 +++++++++++++++++++++++++++++++++++
drivers/pci/controller/dwc/pcie-designware-host.c |  3 +++
2 files changed, 38 insertions(+)


