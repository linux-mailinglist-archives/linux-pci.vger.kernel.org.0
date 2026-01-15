Return-Path: <linux-pci+bounces-44916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D07ED234B8
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 09:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B25D730B470F
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 08:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372B733E36C;
	Thu, 15 Jan 2026 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="f9R9tFGd"
X-Original-To: linux-pci@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021104.outbound.protection.outlook.com [52.101.125.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4283233EAE3;
	Thu, 15 Jan 2026 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768467025; cv=fail; b=KfcuJ5oXy8Zx0Xbu63I4kG252Gin1huPTdjSrU7fdRSLsMT3GuX4x92factDN1Q8CuA9pyTm6BsrTWD4pwdgt9954Mh+xg13khgUyPOmg+wuFyVLDakbIpdv1kcN4bLS8mqxWecfQs+jw6/50Bi08RVvYGMefnGA+LuwfuR7seE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768467025; c=relaxed/simple;
	bh=RXj90i/nmLm6RENuHeW6gf+Fb5VCEv5Wng/d1nHHFng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VCJ5MeJ2YPAxX3b/UJjbTC7DmPeZAjuL4+OPATlGRyKd9C20yfgJ2oXloAksMUb5MiDmulmmvKdlgP1RzCU/YcHJQHgv9jGAHzZ/lyxUlEZWBvGlSVNFH7+ydNRH8x4sitY2lnu93qZDm+kryDTr70hK20KB0ceU8jSUbnOnmNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=f9R9tFGd; arc=fail smtp.client-ip=52.101.125.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9qCmW1Expr2hw1STh4gYgEsh2ZAFj3ub1kgCD1m9TM9y1Cgav91hlcLN7dNJbQjXU+P4rZRaACQgP+48M4fBPwGAS88nrRjMr+lYFR3UTTBX3Bt/NraTFAeLfdEwzHoAzSuU7Y4DcMaR7puVHegMW3x93ogiJj/jNfeV0AgJwbxuROI7cVWYDqLWApeWxXcpy4rj0OonwnonJToEZYNbXrG48nAHqdnGH0y1dC9hKF74rMqrx4g3KByQyhZbz3q6YlzqJGfQ2qFmqEfxMbdYOeBhY3CVPocWb7Y+teLgaW95q1nIyTw2XD0FSnA3Z3yuMB9txALx1NVr0DW5jL1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kl1zeJIx2S0Nes1d8T+FijFSvtv9+MdEhnTKtCr4DDs=;
 b=XtQe3WLopP9Ukr43qQGskJd24vyoyPZGbM5ZPagCIEXqM+274iK38N9HBgb6T9cFilAaLGo+dy5iONJi0g3GbZod7gzD4S318Ji4PtC+YM1E1eegqJEzynEmMfeKgfnIZzvdmFtZm49ntM0sIUzpw9splF73dyQ7Tw5CRu6I9GgcyEo2KNzzv7SC3w+OhkUyMvkgtZlmRxwd8x3QIDIIeaWmQqzNYmWNqKe9/GnHIIuF+S0hNSltN3nLSIRJK08qovRk4cWMcu6nOh6Hq9vJ8o0CDGKRAysPCAW7d8nHY4bDHu8DJ8cAL1QSmbESCMfcBw7N/Kyqw1meW/2PnuBsAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kl1zeJIx2S0Nes1d8T+FijFSvtv9+MdEhnTKtCr4DDs=;
 b=f9R9tFGdRJFVTCLfOjEHtJBpvwprADHU96u3XyiuTU87wnzSCHuFLdwNDnq8VkskthyljhyqjOhQtJQkp7RTw7fEPOBurDGdJEUoQBLl5hZixKDstRwcf6uH/RUGkUDpQxHxKFmbd3wkXlLPae48T2KMlOp5nJRAGlY2vSloRas=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB4454.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 08:49:58 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 08:49:58 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	cassel@kernel.org
Cc: vigneshr@ti.com,
	s-vadapalli@ti.com,
	hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	minghuan.Lian@nxp.com,
	mingkai.hu@nxp.com,
	roy.zang@nxp.com,
	jesper.nilsson@axis.com,
	heiko@sntech.de,
	srikanth.thokala@intel.com,
	marek.vasut+renesas@gmail.com,
	yoshihiro.shimoda.uh@renesas.com,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	christian.bruel@foss.st.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	hayashi.kunihiko@socionext.com,
	mhiramat@kernel.org,
	kishon@kernel.org,
	jirislaby@kernel.org,
	rongqianfeng@vivo.com,
	18255117159@163.com,
	shawn.lin@rock-chips.com,
	nicolas.frattaroli@collabora.com,
	linux.amoon@gmail.com,
	vidyas@nvidia.com,
	Frank.Li@nxp.com,
	linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@axis.com,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-tegra@vger.kernel.org
Subject: [PATCH v8 3/5] PCI: dwc: Advertise dynamic inbound mapping support
Date: Thu, 15 Jan 2026 17:49:26 +0900
Message-ID: <20260115084928.55701-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260115084928.55701-1-den@valinux.co.jp>
References: <20260115084928.55701-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0068.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: dad079c3-8282-4646-b15b-08de54130fc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X6cNAIhidOMb+5r4wKVn+sL/df6cEPeEdGDe/ZbbnUH1eVFEcFDgWK2DRSXX?=
 =?us-ascii?Q?twRlRE5cyymmvJ26s+iMeOKbFmdqdB7kILIuj1/v5AYsRDwXVy6UTmeQ0pfs?=
 =?us-ascii?Q?TVvUA8wTH8I+461YndhZIK8VF174TBcDttf8nqo1CYKeWQ7z5GRepiqMCUt+?=
 =?us-ascii?Q?erXRIDQCdvS0X8Iqrj2YfIZB1FM45knnTCUgvXBo7tl02+awpZijEn3gtHRL?=
 =?us-ascii?Q?Jskp5IM5x3Vg6qjqXnDtZ5/oQwY5mWMKH/Tzp/PRH8vs3wzb8hHb6L2hAXNo?=
 =?us-ascii?Q?zaiDJ5YWEf15TPn7WMR/xSD1tf+fIz497nV0jBp0fYtB9qt9G8wRatdTrHBg?=
 =?us-ascii?Q?TN+IfjqWjQ7+vpFVGdrihPU8Sb/ten/dYZzgGE4FWm9MAor/H4a1sUdposge?=
 =?us-ascii?Q?DPtP1XVp7OwI4PoBc+ihzxJAPXPZ16/yH7tfM8umNiye5AoSOonnUbJtmp3K?=
 =?us-ascii?Q?dAcA0DI0Go8nuwvEKORZ3oE+2mgarh5XAK2KRTBEjEiz9twCk2NFeJZxWTdn?=
 =?us-ascii?Q?eculEXXAaE7HBoDwZCZE/7Rbqky1msNUnk21UpKjnU0jkNrkmbn58x7RjULa?=
 =?us-ascii?Q?/J++ofkBE93PC3U7j7tBUlCB6uAi4zRr1m3ozvCa7BY8xF2RLqS0QNx/W9xX?=
 =?us-ascii?Q?dNkN/2aCKb0Y1Gjt9O8qCEsgDd0i+jkDOqdi7bqcuGLU3AgY0XxBXhch8Yiu?=
 =?us-ascii?Q?0Cmkko4Bdyz3pYc6dyU7UtHP2f44JZsYk1smd9nbCAIBT9ir6zlz+9yJ7xe5?=
 =?us-ascii?Q?hiChxD0fuFNZb0sGHogRS8BglX/E467uJf+I98XFUGtPQxQ6jdkW9QfXblPQ?=
 =?us-ascii?Q?RJHlAiXGzzycpjRZ2ebD8Qax42C/DYs4SYB51kykHf2f+bhLxHhSssF83PKK?=
 =?us-ascii?Q?DSC9HwBIHIIZwVw3k42oNWtsjOqBVEbXBNhy+gXqmQvGNlUqg35T8zIkkSEo?=
 =?us-ascii?Q?zfNEcJ8Aar/NWhaR4Z5hv5cZD3kXF3zbp/zBEX1dqTm4+nohZChGrlhH/sB0?=
 =?us-ascii?Q?PLgHdq7BtHe41759kT/WxfjJbDqUMDxSvrHvXxER6T2LMjG6DLB4rvoYARiG?=
 =?us-ascii?Q?t3SNwE9aX8hxS6txLdEeI/HVQ4K14V1gGyz4y1dbPp1o5Dd2stu5QEqjasWe?=
 =?us-ascii?Q?FIfW8F3hCdBz2Meit0TrLRdNfNkC4EH+NtIAlB0wGW/Isg8TIVRC8SQ90DVR?=
 =?us-ascii?Q?sDJXpsN+4a+9HOwMl57AOnrQabkdvYrL/FZTXOQ3Kr9Wi17TKem2bMs+r1QJ?=
 =?us-ascii?Q?AIzWcgAaxbrIvK5XTm2oLcvht7jcxiAus0EN7FwUX1FvQXnoYRUiHXKnprbK?=
 =?us-ascii?Q?aVJbg6Lu9ccvFXP39d2RtVX24y+LN/NoJ9+tvwYPgyPNKG09UKXQf85NAvLf?=
 =?us-ascii?Q?FYn3sOSd/MyOELfqzyYu4bvGDTN7PRO6bJfkyCslBO1GdB4+Ky4C0M4L06kM?=
 =?us-ascii?Q?VGDlgZSktgN+myznVbdFYWyyBBLloQH5A3tdIGBQdP/Lv48Di0qomhYbjQI0?=
 =?us-ascii?Q?fg+FH1dQjF+GpJPEMROKMg9i8R29llZosT5IsEfL73hM+VHyZjjum1iJ44th?=
 =?us-ascii?Q?dFu/j4YdM+/v2fbx/tE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PSnfSyaO85QhHOayOgE9cBHUUJVnS4vHwhIm6t3dyHDcm1/sZOTTCqrdtD4e?=
 =?us-ascii?Q?/WiVyxv7lllOT2UaEfe/2Vd4juO7S578uELEWPiqZ72ZZJo1vrJN3mYFKJWI?=
 =?us-ascii?Q?GmrzP6L1l1ErXC94tipO7z/MFJ+6120/WKX3x/cJVpi2pg3bAYhSt2qRvpBX?=
 =?us-ascii?Q?gXLxKXSswt//3kQPEhxMwmuKnB0R8P/uMqDviGsVVPlTuExNr9X65xWVTklH?=
 =?us-ascii?Q?mPayxycu7Wit9vc812cRSyxmXoqhIIIxX0jGSHrsaA5JQKu4oL8tf3v0Z5gj?=
 =?us-ascii?Q?Qskodu81e7gtRvmpafBLXri+5umiEEUKAqb7nbydZF3bMTG+h9bP9AF/kuWO?=
 =?us-ascii?Q?/QNJooDG4hjiBt+dY+FsSWsCTh1IPJdGiPBvC06lK6bsAFe8zB4NO5cjL6kQ?=
 =?us-ascii?Q?dQ4XeTxvv18Nsm8QvRw9y4e/7VeetBPnht7UNj0kSnnwMoOR+BAsYYnmQVQ7?=
 =?us-ascii?Q?nbpqMHxioSwBNOJTVTzwBr+1N6Ms0itTodsxXWcK1oODssB6MyVTINtu3Iv8?=
 =?us-ascii?Q?9I/bMRM1ecK9NnLSs2uqTCH1hs70uVY94rxEWGt+Zlj3F5g2ST16G86pf3hv?=
 =?us-ascii?Q?wAoDghdZg/MCD0WgKM/NnyGkBwk/bzyDjJxx6sf8c4syNiqdO5tEOYMKhZIC?=
 =?us-ascii?Q?hVFbzIpXlraclOcnAb9DEPCWny1fo5SBNSs57bVH/a00AOy9trmBb/6HrhOw?=
 =?us-ascii?Q?JM16PT8XDZbYd5jgVd7frUKYoGbyS0YNMwIdmjY1AcW0RfH9zHgDQELX9bx8?=
 =?us-ascii?Q?iioYp/rOhdrQz/vyvk7Fx84rlF/hM2mpMPvlAlUortHlJVmUVxOJrIHT2B7x?=
 =?us-ascii?Q?FtrOI9Uf/vvUAqURO0zPc0s522qw6P/jBhrik86d+E52AimtiZTXPle3jnaO?=
 =?us-ascii?Q?YneLKajIDZGh6Ju3Uil0hNjH7UYrwDP3+fwYcHNUyNx+2Nas9VUbYhDAsf1a?=
 =?us-ascii?Q?bAfRK9nrp9pdaLqVYWsJ6YYIHgtal8osUwi8ejoPhpiGjSTweDHtXeAUPs5j?=
 =?us-ascii?Q?IgY0vOdbf7FVs2UeSMfJvKz8S60EsVHr9pBKF81cHPGRdXJ7gRREGPYtPKWM?=
 =?us-ascii?Q?vOFDbfwLCG33Kr43QHGwWdDbQ0t4Qd9hRSiqikLdQr7mzI8gO/dPjDQqTH6h?=
 =?us-ascii?Q?UdymQeA47kqkWNtSul4d1stHzNm9NJdnTrXerK9VTe4wPGcaovn3NxK3CYLU?=
 =?us-ascii?Q?0d2ZHsu3oizSxEBPDrKfEYTdWCu31kSR08Eu1gV+Utzwx20jvQMK6dcaSsUS?=
 =?us-ascii?Q?IenjmKVKGeHkgWP8DQZ9GJAlHpnfsaXjDpIDX1ilZugRJ3UBKZO195lPX+dW?=
 =?us-ascii?Q?LrhhqoHeE6xJd/hugrqnh5SEF0lvMsE6Mbx6m80lv/O6XppSR6GTW9r6N96H?=
 =?us-ascii?Q?YPYTWGM78bW0ez9FQPZHCm3jplykfoiBUbgmppjDb8Jvgr8awweOG6bbea7D?=
 =?us-ascii?Q?igUlZnwagSurGAkEfrLIwnx0Mk8VnsEgnif7QGqUspAdDkS2tAgBlZ447E+A?=
 =?us-ascii?Q?ZMZMPp3XTPRu99E2T479mgEVAQMDSqOEr5yIu7IAL5nkTYF8RJBjZY3rWcJl?=
 =?us-ascii?Q?rWMd/OVWr92bqfnghsnQY0PaPrCr0aDoXqDnZwro2qvtIyh4Sols9b2Iu+iV?=
 =?us-ascii?Q?B/wCOooRq4Y0+FjePeEFfycZH5Y9SnJoHNdwRpaPMIYPM0PC6FoMjw35+bIu?=
 =?us-ascii?Q?dnBnYN8pVW1A8UBxcmm/ZnH5tHfcYMFTyEhCvYA5Z3u/9M/vwS10QVe/a6ss?=
 =?us-ascii?Q?FSsmaEzBOMJEnszwzeH3dxozW72/ZeyJmaZT0P+HF5zmXvqNQjVA?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: dad079c3-8282-4646-b15b-08de54130fc2
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 08:49:57.9498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ab5jPsyaeVO+B+KsH84Gu/DY/ShcCRxxSBIpXaX62yAOe55usWvSCsHKOTg7rDo09GonjfxNyONmokhdA40Pdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB4454

The DesignWare EP core has supported updating the inbound iATU mapping
for an already configured BAR (i.e. allowing pci_epc_set_bar() to be
called again without a prior pci_epc_clear_bar()) since commit
4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update
inbound map address").

Now that this capability is exposed via the dynamic_inbound_mapping EPC
feature bit, set it for DWC-based EP glue drivers using a common
initializer macro to avoid duplicating the same flag in each driver.

Note that pci-layerscape-ep.c is untouched. It currently constructs the
feature struct dynamically in ls_pcie_ep_init(). Once converted to a
static feature definition, it will use DWC_EPC_COMMON_FEATURES as well.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/controller/dwc/pci-dra7xx.c           | 1 +
 drivers/pci/controller/dwc/pci-imx6.c             | 3 +++
 drivers/pci/controller/dwc/pci-keystone.c         | 1 +
 drivers/pci/controller/dwc/pcie-artpec6.c         | 1 +
 drivers/pci/controller/dwc/pcie-designware-plat.c | 1 +
 drivers/pci/controller/dwc/pcie-designware.h      | 3 +++
 drivers/pci/controller/dwc/pcie-dw-rockchip.c     | 2 ++
 drivers/pci/controller/dwc/pcie-keembay.c         | 1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c         | 1 +
 drivers/pci/controller/dwc/pcie-rcar-gen4.c       | 1 +
 drivers/pci/controller/dwc/pcie-stm32-ep.c        | 1 +
 drivers/pci/controller/dwc/pcie-tegra194.c        | 1 +
 drivers/pci/controller/dwc/pcie-uniphier-ep.c     | 2 ++
 13 files changed, 19 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 01cfd9aeb0b8..d5d26229063f 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -424,6 +424,7 @@ static int dra7xx_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 }
 
 static const struct pci_epc_features dra7xx_pcie_epc_features = {
+	DWC_EPC_COMMON_FEATURES,
 	.linkup_notifier = true,
 	.msi_capable = true,
 };
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 4668fc9648bf..f28e335bbbfa 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1387,6 +1387,7 @@ static int imx_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 }
 
 static const struct pci_epc_features imx8m_pcie_epc_features = {
+	DWC_EPC_COMMON_FEATURES,
 	.msi_capable = true,
 	.bar[BAR_1] = { .type = BAR_RESERVED, },
 	.bar[BAR_3] = { .type = BAR_RESERVED, },
@@ -1396,6 +1397,7 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
 };
 
 static const struct pci_epc_features imx8q_pcie_epc_features = {
+	DWC_EPC_COMMON_FEATURES,
 	.msi_capable = true,
 	.bar[BAR_1] = { .type = BAR_RESERVED, },
 	.bar[BAR_3] = { .type = BAR_RESERVED, },
@@ -1416,6 +1418,7 @@ static const struct pci_epc_features imx8q_pcie_epc_features = {
  * BAR5	| Enable   | 32-bit  | 64 KB   | Programmable Size
  */
 static const struct pci_epc_features imx95_pcie_epc_features = {
+	DWC_EPC_COMMON_FEATURES,
 	.msi_capable = true,
 	.bar[BAR_1] = { .type = BAR_FIXED, .fixed_size = SZ_64K, },
 	.align = SZ_4K,
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index f86d9111f863..20fa4dadb82a 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -930,6 +930,7 @@ static int ks_pcie_am654_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 }
 
 static const struct pci_epc_features ks_pcie_am654_epc_features = {
+	DWC_EPC_COMMON_FEATURES,
 	.msi_capable = true,
 	.msix_capable = true,
 	.bar[BAR_0] = { .type = BAR_RESERVED, },
diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index f4a136ee2daf..e994b75986c3 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -370,6 +370,7 @@ static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 }
 
 static const struct pci_epc_features artpec6_pcie_epc_features = {
+	DWC_EPC_COMMON_FEATURES,
 	.msi_capable = true,
 };
 
diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index 12f41886c65d..8530746ec5cb 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -61,6 +61,7 @@ static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 }
 
 static const struct pci_epc_features dw_plat_pcie_epc_features = {
+	DWC_EPC_COMMON_FEATURES,
 	.msi_capable = true,
 	.msix_capable = true,
 };
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f87c67a7a482..4df0cc44faab 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -305,6 +305,9 @@
 /* Default eDMA LLP memory size */
 #define DMA_LLP_MEM_SIZE		PAGE_SIZE
 
+/* Common struct pci_epc_feature bits among DWC EP glue drivers */
+#define DWC_EPC_COMMON_FEATURES		.dynamic_inbound_mapping = true
+
 struct dw_pcie;
 struct dw_pcie_rp;
 struct dw_pcie_ep;
diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 352f513ebf03..f985a934a137 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -384,6 +384,7 @@ static int rockchip_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 }
 
 static const struct pci_epc_features rockchip_pcie_epc_features_rk3568 = {
+	DWC_EPC_COMMON_FEATURES,
 	.linkup_notifier = true,
 	.msi_capable = true,
 	.msix_capable = true,
@@ -404,6 +405,7 @@ static const struct pci_epc_features rockchip_pcie_epc_features_rk3568 = {
  * BARs) would be overwritten, resulting in (all other BARs) no longer working.
  */
 static const struct pci_epc_features rockchip_pcie_epc_features_rk3588 = {
+	DWC_EPC_COMMON_FEATURES,
 	.linkup_notifier = true,
 	.msi_capable = true,
 	.msix_capable = true,
diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
index 60e74ac782af..2666a9c3d67e 100644
--- a/drivers/pci/controller/dwc/pcie-keembay.c
+++ b/drivers/pci/controller/dwc/pcie-keembay.c
@@ -309,6 +309,7 @@ static int keembay_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 }
 
 static const struct pci_epc_features keembay_pcie_epc_features = {
+	DWC_EPC_COMMON_FEATURES,
 	.msi_capable		= true,
 	.msix_capable		= true,
 	.bar[BAR_0]		= { .only_64bit = true, },
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index f1bc0ac81a92..5e990c7a5879 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -820,6 +820,7 @@ static void qcom_pcie_ep_init_debugfs(struct qcom_pcie_ep *pcie_ep)
 }
 
 static const struct pci_epc_features qcom_pcie_epc_features = {
+	DWC_EPC_COMMON_FEATURES,
 	.linkup_notifier = true,
 	.msi_capable = true,
 	.align = SZ_4K,
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 80778917d2dd..a6912e85e4dd 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -420,6 +420,7 @@ static int rcar_gen4_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 }
 
 static const struct pci_epc_features rcar_gen4_pcie_epc_features = {
+	DWC_EPC_COMMON_FEATURES,
 	.msi_capable = true,
 	.bar[BAR_1] = { .type = BAR_RESERVED, },
 	.bar[BAR_3] = { .type = BAR_RESERVED, },
diff --git a/drivers/pci/controller/dwc/pcie-stm32-ep.c b/drivers/pci/controller/dwc/pcie-stm32-ep.c
index 2cecf32d2b0f..c1944b40ce02 100644
--- a/drivers/pci/controller/dwc/pcie-stm32-ep.c
+++ b/drivers/pci/controller/dwc/pcie-stm32-ep.c
@@ -70,6 +70,7 @@ static int stm32_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 }
 
 static const struct pci_epc_features stm32_pcie_epc_features = {
+	DWC_EPC_COMMON_FEATURES,
 	.msi_capable = true,
 	.align = SZ_64K,
 };
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 0ddeef70726d..06571d806ab3 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1988,6 +1988,7 @@ static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 }
 
 static const struct pci_epc_features tegra_pcie_epc_features = {
+	DWC_EPC_COMMON_FEATURES,
 	.linkup_notifier = true,
 	.msi_capable = true,
 	.bar[BAR_0] = { .type = BAR_FIXED, .fixed_size = SZ_1M,
diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
index d6e73811216e..d52753060970 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
@@ -420,6 +420,7 @@ static const struct uniphier_pcie_ep_soc_data uniphier_pro5_data = {
 	.init = uniphier_pcie_pro5_init_ep,
 	.wait = NULL,
 	.features = {
+		DWC_EPC_COMMON_FEATURES,
 		.linkup_notifier = false,
 		.msi_capable = true,
 		.msix_capable = false,
@@ -438,6 +439,7 @@ static const struct uniphier_pcie_ep_soc_data uniphier_nx1_data = {
 	.init = uniphier_pcie_nx1_init_ep,
 	.wait = uniphier_pcie_nx1_wait_ep,
 	.features = {
+		DWC_EPC_COMMON_FEATURES,
 		.linkup_notifier = false,
 		.msi_capable = true,
 		.msix_capable = false,
-- 
2.51.0


