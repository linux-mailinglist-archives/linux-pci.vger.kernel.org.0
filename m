Return-Path: <linux-pci+bounces-13795-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D32298FCE2
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 07:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BFFE1F21B89
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 05:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B262868E;
	Fri,  4 Oct 2024 05:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NChJaZy5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296E328F3
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 05:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728018465; cv=none; b=qv6TaX3lMYnhQAE32JGB7wti5xLhpJXUVEyqMR9M5G8Pbd94fcUDw2iaG8Ug8662GzQiWTNfrBRBNv+fKJiVkaxMyRT+FKPT1YZrYl+1ZSFeVDb5iGmmdDPc9yHs3R1cNIiJbDso9eCo4TiKDq+PejmKCQGKwcOsAEEWjM7NS5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728018465; c=relaxed/simple;
	bh=d8KqMX3QIBoR7GMg2+/wHRfgTiPL5t7CGySdTy+yCjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VUEhqAhUcZETPIe4mrFWOFnIjheU8PKCsqDxGoxA2SkvMbyBNgVr+0fxIwpaZ8oK9bhVAqRon5zzGcnAadjI9TWexejHY6SwCAPD5UM6AeEz2nSResFV7gn/aQxYaz3Z2qvENfS7OdFmFcZ1gC1ohN1QLxnjIGN4jXP2COuHUrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NChJaZy5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E4EC4CEC6;
	Fri,  4 Oct 2024 05:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728018464;
	bh=d8KqMX3QIBoR7GMg2+/wHRfgTiPL5t7CGySdTy+yCjA=;
	h=From:To:Cc:Subject:Date:From;
	b=NChJaZy5qH9081vN1ODii32yDz8x2rrrrFK2ox/46o6vnLQZickEMeS8g1yOY1SdI
	 ikUaGCfj24xIU2SNS9OOTa4POV9RztiUcBdQEocrlgoUxVHuq2751l6+v4EptU3E1+
	 LQCNJBi5AuKNKsKDvb0jmUFjKvxDhatqkSKzDf1CuDFruc9ofSlvZh0tOHBawJ7C/o
	 nm9SdZ/Yeez8ShlimiPqv90NOLuV5rcVkBB4OEbRk9TCC6BY1Ct/+pI/Zh63X/ULbK
	 ELW4nLraUcrEevgOp52jo0R+uo+QXQSygQ6d2yI8qgZdmYRqD7iamqC4CGF3H52CuZ
	 ihFsTrWWe3Ykg==
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
Subject: [PATCH v3 0/7] Improve PCI memory mapping API
Date: Fri,  4 Oct 2024 14:07:35 +0900
Message-ID: <20241004050742.140664-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces the new functions pci_epc_map_align(),
pci_epc_mem_map() and pci_epc_mem_unmap() to improve handling of the
PCI address mapping alignment constraints of endpoint controllers in a
controller independent manner.

The issue fixed is that the fixed alignment defined by the "align" field
of struct pci_epc_features assumes is defined for inbound ATU entries
(e.g. BARs) and is a fixed value, whereas some controllers need a PCI
address alignment that depends on the PCI address itself. For instance,
the rk3399 SoC controller in endpoint mode uses the lower bits of the
local endpoint memory address as the lower bits for the PCI addresses
for data transfers. That is, when mapping local memory, one must take
into account the number of bits of the RC PCI address that change from
the start address of the mapping.

To fix this, the new endpoint controller method .map_align is introduced
and called from pci_epc_map_align(). This method is optional and for
controllers that do not define it, it is assumed that the controller has
no PCI address constraint.

The functions pci_epc_mem_map() is a helper function which obtains
mapping information, allocates endpoint controller memory according to
the mapping size obtained and maps the memory. pci_epc_mem_unmap()
unmaps and frees the endpoint memory.

This series is organized as follows:
 - Patch 1 tidy up the epc core code
 - Patch 2 improves pci_epc_mem_alloc_addr()
 - Patch 3 and 4 introduce the new map_align endpoint controller method
   and the epc functions pci_epc_mem_map() and pci_epc_mem_unmap().
 - Patch 5 documents these new functions.
 - Patch 6 modifies the test endpoint function driver to use 
   pci_epc_mem_map() and pci_epc_mem_unmap() to illustrate the use of
   these functions.
 - Finally, patch 7 implements the rk3588 endpoint controller driver
   .map_align operation to satisfy that controller 64K PCI address
   alignment constraint.

Changes from v2:
 - Dropped all patches for the rockchip-ep. These patches will be sent
   later as a separate series.
 - Added patch 2 and 5
 - Added review tags to patch 1

Changes from v1:
 - Changed pci_epc_check_func() to pci_epc_function_is_valid() in patch
   1.
 - Removed patch "PCI: endpoint: Improve pci_epc_mem_alloc_addr()"
   (former patch 2 of v1)
 - Various typos cleanups all over. Also fixed some blank space
   indentation.
 - Added review tags

Damien Le Moal (7):
  PCI: endpoint: Introduce pci_epc_function_is_valid()
  PCI: endpoint: Improve pci_epc_mem_alloc_addr()
  PCI: endpoint: Introduce pci_epc_map_align()
  PCI: endpoint: Introduce pci_epc_mem_map()/unmap()
  PCI: endpoint: Update documentation
  PCI: endpoint: test: Use pci_epc_mem_map/unmap()
  PCI: dwc: endpoint: Define the .map_align() controller operation

 Documentation/PCI/endpoint/pci-endpoint.rst   |  33 ++
 .../pci/controller/dwc/pcie-designware-ep.c   |  15 +
 drivers/pci/endpoint/functions/pci-epf-test.c | 372 +++++++++---------
 drivers/pci/endpoint/pci-epc-core.c           | 213 +++++++---
 drivers/pci/endpoint/pci-epc-mem.c            |   9 +-
 include/linux/pci-epc.h                       |  41 ++
 6 files changed, 453 insertions(+), 230 deletions(-)

-- 
2.46.2


