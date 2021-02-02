Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F3C30D012
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 00:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhBBX5w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 18:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbhBBX5q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Feb 2021 18:57:46 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F0FC0613ED
        for <linux-pci@vger.kernel.org>; Tue,  2 Feb 2021 15:57:06 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id lg21so5436968ejb.3
        for <linux-pci@vger.kernel.org>; Tue, 02 Feb 2021 15:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ei7hzPsgvHgxY53PqUfsTxtC6XeuV2PKdJfigEzcdI=;
        b=mzBF5mEs8+7DFtT3HTRtRwBqdt+He1ge0SMWWG8XkrU4j3buin9RWxFI80NU1dbq/R
         /WLbqer0SbWlVjMvaJu8gx57DMPD9tzGQQF+a3hKcNHSjouwn82qB4ZWZcmbSuMgp9QE
         9S6NwSapDuZl2RcO5BNqKzDgJeGii59VEjCP8ylXYrcdeS2mK8609qBkeYKPEA85A/XM
         3Rd5vrV43Hxg2OmRr6UcKmh+9goio20mf2HCQz2M2p0H1sRaYgxs3Q/lCUojUG+I8kWT
         pxnhEpwitUxifLzlm2ksMzc+MnXqrZGtV0guUtXY0v4eLpikf6uL5iOMNfwyslLvg+36
         Ztvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ei7hzPsgvHgxY53PqUfsTxtC6XeuV2PKdJfigEzcdI=;
        b=P1fkEj3HQAz08EYxVRi371pGm8bnZqJulFaMqG79qEqu3FpePR+u0+LJg7Wa+3YHxI
         KSoXoabD/5ip6fqGgfDXwzuYW9wWRsEA8RraC2g8wZQKVqrcww06ldBhquPZC+7euZ63
         5nS/UpY1+So1EXxTyRB3DoYKV/nBOtuDvAtSs6GjHrj3J0CGZk/S2qHqHlk0AB+F9rhX
         GHcAvEPINL8XsMJEvrSQvw4OultHihyyb1FQ6dC568zJExYqQdixZmB0Of1seGKECwAc
         akQ2HXw7KTa1odcGFTkTfaAcgSheuCwj+/fbmdGNKaR41NROireJKEwbrWVNjtAQjPpJ
         FYvg==
X-Gm-Message-State: AOAM531avyHwRjq56LyK1ddoTi0SeyKnjOKb8aX0YabMPVfKjqqjXUV/
        waodyFSwvvbSLxZ+Id6MvqaBvSq4hY6wtXsEeg7NSQ==
X-Google-Smtp-Source: ABdhPJzuqtFYxd9D7t5y31bMs8ikTlJEE9y04BxTxSW9gyQdaL5YEXOIHpBRxrY3j9MA0Fe049i291NZnJ64txyck0M=
X-Received: by 2002:a17:906:d8a1:: with SMTP id qc1mr440588ejb.523.1612310224889;
 Tue, 02 Feb 2021 15:57:04 -0800 (PST)
MIME-Version: 1.0
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-14-ben.widawsky@intel.com> <20210201182848.GL197521@fedora>
 <20210202235103.v36v3znh5tsi4g5x@intel.com>
In-Reply-To: <20210202235103.v36v3znh5tsi4g5x@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 2 Feb 2021 15:57:03 -0800
Message-ID: <CAPcyv4i3MMY=WExfvcPFYiJkHoM_UeZ63ORZqi0Vbm76JapS8A@mail.gmail.com>
Subject: Re: [PATCH 13/14] cxl/mem: Add limited Get Log command (0401h)
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-cxl@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>,
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

On Tue, Feb 2, 2021 at 3:51 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-02-01 13:28:48, Konrad Rzeszutek Wilk wrote:
> > On Fri, Jan 29, 2021 at 04:24:37PM -0800, Ben Widawsky wrote:
> > > The Get Log command returns the actual log entries that are advertised
> > > via the Get Supported Logs command (0400h). CXL device logs are selected
> > > by UUID which is part of the CXL spec. Because the driver tries to
> > > sanitize what is sent to hardware, there becomes a need to restrict the
> > > types of logs which can be accessed by userspace. For example, the
> > > vendor specific log might only be consumable by proprietary, or offline
> > > applications, and therefore a good candidate for userspace.
> > >
> > > The current driver infrastructure does allow basic validation for all
> > > commands, but doesn't inspect any of the payload data. Along with Get
> > > Log support comes new infrastructure to add a hook for payload
> > > validation. This infrastructure is used to filter out the CEL UUID,
> > > which the userspace driver doesn't have business knowing, and taints on
> > > invalid UUIDs being sent to hardware.
> >
> > Perhaps a better option is to reject invalid UUIDs?
> >
> > And if you really really want to use invalid UUIDs then:
> >
> > 1) Make that code wrapped in CONFIG_CXL_DEBUG_THIS_IS_GOING_TO..?
> >
> > 2) Wrap it with lockdown code so that you can't do this at all
> >    when in LOCKDOWN_INTEGRITY or such?
> >
>
> The commit message needs update btw as CEL is allowed in the latest rev of the
> patches.
>
> We could potentially combine this with the now added (in a branch) CONFIG_RAW
> config option. Indeed I think that makes sense. Dan, thoughts?

Yeah, unknown UUIDs blocking is the same risk as raw commands as a
vendor can trigger any behavior they want. A "CONFIG_RAW depends on
!CONFIG_INTEGRITY" policy sounds reasonable as well.
