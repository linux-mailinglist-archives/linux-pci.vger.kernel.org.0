Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5666134B841
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 17:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhC0Qkg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 12:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhC0QkN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Mar 2021 12:40:13 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA91C0613B1;
        Sat, 27 Mar 2021 09:40:13 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so3912144pjg.5;
        Sat, 27 Mar 2021 09:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JL70rgGydsxus+JeTgWi5wl5fpmwQg+GhwZ0mAf8iok=;
        b=HynBWYBX2IKzobwhkHmWP4fkpfSIcVB+IJYj7uu8/XVRTxQe2sJEYX7uqBKBvJERAl
         vAdYsyMcKJyBEJQUoVPPwucofi7koI0hfIU56u1dnoXxkv1spnoEET8FWg76udE7Cq92
         +ignPdPJft2HgToIx34j5ChbtBI5wdlbMkP7OqIBR925U1ZnwHiZHB3g/Glz625YXhnu
         fJt1vx/GX4PEnhEConuSa0UNCtz717UeDb3SAa4YGFUpfwLOh0MzNmHbco901+Wq4bOY
         3QbiPCJ0F4lVl/w7fY1Zjyl//esaeYokd/kBB/ZcO5dpb5kc2qdlkNPxz17W0pVCWX+9
         0HXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JL70rgGydsxus+JeTgWi5wl5fpmwQg+GhwZ0mAf8iok=;
        b=eSDE5antLHVy62kbT7uVHs3Os9/Rf8DNa8/TvABOkvEcAN8DCL2VRiZZKkNUHmO8mZ
         5fdKK/OBqf8nJBPK8wpov7icDeKVjUGA6D38hPC8zHcJqPL3ZSPk3k4k6uuYYcXnfHQi
         OIT6LzAPjqaE+smRMRLiSJmC5AwdsPXKUi90LmEZZLR4/dEzhzZbUV0OAT9PUwPVdoFz
         aL4u2T3eN3rjMzocoMg4BAjZLA4FLQa/95OMKjZ8NHp1SVhaQM09wl+edrvvF++zVRPZ
         pFumcLh3GvoyJqsO/COLIyMq2FGPbGe2eu8dIINMyWpiZIla7w2b2rYNenUimsYF4ff3
         dXUg==
X-Gm-Message-State: AOAM532RI9V7iy7EAdi1uN00fvVDQ2rurUt7BhUOGusiGwToaYijU2dk
        XJ9C8lJFxJrw5TYitwqHvbNkwoNCcS1DHPIuME8=
X-Google-Smtp-Source: ABdhPJzkyo6zxijfjanBnyXsLv3vXhLo28Y8FI2srMcNyQbFZa4Pfz1G4do6IfD8ml1liHwXCz5mMkQanyooX+lE3sc=
X-Received: by 2002:a17:90a:b311:: with SMTP id d17mr19406689pjr.228.1616863212901;
 Sat, 27 Mar 2021 09:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <1616831193-17920-1-git-send-email-tanxiaofei@huawei.com>
 <1616831193-17920-7-git-send-email-tanxiaofei@huawei.com> <CAHp75Vd0hVqsfsZK=d1dz98Kbchqz-w4RqQQp6FwisxSGG5BzA@mail.gmail.com>
 <50e838ca74c56b9fd5cbbc2d7234829f0e0b4131.camel@perches.com>
In-Reply-To: <50e838ca74c56b9fd5cbbc2d7234829f0e0b4131.camel@perches.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 27 Mar 2021 18:39:56 +0200
Message-ID: <CAHp75Vcr5DTiQ=WWSC+Ch-jEw7H+f13A=4=U3QVF5ttvRr1D7w@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] ACPI: LPSS: fix some coding style issues
To:     Joe Perches <joe@perches.com>
Cc:     Xiaofei Tan <tanxiaofei@huawei.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 27, 2021 at 3:39 PM Joe Perches <joe@perches.com> wrote:
>
> On Sat, 2021-03-27 at 10:19 +0200, Andy Shevchenko wrote:
> > On Saturday, March 27, 2021, Xiaofei Tan <tanxiaofei@huawei.com> wrote:
> >
> > > Fix some coding style issues reported by checkpatch.pl, including
> > > following types:
> > >
> > > WARNING: simple_strtol is obsolete, use kstrtol instead
> >
> >
> > And one more thing, the above message is bogus. Read what the comments in
> > the code says about use cases for simple_*() vs. kstrto*() ones.
> >
> > Joe?
>
> This check and message is nearly 10 years old and was appropriate for
> when it was implemented.
>
> kernel.h currently has:
>  * Use these functions if and only if you cannot use kstrto<foo>, because
>
> So the message could be changed to something like:
>
> WARNING: simple_strtol should be used only when kstrtol can not be used.

Fine with me, thanks!

-- 
With Best Regards,
Andy Shevchenko
