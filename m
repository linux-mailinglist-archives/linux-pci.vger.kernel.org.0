Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113E83A724D
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 01:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhFNXHV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Jun 2021 19:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhFNXHV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jun 2021 19:07:21 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B365C061574;
        Mon, 14 Jun 2021 16:05:07 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id 69so7440991plc.5;
        Mon, 14 Jun 2021 16:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uI8GRrOkWXIHHLv8r7qKkxBwgPnYUOcjRvPdHqWD4ps=;
        b=rIkD169VDnBACSkXPY0G2Zk1l23ZofUXwzC5flEBLONQW4gUDe3lVYa+7ijxkzNgi/
         LHweR7YNRaOsa/c4wyfVstKtkpt+gT6n2hqAKOO4TyFyHsM6vDFcngbquFQ3bs5Or8K5
         zZZYGQiY51m3Odu3SdsoffuiUbnmvAUizEM8dBWo/m7Q3G246Fell0rVMcPOE0AxReMr
         6MgvJHnXbbt+muUAqZnjP+aeq/snjew6FZMriAYteGHXyG/yuezdZt8l1PHZC7yEefkU
         1jFfOufhIOwS/zlV/mH8gCxIjfzWMcLBBUiXDMk56QT9yKfZlC8cfw3ZCQzbRmQ/HM0H
         qpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uI8GRrOkWXIHHLv8r7qKkxBwgPnYUOcjRvPdHqWD4ps=;
        b=DbcFDxADhJcaiTtMWGTJxLq/HE/iXH8wTYxLznTUJcvcfbYzxZZH85Tq+JCynjtRyK
         H8Fr76U6qRbbYQwN8mpTFQXpYsXDQmOHUpQZStwGyzuxpLR91YaK/Nv2dRs0LrGeJlkK
         EdTW3FJF1tjvKzjLLJiAv9bw3LXBeRMz39cryb5oPxv3qt/IrYBUF4HNSj8fgRfjL/9L
         Yodka5GOFoiB4ODKSzAAfgU+tsN7z8AIDwyOfgPtblzCiQnorvOdKD6BLKV4ZKzjB83W
         YXYlAe0WhXOSitJWl/X27+UdKnwqiZgCERvp55QMmy5WCraTZLzNZGAvqT2DCSTr0Lv0
         Z9+Q==
X-Gm-Message-State: AOAM530cUB+grsnlGYO8yKhuMFHAbQx2PMiyji3opms/aPUD/CVUyMEb
        VtXEgPLgmJvGBlYrsMV4euc=
X-Google-Smtp-Source: ABdhPJzg8KsUbzwKhuSnQL4vAg8Cqd9ly/sJEWLKr/f6XxXTEN/bXW0dhln72jFXwqiU8fQp2AR1dw==
X-Received: by 2002:a17:90a:b284:: with SMTP id c4mr2552593pjr.213.1623711903029;
        Mon, 14 Jun 2021 16:05:03 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id v15sm14404504pgf.26.2021.06.14.16.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 16:05:01 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     helgaas@kernel.org, robh+dt@kernel.org
Cc:     Punit Agrawal <punitagrawal@gmail.com>, maz@kernel.org,
        leobras.c@gmail.com, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, alexandru.elisei@arm.com, wqu@suse.com,
        robin.murphy@arm.com, pgwipeout@gmail.com, ardb@kernel.org,
        briannorris@chromium.org, shawn.lin@rock-chips.com,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v4] PCI: of: Clear 64-bit flag for non-prefetchable memory below 4GB
Date:   Tue, 15 Jun 2021 08:04:57 +0900
Message-Id: <20210614230457.752811-1-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Alexandru and Qu reported this resource allocation failure on
ROCKPro64 v2 and ROCK Pi 4B, both based on the RK3399:

  pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff 64bit]
  pci 0000:00:00.0: PCI bridge to [bus 01]
  pci 0000:00:00.0: BAR 14: no space for [mem size 0x00100000]
  pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]

"BAR 14" is the PCI bridge's 32-bit non-prefetchable window, and our
PCI allocation code isn't smart enough to allocate it in a host
bridge window marked as 64-bit, even though this should work fine.

A DT host bridge description includes the windows from the CPU
address space to the PCI bus space.  On a few architectures
(microblaze, powerpc, sparc), the DT may also describe PCI devices
themselves, including their BARs.

Before 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource
flags for 64-bit memory addresses"), of_bus_pci_get_flags() ignored
the fact that some DT addresses described 64-bit windows and BARs.
That was a problem because the virtio virtual NIC has a 32-bit BAR
and a 64-bit BAR, and the driver couldn't distinguish them.

9d57e61bf723 set IORESOURCE_MEM_64 for those 64-bit DT ranges, which
fixed the virtio driver.  But it also set IORESOURCE_MEM_64 for host
bridge windows, which exposed the fact that the PCI allocator isn't
smart enough to put 32-bit resources in those 64-bit windows.

Clear IORESOURCE_MEM_64 from host bridge windows since we don't need
that information.

Fixes: 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-bit memory addresses")
Reported-at: https://lore.kernel.org/lkml/7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com/
Reported-by: Alexandru Elisei <alexandru.elisei@arm.com>
Reported-by: Qu Wenruo <wqu@suse.com>
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh+dt@kernel.org>
---
Hi,

The patch is an updated version to fix the PCI allocation issues on
RK3399 based platforms. Previous postings can be found at [0][1][2].

The updated patch instead of clearing the 64-bit flag for
non-prefetchable memory below 4GB does it unconditionally on the basis
that PCI allocation logic cannot deal with the 64-bit flag (although
it should be able to). The result is a simpler patch that restores the
input to the allocation logic to be identical to before 9d57e61bf723.

Tested locally on a RockPro64 on top of v5.13-rc6. Please consider
merging.

Thanks,
Punit

Changes:
v4:

* Updated Patch 1 based on Bjorn's suggestion. Also dropped the
  Tested-by tags due to the change of logic
* Dropped patch 2 and 3 from the series as it's not critical to the
  series
* Dropped the device tree changes (Patch 4) as they are already queued
  in the soc tree

v3:
* Improved commit log for clarity (Patch 1)
* Added Tested-by tags

v2:
* Check ranges PCI / bus addresses rather than CPU addresses
* (new) Restrict 32-bit size warnings on ranges that don't have the 64-bit attribute set
* Refactor the 32-bit size warning to the range parsing loop. This
  change also prints the warnings right after the window mappings are
  logged.

[0] https://lore.kernel.org/linux-arm-kernel/20210527150541.3130505-1-punitagrawal@gmail.com/
[1] https://lore.kernel.org/linux-pci/20210531221057.3406958-1-punitagrawal@gmail.com/
[2] https://lore.kernel.org/linux-pci/20210607112856.3499682-1-punitagrawal@gmail.com/

 drivers/pci/of.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 85dcb7097da4..a143b02b2dcd 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -353,6 +353,8 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
 				dev_warn(dev, "More than one I/O resource converted for %pOF. CPU base address for old range lost!\n",
 					 dev_node);
 			*io_base = range.cpu_addr;
+		} else if (resource_type(res) == IORESOURCE_MEM) {
+			res->flags &= ~IORESOURCE_MEM_64;
 		}
 
 		pci_add_resource_offset(resources, res,	res->start - range.pci_addr);
-- 
2.30.2

