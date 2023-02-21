Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5C569D87E
	for <lists+linux-pci@lfdr.de>; Tue, 21 Feb 2023 03:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjBUCds (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Feb 2023 21:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjBUCdp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Feb 2023 21:33:45 -0500
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4413011EB7;
        Mon, 20 Feb 2023 18:33:44 -0800 (PST)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 69D2E3F2FE;
        Tue, 21 Feb 2023 02:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676946823;
        bh=bhjZxuXkm1MHeyPMkpuHBbBuF0eWs3dLUcdK/gbm22M=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=YjQUu37OAp54gmVSlP7VGLKSkWOe4FO1Su0AJpjcMvKoEUtDTZfGE+PQCb0LLfHsr
         /t0VPD6CAwjGdb933ivrYfBPF1bj/Llyg8Iur8iLkQe+Ey3bTGabKz4Szr0WZ3DmhJ
         45oCTewlyMBmgV9ZNdQKDFFp8bIT/4iJ7WGOCsLNC8vYoEUZfF7Iq60yS21nTsW+5S
         R94/Yub7xZy9tIYWZrmMxLG2XD3+rF8Ns30y56cFzlBMMeLVb2ePkwxn32ksg7g17G
         8H/qQwrm286j3uAQponaqPrTGg95QJcXOSsejGLXG+8FrFfE3ux9MsgBN7V0qJOI9H
         ArXQefx+bXWZQ==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     hkallweit1@gmail.com, nic_swsd@realtek.com, bhelgaas@google.com
Cc:     koba.ko@canonical.com, acelan.kao@canonical.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/6] Revert "PCI/ASPM: Unexport pcie_aspm_support_enabled()"
Date:   Tue, 21 Feb 2023 10:32:33 +0800
Message-Id: <20230221023237.1905536-3-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230221023237.1905536-1-kai.heng.feng@canonical.com>
References: <20230221023237.1905536-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This reverts commit ba13d4575da5e656a3cbc18583e0da5c5d865417.

This will be used by module once again.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v8:
 - New patch.

 drivers/pci/pcie/aspm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 4b4184563a927..692d6953f0970 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1372,3 +1372,4 @@ bool pcie_aspm_support_enabled(void)
 {
 	return aspm_support_enabled;
 }
+EXPORT_SYMBOL(pcie_aspm_support_enabled);
-- 
2.34.1

