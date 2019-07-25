Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C461F75974
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2019 23:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfGYVZh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Jul 2019 17:25:37 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39676 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfGYVZh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Jul 2019 17:25:37 -0400
Received: by mail-io1-f67.google.com with SMTP id f4so100397506ioh.6
        for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2019 14:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=0OE6CkyrftBD3Ku7P1YRVsn9jYbz8x68WmGWVUa6hzY=;
        b=AWXlfRnEtLM74XglQGEkne+2wpRMQ3s+jTBHVl27BvwSaVklVPQBOEl+vVl2AOmA5q
         qv9xXCge4s0vMUla2SYNdU3WfUuDpFqt6iVunAkr8kVIuSSqBhDFCulVS6VMtoNBW2nW
         a3G2ZcfFBZNVDiJHDGaVNLBfRDN7Awy4HmWGgAy3K0bwPm+wqk1zOeXXbb/TXMI5b+i0
         DnvM6BNfb/FAc68JxHuQRI2poAaDUJAcgX3JFh0zp6NFcq0rNvNxGTWgwNBKhLE/Hkyp
         MdU+cjP7xzKxethms3zDzEPZwpyPFzGC5cDQqCSu2QqadqaB+iA26yhrhCOZ+AgVap5e
         mmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=0OE6CkyrftBD3Ku7P1YRVsn9jYbz8x68WmGWVUa6hzY=;
        b=kJsMR/YtRBP1c7o2+PLQmUP6Di2650aEDcjPNb/783IpAnPr5hD33+I7SPUhG/8ViP
         JdNfDFGE6yPH2JnwvA9HjoZ8Y3wRwBfataa2XflbgH1mcgR8qanDBC2u3X+6YXza/Fry
         trP9e8Go3/74fGQwH0XIgmu3UYChMJ86idGVG89uqwPdCcbkyN8jrfObcPXxX8l1yA0F
         K3GGcH/3z+STn+65q1X7DmtJgVKGP6tLulAFF7aZTRGpfamfZaJcwc6navgnVZANtyKv
         0WjDtDGb7KSn6yI0b4j4s0+6fr7qDFXKjsa3uP4yLxtQxTSaKb4nbnYD2WKE6Rh0eVk/
         YnbQ==
X-Gm-Message-State: APjAAAWmLktCLZnw+f1Ltcu5gbg0wu+9Ovrzpfo5n1Mod83SzDdlAvxN
        Uc4alYVF018xRorTw3tlUoCsFsDFZx8=
X-Google-Smtp-Source: APXvYqyXby2GabhLGrmfNxGRSjjzbJ/o7K20JIc5pwz0S+rpYgbr6bHq19jJS94ZBSI/g1gq1f+w5w==
X-Received: by 2002:a6b:b556:: with SMTP id e83mr81812981iof.94.1564089936348;
        Thu, 25 Jul 2019 14:25:36 -0700 (PDT)
Received: from localhost (67-0-24-96.albq.qwest.net. [67.0.24.96])
        by smtp.gmail.com with ESMTPSA id s2sm36154569ioj.8.2019.07.25.14.25.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 14:25:35 -0700 (PDT)
Date:   Thu, 25 Jul 2019 14:25:34 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     bhelgaas@google.com
cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH] pci: Kconfig: select PCI_MSI_IRQ_DOMAIN by default on
 RISC-V
Message-ID: <alpine.DEB.2.21.9999.1907251422040.32766@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


This is part of adding support for RISC-V systems with PCIe host 
controllers that support message-signaled interrupts.

Signed-off-by: Wesley Terpstra <wesley@sifive.com>
[paul.walmsley@sifive.com: wrote patch description; split this
 patch from the arch/riscv patch]
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
---
 drivers/pci/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 2ab92409210a..beb3408a0272 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -52,7 +52,7 @@ config PCI_MSI
 	   If you don't know what to do here, say Y.
 
 config PCI_MSI_IRQ_DOMAIN
-	def_bool ARC || ARM || ARM64 || X86
+	def_bool ARC || ARM || ARM64 || X86 || RISCV
 	depends on PCI_MSI
 	select GENERIC_MSI_IRQ_DOMAIN
