Return-Path: <linux-pci+bounces-20015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A05B5A142BD
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 21:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD85E3A3EC1
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 20:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC43232438;
	Thu, 16 Jan 2025 20:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k7fCzwg3"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2068.outbound.protection.outlook.com [40.107.103.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44A623243D;
	Thu, 16 Jan 2025 20:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737057783; cv=fail; b=tVf7A4lK24LG/8Ligm3p2BZY2yVDEEsWj317hf8kcDlgAOoEf9OTSl6KjFdhJhxyu7FInANTG+I3JC3iWqbJgi4lDFLZDAMO5tWXcSPWlUtisPITyKSEWrLRCXb9XBRwB1u1r1HM3/f0lLeXBkJGu8QLybbYZAHpEv16Qkwt9xE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737057783; c=relaxed/simple;
	bh=AeFJBql6b994FrnkWGx15dKWOJICgAdVj7j+CX7Uy5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oAeljdCnrDimYKXZ9p4bKgTRLGnil/sG1yPrbA0g2Kz8AEC9jt2heE3SUxtx4LeTaZ3UlkKWv5S5b6IPREezq1aDgkwPSYUR79m6fj63eb45qHvIoF3AfjgNoARwC2XT5FjBaerz+WENmLHKIkf73Jj4ZFGo98m0sUtm/2uwyoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k7fCzwg3; arc=fail smtp.client-ip=40.107.103.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgpBkATyCGEFZE4BKqbNrWQHueG4X0BPkvd9fWl2MhIeLaxqpgTN2900Ei3tTDibzhXWmIcRtoecfENNNet4ATiYTxRlEOZtkMthNp+OUbX41ZmrWlRAzZkRydvAg3NSs03Xa98aIO+7lM0rR3G8zkm8k/ncrq0yRiHF8bCvJpBq95z9YjcFPB6uy0XtQrAujkHfiSevjqN2TF8gOPv4Y4D14c/Ng8xNe3JhNPN1GWn6TB/6Wo5un19pnZoUZj6JHfzxvznsqrPepsG8+rzcKTnrzw5y63g/RE4IWrYmsoS71YWgxNDIA1PcaG4iwWwDw88Zx0xJTEVFdzvsqIQI0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+POCXov0p2rdbnBh/rd1SkZU7K9yAXNsvdb4Zamu7k=;
 b=AnJ5jZIC0TIN1gc4WhXdDudoykRnc3q/dQ3fNNCmcMZKLFQvS6vpWGGzaLMrtcp00gRxtHpEfye0OMQRtbmQS94OsHITwke4QDCx7r/5jSoRdwUzzLRCGbChKtxCObYeirVJb46QtV1jsbdSRJD19aPsajpE+GMwbNiNeQfLg3nou852SbdulPe6V+ba+n3UPwjZvAJgNed4VBAcusTXT1cLUrnXEaYwMwWWWZZCszkVeZjRO3qBAQodgDdHkeovZjl6wSl1QeJYHFRnNww4u4NfUG8tk+c2rImETlG3actcgIPI648D6ZO2Kr1Mb25wY16+VYZaEVJxbxQjMoFtmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+POCXov0p2rdbnBh/rd1SkZU7K9yAXNsvdb4Zamu7k=;
 b=k7fCzwg3iIL+nxDkP3zvpC/3MPalDYXkYPkDuhkNdpuvIM2bkAchoUXbMHuEDnNQM5xjezkVADRWl0gPw90UNtl72oZUjuQxqKNwKZ17h9G372g2fXpy/XgG+U14MpZyOF+z0M2gX+PYUE4rEhSSIjiWGND9xc5g6mJQCImzZbU9WuEB3ghZvp/KiMrUpb/3wMY5K1D4ONyyS2Fqia/cw4wPa8qlWtpfkDnJAsX9OXMZrFHpYsYymz4RJf8cIOmHrj+C6TairH1Aexgu3ohiCyApitLqKb6zkroaH/rPDCekcZ+HJ/sC5WaVxK9ap94Rs50aayzgGpfxTiunytOQtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA1PR04MB10142.eurprd04.prod.outlook.com (2603:10a6:102:464::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 20:02:53 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%7]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 20:02:53 +0000
Date: Thu, 16 Jan 2025 15:02:44 -0500
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
Subject: Re: [PATCH v8 3/7] PCI: dwc: ep: Add bus_addr_base for outbound
 window
Message-ID: <Z4ll5Ktyh5kmTzsd@lizhi-Precision-Tower-5810>
References: <Z4lKIJ8nDst7rqCs@lizhi-Precision-Tower-5810>
 <20250116194558.GA595994@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250116194558.GA595994@bhelgaas>
X-ClientProxiedBy: SJ0PR05CA0164.namprd05.prod.outlook.com
 (2603:10b6:a03:339::19) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA1PR04MB10142:EE_
X-MS-Office365-Filtering-Correlation-Id: 04424579-e834-4d91-e64b-08dd3668c311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rk14dk5xVFV6eGorOUxVNGZXZkNLQVdBUlN1S0tya0ExTVBsUFFLZXR6dTFO?=
 =?utf-8?B?SGxxSmtRaiswOFJkcWZjMEhlcmw3RmdBUkt4ZENxQmdtbzNnT1JXYkt0ZWE4?=
 =?utf-8?B?TVo4cUFBc0NFaEs3Nk5wZnFRUVU4QytPYnZOWDkzTlV4dEJYcjBnLzU3OEtu?=
 =?utf-8?B?aS96aGZVYkN2T2dwTXpIMjU2N3F0TEZMTks2Uml4RmpqT212TS9OUGEwb2Ni?=
 =?utf-8?B?Ulk5MGtvQis1VW0raTJvNFU3NEFTazFDcmJST2lBbWd2ejFSOWNQbVNyeG5R?=
 =?utf-8?B?WEIzSS9PTHJyczF4bXE1OVIvYUt5ZlZLU3NUc09EdURsWHlJZmk0Yks4REN5?=
 =?utf-8?B?K1IzNVNGeG9sZS9paC9lU2Z1Nks1YzNzMzd5YWdSUnArNTZ0RnNuRkFNSnp1?=
 =?utf-8?B?RitMYVA5cEJKOUJ4Z3Jpa3p2MGdFRTVjQlhnSFgyeElDMTRCYnY3S2NVa1Iz?=
 =?utf-8?B?WTBVK21GcnRHaGFYN29LdDFLRjZpcjBQNlVvckxnUWcwK2RXYUJaSUp3QlVZ?=
 =?utf-8?B?aytydkZOVWpaL1RPWmFiaVVocDlIejd4RjRlY0NjcXVsRGJlRGtnRHF1OHNT?=
 =?utf-8?B?RXB6TlhMUUtIYkI0TU5lcmV6SXNjU0czRGUrS1cvVjFEcTN0RHRXYnUyVDVt?=
 =?utf-8?B?alFMbHFNOVFNYlJJSUNCa0JkT1BlLzZTNmxHcTBqdUh4ellhQ0c1MjZzWHNv?=
 =?utf-8?B?cTh0T3lQbXVKa0txeEFuSjVQRWp4aDJmUXpKeDVGMlowK0NSdTgxNEswUTRH?=
 =?utf-8?B?Qy9CQU80M1ZWSmZpVzE0SVFxT2lMMWRzQnczQngyaUhYY2Rsbjh6eUoyS0pX?=
 =?utf-8?B?QkNGdmY0L1BRZWhaRXJHM1p0WEFvd2d0RXVUOHYrbWNkbEgxUFJtOXRJcWxJ?=
 =?utf-8?B?YjBPRVBrNHgxc1BIL0NRMnVoN0JTK1dadG9nNHhhZDRCdDh5cHEyVGhRM0xz?=
 =?utf-8?B?OUo5eWNFNU1nNlYwdm53Nzd4Nm1kSzRxVVJLeHhlSnVLN1FtM2MyclZKRVVq?=
 =?utf-8?B?MVBxM2pkNWl1bSt0OVU0R1JNZ2g4QTUzaGFmNkgwdHZlNjkvVllzQ2ZLNjRH?=
 =?utf-8?B?M01PanIvbWUyTUdLOVNGMUcxWnlzenJRQ2grdUxUNTh5SUE1a2l5cyt5ZGtB?=
 =?utf-8?B?NmNPeEw3YnhkQ2hDNzZVK3V5ZEt5U05oS0Rpb25sRnY5WlpSOUlrUnlFZWVp?=
 =?utf-8?B?eFE3aEVkRjk0WmN1VWNiM0U5MUxQU244VHRlK2FyNTYxbmMvVE5jUXI1TGFS?=
 =?utf-8?B?d0oydXRUcXUzU1NkZU1iZzFnd1RUODBnRG9mOU8zaVQ2T3NNVVNqUUtwS0dU?=
 =?utf-8?B?dVExMnFxMXlESjF3Z1lQVFlUWkREWkZaeHM5Y1kzUWdtemFRYjIzTlhnY05L?=
 =?utf-8?B?cFJRV1loVDZ3VDVtd1lKMEpsVGpEVEdZWXF6Wk1iaXFQQVA0aThVQ25pME5L?=
 =?utf-8?B?WEtqdzZrS1VRSDQyWi9UUm5VR1E3UWZrUCtPNDBWbEF5QWNJQXg2dnA5M0JM?=
 =?utf-8?B?eUdNS0ZjUk9tU3lieDk2ZXBFN1VFM3J3MVk4bkg3T3Y3WDgxQnc5NE9tU3hE?=
 =?utf-8?B?LzVaMnhybU5vRCtoUW52NmZzbFRJOFQ0Zld5OGN0RmI3aGlTQ25mQjU2RVFq?=
 =?utf-8?B?ZS95RGYzaWt3aE5TTVB5dWdhTWZKTDlIZVprc0txSUdTNWRrbSt0cTRXL2Jv?=
 =?utf-8?B?dnpIU3JUUUhMa3M4emZtb1htRXRWTUdGcHFHb1p6TCsrZ3hHRlRDZjV3aDUr?=
 =?utf-8?B?WWlBOStGYkJ0a2dUMm93aGZtdm1HN0dObFlEc1FPUll4YXNvbk5tdUtjdkZ1?=
 =?utf-8?B?MzFFL0p0QnVETjg3SzJ1WVUvNGRLZzFITHBpM1RFTjRaSCtodHdGNlB2Sy82?=
 =?utf-8?B?Y3FvT3MvbkNCUDBDUWNsZUhkMjlISGpNZWdIRzAyNFlGRFA0UzZ0QVJjN0tH?=
 =?utf-8?Q?Cfdtgg/hnUSHBRj/oMaHySa7NkEF+pG2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d043ZE1lbGlHcVdPSjVGV1JRa2o3ZlkvNEZXSkZ4OWJaN28xK1B1anZJZERK?=
 =?utf-8?B?OHBXSUFRUE0ycFNCcVYvanQ1M1ZjOFhpRHVYYXpGU3ZOSHh3M1JxbzRLaWhL?=
 =?utf-8?B?ZytUSlNJdWZvK291M0hvbjJuSUxQOWFvdWlnTHRtTVYzZ2xEb1NEQWpwTnN4?=
 =?utf-8?B?eGxwQTN5Z0k3UFJnM2I0UnQrRkd6T2ttLzdSMGVPa2V1a3UyYnI3b2JyNGpu?=
 =?utf-8?B?QmFKVldOVS9zeXhISW8xTHJGRW9KZVdvaHh0VVlTYWtyTWhldEUwSUlsMnVn?=
 =?utf-8?B?TUdoOEl6amV1YWZFYmJxK2dTN3ljTDNIT2UwZjduSXhCTTVKVjF2Y0s2UW9h?=
 =?utf-8?B?Y0xZcHdIcHROY1E3MUp0VElrTEZWbFdLUEpYWHdCbVU5OWsxZXYydG5FSUcr?=
 =?utf-8?B?NnNGZk9BUFBFQmlJR2ppMGxiZ0Z5ckNPT0s3OXJwTnRZcXFtTksrOHBscWZy?=
 =?utf-8?B?Yk5PcW9LUHg4ZjhnL3FVcmFaaFcyV1ZWUUIxaU9CUkpWRmZoRENLaEcxaWJK?=
 =?utf-8?B?akR6WEsxcVNFblFEZ25pSnhIZGRVeTFVVlVrR1ZDN2RIVEJrc2tFYUd0Q2hT?=
 =?utf-8?B?aXpXY3gvY0VCdnNXWHNleGorSmIvWFk0TnRHcFNYRUJ5R2tiWW55L1RJUmFB?=
 =?utf-8?B?UEF3LzlIWHdPOGxybUF4WHFOU3Irc0F6MysrMG5aZDFVZzB2VzZPWnhsZEFz?=
 =?utf-8?B?TzVnaktxU0w3eW9Geit5YUxQOUtyaGFKTWMvbzdBOXJ0QkdBdithbVlTTkNR?=
 =?utf-8?B?dFpEUk5ycENDNkFuajl5VENmNkdhSEloNi83YzY4TkdqVjZnWVpwUndBUENL?=
 =?utf-8?B?a0FhWU5GTnYxeVQ3M0s4UGdhZkEzY0REcnVrNmh6RjVZb1V3VVMyUDJPdzBU?=
 =?utf-8?B?V0RBOHE2Q1I2SnI5bTgxUWVoQncweXh2Rm9DSi91bXZYRHl5dm4wcFBteEdq?=
 =?utf-8?B?SlhQcGJOY3loYlJIbnQwWEsvUGtwSy9CWVFnQkU3UnBzNStvaVZ2aEhvWUZ3?=
 =?utf-8?B?TEh2VEwySlg0QjVpSm11N1RZQTlYYis3NjJsMVRSbFRDaFk2aVB2RHdtMk9u?=
 =?utf-8?B?YndJUGNkWTlyN2tiZXdEZm9EcDk1VTY0a2pTYWUwTzZ3bVEzamQ0bGt0RVlE?=
 =?utf-8?B?UzlrSW52cFcxMG5Idk5wWEZOdGovN1djV3pUa1FtRjErR09XZmtrenNBUlMx?=
 =?utf-8?B?eXViQVFiRWdCS3RjRkwwT3Y4OXQ0NytEK1BOQzVtNnAvTVg3bGNlc0JmYWp6?=
 =?utf-8?B?NlJVR0tUNjBhVXppUVBBdWxsam90cThqMFJwQ05pdW0yWnU3YTZMUlRhcy9E?=
 =?utf-8?B?M0Y0S0NjVFVyQkZoQ21TNVUzdlNLMnZFOUczemcvdGpLdFRvWmNCUHp1M0Jp?=
 =?utf-8?B?SVNXVzNkOW15VEx4aFZRQ05ZenUybnc2YklyOVNaMkhrOWpWVWU3L1p0b2hi?=
 =?utf-8?B?SGFJSUY4M1FUcW5GVXlMWS9DYU9nSDE3di80ditTeDEvNWZ1S3hQRkNNUzIy?=
 =?utf-8?B?MUNKd2g2YWd1NVBwa25USzJCS2Zoa3AzNVNmKzBxRGdzYjFuWUFXcFVsemx4?=
 =?utf-8?B?WFpJTUVVVzc3Vmp3Q000NDlFMkk5d2RWVm1ESEpNbm9Nc1l1cEZwRUVuZG5y?=
 =?utf-8?B?RFBCT1pJWHZBR3k5dC9kbEtTTi9KRGJrWHZYRVNWT013Yy9EckJPZ0VTb0pP?=
 =?utf-8?B?RjEzNGtwMTB0ellpbkNjT2V2WDg5ckZXMnEzT1dQWUljaTBTNFlJQ084cDJS?=
 =?utf-8?B?V045d21rbERIcVhmQW1aZStQZ09VcnFRWEJSN095MkcvNUVWRFdPVll2cUlh?=
 =?utf-8?B?RGt1aWxpWnVIL0lhRE5XTmdXaVgybjVpQktMUjU2YnI2Q0pnL20veDFlcDcr?=
 =?utf-8?B?RFFGbWxlK1JFV3hZRm4xM0RjOFJSc2lBRHdua3UxeXY0TzhKK1NlVjV4UDR3?=
 =?utf-8?B?WkdDQ0pGSlJtY1VkTHcvMGVVOEpGaVBKRDlMWFdNR1pyaWt6SkZPNnB6dHly?=
 =?utf-8?B?M0NQNGxJaTY2SlZJSUY1N2FDVVFpRy9rQkhCMjFvcm9mcytIOU05aHA4Y0ZB?=
 =?utf-8?B?ajJBNzVoNGxxT3A5K0FHbk5CZnovNTVFcUlDN0FsVW11c0JBTU5kVHVNUC9L?=
 =?utf-8?Q?XoSAdJQa14Ee8tSx83N9klNHd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04424579-e834-4d91-e64b-08dd3668c311
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 20:02:53.5155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/VQsXitKiOv/tgEiCQIckP8B+AGGTwwCZbnkXXCfVo7d3Mc22578PjWu+NdGRuLgeJOcUaoa1eSP++W/H8gew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10142

On Thu, Jan 16, 2025 at 01:45:58PM -0600, Bjorn Helgaas wrote:
> On Thu, Jan 16, 2025 at 01:04:16PM -0500, Frank Li wrote:
> > On Thu, Jan 16, 2025 at 09:32:39AM -0600, Bjorn Helgaas wrote:
> > > On Tue, Nov 19, 2024 at 02:44:21PM -0500, Frank Li wrote:
> > > >                    Endpoint
> > > >   ┌───────────────────────────────────────────────┐
> > > >   │                             pcie-ep@5f010000  │
> > > >   │                             ┌────────────────┐│
> > > >   │                             │   Endpoint     ││
> > > >   │                             │   PCIe         ││
> > > >   │                             │   Controller   ││
> > > >   │           bus@5f000000      │                ││
> > > >   │           ┌──────────┐      │                ││
> > > >   │           │          │ Outbound Transfer     ││
> > > >   │┌─────┐    │  Bus     ┼─────►│ ATU  ──────────┬┬─────►
> > > >   ││     │    │  Fabric  │Bus   │                ││PCI Addr
> > > >   ││ CPU ├───►│          │Addr  │                ││0xA000_0000
> > > >   ││     │CPU │          │0x8000_0000            ││
> > > >   │└─────┘Addr└──────────┘      │                ││
> > > >   │       0x7000_0000           └────────────────┘│
> > > >   └───────────────────────────────────────────────┘
> > > >
> > > > Use 'ranges' property in DT to configure the iATU outbound window address.
> > > > The bus fabric generally passes the same address to the PCIe EP controller,
> > > > but some bus fabrics map the address before sending it to the PCIe EP
> > > > controller.
> > > >
> > > > Above diagram, CPU write data to outbound windows address 0x7000_0000, Bus
> > > > fabric map it to 0x8000_0000. ATU should use bus address 0x8000_0000 as
> > > > input address and map to PCI address 0xA000_0000.
> > > >
> > > > Previously, 'cpu_addr_fixup()' was used to handle address conversion. Now,
> > > > the device tree provides this information, preferring a common method.
> > > >
> > > > bus@5f000000 {
> > > > 	compatible = "simple-bus";
> > > > 	ranges = <0x80000000 0x0 0x70000000 0x10000000>;
> > > >
> > > > 	pcie-ep@5f010000 {
> > > > 		reg = <0x80000000 0x10000000>;
> > > > 		reg-names ="addr_space";
> > > > 		...
> > > > 	};
> > > > 	...
> > > > };
> > > >
> > > > 'ranges' in bus@5f000000 descript how address map from CPU address to bus
> > > > address.
> > >
> > > Shouldn't there also be a pcie-ep@5f010000 'ranges' property to
> > > describe the translation for the window from bus addr 0x8000_0000 to
> > > PCI addr 0xA000_0000?
> >
> > Needn't 'ranges' under pcie-ep@5f010000 because history reason. DWC use
> > reg-names "addr_space" descript outbound windows space.
>
> If reg-name "addr_space" is used instead of 'ranges' for some
> historical reason, we should mention that in the commit log so people
> don't assume that this difference is the way it's *supposed* to be
> done.

How about add comments after

reg-names ="addr_space"; // Indicate EP outbound windows space instead use
ranges by histortical reason.

>
> I only see "addr_space" mentioned in
> Documentation/devicetree/bindings/pci/*-ep.yaml, so I assume
> this "addr_space" usage only applies to endpoints?

Yes, "addr_space" usage only applies to endpoints.

>
> > > > Use `of_property_read_reg()` to obtain the bus address and set it to the
> > > > ATU correctly, eliminating the need for vendor-specific cpu_addr_fixup().
> > >
> > > Why is this different from [1], where parent_bus_addr comes from the
> > > 'ranges' property?  Isn't this the same exact kind of address
> > > translation for both RC and EP mode?
> >
> > The method is the same, but space means is difference.
> >
> > RC side:
> >    regs, 1: controller register, 2: config space, (although it should be
> > in ranges)
> >    ranges, (IO range and Memory range).
> >
> > EP side:
> >    regs, 1: controller register, 2: outbound windows space.("addr_space")
> >
> > All regs need call of_property_read_reg() to get untranslated address.
> > ranges:  use "parent_bus_addr" in [1].
>
> I think we should at least use the same name ("parent_bus_addr", not
> "bus_addr_base") and probably also figure out a wrapper or similar way
> to use 'ranges' for future endpoint drivers and fall back to
> "addr_space" for DWC.

Okay for name parent_bus_addr.
Do you need me to respin it? Or you change it by yourself?

Frank

>
> > > [1] https://lore.kernel.org/r/20241119-pci_fixup_addr-v8-1-c4bfa5193288@nxp.com
>
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > > @@ -410,6 +410,7 @@ struct dw_pcie_ep {
> > > >  	struct list_head	func_list;
> > > >  	const struct dw_pcie_ep_ops *ops;
> > > >  	phys_addr_t		phys_base;
> > > > +	u64			bus_addr_base;
> > > >  	size_t			addr_size;
> > > >  	size_t			page_size;
> > > >  	u8			bar_to_atu[PCI_STD_NUM_BARS];

