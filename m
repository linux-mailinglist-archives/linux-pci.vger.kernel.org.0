Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDB52805FA
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 19:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732941AbgJARzG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 13:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732795AbgJARzF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 13:55:05 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CF2C0613D0;
        Thu,  1 Oct 2020 10:55:05 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m34so4590157pgl.9;
        Thu, 01 Oct 2020 10:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rHMJ8NfdGT2MqHpFcCufDD+y2+Qb0H0Ph/DUp+uxX/Y=;
        b=aw26JKesp5tSyb27ufMF3TM2wOKDsPhkzPMVBd3oVaRkDDaKBZazN08UCbLny4D2Dy
         wOcdmbX9Bp57OVNqO7vg0nOPX9rIMJ53kKdDwzoOsE6IyQAEhSWSlV/YQYHrrC4FgXre
         yBND4utAQ5xPdEoJjH0DiCY4yM/LfEkrrecGpv46YO/FN2fvi1yU3zAnFNcAADT4iMfa
         16cGX8+J7pqtOsKL7klpMt4C6LP0aQ08i2FhCcqTr+niMjZW2dry7/WQmg5CICW7Bb0f
         firIgjAsZrJNXPIuMIpl4dg4OEBH23SkP8UG1PLmUn0SRIqaokMC0Kc7pdTQVtpAFS+V
         M19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rHMJ8NfdGT2MqHpFcCufDD+y2+Qb0H0Ph/DUp+uxX/Y=;
        b=rUi5QlLb05oE5VZQVj6GN0al+RoDlioj1AT/5heIDygWaGSuI+z3zMtbdEE13LYsRY
         wJY6IMyfc5MfQPgYp2A7pIcB0lZiwhvNpJs0gAGS28TPhlbonLk7/mMa7i+BVekymHKr
         9XJsNx4tV5HRNsDzlk9Cs3eUhtgyf4oTgFmY0ecHOte5zFatN/NVn6DH/u5PtTLomtd4
         g1/cPGn41TIG1dVwa/cZNCmPXvCWe57+v9hXUtK1BBYx1VvcquaT+MYo2FxubQwHqVaM
         n2m0fjYzMdijPANuNJAzwDYQpCklWbQFFE5WedM4TpbclCAS+SGEm+AGcl6A5v5F9VRp
         DZwQ==
X-Gm-Message-State: AOAM533oafIYdbbdz23stac/X7WozrUcMZYKfWS0gYI1ZpPOORXw/D1w
        IELZCWBLrBCpsh1P8N/wEuYSrYA0gyOX5uvRmG/a4pXepFKyNQ==
X-Google-Smtp-Source: ABdhPJxDI8NgGrnX0YZS3d7bApgu4Scud6EAwQQz0X0cC8QF/yQXZR1oo4YxYCsSWFktwXpTuDlya1JqdaAxoWnWbHY=
X-Received: by 2002:a17:902:c14c:b029:d2:4345:5a9 with SMTP id
 12-20020a170902c14cb02900d2434505a9mr8354999plj.0.1601574905239; Thu, 01 Oct
 2020 10:55:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201001014250.26987-1-david.e.box@linux.intel.com>
 <20201001014250.26987-5-david.e.box@linux.intel.com> <CAHp75VfcXbedZbbF3KATWYMR1SPXusuaU+vrkvM1zsRpYzDFiA@mail.gmail.com>
 <CAKgT0UcJXEeC4ZNQ0vq6Q6gBQeUe9uaFDHoDNoTjL0eYWaYUEA@mail.gmail.com>
In-Reply-To: <CAKgT0UcJXEeC4ZNQ0vq6Q6gBQeUe9uaFDHoDNoTjL0eYWaYUEA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Oct 2020 20:54:46 +0300
Message-ID: <CAHp75Vd2tpGTGTmMSztLsCjsr0-WHV1yUT-ATD1mOLytPz59uA@mail.gmail.com>
Subject: Re: [PATCH V7 4/5] platform/x86: Intel PMT Telemetry capability driver
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

On Thu, Oct 1, 2020 at 7:46 PM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
> On Thu, Oct 1, 2020 at 9:03 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:

> > > +static struct platform_driver pmt_telem_driver = {
> > > +       .driver = {
> > > +               .name   = TELEM_DEV_NAME,
> >
> > I'm not sure I have interpreted this:
> >         - Use 'raw' string instead of defines for device names
> > correctly. Can you elaborate?
>
> Can you point me to a reference of that? I'm not sure what you are referring to.

It's a changelog of this very series.

> > > +       },
> > > +       .remove = pmt_telem_remove,
> > > +       .probe  = pmt_telem_probe,
> > > +};
> >
> > ...
> >
> > > +MODULE_ALIAS("platform:" TELEM_DEV_NAME);
> >
> > Ditto.
>
> This doesn't make sense to me. Are you saying we are expected to use
> "pmt_telemetry" everywhere instead of the define? It seems like that
> would be much more error prone. It seems like common practice to use
> DRV_NAME throughout a driver for these sort of things so if you are
> wanting us to rename it to that I am fine with that, but I am not sure
> getting rid of the use of a define makes sense.

I'm just wondering why changelog mentioned that and what it meant.
If it's indeed conversion to explicit naming, then this has to be
followed (somebody seems asked for that, right?) or commented why not.
Or maybe I understood it wrong?

-- 
With Best Regards,
Andy Shevchenko
