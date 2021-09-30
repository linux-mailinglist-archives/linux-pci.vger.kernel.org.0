Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB3541E11B
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 20:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351652AbhI3S1L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 14:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351605AbhI3S1K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Sep 2021 14:27:10 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08619C06176A;
        Thu, 30 Sep 2021 11:25:26 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id k23-20020a17090a591700b001976d2db364so5467390pji.2;
        Thu, 30 Sep 2021 11:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N2396PWWj0KDvLiRCrJymChy6KYkGMfQb2vNthzIeHc=;
        b=h0RgEzclSn5qehouqncGfnvUr2kvD5B8ymJN014kbcvif0XOvf035AvLcI7OxGB7Wi
         +T2hZIAliVQXP/Pto7cEFkcC2TbHHjXNNEWFa+0VjLqLznEEPdLUpGELkelpdSHdziGu
         PR9Y3Kk+ubRjCFaW04GuIFnR3QiXiGmQTCPP1tRJd2OM6WO8E0sd9yeb/ycCZwPO6URf
         pHB17KcY2Mef60Z5J8ldbvtTKMw9+PpRjitkhyZu0x5WP2IjlSx9TsmnAxpjXC8hRK1u
         bH/NujR70pPJPi6EiRLOR9xMOvT3deurL84m1RfifEHWUO0O9EzKSv61NNRyfQ9Z7IqN
         71qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N2396PWWj0KDvLiRCrJymChy6KYkGMfQb2vNthzIeHc=;
        b=Nd0oJ6w8rLGEaLyeke3CSIWeSWmnD4UcN2s/mpmvLBqL3/1/fLF2HAz/46M+fpPmSs
         3omMlDlRnu3SOZgknZxpKmeOozrl0soNWSsefPX1mRGwhc8EcrtG8H+OmBiUCkfWEkvl
         e2HndTdKSBVZwRqx0uBzHpJh6inaJkpTb95HZ83QrDBXqrohvdVjFgEGS1M0IxKZoRne
         2vy58sWfqo+slsbLVIPzSlbrtjlFDg+vbk0C1+rPTadUh0ylvg0ofa5KjmDuLMTIxAHC
         nAln8fIv1mhpggjjpAaC+ykICBE+oOjzsdUzdtfd1kAItemt+IgdhwxWAiWvd9Fdk2zx
         olcw==
X-Gm-Message-State: AOAM530f8azTIvp9ke6pLetANco3/X1akJaiZi5GJqlcQyMsnnZyr9RI
        UT/ZM8VqF7/6q3AbPkLgw2m1rp3Nd0DJvHcjc2E=
X-Google-Smtp-Source: ABdhPJxB7ITN2UeLrgE/pxlmK2TJjJGMaWr28C3aOxo6IVCu9U2mWW7dSCqVawjYefax7AQN/mQOlSLsvWvFSoYOFXU=
X-Received: by 2002:a17:90a:ba86:: with SMTP id t6mr1178246pjr.1.1633026325497;
 Thu, 30 Sep 2021 11:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CA+CmpXtXn5wjxwow5va5u9qHcQDLkd4Sh2dcqB545SXaxV1GkQ@mail.gmail.com> <CAPcyv4iNp41mZcpzGCPR9Xty83j+abk_SOxvsx1xaQ8wALRv0Q@mail.gmail.com>
In-Reply-To: <CAPcyv4iNp41mZcpzGCPR9Xty83j+abk_SOxvsx1xaQ8wALRv0Q@mail.gmail.com>
From:   Yehezkel Bernat <yehezkelshb@gmail.com>
Date:   Thu, 30 Sep 2021 21:25:09 +0300
Message-ID: <CA+CmpXvGCAny-WHGioJQHF9ZZ5pCaR-E_rw5oeE82xC30naVXg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] driver core: Move the "authorized" attribute from
 USB/Thunderbolt to core
To:     Dan Williams <dan.j.williams@intel.com>
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

On Thu, Sep 30, 2021 at 6:28 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Thu, Sep 30, 2021 at 4:20 AM Yehezkel Bernat <yehezkelshb@gmail.com> wrote:
> >
> > On Thu, Sep 30, 2021 at 4:05 AM Kuppuswamy Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> > >
> > > no functional
> > > changes other than value 2 being not visible to the user.
> > >
> >
> > Are we sure we don't break any user-facing tool with it? Tools might use this to
> > "remember" how the device was authorized this time.
>
> That's why it was highlighted in the changelog. Hopefully a
> Thunderbolt developer can confirm if it is a non-issue.
> Documentation/ABI/testing/sysfs-bus-thunderbolt does not seem to
> answer this question about whether authorized_show and
> authorized_store need to be symmetric.

Apparently, Bolt does read it [1] and cares about it [2].

[1] https://gitlab.freedesktop.org/bolt/bolt/-/blob/130e09d1c7ff02c09e4ad1c9c36e9940b68e58d8/boltd/bolt-sysfs.c#L511
[2] https://gitlab.freedesktop.org/bolt/bolt/-/blob/130e09d1c7ff02c09e4ad1c9c36e9940b68e58d8/boltd/bolt-device.c#L639
