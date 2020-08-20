Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7E824C6DB
	for <lists+linux-pci@lfdr.de>; Thu, 20 Aug 2020 22:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgHTUug (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 16:50:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728478AbgHTUug (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Aug 2020 16:50:36 -0400
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8CE7207DE;
        Thu, 20 Aug 2020 20:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597956636;
        bh=0t9a+4F/Bg+qTJDxLWCFbW9cUmpYpdDXFexzODX4QgA=;
        h=Date:From:To:Cc:Subject:From;
        b=xb60YnFZNvIeFT/uJqRndl4BNUzibD7lzSvPuM+IrH+3dlIohlVWTDucSunV+Og7q
         urfIIgZsJyjqHwZu56hwIeyNqTw2xUvwYuJzd4jGNaAguSPCtqteYqqEuerE2VnMmo
         1J+XIIO5oLAJutG54OE6G9QgeCgni3RFh/ce83f4=
Date:   Thu, 20 Aug 2020 15:50:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: [GIT PULL] PCI fixes for v5.9
Message-ID: <20200820205034.GA1565627@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI fixes:

  - Fix P2PDMA build issue (Christoph Hellwig)


The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.9-fixes-1

for you to fetch changes up to 7c2308f79fc81ba0bf24ccd2429fb483a91bcd51:

  PCI/P2PDMA: Fix build without DMA ops (2020-08-17 17:08:21 -0500)

----------------------------------------------------------------
pci-v5.9-fixes-1

----------------------------------------------------------------
Christoph Hellwig (1):
      PCI/P2PDMA: Fix build without DMA ops

 drivers/pci/p2pdma.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)
