Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D086E423A03
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 10:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237824AbhJFIwx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Oct 2021 04:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237703AbhJFIwv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Oct 2021 04:52:51 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3970C061749;
        Wed,  6 Oct 2021 01:50:59 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id b34so1225365uad.8;
        Wed, 06 Oct 2021 01:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=BL8QLcwVPE63wCHG+vNdv8V4t1woCLSTLoZ2WOuIyh8=;
        b=NItt+JAXFsiXDAxC25l7cMHBeZ2jzPcRJ9PDKBVDkUH6zTzgdgSkaHBuQ40S3EjEsA
         I8EzN1BgXsxoKenGEd2okzKcDVWMU+bDeTmmoY1VvL6Ha6U6WqAvv69wPqPrPaKKjSZi
         5HEMRBZKXLO4xPIRRf7nizrYktKOKecctVXF4XnWGJW+SL7CBqqGbd0V68M7BI/ORnhj
         CxNabbkiFxtP3FiNVFUAUlWsxiwHZ3dYCnv5GGBVTgOPCQ67Qz58tCohTnSg6+aDdGRb
         94Of1VSdWgahRJEZabbo8fSPOz0J5BwEN4LXXN6OVhs2K+zlI8l316q8iXB4uGzgbWzW
         w+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BL8QLcwVPE63wCHG+vNdv8V4t1woCLSTLoZ2WOuIyh8=;
        b=AJp16mhsOqzZDi54n0IRFuiyN5MPfcqUJqUuJ/1XJyiywY+p/NPbjXU57iTkkJv78G
         5h9SpwOQnVaSF1lJ1o/ZMLsc2bnXvjEYd6Q2ccbCheH+Z9t6RbBvUIFYtlFb1zN3fiO4
         V8DPJq96mJNythcHte9UeZqBR0f1r+FpapQAp9jiZXss3S9n9pi2/I3o//OfiOpSk4be
         hBEcr1aZM+7I256ZYPWybgt3tOuITRdc4AY/t1igaQq74aR81UgMbLWHtIAEQX2jfpHH
         JodxXWYS5QKB5uWr4tAXXuZAaU8OJS+fHGcU5Y7PepG9ZewcXgZTEvzm4ycAN69Yzy2X
         eCrA==
X-Gm-Message-State: AOAM530n/UBz8QavolUi+KqcIns15/lfQginnwqvgw6ymarXb9snaWm8
        R0ZZxAgY+cWxqpxR/8viH7jPUnvm9rhm+vZqqA==
X-Google-Smtp-Source: ABdhPJxj0mUNDJSuGV0n1ZYXbOQbUs75og5WVxlDe7KfcKvJ6koy/ZLey7IH/ccTxCq7HjOIcz0dOMjtGe2A08S4m+o=
X-Received: by 2002:ab0:60b6:: with SMTP id f22mr5768693uam.59.1633510258973;
 Wed, 06 Oct 2021 01:50:58 -0700 (PDT)
MIME-Version: 1.0
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Wed, 6 Oct 2021 09:50:48 +0100
Message-ID: <CALjTZvbzYfBuLB+H=fj2J+9=DxjQ2Uqcy0if_PvmJ-nU-qEgkg@mail.gmail.com>
Subject: [REGRESSION][BISECTED] 5.15-rc1: Broken AHCI on NVIDIA ION (MCP79)
To:     tglx@linutronix.de
Cc:     maz@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Thomas,

I'm sorry for reporting this so late in the cycle, I wasn't expecting
being the only one affected. :)
"PCI/MSI: Use new mask/unmask functions" broke boot for my ION/Atom
330 system. Dmesg shows

failed to IDENTIFY (I/O error, err_mask=0x4)

and the system drops to an initramfs shell. Let me know if you need
any additional info (DMI dump and/or .config, for example).

Git bisect log follows:

git bisect start
# good: [7d2a07b769330c34b4deabeed939325c77a7ec2f] Linux 5.14
git bisect good 7d2a07b769330c34b4deabeed939325c77a7ec2f
# bad: [6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f] Linux 5.15-rc1
git bisect bad 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f
# bad: [1b4f3dfb4792f03b139edf10124fcbeb44e608e6] Merge tag
'usb-serial-5.15-rc1' of
https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into
usb-next
git bisect bad 1b4f3dfb4792f03b139edf10124fcbeb44e608e6
# good: [29ce8f9701072fc221d9c38ad952de1a9578f95c] Merge
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
git bisect good 29ce8f9701072fc221d9c38ad952de1a9578f95c
# bad: [e7c1bbcf0c315c56cd970642214aa1df3d8cf61d] Merge tag
'hwmon-for-v5.15' of
git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging
git bisect bad e7c1bbcf0c315c56cd970642214aa1df3d8cf61d
# bad: [679369114e55f422dc593d0628cfde1d04ae59b3] Merge tag
'for-5.15/block-2021-08-30' of git://git.kernel.dk/linux-block
git bisect bad 679369114e55f422dc593d0628cfde1d04ae59b3
# good: [c7a5238ef68b98130fe36716bb3fa44502f56001] Merge tag
's390-5.15-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
git bisect good c7a5238ef68b98130fe36716bb3fa44502f56001
# good: [e5e726f7bb9f711102edea7e5bd511835640e3b4] Merge tag
'locking-core-2021-08-30' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good e5e726f7bb9f711102edea7e5bd511835640e3b4
# good: [158ee7b65653d9f841823c249014c2d0dfdeeb8f] block: mark
blkdev_fsync static
git bisect good 158ee7b65653d9f841823c249014c2d0dfdeeb8f
# bad: [47fb0cfdb7a71a8a0ff8fe1d117363dc81f6ca77] Merge tag
'irqchip-5.15' of
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into
irq/core
git bisect bad 47fb0cfdb7a71a8a0ff8fe1d117363dc81f6ca77
# good: [4513fb87e1402ad815912ec7f027eb17149f44ee] Merge branch
irq/misc-5.15 into irq/irqchip-next
git bisect good 4513fb87e1402ad815912ec7f027eb17149f44ee
# bad: [88ffe2d0a55a165e55cedad1693f239d47e3e17e] genirq/cpuhotplug:
Demote debug printk to KERN_DEBUG
git bisect bad 88ffe2d0a55a165e55cedad1693f239d47e3e17e
# good: [fcacdfbef5a1633211ebfac1b669a7739f5b553e] PCI/MSI: Provide a
new set of mask and unmask functions
git bisect good fcacdfbef5a1633211ebfac1b669a7739f5b553e
# bad: [91cc470e797828d779cd4c1efbe8519bcb358bae] genirq: Change
force_irqthreads to a static key
git bisect bad 91cc470e797828d779cd4c1efbe8519bcb358bae
# bad: [428e211641ed808b55cdc7d880a0ee349eff354b] genirq/affinity:
Replace deprecated CPU-hotplug functions.
git bisect bad 428e211641ed808b55cdc7d880a0ee349eff354b
# bad: [446a98b19fd6da97a1fb148abb1766ad89c9b767] PCI/MSI: Use new
mask/unmask functions
git bisect bad 446a98b19fd6da97a1fb148abb1766ad89c9b767
# first bad commit: [446a98b19fd6da97a1fb148abb1766ad89c9b767]
PCI/MSI: Use new mask/unmask functions

Thanks in advance,
Rui
