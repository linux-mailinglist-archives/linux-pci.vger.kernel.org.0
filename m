Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0073244D68
	for <lists+linux-pci@lfdr.de>; Fri, 14 Aug 2020 19:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgHNRRb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Aug 2020 13:17:31 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35337 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgHNRRa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Aug 2020 13:17:30 -0400
Received: by mail-oi1-f196.google.com with SMTP id k4so8756348oik.2;
        Fri, 14 Aug 2020 10:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JEPjRYh8Kl+9n+Lri8/V1w42KNmPNTQpqIrD1QsRHsE=;
        b=XOa1A/Qaw2sdmn2/GvRfkhKfGCEdkBLrQ81zGuEjhwuyLhnAXw8GuAH0R2TYd5UHbS
         qzVG/OChRFlt0fjuIJPTW8jKdtWjEm6MybiENIlEEl5dBktgnmOi/+EhHrCAMfePGTLD
         w8zGla3saeXIHucTqnLPzLi4+Ii9Urhx+1vmMHDAK7sa6pXeiseny5hq1LBKX7D1haj4
         q9MWZ0lKynl4LRBBHLYUrOtZAUiZhlbDeWNtoQltBCZBKWJdYju3Kme8QZW+7QCf5Miy
         IEd5kgris4uPMKrz/kaYkET1lXqFF4rqWYvW1U3NsnMFDCzhqfD/h1O+6thbD39kfncq
         mpqQ==
X-Gm-Message-State: AOAM5311JWYonjJA52Cth05JoSO32Dr7Vo94911Hs9SruCgY65CFkjaw
        vw8zWCkHnL/UbCaxm/oGlvTyPn9W+gdO5jFvjjI=
X-Google-Smtp-Source: ABdhPJwpzS3w68ReJWWFC7mK5Vs3vGN0qfG81GoUZLL9J1Ybrb7+dHqt4NrILMWR4JcG4c0exXNETFSEvu9wSRf/X+k=
X-Received: by 2002:aca:a88e:: with SMTP id r136mr2253582oie.110.1597425449673;
 Fri, 14 Aug 2020 10:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200813175729.15088-1-andriy.shevchenko@linux.intel.com>
 <20200813175729.15088-3-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0iDZ6UZK_WW6pvWCqsrUH3uqfjRXSoMDTsAcbXoBuMYqw@mail.gmail.com>
 <20200814153730.GQ1891694@smile.fi.intel.com> <CAJZ5v0jOA30iL6AQq3BEY=N3xQdvpC0BJEcLzz2Frv+CByKhPQ@mail.gmail.com>
 <20200814162105.GX1891694@smile.fi.intel.com>
In-Reply-To: <20200814162105.GX1891694@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Aug 2020 19:17:18 +0200
Message-ID: <CAJZ5v0j_tSuGrEmFb-WYLpjS+AviwQ2zJmHmN-u_MzVAkf7HrA@mail.gmail.com>
Subject: Re: [PATCH v1 3/7] resource: Introduce resource_union() for
 overlapping resources
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 14, 2020 at 6:23 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Aug 14, 2020 at 06:09:53PM +0200, Rafael J. Wysocki wrote:
> > On Fri, Aug 14, 2020 at 5:37 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Aug 14, 2020 at 05:23:07PM +0200, Rafael J. Wysocki wrote:
> > > > On Thu, Aug 13, 2020 at 7:57 PM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
>
> ...
>
> > > > Well, what about using min() and max() here?
> > >
> > > I devoted one paragraph in the commit message to answer this. The kernel.h
> > > (which I'm planning to split at some point) is a monster which brings more pain
> > > than solves here. Note, this is a header file and it's quite clean from
> > > dependencies perspective.
> >
> > But this is code duplication (even if really small) and it is not
> > entirely clean too.
> >
> > Maybe move the definitions of min() and max() to a separate header file?
>
> That is the plan in the kernel.h splitting project. But do you want me to do it
> here? I can try to bring that patch into this series.

Well, ostensibly the purpose of this series is to reduce code
duplication, but if it adds code duplication, that kind of defeats the
purpose IMO.
