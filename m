Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456A839DB4F
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 13:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhFGLbL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 07:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhFGLbK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jun 2021 07:31:10 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE46C061766;
        Mon,  7 Jun 2021 04:29:19 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g24so9618304pji.4;
        Mon, 07 Jun 2021 04:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rvzb4qtGRQUWi/ckS9nOcXRKxlM0Wnl5P5x853tHbFI=;
        b=WVWBYvsx5qebQs4uhxeWPTzu+987IycgSJNvyTphaVZrETj044Iw58W6NbDZyHgxse
         r5AwKefCsExOVbY3OQaHaijWhGJm8Bnd3b5eNIibKARMPxmBXDeW4f5d5cyyg9z5I8ZF
         FDXjSJKyFIJRfk/JsSNyibt2LYfBdRNPDxyH9PqyZF7pIrTwge0x9S0P/r9cgwHkA6oQ
         3d6DKAIwRz1+GjxMzI7diW4cIGU7BEajxdieRXURAaE+C5ROu6UCtr3WjkCKLMMEG6FP
         OTOdGOndNHpnmHg8xUpabWofMjMoq1m+VrGTY4DAqSx7dRBD6hqm6PB58wsTlNMIlUVx
         exKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rvzb4qtGRQUWi/ckS9nOcXRKxlM0Wnl5P5x853tHbFI=;
        b=opmalnwmCmsohDuuELLdqtocopjMQyzRUb31DzwRgZxrM4IIz8efgX+exrFKXCDnCJ
         oXUrkWtJBxzOzy+EjXguUg4ZDFCKwmiyq+lz3zWMPfKfQHI7bl08AKE4CA/020qWAYb0
         e3Q1iOG1evNWq28f93/89tVu7IxGU8IX/PWil9IwVE/v8/4u4VoekxOU96HefFyv4c7M
         MbNdSmtTzb7N+z4w4kbP8b1XWuLf+IHWSCH3hbdyy1JttsvXHvSK0IoQYdkX1SIqXi/4
         AnZyHXy+LXGXXbcW9B7Yo1hQTqFvon1Lz1vX1NQ0lYrBjge26XgYUwdErPWZgZLU/pd0
         MvZg==
X-Gm-Message-State: AOAM531g0Ut6uzWMgHxjC4vIxUSZtdoE/MrnU/CX64AtFRZmpe1tZNvN
        8ErAdvFqrlotbWcSOazuiXE=
X-Google-Smtp-Source: ABdhPJzfodVWiIz5t1qZzTiFumpaNqWNvckd2dBZi4kAiT/7o4BeWZ8rJjTxJXM+qOQg/O+SeaBJHA==
X-Received: by 2002:a17:90a:7e84:: with SMTP id j4mr32325306pjl.101.1623065359403;
        Mon, 07 Jun 2021 04:29:19 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id d23sm1725619pjz.15.2021.06.07.04.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 04:29:18 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     helgaas@kernel.org, robh+dt@kernel.org
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, alexandru.elisei@arm.com, wqu@suse.com,
        robin.murphy@arm.com, pgwipeout@gmail.com, ardb@kernel.org,
        briannorris@chromium.org, shawn.lin@rock-chips.com,
        Vidya Sagar <vidyas@nvidia.com>
Subject: [PATCH v3 3/4] PCI: of: Refactor the check for non-prefetchable 32-bit window
Date:   Mon,  7 Jun 2021 20:28:55 +0900
Message-Id: <20210607112856.3499682-4-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210607112856.3499682-1-punitagrawal@gmail.com>
References: <20210607112856.3499682-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Recently, an override was added for non-prefetchable host bridge
windows below 4GB that have the 64-bit address attribute set. As many
of the conditions for the check overlap with the check for
non-prefetchable window size, refactor the code to unify the ranges
validation into devm_of_pci_get_host_bridge_resources().

As an added benefit, the warning message is now printed right after
the range mapping giving the user a better indication of where the
issue is.

Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
Tested-by: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/of.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 38fe2589beb0..0580c654127e 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -355,11 +355,15 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
 			*io_base = range.cpu_addr;
 		} else if (resource_type(res) == IORESOURCE_MEM) {
 			if (!(res->flags & IORESOURCE_PREFETCH)) {
-				if (res->flags & IORESOURCE_MEM_64)
+				if (res->flags & IORESOURCE_MEM_64) {
 					if (!upper_32_bits(range.pci_addr + range.size - 1)) {
 						dev_warn(dev, "Clearing 64-bit flag for non-prefetchable memory below 4GB\n");
 						res->flags &= ~IORESOURCE_MEM_64;
 					}
+				} else {
+					if (upper_32_bits(resource_size(res)))
+						dev_warn(dev, "Memory resource size exceeds max for 32 bits\n");
+				}
 			}
 		}
 
@@ -579,12 +583,6 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
 			break;
 		case IORESOURCE_MEM:
 			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
-
-			if (!(res->flags & IORESOURCE_PREFETCH))
-				if (!(res->flags & IORESOURCE_MEM_64) &&
-				    upper_32_bits(resource_size(res)))
-					dev_warn(dev, "Memory resource size exceeds max for 32 bits\n");
-
 			break;
 		}
 	}
-- 
2.30.2

