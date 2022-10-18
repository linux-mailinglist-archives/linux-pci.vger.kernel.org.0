Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F549602748
	for <lists+linux-pci@lfdr.de>; Tue, 18 Oct 2022 10:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiJRImH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Oct 2022 04:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiJRImF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Oct 2022 04:42:05 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC4D4C631;
        Tue, 18 Oct 2022 01:42:03 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id r17so30448921eja.7;
        Tue, 18 Oct 2022 01:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kJUYQnS+wDJVwg7f1yIoWn6Qu4ZOtG+kFWYfbS0s/NA=;
        b=LESotvyxdCNWutLRLqgFjxC5CqgD8Q76mS9WrlAdiWHV+vtcDAcbaUFIfz37q2O8e1
         Y53rczErEeYDMblVG6SxOTocLvoKUOxuMgvIZSqJ/yn1KSJo0F9FUHGmKwEUfXnRH0bF
         ANcpwFYEE4qrSQ7hJDFICHLbV4FreluuYWAptkcf8gWH65Q0mWajo1jAIrqAzzBvdze3
         d0esP21sAepxqYGqQNMPeQuK3M56fkbxfTifzUspOFBDtJKuDfmSuJIggBzUEymi4lnB
         kY42qd2eOiHFvzLhYYBlZSIvq4NQRlElb+n4397gbCJOzU9eZv6tmMp3o+wcCmT33L2l
         B/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJUYQnS+wDJVwg7f1yIoWn6Qu4ZOtG+kFWYfbS0s/NA=;
        b=mP4Ehok7kaLctQVCjG/cb+LAMSp4RUNh6fULiigkB+4rzn7ZVLP1trh7CeGVC/qy6L
         EHbWDHrGKrbWQBMknJZ00LjZt41CtNHpYXU2Cd8ZHWEx3/+vwh3/kZOKVmeqjPK7rvPi
         0ji4tN4qPS5k8I1BWT/bz7CvpucfhuxTgsfGe/pHbSv4uchOCSzyc4SNakwaNlBAwb0g
         HLFetlSGMBu5ei196zpOQCcg2uSEdb4FeLQi/lEwkHAIm/iz7FMjfpF66Favehq1jvUL
         v3GIL3z0zR4W7YQWUWKZkalE+z7+HLW7hL/mG2BNTZcMlFGSfd8m4Peuamegtk5XQbaM
         +8vA==
X-Gm-Message-State: ACrzQf1DvJ5Da6oIv4Os4CGutrfw/RwHcOntNXVXbveej4wIthjHacdi
        6us7G0UPi276H1kTTJ11qKnuR2XWMPbX12fyXsk=
X-Google-Smtp-Source: AMsMyM7jUGbKxF0ubFnnh/Hy4klouu2/33u0QBOqt6qNKqtpDnelV9XigaA2sEaAFDMoAkR8Oq/khqb2rPYoQdNpOmY=
X-Received: by 2002:a17:907:2cea:b0:78d:eac6:2d09 with SMTP id
 hz10-20020a1709072cea00b0078deac62d09mr1524647ejc.124.1666082521781; Tue, 18
 Oct 2022 01:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20221017142338.1445199-1-christian.gmeiner@gmail.com> <20221017150802.GA3701588@bhelgaas>
In-Reply-To: <20221017150802.GA3701588@bhelgaas>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Tue, 18 Oct 2022 10:41:50 +0200
Message-ID: <CAH9NwWeiaHcWEx9eUQuHZAFzsxz3BhHh4aKUKfRySoJOLxRtQA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Add Bachmann electronic GmbH vendor ID
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Christian GMEINER <Christian.GMEINER@bachmann.info>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Bjorn

>
> On Mon, Oct 17, 2022 at 04:23:37PM +0200, Christian Gmeiner wrote:
> > From: Christian GMEINER <Christian.GMEINER@bachmann.info>
> >
> > Signed-off-by: Christian GMEINER <Christian.GMEINER@bachmann.info>
>
> I tweaked it to shorten the name in the style of other entries and
> sort it by numeric ID.
>

I am fine with that .. was not sure if there needs to be a match of
the used define and
the official "Member company" name:
https://pcisig.com/membership/member-companies?combine=%22Bachmann+electronic%22

> I assume there's a driver that will use this definition.  If so, you
> might want to post this patch (including my ack) along with the driver
> so they get merged together.  But let me know if you need me to take
> it directly.
>

I hope that one driver will see the public light sooner than later but
I have no official time frame.

>
> Also it will be helpful if you can add the item to the PCI ID database
> here: https://pci-ids.ucw.cz/read/PC?restrict=0, which will let lspci
> identify devices with this Vendor ID.
>

Done - thanks.

> Bjorn
>
>
> commit 2fa819fdbb2b ("PCI: Add Bachmann electronic GmbH vendor ID")
> Author: Christian GMEINER <Christian.GMEINER@bachmann.info>
> Date:   Mon Oct 17 16:23:37 2022 +0200
>
>     PCI: Add Bachmann electronic GmbH vendor ID
>
>     Link: https://lore.kernel.org/r/20221017142338.1445199-1-christian.gmeiner@gmail.com
>     Signed-off-by: Christian GMEINER <Christian.GMEINER@bachmann.info>
>     Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index b362d90eb9b0..4cc0e9ecd398 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2,7 +2,7 @@
>  /*
>   *     PCI Class, Vendor and Device IDs
>   *
> - *     Please keep sorted.
> + *     Please keep sorted by numeric ID.
>   *
>   *     Do not add new entries to this file unless the definitions
>   *     are shared between multiple drivers.
> @@ -153,7 +153,7 @@
>
>  #define PCI_CLASS_OTHERS               0xff
>
> -/* Vendors and devices.  Sort key: vendor first, device next. */
> +/* Vendors and devices.  Numeric sort key: vendor first, device next. */
>  #define PCI_VENDOR_ID_PCI_SIG          0x0001
>
>  #define PCI_VENDOR_ID_LOONGSON         0x0014
> @@ -172,6 +172,8 @@
>  #define PCI_DEVICE_ID_BERKOM_A4T               0xffa4
>  #define PCI_DEVICE_ID_BERKOM_SCITEL_QUADRO     0xffa8
>
> +#define PCI_VENDOR_ID_BACHMANN         0x0bae
> +
>  #define PCI_VENDOR_ID_COMPAQ           0x0e11
>  #define PCI_DEVICE_ID_COMPAQ_TOKENRING 0x0508
>  #define PCI_DEVICE_ID_COMPAQ_TACHYON   0xa0fc
>
> > ---
> >  include/linux/pci_ids.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index b362d90eb9b0..b93a52977d85 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -166,6 +166,8 @@
> >
> >  #define PCI_VENDOR_ID_UBIQUITI               0x0777
> >
> > +#define PCI_VENDOR_ID_BACHMANN_ELECTRONIC 0x0bae
> > +
> >  #define PCI_VENDOR_ID_BERKOM                 0x0871
> >  #define PCI_DEVICE_ID_BERKOM_A1T             0xffa1
> >  #define PCI_DEVICE_ID_BERKOM_T_CONCEPT               0xffa2
> > --
> > 2.37.3
> >



-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
