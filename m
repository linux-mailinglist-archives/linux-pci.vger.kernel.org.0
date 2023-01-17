Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F033966DA4F
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jan 2023 10:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbjAQJuV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Jan 2023 04:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbjAQJuT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jan 2023 04:50:19 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6438517170
        for <linux-pci@vger.kernel.org>; Tue, 17 Jan 2023 01:50:18 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ss4so66740655ejb.11
        for <linux-pci@vger.kernel.org>; Tue, 17 Jan 2023 01:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nSMMJbna904D/HY34WkPwGeNj/vI3mpAT3YuSUunxOw=;
        b=m+cSvVlOsZYulX+mufMjkwbBCn193mhWufNoHSjOP2xLiadxvbEQ8y0CB+XYDTYHin
         WGdsi+KMrcO+RHbqzflKz+jO+t5lPbzzNXwmrevqgWITZwoWZvlLJXRAklG4kVwvwVc9
         0q5SiIdIFY4hGyZqIbRSg+J2Ny56hvFw94navQhKbhYyihRrRavrfsoOwx5wYW1Dd8Hw
         o+hiCKuAtyDcLXQ0mN3qUlSN7uPdk0jS8OyiopHZd2M6qT8MEeLFwe/8+nVS9sc2fT1x
         MQfPZTeMxUkv92d8bQOrc8Ox2SIDZIL27CCMucSjIuKihAzwHsh4oLpvy2s6pnnHyoEc
         LtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nSMMJbna904D/HY34WkPwGeNj/vI3mpAT3YuSUunxOw=;
        b=NmxivdV0P26vYvMOknF0doNeIe399d1pHNXaZ7P9kpdc321qysIabobIpHwlwRLl80
         zX00YoJBsoCcWjikI2ZkY5UEgzOrTC+ALSxSrs1oWe36xVOnDSQz5fK60zLjbb8ysYlH
         32d9k3JVx2xYnmR70nTqJzjygN1GbePpIs/ESuBPyY+3DW/L0Cjlr84WuIGXwaKJlcr7
         qBRrBEjj24KFdk52WxliZJE1JmnCgF9Knf7HixuWPTFM+zQRZrUxHIJ156Y/1kMuDcDe
         JIwJ7sFFCBMY+uEPMA/63sMePe3gBxNPQ3YulESV1MeiyGNdhhOA1HF8gWFXHSg4+7gy
         WtkA==
X-Gm-Message-State: AFqh2kosO9y2hEE6NyypFTvvvJzuKWGv8l8Imaxq4tmqpzHTfx7YvY+B
        Eci54Y0JnZeoTx2Es/c2g6lipETkjbYVk2ZwgKY=
X-Google-Smtp-Source: AMrXdXs0GswGSCPsa0/AJL/Ql0WStZ7vNPwUgOCyhTuvnjaUux9fJgCRCabqUfoQTqAuIv5bKh6oE9ePZo8bsbP3Cxw=
X-Received: by 2002:a17:907:c98a:b0:86d:9435:5d1f with SMTP id
 uj10-20020a170907c98a00b0086d94355d1fmr145878ejc.570.1673949016825; Tue, 17
 Jan 2023 01:50:16 -0800 (PST)
MIME-Version: 1.0
References: <20230111092911.8039-1-adrianhuang0701@gmail.com> <20230111155833.GA1668483@bhelgaas>
In-Reply-To: <20230111155833.GA1668483@bhelgaas>
From:   Huang Adrian <adrianhuang0701@gmail.com>
Date:   Tue, 17 Jan 2023 17:50:05 +0800
Message-ID: <CAHKZfL1PPo=fyukj8UA5=m4TUSjFiUj65wC4FmU6w-XW1mJyqw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PCI: vmd: Avoid acceidental enablement of window
 when zeroing config space of VMD root ports
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Adrian Huang <ahuang12@lenovo.com>,
        Jon Derrick <jonathan.derrick@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 11, 2023 at 11:58 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> s/acceidental/accidental/ in subject

Thanks. Sorry for the fat-finger error.

> > When memset_io() clears prefetchable base 32 bits register, the
> > prefetchable memory becomes 0000000000000000-575000fffff, which is enabled.
> > This behavior (accidental enablement of window) causes that config accesses
> > get routed to the wrong place, and the access content of PCI configuration
> > space of VMD root ports is 0xff after invoking memset_io() in
> > vmd_domain_reset():
>
> I was thinking the problem was only between clearing
> PCI_PREF_MEMORY_BASE and PCI_PREF_BASE_UPPER32, but that would be a
> pretty small window, and you're seeing a lot of config accesses going
> wrong.  Why is that?  Is there enumeration that races with this domain
> reset?

Well, I didn't see the races. The problem is that: memset_io() uses
enhanced REP STOSB, fast-string operation or legacy method (see
arch/x86/lib/memset_64.S) to *sequentially* clear the memory location
from lower memory location to higher one. When clearing at
PCI_PREF_BASE_UPPER32, the prefetchable memory window is accidentally
enabled. The subsequent accesses (each read returns 0xff, and each
write does not take any effect) cannot be made correctly. In this
case, clearing at PCI_PREF_LIMIT_UPPER32 cannot take any effect. So,
we're unable to configure VMD devices anymore for subsequent writes.

Here are the test codes for emulating memset_io(), and they are 4-byte
writes. The issue can be reproduced:

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 769eedeb8802..e27e2a0f68e0 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -526,8 +526,15 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
                                     PCI_CLASS_BRIDGE_PCI))
                                        continue;

-                               memset_io(base + PCI_IO_BASE, 0,
-                                         PCI_ROM_ADDRESS1 - PCI_IO_BASE);
+                               writel(0, base + PCI_IO_BASE);
+                               writel(0, base + PCI_MEMORY_BASE);
+                               writel(0, base + PCI_PREF_MEMORY_BASE);
+
+                               writel(0, base + PCI_PREF_BASE_UPPER32);
+                               writel(0, base + PCI_PREF_LIMIT_UPPER32);
+
+                               writel(0, base + PCI_IO_BASE_UPPER16);
+                               writel(0, base + PCI_CAPABILITY_LIST);
                        }
                }
        }


The following test codes can fix the issue (clear
PCI_PREF_LIMIT_UPPER32 firstly):

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 769eedeb8802..b9140e081793 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -526,8 +526,15 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
                                     PCI_CLASS_BRIDGE_PCI))
                                        continue;

-                               memset_io(base + PCI_IO_BASE, 0,
-                                         PCI_ROM_ADDRESS1 - PCI_IO_BASE);
+                               writel(0, base + PCI_IO_BASE);
+                               writel(0, base + PCI_MEMORY_BASE);
+                               writel(0, base + PCI_PREF_MEMORY_BASE);
+
+                               writel(0, base + PCI_PREF_LIMIT_UPPER32);
+                               writel(0, base + PCI_PREF_BASE_UPPER32);
+
+                               writel(0, base + PCI_IO_BASE_UPPER16);
+                               writel(0, base + PCI_CAPABILITY_LIST);


> I guess the same problem occurs with PCI_IO_BASE/PCI_IO_BASE_UPPER16,
> but maybe there's no concurrent I/O port access?

For the general case, how about the following code snippets?

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 769eedeb8802..e29e33f7b70e 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -499,6 +499,19 @@ static inline void vmd_acpi_begin(void) { }
 static inline void vmd_acpi_end(void) { }
 #endif /* CONFIG_ACPI */

+static inline void vmd_clear_cfg_space(char __iomem *base, int start, int end)
+{
+       int i;
+
+       /*
+        * Clear PCI configuration space from higher memory location
+        * to lower one. This prevents from enabling IO window or
+        * prefetchable memory window if it is disabled initially.
+        */
+       for (i = end - 1; i >= start; i--)
+               writeb(0, base + i);
+}
+
 static void vmd_domain_reset(struct vmd_dev *vmd)
 {
        u16 bus, max_buses = resource_size(&vmd->resources[0]);
@@ -526,8 +539,8 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
                                     PCI_CLASS_BRIDGE_PCI))
                                        continue;

-                               memset_io(base + PCI_IO_BASE, 0,
-                                         PCI_ROM_ADDRESS1 - PCI_IO_BASE);
+                               vmd_clear_cfg_space(base, PCI_IO_BASE,
+                                                       PCI_ROM_ADDRESS1);
                        }
                }
        }


-- Adrian
