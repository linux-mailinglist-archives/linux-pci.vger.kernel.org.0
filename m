Return-Path: <linux-pci+bounces-33926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02563B24024
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 07:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 929E3726D56
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 05:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFD828EA72;
	Wed, 13 Aug 2025 05:21:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CAB2110E;
	Wed, 13 Aug 2025 05:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755062510; cv=none; b=tEL+1LO3tqSioQW5EMeCEok6W80hKuoY3+RuYp5OpXiSQQq307bIBXlkkA9x9wvhg6Xwp+SssXn39P4lwB86RsI7BM6idIsf1zYMEv0aSuR+9lE/5lb/Vt6qsd/6UYAfoV2pYlCaLy5eYxlOxC2BE9Ik0Dd8hOAvXAS/BJDIJXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755062510; c=relaxed/simple;
	bh=0iLRSWUDLSAFS6EfD++lBN82EDa3SnSb6SS0qXb+udM=;
	h=Message-ID:From:Date:Subject:To:Cc; b=m2MV+OaXAVsL4ERgcutB6tcDI9NjX9oeFnaOxNJQikjZPP0Yuy6nd1IIaQ9/53kVr990p8ReNS68NEwchX9HAcQqdH92gOTvAPP0FqaaRSsw4d234GAAHhxeEyX583zeIAxSb4HYOgshkkUCSpUN9WhjSzapatODncVRiTjLLhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout1.hostsharing.net (Postfix) with UTF8SMTPS id 726BB18C48;
	Wed, 13 Aug 2025 07:11:36 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with UTF8SMTPSA id 3B6E06000EA5;
	Wed, 13 Aug 2025 07:11:36 +0200 (CEST)
X-Mailbox-Line: From 1d72a891a7f57115e78a73046e776f7e0c8cd68f Mon Sep 17 00:00:00 2001
Message-ID: <cover.1755008151.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 13 Aug 2025 07:11:00 +0200
Subject: [PATCH 0/5] PCI: Reduce AER / EEH deviations
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Riana Tauro <riana.tauro@intel.com>,
	Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>,
	"Sean C. Dardis" <sean.c.dardis@intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Linas Vepstas <linasvepstas@gmail.com>,
	"Mahesh J Salgaonkar" <mahesh@linux.ibm.com>,
	"Oliver OHalloran" <oohall@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	Shahed Shaikh <shshaikh@marvell.com>,
	Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Edward Cree <ecree.xilinx@gmail.com>, linux-net-drivers@amd.com,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vg.smtp.subspace.kernel.org,
	er.kernel.org@web.codeaurora.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The kernel supports three different PCI error recovery mechanisms:

* AER per PCIe r7.0 sec 6.2 (drivers/pci/pcie/aer.c + err.c)
* EEH on PowerPC (arch/powerpc/kernel/eeh_driver.c)
* zPCI on s390 (arch/s390/pci/pci_event.c)

In theory, they should all follow Documentation/PCI/pci-error-recovery.rst
to afford uniform behavior to drivers across platforms.

In practice, there are deviations which this series seeks to reduce.

One particular pain point is AER not allowing drivers to opt in to a
Bus Reset on Non-Fatal Errors (patch [1/5]).  EEH allows this and the
"xe" graphics driver would like to take advantage of it on AER-capable
platforms.  Patches [2/5] to [4/5] address various other deviations,
while patch [5/5] cleans up old gunk in code comments.

I've gone through all drivers implementing pci_error_handlers to ascertain
that no regressions are introduced by these changes.  Nevertheless further
reviewing and testing would be appreciated to raise the confidence.
Thanks!

Lukas Wunner (5):
  PCI/AER: Allow drivers to opt in to Bus Reset on Non-Fatal Errors
  PCI/ERR: Fix uevent on failure to recover
  PCI/ERR: Notify drivers on failure to recover
  PCI/ERR: Update device error_state already after reset
  PCI/ERR: Remove remnants of .link_reset() callback

 .../ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c   |  1 -
 .../net/ethernet/qlogic/qlcnic/qlcnic_main.c  |  2 -
 drivers/net/ethernet/sfc/efx_common.c         |  3 --
 drivers/net/ethernet/sfc/falcon/efx.c         |  3 --
 drivers/net/ethernet/sfc/siena/efx_common.c   |  3 --
 drivers/pci/pcie/err.c                        | 40 ++++++++++++++-----
 drivers/scsi/lpfc/lpfc_init.c                 |  2 +-
 drivers/scsi/qla2xxx/qla_os.c                 |  5 ---
 8 files changed, 32 insertions(+), 27 deletions(-)

-- 
2.47.2


