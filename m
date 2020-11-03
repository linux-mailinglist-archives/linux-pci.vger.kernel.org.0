Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038982A3EF4
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 09:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgKCIc3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 03:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgKCIc3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Nov 2020 03:32:29 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD68C0613D1;
        Tue,  3 Nov 2020 00:32:29 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 72so6859416pfv.7;
        Tue, 03 Nov 2020 00:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CajaA+v1opCtmvDjoNX292E8WdhrMvcRDpxGQcvWnPI=;
        b=S8ec6w5SPhCPk4Qz+YRdWlgi4lspAId48wEp0KbOUypFYtzwzt27sY94L6ggufui0P
         61tLZdCmvxXTqdH2pnxY0tbNafUw0C/I8bS2/9+OQCxN1me5uMdz7h6KWuddCFO8IgWT
         Ml2jsyjMCxFDCDItFlAV8MQRxvA/j9x5qQ1YeCOEyEfR67XxqydDldKEiaFd7TR0x5Bj
         tRGz26tBsDpBe5kZZYqGBFSX0S79LmUHO9Qg4XnUiRqM7Sl+mTPxkkCY29PhvuhmCO7U
         OZtS3NgZ+7WqBR2zTZVkWtqoUDswqTKwQ0trcEFFyauL28HCLwjXZQ0h6Q2Kko0rHKuX
         3vjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CajaA+v1opCtmvDjoNX292E8WdhrMvcRDpxGQcvWnPI=;
        b=D9YMMPE77pX0Vxmj60xYlL5DLPoGr9ipfOpygsett9o9qrhbFZsbVD/daVklbTOz62
         C3R8dUjzerO8JjyHKFwO02CRAT5/EuI8TYJehnC1+jUchgfNjZqjIcgwZfmP+ShX0I1J
         5f8Ljfb3MRoEBlNCn4RVn6SWCoyr5Mvp2Q37IAtKFDWw8LOnFpPM1soKzn6m+rXFEDJd
         geLGS/8S8IhiPeTTf/obPnkmlCa3trEIcQx/1akQaCHL/JnZUymWvGzMWNPX6HA/A6m1
         n8QCK0RAjyMIydpJRiAeKcItlNByeLDaIhRBntkoxOD5Ivwujn//tchjoifkeOts539B
         8lYg==
X-Gm-Message-State: AOAM531iNC7KZzSeroDCYGX6F6BhROhslQXY03GPxPHjmHo2265mgUIr
        j86tR37oatCeLEaxMiHEMRm9jVbt1xtc8zy/cFg=
X-Google-Smtp-Source: ABdhPJzzR9g97VUc/ZZonkI6kxoxjWUKMEUAqUDJkJQzd+W4yEVweAD0XYGxtn5VmG6dwMPgVGEWs9yv9lNCHsw5rQ0=
X-Received: by 2002:a63:4511:: with SMTP id s17mr8817512pga.4.1604392349319;
 Tue, 03 Nov 2020 00:32:29 -0800 (PST)
MIME-Version: 1.0
References: <20201102210025.53520-1-andriy.shevchenko@linux.intel.com> <20201103064829.GB75930@kroah.com>
In-Reply-To: <20201103064829.GB75930@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 3 Nov 2020 10:32:13 +0200
Message-ID: <CAHp75VfAOgCHWFwimhzw93DNMp4Bceq1SFFJnQYi-yDYEr43mA@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] resource: introduce union(), intersection() API
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 3, 2020 at 8:53 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Nov 02, 2020 at 11:00:19PM +0200, Andy Shevchenko wrote:
> > Some users may want to use resource library to manage their own resources,
> > besides existing users that open code union() and intersection()
> > implementations.
> >
> > Provide a generic API for wider use.
> >
> > Changelog v4:
> > - added Rb tag (Rafael)
> > - Cc'ed to LKML and Greg (Rafael)
>
> Didn't we have some tests for this code somewhere?  Have you added tests
> for the new functions you have added?  If not, can you do that so that
> we "know" these work properly?

Sure, I'll add for v5. Thanks for the hint!

-- 
With Best Regards,
Andy Shevchenko
