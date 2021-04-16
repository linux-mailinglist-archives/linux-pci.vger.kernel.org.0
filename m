Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5E33629CC
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 22:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbhDPU7Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 16:59:24 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:45614 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244245AbhDPU7Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Apr 2021 16:59:24 -0400
Received: by mail-ed1-f46.google.com with SMTP id bx20so32690496edb.12
        for <linux-pci@vger.kernel.org>; Fri, 16 Apr 2021 13:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jrw+va8EMj1cW8KmwEq3RRStTBBt0c/mXibBzE08DgU=;
        b=L3200Y1RgrUh77WRENT7D9YaqbubUml1fJXMzWixCXkYnHchGkkHn3s1cc1X7emdxu
         6r4Lgo4kznR62KoA9Z2d3K7KPVXtNfzyoBE3rvjAxZuaj4Db9QIODlJ7iVHGpu20adqU
         bMIVkoJul7lrLJNRks+x1dwkHKX/EK+83xvYdw1W+pGLYCXYfm+r6FN7k4WGp1v98P3F
         1THFiP+UhRpE3jonJ2WjK7zNBt7JDNXfEf9IgS6kzl5brgCRrHU7Rz0NUuiiQfG2sxLx
         4W6ScIfVcqK/MTR5p0gx8EFVtIHQblP1LLzFdpl9A3xR9df/VkZ7OoBrc6evZ9WohQ/m
         vhSA==
X-Gm-Message-State: AOAM5335sUN2Y0htTnIqa17M++OAuP24XzAsBVzWrG6CSUaA749KFJDP
        pPrJAaOhAd/CnhbQb3i22rY=
X-Google-Smtp-Source: ABdhPJxsy+nnEMjKDqg2724lVZ9ZfA2sFNPkWVpplGLSwKSDn2SJNxZOSM214DtzZu2PZNJBLojFjg==
X-Received: by 2002:a05:6402:354b:: with SMTP id f11mr12047340edd.361.1618606737956;
        Fri, 16 Apr 2021 13:58:57 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n11sm5103864ejg.43.2021.04.16.13.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 13:58:57 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Joe Perches <joe@perches.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        David Sterba <dsterba@suse.com>, linux-pci@vger.kernel.org
Subject: [PATCH 00/20] PCI: Convert dynamic sysfs objects into static
Date:   Fri, 16 Apr 2021 20:58:36 +0000
Message-Id: <20210416205856.3234481-1-kw@linux.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

Currently, a lot of PCI-related sysfs objects that are created when
either the PCI driver is initialised or when a new device is added are
dynamically created under the "/sys/bus/pci/devices/..." path.

All the attributes are added when late_initcall() function executes when
the PCI driver, and hence the PCI sub-system, is initialised, and also
when the function pci_bus_add_devices() executes when a device is added:

  late_initcall()
    pci_sysfs_init()
      pci_create_sysfs_dev_files()
        sysfs_create_bin_file()

  pci_bus_add_devices()
    pci_bus_add_device()
      pci_create_sysfs_dev_files()
        ...

When a device is stopped and removed the pci_remove_sysfs_dev_files()
function executes dynamically removing all the attributes that were
previously added:

  pci_stop_bus_device()
    pci_stop_dev()
      pci_remove_sysfs_dev_files()
        sysfs_remove_bin_file()

The current implementation is known to cause problems [1].

As most of the PCI-related attributes does not need to be created and
removed dynamically, and thus there is no need to also manage their
create and remove life cycle manually.

This series aims to convert the majority of the dynamic sysfs objects
into static ones so that the PCI driver core can manage them
automatically when the device is either added or removed.

The aim is also to first reduce the reliance on using late_initcall()
and eventually remove the need for it completely - this hopefully should
move everything closer towards addressing the issue that has been
identified in [1].

Aside from converting sysfs objects, this series also offers a series of
style clean-up patches offering updates, style changes, etc.

1. https://lore.kernel.org/linux-pci/20200716110423.xtfyb3n6tn5ixedh@pali/

Krzysztof

Krzysztof Wilczyński (20):
  PCI: Convert dynamic "config" sysfs object into static
  PCI: Convert dynamic "rom" sysfs object into static
  PCI: Convert dynamic "reset" sysfs object into static
  PCI/VPD: Convert dynamic "vpd" sysfs object into static
  PCI: Convert dynamic "index" and "label" sysfs objects into static
  sysfs: Introduce BIN_ATTR_ADMIN_RO and BIN_ATTR_ADMIN_RW
  PCI: Convert PCI sysfs objects to use BIN_ATTR_ADMIN_RW macro
  PCI: Move to kstrtobool() to handle user input
  PCI: Use sysfs_emit() and sysfs_emit_at() in "show" functions
  PCI: Update style to be more consistent
  PCI: Rearrange attributes from the pci_dev_group
  PCI: Rearrange attributes from the pci_dev_config_attr_group
  PCI: Rearrange attributes from the pci_dev_rom_attr_group
  PCI: Rearrange attributes from the pci_dev_reset_attr_group
  PCI: Rearrange attributes from the pci_dev_attr_group
  PCI: Rearrange attributes from the pci_dev_hp_attr_group
  PCI: Rearrange attributes from the pci_bridge_attr_group
  PCI: Rearrange attributes from the pcie_dev_attr_group
  PCI: Rearrange attributes from the pci_bus_group
  PCI: Rearrange attributes from the pcibus_group

 drivers/pci/pci-label.c |  241 ++----
 drivers/pci/pci-sysfs.c | 1655 ++++++++++++++++++++-------------------
 drivers/pci/pci.h       |   16 +-
 drivers/pci/remove.c    |    2 +
 drivers/pci/vpd.c       |   58 +-
 include/linux/pci.h     |    1 -
 include/linux/sysfs.h   |   23 +
 7 files changed, 976 insertions(+), 1020 deletions(-)

-- 
2.31.0

