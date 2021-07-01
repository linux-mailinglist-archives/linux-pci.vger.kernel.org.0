Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEAA3B8FEF
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 11:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbhGAJqz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 05:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235344AbhGAJqy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jul 2021 05:46:54 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78919C061756;
        Thu,  1 Jul 2021 02:44:24 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mn20-20020a17090b1894b02901707fc074e8so5575343pjb.0;
        Thu, 01 Jul 2021 02:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P4+mFS3UYB5PL7qw9PVS+E8l9U2r7WIe8SRX4lOiQ58=;
        b=CqoKPRTKB4mofvQpl8Zn5T/66nVHkEzQ7ybYIvIT0AIzvPr6Z+0wmxXA4JQ8hxYCHs
         CRXTNMpRBTqCI+U+udsMaGKyzJ52OZcfbcik2i7pyyOUg7oNJi/eFrCALbDdbZdIbwWL
         w0aq1FgsEfqWy29hTuPHJOm5CbOUoO2P/vSP5IxpNZ9qyVfcTSB5v2NgZATEvFUqLnmV
         dtN6xc8w1z5D3+abJid3bQQRU2eTfBvElMtraegqdBW+zi8Vd2Bb7cKKjLK/T0bowVZO
         o3MH7Qh6+3cVWpmm9WAOKQiyllCzr+ni3NEJ0JeQttUUT75A9j/fPlO1bWVR20GXDcYL
         2Emw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P4+mFS3UYB5PL7qw9PVS+E8l9U2r7WIe8SRX4lOiQ58=;
        b=LGDAflzh1d9V/lT50UNHzdm1BDnkmLi/Buzo2Ie6IL1jrMw2ABzOVUO8loRwvkwOIO
         qQHcGuCxDo18WHbAhaz9PTnC1gvNerCfhbs2QB0dONAtKsnw4Rn0fHu3+6gju1bgn1dK
         rsInsw4i2F547V8VSSpGTKJHu6YRJP9l3cWMfdxHG+vBgDTcwUFp3LXxfPN9E+RIaCYm
         OYo7Fu0Q3OTFUcmKwpwbceTKB/B4HxAcnela+l4Idi3Jwm1n3H42pn+tos4HSBwTsKR0
         mVZPgrJDYSScsNCje42GnfikPiy3jtuakwJPjcDzBYZtli3idCC68N7wKKi1vDBF2kKS
         TwaQ==
X-Gm-Message-State: AOAM531gIy3QEZ1tu9aaRZnIu9a3+FSxvUke+LheqdNsJ7j0DuyhiOLJ
        mcjrcBYYjEVC61usq0pb9stbEXZAKxvgnkGF3I/4FyqWLA4=
X-Google-Smtp-Source: ABdhPJxRAQrKeiRdS9kfA2lsliQ6l2D7XgpNn0vVwa/49imMNz39L94+A0XM4r5t1tn4l8QZE3dyvNPPFuKMGB/FNt4=
X-Received: by 2002:a17:902:fe0a:b029:11d:81c9:3adf with SMTP id
 g10-20020a170902fe0ab029011d81c93adfmr36136427plj.0.1625132663923; Thu, 01
 Jul 2021 02:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210617215408.1412409-1-david.e.box@linux.intel.com>
 <20210617215408.1412409-3-david.e.box@linux.intel.com> <YNxENGGctLXmifzj@dell>
 <f590ee871d0527a12b307f1494cb4c8a91c5e3c2.camel@linux.intel.com>
In-Reply-To: <f590ee871d0527a12b307f1494cb4c8a91c5e3c2.camel@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Jul 2021 12:43:46 +0300
Message-ID: <CAHp75VfOU5fcA5-hohcsbyf=v9F5tzWkDp302JNaPt2KDAOqAA@mail.gmail.com>
Subject: Re: [PATCH 2/4] MFD: intel_pmt: Remove OOBMSM device
To:     David Box <david.e.box@linux.intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 1, 2021 at 12:11 AM David E. Box
<david.e.box@linux.intel.com> wrote:
> On Wed, 2021-06-30 at 11:15 +0100, Lee Jones wrote:
> > On Thu, 17 Jun 2021, David E. Box wrote:

...

> > Please consider moving this <whatever this is> out to either
> > drivers/pci or drivers/platform/x86.
>
> None of the cell drivers are in MFD, only the PCI drivers from which
> the cells are created. I understood that these should be in MFD. But
> moving it to drivers/platform/x86 would be fine with me. That keeps the
> code together in the same subsystem. Comment from Hans or Andy?

I'm fine with the PDx86 location, but please consider moving PMT stuff
under drivers/platform/x86/intel/pmt/.

-- 
With Best Regards,
Andy Shevchenko
