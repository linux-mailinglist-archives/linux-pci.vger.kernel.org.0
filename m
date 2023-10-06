Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878DA7BBC18
	for <lists+linux-pci@lfdr.de>; Fri,  6 Oct 2023 17:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjJFPsH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Oct 2023 11:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbjJFPsG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Oct 2023 11:48:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761E2B6;
        Fri,  6 Oct 2023 08:48:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC393C433C8;
        Fri,  6 Oct 2023 15:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696607285;
        bh=I2BM2DEbQztPGY6Z+gBWH7WL0buSYdKKMp7SYvdgqK8=;
        h=Date:From:To:Cc:Subject:From;
        b=cVtSAYayyWljBlLwYRuSVkz1P9ShxM/Oe47rN2I2Bm7yptef1gyGUci4g9dUCrdld
         VBgR7ciCTxa5n94bG/8Vn6hw1O+x1/gwEDzZGF3gzF7DjWc7Sbx0irEMRzQYzVuxIc
         U0Q4ZcnbWML/s6WFGB6P3YbHLpq30Loc/NHMbWtVx1E9PeCi5T77RxMHIku8PJcIvg
         j/Wogeh2uTpMP9fevi3BCGAnAc08M08FVpA0sRh+3fo69MB3f7UQ1PjuBV5mfj+4wa
         txEMoweYDTAwOviBYkDWbHuB/9sHGbJo6rjd+MGYeRm/OKmM4HTwH6tts0MXfn6GpG
         g17mf6W/jOAgg==
Date:   Fri, 6 Oct 2023 10:48:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Blakeney <mark.blakeney@bullet-systems.net>,
        Lizhi Hou <lizhi.hou@amd.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>
Subject: [GIT PULL] PCI fixes for v6.6
Message-ID: <20231006154802.GA855916@bhelgaas>
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

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.6-fixes-2

for you to fetch changes up to c82458101d5490230d735caecce14c9c27b1010c:

  PCI/PM: Mark devices disconnected if upstream PCIe link is down on resume (2023-09-29 17:42:00 -0500)

----------------------------------------------------------------
- Fix a qcom register offset that broke IPQ8074 PCIe controller enumeration
  (Sricharan Ramabadhran)

- Handle interrupt parsing failures when creating a device tree node to
  avoid using uninitialized data (Lizhi Hou)

- Clean up if adding PCI device node fails when creating a device tree node
  to avoid a memory leak (Lizhi Hou)

- If a link is down, mark all downstream devices as "disconnected" so we
  don't wait for them on resume (Mika Westerberg)

----------------------------------------------------------------
Lizhi Hou (2):
      PCI: of_property: Handle interrupt parsing failures
      PCI: of: Destroy changeset when adding PCI device node fails

Mika Westerberg (1):
      PCI/PM: Mark devices disconnected if upstream PCIe link is down on resume

Sricharan Ramabadhran (1):
      PCI: qcom: Fix IPQ8074 enumeration

 drivers/pci/controller/dwc/pcie-qcom.c |  4 +---
 drivers/pci/of.c                       | 19 +++++++++++--------
 drivers/pci/of_property.c              | 25 ++++++++++++++++++-------
 drivers/pci/pci-driver.c               | 14 +++++++++++++-
 4 files changed, 43 insertions(+), 19 deletions(-)
