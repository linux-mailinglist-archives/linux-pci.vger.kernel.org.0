Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7BE672CC5
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 00:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjARXqc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 18:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjARXqb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 18:46:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021EE4CE76;
        Wed, 18 Jan 2023 15:46:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD81EB81F6C;
        Wed, 18 Jan 2023 23:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C08C433EF;
        Wed, 18 Jan 2023 23:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674085588;
        bh=yiW8MghCtuiyTJhQUu4BvUVMEiJImhYSdbZiLuEJixg=;
        h=From:To:Cc:Subject:Date:From;
        b=XDqe3zwK3aszXlJolyH5eJOo22SCXizoqL5UBSxU+yZPRORhHT8o4OH4O0VA9jze1
         8J8YSRkOVlHJ+az5lIP64KJzEyzgyGaS0jAeQ1MkOypsiJc4z8Ev9gKv1p08kY46l+
         kEx7zIB4sAMojoaDPXUvJkaq1a8YdG1fe4Mq5C6c3R7tGYJMZyqFQKBveTPffmyAnH
         Qd90f0r2QhEFOPQeuUX8JFK88KB7v5HyLitUOfQFGRie1G/wFSF32T7LW4qs3kdqbF
         YrvrlrQ2Tv62hqG1GiQ6VHi2mTdisPAVp4rx64xz4E/EJ+WXmE4fWdM3DaUqdRNSTq
         0ZdM+2NdkL5Iw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/9] PCI/AER: Remove redundant Device Control Error Reporting Enable
Date:   Wed, 18 Jan 2023 17:46:03 -0600
Message-Id: <20230118234612.272916-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is native"),
ths PCI core sets the Device Control bits that enable error reporting for
PCIe devices.

This series removes redundant calls to pci_enable_pcie_error_reporting()
that do the same thing from the AER driver and several NIC drivers.

There are several more drivers where this should be removed; I started with
just the Intel drivers here.

Bjorn Helgaas (9):
  PCI/AER: Remove redundant Device Control Error Reporting Enable
  e1000e: Remove redundant pci_enable_pcie_error_reporting()
  fm10k: Remove redundant pci_enable_pcie_error_reporting()
  i40e: Remove redundant pci_enable_pcie_error_reporting()
  iavf: Remove redundant pci_enable_pcie_error_reporting()
  ice: Remove redundant pci_enable_pcie_error_reporting()
  igb: Remove redundant pci_enable_pcie_error_reporting()
  igc: Remove redundant pci_enable_pcie_error_reporting()
  ixgbe: Remove redundant pci_enable_pcie_error_reporting()

 drivers/net/ethernet/intel/e1000e/netdev.c    |  7 ---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c  |  5 --
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  4 --
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  5 --
 drivers/net/ethernet/intel/ice/ice_main.c     |  3 --
 drivers/net/ethernet/intel/igb/igb_main.c     |  5 --
 drivers/net/ethernet/intel/igc/igc_main.c     |  5 --
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  5 --
 drivers/pci/pcie/aer.c                        | 48 -------------------
 9 files changed, 87 deletions(-)

-- 
2.25.1

