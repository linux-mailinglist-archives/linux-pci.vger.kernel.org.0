Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C6054FE11
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jun 2022 22:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbiFQUBu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 16:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbiFQUBs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 16:01:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61435AA74;
        Fri, 17 Jun 2022 13:01:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3BF2FCE2D1F;
        Fri, 17 Jun 2022 20:01:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9591C3411B;
        Fri, 17 Jun 2022 20:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655496104;
        bh=Vi0au6x78VPMQHv+kMtP+MqnRDTXskeTv0zK+FIqE/g=;
        h=Date:From:To:Cc:Subject:From;
        b=nyL9OlfNv2fOjPeaXgh8RBjfMn+GlXVte4UedL9erRQKPeJslvEXwUUNyhcuOrJCr
         zodSnoefBKC8RbVcCJ1jAlrQxMXJePQcUtBkB2oLg67THqbctK61OKbPwMxf5QW7Ed
         yXMqW9AP2XF/n8lstbARHdoXiAKLcjeKU0QHevfZkL9WgPEX/nv73wntgLQevvYa3s
         Sc84+sc2YCadoSWGrV8Zni+voNzm29lgafi2TkZeQkH9kawyFIzK5TspsWqMTS9eQQ
         kgqd3Q6BYmT0AVXaoriYiGfOuKjuO0bct1bBymqb6UMxpfT9hFEnSllK0+EuNiU6i+
         LOXVRrnYHAD/w==
Date:   Fri, 17 Jun 2022 15:01:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: [GIT PULL] PCI fixes for v5.19
Message-ID: <20220617200141.GA1202513@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.19-fixes-2

for you to fetch changes up to a2b36ffbf5b6ec301e61249c8b09e610bc80772f:

  x86/PCI: Revert "x86/PCI: Clip only host bridge windows for E820 regions" (2022-06-17 14:24:14 -0500)

I rebased this to add more reporters and testers.  The patch itself
appeared in next-20220617.

----------------------------------------------------------------
PCI fixes:

  - Revert clipping of PCI host bridge windows to avoid E820 regions, which
    broke several machines by forcing unnecessary BAR reassignments (Hans
    de Goede)

----------------------------------------------------------------
Hans de Goede (1):
      x86/PCI: Revert "x86/PCI: Clip only host bridge windows for E820 regions"

 arch/x86/include/asm/e820/api.h |  5 -----
 arch/x86/include/asm/pci_x86.h  |  8 ++++++++
 arch/x86/kernel/resource.c      | 14 +++++++++-----
 arch/x86/pci/acpi.c             |  8 +-------
 4 files changed, 18 insertions(+), 17 deletions(-)
