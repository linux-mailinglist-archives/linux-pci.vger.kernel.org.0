Return-Path: <linux-pci+bounces-10212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70679930045
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 20:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9E51F228F8
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 18:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3CB17C7DB;
	Fri, 12 Jul 2024 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbwPpmtt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A38417C7D5;
	Fri, 12 Jul 2024 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807972; cv=none; b=NrF203BobiBSihhjRSKq4NDR/XeNJbgSaa3LF5q/hvtK4Y3drBVUG0LOkRZe0h5JH7u/K3Af3dmC3a5wOBnPLwKQPJ7VM4Q+xsQTzSan84i5BOycRWP4RIUHEV9xV1w6nDbeX+sHzZXrtMjQncx/5pJ2OT0OZDIsY3OBaeioQS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807972; c=relaxed/simple;
	bh=Aqw7ADBkx3Tvs2SkoNlVlFbMaz51qnfHYmKZBMA5iFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KNO8nHi+TZgMo2W0lKNAd5hXYc1x8wjf4/rly4aaQpEvITuEe2eiMur/aIUfd3yyGcmcdlsk3osGoW74arsg5l4hCRmtUmYtosePRG6fwWJkbUWnWVZMShkajTr0E9KOYVBtViNtZF1+DOI0/+SvIudAbZ7sJ6AwSU7584EjUqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbwPpmtt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C993C4AF10;
	Fri, 12 Jul 2024 18:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720807971;
	bh=Aqw7ADBkx3Tvs2SkoNlVlFbMaz51qnfHYmKZBMA5iFU=;
	h=From:To:Cc:Subject:Date:From;
	b=VbwPpmttay5n2gDokSId049TrwG4+rF/e0W3D52q+36T1lcmKsK244PFsOGStdklY
	 pONoJV35SJgfz2uhpQzz9PSuKw67VKP9WFwqyA3vEk4tHAi0z7kObaidY2cMZT09EJ
	 LMklNaJZmAi9uczmjUwCEgQxXousSQd8lUs78hQE92eD8AIbf5QHM6v0I1QRiB6lZ5
	 HYNYKdV0kRB6b4WIRtHGXrxvLIpd4ZzKCj0NCORocWiivtgStQaen9gs800xSehjw4
	 gBQWCNXp5bYDHy0uKMC07V55TxtIKT1fz6ceh8lzCPvQk0aNOmJ1ta6R1wqNpBMeiW
	 2N4n2qyU1FBiQ==
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
Subject: [PATCH v3 0/5] Verify devices transition from D3cold to D0
Date: Fri, 12 Jul 2024 13:12:41 -0500
Message-ID: <20240712181246.811044-1-superm1@kernel.org>
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

v2->v3:
 * Add an enum for reset types and pass that instead.
v1->v2:
 * Add a fix for a suspend problem

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


