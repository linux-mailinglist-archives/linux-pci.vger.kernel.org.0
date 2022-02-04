Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38F04AA250
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 22:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241964AbiBDVak (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 16:30:40 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:59880 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241986AbiBDVaj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 16:30:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 28C57CE2467;
        Fri,  4 Feb 2022 21:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2593BC004E1;
        Fri,  4 Feb 2022 21:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644010236;
        bh=9xc8l7vw16ox1ipnsmrdgBCKBAmGW5YNhi+ZVgOdK9g=;
        h=Date:From:To:Cc:Subject:From;
        b=SoyddsbLtA14tC00Brhd7Tto1My8RSahkuR5VLEuf5+4MFMbRBmKE0hj6MQSw4Gzk
         vKWuG+3k0NH8jCWHoUJ98WUG2fPyPKhTxSQUIqZ6clPcx2j0oA4/hHtIqwpXIVI9au
         eEt8hEB0IQHBHIAwjBs66s78/0Vp8mrMu+2GXqCCo++oksrYqio7fhRMUAj+NHJ6mo
         lTJmbC8xWO8+eDL+5FhHZaLN5ZXEloz0rb/rbO3mqfEuYKx6Jn38dvs1ptdP7hIs5l
         SFE1UH2BOqkIX9MZ5ofIkvjOXcDQ9UTq8lIZROmyx3wPWX7jOYd6pVN67Pw9gfQ8D8
         SGban8Aqy1WCQ==
Date:   Fri, 4 Feb 2022 15:30:34 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bean Huo <huobean@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>
Subject: [GIT PULL] PCI fixes for v5.17
Message-ID: <20220204213034.GA217708@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.17-fixes-3

for you to fetch changes up to 7dd3876205df92e07d824fe2264b38e0b8a9eec1:

  PCI: kirin: Add dev struct for of_device_get_match_data() (2022-02-04 15:14:26 -0600)

N.B. These have been in linux-next for a couple days as 71c96af28da5
("PCI: kirin: Add dev struct for of_device_get_match_data()"), but I
amended that commit to add the reporter's info to the commit log.

----------------------------------------------------------------
PCI fixes:

  - Restructure j721e_pcie_probe() so we don't dereference a NULL pointer
    (Bjorn Helgaas)

  - Add a kirin_pcie_data struct to identify different Kirin variants to
    fix probe failure for controllers with an internal PHY (Bjorn Helgaas)

----------------------------------------------------------------
Bjorn Helgaas (2):
      PCI: j721e: Initialize pcie->cdns_pcie before using it
      PCI: kirin: Add dev struct for of_device_get_match_data()

 drivers/pci/controller/cadence/pci-j721e.c | 85 +++++++++++++++---------------
 drivers/pci/controller/dwc/pcie-kirin.c    | 31 ++++++-----
 2 files changed, 60 insertions(+), 56 deletions(-)
