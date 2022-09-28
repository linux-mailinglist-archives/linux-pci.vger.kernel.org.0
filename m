Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2025EE3B8
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 19:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbiI1R73 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 13:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbiI1R7N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 13:59:13 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139291003A5
        for <linux-pci@vger.kernel.org>; Wed, 28 Sep 2022 10:59:08 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q9so12877858pgq.8
        for <linux-pci@vger.kernel.org>; Wed, 28 Sep 2022 10:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=9qZYwREuuJYY5yd2Irf+/+tpgSOwGSBaTZMhbCSXO0Q=;
        b=DYk5gd+wqGWOoAPoxaxUg3ubtAPJ7dT+/jHyT8gXbyw8rRF5+z1SXG/UkiWl5GLCIn
         k35ECh9LtucpMG6zF0IJyD5mL0Or9R1yXto+cKkEIUrl7E+O5IcMP/LFXpXfSZszJBbl
         6pBbc9nGfDE4/hEM81NOvvyKHHrry/iE5ZVWnPpnxcT/tkH3YkrwVl8i4sWM3qzZV50I
         AIpw673EdmmJcBNKt23NAsC3mp/cAjFeDdUX9oZrwDtxsVBb5uHXl41IZXQGIQDW4LYF
         qDsXqVfB0w8nORaKDMxqY1P44zZFvZ8+nBXaQ7NcuhMpRFLTBxicQRJS/ZgFAejEyZW/
         Ap1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=9qZYwREuuJYY5yd2Irf+/+tpgSOwGSBaTZMhbCSXO0Q=;
        b=I7wR+nH4HIZC8dg61Bp47bLBcRP2J7zdH2K9HQpHxtxdbj7Y61nuA7NcVnnw6znHD8
         F+7Ri9P5tMUwtJeS8oCXnGeeXEW/SJ+NknV07B1OiVmA6hIKuUH8eNt6z5wsjtRbA/Qd
         ibqVEpcXBbQirJn0Ml+5f98A/OmoVkPkY7a7xRPO1vTAU8u5xiaSlGOR+tOEsVH+yehZ
         pmrgtJThMPhkE460qKCEfQaVQ2kWLXzK20PpcYhs7ZBnaq1gad1gkNEo1K0yPIhIDI7S
         U8Mfbj1Qaswl4pzDNTXV7zwFzGxaKeM1MU8pcUcBFomLL/k1BkxlBw9RhpMdxnj1ymR8
         Q7xw==
X-Gm-Message-State: ACrzQf2FjnDuxkH/JhWdRGaJtB2SshEQ9C6fQ87ch/5A/oyiqI0U0qEv
        /aSvQ92Pq6FFMP/llBbaymb++w==
X-Google-Smtp-Source: AMsMyM40b8HV6k7mHKysQYhUbVnlADFZ4NRKNdyowcBSo/Y4u26K1/Drz7DzvOTXoLbj2VuFnWTKEw==
X-Received: by 2002:a05:6a00:16d6:b0:53b:3e58:1c6f with SMTP id l22-20020a056a0016d600b0053b3e581c6fmr36222799pfc.7.1664387946812;
        Wed, 28 Sep 2022 10:59:06 -0700 (PDT)
Received: from google.com (201.215.168.34.bc.googleusercontent.com. [34.168.215.201])
        by smtp.gmail.com with ESMTPSA id r33-20020a634421000000b0043c75884c19sm3932958pga.3.2022.09.28.10.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 10:59:06 -0700 (PDT)
Date:   Wed, 28 Sep 2022 17:59:02 +0000
From:   William McVicker <willmcvicker@google.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 20/20] PCI: dwc: Add Baikal-T1 PCIe controller support
Message-ID: <YzSLZp0bH4B9VG4A@google.com>
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
 <20220822184701.25246-21-Sergey.Semin@baikalelectronics.ru>
 <YwzbARMkb/69+l2d@lpieralisi>
 <20220912000211.ct6asuhhmnatje5e@mobilestation>
 <YzF8N/jzkWsjcgdD@lpieralisi>
 <20220926124924.4vodhncnuaorrlwj@mobilestation>
 <20220926143127.GB19031@lst.de>
 <20220926205333.qlhb5ojmx4sktzt5@mobilestation>
 <YzIw4pO03s3wO0tw@google.com>
 <20220928103624.gjhfaewpihhhscpd@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928103624.gjhfaewpihhhscpd@mobilestation>
X-Spam-Status: No, score=-15.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 09/28/2022, Serge Semin wrote:
> On Mon, Sep 26, 2022 at 11:08:18PM +0000, William McVicker wrote:
> > On 09/26/2022, Serge Semin wrote:
> > > On Mon, Sep 26, 2022 at 04:31:28PM +0200, Christoph Hellwig wrote:
> > > > On Mon, Sep 26, 2022 at 03:49:24PM +0300, Serge Semin wrote:
> > > > > @Christoph, @Marek, @Bjorn, @Rob could you please join to the
> > > > > DMA-mask related discussion. @Lorenzo can't decide which driver should
> > > > > initialize the device DMA-mask.
> > > > 
> > > 
> > > > The driver that does the actual DMA mapping or allocation functions
> > > > need to set it.  But even with your comments on the questions I'm
> > > > still confused what struct device you are even talking about.  Can
> > > > you explain this a bit better?
> > > 
> > > We are talking about the DW PCIe Root Port controller with DW eDMA engine
> > > embedded. It' simplified structure can be represented as follows:
> > > 
> > >          +---------------+     +--------+
> > >          | System memory |     | CPU(s) |
> > >          +---------------+     +--------+
> > >                 ^  |              |  ^
> > >                 | ... System bus ... |
> > >                ... |              | ...
> > >                 |  v              v  |
> > >  +------------+------+--------+----------+------+
> > >  | DW PCIe RP | AXI-m|        | AXI-s/DBI|      |
> > >  |            +------+        +----------+      |
> > >  |                ^              ^     |        |
> > >  |         +------+----+         |    CSRs      |
> > >  |         v           v         v              |
> > >  |     +-------+  +---------+ +----------+      |
> > >  |     | eDMA  |  | in-iATU | | out-iATU |      |
> > >  |     +-------+  +---------+ +----------+      |
> > >  |         ^           ^           ^            |
> > >  |         +--------+--+---+-------+            |
> > >  +------------------| PIPE |--------------------+
> > >                     +------+
> > >                       | ^
> > >                       v |
> > >                    PCIe bus
> > > 
> > > The DW PCIe controller device is instantiated as a platform device
> > > defined in the system DT source file. The device is probed by the
> > > DW PCIe low-level driver, which after the platform-specific setups
> > > initiates the generic DW PCIe host-controller registration. On the way
> > > of that procedure the DW PCIe core tries to auto-detect the DW eDMA
> > > engine availability. If the engine is found, the DW eDMA probe method
> > > is called in order to register the DMA-engine device. After that the
> > > PCIe host bridge is registered. Both the PCIe host-bridge and
> > > DMA-engine devices will have the DW PCIe platform device as parent.
> > > 
> > > Getting back to the sketch above. Here is a short description of the
> > > content:
> > > 1. DW eDMA is capable of performing the data transfers from/to System
> > > memory to/from PCIe bus memory.
> > > 2. in-iATU is the Inbound Address Translation Unit, which is
> > > responsible for the PCIe bus peripheral devices to access the system
> > > memory. The "dma-ranges" DT-property is used to initialize the
> > > PCIe<->Sys memory mapping. (@William note the In-iATU setup doesn't
> > > affect the eDMA transfers.)
> > > 3. out-iATU is responsible for the CPU(s) to access the PCIe bus
> > > peripheral devices memory/cfg-space.
> > > 
> > > So eDMA and in-iATU are using the same AXI-master interface to access
> > > the system memory. Thus the DMAable memory capability is the same for
> > > both of them (Though in-iATU may have some specific mapping based on
> > > the "dma-ranges" DT-property setup). Neither DW eDMA nor DW PCIe Root
> > > Port CSRs region have any register to auto-detect the AXI-m interface
> > > address bus width. It's selected during the IP-core synthesize and is
> > > platform-specific. The question is: "What driver/code is supposed to
> > > set the DMA-mask of the DW PCIe platform device?" Seeing the parental
> > > platform device is used to perform the memory-mapping for both DW eDMA
> > > clients and PCIe-bus peripheral device drivers, and seeing the AXI-m
> > > interface parameters aren't auto-detectable and are platform-specific,
> > > the only place it should be done in is the DW PCIe low-level device
> > > driver. I don't really see any alternative... What is your opinion?
> > > 
> > > -Sergey
> > 
> 
> > I believe this eDMA implementation is new for an upstream DW PCIe device
> > driver, right? If so, this will require some refactoring of the DMA mask code,
> > but you need to also make sure you don't break the MSI target address use case
> > that prompted this 32-bit DMA mask change -- [1].
> 
> As far as I can see the commit
> https://lore.kernel.org/all/20201117165312.25847-1-vidyas@nvidia.com/
> isn't marked as fixes or whatever. If so it gets to be pointless due to this
> https://elixir.bootlin.com/linux/latest/source/drivers/of/platform.c#L183
> and this
> https://elixir.bootlin.com/linux/latest/source/drivers/base/platform.c#L529
> and seeing none of the DW PCIe RP/EP platform drivers change the
> device DMA-mask of the being probed platform device. So the mask must
> have been of 32-bits anyway even without that commit.
> 
> Moreover as Rob already told you here
> https://lore.kernel.org/all/CAL_JsqJh=d-B51b6yPBRq0tOwbChN=AFPr-a19U1QdQZAE7c1A@mail.gmail.com/
> and I mentioned in my response here
> https://lore.kernel.org/linux-pci/20220912000211.ct6asuhhmnatje5e@mobilestation/
> DW PCie MSI TLPs never reach the system memory. The TLP PCIe-bus target
> address is checked in the host bridge. If it matches to the one
> initialized in the iMSI-RX engine CSRs the MSI IRQ will be raised.
> None system memory IO will be actually performed. Thus changing the
> device DMA-capability due to something which actually doesn't cause
> any DMA at the very least inappropriate.

Thanks for pointing out the DMA mask references during platform device
allocation. I wasn't aware of that. However, I still have issues with using
ZONE_DMA32. See comments on how we can address this here:
https://lore.kernel.org/linux-pci/YzSJ2ioEeRhHC6zn@google.com/

> 
> The last but not least changing the DMA-mask in the common code which
> isn't aware of the device/platform capability is also at the very least
> inappropriate.
> 
> > My changes were directly
> > related to allowing the DW PCIe device driver to fallback to a 64-bit DMA mask
> > for the MSI target address if there are no 32-bit allocations available. For
> > that use-case, using a 32-bit mask doesn't have any perf impact here since
> > there is no actual DMAs happening.
> 
> Regarding your changes. I'll give you my comments in that thread, but
> here is a short summary. One more time. There is no actually DMA
> performed on MSI due to the way the iMSI-RX works. So setting the
> device DMA-mask based on that is inappropriate. Secondly the coherent
> memory might be very expensive on some platforms
> (see Documentation/core-api/dma-api.rst). And it's on MIPS32 for
> instance. Thus using dma_alloc_coherent()
> for something other than for real DMA is also inappropriate. What
> should have been done instead:
> 1. Drop any dma_set_mask*() invocations.

I'm fine with this, but others will need to approve of that.

> 1. Preserve the alloc_page() method usage.
> 2. Pass GFP_DMA32 to the alloc_page() function only if
> PCI_MSI_FLAGS_64BIT is set.
> 
> The suggestion above is the best choice seeing we can't reserve some
> part of the PCI-bus memory without allocating the real system memory
> behind as @Robin noted here in the last paragraph:
> https://lore.kernel.org/linux-pci/1e63a581-14ae-b4b5-a5bf-ca8f09c33af6@arm.com/

I'm not okay with this as it re-introduces the dependency on ZONE_DMA32.
I responded with more details here with regards to why and how we can work
around the ARCH issues with dma_alloc_coherent():
https://lore.kernel.org/linux-pci/YzSJ2ioEeRhHC6zn@google.com/

Thanks,
Will

> 
> -Sergey
> 
> > 
> > Would it be possible for the DW PCIe device driver to set a capabilities flag
> > that the PCIe host controller can read and set the mask accordingly. This way
> > you don't need to go fix up any drivers that require a 32-bit DMA'able address
> > for the MSI target address. For example, I see several of the PCI capability
> > features have 64-bit flags, e.g. PCI_MSI_FLAGS_64BIT and PCI_X_STATUS_64BIT. If
> > not, then you're going to have to re-work the host controller driver and DW
> > PCIe device drivers that require a 32-bit MSI target address.
> > 
> > [1] https://lore.kernel.org/all/20201117165312.25847-1-vidyas@nvidia.com/
> > 
> > Thanks,
> > Will
> > 
