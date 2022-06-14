Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1F154B50F
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 17:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241398AbiFNPqU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jun 2022 11:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241022AbiFNPqT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2022 11:46:19 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0424640E4C;
        Tue, 14 Jun 2022 08:46:17 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id v25so12228511eda.6;
        Tue, 14 Jun 2022 08:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nfTAgqZHBZjtM/y5tRHC3jaZEPA00KzpeUJrHgo232E=;
        b=Hz/06Qd3DuL+0aSdCvQ+LrzG9pNh4nq7R+0cWXVM8/UmTCSsn/kEFWtd2znicwSRXU
         8/Q+I0yxH/OhewNzc1HRRyR289QxyBBLwARL8F2xZEgp6dlvLo86w6iW/qF69lRpV7SF
         oeglckSY2br2zgmrLshNyajH3gmnlj6Pyy1bqZHVwgN2s01HneerEfvFpWeN305NowqH
         GiM5T0u1cwyJkRjD9D1Glch/Tgg7Hp+OZ/W7rOZU8YU0QlGloTqhu/Ba5cIdwAQisyyu
         Ux8UA5lzYZEB3geJmEEeIDJE3b2S+uqXrTiJdTiz01aly/r4c2j2uvLtcfoIlGiv97jn
         Q/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nfTAgqZHBZjtM/y5tRHC3jaZEPA00KzpeUJrHgo232E=;
        b=vjz9h+3knvPSO3hT38GWqitR3F/+ZGGm8J1rtzv3PsSFT3YPJX0HB/fHIIlAMFkArG
         sHqb6J0juSUmhZYOD50iVdKXIhbXVX4/25bLTL7azQS/p2SPgQ1Cf18+VSvk1o3jaB8B
         5+PlqTqrN5dGk8a+42oK0EU+2Z6aDLsznzkwg7a30UmVDPOo1fQwWmv0+LKU6VSJt008
         gOZcLlbDA9YAe81+JCDWlejzYBaSW2yuqYcTclhbwBM67Pm17uDr3+uZNQFtfKr7L7/c
         +pxWFeIzngTeOeAUWM3bLx5fhEkNttOc4m2z5BwucgC5DdGgUZvjEqRaqIgR4az4rkCt
         cBRQ==
X-Gm-Message-State: AOAM530I2Khky4GkeyXiy3y/W/HlyVo6wrAFHX6jY6yYMm/uxelrInZo
        hLuSWZnUAMj/6wFFxKPyxHk3hoEF0L51dPu+t8Y=
X-Google-Smtp-Source: ABdhPJzDijUS05L/cIZxobR6iSqpiY+NVNJLh8JURw9ZCXKmqWch/j66MxziGjPvfelXFhydfcQgwxeUcjTGxdsPidc=
X-Received: by 2002:aa7:d303:0:b0:42d:d192:4c41 with SMTP id
 p3-20020aa7d303000000b0042dd1924c41mr6931614edq.178.1655221575397; Tue, 14
 Jun 2022 08:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <Yqh3PtENhktETx4S@smile.fi.intel.com> <20220614151850.GA756316@bhelgaas>
In-Reply-To: <20220614151850.GA756316@bhelgaas>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Jun 2022 17:45:38 +0200
Message-ID: <CAHp75Vc0ArHC+iB45spvmAm-3zMDPHbhYjLkw=iTLhKQ0bZRDg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] x86/PCI: Disable e820 usage for the resource allocation
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ferry Toth <ftoth@exalondelft.nl>
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

On Tue, Jun 14, 2022 at 5:26 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Jun 14, 2022 at 02:55:42PM +0300, Andy Shevchenko wrote:
> > On Mon, Jun 13, 2022 at 05:35:20PM -0500, Bjorn Helgaas wrote:
> > > On Mon, Jun 13, 2022 at 11:16:41PM +0300, Andy Shevchenko wrote:
> > > > The resource management improve for PCI on x86 broke booting of Intel MID
> > > > platforms. It seems that the current code removes all available resources
> > > > from the list and none of the PCI device may be initialized. Restore the
> > > > old behaviour by force disabling the e820 usage for the resource allocation.
> > > >
> > > > Fixes: 4c5e242d3e93 ("x86/PCI: Clip only host bridge windows for E820 regions")
> > > > Depends-on: fa6dae5d8208 ("x86/PCI: Add kernel cmdline options to use/ignore E820 reserved regions")
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >
> > > Yeah, I blew it with 4c5e242d3e93.  Can you provide more details on
> > > how the MID platforms broke?
> >
> > It's not so easy. The breakage seems affects the console driver and earlycon
> > doesn't work. erlyprintk doesn't support 32-bit MMIO addresses (again,
> > addresses, not data size). That said, there is nothing to show at all.
> >
> > What I did, I have bisected to your patch, commented out the call and instead
> > added a printk() to see what it does, and it basically removed all resources
> > listed in _CRS.
> >
> > > Since you set "pci_use_e820 = false" for
> > > MID below, I assume MID doesn't depend on the e820 clipping and thus
> > > should not break if we turn off clipping by default in 2023 as in
> > > 0ae084d5a674 ("x86/PCI: Disable E820 reserved region clipping starting
> > > in 2023").
> >
> > > But it'd be nice to see the dmesg log and make sure.
> >
> > Nothing to provide (see above why), sorry.
>
> A dmesg log with a working kernel, especially from one with Hans'
> revert, which might have a little more logging about clipping, might
> have enough info to help figure this out.

https://paste.debian.net/1244105/

(It has a lot of unrelated debug thingy, sorry I didn't cut that out)

-- 
With Best Regards,
Andy Shevchenko
