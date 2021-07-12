Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8233C5BC0
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jul 2021 14:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhGLLvM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 07:51:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:65221 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230364AbhGLLvM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Jul 2021 07:51:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="295611062"
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="295611062"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 04:48:21 -0700
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="561721690"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 04:48:18 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1m2uQ0-00CD4d-KB; Mon, 12 Jul 2021 14:48:12 +0300
Date:   Mon, 12 Jul 2021 14:48:12 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <YOwr/GMIExCoNjeZ@smile.fi.intel.com>
References: <CAHp75Vfpj+ENMe9u-SMKfvCsyFtOucUT9bD3qfWX+QjccZ9ZyQ@mail.gmail.com>
 <20210708214706.GA1059661@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708214706.GA1059661@bjorn-Precision-5520>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 08, 2021 at 04:47:06PM -0500, Bjorn Helgaas wrote:
> On Thu, Apr 02, 2020 at 11:23:27PM +0300, Andy Shevchenko wrote:
> > On Thu, Apr 2, 2020 at 11:16 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Thu, Apr 02, 2020 at 09:33:46PM +0300, Andy Shevchenko wrote:
> > > > On Thu, Apr 2, 2020 at 6:52 PM Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:
> > > > >
> > > > > Convert the legacy callback .suspend() and .resume()
> > > > > to the generic ones.
> > > >
> > > > Thank you for the patch.
> > > >
> > > > Rather then doing this I think the best approach is to unify gpio-pch
> > > > and gpio-ml-ioh together.
> > > > Under umbrella of the task, the clean ups like above are highly
> > > > appreciated.
> > >
> > > I'd be all in favor of that, but what Vaibhav is working toward is
> > > eliminating use of legacy PM in PCI drivers.  I think unifying drivers
> > > is really out of scope for that project.
> > >
> > > If you'd rather leave gpio-ml-ioh.c alone for now, I suggest that
> > > Vaibhav move on to other PCI drivers that use legacy PM.  If we
> > > convert all the others away from legacy PM and gpio-ml-ioh.c is the
> > > only one remaining, then I guess we can revisit this :)
> > 
> > Then skip this driver for good.
> > 
> > > Or, maybe converting gpio-ml-ioh.c now, along the lines of
> > > 226e6b866d74 ("gpio: pch: Convert to dev_pm_ops"), would be one small
> > > step towards the eventual unification, by making gpio-pch and
> > > gpio-ml-ioh a little more similar.
> > 
> > I think it will delay the real work here (very old code motivates
> > better to get rid of it then semi-fixed one).
> 
> With respect, I think it is unreasonable to use the fact that
> gpio-ml-ioh and gpio-pch should be unified to hold up the conversion
> of gpio-ml-ioh to generic power management.
> 
> I do not want to skip gpio-ml-ioh for good, because it is one of the
> few remaining drivers that use the legacy PCI PM interfaces.  We are
> very close to being able to remove a significant amount of ugly code
> from the PCI core.

Makes sense (1).

> gpio-ml-ioh and gpio-pch do look quite similar, and no doubt it would
> be great to unify them.  But without datasheets or hardware to test,

Datasheets are publicly available (at least one may google and find some
information about those PCH chips). I have in possession the hardware for
gpio-pch. I can easily test that part at least.

> that's not a trivial task, and I don't think that burden should fall
> on anyone who wants to make any improvements to these drivers.

> Another alternative would be to remove legacy PCI PM usage
> (ioh_gpio_suspend() and ioh_gpio_resume()) from gpio-ml-ioh.  That
> would mean gpio-ml-ioh wouldn't support power management at all, which
> isn't a good thing, but maybe it would be even more motivation to
> unify it with gpio-pch (which has already been converted by
> 226e6b866d74 ("gpio: pch: Convert to dev_pm_ops"))?

With regard to (1) probably we may exceptionally accept the fix to gpio-ml-ioh,
but I really prefer to do the much more _useful_ job on it by unifying the two.

-- 
With Best Regards,
Andy Shevchenko


