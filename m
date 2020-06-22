Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85F9203B74
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jun 2020 17:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbgFVPsv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jun 2020 11:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729222AbgFVPsu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jun 2020 11:48:50 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1564C061573;
        Mon, 22 Jun 2020 08:48:50 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u14so21424pjj.2;
        Mon, 22 Jun 2020 08:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UTeMozTEnRvUc79vKWE21Wx7VbsBFwErofUbGnztYII=;
        b=gYV5CCQ8bRRUQCfIIIN//96WfrVuHVcVJ6SRKfMJQAkN6uz2/TL7kHyCwxPUs2JnbX
         VVu/rmqDIoaljcZqE78wbHblV5AWifkidKx1puFQFpiYQfoJxe+VkQShS2TLp767Gd0w
         wKB8mlHaHw4nGWi9K7vDsyXtWI/PDjqq8/bixEkpZQYzfo5XRBDdZ+PYUVE6TAcox/zn
         5jj2QwuHHis8QHQZEu0IMZswz1KmeJC7Y391RtYGCYGPXMcGMlCTIPRZSzyq/npPLQPI
         CMTTVxkLSZzyFHXByOaKvwA94RoXqh6RuVx6Ox+XJ2gEblbS3+KLWZtHSZlga5IG88s/
         2iNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UTeMozTEnRvUc79vKWE21Wx7VbsBFwErofUbGnztYII=;
        b=HW8zuneNXWOB4rD8TeSPcfIwGEom06dY3JqXZgGGcmrf9M5MWUfCrI2+bhFGiiEEZe
         DhjRRKFvJv91z3ufN/pElAPazOpJA8xfI8KEloi/NKikH9Bccz0b08Zbih4IK1SUNiyc
         qVhvmVhqY5JCNQS0c9cqpemvWaipdeslyXUUmGUvfl+Y/o1+wmOSQvvViSzA+mWF23bT
         RTgm3G6yh1WNwij3VtHdHjQsmaSwlnw0N2zvaI94mRZXGJL7kmEJcUktfNzH64t+p+8Q
         nsQ5QfB6MCvMbL2KtmGyju5YXiwR1lTtAdI11dayv3CNAxUo9v6o6J05lottmdlusZfz
         nUqQ==
X-Gm-Message-State: AOAM530c4U2jxmB++Yvw5oJZ9pqbF6fj5tsMc9+VH1Bdg0wj0c9bP2cJ
        2Z0IVqCdxsE++UHKuUsOPKJTtZyJwANhB0rq2j8=
X-Google-Smtp-Source: ABdhPJyd++CbCxs4tfqmXSChUpZx5iYr8UfFfO4C772lsN5Xz0B61ofSXuAbMMaY4/KTZcliJwrSXzNECuZECVMOsSQ=
X-Received: by 2002:a17:90a:ac05:: with SMTP id o5mr19461550pjq.228.1592840930325;
 Mon, 22 Jun 2020 08:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200622103817.476-1-nsaenzjulienne@suse.de> <20200622103817.476-3-nsaenzjulienne@suse.de>
 <CAHp75VcGoK=6FitfuzEhPZXSrtJiO_-XcD6jtg8SckprWhePgA@mail.gmail.com> <4aaabc8ff39007a97a03f335c6a51313a2c59551.camel@suse.de>
In-Reply-To: <4aaabc8ff39007a97a03f335c6a51313a2c59551.camel@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 22 Jun 2020 18:48:37 +0300
Message-ID: <CAHp75VeCgum9WtuWLK63h4XEZc8Jz2py-i3NdSw4F1eyL-ngZg@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] reset: Add Raspberry Pi 4 firmware reset controller
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        tim.gover@raspberrypi.org, linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 22, 2020 at 6:08 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
> On Mon, 2020-06-22 at 17:42 +0300, Andy Shevchenko wrote:
> > On Mon, Jun 22, 2020 at 5:26 PM Nicolas Saenz Julienne
> > <nsaenzjulienne@suse.de> wrote:

...

> > > +       struct device_node *fw_node;
> >
> > If you are going to use fwnode (as it should be), make sure the proper
> > data type is in use, i.e. struct fwnode_handle.
> >
> > Otherwise, if you want to be OF centric (I discourage this, don't know
> > if RPi4 is ever going to run RHEL or other distros that require non-DT
> > firmwares), don't name fw_node. It's confusing.
>
> I agree it is confusing. I'll rename it. On the other hand, this is strictly DT
> centric.

AFAIU struct device_node *np is a usual pattern in OF-only world.

-- 
With Best Regards,
Andy Shevchenko
