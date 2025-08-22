Return-Path: <linux-pci+bounces-34503-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCF0B30B9C
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 04:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E36A9B63CA6
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 02:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306641DFCB;
	Fri, 22 Aug 2025 02:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vr0XA+yd"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CE1192B66;
	Fri, 22 Aug 2025 02:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755828242; cv=fail; b=CCRh4Cj1Q/o27YMTUK6YVNl+G/NO0757Ss7eZDRQjWXZDg7GRvS006251AFw/wHzXy2Iegi64DlRRC8pbubJ7naAMLsIFA2MW/dzYWoEmubRFq5NpJXstOgJ8YVqKTB6g5978/Yj94LIjSK/F4YnOi0IykgSy1HdDdhCkH5b9rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755828242; c=relaxed/simple;
	bh=ZCpfQ0B0sEVwtJ+JbDnAe6ujcinzyi7cXfwuqWrKVyA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=M0AcfoJiFViXxPX+KK/XDKb4inCx2bMdjASJtkk5sEwGGy8RFlZCsXgJWYomeAsAjRC4wjnj31FMIlhqtOdbPgAdYvEHHpi2GHlVp1/thHjUjy9Fv8qZbDSNYlO+dQ2K2ZosGZgk7w2/aFvK/0cOV5lEpWuYmnvm1BFmniqNJpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vr0XA+yd; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNtmS2FK5J+TJznC5kSxNXYGwzPSli0wxSY3958O7V7T/Z9lCr/YmSty2kTKggMNZGZaUXL0ojZPLryoEm8zQzcsSUfh2Zn0/kEt90yMz/h5DdUdGfcWIOwCF7KsRcOHFkMHhAyDyrzXGqCq6JBs4sHrs4PjiFiAHyqN6cWOghhUnFq5xplfyVx46Rr/cweoEqOr7a2hW7ODzttRMoW1e+tK+eWB949rtWTda7JUAk3RyRY5C3tD74RP1MNbEmMtszUukNGDxpAqvftOky5X4BYjZsPclH5vws2RLrx9zgmmMInEW/S1ivUQ1kAvt2GBlJLEwDOa6/vAipYjUE+dtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXmX7epHXzw6fyFEHywBwGtB6SIrqUauTnctmuUHGoE=;
 b=cNVNHnPmSxdsXt0sH/vktrpLCIqq4ZmIv05ZxnmM4I5JwJwWCZqcdualZUQgXlQ1zIEEXZ+GDHla4jCPXs84IKK8pPi/8/Dns+W1hNMmq7glpUvzLSlaj0MPwNGzTLr3eKNx6QuRub6MqYSLSY541Y5t7iK8usrWDK/1ApkDX7corufaz2BvEdSJv0dBx64mW/Zfd5P7ALAF6ccnD1WyWtZi/XHT2V43DN1UvRa+FBoTvHZNMyAcs9zHHbH34Yl+pzcGy2yxionm62aJusYGX4cOCMWekQy6Dq/FPwzklqSdFkRAIFg1dbLFUMhGwyon9L1PqpidY19+PHv9fMbQbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXmX7epHXzw6fyFEHywBwGtB6SIrqUauTnctmuUHGoE=;
 b=Vr0XA+ydwYsC/iKyUVZN87hEC/H5u46FyaLsg2pMu/9uLL630svpY6Ij4Tx7ViHKJ+O4JBHtAR3Hc9QEz8W60mxErgrQ1gT8bTW10JYWmoe3pBBzHICnrDXfQ1G+AF9cQ4vjIDF/1x65HU3tDJn8GXRil2ZTfs5i9rzdTgA09Mt5SU01vGe3ciDAXh8rMgDo9C6ntmAUEXiNvy2zsdcGj9tLc55MkBtVpRQI4yWdwhpiMCqVkRBXe6ELHZdFVAVEuVKUoeciFhxb8dI+kQYW2zZBUjnrW+0IumrvDVxMfP17+ItatdMNQYUKyw9MEEFEhbblyElT4PIMfnxqoUI+DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by PH0PR12MB7907.namprd12.prod.outlook.com (2603:10b6:510:28d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 02:03:57 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9031.023; Fri, 22 Aug 2025
 02:03:56 +0000
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
	John Hubbard <jhubbard@nvidia.com>,
	Elle Rhumsaa <elle@weathered-steel.dev>
Subject: [PATCH v6 0/5] rust, nova-core: PCI Class, Vendor support
Date: Thu, 21 Aug 2025 19:03:49 -0700
Message-ID: <20250822020354.357406-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.50.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:217::8) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|PH0PR12MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: d767270f-3c46-42a9-c07d-08dde12026e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ROawfPKt9XBAqUuY5mMPJyUNmFXtIoc+wrKQwDoNZmf9tSk/DXiDfIYLKITA?=
 =?us-ascii?Q?Ckmmn7iDGxvXE0aZ47HbR13zuWh3RCS02+fPQ+gheRIR5mf98Nf4TWcULTVM?=
 =?us-ascii?Q?VDLacnkMsBzTu5wnX31VtL0UDVrS641SLV/34acQ4JDBbRrSm3t5Cj4FI3ru?=
 =?us-ascii?Q?XFd6MhwBT5gzE7neS/iT1Ns5RJDvKDmAV3aqMLUgAJgT8vy1kwgjrEtvdAh1?=
 =?us-ascii?Q?9ryl8oSzAsUr6gEsVe34AMTzCVJWrlb+jLP50XHtZP6PM/WCVN/pbLYq5dcC?=
 =?us-ascii?Q?bkJLAy2T8PjbvAr+2ri/fEe0JQOX7oNRfTnwfc41xAP3AVHib+Egfqs4ddiB?=
 =?us-ascii?Q?89M/J3Sf0Bn20RWU000XvwxE5JeHyYSdhqw61JXa1CgV2cHlknYceZrZhhV8?=
 =?us-ascii?Q?vsYRdGfgtvq/Y+wqOMNJx117SchXFz79XinmlgUMQWXNNKKyKo2Yfr6gnPRq?=
 =?us-ascii?Q?8m6stxri1IR6Fy3hVAW43QfNmef3yvRMOy9nHTfIjMdSReBp5mpYXUA3LwMj?=
 =?us-ascii?Q?Fnc4HQyKJRKDuPZ86w4fTKVtXgVUb7cSoDeHmMW9JX6LgeXMY+3MU5cWS5er?=
 =?us-ascii?Q?XwS1BCteNOZf+PUFeisAwAikp4Op8OctlL5hyvvcq/i6rjEj93g0GQ97P8nQ?=
 =?us-ascii?Q?WRop1Qg+hgNz/PqWtILhDBtrATPJ69nGJDLdWVMh/n1JC6Adbg4O+4iKImlV?=
 =?us-ascii?Q?4p1b/8NQQW6nBlyGBnCyJl6g1acF4rqYQoqRONxkZ8di+PtGIMIIvxJgmIcC?=
 =?us-ascii?Q?G1PIi7phBW58yoM4UewZHOT30ROws1N7X0YdEJrtUklNCe/opw8DKd8a9AwT?=
 =?us-ascii?Q?5Pe/1HPFlFCGOMPWdAF8PFD1/szYdFOiFXqyNCz7yEW3ChmrQJfyNgHcbkw3?=
 =?us-ascii?Q?gZ26TgO3EnoxGk9W656txO5Mp16ewjtFysOPTt38wr/zloluN9miH6J9oqyK?=
 =?us-ascii?Q?5f2kAU2SGg9NXyJsgOV7y+aoNjVmjpi3h2TfdAIyUsZAWwBdT09X6Y4y61n3?=
 =?us-ascii?Q?BTUKrys9GgIvu+j1tE8vIWk8GPnKi/Da+ulQylF2gnZo7W/ub62U2B5hr/ZD?=
 =?us-ascii?Q?7Wnj1u2NJ1G2EORVwVSAzpeplOBaeypprZL3HNf28NkOM7a2+eDwKFf5OhLm?=
 =?us-ascii?Q?/qLstN9xIOi519KM/XRsM5eqa5NFW3dR/UDanU7ZQeMCr37wm1iB8gNiLEvn?=
 =?us-ascii?Q?m8SYEjeN6/XoTAq/8nceBtL2RULbACa8B8JJVO4UhqP4lDH3ZI5TXSA5j/m+?=
 =?us-ascii?Q?ZjdwswRQFbhKiOp4bEn7AmJCxF8EGixCz5/p+vNqHXKODZopt3WiF1hRqMdv?=
 =?us-ascii?Q?elcm1MCdLWK9bt2N6AtVlZE60tBUegDoHUPYLjgw8rGJ4lUq7FSUXnEKyHBU?=
 =?us-ascii?Q?9tcsyCdzPYuagsDxEvFKCJ+NgNGhSn2x5IaFr2RkrC94HjWYa+oxsbw9ZpYg?=
 =?us-ascii?Q?C66gRnkMyxg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3tqlcbi0PbKE/Ml6GmykdoXvH3hLDc/lleQU8bE//bC2uXiLlW0gmDtYxCvT?=
 =?us-ascii?Q?aVUxRZlawiL8J4wJTF1gilDUzRZ2m10Z8xJe9eit3zeRElhcb1cvc/N7Ue+h?=
 =?us-ascii?Q?D08jO6zfmhwiM9G+o447k277WxQQqcGMh7MbuIyq/4+issXL52Rol9zkGpCe?=
 =?us-ascii?Q?Xbo09HIJJP8gv8sEbixKvuK+S+0VHzEqxQETkTZfkL3tNAmO91xczJpuVkaL?=
 =?us-ascii?Q?6w3UUli6Uvn9YE/4W2MUP7WMLOnJYCfZVQN3FSD4RZSr0+L2Q+dgMSRTS1X+?=
 =?us-ascii?Q?IIjlxGSpFlgyP1WAsqlyZ2Y99nl1NHT/wQOLuT8SA2OzVi801lof99xidP7W?=
 =?us-ascii?Q?NUPvqDnGJehC7WZvjEid8lCPLhnaI5ptHgoiVn4PvAU4Z2cqtZEw06mrBi4T?=
 =?us-ascii?Q?hdq6OfJdUr6bdNVlMVeLNvyjLFSJka2Kkhe33dp96nWMP2BmAhrieUkIXS1p?=
 =?us-ascii?Q?0osi8ttqgVnG/KPIZX/tZvgeuzaitBGmoOGto7mXYrlnEXQqV+06hkiiP+vc?=
 =?us-ascii?Q?KS5XNojqRESnXsAJ/rnCETW+kNznMNZkXrn2mNH86JPeQ0vSbCRZXjRChmyQ?=
 =?us-ascii?Q?528p+2Wy1v0lKvqe/BqszIKkJc/66Pm5eccpvIc63cTh5pOZQ3BjT8gXfWsG?=
 =?us-ascii?Q?LCzxOJtwAKKDmR9KRWwlzvcxKtxPnyHoivpffSh9XZxtXsJq3PvjBtQCf6Et?=
 =?us-ascii?Q?LO0aHCxRMpe2xAtoweOpHU1OO2kwkbpwTuhjHdSoK2RsoZMJdMBnD+ZcvLlR?=
 =?us-ascii?Q?OikSTAvPTGOpW+kLC7sHxrR5UUXRBT5Vxuh5m+q7gu1aBIitzVNpdVd43loU?=
 =?us-ascii?Q?cNrtXz8A8qf2bYcNeiK8RGs1rqkQczD4KfELC4RMHgGseAdJ5iX+h1Y1yiXY?=
 =?us-ascii?Q?JZmSDbH6240FT0YcnYqm/zlFFGgTiVLhLSo8eLRUOsUhyHOqSe9lJD9Q5YLP?=
 =?us-ascii?Q?dV0Dm25ZGuVhj96BqleRMUan9I6tKDC2Df7ynkIh8+DPtrsJn3EVqNJQPfvW?=
 =?us-ascii?Q?R9I4RBzDN4nK3A1OUvJjT6qcqoFz0I56O90hsKLYwlZqv7uGRScxeny/R5x4?=
 =?us-ascii?Q?4uVTC0Ik3IOhcVFTvY7v0z08jmug8LVRUZ54osX8UHZPr+NqYd6zN3xChjZv?=
 =?us-ascii?Q?K/Tc64Ed3PixaQf8m5tuXA1j4HMqBTqEvymjwaPegj8AyYKawuE8vvsaQSK0?=
 =?us-ascii?Q?xg2Orvy0vnzBTcNKfzO42+5w4QHHzPbwnVahtzNhllkJB2eqAi4ap4R4KSUg?=
 =?us-ascii?Q?1271xylHeGsdSVdL5kMf0HcEt2izN/euBqaYr60Y28+R3flyyYg3TRHSleKg?=
 =?us-ascii?Q?88SNvDKOwCG0fnlD63GMzAonNX1PU5XEdt9z1etJ/RSI2UwYAyk0//bn1FTU?=
 =?us-ascii?Q?D9FhkhOK/vqSpFOnOPa5Kekl29ZBTLIqaU8ojN/j3sRshgN+lZ8K7PtjrZHO?=
 =?us-ascii?Q?2WFJquMesMYjtiCuYeO32jGNHaSX3BeeyGqWyzAhXuDrWuc4dQFUdo7E5qmR?=
 =?us-ascii?Q?7/3EyOIJkw/NIhmNzOzvvQaGVKICvTuLQdrjThcEZX1t/rloNwI+ClIfSMwe?=
 =?us-ascii?Q?YSzVti721sEwAYfiIEVgJXU5Qspxr4Zax6yPMzTm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d767270f-3c46-42a9-c07d-08dde12026e3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 02:03:56.5557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLZNxC4VzVA2m5lq15+nUEyNpWJx1uANy3nLmztNFwKEG7FTSHpiPrAF8/BxqJJK7NvVuY9Z122tZiIqYeNHEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7907

Changes since v5:
* Applied changes from Danilo's review (thanks!):
    * Split the nova-core patch into two patches, for nova and pci.
    * Added rust/kernel/pci/ to MAINTAINERS.

Changes since v4:
* Applied changes from Danilo's and Alex's review (thanks!):
    * Reorganized the patches so that the Nova changes consume the
      results of Class and Vendor upgrades, all in one shot.

    * Made Class and Vendor types get constructed infallibly.

    * This was all somewhat disruptive, and also required one more patch
      in order to properly separate the various steps. But I think it is
      all correct now. And CLIPPY=1 builds cleanly too.

* Elle Rhumsaa provided a Reviewed-by for v4 (thanks!), but due to the
  churn in v5 here, I thought it best to not add that tag to v5 yet.
  Instead, I have directly Cc'd Elle on the patches for now.

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

Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Elle Rhumsaa <elle@weathered-steel.dev>

John Hubbard (5):
  rust: pci: provide access to PCI Class and Class-related items
  rust: pci: provide access to PCI Vendor values
  rust: pci: add DeviceId::from_class_and_vendor() method
  gpu: nova-core: avoid probing non-display/compute PCI functions
  rust: pci: use pci::Vendor instead of bindings::PCI_VENDOR_ID_*

 MAINTAINERS                           |   1 +
 drivers/gpu/nova-core/driver.rs       |  33 +-
 rust/kernel/pci.rs                    |  46 +-
 rust/kernel/pci/id.rs                 | 591 ++++++++++++++++++++++++++
 samples/rust/rust_dma.rs              |   6 +-
 samples/rust/rust_driver_auxiliary.rs |  12 +-
 samples/rust/rust_driver_pci.rs       |   9 +-
 7 files changed, 670 insertions(+), 28 deletions(-)
 create mode 100644 rust/kernel/pci/id.rs


base-commit: 0dfc23ac2c5b3a62ab27fb9b6ee582b4bb5ce33c
-- 
2.50.1


