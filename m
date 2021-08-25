Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1B63F7DA2
	for <lists+linux-pci@lfdr.de>; Wed, 25 Aug 2021 23:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhHYVXq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Aug 2021 17:23:46 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:41747 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhHYVXo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Aug 2021 17:23:44 -0400
Received: by mail-wr1-f54.google.com with SMTP id u9so1447547wrg.8
        for <linux-pci@vger.kernel.org>; Wed, 25 Aug 2021 14:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XrweEs56lYQQ80oiAAuhCcIZDCuqbdfIHSfwlcBHhyM=;
        b=eBNePNyhfk7ozHQSRYA0eiPSxowp/OU2ep0aICnVNs3D170PEtkfBAb2ok02bajqck
         S43sJO4cUAi64ELor8tzNSkLhg9/a8Y7hl18XH2K/MbO8pVdqSHevB9n43sX3MIWL2tB
         VU+oC84cOTphD/zyByM/FDAfO2GQ2wS24vyj6NxaJvbrHlAUMhgBeg51Ib0kQ9yoLLvz
         bEbfHJYIdohm08pMNeFwofiH3pTnvIp5SYneRiEV2gNChGEfEkPJvlgUbI/0xsFA8L9x
         SO0lSzfPbfy7Or9qUfDSnxt2T2WmHDJAXHUkbSj6N8Js6q7JTtsCLsuy67aDDZm/bFUD
         GLlg==
X-Gm-Message-State: AOAM5311bhJgh9QRhmLbgzUztiB7Em7f88fqRLq37SRSzd/PmWH1oNyP
        K0r1aTVJAmM5bZ5/Sx1xnRpwrlzrtI4=
X-Google-Smtp-Source: ABdhPJx8V+OPdh/fGAU+1eXNv/brCj1uEOt2xPnywNCazSH88IjDxUmDCjcnEER/0ZYunbEab86aEw==
X-Received: by 2002:adf:9e05:: with SMTP id u5mr187179wre.352.1629926577717;
        Wed, 25 Aug 2021 14:22:57 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id d24sm663527wmb.35.2021.08.25.14.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 14:22:56 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: [PATCH 0/4] PCI: Convert dynamic PCI resources sysfs objects into static
Date:   Wed, 25 Aug 2021 21:22:51 +0000
Message-Id: <20210825212255.878043-1-kw@linux.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

Currently, a lot of PCI-related sysfs objects are dynamically created
under the "/sys/bus/pci/devices/..." path when either the PCI driver is
initialised or when a new device is hot-added.

When PCI driver loads and the PCI sub-system initialises, the sysfs
attributes are then added when late_initcall() function is called:

    pci_sysfs_init
      sysfs_initialized = 1
      for_each_pci_dev
        pci_create_sysfs_dev_files
          sysfs_create_bin_file

Otherwise, for hot-added devices, the sysfs attributes are then added
when the pci_bus_add_devices() function is called:

  pci_bus_add_devices
    pci_bus_add_device
      pci_create_sysfs_dev_files
        if (!sysfs_initialized)
	  return
        sysfs_create_bin_file

When a device is removed the pci_remove_sysfs_dev_files() function is
called from pci_stop_dev() to remove all the attributes that were
previously added:

  pci_stop_bus_device
    pci_stop_dev
      if (pci_dev_is_added)
        pci_remove_sysfs_dev_files
          sysfs_remove_bin_file

The current implementation is known to cause problems:

  https://lore.kernel.org/linux-pci/1366196798-15929-1-git-send-email-artem.savkov@gmail.com/
  https://lore.kernel.org/linux-pci/20200716110423.xtfyb3n6tn5ixedh@pali/
  https://lore.kernel.org/linux-pci/m3eebg9puj.fsf@t19.piap.pl/
  https://lore.kernel.org/linux-pci/20210507102706.7658-1-danijel.slivka@amd.com/

Most of the PCI-related attributes do not need to be created and removed
dynamically and there is no need to also manage their create and remove
life cycle manually.

The aim is also to first reduce the reliance on using late_initcall() to
eventually remove the need for it completely.

This particular series focusing on PCI resources files on platforms that
provide either the HAVE_PCI_MMAP or ARCH_GENERIC_PCI_MMAP_RESOURCE
definitions (other platforms, such as the Alpha platform, will not be
affected) continues the on-going effort to convert the majority of the
dynamic sysfs objects into static ones so that the PCI driver core can
add and remove sysfs objects and related attributes automatically.

Please note that this series depends on the commits from the following
series to be added prior to applying it:

  https://lore.kernel.org/linux-pci/20210729233235.1508920-1-kw@linux.com/
  https://lore.kernel.org/linux-pci/20210812132144.791268-1-kw@linux.com/

	Krzysztof

Krzysztof Wilczyński (4):
  PCI/sysfs: Add pci_dev_resource_attr_is_visible() helper
  PCI/sysfs: Add pci_dev_resource_attr() macro
  PCI/sysfs: Add pci_dev_resource_group() macro
  PCI/sysfs: Convert PCI resource files to static attributes

 drivers/pci/pci-sysfs.c | 189 ++++++++++++++++++++++------------------
 include/linux/pci.h     |   2 +
 2 files changed, 104 insertions(+), 87 deletions(-)

-- 
2.32.0

