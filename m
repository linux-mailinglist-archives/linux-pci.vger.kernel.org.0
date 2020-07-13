Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A4F21D6A9
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbgGMNWj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729873AbgGMNWj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 09:22:39 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43B5C061755;
        Mon, 13 Jul 2020 06:22:38 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p20so17105650ejd.13;
        Mon, 13 Jul 2020 06:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z4DbCQASJpB18XYS7ktJTNc93Wbe31Dke4XqE2e1oq0=;
        b=DOSHDGVmk30fZFiz3WKd7zMCSK69f3jEL1u8AsUJjxB2mBuvUr1qBHCx969bF8n9Q2
         KtbdMAJyAt3EFUnpKPSIMJbXHWkN6pnl/9Tnrb3Gl0n+kYXCTO2h5BNyruT2BHFjgl+g
         wH9iQCx1EI7m7ZrVqhRyZdNkYPv0uZXHNRXI4H3ZgM4nssEF6Z4+vhCyAINKoOna9COA
         2vQ/UXMl3YhqVXxT1k4grDXlx/GMqUZZFWedx8icvuVMGE/cnpL+73qZzJoFpLnQEXqM
         kKNEdCxwfmXyA7RuYT4PGHN4OQXUHW+RCFO60LXxoSfPzZmiOAwLoId6GJoDAnwMnMXf
         6VkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z4DbCQASJpB18XYS7ktJTNc93Wbe31Dke4XqE2e1oq0=;
        b=VGODV6+w8pm3BED+mlkJTkLoiPiT2PQOix909FzobWVuQPJ/ckL+JClUhHHZrN/4Ng
         JKXWFn8iUjL812r/K8SreK1/U8CtRqXLEpQpT9ZEg5CVKuHg4wVRpfoxaxe7ArX/rqtd
         NbAD+iJr8dxnIgRDHrCieUZ0/Xjqabn4AU1NIqdP2bRFwSJeqDiO+9b16kth8JTImsiz
         sxIe9cqF92le73rQT0XeUO72vXpnG2UGw/OiSGJB/yY5gsJSRo7YXox+2JYuYhjlS8tu
         gc9lmSVwCd7kx22nfYBU2MRaA7q+EtNc1ORf5NJS5GxD0ERF1jclBxRgKXHAbypC5VbU
         e17w==
X-Gm-Message-State: AOAM530vhEVApyA+HZEwVHGAue2wJSX3nrd/BFWsX7WoIEx2nZWQHA67
        ITTBn0MuGPSTVEkaNbhCt3U=
X-Google-Smtp-Source: ABdhPJyNJ+2A+7vhlimkJ5sh3qnTf4AmYHcIfFpOxzTngMqwIMgJRuRgZYpxdl6ypR4zISe0e31EHw==
X-Received: by 2002:a17:906:4dd4:: with SMTP id f20mr77154689ejw.170.1594646557469;
        Mon, 13 Jul 2020 06:22:37 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id n9sm11806540edr.46.2020.07.13.06.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:22:37 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [RFC PATCH 01/35] xen-pciback: Change PCIBIOS_SUCCESSFUL to 0
Date:   Mon, 13 Jul 2020 14:22:13 +0200
Message-Id: <20200713122247.10985-2-refactormyself@gmail.com>
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
 drivers/xen/xen-pciback/conf_space.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/xen-pciback/conf_space.c b/drivers/xen/xen-pciback/conf_space.c
index 059de92aea7d..0e7577f16f78 100644
--- a/drivers/xen/xen-pciback/conf_space.c
+++ b/drivers/xen/xen-pciback/conf_space.c
@@ -130,7 +130,7 @@ static inline u32 merge_value(u32 val, u32 new_val, u32 new_val_mask,
 static int xen_pcibios_err_to_errno(int err)
 {
 	switch (err) {
-	case PCIBIOS_SUCCESSFUL:
+	case 0:
 		return XEN_PCI_ERR_success;
 	case PCIBIOS_DEVICE_NOT_FOUND:
 		return XEN_PCI_ERR_dev_not_found;
-- 
2.18.2

