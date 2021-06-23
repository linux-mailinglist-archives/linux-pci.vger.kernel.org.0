Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F2A3B1E8B
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 18:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhFWQXY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 12:23:24 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:33418 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFWQXY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jun 2021 12:23:24 -0400
Received: by mail-ot1-f49.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so2533498otl.0;
        Wed, 23 Jun 2021 09:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=35WsYJT9YpRPnzEEhoqfjKbQt4vKvTmr17v8IGf8pkA=;
        b=sYAtF3zWwgT0vjuCBM1ozsHW6O+zcXHTrlpOn/qlwwtqe3hhzc0dL1xHVQC3tlXcD6
         40g6uk8yFFie9GKfV8MfBZ7ejiMeMwJzOk2YFce98HA88itoBVVgPsKqZBIxiZN2BIeI
         ZZ1Ys4SRgjYahkjZg6DtkDVTVnOhITfjHq7YvWX2b539UbyVFF0RcEeGCEWG6g53wXAO
         i0Uzb9GTeJXLdD/JXrC2tVg2VoqcUXJmD4oUJ3kGT4szkXzlXrQv0D1utPPGYPSNYTbp
         4WnUSLiIez/bWI3n9lMCpF+0WWSgajCooovSRyftgzt46tJmkW07C+VYWV/tO77aps0X
         lIoA==
X-Gm-Message-State: AOAM532qxeyZIe/VJN8kMK3epXDtRPfRShmqWJ6F06ndCOHH8oZgrj54
        N/FseOxXaSQmi3hU2yDisId+uHWJb18BxA+VilrCPQmbpmc=
X-Google-Smtp-Source: ABdhPJzBgjWy+VqeBJbt+KGxoD1N/UTshnFIiaEUPd2SEQOGfdsJ3Kqg/RQuV+59rHsN4vwCi3U7bejsvXkGw+6ep8U=
X-Received: by 2002:a9d:1905:: with SMTP id j5mr598865ota.321.1624465265283;
 Wed, 23 Jun 2021 09:21:05 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Jun 2021 18:20:54 +0200
Message-ID: <CAJZ5v0gcogmEi_-wcycEv77443_LT9w-7Ln_x1eiBm=mPiX9hA@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v5.13-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.13-rc8

with top-most commit 4d6035f9bf4ea12776322746a216e856dfe46698

 Revert "PCI: PM: Do not read power state in pci_enable_device_flags()"

on top of commit 13311e74253fe64329390df80bed3f07314ddd61

 Linux 5.13-rc7

to receive a power management fix for 5.13-rc8.

This reverts a recent PCI power management commit that causes
initialization issues to appear on some systems.

Thanks!


---------------

Rafael J. Wysocki (1):
      Revert "PCI: PM: Do not read power state in pci_enable_device_flags()"

---------------

 drivers/pci/pci.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)
