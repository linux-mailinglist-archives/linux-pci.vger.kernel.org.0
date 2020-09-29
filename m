Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E65027BB27
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 04:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgI2CuQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 22:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgI2CuQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Sep 2020 22:50:16 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4994C061755;
        Mon, 28 Sep 2020 19:50:15 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id b12so4637387edz.11;
        Mon, 28 Sep 2020 19:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UGDoo9i782f7BLI1IbefwVwd+1evnRY0tllTExyS5ik=;
        b=JGeEYfKZ2djPZ8sEXlFNS6V/JBsKWpyP0RZgbQ8mLgz5ccqv8MwrvmGLLr9+qUc0QO
         roGHR3I8TQoOmeVDmqA1SW3MZbiDGwggG37ARlgj+bc1Yp6ye4KAMzWTe3rJ42xb+tlt
         wnKcomwxZJb0sG+FNBCoRJLxLT0ig0fOvJgqPJjD4N/vKAJgh027P5kZHCJS7X+m4oWt
         a4PoprMsE1A5hakCVxEL2YU2IOQtZDHCsIuttMVhOZcjBA+9YnyE6vYJqMAKr2Z3OYgf
         ea0gQOqz4DUvlgKCFZvEByYx3MTa2FcqF6Gem314g6V3STzDEfN82Rv6UcD/8z6gaxLk
         LxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UGDoo9i782f7BLI1IbefwVwd+1evnRY0tllTExyS5ik=;
        b=Yz7u/ncYnkw8BqqoLmf7BwrKsL6R8an3MhXYF3qCZTJ8bIyKuMPm4+cnEp43TJNpeB
         0d80o+vTWz+ikO7lM5+02E6WAnU2xarwTVQiHUG2rXGtm+RttaVD/r9k9t3IYQqDV4vq
         1dnagkgVH2sc0MhB32zY5IhU5sSbyVmcj4Ce6xq3ZiGofFIh+MfV9nV+CYoU+RPfTVv5
         X5GXz7OQqgRTb5yQHtK8jaQ2pqVgeFYcDgd5FFeAsJyuTcMAq95f9P8F3o/g59kaCm1P
         OM+tUmaI+Pe625m9E6bJ0zkNdI8T62hlOBM/zh6fyow5+xJ4TAIvK2L1QUNOsYrJbiZ2
         +8Hw==
X-Gm-Message-State: AOAM533TPuijWEpvjXL6dUClHVFIyOy5m3SFZVwnEsOIInSkncMUGVri
        tKdD7EtqpfxMg+DN7bBU6TngjP6PdcKpINAUPw7ymuQCFMc=
X-Google-Smtp-Source: ABdhPJwmELR4adEkt+fubAV5EF+nU/JIdmsQ6xRev3QOUYi4G9voqJcDb9JzEtpCB/Ho6hC5iFHfcfxYru21zWLB+84=
X-Received: by 2002:a05:6402:304f:: with SMTP id bu15mr993627edb.201.1601347814366;
 Mon, 28 Sep 2020 19:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200927032829.11321-1-haifeng.zhao@intel.com>
 <20200927032829.11321-3-haifeng.zhao@intel.com> <f2c9e3db-2027-f669-fcdd-fbc80888b934@kernel.org>
 <MWHPR11MB1696BA6B8473248A8638FD3797350@MWHPR11MB1696.namprd11.prod.outlook.com>
 <14b7d988-212b-93dc-6fa6-6b155d5c8ac3@kernel.org> <16431a60-027e-eca9-36f4-74d348e88090@kernel.org>
In-Reply-To: <16431a60-027e-eca9-36f4-74d348e88090@kernel.org>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Tue, 29 Sep 2020 10:50:03 +0800
Message-ID: <CAKF3qh2NLyLG4dV5n4ttW9hbsf0C1M58aYUo7xtHX86zfJxr-Q@mail.gmail.com>
Subject: Re: [PATCH 2/5 V2] PCI: pciehp: check and wait port status out of DPC
 before handling DLLSC and PDC
To:     Sinan Kaya <okaya@kernel.org>
Cc:     "Zhao, Haifeng" <haifeng.zhao@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "oohall@gmail.com" <oohall@gmail.com>,
        "ruscur@russell.cc" <ruscur@russell.cc>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "stuart.w.hayes@gmail.com" <stuart.w.hayes@gmail.com>,
        "mr.nuke.me@gmail.com" <mr.nuke.me@gmail.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jia, Pei P" <pei.p.jia@intel.com>,
        "ashok.raj@linux.intel.com" <ashok.raj@linux.intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 29, 2020 at 12:44 AM Sinan Kaya <okaya@kernel.org> wrote:
>
> On 9/28/2020 7:10 AM, Sinan Kaya wrote:
> > On 9/27/2020 10:01 PM, Zhao, Haifeng wrote:
> >> Sinan,
> >>    I explained the reason why locks don't protect this case in the pat=
ch description part.
> >> Write side and read side hold different semaphore and mutex.
> >>
> > I have been thinking about it some time but is there any reason why we
> > have to handle all port AER/DPC/HP events in different threads?
> >
> > Can we go to single threaded event loop for all port drivers events?
> >
> > This will require some refactoring but it wlll eliminate the lock
> > nightmares we are having.
> >
> > This means no sleeping. All sleeps need to happen outside of the loop.
> >
> > I wanted to see what you all are thinking about this.
> >
> > It might become a performance problem if the system is
> > continuously observing a hotplug/aer/dpc events.
> >
> > I always think that these should be rare events.
>
> If restructuring would be too costly, the preferred solution should be
> to fix the locks in hotplug driver rather than throwing there a random
> wait call.

  My first though is to unify the pci_bus_sem & pci_rescan_remove_lock
to one sleepable lock, but verifying every
locking scenario to sort out dead lock warning, it is horrible job. I
gave up and then played the device status waiting trick
to workaround it.

    index 03d37128a24f..477d4c499f87 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3223,17 +3223,19 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
  * pci_rescan_bus(), pci_rescan_bus_bridge_resize() and PCI device removal
  * routines should always be executed under this mutex.
  */
-static DEFINE_MUTEX(pci_rescan_remove_lock);
+/* static DEFINE_MUTEX(pci_rescan_remove_lock); */

 void pci_lock_rescan_remove(void)
 {
- mutex_lock(&pci_rescan_remove_lock);
+ /*mutex_lock(&pci_rescan_remove_lock); */
+ down_write(&pci_bus_sem);
 }
 EXPORT_SYMBOL_GPL(pci_lock_rescan_remove);

 void pci_unlock_rescan_remove(void)
 {
- mutex_unlock(&pci_rescan_remove_lock);
+ /*mutex_unlock(&pci_rescan_remove_lock); */
+ up_write(&pci_bus_sem);
 }
 EXPORT_SYMBOL_GPL(pci_unlock_rescan_remove);

Thanks=EF=BC=8C
Ethan
