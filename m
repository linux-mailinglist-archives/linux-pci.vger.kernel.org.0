Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39006902A2
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 15:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfHPNLo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 09:11:44 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45015 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfHPNLj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Aug 2019 09:11:39 -0400
Received: by mail-ot1-f66.google.com with SMTP id w4so9454706ote.11;
        Fri, 16 Aug 2019 06:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lWcyAmV1Uxrxcs0AfEFdOQKYxj1U/I3IYlhoxoBaFv4=;
        b=d1exZ6gFOjqyrrwjklAFnTna3w5cB9QDE/sqHy9aswxR+Dj4p+ebYC+BWbYRRp+dSh
         qvm0zOI76zvbhY5Qxpz1WZVwtbdNofRFAPWFTV++lfXkXW/9BGgLDBaNn/wft9LlGxlU
         Fi8iFg1wqAjA7kjWomBt6uQJIBUBmIic3P28T+a84Ulltmfe3kJeFvfqFyJi9wM32qBm
         rFCzHQdFaitkWqkHpLNPEbN/0XDv0L6DtSxO3Yr2LUQ3GG+M0GUPLxHW8DMqdNEBTV8X
         XUP9q8BNsuEXDS06z5W/GOgtpCrI303bPlfVc177BwQXP8KPYktPVI6OiMRrl4pFjGdi
         ljXw==
X-Gm-Message-State: APjAAAVbL0ncbXuwtJ7YVqwE1S8Z/aekzmew5LPnLc8z8tw5qKylK6/y
        6i2pzCH03ZmnTKkH2H2vLnpqSCrgShte45V5vAI=
X-Google-Smtp-Source: APXvYqxP4hYrPfDsQFlbREk8hpApTYfpZUfHTFRUvPveFErL5wlerojyl24HOL2KJd1oY7iD0OgXXobaKRQhNdUEC84=
X-Received: by 2002:a9d:674c:: with SMTP id w12mr4311320otm.118.1565961098308;
 Fri, 16 Aug 2019 06:11:38 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Aug 2019 15:11:27 +0200
Message-ID: <CAJZ5v0j4ezEuK1dk0J3wwjSuudzjhKWTXzJL=EkE1QG39HKRiw@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.3-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.3-rc5

with top-most commit a3ee2477c45f73184a64d9c6cf97855a52732dc6

 Merge branch 'pm-cpufreq'

on top of commit d45331b00ddb179e291766617259261c112db872

 Linux 5.3-rc4

to receive power management fixes for 5.3-rc5.

These add a check to avoid recent suspend-to-idle power regression on
systems with NVMe drives where the PCIe ASPM policy is "performance"
(or when the kernel is built without ASPM support), fix an issue
related to frequency limits in the schedutil cpufreq governor and fix a
mistake related to the PM QoS usage in the cpufreq core introduced
recently.

Specifics:

 - Disable NVMe power optimization related to suspend-to-idle added
   recently on systems where PCIe ASPM is not able to put PCIe links
   into low-power states to prevent excess power from being drawn by
   the system while suspended (Rafael Wysocki).

 - Make the schedutil cpufreq governor handle frequency limits changes
   properly in all cases (Viresh Kumar).

 - Prevent the cpufreq core from treating positive values returned
   by dev_pm_qos_update_request() as errors (Viresh Kumar).

Thanks!


---------------

Rafael J. Wysocki (2):
      PCI/ASPM: Add pcie_aspm_enabled()
      nvme-pci: Allow PCI bus-level PM to be used if ASPM is disabled

Viresh Kumar (2):
      cpufreq: dev_pm_qos_update_request() can return 1 on success
      cpufreq: schedutil: Don't skip freq update when limits change

---------------

 drivers/cpufreq/cpufreq.c        |  2 +-
 drivers/nvme/host/pci.c          | 13 ++++++++++---
 drivers/pci/pcie/aspm.c          | 20 ++++++++++++++++++++
 include/linux/pci.h              |  2 ++
 kernel/sched/cpufreq_schedutil.c | 14 ++++++++++----
 5 files changed, 43 insertions(+), 8 deletions(-)
