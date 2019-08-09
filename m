Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC7D287486
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2019 10:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405947AbfHIIrl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Aug 2019 04:47:41 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39251 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405932AbfHIIrk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2019 04:47:40 -0400
Received: by mail-ot1-f65.google.com with SMTP id r21so123818616otq.6;
        Fri, 09 Aug 2019 01:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SnWypE8I5rfMeHeIUzc3s634zV9WzHWr9FpC9i6scCA=;
        b=Ff3UGx44dR96b4TG10nLH/tw0e2NLFXBXHVAEjrkz0c8Sbcn2CvA+PTa3jiLWDIXQg
         KKH5y9V5DfxOB6IE54e6SiKMN/BH99PUXsV14m8XBOqginEbCnjJX3E7GYGOiVJmnAQL
         XZWguvw/ugsgMoOJ+/CA2TBgz0CFK4AQpZA+by2J8bU9+oLkZZVawKQunnvvOCRiQC7d
         UGb7LsPGXESj10mCaasL/YypUcxYqVdnjRzWzEi6GGbKZzj/sEA7rNhbJdJAw4f+Vp5p
         EMkbrvsmQYAtpBSnq9rKTkGnULglSCDexeIWiPbd9ugvLsk3MdNYNxfnfoVqlhMcXjMj
         Q37g==
X-Gm-Message-State: APjAAAXieHg5kuvoq+6WBFRmZeH5Dcu19JRQCOSB30KtH/LdlEIp0TnN
        F6c4gSJa6Jl0zX03A4zlQPBWeXtBer4kkodls/Y=
X-Google-Smtp-Source: APXvYqxZ8zzjZcAFE6v568A8l6hKRIdFJDsOtTJCB7GaiHgGa7XvQHdM/hQi7f8P2Zq/Phdhhs1JtFx4jsQ7w5RYa6o=
X-Received: by 2002:aca:5a41:: with SMTP id o62mr5639087oib.110.1565340460061;
 Fri, 09 Aug 2019 01:47:40 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 9 Aug 2019 10:47:28 +0200
Message-ID: <CAJZ5v0jeVsVCC70s-jVphdMH9zx+pFTcMm-EhHcthJCtDxwkvQ@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v5.3-rc3
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
 pm-5.3-rc4

with top-most commit 0617bdede5114a0002298b12cd0ca2b0cfd0395d

 Revert "PCI: Add missing link delays required by the PCIe spec"

on top of commit e21a712a9685488f5ce80495b37b9fdbe96c230d

 Linux 5.3-rc3

to receive a power management fix for 5.3-rc4.

This reverts a recent PCI power management change that caused
problems to occur on multiple systems (Mika Westerberg).

Thanks!


---------------

Mika Westerberg (1):
      Revert "PCI: Add missing link delays required by the PCIe spec"

---------------

 drivers/pci/pci.c               | 29 +++++++-----------
 drivers/pci/pci.h               |  1 -
 drivers/pci/pcie/portdrv_core.c | 66 -----------------------------------------
 3 files changed, 10 insertions(+), 86 deletions(-)
