Return-Path: <linux-pci+bounces-35013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C519BB39EBC
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 15:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2B341C25913
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 13:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F7731197F;
	Thu, 28 Aug 2025 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PCG+YLxD"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A3615B54A;
	Thu, 28 Aug 2025 13:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387516; cv=fail; b=V8Nqy6biYxwI0Kp7zodFK/jgL5Ez9xUB3P2h+j5TtXq7RfL11Ngbg2d/BkrHUP/AR9Ofc817HmWzYLUo+g0LCkNl9skoaLRigz8WEhXZ5SYNJqdGZxTtjRiYw9IP5mmKsdIVTopD47sfPH1JbXSxS/Zp1DckX638Vryk0h1lFRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387516; c=relaxed/simple;
	bh=AuEufEKyq6lxowv7FDln/57o+jLvJzPquWXWWYJux1o=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=WRyzdmYls1kcGCOAhaAX67KecQeuYYJriaezxn+LMxB2kGQQ7HRP4gHQA6LdnHUYOdG5OFSUzZ1RZZxNRSyMKb9xVybQ929WFiaFZkMNWPfW/mep6IX+SloamraBFq6Vci3FNthdGzVEzScksK46x6+btbQU8BhCV9yt5Ufzplo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PCG+YLxD; arc=fail smtp.client-ip=40.107.212.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irCl4WQartw2NXwFOt6ttzslQlarTuvRQVly0SGdYrsMbzsDJZ94UFXx8+DyTRTKi6DJDGdyOZCNzHD9t3v3HHZeC6+7coffrAQgJCvzzaaTWpDj+nZtLDHtOtQyY0rY7gnK0Tvanc4+0T0cYuoPKY7VEIKirkLdZb507bpmIwHKS232f42YpJ/ufdhA6E2l9yScZckIds4vIq7p5DXpGUcwWgm87yWvu9mdS9PjtCkAzA/f7lpJARR2S/Y1SOdg4eI9S8EXuLaBUdg8Rc/T8Keynidqmlp9b+W+r+JJcXUakIB95gLQW+hfRfSoaB3YsxsgXtVenvQO1gmid8ugUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j03u7f5bHnSdOJs5/4Cxby9eIFfqq5biT38LI/yVp9Q=;
 b=KkTttWJBqpOtI1einGwrgNE1qZwLLAqxk/IXjktbVaa1kC9+AbuVXz4J1AUuyZs6cLSGBnWYZkkXcTU0y7wkQ2Pe/7FfW+pGisi6R1O8ybp8u3qmuXZaKRah02Etusf9Ou3N2DuwT37F+BHbY1JLh65pWVMWuFdNaxDrTZVF34n9GDqf6hk+AWgcJ8I7eZGcADKDB2E+YC9ziZtL/bSntk1+arXsZYQdgJSHmNqHkvPgx5svhZoGoUj2SR/Qulxvs70ivlC+bu4kADr8jf1IKPxRVqV28Duob8wjorR09Ac6Y1a8Swktxxvmu/JE6Z6pcBZqy5rHnjufhBrXqBB1dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j03u7f5bHnSdOJs5/4Cxby9eIFfqq5biT38LI/yVp9Q=;
 b=PCG+YLxDq3TF3CN/nhSiMLVWS9X+TGc1SkRwj/jN5mgIOeOxcujy1yaq4YD+utWs0KOdqv1KQae41gFin9mrqFYymNVeJ0WKNj41c/YKtESKlZsSU2ptkQ03UrVZRZjpwGggCi7qqv0yeBj81/txAv8MJf3B/kwbJazmMwgEZ57KsJKrGcTRK9FC4NY1VdhTIds+XUNdgHmKAe1gOQjoOpLMuZxZC8gfI3QD53vHnLXQNYiz4IYspOGCi5OLoNyNRg4hGfjTy42ucpwvG/dQPeP58OyNup3rZziDBq1m6D547WIv/xOToUMVshtsGlcLbWW2BvoOBXKrVtrdnOWa6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB9196.namprd12.prod.outlook.com (2603:10b6:610:197::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 13:25:05 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 13:25:05 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Aug 2025 22:25:02 +0900
Message-Id: <DCE3ENGCR4T7.25B37IKXHCC8O@nvidia.com>
Cc: "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <nouveau@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>
Subject: Re: [PATCH v7 2/6] rust: pci: provide access to PCI Vendor values
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250826231224.1241349-1-jhubbard@nvidia.com>
 <20250826231224.1241349-3-jhubbard@nvidia.com>
In-Reply-To: <20250826231224.1241349-3-jhubbard@nvidia.com>
X-ClientProxiedBy: TYCP301CA0070.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB9196:EE_
X-MS-Office365-Filtering-Correlation-Id: e210ae1e-20d6-4ea0-d881-08dde6364cfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDhuTll1UkJtTDArT3JCUHllbzVJdlp4Q1c1ZVJVeEdhbHNVbXBCZVBEcXRl?=
 =?utf-8?B?WEFrMEhxTDUvQ1hOeXNBUGxvcm5lRFZzejFPTnNLbWNIK1lBbHlWVFFsc2dj?=
 =?utf-8?B?ajdZN0VTREFRVUoyYTJCZnlFcGlsMjhSdmJJaEJSYTE5WXU1eHVlZTd2STQ4?=
 =?utf-8?B?UDFiKzFiTjRBK1pUcGRBaVVhbE5UdWVLVnpGbTM3NzYyQjljeE5vVXBwMVBn?=
 =?utf-8?B?RlBZbGlVRHNjNk1GMitTTUUyZjJtWGVETURyZzdtSDZYNnFqVTFuS3ZPdXpJ?=
 =?utf-8?B?amE0NnNQZGcxamhKWDZTNUp2N1NvRVNheGMvN3QxTEZ3blc3dkVhWUI0blBC?=
 =?utf-8?B?RE5rRXhMM0o2Z3U4RmR2T1VWV3Q5cVdFcHVLVHhZbFZiOTZabU9xYkVROTJJ?=
 =?utf-8?B?N0M1RERQejR1c2VFanZQc20xWnhVRjJKOWtuS3JQRlRsd2ZCc1I2RURuVFZj?=
 =?utf-8?B?Sitnd2lBS1psWlFJZllXVzdyaVh3cmU4TjRQZjlTV21SWWh6eXg3Z2VIVG1E?=
 =?utf-8?B?MHhmQkJhY3dLR2ExcE1aUS9rbUJvMEN0b0t1aHZTQllqR0RscUQrRlZaSjVW?=
 =?utf-8?B?VmwwVjZSTHpla3pNcWNpVTVEVWswWHV6RDVZRmE5bzlOY3VKSDlSS1A0MjJ6?=
 =?utf-8?B?dE56cndLeGY5SFlPWUg2eTBNY3U0S002VzU3MTkwNHB5TE10bGNZTllwNkxy?=
 =?utf-8?B?WlRrdnQzaXd5bVNSOENERGt5RzdSL3VqYUpMd3BsbnV0VDlrQzAxZWJyQWl3?=
 =?utf-8?B?NFJjbGljZ0xZaWFxNUxpNmZVNXhJenAvQnpaZWZIc0VNaHhBUzEvVjRlOFNu?=
 =?utf-8?B?dEV2M2p6U0N6STJjdTNTWDBWRXhrbUUzMTNlajhVTDA5Tk16L0hIRE4xekNk?=
 =?utf-8?B?M3lWQ2lIL00vWW96OGtGOGJxSTcvbnR3eVFsVUxWVEpJdDM0QVBKUS95NmIr?=
 =?utf-8?B?dnVuZ3pLdW1ZNmxSYXFYNEk5R0c1ZjNGL3NYNEZoTUdLdmtwcU5zQ2FmK2RK?=
 =?utf-8?B?MXJuS0F1d0V0bUIrRW5YZ0JtaHRyS0F5QmFuMk1KYzlnVXVPWDQ0eTFtR3lB?=
 =?utf-8?B?Q0Rna3JMSzFvbWZOWUFhSDVodWdUMXdWZmcyLzlSOUdudExza0YzUTIrL1BR?=
 =?utf-8?B?MkJBbk5rV2hvcmhUSkFnT3FaYzdyc3gwWFBKZTdpUTNjZ3BCNmxUSExEUHNk?=
 =?utf-8?B?UW9iWUcrQk1GT0J2RUVsZUZodXpxSVFNKy9Bb1NZL0dJM2JDME52eTVOb3Fw?=
 =?utf-8?B?bkdkd2daMkd5L3hJcWxDeXpoSXJtR3dqUlZvMjhLKysxbDUydXFMRm0vcGJp?=
 =?utf-8?B?N2MyYnJraElMUnl4U1FQUCszc2NjSGtKalpyTjJaNWJTclB5akNsa3gxaExQ?=
 =?utf-8?B?akwrOFFNTDFRWHI4ZFFQWkJiUjcrRmJEWG1Fem5SdHlDMm42dVROWndIK2hP?=
 =?utf-8?B?M0JGM09LbHFmSUdzVEVLNHhrYWJqZGN0M3IrMnIzUjRYR0JQVHdBTnpKVmdk?=
 =?utf-8?B?dXBYUHFxajVlQUppQzcrdXdoVDlGb252Q1BnVlBHdmxxVkljV05WVmx0Z3d2?=
 =?utf-8?B?VjNXL0lrRWpkZWhnNWpWcTV1MTRuM2ZOWUpad2sxUS9lRGl2OGlncjFkQUZ6?=
 =?utf-8?B?VWdzV1Z6LzNFZ2lkZmphRXJLWGlORmNwZ2JqeUtJU2FmdnF5d3dScmtaUDJt?=
 =?utf-8?B?aUx3UlhtVUdCQU14QnB0RW1oeHR4TlNxckRISmFneG55UG9CeXZNQTVET2s2?=
 =?utf-8?B?THFieFNKWDBrN1l3VlNid3BCZ0VhRFcxYXhUc0MwOVJqN3RWU0RtTTZ5Rzkx?=
 =?utf-8?B?MjRLR3hRU0lrQXIvc0puQUp0VURVN0xkaS9kQ3NYREJadUdwdi9KZ08ydmhR?=
 =?utf-8?B?RmtEMGlxVCtHdUJyWm9NbEVyYUNHS25NZGJyWVM2VDVYQ3QzZDdOdy9JU0xs?=
 =?utf-8?Q?KJNU3q2l6GY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHZ4TXBITlkvYUJ5bGVYREpqbytETDYzYnBoZkFlbzdRc3BsZUdvL1dHY0dn?=
 =?utf-8?B?MFhrYmdDN204RjNKTEVZUTVnZno2RWxzMFhQaUtZYUs4aFQ4WU1XU0I4MVNz?=
 =?utf-8?B?eGFUR05PRzZxbkhSM2pjdlhTdnpBak4zeVVNclYySjM2dnlyRUp6Mjh1Nm5P?=
 =?utf-8?B?Nm1nbEdocFhxVmdrTVBMdFcrN1gvcnI3NkJaZnR4eHdQQ2dyV1dVa0poQ1Rm?=
 =?utf-8?B?Y2hlSThqbVJxVmY5V1psbUs3Mm5WTjV5T1BYRDVTR1ZtNEVYd2dWczBoVTBS?=
 =?utf-8?B?R2NQRDF4ejRuK2dGeXdMcXZVNGkvM0JZd2Y1WUxNcEszQWJvZ0F5Rnd1MnlC?=
 =?utf-8?B?bGcrckxvbDcwdG11VHlqV0ZsRTREN2x4dUpwMFpBYnl6NW5LN1FvWVVkRUox?=
 =?utf-8?B?TVRHT0wwOGhlTTJUbjlUZ0MyS1l6OTRQZHRxMThIdlRlczdYNEYvbDRGanlP?=
 =?utf-8?B?UndZV2xiOVhOeWEyK0E0ajh3NUVYNWl4NW5ESE5KNk9KWVdpR2Q0SzNJdkZo?=
 =?utf-8?B?aHF6Q0xXT21rcnF1ZDd5NDI3cTJwUUtkZnpFeWlkK3RsSUVzOTBaS1BoTlRj?=
 =?utf-8?B?T0dBQlh4N2E3bE5ZZ29HN2FxZ3NiR2xOSFhZR0JVajBwY1ZHdFhmUm1GMTh3?=
 =?utf-8?B?Z2xrN0N0WlUrMUY4ektkMmkyUFo5eC83Z2NKeGl0VHBYcGtLbEVjUDhBWE44?=
 =?utf-8?B?M080dDYwcjNPSkN0QVZQd25BM0dTbWd6MTh1TXpxUE53SmlZN3ZITU05RGNK?=
 =?utf-8?B?K2poTVBJYkh1UndkVWMxdnFyK3o1L29MM3BSSVJLS0xpUE5oRG4wMlJ4eWds?=
 =?utf-8?B?c2RpaEREMnBBVGFYNDNZSG9pcGdTUDVSMWc2ekZmam9IV2VCMEFFbUtTTjZN?=
 =?utf-8?B?R0oyQnhQTTlCKzhmL1lRU2FZOFJ0bERSaUxNWWFKbGhPRU00V0NjbmZPUWVr?=
 =?utf-8?B?R0E5aVFFWUpOTzhBck5wMXBXRE5iallzbzRFQ3Y4QW5UNFBGNGFUeUZqT0h1?=
 =?utf-8?B?L3pIeDhFYkJ5MlJoZ1FMK2VhbHM1ZVhiV2RUaXN0ejBnQjFpd1loajBsN0Jl?=
 =?utf-8?B?RmVUNisxeUl0ODYvSm9XUVhBYzM3ckN2Nmd6aEduQS9ETWw0MnlucDlUNWh0?=
 =?utf-8?B?cmlaVklpSTRKbW04TkF2RmlKbXNIWEgrODg5blpJQ1krMllKYnFpeGxQcjJ0?=
 =?utf-8?B?aFNIdGpML1I0c0YrV2dKSERUUkQ4USt6RFVEaVJkb05hOUZSRzY1YlpUK0Vw?=
 =?utf-8?B?bHhqTE82a3N3RTVpd203ejJ1Vk1tT1c1WVRodVNpaU4rSWx0V0kvaWU1MWR1?=
 =?utf-8?B?RGhXVDhrQ214Yk9UR3BZdGY3UHE5eWdEOHRkcW5TbDhjUFFKMFhoNktZaS9r?=
 =?utf-8?B?a3duYVdOWHE5c3pRbHo2cmgrRnhJQnczcE9GUGY5MHU2K0hMWTFrOWZuWVkx?=
 =?utf-8?B?TGJLWFZFWDZGREZKOVRqYXlMVFMxQWVVbVpmR1cwTE1MbEYyVmJwejZ0c2ww?=
 =?utf-8?B?KzRyaUxIVEhKbG5zeFF0TjVNdUUrUjBkNWFrajZCbW5GbHY1UXJkTlhwVXhH?=
 =?utf-8?B?TDVRWTI3NTdLOFROQjBiaUxmQUhrc0JWRU1RYXdHSUlmN0pHdUFLQ0tVWHdE?=
 =?utf-8?B?NTdvZG0yZWhtVncvZ013STRXZnR6cmlzc1ErZDBnSVJiMUZDZ0pJZlVyOTJj?=
 =?utf-8?B?WjhjM25kMkYzd3hMcSsydU0zZ1BYeUMya2JuOE5KNks0cFZBQzluZ0JEbUJ2?=
 =?utf-8?B?eXJFdTEwRm4xUm9aRkN3RUQzdm5UMElJajEwa21vVGFhTFBZSFJDbDM5bS9m?=
 =?utf-8?B?Y2xJU1Fkem1icVhGUHdrYjlTQ2UrZUNnMUowenYvUzR2a0N5S3JYMCs5WEFr?=
 =?utf-8?B?VEs1QWF4a0kvOURWdVBmeVo4VWlML2VWMTZib2JXWFUzKzhPTTcvWlZCek9L?=
 =?utf-8?B?Nlp1amt4TWwxVkl6RjNYR294VW1qb3Bza2kyS2ZHR2lmREVQZDd6MU9obENw?=
 =?utf-8?B?ZVQ5T28yNndPNVNiTURGU1ZPb1pzMWFpWDNhRk12bzJ3ekRSRkNQVU8zekxa?=
 =?utf-8?B?dm5aK1E4OHZkMHZSSlJPODdPZmN6blRvMnpOenJOR0FmcXYrOWZVa0lwcjZk?=
 =?utf-8?B?ekx6THpBSmdnRG9PbmtUMFRGeGh3NU5GcUpSTExZc3Q5ZUFEZEk4OXRIRTFT?=
 =?utf-8?Q?5V2KnPtFDPFRFzqbCDeBxaAHhexmg+lBcmiQfagPMtm6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e210ae1e-20d6-4ea0-d881-08dde6364cfc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 13:25:05.4342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +fztWg9A72DH97ufdCDDFNjaZJf6Twd36nCfdt8n5IN17HVc/KdI75l2yy3gx6KUnGhIyIxUXuWtQxgKv0qs0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9196

On Wed Aug 27, 2025 at 8:12 AM JST, John Hubbard wrote:
> This allows callers to write Vendor::SOME_COMPANY instead of
> bindings::PCI_VENDOR_ID_SOME_COMPANY.
>
> New APIs:
>     Vendor::SOME_COMPANY
>     Vendor::from_raw() -- Only accessible from the pci (parent) module.
>     Vendor::as_raw()
>     Vendor: fmt::Display for Vendor
>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Elle Rhumsaa <elle@weathered-steel.dev>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  rust/kernel/pci.rs    |   2 +-
>  rust/kernel/pci/id.rs | 349 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 349 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 212c4a6834fb..f15cfd0e76d9 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -25,7 +25,7 @@
> =20
>  mod id;
> =20
> -pub use self::id::{Class, ClassMask};
> +pub use self::id::{Class, ClassMask, Vendor};
> =20
>  /// An adapter for the registration of PCI drivers.
>  pub struct Adapter<T: Driver>(T);
> diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
> index 55d9cdcc6658..4b0ad8d4edc6 100644
> --- a/rust/kernel/pci/id.rs
> +++ b/rust/kernel/pci/id.rs
> @@ -2,7 +2,7 @@
> =20
>  //! PCI device identifiers and related types.
>  //!
> -//! This module contains PCI class codes and supporting types.
> +//! This module contains PCI class codes, Vendor IDs, and supporting typ=
es.
> =20
>  use crate::{bindings, error::code::EINVAL, error::Error, prelude::*};
>  use core::fmt;
> @@ -109,6 +109,69 @@ fn try_from(value: u32) -> Result<Self, Self::Error>=
 {
>      }
>  }
> =20
> +/// PCI vendor IDs.
> +///
> +/// Each entry contains the 16-bit PCI vendor ID as assigned by the PCI =
SIG.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// # use kernel::{device::Core, pci::{self, Vendor}, prelude::*};
> +/// fn log_device_info(pdev: &pci::Device<Core>) -> Result<()> {
> +///     // Compare raw vendor ID with known vendor constant
> +///     let vendor_id =3D pdev.vendor_id();
> +///     if vendor_id =3D=3D Vendor::NVIDIA.as_raw() {
> +///         dev_info!(
> +///             pdev.as_ref(),
> +///             "Found NVIDIA device: 0x{:x}\n",
> +///             pdev.device_id()
> +///         );
> +///     }
> +///     Ok(())
> +/// }
> +/// ```
> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +#[repr(transparent)]
> +pub struct Vendor(u16);
> +
> +macro_rules! define_all_pci_vendors {
> +    (
> +        $($variant:ident =3D $binding:expr,)+
> +    ) =3D> {
> +
> +        impl Vendor {

Why the blank line here? (same for the `define_all_pci_classes` in the
previous patch).

> +            $(
> +                #[allow(missing_docs)]
> +                pub const $variant: Self =3D Self($binding as u16);
> +            )+
> +        }
> +    };
> +}
> +
> +/// Once constructed, a `Vendor` contains a valid PCI Vendor ID.
> +impl Vendor {
> +    /// Create a Vendor from a raw 16-bit vendor ID.
> +    /// Only accessible from the parent pci module.
> +    #[expect(dead_code)]
> +    #[inline]
> +    pub(super) fn from_raw(vendor_id: u16) -> Self {
> +        Self(vendor_id)
> +    }
> +
> +    /// Get the raw 16-bit vendor ID value.
> +    #[inline]
> +    pub const fn as_raw(self) -> u16 {
> +        self.0
> +    }
> +}
> +
> +impl fmt::Display for Vendor {
> +    #[inline]
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        write!(f, "0x{:04x}", self.0)
> +    }
> +}

Possibly an exercice for a future patch, but do we want to display the
vendor name if it is defined, rather than its hex code (which is more
the job of `Debug`)? We could leverage the macro above to do that. The
same should be doable for the PCI classes.

I suspect strings for all the names already exist on the C side, in
which case we would want to reuse them instead of defining new ones.

Note that I don't think this needs to be done for this series - it's
just a thought as I was looking at this `Display` implementation that
looks more like a `Debug` one.

