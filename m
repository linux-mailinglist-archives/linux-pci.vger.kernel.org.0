Return-Path: <linux-pci+bounces-11008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFED940C69
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 10:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C64C1F25F9A
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 08:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED0F192B92;
	Tue, 30 Jul 2024 08:57:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB091922C1;
	Tue, 30 Jul 2024 08:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329834; cv=none; b=rNfKF2wIKQVaKWZJDcnSfXLAfeJkBEGSHp2TRRJOSLoXyTbTlKKMt0PytiIWOAk++PYcSujSoHowhMHOdFVZTHmMe0rB4xn35yC7SsjhYczCkmisI2dF0rwCVzH9AAX/p/NJ3yl49MfxxSIAzIYCb3LJ9P4OJXzu81iHHJct2ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329834; c=relaxed/simple;
	bh=YJKK4IVKDzljNLqWRBrWvNv4Hak/f8FkkzC+8NmoFYk=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=UfPJWc9XfHOw7rU2mGyXXqKres+IlxxknZ4dwXvRhAdEMMUxZRTx6g1cjlNilZ0z20PftlUGn4odC56Hk3f0Q8hNkXxDA3TlNtJVkoKZkyzRyo7qAUYkb7ufz67fmnm1pFEEm2nqpfg/+mUDNNjpSmkmNh7JHWVLL88UZHVhwhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 0A3AF101917AC;
	Tue, 30 Jul 2024 10:57:09 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id D1397603B5E6;
	Tue, 30 Jul 2024 10:57:08 +0200 (CEST)
X-Mailbox-Line: From 59b16a6b13dbccacb6200d9e04c5ef1830a7311a Mon Sep 17 00:00:00 2001
Message-ID: <59b16a6b13dbccacb6200d9e04c5ef1830a7311a.1722329230.git.lukas@wunner.de>
In-Reply-To: <dd76a3196d5295fa7575bf149d890e647fbe0fd6.1722329230.git.lukas@wunner.de>
References: <dd76a3196d5295fa7575bf149d890e647fbe0fd6.1722329230.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 30 Jul 2024 10:54:52 +0200
Subject: [PATCH 5.15-stable 2/3] PCI: Introduce cleanup helper for device
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
[lukas: drop DEFINE_GUARD() helper as pci_dev_lock() doesn't exist in v5.15]
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 include/linux/pci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 32805c3a37bb..20199983a283 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1122,6 +1122,7 @@ int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
 u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp);
 struct pci_dev *pci_dev_get(struct pci_dev *dev);
 void pci_dev_put(struct pci_dev *dev);
+DEFINE_FREE(pci_dev_put, struct pci_dev *, if (_T) pci_dev_put(_T))
 void pci_remove_bus(struct pci_bus *b);
 void pci_stop_and_remove_bus_device(struct pci_dev *dev);
 void pci_stop_and_remove_bus_device_locked(struct pci_dev *dev);
-- 
2.43.0


