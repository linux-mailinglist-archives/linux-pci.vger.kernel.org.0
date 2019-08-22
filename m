Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 952BF9A130
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 22:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404468AbfHVUcl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Aug 2019 16:32:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404465AbfHVUcl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Aug 2019 16:32:41 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 616B323401;
        Thu, 22 Aug 2019 20:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566505960;
        bh=691IKZXOs5bNgX1Cw9v441siqH85puO0/NA5EVFiPrI=;
        h=Date:From:To:Cc:Subject:From;
        b=KkTRXpJ+aOaCryBA6ibi6NK9bOproro2FpswK1C8wBCW4vU/Xc0TL2QTRko2m39VM
         YRujAJEZtvZcRWbdEqHkJ00DDLjQs+FBiVaF01uogEIQtrxzjIQ9v6uz5u4tseIbE+
         fzQvqB0hnHOz8CBXgFjny5uHEvDX9dTbkD9L1ZXg=
Date:   Thu, 22 Aug 2019 15:32:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lyude Paul <lyude@redhat.com>
Subject: [GIT PULL] PCI fixes for v5.3
Message-ID: <20190822203239.GL14450@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI fixes:

  - Reset both NVIDIA GPU and HDA in ThinkPad P50 quirk, which was
    broken by another quirk that enabled the HDA device (Lyude Paul)

  - Fix pciebus-howto.rst documentation filename typo (Bjorn Helgaas)


The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.3-fixes-1

for you to fetch changes up to 7bafda88de20b2990461d253c5475007436e355c:

  Documentation PCI: Fix pciebus-howto.rst filename typo (2019-08-15 12:12:38 -0500)

----------------------------------------------------------------
pci-v5.3-fixes-1

----------------------------------------------------------------
Bjorn Helgaas (1):
      Documentation PCI: Fix pciebus-howto.rst filename typo

Lyude Paul (1):
      PCI: Reset both NVIDIA GPU and HDA in ThinkPad P50 workaround

 Documentation/PCI/index.rst                                | 2 +-
 Documentation/PCI/{picebus-howto.rst => pciebus-howto.rst} | 0
 drivers/pci/quirks.c                                       | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/PCI/{picebus-howto.rst => pciebus-howto.rst} (100%)
