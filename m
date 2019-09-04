Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67109A7A5C
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2019 06:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfIDEpn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 00:45:43 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39041 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfIDEpn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Sep 2019 00:45:43 -0400
Received: by mail-io1-f66.google.com with SMTP id d25so38757104iob.6;
        Tue, 03 Sep 2019 21:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/0TcseJqoK4D9Yyytz4SmT57BGmCs5CagUjz8hmy+sU=;
        b=BjMULzB+hktHhh5x1vQWuAxNP/jWMQfGeXEYEJdJ/LzVpAgSb/ZjkdsFMRWPj96Y3X
         GsFWk4K4pcbvg4qfxTWDFe/21KrG+W07DHa8k/8aYvNvYjvCZnS+njU1GmQpizzjCQK/
         hdfLqAM7h56HQnHxibQgTTiBQ7rle5AeyoO40scXPxiuEgb3CohQ/JIY0XYJZPn4odKR
         f6Cg7umULnecbw+Rty3DUmVhobw0qBg5MnolcVhxCUiWZTV6FJp+x1STn7LL/i5yNltq
         5Rz593Nl9DNbuiu+6T4+EGr81WL1JVfR8tUZTGYzp0zUw6HA88j2AAScjCvb/TKa8Zcr
         njQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/0TcseJqoK4D9Yyytz4SmT57BGmCs5CagUjz8hmy+sU=;
        b=PzYUQ4b4sDHMs5ud/ktg9+DGqFo/4frEjAkS94R1nQgEuRCploevX9lvj04hPO1mK3
         88F0bIVPbQyp0Pk9wLQha19J/K/ZwO/jwjlavu4QC2c8YzCW7vAkBAefs/x92LtQgxGl
         /XYP40LbKafNZhujxRpK/KXHi40vpUkpBqTOb8udGaKwYj9qeQqHUwgUbEYzbFivCNil
         XCJIskEWGy2SPxnSvxuJoYQt5qSAVkY5NWW0W7gDl1gbRL44H8zFSpQk+l0S5K5nbw6N
         eOAZImSN7Ot2/wTrW9PQ1WfPyLIKFNpS6E1T983MHUE6N+81v1Lf7mF6mU07At2KvO0p
         3W4Q==
X-Gm-Message-State: APjAAAUsZzJjdaOlxVIXVqLYk5Uhig1gFU9dY+mk1TE2WMYku/zKMfwJ
        wixTy9LUTHh7hDGhigbDbqBDLP58HvM=
X-Google-Smtp-Source: APXvYqzov4EkbTZXg1j47Ju/zrxTBaboIMgXAEg90DfbebeE57Em9acA9/l39rqabo2o85/2PC00sg==
X-Received: by 2002:a02:a516:: with SMTP id e22mr27158903jam.77.1567571990930;
        Tue, 03 Sep 2019 21:39:50 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id s5sm16471411iol.88.2019.09.03.21.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 21:39:50 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skunberg.kelsey@gmail.com
Cc:     skhan@linuxfoundation.org, rafael.j.wysocki@intel.com,
        keith.busch@intel.com
Subject: [PATCH 0/2] PCI: Change to using pci_dev_is_inaccessible()
Date:   Tue,  3 Sep 2019 22:36:33 -0600
Message-Id: <20190904043633.65026-1-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Patch 1: Change pci_device_is_present() name to pci_dev_is_inaccessible()
         to encourage only using to learn if we should not access a
         device that's inaccessible. Return value will need to be reversed
	 to reflect the name change.

Patch 2: Relies on patch 1. Unify pci_dev_is_disconnected() with
         pci_dev_is_inaccessible() so there is only one function
         needed to learn if a device is inaccessible due to surprise
         removal or an error condition.

Kelsey Skunberg (2):
  PCI: Change pci_device_is_present() to pci_dev_is_inaccessible()
  PCI: Unify pci_dev_is_disconnected() and pci_dev_is_inaccessible()

 drivers/net/ethernet/broadcom/tg3.c       |  4 ++--
 drivers/net/ethernet/intel/igb/igb_main.c |  2 +-
 drivers/nvme/host/pci.c                   |  2 +-
 drivers/pci/access.c                      | 12 ++++++------
 drivers/pci/hotplug/acpiphp_glue.c        |  2 +-
 drivers/pci/msi.c                         |  4 ++--
 drivers/pci/pci.c                         | 12 ++++++------
 drivers/pci/pci.h                         |  5 -----
 drivers/pci/pcie/portdrv_core.c           |  2 +-
 drivers/thunderbolt/nhi.c                 |  2 +-
 include/linux/pci.h                       |  2 +-
 11 files changed, 22 insertions(+), 27 deletions(-)

-- 
2.20.1

