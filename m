Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59BA2D7E22
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 19:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbfJORwz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 13:52:55 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41078 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfJORwz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2019 13:52:55 -0400
Received: by mail-ot1-f67.google.com with SMTP id g13so17708036otp.8;
        Tue, 15 Oct 2019 10:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0awkrNAPcXWo+Wm8QfkD5O17YbDc9wlliWJjxDTQPl4=;
        b=A09rzlzGFg3ApjtfQolUx0XxOId8zdCTpVL2fhgTgcmL2qNYTJQ/QAPwTMzYOdBUGL
         hEyn0wRe4hq7oOBqHLpQcDSZtrfPx+RlkUI1S2q4eGu2Z+UI3zKXcs/hT9IImrtprId7
         Rp4GFSbYrFYi/obgIQJuuqA+TwHAQLsdG28Yl5lwKDRjY6VSmop9DGTiWrVCFOnJnz2D
         p6om/04m9zyYrBpV2Y9BnwwCFUE4I1TXwmEED5T+jjItUEFgjFLW38cNPrrc3milLAdE
         f6/cM+AbqwfoRr9557VnAtLKkj6wY9UXpQe0bhpF8OGsOfP83L18r4z5SWWrrfefrWq5
         VgXw==
X-Gm-Message-State: APjAAAUkOenZSVnnQJsYj/klZkQKtFwSn0Lk8ZhvEDW/eOfP5RkASYBZ
        2BvYMylx+pzZDHLvGfSBGj3CvRbmqqeKS23p+qA=
X-Google-Smtp-Source: APXvYqy+z2640pLWXA/n52YLsdwhV9kHXEIfBefEfzEG0gR7AIhD1qLPwhn/HydFH/9RJQz2Qf4j1X31ihVGYH3jcuA=
X-Received: by 2002:a05:6830:1e69:: with SMTP id m9mr1431970otr.262.1571161972801;
 Tue, 15 Oct 2019 10:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191014061355.29072-1-drake@endlessm.com> <20191014154322.GA190693@google.com>
 <CAD8Lp45hmYhrj9v-=7NKrG2YHmxZKFExDsHCL67hap+Y2iM-uw@mail.gmail.com>
In-Reply-To: <CAD8Lp45hmYhrj9v-=7NKrG2YHmxZKFExDsHCL67hap+Y2iM-uw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Oct 2019 19:52:41 +0200
Message-ID: <CAJZ5v0jCh87azmBuhj1T_M+OV8tu7v7Y7WV_zaf56+fxhXU3KQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: increase D3 delay for AMD Ryzen5/7 XHCI controllers
To:     Daniel Drake <drake@endlessm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 15, 2019 at 7:31 AM Daniel Drake <drake@endlessm.com> wrote:
>
> On Mon, Oct 14, 2019 at 11:43 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > Can you tell if this is because the Ryzen7 XHCI controller is out of
> > spec, or is the Linux PCI core missing some delay?  If the latter,
> > fixing the core might fix other devices as well.
> >
> > Mika has this patch:
> > https://lore.kernel.org/r/20190821124519.71594-1-mika.westerberg@linux.intel.com
> > for similar issues, but I think that patch fixes D3cold->D0
> > transitions, and your patch appears to be concerned with D3hot->D0
> > transitions.
>
> It's actually coming out of D3cold here, however what happens right
> before this is that __pci_start_power_transition() calls
> pci_platform_power_transition(D0) to leave D3cold state, then
> pci_update_current_state() reads PMCSR and updates dev->current_state
> to D3hot.

Which pci_update_current_state() do you mean, exactly?

Note that pci_platform_power_transition() itself contains one, which
triggers after a successful change of the ACPI power state of the
device (which should be the case here).

Then, there is one in pci_power_up(), but before that the device's
PMCSR is read from and written to in pci_raw_set_power_state().

It looks like the reads from it after the ACPI power state change are
all successful, but the write isn't unless there is the delay between
it and the former platform_pci_set_power_state().

> The 20ms delay for these XHCI controllers is needed precisely at this
> point - after writing PMCSR to move to D0, and before reading it back
> to check the result.
> I tried moving the delay immediately before writing PMCSR, but that
> doesn't work. Based on that, it seems like it's just a little out of
> spec.

That I agree with and the platform firmware doesn't compensate for
that (which it could do, arguably).
