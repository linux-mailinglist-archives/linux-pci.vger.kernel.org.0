Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F205B895E
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 15:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiINNoS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 09:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiINNoL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 09:44:11 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A11E72FD0
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 06:44:10 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id f20-20020a9d7b54000000b006574e21f1b6so1848855oto.5
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 06:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=0ejaHtJmK1pTKMJwOo46vUymgHPZdMfpHAV6DsH/TMU=;
        b=E4BIeg3R3KxB4vs8m/L/Pu88tvq/dHT2vo5h9piTWPK/Kt8GbZjmoI/iM5xnK+GOu4
         rbPaq2qFsjugwxPgG5nyUI3JJTx3bUdFkTVP0W5W4HN7Fxk2JU9QicKROwZkB+LlpbcJ
         t3InAO14VvbdCRPb+OEmKY4tg6zAba9jhmRXa6dE225DKMbIjTmpgmr8IuPszWMW89S6
         LewD9h2LK2dKvRUNv/CpZWoYkYjZdlZerYrt0Uaw/Ul0OXpx8mdjsLQkKdUbqyxYdUCK
         TOCq55AK7EB4Gy70Ki3zcS/39tQZ1ED22dPDTrQsN4o0wsOaYqai5DNoSzilL6DRl6zc
         E/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0ejaHtJmK1pTKMJwOo46vUymgHPZdMfpHAV6DsH/TMU=;
        b=x8cvGn+Ku/ZfNaEijQshzVhDy51P4XvQ8/vMYvXWZwE/01BKbtTzEp0s3i4hw7PBrD
         ftZGweGldx7Mlq4BSLf+B3VsGznvKIWkqPCMGwG1/orLCMDFxgNq0Vfl8jCl28umlWz+
         3syJ9uPIB3vq3+FSuWzoa4Sa2q0TAdJdS9myy0OKH+VhS6J6gsRY+K6Q66g3RHe846Aw
         FtflZ6ZuCx0gh6oPGcqxzZowITx6n1p/vudUZXv/W4A1xYZbi10+Z97ajqa5JxFabpmF
         cBeI836qNkA57WrbQr4YtzwlJw4bjmj910NKcx/k7FUWpjQa2gRfdv5f4onBahNHYq+G
         Apng==
X-Gm-Message-State: ACgBeo3x09dZ1xA/9p+zmkQTMA8AA9XMmFplSR2WeXe33/xQ6ptzVSOl
        +b3qbTsyrMn+aFgydH74CQT3w3WdVQ931Xxd1fg=
X-Google-Smtp-Source: AA6agR700U7geaGD9CLh6djLAoJ4cdFKbv5Amsm6BAhiWdDeS2O5OHW7eUqdxA5+yT1mSZyeVep86SmMaMDCfurhj5E=
X-Received: by 2002:a9d:376:0:b0:655:b4bc:fd6e with SMTP id
 109-20020a9d0376000000b00655b4bcfd6emr10229584otv.233.1663163049690; Wed, 14
 Sep 2022 06:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220913144832.2784012-1-alexander.deucher@amd.com>
 <20220913144832.2784012-2-alexander.deucher@amd.com> <6dd85297-76d0-07c6-bfd2-5795a339f032@amd.com>
In-Reply-To: <6dd85297-76d0-07c6-bfd2-5795a339f032@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 14 Sep 2022 09:43:58 -0400
Message-ID: <CADnq5_M0mVZ1=wpWZD2c+CUrzqFwJmU7aadThcErUPf+tk0KmA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: move nbio ih_doorbell_range() into ih
 code for vega
To:     "Lazar, Lijo" <lijo.lazar@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, helgaas@kernel.org,
        regressions@lists.linux.dev, airlied@linux.ie,
        linux-pci@vger.kernel.org, m.seyfarth@gmail.com,
        tseewald@gmail.com, kai.heng.feng@canonical.com, daniel@ffwll.ch,
        sr@denx.de
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

On Wed, Sep 14, 2022 at 3:05 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
>
>
> On 9/13/2022 8:18 PM, Alex Deucher wrote:
> > This mirrors what we do for other asics and this way we are
> > sure the ih doorbell range is properly initialized.
> >
> > There is a comment about the way doorbells on gfx9 work that
> > requires that they are initialized for other IPs before GFX
> > is initialized.  In this case IH is initialized before GFX,
> > so there should be no issue.
> >
>
> Not sure about the association of patch 1 and 2 with AER as in the
> comment below. I thought the access would go through (PCIE errors may
> not be reported) and the only side effect is doorbell won't be hit/routed.
>
> The comments may not be relevant to patches 1/2, apart from that -

Patches 1 and 2 don't fix the actual issue, but they are prerequisites
for patch 3.  Without patches 1 and 2, patch 3 won't work on all
cards.  Seemed prudent to just mark all 3, but I could clarify that 1
and 2 are just prerequisites.

Thanks,

Alex

>
> Series is:
>         Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>
> Thanks,
> Lijo
>
> > This fixes the Unsupported Request error reported through
> > AER during driver load. The error happens as a write happens
> > to the remap offset before real remapping is done.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=216373
> >
> > The error was unnoticed before and got visible because of the commit
> > referenced below. This doesn't fix anything in the commit below, rather
> > fixes the issue in amdgpu exposed by the commit. The reference is only
> > to associate this commit with below one so that both go together.
> >
> > Fixes: 8795e182b02d ("PCI/portdrv: Don't disable AER reporting in get_port_device_capability()")
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/soc15.c     | 3 ---
> >   drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 4 ++++
> >   drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 4 ++++
> >   3 files changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > index 5188da87428d..e6a4002fa67d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > @@ -1224,9 +1224,6 @@ static void soc15_doorbell_range_init(struct amdgpu_device *adev)
> >                               ring->use_doorbell, ring->doorbell_index,
> >                               adev->doorbell_index.sdma_doorbell_range);
> >               }
> > -
> > -             adev->nbio.funcs->ih_doorbell_range(adev, adev->irq.ih.use_doorbell,
> > -                                             adev->irq.ih.doorbell_index);
> >       }
> >   }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> > index 03b7066471f9..1e83db0c5438 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> > @@ -289,6 +289,10 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
> >               }
> >       }
> >
> > +     if (!amdgpu_sriov_vf(adev))
> > +             adev->nbio.funcs->ih_doorbell_range(adev, adev->irq.ih.use_doorbell,
> > +                                                 adev->irq.ih.doorbell_index);
> > +
> >       pci_set_master(adev->pdev);
> >
> >       /* enable interrupts */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> > index 2022ffbb8dba..59dfca093155 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> > @@ -340,6 +340,10 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
> >               }
> >       }
> >
> > +     if (!amdgpu_sriov_vf(adev))
> > +             adev->nbio.funcs->ih_doorbell_range(adev, adev->irq.ih.use_doorbell,
> > +                                                 adev->irq.ih.doorbell_index);
> > +
> >       pci_set_master(adev->pdev);
> >
> >       /* enable interrupts */
> >
