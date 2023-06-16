Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C518732551
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jun 2023 04:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241103AbjFPCiL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jun 2023 22:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbjFPCiK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jun 2023 22:38:10 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28D9297C
        for <linux-pci@vger.kernel.org>; Thu, 15 Jun 2023 19:38:08 -0700 (PDT)
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0B3BC3F33C
        for <linux-pci@vger.kernel.org>; Fri, 16 Jun 2023 02:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686883087;
        bh=uIgMGFsFWXeYaOH9c0y1e36aMXOPZcT20Gk+4ok8oCc=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=XSNvs5SCpjGKZ0i3kFrEva4vIpZ6YUt9TS9d9s1I0bOWhwl17seDoTYWyzMD2eLtf
         +NyHYFMpbKYigPZnxLnt0Hgy4+gff9NaVU+NUaAbilQiDl9K7JDskunMUEtCtmtcD6
         34bkgucGN9zlqSSVnpQrs4p+P5HzDa6qfI3+Y8Htgakp8b2OMeRre0Q9Xy4IYUZmgE
         c5S1oiKxdtxdVmanGQCXPr9SEatcmSoyxRqv4jNmkwm758/uBSkKVoQiBudQf2fuJQ
         4+qLmzQCCiz6mC2YTzLuVZAZSiwRizd5eU2O/NujTNf/vDPD+zz7OZ4C0URsKIvby5
         JNpOxm/BA2q6A==
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1a6ba8c60b9so313103fac.2
        for <linux-pci@vger.kernel.org>; Thu, 15 Jun 2023 19:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686883085; x=1689475085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIgMGFsFWXeYaOH9c0y1e36aMXOPZcT20Gk+4ok8oCc=;
        b=Y44VvzRu0yQf6S+cfDTeXQGnRTK9Uy4A3oVFSplNb+FSZOu2UzvvLC13VfMsIEF6/O
         avd6UYW32R2F8Fix4GObDBRmChBfs+FgyfPOE1T+iFfhE+JZfVoV7K4DiwYxOJ8kuxVT
         35hcLjwcU52WP/LoFTAdsvpGZwfb3IBOBG49vXyCyxlcjQdTgdLFGSzDArcSduLBWpHb
         GurXmgGnQWqHQVGllYOD+SGq0tasLx/aDEkjPqkeD+UekPPaQGLR6TnRPMBGgndse5VY
         1AlOUN+9fwm6GttYqJxQ6KlYVtIwS4xWZIkg56yZNGFR+NBzQMJiF77AjK/45k70I7pS
         d+Vg==
X-Gm-Message-State: AC+VfDz3MuaNvLEokmclVuroFdTJcrePgDuSmCI0vTVGYRnFW3rEaQid
        oNpLGBHAa+5ThraSWV4RUycJKQEfT6svOJt0gskD+eLlPaxovgGeEzeAiadK0t5E+wFjBpmCC50
        qVDbzf9tuw46w+8QnIw1EvyzUxslszQ8lTLgO1EMDJZMXBtNfs5DnIw==
X-Received: by 2002:a05:6870:7384:b0:19f:202:4fb9 with SMTP id z4-20020a056870738400b0019f02024fb9mr909994oam.38.1686883085416;
        Thu, 15 Jun 2023 19:38:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4wEsFPW+u0iB+6AyrzEBQjw1i5JXF7jPwaWEWYxvfJw+a2b6HYwbzbGkcMFBB9t2GxNKBekMlbH0ftdV3tjLs=
X-Received: by 2002:a05:6870:7384:b0:19f:202:4fb9 with SMTP id
 z4-20020a056870738400b0019f02024fb9mr909984oam.38.1686883085177; Thu, 15 Jun
 2023 19:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230615070421.1704133-1-kai.heng.feng@canonical.com> <a268fc1c-dd63-cac5-4aec-836a6299ab36@linux.intel.com>
In-Reply-To: <a268fc1c-dd63-cac5-4aec-836a6299ab36@linux.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 16 Jun 2023 10:37:53 +0800
Message-ID: <CAAd53p4pNgijypQKWkf-_81B2bCAOShW_Vw4RGOnzz57hfLa=Q@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM on external PCIe devices
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     bhelgaas@google.com, Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 16, 2023 at 1:07=E2=80=AFAM Sathyanarayanan Kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 6/15/23 12:04 AM, Kai-Heng Feng wrote:
> > When a PCIe device is hotplugged to a Thunderbolt port, ASPM is not
> > enabled for that device. However, when the device is plugged preboot,
> > ASPM is enabled by default.
> >
> > The disparity happens because BIOS doesn't have the ability to program
> > ASPM on hotplugged devices.
> >
> > So enable ASPM by default for external connected PCIe devices so ASPM
> > settings are consitent between preboot and hotplugged.
>
> Why it has to be consistent? Can you add info about what it solves?

It enables ASPM when BIOS can't program LNKCTL.

Enabling ASPM can bring significant power saving for modern CPUs.

It's also quite nice that it can make the BadDLLP caused by I225 device go =
away.

Kai-Heng

>
> >
> > On HP Thunderbolt Dock G4, enable ASPM can also fix BadDLLP error:
> > pcieport 0000:00:1d.0: AER: Corrected error received: 0000:07:04.0
> > pcieport 0000:07:04.0: PCIe Bus Error: severity=3DCorrected, type=3DDat=
a Link Layer, (Receiver ID)
> > pcieport 0000:07:04.0:   device [8086:0b26] error status/mask=3D0000008=
0/00002000
> > pcieport 0000:07:04.0:    [ 7] BadDLLP
> >
> > The root cause is still unclear, but quite likely because the I225 on
> > the dock supports PTM, where ASPM timing is precalculated for the PTM.
> >
> > Cc: Mario Limonciello <mario.limonciello@amd.com>
> > Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217557
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/pci/pcie/aspm.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 66d7514ca111..613b0754c9bb 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -119,7 +119,9 @@ static int policy_to_aspm_state(struct pcie_link_st=
ate *link)
> >               /* Enable Everything */
> >               return ASPM_STATE_ALL;
> >       case POLICY_DEFAULT:
> > -             return link->aspm_default;
> > +             return dev_is_removable(&link->downstream->dev) ?
> > +                     link->aspm_capable :
> > +                     link->aspm_default;
> >       }
> >       return 0;
> >  }
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
