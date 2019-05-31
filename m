Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 817A230B55
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2019 11:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfEaJWJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 May 2019 05:22:09 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37781 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfEaJWJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 May 2019 05:22:09 -0400
Received: by mail-ot1-f68.google.com with SMTP id r10so8520248otd.4;
        Fri, 31 May 2019 02:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZmrjcTQQbB0JQZLmh1TVPDsN8UglFZ3+RMTJhU5OjIc=;
        b=QS/DLuCASwSPZDty8XIYWQRqBRNHUOz9crdECIR7GqAcL3ApTSdp/nUyrid7aJsvb1
         2F/FhjS82VQKHIJSHrXNkf/y2I6tF2Ijc+qwRzdVaa6JAyq2ZN9tVFioCGG06enmM2pF
         /ebWRgoX0Xy//gaySdaqExgrXiNcCmyRRu78/wMDQ+IfpUlPpYjOEE/sD8wQyIUeVabt
         5onxC9pXF2O8xkEd7L4fKLbm8bws5JeFc3WSGYHdRrwMiqHGVTSS/5bMav5QiUIuHjAy
         yBTKOctmwCkU0LS6SklyPLzNL/pFjno1hPR97oDQdi6Hi/0/Q5Q0z66fxQAlYj7YcGwG
         oWIQ==
X-Gm-Message-State: APjAAAXj814XAp7dIYnRMeFM0otBNJbKGYXWvSFvril3BTf5uxQHHIZL
        6kSHrmiBIdEh4cYuGZsqCc+E4saGJAtzFtZ8feAe57c1
X-Google-Smtp-Source: APXvYqzqfwl9QjluHmd3fDEh8DMTSFn24beKN/U0UmB9vwHpTF6jfEYs6fPDtDfvsiuZobYbtmpwlolHi83/lykF9Wk=
X-Received: by 2002:a9d:6b98:: with SMTP id b24mr971451otq.189.1559294528593;
 Fri, 31 May 2019 02:22:08 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 31 May 2019 11:21:57 +0200
Message-ID: <CAJZ5v0j_uQxWZRjJ_=S1b=NRpLfyf_0KHfyPwSj30SRWr9RzHg@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.2-rc3
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
 pm-5.2-rc3

with top-most commit d491f2b75237ef37d8867830ab7fad8d9659e853

 PCI: PM: Avoid possible suspend-to-idle issue

on top of commit cd6c84d8f0cdc911df435bb075ba22ce3c605b07

 Linux 5.2-rc2

to receive power management fixes for 5.2-rc3.

These fix three issues in the system-wide suspend and hibernation
area related to PCI device PM handling by suspend-to-idle, device
wakeup optimizations and arbitrary differences between suspend and
hiberantion.

Specifics:

 - Modify the PCI bus type's PM code to avoid putting devices left
   by their drivers in D0 on purpose during suspend to idle into
   low-power states as doing that may confuse the system resume
   callbacks of the drivers in question (Rafael Wysocki).

 - Avoid checking ACPI wakeup configuration during system-wide
   suspend for suspended devices that do not use ACPI-based wakeup
   to allow them to stay in suspend more often (Rafael Wysocki).

 - The last phase of hibernation is analogous to system-wide suspend
   also because on platforms with ACPI it passes control to the
   platform firmware to complete the transision, so make it indicate
   that by calling pm_set_suspend_via_firmware() to allow the drivers
   that care about this to do the right thing (Rafael Wysocki).

Thanks!


---------------

Rafael J. Wysocki (3):
      ACPI/PCI: PM: Add missing wakeup.flags.valid checks
      ACPI: PM: Call pm_set_suspend_via_firmware() during hibernation
      PCI: PM: Avoid possible suspend-to-idle issue

---------------

 drivers/acpi/device_pm.c |  4 ++--
 drivers/acpi/sleep.c     | 39 ++++++++++++++++++++++++---------------
 drivers/pci/pci-acpi.c   |  3 ++-
 drivers/pci/pci-driver.c | 17 ++++++++++++++++-
 include/linux/pci.h      |  1 +
 include/linux/suspend.h  |  2 +-
 kernel/power/hibernate.c |  4 ++--
 7 files changed, 48 insertions(+), 22 deletions(-)
