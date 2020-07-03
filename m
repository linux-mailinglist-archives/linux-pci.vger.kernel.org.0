Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390B4213D34
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jul 2020 18:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgGCQE6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jul 2020 12:04:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbgGCQE5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Jul 2020 12:04:57 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09D562070B;
        Fri,  3 Jul 2020 16:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593792297;
        bh=c67lgcr6W0rJufCTOEq2LHdlNbpMkL0Nj0X3N2/dCSQ=;
        h=Date:From:To:Cc:Subject:From;
        b=zNPd6yOaND5Pk31qJuH+TacHc1JzakAEje7UybMhj8v6woYdb90194BQWanQ4nZBO
         q46SVN/DNbrP/N9UUkJSxJfXWz40oSR86cDui6xVwYnAcYQETrQdNMug9d12t5hbmZ
         5+4u0iuKIqH+orCqVMfX0GUCyRjatXADO7vXFh4A=
Date:   Fri, 3 Jul 2020 11:04:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>
Subject: [GIT PULL] PCI fixes for v5.8
Message-ID: <20200703160455.GA3899841@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI fixes:

  - Fix a pcie_find_root_port() simplification that broke power management
    because it didn't handle the edge case of finding the Root Port of a
    Root Port itself (Mika Westerberg)


The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v5.8-fixes-1

for you to fetch changes up to 5396956cc7c6874180c9bfc1ceceb02b739a6a87:

  PCI: Make pcie_find_root_port() work for Root Ports (2020-06-30 16:58:27 -0500)

----------------------------------------------------------------
pci-v5.8-fixes-1

----------------------------------------------------------------
Mika Westerberg (1):
      PCI: Make pcie_find_root_port() work for Root Ports

 include/linux/pci.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)
