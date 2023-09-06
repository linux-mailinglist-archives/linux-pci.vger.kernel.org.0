Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974BD7940F8
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 18:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjIFQBW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 12:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242810AbjIFQBV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 12:01:21 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302271995;
        Wed,  6 Sep 2023 09:01:06 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1c8e9d75ce1so2286957fac.3;
        Wed, 06 Sep 2023 09:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694016065; x=1694620865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6LWx34t6RPAjjhmdGIBM9ahXBcms5DV7AzJj+GPzQA=;
        b=ONqqDStry78+CyAPJLvKA1iL7NeZkxN1UkezYBEI2EEVSMq2swzic9P11kbUTQDVkU
         iUJ+/c0IF1em9CScixSwkXmfQEw2ym+r5SYbeF/myaPoc1uc1hSESdbk9VDn0zpN42D4
         GgX8zMdR/siLRt+mOzJzScvAS8lEs6RVAQUUWJQsfMKVvp3PM1X15+O0/WSKIKIsOwkC
         PykAg2bQksLbbFJzbnvNvZyCNe0bsPS6BbeFu5rjAvVBIRNG7M/rzLpqsnNmnC8+zt3b
         +md/A4oxDEQ33/ZNgLA58RNQx37EPG1WX8Cv/Q9sedp8w2Y3yhppuhyYPNZWBcyC+5Be
         ScKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694016065; x=1694620865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6LWx34t6RPAjjhmdGIBM9ahXBcms5DV7AzJj+GPzQA=;
        b=l2KFVcE5WA1HSF3o+Rx4FcOqH2b7DSUFlmvRH2zabYO9lSx+7Z1MUjjq7pkv/oVvUD
         aF3RKj7AcDayd9441CeLtYgUK2jd6RplMjgzFsx9muAB9TBwZV7rPikYAQ5rL/4ibwF2
         vxIVYi0UafG9KmlNnihYUHPbBGsj6LHPVQCUw5eC8DzvXastdb3oWxfklY3sssBqgc7R
         3+HAx96y7Qh03zNc1AeU5uu5ZxfQRKsYmUjsZrz1P+5qfjI2/5+y/1lvy2a/2QSS4w1D
         sDtmyFaa/Rsw1xNWBxrsaJss0bV3YTVARlnZ2OjE80cTKdNAK25akyBrJGkV5ebeQ84b
         Vetg==
X-Gm-Message-State: AOJu0YyGfwAIZ2JET9xRCTaxDdeJd/hD2Xv6/Fc7ltOiPtIlHkbhkDqH
        zfMqaQjgcyEaTLcX5xheOJTZTLXrYKAcDrcfZwI=
X-Google-Smtp-Source: AGHT+IF+5jWUuhtjXrUwCDU2vqm+oD8PcmuCjMCceh985Ms+NPGpiBmtRG8mj/pojUh/Gya7OusMLGeBbVHAX3QI5GA=
X-Received: by 2002:a05:6870:d79f:b0:1bc:26d:6664 with SMTP id
 bd31-20020a056870d79f00b001bc026d6664mr17177800oab.16.1694016065112; Wed, 06
 Sep 2023 09:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230904195724.633404-1-sui.jingfeng@linux.dev>
 <20230904195724.633404-4-sui.jingfeng@linux.dev> <d3e6a9ce-1c7a-8e44-3127-413cd471a8e9@amd.com>
 <40f32814-ca87-6e29-0e10-4b4463a2920d@loongson.cn>
In-Reply-To: <40f32814-ca87-6e29-0e10-4b4463a2920d@loongson.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 6 Sep 2023 12:00:53 -0400
Message-ID: <CADnq5_OYPha5cGF+tSj4fvSmf-6tObzNSe2__nG-SbjX6v_2vw@mail.gmail.com>
Subject: Re: [RFC,drm-misc-next v4 3/9] drm/radeon: Implement .be_primary() callback
To:     suijingfeng <suijingfeng@loongson.cn>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Sui Jingfeng <sui.jingfeng@linux.dev>,
        Bjorn Helgaas <bhelgaas@google.com>,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 5, 2023 at 1:25=E2=80=AFPM suijingfeng <suijingfeng@loongson.cn=
> wrote:
>
> Hi,
>
>
> On 2023/9/5 13:50, Christian K=C3=B6nig wrote:
> > Am 04.09.23 um 21:57 schrieb Sui Jingfeng:
> >> From: Sui Jingfeng <suijingfeng@loongson.cn>
> >>
> >> On a machine with multiple GPUs, a Linux user has no control over
> >> which one
> >> is primary at boot time.
> >
> > Question is why is that useful? Should we give users the ability to
> > control that?
> >
> > I don't see an use case for this.
> >
>
> On a specific machine with multiple GPUs mounted, only the
> primary graphics get POST-ed (initialized) by the firmware.
> Therefore the DRM drivers for the rest video cards have to
> work without the prerequisite setups done by firmware, This
> is called as POST.

I think that should be regarded as a bug in the driver that should be
fixed and this would not help with that case.  If a driver can't
initialize a device without aid from the pre-OS environment, that
should be fixed in the driver.  This solution also doesn't fix which
device is selected as the primary by the pre-OS environment.  That can
only be fixed in the pre-OS environment code.

>
> One of the use cases is to test if a specific DRM driver
> would works properly, under the circumstance of not being
> POST-ed, The ast drm driver is the first one which refused
> to work if not being POST-ed by the firmware.
>
> Before apply this series, I was unable make drm/ast as the
> primary video card easily. The problem is that on a multiple
> video card configuration, the monitor connected with my
> AST2400 card not light up. While confusing, a naive programmer
> may suspect the PRIME is not working.
>
> After applied this series and passing ast.modeset=3D10 on the
> kernel cmd line, I found that the monitor connected with my
> ast2400 video card still black, It doesn't display and It
> doesn't show image to me.

The problem with adding modeset=3D10 is that it only helps when you have
one GPU driven by that driver in the system.  If you have multiple
GPUs driven by that driver, which one would that apply to?  E.g., what
if you have 2 AMD GPUs in the system.

>
> While in the process of study drm/ast, I know that drm/ast
> driver has the POST code shipped, See the ast_post_gpu() function.
> Then, I was wondering why this function doesn't works.
>
> After a short-time (hasty) debugging, I found that the ast_post_gpu()
> function didn't get run. Because it have something to do with the
> ast->config_mode. Without thinking too much, I hardcoded the
> ast->config_mode as ast_use_p2a, the key point is to force the
> ast_post_gpu() function to run.
>
>
> ```
>
> --- a/drivers/gpu/drm/ast/ast_main.c
> +++ b/drivers/gpu/drm/ast/ast_main.c
> @@ -132,6 +132,8 @@ static int ast_device_config_init(struct ast_device
> *ast)
>                  }
>          }
>
> +       ast->config_mode =3D ast_use_p2a;
> +
>          switch (ast->config_mode) {
>          case ast_use_defaults:
>                  drm_info(dev, "Using default configuration\n");
>
> ```
>
> Then, the monitor light up, it display the Ubuntu greeter to me. Therefor=
e
> my patch is useful, at least for the Linux drm driver tester and develope=
r.
> It allow programmers to test the specific part of a specific driver witho=
ut
> changing a line of the source code and without the need of sudo authority=
.
>
> It improves the efficiency of the testing and patch verification. I know
> the PrimaryGPU option of Xorg conf, but this approach will remember the
> setup have been made, you need modify it with root authority each time
> you want to switch the primary. But on the process of rapid developing
> and/or testing for multiple video drivers, with only one computer hardwar=
e
> resource available. What we really want is a one-shot command, as provide=
d
> by this series.  So, this is the first use case.
>
>
> The second use case is that sometime the firmware is not reliable.
> While there are thousands of ARM64, PowerPC and Mips servers machine,
> Most of them don't have a good UEFI firmware support. I haven't test the
> drm/amdgpu and drm/radeon at my ARM64 server yet. Because this ARM64
> server always use the platform(BMC) integrated display controller as prim=
ary.
> The UEFI firmware of it does not provide options menu to tune.
> So, for the first time, the discrete card because useless, despite more p=
owerful.
> I will take time to carry on the testing, so I will be able to tell more
> in the future.
>
>
> Even on X86, when select the PEG as primary on the UEFI BIOS menu.
> There is no way to tell the bios which one of my three
> discrete video be the primary. Not to mention some old UEFI
> firmware, which doesn't provide a setting at all.
> While the benefit of my approach is the flexibility.
> Yes the i915, amdgpu and radeon are good quality,
> but there may have programmers want to try nouveau.
>
>
> The third use case is that VGAARB is also not reliable, It will
> select a wrong device as primary. Especially on Arm64, Loongarch
> and mips arch etc. And the X server will use this wrong device
> as primary and completely crash there. Either because of lacking
> a driver or the driver has a bug which can not bear the graphic
> environment up. VGAARB is firmware dependent.
> My patch provide a temporary method to rescue.
>

It sounds like we need a general purpose "primary" selector.  I think
it's sort of orthogonal to VGA.  VGAARB is just for managing VGA
routing on PCI.  It's not really directly related to which GPU you
want to be the primary when the OS loads.  Maybe some new kernel
parameter, E.g., primary_display=3D<string> where the string would be
the specific device you wanted to be the primary,  E.g., you could use
the PCI BDF on PCI devices, primary_display=3D0000:0a:00.0 or some other
device string for non-PCI devices.

Alex
