Return-Path: <linux-pci+bounces-30973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A347AEC0EC
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 22:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C3B56588A
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 20:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520BF220698;
	Fri, 27 Jun 2025 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXerUr1Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7C621D3C6;
	Fri, 27 Jun 2025 20:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751056052; cv=none; b=ITKvA76y7csT3BE+QmRhGvoDrEMZCm/4S/eqZUNnS6K3873g8bayg/4UPhRfgnPB1zQQr+6YEivQtV429mQ0914XUxeZEoqizSoQ9OmZXU0gGyqfUGd3jo15x38AYuWF54+6O3moykBOYw9eYXkUXh03sQQeJGGUAqOw+tYxP5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751056052; c=relaxed/simple;
	bh=QDKVwtK2TEwDIXhfVWLXDxgF4PMvRsSYsSJwf6t+eWA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dDRD+SaOBY2JGKUNL5pWsj9+CfJxu8e/PvPLniXfQWbCoYeO7FopRkJ+DXbdsMhdCIsd9K6A4TCYJ4Js7qyNl0KFtHfj4amHrIzK/+K4zqWxsGSuoKLClG/w5tzZovbyN8aZToiGFjKv9B55f1K20BhkSknmZ8akMouxqPXWhDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXerUr1Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975AFC4CEE3;
	Fri, 27 Jun 2025 20:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751056051;
	bh=QDKVwtK2TEwDIXhfVWLXDxgF4PMvRsSYsSJwf6t+eWA=;
	h=Date:From:To:Cc:Subject:From;
	b=pXerUr1ZpL/lyDDuhY/20jjRuDzMsyOFBtnNOAMyFpscGHNnKV6o45N97kY3KI01y
	 e+CgI0IGH8h+k7mS1gJW/FgKKjNim+vQ1Ydqnihq1FCbtpbXWS0LxziElz66+y2JiR
	 eJc3OgL3hbmTaMjBME2hTcOubf1+5YRnWJGQgZSPGzzHi1eQS5KHKz4QDUn3C6AU63
	 ARfsp9UCYTCAJjQ5Sa4zbCn2KSSEfMpkRZdPFWwKJ1Vzfkww/E7Me5YxiEZYk+eBWK
	 wULPZF/nV9hj3L1E0OUvPKefyeXBcPNgWgzi9h+LsiTkGFL3akU92y1s6vsaHV3c/3
	 6ekqNtJysygNw==
Date: Fri, 27 Jun 2025 15:27:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [GIT PULL] PCI fixes for v6.16
Message-ID: <20250627202730.GA1683609@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.16-fixes-2

for you to fetch changes up to 5aa326a6a2ff0a7e7c6e11777045e66704c2d5e4:

  PCI/PTM: Build debugfs code only if CONFIG_DEBUG_FS is enabled (2025-06-23 12:55:49 -0500)

----------------------------------------------------------------

- Fix a PTM debugfs build error with CONFIG_DEBUG_FS=n && CONFIG_PCIE_PTM=y
  (Manivannan Sadhasivam)

----------------------------------------------------------------
Manivannan Sadhasivam (1):
      PCI/PTM: Build debugfs code only if CONFIG_DEBUG_FS is enabled

 drivers/pci/pcie/ptm.c | 2 ++
 1 file changed, 2 insertions(+)

