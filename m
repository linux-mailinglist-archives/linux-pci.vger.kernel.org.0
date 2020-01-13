Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 100CB138A80
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2020 05:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387579AbgAME7B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Jan 2020 23:59:01 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41415 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387525AbgAME7B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Jan 2020 23:59:01 -0500
Received: by mail-io1-f66.google.com with SMTP id c16so8446654ioo.8;
        Sun, 12 Jan 2020 20:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wXYC5J9mGweJ3WwVP7qxMLynpS0DlOTbA3mThzYsgNE=;
        b=JxEXnJM8SIwfhvtM0lu4zV13HAV+EcYgf+kLMM1WmNSYzggp5KjQOrBrKtnnIktBhE
         qMAUjMV/GZ7wPwrXX7Uk3hNIKc9mEfZxs3OvtkF1l3f9feDTpNtbuVXfTcmV0ETpKU9n
         jjX8RCvD1Tyxb42LJxfe7PCagCBkfheXwRScBiyQ9k5ACb1TiKn3HU27ibMq9BFsaKZO
         u13sQ3ywN5A97ha5D74INH7ssMh6FzH9uLOMy0ZHDkqIR4kp7pvBkYsAlhbV560WKNcd
         8NCWnwiAPO/aU3Y0Tqoj6bz6hekPPKbsOG5ScQFCu5n+R5fJgs2bPQWk7RwVSEHG2oUQ
         Qpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wXYC5J9mGweJ3WwVP7qxMLynpS0DlOTbA3mThzYsgNE=;
        b=Q0/+wDJ7+nYq5UHhm9jmQfWqW553dOQ41B1ARbyFzjWyqbQTb60A6j5xw6K/xlWSv2
         DMjyWa32XUxfHppO+bgNh9lroThBtKWoDchymf6r+rldgOvKfx4KEA9wcgl8PAWIkwhN
         b2m4UfStGBi+2Ck00OKnO1ItjFDppkyRAAg3FITk6HAKeyWVS5KY7zS0AemKVRYbcuUW
         rFNt+wZY807EUVZTpuNlEleaYFdbMDVbolktdrAde+mLbddpyNpbEljsJAWOP9/EILMz
         i+s7td85ZGA+4CDEdqW2O8fxedmHLEsyUaQAk3PABCq4cj3v09PGhuGixXqUfQ1u/RyT
         McBQ==
X-Gm-Message-State: APjAAAVgMpT7woaq3ijpdnNYcux2o05vvd+atm2lBGceJowRYrUgzXUU
        C+xGjDaWbueVdq2Uce8x16E0QcqkppDX/xqh3aM=
X-Google-Smtp-Source: APXvYqxqEl26J8gLy3PrEoJQdBmlN0zoAq+49/SW6o77INf3gogX95HFFA6nfgIeVygYeCxbtdcpg9+BkR+yrin80V8=
X-Received: by 2002:a5e:d617:: with SMTP id w23mr10846700iom.98.1578891540002;
 Sun, 12 Jan 2020 20:59:00 -0800 (PST)
MIME-Version: 1.0
References: <CAJ2QiJ+MVVztHONagmYc2-BzbtdGQhABRKO7h4+kOE9cCK=CxA@mail.gmail.com>
 <20200110002638.GA50413@google.com>
In-Reply-To: <20200110002638.GA50413@google.com>
From:   Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Date:   Mon, 13 Jan 2020 10:28:23 +0530
Message-ID: <CAJ2QiJL+eTTX2DjmCFLbCfe1oaGS3Y5Dy0NfBxfpHT2YPGwOSQ@mail.gmail.com>
Subject: Re: kexec -e not working: root disk not able to detect
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-pci@vger.kernel.org,
        linux-ide@vger.kernel.org,
        Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>,
        Kamlakant Patel <kamlakantp@marvell.com>,
        kexec mailing list <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Re sending keeping mailing list and others in CC]

On Fri, Jan 10, 2020 at 5:56 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Jens, ahci.c maintainer]
>
> On Mon, Jan 06, 2020 at 05:24:44PM +0530, Prabhakar Kushwaha wrote:
> > Hi All,
> >
> > I am trying kexec -e with latest kernel i.e. Linux-5.5.0-rc4.  Here
> > second kernel is not able to detect/mount hard-disk having root file
> > system (INTEL SSDSC2BB240G7).
> >
> > [  279.690575] ata1: softreset failed (1st FIS failed)
> > [  279.695446] ata1: limiting SATA link speed to 3.0 Gbps
> > [  280.910020] ata1: SATA link down (SStatus 0 SControl 320)
> > [  282.626018] ata1: SATA link down (SStatus 0 SControl 300)
> > [  282.631409] ata1: link online but 1 devices misclassified, retrying
> > [  282.637665] ata1: reset failed (errno=-11), retrying in 9 secs
> > [  298.294546] ata1: failed to reset engine (errno=-5)
> > [  302.042967] ata1: softreset failed (1st FIS failed)
> > [  308.798609] ata1: failed to reset engine (errno=-5)
> > [  337.546605] ata1: softreset failed (1st FIS failed)
> > [  337.551475] ata1: limiting SATA link speed to 3.0 Gbps
> > [  338.766022] ata1: SATA link down (SStatus 0 SControl 320)
> > [  339.270943] ata1: EH pending after 5 tries, giving up
> >
> > I found following two workaround for this issue.
> > A) Define ".shutdown" in driver/ata/ahci.c.
> >
> > reboot --> kernel_kexec() --> kernel_restart_prepare() -->
> > device_shutdown() --> pci_device_shutdown() --> ahci_shutdown_one()
> > --> new function
> >
> > diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> > index 4bfd1b14b390..50a101002885 100644
> > --- a/drivers/ata/ahci.c
> > +++ b/drivers/ata/ahci.c
> > @@ -81,6 +81,7 @@ enum board_ids {
> >
> >  static int ahci_init_one(struct pci_dev *pdev, const struct
> > pci_device_id *ent);
> >  static void ahci_remove_one(struct pci_dev *dev);
> >  +static void ahci_shutdown_one(struct pci_dev *dev);
> >  static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
> >                                   unsigned long deadline);
> >   static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
> >  @@ -606,6 +607,7 @@ static struct pci_driver ahci_pci_driver = {
> >          .id_table               = ahci_pci_tbl,
> >          .probe                  = ahci_init_one,
> >          .remove                 = ahci_remove_one,
> >  +       .shutdown               = ahci_shutdown_one,
> >          .driver = {
> >                  .pm             = &ahci_pci_pm_ops,
> >          },
> >
> >  +static void ahci_shutdown_one(struct pci_dev *pdev)
> >  +{
> >  +       pm_runtime_get_noresume(&pdev->dev);
> >  +       ata_pci_remove_one(pdev);
> >  +}
> >  +
> > Note: After defining shutdown, error related to file-system write
> > seen. Looks like even after device_shutdown, file system related
> > transaction goes to disk.
> >
> > B)) Commenting of pci_clear_master() from pci_device_shutdown()
> > reboot --> kernel_kexec() --> kernel_restart_prepare() -->
> > device_shutdown() --> pci_device_shutdown()
> >
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index 0454ca0e4e3f..ddffaa9321bb 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -481,8 +481,10 @@ static void pci_device_shutdown(struct device *dev)
> >         /*
> >          * If this is a kexec reboot, turn off Bus Master bit on the
> > @@ -491,8 +493,16 @@ static void pci_device_shutdown(struct device *dev)
> >          * If it is not a kexec reboot, firmware will hit the PCI
> >          * devices with big hammer and stop their DMA any way.
> >          */
> >
> >  - if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
> >  -                pci_clear_master(pci_dev);
>
> I doubt we would remove this without a much clearer justification.
>
> > Here pci_dev current_state. It is "0" i.e. D0.
> >
> > From A and B. Looks like even after pci_clear_master(), Some DMA
> > transactions going on PCIe device  causing device in unstable.
> > Not sure if this is the reason and how to solve this problem.
>
> Is it possible the ahci driver depends on receiving the device with
> bus mastering already enabled?  I would guess that would be the common
> case in a non-kexec boot -- the BIOS probably hands off the device
> with bus mastering enabled.
>

Above code clearing Bus Master. May be it try to make sure that next
kernel get PCIe in same state in which BIOS could have provided.
Not sure why this is causing issue in our case. Need to debug more.

> ahci_init_one() does turn on bus mastering itself (it calls
> pci_set_master()), but it's near the end, do if anything before that
> depends on DMA, it wouldn't work.
>
> And I don't know how adding a shutdown method would also be a
> workaround.
>

Ideally shutdown should be added for port freezing/stop. One should
provide ATA in "reset" state to next level kernel.

+static void ahci_shutdown_one(struct pci_dev *pdev)
+{
+       struct ata_host *host = pci_get_drvdata(pdev);
+       int i;
+
+       for (i = 0; i < host->n_ports; i++) {
+               struct ata_port *ap = host->ports[i];
+
+               /* Disable port interrupts */
+               if (ap->ops->freeze)
+                       ap->ops->freeze(ap);
+
+               /* Stop the port DMA engines */
+               if (ap->ops->port_stop)
+                       ap->ops->port_stop(ap);
+       }
+}

why shutdown function never implemented for ahci.c. Considering
ahci_platform.c does have shutdown.

--pk
