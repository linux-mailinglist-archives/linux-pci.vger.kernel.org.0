Return-Path: <linux-pci+bounces-14583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6239B99F725
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 21:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CF70B23897
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 19:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD3820103E;
	Tue, 15 Oct 2024 19:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ig9KZhvo"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2058.outbound.protection.outlook.com [40.107.105.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B9D1B6CE1;
	Tue, 15 Oct 2024 19:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019879; cv=fail; b=o9xuspSOB/VKwz0WAxYO7uyBabrPJi0w+7ldpR6CR4s7LxHdjvqOFgm9EyF7+3JeUOPMr0Ygwp/9bh4XpxXv9H6BbEwQYNT6PpIehyl1p3ceq5iJgwdWvzocxYRAkoq9xMVRnVGwiHEcRw7Gi7jrMhM+DCHQ4IkNe6gRCch/D1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019879; c=relaxed/simple;
	bh=Xur3w88Prm2U9ti80meGJLxIu6InmfTZAzjgILmrVU0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RYp1LTQ2ARjOhQUgWCgkvJhtNbzWdYb4irhVZI8g01PMCwr/kPNanqeDGMGeKrGm9O4ouRCPHxS6XwowbeZfxhJp6L/MMpM/d6t8Y63RSqEQUGOZd0sMuO7qHFDej7ShQ0qnqsxMJXGaXaFvUQbhQpjJRLUTitMXqytB2FJ01f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ig9KZhvo; arc=fail smtp.client-ip=40.107.105.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjKX9s4C8O+HNEZVFwkQz/zBdXvgt/lmg0b+rWZ+gvgubkNFw4BcvB+Y0h0B72rJSPBG4wCOFNAedvvVj3CZF7C5b7Qo0D3HJ/oQDBN7ffeW7gAYFWaXJvLSBsDTZiJFgDreXUJDUNFc4vWrKrdINpiIB1VYC0SLwEQJBfhYzyLAHpv+66qiRXeP7NJjOshrHQNKecwCBa1DJZnrpvHvtd6XLNWXBkW4gdeKeyAPDdBSwinMrKict7BjVD6vGLf5AD889RESxfTWKKSgm25SPkCOxKeA+bbEJ+jgVdSmMMeekJW1r+LrlsX1q5cc1YgyMq5dnRYh3TVEkeYUodnSTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFdkiX44EjkJj3LAqVwNHMJG8BXqkLT7bhkwcmGyI8Y=;
 b=Tjsz/dFsnwJ6eqZisRBYthZLvWzz9PphxCzlap/ISEM6oMroMgikkS69nWWuTmHKa0irkoZCIhG3OUSd0OXRt/HlotBprRhRXbXF8I7nLLMunauXgraSTSJoyiFlme7QKHoKltS+7xOeEfG1LP6QjfKscYpXEsoeRRa783WCSzPREkHiojMt344Fsdhz5Q3DDqhgCVGkbMMWg9JZiqQqBG4QzJq09jKLXbl1UXAL5GwTYER3JtqOp7xB+mmqx41E2zTW8soe8Baj6FdAInZ/AH7A98UaNmo6GO7F52FUnZ+l3g2lnxrAbJG/L37VzasNVMmw1vJHJeyAHxvI+pXdRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFdkiX44EjkJj3LAqVwNHMJG8BXqkLT7bhkwcmGyI8Y=;
 b=Ig9KZhvoxxBtKwaq9W6Dpl2i3KHO+TmXIVq0gKGEiG5iw+LXqO1yl0fOj8MYsqEsW9UI4VciRGnVR5UZUHl+ZQskiw0oqe+hqSj4DGYZPy7P1su4+Tw02Rw/6lupquhIqMAEJ0ljYHJcHmi+Z5wQWPN/94RWPRnq65LQLvRUs3APdpRL2zMETojAHdTqYvURd5mCVjE2i5g1Nywv6/g0yRUsxxEZNdPIK9Z1onWUjShZ6luYj75oiAhQQ4K9mJldjLB7BXo9t5dy2KvCgE4Tf8afg+5BIxk32uI2q04weMm9r47mz1YE3IsE6fIdFRM0idnaaEd32QWoLb/CP3cLkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8826.eurprd04.prod.outlook.com (2603:10a6:20b:409::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 19:17:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 19:17:54 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 15 Oct 2024 15:17:19 -0400
Subject: [PATCH v5 3/3] PCI: imx6: Remove cpu_addr_fixup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-pci_fixup_addr-v5-3-ced556c85270@nxp.com>
References: <20241015-pci_fixup_addr-v5-0-ced556c85270@nxp.com>
In-Reply-To: <20241015-pci_fixup_addr-v5-0-ced556c85270@nxp.com>
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
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729019855; l=2455;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Xur3w88Prm2U9ti80meGJLxIu6InmfTZAzjgILmrVU0=;
 b=CfiwpnLOP6TFyvQ9YuQRyjLyR4VWCIAxMb01L2DT4ROCDyrMXEuNW+7QF1uF9bn8Yoc5jn3/o
 McSsd5Uo+9mAC590Kk5w+kk6T1xmuiHJ+h7yGdod53WsPHxri9YwBXv
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0117.namprd05.prod.outlook.com
 (2603:10b6:a03:334::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8826:EE_
X-MS-Office365-Filtering-Correlation-Id: 5232c217-a128-4570-3cee-08dced4e11aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OW5VRFRKSTUyNmdLdmVGdU4zZDFvY0JHSko3N2FwdklXdUVud0s3enJTbXhH?=
 =?utf-8?B?cld6U1hrZllzb3FRaHd3cWJQYm9oN1IwVGszQXkvVm5WcVdyWDhpeEl2OGh4?=
 =?utf-8?B?eW5hdEtjaGpWa0ZxYkdwQmF2SU9MaE1yYmFqWHg3MHkzTWI0Ym5GRXFGRnlP?=
 =?utf-8?B?WHIzWGlKMnp0Y3kyckwrZVBpdTN5VEtSbTBQWWlOQVdXdnBqT2ozc1U4bGc1?=
 =?utf-8?B?QVh1RmdJOFllUUV5UnFUcTdyMVRpdWx0S09RRklnNGVHMEVwSmdjYTA3ZHNY?=
 =?utf-8?B?dXpaMnZjR3BmWlRnU2Z1Wk16RmVSREprYXlUa3o2K1R4N0Z0NUV6ZHZ1U3du?=
 =?utf-8?B?WHBtdzNTck5NQ2JrRFNEb3p5bGwxODR5anNxTlJKc3E3cjdLV0xWZ1ArdlhC?=
 =?utf-8?B?S2ZkWUR0STlWRHk4Qi9tVysyMU5YbXFwSWNNRFR2TXltbDVBZ0pRaEF0YzNE?=
 =?utf-8?B?bm9vVUduUnd1bWhDWDliczNnYXc3VlphQzZkZzJaaXJWYU94RXl5WkNqSE44?=
 =?utf-8?B?SFBDSUFpN1c2Y0gweitUZkxzWUNmb3AreHVWVy90OXFWSlNuZW15UnpxSzMr?=
 =?utf-8?B?UURraUFkQkFBRHlzczlxLytLemVHWjR6dzZaMm5McUdZWXhHVE9iQUpBUlk1?=
 =?utf-8?B?Q3lYYVpiajIyNXFReFJZM0pQQ0xaaUh2NWZuTmlsaWFoS2FNOFl2VlQxMmM5?=
 =?utf-8?B?YjBJSFQ5am55cU0vQ2FtK2IzTE9QVkVEcTFYN3JHNit2Qzl2QUJqcmZJRWQv?=
 =?utf-8?B?a2hBUWJpNGdoNzltZjl2ejhldUc2THU0WVFzMXE4OWxFb3M3dGNDYllYa2ta?=
 =?utf-8?B?SkpIVGsweWRzWVAyMCtiRWZqc1AvaEJvMmZnWHVzQWRZSFZ2czMzYmVyalRo?=
 =?utf-8?B?Yk5iMWlRNEN1cE0xTURIQzc3eGtoV2VkdldPTDdOTG8veUpoZHZXVmR1VHpO?=
 =?utf-8?B?UDYxbXlpWUN0cnVLUm1SRmVNeFdzSHZmZlQyK1B6Tk5tWHdpMTEzUk93cjll?=
 =?utf-8?B?a2dTMjJtd05XOE1QRWk0U3FSVnpQMWNkdWMxdXl4Y1ZOSzB4SjYzYUQwbGpS?=
 =?utf-8?B?MzJwNU05QXoybklvS0ZGc0ZaaDdCSG9uL2IzVnl3RDJnLzl4MWhCM1p3TDNK?=
 =?utf-8?B?RFpuM0JHeCtoRG9mYXhsNDhCVTV1OFp4M2xLVE9SSHNRY3lENnByekhUaWpi?=
 =?utf-8?B?YWFlZTB6THhVUng4WVVlQkpHTG14eTk1NjNLV2JrZzQvMFUwb0tCMmZMTzdy?=
 =?utf-8?B?c1Z3TWhYaXdnOTExQ0h3dHc0bjh2ZkZ4bURNNWsxMGE5aWpLdU9oUmpBQ3Zk?=
 =?utf-8?B?QWNMNHZjVVRqendHNGJJZHB3cm5qYTk5WUk1eXl5WjdhUEZ4OFlsRDB1MmhY?=
 =?utf-8?B?L0J6My9BdU13Nmwwd0NHUUdtMHV0QWhERWtmaG5TUmJrSDAxWThPbHY2bVpL?=
 =?utf-8?B?SHhJWXIzeDQvWWx4c0FYMk9Xb2d0Z280K2VUWGdhdzNCc1M3QXh3T1lwQmdD?=
 =?utf-8?B?U0dKRENlN2Y3N0ZjNVcvdCtBbHRIMHZjL2EzNFpRai83MGQzcUErSGFSWi9S?=
 =?utf-8?B?bWM3OTJFeWFma093SmwwRERnNTNmQlFtMmFhcmE0Rk0xUGtEOS81T1ArS211?=
 =?utf-8?B?M1YvdjBXTnJndjNLV2FBZVl3bUpSR0lBWVNGU2w4bDdMbXB4V2VqNzRNbG5j?=
 =?utf-8?B?b0lSbHJuU1ErYUJWcmlaY1FtY2gweW1nMitzd1k2UDBVME9BYVA1cXBqNlE1?=
 =?utf-8?B?WHk4N2Q1KzlhVHM3aDhGcVpSWkdVWXNYejUxVDBrN0JIN0k3TFNEOW5rUG9l?=
 =?utf-8?Q?yX7c5eFa+DZ1M7X7C2STt6slcpLOKG65fKRQ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUErUkljQ2loamlMeGVhVEpvZU5uL0pCSVYxR3A3SU0yRjJoMjZtdVRUUjlV?=
 =?utf-8?B?WkJaZVc0M1VJQnA2UHgwOXh4eVFOQXNWNGFjNjY1alZhcHlEcEhBdjQ3ckR0?=
 =?utf-8?B?THFvMEhIZU5wakhVRXZFSE4xWmdxa203dUU3Z2tBY3ZhTnJnS1hBZ095RldC?=
 =?utf-8?B?MFRtMll4bnV6VUZ0UUxndmpGNEFaeFJVa1FqTmxpVStwVFFCMkNqWFlZd2JD?=
 =?utf-8?B?U3V5UHlJM0VSTWc0QkJBR2krN0tDV1dCYlY1eit6dlJ4bDlkU1RnOXpRN3Ro?=
 =?utf-8?B?aWhpN3kweU0yajFyZ3JOeWtHV2VmeVMzTERNZ0Z6QTkrUkx3VEZBOXFnNEM0?=
 =?utf-8?B?NTc4YTRiYXlZZmZ2bDljLzZKajlhbHdSSmFLSXZVbW8xTU5TY1cxNUpDbUhr?=
 =?utf-8?B?YTY0VzhlUWxqd1JxNUNtUktNelBIT0tlY0ZyUnM5cWZQMjh3NWtkbG1OSkZh?=
 =?utf-8?B?Vmt5OUFHR1RMNDRNRjF5OTM2VUh4K3RHOVgrMUZJMWtPUnZwUFpZOVhEK0Z2?=
 =?utf-8?B?L2JrdDNGUWhkZzUzRjg4MGlwZUUxM2E2b0QxTjJ3bUNJOE02TXRIeHg3eHZa?=
 =?utf-8?B?R1VRZ0FIV1FyQ2VkT09uNEo3eFpHNkNucGluK3JIa1dxN3BKNkVsekNUQWZu?=
 =?utf-8?B?T1JxWWxFekluOXFsU0tUbjNpd1dYY0lyc3hpSHBJa0s4T1VBcDhla1MwZk9u?=
 =?utf-8?B?OWRFS0p2OWFIUkU3djlaRThSRE9tcUpNVnA2UlJVUWI5dXJOM1ZVd3c4N2lV?=
 =?utf-8?B?SnhKbmhCTWhOcEExdHlFaWQ3NGhlUk1wWkdvNkF6S0Y4VFRtMVlmMjNxeEJj?=
 =?utf-8?B?MTB2Mjc5VDZYaTNSSVVZanZzS3FweHlWL0R3N2tvOG5sTDJlQ3BaOG83Tm10?=
 =?utf-8?B?blgyaE5NLzZERXJ5RkdrU29iVHpTZFB5N2tRY29QQTNSWnVNU0VndncvWm51?=
 =?utf-8?B?aldVV3piMHR5SUIxK0JnbjgrdHl1MDhYeWJXclVRMXdCbXZreitpLzUrQkZn?=
 =?utf-8?B?THh5dWYrLzMvdFNiUjl0eHRXTGRsZkthaEJDdS9DWk92ZXV0WExsNmM0RnRv?=
 =?utf-8?B?OGtYS25PcjR0SElmTDZ5c1Nudk04a1J5WVBGd21tc1RmWGhJaGFOOUpDMEc3?=
 =?utf-8?B?djNyNFNSaGhiazFIalh1K3U4SkdIdFVJUWtuMzlhRytLc3V0SzJEai9RUG1s?=
 =?utf-8?B?MXpyQlNiYlVEallxKzJSbGVDQTl5YU1uR0x5NGxXeWpiam43R3hnZkh5YWw2?=
 =?utf-8?B?WEpSanpnb0JNdlljdHhZWGxUNGhHa3QxS25ld1hVciszUjlpMUxNOUE3bHov?=
 =?utf-8?B?aVdxcWFveSt1ejZpSVdxd1JnbVo4TVRMUjcvSWtRQUtaQ3FiZ2VXQVROOExD?=
 =?utf-8?B?aHdvaHFKcHR5Z1F2aXpyWDRkUUFsNFhpejJOQ2Q5TEg3QWk4dHR0MVZBL3FW?=
 =?utf-8?B?TlBacGxocmhFWU81RzBKNmp4TGNjS1dZQ3EzcnkydTdOK3M5anhTVjF0QW5r?=
 =?utf-8?B?OEtpSzh4clBzUFM1c0FZOVAzbXJhQlNGakV3cVQ0cjdyWit2eTAxZ2YrWnc5?=
 =?utf-8?B?ZG5GQ3c3cmdSTThsN1BBc1hGUWc1Wk0yU2hObVA4NkJpd3lGVGEzNTdLN0Nk?=
 =?utf-8?B?QU9rZjM2NGxWbjd5SUU5SERMcVdlMmVxbFVBSVFHRnI4Z3I3M1VPc2tSSVdv?=
 =?utf-8?B?SmVUKzREbmJRN3d0OElxclZWT09zOThSVi9QWVRaMXVWQWQ3ckJSVkdwRGEw?=
 =?utf-8?B?dzcyMEU1MWI0SlZyVktzQkQ3a21SYVB1OTRCdUo4cFZrNFdLL1dUMGNaT1Qv?=
 =?utf-8?B?UDJmZ2tFSktWUXo4bDNYZGJvaW9wQzhnZ2JaQktCOVo5UW8vVmpKV2xtcDJ0?=
 =?utf-8?B?aFlqR2lHV3dKUTFMNEl4QW9sMjBqbGEwQXAwR3ozNXJEY1d4Nk1uRjU4Vk9z?=
 =?utf-8?B?SkhMNVZoNGVUQlROUzExK0NGVlpjK2dneGVnVmg2aGQzYkpKTitRdUVadjYz?=
 =?utf-8?B?dUt1TzdXcllFekx0Znd2endsU1ZDTlZoT042b09OQXhMN0g1eG14RHpyTWxX?=
 =?utf-8?B?c3hjQjFHaGRYQk41WUJZZ0JCaFVPcklQVk1idU1Ma3NtSGduM2JMWVR3c0Fz?=
 =?utf-8?Q?Ms3Y=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5232c217-a128-4570-3cee-08dced4e11aa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 19:17:54.0391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwDgHXVUwOZ8uwmSt3jy8jYtO8nSQVFA4wzLJa7wepfIW2708qFbtqR5ICUT5v65zVkaAZ9Z05GUVJYxqqO2uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8826

Remove cpu_addr_fixup() because dwc common driver already handle address
translate.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v5
- none
Change from v1 to v2
- set using_dtbus_info true
---
 drivers/pci/controller/dwc/pci-imx6.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 808d1f1054173..533905b3942a1 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -81,7 +81,6 @@ enum imx_pcie_variants {
 #define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
 #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
 #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
-#define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(8)
 
 #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -1012,22 +1011,6 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 		regulator_disable(imx_pcie->vpcie);
 }
 
-static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
-{
-	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
-	struct dw_pcie_rp *pp = &pcie->pp;
-	struct resource_entry *entry;
-
-	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_CPU_ADDR_FIXUP))
-		return cpu_addr;
-
-	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
-	if (!entry)
-		return cpu_addr;
-
-	return cpu_addr - entry->offset;
-}
-
 static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 	.init = imx_pcie_host_init,
 	.deinit = imx_pcie_host_exit,
@@ -1036,7 +1019,6 @@ static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = imx_pcie_start_link,
 	.stop_link = imx_pcie_stop_link,
-	.cpu_addr_fixup = imx_pcie_cpu_addr_fixup,
 };
 
 static void imx_pcie_ep_init(struct dw_pcie_ep *ep)
@@ -1446,6 +1428,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pci->using_dtbus_info = true;
 	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
 		ret = imx_add_pcie_ep(imx_pcie, pdev);
 		if (ret < 0)
@@ -1585,8 +1568,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	},
 	[IMX8Q] = {
 		.variant = IMX8Q,
-		.flags = IMX_PCIE_FLAG_HAS_PHYDRV |
-			 IMX_PCIE_FLAG_CPU_ADDR_FIXUP,
+		.flags = IMX_PCIE_FLAG_HAS_PHYDRV,
 		.clk_names = imx8q_clks,
 		.clks_cnt = ARRAY_SIZE(imx8q_clks),
 	},

-- 
2.34.1


