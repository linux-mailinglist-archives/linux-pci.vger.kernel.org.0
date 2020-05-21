Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1F61DCBFB
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 13:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgEULUm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 07:20:42 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:35178 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbgEULUl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2020 07:20:41 -0400
Received: by mail-ej1-f66.google.com with SMTP id s21so8382574ejd.2
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2020 04:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/sYGy12rNNYnIFh52O3J7fACxDx7xWZZHTrt8U+0v2Y=;
        b=GGaQgqzdvM7phRllKSXp0PeGLfZfO8SdPIS+gM/Sf00ZsfHxIKQFZ336HGsrx68Jhm
         eTBDLFM3YkbhGz6tuWb7A81m0Yx0w/L48MjzEoU4PSaNBpw0AjK3/pGglZ2+pOlmYb2U
         3W7QVRNmexqCjF1IZpZIzQ3ArGRIYdSHbtvL2daamhVaTtyjGrAnkihrE6r3ONOyZsWJ
         f8B3WLKUbQMxVocbO+838yHlKMABJFEVkMMYiL6COxa+ANb6ex3tifFZklgcbswqthLg
         5iHAIHn1Jn/uTPecOYB1UqPpyIayYxU869C4kMTSLChAQXxuHU2/SPglrQefja+VI2Z5
         bC8Q==
X-Gm-Message-State: AOAM533FNs1wS5t1e13G4N+8akKUGQqcAbcUVyJEtbnVeJVIGfPhzyW/
        dELGVHn0G60+2jHcFGEGbEg=
X-Google-Smtp-Source: ABdhPJz4lj//JtoXnz1qbmoEwNsOuUuNvX25OCyaVvZsKWn+RNLe/PYuMGHeF9kvPATE609JgOGPYA==
X-Received: by 2002:a17:906:c785:: with SMTP id cw5mr2871708ejb.543.1590060038548;
        Thu, 21 May 2020 04:20:38 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id w10sm4522376eju.106.2020.05.21.04.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 04:20:37 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Chuhong Yuan <hslester96@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org
Subject: [PATCH v4 0/2] PCI: Reference bridge window resources explicitly
Date:   Thu, 21 May 2020 11:20:34 +0000
Message-Id: <20200521112036.470112-1-kw@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521081638.GA30231@rocinante>
References: <20200521081638.GA30231@rocinante>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add definitions to allow for more explicit mapping of PCI-to-PCI (P2P)
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
Changes in v4:
  Correct variable name as per the kbuild bot feedback.
  Added "Acked-by" from Dominik Brodowski for the PCMCIA changes.
  Update cover letter wording.

Changes in v3:
  Remove the PCI quirk patch for ALI M7101 chipset as it's not needed.
  Remove surplus new variables added in pci_bus_size_cardbus().

Changes in v2:
  Split patches based on the feedback from Bjorn allowing for the
  patch that correct the PCI quirk for the ALI chipset to be applied
  independently, if someone needs to cherry-pick it, before updating
  the said quirk to use definitions for bridge window resources.
 
Krzysztof Wilczynski (2):
  PCI: Move from using PCI_BRIDGE_RESOURCES to bridge resource
    definitions
  pcmcia: Use resources definitions when freeing CardBus resources

 drivers/pci/quirks.c          |  34 +++++-----
 drivers/pci/setup-bus.c       | 114 ++++++++++++++++++----------------
 drivers/pcmcia/yenta_socket.c |  46 +++++++++-----
 include/linux/pci.h           |  14 ++++-
 4 files changed, 120 insertions(+), 88 deletions(-)

-- 
2.26.2

