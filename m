Return-Path: <linux-pci+bounces-19452-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A17A048C8
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 19:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1591658CC
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 17:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EDB1F37BC;
	Tue,  7 Jan 2025 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OuIm1Yd8"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933E91D95B3;
	Tue,  7 Jan 2025 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736272774; cv=fail; b=sClkAYgTeE619SSIpMudCpJu4VewQ8dSUjeZdHpUZAzx/QJMxV49ceKRSIVVXeNNErpaUdRSRoYyhbg31ZfvsddYXwt52qlEMG0Jhnb9fVgWyqnX2M4fnrLY/f03Qb5ud4l9jXakVuKwCXOcY2Drd2j9XULnCeXC7HRwPo7VUok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736272774; c=relaxed/simple;
	bh=yJvPAp0nj6ValS+t8xO0Gr+lNQK3JTUQg8hHfXE3Fhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KrIsiAo/E9Ziog9GZ3KlMuf3Ln0pwO5ydrQZbkuONrc/o2TjVPQAjspZztrSUmfKRNufu8j4T1B6CizpDy9JLmJAn5FPn9u7XsSlSWnsh/20D7A3YeyTPoxcYNiudjkLxJb9LBTcTl3wUBVxIEap75k23dVkskS/JAbYUQlsOZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OuIm1Yd8; arc=fail smtp.client-ip=40.107.20.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWkUVBObr9IsuECEV0LgMo9hWL39L/jnxAFKhUnUi0xap9hUwlUbl2oOI3zdylxSnNLCihAbfI1IWYw7SxwJ6V82IM5Bn7LHwn+j9q/Lyz0YDAEgNYJyawtBXjNrq6dRr6HVRWp+Xzc5YALQSs6Bl/MIFGMiOIF9TKVQU1LeZi62C+ww63BA3jaS1JjqtkqS0B+2zZWFTeY7DyKKhcDCHLtBsHh8jbhPKDwBkHiIrINjg5Sp2WHwIewoy70Swi7Q/4OIZezkAQdJ6Pg1p+nOkMC+Lv0Nrrv9wUhF1nkNp4iB357WbhyM8NC2mAKDT8/0iqeSOuG7ZmLvajxDypGSVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uBIEK5L1nrGd3bkTQ35SUj1K0efw/pOHEj/oNPwzqw=;
 b=fkii4BHmwcv4Vav87pdJXRp+4M3SqCIKI/ZmMcdv8DacPMx2CYWP/IBLm5QUHdNVvoHyVZlZkGugn0C9PICB0lvRieApGqEOJez9X+3jrTseqUXXp3wKj/p7A0ijXTInf5I4mlrHC4TG+Mz+vT270l+nB6ObsmlFBKcwvY7h9wGOCLounV3qTNhmhEPpIOVgRu420q4VFseO5RV58NtmFGkXXo505cN+HtJ9S0KVqIarF2aatXuomJBUivPgrXvCrDeFlDnxjZgnCizJu4oiOgGsIpEyPmCSzESfhq8CoEbiZGhL/WWWCSdk/dHliELhXf9lMPuDaTcwHDOv5w5Krg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uBIEK5L1nrGd3bkTQ35SUj1K0efw/pOHEj/oNPwzqw=;
 b=OuIm1Yd8HmR6NhhNbK8X2p3BsLaRfs69RHt+ty8bKQ/2OC2KAh7MXBzD9h/epN92HNZVsBR7QVllol6o4aGv2vHxj3tDW3dltPxE7dUjsqcJQyCtwKddDih6wUQu4sW4Tyg+a4hBICkjqVIFXSDC8mHSk8gXT/Ovc1ND+JaC8IRgq3NHxLe0FvpQ5LaRXHBm9zhuurIP8c1CbSAJMfsMuhrPEBVXNiXOJBB5TXgmQrpE9OxfNn7PdsIUEUb/jHAIury179qG0x8sacDZ+gOqaBG1FYZZbauiLgAI+SVYqFexQg0e3N471vuc6dWEzvt+pr8anPnGYeqRt9cL9oLdOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9266.eurprd04.prod.outlook.com (2603:10a6:20b:4e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 17:59:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8335.010; Tue, 7 Jan 2025
 17:59:29 +0000
Date: Tue, 7 Jan 2025 12:59:23 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	bhelgaas@google.com
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v8 0/7] PCI: dwc: opitimaze RC Host/EP pci_fixup_addr()
Message-ID: <Z31re0F1+MVv0VGN@lizhi-Precision-Tower-5810>
References: <20241119-pci_fixup_addr-v8-0-c4bfa5193288@nxp.com>
 <20241124143839.hg2yj462h22rftqa@thinkpad>
 <Z1i9uEGvsVACsF2r@lizhi-Precision-Tower-5810>
 <Z2R6HET6FZEO+uwi@lizhi-Precision-Tower-5810>
 <Z3wPX1F4VrQZhICG@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z3wPX1F4VrQZhICG@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SA9P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9266:EE_
X-MS-Office365-Filtering-Correlation-Id: 05d711a6-7c06-4540-79f4-08dd2f450876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzIzdks4UVROTGlkZzhKSTVEZHBFZjFkUnZwNEc0QUFkeWZHOTBjaHJRS2kv?=
 =?utf-8?B?eGxVaDExTXFRVTNOd281RGhnZTB0Y1hpUzN5eFZwNFEwM1RDOGVoVnhxTFpV?=
 =?utf-8?B?NHpnTlRmOGVqZFBMdFB5UDlqL1VDYzYzWkNFazRrOEVQUjMyb2RCT05qVG9U?=
 =?utf-8?B?MXhBTUxQM3RlRmN6clowb01lSnp2VC9tVjFRaUxWV1ptNUNvZ1dKVk1SajVW?=
 =?utf-8?B?SkNYOFdFZTltbU9HQ0dOTGkzQnBBR3RLdEVCSFVabjgyeWx4ZzRQajl4b2tn?=
 =?utf-8?B?emVPTDZ0UHY2OGdHQVN3SzRiRW9HOGNNcXFyekFYNG1jQVc3WFgyTzNtOGRN?=
 =?utf-8?B?MVFDdXYwMFhONWM3Z1BmUzZEMFJMK2ZnbmE1WUYxN2dwTnBKRGVxK1kza24r?=
 =?utf-8?B?UGFVcFdHUmM3Vnp0U2ZpWFJQSWMvN1VhblRwYUsvZ1VZejZQalEzazNEeFJm?=
 =?utf-8?B?M3UrRE9MVWRzT1BKdmRLSFhOVVFpd2pOYW93QlJMVXlDWjdNVmwxWFZnZ0Vo?=
 =?utf-8?B?cEV5SjluSjdWbUwreTFkMnFHVWNyV0xBZ0QzQmkrcHJtY2dUV1lvb1Z5SVpJ?=
 =?utf-8?B?MmxRVWgxMUVtNmlXeFFYTXJlRUVodEFzUzRIN2UyUllZZVc5R2pyajAzNU00?=
 =?utf-8?B?cUkzU3hIa1c1Q2xKU1FTamNDZGJoZ1JKZWZDcTVVd3ViajNVMkZrMXlQTGlx?=
 =?utf-8?B?V2xEendReGNTSEYra1VKWll3SzREdkJuT0RKVHEzc0JoU2RIS0xIOVFaa2l4?=
 =?utf-8?B?QTdEQ01pV0RmVkRNbGRKWVdoRWVrdW9ZUGtpTVV2OVV0eFBheldOMkFKRWl2?=
 =?utf-8?B?VkJiM1BoZXdZbTlZUTliNTJzdC80VmozL3IwcnpDanlYUlN5N0VidkJDK3lr?=
 =?utf-8?B?RkFtVnJlRUlESlIxM05JRzQ2dG5kTkp1VGhOSk1sanhjY2ZoN0VwbUQrNmpn?=
 =?utf-8?B?Z2Y2WnVtT3B5VjlRelU5Z2tPNTM0MVNyQ21PV1VobmpVV2hCRjM0VGhZbHRL?=
 =?utf-8?B?TGo0TEdkM1gxVk16TmNJM2NBVDhYYlVwSmJEZjZwZUsvMHh4Vng2MjBuSHp6?=
 =?utf-8?B?a21jdDdVZ3dpdXJ3TEdpVnIwNWRGQkhLVEpyMmlEOTlUWmFCaE41eWYzR0NS?=
 =?utf-8?B?eERzcm8wVWpTTmFDSzFLenRSSGJDVmdxaE5VQU8zbTBDREdRUW5pRXpKSHBr?=
 =?utf-8?B?Nmp3WnRxS0ZjbHhOOTFRSmdTMzdMSzhRRVBWc3lRa2F1ZjI0ZnMrZWJUWWlx?=
 =?utf-8?B?eTF5dWRrUlMwKzRRRXNROXhodmwvTHRjTk96dEJBS2w3d0dCcDhQbUl1Ni8y?=
 =?utf-8?B?czlrNFdSQ0lqQmYyVWhQcWNjYXl4WWp0R0QwRi96OUxwN1lpcHRTUFJvL3VX?=
 =?utf-8?B?TXM1OG8yWWQycVBWUkZkVTJTZXdVZnNYdFJGMUVxbUw5dG5LTTIyRXdTYVZj?=
 =?utf-8?B?VS9MaGxoRUJ3TndUL2h1Z0ZLWGIrRzM4cW44bmxzaEFZQ0NITWgrYzE3UGwz?=
 =?utf-8?B?RGQreE1KNWJEaXJTMUlOZTdGYjNCcXJaL3NUOFYrbGlybVp2VVJYUUc3ai9p?=
 =?utf-8?B?YjI3Q2dzUzlwb01XayttMXpncTN1K2xXQ0IwSjdrQ3hzYzZxM09RS1JrTU10?=
 =?utf-8?B?eng2S2JtNktnRmNZNUVGSVpGU0FlOGpjMkQxaDNrcTdqOU9vMldLWnFJR0th?=
 =?utf-8?B?ZnFyTlAzaWxMclZ0ekpWcDFtdU1OcUVXb21mRHRwN1ZCOEdoQnp5VTRMTHNO?=
 =?utf-8?B?VGtPRE4waXhINElsdURiU054SGR2MjdmYjE5VUNpSG9naHpvL3ZnL2FUYXBk?=
 =?utf-8?B?L0dQNUdXT1pJMmtHQ093ZkNPamhmWHM5dkx0a2dLVnkzMDZVV3NKQ01CWGdE?=
 =?utf-8?B?OHR4S255cy9GTElIRStDMjVhV0lNT1A0bjZyQTdXbDZaZHdtcThEU012cFJL?=
 =?utf-8?Q?Ytc6FkgCF6v+mNqqcagNSA86MfrvPfn/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFc1TU9pZG1YaVBBK2RpNWNOZndQcmx0WWtNUjZIL3RiajZDbDU1WnNTQ3Zz?=
 =?utf-8?B?UTBoQVpLWVlGSk5FTGwrb2RsVFVPWGRObldxQjAzNDhHTVdsUEk0Q1IxblFH?=
 =?utf-8?B?Q0IxU3UzMzFBL1diNThkbUN3T2EvbHJ3TmVYQ0g0cWV5ZHRQN0xhbWFocXFX?=
 =?utf-8?B?SUJselZHcjdsbmdvdFNza1U2Szl4UHFyVlNtYlp6eG5BWWhDVkMrK2g3aFYv?=
 =?utf-8?B?MkRkTXcrS0VBY1VsaHBkYkt6cmRpMTNUOW1rQVlLdUdSb090M0dTTnRUTGJZ?=
 =?utf-8?B?T1k3TjRFTFhyY3hKRlRhTWdnVjJHRkkzMEd4K0dqNWJRRzk5cW9CRUZTQ0xX?=
 =?utf-8?B?N0hlN1UrQ1ErdUp2bEFLMmFldzlwdzNUa1VGdmFLVFFqZmcvYllVVDZVdCtt?=
 =?utf-8?B?ZXpGTit5K1VIeGltMTBSbmNkajFSeENubGJBVjVBeEh1a0JuOVlFUkhCbzB1?=
 =?utf-8?B?cjVKamorWmxJaVhiQVh4d1A2YXBKRExsVmZob0xkUWJhM1hQK2wzZlBRTERI?=
 =?utf-8?B?VWhYdGtrUmpBNkZSNUkvMHFLSlNDdkJ4VURlT096amZMN0I5UTFtd1lhSmRk?=
 =?utf-8?B?TmxTcWdtNjhtc1MzYjhxalNUajRRaFZleEpMcXJBZm1haEFyWWRKMFd1RE9i?=
 =?utf-8?B?THR6R1lOS01VNy9vS0d2Z1BvTHJCMnQ1OFVweXlsVlI2R3VnOW9KTU1Id2dj?=
 =?utf-8?B?Q2hINnV5VHRIVytmMVM1UnExcjkrWVZ0REdCNzl5Y3RjTmltTGQwSmt5TVdq?=
 =?utf-8?B?OGU3MzZmZytEK2dHbC9seFM4ZjVuNjdweFk5bkVjckNFaXVCNEd2WDcvOHBP?=
 =?utf-8?B?c0hSYXhsSmhlVlUrbUx4MGRKOE12aUp6bVV3Yi9zc3E0VWsxNU0wRERXaHFB?=
 =?utf-8?B?cCtISzBMYUl0UEdyZXNPWTRXU05LbXJBRGkyU0tvRnE2NlROYnljZjR1SVZH?=
 =?utf-8?B?alZlaktoUWYzOXo0dUVkd1RyS1IyYWpJeVNoemo5N0xEVHA0cVU4cHd3WURS?=
 =?utf-8?B?VUdXOElyTzFvQjg3dkdhenVSWnBlWk1sZnRYWjZYZWE1OG1DVGZSK1VreTZE?=
 =?utf-8?B?QitGbGJHQnQyUXhveit3RFNkb3AvTmUyT2tRS1BVaGhpaDRicURGNDRuS1py?=
 =?utf-8?B?VkIwd1paQlFhUUw0c2FFWVpMOS9jbjlKbHFlSjVtTkJPN0IraU0xZytyQUZu?=
 =?utf-8?B?VitiMTI3L2xDdVg0SzVubmNvanRzdENkWFZyT2tndVhpRGhBckdZTjB3WUFw?=
 =?utf-8?B?UHVqVWhrblg5cEw2UEJWaytaUHBrbzVlQ1p3MlM2VXdyd2NZTW90MDdnOTFI?=
 =?utf-8?B?VkovbGhKL1JjWGRmc0t0czE2cER1a2l1aG1hU2hSOExGc29CaVNGZGxoaUNI?=
 =?utf-8?B?V0FiNTE3bFU2L1U3TXlYWXV5OEtPcGY3UkRKK2ZzTTZMUFFmTk9rRXlwUkhU?=
 =?utf-8?B?eFp0K3UvVFdXVnFSNGhXWFN4S3E4VjREcWxQUFRGMHYyRDhHVmFTb3JkWjJS?=
 =?utf-8?B?TURNT3puR0loTnBNTWV1VmRKWS9mRlBjallmWnBtRExVc21NMHZwNWg3cit6?=
 =?utf-8?B?S0NUejRidllvVTBqNUVBNGtuTE1LaE9IeDRUV05ZYmxWZHJwT1JRMitrMytW?=
 =?utf-8?B?RitzRW5aaGVPUCtyTGQ0eUpQejUyNkZNOWFFR1VaTTBhWWpjZmZQNUlONDgr?=
 =?utf-8?B?UkVPeHY5RlFVSnNYam1wUDhFbk0wS2wxWk9rOXV4Wi83eXM5TjY3Z3lvVTlP?=
 =?utf-8?B?Y2VWT1BCRC8vRi9BU2pBL05nb1pOajMraTNFcWU3YWtGcXZDY1NyNGV1bFdW?=
 =?utf-8?B?T3BqTWs3clFSZU5FZXRTK0JOUXd2L2hBSnpFbFo2VnMxYlR1NEZFVUFheUwv?=
 =?utf-8?B?bkpCbkpISGNTSTk1RmpOU01XYkFKdzgvazcyY1A2cmtxM2VwUE1HL1gzUEpJ?=
 =?utf-8?B?WGJSZENJN1ZGNHRxZ0FYQlV1bUw1bTIzY3NJVVV6NlI5RFlkVWc3bkFrK3cr?=
 =?utf-8?B?WGdFTll5OGNNMDlwWUhyd3c4aldRV1phYmVVMEhMUCsxUXJLWFBFMXE1ZUlZ?=
 =?utf-8?B?a25JM2p2bnE4TmZpQS9CbEhuQ0tCb2IzVWVYMVpwT1ZRNGh1K1RVRTZQRVVv?=
 =?utf-8?Q?4MMDmwJEvD8pH+k/SDK8L4j9V?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d711a6-7c06-4540-79f4-08dd2f450876
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 17:59:29.8927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajfFaRJK+O+WnBSdb0xHesJ+ja3mQ3JYZsbM0T2un2vslK2z7m2V5n/o9/L7tBWfmGVTO029ngZAb3TKHFZaig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9266

On Mon, Jan 06, 2025 at 12:14:07PM -0500, Frank Li wrote:
> On Thu, Dec 19, 2024 at 02:55:08PM -0500, Frank Li wrote:
> > On Tue, Dec 10, 2024 at 05:16:24PM -0500, Frank Li wrote:
> > > On Sun, Nov 24, 2024 at 08:08:39PM +0530, Manivannan Sadhasivam wrote:
> > > > On Tue, Nov 19, 2024 at 02:44:18PM -0500, Frank Li wrote:
> > [...]
> > > > > Previously, `cpu_addr_fixup()` was used to handle address conversion. Now,
> > > > > the device tree provides this information.
> > > > >
> > > > > The both pave the road to eliminate ugle cpu_fixup_addr() callback function.
> > > > >
> > > >
> > > > Series looks good to me. Thanks a lot for your persistence! But it missed 6.13
> > > > cycle. So let's get it merged early once 6.13-rc1 is out.
> > >
> > > Krzysztof Wilczyński:
> > >
> > > 	Could you please pick these? all reviewed by mani? It pave the
> > > road to clean up ugle cpu_fixup_addr().
> >
> > Krzysztof Wilczyński and Bjorn Helgaas
> >
> > 	Any update for this? All already reviewed by mani.
>
> Krzysztof Wilczyński and Bjorn Helgaas:
>
> 	Happy new year!, could you please take care this patches?

Sorry, missed put bhelgaas@google.com in "TO" list.

Frank

>
> Frank
>
> >
> > Frank
> >
> > >
> > > Frank
> > >
> > > >
> > > > - Mani
> > > >
> > [...]
> > > >
> > > > --
> > > > மணிவண்ணன் சதாசிவம்

