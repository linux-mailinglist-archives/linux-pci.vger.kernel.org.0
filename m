Return-Path: <linux-pci+bounces-11011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E688940DC4
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 11:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B066B1C24068
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 09:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47E8194C9B;
	Tue, 30 Jul 2024 09:32:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEAC194C8D;
	Tue, 30 Jul 2024 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331949; cv=none; b=Dnro8xkqR+HIFKwq/IDQ5CEgpA0zSoQnGn6a/mCO4OGPty6+9jdW/4NI6BXiCw/ppsWxW1/zZUYH8M5Je0sCy4w2D7K66Vs4AT0IisqPJXmC5HMIL29+fwM0rWWGkQ95pVXNR0h8qPx3IWz7SuQT89uhgCietNUZmxRDJk0bVpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331949; c=relaxed/simple;
	bh=Ur5ynH3N5vWFBai07aL2IOpp5MDf2oqUShDeuyoBwdM=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=o7/WL6IoYA3uZW+pv33AQ3WoWfzpdQBUTs7upxyky1EZGQiRzricRZehFgs9Ujg47FZT0kG+8BN0H09iTKePYebftBdHnn3XXZ3MnI24irDc4+aIAJlJCWSZAjg5WfneqoZYrGF4xS9S/KPds2RRCJ92W1s70u7po7FilMe5jbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id A61741007577C;
	Tue, 30 Jul 2024 11:32:24 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 3BC2D603B5E6;
	Tue, 30 Jul 2024 11:32:24 +0200 (CEST)
X-Mailbox-Line: From a883280b3fcf833708e66e969e892ce07ffb9e81 Mon Sep 17 00:00:00 2001
Message-ID: <a883280b3fcf833708e66e969e892ce07ffb9e81.1722331565.git.lukas@wunner.de>
In-Reply-To: <3c1751533b20c5ece6ff2296c1d79ac7580200a0.1722331565.git.lukas@wunner.de>
References: <3c1751533b20c5ece6ff2296c1d79ac7580200a0.1722331565.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 30 Jul 2024 11:30:52 +0200
Subject: [PATCH 5.10-stable 2/3] PCI: Introduce cleanup helper for device
 reference counts
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Bjorn Helgaas <helgaas@kernel.org>, Krzysztof Wilczynski <kwilczynski@kernel.org>, Ira Weiny <ira.weiny@intel.com>, Peter Zijlstra <peterz@infradead.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

From: Ira Weiny <ira.weiny@intel.com>

commit ced085ef369af7a2b6da962ec2fbd01339f60693 upstream.

The "goto error" pattern is notorious for introducing subtle resource
leaks. Use the new cleanup.h helpers for PCI device reference counts.

Similar to the new put_device() cleanup helper, __free(put_device),
define the same for PCI devices, __free(pci_dev_put).  These helpers
eliminate the need for "goto free;" patterns. For example, a
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

Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Link: https://lore.kernel.org/r/20231220-cxl-cper-v5-8-1bb8a4ca2c7a@intel.com
[djbw: rewrite changelog]
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
[lukas: drop DEFINE_GUARD() helper as pci_dev_lock() doesn't exist in v5.10]
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 include/linux/pci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 30bc462fb196..f497aaf1d032 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1069,6 +1069,7 @@ int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
 u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp);
 struct pci_dev *pci_dev_get(struct pci_dev *dev);
 void pci_dev_put(struct pci_dev *dev);
+DEFINE_FREE(pci_dev_put, struct pci_dev *, if (_T) pci_dev_put(_T))
 void pci_remove_bus(struct pci_bus *b);
 void pci_stop_and_remove_bus_device(struct pci_dev *dev);
 void pci_stop_and_remove_bus_device_locked(struct pci_dev *dev);
-- 
2.43.0


