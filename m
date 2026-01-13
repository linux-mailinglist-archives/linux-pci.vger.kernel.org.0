Return-Path: <linux-pci+bounces-44573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D1AD164D7
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 03:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CF8C3022A81
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 02:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4E4257848;
	Tue, 13 Jan 2026 02:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="TvTkjzrm"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020081.outbound.protection.outlook.com [52.101.228.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914CA18BC3D;
	Tue, 13 Jan 2026 02:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768271844; cv=fail; b=d3L/VR2aZ0BqClVEiCpFjozJ7hk/T7bj6XZu05mMm/qur2nYIkzHBFETVSwvKocqL2Yx14jOCTWCpLlbJShe7NiTa7Ay5fD8NeNLrKB5qNCW21+43gW34Vcw/dOn7uEpyY4KuHx03NsKLRZL+0Fa5MZ9w43jn96+t17wFw0XChM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768271844; c=relaxed/simple;
	bh=yznU7oeP0B3TpkfKaiqJLBCQZZv47chsHE9T6/nfwMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sydv4WOFIFFzP0ZEYeC27+iZi8zmFaWa9uVImLOnyPeGrbpa2G8HgzoljvsjBOTXUV/pzzdccfR2bou6Xez02Mi52TaJ3xxjWg1M7FdxVFDZCxjBDe9nLnFUXivLmrL6nNsEUeed9TV6+aoCdpMe6mQSxM8GkcHXIN1ue61itdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=TvTkjzrm; arc=fail smtp.client-ip=52.101.228.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ntWOVu6bh9hRSh2UPOq3v+9L5XW1N5mwnT8mnZq4Kwhr0QAKXhVmaTRqBaD8GOlBI57YY5Sw48Fv+foET0bZRDd6RloRDkSB0yqGXCrbW1znXQ/9X45FkPD6fsMyqdvhJvNrL1JutqTc6e+/gIMNM8aC/bg0LP/NUikXI5oALj4OU5JNddbQF+rIDIHfmmV6NYgMyr3zRzbKNlytqcwCSn8XJdOSS6NCnjCbbbSy5nKHo+57WsK+3RTAcUtC5OmpArIGYqABjp8JF6O4TU3wISCpog/jtAze0hkEFwm0O0hKtL0hxVu7li0lXfcDa57qTRJySRjbTKxv5CasQP+lMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRXIqIwsuJBMeivlP/0+QY+PYXeZgOGtLBAtu2rTABE=;
 b=hybXjbdUKspEgN4KXCFA3kivvfPwBuGaur2XnI+iNQ/Kl4f2MAQfjkEGCXKes79R5mM54w9qah4+1dhL0lMPHI6Hnpqyh4LOjU7Xd+bsk8VuqEXx1fRGmr52jziSC4nWYT565R1EjvgiLpChuF/kk+pfCfbOll0PTGvKPdMiVZEWe+2En0DsoUj1qTBXG7CaSODbwRz5j+zsj29ARy04joDr10L6GACPmC0OgTGdg/J8AfBHWA51Zh/Xh0TlMx3s+w8d8AIn0uBeuk3mo+YwGTNYrOr1m1XwUViaF6QYSoXVg02DVUsZTL4hpfgdRKB0UNDZEFCh+PkrARzTmK+P5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRXIqIwsuJBMeivlP/0+QY+PYXeZgOGtLBAtu2rTABE=;
 b=TvTkjzrmIJSiWcbUMKQ6NKl5xlyknq272q5mq1QcT4RrYSNM0kF7nbRPW+OoLE223gdeRoGYi9fbTGSYvnBQJ1zG8z9xa70/v27N+ANANMSw5HYQ16Km0dFjjZPcSKWVgxffNHmrD4gfLOW2F27vRkBCmPGLqjPt/wJ/ilJNVM8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6708.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:323::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 02:37:19 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 02:37:19 +0000
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
Subject: [PATCH v6 1/5] PCI: endpoint: Add BAR subrange mapping support
Date: Tue, 13 Jan 2026 11:37:11 +0900
Message-ID: <20260113023715.3463724-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113023715.3463724-1-den@valinux.co.jp>
References: <20260113023715.3463724-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0177.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::20) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d9263a-2886-4ce2-1102-08de524cac19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mAU3ttSD8LgX/5qQSNJJvwT5BFcF77KW1ER5ejRnZDg3WH7FS+kRCRQ/wUnf?=
 =?us-ascii?Q?4KdbfDe6GnNddHuUPjKUss2TxUGAa23x6fs8XPh0TQ6Hlc11LKDDHEuRskIF?=
 =?us-ascii?Q?IrtoyeiAjTodWfVNFrAU+Uk5nJObpTuEkDrw7tDFUbfyf08weLy3Qi5jC3Gq?=
 =?us-ascii?Q?sm9djuWrgbMYuWXmCAHQ74EVXM0DvH/FgrL8OYfdeuwbinm0fsIBjvvTVYjO?=
 =?us-ascii?Q?sWWw7aSNFcrACl98h82/lvjbS4w9zn1Loc++78r2sE61akWnXCe7aYaa3x2d?=
 =?us-ascii?Q?Q31LqFwGg2fljoKQ4OkXjl52Q3IVDKys0FOHlEuCGve6K0f1LPcnx4P8mZQ7?=
 =?us-ascii?Q?/lH0wHoXm69uRl0CQD8rf3tXVD2vlNH63cCq+NT1hFFv9N5gdnn8lxdFKI45?=
 =?us-ascii?Q?bILXJeKfBWGmU4Rf/QQ5doYmNa+2GhwcQqYQo0fpVlTPBvKNUY/45bzTOqqn?=
 =?us-ascii?Q?uP0XLZSzLwNPlH2k6nYuxHJvvEl48JUw/7oWM9+ohzt5lRaOkyVtj9evxFHR?=
 =?us-ascii?Q?HXqhpXnuxjPOCJpWsXXcwtm2CQZMfyDIVuQYW6SFcnyyoM4yV808TWbB+gqg?=
 =?us-ascii?Q?26eOFd3vg6UPGyD3QmGL03tqrt67uWvoJ381LGc3C1w3kTo61zmnjpLiIaau?=
 =?us-ascii?Q?H8Wqxupk413hWDFlJyg0eso0bJxdl8DIDNRr4FEXJrDAzgCqU6j29c53M/qr?=
 =?us-ascii?Q?WRbbn2y4lS4Y2PehzJTPYj9G27cMckVL7x5GjG+zBK9O0lSsRX3c3RWamsxk?=
 =?us-ascii?Q?EZDiPoEwk7/jKNwlMBjUirV3Zm6xy/PM0NCEzQ0+FUic06la/5UMf/j7CAaH?=
 =?us-ascii?Q?R2mVozCBBWcagqKfVJuGbwPuWy2yLfe43JDj30a5K5DXk04RUGUp3P9NuZoF?=
 =?us-ascii?Q?7uFYk0ixCBAGTMiFOYtg4jTmUv34Pvr8zAu3nqchlB7JWOImLsYUz0uRbfpP?=
 =?us-ascii?Q?LMdxPF6xqQURUR40/vQNVl7MszG6+IVxdisb/uN7kXGJrPYL93adlJzjAkY7?=
 =?us-ascii?Q?2ZmSaEY/33THlQNeubQ6C6CgKEHqmDtMydhmqJGTxtBMpPC+zGeF4UcwkSze?=
 =?us-ascii?Q?I1iU5uOhsqhpjSQytO181l17PNUmgslMnGexTwrFe5xQtaU2S3RwSiQLmJha?=
 =?us-ascii?Q?UZci4YCrFfb+LdrCFTbqiW62Vh8hY6iu8+xlDxGRKBlxKHxWTksqAiTjuQUn?=
 =?us-ascii?Q?OVRq3mSXRdtZlw6tj1eySxnY+fVwiyI65/y5WamfNdgHqhip8NjboGjcnkrr?=
 =?us-ascii?Q?fxiYVxxThR/AKG4tjtJouda0qvXW2N/vJJBmY6HxtQGCeNrLVdf5C8W20+oT?=
 =?us-ascii?Q?DoOnnKnRhZFL3qb2/r1G0LTj7inBaHVVewCd3SbMBBwHSC+1u3ndhDrM+LAo?=
 =?us-ascii?Q?ikmo3DcAVc2Yu1hO/EOTOZshZLl6p1vc67/Fg1ui9lFKA62nyi7dqd0C+r8T?=
 =?us-ascii?Q?iOzqXot8LCx3NUzIqHJWLuQSUyHlvs4G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hm+/UusB2SK3geFpaiDWldH8jCUjCZlMgopsl2U6ejqTaVJ0Bs5iwzT081oJ?=
 =?us-ascii?Q?iBhU7hOUsSKzJG1JjE/yDmA+U8aUScilNuYS5oZX/zXeYREGUbHccL8/L3Z7?=
 =?us-ascii?Q?JR8G1b8eN5s24v8hA9UxSeYLrYnWpO2v9FPzC0dYWJG+JjTRMv/Uag4zgVO4?=
 =?us-ascii?Q?Wy4dKtaJKGVq2OHYKcP7dHqeL5UgB44Gl8zK7eSGMlskp4kP8y8dJr+Gv/bL?=
 =?us-ascii?Q?sDmuy0gJXx1WgWguG2WOwmEwbiGd8/0xV8ZTURxysLsWsJReaV4zUVfGofXy?=
 =?us-ascii?Q?jWRzAjdkhnjwS6WYs/R7BRv0z3LmuxFkOzzGEN+4yHvkOZ46jXw9zuDbMfcr?=
 =?us-ascii?Q?jguqj7Ya+EYBpvvyxodrWyAMRSCPqvw2vGa6ThsKz/1thbJBRRNhsKoxj5vU?=
 =?us-ascii?Q?5dDBSpkwiCFshf3YjO0p4hpyoBpQj1haFksuweww+Vt2kG226vWvVDMkN/Ah?=
 =?us-ascii?Q?qZqUcKHAvcNvq+2FHP05aE7WTK9itDWMuZgrI36ACP/1JlWiGyH3qRYeJ7f4?=
 =?us-ascii?Q?25TBRfMO2LOctvn8g/s9V2oE5hu+oXaR9xV7ATZJarVVbiIvXOPlx5MTE0sG?=
 =?us-ascii?Q?QlPInpng7l7p1r1P2PR/Nij8hp8R8f4CFi/K+NYfm0IlOBT4flyRlqSVKJL0?=
 =?us-ascii?Q?VI+zROorZntpt0+u/tuNQpnY+dAXijlGlgv+RzjaJ7YCiAaZKU1hUoHmnn2N?=
 =?us-ascii?Q?CQWrkfKscyFQLihg9j19FiPVlxJq3CeXoWUFgjR16x/Op8xDdfWXq/4b/YQ1?=
 =?us-ascii?Q?xHmkvY8VR8gPdWX90og5/XsSEgUEmmwm9Xf8F0Bi7NmckPQBsFoYRAa7iWWR?=
 =?us-ascii?Q?GoGA0v4HGzT71Gv7o8nOUVgB1Qg7I1p+csym/teSZMxBa1hNOhcqhiH6IBl6?=
 =?us-ascii?Q?4KyMlgen2kNfS4Cnvr0HOqvi8QLjStElESDDl03c3Z01cLRpu//J7CKfbctV?=
 =?us-ascii?Q?lFsl3crCTj4734tJCD8JH7TCAkPoxqc/7qpQZGeEHoJw9WiXihblc/yXveyZ?=
 =?us-ascii?Q?zzeE4t1x9I0POp7Y4ZAibfHm+8Tr+EGpVA3o3HKswwvgAf/KnfRmaEtdLcn5?=
 =?us-ascii?Q?ETDn//DO++bXIuiYvy7LlIxnZ2OqOsd1FXdpGB+MXDUiz7atYOSmc0ZTnp9m?=
 =?us-ascii?Q?tub6KCC7BByUFjgdcWf71qS6GY+eM0XSnEbk5N2fugdNhi/ig/Lm7KbIrqG+?=
 =?us-ascii?Q?k6m44UNRQhR/4sRpMjwS5KwdY8XyRNmL0XYKenEtdqQXlNzpn+3xXN8Mr75e?=
 =?us-ascii?Q?gtVPr99O3hRZHJxiFxN7fqcxXPZtZGU83936jL/QaoiMWYV7N2u1nLngIm6C?=
 =?us-ascii?Q?s1Rylx4bkpCkNLRHwj+StxI0CztTRuyMEW8ZF4qAtLrL0n+QaPCwy5u16K8C?=
 =?us-ascii?Q?R0R5nIB6u8w7pLHks7k/QmfsDcXn/Kb4bQxbReLRXvDlktKvQ5evY6qChZy/?=
 =?us-ascii?Q?AwohNlToVRGOjpI3xY/9sOufQI4r3XVtZchFEZcYZtPBRKL5UdnB36QY/0OB?=
 =?us-ascii?Q?uUv8w0BZ7qhmbmwvhIWaudgjOGKyf/dkwV91Oq+jphwR3wV8LMbQA2H+asHw?=
 =?us-ascii?Q?Q8D6jmyQj2appCGgUXchTqOWPT+J3ZIL9pQXdu79O27C2Xb1/2w2MERWk7bo?=
 =?us-ascii?Q?nI0Ip0Zv6fiKCV9fAfu+NQBfwNKy/hNosVFAEBgRRQzvaLlyzq/Ahk44xbwD?=
 =?us-ascii?Q?tGmiyfed52fAqrS/CxGE9i3gMZHgucZHTnsqpLjZE7kWSo1d9Xor0ZmKZ+9D?=
 =?us-ascii?Q?QNqSp4xCjTwg4Mo6KzhaUzQ/dwP2ILPtTru3QmNA1FEvHkvuSMPH?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d9263a-2886-4ce2-1102-08de524cac19
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 02:37:19.2169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BsPXhAcigLAx6TzNLHb1OTJEwSWwG3HZennNPO3HE2/KnEDnVDTeelBx41h61GOc+kP29mSOnwvThvQGifSTKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6708

Extend the PCI endpoint core to support mapping subranges within a BAR.
Introduce a new 'submap' field and a 'use_submap' flag in struct
pci_epf_bar so an endpoint function driver can request inbound mappings
that fully cover the BAR.

Add a subrange_mapping feature bit to struct pci_epc_features so EPC
drivers can explicitly advertise support. Make pci_epc_set_bar() reject
use_submap requests (-EINVAL) when the EPC does not advertise
subrange_mapping, to avoid silently accepting a configuration that the
controller cannot implement.

The submap array describes the complete BAR layout (no overlaps and no
gaps are allowed to avoid exposing untranslated address ranges). This
provides the generic infrastructure needed to map multiple logical
regions into a single BAR at different offsets, without assuming a
controller-specific inbound address translation mechanism. Also, the
array must be sorted in ascending order by offset.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/pci-epc-core.c |  3 +++
 include/linux/pci-epc.h             |  3 +++
 include/linux/pci-epf.h             | 31 +++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index ca7f19cc973a..8d809a2c3ce9 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -596,6 +596,9 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	if (!epc_features)
 		return -EINVAL;
 
+	if (epf_bar->use_submap && !epc_features->subrange_mapping)
+		return -EINVAL;
+
 	if (epc_features->bar[bar].type == BAR_RESIZABLE &&
 	    (epf_bar->size < SZ_1M || (u64)epf_bar->size > (SZ_128G * 1024)))
 		return -EINVAL;
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 4286bfdbfdfa..898a29e7d6f7 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -223,6 +223,8 @@ struct pci_epc_bar_desc {
 /**
  * struct pci_epc_features - features supported by a EPC device per function
  * @linkup_notifier: indicate if the EPC device can notify EPF driver on link up
+ * @subrange_mapping: indicate if the EPC device can map inbound subranges for a
+ *                    BAR
  * @msi_capable: indicate if the endpoint function has MSI capability
  * @msix_capable: indicate if the endpoint function has MSI-X capability
  * @intx_capable: indicate if the endpoint can raise INTx interrupts
@@ -231,6 +233,7 @@ struct pci_epc_bar_desc {
  */
 struct pci_epc_features {
 	unsigned int	linkup_notifier : 1;
+	unsigned int	subrange_mapping : 1;
 	unsigned int	msi_capable : 1;
 	unsigned int	msix_capable : 1;
 	unsigned int	intx_capable : 1;
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 48f68c4dcfa5..91f2e3489cda 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -110,6 +110,28 @@ struct pci_epf_driver {
 
 #define to_pci_epf_driver(drv) container_of_const((drv), struct pci_epf_driver, driver)
 
+/**
+ * struct pci_epf_bar_submap - BAR subrange for inbound mapping
+ * @phys_addr: target physical/DMA address for this subrange
+ * @size: the size of the subrange to be mapped
+ * @offset: byte offset within the BAR base
+ *
+ * When pci_epf_bar.use_submap is set, pci_epf_bar.submap describes the
+ * complete BAR layout. This allows an EPC driver to program multiple
+ * inbound translation windows for a single BAR when supported by the
+ * controller.
+ *
+ * Note that the subranges:
+ * - must be non-overlapping
+ * - must exactly cover the BAR (i.e. no holes)
+ * - must be sorted (in ascending order by offset)
+ */
+struct pci_epf_bar_submap {
+	dma_addr_t	phys_addr;
+	size_t		size;
+	size_t		offset;
+};
+
 /**
  * struct pci_epf_bar - represents the BAR of EPF device
  * @phys_addr: physical address that should be mapped to the BAR
@@ -119,6 +141,10 @@ struct pci_epf_driver {
  *            requirement
  * @barno: BAR number
  * @flags: flags that are set for the BAR
+ * @use_submap: set true to request subrange mappings within this BAR
+ * @num_submap: number of entries in @submap
+ * @submap: array of subrange descriptors allocated by the caller. See
+ *          struct pci_epf_bar_submap for the restrictions in detail.
  */
 struct pci_epf_bar {
 	dma_addr_t	phys_addr;
@@ -127,6 +153,11 @@ struct pci_epf_bar {
 	size_t		mem_size;
 	enum pci_barno	barno;
 	int		flags;
+
+	/* Optional sub-range mapping */
+	bool		use_submap;
+	unsigned int	num_submap;
+	struct pci_epf_bar_submap	*submap;
 };
 
 /**
-- 
2.51.0


