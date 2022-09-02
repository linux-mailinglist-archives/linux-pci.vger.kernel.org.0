Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74FD5AB50F
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 17:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbiIBP0S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 11:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236719AbiIBPZe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 11:25:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036937859B;
        Fri,  2 Sep 2022 07:58:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B7D461DFA;
        Fri,  2 Sep 2022 14:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1863C433C1;
        Fri,  2 Sep 2022 14:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662130722;
        bh=QW7EMedLQj/MVKx8Ga0Td1a1vNHsbxGM/M2r3RIXsdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a6MA6/CZupl87PUlvUUiobXUPN04gYfEUZhQaGl5h6rFsIstFDu6PNXnOPg30o4HB
         bmIEWYrAnDkNaIpvWWxOvCHi0/czSdRFabRSEe4DSn0Oz9hUX7BCbAnmcJmJvxux5t
         NvexDoTZTdDS0dayQUTvSrCz3twG0xhLZ/blsmFaJmEevNom/6IBU/aD1l+3lWV1Zn
         bLh14vBtb3RrRx3aBu3A31mNWINhFDDVcmNxTswzORxRnUmt3QF7UYydw9DUKuXGPW
         7biVaz++X07dA5NAnp3OjAf9t8xXjijqRG1DKXjzkDgk8qdpAFdS2egx6wsb0lVWxG
         ZRDeDns+o5gWQ==
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
Subject: [PATCH 2/4] PCI/PTM: Enable PTM when restoring state
Date:   Fri,  2 Sep 2022 09:58:33 -0500
Message-Id: <20220902145835.344302-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902145835.344302-1-helgaas@kernel.org>
References: <20220902145835.344302-1-helgaas@kernel.org>
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

The suspend path may disable PTM before saving config state, which means
the PCI_PTM_CTRL_ENABLE bit in the saved state may be cleared even though
we want PTM to be enabled when resuming.

If "dev->ptm_enabled" is set, it means PTM should be enabled, so make sure
PCI_PTM_CTRL_ENABLE is set when restoring the PTM state.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/ptm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index b6a417247ce3..3115601a85ef 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -82,6 +82,14 @@ void pci_restore_ptm_state(struct pci_dev *dev)
 		return;
 
 	cap = (u16 *)&save_state->cap.data[0];
+
+	/*
+	 * The suspend path may disable PTM before saving config state.
+	 * Make sure PCI_PTM_CTRL_ENABLE is set if PTM should be enabled.
+	 */
+	if (dev->ptm_enabled)
+		*cap |= PCI_PTM_CTRL_ENABLE;
+
 	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, *cap);
 }
 
-- 
2.25.1

