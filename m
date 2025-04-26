Return-Path: <linux-pci+bounces-26829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CF6A9DD00
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 22:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFB567A9830
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 19:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9577F1EDA13;
	Sat, 26 Apr 2025 19:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fudcxCQw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A19D6AD3;
	Sat, 26 Apr 2025 19:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745697599; cv=none; b=AyykO0kt75G+A+lLgsoWT8pjF9MY6SHEU33cVQJfoZ4AkF13lUCXrW4ayuxN50pFOYO041LdfjLl6889QZSWnoXRr2wTNta4NbiIZe6iiR2SWmO4/uVUFh9CaLIeV5lLnUyZ+6qGCftPkSJ6IheBSE726S7u7HarwKzRjmNpREU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745697599; c=relaxed/simple;
	bh=TzEmWAzJLhRlvC2GfkBxcVxzqlomY+7M9h6HqY0KE9E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jMADaytX1mrvuUiqgiH587EFlIHV/zTgE5a5OuEve6Ttma/Lubi+MM1CjhqT6aAyrmSajEpTLS3EYaJCeRox5nbRGljom/RtGEJZPg64+dat+Au1eiWZme1lpfQBi9SZov9jmu/BGIy2lwTfpNdAwPcMBw5QcqXbt3+5P4epo4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fudcxCQw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CDCC4CEE2;
	Sat, 26 Apr 2025 19:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745697598;
	bh=TzEmWAzJLhRlvC2GfkBxcVxzqlomY+7M9h6HqY0KE9E=;
	h=Date:From:To:Cc:Subject:From;
	b=fudcxCQwzbO2wJ3OrI5CbvgZThqsfiE+81rRQIIprbazFKW0sF+Iq4Sgu9DB62R+Y
	 v4lU9R0p6kmvG2ODWTY/iQEeVytL5jjJYt5lbD3qwbnTKEu+hbJuuQJauVfxmn6L3H
	 XPmv6TFmRgg4xTb3yyv5ivDRHjazJSJdd7OHllRRGqauzxAi8BVPMV9/Kzo07r+quP
	 RdfwaKEulKL6cjZVXGUFeWnsmI5ViwvcUmwLu9v8Kve3Pj2Dk9XVP/fld0L7vudcpd
	 3ZbHokTYA2ONiyS0xjTFFCa3CDg8i7wD4L+4/aeWhZupnN/89f/duF4fpT7zIWdrZ1
	 l7skLD+LffHnA==
Date: Sat, 26 Apr 2025 14:59:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Yi Lai <yi1.lai@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Ondrej Jirman <megi@xff.cz>
Subject: [GIT PULL] PCI fixes for v6.15
Message-ID: <20250426195957.GA598020@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git pci-v6.15-fixes-3

for you to fetch changes up to 442cacac2d9935a0698332a568afcb5c6ab8be17:

  misc: pci_endpoint_test: Defer IRQ allocation until ioctl(PCITEST_SET_IRQTYPE) (2025-04-23 17:04:48 -0500)

----------------------------------------------------------------

- When releasing a start-aligned resource, e.g., a bridge window, save
  start/end/flags for the next assignment attempt; fixes a v6.15-rc1
  regression (Ilpo Järvinen)

- Move set_pcie_speed.sh from TEST_PROGS to TEST_FILE; fixes a bwctrl
  selftest v6.15-rc1 regression (Ilpo Järvinen)

- Add Manivannan Sadhasivam as maintainer of native host bridge and
  endpoint drivers (Manivannan Sadhasivam)

- In endpoint test driver, defer IRQ allocation from .probe() until ioctl()
  to fix a regression on platforms where the Vendor/Device ID match doesn't
  include driver_data (Niklas Cassel)

----------------------------------------------------------------
Ilpo Järvinen (2):
      PCI: Restore assigned resources fully after release
      selftests/pcie_bwctrl: Fix test progs list

Manivannan Sadhasivam (1):
      MAINTAINERS: Move Manivannan Sadhasivam as PCI Native host bridge and endpoint maintainer

Niklas Cassel (1):
      misc: pci_endpoint_test: Defer IRQ allocation until ioctl(PCITEST_SET_IRQTYPE)

 MAINTAINERS                                  |  2 +-
 drivers/misc/pci_endpoint_test.c             | 21 +--------------------
 drivers/pci/setup-bus.c                      |  4 ++++
 tools/testing/selftests/pcie_bwctrl/Makefile |  3 ++-
 4 files changed, 8 insertions(+), 22 deletions(-)

