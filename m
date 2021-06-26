Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72553B4E82
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jun 2021 14:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhFZNAB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Jun 2021 09:00:01 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:37483 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFZNAB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Jun 2021 09:00:01 -0400
Received: by mail-ej1-f51.google.com with SMTP id o11so6653627ejd.4
        for <linux-pci@vger.kernel.org>; Sat, 26 Jun 2021 05:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J6KbF4yd/VbN5rSAdoafLMOw+v9NaRZi9NVjJCNeZ7M=;
        b=kPcgY0OQnwxEUweSn15QL4EL6XC7jP4ambkv9hdVhuNSAPsprjyKxZcBorp7h2TZTk
         4Nvi4j3eeFKv5VwSUvkEBD8a3NjPxakzGtrCgLFgUWPpey40Qfs46ZlrEKBWV0eDiggp
         wKgx7RmDd19dv3rWAbgtNxRn8v9lOItU/VDBX23QjDSlu8qs6myrKUmAZh1H8tEwHpWF
         /bk/ngRd7y+jIuQDBww8R1sFpDhBYC5koThj3cKir80ESAtb6ZCfV//dg9LJcgO9hNG7
         ZDunZoVbqEoZAUm/NgflwNWbLAOJn6J9AIPbS904aMZi8IOO3MN3d5gyzNzS3hanlF59
         yGZg==
X-Gm-Message-State: AOAM531TKCejjcQ+BHnDPeUXdEpHGvAts9oACtDKfcEhaI7sZyKr4Z8+
        jJjRr6gjNugT0gpZCFXK3SU=
X-Google-Smtp-Source: ABdhPJzmRfIRtxfX2TmUBV9FUv804ykivnMXukGQi/nsjl71ZZPOPUO92RzYBtlR69rba/pBOxme0g==
X-Received: by 2002:a17:906:f153:: with SMTP id gw19mr16181240ejb.410.1624712257451;
        Sat, 26 Jun 2021 05:57:37 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id e7sm3755748ejm.93.2021.06.26.05.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 05:57:36 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH v2 0/3] Allow deferred execution of iomem_get_mapping()
Date:   Sat, 26 Jun 2021 12:57:32 +0000
Message-Id: <20210626125735.2868256-1-kw@linux.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

At the moment, the dependency on iomem_get_mapping() that is currently
used in the pci_create_resource_files() and pci_create_legacy_files()
stops us from completely retiring the late_initcall() that is used to
invoke pci_sysfs_init() when creating sysfs object for PCI devices.

This dependency on iomem_get_mapping() stops us from retiring the
late_initcall at the moment as when we convert dynamically added sysfs
objects, that are primarily added in the pci_create_resource_files() and
pci_create_legacy_files(), as these attributes are added before the VFS
completes its initialisation, and since most of the PCI devices are
typically enumerated in subsys_initcall this leads to a failure and an
Oops related to iomem_get_mapping() access.

See relevant conversations:
  https://lore.kernel.org/linux-pci/20210204165831.2703772-1-daniel.vetter@ffwll.ch/
  https://lore.kernel.org/linux-pci/20210313215747.GA2394467@bjorn-Precision-5520/

After some deliberation about the problem at hand, Dan Williams
suggested a solution to the problem, as per:
  https://lore.kernel.org/linux-pci/CAPcyv4i0y_4cMGEpNVShLUyUk3nyWH203Ry3S87BqnDJE0Rmxg@mail.gmail.com/

The idea is to defer execution of the iomem_get_mapping() to only when
the sysfs open callback is run, and thus removing the reliance of
fs_initcalls to complete before any other sub-system that uses the
iomem_get_mapping().

Currently, the PCI sub-system will benefit the most from this change
allowing for it to complete the transition from dynamically created to
static sysfs objects.

This series aims to take Dan Williams' idea through the finish line.

Related to:
  https://lore.kernel.org/linux-pci/20210527205845.GA1421476@bjorn-Precision-5520/
  https://lore.kernel.org/linux-pci/20210507102706.7658-1-danijel.slivka@amd.com/
  https://lore.kernel.org/linux-pci/20200716110423.xtfyb3n6tn5ixedh@pali/

	Krzysztof

---
Changes in v2:
  Added "Signed-off-by" and "Reviewed-by" from Dan Williams as per his
  feedback.
  Added third patch that renames struct bin_attribute member "mapping"
  to "f_mapping" to keep the naming consistent with struct file.  N.B.
  this patch can definitely be dropped as the rename is not required for
  anything else to work.

Krzysztof Wilczyński (3):
  sysfs: Invoke iomem_get_mapping() from the sysfs open callback
  PCI/sysfs: Pass iomem_get_mapping() as a function pointer
  sysfs: Rename struct bin_attribute member to f_mapping

 drivers/pci/pci-sysfs.c | 6 +++---
 fs/sysfs/file.c         | 4 ++--
 include/linux/sysfs.h   | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.32.0

