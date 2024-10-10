Return-Path: <linux-pci+bounces-14203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B44F998D5D
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 18:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CFAD1F21A97
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 16:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202091CEACC;
	Thu, 10 Oct 2024 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1eg6oTd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90B11CEAC1;
	Thu, 10 Oct 2024 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577680; cv=none; b=amx8JsGtUcW5qK1ZvRjO+htgvD/lxkg1PZt5vFgMSqjOnFc3Vp/DLCDYtpwg/77cPmYTHxETc03Er3R8NA1iyVaJ+jMQRWY3PiYRjK3q84LUpYABWb5BZhJIZ18KVeIgz1N77N3R9seCMZlvPiFDkL9FiIA8MHqZGdnegUHJDcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577680; c=relaxed/simple;
	bh=A6hN75u7rbieW5fxbS9ky35P8eJcu+J5azqML+bAJ0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=li9Kk+FA0QLmIoKPiQIdUcsaSuerOXarOCeX8TJxta+dPzw4Iw9iMlA8EqcGhg7vJ+TTY8yc577Y/7edhu2CBbnTgQdC5AE226pHs7kZbXvRuiDIfaGHQfyzhPSwxJoS+hmoLFyS9Nh3MpYtIvIarfA6SXEopnBcmxIKDMszhvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1eg6oTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68281C4CECC;
	Thu, 10 Oct 2024 16:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728577679;
	bh=A6hN75u7rbieW5fxbS9ky35P8eJcu+J5azqML+bAJ0Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W1eg6oTdub7M9x8+3CGkKp3SvL/U4Zdy2V8p4kSmXJsi8zZepqoPicWm3hELGsL5I
	 uOjUHEYLdSygpx2XK6utJVQiMbXaCn5+OZkKryLFPc4vVJAREK/Yy/7eY17rL5kcZU
	 urnk4od67b2bzgxNvW2q+4+A0Z1X1xQclpvWnch38qnk961xycYi9S9qOKAlVrV3at
	 GRH6gnv6wxtEjA50dDs/ZEzlhofEvHSQYRd/gmg/LFrTbF9oBEC1En4GUpSqHX5eNn
	 HcWRXiQg1J/C6d0iHbT/mzn4Sps6VOhG81dw0OqIzvejfZ0IHBDsjhf8hkSzeWyZSn
	 ht2V3rp8RJG2Q==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 10 Oct 2024 11:27:14 -0500
Subject: [PATCH 1/7] PCI: Constify pci_register_io_range() fwnode_handle
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-dt-const-v1-1-87a51f558425@kernel.org>
References: <20241010-dt-const-v1-0-87a51f558425@kernel.org>
In-Reply-To: <20241010-dt-const-v1-0-87a51f558425@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Saravana Kannan <saravanak@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.15-dev

pci_register_io_range() does not modify the passed in fwnode_handle, so
make it const.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Please ack and I'll take with the rest of the series.
---
 drivers/pci/pci.c   | 2 +-
 include/linux/pci.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7d85c04fbba2..4b102bd1cfea 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4163,7 +4163,7 @@ EXPORT_SYMBOL(pci_request_regions_exclusive);
  * Record the PCI IO range (expressed as CPU physical address + size).
  * Return a negative value if an error has occurred, zero otherwise
  */
-int pci_register_io_range(struct fwnode_handle *fwnode, phys_addr_t addr,
+int pci_register_io_range(const struct fwnode_handle *fwnode, phys_addr_t addr,
 			resource_size_t	size)
 {
 	int ret = 0;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 573b4c4c2be6..11421ae5c558 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1556,7 +1556,7 @@ int __must_check pci_bus_alloc_resource(struct pci_bus *bus,
 			void *alignf_data);
 
 
-int pci_register_io_range(struct fwnode_handle *fwnode, phys_addr_t addr,
+int pci_register_io_range(const struct fwnode_handle *fwnode, phys_addr_t addr,
 			resource_size_t size);
 unsigned long pci_address_to_pio(phys_addr_t addr);
 phys_addr_t pci_pio_to_address(unsigned long pio);

-- 
2.45.2


