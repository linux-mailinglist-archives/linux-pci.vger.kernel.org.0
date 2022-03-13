Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9489A4D77F1
	for <lists+linux-pci@lfdr.de>; Sun, 13 Mar 2022 20:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbiCMTat (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Mar 2022 15:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiCMTas (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Mar 2022 15:30:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E5F4D274
        for <linux-pci@vger.kernel.org>; Sun, 13 Mar 2022 12:29:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47DAC60A57
        for <linux-pci@vger.kernel.org>; Sun, 13 Mar 2022 19:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B68C340E8;
        Sun, 13 Mar 2022 19:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647199779;
        bh=yr+bK9DWvodmf8ksvjXWdfROscACYUqNUBVvmWQ4yVM=;
        h=From:To:Cc:Subject:Date:From;
        b=E3FwoxIUACH9HHeXLHH1pFs5SNCuafvztR9Du3WOUBQMobnRUjaQTuth0zTE3z0UQ
         8EduOZU7nMW2uaIeeq2sqTYjfNPZb/RGeh/mXpQp2YHu8XmwlISbQFDPV+bLShDQqu
         df/tILdHvdBHo0e8BTLFD7t475Po8R/T/CdAqin7Tmj1o7EqCTsN6N/DRdyn2V2Vqs
         nq0llpQcKten9ySX2Tp1hRC4CZPBfxv+nPpoWKbmzHQfbk//8pDrqwePGkKtExD6AC
         KGPoNsWIfTdzsIVkgqErkzZLLeMgvGL+6KAeHCpyW2b7i4LlXMhCvMhYsdQr98R5Dn
         VHLwh3KtOPNzQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/5] PCI: Remove unused assignments
Date:   Sun, 13 Mar 2022 14:29:28 -0500
Message-Id: <20220313192933.434746-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Krzysztof pointed out several unused variables and unnecessary assignments.
Clean up some of them.

Bjorn Helgaas (5):
  PCI: Remove unused assignments
  PCI: kirin: Remove unused assignments
  PCI: fu740: Remove unused assignments
  PCI: cpqphp: Remove unused assignments
  PCI: ibmphp: Remove unused assignments

 drivers/pci/controller/dwc/pcie-fu740.c |  2 +-
 drivers/pci/controller/dwc/pcie-kirin.c |  3 ---
 drivers/pci/hotplug/cpqphp_core.c       |  2 +-
 drivers/pci/hotplug/cpqphp_ctrl.c       | 22 +++++-----------------
 drivers/pci/hotplug/cpqphp_pci.c        |  2 +-
 drivers/pci/hotplug/ibmphp_hpc.c        |  2 --
 drivers/pci/hotplug/ibmphp_res.c        |  3 +--
 drivers/pci/pci-sysfs.c                 |  7 +------
 drivers/pci/proc.c                      |  4 ----
 drivers/pci/setup-bus.c                 |  2 +-
 10 files changed, 11 insertions(+), 38 deletions(-)

-- 
2.25.1

