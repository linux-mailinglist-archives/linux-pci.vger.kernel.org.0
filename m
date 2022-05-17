Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C6652A614
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 17:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245174AbiEQPWQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 11:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbiEQPWN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 11:22:13 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A2512AF7;
        Tue, 17 May 2022 08:22:09 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id c24so22447910lfv.11;
        Tue, 17 May 2022 08:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fbo8oC5Oc7cRZaskT+wPfgGDuC/Nuq0YfREb/t0hDRc=;
        b=WgT+PiN1OBL+XGb1RWydMs3KKooX1pVjTZGsxkHXeXQYick9AzvG+v6qxfnijYk7V3
         z1f/k3aVW/plbXmSWmD3y5FwFjC+FLLZ/CQJroUZItJchHatTfk2Q/5qfMTivVi1XwIX
         v5z595b8KisVh5jNVcNFpqaMkDC7R8H8DW2i+EDo25hDWxdCjjDXTyOREPa3va839KGj
         vT1vXuRqtApgUPAX4YSFmliGxzEBae/TwRqXylPnAvJdRLRz/xllo6p3GaRNnm6IjEPv
         EcAjDAY8EgrEIfqBFferbDsjiQ1q152zOz02OzsvFZ7ZJl4BsC72uN6yRBntwC0EKZWE
         qd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fbo8oC5Oc7cRZaskT+wPfgGDuC/Nuq0YfREb/t0hDRc=;
        b=day58hBnxgeuZxHRFWjnw9Q6cGWgs07LUwlK1Sn9uADAvcucDaUmdd5fdajqzDUqkR
         1C/cICQ6tyyH9tC9exuv55+6fnKt3Rlbine0Lu554o0FfgUMvjZLekfql5LXARLbHZSp
         pxsEp3ynnj+ANj8bpz0jVQuMvZhpbmL8xGnXPU343EB7Hu+iELXrhZwLFgFxklST/DNt
         lVvjDIleMLh6GLt0UnzKeRKLFpCgi3z0jtaCBZHk00MYsvGFb8K1zL3qAyfTEqdBpgBk
         hYeLspiwoV10c28/yI9eG3UsZdNEb1Kxm+DD6aDNshn5jj5WWXXBWnq0pCAkj01TQILj
         rbdA==
X-Gm-Message-State: AOAM530u9tHWNMxDSki4fD8Oig/G2h9D4oezw3JjMEYITyqNc297hQZr
        w4R0urnVkxWG26bUGmibOPJIs7I5F2EZ6fVRJV0=
X-Google-Smtp-Source: ABdhPJzL8/Z7dCMCGs6vR/evkPvO+yZIEug/rw3iVXpizzpuSCszvoOe9+RC2WQp5FYMX34Hckn0sCDMBQzRnxRV94E=
X-Received: by 2002:a05:6512:33c3:b0:473:d099:919 with SMTP id
 d3-20020a05651233c300b00473d0990919mr17484451lfg.430.1652800928167; Tue, 17
 May 2022 08:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220516173047.123317-1-windy.bi.enflame@gmail.com>
 <20220516202825.GA1047972@bhelgaas> <20220516165740.6256af51.alex.williamson@redhat.com>
In-Reply-To: <20220516165740.6256af51.alex.williamson@redhat.com>
From:   windy Bi <windy.bi.enflame@gmail.com>
Date:   Tue, 17 May 2022 22:56:24 +0800
Message-ID: <CAGdb+H3vcbE8EmdMyaE9oHRrEOCfii=hCDtkgXPCTo2KFdbQFA@mail.gmail.com>
Subject: Re: [PATCH] drivers/pci: wait downstream hierarchy ready instead of
 slot itself ready, after secondary bus reset
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>
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

Hi Bjorn, Alex

Thank you for reviewing the patch and comments below, I will amend the
violation of
submission rule in patch V2.

Thanks

On Tue, May 17, 2022 at 6:57 AM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Mon, 16 May 2022 15:28:25 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> > [+cc Lukas, pciehp expert; Alex, reset person]
> >
> > Thanks for the testing, analysis, and patch!
> >
> > Run "git log --oneline drivers/pci/pci.c" and make your subject line
> > similar.
> >
> > On Tue, May 17, 2022 at 01:30:47AM +0800, windy.bi.enflame wrote:
> > > While I do reset test of a PCIe endpoint device on a server, I find that
> > > the EP device always been removed and re-inserted again by hotplug module,
> > >  after secondary bus reset.
> > >
> > > After checking I find:
> > > 1> "pciehp_reset_slot()" always disable slot's DLLSC interrupt before
> > >    doing reset and restore after reset, to try to filter the hotplug
> > >    event happened during reset.
> > > 2> "pci_bridge_secondary_bus_reset()" sleep 1 seconad and "pci_dev_wait()"
> > >    until device ready with "PCIE_RESET_READY_POLL_MS" timeout.
> > > 3> There is a PCIe switch between CPU and the EP devicem the topology as:
> > >    CPU <-> Switch <-> EP.
> > > 4> While trigger sbr reset at the switch's downstream port, it needs 1.5
> > >    seconds for internal enumeration.
> >
> > s/seconad/second/
> > s/devicem/device/
> > s/sbr/SBR/
> > s/"pciehp_reset_slot()"/pciehp_reset_slot()/ also for other functions
> >
> > > About why 1.5 seconds ready time is not filtered by "pci_dev_wait()" with
> > > "PCIE_RESET_READY_POLL_MS" timeout, I find it is because in
> > > "pci_bridge_secondary_bus_reset()", the function is operating slot's
> > > config space to trigger sbr and also wait slot itself ready by input same
> > > "dev" parameter. Different from other resets like FLR which is triggered
> > > by operating the config space of EP device itself, sbr is triggered by
> > > up slot but need to wait downstream devices' ready, so I think function
> > > "pci_dev_wait()" works for resets like FLR but not for sbr.
>
> Is the unexpected hotplug occurring then because the device is not
> ready after the 1s sleep after the sbr and we re-trigger the hotplug
> controller which then triggers because the link status is still down?

Yes, the device becomes accessible at ~1.5s after SBR while hotplug
interrupt was re-enabled after 1s sleep. Then the hotplug event at 1.5s
was been judged as real hotplug.

>
> > > In this proposed patch, I'm changing the waiting function used in sbr to
> > > "pci_bridge_secondary_bus_wait()" which will wait all the downstream
> > > hierarchy ready with the same timeout setting "PCIE_RESET_READY_POLL_MS".
> > > In "pci_bridge_secondary_bus_wait()" the "subordinate" and
> > > "subordinate->devices" will be checked firstly, and then downstream
> > > devices' present state.
> > >
> > > Signed-off-by: windy.bi.enflame <windy.bi.enflame@gmail.com>
> >
> > See https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v5.17#n407
> > regarding pseudonyms.
> >
> > > ---
> > >  drivers/pci/pci.c | 25 ++++++++++++++++++++++++-
> > >  1 file changed, 24 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 9ecce435fb3f..d7ec3859268b 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -5002,6 +5002,29 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
> > >     }
> > >  }
> > >
> > > +int pci_bridge_secondary_bus_wait(struct pci_dev *bridge, int timeout)
> > > +{
> > > +   struct pci_dev *dev;
> > > +   int delay = 1;
> > > +
> > > +   if (!bridge->subordinate || list_empty(&bridge->subordinate->devices))
> > > +           return 0;
> > > +
> > > +   list_for_each_entry(dev, &bridge->subordinate->devices, bus_list) {
> > > +           while (!pci_device_is_present(dev)) {
> > > +                   if (delay > timeout) {
> > > +                           pci_warn(dev, "secondary bus not ready after %dms\n", delay);
> > > +                           return -ENOTTY;
> > > +                   }
> > > +
> > > +                   msleep(delay);
> > > +                   delay *= 2;
> > > +           }
> > > +   }
> > > +
> > > +   return 0;
> > > +}
> > > +
> > >  void pci_reset_secondary_bus(struct pci_dev *dev)
> > >  {
> > >     u16 ctrl;
> > > @@ -5045,7 +5068,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
> > >  {
> > >     pcibios_reset_secondary_bus(dev);
> > >
> > > -   return pci_dev_wait(dev, "bus reset", PCIE_RESET_READY_POLL_MS);
>
> I assume pci_dev_wait here was always a no-op because we're testing the
> wrong device, maybe this should be marked as:
>
> Fixes: 6b2f1351af56 ("PCI: Wait for device to become ready after secondary bus reset")

I think so too, will mark it if we all aligned.

>
> > > +   return pci_bridge_secondary_bus_wait(dev, PCIE_RESET_READY_POLL_MS);
>
> The theory looks reasonable to me, but I'd hope we cold get a better
> commit log and improve the dev_warn message.  It seems to make sense to
> use pci_device_is_present() since we shouldn't be dealing with VFs
> after a bus reset, but I wonder if we want to enumerate all the missing
> devices.  Since the timeout has passed, we shouldn't incur any extra
> delays beyond the first device that doesn't re-appear.  Thanks,
>
> Alex

Thanks for your suggestion. I thought to enumerate all the missing
devices because SBR affects all the downstream hierarchy and
devices need to be re-enumerated as possible as we can.
I agree that we shouldn't incur any extra delays once the timeout has
already passed, since SBR fails as long as one device fails.

>
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
> > >
> > > --
> > > 2.36.1
> > >
> >
>
