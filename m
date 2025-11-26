Return-Path: <linux-pci+bounces-42092-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5183DC879D7
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 01:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09BB33B3870
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 00:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3277A26E6E8;
	Wed, 26 Nov 2025 00:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eDS+ta7f"
X-Original-To: linux-pci@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013023.outbound.protection.outlook.com [40.93.196.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB4426ED29;
	Wed, 26 Nov 2025 00:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764117809; cv=fail; b=q2Lv89ylcCX0PCRc3Z+lt2dyj+FoQb3++HGcYQWtUXkUyMlzn9zYaf7p3IUFfa/jwg+plv1RFwnLQc2GAin4GVhGl3/RCxO/SaKrx4YWsxNreo/QRKy9+jp0oqn8qHHg8eKVdSx30FuXF85CmjxMSdN9iLIUVC1Ewm+uWyLdWe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764117809; c=relaxed/simple;
	bh=fd+0FYu96XELdxaBrFyJpbttxi4+7HMtXWodScB6q84=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=n/Bi1zdqGDpWzdHnldGuLj3kCEXC9XkvXItL+pLF3sf2+S6xyWJ59Ipw/dlLT4avoLCWKQP4SkVqz8fTojDSblQ4NrhB8hJRT8rUg8vRPT9/Tc5QkyM8KJ9CMht+HTX1wHPtH1EElpyKfJCUSvJMEU22gWfj3E90alh/s4jwXiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eDS+ta7f; arc=fail smtp.client-ip=40.93.196.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDqpWsXgEec4yuyz5lK/Ip6elv2M7glweEDph4x4k+fuLLwACIfUK3gH3Uti3nlGIOmUTTRgWJTeLjsPJ6n2S6x6R7HZzsywWkIIMR5i59nfN0ezXGBnW8Qogybe6efCHab3VC53KnY57aVuxdoyG5NRwCpJMPt4hu9qF4x5G5+akNFKfnBsUv6s1166Oupnmnb9TKSmANqfFqZ2I//c0s/Smt9uXpV0u5JTmDXqj6jpPmiWSAqi3VZu90f0Pl0cPbQ3/dQGnw6hdmQ+L0vxwPqzAirhiGTTG5+GP5fwCbTwGjEH5gCXtYgUM5jUzcPlWzTWpInMY9NFqO+hLBPlbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Os0PE/xG8W1OdflXfyNboWWF68ihJvb2UxSW96JU9TE=;
 b=kwbFRy2b38J3CfocDWApqMtAv5taW3e1MDQt5GeqYq/tEnEOe4GbJZ20uYBqWlNI0J1CSyzgztEfewY5VCjuD7ZoSCV6tn+SFykVuoISYMITVBrKrfyHi8itsXc+Ab34V4MeaDHxOTGlE4gaQQdrQ+zTTQIjeIWRdck/kj1TnvWr7b7btGbHoAuu4tnUkWn60Le8KmwxG9cmVCldo14kMYgPyN7oQ+U+V9F/9WBgW8uY7z1J1PihZQ0HHRB/O378DcmkPuk6M8GXTZ5qQWCbgx0elFOb97bTEiM7JKELQLuzJR3pDK5AIo0ZfNra3lj4Qo8GuiyylHuOfqIbb+F/tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Os0PE/xG8W1OdflXfyNboWWF68ihJvb2UxSW96JU9TE=;
 b=eDS+ta7fT3PT7PD9RFbRDjPtXF4yMzcKZDSjn2oLatk500AQ+eKCvKLALlQ9LBEwW3Wl+oqoR+aYWzXLT1S9oA8n+2xKKh5buJ+jHilZfo9tngsOGtfmoCecmbbmccCdsBSr26utOFbzHPaxrafPdGaNFWldAG6iZGLewoUXZ7U/80vCjYHs2x3ZPcq+2QrxI6TbCAB2eu2HRqvQ4cVzq+uU8Sgo7S7ErRLdeSJJCgiJLzp+Or38aKaW0/0BDcmZKHLbFANm8c+IdMe6rpaQfReF2vnFvtnic9DpA4q9zXkt9vAlw37ijs380ss2kPO1nTbCpguSINeCyKaYSFeJJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY8PR12MB7338.namprd12.prod.outlook.com (2603:10b6:930:52::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Wed, 26 Nov
 2025 00:43:23 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 00:43:23 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Nov 2025 09:43:18 +0900
Message-Id: <DEI7KGLC4AOM.2I3ZMD21X08TO@nvidia.com>
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dakr@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <helgaas@kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>
Subject: Re: [PATCH v7 3/6] rust: io: factor common I/O helpers into Io
 trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251119112117.116979-1-zhiw@nvidia.com>
 <20251119112117.116979-4-zhiw@nvidia.com> <aSB1Hcqr6W7EEjjK@google.com>
 <DEHTK1CK84WO.28LTX338E4PXQ@nvidia.com> <aSXD-I8bYUA-72vi@google.com>
In-Reply-To: <aSXD-I8bYUA-72vi@google.com>
X-ClientProxiedBy: TYCPR01CA0208.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY8PR12MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: f965c03d-469f-413d-9eb8-08de2c84cd83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTFEZkt5cnhnYUEyT2ZBWVEzZ2JVVm9MMUVOUzNib3lyZTlaaWx6YmR5eXd3?=
 =?utf-8?B?ellYOGFjbVQvaEZ0K2prMVZUN0U2QlpUM1A4TDZLUUhoaGwwdnVCYkFyYkVU?=
 =?utf-8?B?RWVaazJweWRkNnJQdEVKMy8yeUhCQ3Z6ZDVuTlFnbEhsTE84SVhiTVBqRFhw?=
 =?utf-8?B?Zk01eTdZSXhib2h2OW0wTE1TNHhjZWNlVGh2ZS91bUFrUjdDK3AzR29BT2ta?=
 =?utf-8?B?VUZ0RDluZzNsOGFBcFJhOWdIZysrWlFqSjRtYkRGTjF1OTZmMlhQTUVrMWpj?=
 =?utf-8?B?SloxYStyTUl2SGRKc2hUQ0FXbTk0QndLUUwreFkrN2g3M0liRHU2N3VqbUxo?=
 =?utf-8?B?VE9vckFyd3lOTHhJY1VJUUFkN1RnNm96Um52SlBUcHB2Q2xUbkN5MFBRSkpn?=
 =?utf-8?B?ZXBab0FucXYyTVFTK0JGVHdqZ2oyQm9qbDdvTzhpN0hhNkN3L1prUWdhc2w2?=
 =?utf-8?B?WXlKcVBuT1B1MjVuV01XR05mbzd2S2RaRFJqcWdHYWU2NU4rRFVQR3ZmZHph?=
 =?utf-8?B?aDdib01PelR3dThxNy9ZS2NmVDg1OW54TnNUK2JKRnovSm9DTzlTaUJCUmIw?=
 =?utf-8?B?ekwyWERPSmMrVTZNZTVhK0NQVHYwOXlNMzhnT2NPamNuQ0NHaXdYSlFCZEtu?=
 =?utf-8?B?dnVGc1B0c2VpdFFzQnpYcFAyZ0RJbERDdkhENE5Hb05ja2V3T05EcFNxejhJ?=
 =?utf-8?B?R0dhRGFkcnpJeFNEemVkc2xqbmJiTlpyNm9DL1lnK01pTXYyRkhwWWRydjlN?=
 =?utf-8?B?aU41S0dSVnVlQk5BQVJXOVRkMG9oeTViTDBkbFVwZ0N1cG5kOUF2UUdsU28y?=
 =?utf-8?B?YjVxM0IrWWkxMDA1L0FQZy9FNm5UR0lIVGhPb2RRd2IwbnRtVmIvQXVpTzRC?=
 =?utf-8?B?aWR6c2ZBZG1MS0YvWDk1ZkY1NWt0SnMyN3YwTzRHUTQvNDk0aFNqTHJqYmZG?=
 =?utf-8?B?OHFzTkgwVnJYcnV5dWhzckxlQ1h1UkNyMkx5TC9ZK1lqa0t5cVpvZ1pITlc4?=
 =?utf-8?B?elBqN0ZuaS9HZGVoT0E0dDgvOFA5NnJnbzZScFE3N09VM0cwTGVCc09CRW4w?=
 =?utf-8?B?RWdsK3laRlF3em91RUZGYVI4YWphYWZsaXBwblJjQUM4WkhFa1Q5SWdFNW9p?=
 =?utf-8?B?dHI4Q0NJTmEwYlVEbzltSzlhNWdqUjQ3Y09CdVV5MlB0RDFmWUl3RFhlSU9G?=
 =?utf-8?B?ODgwOWtqUkt2bmwvY2hUb0pKVWdYV2NyVHg1NVhhMmFaZkhpSUI3ajdEMjZW?=
 =?utf-8?B?Z0VUUCthYi9GbDNIZnFNdUl1NEhYVEpWVkx4c0hFRUJ1OEhGNWZZc1N4Yk1q?=
 =?utf-8?B?UzQrMjdxRm9uNmdJYjFleVV3Y1ZuaTBxelJUcisyQldvRWkvOTROek5QK1p6?=
 =?utf-8?B?MGNZaUl3SjNCdUFFejhYRXVJWGFJeW1lTk1jUUdTRFg5R3BuRzEwWGZxWERq?=
 =?utf-8?B?UG5lNU00d1l6V0NoQWxYM1lqd1lBTlUrYlNpdkQ1UzlkbDFqOEx6WU9EU3BY?=
 =?utf-8?B?T2djUlg0bnMyRDN5SW5IL2ZQM1kxaUk5K29NWXdMNVBhWU1DWjFWZS9JcmRh?=
 =?utf-8?B?QlducjVITU1EdDBJTU0xSWpRaklCUUI0Yk5lYllXTmVtUXQ2bitRLytjZEhY?=
 =?utf-8?B?SzBHT0NtUlhNNEprcUJ0N29DWWxRZFlabmNDYWJ2NGpjVjc1U2dqZUI1bURY?=
 =?utf-8?B?T0RPTURvQVpvTDBqZmZ1YXk5aGpXM1JMOFFyY1JpcVdxK3phckc2SWZmNDNm?=
 =?utf-8?B?QVBndXhhOWs1cEJ0dFlLejNFbDRtSHQ3akdhd3N6TWxDcHkxYlVtM3pGNXNh?=
 =?utf-8?B?VFJPM3ZSclkxRkVHdVY1V3M0dll3d3U0aDd3SEw0d1ZIMTArRUx5NENLbzZt?=
 =?utf-8?B?T2ZUSW50TjBxeTJYdlp1YnZQWkpYbE9zbnFJeTBIbUFKYjNLQzlMYUIzTXVK?=
 =?utf-8?B?QVJpWWlsUE5iQVVmRXZEV2ljK0NEZUJmSW53TXRnWnBkLzVPYlFMbXcxbHBU?=
 =?utf-8?B?RHY1M1ppdXdBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzBvZ1VFWXBTNVZoOGZuY0svMVc0c1JVSHJCQnYyZzBPeGw2ZnZtK3NKcTg2?=
 =?utf-8?B?d3RTdGNJZnpLclRtNGZTZTRPL2p1NGtVNE5sTnlQeEpGcTBLZUpKNmhkMkRL?=
 =?utf-8?B?c1RxaVhLdnFxYSszeXA0Q0RDV0pZazR4MXY2bkxBbkl5Y3hobUJ2bXVOQUJz?=
 =?utf-8?B?cGd5dTFYY3hvMldzYVNSVmxKNzZXSTZxTURsYnRtZ0VHclgxMFNNaWQ1dEtX?=
 =?utf-8?B?aUlqeWl5djAvTWw1eG9namZMaDhEbmhoSE1EeDg4cFg5ZmVxWERUcWhjL3dj?=
 =?utf-8?B?MW5sTE1aNmNVUVIvdVF4enBxRjFrTjVNSExQeWt4ZkdKVWFWbUkya295TGo0?=
 =?utf-8?B?TFZDc3RsRyt5NzJ4TjNSb2dkQTZJYlN1OGZlVndvVUlkV3JmTkRTK3lMbUVR?=
 =?utf-8?B?NmNJY1doTzZHclVoblFCUnphVGdmUHhycCtxK0tBakF5OUhlcVU0VU9DY3ZJ?=
 =?utf-8?B?M0V1TEZOM21JS3ltRGp3Q01uMDhFK3BZUUpQS0YrT01qSnA5QmExU0RXYjBH?=
 =?utf-8?B?SDk1WU5oZWxjcDJtby9KWkdDTDJ5RW5naFZ6M3FqSEIzNmNSeGxSeEw3Ym5H?=
 =?utf-8?B?NE5WQlM0QXhRK3F0bFF1b1ZSazlORHlucVBVMVQxc2g1RnNBd0duTERZMUd6?=
 =?utf-8?B?Vzdwd3JuckRsQ0xYRWlHQ2Y2QnBCRHRTOTVRU0l5d0NRQjNhRzZpZDd4czE1?=
 =?utf-8?B?SzZkOVF0Nml2RlBGbWZYdTFUcGpFS1UyVHdLcVFnSjhCdGZNakRTdXNvUWgx?=
 =?utf-8?B?bjZiem9zZ1dxTDE4MDVQZVR2V1pzMXNQbmwzS2dqNUk5YjZwYVdCUUEwN3RC?=
 =?utf-8?B?cUNRZzA1MWhNUjdwbTdzUlBFcGxEblExbGN0WHJjYWc0dW42bXdwY1RJVmd4?=
 =?utf-8?B?cktqNEFGWVRFdHFsR1J0Y0c0UjhlNy92Qzdqc3FwTDI3RVc5L2pnbFNMSldr?=
 =?utf-8?B?Z1VJM0NlQStGck9QZUh1NFZVTk9saDFPaHhHNFZHSi9uQVpNK2tJQ0hwNmht?=
 =?utf-8?B?N2hDc21jWm5oajdTSFlrZ0lMVGJZekE3TDZ3cmxXZG5wTjVSQ1ZGYTNRek53?=
 =?utf-8?B?cEpiL0VESThodUh2SHpkVEZUd0NyZTU4WVh3aHNJc1lraUtBcnJNVUV2Uk1Q?=
 =?utf-8?B?WnBYR2tVQk5ESjYrQytrN2w4SHZ6eFAxMDg1cXFXMDc3cjVKNDZmczlPNDh6?=
 =?utf-8?B?OW9JcS95V0lUeDFWbmJNdVAwbmVESWtKUi9JNmsyV01PN3ZLbFZZeFZyWWh2?=
 =?utf-8?B?Z3dIallsU0tSemgvQVFDcUlUZHNuWWI1SmlRMFFZNXVjV3YwUTJqRU1NTndR?=
 =?utf-8?B?eUI3dURpZ0M2TG9sbnFtbCtsakgyWmtReUxKaXJpSnBQa21vODEvNTNJN2lp?=
 =?utf-8?B?U0VCZ1ZHK3U0bFpvVkZXKzM0VTlDbDRrRkkvOTdoWTgvelYvSWRmcnI5MVdH?=
 =?utf-8?B?NmNUMTcrTHR0cHBCTjdha1lvV1g3Qll2VWt0U0xlRFE5Z3llUzNLdnRlRDY5?=
 =?utf-8?B?cFRjTUdaekFBaGZPNHdXNXZRenpNMmFpSE9pNDR1WG9OWlFtYnRKZXVqRkdH?=
 =?utf-8?B?UlVzbnAyRG4yRUpQanNwY3p4YzFzWXZ6ZWZhaDlNcWpVOERSOE1TLzlPekxk?=
 =?utf-8?B?R2oxSGhIOGx0Y1VoY0VkUEg2eFU3OUpXcStGa2kwc2NhdVRCRHVMQmd4UEtz?=
 =?utf-8?B?YkRBZXRNQktkdnY3SnRqZ0lseU0xU2JBdW1CVE4wMkY4a2ZlOXhRMTZmQnEw?=
 =?utf-8?B?a0JaWEJIcjRrd0JiUmtqMXcyZ1FXOW9PZUM4K09mTUFYTis5YkhOam1ydWJj?=
 =?utf-8?B?VnpvcGlkM1BTZi9SWTZQWkNJQW5hWTdRR0lYOVJpSHJYZUE2QkoxakV6YXln?=
 =?utf-8?B?SVVGS0RyYzhmQWRNNWk1WlVZZmR4RXhYbzNZWVV0Z2NnTk9lMDh0WkloZmlK?=
 =?utf-8?B?Q1QxN1BPYnJjK3FzalcwVEZCRG1Ld2UxRmlCcEY1OUkvZjBtN0txZFhBVDU5?=
 =?utf-8?B?QVRYRHNHa1ZqRTR4T3lIRitXNiswNGhRakJHQjNyb1lQdFByQ1VqVEpPWmov?=
 =?utf-8?B?ODJ0a3Z1bHJzY1ZHUnZPMzB1MmtlcDZsWFlTRUpndGFXdXFLaDlHOG11MXN3?=
 =?utf-8?B?Rks3N0FqajQyMDM2L1B2V0lRaVpFdmNLVUZPbnZqa1JYVkNzb0dMdWdqczZN?=
 =?utf-8?Q?ESJR+KkmaiQWpO1ZqR2UpNwv4u+/X6P6AwhPtZfLTWrf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f965c03d-469f-413d-9eb8-08de2c84cd83
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 00:43:23.2040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dm7iHRcONOl/lYTk1s1SH+1uTaoF0fJWCRlPnR4Yrh+POEPAgrJBShK13bnZonLcaFqpdqqHSPFpFw055dqWpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7338

On Tue Nov 25, 2025 at 11:58 PM JST, Alice Ryhl wrote:
> On Tue, Nov 25, 2025 at 10:44:29PM +0900, Alexandre Courbot wrote:
>> On Fri Nov 21, 2025 at 11:20 PM JST, Alice Ryhl wrote:
>> > On Wed, Nov 19, 2025 at 01:21:13PM +0200, Zhi Wang wrote:
>> >> The previous Io<SIZE> type combined both the generic I/O access helpe=
rs
>> >> and MMIO implementation details in a single struct.
>> >>=20
>> >> To establish a cleaner layering between the I/O interface and its con=
crete
>> >> backends, paving the way for supporting additional I/O mechanisms in =
the
>> >> future, Io<SIZE> need to be factored.
>> >>=20
>> >> Factor the common helpers into new {Io, Io64} traits, and move the
>> >> MMIO-specific logic into a dedicated Mmio<SIZE> type implementing tha=
t
>> >> trait. Rename the IoRaw to MmioRaw and update the bus MMIO implementa=
tions
>> >> to use MmioRaw.
>> >>=20
>> >> No functional change intended.
>> >>=20
>> >> Cc: Alexandre Courbot <acourbot@nvidia.com>
>> >> Cc: Alice Ryhl <aliceryhl@google.com>
>> >> Cc: Bjorn Helgaas <helgaas@kernel.org>
>> >> Cc: Danilo Krummrich <dakr@kernel.org>
>> >> Cc: John Hubbard <jhubbard@nvidia.com>
>> >> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
>> >
>> > I said this on a previous version, but I still don't buy the split
>> > into IoFallible and IoInfallible.
>> >
>> > For one, we're never going to have a method that can accept any Io - w=
e
>> > will always want to accept either IoInfallible or IoFallible, so the
>> > base Io trait serves no purpose.
>> >
>> > For another, the docs explain that the distinction between them is
>> > whether the bounds check is done at compile-time or runtime. That is n=
ot
>> > the kind of capability one normally uses different traits to distingui=
sh
>> > between. It makes sense to have additional traits to distinguish
>> > between e.g.:
>> >
>> > * Whether IO ops can fail for reasons *other* than bounds checks.
>> > * Whether 64-bit IO ops are possible.
>> >
>> > Well ... I guess one could distinguish between whether it's possible t=
o
>> > check bounds at compile-time at all. But if you can check them at
>> > compile-time, it should always be possible to check at runtime too, so
>> > one should be a sub-trait of the other if you want to distinguish
>> > them. (And then a trait name of KnownSizeIo would be more idiomatic.)
>> >
>> > And I'm not really convinced that the current compile-time checked
>> > traits are a good idea at all. See:
>> > https://lore.kernel.org/all/DEEEZRYSYSS0.28PPK371D100F@nvidia.com/
>> >
>> > If we want to have a compile-time checked trait, then the idiomatic wa=
y
>> > to do that in Rust would be to have a new integer type that's guarante=
ed
>> > to only contain integers <=3D the size. For example, the Bounded integ=
er
>> > being added elsewhere.
>>=20
>> Would that be so different from using an associated const value though?
>> IIUC the bounded integer type would play the same role, only slightly
>> differently - by that I mean that if the offset is expressed by an
>> expression that is not const (such as an indexed access), then the
>> bounded integer still needs to rely on `build_assert` to be built.
>
> I mean something like this:
>
> trait Io {
>     const SIZE: usize;
>     fn write(&mut self, i: Bounded<Self::SIZE>);
> }
>
> You know that Bounded<SIZE> contains a number less than SIZE, so you
> know it's in-bounds without any build_assert required.
>
> Yes, if there's a constructor for Bounded that utilizes build_assert,
> then you end up with a build_assert to create it. But I think in many
> cases it's avoidable depending on where the index comes from.
>
> For example if you iterate all indices 0..SIZE, there could be a way to
> directly create Bounded<SIZE> values from an iterator. Or if the index
> comes from an ioctl, then you probably runtime check the integer at the
> ioctl entrypoint, in which case you want the runtime-checked
> constructor.

Thanks for elaborating. I really like this idea.

You are right that is would drastically reduce the number of times we
need to rely on `build_assert`, as well as concentrating its use to a
single point (bounded int constructor) instead of having to sprinkle
extra invocations in the Io module.

Now I would also like to also keep the ability to define "integers which
only X LSBs represent the value", so I guess we could have a distinct
type for "integers within a lower and higher bound", since the latter
requires two generic constants vs one for the former.

Maybe we could derive the current `Bounded` and that new type from a
more generic "constrained integer" type, which constraint rule itself is
given as a generic argument? From this we could then easily build all
sort of funny things. That could turn into quite an undertaking though.


