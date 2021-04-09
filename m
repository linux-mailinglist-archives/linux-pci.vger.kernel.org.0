Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E6D35A707
	for <lists+linux-pci@lfdr.de>; Fri,  9 Apr 2021 21:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbhDITZH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Apr 2021 15:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbhDITZG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Apr 2021 15:25:06 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDB2C061762;
        Fri,  9 Apr 2021 12:24:53 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so3523018wmi.3;
        Fri, 09 Apr 2021 12:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K151vTwuZepa7L/H09TOpvBqcnJ94NRUCkiGjrxXQl4=;
        b=ELehw9tZ6v3kYPPF4ZChJTD5xOjasegfKQEroeEcR5QszH/B5esJwfK9NvvNyrsyvB
         bfRqmDXKK4Ii3afZdCZZBeak1+HLl08yt5c7j8zOtaMu98q0zDbMEsAIbd+YsUngSfJM
         2k/rQpbO9VA7cIDx+mNkkHWV0AbdUm6Y4TZ0gghsFu3bWMEFzcAPTLsb8MKOo44nfk+J
         GHYfOGeJJj7NB5qocAcgM2rgmRR2lvJcsXyyF/AhdUqFuo9QbottfXP5agpKQk4FbvNc
         8qltaqQQUK2KEKuDpsQLJ66mu0V0oLwAm32kuch/Oo7nCqc3TxN7yQXxsJGfM7Uow9SA
         leCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K151vTwuZepa7L/H09TOpvBqcnJ94NRUCkiGjrxXQl4=;
        b=DpPmlwVrVl8TP5pceQEgTXK0R08H8hddzk1rqtjsRP7FThCJ3BV84BUdsIKuWnMZMc
         7eIAot3Yt7XhKEYeC5nwvUFzXHX3B4VgY7m9PsuCoCnevYBXccUA6Fx519YqLRxu7Ycl
         UMj4gMAEZvAwafHUHvSF/j4uOuEuFU3nB+3cpjx+rtPieYrCb1I3PyzETOZQqVlIJVgG
         52os0+zAEc7QcsnZx6YKZpegysWBuyit1TAfAmt0Xd9E1IHgRP4QPGh6l4nsii41BiR3
         8FOhuy4QBK7XD4PLKBdXn/ZHWCm8yJ2PujW0cAtSgm8oSYALa4i7+4FVYKAl0a3iJHjt
         mbkg==
X-Gm-Message-State: AOAM532TYGcCnWtm9M5Ui6Bpvuy/v7zy91wMp/rPqbR7HAQ5De7gIxry
        gO5wAPrN82lz7NbnGH6D+Ao=
X-Google-Smtp-Source: ABdhPJxsBxbYh2RWWRqPZhvoFPMly9Nm4HkxR6gyBbeFaHBB7B7Y6NmVyKbi+eGGEinEjYDc/mRE1g==
X-Received: by 2002:a1c:7519:: with SMTP id o25mr14950896wmc.35.1617996291906;
        Fri, 09 Apr 2021 12:24:51 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.176])
        by smtp.googlemail.com with ESMTPSA id j6sm6618573wru.18.2021.04.09.12.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 12:24:51 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com, raphael.norwitz@nutanix.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v2 0/5] Expose and manage PCI device reset
Date:   Sat, 10 Apr 2021 00:53:19 +0530
Message-Id: <20210409192324.30080-1-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI and PCIe devices may support a number of possible reset mechanisms
for example Function Level Reset (FLR) provided via Advanced Feature or
PCIe capabilities, Power Management reset, bus reset, or device specific reset.
Currently the PCI subsystem creates a policy prioritizing these reset methods
which provides neither visibility nor control to userspace.

Expose the reset methods available per device to userspace, via sysfs
and allow an administrative user or device owner to have ability to
manage per device reset method priorities or exclusions.
This feature aims to allow greater control of a device for use cases
as device assignment, where specific device or platform issues may
interact poorly with a given reset method, and for which device specific
quirks have not been developed.

Changes in v2:
	- Use byte array instead of bitmap to keep track of
	  ordering of reset methods
	- Fix incorrect use of reset_fn field in octeon driver
	- Allow writing comma separated list of names of supported reset
	  methods to reset_method sysfs attribute
	- Writing empty string instead of "none" to reset_method attribute
	  disables ability of reset the device

Sending Raphael's patch again as this series depends on it.

Amey Narkhede (4):
  PCI: Add pcie_reset_flr to follow calling convention of other reset
    methods
  PCI: Add new array for keeping track of ordering of reset methods
  PCI: Remove reset_fn field from pci_dev
  PCI/sysfs: Allow userspace to query and set device reset mechanism

Raphael Norwitz (1):
  PCI: merge slot and bus reset implementations

 Documentation/ABI/testing/sysfs-bus-pci       |  16 ++
 drivers/crypto/cavium/nitrox/nitrox_main.c    |   4 +-
 .../ethernet/cavium/liquidio/lio_vf_main.c    |   2 +-
 drivers/pci/pci-sysfs.c                       |  93 ++++++++-
 drivers/pci/pci.c                             | 176 ++++++++++--------
 drivers/pci/pci.h                             |  10 +-
 drivers/pci/pcie/aer.c                        |  12 +-
 drivers/pci/probe.c                           |   4 +-
 drivers/pci/quirks.c                          |  11 +-
 include/linux/pci.h                           |  11 +-
 10 files changed, 236 insertions(+), 103 deletions(-)

--
2.31.1
