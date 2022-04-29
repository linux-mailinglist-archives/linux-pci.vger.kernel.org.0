Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4984451513D
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 19:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379371AbiD2REs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 13:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379378AbiD2REk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 13:04:40 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A525DE41
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 10:01:20 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id a11so7431922pff.1
        for <linux-pci@vger.kernel.org>; Fri, 29 Apr 2022 10:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/8ErL6BnP6C5QttTgTp9GzvHjxiM+QiRr/nJIg3XkE4=;
        b=3AXQ4KydmCXy9v5o5uLNP2D/LCb/Ti8kCwfBEaowrO4CHjOHcBLJiSgxmff9vsVC4z
         JlcLFy9Q+NoAIywws86MIMutchNRuBep6qA1WTb4RwBRDaSFXmjdCjq91bvubvcwG0Ce
         cvwphaU2ZtLFVTFLTIfCnYog58BmQjfewwTvFjYOlLaSB/dL1bclqzFTBCXDUQyKDDMf
         X1KhgmYv2L/ubL6KWcPsrMG3tB6LJnhykVjcn10JmXpcyc42PD/5so77YW8P2A1KVLvJ
         5UWtO6zZ33qxX/P6k2H/M9anJpUw+p77IO/Bb0p8FjTlSCjupknbQI4SnObzRkJObz5u
         GL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/8ErL6BnP6C5QttTgTp9GzvHjxiM+QiRr/nJIg3XkE4=;
        b=G8PSol+3cNYb3iM6yJDxUVPxrC93p+lJ6UPgfi0IgFUyVIMSWFsBo7K0nJW5S8wGvL
         Zn/Q2MOQWXoVc0cUL7UZBS0mAaBmDSHi66Vqw7dzg6Ct/tB+5/JUyM37pSxRlgcaRhYR
         fe+KjKLKWt+/ciVLn8WjfqwoVdnut7Dl8J+NzAHvpqr8NQq89+qV1WaZufe66CFaSTA2
         QTlRwNSYX5JD+6gL5U4KC51EMD8vIqaqfpu7fWzKr3zJiajhAdGy1s4jcMXpXJjWQBUW
         RirVnx/c/R/dBaNJTMa4G2jKWaz5iNQq4DlU0bJM2ZlJPv+m1KPR3TZ3kfbUzKJ6/NvX
         VZrA==
X-Gm-Message-State: AOAM530MBscH/u2ghom/KLt7HN2RArKtKLreaMjEK8oJ8HEo8yo89jjj
        IkyiLzBob6OdmrCil6CIr0UYw1HzdwyQx9C/7VcQHQ==
X-Google-Smtp-Source: ABdhPJxK8MRKlKZjWavG8oR7gJ2mH52BBFfoWkuWHlQn2wWEpwlN0+7vspKLie2AvBeVUI9fwsOsI3VK+xLthfSE+qc=
X-Received: by 2002:a65:6e0e:0:b0:399:26d7:a224 with SMTP id
 bd14-20020a656e0e000000b0039926d7a224mr256012pgb.437.1651251680182; Fri, 29
 Apr 2022 10:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220414203237.2198665-1-ira.weiny@intel.com> <20220414203237.2198665-5-ira.weiny@intel.com>
 <20220427181942.00003492@Huawei.com> <YmsCfHf/HMuqBkTk@iweiny-server> <20220429173843.00006dcd@Huawei.com>
In-Reply-To: <20220429173843.00006dcd@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 29 Apr 2022 10:01:09 -0700
Message-ID: <CAPcyv4huH2TPnVEzMmsKR=EGXv5A-4wd38M2nzRa-tkxeECV_Q@mail.gmail.com>
Subject: Re: [PATCH V8 04/10] cxl/pci: Create auxiliary devices for each DOE mailbox
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     "Weiny, Ira" <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 29, 2022 at 9:39 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 28 Apr 2022 14:09:38 -0700
> ira.weiny@intel.com wrote:
>
> > On Wed, Apr 27, 2022 at 06:19:42PM +0100, Jonathan Cameron wrote:
> > > On Thu, 14 Apr 2022 13:32:31 -0700
> > > ira.weiny@intel.com wrote:
> > >
> > > > From: Ira Weiny <ira.weiny@intel.com>
> > > >
> > > > CXL kernel drivers optionally need to access DOE mailbox capabilities.
> > > > Access to mailboxes for things such as CDAT, SPDM, and IDE are needed by
> > > > the kernel while other access is designed towards user space usage.  An
> > > > example of this is for CXL Compliance Testing (see CXL 2.0 14.16.4
> > > > Compliance Mode DOE) which offers a mechanism to set different test
> > > > modes for a device.
> > > >
> > > > There is no anticipated need for the kernel to share an individual
> > > > mailbox with user space.  Thus developing an interface to marshal access
> > > > between the kernel and user space for a single mailbox is unnecessary
> > > > overhead.  However, having the kernel relinquish some mailboxes to be
> > > > controlled by user space is a reasonable compromise to share access to
> > > > the device.
> > > >
> > > > The auxiliary bus provides an elegant solution for this.  Each DOE
> > > > capability is given its own auxiliary device.  This device is controlled
> > > > by a kernel driver by default which restricts access to the mailbox.
> > > > Unbinding the driver from a single auxiliary device (DOE mailbox
> > > > capability) frees the mailbox for user space access.  This architecture
> > > > also allows a clear picture on which mailboxes are kernel controlled vs
> > > > not.
> > > >
> > > > Iterate each DOE mailbox capability and create auxiliary bus devices.
> > > > Follow on patches will define a driver for the newly created devices.
> > > >
> > > > sysfs shows the devices.
> > > >
> > > > $ ls -l /sys/bus/auxiliary/devices/
> > > > total 0
> > > > lrwxrwxrwx 1 root root 0 Mar 24 10:47 cxl_pci.doe.0 -> ../../../devices/pci0000:bf/0000:bf:00.0/0000:c0:00.0/cxl_pci.doe.0
> > > > lrwxrwxrwx 1 root root 0 Mar 24 10:47 cxl_pci.doe.1 -> ../../../devices/pci0000:bf/0000:bf:01.0/0000:c1:00.0/cxl_pci.doe.1
> > > > lrwxrwxrwx 1 root root 0 Mar 24 10:47 cxl_pci.doe.2 -> ../../../devices/pci0000:35/0000:35:00.0/0000:36:00.0/cxl_pci.doe.2
> > > > lrwxrwxrwx 1 root root 0 Mar 24 10:47 cxl_pci.doe.3 -> ../../../devices/pci0000:35/0000:35:01.0/0000:37:00.0/cxl_pci.doe.3
> > > > lrwxrwxrwx 1 root root 0 Mar 24 10:47 cxl_pci.doe.4 -> ../../../devices/pci0000:35/0000:35:00.0/0000:36:00.0/cxl_pci.doe.4
> > > > lrwxrwxrwx 1 root root 0 Mar 24 10:47 cxl_pci.doe.5 -> ../../../devices/pci0000:bf/0000:bf:00.0/0000:c0:00.0/cxl_pci.doe.5
> > > > lrwxrwxrwx 1 root root 0 Mar 24 10:47 cxl_pci.doe.6 -> ../../../devices/pci0000:35/0000:35:01.0/0000:37:00.0/cxl_pci.doe.6
> > > > lrwxrwxrwx 1 root root 0 Mar 24 10:47 cxl_pci.doe.7 -> ../../../devices/pci0000:bf/0000:bf:01.0/0000:c1:00.0/cxl_pci.doe.7
> > > >
> > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > >
> > > I'm not 100% happy with effectively having one solution for CXL
> > > and probably a different one for DOEs on switch ports
> > > (which I just hacked into a port service driver to convince
> > > myself there was at least one plausible way of doing that) but if
> > > this effectively separates the two discussions then I guess I can
> > > live with it for now ;)
> >
> > I took some time this morning to mull this over and talk to Dan...
> >
> > :-(
> >
> > Truthfully the aux driver does very little except provide a way for admins to
> > trigger the driver to stop/start accessing the Mailbox.
> >
> > I suppose a simple sysfs interface could be done to do the same?
> >
> > I'll let Dan weigh in here.
>
> I wonder if best short term option is to not provide a means of
> removing it at all (separate from the PCI driver that is).
> Then we can take our time to decide on the interface if we ever
> get much demand for one.
>
> >
> > >
> > > Once this is merged we can start the discussion about how to
> > > handle switch ports with DOEs both for CDAT and SPDM.
> >
> > I'm ok with that too.  However, I was thinking that this was not a user ABI.
> > But it really is.  If user space starts writing script to unbind drivers and
> > then we drop the aux driver support it will break them...
> >
> > >
> > > I'll send out an RFC that is so hideous it will get people to
> > > suggestion how to do it better!
> >
> > I think I'd like to see that.
>
> Fair enough. It may muddy the waters a bit :( I'll send an RFC
> next week.  I've not looked at how the CXL region code etc would
> actually get to the latency / bandwidth info from the driver yet
> it just goes as far as reading a CDAT length. I also want to actually
> hook up some decent switch CDAT emulation in the QEMU code
> (right now it's giving the same default table as for a type 3 device).
>
> I just hope we don't bikeshed around the RFC in a fashion that slows
> this series moving forwards.

I think we have time in the sense that the worst that happens is that
tooling picks the wrong CFMWS to dynamically create a region and the
performance ends up being sub-optimal. That's tolerable to work around
in userspace in the near term. I want to get some wider confidence in
the DOE ABI with respect to the known protocols and what to do about
the vendor-specific protocols that may conflict and will be driven
from userspace issued config-cycles. That likely means that no DOE ABI
is the best ABI to start which means not moving forward with
aux-devices so scripts do not become attached to something that is not
fully committed to being carried forward.

I still want to refresh the request_config_region() support for at
least having the kernel warn on userspace conflicting configuration
writes to config areas claimed by a driver.
