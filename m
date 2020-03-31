Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9CFE19A20F
	for <lists+linux-pci@lfdr.de>; Wed,  1 Apr 2020 00:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbgCaWss (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Mar 2020 18:48:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38134 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbgCaWss (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Mar 2020 18:48:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id w3so8748681plz.5
        for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2020 15:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=PzUxe8ko8vz1S1g23peXxZLjPYDb7Lz9ppyXcN8eAuw=;
        b=naBdxTbYLPllr28JdItkaY0txWH0NLxTtGo3sh2eGsw+cz3uQyPl0Rsi5YuCe3zC3n
         /LjqrIyB3giSCzTCcFxs5fgLLyqdBLvBw5eADih+f0RBO5P7a/Y1gptbORl9Fw4GpXM/
         HGix4fz7zBuR/ljJV/EGs+BpM9ME0/2894ssYuRyFcc8JUpk3snOJRGxCEG6mF0aw5/l
         l0d1UAXbQtMLcJczthPZbiwElkHwkbF6yJMAvN1WTWD8cbLpuB1Yt1geMxMslVzr+c8j
         Oky0l46dkr+bnWjx6KSXfhPvrD+CN7pXrLHIv3NYoDxCd41QZjC6x7fVv5R8+lVD8nx6
         QriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PzUxe8ko8vz1S1g23peXxZLjPYDb7Lz9ppyXcN8eAuw=;
        b=KbTdelMj/Jb9vr1CXiBOlYfZL2OJJN64j9/otDD9+hU0jo7l1lN+YehzeagMvvYhqM
         4Fzz1gGqufDSI/fl3d2txF1QkcY8XuxWjp4Dr8wr+JwMP26YssJYPHkQ7TnnWdJCz/fW
         UGfC7i6Jhks5U1luGiPLLRIvo6APOk6dUjSYO+ydH+d412bijs5C+ZpKOV/6UxjMgNWo
         s4YAdcvVve/g0RpSr3NDQ6aE+5QjV+ReYj/uGnAx8ZFV7qW9qT3P69og//3Z6cBNMQBv
         M7x6RkUTPvc8JbZKlhZLuIIjj4GgVo3AFh3cG9eGEG6IA+Nq9Tlt0+zweXK3kT+KxRNw
         APSA==
X-Gm-Message-State: AGi0PuY3qOxEbMdQwcNn9uHl3vMGTA5vWubUPgS/e5WDY0j38Clrvwwq
        zwKeEBUG0BZkeIWjQcVzI6l9oQ==
X-Google-Smtp-Source: APiQypJkW7S7TSzizhePr+uNfJv4g9bpFLpYHxkuFM8tDqrRgnbYrww+BeK6AofGL9Oa3dGYvTx6Ww==
X-Received: by 2002:a17:902:8546:: with SMTP id d6mr9102382plo.280.1585694927175;
        Tue, 31 Mar 2020 15:48:47 -0700 (PDT)
Received: from nuc7.sifive.com (c-24-5-48-146.hsd1.ca.comcast.net. [24.5.48.146])
        by smtp.gmail.com with ESMTPSA id k14sm158906pfg.15.2020.03.31.15.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Mar 2020 15:48:46 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, amurray@thegoodpenguin.co.uk,
        bhelgaas@google.com, kishon@ti.com, paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH v2] PCI: dwc: Warn MEM resource size exceeds max for 32-bits
Date:   Tue, 31 Mar 2020 15:48:35 -0700
Message-Id: <1585694915-32005-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alan Mikhak <alan.mikhak@sifive.com>

Output a warning for MEM resource size with non-zero upper 32-bits.

ATU programming functions limit the size of the translated region to 4GB
by using a u32 size parameter. Function dw_pcie_prog_outbound_atu() does
not program the upper 32-bit ATU limit register. These issues may result
in undefined behavior for resource sizes with non-zero upper 32-bits.

For example, a 128GB address space starting at physical CPU address of
0x2000000000 with size of 0x2000000000 needs the following values
programmed into the lower and upper 32-bit limit registers:
 0x3fffffff in the upper 32-bit limit register
 0xffffffff in the lower 32-bit limit register

Currently, only the lower 32-bit limit register is programmed with a
value of 0xffffffff but the upper 32-bit limit register is not being
programmed. As a result, the upper 32-bit limit register remains at its
default value after reset of 0x0.

This would be a problem for a 128GB PCIe space because the internal
calculation of the limit address in ATU programming functions in effect
reduces the size to 4GB. This may also produce undefined behavior since
the ATU limit address may be lower than the ATU base address.

This limitation also means that multiple ATUs would need to be used to
map larger regions.

ATU programming functions may be changed to specify a u64 size parameter
for the translated region. Along with this change, the internal
calculation of the limit address, the address of the last byte in the
translated region, needs to change such that both the lower 32-bit and
upper 32-bit limit registers can be programmed correctly.

Without change, this issue can go unnoticed. A warning may prompt the
user to look for possible issues.

Changing the ATU programming functions impacts all PCIe drivers that
depend on dwc which seem to be currently happy with the u32 size limit.
A solution that allows existing PCIe drivers to phase into the fix on
their own individual schedules, if they need to, may be desirable.

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 395feb8ca051..df5ebe02ffca 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -325,6 +325,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	struct pci_bus *child;
 	struct pci_host_bridge *bridge;
 	struct resource *cfg_res;
+	resource_size_t mem_size;
 	u32 hdr_type;
 	int ret;
 
@@ -362,7 +363,10 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		case IORESOURCE_MEM:
 			pp->mem = win->res;
 			pp->mem->name = "MEM";
-			pp->mem_size = resource_size(pp->mem);
+			mem_size = resource_size(pp->mem);
+			if (upper_32_bits(mem_size))
+				dev_warn(dev, "MEM resource size exceeds max for 32 bits\n");
+			pp->mem_size = mem_size;
 			pp->mem_bus_addr = pp->mem->start - win->offset;
 			break;
 		case 0:
-- 
2.7.4

