Return-Path: <linux-pci+bounces-12057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2087195C41E
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 06:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D0C284EC8
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 04:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3919383BF;
	Fri, 23 Aug 2024 04:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsePWQqA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CFA2E644;
	Fri, 23 Aug 2024 04:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724387154; cv=none; b=Nov7mhs9N3IUJ4oHQQ0yrcjILPPE3UsI1Ig49ZqF+CHcz1lZEGFUE5aM8UFJhaoMC1Ux156qQWRNeq/Kf+bxO8L9LzVZZ+V1ZX0EVKnVAyfNBcyKI50y5EhN2WdJt/txtcGC6w3y94KWjRhcA7MKJEYe9LsXKq5oTWgAdwGiQ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724387154; c=relaxed/simple;
	bh=a9AaoV/PlDTg4wiYf+B6pjA+/siBtOFdk8XhX8IhY7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W6j9DglRFLrs1b0xdxpivfwK90dDfU3DNnYI0RZK5ygwU/Eh264Y4BfWNgjQqf92si8Sl30lCG2rHYQmjPdbq7JuXvXa/IejeG5Gb7PPtVHjs54XE0bQRtC/F+xZu/hneoPHmK6TIU/QuwYwfD4230aHw6+SHJh8hXHLLcP1K9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsePWQqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CBAC32786;
	Fri, 23 Aug 2024 04:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724387154;
	bh=a9AaoV/PlDTg4wiYf+B6pjA+/siBtOFdk8XhX8IhY7Q=;
	h=From:To:Cc:Subject:Date:From;
	b=qsePWQqAqOoFpHKLEKvjWKJjr/6hf3tloxe2aqKutS2czCff++xtOp5S6o/LQtcRc
	 XiLnhxHKzMSbBC/Q3F89ZELhnBgaVUCtRq5DXVvAlQIGQUlWa0uG7xT5jrkcKac6zO
	 Fddwsmfv+O1XLKoOkla/E7/kDqilnX+PKPevGPtWW4qsk8b1Cw9hjYcu3VitDrl75v
	 iZw2RS+IdAnJtaRIgAaVMyAj4UblzbfoWp7CwIvMrNqyVPc+CsYiExRYKyKEiHR9XT
	 8Mmq5B6EzYgTFTSQwt+eNHrBIMtrUXscNyViolQFpGmF2VQp+WI+bYqnYvfb1Ch6FR
	 Hl5ZCnA1/KmdA==
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
Subject: [PATCH v4 0/5] Verify devices transition from D3cold to D0
Date: Thu, 22 Aug 2024 23:25:02 -0500
Message-ID: <20240823042508.1057791-1-superm1@kernel.org>
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

v3->v4:
 * Rebase on 6.11-rc4
 * Sparse fix
 * Index based array init
Mario Limonciello (5):
  PCI: Use an enum for reset type in pci_dev_wait()
  PCI: Check PCI_PM_CTRL instead of PCI_COMMAND in pci_dev_wait()
  PCI: Verify functions currently in D3cold have entered D0
  PCI: Allow Ryzen XHCI controllers into D3cold and drop delays
  PCI: Drop Radeon quirk for Macbook Pro 8.2

 drivers/pci/pci-driver.c    |  2 +-
 drivers/pci/pci.c           | 68 +++++++++++++++++++++++++++----------
 drivers/pci/pci.h           | 12 ++++++-
 drivers/pci/pcie/dpc.c      |  2 +-
 drivers/pci/quirks.c        | 25 --------------
 drivers/usb/host/xhci-pci.c | 11 ------
 6 files changed, 63 insertions(+), 57 deletions(-)

-- 
2.43.0


