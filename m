Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF333E2E76
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 12:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405399AbfJXKNY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Oct 2019 06:13:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56195 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404550AbfJXKNY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Oct 2019 06:13:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id g24so2128747wmh.5
        for <linux-pci@vger.kernel.org>; Thu, 24 Oct 2019 03:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=WGkdSgyk5QDs0H3YBMShx1APwkt+CxEDuO/NO19ZPMk=;
        b=UZwvrj0eqMSzhF9AmKHoK2Nz33TVc5K3v1H8uZFHVVTc2ub/XCKNrdd5KbEDNBsZvM
         wzeUa/9Z/8VTv4RpuhZME4Yd8knecXXNBqTfiU0IT8VtcAcLQGI2qDP7NSHcx8DDIqHm
         JyWQuVMshTWYX85tj6K6FAqQvUxBebQDha0P/d4ibdcqUBe5iICnxuy/2MZes/XL8yla
         oL0s8tL2gmpOpTgAWggH4RHBFvwCRNaKXTwevgNC+TsPhXveLZLVkazARaL1gebA+/Le
         OMrxwTEEzVylkBIGCcwxEo63tfV+YBlzXjJ3aZcLKc88h5fNpLMRggv0PaBc9rxzaNAp
         LdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=WGkdSgyk5QDs0H3YBMShx1APwkt+CxEDuO/NO19ZPMk=;
        b=rTekve8sdlyJaXnOSe8DQpr9WHWIDIT4BhCg3MUiMIAnkkxIAVGQJavQhm+zT25/Bz
         twHP+OKfggHkEvCi15RJFGnVlIw/EV6v+dbK2hWIkHeGwfKejcnWtgAlggz9IKlgpSHg
         vKmsh96ydy5unWTDmTy47kGHulKOR3aZVWhqysf7MZ8T/zWbrc+iYOEztx71bYkSj2Wr
         nHcGyyBpwBD4SUIqjrX1sNFHwm9DasnJbzR1/rg/zzW9ylWh76QR8hwvAhGKQrmdLVPg
         EE/CrlA4BhO8ighG9wWg+2iWBxpbZ61v7BJ2hNeskB1e2e1psj31f3/+nzfZiOuvljYb
         9txg==
X-Gm-Message-State: APjAAAUjhiRwuK7+akmvK1TVM8lobBkFModiTU8v4cEWpA43HIwBZgfH
        VkU8bCwxVgqufSsnRjKW44fJDg==
X-Google-Smtp-Source: APXvYqwITaHJW8sYBW/ZnIhYqk4waxD+Srrn1VRnWsk47+PN9e4+4f6vp0kjCW4Yqb/fDMZQIB39+w==
X-Received: by 2002:a1c:a78b:: with SMTP id q133mr4131264wme.115.1571912003060;
        Thu, 24 Oct 2019 03:13:23 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id i18sm22736686wrx.14.2019.10.24.03.13.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 03:13:22 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, palmer@sifive.com,
        hch@infradead.org, longman@redhat.com, helgaas@kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH 2/2] pci: Default to PCI_MSI_IRQ_DOMAIN
Date:   Thu, 24 Oct 2019 12:13:12 +0200
Message-Id: <ac4cb87e8483ab5a4e97dfec95849aafd5c99e54.1571911976.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1571911976.git.michal.simek@xilinx.com>
References: <cover.1571911976.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1571911976.git.michal.simek@xilinx.com>
References: <cover.1571911976.git.michal.simek@xilinx.com>
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
---

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

