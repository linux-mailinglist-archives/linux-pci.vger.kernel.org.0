Return-Path: <linux-pci+bounces-14286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FF899A324
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 14:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3212B23791
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 12:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B88210C18;
	Fri, 11 Oct 2024 12:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxPIgAw9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFFD20B21A
	for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 12:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648088; cv=none; b=GcPA/cVg7xWEGIEs9OaPov2CRHU+QRx9dKmGCQ9c5H2F0mnTkh6PieDcjCxCx+MCfy6A+CcWu3fzx9OX40UrHNk9MIzvepCwqQbVZz5utCgZIPwhmz33a0gZEaIh0NjAk5CFxJL9zETYopDd4QjbyfrqfL1gIU5Dr86aqIOMnHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648088; c=relaxed/simple;
	bh=RVeu/6LOtKh5QrV1+HgKoavLxJwF5cwgn+U99uBaXdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oNs8Mhl9QGdqSHWuz95LzRxX71jsGpHU0C8+FevtDzcPjSt+J7ifQeXxhy65GUftTIUXfJz4z7iHP07OZ9yj7fZ3NZi8IvCKYOtGCSzisoNqDSIRSMWYpL0WeT9YAT/2wFAgSICFipXSLH0uPCVTM/Ki4iVapZVDmtSfivFMLbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxPIgAw9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1BCC4CECD;
	Fri, 11 Oct 2024 12:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728648088;
	bh=RVeu/6LOtKh5QrV1+HgKoavLxJwF5cwgn+U99uBaXdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QxPIgAw9orI5YMB9lBnZTPKNTxwq98oJCc2niJ1PwBuVh5UQ/jQWZYeTtZEiojDb8
	 6rb2Psmugzu6YxvdsipgWJ5m8L09iqnddPQCghRbwD9VQGZQOLkgoeqbcYF6PXrofN
	 +eUAGaiOmPKtgKTdBb+G5ohDXE3wm0mEWIezbZcd9Kl081uVVy1W2BrW1qAc2OhsFD
	 1KT1kjRhVXRzA0jd3kEhzQxF0vm+ZYOSO3SZc4l0Z4d2Dim+Ic447aLF3hOxtCOhQR
	 T97SrmM1KAZZziYyMSwXbxvxqpOBSFFWNxL4vyhajlwUfx30ZkywRiPQHsA+jPXHsK
	 wYhtIHJ2inGlw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>,
	linux-pci@vger.kernel.org
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v5 4/6] PCI: endpoint: Update documentation
Date: Fri, 11 Oct 2024 21:01:13 +0900
Message-ID: <20241011120115.89756-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011120115.89756-1-dlemoal@kernel.org>
References: <20241011120115.89756-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new functions pci_epc_mem_map() and pci_epc_mem_unmap().
Also add the documentation for the functions pci_epc_map_addr() and
pci_epc_unmap_addr() that were missing.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 Documentation/PCI/endpoint/pci-endpoint.rst | 29 +++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
index 21507e3cc238..35f82f2d45f5 100644
--- a/Documentation/PCI/endpoint/pci-endpoint.rst
+++ b/Documentation/PCI/endpoint/pci-endpoint.rst
@@ -117,6 +117,35 @@ by the PCI endpoint function driver.
    The PCI endpoint function driver should use pci_epc_mem_free_addr() to
    free the memory space allocated using pci_epc_mem_alloc_addr().
 
+* pci_epc_map_addr()
+
+  A PCI endpoint function driver should use pci_epc_map_addr() to map to a RC
+  PCI address the CPU address of local memory obtained with
+  pci_epc_mem_alloc_addr().
+
+* pci_epc_unmap_addr()
+
+  A PCI endpoint function driver should use pci_epc_unmap_addr() to unmap the
+  CPU address of local memory mapped to a RC address with pci_epc_map_addr().
+
+* pci_epc_mem_map()
+
+  A PCI endpoint controller may impose constraints on the RC PCI addresses that
+  can be mapped. The function pci_epc_mem_map() allows endpoint function
+  drivers to allocate and map controller memory while handling such
+  constraints. This function will determine the size of the memory that must be
+  allocated with pci_epc_mem_alloc_addr() for successfully mapping a RC PCI
+  address range. This function will also indicate the size of the PCI address
+  range that was actually mapped, which can be less than the requested size, as
+  well as the offset into the allocated memory to use for accessing the mapped
+  RC PCI address range.
+
+* pci_epc_mem_unmap()
+
+  A PCI endpoint function driver can use pci_epc_mem_unmap() to unmap and free
+  controller memory that was allocated and mapped using pci_epc_mem_map().
+
+
 Other EPC APIs
 ~~~~~~~~~~~~~~
 
-- 
2.47.0


