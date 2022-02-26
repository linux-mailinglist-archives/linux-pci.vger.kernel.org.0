Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4514C5853
	for <lists+linux-pci@lfdr.de>; Sat, 26 Feb 2022 22:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiBZVhn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Feb 2022 16:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiBZVhn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Feb 2022 16:37:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515783EB8C;
        Sat, 26 Feb 2022 13:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=2kClNZTivm3jKSQ6n+6qZG8dQzwRaZEt11W1hUuE1O0=; b=hZzmh5x0LH97OUL05aNA4CDznl
        jusc41jKszt+3ruoWVme3RMiKXkBsnPbtTxMIUIWjyPOw/e+xSPrlyiSQ5x2EzyL1vNkhID175fFp
        vMvr+z+hFQrxvCeyAFL5bKuMbP03WB8Kq2nuoB1lj6b62CjGu01rqwhPjPjSe9TMpRNZcIgUXT4Bv
        9jWFwDul1LKqQZUll7plM7cdGeKxCamV9tXq315xQDN7CVrfWfTlJKPGFD+tOur+ltM4e2z/vd+0a
        9q7Y8OzCqJS5/oYmUuXEGKtr8DCMMjhPuU0jEtne4HDIXQbOt+jk2k9fdqBtUNMFZIf7uhcfmNCL/
        Bs4kY6nw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nO4kT-008Ybp-Vj; Sat, 26 Feb 2022 21:37:06 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH -next?] x86: PCI: asm/pci_x86.h needs more #includes
Date:   Sat, 26 Feb 2022 13:37:03 -0800
Message-Id: <20220226213703.24041-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

<asm/pci_x86.h> uses EINVAL, __init, and raw_spinlock_t, so it
should #include the appropriate files to prevent build errors.

../arch/x86/include/asm/pci_x86.h:150:10: error: ‘EINVAL’ undeclared (first use in this function)
  return -EINVAL;

../arch/x86/include/asm/pci_x86.h:105:8: error: unknown type name ‘raw_spinlock_t’
 extern raw_spinlock_t pci_config_lock;

../arch/x86/include/asm/pci_x86.h:141:20: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or ‘__attribute__’ before ‘dmi_check_pciprobe’
 extern void __init dmi_check_pciprobe(void);

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: linux-pci@vger.kernel.org
---
Without this patch, I am seeing *many* build errors in
linux-next-20220225.

I don't know why this showed up in linux-next-20220225 all of a
sudden.

 arch/x86/include/asm/pci_x86.h |    3 +++
 1 file changed, 3 insertions(+)

--- linux-next-20220225.orig/arch/x86/include/asm/pci_x86.h
+++ linux-next-20220225/arch/x86/include/asm/pci_x86.h
@@ -5,7 +5,10 @@
  *	(c) 1999 Martin Mares <mj@ucw.cz>
  */
 
+#include <linux/errno.h>
+#include <linux/init.h>
 #include <linux/ioport.h>
+#include <linux/spinlock.h>
 
 #undef DEBUG
 
