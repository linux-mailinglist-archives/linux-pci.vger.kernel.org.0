Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750983C6670
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jul 2021 00:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhGLWjW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 18:39:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhGLWjW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Jul 2021 18:39:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 303CF61183;
        Mon, 12 Jul 2021 22:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626129393;
        bh=ZLUAxjTwJuR1eoy9AUGR/u9jh4N+I5I/fJ261D+fEQk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HOmcKa4Z9wxBEQ9WYqiglwEhp3GIsvbMPGxKk8yReBkc9xoCypcbo8DSB3XreUBAs
         x/q8pHobaTJlwT2XnfKGKWOSDuDFyfSmy+RKeymJeBo8ZHFgH0CDiriZqFdMOkavis
         TipwjcettlCG9w5QkkFlwwdsQESA5PIIGM82CDaMqfVOoNn17hkXW5+9OaVUhZ4WfL
         txUY8Ocbzw5NSfvRvSb0Pu9L2onlsZxpnSn12qAYxFV17HahRbaWSTqFsMHJTPCow1
         aeJZd718H+PvQAUC07Hb6JoxXv2OCMes/TMU18gflDEcFMcHkYuqX64Hh/qqVBUlbU
         A86c7L4B6Qhcg==
Date:   Mon, 12 Jul 2021 17:36:31 -0500
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
Message-ID: <20210712223631.GA1682719@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOwr/GMIExCoNjeZ@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 12, 2021 at 02:48:12PM +0300, Andy Shevchenko wrote:
> On Thu, Jul 08, 2021 at 04:47:06PM -0500, Bjorn Helgaas wrote:
> > On Thu, Apr 02, 2020 at 11:23:27PM +0300, Andy Shevchenko wrote:
> > > On Thu, Apr 2, 2020 at 11:16 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Thu, Apr 02, 2020 at 09:33:46PM +0300, Andy Shevchenko wrote:
> > > > > On Thu, Apr 2, 2020 at 6:52 PM Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:
> > > > > >
> > > > > > Convert the legacy callback .suspend() and .resume()
> > > > > > to the generic ones.
> > > > >
> > > > > Thank you for the patch.
> > > > >
> > > > > Rather then doing this I think the best approach is to unify gpio-pch
> > > > > and gpio-ml-ioh together.
> > > > > Under umbrella of the task, the clean ups like above are highly
> > > > > appreciated.
> > > >
> > > > I'd be all in favor of that, but what Vaibhav is working toward is
> > > > eliminating use of legacy PM in PCI drivers.  I think unifying drivers
> > > > is really out of scope for that project.
> > > >
> > > > If you'd rather leave gpio-ml-ioh.c alone for now, I suggest that
> > > > Vaibhav move on to other PCI drivers that use legacy PM.  If we
> > > > convert all the others away from legacy PM and gpio-ml-ioh.c is the
> > > > only one remaining, then I guess we can revisit this :)
> > > 
> > > Then skip this driver for good.
> > > 
> > > > Or, maybe converting gpio-ml-ioh.c now, along the lines of
> > > > 226e6b866d74 ("gpio: pch: Convert to dev_pm_ops"), would be one small
> > > > step towards the eventual unification, by making gpio-pch and
> > > > gpio-ml-ioh a little more similar.
> > > 
> > > I think it will delay the real work here (very old code motivates
> > > better to get rid of it then semi-fixed one).
> > 
> > With respect, I think it is unreasonable to use the fact that
> > gpio-ml-ioh and gpio-pch should be unified to hold up the conversion
> > of gpio-ml-ioh to generic power management.
> > 
> > I do not want to skip gpio-ml-ioh for good, because it is one of the
> > few remaining drivers that use the legacy PCI PM interfaces.  We are
> > very close to being able to remove a significant amount of ugly code
> > from the PCI core.
> 
> Makes sense (1).
> 
> > gpio-ml-ioh and gpio-pch do look quite similar, and no doubt it would
> > be great to unify them.  But without datasheets or hardware to test,
> 
> Datasheets are publicly available (at least one may google and find some
> information about those PCH chips). I have in possession the hardware for
> gpio-pch. I can easily test that part at least.

If you have a URL for those datasheets, can you share it?  I spent
some time looking but all I found was 1-2 page marketing brochures.

> > that's not a trivial task, and I don't think that burden should fall
> > on anyone who wants to make any improvements to these drivers.
> 
> > Another alternative would be to remove legacy PCI PM usage
> > (ioh_gpio_suspend() and ioh_gpio_resume()) from gpio-ml-ioh.  That
> > would mean gpio-ml-ioh wouldn't support power management at all, which
> > isn't a good thing, but maybe it would be even more motivation to
> > unify it with gpio-pch (which has already been converted by
> > 226e6b866d74 ("gpio: pch: Convert to dev_pm_ops"))?
> 
> With regard to (1) probably we may exceptionally accept the fix to
> gpio-ml-ioh, but I really prefer to do the much more _useful_ job on
> it by unifying the two.

Should Vaibhav re-post this patch, or do you want to pull it from the
archives?  I just checked and it still applies cleanly to v5.14-rc1.

Here it is for reference:
  https://lore.kernel.org/lkml/20200402155057.30667-1-vaibhavgupta40@gmail.com/

I'll post a couple small patches toward unifying them.  They don't do
the whole job but they're baby steps.

Bjorn
