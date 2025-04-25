Return-Path: <linux-pci+bounces-26729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 423C1A9C36D
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 11:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC529C027E
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 09:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EB1238176;
	Fri, 25 Apr 2025 09:26:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985BD23BF80
	for <linux-pci@vger.kernel.org>; Fri, 25 Apr 2025 09:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745573217; cv=none; b=PA+oWPeSewB7rHJypIheVMRhqNbhjV3o4qfxZRLyduarN/lVhdpEFs/Jt/4BnXXxotJgNmdGQa9FcZ46BZhqYdkT8f2kEFScGF8iDA9Vp4bYGHX1yNW/afckMX0AfKSs8Sx8pnEX1uzRXPci4IkSkJ0G+lKKT+8Z3XlD/A11A0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745573217; c=relaxed/simple;
	bh=BNHwEvC4+9YUr50uEYIKB8v4zysMMtpOd/Sj5I0pJlU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:To:Cc; b=kwy4tKFFhnTnR+POcgfRcg2FoghWGxR/+RagGTefZCazwT4F2+tL1TitkOuWfWT/VVkcvarntHNnxUMMSWujIpcLFpUFLqJF8q3TaHlubH3IgvlqzM7Nwsx8pp5l3SW9p3r3Qem5k3XU/gkxUiBXTVrdmRsFAUghv3V9Yx3G578=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 2B73C2C4C3F1;
	Fri, 25 Apr 2025 11:26:26 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id CAEEAECCCB; Fri, 25 Apr 2025 11:26:52 +0200 (CEST)
Message-Id: <9a3ddff5cc49512044f963ba0904347bd404094d.1745572340.git.lukas@wunner.de>
In-Reply-To: <cover.1745572340.git.lukas@wunner.de>
References: <cover.1745572340.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 25 Apr 2025 11:24:21 +0200
Subject: [PATCH 1/2] Revert "iommu/amd: Prevent binding other PCI drivers to
 IOMMU PCI devices"
To: Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-pci@vger.kernel.org, iommu@lists.linux.dev, Borislav Petkov <bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Commit 991de2e59090 ("PCI, x86: Implement pcibios_alloc_irq() and
pcibios_free_irq()") changed IRQ handling on PCI driver probing.
It inadvertently broke resume from system sleep on AMD platforms:

  https://lore.kernel.org/r/20150926164651.GA3640@pd.tnic/

This was fixed by two independent commits:

* 8affb487d4a4 ("x86/PCI: Don't alloc pcibios-irq when MSI is enabled")
* cbbc00be2ce3 ("iommu/amd: Prevent binding other PCI drivers to IOMMU
                 PCI devices")

The breaking change and one of these two fixes were subsequently reverted:

* fe25d078874f ("Revert "x86/PCI: Don't alloc pcibios-irq when MSI is
                 enabled"")
* 6c777e8799a9 ("Revert "PCI, x86: Implement pcibios_alloc_irq() and
                 pcibios_free_irq()"")

This rendered the second fix unnecessary, so revert it as well.  It used
the match_driver flag in struct pci_dev, which is internal to the PCI core
and not supposed to be touched by arbitrary drivers.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
I would have cc'ed Jiang Liu (author of the commit reverted here)
but his Intel e-mail address appears to no longer be working.
Someone with the same name has recently started to contribute
using an Alibaba e-mail address, but I'm not sure it's the same
person.

 drivers/iommu/amd/init.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index dd9e26b..33b6e12 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2030,9 +2030,6 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	if (!iommu->dev)
 		return -ENODEV;
 
-	/* Prevent binding other PCI device drivers to IOMMU devices */
-	iommu->dev->match_driver = false;
-
 	/* ACPI _PRT won't have an IRQ for IOMMU */
 	iommu->dev->irq_managed = 1;
 
-- 
2.47.2


