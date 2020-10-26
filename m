Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B1B298B25
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 12:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772910AbgJZK7U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 06:59:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46433 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1772825AbgJZK6n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Oct 2020 06:58:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id n6so11856650wrm.13
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2020 03:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5W4UqFTJMoDRzu7XpmV7m/mIx7tbXZK4TFNNVek8jNg=;
        b=KLr497mrTXuUWmZaofaXk1hyxgArLSK5Z8LFA7VwpBwSz2E3+nE1glgvLx0JiQdQzn
         dm5kaVp9H5reVf+JjmNdCZ0s9dozztPh2nQ4nrraI1YOy9mqE/zZOpL+5xkTYVff+uRk
         JdfMqSudDhC/KCWc2IX1OVFNm25KGK/VrwkWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5W4UqFTJMoDRzu7XpmV7m/mIx7tbXZK4TFNNVek8jNg=;
        b=VPGVTYdnxJtpwirjwng0TGYZo/8jGwxKvPLH62MEPA7JEjRM0YdnlfCzWknT0KDnLW
         0vdRuekhp/1KgaISIj6iBqP/nPZKG9tCQxueM3x+mXMB06v/BT38g4YKQd4TnT/Gs8k/
         w+zNjUaFdOoWcGLy3CCVladdqKh8TcPJV9B6oTl/eDCBtjnsCX4jel4vUJ9CYqmdKzTM
         HSA9kL0Z8MdVzN1aVt9k5iAhmZOFOV07PTLm/tKnKb/FjAUSpZle+6Hi4gbNIS9MdZVr
         X5qccoOqrAdIuqrJnvMOiBL/M20dX5oivqO/taBt5CiVM30Cn+2sefT5P5atimDI5wJh
         4zig==
X-Gm-Message-State: AOAM532+WeQAnKrfJih8RQye46AqyETZBy8FAqXoglbcUROJbk1//yeI
        wYzuOWK/n8df5mVKHQKz5D8kQw==
X-Google-Smtp-Source: ABdhPJz2su0SrOVqm3DeypSb7RJN8qc1fEsNaBh1v2aKMDuErJYYfZ5yJi5C/1uI817lBc+Ai9qYTQ==
X-Received: by 2002:adf:f3cb:: with SMTP id g11mr18177850wrp.210.1603709921142;
        Mon, 26 Oct 2020 03:58:41 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id w83sm21165156wmg.48.2020.10.26.03.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 03:58:40 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     kvm@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org,
        linux-s390@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v4 11/15] PCI: Obey iomem restrictions for procfs mmap
Date:   Mon, 26 Oct 2020 11:58:14 +0100
Message-Id: <20201026105818.2585306-12-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026105818.2585306-1-daniel.vetter@ffwll.ch>
References: <20201026105818.2585306-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There's three ways to access PCI BARs from userspace: /dev/mem, sysfs
files, and the old proc interface. Two check against
iomem_is_exclusive, proc never did. And with CONFIG_IO_STRICT_DEVMEM,
this starts to matter, since we don't want random userspace having
access to PCI BARs while a driver is loaded and using it.

Fix this by adding the same iomem_is_exclusive() check we already have
on the sysfs side in pci_mmap_resource().

References: 90a545e98126 ("restrict /dev/mem to idle io memory ranges")
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kees Cook <keescook@chromium.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
--
v2: Improve commit message (Bjorn)
---
 drivers/pci/proc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index d35186b01d98..3a2f90beb4cb 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -274,6 +274,11 @@ static int proc_bus_pci_mmap(struct file *file, struct vm_area_struct *vma)
 		else
 			return -EINVAL;
 	}
+
+	if (dev->resource[i].flags & IORESOURCE_MEM &&
+	    iomem_is_exclusive(dev->resource[i].start))
+		return -EINVAL;
+
 	ret = pci_mmap_page_range(dev, i, vma,
 				  fpriv->mmap_state, write_combine);
 	if (ret < 0)
-- 
2.28.0

