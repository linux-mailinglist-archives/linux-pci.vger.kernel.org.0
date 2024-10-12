Return-Path: <linux-pci+bounces-14387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DC699B486
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 13:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC861B24E5A
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 11:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2EE18C325;
	Sat, 12 Oct 2024 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlhiQHBw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9803189B8F
	for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732775; cv=none; b=KD4LUmorti1Bo2ZluYp4cHfrqLdTkDl2Snf4aHn7CjEXrxhJnm/7LU5jdpPjB1XhbURcGhofe495WVzZd6zMjp5r0Pi/FWiob11RaMe3JdZCczQk8zYUmzYZCAYlHNPVG/DzJZ46zVUt9ldAjaX8C+Y69ax5se/NXE8C3YYv7yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732775; c=relaxed/simple;
	bh=SkqSdyz37LkaUyrCI1q2KVdaqN3iMXUOzYKClEE6VDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qh9osCAj5/mKGncm3eaf4+i8CKlgSfnbaejkr82yFnAEPVLsajJSquk+QA4DRMgh1srQwh4aeIAHTrhIijCfG55XTfZGv6+yjhu0dOHuYmcKiqa6fr9o7wjSX0fSyPwJqgDMViDpW9csi+hk51ey93PCfdRdycPOUiuyE4wtWXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlhiQHBw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBEA2C4CED0;
	Sat, 12 Oct 2024 11:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732775;
	bh=SkqSdyz37LkaUyrCI1q2KVdaqN3iMXUOzYKClEE6VDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IlhiQHBworWHKduxbe0Ig6iAx7ZFKMu219tGR3ez7sj7g2WaDNqrCYAk7M5Yb3I0P
	 4O3WBLODWgDLd/Vc8m5YRfgqSccwLA30BIEozC0I2Jcfo6UHntc1ace70JwkCH8K0y
	 7tvfGIiBKlBhGfNTyx681B76IAKHi5lEW1zvc+FgqY6DCRZf85Vd0G6SwdG8PnCF7g
	 srfzSZbprTDbuWQJxDrapghh2UrS0Pmplt3hiJWbHT+5UPrBurHEdt4udcXrN7fgxi
	 hb8lDmTh8GkzSuvxqONkOVhB4QFItpPilJRmnf3gdwQ2lOMWrKTcMga6KER97hwGqg
	 EFkhLcn4sGsgg==
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
Subject: [PATCH v6 4/6] PCI: endpoint: Update documentation
Date: Sat, 12 Oct 2024 20:32:44 +0900
Message-ID: <20241012113246.95634-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241012113246.95634-1-dlemoal@kernel.org>
References: <20241012113246.95634-1-dlemoal@kernel.org>
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
Reviewed-by: Niklas Cassel <cassel@kernel.org>
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


