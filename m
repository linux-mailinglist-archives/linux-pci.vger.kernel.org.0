Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C6530B260
	for <lists+linux-pci@lfdr.de>; Mon,  1 Feb 2021 22:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhBAV4G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Feb 2021 16:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhBAV4E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Feb 2021 16:56:04 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB36C0613ED
        for <linux-pci@vger.kernel.org>; Mon,  1 Feb 2021 13:55:24 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id w1so26710629ejf.11
        for <linux-pci@vger.kernel.org>; Mon, 01 Feb 2021 13:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RZDofSxjQfRvCD9og+/lS0h09No2LY/OIRXR8uXND+Y=;
        b=n/z8H83/8L7uutAMt7vBH/0PM6mOT4y6pk0N26xWUl6K+PVgCDp+YXxmyzAL/MNeYh
         FhyEJ+t3PDTgPqvNYAwrmu/2KJ3RSWWl25QxaeD/NM47uE2zcoMu8RcyoSL8izErXY6l
         E3EJtJY7XxeoodByW/FBN5conQMjdj+7X+ZWMb1sp1jVzYgjowklKOspBFlhffuWjaUF
         k1lqgo0WuzZ8ko2jjsDPMOV1KCcBrq7Nvugt5PiU7GKEa+IweAe0Eyy2Ee1Y28XzLmQf
         LczqNPRsAkEeW5JyJaL57yMfWD/dMourQswAGFX+THDobxnkQn4fgT0unLYSJSgoQfCN
         Owbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RZDofSxjQfRvCD9og+/lS0h09No2LY/OIRXR8uXND+Y=;
        b=bnKm67Brtqtp/DsckGqo/tkjh2V7dCXAtUf9jBYNgDMwMy33chkdJjXgf6NIRCLQiy
         yebk5snA66ONvn19eWr+qOFT8VIHDRfDa0c3Utc8MYMTBzxGnwBdGRc8nMTAUq3ZaxmW
         jUm8omIYAXHxqL7sDYHj+22C3mnZYAzDXmsuDyRDS+r2ch9z1BmMPOmI15aHqXW7CMf4
         iQGjGx81mq5xoqg3y2YogmtPer1kxP6ZpIEHo2MPnBzFoZrCmoG6oN/2iGccjiQ1hBxb
         nZaeWhaJ5Zr/hY1Q0519xN+tblUrJI2cMWNSTlMwasZYashNbVaP11hy4XahYlMwOWRA
         OoMQ==
X-Gm-Message-State: AOAM532FNwXH1IFs86N1sYqk45rj47pA7jgL6qZ2a9lBB8lHYrykknv5
        NxJWlca7NlSMeP499ijESAsPgu6BgthFVCNuSegsXA==
X-Google-Smtp-Source: ABdhPJyxAL1XKv5D2YhZQKaxNMuYpOLaoo1o74ufOqhfWO37NIhZqqr71tGZugmaHwjESA7U8g36q/2EI+yerB5qhlw=
X-Received: by 2002:a17:906:f919:: with SMTP id lc25mr20233700ejb.323.1612216523281;
 Mon, 01 Feb 2021 13:55:23 -0800 (PST)
MIME-Version: 1.0
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-6-ben.widawsky@intel.com> <ecd93422-b272-2b76-1ec-cf6af744ae@google.com>
 <20210201171051.m3cbr3udczxwghqh@intel.com> <4d62a125-91e1-d32-66d3-1216d751f9b8@google.com>
In-Reply-To: <4d62a125-91e1-d32-66d3-1216d751f9b8@google.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 1 Feb 2021 13:55:20 -0800
Message-ID: <CAPcyv4jCsv-5TpOFtc6zNG5y4ZSRBnXOuurMx-hkm7AhYZ2b+g@mail.gmail.com>
Subject: Re: [PATCH 05/14] cxl/mem: Register CXL memX devices
To:     David Rientjes <rientjes@google.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 1, 2021 at 1:53 PM David Rientjes <rientjes@google.com> wrote:
>
> On Mon, 1 Feb 2021, Ben Widawsky wrote:
>
> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > > > new file mode 100644
> > > > index 000000000000..fe7b87eba988
> > > > --- /dev/null
> > > > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > > > @@ -0,0 +1,26 @@
> > > > +What:            /sys/bus/cxl/devices/memX/firmware_version
> > > > +Date:            December, 2020
> > > > +KernelVersion:   v5.12
> > > > +Contact: linux-cxl@vger.kernel.org
> > > > +Description:
> > > > +         (RO) "FW Revision" string as reported by the Identify
> > > > +         Memory Device Output Payload in the CXL-2.0
> > > > +         specification.
> > > > +
> > > > +What:            /sys/bus/cxl/devices/memX/ram/size
> > > > +Date:            December, 2020
> > > > +KernelVersion:   v5.12
> > > > +Contact: linux-cxl@vger.kernel.org
> > > > +Description:
> > > > +         (RO) "Volatile Only Capacity" as reported by the
> > > > +         Identify Memory Device Output Payload in the CXL-2.0
> > > > +         specification.
> > > > +
> > > > +What:            /sys/bus/cxl/devices/memX/pmem/size
> > > > +Date:            December, 2020
> > > > +KernelVersion:   v5.12
> > > > +Contact: linux-cxl@vger.kernel.org
> > > > +Description:
> > > > +         (RO) "Persistent Only Capacity" as reported by the
> > > > +         Identify Memory Device Output Payload in the CXL-2.0
> > > > +         specification.
> > >
> > > Aren't volatile and persistent capacities expressed in multiples of 256MB?
> >
> > As of the spec today, volatile and persistent capacities are required to be
> > in multiples of 256MB, however, future specs may not have such a requirement and
> > I think keeping sysfs ABI easily forward portable makes sense.
> >
>
> Makes sense, can we add that these are expressed in bytes or is that
> already implied?

Makes sense to declare units here.
