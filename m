Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56148528B11
	for <lists+linux-pci@lfdr.de>; Mon, 16 May 2022 18:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbiEPQxN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 12:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiEPQxN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 12:53:13 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3791326109
        for <linux-pci@vger.kernel.org>; Mon, 16 May 2022 09:53:10 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id a11so14580320pff.1
        for <linux-pci@vger.kernel.org>; Mon, 16 May 2022 09:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rjHF8zda0dHK9R6BiA7/mpdj4GqfMpRrnLZAGeQsbQ4=;
        b=c8ASxvEJW5nax9QQU6iCpSG4ZYKojIo9eZP+PsckgkCDDLCf3AJp5KwBmXahcy47wU
         jn5voZ3lSn7LiFGqDs3CQKjHF14Z8iQ2FqCJ4edMnkEaq91ohIlPypXBEp35zZRARmyO
         T7qkgHBS4AduriourFmaolMdjMLl3YPlFVnVTih0YvMn55iqez9cR4Jp8QPc8pmhoQTw
         EEXd8FylqkipG5usq/IskctgiXuELiztD01bJF56ZjhC1ZAKlhxSAjsLvYT4D1qSzuT1
         ZITnkCuekyYPKPPM6n75H/VfYk8xokhgW6oX5IRLxJdcrEv4Bf3jk6jF3Iiqffb3LlqQ
         /8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rjHF8zda0dHK9R6BiA7/mpdj4GqfMpRrnLZAGeQsbQ4=;
        b=rtMR3mlAJbScM1LVBfjOd7y19JzrU3BZ+AaNnpF/AcYrA9kWuj1ucUxydx07lPlZYB
         uPw4Sk4nb3LJvtDaz/JKzAZMpFgcX4HLhY9A9L0RPlxhct7hZ/dIHiFPZOl9Z1ZD+Fmi
         dozrkFmSyBw/G7GjYdoxcgFD4bcEjALbV7JHW6daKOxzA5FB4YXGlrp+S4a98HafzD4C
         zckz9o5aZrp2Z8L2TL7BEC+3eJ7bplynH21hLtZ0VwnXWYC0d9JmzGqO7aNlVGw1KWkC
         fu9SEvwku4Per5iJmV54vLxhzhlVurJBeDneSZaDl7ONL3iV9E2Dj9AanFRuO+l/0Gw9
         QSzA==
X-Gm-Message-State: AOAM532vCkK/d/yoWfGM6CzYFoQSHdQ7PCyQ2GpRcowSZs9gJvywMOYR
        S3XteRh8EbYW9JYCs+D9GmTumczRFD6u9onLa4tQXsmZWjgYMA==
X-Google-Smtp-Source: ABdhPJxDGqueclwPT3xn/oAhTGJ0M5G0ecdqKPoH5ncXJjXgBTEB25HB3Q68UL0Hh1+L5In9RqS9A4T8zwXjFaav0WY=
X-Received: by 2002:a62:a105:0:b0:50d:c97b:3084 with SMTP id
 b5-20020a62a105000000b0050dc97b3084mr17987923pff.61.1652719989687; Mon, 16
 May 2022 09:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220503153449.4088-1-Jonathan.Cameron@huawei.com>
 <CAPcyv4geBaTkoJ+Gefgq6RaKHtB3NMh5ruZ-1yV_i0UVaw3SWA@mail.gmail.com>
 <20220507101848.GB31314@wunner.de> <20220509104806.00007c61@Huawei.com>
 <20220511191345.GA26623@wunner.de> <CAPcyv4idjqiY9CV=sghDbWqQS_PM2Z0xWxr2MsrMxS-XqU1F=w@mail.gmail.com>
 <20220514133114.GA14833@wunner.de>
In-Reply-To: <20220514133114.GA14833@wunner.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 16 May 2022 09:53:00 -0700
Message-ID: <CAPcyv4gTrq8qWJhKkM2tEi05kMGwwN4Kt4Axh2y_PRf3FtrMrA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] DOE usage with pcie/portdrv
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gavin Hindman <gavin.hindman@intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-cxl@vger.kernel.org, CHUCK_LEVER <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 14, 2022 at 6:31 AM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Wed, May 11, 2022 at 12:42:24PM -0700, Dan Williams wrote:
> > I think power-management effects relative to IDE is a soft spot of the
> > specification.
>
> When resuming from system sleep, the kernel restores a device's
> config space in pci_pm_resume_noirq(), then calls the driver's
> ->resume_noirq() callback.  The driver is free to assume that
> the device is accessible und usable at that point.
>
> IDE breaks that contract if establishment of an SPDM session
> depends on user space.  We can't call out to user space for
> authentication during the resume_noirq phase because interrupts
> are still disabled.
>
> Drivers would have to be aware that IDE has not yet been
> re-established and refrain from accessing the device.
> Any child devices of the PCI device cannot be resumed
> until then.

Suspend has larger issues with CXL:

https://lore.kernel.org/linux-cxl/165066828317.3907920.5690432272182042556.stgit@dwillia2-desk3.amr.corp.intel.com/

...so IDE is just one more problem on top that requires disabling
suspend. Unless / until firmware takes responsibility for setting up
IDE I am not seeing a clean option for allowing the link to go down.

> Ideally we'd want IDE to be transparent to drivers.
> That's impossible if their access to devices is forbidden
> after system sleep for an indefinite amount of time.
>
> Runtime PM has similar issues as system sleep if the device
> was in D3cold.
>
> Reliance on user space also entails a risk of deadlocks:
> Let's say user space process A accesses a PCI device,
> the kernel runtime resumes the device and calls out to
> user space process B to authenticate it.  If A is holding
> a resource that B requires, the two tasks deadlock and
> the device never becomes accessible.
>
> The more I think about it, the more attractive does Jonathan's
> in-kernel SPDM approach look.  Performing SPDM authentication and
> IDE setup in the kernel would allow us to retain all existing
> assumptions and behavior around power management and reset recovery,
> avoid driver awareness of IDE and avoid deadlocks.

I agree with you that userspace coordination has these problems, but
they are secondary to the larger problem that hosting memory behind
PCI devices causes.

>
>
> > > If setting up an SPDM session is dependent on user space, the kernel
> > > would have to leave a device in an inoperable state after runtime resume
> > > or reset, until user space gets around to initiate SPDM.
> >
> > Yes, this seems acceptable from the perspective of server platforms
> > that can make the power management vs security tradeoff.
>
> It seems likely that IDE will not only be used on server platforms.

I expect IDE outside of the server space will need to be platform
firmware managed. OS managed IDE seems a stopgap to platform firmware
validating devices to be within the trusted compute boundary.

> I'll see to to it that I provide more review feedback to Jonathan's RFC
> series so that we can move forward with this.
>
> Thanks,
>
> Lukas
