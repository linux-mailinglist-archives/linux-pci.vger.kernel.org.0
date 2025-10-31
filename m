Return-Path: <linux-pci+bounces-39966-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D93ECC26E1D
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 21:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3951A665ED
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 20:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4151220FA81;
	Fri, 31 Oct 2025 20:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ky5Eq+Me"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197F718BC3D;
	Fri, 31 Oct 2025 20:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761941968; cv=none; b=c5tDsUyjcN14ZDtxcsR2xHHHkvbYagARdbvpt096+4ULw3vrp71O1VciVFu2Mlcv8YTZy/Q3qNusBUWsKn2tRbGSBMOoCkX09x16RKXOf0pTwHt+313DqPDBBVnRpfz6of5I2jnmKJsf7v94Q6cfbItF6LiCkLXI14HwQTyuANw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761941968; c=relaxed/simple;
	bh=+H2Kb7Uaz1YcISZpEOyhak2luzO19Hkcp3qJ6q98JGw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pKQLhO47VnBkVzI9Ovoo+SNHUK5CEtzwamJ9vngWvVBZJ2YPeoxlsZddtyJ7JXOhsNZFMx/EnZpAfyjcRdu9Bxo+pFijniyNKEmRVor3uQ55i8MhHt0GDDdWwwyjWNtg0+o0WZHacOOHCH+LyChtsqHe0KDI+CNMOK/BSokbqkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ky5Eq+Me; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD6AC4CEE7;
	Fri, 31 Oct 2025 20:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761941967;
	bh=+H2Kb7Uaz1YcISZpEOyhak2luzO19Hkcp3qJ6q98JGw=;
	h=Date:From:To:Cc:Subject:From;
	b=Ky5Eq+MevFe5gkHqEpGg2eYUggciZPB25AqlQUu1HfOW0LNq3a4+SLzpMXarJt1cU
	 z8EpopUMWJfWtUWbOLgRscZeQ/J/IIHaNbCT/GDoPK4EazoECO7/8M9uNw+auFcgEC
	 7EQDEjByUVIphUArFp0FM6961fMPMPZ0dak1J5Wq41nyHGwXgUj4wA0OcgOpnwW6+P
	 YJl248fs5VSHOyyzghV1+WJhH1HU1J4AIS6zu52q1AljWp4zQaOWV4DM9RDezwJ9C4
	 VPrqlzo1NNH+H31/Y9XAm9yDZ2J+v73C6OelkDZAESA3e7gYfx9MV2+2m0Nh7lYI/R
	 Igv36h0CYTCJQ==
Date: Fri, 31 Oct 2025 15:19:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Klaus Kudielka <klaus.kudielka@gmail.com>
Subject: [GIT PULL] PCI fixes for v6.18
Message-ID: <20251031201926.GA1706862@bhelgaas>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.18-fixes-4

for you to fetch changes up to 437aa64c8e32b724fc6d60100ef0eb313d32c88f:

  PCI: Do not size non-existing prefetchable window (2025-10-31 15:07:21 -0500)

----------------------------------------------------------------

- Restore custom qcom ASPM enablement code so L1 PM Substates are enabled
  as they were in v6.17 even though the PCI core now enables just L0s and
  L1 by default (Bjorn Helgaas)

- Size prefetchable bridge windows only when they actually exist, to avoid
  a WARN_ON() regression (Ilpo Järvinen)

----------------------------------------------------------------
Bjorn Helgaas (1):
      Revert "PCI: qcom: Remove custom ASPM enablement code"

Ilpo Järvinen (1):
      PCI: Do not size non-existing prefetchable window

 drivers/pci/controller/dwc/pcie-qcom.c | 32 ++++++++++++++++++++++++++++++++
 drivers/pci/setup-bus.c                |  2 +-
 2 files changed, 33 insertions(+), 1 deletion(-)

