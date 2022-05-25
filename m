Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEAA534213
	for <lists+linux-pci@lfdr.de>; Wed, 25 May 2022 19:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245630AbiEYRN4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 May 2022 13:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241157AbiEYRNz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 May 2022 13:13:55 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A49A6A045;
        Wed, 25 May 2022 10:13:51 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id v66so25764351oib.3;
        Wed, 25 May 2022 10:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2VhfMHntHxmSu4vdA7es7dFU9dUngjl1nXJAN7GN/r8=;
        b=kZKGzScoXhHCugo7nNQ3aTo4ayafls9LAV0Wuq4fg4ETAYxfvGs92hvMUkGnjxebhO
         kz77QcfMRiAO4DGVdoZL49u3cU9TGlzdNiAOorusfjEs9ZhNnwjA3O0G2/JpAn34XlS6
         biptInj2AoI9zZyx6MeFQ64vGIcCZe1jxDeAqpytkypEfI9e9wEQlBfjW3Af7q9jjT/T
         0z/226gX/uerttVjB9nodKCuRTHgsHRJOkOE1CcKh88VB0t81kAM2FR85Ndn5J7LjTKO
         +U+kTN2FtWpL/8zfwiDDsluNtVMvVVhsOSZlrJjHU5zhQKF19xGWPE9nfWoWaW6ZAimr
         Jogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2VhfMHntHxmSu4vdA7es7dFU9dUngjl1nXJAN7GN/r8=;
        b=H1nk9Y3+ZZKH6t5f134beehUjqBp+osJeVK/UrzbYNqRjsdYpbjmBw1OcIUsArjws8
         WM7eVDXzj0ynVXyX7Ouv6bFqlsVUPUWDIwjg3K4i1Zwac263dnrVD92l6kfedKlzQHR1
         yXgqVEWMACLsS4d0aMrDHViZSnRh5wJMQtWACX0xp1382faa/AZm+/H2dMaf/Mo7//P9
         AA/OG2jqJ0Oa53ZLR++0L0MWLYIVaCZ72Msl+xKCysSYSJowaveiovOBaU+BQa9ywrML
         uhoyk/Q5deDMlyfS3JZkMzysyOgYj0uzAht9qCQHEea07teWsgo1VHntFZO3LmqEFyRz
         hzwA==
X-Gm-Message-State: AOAM532ZKFYXZksVPlyswl0UUbsi8s8a2EX+//L/qS3TyeKR656To8Mo
        4FLd4U/I8kZ7j/MKIcSA/rUT2zxhwMmlxFMn6Xs=
X-Google-Smtp-Source: ABdhPJwAsAcUOElLy2daHM0hVO0+sJA1juSodv5/fTJ9HEOfvONqpQ34BaWqr5s+o3Iy3vKPxYDSPvPVZQ4TBMA1GVY=
X-Received: by 2002:a54:4688:0:b0:325:9a36:ecfe with SMTP id
 k8-20020a544688000000b003259a36ecfemr6136170oic.96.1653498830747; Wed, 25 May
 2022 10:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <CANCKTBvqp7_MSG3aMpp6pmNoPUnYpH0c+8-r7Pzgebuzb4sZPA@mail.gmail.com>
 <20220523221036.GA130515@bhelgaas> <CANCKTBsEjkbdWCB4D22iamPr7YP0qUX=M1dZNNgxkfk1EwjjZQ@mail.gmail.com>
 <20220524235605.rz3cyw7akw3327ip@mraw.org>
In-Reply-To: <20220524235605.rz3cyw7akw3327ip@mraw.org>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Wed, 25 May 2022 13:13:38 -0400
Message-ID: <CANCKTBvieyc-adXFrBrRm5k85Dr700=GmLBvdfLWhbkgN0Pw+Q@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: brcmstb: Fix regression regarding missing PCIe linkup
To:     Cyril Brulebois <kibi@debian.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        James Dutton <james.dutton@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 24, 2022 at 7:56 PM Cyril Brulebois <kibi@debian.org> wrote:
>
> Hi Jim,
>
> Jim Quinlan <jim2101024@gmail.com> (2022-05-24):
> > Yes. One repo did not have this node (Cyril/debina?), one did
> > (https://github.com/raspberrypi/firmware/tree/master/boot).
> > Of course there is nothing wrong with omitting the node; it should
> > have pcie linkup regardless.
>
> I work/debug stuff on Debian systems, but Debian's just shipping what's
> in mainline. Raspberry people maintain their own vendor DTBs.
>
> > Unless you object, I plan on sending you a v2 of my regression fix
> > which will correct the commit message, change the "if (busno == 1)"
> > conditional to only guard the pcie linkup call, and add further
> > comments.
> >
> > I have noted and will also address your other concerns and suggestions
> > in a future patchset as I think it is best that I get my hands on a
> > CM4 board before I submit any more changes.
>
> For the record, I'm still happy to be cc'ed so that I spend time testing
> further patches, be it the short-term regression fix (for inclusion in
> master, but also checking it fixes linux-5.17.y and now linux-5.18.y,
> if stable maintainers would welcome the extra testing), or the future
> patchset.
>
> I can't guarantee you'll have an answer in a few hours like that
> happened during the past few days (during which I prioritized testing
> over anything else so as not to be a blocker in case it could be
> squeezed into v5.18). But I'm still willing to allocate some time to
> make sure the CM4 keeps working, even if you don't get your hands on
> such systems right away.

I really appreciate the help, thank you.  We have ordered a CM4 and I
will be testing on  it prior to sending pullreqs.

Regards,
Jim Quinlan
Broadcom ST


>
>
> Cheers,
> --
> Cyril Brulebois (kibi@debian.org)            <https://debamax.com/>
> D-I release manager -- Release team member -- Freelance Consultant
