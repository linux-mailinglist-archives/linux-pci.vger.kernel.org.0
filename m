Return-Path: <linux-pci+bounces-12535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CF5966B06
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 22:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2AA11F24486
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 20:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F0B1BF7FE;
	Fri, 30 Aug 2024 20:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxdt0rhJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651DE1BDAB5;
	Fri, 30 Aug 2024 20:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051456; cv=none; b=apbF7CjXCUf+pmItafUpLHn1y8GOLAqYVY0V13tIMxFbBXWAYXTDIzuNHAAB6vGycZ7J6X6NhkhAueYFXb0akIY0oDG/xPF7E272bIuJlo6jdnI0zWBrrnZzFpLudnOxtdRq3FRiwfX7NqK7sXSe4xaWd5s6E/e2rL6S06z2QXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051456; c=relaxed/simple;
	bh=U4FLLiC46YTJ1zWKSr1e04/tjfLXMDEd1NZ5lGlraVE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SQcWr6deMrbOP+lhOHKWVw5OtbrXyki0GtwYBPrRQ/yOoSjL0XnJI65o62bzs1kog71zJsryP4Om9Uowrjm/Y2iu7oCXdSRtNeuTM8rztFFnjk/qEunEijWqtszUBZXOGtneL2ls70lMGSAJOkM/uUToCuJ6nfLEQ3x4WXUdToM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxdt0rhJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81D7C4CEC2;
	Fri, 30 Aug 2024 20:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725051456;
	bh=U4FLLiC46YTJ1zWKSr1e04/tjfLXMDEd1NZ5lGlraVE=;
	h=Date:From:To:Cc:Subject:From;
	b=hxdt0rhJ6o2njsxXo7SY61hN0A9XCEH9oQcSC2yxtjK+Lc/ViihufOlNb8QMUlThU
	 CmfHxUDTqt63ZZcNLz3xBayAUIWJec8CtSKqgcza/UfE1ZHcOnp8Za6m4bZ/sWt1Ft
	 ZkuBEbxeUqVn//gEDXLXhlnV0LLXL3IP/6wCe+qkNaHWyBQcz2QgFpW9QBPpXFyMRK
	 0OXQjdoptObJRQsEyaRNWHc/TBtgct7ClP2Qw37BkUAjx6Sf+RBEnJH1g0oHzHUJLo
	 SiXMA45/Kq6q2eJeS4WnsTW2L5g0O/BSdF3hRkXZuA8MqVQe2E4gJh+TSJLeLqA9aR
	 K4nvdEaus6XNA==
Date: Fri, 30 Aug 2024 15:57:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Frank Li <Frank.Li@nxp.com>
Subject: [GIT PULL] PCI fixes for v6.11
Message-ID: <20240830205733.GA126293@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-v6.11-fixes-2

for you to fetch changes up to 150b572a7c1df30f5d32d87ad96675200cca7b80:

  MAINTAINERS: PCI: Add NXP PCI controller mailing list imx@lists.linux.dev (2024-08-30 13:07:21 -0500)

----------------------------------------------------------------
- Add Manivannan Sadhasivam as PCI native host bridge and endpoint driver
  reviewer (Manivannan Sadhasivam)

- Disable MHI RAM data parity error interrupt for qcom SA8775P SoC to work
  around hardware erratum that causes a constant stream of interrupts
  (Manivannan Sadhasivam)

- Don't try to fall back to qcom Operating Performance Points (OPP) support
  unless the platform actually supports OPP (Manivannan Sadhasivam)

- Add imx@lists.linux.dev mailing list to MAINTAINERS for NXP layerscape
  and imx6 PCI controller drivers (Frank Li)

----------------------------------------------------------------
Frank Li (1):
      MAINTAINERS: PCI: Add NXP PCI controller mailing list imx@lists.linux.dev

Manivannan Sadhasivam (3):
      MAINTAINERS: Add Manivannan Sadhasivam as Reviewer for PCI native host bridge and endpoint drivers
      PCI: qcom-ep: Disable MHI RAM data parity error interrupt for SA8775P SoC
      PCI: qcom: Use OPP only if the platform supports it

 MAINTAINERS                               |  3 +++
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 13 +++++++++++++
 drivers/pci/controller/dwc/pcie-qcom.c    |  7 +++++--
 3 files changed, 21 insertions(+), 2 deletions(-)

