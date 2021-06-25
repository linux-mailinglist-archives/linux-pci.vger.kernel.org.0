Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E3F3B4AF1
	for <lists+linux-pci@lfdr.de>; Sat, 26 Jun 2021 01:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhFYXdp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 19:33:45 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:37620 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhFYXdn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jun 2021 19:33:43 -0400
Received: by mail-ed1-f44.google.com with SMTP id i24so15632263edx.4
        for <linux-pci@vger.kernel.org>; Fri, 25 Jun 2021 16:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=grWbq2F+Cd1mhUpOOh41AdDJ1fHAAT0Gk3rXj3mM/e0=;
        b=luc5Lr0RtEXBVeqT6lQ/pogNx+obmPv/KrXLQ2AqoXi2FXmCWG+0gN/AoFCHw/r5Vm
         r879I3lKJ5HnZb4KIehhnZzvrj78cAAKKXeE5FJrOnYiLAUqQPXKNZ/G1kJzxtO0ke4w
         oNQJWSflpddgKDbSWT42NCZ3QL+bfyAtNZwyYLuvx0iPFE4MubORYkCBuv+TgmqxuHP/
         zBxmF7w/ZuDF4D/k5tBA3dtghwofRRd85OEL7s6xSmAnAAh+WryQdg5iKpws+jjEU9NI
         Py1VE4j/TXCKd4auHIF3qouD5wI2gs9Fq9X0NxXaIyO8TX+YpZSLG9bLIEW+TDeANDGO
         7xdQ==
X-Gm-Message-State: AOAM5337odEvdPYmTMuJQzwYQ2nTMsg/VKiWRIUS+4h79hw0zcmUON+T
        MJOBUI6ITvcsKPpwRGE6ZfI=
X-Google-Smtp-Source: ABdhPJxRXt20Wu1Zz7tjGF5rQgutsqmXp4iQ3kJPCFspK+pf1XGEhrymoP3kjSEVME0VlchlyD/WxQ==
X-Received: by 2002:a05:6402:4248:: with SMTP id g8mr18212498edb.368.1624663879755;
        Fri, 25 Jun 2021 16:31:19 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id b8sm4741015edr.42.2021.06.25.16.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 16:31:19 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        "Oliver O'Halloran" <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: [PATCH 0/2] Allow deferred execution of iomem_get_mapping()
Date:   Fri, 25 Jun 2021 23:31:16 +0000
Message-Id: <20210625233118.2814915-1-kw@linux.com>
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
suggested a solution to the problem, see:
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

Krzysztof Wilczyński (2):
  sysfs: Invoke iomem_get_mapping() from the sysfs open callback
  PCI/sysfs: Pass iomem_get_mapping() as a function pointer

 drivers/pci/pci-sysfs.c | 6 +++---
 fs/sysfs/file.c         | 2 +-
 include/linux/sysfs.h   | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.32.0

