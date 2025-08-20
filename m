Return-Path: <linux-pci+bounces-34332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EAEB2D252
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 05:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D5F768256F
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 03:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F442185AA;
	Wed, 20 Aug 2025 03:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EGIYDpVn"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E101E9B08;
	Wed, 20 Aug 2025 03:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755659348; cv=fail; b=ptpzDx+USZSEMxrcRzHEzW+gDCuKyvYdKwGCJxNscv1FllUayaCcnbMJz6YbjGpItWj5zV4mMw/GJ+xNAn8w8qT2B7LNOuiCuEZQshp+hSjD60QNoC8F+L78+YJqglWgYr/YALFBofP58nP6loTxadvhSmjIBxR6eFRQNHKxjNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755659348; c=relaxed/simple;
	bh=mN8xSmN/kkSMocMzzIzZjUY4gwYlCw4kbMOBcEfhORE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=M1RdmJZUbpwr3I9ePnk99zJy+2rOsG+UoW/YFenehaH8RL8fYCgs4LguC//8cHppYqb5EXaXPVPOVY6eKHcAgCHWYmGeLEseL16ErHjIyQlSDR7YwwL55KhLlYUzsOE9UDIkrRCTpkAsQUd+cKGmHfytnPRQdBvdeM1RF9TztQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EGIYDpVn; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtlRbBl1M0p5z8tsIhZZNkgn3OhYjLYzc4ipSXscZ4EN5IN3dSGqstKnaSdyh2Ht/7E9JUbqdi83I7r8P8WLoceloMw4+FcqA3DMCm67MczRJGYs3dj2zcTXlp+x8POhkVReA1kT4hWndrvwbnSeS8PoBUwuXsKa3Xr6uU9wfShF0S+oY3h7eoQ7vlppQbSPBCtrT5kOLkcWCYlS7vmzWESZEc4QB3APXFwIOCL8L5h1Ie0m4ZmQbhePbhwkw9eBaod/JamCXUZLd+KaFLoPpfd8XrS6KTh4RVXTmRX0lO1Wz0IK1TfSWCQi8ap+eif4FmidQC71TRWMSdIct0KoNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bj0jLnUuau1v04m41w67R+qxctN8oBMNGQjHhQ2ZiGw=;
 b=Zdx4xiwpCMGC0G7arT5xirhe8W9u5lbe2S8m19RX+1elNKRQaHRp8FMaHb63uK3amCh71ljrBd5Zm5ZmyW+a3a0W39RmnYz+CrJ0y1RTkZJeEISC9porl5AGMBQfd/9/Ha6EQyTRgQgNAKmH6fgvE6kwpC4aE7IcEHObKFNlVvpn0rhEK8ViHQ7SoIYyTlvKw37IAl70bqiZQSkC9Dr0cYdYnRH+oJ2E06m/u7p0YZOCb1UMFpQwrNTzxMwXfHP/GlJmLZviW1k3lJv7hiLt0BX1VwMmpJxHs4Df0htptLIGPPTX8DDLfzFsurfEcpPcDhLBgsu3dwNmGvgbGhRK6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bj0jLnUuau1v04m41w67R+qxctN8oBMNGQjHhQ2ZiGw=;
 b=EGIYDpVncItl5u+nuld3YGOiwg35OiSdKX8cgo+ZbD6bVBJWTGPOb8b3jue+e9UfprpwNGrs0N58JmAyZo+hFMnYwR3XQLpWz3yWUCzy54/d4/BbmP2TOICIS8cwRry7F74UNupgWz5rssebNnCp9NKSc8G+dothXY/42hXiDm4c7P4FNLSBtXoB7NJm3S10V0HssoFeJFH4aEQ8lktAkqKdIB18349/r/FD7PGrpfQawYquZYVj1BmESyMZ2YUdulvgkyUTYKXy6WVSXqcFfJO9Rpejw0coKm0G9g7pFYLpPGcwDkkRVg6QzE1M3dFqh1lqgzCoYPs0aNcYvvbDwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by SA1PR12MB7174.namprd12.prod.outlook.com (2603:10b6:806:2b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Wed, 20 Aug
 2025 03:09:02 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 03:09:02 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
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
	nouveau@lists.freedesktop.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v4 0/3] rust, nova-core: PCI Class, Vendor support
Date: Tue, 19 Aug 2025 20:08:56 -0700
Message-ID: <20250820030859.6446-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.50.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:a03:74::26) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 744934a5-3488-450b-ff93-08dddf96ea25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HEEKIBfp64qZ0JFPgiQWzXqjtP4P4pd4NCOuyT3dGEST5QMLhVuzO3+386R+?=
 =?us-ascii?Q?BwpQzoLT5acg4WTMiWrCdU+YTamfWxcFHlxvhxSeFZWe1Bw4MfvVSAmKFhzW?=
 =?us-ascii?Q?RUpKxjO69oCRlUemvZTxXl3SuNNqOoBrM31fWlPRDvyoQovulT4jl5ohQV94?=
 =?us-ascii?Q?FDbrJ+itAyLdsKrHPPgoPfxaBzDYzLd5yBged+G5Zuq6GNEowmYnykmPKHSE?=
 =?us-ascii?Q?iBcbsgOcZ6OoQU24Zn5MbkxzCP5k4yyD67tkNuZjU0nb5a6rmhN+Mi2zKWup?=
 =?us-ascii?Q?VNvgfLSekirFXMXlmcb1LghFCjr06RUvfHNUpeuTR41xM6q1/gtlPc7cneYg?=
 =?us-ascii?Q?/64bXn6c2cZ5WbjfLmOLT34RI8DX1HyNy+Akp0gPc5pq7xQOYzw0bvPt8E7y?=
 =?us-ascii?Q?1cgZa7ASNM1bZYoyNt3vSb5/Jw4m2TgJtZEygJOB9CwuDjS5TzII1YswWSXN?=
 =?us-ascii?Q?4OwgAc3Xqmvm14DUNMhWq/BYhaLY+ziRW43pNgM5yQLhtN2iKvaXIolJ4uuY?=
 =?us-ascii?Q?26JdJYmt2KLwY4xpZwkBjrg93S5D0Gz4asUg/8QkLEQb7MwpgGQJhHqf3OC3?=
 =?us-ascii?Q?gRH0AaPvukOm4WQqnb6/5hJ0uP2/tArlGBNj6j23I5rmprdl5Ae/6Ouqpw9z?=
 =?us-ascii?Q?bkfq1cc2xaygMYKCbv/ZdZVUZFrvb1POAntR1/85gOS/02lwVfXyJaobOtvj?=
 =?us-ascii?Q?MO2EVbDNjKZ1FlGYZ1NYuP8P/nIWvJsD49QoWIao3beM3ZidEjCrSEaO0KKY?=
 =?us-ascii?Q?+lqS+WSuMdvFw54ZomoawPxTx3SaqPha7d+TVdXHUg2uqYJeFZCCS/l8yA+9?=
 =?us-ascii?Q?RhvNjaf7WUQ0KBp3ZFFw/nfqqHDt7qkx92bcvLDgdMB+M2kuYw3eKnU5afZt?=
 =?us-ascii?Q?TRsTeX+I63zyPyEthq2JLScPWlSGDC27qVirzhtf9oaIisJ4ES0ligkqBzAa?=
 =?us-ascii?Q?QKAkclWx/jnOi8D/SnBNXusRNG/Fy7EVRY+oJ1EvVOQgybYTnUlUQG2WpyPJ?=
 =?us-ascii?Q?Ck6knr2FYTFwxZntSm05GCv3qOao3XqfMhI5x/IfUOC625VbsL8YCqt0d/kr?=
 =?us-ascii?Q?59ri/0aAlp/YdvnZwiCKxYZvija2YJQFFCpq0QtosTXm55oiIPWFlBnANC1i?=
 =?us-ascii?Q?0HpV8qmBeALDeZr6PSvg0fudK2xhPz7cwTVTlid83iyxIhs51t9/Ep8ZLmLA?=
 =?us-ascii?Q?3YLaUH63jinFW5/RHRWvCrVM4kAMlauDAZvq6BHaHgVC7lMf0ivsEmn6OMZW?=
 =?us-ascii?Q?uBE9zaZVzoKZuygfalUdOf38xHe6c035fS2wFOs7rsXjnZoqeozxYeHbTKr7?=
 =?us-ascii?Q?7TjFvDSYBKWzySePF9wwxGSZMSrEYGIGWON5VyCOJN04BadKACnnfIBcDhpy?=
 =?us-ascii?Q?RTsss29PJIOmCk4hNmYxT869PrYiaDLNhtV+7ttYGMOvogcsUpveLg9IjBbb?=
 =?us-ascii?Q?NklPpbJA9yk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kxd8PccEFWmiDrxUg4LlU/4FxG0ZKSMOaPvqnJvK6APpDx3NvPDTnQb1W38l?=
 =?us-ascii?Q?ZO3ZH4e3NF7WzbHJ88c2ezoWt5TRt+nbRqSLD28VB7NKsTTareYkaOYVS+dp?=
 =?us-ascii?Q?UXNaXtkOfVWNLg/LWDcGhZkSwVFuUYgVr6JwOWU6ef+4PEP2dEOXjEZWJgVa?=
 =?us-ascii?Q?dKhe7l+exb+PbiSQb22m74qIzXgwGGQKbGTTj1frgtWTX8udpbYiZuMcTsjc?=
 =?us-ascii?Q?MUv4aDl2pt/1mpdpv9OHnewYfqND91AhKHweYupZIWmEH/q7mKeTw5CKXoKs?=
 =?us-ascii?Q?Z1pGimdBEcy3bwYafGMgh0XIqDu1pRG1boiLjxeVrWOw8e6UQC5VuVjXjTy8?=
 =?us-ascii?Q?x4rpgBV4N8pbl2lszG2xo8vEdYotxZqDAu+nlvRKatjJZDOSXLL0YlhCvsdT?=
 =?us-ascii?Q?sxJyg3uDRvXOXbp7tKs2HNBz7bf8dqfLLPCFQrqW4MzO7+M4IounDcmrH50l?=
 =?us-ascii?Q?uysfwua7OF7sg8vkD+hcFTVlBYNWfDHzKEU7QDcyvzSnYrNnrevIZvdKVHA2?=
 =?us-ascii?Q?8/WaV7PSRGK9qdSqmjxBXDPK8/MOPHc+b8NYf/nLQMxeDrfaD6LNliKQpXUy?=
 =?us-ascii?Q?ZGg5W985ROkDXYESla/9AcrW+S698bpZRgPSpty+lbzSZKYZuLrth41cOW98?=
 =?us-ascii?Q?kAI5aWTViw8BFuk13lqlv+RKQfW/IMR86WY1BYvsIhe7oiDwnMM7gkP/bHyM?=
 =?us-ascii?Q?1mhO34v3w/vVyEoi86aCPCdsXOxmMtsyY3QgXMEPuhi8b4Hm0EW03l8/RKEX?=
 =?us-ascii?Q?BklvLbnVzfx7sF6XGfBPhdoa7Xf93uUcxivq8Ngms3LOh2qjV03w2YmlFKX9?=
 =?us-ascii?Q?bW0XKFZp7cWI0C/6CM3ClmKh/Yr8ysEsCs6OlkGn6WvJ0rljRUHo8G43oPUk?=
 =?us-ascii?Q?/sngPJehmTFVBe0PLHko1TCA7GozWqGtchiSTlpEB3Odc45cDnera7BdNPaX?=
 =?us-ascii?Q?HwqesTVq8vZMaRMm+ySuQVneUr3Mrax0uvwNUu3Ty5ZZ4IjLGLYKOSpQruc6?=
 =?us-ascii?Q?jlNAR52wmwcGegHfT8/cZrqqpxfJVQmmVkd9zVs9P8P3sa9w2X1UZV7DUfMB?=
 =?us-ascii?Q?aF0WzVrqx5YblOWMIGZ8buAu1W1VwoEGT+hokhE8hMT0Ei3ee0oiGrhGci1a?=
 =?us-ascii?Q?xY2AhG9v7GUJgdotrz9+mi+yHzDkCnSK3MZ4XwXaTEm70QZlkcULfe/nQHrT?=
 =?us-ascii?Q?wNNv/Kp7hUCB8IhoXhAmr8RC1Qjo+dW12snEuVvPiu+ZGIsh+Kng6WI6HUED?=
 =?us-ascii?Q?tUq1JOZvC57u7JDCWXm0iDuJk4ZLtATAVH5jpOyT3YlILGbMnvJPlSogqJUL?=
 =?us-ascii?Q?dhwj2F11hlVPMgb4i9d6yh/db5wlTTgiFf1ERDgbC44dPrfqA3NhAZ/jzm0p?=
 =?us-ascii?Q?+H6eejVL9TdRmYuHvVc5cQohDLh8ofR1Zmy4N7R+emvrDeKmN3J7/2XqE/3n?=
 =?us-ascii?Q?sPoE7MVwLW5FXv5ronHd+10imlIUQkYxLLtEWCxQVgOvHp6opqITFmD4OIej?=
 =?us-ascii?Q?gEJUUsJsCHlL6DMWfExhkVBswmfuDjgUHoa0xP7Pqcw40prt1qcdkZsIuktt?=
 =?us-ascii?Q?LlVaAtUixNiaqZsbb1xZgBtdpVpp0Vtp624Fwwvt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744934a5-3488-450b-ff93-08dddf96ea25
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 03:09:02.5065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qxbj9+0Nt8yL5MHJPVK7vh2sbIvSHPMdGmT5fAgGudwMs1AAOVrNpgJ1hXUvJacrpxAyY8aRf1kZqFaIc6kfBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174

Changes since v3:
* Applied changes from Danilo's review (thanks!):

    * Moved Class and Vendor to a new pci/id.rs file.
    * Added ClassMask, to constrain callers to use only the two valid
      masks.
    * Removed pci_class_code_raw()
    * Changed Class and Vendor .as_u32() to .as_raw(), because after
      Danilo's comment I looked around rust/kernel and learned that
      .as_raw() is the overwhelmingly used convention.
    * Changed vendor_id() to return a Vendor instance directly.
        * Also, validated Vendor during construction, just as is done
          with Class. Both of these items are expected to match known
          values, even for new devices, so that's a reasonable move.


Changes since v2:

* Applied changes from Danilo's and Alex's review (thanks!):

    * Moved everything possible out of the new define_all_pci_classes!()
      and define_all_pci_vendors!() macros.
    * Used "impl TryFrom<u32> for Class/Vendor", instead of .from_u32().
    * Made the new DeviceId methods infallible.
    * Upgraded DeviceId::from_id() to accept a Vendor struct.

* Changed the names to be a little clearer:
    * class_code_raw() --> pci_class_code_raw()
    * class_enum() --> pci_class()

* Added doctests for the items that are not yet used in real drivers.

v2 is here:
    https://lore.kernel.org/20250818013305.1089446-1-jhubbard@nvidia.com

Changes since v1:

1) Use the pci_device_table for filtering, instead of open-coding
   filters in the .probe() callback.

2) Add PCI Class (class, subclass, implementation) and PCI Vendor to
   Rust for Linux.

3) Rebased onto the latest nova-next branch, which is here:
    https://gitlab.freedesktop.org/drm/nova.git

v1 is here:
    https://lore.kernel.org/20250813232859.224316-1-jhubbard@nvidia.com

John Hubbard (3):
  rust: pci: provide access to PCI Class and Class-related items
  gpu: nova-core: avoid probing non-display/compute PCI functions
  rust: pci: provide access to PCI Vendor values

 drivers/gpu/nova-core/driver.rs       |  33 +-
 rust/kernel/pci.rs                    |  48 +-
 rust/kernel/pci/id.rs                 | 602 ++++++++++++++++++++++++++
 samples/rust/rust_dma.rs              |   6 +-
 samples/rust/rust_driver_auxiliary.rs |  12 +-
 samples/rust/rust_driver_pci.rs       |   9 +-
 6 files changed, 682 insertions(+), 28 deletions(-)
 create mode 100644 rust/kernel/pci/id.rs


base-commit: 0dfc23ac2c5b3a62ab27fb9b6ee582b4bb5ce33c
-- 
2.50.1


