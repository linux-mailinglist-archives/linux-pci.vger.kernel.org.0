Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F913C2C05
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jul 2021 02:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhGJAZb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jul 2021 20:25:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229854AbhGJAZb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Jul 2021 20:25:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9131B613C5;
        Sat, 10 Jul 2021 00:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625876566;
        bh=twV0s5fvSE7IUuMhVn1kd9rjGDN52nK26wZqofDxqvM=;
        h=Date:From:To:Cc:Subject:From;
        b=r9pOrXLu65AyG0ErQDbxA26gdIzlgBIMKmF5Iw3eMjtoYJlCcqdjQ5DBPK1gQqCzH
         ud/Maz6KeMIOx5RxCZcisNYQK3hayBoAQIn+k/lPPcf3nMfYFiKZviDdtqBHvebQq2
         C6f76C9HyyO4xpj/lHXHypur22a8f0r5T1eMm+rRA8VOKpugxUb/rky3W7r+UM8nOC
         qEtYEYGVOYUokgaAxp5YGDj8Koc90ZJqrtEAJkHaKb3rkQ/cZhEMAKdgwDoNICvsg0
         59c+HRGnzruoKbB1lNLdBMEDbtsSLnd8fpzVklQ6ohM05fQg3Xk/4oNV0QQr+Q6yve
         Er6W/Qhr06ijg==
Date:   Fri, 9 Jul 2021 19:22:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [GIT PULL] PCI fixes for v5.14
Message-ID: <20210710002245.GA1190136@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit 50be9417e23af5a8ac860d998e1e3f06b8fd79d7:

  Merge tag 'io_uring-5.14-2021-07-09' of git://git.kernel.dk/linux-block (2021-07-09 12:17:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.14-fixes-1

for you to fetch changes up to 62efe3eebc8bfc351961eee769a5c2fc30221451:

  Revert "PCI: Coalesce host bridge contiguous apertures" (2021-07-09 18:51:46 -0500)


This is a clean revert for a regression that was just reported, so it
hasn't been through linux-next yet, but I'd like to merge this before -rc1
so we don't release it with a known regression.

----------------------------------------------------------------

PCI fixes:

  - Revert host bridge window patch that fixed HP EliteDesk 805 G6, but
    broke ppc:sam460ex (Bjorn Helgaas)

----------------------------------------------------------------
Bjorn Helgaas (1):
      Revert "PCI: Coalesce host bridge contiguous apertures"

 drivers/pci/probe.c | 52 +++++-----------------------------------------------
 1 file changed, 5 insertions(+), 47 deletions(-)
