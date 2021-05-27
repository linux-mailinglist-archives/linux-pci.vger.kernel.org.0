Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC1F39368B
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 21:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbhE0Tra (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 15:47:30 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:44882 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbhE0Tr1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 15:47:27 -0400
Received: by mail-ot1-f50.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so1305451otp.11;
        Thu, 27 May 2021 12:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=68t16l/dJX8qwP/jSm8KvVZZuN7st3omJGcvkjXgwLg=;
        b=H7UFJUEpiTJY8aF+3j89y9nL8al1p4ixoggkqDWg20okGE3dDit0W9y2zG6vskbErW
         NICm5jhDqqMLXdeDafN5YVeLOFKcntcTCM2lICN9uv/njVxtdZBAqVYUevNOyYwn4m5F
         qswaZ+cmrHWuFDHct3AhiVymDOt9tPoICQl4GQZWnPIs6N6pJInzm6/ndb0NF8cOw+lF
         oI4EH94ZprKq0sC6VKaNJ55RpxdAiQZ04am5xF6Dvfg5KVy52rM/Wl+hRE+/42JScZ3y
         qGCMdhJdnVgTKtmabU2xEM2fCIxiDmdMJK9YQSwRd3b6xWDdsSw/lmmDTvL+xWFQMmlG
         ji6w==
X-Gm-Message-State: AOAM5311RHXUigbq0otf+FSQEfq70kimMaDPSWKlpFkRFfVnPSEU7Bht
        YYSKwIHGLEiKjAZHJjCPdROe/+biIA==
X-Google-Smtp-Source: ABdhPJwpa9J1YIavtkMQ/XIxRGd/oD4XK0/YAu9s1s+yjaawXnmRb0JNQ0azt198SPfINVzh7aumig==
X-Received: by 2002:a05:6830:2248:: with SMTP id t8mr4078086otd.156.1622144751692;
        Thu, 27 May 2021 12:45:51 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id m74sm665162oig.33.2021.05.27.12.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 12:45:50 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 1/4] PCI: Add empty stub for pci_register_io_range()
Date:   Thu, 27 May 2021 14:45:44 -0500
Message-Id: <20210527194547.1287934-2-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210527194547.1287934-1-robh@kernel.org>
References: <20210527194547.1287934-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add an empty stub for pci_register_io_range() when !CONFIG_PCI. It's needed
to convert of_pci_range_to_resource() to use IS_ENABLED(CONFIG_PCI).

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 include/linux/pci.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index c20211e59a57..29da7598f8d0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1772,6 +1772,10 @@ static inline int pci_request_regions(struct pci_dev *dev, const char *res_name)
 { return -EIO; }
 static inline void pci_release_regions(struct pci_dev *dev) { }
 
+static inline int pci_register_io_range(struct fwnode_handle *fwnode,
+					phys_addr_t addr, resource_size_t size)
+{ return -EINVAL; }
+
 static inline unsigned long pci_address_to_pio(phys_addr_t addr) { return -1; }
 
 static inline struct pci_bus *pci_find_next_bus(const struct pci_bus *from)
-- 
2.27.0

