Return-Path: <linux-pci+bounces-1634-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 419EB823790
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 23:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413FD1C245CF
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 22:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C75A1DA26;
	Wed,  3 Jan 2024 22:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9olP2E3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE7F1EB24;
	Wed,  3 Jan 2024 22:13:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C224C433C7;
	Wed,  3 Jan 2024 22:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704320017;
	bh=V7DVqz33iZVLnVsQtvtvNxjFPOP/crTz1Uh3hrjDO9k=;
	h=Date:From:To:Cc:Subject:From;
	b=c9olP2E3k0C9trWd988eMBR+lQRNq7Pnh2r8sJONOjTxb1uls/DYwJr2nQbgKUvgI
	 GdFfPXFS1WOc0LsYKUCic89oJwTcriSK/eJwMqw8e1F5WUMMp+liTRdELl+DvmiSGI
	 rxFslI8QGMoGBA9TlPkPeDf6OtObKSEZEmYswwo6ejPonEUhMaO2fLY4HcMJbeN15l
	 WG96BMNsz74tIEI+xbTkbPXEjEypnLEsZtu1UylndLU95wZ+OkA4FiuDczAjHjoecl
	 az9OIzQj0N7WNidxi3Dyjn6ASGR3TGLdftE2hrA5jdo++tWcbX1ytCNSxX/o8TDGfF
	 C5u2l7R46m0cg==
Date: Wed, 3 Jan 2024 16:13:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Tom Joseph <tjoseph@cadence.com>,
	Michael Schaller <michael@5challer.de>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [GIT PULL] PCI fixes for v6.7
Message-ID: <20240103221335.GA1797305@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.7-fixes-2

for you to fetch changes up to 0ee2030af4e3e0a9cd26dfaa8c2f935beffa91d1:

  MAINTAINERS: Orphan Cadence PCIe IP (2024-01-02 17:29:38 -0600)

----------------------------------------------------------------
- Revert an ASPM patch that caused an unintended reboot when resuming
  after suspend (Bjorn Helgaas)

- Orphan Cadence PCIe IP (Bjorn Helgaas)

----------------------------------------------------------------
Bjorn Helgaas (2):
      Revert "PCI/ASPM: Remove pcie_aspm_pm_state_change()"
      MAINTAINERS: Orphan Cadence PCIe IP

 CREDITS                 |  4 ++++
 MAINTAINERS             |  5 ++---
 drivers/pci/pci.c       |  6 ++++++
 drivers/pci/pci.h       |  2 ++
 drivers/pci/pcie/aspm.c | 19 +++++++++++++++++++
 5 files changed, 33 insertions(+), 3 deletions(-)

