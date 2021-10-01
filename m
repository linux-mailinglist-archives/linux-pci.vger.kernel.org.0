Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F1441F5FF
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 21:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239579AbhJAUAp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 16:00:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229916AbhJAUAp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Oct 2021 16:00:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B29B619EE;
        Fri,  1 Oct 2021 19:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633118340;
        bh=LfTHafmaVMrpC77c8tV93teqbpWLR4gP0woQonzpYI8=;
        h=From:To:Cc:Subject:Date:From;
        b=RuUrmCqvCS+nJB186zvayHJ4zBMrgg8itiKaws7jXFhXUNOuOnnpErWq1woa4Yn51
         fYIkVGY2qvQ472VhCMfp3peUwDYRbP0F2J2+aFlngtZG4PZHk1NmyxUd4vLcYODJKm
         tv/UNkb1WRJuU/f4NxVN9l6aMCjzPTeOw6gTQA9Lwa45pnNATN53EfM0dJ5DjuRb72
         Yqb6F7N7guW3C925caYmAadJvYqggoYG5nU80jWAwD63niZ2nTIGNfxs5dh32ApBRe
         1SN/5fQ/cHfIzrK8QMoxh/YEx3POwzYC7ui5pnizFZTtiOexHTOB8OTTG/0oNQQXzO
         +7gmk8wdDmp8g==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 00/13] PCI: aardvark controller fixes
Date:   Fri,  1 Oct 2021 21:58:43 +0200
Message-Id: <20211001195856.10081-1-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

this series fixes some issues with the Aardvark PCIe controller driver.

Most of them are small changes. Patch 11 has a rather long commit message
since it explains how the bugs were introduced from multiple misleading
names and comments of some registers.

We have another 56 fixes for aardvark, but last time nobody wanted to
review such a large series, so we are now trying in smaller batches.

It would be great if you could find time to review, since we would like
this to land in 5.16. Preferably we would like to send another batch for
5.16, but we will see how fast this one goes

Marek & Pali

Marek Behún (2):
  PCI: aardvark: Don't spam about PIO Response Status
  PCI: aardvark: Deduplicate code in advk_pcie_rd_conf()

Pali Rohár (11):
  PCI: Add PCI_EXP_DEVCTL_PAYLOAD_* macros
  PCI: aardvark: Fix PCIe Max Payload Size setting
  PCI: aardvark: Fix preserving PCI_EXP_RTCTL_CRSSVE flag on emulated
    bridge
  PCI: aardvark: Fix configuring Reference clock
  PCI: aardvark: Do not clear status bits of masked interrupts
  PCI: aardvark: Do not unmask unused interrupts
  PCI: aardvark: Implement re-issuing config requests on CRS response
  PCI: aardvark: Simplify initialization of rootcap on virtual bridge
  PCI: aardvark: Fix link training
  PCI: aardvark: Fix checking for link up via LTSSM state
  PCI: aardvark: Fix reporting Data Link Layer Link Active

 drivers/pci/controller/pci-aardvark.c | 364 +++++++++++++++-----------
 include/uapi/linux/pci_regs.h         |   6 +
 2 files changed, 212 insertions(+), 158 deletions(-)

-- 
2.32.0

