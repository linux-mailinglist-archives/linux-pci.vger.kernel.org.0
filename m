Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6AAD497A
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2019 22:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfJKUvk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Oct 2019 16:51:40 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46111 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfJKUvk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Oct 2019 16:51:40 -0400
Received: by mail-oi1-f195.google.com with SMTP id k25so9113592oiw.13;
        Fri, 11 Oct 2019 13:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zrEgjwTXu2e1AK4KY5c5H2BpvKoCQ9sDkx7vQ3qZ69U=;
        b=f5+owO0poH7hdM2zrY8pY7qeT//OgD/2pdSy6KXiI11ZSs9McjDAA3rknePxFeDhsT
         OAA23OYQHcd/QPqemc7gz4VDW5XCjIqgr+612Ua8xqiTj23gS4vGRbWEYx6jV60Ls+3B
         c0Mn3F2vN72EZfRrdP24inkbv1sGinwgcwzuUUTq2TO6awp01LSsF+6OIHN4pKr6tVy+
         +dTUaUDChX1ocONaDx3a4V6u/NYq0zwg3FzzzhGm9WEivW2TzGLLlleUTSRzgQ9sawA5
         6+HNKriAIT0lZSc90lsGH/SBbnxzO6SvhWSxAW3Ehnx7hU1VgYwCqCpPtmWPe7Vc79DM
         DI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zrEgjwTXu2e1AK4KY5c5H2BpvKoCQ9sDkx7vQ3qZ69U=;
        b=VvxmUjoV1D7bK7H8Z5MxU+37sPpqEr/6OarIu8J4NhbrzFgvKVYqLuhqSNnzELxKIk
         v3HW4fLB6sax3kvxZBKmKYT0YPbpjfqawRXRCY+6h/I6Q6OZZXiFUhb4spjLfFk6RzoE
         6I7XKCIvkVn8QLbWwa6gz/GsQ2aoP6wSMVY0ttWSQcWl58JjGLMR6aazPo317r8B/dG6
         NLe7r9VIVeLhzNIefnplVF/4Z95z0YWgL0GCJX0Uyj+wDlPXQ1RQMZBTas1o7nqFqKmq
         pmPjrFCT6mNl7RRBzDGg6Vv9zFNrkq8P8TfbVKexc6jLrhhz5PleBcEr3yJIr4gYFmdF
         w2uQ==
X-Gm-Message-State: APjAAAV3nEqzN+Q6rIuddnYneO7exrhuLCN7KROMHOD3SSHqI6raV/fo
        ILQeXVUaDbhBdEv1+QoZYz8=
X-Google-Smtp-Source: APXvYqygwyh+a1e7EywDD/FeWLqzc0RvoWAsGDCGgiibEfCFmr6X0kiDX5NyFwDKUFEZWY9x+DSejg==
X-Received: by 2002:aca:1207:: with SMTP id 7mr13519089ois.168.1570827099671;
        Fri, 11 Oct 2019 13:51:39 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id i5sm2900875otk.10.2019.10.11.13.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 13:51:38 -0700 (PDT)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v2 0/3] PCI: pciehp: Do not turn off slot if presence comes up after link
Date:   Fri, 11 Oct 2019 16:51:24 -0400
Message-Id: <20191011205127.4884-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In older PCIe specs, PDS (presence detect) would come up when the
"in-band" presence detect pin connected, and would be up before DLLLA
(link active).

In PCIe 4.0 (as an ECN) and in PCIe 5.0, there is a new bit to show if
in-band presence detection can be disabled for the slot, and another bit
that disables it--and a recommendation that it should be disabled if it
can be. In addition, certain OEMs disable in-band presence detection
without implementing these bits.

This means it is possible to get a "card present" interrupt after the
link is up and the driver is loaded.  This causes an erroneous removal
of the device driver, followed by an immediate re-probing.

This patch set defines these new bits, uses them to disable in-band
presence detection if it can be, waits for PDS to go up if in-band
presence detection is disabled, and adds a DMI table that will let us
know if we should assume in-band presence is disabled on a system.

The first two patches in this set come from a patch set that was
submitted but not accepted many months ago by Alexandru Gagniuc [1].
The first is unmodified, the second has the commit message and timeout 
modified.

[1] https://patchwork.kernel.org/cover/10909167/
    [v3,0/4] PCI: pciehp: Do not turn off slot if presence comes up after link

v2:
- modify loop in pcie_wait_for_presence to do..while

Alexandru Gagniuc (2):
  PCI: pciehp: Add support for disabling in-band presence
  PCI: pciehp: Wait for PDS if in-band presence is disabled

Stuart Hayes (1):
  PCI: pciehp: Add dmi table for in-band presence disabled

 drivers/pci/hotplug/pciehp.h     |  1 +
 drivers/pci/hotplug/pciehp_hpc.c | 45 +++++++++++++++++++++++++++++++-
 include/uapi/linux/pci_regs.h    |  2 ++
 3 files changed, 47 insertions(+), 1 deletion(-)

-- 
2.18.1

