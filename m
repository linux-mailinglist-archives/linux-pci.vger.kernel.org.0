Return-Path: <linux-pci+bounces-33145-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B437B156FD
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 03:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC2716901A
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 01:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43A218BC0C;
	Wed, 30 Jul 2025 01:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ouWggF4p"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1751F1531C1;
	Wed, 30 Jul 2025 01:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753839269; cv=fail; b=MoofZhCuOeVzV+evFa0GZUec7v2iQvCXJN2a/DPmrslpdXdW0apTTSBTi8iFLwNOn05URYXmOuwlFuF/7kCX9hsv6XWUErPCc8VFzlXpinSbBJHfd2EbONEqBxSh7s+vWErny8TVWXhXAJXRhavBRL0j4Ys0bgfqIdeIf4sLIAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753839269; c=relaxed/simple;
	bh=+i09OvXg7VeRkoKNWD4EpgXgj5tk974QBzaVwz1EDTg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=R49vPuzSKkI0s1OpXG6Vo7eyce5677AU6fIrjz/9pvrwSxv8higV57/NpoV1Jf9wquRrqaK1shVneVcBS2ouxGfx9jcdp9ghagojUgAivCfBQYt2ZcrMEJalWi4fANimc84PZJlva9E9bY15P7QEOvgeE1JrTZ1qh74Ofz2qdBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ouWggF4p; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbE21Gy/Wj2W3xPTgIIqfXfaKX4Y2jJFKxhbh5QfyQZIXeSHNtLLDE4tN+0vEzXUznT1ogP3ctuNOycGWM1GaVx6Sq6x9Z7J2az3xxSIbx768KAb/MEi0oB667rQFpLksUcmBZ+kzvInksrR4g6DDuVwhZnkl4uX+FoDUqp4+Su/T8gsqvl0r0HJG2YcjRg2DRztP1X0JibFH3kKriw7vH0r4XncpB7L/a2Z9EczllGavwn9Zzat71LtwpM5O4KT7Ou9bZusgYoLFwnh6m0RCHiC944MAoxMeQY1k6tAtXlEPtsTU1VkO2Mw1lyoaPVmp3P9EG7ddi1TLhT6sSgSFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SpLPFftw4E+/cYoQGFHO92l9ig01PgBuSnuWgJ9XpI=;
 b=NxlBtbNwCBnwzCX1LnVJuYktCnllxHOST/R48vgmEkftXZ2w9k9TmYVotH2fe4C+Dv6ADIWReuoNVn71z3cZe2KJctwVNhuRgYq0r41Ksg9zv0u6V/q91tomz6SxJB9hdngdDgSMkUNdBtYcPyEuXDydX7bjkP6wl8j0FehGl3y7J8ql0g2rty8q3NngIqou979h8XIkS+C3H0mVUTl6xW11cFeDV9NBxP73ciO7XRkkFCYZjk3DDiavp/o5um9BVPB/FXmV+O09UDflyTrnykm3vlKEp5aY6WKH2UuesAL8MZNAJRY7n9EOimYCByC47W8nvUqWdJes5PXriKyyog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SpLPFftw4E+/cYoQGFHO92l9ig01PgBuSnuWgJ9XpI=;
 b=ouWggF4pq4bJSce4IqENoJJ3iiMku9Y3q7EioAhE2yQ52rBwKWfoCEXy+bAweX+0U3y1MsAZy08zdoL+DXbpM86vD4cM/40Yc+gk2iOQgz6d/yomgAOC+eLEb1JSh9j2cWbhPNQ6P1SWdSGg0qNbWYimxJ/smnOaJAiRbwDRFTsWsWSK967QTrU9bLzmhBQpEzzyeIcsfRnWbeyLdA0Rnt5jGaUEm4el6Y8+YgG6QkYESLufq6iO7cV06xRuFOra9kaITn0Q8PqLLO6qOAOOLeycCE7LGDdmiH+26l1YjhY0cDH7fQHhHMjGSm/56/mFyz8sTH1okn9mpIkw4+HpOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.11; Wed, 30 Jul 2025 01:34:25 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%3]) with mapi id 15.20.8964.024; Wed, 30 Jul 2025
 01:34:25 +0000
From: Alistair Popple <apopple@nvidia.com>
To: rust-for-linux@vger.kernel.org
Cc: Alistair Popple <apopple@nvidia.com>,
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
	Alexandre Courbot <acourbot@nvidia.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] rust: Update PCI binding safety comments and add inline compiler hint
Date: Wed, 30 Jul 2025 11:34:16 +1000
Message-ID: <20250730013417.640593-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MEWPR01CA0243.ausprd01.prod.outlook.com
 (2603:10c6:220:1ef::9) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SN7PR12MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d820cd-d752-4fce-3c3d-08ddcf09379d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmhqREhscHRmT0NvV1ZxSk1xdTVoOFJucVNCM0czSlVyMHlVSXhZMmtvYU1h?=
 =?utf-8?B?a1BxYmMyQjhUU3BHOTlueDJCTVgxQXltd0syZFZQNSt4alZMaU5HMUdsMUhB?=
 =?utf-8?B?aWtmdjYxVExYSjVZQ0V2bThUQm0xSHl1NVdtN2ozb3EvenBiUjk0aTlKMlZa?=
 =?utf-8?B?bkd2SHM3UjB2T1R6ZjNEY3dhUUQ2U0NsVUdBQ056d3JFZzdoZEFQUWpLZkp6?=
 =?utf-8?B?cHpiamVYSktrbVFYcGVNcUlaN2g0ZTAvZTFZYXhxWEZhYThtK0N4cjlnL0w5?=
 =?utf-8?B?VDMva0NmK3d6ak4raStTMmMrWWVFZVg0eS9Ja3FoZHBEMkFDYnBxYjgzMHIw?=
 =?utf-8?B?dmgzMjA5NzdzMElqNjVDbkhtRkswRUxlWEhiR1p5bXRwVytTc2xiaVk5aU42?=
 =?utf-8?B?eFdENnNrZ1h6OTVVMGp2MWlKTFNmbjY4cFhMRERqREtYeEZUS2pLbkRFZ1h0?=
 =?utf-8?B?aHNBTXE1dk84NzN3NkNkQkZrVWZKdlUyMngrWVpLSitoajdzZzFyekxQckF4?=
 =?utf-8?B?R1pBdG9yVzJYRWxnM0ZGeklXVmJZWkZscHBiODRLSktBS04zRlU0QkpSbjJz?=
 =?utf-8?B?ZWkzanlnSjk1MzlveU5SbjdkbWVFVFE4anY5U3YwcXo2ZE4wZ2g4aTFZWDRI?=
 =?utf-8?B?NXREUXFqYmZVck5Ocnd1WFRidVJVdWtUUUtoN3J1RE9LVGtMMCs2YWtMM2tk?=
 =?utf-8?B?QnJ2Q0tCRTJVNUxjYUlPeUpGNnpkL2lTL2FSakE5SjZDaG01cXNqQ0RvSW41?=
 =?utf-8?B?QVJTZTBHV01ITjFIOVNsZGI2eFNEVFlNSFNUSjRDdXZvVzJCbTVCNTA5TDRY?=
 =?utf-8?B?RXFHelZBN3Uya0hWOWxRYUJpVjdpZWtBUkJuZ25LWnlCNVpSME1pOTNyZWh0?=
 =?utf-8?B?WVg4TkdUOFMvQ3RWNDg5RzlacE5BcFdwVW1YbUE3ZXpvV0pGODJRSzF6Q3JO?=
 =?utf-8?B?bG5ENStnR0ptNDJCbWdrbDJyaitLbWswaGtnN2R2SXZrYWFBUTJ5ejNBV3B3?=
 =?utf-8?B?bjhKRGo3Mm5oTUlVbVI0M0hNTVpzblYyOFYybFFXN2FCRGdHbDIzMU5UWmpN?=
 =?utf-8?B?aDZic21YbkovczVkNHFyMmtzRlFuUVdPL3JmN1NXSzhhOE44KzZHdWZYTGdh?=
 =?utf-8?B?aDMvKzRvQTVYL1lFRnhSdHcxd1pQWU5iWVJhSHlwbk5sekVkYmVaWk13akFo?=
 =?utf-8?B?QzloL0hDbU8yVW41Ui9ha1Y5OEd4eHZ3Ri91Qk9RbWg0SmxFTjhGbEhSYmdh?=
 =?utf-8?B?bkJLeEV5U085MG9oUnluRysySjdxTUJQeFcwM3hUbDZDdHloVlpaOW9vTTd3?=
 =?utf-8?B?T0NwUWVvK0VKQldsbERFaENGOHl0M2RGRHJHWDVsZVI3R3d5b2pyVUMxREhM?=
 =?utf-8?B?VzllSUw3ejh4STZscUErdWRYNmsxdENRMFpSZE9lVVJQbnQ4OWtaVU9ISG1K?=
 =?utf-8?B?UUR1R0VnRDRCZWNTc0ExMU0rR0JSclJka3lIWjk1M0dMcWpYeHoyVmxVa0h3?=
 =?utf-8?B?a3l0S1RVMGliTXM5emhpSmhma0xLY24rMjIwRmx1Vlk1ejNNU1lsalQzbWhT?=
 =?utf-8?B?L2lMNG9Pc2FHOWJHeThrTkg3eU5pMnBNUHJIVDdUS09TR1VFK3NLNVhTVlRO?=
 =?utf-8?B?ZUpaZm5rSkRubjBxNnZ4S25kTStDbXhJeVVYakVmNlgwRjZoMzZTejZ0VWxO?=
 =?utf-8?B?VVlTbXBHd3ZmSlBKZVR6OG43cmF0MEMzQUxHOWpzTTVNQWhqUFlYbWdEMkp5?=
 =?utf-8?B?QlRsU3pZWGI3dW91RXUwY1U0ZmphZi9SK0tLMEhxY0VyVkYvb09uQnc2dUp6?=
 =?utf-8?B?SWhwN1BYSlFaRlk0NEloZDUyczZsSWluYmJxYVBHem1wVzA4Y3o1UGNGbjRX?=
 =?utf-8?B?ZG45a1NwazZPQmJBd2kva3RMTkswNUFJWnZxVUhRUTNhYldUNHBCWWFZajVV?=
 =?utf-8?Q?PXgbXm4/3kY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REd4aENueS8wN3djSEpRTTFlOHdtV25RdDdsR1p0Rkd2ZU9jcHFHYW10c3k1?=
 =?utf-8?B?anhjT1pHZDdXS0RlL3hWTGNwY1ZWSTcxSnN3b2NQR1RMZUFHZ01BK1E2VWww?=
 =?utf-8?B?NWFyQitYaFQ4OGcyNm1tR3d2L3BaUzJadWljTVNHMmpyQ0l0RldjdXVJN3FK?=
 =?utf-8?B?eVU3dFk2VldaMDhKWXMyNWkvZ1E5eVBJanllWDBFUU1mbTFZRTNQVWpQUFFJ?=
 =?utf-8?B?WktZS0tuN00zVnR1ek5JdmYxT1h0VkkvRTNwUGllLzAxbk4rVmEwSEhISzZq?=
 =?utf-8?B?UHgweG51eS9yUERkTjBDYmorMGRqRzU2VGwybGpnQzRIZXNPZWc2cVo2K2x1?=
 =?utf-8?B?OHdhRzZmZTJBRndiVHVNcUxHZmdQejI2MmhtYjNvWFQwYmlReHhsRDNDTXQ1?=
 =?utf-8?B?SHhlRWs3MXFNc3NQWUpPRkxLNnBKam12cm8wVTZJL1FqMG9CTHhTWFZrMDRa?=
 =?utf-8?B?ZTR3bnFPWWc2TjR0TDRZMHBZK1RLVTdBNDNPTmVYOEpqb1FiSitsYmV5QmVp?=
 =?utf-8?B?dmcrQjVwU01CdWptbmlaTVhjaTlVQkxkc0ZoUzNwQ211U1g5bEhTQVR5cmtY?=
 =?utf-8?B?VzF2cXlpTmJ0Qy9OMG9RUnlwK2lRcXcrcUdPUjRxeE9jSXU1YlVlUE12U3FM?=
 =?utf-8?B?bWhIWnM2ZzZsdnZ1NXdlQlhCam1aNElCZzRzQTRCTVlwWXN6ZnptL3pzVGxH?=
 =?utf-8?B?cCtETHBUWkp2RGhsNlJ3REprN09LMnBycE1WLzg5cVFPTFFEZkdGR2F5Lys2?=
 =?utf-8?B?WGtoWWJVRVhkUEFha0RUMXp2U25zeFRYT0ErQ2libDdqWXBYbGJZbkN6NzlR?=
 =?utf-8?B?OHZScmVIeHFHSW5GMVk4ek1TVkVrVjI3NG9OKzFOQ0ErcUZmVEhVMml4RS9S?=
 =?utf-8?B?U3RhRk96YkpwV3FnU1ZZa3VBRzFnVTlGYXhlTmlRYWdicVpFMUVrVlBDZ0NV?=
 =?utf-8?B?TkhhMHRJbDhoaXl6TUZzRlhjT0MybEp5VDM1Zyt4L2NCdnBERG92UURuM1Fo?=
 =?utf-8?B?ZDQ3bFBjdHFkN3ZaMGFUS1FMUSt4VlF2bkNYWmNCQVpaTnFjOHNKNWRrMi9R?=
 =?utf-8?B?YzJxK2luWUozdksveUE2Mk5KQ1ZNdUhhRXZjYjNmYVVOMzIzaVF6T2NVQ0Qw?=
 =?utf-8?B?Zk5Hb0xjU1REMk1rNDdqeWtVRDkyNUdqd2ZTOGNTVVV3RkFPd2JqMmdXcUdq?=
 =?utf-8?B?eHAyK0RYdW54UEJ5bTJaM0VBZFZXWXZtT01yZG5JTWpnaEdlWkZQQjlJV1Iv?=
 =?utf-8?B?bFA0ZEFuY0Z0bU5FZExPaGFFVXlpUm9iS0hNbHpBSkVaMWlxRk5sNmE4T09P?=
 =?utf-8?B?M3RWb3dtSVFPcFoxby9lSlgwNzFqb3FzcGNqdWc3cFMvR2hNMkJ3bldNbG1k?=
 =?utf-8?B?citkeEpmOFJ3Q2IyZ0c1R0NmRUlpQkZHRStyV2d0dnJnSERGdnRaTTB3MzUz?=
 =?utf-8?B?emkrb3JJL3IvUnU1WjV0OCtTTjNNWG83VWlwN2l5dHZ4c0d6MWN1dXRwS1M1?=
 =?utf-8?B?YXhueVBnRHhua2cxd1VuaEdmUS9CcjYzOEFUKzE5TXFZa2t3UVlXUm9pTXQz?=
 =?utf-8?B?NnJTd05ZTURYUFQvLzZQMkF5NXZVSDdvNkJZMjlITk5yQmpFUFdEbmFhR2RI?=
 =?utf-8?B?bTJxOFlsN0MxWVR2aVJDREpiVHhqN2xSdFgzMm1WaDNzRjcrZVJtWU1XTlRF?=
 =?utf-8?B?STBZVTlrNm5CL3NZMzF6bktvNHIzdkVJMTM4L0VydmJZOTA3UEhrQTM1ZTEy?=
 =?utf-8?B?SHN2dm0rMVpKdExCZEFHZmM2N3BTTU4xNDdicVNWVlJXcmg2SWtkM0t6d3JO?=
 =?utf-8?B?dzNLZUR2Rm5SU0M2V2ZleituMjNKVTJpbUh1UUxTUXpvN0d3S095NHVhNWdl?=
 =?utf-8?B?OXY0M3FUaWZQdzNtcHZLRWdlMDMvRnRmTkppa2lqZ3FtVVZaWUNNUlVuMVVN?=
 =?utf-8?B?MjJrN0hYNzNMV1NPZ25nN2xqK1FCVUtBM1ZHbzlEb1hrSklJQlR4TFBzSlJi?=
 =?utf-8?B?VXVHSHpFdHBISGx1ZG5meC9LUVNYY1kyYUlhZGVBVWFLVzJpb2Z3WHdHMS8z?=
 =?utf-8?B?c2ljUVI5V245RGZ0Qnl0T0NFUnhKVTQwTGZvSU8vNXVBWnp4bHBUd08vQlpO?=
 =?utf-8?Q?rHy8YNR9W1gUAizAzrw/Y0xgQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d820cd-d752-4fce-3c3d-08ddcf09379d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 01:34:25.2550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/MRFFTkYgHFhikDxe58jF8iMjHqCkrRgm8R1hlcRLgEGaIdKZ8FxEI0gxhSbSaZlZAyw6euRMfhZgk3vkJO+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8147

Update the safety comments to be consistent with other safety comments
in the PCI bindings. Also add an inline compiler hint.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Krzysztof Wilczyński <kwilczynski@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Gary Guo <gary@garyguo.net>
Cc: Björn Roy Baron <bjorn3_gh@protonmail.com>
Cc: Benno Lossin <lossin@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Trevor Gross <tmgross@umich.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes for v3:

 - Updated capitalisation of SAFETY comments
---
 rust/kernel/pci.rs | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 8435f8132e381..7da1712398938 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -371,14 +371,18 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
 
 impl Device {
     /// Returns the PCI vendor ID.
+    #[inline]
     pub fn vendor_id(&self) -> u16 {
-        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        // SAFETY: By its type invariant `self.as_raw` is always a valid pointer to a
+        // `struct pci_dev`.
         unsafe { (*self.as_raw()).vendor }
     }
 
     /// Returns the PCI device ID.
+    #[inline]
     pub fn device_id(&self) -> u16 {
-        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        // SAFETY: By its type invariant `self.as_raw` is always a valid pointer to a
+        // `struct pci_dev`.
         unsafe { (*self.as_raw()).device }
     }
 
-- 
2.47.2


