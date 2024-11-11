Return-Path: <linux-pci+bounces-16451-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9739C4275
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 17:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE42285B78
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 16:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D6A19D08A;
	Mon, 11 Nov 2024 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FEN5MEFa"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C45B54728;
	Mon, 11 Nov 2024 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731341899; cv=fail; b=YX4qu1euJfR26PDHOTfA4ACYfB1E3xI7UcDoMdw5PQly5mM+DLECr/VzZs0jken5Cahj59tBO+V/xllC3hdoKDRPthLZNCtEZKdGLlosdh7P+gQca+Lhmp3G1ysnfge2eDEVC8XrxO72YroenAapdHTJwTQaAZ1R6+/b+E6v1EI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731341899; c=relaxed/simple;
	bh=nUaSiwQA9OHl+ya2gD7cmHNJqKLoPd07Au3+ChrbYsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MKQecuO14FbaLRSrDBveumIfA80nUTnRzPwSGyMjH/Ae5vT9/0KFXMZjSqDMB3lmOnbV2mDi1lgqkrWE2g+uLJ6oAPXRaTUetVqBIWsM/R7nzWeJjC3lGqiEW+Ou7nMFUuQySnp7JaqSETBellFbb//TKWOWZi7pyXS5MlcAltM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FEN5MEFa; arc=fail smtp.client-ip=40.107.21.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXrMb99nj7bm19LeyETCNGxOO11rPqlMdT7QYUFUnEsJ/Rz0CApn7u8ftyI+PzonXcZPyof+Att8wcEYyeoH+RXFJfT+AK3j0sY2mj6glciidpl3K+K7mUq1fu6DMY72Wy3IdSJM7mqDNH6FHM0xrvc9GVHALLwOP+ycY61lNAObzFdvWa5ERvHzWeCvgf+4+GYQmAWswInd0PWwOqiU+Bf5DRJBN1moSnd0TI4Hd9EKCsYBbH5tw2L6AS9iZGQoYD3ozD/hCf9QFNmOFEWKXGTcBJIrkb+e+YLckHU6oCld5aaI/GQC9kPsgVtlOIVuSsiYsi7u7ZzIrLM0hp8x7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCZQthyOH7dZGlaP/X9ZHU0x/q4RyJ8stekV+S7c5io=;
 b=pH+3tC2pLGos+b8autL9sWRVcN0OireouzeQnAKXLa6zjqTBjIW3HgrR7KES6Top69RIYlORgNSK7gKsZdshk35UUlkxQImAaGJV9CkuchRmDkR8j2Z8WQ4NeQKoUkD5pIOTr3zGCISyMNqWlL8GJtVTmBx2ga0IRybzcCTiBo7VmwKJaydg1nKJnETbR2jcRLbrkngGEFWSdZ1v1zNXN/dkwBJxC8t0LWfCM6fJcw/A8pxK3mRoHaSBVqFpfDmu7sSdHtzdxo+4M9aO9l11WpUdGmwnXKy5jIPJ+YBkWsRmdDgVlXqWxPny8O3EP8ehENgGJR7d/FdKhHACsgwwXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCZQthyOH7dZGlaP/X9ZHU0x/q4RyJ8stekV+S7c5io=;
 b=FEN5MEFaC0swCyzhzd54PU02gJ7MjdGCo/ry4dqxQAc9j/78qdpF30un/nAxbR8vikQElINcHndbosETHUgec6TOKZum07UN+zEuMOgJa4TdByOCd6qFwNiINBCaVcx9/Y7XQzjz40gBF5m4rLNLrF3vqvZmxaY9u15P93o/bPEYsHE32JhwO3E3aGwCmbmRD94Q4bFroGo7eTuPpVHGF4Hfljv4WG5YWM2DbLgG2omaB+Ym5Z2oqbqc43hLm7AMUFSIe7ulT0xYEzE72IOBMYAlWluVSgUPUYY7pRecse3UK6fH7qcesl3jZQcQGl466mUlU2yunWOBqeJ3XsKaCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU0PR04MB9371.eurprd04.prod.outlook.com (2603:10a6:10:35a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 16:18:13 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 16:18:13 +0000
Date: Mon, 11 Nov 2024 11:18:05 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Hongxing Zhu <hongxing.zhu@nxp.com>,
	Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Message-ID: <ZzIuPYAXUVWUMs9+@lizhi-Precision-Tower-5810>
References: <20241108002425.GA1631063@bhelgaas>
 <b5f56ec9-9b5f-5369-52ed-bcf0c8012dbb@quicinc.com>
 <DU2PR04MB8677ECC185DFF1E2B62B05858C582@DU2PR04MB8677.eurprd04.prod.outlook.com>
 <20241111053322.bh6qhoigqdxui65l@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241111053322.bh6qhoigqdxui65l@thinkpad>
X-ClientProxiedBy: SJ0PR05CA0102.namprd05.prod.outlook.com
 (2603:10b6:a03:334::17) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU0PR04MB9371:EE_
X-MS-Office365-Filtering-Correlation-Id: 082e2965-d246-4dd8-531c-08dd026c70d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlI2cUlMWkdwVU1yamlSRk85Rmlab1VEa2EyZzFoQmdOWnFCVmNjaDdiOTda?=
 =?utf-8?B?UHFiRXdTT2k2NkVhU0xUZUFxTXozbm9XdUVZQ1U2TTZHazh4Yzk4YlB2b2kv?=
 =?utf-8?B?MnE3ZkxTMXpJU3BpcElTdlVhS2lpYnc3ZUFlNWR1UVI2YmpuUHNhcFRSd0Z3?=
 =?utf-8?B?UFRTRkozUm1Xak9YenFxOGVqZjhnTUg5Rm43VDZTWjBvQS96bVVZejVFYm4v?=
 =?utf-8?B?U1Z5VFdRWkt6YkoyZDJhb2hPN2tybStEMUZvZFByejdEN2VCWlVram1yV0F3?=
 =?utf-8?B?WUw3WjRtVlhJdzlrTWVVcWdMWlhvNG1pK2V4QXR3Zm03bzhYZnFERTZwN0hF?=
 =?utf-8?B?SU5aczEyUmFndVhQWGdRb28waWJDcEFZRy9YYjlpZmdZcFpGVHFkc0V6emRq?=
 =?utf-8?B?Z2hISDlyT3FWUEtXZy8yMi80TVZBTWx3TFlyUHFwMnJjNW1nYjgxZWhENzBG?=
 =?utf-8?B?MGZybXEyWjRucTQzeldHZUxkSWlPTGdGS0EyaFVOZG1lMjVCK2N2cVp6R0dQ?=
 =?utf-8?B?OHRIYmI5OWtiQThRQTNCbENCdnZwWk1ZNTViR0R6b2hZT2grdXZkbkUxa0ls?=
 =?utf-8?B?VUtldDRHZWdnMTdDQnZBQ3VuY2JLOERPd0pyL2l1V28vVTdNa2VNNVQrcERF?=
 =?utf-8?B?SkxCWDZkR1hycXNaK2pMMDJaNDNBc3p5b2RoNW5HZ1g0RVk5UXFWOHZTQjht?=
 =?utf-8?B?NVNrRVduQW5nNmlnZ29ZTE9Yd0VKSzI3Nk1NaWR5VmZQVXhRdXlkN1RiQi9l?=
 =?utf-8?B?eDVTWFkrSVUwdmRVSnI5Y0FZb1RGNCtmZUk1eW5uN3l0TUd6KzZJVlAzSWFT?=
 =?utf-8?B?TkRQM1pQUGlVOENRemRnaG1ZQTk2a2RzNm5Oa1Y0M29wTFVkU0RxcU4ybVRW?=
 =?utf-8?B?bGlZOWJGWnlvR08wWXdlMjllamNXOGE5RWlhaHo3MDcybVdlQm1NWnkrV3h4?=
 =?utf-8?B?Q3EwYTV3MHhvdHlXNnk1MkR2ek03V1h5SzhvZG1od1JteWg4RnFoN0JzQzd6?=
 =?utf-8?B?QjJkT2pEWHpXcnZQU2lyTWdodG1NZkVIWE5KZ0hkekxJaWRNOGF4UEsycTd4?=
 =?utf-8?B?M2JlNnVneFQwZU9qYjBtZDJNM1N1NjdLS1pEZDBSWG81OHRVRTgzeWdxVGpx?=
 =?utf-8?B?Ylc3WnN5V0hjZVhTY24zNE9GZFVDa3BXRUJKWFlnajZLMHZvVERTKzRFNVBt?=
 =?utf-8?B?MjUvaVB4azh6UjlMaXlPdlJBYkIzMjB2cDk1R2JseFJrRm5OcnB3bWNHUlpD?=
 =?utf-8?B?eWtmbnA0dkdnRmpzMU8rUi9WYWZIZHIvY2JFVEFKNEQvTllmMGJRWDRHRFRl?=
 =?utf-8?B?dW50Rlc4ZXlWZkV1cVh2VlBSTmN2T0ZBVGVEaEw0RHFEN1piMmgzT0RzOGIv?=
 =?utf-8?B?MFdlSWo3VEpicDJ5d1JTTkpheHd0a3FEeW5kV2VseWt0alBTUEFPYWQzd1Ro?=
 =?utf-8?B?RytuVG1tNUE4eHhoU0FZNHRjRmVJeXFUNEhlVXZqNFc3WklVd3V5eHh2MXl2?=
 =?utf-8?B?VFhvUTlkWk9FZnMvY21zdHQrckJrSllUcTNKa05aMmVpNHYyTWVJeGVmSXll?=
 =?utf-8?B?TVo0ajFiZ1lrV09RaFF1bUxmQkdscThxVTlZanI0M2dLSEZKRjN6QmpiaVVC?=
 =?utf-8?B?anZzS3o0Sm4xR2JsNGp0MGV6Sll3dmxHR1dhUDBsUFl6cmFmTlZUM3hVM3ZT?=
 =?utf-8?B?QzJGSkZHcVVSMGhGU2xGTkgxaEpYcUc3azZWTmxYQmJPbUY5b0d2eGJnYlVU?=
 =?utf-8?B?T2o1a2JPR3ZsT1dLOHE0TkFxY3ZlMyt0SVhRMDlzRWtjb0lCdzZxOHJsQWRC?=
 =?utf-8?Q?QuWKJhI36zAWAy0f4rfl05gQDXq7HfghUlU/Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ny9YeGN0b2hSczBDL0FzaW5tNGlTMVhQZ0dOV2lRU0R6cnJCU25qdTkxb3hP?=
 =?utf-8?B?M3dhVUI2QllTa2tFY1c2NWlNN2ZLMWxlMGNBM2l0SE13V0F1V2szSGVvUDdw?=
 =?utf-8?B?VzA1VFlSREwyN3dRMUpWQXFkKzdteitSbjlGZ2ZCczdGR0Ixb0wyL2JlWnZV?=
 =?utf-8?B?aEw3T1VnYlM4SFc3Z0duOS9BRGNOZ0xsWmtNTlJTSEFPZlF5RUZ5Z1dMMlFt?=
 =?utf-8?B?aW1jaVRsa3NURk5NU2xqMzFxUXREVzlmOG56eEtLN3UwSlhCYm5mWmxCN0dh?=
 =?utf-8?B?NEVoNE1BRmp5djVXWjhEdS9XTUJTQ3N2d1FUYkZ0Z1hmQWxaODhJbldhQ01l?=
 =?utf-8?B?QnJHY2ZhM29oYXhheHpiMkpaeFhRMUt5NWZCNWozL1FhKzJ2U1JiQkJqNHdz?=
 =?utf-8?B?VzJ3ZGxXeHV6V3NMZTF2SHdmTjFpcndVR0paTWZEcWJNcjVrc2RzUy9KeVFs?=
 =?utf-8?B?Z1FqdFZTUVpSdnpKNVJJb0I1eStkd24xdUtoRys0dUJwTk4yVE1HZ2RlcUgw?=
 =?utf-8?B?dU1LYmdWcTNxRDFKK3grVWlUeW5seG9UWExubGlsaGxUOGZib3Q4MlBSY0Ny?=
 =?utf-8?B?QkFDeEs3WTFBTnBzZ2JyOWRTN1d4UXdwUmFYMlZrK1lNbTU4aXBEMTNTcEti?=
 =?utf-8?B?ZTBOVTFZZktzU1dMdVpXTUIyQVc0aTllUlIxeERWbTZsSEtZUzU1Nk9xR1pV?=
 =?utf-8?B?MjMrVUIxWUNqaUhiTVh6VFFCclo2SUhNSll1N3hZZURuYWhaS01DQ0ZMUFQx?=
 =?utf-8?B?S2pMRHhFNkVZeUVBRVVxTFk1d3MvaDQrRSs5N0xYYWNJbG9KVnllZmFNSG1N?=
 =?utf-8?B?YXc2cGlPV3NsaG9iT1Jyd2tiMXJDRWpSa0o0ZW42bmIzbGFCWm1hc0ZQRDVW?=
 =?utf-8?B?cENNcFdKY09pK25HK0hlQ0JLVDZHY24ydGgzNCtBN25QU0VpaFlBVXdkVUxB?=
 =?utf-8?B?Z3VHVEo1aExQWWlPbFpXMVR0NU9EaGVBZkpaeWhFOHBMUkt2V243QkNhNnhu?=
 =?utf-8?B?a2lVbjBuWTNQTE1LY3oyRzc1emFzQVovVDFuTUZxM09GUEEveTcvSFo0UEtE?=
 =?utf-8?B?bytlaThqampmc2hNbVVLWlVzVWIxWW9Hd3I4MEw2VVRiL3VjeWVUZ0JWNTls?=
 =?utf-8?B?UVN3VGY1bUpORzZML2x6UmtSYUl3REpLZVpIZm40Q0NLT3Y4S3lRcDBZZW9U?=
 =?utf-8?B?a2gwVjhZcWRiZjB6UlJ2T2RHTHhMb1E1K2hyUWFNWFJHemlsdjJyZElBMGZv?=
 =?utf-8?B?eWNnUFFaMDhEdnNXSllVWGNBU21DeWplc3h6cU41RURlZVdyUU8yYVJjbWls?=
 =?utf-8?B?bXdvUGRqWjZFWk9YWldqdXhWYnJMdjVBU3J0OWQ3aTdvSEwrNUtydFovaEFM?=
 =?utf-8?B?RzJJaHlKVkZxanQyWFZaTmJCL3I5bXpjUWRuUjVyVjBtOVZINzFCcXB0c20z?=
 =?utf-8?B?LzVBbDcxMHpTYSs1aTRMc2ZHbXVkS05Tay92WFg5UDRTMEg5anMreHI2WGVq?=
 =?utf-8?B?b0hPbEVKdE9lM2dvQ0Z4UlUxYXhqRG5tWG1INlEwc01wdWtDMVRqZjJuUk9Z?=
 =?utf-8?B?STRTTXRBU2xMcnhnRWgwQThrSlNlalZoS0wrcFpDS2VPWU1nOU9Vb1daVHZp?=
 =?utf-8?B?U1grazRtTHVsbEtJWmZrcU1EY3JwZ1VWYmJPRGl4anVKNG5MandvR3lSWk1y?=
 =?utf-8?B?bG1hTmhneHphWlBjeWtXTHVCYzhuTUVVL2NoQVl5SWUvd25zZ2gxV2NCRndV?=
 =?utf-8?B?NjE2UzdJeXB2bENTQ1VuZjBFSnl2VnZBejRMdzhCdUplVG9LSEhERjJ5RERX?=
 =?utf-8?B?N05hU3I5Ui9jRUdOQ1hLc1JucWZScVNVUDV3L3cvb1JQakE3OGJleDlHZnkw?=
 =?utf-8?B?RXNUdWNMRWRobGl2VkNWY0Zrblp6a1JHRFJudDNmaThJYVZuemRLK3FkOHls?=
 =?utf-8?B?NFdzNTBoZW1PWFNnNVIyOWYrU0preXRtUUU0aXB1aURXK0M1N0IyalE4Y0Q4?=
 =?utf-8?B?K2M3Ym12MXBpWFhKaC85azcrNUd6QTNKbXMxZXgrWEZWbEVla29Vd1RkcCsy?=
 =?utf-8?B?Z0VnQXZhc3hwRUlsZStGQzVRWUoyVXZsaUllck1oc09LK0hxLytpem82MzQy?=
 =?utf-8?Q?cFE6Da8ftj/xlBK6EMhvtGixW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082e2965-d246-4dd8-531c-08dd026c70d7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 16:18:13.1611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aY49aUDbBbpf7M2kadhUdqcq7Jc//VXHvT3nOhoU2NKJAALzv7xjRoGa3h77slzWxiAdky6MEVVbLusq4utMEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9371

On Mon, Nov 11, 2024 at 11:03:22AM +0530, Manivannan Sadhasivam wrote:
> On Mon, Nov 11, 2024 at 03:29:18AM +0000, Hongxing Zhu wrote:
> > > -----Original Message-----
> > > From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
> > > Sent: 2024年11月10日 8:10
> > > To: Bjorn Helgaas <helgaas@kernel.org>; Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org>
> > > Cc: Hongxing Zhu <hongxing.zhu@nxp.com>; jingoohan1@gmail.com;
> > > bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> > > robh@kernel.org; Frank Li <frank.li@nxp.com>; imx@lists.linux.dev;
> > > kernel@pengutronix.de; linux-pci@vger.kernel.org;
> > > linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH v1] PCI: dwc: Clean up some unnecessary codes in
> > > dw_pcie_suspend_noirq()
> > >
> > >
> > >
> > > On 11/8/2024 5:54 AM, Bjorn Helgaas wrote:
> > > > On Thu, Nov 07, 2024 at 11:13:34AM +0000, Manivannan Sadhasivam
> > > wrote:
> > > >> On Thu, Nov 07, 2024 at 04:44:55PM +0800, Richard Zhu wrote:
> > > >>> Before sending PME_TURN_OFF, don't test the LTSSM stat. Since it's
> > > >>> safe to send PME_TURN_OFF message regardless of whether the link is
> > > >>> up or down. So, there would be no need to test the LTSSM stat before
> > > >>> sending PME_TURN_OFF message.
> > > >>
> > > >> What is the incentive to send PME_Turn_Off when link is not up?
> > > >
> > > > There's no need to send PME_Turn_Off when link is not up.
> > > >
> > > > But a link-up check is inherently racy because the link may go down
> > > > between the check and the PME_Turn_Off.  Since it's impossible for
> > > > software to guarantee the link is up, the Root Port should be able to
> > > > tolerate attempts to send PME_Turn_Off when the link is down.
> > > >
> > > > So IMO there's no need to check whether the link is up, and checking
> > > > gives the misleading impression that "we know the link is up and
> > > > therefore sending PME_Turn_Off is safe."
> > > >
> > > Hi Bjorn,
> > >
> > > I agree that link-up check is racy but once link is up and link has gone down
> > > due to some reason the ltssm state will not move detect quiet or detect act, it
> > > will go to pre detect quiet (i.e value 0f 0x5).
> > > we can assume if the link is up LTSSM state will greater than detect act even if
> > > the link was down.
> > >
> > > - Krishna Chaitanya.
> > > >>> Remove the L2 poll too, after the PME_TURN_OFF message is sent out.
> > > >>> Because the re-initialization would be done in
> > > >>> dw_pcie_resume_noirq().
> > > >>
> > > >> As Krishna explained, host needs to wait until the endpoint acks the
> > > >> message (just to give it some time to do cleanups). Then only the
> > > >> host can initiate D3Cold. It matters when the device supports L2.
> > > >
> > > > The important thing here is to be clear about the *reason* to poll for
> > > > L2 and the *event* that must wait for L2.
> > > >
> > > > I don't have any DesignWare specs, but when dw_pcie_suspend_noirq()
> > > > waits for DW_PCIE_LTSSM_L2_IDLE, I think what we're doing is waiting
> > > > for the link to be in the L2/L3 Ready pseudo-state (PCIe r6.0, sec
> > > > 5.2, fig 5-1).
> > > >
> > > > L2 and L3 are states where main power to the downstream component is
> > > > off, i.e., the component is in D3cold (r6.0, sec 5.3.2), so there is
> > > > no link in those states.
> > > >
> > > > The PME_Turn_Off handshake is part of the process to put the
> > > > downstream component in D3cold.  I think the reason for this handshake
> > > > is to allow an orderly shutdown of that component before main power is
> > > > removed.
> > > >
> > > > When the downstream component receives PME_Turn_Off, it will stop
> > > > scheduling new TLPs, but it may already have TLPs scheduled but not
> > > > yet sent.  If power were removed immediately, they would be lost.  My
> > > > understanding is that the link will not enter L2/L3 Ready until the
> > > > components on both ends have completed whatever needs to be done with
> > > > those TLPs.  (This is based on the L2/L3 discussion in the Mindshare
> > > > PCIe book; I haven't found clear spec citations for all of it.)
> > > >
> > > > I think waiting for L2/L3 Ready is to keep us from turning off main
> > > > power when the components are still trying to dispose of those TLPs.
> > > >
> > > > So I think every controller that turns off main power needs to wait
> > > > for L2/L3 Ready.
> > > >
> > > > There's also a requirement that software wait at least 100 ns after
> > > > L2/L3 Ready before turning off refclock and main power (sec
> > > > 5.3.3.2.1).
> > Thanks for the comments.
> > So, the L2 poll is better kept, since PCIe r6.0, sec 5.3.3.2.1 also recommends
> >  1ms to 10ms timeout to check L2 ready or not.
> > The v2 of this patch would only remove the LTSSM stat check when issue
> >  the PME_TURN_OFF message if there are no further comments.
> >
>
> If you unconditionally send PME_Turn_Off message, then you'd end up polling for
> L23 Ready, which may result in a timeout and users will see the error message.
> This is my concern.

Yes, may we can check if entry L2 or link down, so no such message print
for link down case.

Frank

>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்

