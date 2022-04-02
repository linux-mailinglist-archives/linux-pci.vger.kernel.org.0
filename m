Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AA94F0532
	for <lists+linux-pci@lfdr.de>; Sat,  2 Apr 2022 19:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbiDBRXe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Apr 2022 13:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbiDBRXd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 2 Apr 2022 13:23:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2479E29821;
        Sat,  2 Apr 2022 10:21:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D720B8093C;
        Sat,  2 Apr 2022 17:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74B5C340EC;
        Sat,  2 Apr 2022 17:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648920099;
        bh=0hnTG76H6UJd1jyN4W+fg12TNi12EMC3JQ8KEvmfHyo=;
        h=Date:From:To:Cc:Subject:From;
        b=iw6eGux58zywAXGTaW9sQN+eeeei2FH1V6O3bSpTL3KmRsZIWW67cTKI+0YM2YU+x
         VmkGWm5xdluF+5Uz6MGMjownHXIMn0Ljrl06k+7Y/b9MTGMw/x4Z78uH70W3tpSo43
         n/7hIPnAslfN1cRZdqYZCTZWJoI5dA1lRG7lj9hgNG/lpY8JuxCibsiTsOFFCqihC4
         tOqC/NszTBXWrKj0zP4OaD5UChZSdcQbK+146iGqih81fUmPzaNFxTphodmbRNX6We
         a14NtZgKSIt6lruL3zs7QW1CKsezGq42nOvA2ulKGdcsb0O0ijoxJAtg2I+aED5689
         4scequ6CKHNbQ==
Date:   Sat, 2 Apr 2022 12:21:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [GIT PULL] PCI changes for v5.18, part 2
Message-ID: <20220402172137.GA272816@bhelgaas>
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

The following changes since commit 148a650476955705482dd57e7ffcf105d8b65440:

  Merge tag 'pci-v5.18-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci (2022-03-25 13:02:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v5.18-changes-2

for you to fetch changes up to 22ef7ee3eeb2a41e07f611754ab9a2663232fedf:

  PCI: hv: Remove unused hv_set_msi_entry_from_desc() (2022-03-31 10:12:59 -0500)

----------------------------------------------------------------

  - Fix Hyper-V "defined but not used" build issue added during merge
    window (YueHaibing)

----------------------------------------------------------------
YueHaibing (1):
      PCI: hv: Remove unused hv_set_msi_entry_from_desc()

 drivers/pci/controller/pci-hyperv.c | 8 --------
 1 file changed, 8 deletions(-)
