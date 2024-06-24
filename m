Return-Path: <linux-pci+bounces-9182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF9D914830
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 13:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 487A9B232C6
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 11:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E709137924;
	Mon, 24 Jun 2024 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GlqjA9KR"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A29137906;
	Mon, 24 Jun 2024 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719227478; cv=fail; b=PXFsuUFWwDOnOodmStzRVnyZfzrJHk5EhpmBZM8GvDzja2mfBCVULzVOzZCtQKH1I3TRpgZRr8aQT6k9FED5kZaFnhDKsUS1Zov+LR5zdljrP3fbto7OkJC1QQS/jlALC3C6Up3B3E0uWCqGE9trKYqZ8gLnCG6h5B3j8XwuomY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719227478; c=relaxed/simple;
	bh=MeXbAYJEhBVL3PjShFQGm20VmdVIzePkw/davPSfatI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GaisRPmVrAYQGKYlKI4422xoOLC7F+wmMWSbdwbQx5gGMLiWHuBq/7gRogEtP7P2eE9RVkYtiAb2i6t3hHU8otgaYpYP6uCSy3Xctn6aE1/SaK/lly9FSkfUp712t4tRLM58LgtetN7WmkY/Dei3rpW5620HYSYqdUE5WT+fnvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GlqjA9KR; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCkn5X6xx0T/KYDwVbBiC+B7get5X1utiRFtbcqy5MelclD39fNEE2x3hgabUcvgcBd61r3JCs5II+a4haBiFbnoos5Q2FVt0lE6HTPx6Ssk2fxufCS/A0aa630nJU1gcgOfn2tj4krrQUIQe0dxYKksN9FN0Xqz4JgagDKruxZGuxuK9aRfu1CJfxhz41Ula7hl7ynu/uM7EtNWsOzUUYuSqmmBDLHAmmYVNQ3Ks0VfrBmtpMabVx53iNbL3mJWNI1uTLbFzG5EYRVYGkumwqKZSv+RofqBIfv1ktOOhDB1Ck1HLYC0lyuVChOxnjt2UZA5plFYLkgyy8h966rQgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpmeOYSvL/rtN/8yt9CORoSynVsqeDSldmvXtJ8YvnM=;
 b=UDoMUOWkwpiyH2UI5WFWOBj6JSLkbAq1M+tS6dh7mYLwienr+QhH7RgPsvorm8FVJw62ZUvNEiLNtreCKCJkCdQlMWRcni3YNRuMxfR1IfVPVpiNJH40pub8/AdbQ64f5FeqJkDlhwRKsPa6p1bg/lCd5sKl9zDlMgmyt4nJsbrnOixCkby3sIg6TNrzE57TLZxL2uyxLnJXMMmIRo3hsemu69VpNJOwQMCQRqSRZLSt+J9u4a9MJdnpzpkZ82QzNCl1fqhx/lZt4x1MsxQaDAs1sDaF9UoL6eAEHo7ErSPIGJUyxB+5ORyWQt6qv76MmFoQ+sBH2QnSXuW5uJPuKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpmeOYSvL/rtN/8yt9CORoSynVsqeDSldmvXtJ8YvnM=;
 b=GlqjA9KRxEAU6MVvlT9OF/T7H5uG7ysrvWmFZgvQn4p8x0ZsX6VWgjct6Z4ioNoNTs5DVL2vj1pU3UzxzIgEnCHtNnIVgj8S50Nufql9B0xZkBxWrdpQpamKSlYD4liDR2YG1Rk7OLu3cYJZbuZOr4gAw1IUg6fyT4CfLRUAU7A=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by CY8PR12MB7732.namprd12.prod.outlook.com (2603:10b6:930:87::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 11:11:13 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b25:4657:e9:cbc3%7]) with mapi id 15.20.7698.017; Mon, 24 Jun 2024
 11:11:11 +0000
From: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "kw@linux.com" <kw@linux.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Gogada,
 Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH 0/2] Add support for Xilinx XDMA Soft IP as Root Port
Thread-Topic: [PATCH 0/2] Add support for Xilinx XDMA Soft IP as Root Port
Thread-Index: AQHaxibJMuZJsYxVN0i7Hh69+Yt78bHWwhEQ
Date: Mon, 24 Jun 2024 11:11:11 +0000
Message-ID:
 <SN7PR12MB72016D96FDE578C1A9CAE0FC8BD42@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20240624110755.133625-1-thippesw@amd.com>
In-Reply-To: <20240624110755.133625-1-thippesw@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|CY8PR12MB7732:EE_
x-ms-office365-filtering-correlation-id: 4b33f284-dd1f-4d30-6529-08dc943e5b0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TYg9mFW8uZNncipU4rgNt32q/jpug0Xv4WxPg0Mf8aNuefM5MCWxpTSkUd4A?=
 =?us-ascii?Q?2CwucKkwrlcPmPrjcbrzlrlN4jbY4920xqxJhVAACro9TdCfuSkNbaz3BpQB?=
 =?us-ascii?Q?GVAKF8Os/y//HIBzXwEQkQtb4SpwGFZy9BimZtjxOy6KCHoAEQ92OHbnVaDm?=
 =?us-ascii?Q?+5T65u3QwBPO87KtEJUC1joTaZce3XqQGaovnWjd3vuJSX/bFZMd2m/s3fHv?=
 =?us-ascii?Q?QW3CP5suu1DntzfezyApW8jK5myMSuz2cFFNoBzaRyI+wVkGR1TS3wS1/dHt?=
 =?us-ascii?Q?NI7N3pKLo0rxG/IF0+ypfLchqwN/uCWFrSt30MYeFEMIlS8RruZsJcWuFhKG?=
 =?us-ascii?Q?kOjbIB6btmCV79FjV5ZiZVRcDLewsMKa3K9GIVsbOw0SHbpZDoks5t9WZwJi?=
 =?us-ascii?Q?yC3ztB6y5GZR+/B+9hjerlswCBrYX3U+LPCbVyrCRS4CTF8N9/qVHAl87H4N?=
 =?us-ascii?Q?Le3ouZRXYnCG2/MjSWNF6ntxMEDfnn7CD9okY4JJC3sCdFG6uw3NtHbXSHhT?=
 =?us-ascii?Q?7qnN/kE7JSgNbUaPfVd5gyvDPOAI/485Ehgik6nZTPBiOuFjV7nWkQfxF6l1?=
 =?us-ascii?Q?Dw9ZP5nuDavkMzD03IJdsRTxVnSrEdjxOFznr/HPd2rpB8XHyHKQQIAZ/iuk?=
 =?us-ascii?Q?PMOJIoyRrHSdGvHe2wRiH7sNizj9F1lAG1GHRz+qhAT6EZ1vgCsUU8I8E1MU?=
 =?us-ascii?Q?ItH5LpPWu9tHCMe1hcck+3WqT2XL/etutdYuHcbhxaxoZMlBTNofETJ30A3o?=
 =?us-ascii?Q?0hLn7ggO9O/5+UeY+8i1ivVCxuHsYf+/Uv++bnNtgJ72LBG7X9i9ddoygI3O?=
 =?us-ascii?Q?wbaF3Ti65bkEotscV9svmHVSRJK0DNGsknC6H79cENCcnA8jn0e7ZQpufYOH?=
 =?us-ascii?Q?Ruztjx12qBGP2zatHTXdYED/rCCV71S0Nudoo+zu/+L75G306uju4FaEsXrx?=
 =?us-ascii?Q?F4hwWd5dmITAUqdQ9tiKQaPjkGBaJZgC9Q/RY3QPPtsdtq+Sz0y2aZSMde+H?=
 =?us-ascii?Q?+EqSvyDKgLTNrHXfYuzcyNUBnnj4M4nUQk5pM7OFUmj7xpxndh67UiSKc4sK?=
 =?us-ascii?Q?Na84E4aqcTYZmQl69w/hYt9la1B7D/1qDdi+95qLyw60HbRz9X/Oc5g05pkl?=
 =?us-ascii?Q?9IBJeZW2RAjwgE48WwLKYY1ZsbwirX53A0JUVZ43RgNsWng2Bwlp1hK9TtLE?=
 =?us-ascii?Q?qwDuhbvs6bA0dEZnKVGuWLd561aXjPyStSgGOVmLfkLAgWjdObU9N9TwfUuf?=
 =?us-ascii?Q?U22vQKHEs7j6E+qVL6ESKgbMcUoWHsBiRCbypxvXFTBe4RoAPoHV3X3opMOK?=
 =?us-ascii?Q?UYVkYdYEvJs/4O3JCmI2V8RHMx6MJexpXw30WCmTBMiba3cMEiluVHwB3ioE?=
 =?us-ascii?Q?DOQt5No=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dP7wYdchYAWaA6YbbG9R/x2a4X+Y2eZR7YaINt21hMyKq6C98dH1vkNowe75?=
 =?us-ascii?Q?MdSMhVrsLYJoF0GM1KYoY8i43Pqe1Y+mTx04j/qVsJu/NUgVjtR5Tuq3p2xc?=
 =?us-ascii?Q?J81qBkyFgY/Os9Zpp3k7/pKGf0hfgTVmtR4PULX6BGRObMsid97StwPnvnVH?=
 =?us-ascii?Q?xWdFQEcKvhqLuDwF03uqMhUPQTrEOvwXMWDR/estmkXwTg8w8YcchI/fPPOo?=
 =?us-ascii?Q?aoaHY6OAxcikN9rG9Ozo2MTHesN7cbwgxmdq+VnVUYa3zE/lDmIRA+HAvsMB?=
 =?us-ascii?Q?ntSaDpEkKClaCPBi6YxOUSVhz+aePEmWWSpYqCtmhkpVQ7IaDXN7iUWZ2C4+?=
 =?us-ascii?Q?PiP4K/3OVJVj6uMkaUJ50Tv3IEk2FtqEpGjlrn7n0VkCkO9T9y2EvJn/dzA8?=
 =?us-ascii?Q?m5Ff93zFi1zibi6HDDdt3yiJAocjX1/4cR9sOk44B8Kj0aq13jBO8PLafdSd?=
 =?us-ascii?Q?7HCJmD8rIjbvMVQdX/peTE9+3GlZZ0rUoJ9SEaDE/BhroAYv82o8qIjDmWhl?=
 =?us-ascii?Q?FuMPfHvXSVt8Dc26hewdPX+fTyn0h0t7vsfhNy5mk0YOYTkiEmmlaV8QGnc/?=
 =?us-ascii?Q?4OWjks7iOboC5AfBOsSdM6cf8WQRl4SPZ2zrXwxUVrAHa3bt45m0UMfPLFsO?=
 =?us-ascii?Q?4xhNm646kBXwOEJ3JULfHxfdtyHuqkYXo+3H/OwR9zewLnHZrh09tqAGIY3R?=
 =?us-ascii?Q?AtGMl5nXIlxS3BtxcyPl8mPVRdq8aJtMOiuAY75AAGshHZfdyUb+xhhKvuGC?=
 =?us-ascii?Q?q02cvrVRv5MeU5G9oeHVgqKwIzwZ/7yHKgB88SCLu8GE3FSuU3uFavGfn/k0?=
 =?us-ascii?Q?hoGYxPJD5dGO5YzRa3/Toxnwd6rOvZTJl0uGEG56/TGGTQIaBdCz8LJLp4Gz?=
 =?us-ascii?Q?unuXxBEGFhvbuNy2YZ913W7E8DShBr4+fCU+Nl3HCxyJiHw9Z0t2v0do0bFC?=
 =?us-ascii?Q?f37Taxa4GgEECv+TGfluwmis0vdGxuwq+u92mv14zbPRc09/mEGFf62TU0RO?=
 =?us-ascii?Q?5xO1KOLgxGT+n3c3fzd508KYP6PyVBO1fk8oMcWtP0KHXqFNSb3D36TYIaHK?=
 =?us-ascii?Q?nwViab8FH0J3q/rvOzd4FmSIuVg5lxuhCPLVB2eBNL3yWxhC0xqJaGmjM2o+?=
 =?us-ascii?Q?w9RctN2G7xKtHu5oFJ1R9lmU+px70a8R8u++8t60/MejyC7ZakSWLIlIZXiN?=
 =?us-ascii?Q?CEZ4vIG7br4b7smAKwd1kB0Wo1OX1shEyR0kfrvVxskMmO/sYVHljc6fJaye?=
 =?us-ascii?Q?xb8mHze4gbL2AWpQO71tGz4Xt0J2MWSS8SvmdT9rSa71f3yXJz2d+QQfD8Ju?=
 =?us-ascii?Q?ZpL9fq3+ajYAjy00wTNWw9+EUyXmJaLGvT5JEJWJFEQaGlaqWJv8A+x7RuAx?=
 =?us-ascii?Q?sPjnO1RLJrni6ratkn/mTsipSkHUh/sBpixRx7ZOo7nIq9dHSmYhJJqNzdWC?=
 =?us-ascii?Q?Nres0THP91EnMbyAFJc72YX3sGIUtK2hN0p+gP3AIs8ctAqEfGsrpDFIIOcL?=
 =?us-ascii?Q?VFfdaMVHYYUtgZCI9F7h48zjIDORlbda+jEt3hRJsplalLmlUiCXPeKvzK0h?=
 =?us-ascii?Q?4e0x1k48d50DGgKFFYE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b33f284-dd1f-4d30-6529-08dc943e5b0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 11:11:11.5898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wk4kbbrACuvfq4Mg/DDlrJmheiK/5lOE/51QT50HT+eBWJCF/pVwqIy7gJlvgoE6BnN4XFaHenTwnlSsTvQCaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7732

Ignore this patch series

> -----Original Message-----
> From: Thippeswamy Havalige <thippesw@amd.com>
> Sent: Monday, June 24, 2024 4:38 PM
> To: bhelgaas@google.com; kw@linux.com; robh@kernel.org;
> krzk+dt@kernel.org; conor+dt@kernel.org; lpieralisi@kernel.org
> Cc: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Gogada, Bharat Kumar
> <bharat.kumar.gogada@amd.com>; Havalige, Thippeswamy
> <thippeswamy.havalige@amd.com>
> Subject: [PATCH 0/2] Add support for Xilinx XDMA Soft IP as Root Port
>=20
> This series of patch add support for Xilinx QDMA Soft IP as Root Port.
>=20
> The Xilinx QDMA Soft IP support's 32 bit and 64bit BAR's.
> As Root Port it supports MSI and legacy interrupts.
>=20
> Thippeswamy Havalige (2):
>   dt-bindings: PCI: xilinx-xdma: Add schemas for Xilinx QDMA PCIe Root
>     Port Bridge
>   PCI: xilinx-xdma: Add Xilinx QDMA Root Port driver
>=20
>  .../devicetree/bindings/pci/xlnx,xdma-host.yaml    | 41 +++++++++++++++-
>  drivers/pci/controller/pcie-xilinx-dma-pl.c        | 56 ++++++++++++++++=
++++-
> -
>  2 files changed, 92 insertions(+), 5 deletions(-)
>=20
> --
> 1.8.3.1


