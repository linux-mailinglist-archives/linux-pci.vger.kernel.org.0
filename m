Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06BE91311A2
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 12:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgAFLzV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jan 2020 06:55:21 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37983 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgAFLzV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jan 2020 06:55:21 -0500
Received: by mail-io1-f66.google.com with SMTP id v3so48335593ioj.5;
        Mon, 06 Jan 2020 03:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=6Di6ffajBH2cZR+pVdW7IOpKkZDUHrowT9et6cWo7uY=;
        b=L8gc2XfmZbBDtaLDePZyXvUltjzM6ScSH0/znKIKaMCtMCibv+eO04IaTmDlBTGhbT
         1rWQ6Vxtd+o4e39T+uUEzmVcl6tC6lTKZECYTG3ADyckeJ2TKRJsyelTSAZPGKez8D1u
         m9AV1p7UxTh7bcRIN24V638UW6qgwex5yhHpV1oBPHLuyL16FphzTKID3dnJ402mwY7T
         fNA+T9uDhZOQbhiwhChgDX/xjmgG4zPj25Gy6KRmUXp8XXJJSewwhBEmcXUuqTv8EAue
         UdDLrzLHpxFMpL4MJqK4cUngKwqznMSJAKFLCIvYGaknkBlUacMMgm2Nm416NF7SRbZg
         mAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6Di6ffajBH2cZR+pVdW7IOpKkZDUHrowT9et6cWo7uY=;
        b=KdJeOx5DrqPUqLUxPDZ+PuHUYCQb5BI06oXxlCvW3W6w+S5CdK5C7N8y2cPV7YWQHi
         At8MJloPi5c4AOymZNvhfczlZfQDy7Wx4Epo9YuHrQngrBZG6LUI+uGpiEUFgiobgfNE
         NtI74WnumVRduhCWLfd9HV2mJ3aCpPwgfgbH94HMknLkmWWP1e5gNgbE0psGu3JiRMuq
         Z3/puamYjPSR/DcbTBZTfsEJJa7sepr85u7SkMIfOP8olda+auJLtcj6NTrbgJePnf+5
         lNyYivrdALsHDxPBTG/HOtKegJ7JkcZsvmAjcCL3Df0iiPUDmAcdXriw4EYYqzZl4nYh
         cNIg==
X-Gm-Message-State: APjAAAUkPoiLiQysULbUH1dNYdsnIenU2B2ZnfVyh3NnhxZ+g69RuUcp
        /dIDmlvx7uD9UDa7kvTPlgJwS+yIM+jNJ4Gf2Zz023RG
X-Google-Smtp-Source: APXvYqyK5B13r8HZFUhRRLwCjL031uyNVHRJy14fnkwQW+NME79KYnHpYoaVPSOY+KwNL7GKReAVKzghVs3O6n2eRC8=
X-Received: by 2002:a02:c90a:: with SMTP id t10mr77309211jao.25.1578311720271;
 Mon, 06 Jan 2020 03:55:20 -0800 (PST)
MIME-Version: 1.0
From:   Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Date:   Mon, 6 Jan 2020 17:24:44 +0530
Message-ID: <CAJ2QiJ+MVVztHONagmYc2-BzbtdGQhABRKO7h4+kOE9cCK=CxA@mail.gmail.com>
Subject: kexec -e not working: root disk not able to detect
To:     linux-pci@vger.kernel.org, linux-ide@vger.kernel.org,
        Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>,
        Kamlakant Patel <kamlakantp@marvell.com>,
        kexec mailing list <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

I am trying kexec -e with latest kernel i.e. Linux-5.5.0-rc4.  Here
second kernel is not able to detect/mount hard-disk having root file
system (INTEL SSDSC2BB240G7).

[  279.690575] ata1: softreset failed (1st FIS failed)
[  279.695446] ata1: limiting SATA link speed to 3.0 Gbps
[  280.910020] ata1: SATA link down (SStatus 0 SControl 320)
[  282.626018] ata1: SATA link down (SStatus 0 SControl 300)
[  282.631409] ata1: link online but 1 devices misclassified, retrying
[  282.637665] ata1: reset failed (errno=-11), retrying in 9 secs
[  298.294546] ata1: failed to reset engine (errno=-5)
[  302.042967] ata1: softreset failed (1st FIS failed)
[  308.798609] ata1: failed to reset engine (errno=-5)
[  337.546605] ata1: softreset failed (1st FIS failed)
[  337.551475] ata1: limiting SATA link speed to 3.0 Gbps
[  338.766022] ata1: SATA link down (SStatus 0 SControl 320)
[  339.270943] ata1: EH pending after 5 tries, giving up

I found following two workaround for this issue.
A) Define ".shutdown" in driver/ata/ahci.c.

reboot --> kernel_kexec() --> kernel_restart_prepare() -->
device_shutdown() --> pci_device_shutdown() --> ahci_shutdown_one()
--> new function

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 4bfd1b14b390..50a101002885 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -81,6 +81,7 @@ enum board_ids {

 static int ahci_init_one(struct pci_dev *pdev, const struct
pci_device_id *ent);
 static void ahci_remove_one(struct pci_dev *dev);
 +static void ahci_shutdown_one(struct pci_dev *dev);
 static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
                                  unsigned long deadline);
  static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
 @@ -606,6 +607,7 @@ static struct pci_driver ahci_pci_driver = {
         .id_table               = ahci_pci_tbl,
         .probe                  = ahci_init_one,
         .remove                 = ahci_remove_one,
 +       .shutdown               = ahci_shutdown_one,
         .driver = {
                 .pm             = &ahci_pci_pm_ops,
         },

 +static void ahci_shutdown_one(struct pci_dev *pdev)
 +{
 +       pm_runtime_get_noresume(&pdev->dev);
 +       ata_pci_remove_one(pdev);
 +}
 +
Note: After defining shutdown, error related to file-system write
seen. Looks like even after device_shutdown, file system related
transaction goes to disk.

B)) Commenting of pci_clear_master() from pci_device_shutdown()
reboot --> kernel_kexec() --> kernel_restart_prepare() -->
device_shutdown() --> pci_device_shutdown()

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 0454ca0e4e3f..ddffaa9321bb 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -481,8 +481,10 @@ static void pci_device_shutdown(struct device *dev)
        /*
         * If this is a kexec reboot, turn off Bus Master bit on the
@@ -491,8 +493,16 @@ static void pci_device_shutdown(struct device *dev)
         * If it is not a kexec reboot, firmware will hit the PCI
         * devices with big hammer and stop their DMA any way.
         */

 - if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
 -                pci_clear_master(pci_dev);

Here pci_dev current_state. It is "0" i.e. D0.

From A and B. Looks like even after pci_clear_master(), Some DMA
transactions going on PCIe device  causing device in unstable.
Not sure if this is the reason and how to solve this problem.

Any help/guidance will help me in moving forward.

Thanks!!

--prabhakar (pk)
