Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126A341846A
	for <lists+linux-pci@lfdr.de>; Sat, 25 Sep 2021 22:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhIYUeQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Sep 2021 16:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbhIYUeH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Sep 2021 16:34:07 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142B3C061575;
        Sat, 25 Sep 2021 13:32:32 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i23so38360502wrb.2;
        Sat, 25 Sep 2021 13:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tk71Ha065utVNVLOH6SmaYvA7yXp/Uoif9kGNCMKFO4=;
        b=oQ9MnWyOtTbvghYiZ0b8FFRNGb8c2o10uU5v985hfBjn8BOI0+5qphvBnU1rFmI53D
         zRTi/xqH+ckeulaQwJVICjodLX+bMH7wGH9IFzNRSPCv1I9UYlWYu5iMhOLXD+M7vDc6
         IqF1BgFZWXuAN45uyfhc5xLy03VPWJiCGokiNwnWQLrWrKkvPYl7hLqC2En3sYtDFlx4
         JMhlzEh31NPOX751fPKHkJBjexUt1Xfk53Nj6l3S1BeEonPeQ0n8uF6KZNjaVxwWbtPU
         F4YSupZhOBDgm6LgiySw7pLRZlysdW7sEj7froIkry1zPJSaiuqiarSMamKA7zpmCa7b
         44TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tk71Ha065utVNVLOH6SmaYvA7yXp/Uoif9kGNCMKFO4=;
        b=w6lYm4PS+9DVE564Za1ZYGRa8BiOAeRjri12p3ViNItJXbuod9hweVl3J5eV/a7u1e
         Hvflx8OtTmwCRYNHjusdOULX1EoSRdmwRXgiyWIMiv8eGxs+9MxlgEMClpGaaojEMYnK
         bEHXppgCJaA18rOuQkqvtacckhVIing7kWOUkPCIVBjHFTZ2I6D1HC054Dz5Wemviere
         i+rQqJncVTa/LIe5820dGDI4zPxHBbISL14O2BueD7WWFAwkdhopeBVak+lpEBWsYres
         M6qyWmpVJ1VjL2lXXSqhzP2BXYOMSh3HDaVwU0J0WxJzxyvGnngU8uIMIfDplxf2ZNIB
         8+eQ==
X-Gm-Message-State: AOAM531wp0L//rE7TG1esjKDnQp2PnSlVeSNiyeZJTTvGteLcS3kg5Dr
        zKr80gKA3nfPtmBWMbgS62e4gMdJPS0=
X-Google-Smtp-Source: ABdhPJzI3fdOjvJi6rSKVa4OVIP23IVjo8NUZi2jfEe976T7EWHYlU2C+s4vJR2g6bsltRRGIm3Bbg==
X-Received: by 2002:a5d:47a4:: with SMTP id 4mr18493619wrb.274.1632601950717;
        Sat, 25 Sep 2021 13:32:30 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id a202sm16703279wmd.15.2021.09.25.13.32.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Sep 2021 13:32:30 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     tsbogend@alpha.franken.de
Cc:     robh@kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        Liviu.Dudau@arm.com, bhelgaas@google.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-staging@lists.linux.dev,
        neil@brown.name, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] PCI: Allow architecture-specific pci_remap_iospace()
Date:   Sat, 25 Sep 2021 22:32:22 +0200
Message-Id: <20210925203224.10419-5-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210925203224.10419-1-sergio.paracuellos@gmail.com>
References: <20210925203224.10419-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_remap_iospace() was originally meant as an architecture specific helper
but it moved into generic code after all architectures had the same
requirements. MIPS has different requirements so it should not be shared.

The way for doing this will be using a macro 'pci_remap_iospace' defined
for those architectures that need a special treatment. Hence, put core API
function inside preprocesor conditional code for 'pci_remap_iospace'
definition.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/pci/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ce2ab62b64cf..0ec57bb01a88 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4123,6 +4123,7 @@ unsigned long __weak pci_address_to_pio(phys_addr_t address)
  * architectures that have memory mapped IO functions defined (and the
  * PCI_IOBASE value defined) should call this function.
  */
+#ifndef pci_remap_iospace
 int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
 {
 #if defined(PCI_IOBASE) && defined(CONFIG_MMU)
@@ -4146,6 +4147,7 @@ int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
 #endif
 }
 EXPORT_SYMBOL(pci_remap_iospace);
+#endif
 
 /**
  * pci_unmap_iospace - Unmap the memory mapped I/O space
-- 
2.25.1

