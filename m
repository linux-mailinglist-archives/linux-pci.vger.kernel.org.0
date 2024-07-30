Return-Path: <linux-pci+bounces-11005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B5A940A07
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 09:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73D4B285383
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 07:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8F71684AE;
	Tue, 30 Jul 2024 07:37:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3E915FCEB;
	Tue, 30 Jul 2024 07:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722325077; cv=none; b=CoUwDphJ+ZuT8ID5zsKklf/wGhWYPPJ3cq3O6mxUWkJq7m1Ezl3YnBzUlBC5kSIA81EUvW+43dOZL+NLNkgXN3OO3aA9abGoArnEmGLMG9vqIxqaQKGKzCZBEKTajwtjQS6PsISylFqN6sGGp+XPgtOvP0YxLZLvzKrKK7CTW3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722325077; c=relaxed/simple;
	bh=A4Yi/saUs5tqazp39zP7IFaLPBCUZcXp4PuQ3Iafx/s=;
	h=Message-ID:From:Date:Subject:To:Cc; b=hni/ZHm85rYkgESxzJDqqB+95KwKzXWRlaiL6TY3NUzzKugCm1sgtuq9rj54OXEeAMiUnNxCAHklcZc2g09XeZ/yzORTs3su6tFvVGBuaI4FEtDTMKdsaMrCbngiu9Big3QdVOra9v1K5qr7wSZdq7Q8gC1p9P34I5ElTwNdZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id E690110189C95;
	Tue, 30 Jul 2024 09:37:47 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id C6E0B6024EDD;
	Tue, 30 Jul 2024 09:37:47 +0200 (CEST)
X-Mailbox-Line: From 2c01e143298db3e6ed75cd7cb4ac50310a6b290c Mon Sep 17 00:00:00 2001
Message-ID: <2c01e143298db3e6ed75cd7cb4ac50310a6b290c.1722324537.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 30 Jul 2024 09:36:54 +0200
Subject: [PATCH 6.1-stable 1/2] PCI: Introduce cleanup helpers for device
 reference counts and locks
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Bjorn Helgaas <helgaas@kernel.org>, Krzysztof Wilczynski <kwilczynski@kernel.org>, Ira Weiny <ira.weiny@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

From: Ira Weiny <ira.weiny@intel.com>

commit ced085ef369af7a2b6da962ec2fbd01339f60693 upstream.

The "goto error" pattern is notorious for introducing subtle resource
leaks. Use the new cleanup.h helpers for PCI device reference counts and
locks.

Similar to the new put_device() and device_lock() cleanup helpers,
__free(put_device) and guard(device), define the same for PCI devices,
__free(pci_dev_put) and guard(pci_dev).  These helpers eliminate the
need for "goto free;" and "goto unlock;" patterns. For example, A
'struct pci_dev *' instance declared as:

    struct pci_dev *pdev __free(pci_dev_put) = NULL;

...will automatically call pci_dev_put() if @pdev is non-NULL when @pdev
goes out of scope (automatic variable scope). If a function wants to
invoke pci_dev_put() on error, but return @pdev on success, it can do:

    return no_free_ptr(pdev);

...or:

    return_ptr(pdev);

For potential cleanup opportunity there are 587 open-coded calls to
pci_dev_put() in the kernel with 65 instances within 10 lines of a goto
statement with the CXL driver threatening to add another one.

The guard() helper holds the associated lock for the remainder of the
current scope in which it was invoked. So, for example:

    func(...)
    {
        if (...) {
            ...
            guard(pci_dev); /* pci_dev_lock() invoked here */
            ...
        } /* <- implied pci_dev_unlock() triggered here */
    }

There are 15 invocations of pci_dev_unlock() in the kernel with 5
instances within 10 lines of a goto statement. Again, the CXL driver is
threatening to add another.

Introduce these helpers to preclude the addition of new more error prone
goto put; / goto unlock; sequences. For now, these helpers are used in
drivers/cxl/pci.c to allow ACPI error reports to be fed back into the
CXL driver associated with the PCI device identified in the report.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Link: https://lore.kernel.org/r/20231220-cxl-cper-v5-8-1bb8a4ca2c7a@intel.com
[djbw: rewrite changelog]
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 include/linux/pci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4da7411da9ba..df73fb26b825 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1138,6 +1138,7 @@ int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
 u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp);
 struct pci_dev *pci_dev_get(struct pci_dev *dev);
 void pci_dev_put(struct pci_dev *dev);
+DEFINE_FREE(pci_dev_put, struct pci_dev *, if (_T) pci_dev_put(_T))
 void pci_remove_bus(struct pci_bus *b);
 void pci_stop_and_remove_bus_device(struct pci_dev *dev);
 void pci_stop_and_remove_bus_device_locked(struct pci_dev *dev);
@@ -1746,6 +1747,7 @@ void pci_cfg_access_unlock(struct pci_dev *dev);
 void pci_dev_lock(struct pci_dev *dev);
 int pci_dev_trylock(struct pci_dev *dev);
 void pci_dev_unlock(struct pci_dev *dev);
+DEFINE_GUARD(pci_dev, struct pci_dev *, pci_dev_lock(_T), pci_dev_unlock(_T))
 
 /*
  * PCI domain support.  Sometimes called PCI segment (eg by ACPI),
-- 
2.43.0


