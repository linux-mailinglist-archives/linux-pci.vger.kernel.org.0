Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09312387228
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 08:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346656AbhERGoP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 May 2021 02:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346662AbhERGoO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 May 2021 02:44:14 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC0CC06175F
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 23:42:57 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ep16-20020a17090ae650b029015d00f578a8so991417pjb.2
        for <linux-pci@vger.kernel.org>; Mon, 17 May 2021 23:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dhey+gEpzKL8h8pP3jKcbtrIWfO9mRaRLZrTGjSACw0=;
        b=OzRbULE97gDu+nJm+2W1/NzhhkCj0QCTZrsqxU76qn+vtZGLqcb+w1igoYylLgqZMK
         FNrnT45xuk38fTuKCy3r98pZ9JUuUor+pLXJzBOrMy0zAumHGMSv3m5XekoY/RuTIkUO
         rl+4b1wiByTGqcgiDzKrnenCWuMAxjCqA3MzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dhey+gEpzKL8h8pP3jKcbtrIWfO9mRaRLZrTGjSACw0=;
        b=my0pu802iW5TaCU7aEEB8bh9l8bFk5eL9FxNcQScP13f0gs9ihuKp29sJ7s+nVTNSL
         b6wsGcLG8Fb2IXgoBvfRaWSgTNE5vyR08dOtbY2I8nSJ4nFWSkLdZ2YwtOOxMvl1ioNR
         PLA+5nS4Qige1egeoJlM1sXKLok4jKiBURnv2qnrC37rAjYocHqmf94ctUk0/FePfOjI
         J84LzYm6iWXhpZJedtWd9I83SuQGt2/Ho8gXr21YtAkP1vkAKrOeU3sCwWrGHPdp++Sc
         ffCXXO4THasibFZtiT9nvj2MYoHeverSFKM6TuEkIJHSw5JFYJ3FT+3q04T9jV0kWfkX
         95/A==
X-Gm-Message-State: AOAM530+9CrjbquwS2aYYGyEQpOKTunPtpAti51VaDrnq79fcDK78NvV
        prmflC7bPdFzN2xw3BbuAMNaIQ==
X-Google-Smtp-Source: ABdhPJzAlI3Jj1VfPflg9N5+BlUFXyQH4Z87PXO5YBjAsPmi6ozdOqhZFzyDTIlkjmaywaEzQdXtCA==
X-Received: by 2002:a17:90b:1d8f:: with SMTP id pf15mr3521801pjb.164.1621320176785;
        Mon, 17 May 2021 23:42:56 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:f284:b819:54ca:c198])
        by smtp.gmail.com with UTF8SMTPSA id o7sm7726182pgs.45.2021.05.17.23.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 23:42:56 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        sstabellini@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        grant.likely@arm.com, xypron.glpk@gmx.de,
        Thierry Reding <treding@nvidia.com>, mingo@kernel.org,
        bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>, tfiga@chromium.org,
        bskeggs@redhat.com, bhelgaas@google.com, chris@chris-wilson.co.uk,
        tientzu@chromium.org, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, jxgao@google.com,
        joonas.lahtinen@linux.intel.com, linux-pci@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, matthew.auld@intel.com,
        rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com
Subject: [PATCH v7 03/15] swiotlb: Add DMA_RESTRICTED_POOL
Date:   Tue, 18 May 2021 14:42:03 +0800
Message-Id: <20210518064215.2856977-4-tientzu@chromium.org>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
In-Reply-To: <20210518064215.2856977-1-tientzu@chromium.org>
References: <20210518064215.2856977-1-tientzu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a new kconfig symbol, DMA_RESTRICTED_POOL, for restricted DMA pool.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 kernel/dma/Kconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 77b405508743..3e961dc39634 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -80,6 +80,20 @@ config SWIOTLB
 	bool
 	select NEED_DMA_MAP_STATE
 
+config DMA_RESTRICTED_POOL
+	bool "DMA Restricted Pool"
+	depends on OF && OF_RESERVED_MEM
+	select SWIOTLB
+	help
+	  This enables support for restricted DMA pools which provide a level of
+	  DMA memory protection on systems with limited hardware protection
+	  capabilities, such as those lacking an IOMMU.
+
+	  For more information see
+	  <Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt>
+	  and <kernel/dma/swiotlb.c>.
+	  If unsure, say "n".
+
 #
 # Should be selected if we can mmap non-coherent mappings to userspace.
 # The only thing that is really required is a way to set an uncached bit
-- 
2.31.1.751.gd2f1c929bd-goog

