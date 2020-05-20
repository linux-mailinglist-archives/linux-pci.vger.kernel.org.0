Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB4A1DBCF3
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 20:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgETSeP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 14:34:15 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44649 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgETSeO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 14:34:14 -0400
Received: by mail-ed1-f68.google.com with SMTP id d24so4193604eds.11
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2020 11:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7iw8vEfiRQQOeWPZKeNwpsmfmaGeCn4iIc7hUSvXOfM=;
        b=o9NhTeBJCWgklUCd7L7G4Rtfhi/8d2P7qJwVv0dQW3fSK66ehqrC94UKFNoBuNUYz9
         Buy67aEakMZcNUt7Ldnylg47F2UsVAU9I+IlaajWtjdIX96y/kbVTNv3qRM0M1jDcpth
         PcvPfXKHBe3w7pcF58RhRXyCmhbrNoAW7rSw1oUpYqGTkAZ0V8l0FDpgekBfuw1kpk55
         v5f4mec/nrlU8eXOxN0hRMhNYnO0Gn8sljIQcQGAI/wenbNqF1M+J41gVvXjjhIpsWPr
         6rMNrl/ZWwqB34Id7EqB5F4AF7zJrsU0FZAakDEY6rtulGZrCgMyR74Y+zU5LDdu4zdY
         HLUA==
X-Gm-Message-State: AOAM530C9AOc9SFu4yldeECWcPcJxtSRH6Y329QCIwLgh8sWhzDTohPk
        gJH/id5EVUd26UYMbmPN5Mk=
X-Google-Smtp-Source: ABdhPJzMCGyJN58wgPa3VpDblIOeljbSS7naNf6xO6PQSSlL0TqitsD0Y/S3pWv6EKO9Kk1hySuewg==
X-Received: by 2002:a05:6402:4d5:: with SMTP id n21mr4544187edw.49.1589999653123;
        Wed, 20 May 2020 11:34:13 -0700 (PDT)
Received: from localhost.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id z3sm2739855ejl.38.2020.05.20.11.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 11:34:12 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Chuhong Yuan <hslester96@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 0/2] PCI: Reference bridge window resources explicitly
Date:   Wed, 20 May 2020 18:34:09 +0000
Message-Id: <20200520183411.1534621-1-kw@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520170609.GA1102503@bjorn-Precision-5520>
References: <20200520170609.GA1102503@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add definitions to allow for more explicit mapping of Peer-to-Peer (P2P)
and CardBus bridge window resources.

Added for P2P:

  PCI_BRIDGE_RESOURCES + 0 -> PCI_BRIDGE_IO_WINDOW
  PCI_BRIDGE_RESOURCES + 1 -> PCI_BRIDGE_MEM_WINDOW
  PCI_BRIDGE_RESOURCES + 2 -> PCI_BRIDGE_PREF_MEM_WINDOW

Added for CardBus:

  PCI_BRIDGE_RESOURCES + 0 -> PCI_CB_BRIDGE_IO_0_WINDOW
  PCI_BRIDGE_RESOURCES + 1 -> PCI_CB_BRIDGE_IO_1_WINDOW
  PCI_BRIDGE_RESOURCES + 2 -> PCI_CB_BRIDGE_MEM_0_WINDOW
  PCI_BRIDGE_RESOURCES + 3 -> PCI_CB_BRIDGE_MEM_1_WINDOW

The old way of addressing resources using an index:

  bridge->resource[PCI_BRIDGE_RESOURCES+0]

Would now be replaced with:

  bridge->resource[PCI_BRIDGE_IO_WINDOW]

This series of patches builds on top of the changes proposed before:

  https://lore.kernel.org/r/20100203233931.10803.39854.stgit@bob.kio
  https://lore.kernel.org/r/20100212170022.19522.81135.stgit@bob.kio

Krzysztof Wilczynski (2):
  PCI: Move from using PCI_BRIDGE_RESOURCES to bridge resource
    definitions
  pcmcia: Use resources definitions when freeing CardBus resources

---
Changes in v2:
  Split patches based on the feedback from Bjorn allowing for the
  patch that correct the PCI quirk for the ALI chipset to be applied
  independently, if someone needs to cherry-pick it, before updating
  the said quirk to use definitions for bridge window resources.

Changes in v3:
  Remove the PCI quirk patch for ALI M7101 chipset as it's not needed.
  Remove surplus new variables added in pci_bus_size_cardbus().

 drivers/pci/quirks.c          |  37 +++++------
 drivers/pci/setup-bus.c       | 114 ++++++++++++++++++----------------
 drivers/pcmcia/yenta_socket.c |  46 +++++++++-----
 include/linux/pci.h           |  14 ++++-
 4 files changed, 122 insertions(+), 89 deletions(-)

-- 
2.26.2

