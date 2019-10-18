Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B319DC0AF
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2019 11:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391069AbfJRJRp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Oct 2019 05:17:45 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35817 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389986AbfJRJRp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Oct 2019 05:17:45 -0400
Received: by mail-oi1-f194.google.com with SMTP id x3so4651453oig.2;
        Fri, 18 Oct 2019 02:17:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=j8z1SM48UZuUXU8cTwzQych7cq4zT468OcaLYrLAHoc=;
        b=g1TTJELLzSCQ96x5h+HOZFbeCaPUQuUYugOqk5Qw0IVZSrFDaHLv9EddoK4FbJdtdp
         spSg6Jr3AdDpen20RUice/YTGmUwkUs6n+I3OheMK9KX4mVr+ndYzwk05rPmM3+y9j4U
         GD+UPiyPIClzcK5LYt3KqB7sSTfyKbycKPvi7lGvcbkFomJYGg6OHOwlVtdVWB07ZB2G
         yawkf+Z9w41QdLvGCRQUCx7Y3HBmQbjRhJZ3nTWuzrlTJxjnnJqPmqrvyfI9/x+heEQh
         JTdoL1zAVPwCS8MaB6/LDfSbv1qTWA3AVhCbfzdY+uLRzZG7nXIY9WKQ0ufTopA8rYxx
         jCZw==
X-Gm-Message-State: APjAAAVcjaFIwyXV7Pueuqq8zhnoVKl25FOnpd6mpcP3nfrLv2E/J7TG
        GY5lFgIfYwrY4he6F4k8Z1UYvjH7DyW0FvmyJPaI/xSW
X-Google-Smtp-Source: APXvYqzyYAXhAoQkimCi9kQHw3PEfQL51Fk/qbhnBd3+8Oku0qmZ/h0tjCh8EffnfNqaU2khxg3i+VXVJXmBVeYYec8=
X-Received: by 2002:aca:d706:: with SMTP id o6mr7309802oig.57.1571390264244;
 Fri, 18 Oct 2019 02:17:44 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Oct 2019 11:17:32 +0200
Message-ID: <CAJZ5v0iMdUWVv8G1D075eSEBOMoqUfoWC_ik6qy5CxNapUo1xg@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.4-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.4-rc4

with top-most commit b23eb5c74e6eb6a0b3fb9cf3eb64481a17ce1cd1

 Merge branches 'pm-cpufreq' and 'pm-sleep'

on top of commit 4f5cafb5cb8471e54afdc9054d973535614f7675

 Linux 5.4-rc3

to receive power management fixes for 5.4-rc4.

These include a fix for a recent regression in the ACPI CPU
performance scaling code, a PCI device power management fix,
a system shutdown fix related to cpufreq, a removal of an ACPI
suspend-to-idle blacklist entry and a build warning fix.

Specifics:

 - Fix possible NULL pointer dereference in the ACPI processor
   scaling initialization code introduced by a recent cpufreq
   update (Rafael Wysocki).

 - Fix possible deadlock due to suspending cpufreq too late during
   system shutdown (Rafael Wysocki).

 - Make the PCI device system resume code path be more consistent
   with its PM-runtime counterpart to fix an issue with missing
   delay on transitions from D3cold to D0 during system resume from
   suspend-to-idle on some systems (Rafael Wysocki).

 - Drop Dell XPS13 9360 from the LPS0 Idle _DSM blacklist to make it
   use suspend-to-idle by default (Mario Limonciello).

 - Fix build warning in the core system suspend support code (Ben
   Dooks).

Thanks!


---------------

Ben Dooks (1):
      PM: sleep: include <linux/pm_runtime.h> for pm_wq

Mario Limonciello (1):
      ACPI: PM: Drop Dell XPS13 9360 from LPS0 Idle _DSM blacklist

Rafael J. Wysocki (3):
      cpufreq: Avoid cpufreq_suspend() deadlock on system shutdown
      PCI: PM: Fix pci_power_up()
      ACPI: processor: Avoid NULL pointer dereferences at init time

---------------

 drivers/acpi/processor_perflib.c | 10 ++++++----
 drivers/acpi/processor_thermal.c | 10 ++++++----
 drivers/acpi/sleep.c             | 13 -------------
 drivers/base/core.c              |  3 +++
 drivers/cpufreq/cpufreq.c        | 10 ----------
 drivers/pci/pci.c                | 24 +++++++++++-------------
 kernel/power/main.c              |  1 +
 7 files changed, 27 insertions(+), 44 deletions(-)
