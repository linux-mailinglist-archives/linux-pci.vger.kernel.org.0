Return-Path: <linux-pci+bounces-15728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 384779B7FED
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 17:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F66281566
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 16:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD651BBBD8;
	Thu, 31 Oct 2024 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VvsACM3Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC351BB6B5;
	Thu, 31 Oct 2024 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391742; cv=fail; b=MSMXB2zN0z5MDKq/grs39cwQhMOW7pUVidNSQShDBaSmWKhG2XAK9dfQvOcYX10b0B6YTMYud15jS2SNAYYew7nFK0IQwMS36dRbuyjthHpoCqX3ZozvJ9y0uGIZ5/N0d6uKy56aeixsbizcMFUiuULtfefvqKJT/ho9lb7M7R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391742; c=relaxed/simple;
	bh=Cw5kCVLYaoWrE+ptDLGkpB90NhkO4+N6TgirJVtv95w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wcr2vAfgxvA6bfs26h9RkdHnH9q/UCO9S09FWk7XZcxFWisgjdgzOcIm6rAtSB3uP40dO6XG58dm9s/Zn3GK/TarP17VumLBemeVcH68UAdL+6BdrEp7mtxqzQMpxXNH73937lDrwbvuUJv5jvnk0wFOSKzKxZjLCTdatVE2UGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VvsACM3Z; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ug7Q+HqCKnGMyNDL54f2GvgT2xJjLm7k4KYuwqMCvVa+ShpSZeKMjdpOSBxyc1azbzy+FS67j1/ubBRy/rBtFJvyxCU3/RNXN5uM0zOpt2KClhO1Rs31q9J9p4DTvhkQSjOehcj0IkF2qXBjZ+zhXn7XFGjr5Qw+PDolmxIkyXekuDGmXcT4As4hj39HGQc5O8IQvQz8PLpuXY7CmIsSBCCqtbmWOlMUbxgiYGTVLhVXxBe9ZpzNwFOqJIGc9wIR8oY35wcLV6AwpkrUSrLn9mXvYMX9QaJkIB0HXLFbqVkgVmiVl7O4XOzzmL8c/yvCcCzN2xqwCA6S2S4eUr/wRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0vnpYuStQXFm+TbN94+J5BVD7x0V1Q4g+l+jx0D7SE=;
 b=ryUSUlNdiKUw2p1VbyPkxuLH0wJnnm62rWoiFQIZCt9C6NekccR434YlraKNEwGptWDQHIGonkefLaSm3h2uVA+6KZTXyodjwgift4sXA9Tn5RM6Z1EZGuoIRcLfJQILVPj0Xhm8XFjrGGd23BoERDjqsflyfuqBp1iOYo5hK85T5jz3bcPBaPTM1ZnkGgRIIUWFHSyKyNt3DZUmXK1GfG6X6T19r3RHSeTIy+e3czmbTgqiaJUmmTSGxG/g22LatrMSjL9ZqHF+v7mmV86HsjLHLxqfYQ9N+EJOmPgf7IEY0QdwT8KPhKYDu6f0dLTkV4l9v7M2B51Kdje1DB5L1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0vnpYuStQXFm+TbN94+J5BVD7x0V1Q4g+l+jx0D7SE=;
 b=VvsACM3ZIeBmKk28OfxIOvS/JXSd5o8gHu0LWXhg1/4SfXueLCVis9puKtJJdfmrn8VJ261rZFkLO07ZG0hXoO7+gn00uCUsYIGP/1BPRS7bbeofSC1I48S+JAN8wH6DVFBTuudgjjecI4kHMqxlY6vmAVcWh3ZrKMwAxf2OHi0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 16:22:16 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 16:22:16 +0000
Date: Thu, 31 Oct 2024 12:22:07 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, bhelgaas@google.com, Shyam-sundar.S-k@amd.com,
	richard.gong@amd.com, jdelvare@suse.com, linux@roeck-us.net,
	clemens@ladisch.de, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	naveenkrishna.chatradhi@amd.com, carlos.bilbao.osdev@gmail.com
Subject: Re: [PATCH 00/16] AMD NB and SMN rework
Message-ID: <20241031162207.GA1524527@yaz-khff2.amd.com>
References: <0018d26a-ffd5-42fc-8cc4-9e689834a808@amd.com>
 <20241024214753.GA1005373@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024214753.GA1005373@bhelgaas>
X-ClientProxiedBy: MN0P222CA0023.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::27) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|MW6PR12MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: 843c541e-e9ff-4b27-c00d-08dcf9c82f37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wfPQL/aSU7DEcoasKG2EgVkaIZ7kqrBl/XSaTgeEkxeMiaumKQPmdnBXUemw?=
 =?us-ascii?Q?QAS5OP1iTTjYJ1aP6hLwCFbkGNujPulnVdr1+jvCAv0Z2jKTJbOSVV753rYA?=
 =?us-ascii?Q?XQdJSNI9AuscbT0JzL+oxEwPoMxO474sdY1EAxxIuaWz2KW2fqSXdTh4d+EU?=
 =?us-ascii?Q?VTdw/m4v238/9eqD4kY8c2ZvmqgdhLx0RhtDIBWad59XI16fs9HenXRIfDu9?=
 =?us-ascii?Q?Y53tHqLC2Ra9hyF2zvWOutf9iyZt2Mx3/WfIRjdo4iEdvLXToMId+TRspXf0?=
 =?us-ascii?Q?q6wlvUrBfwJX0tKpVIywEPMZ3oL5DJeN3xohR9pwgFlnUUJm1pC163JVZUEg?=
 =?us-ascii?Q?AHhFYWyv+K3n/pmqhz+yyYmSisFLtNLDPUYy9yJr44DxBVy0vUGjgsjH1a7P?=
 =?us-ascii?Q?Onz289FczeTXkaNDIwHAwf2uMxzd8+WHULJr6eaxJDsV557NC/Gn4RaCZ80F?=
 =?us-ascii?Q?9MewUI6Xoss9M8mqa6ZH30fey099e7fctA6bZfCEZ9RwqPIdmz3RLVv/BH3F?=
 =?us-ascii?Q?wT1xlerdkdyUxoCi9v+LQMMh9DkrtbJVkRqtsYFXqA5/IsQIoHgGD7DUrdFq?=
 =?us-ascii?Q?eRpxrtgIhWj/Ny+RuPW/jtXtWeiygnM/vHsk1vA4X0tHH46KFbmgINt9CXTm?=
 =?us-ascii?Q?i09qCXvsg8Xzwv17F1NcXmgcMh3zgcz+05QSLYl6fit2gcbJnlHj5X/KNkuZ?=
 =?us-ascii?Q?5i73cw8FKQJ2JDhWBleuTturDuNZXaIRABdqvKSwaBj1UhyXqHIe4m36LrKK?=
 =?us-ascii?Q?/4Jyh4dao5YvMnAn3DJp5pOlDGhQN6UM5zgWbMync+JK+Q6A2ffBZ++fZ41z?=
 =?us-ascii?Q?xTY2yANL+HTXllCyl/zlV94dK/KqkeilW4rJ6oOGoZ3qy7o/9QTfHunk7kcQ?=
 =?us-ascii?Q?0eCazK6X6eOliAOW9TcZbFLYyB8PbTj7qUgDmnk0IyFRNo9wtHMmGtjk8Fq+?=
 =?us-ascii?Q?UjHOCj3+0+EDE85mMj/6t8UM2Ut4SdQB4dapP2fDkz3cQsZggCIKXK7jvuCw?=
 =?us-ascii?Q?6rPxX8lIF6UiGm3tSXmjrgQMGkOO+9EkHb1b/NarMqGKrrWOEyl0MT/CZrze?=
 =?us-ascii?Q?UhL8y26U9sNJ74DSZ9kc7fFb8M6WwbEemKfEy9wtTXF6ZGFWr2ap9XfF+wKE?=
 =?us-ascii?Q?fa1mgNj6u1gZOUPQrm2n98wuiHIkLFWmpbYIfel3z6FfTWTvO/yFnaAZ1wSf?=
 =?us-ascii?Q?1Lm1lIkgBs63FuQpI5sFHAjIsrFa3pRa46bMBUA0TFZo+X+25ni27SKT7vX9?=
 =?us-ascii?Q?ovtVsB3wxPrtjyBbN10uD+y1j1CkN1/fxxQLXO6/GJgiqWyRXEqhoklDp1Pv?=
 =?us-ascii?Q?G4hrUnLcWSJDoZOtAf/Qqj//?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I6SC0v2SLZ1qfBXZcCg9bLgfQVmv6HTblCfOimT/eB6pHqqtytotGjqre25Q?=
 =?us-ascii?Q?w5CNoufPpxJyXukLQWK2+6fixjhBB/leS3kPWSw6dztg7CGBI+VTAin2sTYU?=
 =?us-ascii?Q?YONY7wBaUOEmGFGfw8qO5emHrnku8v0CI1ekM1bL9SaxvprWnnb98FngBFCh?=
 =?us-ascii?Q?DDeDbg7PKHPW6MMOd2WakH5aGLHQicFXQpnOUK/beFYyHMZgATkuEDNNcvA4?=
 =?us-ascii?Q?HirFomVU1uOZh3CDHj7oGpnzr3V6sh6FVyUcr440l3TSIy6Qbh2JMtYnwi2R?=
 =?us-ascii?Q?1VtFhzHsgOSD1ESM3dgA74Jlh9M57hn0YpZNc7gVmwby53ikBHb8Fbqv2vaC?=
 =?us-ascii?Q?yaXuRFQOL/aaKOjO8UGTz+OpEsBsZBzxLHNmf6gNhTQhW+/x7uFL3V9jxur3?=
 =?us-ascii?Q?k/I+4ZuPSKC6W2OMVmQCUsWq/iUsGrwRyGuCHoRJRK2e1QEXUAphKns8tMrW?=
 =?us-ascii?Q?nNPVQ1jlFJ2mAF8vIBRuBsnq/OlykdQInU2b7ahmELm6jlnP0tUm6yDdSKxv?=
 =?us-ascii?Q?4TGhhHJeh1uKlQhvnYwkOaIHcb/qF3IYRgHjrpoD9ZSNoVQLEJy5pj9Xn/xN?=
 =?us-ascii?Q?23kGjK0R3dxN+Qt6MJ9kGMPbDzx4Zc8N65/TLSgwnfuvXXNzC/9ruwoMmTig?=
 =?us-ascii?Q?bUp0v0EypmvtUdHEpbt0WxKGqpuHpiG6LOgVfJjM2++Xpf8edpOtCZMim6w1?=
 =?us-ascii?Q?Adqihz1OmEzvyO7qm359PteI+e4fVRa0WQ0GIzou2sqdh+OuwbMNNYU0joav?=
 =?us-ascii?Q?n7mES7M76gOxYq6ccFhW6zBYFfQVlAHZeiSdAZrqBsr8i0yBnym9XDRLf869?=
 =?us-ascii?Q?lsnG6gjKS5EGv13/3oBt6W6NOBZoMR8sNwswh5u5Q0OWOnsV+7nE1es7ThQO?=
 =?us-ascii?Q?LcSuSI06yvcBPGLdrPl7vAyEWZGmF6bwcTgrJ1CcQdn9Gr8/KRMF843ytpid?=
 =?us-ascii?Q?Uqq9xqhbRXtQl+DMo7QxcsjqcdarZ5swFg7Ol5WgNBlFUVbU0uYRMrbOQgsK?=
 =?us-ascii?Q?CVtAy468lgks8qDEj39zMCxjeB9qAZ1WjcQvLn1ehgly0kMpf8rEWlZIIBk/?=
 =?us-ascii?Q?/2xthDOodoHZBo3pz9Hb6NaA8LZTfY8tLwE1iMfqJy/3xUSax9KEkK/oJd1V?=
 =?us-ascii?Q?3I95e7sYGULJUYoFnmrfoHK10GXjBU0XZRP69rcBEuJ1tMNvDvThpEuIXu/Q?=
 =?us-ascii?Q?XB5J8PexQccC3ysIBXHIjkB/oGkTzWloVJ1/d28gJnTqJ2cAO+yE7DJfOL2R?=
 =?us-ascii?Q?fEGg4JEGm48Qq6b5zH2b9GYzp8so7cZwKflDqpDm6OUO/TtxhHxEvCEZbRGh?=
 =?us-ascii?Q?kFAcrDzXpyPuN3d5uQWItJtZT3qBBYahgDN1QVDcOgccrw/zgEz1KeEcbE3M?=
 =?us-ascii?Q?w1z6p60qUmP4QOkOrF4+rtB+MWF6i6Wus30vCBxvIkmIrVRlCDgrgStigha2?=
 =?us-ascii?Q?mLMV5AhFgayRQYGy86AG4VPTcbBxvkbwA6Gc4A1iN96ijWjSNa/98V3g4PyU?=
 =?us-ascii?Q?Cnkp+Sjs2syw34VR3SoaQ4ETf6AQvYC7BxnaPaqeTrb5PPKtqb2Ev6XG/BzY?=
 =?us-ascii?Q?xyhSW/S488hqPO/ksUT/klW7Ulm0WcSWbvuZJ+6L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843c541e-e9ff-4b27-c00d-08dcf9c82f37
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 16:22:16.3082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFW0llvz7ET5iGGZOAi9vSaiM+eP1cOHhBIFL4+u2JYG9ugNykedPG+phwIt1JyVWB+sth50MrtIy0fSQ6wKuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7088

On Thu, Oct 24, 2024 at 04:47:53PM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 24, 2024 at 04:20:35PM -0500, Mario Limonciello wrote:
> > On 10/24/2024 16:06, Bjorn Helgaas wrote:
> > > On Thu, Oct 24, 2024 at 03:08:41PM -0500, Mario Limonciello wrote:
> > > > On 10/24/2024 12:46, Bjorn Helgaas wrote:
> > > > > On Thu, Oct 24, 2024 at 12:01:59PM -0400, Yazen Ghannam wrote:
> > > > > > On Wed, Oct 23, 2024 at 12:59:28PM -0500, Bjorn Helgaas wrote:
> > > > > > > On Wed, Oct 23, 2024 at 05:21:34PM +0000, Yazen Ghannam wrote:
> > > > ...
> > > 
> > > > > > > The use of pci_get_slot() and pci_get_domain_bus_and_slot() is not
> > > > > > > ideal since all those pci_get_*() interfaces are kind of ugly in my
> > > > > > > opinion, and using them means we have to encode topology details in
> > > > > > > the kernel.  But this still seems like a big improvement.
> > > > > > 
> > > > > > Thanks for the feedback. Hopefully, we'll come to some improved
> > > > > > solution. :)
> > > > > > 
> > > > > > Can you please elaborate on your concern? Is it about saying "thing X is
> > > > > > always at SBDF A:B:C.D" or something else?
> > > > > 
> > > > > "Thing X is always at SBDF A:B:C.D" is one big reason.  "A:B:C.D" says
> > > > > nothing about the actual functionality of the device.  A PCI
> > > > > Vendor/Device ID or a PNP ID identifies the device programming model
> > > > > independent of its geographical location.  Inferring the functionality
> > > > > and programming model from the location is a maintenance issue because
> > > > > hardware may change the address.
> > > > > 
> > > > > PCI bus numbers are under software control, so in general it's not
> > > > > safe to rely on them, although in this case these devices are probably
> > > > > on root buses where the bus number is either fixed or determined by
> > > > > BIOS configuration of the host bridge.
> > > > > 
> > > > > I don't like the pci_get_*() functions because they break the driver
> > > > > model.  The usual .probe() model binds a device to a driver, which
> > > > > essentially means the driver owns the device and its resources, and
> > > > > the driver and doesn't have to worry about other code interfering.
> > > > 
> > > > Are you suggesting that perhaps we should be introducing amd_smn (patch 10)
> > > > as a PCI driver that binds "to the root device" instead?
> > > 
> > > I don't know any of the specifics, so I can't really opine on that.
> > > 
> > > The PCI specs envision that a Vendor/Device ID defines the programming
> > > model of the device, and you would only use a new Device ID when that
> > > programming model changes.
> > > 
> > > Of course, vendors like to define a new set of Device IDs for every
> > > new chipset even when no driver changes are required, so even if a new
> > > SMN works exactly the same as in previous chipsets, you're probably
> > > back to having to add a new Device ID for every new chipset.
> > 
> > Yeah; this I believe is why we're here today and trying to find something
> > more manageable (IE this series).
> 
> Another alternative would be an ACPI device where you can use the same
> _HID (or at least a _CID) for all the chipsets.
>

Yes, we've had some internal discussions about something like this. Of
course, any new solution will only apply to future products.

Another option could be for the platform to provide an abstracted
interface for each unique access method. For example, we could have
define UEFI PRM methods, the code can run in OS context, and the details
would be abstracted. But again, this would have to come for future
products. :/

> > > The Subsystem Vendor ID and Subsystem ID exist to solve a similar
> > > problem (sort of in reverse).  If AMD could allocate a Subsystem ID
> > > for this SMN programming model and use that same ID in every chipset,
> > > you could make a pci_driver.id_table entry that would match them all,
> > > e.g.,
> > > 
> > >    .vendor = PCI_VENDOR_ID_AMD,
> > >    .device = PCI_ANY_ID,
> > >    .subvendor = PCI_VENDOR_ID_AMD,
> > >    .subdevice = PCI_SUBSYSTEM_AMD_SMN,
> > > 
> > > (pci_device_id.subdevice is misnamed; the spec calls it "Subsystem ID")
> > 
> > Isn't the subsystem ID based typically upon the platform it's
> > running on?  For example I seem to recall on Dell systems it's used
> > the value that was in the SBMIOS ProductSKU field here (IoW not
> > something AMD would control).
> 
> Right, it is typically based on the platform; that's why I said "in
> reverse."  I think all these devices are integrated into the chipset,
> so I'm speculating that platform vendors would have no need (maybe
> even no way) to use the Subsystem ID.  But maybe that's not the case.
>

The devices are integrated. However, they aren't solely used for the
register access interfaces. The index/data pairs just happen to reside
in a root complex device, but of course the root complex is not there
just for this use.

> > I mean I guess maybe we could do a:
> > 
> >     .vendor = PCI_VENDOR_ID_AMD,
> >     .device = PCI_ANY_ID,
> >     .class = PCI_CLASS_BRIDGE_HOST << 8
> > 
> > And then in probe() figure out if it's the right one, but that's still
> > pretty ugly, eh?
> 
> I think there are some drivers that do this, and it's not completely
> terrible.  The probe() can just return failure if it doesn't want the
> device.
>

Would it make sense to have a driver if we're not actually driving
anything? We really just need to read/write to a few registers in the
same vein of using an I/O access port.

I think a driver would really work if there was a lot more functionality
and the access port was just one of many features.

But maybe a really bare-bones driver isn't too much more than what we
have. And it could be more maintainable.

And maybe we can treat the "AMD Node" as a logical device that
collects/manages interfaces across multiple devices.

Bjorn, would you mind if we pursued this as a follow up to this set? I
think there's potential for some of these ideas. But I'll need to do
more research and discuss with others.

Thanks,
Yazen

