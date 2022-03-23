Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DFC4E536E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Mar 2022 14:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244396AbiCWNqM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Mar 2022 09:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236735AbiCWNqL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Mar 2022 09:46:11 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58549E0FD;
        Wed, 23 Mar 2022 06:44:41 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id c62so1893972edf.5;
        Wed, 23 Mar 2022 06:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5n9h4RX0iio25CI6fqvwPwFNSibxgTcsM+GkXv7ZxQQ=;
        b=NYPdIg+F9GW3polJIYVTprEYKhiZ4g86XAN3K8y5SxfWZMir0k6dO8Wxq7jkbFlSX2
         C4++F3u5Umsk5l02eDL+b+4ZG8fj6rsBkFFZyXXtOaLRtdBms4fBt2LW7cGGjl80/DD0
         7mSLIHnZQkquUdlI0HQBw2c4XYeuPimUUP3dGCnq8oi8z+z3lGghoxgbIwJ+wOl7ON8Q
         QrGkWMYUuZiJFdQMurXF+tJjyPvoL916fBx3HenXEoDUxRa2VAAO3XU40vogLpUqZAYx
         /sD7n9RCIC+dLMQlicY7rvGHIcK/KfegaC3NUo/gs6vEm8Hui03GZDorILVL5jbFYnos
         bRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5n9h4RX0iio25CI6fqvwPwFNSibxgTcsM+GkXv7ZxQQ=;
        b=RsQLYzr8GvcgwN7xUwwwmOz/osr+MZ6ibhXhX365iFXxBqYZpsWvN3WVNDawnRbgBW
         BSstMi6dlJuXgvDtAzVdYw76hJQJI1LNKEb9bcdCGxVx35+cvk4T0qjKGwMTJBpx6oHg
         M1yExLpP00sPUQj9A/4WOxDqSLkydjq1SBYzmv5Vu5k744z2W7RCAsFsV+7JDl8tvrqE
         JieV7CrAuaBwgKv3xoekfT9UwQiysJAKPNIjOvB6jB5gOG3lAKyF3QaBog+BBOZZnEnV
         uo6f3MkY8Z3gZrJrbJ3bHm+hut5xpeuhZBpV5r/EjQ972cHwgoE5oAW7cLJsr0LG+EUF
         maGw==
X-Gm-Message-State: AOAM530Z2WJhOuPolcLHDfB2EW3Rqcrmoow5Zz/wuKW0BDn5giXQxwSB
        qhzgsFWeJkmX0BswqxYQE4iXyYG613ZClehvKPg=
X-Google-Smtp-Source: ABdhPJykUQnR9d8S/w+Aj8qrgX8B13l0SKuPjc7N6s4BuzK4ejP1LeC4kp0r8iMV4XAxTUQg0MIGhMrr6xMqRP+VPPQ=
X-Received: by 2002:aa7:dc4e:0:b0:419:407b:6bff with SMTP id
 g14-20020aa7dc4e000000b00419407b6bffmr145751edu.158.1648043079752; Wed, 23
 Mar 2022 06:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220321183446.1108325-1-helgaas@kernel.org> <20220323022648.GA1243295@bhelgaas>
 <CAHp75VfdoAbSTkO7eaor94pkmN0ttLXstc1DS_Sa7i45Dt5GAA@mail.gmail.com> <a1bf31d6a8957b837b999c02875456b805efdff1.camel@infradead.org>
In-Reply-To: <a1bf31d6a8957b837b999c02875456b805efdff1.camel@infradead.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 23 Mar 2022 15:43:29 +0200
Message-ID: <CAHp75VdKOzgWgsTh-8sAEEey8iOLUUgnw=M-OeX+Dzhu2tnH1g@mail.gmail.com>
Subject: Re: [PATCH] PCI: Avoid broken MSI on SB600 USB devices
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mick Lorain <micklorain@protonmail.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 23, 2022 at 2:43 PM David Woodhouse <dwmw2@infradead.org> wrote:
> On Wed, 2022-03-23 at 10:03 +0200, Andy Shevchenko wrote:
> > On Wed, Mar 23, 2022 at 4:26 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Mon, Mar 21, 2022 at 01:34:46PM -0500, Bjorn Helgaas wrote:
> > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > > Some ATI SB600 USB adapters advertise MSI, but if INTx is disabled by
> > > > setting PCI_COMMAND_INTX_DISABLE,
> >
> > > > MSI doesn't work either.
> >
> > I think this is not correct.
>
> I think it was perfectly correct until you added a couple of newlines
> in the middle of the sentence, then took it out of context. :)
>
> "If INTX is disabled, MSI doesn't work either".

Ah, I stand corrected. Thanks for the English lesson!

> But really, in that case surely the solution is *not* to disable INTX
> for this device. Then MSI will work, right?

That was my intention, but Bjorn has concerns.

-- 
With Best Regards,
Andy Shevchenko
