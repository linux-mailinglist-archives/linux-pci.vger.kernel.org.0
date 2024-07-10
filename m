Return-Path: <linux-pci+bounces-10102-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFA092DA6D
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 22:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDA591F22ED9
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 20:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3277B198833;
	Wed, 10 Jul 2024 20:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6JalqmD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ABD2B9DD;
	Wed, 10 Jul 2024 20:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720645127; cv=none; b=AIvhEw/nsO7bbPugw+YDZREtnTA6oD0TlrJcXVgygUq88uZLfCESIDkyL9/xRg3NGfdraAB75YczvVjQHbkIRNFp6DfeJmxVRFVX9XVOeObh6QNsL1/EOON9/3wkh5xNz/8IFFFgFcTdz2qHCWkUi6lTb5FaECW+huz4Aq5uHWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720645127; c=relaxed/simple;
	bh=PUHR8OrUrQpwbc9bDfnIl09K0oQLlWW8WgIsdygr33A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HU5EerRDogBh3xhTJYsMebsuQiyAdQLhK/CsIzAlqlXpQnW1tivRsGj5J5qobXqgtIFBYAsRTlNFi28GLgwEOSHa5A9idJoWn0gqpuyU7C5/n//XBE8npp6wq1yzlUJ6Xc5WBaXxYRzd+paowu10a6BoxWE/VRCBy5bE5One5NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6JalqmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2D3C32781;
	Wed, 10 Jul 2024 20:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720645126;
	bh=PUHR8OrUrQpwbc9bDfnIl09K0oQLlWW8WgIsdygr33A=;
	h=From:To:Cc:Subject:Date:From;
	b=P6JalqmDczKER1XbLxdXAJyzwq2lZDsfFCVg9G2dcYFvm2P1z0sfM678dren/vVuJ
	 7mREF/1hM47hPHuG/QZ3hJysm9TAnUf7QVKFJCWHsYLFdfD8sQP5f3V5cDiNk2ZXQD
	 ziu0OwDWH8iL1yNNfDoW7e0ky/BsYoOyvgwLL7VAgvDeXu8E3wD89NQrME9/2w04vS
	 4hUkgpA3W9nTBxqRLumK8VxR/whaygyr+auONjno99W4cCFoYIGp/S1LK1lWDwCbRM
	 tcfgISQtm7m3E/GgmY3ADt5kkofAeCSZ8bnU7iOvelbIrN07YANYl18mRSzbHundE8
	 1VafRTDP9ppLw==
From: superm1@kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	Daniel Drake <drake@endlessos.org>,
	Gary Li <Gary.Li@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 0/4] Verify devices transition from D3cold to D0
Date: Wed, 10 Jul 2024 15:58:34 -0500
Message-ID: <20240710205838.2413465-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>


Gary has reported that when a dock is plugged into a system at the same
time the autosuspend delay has tripped that the USB4 stack malfunctions.

Messages show up like this:

```
thunderbolt 0000:e5:00.6: ring_interrupt_active: interrupt for TX ring 0 is already enabled
```

Furthermore the USB4 router is non-functional at this point.

Those messages happen because the device is still in D3cold at the time
that the PCI core handed control back to the USB4 connection manager
(thunderbolt).

The issue is that it takes time for a device to enter D3cold and do a
conventional reset, and then more time for it to exit D3cold.

This appears not to be a new problem; previously there were very similar
reports from Ryzen XHCI controllers.  Quirks were added for those.
Furthermore; adding extra logging it's apparent that other PCI devices
in the system can take more than 10ms to recover from D3cold as well.

This series add a wait into pci_power_up() specifically for D3cold exit and
then drops the quirks that were previously used for the Ryzen XHCI controllers.

v1->v2:
 * Add a fix for a suspend problem

Mario Limonciello (4):
  PCI: Check PCI_PM_CTRL in pci_dev_wait()
  PCI: Verify functions currently in D3cold have entered D0
  PCI: Allow Ryzen XHCI controllers into D3cold and drop delays
  PCI: Drop Radeon quirk for Macbook Pro 8.2

 drivers/pci/pci.c           | 38 ++++++++++++++++++++++++++++++-------
 drivers/pci/quirks.c        | 25 ------------------------
 drivers/usb/host/xhci-pci.c | 11 -----------
 drivers/usb/host/xhci.h     | 11 +++++------
 4 files changed, 36 insertions(+), 49 deletions(-)

-- 
2.43.0


