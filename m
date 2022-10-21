Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB463607E63
	for <lists+linux-pci@lfdr.de>; Fri, 21 Oct 2022 20:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJUStF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Oct 2022 14:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJUSs6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Oct 2022 14:48:58 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB82E25ED00;
        Fri, 21 Oct 2022 11:48:53 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id s3so2208151qtn.12;
        Fri, 21 Oct 2022 11:48:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a/KYI9SK+qNSpAsWbexUxXHKrMUPsGkfv1dKVsoZ6ks=;
        b=TEkdgSEZrdYoFEEEyW8Bgp261fLwPRJhTCmbPJ69MyF6oPURxSfNBpYIAbrg3fIT8h
         0+QFuXdSEn9AB9mPnolu+vTC4lky59t/0tsEL59waMLeLdzzbKt3IyoWv3wJtlnoUxEk
         4vf2menKV2ha7e4oP83isGA0FuJfn+zoe2gYL/lhFogLv8DwFD3wytOHkaDpVdfGfDgj
         BwH8/rRHARPxGz5fZRiftlwld9PT6qdPkqdhTF39TQY15q4zPtsZjBC37K5v+C2SeYsz
         2qD3MKCWTHcxVZhYdndQf+Bf7mzp1c68IFWLQCzed7bM75Gj+i9I20r2RHBEnpLL7B6C
         vldA==
X-Gm-Message-State: ACrzQf2niC9VA922sTwO6eQZvsds4llQlM5nltRNOrdhc2FIVXi0yJ/3
        zfSrKnXjGEcMFXflpMpgayVc+SW6NW9drlIjV+JV8MDOoQk=
X-Google-Smtp-Source: AMsMyM5h8taKdI0Fx9Ss5YZ4HdCE9r2NTegkaW5KoWbHvmHyWrFuBajq52N5ZYj1uvE/KV2XxNzHnwqzM4xvm79kUOk=
X-Received: by 2002:a05:622a:620a:b0:35c:bf9e:8748 with SMTP id
 hj10-20020a05622a620a00b0035cbf9e8748mr17957110qtb.494.1666378133055; Fri, 21
 Oct 2022 11:48:53 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 Oct 2022 20:48:42 +0200
Message-ID: <CAJZ5v0h6OWoyO3om5GjsU-6+jPcXPiR-p+4LA22YD6-ptpnhbg@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.1-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.1-rc2

with top-most commit 3f8deab61ea86d738a1e7fdf95e9ad2bf08d14b8

 Merge branches 'acpi-scan', 'acpi-resource', 'acpi-apei',
'acpi-extlog' and 'acpi-docs'

on top of commit 9abf2313adc1ca1b6180c508c25f22f9395cc780

 Linux 6.1-rc1

to receive ACPI fixes for 6.1-rc2.

These fix 3 issues introduced during the 6.1 merge window (ACPI/PCI,
device enumeration and documentation) and some other ones found
recently.

Specifics:

 - Add missing device reference counting to acpi_get_pci_dev() after
   changing it recently (Rafael Wysocki).

 - Fix resource list walk in acpi_dma_get_range() (Robin Murphy).

 - Add IRQ override quirk for LENOVO IdeaPad and extend the IRQ
   override warning message (Jiri Slaby).

 - Fix integer overflow in ghes_estatus_pool_init() (Ashish Kalra).

 - Fix multiple error records handling in one of the ACPI extlog driver
   code paths (Tony Luck).

 - Prune DSDT override documentation from index after dropping it (Bagas
   Sanjaya).

Thanks!


---------------

Ashish Kalra (1):
      ACPI: APEI: Fix integer overflow in ghes_estatus_pool_init()

Bagas Sanjaya (1):
      Documentation: ACPI: Prune DSDT override documentation from index

Jiri Slaby (SUSE) (2):
      ACPI: resource: do IRQ override on LENOVO IdeaPad
      ACPI: resource: note more about IRQ override

Rafael J. Wysocki (1):
      ACPI: PCI: Fix device reference counting in acpi_get_pci_dev()

Robin Murphy (1):
      ACPI: scan: Fix DMA range assignment

Tony Luck (1):
      ACPI: extlog: Handle multiple records

---------------

 Documentation/admin-guide/acpi/index.rst |  1 -
 drivers/acpi/acpi_extlog.c               | 33 ++++++++++++---------
 drivers/acpi/apei/ghes.c                 |  2 +-
 drivers/acpi/pci_root.c                  |  1 +
 drivers/acpi/resource.c                  | 49 +++++++++++++++++++++-----------
 drivers/acpi/scan.c                      |  7 +++--
 include/acpi/ghes.h                      |  2 +-
 7 files changed, 60 insertions(+), 35 deletions(-)
