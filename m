Return-Path: <linux-pci+bounces-12746-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B570896BB34
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 13:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C3F3281186
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 11:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6861D0482;
	Wed,  4 Sep 2024 11:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="hAypbGcN"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2080.outbound.protection.outlook.com [40.107.241.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962461CF7A9;
	Wed,  4 Sep 2024 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725450477; cv=fail; b=kZPGHchLVciSa+3wQ24irmH8NheM8l0yboRW/efp674MpLoJSTP7xULPKbXsXA93Ss7V6i+9CXR786MWUrsQGZ2CWWHUBTUtwkXM3qIlHEV6Tjk1qj3mpZFyq6AkyQLgz2PTKaIs95j5d9F4SJhbXzgsFvw/MCwS3TBnJZoFUEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725450477; c=relaxed/simple;
	bh=hMNnSwK5+HR5kyi/Zbvd9j3saAq1sH/nJvNn8nA7tcE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ERBIt/WT2C/MWEWL8i8IE0T0S4i2cx3BSBsxqgbaN7P96m0NDmdFO0WuACMgr3punnB0dZ73XZqHKEVrTNKUXHdCrcmEB9Xr3nSt5hBZ5fKk0BN8ABfqt6sINQZDazzVNnlk9eznH5APd7qJiSkOcDzxJCX4EH49f9JcnyAsbrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=hAypbGcN; arc=fail smtp.client-ip=40.107.241.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fr7Phy/shdb2VgfVTjYZfC1+Gzh5VJz4WbvnaKprOxY9m9Xrx2nqvD2m35a/wMJ3GtDEiHjMwyJFJ76J3xGfz55a+vFs/vTSkzcMfe8aVkeWv93IRHWmpa5P2VCMf51IvowqcOw4bcayW9suq+u1eO4MTIJPJFFzHZyUKYMVutBxsdzfhWStVaD337Ctr+OA468AUIELwmAJhNFWic793ygOnnhFmnMJ+NUVCO5uvIXl093pjWSfUYccxNYdrGU0TjiHQyQV/K6Qib9iYt7hc2iCT2wzaoj4eHT32S8x7Ub4IhtEkq+W+TfSuVQCgT2lLI7H0kfjT4OIH4gmxZVaGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqoHKaCbSoquTf9GtQkvjR39l7A4cG/Cn6pCh12T35s=;
 b=vXQEjbJSyQzFlUARbi6Nf8Xi2LeZVTQzPJgqGghX/XZ8VGbUMYFPBZELuCZZdfMwftRQkSWwzaa4MRKOHUR08dQnZNqCelC5PSYDw300c1TIkeVVAK2fDalikl3HJ3wq/0yFJRTfNEICHVlLdauJYKRTFYJ/YM6aABuvbdFKHCXWa3TP45MfJLVmDobqSjqqA/Y7Pw96Xha3FdIUGOOeSXDUsOCDpz+AolQxR1X5s4glFixZAaNKLvVWJRKmjlpmKIMUrS7XkBX+Pgq7LfqGX3zwKPl5cbp6DLcxZAHhZyvC4U2HEheY6ybf/wgrSer7ecArvptmbt8pThzoJHRdkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqoHKaCbSoquTf9GtQkvjR39l7A4cG/Cn6pCh12T35s=;
 b=hAypbGcNOfykLTT0RB6OSuxgeBzWEUBVYe5w0/6yhcdKVQ6ia0RdBuwgTluMqdkkbkY3UW97Zpx1ibPzn8jmrRyr5SDwhZvual1+xFLeVRm+wmSRJIULBkxs7sTYyVJiLYWC64rWzfG8vSF2Mul9d9TLLt1t41R+sBT1V74OzpEfkqsL16LiSooteJYNdnKeMAZR4mwo4FYJi+NDPEm8Su28I4lxU+6zFqUSIPHocH2wh1Vi8kfaVMfhayHvuUyzY2wE7CB20amynfMrsbL0ckvMOLP8SdtX326oZo8h5n2v4Wejoup7CM3LBtADZOa3oX1q9KxLo2NGzMTg7+Ku0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3319.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:101::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 11:47:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 11:47:49 +0000
Message-ID: <59b921c0-d070-41b9-ba42-96e7b20ef45d@siemens.com>
Date: Wed, 4 Sep 2024 13:47:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] dt-bindings: PCI: ti,am65: Extend for use with PVU
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
 Hua Qian Li <huaqian.li@siemens.com>, Diogo Ivo <diogo.ivo@siemens.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <cover.1725444016.git.jan.kiszka@siemens.com>
 <28d31a14fe9cc1867f023ebaddd6074459d15e40.1725444016.git.jan.kiszka@siemens.com>
 <6d722868-271a-485b-a7af-e2449adc83ca@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <6d722868-271a-485b-a7af-e2449adc83ca@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3319:EE_
X-MS-Office365-Filtering-Correlation-Id: dbce5c1a-8b04-45d4-4e1a-08dcccd766af
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aU1FWUdtcHdWNGF6bTVvcGI5aXZBWG5yVjJacWVKeW5CUWh6bVExZTBCcUhl?=
 =?utf-8?B?ckowaGRMK1hJUUJsT0dTcldFT3RlYytuN29zL3g3Q25kZm52ekVKaDVpQm1Q?=
 =?utf-8?B?dXBjc3ZLbWNYMXlnVS81Y2kyYm1IOVptSU1ObWgzWGUzVy9pc1prdHkrb1kv?=
 =?utf-8?B?VWV0TEZheTB0QzZ3N3RXWGdaYUdRYmVZTlNCdU9DUUtjZnlzVjZ5cjFEcnV0?=
 =?utf-8?B?UlJqSlNkakhLZGZNeUdybkVoMCtFWVdzenQ3OGh3bVF5Snl6YnlhUjl1S1ZE?=
 =?utf-8?B?dzRCb093eXZvdHNEQmZoc253amo2SWN0b3dyQzdWOE9FbzIyUU9FU2l5R0sr?=
 =?utf-8?B?WUZSREI1UHB1VUcyYXBPaXUrNStNZ2VxbzJscnpYTUJ4OHdjRkZTNjQ2Njcv?=
 =?utf-8?B?d08raU5mMnlnVlY3c1dRS3Vmb0JSWmJxL2hXMzBENGtGbkNXc1lGQVJ2aitB?=
 =?utf-8?B?SnR3ZEtpb0VnU1hUWTl6NHRkNWFObHoyWWZ4TDJQN2RLSlVYOXBJV3hLUHN6?=
 =?utf-8?B?OXdqMDR1YzZMOTNNc2NHZVJWRnRqeExWajR1TTEwQ2ZCUUdjYlJIaXZMQm12?=
 =?utf-8?B?Mko0MlRSRERRUWtMS08ySWpBVVU5cW96Ky9kdlFMMFdQQVZQZnExU3RVWGg4?=
 =?utf-8?B?QStGZmZSYVBhVHpLU2hvN090MUdZSnBIU0pvcG9nUG9yek1BWm4wUkh3WkdL?=
 =?utf-8?B?Tm80b01WTTFkOCs1ZytiSW9ScU1YUHlhNGtQQ2JWVG13Ync2RGNGejhERGlD?=
 =?utf-8?B?ZVhiNTFuenBDQmFMTVNSV1VseGRCT3FvTWNmSzdObEgrTzNhSEIvRXRaTE8v?=
 =?utf-8?B?TGVZRld3R295UVVFdDl3MHZESGx4d2dmdGp3NjJpNEZTaXhVV0hGdE9WN3V3?=
 =?utf-8?B?L0J6TjhkVFVnU1l1RmVDVzdKcHh0RDl0R0k4bXd2NlF0NTMrUmZ4aEFVSDg4?=
 =?utf-8?B?aDVvYnFueGFpZ3RrQTJLVUk3ekVzZ2xoeE5DcHM4NG1Jc3kxdzJ6MDBjdlBD?=
 =?utf-8?B?eXVGUHJHYlRqeHZxbnFhU2RoL0JlMVJzWlBoMkJMdDErM3ZQL3lydzVNTkR2?=
 =?utf-8?B?MmZUOXYzS200K2JWaDdibmE5WEVDTHZpdWRuL21xck9xL2FQR1NvNFN2aUhJ?=
 =?utf-8?B?cGczZzA3VDkxdkYvQ3FiQkRHOVJacmwxY3lQMEtqWXZYOWJYalBBSGp4R1FN?=
 =?utf-8?B?VER4WXJOd1dxdEt0bkxGeHlMdkh4OXd4UUluY3RNMGJrTFplUFVRd2J5SDdm?=
 =?utf-8?B?V21IU3gxbHhCTHlXdW1JS0RRT2svNWJpT0d3dHVIQjhyNTdqV0FmQTA2amhh?=
 =?utf-8?B?ZndrS1R4SExFakl4UFRoYTh2NjJvK1QzRlBzSWNGNWdnTm1NVU1tMGtjLzFV?=
 =?utf-8?B?MUU2KzhESE41Qit5UWV6UStQbUpyUUNyRTBQaEZUMDNGNnVpVHRkN1NSYmdq?=
 =?utf-8?B?enNFMkcvK2xwMkVoa09OT2ptTE9qOElzWWs3V0hreW5QZnBHK09teGRoVjdi?=
 =?utf-8?B?WG1yZTZ3VzcyMXVlbzY1VTVXamNYK2phNFl4NVpIZ2lBcTl3MG15ZzBBODR4?=
 =?utf-8?B?ZGVDRU9ScTNJblJPYWJiVzBvU2s4aHVOV3lTTFI4cWMvWXpyaDg3QWpqNnZH?=
 =?utf-8?B?a2lPaGZmMnI1QWJvREF6MWpIR1VNTTlUbk9QN0VHL0g0WStJOHFSOGlnbGRW?=
 =?utf-8?B?QWs0S3B2aGVIcm5NSkdhbWhVdm56KzBZOVRvRTBIUllpMWRIa1crT0R5amdJ?=
 =?utf-8?B?NEt0QWo5ZUFhV2ZxK1dRRGhQaElyRndtV2lHVnoyTDR5ZDFiVVBKeExRekpw?=
 =?utf-8?Q?gscT9VZPQMSc/wHQN30GX+OFyLVG1RlO+0xhY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEJkc1pSRWVsWi9xaSs2RnZYbEdWYzR1ZnNpd0hJS2wvTzE3KzhIZzg5SW5K?=
 =?utf-8?B?a0c1L3h1YUJFNGdJSGMva2pSZ28zRzlpZzlFcFdyVlNnYzJqWTc1Q0RGc2tH?=
 =?utf-8?B?NGFmanAyRzNLVEhvZVFpNXBqVWVaakxGK2lXaEdsNEoxSm5HWlM0YjNsNUdJ?=
 =?utf-8?B?OUtCOFJFMEhUUklhUmFzK25melFLTHJ3VXU4QmU3ckFqcm8reEs1MEsrUVJ4?=
 =?utf-8?B?eTdsejNMcW1OangzZnpzc045cVg1anZDTm9YSFhXOGRnUkV4NFZrR3BEWEF6?=
 =?utf-8?B?NlhtQk8vMmJGaCtTR3dsbVFEREs3bkRRTmhpQitNNWozejFzeXJCcDhJY1RH?=
 =?utf-8?B?OWcwVVhXT3VJbVJPL05RWjVneVpTUFJsdkFWbnlPUXh4RU12cklpa2lmVEJn?=
 =?utf-8?B?MWZIQk1sMHNkYmo1WHlYcG5CeHROSTBmcWlMSEdPbHNDZGJBa1ZDRXdxRWNZ?=
 =?utf-8?B?QlRoOXhhaS9KeFBDclZncmZsVjBQc0FBMnNlcTBqcEtTTFkzeE9ZR09jSjRL?=
 =?utf-8?B?WFk3bDIwNnduUndtZS9rRy9hQThLei9xOWMxbzM4cU5sRk9pdVRQb2dabDll?=
 =?utf-8?B?T09EZXBUbTZiTStadmJuSGlrVDI5WjBzZ2tpTGFMY2FEVG40WHgxQTd2UXVs?=
 =?utf-8?B?TzgyRlhlZ3E2amlIcVhxSlRFMVBJS0hXRHJaSGY4WGJ6OGh3L1RJczkyR1k3?=
 =?utf-8?B?eEp2VzFMSjZhSTN1TjJOaS9jSWxWUWlYWGxlb2Z4ZGNuVTZNRHRtT21iUzVW?=
 =?utf-8?B?QWFxa2t0OXA5WWpxclRJNU9aYnN1eW9mODZvdHk5STZvTlRQY1dpQ0cvc25R?=
 =?utf-8?B?TTlhKzdubHFlaWswdTlJdjB2R0lia2wxOGpRQU4ySmVWZWhMNjZUZk01Qkc5?=
 =?utf-8?B?UGEyVDBPaXNPaEVpZ1Y5M29rRzU4NTcxRWxmZDNaODg3L0NIaU9qcnNLZVQ2?=
 =?utf-8?B?d1VaVGlvQTVzeVRwV2lTNnhYblZTcDFkai91QVVXTmZqV3hUWVMyWFMrOXRk?=
 =?utf-8?B?SEQ4UDdEYzQ4QkhLNXZncWtNYWMxRWw0eWdUb2Rhdi9yUHo2SVdmOWsydmZI?=
 =?utf-8?B?WklEZWZ4cnh2WmVGc3lMZElRQ2N1WG56OEFrd2NxMjFWZjdpUlNYTnZvQ0Vo?=
 =?utf-8?B?Sy9JcTFRUmMxdFRqZGd3Q3pNU3M2VGhmVEpWTWUxdXdpQ0F3ZFQ3eGFxSEdp?=
 =?utf-8?B?NFgxc1RQdm9iWUovcXhnS2xlV0toOWx1cldLeVFLOHY0ZmluQkVqdFNQa3Ur?=
 =?utf-8?B?S3hDSHYzOXNFMDkrTVhpTWN1QlJvWFRZdDd4eWFjMUwwZ0U2d0pXeTZrYURa?=
 =?utf-8?B?NHVaWExNRWlLTXRvTGVwWjlxUjhwbzVoTUdXKzlEQU80cEJHWFcwVmpoTnJk?=
 =?utf-8?B?RDNTb2xQTkEyUzNIVmwwWllmOERtbDQvcFh3ZlgyYjFjMGlZN3dGdWdHVEdn?=
 =?utf-8?B?VkZReHpHL0w2cG1GZ2ZpSVpUc2tSV2Q5WHBCQTJLaU9sNXYwVnBRdzVLWmU2?=
 =?utf-8?B?VFd0d0NjV0ZTZ0JIdnphaDE2bGJZQWlBS2ltUHVwZDFvekhDY0FhekYvRk1S?=
 =?utf-8?B?ZmI3RXJkQ1JiamhzN2VFb1EraE5PZUQ5V29SblVUWXp6ZXNGSmRQTlNUNDJP?=
 =?utf-8?B?MDVuMHV4NGlpZk9PejFpRFpubng0NDNNU25lWmMra3E0MDliK0ZnQjhYWitR?=
 =?utf-8?B?RDVFWFh1dHhsWHg4bTdjdk1KTnErd293SWNhSUg1QWJBVkg1YmdBOTZUaUtn?=
 =?utf-8?B?NThVaStmYjAvZURldU1IUVhCazNBNWJPOXprbWRtL0dFTlNVRGg2Z3AzNTZ3?=
 =?utf-8?B?eVFrRVRGT1l2amJTUG5QT084MkdSSnlSYTBLNHZFQ2ttTG9xMzdBcHowa3Iy?=
 =?utf-8?B?UUxObkdXaGR2T3c2ZFdFOXlMZU55SUREK0NDVHBXd2NRTUh5Vm9nN3cyS3dw?=
 =?utf-8?B?am1zdC8rZmdtUWhFUHFDcUVtRk5VOE5MaVhXQjBaU2hYMXhCVlpRM2l3SFI0?=
 =?utf-8?B?b29FVnk4MC82SDd6N3o2b0lQSllCV3oxeW1XZWVrQW14TWRNaXQ4STRSMXMz?=
 =?utf-8?B?V1Mxd2Q0UTNuTE5uTkpHR2JVNGhpbWR5aEpWcXF4c1ZhOFByU0RHZkFhVWky?=
 =?utf-8?B?dVV6VVo4VHd5ZVBISkVwckJHajdteHBpK2FGUHN3b042NVpNeTZwZUc5VlU3?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbce5c1a-8b04-45d4-4e1a-08dcccd766af
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 11:47:49.3629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSyAJIYB9UZ+st6Lql1hPMZe8fcnuOv+jm35x/zh8so00gkyhurh+YhUZ7dxAi3XzNn2GMhZnfiXA0D1kDK7OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3319

On 04.09.24 12:16, Siddharth Vadapalli wrote:
> On Wed, Sep 04, 2024 at 12:00:11PM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> The PVU on the AM65 SoC is capable of restricting DMA from PCIe devices
>> to specific regions of host memory. Add the optional property
>> "memory-regions" to point to such regions of memory when PVU is used.
>>
>> Since the PVU deals with system physical addresses, utilizing the PVU
>> with PCIe devices also requires setting up the VMAP registers to map the
>> Requester ID of the PCIe device to the CBA Virtual ID, which in turn is
>> mapped to the system physical address. Hence, describe the VMAP
>> registers which are optionally unless the PVU shall used for PCIe.
> 
> The last line above seems to be accidentally modified when compared to
> the one at:
> https://lore.kernel.org/r/ada462d5-157a-4e11-ba25-d412a2bb678f@ti.com/
> "Hence, describe the VMAP registers which are optionally
> configured whenever PVU is used for PCIe."
> 
> If you intended to modify it, then the sentence appears distorted.
> 

Yeah, I wanted to make the original sentence clearer but failed:
"...which are optional unless the PVU shall be used for PCIe."

Jan

-- 
Siemens AG, Technology
Linux Expert Center


