Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89C06DB5F0
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 20:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503312AbfJQSWf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 14:22:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42661 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503305AbfJQSWe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Oct 2019 14:22:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id f14so1807980pgi.9
        for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2019 11:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=DgBlxGGOySK3PLbEB8KobplGmb/95tE64KOi4eUuQBM=;
        b=OuoRmbRd5Brb4bOa+KJONgu47E33OaUmWxD6R3fi07253VF/TvXYdisloB1V/BpX4S
         MsCCbpuYvnycOiSFaiKP32u5/XHu+M5oP5YHL2xKsaN1xhviziBZJP4HZwL8BYE6ewi4
         673IpIK4oYSa5u5eWUD5YEIF35i26IIYZlXLcZTCfL5QjMtDlLI6Y04NhUKGtUYe5S1l
         MzZouP2YGz72xiTQFJMOzZJ+qjbvJrii9cCTfO356PEg9JwTinXLv1vmA3CagXRkZ0Jq
         dy0bkJo7AUZMzYZjwh2oGk9j5MNOG3v4Mr63kwxZs89HqgYuJ8AZTsiUU39GfLzGnBqh
         puvQ==
X-Gm-Message-State: APjAAAW6CsxtZX7J9Jx3psQ/wtbeFOXqfzTn8b+J6+n5dlQOVjq250lg
        Dcz3WrNzmqjtU9CmiteD/+WV4g==
X-Google-Smtp-Source: APXvYqybdVbJNTvuzOcVhsPQif36O+YC/nFlezJzYkDdm19blzh9K6d8ez4kplshP0Xrf/0pwtO9Ew==
X-Received: by 2002:a62:cf42:: with SMTP id b63mr1721635pfg.33.1571336553006;
        Thu, 17 Oct 2019 11:22:33 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id s5sm2751586pjn.24.2019.10.17.11.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 11:22:32 -0700 (PDT)
Subject: [PATCH 2/3] s390: Use the generic msi.h
Date:   Thu, 17 Oct 2019 11:19:36 -0700
Message-Id: <20191017181937.7004-3-palmer@sifive.com>
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

This builds with an s390 defconfig, but I have no access to s390 and
therefor can't even boot test it.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/s390/include/asm/Kbuild | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 2531f673f099..afd35e55b358 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -21,6 +21,7 @@ generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
 generic-y += mmiowb.h
+generic-y += msi.h
 generic-y += trace_clock.h
 generic-y += unaligned.h
 generic-y += word-at-a-time.h
-- 
2.21.0

