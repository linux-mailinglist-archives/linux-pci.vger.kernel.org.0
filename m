Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4794041E1F3
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 21:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346222AbhI3TGm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 15:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346175AbhI3TGm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Sep 2021 15:06:42 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F403C06176C
        for <linux-pci@vger.kernel.org>; Thu, 30 Sep 2021 12:04:59 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id pg10so4429281pjb.5
        for <linux-pci@vger.kernel.org>; Thu, 30 Sep 2021 12:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sq8sxX34+Grk9aluOB8rkcRM/zE/YFO/Um/RRIXvef8=;
        b=s/T3WxfqzLIySudeP/owpLxq0XbQ9h42h5F7XrkwCn4prX8sTpXGFoMMBQEd83MEIO
         PqCfeU5PCR/yXXo8r2wkJsenE9iYQW3XUGx9MxaLkqME25QYBbLFpQJYiWOn4hiRACoh
         TJTllOTyNgPfQ7b9UG0eAMROQIsdnsOOQLeGFOHh4nt4wRQ+vrnlctfEQ08G98STFuWP
         qLdkCHCNKhyiGBu0trjL4UwUD50kT9W2dH5iUiz2nPBj+9HEjuN51lacErFVKXtN9JSC
         xcQDxkXyP+/M/tLt4zoE3m/gxpHZUzIDNDdNOIfZ/PDoN/MMbSNvUBl5RG6cxna3nM0m
         Z6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sq8sxX34+Grk9aluOB8rkcRM/zE/YFO/Um/RRIXvef8=;
        b=JuRFR6wKbrsg1X3aGwbMXecaZImP5x7QmBncgHsmxo7hHG191nF54eBLhDlDUyEyTy
         fhldennMP4BQClNqmi5evfdIHOUco0cZEIA+F3uo5TpCsNlYZly5f9xkEAA9nQjpSV1M
         nG5pUbo7BOfxmqgBZrZW8foZ1SplmP9nfA7aOyUlAJl5lefBpw4pLwXAAkdjJdQiPjQB
         nixeJry2rmrdxD2++E1T0EHOpC84wWhriIaEFVBi6Wg6Zr1XI66hlkUvnPAhbWLxT75s
         ZbWCfU1bwdNQlOLKyQvUe+lQDr2Byb5tXVupl3IhH25+hClwpw9yAWoA1nUf8/3Of0Qz
         3maQ==
X-Gm-Message-State: AOAM532xhkTLRa/97l1QGjz6ZzdRTREhfzUXM1Lfs1H30rD3SgSFlVbY
        GkOTHo0+J7YOR4Bd/maXdtDLaqRUXmcjFt+s5HV4CQ==
X-Google-Smtp-Source: ABdhPJzucKENnq7XhWDMviPOqEM8S2r1dBq8hNkP1imn+5HTl7kkb9fVxFNHk9g2RaqssOmOJEEGC/f7665XrQLlAAg=
X-Received: by 2002:a17:90b:3ec3:: with SMTP id rm3mr7268323pjb.93.1633028698606;
 Thu, 30 Sep 2021 12:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CA+CmpXtXn5wjxwow5va5u9qHcQDLkd4Sh2dcqB545SXaxV1GkQ@mail.gmail.com>
 <CAPcyv4iNp41mZcpzGCPR9Xty83j+abk_SOxvsx1xaQ8wALRv0Q@mail.gmail.com> <CA+CmpXvGCAny-WHGioJQHF9ZZ5pCaR-E_rw5oeE82xC30naVXg@mail.gmail.com>
In-Reply-To: <CA+CmpXvGCAny-WHGioJQHF9ZZ5pCaR-E_rw5oeE82xC30naVXg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 30 Sep 2021 12:04:48 -0700
Message-ID: <CAPcyv4ixqiMw1KTB8rbzzrtaErV4PT3R3XqshHhAXv6Ohjzs1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] driver core: Move the "authorized" attribute from
 USB/Thunderbolt to core
To:     Yehezkel Bernat <yehezkelshb@gmail.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Michael Jamet <michael.jamet@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 30, 2021 at 11:25 AM Yehezkel Bernat <yehezkelshb@gmail.com> wrote:
>
> On Thu, Sep 30, 2021 at 6:28 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Thu, Sep 30, 2021 at 4:20 AM Yehezkel Bernat <yehezkelshb@gmail.com> wrote:
> > >
> > > On Thu, Sep 30, 2021 at 4:05 AM Kuppuswamy Sathyanarayanan
> > > <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> > > >
> > > > no functional
> > > > changes other than value 2 being not visible to the user.
> > > >
> > >
> > > Are we sure we don't break any user-facing tool with it? Tools might use this to
> > > "remember" how the device was authorized this time.
> >
> > That's why it was highlighted in the changelog. Hopefully a
> > Thunderbolt developer can confirm if it is a non-issue.
> > Documentation/ABI/testing/sysfs-bus-thunderbolt does not seem to
> > answer this question about whether authorized_show and
> > authorized_store need to be symmetric.
>
> Apparently, Bolt does read it [1] and cares about it [2].

Ah, thank you!

Yeah, looks like the conversion to bool was indeed too hopeful.

>
> [1] https://gitlab.freedesktop.org/bolt/bolt/-/blob/130e09d1c7ff02c09e4ad1c9c36e9940b68e58d8/boltd/bolt-sysfs.c#L511
> [2] https://gitlab.freedesktop.org/bolt/bolt/-/blob/130e09d1c7ff02c09e4ad1c9c36e9940b68e58d8/boltd/bolt-device.c#L639
