Return-Path: <linux-pci+bounces-34504-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E18B30B91
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 04:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FEFFB65505
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 02:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7CF1CCEE9;
	Fri, 22 Aug 2025 02:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iJvGYnJB"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468131C5D46;
	Fri, 22 Aug 2025 02:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755828244; cv=fail; b=DJogrTMc3h/2YBeDpQTUPLoOSJI0mpUsi+7F/rHQgrsDkEkdH+PIOhx+j+XZ9pHH4yx6yxKdIt/SemSaX0LB/PCeTrSwhIAnXVFnza0Fy5zW2dvEKON5iKaIqH3Btk5aVvN86a4Ji+m0/wJTYOUhj58ftozEfNtS6BEe+JN0f1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755828244; c=relaxed/simple;
	bh=Rf4rDMMLpdSXGfp/bxHyjnLNnRZGFseZsNii5MewSMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qIN1io5OTts2orhghuS9kqBWSBHLM4t851Oxet02Cb0CW7WBhEFsWHhEo1vW8Kcr0JopisxewU1mVX6gNKznb/POA9coI9a0ljfn4Uc+CSm0B0jAecLhpEkpRCmSqCxACZ/IbKouY+pG1raXnB2R58AcD6I0gN8HwMMa7jAh8S4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iJvGYnJB; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfcs2Xp4lR+i60Y9Bve3xoX2cCsD3WwIjPTZMsL3oTql6ycqsJodqUxAHswHEmuOKEhNQnPyattv6kXlcJ1kSyCMe99sD9whAJ+uwoL1OwAXTGhKKMB07DZInLzgATD5/GaCFKP57ErE/cMmiyJtyxZ+U1nySFTwrLG+lENu9ogVIHYjQ0AEM/+fEB+nr283olsp20r54MMyK2oLaPPCUm/PpDZo61ToBNLToD6cstQHWR8k7g56/f5PmfESwxYnJ8NnP2RN1ADjCgb/mJBalmVyg2XKR4lO/o7PI3kaoWl0o2/1RQ+FCjBHdkq7pP2FuNveekGmdb6uH6pWpBQmOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWt9+QqThqfG+dIcl9ZkwH7IrgTx0L5lrR28SNhCn6c=;
 b=PDkaM10U3i3VVNG5HRtMLHYq79blIQhOj/RLFTozwmtDTt7qKXLYlaambAq9jhKY5Zh9QOI5GsleCYlj5k5MatxE0jhx2AAECkMpv1PGzOQ/G+YzViTesZenMhRd4YHIGsaVe1OFBrgnsRIurEY5FcfmyWg8AfKN74hisAMQOj4EOHQuJOs+38wXobP2nRfjuU+KtWaFsN/OyDjF9T/EFVso8b7fxFNmcIJcoB4QnnCAkvpH2hvN4ROtbjDqtyoiA6ztOwOqIYz/5iHE/Pe78BYcmhXrB1fQcB33qGh1kzpUwkkH79V8sQU+vI3U4QBgxI5O37h02GJQmLm4vYj8nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWt9+QqThqfG+dIcl9ZkwH7IrgTx0L5lrR28SNhCn6c=;
 b=iJvGYnJByoKjemsZ1842V1yUDvOQ+epWv17hGjZRjzx0joG0Iw1Wydz2EI3jK02xjCueQgQrS17Qqj/U/lDbaFLwHIyeCf4LPvW4Rg30xMcJM+EaBdvagOZZiWOgTUor4cs114Oqdfzh1Zy0LcyTO0BcwP2j3WrRgt6Rn/38VLURyzWz1RSo8t0d2j2x0n9ikrnbptlqhv9Ay1gwdfo+JlLIDGR6rOICl1N4TyYTbpxXQWm5ct05jD2rx/K8lm7r//sTdLYINatnxJUn7WnxPn6QIAPuHSWfXEpSi0FbXkUlutRSI/jhu47fm8UPt+j09sxy5vGr64sE0JqoNHIajA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by PH0PR12MB7907.namprd12.prod.outlook.com (2603:10b6:510:28d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 02:03:58 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9031.023; Fri, 22 Aug 2025
 02:03:58 +0000
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
Subject: [PATCH v6 1/5] rust: pci: provide access to PCI Class and Class-related items
Date: Thu, 21 Aug 2025 19:03:50 -0700
Message-ID: <20250822020354.357406-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822020354.357406-1-jhubbard@nvidia.com>
References: <20250822020354.357406-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0132.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::17) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|PH0PR12MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: f7cef63c-8ac7-42b4-cef5-08dde1202810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v+E5NCQhNuy367vh3yeBjUV6GlUCBiySJvS13ZbVUqzvQOXtsJw9kTJx494q?=
 =?us-ascii?Q?CzZUhjCawGMn6+pg6YNGe24eDflmHmKTQiU9BBZ95AGoRFVUvXnSN05RYRkQ?=
 =?us-ascii?Q?VP32ksqwoEzRk1c8tlvU/2d2OvZtxXhe3x5V/Oj1M453Zdr14+1DAc2/EQd1?=
 =?us-ascii?Q?dY19gIv5RgpgJryFBIMhrqksrGUoWkswexr8VsSW4Yj38ZI9ikyGuszE05F1?=
 =?us-ascii?Q?T4y+6lVcil2SCFb+tNtAD7nPiOKcFD/LtKYe3tUXLUGFE2DsOnp0x6qO0kHA?=
 =?us-ascii?Q?lpgBRd7NDZnvwJVPIJYwbW6SlFgOY+QUzmGsNAIHo49OKnASUYxBxMNqK/U5?=
 =?us-ascii?Q?ZNTovQfQL3nd6ZZZoBVltycYugufhZlz7c487t3eS7WUvEtOjQYOZgNQ6Ccb?=
 =?us-ascii?Q?DxyHXEe2vd2InHkW2X6sIivsSD66giM6pJ4trq8ofxhC9eweuaGCm9Mup/Tt?=
 =?us-ascii?Q?ecFzCZ8sJvBANAY/woMAdD2GtCER6bfrsL6iveO1KSZ5JQQ1xIvOlYdBFnBX?=
 =?us-ascii?Q?ji+xIJhshO91iwzkbtYDHF9/YWSOTqQqOi9dg5O25HLmzYA7vzMfcdM/Ugt+?=
 =?us-ascii?Q?UepbfVG8rTYK6wvpFs3RsgQK6vY/dCe8pgIVXvpbfmQsVN5B/3JRQZXL+K7/?=
 =?us-ascii?Q?+Q8da9BWUopi1+/LQORp5YawyL3uXbcFoTygZsAxuvJ7tyj60RXP1BJZyP0h?=
 =?us-ascii?Q?2w4fD2dictKwCvq9AjTXY0pbvXS+cE2EhMPbo0NPyTKch6Mxv0VDR3tdVFrZ?=
 =?us-ascii?Q?Mr+yqHuyjB1v72grI7IQtCKuNkzNAQRdAVRcQYLYsytP01jHnQL0zRirzkRH?=
 =?us-ascii?Q?tb0yKPvozSZqqKcaQn1aRMoxzwqY/Y5Hjy3AOsAFr3T06XQvsf0WNSmsqDIY?=
 =?us-ascii?Q?qKFNyDW95Q5xHDxKlQH3Div5ZSz+JOxNRi+pxtsY/wOXW22SZ+Z6fRuwkKQu?=
 =?us-ascii?Q?FYvP6N2c/uUQ9AbIMFIBJjRDQOjCcb8g/6U0aKRItER6NpXzvo52IW69R25E?=
 =?us-ascii?Q?PcGp9UUlLPwXlJNSYqWuFaF7ns2Ib+Y1Px4ULamuFTXroYgS4mkV3Ojar7Zi?=
 =?us-ascii?Q?bfC1dhbytU5HMt5gtu9tuL5e4mjHN87SDjwM41kOdTBGrpzCgDjThGdoaJXk?=
 =?us-ascii?Q?BxYskh7UN/npBd4BmRzbDCcN7HrcHq8ATMZcKdLeYKZrodQC4QQpaVCVJi48?=
 =?us-ascii?Q?aURd2EVCAtjMmx18CbWgMOJYqYA8EGxLIwTb34YXinsE/NPEmF2LN/QvR7Zf?=
 =?us-ascii?Q?JcrvjFTd/9iNMGXEqH1N90/+1PlB51qmg5jMC4B9afDnqRSTyZSCoCxDLrSF?=
 =?us-ascii?Q?N88tlVlwoO5r9q0IMIVdDqBcVC2AMZBud2R5s7XVHJ9vFyTgccwd5GAVMQab?=
 =?us-ascii?Q?RiCciVGLC3xnjXB/s7fchPChBZUnuQQbwFr3A9igE3NPEd08naCxM1QGokXv?=
 =?us-ascii?Q?vk0AxEzA2rA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?plbgGPcyb1L+dTXI+HUIyr+IHpHlV1zR9wX+fKwQKwO7B/+KiYVFuaidFNkC?=
 =?us-ascii?Q?u2LVpKCmPTKgXpOqqThg764c1lPbONPBJF+d4e5yd2D8iNyQOyohV52MHeR8?=
 =?us-ascii?Q?ZZNrCNsUqVgeoophHMUtDrl04Udc2mYrOEcdLnAiM21v21g4O57VEpPvkq9q?=
 =?us-ascii?Q?OmMJIzekTm3IZXLeRYjknesig3O5FBU45RlsEtBGvW0DqEXtZlDrrP+on/ms?=
 =?us-ascii?Q?9q8LVBOTR59uoxNxeeaUHg9i39mgRfLMT6SSus1eB9zPgpH1GAN1ftS8HaKz?=
 =?us-ascii?Q?rNVj4uDhXC2VUnrAhgFMQ6a8AdZUdCF3YZ03W8cWAqenwSfUAhWb5U5x0Z/z?=
 =?us-ascii?Q?D/f/25jMAqCMY4P3vCtfmWvs4FCdnEYKa4L+s7SUhuoShFraThDISRMSc5v1?=
 =?us-ascii?Q?bIF069lSXw0mS7N1kUZ4WucsV3k+hafgJQiQtls9oAakxAbjM09goOdp22ZM?=
 =?us-ascii?Q?sWxOsxs6nk2R8iKpwQZpWS8jr2a8adMQF5CQAvZu2CGDalzIm6jK6z+zAdzp?=
 =?us-ascii?Q?GegCPhfE+yjCt3Q5gM8ISL6Bs092aeHtakKif9Bos/5/n2UllFLJwnD2FfVC?=
 =?us-ascii?Q?wORhS9a/E6ZQPEHWc8FVKXlY0xE+I2vHxuXQ2oAIXXh5neyAJgPiFStdkFcf?=
 =?us-ascii?Q?9xse3f0gu09mf6delA2wuHK7p6ANl0wp1BErEVw2aw+PZYABs/++e45Yz4L1?=
 =?us-ascii?Q?8O/NQkO7ANnmd3zbdGfZ8gDOLVeFhB1kbE3FPVB5wxbWzROPjMe9uBWk8+h/?=
 =?us-ascii?Q?+AQgTIFmG1ZbAulaL6COpDNcSVQVZPGo11xt8ATCfDqn92F5dTF2CEdfrcq5?=
 =?us-ascii?Q?fGLVCaQvRpgIFY0fqhaNytwHA7W+Ya3+BPNpEwlPNizx8ZQSOePDsWg0jmHx?=
 =?us-ascii?Q?x60rwahNNTMcma7MjoPVZDf7g1YUvyoUleW1gScJRhSzukhEdyl8YOCIHftE?=
 =?us-ascii?Q?8RDZ+RGLsAcN+XhyU4goqR3ntd2sCqWJvwSNgxbdvCe86hv3/T5uTVPkFzJ0?=
 =?us-ascii?Q?ex+X/zQpX2qrcWIQMdMXbahKwVjq9DvTG0wI6rXTVXofMjEKCNX/VJ2g3hVC?=
 =?us-ascii?Q?skpRYb+xpEYFCMSvw/5dCnRPcW91XvN/VdgFQvyqV6aetU5s3Mal1KU6ixHf?=
 =?us-ascii?Q?bkSWu9FIRrkyq73jCsHleFsHzD5K2IUwEFo37gY+iCvTQ4XO3QpNPb6QYMsm?=
 =?us-ascii?Q?wpQ2Up5SBGezqRhrrgpQeGlPADwXRn5MaecfVNC1CAibKSdxYcBOUcfOtB2a?=
 =?us-ascii?Q?iingR+nGVwieh0lWjs+ITayV6EUJWdSe/UgJvJlbsKBjJJJu0cM5W4ccqbGd?=
 =?us-ascii?Q?Lk2F/gCP94zzn3h+Yi/LKLrFMXexE9lETrQIsZJE6W4CRATG4RgOHjfK8L1s?=
 =?us-ascii?Q?myg18ss8JBMCTbth9C49uD3qyYW2Wf0qy93fE6h+GT3IdmYclVglYfqKjWzx?=
 =?us-ascii?Q?worojH/aQkncQakuCE+A1wfdwuxwyF4/WByJ2N20PnhKx9idAxszgCm3FrvU?=
 =?us-ascii?Q?Gj8hQBlvVTVgTCZfMpS1745HIzRHKpKANdqPox5tNskpM8Fvdv1LGHdhBfCP?=
 =?us-ascii?Q?xqWv9tApJzqOeUO6ZDsQX0Tdkw5NCQVhWXFHTgE7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7cef63c-8ac7-42b4-cef5-08dde1202810
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 02:03:58.5557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XyzJYVKepclGEZCbYRlqcD934BuzNHU7A7XihSAzsYIVvvJC01d6oeEJB2k5xFXyFtzewYE8rXyxtoNoW1N+qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7907

Allow callers to write Class::STORAGE_SCSI instead of
bindings::PCI_CLASS_STORAGE_SCSI, for example.

New APIs:
    Class::STORAGE_SCSI, Class::NETWORK_ETHERNET, etc.
    Class::as_raw()
    Class: From<u32> for Class
    ClassMask: Full, ClassSubclass
    Device::pci_class()

Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Elle Rhumsaa <elle@weathered-steel.dev>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 MAINTAINERS           |   1 +
 rust/kernel/pci.rs    |  10 ++
 rust/kernel/pci/id.rs | 239 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 250 insertions(+)
 create mode 100644 rust/kernel/pci/id.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index f0d09f7e04e8..4576905a9148 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19532,6 +19532,7 @@ C:	irc://irc.oftc.net/linux-pci
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
 F:	rust/helpers/pci.c
 F:	rust/kernel/pci.rs
+F:	rust/kernel/pci/
 F:	samples/rust/rust_driver_pci.rs
 
 PCIE BANDWIDTH CONTROLLER
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 887ee611b553..0faec49bf8a2 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -23,6 +23,10 @@
 };
 use kernel::prelude::*;
 
+mod id;
+
+pub use self::id::{Class, ClassMask};
+
 /// An adapter for the registration of PCI drivers.
 pub struct Adapter<T: Driver>(T);
 
@@ -410,6 +414,12 @@ pub fn resource_len(&self, bar: u32) -> Result<bindings::resource_size_t> {
         // - by its type invariant `self.as_raw` is always a valid pointer to a `struct pci_dev`.
         Ok(unsafe { bindings::pci_resource_len(self.as_raw(), bar.try_into()?) })
     }
+
+    /// Returns the PCI class as a `Class` struct.
+    pub fn pci_class(&self) -> Class {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        Class::new(unsafe { (*self.as_raw()).class })
+    }
 }
 
 impl Device<device::Bound> {
diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
new file mode 100644
index 000000000000..1291553b4e15
--- /dev/null
+++ b/rust/kernel/pci/id.rs
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! PCI device identifiers and related types.
+//!
+//! This module contains PCI class codes and supporting types.
+
+use crate::{bindings, error::code::EINVAL, error::Error, prelude::*};
+use core::fmt;
+
+/// PCI device class codes. Each entry contains the full 24-bit PCI
+/// class code (base class in bits 23-16, subclass in bits 15-8,
+/// programming interface in bits 7-0).
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::{device::Core, pci::{self, Class}, prelude::*};
+/// fn probe_device(pdev: &pci::Device<Core>) -> Result<()> {
+///     // Get the PCI class for this device
+///     let pci_class = pdev.pci_class();
+///     dev_info!(
+///         pdev.as_ref(),
+///         "Detected PCI class: {}\n",
+///         pci_class
+///     );
+///     Ok(())
+/// }
+/// ```
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+#[repr(transparent)]
+pub struct Class(u32);
+
+/// PCI class mask constants for matching class codes.
+#[repr(u32)]
+#[derive(Debug, Clone, Copy, PartialEq, Eq)]
+pub enum ClassMask {
+    /// Match the full 24-bit class code.
+    Full = 0xffffff,
+    /// Match the upper 16 bits of the class code (base class and subclass only)
+    ClassSubclass = 0xffff00,
+}
+
+macro_rules! define_all_pci_classes {
+    (
+        $($variant:ident = $binding:expr,)+
+    ) => {
+
+        impl Class {
+            $(
+                #[allow(missing_docs)]
+                pub const $variant: Self = Self(Self::to_24bit_class($binding));
+            )+
+        }
+
+        /// Convert a raw 24-bit class code value to a `Class`.
+        impl From<u32> for Class {
+            fn from(value: u32) -> Self {
+                match value {
+                    $(x if x == Self::$variant.0 => Self::$variant,)+
+                    _ => Self::UNKNOWN,
+                }
+            }
+        }
+    };
+}
+
+/// Once constructed, a `Class` contains a valid PCI Class code.
+impl Class {
+    /// Create a new Class from a raw 24-bit class code.
+    pub fn new(class_code: u32) -> Self {
+        Self::from(class_code)
+    }
+
+    /// Get the raw 24-bit class code value.
+    pub const fn as_raw(self) -> u32 {
+        self.0
+    }
+
+    // Converts a PCI class constant to 24-bit format.
+    //
+    // Many device drivers use only the upper 16 bits (base class and subclass), but some
+    // use the full 24 bits. In order to support both cases, store the class code as a 24-bit
+    // value, where 16-bit values are shifted up 8 bits.
+    const fn to_24bit_class(val: u32) -> u32 {
+        if val > 0xFFFF {
+            val
+        } else {
+            val << 8
+        }
+    }
+}
+
+impl fmt::Display for Class {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        write!(f, "0x{:06x}", self.0)
+    }
+}
+
+impl ClassMask {
+    /// Get the raw mask value.
+    pub const fn as_raw(self) -> u32 {
+        self as u32
+    }
+}
+
+impl TryFrom<u32> for ClassMask {
+    type Error = Error;
+
+    fn try_from(value: u32) -> Result<Self, Self::Error> {
+        match value {
+            0xffffff => Ok(ClassMask::Full),
+            0xffff00 => Ok(ClassMask::ClassSubclass),
+            _ => Err(EINVAL),
+        }
+    }
+}
+
+define_all_pci_classes! {
+    NOT_DEFINED                = bindings::PCI_CLASS_NOT_DEFINED,                // 0x000000
+    NOT_DEFINED_VGA            = bindings::PCI_CLASS_NOT_DEFINED_VGA,            // 0x000100
+
+    STORAGE_SCSI               = bindings::PCI_CLASS_STORAGE_SCSI,               // 0x010000
+    STORAGE_IDE                = bindings::PCI_CLASS_STORAGE_IDE,                // 0x010100
+    STORAGE_FLOPPY             = bindings::PCI_CLASS_STORAGE_FLOPPY,             // 0x010200
+    STORAGE_IPI                = bindings::PCI_CLASS_STORAGE_IPI,                // 0x010300
+    STORAGE_RAID               = bindings::PCI_CLASS_STORAGE_RAID,               // 0x010400
+    STORAGE_SATA               = bindings::PCI_CLASS_STORAGE_SATA,               // 0x010600
+    STORAGE_SATA_AHCI          = bindings::PCI_CLASS_STORAGE_SATA_AHCI,          // 0x010601
+    STORAGE_SAS                = bindings::PCI_CLASS_STORAGE_SAS,                // 0x010700
+    STORAGE_EXPRESS            = bindings::PCI_CLASS_STORAGE_EXPRESS,            // 0x010802
+    STORAGE_OTHER              = bindings::PCI_CLASS_STORAGE_OTHER,              // 0x018000
+
+    NETWORK_ETHERNET           = bindings::PCI_CLASS_NETWORK_ETHERNET,           // 0x020000
+    NETWORK_TOKEN_RING         = bindings::PCI_CLASS_NETWORK_TOKEN_RING,         // 0x020100
+    NETWORK_FDDI               = bindings::PCI_CLASS_NETWORK_FDDI,               // 0x020200
+    NETWORK_ATM                = bindings::PCI_CLASS_NETWORK_ATM,                // 0x020300
+    NETWORK_OTHER              = bindings::PCI_CLASS_NETWORK_OTHER,              // 0x028000
+
+    DISPLAY_VGA                = bindings::PCI_CLASS_DISPLAY_VGA,                // 0x030000
+    DISPLAY_XGA                = bindings::PCI_CLASS_DISPLAY_XGA,                // 0x030100
+    DISPLAY_3D                 = bindings::PCI_CLASS_DISPLAY_3D,                 // 0x030200
+    DISPLAY_OTHER              = bindings::PCI_CLASS_DISPLAY_OTHER,              // 0x038000
+
+    MULTIMEDIA_VIDEO           = bindings::PCI_CLASS_MULTIMEDIA_VIDEO,           // 0x040000
+    MULTIMEDIA_AUDIO           = bindings::PCI_CLASS_MULTIMEDIA_AUDIO,           // 0x040100
+    MULTIMEDIA_PHONE           = bindings::PCI_CLASS_MULTIMEDIA_PHONE,           // 0x040200
+    MULTIMEDIA_HD_AUDIO        = bindings::PCI_CLASS_MULTIMEDIA_HD_AUDIO,        // 0x040300
+    MULTIMEDIA_OTHER           = bindings::PCI_CLASS_MULTIMEDIA_OTHER,           // 0x048000
+
+    MEMORY_RAM                 = bindings::PCI_CLASS_MEMORY_RAM,                 // 0x050000
+    MEMORY_FLASH               = bindings::PCI_CLASS_MEMORY_FLASH,               // 0x050100
+    MEMORY_CXL                 = bindings::PCI_CLASS_MEMORY_CXL,                 // 0x050200
+    MEMORY_OTHER               = bindings::PCI_CLASS_MEMORY_OTHER,               // 0x058000
+
+    BRIDGE_HOST                = bindings::PCI_CLASS_BRIDGE_HOST,                // 0x060000
+    BRIDGE_ISA                 = bindings::PCI_CLASS_BRIDGE_ISA,                 // 0x060100
+    BRIDGE_EISA                = bindings::PCI_CLASS_BRIDGE_EISA,                // 0x060200
+    BRIDGE_MC                  = bindings::PCI_CLASS_BRIDGE_MC,                  // 0x060300
+    BRIDGE_PCI_NORMAL          = bindings::PCI_CLASS_BRIDGE_PCI_NORMAL,          // 0x060400
+    BRIDGE_PCI_SUBTRACTIVE     = bindings::PCI_CLASS_BRIDGE_PCI_SUBTRACTIVE,     // 0x060401
+    BRIDGE_PCMCIA              = bindings::PCI_CLASS_BRIDGE_PCMCIA,              // 0x060500
+    BRIDGE_NUBUS               = bindings::PCI_CLASS_BRIDGE_NUBUS,               // 0x060600
+    BRIDGE_CARDBUS             = bindings::PCI_CLASS_BRIDGE_CARDBUS,             // 0x060700
+    BRIDGE_RACEWAY             = bindings::PCI_CLASS_BRIDGE_RACEWAY,             // 0x060800
+    BRIDGE_OTHER               = bindings::PCI_CLASS_BRIDGE_OTHER,               // 0x068000
+
+    COMMUNICATION_SERIAL       = bindings::PCI_CLASS_COMMUNICATION_SERIAL,       // 0x070000
+    COMMUNICATION_PARALLEL     = bindings::PCI_CLASS_COMMUNICATION_PARALLEL,     // 0x070100
+    COMMUNICATION_MULTISERIAL  = bindings::PCI_CLASS_COMMUNICATION_MULTISERIAL,  // 0x070200
+    COMMUNICATION_MODEM        = bindings::PCI_CLASS_COMMUNICATION_MODEM,        // 0x070300
+    COMMUNICATION_OTHER        = bindings::PCI_CLASS_COMMUNICATION_OTHER,        // 0x078000
+
+    SYSTEM_PIC                 = bindings::PCI_CLASS_SYSTEM_PIC,                 // 0x080000
+    SYSTEM_PIC_IOAPIC          = bindings::PCI_CLASS_SYSTEM_PIC_IOAPIC,          // 0x080010
+    SYSTEM_PIC_IOXAPIC         = bindings::PCI_CLASS_SYSTEM_PIC_IOXAPIC,         // 0x080020
+    SYSTEM_DMA                 = bindings::PCI_CLASS_SYSTEM_DMA,                 // 0x080100
+    SYSTEM_TIMER               = bindings::PCI_CLASS_SYSTEM_TIMER,               // 0x080200
+    SYSTEM_RTC                 = bindings::PCI_CLASS_SYSTEM_RTC,                 // 0x080300
+    SYSTEM_PCI_HOTPLUG         = bindings::PCI_CLASS_SYSTEM_PCI_HOTPLUG,         // 0x080400
+    SYSTEM_SDHCI               = bindings::PCI_CLASS_SYSTEM_SDHCI,               // 0x080500
+    SYSTEM_RCEC                = bindings::PCI_CLASS_SYSTEM_RCEC,                // 0x080700
+    SYSTEM_OTHER               = bindings::PCI_CLASS_SYSTEM_OTHER,               // 0x088000
+
+    INPUT_KEYBOARD             = bindings::PCI_CLASS_INPUT_KEYBOARD,             // 0x090000
+    INPUT_PEN                  = bindings::PCI_CLASS_INPUT_PEN,                  // 0x090100
+    INPUT_MOUSE                = bindings::PCI_CLASS_INPUT_MOUSE,                // 0x090200
+    INPUT_SCANNER              = bindings::PCI_CLASS_INPUT_SCANNER,              // 0x090300
+    INPUT_GAMEPORT             = bindings::PCI_CLASS_INPUT_GAMEPORT,             // 0x090400
+    INPUT_OTHER                = bindings::PCI_CLASS_INPUT_OTHER,                // 0x098000
+
+    DOCKING_GENERIC            = bindings::PCI_CLASS_DOCKING_GENERIC,            // 0x0a0000
+    DOCKING_OTHER              = bindings::PCI_CLASS_DOCKING_OTHER,              // 0x0a8000
+
+    PROCESSOR_386              = bindings::PCI_CLASS_PROCESSOR_386,              // 0x0b0000
+    PROCESSOR_486              = bindings::PCI_CLASS_PROCESSOR_486,              // 0x0b0100
+    PROCESSOR_PENTIUM          = bindings::PCI_CLASS_PROCESSOR_PENTIUM,          // 0x0b0200
+    PROCESSOR_ALPHA            = bindings::PCI_CLASS_PROCESSOR_ALPHA,            // 0x0b1000
+    PROCESSOR_POWERPC          = bindings::PCI_CLASS_PROCESSOR_POWERPC,          // 0x0b2000
+    PROCESSOR_MIPS             = bindings::PCI_CLASS_PROCESSOR_MIPS,             // 0x0b3000
+    PROCESSOR_CO               = bindings::PCI_CLASS_PROCESSOR_CO,               // 0x0b4000
+
+    SERIAL_FIREWIRE            = bindings::PCI_CLASS_SERIAL_FIREWIRE,            // 0x0c0000
+    SERIAL_FIREWIRE_OHCI       = bindings::PCI_CLASS_SERIAL_FIREWIRE_OHCI,       // 0x0c0010
+    SERIAL_ACCESS              = bindings::PCI_CLASS_SERIAL_ACCESS,              // 0x0c0100
+    SERIAL_SSA                 = bindings::PCI_CLASS_SERIAL_SSA,                 // 0x0c0200
+    SERIAL_USB_UHCI            = bindings::PCI_CLASS_SERIAL_USB_UHCI,            // 0x0c0300
+    SERIAL_USB_OHCI            = bindings::PCI_CLASS_SERIAL_USB_OHCI,            // 0x0c0310
+    SERIAL_USB_EHCI            = bindings::PCI_CLASS_SERIAL_USB_EHCI,            // 0x0c0320
+    SERIAL_USB_XHCI            = bindings::PCI_CLASS_SERIAL_USB_XHCI,            // 0x0c0330
+    SERIAL_USB_CDNS            = bindings::PCI_CLASS_SERIAL_USB_CDNS,            // 0x0c0380
+    SERIAL_USB_DEVICE          = bindings::PCI_CLASS_SERIAL_USB_DEVICE,          // 0x0c03fe
+    SERIAL_FIBER               = bindings::PCI_CLASS_SERIAL_FIBER,               // 0x0c0400
+    SERIAL_SMBUS               = bindings::PCI_CLASS_SERIAL_SMBUS,               // 0x0c0500
+    SERIAL_IPMI_SMIC           = bindings::PCI_CLASS_SERIAL_IPMI_SMIC,           // 0x0c0700
+    SERIAL_IPMI_KCS            = bindings::PCI_CLASS_SERIAL_IPMI_KCS,            // 0x0c0701
+    SERIAL_IPMI_BT             = bindings::PCI_CLASS_SERIAL_IPMI_BT,             // 0x0c0702
+
+    WIRELESS_RF_CONTROLLER     = bindings::PCI_CLASS_WIRELESS_RF_CONTROLLER,     // 0x0d1000
+    WIRELESS_WHCI              = bindings::PCI_CLASS_WIRELESS_WHCI,              // 0x0d1010
+
+    INTELLIGENT_I2O            = bindings::PCI_CLASS_INTELLIGENT_I2O,            // 0x0e0000
+
+    SATELLITE_TV               = bindings::PCI_CLASS_SATELLITE_TV,               // 0x0f0000
+    SATELLITE_AUDIO            = bindings::PCI_CLASS_SATELLITE_AUDIO,            // 0x0f0100
+    SATELLITE_VOICE            = bindings::PCI_CLASS_SATELLITE_VOICE,            // 0x0f0300
+    SATELLITE_DATA             = bindings::PCI_CLASS_SATELLITE_DATA,             // 0x0f0400
+
+    CRYPT_NETWORK              = bindings::PCI_CLASS_CRYPT_NETWORK,              // 0x100000
+    CRYPT_ENTERTAINMENT        = bindings::PCI_CLASS_CRYPT_ENTERTAINMENT,        // 0x100100
+    CRYPT_OTHER                = bindings::PCI_CLASS_CRYPT_OTHER,                // 0x108000
+
+    SP_DPIO                    = bindings::PCI_CLASS_SP_DPIO,                    // 0x110000
+    SP_OTHER                   = bindings::PCI_CLASS_SP_OTHER,                   // 0x118000
+
+    ACCELERATOR_PROCESSING     = bindings::PCI_CLASS_ACCELERATOR_PROCESSING,     // 0x120000
+
+    OTHERS                     = bindings::PCI_CLASS_OTHERS,                     // 0xff0000
+    UNKNOWN                    = 0xffffff,
+}
-- 
2.50.1


