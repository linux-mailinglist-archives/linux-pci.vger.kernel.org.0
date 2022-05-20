Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD1F52E2C7
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 05:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343978AbiETDA7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 May 2022 23:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344936AbiETDA6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 May 2022 23:00:58 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624802494A;
        Thu, 19 May 2022 20:00:56 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id d15so12131328lfk.5;
        Thu, 19 May 2022 20:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=octF3L3s7sydh3Lri04JtKL9Flbqols+7/iLfIisCyY=;
        b=NqoaH6Mc7/OOqRQltCRS8pd72n8MJo0az00PWGZZ58uNqNKx/wBZUpjlAeB5YxeeAc
         D9lNwfF+oFuXhae+TVixbLa2ffYX+FroITjQEghvqJ9Qw76YSrYOTsvnbXJ4B2PITVF5
         a2kys8aKQRyepMbQfr6uo3C7yLcOoTjKz/bIuzcu9StoDphqCkZIhuXYo3MVzkmLXBOl
         lRJrWKFVpa5rpCjfWfjQiE7LsH8kvB3mebWeSUM0qOv/L+zdwYJfgJWBq2KOtgu3eMRZ
         er8ev63pvSGoUtivHkvr9pxWgGM3vEeKGqWNlJb8ajVRzvLfrke9MZtnKkKI7uEiYuut
         kHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=octF3L3s7sydh3Lri04JtKL9Flbqols+7/iLfIisCyY=;
        b=tq+xj/k4PUYF+AXb7ItUJJWHBb4oEaEbNJgeL/ZlER7G2zVr4Nc5HyyGiQ9z24jz6z
         gTNSAac5DP7/K7tIHBW3yxtspL8i4poO+8rRYO2T5XS1q70gasTOAwshMPUzr7qfq1YJ
         vjpPfM8xK6bQeNRXA1QcU9o4j4EQQQFY54bwxVAKTxn12xvuvllEgcwH7yPn/4ecQIjm
         xzKqpOHdWFo6AgLXKw3hRPjWzBUSwVbJFBehEUAcc9B4kqanGwQmifjcWkVNN8QqpaQg
         aC9uw/5rNWNDjShyYdCpGjK0ex39ZSR/m/GPiZWvXHfsHxp0KDwhNe9HVUQ6wCl30l4+
         ++dw==
X-Gm-Message-State: AOAM530bbk15Iq59xtCk/QGALNethoBE50Hqbsa0g8vDV69BrNF3ka7Q
        E3DG3ZkYxcW+G0ps6WRkE5BX1MbH54wRjaQsh/EOHQEzBjs=
X-Google-Smtp-Source: ABdhPJz1T0X7NVqyHAUCqGcRKKadO+LL19xo4SPj4nddVDRFm4DbZqXHJVsTK3ViY1ETeB9iU9aOcD4JiU3qeilhkRw=
X-Received: by 2002:a05:6512:3f96:b0:477:c0fe:9b05 with SMTP id
 x22-20020a0565123f9600b00477c0fe9b05mr5249778lfa.109.1653015654603; Thu, 19
 May 2022 20:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220516165740.6256af51.alex.williamson@redhat.com>
 <20220518115432.76183-1-windy.bi.enflame@gmail.com> <20220519110622.6fd065d2.alex.williamson@redhat.com>
In-Reply-To: <20220519110622.6fd065d2.alex.williamson@redhat.com>
From:   windy Bi <windy.bi.enflame@gmail.com>
Date:   Fri, 20 May 2022 11:00:42 +0800
Message-ID: <CAGdb+H00q3xhCfw-x+DG624sMuuKqaRwRpPWDJCYs2iLsBCyVw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Fix no-op wait after secondary bus reset
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 20, 2022 at 1:06 AM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Wed, 18 May 2022 19:54:32 +0800
> Sheng Bi <windy.bi.enflame@gmail.com> wrote:
>
> > pci_bridge_secondary_bus_reset() triggers SBR followed by 1 second sleep,
> > and then uses pci_dev_wait() for waiting device ready. The dev parameter
> > passes to the wait function is currently the bridge itself, but not the
> > device been reset.
> >
> > If we call pci_bridge_secondary_bus_reset() to trigger SBR to a device,
> > there is 1 second sleep but not waiting device ready, since the bridge
> > is always ready while resetting downstream devices. pci_dev_wait() here
> > is a no-op actually. This would be risky in the case which the device
> > becomes ready after more than 1 second, especially while hotplug enabled.
> > The late coming hotplug event after 1 second will trigger hotplug module
> > to remove/re-insert the device.
> >
> > Instead of waiting ready of bridge itself, changing to wait all the
> > downstream devices become ready with timeout PCIE_RESET_READY_POLL_MS
> > after SBR, considering all downstream devices are affected during SBR.
> > Once one of the devices doesn't reappear within the timeout, return
> > -ENOTTY to indicate SBR doesn't complete successfully.
> >
> > Fixes: 6b2f1351af56 ("PCI: Wait for device to become ready after secondary bus reset")
> > Signed-off-by: Sheng Bi <windy.bi.enflame@gmail.com>
> > ---
> >  drivers/pci/pci.c | 30 +++++++++++++++++++++++++++++-
> >  1 file changed, 29 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index eb7c0a08ff57..32b7a5c1fa3a 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -5049,6 +5049,34 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
> >       }
> >  }
> >
> > +static int pci_bridge_secondary_bus_wait(struct pci_dev *bridge, int timeout)
> > +{
> > +     struct pci_dev *dev;
> > +     int delay = 0;
> > +
> > +     if (!bridge->subordinate || list_empty(&bridge->subordinate->devices))
> > +             return 0;
> > +
> > +     list_for_each_entry(dev, &bridge->subordinate->devices, bus_list) {
> > +             while (!pci_device_is_present(dev)) {
> > +                     if (delay > timeout) {
> > +                             pci_warn(dev, "not ready %dms after secondary bus reset; giving up\n",
> > +                                     delay);
> > +                             return -ENOTTY;
> > +                     }
> > +
> > +                     msleep(20);
> > +                     delay += 20;
>
> Your previous version used the same exponential back-off as used in
> pci_dev_wait(), why the change here to poll at 20ms intervals?  Thanks,
>
> Alex

Many thanks for your time. The change is to get a more accurate
timeout, to align with
previous statement "we shouldn't incur any extra delay once timeout has passed".
Previous binary exponential back-off incurred probable unexpected
extra delay, like
60,000 ms timeout but actual 65,535 ms, and the difference probably
goes worse by
timeout setting changes. Thanks,

windy

>
> > +             }
> > +
> > +             if (delay > 1000)
> > +                     pci_info(dev, "ready %dms after secondary bus reset\n",
> > +                             delay);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  void pci_reset_secondary_bus(struct pci_dev *dev)
> >  {
> >       u16 ctrl;
> > @@ -5092,7 +5120,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
> >  {
> >       pcibios_reset_secondary_bus(dev);
> >
> > -     return pci_dev_wait(dev, "bus reset", PCIE_RESET_READY_POLL_MS);
> > +     return pci_bridge_secondary_bus_wait(dev, PCIE_RESET_READY_POLL_MS);
> >  }
> >  EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
> >
> >
> > base-commit: 617c8a1e527fadaaec3ba5bafceae7a922ebef7e
>
