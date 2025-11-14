Return-Path: <linux-pci+bounces-41277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 528A7C5F837
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 23:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 04F1D4E18C4
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 22:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9676E315D46;
	Fri, 14 Nov 2025 22:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzu9VR/J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6A2313522;
	Fri, 14 Nov 2025 22:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763159063; cv=none; b=tUjIXlQbKW0zfAaYIj4swRYiRKmp7HTiEJmEaMe5u0JMbdZGLwxoUIxTdxDbE7Hzpv94G9Ticmmy9jXC/2quFUrIgBTFCmP+2qA1F7Di0C9laG1XUK35OMOpSp9Rf7QRNP2TSCz+hVCTAQV/4/gkF9CXoPkF+DW3s14y7eO7MaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763159063; c=relaxed/simple;
	bh=dUqodLSKCAYIu613ODfUm/kd4gnasWRgxOi7RoF5HOk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LZyv/EQl+ZEuVCUbNWS9WeRv72e3neA8FLHxmGwv9qhzhoJRfMb2d/k5PaRlHoSFMhHqLBylVva0TkZ1Bi/hGo2bDUnyF9a5nNOKFenfnEa1aI1KT/u5P2xArq+uudfTqOUWyYpjVncCaU2gK7lxBMO3Ba/iyohW+PJj7/+AAJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzu9VR/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E56C113D0;
	Fri, 14 Nov 2025 22:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763159061;
	bh=dUqodLSKCAYIu613ODfUm/kd4gnasWRgxOi7RoF5HOk=;
	h=Date:From:To:Cc:Subject:From;
	b=tzu9VR/JlF6ZzzoKi/lAwlMm58ketqyW8eOvvCWldJ4cHM5UTGGM5PsDJfCovjT9J
	 e4MedY7OZZIvLZj5WICDN72d5NNH84E0FGLs9VxpdBcMBkFS+QEkPRRby5nBPywrxb
	 wDooTL31dM1EfT47Izy06Q7afRH88qUUGj3r45MK060X1kZd5SfakwDzdHg1vVy/0C
	 p6IZDhuap0Fa7pJiASx1Yf4pDa794VO3oqCTA0js3ODQk4Z9J2FOvbtdFfnktfFt00
	 5WTspPdPcZfAm4kjtEZ1jqrZDLBWbXtiSxCasj1yfY5IJARJVf4BRIShcVbnzQ4DsJ
	 xkGsEWFbOWzxg==
Date: Fri, 14 Nov 2025 16:24:20 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Christian Zigotzky <chzigotzky@xenosoft.de>,
	Lukas Wunner <lukas@wunner.de>, hypexed@yahoo.com.au,
	linuxppc-dev@lists.ozlabs.org, debian-powerpc@lists.debian.org,
	mad skateman <madskateman@gmail.com>
Subject: [GIT PULL] PCI fixes for v6.18
Message-ID: <20251114222420.GA2346148@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.18-fixes-5

for you to fetch changes up to 921b3f59b7b00cd7067ab775b0e0ca4eca436c2f:

  PCI/ASPM: Avoid L0s and L1 on Hi1105 [19e5:1105] Wi-Fi (2025-11-13 06:17:23 -0600)

----------------------------------------------------------------

- Cache the ASPM L0s/L1 Supported bits early so quirks can override them if
  necessary (Bjorn Helgaas)

- Add quirks for PA Semi and Freescale Root Ports and a HiSilicon Wi-Fi
  device that are reported to have broken L0s and L1 (Shawn Lin, Bjorn
  Helgaas)

----------------------------------------------------------------
Bjorn Helgaas (5):
      PCI/ASPM: Cache L0s/L1 Supported so advertised link states can be overridden
      PCI/ASPM: Add pcie_aspm_remove_cap() to override advertised link states
      PCI/ASPM: Convert quirks to override advertised link states
      PCI/ASPM: Avoid L0s and L1 on Freescale [1957:0451] Root Ports
      PCI/ASPM: Avoid L0s and L1 on PA Semi [1959:a002] Root Ports

Shawn Lin (1):
      PCI/ASPM: Avoid L0s and L1 on Hi1105 [19e5:1105] Wi-Fi

 drivers/pci/pci.h       |  2 ++
 drivers/pci/pcie/aspm.c | 25 +++++++++++++++++--------
 drivers/pci/probe.c     |  7 +++++++
 drivers/pci/quirks.c    | 40 +++++++++++++++++++++-------------------
 include/linux/pci.h     |  2 ++
 5 files changed, 49 insertions(+), 27 deletions(-)

