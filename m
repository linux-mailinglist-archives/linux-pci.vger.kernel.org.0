Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31368E4347
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2019 08:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403996AbfJYGKu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Oct 2019 02:10:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38568 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394261AbfJYGKu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Oct 2019 02:10:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id v9so859260wrq.5
        for <linux-pci@vger.kernel.org>; Thu, 24 Oct 2019 23:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=urdSZrEfORclk6zL/+g0MK1/k4SMP80YLlGcZvUazOk=;
        b=kshr2qIhGH1DuUvrqG0fFgLfQD827XA+G8f/XiEq0Ilxcg1KMf8hVPn243UErKq4w/
         ZqdcFd/xi6aB9CMpjRGEumXNJcJconNO99nJWY5GGOxOMnweK1Dht1ywjgD72PF89hGg
         wyU5zRBE9SXS9vgASbCv4P1Phu3LYS+hRO3y+D5NyJlmsY66fsuX/M6fCRFWKL+q2UxI
         wqJQ3OG5k5Vv+JWYgfdqdgRZUc9sFGWYZO1DedrcoCOmrJkhtorw4o91ZfH+kpOz/cML
         ce11UnICMKHEzoSBvRmSy63bb3Q3ONY6zoa7MO10UXndnHUe1mrXDDfAMQnJvU0WferN
         bTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=urdSZrEfORclk6zL/+g0MK1/k4SMP80YLlGcZvUazOk=;
        b=NRdrBZb8aeX65aEWl6h5zmL/xvcUiMaXV/rKGqvohi16cPVGSYu59+Y1KmnJlJ286b
         KIjLDmU/69hX4mJWCRDZxMA5i0wluJXnt8i2f/tcVHNxHMhZfAt6UDFQ9IkNAhIy9FoS
         tMjmF/Xyn23ZCmre+QwRpfJVFeml25i3sZzHYny5xNsxcAIfk3C1QtXjTgzPncZH53ln
         v8ELC0/UyEBROAxuAUAgTXwnEkqNAVOZ4dUh9uK2i2wMaKFjgCyvcDrErgLNM/PUdnv9
         /wj2mNmt63LMb/qmw5V/92BymmK9gbNQm6GbN4sA0/JsSYT6X5L0H1xrJT4Yy8Y+HwAu
         9LdA==
X-Gm-Message-State: APjAAAXPfe87oXYsh1g4OHg/Ch7zvpGmgbmJiY7WeFYBBLc39ERSTt1Z
        uiHPls5UGNb25C3aQjez5luCZA==
X-Google-Smtp-Source: APXvYqz8LkDtEZTzsDKuLH9UrK6btdapTCbVwzfYkAqutNcBUrskoovD+oFz0se0O3wUik65+/qPDA==
X-Received: by 2002:a5d:6892:: with SMTP id h18mr1110459wru.370.1571983848501;
        Thu, 24 Oct 2019 23:10:48 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id w22sm1097375wmc.16.2019.10.24.23.10.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 23:10:47 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, palmer@sifive.com,
        hch@infradead.org, longman@redhat.com, helgaas@kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH v2 2/2] pci: Default to PCI_MSI_IRQ_DOMAIN
Date:   Fri, 25 Oct 2019 08:10:38 +0200
Message-Id: <514e7b040be8ccd69088193aba260da1b89e919c.1571983829.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571983829.git.michal.simek@xilinx.com>
References: <cover.1571983829.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1571983829.git.michal.simek@xilinx.com>
References: <cover.1571983829.git.michal.simek@xilinx.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Palmer Dabbelt <palmer@sifive.com>

As far as I can tell, the only reason there was an architecture
whitelist for PCI_MSI_IRQ_DOMAIN is because it requires msi.h.  I've
built this for all the architectures that play nice with make.cross, but
I haven't boot tested it anywhere.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Acked-by: Waiman Long <longman@redhat.com>
---

Changes in v2: None

Origin patch here:
https://lore.kernel.org/linux-pci/20191017181937.7004-4-palmer@sifive.com/

---
 drivers/pci/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index a304f5ea11b9..77c1428cd945 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -52,7 +52,7 @@ config PCI_MSI
 	   If you don't know what to do here, say Y.
 
 config PCI_MSI_IRQ_DOMAIN
-	def_bool ARC || ARM || ARM64 || X86 || RISCV
+	def_bool y
 	depends on PCI_MSI
 	select GENERIC_MSI_IRQ_DOMAIN
 
-- 
2.17.1

