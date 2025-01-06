Return-Path: <linux-pci+bounces-19350-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D620DA02DE2
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 17:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD99A7A0476
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 16:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D27613DB9F;
	Mon,  6 Jan 2025 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UXq8qbK1"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01927144D1A;
	Mon,  6 Jan 2025 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736181503; cv=fail; b=leL0l0qZapV0zbjpxqvTSO7DcguX64kgKRhToyD0S9vI6IlmoOEKt9ccg1aJCqEta5+UimWqjUt9Ngltf6C+dZ5nhztroAi8eUkrmIjq4OLG4DMlJ6BKv7tmfDKljZNI3QJQV44MQIMl0RCvygy3xMj5X6TYlzGR8ycZQlP31YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736181503; c=relaxed/simple;
	bh=Pv6RLbwqyYXeo/r+8hUJLT2L2n27xBRXp8F/Hsa6O9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AmEARkiWcmICMXMvUIU/AW+7tvnQYGlqg9HgvWYMMHMRZjCSCpmmQp/CIDUfmbJrmcxEe4Z70cg92EZZYdHLiw9IyqtiNMHZoezgtKBCJ6d8EMJTnfH+TuJiHzPCw4Gu3SPqkU1yLZQj2QJ3risLjH9GwQBilyXxNoqQsOb4IFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UXq8qbK1; arc=fail smtp.client-ip=40.107.21.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ttiwa0IFZJJpTC1Hs2nOopUyMd++xOlEFYbiytgcBShbCYan7fG7zC9Dv7Px+NhuYqd1bocJ7pSThX4Ciw+isZmbTu/WbPIvX8/xcGkh9dgEHaXkbZGmInkug2o3H92KnFhtsZiFzdaI4e5zbRX8G5/+dJKWEMBLTYtSC1VuCdpZQoXuL9ubm5SZeB7AyJNsHdRA9xYgIfQnzqYn4c4VS6pWToR7HCiHN9vb8UKL5OdN0RAZwwFV4Y0CeLbKi3qqBNp5PqAXVe/HQ6aQF+7TH0yNJris3dbhhtJGsXNiBz8voePUZQE0ZJyoerkCZSTE86VDUWcG7WBEL853kbcmAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DospklsCBqBWUrNlvlHrqW4TUg0yf6s1Iyq+aZIr9L4=;
 b=vEbUDeIimEzFrJS5/pGy7xAdQXLnYckl9x1HHUzETGVSLU19pxit3BxwUFGoMn8Bnq2Odn6N14xOWJCTQe6fD4fzhSb4xCeC7rp7/h17MA8+T5QNMxO4NF+SARJ8rF34jcurabF3zfB0+8aGu5Je0Y3UWki79OZoeir5dj+r1/X/XFMzSGDj1VhwgKP9JhuKGkRcMoNuarkWwLkHgGoaFu2IwXFElRqg3wLK8iIiva/hqIrSAHuykywplCbQubIhZicZWQ80epSU3upVLfDvLhQVNTQyBKar08m12T6sBy/AkWSTFuE+usGBohu5SmI9/oWrWuI2jDKGEOgOwrHuqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DospklsCBqBWUrNlvlHrqW4TUg0yf6s1Iyq+aZIr9L4=;
 b=UXq8qbK1/Bq9f7HcWrpsE/Zmq3IoHZgeyebeA1ZwusW1akmeJHm9qMLfhq1cLr97tL/h5ycGne70nUAMwVG9jzsoaoVKvQfk4k8vnrG1GutHFonTF4fJLnMoXtN8OgKYCeb4o59E6ldL40zIg7vqv7w+suRAMMBhGhJdnNjPF8S7XAWlz+9Z1jBOwvaYpQl0zlt7KmcwQZ1G8YlNSx9hXBWKDiYUW+/Er4BwJTq3XNYeuIXeNjtGhZTAAluBErSZCzaV6Vdv0psxLXiyL5gjTU7cuScvdVUsXW82MsWTXMMwIu7lN7LR269zewD/JLQNhjPWtUtgslLyUFQoaKnvoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9348.eurprd04.prod.outlook.com (2603:10a6:10:358::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.15; Mon, 6 Jan
 2025 16:38:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 16:38:11 +0000
Date: Mon, 6 Jan 2025 11:38:02 -0500
From: Frank Li <Frank.li@nxp.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <apatel@ventanamicro.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org,
	jdmason@kudzu.us, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v13 4/9] irqchip/gic-v3-its: Add
 DOMAIN_BUS_DEVICE_PCI_EP_MSI support
Message-ID: <Z3wG6pMbjsldqU/n@lizhi-Precision-Tower-5810>
References: <20241218-ep-msi-v13-0-646e2192dc24@nxp.com>
 <20241218-ep-msi-v13-4-646e2192dc24@nxp.com>
 <868qscq70x.wl-maz@kernel.org>
 <Z2RRimPlT41Ru281@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2RRimPlT41Ru281@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: BYAPR11CA0038.namprd11.prod.outlook.com
 (2603:10b6:a03:80::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9348:EE_
X-MS-Office365-Filtering-Correlation-Id: c8571422-2377-4e33-de92-08dd2e70827f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlVSejIyM2xMOU94QWthSVRqcTRXR3Nianl0OXJPbTZuQ1dFTy8zMVJ3RC9v?=
 =?utf-8?B?aktIR2IzZHZaZjErZm16R2lqNVJVVWVLd2ttQk1hckhYMGp1aGxxQy9IUVFK?=
 =?utf-8?B?R0daSGwrWWVXeGpyUVVVT2JLcE9nRzJlb1lrbDZicWo4Sm8yQ1U1dWUyTlcx?=
 =?utf-8?B?ZlZUM2FwQjREN3Zoa0Vmb0dmeU1JaDlWNytxbVFEVlhVUUNHNWtRLzhNVS82?=
 =?utf-8?B?L0JrWXYzQzhRZ0tnL3ZsclVzZDJyM2NXd1pINjhPekFSSEg5Ti80azNmS2Y2?=
 =?utf-8?B?RnRuMlZzWkdNNUJFS3ZWUzNlS1dYWHpES2lEM1VGU0VyUnV3RlRuZWFPak9D?=
 =?utf-8?B?MFB4TC9aUUFobDZTMzdqcHpjMVlWMXVrQndVY2l5WTNCbTFmbUxKb2dRaTk1?=
 =?utf-8?B?eUxWODVieEhNMjU1WkhXUW5KWlhSdGJzZFZNR1dQd3NTZFpMV3Z5U0xXaGlE?=
 =?utf-8?B?MW0wK3hqZytWamlPdWVRY0w5UTllYys1eHU1c2tzM1VVdlBpbjgzbXVvdFh4?=
 =?utf-8?B?SjVJRTBGNUlJYjdNOG5iQXVqaDN5VHdPbTZwVzNJUmtpWWxIWURFOHp2MnNU?=
 =?utf-8?B?UHpEbzZCekVzZWdXNlpOMUQ2YXJNS2QxOW1aMDN4VGdEbXFmeHZOMTR3MW5N?=
 =?utf-8?B?YVQvN2RqQ3ZDeUk1bnZ6Y3Jva3lwV3pybHZlb3cvaW1CcUloS1dpY3BXVVJn?=
 =?utf-8?B?MEVldGZrcWROZklwN2NpQktrdEpqd0k0b2NpejNFTXJLaktRWkhwMlI1cUlO?=
 =?utf-8?B?TDJxSlNvTTJpZzk0ek9KZG4zZEZ4cGlYd3U1ejhhME5DWmFTZjBvMGh1RWZZ?=
 =?utf-8?B?WThVWUlRekp6ek81TDhqY0lyRkIyTTBZR2VoenNmVElLTSs2VWxVbkR1cDVF?=
 =?utf-8?B?YlUvQUcvdC9UTnZFTmdzOFdKODQvaENLN0xuSGlacmd0bkh3ZngxaW93aXpy?=
 =?utf-8?B?dGhhU3dEY3VZcVg3Y2hhSVVoUTRUWFg5a3c5V3lETjk1aGdDbHc0OUVkWjVj?=
 =?utf-8?B?QU16WW9TMjczYjdRbUF4YllhZEY2K2RxcnNtVEt3MDdXTTdBbWZ2R3lLb1U5?=
 =?utf-8?B?aUZBZndMNkd3VjhsWlNrNVZ5cnpZRGdjeThNc2pTWmIxTVkzY1p2MytHRFhE?=
 =?utf-8?B?YVRnMUVPOFdqS2pRNzVjY21DdkxkYW9uRk55WVJZVHRESzY3NW52RXF5Z05D?=
 =?utf-8?B?SVZWbUtOSCtXV0dRR1lRVWJ2d2VTNEgxbE1vVFJmZTdvbDRZeFFOdjM1OGl3?=
 =?utf-8?B?T3BIS3BySHRFRmlzRm5RSmZTSTErU0tBWUtJY005bXg4bEUrMldJNTlCdStl?=
 =?utf-8?B?Vysrdk9BaFR1RkZ6bXBsQlY2dHR3NkozWFJ2RWhlVkRaVVlsL3cxcVlBRHk0?=
 =?utf-8?B?RnNtcUtFNkdsVUFJenlTS1dpQVVrblhHZFJSdU4rVXJSZU1FMklTS0hIQ1lR?=
 =?utf-8?B?WUNkZjMxV3pjOEZOcStGRUlpSERvV2pGem9BdmFQZ0VTTXdUSTRWaVhVN1Q4?=
 =?utf-8?B?YkdneW90Qm9XZTZ1TzBmWnBjbnZXbGlwUjlMVDJ1a2Q2WGZoVXlRVW8zb0hX?=
 =?utf-8?B?dW94akl3bExuQkMxRlF5OEVtQ05BcFJkRVRwUkVISjNDNytOOCtjY2JJVVpU?=
 =?utf-8?B?VnBzVjlxVFZkWGlzN2ZYbzlHOGswd0NLdFBEL1FPbnRUdmJjUDlqV3V3UmFh?=
 =?utf-8?B?azd6cEQxQ0djdmFKMVVoRzBEM1REUlVreHJOcUNOcTZaNjFHUUR2UW1wL3VV?=
 =?utf-8?B?TnQ4Y0oyWE5XV1UrUWxaOG1mZ2M4NTgyWVNNcURHRDBua29Mbm51OUJYUzFw?=
 =?utf-8?B?c0Z2b1RFZ3BBZWUxZ0pDUCtRTHVjQmt2dFlWY1JCc3VpVnZZUHZ0YUExc0pU?=
 =?utf-8?B?TFE3ekQyS2d2aHdReTd2d09qREFYTllhK3loNnlHdHV4UHI2OWpRUDBwUG1G?=
 =?utf-8?Q?3Am8e6g0ok0ViKJj3KLw/5gCmDV4eO0M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmlDQXBZZVpWSEIzNHNwMkZCZEhNWmdSeElIekxVK0l0akZnOW9CYWNES3V1?=
 =?utf-8?B?dmN2VWpXdmpwckp5UXNtWTh4Z2k3aVJlQ0I2aU1SLytrYVhqSmVhZC9nOTBx?=
 =?utf-8?B?cDcyUTFTdFV5REgzamdiZmF1emN3T2xsbUVPVG5WU3dGQjRmUzBNblZYblpp?=
 =?utf-8?B?QlFSZkJNN1JTVlJ4QTJnNnhLeVdEQ3ppRVhOdjBwdkhTSnMvTXFRUVpUYklu?=
 =?utf-8?B?Z1pIN083WklTa1JjckdaWFlHYzMvMi9lSVgxaGFYdTZGaXVDdHN0S21ZZDNP?=
 =?utf-8?B?RFI3SnV0NFh0a0txaSsvNG92WC9OM0hXblNYL2hUT0dMcVcyRzN2Y09LRytn?=
 =?utf-8?B?cktEck1aVGw2bDlrRU1kOVVyNzAwUFJqZzF2VzVtWXRPZFoyMm9ZOTBsS2Z1?=
 =?utf-8?B?VWlzNDA3aE5iRHZCOGo1NCtEbGcwV1JwV3AxMDdzMzlXU1paNGVPYTZINEZJ?=
 =?utf-8?B?RFJnMkpKUWVwUHVib2FTS083QWVYdnJyNjgweWQxSWhRQTJhSWpkc1BXaEF0?=
 =?utf-8?B?SUVpZHk0TlczOWl5YVlFaUZMaVVvL3NDajN0V3hsU2VXSWNFelRpNGpsa1VH?=
 =?utf-8?B?dnllTjZodjhXemhGb3VOUVN5cStiNjdXSkVzd3B1YjMrR1VIMXY2NDZNZmxy?=
 =?utf-8?B?em40MFIyZExKYVBSNGdtR1QrYkJzT1NVaW85eFNPNDNmNFJJN1NZNDd2azI1?=
 =?utf-8?B?a04zazZoell0ZllCSkdKWXZqaEZmaGdNTXRBQ2g0cUpET2UwdVk3Q2xURXln?=
 =?utf-8?B?d3pCbmtaTWx1bXJwUFNlODJackg1bkljTnhuT1dPcEZ4cm03U0phOU9yVE11?=
 =?utf-8?B?elo1Yml2b1N0RmxyRHliT2lKQzRSR25iWjZiRXYzQUVVMFYrcEhPYTdqVFlK?=
 =?utf-8?B?YlNUUExPOFp0QjlNMnZzQkVldWJETTVuRTI4UXMvUTY1R1VNb21sOVdDSHFO?=
 =?utf-8?B?b2dtSVVIRjByTTk5TGRZZjRObTFicDN3TTVnSGQySnJrRVM1UFYvclFZNkk3?=
 =?utf-8?B?dWVjWWxGRmZGOU5wZHRneWU2eXZoRFUzd1psYm9sRUVTdVJOdnBTV0VqVkdu?=
 =?utf-8?B?YTc0bGNVcHpqVkk0bWZLa1k5SEppMFdua3RIWDNEemh6UlJIdVNVdVNkZzlk?=
 =?utf-8?B?YWFOZU9WNVBNNFQzOERZZW9WaWd0OURaK1V1RWpmTHErQ0V0WWhyUldPTHBz?=
 =?utf-8?B?VHFXOXR1Rzh1d2pvR1AyMFF4QXpZMm11dHpaVlFrR3FjdnZnTWVaeXRST3R0?=
 =?utf-8?B?VjZYZzlweWhCckp1MkpPRElZU1RDSzRkSUxMQ1JMTGRYL1JWcXl0NmhvMTNt?=
 =?utf-8?B?YlhvWmJ1ZWNZallEYnQ2ZVFGMTU2MlFUMlJEMHhYZHl5QWwrdGFYR1c2bElG?=
 =?utf-8?B?TDVVNGh5b0JhMkFlQ0dFUkFaTm9BU1dDbUE5VEJwYSsrdkQ0K3didFc4a1U2?=
 =?utf-8?B?RWQvOVRqdWlPNHRFa0JqVDVFRE8zSFJhUmNBNXlha29Ca3hFRVRZRUtsazdp?=
 =?utf-8?B?T0JPWUF2L3FCMkd1K3VkR3BHNkFLaWJFS2l5ekUzWGs0bndBL1grY3h2ZjZ1?=
 =?utf-8?B?c2NoOW9veDdvLzJQZzVNUkJ6YmpnMk9ZM3YxbGdsMTNyNURBQ0R0blhtTkl6?=
 =?utf-8?B?aUtjRFBlUVYyT3V2WVc3N1p3Y2xnTkxxbFRKZFI3bFBqM3Y3Z0R6SmdqdTR4?=
 =?utf-8?B?WTNhVFF1OXZFZmJVOTZOWWdVeWFSZzJYbFEzNkcrSGhJWTl5Y2tOcmNxVjBV?=
 =?utf-8?B?UUlTS3Z1aVlqWEtsZUljdWY3VTVlb1AzUDY5RzRBc1ZBMlFXMGZtWDR4Mnl2?=
 =?utf-8?B?R3oxNXZtWXZnZHc2UG9xbURXR1VJckxURWVDSTNZLzEwS1R5ZHc5OVZRV3Ex?=
 =?utf-8?B?Yi9RTWE5SThQQnRLNWdkcWNnZWVMM3lEOHlJQ0hLTTJ6dkNBeW1SUkdzUGxp?=
 =?utf-8?B?OHVtb0hzck1xZ0NOSXpoWnh1Q0NjLy9Fc0ZYNkRmY1ZxUXlhcE1wcFB4TFNJ?=
 =?utf-8?B?SGJXTDlsc1Z2cWlndGh0aTRSb21hbGs3bG90dEhTeWs1cmlwZ1QyRzJkN3JW?=
 =?utf-8?B?ZGEzaTNHb2VWR0VJMFF6UVZpR1llM08zUncrK25VR0FrakVLd1JPVXdNdy9C?=
 =?utf-8?Q?XrUg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8571422-2377-4e33-de92-08dd2e70827f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 16:38:11.8446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTKGkExwFGTbaNIUAQ1Mvrev4CwkampsuojXCsELTcDk24hg4IFxftn8PVnj+7sXqbz/c53qWXv6eOJrxucYPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9348

On Thu, Dec 19, 2024 at 12:02:02PM -0500, Frank Li wrote:
> On Thu, Dec 19, 2024 at 10:52:30AM +0000, Marc Zyngier wrote:
> > On Wed, 18 Dec 2024 23:08:39 +0000,
> > Frank Li <Frank.Li@nxp.com> wrote:
> > >
> > >            ┌────────────────────────────────┐
> > >            │                                │
> > >            │     PCI Endpoint Controller    │
> > >            │                                │
> > >            │   ┌─────┐  ┌─────┐     ┌─────┐ │
> > > PCI Bus    │   │     │  │     │     │     │ │
> > > ─────────► │   │Func1│  │Func2│ ... │Func │ │
> > > Doorbell   │   │     │  │     │     │<n>  │ │
> > >            │   │     │  │     │     │     │ │
> > >            │   └──┬──┘  └──┬──┘     └──┬──┘ │
> > >            │      │        │           │    │
> > >            └──────┼────────┼───────────┼────┘
> > >                   │        │           │
> > >                   ▼        ▼           ▼
> > >                ┌────────────────────────┐
> > >                │    MSI Controller      │
> > >                └────────────────────────┘
> > >
> > > Add domain DOMAIN_BUS_DEVICE_PCI_EP_MSI to allocate MSI domain for Endpoint
> > > function in PCI Endpoint (EP) controller, So PCI Root Complex (RC) can
> > > write MSI message to MSI controller to trigger doorbell IRQ for difference
> > > EP functions.
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > change from v12 to v13
> > > - new patch
> >
> > This might be v13, but after all this time, I have no idea what you
> > are trying to do. You keep pasting this non-ASCII drawing in commit
> > messages, but I still have no idea what this PCI Bus Doorbell
> > represents.
>
> PCI Bus/Doorbell is two words. Basic over picture is a PCI EP devices (such
> as imx95), which run linux and PCI Endpoint framework. i.MX95 connect to
> PCI Host, such as PC (x86).
>
> i.MX95 can use standard PCI MSI framework to issue a irq to X86. but there
> are not reverse direction. X86 try write some MMIO register ( mapped PCI
> bar0). But i.MX95 don't know it have been modified. So currently solution
> is create a polling thread to check every 10ms.
>
> So this patches try resolve this problem at the platform, which have MSI
> controller such as ITS.
>
> after this patches, i.MX95 can create a PCI Bar1, which map to MSI
> controller register space,  when X86 write data to Bar1 (call as doorbell),
> a irq will be triggered at i.MX95.
>
> Doorbell in diagram means 'push doorbell' (write data to bar<n>).
>
> >
> > I appreciate the knowledge shortage is on my end, but it would
> > definitely help if someone would take the time to explain what this is
> > all about.
>
> I am not sure if diagram in corver letter can help this, or above
> descriptions is enough.
>
>
> ┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
> │            │   │                                   │   │                │
> │            │   │ PCI Endpoint                      │   │ PCI Host       │
> │            │   │                                   │   │                │
> │            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
> │            │   │                                   │   │                │
> │ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
> │ Controller │   │   update doorbell register address│   │                │
> │            │   │   for BAR                         │   │                │
> │            │   │                                   │   │ 3. Write BAR<n>│
> │            │◄──┼───────────────────────────────────┼───┤                │
> │            │   │                                   │   │                │
> │            ├──►│ 4.Irq Handle                      │   │                │
> │            │   │                                   │   │                │
> │            │   │                                   │   │                │
> └────────────┘   └───────────────────────────────────┘   └────────────────┘
> (* some detail have been changed and don't affect understand overall
> picture)
>
> >
> > From what I gather, the ITS is actually on an end-point, and get
> > writes from the host, but that doesn't answer much.
>
> Yes, baisc it is correct. PCI RC -> PCIe Bus TLP -> PCI Endpoint Ctrl ->
> AXI transaction -> ITS MMIO map register -> CPU IRQ.
>
> The major problem how to distingiush from difference PCI Endpoint function
> driver. There are have many EP functions as much as 8, which quite similar
> standard PCI, one PCIe device can have 8 physical functions.
>
> >
> > > ---
> > >  drivers/irqchip/irq-gic-v3-its-msi-parent.c | 19 ++++++++++++++++++-
> > >  1 file changed, 18 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
> > > index b2a4b67545b82..16e7d53f0b133 100644
> > > --- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
> > > +++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
> > > @@ -5,6 +5,7 @@
> > >  // Copyright (C) 2022 Intel
> > >
> > >  #include <linux/acpi_iort.h>
> > > +#include <linux/pci-ep-msi.h>
> > >  #include <linux/pci.h>
> > >
> > >  #include "irq-gic-common.h"
> > > @@ -173,6 +174,19 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
> > >  	return its_pmsi_prepare_devid(domain, dev, nvec, info, dev_id);
> > >  }
> > >
> > > +static int its_pci_ep_msi_prepare(struct irq_domain *domain, struct device *dev,
> > > +				  int nvec, msi_alloc_info_t *info)
> > > +{
> > > +	u32 dev_id;
> > > +	int ret;
> > > +
> > > +	ret = pci_epf_msi_domain_get_msi_rid(dev, &dev_id);
> >
> > What this doesn't express is *how* are the writes conveyed to the ITS.
> > Specifically, the DevID is normally sampled as sideband information at
> > during the write transaction.
>
> Like PCI host, there msi-map in dts file, which descript how map PCI RID
> to DevID, such as
> 	msi-map = <0 $its 0x80 8>;
>
> This informtion should be descripted in DTS or ACPI ...
>
> >
> > Obviously, you can't do that over PCI. So there is a lot of
> > undisclosed assumption about how the ITS is integrated, and how it
> > samples the DevID.
>
> Yes, it should be platform PCI endpoint ctrl driver jobs.  Platform EP
> driver should implement this type of covert. Such as i.MX95, there are
> hardware call LUT in PCI ctrl,  which can convert PCI' request ID to DevID
> here.
>
> On going patch may help understand these
> https://lore.kernel.org/linux-pci/20241210-imx95_lut-v8-0-2e730b2e5fde@nxp.com/
>
> If use latest ITS MSI64 should be simple, only need descript it at DTS
> (I have not hardware to test this case yet).
> pci-ep {
> 	...
> 	msi-map = <0 &its, 0x<8_0000, 0xff>;
> 			      ^, ctrl ID.
> 	msi-mask = <0xff>;
> 	...
> }
>
> >
> > My conclusion is that this is not as generic as it seems to be. It is
> > definitely tied to implementation-specific behaviours, none of which
> > are explained.
>
> Compared to standard PCI MSI, which also have implementation-specific
> behaviours, which convert PCI request ID to DevID Or stream ID.
> https://lore.kernel.org/linux-pci/20241210-imx95_lut-v8-0-2e730b2e5fde@nxp.com/
> (I have struggle this for almost one year for this implementation-specific
> part)
>
> Well defined and mature PCI standard, MSI still need two parts, common part
> and "implementation-specific" part.
>
> Common part of standard PCI is at several place, such its driver/msi
> libary/ kernel msi code ...
>
> "implementation-specific" part is in PCI host bridge driver, such as
> drivers/pci/controller/dwc/pcie-qcom.c
>
> This solution already test by Tested-by: Niklas Cassel <cassel@kernel.org>
> who use another dwc controller, which they already implemented
> "implementation-specific" by only update dts to provide hardware
> information.(I guest he use ITS's MSI64)
>
> Because it is new patches, I have not added Niklas's test-by tag. There
> are not big functional change since Nikas test. The major change is make
> msi part better align current MSI framework according to Thomas's
> suggestion.

Thomas Gleixner and Marc Zyngier:

Happy new year! Do you have additioinal comments for this?

Frank

>
> Frank
> >
> > Thanks,
> >
> > 	M.
> >
> > --
> > Without deviation from the norm, progress is not possible.

