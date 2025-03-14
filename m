Return-Path: <linux-pci+bounces-23787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9548A62186
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 00:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A764214B5
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 23:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF3D1EEA29;
	Fri, 14 Mar 2025 23:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XtLqJkQx"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012001.outbound.protection.outlook.com [52.101.66.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D1A17BA1;
	Fri, 14 Mar 2025 23:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741994498; cv=fail; b=aNrmawwECnoZFl+Jc+ahOa3YOM/x9QItHAVhW+mIO0saKwLAZBi3TPwQuTLCJ5BQs0Rr4SiUD/pEZ9bmNDpd/beseyNZxnxIEIwm81KQE7660xRJo5DCzMMp50T7udI/6LhQATq0OOJb4AgPixmQH6QHzWJka6yQ+yI4qY3xwf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741994498; c=relaxed/simple;
	bh=FDe35ur7sbRaXzVQcLIvApXVx/ZpWL7S8NRSqZnLTq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O9cbKeSJgtaG408Uttu6fRb+3Vs+HBiAqSQGPDJlga0MKzoIKd8xED43A4UewJfH1te0WJblxxnnMwpGJa3VTRYk/8lkI0gsQsDkmkBgNa7QTA2uVxs6h/KFkfWYQ3Fldkm5l2lU9wNOSPsHTOyuL8YJMqdVFFVCkE/SqYwPsBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XtLqJkQx; arc=fail smtp.client-ip=52.101.66.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNap8odovlp2RqLO083uy6RiDhS3HXmxPlFIrAPQXA4yYprXX8cCi12pgAtLO6NAPw4K1ewThciOOjLhTfhfi41EPVbvsBrlKhBwDicWi9pE5NtFRXkRpjPeYIRxbKFdwTVx1bB42Bq2SYrQ7LkBDirXDJFGFGHcSoYi8uRFhYwnXKk6eTE2MTL40qJIMxxlcQSGP89gHzs+OBjmTFErMa+dTi4Qahc35udUovx8jbZGi0B2+cwqkt/l6C5O5oJhyMBxFJJGf/DUsvSjX4nANGTutsRKdTv8gURf/n0TUMuy1icLt0zHxxhyHRJ+jdvHRFTOqNAarF8guaY81k0PQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6CnTRMtrSlVJCOeQSqbMiON3Bs59pryYXS649HV49Q=;
 b=XyvHxiMnGOkSI+FCuovAOuknVhSbXkxPxlCRu8qsNbvBRhFsniWcLneQJs5D9SpuRCMPGXitPF79scJr0y+4t+rK8eMPmXUJ7AvOBRnUdQo2b9oTBHXClATvgnnvnyYyfq8fP2I5KzdeGgkBWSjfcJNWv3orqJbKPmv1h+mpL5W/vmasZiCVe/cUEchZlVwH0lhepByj0H2uk49C1SsUnRoRr4f+WsCO5jgiBWM7HlSTEVGwEwjDJ//KcM6r6GAV0eLGcFj6GmlbsHWCEEZX22zqc6FrEhG0aEGZlbjX96VmgDBC2iupI0E8F0+vOUuRIQFywJBjZzin2h6GMk+9iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6CnTRMtrSlVJCOeQSqbMiON3Bs59pryYXS649HV49Q=;
 b=XtLqJkQxq3GAb7uz/RTFP4WveC0w+/Ze3xdIKr8PRYST1+zz7yZ3tFuS9frwVlmUsw6A2CVqpSsUWZ0pDGaw1AugQBeqr4wp2VKRkttGGj9OoQIT7WKUQA9279yRZVu8t5l24J7mGHMxE5lpDt1g5W2ii16qfpHZMiRSuO26Z9IiWAj1NJB4kw9idgFS2OOduUll8WC4xPlc3hDolqNZG7Y8CwYxWEzXyP6/sLKXPMvXPZleW2rYw/l+78bo/iChquyPXYm7cAIAdTEz84EePKumB1S7Rm4V89f88+pIdwX88UHyQL7LE7jp5Yxgs3XjFH5VqIG0XeZJtwABJlrqsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7384.eurprd04.prod.outlook.com (2603:10a6:10:1b1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 23:21:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 23:21:32 +0000
Date: Fri, 14 Mar 2025 19:21:22 -0400
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
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v11 06/11] PCI: dwc: Use devicetree 'ranges' property to
 get rid of cpu_addr_fixup() callback
Message-ID: <Z9S58n/6cE5QFRUD@lizhi-Precision-Tower-5810>
References: <Z9RJbyoFdkiYHXu9@lizhi-Precision-Tower-5810>
 <20250314221059.GA806127@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250314221059.GA806127@bhelgaas>
X-ClientProxiedBy: SJ0PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:a03:331::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: 510d802f-0f40-48d7-f596-08dd634ef4ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlQwQkwwazFmeEJGZzZuS3dLT1NLUkluRko4R2ZKN21hclB3ak5XNkdId1Bk?=
 =?utf-8?B?TmhxM0ZHSjdKM2lMUDhqS1ErMitwQUcrRDZuOFM1bUVjQzNSNlJlRmNpSG5M?=
 =?utf-8?B?Z0lXMUFwdlplQjBhdXdBM3IxbDdaOWdQKzd2U2hDcGJKUngrdUdicmYyTGVx?=
 =?utf-8?B?R2dNSnQwemhKaFhYVU9PM2twT3VHV29YbitudGJBY2R0SnlkNnA0UmR1TVVz?=
 =?utf-8?B?U2Y5YSszRlJ2NmJLWTZJNzcrajhBYkxyM0tLc1g1ZzVxWVUzZzBYYmt5VGdP?=
 =?utf-8?B?d3Q1MXJWYmEzRHlQR3J2dU5oVHBhY1JWNGFNWHNwWHBsdEJVT0JTVFhXQkdp?=
 =?utf-8?B?QUpWSU5LRE5MVnJOc2w2OHhhbm5vZWF2bUt6d2xHNnU3Y3lyS2VrWkp2UGZ0?=
 =?utf-8?B?aVpSV1YrdG40cnhSS2RiVHdXWElkNE9XK2VkWkU3UExVL3hTZXMwU1Y4S3Az?=
 =?utf-8?B?S3dDOWh4ZDE3VlZ3Q2JjaExRSnliTWlsdmFyMnR1VHBzMnNBaHdINkRndW9I?=
 =?utf-8?B?eFNLdFFJb2dFTTJwS25JV0xEZ1NQN01QWFZaU1d1c3pjUUgxbnNiK2ZqN1ND?=
 =?utf-8?B?TnorK0h4QnNMOWd4aUxWMCsvSDRMWXBQOFlmU29NNk5VeDlCdHh2eW5qRlhj?=
 =?utf-8?B?SFBhNlIyeGJHd0xjVStsMG1kNlQ3bXJGTmxIYXpZbWd0RXE5UVY0VTZ2UVUr?=
 =?utf-8?B?aTBhZjVUY2hTRG1IRTZWVSszWTVvZUFaWjlHdUlsRVV5L1EyQmVud2xTZ09P?=
 =?utf-8?B?cFE4em1CU2RqN01wQWtnRDdYWmVkbGEwZ2h6WE5XOGZYQnNuTlFROUErOVd1?=
 =?utf-8?B?VThSdWhlU1VpSzJta3U0OEVoQXMrbnQ2Q0lSUHpCSUxVL0s2WDRpbFB2R21D?=
 =?utf-8?B?MXdqSG9wS0c4a1IzMUFNVUt3cjNTS0FvMVJDSjRmelZ6MzBvRUVwakZjN2N2?=
 =?utf-8?B?TmhqbTVheVV1ZmVWRzY4aEJlYy9PeFRuTVJvd3BHZVZOckNKUWM3eUxkRXFn?=
 =?utf-8?B?c0J6RElhcVYwTE9RRkx5a2VOVWxaSnhrVkZldVFsVDBoaXZKZ1J5eHZvUk5F?=
 =?utf-8?B?WElsdElpTlhKbWFnWWRtZTBtVFQ0S1VsaU5ZWlU0UHFUWXBaL2F4eWNaVWRL?=
 =?utf-8?B?OTZRRmZQVVFnai9uTzFSaGVKZ1VvUlQxSCsvOUtLNlRhckpuQ3BGQ2lkM2Rz?=
 =?utf-8?B?S01nMjVqRW14aGN3YTlkNnF1QldJeFh5ZGQyN3dhdEF0Tlc2V0JyL0hhRlJs?=
 =?utf-8?B?Ui9YeFFRbkt0Y2NTUGlrdnNubHJOVmNxY3lmdUVNamZReDd1NGVGelZRK25n?=
 =?utf-8?B?YUtwSEhvVUsxdWlwTnJwS2pSNklGWHQ3MmlOS0lHT3ZWQmlBc2luaFk0dUQ4?=
 =?utf-8?B?WVFZQU5iaDRYSXZUWVJQekU4QVh5cEhVVmFSWkYwSVAxamtRcVg2VG90bUxP?=
 =?utf-8?B?YVNqcmw3LzdnYlNZcFlNbjFlRVZnQmFmNDMyeE5mM2VuL3p0d21QQVFVNjA4?=
 =?utf-8?B?eFh0bkhUc3cyLzVBQ0cycEgvMGFvUHZLSnRrR01EbXVPSmRGa3pxRjRQVTdN?=
 =?utf-8?B?N0NZWUtCQzBicDZLSWdPSWNFUzYyVlJSVnZreVFEZWo4eVpsYktHRW5EdFAx?=
 =?utf-8?B?K0s2OUk5U3VqUi9obVMzblNwUHNEcGZFVURSUDZOdGpML2lIRDV3SWNWVXd2?=
 =?utf-8?B?MEp5YVc5a3E1Y0VlamYyTVdIL0tLejdaMmNBcHJxKzFidDlLU1AxZFB0TWlN?=
 =?utf-8?B?MDRRWGE0OVpZcDhEMVhiblY5cEhnZ2RoN2ZRc29jWWN2RjhIdWdKRXJ2bjd6?=
 =?utf-8?B?YmFOUkQreWtaL2JGWFdyRTUwSUlaNHFZQUV1cll1S1pvSWhaTjl3bDJqZ2tJ?=
 =?utf-8?B?YkJLTmpQbjcvbnlSYUgxOVR6VHNOWXkwRTlVbmxJMlRVd2d4dDYwSitMQUZo?=
 =?utf-8?Q?PzZ+HRWL3yXFuDJOE/5P0bHTBtFfgDu+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDR3NC9jSllDcmpjbTIvVjJ5aXJpTkNQQlFlNUNuMGhqeW9YR1ErK05VR0xp?=
 =?utf-8?B?UHFJcE1YYnh3a1RoMFBJMzBHTzRBTklSWEZMSTZ1dkRQcWcrZXFudWU2c1Jx?=
 =?utf-8?B?dEgrOVF5RVZ1bG44OGVJaHE0QlI0ZEl4bDVOMlI5YUo3dTh5TDlNY2RSUE1k?=
 =?utf-8?B?emhjcWZhaVNFZU0yUExmaitFbnhmV05MYUtJdkJtMS93VnhuUnNkY2ljRWlF?=
 =?utf-8?B?aGRXakxiM1N0d0hNVVJGQTNlOGk0S0svN2hjZVkxZmMwZysyQzNJbFEzUEpo?=
 =?utf-8?B?TUxlQUFCUituODlKZnVyKzRyN3JETGJPRk9oemMvcFNEMzJOWFJRbXk0NmRl?=
 =?utf-8?B?aC92MWg1TUpNY1htVVo3MzVDNDJKNmEwZVhmaUUyV1c2U0dmS0tjWmtRcGpG?=
 =?utf-8?B?ZEtzSVBocTU0cDZ5Z1lmbnltZVl1T1ljdlNvM2xvQU5Tb0VOWGJkOS81czZM?=
 =?utf-8?B?b1R0WnlITDd3RkVobFV4ZEZGUHBUTlRuaWZIaE9Pc1B1dDR5Y3pyOTNPbU40?=
 =?utf-8?B?VTlrWjJFYVZlNXA1LzRYYXFUQkNSTlVuVDMxS1BXdHhhZkFTbE4zQStETTFC?=
 =?utf-8?B?NkhOK0NSakYyQ0lNN0F0Mm5QWUh1eHRqWndueE1uVUlQUU53d3QvLzk2VE4v?=
 =?utf-8?B?c3NxS0tjb0huT3hWMUxmL0QxU1Q0MnNwUG5tK3ZSMXNjd3RCbHNYYllVUnMx?=
 =?utf-8?B?eUE2SjQxVWRyUm40MHlySGRlcTlwUlYyeVA2M3FxTnI0aGhuWGQ3VmZ6SlFw?=
 =?utf-8?B?WEtVM3Q5OVltOFN2eXFwRWVMeW9Ub3lqWkd3Um1nNFl5bW84OXFMNEF2eEY0?=
 =?utf-8?B?bHVEdHNuT1lhcWlTUWdyRm5zRU5qQUJiQTZKaGtOay9IYTZQRkNMQkpLbnZK?=
 =?utf-8?B?N2tFY3dvRjl1UDRQTkozRnN0TGFxWVlYb0J3bnNpdldwVEpXNW5sRTZNZ21h?=
 =?utf-8?B?K2czbTJNUGl1NFBLNGlITVFHWUt4NTZnTkJseTZJeTVIUTNOQjVpdlppZ1Nl?=
 =?utf-8?B?YU5JU2tOMUllU0xHR0JzU0dIOVVZbDJCY1FPeUFBWWtWZ1k0aHNsbnJFODJ5?=
 =?utf-8?B?ZTVFejRMQWVOZGpVQVBJZU14TE80ZC9ya25SOGRneHpDc2Ewc0pDcUQvalBp?=
 =?utf-8?B?cVhzZnY5aUIvYlFSb1N4ZE9jREF5ZXo4bHBPRlB5ai9oOUxuL3RlRDlZZEF6?=
 =?utf-8?B?NW5BVDBDQm5nZ1dvY295YVpjNUozNEQybE9wK0pzRE43MnlBSm1LVE9SK092?=
 =?utf-8?B?dXB0ZFRsTTRaNm5maC9ENzVlaWF4ZHBKVmFUUWEzY3ptN0Jkc2V5cXovUHBR?=
 =?utf-8?B?c3VJbUJENDZteFNNeEdyNUlMNTZnNE43NW91eUVmTi9sSkNLOW50WnFvRzlm?=
 =?utf-8?B?RnRwaEtEc0JWa1hvYnFCbVVhdnhaOHF3OTBkbmhta0s2SmgwdHhyKzRDR0ZB?=
 =?utf-8?B?NVZEMHZtakNTK2FCTUU4WjhreHV1WjJEY0hWZ0h1YUF6NHdOaXAvOUdjYk9j?=
 =?utf-8?B?OE5Uei9abm5kN3YrM0o1aHpJYTRRb2RyR255d0xYVE5ySzErVmZvWjh4S1FL?=
 =?utf-8?B?S3hCeHdnL1Q5cGR5SEh6elcwcERFMUc1a29WY2FFa1ZUQXFob2NBNlNWMGhL?=
 =?utf-8?B?WmJFSDBtaWlMSkZCT3pmbWc5SjBWcTNQZ0h5RjkxMTdkUGY0SS9vbGtCR0ZL?=
 =?utf-8?B?Lzd1OVpwemdPRVMzOEx3amREU1hXczdhWmh3dldiVytEWmNjdzE5ZjF0RC8r?=
 =?utf-8?B?V0FCN0VCdUU0RjcvengyZ0l4UjJkVk0rcGVFOWZ0MnMzTVpiMHpFdnI1eEo5?=
 =?utf-8?B?Q3ZBQTk2dUZYSlJSTU1JQTZ5eUhMZEhpMit5M0F6NFdib0Faajk1SHVnVnYv?=
 =?utf-8?B?K1BGY0FpVHRYeVdNKyt1TjZ6SnJqUlhhb3djaHNxSGFJR2MvYzZBa1BKbC9U?=
 =?utf-8?B?ZjJGRDFLY09hTnJWb01Zb09vTlEyNnRLWjczQ0h2clY3djNxdVhRRVl1bHln?=
 =?utf-8?B?ZXRFVjc3d2ptYXJ6RUF4V1QybWdlSEE4N0trVnhTTUoyM1lJaU1iaU1yd3l6?=
 =?utf-8?B?Rm8zSENZbnFzSWJnVithblpxRElnc2VaM04wOEFQNGtpU0xKQnRYRDVaL2Vt?=
 =?utf-8?Q?fG4Y=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510d802f-0f40-48d7-f596-08dd634ef4ae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 23:21:32.2688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jBLIShs3RtrBL2uhiH/Xp95DTDJgmyggnxmyZ+UzigSw/SrOK8+Tb7FNqmXEkHFtt1D2aHyZk5qWL9q5oKzk8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7384

On Fri, Mar 14, 2025 at 05:10:59PM -0500, Bjorn Helgaas wrote:
> On Fri, Mar 14, 2025 at 11:21:19AM -0400, Frank Li wrote:
> > On Thu, Mar 13, 2025 at 06:56:17PM -0400, Frank Li wrote:
> > > On Thu, Mar 13, 2025 at 05:04:50PM -0500, Bjorn Helgaas wrote:
> > > > On Thu, Mar 13, 2025 at 11:38:42AM -0400, Frank Li wrote:
> > > > > The 'ranges' property at PCI controller parent bus can indicate address
> > > > > translation information. Most system's bus fabric use 1:1 map between input
> > > > > and output address. but some hardware like i.MX8QXP doesn't use 1:1 map.
> > > >
> > > > I think you've used reg["addr_space"] to get the offset for Endpoints
> > > > forever.
> > >
> > > Yes, it still need ranges informaiton at parent bus.
> > >
> > > 	bus@000
> > > 	{
> > > 		ranges = <...>; [1] /* still need this */
> > > 		pcie {
> > > 			ranges = <...>;[2]
> > > 		};
> > > 		pcie-ep {};
> > > 	}
>
> Yes, of course. I'm just making the point that the subject/commit log
> says this patch uses 'ranges' but in fact it uses 'reg'.

Actaully my means: 'ranges' in subject means parent bus's ranges. Anyway
how about:

Use reg['config'] dettect parent_bus_offset to get rid of cpu_addr_fixup() callback

>
> > > > I just noticed that through v9, you used 'ranges' to get the offset
> > > > for the Root Complex (with "Add parent_bus_offset to resource_entry"),
> > > > and I think v10 switched to use reg["config"] instead.
> > > >
> > > > I think I originally proposed the idea of "Add parent_bus_offset to
> > > > resource_entry" patch, but I think it turned out to be kind of an ugly
> > > > approach.
> > > >
> > > > Anyway, IIUC this v11 patch actually uses reg["config"] to compute the
> > > > offset, not 'ranges', so we should probably update the subject and
> > > > commit log to reflect that, and maybe remove the now-unused bits of
> > > > the devicetree example.
> > >
> > > We use reg["config"] to detect offset, but still need parent dts's ranges.
> > > There are two ranges, one is at parent pci bus [1], the other is under
> > > 'pci bus' [2].
> >
> > Beside, luckly dwc use reg["config"] to indicate config space. but dt also
> > define ranges [2] under pcie node, which can also include 'config's space.
> >
> > cadence also use reg["cfg"] to do that.
> > res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> >
> > I am not sure why both choose use reg[] instead of [2]ranges under
> > pcie node. But the result make our situation simpler.
> >
> > > Although use reg["config"], but still need ranges [1]. And information at
> > > ranges [2] also need be correct.
> > >
> > > The whole devicetree example also validate to help write address translate
> > > informaiton.
> > >
> > > > I do worry a little bit about the assumption that the offset of
> > > > reg["config"] is the same as the offset of the other pieces.  The main
> > > > place we use the offset on RCs is for the ATU, and isn't the ATU in
> > > > the MemSpace area at 0x8000_0000 below?
> > >
> > > No, "Bus fabric" only decode input address from "0x7000_0000..UPLIMIT".
> > > Then output address to 0x8000_0000..UPLIMIT. So below 0x8000_0000 never
> > > happen.
>
> Minor miscommunication, I think.   I didn't mean there were addresses
> smaller than 0x8000_0000; I meant that in the picture, MemSpace at
> 0x8000_0000 is below CfgSpace at 0x8ff0_0000.  The important point is
> that CfgSpace is a separate region from MemSpace, and we're applying
> the CfgSpace offset to the ATU in MemSpace.
>
> I think it's OK to assume that for now.  AFAICS there is nothing in
> devicetree that explicitly mentions the ATU input address space; it's
> just implicitly part of the intermediate address space described by
> the bus@5f000000 'ranges'.

Actually 'ranges' means address tranlation from child node to parent node.
that should means address to ATU input. It will be good if docuemnt
somewhere. Do you think where should document?

>
> > > > It's great that in this case the 0x7ff0_0000 to 0x8ff0_0000 "config"
> > > > offset is the same as the 0x7000_0000 to 0x8000_0000 MemSpace offset,
> > > > but I don't know that this is guaranteed for all designs.
> > >
> > > So far, it is the same for use dwc chips. If we meet difference, we can
> > > add later.
> > >
> > > reg["config"] only simplied our implement base on the offset is the same.
> > > But whole concept is unchanged.
>
> > > > > See below diagram:
> > > > >
> > > > >             ┌─────────┐                    ┌────────────┐
> > > > >  ┌─────┐    │         │ IA: 0x8ff8_0000    │            │
> > > > >  │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
> > > > >  └─────┘    │   │     │ IA: 0x8ff0_0000 │  │            │
> > > > >   CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
> > > > > 0x7ff8_0000─┼───┘  │  │             │   │  │            │
> > > > >             │      │  │             │   │  │            │   PCI Addr
> > > > > 0x7ff0_0000─┼──────┘  │             │   └──► IOSpace   ─┼────────────►
> > > > >             │         │             │      │            │    0
> > > > > 0x7000_0000─┼────────►├─────────┐   │      │            │
> > > > >             └─────────┘         │   └──────► CfgSpace  ─┼────────────►
> > > > >              BUS Fabric         │          │            │    0
> > > > >                                 │          │            │
> > > > >                                 └──────────► MemSpace  ─┼────────────►
> > > > >                         IA: 0x8000_0000    │            │  0x8000_0000
> > > > >                                            └────────────┘
> > > > >
> > > > > bus@5f000000 {
> > > > > 	compatible = "simple-bus";
> > > > > 	#address-cells = <1>;
> > > > > 	#size-cells = <1>;
> > > > > 	ranges = <0x80000000 0x0 0x70000000 0x10000000>;
> > > > >
> > > > > 	pcie@5f010000 {
> > > > > 		compatible = "fsl,imx8q-pcie";
> > > > > 		reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
> > > > > 		reg-names = "dbi", "config";
>
> > > > > 		#address-cells = <3>;
> > > > > 		#size-cells = <2>;
> > > > > 		device_type = "pci";
> > > > > 		bus-range = <0x00 0xff>;
> > > > > 		ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
> > > > > 			 <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
>
> Of course we need this 'ranges' to describe the translation between
> intermediate addresses and PCI bus addresses.  My point is that this
> is not relevant to the parent bus offset we're computing in this
> patch.
>
> So I think for purposes of this patch, we can omit pcie@5f010000
> #address-cells and everything after it.
>

Okay, we can remove it.

Frank

> Bjorn

