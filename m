Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646BB426FAC
	for <lists+linux-pci@lfdr.de>; Fri,  8 Oct 2021 19:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbhJHRkd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Oct 2021 13:40:33 -0400
Received: from mail-oo1-f52.google.com ([209.85.161.52]:33338 "EHLO
        mail-oo1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbhJHRkb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Oct 2021 13:40:31 -0400
Received: by mail-oo1-f52.google.com with SMTP id u5-20020a4ab5c5000000b002b6a2a05065so2013954ooo.0;
        Fri, 08 Oct 2021 10:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=qeZizzmR8ulBQa65JNtXpCSROdVDInw2hIpSGf8jvqI=;
        b=E2UHZPE8EgUhtrYzFM+zOUsfv+8pVFQpD6xMwYIpMuzXZZx6MsHxRew/s8UjB1J5Mw
         y4/3h8yqxwVKht2+/4U/bOqhgWr9ot+F7ItlP6xMKq2qmf/CHxVTTMCyyiRkKt3t/kGx
         SwZ91R630Dh/dOlY+PIajTW3954Z/7svk6niuAO7RSrI2/hPf6goW0lhaev4w7U+qzC8
         3cUx/SowSLb+tLBs46toNUhaRzU5s/XOmkxddc6giPkEoey0YEeD7prKYinsVPcRjE/6
         jrx9YIkuKDDUx/mJSoWU/6XZw9lyDfjEpffYphUWSSkKNC6kYgHnb5k03jg8FOQMMaKu
         0eDA==
X-Gm-Message-State: AOAM533y2mIsXgCwhZEs2SXc5rNUEz9Pxq3rFaK/0TQiMxEmS+zIpdvN
        XS7B744WnhKZd/u5/b4ECVx1cLbcjTbg4J1pRP6uK74ogZo=
X-Google-Smtp-Source: ABdhPJyqf7XOLvYAkW2U9Cpm0vLyKSBiroa9sT5ee89uOC9o2TKTIzTY/Zxj5QLQhhYwZ2zw/ft9jduuLCJghpCPRg0=
X-Received: by 2002:a4a:ca98:: with SMTP id x24mr8772240ooq.91.1633714715818;
 Fri, 08 Oct 2021 10:38:35 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Oct 2021 19:38:25 +0200
Message-ID: <CAJZ5v0gkdZRZRww8pXin+=xVQ+sCe-w7kS=NkFiSbcPSthTD+A@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v5.15-rc5
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
 acpi-5.15-rc5

with top-most commit 3fb937f441c64af1eec60bfd3732f64001fcc534

 PCI: ACPI: Check parent pointer in acpi_pci_find_companion()

on top of commit 9e1ff307c779ce1f0f810c7ecce3d95bbae40896

 Linux 5.15-rc4

to receive an ACPI fix for 5.15-rc5.

This fixes a recent ACPI-related regression in the PCI subsystem
that introduced a NULL pointer dereference possible to trigger
from user space via sysfs on some systems.

Thanks!


---------------

Rafael J. Wysocki (1):
      PCI: ACPI: Check parent pointer in acpi_pci_find_companion()

---------------

 drivers/pci/pci-acpi.c | 3 +++
 1 file changed, 3 insertions(+)
