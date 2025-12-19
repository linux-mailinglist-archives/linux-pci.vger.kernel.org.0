Return-Path: <linux-pci+bounces-43441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC9ECD1620
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 19:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A2E33064E54
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6F61DE887;
	Fri, 19 Dec 2025 18:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="xPnviqgO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="pVkW4r25"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020128.outbound.protection.outlook.com [52.101.84.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADDF27E074;
	Fri, 19 Dec 2025 18:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.128
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766169354; cv=fail; b=HP1EFqtOP5eM8FDTo/MYbT5Puhc1/O4Qzbb+dKrqbec7eHUtJi1rKu748h4Uv4GfX4iehfeBKuSJCjY4bH2Tr7pSSPFDRWbTktZpBpQo82fTci2RTGB8qVTzAOKkN3pVRKtt32n56Kx6no7lkF/A0+AmGTen1Ggukb0nEbKD1/s=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766169354; c=relaxed/simple;
	bh=jEKerVUxWNmB3EyHs9xCruDp3nug6nrTktH6+xrYEkU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Eb5CZGDznXKobyalqynyvrLe2QDOiE7HqQVwzIRN8fLjLhPfGVJtrX5x+w6JwRtgI7zJ2qTJmkEmqzCZVE+XPzd5sbw4QdJgYOEf0Ss2EVwgNz9CgtLla41tiVAlNONeDrBCiLMPtDcC/LuzqlS1iEycW0ziij799RsQ+j2CyuE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=xPnviqgO; dkim=fail (2048-bit key) header.d=seco.com header.i=@seco.com header.b=pVkW4r25 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.84.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=PlLuCsQbAjNAfFm1AMEs4uqVNqpA2GopSCpwv3NsbsHxNOvVSbnSRdfjoAAtBLUvELJxFirrovDVGQROAz8ZGBlTPvaBJE7h0PENhGQeQZ3oN+NvzHoyysQb7lXmyIzKBZS0lelt7mIP03VBh+YZg7Rwka/FBKhxU3d5h9zT0vvyFmX17LE62QL2SWv5MmrvqkA1oZRBEmnV1V35Q6ypW95aplMYDGdMh4OhWWSMqZ19Op7m3bklTJrayKF/sJTEej/RQNj3rxGTA+XXLe2GfEqFHjJE4vLljLDvTAldM+0LgOOpCxUgw94kGX/W6+qDgZTFlFu1IaMgtxzaCPYKDg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPfpEWW+YqEs8XaeUKdU21pQxmLvEfITTMAtQ+XssBA=;
 b=Hm5SIxAu8BzLfUu2SRlwu8U0tzLCDd1RqeUuO2Kk7i3aYBCfF44kCTso9FpylbarMC+oPDjZH3iQtQPbhDR/sGQiqfETRmOAIpf55Uv+lpmQ5ufZjW410j4q2r8+2bhTfYPeUdug4ZsMqnhWrIZ2rdGRUmBezeM3wLqfMPErEnIOjY71vZMgL8LR3RpZWOD4pXfAQaqY+cnCGq+4nx9jqIUX2amdt3wbFon8ufd9giJwK2wnCwk63YNQ8dL3ouTycXBF4MSXvRhWsNJB86Ee/dH4/zMnf1aemOUHG7SObHDyQt05/gWaykjCNQAydEytboQZIdIxCkj4asUA1l36rA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.85) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPfpEWW+YqEs8XaeUKdU21pQxmLvEfITTMAtQ+XssBA=;
 b=xPnviqgOvvskjx40ZPuMdF0vrAuzHoK1Ag2IotpYYPlJwXFsWDBr8MgKNbXQ0Imy2llgiG9/eyygbpJem39Pr5HKO5+zSZOMHDEXpIbTNPCoWBhFcF020sw9uxAFG5CH7XgzrcN1s+HCgRylJodF/rjjB7wmLhcZkb/QsD2c8JRR2/zvkXUH+KZjrrBhhSJuCJ0Y8pOwPFoj8EXLChRWuPhAgB9nAmUK+8y0Omu/4IkN6NqQqKWMI6IbzEURDfzbcmY8CcofWSqN4+zNkVgPdVQT4zTEcypUixRbcFpdcaSUAG48SR6+nOCW7mVlK3nqePHsHiz/eAjIJt/Mw4QM4g==
Received: from AM9P193CA0025.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::30)
 by AS8PR03MB7287.eurprd03.prod.outlook.com (2603:10a6:20b:2e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Fri, 19 Dec
 2025 18:35:47 +0000
Received: from AM1PEPF000252E1.eurprd07.prod.outlook.com
 (2603:10a6:20b:21e:cafe::80) by AM9P193CA0025.outlook.office365.com
 (2603:10a6:20b:21e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Fri,
 19 Dec 2025 18:35:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.85)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.85 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.85; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.85) by
 AM1PEPF000252E1.mail.protection.outlook.com (10.167.16.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6
 via Frontend Transport; Fri, 19 Dec 2025 18:35:46 +0000
Received: from outmta (unknown [192.168.82.146])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 9A9CD20080EAB;
	Fri, 19 Dec 2025 18:35:46 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (unknown [52.101.83.117])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id BE68820082B63;
	Fri, 19 Dec 2025 18:35:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBs+/QAXWiCJj+5K/kRFf0z8yYdO7gHbdJ+lA/BYAJZjP+NVWwSZRc34wXz3uXYtQhuvumGYb+BRgfvVf3sPHowh7Cvj6aNH/Cfk8ZPh33TMgYFp9DCuKBQAFLiDhHaACP4zHxgbkUgBIYAvawTznBpFu7hKRQ1/0ceB6p1vrxkFhiilZKoHnSmlwV/exEjipmVBvvx7v0HZGKLmSdqoGhZobTjpevMXe6FGvEY2o7HwxKBlwWx2sYf1J7JUcudmlOELMoGtmzK34F/T4xgxdrphqHsumd5c95rRxhrbIwRcAy21CP6hNRJAprWg5RGVnxeY2MbrXzPIxvaUVP1zMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqpnFc53qgMZhcP2wkRw/QqKasdxGNg5cQVyCsb7L3c=;
 b=RPLzJMDKax2C0kG3W41cItoji7PmBlzJ3E3bGPXzjrxNFsqJXP+LKhfdqmsQ4zhMfFzaNqawjf4cs1EBcKy5osCa1pN/ohjs4U5S3lJz1OEHc/6JbJhjlCeQHpwKlFEo6JTRVFqpeDafyZzrRRwBHwjC2f1xQNiOgnQRB0kVkl/GHQBBrakXeGzTxV+8dHTcX9jCNJ8RBsJZAh9qAjF5V2cMSJSa+AQpJuCyjNyE8wI4jzCxo5WaXCURF1vL6eCuHNofqI+CnGZfF5fKRTPL5LAUL0p/WzMzVFc19tnHTZYI+KHP93oth6yI8Dct5Ov4PJPPKhZjZbLUR2QYTHkS2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqpnFc53qgMZhcP2wkRw/QqKasdxGNg5cQVyCsb7L3c=;
 b=pVkW4r25tZ49aJEotJ6Ax+A4GEm7jA6t7fM23wHKz8rQ4M0fQbaXxBHcZnjHUJphs8dJ3kvRPrNF7FpIcyPKj+OzAB6PNBigv+cGj+HOWGASlcnZmKl1fag5KSnUZGuZIrMWDAKWnB3LB0QmGzWxuGxIduUCvR8hHw0+QBD6AOBpWX2e7j3yvM0Mxo7aro52QVRKqTlWNaPcTUX5rkSefPd+cUT6/Xpj+Boqu+L6Qai7gZ0t/umrSbfEZ2JffY0AzHOyCuDdYc0Hx91Jo/w9cr3RLYWFXAc8jXH/YnWkpyLt+i/fjC3XLMR8g7CKRqZk2SRqetlPXqNGiJVrMR1dnA==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by DB9PR03MB7723.eurprd03.prod.outlook.com (2603:10a6:10:2cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 18:35:43 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 18:35:43 +0000
Message-ID: <dec83f5f-6238-43b3-8fe7-41f301347935@seco.com>
Date: Fri, 19 Dec 2025 13:35:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] PCI/pwrctrl: Switch to the new pwrctrl APIs
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>,
 Brian Norris <briannorris@chromium.org>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>,
 Chen-Yu Tsai <wenst@chromium.org>
References: <20251216-pci-pwrctrl-rework-v2-0-745a563b9be6@oss.qualcomm.com>
 <20251216-pci-pwrctrl-rework-v2-5-745a563b9be6@oss.qualcomm.com>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20251216-pci-pwrctrl-rework-v2-5-745a563b9be6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::32) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAVPR03MB9020:EE_|DB9PR03MB7723:EE_|AM1PEPF000252E1:EE_|AS8PR03MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: 69971792-c264-4547-9f19-08de3f2d6d06
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?SlBsbE94cGZNRGNPZHhJYWtEay9tWmJFNTJ4WXMxL0xHb0lzT0Zna24zZ0Uw?=
 =?utf-8?B?cXhPem8vMVhSUGc4UGJxWjhxcWE5Vm81eXFPT0gwMXBOeC94VGg2ckxGQTJY?=
 =?utf-8?B?RDJiRlVVMUxLQnRtQml2TWpjYlQ3Q2d3ZndyNUpGdzBiYTFtcTFWWk5IM0JG?=
 =?utf-8?B?S3RPMnBCK3MrWVJqWGZDOVJ0NEVTbVFPcmlHNWYvT1RHS2paMHYzNmVkS3Jr?=
 =?utf-8?B?Myt2OU9xZ2VzY1hFb2NGOUJrTGVRck1EbjYrU3NUN1UrMUNVM1JZMDJmLzVJ?=
 =?utf-8?B?cG1idnFIY2MyUzhZN2NBV242OTF5YmZzckdFcnMrdnRVQVh0TXBrVThxVzJN?=
 =?utf-8?B?a2o4Mk44Q1RTVkt0WVVkNE81aFE3elV3YjVzaC9HNExYZzVTZnpKZkQyM0ZL?=
 =?utf-8?B?UzdHZ2gvd2lSYlZ0NC9OQm9OSzFSOEJHVlRreDdLTHZJWVBNZ0trNjdSODZi?=
 =?utf-8?B?bnpZYm80Mml5cnJHK2xTWGhpT0lndUloSnBOT2RSQ3EzTW9FRUcyRFFJMmZT?=
 =?utf-8?B?VytCakRueEsrbzRDNnZzczhWSlFGTWg5WHpXWC84MXczNS8wNHF4THJ5S20v?=
 =?utf-8?B?K2pmZkJnZklvK0NFcEh3VnBUSHdXaXBqcTRmZVVZV0lDZ3hzeGxUWTJiTGMr?=
 =?utf-8?B?bkZkOGdDUkZhN1Z0SU81MHhDRzljSTRnOUZQdk5BUzl3d3YrUk11RGlLNVVK?=
 =?utf-8?B?OU5oL3BIQ0NKRjZhNTRpVW1YRXVxSHRFdUd3Zk9hQzZVMTlrd3I4ZndBWk1F?=
 =?utf-8?B?OVFuY04wV3dmc0hmam1oMngrTG9EN3hHVnJ4TlhvS0JNQ3pGMkZWVGc1cDhn?=
 =?utf-8?B?a1o0QytWaUcyRHY5VDlzcThYR3JTNG4wdExSQWJleVRGaXNTbjBlVzNqNjAx?=
 =?utf-8?B?d21iZVlhNEV4UTkxRUZSaEdSTk1OWmxndmQ0c2w1MnhGaEVvYkw0cWJESzNi?=
 =?utf-8?B?QTVnRFdScEFRYS9saVBFSE1TeEtWaExnL0UvSlRnN3M0V2lwZWxERmgrbEhF?=
 =?utf-8?B?emZBSk5XRmp6ZUlHMFFXYVdKdDdZdDBES2czdFNNVEZOcFhsOVZxY3ZFN3Az?=
 =?utf-8?B?NFF1a096SW10dVV6VlAwdjJGYThvam5HMkRsQmI1bEoxeDRURmwwVW91QXl4?=
 =?utf-8?B?bk1tcGZONWx5OUVCL0RLb05UK2dIRVJjdStOeFN3bjlSQ2NRL0htVklrN1JZ?=
 =?utf-8?B?WTR1T3J4U1lscTRFRHh0Q2xncHh5dFhrdWFEVmdzMXV5cVkwa1dQSzM4K0Rm?=
 =?utf-8?B?NDhUd283bDlhYTF1aE5WcDYzbFdxLzhIaDhrME1yUVdOWk1HSXBQYTJDOVJu?=
 =?utf-8?B?SVpUeG5teFQvR015Mi9WZlhWZnd3bFRpQ0pNM01xZ2ZXZ3pINjk3cDNockZx?=
 =?utf-8?B?ZGlrS2crSDNCTTdwTWs3cTRpY0RpYm9qbU9MeHk4QjFtQ0lYRVRuVzZyVUJk?=
 =?utf-8?B?Z3YxdXZRVVJVNUxLWWdWczUvbFMwQ2k4TWxmNmpPeUxMSnRublNYbXlVQmk5?=
 =?utf-8?B?TFRaQzhOUUJWQmJraTRmYTlMVFJibWZ4TWVVcURlb0pETVlxWFh5MUtCakVj?=
 =?utf-8?B?U0lIdkUybGpLWEpWRy9Va1RlZVdiUWlVY2NLNmRGRWlqbTlYNU9uRFFEbFVo?=
 =?utf-8?B?V0IxekFiRHFHTzgwWThKYjhyempWWFEzaDBzTExNUHpYZG04RXFtYUVYeGtp?=
 =?utf-8?B?UWMwUmFkY0FmRFJKOGRJWkJKMUtjWWE4cnJVbmJDVDRTWHM2Y1o0bW82Tnd0?=
 =?utf-8?B?c21NTUlXNFQ3OHFMQWhueGhNMUN4UitHOCthblptaVFiYTRmV0wwQ3crWWNJ?=
 =?utf-8?B?OE10VVowWWtMM1A0NjlkUTdQcG5YcUpBZ0djTG1MOEk4bHZXT2dBc0RSQ0pT?=
 =?utf-8?B?MFh5ek4yY1M4VGxxMnJqWHJ0MGJRTWc5RnZUOW5CUk1EYmkzdG5DOENZWWVD?=
 =?utf-8?Q?cHWu/QVXwmpbqhi2/bTmpeOihrVCFpKW?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR03MB9020.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7723
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252E1.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	4bd532f0-88f6-40bf-a772-08de3f2d6aef
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|14060799003|35042699022|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjFZb05yZHA2RnlTNjdha3dLeU9ycXJJZ24zcEFPdHdGMW1rZEZsVUlBUzdy?=
 =?utf-8?B?Y1h2SHdkQTVFYnlDa0lFQUEvdXFXY0VMYm5kQVdWeXFZN0V3TitzZjM5RlA3?=
 =?utf-8?B?VlBhWHNTUkJnMTdJdUxuWE1SMDFkSk90YWFYUnhRZ1ZCZGY4SjJubWNNbHY0?=
 =?utf-8?B?ZGcvYVZoTVhUaVV5cVdkZ1lNSHhoazZNWmQ4YThCa0QwZytxbE52OXdxZmhC?=
 =?utf-8?B?bXN6WSt6dkhXNklQbkNML0YwN2lXcmdsYW9HWm1wSCtnRlorMVdTSVdXVDND?=
 =?utf-8?B?ZXBZSDMvR2Fkc2NkY2ZJdkE1bElCdTBYMkVoT1pZQ0grL0dkSFQ4WXBhaEN3?=
 =?utf-8?B?ZXdRTExvOUJGblUvUXlQT2dJdWRvOEk2Tk1LZCtPMjdiWlJvZTlRaC9FOVkr?=
 =?utf-8?B?REI0Ry9jVnphVDFVSDBBeUlXckZkUTlQNGsvUVFHMGdObGk3YVdXZDB6NjNs?=
 =?utf-8?B?M3hUcktQTHpkS1JsNzZOL0NKQVRhTmRUVFAyMyt3eDhUeGRua2JxVUFkdTZl?=
 =?utf-8?B?U0N4MGtwL0NubXIveHJaektnUGQ4MGducUE3UXdBcGF4YTlJTFd4K1NsR3dE?=
 =?utf-8?B?VDBUZmNJaUFhOHFKY0RrSUpINjRXZUxndVpLM3BjZkZZa1Y2NC85UHA2OFc4?=
 =?utf-8?B?a21wMUpKSVYrZElTM1Fka3lBb3dQZmt6Qlp5Q2ZYc3U0c1lHZHdsZk5aTGly?=
 =?utf-8?B?cXI1US9yT3U2OElNRXlPNXZVQUhITjQvM0o0VjZvbmhZejFlRGhkTkNwTlQz?=
 =?utf-8?B?RUovNWZPVFpHVzYvMGE4eFQzTjlraVllYjVjYjRBS3RwQStVd0dKTXF1YnFN?=
 =?utf-8?B?SlI0aExld25TZTVKbGN5dFJWZHpGcVFkb3NTaTFwZ1RaQjNIQTVUbTZNVXRU?=
 =?utf-8?B?bmpKeWljQU5md1psc08zT09ua3FUOW5wWXpFS3NNMmRDaEVheU42UjV2dnNl?=
 =?utf-8?B?V1gycHE1RXhPdnZ5N0RVVjVEYlZsMkwybDhnNTU1QjREZS9qUTZJZTEzVFYv?=
 =?utf-8?B?S1lvSjVTN0thdDRzSk5MMjBHYkhjZzFzejYyY29yVXhWak5LQ2pEVW5Uc1Br?=
 =?utf-8?B?ZUNOTmVFQzVVMFNMY3NBVlJrNWpFRHFndnJFQkJ5RzN0THRsQm11Z1BxRTZk?=
 =?utf-8?B?YU1lZlRNWU9IZlJMUytxeEhXUHJCTDFmK0h4cDBBS052TCtKRXc2SVJiSnVE?=
 =?utf-8?B?RDdZR0xqVEM2ZWd4Wk03RHl4RDlja2RNcFoxUzE0dDdwOEw1ODBHSEY0TUxU?=
 =?utf-8?B?QXVSekk4c3IzdEJoSXR4dnErcXdYT2VlNjlZNjhTQzRlamI5UUpjcGVlM1E2?=
 =?utf-8?B?K0YxeTloV0R4M2c5c0E2UGFjTmtxalZBRzVBbFEvc1BnTXk5QzlRZ2NIVFZ3?=
 =?utf-8?B?SjNFd2Z4cndNRmdkR3I2VW9Eb2dndlNmSmNlREhpeGs0OW9TNEVCNlRMajg2?=
 =?utf-8?B?Q2hLeDE2MDJPODhZNTY0L3F5cHlOVVlHN0s0Y2FYdkNaZUQzekNmY3ZtdjNh?=
 =?utf-8?B?VnpKYU1UdkJScmVQdlFvdFl2dUc3U0ZmV3ZvNnJGbnpuZkNGdUZZbElUR0dY?=
 =?utf-8?B?TXdoTmtMcWo3U081QWNZOWx6UVA3VjBFTElMbTBhV0x3UnNHN0I0MTBrcG1i?=
 =?utf-8?B?UUdhSG84MEx3ZlFtT2hRam9WQU1YUzdtUVluQXJ4cjh4a2Q4RFRmMkNObS9F?=
 =?utf-8?B?c1dVNEQ3S0phUXlrUU0zeHVFam9ITHhQZGdTNjB0VjV3VEN3L1VJRlV3a3VX?=
 =?utf-8?B?NlZoS1NHcWlmY3VxZ3VwZE5rdGZtUUxrcVBxSGNYSVhTVi9jbUdPR2lTY2Yw?=
 =?utf-8?B?ZXloL01FZUZaSEpqL0NkdEJDM28waU9haU9iNWJVV3B5YmV6UEhXTUlLQldr?=
 =?utf-8?B?SHhkSG1LN3FpbWJ2eDJrVGpSVXhGRzA3Rkl2MHptZHFiZk9pbjZsYnR1SjRB?=
 =?utf-8?B?QkJWdW1hODNqVlRxK3NTUUx6ekd6VUZLaGVFcjJZZHFkMUpFdU9EaGdJUk5m?=
 =?utf-8?B?Y29YUnZNWW5Wc0d5cEVoUThYNEZtTXNIejQ1RVZOWEF1WHBCSC9xdUVHdGlK?=
 =?utf-8?B?VlBLT1FwaTU3dExEeVJCYmlnSWZHaWJuZEF1MmZZeWlkSmI0aCtpZXN1Yk4x?=
 =?utf-8?Q?ZRSQ=3D?=
X-Forefront-Antispam-Report:
	CIP:20.160.56.85;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(14060799003)(35042699022)(36860700013)(7416014)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 18:35:46.7947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69971792-c264-4547-9f19-08de3f2d6d06
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.85];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252E1.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7287

On 12/16/25 07:51, Manivannan Sadhasivam wrote:
> Adopt the recently introduced pwrctrl APIs to create, power on, destroy,
> and power off pwrctrl devices. In qcom_pcie_host_init(), call
> pci_pwrctrl_create_devices() to create devices, then
> pci_pwrctrl_power_on_devices() to power them on, both after controller
> resource initialization. Once successful, deassert PERST# for all devices=
.
>
> In qcom_pcie_host_deinit(), call pci_pwrctrl_power_off_devices() after
> asserting PERST#. Note that pci_pwrctrl_destroy_devices() is not called
> here, as deinit is only invoked during system suspend where device
> destruction is unnecessary. If the driver becomes removable in future,
> pci_pwrctrl_destroy_devices() should be called in the remove() handler.
>
> At last, remove the old pwrctrl framework code from the PCI core, as the
> new APIs are now the sole consumer of pwrctrl functionality. And also do
> not power on the pwrctrl drivers during probe() as this is now handled by
> the APIs.
>
> Co-developed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.=
com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c   | 22 ++++++++++--
>  drivers/pci/probe.c                      | 59 --------------------------=
------
>  drivers/pci/pwrctrl/core.c               | 15 --------
>  drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c |  5 ---
>  drivers/pci/pwrctrl/slot.c               |  2 --
>  drivers/pci/remove.c                     | 20 -----------
>  6 files changed, 20 insertions(+), 103 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index 73032449d289..7c0c66480f12 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -24,6 +24,7 @@
>  #include <linux/of_pci.h>
>  #include <linux/pci.h>
>  #include <linux/pci-ecam.h>
> +#include <linux/pci-pwrctrl.h>
>  #include <linux/pm_opp.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/platform_device.h>
> @@ -1318,10 +1319,18 @@ static int qcom_pcie_host_init(struct dw_pcie_rp =
*pp)
>       if (ret)
>               goto err_deinit;
>
> +     ret =3D pci_pwrctrl_create_devices(pci->dev);
> +     if (ret)
> +             goto err_disable_phy;
> +
> +     ret =3D pci_pwrctrl_power_on_devices(pci->dev);

Won't this result in a deferred probe loop if there is more than one
pwrctrl device and one has a driver loaded but the other does not?

deferred_probe_work_func()
  driver_probe_device(controller)
    qcom_pcie_probe(controller)
      pci_pwrctrl_create_devices()
        device_add(pwrctrl1)
          (probe successful)
          driver_deferred_probe_trigger()
        device_add(pwrctrl2)
          (driver not loaded)
      pci_pwrctrl_power_on_devices()
        return -EPROBE_DEFER
      pci_pwrctrl_destroy_devices()
        device_unregister(pwrctrl1)
        device_unregister(pwrctrl2)
    driver_deferred_probe_add(controller)
    // deferred_trigger_count changed, so...
    driver_deferred_probe_trigger()

And now you will continually probe the controller until all of the
drivers are loaded.

There is a non-obvious property of the deferred probe infrastructure
which is:

        Once a device creates children, it must never fail with
        EPROBE_DEFER.

So if you want to have something like this, the pwrctrl devices need to
be created before the controller is probed. Or you can use the current
system where the pwrctrl devices are probed asynchronously.

--Sean

> +     if (ret)
> +             goto err_pwrctrl_destroy;
> +
>       if (pcie->cfg->ops->post_init) {
>               ret =3D pcie->cfg->ops->post_init(pcie);
>               if (ret)
> -                     goto err_disable_phy;
> +                     goto err_pwrctrl_power_off;
>       }
>
>       qcom_ep_reset_deassert(pcie);
> @@ -1336,6 +1345,10 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *=
pp)
>
>  err_assert_reset:
>       qcom_ep_reset_assert(pcie);
> +err_pwrctrl_power_off:
> +     pci_pwrctrl_power_off_devices(pci->dev);
> +err_pwrctrl_destroy:
> +     pci_pwrctrl_destroy_devices(pci->dev);
>  err_disable_phy:
>       qcom_pcie_phy_power_off(pcie);
>  err_deinit:
> @@ -1350,6 +1363,11 @@ static void qcom_pcie_host_deinit(struct dw_pcie_r=
p *pp)
>       struct qcom_pcie *pcie =3D to_qcom_pcie(pci);
>
>       qcom_ep_reset_assert(pcie);
> +     /*
> +      * No need to destroy pwrctrl devices as this function only gets ca=
lled
> +      * during system suspend as of now.
> +      */
> +     pci_pwrctrl_power_off_devices(pci->dev);
>       qcom_pcie_phy_power_off(pcie);
>       pcie->cfg->ops->deinit(pcie);
>  }
> @@ -2027,7 +2045,7 @@ static int qcom_pcie_probe(struct platform_device *=
pdev)
>
>       ret =3D dw_pcie_host_init(pp);
>       if (ret) {
> -             dev_err(dev, "cannot initialize host\n");
> +             dev_err_probe(dev, ret, "cannot initialize host\n");
>               goto err_phy_exit;
>       }
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 41183aed8f5d..6e7252404b58 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2563,56 +2563,6 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bu=
s, int devfn, u32 *l,
>  }
>  EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
>
> -#if IS_ENABLED(CONFIG_PCI_PWRCTRL)
> -static struct platform_device *pci_pwrctrl_create_device(struct pci_bus =
*bus, int devfn)
> -{
> -     struct pci_host_bridge *host =3D pci_find_host_bridge(bus);
> -     struct platform_device *pdev;
> -     struct device_node *np;
> -
> -     np =3D of_pci_find_child_device(dev_of_node(&bus->dev), devfn);
> -     if (!np)
> -             return NULL;
> -
> -     pdev =3D of_find_device_by_node(np);
> -     if (pdev) {
> -             put_device(&pdev->dev);
> -             goto err_put_of_node;
> -     }
> -
> -     /*
> -      * First check whether the pwrctrl device really needs to be create=
d or
> -      * not. This is decided based on at least one of the power supplies
> -      * being defined in the devicetree node of the device.
> -      */
> -     if (!of_pci_supply_present(np)) {
> -             pr_debug("PCI/pwrctrl: Skipping OF node: %s\n", np->name);
> -             goto err_put_of_node;
> -     }
> -
> -     /* Now create the pwrctrl device */
> -     pdev =3D of_platform_device_create(np, NULL, &host->dev);
> -     if (!pdev) {
> -             pr_err("PCI/pwrctrl: Failed to create pwrctrl device for no=
de: %s\n", np->name);
> -             goto err_put_of_node;
> -     }
> -
> -     of_node_put(np);
> -
> -     return pdev;
> -
> -err_put_of_node:
> -     of_node_put(np);
> -
> -     return NULL;
> -}
> -#else
> -static struct platform_device *pci_pwrctrl_create_device(struct pci_bus =
*bus, int devfn)
> -{
> -     return NULL;
> -}
> -#endif
> -
>  /*
>   * Read the config data for a PCI device, sanity-check it,
>   * and fill in the dev structure.
> @@ -2622,15 +2572,6 @@ static struct pci_dev *pci_scan_device(struct pci_=
bus *bus, int devfn)
>       struct pci_dev *dev;
>       u32 l;
>
> -     /*
> -      * Create pwrctrl device (if required) for the PCI device to handle=
 the
> -      * power state. If the pwrctrl device is created, then skip scannin=
g
> -      * further as the pwrctrl core will rescan the bus after powering o=
n
> -      * the device.
> -      */
> -     if (pci_pwrctrl_create_device(bus, devfn))
> -             return NULL;
> -
>       if (!pci_bus_read_dev_vendor_id(bus, devfn, &l, 60*1000))
>               return NULL;
>
> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index ebe1740b7c1c..4e2c41bc4ffe 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c
> @@ -45,16 +45,6 @@ static int pci_pwrctrl_notify(struct notifier_block *n=
b, unsigned long action,
>       return NOTIFY_DONE;
>  }
>
> -static void rescan_work_func(struct work_struct *work)
> -{
> -     struct pci_pwrctrl *pwrctrl =3D container_of(work,
> -                                                struct pci_pwrctrl, work=
);
> -
> -     pci_lock_rescan_remove();
> -     pci_rescan_bus(to_pci_host_bridge(pwrctrl->dev->parent)->bus);
> -     pci_unlock_rescan_remove();
> -}
> -
>  /**
>   * pci_pwrctrl_init() - Initialize the PCI power control context struct
>   *
> @@ -64,7 +54,6 @@ static void rescan_work_func(struct work_struct *work)
>  void pci_pwrctrl_init(struct pci_pwrctrl *pwrctrl, struct device *dev)
>  {
>       pwrctrl->dev =3D dev;
> -     INIT_WORK(&pwrctrl->work, rescan_work_func);
>       dev_set_drvdata(dev, pwrctrl);
>  }
>  EXPORT_SYMBOL_GPL(pci_pwrctrl_init);
> @@ -95,8 +84,6 @@ int pci_pwrctrl_device_set_ready(struct pci_pwrctrl *pw=
rctrl)
>       if (ret)
>               return ret;
>
> -     schedule_work(&pwrctrl->work);
> -
>       return 0;
>  }
>  EXPORT_SYMBOL_GPL(pci_pwrctrl_device_set_ready);
> @@ -109,8 +96,6 @@ EXPORT_SYMBOL_GPL(pci_pwrctrl_device_set_ready);
>   */
>  void pci_pwrctrl_device_unset_ready(struct pci_pwrctrl *pwrctrl)
>  {
> -     cancel_work_sync(&pwrctrl->work);
> -
>       /*
>        * We don't have to delete the link here. Typically, this function
>        * is only called when the power control device is being detached. =
If
> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c b/drivers/pci/pwrct=
rl/pci-pwrctrl-pwrseq.c
> index 0fb9038a1d18..7697a8a5cdde 100644
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
> @@ -101,11 +101,6 @@ static int pci_pwrctrl_pwrseq_probe(struct platform_=
device *pdev)
>               return dev_err_probe(dev, PTR_ERR(data->pwrseq),
>                                    "Failed to get the power sequencer\n")=
;
>
> -     ret =3D pci_pwrctrl_pwrseq_power_on(&data->ctx);
> -     if (ret)
> -             return dev_err_probe(dev, ret,
> -                                  "Failed to power-on the device\n");
> -
>       ret =3D devm_add_action_or_reset(dev, devm_pci_pwrctrl_pwrseq_power=
_off,
>                                      data);
>       if (ret)
> diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
> index 14701f65f1f2..888300aeefec 100644
> --- a/drivers/pci/pwrctrl/slot.c
> +++ b/drivers/pci/pwrctrl/slot.c
> @@ -79,8 +79,6 @@ static int pci_pwrctrl_slot_probe(struct platform_devic=
e *pdev)
>               return dev_err_probe(dev, PTR_ERR(slot->clk),
>                                    "Failed to enable slot clock\n");
>
> -     pci_pwrctrl_slot_power_on(&slot->ctx);
> -
>       slot->ctx.power_on =3D pci_pwrctrl_slot_power_on;
>       slot->ctx.power_off =3D pci_pwrctrl_slot_power_off;
>
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index 417a9ea59117..e9d519993853 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -17,25 +17,6 @@ static void pci_free_resources(struct pci_dev *dev)
>       }
>  }
>
> -static void pci_pwrctrl_unregister(struct device *dev)
> -{
> -     struct device_node *np;
> -     struct platform_device *pdev;
> -
> -     np =3D dev_of_node(dev);
> -     if (!np)
> -             return;
> -
> -     pdev =3D of_find_device_by_node(np);
> -     if (!pdev)
> -             return;
> -
> -     of_device_unregister(pdev);
> -     put_device(&pdev->dev);
> -
> -     of_node_clear_flag(np, OF_POPULATED);
> -}
> -
>  static void pci_stop_dev(struct pci_dev *dev)
>  {
>       pci_pme_active(dev, false);
> @@ -73,7 +54,6 @@ static void pci_destroy_dev(struct pci_dev *dev)
>       pci_ide_destroy(dev);
>       pcie_aspm_exit_link_state(dev);
>       pci_bridge_d3_update(dev);
> -     pci_pwrctrl_unregister(&dev->dev);
>       pci_free_resources(dev);
>       put_device(&dev->dev);
>  }
>

[CES 2026, SECO]<https://exhibitors.ces.tech/8_0/exhibitor/exhibitor-detail=
s.cfm?exhid=3D001Pp000010EbaOIAS>

