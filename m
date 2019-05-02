Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFF6211A8F
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2019 15:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfEBNzl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 May 2019 09:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfEBNzk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 May 2019 09:55:40 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEA572063F;
        Thu,  2 May 2019 13:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556805340;
        bh=BJOpwYueOcMmsggx8Fs2FsoWiOkdNNNmyLmNM6egwks=;
        h=Date:From:To:Cc:Subject:From;
        b=yzPXz2+vCTN0geh39VSe/WuBNMOq1IwugOctsJXAf0lKMKsQghfE66XQDFTf79gcm
         NL1DSUuFg6hCmbgP67kzc97xQeQBA+SqDYu+dUQ0Seny19h67di6UymCeOeX5ZPprK
         +EFohsCtQ6e3b/emE61Xm0/TEBG2b+tALVHkEBiA=
Date:   Thu, 2 May 2019 08:55:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <alex.gagniuc@dellteam.com>,
        Lukas Wunner <lukas@wunner.de>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: [GIT PULL] PCI fixes for v5.1
Message-ID: <20190502135538.GB11579@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus,

I apologize for sending these so late in the cycle.  We went back and forth
about how to deal with the unexpected logging of intentional link state
changes and finally decided to just config them off by default.

PCI fixes:

  - Stop ignoring "pci=disable_acs_redir" parameter (Logan Gunthorpe)

  - Use shared MSI/MSI-X vector for Link Bandwidth Management (Alex
    Williamson)

  - Add Kconfig option for Link Bandwidth notification messages (Keith
    Busch)


The following changes since commit 3943af9d01e94330d0cfac6fccdbc829aad50c92:

  PCI: pciehp: Ignore Link State Changes after powering off a slot (2019-04-10 16:06:43 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.1-fixes-3

for you to fetch changes up to 2078e1e7f7e0e21bd0291908f3037c39e666d27b:

  PCI/LINK: Add Kconfig option (default off) (2019-05-02 08:34:32 -0500)

----------------------------------------------------------------
pci-v5.1-fixes-3

----------------------------------------------------------------
Alex Williamson (1):
      PCI/portdrv: Use shared MSI/MSI-X vector for Bandwidth Management

Keith Busch (1):
      PCI/LINK: Add Kconfig option (default off)

Logan Gunthorpe (1):
      PCI: Fix issue with "pci=disable_acs_redir" parameter being ignored

 drivers/pci/pci.c               | 19 +++++++++++++++++--
 drivers/pci/pcie/Kconfig        |  8 ++++++++
 drivers/pci/pcie/Makefile       |  2 +-
 drivers/pci/pcie/portdrv.h      |  4 ++++
 drivers/pci/pcie/portdrv_core.c |  3 ++-
 5 files changed, 32 insertions(+), 4 deletions(-)
