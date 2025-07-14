Return-Path: <linux-pci+bounces-32046-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E99B0387F
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 09:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACF3F3BD72E
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 07:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9857423717C;
	Mon, 14 Jul 2025 07:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="V2uGom8V"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010044.outbound.protection.outlook.com [52.101.69.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB598238C04;
	Mon, 14 Jul 2025 07:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752479858; cv=fail; b=slLly5VFkBP9PMzR7El49e7aLig46xCBP4Xv27uFDTIO8VtHFC4yVl54pRQ5HMDSzNmPqXcP9qdAi/iKC9d2AgnNdA5KxcFWhbcxKWitGqc5KEgsywzf8FH3jqHlCJTq3p2mE/elZvVE4I/cjevGQvFDzACdwG0gsHCUc6lnNhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752479858; c=relaxed/simple;
	bh=ayazKlwJVJCZINi4FD6e48x4j5eFArgKHK32Ch79yro=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DvvTq+6hOgzDsGWkkU6VWQwEUtqAko6C1Hn8ea1KRe8ZPd9oW68+WWom1qxf5uCZPtOk4uYuEm6mkGL2CWXifWHztCYlHKIVRCA1qsDQOvjKfR8i+aIZMxX96u8IFCwPN8S7DJtBQZMvWMU7ytEJ12cXkd0jyRph7TQ+KKq+3hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=V2uGom8V; arc=fail smtp.client-ip=52.101.69.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eh9kZu9AFIUwib269yBf0nsk/F116mwM2PUb9R7VJcc/zZvudU3cPAEbPItPfktgsqvxFJr+1PBYt71d7rGpCAWsKDKOqLEnC0vcSDICMz3LGOa4wLvNVRiGcxFcNkVphvvkkHWX49DK00eIEXhxgll7J3+Pju9ysfPqBgPt8CTg1wHLaCcIgeDjBso3dOVA3DTNNYbfNYXkK9tvMMLmvaHEZe0hgExYY20RLRtig9KnUz/0IBBLRH0zIrQITU/1YhbBol6S9cDK7hiJo+ERKcfXvTOEOsktHvQkueJbDYxV8MZj1pcVV6gjgtiU9oBJdPdxxYJ5Jx7nb+HyDCbH4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LZd85MfwfLst7Ni2Tz//WPk8ZDMbDEWbkr7UpcD4Qc=;
 b=QC6e/rEotJJm5z6wOoJlAk//tjS2vMfaqD59gzu8opZap3rpm3Zh4kMBCFIdGSEYZtN0cAMs2Cq/a/QEIV3D/sPXuRFDdUCQRyrOtnBwfviCsWiGAz0YGfhmkhnuyVWNZl7BwoIM+MzX88qgAWI6edablePKkmMnOJJ9jHBdVwkpWccV2KZWtlkSDIjSicNwNC9Y7VftkvHdt2vF+JBEbV2y+ioaYD8cV8p3y5fHnWq5qrCsW5Gt0bGS6f8OukEQfRZtDGhxzChTfqtGRCRpPMFHyxodkuVvmjfvTsvinq+zlE+Rs/o7KckDvZXQG0kKBEaSrrKhvt6G62WKZ4yeqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LZd85MfwfLst7Ni2Tz//WPk8ZDMbDEWbkr7UpcD4Qc=;
 b=V2uGom8VDdMwSaQ0Wt1ugpEmQsqGYZdvK3Jy0Zr3xA1m1NHEsm6gKD2YKoberNsAHY03OjHwtKPAkGKGgsJ6HlK6bvOsvxOIdpzOf7lJp2VCxFVV1YPeVyz+UFO4Oc/k3vCvWLjOu5egHAoIlmPCkC49g4H/a/dpre93pxRMBkJJd0RHdgLDLDI55CF/prZYhUgmzUHv08rJPYL+m1beTryRwx6TEpHMMZsEJKjgSU8pxC8lSWPhklC5arpHYhbenfkGKLc6qzmwrU0g0Uio7K5xCNRaAcNcv8qbi1XnLsBQjASxIfVgqnJQmayzm/48HS41GclV891OkxOQQ45r0w==
Received: from PR3P191CA0055.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:55::30)
 by AM0PR10MB3345.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:181::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 07:57:31 +0000
Received: from AM1PEPF000252DE.eurprd07.prod.outlook.com
 (2603:10a6:102:55:cafe::91) by PR3P191CA0055.outlook.office365.com
 (2603:10a6:102:55::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.30 via Frontend Transport; Mon,
 14 Jul 2025 07:57:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AM1PEPF000252DE.mail.protection.outlook.com (10.167.16.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 07:57:31 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Mon, 14 Jul
 2025 09:57:20 +0200
Received: from RNGMBX3002.de.bosch.com (10.124.11.207) by
 FE-EXCAS2001.de.bosch.com (10.139.217.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.57; Mon, 14 Jul 2025 09:57:20 +0200
Received: from [10.34.219.93] (10.34.219.93) by smtp.app.bosch.com
 (10.124.11.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Mon, 14 Jul
 2025 09:57:17 +0200
Message-ID: <d6e62068-a05a-43cf-ace3-ff7a41e9a1d7@de.bosch.com>
Date: Mon, 14 Jul 2025 09:57:11 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
To: Danilo Krummrich <dakr@kernel.org>, Daniel Almeida
	<daniel.almeida@collabora.com>
CC: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
	<gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas
	<bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>, <linux-kernel@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
 <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com>
 <DBAE5TCBT8F8.25XWHTO92R9V4@kernel.org>
 <DAD3292B-2DBF-442A-8B60-A999AE0F6511@collabora.com>
 <DBAURC9BEFI0.1LQCRIDT6ZBV9@kernel.org>
 <DBAVXQTMR38Z.2782EGR84L7OP@kernel.org>
 <DBAWQG1PX5TO.6I2ARFGLX88N@kernel.org> <DBAX59YKO0FV.ANLOWRHDDS92@kernel.org>
 <DBAXP68U809C.2G8DMB52M3UZ7@kernel.org>
 <C4A101A7-282D-4A67-A966-CF39850952EA@collabora.com>
 <DBAZRNHGIGL8.3L2NGPCVXLI25@kernel.org>
Content-Language: en-GB
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <DBAZRNHGIGL8.3L2NGPCVXLI25@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DE:EE_|AM0PR10MB3345:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e2e35ad-4776-4faf-2aa0-08ddc2ac15c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekRROTRENnFIZ0pibXI4dXBMVnN2SlJlb2IrVXZrY3hlbnFlYVBHcEU1bkFr?=
 =?utf-8?B?bWRUUmI5eWxod1hGdlM1MEhEQjNxazkwYVBWME5OcGE4Z0hhOGRMZXB1Rllu?=
 =?utf-8?B?MDgwbUZkZUtHcWFXMjV5WGpNOHBVYjBZSDNhbEdXdGR1ZWQ0RDB5OER5Z2N5?=
 =?utf-8?B?YXZDbFJ6Yk5WdlplUXduNy9qTlRwNzMxaWJBNVJObGcwL3YwMjN1RDBOV2NU?=
 =?utf-8?B?dFhoeTVkd0ZTUytPUW5HcjBjeThxZ0c2aDVkVTJJZFRuamdlNDFZUWJaWmNL?=
 =?utf-8?B?VUZ5TGI4MVdiOXloVW40Rmhoa1JpZFVUTU5SRVJsbExPQWxjYTczRWFreW8z?=
 =?utf-8?B?aWp3Q2p4VVhUbWFRdVlEbVpPalNFOU5kcHhEODNaOEhHT1JjcTZiMEZEaUJT?=
 =?utf-8?B?Zk56RElCdkZ0TFNmaFBxNGpCaVpKSHhDY21XSmI1b1RTWElSaUprOFAyVmU4?=
 =?utf-8?B?MWFaWTV0L0JnRXd2cjJWR0gydXk1T1NXY3VtSGI1MFZNT1pmb2dGR20vWVBa?=
 =?utf-8?B?TlFmenZwZVZHVWJqaHpHUURhdFh6RTRSU0V2WWxIbHJ0K2ZpMXY0UWlxSElB?=
 =?utf-8?B?TFlzWTRlenUzelo3VEdjSCtNdzE0dHVBR0YvN01Cem8vMVZyRitSaTRna2ly?=
 =?utf-8?B?MFNiZEc0OTY5QlQ1NFpFTzk4cXJFbkoraGYxbU5uNUpKMmVlYkxiL0FOaldp?=
 =?utf-8?B?dnA4ei8wZjQ4ZG93ajVjQnAwajY3SUQwUW11YW1TVXFueThnT0YwMTdiZTF5?=
 =?utf-8?B?bk83aVlPem1RdG15MWVpa3Q0ZDZsZ3cvR3ZkcHNscnJwVjlEbG5VVExva0ln?=
 =?utf-8?B?UUJIMklFaGRiYjc3bFZMeExXdkk0d1ZpRzFhOUNEd2wyZDZPODdmNVB2a2c0?=
 =?utf-8?B?alltb21mbklrM3R3TWRQSnJyTzllM2pNZDF4dXo1UFI1L3Fsb2VTeEtsZVNG?=
 =?utf-8?B?cUdFUisvRTJDMEpEWVJVQzVoWFpKTnNETFEybFA0eGRtVkFvc3YyQmZjVDZh?=
 =?utf-8?B?NmZyN3ljeHY2QnROSEQ5WEdsejVwNzhPWUZ2ZDFGYnJOTGZCVUc1SjZUcTli?=
 =?utf-8?B?RGx4eEh0ZlJQdWhGdGNYOVFKUW9NcmZxOHNTK3VSRVRpcTUwV2hYNDZBMnZ0?=
 =?utf-8?B?TE4rbXUyNzkvaFZsaEx5L0U3Qjd6VHQvTXcwdnlwYVZhdFdvQUJsNTcrbE5i?=
 =?utf-8?B?MU1TeFh4a1lPdUJvNzhCTG1mbEdSWG5ONjdLUi9zeC93RmxKOUZxNGM2OUo0?=
 =?utf-8?B?TG1tK2RpeUprWWxkLzJaYUpvMUFpREJ4VlY3cGpBSElnbUdmVHRCeE1yNWNL?=
 =?utf-8?B?V0kwYVVlS0NtTDlWOGZ0WHV6azBtSDFYemcwU0Urdno4dEt5RDVHOHVIVTh4?=
 =?utf-8?B?dTJraTdZVHBvVFpmcWxwVmQ0Q1hialZ2dXpEUlVBT1FCK1llY3YwMmt3Y0J5?=
 =?utf-8?B?b3JrYkZhQkNPUzdDV3phUDl4cWRQVzBBVVZSNHkvZk5Rcy85d3Y1SGlTLzNH?=
 =?utf-8?B?RkYvQmNabjdkOXZqcVFVdEVrK1hrb3MxZ1QvZ1NaSDN3ckR1bUc2MjhiL0wv?=
 =?utf-8?B?R1BqcnhkQVlndmNramx6clk4U1d0UzAxME1LeDBTWnVNSkxhbi9XblBEWmp0?=
 =?utf-8?B?SEZRK0w5eXkrTkhjdEEyZkZIYWtGUWptcXZNQ2hGMHhUajJOOU15OUtCNzd1?=
 =?utf-8?B?VmpWT3pMZ3RYcjROdEZkZU93TnN6bnN1MEdmRGMra24xNkVRRll1Z3ovaS9C?=
 =?utf-8?B?OGFhUS9rNFBCU21HNmgzT0JGdWVvUy9YNSsralRXNHFjYW1pdC9OdytHYUo5?=
 =?utf-8?B?NExIc0lBaGRhWUR1WlZsTk81YTl6VThzQytUMWtHNTJUNUhYMy9SMkNNVUQx?=
 =?utf-8?B?Mzc3Y3NVM1k1eDNSUzNHNGF3NE15eHpLaE8rMy9jU1AwMlAvRGdRVUxrTTVo?=
 =?utf-8?B?a2lqUXBWQzJKMzg1d2VyYlozK2ZJeXprQWJ4dGpZaUsxWU81V1FIYnZFcnA5?=
 =?utf-8?B?cmh6bGFkRmF5c0U3bVYyeHM3VjI1cC9LdHBqQkRhVFJ2NnBBdzUvMlZLdFNH?=
 =?utf-8?Q?IwV3ld?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 07:57:31.1318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2e35ad-4776-4faf-2aa0-08ddc2ac15c7
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DE.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3345

On 13/07/2025 16:19, Danilo Krummrich wrote:
> On Sun Jul 13, 2025 at 4:09 PM CEST, Daniel Almeida wrote:
>> On a second look, I wonder how useful this will be.
>>
>>  fn handle(&self, dev: &Device<Bound>) -> IrqReturn
>>
>> Sorry for borrowing this terminology, but here we offer Device<Bound>, while I
>> suspect that most drivers will be looking for the most derived Device type
>> instead. So for drm drivers this will be drm::Device, for example, not the base
>> dev::Device type. I assume that this pattern will hold for other subsystems as
>> well.
>>
>> Which brings me to my second point: drivers can store an ARef<drm::Device> on
>> the handler itself, and I assume that the same will be possible in other
>> subsystems.
> 
> Well, the whole point is that you can use a &Device<Bound> to directly access
> device resources without any overhead, i.e.
> 
> 	fn handle(&self, dev: &Device<Bound>) -> IrqReturn {
> 	   let io = self.iomem.access(dev);
> 
> 	   io.write32(...);

As this is exactly the example I was discussing privately with Daniel
(many thanks!), independent on the device discussion here, just for my
understanding:

Is it ok to do a 'self.iomem.access(dev)' at each interrupt? Wouldn't it
be cheaper/faster to pass 'io' instead of 'iomem' to the interrupt handler?

fn handle(...) -> IrqReturn {

    self.io.write32(...);

?

Thanks

Dirk

