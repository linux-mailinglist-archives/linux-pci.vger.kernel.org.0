Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 547F8528DF
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 12:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbfFYKBJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 06:01:09 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33375 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfFYKBJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jun 2019 06:01:09 -0400
Received: by mail-oi1-f194.google.com with SMTP id f80so12069258oib.0;
        Tue, 25 Jun 2019 03:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JMxWO1OBCSHYptcHpVKv+zvrOqzJ4t8VzgQk1UXHXpM=;
        b=I6RXOB7X1QxbOw8pTyinptBWjwvlN97nM/JT7uY0KM78+Bp5EPHiZO47je3vatKdfv
         tqJJF/FKF3ZH3mj0dKU2zuE7q1ZqiOur4pPg/jVgreYTzOM9s7Gi/j5aFXhJT762HECO
         vnN8BbkfKr8hjjcVVFA/zUgu4vU+4reH/BKiFfCY/FPgZkgcK5g9CkKKXgBW2Jk/bQ+C
         PKxngxfyPiLaD1r44SXQ1vMwTqyPnH/7Tl+qnYszQaf9Es31squ/G5panyn7bkMkQfsm
         Zqdhlao7T+Hu0BOs4o39ccyFUBx7KHoA2upQScKdZZPeB0JiA5NmT0a1xzxw3wb9QlWk
         Efbw==
X-Gm-Message-State: APjAAAXYEc7m/f949vj5Q5mE0N33dttfHjOEq1AJNHE9n6PbChLLi86U
        odWeTDTMlzVxvPYlWnsN57eEIBN+6UsaRAV3iio=
X-Google-Smtp-Source: APXvYqyvEbO5+dzT000ZqMwhIzQKRhsZ5mg1mrS4X4cHDD+Gdn62RbLCOk0KctWGppTeO9l7AUsxs56oGej4Rc34XWg=
X-Received: by 2002:aca:edc8:: with SMTP id l191mr14105958oih.103.1561456868290;
 Tue, 25 Jun 2019 03:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190618161858.77834-1-mika.westerberg@linux.intel.com>
 <20190620141541.GA257318@google.com> <CAJZ5v0hfCnyuAA7kC5-fXRo-Mf0jvGZQASV9T4iK8QxsqHMN_g@mail.gmail.com>
 <1858642.x2LvR771H8@kreacher> <20190625094559.GY2640@lahna.fi.intel.com>
In-Reply-To: <20190625094559.GY2640@lahna.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Jun 2019 12:00:57 +0200
Message-ID: <CAJZ5v0gca0ey-NonUS4vgsv-kXwvnUzhGcDJpVotwscU3wc-nQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] PCI / ACPI: Use cached ACPI device state to get
 PCI device power state
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 25, 2019 at 11:46 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Mon, Jun 24, 2019 at 01:14:47PM +0200, Rafael J. Wysocki wrote:
> > > The problem here is that acpi_device_get_power() really only should be
> > > used for two purposes: (1) To initialize adev->power.state, or to
> > > update it via acpi_device_update_power(), and (2) by the
> > > "real_power_state" sysfs attribute (of ACPI device objects).  The
> > > adev->power.state value should be used anywhere else, in principle, so
> > > the Mika's patch is correct.
> >
> > Well, it is an improvement, but it is not sufficient.
> >
> > > [Note that adev->power.state cannot be updated after calling
> > > acpi_device_get_power() to the value returned by it without updating
> > > the reference counters of the power resources that are "on" *exactly*
> > > because of the problem at hand here.]
> >
> > That is obviously correct, but ->
> >
> > > > but that's just an idle thought, not a suggestion.
> > >
> > > After the initialization of the ACPI subsystem, the authoritative
> > > source of the ACPI device power state information is
> > > adev->power.state.  The ACPI subsystem is expected to update this
> > > value as needed going forward (including system-wide transitions like
> > > resume from S3).
> >
> > -> the "resume from S3 or hibernation" case needs special handling, because
> > in that case the device power state need not reflect the information the ACPI
> > subsystem has.  That only matters if adev->power.state is ACPI_STATE_D0 and
> > the device is actually *not* in D0, because in that case acpi_device_set_power()
> > will not work.
>
> I guess you are talking about the special-cased devices that we leave in
> D0 when system suspend (via firmware) is entered?
>
> > So that case is not covered currently (it should be rare in practice,
> > though, if it happens at all), so something like the patch below (untested) may
> > be needed in addition to the Mika's patch.
>
> Looks good to me.

I actually decided to address this issue in acpi_device_set_power() as
it may affect devices beyond PCI in principle.  I will send a patch
for that shortly.

> > Still, there is also the "power state not matching" case in pci_pm_complete() that's
> > need to be covered and the non-PCI ACPI PM has a similar issue in theory, so I
> > need to think about this a bit more.
>
> Do you want me to hold off sending an updated version of the patch
> series while we figure this one out or is it fine if I send it out now
> and we can add further details on top?

It is independent of the other fix, so it can be sent now just fine IMO.
