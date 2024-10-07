Return-Path: <linux-pci+bounces-13902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AB9992351
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 06:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3151C20A1B
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 04:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0538C200DE;
	Mon,  7 Oct 2024 04:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCy8FxL5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57303C2F
	for <linux-pci@vger.kernel.org>; Mon,  7 Oct 2024 04:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728273803; cv=none; b=CG82t2ZLXgWEO0xud2OhCenHsa/jX0ZpAKvCgaMVPEIixyqMiRdEOh/nWcMPT1ZKTJiRG8bGGG/BOG+5izGU6HI8TjBlWOlituI3hH7fWvyzMnaw6Ok11s5XR6/CBq6EaJUiaxo/s7i5UoBiOfUZC/xTU2jPwD50vNpzZYT9+cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728273803; c=relaxed/simple;
	bh=bR5ytklGH5dV/S9KNlvpa5O9u+Z8FfqN6bywPWwAI5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fvwpf2BYjIzESmpyHLlez/H0KMJNAH49Uainh9BLFP0mR4c323HENK1Loa73QHuaGtr0rR05WiChP1joV09u2eK36eNa+J5o0CbSFzKigl5HlltLpOvfkeQCSiewnpKpw1fk44DZ08z6gMJ/uGtgE1Kbr/ZnKbUFrGodrIy8n8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCy8FxL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA17C4CEC6;
	Mon,  7 Oct 2024 04:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728273803;
	bh=bR5ytklGH5dV/S9KNlvpa5O9u+Z8FfqN6bywPWwAI5E=;
	h=From:To:Cc:Subject:Date:From;
	b=rCy8FxL59M8n3VsGunKdD/g0ZaG7QHN5JOCJUZj3iV3V8zl5lVTbDMDj7qnpjmY87
	 b4v4tEulRep1we3T88696h/DukxJ6KygGkzjsIxocqepFtn5K142EcRX5T7SaOrrSs
	 2K7btdv08hWKVN2uxYx2zI1K13+a0L/n/xTjeZyLjheK1V1LA7p5ibGgHZjecSE2AD
	 T3sTwjPiySsjZcVTTlmqZ+HqB5mNOR4/DVXQb9pEOhVG0d/ovyVzM55zflOMJprYBB
	 gjCc0naQUXYhvYqi3a4wBIee0cmqpW6qHxhKspIv8Ux6eLaDWq135a+407T5jH1SP/
	 zcxXgCrfD4/pw==
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
Subject: [PATCH v4 0/7] Improve PCI memory mapping API
Date: Mon,  7 Oct 2024 13:03:12 +0900
Message-ID: <20241007040319.157412-1-dlemoal@kernel.org>
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
of struct pci_epc_features is defined for inbound ATU entries (e.g.
BARs) and is a fixed value, whereas some controllers need a PCI address
alignment that depends on the PCI address itself. For instance, the
rk3399 SoC controller in endpoint mode uses the lower bits of the local
endpoint memory address as the lower bits for the PCI addresses for data
transfers. That is, when mapping local memory, one must take into
account the number of bits of the RC PCI address that change from the
start address of the mapping.

To fix this, the new endpoint controller method .map_align is introduced
and called from pci_epc_map_align(). This method is optional and for
controllers that do not define it, it is assumed that the controller has
no PCI address constraint.

The functions pci_epc_mem_map() is a helper function which obtains
mapping information, allocates endpoint controller memory according to
the mapping size obtained and maps the memory. pci_epc_mem_unmap()
unmaps and frees the endpoint memory.

This series is organized as follows:
 - Patch 1 introduces a small helper to clean up the epc core code
 - Patch 2 improves pci_epc_mem_alloc_addr()
 - Patch 3 and 4 introduce the new map_align endpoint controller method
   and the epc functions pci_epc_mem_map() and pci_epc_mem_unmap().
 - Patch 5 documents these new functions.
 - Patch 6 modifies the test endpoint function driver to use 
   pci_epc_mem_map() and pci_epc_mem_unmap() to illustrate the use of
   these functions.
 - Finally, patch 7 implements the rk3588 endpoint controller driver
   .map_align operation to satisfy that controller PCI address
   alignment constraint.

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

Damien Le Moal (7):
  PCI: endpoint: Introduce pci_epc_function_is_valid()
  PCI: endpoint: Improve pci_epc_mem_alloc_addr()
  PCI: endpoint: Introduce pci_epc_map_align()
  PCI: endpoint: Introduce pci_epc_mem_map()/unmap()
  PCI: endpoint: Update documentation
  PCI: endpoint: test: Use pci_epc_mem_map/unmap()
  PCI: dwc: endpoint: Define the .map_align() controller operation

 Documentation/PCI/endpoint/pci-endpoint.rst   |  35 ++
 .../pci/controller/dwc/pcie-designware-ep.c   |  15 +
 drivers/pci/endpoint/functions/pci-epf-test.c | 372 +++++++++---------
 drivers/pci/endpoint/pci-epc-core.c           | 223 ++++++++---
 drivers/pci/endpoint/pci-epc-mem.c            |   9 +-
 include/linux/pci-epc.h                       |  41 ++
 6 files changed, 465 insertions(+), 230 deletions(-)

-- 
2.46.2


