Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133265B3E06
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 19:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiIIRgN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 13:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiIIRgM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 13:36:12 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A905A130870
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 10:36:09 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1278624b7c4so5734683fac.5
        for <linux-pci@vger.kernel.org>; Fri, 09 Sep 2022 10:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=jtXdra4m0dzn0sY7Po7o0MxlYg6uPUCynslJBEbJdfg=;
        b=DULSIiHM3CLlTGF6HhaKwStBJuVL8vvh6nqTqrcDJKHWALG3S/D8Ns+QYQFxtOmE2M
         JisRaxkqtrCC317P0zoua9EhblwDkFo7Ry1ggb08d0dCjWuev7HmniZ6JmxJunZGzDAp
         SMuirov8OvNxUjIFVALdGj6A2PmWc/d9q8ov6wrFW8WEoaWCoH6fp02fpmANSsQcaDMO
         Jnd3aLCWRcVy03UWj1QyRqx6gLkQBLZ4RZ9qPhnGLvesV326HnH0YeGIy78FTRn6LPZb
         NpNMAPR/tPw0ABkv4rh37m7ql1oaWKrVdf44mrnOwS0zVjfqHPBokuIp6BdhEjOVPmzU
         qcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=jtXdra4m0dzn0sY7Po7o0MxlYg6uPUCynslJBEbJdfg=;
        b=xkN6RLh7Ia6l5PFZfZ41zrRd8TOekazC8Y7mLoieTfFG2A1MvjdI0rzSZQqu8tdePP
         OMcIw/zFcR3vbpEGMYyxrRZXSrLS3EY8NHala+XMpnm3SZ3APw6BYEzMkhiaZvHpWAbZ
         CFnyE8vVly2wyuNalmIIyJiPpay2j0wiRZHLyltv1Kg7nUyjm2Cs7sc1KVDvdj1XcEJl
         sumbxDDUtm/q8DilPbmt0+vvLT6M66li2AwT02eOV0jjtOWnvL96WF0ePqK1HiwkI7Pq
         mfjEWqVuou6BOKnV5KNsJGrxAnVDfIKEld/51B68GqfmtuA0uGo3qdzylilQ75WVC+XJ
         MaZQ==
X-Gm-Message-State: ACgBeo3Nmr44LlV3sstimcOAgNCO/r07RTXsKdmKi69fuaZzhoqiQgxp
        0Wf6+oCYEszSi/aU5oXySSiVPEjmxhsAJsf21P4=
X-Google-Smtp-Source: AA6agR5Bb8iV7WnVwt7O6l5mra4DssjIvnX9xf+nJ7xVrR0GjGw/+M9hTc8ERqqRYtPnVqSYaAVJNBPHYO4CMmKL28g=
X-Received: by 2002:a05:6870:1783:b0:12a:f442:504d with SMTP id
 r3-20020a056870178300b0012af442504dmr4265778oae.46.1662744968958; Fri, 09 Sep
 2022 10:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220909164758.5632-1-alexander.deucher@amd.com>
 <20220909164758.5632-2-alexander.deucher@amd.com> <4f9441e7-6ca3-25a6-6dd3-644b211d3fcc@amd.com>
In-Reply-To: <4f9441e7-6ca3-25a6-6dd3-644b211d3fcc@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 9 Sep 2022 13:35:57 -0400
Message-ID: <CADnq5_OKQwXDP-730jCXFCe60AbvzLrDvyr=dVr91awEwLNWjw@mail.gmail.com>
Subject: Re: [PATCH 1/7] drm/amdgpu: move nbio remap_hdp_registers() to gmc9 code
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

On Fri, Sep 9, 2022 at 1:17 PM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
>
>
> On 9/9/2022 10:17 PM, Alex Deucher wrote:
> > This is where it is used, so move it into gmc init so
>
> It's only the *side effect* of GMC IP init process, but that doesn't
> mean these IPs are interlinked. Any IP init process which requires HDP
> flush also would need this. It is not a good idea to couple HDP remap
> with GMC especially when there exists a HDP data path way without
> setting up GMC (MM INDEX/DATA).

We have no need for HDP flush at all without vram, and we only have
access to vram once GMC is initialized so it is sort of a dependency
in that regard.  We also call a bunch of the HDP callbacks in the GMC
code and I think those are sort of the boat.  Also, the whole reason
we are in this situation is because we need to init GMC before all
other HW because all other hardware has a dependency on being able to
access GPU memory.

>
>  From a generic software perspective, I think programming pre-requisite
> for HDP flush need to be standalone and the order needs to be guaranteed
> before any client IPs that make use of it.

In that case patches 5, 6, 7 could be an alternative.

Alex

>
> Thanks,
> Lijo
>
> > that it will always be initialized in the right order.
> > We already do this for other nbio and hdp callbacks so
> > it's consistent with what we do on other IPs.
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
> > ---
> >   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 7 +++++++
> >   drivers/gpu/drm/amd/amdgpu/soc15.c    | 7 -------
> >   2 files changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > index 4603653916f5..3a4b0a475672 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > @@ -1819,6 +1819,13 @@ static int gmc_v9_0_hw_init(void *handle)
> >       bool value;
> >       int i, r;
> >
> > +     /* remap HDP registers to a hole in mmio space,
> > +      * for the purpose of expose those registers
> > +      * to process space
> > +      */
> > +     if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
> > +             adev->nbio.funcs->remap_hdp_registers(adev);
> > +
> >       /* The sequence of these two function calls matters.*/
> >       gmc_v9_0_init_golden_registers(adev);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > index 5188da87428d..39c3c6d65aef 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > @@ -1240,13 +1240,6 @@ static int soc15_common_hw_init(void *handle)
> >       soc15_program_aspm(adev);
> >       /* setup nbio registers */
> >       adev->nbio.funcs->init_registers(adev);
> > -     /* remap HDP registers to a hole in mmio space,
> > -      * for the purpose of expose those registers
> > -      * to process space
> > -      */
> > -     if (adev->nbio.funcs->remap_hdp_registers && !amdgpu_sriov_vf(adev))
> > -             adev->nbio.funcs->remap_hdp_registers(adev);
> > -
> >       /* enable the doorbell aperture */
> >       soc15_enable_doorbell_aperture(adev, true);
> >       /* HW doorbell routing policy: doorbell writing not
> >
