Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6879F6D2588
	for <lists+linux-pci@lfdr.de>; Fri, 31 Mar 2023 18:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjCaQbn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Mar 2023 12:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjCaQbY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Mar 2023 12:31:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0CF26249;
        Fri, 31 Mar 2023 09:27:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 575366296C;
        Fri, 31 Mar 2023 16:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF83C433EF;
        Fri, 31 Mar 2023 16:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680280035;
        bh=eP8/B3AzdH6BqhzV/6e2SjkXVUjAStqU1rkXicnS8PY=;
        h=Date:From:To:Cc:Subject:From;
        b=BJFD9wvNuTpFYQY9pNDYsrPHKtOH+7Me/eyYUYWdAIzo/H200uYkjilxt+jMdyQk8
         fuWezglKiWhtRcujm1cN2KsxoI8K+gePViaoLTBlwrvgdNEFFhx9gzTlvimV381xWV
         GC8FIQv/ZGZAqCLGe65h6FLi32qI13mwU6m/8LY0v5fAbGD8R6MaY6SW86kvbaUZjz
         nUq6uX19HAOik205wnd7YELysNX2AeVPo26NNUOacfV3HXHMibAmb9BSHBnid19eIH
         poUjRGH5nLzeeuPlx5zHOn6txOjZpCZT9RMs6GYzj8+akgeHq6wPEnd1T8KQ+yG1S5
         o+6jKJN7MdVzw==
Date:   Fri, 31 Mar 2023 11:27:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [GIT PULL] PCI fixes for v6.3
Message-ID: <20230331162714.GA3232819@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.3-fixes-1

for you to fetch changes up to cdce67099117ece371582f706c6eff7d3a65326d:

  PCI: dwc: Fix PORT_LINK_CONTROL update when CDM check enabled (2023-03-21 13:06:24 -0500)

----------------------------------------------------------------
- Fix DesignWare PORT_LINK_CONTROL setup, which was corrupted when the DT
  "snps,enable-cdm-check" property was present (Yoshihiro Shimoda)

----------------------------------------------------------------
Yoshihiro Shimoda (1):
      PCI: dwc: Fix PORT_LINK_CONTROL update when CDM check enabled

 drivers/pci/controller/dwc/pcie-designware.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
