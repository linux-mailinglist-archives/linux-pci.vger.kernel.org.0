Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680AF7CB546
	for <lists+linux-pci@lfdr.de>; Mon, 16 Oct 2023 23:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbjJPV30 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Oct 2023 17:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbjJPV3Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Oct 2023 17:29:25 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27661E1;
        Mon, 16 Oct 2023 14:29:23 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c1807f3400so58547501fa.1;
        Mon, 16 Oct 2023 14:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697491761; x=1698096561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=izuw3JLwredy2IzR0SMzmo2qR8d6vfISCsd5KRIFA/M=;
        b=IE9qnG8udgC51VLGU5KxgwO9dU3xkuK4nh1KVl7O37MVSFwOyU/gMR3fxcfw74p7Oh
         yE5zfDKu7DPLM0dWnaN9ZZnFZ8EcGV/PVZyuzgDvpXcd6GUGzRksXujf+yIIpzPq3V+j
         81Y34VaZRS2pUOHE3wzq5alSG90c8srKR+mcdfgEkrdiWa2eWfRpk3aL00i8YtHOMXEG
         sVtiUsUzhNN5sLnJcB++ocx4eBVkB+hFLTBJL2/MJrzaiagUrogi9p06QIanOEYDzz7j
         tpqE1yX485hpYJLnEXSoHMY5VZgTY24OfdiDbyxYci5YQgTc8QFShGpAlyuOwsdLrnZD
         qAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697491761; x=1698096561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izuw3JLwredy2IzR0SMzmo2qR8d6vfISCsd5KRIFA/M=;
        b=aIeqiIDAUwjOXwK4s3spYjOfk4DZwjfsq55zMT1TmltLN+QlPNG6ohLutLjnXXhtM+
         sUttl20jQKBsF4wuWpmtpTBip5p21NZ9JibW4BQIid6nD8unq0iNwmK91rFd82lMVlCG
         TVlmOhm8CY9C1u9FIwqfw2AprelMuVlSKHlE/sWwzcnCV1XO2JMtaMO/lKBaSTx5cH/o
         nZBabLtTlzVW+u5MZ9SmNnHBwlxvvd/fv7JkY9BhMbTdZKfOwEPOWB0SxHYU0/yuwlo1
         Nr7fiXHYreMUsOurVoKFS+7Z8T3d6wXP0w6OlWvJut4vf+mAD1jr1a1ielgIZcDB/7Ty
         xoUg==
X-Gm-Message-State: AOJu0YxX0QZdZP3gfnx06kUGDr+7Y9YdxZHbqLoTtei+vR/J0Ok1Dntu
        +bree1ERQmyuQbFJ87m3j+GqGCQBgh0=
X-Google-Smtp-Source: AGHT+IH24ZrFNJR6Rp5nHzFLXP0Db48auRT7S49Rb5pLEz8i1gFt2a+6SL+fSfDGD/o808L/MoXbww==
X-Received: by 2002:a2e:b88a:0:b0:2c0:13d5:e463 with SMTP id r10-20020a2eb88a000000b002c013d5e463mr453281ljp.7.1697491760744;
        Mon, 16 Oct 2023 14:29:20 -0700 (PDT)
Received: from mobilestation ([176.213.11.59])
        by smtp.gmail.com with ESMTPSA id o5-20020a2e7305000000b002b9ec22d9fasm115022ljc.29.2023.10.16.14.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 14:29:19 -0700 (PDT)
Date:   Tue, 17 Oct 2023 00:29:17 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, r-gunasekaran@ti.com,
        srk@ti.com
Subject: Re: [PATCH] PCI: keystone: Don't enable BAR0 if link is not detected
Message-ID: <klxzte53bzk774zinhfrdwdwalvv2hlvc2mqiuyecxcneqkdbt@qbkyc4fdlcka>
References: <20231013184958.GA1118393@bhelgaas>
 <c11f4b9f-8cbe-1fd0-886b-f36547dc8d3c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c11f4b9f-8cbe-1fd0-886b-f36547dc8d3c@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Siddharth

On Sat, Oct 14, 2023 at 11:22:48AM +0530, Siddharth Vadapalli wrote:
> 
> 
> On 14/10/23 00:19, Bjorn Helgaas wrote:
> > On Fri, Oct 13, 2023 at 10:36:01AM +0530, Siddharth Vadapalli wrote:
> >> On 13/10/23 10:33, Siddharth Vadapalli wrote:
> >>> On 12/10/23 22:13, Bjorn Helgaas wrote:
> >>>> On Thu, Oct 12, 2023 at 10:15:09AM +0530, Siddharth Vadapalli wrote:
> >>>>> On 11/10/23 19:16, Bjorn Helgaas wrote:
> >>> ...
> >>>>>                                               msix_prepare_msi_desc
> >>>>> In this function: msix_prepare_msi_desc, the following readl()
> >>>>> causes completion timeout:
> >>>>> 		desc->pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
> >>>>> The completion timeout with the readl is only observed when the link
> >>>>> is down (No Endpoint device is actually connected to the PCIe
> >>>>> connector slot).
> >>>>
> >>>> Do you know the address ("addr")?  From pci_msix_desc_addr(), it looks
> >>>> like it should be:
> >>>>
> >>>>   desc->pci.mask_base + desc->msi_index * PCI_MSIX_ENTRY_SIZE
> >>>>
> >>>> and desc->pci.mask_base should be dev->msix_base, which we got from
> >>>> msix_map_region(), which ioremaps part of the BAR indicated by the
> >>>> MSI-X Table Offset/Table BIR register.
> >>>>
> >>>> I wonder if this readl() is being handled as an MMIO access to a
> >>>> downstream device instead of a Root Port BAR access because it's
> >>>> inside the Root Port's MMIO window.
> >>>>
> >>>> Could you dump out these values just before the readl()?
> >>>>
> >>>>   phys_addr inside msix_map_region()
> >>>>   dev->msix_base
> >>>>   desc->pci.mask_base
> >>>>   desc->msi_index
> >>>>   addr
> >>>
> >>> phys_addr: 0x10102000
> >>> msix_base: 0xffff80000997a000
> >>> mask_base: 0xffff80000997a000
> >>> msi_index: 0
> >>> addr: 0xffff80000997a000
> >>>
> >>> Also, the details of BAR allocation from the logs are:
> >>> keystone-pcie 5500000.pcie: host bridge /bus@100000/pcie@5500000 ranges:
> >>> keystone-pcie 5500000.pcie:       IO 0x0010020000..0x001002ffff -> 0x0000000000
> >>> keystone-pcie 5500000.pcie:      MEM 0x0010030000..0x0017ffffff -> 0x0010030000
> >>> keystone-pcie 5500000.pcie: iATU unroll: enabled
> >>> keystone-pcie 5500000.pcie: iATU regions: 8 ob, 8 ib, align 64K, limit 4G
> >>> keystone-pcie 5500000.pcie: Phy link never came up
> >>> keystone-pcie 5500000.pcie: PCI host bridge to bus 0000:00
> >>> pci_bus 0000:00: root bus resource [bus 00-ff]
> >>> pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> >>> pci_bus 0000:00: root bus resource [mem 0x10030000-0x17ffffff]
> >>> pci 0000:00:00.0: [104c:b00c] type 01 class 0x060400
> >>> pci 0000:00:00.0: reg 0x10: [mem 0x05500000-0x055fffff]
> >>> pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
> >>> pci 0000:00:00.0: supports D1
> >>> pci 0000:00:00.0: PME# supported from D0 D1 D3hot
> >>> pci 0000:00:00.0: BAR 0: assigned [mem 0x10100000-0x101fffff]
> >>> pci 0000:00:00.0: BAR 6: assigned [mem 0x10030000-0x1003ffff pref]
> >>> pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> >>>
> >>> The value of phys_addr lies within the range allocated to BAR0.
> >>>
> >>>>   call early_dump_pci_device() on the Root Port
> >>>
> >>> I invoked early_dump_pci_device() within the pci_setup_device() function in
> >>> drivers/pci/probe.c and the output is:
> > 
> > It'd be better to dump the config space immediately before the readl()
> > since the PCI core did change some things in the interim.
> 
> I dumped the config space just before the readl() and it is:
> 
> pcieport 0000:00:00.0: config space:
> 00000000: 4c 10 0c b0 07 01 10 00 01 00 04 06 00 00 01 00
> 00000010: 00 00 10 10 00 00 00 00 00 01 ff 00 f0 00 00 00
> 00000020: f0 ff 00 00 f0 ff 00 00 00 00 00 00 00 00 00 00
> 00000030: 00 00 00 00 40 00 00 00 00 00 00 00 17 01 02 00
> 00000040: 01 50 c3 5b 08 00 00 00 00 00 00 00 00 00 00 00
> 00000050: 05 70 80 01 00 00 00 00 00 00 00 00 00 00 00 00
> 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00000070: 10 b0 42 00 01 80 00 00 1f 20 00 00 22 3c 73 00
> 00000080: 00 00 11 10 00 00 00 00 c0 03 40 00 10 00 01 00
> 00000090: 00 00 00 00 1f 04 00 00 00 00 00 00 06 00 00 00
> 000000a0: 02 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> 000000b0: 11 00 00 c1 00 20 00 00 00 40 00 00 00 00 00 00
> 000000c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 000000e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> BAR0 was configured with the value: 0x05500000 within ks_pcie_v3_65_add_bus() at:
> dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
> and can be verified based on the previous config space dump I had shared within
> the pci_setup_device() function. But, looking at the dump above which is just
> before the readl(), its value seems to have changed to 0x10100000.
> 
> I am listing down the regions of config space which have changed, based on the
> comparison of dumps taken within pci_setup_device() and just before the readl():
> 
> Within pci_setup_device():
> 00000010: 00 00 50 05 00 00 00 00 00 01 ff 00 00 00 00 00
> Before readl():
> 00000010: 00 00 10 10 00 00 00 00 00 01 ff 00 f0 00 00 00
> 
> Within pci_setup_device():
> 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> Before readl():
> 00000020: f0 ff 00 00 f0 ff 00 00 00 00 00 00 00 00 00 00
> 
> Within pci_setup_device():
> 00000030: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
> Before readl():
> 00000030: 00 00 00 00 40 00 00 00 00 00 00 00 17 01 02 00
> 
> Within pci_setup_device():
> 00000070: 10 b0 42 00 01 80 00 00 10 20 00 00 22 3c 73 00
> Before readl():
> 00000070: 10 b0 42 00 01 80 00 00 1f 20 00 00 22 3c 73 00
> 
> Within pci_setup_device():
> 00000080: 00 00 11 10 00 00 00 00 c0 03 40 00 00 00 01 00
> Before readl():
> 00000080: 00 00 11 10 00 00 00 00 c0 03 40 00 10 00 01 00
> 
> Within pci_setup_device():
> 000000b0: 11 00 00 01 00 20 00 00 00 40 00 00 00 00 00 00
> Before readl():
> 000000b0: 11 00 00 c1 00 20 00 00 00 40 00 00 00 00 00 00
> 
> > 
> >>> pci 0000:00:00.0: config space:
> >>> 00000000: 4c 10 0c b0 07 01 10 00 01 00 04 06 00 00 01 00
> > 
> >   PCI_COMMAND = 0x0107
> >     PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER | PCI_COMMAND_SERR
> > 
> >>> 00000010: 00 00 50 05 00 00 00 00 00 01 ff 00 00 00 00 00
> >>> 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 
> >   PCI_IO_BASE            =       0x00 low 4 bits indicate 16-bit addressing
> >   PCI_IO_LIMIT           =       0x00
> >   PCI_MEMORY_BASE        =     0x0000
> >   PCI_MEMORY_LIMIT       =     0x0000
> >   PCI_PREF_MEMORY_BASE   =     0x0000 low 4 bits indicate 32-bit pref
> >   PCI_PREF_MEMORY_LIMIT  =     0x0000
> >   PCI_PREF_BASE_UPPER32  = 0x00000000
> >   PCI_PREF_LIMIT_UPPER32 = 0x00000000
> > 
> > We can't tell from this whether the prefetchable window is implemented
> > (but I'm sure keystone *does* implement it).  If PCI_PREF_MEMORY_BASE
> > and PCI_PREF_MEMORY_LIMIT are read-only zeros, it is not implemented.
> > If they are writable, it is enabled at the same range as the
> > non-prefetchable window.
> 
> Yes, PCI_PREF_MEMORY_BASE and PCI_PREF_MEMORY_LIMIT are writable.
> 
> > 
> > Similarly for the I/O window; we can't tell whether the base/limit are
> > read-only zero or writable.
> 
> PCI_IO_BASE and PCI_IO_LIMIT are also writable.
> 
> > 
> > So we have these windows that look like they're probably enabled:
> > 
> >   io window   at [io  0x0000-0x0fff]
> >   mem window  at [mem 0x00000000-0x000fffff]
> >   pref window at [mem 0x00000000-0x000fffff pref]
> > 
> > No idea whether it makes a difference, but these windows seem
> > misconfigured.  The default should probably be to make them all
> > disabled (as in f73eedc90bf7 ("PCI: vmd: Disable bridge window for
> > domain reset")):
> > 
> >   PCI_IO_BASE            = 0xf0
> >   PCI_IO_LIMIT           = 0x00
> >   PCI_MEMORY_BASE        = 0xfff0
> >   PCI_MEMORY_LIMIT       = 0x0000
> >   PCI_PREF_MEMORY_BASE   = 0xfff0
> >   PCI_PREF_MEMORY_LIMIT  = 0x0000
> >   PCI_PREF_BASE_UPPER32  = 0xffffffff
> >   PCI_PREF_LIMIT_UPPER32 = 0x00000000
> > 
> > The PCI core should reconfigure and enable them as needed by
> > downstream devices.
> > 
> >> I also noticed that the value of desc->pci.msix_ctrl obtained from
> >> the readl is always 0xffffffff irrespective of whether or not an
> >> endpoint device is connected. This isn't expected right? The only
> >> difference between the cases where endpoint device is connected and
> >> isn't connected is the completion timeout.
> > 
> > Right, I wouldn't expect that.  PCI_MSIX_ENTRY_VECTOR_CTRL has a bunch
> > of reserved bits that should be zero.
> > 
> > I assume MSI-X actually does work for downstream endpoints?  I
> > wouldn't think anybody would have bothered with
> > ks_pcie_v3_65_add_bus() unless MSI-X works.
> 
> Yes, I think it is supposed to work, but it doesn't seem to be working right now
> considering that even with Endpoint device connected, the readl() returns all Fs.

Could you please have look at what DW PCIe IP-core version is utilized
in the Keystone PCIe host controller? If it's of v5.x then here is
what HW databook says about the BARs initialization: "If you do use a
BAR, then you should program it to capture TLPs that are targeted to
your local non-application memory space residing on TRGT1, and not for
the application on TRGT0 (dbi). The BAR range must be outside of the
three Base/Limit regions."

I have no idea whether the BAR being set with an address within the
Base/Limit regions could have caused the lags you see, but I would
have at least checked that.

-Serge(y)

> 
> -- 
> Regards,
> Siddharth.
