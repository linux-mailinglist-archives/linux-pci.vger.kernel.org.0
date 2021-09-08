Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B21403C8A
	for <lists+linux-pci@lfdr.de>; Wed,  8 Sep 2021 17:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352043AbhIHPdv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Sep 2021 11:33:51 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:46935 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352096AbhIHPdv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Sep 2021 11:33:51 -0400
Received: by mail-ot1-f51.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso3441521ott.13;
        Wed, 08 Sep 2021 08:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=wCpW8P/qcfUBAUP9yX0etIAnVGW4oa2u6cdb6qiSrnk=;
        b=Sw/fTWu1Wl5t2ppekAGkn2VAi4O4pncaXfQ7swW/XpUK4q/mY0QA9UKTeVT4x1Uy4s
         Lz/B+bwI9MAXVSil7c3T6l2fUThLaPqRSrFohB/wjG2us5+dGWnh2qXZ8k48q/AIKLXT
         Tvmzj5THeof63lDWs/776kGmiVsLvKL29+3n5dg9OFLzVxwUnD2pKmfkB+YOZDcC+muo
         DWN3ADt8OV5ZchWK1IiduiISFvXGiFq8c1vMh5mr4KyJbQwoL5/VqTREBYlR+79XoGZp
         wq5KhQvT0B714JU4DlCs7yXX6zp+LrICEysFZp71AO7yamN5JOllpdhp3vicMgEC0RSp
         XuHA==
X-Gm-Message-State: AOAM533KBYUDTtbfyjHt4PMPyB6qkGmqUceEq10V1o6Zo/ugJg809lOA
        dJWWxLUKpBv2rBL8x2IycfWzB6sZzLUewSUXv2RcCRlvEAE=
X-Google-Smtp-Source: ABdhPJwjDpAIAa6bP74QWXIdmK708YE7bbnCkp4tIEYhFyLQniE/ez5UxX+qKhH/TJs2LKWkh4/oLpULx1N70TlCDVU=
X-Received: by 2002:a9d:4d93:: with SMTP id u19mr3647281otk.86.1631115163066;
 Wed, 08 Sep 2021 08:32:43 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 8 Sep 2021 17:32:32 +0200
Message-ID: <CAJZ5v0isrxaOi_C50qO1S5t81xQZpnr-bunZp+Y_St+VuH6XxA@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v5.15-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.15-rc1-2

with top-most commit e543b10cd9d75309c820d2175200d09b2a62f249

 Merge branches 'acpi-pm' and 'acpi-docs'

on top of commit 6f1e8b12eec44ee047dc9e0a9544b2cfed739503

 Merge tag 'acpi-5.15-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more ACPI updates for 5.15-rc1.

These add ACPI support to the PCI VMD driver, improve suspend-to-idle
support for AMD platforms and update documentation.

Specifics:

 - Add ACPI support to the PCI VMD driver (Rafael Wysocki).

 - Rearrange suspend-to-idle support code to reflect the platform
   firmware expectations on some AMD platforms (Mario Limonciello).

 - Make SSDT overlays documentation follow the code documented by it
   more closely (Andy Shevchenko).

Thanks!


---------------

Andy Shevchenko (1):
      Documentation: ACPI: Align the SSDT overlays file with the code

Mario Limonciello (1):
      ACPI: PM: s2idle: Run both AMD and Microsoft methods if both are supported

Rafael J. Wysocki (1):
      PCI: VMD: ACPI: Make ACPI companion lookup work for VMD bus

---------------

 Documentation/admin-guide/acpi/ssdt-overlays.rst | 49 ++++++++--------
 drivers/acpi/x86/s2idle.c                        | 67 ++++++++++++---------
 drivers/pci/controller/vmd.c                     | 55 ++++++++++++++++++
 drivers/pci/host-bridge.c                        |  1 +
 drivers/pci/pci-acpi.c                           | 74 ++++++++++++++++++++++++
 include/linux/pci-acpi.h                         |  3 +
 6 files changed, 197 insertions(+), 52 deletions(-)
