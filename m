Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF9CFDB78C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 21:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbfJQTdD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 15:33:03 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:32934 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbfJQTdC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Oct 2019 15:33:02 -0400
Received: by mail-ot1-f68.google.com with SMTP id 60so2943942otu.0;
        Thu, 17 Oct 2019 12:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/eOJNPW1GybwH65ZRCbz3mziNf6IHtBGR8VmrLMA+Bw=;
        b=RWheJ8BHZ0K92Ha9jadaREHXm8SZoRBG4fjzu0XGmZXjPa0wewBDvDb+Li/viTOueM
         YlWTql4v6cvI6T7SoP9GpaMulC9+10xvfryUc415dERYPj64r374eTpp+Wfakboh1H3n
         BvM1m387MwsAnKXVlQ/XHnBKVQfDDwrABj1B0UoYiEE4XNd/dkP5G4hBkVi8R7346yaN
         sECnFw4SpBPp3dluzLMSU69eMqi+g+fk+BqYu1q4uRJkUAcZR42VAgQw61DLXeWqeuyO
         KwPl73zH6nsN//k1UtVgjsjgbo29rU29g4n6YB7FL0yqUTJX4PwnXCV8g74LP/s0stCF
         qH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/eOJNPW1GybwH65ZRCbz3mziNf6IHtBGR8VmrLMA+Bw=;
        b=kDlYsPQUqcIcCNs6dAiYFChCYVkuptYxTeoAU+VZoalDU2vXtxE23kWr9qPn4gBvLO
         7ZZQDSXc+ABns6u2ZBTVKYHs1pjmBWEOsgsbs0Q8llylFjBAnh2XSqaIMXo52J4XBq76
         ZP0VbzbrUsyHnyNHqbyGrvOJmvyMK7g4eGy5iNsT0rMuTheZCKiu5LMZjCmS0dYTOFee
         30xvSlyuz4RRC4hNfDk/uj1PVdZr9YGIx5YosD4zaorYrRF6JrY8+cn+M282T4vPhE2N
         MLKDub0s45TBgLZEa3GFZcGLp2pAJEIBvMgHijM/BFhkQ1VTmzEjeekoUcvd14+2zZQo
         jQvw==
X-Gm-Message-State: APjAAAVQl3bAxjOkr3/pRwnN2tIkCcCVwVF2ORb0kUX2s10G0pohjWBz
        kIXV7j9WaqR9TKkMdYepgMs=
X-Google-Smtp-Source: APXvYqyqraIO18V/Ca2vVKPAbuqO2akSybsPOuIZnh4iIagGmG5/u9YN6/q0kQEh1V5s34fCgb4rQg==
X-Received: by 2002:a9d:5c0e:: with SMTP id o14mr4638631otk.79.1571340781722;
        Thu, 17 Oct 2019 12:33:01 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id z12sm823273oth.71.2019.10.17.12.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 12:33:01 -0700 (PDT)
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
Subject: [PATCH v3 0/3] PCI: pciehp: Do not turn off slot if presence comes up after link
Date:   Thu, 17 Oct 2019 15:32:53 -0400
Message-Id: <20191017193256.3636-1-stuart.w.hayes@gmail.com>
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

