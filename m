Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51BB396991
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jun 2021 00:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhEaWNX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 May 2021 18:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhEaWNW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 May 2021 18:13:22 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9770FC061574;
        Mon, 31 May 2021 15:11:41 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 133so4183477pgf.2;
        Mon, 31 May 2021 15:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ObJnk/4SRS5pFYp9Ryi74xRKcVKBz9rodsuAFbTAcF0=;
        b=NuJwoNvOCmk/TUqCGSOTXCu34DL22xBUfOL8NrOsw1RgI/+bcANwngaNNpF4xJlPXF
         D+PxMKt4B9NxIOiarz7Ot+QbC2klai1lJSIATiUarbkqxsBh520zgml0OBdVrQkoAWO+
         5vorZt7+wtyWfLVNvxGig+Hv/w/FdEiwBbhSFK7IN7TJPbjYBojzS6Bfrzcqr0iAb18s
         OqH0OJjweH9z00GiMKHC6mi6TMgz68VkYUivsIoHzgFypCRHt88aCFSi+0zMjR07BUmQ
         oO0Eqr7/b5ZdBOKmcxmWt7G0agsGvhKZtrhLdetVWcwPa1m8vOqGV0NinCq/r9no4pRt
         uZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ObJnk/4SRS5pFYp9Ryi74xRKcVKBz9rodsuAFbTAcF0=;
        b=hq8re+HlgDOfyCmDMAZz65ZB0o9ArTC/uWqXHzz/CbCWdldiVa7yPoJAEgszFoCvNT
         is06qkO/U9o9IL21rjQ+hovuHmoHdbBb6/oVC3F8sBLTdC4o+iOmOOtde/xm7eN+16T2
         av2cVzvVSG11zdJZ2Bq7uF+efE1P/0hUB39Nz2HRMaNQonWF1JuCmLCGNinzxrdYhMeg
         2mQnPAujpX08+cmMsZTFNa1XcXo6CnOm4LRuXUVmbVAPbjPUoaw6K+Ui9uKFgwhh8FSn
         lsRjY8bSGlFqdnJEisdmspglgtcbTbkqSrUnv/09j3eY/pkNCjTBxj9u2tl99mAz2oEO
         nKWw==
X-Gm-Message-State: AOAM5334lyD+2yd0ja34a6BeP8ml7iwFiigT+ss/4imFt+KpmTxqXv99
        8hb8B2/ivi+atSbLWLvd8gA=
X-Google-Smtp-Source: ABdhPJyM6MZ78Cel4rzoNBtZsG5ANMUhigCb2ZFgVsujzRfnVOIzCkaz6aJHGBVbCnCg/2LjYhHZhw==
X-Received: by 2002:a65:64c8:: with SMTP id t8mr5505003pgv.96.1622499100960;
        Mon, 31 May 2021 15:11:40 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id z6sm12604823pgp.89.2021.05.31.15.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 15:11:40 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexandru.elisei@arm.com, wqu@suse.com, robin.murphy@arm.com,
        pgwipeout@gmail.com, ardb@kernel.org, briannorris@chromium.org,
        shawn.lin@rock-chips.com, helgaas@kernel.org, robh+dt@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 1/4] PCI: of: Override 64-bit flag for non-prefetchable memory below 4GB
Date:   Tue,  1 Jun 2021 07:10:54 +0900
Message-Id: <20210531221057.3406958-2-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210531221057.3406958-1-punitagrawal@gmail.com>
References: <20210531221057.3406958-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some host bridges advertise non-prefetable memory windows that are
entirely located below 4GB but are marked as 64-bit address memory.

Since commit 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource
flags for 64-bit memory addresses"), the OF PCI range parser takes a
stricter view and treats 64-bit address ranges as advertised while
before such ranges were treated as 32-bit.

A PCI host bridge that is modelled as PCI-to-PCI bridge cannot forward
64-bit non-prefetchable memory ranges. As a result, the change in
behaviour due to the commit causes allocation failure for devices that
require non-prefetchable bus addresses.

In order to not break platforms, override the 64-bit flag for
non-prefetchable memory ranges that lie entirely below 4GB.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com
Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh+dt@kernel.org>

Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
---
 drivers/pci/of.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index da5b414d585a..e2e64c5c55cb 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -346,6 +346,14 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
 				dev_warn(dev, "More than one I/O resource converted for %pOF. CPU base address for old range lost!\n",
 					 dev_node);
 			*io_base = range.cpu_addr;
+		} else if (resource_type(res) == IORESOURCE_MEM) {
+			if (!(res->flags & IORESOURCE_PREFETCH)) {
+				if (res->flags & IORESOURCE_MEM_64)
+					if (!upper_32_bits(range.pci_addr + range.size - 1)) {
+						dev_warn(dev, "Clearing 64-bit flag for non-prefetchable memory below 4GB\n");
+						res->flags &= ~IORESOURCE_MEM_64;
+					}
+			}
 		}
 
 		pci_add_resource_offset(resources, res,	res->start - range.pci_addr);
-- 
2.30.2

