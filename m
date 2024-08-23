Return-Path: <linux-pci+bounces-12122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC8895D1CE
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 17:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4A21F27550
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 15:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A9218BBA6;
	Fri, 23 Aug 2024 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BD0DVQNQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED84E18BBA3;
	Fri, 23 Aug 2024 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427635; cv=none; b=MfVunWSm1veekdIbeIZa7l3x6AEWyJ/kOLb0yV79k4/QnqRVs31EzMDs6bi9qmR+JiY57b6Bv+Vo3TLtGxZ3+jWVHTlELK4weYr0/uliADYmRjDIZ0dNBm3ul66i8/6i0pFn3cA/oYnx/7FvyI2O+zN4LZUGJnQyetMBjFUaPcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427635; c=relaxed/simple;
	bh=aLi9/+U9UkyqRo2wj4MKMZZy1G9ZHIG2P3x0xO+c+5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=posV3Yp22eb2yQYRSEXUlGJRKWPmOTddUEz2X34l0hLAwcQmBIdwzcaq3VC/Yu5oKLp9xFMFdXelpBom1tdMqC9JLbXCzWj+j67Cu0GJoZy9CHKUnLdQ56rFaFHgoHYgpy5L8P52/vOEocBD2tzD39g5dtneCbjfCJnPJuKj0cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BD0DVQNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE5DC4AF09;
	Fri, 23 Aug 2024 15:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724427634;
	bh=aLi9/+U9UkyqRo2wj4MKMZZy1G9ZHIG2P3x0xO+c+5k=;
	h=From:To:Cc:Subject:Date:From;
	b=BD0DVQNQOdWGI7ho2gjkVx/ZJFzkeFw6+2FxImPslce+Gu2z6oO+39vgf/oKiIm8v
	 2YtVm2alVPCVMYBJzT1fdxiwyH4tHMFdbSF43SWM35Vkm/fGD1h1/DWr209tk6evOZ
	 AUa+aGXUfmNuTg028hjovZiBi9mwVUnQDHAZHPdp9MyXfcCi9WqpKycwTegQR0fR4m
	 1gd3CScwi/DTU526RuC5rObR+vNA6VvZ+ameg0qQIfN0Qu83Ssl2o8pLLT4uPszGpB
	 +k2QIZZu8OsIWGWMysiMKGKT1Ns5/jnC7VRaiK9txEOj7oGjFLt39/xFZ1L/d3/VjS
	 ICXvkaHeqf7sQ==
From: Mario Limonciello <superm1@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	Daniel Drake <drake@endlessos.org>,
	Gary Li <Gary.Li@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 0/5] Verify devices transition from D3cold to D0
Date: Fri, 23 Aug 2024 10:40:18 -0500
Message-ID: <20240823154023.360234-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Mario Limonciello (5):
  PCI: Use an enum for reset type in pci_dev_wait()
  PCI: Check PCI_PM_CTRL instead of PCI_COMMAND in pci_dev_wait()
  PCI: Verify functions currently in D3cold have entered D0
  PCI: Allow Ryzen XHCI controllers into D3cold and drop delays
  PCI: Drop Radeon quirk for Macbook Pro 8.2

 drivers/pci/pci-driver.c    |  2 +-
 drivers/pci/pci.c           | 70 +++++++++++++++++++++++++++----------
 drivers/pci/pci.h           | 13 ++++++-
 drivers/pci/pcie/dpc.c      |  2 +-
 drivers/pci/quirks.c        | 25 -------------
 drivers/usb/host/xhci-pci.c | 11 ------
 6 files changed, 66 insertions(+), 57 deletions(-)

-- 
2.43.0


