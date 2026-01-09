Return-Path: <linux-pci+bounces-44386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EC71CD0B2F8
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 17:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F12063007C39
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 16:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A6F27FD44;
	Fri,  9 Jan 2026 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNBCFpkP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103EB272803;
	Fri,  9 Jan 2026 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975652; cv=none; b=hFkLUHodo9tH/YQLP9EieBVx9A9ytNW0a+1/hNcnCgLdDPS5gTtw+LyTu+IV6RIDCDQf+Ft/6fHXtqu3GqaCI0ZMxwIngU97HI3lXN8pV2MadOqe9T3JMtr2UH2r5tOvqfh3X7k+KdgIPVNSTAcfYsvQ2AsibIR97aE520DJQmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975652; c=relaxed/simple;
	bh=2fQfYVzcR/8Py3Ur3ShAZ57iS1mSDN6S2USvgq3iYxY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rkEujRQAUOtva3uMeds0OU+5FDc4v0A4bxGrt4rJ6ZxsPKXnhN66cXMVkLmO5kA0kFQ0Abt/tni1pkC3cbz2uQbGupi2jAOLHjAdXtcQXcAjI1svznd30RETBBT3Xbro+lOIeiV4GjcXgVlItOcu11dBWu19wd9DlrtBxr04JIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNBCFpkP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B769C4CEF1;
	Fri,  9 Jan 2026 16:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767975651;
	bh=2fQfYVzcR/8Py3Ur3ShAZ57iS1mSDN6S2USvgq3iYxY=;
	h=Date:From:To:Cc:Subject:From;
	b=sNBCFpkPqzRCWARX/RHZd9YJ5yEIb7t1CCBIlzjNMb4WDpjWAxJLgla+vt1qi1KZo
	 xm/AJG+41H6T3pGTEpGwzAhccDmq5r4nurzxTZm1lt5Adf37ITswEgGhQT2AV5PovV
	 A+HjbcoqI/BWrTcPPkTyLkR1yvd14t8l21SLHtS1RlakA2ttgEkWKwyAewyGe5Lcg2
	 P6AJNrJQjNMmXK7Hhk6agpacMpOV8cUovys1iqqDbRC7FixrRAIHQzIxXQtmm+AHh+
	 tqC7L4rlMHUJKyX3UBWeMqJ1RQk6dnxy2HtMyN898S/4ewMimgleBlGuIQRMVxTxW3
	 DobKY2AOA660A==
Date: Fri, 9 Jan 2026 10:20:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Nathaniel Roach <nroach44@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
	Linnaea Lavia <linnaea-von-lavia@live.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [GIT PULL] PCI fixes for v6.19
Message-ID: <20260109162050.GA548294@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-v6.19-fixes-2

for you to fetch changes up to bdb32359eab94013e80cf7e3d40a3fd4972da93a:

  sparc/PCI: Correct 64-bit non-pref -> pref BAR resources (2026-01-07 14:22:32 -0600)

----------------------------------------------------------------

- Remove ASPM L0s support for MSM8996 SoC since we now enable L0s when
  advertised, and it caused random hangs on this device (Manivannan
  Sadhasivam)

- Fix meson-pcie to report that the link is up while in ASPM L0s or L1,
  since those are active states from the software point of view, and
  treating the link as down caused config access failures (Bjorn Helgaas)

- Fix up sparc DTS BAR descriptions that are above 4GB but not marked as
  prefetchable, which caused resource assignment and driver probe failures
  after we converted from the SPARC pcibios_enable_device() to the generic
  version (Ilpo Järvinen)

----------------------------------------------------------------
Bjorn Helgaas (1):
      PCI: meson: Report that link is up while in ASPM L0s and L1 states

Ilpo Järvinen (1):
      sparc/PCI: Correct 64-bit non-pref -> pref BAR resources

Manivannan Sadhasivam (1):
      PCI: qcom: Remove ASPM L0s support for MSM8996 SoC

 arch/sparc/kernel/pci.c                | 23 +++++++++++++++++++++
 drivers/pci/controller/dwc/pci-meson.c | 37 +++-------------------------------
 drivers/pci/controller/dwc/pcie-qcom.c |  4 +++-
 3 files changed, 29 insertions(+), 35 deletions(-)

