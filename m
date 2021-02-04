Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5201E30F925
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 18:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238204AbhBDRH6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 12:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238279AbhBDRAH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2021 12:00:07 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BB0C061794
        for <linux-pci@vger.kernel.org>; Thu,  4 Feb 2021 08:58:41 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id f16so3734949wmq.5
        for <linux-pci@vger.kernel.org>; Thu, 04 Feb 2021 08:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pjpQViTnfy9zJdPT1OTcZQSZ/SAyjWhVVtQHP1tzBRY=;
        b=Cp4q0GJhHnTgtCNs+BZulRpkv3QXkbb/WQaLNMMiMqwCyKhuSmH0qBjFkaq9MdZ9G0
         BlZsCQfEDn10zMPOMNE7h7wWcT2r55JmPCa+IrCt8f1zR+Aoj93uBi7Rg63nKXGV8rqw
         //pnEscML6TZjEoyQPRfdcvm9DHGnovVBhmYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pjpQViTnfy9zJdPT1OTcZQSZ/SAyjWhVVtQHP1tzBRY=;
        b=Rk375zpiausaO5Tal4NQP7IoC2CYsdQOFghMXHJiYV1qIvOSMNRzTC9ox+EqKXSeSt
         3l+NXmHYNlBt6Pzd4s0LUIVnPjq8cEqA5c4M9EzZlLeAPPqiQCPq5jCW57RZg9iVV5GQ
         9E4cqhb9NC/3PD22SV3etpSHGO1oJ6nrYfSOg7OAAkMKDj4zfIYCR5WBGJB8/JZiHL0B
         zawDK2JAz0qS6dBClxl9A2vCI5TtRi/JcUCzTaa0QOi6TnUN0R3abJQ/WGaPMab/dEjc
         n79zIfOaNM4AKbLTDzvQYJdCyxYQOGreOhb8h2hFVGymdNi22uxzQ7NUtD3tXdk+Dzqg
         wJXA==
X-Gm-Message-State: AOAM531leyVWAFclfRQMc9+DyrkfGxIss2BNTGhIP8fxlrGN/YkbdVYN
        KkHgXX8/8hh5ZL8M5yB/cYX7tA==
X-Google-Smtp-Source: ABdhPJy8cnJj8F6Ag9Gxf2AKhAzvgIg7hnrZS4RA2dE5wOIAaxWEfSPZw52Fw61cA8TEtv0XmB3Xew==
X-Received: by 2002:a1c:7217:: with SMTP id n23mr68437wmc.183.1612457920134;
        Thu, 04 Feb 2021 08:58:40 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id i64sm6700187wmi.19.2021.02.04.08.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 08:58:39 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH 1/2] PCI: also set up legacy files only after sysfs init
Date:   Thu,  4 Feb 2021 17:58:30 +0100
Message-Id: <20210204165831.2703772-2-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210204165831.2703772-1-daniel.vetter@ffwll.ch>
References: <20210204165831.2703772-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We are already doing this for all the regular sysfs files on PCI
devices, but not yet on the legacy io files on the PCI buses. Thus far
now problem, but in the next patch I want to wire up iomem revoke
support. That needs the vfs up an running already to make so that
iomem_get_mapping() works.

Wire it up exactly like the existing code. Note that
pci_remove_legacy_files() doesn't need a check since the one for
pci_bus->legacy_io is sufficient.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kees Cook <keescook@chromium.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/pci-sysfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index fb072f4b3176..0c45b4f7b214 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -927,6 +927,9 @@ void pci_create_legacy_files(struct pci_bus *b)
 {
 	int error;
 
+	if (!sysfs_initialized)
+		return;
+
 	b->legacy_io = kcalloc(2, sizeof(struct bin_attribute),
 			       GFP_ATOMIC);
 	if (!b->legacy_io)
@@ -1448,6 +1451,7 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 static int __init pci_sysfs_init(void)
 {
 	struct pci_dev *pdev = NULL;
+	struct pci_bus *pbus = NULL;
 	int retval;
 
 	sysfs_initialized = 1;
@@ -1459,6 +1463,9 @@ static int __init pci_sysfs_init(void)
 		}
 	}
 
+	while ((pbus = pci_find_next_bus(pbus)))
+		pci_create_legacy_files(pbus);
+
 	return 0;
 }
 late_initcall(pci_sysfs_init);
-- 
2.30.0

