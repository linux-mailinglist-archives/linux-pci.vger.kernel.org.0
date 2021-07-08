Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271D03C1B37
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jul 2021 23:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhGHVtu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jul 2021 17:49:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231314AbhGHVtu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Jul 2021 17:49:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E7F961606;
        Thu,  8 Jul 2021 21:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625780827;
        bh=mrhrj7r8a/qXiw0M9WJaa1DCHBkLNSRdzlM6SWlPTKE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oXC1SpBo1ZihpDDEULeQAk6w2SDXIHgfxJgsYjq252DCnaUUT30xkukiAfUimCtXc
         BMR4woyeM+Rfd2iwqsrQBBHBN4Z9DEITqKxG6L73lW/gFVxxPEcUCT68YEpg2JXB+l
         5VOi6QrEUCacBgxZl/id89uBAGiL0ocodTd01YmA5eLsrCJU/mNOyWJ0tLjMC7K1Pg
         9dxITECxLSUyGGlO+GMCKNFMEtJZb4/frXQYucndDj9mSlw/INEpUX10Mial7LAX3D
         jDRTmyfx1pjrDE/DW8FBsDyLz4bh8FfIkmvrfhvCkDzvocl6CTHRc7bTglGlbBLbwF
         5AJBC3yoMdehA==
Date:   Thu, 8 Jul 2021 16:47:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>, bjorn@helgaas.com,
        andy@kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH v1] gpio: ml: ioh: Convert to
 dev_pm_ops
Message-ID: <20210708214706.GA1059661@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vfpj+ENMe9u-SMKfvCsyFtOucUT9bD3qfWX+QjccZ9ZyQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pci]

On Thu, Apr 02, 2020 at 11:23:27PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 2, 2020 at 11:16 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Apr 02, 2020 at 09:33:46PM +0300, Andy Shevchenko wrote:
> > > On Thu, Apr 2, 2020 at 6:52 PM Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:
> > > >
> > > > Convert the legacy callback .suspend() and .resume()
> > > > to the generic ones.
> > >
> > > Thank you for the patch.
> > >
> > > Rather then doing this I think the best approach is to unify gpio-pch
> > > and gpio-ml-ioh together.
> > > Under umbrella of the task, the clean ups like above are highly
> > > appreciated.
> >
> > I'd be all in favor of that, but what Vaibhav is working toward is
> > eliminating use of legacy PM in PCI drivers.  I think unifying drivers
> > is really out of scope for that project.
> >
> > If you'd rather leave gpio-ml-ioh.c alone for now, I suggest that
> > Vaibhav move on to other PCI drivers that use legacy PM.  If we
> > convert all the others away from legacy PM and gpio-ml-ioh.c is the
> > only one remaining, then I guess we can revisit this :)
> 
> Then skip this driver for good.
> 
> > Or, maybe converting gpio-ml-ioh.c now, along the lines of
> > 226e6b866d74 ("gpio: pch: Convert to dev_pm_ops"), would be one small
> > step towards the eventual unification, by making gpio-pch and
> > gpio-ml-ioh a little more similar.
> 
> I think it will delay the real work here (very old code motivates
> better to get rid of it then semi-fixed one).

With respect, I think it is unreasonable to use the fact that
gpio-ml-ioh and gpio-pch should be unified to hold up the conversion
of gpio-ml-ioh to generic power management.

I do not want to skip gpio-ml-ioh for good, because it is one of the
few remaining drivers that use the legacy PCI PM interfaces.  We are
very close to being able to remove a significant amount of ugly code
from the PCI core.

gpio-ml-ioh and gpio-pch do look quite similar, and no doubt it would
be great to unify them.  But without datasheets or hardware to test,
that's not a trivial task, and I don't think that burden should fall
on anyone who wants to make any improvements to these drivers.

Another alternative would be to remove legacy PCI PM usage
(ioh_gpio_suspend() and ioh_gpio_resume()) from gpio-ml-ioh.  That
would mean gpio-ml-ioh wouldn't support power management at all, which
isn't a good thing, but maybe it would be even more motivation to
unify it with gpio-pch (which has already been converted by
226e6b866d74 ("gpio: pch: Convert to dev_pm_ops"))?

Bjorn
