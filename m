Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DABF233893
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 20:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgG3SvZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jul 2020 14:51:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727945AbgG3SvZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Jul 2020 14:51:25 -0400
Received: from localhost (mobile-166-175-186-42.mycingular.net [166.175.186.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D16E720809;
        Thu, 30 Jul 2020 18:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596135085;
        bh=0Dwey7NDkJZ1hhCwPbhJPUyk5Ih3cyrd7g10AQ+z6bY=;
        h=Date:From:To:Cc:Subject:From;
        b=gVKIJqGSoAoTOAlAkHgEkK0HgCg2ZfwvlX4/nOz0YYN1qhNkH0SJwepJi5n7KtGLu
         3M0kiEsxaJtci7l/PCPWzba13cXq/eo2ofpCNgDNVWIS2iODjzYjqTDZWhEp+cl/9Y
         sKE1Y/iRI/3rLqpZTCHtTCEu0u5ddYIs2rxCow28=
Date:   Thu, 30 Jul 2020 13:51:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Hancock <hancockrwd@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [GIT PULL] PCI fixes for v5.8
Message-ID: <20200730185123.GA2057610@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI fixes:

  - Disable ASPM on ASM1083/1085 PCIe-to-PCI bridge (Robert Hancock)


The following changes since commit d08c30d7a0d1826f771f16cde32bd86e48401791:

  Revert "PCI/PM: Assume ports without DLL Link Active train links in 100 ms" (2020-07-22 10:31:52 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.8-fixes-3

for you to fetch changes up to b361663c5a40c8bc758b7f7f2239f7a192180e7c:

  PCI/ASPM: Disable ASPM on ASMedia ASM1083/1085 PCIe-to-PCI bridge (2020-07-29 18:35:45 -0500)

----------------------------------------------------------------
pci-v5.8-fixes-3

----------------------------------------------------------------
Robert Hancock (1):
      PCI/ASPM: Disable ASPM on ASMedia ASM1083/1085 PCIe-to-PCI bridge

 drivers/pci/quirks.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)
