Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605BE4A7762
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 19:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236726AbiBBR7Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 12:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbiBBR7Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Feb 2022 12:59:25 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88345C061714;
        Wed,  2 Feb 2022 09:59:24 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id t75-20020a4a3e4e000000b002e9c0821d78so20120oot.4;
        Wed, 02 Feb 2022 09:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/On5O1T1fFRuo3Kn0VEn+EC1N2whVRMaGgcleFHlAqk=;
        b=WtZLaWnMUHr/iNSt8R483yj6cyOlZh4ns11f0l3wgv/hG1PAk/N6xwnUqFTff86tj3
         LacgitungzYaXXmPV2MPNglwvRtWMfWn/rwGb7IKGUNDSHbASjssCpMqPlmrlSfIXBKV
         KeoTHgFAu0Q5yxrBRHPHWkwYvKwhdHrU1yiMXX7pX6nFQGq4BD+6mJkk3W4kzCt+/nFD
         jj3i/zbKKne2rsZnm0VHIOOGuVhzkYrn6gzSzAWMnHyQvuC6e1OzmtaK4c5q4agnRpEc
         G2r3mvTdxaSxvP+JHeXwTvu8j6C7U+8pSni76l9graNYx52VBexh2d5Cx6AugVq9qwox
         y9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/On5O1T1fFRuo3Kn0VEn+EC1N2whVRMaGgcleFHlAqk=;
        b=cef9Znr+d//+irFC4JkznFSTGsKf+bwCKdIhk1RTgCoNKhyDm4prsbkEulGOVxaJ88
         3QicSAft0DyNozbojxfx8r/iEI/AJ3X6ev5c07UYYxK+rMBjZ++JSGNhinBSRVdzY4Ze
         F4i3jRTtxALBl6Bw0IrhJyvwihYe6fGRVw+rhpzkygQMpcaMkWNvH1lVYRye3E/F/Slh
         HyzhkiQzP4ErWRO4Wt30WRwLoC+EjPO8i8d33ZqDpqIigDTSAWjikeSYOkf8+ogqD+Tl
         rOrKp50fSrcug1WBUNCTZ+g7PSeGgSQa/fvDwsOKowieg9rAZEl9Zn2Epkn79qwgppMU
         CCgQ==
X-Gm-Message-State: AOAM530Uq1H4SDCoKXWqoE5WEcx4vlEgfQRmQWyCGGyeioKWQDSUnxQ3
        BdHXiY39IX8dDLxmthCXvMs=
X-Google-Smtp-Source: ABdhPJwpOEbHPGejYjce+Mpm5+FaPTko4stoMGo7679QzaQan8lVur7fu0kdsMfWObkJLOYi30lrsQ==
X-Received: by 2002:a4a:a2c9:: with SMTP id r9mr15563303ool.37.1643824763933;
        Wed, 02 Feb 2022 09:59:23 -0800 (PST)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id v10sm16122725oto.53.2022.02.02.09.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 09:59:23 -0800 (PST)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Keith Busch <kbusch@kernel.org>, kw@linux.com,
        mariusz.tkaczyk@linux.intel.com, helgaas@kernel.org,
        lukas@wunner.de, pavel@ucw.cz, linux-cxl@vger.kernel.org,
        martin.petersen@oracle.com, James.Bottomley@hansenpartnership.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [RFC PATCH v2 0/3] Add PCIe enclosure management support
Date:   Wed,  2 Feb 2022 11:59:10 -0600
Message-Id: <cover.1643822289.git.stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch set adds support for two PCIe enclosure management methods,
"Native PCIe Enclosure Management" (defined in the PCI Express Base Spec)
and "_DSM Definitions for PCIe SSD Status LED" (defined in the PCI
Firmware Spec). The latter is very similar to the former, but uses a _DSM
interface (which can be provided by firmware) rather than a PCIe
extended capability.  Each provides a way to control up to ten indicator
states (such as locate, fault, etc.)

There are three patches in the set:

(1) Expands the existing enclosure driver to support more
indicators.

(2) Adds an auxiliary driver "pcie_em" that can attach to auxiliary
devices created by the drivers of any devices that can support PCIe
enclosure management (nvme, pcieport, and cxl).  It will register an
enclosure device with one component for each device with an enclosure
management interface.

(3) Modifies the nvme driver to create an auxiliary device to which the
pcie_em driver can attach.

These patches do not modify the cxl or pcieport drivers to add support,
though the driver was designed to make it easy to do so.
---
v2:  fixed compile error related to switch default in enclosure.c
     added documentation of added sysfs attributes
---

Stuart Hayes (3):
  Add support for seven more indicators in enclosure driver
  Add PCIe enclosure management auxiliary driver
  Register auxiliary device for PCIe enclosure management

 .../ABI/testing/sysfs-class-enclosure         |  14 +
 drivers/misc/enclosure.c                      | 191 ++++---
 drivers/nvme/host/pci.c                       |  11 +
 drivers/pci/pcie/Kconfig                      |   8 +
 drivers/pci/pcie/Makefile                     |   1 +
 drivers/pci/pcie/pcie_em.c                    | 473 ++++++++++++++++++
 include/linux/enclosure.h                     |  22 +
 include/linux/pcie_em.h                       |  97 ++++
 include/uapi/linux/pci_regs.h                 |  11 +-
 9 files changed, 749 insertions(+), 79 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-enclosure
 create mode 100644 drivers/pci/pcie/pcie_em.c
 create mode 100644 include/linux/pcie_em.h

-- 
2.31.1

