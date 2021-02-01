Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A87630AFF0
	for <lists+linux-pci@lfdr.de>; Mon,  1 Feb 2021 20:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhBATCB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Feb 2021 14:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhBATBz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Feb 2021 14:01:55 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B7EC061573
        for <linux-pci@vger.kernel.org>; Mon,  1 Feb 2021 11:01:14 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id q2so5406645edi.4
        for <linux-pci@vger.kernel.org>; Mon, 01 Feb 2021 11:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C4j8R2NWjOWWuVLjBbyJdPlrlZ/j8TvzFIyUEA+Ndu8=;
        b=nyzwIexSmOjDJ+JcSNBcdEk6/yXwTc3YKKDydwVmgfPbkLgTinbZm6+ykK0VQzEtXd
         2FGnsXVks/jQjS4fLAnBKnK11OSqp97qHKPP7ZUqdq9zaUFinHt8zs2HO+5Snar6F84v
         5kZW9qoTEN+59FePDotW3jAP0kx+s2AOE3I3aKrRS257mRb/6+u9GsKidEMKfGro142s
         DWpsafh0uFz0iMyedBmo8mVT7/beWRMM3ciL+gitIiUzkwCc6LH/5iwE8X/spV3q0Kbs
         nPUT/vZZ8B2SFP534Z/VBodBdcFAo7cIr+SWbdYD0ZsBKkAsg8VJmh6BVUYFFwT3Dh2D
         +6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C4j8R2NWjOWWuVLjBbyJdPlrlZ/j8TvzFIyUEA+Ndu8=;
        b=umWv0B5OxLuvg8M7rx3Hg1usgfKI/iRhr9QcfD+wKY5tisrAqyCTOCIfr7YX9WTya2
         wIPk13W6TbmpHTjUwcBlCjIQL0ypT06c65TNjM6SX9fXxzymGgjbZpNMIlREoxz/6o8K
         qHhNmjdc6+oH04RsM8jM9Lf5kf4uRf2ItCjB5k3FjEV7hBu1kIFNCcgdaRND9Ab/CoGY
         oJV/E0JUW9Nw1vVF80Pdp4ElBfL8sVUlp4MQYtrpuw/+lFSEwho7EnbsALYoKEskOCEo
         c7m2rKQnQSOysYTtz3Pts91PHrNiwNqxwxr2ddkA0RFZir+frzkYa6PLMzyGTAHxMd8L
         rxAQ==
X-Gm-Message-State: AOAM532UefywquSxzoEkvsKv8Lmw2hStlxXxlm2iaUnTuOK5DP04U3+f
        2+Hs5OTokG3/4h396hBVLJwh9jt0lOt3kYUCNbDgxg==
X-Google-Smtp-Source: ABdhPJynM6kBjwVDj3TQA0+jvvwTHEb3P0qRRcbLVYHUWU+FzxYi6yyx9m7bmpMHOcX1OWvc84NajYIYsO/BTj6o3/4=
X-Received: by 2002:aa7:cd87:: with SMTP id x7mr21185852edv.210.1612206073657;
 Mon, 01 Feb 2021 11:01:13 -0800 (PST)
MIME-Version: 1.0
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-9-ben.widawsky@intel.com> <20210201181845.GJ197521@fedora>
 <20210201183455.3dndfwyswwvs2dlm@intel.com>
In-Reply-To: <20210201183455.3dndfwyswwvs2dlm@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 1 Feb 2021 11:01:11 -0800
Message-ID: <CAPcyv4iBbA+PCnTg-hFALuDJNqcJrwwXN_gMEe6z9LZvSfC5hw@mail.gmail.com>
Subject: Re: [PATCH 08/14] taint: add taint for direct hardware access
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

On Mon, Feb 1, 2021 at 10:35 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-02-01 13:18:45, Konrad Rzeszutek Wilk wrote:
> > On Fri, Jan 29, 2021 at 04:24:32PM -0800, Ben Widawsky wrote:
> > > For drivers that moderate access to the underlying hardware it is
> > > sometimes desirable to allow userspace to bypass restrictions. Once
> > > userspace has done this, the driver can no longer guarantee the sanctity
> > > of either the OS or the hardware. When in this state, it is helpful for
> > > kernel developers to be made aware (via this taint flag) of this fact
> > > for subsequent bug reports.
> > >
> > > Example usage:
> > > - Hardware xyzzy accepts 2 commands, waldo and fred.
> > > - The xyzzy driver provides an interface for using waldo, but not fred.
> > > - quux is convinced they really need the fred command.
> > > - xyzzy driver allows quux to frob hardware to initiate fred.
> >
> > Would it not be easier to _not_ frob the hardware for fred-operation?
> > Aka not implement it or just disallow in the first place?
>
> Yeah. So the idea is you either are in a transient phase of the command and some
> future kernel will have real support for fred - or a vendor is being short
> sighted and not adding support for fred.
>
> >
> >
> > >   - kernel gets tainted.
> > > - turns out fred command is borked, and scribbles over memory.
> > > - developers laugh while closing quux's subsequent bug report.
> >
> > Yeah good luck with that theory in-the-field. The customer won't
> > care about this and will demand a solution for doing fred-operation.
> >
> > Just easier to not do fred-operation in the first place,no?
>
> The short answer is, in an ideal world you are correct. See nvdimm as an example
> of the real world.
>
> The longer answer. Unless we want to wait until we have all the hardware we're
> ever going to see, it's impossible to have a fully baked, and validated
> interface. The RAW interface is my admission that I make no guarantees about
> being able to provide the perfect interface and giving the power back to the
> hardware vendors and their driver writers.
>
> As an example, suppose a vendor shipped a device with their special vendor
> opcode. They can enable their customers to use that opcode on any driver
> version. That seems pretty powerful and worthwhile to me.
>

Powerful, frightening, and questionably worthwhile when there are
already examples of commands that need extra coordination for whatever
reason. However, I still think the decision tilts towards allowing
this given ongoing spec work.

NVDIMM ended up allowing unfettered vendor passthrough given the lack
of an organizing body to unify vendors. CXL on the other hand appears
to have more gravity to keep vendors honest. A WARN splat with a
taint, and a debugfs knob for the truly problematic commands seems
sufficient protection of system integrity while still following the
Linux ethos of giving system owners enough rope to make their own
decisions.

> Or a more realistic example, we ship a driver that adds a command which is
> totally broken. Customers can utilize the RAW interface until it gets fixed in a
> subsequent release which might be quite a ways out.
>
> I'll say the RAW interface isn't an encouraged usage, but it's one that I expect
> to be needed, and if it's not we can always try to kill it later. If nobody is
> actually using it, nobody will complain, right :D

It might be worthwhile to make RAW support a compile time decision so
that Linux distros can only ship support for the commands the CXL
driver-dev community has blessed, but I'll leave it to a distro
developer to second that approach.
