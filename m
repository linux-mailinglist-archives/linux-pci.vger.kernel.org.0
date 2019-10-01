Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C13FC426B
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 23:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfJAVOg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Oct 2019 17:14:36 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37103 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfJAVOg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Oct 2019 17:14:36 -0400
Received: by mail-ot1-f66.google.com with SMTP id k32so12864994otc.4;
        Tue, 01 Oct 2019 14:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Z0lBrmztwlwxdokvs5UrPzWHos9na8KnNzUa662Ki4U=;
        b=V3l2bPvomwEApGeIC42xksfM35fLkzstnuS71yvaINL1JdB8yQvqgm+kz6WMZCaAQS
         NlOXRoJ4pMF0XkvcDF6JzGNl7eO+bHQ1RYFEsiaS1MxlhtdbaNTM7qnYTZHGA0iGnU03
         Jl79tbxt9SDJUVjCO+TiXV4yRy7tXVIt+hBLs6J8twUrL/0v0csI1A55CTfCvHlTNWHw
         U0MrJiQH+37vQ55hrvcSaR7LM+3KhP4EZa3YdNarWcZpjbmWS+510yQfKENj3XQ/Z3+4
         r9VgPXXepOAMDgBX/WYoeZW6RbAqTUdU6mnewLdgwg3BqUExdnWuAPvJNWbNrg13pMC9
         f64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z0lBrmztwlwxdokvs5UrPzWHos9na8KnNzUa662Ki4U=;
        b=haX7XTRerAmTrjBfW74UajXllisfUQ2p2jyM/PkdCTaRWjwrn5/EsaP17OIZjN0UYJ
         garc8ngYSQkDBrSAMa98xLMs0awfgrk0h6RVWPHScn9r40ZWMa7T4gbJi7tlq7fl16vO
         1MGMlCCEv80AgAMqGJzuZDO9/J1CQJNFSfvDtd8Yh86iVRD+O+GvCfYR8DEZocSuqKDg
         HzDnk4k46bXd2YqEcxsxdRPQLn6W7jPmR1gcb/NUHfIa8UfWgS05CCUSZ7/sj97otGYb
         BtS5ba1hQj0sAYfMduJ969KZ5Fn5Ede3dfEGqDOm3ZHATjYra+0d1Aa5bUnt4izE+A3U
         iC8A==
X-Gm-Message-State: APjAAAWLlhinm/X1Qj1tKOYBqAyiSX1YxbxqcoxKHnDRxfExbjz3iv9d
        tEiRtqd1vDJYuxkSf96bGRQ=
X-Google-Smtp-Source: APXvYqyOyExxFkyt6iQmzMQZq4YBsCHZSfeeiKuGCJZp4623JJplHFZn/pKU1kaAC3y+JwjBE8eqOg==
X-Received: by 2002:a05:6830:14c5:: with SMTP id t5mr35420otq.112.1569964475039;
        Tue, 01 Oct 2019 14:14:35 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id o23sm5220073ote.67.2019.10.01.14.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 14:14:34 -0700 (PDT)
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
Date:   Tue,  1 Oct 2019 17:14:16 -0400
Message-Id: <20191001211419.11245-1-stuart.w.hayes@gmail.com>
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

This patch set is based on a patch set [1] submitted many months ago by
Alexandru Gagniuc, who is no longer working on it.

[1] https://patchwork.kernel.org/cover/10909167/
    [v3,0/4] PCI: pciehp: Do not turn off slot if presence comes up after link

Stuart Hayes (3):
  PCI: pciehp: Add support for disabling in-band presence
  PCI: pciehp: Wait for PDS when in-band presence is disabled
  PCI: pciehp: Add dmi table for systems with in-band presence disabled

 drivers/pci/hotplug/pciehp.h     |  1 +
 drivers/pci/hotplug/pciehp_hpc.c | 45 +++++++++++++++++++++++++++++++-
 include/uapi/linux/pci_regs.h    |  2 ++
 3 files changed, 47 insertions(+), 1 deletion(-)

-- 
2.18.1

