Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C2272483F
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 17:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238120AbjFFPxS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 11:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjFFPxR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 11:53:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BA310D1
        for <linux-pci@vger.kernel.org>; Tue,  6 Jun 2023 08:53:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 722F36347F
        for <linux-pci@vger.kernel.org>; Tue,  6 Jun 2023 15:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CD7C433D2;
        Tue,  6 Jun 2023 15:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686066795;
        bh=XbbC21IILF4tT/p8mLAB3B+XF67k1UpE8CexdDbGQGM=;
        h=From:To:Cc:Subject:Date:From;
        b=WioDO33blskF92ZSQn/6PoMv5iRIxbo6/pR9eY2g7sNhAjykIhRcmD1CIMkAlJ+HS
         Lpv7CZhNUf+bfl9L0xQj+hJ/gC9gcqcNIOgGqfAN34ZcZY6FIY7mw1xDlKfn41sExv
         7cTn1U+EiYMaP1WPkhxLUCHlEXrM+a5sqigiOteD8Dv3SlvzKh90OhLWk9Pe22nLHi
         1Xyflykp6FFzICgbjtLCIBSSWbeZWRQGo4OHqXAfVrrRJaSc4cBdHrfpl06qKRpOQf
         NGNsMuVDIIMRiguC3988xb0Bc0x0mMZk0xaqiVxzROavYaZuVzcPDsUv1HbrTf/gbv
         dFc+0TyosXStA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: Expand comment about sorting pci_ids.h entries
Date:   Tue,  6 Jun 2023 10:53:10 -0500
Message-Id: <20230606155310.1125996-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Clarify the request to sort Vendor ID and Device ID entries by numeric
value, not alphabetically.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci_ids.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 45c3d62e616d..4d2001b86e6b 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2,7 +2,7 @@
 /*
  *	PCI Class, Vendor and Device IDs
  *
- *	Please keep sorted.
+ *	Please keep sorted by numeric Vendor ID and Device ID.
  *
  *	Do not add new entries to this file unless the definitions
  *	are shared between multiple drivers.
-- 
2.34.1

