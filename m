Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D343464739C
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 16:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiLHPyu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Dec 2022 10:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiLHPyr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2022 10:54:47 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DF1786B5
        for <linux-pci@vger.kernel.org>; Thu,  8 Dec 2022 07:54:43 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id fa4-20020a17090af0c400b002198d1328a0so6306894pjb.0
        for <linux-pci@vger.kernel.org>; Thu, 08 Dec 2022 07:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bYcezDAn4sB/5MNC0C4WLAcvqYkNPnouqqzb2qjRYSc=;
        b=Mw6KtFNnVJ4z9FMLRNS7Md6t9ESeTyVcYzIJ5qQcuXjHbMjVLNqcw8Zk8uzIUcDa5i
         XpeC5fYqrJoqE3G7PiF1l/3U4mzP0inuzsJlu92xvRCM7wSJ688qBvfh663tbnyFINak
         4/590hqpmjDySDBdETdJ65dFoMJdHvG05BT17vWsFpHzEXn+LxyBdhJwcMFAJQFpZwsM
         xf7iJs/03gjFw7vpcz70yAHBe/QYCWcbbZe/PUkL1D8xaCfR8JQEkqf2WpT3mlmh0Spl
         b+Ra4VwndCXq2uvx6+wL0vq+NTd3FeA0JukOSqza6axzIc/Sscjk0dQULepixo6zlKkn
         lTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bYcezDAn4sB/5MNC0C4WLAcvqYkNPnouqqzb2qjRYSc=;
        b=hspbH3mRPkZ0IfeEmk8msyfE4NbdOXV7RCkywzH1v1WxE4rwyUeKH4CoPQdt9MJ+qX
         xZZ5Cr8fQxvgW52XBnzvo8Pgqr92lsVKvyAjsmfDb+2qeGW8nbeDzu1sMaKJSCF97w0K
         HRZTRJ8b6glsAIDMYoHI+RmL+Sm5Ikzn9HZHOA5PBualQrTDsNJvm9jqdKdFjY819TOA
         9CPxQfIYZ6lGxFzZ//vQZZsvH2tgMWMTik7eWjCBrCzpOKXH6klU9Ws/wjSF8n+djjwl
         GPixgnyKZ0s4oXdpVEs/2p90DiyWDAv2ncGvxiFn79+GTJV1gn3E1WwVPCjJC0j0IRsJ
         WcLA==
X-Gm-Message-State: ANoB5plrziqbMoh5+m1LF00Lwzhjmn71PbPDcxb0zK1hvEbGCy0VS+9W
        7cnPcNIUJKPFCjBFi4DwrVsd0k0R2VpG7RUdWJg6HeKxCRqRQ7enKVw=
X-Google-Smtp-Source: AA0mqf5Em95Cj/i+D/aYF52jtS9AnBDdgtry5NIvEeSlwrL6sncohju1QYr8cIDqZ031TeoJ/PjEMzPSaNn45aayqaY=
X-Received: by 2002:a17:902:8a90:b0:189:680e:ac3a with SMTP id
 p16-20020a1709028a9000b00189680eac3amr61266906plo.77.1670514882862; Thu, 08
 Dec 2022 07:54:42 -0800 (PST)
MIME-Version: 1.0
From:   Major Saheb <majosaheb@gmail.com>
Date:   Thu, 8 Dec 2022 21:24:31 +0530
Message-ID: <CANBBZXPWe56VYJtzXdimEnkFgF+A=G15TXrd8Z5kBcUOGgHeRw@mail.gmail.com>
Subject: vfio-pci rejects binding to devices having same pcie vendor id and
 device id
To:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I have a linux system running in kvm, with 6 qemu emulated NVMe
drives, as expected all of them have the same PCIe Vendor ID and
Device ID(VID: 0x1b36 DID: 0x0010).
When I try to unbind them from the kernel NVMe driver and bind it to
vfio-pci one by one, I am getting "write error: File exists" when I
try to bind the 2nd(and other) drive to vfio-pci.

Kernel version

5.15.0-56-generic #62-Ubuntu SMP Tue Nov 22 19:54:14 UTC 2022 x86_64
x86_64 x86_64 GNU/Linux


lrwxrwxrwx 1 root root 0 Dec  8 11:32 /sys/block/nvme0n1 ->
../devices/pci0000:00/0000:00:03.0/nvme/nvme0/nvme0n1
lrwxrwxrwx 1 root root 0 Dec  8 11:32 /sys/block/nvme1n1 ->
../devices/pci0000:00/0000:00:04.0/nvme/nvme1/nvme1n1
lrwxrwxrwx 1 root root 0 Dec  8 11:32 /sys/block/nvme2n1 ->
../devices/pci0000:00/0000:00:05.0/nvme/nvme2/nvme2n1
lrwxrwxrwx 1 root root 0 Dec  8 11:32 /sys/block/nvme3n1 ->
../devices/pci0000:00/0000:00:06.0/nvme/nvme3/nvme3n1
lrwxrwxrwx 1 root root 0 Dec  8 11:32 /sys/block/nvme4n1 ->
../devices/pci0000:00/0000:00:07.0/nvme/nvme4/nvme4n1
lrwxrwxrwx 1 root root 0 Dec  8 11:32 /sys/block/nvme5n1 ->
../devices/pci0000:00/0000:00:08.0/nvme/nvme5/nvme5n1


Steps for repro
ubind nvme2 from kernel NVMe driver and bind it to vfio
$ ls -l /sys/bus/pci/drivers/vfio-pci/
total 0
lrwxrwxrwx 1 root root    0 Dec  8 13:04 0000:00:05.0 ->
../../../../devices/pci0000:00/0000:00:05.0
--w------- 1 root root 4096 Dec  8 13:07 bind
lrwxrwxrwx 1 root root    0 Dec  8 13:07 module -> ../../../../module/vfio_pci
--w------- 1 root root 4096 Dec  8 13:04 new_id
--w------- 1 root root 4096 Dec  8 13:07 remove_id
--w------- 1 root root 4096 Dec  8 11:32 uevent
--w------- 1 root root 4096 Dec  8 13:07 unbind

Unbind nvme3 from  kernel NVMe driver
Try binding to vfio-pci
# echo "0x1b36  0x0010" >  /sys/bus/pci/drivers/vfio-pci/new_id
-bash: echo: write error: File exists

Not sure but this seems interesting
https://github.com/torvalds/linux/commit/3853f9123c185eb4018f5ccd3cdda5968efb5e10#diff-625d2827bff96bb3a019fa705d99f0b89ec32f281c38a844457b3413d9172007

Can some help ?
