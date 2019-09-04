Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39D44A925E
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2019 21:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbfIDTg4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 15:36:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42525 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730686AbfIDTg4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Sep 2019 15:36:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id w22so5481848pfi.9;
        Wed, 04 Sep 2019 12:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wpep2LyOTWtiIBc4HmPe2hGyBzwA/CaDAWU9SYsEWFM=;
        b=bjjXrrvYBE6O1PY9usMoum+IaEdozwCZQqvVUNfmL4QJU4/bSyKusQw74uMW+jdezP
         s2Qhxvoc8zz0hGTnNSeZiCCbaC5VIktLN2eoFhphN3f0+FZ1l2x4tvc+OC5pRbUvogrx
         G47jgvhkJLoN5waJEbyKEPfOc6P2lJSIqpeYUWRigmmp7rhIzi0NlVbdklvZPCXlo8vT
         F81BnBCYMu9nVYMnEiYbvDJCm6cIMJfo7iIX9lq/+T7PHhuGuNRPgR22cxFn4p3AK/rI
         QjhPMaj2UIeLQYXGt5zhoeMIa40zmz56XVfP7Vtr2/vqmOx1Zy3qCe7zT6Kr1/vmwhQt
         03hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wpep2LyOTWtiIBc4HmPe2hGyBzwA/CaDAWU9SYsEWFM=;
        b=Qexc0rwwq9QZyWMoac/NazCOH8lqstkODa6REUWi3sBB0Sij9X07q24774dDbWt/gJ
         yr0GVqticw2NhNxggVl2Q8TGExijaXd6nu+WlmmXn2ETxHSXRrDB9YDiV23VBHupsNTN
         GAqwMt+NzF67VA1LYNFy8IfbVYmo+S0pB7Z6Ea8cxQngq+6fvmBDR7hPE/aY2/hlOfOG
         /+N+tPgzCYYAi9GW1BWfB8VCIvc0OGlujzasu9uutR+0UpOhWl5/foSVBlyzhBixEDet
         tkNEMgeBFNC8NdozZ4z2tn27F6u0Jc5qxoJvjOEygu0/GFjdVNBhEPuI7Yq876qKU58c
         Wf4g==
X-Gm-Message-State: APjAAAWBiqXyLOfHbGhD9O42V4gEC8YHbnjMgaCG7YqscF8nrq4FjXJc
        tv8+f9eNIsWoy0NHXtsiZAl9hd2Ftv78F7Ty+bE=
X-Google-Smtp-Source: APXvYqxGOM8h4zs6M0NDN3CDz20A1GiW6udPDCyH0rOObfk69vEJdPv/8XPStExdnQdvhgxSQl9udO7OimAFT8AhK2A=
X-Received: by 2002:a63:6eca:: with SMTP id j193mr35727925pgc.74.1567625815434;
 Wed, 04 Sep 2019 12:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190830231817.76862-1-joel@joelfernandes.org>
 <201909041108.RSjNvfDL%lkp@intel.com> <20190904050419.GA102582@google.com>
 <CAHp75Vdeoc1S_0Dn_vk2ULPRLk_sevWoxs8+Gscv9ki_kkPx4Q@mail.gmail.com> <CAEXW_YQyXSuT9o6pTdMJBM=7xRhUAGtVoteswY5hNcNZBc9bgg@mail.gmail.com>
In-Reply-To: <CAEXW_YQyXSuT9o6pTdMJBM=7xRhUAGtVoteswY5hNcNZBc9bgg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Sep 2019 22:36:43 +0300
Message-ID: <CAHp75VeyxiamNvLJXDCWOwAP9v264b4KmUL82w2JvYj2EWpkXQ@mail.gmail.com>
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

On Wed, Sep 4, 2019 at 9:01 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> On Wed, Sep 4, 2019 at 1:13 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, Sep 4, 2019 at 8:07 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > On Wed, Sep 04, 2019 at 12:06:43PM +0800, kbuild test robot wrote:

> > > > [auto build test ERROR on linus/master]

^^^ (1)

> > > > [cannot apply to v5.3-rc7 next-20190903]

^^^ (2)


> The dependency is already in -next and I pulled it and applied the
> patch.

This is a problem. You must provide dependency even for maintainers
(in form of immutable branch / tag).
The easier way to provide Depends-on (when it's one patch), though
kbuild bot doesn't support it. Yet?

>  It is testing -next right?

It testing (1) and (2). (it was unable to apply against next by some
reason, but the build error is against latest vanilla failed. And this
is completely correct. Just follow the process (see above).

-- 
With Best Regards,
Andy Shevchenko
