Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644F1517738
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 21:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387054AbiEBTRT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 15:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387050AbiEBTRS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 15:17:18 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31677E92
        for <linux-pci@vger.kernel.org>; Mon,  2 May 2022 12:13:49 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id e194so16912697iof.11
        for <linux-pci@vger.kernel.org>; Mon, 02 May 2022 12:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y0LBGAd1mzPzBgDI34ZO9E56JL4JndzFBjXWTJ7seYs=;
        b=ckPp/NdRMXgf5FFXPyGc9liaDJqL2hcNn8pjXgoavzCrY0KDzgtvF0XFqZcMNDXfOr
         6l0lOd/hHI50esNE7LrmDR6dg2UfbkHDyciTF6LeHVIUleHrSlXIeRHzr97J1v7x8kSk
         uzomDevaWRkXHoUH1qWDXTMfMsXSKVz+jFnJCewEpD4C6IMblNSJx23INuzLghEhlxQE
         6mEsGQvJu3GuLNm3d8F4s/JrjutfEMrDVMEOfsJPdPIG+JojWyMeaaIRprxbMHoaoQxh
         Gk4SpxniQhemtQMl77jiDeVgdZebFILROTazekNN8BwMh2KFYXZPPdsTcFTHY45nWptd
         Am4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y0LBGAd1mzPzBgDI34ZO9E56JL4JndzFBjXWTJ7seYs=;
        b=WdfCJlkA3PtOQcsUfabMq+WbRvjoYmyQ21Fnwa8rD1H89TNp3YiSelfzrgE1HZF4CB
         /YfjJxM/uGRXquYV7xJFlsyxfyJXl6tFjZkn8/VXXPNcpsMD95uXFEW18h7L+Ijhy9rO
         e3/QjM0+w/LxjrYACZJYfY2CL2O0YewG57BaIG/PSvcJpGxriR9mDR8WXnIe7EoyzW5R
         +i3jgT2LkXK5j2fRnS3Of+SNkkIYrNe74Gf3IlGa6lHdBv8/Me0xbtXOZVHJFC8QmRDX
         EQNaqz1xUfMKTu4BZQA+Peoga5YSr1qEswDJSkGsYirutWbvgDH/AmbhxtaNOslofRst
         ZcJw==
X-Gm-Message-State: AOAM5323G265FfDxNWZQu8VOwRigknT86buRKIe8CC8Rg1TEGvJf8/2x
        IGrSxPWA8U1hrUt21F/hB3w7N17uiQ8N2kgTwLIMfA==
X-Google-Smtp-Source: ABdhPJwHqlWg5WB6OOOBQLDDEVN8nqKNBqzia3qBgR8p0HecQJbYk6Xkq8myPoSaLOqltKHBMqJU5Kkn5+UKlAQieTA=
X-Received: by 2002:a6b:4419:0:b0:657:aeaa:d2e with SMTP id
 r25-20020a6b4419000000b00657aeaa0d2emr4701122ioa.24.1651518828432; Mon, 02
 May 2022 12:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220412224348.1038613-1-tansuresh@google.com>
 <20220412224348.1038613-2-tansuresh@google.com> <CAJZ5v0ivNq3aYCEcxPYMosLJCAyWiAnucwOCmRBzkM=sbyPWgQ@mail.gmail.com>
 <CALVARr6v5hcY0Vcf1izPUX-tXNJyyNXBMANbKX4CW9wfRf-pYQ@mail.gmail.com> <YmzqrqfVLQ9/4KXp@kroah.com>
In-Reply-To: <YmzqrqfVLQ9/4KXp@kroah.com>
From:   Tanjore Suresh <tansuresh@google.com>
Date:   Mon, 2 May 2022 12:13:37 -0700
Message-ID: <CALVARr50MWexNpCf_PoZ4-pdnexiZiibz7Nd0PH+b-EVnBUN6w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] driver core: Support asynchronous driver shutdown
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 30, 2022 at 12:52 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
>
> A: No.
> Q: Should I include quotations after my reply?
>
> http://daringfireball.net/2007/07/on_top
>
> On Fri, Apr 29, 2022 at 11:03:07AM -0700, Tanjore Suresh wrote:
> > Rafael,
> >
> > That is a good observation, however, many of the use cases in data
> > centers (deployment of devices in data centers) do not exploit device
> > power management. Therefore, I'm not sure that is the right way to
> > design this.
>
> Yes it is, enable device power management and use that interface please.
> Devices in data centers should of course be doing the same thing as
> everyone else, as it actually saves real money in power costs.  To not
> do so is very odd.
>

I guess we are intermixing the  terminology of device power management
with shutdown.
My second, third reasoning in my previous e-mail, thought it brings
out that difference. Maybe not.
I will try one more time, my thought process on this one.

This patch is only for shutdown. The shutdown can be done in a system
in various flavors,
(this may include a power being pulled from the system components when
all the devices
are quiescent and it can also be soft shutdown, where power is not
removed from the system, but system
could be attempting a reboot)

The device power management allows the device to bring down any
devices that may be idle to various power states that
device may support in a selective manner & based on the transition
allowed by the device. Such a transition initiated by
the system can be achieved using the 'dpm' interface for runtime power
management (more for extending laptop battery life).
It can also be exploited for system sleep models (suspend and resume -
where state is preserved and restarted from where it left off
--> More applicable for laptops/desktops). That does not mean data
center devices cannot exploit, but they worry about slight latency
variation in any
I/O initiated to any device. Such power management could introduce
more latency when it transitions from one state to another.
Therefore, the use case is more apt for Laptops, in certain cases
desktops in my opinion or understanding.

The shutdown entry point has been traditionally different and the
semantics is that the whole system is going down to a
quiescent state and power may be pulled or may not be, IMO, i am
seeing both are independent requirements, in my view.
Let me know if I am mistaken. I am not sure why we should break the
shutdown semantics as understood by driver developers and
overload it with dpm requirements?

Thanks
sureshtk


> thanks,
>
> greg k-h
