Return-Path: <linux-pci+bounces-37726-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4500DBC6528
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 20:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E88189D2E5
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 18:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CBC1E834B;
	Wed,  8 Oct 2025 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KOehvsgo"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1027F79CD;
	Wed,  8 Oct 2025 18:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759949158; cv=fail; b=Jog+Np8CS/cFhbxfNl8z/vloK2a8EDtTqw+L2Iy4Ut2jatoCVe8BE1uNpnmXrL52OLIpFR8ixC2ixuzd2OWQ63aDhtBbLR9r7R2X/hXR9JJtXmJ5umK+kUkQWHrbI4Lq7rxFHq511lNLNG7BDuHCs/RvIk3wfrEcnGkcJ1gRWLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759949158; c=relaxed/simple;
	bh=D8N6RhE58oCMzJfdHpd9ejhsUbxpmiGCZlRAT4tKOnQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kuGzwZg3MIgEOEjTWI8YBV7r6z+TWNSBb8syZ6hbEooTJWFle6wOE8jmt+Hl1cNYaSgT5S4E/X/ycbXiPHXTCclekCnJbXDm3WSgIg97g6mlv/rDnDVftgju+zgjcL8rFn/Jie8C78yE9Xf0zhh/0GRo+OUSNdLOMVLZDFFd4dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KOehvsgo; arc=fail smtp.client-ip=52.101.52.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmQ+zEc9ONWglkPVQZCvR0zq0zDUOx7spiojG1Vv7D9RDhvcJsxx1CxSC6cU6SQgWQDxGSoTyjPfV52v/C3dPmSnVNPF+U+qj57yRPerlMatBiQTRiMhFKSMfGQL5a6LxLY+PuZfeTrMbNCtMOq/hkO1PiT/fQKY5ZB9/K/OEffkQS/fb/zEBhV31RLnxAvo8vxLEWYryHLjq7SLBsf43owH4mCuB/1J48z4bcXFJ7d6zDly7g2PpullQUrGYP6lIqJD0FuEsO0vw0RDVJSUWl7iEbpmGx1p+OTel/ghUJf20CRcJtE6rhsmC4PSvzvP/mKa5+4QXjFHiP38UJjjsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Un0f6hReUBUKQE3NZVfqf/poZCT7CJMXQSyxgEtsFGo=;
 b=jVi+jcFCgR4lnhFpjzGXuPoWAhz0tYzffvIjpNyKOKDzM6CoAYkVbhtgD59xwRP3vLBhK9Gmy6qrc1BmqyWQ5CKI0QMj9WT04BVbmKlNneFZhQMl2IxHP1yT+jEwYfVBrr1vphAQnAwoqIQf29bVr/YhVi5WwdO8Lbp2PbzquEd7rVuuE7rbliE0z2FacRcDzg7wzCBJG/gww8j2++Koq02TioTO5EvWPd7VOd+vsxUU5MGx/dGNGn+ae7HP3KERcvrZZ41XBFi/jzBsNQ0QJDsh0Zgis6ITt7vVU1zyxqoeB0l0Cv7QF0azFHMaGrs+bt24MP/fZTathZ4dpNFytA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Un0f6hReUBUKQE3NZVfqf/poZCT7CJMXQSyxgEtsFGo=;
 b=KOehvsgoU/DL0pkp8lUHk9LYqkYOdJXU4Gy6XkKyQX17LsI5f6uXdZcbIpslyJzDDSbf64MxQ4hMVQeuoVTfQR5XRd5wFJXEmq1Q4nE1v0Hf3yjJPQEJPau89sUSKwQ2zv1Ex5lx/CuzInW4+wR/9BG2C8HS1DjzfMd8Qu4ol2SI08hkHA7y34YVIXWPfTTG1TuMYmCwtlnqVMqquq1NkeEJ+Ca7v6bo8vuCQy3ImFLbsbwJdrnEeLVhK70PL9t9u40Xw3alK5meXiGKphC/6hSggv95uzQhL22jBYVfQnhkig8j9M8e5fYo4OvuJrlPNpZsdL/T3fxXdDl8Re2NUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CY5PR12MB6384.namprd12.prod.outlook.com (2603:10b6:930:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 18:45:53 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 18:45:53 +0000
Message-ID: <58a26b94-bf06-413e-a61c-2e0d71de2ac7@nvidia.com>
Date: Wed, 8 Oct 2025 14:45:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: pci: Allocate and manage PCI interrupt vectors
To: Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org, acourbot@nvidia.com,
 Alistair Popple <apopple@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, John Hubbard <jhubbard@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, joel@joelfernandes.org,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
References: <20251002183912.1096508-1-joelagnelf@nvidia.com>
 <DDAEL8DQFWKX.1BSBDMMN9I5B0@kernel.org>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <DDAEL8DQFWKX.1BSBDMMN9I5B0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:208:335::25) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CY5PR12MB6384:EE_
X-MS-Office365-Filtering-Correlation-Id: 43542f72-7cb3-49bf-3cf6-08de069ae87d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXdPanZsZW1kMk5iQ3puWkUrSE9vajBnMEtmQWNPb2lPLzlHcndMY3lOb0U5?=
 =?utf-8?B?WEVqVmtQdDhyL25WSjJ5OHo0N3gvWjFKWlRlcmQ3V24zL09aanJDbldJR0w1?=
 =?utf-8?B?Ry9DN0QweFJzS2tTRkY3Mk14RW5iYzVYWFN4RW5XNUI0c3MzN294d0dkSmo4?=
 =?utf-8?B?UmxTV0lSRFIvb0RmZmx0Q3U2L0c5K1ZpTDVaLyswdzBqVkpLNnJSc1h3TXY4?=
 =?utf-8?B?bk9SdElYdU1kWEs3Wk01Zng5citpUGlPUkY0YUtSR0NqZWNpajBQcFdDaVVr?=
 =?utf-8?B?eEJsTEo2SXkxYXBlRHI2SUhoMnMxWFNWdWtpS0krc2FJbWh4YlpEekROVFRR?=
 =?utf-8?B?TGpSd3JrMU9xRXF0OVlUdGQ3aGt4amYzeGsrdjd6ZE81U0I1cjRsOFFPeWlv?=
 =?utf-8?B?VFVLRzdJT1kvbjdSRFBLY0ozamVjdkhocmgwUVVqcWE1cncySzhWbUd4c2Zo?=
 =?utf-8?B?djRMcndvRU1ucHM3cFhibDJ5aSszYVBscW9WelUxOFFkTFpzK1dEYzNCeTBh?=
 =?utf-8?B?SmkwUXhnQkVhYXUyYmlCOFh0NzFCeHRYVWNsbzYyNTVJS3k4Umo2VnpodTdM?=
 =?utf-8?B?V205S2t0RzJmSE41RWl2Zzk0ZitMb1BpTVpseGplUHE5Z0tYZHhrRFBINEpG?=
 =?utf-8?B?UTdjOGR5KzhiaXg2WGx2RDl1Z3RCWmVRbHU3OUJYQVA4WlZQeiswNW1NckFw?=
 =?utf-8?B?dFBIWVJjeitFM0JJRFUweFRIU0hNa29iNFk5dkFqTWh3Ty9NQXpLMFNlN1ZQ?=
 =?utf-8?B?ZDRoY3FsRDNQNGFXUzlWLzhGNlNod0hlZ2NmUEFockROWVpxYlBYRGgwTzA1?=
 =?utf-8?B?VUZtaE5TaVFkSkFpUHlDbklSMFREeWJDUkpRbHJieDBjQkVJZHVXRy9zNWpw?=
 =?utf-8?B?eTJMODB1ZXVEVUpsTTBiS2JraGVkRGc1eHJ4a1lzNFh3cGdGdis0ZktYbm4v?=
 =?utf-8?B?V3FLMXRIdFZxQkY2REJXdGdmUklGZUd0SGJxVURETWlEbXdVK3ErUEowMVlj?=
 =?utf-8?B?S1Z0ZE5rM1lsY2J6Q2pHR3hSM09BckNqVGovN0tHZi9wdkJqUC9uV2hNSXhJ?=
 =?utf-8?B?WTMzeHN5RlF5RlZNcjRRdURRVFpBR3psaFpIUEJQWFVHdFl0VW80Qm1udktS?=
 =?utf-8?B?dzJWSmt0WFNJUWxIMVRkYlFhTFF3OHh4TE01RUZ6bFRkK2tDRWFKKy8rYi9I?=
 =?utf-8?B?dE9JRUltTTREbnpPb1ZmUnozajB2UGR6VFlnSmtMZ05ZcE1IaWZKVUwxNjVL?=
 =?utf-8?B?UjJkdEtJdlJtZDQrcHR0enVPdG4vR3V2MjVaVlZZM2V0ZUdqZ1FJM0hpTW1Y?=
 =?utf-8?B?SnpzYU1qaHlpUjlKNklhK29ra1ZwMlc0UUxjeUlSVjdnaHo0aVNYM2d6dHFK?=
 =?utf-8?B?VkdHOTdNaVdRdmhwTWRZSGdXZUhieUNZSmNiSytBaE9mS0RPWHhLZ3c2N1Fk?=
 =?utf-8?B?SlgydHdHNVNSclNla3RZS2tGcFpYVFZkTnhaUHg1cFljcEpQRDhLbmtrblc4?=
 =?utf-8?B?WUg2a2h2L0NuYkNtdHdhd1BVSFhkSmtWTkNrRjdwL3M1ZUhwaDk2MlZockZG?=
 =?utf-8?B?dUZESjZYc2k5dnh4ODN2TXlSQ0w4VE1XMFUwdTV4ZWlyaXBGZW12NmFzR1lM?=
 =?utf-8?B?bUF0dmNWdU9JbWptYkFrczYvaWZ4OGZDVXI3OS9vakl2dEV5VnAzckdTTUtT?=
 =?utf-8?B?a0dOTnBOelNaK0s3Z2tVa1VWa2hSMG9ya3lKYWduMHorRmw2cHRLTkxqRnJx?=
 =?utf-8?B?TDJvRlVnejdEdGZFanI0dXY3ZjB6TFE2WXRJQXZYUjEwbzRSd05NOUw0RlBP?=
 =?utf-8?B?d1NIU0phUHdNWHVHUEdDQUNGY0ZCRUxJSXYrcnZKUG1USXY2bUJEVHdoYktt?=
 =?utf-8?B?S1FweExHWlRKZ1k4SEY1bDA4UmpxaVdoQmt6UXNOcXdNK051ZWZGTXZGVytk?=
 =?utf-8?Q?BtBya4HL0RvaGUlGpljmjzx6N6U3mp18?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjB6Z2I1OWJacjhtOFBkblVPbndYQVhxT285c0NKaWlvZW1PamJ1eEg2Uzlq?=
 =?utf-8?B?TnVlRm5tbnY4dmdUbGw3Ukc3bzNDeWRXMkMyMzlpU0d4Y0VHUmk4WG5ZUzl3?=
 =?utf-8?B?SEsxVDErM1RHNHlyLy9nNUxINjZuWHY4cVVVUndtcHA3YUFsbnNOOHd3RnR1?=
 =?utf-8?B?WGdvTEk2cEtwNFZ2enl6M2ErRExiejkxK3dlNkJqa2xSdE9uKzZ3Y0p3aVdm?=
 =?utf-8?B?U2NXS1lKRnUzdkg3RnBvc05VWFdUOW14M0lRV2pXWi9ROU1yWUh4NVBtaGVh?=
 =?utf-8?B?UEhYMkpFUmJBY3htYkMxQlUxQ3Q5eENmblNQUXpRQ3pMa25kVm9zRDRhUkM2?=
 =?utf-8?B?UzFQTXA1aGpSblZaZUkvVGxudElaYnVYOVNnaFNHMVpkTnVkZDFlSzVVYURT?=
 =?utf-8?B?Rkh1TjB2ZmRDRmFSWE4zQUtQUkNsay9LNFZteCttUXFUdnp5U0ZBa0tVYkZ6?=
 =?utf-8?B?QU1LTGpNei9RM1dnZVozZ0RUQkpHY21FUThua2VQVS9OM2wrMWdsNTlwNUN2?=
 =?utf-8?B?TXYzTDdCOVNlVWhUK0xLOWhvaVVycHp2eEZIQUNxRHRLN0w5UGlsOUZpdGFp?=
 =?utf-8?B?bnhZZlNhWHFDNzZCcnVUMFZxa3B4QythblFieEdRREFRS3cwVG5mYTgyWlBv?=
 =?utf-8?B?aCtCNVN6WFY4YXI4anNyVkxNUjNjcnBnZWpPZFJpLy9kdHdkbG1xTHBHaUJJ?=
 =?utf-8?B?RWFZTFo5cHpqaVBYeE5VOEYvK2N6VFh5VWdkMWJiWEpyQ1UxM05HLzVRWVky?=
 =?utf-8?B?cTFlN0NvbStKdlJIaEZscUZUdEdLK1l6N3RFRitTajdGeEIrWDNuWHhjRkFW?=
 =?utf-8?B?cHJRaVBZVHBlNEtnYmY4czI3RDNSSzhQM201d2hxa1lyL0tMcUEzWnZlTnJl?=
 =?utf-8?B?T3hJUmNDbG9WcnJaY1pKZXQ5WHNmcG9XYzlUb1BOSE1NMFloVTZ3dHJKYVBq?=
 =?utf-8?B?NnU2d1ppK2NyRUVacnQ0TXZtaWxod0dKRlJDWWtPdXFtQTlhMnhnS1h2TVRy?=
 =?utf-8?B?bUM2azEyVG1URlNWTmJ0bXlSZjhGcVdCNFlUS1pONnR5RHlrRERhcGUycmtC?=
 =?utf-8?B?UjJaWnBWTXF1ZUZxMjFvNysyNzlQbU0ydURrTzNTY0N4WmlmQit6UmdvSWFx?=
 =?utf-8?B?OFR5cFZGRlZGdDFEUndDNUM2WUZNWFM2QUljVWk2d3IvTElnY1JGUllZMWVp?=
 =?utf-8?B?cFV3MnozM1NoZXc1VnNmVGd3eTFqMFAxRkc4aDkyYldIQXhHY1F2d043cVlB?=
 =?utf-8?B?UVp5TlBEdGNRRkkxbFZEOTd5Y3NzS2d5SzdGeVBYNE5XYmRnZWN6cGwwcFR3?=
 =?utf-8?B?K3BVd0Fzd2pYUWROVkJGa2k1anZtZnNLZXp0TTU3dFAvVjJDMHhFSlhUQmd2?=
 =?utf-8?B?OERvby9zLy8rS2JEWWR5RldMNXlGNUVDOUpGeVNFREg0cDFiVFlpdzVWOExn?=
 =?utf-8?B?akxqS0s1YWQ3bGlRL1RmVUQ0M3RTbWREUFVKczRwQWxmSnhKMDdyTGJrOWVD?=
 =?utf-8?B?bzRNeC9UR3pTRXFjUUVhZnZyWHU5Y2dWUTRWemhDQzZKdFVzdTVoWnp5dlJh?=
 =?utf-8?B?OWZnZy9qZzlRZjdSazRpUXNGY2Z6bkRIZjVncGxERUIxYWFCQ0JaNXR2QTdv?=
 =?utf-8?B?Tlc5bVI2d0JCNWhmY0xUNkZFYi9teUtyK2VkclZIbVJ2K3VtL1hWSkNSeUJN?=
 =?utf-8?B?cjdtWHR5QTM1NXBaeGI2Rjh4SWpmTmNUSnlnMmFBZDJoRVYrbExTaS9TVytK?=
 =?utf-8?B?cHk4WnhPSUlUMEJlNElHL20xekpGVHNOMGJTWlpIbnlIbkJaYmM5YysxZCtP?=
 =?utf-8?B?T2Era2RibFNKZGhXbENzcVpCSUNZS2tyaUtQdDZaVzdySzVNZ2YxUkcyN2x4?=
 =?utf-8?B?NU5HKzNjZXFWUWcycjM5SE5aenZ2K0pTczFPR2hRa2RoTkNkZ2xRWkJ4SDRR?=
 =?utf-8?B?RHlDSHRWMW9yYWphd0EreEx1WWR6NjdDVlkzR0VNTHNmTWRkYkcxZGxmT0ZH?=
 =?utf-8?B?NE5acmxjbzBITVhpdGJYdTJCVit1WHJqbFRySTRVdkdCbnpzaE9RaXRPakVG?=
 =?utf-8?B?YWdySnB5Z3RBeVA2cUpFV1F0a2M4UlYvekFpSklSaFRucWIrc1BTSXBZTUJr?=
 =?utf-8?B?a0U0OVd3dUltMnMwSzlQay9lMGUxbE4zK2RYek9QU2s1ZlpGb2F5SE5OdExI?=
 =?utf-8?B?Z0E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43542f72-7cb3-49bf-3cf6-08de069ae87d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 18:45:52.9829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jBnbN2HWf4oBwBNM3bbXRjJN8e2A/uvTDeRAvMQu6uQxKIviT+Wo4gdKho9s6Wwu7effXuGperpzrfiXe31pUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6384

Hi Danilo,

On 10/5/2025 8:56 AM, Danilo Krummrich wrote:
> 
>> +    /// Allocate IRQ vectors for this PCI device with automatic cleanup.
>> +    ///
>> +    /// Allocates between `min_vecs` and `max_vecs` interrupt vectors for the device.
>> +    /// The allocation will use MSI-X, MSI, or legacy interrupts based on the `irq_types`
>> +    /// parameter and hardware capabilities. When multiple types are specified, the kernel
>> +    /// will try them in order of preference: MSI-X first, then MSI, then legacy interrupts.
>> +    ///
>> +    /// The allocated vectors are automatically freed when the device is unbound, using the
>> +    /// devres (device resource management) system.
>> +    ///
>> +    /// # Arguments
>> +    ///
>> +    /// * `min_vecs` - Minimum number of vectors required
>> +    /// * `max_vecs` - Maximum number of vectors to allocate
>> +    /// * `irq_types` - Types of interrupts that can be used
>> +    ///
>> +    /// # Returns
>> +    ///
>> +    /// Returns a range of IRQ vectors that were successfully allocated, or an error if the
>> +    /// allocation fails or cannot meet the minimum requirement.
>> +    ///
>> +    /// # Examples
>> +    ///
>> +    /// ```ignore
>> +    /// // Allocate using any available interrupt type in the order mentioned above.
>> +    /// let vectors = dev.alloc_irq_vectors(1, 32, IrqTypes::all())?;
>> +    ///
>> +    /// // Allocate MSI or MSI-X only (no legacy interrupts)
>> +    /// let msi_only = IrqTypes::default()
>> +    ///     .with(IrqType::Msi)
>> +    ///     .with(IrqType::MsiX);
>> +    /// let vectors = dev.alloc_irq_vectors(4, 16, msi_only)?;
>> +    /// ```
>> +    pub fn alloc_irq_vectors(
>> +        &self,
>> +        min_vecs: u32,
>> +        max_vecs: u32,
>> +        irq_types: IrqTypes,
>> +    ) -> Result<RangeInclusive<IrqVector<'_>>> {
>> +        let (irq_vecs, range) = IrqVectorRegistration::new(self, min_vecs, max_vecs, irq_types)?;
>> +
>> +        devres::register(self.as_ref(), irq_vecs, GFP_KERNEL)?;
>> If we move the call to devres::register() into IrqVectorRegistration::new()
> (which I'd call IrqVectorRegistration::register() then) we can enforce the
> guarantee that an IrqVectorRegistration must not out-live the device / driver
> binding internally.

Great idea, so paraphrasing for myself, your point is with the above code,
someone could theoretically do:

  1. Call new() directly on IrqVectorRegistration (bypassing alloc_irq_vectors()).
  2. Forget to call devres::register().
  3. Store the IrqVectorRegistration somewhere.
  4. Device gets unbound.
  5. Later when IrqVectorRegistration::drop() runs, it tries to free vectors on
a device that's gone.

Is that right?

So a better approach as you mentioned, is to do the devres registration during
the construction of the IrqVectorRegistration, so there's no way to do one
without the other. Did I get that right? Anyway great point and I have made this
change, thanks!

 - Joel




