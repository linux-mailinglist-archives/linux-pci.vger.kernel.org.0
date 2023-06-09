Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F54472A63E
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jun 2023 00:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjFIWZR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Jun 2023 18:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjFIWZR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jun 2023 18:25:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472173A80
        for <linux-pci@vger.kernel.org>; Fri,  9 Jun 2023 15:25:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB9E265C9C
        for <linux-pci@vger.kernel.org>; Fri,  9 Jun 2023 22:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDDDC433D2;
        Fri,  9 Jun 2023 22:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686349515;
        bh=6vl+HqAi0TZ89MmX2svXN8sbDw6l+dQw1D+Kg+Jsk1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ah5M1Hk0Xh4mnZObI0uNS8blJD76DzJmaltfXUc8y4pUDYb9H+CFMZBkNkWCjt8V5
         7jzsTUaQ8TvbsDuZ5wavzhXbbCDAv9lcc8oIp/aK+ZJL3EH207/ojx/m7rY2KsNONf
         I/LCqj3U5JaXNUGnqMH42JHiUfxaESvSF5kO3FRHg7w625yaJDwWdIzrEPhTYqt/5s
         9ku7MzWVuPhUirYMRVqKATpwLmQpVnUeIp5sUydcgpMcbTFTwoqFzRimkI2Oy90m1O
         /vKcZw7+9uWmJvymEk1DeGpkFPN84r2wq8YsLhrwFNn3hAX4T4kMTmJZ7iKR+bMa9H
         by9KkbgIygzYg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Dave Jiang <dave.jiang@intel.com>, Stefan Roese <sr@denx.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 3/4] Documentation: PCI: Update cross references to .rst files
Date:   Fri,  9 Jun 2023 17:24:59 -0500
Message-Id: <20230609222500.1267795-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609222500.1267795-1-helgaas@kernel.org>
References: <20230609222500.1267795-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Change references to *.txt to *.rst to match the current filenames.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/PCI/pci-error-recovery.rst | 2 +-
 Documentation/PCI/pcieaer-howto.rst      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
index 9981d330da8f..c237596f67e3 100644
--- a/Documentation/PCI/pci-error-recovery.rst
+++ b/Documentation/PCI/pci-error-recovery.rst
@@ -364,7 +364,7 @@ Note, however, not all failures are truly "permanent". Some are
 caused by over-heating, some by a poorly seated card. Many
 PCI error events are caused by software bugs, e.g. DMA's to
 wild addresses or bogus split transactions due to programming
-errors. See the discussion in powerpc/eeh-pci-error-recovery.txt
+errors. See the discussion in Documentation/powerpc/eeh-pci-error-recovery.rst
 for additional detail on real-life experience of the causes of
 software errors.
 
diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index c98a229ea9f5..3f91d54af770 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -160,8 +160,8 @@ when performing error recovery actions.
 Data struct pci_driver has a pointer, err_handler, to point to
 pci_error_handlers who consists of a couple of callback function
 pointers. AER driver follows the rules defined in
-pci-error-recovery.txt except pci express specific parts (e.g.
-reset_link). Pls. refer to pci-error-recovery.txt for detailed
+pci-error-recovery.rst except pci express specific parts (e.g.
+reset_link). Pls. refer to pci-error-recovery.rst for detailed
 definitions of the callbacks.
 
 Below sections specify when to call the error callback functions.
-- 
2.34.1

