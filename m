Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC5D5FFAFE
	for <lists+linux-pci@lfdr.de>; Sat, 15 Oct 2022 17:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJOP1p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 Oct 2022 11:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJOP1n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 Oct 2022 11:27:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984D63471F;
        Sat, 15 Oct 2022 08:27:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 811B4B8076B;
        Sat, 15 Oct 2022 15:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BB0C433D6;
        Sat, 15 Oct 2022 15:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665847658;
        bh=LjflNxGf7oZ5ML6azYmoPdLj/IgEioxaCcvyPF5qpbI=;
        h=Date:From:To:Cc:Subject:From;
        b=gWZ217cSWYBBIBbC7/wgyMyQ2lq+LAcPitPlY6gtwayw9IikLNyH/4Nm+UjYhDLmJ
         Dxz1QutX5L4amrEHu1kCQ+EIk89dUvT9pqhkn/s8mNrBxcUg47e/4m8hGRLmcqoZp7
         ScLu5Q4rKvW+TCdf/XW2/hkGf2ImbUpTFVOG9Tqf89rduxixDf4RKpcssuTY5tFhx2
         CI7eCjGQLO/5TCor8NWrBaZX+v43yphJHf5Abnm7w0UcgB7zu4lDk9lX1GUegHJoFZ
         RCESO4vX8yBt/lToRJFT48jguep/Wd39S/JBlwRtQaFEGKujajYrcDjLrg8uH0jHn5
         MCgBYb4dZMkZQ==
Date:   Sat, 15 Oct 2022 10:27:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com
Subject: [GIT PULL] PCI fixes for v6.1
Message-ID: <20221015152736.GA3574429@bhelgaas>
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

The following changes since commit 041bc24d867a2a577a06534d6d25e500b24a01ef:

  Merge tag 'pci-v6.1-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci (2022-10-11 11:08:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v6.1-fixes-1

for you to fetch changes up to 5632e2beaf9d5dda694c0572684dea783d8a9492:

  Revert "PCI: Distribute available resources for root buses, too" (2022-10-14 14:27:58 -0500)

----------------------------------------------------------------

- Revert the attempt to distribute spare resources to unconfigured hotplug
  bridges at boot time.  This fixed some dock hot-add scenarios, but
  Jonathan Cameron reported that it broke a topology with a multi-function
  device where one function was a Switch Upstream Port and the other was an
  Endpoint.

----------------------------------------------------------------
Bjorn Helgaas (1):
      Revert "PCI: Distribute available resources for root buses, too"

 drivers/pci/setup-bus.c | 62 +------------------------------------------------
 1 file changed, 1 insertion(+), 61 deletions(-)
