Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054022A3EF1
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 09:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgKCIbx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 03:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgKCIbx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Nov 2020 03:31:53 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F332DC0613D1;
        Tue,  3 Nov 2020 00:31:52 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id t14so13134061pgg.1;
        Tue, 03 Nov 2020 00:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/kEY1+Wj4A6o2via5YD8DTFuwW8aYbCWHvyBUYczxyg=;
        b=VFZn8Hhkb9g0pPcbEpPnVX7+bVcBTpVBNC/dVwV/dUloVWtnrJhpkJN63u4OzmmPgx
         48jrVTvhagESHhLKaMduc2S48zgCiomBBZCDVt/fNxD+52Nn/ehai1eC3Vz1wayGwTSO
         NrLUojetzUJWId0qaW3Y14D2bZAakPhz/FYSROpsX3faiUwRSjniU8LO6wvJaozgq16B
         ai3CFhFqqKTwTbRD0KSjEWy+uuJpCed2EjiGEbdDQ5E9thHWIYtDHoF14obDdHayCRZb
         GnJL8kV7sMoYaW1BNXsb1uPRR+FiNi03nvG/c6rrYJduddija3ET+Sz8xlhcUGJF7FOS
         96tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/kEY1+Wj4A6o2via5YD8DTFuwW8aYbCWHvyBUYczxyg=;
        b=ZzhTMMscQfInpUCQVH3yoqQu3rur49PR/ZQRtcchgG8HE//gJlUzmWXNeBWAJtCy6L
         X+WSenjbA6BxYh9uKjISp1eXzR7w10x4qpoHB7P4Gt/FhNCdLRFqiiLjjZ53sOMIRyNM
         uDbSBc3gW+f9j/G7CU5x0TTVdScQmz2I5YzPnsPYPzWwkRgNH0bA9TgabBv8DhFoiJ6h
         XxX+3O1aEtWPvI0Ba19mI4/DenUjcke6J/72cjYM2mpUsNM8azktF/wY1vy/1mN+ZeM9
         +vzIQBQ8xZYjbTEpiRC5bJGWTCyGg7LAzSBRkUx+WKpKU2tJC0JTPqHS3lQm7mNAEhfq
         lpnA==
X-Gm-Message-State: AOAM5314alIwDOyQ7DCXap0EcJuUPKUMC0BHqcCeGN+WcpwcNwALi0cM
        JyFeqfaFNtHiQ4nTzkQjDGaXiyy8BvnyGUmaZ2E=
X-Google-Smtp-Source: ABdhPJwU3V9Gc2nWQl0z8vKa34dAV2EusTcDpth7i6ltJhtb21Yk9PSO0eAyVduM1DlM80X8w6rXexeXvN1IKFgBN70=
X-Received: by 2002:a17:90a:430b:: with SMTP id q11mr2672605pjg.129.1604392312516;
 Tue, 03 Nov 2020 00:31:52 -0800 (PST)
MIME-Version: 1.0
References: <20201102210025.53520-1-andriy.shevchenko@linux.intel.com> <1183267b-3e90-ab71-b1f6-7760ad0ca57c@huawei.com>
In-Reply-To: <1183267b-3e90-ab71-b1f6-7760ad0ca57c@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 3 Nov 2020 10:31:36 +0200
Message-ID: <CAHp75VcEhdmU6NW8Dn-r7Aipden7vYda72nP3_LW09+jTFxOBg@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] resource: introduce union(), intersection() API
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 3, 2020 at 2:46 AM Hanjun Guo <guohanjun@huawei.com> wrote:
>
> On 2020/11/3 5:00, Andy Shevchenko wrote:
> > Some users may want to use resource library to manage their own resources,
> > besides existing users that open code union() and intersection()
> > implementations.
> >
> > Provide a generic API for wider use.
> >
> > Changelog v4:
> > - added Rb tag (Rafael)
> > - Cc'ed to LKML and Greg (Rafael)
> >
> > Changelog v3:
> > - rebased on top of v5.10-rc1
> > - dropped upstreamed dependencies
> > - added Rb tag to the last patch (Mika)
> >
> > Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: linux-pci@vger.kernel.org
> >
> > Andy Shevchenko (6):
> >    resource: Simplify region_intersects() by reducing conditionals
> >    resource: Group resource_overlaps() with other inline helpers
> >    resource: Introduce resource_union() for overlapping resources
> >    resource: Introduce resource_intersection() for overlapping resources
> >    PCI/ACPI: Replace open coded variant of resource_union()
> >    ACPI: watchdog: Replace open coded variant of resource_union()
> >
> >   drivers/acpi/acpi_watchdog.c |  6 +-----
> >   drivers/acpi/pci_root.c      |  4 +---
> >   include/linux/ioport.h       | 34 +++++++++++++++++++++++++++-------
> >   kernel/resource.c            | 10 +++++-----
> >   4 files changed, 34 insertions(+), 20 deletions(-)
>
> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks. Is it for the entire series?


-- 
With Best Regards,
Andy Shevchenko
