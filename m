Return-Path: <linux-pci+bounces-24559-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B693A6E263
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 19:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908EB16D45B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 18:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655B8264A9E;
	Mon, 24 Mar 2025 18:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="USw/Z7AP"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F4A264A98;
	Mon, 24 Mar 2025 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742841196; cv=fail; b=nqvDyjg0MwGWwLfsYlheQguyJc8oxNiC3kxkHYyBHwo/XNpG2J54Vhbvy1vnOnjAUhpod5HQWU936XnPnT6iUzG2d5hIFwvjQC7sMDI21fv7mn+AhbSp0flkZSDxSWlFmKlOoQsLHPMEYyWautfFPvRfNv9wWmllgUMXHo2AaPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742841196; c=relaxed/simple;
	bh=dNNaKLu7wRitHflO9rVD05HFceLnMhGXCvvMoRGtpIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TMXYlhSiiBf4RLbkzDrvsdrjQuswjbOSlIHjBz9hgbNJciAvbIWZOOQ742o/V3OQT/B6SJY0MubmupgZsziSaxcrCVjzJbKgaUM5UMCApB063smcFNHl6d+kQGT+WregfvFZ60JqbPK54vTk/kf8ZsIXceR+Duot1jdH9LI8n8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=USw/Z7AP; arc=fail smtp.client-ip=40.107.21.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTG9rP4v8+yWnRQZmJamh2Xo5kd3gzbbAwm0ua6LUnLSZRWxMEAfQ0zYJ9uzBSGI72z1HrHLbqIB4XS3RkhjzunuS2myqZ2tzQI0TOcZ4eUGZQxP8Adpw8RphPxIFubOUHJiKP+UMPxrpLgqHVDbKktbSL7o9LiZO6aq9hkRHcAam1b9fdzsg1LUDs5Y8PtPUIub/q6QIRSZK7tIc9IR9Mh5Znrfrz9g5C1x+Kypcj/Y247G/LLVwBIbz4qpcAFKeBD9JQ5TOOR2ghsMWk/XJOCigR2D2Uy31Fal6B136xnXaYYECEmEVzJw/rTOrJGGdmTVFvKtEU+PD6tkxSwzWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fc6H56trw4FaCq6pasAt9+y6ydSnws2oFz5WB7lkHpE=;
 b=lMppX0k7Y0uifUiNQZbWDYYyRdhYI/grfctXG7V3hVzp7HSjDTTfzcLQR0YE9yj8EZrpXm/q0937XTyFR8y6MoIf/PDrKN3gKiDBN+xK80l8laaElbwdOdvn6J55bg/u91l1MjIeRBezOxzrHHtB6JKU1IUUKY84bN855btaO9mhKz+3QGQ4kf4YQSrKfNv+owibdSWYhf9Ulg6gB0pFImebjVfoTScx5Sz+R0gsPBxorVzhvOkzsvRlBKRFAehcf6DAJrTM0iVaTO47jBSW/8Mb7+h3fz5cXfFSAJzjXi0907GDXHv+jvCJ1nyYoDcKGhWhMeU4smcYSz7b1mtcFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fc6H56trw4FaCq6pasAt9+y6ydSnws2oFz5WB7lkHpE=;
 b=USw/Z7APbTG4wzJhDm9jwVMLILYnhviKrK8TaQiPAoUU800R18ebDr3/57Qw44pbXOG1k9BbQbgwz95kUDGwJLN4xzpqwZ2xR4Iokjp6T5SNup8y7K1punKVDFGDeRnB9+SkbCUze6WIVAoL/6oA8tRH1nWvTPTyB0oX2o3lloJhTl8UZko2RbthTwymuoDeNVLMcCK+irDXvy7ZRTxVP/Y95szkOJvrMq90O4kuTODOlWLIEbcbmVzSAwJRWYKS6KrSbW2zGlyoW0A1RoUACeouvDiRfljfvomNkO7nKxejF0d3aSUqUHUOo50y8Ww8Bca4rRj5WWwTjbwBu4t8sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB9004.eurprd04.prod.outlook.com (2603:10a6:20b:40b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 18:33:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 18:33:09 +0000
Date: Mon, 24 Mar 2025 14:32:58 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 06/13] PCI: dwc: Add dw_pcie_parent_bus_offset()
 checking and debug
Message-ID: <Z+GlWm4QAkuyb9nI@lizhi-Precision-Tower-5810>
References: <20250315201548.858189-1-helgaas@kernel.org>
 <20250315201548.858189-7-helgaas@kernel.org>
 <x2r2xfxrnkihvpoqiamgjmvppverjugp5r4we7lcfpz6jloxzy@7kdfzxiwv2po>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <x2r2xfxrnkihvpoqiamgjmvppverjugp5r4we7lcfpz6jloxzy@7kdfzxiwv2po>
X-ClientProxiedBy: SJ0PR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:a03:332::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: 57982219-c901-4d9e-0fff-08dd6b0253a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmROMyswUDA2MEh5ZGc4N1MxT202L0EzT3JGbXN0dWpHMC9qZXVESmhVc3RZ?=
 =?utf-8?B?MW1PQ09WTjZ1c0NJdktWQnQ4ZU5EMTFrQzRLRjRZL1dQS3JvSjhVRVdqajNL?=
 =?utf-8?B?U0t4UDFZVEVVSm54TWR1dk90bDFHd3VTZVh0RGhEV3g2WVRmaDlaUjI2L05w?=
 =?utf-8?B?TkpnK3RBYmdoalRtdFNrVmUrbllJQkgyMHVsdUFtOEp4Qy9sTGdwWm82TUt4?=
 =?utf-8?B?U0ZESG9GeFZ2T0Y0TEF6NVIydVh3SVZMNUg2dFZ0MFoxR29zTkVyVzdwRFY0?=
 =?utf-8?B?TGJpZVA5dW5wbGVQRXBmRmwvTmphVDVDcFR4TGxLd2lDdnFJWlBwNDl0ZElU?=
 =?utf-8?B?bVE1bFVjQzZOU2N5YkdpME9raU85R2U2Y3R5WmVQUVl4REFxRDNGTFEzKzF6?=
 =?utf-8?B?U21GY2ZLcFZOeVV0TjNWeVdSR1k2Q0hRZy93aXY1a2ptN05SLzEzQW1LYUxO?=
 =?utf-8?B?Z2xnMFVlcjBwd05IYWYrd0Nmc050bUVmNzNheGN4RjE2OGJtZGdnZWZQRW1P?=
 =?utf-8?B?dE1ERTJRUU1DL3RlWnMyT0M4MHhpLzdZbFRRbVhxaExPQ2tRRCtYb0g5Ukcz?=
 =?utf-8?B?SmNXOUdYa1ZPSHNtblRKRDk4UnBUcFN5dXRPQitBUEZnWDE0THRUamRoTDNT?=
 =?utf-8?B?QXA0MWZQK3gvNzVLNUtZaFNjcnhPM3hPenhEcnUzUmxLWUlleURJdXBPMVZJ?=
 =?utf-8?B?UFR4YnZlVkZ1TCtURFVJV0lRTVpKQ3A3a0lMT1NOM0ZscjAxbmxaTzZBMDlC?=
 =?utf-8?B?MW5jQk1peVh6N1ZWVCtScElFaHJGaVUxMVp0ejdOSDJwRXRTc0t5TjN2OGll?=
 =?utf-8?B?R1ZEMkdMZEU5UW82Y0t5d3JWZGtDcGIwTTk5VlNXRUtSVFl1aGthTUZxYXc1?=
 =?utf-8?B?ZTJOS25ZcTNRTGY0bmxSOWREcS8zcis2UFJleHUvLzMvVnYxODVjVWRjU2xi?=
 =?utf-8?B?STUyNXRGanR5VjdYWWtnblRDRnRyd05EaHFDd2xqWExuWTNEQWFxT3YxTzli?=
 =?utf-8?B?Rk5yTUdTTFI4Um1sOWRSZlovRzlGeWIyRHVlbUJoVGxmMTIrZ3dQTjBsR2gx?=
 =?utf-8?B?aGVINHRxT0d2WnFwRkppUWIxNk1qdHFpdWRsdjN4Vk83a3ZlbjNuMnRyN2lP?=
 =?utf-8?B?L1BVeTVnSVlVMWg5UkJwMVowNm9pNFNZZytleTB3OGpNWnZoNW9mVitQajBt?=
 =?utf-8?B?d0k1WEtOMkF4bFBmWjdTRGt6by96RkZBWWtTT3dGYWN0RUlZczZhUUg1V29M?=
 =?utf-8?B?V1g1bTJ1T0R5NURBSnY3dHdpYlZlaXBVeEhBMndWR2NjOU5WdGtQTjFMUGlu?=
 =?utf-8?B?VUl0aXlDaHlmWUsyT0JvYUtnaGs0aE02TXIrenJOYVZkbHJ6OC8xdjhrL2pR?=
 =?utf-8?B?aW1Wak5HQ251ZkVkVVVSMWNPcGprd1gzb0ZWRURnOTZxd3pGZ2lCS1hLVmE4?=
 =?utf-8?B?a1hNazB6eld0SGhKVCtVOXEwMWxNbmY5OUZKU2xmeUpKQzNXNm11a0pMcXN2?=
 =?utf-8?B?M3JITEFXOEtYTlFKQWRSQWt2ekdsa0VrZmJOeWRtYW5IdFVkVUFUdUdFdUx0?=
 =?utf-8?B?eFpKYXl1ajdqVzFTd2M0RFlScGlZNWdORkE4QjdSMHNobHBQclNMdDZlTWRT?=
 =?utf-8?B?NU5PQXhDaDg4NzgwQzYvaTVuZTExUGtHWGZaR0xZelE0YUtUZ3hSemZwTVZI?=
 =?utf-8?B?bTZMdzF3Szh5NkpTOFg2NVZWSE9UQWdYNml0UlZQdnZHck9rMzkra2l6N29Y?=
 =?utf-8?B?R1g4SVl1Y1FUN0RKczJqSVlIUUdndkFlWFhwQnkrbUJ2TFdMUmZLVHg3SlA5?=
 =?utf-8?B?V0VBV0ppNmV0S0RyVDgrM2gvVHdYZjJDTUd0SDFyZWRzZEFTbFFMOXk3VUNB?=
 =?utf-8?B?WC9mUUN4SzNMc0tRaTBuNzFJZ05BNHlkUTVzUUVidkNRNkxsdFNZN1ZLZEto?=
 =?utf-8?B?Y2VFaG0wSWpxYjdycy9SS2U0SDVUajI5US95akRnMzJOdTU4dmExakt0NXRK?=
 =?utf-8?Q?IcBiqiHs96gbGQ+8xIiOy/GlCprAqI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ck81WTZUTTl4dVprQ0x3dEZZSFZOWmozZFNZUXRabkFCaloxdnRiRG51aEpJ?=
 =?utf-8?B?Mlh2Q2JkWGQ2UHlEaWpzajg4ZXdRNnNzR29sUllGV0hzM1FRZUJBSHBNWXBD?=
 =?utf-8?B?UkhvOC8vTUlGc3ppd1pjT1NNMTdHQmhLaDE2dHdRVkhaSW1idUlBMVNOOHY2?=
 =?utf-8?B?SC9YY2xPY1pDNnpGL3M1ZFVaTDZyMGM2NEViS0VtRE92aVRtYVpKUEVzTnN6?=
 =?utf-8?B?UUpLVm9mT25rbTl2cGtXcXdJanVRRDJ4OG5qR1JvZnJkd2ZFdkkwdjU2MjB3?=
 =?utf-8?B?bVdEOG56MC9yOG5jSFU5dGErZTZsWDBia1ZnVHh1bGVrSC9vTnpEbStuY25R?=
 =?utf-8?B?dFNaUmRrRmpyRlpLbk9wb2IyRUM4c2h3dDdyT1I0bVJ0RnZQY041dlFLbjZk?=
 =?utf-8?B?aG9uWkxJTWliMGJ3bnBhNjJmL0FzU0ZhazJFRWEvNlAzVWxTSmxKVkFITzVQ?=
 =?utf-8?B?WHAyN3lYbWp0SVV4cjdLbEdUQ0NsbHdTMmdQOEZ6VDVkMFgxOHZNcTh3eTFG?=
 =?utf-8?B?NVArMGNBdjJPS0YrWmZPQ09iWHZpTTM4cWYvdG1ZUVNqaXNPSjZFRFJmQVI1?=
 =?utf-8?B?d00wT1pyZjhNQ1Z5eGlxamd3SWhzaEZqaXVGRmlRcUxtMWlMaTFtVkxBSFQ3?=
 =?utf-8?B?OXdTS1dLbUU0SFpscnFIVHFUQjdBR1hjYVNET1hNYUt5ZDM3WHZLWFNWQnp5?=
 =?utf-8?B?REhKcGFqUWc1QkdKQ011N0V3WFpwM0x3S3RiLzh1cW43MW8ycTZPOFJUOHBP?=
 =?utf-8?B?TGlZYmxwRVJVQ25GNS9LcHRDazhRODlzSmlWZzFva2gvTlJoQjc2MDlRMUtZ?=
 =?utf-8?B?ZEIzQ2FzWW5NWTc4aTB5QngrRVlqR1F1WU9kVUF0Nkp0U2s1QUV5b2YzNkhn?=
 =?utf-8?B?WkdzTTd3ZWgvK1N2cHhGaEdsam44NXRuQ1I5c21mcFllREJsclFkaDhEV2hN?=
 =?utf-8?B?Uk5vUG1oZkhnb1UyVzF3UkpLL2toM3JmOXI0Rkg2V0RjeHJ6YjJqMUtFeERr?=
 =?utf-8?B?QlJZNmtVeFdWUnUzdWtJV1g1c1k4Ui9iWTBkQXIzM1lac3pOSW02dmIxbk9F?=
 =?utf-8?B?OUdEeEw1Rm9WOHVKWVNNRGw0UWdDNHFPM0ZwVkduUkpmR1dFWWZjUnh0M2Ni?=
 =?utf-8?B?azBKd2Z0azRkbmpEVk5oUGxBQnhqN1YxYVRZZGs3eTdRZVRCVkpMQURNb1Rm?=
 =?utf-8?B?aDdGYXQwTUY5K2pxQ1I0SHhzRFBYL3FTd055YmMwVU0vbWt1bSt4Z2lPajJ4?=
 =?utf-8?B?NVFKQ0NvNUNWZGc0MTNTQkJ2SXlUNTE0SGpwaCtIT1FWVTRvVFpFYzhqMUVx?=
 =?utf-8?B?VU9BVzg1UTlYK0IrVnhjLzhJZFlzSjRqelNDYjN4Wnphb1ZLb0JERHVGb2xn?=
 =?utf-8?B?TUYxYkxtZm9NZnNlYSsxUzgvSGxoc2NYNGxSb244NEFlVDduZkNSN0dHR1hP?=
 =?utf-8?B?b05jc2cvU05BclFLdFlHUXZHYmxrdTBvaDBQdU9oWm56VlpucXVnV0FaQUR1?=
 =?utf-8?B?c2FNQmhqUjZ6V0xNVTd6d1lFWU1JeG9sbEZ6MVB4Y0lHTjFrSStGaEpLcXAx?=
 =?utf-8?B?TjdNUnlpT1JETjRTditVQi92MmJidVVHUHZTRnpKd25yY3RGUXY0UTdmdW9D?=
 =?utf-8?B?VGw4WWgwMUd1V0NpcFk3UEFzd1BTZjM5SHQrM3FHOXdCRjBBZFdSdnVmaFk5?=
 =?utf-8?B?WG0yZWIvNWhwK1MzekJmVVFIUUdBVWh2aHNpVGZtbWp0cXRsL3NubXVqUUJw?=
 =?utf-8?B?SThTbVNqOU5abCt4dEdmY2tnNm9oNjcyNW5Ua25mK3kvTDNhelIrMjVhZExQ?=
 =?utf-8?B?QjRodk5ESUhJYnVMUmwyWVJzcW1TY1RtbEdsUGNuTHpJNkdEcjBUNFVPRjRG?=
 =?utf-8?B?L1FQeVhCeFEwTWVtUThaREYzdERMRnI3TEVBTGZDTStzR1RPMkpvR2oxNkR1?=
 =?utf-8?B?VEhoSXFhVERXY2c0bU9IRlpHd01xQjFtOW93L0hFUGY3VnJCd3lUWVYxbkNT?=
 =?utf-8?B?aHUwc1Z2bnRLYUFTVmFVMVVySzZRMzFWd2pGRlVvdGJiaVptTEowU2RKRFps?=
 =?utf-8?B?a0h1a28raDN1QURSeStxTDUyR2pVdVZUMTNKUW9YMkdueUNlOEJtd1ZjVHg2?=
 =?utf-8?Q?V8A2o2yhZXmovLtzLXuHKUJMb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57982219-c901-4d9e-0fff-08dd6b0253a6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 18:33:09.5475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEuL86rdzNs8Yciid3v8Qp2mQr1DOXRUKxWaP+TmfD76ZsaDzPrI8gAlxLk8wY3slcfB6ejh41YAuel5LwS/bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9004

On Mon, Mar 24, 2025 at 11:00:24PM +0530, Manivannan Sadhasivam wrote:
> On Sat, Mar 15, 2025 at 03:15:41PM -0500, Bjorn Helgaas wrote:
> > From: Frank Li <Frank.Li@nxp.com>
> >
> > dw_pcie_parent_bus_offset() looks up the parent bus address of a PCI
> > controller 'reg' property in devicetree.  If implemented, .cpu_addr_fixup()
> > is a hard-coded way to get the parent bus address corresponding to a CPU
> > physical address.
> >
> > Add debug code to compare the address from .cpu_addr_fixup() with the
> > address from devicetree.  If they match, warn that .cpu_addr_fixup() is
> > redundant and should be removed; if they differ, warn that something is
> > wrong with the devicetree.
> >
> > If .cpu_addr_fixup() is not implemented, the parent bus address should be
> > identical to the CPU physical address because we previously ignored the
> > parent bus address from devicetree.  If the devicetree has a different
> > parent bus address, warn about it being broken.
> >
> > [bhelgaas: split debug to separate patch for easier future revert, commit
> > log]
> > Link: https://lore.kernel.org/r/20250313-pci_fixup_addr-v11-5-01d2313502ab@nxp.com
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 26 +++++++++++++++++++-
> >  drivers/pci/controller/dwc/pcie-designware.h | 13 ++++++++++
> >  2 files changed, 38 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 0a35e36da703..985264c88b92 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -1114,7 +1114,8 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
> >  	struct device *dev = pci->dev;
> >  	struct device_node *np = dev->of_node;
> >  	int index;
> > -	u64 reg_addr;
> > +	u64 reg_addr, fixup_addr;
> > +	u64 (*fixup)(struct dw_pcie *pcie, u64 cpu_addr);
> >
> >  	/* Look up reg_name address on parent bus */
> >  	index = of_property_match_string(np, "reg-names", reg_name);
> > @@ -1126,5 +1127,28 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
> >
> >  	of_property_read_reg(np, index, &reg_addr, NULL);
> >
> > +	fixup = pci->ops->cpu_addr_fixup;
> > +	if (fixup) {
> > +		fixup_addr = fixup(pci, cpu_phy_addr);
> > +		if (reg_addr == fixup_addr) {
> > +			dev_warn(dev, "%#010llx %s reg[%d] == %#010llx; %ps is redundant\n",
> > +				 cpu_phy_addr, reg_name, index,
> > +				 fixup_addr, fixup);
> > +		} else {
> > +			dev_warn(dev, "%#010llx %s reg[%d] != %#010llx fixed up addr; devicetree is broken\n",
> > +				 cpu_phy_addr, reg_name,
> > +				 index, fixup_addr);
> > +			reg_addr = fixup_addr;
> > +		}
> > +	} else if (!pci->use_parent_dt_ranges) {
>
> Is this check still valid? 'use_parent_dt_ranges' is only used here for
> validation. Moreover, if the fixup is not available, we should be able to
> safely return 'cpu_phy_addr - reg_addr' unconditionally.

I worry about some platform use fake bus address translation in dtb file.
If none report below warn for some times, we can remove all
use_parent_dt_ranges.

Frank

>
> > +		if (reg_addr != cpu_phy_addr) {
> > +			dev_warn(dev, "devicetree has incorrect translation; please check parent \"ranges\" property. CPU physical addr %#010llx, parent bus addr %#010llx\n",
> > +				 cpu_phy_addr, reg_addr);
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	dev_info(dev, "%s parent bus offset is %#010llx\n",
> > +		 reg_name, cpu_phy_addr - reg_addr);
>
> This info is useless on platforms having no translation between CPU and PCI
> controller. The offset will always be 0.
>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்

