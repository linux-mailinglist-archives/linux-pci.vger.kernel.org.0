Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1447C21D6D9
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbgGMNYE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbgGMNXU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 09:23:20 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64C8C061794;
        Mon, 13 Jul 2020 06:23:19 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id z17so13652904edr.9;
        Mon, 13 Jul 2020 06:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8wbmK+ya6vHJSgI+MTiDhQKWZMMzmthLgMh2OY4MZvM=;
        b=n80txyCowMGw0agwpHO34CYMBjnaTUgBZm0NF31BEIRCoPc1JqzuQF5NChyyvnmjJv
         EUpvNZnOiq6UM7e6uY2eMEmBZq65ptv7RYBcTij58bTpkCJzq0njvYzGReCEwrmNV5RI
         5gtzm53oXNXlrL6ExBGPj0YysnmlxyLW4c9ytpXGynG/qwDZkUmE2y1FObO5mcUV0L/0
         wXMj7CkivYgSB0vhRcKAC9l7aIrh8DGiSAPr8YYTB/t+l2Pe9+0FjBbrXbqkKWATAoxQ
         Kl2j3veZd4XTP+PnTPMw3T8UA5mOfMyZf+oQlFVmZaEyzIH8DysrASAyAUCQ0M2aVWw3
         3lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8wbmK+ya6vHJSgI+MTiDhQKWZMMzmthLgMh2OY4MZvM=;
        b=t3sfUcvwZ7unvGUAFVq0G4zRb4pzfT0WTom9ypUUzGY0V8lyTxVrR4X9Qq+JP2U0vJ
         0UxEnkiGGcqzN4tF65oSXneoEQo5Kkw3x5yIHD9xW9d1hXzIFHu4URin6QCOUKxUpnz9
         fUbiA8h6xiQ+9FzxpLsOuYd5xCCWtuSw/07ePXUhM6ctzcqgUmwT4wka9EZKlv+EAMMz
         Zm5Sxq8aDrXsc4XgG5gOXiptfJZub/sb19Hj3OKV4ZGyiGHr1xIeQoiG/wxovDA7kORq
         vxrJA2UNOzct72xK7EKpdBWH/1mKxSu2v9QPxmGcTdWIdhrtzvYD0sPf1uwu5SGsY8Et
         j6Yw==
X-Gm-Message-State: AOAM532+rzb7izcMAhVlokfpSk0XmOj+d4K+Qk4V/rg91LfNIPHl5OMG
        UXKHDc2DRRM1ajSvxmUPAnc=
X-Google-Smtp-Source: ABdhPJy+Hs7Ue1IFdlNyMdXk8xV3FtdPl2STdVdjCaLLSaMCCO1/ac6jRmx114IfgaO4SRqNDdJKtg==
X-Received: by 2002:a05:6402:1ca6:: with SMTP id cz6mr70531295edb.171.1594646598609;
        Mon, 13 Jul 2020 06:23:18 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id n9sm11806540edr.46.2020.07.13.06.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:23:18 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: [RFC PATCH 31/35] m68k: Change PCIBIOS_SUCCESSFUL to 0
Date:   Mon, 13 Jul 2020 14:22:43 +0200
Message-Id: <20200713122247.10985-32-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200713122247.10985-1-refactormyself@gmail.com>
References: <20200713122247.10985-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In reference to the PCI spec (Chapter 2), PCIBIOS* is an x86 concept.
Their scope should be limited within arch/x86.

Change all PCIBIOS_SUCCESSFUL to 0

Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
---
 arch/m68k/coldfire/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/coldfire/pci.c b/arch/m68k/coldfire/pci.c
index 84eab0f5e00a..ecd11a19487a 100644
--- a/arch/m68k/coldfire/pci.c
+++ b/arch/m68k/coldfire/pci.c
@@ -64,7 +64,7 @@ static int mcf_pci_readconfig(struct pci_bus *bus, unsigned int devfn,
 
 	if (bus->number == 0) {
 		if (mcf_host_slot2sid[PCI_SLOT(devfn)] == 0)
-			return PCIBIOS_SUCCESSFUL;
+			return 0;
 	}
 
 	addr = mcf_mk_pcicar(bus->number, devfn, where);
@@ -86,7 +86,7 @@ static int mcf_pci_readconfig(struct pci_bus *bus, unsigned int devfn,
 
 	__raw_writel(0, PCICAR);
 	__raw_readl(PCICAR);
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int mcf_pci_writeconfig(struct pci_bus *bus, unsigned int devfn,
@@ -96,7 +96,7 @@ static int mcf_pci_writeconfig(struct pci_bus *bus, unsigned int devfn,
 
 	if (bus->number == 0) {
 		if (mcf_host_slot2sid[PCI_SLOT(devfn)] == 0)
-			return PCIBIOS_SUCCESSFUL;
+			return 0;
 	}
 
 	addr = mcf_mk_pcicar(bus->number, devfn, where);
@@ -118,7 +118,7 @@ static int mcf_pci_writeconfig(struct pci_bus *bus, unsigned int devfn,
 
 	__raw_writel(0, PCICAR);
 	__raw_readl(PCICAR);
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static struct pci_ops mcf_pci_ops = {
-- 
2.18.2

