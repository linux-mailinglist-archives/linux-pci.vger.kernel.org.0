Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 738224C6B2
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 07:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbfFTFNr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 01:13:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34827 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfFTFNq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jun 2019 01:13:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id d126so975617pfd.2
        for <linux-pci@vger.kernel.org>; Wed, 19 Jun 2019 22:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x1MMOnOq8RstNP2fbCqAXnUxGL8fsmmbBQmO9ouhYxU=;
        b=qqfZQy2CGsb+E8k+hNToCHi7yQ6EQT1ztzughkC4rZ7JZeS8tJxFUZHT3ESXaIYf13
         UgniZjFtJNzZzllYugZzh2J0jll+rA/UjsUDGIDBFBz1XOYdoNPZfDjGQ6ccVzACDhlQ
         fAgBwhr8ldmbQvxUiJ/rrucTy42SRYxvy1n88EHFjG+wsN2W22D5ydbGO4g9DGcZ77fL
         tjqLQZNiZYsxR6kCib/BqTVZDnEjWI/2GpCXzNLuUp0Rmmhp7P3nomG3qPiQ6UFFeWv3
         YIyCm6kvWIk9Yg/jt59IFnyxW6lTaGdJMA86sTL0qHAu5oVfqFIktUWro/775sloGPW5
         X71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x1MMOnOq8RstNP2fbCqAXnUxGL8fsmmbBQmO9ouhYxU=;
        b=rIFVBhFKApZgdFUy0S2dC+v/zAWlGOu4kC9sHFa6ArLIwYlmt+tYl7i+MeqVQKLRT1
         Yx3l64eSEkzfCYgNL/BpD7Y8/WR/QlML+8UlZgWBG7MdBP5QHzNHJ2g/hPkEJtwV8x7E
         MhISF9AbcyjPNvRjA88NoAcQ8+bneh25V7K44hpSO8qcyuY7CaA4idpef8lFgQSIRfjY
         5dy+IP/rZ/3w3UFsaJhE4j2nawalgEBXMY4QdZ95xmLN/UykXve80pQl5sSxTF9DtGFP
         Y227HikFszpgV8JP4DsHiNBz2hyYjCgL669CvqvVYVT5b7gSgjniwe3FD6Pc3HoOTWFi
         zZlw==
X-Gm-Message-State: APjAAAUpH9PxvQh/eoRPYrjsHARPFzrDT0ZsAmO2rvWv3KUFcFKhH/Gw
        TxH3uHLztnurCubJFsHsdWCoIQ==
X-Google-Smtp-Source: APXvYqwG59rjA9LYxKGaWy2LiC6hk6P16QRV4jC29nrowDYTzI56hJhNq74kFL956eFcU6GzoYReIw==
X-Received: by 2002:a17:90a:216f:: with SMTP id a102mr1118147pje.29.1561007625289;
        Wed, 19 Jun 2019 22:13:45 -0700 (PDT)
Received: from limbo.local (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id j2sm26383423pfn.135.2019.06.19.22.13.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 22:13:44 -0700 (PDT)
From:   Daniel Drake <drake@endlessm.com>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-ide@vger.kernel.org, linux@endlessm.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        alex.williamson@redhat.com, dan.j.williams@intel.com
Subject: [PATCH v2 0/5] Support Intel AHCI remapped NVMe devices
Date:   Thu, 20 Jun 2019 13:13:28 +0800
Message-Id: <20190620051333.2235-1-drake@endlessm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Intel SATA AHCI controllers support a strange mode where NVMe devices
disappear from the PCI bus, and instead are remapped into AHCI PCI memory
space.

Many current and upcoming consumer products ship with the AHCI controller
in this "RAID" or "Intel RST Premium with Intel Optane System Acceleration"
mode by default. Without Linux support for this remapped mode,
the default out-of-the-box experience is that the NVMe storage device
is inaccessible (which in many cases is the only internal storage device).

In most cases, the SATA configuration can be changed in the BIOS menu to
"AHCI", resulting in the AHCI & NVMe devices appearing as separate
devices as you would ordinarily expect. Changing this configuration
is the recommendation for power users because there are several limitations
of the remapped mode (now documented in Kconfig help text).

However, it's also important to support the remapped mode given that
it is an increasingly common product default. We cannot expect ordinary
users of consumer PCs to find out about this situation and then
confidently go into the BIOS menu to change options.

This patch set implements support for the remapped mode.

v1 of these patches was originally posted by Dan Williams in 2016.
https://marc.info/?l=linux-ide&m=147709610621480&w=2
Since then:

 - Intel stopped developing these patches & hasn't been responding to
   my emails on this topic.

 - More register documentation appeared in
   https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/300-series-chipset-pch-datasheet-vol-2.pdf

 - I tried Christoph's suggestion of exposing the devices on a fake PCI bus,
   hence not requiring NVMe driver changes, but Bjorn Helgaas does not think
   it's the right approach and instead recommends the approach taken here.
   https://marc.info/?l=linux-pci&m=156034736822205&w=2

 - More consumer devices have appeared with this setting as the default,
   and with the decreasing cost of NVMe storage, it appears that a whole
   bunch more consumer PC products currently in development are going to
   ship in RAID/remapped mode, with only a single NVMe disk, which Linux
   will otherwise be unable to access by default.

 - We heard from hardware vendors that this Linux incompatibility is
   causing them to consider discontinuing Linux support on affected
   products. Changing the BIOS setting is too much of a logistics
   challenge.

 - I updated Dan's patches for current kernels. I added docs and references
   and incorporated the new register info. I incorporated feedback to push
   the recommendation that the user goes back to AHCI mode via the BIOS
   setting (in kernel logs and Kconfig help). And made some misc minor
   changes that I think are sensible.

 - I investigated MSI-X support. Can't quite get it working, but I'm hopeful
   that we can figure it out and add it later. With these patches shared
   I'll follow up with more details about that. With the focus on
   compatibility with default configuration of common consumer products,
   I'm hoping we could land an initial version without MSI support before
   tending to those complications.

Dan Williams (2):
  nvme: rename "pci" operations to "mmio"
  nvme: move common definitions to pci.h

Daniel Drake (3):
  ahci: Discover Intel remapped NVMe devices
  nvme: introduce nvme_dev_ops
  nvme: Intel AHCI remap support

 drivers/ata/Kconfig                  |  33 ++
 drivers/ata/ahci.c                   | 173 ++++++++--
 drivers/ata/ahci.h                   |  14 +
 drivers/nvme/host/Kconfig            |   3 +
 drivers/nvme/host/Makefile           |   3 +
 drivers/nvme/host/intel-ahci-remap.c | 185 ++++++++++
 drivers/nvme/host/pci.c              | 490 ++++++++++++++-------------
 drivers/nvme/host/pci.h              | 145 ++++++++
 include/linux/ahci-remap.h           | 140 +++++++-
 9 files changed, 922 insertions(+), 264 deletions(-)
 create mode 100644 drivers/nvme/host/intel-ahci-remap.c
 create mode 100644 drivers/nvme/host/pci.h

-- 
2.20.1

