Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C67E6E435A
	for <lists+linux-pci@lfdr.de>; Mon, 17 Apr 2023 11:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjDQJNw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 05:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjDQJNv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 05:13:51 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6912681;
        Mon, 17 Apr 2023 02:13:50 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso13666684pjc.1;
        Mon, 17 Apr 2023 02:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681722829; x=1684314829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iICltxFxgZD7R2lQTiHpMVo3mXptmJ3sD33hI5e5uk=;
        b=PEGtYHB8vcNPmJeN/3BWPJUXD34DC3d8nTzcdQ5SU0HXSdviZdZS7jX48UgKcKkkFD
         LywnNNnnqUZRfyErlEk/9kfe9GDI0CG8pfNqclzTLEdewx/kw9001B8axTYZ6Tz1KWJb
         54qzjE5DGVJW2wW6VIusdZwSD7IA7THsZFtx1/Ljx2hObiqESvd6mNhiWKcvOWdguxO6
         VItRc0/cEnIBMNL0H5j7MMIa9ud0eq95uYS3ZVyji1GGH8e6WIGgB+dTUiCG4vnX8pVr
         TfOXiZ/aluHroIjpy7Ucj9K5dO3m8/FI08Fi1G/CppVcAeUfRHl4z/zDcM+c0Pvk/pwF
         wdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681722829; x=1684314829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0iICltxFxgZD7R2lQTiHpMVo3mXptmJ3sD33hI5e5uk=;
        b=N/idBJFssqnB8rCy93k+XKteaybPFJj7qL5lKvvUTIj6nAc42gd+0snoDzkVkI36NE
         z/il8BqCLsre/I2D8baqsAXVsLI3vneiqjSPyVXGjGlZbDWXvICEKAGdHbl6u1aewdBh
         ZXg20cy9+15r4cQRA0PdqbFDA/gIAoJ9CMPrduwSC44a2tOxMcjfOOiF6awJ8ELDJY0y
         3qSLrH9WP6Kx5d2tv6kxCGApgc4CQQDgHQ6zeVJNYAjLGfpRSN8f5WXh774iMURCJP6d
         5FeBSEGCuONkNDsAYcLgJL9FFoo75eAK8VDc7V1sZqA3LR6yKcEEO2dOEnpGhrGCT3wg
         ubnw==
X-Gm-Message-State: AAQBX9e0fKTEw1WOgdud5eHZuU4XIVfbeoDRD4HkSGEKWX6RDrOScOpl
        j1lcQ/JoHAMbkVTpxweMX9rnakak65rUlMOHF/ZWalueJA+V1A==
X-Google-Smtp-Source: AKy350aviDT6EneJ4TKrGKHHcE4yfBcvO2iwK2xSsQtOSQuSp0qiFKcKVDrxymtY16ncCDCODnLUlWqkzy8GgSlnzyI=
X-Received: by 2002:a17:90a:540a:b0:23f:2486:5b53 with SMTP id
 z10-20020a17090a540a00b0023f24865b53mr21424312pjh.17.1681722829480; Mon, 17
 Apr 2023 02:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAEm4hYXLNP6pcCj5Av35sRG6kCOF0H3+a7VfTtFfGduMgcXJhA@mail.gmail.com>
 <20230403224517.GA3472913@bhelgaas> <CAEm4hYXNUdm_wdK580xsZBUWTycJFsEhjFJ+d57U_QYu6RFWxg@mail.gmail.com>
In-Reply-To: <CAEm4hYXNUdm_wdK580xsZBUWTycJFsEhjFJ+d57U_QYu6RFWxg@mail.gmail.com>
From:   Xinghui Li <korantwork@gmail.com>
Date:   Mon, 17 Apr 2023 17:15:00 +0800
Message-ID: <CAEm4hYU4Z+LzhC8PT3OTePMeYjDa-QZEfXMkZqODnSY5i+_hrQ@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: vmd: Add the module param to adjust MSI mode
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     nirmal.patel@linux.intel.com, kbusch@kernel.org,
        jonathan.derrick@linux.dev, lpieralisi@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Friendly ping~

On Tue, Apr 4, 2023 at 7:02=E2=80=AFPM Xinghui Li <korantwork@gmail.com> wr=
ote:
>
> On Tue, Apr 4, 2023 at 6:45=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
> >
> > > In the patch I send in last email, We speculate that the VMD
> > > Controller aggregate interrupts,
> > > making the PCIe port less stressed and improving iops. In this
> > > case(lots of 4k random IO), if we enable the VMD MSI
> > > remapping, we found the interrupts from VMD Controller's MSI are less
> > > and the IOPS is much higher.
> >
> > Great, that's useful information about why users would want to use
> > this parameter.
> >
> > Obviously the other half is to mention the reasons why they may not be
> > able to use it.  If "msi_remap=3Doff" were *always* safe and desirable,
> > we would just do that unconditionally and there would be no point in a
> > parameter.
> >
> > > > > I place the "vmd_config_msi_remap_param" that is VMD MSI-X's mode
> > > > > param configuring helper front
> > > > > "vmd_enable_domain". So, It will not change the logic disabling
> > > > > remapping from ee81ee84f873, such as
> > > > > "Currently MSI remapping must be enabled in guest passthrough mod=
e".
> > > > > So, if the user config the wrong type, it will not work, and they=
 can
> > > > > find it by dmesg.
> > > >
> > > > That's kind of a problem.  I'm not in favor of something failing an=
d
> > > > the user having to debug it via dmesg.  That causes user frustratio=
n
> > > > and problem reports.
> > >
> > > What about adding a sysfs node for it in VMD PCI bus dir, which allow=
s
> > > users to catch VMD's MSI current working mode?
> >
> > No, a sysfs node is not the answer to this.  If we *can* avoid a
> > non-working situation, we should avoid it.  If users see a non-working
> > situation, they will rightly complain, and somebody will have to debug
> > it.  We don't want that.
> emm~
> I privately suppose: In the traditional way without module parameters,
> this problem also exists. If the user disables remapping in guest os, the=
 VMD
> driver will force it to remapping mode.
> What about I add the additional description in MODULE_PARM_DESC and comme=
nt?
> As for some devices not support disable remapping,  What about changing
> the param to disabae_bypass=3D0/1?
> And make it clear in the description:
> this parameter will only affect the disabling of bypass mode on
> devices that support it.
> >
> > My point is that apparently guest passthrough mode is relevant and
> > maybe it should be part of the commit log about how this parameter
> > should be used.
> You are right~
> I will add some clarification on how to configure VMD MSI in the guest.
> >
> > Bjorn
