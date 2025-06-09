Return-Path: <linux-pci+bounces-29182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C03AD169B
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 04:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23260167D13
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 02:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C707261D;
	Mon,  9 Jun 2025 02:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+vuPMlr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6362F3E;
	Mon,  9 Jun 2025 02:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749434548; cv=none; b=pDiB8UfyYILUfpUvFkxCzLSrP+tPxzZ3FAw9Cv0M+lkQEc2HL5+nZmpXO7jeXmt+moHz3hwOex8SH2pZ1h8CyWgi4mCx1fN9afa+ZhUNeWKn7Gar8NSZC59W7gqhb7S9a0NC1fpfkyGD7mtX6EBQe3tSqhRRHH1e0BET+DaUReE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749434548; c=relaxed/simple;
	bh=GKVVPYW7fsLWGXJ27H82XRFr2G8LyYDvCFJXp7kftDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ymbzyn77UO2Jh7eb9bEmSQaahGSCTiRuzlgLRIfl5qHOfFbGFzc2XIW5PkwSouV63I3OamYKHf3GxGa/9g3CrlUP68P3cBxQgptx3R3FwS4MAwKt/wfRYhH/POxSiV6/U1N43kISeiqeb8fzUvZqu2v56JKq9nOFwUAddI67Opg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+vuPMlr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E89AC4CEEE;
	Mon,  9 Jun 2025 02:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749434548;
	bh=GKVVPYW7fsLWGXJ27H82XRFr2G8LyYDvCFJXp7kftDM=;
	h=From:To:Cc:Subject:Date:From;
	b=d+vuPMlrArewNLO10ylBrR43TXVjJkg+Z5G/yyUZss4LR0PNGEXVAPgp/ew2fPdUF
	 YryKycaaDbmUk0CFen1KoynEOflMjLDt+xWO6rXXQJ2Dqifg6b9E0ET4H/m2xYPECb
	 Zzs8rGgsHWyt4N1u4SurayanjnzN8C4gWvCW84JZvuJo3tOrd8n8g6bDxjrXEwnUWp
	 1MuXHNiTGBiRir69b+ScRyy2bTKflT0nt3zt9fgJov3v62eMKi/XBZqwAMI0nBQaQ5
	 ccP5yOfibe0NXVR/lrNrZo6ECYblOiZWa2pRr5G4bO+vxOW9i0mvq8EUD7xmtOJhKj
	 B8JmCYGy+77kQ==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	bhelgaas@google.com,
	gregkh@linuxfoundation.org,
	mathias.nyman@intel.com
Cc: linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH 0/4] Don't make noise about disconnected USB4 devices
Date: Sun,  8 Jun 2025 20:58:00 -0500
Message-ID: <20250609020223.269407-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

When a USB4 or TBT3 dock is disconnected a lot of warnings and errors
are emitted related to the PCIe tunnels and XHCI controllers in th
dock.

The messages are loud, but it's mostly because the functions that
emit the messages don't check whether the device is actually alive.
The PCIe hotplug services mark the device as perm dead, so that
can be used to hide some of the messsages.

In the XHCI driver the device is marked as dying already, so that
can also be used to hide messages.

Mario Limonciello (4):
  PCI: Don't show errors on inaccessible PCI devices
  PCI: Fix runtime PM usage count underflow
  usb: xhci: Avoid showing errors during surprise removal
  usb: xhci: Avoid showing warnings for dying controller

 drivers/pci/pci-driver.c     | 3 ++-
 drivers/pci/pci.c            | 5 +++--
 drivers/usb/host/xhci-ring.c | 7 +++++--
 drivers/usb/host/xhci.c      | 6 ++++--
 4 files changed, 14 insertions(+), 7 deletions(-)

-- 
2.43.0


