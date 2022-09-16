Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F945BA668
	for <lists+linux-pci@lfdr.de>; Fri, 16 Sep 2022 07:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiIPFjS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Sep 2022 01:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiIPFjR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Sep 2022 01:39:17 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00BE71BD5
        for <linux-pci@vger.kernel.org>; Thu, 15 Sep 2022 22:39:16 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id s9so12717864qkg.4
        for <linux-pci@vger.kernel.org>; Thu, 15 Sep 2022 22:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=bGui9tpfbXaXph8yxfFfUUcX4Z55523adcOMpqhHVIA=;
        b=C/8AA994O/cZ8hxBpVbmkDWFQfLeN6vQtNqHpX0NNuUGzSxZxIHZzLci5+nTSoRXpR
         0PNc6NT531M56yKg2ezoxMYWIl/G0ZlG+uKkkZUyibSwjts034ATPq+1z04kYvc9DWR/
         YzZORv9pie2TCV56Ni9+JL28+DZbu+kBQpgXtCifI7omPtjgazEWLetEzGKEVoWIzsTc
         wILX9HC95d82SGDP8z+kDfMXpIXvwFIse+9dRbQJbLl8FouPb5lVBO1zr9MJ7BwFRYzZ
         lpP6ghO61dHv4FkMcCcGrxoUo1s2KELgYEBUgMPoDijeo4RUmuD/AR/OJDJpar6hlhwG
         hNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=bGui9tpfbXaXph8yxfFfUUcX4Z55523adcOMpqhHVIA=;
        b=kHF/CTzQENo9x7kLrAWuXmIdcsdkXVaCObWnVH4cZCy3owuuyuwqwQW13DNV3s2l4j
         1LktyIX4qawinmne5H/wAVZzhv17rXBg7zmD+uU6AYPQRT1vLgTqfuOKw29TTiYnWqDS
         RMF3thdJ0892b4ktpJ2RdUWvCl8PChX6KOTZi09kadRggWKg9Y+JhBDc1E9GrvJHvFA5
         gt9euHAGzOLt9VYZTjp8GpD6u5GIZXwJNEfLTbEkv5baDpRcvJT6qqHxNNfXk7nRvA2F
         niKm+QeQEGZm4e11uSETTYn8cInWl/xQvYeCm/4pQHUgC+L5YTozS4uoHtGm1RLPssjy
         DEBw==
X-Gm-Message-State: ACrzQf0muUPc7TpsaS8hGt9JBss2ASt0j7+hiNddaxAUHZWOkGPqEOtM
        j8isIYAjN9XtQbcQariyLDJZ6ea+NfnxJPgjoHEV4R5GDJI=
X-Google-Smtp-Source: AMsMyM44vljsR7IclcEs7VK9H0/h5xHSaFlh8ZSSxTaRFWhLWFsZx7TrUpGOdPjr32yxI7b0FYCkJK8CYLul6GgbXLU=
X-Received: by 2002:a05:620a:2552:b0:6ca:bf8f:4d27 with SMTP id
 s18-20020a05620a255200b006cabf8f4d27mr2746831qko.383.1663306755654; Thu, 15
 Sep 2022 22:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220915022343.4001331-1-windhl@126.com> <f7316f94-433f-d191-0379-423c22bec129@csail.mit.edu>
 <89a1b1f.165e.18344069cab.Coremail.windhl@126.com>
In-Reply-To: <89a1b1f.165e.18344069cab.Coremail.windhl@126.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 16 Sep 2022 08:38:39 +0300
Message-ID: <CAHp75Vd-ZdHJfjdgob7=e3X_=NQR_chWZzTiSVU64S9eTiAY0g@mail.gmail.com>
Subject: Re: Re: [PATCH] jailhouse: Hold reference returned from of_find_xxx API
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

On Fri, Sep 16, 2022 at 5:02 AM Liang He <windhl@126.com> wrote:
> At 2022-09-16 07:29:06, "Srivatsa S. Bhat" <srivatsa@csail.mit.edu> wrote:
> >On 9/14/22 7:23 PM, Liang He wrote:

..

> >>  static inline bool jailhouse_paravirt(void)
> >>  {
> >> -    return of_find_compatible_node(NULL, NULL, "jailhouse,cell");
> >> +    struct device_node *np = of_find_compatible_node(NULL, NULL, "jailhouse,cell");
> >> +
> >> +    of_node_put(np);
> >> +
> >> +    return np;
> >>  }
> >
> >Thank you for the fix, but returning a pointer from a function with a
> >bool return type looks odd. Can we also fix that up please?
> >
>
> Thanks for your review, how about following patch:
>
> -       return of_find_compatible_node(NULL, NULL, "jailhouse,cell");
> +       struct device_node *np = of_find_compatible_node(NULL, NULL, "jailhouse,cell");
> +
> +       of_node_put(np);
> +
> +       return (np==NULL);

This will be opposite to the above. Perhaps you wanted

  return  !!np;

Also possible (but why?)

  return np ? true : false;

-- 
With Best Regards,
Andy Shevchenko
