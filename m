Return-Path: <linux-pci+bounces-13907-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2272992355
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 06:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D49B1F228D9
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 04:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08623200DE;
	Mon,  7 Oct 2024 04:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fekEmLoB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89963C2F
	for <linux-pci@vger.kernel.org>; Mon,  7 Oct 2024 04:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728273813; cv=none; b=fDcKI+MN5N0llAHxezE++tpgNm4IjvkHRt4u4O4uDlxLJmmugiBIkIVr7WkSP8VAJqvB1iqtHLS/3iqa4oQbru64Z3se/EhcFanDegySv4nZUUEi3wuUCELl98nboYVlqGl/GM2GDtvE5vN2WGPcf8+RKVciWFcJ8Yg1+/P0tD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728273813; c=relaxed/simple;
	bh=sM14zTUreXFzXcTyE03VL6AugWuiYFlUp4lJMpEASrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5ahn+J3Tq+naPbbstnPJCq9GT3Z7FoMeUEXJSeymljghSm3ZxXo+F0r4zcC/3DUVWTzXePA3mKdfnhfsSJ8uwpvOChXx/t60K0W4Tvly26+0GftcsnH/FzXebRy0r60MXBnwcj4UKokQifi5J1V9kkh3v6IS+p5ycLPfZoSm80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fekEmLoB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C981FC4CED2;
	Mon,  7 Oct 2024 04:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728273813;
	bh=sM14zTUreXFzXcTyE03VL6AugWuiYFlUp4lJMpEASrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fekEmLoBCZqTAX5yeXnfnAfyloGVAKqCNhQ7JWoQjAOibKDNaTvVbLi3bgpsid33t
	 b2soqP71mmNwGSEVOo7kxLKmk/UfkUAIihxw0wJR3PuWKPt38Ko6TYEirrMOx8J0f2
	 tbBpfFE8x4xeTWzi5+3MkLYJh3lF+7+rxUucyhEsqdT8jq2cO3DRO8WEs1tGN10Lge
	 +b8zKom/GM1GKtJN7jmFL3yiM4ytrz2NtdYpB2GQwagMIiyJBQQt4JH4cjTS4ob3M0
	 1ndPCbyyZPo96vRjoyZh/9kLqS3ybX6CSOhZH0EHby6W5z6+c2vbKnDtd2AA161sSA
	 5R2uBjzxJEJXA==
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
Subject: [PATCH v4 5/7] PCI: endpoint: Update documentation
Date: Mon,  7 Oct 2024 13:03:17 +0900
Message-ID: <20241007040319.157412-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007040319.157412-1-dlemoal@kernel.org>
References: <20241007040319.157412-1-dlemoal@kernel.org>
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
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 Documentation/PCI/endpoint/pci-endpoint.rst | 35 +++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
index 21507e3cc238..8e86cd209f9a 100644
--- a/Documentation/PCI/endpoint/pci-endpoint.rst
+++ b/Documentation/PCI/endpoint/pci-endpoint.rst
@@ -117,6 +117,41 @@ by the PCI endpoint function driver.
    The PCI endpoint function driver should use pci_epc_mem_free_addr() to
    free the memory space allocated using pci_epc_mem_alloc_addr().
 
+* pci_epc_map_align()
+
+   A PCI endpoint controller may impose constraints on the RC PCI addresses
+   that can be mapped. The function pci_epc_map_align() allows endpoint
+   function drivers to discover and handle such constraints by providing the
+   size of the memory that must be allocated with pci_epc_mem_alloc_addr()
+   for successfully mapping any RC PCI address. This function will also
+   indicate the size of the PCI address range that can be mapped, which can be
+   less than the requested size, as well as the offset into the allocated
+   memory to use for accessing the RC PCI address range that can be mapped.
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
+  to simplify the PCI address mapping handling in endpoint function drivers.
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


