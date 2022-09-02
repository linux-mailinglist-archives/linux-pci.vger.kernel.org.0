Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A735ABB43
	for <lists+linux-pci@lfdr.de>; Sat,  3 Sep 2022 01:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiIBXfu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 19:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiIBXft (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 19:35:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10B5DEA7D;
        Fri,  2 Sep 2022 16:35:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D1C161FCA;
        Fri,  2 Sep 2022 23:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF38C433D6;
        Fri,  2 Sep 2022 23:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662161746;
        bh=FmnAhEe5uZ9f3ApuhBxfFu90IRni8tTV6tD+FWbuSa8=;
        h=From:To:Cc:Subject:Date:From;
        b=kBxHCiXFgnQoiKbZQA31DL25+Hs1UV9ewHYNNxsUqx+m95UU5zl+bDsRt3dv7KVJw
         RrBWsLqg6tL4O7EEopzjJakahh8CxxuW0EXVI32+o1abjnkE7LqWWLyraouDnBlqzY
         ZgKzmYvrvlZruyHoSTyHvRr+MgJSL7oWCjgppUV0gGu86tIz5B/D4dMqnhOlZQVpmw
         T2wNxoo2C1tii3G1y1rLdsytX9hd1jKXuEv3XyVBK0aaR5aAlhE1RL76eC0iIXkw2j
         LhZF6vNMr/c10OoAwWEhYvcac6K8RLCxziiZOcLQ+2XVHdhV9djwNH7t0T09NyWi3e
         OCyFSUAAeaAZw==
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
Subject: [PATCH v2 0/3] PCI/PM: Always disable PTM for all devices during suspend
Date:   Fri,  2 Sep 2022 18:35:40 -0500
Message-Id: <20220902233543.390890-1-helgaas@kernel.org>
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

  - Disable PTM for all devices by removing the Root Port condition and
    doing it early in the suspend paths.

  - Explicitly re-enable PTM during resume, which requires new support in
    pci_enable_ptm() for Root Ports and Switch Upstream Ports.


Bjorn Helgaas (3):
  PCI/PTM: Preserve PTM Root Select
  PCI/PTM: Implement pci_enable_ptm() for Root Ports, Switch Upstream
    Ports
  PCI/PM: Always disable PTM for all devices during suspend

 drivers/pci/pci-driver.c | 14 ++++++++++++++
 drivers/pci/pci.c        | 20 --------------------
 drivers/pci/pcie/ptm.c   | 36 ++++++++++++++++++++++++++++--------
 3 files changed, 42 insertions(+), 28 deletions(-)

-- 
2.25.1

