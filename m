Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FC13943D0
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 16:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbhE1OJj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 May 2021 10:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbhE1OJj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 May 2021 10:09:39 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F985C061574;
        Fri, 28 May 2021 07:08:04 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n8so1681750plf.7;
        Fri, 28 May 2021 07:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0q/z/d6ZdrctJC8E61h1ciA24adNG1lidpYUr8hKt4Y=;
        b=HFByEm/exnXR8jS6EyQ21XayhJ0oHDa5xRp4Ko/NNhpQkxNFJn3GwD83Izc24hAAqx
         dsOhpUQUGAI+Llu0QMF9j3vt0dKXoJV/elBo2FutHEgHN9U6RxIRIQ5LrI2wk4/mG/J9
         +WDquZOWjLU8kyZ550AJseGvWtdVJs8qRu9JE98QTHuNncA6w9+8prEWM5Ndc2ogJHBs
         wh6uv/0L1RR9ZFKMnekOPPcRIq7TFn9KaCbAtJu4IflxzmyVikYSMMZfXp7Aj/U98LLX
         YkpesjTXF0gy95UA3V5s87ZeGLCck4KiGB0/gC2eTVp8jbA6WTPtg+JFSpR20vARJOZr
         XRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0q/z/d6ZdrctJC8E61h1ciA24adNG1lidpYUr8hKt4Y=;
        b=YXLLvrmjHxdmNz2qp0ZC+ApAVJWJNUJc5gL9HoDWg78EXQKOO90++aX8ycPlBisOBA
         CIWDKwA2v129jR5V7FI8C403FseJRwEPx9kbxhgzd+P30DdxFFjq+54eedu9P7bs23O3
         hq6prP/SABRbTiIzT8vTupM9m8fGvQUFjE77E9WTGfWttJqzvQXxQfTLkVLG0DbiegMt
         E7LI9YwgsYSTIpOodbuqIFUfqR92eJQlz62yYTxG/of3PLb20L29xJaxLOoyIr1JuZuq
         kevZA0nzR8SsAoE3mx75+IvsmN/XSa2k6Ew2oQGyJqZXIcuoCdFH5gPxQBEl194OVlp0
         5dIQ==
X-Gm-Message-State: AOAM533t4eaHw8YQ30LrJR1VhXGd/w/6Z8CtLNwze6Qb07cFU2dOqdPw
        O+POYxHkYppUE25JoJKI1GY=
X-Google-Smtp-Source: ABdhPJxutcb8NOcHV6ywFqWqzf6o7s8h7AbU1PTsjRVejsEtA6edAFQsfdhdqbpbW3Y96p+d4DIAaw==
X-Received: by 2002:a17:902:8693:b029:eb:53f:1336 with SMTP id g19-20020a1709028693b02900eb053f1336mr8291005plo.52.1622210883995;
        Fri, 28 May 2021 07:08:03 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.164])
        by smtp.googlemail.com with ESMTPSA id j3sm4607841pfe.98.2021.05.28.07.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 07:08:03 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH v4 0/7] Expose and manage PCI device reset
Date:   Fri, 28 May 2021 19:37:48 +0530
Message-Id: <20210528140755.7044-1-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The error handling might be too verbose in the last patch
("PCI: Change the type of probe argument in reset functions").
Please let me know your comments.

Changes in v4:
	- Change the order or strlen and strim in reset_method_store
	  function to avoid extra strlen call.
	- Use consistent terminology in new
	  pci_reset_mode enum and rename the probe argument
	  of reset functions.

Changes in v3:
	- Dropped "PCI: merge slot and bus reset implementations" which was
	  already accepted separately
	- Grammar fixes
	- Added Shanker's patches which were rebased on v2 of this series
	- Added "PCI: Change the type of probe argument in reset functions"
	  and additional user input sanitization code in reset_method_store
	  function per review feedback from Krzysztof

Changes in v2:
	- Use byte array instead of bitmap to keep track of
	  ordering of reset methods
	- Fix incorrect use of reset_fn field in octeon driver
	- Allow writing comma separated list of names of supported reset
	  methods to reset_method sysfs attribute
	- Writing empty string instead of "none" to reset_method attribute
	  disables ability of reset the device


Amey Narkhede (5):
  PCI: Add pcie_reset_flr to follow calling convention of other reset
    methods
  PCI: Add new array for keeping track of ordering of reset methods
  PCI: Remove reset_fn field from pci_dev
  PCI/sysfs: Allow userspace to query and set device reset mechanism
  PCI: Change the type of probe argument in reset functions

Shanker Donthineni (2):
  PCI: Add support for a function level reset based on _RST method
  PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs

 Documentation/ABI/testing/sysfs-bus-pci       |  16 +
 drivers/crypto/cavium/nitrox/nitrox_main.c    |   4 +-
 .../ethernet/cavium/liquidio/lio_vf_main.c    |   2 +-
 drivers/pci/hotplug/pciehp.h                  |   2 +-
 drivers/pci/hotplug/pciehp_hpc.c              |   7 +-
 drivers/pci/pci-sysfs.c                       |  98 ++++++-
 drivers/pci/pci.c                             | 274 ++++++++++++------
 drivers/pci/pci.h                             |  14 +-
 drivers/pci/pcie/aer.c                        |  12 +-
 drivers/pci/probe.c                           |   4 +-
 drivers/pci/quirks.c                          |  50 ++--
 include/linux/pci.h                           |  16 +-
 include/linux/pci_hotplug.h                   |   2 +-
 13 files changed, 360 insertions(+), 141 deletions(-)

--
2.31.1
