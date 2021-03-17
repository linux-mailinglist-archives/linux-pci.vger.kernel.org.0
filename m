Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2A733F0FF
	for <lists+linux-pci@lfdr.de>; Wed, 17 Mar 2021 14:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhCQNSY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Mar 2021 09:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhCQNSN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Mar 2021 09:18:13 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E02C06174A;
        Wed, 17 Mar 2021 06:18:02 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id j25so1083723pfe.2;
        Wed, 17 Mar 2021 06:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5vT/eDDB8bb1mbvIFsQc8hatBbQbyytVF3slTgeiXPg=;
        b=n1UfrUrvTupANEHpSD12z4KQlD91GER/yykTc/0i0gP1Fp1j/qEaJKREGpZHQ93aw0
         rzjCTFe7HgbgVkZM4TJ7j7q/XS7bhjAcnD2AQPjrcY4Unw7YG7MsIuypYA/j1Q3yVit4
         /cef5pb3YSaIOPJTJyY6kf8Qn5OWBOLZYm82/7gCBUUHoTFbHoYtlpYv+AoZy6NRGwnL
         RR3thPYg7MdsnoTCqiI0DOXuOWeEY+veah5PJbHpbhw9OKGkW3t9W1mpoPPPsVBcnOjg
         2HfxD3H4lDtEhQRdB+R3SUcJX/3ppMJCWkDTsgafJovh8sIyzNM79PgzRLdeHzgpqIsm
         ytYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5vT/eDDB8bb1mbvIFsQc8hatBbQbyytVF3slTgeiXPg=;
        b=MdikU7NtWokzN/rZ5hdzjXp1L1jLVydaxn5MTO2CC5XMTHMyo7nAdzRixt2Y7EEOPU
         Tb76eHL73HctgHPGF0/ztEHsoivgNGwYnERv0TDzG5+MWF9bUJ0rbWD0KL41cAera5qG
         y7YdbxR2LrK3UrnwcqySCIxHp3emHwh9ejDLmdYdBJel+Y+b485Isifx4Pbv5A+c1DH0
         3+lZV6wo+PDJ7BMcUpA4XCqA3dcGl+vpgZ3EoozThPMvMNNk4XjCoNorfEiD++n/Awbm
         KMp1BAQvlNdWy/hJ147P3AVcopJZjwxNzQP4MS8rg9WlmrPgW3dfpSIi+6kU63cNR1Zp
         Db5w==
X-Gm-Message-State: AOAM533X7lM4AYHoUzzYNXypLV/h7AuOTLVAY7fCqhtpI0D7CkPLtk37
        z6AjkXmtto7ZQn5YqM8c+d4=
X-Google-Smtp-Source: ABdhPJz+s0gm0d2B/TE+YSJcLnevBLwGJQz0kw2vEwQf8hum46D1ml5DnAMkzD4xXWvQxBeHcdaQ/A==
X-Received: by 2002:a63:410:: with SMTP id 16mr2640193pge.220.1615987081582;
        Wed, 17 Mar 2021 06:18:01 -0700 (PDT)
Received: from localhost ([103.248.31.158])
        by smtp.gmail.com with ESMTPSA id w191sm7321229pfd.25.2021.03.17.06.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 06:18:01 -0700 (PDT)
Date:   Wed, 17 Mar 2021 18:47:18 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     alex.williamson@redhat.com, raphael.norwitz@nutanix.com,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, alay.shah@nutanix.com,
        suresh.gumpula@nutanix.com, shyam.rajendran@nutanix.com,
        felipe@nutanix.com
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <20210317131718.3uz7zxnvoofpunng@archlinux>
References: <20210315083409.08b1359b@x1.home.shazbot.org>
 <YE94InPHLWmOaH/b@unreal>
 <20210315153341.miip637z35mwv7fv@archlinux>
 <20210315102950.230de1d6@x1.home.shazbot.org>
 <20210315183226.GA14801@raphael-debian-dev>
 <YFGDgqdTLBhQL8mN@unreal>
 <20210317102447.73no7mhox75xetlf@archlinux>
 <YFHh3bopQo/CRepV@unreal>
 <20210317112309.nborigwfd26px2mj@archlinux>
 <YFHsW/1MF6ZSm8I2@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YFHsW/1MF6ZSm8I2@unreal>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/03/17 01:47PM, Leon Romanovsky wrote:
> On Wed, Mar 17, 2021 at 04:53:09PM +0530, Amey Narkhede wrote:
> > On 21/03/17 01:02PM, Leon Romanovsky wrote:
> > > On Wed, Mar 17, 2021 at 03:54:47PM +0530, Amey Narkhede wrote:
> > > > On 21/03/17 06:20AM, Leon Romanovsky wrote:
> > > > > On Mon, Mar 15, 2021 at 06:32:32PM +0000, Raphael Norwitz wrote:
> > > > > > On Mon, Mar 15, 2021 at 10:29:50AM -0600, Alex Williamson wrote:
> > > > > > > On Mon, 15 Mar 2021 21:03:41 +0530
> > > > > > > Amey Narkhede <ameynarkhede03@gmail.com> wrote:
> > > > > > >
> > > > > > > > On 21/03/15 05:07PM, Leon Romanovsky wrote:
> > > > > > > > > On Mon, Mar 15, 2021 at 08:34:09AM -0600, Alex Williamson wrote:
> > > > > > > > > > On Mon, 15 Mar 2021 14:52:26 +0100
> > > > > > > > > > Pali Rohár <pali@kernel.org> wrote:
> > > > > > > > > >
> > > > > > > > > > > On Monday 15 March 2021 19:13:23 Amey Narkhede wrote:
> > > > > > > > > > > > slot reset (pci_dev_reset_slot_function) and secondary bus
> > > > > > > > > > > > reset(pci_parent_bus_reset) which I think are hot reset and
> > > > > > > > > > > > warm reset respectively.
> > > > > > > > > > >
> > > > > > > > > > > No. PCI secondary bus reset = PCIe Hot Reset. Slot reset is just another
> > > > > > > > > > > type of reset, which is currently implemented only for PCIe hot plug
> > > > > > > > > > > bridges and for PowerPC PowerNV platform and it just call PCI secondary
> > > > > > > > > > > bus reset with some other hook. PCIe Warm Reset does not have API in
> > > > > > > > > > > kernel and therefore drivers do not export this type of reset via any
> > > > > > > > > > > kernel function (yet).
> > > > > > > > > >
> > > > > > > > > > Warm reset is beyond the scope of this series, but could be implemented
> > > > > > > > > > in a compatible way to fit within the pci_reset_fn_methods[] array
> > > > > > > > > > defined here.  Note that with this series the resets available through
> > > > > > > > > > pci_reset_function() and the per device reset attribute is sysfs remain
> > > > > > > > > > exactly the same as they are currently.  The bus and slot reset
> > > > > > > > > > methods used here are limited to devices where only a single function is
> > > > > > > > > > affected by the reset, therefore it is not like the patch you proposed
> > > > > > > > > > which performed a reset irrespective of the downstream devices.  This
> > > > > > > > > > series only enables selection of the existing methods.  Thanks,
> > > > > > > > >
> > > > > > > > > Alex,
> > > > > > > > >
> > > > > > > > > I asked the patch author here [1], but didn't get any response, maybe
> > > > > > > > > you can answer me. What is the use case scenario for this functionality?
> > > > > > > > >
> > > > > > > > > Thanks
> > > > > > > > >
> > > > > > > > > [1] https://lore.kernel.org/lkml/YE389lAqjJSeTolM@unreal/
> > > > > > > > >
> > > > > > > > Sorry for not responding immediately. There were some buggy wifi cards
> > > > > > > > which needed FLR explicitly not sure if that behavior is fixed in
> > > > > > > > drivers. Also there is use a case at Nutanix but the engineer who
> > > > > > > > is involved is on PTO that is why I did not respond immediately as
> > > > > > > > I don't know the details yet.
> > > > > > >
> > > > > > > And more generally, devices continue to have reset issues and we
> > > > > > > impose a fixed priority in our ordering.  We can and probably should
> > > > > > > continue to quirk devices when we find broken resets so that we have
> > > > > > > the best default behavior, but it's currently not easy for an end user
> > > > > > > to experiment, ie. this reset works, that one doesn't.  We might also
> > > > > > > have platform issues where a given reset works better on a certain
> > > > > > > platform.  Exposing a way to test these things might lead to better
> > > > > > > quirks.  In the case I think Pali was looking for, they wanted a
> > > > > > > mechanism to force a bus reset, if this was in reference to a single
> > > > > > > function device, this could be accomplished by setting a priority for
> > > > > > > that mechanism, which would translate to not only the sysfs reset
> > > > > > > attribute, but also the reset mechanism used by vfio-pci.  Thanks,
> > > > > > >
> > > > > > > Alex
> > > > > > >
> > > > > >
> > > > > > To confirm from our end - we have seen many such instances where default
> > > > > > reset methods have not worked well on our platform. Debugging these
> > > > > > issues is painful in practice, and this interface would make it far
> > > > > > easier.
> > > > > >
> > > > > > Having an interface like this would also help us better communicate the
> > > > > > issues we find with upstream. Allowing others to more easily test our
> > > > > > (or other entities') findings should give better visibility into
> > > > > > which issues apply to the device in general and which are platform
> > > > > > specific. In disambiguating the former from the latter, we should be
> > > > > > able to better quirk devices for everyone, and in the latter cases, this
> > > > > > interface allows for a safer and more elegant solution than any of the
> > > > > > current alternatives.
> > > > >
> > > > > So to summarize, we are talking about test and debug interface to
> > > > > overcome HW bugs, am I right?
> > > > >
> > > > > My personal experience shows that once the easy workaround exists
> > > > > (and write to generally available sysfs is very simple), the vendors
> > > > > and users desire for proper fix decreases drastically. IMHO, we will
> > > > > see increase of copy/paste in SO and blog posts, but reduce in quirks.
> > > > >
> > > > > My 2-cents.
> > > > >
> > > > I agree with your point but at least it gives the userspace ability
> > > > to use broken device until bug is fixed in upstream.
> > >
> > > As I said, I don't expect many fixes once "userspace" will be able to
> > > use cheap workaround. There is no incentive to fix it.
> > >
> > > > This is also applicable for obscure devices without upstream
> > > > drivers for example custom FPGA based devices.
> > >
> > > This is not relevant to upstream kernel. Those vendors ship everything
> > > custom, they don't need upstream, we don't need them :)
> > >
> > By custom I meant hobbyists who could tinker with their custom FPGA.
>
> I invite such hobbyists to send patches and include their FPGA in
> upstream kernel.
>
> >
> > > > Another main application which I forgot to mention is virtualization
> > > > where vmm wants to reset the device when the guest is reset,
> > > > to emulate machine reboot as closely as possible.
> > >
> > > It can work in very narrow case, because reset will cause to device
> > > reprobe and most likely the driver will be different from the one that
> > > started reset. I can imagine that net devices will lose their state and
> > > config after such reset too.
> > >
> > Not sure if I got that 100% right. The pci_reset_function() function
> > saves and restores device state over the reset.
>
> I'm talking about netdev state, but whatever given the existence of
> sysfs reset knob.
>
> >
> > > IMHO, it will be saner for everyone if virtualization don't try such resets.
> > >
> > > Thanks
> > >
> > The exists reset sysfs attribute was added for exactly this case
> > though.
>
> I didn't know the rationale behind that file till you said and I
> googled libvirt discussion, so ok. Do you propose that libvirt
> will manage database of devices and their working reset types?
>
I don't have much idea about internals of libvirt but why would
it need to manage database of working reset types? It could just
read new reset_methods attribute to get the list of supported reset
methods.
> I'm not against this patch, just want to raise an attention that the
> outcome of this patch will be decrease in fixes of broken devices.
>
> Thanks
>
That makes sense but that isn't any different from existing reset
attribute. This patch inhances it and allows selecting a device supported
reset method instead of using first available reset method according to
existing hardcoded policy.

Thanks,
Amey
