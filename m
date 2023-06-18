Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F40A7346F6
	for <lists+linux-pci@lfdr.de>; Sun, 18 Jun 2023 18:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjFRQZX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 18 Jun 2023 12:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjFRQZU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 18 Jun 2023 12:25:20 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C880FE62
        for <linux-pci@vger.kernel.org>; Sun, 18 Jun 2023 09:25:18 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id AvD8qePgkuHEfAvDDqbYZc; Sun, 18 Jun 2023 18:25:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1687105511;
        bh=7JePpIbtyIw6zKN1IPxyCEDxfHQDsi/Aj9GfQW/K8Hs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=rqOcEbLeGaNm5DlAC1yLgV2X2Zkc6lGAsqydI1b2ap8LJYmxiW2kVWhBsx+8u5aIp
         CPikmmCcAmjwA3zNxfMGbmor4ZYzux0QI8truRwPu9S/tioU59HzNq9Fm2IOReYE2n
         gdaQESUSYTrgpx+jwCBreZbE+E6IiUa/QyWMsNBbAKgrczbHV7y/518k0A9PL4Pbpz
         jmZ2+iRp705D3hlP2hxY1nl5JyWcIDMy9q7o48kEGI9mlhYkA9uaTpiYczdmC/cZNs
         SypS8oOGEjk/q5J+xbI3yeSst6nyjDcYszpbw05CzkSAomqLZOeE8Gpu4HcoHW+NT8
         9jw5tM5qR73Uw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 18 Jun 2023 18:25:11 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-pci@vger.kernel.org
Subject: [PATCH 2/2] PCI: Change the type of 'rom_attr_enabled' in 'struct pci_dev'
Date:   Sun, 18 Jun 2023 18:24:55 +0200
Message-Id: <d7a34ad369336db73145c3efbade895e792a0ad3.1687105455.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <407b17c3e56764ef2c558898d4ff4c6c04b2d757.1687105455.git.christophe.jaillet@wanadoo.fr>
References: <407b17c3e56764ef2c558898d4ff4c6c04b2d757.1687105455.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Make 'rom_attr_enabled' a single bit in a bitfield and move it close to an
existing bitfield so that they can be merged.

This field is only used in 'drivers/pci/pci-sysfs.c' to store 0 or 1.

On x86_64, this shrinks the size of 'struct pci_dev' by 8 bytes.
This goes from 3560 to 3552.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 include/linux/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 106754757279..0ff7500772e6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -464,12 +464,12 @@ struct pci_dev {
 	unsigned int	no_vf_scan:1;		/* Don't scan for VFs after IOV enablement */
 	unsigned int	no_command_memory:1;	/* No PCI_COMMAND_MEMORY */
 	unsigned int	rom_bar_overlap:1;	/* ROM BAR disable broken */
+	unsigned int	rom_attr_enabled:1;	/* Display of ROM attribute enabled? */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
 	u32		saved_config_space[16]; /* Config space saved at suspend time */
 	struct hlist_head saved_cap_space;
-	int		rom_attr_enabled;	/* Display of ROM attribute enabled? */
 	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
 	struct bin_attribute *res_attr_wc[DEVICE_COUNT_RESOURCE]; /* sysfs file for WC mapping of resources */
 
-- 
2.34.1

