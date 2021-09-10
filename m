Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6619C407279
	for <lists+linux-pci@lfdr.de>; Fri, 10 Sep 2021 22:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbhIJU1l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Sep 2021 16:27:41 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:43992 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbhIJU1i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Sep 2021 16:27:38 -0400
Received: by mail-lf1-f48.google.com with SMTP id h16so6423042lfk.10
        for <linux-pci@vger.kernel.org>; Fri, 10 Sep 2021 13:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ja1vajpefVpCT8PhTRqxn52x2hDyf/7JIQ4+5afdBuI=;
        b=O2+cVkUcOyQAHm6fE9twUcXmcFR5wJdKHkDUuE1NWx+SmyzmvGB9UQYKVGvewP25Lb
         VKX9nJ8TpMBE+ZzudQ/Oo1TWl6Z522y5gFTiEJ2/THCQgIe+cb+R6E+rRw9AVA7pwMag
         3FUGNJcGj4FaE5h6gJbQX6haD3BFVnUjb82q36uQmHzK5kis4WNYhwtS4e1kQYusgbZu
         AvE9EuFfwa1YjboYmFu1IGPCDVQe2CkYIFwabwlQiR3NFkTv+UO2F6QMA6leVuC6OLH7
         949blK5tM3b+jioLkKBhcjau+jcwwEJ16D1mKF8piIhhNv5oIjPBMgJJrr8ZjG7ZbDAx
         k9eA==
X-Gm-Message-State: AOAM5336WcaZudsCwQuCkOQyXfiNInzgQzG1H0SkLrp/wpmMA0xGN6zQ
        Mw1HgUWWQgj1XXntKMLy2UA=
X-Google-Smtp-Source: ABdhPJywv08MTNGB+xbrH85wXY5DqnAs4LDw/uh+Wz1Swt0LWVQ/+zrNUefxXNgB/8fpY4NrHVafGg==
X-Received: by 2002:a05:6512:3f8c:: with SMTP id x12mr5438629lfa.320.1631305585666;
        Fri, 10 Sep 2021 13:26:25 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id a22sm657667lfb.17.2021.09.10.13.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 13:26:24 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 0/7] PCI: Convert dynamic PCI resources sysfs objects into static
Date:   Fri, 10 Sep 2021 20:26:16 +0000
Message-Id: <20210910202623.2293708-1-kw@linux.com>
X-Mailer: git-send-email 2.33.0
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

---
Changes in v2:
  Refactored code so that the macros, helpers and internal functions can
  be used to correctly leverage the read(), write() and mmap() callbacks
  rather than to use the .is_bin_visible() callback to set up sysfs
  objects internals as this is not supported.
  Refactored some if-statements to check for a resource flag first, and
  then call either arch_can_pci_mmap_io() or arch_can_pci_mmap_wc(),
  plus store result of testing for IORESOURCE_MEM and
  IORESOURCE_PREFETCH flags into a boolean variable, as per Bjorn
  Helgaas' suggestion.
  Renamed pci_read_resource_io() and pci_write_resource_io() callbacks
  so that these are not specifically tied to I/O BARs read() and write()
  operations also as per Bjorn Helgaas' suggestion.
  Updated style for code handling bitwise operations to match the style
  that is preferred as per Bjorn Helgaas' suggestion.
  Updated commit messages adding more details about the implementation
  as requested by Bjorn Helgaas.

Krzysztof Wilczyński (7):
  PCI/sysfs: Add pci_dev_resource_attr_is_visible() helper
  PCI/sysfs: Add pci_dev_resource_attr() macro
  PCI/sysfs: Only allow IORESOURCE_IO in pci_resource_io()
  PCI/sysfs: Only allow supported resource type in pci_mmap_resource()
  PCI/sysfs: Convert PCI resource files to static attributes
  PCI/sysfs: Rename pci_read_resource_io() and pci_write_resource_io()
  PCI/sysfs: Update code to match the preferred style

 drivers/pci/pci-sysfs.c | 213 +++++++++++++++++++++-------------------
 include/linux/pci.h     |   2 +
 2 files changed, 116 insertions(+), 99 deletions(-)

-- 
2.33.0

