Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74313DAB22
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 20:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhG2Sms (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 14:42:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229925AbhG2Sms (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jul 2021 14:42:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6EC0960FD7;
        Thu, 29 Jul 2021 18:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627584164;
        bh=Fw6pnMuUh/6p/2qaZfimakF16+9evrrMwuSMuxTp7mY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Grbt/G5EJhyyi+sUpI2M72A2x+g/fsT9QGsjb5zUomG9eQQVxtDqu4m349ZzkKJXp
         mDwTZH+A0PKAuYKVLXx6aKxexX6Q3hxRI9gZxIdzU5UB7m9tod8ETxGjargEV45UHP
         XT2eOCH43ayTn+Zuaimg5bGbR1HEy3VcM4q7/kfAecxHWEiQ7xNsBsXDWyFgo5K2Tv
         bKbGBqefaCYa4PmdRM+iQekIYOjoJSCrWqD4ssJ/FWBwdeGchOYzmM4Mizb42+rdeF
         JIU2m+hcSU4kub3shrgNdDw+Iw9X/0VZJa2w7qrlNmEghFUXP6HS8L5tceu1KguNyF
         mimPFoDaQ7VlQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Hannes Reinecke <hare@suse.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 3/6] PCI/VPD: Treat initial 0xff as missing EEPROM
Date:   Thu, 29 Jul 2021 13:42:31 -0500
Message-Id: <20210729184234.976924-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729184234.976924-1-helgaas@kernel.org>
References: <20210729184234.976924-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>

Previously we assumed that the first tag being 0x00 meant an EEPROM was
missing.  The first tag being 0xff means the same thing; check for that
also.

[bhelgaas: rework error mesage]
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/vpd.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 9b54dd95e42c..66703de2cf2b 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -78,10 +78,8 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
 	while (off < old_size && pci_read_vpd(dev, off, 1, header) == 1) {
 		unsigned char tag;
 
-		if (!header[0] && !off) {
-			pci_info(dev, "Invalid VPD tag 00, assume missing optional VPD EPROM\n");
-			return 0;
-		}
+		if (off == 0 && (header[0] == 0x00 || header[0] == 0xff))
+			goto error;
 
 		if (header[0] & PCI_VPD_LRDT) {
 			/* Large Resource Data Type Tag */
@@ -113,6 +111,12 @@ static size_t pci_vpd_size(struct pci_dev *dev, size_t old_size)
 		}
 	}
 	return 0;
+
+error:
+	pci_info(dev, "invalid VPD tag %#04x at offset %zu%s\n",
+		 header[0], off, off == 0 ?
+		 "; assume missing optional EEPROM" : "");
+	return 0;
 }
 
 /*
-- 
2.25.1

