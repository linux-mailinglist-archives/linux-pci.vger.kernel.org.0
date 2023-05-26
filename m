Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13E7712FAC
	for <lists+linux-pci@lfdr.de>; Sat, 27 May 2023 00:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244201AbjEZWAM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 May 2023 18:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244199AbjEZWAL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 May 2023 18:00:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02475134;
        Fri, 26 May 2023 14:59:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10C7B6541A;
        Fri, 26 May 2023 21:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E23AC433D2;
        Fri, 26 May 2023 21:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685138304;
        bh=1nZsA+RKgqZot2LPxa0Mg83EqjS8d/7etUXcHXpdE0E=;
        h=Date:From:To:Cc:Subject:From;
        b=WnS+sewHPL2uqoRV2Jeuh6uKGYtRjy/Z0GF/vRKNNJm2AOOQsVPIcnwfLCCB9frxt
         BBsFQwpF7P2bXRpYce0siyWRVkchC2WGmTFxaRsVOdEDcP9kGfQ1dSeqhvzqTC2n3p
         Pja4ixHChAvAPfvU9oUnmJFt+jJ3BQgNpGULMVAxYcrBBDc+2hE2YdQQcgFHsd9+2l
         vwWMByDpmqSQmLwZ0bmHbdDK/uZOuOFpylZVGIsH3PmU65vj+JRgFlq6yUE/oi+OQf
         NZ2sM3eynl1OqSddf3gRIYD408D6zlK6UXdKzSwzYb2tUoKFFNeb3gy9lqtVDkz3Cr
         AJTBkiw08YT7A==
Date:   Fri, 26 May 2023 16:58:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Blakeney <mark.blakeney@bullet-systems.net>
Subject: [GIT PULL] PCI fixes for v6.4
Message-ID: <ZHErfurfF9cNIION@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.4-fixes-1

for you to fetch changes up to 3b8803494a0612acdeee714cb72aa142b1e05ce5:

  PCI/DPC: Quirk PIO log size for Intel Ice Lake Root Ports (2023-05-11 17:38:46 -0500)

----------------------------------------------------------------
- Quirk Ice Lake Root Ports to work around DPC log size issue (Mika
  Westerberg)

----------------------------------------------------------------
Mika Westerberg (1):
      PCI/DPC: Quirk PIO log size for Intel Ice Lake Root Ports

 drivers/pci/quirks.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)
