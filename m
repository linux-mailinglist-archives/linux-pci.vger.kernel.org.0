Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696C633951B
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 18:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhCLRgx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 12:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbhCLRgj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Mar 2021 12:36:39 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFABC061574;
        Fri, 12 Mar 2021 09:36:39 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id s21so5481252pjq.1;
        Fri, 12 Mar 2021 09:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5ihFZ7BHLilp/vZCzAtM3Ib6e3/Q4HLkfYso80HW+1A=;
        b=By+wEJ2gTR3BGf3ZwucvwFywlAr3EOl1y2J1RgszSFax28ruvnMz//bqhTRizLaSas
         ZdnzOumuXuFZoQ7d+aKSIMBYg4seGF1Gq30Y3lADRwXn380JHlwDQmVWnCfubxhHo2yH
         fXLR6tJooSTg+KyVFfsVl5/z+Bxk/50iRr71NON4ZbX1ydqfr+XSJYmXB/sgOm8YcQKT
         MStxiHACLZrAO457oDOPum/N2PCmE2HsNp9pRZe0CsNa3CfREPOkmKSeq9rx+kAsRFAH
         rIt+dEP7z/gNBECZKSCXBgW21+bZ1vwy/e5EDfuUSSUVAMp7IZboJMROq1DnnlM3ROMc
         nadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5ihFZ7BHLilp/vZCzAtM3Ib6e3/Q4HLkfYso80HW+1A=;
        b=UESW6DwzePQYJnTWwozt320EKnfgF/xFasW0qqI+FUTxWLMjgZExTygU7s4iyDB0EP
         ksWp0LkT5ygSsGND5EOL/dRAmm6+d/P1maHw7lq1Fkm8BuWZy1dwL28ksjkFV3HOLsTt
         52DnDyZMeieCRT0nWCqRRwIHnRUzxhe2jDzdm4Xv5Gyd7YP2QhsAzYtDdH0hTH71TFek
         ued2JgS5WeWzx4CaWHOyfxvvb8++qvYyV3PMvM2seh2KEl4bAIGgRQLsaybqehmjJ3MC
         nr51+peu7vCqP28JsKzqKeZ88O07B1iQYCyaTgHk3KoNBVgkum1husz8QxtUnW05x7de
         VqzQ==
X-Gm-Message-State: AOAM532CjnmVqowJThrP/x6PFkEnxe8KySdNQJuvalfGmXhdsxg8hYrP
        p80j8UWQaf5Vvxt70uymKBs=
X-Google-Smtp-Source: ABdhPJyRWwwEAmq9mh9/pmG4QBAK3h0WHECgl8+56tprKYv+8IQKSr5XJLAGXGHt3koRJtHd/bdT3A==
X-Received: by 2002:a17:90a:670a:: with SMTP id n10mr15081646pjj.101.1615570599284;
        Fri, 12 Mar 2021 09:36:39 -0800 (PST)
Received: from localhost.localdomain ([103.248.31.144])
        by smtp.googlemail.com with ESMTPSA id l10sm180045pfc.125.2021.03.12.09.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 09:36:38 -0800 (PST)
From:   ameynarkhede03@gmail.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com, raphael.norwitz@nutanix.com,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: [PATCH 0/4] Expose and manage PCI device reset
Date:   Fri, 12 Mar 2021 23:04:48 +0530
Message-Id: <20210312173452.3855-1-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Amey Narkhede <ameynarkhede03@gmail.com>

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

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

Amey Narkhede (4):
  PCI: Refactor pcie_flr to follow calling convention of other reset
    methods
  PCI: Add new bitmap for keeping track of supported reset mechanisms
  PCI: Remove reset_fn field from pci_dev
  PCI/sysfs: Allow userspace to query and set device reset mechanism

 Documentation/ABI/testing/sysfs-bus-pci       |  15 ++
 drivers/crypto/cavium/nitrox/nitrox_main.c    |   4 +-
 drivers/crypto/qat/qat_common/adf_aer.c       |   2 +-
 drivers/infiniband/hw/hfi1/chip.c             |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   2 +-
 .../ethernet/cavium/liquidio/lio_vf_main.c    |   4 +-
 .../ethernet/cavium/liquidio/octeon_mailbox.c |   2 +-
 drivers/net/ethernet/freescale/enetc/enetc.c  |   2 +-
 .../ethernet/freescale/enetc/enetc_pci_mdio.c |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   4 +-
 drivers/pci/pci-sysfs.c                       |  68 +++++++-
 drivers/pci/pci.c                             | 160 ++++++++++--------
 drivers/pci/pci.h                             |  11 +-
 drivers/pci/pcie/aer.c                        |  12 +-
 drivers/pci/probe.c                           |   4 +-
 drivers/pci/quirks.c                          |  17 +-
 include/linux/pci.h                           |  17 +-
 17 files changed, 213 insertions(+), 117 deletions(-)

--
2.30.2
