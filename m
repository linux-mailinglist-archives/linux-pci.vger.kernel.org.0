Return-Path: <linux-pci+bounces-13470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD81E985135
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 05:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BAFCB21491
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 03:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7751494BB;
	Wed, 25 Sep 2024 03:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RVFxrc3z"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012041.outbound.protection.outlook.com [52.101.66.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06B113A3ED;
	Wed, 25 Sep 2024 03:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727233580; cv=fail; b=SewmISOvEH7vNvCR6hSlnvM5U7Fu72MsuEKEvsxVsFsETg8YkEd27ImknmheZNPQxehyVaJVEtE9gPXzoVK0wr13EKdft7WIiT/7pdyEevyHclIqDdV0eLW1EBExcqfKiqs6W3YMKRo2AzSJ4+ZLAJvQ8RO0T/CuUQPxZJQwuCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727233580; c=relaxed/simple;
	bh=JIj6QBnYZIrI+0wfBY1WxgoG334VdgULp4MS2Km0vLQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZjHYDnP6f8bdju8Ega39iVCsgdxJxv3t7aWAKWb1T9omp8y28ypPGYXaKHjrRaiaItlROp68ymXaR7K43Gc7hREiTLscMrgaKALWhUILrKG0EoUvT7Yto0nDzUM1YxaEoyUc8V6/TqrEFnC8c02NoP7JMYPgf6W3J7hStC7eNQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RVFxrc3z; arc=fail smtp.client-ip=52.101.66.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=de6kv7baSPTNOnu8+cKJyjXtyAS6sNLmmjbi+PANxgxT/TR5p2dz9fiDtmV7Fdzu/9PvtpkmjjV4klkNdloXXkT/mKXGhCWDUCup9lem+o63LfUr99/6s7ym4QwvZrxGuDhKVFaW6R4t7quB+A48DsYza3Ijt0/6OJndX17G1/+PJU5mG3PgPWuF8ZFvIASAnNxsnQRUlNJYjEGxmpEINxPnBGaqekAO6VxyhwySLRvfbdVVVMzhZjLnjej2UUl2qaw8q1Lyfp9+ivWYLgfDTUq/XPsEG7LVIEFcJEAEbFcDW6uzm+20H4DlwoEvMHWFMbsRDxANc1brFPEZsoIhpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIj6QBnYZIrI+0wfBY1WxgoG334VdgULp4MS2Km0vLQ=;
 b=pcUaRFpbQoe21Eja40D6N6sqvJUAanIJHbojTehUzqxjNX0eF/7xnNxa5QWtbjYEWravHfJ3oO6rg21g4JjK8MayFXPbOXpCumDYFaldjDe7YDlvXcYYf4M8lxO+JcKUpWNUIiCvrmeU6iC2dWrPeGaw2LiUHy7Q4d5krXVddMxRAOd8ll8J3b8lT7GGqjce2a7vdoWeXfqILJJSzMP8JsxUcB67eqCIsa6y4yCgWUbWdSNXw/eImYQcBLfb8GJ9x+SF2KqrF3NfN3KpbtJoVmOwHUvQXG0SO46TXBu6xSuHw+8OmxtRzv+w7TuNRj+zVTPRS6EJxpCfcRhLOvVrRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIj6QBnYZIrI+0wfBY1WxgoG334VdgULp4MS2Km0vLQ=;
 b=RVFxrc3zfn0k3VIs6WhYxsU5qYlHD9KvKDJnnB01ueJ7mbwvyohHjR8Xuqcio6X7Fp1nzCs4z7r4UGUETkW240rf5W7HzL7vSVH3OQT2Bp+fSUJDy3sEMirF+8sgsDXeZXSrOXeomTZ+3AJ6wsltkEDn5lszKpuGyWcoLzYvmpD1qOjO2coyqbLSaboD4VRYv9jSHuouGvfxqPUsOILDNzvZLJEN2M9QBHAMYmJx0+jyc3HIVXS0eOSjQL5K3TY+c0Mq6ljcYEoDUKqb3ikmF4hwscSE9BhnKgdFIfIah8xtK5BBG8K/NLuypZ1dKYNtzW375xQ4f3uX4443OTD+0A==
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com (2603:10a6:10:2dc::14)
 by GVXPR04MB10081.eurprd04.prod.outlook.com (2603:10a6:150:1b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 03:06:09 +0000
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::6b10:a2e8:fdf0:6bdd]) by DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::6b10:a2e8:fdf0:6bdd%4]) with mapi id 15.20.7918.024; Wed, 25 Sep 2024
 03:06:09 +0000
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
Subject: RE: [PATCH v2 3/4] PCI: imx6: Pass correct sub mode when calling
 phy_set_mode_ext()
Thread-Topic: [PATCH v2 3/4] PCI: imx6: Pass correct sub mode when calling
 phy_set_mode_ext()
Thread-Index: AQHbDerXAasKwjNqoEGgFTy+4XDnq7Jn0tpA
Date: Wed, 25 Sep 2024 03:06:09 +0000
Message-ID:
 <DU2PR04MB8677671D9E1C54C871B97C538C692@DU2PR04MB8677.eurprd04.prod.outlook.com>
References: <20240923-pcie_ep_range-v2-0-78d2ea434d9f@nxp.com>
 <20240923-pcie_ep_range-v2-3-78d2ea434d9f@nxp.com>
In-Reply-To: <20240923-pcie_ep_range-v2-3-78d2ea434d9f@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8677:EE_|GVXPR04MB10081:EE_
x-ms-office365-filtering-correlation-id: 9f8b58d1-406e-4006-b005-08dcdd0f0118
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UFhZMERpZ2tuM0xqaTdoMndydXo3TFNXMkdLdFJVV21kR3pXYzFDYzRYWkEw?=
 =?utf-8?B?SU16NmxSYjFHQkp0WmZ2UDgralRyVmpmK1VWb2ZQTHpQdkZqaVYvd2ZUU2Ny?=
 =?utf-8?B?NnBZc3BKQzRvY1ZJeXNBc0ErYnFNWk42QmRZUDRzUVhLSE4xd1htTDFYSXRw?=
 =?utf-8?B?QjMwYUUrQVVVMXlqZE1IZHQyb3RhQ1RLVjJiM2JwMkIyUmUzVEUrODFlRit0?=
 =?utf-8?B?cmZsOTZhcG9ua3MrWGRFMnZiWFpNeE5lQlUxNGdGZnA5OElSbmxVK0N1K1FM?=
 =?utf-8?B?eUNYRGFjcjNXS0VjWGlHZnVTc1VBdGFMc3FPYitKUmNWTEwzcU5kVURpTlM4?=
 =?utf-8?B?Y0o1VnJWcVpqeE9UT1lhU2dLTEhaVEJWNUhtMCtzaE95TklvdVh5N3BQcTIw?=
 =?utf-8?B?eFgxZE5xd1VSNllyUmRoNjhPQ1l2Y2IweFYwMUplaVJwbG5vV3Vhc1QvaCtM?=
 =?utf-8?B?dXlzY09JRS8xQVdNclJ3ZndTbVZQOFhLQVBOQ0IrYXFXbjg4ckkwRHFmNm95?=
 =?utf-8?B?VzRERUlqZU1MQlhvc1VPeEtkNnpUcUp1a3RCaTFLWkpVeHJFVWhpbW1CRVlt?=
 =?utf-8?B?TWpYVDZUeFFGWERRWFJNc2NEemUzZHBRdG1jME9sWkNSaVVzelNzOXljRzRB?=
 =?utf-8?B?VVlMYTVVMmdZMGMrWWJBR2JRZzIzcW9UbUhiWGpycmNoMmJNR2JaUTI3ejJ1?=
 =?utf-8?B?UlhJSDUxaTg5UGpBNmF0TUQrU1VDZit5eC9jZ1V6SVhDUm4xdk1zK1hpSE9Q?=
 =?utf-8?B?S3BBMkVESm9IaDlsdGhIZ3RVejY4TS8xVGM3UjM2TkVMdXI5aHNJblVyaFpK?=
 =?utf-8?B?Y01YSGoxbGVmY2lSdEZ3bmQxNy9pekVxZ3lOdGtIYUNyWDZUMTcxYXZBVTcr?=
 =?utf-8?B?dkk2M2l6RlE2L25kdEFVZHhoTC9jM0gvclhaOTNqVERNVmlJRVI1Q2FSVnBo?=
 =?utf-8?B?WU9pZGp6MzREUi95R00xeGNDTzhBdkJwaXpPcmltK2NBWjY2aGh0bzBaNWdl?=
 =?utf-8?B?ank4cHBpZFBCVTVIRlNYeFhLR1dueWtUVThuT3NDSmRLZUc4U3k2ZjNQaGIv?=
 =?utf-8?B?QXY5L01ma2tSNmNidXNYL3o4QkFjOXpiNDR6ZDVpVllFNW8vZ0YyTUg4NVpH?=
 =?utf-8?B?STdXbVVZWmlDamgvK0JGRmdtbEZ0T3Faajg2c3hMN1Z1NnNja1hMR2g5Yk5N?=
 =?utf-8?B?VHlaTlpMY1l4b2RFR1ZwOTFpU1VkbHI4akFyblR3dGZtdnFNREt4NE5zTHZq?=
 =?utf-8?B?YnlWMklBL2p6YkVZN29yWm1HTVBZRnRDc0JZcUxYVmRWRjZFb2Zkc1UxYk5S?=
 =?utf-8?B?Uk5wYytDS2VyK0RKS1AreVFUWUZTMG1YNUNrWXdVMWp5L2VvNmMyRlhRWTRC?=
 =?utf-8?B?aFRCUHBvSzM5VWRncGprdEQwU1BocnZ2UnFzaTJQSzVCdkRmUmhGNEcrZEpz?=
 =?utf-8?B?Q09tMGl5U2lBK2RMSUVJdk5SaTNnMXpVL3JkUm8xWFlGVjhXYm9FVFFoYmpn?=
 =?utf-8?B?a282c0hwdEZNRUN0cU5haUFUN2ZnbnlReEE0bEd0eG1PVDU0dW81eFEvM0pY?=
 =?utf-8?B?Y3N2dTRiUllhZkxwNlBCek5lbFd2dkFJWFFEd2xsQjRyNUl1eElQaDF2K2Z1?=
 =?utf-8?B?eHpEc3ZyaEZPUm0rQ3FFQjVaR0l6RlJYTzJNbnlGYUVDdjdONHZZWWZya2pC?=
 =?utf-8?B?L01zWFNZQ0IxMGRwZzVxUXd4TFlKQ0I5bDZHakhVOHVrOVFlZE5vWXk4UXgw?=
 =?utf-8?B?bW0xRHUyb1BDbG5vWWYvUStxbUo3NjBDbWxiR2N0R2hJeG95c2NkL3hvUzhi?=
 =?utf-8?Q?G41o2WkC2ECE3I/u5Bcfm4cn+hIIyJ4Mw9xsI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8677.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWlZanpjOGlOSU83UDI4N1Ireno3NEZjY3JxMHNVZmJTVzljT2YxODFDNFVy?=
 =?utf-8?B?MVQwRU9wUlEzbkpMSG1Qb3NrUm9BOXYyUUpTczkwZEN1WGQwak5FSERYODJY?=
 =?utf-8?B?ekFmSzkyTk9xUit6aWRyL2owN1VjdjdFc3dkSUYxVEZpdkk4aWhTanNBYWJK?=
 =?utf-8?B?R3FqTUpoSFo4UTEvamVXYVdnWithUDJVWndQRXUvSGRjWldML2lvL3RTZUJx?=
 =?utf-8?B?UURudDdVUkdJSkpJRlJ6eHFrcUVaWWJlNmsxNUJ3ckFnRklCSFFNbGZVVTRE?=
 =?utf-8?B?MHVwYXJMVWlZRkZuZklNSnc1S0w3OUgva1d1cXB1NzVxV3lvZ2orMVFyMHpa?=
 =?utf-8?B?Rk40KzVvWHAydU5lcVhuUTV0K2dpNlFjaFZuT1NBRnkrakU4V2UxK2t2MCsw?=
 =?utf-8?B?QVBrcFpLNFlQZk5CMUVKeDhYajRqSnRkS1kzYmJXNDF2bmhkRXlKWFpEdVZL?=
 =?utf-8?B?ZGFvV3hwUTkzMHUxRE5pZURPYjMyM20vT3NZTTR6VXN5T0x2QzFsZzZuWDc2?=
 =?utf-8?B?eGtaZG9Wd1c4S1dQR2hGc3U3ZWRDNWtkOHV2bW13a1BsaHBsN2tQTmMzZk9p?=
 =?utf-8?B?RFlTcTBzcFhnRHhoTHpGUUFPbFpEM3dQOHVaUG1UYndmZUZLWFBRd3l5aDlK?=
 =?utf-8?B?ZzBTc08wK1BINjM2eVArakFnSE85Qk9VTnh1K05KS0VOSWFuVndKdW5vUHIw?=
 =?utf-8?B?TGprM1A5S09zcHU2TC91M0o2K3pLTkgvd0FYZ3ppcHJSZW0xR1NXZ0ljRGVO?=
 =?utf-8?B?UDB1SEdkOFVnVk00eGVXazZvRnlLYVNGT1RhSFl0SzZ2NzNWcDlrUDZLZWd3?=
 =?utf-8?B?VUpCL3lLTHFFbmcwalZIM3cyN00xMldDZWZ0bksrdE94dFpSOVZacTAxQ2Nj?=
 =?utf-8?B?TFdiWEdLbk1rTnUyVWl0MzBJUWVNV3VpUnFKb3NEWkdlV0hZQXBtTmtCSlhM?=
 =?utf-8?B?ZWgxMFNhc1dKNVdwRUlkMVZWUitybThpdmR1eG00Ky9yandzZlV2akh0L1lP?=
 =?utf-8?B?MlczN2twWkZENDJUMzIwdEgvbTlOYmpzNjhKRDRkNlNOMDNrRG10S0I1Rjh0?=
 =?utf-8?B?dURhRHVIeVJ2cUI4ZHVUUElIN1o1SExYWE96a0Y5UjVBTVNiS2dyVjRITmY5?=
 =?utf-8?B?QnFuR0F4NGZJNDRhWEZBVFFOaEc1dWZ3NHFaSVNoMjcwVEdDaDllZVhFU0Yr?=
 =?utf-8?B?VmRzYW93WDlmSWV2QXk2bHRUY2JiSFBIaDE0VGp0RGxheGdtdmdGV2dGTzhh?=
 =?utf-8?B?UStZdEpYZ3VYVTA1QkRNUFB6cWNNbGVRTnk1c1kydmVFQmNzK1dLTlZxd1Nw?=
 =?utf-8?B?elV3Z3QybjVQbytNQit4MWNZNHF3VWJzUVpIQkYrYnQ1clc0UkZvK2lhTEtt?=
 =?utf-8?B?c3pyRHRaaU1GQ3hMZTRaQXBKZFBPMk16OGJpbVJBamFKSDY5T1ZhWVZDNDM5?=
 =?utf-8?B?cmVTVVE2RU1wZU81Rk4xN2J4Nk5qMlNlVlpDT2pDSk9OV0orQ2ZKNFNWc3Iw?=
 =?utf-8?B?cGlIUXNmREFQSUZOMUJWbGFDTnUvMU9MUWtHalRXOG9LT3BiVTN0SDUwNE1J?=
 =?utf-8?B?bjFLOE1YVzhKV3UzSkE4VElGbVdkQkY1RFh4aXJYU2thTTIxRXlnOXdYOVpU?=
 =?utf-8?B?Wi9Fa0RudERBRHdORS9JL3dCNW9nczlDTzBZQ2RrQTMwK3NNazdFY3NxY0hh?=
 =?utf-8?B?am00bno1aWhIQzhDaHd3SzJRSXNtdnVoQVltbnZGZ1M5VW5VVVZoVU9RdUZX?=
 =?utf-8?B?emdlUy9yZms5ekRiUCt5YWJHQ2dLUWZydGwxOFhYTG5XdUpuRmswbE1KTURS?=
 =?utf-8?B?MFIyUWtSeHFQTTNxR2lNMCtYVnMvNGR2TzM5SXZkdlJsdm9wNi9oUDdtWmxI?=
 =?utf-8?B?MW9lb0lTYWV4V2JVU3FkZ0hzQ1VlRDNtUVZRSS9va3ZDbmJPNlUxa0lwejZz?=
 =?utf-8?B?d0ZYUUNvWk55VG5jbFFmejFCdDFTbk9RS3M2cmgzUmRteFZiYUFzMmluc0dQ?=
 =?utf-8?B?bUp2dzRubExNY04zVEUwSWlKNnBkWTd4cTkzeHNGckM4eW9ZSkIrZk1NTXRl?=
 =?utf-8?B?WTdyOHZyOXVQWmh0WEI1TVFKdHRrckNnNndwd3lMZXdVVEt3cTZWTzJWWnFo?=
 =?utf-8?Q?bEYG++rYqkR8kKBlVREWX/FaM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8b58d1-406e-4006-b005-08dcdd0f0118
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 03:06:09.1913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RKp9Z+1yew2lc345qu5SMEq7pC/TDDf9urD/B9qmc6xihS4VGIi6ur9eX5Fg93pSNP2ufBKgBXENwBHHfiyPHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10081

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
PjsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MiAzLzRd
IFBDSTogaW14NjogUGFzcyBjb3JyZWN0IHN1YiBtb2RlIHdoZW4gY2FsbGluZw0KPiBwaHlfc2V0
X21vZGVfZXh0KCkNCj4gDQo+IEZpeCBoYXJkY29kaW5nIHRvIFJvb3QgQ29tcGxleCAoUkMpIG1v
ZGUgYnkgYWRkaW5nIGEgZHJ2ZGF0YSBtb2RlIGNoZWNrLg0KPiBQYXNzIFBIWV9NT0RFX1BDSUVf
RVAgaWYgdGhlIFBDSSBjb250cm9sbGVyIG9wZXJhdGVzIGluIEVuZHBvaW50IChFUCkNCj4gbW9k
ZS4NCj4gDQo+IEZpeGVzOiA4MDI2ZjJkOGU4YTkgKCJQQ0k6IGlteDY6IENhbGwgY29tbW9uIFBI
WSBBUEkgdG8gc2V0IG1vZGUsIHNwZWVkLA0KPiBhbmQgc3VibW9kZSIpDQo+IFNpZ25lZC1vZmYt
Ynk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29tPg0KDQpSZXZpZXdlZC1ieTogUmljaGFyZCBa
aHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+
IC0tLQ0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYyB8IDQgKysrLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gYi9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+IGluZGV4IDgwOGQxZjEwNTQx
NzMuLmJkYzJiMzcyZTZjMTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaS1pbXg2LmMNCj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlt
eDYuYw0KPiBAQCAtOTYxLDcgKzk2MSw5IEBAIHN0YXRpYyBpbnQgaW14X3BjaWVfaG9zdF9pbml0
KHN0cnVjdCBkd19wY2llX3JwICpwcCkNCj4gIAkJCWdvdG8gZXJyX2Nsa19kaXNhYmxlOw0KPiAg
CQl9DQo+IA0KPiAtCQlyZXQgPSBwaHlfc2V0X21vZGVfZXh0KGlteF9wY2llLT5waHksIFBIWV9N
T0RFX1BDSUUsDQo+IFBIWV9NT0RFX1BDSUVfUkMpOw0KPiArCQlyZXQgPSBwaHlfc2V0X21vZGVf
ZXh0KGlteF9wY2llLT5waHksIFBIWV9NT0RFX1BDSUUsDQo+ICsJCQkJICAgICAgIGlteF9wY2ll
LT5kcnZkYXRhLT5tb2RlID09DQo+IERXX1BDSUVfRVBfVFlQRSA/DQo+ICsJCQkJCQlQSFlfTU9E
RV9QQ0lFX0VQIDogUEhZX01PREVfUENJRV9SQyk7DQo+ICAJCWlmIChyZXQpIHsNCj4gIAkJCWRl
dl9lcnIoZGV2LCAidW5hYmxlIHRvIHNldCBQQ0llIFBIWSBtb2RlXG4iKTsNCj4gIAkJCWdvdG8g
ZXJyX3BoeV9leGl0Ow0KPiANCj4gLS0NCj4gMi4zNC4xDQoNCg==

