Return-Path: <linux-pci+bounces-40788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACBFC4996E
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 23:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B728B4F3C07
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 22:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612962FD7AC;
	Mon, 10 Nov 2025 22:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+5t5Swo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3881930101B;
	Mon, 10 Nov 2025 22:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813787; cv=none; b=fZs5yjAgKDV6TutTsObcSiFaipuWLMro4xC6xJYJQvQ9UhWu32s1kP+zKR+w5XFv0slnl2sOk0KiG2DVmWz/mIpiuob2n22QsEvzcgeUpdeJUsN/cmyi8N3R2pwW7ySBgiVnEo/mRGw8o7TpJymir+NKakZ8u/dx2o70g9rWLiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813787; c=relaxed/simple;
	bh=Ew1J1aHGuwLLJKwapglsP0+NcHadMOOCXzL3ZeOS9U0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mu02KzoZ2uvLuAQTARlNeEIdFyjOruudLBrU2nepC5EHXFpXfQIcYCmUFnPvlLIm3WGwWdw3YA7M+BcYkGmv4vjvvwNImdYzBqoMUYpciT5LH7nT3inBvkbfmPwfuSu5kN0F/zvmCqoCk7XCa3IQxqdtGt1plm9sNUSljbx7OIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+5t5Swo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0BCC16AAE;
	Mon, 10 Nov 2025 22:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762813786;
	bh=Ew1J1aHGuwLLJKwapglsP0+NcHadMOOCXzL3ZeOS9U0=;
	h=From:To:Cc:Subject:Date:From;
	b=m+5t5Swo67nM7sEdysvArYvIok7mMcmERnJmNun+u5J3G3GBvrq+qiRqn/zPoyaC2
	 LZqa2i8RTZnLt7i0cTBpcvfBOL9ArsRcbeNK4robmStbfggXqKKxV+vJSh6KA+fuuW
	 7x9fhhIorg/qa5GfYjACeV6CvN6Kq/r7uLCGU34Q4seUnbRwprLpqgRwM6+xkWlYis
	 DDb86yBdVCor4GLwlP0RCz/t51N+dka1CCmpINkyOLqgCDqWbxURt2S8sHUT5rzpI1
	 k9j5PKoi8/aZ84OYGfsrDvV3U4z/fJbU3NMWhzXvq/e4q7RJGlV+IzWtVkVPHXu+U2
	 +XkWqlhds645w==
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
Subject: [PATCH v2 0/4] PCI/ASPM: Allow quirks to avoid L0s and L1
Date: Mon, 10 Nov 2025 16:22:24 -0600
Message-ID: <20251110222929.2140564-1-helgaas@kernel.org>
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

df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms")
(v6.18-rc3) backed off and omitted Clock PM and L1 Substates because we
don't have good infrastructure to discover CLKREQ# support, and L1
Substates may require device-specific configuration.

L0s and L1 are generically discoverable and should not require
device-specific support, but some devices advertise them even though they
don't work correctly.  This series is a way to add quirks avoid L0s and L1
in this case.


Bjorn Helgaas (4):
  PCI/ASPM: Cache L0s/L1 Supported so advertised link states can be
    overridden
  PCI/ASPM: Add pcie_aspm_remove_cap() to override advertised link
    states
  PCI/ASPM: Convert quirks to override advertised link states
  PCI/ASPM: Avoid L0s and L1 on Freescale Root Ports

 drivers/pci/pci.h       |  2 ++
 drivers/pci/pcie/aspm.c | 25 +++++++++++++++++--------
 drivers/pci/probe.c     |  7 +++++++
 drivers/pci/quirks.c    | 38 +++++++++++++++++++-------------------
 include/linux/pci.h     |  2 ++
 5 files changed, 47 insertions(+), 27 deletions(-)

-- 

v1: https://lore.kernel.org/r/20251106183643.1963801-1-helgaas@kernel.org

Changes between v1 and v2:
- Cache just the two bits for L0s and L1 support, not the entire Link
  Capabilities (Lukas)
- Add pcie_aspm_remove_cap() to override the ASPM Support bits in Link
  Capabilities (Lukas)
- Convert existing quirks to use pcie_aspm_remove_cap() instead of
  pci_disable_link_state(), and from FINAL to HEADER (Mani)

