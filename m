Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCE74D400E
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 04:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbiCJD6R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Mar 2022 22:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239388AbiCJD54 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Mar 2022 22:57:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED6C12BF7E;
        Wed,  9 Mar 2022 19:56:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48330617DE;
        Thu, 10 Mar 2022 03:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E07C340F5;
        Thu, 10 Mar 2022 03:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646884614;
        bh=3D9GFKu/12WfNEWrnM7P1nIyYXEWetjbz1hTsDrhOxQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eHbKHbvFjjOj2NQYsh+Oi/bCh5BnxYQcjfM05iebPBWOEpRN8ceronXerxJxkkXRz
         xywC4usOhEI4jo1X6/DILpxFggxIE7Vd0fgxXdyuceb7YVz8fGvvam7j8Vp29WhGKs
         yQW/czWqFKS8/pGojUxVKevpD38J0eC7fqDOoaDuBBfj4JRhpIO5SlfGAigFOfN0+g
         0B4TTwUs8W9wyTC24Z+nfBMLecHojw+Sy0xciHafH2mPJU6rqW8RZ6ldrOY1Xgcmff
         W2L+dW7fW/93tvyNirVFkzi8xpCPc2zP7PtKq/6sm9E57aFN6D3wgo1PhE+bmxMa9N
         255v4ycxwA3vQ==
Received: by mail-ua1-f41.google.com with SMTP id a28so1865517uaf.7;
        Wed, 09 Mar 2022 19:56:54 -0800 (PST)
X-Gm-Message-State: AOAM5337DYBkFbJzoESbqFQ5glx0brYsbsebihUpY1ig2FP6jx8HClCQ
        j5Z2VtyzBkH//G+AQcCu0wC0VLT1utRwiB60ABA=
X-Google-Smtp-Source: ABdhPJyMxeleMLVmKri+SIOuq/8cFeORS6+8EgVk1BOoEV8tNUiDlOWyeCIGXoRiRafL3MxxUHhenT3THg5AF8M4uqs=
X-Received: by 2002:ab0:2809:0:b0:341:f4aa:829d with SMTP id
 w9-20020ab02809000000b00341f4aa829dmr1433191uap.42.1646884613619; Wed, 09 Mar
 2022 19:56:53 -0800 (PST)
MIME-Version: 1.0
References: <20220225221523.GA385757@bhelgaas> <20220309162950.GA55262@bhelgaas>
In-Reply-To: <20220309162950.GA55262@bhelgaas>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 10 Mar 2022 11:56:42 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6thUdynSoyt+mm4Q-DCdKKFu_KKv8duKo9T9sdSTMycg@mail.gmail.com>
Message-ID: <CAAhV-H6thUdynSoyt+mm4Q-DCdKKFu_KKv8duKo9T9sdSTMycg@mail.gmail.com>
Subject: Re: [PATCH v9 00/11] vgaarb: Rework default VGA device selection
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I have no objection :)

Huacai

On Thu, Mar 10, 2022 at 12:29 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Feb 25, 2022 at 04:15:23PM -0600, Bjorn Helgaas wrote:
> > On Thu, Feb 24, 2022 at 04:47:42PM -0600, Bjorn Helgaas wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > >
> > > Current default VGA device selection fails in some cases because part of it
> > > is done in the vga_arb_device_init() subsys_initcall, and some arches
> > > enumerate PCI devices in pcibios_init(), which runs *after* that.
> > >
> > > The big change from the v8 posting is that this moves vgaarb.c from
> > > drivers/gpu/vga to drivers/pci because it really has nothing to do with
> > > GPUs or DRM.
> >
> > I provisionally applied this to pci/vga and put it into -next just
> > to get a little runtime on it.
> >
> > But I'd prefer not to unilaterally yank this out of drivers/gpu
> > without a consensus from the GPU folks that this is the right thing to
> > do.
> >
> > Any thoughts?  If it seems OK to you, I think patch 1/11 (the move
> > itself) is all you would need to look at, although of course I would
> > still be grateful for any review and feedback on the rest.
> >
> > After it's in drivers/pci, all the blame for any issues would come my
> > way.
>
> Ping?  This has been in -next since the Feb 28 tree, and I plan to
> ask Linus to include it during the v5.18 merge window (which will
> probably open Mar 13) unless somebody objects.
>
> Bjorn
