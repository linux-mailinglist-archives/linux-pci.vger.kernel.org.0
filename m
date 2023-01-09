Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FD9661F9B
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jan 2023 09:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbjAIIEh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Jan 2023 03:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjAIIEg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2023 03:04:36 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FB21147C
        for <linux-pci@vger.kernel.org>; Mon,  9 Jan 2023 00:04:34 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id g10so5646800wmo.1
        for <linux-pci@vger.kernel.org>; Mon, 09 Jan 2023 00:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k/eTguZ+vBXGX2AwMbtDXjvAK0CXJmCChr0POq5BYnY=;
        b=2hEgmKRc+ljrO9ZWVF8b7C9wF7B+xikXteKbU3GWtcRjFTuqGAJb83Xs3KWbHp6/sj
         DdeUOweNKQoHMxWHWpR1MN70CEuv2sA6/HRqX5LQyEqHBnjA712wbDlJSWRgxFya8+TU
         J2yCd3VXs+a9WjCoweNe+2KgpuaP4jWFTJ19bxUVGD5tmlrDNErOcRVvRajUqlG8XvD/
         R6fyVPIOLWETbxlLncLxff6BY86kglSbq//yGWWSiaaO6wYE5dXrHWU8zR7EEbAtdV3j
         TRWrJMOYdca+kXTa4TaEl7nfPxqSpml8WKHaT/shVL30FK38zv9/urYtfMpuGog1RCNn
         sCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/eTguZ+vBXGX2AwMbtDXjvAK0CXJmCChr0POq5BYnY=;
        b=w+EW+yHHz6ys9Z/WGPqTtrJ8pXsO9fMSL5OoGbB7OmbIke8lXmhRBDGt7ak+szhI7k
         3q1GDVvQMwPS1bo6otvq4zNjiPYiRsd0/Q7dVcjSNN+RrdaoU32Jra+P6GJuZgn/KPen
         ekquUQH+c0MAFu3MQYE2E2l9l2m8OFg03gpvCvz624FOB6GJyO10mu/oPvWrUTEkHZ5m
         e9yrONoT+Va7v8uXn0tm5UL98UT9XzTqKQLAD64hYuGRXVuWdPAcxiE7tKz8PeB1KZl9
         k6dcDddTLQTnNTvxSCAP62TVsYJIStHz83FadbIYOzRKP21rkK/mhl0+Vu9lpXw+cxw9
         XOkg==
X-Gm-Message-State: AFqh2kpTc9Jhhwb+iBkycs1BHe/vCY0yIXdBolxGBs5Un4w2HYgog9zp
        3HJNvMfAmp16pyfKVaZsfD3WCg==
X-Google-Smtp-Source: AMrXdXumvAblIZk7gkbhavODifPSVuq+dW/sqDUHlF2dyv4rnpa9y81POFSuhihwVChVSm1pPoRIcQ==
X-Received: by 2002:a05:600c:34d0:b0:3d6:b691:b80d with SMTP id d16-20020a05600c34d000b003d6b691b80dmr44921803wmq.21.1673251472959;
        Mon, 09 Jan 2023 00:04:32 -0800 (PST)
Received: from localhost.localdomain (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
        by smtp.gmail.com with ESMTPSA id a11-20020a5d508b000000b002779dab8d85sm7789809wrt.8.2023.01.09.00.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 00:04:32 -0800 (PST)
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
To:     virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, mst@redhat.com,
        Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: [PATCH v8 0/3] virtio: vdpa: new SolidNET DPU driver
Date:   Mon,  9 Jan 2023 10:04:29 +0200
Message-Id: <20230109080429.1155046-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds a vDPA driver for SolidNET DPU.

Patch 1 adds SolidRun vendor ID to pci_ids.
Patch 2 adds a PCI quirk needed by the DPU.
Patch 3 has the driver source code.

Patch 1 is prerequisite for both patch 2 and patch 3.

v2:
	- Semantics fixes in commit log - Patch 1.
	- Move the vendor ID to the right place, sorted by vendor ID - Patch 1.
        - Update patch subject to be more meaningful and similar to
          previous quirks - Patch 2.
        - Update the commit log to describe better what the patch does -
	  Patch 2.
	- Auto detect the BAR used for communication - Patch 3.
	- When waiting for the DPU to write a config, wait for 5secs
	  before giving up on the device - Patch 3.
	- Return EOPNOTSUPP error code in vDPA set_vq_state callback if
	  the vq state is not the same as the initial one - Patch 3.
	- Implement a vDPA reset callback - Patch 3.
	- Wait for an ACK when sending a message to the DPU - Patch 3.
	- Add endianness comments on 64bit read/write functions - Patch 3.
	- Remove the get_iova_range and free vDPA callbacks - Patch 3.
	- Usage of managed device functions to ioremap a region - Patch 3.
	- Call pci_set_drvdata and pci_set_master before
	  vdpa_register_device - Patch 3.
	- Create DMA isolation between the vDPA devices by using the
	  chip SR-IOV feature.
	  Every vDPA device gets a PCIe VF with its own DMA device - Patch 3.

v3:
	- Validate vDPA config length while receiving the DPU's config,
	  not while trying to write the vDPA config to the DPU - Patch 3.
	- Request IRQs when vDPA status is set to
          VIRTIO_CONFIG_S_DRIVER_OK - Patch 3.
	- Remove snet_reset_dev() from the PCI remove function for a VF - Patch 3.

v4:
	- Get SolidRun vendor ID from pci_ids - Patch 3.

v5:
	- Remove "select HWMON" from Kconfig.
	  Usage of "depends on HWMON || HWMON=n" instead and usage of
	  IS_ENABLED(CONFIG_HWMON) when calling to snet hwmon functions.
	  snet_hwmon.c is compiled only if CONFIG_HWMON is defined - Patch 3.
	- Remove the  #include <linux/hwmon-sysfs.h> from snet_hwmon.c - Patch 3.
	- Remove the unnecessary (long) casting from snet_hwmon_read_reg -
	  Patch 3.
	- Remove the "_hwmon" ending from the hwmon name - Patch 3.
	- Usage of IS_ERR macro to check if devm_hwmon_device_register_with_info
	  failed - Patch 3.
	- Replace schedule() with usleep_range() in the "hot loop" in
	  psnet_detect_bar - Patch 3.
	- Remove the logging of memory allocation failures - Patch 3.
	- Add parenthesis to arguments in SNET_* macros - Patch 3.
	- Prefer sizeof(*variable) instead of sizeof(struct x) when allocating
	  memory - Patch 3.

v6:
	- SNET_WRN -> SNET_WARN - Patch 3.

v7:
	- Explain the dependency of SNET_VDPA on HWMON in Kconfig - Patch 3.
	- Fix snprintf size argument in psnet_open_pf_bar and
	  snet_open_vf_bar - Patch 3.
	- Fix kernel warning in snet_vdpa_remove_vf.
	  Call pci_free_irq_vectors after vdpa_unregister_device,
	  otherwise we'll get "remove_proc_entry: removing non-empty
	  directory 'irq/..', leaking at least '..'" warnings - Patch 3.
	- Remove the psnet_create_hwmon function empty definition if
	  HWMON is not enabled, otherwise, we'll get "warning: no
	  previous prototype for 'psnet_create_hwmon'" when compiling
	  with W=1.
	  This was reported by kernel test robot <lkp@intel.com> - Patch 3.

v8:
        - Fix the series versioning.
          I updated the versions of every patch separately,
	  which seems to be wrong.

Alvaro Karsz (3):
  PCI: Add SolidRun vendor ID
  PCI: Avoid FLR for SolidRun SNET DPU rev 1
  virtio: vdpa: new SolidNET DPU driver.

 MAINTAINERS                        |    4 +
 drivers/pci/quirks.c               |    8 +
 drivers/vdpa/Kconfig               |   18 +
 drivers/vdpa/Makefile              |    1 +
 drivers/vdpa/solidrun/Makefile     |    6 +
 drivers/vdpa/solidrun/snet_hwmon.c |  188 +++++
 drivers/vdpa/solidrun/snet_main.c  | 1110 ++++++++++++++++++++++++++++
 drivers/vdpa/solidrun/snet_vdpa.h  |  194 +++++
 include/linux/pci_ids.h            |    2 +
 9 files changed, 1531 insertions(+)
 create mode 100644 drivers/vdpa/solidrun/Makefile
 create mode 100644 drivers/vdpa/solidrun/snet_hwmon.c
 create mode 100644 drivers/vdpa/solidrun/snet_main.c
 create mode 100644 drivers/vdpa/solidrun/snet_vdpa.h

--
2.32.0
