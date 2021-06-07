Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E20039DB57
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 13:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhFGLcK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 07:32:10 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:35368 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhFGLcK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jun 2021 07:32:10 -0400
Received: by mail-pg1-f181.google.com with SMTP id o9so10743155pgd.2;
        Mon, 07 Jun 2021 04:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YCToNP4lwbo49RVCOfoWUbLA0lZuEyfjkp0b5XCIINA=;
        b=nI5Q01rIet4WeJW9GCi/1goLl90w/OB7zL9RMrdqmXVkYdnYtyK8GQBLIExcFjRexR
         /TNYbgs7tuinG3wCB2uo6ILPXzgoLaKrsRkRjbi2c9jP0VBHblYzx3CLt0sfXMZblxtb
         KQCA7eflorikpmtnDLhTsQr1HCJ/hueB8uiDQGPtiT0w6YcGMiWFWBWuUT/owIL9ioBA
         sIjX8YcWX6tG0nMwu+NGC7/wiSAa2HJe7dMbhCOC/gtgLQWNjFbgt98vYvd8gNIidMLc
         HmCcnN0MfXsBlj0ya9YnFDYuuK3jCak/H/A2V0FTN98wJsWRA3nZbgBz1WDhfBEuEL9G
         3uHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YCToNP4lwbo49RVCOfoWUbLA0lZuEyfjkp0b5XCIINA=;
        b=WxI/PoG8eSxxeHokcSbYxJUdR86EhnYi41aFMTxgtEzb15HGdIHJfWqBxU60fYqcj8
         vY2F6EsO5oEwUawcudJriFBbkvZ6JO7R1ylPdsM8HOI2MaSLhvsoYd5IIdj3dV+lBUHf
         8aj4zPMpht36juk4TA18qKNrB+p3BtaVVDeOs0JhbkAnLN0xfBZxKW6kLVfAjmqf0Idi
         68mspzFEEF5P66T7TJMvitOss0rrZrpp93cJ72UA3JbFHDRjIZmnteHJUjtme1L6Lhcy
         Uuw0nE51FWRD64Mn/2V/tUKfFo4/XyQWDgo+pLmKVYYzgJMYgT1hmnAqKCq3bzfFy/gH
         F5pQ==
X-Gm-Message-State: AOAM533hxOKJyysr/w+lrm0gkmDvVnAWEddkdRJf23fqQJZ8YivPUHf8
        kwS5rBf1E9J1hDaXK7jVjAU=
X-Google-Smtp-Source: ABdhPJx0kIhVcKMkYM8J/nN6t7I96Ryv12N586HazWMrF66vgSMvWCBoKF26ggQsOxOptM4bhMf5cg==
X-Received: by 2002:a62:860a:0:b029:2ec:81e1:23e4 with SMTP id x10-20020a62860a0000b02902ec81e123e4mr15672830pfd.11.1623065348506;
        Mon, 07 Jun 2021 04:29:08 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id c130sm7919370pfc.51.2021.06.07.04.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 04:29:08 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     helgaas@kernel.org, robh+dt@kernel.org
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, alexandru.elisei@arm.com, wqu@suse.com,
        robin.murphy@arm.com, pgwipeout@gmail.com, ardb@kernel.org,
        briannorris@chromium.org, shawn.lin@rock-chips.com,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 1/4] PCI: of: Clear 64-bit flag for non-prefetchable memory below 4GB
Date:   Mon,  7 Jun 2021 20:28:53 +0900
Message-Id: <20210607112856.3499682-2-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210607112856.3499682-1-punitagrawal@gmail.com>
References: <20210607112856.3499682-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some host bridges advertise non-prefetchable memory windows that are
entirely located below 4GB but are marked as 64-bit address memory.

Since commit 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource
flags for 64-bit memory addresses"), the OF PCI range parser takes a
stricter view and treats 64-bit address ranges as advertised while
before such ranges were treated as 32-bit.

A PCI root port modelled as a PCI-to-PCI bridge cannot forward 64-bit
non-prefetchable memory ranges. As a result, the change in behaviour
due to the commit causes failure to allocate 32-bit BAR from a 64-bit
non-prefetchable window.

In order to not break platforms where non-prefetchable memory ranges
lie entirely below 4GB, clear the 64-bit flag.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com
Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
Tested-by: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh+dt@kernel.org>
---
 drivers/pci/of.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 85dcb7097da4..1e45186a5715 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -353,6 +353,14 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
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

