Return-Path: <linux-pci+bounces-9128-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A076913783
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 05:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C96A1C20F9D
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 03:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228EDD518;
	Sun, 23 Jun 2024 03:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="o1CE/QGL"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2065.outbound.protection.outlook.com [40.92.98.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0838646B5;
	Sun, 23 Jun 2024 03:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.98.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719113315; cv=fail; b=VTbPI1uiC2gFkgaHxVHbNOE8n62uMU5Q6IYaBqCS3cbl/Y0B0hx9p+RoHacDgs+qmlyFT+f2GyZE8RoU+/cYUqBSQLxZF60ASVgHBM4lSGB5UKWYoDlWm2rXe74MI1eqFGtA7978LYg2wJaVb9KlDOg2a3uJ7XwOuDqD9J6Fjww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719113315; c=relaxed/simple;
	bh=H2OA6HLFAdnCZ694TH15fY3ejPRCfoBofBa6sqPZkpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oL78XzjIGNmK6CbYXVEUjiByXQK+jDqLGsDPDBe/hUS0ag/s2goJVityh3YDYhcHmkceeesMSYsPvH8lE+MRfNDyx5os7dOR5SUreJNCJXWOy5Gc4r40RTuA6Jmj4gp7JZazHn4TvY7xdUH0RrgEURO3wAmwR8mw/X8e68JVsVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=o1CE/QGL; arc=fail smtp.client-ip=40.92.98.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1i61pdwG2CCSXO4X3aoTsiplJght1shHqn1e9/4sY4Duz6dFASvQ79xLvwi8TYzHCrK3pKjKNw12boVYfiYcY+EJkgfxCUAAQKOJYPMHYtsKbRf1JrZbcAYq22ngK/z7nILbt+nr0/FBWHqrTyJrnk4EIvFv6APzZP/mmL2ddtQNzFAlBeFfd8o+q+Bi3JIrPN+jpq8IHFDDIQTz7v95JvKeR5nRSsmlMXF7B+ztXBxoHCl+VGJ15e7fWmbVraaftc4sodP8aKcFqRa1V1bed5MHiW23S/bP5o+DzTux/wVM3YD8GvvzebnkU+gI8SagcOaPpChPpUAdnv8qbUwCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6gwymaK8WdPf0aH9qrhK9GdcyhYodCX7fpLzz58JBo=;
 b=hHPUpeP82wGpZ44yFn94WMRRrkF3I4lfDTzIstxf+lUG2QwW8x/++0CZa2OQuwIhQdMJHY2SSWAGUWbLN1cE4xDx9znHxZrvtBfAtj57VZxQLJVra9Q/ZrI58o3NZjv3604wr9HBqNaiTQ7kB62V5Gxes5bIkrYQ7I3U7Sp70s/WHG5XZ7loe24pZ4wy0Bo8aYVWBuCMpxKkLTPDP7CmO/yDzx4c+bylWNebBIf6vYy5lDRZr2wyM5rEsRIy7xoA3GMcnV1wm70MfG/rc/kT4VuNXnM/tibQzvM2MVOUbk7AdFtcKzBGxwbrZKY2TS6y6Adwwbwimnlbj8HjIF+POg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6gwymaK8WdPf0aH9qrhK9GdcyhYodCX7fpLzz58JBo=;
 b=o1CE/QGL/Mu66xu0XXU412j7tBcGX9bGt3Bh6KtAEz1lTnrd9/ajhnjZ1Yh3ByR7SFOdiI5pmiXUEaTuza7237PL9mzIbwUsWT1+uzPqVic9b9dsIa9Eiv52VlEVCcKLcyw3FGINswKHx6Pzi8DI5eWHy24dryDA/huR+vIh21v8VzkiFiL3kbGl3H6BxRB8g0JQ5yUcsTfvZGg3SsFpETIEy5gJQhXKdJ1Wpm1BX3R5ARsQRPohFaJPYUVxl5YlNzXSWhPM8zNLzMBC88IdPH8IujQZSX1k571wZP+xgfizPv+fMfMFpP1F2Yo3asLMwSxaianXgc3Z6VEyxSeJgw==
Received: from TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:256::8)
 by TYCP286MB2243.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:13a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.25; Sun, 23 Jun
 2024 03:28:30 +0000
Received: from TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM
 ([fe80::670b:45a6:4c30:d899]) by TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM
 ([fe80::670b:45a6:4c30:d899%4]) with mapi id 15.20.7698.025; Sun, 23 Jun 2024
 03:28:30 +0000
From: Songyang Li <leesongyang@outlook.com>
To: helgaas@kernel.org
Cc: bhelgaas@google.com,
	leesongyang@outlook.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Cancel compilation restrictions on function pcie_clear_device_status
Date: Sun, 23 Jun 2024 11:28:27 +0800
Message-ID:
 <TY3P286MB2754DF696DC4ECEE8258D36FB4CB2@TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617163106.GA1217016@bhelgaas>
References: <20240617163106.GA1217016@bhelgaas>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [cViVPF4SjQel4wb/qy7gNYx0pXHxlWii]
X-ClientProxiedBy: TYCP286CA0336.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::7) To TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:256::8)
X-Microsoft-Original-Message-ID:
 <20240623032827.2429-1-leesongyang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2754:EE_|TYCP286MB2243:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fce6d7c-b139-40c3-3d27-08dc93348d62
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|440099025|3412199022|1710799023;
X-Microsoft-Antispam-Message-Info:
	P4b4EX/n08I9SrKxlOJal5hKk84iUCEusKGFb/FQCkaT9BfQ3InZMc6pL45wQuyPZb7D8mMLHhvDjQAymsm30BpOlXjcjGXprpsWN6iyVXhDmeIkVdnAICySjlc649ZlVjalMbuwKXjDukeHu2iNkNcMZiwGB9f51bS2L/fbmTLOD2yq4a5Yo9eiBjBvLdF8CUYCcAMmbgykx07iz75KiQIT23GhjCkiDKKvtb1AomOBxAixtsZ47oJ4jH7LOBMYF8pBePpfMC41oOfXLgiJG9xZJy2N51l26oOGY0623xm3sepxgwzo+2OSljA2Vy7yrx2fCBE4oUlmPC6bWV/lru7moGs3Rf3KinRLkpRR0NAYujYyc0O0x2bkb2ITE2ESIw7NVgVyMy6OSedDks56oKn07e4r7AC10CJl4gJfqef4WWr/0RVZRk+GWiAxp4p468NJE85YZTJsUz0gC5YRJCsRW/+DSGsRY/NYTljHBkxHHQVrAb4mpK3WC3Uhw4EH7a+DLdibWVO1XUR5e9K04NmybDPtIinToolCJhFA/66eIvyJqTMx82fLl2B3FDjaDDHTBCXCeYM+OVBeWuwgs3jSpbmzIkaRwzAc1d2jAvYjQpmTg66PKNJw3E5M29N3
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?26jQ+u0WNIpkAUpfswV2pbVy09tQsIKiS+WoZPFHiltjYUpFCO4dNZyhSUvx?=
 =?us-ascii?Q?AiMq2BG1gH1A0xGGB0+xrL5ddpjg160uSw9oZ3hY3X35wHIOaxItjwnxLujE?=
 =?us-ascii?Q?boE/TdPcRkdh3QEffOafCPsF5uk1yVje3CVD8GwD9C/xqBnBRVkjv29O9viB?=
 =?us-ascii?Q?ANuj17GMx3fE6uuhlRFkiqTc9zorAKFzWIe3pTqwkTmtPp6Gk+z9OQmizLpn?=
 =?us-ascii?Q?TEXuWce8nZtPQizyyqvVcssO63j8PRgkZHaAIS67j/ovP4WQF8583pp65a1g?=
 =?us-ascii?Q?uVpa4C7EkVVyKCICjjEBDfyIhmjtG+q+e2ZC4JdsrDrl+ZLMWuhKWOCCBaqm?=
 =?us-ascii?Q?DkyyHxTMsBPy2y1DqRacxT4kavkbCu/WYwpsNCnzYt/LN6t28yKVjcX+RbGL?=
 =?us-ascii?Q?GAtNt0I+TencTexqcBwAN1WEyBmNp0df53/dLGX/jy+LvYCiNIEnOZxGwxjb?=
 =?us-ascii?Q?gEADlKFvQkUNFFClV1lk3lTHeFlE7WlHhMJz9QSB8U4N/TyypYjQT4lJt1rf?=
 =?us-ascii?Q?Te2p9sObRGrOaBVQ1WPRcxiLJfWX7Ru85AfFUE+KyrcyzpA6YKR6xAK4sHdF?=
 =?us-ascii?Q?No54VeJaf2O1+WVNGNGdOGY/nML0Knp3IOq2baGtA9Lq0LTeDpuvv2KrgujB?=
 =?us-ascii?Q?b5JAkwTvjOfmaDOHzlZ+tBYsOCWY/7E5op4WLDo2ksgMr3dr+FUiMM1Bp2mq?=
 =?us-ascii?Q?MupIH6e7hjh2oJ+zz7tB+1Hfa0scVf/vGA6rplJmxB8HXu+NVoYMP5dCpt25?=
 =?us-ascii?Q?VxjG26ziL7+qNOMV2MlLWY0nw1LEcn+NqjtJLUQ03h42nUC4tYRIaiT5L40d?=
 =?us-ascii?Q?n4preaIS9GUHZC0XLINH0xv8jQdI48G2uDq/4S7NrB9pE8PNSpk+DD74Or+7?=
 =?us-ascii?Q?GKS+YXF9KN+vQxd+MZoeACrLYu/PWjNfqYFmJ7JSTrVzNiTozLxRuT/bMyC0?=
 =?us-ascii?Q?XklkQvFodOX1SJWkzHP6KCqB/7qmYN4OXBsUszEQHSN5t9LwKzdZDAEhJ/Wi?=
 =?us-ascii?Q?0WUye9TGtDadr5d1yogC/2bKxe3I2+qjFMdN+4T9KiMVUUBaaK5w7Le0cW77?=
 =?us-ascii?Q?e/31PrDcqxb0HFS1lRTBjuJPveb73CSgiOXtSiKhUGFx7gPcDzPdOjiK2OKo?=
 =?us-ascii?Q?z25BUhSX+1HnLT1R/xFKaewCtLhpozWRHiIlG1aWXBPye4fZh+Tnjl0/zXvj?=
 =?us-ascii?Q?yRidPZgIqYc0EhnR8XYHNGp36Afs6jkJwmm4X0SJS4Ff03VgKkrMiijdroV2?=
 =?us-ascii?Q?UMAUGOq+aQwGYXy9SBmq?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fce6d7c-b139-40c3-3d27-08dc93348d62
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2754.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2024 03:28:30.1641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2243

On Mon, 17 Jun 2024 11:31:06 -0500, Bjorn Helgaas wrote:
>> On Sat, 15 Jun 2024 16:26:03 -0500, Bjorn Helgaas wrote:
>> > > On Wed, 12 Jun 2024 15:14:32 -0500, Bjorn Helgaas wrote:
>> > > > I think all current any callers of pcie_clear_device_status() are also
>> > > > under CONFIG_PCIEAER, so I don't think this fixes a current problem.
>> > > > 
>> > > > As you point out, it might make sense to use
>> > > > pcie_clear_device_status() even without AER, but I think we should
>> > > > include this change at the time when we add such a use.
>> > > > 
>> > > > If I'm missing a use with the current kernel, let me know.
>> > > 
>> > > As far as I know, some PCIe device drivers, for example,
>> > > [net/ethernet/broadcom/tg3.c],[net/ethernet/atheros/atl1c/atl1c_main.c],
>> > > which use the following code to clear the device status register,
>> > > pcie_capability_write_word(tp->pdev, PCI_EXP_DEVSTA,
>> > >                 PCI_EXP_DEVSTA_CED |
>> > >                 PCI_EXP_DEVSTA_NFED |
>> > >                 PCI_EXP_DEVSTA_FED |
>> > >                 PCI_EXP_DEVSTA_URD);
>> > > I think it may be more suitable to export the pcie_clear_device_status()
>> > > for use in the driver code.
>> > 
>> > If we want to use this from drivers, it would make sense to do
>> > something like this patch, and this patch could be part of a series to
>> > call it from the drivers.
>> > 
>> > But at the same time, we should ask whether drivers should be clearing
>> > this status themselves, or whether it should be done by the PCI core.
>> 
>> After careful consideration, I agree with your point of view.
>> I hold a viewpoint that it should be done by the PCI core,
>> rather than pcie drivers. I give up this patch, and then I have
>> gained a profound understanding of PCIe Core from this communication.
>
>I tend to think this should be done by the PCI core, but I haven't
>looked at it enough to know how or where.  If you pursue it, I'd love
>to see your ideas!

I have used the device status regs of PCIe as the basis for error detection,
which is used for PCIe devices without AER capability. But the current
solution is not universal and I look forward to submitting to the
community in the future.

Songyang Li


