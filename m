Return-Path: <linux-pci+bounces-39292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79783C07E80
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 21:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB0E91A67DEC
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 19:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E8F299944;
	Fri, 24 Oct 2025 19:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpjzvzA1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F342299931;
	Fri, 24 Oct 2025 19:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761334147; cv=none; b=PCJ3xe03TlhPPqIoXB5CjiQFwvpKK+38yjMx7Re0s+5IGcwGTb9tvuVGCcK1n6YNFKTHRLR8dhb8CvEPLDv2URUoB8WRo7Cep+RuzBp/vxwOqWdcOoR9u0oseTpiX08wklFo5tPpluWYTX3Wu+HBMxk7oPlXn0+0ekLn0I/2w1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761334147; c=relaxed/simple;
	bh=N5IIqjmOeWmLOz2zHVxqEA+WLcaesU5e/utvVwXoDkA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mTUk2RcF+tzl7U8tonmOXmFLHaBRXrX8BMKs8v+s9ThL65nlsAvZSwsjcc39GPZn0GS8b2svoVCeP26bQzP9bBMPRFFOhGHDR7HFWpDfzacVBQGzGthysIUtSFrD8BfmmkwWNd6vuSWmtVcTxpT+Ue61wfcaQ17WupL3e+g05NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpjzvzA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919E5C4CEF1;
	Fri, 24 Oct 2025 19:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761334144;
	bh=N5IIqjmOeWmLOz2zHVxqEA+WLcaesU5e/utvVwXoDkA=;
	h=Date:From:To:Cc:Subject:From;
	b=jpjzvzA1haU4EZKYPT016IUISm/tXebW5eU1fIiWnCJpsXoXf1t6Q7nAERG06TFYw
	 2g7TYeXPbCeNxibyuMz1D18FSfzzQilOj2bHhL6ixjwhHqExW4YMWp1kLp9L0RGxCj
	 W5ux/6aSa7HWxGQvM06f3Fv8hA5oOnSoPE8cSq9cCH62RwrWSsSrRVpL3XVVFHY3nz
	 zjZR5SbdW3WYzyAdVdytz1atd1iXpEr38IO7x7R/KgTIEmsidbDZFvQKK+xv8PDbYf
	 bkTo2jj1VHWhpXiDVHGQ7C69rCFGL/QzKvKL1btgFoiS3h1BBQflOm+Mao1p3231nq
	 b8qNc1Jo7v+5A==
Date: Fri, 24 Oct 2025 14:29:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Ron Economos <re@w6rz.net>, "Maciej W. Rozycki" <macro@orcam.me.uk>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Christian Zigotzky <chzigotzky@xenosoft.de>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Diederik de Haas <diederik@cknow-tech.com>,
	Dragan Simic <dsimic@manjaro.org>, Johan Hovold <johan@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
	linux-mips@vger.kernel.org
Subject: [GIT PULL] PCI fixes for v6.18
Message-ID: <20251024192903.GA1360890@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.18-fixes-3

for you to fetch changes up to df5192d9bb0e38bf831fb93e8026e346aa017ca8:

  PCI/ASPM: Enable only L0s and L1 for devicetree platforms (2025-10-23 20:08:14 -0500)

----------------------------------------------------------------

- Add DWC custom pci_ops for the root bus instead of overwriting the DBI
  base address, which broke drivers that rely on the DBI address for iATU
  programming; fixes an FU740 probe regression (Krishna Chaitanya Chundru)

- Revert qcom ECAM enablement, which is rendered unnecessary by the DWC
  custom pci_ops (Krishna Chaitanya Chundru)

- Fix longstanding MIPS Malta resource registration issues to avoid
  exposing them when the next commit fixes the boot failure (Maciej W.
  Rozycki)

- Use pcibios_align_resource() on MIPS Malta to fix boot failure caused by
  using the generic pci_enable_resources() (Ilpo Järvinen)

- Enable only ASPM L0s and L1, not L1 PM Substates, for devicetree
  platforms because we lack information required to configure L1 Substates;
  fixes regressions on powerpc and rockchip.  A qcom regression (L1
  Substates no longer enabled) remains and will be addressed next (Bjorn
  Helgaas)

----------------------------------------------------------------
Bjorn Helgaas (1):
      PCI/ASPM: Enable only L0s and L1 for devicetree platforms

Ilpo Järvinen (1):
      MIPS: Malta: Use pcibios_align_resource() to block io range

Krishna Chaitanya Chundru (2):
      PCI: dwc: Use custom pci_ops for root bus DBI vs ECAM config access
      Revert "PCI: qcom: Prepare for the DWC ECAM enablement"

Maciej W. Rozycki (2):
      MIPS: Malta: Fix keyboard resource preventing i8042 driver from registering
      MIPS: Malta: Fix PCI southbridge legacy resource reservations

 arch/mips/mti-malta/malta-setup.c                 |  4 +-
 arch/mips/pci/pci-malta.c                         |  3 +-
 drivers/pci/controller/dwc/pcie-designware-host.c | 28 ++++++++--
 drivers/pci/controller/dwc/pcie-qcom.c            | 68 -----------------------
 drivers/pci/pcie/aspm.c                           | 34 +++---------
 5 files changed, 36 insertions(+), 101 deletions(-)

