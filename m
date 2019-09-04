Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01B49A8F09
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2019 21:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388230AbfIDSB1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 14:01:27 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39080 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732826AbfIDSB0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Sep 2019 14:01:26 -0400
Received: by mail-qt1-f195.google.com with SMTP id n7so25443879qtb.6
        for <linux-pci@vger.kernel.org>; Wed, 04 Sep 2019 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I+yojRW69JxaQ1YWeqMffbm7yLHLeYtlezXpC/ayb9A=;
        b=kbRt0PBSJ48HPVKqYf6ln5xrY0K3tPQUm2vMDVscw9cYbN6byjes7cgfaBiOH/g4Se
         bSV5QE+ivAav5Lo49RKTpLIuAmKnEIhwOObmqBuh3aDAtAgqiYZUoP025LEG6AO4xfOM
         Ad4rH+Rj4ColCBhR7VZeM0jzkWvmq5qUjtYyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I+yojRW69JxaQ1YWeqMffbm7yLHLeYtlezXpC/ayb9A=;
        b=eBMwClMJcT92+8duA/OHKrnY7LaIMgvs64/Qs9gbQIXqKjm0qUsK5WvDaoSf0PRv5m
         1SA6bG4WqOSv/WBh3h+QnQtUK2wFjHqJggFDCXrx/XT1DsCJOKVdX2hDzK3T3A1CBkx2
         k7oA1h0uU4MQmOwQJi8YzVhB5kN9ekom4kwcViz78S2bkHSAd9ZnA73dmrOV3lLBFw8W
         yYj4GjE3gsSoj6XwK06o/qxj5tz89cQYH95kbh5BRDRZR8U3Y2FMKCa5DpHDrKFiTJou
         /7HCw1stZijdf6H0wDffAQ7JIyf8Rb70+/X1xztGYWOnRDDrDsaRNHuCp+LWuQ6QbVyC
         ywqQ==
X-Gm-Message-State: APjAAAVXvOemaQIHw3Jjxs1FrDX9Sg0LExhaL4u5K89xv4sVgIXNMvZ3
        Qnp0qbu4so6H6QGDInyfNYCW5aXurxVrZBfOTxTsQg==
X-Google-Smtp-Source: APXvYqwWC2X+OYzUl5J5ytQJfTXyJbSLc0g6beM03QYuEGvgG0SQAMDJ28TJJEMxAaAsJBpxWqCA1jWIOj3doc4HQKU=
X-Received: by 2002:ac8:44c7:: with SMTP id b7mr24636084qto.170.1567620084987;
 Wed, 04 Sep 2019 11:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190830231817.76862-1-joel@joelfernandes.org>
 <201909041108.RSjNvfDL%lkp@intel.com> <20190904050419.GA102582@google.com> <CAHp75Vdeoc1S_0Dn_vk2ULPRLk_sevWoxs8+Gscv9ki_kkPx4Q@mail.gmail.com>
In-Reply-To: <CAHp75Vdeoc1S_0Dn_vk2ULPRLk_sevWoxs8+Gscv9ki_kkPx4Q@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 4 Sep 2019 14:01:13 -0400
Message-ID: <CAEXW_YQyXSuT9o6pTdMJBM=7xRhUAGtVoteswY5hNcNZBc9bgg@mail.gmail.com>
Subject: Re: [PATCH 1/2] pci: Convert to use built-in RCU list checking
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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

On Wed, Sep 4, 2019 at 1:13 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Sep 4, 2019 at 8:07 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Wed, Sep 04, 2019 at 12:06:43PM +0800, kbuild test robot wrote:
> > > Hi "Joel,
> > >
> > > Thank you for the patch! Yet something to improve:
> > >
> > > [auto build test ERROR on linus/master]
> > > [cannot apply to v5.3-rc7 next-20190903]
> > > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> > >
> > > url:    https://github.com/0day-ci/linux/commits/Joel-Fernandes-Google/pci-Convert-to-use-built-in-RCU-list-checking/20190901-211013
> > > config: x86_64-rhel-7.6 (attached as .config)
> > > compiler: gcc-7 (Debian 7.4.0-11) 7.4.0
> > > reproduce:
> > >         # save the attached .config to linux build tree
> > >         make ARCH=x86_64
> >
> > This error seems bogus. I pulled -next and applied this patch and it builds
> > fine. I am not sure what is wrong with the 0day tree, and the above 0day link
> > is also dead.
> >
> > What's going on with 0day ?!
>
> I would rather to add Depends-on: ... tag to your patch if the
> dependency is going thru another tree at the same cycle.
> kbuildbot absolutely correct here.

The dependency is already in -next and I pulled it and applied the
patch. It is testing -next right?

thanks,

 - Joel
