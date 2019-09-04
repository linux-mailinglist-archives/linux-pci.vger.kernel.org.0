Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFCDEA8D8D
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2019 21:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbfIDRNg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 13:13:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46225 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731611AbfIDRNg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Sep 2019 13:13:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id m3so11544650pgv.13;
        Wed, 04 Sep 2019 10:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=203rL96lqX9CJ7MhqHWhG04uP6pIdNdYcJDpLH3Er7E=;
        b=ouJxs/16RBB649/E0/4u3+4Q3AfsNRAbmb9v/CToDhKV+1YOwmn/fU3MYx6CMvqg4v
         dlTQsNjA3XprYx29R3QKzMR/bhN4nCgSiSDjVamR9pe63LGmkPpD6F8WliemDwPAkr5G
         btiyjhaQTXV9sIYOptCiAz9cxfxMmYMaziMe92oUoZARqdxMIvTxWnuRH/aJOoY6xnDw
         nu4r6zvX7+DMA+sJH5HINkE7NG3WM9YEnGk3vR5YZtR2rMnHmLWXSAisY1sNMPXlGtX1
         vHBjCMM0auZZIVZAlR0FNRkyq1lR5lnEJ3sFfgi/p0fTlPf0Eb0g1DfHwhqlmXIAgLJF
         9/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=203rL96lqX9CJ7MhqHWhG04uP6pIdNdYcJDpLH3Er7E=;
        b=cEt4yEQ0aUcyArFNivxvNAWCv/lzMXB7HwECEAgA3PjQKwhdrjKvu4MQOnWPTBdsNV
         y73RQXH0onijtcsTkYlIZsRmqRPF4cEa8+MJf+N2/b7aI7Z1HAs5NqPxW9mERWpbS432
         gGeokYXWtgyHJ2dxts+wQrmh5YJECA7NgcHaGVBXROPQP2ZA8JsRaVRVZLMWj1Jh1bAj
         CDmOAN3EP0ABy8Kmr9qfj210SAB0TCGTCee+i94WN2pZr67qjvw6WzQ+N5EhC9KhnAf8
         xHkTSGENgh38rk/uP4jCbnz1uK3Fyctms3HFIALeEg76V1ICuPDO5cXOqpeVmySuBEA7
         +g+w==
X-Gm-Message-State: APjAAAWVkwi08KL0IchD4rv8WCPoV5AT9XhWxzsgMiYmeMIOaqi0hx7H
        6rcnKJM1MSuKaw93mGnr2/91SkqCcH0VrCkxAYE=
X-Google-Smtp-Source: APXvYqy1q6FKr2BVGFuDHAekiPGsik3GgCaln4T9YGQW5rrmsKtxaRxiEfJviDKfqykEVer3/KPGg/31X239tUf7VgU=
X-Received: by 2002:aa7:86c8:: with SMTP id h8mr9503892pfo.241.1567617215580;
 Wed, 04 Sep 2019 10:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190830231817.76862-1-joel@joelfernandes.org>
 <201909041108.RSjNvfDL%lkp@intel.com> <20190904050419.GA102582@google.com>
In-Reply-To: <20190904050419.GA102582@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Sep 2019 20:13:23 +0300
Message-ID: <CAHp75Vdeoc1S_0Dn_vk2ULPRLk_sevWoxs8+Gscv9ki_kkPx4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] pci: Convert to use built-in RCU list checking
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 4, 2019 at 8:07 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Wed, Sep 04, 2019 at 12:06:43PM +0800, kbuild test robot wrote:
> > Hi "Joel,
> >
> > Thank you for the patch! Yet something to improve:
> >
> > [auto build test ERROR on linus/master]
> > [cannot apply to v5.3-rc7 next-20190903]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> >
> > url:    https://github.com/0day-ci/linux/commits/Joel-Fernandes-Google/pci-Convert-to-use-built-in-RCU-list-checking/20190901-211013
> > config: x86_64-rhel-7.6 (attached as .config)
> > compiler: gcc-7 (Debian 7.4.0-11) 7.4.0
> > reproduce:
> >         # save the attached .config to linux build tree
> >         make ARCH=x86_64
>
> This error seems bogus. I pulled -next and applied this patch and it builds
> fine. I am not sure what is wrong with the 0day tree, and the above 0day link
> is also dead.
>
> What's going on with 0day ?!

I would rather to add Depends-on: ... tag to your patch if the
dependency is going thru another tree at the same cycle.
kbuildbot absolutely correct here.

-- 
With Best Regards,
Andy Shevchenko
