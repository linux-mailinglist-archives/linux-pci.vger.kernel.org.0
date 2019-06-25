Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6BB6556B4
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 20:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfFYSEG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 14:04:06 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38732 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfFYSEG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jun 2019 14:04:06 -0400
Received: by mail-oi1-f195.google.com with SMTP id v186so13245127oie.5
        for <linux-pci@vger.kernel.org>; Tue, 25 Jun 2019 11:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v+ZhBSNWMG71/hoVLbHT+wkJMxkbtm8D8gJnUatkLjU=;
        b=JxNg8q13dPoy4++bWTLKe91YyHwlNjFnbzSb9Om/uZZjmzDhnDweJK+SXVAHxvQJR0
         312VGhMneNMNXAmSV6hMRZIzT4bIOEkHXQoVC3M4u9DoF+fAlTSvPDyjEiVH1eTZKAv6
         dp2nCpruoX6QC/iIKdTTjv2kOKKIAnLDyxY0m5z6y8S0clG2ID2Kd3dCyQI6rh541kFT
         eDdVfoEDrUI7YN4BuqjchbcpiBzhNte5u19MgaVZHdA1NCRepz4PjjVsuhg3X5n+bs85
         X+HfBTjHRFVQoAtJFMiji2LpwQIjXK1seUAZDPl9j1P4iwnhlcEX3jRF05VVFomoae2Q
         6U5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v+ZhBSNWMG71/hoVLbHT+wkJMxkbtm8D8gJnUatkLjU=;
        b=BqzrGtn8ixPXNylw3gR3KbibLucv4wBzu7AtUzivWlmimXCl9eCgNH5V824qLZoeOb
         bxv2agzU1L5yMfRuILF80lqzqMt2PUEVFE3K+9ZgY6BdhicxMLaGJOE9QpGpQA8mcf94
         SkCYco2mOBwP6Bk++bc2fjBA5dI29EbKDPKeV5oKzr4c0eOLfqOPI+vPsLKdiEnsrZtf
         hoVpC8GLFAOF08duIk6t2bO8PCzjqV2bD8mJSBoxUFiIy8ZXbzHR6becgizLs3LPmCcH
         glQ7Qojijtzfav+WxYauJ3wCiu7QWPR7b92wDvKk3bf29wb5ILpwnF0i2+jlovy8OWNV
         YCsg==
X-Gm-Message-State: APjAAAWFvDUv744i/gCC3YY7sdqMZdQLGj5v1rjxXFq3E9xAFzUk/2Qd
        qYPvIIfvAYiYJthJm/wRDHUeniNKMAEqN/JSbic15g==
X-Google-Smtp-Source: APXvYqz6T9TVXWGjVm88Qsyic/J7sZ8rY/3bbGIhMBzOCJnst1XOiiw6CA8iBdJBDNkwj6/NRoOe4+QnfOGQ8i6wx08=
X-Received: by 2002:aca:d60c:: with SMTP id n12mr15532591oig.105.1561485845899;
 Tue, 25 Jun 2019 11:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190613094326.24093-1-hch@lst.de> <20190613094326.24093-6-hch@lst.de>
 <20190620191733.GH12083@dhcp22.suse.cz> <CAPcyv4h9+Ha4FVrvDAe-YAr1wBOjc4yi7CAzVuASv=JCxPcFaw@mail.gmail.com>
 <20190625072317.GC30350@lst.de> <20190625150053.GJ11400@dhcp22.suse.cz>
In-Reply-To: <20190625150053.GJ11400@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 25 Jun 2019 11:03:53 -0700
Message-ID: <CAPcyv4j1e5dbBHnc+wmtsNUyFbMK_98WxHNwuD_Vxo4dX9Ce=Q@mail.gmail.com>
Subject: Re: [PATCH 05/22] mm: export alloc_pages_vma
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, Linux MM <linux-mm@kvack.org>,
        nouveau@lists.freedesktop.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 25, 2019 at 8:01 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 25-06-19 09:23:17, Christoph Hellwig wrote:
> > On Mon, Jun 24, 2019 at 11:24:48AM -0700, Dan Williams wrote:
> > > I asked for this simply because it was not exported historically. In
> > > general I want to establish explicit export-type criteria so the
> > > community can spend less time debating when to use EXPORT_SYMBOL_GPL
> > > [1].
> > >
> > > The thought in this instance is that it is not historically exported
> > > to modules and it is safer from a maintenance perspective to start
> > > with GPL-only for new symbols in case we don't want to maintain that
> > > interface long-term for out-of-tree modules.
> > >
> > > Yes, we always reserve the right to remove / change interfaces
> > > regardless of the export type, but history has shown that external
> > > pressure to keep an interface stable (contrary to
> > > Documentation/process/stable-api-nonsense.rst) tends to be less for
> > > GPL-only exports.
> >
> > Fully agreed.  In the end the decision is with the MM maintainers,
> > though, although I'd prefer to keep it as in this series.
>
> I am sorry but I am not really convinced by the above reasoning wrt. to
> the allocator API and it has been a subject of many changes over time. I
> do not remember a single case where we would be bending the allocator
> API because of external modules and I am pretty sure we will push back
> heavily if that was the case in the future.

This seems to say that you have no direct experience of dealing with
changing symbols that that a prominent out-of-tree module needs? GPU
drivers and the core-mm are on a path to increase their cooperation on
memory management mechanisms over time, and symbol export changes for
out-of-tree GPU drivers have been a significant source of friction in
the past.

> So in this particular case I would go with consistency and export the
> same way we do with other functions. Also we do not want people to
> reinvent this API and screw that like we have seen in other cases when
> external modules try reimplement core functionality themselves.

Consistency is a weak argument when the cost to the upstream community
is negligible. If the same functionality was available via another /
already exported interface *that* would be an argument to maintain the
existing export policy. "Consistency" in and of itself is not a
precedent we can use more widely in default export-type decisions.

Effectively I'm arguing EXPORT_SYMBOL_GPL by default with a later
decision to drop the _GPL. Similar to how we are careful to mark sysfs
interfaces in Documentation/ABI/ that we are not fully committed to
maintaining over time, or are otherwise so new that there is not yet a
good read on whether they can be made permanent.
