Return-Path: <linux-pci+bounces-32209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB5DB06C0C
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 05:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492031AA10B9
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 03:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BBF7261D;
	Wed, 16 Jul 2025 03:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SPLc5yWB"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33A911CA9;
	Wed, 16 Jul 2025 03:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752635931; cv=fail; b=KoSW5u3Is3U7WzsMU3qYlTCtGV2P82HEiekMJkhHZOrS3bEZEa8LcbUmdo4bXG8xFw2PIZhAtI+M7e5Epo+bZVK+nXdC2HoV8j6G7qPx7wu3M0p7nJS1bbcNCpDendQ6dcNqMWy8Fh1iu9PJ6Sk/Mh/9Pevlo3gUEHEMWkQvmeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752635931; c=relaxed/simple;
	bh=h00CCWaTpshNAN8ma5Imcc6AhavIQcOY8vBLxzhpBdg=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=aS+QblAOEcSJ+w6rdt+hyIN7sCJUgnKxQ+M4kLMX7LPEtv3V93zgDyANiy8ltZL4rJpJ3T5Tnk510DbyzKGrkDKJy6/+7cZzxiN1zQJmsl3ZHiNbvTD8oLtbR31uL2H1NSo9xf9QOy0Wo8ZVYVz1MDMSPKl9CjCxZpN1OqXgmz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SPLc5yWB; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXJKAFM8GllABV0LogkCWalhOzysq5clIU9YXWC+yFL4aRC403pvA+Py0zGtPmf6Hbs81qPEFi4Df9XlnwOEwhdgS5pGomvL6yjw6pwlxrzAqDf8TqpkWvB4nGchNdjfm1l09BaMZDGlyU13kNxSqRJHWlhjsuT94MEb5+rdqHJR1cH6oupe3IZkRB+SbChHsPwoTWoHJTgz0SnvDJeRfNSGcOd4B/YgmknpKL34hn5PVD4zHgQQeJNsky9Z/D08Vmrndw0S+ph8FEEGiy/U2BxQ3/bhSvgQm8JtOLBW2TCiq4txsLiUsM7yPqQ+6qwLmL2e0jIggn5cIVmqP5E7PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxYUAbJ7Im8XhiJsY5B42gywgWrO1nEz42F4AjWac7g=;
 b=vnmVw6bOfFEjugyc1qXuCgtrpzBIPV+hBJqvfQNu5kvBZVtz41aX0iIwSHx9E/DpccIhLWPdCARTPTqlzI2tB+eQQVc1MBVUdUwmbEdX6DUIWgJp1GR2LUu4hfCxvWSNrnWnGMJBaiM82LDQVQN53FW6A5anln2dyhqADZ1xJjXElYPJowGhCftfI/y7CBd8gkdFhYXYBIWdSwKkvZt7rKKFyEqEhXaUP1wjyBEQFn79CtE+WrUP1r07tx8id4v3VdIp08ZnMgvBRyp4vpACm8k3UD/12TN7Mm0TOdpCAEN0nCpBxnb+HY29CccR/zACNgLQCRXDijFsNKgt0L4FfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxYUAbJ7Im8XhiJsY5B42gywgWrO1nEz42F4AjWac7g=;
 b=SPLc5yWBStre79HgCN+Df3WAT0is+bvl9VqskQzzjxY2sSjSCi5gRz0Rj6+fUhJrFTiZt9oz7pQd9DW7oPk+U8NSlaDya1ZNHAcnJe8ZBDBVyaE0hqv+nk6mwuGdU5CEKUNfC7pT4pSPGoPqfGErFwYC5bZxj1d7jny32Q0Hltb5qCeRb3uHkhOfmXwCJ4dk26S0H1ucoKq64oSwB1QQLNWueCghMxXgZZDVj66bKwqpkHRlORxneHj8CigX4eLIymkNeZVfuyR86YrBR0D3nVIiZkwCzABZIeHoHIarYP+Mq1bZJ/eBxThrTTket8tU42u2XTpAMwVLIdFYYYAgQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB6638.namprd12.prod.outlook.com (2603:10b6:8:b5::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.28; Wed, 16 Jul 2025 03:18:42 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8901.021; Wed, 16 Jul 2025
 03:18:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Jul 2025 12:18:38 +0900
Message-Id: <DBD5KXIOSD22.L4RPVLDQ7WDQ@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] rust: dma: add DMA addressing capabilities
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <a.hindborg@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <gregkh@linuxfoundation.org>, <rafael@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250710194556.62605-1-dakr@kernel.org>
 <20250710194556.62605-3-dakr@kernel.org>
In-Reply-To: <20250710194556.62605-3-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0040.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB6638:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a40179a-0298-49f2-0e28-08ddc41776c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amxJOUlQV25UeEp5M2h2Sm04UExpUCtpT2dvdUZPS25OVnpwRFZ3QjVadkw1?=
 =?utf-8?B?OUhEWTRad3hYRGYvc1JxRHFQZ1BVTGJKRGtQTDA0aXVLalFiNkp3T3lOVVZH?=
 =?utf-8?B?TXZYZi9ubDRmRnJxOTJZYzlXaXV0WlNJUFlrWjhnbE5WdG9rWXdWVXhWcm1R?=
 =?utf-8?B?eVlRNU4rYXBLYTJnRUYzTGdMTGVwbi96cnN4TUdSakNQSnQvYllrdkE2UkY0?=
 =?utf-8?B?ak5KVjRFOVVmbUh1TmltL0pyTmhmajZ1cUNHNDdWN3ZXREtLU3FxQUNrNi9L?=
 =?utf-8?B?aEV4RXQ4YVVtUDgrRHArS2JxU2V4V24ya0tLakxMTWE4VDZyeW1EdDI3RVEw?=
 =?utf-8?B?WmY2ampjZE9Wc2JKYk5ieUNyMGxILzArTWwxRXBIenJXQWl3RmNNWjhlaUFL?=
 =?utf-8?B?Z3prYW92cm9zQllzeGNudGFHSFQzME1Wclp6S0JtOWk0bGRjdVgyK3dEOTh1?=
 =?utf-8?B?dDBzNlZUcEhvVTBFYWhJcVFVWXMzN3N2NWt0K0NOU3NSdzVGeUxBczJ3MmRM?=
 =?utf-8?B?VFlEMGNPU2lNWmpKUEtzeVEvZE5FdmJYVDJ1ZGxBNDZ6a1dCczF5UDh0cnVo?=
 =?utf-8?B?eTVuK0E0UGgvN1NqZWdJWFlxUXBiZTNpdGhYTThjSmZRM2hTOXhWVFlrbFJR?=
 =?utf-8?B?VEl3QVBUNHBvM2R6WDMrSDJheHRZT1RkQUowbnRwWHpQcHA5TDV5Lzk2VkVT?=
 =?utf-8?B?cHFNb3BKSDhwcFVlMHRyRm5xSjExdzBOV1FKRFFRSkduc3dzeHNDdzdDL2dR?=
 =?utf-8?B?T0FXVTFsTTVkejZrZ2ppcm51alE2VmNSeHJ1T3haTDZpUDdZMWU0ZVZVbE1S?=
 =?utf-8?B?SG5NVG42VHhjdkJjZlVVcWpNNGp1MGtqdzNLSnZXRUU0YkRCQUxHbkxJZmRV?=
 =?utf-8?B?Ym5heEpIWGZ3OUNqZWxVaVBYelN4TEVXM2pVUThUTnBTRHdIZ28rS2JLd3Rj?=
 =?utf-8?B?eTF0RUxJZis4dlBUdlp2SWNjL09yVTFzSTV6WTIyMFptSVJ3RjBrTkJMWDFX?=
 =?utf-8?B?aVpGaGF3UkZmVVhhdnRycmFJbUEyTUtQaGpPQnR6RGlEQU5kNi9mRWJjZEdV?=
 =?utf-8?B?WWcvNWovNHlTcG1GdVFKaGw3MTNYN0hoZ2drcGRRK0l6TXNSakY5UFVDcmF4?=
 =?utf-8?B?dWRpSU42THdJL0h5TjFmWnU3cWU5ektSMWZ3ZElhOG1GSVF3b1hwNHRFVzB3?=
 =?utf-8?B?WHlNMXhBVEdCVE1DMi9tT3l1MGxsc1VmRnpEQVFzWlRDWUpJL0gwVnBRUnp4?=
 =?utf-8?B?RWp2eUFvS3hZOVJsa0w2cjQrVHExaUlBQkl2azVtcCtGMHZIRTRySTJDbkFk?=
 =?utf-8?B?dDNmdW43WC9FR3plbFVpS2RJeTRLdkQzUW5SSUtoT1pIck10OU02alRhUElp?=
 =?utf-8?B?SVF1ZFVQRWhNV1JJSitqUnA1NG41Y3pVOHBOSkRoWlQxM3V5bEVDczRlTXJk?=
 =?utf-8?B?QkdYYnBzUFNXMXViQ25UeHowaFE0Z0lERnVIVW9IWUh2SURkcEFOYXhZN1Fz?=
 =?utf-8?B?bDFHNnRnWTJjaktSMEoxbTJaa2l3QStTNmthY3lxVlpnTFo2OUloYkpmaVBp?=
 =?utf-8?B?WTBiMitCSTZ1eDVaRHJ3Z1BnWXkwandmSkNFblNoYXdvNlF2YkwzVDVsdlo0?=
 =?utf-8?B?UG5uZUxWKzVTcmZldkhWMkt6QlFXTE9CandGTUNBWXlzQnhIN2J3RVQvZU9w?=
 =?utf-8?B?WmtObC9OdGliWG0rc25aTURWQWJLc2VFWk42TE04eFUzQnI4MTFCOGF5UnhU?=
 =?utf-8?B?T0tXdjNQYzRQVmY2VjQxOGhvODBVM003RU9sR2JTbzFaalp0bU91aGFNWlNI?=
 =?utf-8?B?RHhzNWtvam85UkZkS0FyMkhRTzVSZklZMDB1YndLTHZROVZPQTl5TlpvUUJv?=
 =?utf-8?B?NzRzZ1E3SDVmMXVzUlNsSEgxekppQnFxRE1kUmFLeXRMYzBsbVhiUmUyanA2?=
 =?utf-8?B?QUprUWEvUitBREpFU0JXb3l5Tk1iQmFvU3VveFNUdXBoeitlMW1VYkpvSFdS?=
 =?utf-8?B?OFNNNnBBMzBRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHVrbHRrUDIwL3hsN3hNTGFoenBoZzZUZFBic0RYSnRXaXJHdUJzcFhnNlli?=
 =?utf-8?B?ckN0aytJVTFnYU83NEFacGZDMXRpTGlwK25KWkxsTFhzMkphYjcvdStJYlJa?=
 =?utf-8?B?bGlWNlJHeG1lR2Y5cXZmN2ZFeGpQZS91SjZSdXZtaklwZEx1WUQ2K1BVcFFD?=
 =?utf-8?B?aVoyZCt2NDJHeEI0UzVhN1J0TW1saThVR0NGQUxjV3dxWHhiY1pHUXNHNEZn?=
 =?utf-8?B?M2tuWlpjbjF4NUVKaUF6dmRubEFXT1pFWlZrQ2J0R1lSbU1HcXg3d3lmZHRL?=
 =?utf-8?B?S1hlMDUwNEtpQm03WlFtUHhMZkVLZk5BRHU3V1VCSzNpUzVGR3Y5Z1RKNVEv?=
 =?utf-8?B?N3MwcnI2TUR5enJqd0hZSVR4VWxmVlVuMnF2SzJTOEx5M1A4K3NqRnpXU2hs?=
 =?utf-8?B?MTBOdTBqRjE2WlVKV01IaHlXR0VRZyttcTFySVdPbHZmOUUyNE41TEtWcEE0?=
 =?utf-8?B?S2dDOTVacldwcU5GU0w1NFlZaENyQVQ3UUlOYjBOZGF1UFNwZE1IandyckU3?=
 =?utf-8?B?YnRnejB1ME5keHRuMFVreDMrV2ltaDhacEF2RlNBWXczajFSa1pramNMYytl?=
 =?utf-8?B?Q210TXoxSmFId3AyZGRzOVlwWmdsaFl0R0lsU0Z1bnN6aUdCVjVRTUpZZFpt?=
 =?utf-8?B?ZEIzUEwxMnoxOUlUdmhGNjhRK1p0S2o5Nm40VFZXQTZsWHA2WS9vUE51dWJG?=
 =?utf-8?B?OVRyVk5jbUowV2UvazVaTXVqK3V0c05lYUFnRVdPNXh4RC91VWVGUUg2V2xI?=
 =?utf-8?B?NXc5S3k5WWk1NGh2R0hBWldOVU1OMW5OSE1zZDIrM0FCOGQ5SExpclhpN3J5?=
 =?utf-8?B?SjNwaFFUb2IzS1VGQ3lrYTVRYjRVWk51Nk04NHdQL0ZFWENLaU85MlF1VWdv?=
 =?utf-8?B?U0FPMUFtZTNLMTc2dzYzOVI1cXJZQm90aFYxNDl0dHZ5QTkwVEZqV0ptMU03?=
 =?utf-8?B?bDNqajRpTllQc3d3VWJDditFaHlCOHdoZXBiZm02Tmlob2lQQko5Q0ZDVVJE?=
 =?utf-8?B?bHNFUlZOa0xSN2lOaVVBUHBkZDdFYXk0UVFCaWdSbVJnbHBLcEM4RGVwVk9S?=
 =?utf-8?B?SCt0MkVkd3d1THZNYncwcFZZMytsbW1HT2NDUWFKdEJleFhibWNjVGhaSnVJ?=
 =?utf-8?B?VERIdzJvRFhkTURlZHYxcG5qTWcwVVVUWDNiRGRVbkxaWFhySnlYdVRsOHN2?=
 =?utf-8?B?ZWtQdDljRWJUa1UxV0ZHR0pwa3ptYTNJYnRBcU1KNS83VWt1VVdlUGpZNjl6?=
 =?utf-8?B?aktEZE9kV0lIdEt5WWwvT3B0UkE2aGFDcmFXYVhtTFZ5MlhLZ0RYc1NsSmRW?=
 =?utf-8?B?b3BXcGRObEt1cFFqeSs5OFVrMUxFR2ZxaHNaYk54WXArbGpidFB4SDZCbXRs?=
 =?utf-8?B?ZXdjbzNsa1NFYXlnQTRaZHdxWlNQdDhlZGdLWHQ3UGJuVExTS0cwZGxWQTFy?=
 =?utf-8?B?djc2bUtKRE96UElxYTNVaTU3NVQ5cTZtTnA0N2FBN2RWTzluVUt1ZCtNTTlH?=
 =?utf-8?B?NUpabm9jS3ZoamROdHpUNVpwVnBLYXEyVTFLSkV0aVhHNFltUzVWZUtrNkRX?=
 =?utf-8?B?SVNxM24zTHJFa0p1VXB5MXBBeFVIeXNlVkxEWHhOdXl0ZVQyQlhHZFVhRi8w?=
 =?utf-8?B?YW44eG82S1hKOFpKL2VPMTFtcmorQWZvS3huazk0eEZEYVJBU0JNZ0VNaDBt?=
 =?utf-8?B?WXVXUzFMckJ4dDhDOEFFa1dUc2hLZnFEaUhJSjI0TWNKVTAxZk91bkFXeHR0?=
 =?utf-8?B?a1JBYStlaGwxMTlxZ09XSzNGdlRPUmNHcnpYRHBidTZ3WndrZUY0bVJhOFhE?=
 =?utf-8?B?UDVubUJQVlRWUU5BaVJ4SDhlSmtlV0pWQ1I5Q1cwaTByd3ptZFRKYUNnTHVk?=
 =?utf-8?B?dzc2dzJEYzdCeCtSWTVNRmFHKzVpam9WSnJGR05qbUY3OHhjQUNnQ0MxVDZI?=
 =?utf-8?B?SllJMjQ2L3hWcHpqYlRPMFFtS3lpTGJ1VVdCUFBjVzVwM010OFVnekt4OVQ0?=
 =?utf-8?B?SnJjUmx3UWhZM1E2VUVDbHhQdUFPb3ZmYnZHQzJsaysvVjlYNm1aK3FOMExy?=
 =?utf-8?B?aHYwZlEwN1BQZWM2Z1ZyeFlIL0J2ckl0bzZzTSszYTNRL3hmR1NWZWUvQnlQ?=
 =?utf-8?B?R25penlWZkYyZ3lYNHhjNGtYamRXRnQ4K0YrMzc5eU9ZNnQ1RGlXTkdYTVIr?=
 =?utf-8?Q?bBQntpAIOfYvLYipt64/LzgNFgCI+ruT17zwitvrlrn/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a40179a-0298-49f2-0e28-08ddc41776c2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 03:18:41.7012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NBoiAngiBT+pepKFu2cp3kwHo4K81s4iHs/67Ii0TWma3PCLeDVlzFBwpD5c0zO7kY4j5KCuMqhl7vvdqiqkmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6638

On Fri Jul 11, 2025 at 4:45 AM JST, Danilo Krummrich wrote:
> Implement `dma_set_mask()`, `dma_set_coherent_mask()` and
> `dma_set_mask_and_coherent()` in the `dma::Device` trait.
>
> Those methods are used to set up the device's DMA addressing
> capabilities.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/helpers/dma.c |  5 +++
>  rust/kernel/dma.rs | 82 ++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 84 insertions(+), 3 deletions(-)
>
> diff --git a/rust/helpers/dma.c b/rust/helpers/dma.c
> index df8b8a77355a..6e741c197242 100644
> --- a/rust/helpers/dma.c
> +++ b/rust/helpers/dma.c
> @@ -14,3 +14,8 @@ void rust_helper_dma_free_attrs(struct device *dev, siz=
e_t size, void *cpu_addr,
>  {
>  	dma_free_attrs(dev, size, cpu_addr, dma_handle, attrs);
>  }
> +
> +int rust_helper_dma_set_mask_and_coherent(struct device *dev, u64 mask)
> +{
> +	return dma_set_mask_and_coherent(dev, mask);
> +}
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index f0af23d08e8d..4b27b8279941 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -6,9 +6,9 @@
> =20
>  use crate::{
>      bindings, build_assert, device,
> -    device::Bound,
> +    device::{Bound, Core},
>      error::code::*,
> -    error::Result,
> +    error::{to_result, Result},
>      transmute::{AsBytes, FromBytes},
>      types::ARef,
>  };
> @@ -18,7 +18,83 @@
>  /// The [`dma::Device`](Device) trait should be implemented by bus speci=
fic device representations,
>  /// where the underlying bus is DMA capable, such as [`pci::Device`](::k=
ernel::pci::Device) or
>  /// [`platform::Device`](::kernel::platform::Device).
> -pub trait Device: AsRef<device::Device<Core>> {}
> +pub trait Device: AsRef<device::Device<Core>> {
> +    /// Set up the device's DMA streaming addressing capabilities.
> +    ///
> +    /// This method is usually called once from `probe()` as soon as the=
 device capabilities are
> +    /// known.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This method must not be called concurrently with any DMA allocat=
ion or mapping primitives,
> +    /// such as [`CoherentAllocation::alloc_attrs`].

I'm a bit confused by the use of "concurrently" in this sentence. Do you
mean that it must be called *before* any DMA allocation of mapping
primitives? In this case, wouldn't it be clearer to make the order
explicit?

> +    unsafe fn dma_set_mask(&self, mask: u64) -> Result {

Do we want to allow any u64 as a valid mask? If not, shall we restrict
the accepted values by taking either the parameter to give to
`dma_bit_mask`, or a bit range (similarly to Daniel's bitmask series
[1], which it might make sense to leverage)?

[1]
https://lore.kernel.org/rust-for-linux/20250714-topics-tyr-genmask2-v9-1-9e=
6422cbadb6@collabora.com/

