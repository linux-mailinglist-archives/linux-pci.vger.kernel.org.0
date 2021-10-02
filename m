Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379F541F9DB
	for <lists+linux-pci@lfdr.de>; Sat,  2 Oct 2021 06:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhJBEjY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Oct 2021 00:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhJBEjY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 2 Oct 2021 00:39:24 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6F7C061775;
        Fri,  1 Oct 2021 21:37:39 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id h9-20020a9d2f09000000b005453f95356cso14044208otb.11;
        Fri, 01 Oct 2021 21:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nAmKLZjrOXAXZSBKxPTPKE4dKm8DALBsSgMVMuCAdHc=;
        b=b3yLo2/vIHJ1uElT7jpgHuDU05OkhPEPhoxnqQ4jbk8CTVY662wXA0FS9X01S4cTRF
         yCLro9pVV/XfnE62RuN4dI5yPKAY9JLkgrQRooagDe0ggNfTH6VzYVIvzIF1ayafwMkm
         7+NsS2fK9sGmACodNBVC8Gj+p3+fI0DjbPP2YZDwjJ3hRDBhgjZjqoJTOWHkxfYQiJ+/
         +oHAXRDOTtPtmYpFKp2/8CbPRIRbw76CDcOvsNvqYXuEacrjuUn/aCCzYREeM70s53Vt
         xyiUeSAcUIBNqE1uvba4aK3BtID7VcC91qh6QwhrL+gxrLHBOdMfwJqTIgV7BkdSamh6
         puYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nAmKLZjrOXAXZSBKxPTPKE4dKm8DALBsSgMVMuCAdHc=;
        b=Op7yy+LUqZfAtQy1FLQTRuXcVKdLnT1abYWa599PuSc73WvbONbTDb/L2a3Axnf+Uq
         WZhU5s1/hyc8NeU+edPdfAAmTGYAwjwcdw33c6fa3n5cxz3C6DIKhzKZf7bq/G0jlDef
         1uoY8YDu0xUvaeI7KaKH6ZJYTgoRvanm04jaofcLiEoTqFF1fvjjFl0pUK73YnGexQQ8
         s6AGZ9KJIZ08KL+RCmeTmvWIy4aWUj7hnUp/uJtBAASCf38s/B1y/hq8BorQ8h968b/K
         8lApgonr9M/OF4Br8TE1NY+TSlNFjn9bE8CcDew4bwrb1id7Sg60tTQe45q7kOJ1KgF9
         IcLA==
X-Gm-Message-State: AOAM530BfS8P8T77LmtqSxsStaDQwkeKddbjNT18qD2UdC/ulRtsvCB2
        +caXZFIa4hfm5EUHEIa7+GevW/+v0aH5wU2qtBEa4Wn4
X-Google-Smtp-Source: ABdhPJzLPwInnwI27WfRFsuzK4FFG9Ld0vDn1aFCNHzQ4pbugAHgdOWMfPC0ES6LsToWx9eixS5ziyNk05Xx7zcc2T4=
X-Received: by 2002:a05:6830:1653:: with SMTP id h19mr1351599otr.162.1633149458403;
 Fri, 01 Oct 2021 21:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAHP4M8V6b-su=bpM-qMg5pnDKfvh-Ks_3bFfeK7p4hA2RqQw+Q@mail.gmail.com>
 <a4471053-a4e3-42ac-6177-056bfe371c70@infradead.org>
In-Reply-To: <a4471053-a4e3-42ac-6177-056bfe371c70@infradead.org>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Sat, 2 Oct 2021 10:07:26 +0530
Message-ID: <CAHP4M8XS423Rdv2mX9VadnJn3_0RRxPvpdJjQ=JkMJkpyC6HHA@mail.gmail.com>
Subject: Re: Recommended way to do kernel-development for static modules
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks Randy.

On Sat, Oct 2, 2021 at 10:03 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 10/1/21 8:31 PM, Ajay Garg wrote:
> > Hello All,
> >
> > Let's say, I want to make a simple printk change to drivers/pci/bus.c,
> > compile it, load it, test it.
> >
> > Now, since bus.o is built as a result of CONFIG_PCI=y in
> > drivers/pci/Makefile, so this module is statically built, and as a
> > result doing a "make M=drivers/pci" does-not-pick-up-the-change /
> > have-any-effect.
> >
> > Doing a simple "make" takes too long, everytime for even a trivial change.
> >
> >
> > So, what is the recommended way to do kernel-development for static modules?
> >
> >
> > Will be grateful for pointers.
>
> Just to build drivers/pci/bus.o, you do
> $ make drivers/pci/bus.o
>
> That will tell you if you have any build errors/warnings.
>
> For run-time testing, AFAIK you don't have any choice but to
> build a full kernel and boot it.
>
> --
> ~Randy
