Return-Path: <linux-pci+bounces-17400-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 881279DA5C5
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 11:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79AB1B25FF7
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 10:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C207E1990A8;
	Wed, 27 Nov 2024 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWau27Zd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B821198E99
	for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732703431; cv=none; b=OlmTDhYEAQP8C95S9QxOWoRPyZ3a5unaf6pJ0DLvRqO7y/x+852K28sJzrpF/KyCFiSWfvQq2lsrFAMJqs6FowEt698ukNJ6/5ahYJO9v0oi/EkzpWoQN51iwzTrNacMElqpKSN5RPFJ0v0x9NqkL4yAzOpWuUeitGT2JvpjorA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732703431; c=relaxed/simple;
	bh=bFbOPqXjlptBoCfyRQmEb08iNPRAFYPmOGRqnfdJpm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DhY+5Zsde6RV7olHMqKaquoJZBr1KtgDCK7qh+FUk27/Tadjfs4onCsvg/JGlqy2x3bvR4Gu/8UgzZrIbv38u1pPlPAP1XKcQ4mOY57jmHz5uQIR5ElFVkJUUxkTieNlKpzVtbA/HJoU7inLPKrOF+svUdX96NXk5uTAfQnYRVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWau27Zd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50980C4CECC;
	Wed, 27 Nov 2024 10:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732703431;
	bh=bFbOPqXjlptBoCfyRQmEb08iNPRAFYPmOGRqnfdJpm4=;
	h=From:To:Cc:Subject:Date:From;
	b=HWau27Zd0zuOYRA1/v8DwT3v6eKuS7f4HZIVG3af72Vy7kD5fPrv6YKZFpBKSZKLD
	 VGP/zzg9fITg6guMRkiPnii6b5Wshub7y/iaLhIauSIWL4ED0akTanaPSMC1DotJsA
	 n8QmbdfvZUsJ3HThfQMFk/tk4YSpdM1zflONaQzsdku3iOQApq16ZetLj5X6UWulgY
	 gB72R4PBw6cqBLM7DBF4PCztvBpMFP1gtwvRXAdXdP1PZQmH6SAe9Hj4g16wpwzfPC
	 ur+7HvpYsMS75XN/XTxH2ZpxEvoRDiR3JVM75mwy+OnVOkqWP4SlcZSB+C7XLJY1Fl
	 vRPhUY1QICeVg==
From: Niklas Cassel <cassel@kernel.org>
To: Jesper Nilsson <jesper.nilsson@axis.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Jon Mason <jdmason@kudzu.us>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-arm-kernel@axis.com,
	linux-pci@vger.kernel.org
Subject: [PATCH v5 0/6] PCI endpoint additional pci_epc_set_bar() checks
Date: Wed, 27 Nov 2024 11:30:16 +0100
Message-ID: <20241127103016.3481128-8-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1528; i=cassel@kernel.org; h=from:subject; bh=bFbOPqXjlptBoCfyRQmEb08iNPRAFYPmOGRqnfdJpm4=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLdvuxIdn7rydp2kkfg0end3Qxn/tz/dPScEWe/evpiN t/+b0/7OkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRy6WMDFdlnobIPn1457/X d+myV3ZSTHl/TpUJaJ/zqfq69828rBxGhu37v5nHKLGViM2VPrIlP0Oneq/MjucCJ0x755wWmKR 8nAkA
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


Changes since v4:
-Split patch 1/5 into two patches (patch 1/6 and 2/6), as suggested by Mani.
-Added Cc: stable for patch 1/6, as suggested by Mani.
-Picked up tags from Mani.


Niklas Cassel (6):
  PCI: dwc: ep: iATU registers must be written after the BAR_MASK
  PCI: dwc: ep: Add missing checks when dynamically changing a BAR
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
2.47.0


