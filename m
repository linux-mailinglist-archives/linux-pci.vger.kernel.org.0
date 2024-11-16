Return-Path: <linux-pci+bounces-16980-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4D69CFFDF
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 17:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 354591F226CB
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 16:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4401D85270;
	Sat, 16 Nov 2024 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0L3Lkfm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200FBF9CB
	for <linux-pci@vger.kernel.org>; Sat, 16 Nov 2024 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731774976; cv=none; b=eD7B0Th5jXcZckK99RgEVrzIe4JYJZgRQ/Zr2Yd1lbxaXQzHWLaLx8B3p1R6xukauGK3+3WJYPZkuZrvRtabAMp+LikGi73v4q4MnlT1gjw8WlOwqVctOfIVYhebjmQ+9jZ5voGcrbPmMO/869EpXWH9JjK4a1wVVFlM2OSqX2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731774976; c=relaxed/simple;
	bh=CrOKokhowUuc7bYXcQFOSgq+WuD+i6huz5zS/SDjiG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gor/sWJrEjESl1QgvSq7PXa3Hzsjh8OrkfBQjtTjR7HcuDZ/JEXvIIPRKLkDoBjbDju0mUIyG1c3rMWZKmPqZYyB7jfjWmpzG0BUl2yOn+DXZansCGOmaW6vNVXE+X+L30Dbj+mrDrxtqEw/ynChHW1vBz+ot7hQcUE2CjgSGJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0L3Lkfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14ECC4CEC3;
	Sat, 16 Nov 2024 16:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731774975;
	bh=CrOKokhowUuc7bYXcQFOSgq+WuD+i6huz5zS/SDjiG8=;
	h=From:To:Cc:Subject:Date:From;
	b=m0L3Lkfm9UxqWp+NJLqTQw+uHr3x19dVCDGQkd5RnSXl1TgA619YqhUar2xGNzWHz
	 N3UmzV0FZ7VY+cp7F84gyyiwfhFExmhfZ9MYnUcdhkk5QY2/OBCRTi91XulUhAMsb4
	 fZtKBYmQSlx0T5hfYGPWzPX6emPL4U0nXk2Al2pMcELflGN92W1sT2+b9GuyBeWbwD
	 m9EbtI7LKSgFfhOyhN+sBSPTgidkE8cS2ooMENgY2Qpm9hVLlYinoq48btk2W0V2zY
	 0KSOGPx4pSUgrN7vbcov9sAZAKxQuFI1/zr4FLWJPVsW7KTedGBC6Wei4S6qLsel2b
	 OGDYRdvIYf9kg==
From: Niklas Cassel <cassel@kernel.org>
To: Jesper Nilsson <jesper.nilsson@axis.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-arm-kernel@axis.com,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 0/4] PCI endpoint additional pci_epc_set_bar() checks
Date: Sat, 16 Nov 2024 17:35:59 +0100
Message-ID: <20241116163558.2606874-6-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1342; i=cassel@kernel.org; h=from:subject; bh=CrOKokhowUuc7bYXcQFOSgq+WuD+i6huz5zS/SDjiG8=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNItTr77EV0nY7TL1X0344Xu9Q4vzr9PKTf302QXNJ4lr Bn9feKZjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAExE5zjDHy4x3uXLVdXndl++ 9+/68ZLq9ynnTjefd/Wqr1uzhOPKfSaGPzwzY94a/53pVnrtFYdui8OU2Jbb7XEPXwtx9z9O3DT Nkh0A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello all,

This series adds some extra checks to ensure that it is not possible to
program the iATU with an address which we did not intend to use.

If these checks were in place when testing some of the earlier revisions
of Frank's doorbell patches (which did not handle fixed BARs properly),
we would gotten an error, rather than silently using an address which we
did not intend to use.

Having these checks in place will hopefully avoid similar debugging in the
future.


Kind regards,
Niklas


Changes since v2:
-Picked up tags.
-Added patch 3/4, which checks that requested BAR size is a power of two.


Niklas Cassel (4):
  PCI: artpec6: Implement dw_pcie_ep operation get_features
  PCI: endpoint: Add size check for fixed size BARs in pci_epc_set_bar()
  PCI: endpoint: Verify that requested BAR size is a power of two
  PCI: dwc: ep: Add 'address' alignment to 'size' check in
    dw_pcie_prog_ep_inbound_atu()

 drivers/pci/controller/dwc/pcie-artpec6.c       | 13 +++++++++++++
 drivers/pci/controller/dwc/pcie-designware-ep.c |  8 +++++---
 drivers/pci/controller/dwc/pcie-designware.c    |  5 +++--
 drivers/pci/controller/dwc/pcie-designware.h    |  2 +-
 drivers/pci/endpoint/pci-epc-core.c             | 14 ++++++++++++--
 5 files changed, 34 insertions(+), 8 deletions(-)

-- 
2.47.0


