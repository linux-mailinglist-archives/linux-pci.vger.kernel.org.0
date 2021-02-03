Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF73A30E414
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 21:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhBCUbr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 15:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhBCUbm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Feb 2021 15:31:42 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E86C061573
        for <linux-pci@vger.kernel.org>; Wed,  3 Feb 2021 12:31:01 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id s3so1238438edi.7
        for <linux-pci@vger.kernel.org>; Wed, 03 Feb 2021 12:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GCeEh1pG9896/MM4fasuikkjXXaTHWUxAsa3KXwRezg=;
        b=0La1d6qXruA5buPCLrkx5wbivEiT7/HFmGaUOllSjEMKIyQT9YVkp1RQEyMBYcFT2/
         +Kqv/viUAlMZvMfoMaSpScFMhafTkNCzp07TbEq4BLcp04KfpEd1ziNwQVX0Fo7A8zJV
         csKmRJkMMTBamkqcaMqmV6AV9LHxqpR4K354UTNIs41/nuBY0DFZ+9aX52TWwswXT021
         w5MNoWWPkfRekOFqFP5H8xMSwU5k+xYvcrbB78E31fgGt7B3S/G+nTkTUHZvKbYen+7H
         crT6Gxmq5B69swVwabSJtB9IA5JlUEtmWqc5gKHfQ9URxAxbHzgkL5QXKsK7fkRloi39
         fCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GCeEh1pG9896/MM4fasuikkjXXaTHWUxAsa3KXwRezg=;
        b=ITYRjEn2WgZGIJoTd/9pm1u6jH08ZNwNOJj+D2aBQi1PTwOsnzjD6hX+g2niW9kuWd
         OlNDJ3EDTo0yZ8UOtPFcqq3D+TBB4FHz7kiuhnBuI1bU3bctlnNVpjVKJO67M8INO7yu
         aVnzO3XEuQuxHAQ07lTK4hSAvuAuGJPkktuFDSfx/lwGk51RZEIYZfL8YGvuFzgnvOvi
         jVTPwGHhtDFrHL/SweD//gKrMuqxvDMICdfr8y5wSmz+0u1q5W2z8SzAos6IISgUAlc0
         lOFWPbjHJZAkuFCT4aiDKydb6mdjJ6EK7X6wqPecfxnvXz3D9fQ9snXn1V5xel5Gldo+
         rYgQ==
X-Gm-Message-State: AOAM533RQd2lG/PkGRM5hHS4WPeitK2pxl4wwjmbDa/QTiQyCGqZJM2L
        VBKyuZBnyCFOWYwec53kJMlBVvHBJSnbnr4P0utl0A==
X-Google-Smtp-Source: ABdhPJz5yQvL/w6WuDF2IqOxG58EKzPdmgtRbKd42tGScdcAdslPHYcRzyihZJRMmt2+98+SaW9Insr4XPjglnfKmFQ=
X-Received: by 2002:a05:6402:3585:: with SMTP id y5mr4843766edc.97.1612384260671;
 Wed, 03 Feb 2021 12:31:00 -0800 (PST)
MIME-Version: 1.0
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-14-ben.widawsky@intel.com> <20210201182848.GL197521@fedora>
 <20210202235103.v36v3znh5tsi4g5x@intel.com> <CAPcyv4i3MMY=WExfvcPFYiJkHoM_UeZ63ORZqi0Vbm76JapS8A@mail.gmail.com>
 <20210203171610.2y2x4krijol5dvkk@intel.com> <YBroGrVd76p+BF0v@Konrads-MacBook-Pro.local>
In-Reply-To: <YBroGrVd76p+BF0v@Konrads-MacBook-Pro.local>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 3 Feb 2021 12:31:00 -0800
Message-ID: <CAPcyv4hMM9isho5d8wS=5vtP0NxE5KA0HrMp+Bx2PZhPDrrWsg@mail.gmail.com>
Subject: Re: [PATCH 13/14] cxl/mem: Add limited Get Log command (0401h)
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
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

On Wed, Feb 3, 2021 at 10:16 AM Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>
> On Wed, Feb 03, 2021 at 09:16:10AM -0800, Ben Widawsky wrote:
> > On 21-02-02 15:57:03, Dan Williams wrote:
> > > On Tue, Feb 2, 2021 at 3:51 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > >
> > > > On 21-02-01 13:28:48, Konrad Rzeszutek Wilk wrote:
> > > > > On Fri, Jan 29, 2021 at 04:24:37PM -0800, Ben Widawsky wrote:
> > > > > > The Get Log command returns the actual log entries that are advertised
> > > > > > via the Get Supported Logs command (0400h). CXL device logs are selected
> > > > > > by UUID which is part of the CXL spec. Because the driver tries to
> > > > > > sanitize what is sent to hardware, there becomes a need to restrict the
> > > > > > types of logs which can be accessed by userspace. For example, the
> > > > > > vendor specific log might only be consumable by proprietary, or offline
> > > > > > applications, and therefore a good candidate for userspace.
> > > > > >
> > > > > > The current driver infrastructure does allow basic validation for all
> > > > > > commands, but doesn't inspect any of the payload data. Along with Get
> > > > > > Log support comes new infrastructure to add a hook for payload
> > > > > > validation. This infrastructure is used to filter out the CEL UUID,
> > > > > > which the userspace driver doesn't have business knowing, and taints on
> > > > > > invalid UUIDs being sent to hardware.
> > > > >
> > > > > Perhaps a better option is to reject invalid UUIDs?
> > > > >
> > > > > And if you really really want to use invalid UUIDs then:
> > > > >
> > > > > 1) Make that code wrapped in CONFIG_CXL_DEBUG_THIS_IS_GOING_TO..?
> > > > >
> > > > > 2) Wrap it with lockdown code so that you can't do this at all
> > > > >    when in LOCKDOWN_INTEGRITY or such?
> > > > >
> > > >
> > > > The commit message needs update btw as CEL is allowed in the latest rev of the
> > > > patches.
> > > >
> > > > We could potentially combine this with the now added (in a branch) CONFIG_RAW
> > > > config option. Indeed I think that makes sense. Dan, thoughts?
> > >
> > > Yeah, unknown UUIDs blocking is the same risk as raw commands as a
> > > vendor can trigger any behavior they want. A "CONFIG_RAW depends on
> > > !CONFIG_INTEGRITY" policy sounds reasonable as well.
> >
> > What about LOCKDOWN_NONE though? I think we need something runtime for this.
> >
> > Can we summarize the CONFIG options here?
> >
> > CXL_MEM_INSECURE_DEBUG // no change
> > CXL_MEM_RAW_COMMANDS // if !security_locked_down(LOCKDOWN_NONE)
> >
> > bool cxl_unsafe()
>
> Would it be better if this inverted? Aka cxl_safe()..
> ?
> > {
> > #ifndef CXL_MEM_RAW_COMMANDS

nit use IS_ENABLED() if this function lives in a C file, or provide
whole alternate static inline versions in a header gated by ifdefs.

> >       return false;
> > #else
> >       return !security_locked_down(LOCKDOWN_NONE);
>
> :thumbsup:
>
> (Naturally this would inverted if this was cxl_safe()).
>
>
> > #endif
> > }
> >
> > ---
> >
> > Did I get that right?
>
> :nods:

Looks good which means it's time to bikeshed the naming. I'd call it
cxl_raw_allowed(). As "safety" isn't the only reason for blocking raw,
it's also to corral the userspace api. I.e. things like enforcing
security passphrase material through the Linux keys api.
