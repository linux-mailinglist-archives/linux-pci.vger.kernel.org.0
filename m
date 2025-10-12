Return-Path: <linux-pci+bounces-37852-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9934BD029F
	for <lists+linux-pci@lfdr.de>; Sun, 12 Oct 2025 15:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0BA13B8677
	for <lists+linux-pci@lfdr.de>; Sun, 12 Oct 2025 13:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E7C239E81;
	Sun, 12 Oct 2025 13:25:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81C51B78F3
	for <linux-pci@vger.kernel.org>; Sun, 12 Oct 2025 13:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760275509; cv=none; b=CdDZLu0gCXzmNJ+IxKGmcTPD4W7tQqMAWCaAwDbslTVRQczXuRJZwSa5BfUfZwSqUZkZ6uIyyokx6874XZnvmRrLN1czULdDL0RZ4JZwZ/FgtPOjrndB8qHalAaE0aox9cJVA4REjE/pF8iZXK1HXPtvsapbziCLAg1E1SgTW6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760275509; c=relaxed/simple;
	bh=2chwjQJnCHtjIvlKV3jgJaOYRthrxtyYW5b3l/nCneQ=;
	h=Message-Id:From:Date:Subject:To:Cc; b=MfFTtBmszt3U2fekCv5lAHeFGxKMfMk17BUL3zTsIAhPnGn12X4Fyu6envQHkW0SHChTHhHQ57/gsWWBssbaUJwjJiZ5K1NH/xKaICGGQOMjL0H8jBQu9XliFXueImp62Wwto5vxcslZjrj/xmZkVI1rEDEXLolS8EcGulXUYWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 3703D2C02BA0;
	Sun, 12 Oct 2025 15:25:02 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E910D4A12; Sun, 12 Oct 2025 15:25:01 +0200 (CEST)
Message-Id: <cover.1760274044.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 12 Oct 2025 15:25:00 +0200
Subject: [PATCH 0/2] PCI: Universal error recoverability of devices
To: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Riana Tauro <riana.tauro@intel.com>, "Sean C. Dardis" <sean.c.dardis@intel.com>, Farhan Ali <alifm@linux.ibm.com>, Benjamin Block <bblock@linux.ibm.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Alek Du <alek.du@intel.com>, "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
    Giovanni Cabiddu <giovanni.cabiddu@intel.com>, qat-linux@intel.com, Dave Jiang <dave.jiang@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

When PCI devices are reset -- either to recover from an error or
after a D3hot/D3cold transition -- their Config Space needs to be
restored.

D3hot/D3cold transitions happen under the control of the kernel,
hence it is able to save Config Space before and restore it afterwards.

However errors may occur unexpectedly and it may then be impossible
to save Config Space because the device may be inaccessible (e.g. DPC)
or Config Space may be corrupted.  So it must be saved ahead of time.

This isn't done consistently because the PCI core doesn't take care
of it and only a subset of drivers do.  The situation is aggravated
by the behavior of pci_restore_state(), which only allows restoring
Config Space once and invalidates the saved copy afterwards.

Solve all these problems by saving an initial copy of Config Space
on device addition which drivers may update if they change registers.
Modify pci_restore_state() to allow using the saved copy indefinitely
and drop all the workarounds for its previous behavior that have
accumulated in the tree.

Lukas Wunner (2):
  PCI: Ensure error recoverability at all times
  treewide: Drop pci_save_state() after pci_restore_state()

 drivers/crypto/intel/qat/qat_common/adf_aer.c    | 2 --
 drivers/dma/ioat/init.c                          | 1 -
 drivers/net/ethernet/broadcom/bnx2.c             | 2 --
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 1 -
 drivers/net/ethernet/broadcom/tg3.c              | 1 -
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c  | 1 -
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c  | 2 --
 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c | 1 -
 drivers/net/ethernet/intel/e1000e/netdev.c       | 1 -
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c     | 6 ------
 drivers/net/ethernet/intel/i40e/i40e_main.c      | 1 -
 drivers/net/ethernet/intel/ice/ice_main.c        | 2 --
 drivers/net/ethernet/intel/igb/igb_main.c        | 2 --
 drivers/net/ethernet/intel/igc/igc_main.c        | 2 --
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    | 1 -
 drivers/net/ethernet/mellanox/mlx4/main.c        | 1 -
 drivers/net/ethernet/mellanox/mlx5/core/main.c   | 1 -
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c      | 1 -
 drivers/net/ethernet/microchip/lan743x_main.c    | 1 -
 drivers/net/ethernet/myricom/myri10ge/myri10ge.c | 4 ----
 drivers/net/ethernet/neterion/s2io.c             | 1 -
 drivers/pci/bus.c                                | 7 +++++++
 drivers/pci/pci.c                                | 3 ---
 drivers/pci/pcie/portdrv.c                       | 1 -
 drivers/pci/probe.c                              | 2 --
 drivers/scsi/bfa/bfad.c                          | 1 -
 drivers/scsi/csiostor/csio_init.c                | 1 -
 drivers/scsi/ipr.c                               | 1 -
 drivers/scsi/lpfc/lpfc_init.c                    | 6 ------
 drivers/scsi/qla2xxx/qla_os.c                    | 5 -----
 drivers/scsi/qla4xxx/ql4_os.c                    | 5 -----
 drivers/tty/serial/8250/8250_pci.c               | 1 -
 drivers/tty/serial/jsm/jsm_driver.c              | 1 -
 33 files changed, 7 insertions(+), 62 deletions(-)

-- 
2.51.0


