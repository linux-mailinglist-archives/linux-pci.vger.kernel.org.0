Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068374B2E9C
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 21:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbiBKUkL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 15:40:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiBKUkL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 15:40:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8891DCF2;
        Fri, 11 Feb 2022 12:40:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28B9C62023;
        Fri, 11 Feb 2022 20:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE96C340E9;
        Fri, 11 Feb 2022 20:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644612007;
        bh=9aqXxRdl3vqUo5edo6YqbhV9C3gHFRDD/8/RSNbjZtA=;
        h=Date:From:To:Cc:Subject:From;
        b=Z0wCmlUU+nVsUlIwGKvapnNMfsjmR+GPJU95OXDbzd22dsP+3VF9n6NWPf69XPStx
         UkdNpaQ82k37DQrY/JCfmq+ZN2vPDDN/Ce+hytk/qn+zy2Gp8WHuk0Izn9J5y32jqr
         zAaUGwJD+Lh6+yJAFc8CaMCaXE1iADSx0Cb7mOg+TYC4TdhwNEr25kiQuK+Dr+a0a5
         I6snrRGnywOJ2ZWgmUuC3sE9S4FxY9a+8ZX8oKUgkqczlLOQX0aOVVFhqjUl/0ixXd
         gfaxSTpmEdZ40ea3qWJ+HNM0eFEUIpyWI3ez5hv98v4C30BmyQWi4wHXGVXFfl34kw
         h+G8Kq2C41V+Q==
Date:   Fri, 11 Feb 2022 14:40:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joey Corleone <joey.corleone@mail.ru>,
        Sergiu Deitsch <sergiu.deitsch@gmail.com>,
        David Spencer <dspencer577@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: [GIT PULL] PCI fixes for v5.17
Message-ID: <20220211204005.GA732009@bhelgaas>
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

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.17-fixes-4

for you to fetch changes up to 075b7d363c675ef7fa03918881caeca3458e2a96:

  Revert "PCI/portdrv: Do not setup up IRQs if there are no users" (2022-02-11 14:16:11 -0600)

N.B. This has been in linux-next for a couple days as b139e2632409
("Revert "PCI/portdrv: Do not setup up IRQs if there are no users""),
but I amended that commit to add more info to the commit log.

----------------------------------------------------------------
PCI fixes:

  - Revert a commit that reduced the number of IRQs used but resulted in
    interrupt storms (Bjorn Helgaas)

----------------------------------------------------------------
Bjorn Helgaas (1):
      Revert "PCI/portdrv: Do not setup up IRQs if there are no users"

 drivers/pci/pcie/portdrv_core.c | 47 +++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 30 deletions(-)
