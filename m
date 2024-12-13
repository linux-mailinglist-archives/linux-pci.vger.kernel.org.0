Return-Path: <linux-pci+bounces-18377-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C547F9F0F29
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 15:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860E9282378
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 14:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AD51E1A33;
	Fri, 13 Dec 2024 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZX9s+R5w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0BE1E0E10
	for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2024 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100406; cv=none; b=QwIf1Uoadkio7+ys8vkfyc/+X0qMAeMZgCCmCC5+JU3uO/DSteSRIs9G/W/bg6SBRiVjMaeJLd9ZE3deMjfuH7+UVR+h0b5tr9M3VVzXWtu+eYLJT0tBspM4CkbPCzIY5W3/AyQ6V3BEc+7dRNOCLp2cYjxBx5mcUUYfoPw+Frk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100406; c=relaxed/simple;
	bh=6z8g3qZLtqSGsO5JVJC/+rVTF4aAuaeARL1F0sVpqyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tk4NFLisNb4J1nTIAMZ90/DvWr9VRleM8ksy+ofzFFy31erW8+S1tVXMGikHeAsiNzGPJq69sRnJilunrJ0ssPTjn4VTfHZ3EtDp7WtE/x/H2wOewv1mg5Fwu1x/uGawwv6kdJ9JgYdR2NdO/M2m70vTWZXq2dYZIRw7pVEe5O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZX9s+R5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB6BC4CED0;
	Fri, 13 Dec 2024 14:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734100405;
	bh=6z8g3qZLtqSGsO5JVJC/+rVTF4aAuaeARL1F0sVpqyU=;
	h=From:To:Cc:Subject:Date:From;
	b=ZX9s+R5w7J0OrocTsa2ncjBN02bqz/JfUwrf8HeP/prdQJKgbTPH9f/+EPuf8wEpB
	 eFzhqYZ3WBb012YrZRC+W06+0DwmGaF0F+h9atylOOdbO2AL9l/OiqMVHR/wfRhk3i
	 sVJXhidv3nVLwyEU9acyWNN14Z9C6ebemOYugQr817K18Mnpf390GV2fnymopYfWY7
	 qQKcjP8RlJ5wgGwvQt8k4HpRZpRjLbzwik3+vOOLJ65PEd9c3L6ESzMZe93+JEey9x
	 0RoCoOoStGbglqoMopUzyh/CKEAynVd0lL/MPSaJsBTFvMf+EuPH565GVMZqOUhD8a
	 m5ENyUryJebSw==
From: Niklas Cassel <cassel@kernel.org>
To: Jesper Nilsson <jesper.nilsson@axis.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Frank Li <Frank.Li@nxp.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-arm-kernel@axis.com,
	linux-pci@vger.kernel.org
Subject: [PATCH v6 0/6] PCI endpoint additional pci_epc_set_bar() checks
Date: Fri, 13 Dec 2024 15:33:01 +0100
Message-ID: <20241213143301.4158431-8-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1542; i=cassel@kernel.org; h=from:subject; bh=6z8g3qZLtqSGsO5JVJC/+rVTF4aAuaeARL1F0sVpqyU=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJjXOdeYDkcd6gkVs3La9a7OfpLLHz+XZscPV02cJVZo 6hHFuu9jhIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEykx5fhn9UpF2PzpcK/NzO7 yU+OkbK7ZjPtZNsN2xtv4ti3C6w408zwo+n6BJY/x/9M+OzsHKH44uFzoxrNqeuN9D4qvNr/m/E zMwA=
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


Changes since v5:
-Picked up tags.
-Add Cc: stable for patch 2/6.
-Improved commit messages in patch 1/6 and patch 2/6.
-Improved code comment in patch 2/6 to be more specific.

Niklas Cassel (6):
  PCI: dwc: ep: Write BAR_MASK before iATU registers in
    pci_epc_set_bar()
  PCI: dwc: ep: Prevent changing BAR size/flags in pci_epc_set_bar()
  PCI: dwc: ep: Add 'address' alignment to 'size' check in
    dw_pcie_prog_ep_inbound_atu()
  PCI: artpec6: Implement dw_pcie_ep operation get_features
  PCI: endpoint: Add size check for fixed size BARs in pci_epc_set_bar()
  PCI: endpoint: Verify that requested BAR size is a power of two

 drivers/pci/controller/dwc/pcie-artpec6.c     | 13 +++++
 .../pci/controller/dwc/pcie-designware-ep.c   | 52 ++++++++++++++-----
 drivers/pci/controller/dwc/pcie-designware.c  |  5 +-
 drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
 drivers/pci/endpoint/pci-epc-core.c           | 14 ++++-
 5 files changed, 67 insertions(+), 19 deletions(-)

-- 
2.47.1


