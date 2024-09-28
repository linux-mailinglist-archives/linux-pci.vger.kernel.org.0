Return-Path: <linux-pci+bounces-13617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BB7988E08
	for <lists+linux-pci@lfdr.de>; Sat, 28 Sep 2024 08:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258B81C20DF4
	for <lists+linux-pci@lfdr.de>; Sat, 28 Sep 2024 06:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AEE175D20;
	Sat, 28 Sep 2024 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LWKb33OI"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010062.outbound.protection.outlook.com [52.101.69.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB91800;
	Sat, 28 Sep 2024 06:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727506162; cv=fail; b=Tn/KYofNB0TUBVBke7elMnHt1BfWAFyrAM9t+l9tJPJfF08bE+LSebw6+b6kkY1tWZU3AcfdjpW/KS0NIDrl5bDI/nMi1t2OKi50ivpKtOzBoZtEkWFikkXjRyjuSb1Gf1kAIdCZ6a8iCVtleEmxWsL6zeqcNz4qjVuJij/JDh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727506162; c=relaxed/simple;
	bh=WRr+7hASPSP0NnBZndy0dnEIWJ+8Lg60/VzkpYBD3FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VTBoSb2W76nYGGUfLPxJe6hSXNEkGd/53Qw5enf/bFnJzcR+o4SpSBTg4wDdH3BYJnV0/hi5JtxhB1hCoRMbkCNxzyheUTdBU2u+XUqDTa/jzTdTxukLUkLGbuNrgooIz+xVugjfKgpRJQgRbYoZBMvCUMdA7jiHHEweDjyx8FI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LWKb33OI; arc=fail smtp.client-ip=52.101.69.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UsDhMnmt9odnYaz12HfFuN7Wk9WMuGqtLLp/bXsioenn/dUCqe0mbbTTus5evFgRlgAKaom0+Kd1hCfoNxqU74I0BrlftsM2SDGuhP4KsYIKqlbM8ImIKwd+gUR5BMeRNNTlwSPO+BRcOgdxOtOzKPdBZgVWzgLLcStN8UeHgT8j80lv3tqHKyGlckyVhad7MKJbvSVtSvrDnzXz29RTSoA2+y2BDR57yVKKqvvIeWh+ume2it1Wruz59ewPr77PFEHlR0wYNArJ/xhrMwWqH/kUS1lCGevMp/r6/glQsgW2ozt9nIxCbqtNDE5fgRvDqxRdq9MnjmO5x2mx4X4AVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gimOuSKRxnS6jNgQ8TnsVsaC2tPQRsAueOhMPgSfJ/4=;
 b=cUOGeAUgNckSVj8b939DisgRqp7viC6/N9xvudmUv4VI/LvMMEs97rLTT8w8o01cCxlG0AneNctt0Z4yghgVMnUceXpqqBApYcih8Ifw/fnWD8S4SlldzYikzliOvx5U0CrOvUiCbLaXbfAtj3vbNQKucm8L22Ec8ubBctQUzVWTSsAWfV77PdTj9qqW+OQCMqysosmWx86CtKBu51gwxSTbkn4HU3AujtYzBjxDb9egN9c3ftq7ivZkAWvI+yrZ1XB2TGTJzJHPZegEm+YfGdGep3ROeUGXTX3i+MF1i129Nf136Q0CQWD0TNEqBXWRu+zhiYMt8jm+ysF5Dad+Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gimOuSKRxnS6jNgQ8TnsVsaC2tPQRsAueOhMPgSfJ/4=;
 b=LWKb33OIRXPNvJz+O4TyPBfYDrYIi+TyDpdF2ErnFKMFbHxWtRf2evER3ytd/lpIGFDiigYPDQLJdNLHUd7p0PaY6uO82f8pwfdMLll+KYAnFAR8M6+A8NeMlpSglBKd6P+mf7XrdG446XxGvYqdC08Ac/RXYUY0zT0m4IC0+TvU2DFjUjBoH7Bs77vGVoCBAKR4nST/HffEsXsVJC0ldJY3Fc9GBNlrPmB3WBe+nXdMbHlK+kAbwnARi0TcF+Nf8y5Xmf6zPWfP5wL4FX/YbfGukovbO7PUGK3vrTMbq+hPtc2daBECD+QTZHy2H79DtM36ATqL9GNVnyDfBFsGUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA1PR04MB11060.eurprd04.prod.outlook.com (2603:10a6:102:491::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Sat, 28 Sep
 2024 06:49:16 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%3]) with mapi id 15.20.8005.021; Sat, 28 Sep 2024
 06:49:16 +0000
Date: Sat, 28 Sep 2024 02:49:05 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/3] of: address: Add cpu_untranslate_addr to struct
 of_pci_range
Message-ID: <Zvem4SUAC+FW+WkL@lizhi-Precision-Tower-5810>
References: <20240926-pci_fixup_addr-v2-1-e4524541edf4@nxp.com>
 <20240927235117.GA98484@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240927235117.GA98484@bhelgaas>
X-ClientProxiedBy: SJ0PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA1PR04MB11060:EE_
X-MS-Office365-Filtering-Correlation-Id: a1aa2353-8e50-43a6-732a-08dcdf89ab2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0h6TXgyMmFIRzR2Nkt3VnczUVlWMnpESXovWStmNnU5eElBcVNON2RITHFm?=
 =?utf-8?B?Zm5iM2pIOG50Mzl1SWNoYUxua0h1eFFCTzVVMlBUZGVuVzdlOUhiYVhsY2hB?=
 =?utf-8?B?Y0svT2prL3dLSUI0ckw5VTBwR0Q2TFU4ZkdZUkFCY0VOMzVjVWRWa0NRZWJ2?=
 =?utf-8?B?N1doR3dnU1FnWVNOZ0QvUFRYeUVBMk9FY21QeVNLTk5yNXlVd0h2Q1JHL0gw?=
 =?utf-8?B?Mi9BeFBac3ZIZG5OSE8xZEVYLzNLRDdqTUUvaGhoZjEvTnoxTmZ5K2lWeVRo?=
 =?utf-8?B?elpXZTcrakJ2WFN6ZndkaStrbVN0Y2d1T1EvSzByRXBmdnowaXBpclhaODJr?=
 =?utf-8?B?UERZT2ZwbjV4NmlDR3FzSTJ5cVNRSnRBQWFFV21zc2pBV01BdHFyVFU1Mkxj?=
 =?utf-8?B?a1BLQmsxMkxxNHBxbEVZVXFWVjBRd2ZMZ0VaWWwwYmpybVI1djZOVWplQTl2?=
 =?utf-8?B?ckFwVVJNb1ZFRlZOUkd6Q0JudXNWdFlaN2JNOVo5Z0lVQVNiK091U0c5SG1F?=
 =?utf-8?B?cEtCNG1EMTNKMzFVVXdQZk9FZ0pZcSs1SzBidE0zMVRzRVdWTXFBbHp1SStp?=
 =?utf-8?B?aGZXdFZwTkI0K1BZSjlIQnVSUmlMQUR2dm5QNVFrYlRKQzNYcXl4WUtUeGpE?=
 =?utf-8?B?dDJ2cVYwNWZwK2RLNWZqUjlSdzJKU0xQdm9SUTNuYkVZKzU4WnZGMkhjb3Bj?=
 =?utf-8?B?UG1ZVTRxeUNvcmlsRmNtTnE5V1N0dWU5b2NhZlkxNTdyVjBuY1REMDMrWHph?=
 =?utf-8?B?c01taWhPT1NVdE9VeFM5VTlMeUw4TFBpTnVXdVJOV1o2NExrOU5xOTFvSDN4?=
 =?utf-8?B?YnVvd2F2SkhETEI4QmJlVnRNaEl3TTcxTlVJQ200NjRUMFpaaCt1b0hoYTZy?=
 =?utf-8?B?bzZKNG13NjJFVVljSGFPRXBUM0ZzcmtwZnh2em8rbXhhcVBBUTJ1VTdVbG9R?=
 =?utf-8?B?eUlQOTdZS0pOaHMvZndmZ01uaVphamlFUTQ3a2hMSmdPVUhGaFpBaG9LTXZs?=
 =?utf-8?B?VlRRYjNrUmFjbWhXeStqQkFydzZ3L2hDcFpHdldwakt0SU9Bc00vN0tFRnV0?=
 =?utf-8?B?Q3ZTN1VtdllwNnA0ek5iRVZFeEpaS2kwMG9vRW9xYmRWeGlJYXBaVUNmYXN5?=
 =?utf-8?B?NU5WTTdYRUFzUStRcjlMbHZzN1NKTXJTT1dmbE8zNjJYK2NVMVRHOEFlN1oz?=
 =?utf-8?B?ZHhOYjNYUGV4cFFSVVRtREoyeVhRYlk1NjZ1NVVydUZwVjZON2VlamxRMUVQ?=
 =?utf-8?B?V2NmY3BMSmI0Z0VUNVQ5L1E4THB4eFNaVCs0RHpPZ1ZpM3dINWk1UHQzaHB5?=
 =?utf-8?B?M0dSdXQyWG9XYnU3NjIvbkRmdGl1L3NWVTNJWkw4czkrckx0M2NjenVNN3A1?=
 =?utf-8?B?VlFYZmZZalFXekV4dkhXKzVBRGlyYm42UGl5SEgxN1hUamhIN3dEYUpQUXVa?=
 =?utf-8?B?UGpzNEs5K3BXOVpUK29uSnZ1aHJ3bXdtK3JEdFgvUVRETnFUNy9JVTNkNUZY?=
 =?utf-8?B?dTZTMVp0T1gyS0J0cDc0VFdDZlZ3RzlCVzlxR0VmRXlsdzZPbmd3ZmFsZm15?=
 =?utf-8?B?cEZHSXBDQjRKK0kvTDZzaW5GbCtkQk5lYWpJUEhtNkpIeGRJRnA5TFlocXlw?=
 =?utf-8?B?TVRQTzJpMmFLb2ZRZnBzOExxcnVTSGdkd2crVFRpa1RYMUxoa2hScFZzYXE2?=
 =?utf-8?B?UE1jNXNDVitQZ1lwV25EOFN2R1RNbGIvcVU5dURodjJsUHdsNVBuWWRkZE1u?=
 =?utf-8?B?OFBrUUY1L2pOeUpoUlViaGM3cWgxUmc5MDdGTnBhbWhGNFRJS09jTEhMZDdr?=
 =?utf-8?B?NHVRYVE5eFRDYzZzdU5UZjFDS0V4aTZmUm1EekJZTW1tT2E0cUplYWhiL21G?=
 =?utf-8?B?bFFiWnFXa2xobGRuUzJudUxXektVZ2w0WEh1RnpreDhEcFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1lrRVBnOXBrbHpEU3lSbGRtRkxMd3AvdDgxVEJxUkhzRGltZ2RGNzRYTHdE?=
 =?utf-8?B?dlBJdjlxZko3TmwwbHdqcVpQVERhMVdUZ3VWTUdDTk1Wd280NnA0T21ZSXdl?=
 =?utf-8?B?NTlSMU5pNVNEbUVwcjBpVkhINlpEK1RQVjJUSGRIb2oxR25QcFY5TWliTmwr?=
 =?utf-8?B?L3pMOFBQci9iQmNVR2V3bERJaDZQSXlMbE5RbUxrQmdUakxOOHQ0MEp4YUhT?=
 =?utf-8?B?NEFQMDc3M0Vrb2xUT0UrOVlzSGJZZHZ0c1F2aENOdUt4YzhtSm1LbEtTZlNw?=
 =?utf-8?B?OXI3VHVxQk9oaVdPeFRsRDVzaWQrN3VSQVVmUUdOMmlUc2JjUlZHSUxzd0F6?=
 =?utf-8?B?WU1pRlFLdnNzTUl1MGFnYkJaRVMyaHFPK0g4UTV1bmtVN2pTR0c4THQzODU3?=
 =?utf-8?B?MWZiQ3pJT05oem41alhCZDVHL09BcWRGT2VqSGJJWnh5VEUxbFVnUlYrd1M0?=
 =?utf-8?B?QkZDdHRRR2lJN1lSWlI0YnVucEZtZWNmMWVOYTJHYXR5U2NIWXRmT0s1d3Za?=
 =?utf-8?B?RUxHN3hPbmVQUTJXejRGNlRNOThYRGExbGJGVmFKcXIxbnpzYVBzaytiRjNS?=
 =?utf-8?B?LzFZTFE5R1FjWExUa3UzMExaMmJqSzg4UDBqVUxKMTJSVG0vcEdpRFpXRDAr?=
 =?utf-8?B?YlZ3YU9iZ1RlK25QUG82ZnhvMktwRFZCdVFFeGMxM3JueVEvY0lJMXcyK05M?=
 =?utf-8?B?amNJMnluYWxudmdUbUhYVTdLZStJYWtmUWw0MkE2cW5pelY3SGRIVnNCWWxW?=
 =?utf-8?B?K2o4clgzMUo3YnhrSiswLzRiL3g1YmVGSFg5M0szMVRhbTZCajhqc2VTWXRm?=
 =?utf-8?B?ZExBblUxOXRaMTFML25jKy9EaUZBbDg0WlMxQm9PN2dybXJ0b3BzVGNSMkxl?=
 =?utf-8?B?RUxVbmswTzFsOGdGa2N0VkhuT0FkcHpJalNWSGFPbm5JYStPNkZaZ0ZqSm1l?=
 =?utf-8?B?bUhiOWFwRFQ1QkFFWERIWHk3aTY2d0JaTUpyNnQyUTFQWk5vVGxOVnQ1dGx0?=
 =?utf-8?B?b1RNMjExVnZGQ210bEhKREVobmp4Skt1V1lpcTRCOXRhZzIrVythWlNTem9Y?=
 =?utf-8?B?TUNKU3crMStlOEE0MW05NDdtZmRvNTBpZHRPRVlMLzd1dThUaFZ2U3dHZVF6?=
 =?utf-8?B?dUNieVBhVHJTZWNsYUV3VW05QmIwK2ZRb1krcEtUUWVpVVkvN3dGZ1hxNXBY?=
 =?utf-8?B?dWlLb3ZQeExXcDZnYzFuYWNtZGhFeU5jUXd5YUk4Y3RKc0hobmxrcXlXT2Yz?=
 =?utf-8?B?S052RW0vRGtsMkVqckxjUTF4N1VRSjdaYUNIcU14V1N1TjhpQnZocy80SW80?=
 =?utf-8?B?Q0JJVVphTkpwNXFZV3FHaFhwYkVjd1doQnVmdlhtbGZxRWUrZDZsTU9FdTdZ?=
 =?utf-8?B?OWZLVmI3aWE4cnIySEpOZFN2cFVlRXE5dmZxRFJiWmdRNHBpVzdhcUJtdFht?=
 =?utf-8?B?WkxMc0tNb2ljYXdINm1zNFJqRE5lQTQ0dHBzcmkyRnh5TWhUeFRKelhJVzA3?=
 =?utf-8?B?TGRyQjNhYWJRR3prQ1h0dnhoQ3paeDViMG9sL3pCY05sU2RFNTVUdlIveWRa?=
 =?utf-8?B?RmFyTEhhdWRKVWpMeWplMTB1NUJxOUdNV1pRTTQzM001QzIyMys0eWZpMmFo?=
 =?utf-8?B?bTUvMVVPbmVZYUV0OFNvc0xValJwVWFlSTJxRW1JSHRScUhOU0RFcFJjaGJs?=
 =?utf-8?B?ZFpCQVVHRHBYVWUxd0FEbGtHQVIwRlEwVHdDTCtKSENHY0N0YlBnL0JqaEg0?=
 =?utf-8?B?eVNIdGZ6b1dacHN4M2tqTml2OERKTEE2L3cwR0hQU1J4MEtuRFVuNmM0bmJH?=
 =?utf-8?B?ZDVPQU9ROW9NaDErcVZ4U0gwd2hhN1phUEttUFMzMCtVTDU0Y0s2MDhXRnBv?=
 =?utf-8?B?bEFRcEp0a3NKRkloVTFyUVVTRWRDYjRQdFVNZ085cFJSMHdBOGRJNzNzdFZ6?=
 =?utf-8?B?Wm5iRU5UbEdrQnUrVm4xbDFYMHE4T251WTkwdDQrZ3A0ditULzBjT2FiNDJJ?=
 =?utf-8?B?NVIyM3crbERTUGhMQVJaR0lNVzlQNFVzbjdYcXMrMUI2L3J0dGV2NFRzNFJy?=
 =?utf-8?B?TEc0TWtKUG5sY284TmJpZzRwN0JRRHRkOVNoeHFxekhNVElNZ1gyOWhsSGc4?=
 =?utf-8?Q?Zhgd3LwEPv5R5lZ59yzp3tjIy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1aa2353-8e50-43a6-732a-08dcdf89ab2f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2024 06:49:16.3430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bi3yddKalbmbR6f3QxM6AyYm8rl03thxbxojpqgP8Oo8mFRN4xLeXzogaBIqDzlnHHfSjW1QSxrRXGbBm8FO8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11060

On Fri, Sep 27, 2024 at 06:51:17PM -0500, Bjorn Helgaas wrote:
> On Thu, Sep 26, 2024 at 12:47:13PM -0400, Frank Li wrote:
> > Introduce field 'cpu_untranslate_addr' in of_pci_range to retrieve
> > untranslated CPU address information. This is required for hardware like
> > i.MX8QXP to configure the PCIe controller ATU and eliminate the need for
> > workaround address fixups in drivers. Currently, many drivers use
> > hardcoded CPU addresses for fixups, but this information is already
> > described in the Device Tree. With correct hardware descriptions, such
> > fixups can be removed.
>
> Instead of saying "required for hardware like i.MX8QXP", can we say
> something specific about what this kind of hardware *does* that
> requires this?
>
> I *think* the point is that there's some address translation being
> done between the primary and secondary sides of some bridge.
>
> I think "many drivers use hardcoded CPU addresses for fixups"
> basically means the .cpu_addr_fixup() callback hardcodes that
> translation in the code, e.g., "cpu_addr & CDNS_PLAT_CPU_TO_BUS_ADDR",
> "cpu_addr + BUS_IATU_OFFSET", etc, even though those translations
> *should* be described via DT.
>
> >             ┌─────────┐                    ┌────────────┐
> >  ┌─────┐    │         │ IA: 0x8ff0_0000    │            │
> >  │ CPU ├───►│ BUS     ├─────────────────┐  │ PCI        │
> >  └─────┘    │         │ IA: 0x8ff8_0000 │  │            │
> >   CPU Addr  │ Fabric  ├─────────────┐   │  │ Controller │
> > 0x7000_0000 │         │             │   │  │            │
> >             │         │             │   │  │            │   PCI Addr
> >             │         │             │   └──► CfgSpace  ─┼────────────►
> >             │         ├─────────┐   │      │            │    0
> >             │         │         │   │      │            │
> >             └─────────┘         │   └──────► IOSpace   ─┼────────────►
> >                                 │          │            │    0
> >                                 │          │            │
> >                                 └──────────► MemSpace  ─┼────────────►
> >                         IA: 0x8000_0000    │            │  0x8000_0000
> >                                            └────────────┘
>
> What does "IA" stand for?

internal address

>
> I don't quite understand the mapping done by the "BUS Fabric" block.
> It looks like you're saying the CPU Addr 0x7000_0000 is translated to
> all three of IA 0x8ff0_0000, IA 0x8ff8_0000, and IA 0x8000_0000, but
> that doesn't seem right.

0x7000_0000 --> 0x8000_0000
0x7ff0_0000 --> 0x8ff0_0000
0x7ff8_0000 --> 0x8ff8_0000


I can update diagram at next version

>
> > bus@5f000000 {
> >         compatible = "simple-bus";
> >         #address-cells = <1>;
> >         #size-cells = <1>;
> >         ranges = <0x5f000000 0x0 0x5f000000 0x21000000>,
> >                  <0x80000000 0x0 0x70000000 0x10000000>;
> >
> >         pcieb: pcie@5f010000 {
> >                 compatible = "fsl,imx8q-pcie";
> >                 reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
> >                 reg-names = "dbi", "config";
> >                 #address-cells = <3>;
> >                 #size-cells = <2>;
> >                 device_type = "pci";
> >                 bus-range = <0x00 0xff>;
> >                 ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
> >                          <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
> > 	...
> > 	};
> > };
> >
> > 'cpu_untranslate_addr' in of_pci_range can indicate above diagram IA
> > address information.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v1 to v2
> > - add cpu_untranslate_addr in of_pci_range, instead adding new API.
> > ---
> >  drivers/of/address.c       | 2 ++
> >  include/linux/of_address.h | 1 +
> >  2 files changed, 3 insertions(+)
> >
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > index 286f0c161e332..f4cb82f5313cf 100644
> > --- a/drivers/of/address.c
> > +++ b/drivers/of/address.c
> > @@ -811,6 +811,8 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
> >  	else
> >  		range->cpu_addr = of_translate_address(parser->node,
> >  				parser->range + na);
> > +
> > +	range->cpu_untranslate_addr = of_read_number(parser->range + na, parser->pna);
> >  	range->size = of_read_number(parser->range + parser->pna + na, ns);
> >
> >  	parser->range += np;
> > diff --git a/include/linux/of_address.h b/include/linux/of_address.h
> > index 26a19daf0d092..0683ce0c07f68 100644
> > --- a/include/linux/of_address.h
> > +++ b/include/linux/of_address.h
> > @@ -26,6 +26,7 @@ struct of_pci_range {
> >  		u64 bus_addr;
> >  	};
> >  	u64 cpu_addr;
> > +	u64 cpu_untranslate_addr;
> >  	u64 size;
> >  	u32 flags;
> >  };
> >
> > --
> > 2.34.1
> >

