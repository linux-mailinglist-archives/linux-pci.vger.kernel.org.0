Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B95964B575
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 11:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfFSJvc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 05:51:32 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45502 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfFSJvb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jun 2019 05:51:31 -0400
Received: by mail-oi1-f196.google.com with SMTP id m206so10033258oib.12;
        Wed, 19 Jun 2019 02:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=UJbr7/phPEcDTZVXC/bckou8HWl+paGsMx0R3z/uC48=;
        b=WMQwHRcgQPWB1zx7OT6b+skLoBy5W0ZZMLpjIO0Wd9twQf8f/YXUavJtbmwv4QSmVu
         QodO/unqjBefGWY3lb30y99ObXkSGi+sXyxO+iN7gJlx3RVqN7jxrc85OU4TN4i5UAwQ
         YJTn7WU3ofsSzBdMy7jHjffldzzybzLHr/eURqWqFpAgr4dzG0JqXj+g9VsMtzhTNEHf
         cy+r2VlSazqM+zKFRWoiLj8hrEAA56WTiUL1/cQZr29T295fD131iwlVwiBN4Mknmuxx
         ZZCntw7iJU/zut8egcCigWzZodqtyhwr3HNYl1HAgqbiRxTR8DMrDwwJbtGTru/EcCxZ
         4R6Q==
X-Gm-Message-State: APjAAAUe5i7YnfnhBu2RIHFSsDb9I3StVdS2IzC3F/8jz038UfxE/WWw
        +0UKMoLivtujSdEHukFv1zp1eUM5PG303kGrkhbZTm7X
X-Google-Smtp-Source: APXvYqxJhL4UK1SJOJA0owPbeMrKSSBECfxygU6EJI2tzL6c266q3fjJDmh+UqXmzv/u+42BIG9yb+pEnyNP8TziDDw=
X-Received: by 2002:aca:4e89:: with SMTP id c131mr2241000oib.57.1560937890890;
 Wed, 19 Jun 2019 02:51:30 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Jun 2019 11:51:19 +0200
Message-ID: <CAJZ5v0hbF4i-mJ6thnu8HRNcAXBrw4=vqQG+ikufB2z3q82F4g@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v5.2-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
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
 pm-5.2-rc6

with top-most commit 3e26c5feed2add218046ecf91bab3cfa9bf762a6

 PCI: PM: Skip devices in D0 for suspend-to-idle

on top of commit d1fdb6d8f6a4109a4263176c84b899076a5f8008

 Linux 5.2-rc4

to receive a power management fix for 5.2-rc6.

This prevents PCI bridges in general (and PCIe ports in particular)
from being put into low-power states during system-wide suspend
transitions if there are any devices in D0 below them and refines
the handling of PCI devices in D0 during suspend-to-idle cycles.

Thanks!


---------------

Rafael J. Wysocki (1):
      PCI: PM: Skip devices in D0 for suspend-to-idle

---------------

 drivers/pci/pci-driver.c | 47 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 12 deletions(-)
