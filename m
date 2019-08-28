Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 008899FD5B
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 10:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfH1Inm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 04:43:42 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45165 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfH1Inl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 04:43:41 -0400
Received: by mail-oi1-f194.google.com with SMTP id v12so1445289oic.12;
        Wed, 28 Aug 2019 01:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f7pUEqpS8XYSbhqXawr72tizr49QR8+07pZyNaAucJk=;
        b=Ea9oKdXRwvhnPpNGeICKXlctfcq3JpqpnUO8M4IbeR/Mo7I8XfTZoPwLa1lxwBevkh
         hXTDlmi09BTENNAAzLc2rT1ypqenKPWDZUFoC42E9xgs8eO2k5zq1onocfXrsfcZL4qU
         LO+K7sLb8nhwerMKRrax9iYTVihYQnt42WaCRXGx5wjgQGSNfKKhSDMxWYYm+YihcYgy
         GkDkcCidRKEnIjIjjzRQgrdKQ22FiYvADsEbhBftnE9sQPKLJTwWVl2w9sevTC7YgdSB
         PWN29mVzzDF60p93H20VIDmAj7J+CdQFslCPf91nnNbl3asI9Alhe0g+iSnSfc0TpGY2
         litg==
X-Gm-Message-State: APjAAAVV1Dr4be9dIctKaEbO/XOHMChYXW4hcuazzTeglOPAIXwJDnRn
        GwDOzkJjbsFNHbl8eEFffGvW1vBSz9MQJuvW8SY=
X-Google-Smtp-Source: APXvYqwoBZ9xngGjaLkB18eyYNqI3eSbzfST/fobzbGLBjwCx/DNWUL8p7tLnksoUmbv3wPK5B36UUGRk4SexyBNExI=
X-Received: by 2002:aca:cfcb:: with SMTP id f194mr1988936oig.103.1566981820793;
 Wed, 28 Aug 2019 01:43:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAD8Lp47Vh69gQjROYG69=waJgL7hs1PwnLonL9+27S_TcRhixA@mail.gmail.com>
 <CAJZ5v0g4T_0VD_oYMF_BF1VM-d1bg-BD8h8=STDrhVBgouPOPg@mail.gmail.com>
 <01cf6be6-9175-87ca-f3ad-78c06b666893@linux.intel.com> <CAD8Lp4658-c=7KabiJ=xuNRCqPwF4BJauMHqh_8WSBfCFHWSSg@mail.gmail.com>
 <CAJZ5v0gouaztf7tcKXBr90gjrVjOvqH70regD=o2r_d+9Bwvqg@mail.gmail.com> <CAD8Lp47oNJb5N5i4oUQfN5b=xCtUc1Lt852pnXxhNq0vyWj=yg@mail.gmail.com>
In-Reply-To: <CAD8Lp47oNJb5N5i4oUQfN5b=xCtUc1Lt852pnXxhNq0vyWj=yg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 28 Aug 2019 10:43:29 +0200
Message-ID: <CAJZ5v0j=x4HHOsJ6fCX-xOr29-4BMRzjR5H5UaoWW9v-Ci8ODQ@mail.gmail.com>
Subject: Re: Ryzen7 3700U xhci fails on resume from sleep
To:     Daniel Drake <drake@endlessm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 28, 2019 at 10:34 AM Daniel Drake <drake@endlessm.com> wrote:
>
> On Tue, Aug 27, 2019 at 3:48 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > That depends on what exactly happens when you try to do the D0-D3-D0
> > with setpci.  If the device becomes unreachable (or worse) after that,
> > it indicates a platform issue.  It should not do any harm at the
> > least.
> >
> > However, in principle D0-D3-D0 at the PCI level alone may not be
> > sufficient, because ACPI may need to be involved.
>
> After using setpci to do D0-D3-D0 transitions, the xhci module fails to probe.
>
>   xhci_hcd 0000:03:00.3: WARN: xHC restore state timeout
>   xhci_hcd 0000:03:00.3: PCI post-resume error -110!
>
> But maybe it's not a great test; as you say I'm not involving ACPI,
> and also if Linux has a reason for not runtime suspending PCI devices
> without drivers present then maybe I should also not be doing this.
>
> > I think that PM-runtime should suspend XHCI controllers without
> > anything on the bus under them, so I wonder what happens if
> > ".../power/control" is set to "on" and then to "auto" for that device,
> > with the driver loaded.
>
> Good hint.
>
> # echo on > /sys/bus/pci/devices/0000\:03\:00.3/power/control
> # echo auto > /sys/bus/pci/devices/0000\:03\:00.3/power/control
> # echo 1 > /sys/bus/usb/devices/1-4/remove
> # cat /sys/bus/pci/devices/0000\:03\:00.3/power/runtime_status
> suspended
> # echo on > /sys/bus/pci/devices/0000\:03\:00.3/power/control
>
> The final command there triggers these messages (including a printk I
> added in pci_raw_set_power_state):
>  xhci_hcd 0000:03:00.3: pci_raw_set_power_state from 3 to 0
>  xhci_hcd 0000:03:00.3: Refused to change power state, currently in D3
>  xhci_hcd 0000:03:00.3: pci_raw_set_power_state from 3 to 0
>  xhci_hcd 0000:03:00.3: enabling device (0000 -> 0002)
>  xhci_hcd 0000:03:00.3: WARN: xHC restore state timeout
>  xhci_hcd 0000:03:00.3: PCI post-resume error -110!
>  xhci_hcd 0000:03:00.3: HC died; cleaning up
>
> So we just reproduced the same issue using runtime PM, without having
> to go through the whole suspend path.
>
> I guess that points towards a platform issue, although the weird thing
> is that Windows presumably does the D3-D0-D3 transition during
> suspend/resume and that appears to work fine.

It looks like the platform expects the OS to do something that our
generic XHCI driver and the PCI/ACPI layer don't do.

A quirk or similar may be needed to address that.

> I'll report it to the vendor,

Yes, please.  At least try to get the information on what the exact
platform expectations with respect to the OS are.  Quite evidently,
they aren't just "do the usual thing".

> but if you have any other debug ideas they would be much appreciated.

With the git branch mentioned previously merged in, you can enable
dynamic debug in device_pm.c, repeat the PM-runtime test and collect
the log.  There should be some additional messages from the ACPI layer
in it.


>
> Daniel
