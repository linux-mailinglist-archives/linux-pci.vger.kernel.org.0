Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB21C6080A0
	for <lists+linux-pci@lfdr.de>; Fri, 21 Oct 2022 23:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiJUVSE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Oct 2022 17:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiJUVSD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Oct 2022 17:18:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528682A58F7;
        Fri, 21 Oct 2022 14:18:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5B7B61F91;
        Fri, 21 Oct 2022 21:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B6CC433D7;
        Fri, 21 Oct 2022 21:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666387079;
        bh=X3QBcuI37BQ4d8SwtwNzmbOu2UpYy1SwK/HHZkEUWTA=;
        h=Date:From:To:Cc:Subject:From;
        b=c2L5w4KXlrSq8NTkmqSRO9cX9P3+6mv07TNqDe0netT9GebfoX1ndSsRMB8LrmCu2
         gtdhez8foN/UnqU7gGSwyjK20durtYmX72T0R6eK5y4Qc5dRaeICAqNvHcW3PGwuJH
         7UiiR5zI9V7flAoB+FC8I26EEKTQ0Ns1KmGf4rT3v62vPcjG0P8wfUcXuUSe8E5lGh
         kYNipmZE3TIXYvp0+CkIIW63eA55moE03mfM/BtOjfDbJkZnLKLSVIStu1v/JIQDVl
         fAhsmTMto4tgQ+7HvUolGRvzo3pOSKlUj337cs8U5gr48BfZlILxm+gbrfxFk+ZmLC
         WtqgDnpE0KODw==
Date:   Fri, 21 Oct 2022 16:17:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: [GIT PULL] PCI fixes for v6.1
Message-ID: <20221021211757.GA311020@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v6.1-fixes-2

for you to fetch changes up to e6aa4edd2f5b07fdc41de287876dd98c6e44322b:

  MAINTAINERS: Update Kishon's email address in PCI endpoint subsystem (2022-10-19 16:46:23 -0500)

----------------------------------------------------------------

- Revert a simplification that broke pci-tegra due to a masking error.

- Update MAINTAINERS for Kishon's email address change and TI
  DRA7XX/J721E maintainer change.

----------------------------------------------------------------
Jon Hunter (1):
      Revert "PCI: tegra: Use PCI_CONF1_EXT_ADDRESS() macro"

Kishon Vijay Abraham I (2):
      MAINTAINERS: Add Vignesh Raghavendra as maintainer of TI DRA7XX/J721E PCI driver
      MAINTAINERS: Update Kishon's email address in PCI endpoint subsystem

 MAINTAINERS                        |  4 ++--
 drivers/pci/controller/pci-tegra.c | 11 ++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)
