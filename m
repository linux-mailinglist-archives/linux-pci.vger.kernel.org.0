Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C35F66194
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2019 00:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbfGKW0M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jul 2019 18:26:12 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39663 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbfGKW0L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jul 2019 18:26:11 -0400
Received: by mail-io1-f66.google.com with SMTP id f4so16157019ioh.6;
        Thu, 11 Jul 2019 15:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=//GbfNQFeqgDcbJ1hHRw+XupgUCwVwlP6Am4Bl3mG/I=;
        b=pEMY1jdNGbOqbUrcul/V8M56+8qKmbj4aihnPtjDq+H/i0Rvp3BuAy2Hgr5Py6ljBT
         4UzfCGKSfyOz4f/tY6kSAZLFZfKQUHFjbV47k03ODkyb3TYOiCNSSV0RZ1K3zbGcauES
         ICx8/BoHPEL4MEyCyPC2Acgg1UlQHmmTbziOXPAl4CCPejJiJlZG8kCcXa+rSpZ/6jQl
         Ko/d4EyWuuQlRNeDZrIosJZ3E2cFbxpEz5RRhIJ9J05ri/HIC+SmYJVuT7z0Zi+YcIK6
         LoJsFcO8Ye5EcbGVitdjhu63/LHCzQ2JVJ61coab3i7BON55/b9qp+zxhRtzgfCluhsT
         XzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=//GbfNQFeqgDcbJ1hHRw+XupgUCwVwlP6Am4Bl3mG/I=;
        b=JCXFhtINyW12j4aZxR94oqXIPc/4nHhC5Clpkv2Cnsmr03NZPjIuSnSnB1qxPkC3bW
         sk0asKbd2C0r6n5ghCj2kpnDYwBmqytkvcjOe2rhs3ikm6BGnB1t8i5sssA06R5PTbsP
         doq4mdssrKDp3MIZTTn1h8rBevF+JkCIORZ1+CeEJfivepmPPAKwBM6t3wP2CClHEpfT
         De3lYRP/YmlFu910NUoeqY3AxmwFjAqS95bXSlSVOtzDE8ae9afNUR2nY3umOSuY/wj5
         0FKFoWBTyojlFyljAplRnNN2waEnkVihUEGWoFdUxLo65SGNinD8WlbcRmCziZ2j8nc+
         +zPw==
X-Gm-Message-State: APjAAAVR4cTd2TbTfqAJYAR2FSYE5lRGrog6ebes+JIMi9eogR1fv36o
        mUaqQ4cKA/q7P0HbJEFHmuq1hrqKuqpjlg==
X-Google-Smtp-Source: APXvYqye7LRVHFTjuTXpJZfnWcFFmsqukrcko1gp8ao88MyyjMJtaQwADKkDvosJCAJ1xNX3+MWKLA==
X-Received: by 2002:a5e:c302:: with SMTP id a2mr3204268iok.62.1562883970755;
        Thu, 11 Jul 2019 15:26:10 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id s2sm4478982ioj.8.2019.07.11.15.26.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 15:26:10 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skunberg.kelsey@gmail.com
Subject: [PATCH 00/11] PCI: Move symbols to drivers/pci/pci.h
Date:   Thu, 11 Jul 2019 16:23:30 -0600
Message-Id: <20190711222341.111556-1-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move symbols defined in include/linux/pci.h that are only used in
drivers/pci/ to drivers/pci/pci.h.

Symbols only used in drivers/pci/ do not need to be visible to the rest of
the kernel.

Kelsey Skunberg (11):
  PCI: Move #define PCI_PM_* lines to drivers/pci/pci.h
  PCI: Move PME declarations to drivers/pci/pci.h
  PCI: Move *_host_bridge_device() declarations to drivers/pci.pci.h
  PCI: Move PCI Virtual Channel declarations to drivers/pci/pci.h
  PCI: Move pci_hotplug_*_size declarations to drivers/pci/pci.h
  PCI: Move pci_bus_* declarations to drivers/pci/pci.h
  PCI: Move pcie_update_link_speed() to drivers/pci/pci.h
  PCI: Move pci_ats_init() to drivers/pci/pci.h
  PCI: Move ECRC declarations to drivers/pci/pci.h
  PCI: Move PTM declaration to drivers/pci/pci.h
  PCI: Move pci_*_node() declarations to drivers/pci/pci.h

 drivers/pci/pci.h   | 48 ++++++++++++++++++++++++++++++++++++++++++---
 include/linux/pci.h | 47 --------------------------------------------
 2 files changed, 45 insertions(+), 50 deletions(-)

-- 
2.20.1

