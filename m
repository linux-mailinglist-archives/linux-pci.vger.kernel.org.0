Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70696E9D26
	for <lists+linux-pci@lfdr.de>; Thu, 20 Apr 2023 22:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjDTU2B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 16:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbjDTU1p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 16:27:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADF33A8E;
        Thu, 20 Apr 2023 13:27:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E280F64BBB;
        Thu, 20 Apr 2023 20:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1607BC4339B;
        Thu, 20 Apr 2023 20:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682022454;
        bh=cph4jY4sNf3bdO6jFfmDqQd5XkvrtKpUasG+G/EXRBA=;
        h=Date:From:To:Cc:Subject:From;
        b=kRRaKYUGeVj6HNsF9JdXDvoy5RNm8Tm1AnuCsNbsJX2EsoX0mbaxFsQBoSdwUO7D/
         t9CsxVVd8Pd2cSsR7Vsbt8VgGtI2D7d0/2CcJeCzhuSmAfY5JHOG90agI67BJ5cDD0
         jYTwxVjxFsQ9KP13z4FLd3rSK0oVewSlpzTCspGCWIw6TeIrkS6V7ICEfyeS2/Wnlc
         o5ibvpal0B4OlsXhlNpIBWPOjG+ecvXtefjS8j+qYVcO3yVjoYqmKLFMNnPGfcBO/n
         OZgmIXQD08POLhNtwblVgqb91uidKGTPadCI7zgmr77nIyMQYaQYb6ASUjWRxqxuAL
         h9nKdWL8Gauzw==
Date:   Thu, 20 Apr 2023 15:27:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Donald Hunter <donald.hunter@gmail.com>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [GIT PULL] PCI fixes for v6.3
Message-ID: <20230420202732.GA322005@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.3-fixes-3

for you to fetch changes up to 0d21e71a91debc87e88437a2cf9c6f34f8bf012f:

  PCI: Restrict device disabled status check to DT (2023-04-20 13:30:14 -0500)

This has only been in -next one day, but it fixes an important regression.
It appeared in next-20230420 as a0814a0e8b5b, and I subsequently edited the
commit log to add testing reports from Donald and Vitaly.

----------------------------------------------------------------
- Previously we ignored PCI devices if the DT "status" property or the ACPI
  _STA method said it was not present.  Per spec, _STA cannot be used for
  that purpose, and using it that way caused regressions, so skip the _STA
  check (Rob Herring)

----------------------------------------------------------------
Rob Herring (1):
      PCI: Restrict device disabled status check to DT

 drivers/pci/of.c    | 30 ++++++++++++++++++++++++------
 drivers/pci/pci.h   |  4 ++--
 drivers/pci/probe.c |  8 ++++----
 3 files changed, 30 insertions(+), 12 deletions(-)
