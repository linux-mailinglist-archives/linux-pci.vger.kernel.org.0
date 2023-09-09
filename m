Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8447999A4
	for <lists+linux-pci@lfdr.de>; Sat,  9 Sep 2023 18:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjIIQZ2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Sep 2023 12:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238651AbjIIOor (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Sep 2023 10:44:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA2718E;
        Sat,  9 Sep 2023 07:44:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E23C433C8;
        Sat,  9 Sep 2023 14:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694270679;
        bh=DcYP9gXImssH6qVhHL9lB+FT1skacKc26mctiFmVKTM=;
        h=Date:From:To:Cc:Subject:From;
        b=HgsTSfTM5gW3/jjHSlv81oZAzCCB90EDzjvcVIt33gHUe3AXUTMHcYkPeQDswgTuJ
         QyOPLeC/g/qrxu8uAn4w2l7RBih2jxKrj7usknqWyU0H/MNm2Q3/z0KoSZ+UXV0jkk
         lL+S7xCfL2JRkP/w/UV8/dsZgvQQ4qn4BaXHd0G/JpMaIIOqCDGk/6rJEgm044cEoL
         qyJo1Rcrl3cU/AZNDoXMIhwmiEyqY+033yOK7UqCB4V+Hn7jwqtEJtiU24gsW6uoSQ
         7RIGjqqsCU/kwIqkcXe1DAHCl928zGCDHLmRoeREXbIpvlxQyajWsv0EAY5BK67cMI
         uG0mXwdY2Vitw==
Date:   Sat, 9 Sep 2023 09:44:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Wu Zongyong <wuzongyong@linux.alibaba.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Kalle Valo <kvalo@kernel.org>, Lizhi Hou <lizhi.hou@amd.com>,
        Guenter Roeck <groeck7@gmail.com>
Subject: [GIT PULL] PCI changes for v6.6
Message-ID: <20230909144437.GA326030@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit b6f6167ea8a424d14b41c172fe7a5f49e164f221:

  Merge tag 'pci-v6.6-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci (2023-08-30 20:23:07 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.6-fixes-1

for you to fetch changes up to 5260bd6d36c83c5b269c33baaaf8c78e520908b0:

  Revert "PCI: Mark NVIDIA T4 GPUs to avoid bus reset" (2023-09-08 15:11:45 -0500)

----------------------------------------------------------------
- Add PCI_DYNAMIC_OF_NODES dependency on OF_IRQ to fix sparc64 build error
  (Lizhi Hou)

- After coalescing host bridge resources, free any released resources to
  avoid a leak (Ross Lagerwall)

- Revert a quirk that prevented NVIDIA T4 GPUs from using Secondary Bus
  Reset.  The quirk worked around an issue that we now think is related to
  the Root Port, not the GPU (Bjorn Helgaas)

----------------------------------------------------------------
Bjorn Helgaas (1):
      Revert "PCI: Mark NVIDIA T4 GPUs to avoid bus reset"

Lizhi Hou (1):
      PCI: Fix CONFIG_PCI_DYNAMIC_OF_NODES kconfig dependencies

Ross Lagerwall (1):
      PCI: Free released resource after coalescing

 drivers/pci/Kconfig  | 2 +-
 drivers/pci/probe.c  | 1 +
 drivers/pci/quirks.c | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)
