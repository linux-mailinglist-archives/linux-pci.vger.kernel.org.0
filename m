Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453B1659969
	for <lists+linux-pci@lfdr.de>; Fri, 30 Dec 2022 15:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbiL3Omf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Dec 2022 09:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235085AbiL3OmY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Dec 2022 09:42:24 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82F7193D3;
        Fri, 30 Dec 2022 06:42:23 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id r11so19536264oie.13;
        Fri, 30 Dec 2022 06:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ImGgkIxtp0R2ay3gNEpK2ygUXRVYeCeky2W5vFQ3J+8=;
        b=Z/H0fzziQQhuYuww4lmzf5G2bNgS2aaGHpSBtqoKn8mlA/syKix0o5Ddr8VYAR9ZzO
         ZpBTuPxQxLntY2aG/iit3r9h9yL6lYVMoxRxcoyZTXMvkjhno0zJkXccWM7Qy19mRqFY
         ZMkv7Z3Sh5AmakzqGDHOqxFMqknA59a/vqv82IwsdZmYi01b9UTreIdc5TXvbK/czd7T
         qt97t+3m/vtXFuB7GE0QTlzE7ekL5CX3k9r1lUSBJRVcsVjfCoCKduizfQ7jqc8cnZnR
         Le/pvglg9ZlbWIj5c7LqHR6drKUP7Hg6JsyomqGE26ljTktGedD2ltCwVLA+AGh/rBn/
         yJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ImGgkIxtp0R2ay3gNEpK2ygUXRVYeCeky2W5vFQ3J+8=;
        b=pC0NX5nzqahhe7EixYE38itFj7Qnq1WiVgW+X+IkMrDbjM2kRg0+zWQ+deWzFFcGwh
         pc2tTgb2gw0sIv3uVbLJ3zXTtlsNuzEs6nKx9OfUWEsAP/DeVsH5Lu5BW3+0Ri54R7+I
         mxMka7mCNXL6MWRrOTBgiOnqzzYyKmRDLounLhDhk0mVWYvvmespq1qK7Q5PU/1gJgbH
         4M/nl/BhdAWzDWPpQYklwOy8oSKbWuXaZDospKb0dB22AtXuBkj3mHm1siWaN6Mnb3Gz
         662mDiOmyIfygn3U5LGtMGst1EYjteu4hQMXa8hNTB1hiVh3P/w4Z/k3RFQaClFnYcoD
         iT/w==
X-Gm-Message-State: AFqh2kp0XEUl8WFR5xJcC/Xh5PbVXtzRf+NLUOix/e9YZd6uiAFRA88Z
        zDL4Odot3+y9SpsT31R/nX1PtCynUgd0tKqcyxo=
X-Google-Smtp-Source: AMrXdXuDno+6OeOZuZPUQqB3mZ7Z/yNqxhwVHv640fuMuwX8koOEpJRdNDz/ReuKWRXgEWUuJOrOjAdbJLiN1/OtjqY=
X-Received: by 2002:aca:6706:0:b0:35a:51fc:2134 with SMTP id
 z6-20020aca6706000000b0035a51fc2134mr1727368oix.144.1672411342609; Fri, 30
 Dec 2022 06:42:22 -0800 (PST)
MIME-Version: 1.0
References: <20221209071703.2891714-1-sergio.paracuellos@gmail.com> <Y670XhTSrs3n9c0H@lpieralisi>
In-Reply-To: <Y670XhTSrs3n9c0H@lpieralisi>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 30 Dec 2022 15:42:11 +0100
Message-ID: <CAMhs-H9hLYa5kwr=oy1wYZOow-CMpQTUJhB6kDFW3b_EAbJb7g@mail.gmail.com>
Subject: Re: [PATCH] PCI: mt7621: Sleep a bit after power on the PCIs phy ports
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com, robh@kernel.org,
        kw@linux.com, matthias.bgg@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On Fri, Dec 30, 2022 at 3:23 PM Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
>
> On Fri, Dec 09, 2022 at 08:17:03AM +0100, Sergio Paracuellos wrote:
> > Some devices like ZBT WE1326 and ZBT WF3526-P need to sleep a bit after call
> > to mt7621_pcie_init_port() driver function to get into reliable boots for
> > both warn and hard resets. The needed time for these devices to always detect
>
> s/warn/warm

Sure, I will fix this in v2.

>
> > the ports seems to be from 75 to 100 milliseconds. Hence, properly add an
> > extra 100 milliseconds msleep() call to make also these devices work.
>
> This sounds empirical and it probably is, is it asking too much please
> to add why this delay is *actually* needed ? I think it is important
> to understand that to make sure that in the future developers have a
> clue about why this code was added.
>
> At the very least add a Link: tag to the openwrt discussion.

Most mt7621 boards don't need this extra time after initializing pci
phy related ports registers.
Devices like the two commented here (and some netgear models) seem to
need it to reliably
detect pci ports in both warm and cold resets. I don't have the
devices but the time added by
this patch has been tested on those devices. Since there is no
datasheet or something similar
that says what is this needed in the particular devices I will add the
following link to the commit
message pointing out the openwrt discussion:

https://github.com/openwrt/openwrt/pull/11220

>
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> > Hi Bjorn / Lorenzo,
> >
> > I send previous patch here [0] related with this issue. Since after a bit
> > of testing with these devices by openwrt community [1] we end up that there is
> > no need of increasing PERST_DELAY_MS definition. This is also the reason
> > of not sending a v2 for this but a new patch with the proper solution.
>
> See above, please define "proper". I don't have a problem with defining
> multiple delays as long as we can define with certainty what they are
> there for.

Well, "proper" here was referring to having an always working solution
for these particular devices.

>
> > I preferred to just use the same PERST_DELAY_MS define also for this to
> > not perform extra changes but the needed to the driver.
>
> The problem is not adding more defines, the problem is defining what
> the delay is there for. Reusing the macro may even turn out to be
> misleading if that has nothing to do with PERST - that's what Bjorn
> pointed out already.

Pretty clear, thanks. Will add them and send v2.

>
> > If you prefer me to write new definitions for all the sleep paths you
> > pointed out in [0], just let me know and I will send them also.
>
> Yes, see above.
>
> Thanks,
> Lorenzo

Thanks,
    Sergio Paracuellos

>
> > Thanks in advance for your time.
> >
> > Best regards,
> >     Sergio Paracuellos
> >
> > [0]: https://lore.kernel.org/linux-pci/20221119110837.2419466-1-sergio.paracuellos@gmail.com/T/#u
> > [1]: https://github.com/openwrt/openwrt/pull/11220
> >
> >  drivers/pci/controller/pcie-mt7621.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
> > index 4bd1abf26008..3311ca64b315 100644
> > --- a/drivers/pci/controller/pcie-mt7621.c
> > +++ b/drivers/pci/controller/pcie-mt7621.c
> > @@ -369,6 +369,7 @@ static int mt7621_pcie_init_ports(struct mt7621_pcie *pcie)
> >               }
> >       }
> >
> > +     msleep(PERST_DELAY_MS);
> >       mt7621_pcie_reset_ep_deassert(pcie);
> >
> >       tmp = NULL;
> > --
> > 2.25.1
> >
