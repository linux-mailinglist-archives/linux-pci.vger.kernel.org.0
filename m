Return-Path: <linux-pci+bounces-29890-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8C4ADB98C
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 21:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 437313B6E5E
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 19:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD911D54D8;
	Mon, 16 Jun 2025 19:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQrLLbby"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CA02E40E
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 19:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750102101; cv=none; b=BjqlGknVow5EwqTJLXE9GsUoLewcvs3qTEEbXuYqlvELhtnWP2l+q3gx2sHjKMkhVQvL36yAcvOY9Rv/Ngz/FSxzu3l/kO46sPMybY3BKGtolF+zZBiyw8lWYilNN2Xdtzs+sO2umbuFKVhC0bWcNU/485PW9JQ4Zz++3nD1UTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750102101; c=relaxed/simple;
	bh=ZcKdlyloOp5UhYmRMyfbG+zczfbgd05lYOMk/YU9UkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ds0ge/t8ccW8BV3xXNg/jon3rEqxgx34kGQYaTVPETDXKWAcNPoBNWACHUaSHR7GnurT4C/zgE/TM583N29Tr+c3qi7/O4TVM0fUBoT+DPX37rGerGQaxCri4RUxqEIAr6GUvaIc62bE+R7/ak7lTnP+pXwWKMk5qX40nWFTPTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQrLLbby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0F1C4CEEA;
	Mon, 16 Jun 2025 19:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750102101;
	bh=ZcKdlyloOp5UhYmRMyfbG+zczfbgd05lYOMk/YU9UkA=;
	h=From:To:Cc:Subject:Date:From;
	b=RQrLLbbygB/vFm6epNluX1za5E1D2O0EXMV7gyuS4IcMTLCLfPOFKkBLlF5Iu2tkI
	 oyAldPNBE2df+6XPpM087WvpvKvgdmJeqrP7IBsiRXKObQEkPtkQCB6GQwqdESptB2
	 sVv/l6dchuCIZzT8Bjt43+dZbdsQUIaaOn1LvOzUZzcsMygqQJJ864no5XkOHamwTG
	 2EvIMb0EwW7BX+7xpKrvtcUAjfscwAd1sVs4Wnw/LQFdOpDuFZYH3hj49AeAn0InMD
	 lbgAUv/BIOePMwGLbw+XRdf6v2oOUQWyAIpxzG0tvfHQCWK6IaD1IhCNhNh74uGA+y
	 y6VN4aBIEDQkg==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org
Subject: [PATCH v2 0/2] Don't make noise about disconnected USB4 devices
Date: Mon, 16 Jun 2025 14:26:55 -0500
Message-ID: <20250616192813.3829124-1-superm1@kernel.org>
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

v2:
 * Drop USB patches, these were merged in USB tree already
 * Use pci_dev_is_disconnected() instead

Mario Limonciello (2):
  PCI: Don't show errors on inaccessible PCI devices
  PCI: Fix runtime PM usage count underflow

 drivers/pci/pci-driver.c | 3 ++-
 drivers/pci/pci.c        | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.43.0


