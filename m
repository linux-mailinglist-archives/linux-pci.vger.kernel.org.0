Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C5A3613BA
	for <lists+linux-pci@lfdr.de>; Thu, 15 Apr 2021 22:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbhDOUyW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Apr 2021 16:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbhDOUyV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Apr 2021 16:54:21 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA3CC061760
        for <linux-pci@vger.kernel.org>; Thu, 15 Apr 2021 13:53:58 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id d21so9603133edv.9
        for <linux-pci@vger.kernel.org>; Thu, 15 Apr 2021 13:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Caxsq6e5w5hQHzn1UKSM5N/N92XMDfAKUSIuBiGg3co=;
        b=jfaruwTDBJhPEKQ+qT+r2RQ5DZYvXkNdItYaLCzE+XzuI8fDE/3egCvAmxAQkQTiOw
         sAnxvqxSejrXWgvGuJEUrtowr3zeumlHpYbymconBrIDs3iMy2OCDXX5CmgfhI5tkUGo
         a1hFFpnj0UxHeaQBM57ny7f+AEJq7JmrLYtxxPlhCO7OhC+t8iy69UlGgQhVHwx6FYgz
         FksTuAQW5dxKrKxOAQhRX3PKSOYbISq/OpQ1catH5/zpedXM2WEZ2aRrwSEhXsTRbYXM
         8fDUp+3DPqm9ap4ufqtakMIIduXVGDM8ns9Ydf2YXQFlFp7scc6yzcg68wKm58YIY1G3
         J7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Caxsq6e5w5hQHzn1UKSM5N/N92XMDfAKUSIuBiGg3co=;
        b=M4bka3vvYKLhfETVnqsLErSL+YDJrRgg4M4jvNQ8WI9+YwZ5EdFy7VjwTvC7bhovR+
         VRglqtBtwEtq/bTXo59FRhm7quCGmVO7jlKQuvMteUbKLZ11GcUjAcbx+WhgNA5aDKhg
         Lc4AU+TozJx+XbDluL5bWt0Ql7xIzevXmv5U/VjaS9+5tQbP+5r4NoE+FGLV7bJl3lj5
         wufxXC7TrGT5ZbV5kgosdsnv114nKNLfDGLKDaBJM7aO18VE4VKWdcTTTj3xrjpS/Wuo
         pDQY8yGK2Kel1V6EnqPjpppxQppYRyKG4pZ7JQxOA0Tg9ld0+emgXZDdjzkmufSv6YI4
         DNHQ==
X-Gm-Message-State: AOAM533ZS+ONm3dLOkbdVygerjXEJa6DG7DQblnTe90I9nqh8fuQampr
        tX/AW5s0qDNggM8frCeafj0mxuE9VI80HxwA1E+dBw==
X-Google-Smtp-Source: ABdhPJwGTnM9gKHfSenuZUu2QdmiM+hPocsH6E5LwiEukrwmUz1IvJmjkAvwkbTmOJyECBXmisr84jGxDwbChsANS1k=
X-Received: by 2002:aa7:cd7b:: with SMTP id ca27mr6607714edb.354.1618520036847;
 Thu, 15 Apr 2021 13:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <161728744224.2474040.12854720917440712854.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161728746354.2474040.14531317270409827157.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210406180017.00000875@Huawei.com>
In-Reply-To: <20210406180017.00000875@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 15 Apr 2021 13:53:45 -0700
Message-ID: <CAPcyv4hmtHscAW14gu_avwXo-TWr2KeGPRubu0eE72UrQrj7pw@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] cxl/core: Refactor CXL register lookup for bridge reuse
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 6, 2021 at 10:47 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 1 Apr 2021 07:31:03 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > While CXL Memory Device endpoints locate the CXL MMIO registers in a PCI
> > BAR, CXL root bridges have their MMIO base address described by platform
> > firmware. Refactor the existing register lookup into a generic facility
> > for endpoints and bridges to share.
> >
> > Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Nice to make the docs kernel-doc, but otherwise this is simple and makes sense
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> > ---
> >  drivers/cxl/core.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  drivers/cxl/cxl.h  |    3 +++
> >  drivers/cxl/mem.c  |   50 +++++-----------------------------------------
> >  3 files changed, 65 insertions(+), 45 deletions(-)
> >
> > diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
> > index 7f8d2034038a..2ab467ef9909 100644
> > --- a/drivers/cxl/core.c
> > +++ b/drivers/cxl/core.c
> > @@ -1,7 +1,8 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> > -/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> > +/* Copyright(c) 2020-2021 Intel Corporation. All rights reserved. */
> >  #include <linux/device.h>
> >  #include <linux/module.h>
> > +#include "cxl.h"
> >
> >  /**
> >   * DOC: cxl core
> > @@ -10,6 +11,60 @@
> >   * point for cross-device interleave coordination through cxl ports.
> >   */
> >
> > +/*
> > + * cxl_setup_device_regs() - Detect CXL Device register blocks
> > + * @dev: Host device of the @base mapping
> > + * @base: mapping of CXL 2.0 8.2.8 CXL Device Register Interface
>
> Not much to add to make this kernel-doc. Just the one missing parameter
> and mark it /**  Given it's exported, it would be nice to tidy that up.

Will do, thanks.
