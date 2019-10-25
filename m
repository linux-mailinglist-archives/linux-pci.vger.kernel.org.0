Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDD6E5408
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2019 21:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfJYTBA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Oct 2019 15:01:00 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42287 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfJYTBA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Oct 2019 15:01:00 -0400
Received: by mail-ot1-f65.google.com with SMTP id b16so2750215otk.9;
        Fri, 25 Oct 2019 12:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VfUSTJ+CU/raJUgvpABIWAsUKPhwmRFpmIxXtGCq+QQ=;
        b=LqCYpFfPjS5grxXUwXw1Do+4sZOZvZZFfjHo0SMYARbqLlPidPDignCPF6C1MgsfpR
         nIEvBq7iqksGypHnlfIa1CfWKpqtOTSrd30VHS17JC1u+mehe1xEWr3q9Ch4lvTbJEHD
         a4ikOn6a4rspqE2UhW5x9JlgM3BA3uiFvqosS6S0EVuXjWej4tgVmvfLKNw1M1gXSvYu
         TGJX77u78Qyc9D2LwNAxsE1OVLO/bEsa0qjQUMa1i72/K5eOQJQ4Bz4xfQ1E+wb9DqrC
         5y+gGWp2u6rkSYnRrCYWBoC7QFAoHfrouyVpNchu24U6NhkAiRa8Xke1vCkkFMOPJyen
         I5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VfUSTJ+CU/raJUgvpABIWAsUKPhwmRFpmIxXtGCq+QQ=;
        b=HbkYQjl9cmb1AUHg+/6W+/ioj2TTJNRbR8UmWA5MhH90gdIQZooI25tpXcC8VvrIHG
         rn2Hxog/6hg94v8o49T9P99t88LdMhaE1WhQd6PMcFl+YE0V9grYNC+MjudaCGr39zwn
         2d2LPEVINGxvPMcnlflLurzruzwmK6zQlW51to30xksPb8rLTNIRw4Zz8wVPNgab9r6M
         /KaAFRU61biQLHHZ8jHKgBa4NCLS0V0rLe3UJv2k43EVVG4HAZ/XqujGZ7to6mHguVgz
         +6r4i7oc2AN+4bIpxaUZb9gKpci9n2PSmlUGJMLiJD+GM7UUzw9n9vpVLFm7Tayvp0yH
         dDcA==
X-Gm-Message-State: APjAAAX1AaU263ZybNvc/p57THz2i0QB1FFL3bQthXJkSfRKL0nm9LFo
        57CHj4wWusSNSsV0MHsxiuM=
X-Google-Smtp-Source: APXvYqwFus2ERUAiKK0Pfd67GD5yl/H1Aq135PdcBcYSGXlHZLvTqymcPbYRw1IaVwmhQQl45Ov28Q==
X-Received: by 2002:a9d:3476:: with SMTP id v109mr4029667otb.211.1572030056625;
        Fri, 25 Oct 2019 12:00:56 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 21sm748039oix.31.2019.10.25.12.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 12:00:56 -0700 (PDT)
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
Subject: [PATCH v4 0/3] PCI: pciehp: Do not turn off slot if presence comes up after link
Date:   Fri, 25 Oct 2019 15:00:44 -0400
Message-Id: <20191025190047.38130-1-stuart.w.hayes@gmail.com>
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

v3:
- remove unused variable declaration
- modify text of warning message

v4:
- remove "!!" boolean conversion in an "if" condition for readability
- add explanation comment in dmi table

Alexandru Gagniuc (2):
  PCI: pciehp: Add support for disabling in-band presence
  PCI: pciehp: Wait for PDS if in-band presence is disabled

Stuart Hayes (1):
  PCI: pciehp: Add dmi table for in-band presence disabled

 drivers/pci/hotplug/pciehp.h     |  1 +
 drivers/pci/hotplug/pciehp_hpc.c | 50 +++++++++++++++++++++++++++++++-
 include/uapi/linux/pci_regs.h    |  2 ++
 3 files changed, 52 insertions(+), 1 deletion(-)

-- 
2.18.1

