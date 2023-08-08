Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4239774E45
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 00:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjHHWe1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 18:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjHHWe0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 18:34:26 -0400
Received: from out-113.mta1.migadu.com (out-113.mta1.migadu.com [95.215.58.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A904CFD
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 15:34:25 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691534063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tvIka87Hql946ZPpx6hd4vbkpJreYh/GIZnjwvj50oI=;
        b=fD3cQeg6RLS/RoDfc/Exz5Ycoc1KsDCs6Xcrk0c7SCJLaG4c8hqoFnWT1ZDYCXsxyMVNEv
        dt6ewPBVpkbZFj8YlHOjRjl6y8HrF8XzKAEqLa90xZETwhoEW48Jhr9DkTJR73SKlzW6St
        PbC84VaWW/+S7R6e1suM9448Bp4op8M=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Dave Airlie <airlied@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
        linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH v2 00/11] Fix typos, comments and copyright
Date:   Wed,  9 Aug 2023 06:34:01 +0800
Message-Id: <20230808223412.1743176-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

v1:
	* Various improve.
v2:
	* More fixes, optimizations and improvements.

Sui Jingfeng (11):
  PCI/VGA: Use unsigned type for the io_state variable
  PCI: Add the pci_get_class_masked() helper
  PCI/VGA: Deal with VGA class devices
  PCI/VGA: Drop the inline in the vga_update_device_decodes() function.
  PCI/VGA: Move the new_state assignment out of the loop
  PCI/VGA: Fix two typos in the comments of pci_notify()
  PCI/VGA: vga_client_register() return -ENODEV on failure, not -1
  PCI/VGA: Fix a typo to the comment of vga_default
  PCI/VGA: Fix a typo to the comments in vga_str_to_iostate() function
  PCI/VGA: Tidy up the code and comment format
  PCI/VGA: Replace full MIT license text with SPDX identifier

 drivers/pci/search.c   |  30 ++++++
 drivers/pci/vgaarb.c   | 233 +++++++++++++++++++++++++----------------
 include/linux/pci.h    |   7 ++
 include/linux/vgaarb.h |  27 +----
 4 files changed, 185 insertions(+), 112 deletions(-)


base-commit: 69286072664490a366f3331f9496fe78efaca603
-- 
2.34.1

