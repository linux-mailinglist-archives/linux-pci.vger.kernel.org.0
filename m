Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CE566A1DC
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 19:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjAMSWX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 13:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjAMSWD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 13:22:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D302089BFA;
        Fri, 13 Jan 2023 10:15:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E4B0622C4;
        Fri, 13 Jan 2023 18:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29332C433D2;
        Fri, 13 Jan 2023 18:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673633711;
        bh=OsGopyeciE8h+GGsVxcgtzDFCThmwT2aXDpAwo00A48=;
        h=Date:From:To:Cc:Subject:From;
        b=Qq9UxIDlwLFExjXAtKFbvt1nhRr/dU/mkFqq36gBbUWIa+h/lIkkZhz/2EoiwJVl5
         h9HMEWxY5J6vB2EDMFEH7j1675+oORbVDpn0M4f1LnEzlr1mZiVSFGhGT8jXowS3gF
         qfwxcGVLyxiDf69b260Xhk7tUdLd7ZyMG/rWkoe/Zh5/ue9K5qv0+ELT+rATRRXOLI
         ZEko2RMRhUiNmQ8JLJyFOZToUqiG02lbbrDCB1nEen5KTWNmro214lgfApGYHzm8v0
         ++u6qa+5JJqWUnr/BgSX/9uawgAU9bU9TxYj2Xy4S/vz5NPb7JJAYTZixHZKzI0qxa
         2tRI4FNHs7Xzg==
Date:   Fri, 13 Jan 2023 12:15:09 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Yunying Sun <yunying.sun@intel.com>,
        Baowen Zheng <baowen.zheng@corigine.com>,
        Zhenzhong Duan <zhenzhong.duan@intel.com>,
        Yang Lixiao <lixiao.yang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] PCI fixes for v6.2
Message-ID: <20230113181509.GA1852362@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v6.2-fixes-1

for you to fetch changes up to fd3a8cff4d4a4acb0af49dd947c822717c053cf7:

  x86/pci: Treat EfiMemoryMappedIO as reservation of ECAM space (2023-01-13 11:53:54 -0600)

----------------------------------------------------------------
- Work around apparent firmware issue that made Linux reject MMCONFIG
  space, which broke PCI extended config space (Bjorn Helgaas)

- Fix CONFIG_PCIE_BT1 dependency due to mid-air collision between a
  PCI_MSI_IRQ_DOMAIN -> PCI_MSI change and addition of PCIE_BT1 (Lukas
  Bulwahn)

----------------------------------------------------------------
Bjorn Helgaas (2):
      x86/pci: Simplify is_mmconf_reserved() messages
      x86/pci: Treat EfiMemoryMappedIO as reservation of ECAM space

Lukas Bulwahn (1):
      PCI: dwc: Adjust to recent removal of PCI_MSI_IRQ_DOMAIN

 arch/x86/pci/mmconfig-shared.c     | 44 ++++++++++++++++++++++++++++++++------
 drivers/pci/controller/dwc/Kconfig |  2 +-
 2 files changed, 39 insertions(+), 7 deletions(-)
