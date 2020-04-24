Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131531B7ECA
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 21:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgDXTW2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 15:22:28 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:42299 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbgDXTW1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Apr 2020 15:22:27 -0400
Received: by mail-oo1-f67.google.com with SMTP id e18so2356484oot.9;
        Fri, 24 Apr 2020 12:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=h5tgKPGX1pMT2Yv1+/KaLuaJr7i5eoDwlgF0bQgOpfw=;
        b=j0yIIL4gqfca7b+edl4fupGCvTZNzsX2zzVoyKUey4bbUWKs7NMx6T+AvgYn0udtUJ
         9iJ+OvhACWpQSBBl0dJ0pYdnEK75eYDqvoeHNqdfUA96qmLOKQ42gMYYTi3tZb7NLA41
         dkClEZs0m6OGMPjD9jKog3hTiq2ST2p14wQcruGze4MX7oaD6aiBTuNhmqzsbeC1d5my
         T2yYB6u/wYWV+6hQOhDLF7TKPVj2BVcXD9lCRGPtFzXPfBSY58fo29EgVFFQ6atqerQC
         jg1GF0/S+HMljxdkscEsZMTq0ajszPzFdnTB+Sa+IJBTq4BxtPz8/VqBQ2YBaGkutpah
         z5qA==
X-Gm-Message-State: AGi0PuaoI3G5ASWTLK916JJ8rDHqL19Yddz+HUEwa6GvT2FbVte+yn87
        VANHqu0Z4pjRU08pIpk8fQFRW5iyTxgfU7JLaWYx9NkF
X-Google-Smtp-Source: APiQypKFPdpQHP7GUsDJMyDJJDYGh6iEoEASKq5idVwW/Z+UYWypYUGo0H5G7o+A0ewYQ0GCER42jZXOURsGLcZI9M4=
X-Received: by 2002:a05:6820:245:: with SMTP id b5mr2075832ooe.75.1587756142064;
 Fri, 24 Apr 2020 12:22:22 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Apr 2020 21:22:11 +0200
Message-ID: <CAJZ5v0i=yOFpKuXeGnLh25xyvJsKcr9-3iSnHq7nA0_WMQKQwA@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v5.7-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.7-rc3

with top-most commit 0db0d142e2d2c7522764511f45c0d3c15dbd8be0

 Merge branch 'acpi-pci'

on top of commit ae83d0b416db002fe95601e7f97f64b59514d936

 Linux 5.7-rc2

to receive ACPI fixes for 5.7-rc3.

These drop a lid status quirk for Asus T200TA that is not necessary
any more and clean up a resource management inconsistency in the
PCI IRQ link configuration code.

Both changes from Hans de Goede.

Thanks!


---------------

Hans de Goede (2):
      ACPI/PCI: pci_link: use extended_irq union member when setting
ext-irq shareable
      ACPI: button: Drop no longer necessary Asus T200TA lid_init_state quirk

---------------

 drivers/acpi/button.c   | 12 ------------
 drivers/acpi/pci_link.c |  4 ++--
 2 files changed, 2 insertions(+), 14 deletions(-)
