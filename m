Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63CB417CD7
	for <lists+linux-pci@lfdr.de>; Fri, 24 Sep 2021 23:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348536AbhIXVNZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Sep 2021 17:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347078AbhIXVNV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Sep 2021 17:13:21 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B2DC0614ED;
        Fri, 24 Sep 2021 14:11:47 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t8so31254912wrq.4;
        Fri, 24 Sep 2021 14:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I3qu/bakw/8LhQIXjaOEPV5SVnN+1i5mwJzI+2iO/oc=;
        b=XfmVM23a3TZXWTkk8M3V4KnzK7ODNPfeDEzYIrtlcC4fAb5l2Kd3kaOYpjqmcy6Y9A
         h5L295fq+DCQxENcW/PpuACnlSFNi7Y7EvKL35atOfZnC3hMZmWym7Xy5O656ZY2Yr6W
         n19/dOLk6H4BahbETJSPfTYf/mubMDW6nu/nOVqUMkeH+pP9/T2QWlE0CgTS8E1DG8vZ
         PydsndU15zlsBcDGmd9m2NeT2mq3VpF+BqoCsdWvPBFE4RsJ1NUr/ScbLUOvLuXcekBA
         vnF9R9hBxl8lSgXGOLKqSjBz6sKu5nKUlRXcmPAU1zS0juXIUCKiuT11Iyrgzj50JQ4J
         VTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I3qu/bakw/8LhQIXjaOEPV5SVnN+1i5mwJzI+2iO/oc=;
        b=zy5qut06EH2xPUpiqyCJfC6TzdlcxNDvIWqA5zoKbcabiXC5HWU62dRYAempQtle5n
         GX+Nu5EMDJV57C5aY0DDu5WS4/pEAj/8hH+j3UisbYwRKssRW3mRWO42jVy7sh4lVWjP
         V9YmdrvA5hzfFY4Fkb5KGoMnj1yQNNQFloTHzEM0wSKujvteJBnBQ+BkMGQPbJ5gH8IH
         W2vwXIMANSVNholrQ4QGZzmKPgSoE7CMiqWIBg0Sd5raja/wGqhOjp6uu3GbTuXJYagU
         I/N90dWHcSckuEL4pLVgcfWJetA5JrpcB1ioTMTddlt0luxQ9Tm2H+BeoygY4Sy/Ka9n
         SNJA==
X-Gm-Message-State: AOAM533Ng18St/1EZTHTyTQ6Rud+d6luZn4GxLYDcirn0v1gnmeGbKsf
        7DkvoZ2xrfZ0CSmhM2u1Yy+HQ25l2Pw=
X-Google-Smtp-Source: ABdhPJyyg9AbUZb+fEXLr9Lk4DY8+qYFpCQ1iqu6RBGl04PJnjfBWVpkdf90r95BHZlh8KVQMwlk7w==
X-Received: by 2002:adf:ed92:: with SMTP id c18mr13918812wro.86.1632517906559;
        Fri, 24 Sep 2021 14:11:46 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id y64sm10344297wmc.38.2021.09.24.14.11.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Sep 2021 14:11:46 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     tsbogend@alpha.franken.de
Cc:     robh@kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        Liviu.Dudau@arm.com, bhelgaas@google.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-staging@lists.linux.dev,
        neil@brown.name, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] PCI: allow architecture specific implementation of pci_remap_iospace()
Date:   Fri, 24 Sep 2021 23:11:37 +0200
Message-Id: <20210924211139.3477-5-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924211139.3477-1-sergio.paracuellos@gmail.com>
References: <20210924211139.3477-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_remap_iospace() was originally meant as an architecture specific helper,
but it moved into generic code after all architectures had the same requirements.
MIPS has different requirements so it should not be shared. The way for doing
this will be using a macro 'pci_remap_iospace' defined for those architectures
that need a special treatement. Hence, put core api function inside preprocesor
conditional code for 'pci_remap_iospace' definition.

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

