Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52182554CD5
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 16:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355171AbiFVOYT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 10:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358551AbiFVOYB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 10:24:01 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B183226;
        Wed, 22 Jun 2022 07:24:01 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id cs6so20837299qvb.6;
        Wed, 22 Jun 2022 07:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=47CZ/8z++lPLMGgWvjLGRK3En04kLhxiijUz+sWDc3c=;
        b=gYOcNbxuH/jdGicKb/ACiiyuT8hZePIQom5+Zyba28uQ9qd30Cuud+yoRuBYRuVvkP
         a91ojLIHA/yl0AJHhJo+CgLyBSpJqME4KvjTaB7uYHdQGc4slIdez/GnDBIYSVqlz/bF
         7tDVws1LMLSIwMvuoIhqaN8kUX0kVfj4TcyQPqyKTP06g66vtIGAZY4S9MBnGUwJspv4
         Pelf/RgQg1ZqPaCbRZQJGIr/99Wm4BwHSqCM8SWj6ED4birFYyxDeVstfcZNzFO5ADNO
         pENyRiFdUlYvkS2gO/UqO20AK0GVijQO/Ygi8sjSXaw6bsC4T+3pYDRZML7hYA+XPyxC
         wgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=47CZ/8z++lPLMGgWvjLGRK3En04kLhxiijUz+sWDc3c=;
        b=ni+Yp2MuuRPXaWAp/dhiAVFlRrJCpxAUffUj9RXfHMmUtpxp4tdcPJlmsNurLK6gz/
         BWheMd5/O9YjisLJlwtv6X5tRPfk4EJqTopHnNce6+23nrq4HapmiwU/ZcZ8JpxpWrq6
         C6sd3ao/D2FnQ7i5EeId13wf2avgnnktEONZZfHpsryYxLcas50aconXPITiTNEHqDns
         17l87qGVvTM7rp/0aBOkjC2s9UFjAaMaMJ0Ldge8I9hyWHOPoURQO/9PJqCBn2+5xbJq
         nvNXiH1kNX6/8quQxtMqo/8o964CdS3BuccOa5EgTWe3vOdOYxZJsC+EjYJDKX1/SnL1
         8M1A==
X-Gm-Message-State: AJIora8yXs1wOxYg3ofEdZILd/RtlkWmhlVSNzgPd9GiLk41ZhtVl8NE
        i9oNHJlh04ni15/qlky5PR5QmuL/IiK38yH1pEc=
X-Google-Smtp-Source: AGRyM1sXrDN6NqYZ3O60lot4J5QHl5q8cgCMah1i0/5CG24DaZpgtf4LZdxV2QIsAiHnC4DNBO/A+qOG42E2sxu0GRY=
X-Received: by 2002:a05:6214:d08:b0:470:51b1:e541 with SMTP id
 8-20020a0562140d0800b0047051b1e541mr8098809qvh.50.1655907840012; Wed, 22 Jun
 2022 07:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAOX2RU7idTVcW6ivqs3V_Ep33RoHZs1zt0jav-_z2D7xpKJstw@mail.gmail.com>
 <20220621214343.GA1335071@bhelgaas>
In-Reply-To: <20220621214343.GA1335071@bhelgaas>
From:   Robert Marko <robimarko@gmail.com>
Date:   Wed, 22 Jun 2022 16:23:49 +0200
Message-ID: <CAOX2RU6isNEF4LYRDUEjnKwOcsEoPJR2ekn2kD9RjKFwusF4DA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: qcom: fix IPQ8074 Gen2 support
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lpieralisi@kernel.org, Rob Herring <robh@kernel.org>, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>, p.zabel@pengutronix.de,
        jingoohan1@gmail.com, linux-pci@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        johan+linaro@kernel.org
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

On Tue, 21 Jun 2022 at 23:43, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Jun 21, 2022 at 11:05:17PM +0200, Robert Marko wrote:
> > On Tue, 21 Jun 2022 at 22:32, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Tue, Jun 21, 2022 at 01:23:30PM +0200, Robert Marko wrote:
> > > > IPQ8074 has one Gen2 and one Gen3 port, currently the Gen2 port will
> > > > cause the system to hang as its using DBI registers in the .init
> > > > and those are only accesible after phy_power_on().
> > >
> > > Is the fact that IPQ8074 has both a Gen2 and a Gen3 port relevant to
> > > this patch?  I don't see the connection.
> >
> > Not really, I can remove it from the description as this only affects the Gen2
> > port, Gen3 support is dependant on the IPQ6018 support getting merged as
> > it uses the same controller.
>
> Great, I think unrelated details confuse things.
>
> > > I see that qcom_pcie_host_init() does:
> > >
> > >   qcom_pcie_host_init
> > >     pcie->cfg->ops->init(pcie)
> > >     phy_power_on(pcie->phy)
> > >     pcie->cfg->ops->post_init(pcie)
> > >
> > > and that you're moving DBI register accesses from
> > > qcom_pcie_init_2_3_3() to qcom_pcie_post_init_2_3_3().
> > >
> > > But I also see DBI register accesses in other .init() functions:
> > >
> > >   qcom_pcie_init_2_1_0
> > >   qcom_pcie_init_1_0_0      (oddly out of order)
> > >   qcom_pcie_init_2_3_2
> > >   qcom_pcie_init_2_4_0
> > >
> > > Why do these accesses not need to be moved?  I assume it's because
> > > pcie->phy is an optional PHY and phy_power_on() does nothing on those
> > > controllers?
> >
> > As far as I could figure out from QCA-s 5.4 kernel, various commits,
> > and QCA-s attempts to solve this already upstream the Gen2
> > controller in IPQ8074 is a bit special and requires the PHY to be
> > powered on before DBI could be accessed or else the board will hang
> > as it does for me.
> >
> > I can only assume that this is an IPQ8074-specific quirk and other
> > IP-s are not affected like this, so they were not broken.
>
> > > Whatever the reason, I think the DBI accesses should be done
> > > consistently in .post_init().  I see that Dmitry's previous patches
> > > removed all those .post_init() functions, but I think the consistency
> > > is worth having.
> > >
> > > Perhaps we could reorder the patches so this patch comes first, moves
> > > the DBI accesses into .post_init(), then Dmitry's patches could be
> > > rebased on top to drop the clock handling?
> > >
> > > > So solve this by splitting the DBI read/writes to .post_init.
> >
> > I am open to anything to get this fixed properly, you are gonna need
> > to point me in the right direction as I am really new to PCI.
>
> Unless there's a reason *not* to move the DBI accesses for other
> variants, I think we should move them all to .post_init().  Otherwise
> it's just magic -- there's no indication in the code about why IPQ8074
> needs to be different from all the rest.

Hi Bjorn,
I am not sure how to do it properly, especially for the 2.1.0 IP that
IPQ8064 uses
and that is already filled with tweaks to get it properly working.

As far as I can tell, the reason why it works for all of the others is that they
dont use a PHY driver at all (2.1.0 in IPQ8064 and 2.4.0 in IPQ4019),
1.1.0 in APQ8084 appears to be unused completely as its compatible is not
used in any of the DTS-es.
2.3.2 in MSM8996 and MSM8998 also use QMP, so I am not sure why these work.

>
> a0fd361db8e5 appeared in v5.11, so presumably IPQ8074 has been broken
> since then?  Are there any problem report URLs or references to the
> attempts you mentioned above that we could include here?

It has been broken since then, it worked on 5.10 when I started poking around
IPQ8074 and after backporting the 5.11 commits to get the Gen3 port working
it stopped working, and I traced that down to hanging after a DBI write.

This appears to be QCA-s attempt to always power on the PHY before the init:
https://patchwork.kernel.org/project/linux-pci/patch/1596036607-11877-6-git-send-email-sivaprak@codeaurora.org/

>
> Since folks may want to backport the fix to v5.11, I'd probably do
> this patch by itself to make the backport easier, then add a second
> patch to move the DBI accesses for all the other variants.
>
> My personal opinion is that you should do this based on v5.19-rc1, and
> then we can rebase Dmitry's patches on top.  That would make all the
> patches simpler and it would make yours easier to backport.  But
> that's the sort of thing Dmitry, Stanimir, Andy, and Bjorn A. could
> weigh in on.

This patch applies to 5.19 as well, though I will send a v4 with the
updated description.
Like, I said, I am not sure how to move DBI accesses in other IP-s
without breaking them.

Regards,
Robert
>
> Bjorn H.
