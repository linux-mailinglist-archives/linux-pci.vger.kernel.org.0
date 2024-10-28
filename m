Return-Path: <linux-pci+bounces-15490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E579B3A0C
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 20:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDC8E2832AA
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 19:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC3D1E285F;
	Mon, 28 Oct 2024 19:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cVjjYAoK"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2082.outbound.protection.outlook.com [40.107.104.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B903C1E231F;
	Mon, 28 Oct 2024 19:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142405; cv=fail; b=q78AVhFwdx0yWPQoXvKjl4uzpUlKMGDYLnDvsm6+zCysyiWha0TklpknSYXjFyAa7XhMe2A4dAcvuTrXkvp07Ummh5K/EE3BXIjpRPp7EfO+RXGNr2uTG4eDIetp/ezwUxD6VNhkuAjBDbj62vC9spYNpEuuTFoeFZ5PZVE8bSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142405; c=relaxed/simple;
	bh=oBTuOyGf1p5J6QSrmR/H90B4rkHNLZfeWqkQs2nR+Ss=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tfdhIA5cZqUN/6MB7EVZhBF138U17l1S8O+JRekg1h+SMVtMhS+YC1lEZZ+c8DFqYQvfw1n2wRjnD1ScpGYOC0ABUkhWiSxDRKzUdIp6XmFBD/3RHbJUjCPUyBXx0Q9LS/QWYYBk8hAk1BTUe7tKeqpQnVngbByewADjZBWOAZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cVjjYAoK; arc=fail smtp.client-ip=40.107.104.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MN/KylURMhw6Bu2u0iiTSF4F2KH0xrbMV6d+BYBHUnVITbL2N5ZscSa8MYHRFvWfx1jGZMKPxWG74C7GSZSNtc1TYawMwv1HxHSwIXgRTzVyMg3TdWBaPO8Vh7OJwpcGKvxD4DC6YiqogCx3O6xIX2TPeKBoUmTCsB8mC1FCvW9bz+pCxP/59cbZvsIcwKaa6V481KtWWlevKoyQaayL4yZJVXChp0wEeGVYtynrEC1ZC+iyijwvTD5VLgpD6T/zziWkc6ji9WETbD4M/caANL2x5wjHNX0vVR7p5jNNYTsAsA0H/Ap6r2txQJAb4qGfLQB9au6/7SPYGUBMRQKVDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIG3DwZHBHBFPNj0et0JCjxq4EvOWJCsaM4GFikwMac=;
 b=KGalesmhdrs97FKwb1YskqE5YyEbhNPvcM4PShIWVkKCc5KDYd2I2BQsTSmdQZ0Em0R1G+7sGTUrCzLkXy9DZVRAJ1nQgDykDqRtOFmQqQ88W8ljtUx8obb0xAx7qS08PEHrMW7X8b1olJTbqbbwk+gGx1M47uPYet9jkbmr69pEiDBJriwjFPPgW15fWyCfPaAn0UhS04Vq18Y0in5sjMBkjBWgurDfqSg7aFUuHRSPc/JuRSA31u/OdeHvZo0Snw89kW1f1OiNm3RRQGotuMhwqlFaIrVCnH21YbdPLNv904bPXj+cQWaxHEdn2azsbhpUMDpdDLn48q11P3g0dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIG3DwZHBHBFPNj0et0JCjxq4EvOWJCsaM4GFikwMac=;
 b=cVjjYAoKGv9tyLZOG460zuHGCtEzSnYcqBQpLOXYKCGdmX7b1MJJFOWMEWV1ngyXlllud3Fh6/R433Khn0WKkCKI2IGQ5x6Mqxhz2KwH1/emAJv/8akbt7AkgCK1tbhSYbcapUFybGCrEBOZOHN5ltYuySzo5LoTtY/mRB+BeCZGSxuCrULhrvvCoCkBeatHD/JsfjdCmpkmKNXAPmBAUW44cbK4W1O4p36ueGYU4ikUA5JyDdFIpL3bPa6POvAT652CDP9UX45U5iqTlRmkc86lH2xy+5NHwP4ankoxQ5QpDjJl+JdmnEXgS2QBzLeSKARndXFOiSUlOkvyIR0E1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 19:06:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.021; Mon, 28 Oct 2024
 19:06:40 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 28 Oct 2024 15:06:01 -0400
Subject: [PATCH v6 7/7] PCI: imx6: Add i.MX8Q PCIe Endpoint (EP) support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-pci_fixup_addr-v6-7-ebebcd8fd4ff@nxp.com>
References: <20241028-pci_fixup_addr-v6-0-ebebcd8fd4ff@nxp.com>
In-Reply-To: <20241028-pci_fixup_addr-v6-0-ebebcd8fd4ff@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730142363; l=2548;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=oBTuOyGf1p5J6QSrmR/H90B4rkHNLZfeWqkQs2nR+Ss=;
 b=k4cpxKXncruZS/S2xE5yJeROU6BdD2P8NV5gQAPw2o9sbickQbk8X+D0+Ae84EXIXvqc1vNFM
 S7JCn5F1nIZDZAhOy4Sjg7I1qnyHVWxCW0qVQBdGH1avRdG2zevRSPl
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: e334dac4-ccc8-4c37-37cc-08dcf783a780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEZZQ3VEV3o2cmtianFZY1BrWGEvZ0NuT3pZaEpCd0U2eW9LdVFzTUlKazFC?=
 =?utf-8?B?TTcvU0VSV1pjclIvYm9wcUxIUjY0cXNUQlBkeGFTWVhJZXhNWW9RUFVSOVhz?=
 =?utf-8?B?YnJ4V0dNOFErKys0aDlzL3lPS2MxYzdnTVRKZUlBUGhoaG1HR0xCaFlvSGcv?=
 =?utf-8?B?cTU3Y040Ly9paS9XR0FCaUNrYzRtTUEzOHBrbTZyLzFRVnNpRWhFNEpLUDd6?=
 =?utf-8?B?M2pOMCsrclR1OUQxeTNYY0JJcmdVME5Ta1F2WHFQM0RLUnB5OUl6OSs5UXI3?=
 =?utf-8?B?QlY2U0NtRlpSV3JlbUVMajdyWHV5SVJsNmloTURPZCtIemdFVHUxQTFmcWcr?=
 =?utf-8?B?ZFhzTFd6ZHRTZVdGRGN0VnVkQ3A0NU9XMC9xRGxTRVdwNndsQlFwTmtGV3Fs?=
 =?utf-8?B?Q1VaaW9icDVVOVNIeHB3aS9CQ0VUVmdsN092NHlTRHV0d3diSzdrbEZlU1hr?=
 =?utf-8?B?ZnRjMlAvRjl1ZXVhQ2lWSVNvNS9jU0pUcXRNOEd0VEhLRDd2N1MxZ3JWNmgz?=
 =?utf-8?B?NnFHQlMwNXVpaUtnU08reGZEemVpTUdtQVVKSktZR3FxZldURW83KzNQM25L?=
 =?utf-8?B?cmM4bUlyOUxiZ1E2czl0dGFtanlZRGMwUHlMZ3pkWjFmQ3k0QU1KazFHYUVu?=
 =?utf-8?B?SzNxdlEzSTA0WUlqQ2lrdVlKOGg4V25yOW1BTDhtRVc1emNKZS9pYlNtc1hw?=
 =?utf-8?B?cTZhTlVhTzB5aVMrd2tLeDNjdHU3UlVjVGFVcjBTclQ4L0xzNXIrSHBLbjlL?=
 =?utf-8?B?aXh0WXIwVUhQL25kWnFhak1rK094NXg3Wlk0NmlkaXZ5SDduYjVjQlpna05Z?=
 =?utf-8?B?bWRBZnc1eUZOYjVtdDM5UXB1WlVRQU1saHNwazNGWDFmTkphU2R0YkNaTEtN?=
 =?utf-8?B?MjYwYUVVdVd6Uk5xYUk3eEc3ajJtb2F3d0thT2FVRURtSEsvSFNIUDJqVUs4?=
 =?utf-8?B?RkNVUmIwMkgzTjVIY1BqU3FjTXBiNFJkTWlxNWpEb285R1hrdTlSVWx3WThh?=
 =?utf-8?B?OFZ4TkJkN2RZTWdwQVVkOVNYcFJDL2NQYVV3aUdycmIxeTk1VVdYNVZHS3NQ?=
 =?utf-8?B?RUdzWGtxVDc1Nzdwby9YMlozVEl0K2JCQkl1Znd5dnVWVnN0eVNTMmQ1bWhO?=
 =?utf-8?B?NFpEY1pwMExXekdBdEIvNThFblBtTnpBRURqL21VWUFOMzRUWWR0N3JQSTZC?=
 =?utf-8?B?SE9BMHY5VDdxbUVhc3lONUQ3ejFJbWtQai85ZjVocGNFeGJGUmx4YVBvNG4y?=
 =?utf-8?B?L1NTenVNNEFwTUduazBlbmgreE1XeE5kdktDS0cwRUlHWWJ5ZmxYMHBoOHNV?=
 =?utf-8?B?WVJ4REJsaDhlRHNIdDlySUVBNDN1UUJVRWRIUmxSRWloU1VUQjVnUmQvdE1B?=
 =?utf-8?B?R3JSSnBBRzc4dGthR3Q0SmF4b0ZyeGNnOWRlOWdENTI5aUxzSUloamZxVEtq?=
 =?utf-8?B?ak02YjZLeitsVy80ekVxbmRKdXdVcDZ2RGIvNUtFbjBHSEltdk9xSVloYmtM?=
 =?utf-8?B?S0ZWd0k5NHYrM1lqUXBHVjRlVksxR1kybVlIUm5lYlZwTEhDaXo1Tk1Kb0N5?=
 =?utf-8?B?RkNKVEVmdlkzNTdyN0RSeDVDekZ0d0ltZGZKMTVhTU1tMTN5bzg3K1lKakJt?=
 =?utf-8?B?OXg5T0tKOWEyK2FHbmFzRkVCMjAydGZid1VPZTFGUFVXOFE2YVdOY1FxcHlG?=
 =?utf-8?B?dHptWU5CN3RsNWg4SHJkaHo5aWNVdzlCWUhaUkpMcWdNRTZTQUNjVng0aCtJ?=
 =?utf-8?B?bFF0UkJOUUh6Q1JXRktKRGQyejdWWWJFKzZZSnArZ0h3WTZKQlROM2F0RnVP?=
 =?utf-8?B?UlZvTXQ4cW9hRkRsSDR4bitrRFJYdzBhOVM2THQ4RmdSWjhlenJkNm5hSmlU?=
 =?utf-8?Q?aOIReBliVnLMw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUNNUDB3ZDJGdktBVXQ0bmlZUzBxRU50UGZFK09rUG1HOXBTcVN0TG56SUhl?=
 =?utf-8?B?a1N0NXpQVnJROUUrZnU2OGlZeHFrTXFmeWN4VTU3Tm5kMWpjdWlkYTZCWWVD?=
 =?utf-8?B?OUtGVkl1L1NqbmdiKzBPRWc1MEhrMFRzemFmY2UxV0o2Zzg5Z3IyZTc0UGtC?=
 =?utf-8?B?V2xqUFYyL3orZlU0Z1grYWI0dXJpUFY3UzV4cmZuN1lPaWtRZlB3U0VmdDJB?=
 =?utf-8?B?UG5MekFmam5KTmZwaXdrTFNjWWhFZGlCQWNjSUJGd21lSkRVOW4wbk54MWVZ?=
 =?utf-8?B?MW9uV1hieVNKRWFtQ3V0WnNXM2E0aDNjcGhMak0vRys4azhrb0Q2b1lhVTdw?=
 =?utf-8?B?ZHllY0YxaXdRY1J1M1VBRlBicytEY0pjMDdHV2N3MEJnMlhBUG9zaUhGVVBM?=
 =?utf-8?B?SzZUR0lNUXpJWDhrbjYxU242V1Z0K09vUUZZQWJXV0ZranVESnllUUhxR1dR?=
 =?utf-8?B?YTlwVWYrRjRueGdzK2xJeDN1WHNJbUFQSnA3dE1SMzlsNitUZkZVdG5KdG80?=
 =?utf-8?B?bDI4VEZRaFU4R3hkUnVmdEhhVEN2ditjM3NmYmx3dHZTcW14R1ZpMWtrOGxv?=
 =?utf-8?B?aCtmN3ZsTUt0SkVzS3VrY2pEODYybk9EVzhhT3ZkeXBPdVNEQkJBQWZBK3RN?=
 =?utf-8?B?TTNWUnY0WGk0QVY5RUI4QW84cWdVcW9kNkZFdzdscGEwRmRpRkwxN3dMS0Zr?=
 =?utf-8?B?aCt6RlozbFVNWmw3SUVWSENRZUpMYnNCQ3RYWXVlWjJFZS8rMGRhMDVvdHpu?=
 =?utf-8?B?cmlCaDJJK1FudHEzRWRxZTVzMEc2K045M3pXbWk1Y3lGTDE3bU1xZHJXdEdV?=
 =?utf-8?B?Q3dMVlVHd2ZIc0VJODVaandIMlVnUWF3VjdpNzlBYzZkNzBIY3NOZHBvQUJC?=
 =?utf-8?B?TlhUdnlrYU5KaVl1Zm5PWlUrTVBZREtsYlZNRXRmTzdPbUxwZWx4RzBoOHZD?=
 =?utf-8?B?VHc4cFNiVHlKTklHSlZ5SXExL3ljUHRRYm5GV3BGbm1VSmdPY0JCMk1xMFdz?=
 =?utf-8?B?WEdDeWgrZ3NaL1BaWUc1NUQ0QW1vd1phb1g3bnJsOXR6eDJBR1NzaTQraUt5?=
 =?utf-8?B?TUFkU1pIWElHYzVhSUpIcGxXWE53a3NSSEk2UlJ1bml6bkJFVmhabVRJREMx?=
 =?utf-8?B?QnRGaVJmVG9XQnNPanNvL2ZQMTRKazRpSjZXUVRFR2lGRkRrN2VrcjBTbERI?=
 =?utf-8?B?L3YwOHlIYUEzM1VrQ25pa0tWSlVWc1FOdEVzc3UwT3M0SWdSeEJtbXVWRTFU?=
 =?utf-8?B?cGkxaGtHWnVXRGJzSHkxdzNwUjVBbEEwMnJhbElYSTFaUlhYdEFIZUg2SVg1?=
 =?utf-8?B?dEpQUzQ3MUY0VXZUblppWXc4RTNzcXRTRUlieDNweGt3YzJwV09XVG9vcFF6?=
 =?utf-8?B?cThqZEtiZUN5SGFLb1RTa290dFVac2I1WEFnSDJzTUQremFibFprTmVoK0kr?=
 =?utf-8?B?c25COXd6Tk11RHRCUERzS1lHeXRlYndDMklFM09KWGhMOTJLSThxakhFR2Qx?=
 =?utf-8?B?ZEh1N1hITU5sWlJya1BRdVpBN0ZmYTBOZjdXck9JREdVRDEyT01mSHBsYytK?=
 =?utf-8?B?K0ZwbVpaRGxHY2hHMnBkWnJDTEFYS2NlUGRDa0dBd2JmbkRjeExFQXRhZkdv?=
 =?utf-8?B?eWVuQnp1ckJXVi9wbnpWMEIzK0NyTVZJaGVTTXMyV3FlUnBSeWxaTEplZVVD?=
 =?utf-8?B?NmdzcjAxVkdJRU56RXY1UEprMWJGdklMc1ZTSExwZVNwRnVUbjdHL0lhUXpJ?=
 =?utf-8?B?L3pOMDB5RXVqQ0RKOWhFWWN3eDhraStyc29UajdpeW1vTWM0ME9YRlE1VjNG?=
 =?utf-8?B?UU1IeDdKUmF1Y05vaGozSFZqWUV2RmF6LzUrZG9qTUl3bUk3QjBLcDhwUlBW?=
 =?utf-8?B?S3IrRXRkeE9PWEl6WlZiM3pXQmtVUG5UZWR4N3FUMnk1UGxaVlBpZGEvQzYy?=
 =?utf-8?B?WVZoWWxaL3F3MVJONEFFRm5yb2RCNzJxZ0VqSjV5VWdoQXZEOTlocjNyd1hk?=
 =?utf-8?B?cVRDRkNET2NRUGdUdEhaNHhTekRMZ00yV2NYZCt5ZjljbkkrQUNINTk4RW9j?=
 =?utf-8?B?VE95ZEx0MFJYbkwwU1RtRWtYZUJ5TTZoQm13cEhSV2k4SFJCYzlRRjRsSGli?=
 =?utf-8?Q?eq/RXrVC+Vt9PrQtpIw7Nrb33?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e334dac4-ccc8-4c37-37cc-08dcf783a780
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 19:06:40.3650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W77i2dcd1YOj2GEBw28Tk2rkQHBJqC6DLfsPi+81pW9cFD2LIEnU/9qYJMEeI0CxUvlX+l3nIEVK/t7WbBfZNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946

Add support for i.MX8Q series (i.MX8QM, i.MX8QXP, and i.MX8DXL) PCIe
Endpoint (EP). On i.MX8Q platforms, the PCI bus addresses differ from the
CPU addresses. The DesignWare (DWC) driver already handles this in the
common code.

Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Chagne from v3 to v6
- none
change from v2 to v3
- add Mani's review tag
- Add pci->using_dtbus_info = true;
---
 drivers/pci/controller/dwc/pci-imx6.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 8102a02a00b38..94f3411352bf0 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -70,6 +70,7 @@ enum imx_pcie_variants {
 	IMX8MQ_EP,
 	IMX8MM_EP,
 	IMX8MP_EP,
+	IMX8Q_EP,
 	IMX95_EP,
 };
 
@@ -1061,6 +1062,16 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
 	.align = SZ_64K,
 };
 
+static const struct pci_epc_features imx8q_pcie_epc_features = {
+	.linkup_notifier = false,
+	.msi_capable = true,
+	.msix_capable = false,
+	.bar[BAR_1] = { .type = BAR_RESERVED, },
+	.bar[BAR_3] = { .type = BAR_RESERVED, },
+	.bar[BAR_5] = { .type = BAR_RESERVED, },
+	.align = SZ_64K,
+};
+
 /*
  * BAR#	| Default BAR enable	| Default BAR Type	| Default BAR Size	| BAR Sizing Scheme
  * ================================================================================================
@@ -1627,6 +1638,14 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.epc_features = &imx8m_pcie_epc_features,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
 	},
+	[IMX8Q_EP] = {
+		.variant = IMX8Q_EP,
+		.flags = IMX_PCIE_FLAG_HAS_PHYDRV,
+		.mode = DW_PCIE_EP_TYPE,
+		.epc_features = &imx8q_pcie_epc_features,
+		.clk_names = imx8q_clks,
+		.clks_cnt = ARRAY_SIZE(imx8q_clks),
+	},
 	[IMX95_EP] = {
 		.variant = IMX95_EP,
 		.flags = IMX_PCIE_FLAG_HAS_SERDES |
@@ -1656,6 +1675,7 @@ static const struct of_device_id imx_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
 	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
+	{ .compatible = "fsl,imx8q-pcie-ep", .data = &drvdata[IMX8Q_EP], },
 	{ .compatible = "fsl,imx95-pcie-ep", .data = &drvdata[IMX95_EP], },
 	{},
 };

-- 
2.34.1


