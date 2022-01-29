Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2601B4A3074
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jan 2022 17:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243570AbiA2QPv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Jan 2022 11:15:51 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48234 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243532AbiA2QPu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Jan 2022 11:15:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DD2260B8E;
        Sat, 29 Jan 2022 16:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E347C340E5;
        Sat, 29 Jan 2022 16:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643472949;
        bh=eNcKutvg7at4+y7aT8bzCB1OBz/CjF6juy0X80i8Z+E=;
        h=Date:From:To:Cc:Subject:From;
        b=bygIkpJVY4RrGp1UWzYSCdLPpb50HPCXn+0NojYVgP0Zllj5oPr0RyBFTB81tnwQE
         B286PAqVm6Gzrvpmi+Kikafjoc49ZJODZecasOKzrYFeh6GILrrz0Y12t2FDr0B+0l
         wteFm/leu4vNBETBqQdNIl6/f3DRUZy6HR1S6QJDsfPn8kw9parXKjd2BpVEwQ8p+h
         GaL3dCxIkut0u136T0PJG2/mkPLnvyjU182DykDe0pHEOxM4bBiK0vvO37/67nxUpb
         PhE9SWFu7VRUG1c0Q3iIe6k7PGuB/XrJWu5vwgKdgLjo5MSEotWDUjqT2MCcMmWfKd
         wjeYJT4utrJew==
Date:   Sat, 29 Jan 2022 10:15:47 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: [GIT PULL] PCI fixes for v5.17
Message-ID: <20220129161547.GA352890@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.17-fixes-2

for you to fetch changes up to 66d28b21fe6b3da8d1e9f0a7ba38bc61b6c547e1:

  PCI/sysfs: Find shadow ROM before static attribute initialization (2022-01-26 10:41:21 -0600)

----------------------------------------------------------------
PCI fixes:

  - Fix compilation warnings in new mt7621 driver (Sergio Paracuellos)

  - Restore the sysfs "rom" file for VGA shadow ROMs, which was broken when
    converting "rom" to be a static attribute (Bjorn Helgaas)

----------------------------------------------------------------
Bjorn Helgaas (1):
      PCI/sysfs: Find shadow ROM before static attribute initialization

Sergio Paracuellos (2):
      PCI: mt7621: Drop of_match_ptr() to avoid unused variable
      PCI: mt7621: Remove unused function pcie_rmw()

 arch/ia64/pci/fixup.c                |  4 ++--
 arch/mips/loongson64/vbios_quirk.c   |  9 ++++-----
 arch/x86/pci/fixup.c                 |  4 ++--
 drivers/pci/controller/pcie-mt7621.c | 11 +----------
 4 files changed, 9 insertions(+), 19 deletions(-)
