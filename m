Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79AB5BA881
	for <lists+linux-pci@lfdr.de>; Fri, 16 Sep 2022 10:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiIPIrQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Sep 2022 04:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiIPIrP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Sep 2022 04:47:15 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EBA7AC26
        for <linux-pci@vger.kernel.org>; Fri, 16 Sep 2022 01:47:13 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id g12so15051357qts.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Sep 2022 01:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=YNQhhnLP2IaYIDCSrmAb0DLC6VTKZOy/Bj93eUvHKMk=;
        b=FJi75foOExmtuxypz3Xi9WUQC6nNaftvRns2MPo2G93f2eM2BYttloXJJqWQtguebl
         Gvnmgf1F5phEYtkc5x6Uk7yekktil/7IwfL3tD8Ae3j3i+ry7UOOtMaQZjwO5fnf3Nnn
         /N09gMYBqX/F2c2VADdz+mdpqtdzqNXsywGoQZwueqQOi4cJSnyXV422IDrLjtHTlYiD
         spIODoF9e4Uvg2fnzN/EyZzCRdIpwXH4eYsOOUeZODUyYqSRO4iAFC0zE0LGwKaClPyk
         XedLOaCqIoFK0WMd0N+eDRwTK3H2zDC2DwSCqRZlIyzEaDp0Pd7LpaTNv49lZG2bOb1y
         3gKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=YNQhhnLP2IaYIDCSrmAb0DLC6VTKZOy/Bj93eUvHKMk=;
        b=5RxPetmYWYk7METgBEyV5o9EZxCXt77RdlHs7NSZMuOQF7NX0C/ZtFYDpl3ccLitHv
         yfio5Um1rp3o6SKoIhiv771563ukgyhFLl+fmzMPtX7tRcGfzinqYq/awtEmq0pNyV93
         9/wCDuQoXxGievXLCi5wFIaYQwcGf8dxGSWv6BDaLPB7D2uBacxl9cq+5fxMAcFGbtMT
         FFnWXQISV9LhxenLV+H08qSYjsgDzJXh466yOOMVgSFQ55haNW2+PGCW/pUxYSpD1fJW
         n9fMnFU5/z3EG+TeGzuc+t657Q6u81Hq/Gr0cz8fgm3Lid76U8UExkOxu/ED0CHL2Cvz
         2q3A==
X-Gm-Message-State: ACrzQf3M2M2r1iDC+JeeISsR9kV3LYxcXdGadqfZ1hvKwyh2E0xW27sn
        27ojgIgOi9dEMwbaULMGqL9LS9gBFKQoMov7DlY=
X-Google-Smtp-Source: AMsMyM4LfpNcDiSq3jKoQg4wR435CJgg/DKANzpsa2x3JtAo53BMy2C7x+xfuHj5zvAa7iOtFUx3GkcLs16oKGmKBnc=
X-Received: by 2002:ac8:7f92:0:b0:344:8cd8:59a1 with SMTP id
 z18-20020ac87f92000000b003448cd859a1mr3479496qtj.384.1663318032278; Fri, 16
 Sep 2022 01:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220915022343.4001331-1-windhl@126.com> <f7316f94-433f-d191-0379-423c22bec129@csail.mit.edu>
 <89a1b1f.165e.18344069cab.Coremail.windhl@126.com> <CAHp75Vd-ZdHJfjdgob7=e3X_=NQR_chWZzTiSVU64S9eTiAY0g@mail.gmail.com>
 <7f9efc57.4645.183451f5b84.Coremail.windhl@126.com>
In-Reply-To: <7f9efc57.4645.183451f5b84.Coremail.windhl@126.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 16 Sep 2022 11:46:36 +0300
Message-ID: <CAHp75VfQHnt2YxuxbFo96tfDrHEZpEqSFKFV_D7ERe6uXEnvEQ@mail.gmail.com>
Subject: Re: Re: Re: [PATCH] jailhouse: Hold reference returned from
 of_find_xxx API
To:     Liang He <windhl@126.com>
Cc:     "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>, jgross@suse.com,
        virtualization@lists.linux-foundation.org, wangkelin2023@163.com,
        jan.kiszka@siemens.com, Thomas Gleixner <tglx@linutronix.de>,
        jailhouse-dev@googlegroups.com, mark.rutland@arm.com,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        robh+dt@kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 16, 2022 at 10:09 AM Liang He <windhl@126.com> wrote:
> At 2022-09-16 13:38:39, "Andy Shevchenko" <andy.shevchenko@gmail.com> wrote:
> >On Fri, Sep 16, 2022 at 5:02 AM Liang He <windhl@126.com> wrote:
> >> At 2022-09-16 07:29:06, "Srivatsa S. Bhat" <srivatsa@csail.mit.edu> wrote:
> >> >On 9/14/22 7:23 PM, Liang He wrote:

...

> >> >>  static inline bool jailhouse_paravirt(void)
> >> >>  {
> >> >> -    return of_find_compatible_node(NULL, NULL, "jailhouse,cell");
> >> >> +    struct device_node *np = of_find_compatible_node(NULL, NULL, "jailhouse,cell");
> >> >> +
> >> >> +    of_node_put(np);
> >> >> +
> >> >> +    return np;
> >> >>  }
> >> >
> >> >Thank you for the fix, but returning a pointer from a function with a
> >> >bool return type looks odd. Can we also fix that up please?
> >>
> >> Thanks for your review, how about following patch:
> >>
> >> -       return of_find_compatible_node(NULL, NULL, "jailhouse,cell");
> >> +       struct device_node *np = of_find_compatible_node(NULL, NULL, "jailhouse,cell");
> >> +
> >> +       of_node_put(np);
> >> +
> >> +       return (np==NULL);
>
> >This will be opposite to the above. Perhaps you wanted
>
> Sorry, I wanted to use 'np!=NULL'
>
> >  return  !!np;
> >
> >Also possible (but why?)
> >
> >  return np ? true : false;
>
> So, can I chose 'return np?true: false;' as the final patch?

Of course you can, it's up to the maintainer(s) what to accept.

-- 
With Best Regards,
Andy Shevchenko
