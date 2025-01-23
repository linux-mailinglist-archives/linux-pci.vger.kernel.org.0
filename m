Return-Path: <linux-pci+bounces-20290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151A0A1A77C
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 17:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D52B7A205C
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 16:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4A935950;
	Thu, 23 Jan 2025 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hqgnS2Lb"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2085.outbound.protection.outlook.com [40.107.105.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561EE35963
	for <linux-pci@vger.kernel.org>; Thu, 23 Jan 2025 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737648058; cv=fail; b=jZDFVWv7ImHtA3RR1ichvFIXjhf3Q3cCNaEHijfzWqRbUDOMGTDpoWqBP763CBCDTHm4feTd9Fzkms0/JIwM345dTEOnBBiPYyHBFLr2CR89BUZT/W55Wp+4fZWM7DHMPU4Iu0OsvwvhAdmWftRT860Nrww9iGtByEvp/GzxwRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737648058; c=relaxed/simple;
	bh=+qJuS9a2cp6adJCBXWFqMFxaKxow9EEw3KFejz/xz1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ahl3ktltqA4ClbB4dsb/xXV7zpFeV/q4LJwjMLCAUaCI6Vw/h3jbUKpJu98CpQlZVpXjMLnGJ6jLDmGabchY7mqKyc/oI5CqaHTU9N/zQg3yr9MZ7wALLXfUV+IqktL3sxSamzyhu7u9q6yPILSTtSscAUsWKSMcQQ6ZFiNwiUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hqgnS2Lb; arc=fail smtp.client-ip=40.107.105.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7cQ2DEccWLCc7ScJ5pi+/Nsc4ovZ8P8VwhCgSpa7+XBAEuoZg9VmXh0VhHO4W3jyJ8ZS4m4L3DlZynnlC0ICS3E4F0aKxLiAUCgX20/+PkXkogzbPftHE6IQxwweyGxBIzoMbN4jZ1E3vPTqBBH9QpWYOzSTlivzoLpiowM4WhrqM6p0itXZZtQCzZmRRTgI2ZTq08Ox01u0EHrjUqphyDotn8CWfmVAVwN35K50VEv+/gAXybTEobdZhWIqFfY43Pd8JcN5+h8ssiU+9IKJPTcyHQEJVwFXRAhtcYhTLGQVfEaRloIbAgpT9aHThJWeVLyScwv7g/VababzaKFgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yC6ZFmqkEg1cFm1vUAPIlWbmz8p0yG+V3/6Yqw6oano=;
 b=ul6sMBKT+mKW5VMVP0scGX9THdVEwfIWXKOOJWN6JL+JViESUw+qNuRFwhPMkJJSyZ6JhsDcPVmvcG1OfZQm4gwun/P1T4CiOXamftylH4eM0+C1SQl7oaAaAeUfHKKAV5q5CK5icQaG78GRuU/A4mU1Q+ln7Ut1Vu/MySmsgPoXk7A314/DntkN4HDQjGTBm8P1QtAWQEwFZG8yIEimeAEOC7EfE16Hh5uf+IHz6l+irlfgKpXtWaKkEL5Y8tdRrogryI7t1VAltszcOfyG511FYIirhkKWgNMb64hYdMsn3k6rx4HG4icVH1L6b6dxgR1ePGmuyWc/LEawcDxVCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yC6ZFmqkEg1cFm1vUAPIlWbmz8p0yG+V3/6Yqw6oano=;
 b=hqgnS2Lbp6ZJ8bMmaoVAen9pNl3SLidAhtCjCVt4OvDGCiFCZPKHNkrAYS13C6XTpYSm+u+qvobq8SDo+uKXR/cA0XW3U+eXvE1Uhno329fN8sjBPNauXoeB6WOelzP+l2FKMa7SygdiBOqOLiYGD3CBWZ0ZgnAAXJmIN1gPP/4+LGEtjYqPunHX3kkYg5tN+fXFJtM7K/DM4t5iJeLEeOpQZxhA3pi8j9DZiYU/FYCY+WtUU6QbA2EHXQOdEW58mM3LPX35BmiH+BhzTmRPvqCH0ILEF/786FmywVdtJ70xg3xXuT7B69iLfRT5xHgJT5gakm5YhREu37NNnY7+lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB8PR04MB7082.eurprd04.prod.outlook.com (2603:10a6:10:129::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 16:00:53 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%7]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 16:00:52 +0000
Date: Thu, 23 Jan 2025 11:00:46 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Fix potential truncation in
 pci_endpoint_test_probe()
Message-ID: <Z5JnrlgZOCe7bcD8@lizhi-Precision-Tower-5810>
References: <20250123103127.3581432-2-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250123103127.3581432-2-cassel@kernel.org>
X-ClientProxiedBy: SJ0PR13CA0220.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::15) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB8PR04MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: 324ccd17-4267-476a-8d2a-08dd3bc71cf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUIwVEplcVNaY2t5Z1VDcUtBeTFRbkJMUDhCMzkxUmJNTE81cmRVOFRqdXRu?=
 =?utf-8?B?WExOby94N25aL2VWMWoxZ0Q4aHk0ekxIa2h0RkZjellxTnJKK2pud1F2cm9R?=
 =?utf-8?B?OHVmR1hCQlQ0ZXJtV29hc1RrNS9HSktPMzhYUjE5MFJmczdiOUlRS1hqNDVS?=
 =?utf-8?B?c0dNTkJlY3QrK3hWM0l0TjhvaWlybUJ2QVJZRzFjZUZBZk1hMmUyN09MSmpI?=
 =?utf-8?B?cXlBeUFrM2NZandiOTBpbTJoU01PNERpSzlUc0lOOFgxdUZxN0ZMQVFYZ1dM?=
 =?utf-8?B?blNBTHUzcUlHUWg1clRRRmhyRXE3Q2FBVmV5bkhaaDcvSmFMbnRkYTJQYnpI?=
 =?utf-8?B?K01xM2tzbklBRTBKVE1WWU1lV0dLV2pIajR1bkV4T0FoeVZ2RVRHQUU5ZTNX?=
 =?utf-8?B?Qi9CN2ZFYi81dWFQa0N4bTZYaFU3SHBTNlRVSmVrVytYM0JPT1lYYW9nZi9i?=
 =?utf-8?B?enovYWZOMDRUTitFV2FYcE5uOS95cE9NVTBFaGlVRTdBalNxa2VpcXJXNm9u?=
 =?utf-8?B?Vy9vR1ZXL01KaTUvWnBYWWlONTdjZUQ3ekVpSWtDQmZpaGVUWjNBazlEdG9G?=
 =?utf-8?B?dE5CM1pEcHFzeGdBRkZZK3ByVzRQNG1kWWlFWFVxTVNkeGp4V0ZqZ3d6eWkv?=
 =?utf-8?B?a3ppMGlaNi9SRkRTNkxleHdLYXhPT2lMdFM4RS94Q0xXb21xSnhybkpWSkkw?=
 =?utf-8?B?dVIvZVBaZFFaK1ZiWlR4QWdZcWF4RnpzY0o4YUtCVWZnUnZDNExGS3RaQ2dD?=
 =?utf-8?B?RExGZFFEdlhTeGxYVkxtbU9BWVhiN25aKzc5NkVmRXQ0cFU5ZjZDODFVZmxV?=
 =?utf-8?B?VUNIOTgzT0V4bmZkcFJYb04rQ05CVE5JSUhhdjJqTWd1U0k3MjBSR0Ntb05J?=
 =?utf-8?B?VTZlMzlpWG85V2tMV0dBLzFXTW11eVNkaGpMbTYwdm54QldrcHl6bHBsM2Zj?=
 =?utf-8?B?QXk2ZzlibHFqbHZGc2tWSlAvdHoxRU1hVTlQOWNNelhoK0ZSR1RwSVJkdElO?=
 =?utf-8?B?VzRFdTV5a1VTRHBoaWpDUTZPSDYySGo5eVRvRzhBNGtkUndMSTF2TWdZdnYw?=
 =?utf-8?B?N3IwRFlURnR0QytyWXN6YTdlOVlBT2xPSkVNSlF0RFZndngwVFlwS1pHWnVW?=
 =?utf-8?B?RXJmK2w0cXlPR0hJeU9mQWcyS2hYbGZmR2JvRnpDTkc1UDJQamtXUHVuRTd1?=
 =?utf-8?B?S0k2UlYrZDZxbHpyelppelRzaTVOM3ZkclJjN2tjY2Z5c2Yyb1Z1WXpiZ0V4?=
 =?utf-8?B?c1ZqVXROdkM0dmpBSzg5dHJtUmhTY1B2dkhWWDdaaXk0NW9uVnFLR1YrQlNT?=
 =?utf-8?B?RWRKbkFOS1lyd3laYU9JL3FGQWZiM3VmckVUZnFTZC9XdzVzekdaMXYwTExL?=
 =?utf-8?B?WW5LZFZ6RGxQMlRwUVhCbXB4SlQ4SHpvYnFxWVc4UmNDK0k3L3hWR3JtVkNI?=
 =?utf-8?B?RThNNTFXNXpRUEpWSTh4ZG81UzV5cHF5M2N6Y0EzYS9aMnZXQmNYb3MveC9Z?=
 =?utf-8?B?alJiTGtIUThrWlU5MHhqQmJpR3B6Wm9DMFBXUHBxZDNKRmhidkdjTG1oUEZy?=
 =?utf-8?B?eElCeVlDdk1iUFAzS1BoeVBSWGhBRG9UL2JkREFoSHBGM2N5RHNDNmdPeWEw?=
 =?utf-8?B?ZzhQeWZHbC9iMXJWTXBOVEtsais1MnpNS3k1VUxOeURkOEV3QXU1d1FMTkJh?=
 =?utf-8?B?RGJuTDlwY1BJdkEwWE16WnVFQVdCSkVPZEV6RVhxSEpzSytvT1R2NVJwSzVB?=
 =?utf-8?B?dEZ6ZTRHUGJ6UXAxYVdsWDlNU00xUFpVM1JvcnlIanBGQ255TmZKTldJNkFC?=
 =?utf-8?B?Q3RwVzlneHF3VVUzb2xLV2FXb09nMmVKMWZWUmFoY09oUnEvYlpPakFUanNx?=
 =?utf-8?B?VXRlWC92N2RDNEFKRkx5TlV3ZTBBTXcrYzg2WFJwN09PZTRST05RUVFqKzNq?=
 =?utf-8?Q?B3D4p0gKPsFerQKlkXNjlzBeCbOZA3Df?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1JTQVFHSEk0enhnMnU5Uy80bWZCTXBweE5WS1BVd3pheE9tcjRtVTN1OVh3?=
 =?utf-8?B?U1RVLzJ1RW1wdlJIRDhOK09EVytBT1JTRkxKaDIweTFTVCs2dG9OaUxlT2k4?=
 =?utf-8?B?V0p1L0lWMGZGR2x1c3ZHYmlqdkR6MWdwRmlVMnIxaHpuRjBONVFFY2s5NCs0?=
 =?utf-8?B?TXhYNWZKWnRKS041ZGFWSHFMYzE2Q2NoRnBZYjN5VG5ORnRjTEV1UmUxTmk5?=
 =?utf-8?B?ejRINDkwS0UxYjRXM0FGWlNsdEI0Y0t3aWRRckl6bVB5TFVNNGhVR0xIYU0w?=
 =?utf-8?B?NG9YazcvMGlGMTRUSXRySk5nZENTRkthOFA3YTd4QmZHWWkwb255bTR5aEVS?=
 =?utf-8?B?c1IwWUlMeERzWTRPUkRwWnlwZFl6M2JORXJWVjZhYmZWeWhQOFZMZWdjRlZS?=
 =?utf-8?B?YUJGejgzR1ZZT1JyZUxnRFlKSU5sUXU3Z0c4UnlLRW5BanB0QzIxYUtnVWYy?=
 =?utf-8?B?aHdueWlZZTF3bFR2eWthR1RRK1NEK2c0OUw4cEZYNy9SRndJRzJTUGdicjVG?=
 =?utf-8?B?Z2RTNmUwR21SR1NEZzlMdW1hM1ZCVnRvK1NZWWdXRjIraDVtUktJbEh6MWhz?=
 =?utf-8?B?aGM1UWoralZkUjAwa0JVQUJRMVFFM0ltVng0bHFxN1NMSFh0V2JDN3lSMHdn?=
 =?utf-8?B?ejJpa2YyQ0lRU2gvWDNzc2Y3SmF0V1VGVVA0eXdBZEFuM0FXdTZqd0tXTGdI?=
 =?utf-8?B?dlYzVFM1YXl5RVFFSnR4TWhMajZaeHZ2Ry9MMzAveTZmWjBIRFJNUWt5REdm?=
 =?utf-8?B?UmgxZ2xiTjBFeTh4WEFhdjZqSFlRL0FZZFB5R2NaZ21BU3FMQ2hiSUFESy9p?=
 =?utf-8?B?eW1xenB2QXY3ajNDOFp5L3hScWpzSThEU3llYnRkbGxucEpJMEJ4dmhqUTIx?=
 =?utf-8?B?anhIMGYrTnhqb2g4aHY3SGJLNDVlaXE0K1loWU5wRGdTUnlvcGdyTG8xVFR1?=
 =?utf-8?B?UjN0VFlSVnRPL1ArTmM5RTZhT0Y4dHF2WWZoQVVQTEp3VjYrYnplaWFzcFIx?=
 =?utf-8?B?OFU1ZHJkWmhlNmpZdTM5L1F2c1JuUG5HYTRIeFRGdFNqeTV3M3ZmTWg2UFlM?=
 =?utf-8?B?bmlqUU03bG5QTkVJWVg1ajVmQmlTTVJQMHNJNzVYWngrRVpiVS82NnNWaC9I?=
 =?utf-8?B?eFdHWU00ekRhTTlKa1FSL1V6OWtxbHZHYnd5bnNuOU5KOTMrNllqeHppK1h3?=
 =?utf-8?B?RVFmeDZGdlJhenNjU0ZzYTB3d0F5L05QSHNMNE1xTkg4eTgySUd2dGdFc1A1?=
 =?utf-8?B?ajhzcDBmcFVHdi9aRXgzN2ZOMFlkMmVxWUZiZHRrQTBaY2UyTGkwVU5BeGVH?=
 =?utf-8?B?ZmpPNFB0eHdpK25YTUVvQVVORXArMXZPMjlTbCtKcDFuWVdPMktBUVpZZjls?=
 =?utf-8?B?ODdzZDNWa1Byc09BRjEwSmNZSHdSb1BVTDNrSTZIY3AyRnZlNER5SWdxT1N4?=
 =?utf-8?B?a1RYR2hDMXhidWVoTkpNS3dZdXVQall6OTZjUmZZS2U3bmpyNFJsamsxOS9a?=
 =?utf-8?B?OEpGQndjUExGUFpTL3R4bTVreTU4VU42SWhxSitlR0J6K0FCd2RPMGNtMVI5?=
 =?utf-8?B?aFhqZjF0SnVkVmJ5SFVyc3VkTU4rdytPNGRFcmNkRldmWDJtSFJjQXVCaGVs?=
 =?utf-8?B?UnN4TDJKNFY3MTZiV0ZRcUl5bmNFZDg5bnlGQUtLN05tZ2NoS1QySDdZYy9m?=
 =?utf-8?B?ZWtINE5UUTd1Tlp4L3JQZmVnd1JKWnhTbjZCQndmRVdnWmFJcE1KZEd5SGh3?=
 =?utf-8?B?cExFVnZLT3hYeUk2U1Z0dnl4b3ZHcEJLREVFclhyUzJwZzJyOXpCYUowTTlM?=
 =?utf-8?B?UmxocU5pdkw2anJ6NjhaR1RjQzJ3MzZFYXJWU1JRT2JYRmRDR0g4eXBuYU9m?=
 =?utf-8?B?SHJOWFoyeGxGWXVNOEs3Z2dEVkJWZ1BzeG1lWTgwT0hKU2N0ditNTTFaMnBs?=
 =?utf-8?B?QVEvR2pZSjBTUnY3L3JyUEpGOWswL0dLRWRTeDdCaS83QzVYNWY0TDF1NGRB?=
 =?utf-8?B?NWNBYmhEdjJDd2tLUitGVnlNV3JxcmhpYUZIV0ZXTXdGRDhkUWRXSG9DdDVi?=
 =?utf-8?B?MEVYVmhaRUpEVjM4MUFpZ3ZuRXpCbTFvVTIwaWxPdnVJTE9vOXFnRGtFa3Zw?=
 =?utf-8?Q?hePd8KDU0Mlecm7HETUya43y0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324ccd17-4267-476a-8d2a-08dd3bc71cf2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 16:00:52.8389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OyRHs11xD8i2GsxdBtVe52QS2B0zrG+EMAsQ+RDhlnnEo2R5ByuwTfF9niL+nFaPwQDrz9v2rh5xZZJtOQyEQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7082

On Thu, Jan 23, 2025 at 11:31:28AM +0100, Niklas Cassel wrote:
> Increase the size of the string buffer to avoid potential truncation in
> pci_endpoint_test_probe().
>
> This fixes the following build warning when compiling with W=1:
>
> drivers/misc/pci_endpoint_test.c:29:49: note: directive argument in the range [0, 2147483647]
>    29 | #define DRV_MODULE_NAME                         "pci-endpoint-test"
>       |                                                 ^~~~~~~~~~~~~~~~~~~
> drivers/misc/pci_endpoint_test.c:998:38: note: in expansion of macro ‘DRV_MODULE_NAME’
>   998 |         snprintf(name, sizeof(name), DRV_MODULE_NAME ".%d", id);
>       |                                      ^~~~~~~~~~~~~~~
> drivers/misc/pci_endpoint_test.c:998:9: note: ‘snprintf’ output between 20 and 29 bytes into a destination of size 24
>   998 |         snprintf(name, sizeof(name), DRV_MODULE_NAME ".%d", id);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/misc/pci_endpoint_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 8e48a15100f1..b0db94161d31 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -912,7 +912,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  {
>  	int ret;
>  	int id;
> -	char name[24];
> +	char name[29];
>  	enum pci_barno bar;
>  	void __iomem *base;
>  	struct device *dev = &pdev->dev;
> --
> 2.48.1
>

