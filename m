Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8D74200C8
	for <lists+linux-pci@lfdr.de>; Sun,  3 Oct 2021 10:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhJCIe3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 3 Oct 2021 04:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhJCIe2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 3 Oct 2021 04:34:28 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7864EC0613EC;
        Sun,  3 Oct 2021 01:32:41 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id p13so23906357edw.0;
        Sun, 03 Oct 2021 01:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kPIObBVVgnXoudMBLnu91RHq8erONgyj0SqjFXcGnsc=;
        b=DwhO3ws8FAT1mTK09qNmgbwgFycVAG7Z8JsNEnW9YabhC01Xc9apw35+JERTpTf06L
         alVgopwY+AgEJayvhfBJW41V94vNYL0WQTmm6i+Lh9Gb7bTxAiaRuSPGhqwy1qLQiuQt
         ikEoP6jiPVLLCSE8i2TNgUsTHOe7OEeRFXFTiBFN59Kbesm2hoWrTbRleOX2Etn0N/YD
         3ah3RZ6AcAtsksafD2TB57NxUArvbvXsQKhnjKgusbPH6Ebx6aJ24HJ6EqXDMaJ4a1uY
         32vHBFqfrTc2t91RFYGKcCkIYVRFzMM+9hWl5qQNrFc7T2YXbVEr9LwCm5kvDgInhDzK
         IhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kPIObBVVgnXoudMBLnu91RHq8erONgyj0SqjFXcGnsc=;
        b=WMzV0X9JXRF3gc70EerkueJatlhiZhFjSvZMibgpUGXqWKb1StzOYzzHv+k4rbwHvx
         xPudonSeZMkTr3SnnnQIWuUX/e7WSy86esGwW5rpTApizNu8LBR6N6RW+ZKNPfPz4WCQ
         cAwQWFyBN3EbYtJ22kYtSSbSzwaLAwLE4nb0ePkaaTMA3VStrIAGBagYix9QAVEaT3Nz
         qdkKVR9516aOqdHAdJT2JCk1tFc/c8/7tmXCJOCcImGNFC0Mv7Bt2Msg2lm7wJZqkD2x
         09pH049T4bJZh9iRC0UroKvd+36XxcsowoVK5in/F55x3fDo7oPODyST0UtkxKpuHZBj
         1i9A==
X-Gm-Message-State: AOAM533Uvpp+iNsULayruprNcwdfUOKqypL3HfzbB6L3llmFRopADDFq
        RxajbW54eQyvAK8w8AF8gJv2xVtfmtBBZhSo8II=
X-Google-Smtp-Source: ABdhPJwh0nQr1w1Lj5SRzFQcfXjMdXb7w+vZV4VO4oWFFPjCrnKnNAyUEmpeRFe//S4jOBF/xys5vJU42onnHy0ka3c=
X-Received: by 2002:a50:cd87:: with SMTP id p7mr9578535edi.294.1633249959979;
 Sun, 03 Oct 2021 01:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210825102636.52757-4-21cnbao@gmail.com> <20210829145552.GA11556@xsang-OptiPlex-9020>
 <CAGsJ_4yYwjuWsEeK3CvnOhc10mbBNYWXqxqp+mR5587R2FD3gQ@mail.gmail.com>
 <CAGsJ_4zwRdR2QuoR0K0_J86w0=t=mFh=tAKRuP1+Tx8aLn4kKw@mail.gmail.com> <8ab95f7f784448038d7777c45f1f2d55@intel.com>
In-Reply-To: <8ab95f7f784448038d7777c45f1f2d55@intel.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sun, 3 Oct 2021 21:32:28 +1300
Message-ID: <CAGsJ_4ygPbLFqpRu7_N4RvfTY++OumQCFz=yxgcnb3VoqPwRAg@mail.gmail.com>
Subject: Re: [PCI/MSI] a4fc4cf388: dmesg.genirq:Flags_mismatch_irq##(mei_me)vs.#(xhci_hcd)
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     "Sang, Oliver" <oliver.sang@intel.com>, lkp <lkp@intel.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "bilbao@vt.edu" <bilbao@vt.edu>, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "luzmaximilian@gmail.com" <luzmaximilian@gmail.com>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "schnelle@linux.ibm.com" <schnelle@linux.ibm.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 3, 2021 at 7:34 AM Winkler, Tomas <tomas.winkler@intel.com> wrote:
>
> > dmesg.genirq:Flags_mismatch_irq##(mei_me)vs.#(xhci_hcd)
> >
> > On Tue, Aug 31, 2021 at 1:21 PM Barry Song <21cnbao@gmail.com> wrote:
> > >
> > > On Mon, Aug 30, 2021 at 2:38 AM kernel test robot
> > <oliver.sang@intel.com> wrote:
> > > >
> > > >
> > > >
> > > > Greeting,
> > > >
> > > > FYI, we noticed the following commit (built with gcc-9):
> > > >
> > > > commit: a4fc4cf388319ea957ffbdab5073bdd267de9082 ("[PATCH v3 3/3]
> > > > PCI/MSI: remove msi_attrib.default_irq in msi_desc")
> > > > url:
> > > > https://github.com/0day-ci/linux/commits/Barry-Song/PCI-MSI-Clarify-
> > > > the-IRQ-sysfs-ABI-for-PCI-devices/20210825-183018
> > > > base:
> > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git
> > > > 6e764bcd1cf72a2846c0e53d3975a09b242c04c9
> > > >
> > > > in testcase: kernel-selftests
> > > > version: kernel-selftests-x86_64-ebaa603b-1_20210825
> > > > with following parameters:
> > > >
> > > >         group: pidfd
> > > >         ucode: 0xe2
> > > >
> > > > test-description: The kernel contains a set of "self tests" under the
> > tools/testing/selftests/ directory. These are intended to be small unit tests
> > to exercise individual code paths in the kernel.
> > > > test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> > > >
> > > >
> > > > on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz
> > > > with 32G memory
> > > >
> > > > caused below changes (please refer to attached dmesg/kmsg for entire
> > log/backtrace):
> > > >
> > > >
> > > >
> > > > If you fix the issue, kindly add following tag
> > > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > >
> > > >
> > > >
> > > > [  179.602028][   T34] genirq: Flags mismatch irq 16. 00002000 (mei_me) vs.
> > 00000000 (xhci_hcd)
> > > > [  179.614073][   T34] CPU: 2 PID: 34 Comm: kworker/u8:2 Not tainted
> > 5.14.0-rc7-00014-ga4fc4cf38831 #1
> > > > [  179.623225][   T34] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT,
> > BIOS 1.8.1 12/05/2017
> > > > [  179.631432][   T34] Workqueue: events_unbound async_run_entry_fn
> > > > [  179.637543][   T34] Call Trace:
> > > > [  179.640789][   T34]  dump_stack_lvl+0x45/0x59
> > > > [  179.645253][   T34]  __setup_irq.cold+0x50/0xd4
> > > > [  179.649893][   T34]  ? mei_me_pg_exit_sync+0x480/0x480 [mei_me]
> > > > [  179.655923][   T34]  request_threaded_irq+0x10c/0x180
> > > > [  179.661073][   T34]  ? mei_me_irq_quick_handler+0x240/0x240
> > [mei_me]
> > > > [  179.667528][   T34]  mei_me_probe+0x131/0x300 [mei_me]
> > > > [  179.672767][   T34]  local_pci_probe+0x42/0x80
> > > > [  179.677313][   T34]  pci_device_probe+0x107/0x1c0
> > > > [  179.682118][   T34]  really_probe+0xb6/0x380
> > > > [  179.687094][   T34]  __driver_probe_device+0xfe/0x180
> > > > [  179.692242][   T34]  driver_probe_device+0x1e/0xc0
> > > > [  179.697133][   T34]  __driver_attach_async_helper+0x2b/0x80
> > > > [  179.702802][   T34]  async_run_entry_fn+0x30/0x140
> > > > [  179.707693][   T34]  process_one_work+0x274/0x5c0
> > > > [  179.712503][   T34]  worker_thread+0x50/0x3c0
> > > > [  179.716959][   T34]  ? process_one_work+0x5c0/0x5c0
> > > > [  179.721936][   T34]  kthread+0x14f/0x180
> > > > [  179.725958][   T34]  ? set_kthread_struct+0x40/0x40
> > > > [  179.730935][   T34]  ret_from_fork+0x22/0x30
> > > > [  179.735699][   T34] mei_me 0000:00:16.0: request_threaded_irq failure.
> > irq = 16
> > > > [  179.743125][   T34] mei_me 0000:00:16.0: initialization failed.
> > > > [  179.749399][   T34] mei_me: probe of 0000:00:16.0 failed with error -16
> > > >
> > > >
> > >
> > > it seems there is a direct reference to pdev->irq.
> > > Hi Oliver, would you try if the below patch can fix the problem:
> >
> > + Tomas
> >
> > sorry. after second looking, drivers/misc/mei/pci-me.c has many places using
> > pdev->irq directly. We really need this driver's maintainers to address the
> > problem.
>
> Will look at that.

Hi Tomas,

I assume using hw->irq or not is a separate topic, does vim command
%s/pdev->irq/pci_irq_vector(pdev, 0)/g
as below fix the current crash problem because of directly dereferencing
pdev->irq?

diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index c3393b383e59..97495931fadd 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -216,18 +216,18 @@ static int mei_me_probe(struct pci_dev *pdev,
const struct pci_device_id *ent)

  pci_enable_msi(pdev);

- hw->irq = pdev->irq;
+ hw->irq = pci_irq_vector(pdev, 0);

  /* request and enable interrupt */
  irqflags = pci_dev_msi_enabled(pdev) ? IRQF_ONESHOT : IRQF_SHARED;

- err = request_threaded_irq(pdev->irq,
+ err = request_threaded_irq(pci_irq_vector(pdev, 0),
  mei_me_irq_quick_handler,
  mei_me_irq_thread_handler,
  irqflags, KBUILD_MODNAME, dev);
  if (err) {
  dev_err(&pdev->dev, "request_threaded_irq failure. irq = %d\n",
-        pdev->irq);
+        pci_irq_vector(pdev, 0));
  goto end;
  }

@@ -278,7 +278,7 @@ static int mei_me_probe(struct pci_dev *pdev,
const struct pci_device_id *ent)
 release_irq:
  mei_cancel_work(dev);
  mei_disable_interrupts(dev);
- free_irq(pdev->irq, dev);
+ free_irq(pci_irq_vector(pdev, 0), dev);
 end:
  dev_err(&pdev->dev, "initialization failed.\n");
  return err;
@@ -307,7 +307,7 @@ static void mei_me_shutdown(struct pci_dev *pdev)
  mei_me_unset_pm_domain(dev);

  mei_disable_interrupts(dev);
- free_irq(pdev->irq, dev);
+ free_irq(pci_irq_vector(pdev, 0), dev);
 }

 /**
@@ -336,7 +336,7 @@ static void mei_me_remove(struct pci_dev *pdev)

  mei_disable_interrupts(dev);

- free_irq(pdev->irq, dev);
+ free_irq(pci_irq_vector(pdev, 0), dev);

  mei_deregister(dev);
 }
@@ -356,7 +356,7 @@ static int mei_me_pci_suspend(struct device *device)

  mei_disable_interrupts(dev);

- free_irq(pdev->irq, dev);
+ free_irq(pci_irq_vector(pdev, 0), dev);
  pci_disable_msi(pdev);

  return 0;
@@ -378,14 +378,14 @@ static int mei_me_pci_resume(struct device *device)
  irqflags = pci_dev_msi_enabled(pdev) ? IRQF_ONESHOT : IRQF_SHARED;

  /* request and enable interrupt */
- err = request_threaded_irq(pdev->irq,
+ err = request_threaded_irq(pci_irq_vector(pdev, 0),
  mei_me_irq_quick_handler,
  mei_me_irq_thread_handler,
  irqflags, KBUILD_MODNAME, dev);

  if (err) {
  dev_err(&pdev->dev, "request_threaded_irq failed: irq = %d.\n",
- pdev->irq);
+ pci_irq_vector(pdev, 0));
  return err;
  }


Thanks
barry
