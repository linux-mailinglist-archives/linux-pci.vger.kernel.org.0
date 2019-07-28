Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B94C97817D
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jul 2019 22:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfG1UXt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Jul 2019 16:23:49 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46070 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfG1UXt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Jul 2019 16:23:49 -0400
Received: by mail-lf1-f67.google.com with SMTP id u10so1801425lfm.12;
        Sun, 28 Jul 2019 13:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BsIPSvfzLwnhnLKtcEHLG5y6k186GA8GW/6JbbfPnA4=;
        b=BSYcIs5Spv817zvYqy/Z3cak3ty5rFTrxCdPynBN/QvkVtdU7Qp3ZZxSwYVrFaybvg
         SV6XEfehFoqYdelYf2AP14eTLX+YXmsMzTY0BWjVT47IV+TlYdgwuUZOugHUZE6W2cDr
         kobpD87gVTqD5XyJWrBcxFk1+i9oy6Gh7leromRR/pxJiBJNyj8vJvROcTMTZafAlRLj
         tCtSuuXT7eY9g91xfeEoPRgbS7TzrGUsCzQ2T7zeCX2EwM0FNgYKJMXIMZ6nBG1c8RPL
         r4sN5E9DAuOnP3hn4mYvbvhQdHqaIoMNMTZ/Zo2r319bNAx6f0nw3wrAZRUc7FTFzMun
         xBtQ==
X-Gm-Message-State: APjAAAVLW2Lzy0goiHa3fMOc4dWWTApcIQjfDSqTslUCabPxdxVBYXx9
        wo/2e2PqDVTQVK8MCba5mD4/VQIQyxo=
X-Google-Smtp-Source: APXvYqw+FfN4FqOrzqV25HilzNIKewdHvXu1E1uzSsxYeRi5FpYLNX73c0xiyl7PEEJ+jfoA5/3UQA==
X-Received: by 2002:ac2:4202:: with SMTP id y2mr15335884lfh.178.1564345426848;
        Sun, 28 Jul 2019 13:23:46 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id z17sm12395917ljc.37.2019.07.28.13.23.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 13:23:46 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] powerpc/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
Date:   Sun, 28 Jul 2019 23:22:12 +0300
Message-Id: <20190728202213.15550-5-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190728202213.15550-1-efremov@linux.com>
References: <20190728202213.15550-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The function pci_resource_to_user() was turned to a weak one. Thus,
powerpc-specific version will automatically override the generic one
and the HAVE_ARCH_PCI_RESOURCE_TO_USER macro should be removed.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 arch/powerpc/include/asm/pci.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 2372d35533ad..327567b8f7d6 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -112,8 +112,6 @@ extern pgprot_t	pci_phys_mem_access_prot(struct file *file,
 					 unsigned long size,
 					 pgprot_t prot);
 
-#define HAVE_ARCH_PCI_RESOURCE_TO_USER
-
 extern resource_size_t pcibios_io_space_offset(struct pci_controller *hose);
 extern void pcibios_setup_bus_devices(struct pci_bus *bus);
 extern void pcibios_setup_bus_self(struct pci_bus *bus);
-- 
2.21.0

