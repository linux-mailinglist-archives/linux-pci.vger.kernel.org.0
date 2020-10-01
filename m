Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EC428072B
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 20:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732274AbgJASrK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 14:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbgJASrK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 14:47:10 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A88C0613D0;
        Thu,  1 Oct 2020 11:47:09 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 5so4726557pgf.5;
        Thu, 01 Oct 2020 11:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W+V9kc/cF5/eFjoqfVBQmYxrdK3wlwOgNWJHzA5yG2U=;
        b=lNTxdzoNP91oV0DRBEMau+8CeCVPVuQlysV8yGcYW2jal2ikClNoxvM+f6sgGg5oZa
         2+UlnQRmdLvio2gjjKui/3YV/pr/QWUUR6Xx83LT40hFl9CA1mweE134yJjQn62N8PWo
         Lr1hOkL0bTareKZOwilRDQTcfQO1Dw3PXOe9dgBDdeijiZhpdjCHuKfPVEg6/q1LAGPX
         bsR3WZo9nFRkK1ojaVPrj0mm1+eCJJscxIU1fh55Kaz5ClyIjLDqqs8cyDphSspOBq4o
         IlYBN8dTGVqAcTNohEGjaBBgQINeMrIRXt7Q1X1iOE3t2EcfHiCNK2AeIguFi5qiLVoy
         4WSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W+V9kc/cF5/eFjoqfVBQmYxrdK3wlwOgNWJHzA5yG2U=;
        b=cvjj9bHPAg8Q0ArqgIfBguwVCKwRVNh0F2gg/xwxZTe5hZ8nF7i7jZ1wCh8TOLBNKp
         3ue4cBQwjS1tXhGK63MDkqlyl//tBYYrrV0FwEp+Ekjno7HjerZ88pN7wAjHx4ZHQ0gx
         TkDb21sYbW5rP+3BWhOv5VCkyU219zaL+f0u6htdkzEsFlt1NALcY61g+kBpTkYlW+dU
         XyIGA3TDO+fToZEV9hbOyHIC0Z+D5o6XTohtXqX9mqTyOjWVSxNbmX4nFvK3GYaFQO4a
         +aKge4GHkJyfVNsi7fjvUMpBBt4WdPIE3ly8VPBd8Mcm0pdFNOJJBrWmMqYwLAvQZxg4
         nnKA==
X-Gm-Message-State: AOAM530rpodQp5y6Mf2g5FffG45N7u2dmMl1EDBpvghIlr+4XfoXZeSs
        XHuezpVwHgTCJW1eyogwU7HxHJdoNnNTwdb+kCA=
X-Google-Smtp-Source: ABdhPJxokxjmOFc9DNgpeDkcUv22gDxGDS0FM7bqawSUYIZ40z8d0DnjFLsOVVQGnyQesHImVCYwfkdJvFwUVwV7WW4=
X-Received: by 2002:aa7:9201:0:b029:13e:d13d:a10c with SMTP id
 1-20020aa792010000b029013ed13da10cmr8159656pfo.40.1601578029401; Thu, 01 Oct
 2020 11:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201001014250.26987-1-david.e.box@linux.intel.com>
 <20201001014250.26987-6-david.e.box@linux.intel.com> <CAHp75VcP58Ub=gmbRVy0TPJtntKvnQZoi3tOakxE0qsEqzGPVA@mail.gmail.com>
 <CAKgT0Udk4ZdtAisB=edcUfnBqwNFtY8K54CF+9yEF6MZL1Th6Q@mail.gmail.com>
In-Reply-To: <CAKgT0Udk4ZdtAisB=edcUfnBqwNFtY8K54CF+9yEF6MZL1Th6Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Oct 2020 21:46:50 +0300
Message-ID: <CAHp75VcfdHWCxMcHvEoO4yTGXooX=mbc-m2kOOuBmFn-FZ70DQ@mail.gmail.com>
Subject: Re: [PATCH V7 5/5] platform/x86: Intel PMT Crashlog capability driver
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 1, 2020 at 9:33 PM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
> On Thu, Oct 1, 2020 at 9:37 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Oct 1, 2020 at 4:43 AM David E. Box <david.e.box@linux.intel.com> wrote:

...

> Arguably not much. I'll drop the comment.
>
> > > +       control &= ~(CRASHLOG_FLAG_MASK | CRASHLOG_FLAG_DISABLE);
> >
> > How does the second constant play any role here?
>
> The "control" flags are bits 28-31, while the disable flag is bit 27
> if I recall.

Okay, then it adds more confusion to the same comment here and there.
Good you are about to drop the comment.

> Specifically bit 31 is read only, bit 28 will clear bit 31, bit 29
> will cause the crashlog to be generated and set bit 31, and bit 30 is
> just reserved 0.

Can this be added as a comment somewhere in the code?

...

> > > +       ret = intel_pmt_dev_create(entry, &pmt_crashlog_ns, parent);
> > > +       if (!ret)
> > > +               return 0;

(2)

> > > +
> > > +       dev_err(parent, "Failed to add crashlog controls\n");
> > > +       intel_pmt_dev_destroy(entry, &pmt_crashlog_ns);
> > > +
> > > +       return ret;
> >
> > Can we use traditional patterns?
> > if (ret) {
> >   ...
> > }
> > return ret;
>
> I can switch it if that is preferred.

Yes, please. The (2) is really hard to parse (easy to miss ! part and
be confused by return 0 one).

...

> > Are you going to duplicate this in each driver? Consider to refactor
> > to avoid duplication of a lot of code.
>
> So the issue lies in the complexity of pmt_telem_add_entry versus
> pmt_crashlog_add_entry. Specifically I end up needing disc_res and the
> discovery table when I go to create the controls for the crashlog
> device. Similarly we have a third device that we plan to add called a
> watcher which will require us to keep things split up like this so we
> thought it best to split it up this way.

Could you revisit and think how this can be deduplicated. I see at
least one variant with a hooks (callbacks) which you supply depending
on the driver, but the for-loop is kept in one place.

...

> > > +               .name   = DRV_NAME,
> >
> > > +MODULE_ALIAS("platform:" DRV_NAME);
> >
> > I'm not sure I have interpreted this:
> >         - Use 'raw' string instead of defines for device names
> > correctly. Can you elaborate?
>
> Again I am not sure what this is in reference to. If you can point me
> to some documentation somewhere I can take a look.

Reference to your own changelog of this series!

-- 
With Best Regards,
Andy Shevchenko
