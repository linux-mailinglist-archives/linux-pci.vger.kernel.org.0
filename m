Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED69281BE4
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 21:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388504AbgJBTXm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 15:23:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388419AbgJBTXm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Oct 2020 15:23:42 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83B18206DB;
        Fri,  2 Oct 2020 19:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601666621;
        bh=pYhhz+UueBHB3YsRZz5MWsBWxMANxmmfXeJqqXTkOaI=;
        h=Date:From:To:Cc:Subject:From;
        b=r44fK/oB+rH6SHGmt0tef5OPMbmugQ+BZ8rb25KDnMvzFG8JaIoZdT4iwaHtQmDaG
         TQFJ0bZyCPCgcpGDw9Kmcr41p6TefMyWvZkF8QOFBXFl08NWgb0D+BKAhIHW/2ElHt
         gDlxm2AO+aeQ3VH2Aml7eH/Ut12wU8+FQ3fJ9ems=
Date:   Fri, 2 Oct 2020 14:23:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: [GIT PULL] PCI fixes for v5.9
Message-ID: <20201002192340.GA2820115@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI fixes:

  - Fix rockchip regression in rockchip_pcie_valid_device() (Lorenzo
    Pieralisi)

  - Add Pali Rohár as aardvark PCI maintainer (Pali Rohár)


The following changes since commit 7c2308f79fc81ba0bf24ccd2429fb483a91bcd51:

  PCI/P2PDMA: Fix build without DMA ops (2020-08-17 17:08:21 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.9-fixes-2

for you to fetch changes up to 76a6b0b90d532ed9bb9f6069aa12859c185e5b99:

  MAINTAINERS: Add Pali Rohár as aardvark PCI maintainer (2020-09-30 16:51:14 -0500)

----------------------------------------------------------------
pci-v5.9-fixes-2

----------------------------------------------------------------
Lorenzo Pieralisi (1):
      PCI: rockchip: Fix bus checks in rockchip_pcie_valid_device()

Pali Rohár (1):
      MAINTAINERS: Add Pali Rohár as aardvark PCI maintainer

 MAINTAINERS                                 |  1 +
 drivers/pci/controller/pcie-rockchip-host.c | 11 ++++-------
 2 files changed, 5 insertions(+), 7 deletions(-)
