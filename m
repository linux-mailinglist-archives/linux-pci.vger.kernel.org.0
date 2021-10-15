Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E900242F5ED
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 16:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240633AbhJOOqW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 10:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbhJOOqV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 10:46:21 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AB3C061570;
        Fri, 15 Oct 2021 07:44:15 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id m26so8556643pff.3;
        Fri, 15 Oct 2021 07:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FA4eEA0vKwb58YOkbLP9K2NVmJYtwGLqPjb+iaCxg5k=;
        b=WRjdWN38D6pmIz2/eZS7kZpgxON4LRg1nj1/L5q1P46XY1xU9gmCLz7v3Z1dom5rzl
         +WQEdkj/O22XjHY6DAWhTFUhRU12KIbbRjefhHurp4DhcVlL1TlElgkS5Gx2fgUw9t4Q
         hQS9VLRLx+DJvw/Agp6G1JvNmT43lWpoGtuhQoy5cAw9KDLRNtAlP99Z4ETNvMHBD9Hg
         vc30U0TeuXD+spXiWoWOiGWeFjPKGiPZvriG3s9bNY6Tn1A/NWF0/tkrQJxAuxAc+Le9
         oemYmYUCjs51o8j/mNARaXeUstnlx3pDVfKdltZbHEuJLjmub2e6DdPdVYBnDdLBhA1Q
         zeIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FA4eEA0vKwb58YOkbLP9K2NVmJYtwGLqPjb+iaCxg5k=;
        b=ovROcr4uo+WR83wAVJCdNGJ/4jRhxaPCwzDZb0huGqLMH/Agtj8oRiAxN9n8cmPp8j
         ov4sjJk6uPr7j9lXv280QDolUm/1wYmPvg/FqKt9fnRfWiIvyZcUHDD38gP7TPQ4Mzs2
         9dP0LNi1vmXXyeZQJk90k6Ry6XVO5qSpD4ek9aBam2AGMR/jeyNAXCaV6fD5GmK6n5Zh
         Joy1S+In3pZ4W3yPHASijv+VaU6UpejJjamu5VeLVh3SrhBb4ZYiPCIfAQIfC9+D67nW
         A2+Fso7urSw7rUq0Mcla+plm4G0KqWV9sSS5eiUsgJkXx0FqbzyMAh9jRCK4msOFwFmg
         Cc/g==
X-Gm-Message-State: AOAM533jFrnPz81cJoL8Sl/UZ+vqbXIJXVkchNUAPgqvBXYSf2//uss0
        Bbv8zswqQfyZJV+vedhq3Mw=
X-Google-Smtp-Source: ABdhPJy9gAeFO1KCBbB9jEMGT9fOvRLbnY90aYjBiUI8stEFqE4IDvUss1uiWo/zNMza2tzsWujscQ==
X-Received: by 2002:a63:e243:: with SMTP id y3mr9615900pgj.101.1634309054683;
        Fri, 15 Oct 2021 07:44:14 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:4806:9a51:7f4b:9b5c:337a])
        by smtp.gmail.com with ESMTPSA id f18sm5293491pfa.60.2021.10.15.07.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:44:14 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH v2 09/24] PCI: histb: Remove redundant error fabrication when device read fails
Date:   Fri, 15 Oct 2021 20:08:50 +0530
Message-Id: <42d789c39ff42b123f67f330e6e15ce26047ea3c.1634306198.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634306198.git.naveennaidu479@gmail.com>
References: <cover.1634306198.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error. There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

The host controller drivers sets the error response values (~0) and
returns an error when faulty hardware read occurs. But the error
response value (~0) is already being set in PCI_OP_READ and
PCI_USER_READ_CONFIG whenever a read by host controller driver fails.

Thus, it's no longer necessary for the host controller drivers to
fabricate any error response.

This helps unify PCI error response checking and make error check
consistent and easier to find.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/controller/dwc/pcie-histb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index 86f9d16c50d7..410555dccb6d 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -127,10 +127,8 @@ static int histb_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
 
-	if (PCI_SLOT(devfn)) {
-		*val = ~0;
+	if (PCI_SLOT(devfn))
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	*val = dw_pcie_read_dbi(pci, where, size);
 	return PCIBIOS_SUCCESSFUL;
-- 
2.25.1

