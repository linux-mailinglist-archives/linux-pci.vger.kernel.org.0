Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 309C2D1959
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2019 22:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfJIUFc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Oct 2019 16:05:32 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46557 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbfJIUFc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Oct 2019 16:05:32 -0400
Received: by mail-ot1-f65.google.com with SMTP id 89so2808900oth.13;
        Wed, 09 Oct 2019 13:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VJ6+GJRwt7B8QIB95Qkr/6HpC/9offIDxz70B65cdOw=;
        b=uK7w/WSrVBWqomR/LSIN609I7J7qD6S7Km8ILac0Aq/rIxOGsUVrcmzLjlwixAjahA
         1/kg6qlNoEeBlzKRbWq1CoINxQOg1LnBXupGCRCJAqY+FfpfWrHdQVrMTP1P0ht16eUV
         FMmWf8OwLPq8yLxCABj0yHZ43xxVBw7Gudc+jiIUoDbfuBX6FJtAdYU5vbXaWyw5H09+
         IN5dY/83u2vfUCZunYrbzqYlijlEwVFqZw/esA+IEJdvNcbJzBvfY9LwnBk3akQAm028
         XjxQ3fqdzKiRi7Twi5h0TTUR0PrfvjnHMktdWdOMDrTNEW+u9MVTlaBP8zlKkjMdMxiA
         4HSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VJ6+GJRwt7B8QIB95Qkr/6HpC/9offIDxz70B65cdOw=;
        b=N4l8l/yP0/qU5tAZT+uGL9UHQCU+mlBxeKH8JmpcJkX+fsiBJDVwkHF5stB5Xa6k29
         BKswQ0wPc/zpzJ/MP1qseptF4PhYs9RO//LgwM/JIqW9fBZy0wxYIMCPa2wFBIm7UApV
         DlRkuzA4JbxBlGz9Ph74myAko0yARGmuvdGUcLx6VPbaHDRWoahXjYk0wt8GwvvZJWZp
         /ReGkLFw0SfIkEJU7GCGD31IFVqQIUhedoSvQcxh+yiCipAnpHlhzvnbHhGSzngi/oNr
         MbeVU+4np7wXbAX8ITVhK/C90b3PCQ05GZTYsfTRXqjgXOcDayvdIqB10ZnFWnwRQaXU
         1a9w==
X-Gm-Message-State: APjAAAU0XbpQ18QhefCW5+kicQo5YcY5VDQk5EaDYq28YZlSSdSfyalk
        WudgQCjmtOGhJHlwwI9HgEI=
X-Google-Smtp-Source: APXvYqzXjE1T9bjPweSrdrFrNEroWM2NPJm/mFEDlRApVsqKmuJpT6OAGNDKz/jge2tDwcl6//62ag==
X-Received: by 2002:a9d:77d4:: with SMTP id w20mr4547780otl.148.1570651530976;
        Wed, 09 Oct 2019 13:05:30 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id b5sm976883oia.20.2019.10.09.13.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 13:05:30 -0700 (PDT)
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
Subject: [PATCH 0/3] PCI: pciehp: Do not turn off slot if presence comes up after link
Date:   Wed,  9 Oct 2019 16:05:20 -0400
Message-Id: <20191009200523.8436-1-stuart.w.hayes@gmail.com>
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

