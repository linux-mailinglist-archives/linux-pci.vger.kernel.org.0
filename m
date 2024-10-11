Return-Path: <linux-pci+bounces-14283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB92599A320
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 14:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DA121F24402
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 12:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80941217314;
	Fri, 11 Oct 2024 12:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRhBSFIR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C66E217311
	for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 12:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648079; cv=none; b=fl4Fesv+B2CKtOkiNCai9a6eD0xmwYr+ZGbyvuRoEBINq+FPh2pMfnXxZ5+wTfCh8nVgOPy3Wssn4hKojMOGYHOlnfdZXpmLedywcH3irRtn84aLx4/MIH2PQXy3sjlD/LAJcex7OBrpL1VKpsnF+kFOQLuT0GdGivd3aCKUVpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648079; c=relaxed/simple;
	bh=Vh5iroiS7AhvJh0eXPGPR2pdnkqyT7gQJv9dOlJqPWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rVsL1jE2vAqr8suxtFhqDfjA3YHmy58LuOZ0tbIN6E5lRhbtCK9vIChUG062/Ug3l5hxWSydjtKQJPAJhd+JDOnqVuzRROp1v8leL/SU+C6bjdMWhhq0WoPkoMlCdQvRlQ6AAl5yQrF2XV9gt94v44QTID9Rsls4xUrLIikfWL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRhBSFIR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7A8C4CEC3;
	Fri, 11 Oct 2024 12:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728648078;
	bh=Vh5iroiS7AhvJh0eXPGPR2pdnkqyT7gQJv9dOlJqPWM=;
	h=From:To:Cc:Subject:Date:From;
	b=QRhBSFIRWxxOL3pKGBMZyalZoxqO7xKjeZhtSTVrYJrFGy41X12sVc7l9l2XNjvAt
	 BT9EFb1diNqQxADTRgTkHa57S7gUy4OjaI7NuwgrFM5huxv24VBB75+HQ3gxNbeaHN
	 rBrTxLa9K0TgXiaqbr+KqAWcI2+N9RUr/Xt+//o/OJAX2OG4WBcKQm7atV+Q/T7QpS
	 N4ga8Ws94LmTE8UY9O52p4iy1cyOoMssUxq4MWZvnNZf8dsp6Cuz9pc7VHRdwta+qQ
	 w9I310zq9f+XNVD3PsZm/AJE3YI8FQtRci1sb63yQCMC4JtuSPKkNfVFo2n3WejhO3
	 iV6Vh1EpqwNOg==
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
Subject: [PATCH v5 0/6] Improve PCI memory mapping API
Date: Fri, 11 Oct 2024 21:01:09 +0900
Message-ID: <20241011120115.89756-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces the new functions pci_epc_mem_map() and
pci_epc_mem_unmap() to improve handling of the PCI address mapping
alignment constraints of endpoint controllers in a controller
independent manner.

The issue fixed is that the fixed alignment defined by the "align" field
of struct pci_epc_features is defined for inbound ATU entries (e.g.
BARs) and is a fixed value, whereas some controllers need a PCI address
alignment that depends on the PCI address itself. For instance, the
rk3399 SoC controller in endpoint mode uses the lower bits of the local
endpoint memory address as the lower bits for the PCI addresses for data
transfers. That is, when mapping local memory, one must take into
account the number of bits of the RC PCI address that change from the
start address of the mapping.

To fix this, the new endpoint controller method .get_mem_map is
introduced and called from the new pci_epc_mem_map() function. This
method is optional and for controllers that do not define it, it is
assumed that the controller has no PCI address constraint.

The functions pci_epc_mem_map() is a helper function which obtains
the mapping information, allocates endpoint controller memory according
to the mapping size obtained and maps the memory. pci_epc_mem_unmap()
unmaps and frees the endpoint memory.

This series is organized as follows:
 - Patch 1 introduces a small helper to clean up the epc core code
 - Patch 2 improves pci_epc_mem_alloc_addr()
 - Patch 3 introduce the new get_mem_map endpoint controller method
   and the epc functions pci_epc_mem_map() and pci_epc_mem_unmap().
 - Patch 4 documents these new functions.
 - Patch 5 modifies the test endpoint function driver to use 
   pci_epc_mem_map() and pci_epc_mem_unmap() to illustrate the use of
   these functions.
 - Finally, patch 6 implements the RK3588 endpoint controller driver
   .get_mem_map operation to satisfy that controller PCI address
   alignment constraint.

This patch series was tested using the pci endpoint test driver (as-is
and a modified version removing memory allocation alignment on the host
side) as well as with a prototype NVMe endpoint function driver (where
data transfers use addresses that are never aligned to any specific
boundary).

Changes from v4:
 - Removed the patch adding the pci_epc_map_align() function. The former
   .map_align controller operation is now introduced in patch 3 as
   "get_mem_map()" and used directly in the new pci_epf_mem_map()
   function.
 - Modified the documentation patch 4 to reflect the previous change.
 - Changed patch 6 title and modified it to rename map_align to
   get_mem_map in accordance with the new patch 3.
 - Added review tags

Changes from v3:
 - Addressed Niklas comments (improved patch 2 commit message, added
   comments in the pci_epc_map_align() function in patch 3, typos and
   improvements in patch 5, patch 7 commit message).
 - Added review tags

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

Damien Le Moal (6):
  PCI: endpoint: Introduce pci_epc_function_is_valid()
  PCI: endpoint: Improve pci_epc_mem_alloc_addr()
  PCI: endpoint: Introduce pci_epc_mem_map()/unmap()
  PCI: endpoint: Update documentation
  PCI: endpoint: test: Use pci_epc_mem_map/unmap()
  PCI: dwc: endpoint: Implement the pci_epc_ops::get_mem_map() operation

 Documentation/PCI/endpoint/pci-endpoint.rst   |  29 ++
 .../pci/controller/dwc/pcie-designware-ep.c   |  15 +
 drivers/pci/endpoint/functions/pci-epf-test.c | 372 +++++++++---------
 drivers/pci/endpoint/pci-epc-core.c           | 205 +++++++---
 drivers/pci/endpoint/pci-epc-mem.c            |   9 +-
 include/linux/pci-epc.h                       |  39 ++
 6 files changed, 439 insertions(+), 230 deletions(-)

-- 
2.47.0


