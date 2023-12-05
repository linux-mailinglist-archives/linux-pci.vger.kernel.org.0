Return-Path: <linux-pci+bounces-517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A31F1805ADC
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 18:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56052281DDE
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 17:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C556928A;
	Tue,  5 Dec 2023 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLLFSIeo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6FD69288
	for <linux-pci@vger.kernel.org>; Tue,  5 Dec 2023 17:11:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C9BC433C7;
	Tue,  5 Dec 2023 17:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701796284;
	bh=uQ8NO0YEvmWRTXpfKA698SVu/8BUZMEaJADM8AXng0A=;
	h=From:To:Cc:Subject:Date:From;
	b=QLLFSIeoQ9Rb8Oq5nr1rquMQbHONSD/WqnFsmDNi22I7HaHcC+2iOL+HW8hgkm+8s
	 i+U9FVet2uN+P9vsr5aOKuCagl9KFtHCcm5CcZaim8kJyN5a19ZinbYwEBGVZHkDTk
	 gK7FU4MOj/xJxtCmCm4tslm8be9OfkwDzuXWENseaVcwZW3DIBSoAN1yMTFiDECu2T
	 NUJ462V1FpxI0Oh52aU0l8YB1D7lHAWdlL3FmCKDP4MKr1JL44KJcGDNb5qKElQVgl
	 aabUDbjQLzwy66ymRpfGdP7ZBuaXM6Q+l1Jeuie1hmUrA6tslrtulFT3bPB+ylyta/
	 MzcEP4pV0Z+Yw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/7] PCI: Improve enumeration logging
Date: Tue,  5 Dec 2023 11:11:12 -0600
Message-Id: <20231205171119.680358-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

This is based on Puranjay Mohan's work at
https://lore.kernel.org/all/20211106112606.192563-1-puranjay12@gmail.com/
which updated BAR resource logging to consistently use "BAR 0" instead of a
mix of "BAR 0", "reg 0x10", etc.

I added:

  - More BAR resource log updates
  - Device type (PCIe Root Port, Switch Port, etc) to initial message
  - Bridge info logging in logical order (bridge before downstream)

Bjorn Helgaas (5):
  PCI: Log device type during enumeration
  PCI: Move pci_read_bridge_windows() below individual window accessors
  PCI: Supply bridge device, not secondary bus, to read window details
  PCI: Log bridge windows conditionally
  PCI: Log bridge info when first enumerating bridge

Puranjay Mohan (2):
  PCI: Update BAR # and window messages
  PCI: Use resource names in PCI log messages

 drivers/pci/iov.c       |   7 +-
 drivers/pci/pci.c       |  85 ++++++++++++++--
 drivers/pci/pci.h       |   2 +
 drivers/pci/probe.c     | 218 ++++++++++++++++++++++++----------------
 drivers/pci/quirks.c    |  15 ++-
 drivers/pci/setup-bus.c |  30 ++++--
 drivers/pci/setup-res.c |  72 +++++++------
 7 files changed, 286 insertions(+), 143 deletions(-)

-- 
2.34.1


