Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23B65B2063
	for <lists+linux-pci@lfdr.de>; Thu,  8 Sep 2022 16:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbiIHOVY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Sep 2022 10:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiIHOVY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2022 10:21:24 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F6CE6239
        for <linux-pci@vger.kernel.org>; Thu,  8 Sep 2022 07:21:22 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1278a61bd57so26198854fac.7
        for <linux-pci@vger.kernel.org>; Thu, 08 Sep 2022 07:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Qudv4PRxQU2ec00vhzza+IJ/8DXkVM9NA8dDvO9+d8s=;
        b=Z6gWPbeubeUCBKbACAJxowa+zqM89pGQ4YV5++Upgcd0H5rkBGDOlUbDtb7SQceb+f
         KJjtIg57+pX/OHyjF1h5+zGiaE9ncp3OXUI4oTYb7TZruWuIHEtcBZ0W06n91jd4+S7M
         sxkqHad9uizYNTWVxaNRmHYOdUrfYGTwGjBrw7xtV9Mq6WScsU3ULbUeZqPeHm5nKLt2
         6GsFTH4mJX+/s0iSht+Pxc2w2nimCsstYnoYoe/HEe0nA0rw54Nq0kyERCyhSoTUrdMb
         8SqB+fJd7zd57X9O8M8CebU4wECl2+Zv5rkj0lwYZmAN20InyAvXyjLjKGnHH55CX/hF
         Gabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Qudv4PRxQU2ec00vhzza+IJ/8DXkVM9NA8dDvO9+d8s=;
        b=LRBwP0JldjyUqpPYAFpTcMmKtk3FYQVSxFFsYJIkcRCbmG5ObqVN26K2JQwyYD+em4
         JjRqWxYInPnfeZrwJ7CzuuuNpaNGxcOuaTo4Svjd9DwWRJ+EyIiOWIwBd4n80+vnFJ3n
         4bqHZXKF3Azctm9B+0+9cj2lrv2vibf5zvCtFjr6+EAqLt1n05RBd00Bu9Vty/ZSi0ZS
         WCIUv6f3eEdjz9E5tSJwzMZtD+K/K+XOWORJIrg+bBGSIph39UDj+KGyfr/YjaEbbFNg
         EIXva8DT85Wed78+rBJY6/lxEZSL4wYxw6oTS6BcZTrajJZhyAK6AoJbzkp/bEF77Kjc
         fREQ==
X-Gm-Message-State: ACgBeo0pAjFmqIQexxlJMQO6hbC7RhMPUJBSHy+PxuMFkE8a5ZayJ7fw
        qItFhnXBKuFRMzOOw5VA22cQbZYIvWVMVAhrmpw=
X-Google-Smtp-Source: AA6agR6mNyIvQyJTxriUckKrkO9BLzLVrO6FrPkAZTJMW5L+owjRZFNzihkcshhUwW2jBBoJwLMyu0Pwr0i8mdVXtsg=
X-Received: by 2002:a05:6808:2187:b0:344:eccd:3fc5 with SMTP id
 be7-20020a056808218700b00344eccd3fc5mr1708882oib.46.1662646882178; Thu, 08
 Sep 2022 07:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220908040821.5786-1-alexander.deucher@amd.com> <4148adb1-2181-efa4-672c-defb45abe0e8@amd.com>
In-Reply-To: <4148adb1-2181-efa4-672c-defb45abe0e8@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 8 Sep 2022 10:21:10 -0400
Message-ID: <CADnq5_Pc0MvqWHMOBd3=z72TF4HiwWwf3g6dHA6KrGbAUe4W9w@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: make sure to init common IP before gmc
To:     "Lazar, Lijo" <lijo.lazar@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, helgaas@kernel.org,
        regressions@lists.linux.dev, airlied@linux.ie,
        linux-pci@vger.kernel.org, tseewald@gmail.com,
        kai.heng.feng@canonical.com, daniel@ffwll.ch, sr@denx.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 8, 2022 at 1:11 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
>
>
> On 9/8/2022 9:38 AM, Alex Deucher wrote:
> > Common is mainly golden register setting and HDP register
> > remapping, it shouldn't allocate any GPU memory.  Make sure
> > common happens before gmc so that the HDP registers are
> > remapped before gmc attempts to access them.
> >
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
>
> Series is:
>         Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>


@tseewald@gmail.com it would be good if you could verify that this
patch fixes the issue for you as well.

Thanks,

Alex

>
> Thanks,
> Lijo
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 +++++++++++---
> >   1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 899564ea8b4b..4da85ce9e3b1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -2375,8 +2375,16 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
> >               }
> >               adev->ip_blocks[i].status.sw = true;
> >
> > -             /* need to do gmc hw init early so we can allocate gpu mem */
> > -             if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC) {
> > +             if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON) {
> > +                     /* need to do common hw init early so everything is set up for gmc */
> > +                     r = adev->ip_blocks[i].version->funcs->hw_init((void *)adev);
> > +                     if (r) {
> > +                             DRM_ERROR("hw_init %d failed %d\n", i, r);
> > +                             goto init_failed;
> > +                     }
> > +                     adev->ip_blocks[i].status.hw = true;
> > +             } else if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC) {
> > +                     /* need to do gmc hw init early so we can allocate gpu mem */
> >                       /* Try to reserve bad pages early */
> >                       if (amdgpu_sriov_vf(adev))
> >                               amdgpu_virt_exchange_data(adev);
> > @@ -3062,8 +3070,8 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
> >       int i, r;
> >
> >       static enum amd_ip_block_type ip_order[] = {
> > -             AMD_IP_BLOCK_TYPE_GMC,
> >               AMD_IP_BLOCK_TYPE_COMMON,
> > +             AMD_IP_BLOCK_TYPE_GMC,
> >               AMD_IP_BLOCK_TYPE_PSP,
> >               AMD_IP_BLOCK_TYPE_IH,
> >       };
> >
