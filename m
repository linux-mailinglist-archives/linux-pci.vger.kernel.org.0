Return-Path: <linux-pci+bounces-40534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F7DC3D14B
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 19:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A23426B8C
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 18:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FE5350D40;
	Thu,  6 Nov 2025 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXi4PjQS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0F7350A2B;
	Thu,  6 Nov 2025 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762454211; cv=none; b=mczZoUxkxNYK7NvDpyNwWvhOXOz5u4aOzPlWy3h2oKpTdOkN4XZsAoGM8vPboZ4+4OU3sYsIymYSZ+RtPbA1IQZSDMsakoSNrg9yGPQUi+0GCWXQFUEqIp91OaDPZ7kz8G8X/cVyrc8l2TVVa1XHgUJhWu9pWrFjjhtATLHNsdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762454211; c=relaxed/simple;
	bh=ovJgUkK1UaueWtGueNfGGSGbgibwAdLBLmWiDB1y0xY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XZxJV49qMjWPXucUMH1c+ByUZ/sDHX0CfH5gZlBy3rfa0UXRRCSqjKocZwG8H0UXPAJPr0dPS9xs5j6WEcUa7+85eC47H/iiOCqDiPbFWR8/m0/oPKZLagkp2ZLLN7aGLNEXK7C6tVjGj/cPIePtfNPUE2XA7eLHb0z2LFhwiug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXi4PjQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E52C16AAE;
	Thu,  6 Nov 2025 18:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762454210;
	bh=ovJgUkK1UaueWtGueNfGGSGbgibwAdLBLmWiDB1y0xY=;
	h=From:To:Cc:Subject:Date:From;
	b=XXi4PjQSB4Oxl69IwggGTCQIC/3oJLu4KgfZcMACoIM7uoR4x/570zQRcRgEqUXrk
	 gpC9t5uFUMf0oNjw/HiN2PZc+vU+T18e4DtiUnnl9R0zfitqwpfKPWguKcwGYJgzMU
	 D2uvSXRzHarbDEXiiZF+3wV6DjkzvB6aEByyxVELMk7wR81aApOlv3a4Klz0zRz9Uu
	 BHcIynN9o4K4dH5L4xhITng4qUv06jqeXWK4qtuK3nZHXbQ9OE7dDAwiHp9LkKz2WW
	 9Fbq+EjhKWNsAiyG8OG8O9HVZVE/vQOFHKHg+JKFZCf9kehXkC9kUkZLrrWTy5W0SD
	 qB8m4b2riraRw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	mad skateman <madskateman@gmail.com>,
	"R . T . Dickinson" <rtd2@xtra.co.nz>,
	Darren Stevens <darren@stevens-zone.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lukas Wunner <lukas@wunner.de>,
	luigi burdo <intermediadc@hotmail.com>,
	Al <al@datazap.net>,
	Roland <rol7and@gmx.com>,
	Hongxing Zhu <hongxing.zhu@nxp.com>,
	hypexed@yahoo.com.au,
	linuxppc-dev@lists.ozlabs.org,
	debian-powerpc@lists.debian.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] PCI/ASPM: Allow quirks to avoid L0s and L1
Date: Thu,  6 Nov 2025 12:36:37 -0600
Message-ID: <20251106183643.1963801-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

We enabled ASPM too aggressively in v6.18-rc1.  f3ac2ff14834 ("PCI/ASPM:
Enable all ClockPM and ASPM states for devicetree platforms") enabled ASPM
L0s, L1, and (if advertised) L1 PM Substates.

L1 PM Substates and Clock PM in particular are a problem because they
depend on CLKREQ# and sometimes device-specific configuration, and none of
this is discoverable in a generic way.

df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms")
(v6.18-rc3) backed off and omitted Clock PM and L1 Substates.

L0s and L1 are generically discoverable, but some devices advertise them
even though they don't work correctly.  This series is a way to avoid L0s
and L1 in that case.

Bjorn Helgaas (2):
  PCI/ASPM: Cache Link Capabilities so quirks can override them
  PCI/ASPM: Avoid L0s and L1 on Freescale Root Ports

 drivers/pci/pcie/aspm.c | 42 ++++++++++++++++++++---------------------
 drivers/pci/probe.c     |  5 ++---
 drivers/pci/quirks.c    | 12 ++++++++++++
 include/linux/pci.h     |  1 +
 4 files changed, 36 insertions(+), 24 deletions(-)

-- 
2.43.0


