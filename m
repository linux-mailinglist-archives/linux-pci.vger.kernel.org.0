Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33E8C13182A
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 20:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgAFTDr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jan 2020 14:03:47 -0500
Received: from ale.deltatee.com ([207.54.116.67]:54836 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbgAFTDr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jan 2020 14:03:47 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ioXf9-0005m3-NR; Mon, 06 Jan 2020 12:03:46 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ioXf8-0000e5-Rx; Mon, 06 Jan 2020 12:03:38 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kelvin.Cao@microchip.com, Eric Pilmore <epilmore@gigaio.com>,
        Doug Meyer <dmeyer@gigaio.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Mon,  6 Jan 2020 12:03:25 -0700
Message-Id: <20200106190337.2428-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, Kelvin.Cao@microchip.com, epilmore@gigaio.com, dmeyer@gigaio.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 00/12]  Switchtec Fixes and Gen4 Support
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Please find a bunch of patches for the switchtec driver collected over the
last few months.

The first 2 patches fix a couple of minor bugs. Patch 3 adds support for
a new event that is available in specific firmware versions. Patches 4 and
5 are some code cleanup changes to simplify the logic. And the last 6
patches implement support for the new Gen4 hardware.

This patchset is based on v5.5-rc5 and a git branch is available here:

https://github.com/sbates130272/linux-p2pmem switchtec-next

Thanks,

Logan

--

Kelvin Cao (3):
  PCI/switchtec: Add gen4 support in struct flash_info_regs
  PCI/switchtec: Add permission check for the GAS access MRPC commands
  PCI/switchtec: Introduce gen4 variant IDS in the device ID table

Logan Gunthorpe (6):
  PCI/switchtec: Fix vep_vector_number ioread width
  PCI/switchtec: Add support for new events
  PCI/switchtec: Introduce Generation Variable
  PCI/switchtec: Separate out gen3 specific fields in the sys_info_regs
    structure
  PCI/switchtec: Add gen4 support in struct sys_info_regs
  PCI: Apply switchtec DMA aliasing quirk to GEN4 devices

Wesley Sheng (3):
  PCI/switchtec: Use dma_set_mask_and_coherent()
  PCI/switchtec: Remove redundant valid PFF number count
  PCI/switchtec: Move check event id from mask_event() to
    switchtec_event_isr()

 drivers/pci/quirks.c                 |  18 ++
 drivers/pci/switch/switchtec.c       | 365 ++++++++++++++++++++-------
 include/linux/switchtec.h            | 160 ++++++++++--
 include/uapi/linux/switchtec_ioctl.h |  13 +-
 4 files changed, 450 insertions(+), 106 deletions(-)

--
2.20.1
