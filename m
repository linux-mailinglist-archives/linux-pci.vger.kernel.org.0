Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A586D5E8A
	for <lists+linux-pci@lfdr.de>; Tue,  4 Apr 2023 13:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjDDLFP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Apr 2023 07:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbjDDLEc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2023 07:04:32 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF5665B2;
        Tue,  4 Apr 2023 04:02:19 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso33540296pjb.2;
        Tue, 04 Apr 2023 04:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680606110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLXYG9UIvfeWF+Q8/NtPlVhVUhnvAmqVeS4iKYz0Uz0=;
        b=pz0HO8RZWzyNSUJ2QkwzWsTUwKeHQ55RS+lRq18OK3hROKy/duTTo2Oi55gEbRHlWZ
         LeA8q8SYJ762pHWz1s8JKvo2UVKhpNcDNiUdtVCV0m/7BTvzV476wIZ/Fu0qFNzhfcqn
         TvY12MFnOJRFLvy1gsbhy6Twb591LymsHKkfb1p7gb7WhEvUOqI0zELpRK21td7cJNNP
         2Ktbemkvjdy8LyVK28EqY50DcqGz5bVUqc72iEyjHRW1gKtXSTIA8jC6HlqlXk7HN9Nl
         S1c7edAdzs6VJRtxSEMTX2pbFNLWtReP/aKiWI7kR6HI6MozBvDQ1+dnnbjKBC7qqcs7
         3Ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680606110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLXYG9UIvfeWF+Q8/NtPlVhVUhnvAmqVeS4iKYz0Uz0=;
        b=XJcnAa93/eb7/VTQJ8JtyiXXPad1E4TQ8EadZmIfLbxjgktMkw1aVp5LGVV4lgoz5b
         4SaU4Uh6oSYpag1Bny1+4ZHC3/UDajAo3PIzUIq7t0bTyYlqUSWuc25fV61r0WfyKTir
         A9V2d+LGbkc9oZrQE0vbpWNKGSuzhjh+dwhAWeLq6FVJxODSbfnLldIBBH6Rnf7pdnVv
         6KcU8VNoMorPSH65CLFWJZZYyHxr+6SxPmIcnr9t+BrQehp5boZHVR0JfQv/kj3pEnlC
         GZoEDykBYoHa+XxmlSTTsqrTfKYz2Di98Djh4vbiyTA0mrxZAQrjQUQ1GOuo1OHuz+uf
         hN0g==
X-Gm-Message-State: AAQBX9fjaf/Gjrp82m+u6PtYc2+hKKn+ANJMD+ANEkLBc19/qNdHVq9m
        kqgAeT+kZgCHaFbSiiBD69HVY774lkceX50hbl8=
X-Google-Smtp-Source: AKy350aHxr3M+JgML644wS5Lz136pHJq5126aDOS+wBR0DZFjTtNeaBbyx5mm3eGDkvMk3XFrvyn/2mgzWXsWibaDTs=
X-Received: by 2002:a17:902:76c3:b0:19f:3cc1:e3cc with SMTP id
 j3-20020a17090276c300b0019f3cc1e3ccmr828639plt.3.1680606110250; Tue, 04 Apr
 2023 04:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAEm4hYXLNP6pcCj5Av35sRG6kCOF0H3+a7VfTtFfGduMgcXJhA@mail.gmail.com>
 <20230403224517.GA3472913@bhelgaas>
In-Reply-To: <20230403224517.GA3472913@bhelgaas>
From:   Xinghui Li <korantwork@gmail.com>
Date:   Tue, 4 Apr 2023 19:02:59 +0800
Message-ID: <CAEm4hYXNUdm_wdK580xsZBUWTycJFsEhjFJ+d57U_QYu6RFWxg@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: vmd: Add the module param to adjust MSI mode
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     nirmal.patel@linux.intel.com, kbusch@kernel.org,
        jonathan.derrick@linux.dev, lpieralisi@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 4, 2023 at 6:45=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> > In the patch I send in last email, We speculate that the VMD
> > Controller aggregate interrupts,
> > making the PCIe port less stressed and improving iops. In this
> > case(lots of 4k random IO), if we enable the VMD MSI
> > remapping, we found the interrupts from VMD Controller's MSI are less
> > and the IOPS is much higher.
>
> Great, that's useful information about why users would want to use
> this parameter.
>
> Obviously the other half is to mention the reasons why they may not be
> able to use it.  If "msi_remap=3Doff" were *always* safe and desirable,
> we would just do that unconditionally and there would be no point in a
> parameter.
>
> > > > I place the "vmd_config_msi_remap_param" that is VMD MSI-X's mode
> > > > param configuring helper front
> > > > "vmd_enable_domain". So, It will not change the logic disabling
> > > > remapping from ee81ee84f873, such as
> > > > "Currently MSI remapping must be enabled in guest passthrough mode"=
.
> > > > So, if the user config the wrong type, it will not work, and they c=
an
> > > > find it by dmesg.
> > >
> > > That's kind of a problem.  I'm not in favor of something failing and
> > > the user having to debug it via dmesg.  That causes user frustration
> > > and problem reports.
> >
> > What about adding a sysfs node for it in VMD PCI bus dir, which allows
> > users to catch VMD's MSI current working mode?
>
> No, a sysfs node is not the answer to this.  If we *can* avoid a
> non-working situation, we should avoid it.  If users see a non-working
> situation, they will rightly complain, and somebody will have to debug
> it.  We don't want that.
emm~
I privately suppose: In the traditional way without module parameters,
this problem also exists. If the user disables remapping in guest os, the V=
MD
driver will force it to remapping mode.
What about I add the additional description in MODULE_PARM_DESC and comment=
?
As for some devices not support disable remapping,  What about changing
the param to disabae_bypass=3D0/1?
And make it clear in the description:
this parameter will only affect the disabling of bypass mode on
devices that support it.
>
> My point is that apparently guest passthrough mode is relevant and
> maybe it should be part of the commit log about how this parameter
> should be used.
You are right~
I will add some clarification on how to configure VMD MSI in the guest.
>
> Bjorn
