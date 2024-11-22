Return-Path: <linux-pci+bounces-17204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5790E9D5E74
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 12:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC391B24B13
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 11:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491E61CCB50;
	Fri, 22 Nov 2024 11:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPsq/YRt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2591C524F
	for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2024 11:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732276656; cv=none; b=l9hnFkYLAmPuMi0MHLOElPQPZOAB6EKizeqxO7pLsSP03EtjMXoqpHKjWIAHMR2DOrL+muzNvAjBzdlRC6UVnk2wgHkNARZICZIuVCOF4c32Yro2CGUVj1SgWUz7SQ5zh6o17vU/V2HSXtt17pVTy0/0C+xBQlOOo9qqAbt91I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732276656; c=relaxed/simple;
	bh=6BJTSF6xPFRRie0TWK5txlKn6C5Zv7x8Lv5xkz88ZEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O4SBtCwi6SL234HSptqV7iln9UwT+jvR5S3gN429ABM7aXEe+lKAEZpflLZQ15P1cGoTEuxpPPGtY5nMHf8f4xKx0oNF7BczdYi5hJT3mPCoJE276QrhWc8WARsJbYQIKc3oHQEz9uqSInxBxf2FRHNy/05n87japJWIcOEd9ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPsq/YRt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05581C4CECE;
	Fri, 22 Nov 2024 11:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732276655;
	bh=6BJTSF6xPFRRie0TWK5txlKn6C5Zv7x8Lv5xkz88ZEU=;
	h=From:To:Cc:Subject:Date:From;
	b=oPsq/YRtJSGxhdgJ6yUzFIwLxk6XjSSIrEc+owHbwiMsuS47B/FUXJsKcSG+R3Icw
	 0qQ9Bn2ZTol34HApwvtVmHsInWfnaIn7WyDVyHqtkJ/P0exCihoHdXaaibUPkC9ah5
	 NPLi1kpNX9FeEpVmu4bNKelpsxjbE0dG4gbWDO9Aa5/pSW4YGQ+PwKgVSaChgpcN85
	 lnAqnCmD4ATc7aqTnsJ275lA0oAwt3i2/S/KWPnnsS5QopCQcB3ZW974SI8d/aMdC9
	 dK3u5Hd4hMWqLdXN7mPiC9gyizGIPCCIX7X6UJfWRRzYE6Qia26wcNHD2krtsFgIp6
	 pNM2pgjNKJi7Q==
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
Subject: [PATCH v4 0/5] PCI endpoint additional pci_epc_set_bar() checks
Date: Fri, 22 Nov 2024 12:57:09 +0100
Message-ID: <20241122115709.2949703-7-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1427; i=cassel@kernel.org; h=from:subject; bh=6BJTSF6xPFRRie0TWK5txlKn6C5Zv7x8Lv5xkz88ZEU=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIdCqfe7hLPkszVfpVpqMXOxMXVEXnpbt+d/BnrV7PM+ +ZXcyCuo5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABOxLGL4nynIfS3FgeuM34y5 wj8YPVjfZC48wHE2LKxf+/DPtqMmsgz/dOS9Sq+diDgz06Xa8G3QLwf3CSuYvktf1Yl8cLOOT7m SHQA=
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


Changes since v3:
-Added patch 1/5, which fixes iATU programming on DWC PCIe EP controllers.
-Reordered patches to have a more logical ordering.


Niklas Cassel (5):
  PCI: dwc: ep: iATU registers must be written after the BAR_MASK
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


