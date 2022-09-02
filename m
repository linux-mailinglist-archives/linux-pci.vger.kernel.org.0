Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05895AB50A
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 17:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbiIBP0O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 11:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236457AbiIBPZ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 11:25:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47809140F9;
        Fri,  2 Sep 2022 07:58:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7AA461EA5;
        Fri,  2 Sep 2022 14:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0593BC433D7;
        Fri,  2 Sep 2022 14:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662130719;
        bh=UaAcv2RWBLYMQK9mhI6byphOyUV4nkRDSsdRZiMGcPA=;
        h=From:To:Cc:Subject:Date:From;
        b=USpoqqWGlGHH/MOYLgk69yczzjb8FtjKsCM2v1xMDFoLhGvzxQqN/9DzLGNOjso+j
         vUlw7imWEdINq4lIyHF1FkFrjMlb5ZtgS1DvD+N4NnuV3Jp3UpBcb/FUZGxRU1M3in
         HXocdoymJ0Z3wxIpBuqjzpX+pKeh6FIZCYflXROsXMTZsvz0xuqb2YDDm9Em1lZlvo
         S5u7OALv6vlZw0hn7UYeD4u4saCFPTZs+db+YmCODaeP3l6al1y+T7gksnSC9yIpLH
         OltV7IcH9cCzXktEZ3GESRO3k83SMKV0akIF/BF4O5MF4SjygXqBLJl5IvnTFaqOdk
         HzYQSdIVWBfdg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Koba Ko <koba.ko@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/4] PCI/PM: Always disable PTM for all devices during
Date:   Fri,  2 Sep 2022 09:58:31 -0500
Message-Id: <20220902145835.344302-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

We currently disable PTM for Root Ports during suspend.  Leaving PTM
enabled for downstream devices causes UR errors if they send PTM Requests.
The intent of this series is to:

  - Unconditionally disable PTM during suspend (even if the driver saves
    its own state) by moving the disable from pci_prepare_to_sleep() to
    pci_pm_suspend().

  - Disable PTM for all devices by removing the Root Port condition.

  - Manually set PTM Enable when restoring PTM state because suspend saves
    the PTM state *after* disabling PTM.

This series is intended to replace Rajvi's second patch, so we would end
up with this:

  Rajvi  PCI/PM: Simplify pci_pm_suspend_noirq()
  Bjorn  PCI/PTM: Preserve PTM Root Select
  Bjorn  PCI/PTM: Enable PTM when restoring state
  Bjorn  PCI/PM: Always disable PTM for all devices during suspend
  Bjorn  PCI/PTM: Cache PTM Capability offset

Please comment!

Bjorn Helgaas (4):
  PCI/PTM: Preserve PTM Root Select
  PCI/PTM: Enable PTM when restoring state
  PCI/PM: Always disable PTM for all devices during suspend
  PCI/PTM: Cache PTM Capability offset

 drivers/pci/pci-driver.c |  8 ++++++
 drivers/pci/pci.c        | 20 --------------
 drivers/pci/pcie/ptm.c   | 56 +++++++++++++++++++---------------------
 include/linux/pci.h      |  1 +
 4 files changed, 35 insertions(+), 50 deletions(-)

-- 
2.25.1

