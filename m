Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6DC1DB03B
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 12:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgETKbv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 06:31:51 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43179 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETKbu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 06:31:50 -0400
Received: by mail-lf1-f68.google.com with SMTP id c12so1968650lfc.10
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2020 03:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RfAYY6xCT7oghxcf0si+F3cQB1lL04wBWkTWRakd9FQ=;
        b=fR5CLnQpEZw03z1USplSeD7ukwteaBGX9uTzufJeywsdYXgOJkb35fvFOEfcOFIihm
         4cwh7nH9mb2waznL3ssd6+ppqe+5iOK7hR/HfpAVYTUAgF9Wfhs3IumQNHLO36udfHoI
         IcvpVwUSERZfASz1FRcls6NJudYnUU0WCajor7L5kFCiXbZW2lI+D0xBfGN8amFnTEqM
         8igoVB6H9SEddvLSBl9kG7EB66kT2dksVMKMMLzac1R6C2ClxbXW6S7pkHa9updFyVJn
         03HAY+Pcd3Ozq5kERR5ILm6GHK7s+iRfAcrWk3WnkZ2Ago1WPm9QEBAUaaiZXXK9nvdR
         i/Dg==
X-Gm-Message-State: AOAM531utszOx8G/EhSUJy5x6TFoUlqpSzz2gMePtj9Et7nDCnNfLbJT
        ZgDWMlmwImTjN0F9HZ7I33M=
X-Google-Smtp-Source: ABdhPJyuhnyRbj80v7aUekTvbq/zolWMBeWLlHPm2SrXoj7DKPrimHh76IuDcFTNi1G+17e3tKhQSw==
X-Received: by 2002:ac2:504e:: with SMTP id a14mr2285597lfm.30.1589970708624;
        Wed, 20 May 2020 03:31:48 -0700 (PDT)
Received: from localhost.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id v28sm967404lfd.35.2020.05.20.03.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 03:31:48 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Chuhong Yuan <hslester96@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 0/3] PCI: Reference bridge window resources explicitly
Date:   Wed, 20 May 2020 10:31:44 +0000
Message-Id: <20200520103147.985326-1-kw@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519214926.969196-1-kw@linux.com>
References: <20200519214926.969196-1-kw@linux.com>
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

Also, correct the PCI quirk for the ALI M7101 chipset so that it would
stop claiming an I/O resource from the memory window which was not
correct.

Krzysztof Wilczynski (3):
  PCI: Correct the PCI quirk for the ALI M7101 chipset
  PCI: Move from using PCI_BRIDGE_RESOURCES to bridge resource
    definitions
  pcmcia: Use resources definitions when freeing CardBus resources

---
Changes in v2:
  Split patches based on the feedback from Bjorn allowing for the
  patch that correct the PCI quirk for the ALI chipset to be applied
  independently, if someone needs to cherry-pick it, before updating
  the said quirk to use definitions for bridge window resources.

 drivers/pci/quirks.c          |  34 +++++-----
 drivers/pci/setup-bus.c       | 116 ++++++++++++++++++----------------
 drivers/pcmcia/yenta_socket.c |  46 +++++++++-----
 include/linux/pci.h           |  14 +++-
 4 files changed, 121 insertions(+), 89 deletions(-)

-- 
2.26.2

