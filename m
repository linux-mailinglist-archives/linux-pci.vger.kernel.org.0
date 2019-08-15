Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFB28EF82
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2019 17:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbfHOPhM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Aug 2019 11:37:12 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38289 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729998AbfHOPhM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Aug 2019 11:37:12 -0400
Received: by mail-oi1-f196.google.com with SMTP id p124so2519488oig.5;
        Thu, 15 Aug 2019 08:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=suz4mKzGOm43s2AkTS32mygq2S1lAq1/2KkLJRCcuhI=;
        b=BU+L/BikDVQeibw0EaDlqNH0M39YSDw4l2NssNBQ5HVSKf3PnMSL46YV3aGAlipVT6
         j3UVmAAi5tAK0gH2D1mQABUsRBs7b/WdAkTm3zGadgUd24tSxdfwseZPyUkRNVWIaunE
         1s9o3QJApWcej2KiMyjW5svK1eza9ICGsvjRxc+q8Cp0srbVW5DAf3vw8JKHcHh+lv72
         y+SP7gkpwhUJQxuacUagwST9K1ZHP2Bp3Z/DQCuhKprEIAB2GMwRpyskkYJ6c5BC8HeN
         yfHed+k4n4jSfOkZm2Yvq0gINHYpG3ISvIlxE6HOO5Ml/Q5luYmq9ORXOATC1MRxyXlU
         1sjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=suz4mKzGOm43s2AkTS32mygq2S1lAq1/2KkLJRCcuhI=;
        b=NbymDNoJmpc3cDghnnFtoylIDigNdxjQvVToURMscbvjpQStkyXtAjUpmFQgnDA/tn
         2PDA0XKpWAoUaecs7KWKSxL0isvyGfrxjh8v5ETJ8yE99/zTIQ24OizULA2tnBEodf5m
         XyFRM82HylkYTGpctqYYfC7oQW63t+kJzdDtFvC7wthm5noPrlmgmFf+tox/v2b6l6jF
         qSRO1C4SmSaXukO8WQ0X3VOwKxy9hdJ7l55DbbqcK5V0pE+DuCGQP2N056xFyoCh3Sru
         3RXmZscpTQRSkFhnKT1ocI7WQpS6500E3ZjeA5Od5SnfKbOWovxl9uT41XV0wD+ZWH6b
         Ea7A==
X-Gm-Message-State: APjAAAXVwydjiRG+ygg98VLytLYqTdz03lu1/YlZcfjlCwON3sIiwew9
        kAKf10QomSDx5hMf0yRC+EY=
X-Google-Smtp-Source: APXvYqyHna7FfuRasokgTH8PppSPOd+C93aaRzZFjLUIE4EtFikMOioFypedbkXo6otEajkh/cp2cA==
X-Received: by 2002:a02:a383:: with SMTP id y3mr5754146jak.6.1565883431093;
        Thu, 15 Aug 2019 08:37:11 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id c18sm1491856iod.19.2019.08.15.08.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 08:37:10 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        bodong@mellanox.com, ddutile@redhat.com,
        gregkh@linuxfoundation.org, skunberg.kelsey@gmail.com
Subject: [PATCH v3 0/4] PCI: Clean up pci-sysfs.c
Date:   Thu, 15 Aug 2019 09:33:49 -0600
Message-Id: <20190815153352.86143-1-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190813204513.4790-1-skunberg.kelsey@gmail.com>
References: <20190813204513.4790-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series is designed to clean up device attributes and permissions in
pci-sysfs.c. Then move the sysfs SR-IOV functions from pci-sysfs.c to
iov.c for better organization.

Patch 1: Define device attributes with DEVICE_ATTR* instead of __ATTR*.

Patch 2: Change permissions from symbolic to the preferred octal.

Patch 3: Change DEVICE_ATTR() with 0220 permissions to DEVICE_ATTR_WO().

Patch 4: Move sysfs SR-IOV functions to iov.c to keep the feature's code
together.


Patch 1, 2, and 4 will report unusual permissions '0664' used from the
following:

  static DEVICE_ATTR(sriov_numvfs, 0664, sriov_numvfs_show,
                     sriov_numvfs_store);

  static DEVICE_ATTR(sriov_drivers_autoprobe, 0664,
                     sriov_drivers_autoprobe_show,
                     sriov_drivers_autoprobe_store);

This series preserves the existing permissions set in:


  commit 0e7df22401a3 ("PCI: Add sysfs sriov_drivers_autoprobe to control
                        VF driver binding")

  commit 1789382a72a5 ("PCI: SRIOV control and status via sysfs")

Either adding a comment verifying permissions are okay or changing the
permissions is to be completed with a new patch.

Changes since v1:
        Add patch 1 and 2 to fix the way device attributes are defined
        and change permissions from symbolic to octal. Patch 4 which moves
        sysfs SR-IOV functions to iov.c will then apply cleaner.

Changes since v2:

        Patch 1: Commit log updated. Example shows DEVICE_ATTR_RO()
        example instead of DEVICE_ATTR(). DEVICE_ATTR() should be avoided
        unless the files have unusual permissions. Changed to reflect a
        more encouraged usage.  Also updated regex to be accurate.

        Patch 3: [NEW] Add patch to change DEVICE_ATTR() with 0220
        permissions to DEVICE_ATTR_WO().

        Updated series log to reflect new patch and unusual permissions
        information.


Kelsey Skunberg (4):
  PCI: sysfs: Define device attributes with DEVICE_ATTR*
  PCI: sysfs: Change permissions from symbolic to octal
  PCI: sysfs: Change DEVICE_ATTR() to DEVICE_ATTR_WO()
  PCI/IOV: Move sysfs SR-IOV functions to iov.c

 drivers/pci/iov.c       | 168 ++++++++++++++++++++++++++++++
 drivers/pci/pci-sysfs.c | 223 ++++------------------------------------
 drivers/pci/pci.h       |   2 +-
 3 files changed, 191 insertions(+), 202 deletions(-)

-- 
2.20.1

