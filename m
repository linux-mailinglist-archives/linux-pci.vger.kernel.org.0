Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DAD3DAFD9
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 01:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhG2Xcx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 19:32:53 -0400
Received: from mail-pj1-f49.google.com ([209.85.216.49]:38471 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhG2Xcw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jul 2021 19:32:52 -0400
Received: by mail-pj1-f49.google.com with SMTP id mz5-20020a17090b3785b0290176ecf64922so18065957pjb.3
        for <linux-pci@vger.kernel.org>; Thu, 29 Jul 2021 16:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=biN1hl2/e3cW/QbOjvBOrF1jLg4fdPkpI3WYfynWCaA=;
        b=ckNMC1QYVpAnwxIZ+3R5hpzVAIRJnRw8R6hJzyvfgQir3ItMYYIsUte1B9vx2b8DAn
         KjoJZzKXhf09BTxxkmUVi9IgfsW9Sko48kwCZ1WTanB63n4uogph6aA90jp8RRK/XIcf
         KVatVAJ94BV61cWEWi+wKAQ2lHQeuAjdrw2udCxn+gMrxVOeG00O5sRVSGhSXSadjeFl
         ETobA64lwq0U2/AvrBjA19EIX1YnNKCtYW+uGwxZ11SGodIk/i6XvuWXrL89BpXepUeM
         qIr5r0sqMWUdglJNzO4A2npMcNYYmNuct7bmgB3X4TIClXY8anWWiWv/xkdEHXxRsJBq
         ppzw==
X-Gm-Message-State: AOAM531LpBjRhl7yxqxfy5JMVI4zsitDSxNDJBsU5Hwn5aFJSoCu29gF
        0/LrYrPtLfHrwacZvDIKQTk=
X-Google-Smtp-Source: ABdhPJwnvs3Fx6rNKv4ktbYfKecjvrPO7+aoq84dw+39k3x9ELFRW+BQXvwPaxgjriZ3HgRVCzUqaQ==
X-Received: by 2002:a65:6243:: with SMTP id q3mr74529pgv.297.1627601567366;
        Thu, 29 Jul 2021 16:32:47 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id d22sm4843325pfo.88.2021.07.29.16.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 16:32:46 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH v3 0/2] Allow deferred execution of iomem_get_mapping()
Date:   Thu, 29 Jul 2021 23:32:33 +0000
Message-Id: <20210729233235.1508920-1-kw@linux.com>
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
Changes in v3:
  Squashed first two patches from v2 into a single patch to resolve
  compile time issues.
  Carried over Dan Williams' review from v2 as there are no code or
  functional changes.

Changes in v2:
  Added "Signed-off-by" and "Reviewed-by" from Dan Williams as per his
  feedback.
  Added third patch that renames struct bin_attribute member "mapping"
  to "f_mapping" to keep the naming consistent with struct file.  N.B.
  this patch can definitely be dropped as the rename is not required for
  anything else to work.

Krzysztof Wilczyński (2):
  sysfs: Invoke iomem_get_mapping() from the sysfs open callback
  sysfs: Rename struct bin_attribute member to f_mapping

 drivers/pci/pci-sysfs.c | 6 +++---
 fs/sysfs/file.c         | 4 ++--
 include/linux/sysfs.h   | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.32.0

