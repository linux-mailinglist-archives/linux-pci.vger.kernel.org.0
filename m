Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2644B2B22
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 17:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351822AbiBKQ6F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 11:58:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345503AbiBKQ5x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 11:57:53 -0500
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C3F1A1;
        Fri, 11 Feb 2022 08:57:52 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id p5so26544765ybd.13;
        Fri, 11 Feb 2022 08:57:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=g51Fp1R3lRSibqJYvJdP7FqiSwiq70ebeFxSVUv1uco=;
        b=q6uspWzv6EPpmaX4278d6mlsG0krRDSY3XJUqPTQbGpjv92n5mE1e9kZ58emFBffjo
         3Yt4yJHzwwnjxBJZK9jbMZzqkf+oZYVWkKaZAxuJ+CfDsD9YjXf8ucEDQ7uRIczoevN9
         QHpxrpQG6Ga58zW/jLUS/3NaPSOLDO3iGEG3Q8JWKI6/9wFMt08BD+OBLM/3pBG2ogDv
         rtKbyf8kMDRAewwopwe8jGRld9zZvO9BUPESG2KdDswhAnL8gyWG0a5IdG+AbC1Buyea
         /kmBzabcornejpPSjlmrFbv1xc2KzBedH4Q/vlKXoP1l5qbl1RUKzMnDFi9uJZzzeo70
         +nfA==
X-Gm-Message-State: AOAM531DTjvQuEpUhwa6hHndKJ9ne6MWaN9HxDsVEJu2d+6a4efVy3kW
        QFwlVWh8HAT5Tg58/eRO4es7/bPliRLKezZZl/0=
X-Google-Smtp-Source: ABdhPJycPb6bIjy4upo9Z/7f3JkChIuixCqNAyCDjPOHdQl4PLLD7bOGT3cWtGGJq82ABnpUxAr7xjC9AjJjsUSFKsg=
X-Received: by 2002:a81:8b4e:: with SMTP id e14mr2741411ywk.301.1644598671674;
 Fri, 11 Feb 2022 08:57:51 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Feb 2022 17:57:41 +0100
Message-ID: <CAJZ5v0i=QT9GjEgWcqT-+CUKL=aScS3S6NZLUDznN-fNBahVYw@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v5.17-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.17-rc4

with top-most commit 27a98fe60b033dfce95361abe368750994b8a78e

 Merge branch 'acpi-x86'

on top of commit dfd42facf1e4ada021b939b4e19c935dcdd55566

 Linux 5.17-rc3

to receive ACPI fixes for 5.17-rc4.

These revert two commits that turned out to be problematic and fix
two issues related to wakeup from suspend-to-idle on x86.

Specifics:

 - Revert a recent change that attempted to avoid issues with
   conflicting address ranges during PCI initialization, because it
   turned out to introduce a regression (Hans de Goede).

 - Revert a change that limited EC GPE wakeups from suspend-to-idle
   to systems based on Intel hardware, because it turned out that
   systems based on hardware from other vendors depended on that
   functionality too (Mario Limonciello).

 - Fix two issues related to the handling of wakeup interrupts and
   wakeup events signaled through the EC GPE during suspend-to-idle
   on x86 (Rafael Wysocki).

Thanks!


---------------

Hans de Goede (1):
      x86/PCI: revert "Ignore E820 reservations for bridge windows on
newer systems"

Mario Limonciello (1):
      ACPI: PM: Revert "Only mark EC GPE for wakeup on Intel systems"

Rafael J. Wysocki (2):
      ACPI: PM: s2idle: Cancel wakeup before dispatching EC GPE
      PM: s2idle: ACPI: Fix wakeup interrupts handling

---------------

 arch/x86/kernel/resource.c  | 23 +----------------------
 drivers/acpi/ec.c           | 10 ++++++++++
 drivers/acpi/sleep.c        | 15 +++++----------
 drivers/acpi/x86/s2idle.c   | 12 ++++--------
 drivers/base/power/wakeup.c | 41 ++++++++++++++++++++++++++++++++++-------
 include/linux/suspend.h     |  4 ++--
 kernel/power/main.c         |  5 ++++-
 kernel/power/process.c      |  2 +-
 kernel/power/suspend.c      |  2 --
 9 files changed, 61 insertions(+), 53 deletions(-)
