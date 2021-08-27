Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160213F938D
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 06:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhH0EZn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Aug 2021 00:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhH0EZn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Aug 2021 00:25:43 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2414BC061757
        for <linux-pci@vger.kernel.org>; Thu, 26 Aug 2021 21:24:55 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id m19so3636979vsj.10
        for <linux-pci@vger.kernel.org>; Thu, 26 Aug 2021 21:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o2ac3WU5PKyDrLNw8DzbWnQu4UdRxnLFK3Sf2SVuZjc=;
        b=ZJpjJB8hCd6jjLdHPQm0LFyuowgsoGG7LOtJzv/jHtQ6PvsHvDjrvXHMLZinBkqmor
         xwwaGMxm+S8L4dCwz2Dk0Ms2PBpbiOq9CvyPEsFQ8v53+hwGgunJCLwVAVTQ4z3shH9Q
         Ab2gqowA01OUSXqa29MK5l/PfuJURjgWnwoWSZ5BmYNMHub8yjRSyOGpQ5QdtcyIH1MP
         T6oBEH8J1/X8OASLZcjfqrILi1J6dl/Yqmh6WQGKD1C/GPXbjFEmi3gbM09mm1+2wbOn
         yjMI/x3DlvL6ANddhwh9wDcuhX6FjkfJLmlJuiAynD2NeeUX6cyo9vaLkxtvMO+3DRV5
         SWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o2ac3WU5PKyDrLNw8DzbWnQu4UdRxnLFK3Sf2SVuZjc=;
        b=YZmMlXbd89MhKdeQKfuPTGJGW4yFqSu3RPxqdJ6a4OGUasgG6UDelBorDhYxVH3TsL
         ZWRCt0IpodI6826oWDdAJisiff9AOOQXmzbUNog/azCxkQIbfoD3WPw4YL+TGzDZL620
         w+AHPIlbWs3sErWFCayrwejEchgYQ1xqsDRnkt67Cu58hNrawXzgDy4xtw+YaSBwX2VX
         Z4dE3fUUEP9ifpvs9UT5mf2x8iKldqxv16wrtfn+VbNjCpnnb0J0tzTY8Yn0XeiGZF+L
         vJLPH3QhIPU8Ef8l4Zt9Qp5zKhabNxpYA4cdIH4xFFhIlFuJm0k8A4W8l+4AoDEdPReG
         qfbA==
X-Gm-Message-State: AOAM532OsrmxGKNNssEGD63Etgz8gxQqAEwhibOktwOckGuwfJKTB1rS
        KnDZI9WcNxZNRE6BI+BXMesGy8qQmpBfJH1j+xY=
X-Google-Smtp-Source: ABdhPJxtyZ6SMAyzmkJxzuz5PxWwGUf9q/Y3aMHbXeelZOxgLf+T2DmyyCmrgp+MZ9NtAitoZlgUzCbJVExCWcdB+bI=
X-Received: by 2002:a67:ef92:: with SMTP id r18mr5441407vsp.53.1630038294327;
 Thu, 26 Aug 2021 21:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210820100832.663931-1-chenhuacai@loongson.cn> <20210825201704.GA3600046@bjorn-Precision-5520>
In-Reply-To: <20210825201704.GA3600046@bjorn-Precision-5520>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 27 Aug 2021 12:24:39 +0800
Message-ID: <CAAhV-H6NM2gdcaOFPgmV_fLcm=x8BSz28Gg2-hqZBRxpcVBOjw@mail.gmail.com>
Subject: Re: [PATCH V3 0/9] PCI/VGA: Rework default VGA device selection
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,

On Thu, Aug 26, 2021 at 4:17 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Aug 20, 2021 at 06:08:23PM +0800, Huacai Chen wrote:
> > My original work is at [1].
> >
> > Bjorn do some rework and extension in V2. It moves the VGA arbiter to
> > the PCI subsystem, fixes a few nits, and breaks a few pieces to make
> > the main patch a little smaller.
> >
> > V3 rewrite the commit log of the last patch (which is also summarized
> > by Bjorn).
> >
> > All comments welcome!
> >
> > [1] https://lore.kernel.org/dri-devel/20210705100503.1120643-1-chenhuacai@loongson.cn/
> >
> > Bjorn Helgaas (4):
> >   PCI/VGA: Move vgaarb to drivers/pci
> >   PCI/VGA: Replace full MIT license text with SPDX identifier
> >   PCI/VGA: Use unsigned format string to print lock counts
> >   PCI/VGA: Remove empty vga_arb_device_card_gone()
> >
> > Huacai Chen (5):
> >   PCI/VGA: Move vga_arb_integrated_gpu() earlier in file
> >   PCI/VGA: Prefer vga_default_device()
> >   PCI/VGA: Split out vga_arb_update_default_device()
> >   PCI/VGA: Log bridge control messages when adding devices
> >   PCI/VGA: Rework default VGA device selection
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/gpu/vga/Kconfig           |  19 ---
> >  drivers/gpu/vga/Makefile          |   1 -
> >  drivers/pci/Kconfig               |  19 +++
> >  drivers/pci/Makefile              |   1 +
> >  drivers/{gpu/vga => pci}/vgaarb.c | 269 ++++++++++++------------------
> >  5 files changed, 126 insertions(+), 183 deletions(-)
> >  rename drivers/{gpu/vga => pci}/vgaarb.c (90%)
>
> I'm open to merging this series but the v5.15 merge window will
> probably open on Sunday, and that's too close for a series of this
> size.
>
> Moreover, the critical change is still buried in the middle of the
> last patch ("PCI/VGA: Rework default VGA device selection").  There's
> way too much going on in that single patch.
>
> As I mentioned in [1], I think you can make a 1- or 2-line patch that
> will fix your problem, and I think *that's* the first thing we should
> do.
>
> That would be a patch against drivers/gpu/vga/vgaarb.c, so it would be
> up to the DRM folks to decide whether to take it for v5.15, but at
> least it would be small enough to review it easily.
OK, let me try.

Huacai
>
> Bjorn
>
> [1] https://lore.kernel.org/r/20210724001043.GA448782@bjorn-Precision-5520
