Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF227896E
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2019 12:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbfG2KOl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Jul 2019 06:14:41 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40629 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbfG2KOk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jul 2019 06:14:40 -0400
Received: by mail-lf1-f65.google.com with SMTP id b17so41668809lff.7;
        Mon, 29 Jul 2019 03:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BsIPSvfzLwnhnLKtcEHLG5y6k186GA8GW/6JbbfPnA4=;
        b=Bs6UPJ5AGBfzGCDu1yTlLyiAGy/axf7R5AP8BquIYDJcIDHfPQbNs/uxxXOtgdqbrT
         +x4q2VfquCtIdRSMCV14uxsQAqELm2Erq/3evaRSL659fACwYgGrjEb2m0f3V5qHjxsA
         554SEssPzLAnrI/ZnRBvOiJ7KMl+GJS5UKoM8hUiC84MxbRkiEehEdbJ/7mAJwvmPxj9
         2yzdv9if5oTGUUdVDKdt8mGyek6cOPJ3a+fdLPViRpnFA3+WGBVEEQIdUti/uzOIMijx
         gKdnym3hmSPhbbE6fuekglwfmvEqHi4HAPUrltBn9JYEe8y/VH85uevVtvrWndfgFs3S
         gsVQ==
X-Gm-Message-State: APjAAAVO4XS41fsfxEqFx6QDMyvU3qizS2GaFpA5fDXOaG+B0W6PkbrB
        5j9RYEhs0IiXdV70ZZfEfmk=
X-Google-Smtp-Source: APXvYqxAitsCCS/HFPR7uHO4tOhzGp6jjCagTQ9NCr3/Ull+T3hU8+UpiyoxWae7OFM9Qe0aQhN3uA==
X-Received: by 2002:ac2:5492:: with SMTP id t18mr53096046lfk.41.1564395278677;
        Mon, 29 Jul 2019 03:14:38 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id y12sm11814834lfy.36.2019.07.29.03.14.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 03:14:38 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] powerpc/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
Date:   Mon, 29 Jul 2019 13:14:00 +0300
Message-Id: <20190729101401.28068-5-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729101401.28068-1-efremov@linux.com>
References: <20190729101401.28068-1-efremov@linux.com>
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

