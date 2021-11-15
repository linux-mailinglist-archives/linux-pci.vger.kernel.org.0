Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63C644FF09
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 08:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhKOHLk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 02:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhKOHLL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 02:11:11 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F64AC061767;
        Sun, 14 Nov 2021 23:08:15 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id u18so28579310wrg.5;
        Sun, 14 Nov 2021 23:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2enovZIIcSmPlNGyWYjv9MRu60VM0WFrzLKPmZYvVq8=;
        b=TP1oegk8MO7vn/JpI1EZbFq0jyItHaBbpcq+KibGdAYo2USrzCi+sPLGrem4PBibOA
         9epbY2V5snO3T1z+jhtYqxWiiOKN61k//lirgQvgMqZ3culHra1q7OK7fLsRfNTUUUYB
         rDL3zWegFiYCDD7sex54QvRUhaYUs0v316LRtgBbno76Jtc4Yw7m0cw6HcyiYW5aDUAk
         dZRnE+wauHjEiJ1g4ehpYbfheX9+qFPu6rq+uitOJBiy/vbvmwzNRAC+2vrFkbWqLIY1
         vGqDFh1ksmuyWjcVW+asiI3bP2Rk3EFcik5YGBTyHEEqBvBJuIy0OCSsVY4fahzyoVMN
         lq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2enovZIIcSmPlNGyWYjv9MRu60VM0WFrzLKPmZYvVq8=;
        b=1HS5cC+/l9Cqs2LOx0KHuykRDfoE6y84EfPoAUp0PWqMTIwv5dvFnRiPj6mdUYVnFm
         JlSk+Op79pj81P2mUki65fG4Qkh1m1Rwu1ep5KxdKM858/lX4XKLMRPLTM8Ez/jn95qT
         6yf9JDhpLY9Y1XUGvozaoOwY9tDXRUtkTAZwU7Om++FqOeupo5pB3wq+tT+2Lt8jpeGM
         nSwA+06xHNMKNT4XiRWawsXZX8jdI3NFXjepAm4K9uwqFga4jMOJxEwA6pTxpP9O5Eb2
         N4xdH0r8dNAJ2tHYMF4sCIOsf1b5/qM+BJKLbT0eNi0KsEOb/Eo9nuY4AO6gAlEG/ELy
         SXPw==
X-Gm-Message-State: AOAM532PWYnt/f4tPHY9P4CletVkvOEQ/JtDZnsoODfecj1/z52K5rli
        I4OiSB27fR9s6CyHxkqFyUx6JnPknlA=
X-Google-Smtp-Source: ABdhPJzOpMw/ACQzOto7XTcR6932CmD0Xu4aOf3mtKMnok2YYZZdOhULXNVxmW5h4fAM4rjxo2AXbg==
X-Received: by 2002:a05:6000:1862:: with SMTP id d2mr44337344wri.203.1636960093571;
        Sun, 14 Nov 2021 23:08:13 -0800 (PST)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id d6sm13301079wrx.60.2021.11.14.23.08.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Nov 2021 23:08:13 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] MIPS: ralink: implement 'pcibios_root_bridge_prepare()'
Date:   Mon, 15 Nov 2021 08:08:06 +0100
Message-Id: <20211115070809.15529-3-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211115070809.15529-1-sergio.paracuellos@gmail.com>
References: <20211115070809.15529-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI core code call 'pcibios_root_bridge_prepare()' function inside function
'pci_register_host_bridge()'. This point is very good way to properly enter
into this MIPS ralink specific code to properly setup I/O coherency units
with PCI memory addresses.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/ralink/mt7621.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
index bd71f5b14238..7649416c1cd7 100644
--- a/arch/mips/ralink/mt7621.c
+++ b/arch/mips/ralink/mt7621.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
 #include <linux/memblock.h>
+#include <linux/pci.h>
 
 #include <asm/bootinfo.h>
 #include <asm/mipsregs.h>
@@ -22,6 +23,35 @@
 
 static void *detect_magic __initdata = detect_memory_region;
 
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	struct resource_entry *entry;
+	resource_size_t mask;
+
+	entry = resource_list_first_type(&bridge->windows, IORESOURCE_MEM);
+	if (!entry) {
+		pr_err("Cannot get memory resource\n");
+		return -EINVAL;
+	}
+
+	if (mips_cps_numiocu(0)) {
+		/*
+		 * FIXME: hardware doesn't accept mask values with 1s after
+		 * 0s (e.g. 0xffef), so it would be great to warn if that's
+		 * about to happen
+		 */
+		mask = ~(entry->res->end - entry->res->start);
+
+		write_gcr_reg1_base(entry->res->start);
+		write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
+		pr_info("PCI coherence region base: 0x%08llx, mask/settings: 0x%08llx\n",
+			(unsigned long long)read_gcr_reg1_base(),
+			(unsigned long long)read_gcr_reg1_mask());
+	}
+
+	return 0;
+}
+
 phys_addr_t mips_cpc_default_phys_base(void)
 {
 	panic("Cannot detect cpc address");
-- 
2.33.0

