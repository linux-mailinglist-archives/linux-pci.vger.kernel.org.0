Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FA71C38C2
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 13:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgEDL7y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 07:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgEDL7y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 May 2020 07:59:54 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AA6C061A0E
        for <linux-pci@vger.kernel.org>; Mon,  4 May 2020 04:59:53 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y24so8718887wma.4
        for <linux-pci@vger.kernel.org>; Mon, 04 May 2020 04:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cCoTZdYSMtmcy9yxqpSvzGCwq3TPN8XX8YgKuZwvimg=;
        b=qrPGBUOCwGl53Jc7fcMa/4bN8JwcD+62I+1J/N+BTznbkc8bhcq1yZZznQmOPO8hha
         n/xCV+3UoAjdZFqkKU1HmGx4u2sx9DmN3tiOy5rvcBW+xYixFo3bnyX/2TGM6uNmCCrX
         +VqkPD6PrmBcYjcdrj2QXauFLcOVHiKHEtn/s8saELrx5fqPuf5uHzwOz7B2zecKZAhL
         YdPRnuigxSeZd1lUPXAExM63DEfjYJVpF2uU97vDvwhtDuHlrLJzB2c1FAqldZhaXRoF
         /VFRx7bAHQkKb9/LTM3V2Y4DNZRdwVPWzYF2UQQpXqcN69siyZVN7BDTzmsT7W79E8/M
         Ep/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cCoTZdYSMtmcy9yxqpSvzGCwq3TPN8XX8YgKuZwvimg=;
        b=iiHU9O0X85mm1fh4JCcRLhC+3+iI3ntCL1Hnv6MNCMAQn9GwtNXz4l3wvA3iV3N7Nb
         RSIf/lrw/8cBkac04Aii9zg0zhqO/WUz7W8fhtvrDZJemUnYb92b9MAhBY6HL/Lxl5fF
         ZfXUzUEY5stdpvsxAEwoOof7fb5ooGlZW3QDlRiBqaEaJGCHrMmMeymJGgGfrRZH7aoT
         YCzdraU0+z5CmfAkvbHuIj5anrJauUi0ABqBWNSoqMrNCaPAPdIqMhbVMIzM8vxMe/yB
         wj0kgRJbQBnilrU79dBGY9orP6LPc9ZUJ30+XTwZo+xJlFHLKRs9N/w9KMB2ziT5ST7x
         Ny4g==
X-Gm-Message-State: AGi0PuYk0PCf+k3mByLEpBkmuyWTrY9teGXQ8pxa3yAlElNm6DgwBra4
        LaEq2AFhqWHfGu88OFOuk0ecMQ==
X-Google-Smtp-Source: APiQypIM4HapMoe4K1/6EhPHGXPL1n8yyjUhsFUzED4Bbhaw6ZfimWNGyGOh+Bwzk+3YpFiB3MLeLA==
X-Received: by 2002:a1c:3c87:: with SMTP id j129mr13805033wma.157.1588593592404;
        Mon, 04 May 2020 04:59:52 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id f7sm17171875wrt.10.2020.05.04.04.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 04:59:51 -0700 (PDT)
Date:   Mon, 4 May 2020 13:59:42 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Zubin Mithra <zsm@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        "Keany, Bernie" <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
Message-ID: <20200504115942.GB64193@myrica>
References: <CACK8Z6E8pjVeC934oFgr=VB3pULx_GyT2NkzAogdRQJ9TKSX9A@mail.gmail.com>
 <20200504114727.GA64193@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504114727.GA64193@myrica>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 04, 2020 at 01:47:27PM +0200, Jean-Philippe Brucker wrote:
> Hi,
> 
> On Fri, May 01, 2020 at 04:07:10PM -0700, Rajat Jain wrote:
> > Hi,
> > 
> > Currently, the PCI subsystem marks the PCI devices as "untrusted", if
> > the firmware asks it to:
> > 
> > 617654aae50e ("PCI / ACPI: Identify untrusted PCI devices")
> > 9cb30a71acd4 ("PCI: OF: Support "external-facing" property")
> > 
> > An "untrusted" device indicates a (likely external facing) device that
> > may be malicious, and can trigger DMA attacks on the system. It may
> > also try to exploit any vulnerabilities exposed by the driver, that
> > may allow it to read/write unintended addresses in the host (e.g. if
> > DMA buffers for the device, share memory pages with other driver data
> > structures or code etc).
> > 
> > High Level proposal
> > ===============
> > Currently, the "untrusted" device property is used as a hint to enable
> > IOMMU restrictions (on Intel), disable ATS (on ARM) etc. We'd like to
> > go a step further, and allow the administrator to build a list of
> > whitelisted drivers for these "untrusted" devices.
> 
> How about letting the administrator whitelist devices that are trusted,
> rather than whitelisting drivers?

Uh, I completely missed the point. Your proposal is about preventing from
binding any untrusted devices to non-whitelisted drivers. Please disregard
my reply :)

Thanks,
Jean

> 
> The "thunderclap" attack [1] emulates an existing device using an FPGA in
> order to get probed by the device driver, and then bypasses a weakened
> IOMMU. By design the driver cannot differentiate a well-behaved device
> from a malicious one, so changing the trust level of the driver doesn't
> feel like the right way. What the admin wants to say is "I trust this
> port, no one is plugging any malicious device in here."
> 
> Then you could also make the option 3-way: either keep the default trust
> fixed by FW, or manually set "trusted" or "untrusted".
> 
> For reference there have been several discussions, recently, about letting
> admins change IOMMU configuration for a device. A PCI command-line option
> [2] was suggested, but I think the current proposal is a sysfs knob on
> IOMMU groups [3], that can be changed while devices are unbound from
> drivers. It's not completely relevant since the "untrusted" property isn't
> tied to the IOMMU subsystem, but seemed worth mentioning.
> 
> [1] https://thunderclap.io/thunderclap-paper-ndss2019.pdf
> [2] https://lore.kernel.org/linux-iommu/20200101052648.14295-3-baolu.lu@linux.intel.com/
> [3] https://lore.kernel.org/linux-iommu/5aa5ef20ff81f706aafa9a6af68cef98fe60ad0f.1581619464.git.sai.praneeth.prakhya@intel.com/
> 
> Thanks,
> Jean
> 
> > This whitelist of
> > drivers are the ones that he trusts enough to have little or no
> > vulnerabilities. (He may have built this list of whitelisted drivers
> > by a combination of code analysis of drivers, or by extensive testing
> > using PCIe fuzzing etc). We propose that the administrator be allowed
> > to specify this list of whitelisted drivers to the kernel, and the PCI
> > subsystem to impose this behavior:
> > 
> > 1) The "untrusted" devices can bind to only "whitelisted drivers".
> > 2) The other devices (i.e. dev->untrusted=0) can bind to any driver.
> > 
> > Of course this behavior is to be imposed only if such a whitelist is
> > provided by the administrator.
> > 
> > Details
> > ======
> > 
> > 1) A kernel argument ("pci.impose_driver_whitelisting") to enable
> > imposing of whitelisting by PCI subsystem.
> > 
> > 2) Add a flag ("whitelisted") in struct pci_driver to indicate whether
> > the driver is whitelisted.
> > 
> > 3) Use the driver's "whitelisted" flag and the device's "untrusted"
> > flag, to make a decision about whether to bind or not in
> > pci_bus_match() or similar.
> > 
> > 4) A mechanism to allow the administrator to specify the whitelist of
> > drivers. I think this needs more thought as there are multiple
> > options.
> > 
> > a) Expose individual driver's "whitelisted" flag to userspace so a
> > boot script can whitelist that driver. There are questions that still
> > need answered though e.g. what to do about the devices that may have
> > already been enumerated and rejected by then? What to do with the
> > already bound devices, if the user changes a driver to remove it from
> > the whitelist. etc.
> > 
> >       b) Provide a way to specify the whitelist via the kernel command
> > line. Accept a ("pci.whitelist") kernel parameter which is a comma
> > separated list of driver names (just like "module_blacklist"), and
> > then use it to initialize each driver's "whitelisted" flag as the
> > drivers are registered. Essentially this would mean that the whitelist
> > of devices cannot be changed after boot.
> > 
> > To me (b) looks a better option but I think a future requirement would
> > be the ability to remove the drivers from the whitelist after boot
> > (adding drivers to whitelist at runtime may not be that critical IMO)
> > 
> >  WDYT?
> > 
> > Thanks,
> > 
> > Rajat
