Return-Path: <linux-pci+bounces-3655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF92858A32
	for <lists+linux-pci@lfdr.de>; Sat, 17 Feb 2024 00:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27BEA1C22519
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 23:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0A11487C5;
	Fri, 16 Feb 2024 23:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ridb9F8u"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A851DFFD;
	Fri, 16 Feb 2024 23:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708126504; cv=none; b=RdYKyRXkIxLp5J/ybwHCpouck34ph3IPFNSB5vsSTs5bFRnT8Xx2DhybWWMTiLDF5HD6v8bE42PgfVi+ZtIGDSWn3af34G8G3IlAQ8/47yQY32FV7XcA1pKwRAOO56HnI+fIaTlrRVLb83+vb4BOqnnaewJOMjOZkI9CVlDyczI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708126504; c=relaxed/simple;
	bh=U1wMspvLAL0UvPRSFZ4Rkdd8TUVFp8FYfrWPx3igRqs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W5VOqmJ6NMR3rmJPHkNrviblLgPBUXb0YNJYg+NPSy67Z4wIiLLfxDClvDgd/aWG5/ZGDax6KZHNAmgsZAW9Bn1OqSZZkWFLGyIGLHqAjktigRC9nBbwMVNwZhLIAJGC5wxbd0f0EGKoJppQty0jvXC1pZL0Kjve5GtB3eh35aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ridb9F8u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58564C433F1;
	Fri, 16 Feb 2024 23:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708126503;
	bh=U1wMspvLAL0UvPRSFZ4Rkdd8TUVFp8FYfrWPx3igRqs=;
	h=Date:From:To:Cc:Subject:From;
	b=ridb9F8u7AH/NMGd2bDoowNeouM3mg0Q4oG3QY2X/5mm1+qcTHjp8+M2Cmw4r8ItU
	 1JpkJXvVRT3lAvAZ8Nk5a+4mr0g3F2/07HK3DYDOxBdc5JLvxLyWEQp+Fil3wGL/l+
	 ZS46dlWiLufXXYzxqZHwGlQ0G3qCpurAB6BMb+OeItU1DaeQPjft5avV2njYSVOm3+
	 kzZrNvyU8FaZzlc7phOXlF5Xxs4NTWV9nmeZWYI9tczEAj6kllHEq+GxRGNblTMP02
	 i1C6qeArAZtA6cbzXHwnzULGs7he4ALScrjnh0Jog4dLpABopQbNbMJq+3+JebSeVz
	 zsBd+NCF2Jisw==
Date: Fri, 16 Feb 2024 17:35:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Sanath S <sanath.s@amd.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] PCI fixes for v6.8
Message-ID: <20240216233501.GA1362441@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.8-fixes-3

for you to fetch changes up to 172c0cf519fb52860157c57067f1a58cfc0aa861:

  MAINTAINERS: Add Siddharth Vadapalli as PCI TI DRA7XX/J721E reviewer (2024-02-16 16:42:59 -0600)

----------------------------------------------------------------
- Keep bridges in D0 if we need to poll downstream devices for PME to
  resolve a v6.6 regression where we failed to enumerate devices below
  bridges put in D3hot by runtime PM, e.g., NVMe drives connected via
  Thunderbolt or USB4 docks (Alex Williamson)

- Add Siddharth Vadapalli as PCI TI DRA7XX/J721E reviewer

----------------------------------------------------------------
Alex Williamson (1):
      PCI: Fix active state requirement in PME polling

Siddharth Vadapalli (1):
      MAINTAINERS: Add Siddharth Vadapalli as PCI TI DRA7XX/J721E reviewer

 MAINTAINERS       |  1 +
 drivers/pci/pci.c | 37 ++++++++++++++++++++++---------------
 2 files changed, 23 insertions(+), 15 deletions(-)

