Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081645EDA34
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 12:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbiI1Kgi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 06:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbiI1Kgb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 06:36:31 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C8F7E008;
        Wed, 28 Sep 2022 03:36:29 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id d42so19805580lfv.0;
        Wed, 28 Sep 2022 03:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=yD6aOc+5KLkkygqlqGBtUHVHnYRTIWJmV02q/QTISFg=;
        b=qe4gMcotqEESQDZWtQZnEojV1RS1UPe+/OaticUsLT0mots0tHQGHDPoWl1w6sT3k2
         Ca7UAOSAC+yMs/hSE02PBSaGcURZCVd+ifqcSyCqFQkzy6HJ5t9X9iIt4IutFgfKl572
         o7W984VY4Bt56RYnxHWFt9HnNWDcm4OgluAyd3a6NG9jKx8hqRgvUxN8rfn8NtB1g0ue
         ZU/6Hbhm7gLGHu1xZADlTH74E5DKi8yPLqVfiF37niBjkVpO8XJ5w8M5E2f4gdQmg58G
         kop/QQpeqi0Ti+BbkHVQJe3jzdUdL07X1Z3Pr3U2cpR480Fvkynq/mPke/fOAoDy/nAW
         JnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=yD6aOc+5KLkkygqlqGBtUHVHnYRTIWJmV02q/QTISFg=;
        b=qVjNC6c+a0MGsH1cWwvXpsXVNTeNA/qZQb8kRyZ9yuImgH++cuaA70tfkfIyTW7uVd
         RKSgQN0MFOXnhqCZKaNqTDEXN/nXnrI0Z0kqqkVG1DrgumeM/bzrIQ6NW1sxmhR2q60b
         nNXbdTkmHSbjX5qatmLHJoRf2QDmNUV899xcbiMoCGv0xhzZCak88WFTdmZXMhzIF018
         7GSPbLMIKGDVPW67E32twbKpHz5SJqrKCttVP93eRAwr/Qtzef+OCr+VOsDJ+RxEPVR0
         D4djq805dVmrwFxwAwKScqbwYuEgmJbsgIwir8M/N9W7mqeO/wGwsCuF7IzcUFZJ+J8x
         umhA==
X-Gm-Message-State: ACrzQf1YSq/lpj0Ixzb3jBT5Q7PW1FX5IBeo7gBhT2/I2ENp+DFuxbPI
        CesPl+GXsHrYI804jmMlszM=
X-Google-Smtp-Source: AMsMyM7BJOc1PmdVQSelcwsSvGBAMoB4mbBC7kuey3Hyca7DLMtWciPag/uklBT/TrAY7P2FE5/y/Q==
X-Received: by 2002:a19:6b01:0:b0:499:b6fb:fcf2 with SMTP id d1-20020a196b01000000b00499b6fbfcf2mr11847397lfa.622.1664361387925;
        Wed, 28 Sep 2022 03:36:27 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id m8-20020a056512358800b004947f8b6266sm437436lfr.203.2022.09.28.03.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 03:36:26 -0700 (PDT)
Date:   Wed, 28 Sep 2022 13:36:24 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     William McVicker <willmcvicker@google.com>
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
Message-ID: <20220928103624.gjhfaewpihhhscpd@mobilestation>
References: <20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru>
 <20220822184701.25246-21-Sergey.Semin@baikalelectronics.ru>
 <YwzbARMkb/69+l2d@lpieralisi>
 <20220912000211.ct6asuhhmnatje5e@mobilestation>
 <YzF8N/jzkWsjcgdD@lpieralisi>
 <20220926124924.4vodhncnuaorrlwj@mobilestation>
 <20220926143127.GB19031@lst.de>
 <20220926205333.qlhb5ojmx4sktzt5@mobilestation>
 <YzIw4pO03s3wO0tw@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIw4pO03s3wO0tw@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 26, 2022 at 11:08:18PM +0000, William McVicker wrote:
> On 09/26/2022, Serge Semin wrote:
> > On Mon, Sep 26, 2022 at 04:31:28PM +0200, Christoph Hellwig wrote:
> > > On Mon, Sep 26, 2022 at 03:49:24PM +0300, Serge Semin wrote:
> > > > @Christoph, @Marek, @Bjorn, @Rob could you please join to the
> > > > DMA-mask related discussion. @Lorenzo can't decide which driver should
> > > > initialize the device DMA-mask.
> > > 
> > 
> > > The driver that does the actual DMA mapping or allocation functions
> > > need to set it.  But even with your comments on the questions I'm
> > > still confused what struct device you are even talking about.  Can
> > > you explain this a bit better?
> > 
> > We are talking about the DW PCIe Root Port controller with DW eDMA engine
> > embedded. It' simplified structure can be represented as follows:
> > 
> >          +---------------+     +--------+
> >          | System memory |     | CPU(s) |
> >          +---------------+     +--------+
> >                 ^  |              |  ^
> >                 | ... System bus ... |
> >                ... |              | ...
> >                 |  v              v  |
> >  +------------+------+--------+----------+------+
> >  | DW PCIe RP | AXI-m|        | AXI-s/DBI|      |
> >  |            +------+        +----------+      |
> >  |                ^              ^     |        |
> >  |         +------+----+         |    CSRs      |
> >  |         v           v         v              |
> >  |     +-------+  +---------+ +----------+      |
> >  |     | eDMA  |  | in-iATU | | out-iATU |      |
> >  |     +-------+  +---------+ +----------+      |
> >  |         ^           ^           ^            |
> >  |         +--------+--+---+-------+            |
> >  +------------------| PIPE |--------------------+
> >                     +------+
> >                       | ^
> >                       v |
> >                    PCIe bus
> > 
> > The DW PCIe controller device is instantiated as a platform device
> > defined in the system DT source file. The device is probed by the
> > DW PCIe low-level driver, which after the platform-specific setups
> > initiates the generic DW PCIe host-controller registration. On the way
> > of that procedure the DW PCIe core tries to auto-detect the DW eDMA
> > engine availability. If the engine is found, the DW eDMA probe method
> > is called in order to register the DMA-engine device. After that the
> > PCIe host bridge is registered. Both the PCIe host-bridge and
> > DMA-engine devices will have the DW PCIe platform device as parent.
> > 
> > Getting back to the sketch above. Here is a short description of the
> > content:
> > 1. DW eDMA is capable of performing the data transfers from/to System
> > memory to/from PCIe bus memory.
> > 2. in-iATU is the Inbound Address Translation Unit, which is
> > responsible for the PCIe bus peripheral devices to access the system
> > memory. The "dma-ranges" DT-property is used to initialize the
> > PCIe<->Sys memory mapping. (@William note the In-iATU setup doesn't
> > affect the eDMA transfers.)
> > 3. out-iATU is responsible for the CPU(s) to access the PCIe bus
> > peripheral devices memory/cfg-space.
> > 
> > So eDMA and in-iATU are using the same AXI-master interface to access
> > the system memory. Thus the DMAable memory capability is the same for
> > both of them (Though in-iATU may have some specific mapping based on
> > the "dma-ranges" DT-property setup). Neither DW eDMA nor DW PCIe Root
> > Port CSRs region have any register to auto-detect the AXI-m interface
> > address bus width. It's selected during the IP-core synthesize and is
> > platform-specific. The question is: "What driver/code is supposed to
> > set the DMA-mask of the DW PCIe platform device?" Seeing the parental
> > platform device is used to perform the memory-mapping for both DW eDMA
> > clients and PCIe-bus peripheral device drivers, and seeing the AXI-m
> > interface parameters aren't auto-detectable and are platform-specific,
> > the only place it should be done in is the DW PCIe low-level device
> > driver. I don't really see any alternative... What is your opinion?
> > 
> > -Sergey
> 

> I believe this eDMA implementation is new for an upstream DW PCIe device
> driver, right? If so, this will require some refactoring of the DMA mask code,
> but you need to also make sure you don't break the MSI target address use case
> that prompted this 32-bit DMA mask change -- [1].

As far as I can see the commit
https://lore.kernel.org/all/20201117165312.25847-1-vidyas@nvidia.com/
isn't marked as fixes or whatever. If so it gets to be pointless due to this
https://elixir.bootlin.com/linux/latest/source/drivers/of/platform.c#L183
and this
https://elixir.bootlin.com/linux/latest/source/drivers/base/platform.c#L529
and seeing none of the DW PCIe RP/EP platform drivers change the
device DMA-mask of the being probed platform device. So the mask must
have been of 32-bits anyway even without that commit.

Moreover as Rob already told you here
https://lore.kernel.org/all/CAL_JsqJh=d-B51b6yPBRq0tOwbChN=AFPr-a19U1QdQZAE7c1A@mail.gmail.com/
and I mentioned in my response here
https://lore.kernel.org/linux-pci/20220912000211.ct6asuhhmnatje5e@mobilestation/
DW PCie MSI TLPs never reach the system memory. The TLP PCIe-bus target
address is checked in the host bridge. If it matches to the one
initialized in the iMSI-RX engine CSRs the MSI IRQ will be raised.
None system memory IO will be actually performed. Thus changing the
device DMA-capability due to something which actually doesn't cause
any DMA at the very least inappropriate.

The last but not least changing the DMA-mask in the common code which
isn't aware of the device/platform capability is also at the very least
inappropriate.

> My changes were directly
> related to allowing the DW PCIe device driver to fallback to a 64-bit DMA mask
> for the MSI target address if there are no 32-bit allocations available. For
> that use-case, using a 32-bit mask doesn't have any perf impact here since
> there is no actual DMAs happening.

Regarding your changes. I'll give you my comments in that thread, but
here is a short summary. One more time. There is no actually DMA
performed on MSI due to the way the iMSI-RX works. So setting the
device DMA-mask based on that is inappropriate. Secondly the coherent
memory might be very expensive on some platforms
(see Documentation/core-api/dma-api.rst). And it's on MIPS32 for
instance. Thus using dma_alloc_coherent()
for something other than for real DMA is also inappropriate. What
should have been done instead:
1. Drop any dma_set_mask*() invocations.
1. Preserve the alloc_page() method usage.
2. Pass GFP_DMA32 to the alloc_page() function only if
PCI_MSI_FLAGS_64BIT is set.

The suggestion above is the best choice seeing we can't reserve some
part of the PCI-bus memory without allocating the real system memory
behind as @Robin noted here in the last paragraph:
https://lore.kernel.org/linux-pci/1e63a581-14ae-b4b5-a5bf-ca8f09c33af6@arm.com/

-Sergey

> 
> Would it be possible for the DW PCIe device driver to set a capabilities flag
> that the PCIe host controller can read and set the mask accordingly. This way
> you don't need to go fix up any drivers that require a 32-bit DMA'able address
> for the MSI target address. For example, I see several of the PCI capability
> features have 64-bit flags, e.g. PCI_MSI_FLAGS_64BIT and PCI_X_STATUS_64BIT. If
> not, then you're going to have to re-work the host controller driver and DW
> PCIe device drivers that require a 32-bit MSI target address.
> 
> [1] https://lore.kernel.org/all/20201117165312.25847-1-vidyas@nvidia.com/
> 
> Thanks,
> Will
> 
