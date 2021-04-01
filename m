Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226D33519AE
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 20:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbhDARz5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 13:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236050AbhDARtT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 13:49:19 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45371C08EC72;
        Thu,  1 Apr 2021 06:50:06 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id v25so1834842oic.5;
        Thu, 01 Apr 2021 06:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=obPyz+e6xbd7We+KsT9T0ixM5UyYHDGjsKl1W8VAD1Q=;
        b=Y9k5poOP2aOMcOVYyJPVznKH3uA/mv6KRYy9/7o9IOuHXs/S70YSMRN8YaCVA18RgO
         M8jAKe/MCXxMqG9exZ6lEGmPiiV6euSGm8shFEeCVjLJCw2p+RmoUlb5nmGhcBy0bV9B
         QtGJSCcv9Q/xtcwLTDXBIipVHZ5KE+5KThBbu5Ybs+9KZzY/kl+OMd1j2wLqOlt35ZNz
         1JJ3UZhlIOXxHO6PoNW9cd6DB2CfCl147jhLLvxJ4/PG79CkzZo7Yj9uOp5w9Tn7CP+F
         K1zmyRN1tUN93lXq4VWA+hTTRMr/WHKHTuRpN18nYEeh651fSyTbBcWlbBZQzakHrwxv
         8uMw==
X-Gm-Message-State: AOAM533OzpDdy1cg3P5X66oDfyLfpFs7zIBMLBRwFMML7w7WREVy5F6d
        VEf2FF5QtymYQ9pCgzoBzeoz4+SrESrcvoeEX1M=
X-Google-Smtp-Source: ABdhPJwyQVp4oAnnyAvoO1xmI2F+tkbmp4RWiyGqaSVTQUrfQWAgb31mo8zgnybKLFuYB5swwjP5Geu1Q8ZqMJofj5k=
X-Received: by 2002:aca:5fc3:: with SMTP id t186mr5819440oib.69.1617285005595;
 Thu, 01 Apr 2021 06:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <e0d626837e577e60f226b8bbf354bd8cbb1fe40a.camel@intel.com>
 <20210331172210.GA1397554@bjorn-Precision-5520> <100f5a45dae14c77b341b7f1c5ea1db0@AcuMS.aculab.com>
In-Reply-To: <100f5a45dae14c77b341b7f1c5ea1db0@AcuMS.aculab.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 1 Apr 2021 15:49:52 +0200
Message-ID: <CAJZ5v0jJ2XDYSwqP3AyKuUvuxhwuNwvk3Z=xwtAL3hG5uYGG-Q@mail.gmail.com>
Subject: Re: [PATCH v2 04/15] ACPI: table: replace __attribute__((packed)) by __packed
To:     David Laight <David.Laight@aculab.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 1, 2021 at 11:00 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Bjorn Helgaas
> > Sent: 31 March 2021 18:22
> >
> > On Wed, Mar 31, 2021 at 11:55:08PM +0800, Zhang Rui wrote:
> > > ...
> >
> > > From e18c942855e2f51e814d057fff4dd951cd0d0907 Mon Sep 17 00:00:00 2001
> > > From: Zhang Rui <rui.zhang@intel.com>
> > > Date: Wed, 31 Mar 2021 20:34:13 +0800
> > > Subject: [PATCH] ACPI: tables: FPDT: Fix 64bit alignment issue
> > >
> > > Some of the 64bit items in FPDT table may be 32bit aligned.
> > > Using __attribute__((packed)) is not needed in this case, fixing it by
> > > allowing 32bit alignment for these 64bit items.
> >
> > 1) Can you please add a spec reference for this?  I think it's ACPI
> >    v6.3, sec 5.2.23.5, or something close to that.
> >
> > 2) The exact layout in memory is prescribed by the spec.  I think
> >    that's basically what "packed" accomplishes.  I don't understand
> >    why using "aligned" would be preferable.  Using "aligned" means
> >    things can be at different offsets depending on the starting
> >    address of the structure.  We always want the identical layout, no
> >    matter what the starting address is.
>
> Both 'packed' and 'aligned(4)' remove any structure alignment
> padding before 64bit items that aren't on an 8 byte boundary.
> (Because everything else in the structures is naturally aligned.)
>
> The difference is significant on cpu that don't support misaligned
> addresses.
> Assuming that the structure is always on a 4n byte boundary
> (which the ACPI spec probably requires) accesses to the 32-bit
> fields are always ok.
> It is only 64-bit fields that must be accessed as two 32-bit
> memory cycles, not all the fields using multiple single byte
> cycles.

So what exactly is wrong with using "packed"?  It is way easier to
understand for a casual reader of the code.
