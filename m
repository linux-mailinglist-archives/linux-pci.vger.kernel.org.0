Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 572E75A9C3
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2019 11:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfF2JHX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Jun 2019 05:07:23 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33676 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfF2JHX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Jun 2019 05:07:23 -0400
Received: by mail-ot1-f66.google.com with SMTP id q20so8521321otl.0;
        Sat, 29 Jun 2019 02:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Ry0ikm9jlJIGPa85x3qVakAXT3GF98XkEln9GjZGy08=;
        b=E69qwa8qQUd5RtGkz7SPJkWvSMxk7vArVhBA4nHx3WOIuL1NqgUMv9YUn7G4k5bTiw
         08NIKNaoXkp0VmIQDVdTPWL2z5y0x2w2EY3bFWyAS4/ENCseIZU0jPlzWda71fw6BkR6
         prYRBYLZE9pFmjR4Ovri7XXq2ElsmuzXmLBqGkiGPjYq7l5O0ClT9t0EzbIW48/EyiKM
         +JEepAVeNbPfpuNGGtNiNFW8CB8dWOhG+JBM6Ghg0cL3WJ+gb/28/m4H08wqwKAzbPa7
         RPw+wSZNUg691DAriBvu0cFOfpgMmprFp9ldRUL8fnpfEaATiONfcWMqrECbG4ZlIs+e
         EjPg==
X-Gm-Message-State: APjAAAVAZqUE/2FE6mKggO7mrhfKZYWMS/S7BRKZ04vF6amiZbcatGyo
        stybQSefByw9sYX/vgKKpVlwUFn3iLHuVS+um9WreTFf
X-Google-Smtp-Source: APXvYqwGyLH5570+dqH9wO99dggC8HFynAKWOaBFTQQyCjPw3pM+ZlRMu6ExF8TxHk0GYk5P1I9OlI5+Cs/AaAimzRU=
X-Received: by 2002:a9d:6a4b:: with SMTP id h11mr12133029otn.266.1561799242826;
 Sat, 29 Jun 2019 02:07:22 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 29 Jun 2019 11:07:09 +0200
Message-ID: <CAJZ5v0ieD3bohHtsk4dZtZL-oJF8NUz5MJ3p+zHvQ2McgaSqaw@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v5.2-rc7
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
 pm-5.2-rc7

with top-most commit 471a739a47aa7d582f0cdf9d392957d04632bae2

 PCI: PM: Avoid skipping bus-level PM on platforms without ACPI

on top of commit 4b972a01a7da614b4796475f933094751a295a2f

 Linux 5.2-rc6

to receive a PCI power management fix for 5.2-rc7.

This avoids skipping bus-level PCI power management during system
resume for PCIe ports left in D0 during the preceding suspend
transition on platforms where the power states of those ports
can change out of the PCI layer's control.

Thanks!


---------------

Rafael J. Wysocki (1):
      PCI: PM: Avoid skipping bus-level PM on platforms without ACPI

---------------

 drivers/pci/pci-driver.c |  8 ++++----
 include/linux/suspend.h  | 26 ++++++++++++++++++++++++--
 kernel/power/suspend.c   |  3 +++
 3 files changed, 31 insertions(+), 6 deletions(-)
