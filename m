Return-Path: <linux-pci+bounces-31832-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAD2AFF6C6
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 04:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0825A0FE7
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 02:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D721F27F19F;
	Thu, 10 Jul 2025 02:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eRfRTtfM"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094F027FD4F;
	Thu, 10 Jul 2025 02:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752114271; cv=fail; b=lRMvixQJmU/nRov7av/NjS95Q2BGpaM/4A7uUu4MVCnlO2HvL7w9Arw7Mas0PnGdYH66VQmr+weWHJiFjLLKUUcJnwDILOui5rvZB8cjpuLu92ZpJ48D8NMbwCh36Z4utl5XXCEZi5nL3flLaEVAWv/mpocbXVOxR2hyS0kF2M8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752114271; c=relaxed/simple;
	bh=nyV7KxZ+viumsu+edu8hwvu86bPQVZjiusX+N5J7lwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MMMML+GZF8pklmCbmZkJzCfe5a9Gyc63L+OOcEAKgVmVoFpR6bb/1MM+/U+M+xPAIRCCuyfsXcp5P8UQhjaZsuJLiKOjcDoOf2uA7tdCO9R/Kc4IrmI95hSJxDnfs9yK1ZE9ziw5lxN5Dq89wYGDi3VTsEzPz/rFpwmXQyqCs70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eRfRTtfM; arc=fail smtp.client-ip=40.107.100.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7PMWQ+DYIiuCPvuBkBzfbSFcFq6RViWSjNLe685X0xVx0ofWmiBXHB7seaDdCoAcY9aZirVBtbacFXO7tQVPi9ms5vPVtaZknP27mqIZSPZbtTOjWvjcSuIVFitpKDTLX9Hbg/kdQcmyDmQy8+P5LYFAjF9fM7oF0cSwQJVOKadejJfbF9IoNroqOjR+08Y1VbQlHR/hrHhmwe28iTgsaxz65HGOAeuH3l87cYICkuXi0yN5NfOEOggOXQYaGUpNMALY/FJWNcvkxw2K277Wpucn1eOlSvsOQglZ9VGeVNSK9F+7Syb+tiOtTIbKfpm4rUhbAd/bWAi8Z8f1Wtr1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02mbPziNpip6waBrJrgvs1QiSEML4Z84exf2/JeXiNI=;
 b=aBNndVaUDnzgwbRJM9gJE8YPb1WKD/To0Fyq/l2FRYQrrSf8MYF5fyQN3qayrL0jCytfFKybAwOxDAJkcJlPr9UB50PrnhDpX9DTdniL27d0UGTgG6GUh+RcUJ9HZ6gFBi5Sw6zuIwiayEz4Eh9sRqEFCcIqLVYXGNpSRsY2BYHqlezXVzYyJozyIqBZTx6xfrW3XMy6yPgN5xNSfgASd0kfUdGcvSz1UZeBgtRVwEjv2tvcxxL4fedg8VSDBLli0dL+pcAEJKzwzrthLc//z9RegienLawj0Ozg3rre7ZCg6WhOGrJGierMSox9fY9D+BOnkZmyTekMwcCo9gU4ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02mbPziNpip6waBrJrgvs1QiSEML4Z84exf2/JeXiNI=;
 b=eRfRTtfM2eyKvGqaEET64eyHDiD8d2GP/n/tLmkoe4sTduGq5kriquE5j2IQM88l6w4zBrJRuOFZ8XVxlqPNRG7fCz8fs35CB1tjrqX3PpiRpeWaBaFPgaPS4nVBDQPyTuM4U9JWeO5611UXS58MO7aJ95nV+A2VdRZikNvsmllUTUtncjd+j0rGAYkqTvZXhkQsrlMV9BLRxmeogwX+w/MP4JBG/A9blqtt212dCPID/5cLdq9ec/JU0EwcFLbtGHkG0+uIbmWq2UbWyjAAdzYETjBc+oyPAg/qqKcDNsqxnq2Bs6zHVxFEUj5GiU1eBE3Uqzc9ulkalrVhf1pwvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Thu, 10 Jul
 2025 02:24:27 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8901.023; Thu, 10 Jul 2025
 02:24:27 +0000
From: Alistair Popple <apopple@nvidia.com>
To: rust-for-linux@vger.kernel.org
Cc: Alistair Popple <apopple@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] rust: Add several miscellaneous PCI helpers
Date: Thu, 10 Jul 2025 12:24:15 +1000
Message-ID: <20250710022415.923972-2-apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250710022415.923972-1-apopple@nvidia.com>
References: <20250710022415.923972-1-apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:610:cc::33) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: f976fe93-3a0a-4272-cdcd-08ddbf58e45a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cks1QTlxL2VDRmZNa2tyZGs5dkRqVlorRVQzV0ZVcWRMbFVVMHJwMlNTUmVk?=
 =?utf-8?B?OWVrYnRmYlVSekFJVHZUUEM1VTlJUmRyNU0vdUJQdlU5eFV4MG1STDVBTTNG?=
 =?utf-8?B?NVJuOERQM01FVTRIMGZzUGlqYlhnaURzQlp2c3orMzloY1JXRityTjVlU0Qy?=
 =?utf-8?B?Yk1XZ1pnVU1RckdOd2U4c3piTnp3WWJaaFBuRDd4SzNFR2xQQjFmL3JQV0I2?=
 =?utf-8?B?K3NlZ0xYNHZrcWh5RGVwSThpOU5xMlNNTitYaHc1TndDRG5pTUtQMWJDKzZ6?=
 =?utf-8?B?Z24yR0FtV0ZaOEtmcG5GUEdGM1BYNUo1bmFONEh5TzZqelhvOFRoemFzNXpx?=
 =?utf-8?B?VG9kVjhONzl6SkhpOHJMOUh2YWdEcGp2cWF3Q1ZOSXVNN2V2TEs3MXBISHF1?=
 =?utf-8?B?N2QxKy9ZVlpQL1V6bXJUV0pHSHgrZnVPZHE3cDRDS2VpV0N0d0xPdHh2akFI?=
 =?utf-8?B?Nk1Nd2JZTWRuUWFkeTZ2UFRBcFZxVTNtUmZBNStCdWF4Umk2aHBJNllpd2tH?=
 =?utf-8?B?eXJaZnBzKzE0SWViTWdONWFIMWdEN2tWdEJ2VWpabC83Z2FvQlg3L1B4b0FN?=
 =?utf-8?B?dTBDTVN0NjhIV1ZFNDMxclZoUXc2M3RjaysyQjVyY01wUTEvQkpQazNQT21T?=
 =?utf-8?B?ek5sSGZHYXFRZFY3aVRCSm5zc1BkKzJBTVp5US9TMlJ5Nml2SXdjTllXSmVY?=
 =?utf-8?B?MWFmK1VkUTI3RzAvZzdkYk9HQmN0N3hlWHdLYStHaVdoR1N6eXc4aVBhd0Yv?=
 =?utf-8?B?eWpTY0krTVFNN2g5bmNpTEhwOVFIV2xrUzA1VTl1c09lcXROT01XVVVyR2lG?=
 =?utf-8?B?NklOYmd6Qk1jS3Jndi9vdkxEUGlwREt3Y1hKdUs5RXZGMHNHZUFsNnRYOUVy?=
 =?utf-8?B?cjEvRFFrMHJPVzdoTXdDTlphV0lCWjMwZnRkUWJaOEZXaWxETWswRXJySG13?=
 =?utf-8?B?QzJFYnk3QWNva3ZQM2FnRTVockc1RURReWhBdW5xMXJKb3V3SktKa1A2QzJa?=
 =?utf-8?B?VTZjTDFlWHBrajVQNDRhY1poYnNqNmp2dU84Q3BERkZlTlI3VElmck53a3lz?=
 =?utf-8?B?cW11QWpsMjhQSWRtdVRHRkxVRC8wbDlWUjZaTTBhNkR0SjczUTQ0YUIzTTVT?=
 =?utf-8?B?dE54cnBSM2NmZmRNejVQQTU0RmxhcFlUWEdDeXBOSDd5Nm82SDcxVSsyNHQy?=
 =?utf-8?B?VFZRVFpPVjc4TVRLTjQySnNYd3VhV3p4Q3dYbGNnRHlNdHByaTFIS1p1cERk?=
 =?utf-8?B?SVhlUXcyZENHSHdGY1FVRU1yekk3L0J1dE80d2RrN3dYNkpYcXNOY1h5Mjht?=
 =?utf-8?B?bnVzVUYrWU1xaXVpZ090a29RS0FXZUpVSUR4Wm1zN211VXdiOUlRSU14ZVFn?=
 =?utf-8?B?am1URUV0ZlptQ1JPZ28vSVJtVlg4YUM1SndWaUFBZXJYSnE5ZnZha2pVK1k4?=
 =?utf-8?B?VjZ6UlVMeGZ0WUFDelhWRldjZW5xTmVVeDB1N2REQllIT0xaZmxxVnNHZnIz?=
 =?utf-8?B?QlR2ZlBLQ3ZoSXhtVG5rVXhDaFZyL0tKSVRNT3JzMThKM1Zuclo2cDREWnl1?=
 =?utf-8?B?UUdGS1BYZnpvenhXREdlM29DdWUrNHBwMVZPeDkwZHhBQTVaL1ByTmF3dkFa?=
 =?utf-8?B?clU1alNlaXRLcW4yd0Y5QlRLRWo1WjI5Y29ucHF0R2F5WUlxeHFMMFJrRkIw?=
 =?utf-8?B?d1UrOXBPVTViTnNrbzNNMnNxelRaTDV2WnJHK2Y2cFAzb1RDU2xnVEJodVQr?=
 =?utf-8?B?TWI5aDNEeEpRYWl3VlNmZlBuNXRkamU5aHBmMDZSaXRCdm1XYm1JM21YQSts?=
 =?utf-8?B?TkxuT092VFRtc2lFRUlTb0NtZ0xuUFBFd1N5dGZnVDlSWGw2VXRWa2hyOTlE?=
 =?utf-8?B?SHR4cDdEN3E2cjNJTmt4b2NqemFxaHRRYTRDWFVRSWpocTkwczhNQnZwYnUx?=
 =?utf-8?Q?a60Z7xw4GGs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RC8vVEVZN2VSZzJxRGx3MjMxSkwvN01VQjBYdkd4SFA3NStwbURUNzN2dzly?=
 =?utf-8?B?L1BOb3lOUWZYNE1zUlEwUkpnU1JvQzAzUUJrejFNa0xoVGlrZHo4VTlKTjFQ?=
 =?utf-8?B?OEhyanlkRVdJSzdXbUlQN2VacktReDFSbW5EaXVGZElNYUtsRXNYMmZ2cTlJ?=
 =?utf-8?B?QVQ2L3Nia2ozejhQdzVwbXBvemJqang3RVp0WDh6WnlNQkpOYVBFY3JQYm5Y?=
 =?utf-8?B?TkhhdnZIVmhnTVpueU81dUVxV29tME1qNmwrYmFFL2FQRXpoOWl4ZDdBbFg5?=
 =?utf-8?B?VTFEbHVKb1JxMVJoUVptYzdOczRDVVg4cHFkeThnNmdGS3I4SUxTMldWN2hi?=
 =?utf-8?B?cm5IVUZ3S2Z0NENJdFRsWDdVU0F4NDJXWjVnSlRwelkwVCs1bjNObnp6ZWpK?=
 =?utf-8?B?NldRendtMmg5VnhUZU9ZeWNzVWhIVm5mSERMcENiSmJlK0NyQlIwK2hZYUk1?=
 =?utf-8?B?aEd4MEY0RjRjY1RFVFJtMEhXNnFCSS82ZW85Q1g1OHROZVBLU0Rxb3B6UVZo?=
 =?utf-8?B?M3RXS1NTU2RNYlZTVjIwWjFGQmtIU1NPYWRHR1lRWlpGU0hERDBSQThKdHVr?=
 =?utf-8?B?cXhJUFM1OUIzVktZNTl1TnJjWnkrdEdReExXcjc0MEl4OUhtbnV1WXB5NjEw?=
 =?utf-8?B?dGlnWmFMUk9MaW96TWJnTk9xdUswOFIvTmxTZ09OUHVFVGh2NG11V0lPS2Qz?=
 =?utf-8?B?Ykp5eEdkT0ZCd0o2TkhxRUYxVFRxUlhRYnp4SU9obWhmRVhSWFhEdy8zOW5i?=
 =?utf-8?B?SWxUNmVWZDVGK05PZkxhRDhERWRaY2RaYzJNRlRkNTVUWmV2aHJYSURJb1ps?=
 =?utf-8?B?WUh5Wkx3Qno3ekE5cjM4cUZ6QU0xWjV0cHV2cmZkUTZvdWdDd0VaL3dKUHVJ?=
 =?utf-8?B?RnpFUlpKUlZWK2I4ZUZURitOampqK1Jza1UwZWJnNHJ6c2ZMSTJKdFd4UWNt?=
 =?utf-8?B?V2VSL1hIUzBuR09FT01BVWo3RnFnNWh2WXZRTTN6RHJ0WG04WFJrNytOUnU1?=
 =?utf-8?B?RFFWUXVWR29zUWNXUHNIV1lKQ0dyTEltNHBvYUMzUVVjS0F5SU9tbExDZmJY?=
 =?utf-8?B?TVZkcFRCaWFieDVIWUllMmMzd01qSXV6VUFFYzRjZG9ZdkduQ0QwVE96QU1V?=
 =?utf-8?B?YnJsRFQ4T29La095a1ljSFVhQ3E4bHBGQTYxdkszL3BqNzlDNUgxaVYyTlk2?=
 =?utf-8?B?MXp0U2NTMk0xT09SL1ZsZEFLR3pzMFdkZ0NNb0NHUEVoalBWZEkwbmI5dEJm?=
 =?utf-8?B?RHVQd2JWWE1IS0Y5MmVUWXUvQ2IzRG9XRUlZZjd5cjJldnVQdWZ2SkhQRlF3?=
 =?utf-8?B?SzAvenJFMUN5cWVDRHZvQWljZ1Y0bEVLemUzbEtVWUh3bzVSdWIxUCs4V3JD?=
 =?utf-8?B?aWRtSzVPNkc3cnB6SGN0VTh4T3l5ZFA0YjhCR1FqdG04d0V6VU1RaFo0THVw?=
 =?utf-8?B?eWwzYkZzNmVuenF6MlJVQnVIMllRQ2JlalhWOGVra3ZSSjhZOEZPRW0xRFR3?=
 =?utf-8?B?NTB4NVI2Sk1laERmOXk5MGRGMmJQd21zZjBLNk1JMXkraWVxUGxyUDZXTDZz?=
 =?utf-8?B?a1k1RTl1c2NpS29uMHI1Wk1jMkVyVUJnL2JMcTlUN0Q3b09xOHRSNHBuaWxs?=
 =?utf-8?B?WVBOREhOTVVRRU0rL3E4UFdSWWQrbWtRcFBEUkhRSVdlRkdVOVpaNnMvd1Ri?=
 =?utf-8?B?blM0SGE3MjBDcVljZGF0VTVmUFVCWWR5Z2o5cU84aXpXZ1ZranYyRWtZQkhv?=
 =?utf-8?B?eEkyaGxoYW9EdE94M1NXbVF0dkhCUTJoK1M0RXJKanpQSzV4N21QSVZ4bS9I?=
 =?utf-8?B?Yjg3a0c5eHY5Q0l2bENUTDJ0S1I5N2ZESnc5QXJkcVEwUVZCL3hMNzZrUnNT?=
 =?utf-8?B?MTBKMGhMUUtsblJxRnhGQStRanU0REwyQmE5ZnBlV0EvczdkQXpZUi9mMjQ0?=
 =?utf-8?B?YVA1RmxTeUNZaHpNVFI2b2x0Q0gvQW5SVXEwaWxtTU5PejgraFBia0hIR2lC?=
 =?utf-8?B?TDh0N0NVVlZIbDlWZ2FZbjY4US9yVUVZZ2ZXWEQzY0RPanc0ckdvQWduZG1Y?=
 =?utf-8?B?aGlmUXJuRFp3QVpYdWJseGZQSk5KY2dwSGhLTGxPTE1KcGdJNnVUZ0NjL2xs?=
 =?utf-8?Q?iTv02Ir+Ye7eHRcl7PbDi7C1n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f976fe93-3a0a-4272-cdcd-08ddbf58e45a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 02:24:26.9434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+6F6OZfEoyfBHfeWds/5ybYnfzrQ7ed3Q504Ajk3VAIA55sD0K5SseHD6ntg0VPxOEZ4ByifEVC+sm6v4lhTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132

Add bindings to obtain a PCI device's resource start address, bus/
device function, revision ID and subsystem device and vendor IDs.

These will be used by the nova-core GPU driver which is currently in
development.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Gary Guo <gary@garyguo.net>
Cc: "Björn Roy Baron" <bjorn3_gh@protonmail.com>
Cc: Benno Lossin <lossin@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Trevor Gross <tmgross@umich.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---

Changes for v2:
 - Update comments and add inline compiler hint.
 - Add note for where these will be used.
---
 rust/helpers/pci.c | 10 ++++++++++
 rust/kernel/pci.rs | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
index cd0e6bf2cc4d..59d15bd4bdb1 100644
--- a/rust/helpers/pci.c
+++ b/rust/helpers/pci.c
@@ -12,6 +12,16 @@ void *rust_helper_pci_get_drvdata(struct pci_dev *pdev)
 	return pci_get_drvdata(pdev);
 }
 
+u16 rust_helper_pci_dev_id(struct pci_dev *dev)
+{
+	return PCI_DEVID(dev->bus->number, dev->devfn);
+}
+
+resource_size_t rust_helper_pci_resource_start(struct pci_dev *pdev, int bar)
+{
+	return pci_resource_start(pdev, bar);
+}
+
 resource_size_t rust_helper_pci_resource_len(struct pci_dev *pdev, int bar)
 {
 	return pci_resource_len(pdev, bar);
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 5c35a66a5251..25f5693f32d6 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -386,6 +386,50 @@ pub fn device_id(&self) -> u16 {
         unsafe { (*self.as_raw()).device }
     }
 
+    /// Returns the PCI revision ID.
+    #[inline]
+    pub fn revision_id(&self) -> u8 {
+        // SAFETY: by its type invariant `self.as_raw` is always a valid pointer to a
+        // `struct pci_dev`.
+        unsafe { (*self.as_raw()).revision }
+    }
+
+    /// Returns the PCI bus device/function.
+    #[inline]
+    pub fn dev_id(&self) -> u16 {
+        // SAFETY: by its type invariant `self.as_raw` is always a valid pointer to a
+        // `struct pci_dev`.
+        unsafe { bindings::pci_dev_id(self.as_raw()) }
+    }
+
+    /// Returns the PCI subsystem vendor ID.
+    #[inline]
+    pub fn subsystem_vendor_id(&self) -> u16 {
+        // SAFETY: by its type invariant `self.as_raw` is always a valid pointer to a
+        // `struct pci_dev`.
+        unsafe { (*self.as_raw()).subsystem_vendor }
+    }
+
+    /// Returns the PCI subsystem device ID.
+    #[inline]
+    pub fn subsystem_device_id(&self) -> u16 {
+        // SAFETY: by its type invariant `self.as_raw` is always a valid pointer to a
+        // `struct pci_dev`.
+        unsafe { (*self.as_raw()).subsystem_device }
+    }
+
+    /// Returns the start of the given PCI bar resource.
+    pub fn resource_start(&self, bar: u32) -> Result<bindings::resource_size_t> {
+        if !Bar::index_is_valid(bar) {
+            return Err(EINVAL);
+        }
+
+        // SAFETY:
+        // - `bar` is a valid bar number, as guaranteed by the above call to `Bar::index_is_valid`,
+        // - by its type invariant `self.as_raw` is always a valid pointer to a `struct pci_dev`.
+        Ok(unsafe { bindings::pci_resource_start(self.as_raw(), bar.try_into()?) })
+    }
+
     /// Returns the size of the given PCI bar resource.
     pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
         if !Bar::index_is_valid(bar) {
-- 
2.47.2


