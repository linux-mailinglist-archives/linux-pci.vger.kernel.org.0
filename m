Return-Path: <linux-pci+bounces-13800-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB64598FCE7
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 07:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DBDD283AE4
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 05:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6524F28F3;
	Fri,  4 Oct 2024 05:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLSqnoUb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407B42868E
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 05:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728018472; cv=none; b=FBUA/9vMfSeUy25rO+Ad1xoY+AmEo1I9AaHPTBGaPzmex5Aqb85YtjUxy9Pttmq8eeaR//eR1SEoBY2EevMe2bXkj9iYZL6gY3ltmk5p+yTwN9X+3zZfvC7QQaCSkQ7Bg3pN2OdNxwstApeW/qzLyy1avV2uv38YOvmuh180v8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728018472; c=relaxed/simple;
	bh=a6NqLeJydd97b8EHnOSDAMW27491LOJQ6VXC6fEYHu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRNLLlLaHZ2hbPKBgtadAAKWnLBtiQsEDSM0pWnDEUabq8D81dt2oX6azGwgscTrLHSvDtSb6XNBbPPpr1qJ/b4kNvFavNKwgJNYnjBhLk9iZ3eJOG7qHDbpmhk5g4v/B4xyKUH5PXNJHSb8MGsMiZdBGN8VDd7sypak2hncRB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLSqnoUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E234CC4CED0;
	Fri,  4 Oct 2024 05:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728018472;
	bh=a6NqLeJydd97b8EHnOSDAMW27491LOJQ6VXC6fEYHu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eLSqnoUb2GfOD5af86smBni5EgMsBgqIezzsCJnslC9PGUTYCkjDwafem2HIRl9dA
	 Rj5SB97Z27ruYXeQ2W33SSht20phsjdZpFIdqxMU+rVzatCNEaDA2S7CtquDjsetsn
	 +OBy4LbTHTOuz2u718e3PqUu1dCb4kGW08clqBzCGGke6MR7CezfRr/sSVi+azrGQn
	 o27dKtz17egaBDpn23HzoVX9g3ovv8qFOvv9zGgq3rabC5qGIF+tiqyX7mUbcWEu08
	 X4R//H8Ivyv25cQUKDa/Wri73MUrJtPtHtWtvZOwfA5YezZuG4MJdGUv4jk94vqWDh
	 reEhLBNwIMOSg==
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
Subject: [PATCH v3 5/7] PCI: endpoint: Update documentation
Date: Fri,  4 Oct 2024 14:07:40 +0900
Message-ID: <20241004050742.140664-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241004050742.140664-1-dlemoal@kernel.org>
References: <20241004050742.140664-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new functions pci_epc_map_align(), pci_epc_mem_map() and
pci_epc_mem_unmap(). Also add the documentation for the functions
pci_epc_map_addr() and pci_epc_unmap_addr() that were missing.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 Documentation/PCI/endpoint/pci-endpoint.rst | 33 +++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
index 21507e3cc238..80061110441d 100644
--- a/Documentation/PCI/endpoint/pci-endpoint.rst
+++ b/Documentation/PCI/endpoint/pci-endpoint.rst
@@ -117,6 +117,39 @@ by the PCI endpoint function driver.
    The PCI endpoint function driver should use pci_epc_mem_free_addr() to
    free the memory space allocated using pci_epc_mem_alloc_addr().
 
+* pci_epc_map_align()
+
+   The PCI endpoint controller may impose constraints on the RC PCI addresses
+   that can be mapped. The function pci_epc_map_align() allows endpoint drivers
+   to discover and handle such constraint by providing the size of the memory
+   that must be allocated with pci_epc_mem_alloc_addr() for successfully mapping
+   any RC PCI address. This function will also indicate the offset into the
+   allocated memory to use for accessing the target RC PCI address.
+
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
+  A PCI endpoint function driver can use pci_epc_mem_map() to allocate and map
+  a RC PCI address range. This function combines calls to pci_epc_map_align(),
+  pci_epc_mem_alloc_addr() and pci_epc_mem_alloc_addr() into a single function
+  to simplify the PCI address mapping handling in endpoitn function drivers.
+
+* pci_epc_mem_unmap()
+
+  A PCI endpoint function driver can use pci_epc_mem_unmap() to unmap and free
+  memory that was allocated and mapped using pci_epc_mem_map().
+
+
 Other EPC APIs
 ~~~~~~~~~~~~~~
 
-- 
2.46.2


