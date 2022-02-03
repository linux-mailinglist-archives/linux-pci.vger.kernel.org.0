Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009AD4A892D
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 18:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352468AbiBCQ77 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 11:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiBCQ75 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Feb 2022 11:59:57 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA37EC06173B
        for <linux-pci@vger.kernel.org>; Thu,  3 Feb 2022 08:59:57 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id t9so440671plg.13
        for <linux-pci@vger.kernel.org>; Thu, 03 Feb 2022 08:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aLNM0uedgDZUPnFFdk/G6RDrE5HpLbY+y+ugdlzYiAo=;
        b=ZiypM0N61B5ExfM/3S9FFu/uqwvUIZIzMjlKTXTsQRCs8cpjqHp8xd8FBa+lGNg37w
         7oO62QBfGznSGqqbhoZK5cvNlIeb4mRHs134VQEYHaB48K+D2iPTXUzLPI/209Epb4fq
         5MH0udNWP4yiDCrfdEGCCtPcDC5L08RJjvBMHG0HyOeYEg9X7epz443Q9WO9flsco55x
         pUUQyvICdlCZ6hCdAyUg1dDHldgpFudAORJ5Mj+lQwZuVqUNyYAQh7DnmOzo5jVGhswS
         T8798GvGVuC7whHxc1dBZIDfWVT8hU+fNfG6kXDtf+jMYTBMRTHQUOnN9Nvra/RO2rP6
         StjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aLNM0uedgDZUPnFFdk/G6RDrE5HpLbY+y+ugdlzYiAo=;
        b=kM9tllf2mEXT87U69LY5OkLG4yEblqOmdaGsdY/9UlEss0wFEoBH0lC/Ir+pHmpwpr
         ki+59inZPmtpHZFRPfMqUjjUKjXr9I7+/TfUl4x6Y0EYQ70dUTEaGvaaSxBxuIrneQkd
         gm5GTDD84ZuNMnpDPsCFI7cqzAs4xuFOSGIycOPRx1eyERIC5ENfgGIva0Yejwk8p+k4
         /Spsx826y55yMCHO9d+bw+zPnEpqC+XYvhK/48sU5c5zuLNsAOercVAPptfe/zCFlKYY
         zuVimWhwHESHbSJAB2EBNo/D676eS8r9STFEQv5ZUGTYRXerNz1OLHWYi7vkdnDWocvY
         xA0w==
X-Gm-Message-State: AOAM530VjACRGH46jr5YbjBfPVt1wvhwPVbcShPFdRJZaD6bNHfnqDtO
        PGLycTN4hNI6GoGASK1ipQaze8z7TciH31nZfy6kKw==
X-Google-Smtp-Source: ABdhPJzgrxyMBHMvf3i8ye1B/HNShEgJawC1NkUzkgzjFViOioPA5FIlRbLo5ApzFhBycSmhBddHuzg74RaTaEbyb48=
X-Received: by 2002:a17:90a:640e:: with SMTP id g14mr14865235pjj.8.1643907597103;
 Thu, 03 Feb 2022 08:59:57 -0800 (PST)
MIME-Version: 1.0
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298428430.3018233.16409089892707993289.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220131184126.00002a47@Huawei.com> <CAPcyv4iYpj7MH4kKMP57ouHb85GffEmhXPupq5i1mwJwzFXr0w@mail.gmail.com>
 <20220202094437.00003c03@Huawei.com> <CAPcyv4hwdMetDJ-+yL9-2rY92g2C4wWPqpRiQULaX_M6ZQPMtA@mail.gmail.com>
 <20220203094123.000049e6@Huawei.com>
In-Reply-To: <20220203094123.000049e6@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 3 Feb 2022 08:59:44 -0800
Message-ID: <CAPcyv4gJozea7aDg+KyKdwEbSO5PV-rUUGC5u-6NNTHA755etA@mail.gmail.com>
Subject: Re: [PATCH v3 31/40] cxl/memdev: Add numa_node attribute
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 3, 2022 at 1:41 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 2 Feb 2022 07:44:37 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > On Wed, Feb 2, 2022 at 1:45 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Tue, 1 Feb 2022 15:57:10 -0800
> > > Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > > On Mon, Jan 31, 2022 at 10:41 AM Jonathan Cameron
> > > > <Jonathan.Cameron@huawei.com> wrote:
> > > > >
> > > > > On Sun, 23 Jan 2022 16:31:24 -0800
> > > > > Dan Williams <dan.j.williams@intel.com> wrote:
> > > > >
> > > > > > While CXL memory targets will have their own memory target node,
> > > > > > individual memory devices may be affinitized like other PCI devices.
> > > > > > Emit that attribute for memdevs.
> > > > > >
> > > > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > > >
> > > > > Hmm. Is this just duplicating what we can get from
> > > > > the PCI device?  It feels a bit like overkill to have it here
> > > > > as well.
> > > >
> > > > Not all cxl_memdevs are associated with PCI devices.
> > >
> > > Platform devices have numa nodes too...
> >
> > So what's the harm in having a numa_node attribute local to the memdev?
> >
>
> I'm not really against, it just wanted to raise the question of
> whether we want these to go further than the granularity at which
> numa nodes can be assigned.

What is the "granularity at which numa nodes can be assigned"? It
sounds like you are referencing a standard / document, so maybe I
missed something. Certainly Proximity Domains != Linux NUMA nodes so
it's not ACPI.

>  Right now that at platform_device or
> PCI EP (from ACPI anyway).  Sure the value might come from higher
> up a hierarchy but at least in theory it can be assigned to
> individual devices.
>
> This is pushing that description beyond that point so is worth discussing.

To me, any device that presents a driver interface can declare its CPU
affinity with a numa_node leaf attribute. Once you start walking the
device tree to infer the node from parent information you also need to
be worried about whether the Linux device topology follows the NUMA
topology. The leaf attribute removes that ambiguity.
