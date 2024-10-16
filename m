Return-Path: <linux-pci+bounces-14616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B159A0162
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 08:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21FAD1C22E81
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 06:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CE018DF72;
	Wed, 16 Oct 2024 06:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERwkFU4Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D050E18D655;
	Wed, 16 Oct 2024 06:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729059856; cv=none; b=IkZz6PAyuQG1NhNaS5EmcFBqIdx4pUE+WISrZUg89vWE+gnFhJ6yYHGWAaMPDNmZBlM0HhwzNcP/+WU6P6nIwSyUETs4rEkANCTH1DQ5IYoB/UV4+uFFFNBHGHKWmmiYI5VZmP2EvAhg5eabdXJ8gMrCuKXrDsqob9b0BW//+bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729059856; c=relaxed/simple;
	bh=GoiUt5t70hi75J47RBegx6CmkNJuNYszg5HcetA7zeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y91YWaPveEXbpqsh+WAsMJcpWcOBgDwk+xSYvjSQd0w3HDkYMnYa5pQb++WpLEbZxTT5HKxj783ujQiLGTkL5jP6gd6BnxlAU+Bi/YxVhJLyslNWMYIezJEN4htux/y0c+RXKbRlr+3xATyg12kbhs/J8NWS6+zvELq5U3+2iI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERwkFU4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D140C4CEC5;
	Wed, 16 Oct 2024 06:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729059856;
	bh=GoiUt5t70hi75J47RBegx6CmkNJuNYszg5HcetA7zeQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ERwkFU4QUpU8Prrl3pqtKZBNR2D2+3KbdoevDqSXWIrjo5I7dFZfxJN7IgKlM6hl/
	 ml4RLYNRWDEB/J2IpF4xzthyXfa0zWewpJR5d6pqDUDa/YB9LXT0Lw8WN5LYToc2gA
	 EyRW0Z2ntVrTly1Du/jWPOLzX0W0wSPNbGLwRWNmwq5eMsc/MBHXX+MARE54m871wv
	 YWekq08zuZPEWBJZujkKpfFDB7cXxhfq2HE7v24XIHq373YjC3BKLeqeItNa8OGtvW
	 Ujug0wfHS+Uo+XB1ZOck6YK7Fi/ksYX4nTpDRSjPTvlGQgqs2YtrKSh6O0vIiE2sWo
	 lUaXBhHYZ09VA==
From: Arnd Bergmann <arnd@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Philipp Stanner <pstanner@redhat.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Constify pci_register_io_range stub fwnode_handle
Date: Wed, 16 Oct 2024 06:24:04 +0000
Message-Id: <20241016062410.2581152-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The patch to change the argument types for pci_register_io_range()
only caught one of the two implementations, but missed the empty
version:

drivers/of/address.c: In function 'of_pci_range_to_resource':
drivers/of/address.c:244:45: error: passing argument 1 of 'pci_register_io_range' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
  244 |                 err = pci_register_io_range(&np->fwnode, range->cpu_addr,
      |                                             ^~~~~~~~~~~
In file included from drivers/of/address.c:12:
include/linux/pci.h:1559:49: note: expected 'struct fwnode_handle *' but argument is of type 'const struct fwnode_handle *'
 1559 | int pci_register_io_range(struct fwnode_handle *fwnode, phys_addr_t addr,
      |                           ~~~~~~~~~~~~~~~~~~~~~~^~~~~~

Change this the same way.

Fixes: 6ad99a07e6d2 ("PCI: Constify pci_register_io_range() fwnode_handle")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
If possible, please fold this fixup into the original patch
---
 include/linux/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 11421ae5c558..733ff6570e2d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2019,7 +2019,7 @@ static inline int pci_request_regions(struct pci_dev *dev, const char *res_name)
 { return -EIO; }
 static inline void pci_release_regions(struct pci_dev *dev) { }
 
-static inline int pci_register_io_range(struct fwnode_handle *fwnode,
+static inline int pci_register_io_range(const struct fwnode_handle *fwnode,
 					phys_addr_t addr, resource_size_t size)
 { return -EINVAL; }
 
-- 
2.39.5


