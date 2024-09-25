Return-Path: <linux-pci+bounces-13469-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E7B985131
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 05:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724AA2851BC
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 03:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D57149C4B;
	Wed, 25 Sep 2024 03:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VCRXgytx"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2051.outbound.protection.outlook.com [40.107.249.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA2F13A3ED;
	Wed, 25 Sep 2024 03:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727233557; cv=fail; b=EPfgo2BCHNGm7odV3dljAN8HC4ZT2xJYOR+haUTO3PP1HX6HpVS8/EVNWSUxNF4f/mkCSWgmSEL+mWv49jj7ew+2fa2snTdwfBvQaKB/qe3FHpqCXKpPnBFn0lphPT9VKnmW0t7g6t+zAcbvu/9abgExfOJttJoZg5mGAeUbFYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727233557; c=relaxed/simple;
	bh=O9j5KOfyUTXREtS0JTx7UfuAeyomq+KQfOGEzEKb1bk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IoJipLBCkj+5Z/+x9z1AJ2Bc4WAexmaFManHjfHES6RDDtDWo4BQ7Wdq7gyLzfKj8G6y8au2atE2R75dQIxHCJCvqSpW7vNC219Go6LWMdiO6rt+whM1mb4jhcQTp1GSvn39wGLqHk2iKx/NPXGWPShbnDzCpUCEw9DD0bCcdo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VCRXgytx; arc=fail smtp.client-ip=40.107.249.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzjn+/mqT4yhYBNakmT1a177yQ8qO7wC/xRzOUWMaYW5J55s/Nqvx5WlvLlEeCFMrlmnqAjIsFmf4EEgmPvl/BTSJ59sE9+3bfjeU8ccYQTyfSkfvISx769ogITN0xZop71tpE8BkrahHEddK0FD584cJHXgSxjwW3NEhD/fe2b8PjFvBzB6nt1uzURNIhMba2UPdbkPfVcoJ1xD1g3RgI08bTOdAH82asolr3vFeSgWFAzX+E8nYeapzaNXJOELzkf5DPMKiWbBCpc2gNggaxb0mfMDow+FBADRrJjPK3Bx3RrVVUjtMg1hlFlzkDgiut5zBxLBLC22zJpWLvHzCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9j5KOfyUTXREtS0JTx7UfuAeyomq+KQfOGEzEKb1bk=;
 b=aUySNAQpHj0NNp7xJsPm/9SXu8w0pdMCQzD34SjMLNfXYw6aczQrLwN1SVjJSODZWDYXOh6HaZhd1LjfdNKaiUTfrneJEaz3VMZr69HpEl1Q1Ty5EZZBU1u0uAtN36EdwUqpdggBe1KbuOn2daJh16IEwI/8Br+ZMXqxzOGMTnQvWq1QiBo9C+8xc6wqKb+stkYfgXj7wVObyCluZF/0h2qeakFCaXKWQjmm3tG6DJ89uL2565OHUVqBERv1VUc/8pRmfhUZsiGxdcXVDMnEEjZxov42aOcXgZIVkfW8X77rJfykuaU23m6bUZRreXT4kwSE+bQojPzO3xVI3vWcAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9j5KOfyUTXREtS0JTx7UfuAeyomq+KQfOGEzEKb1bk=;
 b=VCRXgytxkAN385fz7/6Y0PTVZkjetOmOzJymHcV3kRWVAW8oA8hBqBCS8zgathxLTJY09qPOeUmUG0grMrvdLgRAq1fhDLoao1yIv0zsmlSR32K638YH62EcZvjgERkHHCovX1CvXuFStDB0ReO7mgZlXA8xXe9UPIEAI24z8T9g6t6josRBIEhEVX57+Rg6WKsVP96bFs62QIh3iSziiWRm0M/5i+TY0R6+UehUVep43LeRDsb2n54FOcddtAIP24VCVM6aB0A0ITwSmCOpwngN3n0zRCBkkv4edTfhzfPa80tWXneVfdsBvSrtLs5sK9pnTCNuKxPcZ+gW/9hPyQ==
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com (2603:10a6:10:2dc::14)
 by DB9PR04MB9452.eurprd04.prod.outlook.com (2603:10a6:10:367::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 03:05:50 +0000
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::6b10:a2e8:fdf0:6bdd]) by DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::6b10:a2e8:fdf0:6bdd%4]) with mapi id 15.20.7918.024; Wed, 25 Sep 2024
 03:05:50 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Frank Li <frank.li@nxp.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>, Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Abraham I
	<kishon@kernel.org>, Saravana Kannan <saravanak@google.com>, Jingoo Han
	<jingoohan1@gmail.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>, Lucas Stach
	<l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?=
	<kwilczynski@kernel.org>
Subject: RE: [PATCH v2 4/4] PCI: imx6: Add i.MX8Q PCIe Endpoint (EP) support
Thread-Topic: [PATCH v2 4/4] PCI: imx6: Add i.MX8Q PCIe Endpoint (EP) support
Thread-Index: AQHbDeraOxgdvHBrz0y8SMXHkvPmgbJn05fA
Date: Wed, 25 Sep 2024 03:05:49 +0000
Message-ID:
 <DU2PR04MB8677180B5B0B3637D59EB7378C692@DU2PR04MB8677.eurprd04.prod.outlook.com>
References: <20240923-pcie_ep_range-v2-0-78d2ea434d9f@nxp.com>
 <20240923-pcie_ep_range-v2-4-78d2ea434d9f@nxp.com>
In-Reply-To: <20240923-pcie_ep_range-v2-4-78d2ea434d9f@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8677:EE_|DB9PR04MB9452:EE_
x-ms-office365-filtering-correlation-id: f3cdfc50-0f4d-482a-7b04-08dcdd0ef5a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?L2sxbXZGZHI4dkVFVUM5WW1na0g2L0JreCt3U2JJQzdlNVd3SWlCRXNMQXdp?=
 =?utf-8?B?R2hoSmFFZ241Z3VqWXRYMFY4WGUyeW9nc0dGUFpreVBSVk9NWWRmdXJiSlRV?=
 =?utf-8?B?YmFXb1VvV3drQUdpR3U3Y0JQZEo3dDB6U2lja1N3b25qYVNKU283T3ZFVzF2?=
 =?utf-8?B?Qi9DNGxYd1FJaWhYUFZxZ0FqanAwUUVSTGZGMTBEZXhtWWh3ejg2WGJ6ZlQ2?=
 =?utf-8?B?TVg1RlNpYWNlWFFyWVlFd0pJUk1IeEROS01pTGZ4WDNxb2E4QmxtSzVTYWI4?=
 =?utf-8?B?ZkJtZnZ6bzdySmVIYU5TVHR4RDNxTEJLSHJuR0dSVURSUExScDErVko2dkk1?=
 =?utf-8?B?UnRiR2FDN3JXU0hXOGl0amZjeHZaYkhONmhvMFZQTi80ZDU1Z1hBMGc4b0Rk?=
 =?utf-8?B?QjBucWh5R0JtVW9XdEFJeEpheXNOYlFGTUloNkFMcXQ4Q1ZRMkRFeUxFTi9p?=
 =?utf-8?B?cSt4M3FoMTR3UGQ4eVVGZ3djV3dOWlloaW5OYWVaSE1kSi9EL3YzZnJiS0No?=
 =?utf-8?B?aW1oMlFyUWx4Mk5HYzBtTXhERUpqWHRURFhqY25QSjViNUZxUGJVTWZRTUhT?=
 =?utf-8?B?UDc2Y09jMlN1S1R1K2dUYkFlUG1paEZ3SHRDNTJ2YWZZYTlLZGtOdVFvWjF4?=
 =?utf-8?B?VHZxZlMrVzUra3N6OC9xSWZZQzlJVitOTHEyOG5pWlZQb2J5dXVidlpYemdm?=
 =?utf-8?B?QjcwN3Q1ZGZKZngwZTJHbzhySThUTHJLM1NKUDVYR1YyTTNIV1pGd0RhbFVN?=
 =?utf-8?B?cnlkaStZRnBkR3l6cXUrSkJlYTBZaSt1cW45L3kvN3YwMmFhL1RjdGgzamVJ?=
 =?utf-8?B?bldkZFQ4ZmxzbFJmNitqU1JJKy82Y2hqdEN0V0ZxQmJTb3BPV0ZkYlRpRVR0?=
 =?utf-8?B?VnR5U1IxaG4veFdoQ2xpZFYwd3BJck9QSmNBemRpR0RVZk5PQTd0STFpK2tq?=
 =?utf-8?B?N0NVUUlTc04yRStGbkVMaHpoaHlHN2VwOGFqOVo5SjMvY3gvdFd1UHc2Y3d2?=
 =?utf-8?B?Mm01UHZNNEFmb3RFUzBlbmI0am1pMXFPV0dYemJIajEzdTd4RTY5Z21kUjNV?=
 =?utf-8?B?dlpmNXRuTDkzM3lsSzVUVGxCSUZqalRvY0RQdnlUS25XUG50RnIrWVhXSU8x?=
 =?utf-8?B?YXlTeGJncTR1TzVENG5YUEdpZEpOWWdBbFI4OWx4WG02SFE0ZVkwQTVPQUtt?=
 =?utf-8?B?RUt2Y2JIc1p4NlprcXoyRTBJa2t5UGQyaWY2ejdmbXFYeHNPQU5DK0tQcVg4?=
 =?utf-8?B?emVqOEowUERLdzZlV2dnRkcwQ0szamJMUlo4TUlIR2ZHREU4QW5DaUVVa1JJ?=
 =?utf-8?B?S1VPb0RIOHBscHNxRFVDbjRVSWl4TFNMRUJtZkg3dUtaM2p2aktuYk1tamhD?=
 =?utf-8?B?Z1FBbVQ5V2hPWExyc1VzdHpRaFd0dFFIdDZWcjFrUHg3ZjM3Nk1mcGdmZk9Q?=
 =?utf-8?B?YWtGYTBlQjZudTBBZ21MNmFhZVpENHFydjVRMDFZNUFObVlIcTFiWjFtaS9Q?=
 =?utf-8?B?RGZoaXNISnVobUh0bHdYMlVpZmw2RDFpN2U4Y1NUUWg4aFZ6RGg4STV3eHVE?=
 =?utf-8?B?MzdGV2JoV3RwUGFlNzlUU3NMMDIzcFhWQmRsNFcwWTQrSENrQ2xmU2labDhW?=
 =?utf-8?B?Y1ZhZjgwdkhScENmRmxTamVQdzZadmNHeHArV1ZmTndVeWwySXRkbzF4ekUr?=
 =?utf-8?B?TVNxNTJMVE5mWXd3NWp0VklFcFRNSmhZWTFtSSt2ZXg1RndoQjYzVjl4YTJG?=
 =?utf-8?B?SGNFcXdQYU12dElYemtrMm90Vmo2Z1VEdHJPeU1zWWR6UWt3VmtCanFlT2Nv?=
 =?utf-8?Q?oRuefPG37Xdih5pBgljh/Nr1rJLNCH+Tt/rAo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8677.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aUk5MWN1dkRTeldVT2ZURW9FRkZNR0dlZ2VYL1lCOTdNb3h5OWpqZEs4cUU2?=
 =?utf-8?B?NGhkVDUwR2M4TTVtK0JPRkMrT25qc0RsSlNJLzJwOVkwa3p2Yk01SnBLWDZL?=
 =?utf-8?B?WW54V2tkZjFHdFZGNGZSeHZnNURiTEhBYy9aR0Z5bFYvbUFKQjg5em11VTVG?=
 =?utf-8?B?eHdUTlNsMkNyRGRxOUdGbnp5QTZoWm9VZ0kvbG1TdHoxQnNtYUkxRjl5T3dC?=
 =?utf-8?B?Ny9xKzk1dHFXY0NmQTBGWXVyekEwUkNiVGcrS3pZSnJzL0UwQXk3RHpkalZQ?=
 =?utf-8?B?SUJ2Y2hOb3dDMFlDZ0dTM1YwSVJQbXBSTEtQWHhOcDhybUFHanlkdTRZN254?=
 =?utf-8?B?eTJBUkUvQlBNR0xRemRiSjhKMkFUNGczcWJoOXRNQi9QbFFSSlV6MjNwalFI?=
 =?utf-8?B?cHRiWHMyWk9mNHdFYVhNQWJqL3VpMlZ3UmVaRDB5cUhSSUJFUis0Q2p5Z2Ry?=
 =?utf-8?B?SlhHZTVtM2w0SDhGNWEzYkQ1aWVKVkpzSmE3RTlHbUhuZ09TcUNVVERMM2ls?=
 =?utf-8?B?YmRlbVZnZ1Q3R25kcG54R0FWUVJ3cGo5YTBWMFlPaWhndVZENG1ZSW15YU4x?=
 =?utf-8?B?aGtRK0NDRjJ3RTU2MXIzNVVuUXFvNHAxaXBUbkdSQVplbnRJL2EybzBNUUZC?=
 =?utf-8?B?WWZaQnhmaFhPbE5YVUI0YWwyTzA5UjcwYUh5MldNMW9nN253enlaQnNQQkRh?=
 =?utf-8?B?L2pTS3dkT3lJWC9MWmpFWGhxbEhlSFRzZitHVkczT1E0enJCb0VqeXUwemVv?=
 =?utf-8?B?cVQzWmV4YXVMNEd2cEpCd2d4Szk3QnlBMHRMMm1jaHRwWW8veTN4VEVrZEVv?=
 =?utf-8?B?aEtZdTZGbU14T3ZUbFIvV21pTGtnQU81M1BHM3FvV2dDYkNXOEJST2krczNo?=
 =?utf-8?B?M2V3TWo3Z2h0WlRESWU1QVBwMnVUTUdmS2NIVmhKSlRlcnZYbVNNMEdRbjdo?=
 =?utf-8?B?Ulg4dnFGcThTNERHSlFhQldycFAvVzFXeEZleElhSWp4U2NWbStuQXdCbVll?=
 =?utf-8?B?ZWhQaTFDUWRFZzlRbVZXRjE0Mm0xYVVqdkY1cmZrZ1RNa3BCa3BCa0tkR0ht?=
 =?utf-8?B?c055QXcvOHFKWHduRWNNREJaOGtjN3dyUENwNmF5UklDbFBJSVZVeFF3Unho?=
 =?utf-8?B?QzZiaE9lWFF2TTlQY3NnQ3RmWUttaWF1RDBrNU9vZUxrNHZnZVhXUzZpcWVk?=
 =?utf-8?B?UE5abEFZRVFKQVZCNlp2QXRxaEpPUVpqMkFNYzhSckxKU2JybmhXQUlrZ2Nx?=
 =?utf-8?B?cEVnak1lbXE0ajVZb1B3L1BpbDJvUGV3QVpyQzc3WExROHZCdXJoRFBGMHRX?=
 =?utf-8?B?RjNPZGU5VlNGckJiYU5zWklHblJFREpkWWdENEgyalhqc1pkNWFKTFRvaTNM?=
 =?utf-8?B?dk5rQnpDYm5BTEREQXZqL1hNZnJGanYvZGRUU0FtZkpUeEloRUc4eTV4RElU?=
 =?utf-8?B?MDBkWFF1OE5sdEdyT29Ra2pLdllsaUNYRjNXSnlka0ljREtLWjh0OG85cmxi?=
 =?utf-8?B?UittMW92Y0N0VEhRQzVEN3ovdkxyVzVwbW9BREg3KzlnQjBQRldyV0JMMmV1?=
 =?utf-8?B?TDZ0WllYL2xMSE5LZEJOdHJ2c0REb2RPVm5wd0U1QWtXSmRuM0dTbXVlamds?=
 =?utf-8?B?dEZVTUl1emkrVmpuc1lzdGttd3FlMzBPdzRJU2FDYXF3dGxiR0t5NU1OaitR?=
 =?utf-8?B?aCtPSW9UMy9QV3I4ZnEvK2pPRnBVaUw1V0hlNGlLeDdwS1dsbENVTXE0ckFU?=
 =?utf-8?B?SzBwQUFYVzN4TG5NMkUzQkd2eUtMOEVEMm4wV24xenZiT00wVlFYd1FOMWgy?=
 =?utf-8?B?NkgvRG5CYzczdmUxUEUrdlF4UkdydkJyY2R6V0FZcmU0bkhORXZUSFVFMDNW?=
 =?utf-8?B?QXR0V0htN3VMc3U5L3FsdEFLM204Vm10ME0vSVVha3lrMFI2TmovNkZialVl?=
 =?utf-8?B?ZjdUQTBTV2J0eUtQZ3VvR201RHJUN09hNkhxZDhLd2dsR2VnS05kemJzRlFy?=
 =?utf-8?B?b3pQNndjM3lHcVpvTVA5ZzdmSUkvMGpHaUgvNG9BRkN6c3pkRi9jVHkzWmtT?=
 =?utf-8?B?Uk9tamVjT1ZDRzdGb1libnB2SFRnN3JKQjdBeU1LT080bGRCLzVzZG4vbk9K?=
 =?utf-8?Q?M/oB0lAoFYJcniEGeUZRc7wBA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8677.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3cdfc50-0f4d-482a-7b04-08dcdd0ef5a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 03:05:50.0082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R8B+iejO1O3YmKAIbA8JIX2iF44LTlGZSegkylKNcoFM+KzN4cpfojf9qpCZ26E8WlqgNT/MWpa/tuKz1H3YeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9452

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNOW5tDnmnIgyNOaXpSAyOjU5DQo+IFRvOiBMb3JlbnpvIFBp
ZXJhbGlzaSA8bHBpZXJhbGlzaUBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIFdpbGN6ecWEc2tpDQo+
IDxrd0BsaW51eC5jb20+OyBNYW5pdmFubmFuIFNhZGhhc2l2YW0NCj4gPG1hbml2YW5uYW4uc2Fk
aGFzaXZhbUBsaW5hcm8ub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47DQo+IEJq
b3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+OyBLcnp5c3p0b2YgS296bG93c2tpDQo+
IDxrcnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+
OyBBYnJhaGFtIEkNCj4gPGtpc2hvbkBrZXJuZWwub3JnPjsgU2FyYXZhbmEgS2FubmFuIDxzYXJh
dmFuYWtAZ29vZ2xlLmNvbT47IEppbmdvbw0KPiBIYW4gPGppbmdvb2hhbjFAZ21haWwuY29tPjsg
R3VzdGF2byBQaW1lbnRlbA0KPiA8Z3VzdGF2by5waW1lbnRlbEBzeW5vcHN5cy5jb20+OyBKZXNw
ZXIgTmlsc3Nvbg0KPiA8amVzcGVyLm5pbHNzb25AYXhpcy5jb20+OyBIb25neGluZyBaaHUgPGhv
bmd4aW5nLnpodUBueHAuY29tPjsgTHVjYXMNCj4gU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXgu
ZGU+OyBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+Ow0KPiBTYXNjaGEgSGF1ZXIgPHMu
aGF1ZXJAcGVuZ3V0cm9uaXguZGU+OyBQZW5ndXRyb25peCBLZXJuZWwgVGVhbQ0KPiA8a2VybmVs
QHBlbmd1dHJvbml4LmRlPjsgRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBD
YzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAYXhpcy5j
b207DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgaW14QGxpc3RzLmxp
bnV4LmRldjsgS3J6eXN6dG9mDQo+IFdpbGN6ecWEc2tpIDxrd2lsY3p5bnNraUBrZXJuZWwub3Jn
PjsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MiA0LzRd
IFBDSTogaW14NjogQWRkIGkuTVg4USBQQ0llIEVuZHBvaW50IChFUCkgc3VwcG9ydA0KPiANCj4g
QWRkIHN1cHBvcnQgZm9yIGkuTVg4USBzZXJpZXMgKGkuTVg4UU0sIGkuTVg4UVhQLCBhbmQgaS5N
WDhEWEwpIFBDSWUNCj4gRW5kcG9pbnQgKEVQKS4gT24gaS5NWDhRIHBsYXRmb3JtcywgdGhlIFBD
SSBidXMgYWRkcmVzc2VzIGRpZmZlciBmcm9tIHRoZQ0KPiBDUFUgYWRkcmVzc2VzLiBUaGUgRGVz
aWduV2FyZSAoRFdDKSBkcml2ZXIgYWxyZWFkeSBoYW5kbGVzIHRoaXMgaW4gdGhlDQo+IGNvbW1v
biBjb2RlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+
DQoNClJldmlld2VkLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQoNCkJl
c3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gLS0tDQo+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2ktaW14Ni5jIHwgMjAgKysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFu
Z2VkLCAyMCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aS1pbXg2LmMNCj4gaW5kZXggYmRjMmIzNzJlNmMxMy4uMWU1OGMyNDEzN2U3ZiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiArKysgYi9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+IEBAIC03MCw2ICs3MCw3IEBAIGVu
dW0gaW14X3BjaWVfdmFyaWFudHMgew0KPiAgCUlNWDhNUV9FUCwNCj4gIAlJTVg4TU1fRVAsDQo+
ICAJSU1YOE1QX0VQLA0KPiArCUlNWDhRX0VQLA0KPiAgCUlNWDk1X0VQLA0KPiAgfTsNCj4gDQo+
IEBAIC0xMDc5LDYgKzEwODAsMTYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZXBjX2ZlYXR1
cmVzDQo+IGlteDhtX3BjaWVfZXBjX2ZlYXR1cmVzID0gew0KPiAgCS5hbGlnbiA9IFNaXzY0SywN
Cj4gIH07DQo+IA0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZXBjX2ZlYXR1cmVzIGlteDhx
X3BjaWVfZXBjX2ZlYXR1cmVzID0gew0KPiArCS5saW5rdXBfbm90aWZpZXIgPSBmYWxzZSwNCj4g
KwkubXNpX2NhcGFibGUgPSB0cnVlLA0KPiArCS5tc2l4X2NhcGFibGUgPSBmYWxzZSwNCj4gKwku
YmFyW0JBUl8xXSA9IHsgLnR5cGUgPSBCQVJfUkVTRVJWRUQsIH0sDQo+ICsJLmJhcltCQVJfM10g
PSB7IC50eXBlID0gQkFSX1JFU0VSVkVELCB9LA0KPiArCS5iYXJbQkFSXzVdID0geyAudHlwZSA9
IEJBUl9SRVNFUlZFRCwgfSwNCj4gKwkuYWxpZ24gPSBTWl82NEssDQo+ICt9Ow0KPiArDQo+ICAv
Kg0KPiAgICogQkFSIwl8IERlZmF1bHQgQkFSIGVuYWJsZQl8IERlZmF1bHQgQkFSIFR5cGUJfCBE
ZWZhdWx0IEJBUiBTaXplDQo+IAl8IEJBUiBTaXppbmcgU2NoZW1lDQo+ICAgKg0KPiA9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0K
PiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+IEBAIC0xNjQ1LDYgKzE2NTYs
MTQgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpbXhfcGNpZV9kcnZkYXRhIGRydmRhdGFbXSA9IHsN
Cj4gIAkJLmVwY19mZWF0dXJlcyA9ICZpbXg4bV9wY2llX2VwY19mZWF0dXJlcywNCj4gIAkJLmVu
YWJsZV9yZWZfY2xrID0gaW14OG1tX3BjaWVfZW5hYmxlX3JlZl9jbGssDQo+ICAJfSwNCj4gKwlb
SU1YOFFfRVBdID0gew0KPiArCQkudmFyaWFudCA9IElNWDhRX0VQLA0KPiArCQkuZmxhZ3MgPSBJ
TVhfUENJRV9GTEFHX0hBU19QSFlEUlYsDQo+ICsJCS5tb2RlID0gRFdfUENJRV9FUF9UWVBFLA0K
PiArCQkuZXBjX2ZlYXR1cmVzID0gJmlteDhxX3BjaWVfZXBjX2ZlYXR1cmVzLA0KPiArCQkuY2xr
X25hbWVzID0gaW14OHFfY2xrcywNCj4gKwkJLmNsa3NfY250ID0gQVJSQVlfU0laRShpbXg4cV9j
bGtzKSwNCj4gKwl9LA0KPiAgCVtJTVg5NV9FUF0gPSB7DQo+ICAJCS52YXJpYW50ID0gSU1YOTVf
RVAsDQo+ICAJCS5mbGFncyA9IElNWF9QQ0lFX0ZMQUdfSEFTX1NFUkRFUyB8DQo+IEBAIC0xNjc0
LDYgKzE2OTMsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZA0KPiBpbXhfcGNp
ZV9vZl9tYXRjaFtdID0gew0KPiAgCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDhtcS1wY2llLWVw
IiwgLmRhdGEgPSAmZHJ2ZGF0YVtJTVg4TVFfRVBdLCB9LA0KPiAgCXsgLmNvbXBhdGlibGUgPSAi
ZnNsLGlteDhtbS1wY2llLWVwIiwgLmRhdGEgPSAmZHJ2ZGF0YVtJTVg4TU1fRVBdLCB9LA0KPiAg
CXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDhtcC1wY2llLWVwIiwgLmRhdGEgPSAmZHJ2ZGF0YVtJ
TVg4TVBfRVBdLCB9LA0KPiArCXsgLmNvbXBhdGlibGUgPSAiZnNsLGlteDhxLXBjaWUtZXAiLCAu
ZGF0YSA9ICZkcnZkYXRhW0lNWDhRX0VQXSwgfSwNCj4gIAl7IC5jb21wYXRpYmxlID0gImZzbCxp
bXg5NS1wY2llLWVwIiwgLmRhdGEgPSAmZHJ2ZGF0YVtJTVg5NV9FUF0sIH0sDQo+ICAJe30sDQo+
ICB9Ow0KPiANCj4gLS0NCj4gMi4zNC4xDQoNCg==

