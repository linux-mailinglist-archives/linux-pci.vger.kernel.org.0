Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36B722D330
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jul 2020 02:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgGYARz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 20:17:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbgGYARz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Jul 2020 20:17:55 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61B3D2067D;
        Sat, 25 Jul 2020 00:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595636274;
        bh=9co2wgVkURI0AonSalg0IZ+9cb8RSmUqjIqt87z6XpA=;
        h=Date:From:To:Cc:Subject:From;
        b=JkgxuI4ftS3B7xcyUSVRlZxFf1X82QLan3uyRcaVVZVctZAbDnuoNLGQSFOKZnIOK
         YgfhqBw1A39p/F1qnorIP9Rcwvjk97a+iejgnuISB/FSPSO62LytMmxOS0XY9ppo9G
         egdQ/5AtlvDAPBxN9mgOIJfk2i71p9EuQotpGyFs=
Date:   Fri, 24 Jul 2020 19:17:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Patrick Volkerding <volkerdi@gmail.com>,
        Karol Herbst <kherbst@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [GIT PULL] PCI fixes for v5.8
Message-ID: <20200725001753.GA1556558@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI fixes:

  - Reject invalid IRQ 0 command line argument for virtio_mmio because
    IRQ 0 now generates warnings (Bjorn Helgaas)

  - Revert "PCI/PM: Assume ports without DLL Link Active train links
    in 100 ms", which broke nouveau (Bjorn Helgaas)


The following changes since commit 5396956cc7c6874180c9bfc1ceceb02b739a6a87:

  PCI: Make pcie_find_root_port() work for Root Ports (2020-06-30 16:58:27 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.8-fixes-2

for you to fetch changes up to d08c30d7a0d1826f771f16cde32bd86e48401791:

  Revert "PCI/PM: Assume ports without DLL Link Active train links in 100 ms" (2020-07-22 10:31:52 -0500)

----------------------------------------------------------------
pci-v5.8-fixes-2

----------------------------------------------------------------
Bjorn Helgaas (2):
      virtio-mmio: Reject invalid IRQ 0 command line argument
      Revert "PCI/PM: Assume ports without DLL Link Active train links in 100 ms"

 drivers/pci/pci.c            | 30 +++++++++---------------------
 drivers/virtio/virtio_mmio.c |  4 ++--
 2 files changed, 11 insertions(+), 23 deletions(-)
