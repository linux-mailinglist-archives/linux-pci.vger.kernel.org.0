Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D20A339A77
	for <lists+linux-pci@lfdr.de>; Sat, 13 Mar 2021 01:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhCMAil (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 19:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhCMAiC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Mar 2021 19:38:02 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9133EC061574
        for <linux-pci@vger.kernel.org>; Fri, 12 Mar 2021 16:38:01 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id bx7so10407086edb.12
        for <linux-pci@vger.kernel.org>; Fri, 12 Mar 2021 16:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V55CsUmF+mr/CmKZQo4eJ9DoAvL0H9UDMjqEpaUB6P8=;
        b=RH9RDg+D75eQrwkyEdi2sgJFftBidFQeJw2cxeSf+OKCsQ+T66mXWa2etqZaWchhv3
         2SAMfRLrOATudtHmv4stvGgXYh4OBWw572sVy0isD1a4sbdZk1vBXiQ4uBt1WBQfvIws
         BrKRb1E2N38QPKyOeFrUnsJTMHWv8TJeC/nQ/0GXC8kTZbA7blnT2VEKdL0ZjVgux7z6
         Grd7Ywj1a79opu4pu5mfmT3WlL5o2Qj/PWPpcqqcTlDGf3INQws5wFAK08kgz6vOwxFB
         zaEHeEnveJ5uNf/p9fSU/Uhf70o+D58KJLVr32cuMIeqhZatZp8jPwSRuSnxH9epV+xy
         Uylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V55CsUmF+mr/CmKZQo4eJ9DoAvL0H9UDMjqEpaUB6P8=;
        b=g2WcIEp6SIhJIdYV6PpawRXWcfa23vDp1yDIq6saB0rgCkcLr/w3npOB8BUIshuS6z
         GNRBsTM/A/vqL3g8H492TTTa9LXFGz/wcDZkpMfJCnbtKSLtyKShQkWLE73mbT/1cVK+
         F6CDZnKxYDGsw9QnEA4qIu3elmRD/Jnxp80b2/3Ah5VKVEmQ58DEucD/kDpoOBT+YPan
         mInamGkak/gWD/2B/9jdFvkr8ydEBDp0eviqxwumiy8+GEcnPWNXF+XyvIpUEreYQMpQ
         sRPNCNfsHzAILfYr1IBJHaMZfFbWgsStJMMv0kzFAY3ZHy/6/Bn7hThZEUjDNliWyj9L
         KkqA==
X-Gm-Message-State: AOAM531RRs/YhNLSfQvL3GPyZD3oBdr1FPTz5K3L1BZ/E00vH+6bUJJ4
        llcgEnaM2hin1nSmjR23K6w6KvcGpGZKZYztSiLYww==
X-Google-Smtp-Source: ABdhPJxA2nrJrysU0o+ZmDC6nfvgpSHtUwP8Uj+zsAeDJef7rmoitYogvGH31sOr5WepfLemcqpL02/a0l9ZafkST+Y=
X-Received: by 2002:aa7:c3cd:: with SMTP id l13mr17041105edr.52.1615595880149;
 Fri, 12 Mar 2021 16:38:00 -0800 (PST)
MIME-Version: 1.0
References: <a137e4aa-22fb-5683-7d58-847408c6bf2b@linux.intel.com> <20210312231416.GA2304029@bjorn-Precision-5520>
In-Reply-To: <20210312231416.GA2304029@bjorn-Precision-5520>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 12 Mar 2021 16:37:49 -0800
Message-ID: <CAPcyv4jWkwbaBUtcV4B1hMaCWxEdZwzgmLSTiuepb-MQE=ZegA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] PCI: pciehp: Skip DLLSC handling if DPC is triggered
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>, knsathya@kernel.org,
        Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 12, 2021 at 3:14 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Mar 12, 2021 at 02:11:03PM -0800, Kuppuswamy, Sathyanarayanan wrote:
> > On 3/12/21 1:33 PM, Bjorn Helgaas wrote:
> > > On Mon, Mar 08, 2021 at 10:34:10PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> > > > +bool is_dpc_reset_active(struct pci_dev *dev)
> > > > +{
> > > > + struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> > > > + u16 status;
> > > > +
> > > > + if (!dev->dpc_cap)
> > > > +         return false;
> > > > +
> > > > + /*
> > > > +  * If DPC is owned by firmware and EDR is not supported, there is
> > > > +  * no race between hotplug and DPC recovery handler. So return
> > > > +  * false.
> > > > +  */
> > > > + if (!host->native_dpc && !IS_ENABLED(CONFIG_PCIE_EDR))
> > > > +         return false;
> > > > +
> > > > + if (atomic_read_acquire(&dev->dpc_reset_active))
> > > > +         return true;
> > > > +
> > > > + pci_read_config_word(dev, dev->dpc_cap + PCI_EXP_DPC_STATUS, &status);
> > > > +
> > > > + return !!(status & PCI_EXP_DPC_STATUS_TRIGGER);
> > >
> > > I know it's somewhat common in drivers/pci/, but I'm not really a
> > > big fan of "!!".
> > I can change it to use ternary operator.
> > (status & PCI_EXP_DPC_STATUS_TRIGGER) ? true : false;
>
> Ternary isn't terrible, but what's wrong with:
>
>   if (status & PCI_EXP_DPC_STATUS_TRIGGER)
>     return true;
>   return false;

It was the branch I was trying to get rid of by recommending !!, how about:

return (status & PCI_EXP_DPC_STATUS_TRIGGER) == PCI_EXP_DPC_STATUS_TRIGGER;

...just so I know the style preference for future drivers/pci/ work?
That at least matches the pattern in the mm helpers that test pte
bits.

>
> which matches the style of the rest of the function.
>
> Looking at this again, we return "true" if either dpc_reset_active or
> PCI_EXP_DPC_STATUS_TRIGGER.  I haven't worked this all out, but that
> pattern feels racy.  I guess the thought is that if
> PCI_EXP_DPC_STATUS_TRIGGER is set, dpc_reset_link() will be invoked
> soon and we don't want to interfere?

Right, and when the trigger is clear then dpc_reset_active keeps
holding off the hotplug driver until the dpc reset completes in
polling for the link up event.
