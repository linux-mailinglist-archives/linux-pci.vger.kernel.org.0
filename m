Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5718257A56E
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 19:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239302AbiGSRd1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 13:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239334AbiGSRd0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 13:33:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638675A8BC;
        Tue, 19 Jul 2022 10:33:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F363B6151D;
        Tue, 19 Jul 2022 17:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1BBC341C6;
        Tue, 19 Jul 2022 17:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658252005;
        bh=tRKuMrr8rjuQB8HL23Itlt0lzzpA80kx5d/SBi5oL+E=;
        h=From:To:Cc:Subject:Date:From;
        b=ud9kL3VYgfS1vmemDOEMSOuadDIeOLevPC6SrmSkDg2QS5lXDgPOatY8zFH6tGZYi
         rrP643c+7lL78KkYLm+E4KDzIWaecByG8/0FnSao7uuyEmgnKMUVhM3gajowXc8HIS
         mFUHNRREXN8bOgql/sKtAElwKri2vyvyVPBYYOGMr6h8AraHTVI2moFKg7xffWKWFh
         gt3v0SII4UsYCFltnh9LVEO/B5zKC8ET596FkzjcxQ9tEHpnRnhtI5FQmM4EmKOKMW
         CVcjrA/nlMF0jmxtjeObJj0i+l8ty/eZ7ss176vp887NOQB1lGxPX+If12s5I1XS1X
         xYRKD83rtYvrA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: fu740: Remove unnecessary include files
Date:   Tue, 19 Jul 2022 12:33:21 -0500
Message-Id: <20220719173321.1545451-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

fu740 uses no syscon or regman interfaces, so it doesn't need to include
mfs/syscon.h.  It uses no regulator interfaces, so it doesn't need to
include regulator/consumer.h either.

Remove both unnecessary includes.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pcie-fu740.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
index 02cc70d8cc06..e8b008f73f34 100644
--- a/drivers/pci/controller/dwc/pcie-fu740.c
+++ b/drivers/pci/controller/dwc/pcie-fu740.c
@@ -16,11 +16,9 @@
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
-#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
-#include <linux/regulator/consumer.h>
 #include <linux/resource.h>
 #include <linux/types.h>
 #include <linux/interrupt.h>
-- 
2.25.1

