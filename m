Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6E55DB5F5
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 20:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503325AbfJQSWk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 14:22:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38156 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503310AbfJQSWf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Oct 2019 14:22:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id h195so2170075pfe.5
        for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2019 11:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=Vl0993kFOVCbFbBd0f73Vm2bgxp+dYjZuoT4X6x3qbo=;
        b=nLk8WQ6M/i1RttpNO761kmYwJQNLkbQ3KcAyCX3ZwFkCbfbyZC8f2NVTFcOZTjMKaC
         0T1jrWxLh92705bPzggbKG+MisV0hQIka0pNwS/KYHBFFrgxVl8G9HUS8ZRyLJZVRyxo
         yil8GpvjVworm57GJREBJICJ34bOhG7uBiQpKkwDtgtmgQXdXyy5fpLQ+BDQr6NFGxnR
         B+rRWMFEC6FEL4HfB95h9jdptVtAlqM3HD6s68cgRVz6DFUHcS2oPONMuLYZba2UIv5H
         JdS6Dhwr4lNEZhcldwyKbOYzM3iXVDxtD/h5qWK65luZ9xhcKHcgkhndPJ6ZZwKHzfO8
         LYBw==
X-Gm-Message-State: APjAAAXqwdy7xfGS+QHRwKIVh5vexbif9ipbtoVsnf9YO3jFz7xD9szM
        mNbI6+H1xXnBxebndnyaiD5gLg==
X-Google-Smtp-Source: APXvYqynD9rVIS1o3qWTvaQTxl9H6HgwDspwax1m/MNQ8kaTqQ6suPLQuCl8IkuSxv3eFErDBkUQ1g==
X-Received: by 2002:a17:90a:1b49:: with SMTP id q67mr6162405pjq.115.1571336554301;
        Thu, 17 Oct 2019 11:22:34 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id s36sm3153399pgk.84.2019.10.17.11.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 11:22:33 -0700 (PDT)
Subject: [PATCH 3/3] pci: Default to PCI_MSI_IRQ_DOMAIN
Date:   Thu, 17 Oct 2019 11:19:37 -0700
Message-Id: <20191017181937.7004-4-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017181937.7004-1-palmer@sifive.com>
References: <20191017181937.7004-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     tony.luck@intel.com, fenghua.yu@intel.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, bhelgaas@google.com, will@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        kstewart@linuxfoundation.org, pbonzini@redhat.com,
        firoz.khan@linaro.org, yamada.masahiro@socionext.com,
        longman@redhat.com, mingo@kernel.org, peterz@infradead.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>, michal.simek@xilinx.com,
        helgaas@kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As far as I can tell, the only reason there was an architecture
whitelist for PCI_MSI_IRQ_DOMAIN is because it requires msi.h.  I've
built this for all the architectures that play nice with make.cross, but
I haven't boot tested it anywhere.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
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
2.21.0

