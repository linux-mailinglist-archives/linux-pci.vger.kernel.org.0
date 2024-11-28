Return-Path: <linux-pci+bounces-17432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C2C9DB3EF
	for <lists+linux-pci@lfdr.de>; Thu, 28 Nov 2024 09:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C390A16668A
	for <lists+linux-pci@lfdr.de>; Thu, 28 Nov 2024 08:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B96C1531D2;
	Thu, 28 Nov 2024 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gRhN3Wlk"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588FD14AD22;
	Thu, 28 Nov 2024 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732783248; cv=fail; b=i7hc9PEBRowGLgYSg1cZMvnXi1ooMdYp8YZ0jVTtNQksyjs9HF+MS45N5ybnxjx7BSZeo2i3q3bDbEMz+rGtPAfuLtue2BSiqSdDDFYSYmXadqrGSMlKIOcycIPaqNVcYgE3BIQkZwcIYIHFqUSzQqVNl/YWphrpJrpDcOHoWhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732783248; c=relaxed/simple;
	bh=9v191I2yQwd2xfBYP/QPdMKLqjnWSd8HMvmUPOJJTfE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MeRaCRnVJt4+O87DWs6Z/COK5nQm5mmiilxAAMR6SyLvKfyW0lIezUZ2Xf+QOqpxN4bP6wqYOsfDova+z00EfeRx+by/HI1kj6//HGgGeH8VdaCSqru+KK/qAsIxRTgrKJjgFTyyCGkTznRpX4/semhBIXLddLrqLa0TbNQ0IjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gRhN3Wlk; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XaO4WmHw/1vQ9vSF8wEh40LinucTpoBCKu7Wl2bRNSM6UgwZGbSRoA5nFx4b0+8AMH3fZgVj0o6gcEqP4smkMZHUiDFXfczUAdBJr+wlYr85vryAk3zfPcH9690JyEg0fxTC/imKg0I0KWdXw8tQv7Md4gOuWYIj3m6nytHCohHaXwtiUis8xKtllXJPAcns8aDo1EzJ2CZ4GZz3N/MAgJEIryqvUewZi3bGy5tQd+rE5aRaJS9PAcGHlbOZ6GLX4nhXyXtgpOb+wdxQrG3Y5CaHlAhEDrHNfAqRZO0PbMzRpwqYw4QiYQ9uFJmVFnBaglON+088c2b+mNv68xXalw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrlyRJYU2tI8QN1opQOy1FbJ+D6SRybCpIQ0Cue5a0w=;
 b=ZpT6EqH+NAZ35aNvib26ocRO6CcZYgthBwS0KeT0JerFW25bkntqHItaDsq+4TtQUP6foJcIVlurQydLr728KE/ydWx9AXglIidZSFhKPo4tvNYJy/VhtwEuwUBNVeMmPT7veNPRSOZPyYIL0TB8bBMAIAV1HCUqcxQDbne+wkt1nk/C1uo7Cwu+RjxbwtVedFgyHexFoG/KTYrqiOq51Mc2N2lk+5ijUB3a5qSrycKp3lkwceGINXosN/4ChELddjby3RzdxTBCPqz0clZxX3rjCdWH+8/MI8WnBiMV9QbDk2YAEe4QDpeVDD3eRN+ofXLusU2zfAiBXFLyC1Zoyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrlyRJYU2tI8QN1opQOy1FbJ+D6SRybCpIQ0Cue5a0w=;
 b=gRhN3Wlk3e3QG1Q6ioUwhqiyC7P6pexRzFU3mUxL8nVb7n1YIqgheqHL1bIu0rCOk62ZPYHKO2wBn7WzvWcdW/1+rMBl6ydyyzbP3WXBwc06y3lFiyDjZtUlYYjjs5cOVcXj32HoWCUr1YakAOVhxbxWvAr4R5WST6I/t4DJ7id5xtK0HENAdmP26R852so/PaASCWkyNKWaIA1J3IyswOyf1a2Iuirv0900tmD8lAQd0FjF5mZ1jv8kNFoE0BDh/XN5/df3j2gTfUefB30qFgZfbPVJ9fbTerrSw1TQB0hHh0lSTaTHkLr0JgDVaepyePzbcnG1B+jB05jPrqC1YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by CY8PR12MB7729.namprd12.prod.outlook.com (2603:10b6:930:84::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Thu, 28 Nov
 2024 08:40:43 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378%6]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 08:40:43 +0000
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: bhelgaas@google.com,
	mika.westerberg@linux.intel.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Carol Soto <csoto@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Chris Chiu <chris.chiu@canonical.com>,
	"Matthew R . Ochs" <mochs@nvidia.com>,
	Koba Ko <kobak@nvidia.com>
Subject: [PATCH] PCI: Use downstream bridges for distributing resources
Date: Thu, 28 Nov 2024 16:40:39 +0800
Message-Id: <20241128084039.54972-1-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::12) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|CY8PR12MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e12cb5-a33e-43f9-040b-08dd0f88587a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jdQIYaPdzH+vqjzZvNEZaBkgfgUkaoBwceTIJTGQreEXlNCWgZsIjKDpu67e?=
 =?us-ascii?Q?eTDymGjRe9Ofg4cUZJ5f603Grp7BGbVrewEE0J24N5t3csdgidhPIpdOUi+b?=
 =?us-ascii?Q?wigcpq91l7WIB854UatVNK+BGs27yAYIz+71V5qAPytODD5JFcbF7LjZlSeV?=
 =?us-ascii?Q?IwqT7Id860nsGnJkIDBQoIN5LdUNB/x7RL1GujyrNWoqbw0g1G7ypPumzcoc?=
 =?us-ascii?Q?JGR3n5CBjf+XrkNhn/VVFVn0PAU9aeeepZlzcm1e2J1/cqVDWIOyctL0aXEc?=
 =?us-ascii?Q?wRdR6JZ/wq3Xo+tfjMgkpK4EC8PjETqvMtmNKR77uE4vkG6L/t1PH6N9XCyh?=
 =?us-ascii?Q?fz0R002G/ndIwuQppkLXSmidBIuK4qVuHxeNJq9ze0y7I5F1ydxBYYP1DAap?=
 =?us-ascii?Q?pEOsVLzLheb/8T5hhQauC5QvkKh3EsWXR7ul13ComWeWF6Z2LX5gk1rEmkKm?=
 =?us-ascii?Q?flZhwO+klH6oWLS6nSfPp2tqcW+aZ09pOWu78/7kpYnlYd3TDHcsJ12s60bq?=
 =?us-ascii?Q?8AP75C8gZ3UV5Pt5/MH7i0mrKNszN3zFI2ElgZTm7xowrDNXdEt/6f08MrBo?=
 =?us-ascii?Q?zjh95P+vWmEkrSyGJ5NkaXHoqpHTqGHQhqvOHyTaeWZ1RhKQaDO1Nqq2KvVX?=
 =?us-ascii?Q?jkXzLdvPBwUZFWk+R6XK4ESNeLEHYjj9wm1lYnapdO6+oH5EMfBXP/UzMMMq?=
 =?us-ascii?Q?VQPGHQxwd94wRTbYUFfusJLwYAsbhQz1eIyfWvNx0yNEYqsO8YrRn8FByCw5?=
 =?us-ascii?Q?QRqR8nZwo0Gg5jl4cqcFJkB2Q/Pj4P/ugbLuWFN6cmzvtsfi3UcLqJAOr2Om?=
 =?us-ascii?Q?1a2TNKoKMdyAOtmV7O/qCnN/BfciLMD6ZWf+/Mahpu3Gr5dc2s4u5BxvyX4A?=
 =?us-ascii?Q?AiI3CXRjjv7rq6lYRyCxoLRdoP5mtiNoBoyqRgY5XtmVThA3AZaqMr2KpNeT?=
 =?us-ascii?Q?9GwMHw8bHdnqMS1HU9U4B6SN80IngVuqfeZ1+wDTaqPyKoR2ZmFcdlGm2bq/?=
 =?us-ascii?Q?j3T83bBxcofhbGpCcbG5FU2WzOkYKJe1lSi9HYx6BUKkWm+hPPqILBhpQ5RW?=
 =?us-ascii?Q?ECsXgoE8StG0uQlmreOrlLjI1aNXko0GAcKwOHYh1USV6gQUNfcFV0tsVLDl?=
 =?us-ascii?Q?bU6M8sE1cflCfK4UQTzKw/R+ndxru8jBCXM/VmkX5kcOS0nzov5gTC2eNSt+?=
 =?us-ascii?Q?ytqqiMEdQPBu9No2dhdGibxu/LsL/SemfDjzwzP22G9eY8GQ8uKhg19Cqar5?=
 =?us-ascii?Q?RLVgsnMj75JlrwJN3rxs5B1KujfDXSmRKx+g7NCu8uBqqIpzxpEkfV+Pf0E6?=
 =?us-ascii?Q?Z8VUOr0CXctkcO6mr/Nuf0pwA4e5jRPICMNDPJpA8vp03AgEOYX6C/6HsQbj?=
 =?us-ascii?Q?7QDxXHc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r9cFtSNyd0caGuoiEjeOEnChaJk1f6onWXpBk3n3wTtsD/YuvuQbvPBfOr2Q?=
 =?us-ascii?Q?Qhm3MlyjmzahtHG2QSBiwy8uvEYkrP0Fq/P4wXFahF+SYZZKCp/KszAobh62?=
 =?us-ascii?Q?Tj9+gEX7Ys+e5OuZhVA1gnMSLLNJutsKLtlze88HcuR+ktu6GLaMBEV7oIZI?=
 =?us-ascii?Q?AMoehnKLBEG/PxJw49S50+41Elv0D0JqFsEG+xDAu/IVjPkc1P/wSeWywadK?=
 =?us-ascii?Q?kkD4CUZSEgya+o6BNCWEPZ8b5PDmC7dUKsZp+1MLCXc+J1yBV7/MaXOzhyLx?=
 =?us-ascii?Q?2iWI/esupcVMkHW+vRfovnbQUZnz3mU6xoiZjZBP5rvgDTy2JJJ+Y0TJN6eF?=
 =?us-ascii?Q?ZpY/daj3MJajVGeKTrFuHNJfHv1PIO9uFRi01tSD6+McB84pDKhUCaOWjLqh?=
 =?us-ascii?Q?VuWAB50pUEw8i3UMBTUT6NaOtOTonyC41XZ11wMWVQ7WJ7si+8Fz61PhLxzJ?=
 =?us-ascii?Q?rlFNa9HaVyfltjuk1Kwnb6cvd/iqRAmyMY2TGtrfnlUG1VWtuXnOggW/u7Xn?=
 =?us-ascii?Q?2IQ9/GiIipIhOis17jHt+e8aMeqspoDI9zt0Z91PwB1j7lJCNi6yZrakWQ8Z?=
 =?us-ascii?Q?gVnTPiZsPTP8a4+rZWYch4vCr8R+/nfZSnHhPZGN7z91j+/zoJ1a+uHtNZs7?=
 =?us-ascii?Q?PQ9ZChf1TjI2NTcZu4VoSM151/swel4004JX7yhTvHQgCIad0lbaKAYJs3h/?=
 =?us-ascii?Q?gQpOQbvOxFS07Lv9B6fk12QyMkkM/DN9Ocdm8UBUJC9xPc9P/KpxtgQor9mF?=
 =?us-ascii?Q?kNFwU/lyAr77ZPNM/C75/H2em7XjbSeLfTSIUu4tS3fzUvDp2VgzZh4o2Ah0?=
 =?us-ascii?Q?GgToJa8Ev7BInd2Sm7/57vp/HJGd9xA6yTU4gCwxq0wf/dWutd5r5eBgs15Q?=
 =?us-ascii?Q?Fv9FQcHCTEVGMoXmDJp+GW6FTuXVGA6AFSweUPHQWSxqUHV4c4aOJVpqBh3O?=
 =?us-ascii?Q?AVOJRIgNm01aeRz4wBtov5lWRLvMwNxYsJ4M7+ZYw/HkFWOdr2PNBXl0iDnK?=
 =?us-ascii?Q?ujYpxyVBucoDAu4WjnaMzIhrY8nGrfXqHPUrQaU/F1PQM9Uhi2rDoVQ3v0US?=
 =?us-ascii?Q?RbPrHGs2SA70mvt6kb4LUSRaTSCxE1gZelOoYM+Dtyi121+4mjleJAtzs0h7?=
 =?us-ascii?Q?aFJM2+Xm9ujU8sLHWMj1QGNNMsqVgCOZNvCR7xQNlX5SviYU3kOTqAejOl9b?=
 =?us-ascii?Q?VsptmN/qAj1AhnchQrAy2Jc9qQRcnoalCG/IIL5rIOaJq6YO5JNNYBOhX+lk?=
 =?us-ascii?Q?KWEl1ycf1lBWfVNX9H9hRiFqEZjQguzZeFJlFr1GYM3JnCZ6gI3nhN0DXcoI?=
 =?us-ascii?Q?bGzfrQe0+3meA0Qvi/mp/iYwzDOtkP93GUzutP352HCkrpTyXmLyqFKOP7mB?=
 =?us-ascii?Q?6HE2XH3TJxuyUD1qtbZN+evqTeo5+D7l4yZr4J5IOZFC0CZlISvBx0Xsr860?=
 =?us-ascii?Q?mLD5izp7pxb8KRjKrC1eFHWnL9ekwMNn1K4skHiY+7ELZxFAIGiqVe5xXxFY?=
 =?us-ascii?Q?8XUohFwW2o2MHarUDWhFPAqQREDg0Wv0zya5Qg6Zjgk5wuENFhUcTY0X0irc?=
 =?us-ascii?Q?bjUG19TdPS2wY7YwbTS33Rm7GIpv84eXFq/4WWLi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e12cb5-a33e-43f9-040b-08dd0f88587a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 08:40:43.2500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJE1aGBWTbtrIGNqU+vq006w7DVnU1IJKpPgBy5t4kcxIryXMz+9YI8a08L/TOm1soZHoPJlzXoQDEgKMoxe1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7729

Commit 7180c1d08639 ("PCI: Distribute available resources for root
buses, too") breaks BAR assignment on some devcies:
[   10.021193] pci 0006:03:00.0: BAR 0 [mem 0x6300c0000000-0x6300c1ffffff 64bit pref]: assigned
[   10.029880] pci 0006:03:00.1: BAR 0 [mem 0x6300c2000000-0x6300c3ffffff 64bit pref]: assigned
[   10.038561] pci 0006:03:00.2: BAR 0 [mem size 0x00800000 64bit pref]: can't assign; no space
[   10.047191] pci 0006:03:00.2: BAR 0 [mem size 0x00800000 64bit pref]: failed to assign
[   10.055285] pci 0006:03:00.0: VF BAR 0 [mem size 0x02000000 64bit pref]: can't assign; no space
[   10.064180] pci 0006:03:00.0: VF BAR 0 [mem size 0x02000000 64bit pref]: failed to assign
[   10.072543] pci 0006:03:00.1: VF BAR 0 [mem size 0x02000000 64bit pref]: can't assign; no space
[   10.081437] pci 0006:03:00.1: VF BAR 0 [mem size 0x02000000 64bit pref]: failed to assign

The apertures of domain 0006 before the commit:
6300c0000000-63ffffffffff : PCI Bus 0006:00
  6300c0000000-6300c9ffffff : PCI Bus 0006:01
    6300c0000000-6300c9ffffff : PCI Bus 0006:02
      6300c0000000-6300c8ffffff : PCI Bus 0006:03
        6300c0000000-6300c1ffffff : 0006:03:00.0
          6300c0000000-6300c1ffffff : mlx5_core
        6300c2000000-6300c3ffffff : 0006:03:00.1
          6300c2000000-6300c3ffffff : mlx5_core
        6300c4000000-6300c47fffff : 0006:03:00.2
        6300c4800000-6300c67fffff : 0006:03:00.0
        6300c6800000-6300c87fffff : 0006:03:00.1
      6300c9000000-6300c9bfffff : PCI Bus 0006:04
        6300c9000000-6300c9bfffff : PCI Bus 0006:05
          6300c9000000-6300c91fffff : PCI Bus 0006:06
          6300c9200000-6300c93fffff : PCI Bus 0006:07
          6300c9400000-6300c95fffff : PCI Bus 0006:08
          6300c9600000-6300c97fffff : PCI Bus 0006:09

After the commit:
6300c0000000-63ffffffffff : PCI Bus 0006:00
  6300c0000000-6300c9ffffff : PCI Bus 0006:01
    6300c0000000-6300c9ffffff : PCI Bus 0006:02
      6300c0000000-6300c43fffff : PCI Bus 0006:03
        6300c0000000-6300c1ffffff : 0006:03:00.0
          6300c0000000-6300c1ffffff : mlx5_core
        6300c2000000-6300c3ffffff : 0006:03:00.1
          6300c2000000-6300c3ffffff : mlx5_core
      6300c4400000-6300c4dfffff : PCI Bus 0006:04
        6300c4400000-6300c4dfffff : PCI Bus 0006:05
          6300c4400000-6300c45fffff : PCI Bus 0006:06
          6300c4600000-6300c47fffff : PCI Bus 0006:07
          6300c4800000-6300c49fffff : PCI Bus 0006:08
          6300c4a00000-6300c4bfffff : PCI Bus 0006:09

We can see that the window of 0006:03 gets shrunken too much and 0006:04
eats away the window for 0006:03:00.2.

The offending commit distributes the upstream bridge's resources
multiple times to every downstream bridges, hence makes the aperture
smaller than desired because calculation of io_per_b, mmio_per_b and
mmio_pref_per_b becomes incorrect.

Instead, distributing downstream bridges' own resources to resolve the
issue.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219540
Cc: Carol Soto <csoto@nvidia.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Chris Chiu <chris.chiu@canonical.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
Reviewed-by: Koba Ko <kobak@nvidia.com>
Fixes: 7180c1d08639 ("PCI: Distribute available resources for root buses, too")
Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
---
 drivers/pci/setup-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 23082bc0ca37..2db19c17e824 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2105,7 +2105,7 @@ pci_root_bus_distribute_available_resources(struct pci_bus *bus,
 		 * in case of root bus.
 		 */
 		if (bridge && pci_bridge_resources_not_assigned(dev))
-			pci_bridge_distribute_available_resources(bridge,
+			pci_bridge_distribute_available_resources(dev,
 								  add_list);
 		else
 			pci_root_bus_distribute_available_resources(b, add_list);
-- 
2.47.0


