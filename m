Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29868174031
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 20:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgB1TV4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 14:21:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:51808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgB1TV4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Feb 2020 14:21:56 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A7392469F;
        Fri, 28 Feb 2020 19:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582917715;
        bh=dC4jleGOY7CBKlY9hgX1iCewszSguWgeYcQ3QYeB9oI=;
        h=Date:From:To:Cc:Subject:From;
        b=UUZYbTtSXXjzp+X3J2X2Y3eilM0XgF1dOfH6BxKzCHUcz7Atq+DKiWsOBOkPvPakM
         wqG2nHAPokLGD+9NMBtjeHyLFRB61mPoTdpX6r+2fwlOuODy3+stzVsbySIEx1OcPA
         ++FUJ5JP7vczi34OUQ3k7r4D+pDvcb5mJg/wbZD0=
Date:   Fri, 28 Feb 2020 13:21:53 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [GIT PULL] PCI fixes for v5.6
Message-ID: <20200228192153.GA97492@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI fixes:

  - Fix build issue on 32-bit ARM with old compilers (Marek
    Szyprowski)

  - Update MAINTAINERS for recent Cadence driver file move (Lukas
    Bulwahn)


The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.6-fixes-2

for you to fetch changes up to 5901b51f3e5d9129da3e59b10cc76e4cc983e940:

  MAINTAINERS: Correct Cadence PCI driver path (2020-02-27 15:49:28 -0600)

----------------------------------------------------------------
pci-v5.6-fixes-2

----------------------------------------------------------------
Lukas Bulwahn (1):
      MAINTAINERS: Correct Cadence PCI driver path

Marek Szyprowski (1):
      PCI: brcmstb: Fix build on 32bit ARM platforms with older compilers

 MAINTAINERS                           | 2 +-
 drivers/pci/controller/pcie-brcmstb.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
