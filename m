Return-Path: <linux-pci+bounces-17550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D09C9E0B9E
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 20:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32886281650
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 19:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73CD1DE3BD;
	Mon,  2 Dec 2024 19:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="U0X3hkeL"
X-Original-To: linux-pci@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194E51DE3C1;
	Mon,  2 Dec 2024 19:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166181; cv=none; b=kKZyO4rrdwVNO2NXhp6+yEw4cffb+D8fiGNMZ/uTfNBce2QckU1Rpc5gnOdLqEc7nBuTh0Q72qj4+L2BhGhdTHeGv7h0Y4IYfxlqcnVRfrMy/mNK6ldP2tFsNnYOr5CXZlzHrKfM8/2/WLBCGOn0UMZAD2POmyfP0tjrxOLpxYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166181; c=relaxed/simple;
	bh=iXiGJX95yU+n/5WRBL8Lysfxc2+MXbVLi5M5eaxljfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aXt1GDyX32jRmP3j3lvketm2twZOsJapgg6CKyN+SbEXxS5zg8zW/GW4Ur5mkJUABPhxikPGmLnEMa3J1YlRtZUGPQkjjTI20S6H45pKzfGiPWvG6l1A5WplHEf5S9d+w3rt5e5tHOWDcrHvSuWpk905ggplVjDBMo1nqsaeEhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=U0X3hkeL; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733166178;
	bh=iXiGJX95yU+n/5WRBL8Lysfxc2+MXbVLi5M5eaxljfI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U0X3hkeLXX0IJ7HIAj2zLaA3TRDDpkcISt8fIDoPPl/L/KnK3M6wc7MkohRoD0i93
	 rnRkY0tVc3DvAD02Lh2hnd0mCD/dR6rHnsEejI+gT3hJQasxcUROSNksQTs6/MR9iE
	 elubCZPYKOpBuZvNx1aXHddleESiIUZgTgHFsuW0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 02 Dec 2024 20:02:59 +0100
Subject: [PATCH 3/4] PCI/P2PDMA: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241202-sysfs-const-bin_attr-pci-v1-3-c32360f495a7@weissschuh.net>
References: <20241202-sysfs-const-bin_attr-pci-v1-0-c32360f495a7@weissschuh.net>
In-Reply-To: <20241202-sysfs-const-bin_attr-pci-v1-0-c32360f495a7@weissschuh.net>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Logan Gunthorpe <logang@deltatee.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733166177; l=1290;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=iXiGJX95yU+n/5WRBL8Lysfxc2+MXbVLi5M5eaxljfI=;
 b=RxFtfmGLwK97UIcrFhUkwpHQXzJD7s+JXyFF1AMqnvjQlNopiigYiuvJj7EIKdXzXLFSVWcr9
 7xIRgp3mj/kDPfCx8k87W+tWxbDOWKQHc4u//998bn0yyUFcehdOmzt
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/pci/p2pdma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 7abd4f546d3c071f31e622d881f5c5ac3e4de55e..0cb7e0aaba0ebdb8d0d235428a03a113cde7b390 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -161,7 +161,7 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
 	return ret;
 }
 
-static struct bin_attribute p2pmem_alloc_attr = {
+static const struct bin_attribute p2pmem_alloc_attr = {
 	.attr = { .name = "allocate", .mode = 0660 },
 	.mmap = p2pmem_alloc_mmap,
 	/*
@@ -180,14 +180,14 @@ static struct attribute *p2pmem_attrs[] = {
 	NULL,
 };
 
-static struct bin_attribute *p2pmem_bin_attrs[] = {
+static const struct bin_attribute *const p2pmem_bin_attrs[] = {
 	&p2pmem_alloc_attr,
 	NULL,
 };
 
 static const struct attribute_group p2pmem_group = {
 	.attrs = p2pmem_attrs,
-	.bin_attrs = p2pmem_bin_attrs,
+	.bin_attrs_new = p2pmem_bin_attrs,
 	.name = "p2pmem",
 };
 

-- 
2.47.1


