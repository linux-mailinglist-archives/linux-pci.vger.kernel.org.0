Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA5D5DB5F7
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 20:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503306AbfJQSWp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 14:22:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41231 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503288AbfJQSWc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Oct 2019 14:22:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id t3so1815221pga.8
        for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2019 11:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=2KT/1Ua4Ne08bIcLoxtdMsARQdKvdiD630BlGhWeLtw=;
        b=WiyD9wrMewk1bCixmcryiXhlClNvfNp4VyOFw4YtPVwgbO728G03De9Rlez8om1rlR
         SNK1h0z6J1x6htUKhwaP0fZIsXLXHh24C+Fqr1TrIbCIGBtwppcSISlO+KSJIqGm1XAQ
         Dn8QvqXCW/kjAkn67ogIeHQciKaAEvoTKPpV7hErN4ct7tiRVfXXOLxabqzbuNRilbzw
         dvVlZA/tRcWiqeVD3EcAfOk5L0vTBGXLZKuSCAXdDVdpA2RL/vZh9vCYqJcjxe8OKDo6
         mPGyMoXPOJMo7BOloFuA1a+ic1eaCXC1ZKjeRGzwvUeLehDY38/raz8ryUgr1eWE4UTx
         PypA==
X-Gm-Message-State: APjAAAU7UHhCRWdD3zU+tcnk6wPUDSEq52EBJ69qQ+YYhnhBOoFK5lPj
        Pi7F8pUd3qLH7y17JECzqQtWJQ==
X-Google-Smtp-Source: APXvYqzRFMnoGzdJ2pTmCdShwyvvireoh2sq3hfvaMP0TW/8NOqgFYu+GU8GpPpVrwDdC5UWEBAmzA==
X-Received: by 2002:a63:5423:: with SMTP id i35mr5812604pgb.128.1571336551338;
        Thu, 17 Oct 2019 11:22:31 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id u5sm4007226pfl.25.2019.10.17.11.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 11:22:30 -0700 (PDT)
Subject: [PATCH 1/3] ia64: Use the generic msi.h
Date:   Thu, 17 Oct 2019 11:19:35 -0700
Message-Id: <20191017181937.7004-2-palmer@sifive.com>
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

Without this I can't enable PCI_MSI_IRQ_DOMAIN, which as far as I can
tell only depends on generic functionality provided by msi.h.
PCI_MSI_IRQ_DOMAIN has historically had a whitelist of supported
architectures, but that list is getting long enough that it's cleaner to
just enable it everywhere.

This builds with an ia64 defconfig, but I have no access to ia64 and
therefor can't even boot test it.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/ia64/include/asm/Kbuild | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/ia64/include/asm/Kbuild b/arch/ia64/include/asm/Kbuild
index 390393667d3b..22d6dbefa7d7 100644
--- a/arch/ia64/include/asm/Kbuild
+++ b/arch/ia64/include/asm/Kbuild
@@ -6,6 +6,7 @@ generic-y += irq_work.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
+generic-y += msi.h
 generic-y += preempt.h
 generic-y += trace_clock.h
 generic-y += vtime.h
-- 
2.21.0

